// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / DataBend"
{
	Properties
	{
		[Toggle]_Spectrogram("Spectrogram?", Float) = 0
		_CrazinessSlider("CrazinessSlider", Range( 0 , 300)) = 0
		_Mix("Mix", Range( 0 , 1)) = 1
		_Contrast("Contrast", Range( 0 , 100)) = 3
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+2000" "IsEmissive" = "true"  }
		Cull Off
		GrabPass{ "_GrabAss" }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float eyeDepth;
		};

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabAss )
		uniform float _Spectrogram;
		uniform float _CrazinessSlider;
		uniform float _Contrast;
		uniform float _Mix;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor1 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabAss,ase_grabScreenPosNorm.xy/ase_grabScreenPosNorm.w);
			float4 temp_cast_0 = (screenColor1.g).xxxx;
			float div8=256.0/float(120);
			float4 posterize8 = ( floor( CalculateContrast(_Contrast,temp_cast_0) * div8 ) / div8 );
			float simplePerlin2D10 = snoise( ( ( ase_grabScreenPosNorm.r * posterize8 ) * _Time.w ).rg*9000.0 );
			simplePerlin2D10 = simplePerlin2D10*0.5 + 0.5;
			float4 temp_cast_2 = (simplePerlin2D10).xxxx;
			float4 lerpResult12 = lerp( screenColor1 , temp_cast_2 , posterize8);
			float3 hsvTorgb15 = RGBToHSV( lerpResult12.rgb );
			float3 clampResult23 = clamp( saturate( ( 1.0 - hsvTorgb15 ) ) , float3( 0.01,0.01,0.01 ) , float3( 0.7,0.7,0.7 ) );
			float3 hsvTorgb29 = RGBToHSV( clampResult23 );
			float3 hsvTorgb30 = HSVToRGB( float3(( _CrazinessSlider * clampResult23 ).x,hsvTorgb29.y,hsvTorgb29.z) );
			float3 hsvTorgb25 = RGBToHSV( clampResult23 );
			float3 hsvTorgb26 = HSVToRGB( float3(hsvTorgb25.x,1.0,hsvTorgb25.z) );
			float4 lerpResult33 = lerp( screenColor1 , float4( (( _Spectrogram )?( hsvTorgb26 ):( hsvTorgb30 )) , 0.0 ) , _Mix);
			float cameraDepthFade49 = (( i.eyeDepth -_ProjectionParams.y - 0.23 ) / 0.23);
			float4 clampResult48 = clamp( ( lerpResult33 * saturate( ( 1.0 - cameraDepthFade49 ) ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Emission = clampResult48.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18912
1012;73;907;926;1330.127;484.0017;1.534372;True;False
Node;AmplifyShaderEditor.GrabScreenPosition;9;-1318.626,-191.1702;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;-981.3733,483.4682;Inherit;False;Property;_Contrast;Contrast;4;0;Create;True;0;0;0;False;0;False;3;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;1;-1078.685,262.4924;Inherit;False;Global;_GrabAss;GrabAss;0;0;Create;True;0;0;0;False;0;False;Object;-1;True;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;13;-844.6271,374.7518;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0.16;False;1;COLOR;0
Node;AmplifyShaderEditor.PosterizeNode;8;-497.9655,423.7213;Inherit;False;120;2;1;COLOR;0,0,0,0;False;0;INT;120;False;1;COLOR;0
Node;AmplifyShaderEditor.TimeNode;22;-811.2804,-250.3677;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-585.8785,148.1768;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-559.2574,-259.9991;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;10;-395.9591,-371.4423;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;9000;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;12;-243.3373,-161.1631;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RGBToHSVNode;15;-204.4994,178.2316;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;19;-19.21522,-18.3299;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;14;7.394165,-199.0002;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;23;218.1044,-153.1207;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.01,0.01,0.01;False;2;FLOAT3;0.7,0.7,0.7;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;351.1351,-265.1351;Inherit;False;Property;_CrazinessSlider;CrazinessSlider;2;0;Create;True;0;0;0;False;0;False;0;0;0;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;25;294.041,-574.8829;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;27;459.6292,-686.3962;Inherit;False;Constant;_hue;hue;1;0;Create;True;0;0;0;False;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;29;346.8165,97.35382;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;630.7153,-102.7747;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;30;756.9033,103.5207;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CameraDepthFade;49;993.897,873.3384;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;0.23;False;1;FLOAT;0.23;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;26;704.1277,-568.716;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;34;324.7971,517.4447;Inherit;False;Property;_Mix;Mix;3;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;28;846.0005,-67.48125;Inherit;False;Property;_Spectrogram;Spectrogram?;1;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;50;1046.051,773.1695;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;51;1058.555,579.2745;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;33;685.5792,403.1202;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1044.056,386.2829;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;48;1232.602,232.7009;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1175.073,-322.7042;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / DataBend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;2000;True;Overlay;;Overlay;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;0;9;0
WireConnection;13;1;1;2
WireConnection;13;0;56;0
WireConnection;8;1;13;0
WireConnection;11;0;9;1
WireConnection;11;1;8;0
WireConnection;20;0;11;0
WireConnection;20;1;22;4
WireConnection;10;0;20;0
WireConnection;12;0;1;0
WireConnection;12;1;10;0
WireConnection;12;2;8;0
WireConnection;15;0;12;0
WireConnection;19;0;15;0
WireConnection;14;0;19;0
WireConnection;23;0;14;0
WireConnection;25;0;23;0
WireConnection;29;0;23;0
WireConnection;31;0;32;0
WireConnection;31;1;23;0
WireConnection;30;0;31;0
WireConnection;30;1;29;2
WireConnection;30;2;29;3
WireConnection;26;0;25;1
WireConnection;26;1;27;0
WireConnection;26;2;25;3
WireConnection;28;0;30;0
WireConnection;28;1;26;0
WireConnection;50;0;49;0
WireConnection;51;0;50;0
WireConnection;33;0;1;0
WireConnection;33;1;28;0
WireConnection;33;2;34;0
WireConnection;52;0;33;0
WireConnection;52;1;51;0
WireConnection;48;0;52;0
WireConnection;0;2;48;0
ASEEND*/
//CHKSM=82C5DFC04C5E60E0D047825FB651C5395CF6FEDF