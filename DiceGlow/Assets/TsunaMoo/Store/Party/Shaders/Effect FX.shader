// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Effect FX"
{
	Properties
	{
		[HideInInspector]shader_is_using_thry_editor("", Float) = 0
		[HideInInspector]shader_master_label("<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}}", Float) = 0
		[HideInInspector]shader_properties_label_file("TsunaMooLabels", Float) = 0
		[HideInInspector]m_start_Main("Main", Float) = 0
		[NoScaleOffset][SingleLineTexture]_MainTex("Albedo Map--{reference_property:_Color}", 2D) = "white" {}
		[HideInInspector]_Color("Albedo Color", Color) = (1,1,1,1)
		[NoScaleOffset][SingleLineTexture]_MetallicGlossMap("Metallic Map--{reference_property:_Metallic}", 2D) = "white" {}
		[HideInInspector]_Metallic("Metallic Slider", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0
		_AntiAliasingVarianceSm("Anti Aliasing Variance", Range( 0 , 5)) = 5
		_AntiAliasingThresholdSm("Anti Aliasing Threshold", Range( 0 , 1)) = 0.01
		[Toggle(_NormalMap_ON)] _UseNormalMap("Enable Normal Map", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map--{reference_property:_NormalMapSlider,condition_show:{type:PROPERTY_BOOL,data:_UseNormalMap==1}}", 2D) = "bump" {}
		[HideInInspector]_NormalMapSlider("Normal Map Slider", Range( 0 , 5)) = 1
		[HideInInspector][HDR]_EmissionColor("Emission Color", Color) = (0,0,0,1)
		[HideInInspector][HDR][hide_in_inspector]_EffectColor("Effect Color", Color) = (0,0,0,1)
		[NoScaleOffset][SingleLineTexture]_EmissionMap("Emission Map--{reference_property:_EmissionColor}", 2D) = "white" {}
		[Vector2][Space]_Tiling("Tiling", Vector) = (1,1,0,0)
		[Vector2]_Offset("Offset", Vector) = (0,0,0,0)
		[ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_UVMain("UV", Int) = 0
		[Vector2]_MainScroll("Scroll", Vector) = (0,0,0,0)
		_HueModifier("Hue Modifier", Range( -0.5 , 0.5)) = 0
		_HueTime("Hue Time", Range( -0.5 , 0.5)) = 0
		[HideInInspector]m_end_Main("Main", Float) = 0
		[HideInInspector]m_start_eff("Emission Effect--{reference_property:_EnableEmissionEff}", Float) = 0
		[HideInInspector][Toggle(_EmissionEff_ON)] _EnableEmissionEff("Enable Emission Effect", Float) = 0
		[NoScaleOffset]_EffectAlbedoMap("Effect Albedo Map--{reference_property:_EffectColor,reference_properties:[_TilingEff,_OffsetEff,_ScrollEff,_UVEff]}", 2D) = "white" {}
		_ShiftSpeed("Shift Speed", Range( -5 , 5)) = 1
		[HideInInspector][Vector2]_TilingEff("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_OffsetEff("Offset", Vector) = (0,0,0,0)
		[HideInInspector][Vector2]_ScrollEff("Scroll", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_UVEff("UV", Int) = 0
		[NoScaleOffset][SingleLineTexture]_EffectMask("Effect Mask Map--{reference_properties:[_TilingEffMask,_OffsetEffMask,_ScrollEffMask,_UVEffMask]}", 2D) = "white" {}
		[ToggleUI]_UseEmissionMapasMask("Use Emission Map as Mask", Float) = 0
		[HideInInspector][Vector2]_TilingEffMask("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_OffsetEffMask("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_UVEffMask("UV", Int) = 0
		[HideInInspector][Vector2]_ScrollEffMask("Scroll", Vector) = (0,0,0,0)
		[HideInInspector]m_end_eff("Emission Effect", Float) = 0
		[HideInInspector]m_start_rim("Rimlight--{reference_property:_EnableRimlight}", Float) = 0
		[HideInInspector][ToggleUI]_EnableRimlight("Enable Rimlight", Float) = 0
		[HDR]_RimColor("Color", Color) = (0,0,0,1)
		_Bias("Bias", Range( 0 , 10)) = 0
		_Scale("Scale", Range( 0 , 10)) = 1
		_Power("Power", Range( 0 , 10)) = 1
		_AntiAliasingVariance("Anti Aliasing Variance", Range( 0 , 5)) = 5
		_AntiAliasingThreshold("Anti Aliasing Threshold", Range( 0 , 1)) = 1
		[HideInInspector]m_end_rim("Rimlight", Float) = 0
		[HideInInspector]m_start_engine("Engine", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull", Float) = 2
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("ZTest", Float) = 4
		[Enum(Off,0,On,1)]_ZWrite("ZWrite", Int) = 1
		[HideInInspector]LightmapFlags("LightmapFlags", Float) = 0
		[HideInInspector]DSGI("DSGI", Float) = 0
		[HideInInspector]Instancing("Instancing", Float) = 1
		[HideInInspector]m_end_engine("Engine", Float) = 0
		[HideInInspector]footer_discord("", Float) = 0
		[HideInInspector]footer_booth("", Float) = 0
		[HideInInspector]footer_github("", Float) = 0
		[HideInInspector]footer_patreon("", Float) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_Cull]
		ZWrite [_ZWrite]
		ZTest [_ZTest]
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		#pragma shader_feature_local _NormalMap_ON
		#pragma shader_feature_local _EmissionEff_ON
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#endif//ASE Sampling Macros

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
			float3 worldPos;
			half3 worldNormal;
			INTERNAL_DATA
		};

		uniform half m_start_rim;
		uniform half m_start_eff;
		uniform half m_end_engine;
		uniform half m_end_Main;
		uniform half shader_properties_label_file;
		uniform half _Cull;
		uniform half footer_patreon;
		uniform half LightmapFlags;
		uniform half footer_discord;
		uniform half m_start_Main;
		uniform half _ZTest;
		uniform half footer_booth;
		uniform half m_start_engine;
		uniform int _ZWrite;
		uniform half DSGI;
		uniform half shader_is_using_thry_editor;
		uniform half shader_master_label;
		uniform half m_end_eff;
		uniform half m_end_rim;
		uniform half Instancing;
		uniform half footer_github;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform half2 _MainScroll;
		uniform half2 _Offset;
		uniform half2 _Tiling;
		uniform int _UVMain;
		SamplerState sampler_linear_repeat;
		uniform half _NormalMapSlider;
		uniform half4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _HueModifier;
		uniform half _HueTime;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionMap);
		uniform half4 _EmissionColor;
		uniform half4 _EffectColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EffectAlbedoMap);
		uniform half2 _ScrollEff;
		uniform half2 _OffsetEff;
		uniform half2 _TilingEff;
		uniform int _UVEff;
		uniform half _ShiftSpeed;
		uniform half _UseEmissionMapasMask;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EffectMask);
		uniform half2 _ScrollEffMask;
		uniform half2 _OffsetEffMask;
		uniform half2 _TilingEffMask;
		uniform int _UVEffMask;
		uniform half _EnableRimlight;
		uniform half _Bias;
		uniform half _Scale;
		uniform half _Power;
		uniform half4 _RimColor;
		uniform half _AntiAliasingVariance;
		uniform half _AntiAliasingThreshold;
		uniform half _Metallic;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
		uniform half _Glossiness;
		uniform half _AntiAliasingVarianceSm;
		uniform half _AntiAliasingThresholdSm;


		half2 UVSelector9_g306( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
		{
			float2 UvSet[7];
			UvSet[0] = UV0;
			UvSet[1] = UV1;
			UvSet[2] = UV2;
			UvSet[3] = UV3;
			UvSet[4] = UV4;
			UvSet[5] = UV5;
			UvSet[6] = UV6;
			return UvSet[Set];
		}


		half3 HSVToRGB( half3 c )
		{
			half4 K = half4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			half3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		half3 RGBToHSV(half3 c)
		{
			half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			half4 p = lerp( half4( c.bg, K.wz ), half4( c.gb, K.xy ), step( c.b, c.g ) );
			half4 q = lerp( half4( p.xyw, c.r ), half4( c.r, p.yzx ), step( p.x, c.r ) );
			half d = q.x - min( q.w, q.y );
			half e = 1.0e-10;
			return half3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		half2 UVSelector9_g308( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
		{
			float2 UvSet[7];
			UvSet[0] = UV0;
			UvSet[1] = UV1;
			UvSet[2] = UV2;
			UvSet[3] = UV3;
			UvSet[4] = UV4;
			UvSet[5] = UV5;
			UvSet[6] = UV6;
			return UvSet[Set];
		}


		half2 UVSelector9_g309( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
		{
			float2 UvSet[7];
			UvSet[0] = UV0;
			UvSet[1] = UV1;
			UvSet[2] = UV2;
			UvSet[3] = UV3;
			UvSet[4] = UV4;
			UvSet[5] = UV5;
			UvSet[6] = UV6;
			return UvSet[Set];
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half mulTime418 = _Time.y * _MainScroll.x;
			half mulTime415 = _Time.y * _MainScroll.y;
			half2 appendResult420 = (half2(mulTime418 , mulTime415));
			int Set9_g306 = _UVMain;
			half2 UV09_g306 = i.uv_texcoord;
			half2 UV19_g306 = i.uv2_texcoord2;
			half2 UV29_g306 = i.uv3_texcoord3;
			half2 UV39_g306 = i.uv4_texcoord4;
			float3 ase_worldPos = i.worldPos;
			half2 appendResult40_g306 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g306 = appendResult40_g306;
			half2 appendResult41_g306 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g306 = appendResult41_g306;
			half2 appendResult42_g306 = (half2(0.0 , 0.0));
			half2 UV69_g306 = appendResult42_g306;
			half2 localUVSelector9_g306 = UVSelector9_g306( Set9_g306 , UV09_g306 , UV19_g306 , UV29_g306 , UV39_g306 , UV49_g306 , UV59_g306 , UV69_g306 );
			half2 MainUV339 = ( ( appendResult420 + _Offset ) + ( _Tiling * localUVSelector9_g306 ) );
			#ifdef _NormalMap_ON
				half3 staticSwitch1079 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_linear_repeat, MainUV339 ), _NormalMapSlider );
			#else
				half3 staticSwitch1079 = half3(0,0,1);
			#endif
			half3 NormalMap336 = staticSwitch1079;
			o.Normal = NormalMap336;
			half4 Albedo351 = ( _Color * SAMPLE_TEXTURE2D( _MainTex, sampler_linear_repeat, MainUV339 ) );
			half3 hsvTorgb1103 = RGBToHSV( Albedo351.rgb );
			half mulTime1113 = _Time.y * _HueTime;
			half3 hsvTorgb1104 = HSVToRGB( half3(( hsvTorgb1103.x + _HueModifier + mulTime1113 ),hsvTorgb1103.y,hsvTorgb1103.z) );
			o.Albedo = hsvTorgb1104;
			half4 EmissionMap354 = ( SAMPLE_TEXTURE2D( _EmissionMap, sampler_linear_repeat, MainUV339 ) * _EmissionColor );
			half mulTime571 = _Time.y * _ScrollEff.x;
			half mulTime572 = _Time.y * _ScrollEff.y;
			half2 appendResult573 = (half2(mulTime571 , mulTime572));
			int Set9_g308 = _UVEff;
			half2 UV09_g308 = i.uv_texcoord;
			half2 UV19_g308 = i.uv2_texcoord2;
			half2 UV29_g308 = i.uv3_texcoord3;
			half2 UV39_g308 = i.uv4_texcoord4;
			half2 appendResult40_g308 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g308 = appendResult40_g308;
			half2 appendResult41_g308 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g308 = appendResult41_g308;
			half2 appendResult42_g308 = (half2(0.0 , 0.0));
			half2 UV69_g308 = appendResult42_g308;
			half2 localUVSelector9_g308 = UVSelector9_g308( Set9_g308 , UV09_g308 , UV19_g308 , UV29_g308 , UV39_g308 , UV49_g308 , UV59_g308 , UV69_g308 );
			half3 hsvTorgb301 = RGBToHSV( ( _EffectColor * SAMPLE_TEXTURE2D( _EffectAlbedoMap, sampler_linear_repeat, ( ( appendResult573 + _OffsetEff ) + ( _TilingEff * localUVSelector9_g308 ) ) ) ).rgb );
			half mulTime297 = _Time.y * _ShiftSpeed;
			half3 hsvTorgb300 = HSVToRGB( half3(( hsvTorgb301.x + mulTime297 ),hsvTorgb301.y,hsvTorgb301.z) );
			half mulTime566 = _Time.y * _ScrollEffMask.x;
			half mulTime567 = _Time.y * _ScrollEffMask.y;
			half2 appendResult568 = (half2(mulTime566 , mulTime567));
			int Set9_g309 = _UVEffMask;
			half2 UV09_g309 = i.uv_texcoord;
			half2 UV19_g309 = i.uv2_texcoord2;
			half2 UV29_g309 = i.uv3_texcoord3;
			half2 UV39_g309 = i.uv4_texcoord4;
			half2 appendResult40_g309 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g309 = appendResult40_g309;
			half2 appendResult41_g309 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g309 = appendResult41_g309;
			half2 appendResult42_g309 = (half2(0.0 , 0.0));
			half2 UV69_g309 = appendResult42_g309;
			half2 localUVSelector9_g309 = UVSelector9_g309( Set9_g309 , UV09_g309 , UV19_g309 , UV29_g309 , UV39_g309 , UV49_g309 , UV59_g309 , UV69_g309 );
			half4 ifLocalVar310 = 0;
			if( _UseEmissionMapasMask >= 1.0 )
				ifLocalVar310 = EmissionMap354;
			else
				ifLocalVar310 = SAMPLE_TEXTURE2D( _EffectMask, sampler_linear_repeat, ( ( appendResult568 + _OffsetEffMask ) + ( _TilingEffMask * localUVSelector9_g309 ) ) );
			half4 lerpResult307 = lerp( EmissionMap354 , half4( hsvTorgb300 , 0.0 ) , ifLocalVar310);
			#ifdef _EmissionEff_ON
				half4 staticSwitch1076 = ( lerpResult307 * _EffectColor.a );
			#else
				half4 staticSwitch1076 = EmissionMap354;
			#endif
			half4 EffectMap359 = staticSwitch1076;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 newWorldNormal402 = normalize( (WorldNormalVector( i , NormalMap336 )) );
			half fresnelNdotV389 = dot( normalize( newWorldNormal402 ), ase_worldViewDir );
			half fresnelNode389 = ( _Bias + _Scale * pow( max( 1.0 - fresnelNdotV389 , 0.0001 ), _Power ) );
			half clampResult390 = clamp( fresnelNode389 , 0.0 , 1.0 );
			half3 temp_output_1_0_g314 = newWorldNormal402;
			half3 temp_output_4_0_g314 = ddx( temp_output_1_0_g314 );
			half dotResult6_g314 = dot( temp_output_4_0_g314 , temp_output_4_0_g314 );
			half3 temp_output_5_0_g314 = ddy( temp_output_1_0_g314 );
			half dotResult8_g314 = dot( temp_output_5_0_g314 , temp_output_5_0_g314 );
			half4 lerpResult424 = lerp( ( clampResult390 * _RimColor ) , float4( 0,0,0,0 ) , sqrt( sqrt( saturate( min( ( ( ( dotResult6_g314 + dotResult8_g314 ) * _AntiAliasingVariance ) * 2.0 ) , _AntiAliasingThreshold ) ) ) ));
			half4 ifLocalVar1092 = 0;
			if( _EnableRimlight == 1.0 )
				ifLocalVar1092 = ( lerpResult424 * _RimColor.a );
			half4 Rimlight395 = ifLocalVar1092;
			half4 EmissionFinal846 = ( EffectMap359 + Rimlight395 );
			half3 hsvTorgb1105 = RGBToHSV( EmissionFinal846.rgb );
			half3 hsvTorgb1106 = HSVToRGB( half3(( hsvTorgb1105.x + _HueModifier + mulTime1113 ),hsvTorgb1105.y,hsvTorgb1105.z) );
			o.Emission = hsvTorgb1106;
			half4 tex2DNode59 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_linear_repeat, MainUV339 );
			half3 ase_worldNormal = WorldNormalVector( i, half3( 0, 0, 1 ) );
			half3 temp_output_1_0_g320 = ase_worldNormal;
			half3 temp_output_4_0_g320 = ddx( temp_output_1_0_g320 );
			half dotResult6_g320 = dot( temp_output_4_0_g320 , temp_output_4_0_g320 );
			half3 temp_output_5_0_g320 = ddy( temp_output_1_0_g320 );
			half dotResult8_g320 = dot( temp_output_5_0_g320 , temp_output_5_0_g320 );
			half lerpResult443 = lerp( _Glossiness , 0.0 , sqrt( sqrt( saturate( min( ( ( ( dotResult6_g320 + dotResult8_g320 ) * _AntiAliasingVarianceSm ) * 2.0 ) , _AntiAliasingThresholdSm ) ) ) ));
			half2 appendResult346 = (half2(( _Metallic * tex2DNode59 ).r , ( lerpResult443 * tex2DNode59.a )));
			half2 MetallicSmoothness345 = appendResult346;
			half2 break348 = MetallicSmoothness345;
			o.Metallic = break348;
			o.Smoothness = break348.y;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xbox360 xboxone xboxseries ps4 playstation psp2 n3ds wiiu switch 
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
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
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
	CustomEditor "Thry.ShaderEditor"
}
/*ASEBEGIN
Version=18935
89.6;132.8;2232;1533;3630.051;7882.302;4.891777;True;False
Node;AmplifyShaderEditor.CommentaryNode;1006;228.096,-5042.061;Inherit;False;3385.644;2894.609;;4;349;357;350;353;PBR;0,1,0.5443456,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;353;309.5103,-4822.507;Inherit;False;3151.7;441.8367;;16;93;420;419;417;415;418;327;53;351;92;52;339;293;428;51;645;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;417;338.2161,-4728.423;Inherit;False;Property;_MainScroll;Scroll;20;0;Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;418;609.2158,-4742.423;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;415;607.2158,-4659.423;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;420;854.7159,-4749.923;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;93;843.0436,-4594.829;Inherit;False;Property;_Offset;Offset;18;0;Create;True;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;293;1110.807,-4492.527;Inherit;False;Property;_UVMain;UV;19;0;Create;False;0;4;UV0;0;UV1;1;UV2;2;UV3;3;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;419;1023.715,-4671.173;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;92;1198.033,-4756.578;Inherit;False;Property;_Tiling;Tiling;17;0;Create;True;0;0;0;False;2;Vector2;Space;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;1007;152.4413,-1974.776;Inherit;False;3748.471;1927.719;;2;393;477;Effects;1,0,0.3941193,1;0;0
Node;AmplifyShaderEditor.FunctionNode;645;1516.386,-4743.275;Inherit;False;UV Selector;-1;;306;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerStateNode;327;1846.941,-4672.258;Inherit;False;0;0;0;1;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.CommentaryNode;477;296.0154,-1592.815;Inherit;False;3370.17;750.7358;;40;359;307;355;300;310;302;356;358;311;301;297;209;433;309;298;308;258;412;569;432;568;414;223;566;567;574;264;565;573;263;571;572;570;413;262;261;647;646;1057;1076;Emission Overlay;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;350;322.4894,-2787.082;Inherit;False;1304.338;547.112;;7;55;56;54;343;336;430;1079;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;570;373.2465,-1285.321;Inherit;False;Property;_ScrollEff;Scroll;30;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;339;1898.818,-4527.127;Inherit;False;MainUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;428;2089.254,-4624.942;Inherit;False;Sampler;-1;True;1;0;SAMPLERSTATE;0,0;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.RangedFloatNode;54;359.015,-2593.066;Inherit;False;Property;_NormalMapSlider;Normal Map Slider;13;1;[HideInInspector];Create;False;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;571;629.2467,-1304.321;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;343;456.7505,-2504.824;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;430;454.6226,-2422.273;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SimpleTimeNode;572;625.0706,-1221.321;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;565;633.7377,-1489.576;Inherit;False;Property;_ScrollEffMask;Scroll;37;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;56;826.4747,-2420.066;Inherit;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;55;667.8158,-2632.708;Inherit;True;Property;_BumpMap;Normal Map--{reference_property:_NormalMapSlider,condition_show:{type:PROPERTY_BOOL,data:_UseNormalMap==1}};12;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;263;850.6425,-1155.594;Inherit;False;Property;_OffsetEff;Offset;29;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;573;832.7468,-1288.821;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;574;1025.746,-1181.071;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1079;1026.552,-2628.31;Inherit;False;Property;_UseNormalMap;Enable Normal Map;11;0;Create;False;0;0;0;False;0;False;0;0;0;True;_NormalMap_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;264;857.6425,-978.2061;Inherit;False;Property;_TilingEff;Tiling;28;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;223;1024.645,-1065.912;Inherit;False;Property;_UVEff;UV;31;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;Option5;4;Option6;5;Option7;6;Option8;7;Option9;8;Option10;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleTimeNode;566;907.5134,-1500.8;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;567;905.5134,-1417.801;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;357;323.1516,-3421.313;Inherit;False;1224.44;469.0579;;6;354;50;109;342;233;431;Emission Base;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;430.2509,-3216.043;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;1281.888,-2625.375;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;414;1147.351,-1371.141;Inherit;False;Property;_OffsetEffMask;Offset;35;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;393;304.8026,-659.6858;Inherit;False;2554.657;526.206;;20;395;424;421;422;391;392;390;389;402;387;388;386;406;442;446;397;398;1058;1092;1093;Rimlight;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;430.1315,-3305.271;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;568;1153.013,-1508.3;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;646;1192.539,-1114.024;Inherit;False;UV Selector;-1;;308;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;432;1219.34,-947.6233;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SamplerNode;233;665.1648,-3374.1;Inherit;True;Property;_EmissionMap;Emission Map--{reference_property:_EmissionColor};16;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;569;1325.012,-1399.551;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;413;1319.023,-1541.207;Inherit;False;Property;_TilingEffMask;Tiling;34;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;412;1234.122,-1222.59;Inherit;False;Property;_UVEffMask;UV;36;1;[HideInInspector];Create;False;0;4;UV0;0;UV1;1;UV2;2;UV3;3;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;258;1462.555,-1149.228;Inherit;True;Property;_EffectAlbedoMap;Effect Albedo Map--{reference_property:_EffectColor,reference_properties:[_TilingEff,_OffsetEff,_ScrollEff,_UVEff]};26;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;c258fb960e534b54e9e6e463bc4369b1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;406;325.0794,-591.1275;Inherit;False;336;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;308;1534.536,-1324.684;Inherit;False;Property;_EffectColor;Effect Color;15;2;[HideInInspector];[HDR];Create;False;0;0;0;False;1;hide_in_inspector;False;0,0,0,1;0.7169812,0.4633322,0.4633322,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;782.4487,-3156.41;Inherit;False;Property;_EmissionColor;Emission Color;14;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;0.7169812,0.4633322,0.4633322,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;386;430.8954,-330.1966;Inherit;False;Property;_Scale;Scale;43;0;Create;True;0;0;0;False;0;False;1;0.48;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;388;428.0912,-423.7188;Inherit;False;Property;_Bias;Bias;42;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;298;1793.701,-1085.211;Inherit;False;Property;_ShiftSpeed;Shift Speed;27;0;Create;True;0;0;0;False;0;False;1;0.25;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;387;431.8955,-238.1965;Inherit;False;Property;_Power;Power;44;0;Create;True;0;0;0;False;0;False;1;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;647;1524.016,-1502.703;Inherit;False;UV Selector;-1;;309;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;433;1833.265,-1472.058;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;1851.345,-1234.727;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;1089.171,-3223.919;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;402;518.451,-591.129;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FresnelNode;389;769.3622,-519.2387;Inherit;True;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;354;1276.639,-3232.055;Inherit;False;EmissionMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;297;2152.187,-993.9658;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;209;2038.336,-1373.991;Inherit;True;Property;_EffectMask;Effect Mask Map--{reference_properties:[_TilingEffMask,_OffsetEffMask,_ScrollEffMask,_UVEffMask]};32;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;301;2127.785,-1154.379;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;421;1348.342,-254.3114;Inherit;False;Property;_AntiAliasingThreshold;Anti Aliasing Threshold;46;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;442;1527.527,-529.012;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;356;2351.144,-1290.219;Inherit;False;354;EmissionMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;390;1086.811,-515.2386;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;302;2393.586,-1181.879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;311;2252.03,-1481.086;Inherit;False;Property;_UseEmissionMapasMask;Use Emission Map as Mask;33;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;358;2524.146,-1303.983;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;391;1068.949,-339.2581;Inherit;False;Property;_RimColor;Color;41;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;8.47419,0.1331024,0.4436749,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;422;1348.652,-342.4205;Inherit;False;Property;_AntiAliasingVariance;Anti Aliasing Variance;45;0;Create;True;0;0;0;False;0;False;5;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;355;2553.327,-1477.893;Inherit;False;354;EmissionMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.HSVToRGBNode;300;2543.586,-1133.879;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ConditionalIfNode;310;2572.032,-1358.244;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;1340.66,-506.654;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;446;1654.896,-336.5821;Inherit;False;GSAA;-1;;314;a3c5c6cf9d1dd744589a5e3146f5a3a1;0;3;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;307;2799.826,-1323.584;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;424;2068.485,-504.2038;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;2244.836,-458.0235;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1057;3035.496,-1268.906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1093;2198.263,-586.2712;Inherit;False;Property;_EnableRimlight;Enable Rimlight;40;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;349;320.6011,-4220.241;Inherit;False;1504.473;670.9171;;14;345;346;62;63;443;59;61;60;344;447;429;440;437;439;Metallic Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1076;3192.45,-1476.977;Inherit;False;Property;_EnableEmissionEff;Enable Emission Effect;25;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_EmissionEff_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1092;2410.265,-501.4291;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1008;3925.017,-6644.813;Inherit;False;3192.067;1473.515;;4;476;830;1112;1113;Final Data;1,0.8339342,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;3449.899,-1439.646;Inherit;False;EffectMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;395;2621.88,-464.5416;Inherit;False;Rimlight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;437;365.415,-3740.733;Inherit;False;Property;_AntiAliasingVarianceSm;Anti Aliasing Variance;9;0;Create;False;0;0;0;False;0;False;5;0.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;830;4120.622,-6391.199;Inherit;False;1160.526;969.9855;Comment;4;846;843;841;842;Layers;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;439;364.1954,-3652.388;Inherit;False;Property;_AntiAliasingThresholdSm;Anti Aliasing Threshold;10;0;Create;False;0;0;0;False;0;False;0.01;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;440;368.8724,-3984.427;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;51;2343.257,-4594.248;Inherit;True;Property;_MainTex;Albedo Map--{reference_property:_Color};4;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;365.0643,-3835.484;Inherit;False;Property;_Glossiness;Smoothness;8;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;842;4173.248,-5896.038;Inherit;False;395;Rimlight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;841;4167.275,-5975.464;Inherit;False;359;EffectMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;53;2662.773,-4768.707;Inherit;False;Property;_Color;Albedo Color;5;1;[HideInInspector];Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;429;366.946,-4068.557;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.FunctionNode;447;665.1736,-3849.251;Inherit;False;GSAA;-1;;320;a3c5c6cf9d1dd744589a5e3146f5a3a1;0;3;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;344;368.6843,-4150.683;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;443;1094.463,-3833.62;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;2901.708,-4669.852;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;843;4429.942,-5956.953;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;624.3825,-4069.384;Inherit;True;Property;_MetallicGlossMap;Metallic Map--{reference_property:_Metallic};6;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;642.9706,-4151.756;Inherit;False;Property;_Metallic;Metallic Slider;7;1;[HideInInspector];Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;1256.055,-3922.359;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;846;4646.605,-5988.646;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;351;3096.972,-4672.054;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;476;5401.255,-6396.753;Inherit;False;1433.389;997.3186;;13;478;338;352;348;847;347;1103;1104;1105;1106;1107;1110;1111;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;1193.223,-4035.894;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;346;1394.461,-4002.139;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1112;5695.171,-6479.116;Inherit;False;Property;_HueTime;Hue Time;22;0;Create;True;0;0;0;False;0;False;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;847;5583.18,-6136.138;Inherit;False;846;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;352;5596.542,-6312.124;Inherit;False;351;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1005;263.7675,-6628.079;Inherit;False;2666.795;1377.973;;2;458;77;Unity;0,0.1185064,1,1;0;0
Node;AmplifyShaderEditor.RGBToHSVNode;1105;5824.811,-6104.982;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;1553.925,-4005.035;Inherit;False;MetallicSmoothness;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1113;5984.4,-6503.395;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1107;5773.811,-6352.982;Inherit;False;Property;_HueModifier;Hue Modifier;21;0;Create;True;0;0;0;False;0;False;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;1103;5823.811,-6266.982;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;347;5449.268,-6004.473;Inherit;False;345;MetallicSmoothness;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1110;6099.811,-6309.482;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;458;443.7283,-6343.615;Inherit;False;455.9268;793.7084;;8;479;480;260;575;576;89;88;90;Engine;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;77;2101.973,-6316.941;Inherit;False;670.9143;415.154;;9;86;101;82;85;83;84;81;79;78;ThryEditor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1111;6108.811,-6139.482;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;575;464.4715,-6293.193;Inherit;False;Property;m_start_engine;Engine;48;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;479;513.6707,-6029.546;Inherit;False;Property;_ZWrite;ZWrite;51;1;[Enum];Create;True;0;2;Off;0;On;1;0;True;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;510.4168,-5764.929;Inherit;False;Property;DSGI;DSGI;53;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;2143.377,-6256.582;Inherit;False;Property;shader_is_using_thry_editor;;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;2458.035,-6033.242;Inherit;False;Property;footer_github;;58;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;3463.682,-961.3279;Inherit;False;Property;m_end_eff;Emission Effect;38;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;397;2707.441,-235.7794;Inherit;False;Property;m_end_rim;Rimlight;47;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;515.597,-5666.476;Inherit;False;Property;Instancing;Instancing;54;1;[HideInInspector];Create;False;0;0;0;True;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;6201.269,-5930.539;Inherit;False;336;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;1106;6267.811,-6190.982;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;79;2318.719,-6256.294;Inherit;False;Property;shader_master_label;<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}};1;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;2138.23,-6032.16;Inherit;False;Property;footer_booth;;57;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;260;509.6126,-6197.18;Inherit;False;Property;_Cull;Cull;49;0;Create;True;0;0;0;True;1;Enum(UnityEngine.Rendering.CullMode);False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;480;510.5096,-6115.655;Inherit;False;Property;_ZTest;ZTest;50;0;Create;True;0;0;0;True;1;Enum(UnityEngine.Rendering.CompareFunction);False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;2280.25,-6144.64;Inherit;False;Property;m_start_Main;Main;3;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;2606.983,-6033.262;Inherit;False;Property;footer_discord;;56;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;508.597,-5847.476;Inherit;False;Property;LightmapFlags;LightmapFlags;52;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;2290.085,-6030.526;Inherit;False;Property;footer_patreon;;59;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;2508.608,-6260.279;Inherit;False;Property;shader_properties_label_file;TsunaMooLabels;2;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;2135.274,-6146.626;Inherit;False;Property;m_end_Main;Main;23;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;1104;6263.811,-6340.982;Inherit;False;3;0;FLOAT;0.79;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;576;762.4714,-5656.193;Inherit;False;Property;m_end_engine;Engine;55;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;261;305.9659,-1526.734;Inherit;False;Property;m_start_eff;Emission Effect--{reference_property:_EnableEmissionEff};24;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;398;767.1793,-232.4575;Inherit;False;Property;m_start_rim;Rimlight--{reference_property:_EnableRimlight};39;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;348;5704.018,-5979.456;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;478;6596.363,-6171.372;Half;False;True;-1;4;Thry.ShaderEditor;0;0;Standard;TsunaMoo/Effect FX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;True;479;0;True;480;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;9;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;nomrt;True;True;True;True;0;False;-1;False;0;True;449;255;True;453;255;True;454;0;True;451;0;True;452;0;True;455;0;True;456;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;260;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;418;0;417;1
WireConnection;415;0;417;2
WireConnection;420;0;418;0
WireConnection;420;1;415;0
WireConnection;419;0;420;0
WireConnection;419;1;93;0
WireConnection;645;15;293;0
WireConnection;645;16;92;0
WireConnection;645;17;419;0
WireConnection;339;0;645;0
WireConnection;428;0;327;0
WireConnection;571;0;570;1
WireConnection;572;0;570;2
WireConnection;55;1;343;0
WireConnection;55;5;54;0
WireConnection;55;7;430;0
WireConnection;573;0;571;0
WireConnection;573;1;572;0
WireConnection;574;0;573;0
WireConnection;574;1;263;0
WireConnection;1079;1;56;0
WireConnection;1079;0;55;0
WireConnection;566;0;565;1
WireConnection;567;0;565;2
WireConnection;336;0;1079;0
WireConnection;568;0;566;0
WireConnection;568;1;567;0
WireConnection;646;15;223;0
WireConnection;646;16;264;0
WireConnection;646;17;574;0
WireConnection;233;1;342;0
WireConnection;233;7;431;0
WireConnection;569;0;568;0
WireConnection;569;1;414;0
WireConnection;258;1;646;0
WireConnection;258;7;432;0
WireConnection;647;15;412;0
WireConnection;647;16;413;0
WireConnection;647;17;569;0
WireConnection;309;0;308;0
WireConnection;309;1;258;0
WireConnection;109;0;233;0
WireConnection;109;1;50;0
WireConnection;402;0;406;0
WireConnection;389;0;402;0
WireConnection;389;1;388;0
WireConnection;389;2;386;0
WireConnection;389;3;387;0
WireConnection;354;0;109;0
WireConnection;297;0;298;0
WireConnection;209;1;647;0
WireConnection;209;7;433;0
WireConnection;301;0;309;0
WireConnection;442;0;402;0
WireConnection;390;0;389;0
WireConnection;302;0;301;1
WireConnection;302;1;297;0
WireConnection;358;0;209;0
WireConnection;300;0;302;0
WireConnection;300;1;301;2
WireConnection;300;2;301;3
WireConnection;310;0;311;0
WireConnection;310;2;356;0
WireConnection;310;3;356;0
WireConnection;310;4;358;0
WireConnection;392;0;390;0
WireConnection;392;1;391;0
WireConnection;446;1;442;0
WireConnection;446;10;422;0
WireConnection;446;12;421;0
WireConnection;307;0;355;0
WireConnection;307;1;300;0
WireConnection;307;2;310;0
WireConnection;424;0;392;0
WireConnection;424;2;446;0
WireConnection;1058;0;424;0
WireConnection;1058;1;391;4
WireConnection;1057;0;307;0
WireConnection;1057;1;308;4
WireConnection;1076;1;355;0
WireConnection;1076;0;1057;0
WireConnection;1092;0;1093;0
WireConnection;1092;3;1058;0
WireConnection;359;0;1076;0
WireConnection;395;0;1092;0
WireConnection;51;1;339;0
WireConnection;51;7;428;0
WireConnection;447;1;440;0
WireConnection;447;10;437;0
WireConnection;447;12;439;0
WireConnection;443;0;60;0
WireConnection;443;2;447;0
WireConnection;52;0;53;0
WireConnection;52;1;51;0
WireConnection;843;0;841;0
WireConnection;843;1;842;0
WireConnection;59;1;344;0
WireConnection;59;7;429;0
WireConnection;63;0;443;0
WireConnection;63;1;59;4
WireConnection;846;0;843;0
WireConnection;351;0;52;0
WireConnection;62;0;61;0
WireConnection;62;1;59;0
WireConnection;346;0;62;0
WireConnection;346;1;63;0
WireConnection;1105;0;847;0
WireConnection;345;0;346;0
WireConnection;1113;0;1112;0
WireConnection;1103;0;352;0
WireConnection;1110;0;1103;1
WireConnection;1110;1;1107;0
WireConnection;1110;2;1113;0
WireConnection;1111;0;1105;1
WireConnection;1111;1;1107;0
WireConnection;1111;2;1113;0
WireConnection;1106;0;1111;0
WireConnection;1106;1;1105;2
WireConnection;1106;2;1105;3
WireConnection;1104;0;1110;0
WireConnection;1104;1;1103;2
WireConnection;1104;2;1103;3
WireConnection;348;0;347;0
WireConnection;478;0;1104;0
WireConnection;478;1;338;0
WireConnection;478;2;1106;0
WireConnection;478;3;348;0
WireConnection;478;4;348;1
ASEEND*/
//CHKSM=26A4553961CA33919066357B603999C44E0D3986