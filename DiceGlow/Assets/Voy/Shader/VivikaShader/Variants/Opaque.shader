// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VoyVivika/VivikaShader/Vivika Shader Opaque"
{
	Properties
	{
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[SingleLineTexture]_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		[SingleLineTexture]_BumpMap("Normal Map", 2D) = "bump" {}
		_Emission("Emission", 2D) = "black" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_MinBrightness("Min Brightness", Range( 0 , 1)) = 0
		_IndirectDiffuseOffset("Indirect Light Min", Range( 0 , 1)) = 0
		_IndirectDiffuseOffsetMax("Indirect Light Max", Range( 0 , 1)) = 0
		[ToggleUI]_IndirLightUseMinforMax("Use Min for Max", Float) = 1
		[Enum(Clamp,0,Remap,1)]_IndirectLimiterMode("Indirect Limiter Mode", Float) = 0
		_WrappedShadingValue("Wrapped Shading Value", Float) = 1
		_WrapIndirScale("Indirect Light Scale", Float) = 3
		[SingleLineTexture]_MetallicGlossMap("Unity Metallic", 2D) = "black" {}
		_WrapMetallicFesnelScale("Metallic Fesnel Scale", Float) = 1
		_MetallicFresnelPower("Metallic Fresnel Power", Float) = 3
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_AOStrength("AO Strength", Range( 0 , 1)) = 1
		[ToggleUI]_RealAO("Real AO", Float) = 0
		[Header(AudioLink)][ToggleUI]_EnableAudioLink("Enable AudioLink", Range( 0 , 1)) = 0
		[ToggleUI]_ALEmitifInactive("AL Emit if Inactive", Float) = 0
		_AL_Mask("AudioLink Mask", 2D) = "black" {}
		[SingleLineTexture]_ALDelayMap("AudioLink Delay Tex Map", 2D) = "black" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,Screen Space,8)]_ALDelayUVMap("AL Delay UV Map", Float) = 2
		_ALUVDelayMaxDelay("AL UV Delay Max Delay", Range( 0 , 127)) = 0
		_ALTimeScale("AL HueShift Time Scale", Float) = 0
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
		[SingleLineTexture]_EmissionMap("Fallback Emission Map", 2D) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "VRCFallback"="DoubleSided" }
		Cull [_CullMode]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#include "..\Libs\AudioLink\AudioLink.cginc"
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
			float3 worldNormal;
			INTERNAL_DATA
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

		uniform float _CullMode;
		uniform sampler2D _EmissionMap;
		uniform float _DiscardUVTile00;
		uniform float _DiscardUVMap;
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
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _AmbientOcclusion;
		uniform float4 _AmbientOcclusion_ST;
		uniform float _AOStrength;
		uniform float _RealAO;
		uniform float4 _Color;
		uniform half _EnableAudioLink;
		uniform sampler2D _AL_Mask;
		uniform float4 _AL_Mask_ST;
		uniform float _ALTimeScale;
		uniform sampler2D _ALDelayMap;
		uniform float _ALDelayUVMap;
		uniform float _ALUVDelayMaxDelay;
		uniform float _ALEmitifInactive;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform half _EnableRimLighting;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _RimPower;
		uniform float _RimEnergy;
		uniform float _RimBaseColorStrength;
		uniform float _IndirectDiffuseOffsetMax;
		uniform float _IndirectDiffuseOffset;
		uniform float _IndirLightUseMinforMax;
		uniform float _WrappedShadingValue;
		uniform float _IndirectLimiterMode;
		uniform float _WrapIndirScale;
		uniform float _MinBrightness;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform float _WrapMetallicFesnelScale;
		uniform float _MetallicFresnelPower;


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

		inline float AudioLinkData3_g1071( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		float IfAudioLinkv2Exists1_g1073(  )
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


		inline float AudioLinkData3_g1076( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		float IfAudioLinkv2Exists1_g1078(  )
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


		inline float AudioLinkData3_g1081( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		float IfAudioLinkv2Exists1_g1083(  )
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


		inline float AudioLinkData3_g1086( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		float IfAudioLinkv2Exists1_g1088(  )
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


		float IfAudioLinkv2Exists1_g1068(  )
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


		float3 ShadeSH97_g1064( float4 Normal )
		{
			return ShadeSH9(Normal);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 break63_g1107 = floor( float2( 0,0 ) );
			float temp_output_8_0_g1093 = 0.0;
			float temp_output_26_0_g1089 = _DiscardUVMap;
			float temp_output_7_0_g1093 = temp_output_26_0_g1089;
			float2 lerpResult6_g1093 = lerp( float2( 0,0 ) , v.texcoord.xy , ( step( temp_output_8_0_g1093 , temp_output_7_0_g1093 ) * step( temp_output_7_0_g1093 , temp_output_8_0_g1093 ) ));
			float temp_output_8_0_g1090 = 1.0;
			float temp_output_7_0_g1090 = temp_output_26_0_g1089;
			float2 lerpResult6_g1090 = lerp( float2( 0,0 ) , v.texcoord1.xy , ( step( temp_output_8_0_g1090 , temp_output_7_0_g1090 ) * step( temp_output_7_0_g1090 , temp_output_8_0_g1090 ) ));
			float temp_output_8_0_g1091 = 2.0;
			float temp_output_7_0_g1091 = temp_output_26_0_g1089;
			float2 lerpResult6_g1091 = lerp( float2( 0,0 ) , v.texcoord2.xy , ( step( temp_output_8_0_g1091 , temp_output_7_0_g1091 ) * step( temp_output_7_0_g1091 , temp_output_8_0_g1091 ) ));
			float temp_output_8_0_g1092 = 3.0;
			float temp_output_7_0_g1092 = temp_output_26_0_g1089;
			float2 lerpResult6_g1092 = lerp( float2( 0,0 ) , v.texcoord3.xy , ( step( temp_output_8_0_g1092 , temp_output_7_0_g1092 ) * step( temp_output_7_0_g1092 , temp_output_8_0_g1092 ) ));
			float2 DiscardUV200 = ( lerpResult6_g1093 + lerpResult6_g1090 + lerpResult6_g1091 + lerpResult6_g1092 );
			float2 temp_output_99_0_g1094 = DiscardUV200;
			float2 break61_g1107 = temp_output_99_0_g1094;
			float2 break63_g1109 = floor( float2( 0,1 ) );
			float2 break61_g1109 = temp_output_99_0_g1094;
			float2 break63_g1106 = floor( float2( 0,2 ) );
			float2 break61_g1106 = temp_output_99_0_g1094;
			float2 break63_g1110 = floor( float2( 0,3 ) );
			float2 break61_g1110 = temp_output_99_0_g1094;
			float2 break63_g1108 = floor( float2( 1,0 ) );
			float2 break61_g1108 = temp_output_99_0_g1094;
			float2 break63_g1103 = floor( float2( 1,1 ) );
			float2 break61_g1103 = temp_output_99_0_g1094;
			float2 break63_g1104 = floor( float2( 1,2 ) );
			float2 break61_g1104 = temp_output_99_0_g1094;
			float2 break63_g1105 = floor( float2( 1,3 ) );
			float2 break61_g1105 = temp_output_99_0_g1094;
			float2 break63_g1102 = floor( float2( 2,0 ) );
			float2 break61_g1102 = temp_output_99_0_g1094;
			float2 break63_g1101 = floor( float2( 2,1 ) );
			float2 break61_g1101 = temp_output_99_0_g1094;
			float2 break63_g1100 = floor( float2( 2,2 ) );
			float2 break61_g1100 = temp_output_99_0_g1094;
			float2 break63_g1099 = floor( float2( 2,3 ) );
			float2 break61_g1099 = temp_output_99_0_g1094;
			float2 break63_g1095 = floor( float2( 3,0 ) );
			float2 break61_g1095 = temp_output_99_0_g1094;
			float2 break63_g1096 = floor( float2( 3,1 ) );
			float2 break61_g1096 = temp_output_99_0_g1094;
			float2 break63_g1097 = floor( float2( 3,2 ) );
			float2 break61_g1097 = temp_output_99_0_g1094;
			float2 break63_g1098 = floor( float2( 3,3 ) );
			float2 break61_g1098 = temp_output_99_0_g1094;
			float temp_output_66_0_g1094 = step( 1.0 , ( ( ( saturate( _DiscardUVTile00 ) * saturate( ( step( break63_g1107.x , break61_g1107.x ) * step( break61_g1107.x , ( break63_g1107.x + 0.9999999 ) ) * step( break63_g1107.y , break61_g1107.y ) * step( break61_g1107.y , ( break63_g1107.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile01 ) * saturate( ( step( break63_g1109.x , break61_g1109.x ) * step( break61_g1109.x , ( break63_g1109.x + 0.9999999 ) ) * step( break63_g1109.y , break61_g1109.y ) * step( break61_g1109.y , ( break63_g1109.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile02 ) * saturate( ( step( break63_g1106.x , break61_g1106.x ) * step( break61_g1106.x , ( break63_g1106.x + 0.9999999 ) ) * step( break63_g1106.y , break61_g1106.y ) * step( break61_g1106.y , ( break63_g1106.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile03 ) * saturate( ( step( break63_g1110.x , break61_g1110.x ) * step( break61_g1110.x , ( break63_g1110.x + 0.9999999 ) ) * step( break63_g1110.y , break61_g1110.y ) * step( break61_g1110.y , ( break63_g1110.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile10 ) * saturate( ( step( break63_g1108.x , break61_g1108.x ) * step( break61_g1108.x , ( break63_g1108.x + 0.9999999 ) ) * step( break63_g1108.y , break61_g1108.y ) * step( break61_g1108.y , ( break63_g1108.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile11 ) * saturate( ( step( break63_g1103.x , break61_g1103.x ) * step( break61_g1103.x , ( break63_g1103.x + 0.9999999 ) ) * step( break63_g1103.y , break61_g1103.y ) * step( break61_g1103.y , ( break63_g1103.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile12 ) * saturate( ( step( break63_g1104.x , break61_g1104.x ) * step( break61_g1104.x , ( break63_g1104.x + 0.9999999 ) ) * step( break63_g1104.y , break61_g1104.y ) * step( break61_g1104.y , ( break63_g1104.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile13 ) * saturate( ( step( break63_g1105.x , break61_g1105.x ) * step( break61_g1105.x , ( break63_g1105.x + 0.9999999 ) ) * step( break63_g1105.y , break61_g1105.y ) * step( break61_g1105.y , ( break63_g1105.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile20 ) * saturate( ( step( break63_g1102.x , break61_g1102.x ) * step( break61_g1102.x , ( break63_g1102.x + 0.9999999 ) ) * step( break63_g1102.y , break61_g1102.y ) * step( break61_g1102.y , ( break63_g1102.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile21 ) * saturate( ( step( break63_g1101.x , break61_g1101.x ) * step( break61_g1101.x , ( break63_g1101.x + 0.9999999 ) ) * step( break63_g1101.y , break61_g1101.y ) * step( break61_g1101.y , ( break63_g1101.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile22 ) * saturate( ( step( break63_g1100.x , break61_g1100.x ) * step( break61_g1100.x , ( break63_g1100.x + 0.9999999 ) ) * step( break63_g1100.y , break61_g1100.y ) * step( break61_g1100.y , ( break63_g1100.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile23 ) * saturate( ( step( break63_g1099.x , break61_g1099.x ) * step( break61_g1099.x , ( break63_g1099.x + 0.9999999 ) ) * step( break63_g1099.y , break61_g1099.y ) * step( break61_g1099.y , ( break63_g1099.y + 0.9999999 ) ) ) ) ) ) + ( ( saturate( _DiscardUVTile30 ) * saturate( ( step( break63_g1095.x , break61_g1095.x ) * step( break61_g1095.x , ( break63_g1095.x + 0.9999999 ) ) * step( break63_g1095.y , break61_g1095.y ) * step( break61_g1095.y , ( break63_g1095.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile31 ) * saturate( ( step( break63_g1096.x , break61_g1096.x ) * step( break61_g1096.x , ( break63_g1096.x + 0.9999999 ) ) * step( break63_g1096.y , break61_g1096.y ) * step( break61_g1096.y , ( break63_g1096.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile32 ) * saturate( ( step( break63_g1097.x , break61_g1097.x ) * step( break61_g1097.x , ( break63_g1097.x + 0.9999999 ) ) * step( break63_g1097.y , break61_g1097.y ) * step( break61_g1097.y , ( break63_g1097.y + 0.9999999 ) ) ) ) ) + ( saturate( _DiscardUVTile33 ) * saturate( ( step( break63_g1098.x , break61_g1098.x ) * step( break61_g1098.x , ( break63_g1098.x + 0.9999999 ) ) * step( break63_g1098.y , break61_g1098.y ) * step( break61_g1098.y , ( break63_g1098.y + 0.9999999 ) ) ) ) ) ) ) );
			float UVTileDiscard192 = ( temp_output_66_0_g1094 == 1.0 ? ( 0.0 / 0.0 ) : 0.0 );
			float3 temp_cast_0 = (UVTileDiscard192).xxx;
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
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 normalMap1002 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 temp_output_11_0_g1059 = normalMap1002;
			float3 temp_output_2_0_g1061 = temp_output_11_0_g1059;
			float dotResult3_g1063 = dot( ase_worldlightDir , (WorldNormalVector( i , temp_output_2_0_g1061 )) );
			float temp_output_5_0_g1062 = _WrappedShadingValue;
			float temp_output_15_0_g1061 = saturate( ase_lightAtten );
			float4 color16_g1061 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 lerpResult17_g1061 = lerp( color16_g1061 , ase_lightColor , temp_output_15_0_g1061);
			float3 temp_output_1_0_g1064 = temp_output_2_0_g1061;
			UnityGI gi2_g1064 = gi;
			float3 diffNorm2_g1064 = normalize( WorldNormalVector( i , temp_output_1_0_g1064 ) );
			gi2_g1064 = UnityGI_Base( data, 1, diffNorm2_g1064 );
			float3 indirectDiffuse2_g1064 = gi2_g1064.indirect.diffuse + diffNorm2_g1064 * 0.0001;
			float3 temp_output_34_0_g1064 = saturate( indirectDiffuse2_g1064 );
			float4 appendResult6_g1064 = (float4(( temp_output_1_0_g1064 * 0.3 ) , 1.0));
			float4 Normal7_g1064 = appendResult6_g1064;
			float3 localShadeSH97_g1064 = ShadeSH97_g1064( Normal7_g1064 );
			float temp_output_9_0_g1064 = _IndirectDiffuseOffset;
			float3 temp_cast_17 = (temp_output_9_0_g1064).xxx;
			float3 temp_output_15_0_g1064 = saturate( ( localShadeSH97_g1064 - temp_cast_17 ) );
			float temp_output_8_0_g1065 = 1.0;
			float temp_output_7_0_g1065 = _IndirLightUseMinforMax;
			float lerpResult6_g1065 = lerp( _IndirectDiffuseOffsetMax , temp_output_9_0_g1064 , ( step( temp_output_8_0_g1065 , temp_output_7_0_g1065 ) * step( temp_output_7_0_g1065 , temp_output_8_0_g1065 ) ));
			float3 temp_output_16_0_g1064 = saturate( ( localShadeSH97_g1064 + lerpResult6_g1065 ) );
			float3 clampResult17_g1064 = clamp( temp_output_34_0_g1064 , temp_output_15_0_g1064 , temp_output_16_0_g1064 );
			float3 lerpResult20_g1064 = lerp( clampResult17_g1064 , (temp_output_15_0_g1064 + (temp_output_34_0_g1064 - float3( 0,0,0 )) * (temp_output_16_0_g1064 - temp_output_15_0_g1064) / (float3( 1,1,1 ) - float3( 0,0,0 ))) , _IndirectLimiterMode);
			float4 color4_g1061 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 temp_cast_19 = (1.0).xxxx;
			float4 temp_cast_20 = (_MinBrightness).xxxx;
			float4 color40_g1061 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 clampResult37_g1061 = clamp( saturate( ( saturate( ( saturate( exp2( ( ( dotResult3_g1063 + temp_output_5_0_g1062 ) / ( 1.0 + temp_output_5_0_g1062 ) ) ) ) + saturate( exp2( temp_output_15_0_g1061 ) ) ) ) * saturate( ( saturate( lerpResult17_g1061 ) + saturate( (saturate( ( exp2( saturate( ( float4( lerpResult20_g1064 , 0.0 ) * color4_g1061 ) ) ) - temp_cast_19 ) )*_WrapIndirScale + 0.0) ) ) ) ) ) , temp_cast_20 , color40_g1061 );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 color8_g891 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			float4 temp_output_3_0_g891 = ( 1.0 - ( ( 1.0 - tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) ) * _AOStrength ) );
			float temp_output_9_0_g891 = _RealAO;
			float4 lerpResult5_g891 = lerp( color8_g891 , temp_output_3_0_g891 , temp_output_9_0_g891);
			float4 mainTex26 = ( tex2D( _MainTex, uv_MainTex ) * lerpResult5_g891 * _Color );
			float3 temp_output_1_0_g1060 = temp_output_11_0_g1059;
			float3 indirectNormal4_g1060 = normalize( WorldNormalVector( i , normalize( WorldReflectionVector( i , temp_output_1_0_g1060 ) ) ) );
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1017 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			float _Smoothness755 = tex2DNode1017.a;
			Unity_GlossyEnvironmentData g4_g1060 = UnityGlossyEnvironmentSetup( _Smoothness755, data.worldViewDir, indirectNormal4_g1060, float3(0,0,0));
			float3 indirectSpecular4_g1060 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal4_g1060, g4_g1060 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float _Metalic753 = tex2DNode1017.r;
			float fresnelNdotV8_g1060 = dot( normalize( normalize( (WorldNormalVector( i , temp_output_1_0_g1060 )) ) ), ase_worldViewDir );
			float fresnelNode8_g1060 = ( _Metalic753 + _WrapMetallicFesnelScale * pow( max( 1.0 - fresnelNdotV8_g1060 , 0.0001 ), _MetallicFresnelPower ) );
			float4 Lighting_Wrapped1144 = ( clampResult37_g1061 * ( mainTex26 + float4( ( saturate( indirectSpecular4_g1060 ) * fresnelNode8_g1060 ) , 0.0 ) ) );
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 color8_g891 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			float4 temp_output_3_0_g891 = ( 1.0 - ( ( 1.0 - tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) ) * _AOStrength ) );
			float temp_output_9_0_g891 = _RealAO;
			float4 lerpResult5_g891 = lerp( color8_g891 , temp_output_3_0_g891 , temp_output_9_0_g891);
			float4 mainTex26 = ( tex2D( _MainTex, uv_MainTex ) * lerpResult5_g891 * _Color );
			o.Albedo = mainTex26.rgb;
			float2 uv_AL_Mask = i.uv_texcoord * _AL_Mask_ST.xy + _AL_Mask_ST.zw;
			float4 ALMask39 = tex2D( _AL_Mask, uv_AL_Mask );
			float4 temp_output_51_0_g1067 = ALMask39;
			float4 color42 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float3 hsvTorgb4_g1070 = RGBToHSV( color42.rgb );
			float mulTime48 = _Time.y * _ALTimeScale;
			float Time50 = frac( mulTime48 );
			float temp_output_54_0_g1067 = Time50;
			float3 hsvTorgb8_g1070 = HSVToRGB( float3(( hsvTorgb4_g1070.x + temp_output_54_0_g1067 ),( hsvTorgb4_g1070.y + 0.0 ),( hsvTorgb4_g1070.z + 0.0 )) );
			float3 temp_output_5_0_g1069 = saturate( hsvTorgb8_g1070 );
			int Band3_g1071 = 0;
			float temp_output_8_0_g888 = 0.0;
			float temp_output_32_0_g885 = _ALDelayUVMap;
			float temp_output_7_0_g888 = temp_output_32_0_g885;
			float2 lerpResult6_g888 = lerp( float2( 0,0 ) , i.uv_texcoord , ( step( temp_output_8_0_g888 , temp_output_7_0_g888 ) * step( temp_output_7_0_g888 , temp_output_8_0_g888 ) ));
			float temp_output_8_0_g886 = 1.0;
			float temp_output_7_0_g886 = temp_output_32_0_g885;
			float2 lerpResult6_g886 = lerp( float2( 0,0 ) , i.uv2_texcoord2 , ( step( temp_output_8_0_g886 , temp_output_7_0_g886 ) * step( temp_output_7_0_g886 , temp_output_8_0_g886 ) ));
			float temp_output_8_0_g887 = 2.0;
			float temp_output_7_0_g887 = temp_output_32_0_g885;
			float2 lerpResult6_g887 = lerp( float2( 0,0 ) , i.uv3_texcoord3 , ( step( temp_output_8_0_g887 , temp_output_7_0_g887 ) * step( temp_output_7_0_g887 , temp_output_8_0_g887 ) ));
			float temp_output_8_0_g889 = 3.0;
			float temp_output_7_0_g889 = temp_output_32_0_g885;
			float2 lerpResult6_g889 = lerp( float2( 0,0 ) , i.uv4_texcoord4 , ( step( temp_output_8_0_g889 , temp_output_7_0_g889 ) * step( temp_output_7_0_g889 , temp_output_8_0_g889 ) ));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult18_g885 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float temp_output_8_0_g890 = 8.0;
			float temp_output_7_0_g890 = temp_output_32_0_g885;
			float2 lerpResult6_g890 = lerp( float2( 0,0 ) , appendResult18_g885 , ( step( temp_output_8_0_g890 , temp_output_7_0_g890 ) * step( temp_output_7_0_g890 , temp_output_8_0_g890 ) ));
			float2 DelayUV2355 = ( lerpResult6_g888 + lerpResult6_g886 + lerpResult6_g887 + lerpResult6_g889 + lerpResult6_g890 );
			float3 hsvTorgb2458 = RGBToHSV( tex2D( _ALDelayMap, DelayUV2355 ).rgb );
			float clampResult987 = clamp( (0.0 + (hsvTorgb2458.z - 0.0) * (_ALUVDelayMaxDelay - 0.0) / (1.0 - 0.0)) , 0.0 , 127.0 );
			float in_ALDelay991 = round( clampResult987 );
			int temp_output_55_0_g1067 = (int)in_ALDelay991;
			int Delay3_g1071 = temp_output_55_0_g1067;
			float localAudioLinkData3_g1071 = AudioLinkData3_g1071( Band3_g1071 , Delay3_g1071 );
			float temp_output_8_0_g1072 = 1.0;
			float localIfAudioLinkv2Exists1_g1073 = IfAudioLinkv2Exists1_g1073();
			float temp_output_7_0_g1072 = saturate( ( localIfAudioLinkv2Exists1_g1073 + 1.0 ) );
			float3 lerpResult6_g1072 = lerp( temp_output_5_0_g1069 , ( temp_output_5_0_g1069 * localAudioLinkData3_g1071 ) , ( step( temp_output_8_0_g1072 , temp_output_7_0_g1072 ) * step( temp_output_7_0_g1072 , temp_output_8_0_g1072 ) ));
			float4 color44 = IsGammaSpace() ? float4(0,0.8196079,0,1) : float4(0,0.637597,0,1);
			float3 hsvTorgb4_g1075 = RGBToHSV( color44.rgb );
			float3 hsvTorgb8_g1075 = HSVToRGB( float3(( hsvTorgb4_g1075.x + temp_output_54_0_g1067 ),( hsvTorgb4_g1075.y + 0.0 ),( hsvTorgb4_g1075.z + 0.0 )) );
			float3 temp_output_5_0_g1074 = saturate( hsvTorgb8_g1075 );
			int Band3_g1076 = 2;
			int Delay3_g1076 = temp_output_55_0_g1067;
			float localAudioLinkData3_g1076 = AudioLinkData3_g1076( Band3_g1076 , Delay3_g1076 );
			float temp_output_8_0_g1077 = 1.0;
			float localIfAudioLinkv2Exists1_g1078 = IfAudioLinkv2Exists1_g1078();
			float temp_output_7_0_g1077 = saturate( ( localIfAudioLinkv2Exists1_g1078 + 0.0 ) );
			float3 lerpResult6_g1077 = lerp( temp_output_5_0_g1074 , ( temp_output_5_0_g1074 * localAudioLinkData3_g1076 ) , ( step( temp_output_8_0_g1077 , temp_output_7_0_g1077 ) * step( temp_output_7_0_g1077 , temp_output_8_0_g1077 ) ));
			float4 color43 = IsGammaSpace() ? float4(1,0.9294118,0,1) : float4(1,0.8468735,0,1);
			float3 hsvTorgb4_g1080 = RGBToHSV( color43.rgb );
			float3 hsvTorgb8_g1080 = HSVToRGB( float3(( hsvTorgb4_g1080.x + temp_output_54_0_g1067 ),( hsvTorgb4_g1080.y + 0.0 ),( hsvTorgb4_g1080.z + 0.0 )) );
			float3 temp_output_5_0_g1079 = saturate( hsvTorgb8_g1080 );
			int Band3_g1081 = 1;
			int Delay3_g1081 = temp_output_55_0_g1067;
			float localAudioLinkData3_g1081 = AudioLinkData3_g1081( Band3_g1081 , Delay3_g1081 );
			float temp_output_8_0_g1082 = 1.0;
			float localIfAudioLinkv2Exists1_g1083 = IfAudioLinkv2Exists1_g1083();
			float temp_output_7_0_g1082 = saturate( ( localIfAudioLinkv2Exists1_g1083 + 0.0 ) );
			float3 lerpResult6_g1082 = lerp( temp_output_5_0_g1079 , ( temp_output_5_0_g1079 * localAudioLinkData3_g1081 ) , ( step( temp_output_8_0_g1082 , temp_output_7_0_g1082 ) * step( temp_output_7_0_g1082 , temp_output_8_0_g1082 ) ));
			float4 color45 = IsGammaSpace() ? float4(0,0,1,1) : float4(0,0,1,1);
			float3 hsvTorgb4_g1085 = RGBToHSV( color45.rgb );
			float3 hsvTorgb8_g1085 = HSVToRGB( float3(( hsvTorgb4_g1085.x + temp_output_54_0_g1067 ),( hsvTorgb4_g1085.y + 0.0 ),( hsvTorgb4_g1085.z + 0.0 )) );
			float3 temp_output_5_0_g1084 = saturate( hsvTorgb8_g1085 );
			int Band3_g1086 = 3;
			int Delay3_g1086 = temp_output_55_0_g1067;
			float localAudioLinkData3_g1086 = AudioLinkData3_g1086( Band3_g1086 , Delay3_g1086 );
			float temp_output_8_0_g1087 = 1.0;
			float localIfAudioLinkv2Exists1_g1088 = IfAudioLinkv2Exists1_g1088();
			float temp_output_7_0_g1087 = saturate( ( localIfAudioLinkv2Exists1_g1088 + 0.0 ) );
			float3 lerpResult6_g1087 = lerp( temp_output_5_0_g1084 , ( temp_output_5_0_g1084 * localAudioLinkData3_g1086 ) , ( step( temp_output_8_0_g1087 , temp_output_7_0_g1087 ) * step( temp_output_7_0_g1087 , temp_output_8_0_g1087 ) ));
			float localIfAudioLinkv2Exists1_g1068 = IfAudioLinkv2Exists1_g1068();
			float4 AL_Final85 = ( ( _EnableAudioLink * ( ( temp_output_51_0_g1067 * float4( lerpResult6_g1072 , 0.0 ) ) + ( temp_output_51_0_g1067 * float4( lerpResult6_g1077 , 0.0 ) ) + ( temp_output_51_0_g1067 * float4( lerpResult6_g1082 , 0.0 ) ) + ( temp_output_51_0_g1067 * float4( lerpResult6_g1087 , 0.0 ) ) ) ) * saturate( ( localIfAudioLinkv2Exists1_g1068 + _ALEmitifInactive ) ) );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 Emission119 = ( tex2D( _Emission, uv_Emission ) * _EmissionColor );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 normalMap1002 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float fresnelNdotV9_g1066 = dot( (WorldNormalVector( i , normalMap1002 )), ase_worldViewDir );
			float fresnelNode9_g1066 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV9_g1066, _RimPower ) );
			float4 lerpResult14_g1066 = lerp( float4( 1,1,1,0 ) , mainTex26 , _RimBaseColorStrength);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 hsvTorgb3_g1066 = RGBToHSV( ase_lightColor.rgb );
			float3 temp_output_11_0_g1059 = normalMap1002;
			float3 temp_output_2_0_g1061 = temp_output_11_0_g1059;
			float3 temp_output_1_0_g1064 = temp_output_2_0_g1061;
			float4 appendResult6_g1064 = (float4(( temp_output_1_0_g1064 * 0.3 ) , 1.0));
			float4 Normal7_g1064 = appendResult6_g1064;
			float3 localShadeSH97_g1064 = ShadeSH97_g1064( Normal7_g1064 );
			float temp_output_9_0_g1064 = _IndirectDiffuseOffset;
			float temp_output_8_0_g1065 = 1.0;
			float temp_output_7_0_g1065 = _IndirLightUseMinforMax;
			float lerpResult6_g1065 = lerp( _IndirectDiffuseOffsetMax , temp_output_9_0_g1064 , ( step( temp_output_8_0_g1065 , temp_output_7_0_g1065 ) * step( temp_output_7_0_g1065 , temp_output_8_0_g1065 ) ));
			float3 temp_output_16_0_g1064 = saturate( ( localShadeSH97_g1064 + lerpResult6_g1065 ) );
			float3 maxIndirLight2618 = temp_output_16_0_g1064;
			float3 hsvTorgb24_g1066 = RGBToHSV( maxIndirLight2618 );
			float4 Rim116 = ( _EnableRimLighting * ( ( ( fresnelNode9_g1066 * _RimEnergy ) * lerpResult14_g1066 ) * max( ( 0.0 * saturate( ( exp( hsvTorgb3_g1066.z ) - 1.0 ) ) ) , hsvTorgb24_g1066.z ) ) );
			float4 EmissionFinal29 = saturate( ( AL_Final85 + Emission119 + Rim116 ) );
			o.Emission = EmissionFinal29.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
Version=19303
Node;AmplifyShaderEditor.CommentaryNode;2333;-2064,-2752;Inherit;False;673.8176;177.324;Selection of UV Maps to Use for UV Tile Discarding;3;2355;2627;2357;Audio Link Delay UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2357;-2032,-2688;Inherit;False;Property;_ALDelayUVMap;AL Delay UV Map;23;2;[Header];[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;Screen Space;8;0;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2627;-1824,-2688;Inherit;False;VVGetTextureUV;-1;;885;c300954d56021714fb5c622c8f34ec06;0;1;32;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2064,-3536;Inherit;False;1084.464;673.0301;Comment;11;2630;2546;2307;26;1003;2629;25;2552;2540;2542;1047;MainTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;977;-272,-3248;Inherit;False;1452.845;376.6802;Comment;8;991;985;987;979;993;2458;2457;2363;AudioLink Delay Settings;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2355;-1616,-2688;Inherit;False;DelayUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;37;-1072,-1328;Inherit;False;859.9141;343.3768;Comment;3;34;1002;1006;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2363;-240,-3152;Inherit;False;2355;DelayUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2542;-2000,-3280;Inherit;False;Property;_AOStrength;AO Strength;17;0;Create;True;0;0;0;False;0;False;1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2540;-2032,-3216;Inherit;True;Property;_AmbientOcclusion;Ambient Occlusion;16;0;Create;True;0;0;0;False;0;False;-1;None;cbb0fb74fb087f94db59618e2c77cb4e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2552;-1872,-3040;Inherit;False;Property;_RealAO;Real AO;18;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1003;-2000,-3472;Inherit;True;Property;_MainTex;Albedo;1;1;[SingleLineTexture];Create;False;1;Standard Fallbacks;0;0;True;0;False;None;411703fcc42d53946ab2cd7871aa1529;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;2457;-32,-3168;Inherit;True;Property;_ALDelayMap;AudioLink Delay Tex Map;22;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;2050;-1728,-1440;Inherit;False;551.9897;288.0864;Comment;3;755;753;1017;Metallic and Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;25;-1712,-3472;Inherit;True;Property;_AlbedoSample;Albedo Sample;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1006;-1008,-1216;Inherit;True;Property;_BumpMap;Normal Map;3;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;2307;-1616,-3056;Inherit;False;Property;_Color;Color;2;0;Create;False;0;0;0;True;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2630;-1728,-3200;Inherit;False;VVAmbientOcclusion;-1;;891;9931be4718b157b4ebb46a99812bfe31;0;3;6;FLOAT;0;False;7;COLOR;0,0,0,0;False;9;FLOAT;0;False;2;COLOR;11;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;34;-736,-1216;Inherit;True;Property;_NMSample;NM Sample;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;72;1440,-3088;Inherit;False;765.7347;170.1592;Comment;4;243;50;49;48;Time;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;979;160,-2976;Inherit;False;Property;_ALUVDelayMaxDelay;AL UV Delay Max Delay;24;0;Create;True;0;0;0;False;0;False;0;127;0;127;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2458;256,-3168;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;1017;-1696,-1376;Inherit;True;Property;_MetallicGlossMap;Unity Metallic;13;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;d67612330337b144583e5ca14791e406;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2629;-1360,-3312;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1002;-416,-1200;Inherit;False;normalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;993;496,-3184;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;1472,-3040;Inherit;False;Property;_ALTimeScale;AL HueShift Time Scale;25;0;Create;False;0;0;0;False;0;False;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2602;-1728,-896;Inherit;False;1076;931;Comment;15;2392;2414;2415;2556;1207;2567;2589;2375;2582;2583;1497;2584;2291;1144;2618;Shading;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;755;-1408,-1280;Inherit;False;_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;753;-1408,-1344;Inherit;False;_Metalic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-1200,-3312;Inherit;False;mainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;38;16,-2656;Inherit;False;604.8932;280;Comment;2;40;39;AL Emission Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;987;672,-3184;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;127;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;48;1712,-3040;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2392;-1680,-848;Inherit;False;Property;_IndirectDiffuseOffset;Indirect Light Min;7;0;Create;False;0;0;0;False;0;False;0;0.04;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2414;-1680,-784;Inherit;False;Property;_IndirectDiffuseOffsetMax;Indirect Light Max;8;0;Create;False;0;0;0;False;0;False;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2415;-1584,-720;Inherit;False;Property;_IndirLightUseMinforMax;Use Min for Max;9;1;[ToggleUI];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2556;-1648,-656;Inherit;False;Property;_IndirectLimiterMode;Indirect Limiter Mode;10;1;[Enum];Create;True;0;2;Clamp;0;Remap;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1207;-1648,-592;Inherit;False;Property;_WrappedShadingValue;Wrapped Shading Value;11;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2567;-1648,-144;Inherit;False;Property;_MetallicFresnelPower;Metallic Fresnel Power;15;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2589;-1584,-80;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2375;-1680,-464;Inherit;False;Property;_MinBrightness;Min Brightness;6;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2582;-1584,-400;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2583;-1616,-336;Inherit;False;755;_Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1497;-1616,-208;Inherit;False;Property;_WrapMetallicFesnelScale;Metallic Fesnel Scale;14;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2584;-1584,-272;Inherit;False;753;_Metalic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2291;-1616,-528;Inherit;False;Property;_WrapIndirScale;Indirect Light Scale;12;0;Create;False;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;49;1872,-3040;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;985;800,-3184;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;80,-2608;Inherit;True;Property;_AL_Mask;AudioLink Mask;21;0;Create;False;0;0;0;False;0;False;-1;None;2414abd24fe758f428a48c511a3c37d3;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2644;-1328,-640;Inherit;True;VivikaShading;-1;;1059;efce34b3f4a0e2b44933c4737d48061f;0;13;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;3;False;9;FLOAT;0;False;10;FLOAT;0;False;11;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;18;COLOR;0,0,0,0;False;2;FLOAT3;32;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1;32,-1120;Inherit;False;1041.734;585.5447;Comment;9;116;2620;2621;333;2505;1404;12;87;113;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;117;16,-2288;Inherit;False;907.3133;529.2772;Comment;4;1005;119;121;118;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-1328,-2656;Inherit;False;1185.214;1096.479;Comment;11;85;2616;42;44;43;45;415;2614;995;51;75;AudioLink Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;944,-3168;Inherit;False;in_ALDelay;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;1984,-3040;Inherit;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;400,-2608;Inherit;False;ALMask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2618;-896,-688;Inherit;False;maxIndirLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;201;-2064,-2464;Inherit;False;668.8916;177.8153;Selection of UV Maps to Use for UV Tile Discarding;3;2313;200;2626;Discard UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;-944,-1920;Inherit;False;39;ALMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1168,-1936;Inherit;False;50;Time;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;995;-1168,-1872;Inherit;False;991;in_ALDelay;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2614;-1200,-1744;Inherit;False;Property;_ALEmitifInactive;AL Emit if Inactive;20;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;415;-1264,-1808;Half;False;Property;_EnableAudioLink;Enable AudioLink;19;2;[Header];[ToggleUI];Create;True;1;AudioLink;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-1200,-2096;Inherit;False;Constant;_AL_Treble;AL_Treble;6;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;43;-1200,-2256;Inherit;False;Constant;_AL_LowMid;AL_LowMid;6;0;Create;True;0;0;0;False;0;False;1,0.9294118,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-1200,-2416;Inherit;False;Constant;_AL_HighMid;AL_HighMid;6;0;Create;True;0;0;0;False;0;False;0,0.8196079,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;42;-1200,-2576;Inherit;False;Constant;_AL_Bass;AL_Bass;6;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;113;96,-848;Inherit;False;Property;_RimBaseColorStrength;Rim Base Color Strength;29;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;96,-912;Inherit;False;Property;_RimEnergy;Rim Energy;28;0;Create;True;0;0;0;False;0;False;0.345;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;96,-976;Float;False;Property;_RimPower;Rim Power;27;0;Create;True;0;0;0;False;0;False;2.07;1.86;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1404;192,-784;Inherit;False;1002;normalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2505;160,-720;Inherit;False;2618;maxIndirLight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;333;96,-1040;Half;False;Property;_EnableRimLighting;Enable Rim Lighting;26;1;[ToggleUI];Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2621;192,-656;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1005;128,-1952;Inherit;False;Property;_EmissionColor;Emission Color;5;0;Create;False;0;0;0;True;0;False;0,0,0,0;0,1,0.9604408,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;118;80,-2224;Inherit;True;Property;_Emission;Emission;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;432,-2144;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2313;-2016,-2400;Inherit;False;Property;_DiscardUVMap;Discard UV Map;30;2;[Header];[Enum];Create;True;1;UV Tile Discarding;4;UV0;0;UV1;1;UV2;2;UV3;3;0;True;0;False;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2620;496,-912;Inherit;False;Rim;-1;;1066;652e8c2aadb4b694999944f1079d1366;0;7;29;FLOAT;0;False;30;FLOAT;0;False;31;FLOAT;0;False;32;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT3;0,0,0;False;28;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2616;-720,-2336;Inherit;False;VVALCombine;-1;;1067;bceeba5c9c06c59459d6b7e4bf2084da;0;9;54;FLOAT;0;False;55;INT;0;False;25;COLOR;1,0,0,1;False;27;COLOR;1,0.9294118,0,1;False;26;COLOR;0,0.8196079,0,1;False;28;COLOR;0,0,1,1;False;51;COLOR;0,0,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;31;16,-1680;Inherit;False;798.6848;366.049;Comment;6;29;2539;30;86;28;122;Emission Combination;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;592,-2224;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-400,-2288;Inherit;False;AL_Final;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;848,-912;Float;False;Rim;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2626;-1840,-2400;Inherit;False;VVGetVertexUV;-1;;1089;b2c6b9b1b245cf54ca03e50557eebb87;0;1;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;138;1744,-1136;Inherit;False;1050.305;1191.881;Comment;19;192;198;774;775;776;777;773;772;771;770;768;767;766;765;764;763;762;270;2640;UV Tile Discard;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;48,-1520;Inherit;False;119;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;32,-1440;Inherit;False;116;Rim;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;32,-1616;Inherit;False;85;AL_Final;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-1632,-2400;Inherit;False;DiscardUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;240,-1536;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;270;1776,-1088;Inherit;False;Property;_DiscardUVTile00;Discard UV Tile 0,0;31;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;762;1776,-1024;Inherit;False;Property;_DiscardUVTile01;Discard UV Tile 0,1;32;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;763;1776,-960;Inherit;False;Property;_DiscardUVTile02;Discard UV Tile 0,2;33;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;764;1776,-896;Inherit;False;Property;_DiscardUVTile03;Discard UV Tile 0,3;34;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;765;1776,-832;Inherit;False;Property;_DiscardUVTile10;Discard UV Tile 1,0;35;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;766;1776,-768;Inherit;False;Property;_DiscardUVTile11;Discard UV Tile 1,1;36;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;767;1776,-704;Inherit;False;Property;_DiscardUVTile12;Discard UV Tile 1,2;37;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;768;1776,-640;Inherit;False;Property;_DiscardUVTile13;Discard UV Tile 1,3;38;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;770;1776,-576;Inherit;False;Property;_DiscardUVTile20;Discard UV Tile 2,0;39;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;771;1776,-512;Inherit;False;Property;_DiscardUVTile21;Discard UV Tile 2,1;40;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;772;1776,-448;Inherit;False;Property;_DiscardUVTile22;Discard UV Tile 2,2;41;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;773;1776,-384;Inherit;False;Property;_DiscardUVTile23;Discard UV Tile 2,3;42;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;777;1776,-128;Inherit;False;Property;_DiscardUVTile33;Discard UV Tile 3,3;46;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;776;1776,-192;Inherit;False;Property;_DiscardUVTile32;Discard UV Tile 3,2;45;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;775;1776,-256;Inherit;False;Property;_DiscardUVTile31;Discard UV Tile 3,1;43;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;774;1776,-320;Inherit;False;Property;_DiscardUVTile30;Discard UV Tile 3,0;44;1;[ToggleUI];Create;True;1;UV Tile Discard;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;1872,-64;Inherit;False;200;DiscardUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;2539;448,-1536;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2640;2256,-736;Inherit;False;VVUVTileDiscardFull;-1;;1094;37cd3007c1dbdac4b9341609f3fa3a5a;0;17;100;FLOAT;0;False;101;FLOAT;0;False;102;FLOAT;0;False;103;FLOAT;0;False;104;FLOAT;0;False;105;FLOAT;0;False;106;FLOAT;0;False;107;FLOAT;0;False;108;FLOAT;0;False;109;FLOAT;0;False;110;FLOAT;0;False;111;FLOAT;0;False;112;FLOAT;0;False;113;FLOAT;0;False;114;FLOAT;0;False;115;FLOAT;0;False;99;FLOAT2;0,0;False;2;FLOAT;116;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;220;1248,-2688;Inherit;False;962.8354;715.8684;Comment;5;0;33;32;193;332;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;217;1840,-1792;Inherit;False;420.8079;185;Comment;2;219;218;Declare NaN;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1144;-896,-576;Inherit;False;Lighting Wrapped;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;592,-1536;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;2560,-672;Inherit;False;UVTileDiscard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2641;-688.6962,-4043.483;Inherit;False;324;355;Comment;1;2642;Fallbacks;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;1488,-2640;Inherit;False;26;mainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;218;1888,-1744;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;2048,-1744;Inherit;False;NaN;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;193;1552,-2176;Inherit;False;192;UVTileDiscard;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;1504,-2464;Inherit;False;29;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2546;-1312,-3088;Inherit;False;ao_times_strength;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2635;2480,-1488;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1047;-1232,-3456;Inherit;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2642;-640.6962,-3979.483;Inherit;True;Property;_EmissionMap;Fallback Emission Map;47;1;[SingleLineTexture];Create;False;0;0;0;True;0;False;None;2414abd24fe758f428a48c511a3c37d3;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;332;1728,-2304;Inherit;False;1144;Lighting Wrapped;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1968,-2528;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;VoyVivika/VivikaShader/Vivika Shader Opaque;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Standard;-1;-1;-1;-1;1;VRCFallback=DoubleSided;False;0;0;True;_CullMode;-1;0;False;;1;Include;..\Libs\AudioLink\AudioLink.cginc;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2627;32;2357;0
WireConnection;2355;0;2627;0
WireConnection;2457;1;2363;0
WireConnection;25;0;1003;0
WireConnection;2630;6;2542;0
WireConnection;2630;7;2540;0
WireConnection;2630;9;2552;0
WireConnection;34;0;1006;0
WireConnection;2458;0;2457;0
WireConnection;2629;0;25;0
WireConnection;2629;1;2630;11
WireConnection;2629;2;2307;0
WireConnection;1002;0;34;0
WireConnection;993;0;2458;3
WireConnection;993;4;979;0
WireConnection;755;0;1017;4
WireConnection;753;0;1017;1
WireConnection;26;0;2629;0
WireConnection;987;0;993;0
WireConnection;48;0;243;0
WireConnection;49;0;48;0
WireConnection;985;0;987;0
WireConnection;2644;4;2392;0
WireConnection;2644;5;2414;0
WireConnection;2644;6;2415;0
WireConnection;2644;7;2556;0
WireConnection;2644;8;1207;0
WireConnection;2644;9;2291;0
WireConnection;2644;10;2375;0
WireConnection;2644;11;2582;0
WireConnection;2644;12;2583;0
WireConnection;2644;13;2584;0
WireConnection;2644;16;1497;0
WireConnection;2644;17;2567;0
WireConnection;2644;18;2589;0
WireConnection;991;0;985;0
WireConnection;50;0;49;0
WireConnection;39;0;40;0
WireConnection;2618;0;2644;32
WireConnection;121;0;118;0
WireConnection;121;1;1005;0
WireConnection;2620;29;333;0
WireConnection;2620;30;12;0
WireConnection;2620;31;87;0
WireConnection;2620;32;113;0
WireConnection;2620;26;1404;0
WireConnection;2620;27;2505;0
WireConnection;2620;28;2621;0
WireConnection;2616;54;51;0
WireConnection;2616;55;995;0
WireConnection;2616;25;42;0
WireConnection;2616;27;43;0
WireConnection;2616;26;44;0
WireConnection;2616;28;45;0
WireConnection;2616;51;75;0
WireConnection;2616;52;415;0
WireConnection;2616;53;2614;0
WireConnection;119;0;121;0
WireConnection;85;0;2616;0
WireConnection;116;0;2620;0
WireConnection;2626;26;2313;0
WireConnection;200;0;2626;0
WireConnection;30;0;86;0
WireConnection;30;1;122;0
WireConnection;30;2;28;0
WireConnection;2539;0;30;0
WireConnection;2640;100;270;0
WireConnection;2640;101;762;0
WireConnection;2640;102;763;0
WireConnection;2640;103;764;0
WireConnection;2640;104;765;0
WireConnection;2640;105;766;0
WireConnection;2640;106;767;0
WireConnection;2640;107;768;0
WireConnection;2640;108;770;0
WireConnection;2640;109;771;0
WireConnection;2640;110;772;0
WireConnection;2640;111;773;0
WireConnection;2640;112;774;0
WireConnection;2640;113;775;0
WireConnection;2640;114;776;0
WireConnection;2640;115;777;0
WireConnection;2640;99;198;0
WireConnection;1144;0;2644;0
WireConnection;29;0;2539;0
WireConnection;192;0;2640;0
WireConnection;219;0;218;0
WireConnection;2546;0;2630;0
WireConnection;0;0;33;0
WireConnection;0;2;32;0
WireConnection;0;13;332;0
WireConnection;0;11;193;0
ASEEND*/
//CHKSM=125F224EEB365573219C49BDC34428F5CDB919D7