// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / VHS"
{
	Properties
	{
		_BleedIntensity("BleedIntensity", Float) = 2
		_BleedScale("BleedScale", Range( -0.01 , 0.01)) = -0.003
		_NoiseGenerator("NoiseGenerator", Float) = 0.4
		_NoiseScale("NoiseScale", Float) = 200
		_AspectRatio("AspectRatio", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_DitheringIntensity("DitheringIntensity", Range( 0 , 1)) = 0.9
		_ColorDepth("ColorDepth", Range( 0 , 100)) = 0
		_FlickerGradient("FlickerGradient", 2D) = "black" {}
		_CRT("CRT", 2D) = "white" {}
		_CRTAmount("CRTAmount", Range( 0 , 1)) = 0
		_CRTScale("CRTScale", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Transparent+80000" "IsEmissive" = "true"  }
		Cull Off
		ZTest Always
		GrabPass{ "_GrabAss" }
		GrabPass{ "_GrabScreen0" }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPosition;
			float eyeDepth;
			float3 worldPos;
		};

		uniform float4 _Tint;
		uniform sampler2D _AspectRatio;
		uniform sampler2D _FlickerGradient;
		uniform float _ColorDepth;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabAss )
		uniform float _BleedIntensity;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabScreen0 )
		uniform float _BleedScale;
		uniform float _NoiseScale;
		uniform float _NoiseGenerator;
		uniform float _DitheringIntensity;
		uniform sampler2D _CRT;
		uniform float _CRTScale;
		uniform float _CRTAmount;


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


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 clampResult71 = clamp( _Tint , float4( 0,0,0,0 ) , float4( 0.01,0.01,0.01,0 ) );
			float localUnity_RadialShear_float5_g2 = ( 0.0 );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 UV5_g2 = ase_grabScreenPosNorm.xy;
			float2 Center5_g2 = float2( 0.6,1.41 );
			float2 temp_cast_1 = (ase_grabScreenPosNorm.g).xx;
			float2 panner139 = ( 1.0 * _Time.y * float2( 1,0 ) + temp_cast_1);
			float simplePerlin2D133 = snoise( panner139*2500.0 );
			float2 panner126 = ( 1.0 * _Time.y * float2( 2,0 ) + float2( 0,0 ));
			float4 temp_cast_2 = (0.0015).xxxx;
			float4 clampResult129 = clamp( tex2D( _FlickerGradient, panner126 ) , float4( 0,0,0,0 ) , temp_cast_2 );
			float Strength5_g2 = ( ( simplePerlin2D133 * 0.001 ) + clampResult129 ).r;
			float2 Offset5_g2 = float2( 0,-0.02 );
			float2 Out5_g2 = float2( 0,0 );
			{
			float2 delta = UV5_g2 - Center5_g2;
			float delta2 = dot(delta.xy, delta.xy);
			float2 delta_offset = delta2 * Strength5_g2;
			Out5_g2 = UV5_g2 + float2(delta.y, -delta.x) * delta_offset + Offset5_g2;
			}
			float2 temp_output_110_0 = Out5_g2;
			float4 screenColor1 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabAss,temp_output_110_0);
			float div13=256.0/float((int)_ColorDepth);
			float4 posterize13 = ( floor( screenColor1 * div13 ) / div13 );
			float4 screenColor3 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabScreen0,( _BleedScale + temp_output_110_0 ));
			float3 desaturateInitialColor11 = ( screenColor1 - screenColor3 ).rgb;
			float desaturateDot11 = dot( desaturateInitialColor11, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar11 = lerp( desaturateInitialColor11, desaturateDot11.xxx, 1.0 );
			float simplePerlin3D15 = snoise( ( unity_DeltaTime.y + ase_grabScreenPosNorm ).xyz*_NoiseScale );
			simplePerlin3D15 = simplePerlin3D15*0.5 + 0.5;
			float4 temp_cast_8 = (simplePerlin3D15).xxxx;
			float4 lerpResult22 = lerp( ( posterize13 + float4( ( _BleedIntensity * desaturateVar11 ) , 0.0 ) ) , temp_cast_8 , _NoiseGenerator);
			float4 clampResult24 = clamp( lerpResult22 , float4( 0.007,0.007,0.007,0 ) , float4( 0.9811321,0.9811321,0.9811321,0 ) );
			float3 hsvTorgb41 = RGBToHSV( ( tex2D( _AspectRatio, temp_output_110_0 ) * clampResult24 ).rgb );
			float3 hsvTorgb42 = HSVToRGB( float3(hsvTorgb41.x,hsvTorgb41.y,hsvTorgb41.z) );
			float4 ditherCustomScreenPos64 = ( 1.0 * ase_grabScreenPosNorm );
			float2 clipScreen64 = ditherCustomScreenPos64.xy * _ScreenParams.xy;
			float dither64 = Dither4x4Bayer( fmod(clipScreen64.x, 4), fmod(clipScreen64.y, 4) );
			dither64 = step( dither64, hsvTorgb41.z );
			float3 temp_cast_10 = (dither64).xxx;
			float3 lerpResult77 = lerp( hsvTorgb42 , temp_cast_10 , _DitheringIntensity);
			float cameraDepthFade60 = (( i.eyeDepth -_ProjectionParams.y - 0.23 ) / 0.23);
			float3 clampResult48 = clamp( ( lerpResult77 * saturate( ( 1.0 - cameraDepthFade60 ) ) ) , float3( 0,0,0 ) , float3( 0.6,0.6,0.6 ) );
			float3 desaturateInitialColor131 = ( clampResult71 + float4( clampResult48 , 0.0 ) ).rgb;
			float desaturateDot131 = dot( desaturateInitialColor131, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar131 = lerp( desaturateInitialColor131, desaturateDot131.xxx, 0.25 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos3_g2 = UnityObjectToClipPos( ase_vertex3Pos );
			float4 computeScreenPos5_g2 = ComputeScreenPos( unityObjectToClipPos3_g2 );
			float temp_output_20_0_g2 = _CRTScale;
			float4 unityObjectToClipPos4_g2 = UnityObjectToClipPos( float3(0,0,0) );
			float4 computeScreenPos6_g2 = ComputeScreenPos( unityObjectToClipPos4_g2 );
			float4 temp_output_17_0_g2 = ( ( ( computeScreenPos5_g2 / (computeScreenPos5_g2).w ) * temp_output_20_0_g2 ) - ( temp_output_20_0_g2 * ( computeScreenPos6_g2 / (computeScreenPos6_g2).w ) ) );
			float4 lerpResult157 = lerp( float4( desaturateVar131 , 0.0 ) , ( tex2D( _CRT, (temp_output_17_0_g2).xy ) * float4( desaturateVar131 , 0.0 ) ) , _CRTAmount);
			o.Emission = lerpResult157.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18912
906;73;1013;926;-1254.035;2072.346;1.963394;False;False
Node;AmplifyShaderEditor.GrabScreenPosition;8;-472.0826,-1350.454;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;126;-2068.592,-520.1681;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;2,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;139;-1243.726,-1006.42;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;125;-1808.391,-593.1681;Inherit;True;Property;_FlickerGradient;FlickerGradient;9;0;Create;True;0;0;0;False;0;False;-1;None;0fd9fff4b0830664092ed414a361abf8;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;133;-1314.622,-753.3639;Inherit;False;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;2500;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-1218.226,-613.42;Inherit;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;0;False;0;False;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-1656.918,-324.1351;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0.0015;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;129;-1476.219,-433.3351;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.01,0.01,0.01,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-1039.226,-725.42;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;-919.0068,-672.3311;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1266.213,-265.0558;Inherit;False;Property;_BleedScale;BleedScale;2;0;Create;True;0;0;0;False;0;False;-0.003;0.0032;-0.01;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;110;-727.9421,-622.5781;Inherit;False;RadialShear;-1;;2;654cf399d6f97fe43ae727fc05c61800;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.6,1.41;False;3;FLOAT;0.02;False;4;FLOAT2;0,-0.02;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-887.3252,-205.3048;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;1;-674.9637,-235.3191;Inherit;False;Global;_GrabAss;GrabAss;0;0;Create;True;0;0;0;False;0;False;Object;-1;True;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;3;-685.3866,71.13579;Inherit;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;0;False;0;False;Object;-1;True;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-460.478,15.51805;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;11;-406.3171,217.7711;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-225.4555,78.75603;Inherit;False;Property;_BleedIntensity;BleedIntensity;0;0;Create;True;0;0;0;False;0;False;2;-1.96;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-371.696,-227.1077;Inherit;False;Property;_ColorDepth;ColorDepth;8;0;Create;True;0;0;0;False;0;False;0;4.7;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.DeltaTime;17;-437.8752,-794.9962;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-183.3496,-822.7322;Inherit;False;Property;_NoiseScale;NoiseScale;4;0;Create;True;0;0;0;False;0;False;200;128.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-228.1061,-635.43;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;40.47151,84.86957;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosterizeNode;13;-243.9049,-369.1978;Inherit;False;3;2;1;COLOR;0,0,0,0;False;0;INT;3;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;56.15358,-227.9865;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;15.9937,-530.83;Inherit;False;Property;_NoiseGenerator;NoiseGenerator;3;0;Create;True;0;0;0;False;0;False;0.4;0.015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;15;2.753326,-783.9773;Inherit;False;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;200;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;22;375.9937,-518.43;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;28;230.1093,-976.9542;Inherit;True;Property;_AspectRatio;AspectRatio;5;0;Create;True;0;0;0;False;0;False;-1;None;c019ba651a54fcb42b037ba8db605299;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;24;429.8904,-702.1492;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.007,0.007,0.007,0;False;2;COLOR;0.9811321,0.9811321,0.9811321,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;606.6703,-812.9679;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;476.1263,-130.4554;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;41;522.8209,-473.8067;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CameraDepthFade;60;1432.346,-270.2772;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;0.23;False;1;FLOAT;0.23;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;577.1263,49.54456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DitheringNode;64;801.9556,-66.15979;Inherit;False;0;True;4;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;3;SAMPLERSTATE;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;61;1484.5,-370.4463;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;847.2983,301.1392;Inherit;False;Property;_DitheringIntensity;DitheringIntensity;7;0;Create;True;0;0;0;False;0;False;0.9;0.027;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;42;892.8165,-804.8022;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;63;1497.004,-564.3414;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;77;1233.36,-538.357;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;70;1553.969,-1194.569;Inherit;False;Property;_Tint;Tint;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.02,0.005700916,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;1482.505,-757.3329;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;48;1671.051,-910.9148;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.6,0.6,0.6;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;159;1429.442,-1536.818;Inherit;False;Property;_CRTScale;CRTScale;12;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;71;1813.968,-1219.269;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.01,0.01,0.01,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;132;2050.176,-920.0805;Inherit;False;Constant;_sat;sat;10;0;Create;True;0;0;0;False;0;False;0.25;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;1837.369,-1000.868;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;160;1691.023,-1580.819;Inherit;True;ScreenSpaceUVLockedToObject;-1;;2;bcc05ebb4d97a5844a7b143c5d825e6e;0;1;20;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DesaturateOpNode;131;2154.798,-1165.29;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;149;2018.481,-1632.877;Inherit;True;Property;_CRT;CRT;10;0;Create;True;0;0;0;False;0;False;-1;None;e627da118310bfc49973addccac515eb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;158;2376.344,-1122.162;Inherit;False;Property;_CRTAmount;CRTAmount;11;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;2334.005,-1391.427;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;157;2509.344,-1336.162;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2342.567,-915.9835;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / VHS;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;80000;True;Overlay;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;139;0;8;2
WireConnection;125;1;126;0
WireConnection;133;0;139;0
WireConnection;129;0;125;0
WireConnection;129;2;130;0
WireConnection;137;0;133;0
WireConnection;137;1;138;0
WireConnection;134;0;137;0
WireConnection;134;1;129;0
WireConnection;110;1;8;0
WireConnection;110;3;134;0
WireConnection;10;0;9;0
WireConnection;10;1;110;0
WireConnection;1;0;110;0
WireConnection;3;0;10;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;11;0;4;0
WireConnection;18;0;17;2
WireConnection;18;1;8;0
WireConnection;25;0;26;0
WireConnection;25;1;11;0
WireConnection;13;1;1;0
WireConnection;13;0;76;0
WireConnection;12;0;13;0
WireConnection;12;1;25;0
WireConnection;15;0;18;0
WireConnection;15;1;30;0
WireConnection;22;0;12;0
WireConnection;22;1;15;0
WireConnection;22;2;23;0
WireConnection;28;1;110;0
WireConnection;24;0;22;0
WireConnection;27;0;28;0
WireConnection;27;1;24;0
WireConnection;41;0;27;0
WireConnection;67;0;68;0
WireConnection;67;1;8;0
WireConnection;64;0;41;3
WireConnection;64;2;67;0
WireConnection;61;0;60;0
WireConnection;42;0;41;1
WireConnection;42;1;41;2
WireConnection;42;2;41;3
WireConnection;63;0;61;0
WireConnection;77;0;42;0
WireConnection;77;1;64;0
WireConnection;77;2;66;0
WireConnection;62;0;77;0
WireConnection;62;1;63;0
WireConnection;48;0;62;0
WireConnection;71;0;70;0
WireConnection;69;0;71;0
WireConnection;69;1;48;0
WireConnection;160;20;159;0
WireConnection;131;0;69;0
WireConnection;131;1;132;0
WireConnection;149;1;160;0
WireConnection;148;0;149;0
WireConnection;148;1;131;0
WireConnection;157;0;131;0
WireConnection;157;1;148;0
WireConnection;157;2;158;0
WireConnection;0;2;157;0
ASEEND*/
//CHKSM=66A57F5CB63FE055D33A2E13E63F18596B3398E4