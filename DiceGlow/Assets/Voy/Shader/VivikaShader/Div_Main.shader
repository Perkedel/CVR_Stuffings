// Made with Amplify Shader Editor v1.9.3.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VoyVivika/VivikaShader"
{
	Properties
	{
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		_MinBrightness("Min Brightness", Range( 0 , 1)) = 0
		_IndirectDiffuseOffset("Indirect Light Min", Range( 0 , 1)) = 0
		[ToggleUI]_IndirLightUseMinforMax("Use Min for Max", Float) = 1
		_IndirectDiffuseOffsetMax("Indirect Light Max", Range( 0 , 1)) = 0
		_WrappedShadingValue("Wrapped Shading Value", Float) = 1
		_WrapIndirScale("Indirect Light Scale", Float) = 3
		_Albedo("Albedo", 2D) = "black" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		[SingleLineTexture]_MetallicGlossMap("Unity Metallic", 2D) = "white" {}
		_WrapMetallicFesnelScale("Metallic Fesnel Scale", Float) = 1
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_AOStrength("AO Strength", Range( 0 , 1)) = 1
		[ToggleUI]_RealAO("Real AO", Float) = 0
		[Header(AudioLink)][ToggleUI]_EnableAudioLink("Enable AudioLink", Range( 0 , 1)) = 0
		_AL_Mask("AudioLink Mask", 2D) = "black" {}
		[ToggleUI]_ALEmitifInactive("AL Emit if Inactive", Float) = 1
		[SingleLineTexture]_ALDelayMap("AudioLink Delay Tex Map", 2D) = "black" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,Screen Space,8)]_ALDelayUVMap("AL Delay UV Map", Float) = 2
		_ALUVDelayMaxDelay("AL UV Delay Max Delay", Range( 0 , 127)) = 0
		_ALTimeScale("AL HueShift Time Scale", Float) = 0
		_Emission("Emission", 2D) = "black" {}
		_EmissionStrength("Emission Strength", Range( 0 , 1)) = 0
		[ToggleUI]_EnableRimLighting("Enable Rim Lighting", Range( 0 , 1)) = 1
		_RimPower("Rim Power", Range( 0 , 10)) = 2.07
		_RimEnergy("Rim Energy", Range( 0 , 1)) = 0.345
		_RimBaseColorStrength("Rim Base Color Strength", Range( 0 , 1)) = 1
		[Header(UV Tile Discarding)][Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_DiscardUVMap("Discard UV Map", Float) = 1
		[ToggleUI]_DiscardUVTile00("Discard UV Tile 0,0", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile01("Discard UV Tile 0,1", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile02("Discard UV Tile 0,2", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile03("Discard UV Tile 0,3", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile10("Discard UV Tile 1,0", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile11("Discard UV Tile 1,1", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile12("Discard UV Tile 1,2", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile13("Discard UV Tile 1,3", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile20("Discard UV Tile 2,0", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile21("Discard UV Tile 2,1", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile22("Discard UV Tile 2,2", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile23("Discard UV Tile 2,3", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile31("Discard UV Tile 3,1", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile30("Discard UV Tile 3,0", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile32("Discard UV Tile 3,2", Range( 0 , 1)) = 0
		[ToggleUI]_DiscardUVTile33("Discard UV Tile 3,3", Range( 0 , 1)) = 0
		[Header(Standard Fallbacks)][SingleLineTexture]_MainTex("Fallback Albedo", 2D) = "white" {}
		_Color("Fallback Color", Color) = (1,1,1,0)
		[SingleLineTexture]_EmissionMap("Fallback Emission Map", 2D) = "white" {}
		_EmissionColor("Fallback Emission Color", Color) = (0,0,0,0)
		[SingleLineTexture]_BumpMap("Fallback Normal Map", 2D) = "bump" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "VRCFallback"="DoubleSided" }
		Cull [_CullMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#include "Libs\AudioLink\AudioLink.cginc"
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float2 uv3_texcoord3;
			float2 uv4_texcoord4;
			float4 screenPos;
			float3 worldPos;
			half3 worldNormal;
			INTERNAL_DATA
			half3 worldRefl;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _EmissionMap;
		uniform sampler2D _MainTex;
		uniform half4 _EmissionColor;
		uniform half4 _Color;
		uniform sampler2D _BumpMap;
		uniform half _CullMode;
		uniform half _DiscardUVTile00;
		uniform half _DiscardUVMap;
		uniform half _DiscardUVTile01;
		uniform half _DiscardUVTile02;
		uniform half _DiscardUVTile03;
		uniform half _DiscardUVTile10;
		uniform half _DiscardUVTile11;
		uniform half _DiscardUVTile12;
		uniform half _DiscardUVTile13;
		uniform half _DiscardUVTile20;
		uniform half _DiscardUVTile21;
		uniform half _DiscardUVTile22;
		uniform half _DiscardUVTile23;
		uniform half _DiscardUVTile30;
		uniform half _DiscardUVTile31;
		uniform half _DiscardUVTile32;
		uniform half _DiscardUVTile33;
		uniform sampler2D _Albedo;
		uniform half4 _Albedo_ST;
		uniform sampler2D _AmbientOcclusion;
		uniform half4 _AmbientOcclusion_ST;
		uniform half _AOStrength;
		uniform half _RealAO;
		uniform half _EnableAudioLink;
		uniform sampler2D _AL_Mask;
		uniform half4 _AL_Mask_ST;
		uniform half _ALTimeScale;
		uniform sampler2D _ALDelayMap;
		uniform half _ALDelayUVMap;
		uniform half _ALUVDelayMaxDelay;
		uniform half _ALEmitifInactive;
		uniform sampler2D _Emission;
		uniform half4 _Emission_ST;
		uniform half _EmissionStrength;
		uniform half _EnableRimLighting;
		uniform sampler2D _NormalMap;
		uniform half4 _NormalMap_ST;
		uniform float _RimPower;
		uniform half _RimEnergy;
		uniform half _RimBaseColorStrength;
		uniform half _IndirectDiffuseOffsetMax;
		uniform half _IndirectDiffuseOffset;
		uniform half _IndirLightUseMinforMax;
		uniform half _WrappedShadingValue;
		uniform half _WrapIndirScale;
		uniform half _MinBrightness;
		uniform sampler2D _MetallicGlossMap;
		uniform half4 _MetallicGlossMap_ST;
		uniform half _WrapMetallicFesnelScale;


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

		inline half AudioLinkData3_g527( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		half IfAudioLinkv2Exists1_g534(  )
		{
			int w = 0; 
			int h; 
			int res = 0;
			#ifndef SHADER_TARGET_SURFACE_ANALYSIS
			_AudioTexture.GetDimensions(w, h); 
			#endif
			if (w == 128) res = 1;
			return res;
		}


		inline half AudioLinkData3_g532( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline half AudioLinkData3_g531( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline half AudioLinkData3_g533( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		half IfAudioLinkv2Exists1_g540(  )
		{
			int w = 0; 
			int h; 
			int res = 0;
			#ifndef SHADER_TARGET_SURFACE_ANALYSIS
			_AudioTexture.GetDimensions(w, h); 
			#endif
			if (w == 128) res = 1;
			return res;
		}


		half3 ShadeSH92384( half4 Normal )
		{
			return ShadeSH9(Normal);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half2 break63_g555 = floor( half2( 0,0 ) );
			half temp_output_8_0_g538 = 0.0;
			half discUVset2314 = _DiscardUVMap;
			half temp_output_7_0_g538 = discUVset2314;
			half2 lerpResult6_g538 = lerp( half2( 0,0 ) , v.texcoord.xy , ( step( temp_output_8_0_g538 , temp_output_7_0_g538 ) * step( temp_output_7_0_g538 , temp_output_8_0_g538 ) ));
			half temp_output_8_0_g535 = 1.0;
			half temp_output_7_0_g535 = discUVset2314;
			half2 lerpResult6_g535 = lerp( half2( 0,0 ) , v.texcoord1.xy , ( step( temp_output_8_0_g535 , temp_output_7_0_g535 ) * step( temp_output_7_0_g535 , temp_output_8_0_g535 ) ));
			half temp_output_8_0_g536 = 2.0;
			half temp_output_7_0_g536 = discUVset2314;
			half2 lerpResult6_g536 = lerp( half2( 0,0 ) , v.texcoord2.xy , ( step( temp_output_8_0_g536 , temp_output_7_0_g536 ) * step( temp_output_7_0_g536 , temp_output_8_0_g536 ) ));
			half temp_output_8_0_g537 = 3.0;
			half temp_output_7_0_g537 = discUVset2314;
			half2 lerpResult6_g537 = lerp( half2( 0,0 ) , v.texcoord3.xy , ( step( temp_output_8_0_g537 , temp_output_7_0_g537 ) * step( temp_output_7_0_g537 , temp_output_8_0_g537 ) ));
			half2 DiscardUV200 = ( lerpResult6_g538 + lerpResult6_g535 + lerpResult6_g536 + lerpResult6_g537 );
			half2 break61_g555 = DiscardUV200;
			half2 break63_g554 = floor( half2( 0,1 ) );
			half2 break61_g554 = DiscardUV200;
			half2 break63_g553 = floor( half2( 0,2 ) );
			half2 break61_g553 = DiscardUV200;
			half2 break63_g552 = floor( half2( 0,3 ) );
			half2 break61_g552 = DiscardUV200;
			half2 break63_g556 = floor( half2( 1,0 ) );
			half2 break61_g556 = DiscardUV200;
			half2 break63_g549 = floor( half2( 1,1 ) );
			half2 break61_g549 = DiscardUV200;
			half2 break63_g550 = floor( half2( 1,2 ) );
			half2 break61_g550 = DiscardUV200;
			half2 break63_g551 = floor( half2( 1,3 ) );
			half2 break61_g551 = DiscardUV200;
			half2 break63_g548 = floor( half2( 2,0 ) );
			half2 break61_g548 = DiscardUV200;
			half2 break63_g547 = floor( half2( 2,1 ) );
			half2 break61_g547 = DiscardUV200;
			half2 break63_g546 = floor( half2( 2,2 ) );
			half2 break61_g546 = DiscardUV200;
			half2 break63_g545 = floor( half2( 2,3 ) );
			half2 break61_g545 = DiscardUV200;
			half2 break63_g541 = floor( half2( 3,0 ) );
			half2 break61_g541 = DiscardUV200;
			half2 break63_g542 = floor( half2( 3,1 ) );
			half2 break61_g542 = DiscardUV200;
			half2 break63_g543 = floor( half2( 3,2 ) );
			half2 break61_g543 = DiscardUV200;
			half2 break63_g544 = floor( half2( 3,3 ) );
			half2 break61_g544 = DiscardUV200;
			half UVTileDiscard192 = ( step( 1.0 , ( ( ( saturate( _DiscardUVTile00 ) * saturate( ( step( break63_g555.x , break61_g555.x ) * step( break61_g555.x , ( break63_g555.x + 0.9999999 ) ) * step( break63_g555.y , break61_g555.y ) * step( break61_g555.y , ( break63_g555.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile01 ) * saturate( ( step( break63_g554.x , break61_g554.x ) * step( break61_g554.x , ( break63_g554.x + 0.9999999 ) ) * step( break63_g554.y , break61_g554.y ) * step( break61_g554.y , ( break63_g554.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile02 ) * saturate( ( step( break63_g553.x , break61_g553.x ) * step( break61_g553.x , ( break63_g553.x + 0.9999999 ) ) * step( break63_g553.y , break61_g553.y ) * step( break61_g553.y , ( break63_g553.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile03 ) * saturate( ( step( break63_g552.x , break61_g552.x ) * step( break61_g552.x , ( break63_g552.x + 0.9999999 ) ) * step( break63_g552.y , break61_g552.y ) * step( break61_g552.y , ( break63_g552.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile10 ) * saturate( ( step( break63_g556.x , break61_g556.x ) * step( break61_g556.x , ( break63_g556.x + 0.9999999 ) ) * step( break63_g556.y , break61_g556.y ) * step( break61_g556.y , ( break63_g556.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile11 ) * saturate( ( step( break63_g549.x , break61_g549.x ) * step( break61_g549.x , ( break63_g549.x + 0.9999999 ) ) * step( break63_g549.y , break61_g549.y ) * step( break61_g549.y , ( break63_g549.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile12 ) * saturate( ( step( break63_g550.x , break61_g550.x ) * step( break61_g550.x , ( break63_g550.x + 0.9999999 ) ) * step( break63_g550.y , break61_g550.y ) * step( break61_g550.y , ( break63_g550.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile13 ) * saturate( ( step( break63_g551.x , break61_g551.x ) * step( break61_g551.x , ( break63_g551.x + 0.9999999 ) ) * step( break63_g551.y , break61_g551.y ) * step( break61_g551.y , ( break63_g551.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile20 ) * saturate( ( step( break63_g548.x , break61_g548.x ) * step( break61_g548.x , ( break63_g548.x + 0.9999999 ) ) * step( break63_g548.y , break61_g548.y ) * step( break61_g548.y , ( break63_g548.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile21 ) * saturate( ( step( break63_g547.x , break61_g547.x ) * step( break61_g547.x , ( break63_g547.x + 0.9999999 ) ) * step( break63_g547.y , break61_g547.y ) * step( break61_g547.y , ( break63_g547.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile22 ) * saturate( ( step( break63_g546.x , break61_g546.x ) * step( break61_g546.x , ( break63_g546.x + 0.9999999 ) ) * step( break63_g546.y , break61_g546.y ) * step( break61_g546.y , ( break63_g546.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile23 ) * saturate( ( step( break63_g545.x , break61_g545.x ) * step( break61_g545.x , ( break63_g545.x + 0.9999999 ) ) * step( break63_g545.y , break61_g545.y ) * step( break61_g545.y , ( break63_g545.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile30 ) * saturate( ( step( break63_g541.x , break61_g541.x ) * step( break61_g541.x , ( break63_g541.x + 0.9999999 ) ) * step( break63_g541.y , break61_g541.y ) * step( break61_g541.y , ( break63_g541.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile31 ) * saturate( ( step( break63_g542.x , break61_g542.x ) * step( break61_g542.x , ( break63_g542.x + 0.9999999 ) ) * step( break63_g542.y , break61_g542.y ) * step( break61_g542.y , ( break63_g542.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile32 ) * saturate( ( step( break63_g543.x , break61_g543.x ) * step( break61_g543.x , ( break63_g543.x + 0.9999999 ) ) * step( break63_g543.y , break61_g543.y ) * step( break61_g543.y , ( break63_g543.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile33 ) * saturate( ( step( break63_g544.x , break61_g544.x ) * step( break61_g544.x , ( break63_g544.x + 0.9999999 ) ) * step( break63_g544.y , break61_g544.y ) * step( break61_g544.y , ( break63_g544.y + 0.9999999 ) ) ) ) ) ) ) ) == 1.0 ? ( 0.0 / 0.0 ) : 0.0 );
			half3 temp_cast_0 = (UVTileDiscard192).xxx;
			v.vertex.xyz += temp_cast_0;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			half3 ase_worldlightDir = 0;
			#else //aseld
			half3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			half3 normalMap1002 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			half dotResult1206 = dot( ase_worldlightDir , (WorldNormalVector( i , normalMap1002 )) );
			half NdotL1254 = dotResult1206;
			half NdotLSaturated2266 = saturate( NdotL1254 );
			half wrap1209 = _WrappedShadingValue;
			half DiffWrapStep11229 = saturate( exp2( ( ( NdotLSaturated2266 + wrap1209 ) / ( 1.0 + wrap1209 ) ) ) );
			half temp_output_2255_0 = saturate( ase_lightAtten );
			half4 color1362 = IsGammaSpace() ? half4(0,0,0,0) : half4(0,0,0,0);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			half4 ase_lightColor = 0;
			#else //aselc
			half4 ase_lightColor = _LightColor0;
			#endif //aselc
			half4 lerpResult1356 = lerp( color1362 , saturate( ase_lightColor ) , temp_output_2255_0);
			UnityGI gi1348 = gi;
			float3 diffNorm1348 = normalize( WorldNormalVector( i , normalMap1002 ) );
			gi1348 = UnityGI_Base( data, 1, diffNorm1348 );
			half3 indirectDiffuse1348 = gi1348.indirect.diffuse + diffNorm1348 * 0.0001;
			half4 appendResult2408 = (half4(( normalMap1002 * 0.3 ) , 1.0));
			half4 Normal2384 = appendResult2408;
			half3 localShadeSH92384 = ShadeSH92384( Normal2384 );
			half3 temp_cast_18 = (_IndirectDiffuseOffset).xxx;
			half temp_output_8_0_g523 = 1.0;
			half temp_output_7_0_g523 = _IndirLightUseMinforMax;
			half lerpResult6_g523 = lerp( _IndirectDiffuseOffsetMax , _IndirectDiffuseOffset , ( step( temp_output_8_0_g523 , temp_output_7_0_g523 ) * step( temp_output_7_0_g523 , temp_output_8_0_g523 ) ));
			half3 temp_output_2393_0 = saturate( ( localShadeSH92384 + lerpResult6_g523 ) );
			half3 clampResult2396 = clamp( indirectDiffuse1348 , saturate( ( localShadeSH92384 - temp_cast_18 ) ) , temp_output_2393_0 );
			half4 color2551 = IsGammaSpace() ? half4(1,1,1,1) : half4(1,1,1,1);
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			half4 temp_output_2545_0 = ( 1.0 - ( ( 1.0 - tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) ) * _AOStrength ) );
			half4 lerpResult2549 = lerp( color2551 , temp_output_2545_0 , _RealAO);
			half4 ao_times_strength2546 = lerpResult2549;
			half4 indirDiffuse2394 = ( half4( clampResult2396 , 0.0 ) * ao_times_strength2546 );
			half4 temp_cast_20 = (1.0).xxxx;
			half4 temp_cast_21 = (_MinBrightness).xxxx;
			half4 color2383 = IsGammaSpace() ? half4(1,1,1,1) : half4(1,1,1,1);
			half4 clampResult2381 = clamp( saturate( ( saturate( ( DiffWrapStep11229 + saturate( exp2( temp_output_2255_0 ) ) ) ) * saturate( ( saturate( lerpResult1356 ) + saturate( (saturate( ( exp2( saturate( indirDiffuse2394 ) ) - temp_cast_20 ) )*_WrapIndirScale + 0.0) ) ) ) ) ) , temp_cast_21 , color2383 );
			half4 DiffWrapLighting1363 = clampResult2381;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			half4 lerpResult2553 = lerp( temp_output_2545_0 , color2551 , _RealAO);
			half4 mainTex26 = ( tex2D( _Albedo, uv_Albedo ) * lerpResult2553 );
			float3 indirectNormal1410 = normalize( WorldNormalVector( i , normalize( WorldReflectionVector( i , normalMap1002 ) ) ) );
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			half4 tex2DNode1017 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			half _Smoothness755 = tex2DNode1017.a;
			Unity_GlossyEnvironmentData g1410 = UnityGlossyEnvironmentSetup( _Smoothness755, data.worldViewDir, indirectNormal1410, float3(0,0,0));
			half3 indirectSpecular1410 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal1410, g1410 );
			half3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half fresnelNdotV1393 = dot( normalize( normalize( (WorldNormalVector( i , normalMap1002 )) ) ), ase_worldViewDir );
			half fresnelNode1393 = ( 0.0 + _WrapMetallicFesnelScale * pow( max( 1.0 - fresnelNdotV1393 , 0.0001 ), 3.0 ) );
			half _Metalic753 = tex2DNode1017.r;
			half lerpResult1405 = lerp( fresnelNode1393 , 1.0 , _Metalic753);
			half4 AvatarColor1289 = ( mainTex26 + half4( ( indirectSpecular1410 * lerpResult1405 ) , 0.0 ) );
			half4 Lighting_Wrapped1144 = ( DiffWrapLighting1363 * AvatarColor1289 );
			c.rgb = Lighting_Wrapped1144.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			half4 temp_output_2545_0 = ( 1.0 - ( ( 1.0 - tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) ) * _AOStrength ) );
			half4 color2551 = IsGammaSpace() ? half4(1,1,1,1) : half4(1,1,1,1);
			half4 lerpResult2553 = lerp( temp_output_2545_0 , color2551 , _RealAO);
			half4 mainTex26 = ( tex2D( _Albedo, uv_Albedo ) * lerpResult2553 );
			o.Albedo = mainTex26.rgb;
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			half4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			half4 color42 = IsGammaSpace() ? half4(1,0,0,1) : half4(1,0,0,1);
			float3 hsvTorgb4_g526 = RGBToHSV( color42.rgb );
			half mulTime48 = _Time.y * _ALTimeScale;
			half Time50 = frac( mulTime48 );
			float3 hsvTorgb8_g526 = HSVToRGB( float3(( hsvTorgb4_g526.x + Time50 ),( hsvTorgb4_g526.y + 0.0 ),( hsvTorgb4_g526.z + 0.0 )) );
			half3 temp_output_194_0 = saturate( hsvTorgb8_g526 );
			int Band3_g527 = 0;
			half temp_output_8_0_g470 = 0.0;
			half delayUVset2356 = _ALDelayUVMap;
			half temp_output_7_0_g470 = delayUVset2356;
			half2 lerpResult6_g470 = lerp( half2( 0,0 ) , i.uv_texcoord , ( step( temp_output_8_0_g470 , temp_output_7_0_g470 ) * step( temp_output_7_0_g470 , temp_output_8_0_g470 ) ));
			half temp_output_8_0_g427 = 1.0;
			half temp_output_7_0_g427 = delayUVset2356;
			half2 lerpResult6_g427 = lerp( half2( 0,0 ) , i.uv2_texcoord2 , ( step( temp_output_8_0_g427 , temp_output_7_0_g427 ) * step( temp_output_7_0_g427 , temp_output_8_0_g427 ) ));
			half temp_output_8_0_g428 = 2.0;
			half temp_output_7_0_g428 = delayUVset2356;
			half2 lerpResult6_g428 = lerp( half2( 0,0 ) , i.uv3_texcoord3 , ( step( temp_output_8_0_g428 , temp_output_7_0_g428 ) * step( temp_output_7_0_g428 , temp_output_8_0_g428 ) ));
			half temp_output_8_0_g478 = 3.0;
			half temp_output_7_0_g478 = delayUVset2356;
			half2 lerpResult6_g478 = lerp( half2( 0,0 ) , i.uv4_texcoord4 , ( step( temp_output_8_0_g478 , temp_output_7_0_g478 ) * step( temp_output_7_0_g478 , temp_output_8_0_g478 ) ));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			half2 appendResult2533 = (half2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			half temp_output_8_0_g518 = 8.0;
			half temp_output_7_0_g518 = delayUVset2356;
			half2 lerpResult6_g518 = lerp( half2( 0,0 ) , appendResult2533 , ( step( temp_output_8_0_g518 , temp_output_7_0_g518 ) * step( temp_output_7_0_g518 , temp_output_8_0_g518 ) ));
			half2 DelayUV2355 = ( lerpResult6_g470 + lerpResult6_g427 + lerpResult6_g428 + lerpResult6_g478 + lerpResult6_g518 );
			half3 hsvTorgb2458 = RGBToHSV( tex2D( _ALDelayMap, DelayUV2355 ).rgb );
			half clampResult987 = clamp( (0.0 + (hsvTorgb2458.z - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			half in_ALDelay991 = round( clampResult987 );
			int Delay3_g527 = (int)in_ALDelay991;
			half localAudioLinkData3_g527 = AudioLinkData3_g527( Band3_g527 , Delay3_g527 );
			half temp_output_8_0_g539 = 1.0;
			half localIfAudioLinkv2Exists1_g534 = IfAudioLinkv2Exists1_g534();
			half temp_output_7_0_g539 = localIfAudioLinkv2Exists1_g534;
			half3 lerpResult6_g539 = lerp( temp_output_194_0 , ( temp_output_194_0 * localAudioLinkData3_g527 ) , ( step( temp_output_8_0_g539 , temp_output_7_0_g539 ) * step( temp_output_7_0_g539 , temp_output_8_0_g539 ) ));
			half3 ALC_Bass61 = lerpResult6_g539;
			half4 color44 = IsGammaSpace() ? half4(0,0.8196079,0,1) : half4(0,0.637597,0,1);
			float3 hsvTorgb4_g530 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g530 = HSVToRGB( float3(( hsvTorgb4_g530.x + Time50 ),( hsvTorgb4_g530.y + 0.0 ),( hsvTorgb4_g530.z + 0.0 )) );
			int Band3_g532 = 2;
			int Delay3_g532 = (int)in_ALDelay991;
			half localAudioLinkData3_g532 = AudioLinkData3_g532( Band3_g532 , Delay3_g532 );
			half3 ALC_HighMid67 = ( saturate( hsvTorgb8_g530 ) * localAudioLinkData3_g532 );
			half4 color43 = IsGammaSpace() ? half4(1,0.9294118,0,1) : half4(1,0.8468735,0,1);
			float3 hsvTorgb4_g529 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g529 = HSVToRGB( float3(( hsvTorgb4_g529.x + Time50 ),( hsvTorgb4_g529.y + 0.0 ),( hsvTorgb4_g529.z + 0.0 )) );
			int Band3_g531 = 1;
			int Delay3_g531 = (int)in_ALDelay991;
			half localAudioLinkData3_g531 = AudioLinkData3_g531( Band3_g531 , Delay3_g531 );
			half3 ALC_LowMid64 = ( saturate( hsvTorgb8_g529 ) * localAudioLinkData3_g531 );
			half4 color45 = IsGammaSpace() ? half4(0,0,1,1) : half4(0,0,1,1);
			float3 hsvTorgb4_g528 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g528 = HSVToRGB( float3(( hsvTorgb4_g528.x + Time50 ),( hsvTorgb4_g528.y + 0.0 ),( hsvTorgb4_g528.z + 0.0 )) );
			int Band3_g533 = 3;
			int Delay3_g533 = (int)in_ALDelay991;
			half localAudioLinkData3_g533 = AudioLinkData3_g533( Band3_g533 , Delay3_g533 );
			half3 ALC_Treble70 = ( saturate( hsvTorgb8_g528 ) * localAudioLinkData3_g533 );
			half localIfAudioLinkv2Exists1_g540 = IfAudioLinkv2Exists1_g540();
			half4 AL_Final85 = ( ( _EnableAudioLink * ( ( ALMask39 * half4( ALC_Bass61 , 0.0 ) ) + ( ALMask39 * half4( ALC_HighMid67 , 0.0 ) ) + ( ALMask39 * half4( ALC_LowMid64 , 0.0 ) ) + ( ALMask39 * half4( ALC_Treble70 , 0.0 ) ) ) ) * saturate( ( localIfAudioLinkv2Exists1_g540 + _ALEmitifInactive ) ) );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			half4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionStrength );
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			half3 normalMap1002 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			half fresnelNdotV1402 = dot( (WorldNormalVector( i , normalMap1002 )), ase_worldViewDir );
			half fresnelNode1402 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1402, _RimPower ) );
			half4 lerpResult114 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			half4 ase_lightColor = 0;
			#else //aselc
			half4 ase_lightColor = _LightColor0;
			#endif //aselc
			half3 hsvTorgb2512 = RGBToHSV( ase_lightColor.rgb );
			half4 appendResult2408 = (half4(( normalMap1002 * 0.3 ) , 1.0));
			half4 Normal2384 = appendResult2408;
			half3 localShadeSH92384 = ShadeSH92384( Normal2384 );
			half temp_output_8_0_g523 = 1.0;
			half temp_output_7_0_g523 = _IndirLightUseMinforMax;
			half lerpResult6_g523 = lerp( _IndirectDiffuseOffsetMax , _IndirectDiffuseOffset , ( step( temp_output_8_0_g523 , temp_output_7_0_g523 ) * step( temp_output_7_0_g523 , temp_output_8_0_g523 ) ));
			half3 temp_output_2393_0 = saturate( ( localShadeSH92384 + lerpResult6_g523 ) );
			half3 maxIndirLight2502 = temp_output_2393_0;
			half3 hsvTorgb2510 = RGBToHSV( maxIndirLight2502 );
			float4 Rim116 = ( _EnableRimLighting * ( ( ( fresnelNode1402 * _RimEnergy ) * lerpResult114 ) * max( ( 1 * saturate( ( exp( hsvTorgb2512.z ) - 1.0 ) ) ) , hsvTorgb2510.z ) ) );
			half4 EmissionFinal29 = saturate( ( AL_Final85 + Emission119 + Rim116 ) );
			o.Emission = EmissionFinal29.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				float4 tSpace0 : TEXCOORD4;
				float4 tSpace1 : TEXCOORD5;
				float4 tSpace2 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
				o.customPack2.xy = customInputData.uv3_texcoord3;
				o.customPack2.xy = v.texcoord2;
				o.customPack2.zw = customInputData.uv4_texcoord4;
				o.customPack2.zw = v.texcoord3;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv2_texcoord2 = IN.customPack1.zw;
				surfIN.uv3_texcoord3 = IN.customPack2.xy;
				surfIN.uv4_texcoord4 = IN.customPack2.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Standard"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19302
Node;AmplifyShaderEditor.CommentaryNode;2333;-4204.083,-8472.979;Inherit;False;1172.708;2244.156;Selection of UV Maps to Use for UV Tile Discarding;30;2533;2532;2359;2355;2354;2353;2338;2348;2343;2337;2336;2362;2361;2360;2351;2350;2349;2346;2345;2344;2342;2340;2339;2335;2356;2357;2535;2536;2537;2538;Delay UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-4455.841,-2579.398;Inherit;False;859.9141;343.3768;Comment;3;737;34;1002;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2357;-3525.436,-8411.093;Inherit;False;Property;_ALDelayUVMap;AL Delay UV Map;18;2;[Header];[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;Screen Space;8;0;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;737;-4425.451,-2467.993;Inherit;True;Property;_NormalMap;Normal Map;8;0;Create;True;0;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;2356;-3306.221,-8410.321;Inherit;False;delayUVset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;2532;-4190.378,-6689.478;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1276;-451.2643,-10403.85;Inherit;False;2609.462;2341.557;Comment;7;1277;1278;1313;1365;1279;2401;1275;Diffuse Wrapped;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;34;-4129.341,-2468.484;Inherit;True;Property;_NMSample;NM Sample;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2335;-4072.747,-8419.262;Inherit;False;2356;delayUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2339;-4081.249,-7982.147;Inherit;False;2356;delayUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2340;-4051.756,-7911.304;Inherit;False;Constant;_Float8;Float 2;54;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2342;-4055.756,-7718.305;Inherit;False;Constant;_Vector21;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;2344;-4080.736,-7582.253;Inherit;False;2356;delayUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2345;-4051.243,-7511.41;Inherit;False;Constant;_Float9;Float 2;54;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2346;-4055.243,-7318.411;Inherit;False;Constant;_Vector22;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;2360;-4119.167,-7839.875;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2361;-4117.167,-7438.875;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2336;-4087.254,-8327.415;Inherit;False;Constant;_Float7;Float 2;54;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2337;-4061.254,-8130.41;Inherit;False;Constant;_Vector20;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;2350;-4057.099,-6916.156;Inherit;False;Constant;_Vector23;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;2351;-4053.099,-7109.155;Inherit;False;Constant;_Float10;Float 2;54;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2536;-4156.862,-6475.226;Inherit;False;Constant;_Vector28;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;2533;-4016.219,-6604.665;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2537;-4008.859,-6675.096;Inherit;False;Constant;_Float16;Float 2;54;0;Create;True;0;0;0;False;0;False;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2349;-4082.592,-7180;Inherit;False;2356;delayUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2538;-4044.859,-6759.096;Inherit;False;2356;delayUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2359;-4124.167,-8252.877;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2362;-4116.167,-7036.876;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;2401;-412.7138,-8786.773;Inherit;False;1521.969;674.606;Comment;21;2415;2413;2392;2416;2414;2408;2412;2411;2409;1347;2384;1348;2394;2396;2388;2389;2393;2390;2502;2547;2548;Indirect Diffuse (Light Probes/Baked Lighting);1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1002;-3805.344,-2450.526;Inherit;False;normalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;-4679.208,-5018.687;Inherit;False;1638.637;723.5784;Comment;14;2546;2549;2553;2552;2551;2541;2545;26;25;736;2543;2542;2544;2540;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;2343;-3846.255,-7904.252;Inherit;False;If Float Equal;-1;;427;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2348;-3845.742,-7504.357;Inherit;False;If Float Equal;-1;;428;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2338;-3841.721,-8327.282;Inherit;False;If Float Equal;-1;;470;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2353;-3791.093,-7109.897;Inherit;False;If Float Equal;-1;;478;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2535;-3780.856,-6690.967;Inherit;False;If Float Equal;-1;;518;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1347;-395.1138,-8739.496;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2412;-392.483,-8544.104;Inherit;False;Constant;_Float13;Float 13;56;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2540;-4660.19,-4723.463;Inherit;True;Property;_AmbientOcclusion;Ambient Occlusion;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1275;1251.725,-8658.753;Inherit;False;735.2146;441.0371;Dot Product of Normal and Light Dir;8;2266;2265;2264;1204;1254;1206;1205;1203;NdotL;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2354;-3423.054,-7630.017;Inherit;False;5;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2409;-391.483,-8417.104;Inherit;False;Constant;_Float12;Float 12;56;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2411;-212.4834,-8654.104;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;2544;-4388.115,-4714.262;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2542;-4654.115,-4526.262;Inherit;False;Property;_AOStrength;AO Strength;12;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;977;-2961.907,-5914.765;Inherit;False;1452.845;376.6802;Comment;8;991;985;987;979;993;2458;2457;2363;AudioLink Delay Settings;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2355;-3297.324,-7628.428;Inherit;False;DelayUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1204;1270.725,-8451.753;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;2408;-70.48354,-8629.104;Inherit;False;COLOR;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2416;-203.9555,-8289.873;Inherit;False;Constant;_Float14;Float 14;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2415;-236.9555,-8364.873;Inherit;False;Property;_IndirLightUseMinforMax;Use Min for Max;3;1;[ToggleUI];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2414;-344.9555,-8208.873;Inherit;False;Property;_IndirectDiffuseOffsetMax;Indirect Light Max;4;0;Create;False;0;0;0;False;0;False;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2392;-127.444,-8483.763;Inherit;False;Property;_IndirectDiffuseOffset;Indirect Light Min;2;0;Create;False;0;0;0;False;0;False;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2543;-4253.115,-4715.262;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2363;-2927.526,-5825.275;Inherit;False;2355;DelayUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;1203;1437.725,-8444.753;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1205;1404.725,-8593.753;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;2413;150.5898,-8350.622;Inherit;False;If Float Equal;-1;;523;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;2384;65.17541,-8624.276;Inherit;False;return ShadeSH9(Normal)@;3;Create;1;True;Normal;FLOAT4;0,0,0,0;In;;Inherit;False;ShadeSH9;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;2545;-4095.297,-4719.267;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2551;-4145.528,-4617.779;Inherit;False;Constant;_Color2;Color 2;48;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2552;-4097.528,-4403.779;Inherit;False;Property;_RealAO;Real AO;13;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2457;-2717.191,-5840.994;Inherit;True;Property;_ALDelayMap;AudioLink Delay Tex Map;17;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;1206;1634.725,-8592.753;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2390;320.0076,-8533.168;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2388;321.028,-8641.239;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2549;-3860.528,-4597.779;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1870.811,-4819.045;Inherit;False;765.7347;170.1592;Comment;4;243;50;49;48;Time;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;979;-2530.399,-5646.738;Inherit;False;Property;_ALUVDelayMaxDelay;AL UV Delay Max Delay;19;0;Create;True;0;0;0;False;0;False;0;127;0;127;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2458;-2433.307,-5836.21;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;1254;1746.7,-8595.224;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2393;476.0004,-8547.441;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2389;472.9423,-8650.415;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;1348;408.6866,-8736.773;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2546;-3298.615,-4585.247;Inherit;False;ao_times_strength;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1277;-387.3082,-9906.771;Inherit;False;532.9998;163;Comment;2;1207;1209;Wrap Value;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;993;-2195.031,-5847.895;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-1851.701,-4762.217;Inherit;False;Property;_ALTimeScale;AL HueShift Time Scale;20;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2264;1445.354,-8298.688;Inherit;False;1254;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;2396;628.5804,-8692.937;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2548;440.8804,-8427.203;Inherit;False;2546;ao_times_strength;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;48;-1610.04,-4762.258;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;987;-2023.359,-5848.717;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2265;1627.146,-8307.104;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1207;-356.8683,-9841.051;Inherit;False;Property;_WrappedShadingValue;Wrapped Shading Value;5;0;Create;False;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2547;779.8804,-8610.203;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1279;-423.5098,-9588.972;Inherit;False;2538.892;696.345;I really hated this bit;29;2381;2375;1363;2383;2260;1326;2259;2286;1355;1389;2257;2285;1388;2258;2290;1390;1356;2291;2367;2255;2256;1362;1273;2372;1274;2371;2369;2283;2395;Light Color & More Indirect Calculations;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1278;-397.7499,-10309.86;Inherit;False;795.2947;355.6133;Comment;10;1229;1216;1211;1208;1210;1213;1214;1255;1392;2254;Wrapping;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;201;1447.965,581.0845;Inherit;False;1136.561;1721.451;Selection of UV Maps to Use for UV Tile Discarding;24;200;2318;2332;2331;2329;2330;2328;2327;2325;2326;2324;2323;2322;2321;2312;2320;2319;2311;2316;2317;2315;1027;2314;2313;Discard UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.FractNode;49;-1440.809,-4759.045;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;985;-1886.024,-5846.962;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1209;-105.6579,-9841.051;Inherit;False;wrap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2266;1776.146,-8312.104;Inherit;False;NdotLSaturated;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2394;906.1145,-8713.668;Inherit;False;indirDiffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;103;-1401.04,-5944.659;Inherit;False;1232.821;441.5522;Comment;10;1012;2213;61;58;42;51;995;1009;194;2292;AudioLink Bass;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2313;2090.464,641.9681;Inherit;False;Property;_DiscardUVMap;Discard UV Map;27;2;[Header];[Enum];Create;True;1;UV Tile Discarding;4;UV0;0;UV1;1;UV2;2;UV3;3;0;True;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;-1744.552,-5844.096;Inherit;False;in_ALDelay;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1329.076,-4762.699;Inherit;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1214;-372.75,-10051.03;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1213;-339.3501,-10122.64;Inherit;False;Constant;_Float5;Float 5;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1210;-370.9919,-10193.83;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2395;-354.4717,-8977.956;Inherit;False;2394;indirDiffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1255;-390.9689,-10267.86;Inherit;False;2266;NdotLSaturated;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;106;-112.9787,-5381.73;Inherit;False;1183.572;355.2229;Comment;5;57;69;70;45;1011;AudioLink Treble;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;105;-86.35403,-5893.254;Inherit;False;1188.215;403.241;Comment;6;67;66;56;44;197;1010;AudioLink HighMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-1337.905,-5407.259;Inherit;False;1137.62;367.6456;Comment;7;64;63;55;43;1008;996;196;AudioLink LowMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;995;-1251.419,-5630.939;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1153.306,-5711.634;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;-1362.825,-5809.147;Inherit;False;Constant;_AL_Bass;AL_Bass;6;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2314;2285.679,643.7394;Inherit;False;discUVset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1;-711.9443,-1120.764;Inherit;False;1747.943;1008.731;Comment;25;116;334;333;947;115;88;114;113;112;87;1402;1403;12;1404;2503;2505;2510;2509;2512;2513;2514;2515;2516;2517;2518;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1208;-190.8224,-10240.95;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1211;-191.5504,-10096.63;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2283;-129.6784,-9224.612;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;43;-1294.715,-5338.324;Inherit;False;Constant;_AL_LowMid;AL_LowMid;6;0;Create;True;0;0;0;False;0;False;1,0.9294118,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1082.38,-5260.526;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-77.97868,-5324.461;Inherit;False;Constant;_AL_Treble;AL_Treble;6;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;57;134.7981,-5255.021;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;44;-43.51395,-5829.144;Inherit;False;Constant;_AL_HighMid;AL_HighMid;6;0;Create;True;0;0;0;False;0;False;0,0.8196079,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;56;168.1703,-5754.85;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;996;-1143.704,-5124.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;997;33.29614,-5111.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;998;49.29614,-5600.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;194;-960.5157,-5788.812;Inherit;False;HueShift;-1;;526;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1009;-973.2197,-5635.942;Inherit;False;4BandAmplitude;-1;;527;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;0;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1027;1497.878,801.851;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2315;1543.152,634.7986;Inherit;False;2314;discUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2317;1528.645,726.6432;Inherit;False;Constant;_Float2;Float 2;54;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2316;1554.645,923.6432;Inherit;False;Constant;_Vector16;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;2319;1534.65,1071.904;Inherit;False;2314;discUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2320;1564.143,1142.749;Inherit;False;Constant;_Float3;Float 2;54;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2312;1498.569,1215.446;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;2321;1560.143,1335.749;Inherit;False;Constant;_Vector17;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;2323;1535.163,1471.8;Inherit;False;2314;discUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2324;1564.656,1542.645;Inherit;False;Constant;_Float4;Float 2;54;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2326;1560.656,1735.645;Inherit;False;Constant;_Vector18;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2325;1499.082,1615.342;Inherit;False;2;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;2330;1558.8,2137.9;Inherit;False;Constant;_Vector19;Vector 16;54;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;2329;1562.8,1944.901;Inherit;False;Constant;_Float6;Float 2;54;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2331;1497.226,2017.598;Inherit;False;3;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2328;1533.307,1874.056;Inherit;False;2314;discUVset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;2513;-696.3657,-406.7531;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;1216;-79.53743,-10175.82;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2369;-56.38911,-9086.518;Inherit;False;Constant;_Float11;Float 11;55;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Exp2OpNode;2371;18.72949,-9228.981;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;736;-4547.432,-4929.197;Inherit;True;Property;_Albedo;Albedo;7;0;Create;True;0;0;0;False;0;False;None;None;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;38;-1765.898,-3397.137;Inherit;False;604.8932;280;Comment;2;40;39;AL Emission Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;195;343.6559,-5323.875;Inherit;False;HueShift;-1;;528;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;196;-907.4175,-5335.405;Inherit;False;HueShift;-1;;529;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;197;368.8238,-5818.455;Inherit;False;HueShift;-1;;530;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1008;-913.0733,-5171.95;Inherit;False;4BandAmplitude;-1;;531;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;1;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1010;368.6584,-5617.326;Inherit;False;4BandAmplitude;-1;;532;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;2;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1011;331.6262,-5142.257;Inherit;False;4BandAmplitude;-1;;533;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;3;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-711.889,-5717.277;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2292;-884.269,-5865.682;Inherit;False;Constant;_Float0;Float 0;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1012;-743.153,-5891.785;Inherit;False;IsAudioLink;-1;;534;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2322;1769.645,1149.8;Inherit;False;If Float Equal;-1;;535;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2327;1770.158,1549.696;Inherit;False;If Float Equal;-1;;536;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2332;1824.807,1944.158;Inherit;False;If Float Equal;-1;;537;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2311;1774.179,726.7761;Inherit;False;If Float Equal;-1;;538;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RGBToHSVNode;2512;-552.2336,-417.7674;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Exp2OpNode;1392;-1.601025,-10260.7;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2372;134.7295,-9226.981;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;1273;-406.2366,-9528.8;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;1274;-405.9002,-9266.962;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;25;-4327.529,-4929.668;Inherit;True;Property;_AlbedoSample;Albedo Sample;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2553;-3863.528,-4795.779;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1313;442.0415,-10308;Inherit;False;969.559;661.3575;Comment;17;1289;1312;1405;1309;1217;1410;1306;1393;1411;1400;1396;1399;1395;1394;1310;1307;1497;Reflections;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;637.4441,-5280.506;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-644.6395,-5299.407;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;665.2375,-5831.361;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;40;-1709.898,-3340.138;Inherit;True;Property;_AL_Mask;AudioLink Mask;15;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2213;-556.2672,-5832.83;Inherit;False;If Float Equal;-1;;539;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2318;2192.846,1424.037;Inherit;False;4;4;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1404;-679.2596,-1047.089;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ExpOpNode;2518;-356.7303,-495.3182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1362;-403.7976,-9446.18;Inherit;False;Constant;_Color1;Color 1;57;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;2254;55.35961,-10170.78;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2256;-167.1041,-9323.724;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2255;-148.1041,-9494.725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2367;286.5102,-9223.395;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2291;143.8698,-9088.977;Inherit;False;Property;_WrapIndirScale;Indirect Light Scale;6;0;Create;False;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2541;-3689.845,-4914.359;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;2050;-2736.134,-7266.054;Inherit;False;551.9897;288.0864;Comment;3;755;753;1017;Metallic and Smoothness (Multimap vs Unity Metallic Map);1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-23.66935,-4536.875;Inherit;False;1663.516;958.884;Comment;21;85;1043;1037;71;415;416;84;83;82;81;80;79;78;76;77;75;74;73;1044;1046;2263;AudioLink Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;846.5929,-5305.182;Inherit;False;ALC_Treble;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-415.1543,-5306.091;Inherit;False;ALC_LowMid;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;138;1465.541,-1401.771;Inherit;False;4140.275;1815.13;Comment;81;2449;2448;2447;2446;2445;2444;2443;2442;2441;2440;2439;2438;2437;2436;2435;2434;202;192;149;270;198;629;191;222;802;801;768;208;636;635;207;767;640;773;212;772;639;211;771;210;638;637;213;641;644;777;216;643;776;215;642;214;775;774;770;209;766;634;206;765;764;204;632;763;631;203;762;633;630;224;223;225;205;180;167;154;2451;2452;2453;2454;2455;UV Tile Discard;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1386.656,-3345.987;Inherit;False;ALMask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-379.7261,-5841.099;Inherit;False;ALC_Bass;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;2318.576,1425.626;Inherit;False;DiscardUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-590.4416,-903.1979;Float;False;Property;_RimPower;Rim Power;24;0;Create;True;0;0;0;False;0;False;2.07;4.59;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1403;-501.4037,-1051.377;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;880.6917,-5833.153;Inherit;False;ALC_HighMid;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2517;-238.7303,-458.3182;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1356;14.34278,-9387.64;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Exp2OpNode;1390;77.31171,-9497.535;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2290;440.6057,-9217.855;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;3;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1229;193.3933,-10196.02;Inherit;False;DiffWrapStep1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1396;457.9587,-9927.372;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;2502;721.4232,-8381.824;Inherit;False;maxIndirLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-3300.029,-4917.205;Inherit;False;mainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;26.33066,-4372.526;Inherit;False;61;ALC_Bass;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;42.57924,-4245.578;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;42.11675,-4131.23;Inherit;False;67;ALC_HighMid;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;67.26691,-4009.6;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;67.80442,-3895.252;Inherit;False;64;ALC_LowMid;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;76.93356,-3805.6;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;77.47105,-3691.253;Inherit;False;70;ALC_Treble;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;774;3842.005,-910.9678;Inherit;False;Property;_DiscardUVTile30;Discard UV Tile 3,0;41;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;775;3839.91,-560.7627;Inherit;False;Property;_DiscardUVTile31;Discard UV Tile 3,1;40;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;214;3904.62,-483.9957;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;642;3933.447,-413.097;Inherit;False;Constant;_Vector13;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;215;3912.915,-182.604;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;776;3813.138,-254.3136;Inherit;False;Property;_DiscardUVTile32;Discard UV Tile 3,2;42;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;643;3940.676,-112.648;Inherit;False;Constant;_Vector14;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;216;3914.689,128.2034;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;777;3814.721,53.09606;Inherit;False;Property;_DiscardUVTile33;Discard UV Tile 3,3;43;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;644;3945.259,200.7619;Inherit;False;Constant;_Vector15;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;641;3964.222,-753.2794;Inherit;False;Constant;_Vector12;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;213;3933.363,-828.7961;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;20.79314,-4476.875;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;1402;-311.6268,-1031.716;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-306.0728,-806.6133;Inherit;False;Property;_RimEnergy;Rim Energy;25;0;Create;True;0;0;0;False;0;False;0.345;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-203.138,-719.0771;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-283.1368,-639.0771;Inherit;False;Property;_RimBaseColorStrength;Rim Base Color Strength;26;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;2509;-126.9134,-552.6226;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2516;-94.12061,-419.6631;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2505;-186.393,-270.0654;Inherit;False;2502;maxIndirLight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2258;235.6247,-9328.195;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2285;207.3216,-9466.611;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2257;655.499,-9255.595;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;1400;620.5622,-9870.482;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1388;199.7824,-9545.024;Inherit;False;1229;DiffWrapStep1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1395;463.5598,-10004.88;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1017;-2707.858,-7202.369;Inherit;True;Property;_MetallicGlossMap;Unity Metallic;9;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;211.3306,-4443.526;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;227.1167,-4202.23;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;251.8044,-3966.252;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;261.471,-3762.253;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1043;743,-4456;Inherit;False;IsAudioLink;-1;;540;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;114;0.4000921,-775.0516;Inherit;True;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2434;4148.061,-787.4337;Inherit;False;UV Tile Checker;-1;;541;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2435;4155.061,-506.4337;Inherit;False;UV Tile Checker;-1;;542;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2436;4142.061,-217.4337;Inherit;False;UV Tile Checker;-1;;543;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2437;4140.061,73.56628;Inherit;False;UV Tile Checker;-1;;544;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-7.109922,-962.2746;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1037;743,-4376;Inherit;False;Property;_ALEmitifInactive;AL Emit if Inactive;16;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2514;100.8794,-481.6631;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2510;27.69453,-304.0276;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1389;465.4989,-9502.846;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1355;796.175,-9321.411;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;1399;755.5626,-9859.482;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1307;463.5856,-10178.8;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1497;499.8647,-9766.358;Inherit;False;Property;_WrapMetallicFesnelScale;Metallic Fesnel Scale;10;0;Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1394;635.0743,-10007.28;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;753;-2407.187,-7179.227;Inherit;False;_Metalic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;755;-2408.279,-7102.891;Inherit;False;_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;534.6252,-4158.036;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;117;-1853.104,-2983.999;Inherit;False;791.7242;362.8555;Comment;4;120;119;118;121;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;4481.771,-529.569;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;2294.606,-865.7911;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;630;1538.705,-578.879;Inherit;False;Constant;_Vector1;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;633;2324.538,-773.1622;Inherit;False;Constant;_Vector4;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;762;1499.583,-759.6893;Inherit;False;Property;_DiscardUVTile01;Discard UV Tile 0,1;29;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;203;1536.018,-316.3951;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;631;1566.422,-217.064;Inherit;False;Constant;_Vector2;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;763;1496.973,-427.7367;Inherit;False;Property;_DiscardUVTile02;Discard UV Tile 0,2;30;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;632;1594.787,113.182;Inherit;False;Constant;_Vector3;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;204;1570.418,24.20495;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;764;1518.973,-60.73669;Inherit;False;Property;_DiscardUVTile03;Discard UV Tile 0,3;31;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;765;2249.126,-963.5736;Inherit;False;Property;_DiscardUVTile10;Discard UV Tile 1,0;32;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;2357.974,-536.9484;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;634;2385.538,-462.1622;Inherit;False;Constant;_Vector5;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;766;2259.126,-613.5735;Inherit;False;Property;_DiscardUVTile11;Discard UV Tile 1,1;33;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;3140.744,-871.4884;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;770;3041.102,-947.6624;Inherit;False;Property;_DiscardUVTile20;Discard UV Tile 2,0;36;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;637;3166.819,-795.8944;Inherit;False;Constant;_Vector8;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;638;3179.013,-479.2932;Inherit;False;Constant;_Vector9;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;210;3150.812,-564.5684;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;771;3055.927,-642.5212;Inherit;False;Property;_DiscardUVTile21;Discard UV Tile 2,1;37;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;3164.474,-249.9562;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;639;3189.3,-170.453;Inherit;False;Constant;_Vector10;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;772;3061.227,-323.6906;Inherit;False;Property;_DiscardUVTile22;Discard UV Tile 2,2;38;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;3166.697,60.64629;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;773;3067.304,-14.54724;Inherit;False;Property;_DiscardUVTile23;Discard UV Tile 2,3;39;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;640;3192.601,137.0375;Inherit;False;Constant;_Vector11;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;767;2251.573,-307.925;Inherit;False;Property;_DiscardUVTile12;Discard UV Tile 1,2;34;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;2353.001,-233.3764;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;635;2382.081,-156.652;Inherit;False;Constant;_Vector6;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;636;2388.87,155.4928;Inherit;False;Constant;_Vector7;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;208;2361.729,79.19774;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;768;2260.751,5.167598;Inherit;False;Property;_DiscardUVTile13;Discard UV Tile 1,3;35;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;629;1539.432,-900.3254;Inherit;False;Constant;_Vector0;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;1044;977.5732,-4431.625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;1543.344,-979.7899;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;270;1497.07,-1070.585;Inherit;False;Property;_DiscardUVTile00;Discard UV Tile 0,0;28;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;238.1626,-854.9144;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;202;1533.318,-660.1951;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;415;478.4037,-4285.905;Half;False;Property;_EnableAudioLink;Enable AudioLink;14;2;[Header];[ToggleUI];Create;True;1;AudioLink;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;2503;328.4067,-598.4909;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2259;897.2431,-9336.568;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1411;557.8206,-10102.24;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1310;887.5402,-9978.068;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;1306;637.2359,-10260.15;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;2286;737.4152,-9543.655;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1393;828.4354,-9873.259;Inherit;True;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1771.553,-2723.966;Inherit;False;Property;_EmissionStrength;Emission Strength;22;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;118;-1797.104,-2926.999;Inherit;True;Property;_Emission;Emission;21;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;416;787.8911,-4176.061;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;801;4579.42,-570.3809;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2263;1093.691,-4358.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;947;458.6556,-853.9329;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;333;256.8146,-929.4459;Half;False;Property;_EnableRimLighting;Enable Rim Lighting;23;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2438;3383.047,37.1557;Inherit;False;UV Tile Checker;-1;;545;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2439;3368.047,-283.8443;Inherit;False;UV Tile Checker;-1;;546;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2440;3356.047,-582.8443;Inherit;False;UV Tile Checker;-1;;547;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2441;3351.047,-865.8442;Inherit;False;UV Tile Checker;-1;;548;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2443;2550.401,-554.9913;Inherit;False;UV Tile Checker;-1;;549;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2444;2548.401,-255.9913;Inherit;False;UV Tile Checker;-1;;550;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2445;2567.401,74.00867;Inherit;False;UV Tile Checker;-1;;551;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2446;1800.911,-3.485718;Inherit;False;UV Tile Checker;-1;;552;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2447;1785.775,-345.7103;Inherit;False;UV Tile Checker;-1;;553;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2448;1788.775,-622.7103;Inherit;False;UV Tile Checker;-1;;554;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2449;1764.775,-968.7103;Inherit;False;UV Tile Checker;-1;;555;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2442;2547.401,-851.9913;Inherit;False;UV Tile Checker;-1;;556;c43a818059b65cd448c0f67225beab6f;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1326;1035.661,-9401.441;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1405;1073.653,-10025.14;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;1410;859.4247,-10162.95;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-1444.109,-2847.282;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;154;2890.493,-401.2814;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;3686.68,-527.5339;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;802;4497.627,-688.764;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1046;1214.24,-4177.113;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;656.5175,-916.3521;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;2103.135,-435.5835;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2260;1175.729,-9434.508;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1309;1100.669,-10171.83;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2383;1542.447,-9102.138;Inherit;False;Constant;_Color0;Color 0;56;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2375;1180.356,-9176.692;Inherit;False;Property;_MinBrightness;Min Brightness;1;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1217;889.4218,-10252.32;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;31;-278.7401,-2122.503;Inherit;False;1194.286;795.1765;Comment;6;30;28;122;86;29;2539;Emission Combination;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;-1276.658,-2924.725;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;225;2205.348,-1117.688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;223;3826.804,-1027.133;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;224;3041,-1077.105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;222;4161.278,-1049.713;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;1389.661,-4179.093;Inherit;False;AL_Final;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;797.5814,-910.1874;Float;True;Rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1312;1243.066,-10260.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;2381;1747.969,-9260.06;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1365;1457.327,-10279.38;Inherit;False;584.9199;216.6494;Comment;4;1219;1290;1144;1364;Final Assembly;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;4249.063,-1173.994;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-180.3152,-1961.81;Inherit;False;119;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-182.0909,-1878.577;Inherit;False;116;Rim;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2452;4310.275,-985.5667;Inherit;False;Constant;_Float2;Float 2;58;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2454;4365.413,-1078.667;Inherit;False;Constant;_Float15;Float 15;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-182.0128,-2051.763;Inherit;False;85;AL_Final;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1289;1148.671,-9758.097;Inherit;False;AvatarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1363;1892.308,-9256.013;Inherit;False;DiffWrapLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;24.13739,-1985.716;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2455;4560.986,-915.4526;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;2451;4526.275,-1286.567;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1364;1475.227,-10233.8;Inherit;False;1363;DiffWrapLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1290;1477.527,-10160.34;Inherit;False;1289;AvatarColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;2453;4783.413,-1083.667;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1219;1684.486,-10207.08;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2539;338.2462,-1986.586;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1007;-4318.539,-6050.715;Inherit;False;587.23;638.1619;Comment;6;1006;2307;1005;1003;1004;1047;Fallback Textures;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;220;2051.233,-3370.865;Inherit;False;962.8354;715.8684;Comment;5;0;33;32;193;332;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;217;4137.307,-4147.085;Inherit;False;420.8079;185;Comment;2;219;218;Declare NaN;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;5052.494,-1100.016;Inherit;False;UVTileDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1144;1826.148,-10189.87;Inherit;False;Lighting Wrapped;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;699.295,-1985.41;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Exp2OpNode;2515;-353.1206,-353.6631;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;2286.262,-3320.865;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;218;4187.307,-4097.085;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;4334.115,-4095.47;Inherit;False;NaN;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1004;-4300.542,-5804.715;Inherit;True;Property;_EmissionMap;Fallback Emission Map;46;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;1003;-4295.542,-6000.715;Inherit;True;Property;_MainTex;Fallback Albedo;44;2;[Header];[SingleLineTexture];Create;False;1;Standard Fallbacks;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;1005;-4058.832,-5795.639;Inherit;False;Property;_EmissionColor;Fallback Emission Color;47;0;Create;False;0;0;0;True;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2307;-4059.833,-5990.872;Inherit;False;Property;_Color;Fallback Color;45;0;Create;False;0;0;0;True;0;False;1,1,1,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1006;-4300.907,-5611.498;Inherit;True;Property;_BumpMap;Fallback Normal Map;48;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;332;2519.215,-2995.611;Inherit;False;1144;Lighting Wrapped;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;193;2351.81,-2859.997;Inherit;False;192;UVTileDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;2301.754,-3145.94;Inherit;False;29;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1047;-4033.585,-5532.455;Inherit;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2759.068,-3220.523;Half;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;VoyVivika/VivikaShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Standard;-1;-1;-1;-1;1;VRCFallback=DoubleSided;False;0;0;True;_CullMode;-1;0;False;;1;Include;Libs\AudioLink\AudioLink.cginc;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2356;0;2357;0
WireConnection;34;0;737;0
WireConnection;2533;0;2532;1
WireConnection;2533;1;2532;2
WireConnection;1002;0;34;0
WireConnection;2343;7;2339;0
WireConnection;2343;8;2340;0
WireConnection;2343;9;2360;0
WireConnection;2343;10;2342;0
WireConnection;2348;7;2344;0
WireConnection;2348;8;2345;0
WireConnection;2348;9;2361;0
WireConnection;2348;10;2346;0
WireConnection;2338;7;2335;0
WireConnection;2338;8;2336;0
WireConnection;2338;9;2359;0
WireConnection;2338;10;2337;0
WireConnection;2353;7;2349;0
WireConnection;2353;8;2351;0
WireConnection;2353;9;2362;0
WireConnection;2353;10;2350;0
WireConnection;2535;7;2538;0
WireConnection;2535;8;2537;0
WireConnection;2535;9;2533;0
WireConnection;2535;10;2536;0
WireConnection;2354;0;2338;0
WireConnection;2354;1;2343;0
WireConnection;2354;2;2348;0
WireConnection;2354;3;2353;0
WireConnection;2354;4;2535;0
WireConnection;2411;0;1347;0
WireConnection;2411;1;2412;0
WireConnection;2544;0;2540;0
WireConnection;2355;0;2354;0
WireConnection;2408;0;2411;0
WireConnection;2408;3;2409;0
WireConnection;2543;0;2544;0
WireConnection;2543;1;2542;0
WireConnection;1203;0;1204;0
WireConnection;2413;7;2415;0
WireConnection;2413;8;2416;0
WireConnection;2413;9;2392;0
WireConnection;2413;10;2414;0
WireConnection;2384;0;2408;0
WireConnection;2545;0;2543;0
WireConnection;2457;1;2363;0
WireConnection;1206;0;1205;0
WireConnection;1206;1;1203;0
WireConnection;2390;0;2384;0
WireConnection;2390;1;2413;0
WireConnection;2388;0;2384;0
WireConnection;2388;1;2392;0
WireConnection;2549;0;2551;0
WireConnection;2549;1;2545;0
WireConnection;2549;2;2552;0
WireConnection;2458;0;2457;0
WireConnection;1254;0;1206;0
WireConnection;2393;0;2390;0
WireConnection;2389;0;2388;0
WireConnection;1348;0;1347;0
WireConnection;2546;0;2549;0
WireConnection;993;0;2458;3
WireConnection;993;4;979;0
WireConnection;2396;0;1348;0
WireConnection;2396;1;2389;0
WireConnection;2396;2;2393;0
WireConnection;48;0;243;0
WireConnection;987;0;993;0
WireConnection;2265;0;2264;0
WireConnection;2547;0;2396;0
WireConnection;2547;1;2548;0
WireConnection;49;0;48;0
WireConnection;985;0;987;0
WireConnection;1209;0;1207;0
WireConnection;2266;0;2265;0
WireConnection;2394;0;2547;0
WireConnection;991;0;985;0
WireConnection;50;0;49;0
WireConnection;2314;0;2313;0
WireConnection;1208;0;1255;0
WireConnection;1208;1;1210;0
WireConnection;1211;0;1213;0
WireConnection;1211;1;1214;0
WireConnection;2283;0;2395;0
WireConnection;194;14;42;0
WireConnection;194;15;51;0
WireConnection;1009;4;995;0
WireConnection;1216;0;1208;0
WireConnection;1216;1;1211;0
WireConnection;2371;0;2283;0
WireConnection;195;14;45;0
WireConnection;195;15;57;0
WireConnection;196;14;43;0
WireConnection;196;15;55;0
WireConnection;197;14;44;0
WireConnection;197;15;56;0
WireConnection;1008;4;996;0
WireConnection;1010;4;998;0
WireConnection;1011;4;997;0
WireConnection;58;0;194;0
WireConnection;58;1;1009;0
WireConnection;2322;7;2319;0
WireConnection;2322;8;2320;0
WireConnection;2322;9;2312;0
WireConnection;2322;10;2321;0
WireConnection;2327;7;2323;0
WireConnection;2327;8;2324;0
WireConnection;2327;9;2325;0
WireConnection;2327;10;2326;0
WireConnection;2332;7;2328;0
WireConnection;2332;8;2329;0
WireConnection;2332;9;2331;0
WireConnection;2332;10;2330;0
WireConnection;2311;7;2315;0
WireConnection;2311;8;2317;0
WireConnection;2311;9;1027;0
WireConnection;2311;10;2316;0
WireConnection;2512;0;2513;0
WireConnection;1392;0;1216;0
WireConnection;2372;0;2371;0
WireConnection;2372;1;2369;0
WireConnection;25;0;736;0
WireConnection;2553;0;2545;0
WireConnection;2553;1;2551;0
WireConnection;2553;2;2552;0
WireConnection;69;0;195;0
WireConnection;69;1;1011;0
WireConnection;63;0;196;0
WireConnection;63;1;1008;0
WireConnection;66;0;197;0
WireConnection;66;1;1010;0
WireConnection;2213;7;1012;0
WireConnection;2213;8;2292;0
WireConnection;2213;9;58;0
WireConnection;2213;10;194;0
WireConnection;2318;0;2311;0
WireConnection;2318;1;2322;0
WireConnection;2318;2;2327;0
WireConnection;2318;3;2332;0
WireConnection;2518;0;2512;3
WireConnection;2254;0;1392;0
WireConnection;2256;0;1274;0
WireConnection;2255;0;1273;0
WireConnection;2367;0;2372;0
WireConnection;2541;0;25;0
WireConnection;2541;1;2553;0
WireConnection;70;0;69;0
WireConnection;64;0;63;0
WireConnection;39;0;40;0
WireConnection;61;0;2213;0
WireConnection;200;0;2318;0
WireConnection;1403;0;1404;0
WireConnection;67;0;66;0
WireConnection;2517;0;2518;0
WireConnection;1356;0;1362;0
WireConnection;1356;1;2256;0
WireConnection;1356;2;2255;0
WireConnection;1390;0;2255;0
WireConnection;2290;0;2367;0
WireConnection;2290;1;2291;0
WireConnection;1229;0;2254;0
WireConnection;2502;0;2393;0
WireConnection;26;0;2541;0
WireConnection;1402;0;1403;0
WireConnection;1402;3;12;0
WireConnection;2516;0;2517;0
WireConnection;2258;0;1356;0
WireConnection;2285;0;1390;0
WireConnection;2257;0;2290;0
WireConnection;1400;0;1396;0
WireConnection;74;0;71;0
WireConnection;74;1;73;0
WireConnection;77;0;75;0
WireConnection;77;1;76;0
WireConnection;79;0;78;0
WireConnection;79;1;80;0
WireConnection;82;0;81;0
WireConnection;82;1;83;0
WireConnection;114;1;112;0
WireConnection;114;2;113;0
WireConnection;2434;21;774;0
WireConnection;2434;6;213;0
WireConnection;2434;10;641;0
WireConnection;2435;21;775;0
WireConnection;2435;6;214;0
WireConnection;2435;10;642;0
WireConnection;2436;21;776;0
WireConnection;2436;6;215;0
WireConnection;2436;10;643;0
WireConnection;2437;21;777;0
WireConnection;2437;6;216;0
WireConnection;2437;10;644;0
WireConnection;88;0;1402;0
WireConnection;88;1;87;0
WireConnection;2514;0;2509;0
WireConnection;2514;1;2516;0
WireConnection;2510;0;2505;0
WireConnection;1389;0;1388;0
WireConnection;1389;1;2285;0
WireConnection;1355;0;2258;0
WireConnection;1355;1;2257;0
WireConnection;1399;0;1400;0
WireConnection;1394;0;1395;0
WireConnection;753;0;1017;1
WireConnection;755;0;1017;4
WireConnection;84;0;74;0
WireConnection;84;1;77;0
WireConnection;84;2;79;0
WireConnection;84;3;82;0
WireConnection;180;0;2434;0
WireConnection;180;1;2435;0
WireConnection;180;2;2436;0
WireConnection;180;3;2437;0
WireConnection;1044;0;1043;0
WireConnection;1044;1;1037;0
WireConnection;115;0;88;0
WireConnection;115;1;114;0
WireConnection;2503;0;2514;0
WireConnection;2503;1;2510;3
WireConnection;2259;0;1355;0
WireConnection;1306;0;1307;0
WireConnection;2286;0;1389;0
WireConnection;1393;0;1394;0
WireConnection;1393;4;1399;0
WireConnection;1393;2;1497;0
WireConnection;416;0;415;0
WireConnection;416;1;84;0
WireConnection;801;0;180;0
WireConnection;2263;0;1044;0
WireConnection;947;0;115;0
WireConnection;947;1;2503;0
WireConnection;2438;21;773;0
WireConnection;2438;6;212;0
WireConnection;2438;10;640;0
WireConnection;2439;21;772;0
WireConnection;2439;6;211;0
WireConnection;2439;10;639;0
WireConnection;2440;21;771;0
WireConnection;2440;6;210;0
WireConnection;2440;10;638;0
WireConnection;2441;21;770;0
WireConnection;2441;6;209;0
WireConnection;2441;10;637;0
WireConnection;2443;21;766;0
WireConnection;2443;6;206;0
WireConnection;2443;10;634;0
WireConnection;2444;21;767;0
WireConnection;2444;6;207;0
WireConnection;2444;10;635;0
WireConnection;2445;21;768;0
WireConnection;2445;6;208;0
WireConnection;2445;10;636;0
WireConnection;2446;21;764;0
WireConnection;2446;6;204;0
WireConnection;2446;10;632;0
WireConnection;2447;21;763;0
WireConnection;2447;6;203;0
WireConnection;2447;10;631;0
WireConnection;2448;21;762;0
WireConnection;2448;6;202;0
WireConnection;2448;10;630;0
WireConnection;2449;21;270;0
WireConnection;2449;6;198;0
WireConnection;2449;10;629;0
WireConnection;2442;21;765;0
WireConnection;2442;6;205;0
WireConnection;2442;10;633;0
WireConnection;1326;0;2286;0
WireConnection;1326;1;2259;0
WireConnection;1405;0;1393;0
WireConnection;1405;2;1310;0
WireConnection;1410;0;1306;0
WireConnection;1410;1;1411;0
WireConnection;121;0;118;0
WireConnection;121;1;120;0
WireConnection;154;0;2442;0
WireConnection;154;1;2443;0
WireConnection;154;2;2444;0
WireConnection;154;3;2445;0
WireConnection;167;0;2441;0
WireConnection;167;1;2440;0
WireConnection;167;2;2439;0
WireConnection;167;3;2438;0
WireConnection;802;0;801;0
WireConnection;1046;0;416;0
WireConnection;1046;1;2263;0
WireConnection;334;0;333;0
WireConnection;334;1;947;0
WireConnection;149;0;2449;0
WireConnection;149;1;2448;0
WireConnection;149;2;2447;0
WireConnection;149;3;2446;0
WireConnection;2260;0;1326;0
WireConnection;1309;0;1410;0
WireConnection;1309;1;1405;0
WireConnection;119;0;121;0
WireConnection;225;0;149;0
WireConnection;223;0;167;0
WireConnection;224;0;154;0
WireConnection;222;0;802;0
WireConnection;85;0;1046;0
WireConnection;116;0;334;0
WireConnection;1312;0;1217;0
WireConnection;1312;1;1309;0
WireConnection;2381;0;2260;0
WireConnection;2381;1;2375;0
WireConnection;2381;2;2383;0
WireConnection;191;0;225;0
WireConnection;191;1;224;0
WireConnection;191;2;223;0
WireConnection;191;3;222;0
WireConnection;1289;0;1312;0
WireConnection;1363;0;2381;0
WireConnection;30;0;86;0
WireConnection;30;1;122;0
WireConnection;30;2;28;0
WireConnection;2455;0;2452;0
WireConnection;2455;1;2452;0
WireConnection;2451;0;2454;0
WireConnection;2451;1;191;0
WireConnection;2453;0;2451;0
WireConnection;2453;1;2454;0
WireConnection;2453;2;2455;0
WireConnection;2453;3;2452;0
WireConnection;1219;0;1364;0
WireConnection;1219;1;1290;0
WireConnection;2539;0;30;0
WireConnection;192;0;2453;0
WireConnection;1144;0;1219;0
WireConnection;29;0;2539;0
WireConnection;2515;0;2512;3
WireConnection;219;0;218;0
WireConnection;0;0;33;0
WireConnection;0;2;32;0
WireConnection;0;13;332;0
WireConnection;0;11;193;0
ASEEND*/
//CHKSM=F25023EAAFEB0C480594A339F84B05C6207CDC33