// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VoyVivika/VivikaShader"
{
	Properties
	{
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[Enum(Standard,0,Wrapped,2)]_LightingType("Lighting Type", Float) = 0
		_WrappedShadingValue("Wrapped Shading Value", Float) = 1
		_WrapIndirScale("Wrapped Indirect Scale", Float) = 3
		_Albedo("Albedo", 2D) = "black" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_MultiMap("MultiMap", 2D) = "black" {}
		[SingleLineTexture]_MetallicGlossMap("Unity Metallic", 2D) = "white" {}
		[ToggleUI]_UseUnityMetalicMap("Use Unity Metalic Map instead of MultiMap", Float) = 0
		_WrapMetallicFesnelScale("Wrap Metallic Fesnel Scale", Float) = 1
		[ToggleUI]_EnableAudioLink("Enable AudioLink", Range( 0 , 1)) = 0
		[ToggleUI]_ALEmitifInactive("AL Emit if Inactive", Float) = 1
		_AL_Mask("AudioLink Mask", 2D) = "black" {}
		[Enum(None,0,UV Vertical,1,Distance,2)]_ALUVToggle("Delay for AL", Float) = 0
		_ALDelayUPosition("AL Delay U Position", Range( 0 , 1)) = 0.5
		_ALDelayVPosition("AL Delay V Position", Range( 0 , 1)) = 0.83
		_ALUVDelayMaxDelay("AL UV Delay Max Delay", Range( 0 , 127)) = 0
		_ALTimeScale("AL Time Scale", Float) = 0
		_Emission("Emission", 2D) = "black" {}
		_EmissionStrength("Emission Strength", Range( 0 , 1)) = 0
		[ToggleUI]_EnableRimLighting("Enable Rim Lighting", Range( 0 , 1)) = 1
		_RimPower("Rim Power", Range( 0 , 10)) = 2.07
		_RimEnergy("Rim Energy", Range( 0 , 1)) = 0.345
		_RimBaseColorStrength("Rim Base Color Strength", Range( 0 , 1)) = 1
		[Header(UV Tile Discard)][ToggleUI]_DiscardUVTile00("Discard UV Tile 0,0", Range( 0 , 1)) = 0
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
		[Header(Video Player Decal)][ToggleUI]_EnableVideoPlayerDecal("Enable Video Player Decal", Float) = 0
		[ToggleUI]_ShowVideoPreview("Show Preview", Float) = 0
		[SingleLineTexture]_VideoDecalPreview("Video Decal Preview", 2D) = "white" {}
		[Header(X and Y are Position)][Header(Z and W are Tiling (Size))]_VideoDecalUVs("Video Decal Coordinates", Vector) = (0.01,-0.29,1.29,1.4)
		_VideoDecalRotation("Video Decal Rotation", Float) = -0.15
		[Header(Standard Fallbacks)][SingleLineTexture]_MainTex("Fallback Albedo", 2D) = "white" {}
		[SingleLineTexture]_EmissionMap("Fallback Emission Map", 2D) = "white" {}
		_EmissionColor("Fallback Emission Color", Color) = (0,0,0,0)
		[SingleLineTexture]_BumpMap("Fallback Normal Map", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
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
			float2 uv3_texcoord3;
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

		uniform sampler2D _MainTex;
		uniform sampler2D _EmissionMap;
		uniform half4 _EmissionColor;
		uniform sampler2D _BumpMap;
		uniform half _CullMode;
		uniform half _DiscardUVTile00;
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
		uniform half4 _VideoDecalUVs;
		uniform half _VideoDecalRotation;
		uniform half _EnableVideoPlayerDecal;
		uniform sampler2D _Albedo;
		uniform half4 _Albedo_ST;
		uniform sampler2D _Udon_VideoTex;
		uniform sampler2D _VideoDecalPreview;
		uniform half _ShowVideoPreview;
		uniform half _EnableAudioLink;
		uniform sampler2D _AL_Mask;
		uniform half4 _AL_Mask_ST;
		uniform half _ALTimeScale;
		uniform half _ALUVToggle;
		uniform half _ALDelayVPosition;
		uniform half _ALUVDelayMaxDelay;
		uniform half _ALDelayUPosition;
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
		uniform sampler2D _MetallicGlossMap;
		uniform half4 _MetallicGlossMap_ST;
		uniform half _UseUnityMetalicMap;
		uniform sampler2D _MultiMap;
		uniform half4 _MultiMap_ST;
		uniform half _WrappedShadingValue;
		uniform half _WrapIndirScale;
		uniform half _WrapMetallicFesnelScale;
		uniform half _LightingType;


		half AND1_g419( half A, half B )
		{
			return A && B;
		}


		half AND1_g393( half A, half B )
		{
			return A && B;
		}


		half AND1_g395( half A, half B )
		{
			return A && B;
		}


		half AND1_g397( half A, half B )
		{
			return A && B;
		}


		half AND1_g389( half A, half B )
		{
			return A && B;
		}


		half AND1_g399( half A, half B )
		{
			return A && B;
		}


		half AND1_g413( half A, half B )
		{
			return A && B;
		}


		half AND1_g415( half A, half B )
		{
			return A && B;
		}


		half AND1_g391( half A, half B )
		{
			return A && B;
		}


		half AND1_g407( half A, half B )
		{
			return A && B;
		}


		half AND1_g409( half A, half B )
		{
			return A && B;
		}


		half AND1_g411( half A, half B )
		{
			return A && B;
		}


		half AND1_g417( half A, half B )
		{
			return A && B;
		}


		half AND1_g401( half A, half B )
		{
			return A && B;
		}


		half AND1_g403( half A, half B )
		{
			return A && B;
		}


		half AND1_g405( half A, half B )
		{
			return A && B;
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

		inline half AudioLinkData3_g316( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		half IfAudioLinkv2Exists1_g421(  )
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


		inline half AudioLinkData3_g313( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline half AudioLinkData3_g311( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline half AudioLinkData3_g314( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		half IfAudioLinkv2Exists1_g322(  )
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half A1_g419 = _DiscardUVTile00;
			half2 break63_g418 = floor( half2( 0,0 ) );
			half2 DiscardUV200 = v.texcoord1.xy;
			half2 break61_g418 = DiscardUV200;
			half B1_g419 = ( step( break63_g418.x , break61_g418.x ) * step( break61_g418.x , ( break63_g418.x + 0.9999999 ) ) * step( break63_g418.y , break61_g418.y ) * step( break61_g418.y , ( break63_g418.y + 0.9999999 ) ) );
			half localAND1_g419 = AND1_g419( A1_g419 , B1_g419 );
			half A1_g393 = _DiscardUVTile01;
			half2 break63_g392 = floor( half2( 0,1 ) );
			half2 break61_g392 = DiscardUV200;
			half B1_g393 = ( step( break63_g392.x , break61_g392.x ) * step( break61_g392.x , ( break63_g392.x + 0.9999999 ) ) * step( break63_g392.y , break61_g392.y ) * step( break61_g392.y , ( break63_g392.y + 0.9999999 ) ) );
			half localAND1_g393 = AND1_g393( A1_g393 , B1_g393 );
			half A1_g395 = _DiscardUVTile02;
			half2 break63_g394 = floor( half2( 0,2 ) );
			half2 break61_g394 = DiscardUV200;
			half B1_g395 = ( step( break63_g394.x , break61_g394.x ) * step( break61_g394.x , ( break63_g394.x + 0.9999999 ) ) * step( break63_g394.y , break61_g394.y ) * step( break61_g394.y , ( break63_g394.y + 0.9999999 ) ) );
			half localAND1_g395 = AND1_g395( A1_g395 , B1_g395 );
			half A1_g397 = _DiscardUVTile03;
			half2 break63_g396 = floor( half2( 0,3 ) );
			half2 break61_g396 = DiscardUV200;
			half B1_g397 = ( step( break63_g396.x , break61_g396.x ) * step( break61_g396.x , ( break63_g396.x + 0.9999999 ) ) * step( break63_g396.y , break61_g396.y ) * step( break61_g396.y , ( break63_g396.y + 0.9999999 ) ) );
			half localAND1_g397 = AND1_g397( A1_g397 , B1_g397 );
			half A1_g389 = _DiscardUVTile10;
			half2 break63_g388 = floor( half2( 1,0 ) );
			half2 break61_g388 = DiscardUV200;
			half B1_g389 = ( step( break63_g388.x , break61_g388.x ) * step( break61_g388.x , ( break63_g388.x + 0.9999999 ) ) * step( break63_g388.y , break61_g388.y ) * step( break61_g388.y , ( break63_g388.y + 0.9999999 ) ) );
			half localAND1_g389 = AND1_g389( A1_g389 , B1_g389 );
			half A1_g399 = _DiscardUVTile11;
			half2 break63_g398 = floor( half2( 1,1 ) );
			half2 break61_g398 = DiscardUV200;
			half B1_g399 = ( step( break63_g398.x , break61_g398.x ) * step( break61_g398.x , ( break63_g398.x + 0.9999999 ) ) * step( break63_g398.y , break61_g398.y ) * step( break61_g398.y , ( break63_g398.y + 0.9999999 ) ) );
			half localAND1_g399 = AND1_g399( A1_g399 , B1_g399 );
			half A1_g413 = _DiscardUVTile12;
			half2 break63_g412 = floor( half2( 1,2 ) );
			half2 break61_g412 = DiscardUV200;
			half B1_g413 = ( step( break63_g412.x , break61_g412.x ) * step( break61_g412.x , ( break63_g412.x + 0.9999999 ) ) * step( break63_g412.y , break61_g412.y ) * step( break61_g412.y , ( break63_g412.y + 0.9999999 ) ) );
			half localAND1_g413 = AND1_g413( A1_g413 , B1_g413 );
			half A1_g415 = _DiscardUVTile13;
			half2 break63_g414 = floor( half2( 1,3 ) );
			half2 break61_g414 = DiscardUV200;
			half B1_g415 = ( step( break63_g414.x , break61_g414.x ) * step( break61_g414.x , ( break63_g414.x + 0.9999999 ) ) * step( break63_g414.y , break61_g414.y ) * step( break61_g414.y , ( break63_g414.y + 0.9999999 ) ) );
			half localAND1_g415 = AND1_g415( A1_g415 , B1_g415 );
			half A1_g391 = _DiscardUVTile20;
			half2 break63_g390 = floor( half2( 2,0 ) );
			half2 break61_g390 = DiscardUV200;
			half B1_g391 = ( step( break63_g390.x , break61_g390.x ) * step( break61_g390.x , ( break63_g390.x + 0.9999999 ) ) * step( break63_g390.y , break61_g390.y ) * step( break61_g390.y , ( break63_g390.y + 0.9999999 ) ) );
			half localAND1_g391 = AND1_g391( A1_g391 , B1_g391 );
			half A1_g407 = _DiscardUVTile21;
			half2 break63_g406 = floor( half2( 2,1 ) );
			half2 break61_g406 = DiscardUV200;
			half B1_g407 = ( step( break63_g406.x , break61_g406.x ) * step( break61_g406.x , ( break63_g406.x + 0.9999999 ) ) * step( break63_g406.y , break61_g406.y ) * step( break61_g406.y , ( break63_g406.y + 0.9999999 ) ) );
			half localAND1_g407 = AND1_g407( A1_g407 , B1_g407 );
			half A1_g409 = _DiscardUVTile22;
			half2 break63_g408 = floor( half2( 2,2 ) );
			half2 break61_g408 = DiscardUV200;
			half B1_g409 = ( step( break63_g408.x , break61_g408.x ) * step( break61_g408.x , ( break63_g408.x + 0.9999999 ) ) * step( break63_g408.y , break61_g408.y ) * step( break61_g408.y , ( break63_g408.y + 0.9999999 ) ) );
			half localAND1_g409 = AND1_g409( A1_g409 , B1_g409 );
			half A1_g411 = _DiscardUVTile23;
			half2 break63_g410 = floor( half2( 2,3 ) );
			half2 break61_g410 = DiscardUV200;
			half B1_g411 = ( step( break63_g410.x , break61_g410.x ) * step( break61_g410.x , ( break63_g410.x + 0.9999999 ) ) * step( break63_g410.y , break61_g410.y ) * step( break61_g410.y , ( break63_g410.y + 0.9999999 ) ) );
			half localAND1_g411 = AND1_g411( A1_g411 , B1_g411 );
			half A1_g417 = _DiscardUVTile30;
			half2 break63_g416 = floor( half2( 3,0 ) );
			half2 break61_g416 = DiscardUV200;
			half B1_g417 = ( step( break63_g416.x , break61_g416.x ) * step( break61_g416.x , ( break63_g416.x + 0.9999999 ) ) * step( break63_g416.y , break61_g416.y ) * step( break61_g416.y , ( break63_g416.y + 0.9999999 ) ) );
			half localAND1_g417 = AND1_g417( A1_g417 , B1_g417 );
			half A1_g401 = _DiscardUVTile31;
			half2 break63_g400 = floor( half2( 3,1 ) );
			half2 break61_g400 = DiscardUV200;
			half B1_g401 = ( step( break63_g400.x , break61_g400.x ) * step( break61_g400.x , ( break63_g400.x + 0.9999999 ) ) * step( break63_g400.y , break61_g400.y ) * step( break61_g400.y , ( break63_g400.y + 0.9999999 ) ) );
			half localAND1_g401 = AND1_g401( A1_g401 , B1_g401 );
			half A1_g403 = _DiscardUVTile32;
			half2 break63_g402 = floor( half2( 3,2 ) );
			half2 break61_g402 = DiscardUV200;
			half B1_g403 = ( step( break63_g402.x , break61_g402.x ) * step( break61_g402.x , ( break63_g402.x + 0.9999999 ) ) * step( break63_g402.y , break61_g402.y ) * step( break61_g402.y , ( break63_g402.y + 0.9999999 ) ) );
			half localAND1_g403 = AND1_g403( A1_g403 , B1_g403 );
			half A1_g405 = _DiscardUVTile33;
			half2 break63_g404 = floor( half2( 3,3 ) );
			half2 break61_g404 = DiscardUV200;
			half B1_g405 = ( step( break63_g404.x , break61_g404.x ) * step( break61_g404.x , ( break63_g404.x + 0.9999999 ) ) * step( break63_g404.y , break61_g404.y ) * step( break61_g404.y , ( break63_g404.y + 0.9999999 ) ) );
			half localAND1_g405 = AND1_g405( A1_g405 , B1_g405 );
			half UVTileDiscard192 = ( ( ( localAND1_g419 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g393 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g395 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g397 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) ) + ( ( localAND1_g389 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g399 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g413 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g415 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) ) + ( ( localAND1_g391 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g407 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g409 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g411 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) ) + ( ( localAND1_g417 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g401 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g403 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) + ( localAND1_g405 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 ) ) );
			half UVDiscard730 = UVTileDiscard192;
			half3 temp_cast_0 = (UVDiscard730).xxx;
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
			SurfaceOutputStandard s303 = (SurfaceOutputStandard ) 0;
			half2 appendResult1066 = (half2(_VideoDecalUVs.x , _VideoDecalUVs.y));
			half2 appendResult1067 = (half2(_VideoDecalUVs.z , _VideoDecalUVs.w));
			half2 temp_output_1076_0 = ( ( i.uv_texcoord + ( appendResult1066 * 0.01 ) ) * appendResult1067 );
			float cos7_g323 = cos( _VideoDecalRotation );
			float sin7_g323 = sin( _VideoDecalRotation );
			half2 rotator7_g323 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g323 , -sin7_g323 , sin7_g323 , cos7_g323 )) + float2( 0.5,0.5 );
			half2 break6_g323 = rotator7_g323;
			half VideoDecalAlpha1118 = ( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? 1.0 :  0.0 ) :  0.0 ) * _EnableVideoPlayerDecal );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float cos7_g324 = cos( _VideoDecalRotation );
			float sin7_g324 = sin( _VideoDecalRotation );
			half2 rotator7_g324 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g324 , -sin7_g324 , sin7_g324 , cos7_g324 )) + float2( 0.5,0.5 );
			half2 break6_g324 = rotator7_g324;
			half4 lerpResult1129 = lerp( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? tex2D( _Udon_VideoTex, rotator7_g323 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , (( break6_g324.y >= 0.0 && break6_g324.y <= 1.0 ) ? (( break6_g324.x >= 0.0 && break6_g324.x <= 1.0 ) ? tex2D( _VideoDecalPreview, rotator7_g324 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , _ShowVideoPreview);
			half4 Video_Player_Decal1077 = ( lerpResult1129 * _EnableVideoPlayerDecal );
			half layeredBlendVar1101 = VideoDecalAlpha1118;
			half4 layeredBlend1101 = ( lerp( tex2D( _Albedo, uv_Albedo ),Video_Player_Decal1077 , layeredBlendVar1101 ) );
			half4 mainTex26 = layeredBlend1101;
			s303.Albedo = mainTex26.rgb;
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			half3 normalMap1002 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			s303.Normal = normalize( WorldNormalVector( i , normalMap1002 ) );
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			half4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			half4 color42 = IsGammaSpace() ? half4(1,0,0,1) : half4(1,0,0,1);
			float3 hsvTorgb4_g315 = RGBToHSV( color42.rgb );
			half mulTime48 = _Time.y * _ALTimeScale;
			half Time50 = frac( mulTime48 );
			float3 hsvTorgb8_g315 = HSVToRGB( float3(( hsvTorgb4_g315.x + Time50 ),( hsvTorgb4_g315.y + 0.0 ),( hsvTorgb4_g315.z + 0.0 )) );
			half3 temp_output_194_0 = saturate( hsvTorgb8_g315 );
			int Band3_g316 = 0;
			half clampResult982 = clamp( (0.0 + (i.uv3_texcoord3.y - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (_ALDelayVPosition - 0.0)) , 0.0 , 127.0 );
			half2 appendResult986 = (half2(_ALDelayUPosition , _ALDelayVPosition));
			half2 break18_g310 = appendResult986;
			half2 break20_g310 = i.uv3_texcoord3;
			half temp_output_10_0_g310 = ( break18_g310.x - break20_g310.x );
			half temp_output_11_0_g310 = ( break18_g310.y - break20_g310.y );
			half clampResult27_g310 = clamp( sqrt( ( ( temp_output_10_0_g310 * temp_output_10_0_g310 ) + ( temp_output_11_0_g310 * temp_output_11_0_g310 ) ) ) , 0.0 , 1.0 );
			half clampResult987 = clamp( (0.0 + (clampResult27_g310 - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			half in_ALDelay991 = round( ( _ALUVToggle == 1.0 ? (127.0 + (clampResult982 - 0.0) * (0.0 - 127.0) / (127.0 - 0.0)) : ( _ALUVToggle == 2.0 ? clampResult987 : 0.0 ) ) );
			int Delay3_g316 = (int)in_ALDelay991;
			half localAudioLinkData3_g316 = AudioLinkData3_g316( Band3_g316 , Delay3_g316 );
			half temp_output_8_0_g420 = 1.0;
			half localIfAudioLinkv2Exists1_g421 = IfAudioLinkv2Exists1_g421();
			half temp_output_7_0_g420 = localIfAudioLinkv2Exists1_g421;
			half3 lerpResult6_g420 = lerp( temp_output_194_0 , ( temp_output_194_0 * localAudioLinkData3_g316 ) , ( step( temp_output_8_0_g420 , temp_output_7_0_g420 ) * step( temp_output_7_0_g420 , temp_output_8_0_g420 ) ));
			half3 ALC_Bass61 = lerpResult6_g420;
			half4 color44 = IsGammaSpace() ? half4(0,0.8196079,0,1) : half4(0,0.637597,0,1);
			float3 hsvTorgb4_g59 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g59 = HSVToRGB( float3(( hsvTorgb4_g59.x + Time50 ),( hsvTorgb4_g59.y + 0.0 ),( hsvTorgb4_g59.z + 0.0 )) );
			int Band3_g313 = 2;
			int Delay3_g313 = (int)in_ALDelay991;
			half localAudioLinkData3_g313 = AudioLinkData3_g313( Band3_g313 , Delay3_g313 );
			half3 ALC_HighMid67 = ( saturate( hsvTorgb8_g59 ) * localAudioLinkData3_g313 );
			half4 color43 = IsGammaSpace() ? half4(1,0.9294118,0,1) : half4(1,0.8468735,0,1);
			float3 hsvTorgb4_g38 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g38 = HSVToRGB( float3(( hsvTorgb4_g38.x + Time50 ),( hsvTorgb4_g38.y + 0.0 ),( hsvTorgb4_g38.z + 0.0 )) );
			int Band3_g311 = 1;
			int Delay3_g311 = (int)in_ALDelay991;
			half localAudioLinkData3_g311 = AudioLinkData3_g311( Band3_g311 , Delay3_g311 );
			half3 ALC_LowMid64 = ( saturate( hsvTorgb8_g38 ) * localAudioLinkData3_g311 );
			half4 color45 = IsGammaSpace() ? half4(0,0,1,1) : half4(0,0,1,1);
			float3 hsvTorgb4_g37 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g37 = HSVToRGB( float3(( hsvTorgb4_g37.x + Time50 ),( hsvTorgb4_g37.y + 0.0 ),( hsvTorgb4_g37.z + 0.0 )) );
			int Band3_g314 = 3;
			int Delay3_g314 = (int)in_ALDelay991;
			half localAudioLinkData3_g314 = AudioLinkData3_g314( Band3_g314 , Delay3_g314 );
			half3 ALC_Treble70 = ( saturate( hsvTorgb8_g37 ) * localAudioLinkData3_g314 );
			half localIfAudioLinkv2Exists1_g322 = IfAudioLinkv2Exists1_g322();
			half4 AL_Final85 = ( ( _EnableAudioLink * ( ( ALMask39 * half4( ALC_Bass61 , 0.0 ) ) + ( ALMask39 * half4( ALC_HighMid67 , 0.0 ) ) + ( ALMask39 * half4( ALC_LowMid64 , 0.0 ) ) + ( ALMask39 * half4( ALC_Treble70 , 0.0 ) ) ) ) * saturate( ( localIfAudioLinkv2Exists1_g322 + _ALEmitifInactive ) ) );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			half4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionStrength );
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half fresnelNdotV1402 = dot( (WorldNormalVector( i , normalMap1002 )), ase_worldViewDir );
			half fresnelNode1402 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1402, _RimPower ) );
			half4 lerpResult114 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			float4 Rim116 = ( _EnableRimLighting * ( ( ( fresnelNode1402 * _RimEnergy ) * lerpResult114 ) * ase_lightAtten ) );
			half layeredBlendVar1098 = VideoDecalAlpha1118;
			half4 layeredBlend1098 = ( lerp( ( AL_Final85 + Emission119 + Rim116 ),Video_Player_Decal1077 , layeredBlendVar1098 ) );
			half4 EmissionFinal29 = layeredBlend1098;
			s303.Emission = EmissionFinal29.rgb;
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			half4 tex2DNode1017 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			half2 appendResult1019 = (half2(tex2DNode1017.r , tex2DNode1017.a));
			float2 uv_MultiMap = i.uv_texcoord * _MultiMap_ST.xy + _MultiMap_ST.zw;
			half4 multiMap90 = tex2D( _MultiMap, uv_MultiMap );
			half4 break307 = multiMap90;
			half2 appendResult1015 = (half2(break307.r , break307.g));
			half2 break1020 = ( ( appendResult1019 * _UseUnityMetalicMap ) + ( appendResult1015 * ( 1.0 - _UseUnityMetalicMap ) ) );
			half _Metalic753 = break1020.x;
			s303.Metallic = _Metalic753;
			half _Smoothness755 = break1020.y;
			s303.Smoothness = _Smoothness755;
			s303.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi303 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g303 = UnityGlossyEnvironmentSetup( s303.Smoothness, data.worldViewDir, s303.Normal, float3(0,0,0));
			gi303 = UnityGlobalIllumination( data, s303.Occlusion, s303.Normal, g303 );
			#endif

			float3 surfResult303 = LightingStandard ( s303, viewDir, gi303 ).rgb;
			surfResult303 += s303.Emission;

			#ifdef UNITY_PASS_FORWARDADD//303
			surfResult303 -= s303.Emission;
			#endif//303
			half3 Lighting_Standard309 = surfResult303;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			half3 ase_worldlightDir = 0;
			#else //aseld
			half3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
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
			half4 DiffWrapLighting1363 = saturate( ( saturate( ( DiffWrapStep11229 + saturate( exp2( temp_output_2255_0 ) ) ) ) * saturate( ( saturate( lerpResult1356 ) + half4( saturate( (( exp( saturate( indirectDiffuse1348 ) ) - float3( 1,1,1 ) )*_WrapIndirScale + 0.0) ) , 0.0 ) ) ) ) );
			float3 indirectNormal1410 = normalize( WorldNormalVector( i , normalize( WorldReflectionVector( i , normalMap1002 ) ) ) );
			Unity_GlossyEnvironmentData g1410 = UnityGlossyEnvironmentSetup( _Smoothness755, data.worldViewDir, indirectNormal1410, float3(0,0,0));
			half3 indirectSpecular1410 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal1410, g1410 );
			half fresnelNdotV1393 = dot( (WorldNormalVector( i , normalMap1002 )), ase_worldViewDir );
			half fresnelNode1393 = ( 0.0 + _WrapMetallicFesnelScale * pow( 1.0 - fresnelNdotV1393, 3.0 ) );
			half lerpResult1405 = lerp( fresnelNode1393 , 1.0 , _Metalic753);
			half4 AvatarColor1289 = ( mainTex26 + half4( ( indirectSpecular1410 * lerpResult1405 ) , 0.0 ) );
			half4 Lighting_Wrapped1144 = ( DiffWrapLighting1363 * AvatarColor1289 );
			half temp_output_8_0_g354 = 2.0;
			half LightType793 = _LightingType;
			half temp_output_7_0_g354 = LightType793;
			half4 lerpResult6_g354 = lerp( half4( Lighting_Standard309 , 0.0 ) , Lighting_Wrapped1144 , ( step( temp_output_8_0_g354 , temp_output_7_0_g354 ) * step( temp_output_7_0_g354 , temp_output_8_0_g354 ) ));
			half4 temp_output_2212_0 = lerpResult6_g354;
			half4 LightingFinal330 = temp_output_2212_0;
			c.rgb = LightingFinal330.rgb;
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
			half2 appendResult1066 = (half2(_VideoDecalUVs.x , _VideoDecalUVs.y));
			half2 appendResult1067 = (half2(_VideoDecalUVs.z , _VideoDecalUVs.w));
			half2 temp_output_1076_0 = ( ( i.uv_texcoord + ( appendResult1066 * 0.01 ) ) * appendResult1067 );
			float cos7_g323 = cos( _VideoDecalRotation );
			float sin7_g323 = sin( _VideoDecalRotation );
			half2 rotator7_g323 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g323 , -sin7_g323 , sin7_g323 , cos7_g323 )) + float2( 0.5,0.5 );
			half2 break6_g323 = rotator7_g323;
			half VideoDecalAlpha1118 = ( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? 1.0 :  0.0 ) :  0.0 ) * _EnableVideoPlayerDecal );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float cos7_g324 = cos( _VideoDecalRotation );
			float sin7_g324 = sin( _VideoDecalRotation );
			half2 rotator7_g324 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g324 , -sin7_g324 , sin7_g324 , cos7_g324 )) + float2( 0.5,0.5 );
			half2 break6_g324 = rotator7_g324;
			half4 lerpResult1129 = lerp( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? tex2D( _Udon_VideoTex, rotator7_g323 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , (( break6_g324.y >= 0.0 && break6_g324.y <= 1.0 ) ? (( break6_g324.x >= 0.0 && break6_g324.x <= 1.0 ) ? tex2D( _VideoDecalPreview, rotator7_g324 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , _ShowVideoPreview);
			half4 Video_Player_Decal1077 = ( lerpResult1129 * _EnableVideoPlayerDecal );
			half layeredBlendVar1101 = VideoDecalAlpha1118;
			half4 layeredBlend1101 = ( lerp( tex2D( _Albedo, uv_Albedo ),Video_Player_Decal1077 , layeredBlendVar1101 ) );
			half4 mainTex26 = layeredBlend1101;
			o.Albedo = mainTex26.rgb;
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			half4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			half4 color42 = IsGammaSpace() ? half4(1,0,0,1) : half4(1,0,0,1);
			float3 hsvTorgb4_g315 = RGBToHSV( color42.rgb );
			half mulTime48 = _Time.y * _ALTimeScale;
			half Time50 = frac( mulTime48 );
			float3 hsvTorgb8_g315 = HSVToRGB( float3(( hsvTorgb4_g315.x + Time50 ),( hsvTorgb4_g315.y + 0.0 ),( hsvTorgb4_g315.z + 0.0 )) );
			half3 temp_output_194_0 = saturate( hsvTorgb8_g315 );
			int Band3_g316 = 0;
			half clampResult982 = clamp( (0.0 + (i.uv3_texcoord3.y - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (_ALDelayVPosition - 0.0)) , 0.0 , 127.0 );
			half2 appendResult986 = (half2(_ALDelayUPosition , _ALDelayVPosition));
			half2 break18_g310 = appendResult986;
			half2 break20_g310 = i.uv3_texcoord3;
			half temp_output_10_0_g310 = ( break18_g310.x - break20_g310.x );
			half temp_output_11_0_g310 = ( break18_g310.y - break20_g310.y );
			half clampResult27_g310 = clamp( sqrt( ( ( temp_output_10_0_g310 * temp_output_10_0_g310 ) + ( temp_output_11_0_g310 * temp_output_11_0_g310 ) ) ) , 0.0 , 1.0 );
			half clampResult987 = clamp( (0.0 + (clampResult27_g310 - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			half in_ALDelay991 = round( ( _ALUVToggle == 1.0 ? (127.0 + (clampResult982 - 0.0) * (0.0 - 127.0) / (127.0 - 0.0)) : ( _ALUVToggle == 2.0 ? clampResult987 : 0.0 ) ) );
			int Delay3_g316 = (int)in_ALDelay991;
			half localAudioLinkData3_g316 = AudioLinkData3_g316( Band3_g316 , Delay3_g316 );
			half temp_output_8_0_g420 = 1.0;
			half localIfAudioLinkv2Exists1_g421 = IfAudioLinkv2Exists1_g421();
			half temp_output_7_0_g420 = localIfAudioLinkv2Exists1_g421;
			half3 lerpResult6_g420 = lerp( temp_output_194_0 , ( temp_output_194_0 * localAudioLinkData3_g316 ) , ( step( temp_output_8_0_g420 , temp_output_7_0_g420 ) * step( temp_output_7_0_g420 , temp_output_8_0_g420 ) ));
			half3 ALC_Bass61 = lerpResult6_g420;
			half4 color44 = IsGammaSpace() ? half4(0,0.8196079,0,1) : half4(0,0.637597,0,1);
			float3 hsvTorgb4_g59 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g59 = HSVToRGB( float3(( hsvTorgb4_g59.x + Time50 ),( hsvTorgb4_g59.y + 0.0 ),( hsvTorgb4_g59.z + 0.0 )) );
			int Band3_g313 = 2;
			int Delay3_g313 = (int)in_ALDelay991;
			half localAudioLinkData3_g313 = AudioLinkData3_g313( Band3_g313 , Delay3_g313 );
			half3 ALC_HighMid67 = ( saturate( hsvTorgb8_g59 ) * localAudioLinkData3_g313 );
			half4 color43 = IsGammaSpace() ? half4(1,0.9294118,0,1) : half4(1,0.8468735,0,1);
			float3 hsvTorgb4_g38 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g38 = HSVToRGB( float3(( hsvTorgb4_g38.x + Time50 ),( hsvTorgb4_g38.y + 0.0 ),( hsvTorgb4_g38.z + 0.0 )) );
			int Band3_g311 = 1;
			int Delay3_g311 = (int)in_ALDelay991;
			half localAudioLinkData3_g311 = AudioLinkData3_g311( Band3_g311 , Delay3_g311 );
			half3 ALC_LowMid64 = ( saturate( hsvTorgb8_g38 ) * localAudioLinkData3_g311 );
			half4 color45 = IsGammaSpace() ? half4(0,0,1,1) : half4(0,0,1,1);
			float3 hsvTorgb4_g37 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g37 = HSVToRGB( float3(( hsvTorgb4_g37.x + Time50 ),( hsvTorgb4_g37.y + 0.0 ),( hsvTorgb4_g37.z + 0.0 )) );
			int Band3_g314 = 3;
			int Delay3_g314 = (int)in_ALDelay991;
			half localAudioLinkData3_g314 = AudioLinkData3_g314( Band3_g314 , Delay3_g314 );
			half3 ALC_Treble70 = ( saturate( hsvTorgb8_g37 ) * localAudioLinkData3_g314 );
			half localIfAudioLinkv2Exists1_g322 = IfAudioLinkv2Exists1_g322();
			half4 AL_Final85 = ( ( _EnableAudioLink * ( ( ALMask39 * half4( ALC_Bass61 , 0.0 ) ) + ( ALMask39 * half4( ALC_HighMid67 , 0.0 ) ) + ( ALMask39 * half4( ALC_LowMid64 , 0.0 ) ) + ( ALMask39 * half4( ALC_Treble70 , 0.0 ) ) ) ) * saturate( ( localIfAudioLinkv2Exists1_g322 + _ALEmitifInactive ) ) );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			half4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionStrength );
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			half3 normalMap1002 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			half fresnelNdotV1402 = dot( (WorldNormalVector( i , normalMap1002 )), ase_worldViewDir );
			half fresnelNode1402 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1402, _RimPower ) );
			half4 lerpResult114 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			float4 Rim116 = ( _EnableRimLighting * ( ( ( fresnelNode1402 * _RimEnergy ) * lerpResult114 ) * 1 ) );
			half layeredBlendVar1098 = VideoDecalAlpha1118;
			half4 layeredBlend1098 = ( lerp( ( AL_Final85 + Emission119 + Rim116 ),Video_Player_Decal1077 , layeredBlendVar1098 ) );
			half4 EmissionFinal29 = layeredBlend1098;
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				o.customPack1.zw = customInputData.uv3_texcoord3;
				o.customPack1.zw = v.texcoord2;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				surfIN.uv3_texcoord3 = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
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
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;2050;-2736.134,-7266.054;Inherit;False;1309.322;570.2998;Comment;13;1015;1020;1094;1092;1093;1019;1091;753;755;1014;1017;308;307;Metallic and Smoothness (Multimap vs Unity Metallic Map);1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1276;-689.4099,-8962.246;Inherit;False;2540.031;1700.906;Comment;5;1277;1278;1279;1313;1365;Diffuse Wrapped;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1365;1219.183,-8837.781;Inherit;False;584.9199;216.6494;Comment;4;1219;1290;1144;1364;Final Assembly;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1313;203.8962,-8866.401;Inherit;False;969.559;661.3575;Comment;17;1289;1312;1405;1309;1217;1410;1306;1393;1411;1400;1396;1399;1395;1394;1310;1307;1497;Reflections;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1279;-663.6116,-8147.37;Inherit;False;1759.4;542.5529;I really hated this bit;28;2306;1363;2305;2302;1355;2257;2290;2260;1326;2259;2288;2286;1389;2291;2289;2285;1388;2255;1390;2283;1348;2258;1347;2256;1274;1273;1362;1356;Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1278;-635.8955,-8868.259;Inherit;False;795.2947;355.6133;Comment;10;1229;1216;1211;1208;1210;1213;1214;1255;1392;2254;Wrapping;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1277;-625.4538,-8465.168;Inherit;False;532.9998;163;Comment;2;1207;1209;Wrap Value;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1275;-585.7518,-9738.513;Inherit;False;735.2146;441.0371;Dot Product of Normal and Light Dir;8;2266;2265;2264;1204;1254;1206;1205;1203;NdotL;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;326;1907.217,-5775.348;Inherit;False;1038.421;993.8057;Comment;9;1155;1148;330;1156;1146;329;1149;328;1157;Pick Lighting Type;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1157;1973.18,-5641.242;Inherit;False;467.9048;169.6509;Comment;2;331;793;Light Type Register;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1110;-4777.827,-3708.893;Inherit;False;2225.059;1150.243;Comment;20;1118;1136;1074;1124;1135;1129;1108;1081;1077;1121;1053;1075;1112;1111;1076;1071;1064;1067;1066;1083;Video Player Decal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1007;-8252.399,-4786.937;Inherit;False;330;858.978;Comment;4;1005;1003;1006;1004;Fallback Textures;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;854;1549.401,-6831.974;Inherit;False;1363.141;376.2364;Comment;6;848;845;847;951;844;849;Light Ramp;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;732;4078.449,-1883.351;Inherit;False;626.3779;265.5669;Comment;2;729;730;Combine UV Discards;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;220;2051.233,-3370.865;Inherit;False;962.8354;715.8684;Comment;5;0;33;32;193;332;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;201;202.1576,-813.593;Inherit;False;861.1718;446.9373;Comment;2;200;1027;Discard UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-23.66935,-4536.875;Inherit;False;1663.516;958.884;Comment;21;85;1043;1037;71;415;416;84;83;82;81;80;79;78;76;77;75;74;73;1044;1046;2263;AudioLink Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;106;-112.9787,-5381.73;Inherit;False;1183.572;355.2229;Comment;5;57;69;70;45;1011;AudioLink Treble;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;105;-86.35403,-5893.254;Inherit;False;1188.215;403.241;Comment;6;67;66;56;44;197;1010;AudioLink HighMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-1337.905,-5407.259;Inherit;False;1137.62;367.6456;Comment;7;64;63;55;43;1008;996;196;AudioLink LowMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-1401.04,-5944.659;Inherit;False;1232.821;441.5522;Comment;10;1012;2213;61;58;42;51;995;1009;194;2292;AudioLink Bass;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1818.04,-4819.045;Inherit;False;712.9634;194.3457;Comment;4;243;48;49;50;Time;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-7417.041,-1620.861;Inherit;False;859.9141;343.3768;Comment;3;737;34;1002;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;31;-278.7401,-2122.503;Inherit;False;1194.286;795.1765;Comment;8;1098;1079;30;28;122;86;29;1120;Emission Combination;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;27;-7513.137,-3602.244;Inherit;False;1683.726;597.8718;Comment;6;736;25;26;1090;1101;1119;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1;-3015.296,-577.5867;Inherit;False;1747.943;601.6742;Comment;15;333;116;334;947;917;114;115;113;112;88;87;1404;1403;12;1402;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;38;-1849.337,-3502.624;Inherit;False;604.8932;280;Comment;2;40;39;AL Emission Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1329.076,-4762.699;Inherit;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;89;-813.4411,-2813.33;Inherit;False;604.8932;280;R = Metalic, G = Smoothness;2;91;90;MultiMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-424.5481,-2761.528;Inherit;False;multiMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;637.4441,-5280.506;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;846.5929,-5305.182;Inherit;False;ALC_Treble;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;26.33066,-4372.526;Inherit;False;61;ALC_Bass;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;211.3306,-4443.526;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;42.57924,-4245.578;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;227.1167,-4202.23;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;42.11675,-4131.23;Inherit;False;67;ALC_HighMid;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;67.26691,-4009.6;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;251.8044,-3966.252;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;67.80442,-3895.252;Inherit;False;64;ALC_LowMid;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;76.93356,-3805.6;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;261.471,-3762.253;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;77.47105,-3691.253;Inherit;False;70;ALC_Treble;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;534.6252,-4158.036;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;117;-1853.104,-2983.999;Inherit;False;791.7242;362.8555;Comment;4;120;119;118;121;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;-1276.658,-2924.725;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1771.553,-2723.966;Inherit;False;Property;_EmissionStrength;Emission Strength;21;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-1444.109,-2847.282;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;43;-1294.715,-5338.324;Inherit;False;Constant;_AL_LowMid;AL_LowMid;6;0;Create;True;0;0;0;False;0;False;1,0.9294118,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-644.6395,-5299.407;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-415.1543,-5306.091;Inherit;False;ALC_LowMid;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;665.2375,-5831.361;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;138;1465.541,-1401.771;Inherit;False;3237.51;1806.072;Comment;60;191;192;222;802;801;768;208;636;635;207;767;640;773;212;772;639;211;771;210;638;637;213;641;644;777;216;643;776;215;642;214;775;774;770;209;766;634;206;765;270;764;204;632;763;631;203;762;633;630;629;198;224;223;225;205;202;180;167;154;149;UV Tile Discard;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;195;343.6559,-5323.875;Inherit;False;HueShift;-1;;37;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;196;-907.4175,-5335.405;Inherit;False;HueShift;-1;;38;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;217;4137.307,-4147.085;Inherit;False;420.8079;185;Comment;2;219;218;Declare NaN;1,1,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2759.068,-3220.523;Half;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;VoyVivika/VivikaShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Standard;-1;-1;-1;-1;1;VRCFallback=DoubleSided;False;0;0;True;_CullMode;-1;0;False;;1;Include;Libs\AudioLink\AudioLink.cginc;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SamplerNode;118;-1797.104,-2926.999;Inherit;True;Property;_Emission;Emission;20;0;Create;True;0;0;0;False;0;False;-1;83f90c05f51ea5c469ceb2c4218b09a7;83f90c05f51ea5c469ceb2c4218b09a7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;49;-1440.809,-4759.045;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-1786.835,-4764.416;Inherit;False;Property;_ALTimeScale;AL Time Scale;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;302;-1563.27,-8951.487;Inherit;False;791.165;482.8682;Comment;7;2049;2048;306;304;305;309;303;Standard Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;416;787.8911,-4176.061;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;197;368.8238,-5818.455;Inherit;False;HueShift;-1;;59;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;415;478.4037,-4285.905;Half;False;Property;_EnableAudioLink;Enable AudioLink;12;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;-795.4411,-2748.33;Inherit;True;Property;_MultiMap;MultiMap;8;0;Create;True;0;0;0;False;0;False;-1;01e8d4996fddd0a448744957657de587;01e8d4996fddd0a448744957657de587;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-7141.458,-3513.226;Inherit;True;Property;_AlbedoSample;Albedo Sample;3;0;Create;True;0;0;0;False;0;False;-1;0db631ddb1a2c1443b81c6ac5ce43d11;0db631ddb1a2c1443b81c6ac5ce43d11;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;149;2103.135,-435.5835;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;154;2890.493,-401.2814;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;3686.68,-527.5339;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;4481.771,-529.569;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;202;1533.318,-660.1951;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;2294.606,-865.7911;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;225;2205.348,-1117.688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;223;3826.804,-1027.133;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;224;3041,-1077.105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;630;1538.705,-578.879;Inherit;False;Constant;_Vector1;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;633;2324.538,-773.1622;Inherit;False;Constant;_Vector4;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;762;1499.583,-759.6893;Inherit;False;Property;_DiscardUVTile01;Discard UV Tile 0,1;27;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;203;1536.018,-316.3951;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;631;1566.422,-217.064;Inherit;False;Constant;_Vector2;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;763;1496.973,-427.7367;Inherit;False;Property;_DiscardUVTile02;Discard UV Tile 0,2;28;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;632;1594.787,113.182;Inherit;False;Constant;_Vector3;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;204;1570.418,24.20495;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;764;1518.973,-60.73669;Inherit;False;Property;_DiscardUVTile03;Discard UV Tile 0,3;29;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;765;2249.126,-963.5736;Inherit;False;Property;_DiscardUVTile10;Discard UV Tile 1,0;30;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;2357.974,-536.9484;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;634;2385.538,-462.1622;Inherit;False;Constant;_Vector5;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;766;2259.126,-613.5735;Inherit;False;Property;_DiscardUVTile11;Discard UV Tile 1,1;31;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;3140.744,-871.4884;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;770;3041.102,-947.6624;Inherit;False;Property;_DiscardUVTile20;Discard UV Tile 2,0;34;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;774;3842.005,-910.9678;Inherit;False;Property;_DiscardUVTile30;Discard UV Tile 3,0;39;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;775;3839.91,-560.7627;Inherit;False;Property;_DiscardUVTile31;Discard UV Tile 3,1;38;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;214;3904.62,-483.9957;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;642;3933.447,-413.097;Inherit;False;Constant;_Vector13;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;215;3912.915,-182.604;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;776;3813.138,-254.3136;Inherit;False;Property;_DiscardUVTile32;Discard UV Tile 3,2;40;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;643;3940.676,-112.648;Inherit;False;Constant;_Vector14;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;216;3914.689,128.2034;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;777;3814.721,53.09606;Inherit;False;Property;_DiscardUVTile33;Discard UV Tile 3,3;41;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;644;3945.259,200.7619;Inherit;False;Constant;_Vector15;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;641;3964.222,-753.2794;Inherit;False;Constant;_Vector12;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;213;3933.363,-828.7961;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;637;3166.819,-795.8944;Inherit;False;Constant;_Vector8;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;638;3179.013,-479.2932;Inherit;False;Constant;_Vector9;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;210;3150.812,-564.5684;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;771;3055.927,-642.5212;Inherit;False;Property;_DiscardUVTile21;Discard UV Tile 2,1;35;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;3164.474,-249.9562;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;639;3189.3,-170.453;Inherit;False;Constant;_Vector10;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;772;3061.227,-323.6906;Inherit;False;Property;_DiscardUVTile22;Discard UV Tile 2,2;36;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;3166.697,60.64629;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;773;3067.304,-14.54724;Inherit;False;Property;_DiscardUVTile23;Discard UV Tile 2,3;37;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;640;3192.601,137.0375;Inherit;False;Constant;_Vector11;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;767;2251.573,-307.925;Inherit;False;Property;_DiscardUVTile12;Discard UV Tile 1,2;32;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;2353.001,-233.3764;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;635;2382.081,-156.652;Inherit;False;Constant;_Vector6;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;636;2388.87,155.4928;Inherit;False;Constant;_Vector7;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;208;2361.729,79.19774;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;768;2260.751,5.167598;Inherit;False;Property;_DiscardUVTile13;Discard UV Tile 1,3;33;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;801;4579.42,-570.3809;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;802;4497.627,-688.764;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;222;4161.278,-1049.713;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;4249.063,-1173.994;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;1497.07,-1070.585;Inherit;False;Property;_DiscardUVTile00;Discard UV Tile 0,0;26;2;[Header];[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;629;1539.432,-900.3254;Inherit;False;Constant;_Vector0;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;193;2351.81,-2859.997;Inherit;False;730;UVDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-1793.337,-3445.624;Inherit;True;Property;_AL_Mask;AudioLink Mask;14;0;Create;False;0;0;0;False;0;False;-1;83f90c05f51ea5c469ceb2c4218b09a7;83f90c05f51ea5c469ceb2c4218b09a7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;977;-3566.635,-6071.09;Inherit;False;1927.026;711.7993;Comment;16;993;992;991;989;988;987;986;985;984;983;982;981;979;978;999;1028;UV Delay AudioLink;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;-1864.02,-5845.763;Inherit;False;in_ALDelay;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1082.38,-5260.526;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-77.97868,-5324.461;Inherit;False;Constant;_AL_Treble;AL_Treble;6;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;57;134.7981,-5255.021;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;44;-43.51395,-5829.144;Inherit;False;Constant;_AL_HighMid;AL_HighMid;6;0;Create;True;0;0;0;False;0;False;0,0.8196079,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;56;168.1703,-5754.85;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;880.6917,-5833.153;Inherit;False;ALC_HighMid;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;996;-1143.704,-5124.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;997;33.29614,-5111.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;998;49.29614,-5600.545;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;978;-3524.537,-5819.039;Inherit;False;Property;_ALDelayVPosition;AL Delay V Position;17;0;Create;True;0;0;0;False;0;False;0.83;0.83;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;983;-2522.057,-5938.445;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;3;FLOAT;127;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;985;-2014.866,-5847.629;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;989;-2174.397,-5826.617;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;993;-2685.484,-5629.869;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;992;-2939.719,-5661.353;Inherit;False;Distance;-1;;310;5a463ec6a2137ce40abfe8c530112fe4;0;2;17;FLOAT2;0,0;False;19;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;984;-2526.103,-5758.253;Inherit;False;Property;_ALUVToggle;Delay for AL;15;1;[Enum];Create;False;0;3;None;0;UV Vertical;1;Distance;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;986;-3145.573,-5659.957;Inherit;False;FLOAT2;4;0;FLOAT;0.5;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;981;-2908.014,-6001.174;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;979;-3552.83,-5722.939;Inherit;False;Property;_ALUVDelayMaxDelay;AL UV Delay Max Delay;18;0;Create;True;0;0;0;False;0;False;0;127;0;127;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;999;-3524.789,-5897.548;Inherit;False;Property;_ALDelayUPosition;AL Delay U Position;16;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1002;-6766.544,-1491.989;Inherit;False;normalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;34;-7090.542,-1509.947;Inherit;True;Property;_NMSample;NM Sample;4;0;Create;True;0;0;0;False;0;False;-1;13ce54de7ec2bdd45a3ceb8a5e5e4cad;1f3982b36e89bca46b80f47660759b39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;737;-7386.651,-1509.456;Inherit;True;Property;_NormalMap;Normal Map;5;0;Create;True;0;0;0;False;0;False;0f9978e19d98bb04b8f2ce5197640506;0f9978e19d98bb04b8f2ce5197640506;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;1008;-913.0733,-5171.95;Inherit;False;4BandAmplitude;-1;;311;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;1;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1010;368.6584,-5617.326;Inherit;False;4BandAmplitude;-1;;313;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;2;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1011;331.6262,-5142.257;Inherit;False;4BandAmplitude;-1;;314;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;3;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;1543.344,-979.7899;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1028;-3505.115,-6027.419;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1470.095,-3451.473;Inherit;False;ALMask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;194;-960.5157,-5788.812;Inherit;False;HueShift;-1;;315;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1009;-973.2197,-5635.942;Inherit;False;4BandAmplitude;-1;;316;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;0;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;995;-1251.419,-5630.939;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1153.306,-5711.634;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;-1362.825,-5809.147;Inherit;False;Constant;_AL_Bass;AL_Bass;6;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;71;20.79314,-4476.875;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;1389.661,-4179.093;Inherit;False;AL_Final;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1037;743,-4376;Inherit;False;Property;_ALEmitifInactive;AL Emit if Inactive;13;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1043;743,-4456;Inherit;False;IsAudioLink;-1;;322;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1044;977.5732,-4431.625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1046;1214.24,-4177.113;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;736;-7467.361,-3512.755;Inherit;True;Property;_Albedo;Albedo;4;0;Create;True;0;0;0;False;0;False;0db631ddb1a2c1443b81c6ac5ce43d11;7a3af6d336f8abd4fb3c0a3c5258c085;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;1003;-8229.402,-4736.937;Inherit;True;Property;_MainTex;Fallback Albedo;47;2;[Header];[SingleLineTexture];Create;False;1;Standard Fallbacks;0;0;True;0;False;None;7a3af6d336f8abd4fb3c0a3c5258c085;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;1004;-8234.402,-4540.937;Inherit;True;Property;_EmissionMap;Fallback Emission Map;49;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;1005;-8203.402,-4345.939;Inherit;False;Property;_EmissionColor;Fallback Emission Color;50;0;Create;False;0;0;0;True;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1006;-8231.174,-4149.961;Inherit;True;Property;_BumpMap;Fallback Normal Map;51;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;1047;-7527.922,-4553.556;Inherit;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;2286.262,-3320.865;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;2301.754,-3145.94;Inherit;False;29;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;332;2519.215,-2995.611;Inherit;False;330;LightingFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1090;-7076.994,-3314.285;Inherit;False;1077;Video Player Decal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-6139.787,-3510.114;Inherit;False;mainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;699.295,-1985.41;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-182.0128,-2051.763;Inherit;False;85;AL_Final;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-180.3152,-1961.81;Inherit;False;119;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-182.0909,-1878.577;Inherit;False;116;Rim;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;24.13739,-1985.716;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LayeredBlendNode;1098;366.2708,-1963.705;Inherit;True;6;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LayeredBlendNode;1101;-6423.06,-3428.237;Inherit;True;6;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1079;-82.32339,-1724.547;Inherit;False;1077;Video Player Decal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1119;-6822.949,-3227.708;Inherit;False;1118;VideoDecalAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1083;-3667.103,-3648.907;Inherit;False;Property;_EnableVideoPlayerDecal;Enable Video Player Decal;42;2;[Header];[ToggleUI];Create;True;1;Video Player Decal;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1066;-4445.004,-3141;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1067;-4439.004,-3027;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;1064;-4696.004,-3121;Inherit;False;Property;_VideoDecalUVs;Video Decal Coordinates;45;1;[Header];Create;False;2;X and Y are Position;Z and W are Tiling (Size);0;0;False;0;False;0.01,-0.29,1.29,1.4;0.01,-0.29,1.29,1.4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1071;-4117.007,-2984.2;Inherit;False;Property;_VideoDecalRotation;Video Decal Rotation;46;0;Create;True;0;0;0;False;0;False;-0.15;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1076;-3967.025,-3143.215;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1111;-4280.878,-3263.277;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1112;-4469.494,-3288.354;Inherit;False;Constant;_Float1;Float 1;56;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1075;-4081.008,-3341;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;1053;-4046.878,-3543.225;Inherit;True;Global;_Udon_VideoTex;_Udon_VideoTex;48;0;Create;True;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1121;-3119.618,-3508.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1077;-2825.569,-3288.123;Inherit;True;Video Player Decal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1081;-3019.766,-3288.592;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1108;-3615.98,-2997.36;Inherit;False;Property;_ShowVideoPreview;Show Preview;43;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1129;-3335.079,-3162.252;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1135;-3750.112,-3263.333;Inherit;True;Decal;-1;;323;c7a5994071b70f8448ea324b9d90affe;0;4;9;SAMPLER2D;;False;15;FLOAT2;0,0;False;12;FLOAT2;0.5,0.5;False;14;FLOAT;0;False;2;COLOR;0;FLOAT;19
Node;AmplifyShaderEditor.TexturePropertyNode;1124;-4076.226,-2837.161;Inherit;True;Property;_VideoDecalPreview;Video Decal Preview;44;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;1074;-4417.019,-3434.575;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1136;-3737.754,-2892.921;Inherit;True;Decal;-1;;324;c7a5994071b70f8448ea324b9d90affe;0;4;9;SAMPLER2D;;False;15;FLOAT2;0,0;False;12;FLOAT2;0.5,0.5;False;14;FLOAT;0;False;2;COLOR;0;FLOAT;19
Node;AmplifyShaderEditor.RegisterLocalVarNode;793;2199.086,-5591.242;Inherit;False;LightType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;328;2047.839,-4902.87;Inherit;False;309;Lighting_Standard;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1149;2063.787,-5036.328;Inherit;False;1144;Lighting Wrapped;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1156;2264.553,-5411.804;Inherit;False;793;LightType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1148;2126.788,-5110.328;Inherit;False;Constant;_Wrap;Wrap;57;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1155;2095.441,-5183.049;Inherit;False;793;LightType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;303;-1238.217,-8849.06;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1209;-343.803,-8399.448;Inherit;False;wrap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1207;-595.0138,-8399.448;Inherit;False;Property;_WrappedShadingValue;Wrapped Shading Value;2;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1356;-223.8023,-7946.047;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1214;-610.8956,-8609.429;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1213;-577.4956,-8681.038;Inherit;False;Constant;_Float5;Float 5;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1210;-609.1375,-8752.229;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1208;-428.9675,-8799.349;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1211;-429.6955,-8655.028;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1216;-317.6825,-8734.219;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1307;225.4403,-8737.2;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;1402;-2614.978,-488.5381;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-2893.793,-360.0198;Float;False;Property;_RimPower;Rim Power;23;0;Create;True;0;0;0;False;0;False;2.07;4.59;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1403;-2804.755,-508.1996;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1404;-2982.611,-503.9109;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2609.424,-263.4352;Inherit;False;Property;_RimEnergy;Rim Energy;24;0;Create;True;0;0;0;False;0;False;0.345;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-2310.461,-419.0966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-2506.489,-175.899;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2586.488,-95.89901;Inherit;False;Property;_RimBaseColorStrength;Rim Base Color Strength;25;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-2065.188,-311.7364;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;114;-2302.951,-231.8736;Inherit;True;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;917;-2062.818,-92.66876;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;947;-1844.695,-310.7548;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-1646.833,-373.174;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-1505.769,-367.0093;Float;True;Rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;333;-2046.536,-386.2678;Half;False;Property;_EnableRimLighting;Enable Rim Lighting;22;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1411;319.6755,-8660.635;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1362;-641.9432,-8004.586;Inherit;False;Constant;_Color1;Color 1;57;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;1273;-644.3822,-8087.2;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;1274;-575.0458,-7825.367;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;1364;1237.083,-8792.199;Inherit;False;1363;DiffWrapLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1144;1588.004,-8748.269;Inherit;False;Lighting Wrapped;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1146;2296.102,-5339.675;Inherit;False;Constant;_Toon;Toon;57;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;2023.18,-5584.591;Inherit;False;Property;_LightingType;Lighting Type;1;1;[Enum];Create;True;0;2;Standard;0;Wrapped;2;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1290;1239.383,-8718.735;Inherit;False;1289;AvatarColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1219;1446.342,-8765.479;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;849;2667.604,-6767.484;Inherit;True;TexRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;951;2157.633,-6722.786;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;847;1898.656,-6723.437;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;848;1622.875,-6667.49;Inherit;False;Property;_ScaleOffset;Tex Ramp Scale & Offset;7;0;Create;False;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;844;2382.544,-6756.269;Inherit;True;Property;_FlatTextureRamp;Flat Texture Ramp;6;1;[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;4a1a20e176d86f64695ccaa972459e52;4a1a20e176d86f64695ccaa972459e52;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldReflectionVector;1306;399.0909,-8818.546;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IndirectSpecularLight;1410;621.2794,-8721.35;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Exp2OpNode;1392;-239.7461,-8819.095;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;218;4187.307,-4097.085;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1217;651.2765,-8810.721;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1309;862.5243,-8730.229;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1405;835.5076,-8583.534;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1312;1004.922,-8818.9;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1289;910.5255,-8316.494;Inherit;False;AvatarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1310;649.3949,-8536.466;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1393;590.2901,-8431.656;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1394;396.9293,-8565.68;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1395;225.4145,-8563.272;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1396;219.8134,-8485.77;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;1400;382.4172,-8428.88;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1399;517.4173,-8417.88;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1497;261.7195,-8324.756;Inherit;False;Property;_WrapMetallicFesnelScale;Wrap Metallic Fesnel Scale;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;4390.601,-1188.976;Inherit;False;UVTileDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;730;4480.827,-1793.785;Inherit;False;UVDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;4334.115,-4095.47;Inherit;False;NaN;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1027;471.0703,-684.8264;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;799.3069,-665.868;Inherit;False;DiscardUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;329;2242.849,-5264.512;Inherit;False;-1;;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;330;2652.833,-5141.345;Inherit;False;LightingFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;988;-2330.397,-5697.618;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-711.889,-5717.277;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-379.7261,-5841.099;Inherit;False;ALC_Bass;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;48;-1610.04,-4762.258;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;729;4150.826,-1795.785;Inherit;False;192;UVTileDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;845;1705.331,-6759.567;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1015;-2342.906,-6864.568;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1020;-1877.493,-6965.705;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1094;-1982.059,-6956.215;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1092;-2150.059,-6836.215;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;1093;-2305.058,-6943.215;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1019;-2306.412,-7056.47;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1091;-2131.26,-7011.808;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;753;-1671.29,-6966.677;Inherit;False;_Metalic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;755;-1668.81,-6865.335;Inherit;False;_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1014;-2646.456,-7216.057;Inherit;False;Property;_UseUnityMetalicMap;Use Unity Metalic Map instead of MultiMap;10;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1017;-2664.991,-7082.698;Inherit;True;Property;_MetallicGlossMap;Unity Metallic;9;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;ec89906eae50d364b8e936869463cc5e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;308;-2686.135,-6880.757;Inherit;False;90;multiMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;307;-2494.135,-6880.757;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;309;-1017.022,-8847.999;Inherit;False;Lighting_Standard;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-1508.128,-8738.603;Inherit;False;29;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-1505.828,-8899.902;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-1493.128,-8819.603;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2048;-1490.37,-8646.09;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2049;-1504.37,-8564.09;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2211;2552.985,-5357.156;Inherit;False;If Float Equal;-1;;353;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;COLOR;0,0,0,0;False;10;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2212;2303.705,-5091.534;Inherit;False;If Float Equal;-1;;354;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;COLOR;0,0,0,0;False;10;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2254;-182.7855,-8729.182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2256;-405.2491,-7882.128;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1347;-605.87,-7699.82;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2258;-2.52046,-7886.6;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1229;-44.21987,-8742.948;Inherit;False;DiffWrapStep1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;982;-2691.424,-5940.795;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;987;-2500.677,-5634.63;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2263;1093.691,-4358.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1203;-399.7516,-9524.513;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1205;-432.7515,-9673.513;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1255;-629.1146,-8826.259;Inherit;False;2266;NdotLSaturated;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1206;-202.7514,-9672.513;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1254;-90.77682,-9674.983;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1204;-566.7516,-9531.513;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2264;-392.1232,-9378.447;Inherit;False;1254;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2265;-210.3306,-9386.864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2266;-61.33063,-9391.864;Inherit;False;NdotLSaturated;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2267;2566.127,-818.3905;Inherit;False;UV Tile Discard;-1;;388;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2268;3347.481,-781.8707;Inherit;False;UV Tile Discard;-1;;390;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2269;1803.251,-596.9982;Inherit;False;UV Tile Discard;-1;;392;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2270;1785.751,-378.5684;Inherit;False;UV Tile Discard;-1;;394;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2271;1793.151,-18.96954;Inherit;False;UV Tile Discard;-1;;396;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2272;2535.103,-558.2587;Inherit;False;UV Tile Discard;-1;;398;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2273;4111.194,-549.4994;Inherit;False;UV Tile Discard;-1;;400;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2274;4146.207,-244.9378;Inherit;False;UV Tile Discard;-1;;402;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2275;4104.421,78.95988;Inherit;False;UV Tile Discard;-1;;404;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2276;3330.537,-609.8447;Inherit;False;UV Tile Discard;-1;;406;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2277;3352.062,-280.4475;Inherit;False;UV Tile Discard;-1;;408;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2278;3339.263,55.05388;Inherit;False;UV Tile Discard;-1;;410;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2279;2536.623,-252.0813;Inherit;False;UV Tile Discard;-1;;412;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2280;2532.193,51.46117;Inherit;False;UV Tile Discard;-1;;414;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2281;4142.573,-783.9061;Inherit;False;UV Tile Discard;-1;;416;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2282;1812.015,-856.9457;Inherit;False;UV Tile Discard;-1;;418;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1120;-31.28754,-1624.004;Inherit;False;1118;VideoDecalAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1118;-2900.04,-3519.727;Inherit;False;VideoDecalAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;1348;-411.6209,-7766.015;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2283;-195.8235,-7798.017;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Exp2OpNode;1390;-160.8334,-8055.938;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2255;-386.2491,-8053.128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1388;-38.36267,-8103.424;Inherit;False;1229;DiffWrapStep1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2285;-30.82349,-8025.017;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;2289;-47.40698,-7793.081;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2291;-190.8753,-7710.983;Inherit;False;Property;_WrapIndirScale;Wrapped Indirect Scale;3;0;Create;False;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1389;227.3536,-8061.248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2286;503.1699,-8064.364;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2288;61.8468,-7792.959;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2259;659.0978,-7894.973;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1326;797.5153,-7959.848;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2260;937.5839,-7992.915;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2290;196.4604,-7764.261;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;3;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2257;394.354,-7789;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1355;558.0298,-7879.816;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2302;1010.839,-7916.79;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2305;884.8391,-7857.79;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1363;694.6958,-7796.014;Inherit;False;DiffWrapLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2306;667.8391,-7819.79;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2213;-556.2672,-5832.83;Inherit;False;If Float Equal;-1;;420;bdca1c28487c8a1418e72579bec63589;0;4;7;FLOAT;0;False;8;FLOAT;0;False;9;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2292;-884.269,-5865.682;Inherit;False;Constant;_Float0;Float 0;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1012;-743.153,-5891.785;Inherit;False;IsAudioLink;-1;;421;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
WireConnection;50;0;49;0
WireConnection;90;0;91;0
WireConnection;69;0;195;0
WireConnection;69;1;1011;0
WireConnection;70;0;69;0
WireConnection;74;0;71;0
WireConnection;74;1;73;0
WireConnection;77;0;75;0
WireConnection;77;1;76;0
WireConnection;79;0;78;0
WireConnection;79;1;80;0
WireConnection;82;0;81;0
WireConnection;82;1;83;0
WireConnection;84;0;74;0
WireConnection;84;1;77;0
WireConnection;84;2;79;0
WireConnection;84;3;82;0
WireConnection;119;0;121;0
WireConnection;121;0;118;0
WireConnection;121;1;120;0
WireConnection;63;0;196;0
WireConnection;63;1;1008;0
WireConnection;64;0;63;0
WireConnection;66;0;197;0
WireConnection;66;1;1010;0
WireConnection;195;14;45;0
WireConnection;195;15;57;0
WireConnection;196;14;43;0
WireConnection;196;15;55;0
WireConnection;0;0;33;0
WireConnection;0;2;32;0
WireConnection;0;13;332;0
WireConnection;0;11;193;0
WireConnection;49;0;48;0
WireConnection;416;0;415;0
WireConnection;416;1;84;0
WireConnection;197;14;44;0
WireConnection;197;15;56;0
WireConnection;25;0;736;0
WireConnection;149;0;2282;0
WireConnection;149;1;2269;0
WireConnection;149;2;2270;0
WireConnection;149;3;2271;0
WireConnection;154;0;2267;0
WireConnection;154;1;2272;0
WireConnection;154;2;2279;0
WireConnection;154;3;2280;0
WireConnection;167;0;2268;0
WireConnection;167;1;2276;0
WireConnection;167;2;2277;0
WireConnection;167;3;2278;0
WireConnection;180;0;2281;0
WireConnection;180;1;2273;0
WireConnection;180;2;2274;0
WireConnection;180;3;2275;0
WireConnection;225;0;149;0
WireConnection;223;0;167;0
WireConnection;224;0;154;0
WireConnection;801;0;180;0
WireConnection;802;0;801;0
WireConnection;222;0;802;0
WireConnection;191;0;225;0
WireConnection;191;1;224;0
WireConnection;191;2;223;0
WireConnection;191;3;222;0
WireConnection;991;0;985;0
WireConnection;67;0;66;0
WireConnection;983;0;982;0
WireConnection;985;0;989;0
WireConnection;989;0;984;0
WireConnection;989;2;983;0
WireConnection;989;3;988;0
WireConnection;993;0;992;0
WireConnection;993;4;979;0
WireConnection;992;17;986;0
WireConnection;992;19;1028;0
WireConnection;986;0;999;0
WireConnection;986;1;978;0
WireConnection;981;0;1028;2
WireConnection;981;2;978;0
WireConnection;981;4;979;0
WireConnection;1002;0;34;0
WireConnection;34;0;737;0
WireConnection;1008;4;996;0
WireConnection;1010;4;998;0
WireConnection;1011;4;997;0
WireConnection;39;0;40;0
WireConnection;194;14;42;0
WireConnection;194;15;51;0
WireConnection;1009;4;995;0
WireConnection;85;0;1046;0
WireConnection;1044;0;1043;0
WireConnection;1044;1;1037;0
WireConnection;1046;0;416;0
WireConnection;1046;1;2263;0
WireConnection;26;0;1101;0
WireConnection;29;0;1098;0
WireConnection;30;0;86;0
WireConnection;30;1;122;0
WireConnection;30;2;28;0
WireConnection;1098;0;1120;0
WireConnection;1098;1;30;0
WireConnection;1098;2;1079;0
WireConnection;1101;0;1119;0
WireConnection;1101;1;25;0
WireConnection;1101;2;1090;0
WireConnection;1066;0;1064;1
WireConnection;1066;1;1064;2
WireConnection;1067;0;1064;3
WireConnection;1067;1;1064;4
WireConnection;1076;0;1075;0
WireConnection;1076;1;1067;0
WireConnection;1111;0;1066;0
WireConnection;1111;1;1112;0
WireConnection;1075;0;1074;0
WireConnection;1075;1;1111;0
WireConnection;1121;0;1135;19
WireConnection;1121;1;1083;0
WireConnection;1077;0;1081;0
WireConnection;1081;0;1129;0
WireConnection;1081;1;1083;0
WireConnection;1129;0;1135;0
WireConnection;1129;1;1136;0
WireConnection;1129;2;1108;0
WireConnection;1135;9;1053;0
WireConnection;1135;15;1076;0
WireConnection;1135;14;1071;0
WireConnection;1136;9;1124;0
WireConnection;1136;15;1076;0
WireConnection;1136;14;1071;0
WireConnection;793;0;331;0
WireConnection;303;0;304;0
WireConnection;303;1;306;0
WireConnection;303;2;305;0
WireConnection;303;3;2048;0
WireConnection;303;4;2049;0
WireConnection;1209;0;1207;0
WireConnection;1356;0;1362;0
WireConnection;1356;1;2256;0
WireConnection;1356;2;2255;0
WireConnection;1208;0;1255;0
WireConnection;1208;1;1210;0
WireConnection;1211;0;1213;0
WireConnection;1211;1;1214;0
WireConnection;1216;0;1208;0
WireConnection;1216;1;1211;0
WireConnection;1402;0;1403;0
WireConnection;1402;3;12;0
WireConnection;1403;0;1404;0
WireConnection;88;0;1402;0
WireConnection;88;1;87;0
WireConnection;115;0;88;0
WireConnection;115;1;114;0
WireConnection;114;1;112;0
WireConnection;114;2;113;0
WireConnection;947;0;115;0
WireConnection;947;1;917;0
WireConnection;334;0;333;0
WireConnection;334;1;947;0
WireConnection;116;0;334;0
WireConnection;1144;0;1219;0
WireConnection;1219;0;1364;0
WireConnection;1219;1;1290;0
WireConnection;849;0;844;0
WireConnection;951;0;847;0
WireConnection;847;0;845;0
WireConnection;847;1;848;0
WireConnection;847;2;848;0
WireConnection;844;1;951;0
WireConnection;1306;0;1307;0
WireConnection;1410;0;1306;0
WireConnection;1410;1;1411;0
WireConnection;1392;0;1216;0
WireConnection;1309;0;1410;0
WireConnection;1309;1;1405;0
WireConnection;1405;0;1393;0
WireConnection;1405;2;1310;0
WireConnection;1312;0;1217;0
WireConnection;1312;1;1309;0
WireConnection;1289;0;1312;0
WireConnection;1393;0;1394;0
WireConnection;1393;4;1399;0
WireConnection;1393;2;1497;0
WireConnection;1394;0;1395;0
WireConnection;1400;0;1396;0
WireConnection;1399;0;1400;0
WireConnection;192;0;191;0
WireConnection;730;0;729;0
WireConnection;219;0;218;0
WireConnection;200;0;1027;0
WireConnection;330;0;2212;0
WireConnection;988;0;984;0
WireConnection;988;2;987;0
WireConnection;58;0;194;0
WireConnection;58;1;1009;0
WireConnection;61;0;2213;0
WireConnection;48;0;243;0
WireConnection;1015;0;307;0
WireConnection;1015;1;307;1
WireConnection;1020;0;1094;0
WireConnection;1094;0;1091;0
WireConnection;1094;1;1092;0
WireConnection;1092;0;1015;0
WireConnection;1092;1;1093;0
WireConnection;1093;0;1014;0
WireConnection;1019;0;1017;1
WireConnection;1019;1;1017;4
WireConnection;1091;0;1019;0
WireConnection;1091;1;1014;0
WireConnection;753;0;1020;0
WireConnection;755;0;1020;1
WireConnection;307;0;308;0
WireConnection;309;0;303;0
WireConnection;2211;7;1156;0
WireConnection;2211;8;1146;0
WireConnection;2211;9;329;0
WireConnection;2211;10;2212;0
WireConnection;2212;7;1155;0
WireConnection;2212;8;1148;0
WireConnection;2212;9;1149;0
WireConnection;2212;10;328;0
WireConnection;2254;0;1392;0
WireConnection;2256;0;1274;0
WireConnection;2258;0;1356;0
WireConnection;1229;0;2254;0
WireConnection;982;0;981;0
WireConnection;987;0;993;0
WireConnection;2263;0;1044;0
WireConnection;1203;0;1204;0
WireConnection;1206;0;1205;0
WireConnection;1206;1;1203;0
WireConnection;1254;0;1206;0
WireConnection;2265;0;2264;0
WireConnection;2266;0;2265;0
WireConnection;2267;21;765;0
WireConnection;2267;6;205;0
WireConnection;2267;10;633;0
WireConnection;2268;21;770;0
WireConnection;2268;6;209;0
WireConnection;2268;10;637;0
WireConnection;2269;21;762;0
WireConnection;2269;6;202;0
WireConnection;2269;10;630;0
WireConnection;2270;21;763;0
WireConnection;2270;6;203;0
WireConnection;2270;10;631;0
WireConnection;2271;21;764;0
WireConnection;2271;6;204;0
WireConnection;2271;10;632;0
WireConnection;2272;21;766;0
WireConnection;2272;6;206;0
WireConnection;2272;10;634;0
WireConnection;2273;21;775;0
WireConnection;2273;6;214;0
WireConnection;2273;10;642;0
WireConnection;2274;21;776;0
WireConnection;2274;6;215;0
WireConnection;2274;10;643;0
WireConnection;2275;21;777;0
WireConnection;2275;6;216;0
WireConnection;2275;10;644;0
WireConnection;2276;21;771;0
WireConnection;2276;6;210;0
WireConnection;2276;10;638;0
WireConnection;2277;21;772;0
WireConnection;2277;6;211;0
WireConnection;2277;10;639;0
WireConnection;2278;21;773;0
WireConnection;2278;6;212;0
WireConnection;2278;10;640;0
WireConnection;2279;21;767;0
WireConnection;2279;6;207;0
WireConnection;2279;10;635;0
WireConnection;2280;21;768;0
WireConnection;2280;6;208;0
WireConnection;2280;10;636;0
WireConnection;2281;21;774;0
WireConnection;2281;6;213;0
WireConnection;2281;10;641;0
WireConnection;2282;21;270;0
WireConnection;2282;6;198;0
WireConnection;2282;10;629;0
WireConnection;1118;0;1121;0
WireConnection;1348;0;1347;0
WireConnection;2283;0;1348;0
WireConnection;1390;0;2255;0
WireConnection;2255;0;1273;0
WireConnection;2285;0;1390;0
WireConnection;2289;0;2283;0
WireConnection;1389;0;1388;0
WireConnection;1389;1;2285;0
WireConnection;2286;0;1389;0
WireConnection;2288;0;2289;0
WireConnection;2259;0;1355;0
WireConnection;1326;0;2286;0
WireConnection;1326;1;2259;0
WireConnection;2260;0;1326;0
WireConnection;2290;0;2288;0
WireConnection;2290;1;2291;0
WireConnection;2257;0;2290;0
WireConnection;1355;0;2258;0
WireConnection;1355;1;2257;0
WireConnection;2302;0;2260;0
WireConnection;2305;0;2302;0
WireConnection;1363;0;2306;0
WireConnection;2306;0;2305;0
WireConnection;2213;7;1012;0
WireConnection;2213;8;2292;0
WireConnection;2213;9;58;0
WireConnection;2213;10;194;0
ASEEND*/
//CHKSM=49A846B0CE8BC20E400A919235A3E3D14BD98020