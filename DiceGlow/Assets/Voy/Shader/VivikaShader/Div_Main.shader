// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VoyVivika/VivikaShader"
{
	Properties
	{
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[Enum(Standard,0,Toon,1,Wrapped,2)]_LightingType("Lighting Type", Float) = 0
		_WrappedShadingValue("Wrapped Shading Value", Float) = 1
		_Albedo("Albedo", 2D) = "black" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_FlatTextureRamp("Flat Texture Ramp", 2D) = "black" {}
		_ScaleOffset("Scale & Offset", Float) = 0.5
		_MultiMap("MultiMap", 2D) = "black" {}
		[SingleLineTexture]_MetallicGlossMap("Unity Metallic", 2D) = "white" {}
		[ToggleUI]_UseUnityMetalicMap("Use Unity Metalic Map instead of MultiMap", Float) = 0
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
		_RimNormalMap("Rim Normal Map", 2D) = "bump" {}
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
		[Header(UV Range Discard)][Header(X and Y are Start UVs)][Header(Z and W are End UVs)][ToggleUI]_UVRangeDiscard1("UV Range Discard 1", Range( 0 , 1)) = 0
		[ToggleUI]_UVRangeDiscard3("UV Range Discard 3", Range( 0 , 1)) = 0
		[ToggleUI]_UVRangeDiscard2("UV Range Discard 2", Range( 0 , 1)) = 0
		_UVRangeDiscard1Range("UV Range Discard 1 Range", Vector) = (0,0,1,1)
		_UVRangeDiscard2Range("UV Range Discard 2 Range", Vector) = (0,0,1,1)
		_UVRangeDiscard3Range("UV Range Discard 3 Range", Vector) = (0,0,1,1)
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Blend One OneMinusSrcAlpha
		
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
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float3 worldNormal;
			float3 worldRefl;
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
		uniform float4 _EmissionColor;
		uniform sampler2D _BumpMap;
		uniform float _CullMode;
		uniform float _UVRangeDiscard1;
		uniform float4 _UVRangeDiscard1Range;
		uniform float _UVRangeDiscard2;
		uniform float4 _UVRangeDiscard2Range;
		uniform float _UVRangeDiscard3;
		uniform float4 _UVRangeDiscard3Range;
		uniform float _DiscardUVTile00;
		uniform float _DiscardUVTile01;
		uniform float _DiscardUVTile02;
		uniform float _DiscardUVTile03;
		uniform float _DiscardUVTile10;
		uniform float _DiscardUVTile11;
		uniform float _DiscardUVTile12;
		uniform float _DiscardUVTile13;
		uniform float _DiscardUVTile20;
		uniform float _DiscardUVTile21;
		uniform float _DiscardUVTile22;
		uniform float _DiscardUVTile23;
		uniform float _DiscardUVTile30;
		uniform float _DiscardUVTile31;
		uniform float _DiscardUVTile32;
		uniform float _DiscardUVTile33;
		uniform float4 _VideoDecalUVs;
		uniform float _VideoDecalRotation;
		uniform float _EnableVideoPlayerDecal;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Udon_VideoTex;
		uniform sampler2D _VideoDecalPreview;
		uniform float _ShowVideoPreview;
		uniform half _EnableAudioLink;
		uniform sampler2D _AL_Mask;
		uniform float4 _AL_Mask_ST;
		uniform float _ALTimeScale;
		uniform float _ALUVToggle;
		uniform float _ALDelayVPosition;
		uniform float _ALUVDelayMaxDelay;
		uniform float _ALDelayUPosition;
		uniform float _ALEmitifInactive;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _EmissionStrength;
		uniform half _EnableRimLighting;
		uniform sampler2D _RimNormalMap;
		uniform float _RimPower;
		uniform float _RimEnergy;
		uniform float _RimBaseColorStrength;
		uniform float _LightingType;
		uniform sampler2D _FlatTextureRamp;
		uniform float _ScaleOffset;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform float _UseUnityMetalicMap;
		uniform sampler2D _MultiMap;
		uniform float4 _MultiMap_ST;
		uniform float _WrappedShadingValue;


		float IfAudioLinkv2Exists1_g317(  )
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

		inline float AudioLinkData3_g316( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float AudioLinkData3_g313( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float AudioLinkData3_g311( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float AudioLinkData3_g314( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		float IfAudioLinkv2Exists1_g322(  )
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


		float3 MyCustomExpression( float3 worldReflection )
		{
			float4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldReflection);
			float3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			return skyColor;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 DiscardUV200 = v.texcoord1.xy;
			float2 break9_g250 = DiscardUV200;
			float4 break245 = _UVRangeDiscard1Range;
			float2 appendResult247 = (float2(break245.x , break245.y));
			float2 break11_g250 = appendResult247;
			float2 appendResult248 = (float2(break245.z , break245.w));
			float2 break13_g250 = appendResult248;
			float2 break9_g251 = DiscardUV200;
			float4 break252 = _UVRangeDiscard2Range;
			float2 appendResult253 = (float2(break252.x , break252.y));
			float2 break11_g251 = appendResult253;
			float2 appendResult254 = (float2(break252.z , break252.w));
			float2 break13_g251 = appendResult254;
			float2 break9_g252 = DiscardUV200;
			float4 break259 = _UVRangeDiscard3Range;
			float2 appendResult260 = (float2(break259.x , break259.y));
			float2 break11_g252 = appendResult260;
			float2 appendResult261 = (float2(break259.z , break259.w));
			float2 break13_g252 = appendResult261;
			float VV_UVRangeDiscard267 = ( ( _UVRangeDiscard1 == 1.0 ? (( break9_g250.y >= break11_g250.y && break9_g250.y <= break13_g250.y ) ? (( break9_g250.x >= break11_g250.x && break9_g250.x <= break13_g250.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _UVRangeDiscard2 == 1.0 ? (( break9_g251.y >= break11_g251.y && break9_g251.y <= break13_g251.y ) ? (( break9_g251.x >= break11_g251.x && break9_g251.x <= break13_g251.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _UVRangeDiscard3 == 1.0 ? (( break9_g252.y >= break11_g252.y && break9_g252.y <= break13_g252.y ) ? (( break9_g252.x >= break11_g252.x && break9_g252.x <= break13_g252.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) );
			float2 break9_g305 = DiscardUV200;
			float2 temp_output_24_0_g305 = floor( float2( 0,0 ) );
			float2 break11_g305 = temp_output_24_0_g305;
			float2 break13_g305 = ( temp_output_24_0_g305 + float2( 1,1 ) );
			float2 break9_g292 = DiscardUV200;
			float2 temp_output_24_0_g292 = floor( float2( 0,1 ) );
			float2 break11_g292 = temp_output_24_0_g292;
			float2 break13_g292 = ( temp_output_24_0_g292 + float2( 1,1 ) );
			float2 break9_g293 = DiscardUV200;
			float2 temp_output_24_0_g293 = floor( float2( 0,2 ) );
			float2 break11_g293 = temp_output_24_0_g293;
			float2 break13_g293 = ( temp_output_24_0_g293 + float2( 1,1 ) );
			float2 break9_g294 = DiscardUV200;
			float2 temp_output_24_0_g294 = floor( float2( 0,3 ) );
			float2 break11_g294 = temp_output_24_0_g294;
			float2 break13_g294 = ( temp_output_24_0_g294 + float2( 1,1 ) );
			float2 break9_g290 = DiscardUV200;
			float2 temp_output_24_0_g290 = floor( float2( 1,0 ) );
			float2 break11_g290 = temp_output_24_0_g290;
			float2 break13_g290 = ( temp_output_24_0_g290 + float2( 1,1 ) );
			float2 break9_g295 = DiscardUV200;
			float2 temp_output_24_0_g295 = floor( float2( 1,1 ) );
			float2 break11_g295 = temp_output_24_0_g295;
			float2 break13_g295 = ( temp_output_24_0_g295 + float2( 1,1 ) );
			float2 break9_g302 = DiscardUV200;
			float2 temp_output_24_0_g302 = floor( float2( 1,2 ) );
			float2 break11_g302 = temp_output_24_0_g302;
			float2 break13_g302 = ( temp_output_24_0_g302 + float2( 1,1 ) );
			float2 break9_g303 = DiscardUV200;
			float2 temp_output_24_0_g303 = floor( float2( 1,3 ) );
			float2 break11_g303 = temp_output_24_0_g303;
			float2 break13_g303 = ( temp_output_24_0_g303 + float2( 1,1 ) );
			float2 break9_g291 = DiscardUV200;
			float2 temp_output_24_0_g291 = floor( float2( 2,0 ) );
			float2 break11_g291 = temp_output_24_0_g291;
			float2 break13_g291 = ( temp_output_24_0_g291 + float2( 1,1 ) );
			float2 break9_g299 = DiscardUV200;
			float2 temp_output_24_0_g299 = floor( float2( 2,1 ) );
			float2 break11_g299 = temp_output_24_0_g299;
			float2 break13_g299 = ( temp_output_24_0_g299 + float2( 1,1 ) );
			float2 break9_g300 = DiscardUV200;
			float2 temp_output_24_0_g300 = floor( float2( 2,2 ) );
			float2 break11_g300 = temp_output_24_0_g300;
			float2 break13_g300 = ( temp_output_24_0_g300 + float2( 1,1 ) );
			float2 break9_g301 = DiscardUV200;
			float2 temp_output_24_0_g301 = floor( float2( 2,3 ) );
			float2 break11_g301 = temp_output_24_0_g301;
			float2 break13_g301 = ( temp_output_24_0_g301 + float2( 1,1 ) );
			float2 break9_g304 = DiscardUV200;
			float2 temp_output_24_0_g304 = floor( float2( 3,0 ) );
			float2 break11_g304 = temp_output_24_0_g304;
			float2 break13_g304 = ( temp_output_24_0_g304 + float2( 1,1 ) );
			float2 break9_g296 = DiscardUV200;
			float2 temp_output_24_0_g296 = floor( float2( 3,1 ) );
			float2 break11_g296 = temp_output_24_0_g296;
			float2 break13_g296 = ( temp_output_24_0_g296 + float2( 1,1 ) );
			float2 break9_g297 = DiscardUV200;
			float2 temp_output_24_0_g297 = floor( float2( 3,2 ) );
			float2 break11_g297 = temp_output_24_0_g297;
			float2 break13_g297 = ( temp_output_24_0_g297 + float2( 1,1 ) );
			float2 break9_g298 = DiscardUV200;
			float2 temp_output_24_0_g298 = floor( float2( 3,3 ) );
			float2 break11_g298 = temp_output_24_0_g298;
			float2 break13_g298 = ( temp_output_24_0_g298 + float2( 1,1 ) );
			float UVTileDiscard192 = ( ( ( _DiscardUVTile00 == 1.0 ? (( break9_g305.y >= break11_g305.y && break9_g305.y <= break13_g305.y ) ? (( break9_g305.x >= break11_g305.x && break9_g305.x <= break13_g305.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile01 == 1.0 ? (( break9_g292.y >= break11_g292.y && break9_g292.y <= break13_g292.y ) ? (( break9_g292.x >= break11_g292.x && break9_g292.x <= break13_g292.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile02 == 1.0 ? (( break9_g293.y >= break11_g293.y && break9_g293.y <= break13_g293.y ) ? (( break9_g293.x >= break11_g293.x && break9_g293.x <= break13_g293.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile03 == 1.0 ? (( break9_g294.y >= break11_g294.y && break9_g294.y <= break13_g294.y ) ? (( break9_g294.x >= break11_g294.x && break9_g294.x <= break13_g294.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) ) + ( ( _DiscardUVTile10 == 1.0 ? (( break9_g290.y >= break11_g290.y && break9_g290.y <= break13_g290.y ) ? (( break9_g290.x >= break11_g290.x && break9_g290.x <= break13_g290.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile11 == 1.0 ? (( break9_g295.y >= break11_g295.y && break9_g295.y <= break13_g295.y ) ? (( break9_g295.x >= break11_g295.x && break9_g295.x <= break13_g295.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile12 == 1.0 ? (( break9_g302.y >= break11_g302.y && break9_g302.y <= break13_g302.y ) ? (( break9_g302.x >= break11_g302.x && break9_g302.x <= break13_g302.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile13 == 1.0 ? (( break9_g303.y >= break11_g303.y && break9_g303.y <= break13_g303.y ) ? (( break9_g303.x >= break11_g303.x && break9_g303.x <= break13_g303.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) ) + ( ( _DiscardUVTile20 == 1.0 ? (( break9_g291.y >= break11_g291.y && break9_g291.y <= break13_g291.y ) ? (( break9_g291.x >= break11_g291.x && break9_g291.x <= break13_g291.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile21 == 1.0 ? (( break9_g299.y >= break11_g299.y && break9_g299.y <= break13_g299.y ) ? (( break9_g299.x >= break11_g299.x && break9_g299.x <= break13_g299.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile22 == 1.0 ? (( break9_g300.y >= break11_g300.y && break9_g300.y <= break13_g300.y ) ? (( break9_g300.x >= break11_g300.x && break9_g300.x <= break13_g300.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile23 == 1.0 ? (( break9_g301.y >= break11_g301.y && break9_g301.y <= break13_g301.y ) ? (( break9_g301.x >= break11_g301.x && break9_g301.x <= break13_g301.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) ) + ( ( _DiscardUVTile30 == 1.0 ? (( break9_g304.y >= break11_g304.y && break9_g304.y <= break13_g304.y ) ? (( break9_g304.x >= break11_g304.x && break9_g304.x <= break13_g304.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile31 == 1.0 ? (( break9_g296.y >= break11_g296.y && break9_g296.y <= break13_g296.y ) ? (( break9_g296.x >= break11_g296.x && break9_g296.x <= break13_g296.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile32 == 1.0 ? (( break9_g297.y >= break11_g297.y && break9_g297.y <= break13_g297.y ) ? (( break9_g297.x >= break11_g297.x && break9_g297.x <= break13_g297.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) + ( _DiscardUVTile33 == 1.0 ? (( break9_g298.y >= break11_g298.y && break9_g298.y <= break13_g298.y ) ? (( break9_g298.x >= break11_g298.x && break9_g298.x <= break13_g298.x ) ? ( 0.0 / 0.0 ) :  0.0 ) :  0.0 ) : 0.0 ) ) );
			float UVDiscard730 = ( VV_UVRangeDiscard267 + UVTileDiscard192 );
			float3 temp_cast_0 = (UVDiscard730).xxx;
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
			float LightType793 = _LightingType;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 newWorldNormal835 = normalize( (WorldNormalVector( i , half3(0,0,0) )) );
			float dotResult840 = dot( ( ase_worldlightDir != float3( 0,0,0 ) ? ase_worldlightDir : float3(1,1,1) ) , newWorldNormal835 );
			float LightLightDir841 = dotResult840;
			float clampResult951 = clamp( (LightLightDir841*_ScaleOffset + _ScaleOffset) , 0.0 , 1.0 );
			float2 temp_cast_14 = (clampResult951).xx;
			float4 TexRamp849 = tex2D( _FlatTextureRamp, temp_cast_14 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 clampResult942 = clamp( ase_lightColor.rgb , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float3 FlatLightColor414 = clampResult942;
			float clampResult799 = clamp( ase_lightAtten , 0.0 , 1.0 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 normalMap1002 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			UnityGI gi400 = gi;
			float3 diffNorm400 = normalize( WorldNormalVector( i , normalMap1002 ) );
			gi400 = UnityGI_Base( data, 1, diffNorm400 );
			float3 indirectDiffuse400 = gi400.indirect.diffuse + diffNorm400 * 0.0001;
			float3 temp_output_918_0 = ( clampResult799 + indirectDiffuse400 );
			float3 clampResult932 = clamp( ( ( FlatLightColor414 * temp_output_918_0 ) + temp_output_918_0 ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float3 break921 = clampResult932;
			float4 appendResult922 = (float4(break921.x , break921.y , break921.z , 0.0));
			float4 _ToonShadeResult424 = appendResult922;
			float2 appendResult1066 = (float2(_VideoDecalUVs.x , _VideoDecalUVs.y));
			float2 appendResult1067 = (float2(_VideoDecalUVs.z , _VideoDecalUVs.w));
			float2 temp_output_1076_0 = ( ( i.uv_texcoord + ( appendResult1066 * 0.01 ) ) * appendResult1067 );
			float cos7_g323 = cos( _VideoDecalRotation );
			float sin7_g323 = sin( _VideoDecalRotation );
			float2 rotator7_g323 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g323 , -sin7_g323 , sin7_g323 , cos7_g323 )) + float2( 0.5,0.5 );
			float2 break6_g323 = rotator7_g323;
			float VideoDecalAlpha1118 = ( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? 1.0 :  0.0 ) :  0.0 ) * _EnableVideoPlayerDecal );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float cos7_g324 = cos( _VideoDecalRotation );
			float sin7_g324 = sin( _VideoDecalRotation );
			float2 rotator7_g324 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g324 , -sin7_g324 , sin7_g324 , cos7_g324 )) + float2( 0.5,0.5 );
			float2 break6_g324 = rotator7_g324;
			float4 lerpResult1129 = lerp( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? tex2D( _Udon_VideoTex, rotator7_g323 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , (( break6_g324.y >= 0.0 && break6_g324.y <= 1.0 ) ? (( break6_g324.x >= 0.0 && break6_g324.x <= 1.0 ) ? tex2D( _VideoDecalPreview, rotator7_g324 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , _ShowVideoPreview);
			float4 Video_Player_Decal1077 = ( lerpResult1129 * _EnableVideoPlayerDecal );
			float layeredBlendVar1101 = VideoDecalAlpha1118;
			float4 layeredBlend1101 = ( lerp( tex2D( _Albedo, uv_Albedo ),Video_Player_Decal1077 , layeredBlendVar1101 ) );
			float4 mainTex26 = layeredBlend1101;
			float4 mainTexClamped354 = (float4( 0.01,0.01,0.01,0 ) + (mainTex26 - float4( 0,0,0,0 )) * (float4( 1,1,1,1 ) - float4( 0.01,0.01,0.01,0 )) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 )));
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1017 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			float2 appendResult1019 = (float2(tex2DNode1017.r , tex2DNode1017.a));
			float2 uv_MultiMap = i.uv_texcoord * _MultiMap_ST.xy + _MultiMap_ST.zw;
			float4 multiMap90 = tex2D( _MultiMap, uv_MultiMap );
			float4 break307 = multiMap90;
			float2 appendResult1015 = (float2(break307.r , break307.g));
			float2 break1020 = ( ( appendResult1019 * _UseUnityMetalicMap ) + ( appendResult1015 * ( 1.0 - _UseUnityMetalicMap ) ) );
			float _Metalic753 = break1020.x;
			float3 indirectNormal405 = normalize( WorldNormalVector( i , normalMap1002 ) );
			float _Smoothness755 = break1020.y;
			Unity_GlossyEnvironmentData g405 = UnityGlossyEnvironmentSetup( _Smoothness755, data.worldViewDir, indirectNormal405, float3(0,0,0));
			float3 indirectSpecular405 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal405, g405 );
			float3 clampResult960 = clamp( indirectSpecular405 , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float4 clampResult945 = clamp( ( TexRamp849 * ( ( _ToonShadeResult424 * mainTexClamped354 ) + ( _Metalic753 * float4( clampResult960 , 0.0 ) * _ToonShadeResult424 ) ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 Lighting_Toon411 = clampResult945;
			float dotResult1206 = dot( ase_worldlightDir , (WorldNormalVector( i , normalMap1002 )) );
			float NdotL1254 = dotResult1206;
			float wrap1209 = _WrappedShadingValue;
			float clampResult1218 = clamp( ( ( NdotL1254 + wrap1209 ) / ( 1.0 + wrap1209 ) ) , 0.0 , 1.0 );
			float DiffWrapShading1229 = clampResult1218;
			float clampResult1338 = clamp( ase_lightAtten , 0.0 , 1.0 );
			float clampResult1339 = clamp( exp( clampResult1338 ) , 0.0 , 1.0 );
			float4 color1362 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 lerpResult1356 = lerp( color1362 , ase_lightColor , ase_lightAtten);
			float4 color1317 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 clampResult1340 = clamp( lerpResult1356 , float4( 0,0,0,0 ) , color1317 );
			UnityGI gi1348 = gi;
			float3 diffNorm1348 = normalize( WorldNormalVector( i , normalMap1002 ) );
			gi1348 = UnityGI_Base( data, 1, diffNorm1348 );
			float3 indirectDiffuse1348 = gi1348.indirect.diffuse + diffNorm1348 * 0.0001;
			float3 clampResult1351 = clamp( indirectDiffuse1348 , float3( 0,0,0 ) , float3(1,1,1) );
			float4 clampResult1353 = clamp( ( clampResult1340 + float4( clampResult1351 , 0.0 ) ) , float4( 0,0,0,0 ) , color1317 );
			float4 clampResult1315 = clamp( ( clampResult1339 * clampResult1353 ) , float4( 0,0,0,0 ) , color1317 );
			float4 DiffWrapLighting1363 = clampResult1315;
			float3 worldReflection1305 = normalize( WorldReflectionVector( i , normalMap1002 ) );
			float3 localMyCustomExpression1305 = MyCustomExpression( worldReflection1305 );
			float4 AvatarColor1289 = ( mainTex26 + float4( ( _Smoothness755 * _Metalic753 * localMyCustomExpression1305 ) , 0.0 ) );
			float4 Lighting_Wrapped1144 = ( DiffWrapShading1229 * DiffWrapLighting1363 * AvatarColor1289 );
			SurfaceOutputStandard s303 = (SurfaceOutputStandard ) 0;
			s303.Albedo = mainTex26.rgb;
			s303.Normal = normalize( WorldNormalVector( i , normalMap1002 ) );
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			float4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			float localIfAudioLinkv2Exists1_g317 = IfAudioLinkv2Exists1_g317();
			float4 color42 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float3 hsvTorgb4_g315 = RGBToHSV( color42.rgb );
			float mulTime48 = _Time.y * _ALTimeScale;
			float Time50 = frac( mulTime48 );
			float3 hsvTorgb8_g315 = HSVToRGB( float3(( hsvTorgb4_g315.x + Time50 ),( hsvTorgb4_g315.y + 0.0 ),( hsvTorgb4_g315.z + 0.0 )) );
			float3 temp_output_194_0 = saturate( hsvTorgb8_g315 );
			int Band3_g316 = 0;
			float clampResult982 = clamp( (0.0 + (i.uv3_texcoord3.y - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (_ALDelayVPosition - 0.0)) , 0.0 , 127.0 );
			float2 appendResult986 = (float2(_ALDelayUPosition , _ALDelayVPosition));
			float2 break18_g310 = appendResult986;
			float2 break20_g310 = i.uv3_texcoord3;
			float temp_output_10_0_g310 = ( break18_g310.x - break20_g310.x );
			float temp_output_11_0_g310 = ( break18_g310.y - break20_g310.y );
			float clampResult27_g310 = clamp( sqrt( ( ( temp_output_10_0_g310 * temp_output_10_0_g310 ) + ( temp_output_11_0_g310 * temp_output_11_0_g310 ) ) ) , 0.0 , 1.0 );
			float clampResult987 = clamp( (0.0 + (clampResult27_g310 - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			float in_ALDelay991 = round( ( _ALUVToggle == 1.0 ? (127.0 + (clampResult982 - 0.0) * (0.0 - 127.0) / (127.0 - 0.0)) : ( _ALUVToggle == 2.0 ? clampResult987 : 0.0 ) ) );
			int Delay3_g316 = (int)in_ALDelay991;
			float localAudioLinkData3_g316 = AudioLinkData3_g316( Band3_g316 , Delay3_g316 );
			float3 ALC_Bass61 = ( localIfAudioLinkv2Exists1_g317 == 1.0 ? ( temp_output_194_0 * localAudioLinkData3_g316 ) : temp_output_194_0 );
			float4 color44 = IsGammaSpace() ? float4(0,0.8196079,0,1) : float4(0,0.637597,0,1);
			float3 hsvTorgb4_g59 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g59 = HSVToRGB( float3(( hsvTorgb4_g59.x + Time50 ),( hsvTorgb4_g59.y + 0.0 ),( hsvTorgb4_g59.z + 0.0 )) );
			int Band3_g313 = 2;
			int Delay3_g313 = (int)in_ALDelay991;
			float localAudioLinkData3_g313 = AudioLinkData3_g313( Band3_g313 , Delay3_g313 );
			float3 ALC_HighMid67 = ( saturate( hsvTorgb8_g59 ) * localAudioLinkData3_g313 );
			float4 color43 = IsGammaSpace() ? float4(1,0.9294118,0,1) : float4(1,0.8468735,0,1);
			float3 hsvTorgb4_g38 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g38 = HSVToRGB( float3(( hsvTorgb4_g38.x + Time50 ),( hsvTorgb4_g38.y + 0.0 ),( hsvTorgb4_g38.z + 0.0 )) );
			int Band3_g311 = 1;
			int Delay3_g311 = (int)in_ALDelay991;
			float localAudioLinkData3_g311 = AudioLinkData3_g311( Band3_g311 , Delay3_g311 );
			float3 ALC_LowMid64 = ( saturate( hsvTorgb8_g38 ) * localAudioLinkData3_g311 );
			float4 color45 = IsGammaSpace() ? float4(0,0,1,1) : float4(0,0,1,1);
			float3 hsvTorgb4_g37 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g37 = HSVToRGB( float3(( hsvTorgb4_g37.x + Time50 ),( hsvTorgb4_g37.y + 0.0 ),( hsvTorgb4_g37.z + 0.0 )) );
			int Band3_g314 = 3;
			int Delay3_g314 = (int)in_ALDelay991;
			float localAudioLinkData3_g314 = AudioLinkData3_g314( Band3_g314 , Delay3_g314 );
			float3 ALC_Treble70 = ( saturate( hsvTorgb8_g37 ) * localAudioLinkData3_g314 );
			float localIfAudioLinkv2Exists1_g322 = IfAudioLinkv2Exists1_g322();
			float clampResult1045 = clamp( ( localIfAudioLinkv2Exists1_g322 + _ALEmitifInactive ) , 0.0 , 1.0 );
			float4 AL_Final85 = ( ( _EnableAudioLink * ( ( ALMask39 * float4( ALC_Bass61 , 0.0 ) ) + ( ALMask39 * float4( ALC_HighMid67 , 0.0 ) ) + ( ALMask39 * float4( ALC_LowMid64 , 0.0 ) ) + ( ALMask39 * float4( ALC_Treble70 , 0.0 ) ) ) ) * clampResult1045 );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionStrength );
			float3 normalizeResult9 = normalize( i.viewDir );
			float dotResult10 = dot( UnpackNormal( tex2D( _RimNormalMap, i.uv_texcoord ) ) , normalizeResult9 );
			float4 lerpResult114 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			float4 Rim116 = ( _EnableRimLighting * ( ( ( pow( ( 1.0 - saturate( dotResult10 ) ) , ( 10.0 - _RimPower ) ) * _RimEnergy ) * lerpResult114 ) * ase_lightAtten ) );
			float layeredBlendVar1098 = VideoDecalAlpha1118;
			float4 layeredBlend1098 = ( lerp( ( AL_Final85 + Emission119 + Rim116 ),Video_Player_Decal1077 , layeredBlendVar1098 ) );
			float4 EmissionFinal29 = layeredBlend1098;
			s303.Emission = EmissionFinal29.rgb;
			s303.Metallic = break1020.x;
			s303.Smoothness = break1020.y;
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
			float3 Lighting_Standard309 = surfResult303;
			float4 LightingFinal330 = ( LightType793 == 1.0 ? Lighting_Toon411 : ( LightType793 == 2.0 ? Lighting_Wrapped1144 : float4( Lighting_Standard309 , 0.0 ) ) );
			c.rgb = LightingFinal330.rgb;
			c.a = 1;
			c.rgb *= c.a;
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
			float2 appendResult1066 = (float2(_VideoDecalUVs.x , _VideoDecalUVs.y));
			float2 appendResult1067 = (float2(_VideoDecalUVs.z , _VideoDecalUVs.w));
			float2 temp_output_1076_0 = ( ( i.uv_texcoord + ( appendResult1066 * 0.01 ) ) * appendResult1067 );
			float cos7_g323 = cos( _VideoDecalRotation );
			float sin7_g323 = sin( _VideoDecalRotation );
			float2 rotator7_g323 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g323 , -sin7_g323 , sin7_g323 , cos7_g323 )) + float2( 0.5,0.5 );
			float2 break6_g323 = rotator7_g323;
			float VideoDecalAlpha1118 = ( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? 1.0 :  0.0 ) :  0.0 ) * _EnableVideoPlayerDecal );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float cos7_g324 = cos( _VideoDecalRotation );
			float sin7_g324 = sin( _VideoDecalRotation );
			float2 rotator7_g324 = mul( temp_output_1076_0 - float2( 0.5,0.5 ) , float2x2( cos7_g324 , -sin7_g324 , sin7_g324 , cos7_g324 )) + float2( 0.5,0.5 );
			float2 break6_g324 = rotator7_g324;
			float4 lerpResult1129 = lerp( (( break6_g323.y >= 0.0 && break6_g323.y <= 1.0 ) ? (( break6_g323.x >= 0.0 && break6_g323.x <= 1.0 ) ? tex2D( _Udon_VideoTex, rotator7_g323 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , (( break6_g324.y >= 0.0 && break6_g324.y <= 1.0 ) ? (( break6_g324.x >= 0.0 && break6_g324.x <= 1.0 ) ? tex2D( _VideoDecalPreview, rotator7_g324 ) :  float4( 0,0,0,0 ) ) :  float4( 0,0,0,0 ) ) , _ShowVideoPreview);
			float4 Video_Player_Decal1077 = ( lerpResult1129 * _EnableVideoPlayerDecal );
			float layeredBlendVar1101 = VideoDecalAlpha1118;
			float4 layeredBlend1101 = ( lerp( tex2D( _Albedo, uv_Albedo ),Video_Player_Decal1077 , layeredBlendVar1101 ) );
			float4 mainTex26 = layeredBlend1101;
			o.Albedo = mainTex26.rgb;
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			float4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			float localIfAudioLinkv2Exists1_g317 = IfAudioLinkv2Exists1_g317();
			float4 color42 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float3 hsvTorgb4_g315 = RGBToHSV( color42.rgb );
			float mulTime48 = _Time.y * _ALTimeScale;
			float Time50 = frac( mulTime48 );
			float3 hsvTorgb8_g315 = HSVToRGB( float3(( hsvTorgb4_g315.x + Time50 ),( hsvTorgb4_g315.y + 0.0 ),( hsvTorgb4_g315.z + 0.0 )) );
			float3 temp_output_194_0 = saturate( hsvTorgb8_g315 );
			int Band3_g316 = 0;
			float clampResult982 = clamp( (0.0 + (i.uv3_texcoord3.y - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (_ALDelayVPosition - 0.0)) , 0.0 , 127.0 );
			float2 appendResult986 = (float2(_ALDelayUPosition , _ALDelayVPosition));
			float2 break18_g310 = appendResult986;
			float2 break20_g310 = i.uv3_texcoord3;
			float temp_output_10_0_g310 = ( break18_g310.x - break20_g310.x );
			float temp_output_11_0_g310 = ( break18_g310.y - break20_g310.y );
			float clampResult27_g310 = clamp( sqrt( ( ( temp_output_10_0_g310 * temp_output_10_0_g310 ) + ( temp_output_11_0_g310 * temp_output_11_0_g310 ) ) ) , 0.0 , 1.0 );
			float clampResult987 = clamp( (0.0 + (clampResult27_g310 - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			float in_ALDelay991 = round( ( _ALUVToggle == 1.0 ? (127.0 + (clampResult982 - 0.0) * (0.0 - 127.0) / (127.0 - 0.0)) : ( _ALUVToggle == 2.0 ? clampResult987 : 0.0 ) ) );
			int Delay3_g316 = (int)in_ALDelay991;
			float localAudioLinkData3_g316 = AudioLinkData3_g316( Band3_g316 , Delay3_g316 );
			float3 ALC_Bass61 = ( localIfAudioLinkv2Exists1_g317 == 1.0 ? ( temp_output_194_0 * localAudioLinkData3_g316 ) : temp_output_194_0 );
			float4 color44 = IsGammaSpace() ? float4(0,0.8196079,0,1) : float4(0,0.637597,0,1);
			float3 hsvTorgb4_g59 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g59 = HSVToRGB( float3(( hsvTorgb4_g59.x + Time50 ),( hsvTorgb4_g59.y + 0.0 ),( hsvTorgb4_g59.z + 0.0 )) );
			int Band3_g313 = 2;
			int Delay3_g313 = (int)in_ALDelay991;
			float localAudioLinkData3_g313 = AudioLinkData3_g313( Band3_g313 , Delay3_g313 );
			float3 ALC_HighMid67 = ( saturate( hsvTorgb8_g59 ) * localAudioLinkData3_g313 );
			float4 color43 = IsGammaSpace() ? float4(1,0.9294118,0,1) : float4(1,0.8468735,0,1);
			float3 hsvTorgb4_g38 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g38 = HSVToRGB( float3(( hsvTorgb4_g38.x + Time50 ),( hsvTorgb4_g38.y + 0.0 ),( hsvTorgb4_g38.z + 0.0 )) );
			int Band3_g311 = 1;
			int Delay3_g311 = (int)in_ALDelay991;
			float localAudioLinkData3_g311 = AudioLinkData3_g311( Band3_g311 , Delay3_g311 );
			float3 ALC_LowMid64 = ( saturate( hsvTorgb8_g38 ) * localAudioLinkData3_g311 );
			float4 color45 = IsGammaSpace() ? float4(0,0,1,1) : float4(0,0,1,1);
			float3 hsvTorgb4_g37 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g37 = HSVToRGB( float3(( hsvTorgb4_g37.x + Time50 ),( hsvTorgb4_g37.y + 0.0 ),( hsvTorgb4_g37.z + 0.0 )) );
			int Band3_g314 = 3;
			int Delay3_g314 = (int)in_ALDelay991;
			float localAudioLinkData3_g314 = AudioLinkData3_g314( Band3_g314 , Delay3_g314 );
			float3 ALC_Treble70 = ( saturate( hsvTorgb8_g37 ) * localAudioLinkData3_g314 );
			float localIfAudioLinkv2Exists1_g322 = IfAudioLinkv2Exists1_g322();
			float clampResult1045 = clamp( ( localIfAudioLinkv2Exists1_g322 + _ALEmitifInactive ) , 0.0 , 1.0 );
			float4 AL_Final85 = ( ( _EnableAudioLink * ( ( ALMask39 * float4( ALC_Bass61 , 0.0 ) ) + ( ALMask39 * float4( ALC_HighMid67 , 0.0 ) ) + ( ALMask39 * float4( ALC_LowMid64 , 0.0 ) ) + ( ALMask39 * float4( ALC_Treble70 , 0.0 ) ) ) ) * clampResult1045 );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionStrength );
			float3 normalizeResult9 = normalize( i.viewDir );
			float dotResult10 = dot( UnpackNormal( tex2D( _RimNormalMap, i.uv_texcoord ) ) , normalizeResult9 );
			float4 lerpResult114 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			float4 Rim116 = ( _EnableRimLighting * ( ( ( pow( ( 1.0 - saturate( dotResult10 ) ) , ( 10.0 - _RimPower ) ) * _RimEnergy ) * lerpResult114 ) * 1 ) );
			float layeredBlendVar1098 = VideoDecalAlpha1118;
			float4 layeredBlend1098 = ( lerp( ( AL_Final85 + Emission119 + Rim116 ),Video_Player_Decal1077 , layeredBlendVar1098 ) );
			float4 EmissionFinal29 = layeredBlend1098;
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
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
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
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;1276;-697.7578,-8983.115;Inherit;False;2247.523;1971.821;Comment;5;1277;1278;1279;1313;1365;Diffuse Wrapped;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1365;298.9429,-8479.207;Inherit;False;768.9199;361.6494;Comment;5;1219;1230;1144;1364;1290;Final Assembly;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1313;287.6499,-8876.735;Inherit;False;1202.157;320.2813;Comment;9;1289;1312;1309;1307;1306;1305;1281;1310;1217;Reflections;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1279;-639.4751,-8057.1;Inherit;False;1600.625;1006.903;I really hated this bit;19;1363;1315;1326;1353;1355;1340;1351;1348;1356;1357;1317;1352;1274;1362;1338;1339;1330;1347;1273;Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1278;-661.1073,-8864.655;Inherit;False;880.3926;417.3516;Comment;9;1216;1229;1218;1211;1213;1214;1208;1210;1255;Wrapping;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1277;-614.3854,-8370.295;Inherit;False;532.9998;163;Comment;2;1207;1209;Wrap Value;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1275;-585.7518,-9738.513;Inherit;False;809.0941;395;Dot Product of Normal and Light Dir;5;1205;1206;1204;1254;1203;NdotL;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;326;1907.217,-5775.348;Inherit;False;1038.421;993.8057;Comment;11;1155;1148;330;1156;1146;329;1145;1149;328;1147;1157;Pick Lighting Type;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1157;1973.18,-5641.242;Inherit;False;467.9048;169.6509;Comment;2;331;793;Light Type Register;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1110;-4777.827,-3708.893;Inherit;False;2208.849;2268.729;Comment;19;1083;1053;1108;1074;1075;1112;1111;1076;1071;1064;1067;1066;1121;1118;1077;1081;1124;1129;1136;Video Player Decal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1007;-8252.399,-4786.937;Inherit;False;330;858.978;Comment;4;1005;1003;1006;1004;Fallback Textures;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;382;1724.075,-8904.816;Inherit;False;3304.669;1860.738;Comment;31;405;400;424;391;426;960;1286;409;1287;918;401;799;788;402;411;932;938;945;406;922;908;929;399;397;425;921;931;410;412;351;854;Toon Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;854;1799.251,-7740.116;Inherit;False;1271.393;642.0645;Comment;6;844;845;849;848;847;951;Light Ramp;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;843;485.3015,-9967.852;Inherit;False;931.1643;711.4839;Comment;10;954;952;839;836;840;835;841;842;838;837;Light/View Dir Dot Products;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;732;4078.449,-1883.351;Inherit;False;626.3779;265.5669;Comment;4;728;729;731;730;Combine UV Discards;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;220;2051.233,-3370.865;Inherit;False;962.8354;715.8684;Comment;7;0;33;32;95;92;193;332;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;201;202.1576,-813.593;Inherit;False;861.1718;446.9373;Comment;2;200;1027;Discard UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-23.66935,-4536.875;Inherit;False;1663.516;958.884;Comment;21;85;1043;1037;71;415;416;84;83;82;81;80;79;78;76;77;75;74;73;1044;1045;1046;AudioLink Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;106;-112.9787,-5381.73;Inherit;False;1183.572;355.2229;Comment;5;57;69;70;45;1011;AudioLink Treble;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;105;-86.35403,-5893.254;Inherit;False;1188.215;403.241;Comment;6;67;66;56;44;197;1010;AudioLink HighMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-1337.905,-5407.259;Inherit;False;1137.62;367.6456;Comment;7;64;63;55;43;1008;996;196;AudioLink LowMid;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-1450.344,-6273.886;Inherit;False;1247.135;723.0679;Comment;9;1012;417;42;51;995;1009;194;58;61;AudioLink Bass;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1818.04,-4819.045;Inherit;False;712.9634;194.3457;Comment;4;243;48;49;50;Time;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-7417.041,-1620.861;Inherit;False;859.9141;343.3768;Comment;3;737;34;1002;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;31;-278.7401,-2122.503;Inherit;False;1194.286;795.1765;Comment;8;1098;1079;30;28;122;86;29;1120;Emission Combination;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;27;-7513.137,-3602.244;Inherit;False;1683.726;597.8718;Comment;6;736;25;26;1090;1101;1119;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1;-3015.296,-577.5867;Inherit;False;2860.72;1234.63;Comment;21;917;88;333;334;116;114;4;113;112;115;87;8;9;10;12;7;15;14;13;11;947;Rim;1,1,1,1;0;0
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
Node;AmplifyShaderEditor.RangedFloatNode;120;-1771.553,-2723.966;Inherit;False;Property;_EmissionStrength;Emission Strength;19;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-1444.109,-2847.282;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;11;-2179.434,-304.2606;Inherit;False;1;0;FLOAT;1.23;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;-2010.431,-261.9613;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;-2234.424,-176.6531;Inherit;False;2;0;FLOAT;10;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-1817.633,-238.5608;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-2780.132,-251.9605;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;-2650.262,-92.36382;Float;False;Property;_RimPower;Rim Power;22;0;Create;True;0;0;0;False;0;False;2.07;3.39;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;10;-2398.068,-404.9769;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;9;-2568.881,-243.393;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-1893.711,-79.22301;Inherit;False;Property;_RimEnergy;Rim Energy;23;0;Create;True;0;0;0;False;0;False;0.345;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;-1294.715,-5338.324;Inherit;False;Constant;_AL_LowMid;AL_LowMid;6;0;Create;True;0;0;0;False;0;False;1,0.9294118,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-644.6395,-5299.407;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-415.1543,-5306.091;Inherit;False;ALC_LowMid;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;665.2375,-5831.361;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;138;1465.541,-1401.771;Inherit;False;3237.51;1806.072;Comment;60;191;192;222;802;801;768;208;636;635;207;767;640;773;212;772;639;211;771;210;638;637;213;641;644;777;216;643;776;215;642;214;775;774;770;209;766;634;206;765;270;764;204;632;763;631;203;762;633;630;629;198;224;223;225;205;202;180;167;154;149;UV Tile Discard;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;195;343.6559,-5323.875;Inherit;False;HueShift;-1;;37;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;196;-907.4175,-5335.405;Inherit;False;HueShift;-1;;38;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;217;4137.307,-4147.085;Inherit;False;420.8079;185;Comment;2;219;218;Declare NaN;1,1,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2759.068,-3220.523;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;VoyVivika/VivikaShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;3;1;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;_CullMode;-1;0;False;;1;Include;Libs\AudioLink\AudioLink.cginc;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.BreakToComponentsNode;95;2282.518,-3022.374;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;92;2101.233,-3026.873;Inherit;False;90;multiMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;118;-1797.104,-2926.999;Inherit;True;Property;_Emission;Emission;18;0;Create;True;0;0;0;False;0;False;-1;83f90c05f51ea5c469ceb2c4218b09a7;83f90c05f51ea5c469ceb2c4218b09a7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;49;-1440.809,-4759.045;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;48;-1600.04,-4757.258;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-1786.835,-4764.416;Inherit;False;Property;_ALTimeScale;AL Time Scale;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;244;4931.741,-1214.173;Inherit;False;1373.246;1423.229;Comment;23;267;779;778;466;246;711;710;709;266;264;262;261;260;259;258;255;254;253;252;249;248;247;245;UV Range Discard;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;302;-2660.94,-8561.483;Inherit;False;1817.974;1019.399;Comment;18;1091;306;304;309;755;753;308;1019;1093;1092;1014;303;1094;1020;1017;1015;307;305;Standard Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;351;2481.085,-8393.098;Inherit;False;753.479;304;Comment;3;354;353;352;MainTexClamped;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;412;2696.326,-8799.865;Inherit;False;804.724;297.1823;Comment;3;414;942;413;Flat Light Color (Clamp Toggle);1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;416;787.8911,-4176.061;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;197;368.8238,-5818.455;Inherit;False;HueShift;-1;;59;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;415;478.4037,-4285.905;Half;False;Property;_EnableAudioLink;Enable AudioLink;10;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;-795.4411,-2748.33;Inherit;True;Property;_MultiMap;MultiMap;7;0;Create;True;0;0;0;False;0;False;-1;01e8d4996fddd0a448744957657de587;01e8d4996fddd0a448744957657de587;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-7141.458,-3513.226;Inherit;True;Property;_AlbedoSample;Albedo Sample;3;0;Create;True;0;0;0;False;0;False;-1;0db631ddb1a2c1443b81c6ac5ce43d11;0db631ddb1a2c1443b81c6ac5ce43d11;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;4334.115,-4095.47;Inherit;False;NaN;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
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
Node;AmplifyShaderEditor.RangedFloatNode;762;1499.583,-759.6893;Inherit;False;Property;_DiscardUVTile01;Discard UV Tile 0,1;26;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;203;1536.018,-316.3951;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;631;1566.422,-217.064;Inherit;False;Constant;_Vector2;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;763;1496.973,-427.7367;Inherit;False;Property;_DiscardUVTile02;Discard UV Tile 0,2;27;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;632;1594.787,113.182;Inherit;False;Constant;_Vector3;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;204;1570.418,24.20495;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;764;1518.973,-60.73669;Inherit;False;Property;_DiscardUVTile03;Discard UV Tile 0,3;28;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;765;2249.126,-963.5736;Inherit;False;Property;_DiscardUVTile10;Discard UV Tile 1,0;29;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;2357.974,-536.9484;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;634;2385.538,-462.1622;Inherit;False;Constant;_Vector5;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;766;2259.126,-613.5735;Inherit;False;Property;_DiscardUVTile11;Discard UV Tile 1,1;30;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;3140.744,-871.4884;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;770;3041.102,-947.6624;Inherit;False;Property;_DiscardUVTile20;Discard UV Tile 2,0;33;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;774;3842.005,-910.9678;Inherit;False;Property;_DiscardUVTile30;Discard UV Tile 3,0;38;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;775;3839.91,-560.7627;Inherit;False;Property;_DiscardUVTile31;Discard UV Tile 3,1;37;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;214;3904.62,-483.9957;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;642;3933.447,-413.097;Inherit;False;Constant;_Vector13;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;215;3912.915,-182.604;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;776;3813.138,-254.3136;Inherit;False;Property;_DiscardUVTile32;Discard UV Tile 3,2;39;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;643;3940.676,-112.648;Inherit;False;Constant;_Vector14;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;216;3914.689,128.2034;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;777;3814.721,53.09606;Inherit;False;Property;_DiscardUVTile33;Discard UV Tile 3,3;40;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;644;3945.259,200.7619;Inherit;False;Constant;_Vector15;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;641;3964.222,-753.2794;Inherit;False;Constant;_Vector12;Vector 0;38;0;Create;True;0;0;0;False;0;False;3,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;213;3933.363,-828.7961;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;637;3166.819,-795.8944;Inherit;False;Constant;_Vector8;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;638;3179.013,-479.2932;Inherit;False;Constant;_Vector9;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;210;3150.812,-564.5684;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;771;3055.927,-642.5212;Inherit;False;Property;_DiscardUVTile21;Discard UV Tile 2,1;34;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;3164.474,-249.9562;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;639;3189.3,-170.453;Inherit;False;Constant;_Vector10;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;772;3061.227,-323.6906;Inherit;False;Property;_DiscardUVTile22;Discard UV Tile 2,2;35;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;3166.697,60.64629;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;773;3067.304,-14.54724;Inherit;False;Property;_DiscardUVTile23;Discard UV Tile 2,3;36;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;640;3192.601,137.0375;Inherit;False;Constant;_Vector11;Vector 0;38;0;Create;True;0;0;0;False;0;False;2,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;767;2251.573,-307.925;Inherit;False;Property;_DiscardUVTile12;Discard UV Tile 1,2;31;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;2353.001,-233.3764;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;635;2382.081,-156.652;Inherit;False;Constant;_Vector6;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;636;2388.87,155.4928;Inherit;False;Constant;_Vector7;Vector 0;38;0;Create;True;0;0;0;False;0;False;1,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;208;2361.729,79.19774;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;768;2260.751,5.167598;Inherit;False;Property;_DiscardUVTile13;Discard UV Tile 1,3;32;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;801;4579.42,-570.3809;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;802;4497.627,-688.764;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;222;4161.278,-1049.713;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;4249.063,-1173.994;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;245;5241.74,-922.281;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;247;5375.179,-946.2517;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;248;5375.179,-850.2518;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;249;5333.789,-1021.623;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;252;5271.327,-472.0491;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;253;5404.764,-496.0198;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;254;5404.764,-400.0198;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;5363.374,-571.3915;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;258;5011.327,-475.0491;Inherit;False;Property;_UVRangeDiscard2Range;UV Range Discard 2 Range;45;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;259;5334.241,14.65262;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;260;5467.679,-9.317484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;261;5467.679,86.68251;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;262;5426.288,-84.68938;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;264;5074.242,11.65262;Inherit;False;Property;_UVRangeDiscard3Range;UV Range Discard 3 Range;46;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;266;5958.68,-614.4764;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;709;5558.698,-1045.453;Inherit;False;UV Range Discard;-1;;250;59eaa82e4bf18fa44b47aa07cd25b8a2;0;4;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;12;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;710;5588.283,-595.2204;Inherit;False;UV Range Discard;-1;;251;59eaa82e4bf18fa44b47aa07cd25b8a2;0;4;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;12;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;711;5651.197,-108.5184;Inherit;False;UV Range Discard;-1;;252;59eaa82e4bf18fa44b47aa07cd25b8a2;0;4;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;12;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;246;4981.741,-925.281;Inherit;False;Property;_UVRangeDiscard1Range;UV Range Discard 1 Range;44;0;Create;True;3;UV Range Discard;X and Y are Start UVs;Z and W are End UVs;0;0;False;0;False;0,0,1,1;0,0,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;466;5261.058,-1129.487;Inherit;False;Property;_UVRangeDiscard1;UV Range Discard 1;41;2;[Header];[ToggleUI];Create;True;3;UV Range Discard;X and Y are Start UVs;Z and W are End UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;778;5250.409,-696.8858;Inherit;False;Property;_UVRangeDiscard2;UV Range Discard 2;43;1;[ToggleUI];Create;True;3;UV Range Discard;X and Y are Start UVs;Z and W are End UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;779;5313.231,-188.0279;Inherit;False;Property;_UVRangeDiscard3;UV Range Discard 3;42;1;[ToggleUI];Create;True;3;UV Range Discard;X and Y are Start UVs;Z and W are End UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;-881,-277;Half;False;Property;_EnableRimLighting;Enable Rim Lighting;20;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-561,-133;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-368.0269,-114.8811;Float;True;Rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1666.907,-210.9594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-1285,23;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;114;-1541,87;Inherit;True;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-1749,199;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-1829,279;Inherit;False;Property;_RimBaseColorStrength;Rim Base Color Strength;24;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;947;-858.6481,14.32739;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;917;-1079.548,107.3725;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;218;4187.307,-4097.085;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;4390.601,-1188.976;Inherit;False;UVTileDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;267;6089.752,-618.9073;Inherit;False;VV_UVRangeDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;1497.07,-1070.585;Inherit;False;Property;_DiscardUVTile00;Discard UV Tile 0,0;25;2;[Header];[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;629;1539.432,-900.3254;Inherit;False;Constant;_Vector0;Vector 0;38;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;728;4128.448,-1832.351;Inherit;False;267;VV_UVRangeDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;729;4130.826,-1733.785;Inherit;False;192;UVTileDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;731;4354.827,-1783.785;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;730;4480.827,-1793.785;Inherit;False;UVDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;193;2351.81,-2859.997;Inherit;False;730;UVDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;961;2566.127,-818.3905;Inherit;False;UV Tile Discard;-1;;290;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;962;3347.481,-781.8707;Inherit;False;UV Tile Discard;-1;;291;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;963;1803.251,-596.9982;Inherit;False;UV Tile Discard;-1;;292;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;964;1785.751,-378.5684;Inherit;False;UV Tile Discard;-1;;293;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;965;1793.151,-18.96954;Inherit;False;UV Tile Discard;-1;;294;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;966;2535.103,-558.2587;Inherit;False;UV Tile Discard;-1;;295;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;967;4111.194,-549.4994;Inherit;False;UV Tile Discard;-1;;296;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;968;4146.207,-244.9378;Inherit;False;UV Tile Discard;-1;;297;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;969;4104.421,78.95988;Inherit;False;UV Tile Discard;-1;;298;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;970;3330.537,-609.8447;Inherit;False;UV Tile Discard;-1;;299;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;971;3352.062,-280.4475;Inherit;False;UV Tile Discard;-1;;300;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;972;3339.263,55.05388;Inherit;False;UV Tile Discard;-1;;301;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;973;2536.623,-252.0813;Inherit;False;UV Tile Discard;-1;;302;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;974;2532.193,51.46117;Inherit;False;UV Tile Discard;-1;;303;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;975;4142.573,-783.9061;Inherit;False;UV Tile Discard;-1;;304;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;976;1813.015,-855.9457;Inherit;False;UV Tile Discard;-1;;305;f1bd11510c44bc348aeb983c4528c9d5;0;3;21;FLOAT;0;False;6;FLOAT2;0,0;False;10;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-1793.337,-3445.624;Inherit;True;Property;_AL_Mask;AudioLink Mask;12;0;Create;False;0;0;0;False;0;False;-1;83f90c05f51ea5c469ceb2c4218b09a7;4458fd93822db704f8668dece1eda249;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
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
Node;AmplifyShaderEditor.RangedFloatNode;978;-3524.537,-5819.039;Inherit;False;Property;_ALDelayVPosition;AL Delay V Position;15;0;Create;True;0;0;0;False;0;False;0.83;0.722;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;983;-2522.057,-5938.445;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;3;FLOAT;127;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;982;-2691.424,-5940.795;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;985;-2014.866,-5847.629;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;989;-2174.397,-5826.617;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;988;-2330.397,-5697.618;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;987;-2499.557,-5635.75;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;993;-2685.484,-5629.869;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;992;-2939.719,-5661.353;Inherit;False;Distance;-1;;310;5a463ec6a2137ce40abfe8c530112fe4;0;2;17;FLOAT2;0,0;False;19;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;984;-2526.103,-5758.253;Inherit;False;Property;_ALUVToggle;Delay for AL;13;1;[Enum];Create;False;0;3;None;0;UV Vertical;1;Distance;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;986;-3145.573,-5659.957;Inherit;False;FLOAT2;4;0;FLOAT;0.5;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;981;-2908.014,-6001.174;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;979;-3552.83,-5722.939;Inherit;False;Property;_ALUVDelayMaxDelay;AL UV Delay Max Delay;16;0;Create;True;0;0;0;False;0;False;0;110;0;127;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;999;-3524.789,-5897.548;Inherit;False;Property;_ALDelayUPosition;AL Delay U Position;14;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2990.279,-371.7114;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1002;-6766.544,-1491.989;Inherit;False;normalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;34;-7090.542,-1509.947;Inherit;True;Property;_NMSample;NM Sample;4;0;Create;True;0;0;0;False;0;False;-1;13ce54de7ec2bdd45a3ceb8a5e5e4cad;1f3982b36e89bca46b80f47660759b39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;737;-7386.651,-1509.456;Inherit;True;Property;_NormalMap;Normal Map;4;0;Create;True;0;0;0;False;0;False;0f9978e19d98bb04b8f2ce5197640506;de6df218bb431e5478b40918ba89ef81;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;1008;-913.0733,-5171.95;Inherit;False;4BandAmplitude;-1;;311;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;1;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1010;368.6584,-5617.326;Inherit;False;4BandAmplitude;-1;;313;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;2;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1011;331.6262,-5142.257;Inherit;False;4BandAmplitude;-1;;314;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;3;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;1543.344,-979.7899;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;799.3069,-665.868;Inherit;False;DiscardUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1028;-3505.115,-6027.419;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1470.095,-3451.473;Inherit;False;ALMask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-752.1933,-6042.505;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;194;-1009.82,-6118.039;Inherit;False;HueShift;-1;;315;09c7357f8ce789c46a405a6704ca8341;0;4;14;COLOR;0,0,0,0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1009;-1022.524,-5965.17;Inherit;False;4BandAmplitude;-1;;316;54e9597243c613f4e9d8abb2df35c1e0;0;2;2;INT;0;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;995;-1300.723,-5960.167;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1202.61,-6040.862;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;-1412.129,-6138.375;Inherit;False;Constant;_AL_Bass;AL_Bass;6;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;417;-590.3177,-6164.811;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-439.0311,-6159.326;Inherit;False;ALC_Bass;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;20.79314,-4476.875;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1012;-801,-6234;Inherit;False;IsAudioLink;-1;;317;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;1389.661,-4179.093;Inherit;False;AL_Final;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1037;743,-4376;Inherit;False;Property;_ALEmitifInactive;AL Emit if Inactive;11;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1043;743,-4456;Inherit;False;IsAudioLink;-1;;322;ff5333ab7aa196b46b61532e86c1a947;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1044;977.5732,-4431.625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1045;1099.52,-4430.474;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1046;1214.24,-4177.113;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;736;-7467.361,-3512.755;Inherit;True;Property;_Albedo;Albedo;3;0;Create;True;0;0;0;False;0;False;0db631ddb1a2c1443b81c6ac5ce43d11;2929c791376549d48b5f9ba904093d71;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;1003;-8229.402,-4736.937;Inherit;True;Property;_MainTex;Fallback Albedo;52;2;[Header];[SingleLineTexture];Create;False;1;Standard Fallbacks;0;0;True;0;False;None;2929c791376549d48b5f9ba904093d71;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;1004;-8234.402,-4540.937;Inherit;True;Property;_EmissionMap;Fallback Emission Map;54;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;1005;-8203.402,-4345.939;Inherit;False;Property;_EmissionColor;Fallback Emission Color;55;0;Create;False;0;0;0;True;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1006;-8231.174,-4149.961;Inherit;True;Property;_BumpMap;Fallback Normal Map;56;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;de6df218bb431e5478b40918ba89ef81;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;1047;-7527.922,-4553.556;Inherit;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
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
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1027;471.0703,-684.8264;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1119;-6822.949,-3227.708;Inherit;False;1118;VideoDecalAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1120;-31.28754,-1624.004;Inherit;False;1118;VideoDecalAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1083;-3667.103,-3648.907;Inherit;False;Property;_EnableVideoPlayerDecal;Enable Video Player Decal;47;2;[Header];[ToggleUI];Create;True;1;Video Player Decal;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1066;-4445.004,-3141;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1067;-4439.004,-3027;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;1064;-4696.004,-3121;Inherit;False;Property;_VideoDecalUVs;Video Decal Coordinates;50;1;[Header];Create;False;2;X and Y are Position;Z and W are Tiling (Size);0;0;False;0;False;0.01,-0.29,1.29,1.4;-52.3,-55.9,20.3,22.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1071;-4117.007,-2984.2;Inherit;False;Property;_VideoDecalRotation;Video Decal Rotation;51;0;Create;True;0;0;0;False;0;False;-0.15;-0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1076;-3967.025,-3143.215;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1111;-4280.878,-3263.277;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1112;-4469.494,-3288.354;Inherit;False;Constant;_Float1;Float 1;56;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1075;-4081.008,-3341;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;1053;-4046.878,-3543.225;Inherit;True;Global;_Udon_VideoTex;_Udon_VideoTex;53;0;Create;True;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;1118;-2900.04,-3521.027;Inherit;False;VideoDecalAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1121;-3119.618,-3508.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1077;-2825.569,-3288.123;Inherit;True;Video Player Decal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1081;-3019.766,-3288.592;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1108;-3615.98,-2997.36;Inherit;False;Property;_ShowVideoPreview;Show Preview;48;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1129;-3335.079,-3162.252;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-2720.214,-488.9528;Inherit;True;Property;_RimNormalMap;Rim Normal Map;21;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1135;-3750.112,-3263.333;Inherit;True;Decal;-1;;323;c7a5994071b70f8448ea324b9d90affe;0;4;9;SAMPLER2D;;False;15;FLOAT2;0,0;False;12;FLOAT2;0.5,0.5;False;14;FLOAT;0;False;2;COLOR;0;FLOAT;19
Node;AmplifyShaderEditor.TexturePropertyNode;1124;-4076.226,-2837.161;Inherit;True;Property;_VideoDecalPreview;Video Decal Preview;49;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;80ab37a9e4f49c842903bb43bdd7bcd2;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;1074;-4417.019,-3434.575;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1136;-3737.754,-2892.921;Inherit;True;Decal;-1;;324;c7a5994071b70f8448ea324b9d90affe;0;4;9;SAMPLER2D;;False;15;FLOAT2;0,0;False;12;FLOAT2;0.5,0.5;False;14;FLOAT;0;False;2;COLOR;0;FLOAT;19
Node;AmplifyShaderEditor.RegisterLocalVarNode;793;2199.086,-5591.242;Inherit;False;LightType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1147;2312.234,-5085.455;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;328;2047.839,-4902.87;Inherit;False;309;Lighting_Standard;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1149;2063.787,-5036.328;Inherit;False;1144;Lighting Wrapped;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare;1145;2481.447,-5316.179;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;329;2235.849,-5268.512;Inherit;False;411;Lighting_Toon;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1146;2296.102,-5339.675;Inherit;False;Constant;_Toon;Toon;57;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1156;2264.553,-5411.804;Inherit;False;793;LightType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;330;2653.833,-5424.345;Inherit;False;LightingFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1148;2126.788,-5110.328;Inherit;False;Constant;_Wrap;Wrap;57;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1155;2095.441,-5183.049;Inherit;False;793;LightType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;2023.18,-5584.591;Inherit;False;Property;_LightingType;Lighting Type;1;1;[Enum];Create;True;0;3;Standard;0;Toon;1;Wrapped;2;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;354;2996.564,-8326.079;Inherit;False;mainTexClamped;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;848;1886.292,-7438.65;Inherit;False;Property;_ScaleOffset;Scale & Offset;6;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;413;2780.64,-8707.7;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;847;2090.291,-7501.652;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;844;2567.739,-7535.479;Inherit;True;Property;_FlatTextureRamp;Flat Texture Ramp;5;0;Create;True;0;0;0;False;0;False;-1;None;c0652d14b9128794da6aee5610de4458;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;837;1026.471,-9526.638;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;838;1200.473,-9521.638;Inherit;False;LightViewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;841;1194.473,-9743.162;Inherit;False;LightLightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;835;809.627,-9633.095;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;840;1034.907,-9693.645;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;836;836.3906,-9455.15;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;842;604.5024,-9464.823;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;849;2816.625,-7665.191;Inherit;False;TexRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;352;2704.496,-8343.098;Inherit;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;3;COLOR;0.01,0.01,0.01,0;False;4;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-2039.203,-8355.536;Inherit;False;29;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;307;-2391.093,-8080.505;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1015;-2263.094,-8080.907;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1017;-2561.949,-8282.445;Inherit;True;Property;_MetallicGlossMap;Unity Metallic;8;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;10bb579d32ef46948b34951dab6381cd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;1020;-1797.679,-8182.044;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1094;-1902.245,-8172.554;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1014;-2543.413,-8415.805;Inherit;False;Property;_UseUnityMetalicMap;Use Unity Metalic Map instead of MultiMap;9;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1092;-2070.246,-8052.554;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;1093;-2225.245,-8159.554;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1019;-2226.599,-8272.81;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;308;-2583.092,-8080.505;Inherit;False;90;multiMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;753;-1581.477,-8153.016;Inherit;False;_Metalic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;755;-1577.997,-8054.675;Inherit;False;_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;353;2531.085,-8300.216;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-2036.903,-8516.836;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-2024.203,-8436.536;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1091;-2051.446,-8228.147;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;309;-1076.321,-8462.62;Inherit;False;Lighting_Standard;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomStandardSurface;303;-1628.222,-8459.056;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;1206;-140.7514,-9605.513;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1204;-535.7516,-9523.513;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1254;-18.65635,-9608.522;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1203;-352.7516,-9528.513;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;1209;-332.735,-8304.575;Inherit;False;wrap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;954;511.8394,-9680.53;Inherit;False;Constant;_ToonEmptyLightStrength;Toon Empty Light Strength;39;0;Create;True;0;0;0;False;0;False;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1207;-583.9454,-8304.575;Inherit;False;Property;_WrappedShadingValue;Wrapped Shading Value;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;845;1911.92,-7521.969;Inherit;False;841;LightLightDir;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1255;-638.3264,-8822.655;Inherit;False;1254;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1210;-630.3493,-8728.625;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1208;-442.1794,-8782.745;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1214;-628.1074,-8547.825;Inherit;False;1209;wrap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1213;-589.7074,-8637.435;Inherit;False;Constant;_Float5;Float 5;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1211;-429.9074,-8608.425;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1218;-187.0108,-8698.595;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1216;-298.8944,-8699.615;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;839;566.467,-9845.46;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Compare;952;841.5908,-9811.007;Inherit;False;1;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.5,0.5,0.5;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1205;-382.7515,-9688.513;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;942;3032.019,-8688.161;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;414;3254.38,-8699.79;Inherit;False;FlatLightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1217;953.2814,-8825.465;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1310;736.1473,-8736.795;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1281;711.6492,-8813.705;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1305;716.6292,-8662.905;Inherit;False;float4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldReflection)@$float3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR)@$return skyColor@$;3;Create;1;True;worldReflection;FLOAT3;0,0,0;In;;Inherit;False;My Custom Expression;False;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldReflectionVector;1306;495.2336,-8752.915;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1307;309.1938,-8780.025;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1309;964.5054,-8741.945;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1312;1140.467,-8766.125;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1289;1264.55,-8759.455;Inherit;False;AvatarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1229;-40.43162,-8697.345;Inherit;False;DiffWrapShading;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1273;-598.517,-7865.479;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1347;-527.676,-7548.161;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ExpOpNode;1330;-164.6683,-7936.819;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1339;14.33272,-7935.18;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1338;-340.9915,-7933.33;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1362;-584.1781,-7775.47;Inherit;False;Constant;_Color1;Color 1;57;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;1274;-364.2808,-7699.25;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;1352;-460.481,-7457.934;Inherit;False;Constant;_Vector16;Vector 16;57;0;Create;True;0;0;0;False;0;False;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;1317;-265.46,-7355.147;Inherit;False;Constant;_Color0;Color 0;57;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1357;226.9836,-7357.38;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1356;-196.0374,-7786.93;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;1348;-334.8964,-7554.864;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1351;-100.183,-7535.97;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1340;-28.0134,-7744.6;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1355;127.3366,-7668.897;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1353;248.383,-7620.387;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1326;399.2337,-7691.269;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1315;560.6395,-7648.032;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1363;715.0334,-7616.791;Inherit;False;DiffWrapLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1219;607.1013,-8380.904;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1230;371.9422,-8418.814;Inherit;False;1229;DiffWrapShading;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1144;829.7634,-8400.694;Inherit;False;Lighting Wrapped;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1364;352.8424,-8319.625;Inherit;False;1363;DiffWrapLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1290;385.1431,-8220.165;Inherit;False;1289;AvatarColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;410;4008.377,-7725.494;Inherit;False;2;2;0;COLOR;1,1,1,0;False;1;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;931;3883.216,-7913.282;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;921;4404.682,-8004.95;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;425;3787.999,-7761.424;Inherit;False;424;_ToonShadeResult;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;3776.251,-7679.321;Inherit;False;354;mainTexClamped;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;399;3978.08,-8034.278;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;929;3630.452,-8134.794;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;908;4168.421,-7781.607;Inherit;False;849;TexRamp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;922;4520.682,-8000.95;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;406;4073.131,-7570.138;Inherit;False;3;3;0;FLOAT;1;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;945;4554.071,-7625.279;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;938;4382.308,-7734.742;Inherit;False;2;2;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;932;4262.541,-7995.664;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;411;4719.614,-7628.313;Inherit;False;Lighting_Toon;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;402;4211.496,-7623.329;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;788;2706.381,-7971.226;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;799;2919.015,-7987.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;401;2719.67,-7856.779;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;918;3399.657,-7913.924;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1287;3793.253,-7606.311;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;409;3397.594,-7535.874;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1286;3363.252,-7457.311;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;960;3852.745,-7529.317;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;426;3714.855,-7368.05;Inherit;False;424;_ToonShadeResult;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;391;3338.486,-8213.613;Inherit;False;414;FlatLightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;424;4730.337,-7918.396;Inherit;False;_ToonShadeResult;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;400;2895.938,-7850.333;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectSpecularLight;405;3607.417,-7528.632;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;951;2342.828,-7501.996;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
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
WireConnection;11;0;10;0
WireConnection;13;0;11;0
WireConnection;14;1;12;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;9;0;7;0
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
WireConnection;95;0;92;0
WireConnection;49;0;48;0
WireConnection;48;0;243;0
WireConnection;416;0;415;0
WireConnection;416;1;84;0
WireConnection;197;14;44;0
WireConnection;197;15;56;0
WireConnection;25;0;736;0
WireConnection;219;0;218;0
WireConnection;149;0;976;0
WireConnection;149;1;963;0
WireConnection;149;2;964;0
WireConnection;149;3;965;0
WireConnection;154;0;961;0
WireConnection;154;1;966;0
WireConnection;154;2;973;0
WireConnection;154;3;974;0
WireConnection;167;0;962;0
WireConnection;167;1;970;0
WireConnection;167;2;971;0
WireConnection;167;3;972;0
WireConnection;180;0;975;0
WireConnection;180;1;967;0
WireConnection;180;2;968;0
WireConnection;180;3;969;0
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
WireConnection;245;0;246;0
WireConnection;247;0;245;0
WireConnection;247;1;245;1
WireConnection;248;0;245;2
WireConnection;248;1;245;3
WireConnection;252;0;258;0
WireConnection;253;0;252;0
WireConnection;253;1;252;1
WireConnection;254;0;252;2
WireConnection;254;1;252;3
WireConnection;259;0;264;0
WireConnection;260;0;259;0
WireConnection;260;1;259;1
WireConnection;261;0;259;2
WireConnection;261;1;259;3
WireConnection;266;0;709;0
WireConnection;266;1;710;0
WireConnection;266;2;711;0
WireConnection;709;21;466;0
WireConnection;709;6;249;0
WireConnection;709;10;247;0
WireConnection;709;12;248;0
WireConnection;710;21;778;0
WireConnection;710;6;255;0
WireConnection;710;10;253;0
WireConnection;710;12;254;0
WireConnection;711;21;779;0
WireConnection;711;6;262;0
WireConnection;711;10;260;0
WireConnection;711;12;261;0
WireConnection;334;0;333;0
WireConnection;334;1;947;0
WireConnection;116;0;334;0
WireConnection;88;0;15;0
WireConnection;88;1;87;0
WireConnection;115;0;88;0
WireConnection;115;1;114;0
WireConnection;114;1;112;0
WireConnection;114;2;113;0
WireConnection;947;0;115;0
WireConnection;947;1;917;0
WireConnection;192;0;191;0
WireConnection;267;0;266;0
WireConnection;731;0;728;0
WireConnection;731;1;729;0
WireConnection;730;0;731;0
WireConnection;961;21;765;0
WireConnection;961;6;205;0
WireConnection;961;10;633;0
WireConnection;962;21;770;0
WireConnection;962;6;209;0
WireConnection;962;10;637;0
WireConnection;963;21;762;0
WireConnection;963;6;202;0
WireConnection;963;10;630;0
WireConnection;964;21;763;0
WireConnection;964;6;203;0
WireConnection;964;10;631;0
WireConnection;965;21;764;0
WireConnection;965;6;204;0
WireConnection;965;10;632;0
WireConnection;966;21;766;0
WireConnection;966;6;206;0
WireConnection;966;10;634;0
WireConnection;967;21;775;0
WireConnection;967;6;214;0
WireConnection;967;10;642;0
WireConnection;968;21;776;0
WireConnection;968;6;215;0
WireConnection;968;10;643;0
WireConnection;969;21;777;0
WireConnection;969;6;216;0
WireConnection;969;10;644;0
WireConnection;970;21;771;0
WireConnection;970;6;210;0
WireConnection;970;10;638;0
WireConnection;971;21;772;0
WireConnection;971;6;211;0
WireConnection;971;10;639;0
WireConnection;972;21;773;0
WireConnection;972;6;212;0
WireConnection;972;10;640;0
WireConnection;973;21;767;0
WireConnection;973;6;207;0
WireConnection;973;10;635;0
WireConnection;974;21;768;0
WireConnection;974;6;208;0
WireConnection;974;10;636;0
WireConnection;975;21;774;0
WireConnection;975;6;213;0
WireConnection;975;10;641;0
WireConnection;976;21;270;0
WireConnection;976;6;198;0
WireConnection;976;10;629;0
WireConnection;991;0;985;0
WireConnection;67;0;66;0
WireConnection;983;0;982;0
WireConnection;982;0;981;0
WireConnection;985;0;989;0
WireConnection;989;0;984;0
WireConnection;989;2;983;0
WireConnection;989;3;988;0
WireConnection;988;0;984;0
WireConnection;988;2;987;0
WireConnection;987;0;993;0
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
WireConnection;200;0;1027;0
WireConnection;39;0;40;0
WireConnection;58;0;194;0
WireConnection;58;1;1009;0
WireConnection;194;14;42;0
WireConnection;194;15;51;0
WireConnection;1009;4;995;0
WireConnection;417;0;1012;0
WireConnection;417;2;58;0
WireConnection;417;3;194;0
WireConnection;61;0;417;0
WireConnection;85;0;1046;0
WireConnection;1044;0;1043;0
WireConnection;1044;1;1037;0
WireConnection;1045;0;1044;0
WireConnection;1046;0;416;0
WireConnection;1046;1;1045;0
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
WireConnection;1118;0;1121;0
WireConnection;1121;0;1135;19
WireConnection;1121;1;1083;0
WireConnection;1077;0;1081;0
WireConnection;1081;0;1129;0
WireConnection;1081;1;1083;0
WireConnection;1129;0;1135;0
WireConnection;1129;1;1136;0
WireConnection;1129;2;1108;0
WireConnection;8;1;4;0
WireConnection;1135;9;1053;0
WireConnection;1135;15;1076;0
WireConnection;1135;14;1071;0
WireConnection;1136;9;1124;0
WireConnection;1136;15;1076;0
WireConnection;1136;14;1071;0
WireConnection;793;0;331;0
WireConnection;1147;0;1155;0
WireConnection;1147;1;1148;0
WireConnection;1147;2;1149;0
WireConnection;1147;3;328;0
WireConnection;1145;0;1156;0
WireConnection;1145;1;1146;0
WireConnection;1145;2;329;0
WireConnection;1145;3;1147;0
WireConnection;330;0;1145;0
WireConnection;354;0;352;0
WireConnection;847;0;845;0
WireConnection;847;1;848;0
WireConnection;847;2;848;0
WireConnection;844;1;951;0
WireConnection;837;0;835;0
WireConnection;837;1;836;0
WireConnection;838;0;837;0
WireConnection;841;0;840;0
WireConnection;835;0;842;0
WireConnection;840;0;952;0
WireConnection;840;1;835;0
WireConnection;849;0;844;0
WireConnection;352;0;353;0
WireConnection;307;0;308;0
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
WireConnection;753;0;1020;0
WireConnection;755;0;1020;1
WireConnection;1091;0;1019;0
WireConnection;1091;1;1014;0
WireConnection;309;0;303;0
WireConnection;303;0;304;0
WireConnection;303;1;306;0
WireConnection;303;2;305;0
WireConnection;303;3;1020;0
WireConnection;303;4;1020;1
WireConnection;1206;0;1205;0
WireConnection;1206;1;1203;0
WireConnection;1254;0;1206;0
WireConnection;1203;0;1204;0
WireConnection;1209;0;1207;0
WireConnection;1208;0;1255;0
WireConnection;1208;1;1210;0
WireConnection;1211;0;1213;0
WireConnection;1211;1;1214;0
WireConnection;1218;0;1216;0
WireConnection;1216;0;1208;0
WireConnection;1216;1;1211;0
WireConnection;952;0;839;0
WireConnection;952;2;839;0
WireConnection;952;3;954;0
WireConnection;942;0;413;1
WireConnection;414;0;942;0
WireConnection;1305;0;1306;0
WireConnection;1306;0;1307;0
WireConnection;1309;0;1281;0
WireConnection;1309;1;1310;0
WireConnection;1309;2;1305;0
WireConnection;1312;0;1217;0
WireConnection;1312;1;1309;0
WireConnection;1289;0;1312;0
WireConnection;1229;0;1218;0
WireConnection;1330;0;1338;0
WireConnection;1339;0;1330;0
WireConnection;1338;0;1273;0
WireConnection;1357;0;1317;0
WireConnection;1356;0;1362;0
WireConnection;1356;1;1274;0
WireConnection;1356;2;1273;0
WireConnection;1348;0;1347;0
WireConnection;1351;0;1348;0
WireConnection;1351;2;1352;0
WireConnection;1340;0;1356;0
WireConnection;1340;2;1317;0
WireConnection;1355;0;1340;0
WireConnection;1355;1;1351;0
WireConnection;1353;0;1355;0
WireConnection;1353;2;1317;0
WireConnection;1326;0;1339;0
WireConnection;1326;1;1353;0
WireConnection;1315;0;1326;0
WireConnection;1315;2;1357;0
WireConnection;1363;0;1315;0
WireConnection;1219;0;1230;0
WireConnection;1219;1;1364;0
WireConnection;1219;2;1290;0
WireConnection;1144;0;1219;0
WireConnection;410;0;425;0
WireConnection;410;1;397;0
WireConnection;931;0;918;0
WireConnection;921;0;932;0
WireConnection;399;0;929;0
WireConnection;399;1;931;0
WireConnection;929;0;391;0
WireConnection;929;1;918;0
WireConnection;922;0;921;0
WireConnection;922;1;921;1
WireConnection;922;2;921;2
WireConnection;406;0;1287;0
WireConnection;406;1;960;0
WireConnection;406;2;426;0
WireConnection;945;0;938;0
WireConnection;938;0;908;0
WireConnection;938;1;402;0
WireConnection;932;0;399;0
WireConnection;411;0;945;0
WireConnection;402;0;410;0
WireConnection;402;1;406;0
WireConnection;799;0;788;0
WireConnection;918;0;799;0
WireConnection;918;1;400;0
WireConnection;960;0;405;0
WireConnection;424;0;922;0
WireConnection;400;0;401;0
WireConnection;405;0;409;0
WireConnection;405;1;1286;0
WireConnection;951;0;847;0
ASEEND*/
//CHKSM=50B41D1F32AA8011E53976BE01367F4596701648