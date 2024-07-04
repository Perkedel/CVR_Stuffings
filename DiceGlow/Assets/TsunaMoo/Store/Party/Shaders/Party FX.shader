// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Party FX"
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
		[HideInInspector]m_start_noisevert("Vertex Noise--{reference_property:_VertexNoise}", Float) = 0
		[HideInInspector][Toggle(_VertNoise_ON)] _VertexNoise("Enable Vertex Noise", Float) = 0
		[NoScaleOffset][SingleLineTexture]_VertexNoiseMask("Vertex Noise Mask Map--{reference_properties:[_TilingNoiseMask,_OffsetNoiseMask,_UVNoiseMask]}", 2D) = "white" {}
		[HideInInspector][Vector2]_TilingNoiseMask("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_OffsetNoiseMask("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_UVNoiseMask("UV", Int) = 0
		_NoiseStength("Strength", Float) = 1
		_NoiseScale("Scale", Range( 0 , 10)) = 5
		[Vector3]_NoiseDirection("Directional Speed", Vector) = (1,1,1,0)
		[HideInInspector]m_end_noisevert("Vertex Noise", Float) = 0
		[HideInInspector]m_start_AudioLink("Audio Link", Float) = 0
		[HideInInspector]m_start_Band0("Band 0--{reference_property:_UseBand0}", Float) = 0
		[HideInInspector][Toggle(_B0_ON)] _UseBand0("Enable Band 0", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Band0Albedo("Albedo Map--{reference_property:_Band0Color,reference_properties:[_Band0Tiling,_Band0Offset,_Band0UV]}", 2D) = "white" {}
		[HideInInspector][HDR]_Band0Color("Color", Color) = (0,0,0,1)
		[HideInInspector][Vector2]_Band0Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band0Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band0UV("UV", Int) = 0
		[NoScaleOffset][SingleLineTexture]_Band0Mask("Mask Map--{reference_properties:[_Band0MaskTiling,_Band0MaskOffset,_Band0MaskUV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Band0MaskTiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band0MaskOffset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band0MaskUV("UV", Int) = 0
		_Band0HueShift("Hue Shift", Range( 0 , 1)) = 0
		_Band0Delay("Delay", Range( 0 , 1)) = 0
		_Band0Pulse("Pulse", Range( 0 , 1)) = 1
		[ToggleUI]_Band0BarAmp("Bar Mode Pulse", Float) = 0
		_Band0PulseRotation("Rotation", Range( 0 , 360)) = 0
		[ToggleUI]_Band0RotationoverTime("Rotation over Time", Float) = 0
		_Band0RotateSpeed("Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band0RotationoverTime==1}}", Range( 0 , 5)) = 1
		[HideInInspector]m_start_Shake0("Shake--{reference_property:_UseShake0}", Float) = 0
		[HideInInspector][ToggleUI]_UseShake0("Enable Shake 0", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Shake0Mask("Mask Map--{reference_properties:[_Shake0Tiling,_Shake0Offset,_Shake0UV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Shake0Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Shake0Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Shake0UV("UV", Int) = 0
		_Shake0Intensity("Intensity", Range( 0 , 2)) = 0.05
		[Enum(Normals,0,Custom,1)]_Shake0DirectionSelect("Direction", Float) = 0
		[Vector3]_Shake0DirectionVector("Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake0DirectionSelect==1}}", Vector) = (0,0,0,0)
		[HideInInspector]m_end_Shake0("Shake 0", Float) = 0
		[HideInInspector]m_end_Band0("Band 0", Float) = 0
		[HideInInspector]m_start_Band1("Band 1--{reference_property:_UseBand1}", Float) = 0
		[HideInInspector][Toggle(_B1_ON)] _UseBand1("Enable Band 1", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Band1Albedo("Albedo Map--{reference_property:_Band1Color,reference_properties:[_Band1Tiling,_Band1Offset,_Band1UV]}", 2D) = "white" {}
		[HideInInspector][HDR]_Band1Color("Color", Color) = (0,0,0,1)
		[HideInInspector][Vector2]_Band1Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band1Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band1UV("UV", Int) = 0
		[NoScaleOffset][SingleLineTexture]_Band1Mask("Mask Map--{reference_properties:[_Band1MaskTiling,_Band1MaskOffset,_Band1MaskUV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Band1MaskTiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band1MaskOffset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band1MaskUV("UV", Int) = 0
		_Band1HueShift("Hue Shift", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		_Band1Delay("Delay", Range( 0 , 1)) = 0
		_Band1Pulse("Pulse", Range( 0 , 1)) = 0
		[ToggleUI]_Band1BarAmp("Bar Mode Pulse", Float) = 0
		_Band1PulseRotation("Rotation", Range( 0 , 360)) = 0
		[ToggleUI]_Band1RotationoverTime("Rotation over Time", Float) = 0
		_Band1RotateSpeed("Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band1RotationoverTime==1}}", Range( 0 , 5)) = 1
		[HideInInspector]m_start_Shake1("Shake--{reference_property:_UseShake1}", Float) = 0
		[HideInInspector][ToggleUI]_UseShake1("Enable Shake 1", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Shake1Mask("Mask Map--{reference_properties:[_Shake1Tiling,_Shake1Offset,_Shake1UV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Shake1Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Shake1Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Shake1UV("UV", Int) = 0
		_Shake1Intensity("Intensity", Range( 0 , 2)) = 0.05
		[IntRange][Enum(Normals,0,Custom,1)]_Shake1DirectionSelect("Direction", Float) = 0
		[Vector3]_Shake1DirectionVector("Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake1DirectionSelect==1}}", Vector) = (0,0,0,0)
		[HideInInspector]m_end_Shake1("Shake 1", Float) = 0
		[HideInInspector]m_end_Band1("Band 1", Float) = 0
		[HideInInspector]m_start_Band2("Band 2--{reference_property:_UseBand2}", Float) = 0
		[HideInInspector][Toggle(_B2_ON)] _UseBand2("Enable Band 2", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Band2Albedo("Albedo Map--{reference_property:_Band2Color,reference_properties:[_Band2Tiling,_Band2Offset,_Band2UV]}", 2D) = "white" {}
		[HideInInspector][HDR]_Band2Color("Color", Color) = (0,0,0,1)
		[HideInInspector][Vector2]_Band2Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band2Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band2UV("UV", Int) = 0
		[NoScaleOffset][SingleLineTexture]_Band2Mask("Mask Map--{reference_properties:[_Band2MaskTiling,_Band2MaskOffset,_Band2MaskUV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Band2MaskTiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band2MaskOffset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band2MaskUV("UV", Int) = 0
		_Band2HueShift("Hue Shift", Range( 0 , 1)) = 0
		_Band2Delay("Delay", Range( 0 , 1)) = 0
		_Band2Pulse("Pulse", Range( 0 , 1)) = 0
		[ToggleUI]_Band2BarAmp("Bar Mode Pulse", Float) = 0
		_Band2PulseRotation("Rotation", Range( 0 , 360)) = 0
		[ToggleUI]_Band2RotationoverTime("Rotation over Time", Float) = 0
		_Band2RotateSpeed("Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band2RotationoverTime==1}}", Range( 0 , 5)) = 1
		[HideInInspector]m_start_Shake2("Shake--{reference_property:_UseShake2}", Float) = 0
		[HideInInspector][ToggleUI]_UseShake2("Enable Shake 2", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Shake2Mask("Mask Map--{reference_properties:[_Shake2Tiling,_Shake2Offset,_Shake2UV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Shake2Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Shake2Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Shake2UV("UV", Int) = 0
		_Shake2Intensity("Intensity", Range( 0 , 2)) = 0.05
		[Enum(Normals,0,Custom,1)]_Shake2DirectionSelect("Direction", Float) = 0
		[Vector3]_Shake2DirectionVector("Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake2DirectionSelect==1}}", Vector) = (0,0,0,0)
		[HideInInspector]m_end_Shake2("Shake 2", Float) = 0
		[HideInInspector]m_end_Band2("Band 2", Float) = 0
		[HideInInspector]m_start_Band3("Band 3--{reference_property:_UseBand3}", Float) = 0
		[HideInInspector][Toggle(_B3_ON)] _UseBand3("Enable Band 3", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Band3Albedo("Albedo Map--{reference_property:_Band3Color,reference_properties:[_Band3Tiling,_Band3Offset,_Band3UV]}", 2D) = "white" {}
		[HideInInspector][HDR]_Band3Color("Color", Color) = (0,0,0,1)
		[HideInInspector][Vector2]_Band3Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band3Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band3UV("UV", Int) = 0
		[NoScaleOffset][SingleLineTexture]_Band3Mask("Mask Map--{reference_properties:[_Band3MaskTiling,_Band3MaskOffset,_Band3MaskUV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Band3MaskTiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Band3MaskOffset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Band3MaskUV("UV", Int) = 0
		_Band3HueShift("Hue Shift", Range( 0 , 1)) = 0.420841
		_Band3Delay("Delay", Range( 0 , 1)) = 0
		_Band3Pulse("Pulse", Range( 0 , 1)) = 1
		[ToggleUI]_Band3BarAmp("Bar Mode Pulse", Float) = 0
		_Band3PulseRotation("Rotation", Range( 0 , 360)) = 0
		[ToggleUI]_Band3RotationoverTime("Rotation over Time", Float) = 0
		_Band3RotateSpeed("Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band3RotationoverTime==1}}", Range( 0 , 5)) = 1
		[HideInInspector]m_start_Shake3("Shake--{reference_property:_UseShake3}", Float) = 0
		[HideInInspector][ToggleUI]_UseShake3("Enable Shake 3", Float) = 0
		[NoScaleOffset][SingleLineTexture]_Shake3Mask("Mask Map--{reference_properties:[_Shake3Tiling,_Shake3Offset,_Shake3UV]}", 2D) = "white" {}
		[HideInInspector][Vector2]_Shake3Tiling("Tiling", Vector) = (1,1,0,0)
		[HideInInspector][Vector2]_Shake3Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector][ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6)]_Shake3UV("UV", Int) = 0
		_Shake3Intensity("Intensity", Range( 0 , 2)) = 0.05
		[Enum(Normals,0,Custom,1)]_Shake3DirectionSelect("Direction", Float) = 0
		[Vector3]_Shake3DirectionVector("Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake3DirectionSelect==1}}", Vector) = (0,0,0,0)
		[HideInInspector]m_end_Shake3("Shake 3", Float) = 0
		[HideInInspector]m_end_Band3("Band 3", Float) = 0
		[HideInInspector]m_end_AudioLink("Audio Link", Float) = 0
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
		#pragma shader_feature_local _VertNoise_ON
		#pragma shader_feature_local _B0_ON
		#pragma shader_feature_local _B1_ON
		#pragma shader_feature_local _B2_ON
		#pragma shader_feature_local _B3_ON
		#pragma shader_feature_local _NormalMap_ON
		#pragma shader_feature_local _EmissionEff_ON
		#include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"
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
			float3 worldPos;
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float2 uv3_texcoord3;
			float2 uv4_texcoord4;
			half3 worldNormal;
			INTERNAL_DATA
		};

		uniform half m_end_Shake0;
		uniform half footer_github;
		uniform int _ZWrite;
		uniform half m_start_Band0;
		uniform half _ZTest;
		uniform half shader_is_using_thry_editor;
		uniform half m_end_Shake2;
		uniform half m_end_Band1;
		uniform half m_end_eff;
		uniform half m_end_Band2;
		uniform half m_start_Shake2;
		uniform half m_start_engine;
		uniform half m_end_Shake3;
		uniform half LightmapFlags;
		uniform half footer_booth;
		uniform half m_start_Band3;
		uniform half shader_master_label;
		uniform half Instancing;
		uniform half m_start_Main;
		uniform half m_start_Shake1;
		uniform half m_start_Shake0;
		uniform half shader_properties_label_file;
		uniform half DSGI;
		uniform half m_start_AudioLink;
		uniform half m_end_rim;
		uniform half m_end_Band3;
		uniform half _Cull;
		uniform half m_end_AudioLink;
		uniform half m_end_Shake1;
		uniform half m_start_rim;
		uniform half m_end_Band0;
		uniform half m_start_eff;
		uniform half m_start_Band2;
		uniform half m_end_Main;
		uniform half footer_discord;
		uniform half footer_patreon;
		uniform half m_start_noisevert;
		uniform half m_end_engine;
		uniform half m_start_Band1;
		uniform half m_end_noisevert;
		uniform half m_start_Shake3;
		uniform half3 _NoiseDirection;
		uniform half _NoiseScale;
		uniform half _NoiseStength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_VertexNoiseMask);
		uniform half2 _OffsetNoiseMask;
		uniform half2 _TilingNoiseMask;
		uniform int _UVNoiseMask;
		SamplerState sampler_linear_repeat;
		uniform half _UseShake0;
		uniform half _Band0BarAmp;
		uniform half2 _Band0Offset;
		uniform half2 _Band0Tiling;
		uniform int _Band0UV;
		uniform half _Band0RotationoverTime;
		uniform half _Band0PulseRotation;
		uniform half _Band0RotateSpeed;
		uniform half _Band0Pulse;
		uniform half _Band0Delay;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band0Mask);
		uniform half2 _Band0MaskOffset;
		uniform half2 _Band0MaskTiling;
		uniform int _Band0MaskUV;
		uniform half4 _Band0Color;
		uniform half _Shake0Intensity;
		uniform half _Shake0DirectionSelect;
		uniform half3 _Shake0DirectionVector;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Shake0Mask);
		uniform half2 _Shake0Offset;
		uniform half2 _Shake0Tiling;
		uniform int _Shake0UV;
		uniform half _UseShake1;
		uniform half _Band1BarAmp;
		uniform half2 _Band1Offset;
		uniform half2 _Band1Tiling;
		uniform int _Band1UV;
		uniform half _Band1RotationoverTime;
		uniform half _Band1PulseRotation;
		uniform half _Band1RotateSpeed;
		uniform half _Band1Pulse;
		uniform half _Band1Delay;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band1Mask);
		uniform half2 _Band1MaskOffset;
		uniform half2 _Band1MaskTiling;
		uniform int _Band1MaskUV;
		uniform half4 _Band1Color;
		uniform half _Shake1Intensity;
		uniform half _Shake1DirectionSelect;
		uniform half3 _Shake1DirectionVector;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Shake1Mask);
		uniform half2 _Shake1Offset;
		uniform half2 _Shake1Tiling;
		uniform int _Shake1UV;
		uniform half _UseShake2;
		uniform half _Band2BarAmp;
		uniform half2 _Band2Offset;
		uniform half2 _Band2Tiling;
		uniform int _Band2UV;
		uniform half _Band2RotationoverTime;
		uniform half _Band2PulseRotation;
		uniform half _Band2RotateSpeed;
		uniform half _Band2Pulse;
		uniform half _Band2Delay;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band2Mask);
		uniform half2 _Band2MaskOffset;
		uniform half2 _Band2MaskTiling;
		uniform int _Band2MaskUV;
		uniform half4 _Band2Color;
		uniform half _Shake2Intensity;
		uniform half _Shake2DirectionSelect;
		uniform half3 _Shake2DirectionVector;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Shake2Mask);
		uniform half2 _Shake2Offset;
		uniform half2 _Shake2Tiling;
		uniform int _Shake2UV;
		uniform half _UseShake3;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band3Mask);
		uniform half2 _Band3MaskOffset;
		uniform half2 _Band3MaskTiling;
		uniform int _Band3MaskUV;
		uniform half _Band3BarAmp;
		uniform half2 _Band3Offset;
		uniform half2 _Band3Tiling;
		uniform int _Band3UV;
		uniform half _Band3RotationoverTime;
		uniform half _Band3PulseRotation;
		uniform half _Band3RotateSpeed;
		uniform half _Band3Pulse;
		uniform half _Band3Delay;
		uniform half4 _Band3Color;
		uniform half _Shake3Intensity;
		uniform half _Shake3DirectionSelect;
		uniform half3 _Shake3DirectionVector;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Shake3Mask);
		uniform half2 _Shake3Offset;
		uniform half2 _Shake3Tiling;
		uniform int _Shake3UV;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform half2 _MainScroll;
		uniform half2 _Offset;
		uniform half2 _Tiling;
		uniform int _UVMain;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band1Albedo);
		uniform half _Band1HueShift;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band0Albedo);
		uniform half _Band0HueShift;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band2Albedo);
		uniform half _Band2HueShift;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Band3Albedo);
		uniform half _Band3HueShift;
		uniform half _Metallic;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
		uniform half _Glossiness;
		uniform half _AntiAliasingVarianceSm;
		uniform half _AntiAliasingThresholdSm;


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


		half2 UVSelector9_g363( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g290( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		inline half AudioLinkLerp3_g345( int Band, half Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		half2 UVSelector9_g351( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g358( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g291( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		inline half AudioLinkLerp3_g347( int Band, half Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		half2 UVSelector9_g352( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g360( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g295( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		inline half AudioLinkLerp3_g348( int Band, half Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		half2 UVSelector9_g353( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g359( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g354( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g292( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		inline half AudioLinkLerp3_g346( int Band, half Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		half2 UVSelector9_g361( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g343( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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

		half2 UVSelector9_g349( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		half2 UVSelector9_g350( int Set, half2 UV0, half2 UV1, half2 UV2, half2 UV3, half2 UV4, half2 UV5, half2 UV6 )
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half simplePerlin3D660 = snoise( ( ase_worldPos + ( _Time.y * _NoiseDirection ) )*_NoiseScale );
			simplePerlin3D660 = simplePerlin3D660*0.5 + 0.5;
			int Set9_g363 = _UVNoiseMask;
			half2 UV09_g363 = v.texcoord.xy;
			half2 UV19_g363 = v.texcoord1.xy;
			half2 UV29_g363 = v.texcoord2.xy;
			half2 UV39_g363 = v.texcoord3.xy;
			half2 appendResult40_g363 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g363 = appendResult40_g363;
			half2 appendResult41_g363 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g363 = appendResult41_g363;
			half2 appendResult42_g363 = (half2(0.0 , 0.0));
			half2 UV69_g363 = appendResult42_g363;
			half2 localUVSelector9_g363 = UVSelector9_g363( Set9_g363 , UV09_g363 , UV19_g363 , UV29_g363 , UV39_g363 , UV49_g363 , UV59_g363 , UV69_g363 );
			#ifdef _VertNoise_ON
				half4 staticSwitch1077 = ( ( (-1.0 + (simplePerlin3D660 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _NoiseStength ) * SAMPLE_TEXTURE2D_LOD( _VertexNoiseMask, sampler_linear_repeat, ( _OffsetNoiseMask + ( _TilingNoiseMask * localUVSelector9_g363 ) ), 0.0 ) );
			#else
				half4 staticSwitch1077 = float4( 0,0,0,0 );
			#endif
			half4 WorldNoise672 = staticSwitch1077;
			int Band3_g345 = 0;
			int Set9_g290 = _Band0UV;
			half2 UV09_g290 = v.texcoord.xy;
			half2 UV19_g290 = v.texcoord1.xy;
			half2 UV29_g290 = v.texcoord2.xy;
			half2 UV39_g290 = v.texcoord3.xy;
			half2 appendResult40_g290 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g290 = appendResult40_g290;
			half2 appendResult41_g290 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g290 = appendResult41_g290;
			half2 appendResult42_g290 = (half2(0.0 , 0.0));
			half2 UV69_g290 = appendResult42_g290;
			half2 localUVSelector9_g290 = UVSelector9_g290( Set9_g290 , UV09_g290 , UV19_g290 , UV29_g290 , UV39_g290 , UV49_g290 , UV59_g290 , UV69_g290 );
			half2 temp_output_696_0 = ( _Band0Offset + ( _Band0Tiling * localUVSelector9_g290 ) );
			half2 break6_g301 = (float2( 0,0 ) + (temp_output_696_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g301 = ( break6_g301.x - 0.5 );
			half temp_output_691_0 = radians( _Band0PulseRotation );
			half mulTime694 = _Time.y * _Band0RotateSpeed;
			half ifLocalVar1090 = 0;
			if( _Band0RotationoverTime == 1.0 )
				ifLocalVar1090 = ( temp_output_691_0 + mulTime694 );
			else
				ifLocalVar1090 = temp_output_691_0;
			half temp_output_2_0_g301 = ifLocalVar1090;
			half temp_output_3_0_g301 = cos( temp_output_2_0_g301 );
			half temp_output_8_0_g301 = sin( temp_output_2_0_g301 );
			half temp_output_20_0_g301 = ( 1.0 / ( abs( temp_output_3_0_g301 ) + abs( temp_output_8_0_g301 ) ) );
			half temp_output_7_0_g301 = ( break6_g301.y - 0.5 );
			half2 appendResult16_g301 = (half2(( ( ( temp_output_5_0_g301 * temp_output_3_0_g301 * temp_output_20_0_g301 ) + ( temp_output_7_0_g301 * temp_output_8_0_g301 * temp_output_20_0_g301 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g301 * temp_output_3_0_g301 * temp_output_20_0_g301 ) - ( temp_output_5_0_g301 * temp_output_8_0_g301 * temp_output_20_0_g301 ) ) + 0.5 )));
			half Delay3_g345 = ( ( (_Band0Delay + (( appendResult16_g301.x * _Band0Pulse ) - 0.0) * (1.0 - _Band0Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g345 = AudioLinkLerp3_g345( Band3_g345 , Delay3_g345 );
			half temp_output_708_0 = localAudioLinkLerp3_g345;
			half clampResult995 = clamp( (1.0 + (floor( ( temp_output_696_0.y - temp_output_708_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band0BarMode1000 = ( 1.0 - clampResult995 );
			half ifLocalVar1002 = 0;
			if( _Band0BarAmp == 1.0 )
				ifLocalVar1002 = Band0BarMode1000;
			else
				ifLocalVar1002 = temp_output_708_0;
			int Set9_g351 = _Band0MaskUV;
			half2 UV09_g351 = v.texcoord.xy;
			half2 UV19_g351 = v.texcoord1.xy;
			half2 UV29_g351 = v.texcoord2.xy;
			half2 UV39_g351 = v.texcoord3.xy;
			half2 appendResult40_g351 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g351 = appendResult40_g351;
			half2 appendResult41_g351 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g351 = appendResult41_g351;
			half2 appendResult42_g351 = (half2(0.0 , 0.0));
			half2 UV69_g351 = appendResult42_g351;
			half2 localUVSelector9_g351 = UVSelector9_g351( Set9_g351 , UV09_g351 , UV19_g351 , UV29_g351 , UV39_g351 , UV49_g351 , UV59_g351 , UV69_g351 );
			half4 tex2DNode736 = SAMPLE_TEXTURE2D_LOD( _Band0Mask, sampler_linear_repeat, ( _Band0MaskOffset + ( _Band0MaskTiling * localUVSelector9_g351 ) ), 0.0 );
			#ifdef _B0_ON
				half4 staticSwitch1064 = ( ifLocalVar1002 * tex2DNode736 * _Band0Color.a );
			#else
				half4 staticSwitch1064 = float4( 0,0,0,0 );
			#endif
			half4 Band0Amp720 = staticSwitch1064;
			half3 ase_vertexNormal = v.normal.xyz;
			half3 ifLocalVar722 = 0;
			if( _Shake0DirectionSelect == 1.0 )
				ifLocalVar722 = _Shake0DirectionVector;
			else
				ifLocalVar722 = ase_vertexNormal;
			int Set9_g358 = _Shake0UV;
			half2 UV09_g358 = v.texcoord.xy;
			half2 UV19_g358 = v.texcoord1.xy;
			half2 UV29_g358 = v.texcoord2.xy;
			half2 UV39_g358 = v.texcoord3.xy;
			half2 appendResult40_g358 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g358 = appendResult40_g358;
			half2 appendResult41_g358 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g358 = appendResult41_g358;
			half2 appendResult42_g358 = (half2(0.0 , 0.0));
			half2 UV69_g358 = appendResult42_g358;
			half2 localUVSelector9_g358 = UVSelector9_g358( Set9_g358 , UV09_g358 , UV19_g358 , UV29_g358 , UV39_g358 , UV49_g358 , UV59_g358 , UV69_g358 );
			half4 ifLocalVar1097 = 0;
			if( _UseShake0 == 1.0 )
				ifLocalVar1097 = ( ( Band0Amp720 * _Shake0Intensity * half4( ifLocalVar722 , 0.0 ) ) * SAMPLE_TEXTURE2D_LOD( _Shake0Mask, sampler_linear_repeat, ( _Shake0Offset + ( _Shake0Tiling * localUVSelector9_g358 ) ), 0.0 ) );
			#ifdef _B0_ON
				half4 staticSwitch1065 = ifLocalVar1097;
			#else
				half4 staticSwitch1065 = float4( 0,0,0,0 );
			#endif
			half4 Band0Shake743 = staticSwitch1065;
			int Band3_g347 = 1;
			int Set9_g291 = _Band1UV;
			half2 UV09_g291 = v.texcoord.xy;
			half2 UV19_g291 = v.texcoord1.xy;
			half2 UV29_g291 = v.texcoord2.xy;
			half2 UV39_g291 = v.texcoord3.xy;
			half2 appendResult40_g291 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g291 = appendResult40_g291;
			half2 appendResult41_g291 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g291 = appendResult41_g291;
			half2 appendResult42_g291 = (half2(0.0 , 0.0));
			half2 UV69_g291 = appendResult42_g291;
			half2 localUVSelector9_g291 = UVSelector9_g291( Set9_g291 , UV09_g291 , UV19_g291 , UV29_g291 , UV39_g291 , UV49_g291 , UV59_g291 , UV69_g291 );
			half2 temp_output_810_0 = ( _Band1Offset + ( _Band1Tiling * localUVSelector9_g291 ) );
			half2 break6_g300 = (float2( 0,0 ) + (temp_output_810_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g300 = ( break6_g300.x - 0.5 );
			half temp_output_812_0 = radians( _Band1PulseRotation );
			half mulTime811 = _Time.y * _Band1RotateSpeed;
			half ifLocalVar1088 = 0;
			if( _Band1RotationoverTime == 1.0 )
				ifLocalVar1088 = ( temp_output_812_0 + mulTime811 );
			else
				ifLocalVar1088 = temp_output_812_0;
			half temp_output_2_0_g300 = ifLocalVar1088;
			half temp_output_3_0_g300 = cos( temp_output_2_0_g300 );
			half temp_output_8_0_g300 = sin( temp_output_2_0_g300 );
			half temp_output_20_0_g300 = ( 1.0 / ( abs( temp_output_3_0_g300 ) + abs( temp_output_8_0_g300 ) ) );
			half temp_output_7_0_g300 = ( break6_g300.y - 0.5 );
			half2 appendResult16_g300 = (half2(( ( ( temp_output_5_0_g300 * temp_output_3_0_g300 * temp_output_20_0_g300 ) + ( temp_output_7_0_g300 * temp_output_8_0_g300 * temp_output_20_0_g300 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g300 * temp_output_3_0_g300 * temp_output_20_0_g300 ) - ( temp_output_5_0_g300 * temp_output_8_0_g300 * temp_output_20_0_g300 ) ) + 0.5 )));
			half Delay3_g347 = ( ( (_Band1Delay + (( appendResult16_g300.x * _Band1Pulse ) - 0.0) * (1.0 - _Band1Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g347 = AudioLinkLerp3_g347( Band3_g347 , Delay3_g347 );
			half temp_output_772_0 = localAudioLinkLerp3_g347;
			half clampResult1015 = clamp( (1.0 + (floor( ( temp_output_810_0.y - temp_output_772_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band1BarMode1017 = ( 1.0 - clampResult1015 );
			half ifLocalVar1039 = 0;
			if( _Band1BarAmp == 1.0 )
				ifLocalVar1039 = Band1BarMode1017;
			else
				ifLocalVar1039 = temp_output_772_0;
			int Set9_g352 = _Band1MaskUV;
			half2 UV09_g352 = v.texcoord.xy;
			half2 UV19_g352 = v.texcoord1.xy;
			half2 UV29_g352 = v.texcoord2.xy;
			half2 UV39_g352 = v.texcoord3.xy;
			half2 appendResult40_g352 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g352 = appendResult40_g352;
			half2 appendResult41_g352 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g352 = appendResult41_g352;
			half2 appendResult42_g352 = (half2(0.0 , 0.0));
			half2 UV69_g352 = appendResult42_g352;
			half2 localUVSelector9_g352 = UVSelector9_g352( Set9_g352 , UV09_g352 , UV19_g352 , UV29_g352 , UV39_g352 , UV49_g352 , UV59_g352 , UV69_g352 );
			half4 tex2DNode784 = SAMPLE_TEXTURE2D_LOD( _Band1Mask, sampler_linear_repeat, ( _Band1MaskOffset + ( _Band1MaskTiling * localUVSelector9_g352 ) ), 0.0 );
			#ifdef _B1_ON
				half4 staticSwitch1067 = ( ifLocalVar1039 * tex2DNode784 * _Band1Color.a );
			#else
				half4 staticSwitch1067 = float4( 0,0,0,0 );
			#endif
			half4 Band1Amp768 = staticSwitch1067;
			half3 ifLocalVar764 = 0;
			if( _Shake1DirectionSelect == 1.0 )
				ifLocalVar764 = _Shake1DirectionVector;
			else
				ifLocalVar764 = ase_vertexNormal;
			int Set9_g360 = _Shake1UV;
			half2 UV09_g360 = v.texcoord.xy;
			half2 UV19_g360 = v.texcoord1.xy;
			half2 UV29_g360 = v.texcoord2.xy;
			half2 UV39_g360 = v.texcoord3.xy;
			half2 appendResult40_g360 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g360 = appendResult40_g360;
			half2 appendResult41_g360 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g360 = appendResult41_g360;
			half2 appendResult42_g360 = (half2(0.0 , 0.0));
			half2 UV69_g360 = appendResult42_g360;
			half2 localUVSelector9_g360 = UVSelector9_g360( Set9_g360 , UV09_g360 , UV19_g360 , UV29_g360 , UV39_g360 , UV49_g360 , UV59_g360 , UV69_g360 );
			half4 ifLocalVar1094 = 0;
			if( _UseShake1 == 1.0 )
				ifLocalVar1094 = ( ( Band1Amp768 * _Shake1Intensity * half4( ifLocalVar764 , 0.0 ) ) * SAMPLE_TEXTURE2D_LOD( _Shake1Mask, sampler_linear_repeat, ( _Shake1Offset + ( _Shake1Tiling * localUVSelector9_g360 ) ), 0.0 ) );
			#ifdef _B1_ON
				half4 staticSwitch1068 = ifLocalVar1094;
			#else
				half4 staticSwitch1068 = float4( 0,0,0,0 );
			#endif
			half4 Band1Shake766 = staticSwitch1068;
			int Band3_g348 = 2;
			int Set9_g295 = _Band2UV;
			half2 UV09_g295 = v.texcoord.xy;
			half2 UV19_g295 = v.texcoord1.xy;
			half2 UV29_g295 = v.texcoord2.xy;
			half2 UV39_g295 = v.texcoord3.xy;
			half2 appendResult40_g295 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g295 = appendResult40_g295;
			half2 appendResult41_g295 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g295 = appendResult41_g295;
			half2 appendResult42_g295 = (half2(0.0 , 0.0));
			half2 UV69_g295 = appendResult42_g295;
			half2 localUVSelector9_g295 = UVSelector9_g295( Set9_g295 , UV09_g295 , UV19_g295 , UV29_g295 , UV39_g295 , UV49_g295 , UV59_g295 , UV69_g295 );
			half2 temp_output_860_0 = ( _Band2Offset + ( _Band2Tiling * localUVSelector9_g295 ) );
			half2 break6_g303 = (float2( 0,0 ) + (temp_output_860_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g303 = ( break6_g303.x - 0.5 );
			half temp_output_853_0 = radians( _Band2PulseRotation );
			half mulTime854 = _Time.y * _Band2RotateSpeed;
			half ifLocalVar1087 = 0;
			if( _Band2RotationoverTime == 1.0 )
				ifLocalVar1087 = ( temp_output_853_0 + mulTime854 );
			else
				ifLocalVar1087 = temp_output_853_0;
			half temp_output_2_0_g303 = ifLocalVar1087;
			half temp_output_3_0_g303 = cos( temp_output_2_0_g303 );
			half temp_output_8_0_g303 = sin( temp_output_2_0_g303 );
			half temp_output_20_0_g303 = ( 1.0 / ( abs( temp_output_3_0_g303 ) + abs( temp_output_8_0_g303 ) ) );
			half temp_output_7_0_g303 = ( break6_g303.y - 0.5 );
			half2 appendResult16_g303 = (half2(( ( ( temp_output_5_0_g303 * temp_output_3_0_g303 * temp_output_20_0_g303 ) + ( temp_output_7_0_g303 * temp_output_8_0_g303 * temp_output_20_0_g303 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g303 * temp_output_3_0_g303 * temp_output_20_0_g303 ) - ( temp_output_5_0_g303 * temp_output_8_0_g303 * temp_output_20_0_g303 ) ) + 0.5 )));
			half Delay3_g348 = ( ( (_Band2Delay + (( appendResult16_g303.x * _Band2Pulse ) - 0.0) * (1.0 - _Band2Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g348 = AudioLinkLerp3_g348( Band3_g348 , Delay3_g348 );
			half temp_output_869_0 = localAudioLinkLerp3_g348;
			half clampResult1024 = clamp( (1.0 + (floor( ( temp_output_860_0.y - temp_output_869_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band2BarMode1026 = ( 1.0 - clampResult1024 );
			half ifLocalVar1042 = 0;
			if( _Band2BarAmp == 1.0 )
				ifLocalVar1042 = Band2BarMode1026;
			else
				ifLocalVar1042 = temp_output_869_0;
			int Set9_g353 = _Band2MaskUV;
			half2 UV09_g353 = v.texcoord.xy;
			half2 UV19_g353 = v.texcoord1.xy;
			half2 UV29_g353 = v.texcoord2.xy;
			half2 UV39_g353 = v.texcoord3.xy;
			half2 appendResult40_g353 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g353 = appendResult40_g353;
			half2 appendResult41_g353 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g353 = appendResult41_g353;
			half2 appendResult42_g353 = (half2(0.0 , 0.0));
			half2 UV69_g353 = appendResult42_g353;
			half2 localUVSelector9_g353 = UVSelector9_g353( Set9_g353 , UV09_g353 , UV19_g353 , UV29_g353 , UV39_g353 , UV49_g353 , UV59_g353 , UV69_g353 );
			half4 tex2DNode893 = SAMPLE_TEXTURE2D_LOD( _Band2Mask, sampler_linear_repeat, ( _Band2MaskOffset + ( _Band2MaskTiling * localUVSelector9_g353 ) ), 0.0 );
			#ifdef _B2_ON
				half4 staticSwitch1070 = ( ifLocalVar1042 * tex2DNode893 * _Band2Color.a );
			#else
				half4 staticSwitch1070 = float4( 0,0,0,0 );
			#endif
			half4 Band2Amp875 = staticSwitch1070;
			half3 ifLocalVar899 = 0;
			if( _Shake2DirectionSelect == 1.0 )
				ifLocalVar899 = _Shake2DirectionVector;
			else
				ifLocalVar899 = ase_vertexNormal;
			int Set9_g359 = _Shake2UV;
			half2 UV09_g359 = v.texcoord.xy;
			half2 UV19_g359 = v.texcoord1.xy;
			half2 UV29_g359 = v.texcoord2.xy;
			half2 UV39_g359 = v.texcoord3.xy;
			half2 appendResult40_g359 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g359 = appendResult40_g359;
			half2 appendResult41_g359 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g359 = appendResult41_g359;
			half2 appendResult42_g359 = (half2(0.0 , 0.0));
			half2 UV69_g359 = appendResult42_g359;
			half2 localUVSelector9_g359 = UVSelector9_g359( Set9_g359 , UV09_g359 , UV19_g359 , UV29_g359 , UV39_g359 , UV49_g359 , UV59_g359 , UV69_g359 );
			half4 ifLocalVar1099 = 0;
			if( _UseShake2 == 1.0 )
				ifLocalVar1099 = ( ( Band2Amp875 * _Shake2Intensity * half4( ifLocalVar899 , 0.0 ) ) * SAMPLE_TEXTURE2D_LOD( _Shake2Mask, sampler_linear_repeat, ( _Shake2Offset + ( _Shake2Tiling * localUVSelector9_g359 ) ), 0.0 ) );
			#ifdef _B2_ON
				half4 staticSwitch1071 = ifLocalVar1099;
			#else
				half4 staticSwitch1071 = float4( 0,0,0,0 );
			#endif
			half4 Band2Shake909 = staticSwitch1071;
			int Set9_g354 = _Band3MaskUV;
			half2 UV09_g354 = v.texcoord.xy;
			half2 UV19_g354 = v.texcoord1.xy;
			half2 UV29_g354 = v.texcoord2.xy;
			half2 UV39_g354 = v.texcoord3.xy;
			half2 appendResult40_g354 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g354 = appendResult40_g354;
			half2 appendResult41_g354 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g354 = appendResult41_g354;
			half2 appendResult42_g354 = (half2(0.0 , 0.0));
			half2 UV69_g354 = appendResult42_g354;
			half2 localUVSelector9_g354 = UVSelector9_g354( Set9_g354 , UV09_g354 , UV19_g354 , UV29_g354 , UV39_g354 , UV49_g354 , UV59_g354 , UV69_g354 );
			half4 tex2DNode961 = SAMPLE_TEXTURE2D_LOD( _Band3Mask, sampler_linear_repeat, ( _Band3MaskOffset + ( _Band3MaskTiling * localUVSelector9_g354 ) ), 0.0 );
			int Band3_g346 = 3;
			int Set9_g292 = _Band3UV;
			half2 UV09_g292 = v.texcoord.xy;
			half2 UV19_g292 = v.texcoord1.xy;
			half2 UV29_g292 = v.texcoord2.xy;
			half2 UV39_g292 = v.texcoord3.xy;
			half2 appendResult40_g292 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g292 = appendResult40_g292;
			half2 appendResult41_g292 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g292 = appendResult41_g292;
			half2 appendResult42_g292 = (half2(0.0 , 0.0));
			half2 UV69_g292 = appendResult42_g292;
			half2 localUVSelector9_g292 = UVSelector9_g292( Set9_g292 , UV09_g292 , UV19_g292 , UV29_g292 , UV39_g292 , UV49_g292 , UV59_g292 , UV69_g292 );
			half2 temp_output_930_0 = ( _Band3Offset + ( _Band3Tiling * localUVSelector9_g292 ) );
			half2 break6_g302 = (float2( 0,0 ) + (temp_output_930_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g302 = ( break6_g302.x - 0.5 );
			half temp_output_922_0 = radians( _Band3PulseRotation );
			half mulTime923 = _Time.y * _Band3RotateSpeed;
			half ifLocalVar1084 = 0;
			if( _Band3RotationoverTime == 1.0 )
				ifLocalVar1084 = ( temp_output_922_0 + mulTime923 );
			else
				ifLocalVar1084 = temp_output_922_0;
			half temp_output_2_0_g302 = ifLocalVar1084;
			half temp_output_3_0_g302 = cos( temp_output_2_0_g302 );
			half temp_output_8_0_g302 = sin( temp_output_2_0_g302 );
			half temp_output_20_0_g302 = ( 1.0 / ( abs( temp_output_3_0_g302 ) + abs( temp_output_8_0_g302 ) ) );
			half temp_output_7_0_g302 = ( break6_g302.y - 0.5 );
			half2 appendResult16_g302 = (half2(( ( ( temp_output_5_0_g302 * temp_output_3_0_g302 * temp_output_20_0_g302 ) + ( temp_output_7_0_g302 * temp_output_8_0_g302 * temp_output_20_0_g302 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g302 * temp_output_3_0_g302 * temp_output_20_0_g302 ) - ( temp_output_5_0_g302 * temp_output_8_0_g302 * temp_output_20_0_g302 ) ) + 0.5 )));
			half Delay3_g346 = ( ( (_Band3Delay + (( appendResult16_g302.x * _Band3Pulse ) - 0.0) * (1.0 - _Band3Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g346 = AudioLinkLerp3_g346( Band3_g346 , Delay3_g346 );
			half temp_output_939_0 = localAudioLinkLerp3_g346;
			half clampResult1033 = clamp( (1.0 + (floor( ( temp_output_930_0.y - temp_output_939_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band3BarMode1035 = ( 1.0 - clampResult1033 );
			half ifLocalVar1045 = 0;
			if( _Band3BarAmp == 1.0 )
				ifLocalVar1045 = Band3BarMode1035;
			else
				ifLocalVar1045 = temp_output_939_0;
			#ifdef _B3_ON
				half4 staticSwitch1073 = ( tex2DNode961 * ifLocalVar1045 * _Band3Color.a );
			#else
				half4 staticSwitch1073 = float4( 0,0,0,0 );
			#endif
			half4 Band3Amp945 = staticSwitch1073;
			half3 ifLocalVar965 = 0;
			if( _Shake3DirectionSelect == 1.0 )
				ifLocalVar965 = _Shake3DirectionVector;
			else
				ifLocalVar965 = ase_vertexNormal;
			int Set9_g361 = _Shake3UV;
			half2 UV09_g361 = v.texcoord.xy;
			half2 UV19_g361 = v.texcoord1.xy;
			half2 UV29_g361 = v.texcoord2.xy;
			half2 UV39_g361 = v.texcoord3.xy;
			half2 appendResult40_g361 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g361 = appendResult40_g361;
			half2 appendResult41_g361 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g361 = appendResult41_g361;
			half2 appendResult42_g361 = (half2(0.0 , 0.0));
			half2 UV69_g361 = appendResult42_g361;
			half2 localUVSelector9_g361 = UVSelector9_g361( Set9_g361 , UV09_g361 , UV19_g361 , UV29_g361 , UV39_g361 , UV49_g361 , UV59_g361 , UV69_g361 );
			half4 ifLocalVar1101 = 0;
			if( _UseShake3 == 1.0 )
				ifLocalVar1101 = ( ( Band3Amp945 * _Shake3Intensity * half4( ifLocalVar965 , 0.0 ) ) * SAMPLE_TEXTURE2D_LOD( _Shake3Mask, sampler_linear_repeat, ( _Shake3Offset + ( _Shake3Tiling * localUVSelector9_g361 ) ), 0.0 ) );
			#ifdef _B3_ON
				half4 staticSwitch1074 = ifLocalVar1101;
			#else
				half4 staticSwitch1074 = float4( 0,0,0,0 );
			#endif
			half4 Band3Shake977 = staticSwitch1074;
			v.vertex.xyz += ( WorldNoise672 + Band0Shake743 + Band1Shake766 + Band2Shake909 + Band3Shake977 ).rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half mulTime418 = _Time.y * _MainScroll.x;
			half mulTime415 = _Time.y * _MainScroll.y;
			half2 appendResult420 = (half2(mulTime418 , mulTime415));
			int Set9_g343 = _UVMain;
			half2 UV09_g343 = i.uv_texcoord;
			half2 UV19_g343 = i.uv2_texcoord2;
			half2 UV29_g343 = i.uv3_texcoord3;
			half2 UV39_g343 = i.uv4_texcoord4;
			float3 ase_worldPos = i.worldPos;
			half2 appendResult40_g343 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g343 = appendResult40_g343;
			half2 appendResult41_g343 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g343 = appendResult41_g343;
			half2 appendResult42_g343 = (half2(0.0 , 0.0));
			half2 UV69_g343 = appendResult42_g343;
			half2 localUVSelector9_g343 = UVSelector9_g343( Set9_g343 , UV09_g343 , UV19_g343 , UV29_g343 , UV39_g343 , UV49_g343 , UV59_g343 , UV69_g343 );
			half2 MainUV339 = ( ( appendResult420 + _Offset ) + ( _Tiling * localUVSelector9_g343 ) );
			#ifdef _NormalMap_ON
				half3 staticSwitch1079 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_linear_repeat, MainUV339 ), _NormalMapSlider );
			#else
				half3 staticSwitch1079 = half3(0,0,1);
			#endif
			half3 NormalMap336 = staticSwitch1079;
			o.Normal = NormalMap336;
			half4 Albedo351 = ( _Color * SAMPLE_TEXTURE2D( _MainTex, sampler_linear_repeat, MainUV339 ) );
			half3 hsvTorgb1103 = RGBToHSV( Albedo351.rgb );
			half mulTime1134 = _Time.y * _HueTime;
			half3 hsvTorgb1104 = HSVToRGB( half3(( hsvTorgb1103.x + _HueModifier + mulTime1134 ),hsvTorgb1103.y,hsvTorgb1103.z) );
			o.Albedo = hsvTorgb1104;
			half4 EmissionMap354 = ( SAMPLE_TEXTURE2D( _EmissionMap, sampler_linear_repeat, MainUV339 ) * _EmissionColor );
			half mulTime571 = _Time.y * _ScrollEff.x;
			half mulTime572 = _Time.y * _ScrollEff.y;
			half2 appendResult573 = (half2(mulTime571 , mulTime572));
			int Set9_g349 = _UVEff;
			half2 UV09_g349 = i.uv_texcoord;
			half2 UV19_g349 = i.uv2_texcoord2;
			half2 UV29_g349 = i.uv3_texcoord3;
			half2 UV39_g349 = i.uv4_texcoord4;
			half2 appendResult40_g349 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g349 = appendResult40_g349;
			half2 appendResult41_g349 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g349 = appendResult41_g349;
			half2 appendResult42_g349 = (half2(0.0 , 0.0));
			half2 UV69_g349 = appendResult42_g349;
			half2 localUVSelector9_g349 = UVSelector9_g349( Set9_g349 , UV09_g349 , UV19_g349 , UV29_g349 , UV39_g349 , UV49_g349 , UV59_g349 , UV69_g349 );
			half3 hsvTorgb301 = RGBToHSV( ( _EffectColor * SAMPLE_TEXTURE2D( _EffectAlbedoMap, sampler_linear_repeat, ( ( appendResult573 + _OffsetEff ) + ( _TilingEff * localUVSelector9_g349 ) ) ) ).rgb );
			half mulTime297 = _Time.y * _ShiftSpeed;
			half3 hsvTorgb300 = HSVToRGB( half3(( hsvTorgb301.x + mulTime297 ),hsvTorgb301.y,hsvTorgb301.z) );
			half mulTime566 = _Time.y * _ScrollEffMask.x;
			half mulTime567 = _Time.y * _ScrollEffMask.y;
			half2 appendResult568 = (half2(mulTime566 , mulTime567));
			int Set9_g350 = _UVEffMask;
			half2 UV09_g350 = i.uv_texcoord;
			half2 UV19_g350 = i.uv2_texcoord2;
			half2 UV29_g350 = i.uv3_texcoord3;
			half2 UV39_g350 = i.uv4_texcoord4;
			half2 appendResult40_g350 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g350 = appendResult40_g350;
			half2 appendResult41_g350 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g350 = appendResult41_g350;
			half2 appendResult42_g350 = (half2(0.0 , 0.0));
			half2 UV69_g350 = appendResult42_g350;
			half2 localUVSelector9_g350 = UVSelector9_g350( Set9_g350 , UV09_g350 , UV19_g350 , UV29_g350 , UV39_g350 , UV49_g350 , UV59_g350 , UV69_g350 );
			half4 ifLocalVar310 = 0;
			if( _UseEmissionMapasMask >= 1.0 )
				ifLocalVar310 = EmissionMap354;
			else
				ifLocalVar310 = SAMPLE_TEXTURE2D( _EffectMask, sampler_linear_repeat, ( ( appendResult568 + _OffsetEffMask ) + ( _TilingEffMask * localUVSelector9_g350 ) ) );
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
			half3 temp_output_1_0_g355 = newWorldNormal402;
			half3 temp_output_4_0_g355 = ddx( temp_output_1_0_g355 );
			half dotResult6_g355 = dot( temp_output_4_0_g355 , temp_output_4_0_g355 );
			half3 temp_output_5_0_g355 = ddy( temp_output_1_0_g355 );
			half dotResult8_g355 = dot( temp_output_5_0_g355 , temp_output_5_0_g355 );
			half4 lerpResult424 = lerp( ( clampResult390 * _RimColor ) , float4( 0,0,0,0 ) , sqrt( sqrt( saturate( min( ( ( ( dotResult6_g355 + dotResult8_g355 ) * _AntiAliasingVariance ) * 2.0 ) , _AntiAliasingThreshold ) ) ) ));
			half4 ifLocalVar1092 = 0;
			if( _EnableRimlight == 1.0 )
				ifLocalVar1092 = ( lerpResult424 * _RimColor.a );
			half4 Rimlight395 = ifLocalVar1092;
			int Set9_g291 = _Band1UV;
			half2 UV09_g291 = i.uv_texcoord;
			half2 UV19_g291 = i.uv2_texcoord2;
			half2 UV29_g291 = i.uv3_texcoord3;
			half2 UV39_g291 = i.uv4_texcoord4;
			half2 appendResult40_g291 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g291 = appendResult40_g291;
			half2 appendResult41_g291 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g291 = appendResult41_g291;
			half2 appendResult42_g291 = (half2(0.0 , 0.0));
			half2 UV69_g291 = appendResult42_g291;
			half2 localUVSelector9_g291 = UVSelector9_g291( Set9_g291 , UV09_g291 , UV19_g291 , UV29_g291 , UV39_g291 , UV49_g291 , UV59_g291 , UV69_g291 );
			half2 temp_output_810_0 = ( _Band1Offset + ( _Band1Tiling * localUVSelector9_g291 ) );
			half3 hsvTorgb776 = RGBToHSV( ( SAMPLE_TEXTURE2D( _Band1Albedo, sampler_linear_repeat, temp_output_810_0 ) * _Band1Color ).rgb );
			int Band3_g347 = 1;
			half2 break6_g300 = (float2( 0,0 ) + (temp_output_810_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g300 = ( break6_g300.x - 0.5 );
			half temp_output_812_0 = radians( _Band1PulseRotation );
			half mulTime811 = _Time.y * _Band1RotateSpeed;
			half ifLocalVar1088 = 0;
			if( _Band1RotationoverTime == 1.0 )
				ifLocalVar1088 = ( temp_output_812_0 + mulTime811 );
			else
				ifLocalVar1088 = temp_output_812_0;
			half temp_output_2_0_g300 = ifLocalVar1088;
			half temp_output_3_0_g300 = cos( temp_output_2_0_g300 );
			half temp_output_8_0_g300 = sin( temp_output_2_0_g300 );
			half temp_output_20_0_g300 = ( 1.0 / ( abs( temp_output_3_0_g300 ) + abs( temp_output_8_0_g300 ) ) );
			half temp_output_7_0_g300 = ( break6_g300.y - 0.5 );
			half2 appendResult16_g300 = (half2(( ( ( temp_output_5_0_g300 * temp_output_3_0_g300 * temp_output_20_0_g300 ) + ( temp_output_7_0_g300 * temp_output_8_0_g300 * temp_output_20_0_g300 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g300 * temp_output_3_0_g300 * temp_output_20_0_g300 ) - ( temp_output_5_0_g300 * temp_output_8_0_g300 * temp_output_20_0_g300 ) ) + 0.5 )));
			half Delay3_g347 = ( ( (_Band1Delay + (( appendResult16_g300.x * _Band1Pulse ) - 0.0) * (1.0 - _Band1Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g347 = AudioLinkLerp3_g347( Band3_g347 , Delay3_g347 );
			half temp_output_772_0 = localAudioLinkLerp3_g347;
			half3 hsvTorgb756 = HSVToRGB( half3(( hsvTorgb776.x + ( _Band1HueShift * temp_output_772_0 ) ),hsvTorgb776.y,hsvTorgb776.z) );
			half clampResult1015 = clamp( (1.0 + (floor( ( temp_output_810_0.y - temp_output_772_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band1BarMode1017 = ( 1.0 - clampResult1015 );
			half ifLocalVar1039 = 0;
			if( _Band1BarAmp == 1.0 )
				ifLocalVar1039 = Band1BarMode1017;
			else
				ifLocalVar1039 = temp_output_772_0;
			int Set9_g352 = _Band1MaskUV;
			half2 UV09_g352 = i.uv_texcoord;
			half2 UV19_g352 = i.uv2_texcoord2;
			half2 UV29_g352 = i.uv3_texcoord3;
			half2 UV39_g352 = i.uv4_texcoord4;
			half2 appendResult40_g352 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g352 = appendResult40_g352;
			half2 appendResult41_g352 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g352 = appendResult41_g352;
			half2 appendResult42_g352 = (half2(0.0 , 0.0));
			half2 UV69_g352 = appendResult42_g352;
			half2 localUVSelector9_g352 = UVSelector9_g352( Set9_g352 , UV09_g352 , UV19_g352 , UV29_g352 , UV39_g352 , UV49_g352 , UV59_g352 , UV69_g352 );
			half4 tex2DNode784 = SAMPLE_TEXTURE2D( _Band1Mask, sampler_linear_repeat, ( _Band1MaskOffset + ( _Band1MaskTiling * localUVSelector9_g352 ) ) );
			#ifdef _B1_ON
				half4 staticSwitch1066 = ( half4( hsvTorgb756 , 0.0 ) * ifLocalVar1039 * tex2DNode784 );
			#else
				half4 staticSwitch1066 = float4( 0,0,0,0 );
			#endif
			half4 Band1Color777 = staticSwitch1066;
			int Set9_g290 = _Band0UV;
			half2 UV09_g290 = i.uv_texcoord;
			half2 UV19_g290 = i.uv2_texcoord2;
			half2 UV29_g290 = i.uv3_texcoord3;
			half2 UV39_g290 = i.uv4_texcoord4;
			half2 appendResult40_g290 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g290 = appendResult40_g290;
			half2 appendResult41_g290 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g290 = appendResult41_g290;
			half2 appendResult42_g290 = (half2(0.0 , 0.0));
			half2 UV69_g290 = appendResult42_g290;
			half2 localUVSelector9_g290 = UVSelector9_g290( Set9_g290 , UV09_g290 , UV19_g290 , UV29_g290 , UV39_g290 , UV49_g290 , UV59_g290 , UV69_g290 );
			half2 temp_output_696_0 = ( _Band0Offset + ( _Band0Tiling * localUVSelector9_g290 ) );
			half3 hsvTorgb726 = RGBToHSV( ( SAMPLE_TEXTURE2D( _Band0Albedo, sampler_linear_repeat, temp_output_696_0 ) * _Band0Color ).rgb );
			int Band3_g345 = 0;
			half2 break6_g301 = (float2( 0,0 ) + (temp_output_696_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g301 = ( break6_g301.x - 0.5 );
			half temp_output_691_0 = radians( _Band0PulseRotation );
			half mulTime694 = _Time.y * _Band0RotateSpeed;
			half ifLocalVar1090 = 0;
			if( _Band0RotationoverTime == 1.0 )
				ifLocalVar1090 = ( temp_output_691_0 + mulTime694 );
			else
				ifLocalVar1090 = temp_output_691_0;
			half temp_output_2_0_g301 = ifLocalVar1090;
			half temp_output_3_0_g301 = cos( temp_output_2_0_g301 );
			half temp_output_8_0_g301 = sin( temp_output_2_0_g301 );
			half temp_output_20_0_g301 = ( 1.0 / ( abs( temp_output_3_0_g301 ) + abs( temp_output_8_0_g301 ) ) );
			half temp_output_7_0_g301 = ( break6_g301.y - 0.5 );
			half2 appendResult16_g301 = (half2(( ( ( temp_output_5_0_g301 * temp_output_3_0_g301 * temp_output_20_0_g301 ) + ( temp_output_7_0_g301 * temp_output_8_0_g301 * temp_output_20_0_g301 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g301 * temp_output_3_0_g301 * temp_output_20_0_g301 ) - ( temp_output_5_0_g301 * temp_output_8_0_g301 * temp_output_20_0_g301 ) ) + 0.5 )));
			half Delay3_g345 = ( ( (_Band0Delay + (( appendResult16_g301.x * _Band0Pulse ) - 0.0) * (1.0 - _Band0Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g345 = AudioLinkLerp3_g345( Band3_g345 , Delay3_g345 );
			half temp_output_708_0 = localAudioLinkLerp3_g345;
			half3 hsvTorgb734 = HSVToRGB( half3(( hsvTorgb726.x + ( _Band0HueShift * temp_output_708_0 ) ),hsvTorgb726.y,hsvTorgb726.z) );
			half clampResult995 = clamp( (1.0 + (floor( ( temp_output_696_0.y - temp_output_708_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band0BarMode1000 = ( 1.0 - clampResult995 );
			half ifLocalVar1002 = 0;
			if( _Band0BarAmp == 1.0 )
				ifLocalVar1002 = Band0BarMode1000;
			else
				ifLocalVar1002 = temp_output_708_0;
			int Set9_g351 = _Band0MaskUV;
			half2 UV09_g351 = i.uv_texcoord;
			half2 UV19_g351 = i.uv2_texcoord2;
			half2 UV29_g351 = i.uv3_texcoord3;
			half2 UV39_g351 = i.uv4_texcoord4;
			half2 appendResult40_g351 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g351 = appendResult40_g351;
			half2 appendResult41_g351 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g351 = appendResult41_g351;
			half2 appendResult42_g351 = (half2(0.0 , 0.0));
			half2 UV69_g351 = appendResult42_g351;
			half2 localUVSelector9_g351 = UVSelector9_g351( Set9_g351 , UV09_g351 , UV19_g351 , UV29_g351 , UV39_g351 , UV49_g351 , UV59_g351 , UV69_g351 );
			half4 tex2DNode736 = SAMPLE_TEXTURE2D( _Band0Mask, sampler_linear_repeat, ( _Band0MaskOffset + ( _Band0MaskTiling * localUVSelector9_g351 ) ) );
			#ifdef _B0_ON
				half4 staticSwitch1063 = ( half4( hsvTorgb734 , 0.0 ) * ifLocalVar1002 * tex2DNode736 );
			#else
				half4 staticSwitch1063 = float4( 0,0,0,0 );
			#endif
			half4 Band0Color744 = staticSwitch1063;
			int Set9_g295 = _Band2UV;
			half2 UV09_g295 = i.uv_texcoord;
			half2 UV19_g295 = i.uv2_texcoord2;
			half2 UV29_g295 = i.uv3_texcoord3;
			half2 UV39_g295 = i.uv4_texcoord4;
			half2 appendResult40_g295 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g295 = appendResult40_g295;
			half2 appendResult41_g295 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g295 = appendResult41_g295;
			half2 appendResult42_g295 = (half2(0.0 , 0.0));
			half2 UV69_g295 = appendResult42_g295;
			half2 localUVSelector9_g295 = UVSelector9_g295( Set9_g295 , UV09_g295 , UV19_g295 , UV29_g295 , UV39_g295 , UV49_g295 , UV59_g295 , UV69_g295 );
			half2 temp_output_860_0 = ( _Band2Offset + ( _Band2Tiling * localUVSelector9_g295 ) );
			half3 hsvTorgb879 = RGBToHSV( ( SAMPLE_TEXTURE2D( _Band2Albedo, sampler_linear_repeat, temp_output_860_0 ) * _Band2Color ).rgb );
			int Band3_g348 = 2;
			half2 break6_g303 = (float2( 0,0 ) + (temp_output_860_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g303 = ( break6_g303.x - 0.5 );
			half temp_output_853_0 = radians( _Band2PulseRotation );
			half mulTime854 = _Time.y * _Band2RotateSpeed;
			half ifLocalVar1087 = 0;
			if( _Band2RotationoverTime == 1.0 )
				ifLocalVar1087 = ( temp_output_853_0 + mulTime854 );
			else
				ifLocalVar1087 = temp_output_853_0;
			half temp_output_2_0_g303 = ifLocalVar1087;
			half temp_output_3_0_g303 = cos( temp_output_2_0_g303 );
			half temp_output_8_0_g303 = sin( temp_output_2_0_g303 );
			half temp_output_20_0_g303 = ( 1.0 / ( abs( temp_output_3_0_g303 ) + abs( temp_output_8_0_g303 ) ) );
			half temp_output_7_0_g303 = ( break6_g303.y - 0.5 );
			half2 appendResult16_g303 = (half2(( ( ( temp_output_5_0_g303 * temp_output_3_0_g303 * temp_output_20_0_g303 ) + ( temp_output_7_0_g303 * temp_output_8_0_g303 * temp_output_20_0_g303 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g303 * temp_output_3_0_g303 * temp_output_20_0_g303 ) - ( temp_output_5_0_g303 * temp_output_8_0_g303 * temp_output_20_0_g303 ) ) + 0.5 )));
			half Delay3_g348 = ( ( (_Band2Delay + (( appendResult16_g303.x * _Band2Pulse ) - 0.0) * (1.0 - _Band2Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g348 = AudioLinkLerp3_g348( Band3_g348 , Delay3_g348 );
			half temp_output_869_0 = localAudioLinkLerp3_g348;
			half3 hsvTorgb891 = HSVToRGB( half3(( hsvTorgb879.x + ( _Band2HueShift * temp_output_869_0 ) ),hsvTorgb879.y,hsvTorgb879.z) );
			half clampResult1024 = clamp( (1.0 + (floor( ( temp_output_860_0.y - temp_output_869_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band2BarMode1026 = ( 1.0 - clampResult1024 );
			half ifLocalVar1042 = 0;
			if( _Band2BarAmp == 1.0 )
				ifLocalVar1042 = Band2BarMode1026;
			else
				ifLocalVar1042 = temp_output_869_0;
			int Set9_g353 = _Band2MaskUV;
			half2 UV09_g353 = i.uv_texcoord;
			half2 UV19_g353 = i.uv2_texcoord2;
			half2 UV29_g353 = i.uv3_texcoord3;
			half2 UV39_g353 = i.uv4_texcoord4;
			half2 appendResult40_g353 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g353 = appendResult40_g353;
			half2 appendResult41_g353 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g353 = appendResult41_g353;
			half2 appendResult42_g353 = (half2(0.0 , 0.0));
			half2 UV69_g353 = appendResult42_g353;
			half2 localUVSelector9_g353 = UVSelector9_g353( Set9_g353 , UV09_g353 , UV19_g353 , UV29_g353 , UV39_g353 , UV49_g353 , UV59_g353 , UV69_g353 );
			half4 tex2DNode893 = SAMPLE_TEXTURE2D( _Band2Mask, sampler_linear_repeat, ( _Band2MaskOffset + ( _Band2MaskTiling * localUVSelector9_g353 ) ) );
			#ifdef _B2_ON
				half4 staticSwitch1069 = ( half4( hsvTorgb891 , 0.0 ) * ifLocalVar1042 * tex2DNode893 );
			#else
				half4 staticSwitch1069 = float4( 0,0,0,0 );
			#endif
			half4 Band2Color904 = staticSwitch1069;
			int Set9_g292 = _Band3UV;
			half2 UV09_g292 = i.uv_texcoord;
			half2 UV19_g292 = i.uv2_texcoord2;
			half2 UV29_g292 = i.uv3_texcoord3;
			half2 UV39_g292 = i.uv4_texcoord4;
			half2 appendResult40_g292 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g292 = appendResult40_g292;
			half2 appendResult41_g292 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g292 = appendResult41_g292;
			half2 appendResult42_g292 = (half2(0.0 , 0.0));
			half2 UV69_g292 = appendResult42_g292;
			half2 localUVSelector9_g292 = UVSelector9_g292( Set9_g292 , UV09_g292 , UV19_g292 , UV29_g292 , UV39_g292 , UV49_g292 , UV59_g292 , UV69_g292 );
			half2 temp_output_930_0 = ( _Band3Offset + ( _Band3Tiling * localUVSelector9_g292 ) );
			half3 hsvTorgb950 = RGBToHSV( ( SAMPLE_TEXTURE2D( _Band3Albedo, sampler_linear_repeat, temp_output_930_0 ) * _Band3Color ).rgb );
			int Band3_g346 = 3;
			half2 break6_g302 = (float2( 0,0 ) + (temp_output_930_0 - float2( 0,0 )) * (float2( 0.9,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 )));
			half temp_output_5_0_g302 = ( break6_g302.x - 0.5 );
			half temp_output_922_0 = radians( _Band3PulseRotation );
			half mulTime923 = _Time.y * _Band3RotateSpeed;
			half ifLocalVar1084 = 0;
			if( _Band3RotationoverTime == 1.0 )
				ifLocalVar1084 = ( temp_output_922_0 + mulTime923 );
			else
				ifLocalVar1084 = temp_output_922_0;
			half temp_output_2_0_g302 = ifLocalVar1084;
			half temp_output_3_0_g302 = cos( temp_output_2_0_g302 );
			half temp_output_8_0_g302 = sin( temp_output_2_0_g302 );
			half temp_output_20_0_g302 = ( 1.0 / ( abs( temp_output_3_0_g302 ) + abs( temp_output_8_0_g302 ) ) );
			half temp_output_7_0_g302 = ( break6_g302.y - 0.5 );
			half2 appendResult16_g302 = (half2(( ( ( temp_output_5_0_g302 * temp_output_3_0_g302 * temp_output_20_0_g302 ) + ( temp_output_7_0_g302 * temp_output_8_0_g302 * temp_output_20_0_g302 ) ) + 0.5 ) , ( ( ( temp_output_7_0_g302 * temp_output_3_0_g302 * temp_output_20_0_g302 ) - ( temp_output_5_0_g302 * temp_output_8_0_g302 * temp_output_20_0_g302 ) ) + 0.5 )));
			half Delay3_g346 = ( ( (_Band3Delay + (( appendResult16_g302.x * _Band3Pulse ) - 0.0) * (1.0 - _Band3Delay) / (1.0 - 0.0)) % 1.0 ) * 128.0 );
			half localAudioLinkLerp3_g346 = AudioLinkLerp3_g346( Band3_g346 , Delay3_g346 );
			half temp_output_939_0 = localAudioLinkLerp3_g346;
			half3 hsvTorgb960 = HSVToRGB( half3(( hsvTorgb950.x + ( _Band3HueShift * temp_output_939_0 ) ),hsvTorgb950.y,hsvTorgb950.z) );
			half clampResult1033 = clamp( (1.0 + (floor( ( temp_output_930_0.y - temp_output_939_0 ) ) - 0.0) * (100.0 - 1.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			half Band3BarMode1035 = ( 1.0 - clampResult1033 );
			half ifLocalVar1045 = 0;
			if( _Band3BarAmp == 1.0 )
				ifLocalVar1045 = Band3BarMode1035;
			else
				ifLocalVar1045 = temp_output_939_0;
			int Set9_g354 = _Band3MaskUV;
			half2 UV09_g354 = i.uv_texcoord;
			half2 UV19_g354 = i.uv2_texcoord2;
			half2 UV29_g354 = i.uv3_texcoord3;
			half2 UV39_g354 = i.uv4_texcoord4;
			half2 appendResult40_g354 = (half2(ase_worldPos.x , 0.0));
			half2 UV49_g354 = appendResult40_g354;
			half2 appendResult41_g354 = (half2(ase_worldPos.x , 0.0));
			half2 UV59_g354 = appendResult41_g354;
			half2 appendResult42_g354 = (half2(0.0 , 0.0));
			half2 UV69_g354 = appendResult42_g354;
			half2 localUVSelector9_g354 = UVSelector9_g354( Set9_g354 , UV09_g354 , UV19_g354 , UV29_g354 , UV39_g354 , UV49_g354 , UV59_g354 , UV69_g354 );
			half4 tex2DNode961 = SAMPLE_TEXTURE2D( _Band3Mask, sampler_linear_repeat, ( _Band3MaskOffset + ( _Band3MaskTiling * localUVSelector9_g354 ) ) );
			#ifdef _B3_ON
				half4 staticSwitch1072 = ( half4( hsvTorgb960 , 0.0 ) * ifLocalVar1045 * tex2DNode961 );
			#else
				half4 staticSwitch1072 = float4( 0,0,0,0 );
			#endif
			half4 Band3Color974 = staticSwitch1072;
			#ifdef _B0_ON
				half4 staticSwitch1064 = ( ifLocalVar1002 * tex2DNode736 * _Band0Color.a );
			#else
				half4 staticSwitch1064 = float4( 0,0,0,0 );
			#endif
			half4 Band0Amp720 = staticSwitch1064;
			#ifdef _B1_ON
				half4 staticSwitch1067 = ( ifLocalVar1039 * tex2DNode784 * _Band1Color.a );
			#else
				half4 staticSwitch1067 = float4( 0,0,0,0 );
			#endif
			half4 Band1Amp768 = staticSwitch1067;
			#ifdef _B2_ON
				half4 staticSwitch1070 = ( ifLocalVar1042 * tex2DNode893 * _Band2Color.a );
			#else
				half4 staticSwitch1070 = float4( 0,0,0,0 );
			#endif
			half4 Band2Amp875 = staticSwitch1070;
			#ifdef _B3_ON
				half4 staticSwitch1073 = ( tex2DNode961 * ifLocalVar1045 * _Band3Color.a );
			#else
				half4 staticSwitch1073 = float4( 0,0,0,0 );
			#endif
			half4 Band3Amp945 = staticSwitch1073;
			half4 clampResult1049 = clamp( ( Band0Amp720 + Band1Amp768 + Band2Amp875 + Band3Amp945 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			half4 lerpResult834 = lerp( ( EffectMap359 + Rimlight395 ) , ( Band1Color777 + Band0Color744 + Band2Color904 + Band3Color974 ) , clampResult1049);
			half4 EmissionFinal846 = lerpResult834;
			half3 hsvTorgb1105 = RGBToHSV( EmissionFinal846.rgb );
			half3 hsvTorgb1106 = HSVToRGB( half3(( hsvTorgb1105.x + _HueModifier + mulTime1134 ),hsvTorgb1105.y,hsvTorgb1105.z) );
			o.Emission = hsvTorgb1106;
			half4 tex2DNode59 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_linear_repeat, MainUV339 );
			half3 ase_worldNormal = WorldNormalVector( i, half3( 0, 0, 1 ) );
			half3 temp_output_1_0_g362 = ase_worldNormal;
			half3 temp_output_4_0_g362 = ddx( temp_output_1_0_g362 );
			half dotResult6_g362 = dot( temp_output_4_0_g362 , temp_output_4_0_g362 );
			half3 temp_output_5_0_g362 = ddy( temp_output_1_0_g362 );
			half dotResult8_g362 = dot( temp_output_5_0_g362 , temp_output_5_0_g362 );
			half lerpResult443 = lerp( _Glossiness , 0.0 , sqrt( sqrt( saturate( min( ( ( ( dotResult6_g362 + dotResult8_g362 ) * _AntiAliasingVarianceSm ) * 2.0 ) , _AntiAliasingThresholdSm ) ) ) ));
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
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

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
89.6;132.8;2232;1533;7259.226;3146.085;4.07602;True;False
Node;AmplifyShaderEditor.CommentaryNode;1004;-5533.381,-7076.395;Inherit;False;5407.196;8957.329;;6;747;750;751;849;917;685;AudioLink;1,0,0.7756052,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;917;-5040.133,-148.7535;Inherit;False;4509.248;1745.854;;5;981;978;919;918;1027;Band 3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;-5083.649,-4452.433;Inherit;False;4509.248;1745.854;;5;800;781;753;752;1009;Band 1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;685;-5100.974,-6687.812;Inherit;False;4509.248;1745.854;;6;746;745;687;686;998;1003;Band 0;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;918;-4756.647,82.27334;Inherit;False;4199.426;561.84;;43;974;968;961;960;953;952;951;950;949;948;947;946;945;944;943;942;941;939;938;937;936;934;933;932;931;930;928;926;925;924;923;922;921;920;985;1045;1046;1047;1072;1073;1084;1085;1132;Band 3 Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;849;-5058.012,-2297.015;Inherit;False;4509.248;1745.854;;5;911;910;882;850;1018;Band 2;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;752;-4799.161,-4221.408;Inherit;False;4199.426;561.84;;43;812;811;810;807;806;805;798;797;796;795;794;792;791;790;789;788;787;786;785;784;783;777;776;774;772;770;768;763;759;756;755;754;817;848;982;1039;1040;1041;1066;1067;1088;1089;1130;Band 1 Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;686;-4816.487,-6456.782;Inherit;False;4199.426;561.84;;42;744;740;736;734;733;731;728;727;726;725;723;720;715;713;711;710;708;706;705;703;702;701;700;697;696;694;693;692;691;690;689;688;815;816;983;1001;1002;1063;1064;1090;1091;1129;Band 0 Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;920;-4539.355,429.0364;Inherit;False;Property;_Band3RotateSpeed;Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band3RotationoverTime==1}};163;0;Create;False;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;850;-4771.525,-2059.988;Inherit;False;4199.426;561.84;;43;904;895;893;891;885;884;883;881;880;879;878;877;876;875;874;873;872;870;869;868;867;865;864;863;862;860;859;858;857;856;854;853;852;851;984;1042;1043;1044;1069;1070;1086;1087;1131;Band 2 Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;921;-4539.199,340.4003;Inherit;False;Property;_Band3PulseRotation;Rotation;161;0;Create;False;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;795;-4581.871,-3874.645;Inherit;False;Property;_Band1RotateSpeed;Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band1RotationoverTime==1}};105;0;Create;False;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;689;-4599.197,-6110.018;Inherit;False;Property;_Band0RotateSpeed;Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band0RotationoverTime==1}};76;0;Create;False;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;794;-4581.715,-3963.281;Inherit;False;Property;_Band1PulseRotation;Rotation;103;0;Create;False;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;688;-4599.042,-6198.652;Inherit;False;Property;_Band0PulseRotation;Rotation;74;0;Create;False;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;797;-4777.225,-3925.602;Inherit;False;Property;_Band1Offset;Offset;93;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RadiansOpNode;922;-4211.916,357.1923;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;926;-4717.588,510.3404;Inherit;False;Property;_Band3UV;UV;152;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;796;-4760.104,-3793.339;Inherit;False;Property;_Band1UV;UV;94;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;798;-4770.543,-4055.29;Inherit;False;Property;_Band1Tiling;Tiling;92;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;928;-4733.432,378.0786;Inherit;False;Property;_Band3Offset;Offset;151;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RadiansOpNode;812;-4254.432,-3946.488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;923;-4238.927,435.8704;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;851;-4554.078,-1801.861;Inherit;False;Property;_Band2PulseRotation;Rotation;132;0;Create;False;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;811;-4281.445,-3867.811;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;691;-4271.758,-6181.864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;692;-4787.869,-6290.662;Inherit;False;Property;_Band0Tiling;Tiling;63;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;694;-4298.771,-6103.184;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;693;-4794.55,-6160.975;Inherit;False;Property;_Band0Offset;Offset;64;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;690;-4777.43,-6028.713;Inherit;False;Property;_Band0UV;UV;65;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;1006;228.096,-5042.061;Inherit;False;3385.644;2894.609;;4;349;357;350;353;PBR;0,1,0.5443456,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;852;-4554.233,-1713.225;Inherit;False;Property;_Band2RotateSpeed;Speed--{condition_show:{type:PROPERTY_BOOL,data:_Band2RotationoverTime==1}};134;0;Create;False;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;925;-4728.028,248.3896;Inherit;False;Property;_Band3Tiling;Tiling;150;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;807;-4073.443,-3991.811;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;854;-4253.806,-1706.391;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;857;-4732.467,-1631.921;Inherit;False;Property;_Band2UV;UV;123;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;856;-4749.588,-1764.183;Inherit;False;Property;_Band2Offset;Offset;122;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RadiansOpNode;853;-4226.794,-1785.069;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1089;-4300.662,-4017.65;Inherit;False;Property;_Band1RotationoverTime;Rotation over Time;104;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;930;-4516.655,167.1303;Inherit;False;UV Selector;-1;;292;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;859;-4742.907,-1893.873;Inherit;False;Property;_Band2Tiling;Tiling;121;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;924;-4045.926,309.8705;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;697;-4101.77,-6126.182;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1091;-4137.834,-6225.8;Inherit;False;Property;_Band0RotationoverTime;Rotation over Time;75;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;696;-4576.499,-6371.921;Inherit;False;UV Selector;-1;;290;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;353;309.5103,-4822.507;Inherit;False;3151.7;441.8367;;16;93;420;419;417;415;418;327;53;351;92;52;339;293;428;51;645;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1085;-4128,224;Inherit;False;Property;_Band3RotationoverTime;Rotation over Time;162;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;810;-4559.172,-4136.55;Inherit;False;UV Selector;-1;;291;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;1132;-3885.405,136.749;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.9,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;1084;-3888,320;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1090;-3910.136,-6250.8;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1086;-4151.626,-1910.554;Inherit;False;Property;_Band2RotationoverTime;Rotation over Time;133;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;860;-4531.534,-1975.131;Inherit;False;UV Selector;-1;;295;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;417;338.2161,-4728.423;Inherit;False;Property;_MainScroll;Scroll;20;0;Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ConditionalIfNode;1088;-3929.662,-3930.65;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1129;-4111.405,-6409.251;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.9,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;858;-4071.205,-1792.09;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1130;-4092.405,-4177.251;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.9,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;700;-3702.353,-6395.658;Inherit;False;RotateUVFill;-1;;301;459952d587cbfe742a7e7f4a8a0a4169;0;2;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;1087;-3896.626,-1861.554;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;806;-3718.44,-4144.869;Inherit;True;RotateUVFill;-1;;300;459952d587cbfe742a7e7f4a8a0a4169;0;2;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;931;-3670.51,177.2646;Inherit;True;RotateUVFill;-1;;302;459952d587cbfe742a7e7f4a8a0a4169;0;2;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;418;609.2158,-4742.423;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;415;607.2158,-4659.423;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1131;-3907.405,-2037.251;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.9,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;792;-3557.642,-3823.142;Inherit;False;Property;_Band1Delay;Delay;100;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;805;-3563.564,-3910.278;Inherit;False;Property;_Band1Pulse;Pulse;101;0;Create;False;1;Pulse Across UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;932;-3511.288,480.5374;Inherit;False;Property;_Band3Delay;Delay;158;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;934;-3386.589,296.9506;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;933;-3522.211,393.4033;Inherit;False;Property;_Band3Pulse;Pulse;159;0;Create;False;1;Pulse Across UVs;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;791;-3429.106,-4006.731;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;93;843.0436,-4594.829;Inherit;False;Property;_Offset;Offset;18;0;Create;True;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;703;-3571.968,-6035.516;Inherit;False;Property;_Band0Delay;Delay;71;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;701;-3573.129,-6131.287;Inherit;False;Property;_Band0Pulse;Pulse;72;0;Create;False;1;Pulse Across UVs;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;420;854.7159,-4749.923;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;862;-3684.389,-1978.998;Inherit;True;RotateUVFill;-1;;303;459952d587cbfe742a7e7f4a8a0a4169;0;2;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;702;-3425.432,-6241.102;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;92;1198.033,-4756.578;Inherit;False;Property;_Tiling;Tiling;17;0;Create;True;0;0;0;False;2;Vector2;Space;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;293;1110.807,-4492.527;Inherit;False;Property;_UVMain;UV;19;0;Create;False;0;4;UV0;0;UV1;1;UV2;2;UV3;3;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;863;-3530.004,-1661.724;Inherit;False;Property;_Band2Delay;Delay;129;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1124;-3240.202,-3864.536;Inherit;False;BandPulse;-1;;342;c478702160369ce4480fa2fb6d734ffa;0;3;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;864;-3401.467,-1845.312;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;865;-3537.089,-1748.858;Inherit;False;Property;_Band2Pulse;Pulse;130;0;Create;False;1;Pulse Across UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1125;-3197.686,439.1446;Inherit;False;BandPulse;-1;;340;c478702160369ce4480fa2fb6d734ffa;0;3;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1007;152.4413,-1974.776;Inherit;False;3712.167;2907.922;;3;671;393;477;Effects;1,0,0.3941193,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;419;1023.715,-4671.173;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1126;-3257.527,-6099.911;Inherit;False;BandPulse;-1;;341;c478702160369ce4480fa2fb6d734ffa;0;3;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;774;-3005.502,-3844.829;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;128;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1127;-3212.564,-1703.117;Inherit;False;BandPulse;-1;;344;c478702160369ce4480fa2fb6d734ffa;0;3;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;936;-2964.499,358.9335;Inherit;False;Constant;_Band3;Band 3;50;0;Create;True;0;0;0;False;0;False;3;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;789;-3010.283,-3944.747;Inherit;False;Constant;_Band1;Band 1;50;0;Create;True;0;0;0;False;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;937;-2962.985,458.8514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;128;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;477;296.0154,-1592.815;Inherit;False;3370.17;750.7358;;40;359;307;355;300;310;302;356;358;311;301;297;209;433;309;298;308;258;412;569;432;568;414;223;566;567;574;264;565;573;263;571;572;570;413;262;261;647;646;1057;1076;Emission Overlay;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;706;-3022.828,-6080.204;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;128;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;645;1516.386,-4743.275;Inherit;False;UV Selector;-1;;343;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;705;-3022.128,-6182.334;Inherit;False;Constant;_Band0;Band 0;50;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SamplerStateNode;327;1846.941,-4672.258;Inherit;False;0;0;0;1;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.FunctionNode;772;-2840.852,-3852.513;Inherit;False;4BandAmplitudeLerp;-1;;347;3cf4b6e83381a9a4f84f8cf857bc3af5;0;2;2;INT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1027;-2469.63,765.6385;Inherit;False;1855.127;426.3975;;8;1035;1034;1033;1032;1031;1030;1028;1038;Bar Mode;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;867;-2977.864,-1683.41;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;128;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1009;-2533.22,-3533.683;Inherit;False;1855.127;426.3975;;8;1017;1016;1015;1014;1013;1012;1010;1036;Bar Mode;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;350;322.4894,-2787.082;Inherit;False;1304.338;547.112;;7;55;56;54;343;336;430;1079;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;868;-2979.377,-1783.328;Inherit;False;Constant;_Band2;Band 2;50;0;Create;True;0;0;0;False;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;570;373.2465,-1285.321;Inherit;False;Property;_ScrollEff;Scroll;30;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;428;2089.254,-4624.942;Inherit;False;Sampler;-1;True;1;0;SAMPLERSTATE;0,0;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.FunctionNode;708;-2854.797,-6095.887;Inherit;False;4BandAmplitudeLerp;-1;;345;3cf4b6e83381a9a4f84f8cf857bc3af5;0;2;2;INT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;339;1898.818,-4527.127;Inherit;False;MainUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1018;-2527.904,-1367.761;Inherit;False;1855.127;426.3975;;7;1026;1025;1024;1023;1022;1021;1019;Bar Mode;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;998;-2541.255,-5767.293;Inherit;False;1855.127;426.3975;;8;999;1000;996;995;994;993;992;997;Bar Mode;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;939;-2798.336,451.1675;Inherit;False;4BandAmplitudeLerp;-1;;346;3cf4b6e83381a9a4f84f8cf857bc3af5;0;2;2;INT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;571;629.2467,-1304.321;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1010;-2493.738,-3446.295;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;1028;-2299.1,828.8284;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;1019;-2516.452,-1321.01;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;869;-2813.214,-1691.094;Inherit;False;4BandAmplitudeLerp;-1;;348;3cf4b6e83381a9a4f84f8cf857bc3af5;0;2;2;INT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;999;-2501.091,-5669.5;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;1038;-2414.842,819.0309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;343;456.7505,-2504.824;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;572;625.0706,-1221.321;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;997;-2395.011,-5632.167;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1036;-2424.164,-3450.685;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;359.015,-2593.066;Inherit;False;Property;_NormalMapSlider;Normal Map Slider;13;1;[HideInInspector];Create;False;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;430;454.6226,-2422.273;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1030;-1954.835,947.2967;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1012;-2018.425,-3352.025;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;56;826.4747,-2420.066;Inherit;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;263;850.6425,-1155.594;Inherit;False;Property;_OffsetEff;Offset;29;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1021;-2103.589,-1210.31;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;992;-2026.46,-5585.635;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;55;667.8158,-2632.708;Inherit;True;Property;_BumpMap;Normal Map--{reference_property:_NormalMapSlider,condition_show:{type:PROPERTY_BOOL,data:_UseNormalMap==1}};12;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;False;0;0;0;False;0;False;51;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;573;832.7468,-1288.821;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;565;633.7377,-1489.576;Inherit;False;Property;_ScrollEffMask;Scroll;37;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;357;323.1516,-3421.313;Inherit;False;1224.44;469.0579;;6;354;50;109;342;233;431;Emission Base;1,1,1,1;0;0
Node;AmplifyShaderEditor.FloorOpNode;1013;-1789.276,-3260.196;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;1031;-1725.686,1039.125;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;264;857.6425,-978.2061;Inherit;False;Property;_TilingEff;Tiling;28;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;574;1025.746,-1181.071;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;223;1024.645,-1065.912;Inherit;False;Property;_UVEff;UV;31;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;Option5;4;Option6;5;Option7;6;Option8;7;Option9;8;Option10;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FloorOpNode;993;-1797.311,-5493.806;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;1022;-1895.594,-1205.324;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;566;907.5134,-1500.8;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;567;905.5134,-1417.801;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1079;1026.552,-2628.31;Inherit;False;Property;_UseNormalMap;Enable Normal Map;11;0;Create;False;0;0;0;False;0;False;0;0;0;True;_NormalMap_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;1032;-1530.961,978.8245;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;414;1147.351,-1371.141;Inherit;False;Property;_OffsetEffMask;Offset;35;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;568;1153.013,-1508.3;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;1014;-1594.551,-3320.497;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1023;-1649.957,-1261.065;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;430.1315,-3305.271;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;1281.888,-2625.375;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;646;1192.539,-1114.024;Inherit;False;UV Selector;-1;;349;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;430.2509,-3216.043;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.GetLocalVarNode;432;1219.34,-947.6233;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.CommentaryNode;393;304.8026,-659.6858;Inherit;False;2554.657;526.206;;20;395;424;421;422;391;392;390;389;402;387;388;386;406;442;446;397;398;1058;1092;1093;Rimlight;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;994;-1602.586,-5554.107;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1033;-1287.104,932.6624;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;308;1534.536,-1324.684;Inherit;False;Property;_EffectColor;Effect Color;15;2;[HideInInspector];[HDR];Create;False;0;0;0;False;1;hide_in_inspector;False;0,0,0,1;0.7169812,0.4633322,0.4633322,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;787.5749,-3156.41;Inherit;False;Property;_EmissionColor;Emission Color;14;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;0.7169812,0.4633322,0.4633322,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;995;-1358.729,-5600.269;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;569;1325.012,-1399.551;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;413;1319.023,-1541.207;Inherit;False;Property;_TilingEffMask;Tiling;34;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;1024;-1391.446,-1260.759;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;870;-3401.001,-2006.482;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;325.0794,-591.1275;Inherit;False;336;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;817;-3428.639,-4167.901;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SamplerNode;233;665.1648,-3374.1;Inherit;True;Property;_EmissionMap;Emission Map--{reference_property:_EmissionColor};16;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;51;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;815;-3436.453,-6388.162;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.ClampOpNode;1015;-1350.694,-3366.659;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;258;1462.555,-1149.228;Inherit;True;Property;_EffectAlbedoMap;Effect Albedo Map--{reference_property:_EffectColor,reference_properties:[_TilingEff,_OffsetEff,_ScrollEff,_UVEff]};26;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;51;None;c258fb960e534b54e9e6e463bc4369b1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;412;1234.122,-1222.59;Inherit;False;Property;_UVEffMask;UV;36;1;[HideInInspector];Create;False;0;4;UV0;0;UV1;1;UV2;2;UV3;3;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;938;-3386.123,135.7797;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.ColorNode;790;-2842.288,-4057.183;Inherit;False;Property;_Band1Color;Color;91;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;32,32,32,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;942;-2798.608,246.4965;Inherit;False;Property;_Band3Color;Color;149;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;32,32,32,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;711;-3231.854,-6383.572;Inherit;True;Property;_Band0Albedo;Albedo Map--{reference_property:_Band0Color,reference_properties:[_Band0Tiling,_Band0Offset,_Band0UV]};61;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;710;-2859.614,-6292.562;Inherit;False;Property;_Band0Color;Color;62;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;32,32,32,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;872;-2813.486,-1895.765;Inherit;False;Property;_Band2Color;Color;120;2;[HideInInspector];[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;32,32,32,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;1089.171,-3223.919;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;1025;-1119.985,-1199.981;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;941;-3179.163,157.8647;Inherit;True;Property;_Band3Albedo;Albedo Map--{reference_property:_Band3Color,reference_properties:[_Band3Tiling,_Band3Offset,_Band3UV]};148;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;386;430.8954,-330.1966;Inherit;False;Property;_Scale;Scale;43;0;Create;True;0;0;0;False;0;False;1;0.48;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1016;-1074.419,-3330.327;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;402;518.451,-591.129;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;1034;-1025.829,964.9944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;996;-1082.454,-5563.937;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;388;428.0912,-423.7188;Inherit;False;Property;_Bias;Bias;42;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;387;431.8955,-238.1965;Inherit;False;Property;_Power;Power;44;0;Create;True;0;0;0;False;0;False;1;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;783;-3221.679,-4145.817;Inherit;True;Property;_Band1Albedo;Albedo Map--{reference_property:_Band1Color,reference_properties:[_Band1Tiling,_Band1Offset,_Band1UV]};90;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;1851.345,-1234.727;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;298;1793.701,-1085.211;Inherit;False;Property;_ShiftSpeed;Shift Speed;27;0;Create;True;0;0;0;False;0;False;1;0.25;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;873;-3194.041,-1984.397;Inherit;True;Property;_Band2Albedo;Albedo Map--{reference_property:_Band2Color,reference_properties:[_Band2Tiling,_Band2Offset,_Band2UV]};119;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;647;1524.016,-1502.703;Inherit;False;UV Selector;-1;;350;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;433;1833.265,-1472.058;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.Vector2Node;728;-2405.464,-6061.03;Inherit;False;Property;_Band0MaskTiling;Tiling;67;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;788;-2380.139,-3786.654;Inherit;False;Property;_Band1MaskTiling;Tiling;96;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;209;2038.336,-1373.991;Inherit;True;Property;_EffectMask;Effect Mask Map--{reference_properties:[_TilingEffMask,_OffsetEffMask,_ScrollEffMask,_UVEffMask]};32;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;51;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;713;-2600.221,-6387.722;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;878;-2348.501,-1624.236;Inherit;False;Property;_Band2MaskTiling;Tiling;125;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;715;-2235.398,-6272.542;Inherit;False;Property;_Band0HueShift;Hue Shift;70;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1017;-881.5655,-3307.949;Inherit;False;Band1BarMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1026;-876.2485,-1142.027;Inherit;False;Band2BarMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1000;-889.6002,-5541.559;Inherit;False;Band0BarMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1035;-815.9751,992.3724;Inherit;False;Band3BarMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;944;-2177.556,278.5107;Inherit;False;Property;_Band3HueShift;Hue Shift;157;0;Create;False;0;0;0;False;0;False;0.420841;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;881;-2203.835,-1626.88;Inherit;False;Property;_Band2MaskOffset;Offset;126;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;947;-2192.957,518.3814;Inherit;False;Property;_Band3MaskOffset;Offset;155;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;723;-2258.798,-6025.692;Inherit;False;Property;_Band0MaskOffset;Offset;68;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.IntNode;877;-2194.491,-1703.896;Inherit;False;Property;_Band2MaskUV;UV;127;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;785;-2220.072,-4025.169;Inherit;False;Property;_Band1HueShift;Hue Shift;99;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;297;2152.187,-993.9658;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;770;-2582.895,-4152.349;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;876;-2555.256,-1990.93;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;948;-2348.623,523.0255;Inherit;False;Property;_Band3MaskTiling;Tiling;154;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RGBToHSVNode;301;2127.785,-1154.379;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;786;-2232.129,-3862.315;Inherit;False;Property;_Band1MaskUV;UV;98;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;725;-2250.455,-6107.69;Inherit;False;Property;_Band0MaskUV;UV;69;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;354;1276.639,-3232.055;Inherit;False;EmissionMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;943;-2540.378,151.3315;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;787;-2239.473,-3783.317;Inherit;False;Property;_Band1MaskOffset;Offset;97;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FresnelNode;389;769.3622,-519.2387;Inherit;True;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;946;-2188.612,436.3655;Inherit;False;Property;_Band3MaskUV;UV;156;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;874;-2192.434,-1863.751;Inherit;False;Property;_Band2HueShift;Hue Shift;128;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1043;-2558.437,-1800.766;Inherit;False;Property;_Band2BarAmp;Bar Mode Pulse;131;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1041;-2813.62,-3738.005;Inherit;False;1017;Band1BarMode;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1047;-2764.566,559.0972;Inherit;False;1035;Band3BarMode;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1040;-2587.721,-3952.681;Inherit;False;Property;_Band1BarAmp;Bar Mode Pulse;102;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;816;-1865.225,-5999.321;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.GetLocalVarNode;1001;-2836.65,-5994.81;Inherit;False;1000;Band0BarMode;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;848;-1866.132,-3769.067;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;880;-1826.52,-1844.988;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;442;1527.527,-529.012;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RGBToHSVNode;879;-1904.093,-1993.821;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1044;-2784.336,-1586.09;Inherit;False;1026;Band2BarMode;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;391;1068.949,-339.2581;Inherit;False;Property;_RimColor;Color;41;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;8.47419,0.1331024,0.4436749,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;356;2351.144,-1290.219;Inherit;False;354;EmissionMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;390;1086.811,-515.2386;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;358;2524.146,-1303.983;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1046;-2538.667,344.4219;Inherit;False;Property;_Band3BarAmp;Bar Mode Pulse;160;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;727;-1871.484,-6241.782;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;733;-2066.829,-6070.926;Inherit;False;UV Selector;-1;;351;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RGBToHSVNode;950;-1889.214,148.4403;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1003;-2825.826,-5907.871;Inherit;False;Property;_Band0BarAmp;Bar Mode Pulse;73;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;302;2393.586,-1181.879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;883;-1838.494,-1607.648;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.RGBToHSVNode;726;-1949.058,-6390.612;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RGBToHSVNode;776;-1931.732,-4155.24;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;755;-2084.503,-3830.552;Inherit;False;UV Selector;-1;;352;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;763;-1854.158,-4006.407;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;422;1348.652,-342.4205;Inherit;False;Property;_AntiAliasingVariance;Anti Aliasing Variance;45;0;Create;True;0;0;0;False;0;False;5;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;421;1348.342,-254.3114;Inherit;False;Property;_AntiAliasingThreshold;Anti Aliasing Threshold;46;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;884;-2056.865,-1669.134;Inherit;False;UV Selector;-1;;353;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;311;2252.03,-1481.086;Inherit;False;Property;_UseEmissionMapasMask;Use Emission Map as Mask;33;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;953;-2041.986,473.1275;Inherit;False;UV Selector;-1;;354;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;949;-1811.642,297.2734;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;951;-1823.615,534.6135;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.ConditionalIfNode;1042;-2537.371,-1708.854;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;310;2572.032,-1358.244;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;355;2553.327,-1477.893;Inherit;False;354;EmissionMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1045;-2511.601,436.333;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1039;-2569.659,-3863.774;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;784;-1640.975,-3876.04;Inherit;True;Property;_Band1Mask;Mask Map--{reference_properties:[_Band1MaskTiling,_Band1MaskOffset,_Band1MaskUV]};95;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;754;-1685.231,-4127.763;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1002;-2554.76,-6157.96;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;736;-1660.301,-6111.415;Inherit;True;Property;_Band0Mask;Mask Map--{reference_properties:[_Band0MaskTiling,_Band0MaskOffset,_Band0MaskUV]};66;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;1340.66,-506.654;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;961;-1597.253,428.8465;Inherit;True;Property;_Band3Mask;Mask Map--{reference_properties:[_Band3MaskTiling,_Band3MaskOffset,_Band3MaskUV]};153;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;893;-1613.337,-1714.621;Inherit;True;Property;_Band2Mask;Mask Map--{reference_properties:[_Band2MaskTiling,_Band2MaskOffset,_Band2MaskUV]};124;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;731;-1702.557,-6363.142;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;446;1654.896,-336.5821;Inherit;False;GSAA;-1;;355;a3c5c6cf9d1dd744589a5e3146f5a3a1;0;3;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;885;-1657.592,-1966.344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;952;-1642.714,175.9174;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;300;2543.586,-1133.879;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.HSVToRGBNode;960;-1509.397,174.9433;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.HSVToRGBNode;756;-1551.913,-4128.737;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.HSVToRGBNode;734;-1569.239,-6364.112;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;984;-1254.032,-1668.737;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;307;2799.826,-1323.584;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.HSVToRGBNode;891;-1524.275,-1967.318;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;983;-1249.41,-6038.809;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;424;2068.485,-504.2038;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;985;-1226.555,487.5794;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;671;306.5348,-8.596262;Inherit;False;2449.018;764.2587;;21;677;672;668;657;684;650;667;655;678;666;665;661;680;662;683;660;679;681;682;656;1077;Vertex Noise;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;982;-1214.688,-3796.074;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1008;3925.017,-6644.813;Inherit;False;3192.067;1473.515;;4;476;830;1133;1134;Final Data;1,0.8339342,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1057;3035.496,-1268.906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;895;-1250.385,-1873.236;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1067;-1049.203,-3819.624;Inherit;False;Property;_UseBand6;Enable Band 1;89;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B1_ON;Toggle;2;Key0;Key1;Reference;1066;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1070;-1038.398,-1654.54;Inherit;False;Property;_UseBand8;Enable Band 2;118;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B2_ON;Toggle;2;Key0;Key1;Reference;1069;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1064;-1074.976,-6062.983;Inherit;False;Property;_UseBand4;Enable Band 0;60;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B0_ON;Toggle;2;Key0;Key1;Reference;1063;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1073;-1018.55,480.4369;Inherit;False;Property;_UseBand10;Enable Band 3;147;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B3_ON;Toggle;2;Key0;Key1;Reference;1072;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;667;435.1756,313.0659;Inherit;False;Property;_NoiseDirection;Directional Speed;56;0;Create;False;0;0;0;False;1;Vector3;False;1,1,1;1,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;2244.836,-458.0235;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;740;-1295.35,-6270.032;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;759;-1278.024,-4034.654;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1093;2198.263,-586.2712;Inherit;False;Property;_EnableRimlight;Enable Rimlight;40;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;968;-1235.506,269.0253;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;655;417.6399,234.8339;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;875;-808.6412,-1687.216;Inherit;False;Band2Amp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1072;-1021.55,263.437;Inherit;False;Property;_UseBand3;Enable Band 3;147;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_B3_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1066;-1056.255,-4047.872;Inherit;False;Property;_UseBand1;Enable Band 1;89;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_B1_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;830;4120.622,-6391.199;Inherit;False;1160.526;969.9855;Comment;16;846;834;837;843;823;832;838;835;841;827;842;831;839;836;563;1049;Layers;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;687;-4816.611,-5782.317;Inherit;False;2121.967;719.4281;;20;749;748;743;737;732;730;729;724;722;721;719;718;717;716;714;712;819;1065;1096;1097;Band 0 Shake;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;882;-4773.65,-1391.524;Inherit;False;2121.967;719.4281;;20;913;912;909;905;902;901;900;899;898;897;894;892;890;889;888;887;886;1071;1098;1099;Band 2 Shake;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;753;-4799.286,-3546.943;Inherit;False;2121.967;719.4281;;20;813;804;803;802;801;782;780;779;778;769;767;766;765;764;762;757;818;1068;1094;1095;Band 1 Shake;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;720;-841.754,-6026.826;Inherit;False;Band0Amp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;768;-825.9132,-3795.036;Inherit;False;Band1Amp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;945;-788.774,463.9825;Inherit;False;Band3Amp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1063;-1082.904,-6296.932;Inherit;False;Property;_UseBand0;Enable Band 0;60;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_B0_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1076;3192.45,-1476.977;Inherit;False;Property;_EnableEmissionEff;Enable Emission Effect;25;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_EmissionEff_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1069;-1042.398,-1908.54;Inherit;False;Property;_UseBand2;Enable Band 2;118;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_B2_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1092;2410.265,-501.4291;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;919;-4755.772,756.7375;Inherit;False;2121.967;719.4281;;20;980;979;977;973;970;969;966;965;964;963;962;959;958;957;956;955;954;1074;1100;1101;Band 3 Shake;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;684;645.442,234.8065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;650;415.7185,55.79781;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;804;-4741.671,-3103.928;Inherit;False;Property;_Shake1Tiling;Tiling;109;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;959;-4699.73,1331.739;Inherit;False;Property;_Shake3Offset;Offset;168;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;831;4158.927,-5561.075;Inherit;False;945;Band3Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;958;-4278.225,872.1304;Inherit;False;Property;_Shake3DirectionSelect;Direction;171;1;[Enum];Create;False;0;2;Normals;0;Custom;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;813;-4320.741,-3434.817;Inherit;False;Property;_Shake1DirectionSelect;Direction;113;2;[IntRange];[Enum];Create;False;0;2;Normals;0;Custom;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;-848.985,-6249.012;Inherit;False;Band0Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;777;-831.6588,-4013.634;Inherit;False;Band1Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;904;-804.0201,-1852.216;Inherit;False;Band2Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;974;-789.1422,290.0453;Inherit;False;Band3Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;832;4155.93,-5636.584;Inherit;False;875;Band2Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;395;2621.88,-464.5416;Inherit;False;Rimlight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;717;-4759.997,-5339.302;Inherit;False;Property;_Shake0Tiling;Tiling;80;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;714;-4352.067,-5668.924;Inherit;False;Property;_Shake0DirectionSelect;Direction;84;1;[Enum];Create;False;0;2;Normals;0;Custom;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;803;-4743.244,-2973.31;Inherit;False;Property;_Shake1Offset;Offset;110;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;349;320.6011,-4220.241;Inherit;False;1504.473;670.9171;;14;345;346;62;63;443;59;61;60;344;447;429;440;437;439;Metallic Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalVertexDataNode;890;-4541.364,-1084.067;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;778;-4622.583,-3413.746;Inherit;False;Property;_Shake1DirectionVector;Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake1DirectionSelect==1}};114;0;Create;False;0;0;0;False;1;Vector3;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalVertexDataNode;955;-4523.485,1064.195;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;718;-4764.991,-5416.935;Inherit;False;Property;_Shake0UV;UV;82;1;[HideInInspector];Create;False;0;9;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;716;-4584.329,-5474.859;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;956;-4579.068,889.9333;Inherit;False;Property;_Shake3DirectionVector;Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake3DirectionSelect==1}};172;0;Create;False;0;0;0;False;1;Vector3;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;779;-4747.665,-3181.562;Inherit;False;Property;_Shake1UV;UV;111;1;[HideInInspector];Create;False;0;9;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;656;848.8444,236.9638;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;892;-4296.103,-1276.131;Inherit;False;Property;_Shake2DirectionSelect;Direction;142;1;[Enum];Create;False;0;2;Normals;0;Custom;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;827;4169.339,-5788.544;Inherit;False;720;Band0Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;957;-4694.293,1195.805;Inherit;False;Property;_Shake3Tiling;Tiling;167;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;719;-4760.569,-5208.683;Inherit;False;Property;_Shake0Offset;Offset;81;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;888;-4717.608,-816.5236;Inherit;False;Property;_Shake2Offset;Offset;139;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;3449.899,-1439.646;Inherit;False;EffectMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;954;-4704.151,1122.118;Inherit;False;Property;_Shake3UV;UV;169;1;[HideInInspector];Create;False;0;9;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector3Node;886;-4596.946,-1258.328;Inherit;False;Property;_Shake2DirectionVector;Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake2DirectionSelect==1}};143;0;Create;False;0;0;0;False;1;Vector3;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;887;-4716.035,-949.8815;Inherit;False;Property;_Shake2Tiling;Tiling;138;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NormalVertexDataNode;769;-4567.002,-3239.485;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;563;4156.336,-5713.036;Inherit;False;768;Band1Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;712;-4642.908,-5648.121;Inherit;False;Property;_Shake0DirectionVector;Custom--{condition_show:{type:PROPERTY_BOOL,data:_Shake0DirectionSelect==1}};85;0;Create;False;0;0;0;False;1;Vector3;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;889;-4722.029,-1026.144;Inherit;False;Property;_Shake2UV;UV;140;1;[HideInInspector];Create;False;0;9;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;657;629.9982,358.9076;Inherit;False;Property;_NoiseScale;Scale;55;0;Create;False;0;0;0;False;0;False;5;6.31;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;767;-4570.85,-3081.71;Inherit;False;UV Selector;-1;;360;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;963;-3641.291,850.9854;Inherit;False;945;Band3Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;439;364.1954,-3652.388;Inherit;False;Property;_AntiAliasingThresholdSm;Anti Aliasing Threshold;10;0;Create;False;0;0;0;False;0;False;0.01;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;842;4173.248,-5896.038;Inherit;False;395;Rimlight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;440;368.8724,-3984.427;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;964;-3738.053,937.5344;Inherit;False;Property;_Shake3Intensity;Intensity;170;0;Create;False;0;0;0;False;0;False;0.05;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;679;1155.561,500.122;Inherit;False;Property;_UVNoiseMask;UV;53;1;[HideInInspector];Create;False;0;10;UV0;0;UV1;1;UV2;2;UV3;3;World XY;4;World XZ;5;World YZ;6;Object XY;7;Object XZ;8;Object YZ;9;0;False;1;ThryWideEnum(UV0,0,UV1,1,UV2,2,UV3,3,World XY,4,World XZ,5,World YZ,6);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;660;984.6999,234.0976;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;836;4164.837,-6232.959;Inherit;False;744;Band0Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;841;4167.275,-5975.464;Inherit;False;359;EffectMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;764;-4123.472,-3306.988;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;818;-4550.758,-2927.202;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.FunctionNode;966;-4527.333,1221.969;Inherit;False;UV Selector;-1;;361;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;838;4161.86,-6147.708;Inherit;False;904;Band2Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;897;-4545.211,-926.2936;Inherit;False;UV Selector;-1;;359;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;965;-4086.881,1003.62;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;681;936.8162,571.0668;Inherit;False;Property;_OffsetNoiseMask;Offset;52;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;724;-3701.132,-5688.068;Inherit;False;720;Band0Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;682;792.6887,470.0658;Inherit;False;Property;_TilingNoiseMask;Tiling;51;1;[HideInInspector];Create;False;0;0;0;False;1;Vector2;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;962;-4507.241,1376.476;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.GetLocalVarNode;819;-4569.434,-5172.498;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.GetLocalVarNode;894;-3659.169,-1297.276;Inherit;False;875;Band2Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;835;4164.316,-6321.471;Inherit;False;777;Band1Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;729;-3800.184,-5601.519;Inherit;False;Property;_Shake0Intensity;Intensity;83;0;Create;False;0;0;0;False;0;False;0.05;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;802;-3782.858,-3366.146;Inherit;False;Property;_Shake1Intensity;Intensity;112;0;Create;False;0;0;0;False;0;False;0.05;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;437;365.415,-3740.733;Inherit;False;Property;_AntiAliasingVarianceSm;Anti Aliasing Variance;9;0;Create;False;0;0;0;False;0;False;5;0.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;900;-4525.12,-771.7853;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.FunctionNode;721;-4588.175,-5317.085;Inherit;False;UV Selector;-1;;358;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ConditionalIfNode;722;-4147.725,-5535.433;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;899;-4104.76,-1144.641;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;765;-3684.807,-3452.695;Inherit;False;768;Band1Amp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;839;4160.381,-6066.196;Inherit;False;974;Band3Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;823;4363.154,-5721.85;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;898;-3757.219,-1210.728;Inherit;False;Property;_Shake2Intensity;Intensity;141;0;Create;False;0;0;0;False;0;False;0.05;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;970;-3442.943,936.2163;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;51;2343.257,-4594.248;Inherit;True;Property;_MainTex;Albedo Map--{reference_property:_Color};4;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;661;1260.056,232.1859;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;683;1358.335,483.8578;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.SimpleAddOpNode;843;4429.942,-5956.953;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;60;365.0643,-3835.484;Inherit;False;Property;_Glossiness;Smoothness;8;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;762;-3486.46,-3367.463;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;447;665.1736,-3849.251;Inherit;False;GSAA;-1;;362;a3c5c6cf9d1dd744589a5e3146f5a3a1;0;3;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;782;-4314.401,-3079.908;Inherit;True;Property;_Shake1Mask;Mask Map--{reference_properties:[_Shake1Tiling,_Shake1Offset,_Shake1UV]};108;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;969;-4270.883,1223.771;Inherit;True;Property;_Shake3Mask;Mask Map--{reference_properties:[_Shake3Tiling,_Shake3Offset,_Shake3UV]};166;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1049;4556.509,-5730.042;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;344;368.6843,-4150.683;Inherit;False;339;MainUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;901;-4288.762,-924.4913;Inherit;True;Property;_Shake2Mask;Mask Map--{reference_properties:[_Shake2Tiling,_Shake2Offset,_Shake2UV]};137;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;730;-3503.786,-5602.837;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;732;-4331.727,-5315.283;Inherit;True;Property;_Shake0Mask;Mask Map--{reference_properties:[_Shake0Tiling,_Shake0Offset,_Shake0UV]};79;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;53;2662.773,-4768.707;Inherit;False;Property;_Color;Albedo Color;5;1;[HideInInspector];Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;837;4425.719,-6247.902;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;662;1152.688,143.4477;Inherit;False;Property;_NoiseStength;Strength;54;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;902;-3460.822,-1212.046;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;680;1339.295,569.2529;Inherit;False;UV Selector;-1;;363;d8047ff639977014ab6649a770bd5cd4;0;3;15;INT;0;False;16;FLOAT2;0,0;False;17;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;429;366.946,-4068.557;Inherit;False;428;Sampler;1;0;OBJECT;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.RangedFloatNode;1096;-3417.392,-5734.739;Inherit;False;Property;_UseShake0;Enable Shake 0;78;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;834;4831.115,-6045.126;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1100;-3358.575,847.5449;Inherit;False;Property;_UseShake3;Enable Shake 3;165;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;665;1671.414,141.9736;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-3350.807,-3290.238;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1095;-3397.186,-3456.376;Inherit;False;Property;_UseShake1;Enable Shake 1;107;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;737;-3368.132,-5525.611;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;905;-3325.169,-1134.819;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;443;1094.463,-3833.62;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;642.9706,-4151.756;Inherit;False;Property;_Metallic;Metallic Slider;7;1;[HideInInspector];Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;59;624.3825,-4069.384;Inherit;True;Property;_MetallicGlossMap;Metallic Map--{reference_property:_Metallic};6;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;51;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;2901.708,-4669.852;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1098;-3372.808,-1333.023;Inherit;False;Property;_UseShake2;Enable Shake 2;136;2;[HideInInspector];[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;666;1679.472,413.4476;Inherit;True;Property;_VertexNoiseMask;Vertex Noise Mask Map--{reference_properties:[_TilingNoiseMask,_OffsetNoiseMask,_UVNoiseMask]};50;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;973;-3307.291,1013.442;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;846;5026.605,-6045.646;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1101;-3157.122,956.6528;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;351;3096.972,-4672.054;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;668;2093.977,317.9998;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;476;5401.255,-6396.753;Inherit;False;1433.389;997.3186;;19;478;338;352;348;674;847;673;914;347;828;915;364;1103;1104;1105;1106;1107;1110;1111;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.ConditionalIfNode;1094;-3216,-3296;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1099;-3175.207,-1180.915;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1097;-3215.939,-5583.512;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;1193.223,-4035.894;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;1256.055,-3922.359;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;847;5583.18,-6136.138;Inherit;False;846;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1071;-3013.118,-1169.884;Inherit;False;Property;_UseBand9;Enable Band 2;118;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B2_ON;Toggle;2;Key0;Key1;Reference;1069;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;352;5596.542,-6312.124;Inherit;False;351;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1074;-2988.518,985.1509;Inherit;False;Property;_UseBand11;Enable Band 3;147;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B3_ON;Toggle;2;Key0;Key1;Reference;1072;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1133;5742.293,-6529.238;Inherit;False;Property;_HueTime;Hue Time;22;0;Create;True;0;0;0;False;0;False;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1077;2263.876,215.9341;Inherit;False;Property;_VertexNoise;Enable Vertex Noise;49;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_VertNoise_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1065;-3050.984,-5559.171;Inherit;False;Property;_UseBand5;Enable Band 0;60;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B0_ON;Toggle;2;Key0;Key1;Reference;1063;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;346;1394.461,-4002.139;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1068;-3035.499,-3325.767;Inherit;False;Property;_UseBand7;Enable Band 1;89;0;Create;False;0;0;0;False;0;False;0;0;0;True;_B1_ON;Toggle;2;Key0;Key1;Reference;1066;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1107;5773.811,-6352.982;Inherit;False;Property;_HueModifier;Hue Modifier;21;0;Create;True;0;0;0;False;0;False;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;766;-2860.398,-3358.715;Inherit;False;Band1Shake;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1005;263.7675,-6628.079;Inherit;False;2666.795;1377.973;;2;458;77;Unity;0,0.1185064,1,1;0;0
Node;AmplifyShaderEditor.RGBToHSVNode;1103;5823.811,-6266.982;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;1134;6031.521,-6553.517;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;1105;5824.811,-6104.982;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;909;-2834.759,-1203.297;Inherit;False;Band2Shake;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;672;2501.17,159.2746;Inherit;False;WorldNoise;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;977;-2816.88,944.9644;Inherit;False;Band3Shake;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;743;-2877.724,-5594.089;Inherit;False;Band0Shake;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;1553.925,-4005.035;Inherit;False;MetallicSmoothness;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;347;5449.268,-6004.473;Inherit;False;345;MetallicSmoothness;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;5846.439,-5565.998;Inherit;False;977;Band3Shake;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1111;6108.811,-6139.482;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;673;5839.724,-5907.373;Inherit;False;672;WorldNoise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;77;2101.973,-6316.941;Inherit;False;670.9143;415.154;;9;86;101;82;85;83;84;81;79;78;ThryEditor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1110;6099.811,-6309.482;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;458;443.7283,-6343.615;Inherit;False;455.9268;793.7084;;8;479;480;260;575;576;89;88;90;Engine;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;914;5840.439,-5642.998;Inherit;False;909;Band2Shake;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;828;5840.621,-5732.155;Inherit;False;766;Band1Shake;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;5840.453,-5826.964;Inherit;False;743;Band0Shake;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;6365.269,-5973.539;Inherit;False;336;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;260;509.6126,-6197.18;Inherit;False;Property;_Cull;Cull;177;0;Create;True;0;0;0;True;1;Enum(UnityEngine.Rendering.CullMode);False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;750;-452.672,1680.548;Inherit;False;Property;m_end_AudioLink;Audio Link;175;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;801;-2843.831,-2924.204;Inherit;False;Property;m_end_Shake1;Shake 1;115;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;398;767.1793,-232.4575;Inherit;False;Property;m_start_rim;Rimlight--{reference_property:_EnableRimlight};39;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;348;5704.018,-5979.456;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;745;-759.4528,-5064.427;Inherit;False;Property;m_end_Band0;Band 0;87;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;261;305.9659,-1526.734;Inherit;False;Property;m_start_eff;Emission Effect--{reference_property:_EnableEmissionEff};24;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;2135.274,-6146.626;Inherit;False;Property;m_end_Main;Main;23;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;2606.983,-6033.262;Inherit;False;Property;footer_discord;;184;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;978;-698.6071,1474.626;Inherit;False;Property;m_end_Band3;Band 3;174;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;677;349.3825,605.7237;Inherit;False;Property;m_start_noisevert;Vertex Noise--{reference_property:_VertexNoise};48;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;674;6105.724,-5843.373;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;576;762.4714,-5656.193;Inherit;False;Property;m_end_engine;Engine;183;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;800;-5043.833,-4381.389;Inherit;False;Property;m_start_Band1;Band 1--{reference_property:_UseBand1};88;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;678;2535.611,590.312;Inherit;False;Property;m_end_noisevert;Vertex Noise;57;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;979;-4729.726,801.6523;Inherit;False;Property;m_start_Shake3;Shake--{reference_property:_UseShake3};164;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;911;-5018.197,-2225.97;Inherit;False;Property;m_start_Band2;Band 2--{reference_property:_UseBand2};117;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;2290.085,-6030.526;Inherit;False;Property;footer_patreon;;187;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;397;2707.441,-235.7794;Inherit;False;Property;m_end_rim;Rimlight;47;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;747;-5267.767,-6889.392;Inherit;False;Property;m_start_AudioLink;Audio Link;58;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;2458.035,-6033.242;Inherit;False;Property;footer_github;;186;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;479;513.6707,-6029.546;Inherit;False;Property;_ZWrite;ZWrite;179;1;[Enum];Create;True;0;2;Off;0;On;1;0;True;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;746;-5064.051,-6616.762;Inherit;False;Property;m_start_Band0;Band 0--{reference_property:_UseBand0};59;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;480;510.5096,-6115.655;Inherit;False;Property;_ZTest;ZTest;178;0;Create;True;0;0;0;True;1;Enum(UnityEngine.Rendering.CompareFunction);False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;2143.377,-6256.582;Inherit;False;Property;shader_is_using_thry_editor;;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;912;-2818.193,-768.7872;Inherit;False;Property;m_end_Shake2;Shake 2;144;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;781;-742.1261,-2829.052;Inherit;False;Property;m_end_Band1;Band 1;116;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;3463.682,-961.3279;Inherit;False;Property;m_end_eff;Emission Effect;38;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;910;-716.486,-673.6354;Inherit;False;Property;m_end_Band2;Band 2;145;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;913;-4747.604,-1346.609;Inherit;False;Property;m_start_Shake2;Shake--{reference_property:_UseShake2};135;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;1106;6267.811,-6190.982;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;575;464.4715,-6293.193;Inherit;False;Property;m_start_engine;Engine;176;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;508.597,-5847.476;Inherit;False;Property;LightmapFlags;LightmapFlags;180;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;2138.23,-6032.16;Inherit;False;Property;footer_booth;;185;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;981;-5000.318,-77.7086;Inherit;False;Property;m_start_Band3;Band 3--{reference_property:_UseBand3};146;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;1104;6263.811,-6340.982;Inherit;False;3;0;FLOAT;0.79;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;79;2318.719,-6256.294;Inherit;False;Property;shader_master_label;<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}};1;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;515.597,-5666.476;Inherit;False;Property;Instancing;Instancing;182;1;[HideInInspector];Create;False;0;0;0;True;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;2280.25,-6144.64;Inherit;False;Property;m_start_Main;Main;3;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;780;-4773.24,-3502.028;Inherit;False;Property;m_start_Shake1;Shake--{reference_property:_UseShake1};106;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;748;-4790.566,-5737.403;Inherit;False;Property;m_start_Shake0;Shake--{reference_property:_UseShake0};77;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;2508.608,-6260.279;Inherit;False;Property;shader_properties_label_file;TsunaMooLabels;2;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;510.4168,-5764.929;Inherit;False;Property;DSGI;DSGI;181;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;980;-2800.315,1379.474;Inherit;False;Property;m_end_Shake3;Shake 3;173;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;749;-2860.157,-5156.58;Inherit;False;Property;m_end_Shake0;Shake 0;86;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;478;6596.363,-6171.372;Half;False;True;-1;4;Thry.ShaderEditor;0;0;Standard;TsunaMoo/Party FX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;True;479;0;True;480;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;9;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;nomrt;True;True;True;True;0;False;-1;False;0;True;449;255;True;453;255;True;454;0;True;451;0;True;452;0;True;455;0;True;456;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;463;10;True;464;0;0;True;466;0;True;467;0;True;465;0;True;468;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;260;-1;0;False;-1;1;Include;Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;922;0;921;0
WireConnection;812;0;794;0
WireConnection;923;0;920;0
WireConnection;811;0;795;0
WireConnection;691;0;688;0
WireConnection;694;0;689;0
WireConnection;807;0;812;0
WireConnection;807;1;811;0
WireConnection;854;0;852;0
WireConnection;853;0;851;0
WireConnection;930;15;926;0
WireConnection;930;16;925;0
WireConnection;930;17;928;0
WireConnection;924;0;922;0
WireConnection;924;1;923;0
WireConnection;697;0;691;0
WireConnection;697;1;694;0
WireConnection;696;15;690;0
WireConnection;696;16;692;0
WireConnection;696;17;693;0
WireConnection;810;15;796;0
WireConnection;810;16;798;0
WireConnection;810;17;797;0
WireConnection;1132;0;930;0
WireConnection;1084;0;1085;0
WireConnection;1084;2;922;0
WireConnection;1084;3;924;0
WireConnection;1084;4;922;0
WireConnection;1090;0;1091;0
WireConnection;1090;2;691;0
WireConnection;1090;3;697;0
WireConnection;1090;4;691;0
WireConnection;860;15;857;0
WireConnection;860;16;859;0
WireConnection;860;17;856;0
WireConnection;1088;0;1089;0
WireConnection;1088;2;812;0
WireConnection;1088;3;807;0
WireConnection;1088;4;812;0
WireConnection;1129;0;696;0
WireConnection;858;0;853;0
WireConnection;858;1;854;0
WireConnection;1130;0;810;0
WireConnection;700;1;1129;0
WireConnection;700;2;1090;0
WireConnection;1087;0;1086;0
WireConnection;1087;2;853;0
WireConnection;1087;3;858;0
WireConnection;1087;4;853;0
WireConnection;806;1;1130;0
WireConnection;806;2;1088;0
WireConnection;931;1;1132;0
WireConnection;931;2;1084;0
WireConnection;418;0;417;1
WireConnection;415;0;417;2
WireConnection;1131;0;860;0
WireConnection;934;0;931;0
WireConnection;791;0;806;0
WireConnection;420;0;418;0
WireConnection;420;1;415;0
WireConnection;862;1;1131;0
WireConnection;862;2;1087;0
WireConnection;702;0;700;0
WireConnection;1124;1;791;0
WireConnection;1124;2;805;0
WireConnection;1124;3;792;0
WireConnection;864;0;862;0
WireConnection;1125;1;934;0
WireConnection;1125;2;933;0
WireConnection;1125;3;932;0
WireConnection;419;0;420;0
WireConnection;419;1;93;0
WireConnection;1126;1;702;0
WireConnection;1126;2;701;0
WireConnection;1126;3;703;0
WireConnection;774;0;1124;0
WireConnection;1127;1;864;0
WireConnection;1127;2;865;0
WireConnection;1127;3;863;0
WireConnection;937;0;1125;0
WireConnection;706;0;1126;0
WireConnection;645;15;293;0
WireConnection;645;16;92;0
WireConnection;645;17;419;0
WireConnection;772;2;789;0
WireConnection;772;4;774;0
WireConnection;867;0;1127;0
WireConnection;428;0;327;0
WireConnection;708;2;705;0
WireConnection;708;4;706;0
WireConnection;339;0;645;0
WireConnection;939;2;936;0
WireConnection;939;4;937;0
WireConnection;571;0;570;1
WireConnection;1010;0;810;0
WireConnection;1028;0;930;0
WireConnection;1019;0;860;0
WireConnection;869;2;868;0
WireConnection;869;4;867;0
WireConnection;999;0;696;0
WireConnection;1038;0;939;0
WireConnection;572;0;570;2
WireConnection;997;0;708;0
WireConnection;1036;0;772;0
WireConnection;1030;0;1028;1
WireConnection;1030;1;1038;0
WireConnection;1012;0;1010;1
WireConnection;1012;1;1036;0
WireConnection;1021;0;1019;1
WireConnection;1021;1;869;0
WireConnection;992;0;999;1
WireConnection;992;1;997;0
WireConnection;55;1;343;0
WireConnection;55;5;54;0
WireConnection;55;7;430;0
WireConnection;573;0;571;0
WireConnection;573;1;572;0
WireConnection;1013;0;1012;0
WireConnection;1031;0;1030;0
WireConnection;574;0;573;0
WireConnection;574;1;263;0
WireConnection;993;0;992;0
WireConnection;1022;0;1021;0
WireConnection;566;0;565;1
WireConnection;567;0;565;2
WireConnection;1079;1;56;0
WireConnection;1079;0;55;0
WireConnection;1032;0;1031;0
WireConnection;568;0;566;0
WireConnection;568;1;567;0
WireConnection;1014;0;1013;0
WireConnection;1023;0;1022;0
WireConnection;336;0;1079;0
WireConnection;646;15;223;0
WireConnection;646;16;264;0
WireConnection;646;17;574;0
WireConnection;994;0;993;0
WireConnection;1033;0;1032;0
WireConnection;995;0;994;0
WireConnection;569;0;568;0
WireConnection;569;1;414;0
WireConnection;1024;0;1023;0
WireConnection;233;1;342;0
WireConnection;233;7;431;0
WireConnection;1015;0;1014;0
WireConnection;258;1;646;0
WireConnection;258;7;432;0
WireConnection;711;1;696;0
WireConnection;711;7;815;0
WireConnection;109;0;233;0
WireConnection;109;1;50;0
WireConnection;1025;0;1024;0
WireConnection;941;1;930;0
WireConnection;941;7;938;0
WireConnection;1016;0;1015;0
WireConnection;402;0;406;0
WireConnection;1034;0;1033;0
WireConnection;996;0;995;0
WireConnection;783;1;810;0
WireConnection;783;7;817;0
WireConnection;309;0;308;0
WireConnection;309;1;258;0
WireConnection;873;1;860;0
WireConnection;873;7;870;0
WireConnection;647;15;412;0
WireConnection;647;16;413;0
WireConnection;647;17;569;0
WireConnection;209;1;647;0
WireConnection;209;7;433;0
WireConnection;713;0;711;0
WireConnection;713;1;710;0
WireConnection;1017;0;1016;0
WireConnection;1026;0;1025;0
WireConnection;1000;0;996;0
WireConnection;1035;0;1034;0
WireConnection;297;0;298;0
WireConnection;770;0;783;0
WireConnection;770;1;790;0
WireConnection;876;0;873;0
WireConnection;876;1;872;0
WireConnection;301;0;309;0
WireConnection;354;0;109;0
WireConnection;943;0;941;0
WireConnection;943;1;942;0
WireConnection;389;0;402;0
WireConnection;389;1;388;0
WireConnection;389;2;386;0
WireConnection;389;3;387;0
WireConnection;880;0;874;0
WireConnection;880;1;869;0
WireConnection;442;0;402;0
WireConnection;879;0;876;0
WireConnection;390;0;389;0
WireConnection;358;0;209;0
WireConnection;727;0;715;0
WireConnection;727;1;708;0
WireConnection;733;15;725;0
WireConnection;733;16;728;0
WireConnection;733;17;723;0
WireConnection;950;0;943;0
WireConnection;302;0;301;1
WireConnection;302;1;297;0
WireConnection;726;0;713;0
WireConnection;776;0;770;0
WireConnection;755;15;786;0
WireConnection;755;16;788;0
WireConnection;755;17;787;0
WireConnection;763;0;785;0
WireConnection;763;1;772;0
WireConnection;884;15;877;0
WireConnection;884;16;878;0
WireConnection;884;17;881;0
WireConnection;953;15;946;0
WireConnection;953;16;948;0
WireConnection;953;17;947;0
WireConnection;949;0;944;0
WireConnection;949;1;939;0
WireConnection;1042;0;1043;0
WireConnection;1042;2;869;0
WireConnection;1042;3;1044;0
WireConnection;1042;4;869;0
WireConnection;310;0;311;0
WireConnection;310;2;356;0
WireConnection;310;3;356;0
WireConnection;310;4;358;0
WireConnection;1045;0;1046;0
WireConnection;1045;2;939;0
WireConnection;1045;3;1047;0
WireConnection;1045;4;939;0
WireConnection;1039;0;1040;0
WireConnection;1039;2;772;0
WireConnection;1039;3;1041;0
WireConnection;1039;4;772;0
WireConnection;784;1;755;0
WireConnection;784;7;848;0
WireConnection;754;0;776;1
WireConnection;754;1;763;0
WireConnection;1002;0;1003;0
WireConnection;1002;2;708;0
WireConnection;1002;3;1001;0
WireConnection;1002;4;708;0
WireConnection;736;1;733;0
WireConnection;736;7;816;0
WireConnection;392;0;390;0
WireConnection;392;1;391;0
WireConnection;961;1;953;0
WireConnection;961;7;951;0
WireConnection;893;1;884;0
WireConnection;893;7;883;0
WireConnection;731;0;726;1
WireConnection;731;1;727;0
WireConnection;446;1;442;0
WireConnection;446;10;422;0
WireConnection;446;12;421;0
WireConnection;885;0;879;1
WireConnection;885;1;880;0
WireConnection;952;0;950;1
WireConnection;952;1;949;0
WireConnection;300;0;302;0
WireConnection;300;1;301;2
WireConnection;300;2;301;3
WireConnection;960;0;952;0
WireConnection;960;1;950;2
WireConnection;960;2;950;3
WireConnection;756;0;754;0
WireConnection;756;1;776;2
WireConnection;756;2;776;3
WireConnection;734;0;731;0
WireConnection;734;1;726;2
WireConnection;734;2;726;3
WireConnection;984;0;1042;0
WireConnection;984;1;893;0
WireConnection;984;2;872;4
WireConnection;307;0;355;0
WireConnection;307;1;300;0
WireConnection;307;2;310;0
WireConnection;891;0;885;0
WireConnection;891;1;879;2
WireConnection;891;2;879;3
WireConnection;983;0;1002;0
WireConnection;983;1;736;0
WireConnection;983;2;710;4
WireConnection;424;0;392;0
WireConnection;424;2;446;0
WireConnection;985;0;961;0
WireConnection;985;1;1045;0
WireConnection;985;2;942;4
WireConnection;982;0;1039;0
WireConnection;982;1;784;0
WireConnection;982;2;790;4
WireConnection;1057;0;307;0
WireConnection;1057;1;308;4
WireConnection;895;0;891;0
WireConnection;895;1;1042;0
WireConnection;895;2;893;0
WireConnection;1067;0;982;0
WireConnection;1070;0;984;0
WireConnection;1064;0;983;0
WireConnection;1073;0;985;0
WireConnection;1058;0;424;0
WireConnection;1058;1;391;4
WireConnection;740;0;734;0
WireConnection;740;1;1002;0
WireConnection;740;2;736;0
WireConnection;759;0;756;0
WireConnection;759;1;1039;0
WireConnection;759;2;784;0
WireConnection;968;0;960;0
WireConnection;968;1;1045;0
WireConnection;968;2;961;0
WireConnection;875;0;1070;0
WireConnection;1072;0;968;0
WireConnection;1066;0;759;0
WireConnection;720;0;1064;0
WireConnection;768;0;1067;0
WireConnection;945;0;1073;0
WireConnection;1063;0;740;0
WireConnection;1076;1;355;0
WireConnection;1076;0;1057;0
WireConnection;1069;0;895;0
WireConnection;1092;0;1093;0
WireConnection;1092;3;1058;0
WireConnection;684;0;655;0
WireConnection;684;1;667;0
WireConnection;744;0;1063;0
WireConnection;777;0;1066;0
WireConnection;904;0;1069;0
WireConnection;974;0;1072;0
WireConnection;395;0;1092;0
WireConnection;656;0;650;0
WireConnection;656;1;684;0
WireConnection;359;0;1076;0
WireConnection;767;15;779;0
WireConnection;767;16;804;0
WireConnection;767;17;803;0
WireConnection;660;0;656;0
WireConnection;660;1;657;0
WireConnection;764;0;813;0
WireConnection;764;2;769;0
WireConnection;764;3;778;0
WireConnection;764;4;769;0
WireConnection;966;15;954;0
WireConnection;966;16;957;0
WireConnection;966;17;959;0
WireConnection;897;15;889;0
WireConnection;897;16;887;0
WireConnection;897;17;888;0
WireConnection;965;0;958;0
WireConnection;965;2;955;0
WireConnection;965;3;956;0
WireConnection;965;4;955;0
WireConnection;721;15;718;0
WireConnection;721;16;717;0
WireConnection;721;17;719;0
WireConnection;722;0;714;0
WireConnection;722;2;716;0
WireConnection;722;3;712;0
WireConnection;722;4;716;0
WireConnection;899;0;892;0
WireConnection;899;2;890;0
WireConnection;899;3;886;0
WireConnection;899;4;890;0
WireConnection;823;0;827;0
WireConnection;823;1;563;0
WireConnection;823;2;832;0
WireConnection;823;3;831;0
WireConnection;970;0;963;0
WireConnection;970;1;964;0
WireConnection;970;2;965;0
WireConnection;51;1;339;0
WireConnection;51;7;428;0
WireConnection;661;0;660;0
WireConnection;843;0;841;0
WireConnection;843;1;842;0
WireConnection;762;0;765;0
WireConnection;762;1;802;0
WireConnection;762;2;764;0
WireConnection;447;1;440;0
WireConnection;447;10;437;0
WireConnection;447;12;439;0
WireConnection;782;1;767;0
WireConnection;782;7;818;0
WireConnection;969;1;966;0
WireConnection;969;7;962;0
WireConnection;1049;0;823;0
WireConnection;901;1;897;0
WireConnection;901;7;900;0
WireConnection;730;0;724;0
WireConnection;730;1;729;0
WireConnection;730;2;722;0
WireConnection;732;1;721;0
WireConnection;732;7;819;0
WireConnection;837;0;835;0
WireConnection;837;1;836;0
WireConnection;837;2;838;0
WireConnection;837;3;839;0
WireConnection;902;0;894;0
WireConnection;902;1;898;0
WireConnection;902;2;899;0
WireConnection;680;15;679;0
WireConnection;680;16;682;0
WireConnection;680;17;681;0
WireConnection;834;0;843;0
WireConnection;834;1;837;0
WireConnection;834;2;1049;0
WireConnection;665;0;661;0
WireConnection;665;1;662;0
WireConnection;757;0;762;0
WireConnection;757;1;782;0
WireConnection;737;0;730;0
WireConnection;737;1;732;0
WireConnection;905;0;902;0
WireConnection;905;1;901;0
WireConnection;443;0;60;0
WireConnection;443;2;447;0
WireConnection;59;1;344;0
WireConnection;59;7;429;0
WireConnection;52;0;53;0
WireConnection;52;1;51;0
WireConnection;666;1;680;0
WireConnection;666;7;683;0
WireConnection;973;0;970;0
WireConnection;973;1;969;0
WireConnection;846;0;834;0
WireConnection;1101;0;1100;0
WireConnection;1101;3;973;0
WireConnection;351;0;52;0
WireConnection;668;0;665;0
WireConnection;668;1;666;0
WireConnection;1094;0;1095;0
WireConnection;1094;3;757;0
WireConnection;1099;0;1098;0
WireConnection;1099;3;905;0
WireConnection;1097;0;1096;0
WireConnection;1097;3;737;0
WireConnection;62;0;61;0
WireConnection;62;1;59;0
WireConnection;63;0;443;0
WireConnection;63;1;59;4
WireConnection;1071;0;1099;0
WireConnection;1074;0;1101;0
WireConnection;1077;0;668;0
WireConnection;1065;0;1097;0
WireConnection;346;0;62;0
WireConnection;346;1;63;0
WireConnection;1068;0;1094;0
WireConnection;766;0;1068;0
WireConnection;1103;0;352;0
WireConnection;1134;0;1133;0
WireConnection;1105;0;847;0
WireConnection;909;0;1071;0
WireConnection;672;0;1077;0
WireConnection;977;0;1074;0
WireConnection;743;0;1065;0
WireConnection;345;0;346;0
WireConnection;1111;0;1105;1
WireConnection;1111;1;1107;0
WireConnection;1111;2;1134;0
WireConnection;1110;0;1103;1
WireConnection;1110;1;1107;0
WireConnection;1110;2;1134;0
WireConnection;348;0;347;0
WireConnection;674;0;673;0
WireConnection;674;1;364;0
WireConnection;674;2;828;0
WireConnection;674;3;914;0
WireConnection;674;4;915;0
WireConnection;1106;0;1111;0
WireConnection;1106;1;1105;2
WireConnection;1106;2;1105;3
WireConnection;1104;0;1110;0
WireConnection;1104;1;1103;2
WireConnection;1104;2;1103;3
WireConnection;478;0;1104;0
WireConnection;478;1;338;0
WireConnection;478;2;1106;0
WireConnection;478;3;348;0
WireConnection;478;4;348;1
WireConnection;478;11;674;0
ASEEND*/
//CHKSM=9EAF5FBDA50EEF496856427C53FC2BBC753E5BC0
