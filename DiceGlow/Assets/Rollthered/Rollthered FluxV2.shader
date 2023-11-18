// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / FluxV2"
{
	Properties
	{
		_HDRClamp("HDR Clamp", Range( 0.6 , 2)) = 1
		_Hue("Hue", Range( 0 , 1)) = 0.056
		_Colorize("Colorize", Range( 0 , 1)) = 0.8
		_Brightness("Brightness", Range( 0 , 1)) = 1
		_Desaturate("Desaturate", Range( 0 , 1)) = 0
		_Length("Length", Float) = 0.02
		_Offset("Offset", Float) = 0.3
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+9999" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest Always
		GrabPass{ "_GrabAss" }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float customSurfaceDepth25;
		};

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabAss )
		uniform float _Brightness;
		uniform float _Hue;
		uniform float _HDRClamp;
		uniform float _Colorize;
		uniform float _Desaturate;
		uniform float _Length;
		uniform float _Offset;


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

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float3 temp_cast_0 = (ase_grabScreenPos.b).xxx;
			float3 customSurfaceDepth25 = temp_cast_0;
			o.customSurfaceDepth25 = -UnityObjectToViewPos( customSurfaceDepth25 ).z;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor1 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabAss,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 color6 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			float3 hsvTorgb9 = RGBToHSV( color6.rgb );
			float3 hsvTorgb8 = HSVToRGB( float3(_Hue,hsvTorgb9.y,hsvTorgb9.z) );
			float4 temp_cast_2 = (0.0).xxxx;
			float4 temp_cast_3 = (_HDRClamp).xxxx;
			float4 clampResult2 = clamp( screenColor1 , temp_cast_2 , temp_cast_3 );
			float4 lerpResult15 = lerp( ( float4( hsvTorgb8 , 0.0 ) * clampResult2 ) , clampResult2 , _Colorize);
			float3 desaturateInitialColor23 = ( _Brightness * lerpResult15 ).rgb;
			float desaturateDot23 = dot( desaturateInitialColor23, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar23 = lerp( desaturateInitialColor23, desaturateDot23.xxx, _Desaturate );
			float cameraDepthFade25 = (( i.customSurfaceDepth25 -_ProjectionParams.y - _Offset ) / _Length);
			float4 lerpResult35 = lerp( screenColor1 , float4( desaturateVar23 , 0.0 ) , saturate( ( 1.0 - cameraDepthFade25 ) ));
			o.Emission = lerpResult35.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18912
835;73;1084;926;-384.9258;138.9606;1;True;False
Node;AmplifyShaderEditor.ColorNode;6;-731.2294,-562.3174;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;1;-1144.23,-259.6207;Inherit;False;Global;_GrabAss;GrabAss;0;0;Create;True;0;0;0;False;0;False;Object;-1;True;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-501.2417,-774.1041;Inherit;False;Property;_Hue;Hue;2;0;Create;True;0;0;0;False;0;False;0.056;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;9;-462.9058,-552.128;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;4;-1139.23,-43.62078;Inherit;False;Constant;_Min;Min;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1136.23,42.3792;Inherit;False;Property;_HDRClamp;HDR Clamp;0;0;Create;True;0;0;0;False;0;False;1;0;0.6;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;8;-209.1616,-703.7839;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;2;-832.2308,-135.6207;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;29;530.0983,972.1927;Inherit;False;Property;_Length;Length;6;0;Create;True;0;0;0;False;0;False;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;575.7068,1044.318;Inherit;False;Property;_Offset;Offset;7;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-162.4212,-40.924;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-313.2583,331.2391;Inherit;False;Property;_Colorize;Colorize;3;0;Create;True;0;0;0;False;0;False;0.8;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;26;506.9643,797.0585;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;15;-94.80626,180.1865;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CameraDepthFade;25;759.7303,886.3792;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;0.14;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;304.4147,-91.37036;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;1011.429,917.7072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;451.2168,41.84075;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;24;607.0766,200.1037;Inherit;False;Property;_Desaturate;Desaturate;5;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;23;870.5382,76.68666;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;34;1100.818,599.1768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StickyNoteNode;20;-356.4673,-87.5302;Inherit;False;511.6472;568.0272;Mix color from hue and screen color;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.LerpOp;35;974.829,199.1664;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;28;482.4991,755.5393;Inherit;False;714.106;390.9967;Lazy Mirror Depth Check;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.StickyNoteNode;21;271.9601,-150.7422;Inherit;False;351.4387;343.4359;Multiply with float for brightness control;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.StickyNoteNode;18;-759.8514,-835.2126;Inherit;False;793.8188;451.0745;Filter out Hue from HSV;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.StickyNoteNode;19;-1180.739,-299.0478;Inherit;False;793.8188;451.0745;Grab screen color for filtering high dynamic range values;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1134.033,32.15224;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / FluxV2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;9999;True;Overlay;;Overlay;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;6;0
WireConnection;8;0;12;0
WireConnection;8;1;9;2
WireConnection;8;2;9;3
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;2;2;3;0
WireConnection;5;0;8;0
WireConnection;5;1;2;0
WireConnection;15;0;5;0
WireConnection;15;1;2;0
WireConnection;15;2;16;0
WireConnection;25;2;26;3
WireConnection;25;0;29;0
WireConnection;25;1;30;0
WireConnection;27;0;25;0
WireConnection;17;0;22;0
WireConnection;17;1;15;0
WireConnection;23;0;17;0
WireConnection;23;1;24;0
WireConnection;34;0;27;0
WireConnection;35;0;1;0
WireConnection;35;1;23;0
WireConnection;35;2;34;0
WireConnection;0;2;35;0
ASEEND*/
//CHKSM=62D8B15BD88AD588B01F07F2FF0A868B9E1BB443