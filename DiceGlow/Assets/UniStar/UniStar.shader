// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/UniStar"
{
	Properties
	{
		_Size("Size", Float) = 10
		_Sharp("Sharp", Float) = 10
		_Noise("Noise", Range( 0 , 1)) = 0
		_Bloom("Bloom", Range( 0 , 1)) = 1
		_CutLevel("CutLevel", Range( 0 , 1)) = 0
		_LargeNoiseSize("LargeNoiseSize", Float) = 1.5
		_LargeNoise("LargeNoise", Float) = 0.7882353
		_FogSize("FogSize", Float) = 1
		_Fog("Fog", Float) = 0
		_ColorShiftLevel("ColorShiftLevel", Range( 0 , 1)) = 0
		_CentorColor("CentorColor", Color) = (0.998112,1,0.941,0)
		_Thinning("Thinning", Range( 0 , 1)) = 0
		_BrightnessMax("BrightnessMax", Range( 0 , 1)) = 0.5
		_Brightness("Brightness", Float) = 1
		_BackGroundColorBottom("BackGroundColorBottom", Color) = (0,0,0,0)
		_BackGroundColorTop("BackGroundColorTop", Color) = (0,0,0,0)
		_GradationSharpness("GradationSharpness", Range( 0 , 1)) = 0
		_LimitBottomColor("LimitBottomColor", Range( 0 , 1)) = 0
		[Toggle]_GradationMirror("GradationMirror", Float) = 1
		[Toggle]_StarHorizonGradation("StarHorizonGradation", Float) = 1
		_StarHorizonGradationOffset("StarHorizonGradationOffset", Range( -1 , 1)) = 0
		_StarHorizonGradationSharpness("StarHorizonGradationSharpness", Float) = 2
		[Toggle]_HorizontalMirror("HorizontalMirror", Float) = 1
		_MoonTexture("MoonTexture", 2D) = "black" {}
		_MoonColor("MoonColor", Color) = (1,1,1,0)
		_MoonSize("MoonSize", Float) = 5
		_HorizontalAngle("HorizontalAngle", Float) = 0
		_VerticalAngle("VerticalAngle", Float) = 0
		_BloomColor("BloomColor", Color) = (1,1,1,0)
		_MoonBloomSharpness("MoonBloomSharpness", Float) = 20
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow nofog 
		struct Input
		{
			float3 viewDir;
		};

		uniform float4 _BackGroundColorBottom;
		uniform float4 _BackGroundColorTop;
		uniform float _GradationMirror;
		uniform float _LimitBottomColor;
		uniform float _GradationSharpness;
		uniform float _HorizontalMirror;
		uniform float _Size;
		uniform float _Noise;
		uniform float _Sharp;
		uniform float _Bloom;
		uniform float _CutLevel;
		uniform float4 _CentorColor;
		uniform float _ColorShiftLevel;
		uniform float _Thinning;
		uniform float _BrightnessMax;
		uniform float _Brightness;
		uniform float _LargeNoiseSize;
		uniform float _LargeNoise;
		uniform float _StarHorizonGradation;
		uniform float _StarHorizonGradationOffset;
		uniform float _StarHorizonGradationSharpness;
		uniform float _FogSize;
		uniform float _Fog;
		uniform float4 _BloomColor;
		uniform float _HorizontalAngle;
		uniform float _VerticalAngle;
		uniform float _MoonBloomSharpness;
		uniform sampler2D _MoonTexture;
		uniform float _MoonSize;
		uniform float4 _MoonColor;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float temp_output_484_0 = pow( (1.0 + (cos( ( saturate( ( abs( i.viewDir.y ) / _LimitBottomColor ) ) * UNITY_PI ) ) - -1.0) * (0.0001 - 1.0) / (1.0 - -1.0)) , _GradationSharpness );
			float4 lerpResult479 = lerp( _BackGroundColorBottom , _BackGroundColorTop , (( _GradationMirror )?( saturate( temp_output_484_0 ) ):( saturate( ( temp_output_484_0 - saturate( ceil( i.viewDir.y ) ) ) ) )));
			float3 appendResult621 = (float3(i.viewDir.x , (( _HorizontalMirror )?( abs( i.viewDir.y ) ):( i.viewDir.y )) , i.viewDir.z));
			float3 ViewDir622 = appendResult621;
			float3 break102_g1338 = ViewDir622;
			float2 appendResult87_g1338 = (float2(break102_g1338.x , break102_g1338.z));
			float cos86_g1338 = cos( 0.0 );
			float sin86_g1338 = sin( 0.0 );
			float2 rotator86_g1338 = mul( appendResult87_g1338 - float2( 0,0 ) , float2x2( cos86_g1338 , -sin86_g1338 , sin86_g1338 , cos86_g1338 )) + float2( 0,0 );
			float2 break90_g1338 = rotator86_g1338;
			float3 appendResult89_g1338 = (float3(break90_g1338.x , break102_g1338.y , break90_g1338.y));
			float Size385 = _Size;
			float Size120_g1338 = Size385;
			float3 temp_output_110_0_g1338 = round( ( appendResult89_g1338 * Size120_g1338 ) );
			float3 break3_g1340 = temp_output_110_0_g1338;
			float2 appendResult4_g1340 = (float2(break3_g1340.x , break3_g1340.y));
			float2 appendResult5_g1340 = (float2(break3_g1340.y , break3_g1340.z));
			float dotResult2_g1345 = dot( appendResult5_g1340 , float2( 12.98,78.233 ) );
			float dotResult2_g1341 = dot( ( appendResult4_g1340 + frac( ( sin( dotResult2_g1345 ) * 43758.55 ) ) ) , float2( 12.98,78.233 ) );
			float temp_output_30_0_g1340 = frac( ( sin( dotResult2_g1341 ) * 43758.55 ) );
			float dotResult2_g1343 = dot( appendResult4_g1340 , float2( 12.98,78.233 ) );
			float dotResult2_g1342 = dot( ( frac( ( sin( dotResult2_g1343 ) * 43758.55 ) ) + appendResult5_g1340 ) , float2( 12.98,78.233 ) );
			float temp_output_31_0_g1340 = frac( ( sin( dotResult2_g1342 ) * 43758.55 ) );
			float2 appendResult13_g1340 = (float2(temp_output_30_0_g1340 , temp_output_31_0_g1340));
			float dotResult2_g1344 = dot( appendResult13_g1340 , float2( 12.98,78.233 ) );
			float temp_output_32_0_g1340 = frac( ( sin( dotResult2_g1344 ) * 43758.55 ) );
			float3 appendResult8_g1340 = (float3(temp_output_30_0_g1340 , temp_output_32_0_g1340 , temp_output_31_0_g1340));
			float Noise386 = _Noise;
			float3 normalizeResult22_g1338 = normalize( ( temp_output_110_0_g1338 + ( (float3( -1,-1,-1 ) + (appendResult8_g1340 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * Noise386 ) ) );
			float dotResult28_g1338 = dot( appendResult89_g1338 , normalizeResult22_g1338 );
			float Sharp387 = _Sharp;
			float Bloom388 = _Bloom;
			float CutLevel389 = _CutLevel;
			float4 CentorColor393 = _CentorColor;
			float4 temp_output_68_0_g1338 = CentorColor393;
			float dotResult10_g1346 = dot( round( ( appendResult89_g1338 * Size120_g1338 ) ) , float3(12.9898,78.233,128.1575) );
			float temp_output_24_14_g1338 = frac( ( sin( dotResult10_g1346 ) * 4378.55 ) );
			float temp_output_26_0_g1338 = ( temp_output_24_14_g1338 * UNITY_PI );
			float3 appendResult50_g1338 = (float3((0.0 + (cos( temp_output_26_0_g1338 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , ( 1.0 - (0.0 + (cos( temp_output_26_0_g1338 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) )));
			float4 lerpResult52_g1338 = lerp( float4( appendResult50_g1338 , 0.0 ) , temp_output_68_0_g1338 , sin( temp_output_26_0_g1338 ));
			float ClolrShiftLevel390 = _ColorShiftLevel;
			float4 lerpResult69_g1338 = lerp( temp_output_68_0_g1338 , lerpResult52_g1338 , ClolrShiftLevel390);
			float3 temp_cast_1 = (temp_output_24_14_g1338).xxx;
			float dotResult10_g1339 = dot( temp_cast_1 , float3(12.9898,78.233,128.1575) );
			float Thinning391 = _Thinning;
			float Brightness444 = _BrightnessMax;
			float4 temp_cast_2 = (Brightness444).xxxx;
			float2 temp_cast_3 = (temp_output_24_14_g1338).xx;
			float dotResult2_g1339 = dot( temp_cast_3 , float2( 12.98,78.233 ) );
			float3 break102_g1311 = ViewDir622;
			float2 appendResult87_g1311 = (float2(break102_g1311.x , break102_g1311.z));
			float cos86_g1311 = cos( 0.0 );
			float sin86_g1311 = sin( 0.0 );
			float2 rotator86_g1311 = mul( appendResult87_g1311 - float2( 0,0 ) , float2x2( cos86_g1311 , -sin86_g1311 , sin86_g1311 , cos86_g1311 )) + float2( 0,0 );
			float2 break90_g1311 = rotator86_g1311;
			float3 appendResult89_g1311 = (float3(break90_g1311.x , break102_g1311.y , break90_g1311.y));
			float Size120_g1311 = ( Size385 + 0.5 );
			float3 temp_output_110_0_g1311 = round( ( appendResult89_g1311 * Size120_g1311 ) );
			float3 break3_g1313 = temp_output_110_0_g1311;
			float2 appendResult4_g1313 = (float2(break3_g1313.x , break3_g1313.y));
			float2 appendResult5_g1313 = (float2(break3_g1313.y , break3_g1313.z));
			float dotResult2_g1318 = dot( appendResult5_g1313 , float2( 12.98,78.233 ) );
			float dotResult2_g1314 = dot( ( appendResult4_g1313 + frac( ( sin( dotResult2_g1318 ) * 43758.55 ) ) ) , float2( 12.98,78.233 ) );
			float temp_output_30_0_g1313 = frac( ( sin( dotResult2_g1314 ) * 43758.55 ) );
			float dotResult2_g1316 = dot( appendResult4_g1313 , float2( 12.98,78.233 ) );
			float dotResult2_g1315 = dot( ( frac( ( sin( dotResult2_g1316 ) * 43758.55 ) ) + appendResult5_g1313 ) , float2( 12.98,78.233 ) );
			float temp_output_31_0_g1313 = frac( ( sin( dotResult2_g1315 ) * 43758.55 ) );
			float2 appendResult13_g1313 = (float2(temp_output_30_0_g1313 , temp_output_31_0_g1313));
			float dotResult2_g1317 = dot( appendResult13_g1313 , float2( 12.98,78.233 ) );
			float temp_output_32_0_g1313 = frac( ( sin( dotResult2_g1317 ) * 43758.55 ) );
			float3 appendResult8_g1313 = (float3(temp_output_30_0_g1313 , temp_output_32_0_g1313 , temp_output_31_0_g1313));
			float3 normalizeResult22_g1311 = normalize( ( temp_output_110_0_g1311 + ( (float3( -1,-1,-1 ) + (appendResult8_g1313 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * Noise386 ) ) );
			float dotResult28_g1311 = dot( appendResult89_g1311 , normalizeResult22_g1311 );
			float4 temp_output_68_0_g1311 = CentorColor393;
			float dotResult10_g1319 = dot( round( ( appendResult89_g1311 * Size120_g1311 ) ) , float3(12.9898,78.233,128.1575) );
			float temp_output_24_14_g1311 = frac( ( sin( dotResult10_g1319 ) * 4378.55 ) );
			float temp_output_26_0_g1311 = ( temp_output_24_14_g1311 * UNITY_PI );
			float3 appendResult50_g1311 = (float3((0.0 + (cos( temp_output_26_0_g1311 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , ( 1.0 - (0.0 + (cos( temp_output_26_0_g1311 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) )));
			float4 lerpResult52_g1311 = lerp( float4( appendResult50_g1311 , 0.0 ) , temp_output_68_0_g1311 , sin( temp_output_26_0_g1311 ));
			float4 lerpResult69_g1311 = lerp( temp_output_68_0_g1311 , lerpResult52_g1311 , ClolrShiftLevel390);
			float3 temp_cast_5 = (temp_output_24_14_g1311).xxx;
			float dotResult10_g1312 = dot( temp_cast_5 , float3(12.9898,78.233,128.1575) );
			float4 temp_cast_6 = (Brightness444).xxxx;
			float2 temp_cast_7 = (temp_output_24_14_g1311).xx;
			float dotResult2_g1312 = dot( temp_cast_7 , float2( 12.98,78.233 ) );
			float3 break102_g1329 = ViewDir622;
			float2 appendResult87_g1329 = (float2(break102_g1329.x , break102_g1329.z));
			float cos86_g1329 = cos( 0.0 );
			float sin86_g1329 = sin( 0.0 );
			float2 rotator86_g1329 = mul( appendResult87_g1329 - float2( 0,0 ) , float2x2( cos86_g1329 , -sin86_g1329 , sin86_g1329 , cos86_g1329 )) + float2( 0,0 );
			float2 break90_g1329 = rotator86_g1329;
			float3 appendResult89_g1329 = (float3(break90_g1329.x , break102_g1329.y , break90_g1329.y));
			float Size120_g1329 = ( Size385 + 5.0 );
			float3 temp_output_110_0_g1329 = round( ( appendResult89_g1329 * Size120_g1329 ) );
			float3 break3_g1331 = temp_output_110_0_g1329;
			float2 appendResult4_g1331 = (float2(break3_g1331.x , break3_g1331.y));
			float2 appendResult5_g1331 = (float2(break3_g1331.y , break3_g1331.z));
			float dotResult2_g1336 = dot( appendResult5_g1331 , float2( 12.98,78.233 ) );
			float dotResult2_g1332 = dot( ( appendResult4_g1331 + frac( ( sin( dotResult2_g1336 ) * 43758.55 ) ) ) , float2( 12.98,78.233 ) );
			float temp_output_30_0_g1331 = frac( ( sin( dotResult2_g1332 ) * 43758.55 ) );
			float dotResult2_g1334 = dot( appendResult4_g1331 , float2( 12.98,78.233 ) );
			float dotResult2_g1333 = dot( ( frac( ( sin( dotResult2_g1334 ) * 43758.55 ) ) + appendResult5_g1331 ) , float2( 12.98,78.233 ) );
			float temp_output_31_0_g1331 = frac( ( sin( dotResult2_g1333 ) * 43758.55 ) );
			float2 appendResult13_g1331 = (float2(temp_output_30_0_g1331 , temp_output_31_0_g1331));
			float dotResult2_g1335 = dot( appendResult13_g1331 , float2( 12.98,78.233 ) );
			float temp_output_32_0_g1331 = frac( ( sin( dotResult2_g1335 ) * 43758.55 ) );
			float3 appendResult8_g1331 = (float3(temp_output_30_0_g1331 , temp_output_32_0_g1331 , temp_output_31_0_g1331));
			float3 normalizeResult22_g1329 = normalize( ( temp_output_110_0_g1329 + ( (float3( -1,-1,-1 ) + (appendResult8_g1331 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * Noise386 ) ) );
			float dotResult28_g1329 = dot( appendResult89_g1329 , normalizeResult22_g1329 );
			float4 temp_output_68_0_g1329 = CentorColor393;
			float dotResult10_g1337 = dot( round( ( appendResult89_g1329 * Size120_g1329 ) ) , float3(12.9898,78.233,128.1575) );
			float temp_output_24_14_g1329 = frac( ( sin( dotResult10_g1337 ) * 4378.55 ) );
			float temp_output_26_0_g1329 = ( temp_output_24_14_g1329 * UNITY_PI );
			float3 appendResult50_g1329 = (float3((0.0 + (cos( temp_output_26_0_g1329 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , ( 1.0 - (0.0 + (cos( temp_output_26_0_g1329 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) )));
			float4 lerpResult52_g1329 = lerp( float4( appendResult50_g1329 , 0.0 ) , temp_output_68_0_g1329 , sin( temp_output_26_0_g1329 ));
			float4 lerpResult69_g1329 = lerp( temp_output_68_0_g1329 , lerpResult52_g1329 , ClolrShiftLevel390);
			float3 temp_cast_9 = (temp_output_24_14_g1329).xxx;
			float dotResult10_g1330 = dot( temp_cast_9 , float3(12.9898,78.233,128.1575) );
			float4 temp_cast_10 = (Brightness444).xxxx;
			float2 temp_cast_11 = (temp_output_24_14_g1329).xx;
			float dotResult2_g1330 = dot( temp_cast_11 , float2( 12.98,78.233 ) );
			float3 break102_g1320 = ViewDir622;
			float2 appendResult87_g1320 = (float2(break102_g1320.x , break102_g1320.z));
			float cos86_g1320 = cos( 0.0 );
			float sin86_g1320 = sin( 0.0 );
			float2 rotator86_g1320 = mul( appendResult87_g1320 - float2( 0,0 ) , float2x2( cos86_g1320 , -sin86_g1320 , sin86_g1320 , cos86_g1320 )) + float2( 0,0 );
			float2 break90_g1320 = rotator86_g1320;
			float3 appendResult89_g1320 = (float3(break90_g1320.x , break102_g1320.y , break90_g1320.y));
			float Size120_g1320 = ( Size385 + 5.5 );
			float3 temp_output_110_0_g1320 = round( ( appendResult89_g1320 * Size120_g1320 ) );
			float3 break3_g1322 = temp_output_110_0_g1320;
			float2 appendResult4_g1322 = (float2(break3_g1322.x , break3_g1322.y));
			float2 appendResult5_g1322 = (float2(break3_g1322.y , break3_g1322.z));
			float dotResult2_g1327 = dot( appendResult5_g1322 , float2( 12.98,78.233 ) );
			float dotResult2_g1323 = dot( ( appendResult4_g1322 + frac( ( sin( dotResult2_g1327 ) * 43758.55 ) ) ) , float2( 12.98,78.233 ) );
			float temp_output_30_0_g1322 = frac( ( sin( dotResult2_g1323 ) * 43758.55 ) );
			float dotResult2_g1325 = dot( appendResult4_g1322 , float2( 12.98,78.233 ) );
			float dotResult2_g1324 = dot( ( frac( ( sin( dotResult2_g1325 ) * 43758.55 ) ) + appendResult5_g1322 ) , float2( 12.98,78.233 ) );
			float temp_output_31_0_g1322 = frac( ( sin( dotResult2_g1324 ) * 43758.55 ) );
			float2 appendResult13_g1322 = (float2(temp_output_30_0_g1322 , temp_output_31_0_g1322));
			float dotResult2_g1326 = dot( appendResult13_g1322 , float2( 12.98,78.233 ) );
			float temp_output_32_0_g1322 = frac( ( sin( dotResult2_g1326 ) * 43758.55 ) );
			float3 appendResult8_g1322 = (float3(temp_output_30_0_g1322 , temp_output_32_0_g1322 , temp_output_31_0_g1322));
			float3 normalizeResult22_g1320 = normalize( ( temp_output_110_0_g1320 + ( (float3( -1,-1,-1 ) + (appendResult8_g1322 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * Noise386 ) ) );
			float dotResult28_g1320 = dot( appendResult89_g1320 , normalizeResult22_g1320 );
			float4 temp_output_68_0_g1320 = CentorColor393;
			float dotResult10_g1328 = dot( round( ( appendResult89_g1320 * Size120_g1320 ) ) , float3(12.9898,78.233,128.1575) );
			float temp_output_24_14_g1320 = frac( ( sin( dotResult10_g1328 ) * 4378.55 ) );
			float temp_output_26_0_g1320 = ( temp_output_24_14_g1320 * UNITY_PI );
			float3 appendResult50_g1320 = (float3((0.0 + (cos( temp_output_26_0_g1320 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , ( 1.0 - (0.0 + (cos( temp_output_26_0_g1320 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) )));
			float4 lerpResult52_g1320 = lerp( float4( appendResult50_g1320 , 0.0 ) , temp_output_68_0_g1320 , sin( temp_output_26_0_g1320 ));
			float4 lerpResult69_g1320 = lerp( temp_output_68_0_g1320 , lerpResult52_g1320 , ClolrShiftLevel390);
			float3 temp_cast_13 = (temp_output_24_14_g1320).xxx;
			float dotResult10_g1321 = dot( temp_cast_13 , float3(12.9898,78.233,128.1575) );
			float4 temp_cast_14 = (Brightness444).xxxx;
			float2 temp_cast_15 = (temp_output_24_14_g1320).xx;
			float dotResult2_g1321 = dot( temp_cast_15 , float2( 12.98,78.233 ) );
			float4 temp_cast_16 = (0.6).xxxx;
			float3 v24_g436 = ( i.viewDir * _LargeNoiseSize );
			float2 appendResult51_g436 = (float2(( 1.0 / 6.0 ) , ( 1.0 / 3.0 )));
			float2 C6_g436 = appendResult51_g436;
			float dotResult16_g436 = dot( v24_g436 , (C6_g436).yyy );
			float3 i21_g436 = floor( ( v24_g436 + dotResult16_g436 ) );
			float dotResult31_g436 = dot( i21_g436 , (C6_g436).xxx );
			float3 x032_g436 = ( ( v24_g436 - i21_g436 ) + dotResult31_g436 );
			float dotResult286_g436 = dot( x032_g436 , x032_g436 );
			float3 g40_g436 = step( (x032_g436).yzx , x032_g436 );
			float3 temp_output_62_0_g436 = (g40_g436).xyz;
			float3 l54_g436 = ( 1.0 - g40_g436 );
			float3 temp_output_63_0_g436 = (l54_g436).zxy;
			float3 i157_g436 = min( temp_output_62_0_g436 , temp_output_63_0_g436 );
			float3 x165_g436 = ( ( x032_g436 - i157_g436 ) + (C6_g436).xxx );
			float dotResult289_g436 = dot( x165_g436 , x165_g436 );
			float3 i258_g436 = max( temp_output_62_0_g436 , temp_output_63_0_g436 );
			float3 x266_g436 = ( ( x032_g436 - i258_g436 ) + (C6_g436).yyy );
			float dotResult291_g436 = dot( x266_g436 , x266_g436 );
			float3 temp_cast_17 = (0.5).xxx;
			float3 x367_g436 = ( x032_g436 - temp_cast_17 );
			float dotResult293_g436 = dot( x367_g436 , x367_g436 );
			float4 appendResult287_g436 = (float4(dotResult286_g436 , dotResult289_g436 , dotResult291_g436 , dotResult293_g436));
			float4 temp_cast_18 = (0.0).xxxx;
			float4 m301_g436 = max( ( temp_cast_16 - appendResult287_g436 ) , temp_cast_18 );
			float4 m2351_g436 = ( m301_g436 * m301_g436 );
			float4 m3352_g436 = ( m2351_g436 * m301_g436 );
			float3 temp_output_3_0_g444 = i21_g436;
			float3 i_97_g436 = ( temp_output_3_0_g444 - ( floor( ( temp_output_3_0_g444 / 289.0 ) ) * 289.0 ) );
			float4 appendResult105_g436 = (float4(0.0 , (i157_g436).z , (i258_g436).z , 1.0));
			float4 temp_output_1_0_g442 = ( (i_97_g436).z + appendResult105_g436 );
			float4 temp_output_3_0_g443 = ( temp_output_1_0_g442 * ( ( temp_output_1_0_g442 * 34.0 ) + 1.0 ) );
			float4 appendResult121_g436 = (float4(0.0 , (i157_g436).y , (i258_g436).y , 1.0));
			float4 temp_output_1_0_g440 = ( ( temp_output_3_0_g443 - ( floor( ( temp_output_3_0_g443 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g436).y + appendResult121_g436 ) );
			float4 temp_output_3_0_g441 = ( temp_output_1_0_g440 * ( ( temp_output_1_0_g440 * 34.0 ) + 1.0 ) );
			float4 appendResult127_g436 = (float4(0.0 , (i157_g436).x , (i258_g436).x , 1.0));
			float4 temp_output_1_0_g437 = ( ( temp_output_3_0_g441 - ( floor( ( temp_output_3_0_g441 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g436).x + appendResult127_g436 ) );
			float4 temp_output_3_0_g438 = ( temp_output_1_0_g437 * ( ( temp_output_1_0_g437 * 34.0 ) + 1.0 ) );
			float4 p130_g436 = ( temp_output_3_0_g438 - ( floor( ( temp_output_3_0_g438 / 289.0 ) ) * 289.0 ) );
			float4 j140_g436 = ( p130_g436 - ( floor( ( p130_g436 / 49.0 ) ) * 49.0 ) );
			float4 x_145_g436 = floor( ( j140_g436 / 7.0 ) );
			float4 temp_cast_19 = (1.0).xxxx;
			float4 x169_g436 = ( ( ( ( x_145_g436 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_19 );
			float4 y_152_g436 = floor( ( j140_g436 - ( 7.0 * x_145_g436 ) ) );
			float4 temp_cast_20 = (1.0).xxxx;
			float4 y170_g436 = ( ( ( ( y_152_g436 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_20 );
			float4 appendResult177_g436 = (float4((x169_g436).xy , (y170_g436).xy));
			float4 b0179_g436 = appendResult177_g436;
			float4 s0192_g436 = ( ( floor( b0179_g436 ) * 2.0 ) + 1.0 );
			float4 h201_g436 = ( ( 1.0 - abs( x169_g436 ) ) - abs( y170_g436 ) );
			float4 temp_cast_21 = (0.0).xxxx;
			float4 sh202_g436 = ( step( h201_g436 , temp_cast_21 ) * -1.0 );
			float4 a0212_g436 = ( (b0179_g436).xzyw + ( (s0192_g436).xzyw * (sh202_g436).xxyy ) );
			float3 appendResult226_g436 = (float3((a0212_g436).xy , (h201_g436).x));
			float3 g0231_g436 = appendResult226_g436;
			float dotResult371_g436 = dot( x032_g436 , g0231_g436 );
			float4 m4353_g436 = ( m2351_g436 * m2351_g436 );
			float3 appendResult240_g436 = (float3((a0212_g436).zw , (h201_g436).y));
			float3 g1241_g436 = appendResult240_g436;
			float dotResult382_g436 = dot( x165_g436 , g1241_g436 );
			float4 appendResult182_g436 = (float4((x169_g436).zw , (y170_g436).zw));
			float4 b1184_g436 = appendResult182_g436;
			float4 s1197_g436 = ( ( floor( b1184_g436 ) * 2.0 ) + 1.0 );
			float4 a1221_g436 = ( (b1184_g436).xzyw + ( (s1197_g436).xzyw * (sh202_g436).zzww ) );
			float3 appendResult244_g436 = (float3((a1221_g436).xy , (h201_g436).z));
			float3 g2248_g436 = appendResult244_g436;
			float dotResult393_g436 = dot( x266_g436 , g2248_g436 );
			float3 appendResult245_g436 = (float3((a1221_g436).zw , (h201_g436).w));
			float3 g3249_g436 = appendResult245_g436;
			float dotResult404_g436 = dot( x367_g436 , g3249_g436 );
			float3 grad416_g436 = ( ( -6.0 * (m3352_g436).x * x032_g436 * dotResult371_g436 ) + ( (m4353_g436).x * g0231_g436 ) + ( -6.0 * (m3352_g436).y * x165_g436 * dotResult382_g436 ) + ( (m4353_g436).y * g1241_g436 ) + ( -6.0 * (m3352_g436).z * x266_g436 * dotResult393_g436 ) + ( (m4353_g436).z * g2248_g436 ) + ( -6.0 * (m3352_g436).w * x367_g436 * dotResult404_g436 ) + ( (m4353_g436).w * g3249_g436 ) );
			float4 temp_cast_22 = (1.792843).xxxx;
			float dotResult252_g436 = dot( g0231_g436 , g0231_g436 );
			float dotResult253_g436 = dot( g1241_g436 , g1241_g436 );
			float dotResult255_g436 = dot( g2248_g436 , g2248_g436 );
			float dotResult256_g436 = dot( g3249_g436 , g3249_g436 );
			float4 appendResult257_g436 = (float4(dotResult252_g436 , dotResult253_g436 , dotResult255_g436 , dotResult256_g436));
			float4 norm258_g436 = ( temp_cast_22 - ( appendResult257_g436 * 0.8537347 ) );
			float3 g0_261_g436 = ( g0231_g436 * (norm258_g436).x );
			float dotResult317_g436 = dot( x032_g436 , g0_261_g436 );
			float3 g1_270_g436 = ( g1241_g436 * (norm258_g436).y );
			float dotResult318_g436 = dot( x165_g436 , g1_270_g436 );
			float3 g2_275_g436 = ( g2248_g436 * (norm258_g436).z );
			float dotResult316_g436 = dot( x266_g436 , g2_275_g436 );
			float3 g3_280_g436 = ( g3249_g436 * (norm258_g436).w );
			float dotResult320_g436 = dot( x367_g436 , g3_280_g436 );
			float4 appendResult319_g436 = (float4(dotResult317_g436 , dotResult318_g436 , dotResult316_g436 , dotResult320_g436));
			float4 px418_g436 = appendResult319_g436;
			float dotResult421_g436 = dot( m4353_g436 , px418_g436 );
			float4 appendResult417_g436 = (float4(grad416_g436 , dotResult421_g436));
			float4 result341_g436 = ( 42.0 * appendResult417_g436 );
			float4 temp_cast_23 = (0.6).xxxx;
			float3 temp_output_355_0 = ( i.viewDir * _FogSize );
			float3 v24_g499 = temp_output_355_0;
			float2 appendResult51_g499 = (float2(( 1.0 / 6.0 ) , ( 1.0 / 3.0 )));
			float2 C6_g499 = appendResult51_g499;
			float dotResult16_g499 = dot( v24_g499 , (C6_g499).yyy );
			float3 i21_g499 = floor( ( v24_g499 + dotResult16_g499 ) );
			float dotResult31_g499 = dot( i21_g499 , (C6_g499).xxx );
			float3 x032_g499 = ( ( v24_g499 - i21_g499 ) + dotResult31_g499 );
			float dotResult286_g499 = dot( x032_g499 , x032_g499 );
			float3 g40_g499 = step( (x032_g499).yzx , x032_g499 );
			float3 temp_output_62_0_g499 = (g40_g499).xyz;
			float3 l54_g499 = ( 1.0 - g40_g499 );
			float3 temp_output_63_0_g499 = (l54_g499).zxy;
			float3 i157_g499 = min( temp_output_62_0_g499 , temp_output_63_0_g499 );
			float3 x165_g499 = ( ( x032_g499 - i157_g499 ) + (C6_g499).xxx );
			float dotResult289_g499 = dot( x165_g499 , x165_g499 );
			float3 i258_g499 = max( temp_output_62_0_g499 , temp_output_63_0_g499 );
			float3 x266_g499 = ( ( x032_g499 - i258_g499 ) + (C6_g499).yyy );
			float dotResult291_g499 = dot( x266_g499 , x266_g499 );
			float3 temp_cast_24 = (0.5).xxx;
			float3 x367_g499 = ( x032_g499 - temp_cast_24 );
			float dotResult293_g499 = dot( x367_g499 , x367_g499 );
			float4 appendResult287_g499 = (float4(dotResult286_g499 , dotResult289_g499 , dotResult291_g499 , dotResult293_g499));
			float4 temp_cast_25 = (0.0).xxxx;
			float4 m301_g499 = max( ( temp_cast_23 - appendResult287_g499 ) , temp_cast_25 );
			float4 m2351_g499 = ( m301_g499 * m301_g499 );
			float4 m3352_g499 = ( m2351_g499 * m301_g499 );
			float3 temp_output_3_0_g507 = i21_g499;
			float3 i_97_g499 = ( temp_output_3_0_g507 - ( floor( ( temp_output_3_0_g507 / 289.0 ) ) * 289.0 ) );
			float4 appendResult105_g499 = (float4(0.0 , (i157_g499).z , (i258_g499).z , 1.0));
			float4 temp_output_1_0_g505 = ( (i_97_g499).z + appendResult105_g499 );
			float4 temp_output_3_0_g506 = ( temp_output_1_0_g505 * ( ( temp_output_1_0_g505 * 34.0 ) + 1.0 ) );
			float4 appendResult121_g499 = (float4(0.0 , (i157_g499).y , (i258_g499).y , 1.0));
			float4 temp_output_1_0_g503 = ( ( temp_output_3_0_g506 - ( floor( ( temp_output_3_0_g506 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g499).y + appendResult121_g499 ) );
			float4 temp_output_3_0_g504 = ( temp_output_1_0_g503 * ( ( temp_output_1_0_g503 * 34.0 ) + 1.0 ) );
			float4 appendResult127_g499 = (float4(0.0 , (i157_g499).x , (i258_g499).x , 1.0));
			float4 temp_output_1_0_g500 = ( ( temp_output_3_0_g504 - ( floor( ( temp_output_3_0_g504 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g499).x + appendResult127_g499 ) );
			float4 temp_output_3_0_g501 = ( temp_output_1_0_g500 * ( ( temp_output_1_0_g500 * 34.0 ) + 1.0 ) );
			float4 p130_g499 = ( temp_output_3_0_g501 - ( floor( ( temp_output_3_0_g501 / 289.0 ) ) * 289.0 ) );
			float4 j140_g499 = ( p130_g499 - ( floor( ( p130_g499 / 49.0 ) ) * 49.0 ) );
			float4 x_145_g499 = floor( ( j140_g499 / 7.0 ) );
			float4 temp_cast_26 = (1.0).xxxx;
			float4 x169_g499 = ( ( ( ( x_145_g499 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_26 );
			float4 y_152_g499 = floor( ( j140_g499 - ( 7.0 * x_145_g499 ) ) );
			float4 temp_cast_27 = (1.0).xxxx;
			float4 y170_g499 = ( ( ( ( y_152_g499 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_27 );
			float4 appendResult177_g499 = (float4((x169_g499).xy , (y170_g499).xy));
			float4 b0179_g499 = appendResult177_g499;
			float4 s0192_g499 = ( ( floor( b0179_g499 ) * 2.0 ) + 1.0 );
			float4 h201_g499 = ( ( 1.0 - abs( x169_g499 ) ) - abs( y170_g499 ) );
			float4 temp_cast_28 = (0.0).xxxx;
			float4 sh202_g499 = ( step( h201_g499 , temp_cast_28 ) * -1.0 );
			float4 a0212_g499 = ( (b0179_g499).xzyw + ( (s0192_g499).xzyw * (sh202_g499).xxyy ) );
			float3 appendResult226_g499 = (float3((a0212_g499).xy , (h201_g499).x));
			float3 g0231_g499 = appendResult226_g499;
			float dotResult371_g499 = dot( x032_g499 , g0231_g499 );
			float4 m4353_g499 = ( m2351_g499 * m2351_g499 );
			float3 appendResult240_g499 = (float3((a0212_g499).zw , (h201_g499).y));
			float3 g1241_g499 = appendResult240_g499;
			float dotResult382_g499 = dot( x165_g499 , g1241_g499 );
			float4 appendResult182_g499 = (float4((x169_g499).zw , (y170_g499).zw));
			float4 b1184_g499 = appendResult182_g499;
			float4 s1197_g499 = ( ( floor( b1184_g499 ) * 2.0 ) + 1.0 );
			float4 a1221_g499 = ( (b1184_g499).xzyw + ( (s1197_g499).xzyw * (sh202_g499).zzww ) );
			float3 appendResult244_g499 = (float3((a1221_g499).xy , (h201_g499).z));
			float3 g2248_g499 = appendResult244_g499;
			float dotResult393_g499 = dot( x266_g499 , g2248_g499 );
			float3 appendResult245_g499 = (float3((a1221_g499).zw , (h201_g499).w));
			float3 g3249_g499 = appendResult245_g499;
			float dotResult404_g499 = dot( x367_g499 , g3249_g499 );
			float3 grad416_g499 = ( ( -6.0 * (m3352_g499).x * x032_g499 * dotResult371_g499 ) + ( (m4353_g499).x * g0231_g499 ) + ( -6.0 * (m3352_g499).y * x165_g499 * dotResult382_g499 ) + ( (m4353_g499).y * g1241_g499 ) + ( -6.0 * (m3352_g499).z * x266_g499 * dotResult393_g499 ) + ( (m4353_g499).z * g2248_g499 ) + ( -6.0 * (m3352_g499).w * x367_g499 * dotResult404_g499 ) + ( (m4353_g499).w * g3249_g499 ) );
			float4 temp_cast_29 = (1.792843).xxxx;
			float dotResult252_g499 = dot( g0231_g499 , g0231_g499 );
			float dotResult253_g499 = dot( g1241_g499 , g1241_g499 );
			float dotResult255_g499 = dot( g2248_g499 , g2248_g499 );
			float dotResult256_g499 = dot( g3249_g499 , g3249_g499 );
			float4 appendResult257_g499 = (float4(dotResult252_g499 , dotResult253_g499 , dotResult255_g499 , dotResult256_g499));
			float4 norm258_g499 = ( temp_cast_29 - ( appendResult257_g499 * 0.8537347 ) );
			float3 g0_261_g499 = ( g0231_g499 * (norm258_g499).x );
			float dotResult317_g499 = dot( x032_g499 , g0_261_g499 );
			float3 g1_270_g499 = ( g1241_g499 * (norm258_g499).y );
			float dotResult318_g499 = dot( x165_g499 , g1_270_g499 );
			float3 g2_275_g499 = ( g2248_g499 * (norm258_g499).z );
			float dotResult316_g499 = dot( x266_g499 , g2_275_g499 );
			float3 g3_280_g499 = ( g3249_g499 * (norm258_g499).w );
			float dotResult320_g499 = dot( x367_g499 , g3_280_g499 );
			float4 appendResult319_g499 = (float4(dotResult317_g499 , dotResult318_g499 , dotResult316_g499 , dotResult320_g499));
			float4 px418_g499 = appendResult319_g499;
			float dotResult421_g499 = dot( m4353_g499 , px418_g499 );
			float4 appendResult417_g499 = (float4(grad416_g499 , dotResult421_g499));
			float4 result341_g499 = ( 42.0 * appendResult417_g499 );
			float4 temp_cast_30 = (0.6).xxxx;
			float3 v24_g508 = ( temp_output_355_0 * float3( 3,3,3 ) );
			float2 appendResult51_g508 = (float2(( 1.0 / 6.0 ) , ( 1.0 / 3.0 )));
			float2 C6_g508 = appendResult51_g508;
			float dotResult16_g508 = dot( v24_g508 , (C6_g508).yyy );
			float3 i21_g508 = floor( ( v24_g508 + dotResult16_g508 ) );
			float dotResult31_g508 = dot( i21_g508 , (C6_g508).xxx );
			float3 x032_g508 = ( ( v24_g508 - i21_g508 ) + dotResult31_g508 );
			float dotResult286_g508 = dot( x032_g508 , x032_g508 );
			float3 g40_g508 = step( (x032_g508).yzx , x032_g508 );
			float3 temp_output_62_0_g508 = (g40_g508).xyz;
			float3 l54_g508 = ( 1.0 - g40_g508 );
			float3 temp_output_63_0_g508 = (l54_g508).zxy;
			float3 i157_g508 = min( temp_output_62_0_g508 , temp_output_63_0_g508 );
			float3 x165_g508 = ( ( x032_g508 - i157_g508 ) + (C6_g508).xxx );
			float dotResult289_g508 = dot( x165_g508 , x165_g508 );
			float3 i258_g508 = max( temp_output_62_0_g508 , temp_output_63_0_g508 );
			float3 x266_g508 = ( ( x032_g508 - i258_g508 ) + (C6_g508).yyy );
			float dotResult291_g508 = dot( x266_g508 , x266_g508 );
			float3 temp_cast_31 = (0.5).xxx;
			float3 x367_g508 = ( x032_g508 - temp_cast_31 );
			float dotResult293_g508 = dot( x367_g508 , x367_g508 );
			float4 appendResult287_g508 = (float4(dotResult286_g508 , dotResult289_g508 , dotResult291_g508 , dotResult293_g508));
			float4 temp_cast_32 = (0.0).xxxx;
			float4 m301_g508 = max( ( temp_cast_30 - appendResult287_g508 ) , temp_cast_32 );
			float4 m2351_g508 = ( m301_g508 * m301_g508 );
			float4 m3352_g508 = ( m2351_g508 * m301_g508 );
			float3 temp_output_3_0_g516 = i21_g508;
			float3 i_97_g508 = ( temp_output_3_0_g516 - ( floor( ( temp_output_3_0_g516 / 289.0 ) ) * 289.0 ) );
			float4 appendResult105_g508 = (float4(0.0 , (i157_g508).z , (i258_g508).z , 1.0));
			float4 temp_output_1_0_g514 = ( (i_97_g508).z + appendResult105_g508 );
			float4 temp_output_3_0_g515 = ( temp_output_1_0_g514 * ( ( temp_output_1_0_g514 * 34.0 ) + 1.0 ) );
			float4 appendResult121_g508 = (float4(0.0 , (i157_g508).y , (i258_g508).y , 1.0));
			float4 temp_output_1_0_g512 = ( ( temp_output_3_0_g515 - ( floor( ( temp_output_3_0_g515 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g508).y + appendResult121_g508 ) );
			float4 temp_output_3_0_g513 = ( temp_output_1_0_g512 * ( ( temp_output_1_0_g512 * 34.0 ) + 1.0 ) );
			float4 appendResult127_g508 = (float4(0.0 , (i157_g508).x , (i258_g508).x , 1.0));
			float4 temp_output_1_0_g509 = ( ( temp_output_3_0_g513 - ( floor( ( temp_output_3_0_g513 / 289.0 ) ) * 289.0 ) ) + ( (i_97_g508).x + appendResult127_g508 ) );
			float4 temp_output_3_0_g510 = ( temp_output_1_0_g509 * ( ( temp_output_1_0_g509 * 34.0 ) + 1.0 ) );
			float4 p130_g508 = ( temp_output_3_0_g510 - ( floor( ( temp_output_3_0_g510 / 289.0 ) ) * 289.0 ) );
			float4 j140_g508 = ( p130_g508 - ( floor( ( p130_g508 / 49.0 ) ) * 49.0 ) );
			float4 x_145_g508 = floor( ( j140_g508 / 7.0 ) );
			float4 temp_cast_33 = (1.0).xxxx;
			float4 x169_g508 = ( ( ( ( x_145_g508 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_33 );
			float4 y_152_g508 = floor( ( j140_g508 - ( 7.0 * x_145_g508 ) ) );
			float4 temp_cast_34 = (1.0).xxxx;
			float4 y170_g508 = ( ( ( ( y_152_g508 * 2.0 ) + 0.5 ) / 7.0 ) - temp_cast_34 );
			float4 appendResult177_g508 = (float4((x169_g508).xy , (y170_g508).xy));
			float4 b0179_g508 = appendResult177_g508;
			float4 s0192_g508 = ( ( floor( b0179_g508 ) * 2.0 ) + 1.0 );
			float4 h201_g508 = ( ( 1.0 - abs( x169_g508 ) ) - abs( y170_g508 ) );
			float4 temp_cast_35 = (0.0).xxxx;
			float4 sh202_g508 = ( step( h201_g508 , temp_cast_35 ) * -1.0 );
			float4 a0212_g508 = ( (b0179_g508).xzyw + ( (s0192_g508).xzyw * (sh202_g508).xxyy ) );
			float3 appendResult226_g508 = (float3((a0212_g508).xy , (h201_g508).x));
			float3 g0231_g508 = appendResult226_g508;
			float dotResult371_g508 = dot( x032_g508 , g0231_g508 );
			float4 m4353_g508 = ( m2351_g508 * m2351_g508 );
			float3 appendResult240_g508 = (float3((a0212_g508).zw , (h201_g508).y));
			float3 g1241_g508 = appendResult240_g508;
			float dotResult382_g508 = dot( x165_g508 , g1241_g508 );
			float4 appendResult182_g508 = (float4((x169_g508).zw , (y170_g508).zw));
			float4 b1184_g508 = appendResult182_g508;
			float4 s1197_g508 = ( ( floor( b1184_g508 ) * 2.0 ) + 1.0 );
			float4 a1221_g508 = ( (b1184_g508).xzyw + ( (s1197_g508).xzyw * (sh202_g508).zzww ) );
			float3 appendResult244_g508 = (float3((a1221_g508).xy , (h201_g508).z));
			float3 g2248_g508 = appendResult244_g508;
			float dotResult393_g508 = dot( x266_g508 , g2248_g508 );
			float3 appendResult245_g508 = (float3((a1221_g508).zw , (h201_g508).w));
			float3 g3249_g508 = appendResult245_g508;
			float dotResult404_g508 = dot( x367_g508 , g3249_g508 );
			float3 grad416_g508 = ( ( -6.0 * (m3352_g508).x * x032_g508 * dotResult371_g508 ) + ( (m4353_g508).x * g0231_g508 ) + ( -6.0 * (m3352_g508).y * x165_g508 * dotResult382_g508 ) + ( (m4353_g508).y * g1241_g508 ) + ( -6.0 * (m3352_g508).z * x266_g508 * dotResult393_g508 ) + ( (m4353_g508).z * g2248_g508 ) + ( -6.0 * (m3352_g508).w * x367_g508 * dotResult404_g508 ) + ( (m4353_g508).w * g3249_g508 ) );
			float4 temp_cast_36 = (1.792843).xxxx;
			float dotResult252_g508 = dot( g0231_g508 , g0231_g508 );
			float dotResult253_g508 = dot( g1241_g508 , g1241_g508 );
			float dotResult255_g508 = dot( g2248_g508 , g2248_g508 );
			float dotResult256_g508 = dot( g3249_g508 , g3249_g508 );
			float4 appendResult257_g508 = (float4(dotResult252_g508 , dotResult253_g508 , dotResult255_g508 , dotResult256_g508));
			float4 norm258_g508 = ( temp_cast_36 - ( appendResult257_g508 * 0.8537347 ) );
			float3 g0_261_g508 = ( g0231_g508 * (norm258_g508).x );
			float dotResult317_g508 = dot( x032_g508 , g0_261_g508 );
			float3 g1_270_g508 = ( g1241_g508 * (norm258_g508).y );
			float dotResult318_g508 = dot( x165_g508 , g1_270_g508 );
			float3 g2_275_g508 = ( g2248_g508 * (norm258_g508).z );
			float dotResult316_g508 = dot( x266_g508 , g2_275_g508 );
			float3 g3_280_g508 = ( g3249_g508 * (norm258_g508).w );
			float dotResult320_g508 = dot( x367_g508 , g3_280_g508 );
			float4 appendResult319_g508 = (float4(dotResult317_g508 , dotResult318_g508 , dotResult316_g508 , dotResult320_g508));
			float4 px418_g508 = appendResult319_g508;
			float dotResult421_g508 = dot( m4353_g508 , px418_g508 );
			float4 appendResult417_g508 = (float4(grad416_g508 , dotResult421_g508));
			float4 result341_g508 = ( 42.0 * appendResult417_g508 );
			float3 break606 = i.viewDir;
			float2 appendResult607 = (float2(break606.x , break606.z));
			float cos605 = cos( _HorizontalAngle );
			float sin605 = sin( _HorizontalAngle );
			float2 rotator605 = mul( appendResult607 - float2( 0,0 ) , float2x2( cos605 , -sin605 , sin605 , cos605 )) + float2( 0,0 );
			float2 break610 = rotator605;
			float3 appendResult609 = (float3(break610.x , break606.y , break610.y));
			float3 break612 = appendResult609;
			float2 appendResult613 = (float2(break612.x , break612.y));
			float cos611 = cos( _VerticalAngle );
			float sin611 = sin( _VerticalAngle );
			float2 rotator611 = mul( appendResult613 - float2( 0,0 ) , float2x2( cos611 , -sin611 , sin611 , cos611 )) + float2( 0,0 );
			float3 appendResult614 = (float3(rotator611 , break612.z));
			float dotResult566 = dot( float3(-1,0,0) , appendResult614 );
			float2 break617 = (float2( 0,0 ) + (( (appendResult614).yz * _MoonSize ) - float2( 1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( -1,1 ) - float2( 1,-1 )));
			float2 appendResult618 = (float2(break617.y , break617.x));
			float4 tex2DNode601 = tex2Dbias( _MoonTexture, float4( saturate( appendResult618 ), 0, -1.0) );
			float4 lerpResult604 = lerp( saturate( ( lerpResult479 + ( ( ( min( ( pow( saturate( ( 0.5 / ( ( 1.0 - dotResult28_g1338 ) * pow( Sharp387 , 3.0 ) ) ) ) , ( 1.0 / Bloom388 ) ) * step( distance( distance( temp_output_110_0_g1338 , float3( 0,0,0 ) ) , Size120_g1338 ) , CutLevel389 ) * lerpResult69_g1338 * step( frac( ( sin( dotResult10_g1339 ) * 4378.55 ) ) , Thinning391 ) ) , temp_cast_2 ) * frac( ( sin( dotResult2_g1339 ) * 43758.55 ) ) * temp_output_24_14_g1338 ) + ( min( ( pow( saturate( ( 0.5 / ( ( 1.0 - dotResult28_g1311 ) * pow( Sharp387 , 3.0 ) ) ) ) , ( 1.0 / Bloom388 ) ) * step( distance( distance( temp_output_110_0_g1311 , float3( 0,0,0 ) ) , Size120_g1311 ) , CutLevel389 ) * lerpResult69_g1311 * step( frac( ( sin( dotResult10_g1312 ) * 4378.55 ) ) , Thinning391 ) ) , temp_cast_6 ) * frac( ( sin( dotResult2_g1312 ) * 43758.55 ) ) * temp_output_24_14_g1311 ) + ( min( ( pow( saturate( ( 0.5 / ( ( 1.0 - dotResult28_g1329 ) * pow( Sharp387 , 3.0 ) ) ) ) , ( 1.0 / Bloom388 ) ) * step( distance( distance( temp_output_110_0_g1329 , float3( 0,0,0 ) ) , Size120_g1329 ) , CutLevel389 ) * lerpResult69_g1329 * step( frac( ( sin( dotResult10_g1330 ) * 4378.55 ) ) , Thinning391 ) ) , temp_cast_10 ) * frac( ( sin( dotResult2_g1330 ) * 43758.55 ) ) * temp_output_24_14_g1329 ) + ( min( ( pow( saturate( ( 0.5 / ( ( 1.0 - dotResult28_g1320 ) * pow( Sharp387 , 3.0 ) ) ) ) , ( 1.0 / Bloom388 ) ) * step( distance( distance( temp_output_110_0_g1320 , float3( 0,0,0 ) ) , Size120_g1320 ) , CutLevel389 ) * lerpResult69_g1320 * step( frac( ( sin( dotResult10_g1321 ) * 4378.55 ) ) , Thinning391 ) ) , temp_cast_14 ) * frac( ( sin( dotResult2_g1321 ) * 43758.55 ) ) * temp_output_24_14_g1320 ) ) * _Brightness * pow( ( 1.0 - (0.0 + (result341_g436.w - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ) , _LargeNoise ) * (( _StarHorizonGradation )?( saturate( ( 1.0 - pow( saturate( ( i.viewDir.y + 1.0 + _StarHorizonGradationOffset ) ) , _StarHorizonGradationSharpness ) ) ) ):( 1.0 )) ) + ( ( (0.0 + (result341_g499.w - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) + (0.0 + (result341_g508.w - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ) * _Fog ) + ( _BloomColor * ( 0.01 / ( ( 1.0 - saturate( dotResult566 ) ) * _MoonBloomSharpness ) ) ) ) ) , ( tex2DNode601 * _MoonColor ) , ( ceil( dotResult566 ) * tex2DNode601.a ));
			o.Emission = lerpResult604.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;-1057;1920;998;-1364.533;-757.0544;1;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;565;768,2976;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;606;928,2976;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;607;1072,2928;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;589;944,3088;Inherit;False;Property;_HorizontalAngle;HorizontalAngle;28;0;Create;True;0;0;0;False;0;False;0;1.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;605;1200,2928;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;610;1376,2928;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;476;1436.24,950.0647;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.AbsOpNode;482;1660.24,1078.065;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;609;1504,2976;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;491;1484.24,1142.065;Inherit;False;Property;_LimitBottomColor;LimitBottomColor;19;0;Create;True;0;0;0;False;0;False;0;0.653;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;612;1632,2976;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleDivideOpNode;488;1772.24,1078.065;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;591;1648,3088;Inherit;False;Property;_VerticalAngle;VerticalAngle;29;0;Create;True;0;0;0;False;0;False;0;0.38;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;494;1852.24,1174.065;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;150;1616,1728;Inherit;False;1548.081;524.7574;LargeNoise;21;115;355;356;354;101;93;108;90;106;105;95;163;102;98;99;89;103;94;100;92;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;490;1884.24,1078.065;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;619;-401.0674,14.93262;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;613;1760,2976;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;620;-160,16;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;115;1632,1920;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;356;1664,2064;Float;False;Property;_FogSize;FogSize;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;493;2028.24,1110.065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;354;1824,1792;Float;False;Property;_LargeNoiseSize;LargeNoiseSize;6;0;Create;True;0;0;0;False;0;False;1.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;611;1888,2976;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;627;-208,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;651;1833,1393;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;661;1721,1537;Inherit;False;Property;_StarHorizonGradationOffset;StarHorizonGradationOffset;22;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;626;-32,-16;Inherit;False;Property;_HorizontalMirror;HorizontalMirror;24;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;2064,1776;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CosOpNode;495;2156.24,1110.065;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;615;2032,2832;Inherit;False;Constant;_Vector0;Vector 0;23;0;Create;True;0;0;0;False;0;False;-1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;614;2064,2976;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;355;1872,1936;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;657;2048,1472;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;256,160;Float;False;Property;_Size;Size;1;0;Create;True;0;0;0;False;0;False;10;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;642;2016,1008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;443;128,688;Float;False;Property;_BrightnessMax;BrightnessMax;14;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;363;160,752;Float;False;Property;_CentorColor;CentorColor;11;0;Create;True;0;0;0;False;0;False;0.998112,1,0.941,0;0.9959906,1,0.9198113,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;189;144,432;Float;False;Property;_CutLevel;CutLevel;5;0;Create;True;0;0;0;False;0;False;0;0.346;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;100;2192,1776;Inherit;False;SimplexNoise3D;-1;;436;3623647b3cf802348bfe329aa32e5b8c;0;1;340;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;662;2208,1472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;144,368;Float;False;Property;_Bloom;Bloom;4;0;Create;True;0;0;0;False;0;False;1;0.768;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;240,304;Float;False;Property;_Sharp;Sharp;2;0;Create;True;0;0;0;False;0;False;10;180;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;376;144,560;Float;False;Property;_Thinning;Thinning;12;0;Create;True;0;0;0;False;0;False;0;0.299;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;659;2048,1584;Inherit;False;Property;_StarHorizonGradationSharpness;StarHorizonGradationSharpness;23;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;2064,2080;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;3,3,3;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;485;2236.24,1270.065;Inherit;False;Property;_GradationSharpness;GradationSharpness;18;0;Create;True;0;0;0;False;0;False;0;0.038;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;385;416,176;Float;False;Size;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;616;2304,3168;Inherit;False;Property;_MoonSize;MoonSize;27;0;Create;True;0;0;0;False;0;False;5;39.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;600;2256,3104;Inherit;False;False;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;566;2256,2896;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;128,240;Float;False;Property;_Noise;Noise;3;0;Create;True;0;0;0;False;0;False;0;0.455;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;621;240,48;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;496;2316.24,1110.065;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;362;144,496;Float;False;Property;_ColorShiftLevel;ColorShiftLevel;10;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;88;2192,1936;Inherit;False;SimplexNoise3D;-1;;499;3623647b3cf802348bfe329aa32e5b8c;0;1;340;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;103;2400,1776;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;645;2144,1008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;622;416,112;Float;False;ViewDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;391;416,560;Float;False;Thinning;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;92;2192,2080;Inherit;False;SimplexNoise3D;-1;;508;3623647b3cf802348bfe329aa32e5b8c;0;1;340;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;448,1568;Inherit;False;385;Size;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;394;448,896;Inherit;False;385;Size;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;388;416,368;Float;False;Bloom;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;390;416,496;Float;False;ClolrShiftLevel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;417;448,2240;Inherit;False;385;Size;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;603;2464,3104;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;567;2384,2896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;387;416,304;Float;False;Sharp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;386;416,240;Float;False;Noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;393;416,752;Float;False;CentorColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;389;416,432;Float;False;CutLevel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;654;2368,1472;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;444;416,688;Float;False;Brightness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;484;2524.24,1174.065;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;414;448,1968;Inherit;False;391;Thinning;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;411;432,2096;Inherit;False;393;CentorColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;448,1088;Inherit;False;388;Bloom;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;424;448,2496;Inherit;False;389;CutLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;400;416,1216;Inherit;False;390;ClolrShiftLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;423;416,2560;Inherit;False;390;ClolrShiftLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;408;448,1632;Inherit;False;386;Noise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;448,1024;Inherit;False;387;Sharp;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;625;448,2176;Inherit;False;622;ViewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;426;448,2368;Inherit;False;387;Sharp;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;448,1504;Inherit;False;622;ViewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;94;2400,2080;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;403;432,1408;Inherit;False;393;CentorColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;89;2400,1936;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;446;432,2032;Inherit;False;444;Brightness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;422;432,2752;Inherit;False;393;CentorColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;421;624,2256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;420;448,2432;Inherit;False;388;Bloom;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;409;448,1776;Inherit;False;388;Bloom;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;602;2592,3104;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;1,-1;False;2;FLOAT2;-1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;623;448,832;Inherit;False;622;ViewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;568;2512,2896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;569;2416,2976;Inherit;False;Property;_MoonBloomSharpness;MoonBloomSharpness;31;0;Create;True;0;0;0;False;0;False;20;95.74;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;425;448,2624;Inherit;False;391;Thinning;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;396;448,960;Inherit;False;386;Noise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;656;2507,1473;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;415;448,1712;Inherit;False;387;Sharp;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;447;432,2688;Inherit;False;444;Brightness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;650;2700.24,982.0647;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;430;624,1584;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;413;448,1840;Inherit;False;389;CutLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;412;416,1904;Inherit;False;390;ClolrShiftLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;399;448,1152;Inherit;False;389;CutLevel;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;445;432,1344;Inherit;False;444;Brightness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;419;448,2304;Inherit;False;386;Noise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;405;624,912;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;102;2640,1776;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;401;448,1280;Inherit;False;391;Thinning;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;570;2672,2896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;631;960,2416;Inherit;False;3DStar;-1;;1320;cc687007379137f48a257086552e4a9a;0;11;101;FLOAT3;0,0,0;False;57;FLOAT;0;False;60;FLOAT;0;False;61;FLOAT;0;False;62;FLOAT;0;False;63;FLOAT;0;False;70;FLOAT;1;False;84;FLOAT;0.5;False;88;FLOAT;0;False;96;FLOAT;1;False;68;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;106;2816,1840;Float;False;Property;_LargeNoise;LargeNoise;7;0;Create;True;0;0;0;False;0;False;0.7882353;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;629;944,1072;Inherit;False;3DStar;-1;;1311;cc687007379137f48a257086552e4a9a;0;11;101;FLOAT3;0,0,0;False;57;FLOAT;0;False;60;FLOAT;0;False;61;FLOAT;0;False;62;FLOAT;0;False;63;FLOAT;0;False;70;FLOAT;1;False;84;FLOAT;0.5;False;88;FLOAT;0;False;96;FLOAT;1;False;68;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;571;2640,2816;Inherit;False;Constant;_Float15;Float 15;14;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;648;2844.24,982.0647;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;617;2768,3104;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCRemapNode;98;2640,1936;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;630;960,1728;Inherit;False;3DStar;-1;;1329;cc687007379137f48a257086552e4a9a;0;11;101;FLOAT3;0,0,0;False;57;FLOAT;0;False;60;FLOAT;0;False;61;FLOAT;0;False;62;FLOAT;0;False;63;FLOAT;0;False;70;FLOAT;1;False;84;FLOAT;0.5;False;88;FLOAT;0;False;96;FLOAT;1;False;68;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;99;2640,2096;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;660;2656,1472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;497;2844.24,1174.065;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;632;928,368;Inherit;False;3DStar;-1;;1338;cc687007379137f48a257086552e4a9a;0;11;101;FLOAT3;0,0,0;False;57;FLOAT;0;False;60;FLOAT;0;False;61;FLOAT;0;False;62;FLOAT;0;False;63;FLOAT;0;False;70;FLOAT;1;False;84;FLOAT;0.5;False;88;FLOAT;0;False;96;FLOAT;1;False;68;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;105;2832,1776;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;2864,1968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;658;2832,1408;Inherit;False;Property;_StarHorizonGradation;StarHorizonGradation;21;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;562;2961,1264;Inherit;False;Property;_Brightness;Brightness;15;0;Create;True;0;0;0;False;0;False;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;1520,1328;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;87;2976,672;Float;False;Property;_BackGroundColorBottom;BackGroundColorBottom;16;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2117646,0.5635324,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;480;3008,848;Float;False;Property;_BackGroundColorTop;BackGroundColorTop;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.01333566,0,0.1132074,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;666;2736,2640;Inherit;False;Property;_BloomColor;BloomColor;30;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;649;3004.24,1062.065;Inherit;False;Property;_GradationMirror;GradationMirror;20;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;572;2816,2864;Inherit;False;2;0;FLOAT;0.01;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;618;2896,3104;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;640;2368,3024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;108;3008,1792;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;2816,2144;Float;False;Property;_Fog;Fog;9;0;Create;True;0;0;0;False;0;False;0;0.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;3008,1984;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.002;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;479;3296,832;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;641;2464,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;3248,1328;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;635;3024,3104;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;665;3008,2752;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;601;3168,3104;Inherit;True;Property;_MoonTexture;MoonTexture;25;0;Create;True;0;0;0;False;0;False;-1;None;4f249c20dcfc3d542a25d571cfb544a9;True;0;False;black;Auto;False;Object;-1;MipBias;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;-1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;638;3152,3024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;86;3504,1312;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;663;3248,3296;Inherit;False;Property;_MoonColor;MoonColor;26;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;628;3632,1312;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;639;3504,3024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;664;3524.086,3197.617;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;380;240,624;Float;False;Property;_Rotate;Rotate;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;392;416,624;Float;False;Rotate;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;604;3792,1312;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;477;3952,1264;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;uniuni/UniStar;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Background;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;606;0;565;0
WireConnection;607;0;606;0
WireConnection;607;1;606;2
WireConnection;605;0;607;0
WireConnection;605;2;589;0
WireConnection;610;0;605;0
WireConnection;482;0;476;2
WireConnection;609;0;610;0
WireConnection;609;1;606;1
WireConnection;609;2;610;1
WireConnection;612;0;609;0
WireConnection;488;0;482;0
WireConnection;488;1;491;0
WireConnection;490;0;488;0
WireConnection;613;0;612;0
WireConnection;613;1;612;1
WireConnection;620;0;619;2
WireConnection;493;0;490;0
WireConnection;493;1;494;0
WireConnection;611;0;613;0
WireConnection;611;2;591;0
WireConnection;627;0;619;2
WireConnection;626;0;627;0
WireConnection;626;1;620;0
WireConnection;101;0;115;0
WireConnection;101;1;354;0
WireConnection;495;0;493;0
WireConnection;614;0;611;0
WireConnection;614;2;612;2
WireConnection;355;0;115;0
WireConnection;355;1;356;0
WireConnection;657;0;651;2
WireConnection;657;2;661;0
WireConnection;642;0;476;2
WireConnection;100;340;101;0
WireConnection;662;0;657;0
WireConnection;93;0;355;0
WireConnection;385;0;4;0
WireConnection;600;0;614;0
WireConnection;566;0;615;0
WireConnection;566;1;614;0
WireConnection;621;0;619;1
WireConnection;621;1;626;0
WireConnection;621;2;619;3
WireConnection;496;0;495;0
WireConnection;88;340;355;0
WireConnection;103;0;100;0
WireConnection;645;0;642;0
WireConnection;622;0;621;0
WireConnection;391;0;376;0
WireConnection;92;340;93;0
WireConnection;388;0;58;0
WireConnection;390;0;362;0
WireConnection;603;0;600;0
WireConnection;603;1;616;0
WireConnection;567;0;566;0
WireConnection;387;0;13;0
WireConnection;386;0;49;0
WireConnection;393;0;363;0
WireConnection;389;0;189;0
WireConnection;654;0;662;0
WireConnection;654;1;659;0
WireConnection;444;0;443;0
WireConnection;484;0;496;0
WireConnection;484;1;485;0
WireConnection;94;0;92;0
WireConnection;89;0;88;0
WireConnection;421;0;417;0
WireConnection;602;0;603;0
WireConnection;568;0;567;0
WireConnection;656;0;654;0
WireConnection;650;0;484;0
WireConnection;650;1;645;0
WireConnection;430;0;406;0
WireConnection;405;0;394;0
WireConnection;102;0;103;3
WireConnection;570;0;568;0
WireConnection;570;1;569;0
WireConnection;631;101;625;0
WireConnection;631;57;421;0
WireConnection;631;60;419;0
WireConnection;631;61;426;0
WireConnection;631;62;420;0
WireConnection;631;63;424;0
WireConnection;631;70;423;0
WireConnection;631;84;425;0
WireConnection;631;96;447;0
WireConnection;631;68;422;0
WireConnection;629;101;623;0
WireConnection;629;57;405;0
WireConnection;629;60;396;0
WireConnection;629;61;397;0
WireConnection;629;62;398;0
WireConnection;629;63;399;0
WireConnection;629;70;400;0
WireConnection;629;84;401;0
WireConnection;629;96;445;0
WireConnection;629;68;403;0
WireConnection;648;0;650;0
WireConnection;617;0;602;0
WireConnection;98;0;89;3
WireConnection;630;101;624;0
WireConnection;630;57;430;0
WireConnection;630;60;408;0
WireConnection;630;61;415;0
WireConnection;630;62;409;0
WireConnection;630;63;413;0
WireConnection;630;70;412;0
WireConnection;630;84;414;0
WireConnection;630;96;446;0
WireConnection;630;68;411;0
WireConnection;99;0;94;3
WireConnection;660;0;656;0
WireConnection;497;0;484;0
WireConnection;632;101;622;0
WireConnection;632;57;385;0
WireConnection;632;60;386;0
WireConnection;632;61;387;0
WireConnection;632;62;388;0
WireConnection;632;63;389;0
WireConnection;632;70;390;0
WireConnection;632;84;391;0
WireConnection;632;96;444;0
WireConnection;632;68;393;0
WireConnection;105;0;102;0
WireConnection;95;0;98;0
WireConnection;95;1;99;0
WireConnection;658;1;660;0
WireConnection;273;0;632;0
WireConnection;273;1;629;0
WireConnection;273;2;630;0
WireConnection;273;3;631;0
WireConnection;649;0;648;0
WireConnection;649;1;497;0
WireConnection;572;0;571;0
WireConnection;572;1;570;0
WireConnection;618;0;617;1
WireConnection;618;1;617;0
WireConnection;640;0;566;0
WireConnection;108;0;105;0
WireConnection;108;1;106;0
WireConnection;90;0;95;0
WireConnection;90;1;163;0
WireConnection;479;0;87;0
WireConnection;479;1;480;0
WireConnection;479;2;649;0
WireConnection;641;0;640;0
WireConnection;107;0;273;0
WireConnection;107;1;562;0
WireConnection;107;2;108;0
WireConnection;107;3;658;0
WireConnection;635;0;618;0
WireConnection;665;0;666;0
WireConnection;665;1;572;0
WireConnection;601;1;635;0
WireConnection;638;0;641;0
WireConnection;86;0;479;0
WireConnection;86;1;107;0
WireConnection;86;2;90;0
WireConnection;86;3;665;0
WireConnection;628;0;86;0
WireConnection;639;0;638;0
WireConnection;639;1;601;4
WireConnection;664;0;601;0
WireConnection;664;1;663;0
WireConnection;392;0;380;0
WireConnection;604;0;628;0
WireConnection;604;1;664;0
WireConnection;604;2;639;0
WireConnection;477;2;604;0
ASEEND*/
//CHKSM=FC5ECF4E25BB62BD134033E9CBC3B9C9E3BF37DD