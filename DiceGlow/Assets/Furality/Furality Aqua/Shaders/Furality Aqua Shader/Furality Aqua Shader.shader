// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Furality/Aqua Shader/Aqua Shader"
{
	Properties
	{
		[Header(Texture Settings)]_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_AlphaMask("AlphaMask", 2D) = "white" {}
		[Normal]_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Scale", Range( 0 , 1)) = 1
		[ToggleUI]_EnableEmission("Enable Emission", Float) = 0
		_EmissionMap("Emission", 2D) = "black" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_Specular("Specular", 2D) = "white" {}
		[HDR]_SpecularTint("Specular Color", Color) = (1,1,1,0)
		[ToggleUI]_UseSpecularTexture("Use Specular", Float) = 0
		_MetallicGlossMap("Metallic", 2D) = "black" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_MetallicMult("Metallic Mult", Float) = 1
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		_SmoothnessMult("Smoothness Mult", Float) = 1
		_OcclusionMap("Occlusion", 2D) = "white" {}
		_OcclusionStrength("Occlusion Strength", Range( 0 , 1)) = 1
		_FakeLightDir("Fake Light Dir", Vector) = (1,1,2,0)
		_ShadingOffset("Lighting Offset", Range( -0.5 , 0.5)) = 0
		_SecretLightingToggle("SecretLightingToggle", Float) = 0
		_SoftenLighting("Soften Lighting", Range( 0 , 0.75)) = 0
		_ToonLighting1("Toon Lighting", Range( 0 , 0.49)) = 0
		_ToonLighting2("Toon Lighting 2", Range( 0 , 0.49)) = 0
		_PosterizeLighting("Posterize Lighting", Range( 0 , 1)) = 0
		_PosterizedLightingSlices("Shadow Slices", Range( 1 , 10)) = 1
		_ToonSpecular("Toon Specular", Range( 0 , 1)) = 0
		_ToonSpecularSize("Toon Specular Size", Range( 0 , 0.05)) = 0
		_RimlightScale("Rimlight Scale", Range( 0 , 10)) = 1
		_RimOffset("Rimlight Offset", Range( -1 , 1)) = 0.02
		_RimlightToon("Rimlight Toon", Range( 0 , 0.49)) = 0
		_PosterizeRimLighting("Posterize Rimlight", Range( 0 , 1)) = 0
		_PosterizedRimLightingSlices("Rimlight Slices", Range( 1 , 10)) = 1
		_RimlightSpecularInfluence("Specular Tinting", Range( 0 , 1)) = 0
		_Noise("Noise", 2D) = "white" {}
		_SparkleTiling("Sparkle Tiling", Float) = 100
		_SparkleDepth("Sparkle Depth", Range( 0 , 0.25)) = 0
		_SparkleSpeed("Sparkle Speed", Range( 0 , 1)) = 0.01
		_SparkleSize("Sparkle Size", Range( 0.001 , 0.25)) = 0.01
		_EffectMask("Effect Mask", 2D) = "white" {}
		[HDR]_SparkleColor("Sparkle Color", Color) = (1,1,1,0)
		_SparkleThreshold("Sparkle Threshold", Range( 0 , 1)) = 0.1
		[HDR]_RimlightColor("Rimlight Color", Color) = (1,1,1,0)
		_OutlineWidth("OutlineWidth", Float) = 3
		_OutlineColor("Outline Color", Color) = (0,0,0,0)
		_LumaFlowTiling("Luma Flow Tiling", Float) = 1
		_GlowMaskRGB("Glow Mask", 2D) = "white" {}
		[ToggleUI]_MaskLumaFlowG("Mask Luma Flow (G)", Float) = 0
		[ToggleUI]_MaskSparklesB("Mask Sparkles (B)", Float) = 0
		[ToggleUI]_MaskEmission("Mask Emission (R)", Float) = 0
		[ToggleUI]_EnableRimlightGlow("   Enable Rimlight Glow", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_RimlightZone("   Rimlight Zone", Int) = 3
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_RimlightReactivity("   Rimlight Reactivity", Int) = 0
		[ToggleUI]_EnableOutlineGlow("   Enable Outline Glow", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_OutlineZone("   Outline Zone", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_OutlineReactivity("   Outline Reactivity", Int) = 0
		[ToggleUI]_EnableEmissionGlow("   Enable Emission Glow", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_EmissionZone("   Emission Zone", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_EmissionReactivity("   Emission Reactivity", Int) = 0
		[ToggleUI]_EnableGlowMaskR("   Enable Glow Mask (R)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_GlowMaskZoneR("   Glow Mask Zone (R)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityR("   Reacitvity (R)", Int) = 0
		[HDR]_GlowMaskTintR("   Glow Mask Tint (R)", Color) = (0,0,0,1)
		[ToggleUI]_EnableGlowMaskG("   Enable Glow Mask (G)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_GlowMaskZoneG("   Glow Mask Zone (G)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityG("   Reacitvity (G)", Int) = 0
		[HDR]_GlowMaskTintG("   Glow Mask Tint (G)", Color) = (0,0,0,1)
		[ToggleUI]_EnableGlowMaskB("   Enable Glow Mask (B)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Zone 01,3,Zone 02,4,Zone 03,5,Zone 04,6)]_GlowMaskZoneB("   Glow Mask Zone (B)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityB("   Reacitvity (B)", Int) = 0
		[HDR]_GlowMaskTintB("   Glow Mask Tint (B)", Color) = (0,0,0,1)
		_LowsPulseDirection("   Lows Pulse Direction", Float) = 180
		_HighsPulseDirection("   Highs Pulse Direction", Float) = 180
		_GradientDirection("   Gradient Direction", Float) = 0
		[ToggleUI]_DebugMode("   Debug Mode", Float) = 0
		_GradientDirectionMap("Directional Map", 2D) = "white" {}
		_LumaAuraColor("Luma Aura Color", Color) = (1,1,1,0)
		_AuraColorIndex("AuraColorIndex", Float) = 0
		_BlendOPdst("BlendOPdst", Float) = 10
		_BlendOPIndex("BlendOPIndex", Float) = 0
		_MaskClip("Mask Clip Value", Float) = 0.5
		_BlendOPsrc("BlendOPsrc", Float) = 5
		[ToggleUI]_EmissionPan("Enable Emission Panning", Float) = 0
		_EmissionPanSpeed("Emission Pan Speed", Vector) = (1,1,0,0)
		_BlendModeIndex("BlendModeIndex", Float) = 0
		[Enum(Main Settings,3,Lighting Settings,0,Luma Glow Settings,2,Effect Settings,4)]_SettingsMode("   Mode", Float) = 3
		[ToggleUI]_AdvToggle("Toggle Advanced Settings", Float) = 0
		[Enum(Off,0,Front,1,Back,2)]_Culling("Culling", Float) = 2
		[Toggle(_OUTLINES_ON)] _Outlines("Outlines", Float) = 0
		[Toggle(_RIMLIGHTING_ON)] _Rimlighting("Rimlighting", Float) = 0
		[Toggle(_SPARKLES_ON)] _Sparkles("Sparkles", Float) = 0
		[Toggle(_LUMAFLOW_ON)] _LumaFlow("Luma Flow", Float) = 0
		_LumaFlowDistortion("Luma Flow Distortion", Range( 0.05 , 1)) = 0.1
		_LumaFlowSpeed("Luma Flow Speed", Range( 0.001 , 1)) = 0.001
		[HDR]_LumaFlowColor("Luma Flow Color", Color) = (0,1,0.9602337,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_Culling]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local _LUMAFLOW_ON
		#pragma shader_feature_local _SPARKLES_ON
		#pragma shader_feature_local _OUTLINES_ON
		#pragma shader_feature_local _RIMLIGHTING_ON
		#if !defined(UNITY_STEREO_INSTANCING_ENABLED) && !defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#undef UNITY_DECLARE_DEPTH_TEXTURE
		#define UNITY_DECLARE_DEPTH_TEXTURE(tex) UNITY_DECLARE_TEX2D(tex)
		#undef SAMPLE_DEPTH_TEXTURE
		#define SAMPLE_DEPTH_TEXTURE(sampler, uv) (UNITY_SAMPLE_TEX2D(sampler, uv).r)
		#endif
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
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
			float4 screenPos;
			float eyeDepth;
			float vertexToFrag23_g1741;
			float vertexToFrag23_g1737;
			float vertexToFrag23_g1735;
			float vertexToFrag23_g1733;
			float3 worldNormal;
			half ASEVFace : VFACE;
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

		uniform float _AuraColorIndex;
		uniform int _OutlineZone;
		uniform int _OutlineReactivity;
		uniform float4 _LumaAuraColor;
		uniform float _EnableOutlineGlow;
		uniform float _BlendModeIndex;
		uniform float _BlendOPIndex;
		uniform sampler2D _AlphaMask;
		uniform float _Culling;
		uniform float _BlendOPsrc;
		uniform float _MaskClip;
		uniform float _SettingsMode;
		uniform float _AdvToggle;
		uniform float _BlendOPdst;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _MetallicMult;
		uniform float _Metallic;
		uniform sampler2D _MetallicGlossMap;
		float4 _MetallicGlossMap_TexelSize;
		uniform sampler2D _Stored;
		uniform float _GradientDirection;
		uniform sampler2D _GradientDirectionMap;
		uniform float4 _GradientDirectionMap_ST;
		float4 _GradientDirectionMap_TexelSize;
		uniform float _DebugMode;
		uniform float4 _OutlineColor;
		uniform float _LowsPulseDirection;
		uniform float _HighsPulseDirection;
		uniform int _EmissionZone;
		uniform float _EnableEmissionGlow;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionPan;
		uniform float2 _EmissionPanSpeed;
		uniform float4 _EmissionMap_ST;
		uniform sampler2D _EffectMask;
		uniform float4 _EffectMask_ST;
		uniform float _MaskEmission;
		float4 _EmissionMap_TexelSize;
		uniform float _EnableEmission;
		uniform int _EmissionReactivity;
		uniform int _GlowMaskZoneR;
		uniform float _EnableGlowMaskR;
		uniform float4 _GlowMaskTintR;
		uniform sampler2D _GlowMaskRGB;
		uniform float4 _GlowMaskRGB_ST;
		uniform int _ReacitvityR;
		uniform int _GlowMaskZoneG;
		uniform float _EnableGlowMaskG;
		uniform float4 _GlowMaskTintG;
		uniform int _ReacitvityG;
		uniform int _GlowMaskZoneB;
		uniform float _EnableGlowMaskB;
		uniform float4 _GlowMaskTintB;
		uniform int _ReacitvityB;
		uniform float _SparkleSize;
		uniform float _SparkleTiling;
		uniform float _SparkleDepth;
		uniform float _SparkleThreshold;
		uniform sampler2D _Noise;
		uniform float _SparkleSpeed;
		uniform float4 _SparkleColor;
		uniform float _MaskSparklesB;
		uniform float4 _LumaFlowColor;
		uniform float _MaskLumaFlowG;
		uniform float _LumaFlowTiling;
		uniform float4 _Noise_ST;
		uniform float _LumaFlowSpeed;
		uniform float _LumaFlowDistortion;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _OutlineWidth;
		uniform float _ToonLighting1;
		uniform float _ShadingOffset;
		uniform float3 _FakeLightDir;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _BumpScale;
		uniform float _SoftenLighting;
		uniform float _ToonLighting2;
		uniform float _Glossiness;
		uniform float _SmoothnessMult;
		uniform float _SecretLightingToggle;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		float4 _OcclusionMap_TexelSize;
		uniform float _PosterizedLightingSlices;
		uniform float _PosterizeLighting;
		uniform float _ToonSpecular;
		uniform float _ToonSpecularSize;
		uniform sampler2D _Specular;
		uniform float4 _SpecularTint;
		uniform float _UseSpecularTexture;
		uniform float _RimlightToon;
		uniform float _RimlightScale;
		uniform float _RimOffset;
		uniform float _PosterizedRimLightingSlices;
		uniform float _PosterizeRimLighting;
		uniform int _RimlightZone;
		uniform float _EnableRimlightGlow;
		uniform float4 _RimlightColor;
		uniform int _RimlightReactivity;
		uniform float _RimlightSpecularInfluence;


		half3 ToonAmbience( half3 uvw, half GSF )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				uvw = float3(0,1,0);
				}
			half3 ambientFwd = saturate(ShadeSH9(float4(uvw, 1)));
			half3 ambientBwd = saturate(ShadeSH9(float4(-uvw, 1)))*0.7;
			return lerp(ambientBwd,ambientFwd,GSF);
		}


		float2 voronoihash792( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi792( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash792( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return F1;
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

		float4 CalculateFrustrumCorrection25_g1741(  )
		{
						float x1 = -UNITY_MATRIX_P._31/(UNITY_MATRIX_P._11*UNITY_MATRIX_P._34);
						float x2 = -UNITY_MATRIX_P._32/(UNITY_MATRIX_P._22*UNITY_MATRIX_P._34);
						return float4(x1, x2, 0, UNITY_MATRIX_P._33/UNITY_MATRIX_P._34 + x1*UNITY_MATRIX_P._13 + x2*UNITY_MATRIX_P._23);
		}


		float CorrectedLinearEyeDepth20_g1741( float inputDepth, float Correction )
		{
				return 1.0 / (inputDepth/UNITY_MATRIX_P._34 + Correction);
		}


		float4 CalculateFrustrumCorrection25_g1737(  )
		{
						float x1 = -UNITY_MATRIX_P._31/(UNITY_MATRIX_P._11*UNITY_MATRIX_P._34);
						float x2 = -UNITY_MATRIX_P._32/(UNITY_MATRIX_P._22*UNITY_MATRIX_P._34);
						return float4(x1, x2, 0, UNITY_MATRIX_P._33/UNITY_MATRIX_P._34 + x1*UNITY_MATRIX_P._13 + x2*UNITY_MATRIX_P._23);
		}


		float CorrectedLinearEyeDepth20_g1737( float inputDepth, float Correction )
		{
				return 1.0 / (inputDepth/UNITY_MATRIX_P._34 + Correction);
		}


		float4 CalculateFrustrumCorrection25_g1735(  )
		{
						float x1 = -UNITY_MATRIX_P._31/(UNITY_MATRIX_P._11*UNITY_MATRIX_P._34);
						float x2 = -UNITY_MATRIX_P._32/(UNITY_MATRIX_P._22*UNITY_MATRIX_P._34);
						return float4(x1, x2, 0, UNITY_MATRIX_P._33/UNITY_MATRIX_P._34 + x1*UNITY_MATRIX_P._13 + x2*UNITY_MATRIX_P._23);
		}


		float CorrectedLinearEyeDepth20_g1735( float inputDepth, float Correction )
		{
				return 1.0 / (inputDepth/UNITY_MATRIX_P._34 + Correction);
		}


		float4 CalculateFrustrumCorrection25_g1733(  )
		{
						float x1 = -UNITY_MATRIX_P._31/(UNITY_MATRIX_P._11*UNITY_MATRIX_P._34);
						float x2 = -UNITY_MATRIX_P._32/(UNITY_MATRIX_P._22*UNITY_MATRIX_P._34);
						return float4(x1, x2, 0, UNITY_MATRIX_P._33/UNITY_MATRIX_P._34 + x1*UNITY_MATRIX_P._13 + x2*UNITY_MATRIX_P._23);
		}


		float CorrectedLinearEyeDepth20_g1733( float inputDepth, float Correction )
		{
				return 1.0 / (inputDepth/UNITY_MATRIX_P._34 + Correction);
		}


		int LightExists6_g1623(  )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				return 0;
				}
			return 1;
		}


		float3 CustomReflectionProbeSample95_g1623( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
			float4 localCalculateFrustrumCorrection25_g1741 = CalculateFrustrumCorrection25_g1741();
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 unityObjectToClipPos22_g1741 = UnityObjectToClipPos( ase_vertex3Pos );
			float dotResult24_g1741 = dot( localCalculateFrustrumCorrection25_g1741 , unityObjectToClipPos22_g1741 );
			o.vertexToFrag23_g1741 = dotResult24_g1741;
			float4 localCalculateFrustrumCorrection25_g1737 = CalculateFrustrumCorrection25_g1737();
			float4 unityObjectToClipPos22_g1737 = UnityObjectToClipPos( ase_vertex3Pos );
			float dotResult24_g1737 = dot( localCalculateFrustrumCorrection25_g1737 , unityObjectToClipPos22_g1737 );
			o.vertexToFrag23_g1737 = dotResult24_g1737;
			float4 localCalculateFrustrumCorrection25_g1735 = CalculateFrustrumCorrection25_g1735();
			float4 unityObjectToClipPos22_g1735 = UnityObjectToClipPos( ase_vertex3Pos );
			float dotResult24_g1735 = dot( localCalculateFrustrumCorrection25_g1735 , unityObjectToClipPos22_g1735 );
			o.vertexToFrag23_g1735 = dotResult24_g1735;
			float4 localCalculateFrustrumCorrection25_g1733 = CalculateFrustrumCorrection25_g1733();
			float4 unityObjectToClipPos22_g1733 = UnityObjectToClipPos( ase_vertex3Pos );
			float dotResult24_g1733 = dot( localCalculateFrustrumCorrection25_g1733 , unityObjectToClipPos22_g1733 );
			o.vertexToFrag23_g1733 = dotResult24_g1733;
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
			float cos695_g1617 = cos( radians( _GradientDirection ) );
			float sin695_g1617 = sin( radians( _GradientDirection ) );
			float2 rotator695_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos695_g1617 , -sin695_g1617 , sin695_g1617 , cos695_g1617 )) + float2( 0.5,0.5 );
			float2 break995_g1617 = rotator695_g1617;
			float2 uv_GradientDirectionMap = i.uv_texcoord * _GradientDirectionMap_ST.xy + _GradientDirectionMap_ST.zw;
			float4 tex2DNode988_g1617 = tex2D( _GradientDirectionMap, uv_GradientDirectionMap );
			float GradientDirectionMap992_g1617 = tex2DNode988_g1617.r;
			float temp_output_1000_0_g1617 = step( 32.0 , max( _GradientDirectionMap_TexelSize.z , _GradientDirectionMap_TexelSize.w ) );
			float DirectionalMapEnable996_g1617 = temp_output_1000_0_g1617;
			float lerpResult998_g1617 = lerp( break995_g1617.x , GradientDirectionMap992_g1617 , DirectionalMapEnable996_g1617);
			float2 appendResult994_g1617 = (float2(lerpResult998_g1617 , break995_g1617.y));
			float2 GradientUVs698_g1617 = appendResult994_g1617;
			float4 _GradientZone01 = float4(9.4,0,0.57,0.49);
			float2 appendResult34_g1617 = (float2(( 1.0 / _GradientZone01.x ) , 0.0));
			float2 appendResult42_g1617 = (float2(_GradientZone01.z , _GradientZone01.w));
			float2 clampResult707_g1617 = clamp( (GradientUVs698_g1617*appendResult34_g1617 + appendResult42_g1617) , float2( 0.571,0 ) , float2( 0.676,1 ) );
			float2 GradientZone0175_g1617 = clampResult707_g1617;
			float4 _GradientZone02 = float4(9.4,0,0.6805,0.49);
			float2 appendResult38_g1617 = (float2(( 1.0 / _GradientZone02.x ) , 0.0));
			float2 appendResult41_g1617 = (float2(_GradientZone02.z , _GradientZone02.w));
			float2 clampResult710_g1617 = clamp( (GradientUVs698_g1617*appendResult38_g1617 + appendResult41_g1617) , float2( 0.681,0 ) , float2( 0.786,1 ) );
			float2 GradientZone0282_g1617 = clampResult710_g1617;
			int OutlineZoneIndex768_g1617 = _OutlineZone;
			float2 lerpResult756_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( OutlineZoneIndex768_g1617 ));
			float4 _GradientZone03 = float4(9.4,0,0.791,0.49);
			float2 appendResult57_g1617 = (float2(( 1.0 / _GradientZone03.x ) , 0.0));
			float2 appendResult52_g1617 = (float2(_GradientZone03.z , _GradientZone03.w));
			float2 clampResult711_g1617 = clamp( (GradientUVs698_g1617*appendResult57_g1617 + appendResult52_g1617) , float2( 0.792,0 ) , float2( 0.896,1 ) );
			float2 GradientZone03122_g1617 = clampResult711_g1617;
			float2 lerpResult754_g1617 = lerp( lerpResult756_g1617 , GradientZone03122_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 1 ) ));
			float2 OriginalOffset44_g1617 = float2( 0.1,0.471 );
			float2 Zone01138_g1617 = ( float2( 0.955,0.992 ) - OriginalOffset44_g1617 );
			float2 lerpResult747_g1617 = lerp( lerpResult754_g1617 , Zone01138_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 2 ) ));
			float2 Zone02188_g1617 = ( float2( 0.964,0.992 ) - OriginalOffset44_g1617 );
			float2 lerpResult735_g1617 = lerp( lerpResult747_g1617 , Zone02188_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 3 ) ));
			float2 Zone03224_g1617 = ( float2( 0.955,0.978 ) - OriginalOffset44_g1617 );
			float2 lerpResult752_g1617 = lerp( lerpResult735_g1617 , Zone03224_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 4 ) ));
			float2 Zone04291_g1617 = ( float2( 0.964,0.978 ) - OriginalOffset44_g1617 );
			float2 lerpResult757_g1617 = lerp( lerpResult752_g1617 , Zone04291_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 5 ) ));
			float2 OutlineZoneUV762_g1617 = lerpResult757_g1617;
			float temp_output_785_0_g1617 = ( 1.0 - _EnableOutlineGlow );
			float2 break1020_g1617 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult1019_g1617 = (float2(break1020_g1617.x , break1020_g1617.y));
			float4 tex2DNode1007_g1617 = tex2Dlod( _Stored, float4( ( ( ( ( ( float2( -995,-525 ) * appendResult1019_g1617 ) + i.uv_texcoord ) * appendResult1019_g1617 ) - float2( 0.1,-0.5 ) ) - float2( -0.73,-0.01 ) ), 0, 0.0) );
			float StoredTextureTog669_g1617 = ( 1.0 - ( min( tex2DNode1007_g1617.r , 1.0 ) * step( max( tex2DNode1007_g1617.g , tex2DNode1007_g1617.b ) , 0.0 ) ) );
			float temp_output_712_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y ) ) ) ) );
			float3 appendResult65_g1617 = (float3(temp_output_712_0_g1617 , temp_output_712_0_g1617 , temp_output_712_0_g1617));
			float3 DebugGradient1111_g1617 = appendResult65_g1617;
			float temp_output_713_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y + 0.3 ) ) ) ) );
			float3 appendResult72_g1617 = (float3(temp_output_713_0_g1617 , temp_output_713_0_g1617 , 0.0));
			float3 DebugGradient2110_g1617 = appendResult72_g1617;
			float3 lerpResult816_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( OutlineZoneIndex768_g1617 ));
			float temp_output_714_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y + 0.6 ) ) ) ) );
			float3 appendResult96_g1617 = (float3(0.0 , temp_output_714_0_g1617 , temp_output_714_0_g1617));
			float3 DebugGradient3173_g1617 = appendResult96_g1617;
			float3 lerpResult811_g1617 = lerp( lerpResult816_g1617 , DebugGradient3173_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 1 ) ));
			float3 appendResult139_g1617 = (float3(0.0 , 0.0 , saturate( ( 1.0 - abs( sin( _Time.y ) ) ) )));
			float3 DebugZone1195_g1617 = appendResult139_g1617;
			float3 lerpResult817_g1617 = lerp( lerpResult811_g1617 , DebugZone1195_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 2 ) ));
			float temp_output_716_0_g1617 = saturate( ( 1.0 - abs( sin( ( _Time.y + 0.2 ) ) ) ) );
			float3 appendResult192_g1617 = (float3(temp_output_716_0_g1617 , temp_output_716_0_g1617 , temp_output_716_0_g1617));
			float3 DebugZone2250_g1617 = appendResult192_g1617;
			float3 lerpResult800_g1617 = lerp( lerpResult817_g1617 , DebugZone2250_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 3 ) ));
			float3 appendResult259_g1617 = (float3(saturate( ( 1.0 - abs( sin( ( _Time.y + 0.4 ) ) ) ) ) , 0.0 , 0.0));
			float3 DebugZone3309_g1617 = appendResult259_g1617;
			float3 lerpResult813_g1617 = lerp( lerpResult800_g1617 , DebugZone3309_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 4 ) ));
			float3 appendResult306_g1617 = (float3(0.0 , saturate( ( 1.0 - abs( sin( ( _Time.y + 0.6 ) ) ) ) ) , 0.0));
			float3 DebugZone4332_g1617 = appendResult306_g1617;
			float3 lerpResult821_g1617 = lerp( lerpResult813_g1617 , DebugZone4332_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 5 ) ));
			float EnableOutlineGlow780_g1617 = temp_output_785_0_g1617;
			float3 DebugOutlineGlow812_g1617 = saturate( ( lerpResult821_g1617 + EnableOutlineGlow780_g1617 ) );
			float DebugSwitch628_g1617 = _DebugMode;
			float4 lerpResult772_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( OutlineZoneUV762_g1617, 0, 0.0) ) + temp_output_785_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugOutlineGlow812_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 temp_output_728_0_g1617 = _OutlineColor;
			float4 lerpResult723_g1617 = lerp( lerpResult772_g1617 , temp_output_728_0_g1617 , saturate( ( temp_output_785_0_g1617 + ( ( 1.0 - DebugSwitch628_g1617 ) * StoredTextureTog669_g1617 ) ) ));
			float4 OutlineGlowColor730_g1617 = lerpResult723_g1617;
			float2 ReactiveZone365_g1617 = ( float2( 0.673,0.985 ) - OriginalOffset44_g1617 );
			float mulTime293_g1617 = _Time.y * 13.0;
			float3 appendResult390_g1617 = (float3(saturate( sin( mulTime293_g1617 ) ) , saturate( sin( ( mulTime293_g1617 + 0.5 ) ) ) , 0.0));
			float4 lerpResult637_g1617 = lerp( saturate( ( StoredTextureTog669_g1617 + tex2D( _Stored, ReactiveZone365_g1617 ) ) ) , float4( appendResult390_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 break417_g1617 = lerpResult637_g1617;
			float LowBlink431_g1617 = break417_g1617.r;
			int ReactivityIndexOutline778_g1617 = _OutlineReactivity;
			float4 lerpResult830_g1617 = lerp( OutlineGlowColor730_g1617 , ( OutlineGlowColor730_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexOutline778_g1617 ));
			float cos437_g1617 = cos( radians( _LowsPulseDirection ) );
			float sin437_g1617 = sin( radians( _LowsPulseDirection ) );
			float2 rotator437_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos437_g1617 , -sin437_g1617 , sin437_g1617 , cos437_g1617 )) + float2( 0.5,0.5 );
			float lerpResult991_g1617 = lerp( rotator437_g1617.y , tex2DNode988_g1617.r , temp_output_1000_0_g1617);
			float LowPulse493_g1617 = saturate( ( lerpResult991_g1617 - ( 1.0 - LowBlink431_g1617 ) ) );
			float4 lerpResult849_g1617 = lerp( lerpResult830_g1617 , ( OutlineGlowColor730_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 1 ) ));
			float HighBlink464_g1617 = break417_g1617.g;
			float4 lerpResult832_g1617 = lerp( lerpResult849_g1617 , ( OutlineGlowColor730_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 2 ) ));
			float cos456_g1617 = cos( radians( _HighsPulseDirection ) );
			float sin456_g1617 = sin( radians( _HighsPulseDirection ) );
			float2 rotator456_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos456_g1617 , -sin456_g1617 , sin456_g1617 , cos456_g1617 )) + float2( 0.5,0.5 );
			float lerpResult989_g1617 = lerp( rotator456_g1617.y , tex2DNode988_g1617.r , temp_output_1000_0_g1617);
			float HighPulse556_g1617 = saturate( ( lerpResult989_g1617 - ( 1.0 - HighBlink464_g1617 ) ) );
			float4 lerpResult852_g1617 = lerp( lerpResult832_g1617 , ( OutlineGlowColor730_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 3 ) ));
			float4 FinalGlowOutline826_g1617 = lerpResult852_g1617;
			float4 temp_output_1048_719 = FinalGlowOutline826_g1617;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 MainTexRGBA715 = ( _Color * tex2D( _MainTex, uv_MainTex ) );
			float4 tex2DNode5 = tex2D( _MetallicGlossMap, uv_MainTex );
			float temp_output_263_0 = step( 32.0 , max( _MetallicGlossMap_TexelSize.z , _MetallicGlossMap_TexelSize.w ) );
			float lerpResult40 = lerp( _Metallic , tex2DNode5.r , temp_output_263_0);
			float Metallic23 = saturate( ( _MetallicMult * lerpResult40 ) );
			half3 specColor698 = (0).xxx;
			half oneMinusReflectivity698 = 0;
			half3 diffuseAndSpecularFromMetallic698 = DiffuseAndSpecularFromMetallic(MainTexRGBA715.rgb,Metallic23,specColor698,oneMinusReflectivity698);
			float3 MetAlbedo700 = diffuseAndSpecularFromMetallic698;
			float temp_output_50_0_g1624 = ( 1.0 - _ToonLighting1 );
			float temp_output_60_0_g1624 = ( ( 1.0 - temp_output_50_0_g1624 ) + _ShadingOffset );
			float temp_output_59_0_g1624 = ( _ShadingOffset + temp_output_50_0_g1624 );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			int localLightExists6_g1623 = LightExists6_g1623();
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 break2_g1623 = ase_lightColor.rgb;
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch103_g1623 = ( 1.0 - step( max( max( break2_g1623.x , break2_g1623.y ) , break2_g1623.z ) , 0.001 ) );
			#else
				float staticSwitch103_g1623 = 1.0;
			#endif
			float temp_output_10_0_g1623 = ( localLightExists6_g1623 * staticSwitch103_g1623 );
			float3 lerpResult12_g1623 = lerp( _FakeLightDir , ase_worldlightDir , temp_output_10_0_g1623);
			float3 LightDir14_g1623 = lerpResult12_g1623;
			float3 normalizeResult10_g1624 = normalize( LightDir14_g1623 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode9 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale );
			float3 appendResult502 = (float3(tex2DNode9.xy , ( (tex2DNode9).z * i.ASEVFace )));
			float3 NormalMapXYZ21 = appendResult502;
			float3 temp_output_64_0_g1623 = NormalMapXYZ21;
			float3 newWorldNormal4_g1624 = (WorldNormalVector( i , temp_output_64_0_g1623 ));
			float3 normalizeResult11_g1624 = normalize( newWorldNormal4_g1624 );
			float dotResult13_g1624 = dot( normalizeResult10_g1624 , normalizeResult11_g1624 );
			float smoothstepResult53_g1624 = smoothstep( temp_output_60_0_g1624 , temp_output_59_0_g1624 , dotResult13_g1624);
			float SoftenLight69_g1623 = _SoftenLighting;
			float temp_output_34_0_g1624 = ( 1.0 - SoftenLight69_g1623 );
			float temp_output_37_0_g1624 = SoftenLight69_g1623;
			float temp_output_32_0_g1624 = max( (smoothstepResult53_g1624*temp_output_34_0_g1624 + temp_output_37_0_g1624) , 0.0 );
			float temp_output_56_0_g1624 = ( 1.0 - _ToonLighting2 );
			float temp_output_57_0_g1624 = ( 1.0 - temp_output_56_0_g1624 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult15_g1624 = normalize( ase_worldViewDir );
			float dotResult12_g1624 = dot( normalizeResult15_g1624 , normalizeResult11_g1624 );
			float smoothstepResult49_g1624 = smoothstep( temp_output_57_0_g1624 , temp_output_56_0_g1624 , dotResult12_g1624);
			float lerpResult37 = lerp( _Glossiness , tex2DNode5.a , temp_output_263_0);
			float Smoothness24 = saturate( ( lerpResult37 * _SmoothnessMult ) );
			float temp_output_22_0_g1624 = ( 1.0 - Smoothness24 );
			float temp_output_23_0_g1624 = ( temp_output_22_0_g1624 * temp_output_22_0_g1624 * 0.7978846 );
			float temp_output_24_0_g1624 = ( 1.0 - temp_output_23_0_g1624 );
			float temp_output_25_0_g1624 = ( ( max( (smoothstepResult49_g1624*temp_output_34_0_g1624 + temp_output_37_0_g1624) , 0.0 ) * temp_output_23_0_g1624 ) + temp_output_24_0_g1624 );
			float lerpResult62_g1624 = lerp( temp_output_32_0_g1624 , ( temp_output_32_0_g1624 * temp_output_25_0_g1624 * temp_output_25_0_g1624 ) , _SecretLightingToggle);
			float temp_output_85_0_g1623 = ase_lightAtten;
			float lerpResult15_g1623 = lerp( 1.0 , temp_output_85_0_g1623 , temp_output_10_0_g1623);
			float Attenuation22_g1623 = lerpResult15_g1623;
			float temp_output_29_0_g1623 = (Attenuation22_g1623*( 1.0 - SoftenLight69_g1623 ) + SoftenLight69_g1623);
			float lerpResult479 = lerp( 1.0 , saturate( ( tex2D( _OcclusionMap, uv_MainTex ).g + ( 1.0 - _OcclusionStrength ) ) ) , step( 32.0 , max( _OcclusionMap_TexelSize.z , _OcclusionMap_TexelSize.w ) ));
			float OcclusionG25 = lerpResult479;
			float temp_output_67_0_g1623 = OcclusionG25;
			float temp_output_38_0_g1623 = min( saturate( lerpResult62_g1624 ) , saturate( ( temp_output_29_0_g1623 * temp_output_67_0_g1623 ) ) );
			float lerpResult50_g1623 = lerp( temp_output_38_0_g1623 , ( round( ( temp_output_38_0_g1623 * ceil( _PosterizedLightingSlices ) ) ) / floor( _PosterizedLightingSlices ) ) , _PosterizeLighting);
			UnityGI gi120_g1623 = gi;
			float3 diffNorm120_g1623 = WorldNormalVector( i , temp_output_64_0_g1623 );
			gi120_g1623 = UnityGI_Base( data, 1, diffNorm120_g1623 );
			float3 indirectDiffuse120_g1623 = gi120_g1623.indirect.diffuse + diffNorm120_g1623 * 0.0001;
			float3 uvw95_g1623 = (WorldNormalVector( i , temp_output_64_0_g1623 ));
			float3 localCustomReflectionProbeSample95_g1623 = CustomReflectionProbeSample95_g1623( uvw95_g1623 );
			float3 CustomProbe96_g1623 = localCustomReflectionProbeSample95_g1623;
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch122_g1623 = ( 0.5 * temp_output_10_0_g1623 );
			#else
				float staticSwitch122_g1623 = 0.0;
			#endif
			float3 lerpResult100_g1623 = lerp( indirectDiffuse120_g1623 , CustomProbe96_g1623 , staticSwitch122_g1623);
			float3 ToonAmbience80_g1623 = lerpResult100_g1623;
			float4 lerpResult45_g1623 = lerp( float4( ToonAmbience80_g1623 , 0.0 ) , ase_lightColor , temp_output_10_0_g1623);
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch111_g1623 = 1.0;
			#else
				float staticSwitch111_g1623 = temp_output_85_0_g1623;
			#endif
			float4 LightColor47_g1623 = ( lerpResult45_g1623 * staticSwitch111_g1623 );
			float4 DiffuseLighting55_g1623 = ( float4( MetAlbedo700 , 0.0 ) * ( ( lerpResult50_g1623 * LightColor47_g1623 ) + float4( ToonAmbience80_g1623 , 0.0 ) ) );
			float4 DiffuseLighting69 = DiffuseLighting55_g1623;
			float4 LightColor651 = LightColor47_g1623;
			float4 temp_output_74_0_g1745 = LightColor651;
			float smoothstepResult54_g1624 = smoothstep( temp_output_60_0_g1624 , temp_output_59_0_g1624 , max( dotResult13_g1624 , 0.0 ));
			float smoothstepResult55_g1624 = smoothstep( temp_output_57_0_g1624 , temp_output_56_0_g1624 , max( dotResult12_g1624 , 0.0 ));
			float temp_output_45_0_g1624 = ( ( smoothstepResult55_g1624 * temp_output_23_0_g1624 ) + temp_output_24_0_g1624 );
			float lerpResult61_g1624 = lerp( smoothstepResult54_g1624 , ( smoothstepResult54_g1624 * temp_output_45_0_g1624 * temp_output_45_0_g1624 ) , _SecretLightingToggle);
			float SaturatedGSF35_g1623 = min( saturate( lerpResult61_g1624 ) , ( Attenuation22_g1623 * temp_output_67_0_g1623 ) );
			float SaturatedGSF71 = SaturatedGSF35_g1623;
			float temp_output_75_0_g1745 = SaturatedGSF71;
			float smoothness66_g1745 = Smoothness24;
			float temp_output_27_0_g1745 = ( 1.0 - smoothness66_g1745 );
			float temp_output_2_0_g1748 = temp_output_27_0_g1745;
			float temp_output_10_0_g1748 = ( temp_output_2_0_g1748 * temp_output_2_0_g1748 );
			float temp_output_26_0_g1748 = _ToonSpecular;
			float temp_output_24_0_g1748 = (0.0 + (temp_output_26_0_g1748 - 0.0) * (0.83 - 0.0) / (1.0 - 0.0));
			float lerpResult23_g1748 = lerp( 1.0 , 0.8 , max( ( temp_output_24_0_g1748 * saturate( ( temp_output_2_0_g1748 + 0.1 ) ) ) , min( temp_output_26_0_g1748 , 0.11 ) ));
			float3 LightDir644 = LightDir14_g1623;
			float3 temp_output_82_0_g1745 = LightDir644;
			float3 normalizeResult52_g1748 = normalize( ( ase_worldViewDir + temp_output_82_0_g1745 ) );
			float3 NormalXYZ64_g1745 = NormalMapXYZ21;
			float3 newWorldNormal16_g1748 = (WorldNormalVector( i , NormalXYZ64_g1745 ));
			float3 normalizeResult4_g1748 = normalize( newWorldNormal16_g1748 );
			float dotResult7_g1748 = dot( normalizeResult52_g1748 , normalizeResult4_g1748 );
			float smoothstepResult25_g1748 = smoothstep( temp_output_24_0_g1748 , lerpResult23_g1748 , ( dotResult7_g1748 - _ToonSpecularSize ));
			float temp_output_12_0_g1748 = ( ( smoothstepResult25_g1748 * smoothstepResult25_g1748 * ( temp_output_10_0_g1748 - 1.0 ) ) + 1.0 );
			float temp_output_88_0_g1745 = ( temp_output_10_0_g1748 / ( temp_output_12_0_g1748 * temp_output_12_0_g1748 * UNITY_PI ) );
			float smoothstepResult113_g1745 = smoothstep( 0.0 , 0.1 , smoothness66_g1745);
			float temp_output_115_0_g1745 = max( smoothstepResult113_g1745 , 0.01 );
			float4 SpecularRGBA317 = ( tex2D( _Specular, uv_MainTex ) * _SpecularTint );
			float4 lerpResult699 = lerp( float4( specColor698 , 0.0 ) , ( float4( specColor698 , 0.0 ) * SpecularRGBA317 ) , _UseSpecularTexture);
			float4 SpecularColor704 = lerpResult699;
			float4 SpecularColor31_g1745 = SpecularColor704;
			float fresnelNdotV25_g1745 = dot( (WorldNormalVector( i , NormalXYZ64_g1745 )), ase_worldViewDir );
			float fresnelNode25_g1745 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV25_g1745, 5.0 ) );
			float Metallic70_g1745 = Metallic23;
			float4 lerpResult43_g1745 = lerp( SpecularColor31_g1745 , float4( 1,1,1,0 ) , ( saturate( fresnelNode25_g1745 ) * Metallic70_g1745 ));
			float4 temp_cast_132 = (0.0).xxxx;
			#ifdef _SPECULARHIGHLIGHTS_OFF
				float4 staticSwitch86_g1745 = temp_cast_132;
			#else
				float4 staticSwitch86_g1745 = ( temp_output_74_0_g1745 * ( temp_output_75_0_g1745 * max( temp_output_88_0_g1745 , 0.0 ) * temp_output_115_0_g1745 ) * lerpResult43_g1745 );
			#endif
			float3 indirectNormal82 = WorldNormalVector( i , NormalMapXYZ21 );
			Unity_GlossyEnvironmentData g82 = UnityGlossyEnvironmentSetup( Smoothness24, data.worldViewDir, indirectNormal82, float3(0,0,0));
			float3 indirectSpecular82 = UnityGI_IndirectSpecular( data, OcclusionG25, indirectNormal82, g82 );
			float3 temp_cast_133 = (0.0).xxx;
			#ifdef _GLOSSYREFLECTIONS_OFF
				float3 staticSwitch84_g1745 = temp_cast_133;
			#else
				float3 staticSwitch84_g1745 = indirectSpecular82;
			#endif
			float fresnelNdotV40_g1745 = dot( (WorldNormalVector( i , NormalXYZ64_g1745 )), ase_worldViewDir );
			float fresnelNode40_g1745 = ( ((0.05 + (smoothness66_g1745 - 0.0) * (1.0 - 0.05) / (1.0 - 0.0)) + (Metallic70_g1745 - 0.0) * ((0.1 + (smoothness66_g1745 - 0.0) * (1.0 - 0.1) / (1.0 - 0.0)) - (0.05 + (smoothness66_g1745 - 0.0) * (1.0 - 0.05) / (1.0 - 0.0))) / (1.0 - 0.0)) + ( smoothness66_g1745 * 0.075 ) * pow( 1.0 - fresnelNdotV40_g1745, 5.0 ) );
			float4 temp_cast_135 = (5.0).xxxx;
			float4 temp_output_51_0_g1745 = min( ( staticSwitch86_g1745 + ( float4( staticSwitch84_g1745 , 0.0 ) * saturate( fresnelNode40_g1745 ) * saturate( SpecularColor31_g1745 ) ) ) , temp_cast_135 );
			float4 SpecularLighting91 = temp_output_51_0_g1745;
			float4 temp_cast_136 = (0.0).xxxx;
			float Attenuation656 = Attenuation22_g1623;
			float temp_output_50_0_g1744 = ( 1.0 - _RimlightToon );
			float temp_output_52_0_g1744 = ( 1.0 - temp_output_50_0_g1744 );
			float3 normalizeResult15_g1744 = normalize( ase_worldViewDir );
			float3 newWorldNormal4_g1744 = (WorldNormalVector( i , NormalMapXYZ21 ));
			float3 normalizeResult11_g1744 = normalize( newWorldNormal4_g1744 );
			float dotResult12_g1744 = dot( normalizeResult15_g1744 , normalizeResult11_g1744 );
			float temp_output_34_0_g1744 = _RimlightScale;
			float temp_output_37_0_g1744 = _RimOffset;
			float temp_output_35_0_g1744 = (dotResult12_g1744*temp_output_34_0_g1744 + temp_output_37_0_g1744);
			float smoothstepResult49_g1744 = smoothstep( temp_output_52_0_g1744 , temp_output_50_0_g1744 , temp_output_35_0_g1744);
			float temp_output_10_0_g1743 = saturate( ( 1.0 - smoothstepResult49_g1744 ) );
			float lerpResult22_g1743 = lerp( temp_output_10_0_g1743 , ( round( ( temp_output_10_0_g1743 * ceil( _PosterizedRimLightingSlices ) ) ) / floor( _PosterizedRimLightingSlices ) ) , _PosterizeRimLighting);
			int RimlightZoneIndex874_g1617 = _RimlightZone;
			float2 lerpResult899_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( RimlightZoneIndex874_g1617 ));
			float2 lerpResult904_g1617 = lerp( lerpResult899_g1617 , GradientZone03122_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 1 ) ));
			float2 lerpResult891_g1617 = lerp( lerpResult904_g1617 , Zone01138_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 2 ) ));
			float2 lerpResult881_g1617 = lerp( lerpResult891_g1617 , Zone02188_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 3 ) ));
			float2 lerpResult888_g1617 = lerp( lerpResult881_g1617 , Zone03224_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 4 ) ));
			float2 lerpResult900_g1617 = lerp( lerpResult888_g1617 , Zone04291_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 5 ) ));
			float2 RimlightZoneUV909_g1617 = lerpResult900_g1617;
			float temp_output_865_0_g1617 = ( 1.0 - _EnableRimlightGlow );
			float3 lerpResult933_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( RimlightZoneIndex874_g1617 ));
			float3 lerpResult929_g1617 = lerp( lerpResult933_g1617 , DebugGradient3173_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 1 ) ));
			float3 lerpResult934_g1617 = lerp( lerpResult929_g1617 , DebugZone1195_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 2 ) ));
			float3 lerpResult926_g1617 = lerp( lerpResult934_g1617 , DebugZone2250_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 3 ) ));
			float3 lerpResult930_g1617 = lerp( lerpResult926_g1617 , DebugZone3309_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 4 ) ));
			float3 lerpResult918_g1617 = lerp( lerpResult930_g1617 , DebugZone4332_g1617 , (float)saturate( ( RimlightZoneIndex874_g1617 - 5 ) ));
			float EnableRimlightGlow872_g1617 = temp_output_865_0_g1617;
			float3 DebugRimlightGlow944_g1617 = saturate( ( lerpResult918_g1617 + EnableRimlightGlow872_g1617 ) );
			float4 lerpResult856_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( RimlightZoneUV909_g1617, 0, 0.0) ) + temp_output_865_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugRimlightGlow944_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 temp_output_859_0_g1617 = _RimlightColor;
			float4 lerpResult877_g1617 = lerp( ( lerpResult856_g1617 * temp_output_859_0_g1617 ) , temp_output_859_0_g1617 , saturate( ( temp_output_865_0_g1617 + ( 1.0 - StoredTextureTog669_g1617 ) ) ));
			float4 RimlightGlowColor878_g1617 = lerpResult877_g1617;
			int ReactivityIndexRimlight875_g1617 = _RimlightReactivity;
			float4 lerpResult973_g1617 = lerp( RimlightGlowColor878_g1617 , ( RimlightGlowColor878_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexRimlight875_g1617 ));
			float4 lerpResult957_g1617 = lerp( lerpResult973_g1617 , ( RimlightGlowColor878_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexRimlight875_g1617 - 1 ) ));
			float4 lerpResult975_g1617 = lerp( lerpResult957_g1617 , ( RimlightGlowColor878_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexRimlight875_g1617 - 2 ) ));
			float4 lerpResult958_g1617 = lerp( lerpResult975_g1617 , ( RimlightGlowColor878_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexRimlight875_g1617 - 3 ) ));
			float4 FinalGlowRimlight961_g1617 = lerpResult958_g1617;
			float4 RimlightColor764 = FinalGlowRimlight961_g1617;
			float4 temp_cast_160 = (1.0).xxxx;
			float4 lerpResult24_g1743 = lerp( temp_cast_160 , SpecularColor704 , _RimlightSpecularInfluence);
			float dotResult857 = dot( LightDir644 , -ase_worldViewDir );
			float4 Rimlight27_g1743 = ( float4( ( LightColor651.rgb * Attenuation656 ) , 0.0 ) * lerpResult22_g1743 * RimlightColor764 * lerpResult24_g1743 * max( SaturatedGSF71 , saturate( dotResult857 ) ) );
			float4 Rimlight467 = Rimlight27_g1743;
			#ifdef _RIMLIGHTING_ON
				float4 staticSwitch785 = Rimlight467;
			#else
				float4 staticSwitch785 = temp_cast_136;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult5_g1732 = (float2(_ScreenParams.x , _ScreenParams.y));
			float2 temp_output_10_0_g1732 = ( 1.0 / appendResult5_g1732 );
			float temp_output_3_0_g1732 = max( ( _OutlineWidth * saturate( ( 1.0 - ( ( i.eyeDepth + 2.0 ) * 0.1 ) ) ) ) , 1.0 );
			float2 appendResult6_g1732 = (float2(temp_output_3_0_g1732 , 0.0));
			float4 temp_output_4_0_g1741 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * appendResult6_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1741 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1741.xy );
			float inputDepth20_g1741 = clampDepth6_g1741;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos22_g1741 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1741 = ( i.vertexToFrag23_g1741 / unityObjectToClipPos22_g1741.w );
			float localCorrectedLinearEyeDepth20_g1741 = CorrectedLinearEyeDepth20_g1741( inputDepth20_g1741 , Correction20_g1741 );
			float4 temp_output_4_0_g1737 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * -appendResult6_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1737 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1737.xy );
			float inputDepth20_g1737 = clampDepth6_g1737;
			float4 unityObjectToClipPos22_g1737 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1737 = ( i.vertexToFrag23_g1737 / unityObjectToClipPos22_g1737.w );
			float localCorrectedLinearEyeDepth20_g1737 = CorrectedLinearEyeDepth20_g1737( inputDepth20_g1737 , Correction20_g1737 );
			float2 appendResult7_g1732 = (float2(0.0 , temp_output_3_0_g1732));
			float4 temp_output_4_0_g1735 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * appendResult7_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1735 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1735.xy );
			float inputDepth20_g1735 = clampDepth6_g1735;
			float4 unityObjectToClipPos22_g1735 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1735 = ( i.vertexToFrag23_g1735 / unityObjectToClipPos22_g1735.w );
			float localCorrectedLinearEyeDepth20_g1735 = CorrectedLinearEyeDepth20_g1735( inputDepth20_g1735 , Correction20_g1735 );
			float4 temp_output_4_0_g1733 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * -appendResult7_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1733 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1733.xy );
			float inputDepth20_g1733 = clampDepth6_g1733;
			float4 unityObjectToClipPos22_g1733 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1733 = ( i.vertexToFrag23_g1733 / unityObjectToClipPos22_g1733.w );
			float localCorrectedLinearEyeDepth20_g1733 = CorrectedLinearEyeDepth20_g1733( inputDepth20_g1733 , Correction20_g1733 );
			float smoothstepResult30_g1732 = smoothstep( 0.25 , 0.0 , saturate( ( ( ( localCorrectedLinearEyeDepth20_g1741 + localCorrectedLinearEyeDepth20_g1737 + localCorrectedLinearEyeDepth20_g1735 + localCorrectedLinearEyeDepth20_g1733 ) / 4.0 ) - i.eyeDepth ) ));
			float Outlines31_g1732 = smoothstepResult30_g1732;
			float Outlines671 = Outlines31_g1732;
			#ifdef _OUTLINES_ON
				float staticSwitch734 = Outlines671;
			#else
				float staticSwitch734 = 1.0;
			#endif
			float4 lerpResult729 = lerp( temp_output_1048_719 , ( DiffuseLighting69 + SpecularLighting91 + staticSwitch785 ) , staticSwitch734);
			c.rgb = lerpResult729.rgb;
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
			float4 MainTexRGBA715 = ( _Color * tex2D( _MainTex, uv_MainTex ) );
			float4 tex2DNode5 = tex2D( _MetallicGlossMap, uv_MainTex );
			float temp_output_263_0 = step( 32.0 , max( _MetallicGlossMap_TexelSize.z , _MetallicGlossMap_TexelSize.w ) );
			float lerpResult40 = lerp( _Metallic , tex2DNode5.r , temp_output_263_0);
			float Metallic23 = saturate( ( _MetallicMult * lerpResult40 ) );
			half3 specColor698 = (0).xxx;
			half oneMinusReflectivity698 = 0;
			half3 diffuseAndSpecularFromMetallic698 = DiffuseAndSpecularFromMetallic(MainTexRGBA715.rgb,Metallic23,specColor698,oneMinusReflectivity698);
			float3 MetAlbedo700 = diffuseAndSpecularFromMetallic698;
			o.Albedo = MetAlbedo700;
			float cos695_g1617 = cos( radians( _GradientDirection ) );
			float sin695_g1617 = sin( radians( _GradientDirection ) );
			float2 rotator695_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos695_g1617 , -sin695_g1617 , sin695_g1617 , cos695_g1617 )) + float2( 0.5,0.5 );
			float2 break995_g1617 = rotator695_g1617;
			float2 uv_GradientDirectionMap = i.uv_texcoord * _GradientDirectionMap_ST.xy + _GradientDirectionMap_ST.zw;
			float4 tex2DNode988_g1617 = tex2D( _GradientDirectionMap, uv_GradientDirectionMap );
			float GradientDirectionMap992_g1617 = tex2DNode988_g1617.r;
			float temp_output_1000_0_g1617 = step( 32.0 , max( _GradientDirectionMap_TexelSize.z , _GradientDirectionMap_TexelSize.w ) );
			float DirectionalMapEnable996_g1617 = temp_output_1000_0_g1617;
			float lerpResult998_g1617 = lerp( break995_g1617.x , GradientDirectionMap992_g1617 , DirectionalMapEnable996_g1617);
			float2 appendResult994_g1617 = (float2(lerpResult998_g1617 , break995_g1617.y));
			float2 GradientUVs698_g1617 = appendResult994_g1617;
			float4 _GradientZone01 = float4(9.4,0,0.57,0.49);
			float2 appendResult34_g1617 = (float2(( 1.0 / _GradientZone01.x ) , 0.0));
			float2 appendResult42_g1617 = (float2(_GradientZone01.z , _GradientZone01.w));
			float2 clampResult707_g1617 = clamp( (GradientUVs698_g1617*appendResult34_g1617 + appendResult42_g1617) , float2( 0.571,0 ) , float2( 0.676,1 ) );
			float2 GradientZone0175_g1617 = clampResult707_g1617;
			float4 _GradientZone02 = float4(9.4,0,0.6805,0.49);
			float2 appendResult38_g1617 = (float2(( 1.0 / _GradientZone02.x ) , 0.0));
			float2 appendResult41_g1617 = (float2(_GradientZone02.z , _GradientZone02.w));
			float2 clampResult710_g1617 = clamp( (GradientUVs698_g1617*appendResult38_g1617 + appendResult41_g1617) , float2( 0.681,0 ) , float2( 0.786,1 ) );
			float2 GradientZone0282_g1617 = clampResult710_g1617;
			int OutlineZoneIndex768_g1617 = _OutlineZone;
			float2 lerpResult756_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( OutlineZoneIndex768_g1617 ));
			float4 _GradientZone03 = float4(9.4,0,0.791,0.49);
			float2 appendResult57_g1617 = (float2(( 1.0 / _GradientZone03.x ) , 0.0));
			float2 appendResult52_g1617 = (float2(_GradientZone03.z , _GradientZone03.w));
			float2 clampResult711_g1617 = clamp( (GradientUVs698_g1617*appendResult57_g1617 + appendResult52_g1617) , float2( 0.792,0 ) , float2( 0.896,1 ) );
			float2 GradientZone03122_g1617 = clampResult711_g1617;
			float2 lerpResult754_g1617 = lerp( lerpResult756_g1617 , GradientZone03122_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 1 ) ));
			float2 OriginalOffset44_g1617 = float2( 0.1,0.471 );
			float2 Zone01138_g1617 = ( float2( 0.955,0.992 ) - OriginalOffset44_g1617 );
			float2 lerpResult747_g1617 = lerp( lerpResult754_g1617 , Zone01138_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 2 ) ));
			float2 Zone02188_g1617 = ( float2( 0.964,0.992 ) - OriginalOffset44_g1617 );
			float2 lerpResult735_g1617 = lerp( lerpResult747_g1617 , Zone02188_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 3 ) ));
			float2 Zone03224_g1617 = ( float2( 0.955,0.978 ) - OriginalOffset44_g1617 );
			float2 lerpResult752_g1617 = lerp( lerpResult735_g1617 , Zone03224_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 4 ) ));
			float2 Zone04291_g1617 = ( float2( 0.964,0.978 ) - OriginalOffset44_g1617 );
			float2 lerpResult757_g1617 = lerp( lerpResult752_g1617 , Zone04291_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 5 ) ));
			float2 OutlineZoneUV762_g1617 = lerpResult757_g1617;
			float temp_output_785_0_g1617 = ( 1.0 - _EnableOutlineGlow );
			float2 break1020_g1617 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult1019_g1617 = (float2(break1020_g1617.x , break1020_g1617.y));
			float4 tex2DNode1007_g1617 = tex2Dlod( _Stored, float4( ( ( ( ( ( float2( -995,-525 ) * appendResult1019_g1617 ) + i.uv_texcoord ) * appendResult1019_g1617 ) - float2( 0.1,-0.5 ) ) - float2( -0.73,-0.01 ) ), 0, 0.0) );
			float StoredTextureTog669_g1617 = ( 1.0 - ( min( tex2DNode1007_g1617.r , 1.0 ) * step( max( tex2DNode1007_g1617.g , tex2DNode1007_g1617.b ) , 0.0 ) ) );
			float temp_output_712_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y ) ) ) ) );
			float3 appendResult65_g1617 = (float3(temp_output_712_0_g1617 , temp_output_712_0_g1617 , temp_output_712_0_g1617));
			float3 DebugGradient1111_g1617 = appendResult65_g1617;
			float temp_output_713_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y + 0.3 ) ) ) ) );
			float3 appendResult72_g1617 = (float3(temp_output_713_0_g1617 , temp_output_713_0_g1617 , 0.0));
			float3 DebugGradient2110_g1617 = appendResult72_g1617;
			float3 lerpResult816_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( OutlineZoneIndex768_g1617 ));
			float temp_output_714_0_g1617 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g1617.x + _Time.y + 0.6 ) ) ) ) );
			float3 appendResult96_g1617 = (float3(0.0 , temp_output_714_0_g1617 , temp_output_714_0_g1617));
			float3 DebugGradient3173_g1617 = appendResult96_g1617;
			float3 lerpResult811_g1617 = lerp( lerpResult816_g1617 , DebugGradient3173_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 1 ) ));
			float3 appendResult139_g1617 = (float3(0.0 , 0.0 , saturate( ( 1.0 - abs( sin( _Time.y ) ) ) )));
			float3 DebugZone1195_g1617 = appendResult139_g1617;
			float3 lerpResult817_g1617 = lerp( lerpResult811_g1617 , DebugZone1195_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 2 ) ));
			float temp_output_716_0_g1617 = saturate( ( 1.0 - abs( sin( ( _Time.y + 0.2 ) ) ) ) );
			float3 appendResult192_g1617 = (float3(temp_output_716_0_g1617 , temp_output_716_0_g1617 , temp_output_716_0_g1617));
			float3 DebugZone2250_g1617 = appendResult192_g1617;
			float3 lerpResult800_g1617 = lerp( lerpResult817_g1617 , DebugZone2250_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 3 ) ));
			float3 appendResult259_g1617 = (float3(saturate( ( 1.0 - abs( sin( ( _Time.y + 0.4 ) ) ) ) ) , 0.0 , 0.0));
			float3 DebugZone3309_g1617 = appendResult259_g1617;
			float3 lerpResult813_g1617 = lerp( lerpResult800_g1617 , DebugZone3309_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 4 ) ));
			float3 appendResult306_g1617 = (float3(0.0 , saturate( ( 1.0 - abs( sin( ( _Time.y + 0.6 ) ) ) ) ) , 0.0));
			float3 DebugZone4332_g1617 = appendResult306_g1617;
			float3 lerpResult821_g1617 = lerp( lerpResult813_g1617 , DebugZone4332_g1617 , (float)saturate( ( OutlineZoneIndex768_g1617 - 5 ) ));
			float EnableOutlineGlow780_g1617 = temp_output_785_0_g1617;
			float3 DebugOutlineGlow812_g1617 = saturate( ( lerpResult821_g1617 + EnableOutlineGlow780_g1617 ) );
			float DebugSwitch628_g1617 = _DebugMode;
			float4 lerpResult772_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( OutlineZoneUV762_g1617, 0, 0.0) ) + temp_output_785_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugOutlineGlow812_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 temp_output_728_0_g1617 = _OutlineColor;
			float4 lerpResult723_g1617 = lerp( lerpResult772_g1617 , temp_output_728_0_g1617 , saturate( ( temp_output_785_0_g1617 + ( ( 1.0 - DebugSwitch628_g1617 ) * StoredTextureTog669_g1617 ) ) ));
			float4 OutlineGlowColor730_g1617 = lerpResult723_g1617;
			float2 ReactiveZone365_g1617 = ( float2( 0.673,0.985 ) - OriginalOffset44_g1617 );
			float mulTime293_g1617 = _Time.y * 13.0;
			float3 appendResult390_g1617 = (float3(saturate( sin( mulTime293_g1617 ) ) , saturate( sin( ( mulTime293_g1617 + 0.5 ) ) ) , 0.0));
			float4 lerpResult637_g1617 = lerp( saturate( ( StoredTextureTog669_g1617 + tex2D( _Stored, ReactiveZone365_g1617 ) ) ) , float4( appendResult390_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 break417_g1617 = lerpResult637_g1617;
			float LowBlink431_g1617 = break417_g1617.r;
			int ReactivityIndexOutline778_g1617 = _OutlineReactivity;
			float4 lerpResult830_g1617 = lerp( OutlineGlowColor730_g1617 , ( OutlineGlowColor730_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexOutline778_g1617 ));
			float cos437_g1617 = cos( radians( _LowsPulseDirection ) );
			float sin437_g1617 = sin( radians( _LowsPulseDirection ) );
			float2 rotator437_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos437_g1617 , -sin437_g1617 , sin437_g1617 , cos437_g1617 )) + float2( 0.5,0.5 );
			float lerpResult991_g1617 = lerp( rotator437_g1617.y , tex2DNode988_g1617.r , temp_output_1000_0_g1617);
			float LowPulse493_g1617 = saturate( ( lerpResult991_g1617 - ( 1.0 - LowBlink431_g1617 ) ) );
			float4 lerpResult849_g1617 = lerp( lerpResult830_g1617 , ( OutlineGlowColor730_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 1 ) ));
			float HighBlink464_g1617 = break417_g1617.g;
			float4 lerpResult832_g1617 = lerp( lerpResult849_g1617 , ( OutlineGlowColor730_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 2 ) ));
			float cos456_g1617 = cos( radians( _HighsPulseDirection ) );
			float sin456_g1617 = sin( radians( _HighsPulseDirection ) );
			float2 rotator456_g1617 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos456_g1617 , -sin456_g1617 , sin456_g1617 , cos456_g1617 )) + float2( 0.5,0.5 );
			float lerpResult989_g1617 = lerp( rotator456_g1617.y , tex2DNode988_g1617.r , temp_output_1000_0_g1617);
			float HighPulse556_g1617 = saturate( ( lerpResult989_g1617 - ( 1.0 - HighBlink464_g1617 ) ) );
			float4 lerpResult852_g1617 = lerp( lerpResult832_g1617 , ( OutlineGlowColor730_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexOutline778_g1617 - 3 ) ));
			float4 FinalGlowOutline826_g1617 = lerpResult852_g1617;
			float4 temp_output_1048_719 = FinalGlowOutline826_g1617;
			int EmissionZoneIndex47_g1617 = _EmissionZone;
			float2 lerpResult169_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( EmissionZoneIndex47_g1617 ));
			float2 lerpResult214_g1617 = lerp( lerpResult169_g1617 , GradientZone03122_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 1 ) ));
			float2 lerpResult249_g1617 = lerp( lerpResult214_g1617 , Zone01138_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 2 ) ));
			float2 lerpResult286_g1617 = lerp( lerpResult249_g1617 , Zone02188_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 3 ) ));
			float2 lerpResult343_g1617 = lerp( lerpResult286_g1617 , Zone03224_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 4 ) ));
			float2 lerpResult364_g1617 = lerp( lerpResult343_g1617 , Zone04291_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 5 ) ));
			float2 EmissionZoneUV375_g1617 = lerpResult364_g1617;
			float temp_output_423_0_g1617 = ( 1.0 - _EnableEmissionGlow );
			float3 lerpResult181_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( EmissionZoneIndex47_g1617 ));
			float3 lerpResult244_g1617 = lerp( lerpResult181_g1617 , DebugGradient3173_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 1 ) ));
			float3 lerpResult278_g1617 = lerp( lerpResult244_g1617 , DebugZone1195_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 2 ) ));
			float3 lerpResult352_g1617 = lerp( lerpResult278_g1617 , DebugZone2250_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 3 ) ));
			float3 lerpResult362_g1617 = lerp( lerpResult352_g1617 , DebugZone3309_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 4 ) ));
			float3 lerpResult379_g1617 = lerp( lerpResult362_g1617 , DebugZone4332_g1617 , (float)saturate( ( EmissionZoneIndex47_g1617 - 5 ) ));
			float EnableGlowMaskEmission683_g1617 = temp_output_423_0_g1617;
			float3 DebugEmissionColor399_g1617 = saturate( ( lerpResult379_g1617 + EnableGlowMaskEmission683_g1617 ) );
			float4 lerpResult634_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( EmissionZoneUV375_g1617, 0, 0.0) ) + temp_output_423_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugEmissionColor399_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 panner923 = ( 0.1 * _Time.y * ( _EmissionPan * _EmissionPanSpeed ) + uv_EmissionMap);
			float2 uv_EffectMask = i.uv_texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float4 tex2DNode819 = tex2D( _EffectMask, uv_EffectMask );
			float4 EffectMaskRGBA848 = tex2DNode819;
			float lerpResult947 = lerp( 1.0 , EffectMaskRGBA848.r , _MaskEmission);
			float4 lerpResult47 = lerp( _EmissionColor , ( tex2D( _EmissionMap, panner923 ) * _EmissionColor * lerpResult947 ) , step( 32.0 , max( _EmissionMap_TexelSize.z , _EmissionMap_TexelSize.w ) ));
			float4 EmissionRGBA22 = ( lerpResult47 * _EnableEmission );
			float3 Emission436_g1617 = EmissionRGBA22.rgb;
			float4 EmissionGlowColor471_g1617 = ( lerpResult634_g1617 * float4( Emission436_g1617 , 0.0 ) );
			int ReactivityIndexEmission470_g1617 = _EmissionReactivity;
			float4 lerpResult532_g1617 = lerp( EmissionGlowColor471_g1617 , ( EmissionGlowColor471_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexEmission470_g1617 ));
			float4 lerpResult580_g1617 = lerp( lerpResult532_g1617 , ( EmissionGlowColor471_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexEmission470_g1617 - 1 ) ));
			float4 lerpResult590_g1617 = lerp( lerpResult580_g1617 , ( EmissionGlowColor471_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexEmission470_g1617 - 2 ) ));
			float4 lerpResult596_g1617 = lerp( lerpResult590_g1617 , ( EmissionGlowColor471_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexEmission470_g1617 - 3 ) ));
			float4 FinalGlowEmission600_g1617 = lerpResult596_g1617;
			int GlowMaskRIndex48_g1617 = _GlowMaskZoneR;
			float2 lerpResult170_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( GlowMaskRIndex48_g1617 ));
			float2 lerpResult216_g1617 = lerp( lerpResult170_g1617 , GradientZone03122_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 1 ) ));
			float2 lerpResult263_g1617 = lerp( lerpResult216_g1617 , Zone01138_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 2 ) ));
			float2 lerpResult298_g1617 = lerp( lerpResult263_g1617 , Zone02188_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 3 ) ));
			float2 lerpResult338_g1617 = lerp( lerpResult298_g1617 , Zone03224_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 4 ) ));
			float2 lerpResult355_g1617 = lerp( lerpResult338_g1617 , Zone04291_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 5 ) ));
			float2 GlowMaskZoneRUV376_g1617 = lerpResult355_g1617;
			float temp_output_424_0_g1617 = ( 1.0 - _EnableGlowMaskR );
			float3 lerpResult175_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( GlowMaskRIndex48_g1617 ));
			float3 lerpResult233_g1617 = lerp( lerpResult175_g1617 , DebugGradient3173_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 1 ) ));
			float3 lerpResult305_g1617 = lerp( lerpResult233_g1617 , DebugZone1195_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 2 ) ));
			float3 lerpResult321_g1617 = lerp( lerpResult305_g1617 , DebugZone2250_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 3 ) ));
			float3 lerpResult363_g1617 = lerp( lerpResult321_g1617 , DebugZone3309_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 4 ) ));
			float3 lerpResult387_g1617 = lerp( lerpResult363_g1617 , DebugZone4332_g1617 , (float)saturate( ( GlowMaskRIndex48_g1617 - 5 ) ));
			float EnableGlowMaskR682_g1617 = temp_output_424_0_g1617;
			float3 DebugGlowMaskR397_g1617 = saturate( ( lerpResult387_g1617 + EnableGlowMaskR682_g1617 ) );
			float4 lerpResult633_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneRUV376_g1617, 0, 0.0) ) + temp_output_424_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugGlowMaskR397_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float2 uv_GlowMaskRGB = i.uv_texcoord * _GlowMaskRGB_ST.xy + _GlowMaskRGB_ST.zw;
			float3 GlowMask605_g1617 = (tex2D( _GlowMaskRGB, uv_GlowMaskRGB ).rgb).xyz;
			float4 GlowMaskZoneRColor468_g1617 = ( lerpResult633_g1617 * _GlowMaskTintR * GlowMask605_g1617.x );
			int ReactivityIndexR469_g1617 = _ReacitvityR;
			float4 lerpResult539_g1617 = lerp( GlowMaskZoneRColor468_g1617 , ( GlowMaskZoneRColor468_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexR469_g1617 ));
			float4 lerpResult577_g1617 = lerp( lerpResult539_g1617 , ( GlowMaskZoneRColor468_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexR469_g1617 - 1 ) ));
			float4 lerpResult588_g1617 = lerp( lerpResult577_g1617 , ( GlowMaskZoneRColor468_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexR469_g1617 - 2 ) ));
			float4 lerpResult595_g1617 = lerp( lerpResult588_g1617 , ( GlowMaskZoneRColor468_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexR469_g1617 - 3 ) ));
			float4 FinalGlowR599_g1617 = lerpResult595_g1617;
			int GlowMaskGIndex45_g1617 = _GlowMaskZoneG;
			float2 lerpResult155_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( GlowMaskGIndex45_g1617 ));
			float2 lerpResult222_g1617 = lerp( lerpResult155_g1617 , GradientZone03122_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 1 ) ));
			float2 lerpResult230_g1617 = lerp( lerpResult222_g1617 , Zone01138_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 2 ) ));
			float2 lerpResult300_g1617 = lerp( lerpResult230_g1617 , Zone02188_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 3 ) ));
			float2 lerpResult330_g1617 = lerp( lerpResult300_g1617 , Zone03224_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 4 ) ));
			float2 lerpResult367_g1617 = lerp( lerpResult330_g1617 , Zone04291_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 5 ) ));
			float2 GlowMaskZoneGUV385_g1617 = lerpResult367_g1617;
			float temp_output_419_0_g1617 = ( 1.0 - _EnableGlowMaskG );
			float3 lerpResult212_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( GlowMaskGIndex45_g1617 ));
			float3 lerpResult236_g1617 = lerp( lerpResult212_g1617 , DebugGradient3173_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 1 ) ));
			float3 lerpResult296_g1617 = lerp( lerpResult236_g1617 , DebugZone1195_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 2 ) ));
			float3 lerpResult323_g1617 = lerp( lerpResult296_g1617 , DebugZone2250_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 3 ) ));
			float3 lerpResult354_g1617 = lerp( lerpResult323_g1617 , DebugZone3309_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 4 ) ));
			float3 lerpResult388_g1617 = lerp( lerpResult354_g1617 , DebugZone4332_g1617 , (float)saturate( ( GlowMaskGIndex45_g1617 - 5 ) ));
			float EnableGlowMaskG681_g1617 = temp_output_419_0_g1617;
			float3 DebugGlowMaskG396_g1617 = saturate( ( lerpResult388_g1617 + EnableGlowMaskG681_g1617 ) );
			float4 lerpResult630_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneGUV385_g1617, 0, 0.0) ) + temp_output_419_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugGlowMaskG396_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 GlowMaskZoneGColor472_g1617 = ( lerpResult630_g1617 * _GlowMaskTintG * GlowMask605_g1617.y );
			int ReactivityIndexG467_g1617 = _ReacitvityG;
			float4 lerpResult551_g1617 = lerp( GlowMaskZoneGColor472_g1617 , ( GlowMaskZoneGColor472_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexG467_g1617 ));
			float4 lerpResult564_g1617 = lerp( lerpResult551_g1617 , ( GlowMaskZoneGColor472_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexG467_g1617 - 1 ) ));
			float4 lerpResult585_g1617 = lerp( lerpResult564_g1617 , ( GlowMaskZoneGColor472_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexG467_g1617 - 2 ) ));
			float4 lerpResult593_g1617 = lerp( lerpResult585_g1617 , ( GlowMaskZoneGColor472_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexG467_g1617 - 3 ) ));
			float4 FinalGlowG598_g1617 = lerpResult593_g1617;
			int GlowMaskBIndex50_g1617 = _GlowMaskZoneB;
			float2 lerpResult157_g1617 = lerp( GradientZone0175_g1617 , GradientZone0282_g1617 , (float)saturate( GlowMaskBIndex50_g1617 ));
			float2 lerpResult205_g1617 = lerp( lerpResult157_g1617 , GradientZone03122_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 1 ) ));
			float2 lerpResult262_g1617 = lerp( lerpResult205_g1617 , Zone01138_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 2 ) ));
			float2 lerpResult311_g1617 = lerp( lerpResult262_g1617 , Zone02188_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 3 ) ));
			float2 lerpResult336_g1617 = lerp( lerpResult311_g1617 , Zone03224_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 4 ) ));
			float2 lerpResult370_g1617 = lerp( lerpResult336_g1617 , Zone04291_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 5 ) ));
			float2 GlowMaskZoneBUV383_g1617 = lerpResult370_g1617;
			float temp_output_421_0_g1617 = ( 1.0 - _EnableGlowMaskB );
			float3 lerpResult197_g1617 = lerp( DebugGradient1111_g1617 , DebugGradient2110_g1617 , (float)saturate( GlowMaskBIndex50_g1617 ));
			float3 lerpResult237_g1617 = lerp( lerpResult197_g1617 , DebugGradient3173_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 1 ) ));
			float3 lerpResult287_g1617 = lerp( lerpResult237_g1617 , DebugZone1195_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 2 ) ));
			float3 lerpResult339_g1617 = lerp( lerpResult287_g1617 , DebugZone2250_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 3 ) ));
			float3 lerpResult360_g1617 = lerp( lerpResult339_g1617 , DebugZone3309_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 4 ) ));
			float3 lerpResult384_g1617 = lerp( lerpResult360_g1617 , DebugZone4332_g1617 , (float)saturate( ( GlowMaskBIndex50_g1617 - 5 ) ));
			float EnableGlowMaskB680_g1617 = temp_output_421_0_g1617;
			float3 DebugGlowMaskB401_g1617 = saturate( ( lerpResult384_g1617 + EnableGlowMaskB680_g1617 ) );
			float4 lerpResult626_g1617 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneBUV383_g1617, 0, 0.0) ) + temp_output_421_0_g1617 + StoredTextureTog669_g1617 ) ) , float4( DebugGlowMaskB401_g1617 , 0.0 ) , DebugSwitch628_g1617);
			float4 GlowMaskZoneBColor466_g1617 = ( lerpResult626_g1617 * _GlowMaskTintB * GlowMask605_g1617.z );
			int ReactivityIndexB480_g1617 = _ReacitvityB;
			float4 lerpResult553_g1617 = lerp( GlowMaskZoneBColor466_g1617 , ( GlowMaskZoneBColor466_g1617 * LowBlink431_g1617 ) , (float)saturate( ReactivityIndexB480_g1617 ));
			float4 lerpResult574_g1617 = lerp( lerpResult553_g1617 , ( GlowMaskZoneBColor466_g1617 * LowPulse493_g1617 ) , (float)saturate( ( ReactivityIndexB480_g1617 - 1 ) ));
			float4 lerpResult591_g1617 = lerp( lerpResult574_g1617 , ( GlowMaskZoneBColor466_g1617 * HighBlink464_g1617 ) , (float)saturate( ( ReactivityIndexB480_g1617 - 2 ) ));
			float4 lerpResult594_g1617 = lerp( lerpResult591_g1617 , ( GlowMaskZoneBColor466_g1617 * HighPulse556_g1617 ) , (float)saturate( ( ReactivityIndexB480_g1617 - 3 ) ));
			float4 FinalGlowB597_g1617 = lerpResult594_g1617;
			float4 temp_cast_93 = (0.0).xxxx;
			float time792 = 0.0;
			float2 voronoiSmoothId792 = 0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 Offset793 = ( ( 0.0 - 1 ) * ase_worldViewDir.xy * _SparkleDepth ) + i.uv_texcoord;
			float2 coords792 = Offset793 * _SparkleTiling;
			float2 id792 = 0;
			float2 uv792 = 0;
			float voroi792 = voronoi792( coords792, time792, id792, uv792, 0, voronoiSmoothId792 );
			float smoothstepResult810 = smoothstep( _SparkleSize , 0.0 , voroi792);
			float mulTime799 = _Time.y * _SparkleSpeed;
			float smoothstepResult811 = smoothstep( _SparkleThreshold , 1.0 , tex2D( _Noise, ( id792 + mulTime799 ) ).r);
			float lerpResult954 = lerp( 1.0 , tex2DNode819.b , _MaskSparklesB);
			#ifdef _SPARKLES_ON
				float4 staticSwitch814 = ( ( smoothstepResult810 * smoothstepResult811 * _SparkleColor ) * lerpResult954 );
			#else
				float4 staticSwitch814 = temp_cast_93;
			#endif
			float4 temp_output_813_0 = ( ( FinalGlowEmission600_g1617 + FinalGlowR599_g1617 + FinalGlowG598_g1617 + FinalGlowB597_g1617 ) + staticSwitch814 );
			float4 temp_cast_94 = (0.1).xxxx;
			float4 temp_output_1048_977 = lerpResult634_g1617;
			float4 EGColor868 = temp_output_1048_977;
			float temp_output_987_0_g1617 = ( ( 1.0 - DebugSwitch628_g1617 ) * StoredTextureTog669_g1617 );
			float EGEnabled869 = saturate( ( temp_output_423_0_g1617 + temp_output_987_0_g1617 ) );
			float4 lerpResult872 = lerp( max( temp_cast_94 , EGColor868 ) , _LumaFlowColor , EGEnabled869);
			float lerpResult957 = lerp( 1.0 , (EffectMaskRGBA848).g , _MaskLumaFlowG);
			float4 temp_output_843_0 = ( lerpResult872 * lerpResult957 );
			float3 hsvTorgb833 = RGBToHSV( temp_output_843_0.rgb );
			float3 hsvTorgb834 = HSVToRGB( float3(( -0.25 + hsvTorgb833.x ),hsvTorgb833.y,( hsvTorgb833.z * 2.0 )) );
			float2 temp_cast_97 = (_LumaFlowTiling).xx;
			float2 uv_TexCoord825 = i.uv_texcoord * temp_cast_97 + _Noise_ST.zw;
			float2 Offset853 = ( ( 0.0 - 1 ) * i.viewDir.xy * 0.1 ) + uv_TexCoord825;
			float2 temp_cast_98 = (( 0.8 * _LumaFlowTiling )).xx;
			float mulTime839 = _Time.y * _LumaFlowSpeed;
			float2 uv_TexCoord821 = i.uv_texcoord * temp_cast_98 + ( _Noise_ST.zw + mulTime839 );
			float4 lerpResult836 = lerp( temp_output_843_0 , float4( hsvTorgb834 , 0.0 ) , tex2D( _Noise, ( Offset853 + ( (-1.0 + (tex2D( _Noise, ( uv_TexCoord821 + float2( 0,0 ) ) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _LumaFlowDistortion ) + -mulTime839 ) ).r);
			float4 LumaFlow840 = lerpResult836;
			float lerpResult961 = lerp( 1.0 , (EffectMaskRGBA848).g , _MaskLumaFlowG);
			float4 lerpResult845 = lerp( temp_output_813_0 , ( LumaFlow840 + ( LumaFlow840 * staticSwitch814 ) ) , lerpResult961);
			#ifdef _LUMAFLOW_ON
				float4 staticSwitch855 = lerpResult845;
			#else
				float4 staticSwitch855 = temp_output_813_0;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult5_g1732 = (float2(_ScreenParams.x , _ScreenParams.y));
			float2 temp_output_10_0_g1732 = ( 1.0 / appendResult5_g1732 );
			float temp_output_3_0_g1732 = max( ( _OutlineWidth * saturate( ( 1.0 - ( ( i.eyeDepth + 2.0 ) * 0.1 ) ) ) ) , 1.0 );
			float2 appendResult6_g1732 = (float2(temp_output_3_0_g1732 , 0.0));
			float4 temp_output_4_0_g1741 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * appendResult6_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1741 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1741.xy );
			float inputDepth20_g1741 = clampDepth6_g1741;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos22_g1741 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1741 = ( i.vertexToFrag23_g1741 / unityObjectToClipPos22_g1741.w );
			float localCorrectedLinearEyeDepth20_g1741 = CorrectedLinearEyeDepth20_g1741( inputDepth20_g1741 , Correction20_g1741 );
			float4 temp_output_4_0_g1737 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * -appendResult6_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1737 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1737.xy );
			float inputDepth20_g1737 = clampDepth6_g1737;
			float4 unityObjectToClipPos22_g1737 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1737 = ( i.vertexToFrag23_g1737 / unityObjectToClipPos22_g1737.w );
			float localCorrectedLinearEyeDepth20_g1737 = CorrectedLinearEyeDepth20_g1737( inputDepth20_g1737 , Correction20_g1737 );
			float2 appendResult7_g1732 = (float2(0.0 , temp_output_3_0_g1732));
			float4 temp_output_4_0_g1735 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * appendResult7_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1735 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1735.xy );
			float inputDepth20_g1735 = clampDepth6_g1735;
			float4 unityObjectToClipPos22_g1735 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1735 = ( i.vertexToFrag23_g1735 / unityObjectToClipPos22_g1735.w );
			float localCorrectedLinearEyeDepth20_g1735 = CorrectedLinearEyeDepth20_g1735( inputDepth20_g1735 , Correction20_g1735 );
			float4 temp_output_4_0_g1733 = ( ase_screenPosNorm + float4( ( temp_output_10_0_g1732 * -appendResult7_g1732 ), 0.0 , 0.0 ) );
			float clampDepth6_g1733 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, temp_output_4_0_g1733.xy );
			float inputDepth20_g1733 = clampDepth6_g1733;
			float4 unityObjectToClipPos22_g1733 = UnityObjectToClipPos( ase_vertex3Pos );
			float Correction20_g1733 = ( i.vertexToFrag23_g1733 / unityObjectToClipPos22_g1733.w );
			float localCorrectedLinearEyeDepth20_g1733 = CorrectedLinearEyeDepth20_g1733( inputDepth20_g1733 , Correction20_g1733 );
			float smoothstepResult30_g1732 = smoothstep( 0.25 , 0.0 , saturate( ( ( ( localCorrectedLinearEyeDepth20_g1741 + localCorrectedLinearEyeDepth20_g1737 + localCorrectedLinearEyeDepth20_g1735 + localCorrectedLinearEyeDepth20_g1733 ) / 4.0 ) - i.eyeDepth ) ));
			float Outlines31_g1732 = smoothstepResult30_g1732;
			float Outlines671 = Outlines31_g1732;
			#ifdef _OUTLINES_ON
				float staticSwitch734 = Outlines671;
			#else
				float staticSwitch734 = 1.0;
			#endif
			float4 lerpResult728 = lerp( temp_output_1048_719 , staticSwitch855 , staticSwitch734);
			o.Emission = lerpResult728.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa noforwardadd vertex:vertexDataFunc 

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
				float3 customPack2 : TEXCOORD2;
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
				o.customPack1.z = customInputData.eyeDepth;
				o.customPack1.w = customInputData.vertexToFrag23_g1741;
				o.customPack2.x = customInputData.vertexToFrag23_g1737;
				o.customPack2.y = customInputData.vertexToFrag23_g1735;
				o.customPack2.z = customInputData.vertexToFrag23_g1733;
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
				surfIN.eyeDepth = IN.customPack1.z;
				surfIN.vertexToFrag23_g1741 = IN.customPack1.w;
				surfIN.vertexToFrag23_g1737 = IN.customPack2.x;
				surfIN.vertexToFrag23_g1735 = IN.customPack2.y;
				surfIN.vertexToFrag23_g1733 = IN.customPack2.z;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
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
	Fallback "Diffuse"
	CustomEditor "AquaShaderGUI"
}
/*ASEBEGIN
Version=18935
908;162;2326;1343;1285.445;44.72235;1.257244;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;909;411.0304,2291.548;Inherit;True;Property;_EffectMask;Effect Mask;43;0;Create;False;0;0;0;False;0;False;None;bff4d41592b39c745bf01a504c89d3b0;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;819;747.1909,1938.197;Inherit;True;Property;_TextureSample;TextureSample;39;0;Create;True;0;0;0;False;0;False;-1;None;bff4d41592b39c745bf01a504c89d3b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;312;-3070.081,-358.8645;Inherit;False;1624.906;2277.979;Comment;59;22;266;47;265;48;264;11;45;17;10;25;14;23;19;43;42;13;7;268;267;40;6;41;21;24;9;260;44;16;8;258;37;259;39;263;5;18;12;314;315;316;317;320;449;477;479;482;483;499;502;504;501;616;714;715;921;922;923;1057;Texture Assignment;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;919;-3275.646,620.7645;Inherit;False;Property;_EmissionPan;Enable Emission Panning;90;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;848;1098.64,1944.943;Inherit;False;EffectMaskRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;10;-3036.603,285.0772;Inherit;True;Property;_EmissionMap;Emission;6;0;Create;False;0;0;0;False;0;False;None;bff4d41592b39c745bf01a504c89d3b0;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;920;-3506.596,709.4295;Inherit;False;Property;_EmissionPanSpeed;Emission Pan Speed;91;0;Create;False;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;927;-3701.366,449.8586;Inherit;False;848;EffectMaskRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;922;-3012.816,476.2315;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;921;-2958.606,614.7535;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-2735.843,288.7984;Inherit;False;EmissionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;946;-3540.479,554.144;Inherit;False;Property;_MaskEmission;Mask Emission (R);54;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;929;-3474.738,399.6727;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.PannerNode;923;-2731.726,478.0235;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;948;-3652.117,336.7433;Inherit;False;Constant;_Float0;Float 0;51;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-2460.181,471.9951;Inherit;False;Property;_EmissionColor;Emission Color;7;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-2533.925,286.4925;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;947;-3277.834,369.241;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;12;-3032.112,806.3143;Inherit;True;Property;_MetallicGlossMap;Metallic;11;0;Create;False;0;0;0;False;0;False;None;None;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-2726.901,804.4884;Inherit;False;MetallicTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1057;-2770.307,1628.475;Inherit;False;0;6;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-2217.072,384.5918;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;264;-2456.962,645.4688;Inherit;False;DoesTextureExist;-1;;668;4e1e1200369ca2442907b791dca76406;0;1;4;SAMPLER2D;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2508.926,726.4688;Inherit;False;Property;_Metallic;Metallic;12;0;Create;True;0;0;0;False;0;False;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-2525.182,803.7869;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;263;-2466.264,1067.016;Inherit;False;DoesTextureExist;-1;;669;4e1e1200369ca2442907b791dca76406;0;1;4;SAMPLER2D;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-3020.081,-150.3048;Inherit;True;Property;_MainTex;MainTex;0;1;[Header];Create;True;1;Texture Settings;0;0;False;0;False;None;fdaeb16d28f428348be1355797678d40;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;265;-2054.666,467.8889;Inherit;False;Property;_EnableEmission;Enable Emission;5;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;-2033.528,355.2315;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;714;-2716.8,-146.0843;Inherit;False;MainTexTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.LerpOp;40;-2212.008,805.647;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;8;-2993.248,52.77805;Inherit;True;Property;_BumpMap;Normal Map;3;1;[Normal];Create;False;0;0;0;False;0;False;None;33afc0ae32e97f846ab888be1543f0f1;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;267;-2219.269,724.9987;Inherit;False;Property;_MetallicMult;Metallic Mult;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-3013.329,1160.354;Inherit;True;Property;_OcclusionMap;Occlusion;16;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-1815.279,452.889;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;-2495.474,-140.6508;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-1856.736,351.003;Inherit;False;EmissionRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-2709.842,51.65414;Inherit;False;NormalMapTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-2713.183,1157.254;Inherit;False;OcclusionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;477;-2579.05,1346.205;Inherit;False;Property;_OcclusionStrength;Occlusion Strength;17;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2773.675,127.9339;Inherit;False;Property;_BumpScale;Scale;4;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;-2447.377,-308.8645;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-1979.882,781.9987;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-2515.606,1158.013;Inherit;True;Property;_TextureSample4;Texture Sample 4;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;732;-129.1303,-410.0122;Inherit;False;Property;_OutlineColor;Outline Color;49;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;495;-184.9299,111.2459;Inherit;True;Property;_GlowMaskRGB;Glow Mask;51;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;33;-99.13393,33.06703;Inherit;False;22;EmissionRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2153.575,-159.3646;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;483;-2309.05,1348.205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-2502.177,64.48508;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;901;2320.122,2094.509;Inherit;False;Property;_LumaFlowSpeed;Luma Flow Speed;101;0;Create;True;0;0;0;False;0;False;0.001;0.001;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2509.068,989.6672;Inherit;False;Property;_Glossiness;Smoothness;14;0;Create;False;0;0;0;False;0;False;0.5;0.35;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;494;-118.4869,-158.6546;Inherit;True;Global;_Stored;_Stored;103;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SaturateNode;616;-1852.985,780.2809;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;763;-339.9212,-57.06429;Inherit;False;Property;_RimlightColor;Rimlight Color;46;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;11.98431,11.98431,11.98431,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureTransformNode;897;1497.916,1978.403;Inherit;False;798;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;715;-1713.312,-235.728;Inherit;False;MainTexRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1048;371.7283,92.56326;Inherit;False;LumaGlowFunction;55;;1617;092de522a712e4a49a7db9791eea5f51;0;5;728;FLOAT4;0,0,0,0;False;859;FLOAT4;0,0,0,0;False;618;SAMPLER2D;0;False;612;FLOAT3;0,0,0;False;611;FLOAT3;0,0,0;False;5;COLOR;977;FLOAT;978;FLOAT4;719;FLOAT4;976;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;830;1723.895,1806.309;Inherit;False;Constant;_Float10;Float 10;40;0;Create;True;0;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FaceVariableNode;499;-2157.644,195.3395;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;259;-2238.65,1057.394;Inherit;False;Property;_SmoothnessMult;Smoothness Mult;15;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;504;-2206.644,127.3395;Inherit;False;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;481;-2192.05,1210.205;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-1714.581,772.9872;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;839;2586.269,1979.413;Inherit;False;1;0;FLOAT;0.0025;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;-2221.068,945.6672;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;945;1534.624,1895.021;Inherit;False;Property;_LumaFlowTiling;Luma Flow Tiling;50;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;829;1912.895,1809.109;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;900;1878.334,1967.305;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;701;-3229.714,3406.512;Inherit;False;715;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;482;-2064.05,1212.205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;501;-2020.644,135.3395;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-2049.65,947.394;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;694;-3210.802,3502.486;Inherit;False;23;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;478;-2466.05,1434.205;Inherit;False;DoesTextureExist;-1;;1622;4e1e1200369ca2442907b791dca76406;0;1;4;SAMPLER2D;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;868;572.4833,-119.4117;Inherit;False;EGColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;314;-3024.172,1512.801;Inherit;True;Property;_Specular;Specular;8;0;Create;True;0;0;0;False;0;False;None;fdaeb16d28f428348be1355797678d40;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;821;1662.061,1672.948;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;870;2465.119,1050.806;Inherit;False;868;EGColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;874;2499.119,957.806;Inherit;False;Constant;_Float1;Float 1;41;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;479;-1863.05,1185.205;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;502;-1866.644,70.33951;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;260;-1929.65,945.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;832;1820.308,1230.863;Inherit;False;848;EffectMaskRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DiffuseAndSpecularFromMetallicNode;698;-3005.746,3424.377;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;3;FLOAT3;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;-2744.865,1516.958;Inherit;False;SpecularTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;869;588.4833,-44.41174;Inherit;False;EGEnabled;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;794;-1048.18,1623.779;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;795;-994.1799,1848.779;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;849;2080.603,1226.059;Inherit;False;False;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;842;2424.273,1131.383;Inherit;False;Property;_LumaFlowColor;Luma Flow Color;102;1;[HDR];Create;True;0;0;0;False;0;False;0,1,0.9602337,0;0,0.9627109,1.414214,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;871;2672.926,1266.833;Inherit;False;869;EGEnabled;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;959;2682.878,1435.321;Inherit;False;Property;_MaskLumaFlowG;Mask Luma Flow (G);52;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;875;2825.119,966.806;Inherit;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;958;2699.776,1365.08;Inherit;False;Constant;_Float12;Float 12;51;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;796;-1071.18,1744.779;Inherit;False;Property;_SparkleDepth;Sparkle Depth;40;0;Create;True;0;0;0;False;0;False;0;0;0;0.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-1702.093,70.61313;Inherit;False;NormalMapXYZ;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;316;-2508.865,1514.958;Inherit;True;Property;_TextureSample5;Texture Sample 5;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1805.01,941.4736;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;320;-2466.498,1713.003;Inherit;False;Property;_SpecularTint;Specular Color;9;1;[HDR];Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;898;2045.689,1679.963;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;700;-2640.977,3381.025;Inherit;False;MetAlbedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-1702.673,1179.784;Inherit;False;OcclusionG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;801;-736.1799,2061.779;Inherit;False;Property;_SparkleSpeed;Sparkle Speed;41;0;Create;True;0;0;0;False;0;False;0.01;0.005;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;872;2993.119,1128.806;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;957;2994.776,1341.08;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;793;-722.1799,1650.779;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;822;2215.593,1655.186;Inherit;True;Property;_TextureSample6;Texture Sample 6;38;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;798;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;797;-690.1799,1791.779;Inherit;False;Property;_SparkleTiling;Sparkle Tiling;39;0;Create;True;0;0;0;False;0;False;100;500;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;680;-2802.702,2123.884;Inherit;False;25;OcclusionG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;449;-2189.272,1518.04;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;676;-2815.642,2041.253;Inherit;False;21;NormalMapXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightAttenuation;679;-2823.502,2344.884;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;677;-2814.403,2199.284;Inherit;False;24;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;678;-2811.802,2268.184;Inherit;False;700;MetAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;799;-439.1799,2067.779;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;843;3210.85,1318.39;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;317;-2036.865,1514.958;Inherit;False;SpecularRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;792;-394.1799,1658.779;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;825;2242.676,1520.183;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1047;-2461.975,2121.929;Inherit;False;Luma Diffuse;18;;1623;ab46d30c6f8469f438d0db5eae458f8c;0;5;64;FLOAT3;0,0,1;False;67;FLOAT;0;False;72;FLOAT;0;False;79;COLOR;0,0,0,0;False;85;FLOAT;0;False;6;FLOAT3;88;FLOAT3;89;COLOR;90;FLOAT;91;FLOAT;92;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;824;2548.993,1676.486;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;828;2515.495,1854.109;Inherit;False;Property;_LumaFlowDistortion;Luma Flow Distortion;100;0;Create;True;0;0;0;False;0;False;0.1;0.455;0.05;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;854;2272.94,1360.115;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ParallaxMappingNode;853;2590.242,1522.551;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0.1;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;899;2829.853,1839.512;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;837;3521.675,1409.539;Inherit;False;Constant;_Float11;Float 11;39;0;Create;True;0;0;0;False;0;False;-0.25;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;644;-1922.279,2031.454;Inherit;False;LightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RGBToHSVNode;833;3468.503,1481.687;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;702;-2873.056,3537.723;Inherit;False;317;SpecularRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;827;2751.495,1675.109;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;859;-2026.055,3665.493;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;800;-214.1801,2015.779;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;826;2875.476,1576.083;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;812;17.7949,2236.706;Inherit;False;Property;_SparkleThreshold;Sparkle Threshold;45;0;Create;True;0;0;0;False;0;False;0.1;0.807;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;798;-84.18008,1986.779;Inherit;True;Property;_Noise;Noise;38;0;Create;True;0;0;0;False;0;False;-1;None;4ba9f602de4f0f2409a45db9ecd8c0e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;803;-401.205,1920.706;Inherit;False;Property;_SparkleSize;Sparkle Size;42;0;Create;True;0;0;0;False;0;False;0.01;0.025;0.001;0.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;896;3733.785,1615.657;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;835;3717.503,1482.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;864;-1996.531,3546.342;Inherit;False;644;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;696;-2536.269,3516.19;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;697;-2569.985,3610.482;Inherit;False;Property;_UseSpecularTexture;Use Specular;10;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;860;-1853.055,3659.493;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;834;3891.503,1481.687;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;857;-1709.055,3576.493;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;-1923.609,2255.82;Inherit;False;SaturatedGSF;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;699;-2327.789,3448.129;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;956;898.0174,2211.654;Inherit;False;Property;_MaskSparklesB;Mask Sparkles (B);53;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;810;16.7949,1528.706;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;902;435.4144,1770.943;Inherit;False;Property;_SparkleColor;Sparkle Color;44;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;811;368.7949,2058.706;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.6;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;823;3046.293,1564.286;Inherit;True;Property;_TextureSample7;Texture Sample 7;38;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;798;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;955;885.0174,2139.654;Inherit;False;Constant;_Float9;Float 9;51;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;764;840.5173,-46.50397;Inherit;False;RimlightColor;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;651;-1922.447,2102.927;Inherit;False;LightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;713;-1696.906,3500.652;Inherit;False;71;SaturatedGSF;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;809;791.395,1692.706;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;954;1180.017,2115.654;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;861;-1586.055,3578.493;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;656;-1921.734,2180.257;Inherit;False;Attenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;836;4238.503,1445.687;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;1064;-1244.178,515.0341;Inherit;True;Global;_CameraDepthTexture;_CameraDepthTexture;85;0;Fetch;True;0;0;0;False;0;False;None;;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;704;-2146.358,3442.822;Inherit;False;SpecularColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;712;-1699.001,3425.635;Inherit;False;704;SpecularColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;659;-1673.206,3182.75;Inherit;False;651;LightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;711;-1701.732,3350.549;Inherit;False;21;NormalMapXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-3501.721,3072.563;Inherit;False;25;OcclusionG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;863;-1432.055,3524.493;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;660;-1682.206,3264.751;Inherit;False;656;Attenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;840;4581.285,1431.255;Inherit;False;LumaFlow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;820;1056.337,1689.414;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;765;-1688.033,3094.1;Inherit;False;764;RimlightColor;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;815;820.7639,1617.014;Inherit;False;Constant;_Float8;Float 8;37;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-3528.721,2927.562;Inherit;False;21;NormalMapXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1069;-971.7154,616.3122;Inherit;False;CameraDepthTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;-3506.721,3000.562;Inherit;False;24;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;814;1216.217,1591.499;Inherit;False;Property;_Sparkles;Sparkles;98;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;682;-2829.252,2680.328;Inherit;False;21;NormalMapXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;850;2255.754,579.3786;Inherit;False;848;EffectMaskRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;82;-3252.722,2921.562;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;683;-2824.785,2754.033;Inherit;False;24;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;686;-2807.47,3016.737;Inherit;False;651;LightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;684;-2816.968,2828.856;Inherit;False;23;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;844;2220.446,262.4771;Inherit;False;840;LumaFlow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;689;-2813.171,2602.647;Inherit;False;644;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;705;-2836.593,2526.759;Inherit;False;704;SpecularColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1089;-2894.736,-560.9691;Inherit;False;1069;CameraDepthTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;940;-1157.418,3263.003;Inherit;False;Luma Rimlight;31;;1743;5b3155e7c2220d94d8e624bb49449fcb;0;6;37;COLOR;0,0,0,0;False;35;FLOAT3;0,0,0;False;36;FLOAT;0;False;30;FLOAT3;0,0,0;False;31;COLOR;0,0,0,0;False;32;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;690;-2817.303,3089.785;Inherit;False;71;SaturatedGSF;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;851;2462.049,578.5747;Inherit;False;False;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1056;-2476.552,2710.02;Inherit;False;Luma Specular;28;;1745;408fd9e8da1e3f245ad772ffa8c598f3;0;8;83;COLOR;0,0,0,0;False;82;FLOAT3;0,0,0;False;62;FLOAT3;0,0,0;False;63;FLOAT;0;False;65;FLOAT;0;False;73;FLOAT3;0,0,0;False;74;COLOR;0,0,0,0;False;75;FLOAT;0;False;1;COLOR;80
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1049;2370.811,361.2215;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;467;-797.3391,3171.842;Inherit;False;Rimlight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1106;-2615.677,-543.5316;Inherit;False;DepthOutlines;47;;1732;01bbef20e59a14648a6e0d1d0736e972;0;1;39;SAMPLER2D;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;960;2591.745,688.7491;Inherit;False;Constant;_Float13;Float 13;51;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;813;2483.038,74.2592;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;671;-2383.885,-544.489;Inherit;False;Outlines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;961;2886.745,664.7491;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-1948.951,2729.929;Inherit;False;SpecularLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;786;357.8875,879.2886;Inherit;False;Constant;_Float7;Float 7;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;468;509.9256,969.257;Inherit;False;467;Rimlight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1050;2493.011,270.2215;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;-1924.327,2330.137;Inherit;False;DiffuseLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;332.9704,771.3664;Inherit;False;91;SpecularLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;785;755.8875,926.2886;Inherit;False;Property;_Rimlighting;Rimlighting;97;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;618.1082,535.6164;Inherit;False;69;DiffuseLighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;735;288.468,246.5356;Inherit;False;Constant;_Float6;Float 6;30;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;672;-155.3527,304.1732;Inherit;False;671;Outlines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;845;2619.474,235.5494;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;855;2683.578,64.13541;Inherit;False;Property;_LumaFlow;Luma Flow;99;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;94;1046.797,597.2612;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;734;460.9943,277.2193;Inherit;False;Property;_Outlines;Outlines;96;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;917;-1892.941,-646.8298;Inherit;False;Property;_SettingsMode;   Mode;93;1;[Enum];Create;False;0;4;Main Settings;3;Lighting Settings;0;Luma Glow Settings;2;Effect Settings;4;0;True;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;691;-2822.504,3166.486;Inherit;False;317;SpecularRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-558.2043,1109.629;Inherit;False;21;NormalMapXYZ;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-555.7917,1186.829;Inherit;False;22;EmissionRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;944;-1640.096,-547.0347;Inherit;False;Property;_MaskClip;Mask Clip Value;88;0;Create;False;0;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;818;1304.857,-349.9412;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;889.4977,232.4611;Inherit;False;715;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-531.6661,1257.999;Inherit;False;23;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;963;3154.109,693.6348;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;27;865.5123,22.30745;Inherit;False;700;MetAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;731;1160.142,164.2985;Inherit;False;Constant;_Float4;Float 4;26;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1066;-704.9345,500.0748;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;965;3219.089,869.4006;Inherit;False;Constant;_Float14;Float 14;54;0;Create;True;0;0;0;False;0;False;3.77;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;916;-1946.94,-548.8298;Inherit;False;Property;_AdvToggle;Toggle Advanced Settings;94;1;[ToggleUI];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-546.1415,1329.168;Inherit;False;24;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;1109;-722.6062,651.7977;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;505;1118.812,233.228;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;913;741.1028,2282.532;Inherit;False;EffectMaskTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1065;3860.615,390.9319;Inherit;False;Texture2DSample;-1;;1750;6179d142183ebb64ca37d025fd80aeb4;0;2;5;OBJECT;1,0,0,0,1,0,0,0,1;False;2;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;1113;-769.3652,737.3987;Inherit;False;Constant;_Color2;Color 2;58;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;969;-2285.517,-710.5833;Inherit;False;Property;_BlendOPdst;BlendOPdst;86;0;Create;True;0;0;0;True;0;False;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;950;-3291.514,774.9254;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;910;203.0304,1945.548;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectScaleNode;962;3448.431,950.8702;Inherit;False;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;26;-542.5078,1028.481;Inherit;False;700;MetAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-538.9037,1405.163;Inherit;False;25;OcclusionG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;817;1647.446,182.6819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1108;-990.5034,518.2611;Inherit;False;Texture2DGetDimensions;-1;;1726;abff9398dd419474ca60ef9d681db937;0;2;2;OBJECT;0;False;3;INT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1068;-547.9344,498.0748;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;729;1137.793,360.6908;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1112;-85.08842,469.2061;Inherit;False;Constant;_Float16;Float 16;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1085;-429.3919,501.3663;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1111;126.8114,353.5061;Inherit;False;False;5;0;FLOAT;22;False;1;FLOAT;18;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;730;1427.549,214.5573;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;728;2797.94,-156.0881;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;918;-1685.726,-662.8553;Inherit;False;Property;_BlendModeIndex;BlendModeIndex;92;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;1;-246.5579,1167.181;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1073;482.8427,556.5276;Inherit;False;Constant;_Float15;Float 15;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1075;20.0423,758.0276;Inherit;False;Constant;_Color0;Color 0;58;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;816;1003.64,-381.6212;Inherit;True;Property;_AlphaMask;AlphaMask;2;0;Create;True;0;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;1081;893.8337,318.8689;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;1104;-774.1456,887.9809;Inherit;False;2;4;0;FLOAT3;20,20,20;False;1;FLOAT3;18,18,18;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;498;-2136.616,-546.5114;Inherit;False;Property;_Culling;Culling;95;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1076;-302.3577,780.1276;Inherit;False;Constant;_Color1;Color 1;58;0;Create;True;0;0;0;False;0;False;0,0.1064057,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;970;-2447.517,-710.5833;Inherit;False;Property;_BlendOPsrc;BlendOPsrc;89;0;Create;True;0;0;0;True;0;False;5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;949;-3285.514,709.9254;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;838;2859.661,1913.549;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;964;3486.466,688.3085;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;951;-3091.914,723.9254;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;971;-2372.517,-788.5833;Inherit;False;Property;_BlendOPIndex;BlendOPIndex;87;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3317.547,55.4875;Float;False;True;-1;2;AquaShaderGUI;0;0;CustomLighting;Furality/Aqua Shader/Aqua Shader;False;False;False;False;False;False;True;True;True;False;True;True;False;False;False;False;False;False;True;True;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.3;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;498;-1;0;True;944;6;Custom;#if !defined(UNITY_STEREO_INSTANCING_ENABLED) && !defined(UNITY_STEREO_MULTIVIEW_ENABLED);False;;Custom;Custom;#undef UNITY_DECLARE_DEPTH_TEXTURE;False;;Custom;Custom;#define UNITY_DECLARE_DEPTH_TEXTURE(tex) UNITY_DECLARE_TEX2D(tex);False;;Custom;Custom;#undef SAMPLE_DEPTH_TEXTURE;False;;Custom;Custom;#define SAMPLE_DEPTH_TEXTURE(sampler, uv) (UNITY_SAMPLE_TEX2D(sampler, uv).r);False;;Custom;Custom;#endif;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;819;0;909;0
WireConnection;848;0;819;0
WireConnection;922;2;10;0
WireConnection;921;0;919;0
WireConnection;921;1;920;0
WireConnection;17;0;10;0
WireConnection;929;0;927;0
WireConnection;923;0;922;0
WireConnection;923;2;921;0
WireConnection;11;0;17;0
WireConnection;11;1;923;0
WireConnection;947;0;948;0
WireConnection;947;1;929;0
WireConnection;947;2;946;0
WireConnection;18;0;12;0
WireConnection;48;0;11;0
WireConnection;48;1;45;0
WireConnection;48;2;947;0
WireConnection;264;4;17;0
WireConnection;5;0;18;0
WireConnection;5;1;1057;0
WireConnection;263;4;18;0
WireConnection;47;0;45;0
WireConnection;47;1;48;0
WireConnection;47;2;264;0
WireConnection;714;0;6;0
WireConnection;40;0;41;0
WireConnection;40;1;5;1
WireConnection;40;2;263;0
WireConnection;266;0;47;0
WireConnection;266;1;265;0
WireConnection;7;0;714;0
WireConnection;22;0;266;0
WireConnection;16;0;8;0
WireConnection;19;0;13;0
WireConnection;268;0;267;0
WireConnection;268;1;40;0
WireConnection;14;0;19;0
WireConnection;14;1;1057;0
WireConnection;43;0;42;0
WireConnection;43;1;7;0
WireConnection;483;0;477;0
WireConnection;9;0;16;0
WireConnection;9;5;44;0
WireConnection;616;0;268;0
WireConnection;715;0;43;0
WireConnection;1048;728;732;0
WireConnection;1048;859;763;0
WireConnection;1048;618;494;0
WireConnection;1048;612;33;0
WireConnection;1048;611;495;0
WireConnection;504;0;9;0
WireConnection;481;0;14;2
WireConnection;481;1;483;0
WireConnection;23;0;616;0
WireConnection;839;0;901;0
WireConnection;37;0;39;0
WireConnection;37;1;5;4
WireConnection;37;2;263;0
WireConnection;829;0;830;0
WireConnection;829;1;945;0
WireConnection;900;0;897;1
WireConnection;900;1;839;0
WireConnection;482;0;481;0
WireConnection;501;0;504;0
WireConnection;501;1;499;0
WireConnection;258;0;37;0
WireConnection;258;1;259;0
WireConnection;478;4;13;0
WireConnection;868;0;1048;977
WireConnection;821;0;829;0
WireConnection;821;1;900;0
WireConnection;479;1;482;0
WireConnection;479;2;478;0
WireConnection;502;0;9;0
WireConnection;502;2;501;0
WireConnection;260;0;258;0
WireConnection;698;0;701;0
WireConnection;698;1;694;0
WireConnection;315;0;314;0
WireConnection;869;0;1048;978
WireConnection;849;0;832;0
WireConnection;875;0;874;0
WireConnection;875;1;870;0
WireConnection;21;0;502;0
WireConnection;316;0;315;0
WireConnection;316;1;1057;0
WireConnection;24;0;260;0
WireConnection;898;0;821;0
WireConnection;700;0;698;0
WireConnection;25;0;479;0
WireConnection;872;0;875;0
WireConnection;872;1;842;0
WireConnection;872;2;871;0
WireConnection;957;0;958;0
WireConnection;957;1;849;0
WireConnection;957;2;959;0
WireConnection;793;0;794;0
WireConnection;793;2;796;0
WireConnection;793;3;795;0
WireConnection;822;1;898;0
WireConnection;449;0;316;0
WireConnection;449;1;320;0
WireConnection;799;0;801;0
WireConnection;843;0;872;0
WireConnection;843;1;957;0
WireConnection;317;0;449;0
WireConnection;792;0;793;0
WireConnection;792;2;797;0
WireConnection;825;0;945;0
WireConnection;825;1;897;1
WireConnection;1047;64;676;0
WireConnection;1047;67;680;0
WireConnection;1047;72;677;0
WireConnection;1047;79;678;0
WireConnection;1047;85;679;0
WireConnection;824;0;822;1
WireConnection;853;0;825;0
WireConnection;853;3;854;0
WireConnection;899;0;839;0
WireConnection;644;0;1047;89
WireConnection;833;0;843;0
WireConnection;827;0;824;0
WireConnection;827;1;828;0
WireConnection;800;0;792;1
WireConnection;800;1;799;0
WireConnection;826;0;853;0
WireConnection;826;1;827;0
WireConnection;826;2;899;0
WireConnection;798;1;800;0
WireConnection;896;0;833;3
WireConnection;835;0;837;0
WireConnection;835;1;833;1
WireConnection;696;0;698;1
WireConnection;696;1;702;0
WireConnection;860;0;859;0
WireConnection;834;0;835;0
WireConnection;834;1;833;2
WireConnection;834;2;896;0
WireConnection;857;0;864;0
WireConnection;857;1;860;0
WireConnection;71;0;1047;92
WireConnection;699;0;698;1
WireConnection;699;1;696;0
WireConnection;699;2;697;0
WireConnection;810;0;792;0
WireConnection;810;1;803;0
WireConnection;811;0;798;1
WireConnection;811;1;812;0
WireConnection;823;1;826;0
WireConnection;764;0;1048;976
WireConnection;651;0;1047;90
WireConnection;809;0;810;0
WireConnection;809;1;811;0
WireConnection;809;2;902;0
WireConnection;954;0;955;0
WireConnection;954;1;819;3
WireConnection;954;2;956;0
WireConnection;861;0;857;0
WireConnection;656;0;1047;91
WireConnection;836;0;843;0
WireConnection;836;1;834;0
WireConnection;836;2;823;1
WireConnection;704;0;699;0
WireConnection;863;0;713;0
WireConnection;863;1;861;0
WireConnection;840;0;836;0
WireConnection;820;0;809;0
WireConnection;820;1;954;0
WireConnection;1069;0;1064;0
WireConnection;814;1;815;0
WireConnection;814;0;820;0
WireConnection;82;0;85;0
WireConnection;82;1;83;0
WireConnection;82;2;84;0
WireConnection;940;37;765;0
WireConnection;940;35;659;0
WireConnection;940;36;660;0
WireConnection;940;30;711;0
WireConnection;940;31;712;0
WireConnection;940;32;863;0
WireConnection;851;0;850;0
WireConnection;1056;83;705;0
WireConnection;1056;82;689;0
WireConnection;1056;62;682;0
WireConnection;1056;63;683;0
WireConnection;1056;65;684;0
WireConnection;1056;73;82;0
WireConnection;1056;74;686;0
WireConnection;1056;75;690;0
WireConnection;1049;0;844;0
WireConnection;1049;1;814;0
WireConnection;467;0;940;0
WireConnection;1106;39;1089;0
WireConnection;813;0;1048;0
WireConnection;813;1;814;0
WireConnection;671;0;1106;0
WireConnection;961;0;960;0
WireConnection;961;1;851;0
WireConnection;961;2;959;0
WireConnection;91;0;1056;80
WireConnection;1050;0;844;0
WireConnection;1050;1;1049;0
WireConnection;69;0;1047;0
WireConnection;785;1;786;0
WireConnection;785;0;468;0
WireConnection;845;0;813;0
WireConnection;845;1;1050;0
WireConnection;845;2;961;0
WireConnection;855;1;813;0
WireConnection;855;0;845;0
WireConnection;94;0;92;0
WireConnection;94;1;93;0
WireConnection;94;2;785;0
WireConnection;734;1;735;0
WireConnection;734;0;672;0
WireConnection;818;0;816;1
WireConnection;818;1;816;4
WireConnection;1066;0;1108;0
WireConnection;505;0;470;0
WireConnection;913;0;909;0
WireConnection;950;0;920;2
WireConnection;817;0;818;0
WireConnection;817;1;730;0
WireConnection;1108;2;1064;0
WireConnection;1068;0;1066;0
WireConnection;1068;1;1066;1
WireConnection;729;0;1048;719
WireConnection;729;1;94;0
WireConnection;729;2;734;0
WireConnection;1085;0;1068;0
WireConnection;1085;1;1066;2
WireConnection;1111;0;1085;0
WireConnection;1111;2;672;0
WireConnection;1111;3;1112;0
WireConnection;1111;4;1112;0
WireConnection;730;0;731;0
WireConnection;730;1;505;0
WireConnection;730;2;734;0
WireConnection;728;0;1048;719
WireConnection;728;1;855;0
WireConnection;728;2;734;0
WireConnection;1;0;26;0
WireConnection;1;1;28;0
WireConnection;1;2;1048;977
WireConnection;1;3;30;0
WireConnection;1;4;31;0
WireConnection;1;5;32;0
WireConnection;949;0;920;1
WireConnection;964;0;963;0
WireConnection;964;1;965;0
WireConnection;951;0;949;0
WireConnection;951;1;950;0
WireConnection;0;0;27;0
WireConnection;0;2;728;0
WireConnection;0;13;729;0
ASEEND*/
//CHKSM=B5FD006A34BD65121DB86A4A2B7097074E795227