// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Furality/Umbra Shader/Umbra Cutout"
{
	Properties
	{
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_EmissionMaskMap("Emission Mask Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_EmissionMaskChannel("Emission Mask Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_MetallicMask("Metallic Map", Float) = 1
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_FleckMetallicMap("Fleck Metallic Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_FleckMetallicChannel("Fleck Metallic Channel", Float) = 0
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_MetallicChannel("Metallic Channel", Float) = 0
		[ToggleUI]_InvertHighlightGloss("Invert Highlight Gloss", Float) = 0
		[ToggleUI]_InvertReflectionGloss("InvertReflectionGloss", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlossMap("Gloss Map", Float) = 1
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlossChannel("Gloss Channel", Float) = 3
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_OcclusionMap("Occlusion Map", Float) = 1
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_OcclusionChannel("Occlusion Channel", Float) = 1
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_ReflectionMask("Reflection Mask", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_ReflectionMaskChannel("Reflection Mask Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlowMask0("Glow Mask 0", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlowMask0Channel("Glow Mask 0 Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlowMask1("Glow Mask 1", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlowMask1Channel("Glow Mask 1 Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlowMask2("Glow Mask 2", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlowMask2Channel("Glow Mask 2 Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlowMask3("Glow Mask 3", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlowMask3Channel("Glow Mask 3 Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_SpecularMask("Specular Mask", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_SpecularMaskChannel("Specular Mask Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_FleckColorMap("Fleck Color Map", Float) = 4
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_SpecularTintMap("Specular Tint Map", Float) = 4
		[Header()][Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_ClearCoatHighlightMap("Clear Coat Highlight Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_ClearCoatHighlightChannel("Clear Coat Highlight Channel", Float) = 0
		[Header()][Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_ClearCoatReflectionMap("Clear Coat Reflection Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_ClearCoatReflectionChannel("Clear Coat Reflection Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_ClearCoatMap("Clear Coat Map", Float) = 0
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_ClearCoatChannel("Clear Coat Channel", Float) = 2
		[Header()][Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlintHighlightMap("Glint Highlight Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlintHighlightChannel("Glint Highlight Channel", Float) = 0
		[Header()][Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlintGlossMap("Glint Gloss Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlintGlossChannel("Glint Gloss Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_GlintMap("Glint Map", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_GlintChannel("Glint Channel", Float) = 0
		[Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,None,4)]_DetailNormalMask("Detail Normal Mask", Float) = 4
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_DetailNormalChannel("Detail Normal Channel", Float) = 0
		[ToggleUI]_GlintIgnoreNormals("Glint Ignore Normals", Float) = 0
		_FleckShape("FleckShape", 2D) = "white" {}
		_FleckVariance("FleckVariance", Range( 0 , 1)) = 0
		[HDR]_FleckColor("Fleck Color", Color) = (1,1,1,1)
		[ToggleUI]_UseAlbedo("Use Albedo", Float) = 0
		_FleckIntensity("Fleck Intensity", Range( 0 , 10)) = 1
		[Enum(UnityEngine.Rendering.CullMode)]_Culling("Culling", Float) = 2
		[HDR]_EmissionGlowTint("EmissionGlowTint", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_EmissionGlowZone("EmissionGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_EmissionGlowMode("EmissionGlowMode", Int) = 0
		[Enum(Multiply,0,Additive,1)]_EmissionGlowBlendMode("EmissionGlowBlendMode", Int) = 0
		_EmissionGlowMinBrightness("EmissionGlowMinBrightness", Range( 0 , 1)) = 0
		_EmissionGlowPulseDir("EmissionGlowPulseDir", Float) = 0
		_EmissionGlowPulseScale("EmissionGlowPulseScale", Float) = 127
		_EmissionGlowPulseOffset("EmissionGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_EmissionGlowAnimationBand("EmissionGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_EmissionGlowAnimationMode("EmissionGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_EmissionGlowAnimationSpeed("EmissionGlowAnimationSpeed", Int) = 0
		_EmissionGlowAnimationStrength("EmissionGlowAnimationStrength", Float) = 1
		_EmissionGlowRadialCenter("EmissionGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_EmissionReactiveTint("EmissionReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_EmissionReactiveBand("EmissionReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_EmissionReactiveMode("EmissionReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_EmissionReactiveBlendMode("EmissionReactiveBlendMode", Int) = 0
		_EmissionReactiveMinBrightness("EmissionReactiveMinBrightness", Range( 0 , 1)) = 0
		_EmissionReactiveGlobalSmoothing("EmissionReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_EmissionReactivePulseDir("EmissionReactivePulseDir", Float) = 0
		_EmissionReactivePulseScale("EmissionReactivePulseScale", Float) = 127
		_EmissionReactivePulseOffset("EmissionReactivePulseOffset", Float) = 0
		_EmissionReactiveRadialCenter("EmissionReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowEmissGlow("_ShowEmissGlow", Float) = 0
		_ShowEmissAL("_ShowEmissAL", Float) = 0
		_DirectionalMap("DirectionalMap", 2D) = "white" {}
		[ToggleUI]_UseFallback0("Use Fallback 0", Float) = 0
		[HDR]_RedChGlowTint("RedChGlowTint", Color) = (1,1,1,0)
		[HDR]_RedChGlowFallback("RedChGlowFallback", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_RedChGlowZone("RedChGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_RedChGlowMode("RedChGlowMode", Int) = 0
		_RedChGlowMinBrightness("RedChGlowMinBrightness", Range( 0 , 1)) = 0
		_RedChGlowPulseDir("RedChGlowPulseDir", Float) = 0
		_RedChGlowPulseScale("RedChGlowPulseScale", Float) = 127
		_RedChGlowPulseOffset("RedChGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_RedChGlowAnimationBand("RedChGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_RedChGlowAnimationMode("RedChGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_RedChGlowAnimationSpeed("RedChGlowAnimationSpeed", Int) = 0
		_RedChGlowAnimationStrength("RedChGlowAnimationStrength", Float) = 1
		_RedChGlowRadialCenter("RedChGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_RedChReactiveTint("RedChReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_RedChReactiveBand("RedChReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_RedChReactiveMode("RedChReactiveMode", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_RedChReactiveBlendMode("RedChReactiveBlendMode", Int) = 0
		_RedChReactiveMinBrightness("RedChReactiveMinBrightness", Range( 0 , 1)) = 0
		_RedChReactiveGlobalSmoothing("RedChReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_RedChReactivePulseDir("RedChReactivePulseDir", Float) = 0
		_RedChReactivePulseScale("RedChReactivePulseScale", Float) = 127
		_RedChReactivePulseOffset("RedChReactivePulseOffset", Float) = 0
		_RedChReactiveRadialCenter("RedChReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowRedGlow("_ShowRedGlow", Float) = 0
		_ShowRedAL("_ShowRedAL", Float) = 0
		[ToggleUI]_EnableRedChannel("_EnableRedChannel", Float) = 0
		[ToggleUI]_UseFallback1("Use Fallback 1", Float) = 0
		[HDR]_GreenChGlowTint("GreenChGlowTint", Color) = (1,1,1,0)
		[HDR]_GreenChGlowFallback("GreenChGlowFallback", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_GreenChGlowZone("GreenChGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_GreenChGlowMode("GreenChGlowMode", Int) = 0
		_GreenChReactiveMinBrightness("GreenChReactiveMinBrightness", Range( 0 , 1)) = 0
		_GreenChGlowPulseDir("GreenChGlowPulseDir", Float) = 0
		_GreenChGlowPulseScale("GreenChGlowPulseScale", Float) = 127
		_GreenChGlowPulseOffset("GreenChGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_GreenChGlowAnimationBand("GreenChGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_GreenChGlowAnimationMode("GreenChGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_GreenChGlowAnimationSpeed("GreenChGlowAnimationSpeed", Int) = 0
		_GreenChGlowAnimationStrength("GreenChGlowAnimationStrength", Float) = 1
		_GreenChGlowRadialCenter("GreenChGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_GreenChReactiveTint("GreenChReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_GreenChReactiveBand("GreenChReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_GreenChReactiveMode("GreenChReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_GreenChReactiveBlendMode("GreenChReactiveBlendMode", Int) = 0
		_GreenChGlowMinBrightness("GreenChGlowMinBrightness", Range( 0 , 1)) = 0
		_GreenChReactiveGlobalSmoothing("GreenChReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_GreenChReactivePulseDir("GreenChReactivePulseDir", Float) = 0
		_GreenChReactivePulseScale("GreenChReactivePulseScale", Float) = 127
		_GreenChReactivePulseOffset("GreenChReactivePulseOffset", Float) = 0
		_GreenChReactiveRadialCenter("GreenChReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowGreenGlow("_ShowGreenGlow", Float) = 0
		_ShowGreenAL("_ShowGreenAL", Float) = 0
		[ToggleUI]_EnableGreenChannel("_EnableGreenChannel", Float) = 0
		[ToggleUI]_UseFallback2("Use Fallback 2", Float) = 0
		[HDR]_BlueChGlowTint("BlueChGlowTint", Color) = (1,1,1,0)
		[HDR]_BlueChGlowFallback("BlueChGlowFallback", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_BlueChGlowZone("BlueChGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_BlueChGlowMode("BlueChGlowMode", Int) = 0
		_BlueChGlowMinBrightness("BlueChGlowMinBrightness", Range( 0 , 1)) = 0
		_BlueChGlowPulseDir("BlueChGlowPulseDir", Float) = 0
		_BlueChGlowPulseScale("BlueChGlowPulseScale", Float) = 127
		_BlueChGlowPulseOffset("BlueChGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_BlueChGlowAnimationBand("BlueChGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_BlueChGlowAnimationMode("BlueChGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_BlueChGlowAnimationSpeed("BlueChGlowAnimationSpeed", Int) = 0
		_BlueChGlowAnimationStrength("BlueChGlowAnimationStrength", Float) = 1
		_BlueChGlowRadialCenter("BlueChGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_BlueChReactiveTint("BlueChReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_BlueChReactiveBand("BlueChReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_BlueChReactiveMode("BlueChReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_BlueChReactiveBlendMode("BlueChReactiveBlendMode", Int) = 0
		_BlueChReactiveMinBrightness("BlueChReactiveMinBrightness", Range( 0 , 1)) = 0
		_BlueChReactiveGlobalSmoothing("BlueChReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_BlueChReactivePulseDir("BlueChReactivePulseDir", Float) = 0
		_BlueChReactivePulseScale("BlueChReactivePulseScale", Float) = 127
		_BlueChReactivePulseOffset("BlueChReactivePulseOffset", Float) = 0
		_BlueChReactiveRadialCenter("BlueChReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowBlueGlow("_ShowBlueGlow", Float) = 0
		_ShowBlueAL("_ShowBlueAL", Float) = 0
		[ToggleUI]_EnableBlueChannel("_EnableBlueChannel", Float) = 0
		[ToggleUI]_UseFallback3("Use Fallback 3", Float) = 0
		[HDR]_AlphaChGlowTint("AlphaChGlowTint", Color) = (1,1,1,0)
		[HDR]_AlphaChGlowFallback("AlphaChGlowFallback", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_AlphaChGlowZone("AlphaChGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_AlphaChGlowMode("AlphaChGlowMode", Int) = 0
		_AlphaChGlowMinBrightness("AlphaChGlowMinBrightness", Range( 0 , 1)) = 0
		_AlphaChGlowPulseDir("AlphaChGlowPulseDir", Float) = 0
		_AlphaChGlowPulseScale("AlphaChGlowPulseScale", Float) = 127
		_AlphaChGlowPulseOffset("AlphaChGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_AlphaChGlowAnimationBand("AlphaChGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_AlphaChGlowAnimationMode("AlphaChGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_AlphaChGlowAnimationSpeed("AlphaChGlowAnimationSpeed", Int) = 0
		_AlphaChGlowAnimationStrength("AlphaChGlowAnimationStrength", Float) = 1
		_AlphaChGlowRadialCenter("AlphaChGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_AlphaChReactiveTint("AlphaChReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_AlphaChReactiveBand("AlphaChReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_AlphaChReactiveMode("AlphaChReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_AlphaChReactiveBlendMode("AlphaChReactiveBlendMode", Int) = 0
		_AlphaChReactiveMinBrightness("AlphaChReactiveMinBrightness", Range( 0 , 1)) = 0
		_AlphaChReactiveGlobalSmoothing("AlphaChReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_AlphaChReactivePulseDir("AlphaChReactivePulseDir", Float) = 0
		_AlphaChReactivePulseScale("AlphaChReactivePulseScale", Float) = 127
		_AlphaChReactivePulseOffset("AlphaChReactivePulseOffset", Float) = 0
		_AlphaChReactiveRadialCenter("AlphaChReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowAlphaGlow("_ShowAlphaGlow", Float) = 0
		_ShowAlphaAL("_ShowAlphaAL", Float) = 0
		[ToggleUI]_EnableAlphaChannel("_EnableAlphaChannel", Float) = 0
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_DirectionMapUV("DirectionMapUV", Float) = 0
		_MaskClipValue("MaskClipValue", Float) = 0.5
		[Enum(UnityEngine.Rendering.BlendOp)]_BlendOpRGB("Blend Op RGB", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_DestinationBlendRGB("Destination Blend RGB", Float) = 10
		[Enum(UnityEngine.Rendering.BlendMode)]_SourceBlendRGB("Source Blend RGB", Float) = 1
		[ToggleUI]_AffectDiffuseColor("Affect Diffuse Color", Float) = 0
		[ToggleUI]_AffectDiffuseNormals("AffectDiffuseNormals", Float) = 0
		[ToggleUI]_AffectIndirectColor("AffectIndirectColor", Float) = 0
		_FleckMetallic("FleckMetallic", Range( 0 , 2)) = 1
		[ToggleUI]_AffectIndirect("Affect Indirect", Float) = 0
		_FleckScale("Fleck Scale", Float) = 500
		_FleckSize("Fleck Size", Float) = 0.35
		_GlintTimescale("Glint Timescale", Float) = 0.001
		_DictionaryTex("Texture 0", 2D) = "white" {}
		_ShowMaps("ShowMaps", Float) = 0
		_Color("Color", Color) = (1,1,1,1)
		_ShowLighting("ShowLighting", Float) = 0
		_ShowEmissionMain("ShowEmissionMain", Float) = 0
		_ShowEmission("ShowEmission", Float) = 0
		_ShowTileDiscard("ShowTileDiscard", Float) = 0
		_ShowEmission04("ShowEmission04", Float) = 0
		_ShowEmission02("ShowEmission02", Float) = 0
		_ShowEmission03("ShowEmission03", Float) = 0
		_ShowEmission01("ShowEmission01", Float) = 0
		_ShowMain("ShowMain", Float) = 0
		[Toggle(_EMISSION)] _EnableEmission("Emission", Float) = 0
		[Header(Main)]_MainTex("Main Tex", 2D) = "white" {}
		_EmissionMap("EmissionMap", 2D) = "white" {}
		[HDR]_EmissionColor("Emission Tint", Color) = (0,0,0,0)
		_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 1)) = 1
		[Enum(Furality,3,Metallic,0,Specular,1,Packed,2)]_Workflow("Workflow", Float) = 3
		_MaskMap01("Mask Map 01", 2D) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_MaskMap01UV("MaskMap01UV", Float) = 0
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_DetailUV("DetailUV", Float) = 0
		_MaskMap02("Mask Map 02", 2D) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_MaskMap02UV("MaskMap02UV", Float) = 0
		_MaskMap03("Mask Map 03", 2D) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_MaskMap03UV("MaskMap03UV", Float) = 0
		_MaskMap04("Mask Map 04", 2D) = "white" {}
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_MaskMap04UV("MaskMap04UV", Float) = 0
		[ToggleUI]_ReplaceBaseColor("Replace Base Color", Float) = 0
		_MetallicMult("MetallicMult", Range( 0 , 2)) = 1
		_GlossMult("GlossMult", Range( 0 , 1)) = 1
		[ToggleUI]_InvertGloss("Invert Gloss", Float) = 0
		_OcclusionPower("Occlusion Power", Range( 0 , 1)) = 1
		_SpecularTint("Specular Tint", Color) = (1,1,1,0)
		[Toggle(_CLEARCOAT_ON)] _ClearCoat("Clear Coat", Float) = 0
		_ClearCoatHighlight("Clear Coat Highlight", Range( 0 , 1)) = 0.9
		_BlendModeIndex("_BlendModeIndex", Float) = 0
		_ClearCoatReflection("Clear Coat Reflection", Range( 0 , 1)) = 1
		_BlendOPsrc("_BlendOPsrc", Float) = 5
		_BlendOPIndex("_BlendOPIndex", Float) = 0
		_BlendOPdst("_BlendOPdst", Float) = 10
		_ClearCoatNormalScale("Clear Coat Normal Scale", Range( 0 , 1)) = 1
		_ClearCoatDetailNormalScale("Clear Coat Detail Normal Scale", Range( 0 , 1)) = 1
		[Enum(None,0,Normal,1,Detail Normal,2,Both,3)]_ClearCoatNormal("Clear Coat Normal", Float) = 0
		[Toggle(_GLINT_ON)] _SpecularGlint("Specular Glint", Float) = 0
		[Toggle(_GLINT_HIGHLIGHT_ON)] _GlintHighlightToggle("Glint Highlight", Float) = 0
		_GlintHighlight("Glint Highlight", Range( 0 , 1)) = 0.5
		[Header()][Enum(Map 01,0,Map 02,1,Map 03,2,Map 04,3,MainTex,5,None,4)]_OpacityMap("Opacity Map", Float) = 5
		_GlintIntensity("Glint Intensity", Range( 0 , 2)) = 1
		[Enum(Red,0,Green,1,Blue,2,Alpha,3)]_OpacityChannel("Opacity Channel", Float) = 3
		_GlintGloss("Glint Gloss", Range( 0 , 1)) = 0.95
		_GlintAmount("Glint Amount", Range( 0 , 1)) = 0.5
		_GlintDensity("Glint Density", Range( 0 , 1)) = 0.5
		[Header(Detail Normal)]_DetailNormal("DetailNormal", 2D) = "bump" {}
		_BumpScale1("Detail Normal Scale", Range( 0 , 1)) = 1
		_UVTileDissolveAlpha_Row3_0("Row 3 Column 0", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row3_1("Row 3 Column 1", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row3_2("Row 3 Column 2", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row3_3("Row 3 Column 3", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row2_0("Row 2 Column 0", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row2_1("Row 2 Column 1", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row2_2("Row 2 Column 2", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row2_3("Row 2 Column 3", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row1_0("Row 1 Column 0", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row1_1("Row 1 Column 1", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row1_2("Row 1 Column 2", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row1_3("Row 1 Column 3", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row0_0("Row 0 Column 0", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row0_1("Row 0 Column 1", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row0_2("Row 0 Column 2", Range( 0 , 1)) = 0
		_UVTileDissolveAlpha_Row0_3("Row 0 Column 3", Range( 0 , 1)) = 0
		[ToggleUI]_UDIMDiscardRow3_0("UDIMDiscardRow3_0", Float) = 0
		[ToggleUI]_UDIMDiscardRow3_1("UDIMDiscardRow3_1", Float) = 0
		[ToggleUI]_UDIMDiscardRow3_2("UDIMDiscardRow3_2", Float) = 0
		[ToggleUI]_UDIMDiscardRow3_3("UDIMDiscardRow3_3", Float) = 0
		[ToggleUI]_UDIMDiscardRow2_0("UDIMDiscardRow2_0", Float) = 0
		[ToggleUI]_UDIMDiscardRow2_1("UDIMDiscardRow2_1", Float) = 0
		[ToggleUI]_UDIMDiscardRow2_2("UDIMDiscardRow2_2", Float) = 0
		[ToggleUI]_UDIMDiscardRow2_3("UDIMDiscardRow2_3", Float) = 0
		[ToggleUI]_UDIMDiscardRow1_0("UDIMDiscardRow1_0", Float) = 0
		[ToggleUI]_UDIMDiscardRow1_1("UDIMDiscardRow1_1", Float) = 0
		[ToggleUI]_UDIMDiscardRow1_2("UDIMDiscardRow1_2", Float) = 0
		[ToggleUI]_UDIMDiscardRow1_3("UDIMDiscardRow1_3", Float) = 0
		[ToggleUI]_UDIMDiscardRow0_0("UDIMDiscardRow0_0", Float) = 0
		[ToggleUI]_UDIMDiscardRow0_1("UDIMDiscardRow0_1", Float) = 0
		[ToggleUI]_UDIMDiscardRow0_2("UDIMDiscardRow0_2", Float) = 0
		[ToggleUI]_UDIMDiscardRow0_3("UDIMDiscardRow0_3", Float) = 0
		[Enum(UV0,0,UV1,1,UV2,2,UV3,3,UV4,4)]_TileDiscardUV("TileDiscardUV", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  "VRCFallback"="Cutout" }
		Cull [_Culling]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		#pragma shader_feature_local _EMISSION
		#pragma shader_feature_local _CLEARCOAT_ON
		#pragma shader_feature_local _GLINT_ON
		#pragma shader_feature_local _GLINT_HIGHLIGHT_ON
		#include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif

		struct appdata_full_custom
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			float4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			float4 ase_texcoord4 : TEXCOORD4;
		};
		struct Input
		{
			float2 uv_texcoord;
			float2 vertexToFrag51_g8229;
			float2 vertexToFrag51_g5489;
			float2 vertexToFrag51_g5488;
			float2 vertexToFrag51_g5487;
			float2 vertexToFrag51_g5486;
			float3 worldNormal;
			INTERNAL_DATA
			float2 vertexToFrag51_g8211;
			half ASEIsFrontFacing : VFACE;
			float3 worldPos;
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

		uniform float _ShowEmissGlow;
		uniform float _ShowEmissAL;
		uniform float _ShowRedGlow;
		uniform float _ShowRedAL;
		uniform float _ShowGreenGlow;
		uniform float _ShowGreenAL;
		uniform float _ShowBlueGlow;
		uniform float _ShowBlueAL;
		uniform float _ShowAlphaGlow;
		uniform float _ShowAlphaAL;
		uniform float _Culling;
		uniform float _BlendOPdst;
		uniform float _BlendModeIndex;
		uniform float _BlendOPIndex;
		uniform float _BlendOPsrc;
		uniform float _ShowMaps;
		uniform float _ShowMain;
		uniform float _ShowLighting;
		uniform float _ShowEmission;
		uniform float _ShowEmissionMain;
		uniform float _ShowEmission01;
		uniform float _ShowEmission02;
		uniform float _ShowEmission03;
		uniform float _ShowEmission04;
		uniform float _ShowTileDiscard;
		uniform float _GlintIntensity;
		uniform float _GlintIgnoreNormals;
		uniform float _SourceBlendRGB;
		uniform float _DestinationBlendRGB;
		uniform float _BlendOpRGB;
		uniform float _MaskClipValue;
		uniform float _TileDiscardUV;
		uniform float _UVTileDissolveAlpha_Row0_0;
		uniform float _UDIMDiscardRow0_0;
		uniform float _UVTileDissolveAlpha_Row0_1;
		uniform float _UDIMDiscardRow0_1;
		uniform float _UVTileDissolveAlpha_Row0_2;
		uniform float _UDIMDiscardRow0_2;
		uniform float _UVTileDissolveAlpha_Row0_3;
		uniform float _UDIMDiscardRow0_3;
		uniform float _UVTileDissolveAlpha_Row1_0;
		uniform float _UDIMDiscardRow1_0;
		uniform float _UVTileDissolveAlpha_Row1_1;
		uniform float _UDIMDiscardRow1_1;
		uniform float _UVTileDissolveAlpha_Row1_2;
		uniform float _UDIMDiscardRow1_2;
		uniform float _UVTileDissolveAlpha_Row1_3;
		uniform float _UDIMDiscardRow1_3;
		uniform float _UVTileDissolveAlpha_Row2_0;
		uniform float _UDIMDiscardRow2_0;
		uniform float _UVTileDissolveAlpha_Row2_1;
		uniform float _UDIMDiscardRow2_1;
		uniform float _UVTileDissolveAlpha_Row2_2;
		uniform float _UDIMDiscardRow2_2;
		uniform float _UVTileDissolveAlpha_Row2_3;
		uniform float _UDIMDiscardRow2_3;
		uniform float _UVTileDissolveAlpha_Row3_0;
		uniform float _UDIMDiscardRow3_0;
		uniform float _UVTileDissolveAlpha_Row3_1;
		uniform float _UDIMDiscardRow3_1;
		uniform float _UVTileDissolveAlpha_Row3_2;
		uniform float _UDIMDiscardRow3_2;
		uniform float _UVTileDissolveAlpha_Row3_3;
		uniform float _UDIMDiscardRow3_3;
		uniform float _EnableRedChannel;
		uniform float4 _RedChGlowFallback;
		uniform int _RedChGlowZone;
		uniform float _RedChGlowPulseDir;
		uniform float _RedChGlowPulseScale;
		uniform float _RedChGlowPulseOffset;
		uniform float _RedChGlowAnimationStrength;
		uniform int _RedChGlowAnimationMode;
		uniform int _RedChGlowAnimationBand;
		uniform int _RedChGlowAnimationSpeed;
		uniform float2 _RedChGlowRadialCenter;
		uniform int _RedChGlowMode;
		uniform sampler2D _DirectionalMap;
		uniform float4 _DirectionalMap_ST;
		uniform float _DirectionMapUV;
		uniform float _RedChGlowMinBrightness;
		uniform float4 _RedChGlowTint;
		uniform int _RedChReactiveBand;
		uniform float _RedChReactivePulseDir;
		uniform float _RedChReactivePulseScale;
		uniform float _RedChReactivePulseOffset;
		uniform float2 _RedChReactiveRadialCenter;
		uniform int _RedChReactiveMode;
		uniform float _RedChReactiveGlobalSmoothing;
		uniform float _RedChReactiveMinBrightness;
		uniform float4 _RedChReactiveTint;
		uniform int _RedChReactiveBlendMode;
		uniform float _GlowMask0Channel;
		uniform float _GlowMask0;
		uniform sampler2D _MaskMap04;
		uniform float4 _MaskMap04_ST;
		uniform float _MaskMap04UV;
		uniform sampler2D _MaskMap03;
		uniform float4 _MaskMap03_ST;
		uniform float _MaskMap03UV;
		uniform sampler2D _MaskMap02;
		uniform float4 _MaskMap02_ST;
		uniform float _MaskMap02UV;
		uniform sampler2D _MaskMap01;
		uniform float4 _MaskMap01_ST;
		uniform float _MaskMap01UV;
		uniform float _GlowMask1Channel;
		uniform float _GlowMask1;
		uniform float _GlowMask2Channel;
		uniform float _GlowMask2;
		uniform float _GlowMask3Channel;
		uniform float _GlowMask3;
		uniform float _UseFallback0;
		uniform float _EnableGreenChannel;
		uniform float4 _GreenChGlowFallback;
		uniform int _GreenChGlowZone;
		uniform float _GreenChGlowPulseDir;
		uniform float _GreenChGlowPulseScale;
		uniform float _GreenChGlowPulseOffset;
		uniform float _GreenChGlowAnimationStrength;
		uniform int _GreenChGlowAnimationMode;
		uniform int _GreenChGlowAnimationBand;
		uniform int _GreenChGlowAnimationSpeed;
		uniform float2 _GreenChGlowRadialCenter;
		uniform int _GreenChGlowMode;
		uniform float _GreenChGlowMinBrightness;
		uniform float4 _GreenChGlowTint;
		uniform int _GreenChReactiveBand;
		uniform float _GreenChReactivePulseDir;
		uniform float _GreenChReactivePulseScale;
		uniform float _GreenChReactivePulseOffset;
		uniform float2 _GreenChReactiveRadialCenter;
		uniform int _GreenChReactiveMode;
		uniform float _GreenChReactiveGlobalSmoothing;
		uniform float _GreenChReactiveMinBrightness;
		uniform float4 _GreenChReactiveTint;
		uniform int _GreenChReactiveBlendMode;
		uniform float _UseFallback1;
		uniform float _EnableBlueChannel;
		uniform float4 _BlueChGlowFallback;
		uniform int _BlueChGlowZone;
		uniform float _BlueChGlowPulseDir;
		uniform float _BlueChGlowPulseScale;
		uniform float _BlueChGlowPulseOffset;
		uniform float _BlueChGlowAnimationStrength;
		uniform int _BlueChGlowAnimationMode;
		uniform int _BlueChGlowAnimationBand;
		uniform int _BlueChGlowAnimationSpeed;
		uniform float2 _BlueChGlowRadialCenter;
		uniform int _BlueChGlowMode;
		uniform float _BlueChGlowMinBrightness;
		uniform float4 _BlueChGlowTint;
		uniform int _BlueChReactiveBand;
		uniform float _BlueChReactivePulseDir;
		uniform float _BlueChReactivePulseScale;
		uniform float _BlueChReactivePulseOffset;
		uniform float2 _BlueChReactiveRadialCenter;
		uniform int _BlueChReactiveMode;
		uniform float _BlueChReactiveGlobalSmoothing;
		uniform float _BlueChReactiveMinBrightness;
		uniform float4 _BlueChReactiveTint;
		uniform int _BlueChReactiveBlendMode;
		uniform float _UseFallback2;
		uniform float _EnableAlphaChannel;
		uniform float4 _AlphaChGlowFallback;
		uniform int _AlphaChGlowZone;
		uniform float _AlphaChGlowPulseDir;
		uniform float _AlphaChGlowPulseScale;
		uniform float _AlphaChGlowPulseOffset;
		uniform float _AlphaChGlowAnimationStrength;
		uniform int _AlphaChGlowAnimationMode;
		uniform int _AlphaChGlowAnimationBand;
		uniform int _AlphaChGlowAnimationSpeed;
		uniform float2 _AlphaChGlowRadialCenter;
		uniform int _AlphaChGlowMode;
		uniform float _AlphaChGlowMinBrightness;
		uniform float4 _AlphaChGlowTint;
		uniform int _AlphaChReactiveBand;
		uniform float _AlphaChReactivePulseDir;
		uniform float _AlphaChReactivePulseScale;
		uniform float _AlphaChReactivePulseOffset;
		uniform float2 _AlphaChReactiveRadialCenter;
		uniform int _AlphaChReactiveMode;
		uniform float _AlphaChReactiveGlobalSmoothing;
		uniform float _AlphaChReactiveMinBrightness;
		uniform float4 _AlphaChReactiveTint;
		uniform int _AlphaChReactiveBlendMode;
		uniform float _UseFallback3;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float _EmissionMaskChannel;
		uniform float _EmissionMaskMap;
		uniform int _EmissionGlowZone;
		uniform float _EmissionGlowPulseDir;
		uniform float _EmissionGlowPulseScale;
		uniform float _EmissionGlowPulseOffset;
		uniform float _EmissionGlowAnimationStrength;
		uniform int _EmissionGlowAnimationMode;
		uniform int _EmissionGlowAnimationBand;
		uniform int _EmissionGlowAnimationSpeed;
		uniform float2 _EmissionGlowRadialCenter;
		uniform int _EmissionGlowMode;
		uniform float _EmissionGlowMinBrightness;
		uniform float4 _EmissionGlowTint;
		uniform int _EmissionReactiveBand;
		uniform float _EmissionReactivePulseDir;
		uniform float _EmissionReactivePulseScale;
		uniform float _EmissionReactivePulseOffset;
		uniform float2 _EmissionReactiveRadialCenter;
		uniform int _EmissionReactiveMode;
		uniform float _EmissionReactiveGlobalSmoothing;
		uniform float _EmissionReactiveMinBrightness;
		uniform float4 _EmissionReactiveTint;
		uniform int _EmissionReactiveBlendMode;
		uniform int _EmissionGlowBlendMode;
		uniform float4 _Color;
		uniform float _OpacityMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _ReplaceBaseColor;
		uniform float _OpacityChannel;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _BumpScale;
		uniform sampler2D _DetailNormal;
		uniform float4 _DetailNormal_ST;
		uniform float _DetailUV;
		uniform float _BumpScale1;
		uniform float _DetailNormalChannel;
		uniform float _DetailNormalMask;
		uniform float _FleckScale;
		uniform float _GlintDensity;
		uniform sampler2D _FleckShape;
		uniform float _FleckSize;
		uniform float _GlintAmount;
		uniform sampler2D _DictionaryTex;
		uniform float _GlintTimescale;
		uniform float4 _FleckColor;
		uniform float _GlintChannel;
		uniform float _GlintMap;
		uniform float _AffectDiffuseNormals;
		uniform float _GlossChannel;
		uniform float _GlossMap;
		uniform float _Workflow;
		uniform float _InvertGloss;
		uniform float _GlossMult;
		uniform float _MetallicChannel;
		uniform float _MetallicMask;
		uniform float _MetallicMult;
		uniform float4 _SpecularTint;
		uniform float _SpecularTintMap;
		uniform float _FleckColorMap;
		uniform float _UseAlbedo;
		uniform float _FleckVariance;
		uniform float _FleckMetallicChannel;
		uniform float _FleckMetallicMap;
		uniform float _FleckMetallic;
		uniform float _AffectIndirectColor;
		uniform float _FleckIntensity;
		uniform float _GlintGloss;
		uniform float _GlintGlossChannel;
		uniform float _GlintGlossMap;
		uniform float _GlintHighlight;
		uniform float _GlintHighlightChannel;
		uniform float _GlintHighlightMap;
		uniform float _ClearCoatNormalScale;
		uniform float _ClearCoatNormal;
		uniform float _ClearCoatDetailNormalScale;
		uniform float _ClearCoatHighlight;
		uniform float _InvertHighlightGloss;
		uniform float _ClearCoatHighlightChannel;
		uniform float _ClearCoatHighlightMap;
		uniform float _ClearCoatChannel;
		uniform float _ClearCoatMap;
		uniform float _SpecularMaskChannel;
		uniform float _SpecularMask;
		uniform float _AffectDiffuseColor;
		uniform float _OcclusionChannel;
		uniform float _OcclusionMap;
		uniform float _OcclusionPower;
		uniform float _ReflectionMaskChannel;
		uniform float _ReflectionMask;
		uniform float _AffectIndirect;
		uniform float _ClearCoatReflection;
		uniform float _InvertReflectionGloss;
		uniform float _ClearCoatReflectionChannel;
		uniform float _ClearCoatReflectionMap;


		float3 getThemeData( int Zone )
		{
			float3 result = lerp(AudioLinkData(ALPASS_THEME_COLOR0),AudioLinkData(ALPASS_THEME_COLOR1),saturate(Zone));
			result = lerp(result,AudioLinkData(ALPASS_THEME_COLOR2),saturate(Zone-1));
			result = lerp(result,AudioLinkData(ALPASS_THEME_COLOR3),saturate(Zone-2));
			return result;
		}


		float3 ProbeDir(  )
		{
			return half3(unity_SHAr.r,unity_SHAg.g,unity_SHAb.b);
		}


		float3 Hash32( float2 p )
		{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
			    p3 += dot(p3, p3.yxz+33.33);
			    return frac((p3.xxy+p3.yzz)*p3.zyx);
		}


		half OneMinusReflectivity( half metallic )
		{
			   return OneMinusReflectivityFromMetallic(metallic);
		}


		inline int IsLumaActive11_g8253( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g8252( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8255( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g8259( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g8254( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g8258( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g8256( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8257( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8262(  )
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


		inline float AudioLinkData3_g8247( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g8246( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g8249( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g8251( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8261(  )
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


		inline int IsLumaActive11_g8270( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g8269( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8272( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g8276( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g8271( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g8275( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g8273( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8274( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8279(  )
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


		inline float AudioLinkData3_g8264( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g8263( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g8266( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g8268( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8278(  )
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


		inline int IsLumaActive11_g8287( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g8286( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8289( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g8293( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g8288( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g8292( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g8290( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8291( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8296(  )
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


		inline float AudioLinkData3_g8281( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g8280( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g8283( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g8285( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8295(  )
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


		inline int IsLumaActive11_g8304( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g8303( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8306( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g8310( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g8305( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g8309( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g8307( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8308( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8313(  )
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


		inline float AudioLinkData3_g8298( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g8297( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g8300( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g8302( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		int IfAudioLinkv2Exists1_g8312(  )
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


		inline int IsLumaActive11_g8241( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g8240( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8243( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g8245( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g8242( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g8239( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g8237( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g8238( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g8231( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g8233( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g8235( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		inline float glslmod270_g8230( float x, float y )
		{
			return glsl_mod(x,y);
		}


		int IfAudioLinkv2Exists1_g8244(  )
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


		float2 voronoihash10_g8321( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi10_g8321( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash10_g8321( n + g );
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


		float3 ASESafeNormalize(float3 inVec)
		{
			float dp3 = max(1.175494351e-38, dot(inVec, inVec));
			return inVec* rsqrt(dp3);
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

		float3 sampleReflectionProbe5_g8317( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
		}


		inline int IsLumaActive11_g8318( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		int LightExists8_g8330(  )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				return 0;
				}
			return 1;
		}


		float3 CenterEye1_g8324(  )
		{
			#if defined(USING_STEREO_MATRICES)
			float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
			float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
			float3 centerEye = lerp(leftEye, rightEye, 0.5);
			#else
			float3 centerEye = _WorldSpaceCameraPos;
			#endif
			return centerEye;
		}


		int LightExists8_g8326(  )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				return 0;
				}
			return 1;
		}


		int LightExists8_g8328(  )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				return 0;
				}
			return 1;
		}


		int LightExists8_g8332(  )
		{
			int lightEnv = int(any(_WorldSpaceLightPos0.xyz));       
			if(lightEnv != 1){
				return 0;
				}
			return 1;
		}


		float3 sampleReflectionProbe381_g8329( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
		}


		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 _Vector4 = float2(0,0);
			float temp_output_14_0_g8314 = _TileDiscardUV;
			float2 lerpResult31_g8314 = lerp( v.texcoord.xy , v.texcoord1.xy , saturate( temp_output_14_0_g8314 ));
			float temp_output_36_0_g8314 = ( temp_output_14_0_g8314 - 1.0 );
			float2 lerpResult34_g8314 = lerp( lerpResult31_g8314 , v.texcoord2.xy , saturate( temp_output_36_0_g8314 ));
			float temp_output_40_0_g8314 = ( temp_output_36_0_g8314 - 1.0 );
			float2 lerpResult38_g8314 = lerp( lerpResult34_g8314 , v.texcoord3.xy , saturate( temp_output_40_0_g8314 ));
			float2 lerpResult41_g8314 = lerp( lerpResult38_g8314 , v.ase_texcoord4.xy , saturate( ( temp_output_40_0_g8314 - 1.0 ) ));
			float2 vertexToFrag51_g8314 = lerpResult41_g8314;
			float2 TileDiscardUVs18_g8315 = ( vertexToFrag51_g8314 + -1.0 );
			float2 break10_g8315 = TileDiscardUVs18_g8315;
			float Row0Col071_g8315 = saturate( ( max( max( step( _Vector4.x , break10_g8315.x ) , step( -( _Vector4.x - 1.0 ) , -break10_g8315.x ) ) , max( step( _Vector4.y , break10_g8315.y ) , step( -( _Vector4.y - 1.0 ) , -break10_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row0_0 ) * ( 1.0 - _UDIMDiscardRow0_0 ) ) ) );
			float2 _Vector5 = float2(1,0);
			float2 break82_g8315 = TileDiscardUVs18_g8315;
			float Row0Col189_g8315 = saturate( ( max( max( step( _Vector5.x , break82_g8315.x ) , step( -( _Vector5.x - 1.0 ) , -break82_g8315.x ) ) , max( step( _Vector5.y , break82_g8315.y ) , step( -( _Vector5.y - 1.0 ) , -break82_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row0_1 ) * ( 1.0 - _UDIMDiscardRow0_1 ) ) ) );
			float2 _Vector6 = float2(2,0);
			float2 break100_g8315 = TileDiscardUVs18_g8315;
			float Row0Col2106_g8315 = saturate( ( max( max( step( _Vector6.x , break100_g8315.x ) , step( -( _Vector6.x - 1.0 ) , -break100_g8315.x ) ) , max( step( _Vector6.y , break100_g8315.y ) , step( -( _Vector6.y - 1.0 ) , -break100_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row0_2 ) * ( 1.0 - _UDIMDiscardRow0_2 ) ) ) );
			float2 _Vector7 = float2(3,0);
			float2 break118_g8315 = TileDiscardUVs18_g8315;
			float Row0Col3124_g8315 = saturate( ( max( max( step( _Vector7.x , break118_g8315.x ) , step( -( _Vector7.x - 1.0 ) , -break118_g8315.x ) ) , max( step( _Vector7.y , break118_g8315.y ) , step( -( _Vector7.y - 1.0 ) , -break118_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row0_3 ) * ( 1.0 - _UDIMDiscardRow0_3 ) ) ) );
			float2 _Vector8 = float2(0,1);
			float2 break141_g8315 = TileDiscardUVs18_g8315;
			float Row1Col0148_g8315 = saturate( ( max( max( step( _Vector8.x , break141_g8315.x ) , step( -( _Vector8.x - 1.0 ) , -break141_g8315.x ) ) , max( step( _Vector8.y , break141_g8315.y ) , step( -( _Vector8.y - 1.0 ) , -break141_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row1_0 ) * ( 1.0 - _UDIMDiscardRow1_0 ) ) ) );
			float2 _Vector9 = float2(1,1);
			float2 break159_g8315 = TileDiscardUVs18_g8315;
			float Row1Col1165_g8315 = saturate( ( max( max( step( _Vector9.x , break159_g8315.x ) , step( -( _Vector9.x - 1.0 ) , -break159_g8315.x ) ) , max( step( _Vector9.y , break159_g8315.y ) , step( -( _Vector9.y - 1.0 ) , -break159_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row1_1 ) * ( 1.0 - _UDIMDiscardRow1_1 ) ) ) );
			float2 _Vector10 = float2(2,1);
			float2 break177_g8315 = TileDiscardUVs18_g8315;
			float Row1Col2183_g8315 = saturate( ( max( max( step( _Vector10.x , break177_g8315.x ) , step( -( _Vector10.x - 1.0 ) , -break177_g8315.x ) ) , max( step( _Vector10.y , break177_g8315.y ) , step( -( _Vector10.y - 1.0 ) , -break177_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row1_2 ) * ( 1.0 - _UDIMDiscardRow1_2 ) ) ) );
			float2 _Vector11 = float2(3,1);
			float2 break195_g8315 = TileDiscardUVs18_g8315;
			float Row1Col3201_g8315 = saturate( ( max( max( step( _Vector11.x , break195_g8315.x ) , step( -( _Vector11.x - 1.0 ) , -break195_g8315.x ) ) , max( step( _Vector11.y , break195_g8315.y ) , step( -( _Vector11.y - 1.0 ) , -break195_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row1_3 ) * ( 1.0 - _UDIMDiscardRow1_3 ) ) ) );
			float2 _Vector12 = float2(0,2);
			float2 break222_g8315 = TileDiscardUVs18_g8315;
			float Row2Col0229_g8315 = saturate( ( max( max( step( _Vector12.x , break222_g8315.x ) , step( -( _Vector12.x - 1.0 ) , -break222_g8315.x ) ) , max( step( _Vector12.y , break222_g8315.y ) , step( -( _Vector12.y - 1.0 ) , -break222_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row2_0 ) * ( 1.0 - _UDIMDiscardRow2_0 ) ) ) );
			float2 _Vector13 = float2(1,2);
			float2 break239_g8315 = TileDiscardUVs18_g8315;
			float Row2Col1245_g8315 = saturate( ( max( max( step( _Vector13.x , break239_g8315.x ) , step( -( _Vector13.x - 1.0 ) , -break239_g8315.x ) ) , max( step( _Vector13.y , break239_g8315.y ) , step( -( _Vector13.y - 1.0 ) , -break239_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row2_1 ) * ( 1.0 - _UDIMDiscardRow2_1 ) ) ) );
			float2 _Vector14 = float2(2,2);
			float2 break256_g8315 = TileDiscardUVs18_g8315;
			float Row2Col2262_g8315 = saturate( ( max( max( step( _Vector14.x , break256_g8315.x ) , step( -( _Vector14.x - 1.0 ) , -break256_g8315.x ) ) , max( step( _Vector14.y , break256_g8315.y ) , step( -( _Vector14.y - 1.0 ) , -break256_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row2_2 ) * ( 1.0 - _UDIMDiscardRow2_2 ) ) ) );
			float2 _Vector15 = float2(3,2);
			float2 break273_g8315 = TileDiscardUVs18_g8315;
			float Row2Col3279_g8315 = saturate( ( max( max( step( _Vector15.x , break273_g8315.x ) , step( -( _Vector15.x - 1.0 ) , -break273_g8315.x ) ) , max( step( _Vector15.y , break273_g8315.y ) , step( -( _Vector15.y - 1.0 ) , -break273_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row2_3 ) * ( 1.0 - _UDIMDiscardRow2_3 ) ) ) );
			float2 _Vector19 = float2(0,3);
			float2 break294_g8315 = TileDiscardUVs18_g8315;
			float Row3Col0352_g8315 = saturate( ( max( max( step( _Vector19.x , break294_g8315.x ) , step( -( _Vector19.x - 1.0 ) , -break294_g8315.x ) ) , max( step( _Vector19.y , break294_g8315.y ) , step( -( _Vector19.y - 1.0 ) , -break294_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row3_0 ) * ( 1.0 - _UDIMDiscardRow3_0 ) ) ) );
			float2 _Vector16 = float2(1,3);
			float2 break309_g8315 = TileDiscardUVs18_g8315;
			float Row3Col1351_g8315 = saturate( ( max( max( step( _Vector16.x , break309_g8315.x ) , step( -( _Vector16.x - 1.0 ) , -break309_g8315.x ) ) , max( step( _Vector16.y , break309_g8315.y ) , step( -( _Vector16.y - 1.0 ) , -break309_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row3_1 ) * ( 1.0 - _UDIMDiscardRow3_1 ) ) ) );
			float2 _Vector17 = float2(2,3);
			float2 break325_g8315 = TileDiscardUVs18_g8315;
			float Row3Col2350_g8315 = saturate( ( max( max( step( _Vector17.x , break325_g8315.x ) , step( -( _Vector17.x - 1.0 ) , -break325_g8315.x ) ) , max( step( _Vector17.y , break325_g8315.y ) , step( -( _Vector17.y - 1.0 ) , -break325_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row3_2 ) * ( 1.0 - _UDIMDiscardRow3_2 ) ) ) );
			float2 _Vector18 = float2(3,3);
			float2 break341_g8315 = TileDiscardUVs18_g8315;
			float Row3Col3349_g8315 = saturate( ( max( max( step( _Vector18.x , break341_g8315.x ) , step( -( _Vector18.x - 1.0 ) , -break341_g8315.x ) ) , max( step( _Vector18.y , break341_g8315.y ) , step( -( _Vector18.y - 1.0 ) , -break341_g8315.y ) ) ) + ( ( 1.0 - _UVTileDissolveAlpha_Row3_3 ) * ( 1.0 - _UDIMDiscardRow3_3 ) ) ) );
			float3 temp_cast_0 = (( 0.0 / 0.0 )).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz = ( ( ( ( Row0Col071_g8315 * Row0Col189_g8315 * Row0Col2106_g8315 * Row0Col3124_g8315 ) * ( Row1Col0148_g8315 * Row1Col1165_g8315 * Row1Col2183_g8315 * Row1Col3201_g8315 ) ) * ( ( Row2Col0229_g8315 * Row2Col1245_g8315 * Row2Col2262_g8315 * Row2Col3279_g8315 ) * ( Row3Col0352_g8315 * Row3Col1351_g8315 * Row3Col2350_g8315 * Row3Col3349_g8315 ) ) ) < 0.001 ? temp_cast_0 : ase_vertex3Pos );
			v.vertex.w = 1;
			float2 uv_DirectionalMap = v.texcoord.xy * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float2 uv2_DirectionalMap = v.texcoord1.xy * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float temp_output_14_0_g8229 = _DirectionMapUV;
			float2 lerpResult11_g8229 = lerp( uv_DirectionalMap , uv2_DirectionalMap , saturate( temp_output_14_0_g8229 ));
			float2 uv3_DirectionalMap = v.texcoord2.xy * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float temp_output_16_0_g8229 = ( temp_output_14_0_g8229 - 1.0 );
			float2 lerpResult12_g8229 = lerp( lerpResult11_g8229 , uv3_DirectionalMap , saturate( temp_output_16_0_g8229 ));
			float2 uv4_DirectionalMap = v.texcoord3.xy * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float temp_output_21_0_g8229 = ( temp_output_16_0_g8229 - 1.0 );
			float2 lerpResult19_g8229 = lerp( lerpResult12_g8229 , uv4_DirectionalMap , saturate( temp_output_21_0_g8229 ));
			float2 uv5_DirectionalMap = v.ase_texcoord4 * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float2 lerpResult27_g8229 = lerp( lerpResult19_g8229 , uv5_DirectionalMap.xy , saturate( ( temp_output_21_0_g8229 - 1.0 ) ));
			o.vertexToFrag51_g8229 = lerpResult27_g8229;
			float2 uv_MaskMap04 = v.texcoord.xy * _MaskMap04_ST.xy + _MaskMap04_ST.zw;
			float2 uv2_MaskMap04 = v.texcoord1.xy * _MaskMap04_ST.xy + _MaskMap04_ST.zw;
			float temp_output_14_0_g5489 = _MaskMap04UV;
			float2 lerpResult11_g5489 = lerp( uv_MaskMap04 , uv2_MaskMap04 , saturate( temp_output_14_0_g5489 ));
			float2 uv3_MaskMap04 = v.texcoord2.xy * _MaskMap04_ST.xy + _MaskMap04_ST.zw;
			float temp_output_16_0_g5489 = ( temp_output_14_0_g5489 - 1.0 );
			float2 lerpResult12_g5489 = lerp( lerpResult11_g5489 , uv3_MaskMap04 , saturate( temp_output_16_0_g5489 ));
			float2 uv4_MaskMap04 = v.texcoord3.xy * _MaskMap04_ST.xy + _MaskMap04_ST.zw;
			float temp_output_21_0_g5489 = ( temp_output_16_0_g5489 - 1.0 );
			float2 lerpResult19_g5489 = lerp( lerpResult12_g5489 , uv4_MaskMap04 , saturate( temp_output_21_0_g5489 ));
			float2 uv5_MaskMap04 = v.ase_texcoord4 * _MaskMap04_ST.xy + _MaskMap04_ST.zw;
			float2 lerpResult27_g5489 = lerp( lerpResult19_g5489 , uv5_MaskMap04.xy , saturate( ( temp_output_21_0_g5489 - 1.0 ) ));
			o.vertexToFrag51_g5489 = lerpResult27_g5489;
			float2 uv_MaskMap03 = v.texcoord.xy * _MaskMap03_ST.xy + _MaskMap03_ST.zw;
			float2 uv2_MaskMap03 = v.texcoord1.xy * _MaskMap03_ST.xy + _MaskMap03_ST.zw;
			float temp_output_14_0_g5488 = _MaskMap03UV;
			float2 lerpResult11_g5488 = lerp( uv_MaskMap03 , uv2_MaskMap03 , saturate( temp_output_14_0_g5488 ));
			float2 uv3_MaskMap03 = v.texcoord2.xy * _MaskMap03_ST.xy + _MaskMap03_ST.zw;
			float temp_output_16_0_g5488 = ( temp_output_14_0_g5488 - 1.0 );
			float2 lerpResult12_g5488 = lerp( lerpResult11_g5488 , uv3_MaskMap03 , saturate( temp_output_16_0_g5488 ));
			float2 uv4_MaskMap03 = v.texcoord3.xy * _MaskMap03_ST.xy + _MaskMap03_ST.zw;
			float temp_output_21_0_g5488 = ( temp_output_16_0_g5488 - 1.0 );
			float2 lerpResult19_g5488 = lerp( lerpResult12_g5488 , uv4_MaskMap03 , saturate( temp_output_21_0_g5488 ));
			float2 uv5_MaskMap03 = v.ase_texcoord4 * _MaskMap03_ST.xy + _MaskMap03_ST.zw;
			float2 lerpResult27_g5488 = lerp( lerpResult19_g5488 , uv5_MaskMap03.xy , saturate( ( temp_output_21_0_g5488 - 1.0 ) ));
			o.vertexToFrag51_g5488 = lerpResult27_g5488;
			float2 uv_MaskMap02 = v.texcoord.xy * _MaskMap02_ST.xy + _MaskMap02_ST.zw;
			float2 uv2_MaskMap02 = v.texcoord1.xy * _MaskMap02_ST.xy + _MaskMap02_ST.zw;
			float temp_output_14_0_g5487 = _MaskMap02UV;
			float2 lerpResult11_g5487 = lerp( uv_MaskMap02 , uv2_MaskMap02 , saturate( temp_output_14_0_g5487 ));
			float2 uv3_MaskMap02 = v.texcoord2.xy * _MaskMap02_ST.xy + _MaskMap02_ST.zw;
			float temp_output_16_0_g5487 = ( temp_output_14_0_g5487 - 1.0 );
			float2 lerpResult12_g5487 = lerp( lerpResult11_g5487 , uv3_MaskMap02 , saturate( temp_output_16_0_g5487 ));
			float2 uv4_MaskMap02 = v.texcoord3.xy * _MaskMap02_ST.xy + _MaskMap02_ST.zw;
			float temp_output_21_0_g5487 = ( temp_output_16_0_g5487 - 1.0 );
			float2 lerpResult19_g5487 = lerp( lerpResult12_g5487 , uv4_MaskMap02 , saturate( temp_output_21_0_g5487 ));
			float2 uv5_MaskMap02 = v.ase_texcoord4 * _MaskMap02_ST.xy + _MaskMap02_ST.zw;
			float2 lerpResult27_g5487 = lerp( lerpResult19_g5487 , uv5_MaskMap02.xy , saturate( ( temp_output_21_0_g5487 - 1.0 ) ));
			o.vertexToFrag51_g5487 = lerpResult27_g5487;
			float2 uv_MaskMap01 = v.texcoord.xy * _MaskMap01_ST.xy + _MaskMap01_ST.zw;
			float2 uv2_MaskMap01 = v.texcoord1.xy * _MaskMap01_ST.xy + _MaskMap01_ST.zw;
			float temp_output_14_0_g5486 = _MaskMap01UV;
			float2 lerpResult11_g5486 = lerp( uv_MaskMap01 , uv2_MaskMap01 , saturate( temp_output_14_0_g5486 ));
			float2 uv3_MaskMap01 = v.texcoord2.xy * _MaskMap01_ST.xy + _MaskMap01_ST.zw;
			float temp_output_16_0_g5486 = ( temp_output_14_0_g5486 - 1.0 );
			float2 lerpResult12_g5486 = lerp( lerpResult11_g5486 , uv3_MaskMap01 , saturate( temp_output_16_0_g5486 ));
			float2 uv4_MaskMap01 = v.texcoord3.xy * _MaskMap01_ST.xy + _MaskMap01_ST.zw;
			float temp_output_21_0_g5486 = ( temp_output_16_0_g5486 - 1.0 );
			float2 lerpResult19_g5486 = lerp( lerpResult12_g5486 , uv4_MaskMap01 , saturate( temp_output_21_0_g5486 ));
			float2 uv5_MaskMap01 = v.ase_texcoord4 * _MaskMap01_ST.xy + _MaskMap01_ST.zw;
			float2 lerpResult27_g5486 = lerp( lerpResult19_g5486 , uv5_MaskMap01.xy , saturate( ( temp_output_21_0_g5486 - 1.0 ) ));
			o.vertexToFrag51_g5486 = lerpResult27_g5486;
			float2 uv_DetailNormal = v.texcoord.xy * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float2 uv2_DetailNormal = v.texcoord1.xy * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float temp_output_14_0_g8211 = _DetailUV;
			float2 lerpResult11_g8211 = lerp( uv_DetailNormal , uv2_DetailNormal , saturate( temp_output_14_0_g8211 ));
			float2 uv3_DetailNormal = v.texcoord2.xy * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float temp_output_16_0_g8211 = ( temp_output_14_0_g8211 - 1.0 );
			float2 lerpResult12_g8211 = lerp( lerpResult11_g8211 , uv3_DetailNormal , saturate( temp_output_16_0_g8211 ));
			float2 uv4_DetailNormal = v.texcoord3.xy * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float temp_output_21_0_g8211 = ( temp_output_16_0_g8211 - 1.0 );
			float2 lerpResult19_g8211 = lerp( lerpResult12_g8211 , uv4_DetailNormal , saturate( temp_output_21_0_g8211 ));
			float2 uv5_DetailNormal = v.ase_texcoord4 * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float2 lerpResult27_g8211 = lerp( lerpResult19_g8211 , uv5_DetailNormal.xy , saturate( ( temp_output_21_0_g8211 - 1.0 ) ));
			o.vertexToFrag51_g8211 = lerpResult27_g8211;
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
			float4 MainTexColor1832 = _Color;
			float4 tex2DNode9 = tex2D( _MaskMap01, i.vertexToFrag51_g5486 );
			float4 MM01RGBA295 = tex2DNode9;
			float4 tex2DNode52 = tex2D( _MaskMap02, i.vertexToFrag51_g5487 );
			float4 MM02RGBA296 = tex2DNode52;
			float4 lerpResult1798 = lerp( MM01RGBA295 , MM02RGBA296 , saturate( _OpacityMap ));
			float4 tex2DNode406 = tex2D( _MaskMap03, i.vertexToFrag51_g5488 );
			float4 MM03RGBA412 = tex2DNode406;
			float temp_output_1792_0 = ( _OpacityMap - 1.0 );
			float4 lerpResult1800 = lerp( lerpResult1798 , MM03RGBA412 , saturate( temp_output_1792_0 ));
			float4 tex2DNode414 = tex2D( _MaskMap04, i.vertexToFrag51_g5489 );
			float4 MM04RGBA420 = tex2DNode414;
			float temp_output_1797_0 = ( temp_output_1792_0 - 1.0 );
			float4 lerpResult1804 = lerp( lerpResult1800 , MM04RGBA420 , saturate( temp_output_1797_0 ));
			float4 temp_cast_250 = (1.0).xxxx;
			float temp_output_1802_0 = ( temp_output_1797_0 - 1.0 );
			float4 lerpResult1808 = lerp( lerpResult1804 , temp_cast_250 , saturate( temp_output_1802_0 ));
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float4 EmissionRGBA590 = ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) );
			float temp_output_43_0_g8192 = _EmissionMaskChannel;
			float temp_output_21_0_g8192 = ( temp_output_43_0_g8192 - 1.0 );
			float temp_output_42_0_g8192 = _EmissionMaskMap;
			float temp_output_6_0_g8192 = ( temp_output_42_0_g8192 - 1.0 );
			float temp_output_9_0_g8192 = ( temp_output_6_0_g8192 - 1.0 );
			float4 temp_cast_251 = (1.0).xxxx;
			float4 MM04RGBA178_g8013 = MM04RGBA420;
			float4 MM03RGBA177_g8013 = MM03RGBA412;
			float4 MM02RGBA175_g8013 = MM02RGBA296;
			float4 MM01RGBA176_g8013 = MM01RGBA295;
			float4 ifLocalVar10_g8192 = 0;
			if( saturate( temp_output_42_0_g8192 ) > 0.0 )
				ifLocalVar10_g8192 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8192 ) == 0.0 )
				ifLocalVar10_g8192 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8192 = 0;
			if( saturate( temp_output_6_0_g8192 ) > 0.0 )
				ifLocalVar14_g8192 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8192 ) == 0.0 )
				ifLocalVar14_g8192 = ifLocalVar10_g8192;
			float4 ifLocalVar17_g8192 = 0;
			if( saturate( temp_output_9_0_g8192 ) > 0.0 )
				ifLocalVar17_g8192 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8192 ) == 0.0 )
				ifLocalVar17_g8192 = ifLocalVar14_g8192;
			float4 ifLocalVar19_g8192 = 0;
			if( saturate( ( temp_output_9_0_g8192 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8192 = temp_cast_251;
			else if( saturate( ( temp_output_9_0_g8192 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8192 = ifLocalVar17_g8192;
			float ifLocalVar28_g8192 = 0;
			if( saturate( temp_output_43_0_g8192 ) > 0.0 )
				ifLocalVar28_g8192 = (ifLocalVar19_g8192).g;
			else if( saturate( temp_output_43_0_g8192 ) == 0.0 )
				ifLocalVar28_g8192 = (ifLocalVar19_g8192).r;
			float ifLocalVar32_g8192 = 0;
			if( saturate( temp_output_21_0_g8192 ) > 0.0 )
				ifLocalVar32_g8192 = (ifLocalVar19_g8192).b;
			else if( saturate( temp_output_21_0_g8192 ) == 0.0 )
				ifLocalVar32_g8192 = ifLocalVar28_g8192;
			float ifLocalVar33_g8192 = 0;
			if( saturate( ( temp_output_21_0_g8192 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8192 = (ifLocalVar19_g8192).a;
			else if( saturate( ( temp_output_21_0_g8192 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8192 = ifLocalVar32_g8192;
			float temp_output_363_0_g8013 = ifLocalVar33_g8192;
			float EmissionMaskChannel676 = temp_output_363_0_g8013;
			float4 lerpResult689 = lerp( ( tex2D( _MainTex, uv_MainTex ) * _Color ) , EmissionRGBA590 , ( _ReplaceBaseColor * EmissionMaskChannel676 ));
			float4 MainTexRGBA7 = lerpResult689;
			float temp_output_1809_0 = saturate( ( temp_output_1802_0 - 1.0 ) );
			float4 lerpResult1810 = lerp( lerpResult1808 , MainTexRGBA7 , temp_output_1809_0);
			float lerpResult1817 = lerp( (lerpResult1810).r , (lerpResult1810).g , saturate( _OpacityChannel ));
			float temp_output_1816_0 = ( _OpacityChannel - 1.0 );
			float lerpResult1822 = lerp( lerpResult1817 , (lerpResult1810).b , saturate( temp_output_1816_0 ));
			float temp_output_1824_0 = (lerpResult1810).a;
			float lerpResult1825 = lerp( lerpResult1822 , temp_output_1824_0 , saturate( ( temp_output_1816_0 - 1.0 ) ));
			float lerpResult1827 = lerp( lerpResult1825 , temp_output_1824_0 , temp_output_1809_0);
			float OpacityChannel1828 = lerpResult1827;
			float temp_output_1831_0 = ( (MainTexColor1832).a * OpacityChannel1828 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 Normal23 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale );
			float2 temp_output_1610_0 = i.vertexToFrag51_g8211;
			float3 DetailNormal596 = UnpackScaleNormal( tex2D( _DetailNormal, temp_output_1610_0 ), _BumpScale1 );
			float temp_output_43_0_g8194 = _DetailNormalChannel;
			float temp_output_21_0_g8194 = ( temp_output_43_0_g8194 - 1.0 );
			float temp_output_42_0_g8194 = _DetailNormalMask;
			float temp_output_6_0_g8194 = ( temp_output_42_0_g8194 - 1.0 );
			float temp_output_9_0_g8194 = ( temp_output_6_0_g8194 - 1.0 );
			float4 temp_cast_260 = (1.0).xxxx;
			float4 ifLocalVar10_g8194 = 0;
			if( saturate( temp_output_42_0_g8194 ) > 0.0 )
				ifLocalVar10_g8194 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8194 ) == 0.0 )
				ifLocalVar10_g8194 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8194 = 0;
			if( saturate( temp_output_6_0_g8194 ) > 0.0 )
				ifLocalVar14_g8194 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8194 ) == 0.0 )
				ifLocalVar14_g8194 = ifLocalVar10_g8194;
			float4 ifLocalVar17_g8194 = 0;
			if( saturate( temp_output_9_0_g8194 ) > 0.0 )
				ifLocalVar17_g8194 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8194 ) == 0.0 )
				ifLocalVar17_g8194 = ifLocalVar14_g8194;
			float4 ifLocalVar19_g8194 = 0;
			if( saturate( ( temp_output_9_0_g8194 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8194 = temp_cast_260;
			else if( saturate( ( temp_output_9_0_g8194 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8194 = ifLocalVar17_g8194;
			float ifLocalVar28_g8194 = 0;
			if( saturate( temp_output_43_0_g8194 ) > 0.0 )
				ifLocalVar28_g8194 = (ifLocalVar19_g8194).g;
			else if( saturate( temp_output_43_0_g8194 ) == 0.0 )
				ifLocalVar28_g8194 = (ifLocalVar19_g8194).r;
			float ifLocalVar32_g8194 = 0;
			if( saturate( temp_output_21_0_g8194 ) > 0.0 )
				ifLocalVar32_g8194 = (ifLocalVar19_g8194).b;
			else if( saturate( temp_output_21_0_g8194 ) == 0.0 )
				ifLocalVar32_g8194 = ifLocalVar28_g8194;
			float ifLocalVar33_g8194 = 0;
			if( saturate( ( temp_output_21_0_g8194 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8194 = (ifLocalVar19_g8194).a;
			else if( saturate( ( temp_output_21_0_g8194 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8194 = ifLocalVar32_g8194;
			float temp_output_379_0_g8013 = ifLocalVar33_g8194;
			float DetailNormalChannel626 = temp_output_379_0_g8013;
			float3 lerpResult639 = lerp( Normal23 , BlendNormals( Normal23 , DetailNormal596 ) , DetailNormalChannel626);
			float3 InitialNormal1580 = lerpResult639;
			float time10_g8321 = 0.0;
			float2 voronoiSmoothId10_g8321 = 0;
			float2 temp_output_53_0_g8321 = i.uv_texcoord;
			float2 coords10_g8321 = temp_output_53_0_g8321 * _FleckScale;
			float2 id10_g8321 = 0;
			float2 uv10_g8321 = 0;
			float voroi10_g8321 = voronoi10_g8321( coords10_g8321, time10_g8321, id10_g8321, uv10_g8321, 0, voronoiSmoothId10_g8321 );
			float2 FleckID79_g8321 = id10_g8321;
			float2 p19_g8321 = FleckID79_g8321;
			float3 localHash3219_g8321 = Hash32( p19_g8321 );
			float3 temp_output_23_0_g8321 = (float3( -1,-1,0 ) + (localHash3219_g8321 - float3( 0,0,0 )) * (float3( 1,1,0 ) - float3( -1,-1,0 )) / (float3( 1,1,1 ) - float3( 0,0,0 )));
			float dotResult4_g8322 = dot( FleckID79_g8321 , float2( 12.9898,78.233 ) );
			float lerpResult10_g8322 = lerp( 0.0 , 360.0 , frac( ( sin( dotResult4_g8322 ) * 43758.55 ) ));
			float cos182_g8321 = cos( radians( lerpResult10_g8322 ) );
			float sin182_g8321 = sin( radians( lerpResult10_g8322 ) );
			float2 rotator182_g8321 = mul( uv10_g8321 - float2( 0,0 ) , float2x2( cos182_g8321 , -sin182_g8321 , sin182_g8321 , cos182_g8321 )) + float2( 0,0 );
			float2 temp_output_6_0_g8323 = float2( 0.5,0.5 );
			float2 temp_output_68_0_g8321 = ( ( ( (float2( 0,0 ) + (rotator182_g8321 - float2( -1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( -1,-1 ))) - temp_output_6_0_g8323 ) * _FleckSize ) + temp_output_6_0_g8323 );
			float2 temp_output_198_0_g8321 = max( temp_output_68_0_g8321 , float2( 0,0 ) );
			float4 tex2DNode64_g8321 = tex2D( _FleckShape, temp_output_68_0_g8321, ddx( temp_output_198_0_g8321 ), ddy( temp_output_198_0_g8321 ) );
			float temp_output_54_0_g8321 = ( 1.0 - _GlintAmount );
			float mulTime12_g8321 = _Time.y * _GlintTimescale;
			float2 temp_output_16_0_g8321 = ddx( temp_output_53_0_g8321 );
			float2 temp_output_17_0_g8321 = ddy( temp_output_53_0_g8321 );
			float4 tex2DNode21_g8321 = tex2D( _DictionaryTex, ( FleckID79_g8321 + mulTime12_g8321 ), temp_output_16_0_g8321, temp_output_17_0_g8321 );
			float smoothstepResult26_g8321 = smoothstep( temp_output_54_0_g8321 , 1.0 , tex2DNode21_g8321.r);
			float temp_output_28_0_g8321 = ( _GlintDensity * tex2DNode64_g8321.a * smoothstepResult26_g8321 * _FleckColor.a );
			float3 temp_output_60_0_g8321 = InitialNormal1580;
			float3 normalizeResult133_g8321 = normalize( ( ( temp_output_23_0_g8321 * temp_output_28_0_g8321 ) + temp_output_60_0_g8321 ) );
			float temp_output_43_0_g8200 = _GlintChannel;
			float temp_output_21_0_g8200 = ( temp_output_43_0_g8200 - 1.0 );
			float temp_output_42_0_g8200 = _GlintMap;
			float temp_output_6_0_g8200 = ( temp_output_42_0_g8200 - 1.0 );
			float temp_output_9_0_g8200 = ( temp_output_6_0_g8200 - 1.0 );
			float4 temp_cast_265 = (1.0).xxxx;
			float4 ifLocalVar10_g8200 = 0;
			if( saturate( temp_output_42_0_g8200 ) > 0.0 )
				ifLocalVar10_g8200 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8200 ) == 0.0 )
				ifLocalVar10_g8200 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8200 = 0;
			if( saturate( temp_output_6_0_g8200 ) > 0.0 )
				ifLocalVar14_g8200 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8200 ) == 0.0 )
				ifLocalVar14_g8200 = ifLocalVar10_g8200;
			float4 ifLocalVar17_g8200 = 0;
			if( saturate( temp_output_9_0_g8200 ) > 0.0 )
				ifLocalVar17_g8200 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8200 ) == 0.0 )
				ifLocalVar17_g8200 = ifLocalVar14_g8200;
			float4 ifLocalVar19_g8200 = 0;
			if( saturate( ( temp_output_9_0_g8200 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8200 = temp_cast_265;
			else if( saturate( ( temp_output_9_0_g8200 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8200 = ifLocalVar17_g8200;
			float ifLocalVar28_g8200 = 0;
			if( saturate( temp_output_43_0_g8200 ) > 0.0 )
				ifLocalVar28_g8200 = (ifLocalVar19_g8200).g;
			else if( saturate( temp_output_43_0_g8200 ) == 0.0 )
				ifLocalVar28_g8200 = (ifLocalVar19_g8200).r;
			float ifLocalVar32_g8200 = 0;
			if( saturate( temp_output_21_0_g8200 ) > 0.0 )
				ifLocalVar32_g8200 = (ifLocalVar19_g8200).b;
			else if( saturate( temp_output_21_0_g8200 ) == 0.0 )
				ifLocalVar32_g8200 = ifLocalVar28_g8200;
			float ifLocalVar33_g8200 = 0;
			if( saturate( ( temp_output_21_0_g8200 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8200 = (ifLocalVar19_g8200).a;
			else if( saturate( ( temp_output_21_0_g8200 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8200 = ifLocalVar32_g8200;
			float temp_output_425_0_g8013 = ifLocalVar33_g8200;
			float GlintChannel542 = temp_output_425_0_g8013;
			float3 lerpResult1529 = lerp( InitialNormal1580 , normalizeResult133_g8321 , GlintChannel542);
			#ifdef _GLINT_ON
				float3 staticSwitch1561 = lerpResult1529;
			#else
				float3 staticSwitch1561 = InitialNormal1580;
			#endif
			float3 FleckNorm1443 = staticSwitch1561;
			float3 lerpResult1581 = lerp( lerpResult639 , FleckNorm1443 , _AffectDiffuseNormals);
			#ifdef _GLINT_ON
				float3 staticSwitch1584 = lerpResult1581;
			#else
				float3 staticSwitch1584 = lerpResult639;
			#endif
			float3 NormalFinal643 = staticSwitch1584;
			float temp_output_1130_0 = (NormalFinal643).z;
			float switchResult1132 = (((i.ASEIsFrontFacing>0)?(temp_output_1130_0):(-temp_output_1130_0)));
			float3 appendResult1134 = (float3((NormalFinal643).xy , switchResult1132));
			float3 temp_output_30_0_g8329 = appendResult1134;
			float3 normalizeResult25_g8329 = normalize( (WorldNormalVector( i , temp_output_30_0_g8329 )) );
			float3 normalDir28_g8329 = normalizeResult25_g8329;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 viewDir15_g8329 = ase_worldViewDir;
			float dotResult56_g8329 = dot( normalDir28_g8329 , viewDir15_g8329 );
			float NdotV55_g8329 = saturate( dotResult56_g8329 );
			float MM01A18 = tex2DNode9.a;
			float temp_output_43_0_g8201 = _GlossChannel;
			float temp_output_21_0_g8201 = ( temp_output_43_0_g8201 - 1.0 );
			float temp_output_42_0_g8201 = _GlossMap;
			float temp_output_6_0_g8201 = ( temp_output_42_0_g8201 - 1.0 );
			float temp_output_9_0_g8201 = ( temp_output_6_0_g8201 - 1.0 );
			float4 temp_cast_270 = (1.0).xxxx;
			float4 ifLocalVar10_g8201 = 0;
			if( saturate( temp_output_42_0_g8201 ) > 0.0 )
				ifLocalVar10_g8201 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8201 ) == 0.0 )
				ifLocalVar10_g8201 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8201 = 0;
			if( saturate( temp_output_6_0_g8201 ) > 0.0 )
				ifLocalVar14_g8201 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8201 ) == 0.0 )
				ifLocalVar14_g8201 = ifLocalVar10_g8201;
			float4 ifLocalVar17_g8201 = 0;
			if( saturate( temp_output_9_0_g8201 ) > 0.0 )
				ifLocalVar17_g8201 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8201 ) == 0.0 )
				ifLocalVar17_g8201 = ifLocalVar14_g8201;
			float4 ifLocalVar19_g8201 = 0;
			if( saturate( ( temp_output_9_0_g8201 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8201 = temp_cast_270;
			else if( saturate( ( temp_output_9_0_g8201 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8201 = ifLocalVar17_g8201;
			float ifLocalVar28_g8201 = 0;
			if( saturate( temp_output_43_0_g8201 ) > 0.0 )
				ifLocalVar28_g8201 = (ifLocalVar19_g8201).g;
			else if( saturate( temp_output_43_0_g8201 ) == 0.0 )
				ifLocalVar28_g8201 = (ifLocalVar19_g8201).r;
			float ifLocalVar32_g8201 = 0;
			if( saturate( temp_output_21_0_g8201 ) > 0.0 )
				ifLocalVar32_g8201 = (ifLocalVar19_g8201).b;
			else if( saturate( temp_output_21_0_g8201 ) == 0.0 )
				ifLocalVar32_g8201 = ifLocalVar28_g8201;
			float ifLocalVar33_g8201 = 0;
			if( saturate( ( temp_output_21_0_g8201 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8201 = (ifLocalVar19_g8201).a;
			else if( saturate( ( temp_output_21_0_g8201 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8201 = ifLocalVar32_g8201;
			float temp_output_434_0_g8013 = ifLocalVar33_g8201;
			float GlossChannel244 = temp_output_434_0_g8013;
			float Workflow212 = _Workflow;
			float temp_output_239_0 = ( Workflow212 - 1.0 );
			float lerpResult241 = lerp( MM01A18 , GlossChannel244 , saturate( temp_output_239_0 ));
			float lerpResult1709 = lerp( lerpResult241 , MM01A18 , saturate( ( temp_output_239_0 - 1.0 ) ));
			float lerpResult213 = lerp( lerpResult1709 , ( 1.0 - lerpResult1709 ) , _InvertGloss);
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_1675_0 = ddx( ase_worldNormal );
			float dotResult1677 = dot( temp_output_1675_0 , temp_output_1675_0 );
			float3 temp_output_1676_0 = ddy( ase_worldNormal );
			float dotResult1678 = dot( temp_output_1676_0 , temp_output_1676_0 );
			float temp_output_1681_0 = pow( saturate( max( dotResult1677 , dotResult1678 ) ) , 0.333 );
			float Gloss10 = ( 1.0 - max( ( 1.0 - ( lerpResult213 * _GlossMult ) ) , temp_output_1681_0 ) );
			float temp_output_147_0_g8329 = Gloss10;
			float smoothness169_g8329 = temp_output_147_0_g8329;
			float perceprualRoughness188_g8329 = ( 1.0 - smoothness169_g8329 );
			half Roughness64_g8329 = max( ( perceprualRoughness188_g8329 * perceprualRoughness188_g8329 ) , 0.002 );
			float3 localProbeDir1_g8317 = ProbeDir();
			float3 normalizeResult2_g8317 = ASESafeNormalize( localProbeDir1_g8317 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float luminance15_g8320 = Luminance(ase_lightColor.rgb);
			float smoothstepResult14_g8320 = smoothstep( 0.0 , 0.15 , saturate( luminance15_g8320 ));
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch7_g8320 = smoothstepResult14_g8320;
			#else
				float staticSwitch7_g8320 = 1.0;
			#endif
			float temp_output_11_10_g8317 = staticSwitch7_g8320;
			float3 lerpResult15_g8317 = lerp( normalizeResult2_g8317 , ase_worldlightDir , temp_output_11_10_g8317);
			float3 LightDir776 = lerpResult15_g8317;
			float3 lightDir14_g8329 = LightDir776;
			float dotResult21_g8329 = dot( lightDir14_g8329 , normalDir28_g8329 );
			float temp_output_347_0_g8329 = max( dotResult21_g8329 , 0.0 );
			float NdotL20_g8329 = temp_output_347_0_g8329;
			half SmithJointGGXVisibilityTerm42_g8329 = ( 0.5 / ( ( ( ( NdotV55_g8329 * ( 1.0 - Roughness64_g8329 ) ) + Roughness64_g8329 ) * NdotL20_g8329 ) + 1E-05 + ( NdotV55_g8329 * ( Roughness64_g8329 + ( ( 1.0 - Roughness64_g8329 ) * NdotL20_g8329 ) ) ) ) );
			float a266_g8329 = ( Roughness64_g8329 * Roughness64_g8329 );
			float3 normalizeResult87_g8329 = ASESafeNormalize( ( lightDir14_g8329 + viewDir15_g8329 ) );
			float dotResult88_g8329 = dot( normalDir28_g8329 , normalizeResult87_g8329 );
			float NdotH90_g8329 = saturate( dotResult88_g8329 );
			float d99_g8329 = ( ( ( ( NdotH90_g8329 * a266_g8329 ) - NdotH90_g8329 ) * NdotH90_g8329 ) + 1.0 );
			half GGXTerm43_g8329 = ( ( ( 1.0 / UNITY_PI ) * a266_g8329 ) / ( ( d99_g8329 * d99_g8329 ) + 1E-07 ) );
			float temp_output_36_0_g8329 = ( SmithJointGGXVisibilityTerm42_g8329 * GGXTerm43_g8329 * UNITY_PI );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch5_g8329 = sqrt( max( 0.0001 , temp_output_36_0_g8329 ) );
			#else
				float staticSwitch5_g8329 = temp_output_36_0_g8329;
			#endif
			#ifdef _SPECULARHIGHLIGHTS_OFF
				float staticSwitch119_g8329 = 0.0;
			#else
				float staticSwitch119_g8329 = max( 0.0 , ( staticSwitch5_g8329 * NdotL20_g8329 ) );
			#endif
			float MM01R16 = tex2DNode9.r;
			float lerpResult226 = lerp( MM01R16 , 0.0 , saturate( Workflow212 ));
			float temp_output_43_0_g8191 = _MetallicChannel;
			float temp_output_21_0_g8191 = ( temp_output_43_0_g8191 - 1.0 );
			float temp_output_42_0_g8191 = _MetallicMask;
			float temp_output_6_0_g8191 = ( temp_output_42_0_g8191 - 1.0 );
			float temp_output_9_0_g8191 = ( temp_output_6_0_g8191 - 1.0 );
			float4 temp_cast_276 = (1.0).xxxx;
			float4 ifLocalVar10_g8191 = 0;
			if( saturate( temp_output_42_0_g8191 ) > 0.0 )
				ifLocalVar10_g8191 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8191 ) == 0.0 )
				ifLocalVar10_g8191 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8191 = 0;
			if( saturate( temp_output_6_0_g8191 ) > 0.0 )
				ifLocalVar14_g8191 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8191 ) == 0.0 )
				ifLocalVar14_g8191 = ifLocalVar10_g8191;
			float4 ifLocalVar17_g8191 = 0;
			if( saturate( temp_output_9_0_g8191 ) > 0.0 )
				ifLocalVar17_g8191 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8191 ) == 0.0 )
				ifLocalVar17_g8191 = ifLocalVar14_g8191;
			float4 ifLocalVar19_g8191 = 0;
			if( saturate( ( temp_output_9_0_g8191 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8191 = temp_cast_276;
			else if( saturate( ( temp_output_9_0_g8191 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8191 = ifLocalVar17_g8191;
			float ifLocalVar28_g8191 = 0;
			if( saturate( temp_output_43_0_g8191 ) > 0.0 )
				ifLocalVar28_g8191 = (ifLocalVar19_g8191).g;
			else if( saturate( temp_output_43_0_g8191 ) == 0.0 )
				ifLocalVar28_g8191 = (ifLocalVar19_g8191).r;
			float ifLocalVar32_g8191 = 0;
			if( saturate( temp_output_21_0_g8191 ) > 0.0 )
				ifLocalVar32_g8191 = (ifLocalVar19_g8191).b;
			else if( saturate( temp_output_21_0_g8191 ) == 0.0 )
				ifLocalVar32_g8191 = ifLocalVar28_g8191;
			float ifLocalVar33_g8191 = 0;
			if( saturate( ( temp_output_21_0_g8191 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8191 = (ifLocalVar19_g8191).a;
			else if( saturate( ( temp_output_21_0_g8191 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8191 = ifLocalVar32_g8191;
			float temp_output_355_0_g8013 = ifLocalVar33_g8191;
			float MetallicChannel232 = temp_output_355_0_g8013;
			float temp_output_230_0 = ( Workflow212 - 1.0 );
			float lerpResult229 = lerp( lerpResult226 , MetallicChannel232 , saturate( temp_output_230_0 ));
			float lerpResult1705 = lerp( lerpResult229 , MM01R16 , saturate( ( temp_output_230_0 - 1.0 ) ));
			float Metallic224 = saturate( ( lerpResult1705 * _MetallicMult ) );
			half3 specColor2 = (0).xxx;
			half oneMinusReflectivity2 = 0;
			half3 diffuseAndSpecularFromMetallic2 = DiffuseAndSpecularFromMetallic(MainTexRGBA7.rgb,Metallic224,specColor2,oneMinusReflectivity2);
			float temp_output_42_0_g8193 = _SpecularTintMap;
			float temp_output_6_0_g8193 = ( temp_output_42_0_g8193 - 1.0 );
			float temp_output_9_0_g8193 = ( temp_output_6_0_g8193 - 1.0 );
			float4 temp_cast_281 = (1.0).xxxx;
			float4 ifLocalVar10_g8193 = 0;
			if( saturate( temp_output_42_0_g8193 ) > 0.0 )
				ifLocalVar10_g8193 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8193 ) == 0.0 )
				ifLocalVar10_g8193 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8193 = 0;
			if( saturate( temp_output_6_0_g8193 ) > 0.0 )
				ifLocalVar14_g8193 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8193 ) == 0.0 )
				ifLocalVar14_g8193 = ifLocalVar10_g8193;
			float4 ifLocalVar17_g8193 = 0;
			if( saturate( temp_output_9_0_g8193 ) > 0.0 )
				ifLocalVar17_g8193 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8193 ) == 0.0 )
				ifLocalVar17_g8193 = ifLocalVar14_g8193;
			float4 ifLocalVar19_g8193 = 0;
			if( saturate( ( temp_output_9_0_g8193 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8193 = temp_cast_281;
			else if( saturate( ( temp_output_9_0_g8193 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8193 = ifLocalVar17_g8193;
			float4 temp_output_376_0_g8013 = ifLocalVar19_g8193;
			float4 SpecularTintCol923 = temp_output_376_0_g8013;
			float3 temp_output_223_0 = (( _SpecularTint * SpecularTintCol923 )).rgb;
			float3 temp_output_220_0 = ( specColor2 * temp_output_223_0 );
			float3 temp_output_1387_0 = (( _SpecularTint * MM01RGBA295 )).rgb;
			float3 lerpResult264 = lerp( temp_output_220_0 , temp_output_1387_0 , saturate( Workflow212 ));
			float3 lerpResult267 = lerp( lerpResult264 , temp_output_220_0 , saturate( ( Workflow212 - 1.0 ) ));
			float3 InitialSpec1489 = lerpResult267;
			float3 temp_output_72_0_g8321 = MainTexRGBA7.rgb;
			float3 InitialAlbedo193_g8321 = temp_output_72_0_g8321;
			float temp_output_42_0_g8199 = _FleckColorMap;
			float temp_output_6_0_g8199 = ( temp_output_42_0_g8199 - 1.0 );
			float temp_output_9_0_g8199 = ( temp_output_6_0_g8199 - 1.0 );
			float4 temp_cast_287 = (1.0).xxxx;
			float4 ifLocalVar10_g8199 = 0;
			if( saturate( temp_output_42_0_g8199 ) > 0.0 )
				ifLocalVar10_g8199 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8199 ) == 0.0 )
				ifLocalVar10_g8199 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8199 = 0;
			if( saturate( temp_output_6_0_g8199 ) > 0.0 )
				ifLocalVar14_g8199 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8199 ) == 0.0 )
				ifLocalVar14_g8199 = ifLocalVar10_g8199;
			float4 ifLocalVar17_g8199 = 0;
			if( saturate( temp_output_9_0_g8199 ) > 0.0 )
				ifLocalVar17_g8199 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8199 ) == 0.0 )
				ifLocalVar17_g8199 = ifLocalVar14_g8199;
			float4 ifLocalVar19_g8199 = 0;
			if( saturate( ( temp_output_9_0_g8199 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8199 = temp_cast_287;
			else if( saturate( ( temp_output_9_0_g8199 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8199 = ifLocalVar17_g8199;
			float4 temp_output_424_0_g8013 = ifLocalVar19_g8199;
			float4 FleckTintCol1633 = temp_output_424_0_g8013;
			float4 temp_output_196_0_g8321 = ( float4( FleckTintCol1633.rgb , 0.0 ) * _FleckColor * float4( (tex2DNode64_g8321).rgb , 0.0 ) );
			float4 lerpResult130_g8321 = lerp( temp_output_196_0_g8321 , ( float4( temp_output_72_0_g8321 , 0.0 ) * temp_output_196_0_g8321 ) , _UseAlbedo);
			float3 hsvTorgb87_g8321 = RGBToHSV( lerpResult130_g8321.rgb );
			float2 break82_g8321 = (float2( -1,-1 ) + (FleckID79_g8321 - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 )));
			float3 hsvTorgb91_g8321 = HSVToRGB( float3(( hsvTorgb87_g8321.x + ( ( break82_g8321.x + break82_g8321.y ) * _FleckVariance ) ),hsvTorgb87_g8321.y,hsvTorgb87_g8321.z) );
			float temp_output_112_0_g8321 = ( tex2DNode64_g8321.a * smoothstepResult26_g8321 * _FleckColor.a );
			float FleckShape78_g8321 = temp_output_112_0_g8321;
			float3 lerpResult96_g8321 = lerp( InitialAlbedo193_g8321 , hsvTorgb91_g8321 , FleckShape78_g8321);
			float lerpResult1502 = lerp( MM01R16 , 0.0 , saturate( Workflow212 ));
			float temp_output_43_0_g8196 = _FleckMetallicChannel;
			float temp_output_21_0_g8196 = ( temp_output_43_0_g8196 - 1.0 );
			float temp_output_42_0_g8196 = _FleckMetallicMap;
			float temp_output_6_0_g8196 = ( temp_output_42_0_g8196 - 1.0 );
			float temp_output_9_0_g8196 = ( temp_output_6_0_g8196 - 1.0 );
			float4 temp_cast_299 = (1.0).xxxx;
			float4 ifLocalVar10_g8196 = 0;
			if( saturate( temp_output_42_0_g8196 ) > 0.0 )
				ifLocalVar10_g8196 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8196 ) == 0.0 )
				ifLocalVar10_g8196 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8196 = 0;
			if( saturate( temp_output_6_0_g8196 ) > 0.0 )
				ifLocalVar14_g8196 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8196 ) == 0.0 )
				ifLocalVar14_g8196 = ifLocalVar10_g8196;
			float4 ifLocalVar17_g8196 = 0;
			if( saturate( temp_output_9_0_g8196 ) > 0.0 )
				ifLocalVar17_g8196 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8196 ) == 0.0 )
				ifLocalVar17_g8196 = ifLocalVar14_g8196;
			float4 ifLocalVar19_g8196 = 0;
			if( saturate( ( temp_output_9_0_g8196 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8196 = temp_cast_299;
			else if( saturate( ( temp_output_9_0_g8196 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8196 = ifLocalVar17_g8196;
			float ifLocalVar28_g8196 = 0;
			if( saturate( temp_output_43_0_g8196 ) > 0.0 )
				ifLocalVar28_g8196 = (ifLocalVar19_g8196).g;
			else if( saturate( temp_output_43_0_g8196 ) == 0.0 )
				ifLocalVar28_g8196 = (ifLocalVar19_g8196).r;
			float ifLocalVar32_g8196 = 0;
			if( saturate( temp_output_21_0_g8196 ) > 0.0 )
				ifLocalVar32_g8196 = (ifLocalVar19_g8196).b;
			else if( saturate( temp_output_21_0_g8196 ) == 0.0 )
				ifLocalVar32_g8196 = ifLocalVar28_g8196;
			float ifLocalVar33_g8196 = 0;
			if( saturate( ( temp_output_21_0_g8196 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8196 = (ifLocalVar19_g8196).a;
			else if( saturate( ( temp_output_21_0_g8196 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8196 = ifLocalVar32_g8196;
			float temp_output_393_0_g8013 = ifLocalVar33_g8196;
			float FleckMetallicChannel1482 = temp_output_393_0_g8013;
			float lerpResult1505 = lerp( lerpResult1502 , FleckMetallicChannel1482 , saturate( ( Workflow212 - 1.0 ) ));
			float MetallicForFleck1509 = saturate( ( lerpResult1505 * _FleckMetallic ) );
			float temp_output_102_0_g8321 = MetallicForFleck1509;
			half3 specColor116_g8321 = (0).xxx;
			half oneMinusReflectivity116_g8321 = 0;
			half3 diffuseAndSpecularFromMetallic116_g8321 = DiffuseAndSpecularFromMetallic(lerpResult96_g8321,temp_output_102_0_g8321,specColor116_g8321,oneMinusReflectivity116_g8321);
			float3 GlintSpecCol11510 = temp_output_223_0;
			float3 temp_output_117_0_g8321 = ( specColor116_g8321 * GlintSpecCol11510 );
			float3 GlintSpecCol21511 = temp_output_1387_0;
			float temp_output_125_0_g8321 = Workflow212;
			float3 lerpResult118_g8321 = lerp( temp_output_117_0_g8321 , GlintSpecCol21511 , saturate( temp_output_125_0_g8321 ));
			float3 lerpResult122_g8321 = lerp( lerpResult118_g8321 , temp_output_117_0_g8321 , saturate( ( temp_output_125_0_g8321 - 1.0 ) ));
			float3 lerpResult103_g8321 = lerp( InitialSpec1489 , lerpResult122_g8321 , FleckShape78_g8321);
			float3 lerpResult1490 = lerp( InitialSpec1489 , lerpResult103_g8321 , _AffectIndirectColor);
			float3 lerpResult1527 = lerp( InitialSpec1489 , lerpResult1490 , GlintChannel542);
			#ifdef _GLINT_ON
				float3 staticSwitch1562 = lerpResult1527;
			#else
				float3 staticSwitch1562 = InitialSpec1489;
			#endif
			float3 GlintSpecColor1486 = staticSwitch1562;
			#ifdef _GLINT_ON
				float3 staticSwitch1488 = GlintSpecColor1486;
			#else
				float3 staticSwitch1488 = lerpResult267;
			#endif
			float3 SpecularColor42 = staticSwitch1488;
			float3 SpecColor140_g8329 = SpecularColor42;
			float SpecularTerm34_g8329 = ( staticSwitch119_g8329 * ( SpecColor140_g8329.x == float3( 0,0,0 ) ? 0.0 : 1.0 ) );
			UnityGI gi22_g8317 = gi;
			float3 diffNorm22_g8317 = normalizeResult2_g8317;
			gi22_g8317 = UnityGI_Base( data, 1, diffNorm22_g8317 );
			float3 indirectDiffuse22_g8317 = gi22_g8317.indirect.diffuse + diffNorm22_g8317 * 0.0001;
			float3 uvw5_g8317 = (WorldNormalVector( i , InitialNormal1580 ));
			float3 localsampleReflectionProbe5_g8317 = sampleReflectionProbe5_g8317( uvw5_g8317 );
			float luminance26_g8317 = Luminance(indirectDiffuse22_g8317);
			float smoothstepResult27_g8317 = smoothstep( 0.0 , 0.15 , luminance26_g8317);
			float3 lerpResult28_g8317 = lerp( localsampleReflectionProbe5_g8317 , indirectDiffuse22_g8317 , smoothstepResult27_g8317);
			#ifdef UNITY_PASS_FORWARDBASE
				float3 staticSwitch29_g8317 = lerpResult28_g8317;
			#else
				float3 staticSwitch29_g8317 = indirectDiffuse22_g8317;
			#endif
			float3 temp_output_7_0_g8317 = max( staticSwitch29_g8317 , float3( 0,0,0 ) );
			float3 lerpResult9_g8317 = lerp( temp_output_7_0_g8317 , localsampleReflectionProbe5_g8317 , 0.85);
			int Band11_g8318 = 56;
			int localIsLumaActive11_g8318 = IsLumaActive11_g8318( Band11_g8318 );
			int temp_output_8_0_g8317 = localIsLumaActive11_g8318;
			float3 lerpResult14_g8317 = lerp( temp_output_7_0_g8317 , lerpResult9_g8317 , (float)temp_output_8_0_g8317);
			float3 lerpResult16_g8317 = lerp( lerpResult14_g8317 , ase_lightColor.rgb , temp_output_11_10_g8317);
			float3 LightCol782 = lerpResult16_g8317;
			float3 temp_output_328_0_g8329 = LightCol782;
			int localLightExists8_g8330 = LightExists8_g8330();
			float luminance15_g8330 = Luminance(ase_lightColor.rgb);
			float smoothstepResult14_g8330 = smoothstep( 0.0 , 0.15 , saturate( luminance15_g8330 ));
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch7_g8330 = smoothstepResult14_g8330;
			#else
				float staticSwitch7_g8330 = 1.0;
			#endif
			float temp_output_344_0_g8329 = saturate( ( max( 0.0 , ase_lightAtten ) + ( 1.0 - ( localLightExists8_g8330 * staticSwitch7_g8330 ) ) ) );
			float3 lightAtten296_g8329 = ( temp_output_328_0_g8329 * temp_output_344_0_g8329 );
			float3 normalizeResult136_g8329 = ASESafeNormalize( ( lightDir14_g8329 + viewDir15_g8329 ) );
			float dotResult137_g8329 = dot( lightDir14_g8329 , normalizeResult136_g8329 );
			float LdotH139_g8329 = saturate( dotResult137_g8329 );
			half3 FresnelTerm130_g8329 = ( ( pow( ( 1.0 - LdotH139_g8329 ) , 5.0 ) * ( 1.0 - SpecColor140_g8329 ) ) + SpecColor140_g8329 );
			float3 temp_output_144_0_g8329 = ( SpecularTerm34_g8329 * lightAtten296_g8329 * FresnelTerm130_g8329 );
			float OnlyShadow349_g8329 = temp_output_344_0_g8329;
			float4 appendResult1333 = (float4(temp_output_144_0_g8329 , ( SpecularTerm34_g8329 * OnlyShadow349_g8329 )));
			float4 ggxSpec186 = appendResult1333;
			float3 temp_output_63_0_g8321 = LightDir776;
			float3 newWorldNormal201_g8321 = (WorldNormalVector( i , temp_output_60_0_g8321 ));
			float dotResult204_g8321 = dot( temp_output_63_0_g8321 , newWorldNormal201_g8321 );
			float dotResult200_g8321 = dot( ase_worldViewDir , newWorldNormal201_g8321 );
			float3 temp_output_30_0_g8325 = normalizeResult133_g8321;
			float3 normalizeResult25_g8325 = normalize( (WorldNormalVector( i , temp_output_30_0_g8325 )) );
			float3 normalDir28_g8325 = normalizeResult25_g8325;
			float3 localCenterEye1_g8324 = CenterEye1_g8324();
			float3 normalizeResult5_g8324 = normalize( ( localCenterEye1_g8324 - ase_worldPos ) );
			float3 viewDir15_g8325 = normalizeResult5_g8324;
			float dotResult56_g8325 = dot( normalDir28_g8325 , viewDir15_g8325 );
			float NdotV55_g8325 = saturate( dotResult56_g8325 );
			float temp_output_43_0_g8198 = _GlintGlossChannel;
			float temp_output_21_0_g8198 = ( temp_output_43_0_g8198 - 1.0 );
			float temp_output_42_0_g8198 = _GlintGlossMap;
			float temp_output_6_0_g8198 = ( temp_output_42_0_g8198 - 1.0 );
			float temp_output_9_0_g8198 = ( temp_output_6_0_g8198 - 1.0 );
			float4 temp_cast_306 = (1.0).xxxx;
			float4 ifLocalVar10_g8198 = 0;
			if( saturate( temp_output_42_0_g8198 ) > 0.0 )
				ifLocalVar10_g8198 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8198 ) == 0.0 )
				ifLocalVar10_g8198 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8198 = 0;
			if( saturate( temp_output_6_0_g8198 ) > 0.0 )
				ifLocalVar14_g8198 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8198 ) == 0.0 )
				ifLocalVar14_g8198 = ifLocalVar10_g8198;
			float4 ifLocalVar17_g8198 = 0;
			if( saturate( temp_output_9_0_g8198 ) > 0.0 )
				ifLocalVar17_g8198 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8198 ) == 0.0 )
				ifLocalVar17_g8198 = ifLocalVar14_g8198;
			float4 ifLocalVar19_g8198 = 0;
			if( saturate( ( temp_output_9_0_g8198 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8198 = temp_cast_306;
			else if( saturate( ( temp_output_9_0_g8198 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8198 = ifLocalVar17_g8198;
			float ifLocalVar28_g8198 = 0;
			if( saturate( temp_output_43_0_g8198 ) > 0.0 )
				ifLocalVar28_g8198 = (ifLocalVar19_g8198).g;
			else if( saturate( temp_output_43_0_g8198 ) == 0.0 )
				ifLocalVar28_g8198 = (ifLocalVar19_g8198).r;
			float ifLocalVar32_g8198 = 0;
			if( saturate( temp_output_21_0_g8198 ) > 0.0 )
				ifLocalVar32_g8198 = (ifLocalVar19_g8198).b;
			else if( saturate( temp_output_21_0_g8198 ) == 0.0 )
				ifLocalVar32_g8198 = ifLocalVar28_g8198;
			float ifLocalVar33_g8198 = 0;
			if( saturate( ( temp_output_21_0_g8198 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8198 = (ifLocalVar19_g8198).a;
			else if( saturate( ( temp_output_21_0_g8198 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8198 = ifLocalVar32_g8198;
			float ifLocalVar53_g8198 = 0;
			if( 0.0 > 0.0 )
				ifLocalVar53_g8198 = ( 1.0 - ifLocalVar33_g8198 );
			else if( 0.0 == 0.0 )
				ifLocalVar53_g8198 = ifLocalVar33_g8198;
			float SpecularAntiAlias1835 = temp_output_1681_0;
			float SpecAntiAlias345_g8013 = SpecularAntiAlias1835;
			float temp_output_416_0_g8013 = ( 1.0 - max( ( 1.0 - ifLocalVar53_g8198 ) , SpecAntiAlias345_g8013 ) );
			float GlintGlossChannel1240 = temp_output_416_0_g8013;
			float lerpResult136_g8321 = lerp( 0.0 , ( _GlintGloss * GlintGlossChannel1240 ) , FleckShape78_g8321);
			float temp_output_147_0_g8325 = lerpResult136_g8321;
			float smoothness169_g8325 = temp_output_147_0_g8325;
			float perceprualRoughness188_g8325 = ( 1.0 - smoothness169_g8325 );
			half Roughness64_g8325 = max( ( perceprualRoughness188_g8325 * perceprualRoughness188_g8325 ) , 0.002 );
			float3 lightDir14_g8325 = temp_output_63_0_g8321;
			float dotResult21_g8325 = dot( lightDir14_g8325 , normalDir28_g8325 );
			float temp_output_347_0_g8325 = max( dotResult21_g8325 , 0.0 );
			float NdotL20_g8325 = temp_output_347_0_g8325;
			half SmithJointGGXVisibilityTerm42_g8325 = ( 0.5 / ( ( ( ( NdotV55_g8325 * ( 1.0 - Roughness64_g8325 ) ) + Roughness64_g8325 ) * NdotL20_g8325 ) + 1E-05 + ( NdotV55_g8325 * ( Roughness64_g8325 + ( ( 1.0 - Roughness64_g8325 ) * NdotL20_g8325 ) ) ) ) );
			float a266_g8325 = ( Roughness64_g8325 * Roughness64_g8325 );
			float3 normalizeResult87_g8325 = ASESafeNormalize( ( lightDir14_g8325 + viewDir15_g8325 ) );
			float dotResult88_g8325 = dot( normalDir28_g8325 , normalizeResult87_g8325 );
			float NdotH90_g8325 = saturate( dotResult88_g8325 );
			float d99_g8325 = ( ( ( ( NdotH90_g8325 * a266_g8325 ) - NdotH90_g8325 ) * NdotH90_g8325 ) + 1.0 );
			half GGXTerm43_g8325 = ( ( ( 1.0 / UNITY_PI ) * a266_g8325 ) / ( ( d99_g8325 * d99_g8325 ) + 1E-07 ) );
			float temp_output_36_0_g8325 = ( SmithJointGGXVisibilityTerm42_g8325 * GGXTerm43_g8325 * UNITY_PI );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch5_g8325 = sqrt( max( 0.0001 , temp_output_36_0_g8325 ) );
			#else
				float staticSwitch5_g8325 = temp_output_36_0_g8325;
			#endif
			#ifdef _SPECULARHIGHLIGHTS_OFF
				float staticSwitch119_g8325 = 0.0;
			#else
				float staticSwitch119_g8325 = max( 0.0 , ( staticSwitch5_g8325 * NdotL20_g8325 ) );
			#endif
			float3 SpecColor140_g8325 = lerpResult103_g8321;
			float SpecularTerm34_g8325 = ( staticSwitch119_g8325 * ( SpecColor140_g8325.x == float3( 0,0,0 ) ? 0.0 : 1.0 ) );
			int localLightExists8_g8326 = LightExists8_g8326();
			float luminance15_g8326 = Luminance(ase_lightColor.rgb);
			float smoothstepResult14_g8326 = smoothstep( 0.0 , 0.15 , saturate( luminance15_g8326 ));
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch7_g8326 = smoothstepResult14_g8326;
			#else
				float staticSwitch7_g8326 = 1.0;
			#endif
			float temp_output_344_0_g8325 = saturate( ( max( 0.0 , ase_lightAtten ) + ( 1.0 - ( localLightExists8_g8326 * staticSwitch7_g8326 ) ) ) );
			float OnlyShadow349_g8325 = temp_output_344_0_g8325;
			float temp_output_208_348_g8321 = ( SpecularTerm34_g8325 * OnlyShadow349_g8325 );
			float3 temp_output_328_0_g8325 = LightCol782;
			float3 lightAtten296_g8325 = ( temp_output_328_0_g8325 * temp_output_344_0_g8325 );
			float3 normalizeResult136_g8325 = ASESafeNormalize( ( lightDir14_g8325 + viewDir15_g8325 ) );
			float dotResult137_g8325 = dot( lightDir14_g8325 , normalizeResult136_g8325 );
			float LdotH139_g8325 = saturate( dotResult137_g8325 );
			half3 FresnelTerm130_g8325 = ( ( pow( ( 1.0 - LdotH139_g8325 ) , 5.0 ) * ( 1.0 - SpecColor140_g8325 ) ) + SpecColor140_g8325 );
			float3 temp_output_144_0_g8325 = ( SpecularTerm34_g8325 * lightAtten296_g8325 * FresnelTerm130_g8325 );
			float3 temp_cast_312 = (1.0).xxx;
			float3 lerpResult167_g8321 = lerp( temp_cast_312 , lerpResult122_g8321 , FleckShape78_g8321);
			float4 appendResult76_g8321 = (float4(( min( _FleckIntensity , temp_output_208_348_g8321 ) * temp_output_144_0_g8325 * lerpResult167_g8321 ) , temp_output_208_348_g8321));
			float4 temp_output_1862_0 = ( ( max( dotResult204_g8321 , 0.0 ) * max( dotResult200_g8321 , 0.0 ) ) * appendResult76_g8321 );
			float4 GlintSpec175 = temp_output_1862_0;
			float3 temp_output_30_0_g8327 = appendResult1134;
			float3 normalizeResult25_g8327 = normalize( (WorldNormalVector( i , temp_output_30_0_g8327 )) );
			float3 normalDir28_g8327 = normalizeResult25_g8327;
			float3 viewDir15_g8327 = ase_worldViewDir;
			float dotResult56_g8327 = dot( normalDir28_g8327 , viewDir15_g8327 );
			float NdotV55_g8327 = saturate( dotResult56_g8327 );
			float temp_output_43_0_g8202 = _GlintHighlightChannel;
			float temp_output_21_0_g8202 = ( temp_output_43_0_g8202 - 1.0 );
			float temp_output_42_0_g8202 = _GlintHighlightMap;
			float temp_output_6_0_g8202 = ( temp_output_42_0_g8202 - 1.0 );
			float temp_output_9_0_g8202 = ( temp_output_6_0_g8202 - 1.0 );
			float4 temp_cast_313 = (1.0).xxxx;
			float4 ifLocalVar10_g8202 = 0;
			if( saturate( temp_output_42_0_g8202 ) > 0.0 )
				ifLocalVar10_g8202 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8202 ) == 0.0 )
				ifLocalVar10_g8202 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8202 = 0;
			if( saturate( temp_output_6_0_g8202 ) > 0.0 )
				ifLocalVar14_g8202 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8202 ) == 0.0 )
				ifLocalVar14_g8202 = ifLocalVar10_g8202;
			float4 ifLocalVar17_g8202 = 0;
			if( saturate( temp_output_9_0_g8202 ) > 0.0 )
				ifLocalVar17_g8202 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8202 ) == 0.0 )
				ifLocalVar17_g8202 = ifLocalVar14_g8202;
			float4 ifLocalVar19_g8202 = 0;
			if( saturate( ( temp_output_9_0_g8202 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8202 = temp_cast_313;
			else if( saturate( ( temp_output_9_0_g8202 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8202 = ifLocalVar17_g8202;
			float ifLocalVar28_g8202 = 0;
			if( saturate( temp_output_43_0_g8202 ) > 0.0 )
				ifLocalVar28_g8202 = (ifLocalVar19_g8202).g;
			else if( saturate( temp_output_43_0_g8202 ) == 0.0 )
				ifLocalVar28_g8202 = (ifLocalVar19_g8202).r;
			float ifLocalVar32_g8202 = 0;
			if( saturate( temp_output_21_0_g8202 ) > 0.0 )
				ifLocalVar32_g8202 = (ifLocalVar19_g8202).b;
			else if( saturate( temp_output_21_0_g8202 ) == 0.0 )
				ifLocalVar32_g8202 = ifLocalVar28_g8202;
			float ifLocalVar33_g8202 = 0;
			if( saturate( ( temp_output_21_0_g8202 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8202 = (ifLocalVar19_g8202).a;
			else if( saturate( ( temp_output_21_0_g8202 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8202 = ifLocalVar32_g8202;
			float ifLocalVar53_g8202 = 0;
			if( 0.0 > 0.0 )
				ifLocalVar53_g8202 = ( 1.0 - ifLocalVar33_g8202 );
			else if( 0.0 == 0.0 )
				ifLocalVar53_g8202 = ifLocalVar33_g8202;
			float temp_output_443_0_g8013 = ( 1.0 - max( ( 1.0 - ifLocalVar53_g8202 ) , SpecAntiAlias345_g8013 ) );
			float GlintHighlightChannel1272 = temp_output_443_0_g8013;
			float temp_output_147_0_g8327 = ( _GlintHighlight * GlintHighlightChannel1272 );
			float smoothness169_g8327 = temp_output_147_0_g8327;
			float perceprualRoughness188_g8327 = ( 1.0 - smoothness169_g8327 );
			half Roughness64_g8327 = max( ( perceprualRoughness188_g8327 * perceprualRoughness188_g8327 ) , 0.002 );
			float3 lightDir14_g8327 = LightDir776;
			float dotResult21_g8327 = dot( lightDir14_g8327 , normalDir28_g8327 );
			float temp_output_347_0_g8327 = max( dotResult21_g8327 , 0.0 );
			float NdotL20_g8327 = temp_output_347_0_g8327;
			half SmithJointGGXVisibilityTerm42_g8327 = ( 0.5 / ( ( ( ( NdotV55_g8327 * ( 1.0 - Roughness64_g8327 ) ) + Roughness64_g8327 ) * NdotL20_g8327 ) + 1E-05 + ( NdotV55_g8327 * ( Roughness64_g8327 + ( ( 1.0 - Roughness64_g8327 ) * NdotL20_g8327 ) ) ) ) );
			float a266_g8327 = ( Roughness64_g8327 * Roughness64_g8327 );
			float3 normalizeResult87_g8327 = ASESafeNormalize( ( lightDir14_g8327 + viewDir15_g8327 ) );
			float dotResult88_g8327 = dot( normalDir28_g8327 , normalizeResult87_g8327 );
			float NdotH90_g8327 = saturate( dotResult88_g8327 );
			float d99_g8327 = ( ( ( ( NdotH90_g8327 * a266_g8327 ) - NdotH90_g8327 ) * NdotH90_g8327 ) + 1.0 );
			half GGXTerm43_g8327 = ( ( ( 1.0 / UNITY_PI ) * a266_g8327 ) / ( ( d99_g8327 * d99_g8327 ) + 1E-07 ) );
			float temp_output_36_0_g8327 = ( SmithJointGGXVisibilityTerm42_g8327 * GGXTerm43_g8327 * UNITY_PI );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch5_g8327 = sqrt( max( 0.0001 , temp_output_36_0_g8327 ) );
			#else
				float staticSwitch5_g8327 = temp_output_36_0_g8327;
			#endif
			#ifdef _SPECULARHIGHLIGHTS_OFF
				float staticSwitch119_g8327 = 0.0;
			#else
				float staticSwitch119_g8327 = max( 0.0 , ( staticSwitch5_g8327 * NdotL20_g8327 ) );
			#endif
			float3 SpecColor140_g8327 = SpecularColor42;
			float SpecularTerm34_g8327 = ( staticSwitch119_g8327 * ( SpecColor140_g8327.x == float3( 0,0,0 ) ? 0.0 : 1.0 ) );
			float3 temp_output_328_0_g8327 = LightCol782;
			int localLightExists8_g8328 = LightExists8_g8328();
			float luminance15_g8328 = Luminance(ase_lightColor.rgb);
			float smoothstepResult14_g8328 = smoothstep( 0.0 , 0.15 , saturate( luminance15_g8328 ));
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch7_g8328 = smoothstepResult14_g8328;
			#else
				float staticSwitch7_g8328 = 1.0;
			#endif
			float temp_output_344_0_g8327 = saturate( ( max( 0.0 , ase_lightAtten ) + ( 1.0 - ( localLightExists8_g8328 * staticSwitch7_g8328 ) ) ) );
			float3 lightAtten296_g8327 = ( temp_output_328_0_g8327 * temp_output_344_0_g8327 );
			float3 normalizeResult136_g8327 = ASESafeNormalize( ( lightDir14_g8327 + viewDir15_g8327 ) );
			float dotResult137_g8327 = dot( lightDir14_g8327 , normalizeResult136_g8327 );
			float LdotH139_g8327 = saturate( dotResult137_g8327 );
			half3 FresnelTerm130_g8327 = ( ( pow( ( 1.0 - LdotH139_g8327 ) , 5.0 ) * ( 1.0 - SpecColor140_g8327 ) ) + SpecColor140_g8327 );
			float3 temp_output_144_0_g8327 = ( SpecularTerm34_g8327 * lightAtten296_g8327 * FresnelTerm130_g8327 );
			float OnlyShadow349_g8327 = temp_output_344_0_g8327;
			float4 appendResult1332 = (float4(temp_output_144_0_g8327 , ( SpecularTerm34_g8327 * OnlyShadow349_g8327 )));
			float4 GlintHighlight732 = appendResult1332;
			#ifdef _GLINT_HIGHLIGHT_ON
				float4 staticSwitch740 = ( ( GlintSpec175 + GlintHighlight732 + ggxSpec186 ) * 0.5 );
			#else
				float4 staticSwitch740 = ( GlintSpec175 + ggxSpec186 );
			#endif
			float4 lerpResult543 = lerp( ggxSpec186 , staticSwitch740 , GlintChannel542);
			#ifdef _GLINT_ON
				float4 staticSwitch544 = lerpResult543;
			#else
				float4 staticSwitch544 = ggxSpec186;
			#endif
			float4 GlintFinal572 = staticSwitch544;
			float3 tex2DNode747 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _ClearCoatNormalScale );
			float3 lerpResult743 = lerp( float3(0,0,1) , tex2DNode747 , saturate( _ClearCoatNormal ));
			float2 DetailNormUV1859 = temp_output_1610_0;
			float3 tex2DNode753 = UnpackScaleNormal( tex2D( _DetailNormal, DetailNormUV1859 ), _ClearCoatDetailNormalScale );
			float temp_output_751_0 = ( _ClearCoatNormal - 1.0 );
			float3 lerpResult750 = lerp( lerpResult743 , tex2DNode753 , saturate( temp_output_751_0 ));
			float3 lerpResult756 = lerp( lerpResult750 , BlendNormals( tex2DNode747 , tex2DNode753 ) , saturate( ( temp_output_751_0 - 1.0 ) ));
			float3 ClearCoatNormal741 = lerpResult756;
			float temp_output_1127_0 = (ClearCoatNormal741).z;
			float switchResult1126 = (((i.ASEIsFrontFacing>0)?(temp_output_1127_0):(-temp_output_1127_0)));
			float3 appendResult1129 = (float3((ClearCoatNormal741).xy , switchResult1126));
			float3 temp_output_30_0_g8331 = appendResult1129;
			float3 normalizeResult25_g8331 = normalize( (WorldNormalVector( i , temp_output_30_0_g8331 )) );
			float3 normalDir28_g8331 = normalizeResult25_g8331;
			float3 viewDir15_g8331 = ase_worldViewDir;
			float dotResult56_g8331 = dot( normalDir28_g8331 , viewDir15_g8331 );
			float NdotV55_g8331 = saturate( dotResult56_g8331 );
			float temp_output_43_0_g8203 = _ClearCoatHighlightChannel;
			float temp_output_21_0_g8203 = ( temp_output_43_0_g8203 - 1.0 );
			float temp_output_42_0_g8203 = _ClearCoatHighlightMap;
			float temp_output_6_0_g8203 = ( temp_output_42_0_g8203 - 1.0 );
			float temp_output_9_0_g8203 = ( temp_output_6_0_g8203 - 1.0 );
			float4 temp_cast_319 = (1.0).xxxx;
			float4 ifLocalVar10_g8203 = 0;
			if( saturate( temp_output_42_0_g8203 ) > 0.0 )
				ifLocalVar10_g8203 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8203 ) == 0.0 )
				ifLocalVar10_g8203 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8203 = 0;
			if( saturate( temp_output_6_0_g8203 ) > 0.0 )
				ifLocalVar14_g8203 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8203 ) == 0.0 )
				ifLocalVar14_g8203 = ifLocalVar10_g8203;
			float4 ifLocalVar17_g8203 = 0;
			if( saturate( temp_output_9_0_g8203 ) > 0.0 )
				ifLocalVar17_g8203 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8203 ) == 0.0 )
				ifLocalVar17_g8203 = ifLocalVar14_g8203;
			float4 ifLocalVar19_g8203 = 0;
			if( saturate( ( temp_output_9_0_g8203 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8203 = temp_cast_319;
			else if( saturate( ( temp_output_9_0_g8203 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8203 = ifLocalVar17_g8203;
			float ifLocalVar28_g8203 = 0;
			if( saturate( temp_output_43_0_g8203 ) > 0.0 )
				ifLocalVar28_g8203 = (ifLocalVar19_g8203).g;
			else if( saturate( temp_output_43_0_g8203 ) == 0.0 )
				ifLocalVar28_g8203 = (ifLocalVar19_g8203).r;
			float ifLocalVar32_g8203 = 0;
			if( saturate( temp_output_21_0_g8203 ) > 0.0 )
				ifLocalVar32_g8203 = (ifLocalVar19_g8203).b;
			else if( saturate( temp_output_21_0_g8203 ) == 0.0 )
				ifLocalVar32_g8203 = ifLocalVar28_g8203;
			float ifLocalVar33_g8203 = 0;
			if( saturate( ( temp_output_21_0_g8203 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8203 = (ifLocalVar19_g8203).a;
			else if( saturate( ( temp_output_21_0_g8203 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8203 = ifLocalVar32_g8203;
			float ifLocalVar53_g8203 = 0;
			if( _InvertHighlightGloss > 0.0 )
				ifLocalVar53_g8203 = ( 1.0 - ifLocalVar33_g8203 );
			else if( _InvertHighlightGloss == 0.0 )
				ifLocalVar53_g8203 = ifLocalVar33_g8203;
			float temp_output_453_0_g8013 = ( 1.0 - max( ( 1.0 - ifLocalVar53_g8203 ) , SpecAntiAlias345_g8013 ) );
			float ClearCoatHighlightChannel1168 = temp_output_453_0_g8013;
			float temp_output_147_0_g8331 = ( _ClearCoatHighlight * ClearCoatHighlightChannel1168 );
			float smoothness169_g8331 = temp_output_147_0_g8331;
			float perceprualRoughness188_g8331 = ( 1.0 - smoothness169_g8331 );
			half Roughness64_g8331 = max( ( perceprualRoughness188_g8331 * perceprualRoughness188_g8331 ) , 0.002 );
			float3 lightDir14_g8331 = LightDir776;
			float dotResult21_g8331 = dot( lightDir14_g8331 , normalDir28_g8331 );
			float temp_output_347_0_g8331 = max( dotResult21_g8331 , 0.0 );
			float NdotL20_g8331 = temp_output_347_0_g8331;
			half SmithJointGGXVisibilityTerm42_g8331 = ( 0.5 / ( ( ( ( NdotV55_g8331 * ( 1.0 - Roughness64_g8331 ) ) + Roughness64_g8331 ) * NdotL20_g8331 ) + 1E-05 + ( NdotV55_g8331 * ( Roughness64_g8331 + ( ( 1.0 - Roughness64_g8331 ) * NdotL20_g8331 ) ) ) ) );
			float a266_g8331 = ( Roughness64_g8331 * Roughness64_g8331 );
			float3 normalizeResult87_g8331 = ASESafeNormalize( ( lightDir14_g8331 + viewDir15_g8331 ) );
			float dotResult88_g8331 = dot( normalDir28_g8331 , normalizeResult87_g8331 );
			float NdotH90_g8331 = saturate( dotResult88_g8331 );
			float d99_g8331 = ( ( ( ( NdotH90_g8331 * a266_g8331 ) - NdotH90_g8331 ) * NdotH90_g8331 ) + 1.0 );
			half GGXTerm43_g8331 = ( ( ( 1.0 / UNITY_PI ) * a266_g8331 ) / ( ( d99_g8331 * d99_g8331 ) + 1E-07 ) );
			float temp_output_36_0_g8331 = ( SmithJointGGXVisibilityTerm42_g8331 * GGXTerm43_g8331 * UNITY_PI );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch5_g8331 = sqrt( max( 0.0001 , temp_output_36_0_g8331 ) );
			#else
				float staticSwitch5_g8331 = temp_output_36_0_g8331;
			#endif
			#ifdef _SPECULARHIGHLIGHTS_OFF
				float staticSwitch119_g8331 = 0.0;
			#else
				float staticSwitch119_g8331 = max( 0.0 , ( staticSwitch5_g8331 * NdotL20_g8331 ) );
			#endif
			float3 SpecColor140_g8331 = InitialSpec1489;
			float SpecularTerm34_g8331 = ( staticSwitch119_g8331 * ( SpecColor140_g8331.x == float3( 0,0,0 ) ? 0.0 : 1.0 ) );
			float3 temp_output_328_0_g8331 = LightCol782;
			int localLightExists8_g8332 = LightExists8_g8332();
			float luminance15_g8332 = Luminance(ase_lightColor.rgb);
			float smoothstepResult14_g8332 = smoothstep( 0.0 , 0.15 , saturate( luminance15_g8332 ));
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch7_g8332 = smoothstepResult14_g8332;
			#else
				float staticSwitch7_g8332 = 1.0;
			#endif
			float temp_output_344_0_g8331 = saturate( ( max( 0.0 , ase_lightAtten ) + ( 1.0 - ( localLightExists8_g8332 * staticSwitch7_g8332 ) ) ) );
			float3 lightAtten296_g8331 = ( temp_output_328_0_g8331 * temp_output_344_0_g8331 );
			float3 normalizeResult136_g8331 = ASESafeNormalize( ( lightDir14_g8331 + viewDir15_g8331 ) );
			float dotResult137_g8331 = dot( lightDir14_g8331 , normalizeResult136_g8331 );
			float LdotH139_g8331 = saturate( dotResult137_g8331 );
			half3 FresnelTerm130_g8331 = ( ( pow( ( 1.0 - LdotH139_g8331 ) , 5.0 ) * ( 1.0 - SpecColor140_g8331 ) ) + SpecColor140_g8331 );
			float3 temp_output_144_0_g8331 = ( SpecularTerm34_g8331 * lightAtten296_g8331 * FresnelTerm130_g8331 );
			float OnlyShadow349_g8331 = temp_output_344_0_g8331;
			float4 appendResult1331 = (float4(temp_output_144_0_g8331 , ( SpecularTerm34_g8331 * OnlyShadow349_g8331 )));
			float4 ggxClearCoat561 = appendResult1331;
			float4 ClearCoatSpecular580 = ( ( ggxClearCoat561 * 0.5 ) + ( 0.5 * GlintFinal572 ) );
			float Workflow346_g8013 = Workflow212;
			float4 temp_output_45_0_g8205 = MM02RGBA175_g8013;
			float temp_output_43_0_g8205 = _ClearCoatChannel;
			float temp_output_21_0_g8205 = ( temp_output_43_0_g8205 - 1.0 );
			float temp_output_42_0_g8205 = _ClearCoatMap;
			float temp_output_6_0_g8205 = ( temp_output_42_0_g8205 - 1.0 );
			float temp_output_9_0_g8205 = ( temp_output_6_0_g8205 - 1.0 );
			float4 temp_cast_326 = (1.0).xxxx;
			float4 ifLocalVar10_g8205 = 0;
			if( saturate( temp_output_42_0_g8205 ) > 0.0 )
				ifLocalVar10_g8205 = temp_output_45_0_g8205;
			else if( saturate( temp_output_42_0_g8205 ) == 0.0 )
				ifLocalVar10_g8205 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8205 = 0;
			if( saturate( temp_output_6_0_g8205 ) > 0.0 )
				ifLocalVar14_g8205 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8205 ) == 0.0 )
				ifLocalVar14_g8205 = ifLocalVar10_g8205;
			float4 ifLocalVar17_g8205 = 0;
			if( saturate( temp_output_9_0_g8205 ) > 0.0 )
				ifLocalVar17_g8205 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8205 ) == 0.0 )
				ifLocalVar17_g8205 = ifLocalVar14_g8205;
			float4 ifLocalVar19_g8205 = 0;
			if( saturate( ( temp_output_9_0_g8205 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8205 = temp_cast_326;
			else if( saturate( ( temp_output_9_0_g8205 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8205 = ifLocalVar17_g8205;
			float ifLocalVar28_g8205 = 0;
			if( saturate( temp_output_43_0_g8205 ) > 0.0 )
				ifLocalVar28_g8205 = (ifLocalVar19_g8205).g;
			else if( saturate( temp_output_43_0_g8205 ) == 0.0 )
				ifLocalVar28_g8205 = (ifLocalVar19_g8205).r;
			float ifLocalVar32_g8205 = 0;
			if( saturate( temp_output_21_0_g8205 ) > 0.0 )
				ifLocalVar32_g8205 = (ifLocalVar19_g8205).b;
			else if( saturate( temp_output_21_0_g8205 ) == 0.0 )
				ifLocalVar32_g8205 = ifLocalVar28_g8205;
			float ifLocalVar33_g8205 = 0;
			if( saturate( ( temp_output_21_0_g8205 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8205 = (ifLocalVar19_g8205).a;
			else if( saturate( ( temp_output_21_0_g8205 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8205 = ifLocalVar32_g8205;
			float ifLocalVar54_g8205 = 0;
			if( saturate( ( Workflow346_g8013 - 2.0 ) ) > 0.0 )
				ifLocalVar54_g8205 = (temp_output_45_0_g8205).r;
			else if( saturate( ( Workflow346_g8013 - 2.0 ) ) == 0.0 )
				ifLocalVar54_g8205 = ifLocalVar33_g8205;
			float temp_output_493_0_g8013 = ifLocalVar54_g8205;
			float ClearCoatChannel493 = temp_output_493_0_g8013;
			float4 lerpResult576 = lerp( GlintFinal572 , ClearCoatSpecular580 , ClearCoatChannel493);
			#ifdef _CLEARCOAT_ON
				float4 staticSwitch574 = lerpResult576;
			#else
				float4 staticSwitch574 = GlintFinal572;
			#endif
			float temp_output_43_0_g8204 = _SpecularMaskChannel;
			float temp_output_21_0_g8204 = ( temp_output_43_0_g8204 - 1.0 );
			float temp_output_42_0_g8204 = _SpecularMask;
			float temp_output_6_0_g8204 = ( temp_output_42_0_g8204 - 1.0 );
			float temp_output_9_0_g8204 = ( temp_output_6_0_g8204 - 1.0 );
			float4 temp_cast_330 = (1.0).xxxx;
			float4 ifLocalVar10_g8204 = 0;
			if( saturate( temp_output_42_0_g8204 ) > 0.0 )
				ifLocalVar10_g8204 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8204 ) == 0.0 )
				ifLocalVar10_g8204 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8204 = 0;
			if( saturate( temp_output_6_0_g8204 ) > 0.0 )
				ifLocalVar14_g8204 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8204 ) == 0.0 )
				ifLocalVar14_g8204 = ifLocalVar10_g8204;
			float4 ifLocalVar17_g8204 = 0;
			if( saturate( temp_output_9_0_g8204 ) > 0.0 )
				ifLocalVar17_g8204 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8204 ) == 0.0 )
				ifLocalVar17_g8204 = ifLocalVar14_g8204;
			float4 ifLocalVar19_g8204 = 0;
			if( saturate( ( temp_output_9_0_g8204 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8204 = temp_cast_330;
			else if( saturate( ( temp_output_9_0_g8204 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8204 = ifLocalVar17_g8204;
			float ifLocalVar28_g8204 = 0;
			if( saturate( temp_output_43_0_g8204 ) > 0.0 )
				ifLocalVar28_g8204 = (ifLocalVar19_g8204).g;
			else if( saturate( temp_output_43_0_g8204 ) == 0.0 )
				ifLocalVar28_g8204 = (ifLocalVar19_g8204).r;
			float ifLocalVar32_g8204 = 0;
			if( saturate( temp_output_21_0_g8204 ) > 0.0 )
				ifLocalVar32_g8204 = (ifLocalVar19_g8204).b;
			else if( saturate( temp_output_21_0_g8204 ) == 0.0 )
				ifLocalVar32_g8204 = ifLocalVar28_g8204;
			float ifLocalVar33_g8204 = 0;
			if( saturate( ( temp_output_21_0_g8204 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8204 = (ifLocalVar19_g8204).a;
			else if( saturate( ( temp_output_21_0_g8204 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8204 = ifLocalVar32_g8204;
			float temp_output_468_0_g8013 = ifLocalVar33_g8204;
			float SpecularMaskChannel291 = temp_output_468_0_g8013;
			float SpecularMask402 = SpecularMaskChannel291;
			float4 SpecularFinal188 = ( staticSwitch574 * SpecularMask402 );
			float4 temp_output_337_0 = max( ( 0.05 * MainTexRGBA7 ) , float4( diffuseAndSpecularFromMetallic2 , 0.0 ) );
			float3 lerpResult178_g8321 = lerp( InitialAlbedo193_g8321 , max( ( 0.05 * lerpResult96_g8321 ) , diffuseAndSpecularFromMetallic116_g8321 ) , FleckShape78_g8321);
			float3 FleckAlbedo1573 = lerpResult178_g8321;
			float FleckShape1572 = ( _AffectDiffuseColor * temp_output_112_0_g8321 );
			float4 lerpResult1575 = lerp( temp_output_337_0 , float4( FleckAlbedo1573 , 0.0 ) , ( FleckShape1572 * GlintChannel542 ));
			#ifdef _GLINT_ON
				float4 staticSwitch1574 = lerpResult1575;
			#else
				float4 staticSwitch1574 = temp_output_337_0;
			#endif
			float4 Albedo43 = staticSwitch1574;
			half fd90273_g8329 = ( 0.5 + ( 2.0 * LdotH139_g8329 * LdotH139_g8329 * perceprualRoughness188_g8329 ) );
			half lightScatter253_g8329 = ( ( ( fd90273_g8329 - 1.0 ) * pow( ( 1.0 - NdotL20_g8329 ) , 5.0 ) ) + 1.0 );
			half viewScatter254_g8329 = ( 1.0 + ( pow( ( 1.0 - NdotV55_g8329 ) , 5.0 ) * ( fd90273_g8329 - 1.0 ) ) );
			half disneydiffuse251_g8329 = ( lightScatter253_g8329 * viewScatter254_g8329 );
			half Diffuseterm281_g8329 = ( disneydiffuse251_g8329 * NdotL20_g8329 );
			float3 normal198_g8329 = temp_output_30_0_g8329;
			UnityGI gi203_g8329 = gi;
			float3 diffNorm203_g8329 = normalize( WorldNormalVector( i , normal198_g8329 ) );
			gi203_g8329 = UnityGI_Base( data, 1, diffNorm203_g8329 );
			float3 indirectDiffuse203_g8329 = gi203_g8329.indirect.diffuse + diffNorm203_g8329 * 0.0001;
			float3 uvw381_g8329 = (WorldNormalVector( i , float3(0,0,1) ));
			float3 localsampleReflectionProbe381_g8329 = sampleReflectionProbe381_g8329( uvw381_g8329 );
			float luminance377_g8329 = Luminance(indirectDiffuse203_g8329);
			float smoothstepResult378_g8329 = smoothstep( 0.0 , 0.15 , luminance377_g8329);
			float3 lerpResult379_g8329 = lerp( localsampleReflectionProbe381_g8329 , indirectDiffuse203_g8329 , smoothstepResult378_g8329);
			#ifdef UNITY_PASS_FORWARDBASE
				float3 staticSwitch384_g8329 = lerpResult379_g8329;
			#else
				float3 staticSwitch384_g8329 = indirectDiffuse203_g8329;
			#endif
			float MM02G217 = tex2DNode52.g;
			float temp_output_43_0_g8195 = _OcclusionChannel;
			float temp_output_21_0_g8195 = ( temp_output_43_0_g8195 - 1.0 );
			float temp_output_42_0_g8195 = _OcclusionMap;
			float temp_output_6_0_g8195 = ( temp_output_42_0_g8195 - 1.0 );
			float temp_output_9_0_g8195 = ( temp_output_6_0_g8195 - 1.0 );
			float4 temp_cast_339 = (1.0).xxxx;
			float4 ifLocalVar10_g8195 = 0;
			if( saturate( temp_output_42_0_g8195 ) > 0.0 )
				ifLocalVar10_g8195 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8195 ) == 0.0 )
				ifLocalVar10_g8195 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8195 = 0;
			if( saturate( temp_output_6_0_g8195 ) > 0.0 )
				ifLocalVar14_g8195 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8195 ) == 0.0 )
				ifLocalVar14_g8195 = ifLocalVar10_g8195;
			float4 ifLocalVar17_g8195 = 0;
			if( saturate( temp_output_9_0_g8195 ) > 0.0 )
				ifLocalVar17_g8195 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8195 ) == 0.0 )
				ifLocalVar17_g8195 = ifLocalVar14_g8195;
			float4 ifLocalVar19_g8195 = 0;
			if( saturate( ( temp_output_9_0_g8195 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8195 = temp_cast_339;
			else if( saturate( ( temp_output_9_0_g8195 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8195 = ifLocalVar17_g8195;
			float ifLocalVar28_g8195 = 0;
			if( saturate( temp_output_43_0_g8195 ) > 0.0 )
				ifLocalVar28_g8195 = (ifLocalVar19_g8195).g;
			else if( saturate( temp_output_43_0_g8195 ) == 0.0 )
				ifLocalVar28_g8195 = (ifLocalVar19_g8195).r;
			float ifLocalVar32_g8195 = 0;
			if( saturate( temp_output_21_0_g8195 ) > 0.0 )
				ifLocalVar32_g8195 = (ifLocalVar19_g8195).b;
			else if( saturate( temp_output_21_0_g8195 ) == 0.0 )
				ifLocalVar32_g8195 = ifLocalVar28_g8195;
			float ifLocalVar33_g8195 = 0;
			if( saturate( ( temp_output_21_0_g8195 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8195 = (ifLocalVar19_g8195).a;
			else if( saturate( ( temp_output_21_0_g8195 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8195 = ifLocalVar32_g8195;
			float temp_output_392_0_g8013 = ifLocalVar33_g8195;
			float OcclusionChannel257 = temp_output_392_0_g8013;
			float temp_output_249_0 = ( Workflow212 - 1.0 );
			float lerpResult254 = lerp( MM02G217 , OcclusionChannel257 , saturate( temp_output_249_0 ));
			float MM01G216 = tex2DNode9.g;
			float lerpResult1723 = lerp( lerpResult254 , MM01G216 , saturate( ( temp_output_249_0 - 1.0 ) ));
			float Occlusion246 = pow( lerpResult1723 , max( _OcclusionPower , 0.0001 ) );
			float occlusion306_g8329 = Occlusion246;
			float3 temp_output_206_0_g8329 = ( Albedo43.rgb * ( ( Diffuseterm281_g8329 * lightAtten296_g8329 ) + ( staticSwitch384_g8329 * occlusion306_g8329 ) ) );
			float3 AlbedoFinal190 = temp_output_206_0_g8329;
			float temp_output_43_0_g8197 = _ReflectionMaskChannel;
			float temp_output_21_0_g8197 = ( temp_output_43_0_g8197 - 1.0 );
			float temp_output_42_0_g8197 = _ReflectionMask;
			float temp_output_6_0_g8197 = ( temp_output_42_0_g8197 - 1.0 );
			float temp_output_9_0_g8197 = ( temp_output_6_0_g8197 - 1.0 );
			float4 temp_cast_345 = (1.0).xxxx;
			float4 ifLocalVar10_g8197 = 0;
			if( saturate( temp_output_42_0_g8197 ) > 0.0 )
				ifLocalVar10_g8197 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8197 ) == 0.0 )
				ifLocalVar10_g8197 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8197 = 0;
			if( saturate( temp_output_6_0_g8197 ) > 0.0 )
				ifLocalVar14_g8197 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8197 ) == 0.0 )
				ifLocalVar14_g8197 = ifLocalVar10_g8197;
			float4 ifLocalVar17_g8197 = 0;
			if( saturate( temp_output_9_0_g8197 ) > 0.0 )
				ifLocalVar17_g8197 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8197 ) == 0.0 )
				ifLocalVar17_g8197 = ifLocalVar14_g8197;
			float4 ifLocalVar19_g8197 = 0;
			if( saturate( ( temp_output_9_0_g8197 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8197 = temp_cast_345;
			else if( saturate( ( temp_output_9_0_g8197 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8197 = ifLocalVar17_g8197;
			float ifLocalVar28_g8197 = 0;
			if( saturate( temp_output_43_0_g8197 ) > 0.0 )
				ifLocalVar28_g8197 = (ifLocalVar19_g8197).g;
			else if( saturate( temp_output_43_0_g8197 ) == 0.0 )
				ifLocalVar28_g8197 = (ifLocalVar19_g8197).r;
			float ifLocalVar32_g8197 = 0;
			if( saturate( temp_output_21_0_g8197 ) > 0.0 )
				ifLocalVar32_g8197 = (ifLocalVar19_g8197).b;
			else if( saturate( temp_output_21_0_g8197 ) == 0.0 )
				ifLocalVar32_g8197 = ifLocalVar28_g8197;
			float ifLocalVar33_g8197 = 0;
			if( saturate( ( temp_output_21_0_g8197 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8197 = (ifLocalVar19_g8197).a;
			else if( saturate( ( temp_output_21_0_g8197 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8197 = ifLocalVar32_g8197;
			float temp_output_402_0_g8013 = ifLocalVar33_g8197;
			float ReflectionMaskChannel279 = temp_output_402_0_g8013;
			float ReflectionMask277 = ReflectionMaskChannel279;
			float RefperceprualRoughness370_g8329 = ( 1.0 - temp_output_147_0_g8329 );
			half RefRoughness367_g8329 = max( ( RefperceprualRoughness370_g8329 * RefperceprualRoughness370_g8329 ) , 0.002 );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch183_g8329 = ( 1.0 - ( 0.28 * RefRoughness367_g8329 * RefperceprualRoughness370_g8329 ) );
			#else
				float staticSwitch183_g8329 = ( 1.0 / ( ( RefRoughness367_g8329 * RefRoughness367_g8329 ) + 1.0 ) );
			#endif
			half SurfaceReduction182_g8329 = staticSwitch183_g8329;
			float RefSmoothness376_g8329 = temp_output_147_0_g8329;
			half metallic176_g8329 = 0.0;
			half localOneMinusReflectivity176_g8329 = OneMinusReflectivity( metallic176_g8329 );
			half GrazingTerm163_g8329 = saturate( ( RefSmoothness376_g8329 + ( 1.0 - localOneMinusReflectivity176_g8329 ) ) );
			float3 temp_cast_350 = (GrazingTerm163_g8329).xxx;
			float3 break1585 = InitialNormal1580;
			float switchResult1587 = (((i.ASEIsFrontFacing>0)?(break1585.z):(-break1585.z)));
			float3 appendResult1588 = (float3(break1585.x , break1585.y , switchResult1587));
			float3 lerpResult1427 = lerp( appendResult1588 , FleckNorm1443 , _AffectIndirect);
			float3 temp_output_359_0_g8329 = lerpResult1427;
			float3 IndirectNorm360_g8329 = temp_output_359_0_g8329;
			float dotResult362_g8329 = dot( viewDir15_g8329 , (WorldNormalVector( i , IndirectNorm360_g8329 )) );
			float IndirectNdotV364_g8329 = saturate( dotResult362_g8329 );
			float temp_output_258_0_g8329 = pow( ( 1.0 - IndirectNdotV364_g8329 ) , 5.0 );
			float3 lerpResult159_g8329 = lerp( SpecColor140_g8329 , temp_cast_350 , temp_output_258_0_g8329);
			half3 FresnelLerp165_g8329 = lerpResult159_g8329;
			float3 indirectNormal299_g8329 = normalize( WorldNormalVector( i , temp_output_359_0_g8329 ) );
			Unity_GlossyEnvironmentData g299_g8329 = UnityGlossyEnvironmentSetup( smoothness169_g8329, data.worldViewDir, indirectNormal299_g8329, float3(0,0,0));
			float3 indirectSpecular299_g8329 = UnityGI_IndirectSpecular( data, occlusion306_g8329, indirectNormal299_g8329, g299_g8329 );
			#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch305_g8329 = float3( 0,0,0 );
			#else
				float3 staticSwitch305_g8329 = ( ReflectionMask277 * SurfaceReduction182_g8329 * FresnelLerp165_g8329 * indirectSpecular299_g8329 );
			#endif
			float lerpResult352_g8329 = lerp( 0.0 , GrazingTerm163_g8329 , temp_output_258_0_g8329);
			float FresnelLerpA355_g8329 = lerpResult352_g8329;
			float temp_output_1864_358 = ( FresnelLerpA355_g8329 * SurfaceReduction182_g8329 * ReflectionMask277 );
			float4 appendResult1343 = (float4(staticSwitch305_g8329 , temp_output_1864_358));
			float4 IndirectSpec192 = appendResult1343;
			float RefSmoothness376_g8331 = _ClearCoatReflection;
			half metallic176_g8331 = 0.0;
			half localOneMinusReflectivity176_g8331 = OneMinusReflectivity( metallic176_g8331 );
			half GrazingTerm163_g8331 = saturate( ( RefSmoothness376_g8331 + ( 1.0 - localOneMinusReflectivity176_g8331 ) ) );
			float3 temp_cast_351 = (GrazingTerm163_g8331).xxx;
			float3 normal198_g8331 = temp_output_30_0_g8331;
			float3 temp_output_359_0_g8331 = normal198_g8331;
			float3 IndirectNorm360_g8331 = temp_output_359_0_g8331;
			float dotResult362_g8331 = dot( viewDir15_g8331 , (WorldNormalVector( i , IndirectNorm360_g8331 )) );
			float IndirectNdotV364_g8331 = saturate( dotResult362_g8331 );
			float temp_output_258_0_g8331 = pow( ( 1.0 - IndirectNdotV364_g8331 ) , 5.0 );
			float3 lerpResult159_g8331 = lerp( SpecColor140_g8331 , temp_cast_351 , temp_output_258_0_g8331);
			half3 FresnelLerp165_g8331 = lerpResult159_g8331;
			float RefperceprualRoughness370_g8331 = ( 1.0 - _ClearCoatReflection );
			half RefRoughness367_g8331 = max( ( RefperceprualRoughness370_g8331 * RefperceprualRoughness370_g8331 ) , 0.002 );
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch183_g8331 = ( 1.0 - ( 0.28 * RefRoughness367_g8331 * RefperceprualRoughness370_g8331 ) );
			#else
				float staticSwitch183_g8331 = ( 1.0 / ( ( RefRoughness367_g8331 * RefRoughness367_g8331 ) + 1.0 ) );
			#endif
			half SurfaceReduction182_g8331 = staticSwitch183_g8331;
			float lerpResult352_g8331 = lerp( 0.0 , GrazingTerm163_g8331 , temp_output_258_0_g8331);
			float FresnelLerpA355_g8331 = lerpResult352_g8331;
			float4 appendResult1340 = (float4(( FresnelLerp165_g8331 * SurfaceReduction182_g8331 * ReflectionMask277 ) , ( FresnelLerpA355_g8331 * SurfaceReduction182_g8331 * ReflectionMask277 )));
			float4 CustomIndirect180 = appendResult1340;
			float3 indirectNormal495 = normalize( WorldNormalVector( i , appendResult1129 ) );
			float temp_output_59_0_g8210 = saturate( ( Workflow346_g8013 - 2.0 ) );
			float lerpResult60_g8210 = lerp( _InvertReflectionGloss , 1.0 , temp_output_59_0_g8210);
			float temp_output_43_0_g8210 = _ClearCoatReflectionChannel;
			float temp_output_21_0_g8210 = ( temp_output_43_0_g8210 - 1.0 );
			float temp_output_42_0_g8210 = _ClearCoatReflectionMap;
			float temp_output_6_0_g8210 = ( temp_output_42_0_g8210 - 1.0 );
			float temp_output_9_0_g8210 = ( temp_output_6_0_g8210 - 1.0 );
			float4 temp_cast_352 = (1.0).xxxx;
			float4 temp_output_45_0_g8210 = MM02RGBA175_g8013;
			float4 ifLocalVar10_g8210 = 0;
			if( saturate( temp_output_42_0_g8210 ) > 0.0 )
				ifLocalVar10_g8210 = temp_output_45_0_g8210;
			else if( saturate( temp_output_42_0_g8210 ) == 0.0 )
				ifLocalVar10_g8210 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8210 = 0;
			if( saturate( temp_output_6_0_g8210 ) > 0.0 )
				ifLocalVar14_g8210 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8210 ) == 0.0 )
				ifLocalVar14_g8210 = ifLocalVar10_g8210;
			float4 ifLocalVar17_g8210 = 0;
			if( saturate( temp_output_9_0_g8210 ) > 0.0 )
				ifLocalVar17_g8210 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8210 ) == 0.0 )
				ifLocalVar17_g8210 = ifLocalVar14_g8210;
			float4 ifLocalVar19_g8210 = 0;
			if( saturate( ( temp_output_9_0_g8210 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8210 = temp_cast_352;
			else if( saturate( ( temp_output_9_0_g8210 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8210 = ifLocalVar17_g8210;
			float ifLocalVar28_g8210 = 0;
			if( saturate( temp_output_43_0_g8210 ) > 0.0 )
				ifLocalVar28_g8210 = (ifLocalVar19_g8210).g;
			else if( saturate( temp_output_43_0_g8210 ) == 0.0 )
				ifLocalVar28_g8210 = (ifLocalVar19_g8210).r;
			float ifLocalVar32_g8210 = 0;
			if( saturate( temp_output_21_0_g8210 ) > 0.0 )
				ifLocalVar32_g8210 = (ifLocalVar19_g8210).b;
			else if( saturate( temp_output_21_0_g8210 ) == 0.0 )
				ifLocalVar32_g8210 = ifLocalVar28_g8210;
			float ifLocalVar33_g8210 = 0;
			if( saturate( ( temp_output_21_0_g8210 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8210 = (ifLocalVar19_g8210).a;
			else if( saturate( ( temp_output_21_0_g8210 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8210 = ifLocalVar32_g8210;
			float ifLocalVar72_g8210 = 0;
			if( temp_output_59_0_g8210 > 0.0 )
				ifLocalVar72_g8210 = (temp_output_45_0_g8210).g;
			else if( temp_output_59_0_g8210 == 0.0 )
				ifLocalVar72_g8210 = ifLocalVar33_g8210;
			float ifLocalVar53_g8210 = 0;
			if( lerpResult60_g8210 > 0.0 )
				ifLocalVar53_g8210 = ( 1.0 - ifLocalVar33_g8210 );
			else if( lerpResult60_g8210 == 0.0 )
				ifLocalVar53_g8210 = ifLocalVar72_g8210;
			float temp_output_511_0_g8013 = ( 1.0 - max( ( 1.0 - ifLocalVar53_g8210 ) , SpecAntiAlias345_g8013 ) );
			float ClearCoatReflectionChannel1202 = temp_output_511_0_g8013;
			Unity_GlossyEnvironmentData g495 = UnityGlossyEnvironmentSetup( ( ClearCoatReflectionChannel1202 * _ClearCoatReflection ), data.worldViewDir, indirectNormal495, float3(0,0,0));
			float3 indirectSpecular495 = UnityGI_IndirectSpecular( data, Occlusion246, indirectNormal495, g495 );
			float4 appendResult1341 = (float4(indirectSpecular495 , 0.0));
			float4 IndirectClearCoat549 = ( ( IndirectSpec192 * 0.5 ) + ( 0.5 * ( CustomIndirect180 * appendResult1341 ) ) );
			float4 lerpResult509 = lerp( IndirectSpec192 , IndirectClearCoat549 , ClearCoatChannel493);
			#ifdef _CLEARCOAT_ON
				float4 staticSwitch503 = lerpResult509;
			#else
				float4 staticSwitch503 = IndirectSpec192;
			#endif
			#ifdef UNITY_PASS_FORWARDADD
				float4 staticSwitch73 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch73 = staticSwitch503;
			#endif
			float4 IndirectSpecFinal195 = staticSwitch73;
			c.rgb = ( SpecularFinal188 + float4( AlbedoFinal190 , 0.0 ) + IndirectSpecFinal195 ).xyz;
			c.a = 1;
			clip( temp_output_1831_0 - _MaskClipValue );
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
			float4 temp_cast_0 = (1.0).xxxx;
			float3 temp_cast_2 = (1.0).xxx;
			int EmissionGlowZone47_g8246 = _RedChGlowZone;
			int clampResult8_g8252 = clamp( EmissionGlowZone47_g8246 , 1 , 4 );
			int temp_output_3_0_g8252 = ( clampResult8_g8252 - 1 );
			int Zone16_g8252 = temp_output_3_0_g8252;
			float3 localgetThemeData16_g8252 = getThemeData( Zone16_g8252 );
			int Band11_g8253 = 56;
			int localIsLumaActive11_g8253 = IsLumaActive11_g8253( Band11_g8253 );
			int temp_output_14_0_g8252 = localIsLumaActive11_g8253;
			int lerpResult15_g8252 = lerp( temp_output_3_0_g8252 , ( 63 - temp_output_3_0_g8252 ) , (float)temp_output_14_0_g8252);
			int Band2_g8252 = lerpResult15_g8252;
			int Delay2_g8252 = 0;
			float3 localLumaGlowData2_g8252 = LumaGlowData2_g8252( Band2_g8252 , Delay2_g8252 );
			float3 lerpResult17_g8252 = lerp( ( localgetThemeData16_g8252 * localLumaGlowData2_g8252 ) , localLumaGlowData2_g8252 , (float)temp_output_14_0_g8252);
			int temp_output_21_0_g8246 = saturate( EmissionGlowZone47_g8246 );
			float3 lerpResult20_g8246 = lerp( temp_cast_2 , lerpResult17_g8252 , (float)temp_output_21_0_g8246);
			float3 temp_cast_6 = (1.0).xxx;
			int clampResult8_g8254 = clamp( EmissionGlowZone47_g8246 , 1 , 4 );
			int temp_output_3_0_g8254 = ( clampResult8_g8254 - 1 );
			int Zone15_g8254 = temp_output_3_0_g8254;
			float3 localgetThemeData15_g8254 = getThemeData( Zone15_g8254 );
			int Band11_g8255 = 56;
			int localIsLumaActive11_g8255 = IsLumaActive11_g8255( Band11_g8255 );
			int temp_output_13_0_g8254 = localIsLumaActive11_g8255;
			int lerpResult14_g8254 = lerp( temp_output_3_0_g8254 , ( 63 - temp_output_3_0_g8254 ) , (float)temp_output_13_0_g8254);
			int Band11_g8254 = lerpResult14_g8254;
			float cos6_g8246 = cos( radians( _RedChGlowPulseDir ) );
			float sin6_g8246 = sin( radians( _RedChGlowPulseDir ) );
			float2 rotator6_g8246 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g8246 , -sin6_g8246 , sin6_g8246 , cos6_g8246 )) + float2( 0.5,0.5 );
			float localGetLocalTime2_g8260 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			int Band6_g8259 = _RedChGlowAnimationBand;
			int Mode6_g8259 = ( ( _RedChGlowAnimationMode * 2 ) + _RedChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g8259 = AudioLinkDecodeDataAsUInt6_g8259( Band6_g8259 , Mode6_g8259 );
			float ifLocalVar294_g8246 = 0;
			if( saturate( ( _RedChGlowAnimationMode - 3 ) ) > 0.0 )
				ifLocalVar294_g8246 = localGetLocalTime2_g8260;
			else if( saturate( ( _RedChGlowAnimationMode - 3 ) ) == 0.0 )
				ifLocalVar294_g8246 = ( ( localAudioLinkDecodeDataAsUInt6_g8259 % 628319 ) / 100000.0 );
			float EmissionGlowAnimation195_g8246 = ( _RedChGlowAnimationStrength * ifLocalVar294_g8246 * step( _RedChGlowAnimationBand , 9 ) );
			float x13_g8246 = ( ( rotator6_g8246.x * _RedChGlowPulseScale ) + _RedChGlowPulseOffset + EmissionGlowAnimation195_g8246 );
			float y13_g8246 = 127.0;
			float localglslmod13_g8246 = glslmod13_g8246( x13_g8246 , y13_g8246 );
			float2 temp_output_34_0_g8248 = ( i.uv_texcoord - _RedChGlowRadialCenter );
			float2 break39_g8248 = temp_output_34_0_g8248;
			float2 appendResult50_g8248 = (float2(( _RedChGlowPulseScale * ( length( temp_output_34_0_g8248 ) * 2.0 ) ) , ( ( atan2( break39_g8248.x , break39_g8248.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x12_g8246 = ( _RedChGlowPulseOffset + appendResult50_g8248.x + EmissionGlowAnimation195_g8246 );
			float y12_g8246 = 127.0;
			float localglslmod12_g8246 = glslmod12_g8246( x12_g8246 , y12_g8246 );
			int EmissionGlowMode35_g8246 = _RedChGlowMode;
			int temp_output_37_0_g8246 = ( EmissionGlowMode35_g8246 - 1 );
			float lerpResult5_g8246 = lerp( localglslmod13_g8246 , localglslmod12_g8246 , (float)saturate( temp_output_37_0_g8246 ));
			float Direction27_g8228 = tex2D( _DirectionalMap, i.vertexToFrag51_g8229 ).r;
			float DirectionalMap106_g8246 = Direction27_g8228;
			float lerpResult179_g8246 = lerp( DirectionalMap106_g8246 , ( 1.0 - DirectionalMap106_g8246 ) , (float)saturate( ( EmissionGlowMode35_g8246 - 3 ) ));
			float x34_g8246 = ( _RedChGlowPulseOffset + ( _RedChGlowPulseScale * lerpResult179_g8246 ) + EmissionGlowAnimation195_g8246 );
			float y34_g8246 = 127.0;
			float localglslmod34_g8246 = glslmod34_g8246( x34_g8246 , y34_g8246 );
			float lerpResult30_g8246 = lerp( lerpResult5_g8246 , localglslmod34_g8246 , (float)saturate( ( temp_output_37_0_g8246 - 1 ) ));
			float EmissionGlowDelay56_g8246 = lerpResult30_g8246;
			float Delay11_g8254 = EmissionGlowDelay56_g8246;
			float3 localLumaGlowLerp11_g8254 = LumaGlowLerp11_g8254( Band11_g8254 , Delay11_g8254 );
			float3 lerpResult17_g8254 = lerp( ( localgetThemeData15_g8254 * localLumaGlowLerp11_g8254 ) , localLumaGlowLerp11_g8254 , (float)temp_output_13_0_g8254);
			float3 lerpResult22_g8246 = lerp( temp_cast_6 , lerpResult17_g8254 , (float)temp_output_21_0_g8246);
			float3 lerpResult23_g8246 = lerp( lerpResult20_g8246 , lerpResult22_g8246 , (float)saturate( EmissionGlowMode35_g8246 ));
			float4 temp_cast_15 = (1.0).xxxx;
			float temp_output_10_0_g8256 = EmissionGlowDelay56_g8246;
			float Position1_g8258 = ( temp_output_10_0_g8256 / 127.0 );
			float4 localAudioLinkLerp1_g8258 = AudioLinkLerp1_g8258( Position1_g8258 );
			int clampResult8_g8256 = clamp( ( EmissionGlowZone47_g8246 - 4 ) , 1 , 3 );
			int Band11_g8256 = ( 59 - ( clampResult8_g8256 - 1 ) );
			float Delay11_g8256 = temp_output_10_0_g8256;
			float3 localLumaGlowLerp11_g8256 = LumaGlowLerp11_g8256( Band11_g8256 , Delay11_g8256 );
			int Band11_g8257 = 56;
			int localIsLumaActive11_g8257 = IsLumaActive11_g8257( Band11_g8257 );
			float4 lerpResult14_g8256 = lerp( localAudioLinkLerp1_g8258 , float4( localLumaGlowLerp11_g8256 , 0.0 ) , (float)localIsLumaActive11_g8257);
			float4 lerpResult52_g8246 = lerp( temp_cast_15 , lerpResult14_g8256 , (float)saturate( EmissionGlowZone47_g8246 ));
			float4 lerpResult51_g8246 = lerp( float4( lerpResult23_g8246 , 0.0 ) , lerpResult52_g8246 , (float)saturate( ( EmissionGlowZone47_g8246 - 4 ) ));
			float4 temp_cast_20 = (_RedChGlowMinBrightness).xxxx;
			float4 temp_cast_21 = (( _RedChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_254_0_g8246 = saturate( EmissionGlowZone47_g8246 );
			int localIfAudioLinkv2Exists1_g8262 = IfAudioLinkv2Exists1_g8262();
			float4 lerpResult284_g8246 = lerp( _RedChGlowFallback , ( (temp_cast_20 + (lerpResult51_g8246 - float4( 0,0,0,0 )) * (temp_cast_21 - temp_cast_20) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _RedChGlowTint * temp_output_254_0_g8246 ) , (float)localIfAudioLinkv2Exists1_g8262);
			float4 EmissionGlow142_g8246 = lerpResult284_g8246;
			float4 lerpResult257_g8246 = lerp( temp_cast_0 , EmissionGlow142_g8246 , (float)temp_output_254_0_g8246);
			float4 EmissionGlowTog258_g8246 = lerpResult257_g8246;
			int EmissionReactiveBand243_g8246 = _RedChReactiveBand;
			int Band3_g8247 = EmissionReactiveBand243_g8246;
			int Delay3_g8247 = 0;
			float localAudioLinkData3_g8247 = AudioLinkData3_g8247( Band3_g8247 , Delay3_g8247 );
			int temp_output_64_0_g8246 = step( _RedChReactiveBand , 9 );
			float lerpResult66_g8246 = lerp( 1.0 , localAudioLinkData3_g8247 , (float)temp_output_64_0_g8246);
			int Band3_g8249 = _RedChReactiveBand;
			float cos78_g8246 = cos( radians( _RedChReactivePulseDir ) );
			float sin78_g8246 = sin( radians( _RedChReactivePulseDir ) );
			float2 rotator78_g8246 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g8246 , -sin78_g8246 , sin78_g8246 , cos78_g8246 )) + float2( 0.5,0.5 );
			float x96_g8246 = ( ( rotator78_g8246.x * _RedChReactivePulseScale ) + _RedChReactivePulseOffset );
			float y96_g8246 = 127.0;
			float localglslmod96_g8246 = glslmod96_g8246( x96_g8246 , y96_g8246 );
			float2 temp_output_34_0_g8250 = ( i.uv_texcoord - _RedChReactiveRadialCenter );
			float2 break39_g8250 = temp_output_34_0_g8250;
			float2 appendResult50_g8250 = (float2(( _RedChReactivePulseScale * ( length( temp_output_34_0_g8250 ) * 2.0 ) ) , ( ( atan2( break39_g8250.x , break39_g8250.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x97_g8246 = ( _RedChReactivePulseOffset + appendResult50_g8250.x );
			float y97_g8246 = 127.0;
			float localglslmod97_g8246 = glslmod97_g8246( x97_g8246 , y97_g8246 );
			int EmissionReactiveMode99_g8246 = _RedChReactiveMode;
			int temp_output_90_0_g8246 = ( EmissionReactiveMode99_g8246 - 1 );
			float lerpResult77_g8246 = lerp( localglslmod96_g8246 , localglslmod97_g8246 , (float)saturate( temp_output_90_0_g8246 ));
			float lerpResult174_g8246 = lerp( DirectionalMap106_g8246 , ( 1.0 - DirectionalMap106_g8246 ) , (float)saturate( ( EmissionReactiveMode99_g8246 - 3 ) ));
			float x98_g8246 = ( _RedChReactivePulseOffset + ( _RedChReactivePulseScale * lerpResult174_g8246 ) );
			float y98_g8246 = 127.0;
			float localglslmod98_g8246 = glslmod98_g8246( x98_g8246 , y98_g8246 );
			float lerpResult87_g8246 = lerp( lerpResult77_g8246 , localglslmod98_g8246 , (float)saturate( ( temp_output_90_0_g8246 - 1 ) ));
			float Delay3_g8249 = lerpResult87_g8246;
			float localAudioLinkLerp3_g8249 = AudioLinkLerp3_g8249( Band3_g8249 , Delay3_g8249 );
			float lerpResult102_g8246 = lerp( 1.0 , localAudioLinkLerp3_g8249 , (float)temp_output_64_0_g8246);
			float lerpResult103_g8246 = lerp( lerpResult66_g8246 , lerpResult102_g8246 , (float)saturate( EmissionReactiveMode99_g8246 ));
			int Band3_g8251 = _RedChReactiveBand;
			float FilteredAmount3_g8251 = ( ( 1.0 - _RedChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g8251 = AudioLinkLerp3_g8251( Band3_g8251 , FilteredAmount3_g8251 );
			float lerpResult168_g8246 = lerp( 1.0 , localAudioLinkLerp3_g8251 , (float)temp_output_64_0_g8246);
			float lerpResult172_g8246 = lerp( lerpResult103_g8246 , lerpResult168_g8246 , (float)saturate( ( EmissionReactiveMode99_g8246 - 4 ) ));
			float ReactivityAlpha132_g8246 = (_RedChReactiveMinBrightness + (lerpResult172_g8246 - 0.0) * (( _RedChReactiveMinBrightness + 1.0 ) - _RedChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_33 = (1.0).xxxx;
			float4 lerpResult253_g8246 = lerp( temp_cast_33 , _RedChReactiveTint , (float)step( EmissionReactiveBand243_g8246 , 9 ));
			float4 FinalReactivity68_g8246 = ( ReactivityAlpha132_g8246 * lerpResult253_g8246 );
			float4 lerpResult146_g8246 = lerp( ( EmissionGlowTog258_g8246 * FinalReactivity68_g8246 ) , ( EmissionGlow142_g8246 + FinalReactivity68_g8246 ) , (float)saturate( _RedChReactiveBlendMode ));
			float4 ReversedReactivity152_g8246 = ( ( 1.0 - ReactivityAlpha132_g8246 ) * lerpResult253_g8246 );
			int temp_output_157_0_g8246 = ( _RedChReactiveBlendMode - 1 );
			float4 lerpResult114_g8246 = lerp( lerpResult146_g8246 , ( EmissionGlowTog258_g8246 * ReversedReactivity152_g8246 ) , (float)saturate( temp_output_157_0_g8246 ));
			float4 lerpResult164_g8246 = lerp( lerpResult114_g8246 , ( EmissionGlow142_g8246 + ( ReversedReactivity152_g8246 * step( EmissionReactiveBand243_g8246 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g8246 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g8246 , 9 ) ) ));
			float temp_output_43_0_g8206 = _GlowMask0Channel;
			float temp_output_21_0_g8206 = ( temp_output_43_0_g8206 - 1.0 );
			float temp_output_42_0_g8206 = _GlowMask0;
			float temp_output_6_0_g8206 = ( temp_output_42_0_g8206 - 1.0 );
			float temp_output_9_0_g8206 = ( temp_output_6_0_g8206 - 1.0 );
			float4 temp_cast_42 = (1.0).xxxx;
			float4 tex2DNode414 = tex2D( _MaskMap04, i.vertexToFrag51_g5489 );
			float4 MM04RGBA420 = tex2DNode414;
			float4 MM04RGBA178_g8013 = MM04RGBA420;
			float4 tex2DNode406 = tex2D( _MaskMap03, i.vertexToFrag51_g5488 );
			float4 MM03RGBA412 = tex2DNode406;
			float4 MM03RGBA177_g8013 = MM03RGBA412;
			float4 tex2DNode52 = tex2D( _MaskMap02, i.vertexToFrag51_g5487 );
			float4 MM02RGBA296 = tex2DNode52;
			float4 MM02RGBA175_g8013 = MM02RGBA296;
			float4 tex2DNode9 = tex2D( _MaskMap01, i.vertexToFrag51_g5486 );
			float4 MM01RGBA295 = tex2DNode9;
			float4 MM01RGBA176_g8013 = MM01RGBA295;
			float4 ifLocalVar10_g8206 = 0;
			if( saturate( temp_output_42_0_g8206 ) > 0.0 )
				ifLocalVar10_g8206 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8206 ) == 0.0 )
				ifLocalVar10_g8206 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8206 = 0;
			if( saturate( temp_output_6_0_g8206 ) > 0.0 )
				ifLocalVar14_g8206 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8206 ) == 0.0 )
				ifLocalVar14_g8206 = ifLocalVar10_g8206;
			float4 ifLocalVar17_g8206 = 0;
			if( saturate( temp_output_9_0_g8206 ) > 0.0 )
				ifLocalVar17_g8206 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8206 ) == 0.0 )
				ifLocalVar17_g8206 = ifLocalVar14_g8206;
			float4 ifLocalVar19_g8206 = 0;
			if( saturate( ( temp_output_9_0_g8206 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8206 = temp_cast_42;
			else if( saturate( ( temp_output_9_0_g8206 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8206 = ifLocalVar17_g8206;
			float ifLocalVar28_g8206 = 0;
			if( saturate( temp_output_43_0_g8206 ) > 0.0 )
				ifLocalVar28_g8206 = (ifLocalVar19_g8206).g;
			else if( saturate( temp_output_43_0_g8206 ) == 0.0 )
				ifLocalVar28_g8206 = (ifLocalVar19_g8206).r;
			float ifLocalVar32_g8206 = 0;
			if( saturate( temp_output_21_0_g8206 ) > 0.0 )
				ifLocalVar32_g8206 = (ifLocalVar19_g8206).b;
			else if( saturate( temp_output_21_0_g8206 ) == 0.0 )
				ifLocalVar32_g8206 = ifLocalVar28_g8206;
			float ifLocalVar33_g8206 = 0;
			if( saturate( ( temp_output_21_0_g8206 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8206 = (ifLocalVar19_g8206).a;
			else if( saturate( ( temp_output_21_0_g8206 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8206 = ifLocalVar32_g8206;
			float temp_output_496_0_g8013 = ifLocalVar33_g8206;
			float GlowMask0Channel1009 = temp_output_496_0_g8013;
			float temp_output_43_0_g8208 = _GlowMask1Channel;
			float temp_output_21_0_g8208 = ( temp_output_43_0_g8208 - 1.0 );
			float temp_output_42_0_g8208 = _GlowMask1;
			float temp_output_6_0_g8208 = ( temp_output_42_0_g8208 - 1.0 );
			float temp_output_9_0_g8208 = ( temp_output_6_0_g8208 - 1.0 );
			float4 temp_cast_51 = (1.0).xxxx;
			float4 ifLocalVar10_g8208 = 0;
			if( saturate( temp_output_42_0_g8208 ) > 0.0 )
				ifLocalVar10_g8208 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8208 ) == 0.0 )
				ifLocalVar10_g8208 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8208 = 0;
			if( saturate( temp_output_6_0_g8208 ) > 0.0 )
				ifLocalVar14_g8208 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8208 ) == 0.0 )
				ifLocalVar14_g8208 = ifLocalVar10_g8208;
			float4 ifLocalVar17_g8208 = 0;
			if( saturate( temp_output_9_0_g8208 ) > 0.0 )
				ifLocalVar17_g8208 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8208 ) == 0.0 )
				ifLocalVar17_g8208 = ifLocalVar14_g8208;
			float4 ifLocalVar19_g8208 = 0;
			if( saturate( ( temp_output_9_0_g8208 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8208 = temp_cast_51;
			else if( saturate( ( temp_output_9_0_g8208 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8208 = ifLocalVar17_g8208;
			float ifLocalVar28_g8208 = 0;
			if( saturate( temp_output_43_0_g8208 ) > 0.0 )
				ifLocalVar28_g8208 = (ifLocalVar19_g8208).g;
			else if( saturate( temp_output_43_0_g8208 ) == 0.0 )
				ifLocalVar28_g8208 = (ifLocalVar19_g8208).r;
			float ifLocalVar32_g8208 = 0;
			if( saturate( temp_output_21_0_g8208 ) > 0.0 )
				ifLocalVar32_g8208 = (ifLocalVar19_g8208).b;
			else if( saturate( temp_output_21_0_g8208 ) == 0.0 )
				ifLocalVar32_g8208 = ifLocalVar28_g8208;
			float ifLocalVar33_g8208 = 0;
			if( saturate( ( temp_output_21_0_g8208 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8208 = (ifLocalVar19_g8208).a;
			else if( saturate( ( temp_output_21_0_g8208 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8208 = ifLocalVar32_g8208;
			float temp_output_498_0_g8013 = ifLocalVar33_g8208;
			float GlowMask1Channel1042 = temp_output_498_0_g8013;
			float temp_output_43_0_g8207 = _GlowMask2Channel;
			float temp_output_21_0_g8207 = ( temp_output_43_0_g8207 - 1.0 );
			float temp_output_42_0_g8207 = _GlowMask2;
			float temp_output_6_0_g8207 = ( temp_output_42_0_g8207 - 1.0 );
			float temp_output_9_0_g8207 = ( temp_output_6_0_g8207 - 1.0 );
			float4 temp_cast_56 = (1.0).xxxx;
			float4 ifLocalVar10_g8207 = 0;
			if( saturate( temp_output_42_0_g8207 ) > 0.0 )
				ifLocalVar10_g8207 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8207 ) == 0.0 )
				ifLocalVar10_g8207 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8207 = 0;
			if( saturate( temp_output_6_0_g8207 ) > 0.0 )
				ifLocalVar14_g8207 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8207 ) == 0.0 )
				ifLocalVar14_g8207 = ifLocalVar10_g8207;
			float4 ifLocalVar17_g8207 = 0;
			if( saturate( temp_output_9_0_g8207 ) > 0.0 )
				ifLocalVar17_g8207 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8207 ) == 0.0 )
				ifLocalVar17_g8207 = ifLocalVar14_g8207;
			float4 ifLocalVar19_g8207 = 0;
			if( saturate( ( temp_output_9_0_g8207 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8207 = temp_cast_56;
			else if( saturate( ( temp_output_9_0_g8207 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8207 = ifLocalVar17_g8207;
			float ifLocalVar28_g8207 = 0;
			if( saturate( temp_output_43_0_g8207 ) > 0.0 )
				ifLocalVar28_g8207 = (ifLocalVar19_g8207).g;
			else if( saturate( temp_output_43_0_g8207 ) == 0.0 )
				ifLocalVar28_g8207 = (ifLocalVar19_g8207).r;
			float ifLocalVar32_g8207 = 0;
			if( saturate( temp_output_21_0_g8207 ) > 0.0 )
				ifLocalVar32_g8207 = (ifLocalVar19_g8207).b;
			else if( saturate( temp_output_21_0_g8207 ) == 0.0 )
				ifLocalVar32_g8207 = ifLocalVar28_g8207;
			float ifLocalVar33_g8207 = 0;
			if( saturate( ( temp_output_21_0_g8207 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8207 = (ifLocalVar19_g8207).a;
			else if( saturate( ( temp_output_21_0_g8207 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8207 = ifLocalVar32_g8207;
			float temp_output_497_0_g8013 = ifLocalVar33_g8207;
			float GlowMask2Channel1076 = temp_output_497_0_g8013;
			float temp_output_43_0_g8209 = _GlowMask3Channel;
			float temp_output_21_0_g8209 = ( temp_output_43_0_g8209 - 1.0 );
			float temp_output_42_0_g8209 = _GlowMask3;
			float temp_output_6_0_g8209 = ( temp_output_42_0_g8209 - 1.0 );
			float temp_output_9_0_g8209 = ( temp_output_6_0_g8209 - 1.0 );
			float4 temp_cast_61 = (1.0).xxxx;
			float4 ifLocalVar10_g8209 = 0;
			if( saturate( temp_output_42_0_g8209 ) > 0.0 )
				ifLocalVar10_g8209 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8209 ) == 0.0 )
				ifLocalVar10_g8209 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8209 = 0;
			if( saturate( temp_output_6_0_g8209 ) > 0.0 )
				ifLocalVar14_g8209 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8209 ) == 0.0 )
				ifLocalVar14_g8209 = ifLocalVar10_g8209;
			float4 ifLocalVar17_g8209 = 0;
			if( saturate( temp_output_9_0_g8209 ) > 0.0 )
				ifLocalVar17_g8209 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8209 ) == 0.0 )
				ifLocalVar17_g8209 = ifLocalVar14_g8209;
			float4 ifLocalVar19_g8209 = 0;
			if( saturate( ( temp_output_9_0_g8209 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8209 = temp_cast_61;
			else if( saturate( ( temp_output_9_0_g8209 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8209 = ifLocalVar17_g8209;
			float ifLocalVar28_g8209 = 0;
			if( saturate( temp_output_43_0_g8209 ) > 0.0 )
				ifLocalVar28_g8209 = (ifLocalVar19_g8209).g;
			else if( saturate( temp_output_43_0_g8209 ) == 0.0 )
				ifLocalVar28_g8209 = (ifLocalVar19_g8209).r;
			float ifLocalVar32_g8209 = 0;
			if( saturate( temp_output_21_0_g8209 ) > 0.0 )
				ifLocalVar32_g8209 = (ifLocalVar19_g8209).b;
			else if( saturate( temp_output_21_0_g8209 ) == 0.0 )
				ifLocalVar32_g8209 = ifLocalVar28_g8209;
			float ifLocalVar33_g8209 = 0;
			if( saturate( ( temp_output_21_0_g8209 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8209 = (ifLocalVar19_g8209).a;
			else if( saturate( ( temp_output_21_0_g8209 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8209 = ifLocalVar32_g8209;
			float temp_output_499_0_g8013 = ifLocalVar33_g8209;
			float GlowMask3Channel1110 = temp_output_499_0_g8013;
			float4 appendResult1117 = (float4(GlowMask0Channel1009 , GlowMask1Channel1042 , GlowMask2Channel1076 , GlowMask3Channel1110));
			float4 GlowMaskRGBA174_g8228 = appendResult1117;
			float temp_output_236_0_g8246 = (GlowMaskRGBA174_g8228).x;
			int localIfAudioLinkv2Exists1_g8261 = IfAudioLinkv2Exists1_g8261();
			float4 temp_output_213_0_g8246 = ( lerpResult164_g8246 * temp_output_236_0_g8246 * saturate( ( localIfAudioLinkv2Exists1_g8261 + _UseFallback0 ) ) );
			float4 FallbackColor289_g8246 = _RedChGlowFallback;
			float4 temp_output_291_0_g8246 = ( FallbackColor289_g8246 * _UseFallback0 * temp_output_236_0_g8246 );
			float4 ifLocalVar295_g8246 = 0;
			if( _EnableRedChannel > 0.0 )
				ifLocalVar295_g8246 = temp_output_213_0_g8246;
			else if( _EnableRedChannel == 0.0 )
				ifLocalVar295_g8246 = temp_output_291_0_g8246;
			float4 temp_cast_67 = (1.0).xxxx;
			float3 temp_cast_69 = (1.0).xxx;
			int EmissionGlowZone47_g8263 = _GreenChGlowZone;
			int clampResult8_g8269 = clamp( EmissionGlowZone47_g8263 , 1 , 4 );
			int temp_output_3_0_g8269 = ( clampResult8_g8269 - 1 );
			int Zone16_g8269 = temp_output_3_0_g8269;
			float3 localgetThemeData16_g8269 = getThemeData( Zone16_g8269 );
			int Band11_g8270 = 56;
			int localIsLumaActive11_g8270 = IsLumaActive11_g8270( Band11_g8270 );
			int temp_output_14_0_g8269 = localIsLumaActive11_g8270;
			int lerpResult15_g8269 = lerp( temp_output_3_0_g8269 , ( 63 - temp_output_3_0_g8269 ) , (float)temp_output_14_0_g8269);
			int Band2_g8269 = lerpResult15_g8269;
			int Delay2_g8269 = 0;
			float3 localLumaGlowData2_g8269 = LumaGlowData2_g8269( Band2_g8269 , Delay2_g8269 );
			float3 lerpResult17_g8269 = lerp( ( localgetThemeData16_g8269 * localLumaGlowData2_g8269 ) , localLumaGlowData2_g8269 , (float)temp_output_14_0_g8269);
			int temp_output_21_0_g8263 = saturate( EmissionGlowZone47_g8263 );
			float3 lerpResult20_g8263 = lerp( temp_cast_69 , lerpResult17_g8269 , (float)temp_output_21_0_g8263);
			float3 temp_cast_73 = (1.0).xxx;
			int clampResult8_g8271 = clamp( EmissionGlowZone47_g8263 , 1 , 4 );
			int temp_output_3_0_g8271 = ( clampResult8_g8271 - 1 );
			int Zone15_g8271 = temp_output_3_0_g8271;
			float3 localgetThemeData15_g8271 = getThemeData( Zone15_g8271 );
			int Band11_g8272 = 56;
			int localIsLumaActive11_g8272 = IsLumaActive11_g8272( Band11_g8272 );
			int temp_output_13_0_g8271 = localIsLumaActive11_g8272;
			int lerpResult14_g8271 = lerp( temp_output_3_0_g8271 , ( 63 - temp_output_3_0_g8271 ) , (float)temp_output_13_0_g8271);
			int Band11_g8271 = lerpResult14_g8271;
			float cos6_g8263 = cos( radians( _GreenChGlowPulseDir ) );
			float sin6_g8263 = sin( radians( _GreenChGlowPulseDir ) );
			float2 rotator6_g8263 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g8263 , -sin6_g8263 , sin6_g8263 , cos6_g8263 )) + float2( 0.5,0.5 );
			float localGetLocalTime2_g8277 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			int Band6_g8276 = _GreenChGlowAnimationBand;
			int Mode6_g8276 = ( ( _GreenChGlowAnimationMode * 2 ) + _GreenChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g8276 = AudioLinkDecodeDataAsUInt6_g8276( Band6_g8276 , Mode6_g8276 );
			float ifLocalVar286_g8263 = 0;
			if( saturate( ( _GreenChGlowAnimationMode - 3 ) ) > 0.0 )
				ifLocalVar286_g8263 = localGetLocalTime2_g8277;
			else if( saturate( ( _GreenChGlowAnimationMode - 3 ) ) == 0.0 )
				ifLocalVar286_g8263 = ( ( localAudioLinkDecodeDataAsUInt6_g8276 % 628319 ) / 100000.0 );
			float EmissionGlowAnimation195_g8263 = ( _GreenChGlowAnimationStrength * ifLocalVar286_g8263 * step( _GreenChGlowAnimationBand , 9 ) );
			float x13_g8263 = ( ( rotator6_g8263.x * _GreenChGlowPulseScale ) + _GreenChGlowPulseOffset + EmissionGlowAnimation195_g8263 );
			float y13_g8263 = 127.0;
			float localglslmod13_g8263 = glslmod13_g8263( x13_g8263 , y13_g8263 );
			float2 temp_output_34_0_g8265 = ( i.uv_texcoord - _GreenChGlowRadialCenter );
			float2 break39_g8265 = temp_output_34_0_g8265;
			float2 appendResult50_g8265 = (float2(( _GreenChGlowPulseScale * ( length( temp_output_34_0_g8265 ) * 2.0 ) ) , ( ( atan2( break39_g8265.x , break39_g8265.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x12_g8263 = ( _GreenChGlowPulseOffset + appendResult50_g8265.x + EmissionGlowAnimation195_g8263 );
			float y12_g8263 = 127.0;
			float localglslmod12_g8263 = glslmod12_g8263( x12_g8263 , y12_g8263 );
			int EmissionGlowMode35_g8263 = _GreenChGlowMode;
			int temp_output_37_0_g8263 = ( EmissionGlowMode35_g8263 - 1 );
			float lerpResult5_g8263 = lerp( localglslmod13_g8263 , localglslmod12_g8263 , (float)saturate( temp_output_37_0_g8263 ));
			float DirectionalMap106_g8263 = Direction27_g8228;
			float lerpResult179_g8263 = lerp( DirectionalMap106_g8263 , ( 1.0 - DirectionalMap106_g8263 ) , (float)saturate( ( EmissionGlowMode35_g8263 - 3 ) ));
			float x34_g8263 = ( _GreenChGlowPulseOffset + ( _GreenChGlowPulseScale * lerpResult179_g8263 ) + EmissionGlowAnimation195_g8263 );
			float y34_g8263 = 127.0;
			float localglslmod34_g8263 = glslmod34_g8263( x34_g8263 , y34_g8263 );
			float lerpResult30_g8263 = lerp( lerpResult5_g8263 , localglslmod34_g8263 , (float)saturate( ( temp_output_37_0_g8263 - 1 ) ));
			float EmissionGlowDelay56_g8263 = lerpResult30_g8263;
			float Delay11_g8271 = EmissionGlowDelay56_g8263;
			float3 localLumaGlowLerp11_g8271 = LumaGlowLerp11_g8271( Band11_g8271 , Delay11_g8271 );
			float3 lerpResult17_g8271 = lerp( ( localgetThemeData15_g8271 * localLumaGlowLerp11_g8271 ) , localLumaGlowLerp11_g8271 , (float)temp_output_13_0_g8271);
			float3 lerpResult22_g8263 = lerp( temp_cast_73 , lerpResult17_g8271 , (float)temp_output_21_0_g8263);
			float3 lerpResult23_g8263 = lerp( lerpResult20_g8263 , lerpResult22_g8263 , (float)saturate( EmissionGlowMode35_g8263 ));
			float4 temp_cast_82 = (1.0).xxxx;
			float temp_output_10_0_g8273 = EmissionGlowDelay56_g8263;
			float Position1_g8275 = ( temp_output_10_0_g8273 / 127.0 );
			float4 localAudioLinkLerp1_g8275 = AudioLinkLerp1_g8275( Position1_g8275 );
			int clampResult8_g8273 = clamp( ( EmissionGlowZone47_g8263 - 4 ) , 1 , 3 );
			int Band11_g8273 = ( 59 - ( clampResult8_g8273 - 1 ) );
			float Delay11_g8273 = temp_output_10_0_g8273;
			float3 localLumaGlowLerp11_g8273 = LumaGlowLerp11_g8273( Band11_g8273 , Delay11_g8273 );
			int Band11_g8274 = 56;
			int localIsLumaActive11_g8274 = IsLumaActive11_g8274( Band11_g8274 );
			float4 lerpResult14_g8273 = lerp( localAudioLinkLerp1_g8275 , float4( localLumaGlowLerp11_g8273 , 0.0 ) , (float)localIsLumaActive11_g8274);
			float4 lerpResult52_g8263 = lerp( temp_cast_82 , lerpResult14_g8273 , (float)saturate( EmissionGlowZone47_g8263 ));
			float4 lerpResult51_g8263 = lerp( float4( lerpResult23_g8263 , 0.0 ) , lerpResult52_g8263 , (float)saturate( ( EmissionGlowZone47_g8263 - 4 ) ));
			float4 temp_cast_87 = (_GreenChGlowMinBrightness).xxxx;
			float4 temp_cast_88 = (( _GreenChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_255_0_g8263 = saturate( EmissionGlowZone47_g8263 );
			int localIfAudioLinkv2Exists1_g8279 = IfAudioLinkv2Exists1_g8279();
			float4 lerpResult280_g8263 = lerp( _GreenChGlowFallback , ( (temp_cast_87 + (lerpResult51_g8263 - float4( 0,0,0,0 )) * (temp_cast_88 - temp_cast_87) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _GreenChGlowTint * temp_output_255_0_g8263 ) , (float)localIfAudioLinkv2Exists1_g8279);
			float4 EmissionGlow142_g8263 = lerpResult280_g8263;
			float4 lerpResult258_g8263 = lerp( temp_cast_67 , EmissionGlow142_g8263 , (float)temp_output_255_0_g8263);
			float4 EmissionGlowTog259_g8263 = lerpResult258_g8263;
			int EmissionReactiveBand243_g8263 = _GreenChReactiveBand;
			int Band3_g8264 = EmissionReactiveBand243_g8263;
			int Delay3_g8264 = 0;
			float localAudioLinkData3_g8264 = AudioLinkData3_g8264( Band3_g8264 , Delay3_g8264 );
			int temp_output_64_0_g8263 = step( _GreenChReactiveBand , 9 );
			float lerpResult66_g8263 = lerp( 1.0 , localAudioLinkData3_g8264 , (float)temp_output_64_0_g8263);
			int Band3_g8266 = _GreenChReactiveBand;
			float cos78_g8263 = cos( radians( _GreenChReactivePulseDir ) );
			float sin78_g8263 = sin( radians( _GreenChReactivePulseDir ) );
			float2 rotator78_g8263 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g8263 , -sin78_g8263 , sin78_g8263 , cos78_g8263 )) + float2( 0.5,0.5 );
			float x96_g8263 = ( ( rotator78_g8263.x * _GreenChReactivePulseScale ) + _GreenChReactivePulseOffset );
			float y96_g8263 = 127.0;
			float localglslmod96_g8263 = glslmod96_g8263( x96_g8263 , y96_g8263 );
			float2 temp_output_34_0_g8267 = ( i.uv_texcoord - _GreenChReactiveRadialCenter );
			float2 break39_g8267 = temp_output_34_0_g8267;
			float2 appendResult50_g8267 = (float2(( _GreenChReactivePulseScale * ( length( temp_output_34_0_g8267 ) * 2.0 ) ) , ( ( atan2( break39_g8267.x , break39_g8267.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x97_g8263 = ( _GreenChReactivePulseOffset + appendResult50_g8267.x );
			float y97_g8263 = 127.0;
			float localglslmod97_g8263 = glslmod97_g8263( x97_g8263 , y97_g8263 );
			int EmissionReactiveMode99_g8263 = _GreenChReactiveMode;
			int temp_output_90_0_g8263 = ( EmissionReactiveMode99_g8263 - 1 );
			float lerpResult77_g8263 = lerp( localglslmod96_g8263 , localglslmod97_g8263 , (float)saturate( temp_output_90_0_g8263 ));
			float lerpResult174_g8263 = lerp( DirectionalMap106_g8263 , ( 1.0 - DirectionalMap106_g8263 ) , (float)saturate( ( EmissionReactiveMode99_g8263 - 3 ) ));
			float x98_g8263 = ( _GreenChReactivePulseOffset + ( _GreenChReactivePulseScale * lerpResult174_g8263 ) );
			float y98_g8263 = 127.0;
			float localglslmod98_g8263 = glslmod98_g8263( x98_g8263 , y98_g8263 );
			float lerpResult87_g8263 = lerp( lerpResult77_g8263 , localglslmod98_g8263 , (float)saturate( ( temp_output_90_0_g8263 - 1 ) ));
			float Delay3_g8266 = lerpResult87_g8263;
			float localAudioLinkLerp3_g8266 = AudioLinkLerp3_g8266( Band3_g8266 , Delay3_g8266 );
			float lerpResult102_g8263 = lerp( 1.0 , localAudioLinkLerp3_g8266 , (float)temp_output_64_0_g8263);
			float lerpResult103_g8263 = lerp( lerpResult66_g8263 , lerpResult102_g8263 , (float)saturate( EmissionReactiveMode99_g8263 ));
			int Band3_g8268 = _GreenChReactiveBand;
			float FilteredAmount3_g8268 = ( ( 1.0 - _GreenChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g8268 = AudioLinkLerp3_g8268( Band3_g8268 , FilteredAmount3_g8268 );
			float lerpResult168_g8263 = lerp( 1.0 , localAudioLinkLerp3_g8268 , (float)temp_output_64_0_g8263);
			float lerpResult172_g8263 = lerp( lerpResult103_g8263 , lerpResult168_g8263 , (float)saturate( ( EmissionReactiveMode99_g8263 - 4 ) ));
			float ReactivityAlpha132_g8263 = (_GreenChReactiveMinBrightness + (lerpResult172_g8263 - 0.0) * (( _GreenChReactiveMinBrightness + 1.0 ) - _GreenChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_100 = (1.0).xxxx;
			float4 lerpResult264_g8263 = lerp( temp_cast_100 , _GreenChReactiveTint , (float)step( EmissionReactiveBand243_g8263 , 9 ));
			float4 FinalReactivity68_g8263 = ( ReactivityAlpha132_g8263 * lerpResult264_g8263 );
			float4 lerpResult146_g8263 = lerp( ( EmissionGlowTog259_g8263 * FinalReactivity68_g8263 ) , ( EmissionGlow142_g8263 + FinalReactivity68_g8263 ) , (float)saturate( _GreenChReactiveBlendMode ));
			float4 ReversedReactivity152_g8263 = ( ( 1.0 - ReactivityAlpha132_g8263 ) * lerpResult264_g8263 );
			int temp_output_157_0_g8263 = ( _GreenChReactiveBlendMode - 1 );
			float4 lerpResult114_g8263 = lerp( lerpResult146_g8263 , ( EmissionGlowTog259_g8263 * ReversedReactivity152_g8263 ) , (float)saturate( temp_output_157_0_g8263 ));
			float4 lerpResult164_g8263 = lerp( lerpResult114_g8263 , ( EmissionGlow142_g8263 + ( ReversedReactivity152_g8263 * step( EmissionReactiveBand243_g8263 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g8263 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g8263 , 9 ) ) ));
			float temp_output_236_0_g8263 = (GlowMaskRGBA174_g8228).y;
			int localIfAudioLinkv2Exists1_g8278 = IfAudioLinkv2Exists1_g8278();
			float4 temp_output_213_0_g8263 = ( lerpResult164_g8263 * temp_output_236_0_g8263 * saturate( ( localIfAudioLinkv2Exists1_g8278 + _UseFallback1 ) ) );
			float4 temp_output_283_0_g8263 = ( _GreenChGlowFallback * temp_output_236_0_g8263 * _UseFallback1 );
			float4 ifLocalVar287_g8263 = 0;
			if( _EnableGreenChannel > 0.0 )
				ifLocalVar287_g8263 = temp_output_213_0_g8263;
			else if( _EnableGreenChannel == 0.0 )
				ifLocalVar287_g8263 = temp_output_283_0_g8263;
			float4 temp_cast_110 = (1.0).xxxx;
			float3 temp_cast_112 = (1.0).xxx;
			int EmissionGlowZone47_g8280 = _BlueChGlowZone;
			int clampResult8_g8286 = clamp( EmissionGlowZone47_g8280 , 1 , 4 );
			int temp_output_3_0_g8286 = ( clampResult8_g8286 - 1 );
			int Zone16_g8286 = temp_output_3_0_g8286;
			float3 localgetThemeData16_g8286 = getThemeData( Zone16_g8286 );
			int Band11_g8287 = 56;
			int localIsLumaActive11_g8287 = IsLumaActive11_g8287( Band11_g8287 );
			int temp_output_14_0_g8286 = localIsLumaActive11_g8287;
			int lerpResult15_g8286 = lerp( temp_output_3_0_g8286 , ( 63 - temp_output_3_0_g8286 ) , (float)temp_output_14_0_g8286);
			int Band2_g8286 = lerpResult15_g8286;
			int Delay2_g8286 = 0;
			float3 localLumaGlowData2_g8286 = LumaGlowData2_g8286( Band2_g8286 , Delay2_g8286 );
			float3 lerpResult17_g8286 = lerp( ( localgetThemeData16_g8286 * localLumaGlowData2_g8286 ) , localLumaGlowData2_g8286 , (float)temp_output_14_0_g8286);
			int temp_output_21_0_g8280 = saturate( EmissionGlowZone47_g8280 );
			float3 lerpResult20_g8280 = lerp( temp_cast_112 , lerpResult17_g8286 , (float)temp_output_21_0_g8280);
			float3 temp_cast_116 = (1.0).xxx;
			int clampResult8_g8288 = clamp( EmissionGlowZone47_g8280 , 1 , 4 );
			int temp_output_3_0_g8288 = ( clampResult8_g8288 - 1 );
			int Zone15_g8288 = temp_output_3_0_g8288;
			float3 localgetThemeData15_g8288 = getThemeData( Zone15_g8288 );
			int Band11_g8289 = 56;
			int localIsLumaActive11_g8289 = IsLumaActive11_g8289( Band11_g8289 );
			int temp_output_13_0_g8288 = localIsLumaActive11_g8289;
			int lerpResult14_g8288 = lerp( temp_output_3_0_g8288 , ( 63 - temp_output_3_0_g8288 ) , (float)temp_output_13_0_g8288);
			int Band11_g8288 = lerpResult14_g8288;
			float cos6_g8280 = cos( radians( _BlueChGlowPulseDir ) );
			float sin6_g8280 = sin( radians( _BlueChGlowPulseDir ) );
			float2 rotator6_g8280 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g8280 , -sin6_g8280 , sin6_g8280 , cos6_g8280 )) + float2( 0.5,0.5 );
			float localGetLocalTime2_g8294 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			int Band6_g8293 = _BlueChGlowAnimationBand;
			int Mode6_g8293 = ( ( _BlueChGlowAnimationMode * 2 ) + _BlueChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g8293 = AudioLinkDecodeDataAsUInt6_g8293( Band6_g8293 , Mode6_g8293 );
			float ifLocalVar289_g8280 = 0;
			if( saturate( ( _BlueChGlowAnimationMode - 3 ) ) > 0.0 )
				ifLocalVar289_g8280 = localGetLocalTime2_g8294;
			else if( saturate( ( _BlueChGlowAnimationMode - 3 ) ) == 0.0 )
				ifLocalVar289_g8280 = ( ( localAudioLinkDecodeDataAsUInt6_g8293 % 628319 ) / 100000.0 );
			float EmissionGlowAnimation195_g8280 = ( _BlueChGlowAnimationStrength * ifLocalVar289_g8280 * step( _BlueChGlowAnimationBand , 9 ) );
			float x13_g8280 = ( ( rotator6_g8280.x * _BlueChGlowPulseScale ) + _BlueChGlowPulseOffset + EmissionGlowAnimation195_g8280 );
			float y13_g8280 = 127.0;
			float localglslmod13_g8280 = glslmod13_g8280( x13_g8280 , y13_g8280 );
			float2 temp_output_34_0_g8282 = ( i.uv_texcoord - _BlueChGlowRadialCenter );
			float2 break39_g8282 = temp_output_34_0_g8282;
			float2 appendResult50_g8282 = (float2(( _BlueChGlowPulseScale * ( length( temp_output_34_0_g8282 ) * 2.0 ) ) , ( ( atan2( break39_g8282.x , break39_g8282.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x12_g8280 = ( _BlueChGlowPulseOffset + appendResult50_g8282.x + EmissionGlowAnimation195_g8280 );
			float y12_g8280 = 127.0;
			float localglslmod12_g8280 = glslmod12_g8280( x12_g8280 , y12_g8280 );
			int EmissionGlowMode35_g8280 = _BlueChGlowMode;
			int temp_output_37_0_g8280 = ( EmissionGlowMode35_g8280 - 1 );
			float lerpResult5_g8280 = lerp( localglslmod13_g8280 , localglslmod12_g8280 , (float)saturate( temp_output_37_0_g8280 ));
			float DirectionalMap106_g8280 = Direction27_g8228;
			float lerpResult179_g8280 = lerp( DirectionalMap106_g8280 , ( 1.0 - DirectionalMap106_g8280 ) , (float)saturate( ( EmissionGlowMode35_g8280 - 3 ) ));
			float x34_g8280 = ( _BlueChGlowPulseOffset + ( _BlueChGlowPulseScale * lerpResult179_g8280 ) + EmissionGlowAnimation195_g8280 );
			float y34_g8280 = 127.0;
			float localglslmod34_g8280 = glslmod34_g8280( x34_g8280 , y34_g8280 );
			float lerpResult30_g8280 = lerp( lerpResult5_g8280 , localglslmod34_g8280 , (float)saturate( ( temp_output_37_0_g8280 - 1 ) ));
			float EmissionGlowDelay56_g8280 = lerpResult30_g8280;
			float Delay11_g8288 = EmissionGlowDelay56_g8280;
			float3 localLumaGlowLerp11_g8288 = LumaGlowLerp11_g8288( Band11_g8288 , Delay11_g8288 );
			float3 lerpResult17_g8288 = lerp( ( localgetThemeData15_g8288 * localLumaGlowLerp11_g8288 ) , localLumaGlowLerp11_g8288 , (float)temp_output_13_0_g8288);
			float3 lerpResult22_g8280 = lerp( temp_cast_116 , lerpResult17_g8288 , (float)temp_output_21_0_g8280);
			float3 lerpResult23_g8280 = lerp( lerpResult20_g8280 , lerpResult22_g8280 , (float)saturate( EmissionGlowMode35_g8280 ));
			float4 temp_cast_125 = (1.0).xxxx;
			float temp_output_10_0_g8290 = EmissionGlowDelay56_g8280;
			float Position1_g8292 = ( temp_output_10_0_g8290 / 127.0 );
			float4 localAudioLinkLerp1_g8292 = AudioLinkLerp1_g8292( Position1_g8292 );
			int clampResult8_g8290 = clamp( ( EmissionGlowZone47_g8280 - 4 ) , 1 , 3 );
			int Band11_g8290 = ( 59 - ( clampResult8_g8290 - 1 ) );
			float Delay11_g8290 = temp_output_10_0_g8290;
			float3 localLumaGlowLerp11_g8290 = LumaGlowLerp11_g8290( Band11_g8290 , Delay11_g8290 );
			int Band11_g8291 = 56;
			int localIsLumaActive11_g8291 = IsLumaActive11_g8291( Band11_g8291 );
			float4 lerpResult14_g8290 = lerp( localAudioLinkLerp1_g8292 , float4( localLumaGlowLerp11_g8290 , 0.0 ) , (float)localIsLumaActive11_g8291);
			float4 lerpResult52_g8280 = lerp( temp_cast_125 , lerpResult14_g8290 , (float)saturate( EmissionGlowZone47_g8280 ));
			float4 lerpResult51_g8280 = lerp( float4( lerpResult23_g8280 , 0.0 ) , lerpResult52_g8280 , (float)saturate( ( EmissionGlowZone47_g8280 - 4 ) ));
			float4 temp_cast_130 = (_BlueChGlowMinBrightness).xxxx;
			float4 temp_cast_131 = (( _BlueChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_258_0_g8280 = saturate( EmissionGlowZone47_g8280 );
			int localIfAudioLinkv2Exists1_g8296 = IfAudioLinkv2Exists1_g8296();
			float4 lerpResult283_g8280 = lerp( _BlueChGlowFallback , ( (temp_cast_130 + (lerpResult51_g8280 - float4( 0,0,0,0 )) * (temp_cast_131 - temp_cast_130) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _BlueChGlowTint * temp_output_258_0_g8280 ) , (float)localIfAudioLinkv2Exists1_g8296);
			float4 EmissionGlow142_g8280 = lerpResult283_g8280;
			float4 lerpResult261_g8280 = lerp( temp_cast_110 , EmissionGlow142_g8280 , (float)temp_output_258_0_g8280);
			float4 EmissionGlowTog262_g8280 = lerpResult261_g8280;
			int EmissionReactiveBand243_g8280 = _BlueChReactiveBand;
			int Band3_g8281 = EmissionReactiveBand243_g8280;
			int Delay3_g8281 = 0;
			float localAudioLinkData3_g8281 = AudioLinkData3_g8281( Band3_g8281 , Delay3_g8281 );
			int temp_output_64_0_g8280 = step( _BlueChReactiveBand , 9 );
			float lerpResult66_g8280 = lerp( 1.0 , localAudioLinkData3_g8281 , (float)temp_output_64_0_g8280);
			int Band3_g8283 = _BlueChReactiveBand;
			float cos78_g8280 = cos( radians( _BlueChReactivePulseDir ) );
			float sin78_g8280 = sin( radians( _BlueChReactivePulseDir ) );
			float2 rotator78_g8280 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g8280 , -sin78_g8280 , sin78_g8280 , cos78_g8280 )) + float2( 0.5,0.5 );
			float x96_g8280 = ( ( rotator78_g8280.x * _BlueChReactivePulseScale ) + _BlueChReactivePulseOffset );
			float y96_g8280 = 127.0;
			float localglslmod96_g8280 = glslmod96_g8280( x96_g8280 , y96_g8280 );
			float2 temp_output_34_0_g8284 = ( i.uv_texcoord - _BlueChReactiveRadialCenter );
			float2 break39_g8284 = temp_output_34_0_g8284;
			float2 appendResult50_g8284 = (float2(( _BlueChReactivePulseScale * ( length( temp_output_34_0_g8284 ) * 2.0 ) ) , ( ( atan2( break39_g8284.x , break39_g8284.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x97_g8280 = ( _BlueChReactivePulseOffset + appendResult50_g8284.x );
			float y97_g8280 = 127.0;
			float localglslmod97_g8280 = glslmod97_g8280( x97_g8280 , y97_g8280 );
			int EmissionReactiveMode99_g8280 = _BlueChReactiveMode;
			int temp_output_90_0_g8280 = ( EmissionReactiveMode99_g8280 - 1 );
			float lerpResult77_g8280 = lerp( localglslmod96_g8280 , localglslmod97_g8280 , (float)saturate( temp_output_90_0_g8280 ));
			float lerpResult174_g8280 = lerp( DirectionalMap106_g8280 , ( 1.0 - DirectionalMap106_g8280 ) , (float)saturate( ( EmissionReactiveMode99_g8280 - 3 ) ));
			float x98_g8280 = ( _BlueChReactivePulseOffset + ( _BlueChReactivePulseScale * lerpResult174_g8280 ) );
			float y98_g8280 = 127.0;
			float localglslmod98_g8280 = glslmod98_g8280( x98_g8280 , y98_g8280 );
			float lerpResult87_g8280 = lerp( lerpResult77_g8280 , localglslmod98_g8280 , (float)saturate( ( temp_output_90_0_g8280 - 1 ) ));
			float Delay3_g8283 = lerpResult87_g8280;
			float localAudioLinkLerp3_g8283 = AudioLinkLerp3_g8283( Band3_g8283 , Delay3_g8283 );
			float lerpResult102_g8280 = lerp( 1.0 , localAudioLinkLerp3_g8283 , (float)temp_output_64_0_g8280);
			float lerpResult103_g8280 = lerp( lerpResult66_g8280 , lerpResult102_g8280 , (float)saturate( EmissionReactiveMode99_g8280 ));
			int Band3_g8285 = _BlueChReactiveBand;
			float FilteredAmount3_g8285 = ( ( 1.0 - _BlueChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g8285 = AudioLinkLerp3_g8285( Band3_g8285 , FilteredAmount3_g8285 );
			float lerpResult168_g8280 = lerp( 1.0 , localAudioLinkLerp3_g8285 , (float)temp_output_64_0_g8280);
			float lerpResult172_g8280 = lerp( lerpResult103_g8280 , lerpResult168_g8280 , (float)saturate( ( EmissionReactiveMode99_g8280 - 4 ) ));
			float ReactivityAlpha132_g8280 = (_BlueChReactiveMinBrightness + (lerpResult172_g8280 - 0.0) * (( _BlueChReactiveMinBrightness + 1.0 ) - _BlueChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_143 = (1.0).xxxx;
			float4 lerpResult268_g8280 = lerp( temp_cast_143 , _BlueChReactiveTint , (float)step( EmissionReactiveBand243_g8280 , 9 ));
			float4 FinalReactivity68_g8280 = ( ReactivityAlpha132_g8280 * lerpResult268_g8280 );
			float4 lerpResult146_g8280 = lerp( ( EmissionGlowTog262_g8280 * FinalReactivity68_g8280 ) , ( EmissionGlow142_g8280 + FinalReactivity68_g8280 ) , (float)saturate( _BlueChReactiveBlendMode ));
			float4 ReversedReactivity152_g8280 = ( ( 1.0 - ReactivityAlpha132_g8280 ) * lerpResult268_g8280 );
			int temp_output_157_0_g8280 = ( _BlueChReactiveBlendMode - 1 );
			float4 lerpResult114_g8280 = lerp( lerpResult146_g8280 , ( EmissionGlowTog262_g8280 * ReversedReactivity152_g8280 ) , (float)saturate( temp_output_157_0_g8280 ));
			float4 lerpResult164_g8280 = lerp( lerpResult114_g8280 , ( EmissionGlow142_g8280 + ( ReversedReactivity152_g8280 * step( EmissionReactiveBand243_g8280 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g8280 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g8280 , 9 ) ) ));
			float temp_output_236_0_g8280 = (GlowMaskRGBA174_g8228).z;
			int localIfAudioLinkv2Exists1_g8295 = IfAudioLinkv2Exists1_g8295();
			float4 temp_output_213_0_g8280 = ( lerpResult164_g8280 * temp_output_236_0_g8280 * saturate( ( localIfAudioLinkv2Exists1_g8295 + _UseFallback2 ) ) );
			float4 temp_output_286_0_g8280 = ( _BlueChGlowFallback * temp_output_236_0_g8280 * _UseFallback2 );
			float4 ifLocalVar290_g8280 = 0;
			if( _EnableBlueChannel > 0.0 )
				ifLocalVar290_g8280 = temp_output_213_0_g8280;
			else if( _EnableBlueChannel == 0.0 )
				ifLocalVar290_g8280 = temp_output_286_0_g8280;
			float4 temp_cast_153 = (1.0).xxxx;
			float3 temp_cast_155 = (1.0).xxx;
			int EmissionGlowZone47_g8297 = _AlphaChGlowZone;
			int clampResult8_g8303 = clamp( EmissionGlowZone47_g8297 , 1 , 4 );
			int temp_output_3_0_g8303 = ( clampResult8_g8303 - 1 );
			int Zone16_g8303 = temp_output_3_0_g8303;
			float3 localgetThemeData16_g8303 = getThemeData( Zone16_g8303 );
			int Band11_g8304 = 56;
			int localIsLumaActive11_g8304 = IsLumaActive11_g8304( Band11_g8304 );
			int temp_output_14_0_g8303 = localIsLumaActive11_g8304;
			int lerpResult15_g8303 = lerp( temp_output_3_0_g8303 , ( 63 - temp_output_3_0_g8303 ) , (float)temp_output_14_0_g8303);
			int Band2_g8303 = lerpResult15_g8303;
			int Delay2_g8303 = 0;
			float3 localLumaGlowData2_g8303 = LumaGlowData2_g8303( Band2_g8303 , Delay2_g8303 );
			float3 lerpResult17_g8303 = lerp( ( localgetThemeData16_g8303 * localLumaGlowData2_g8303 ) , localLumaGlowData2_g8303 , (float)temp_output_14_0_g8303);
			int temp_output_21_0_g8297 = saturate( EmissionGlowZone47_g8297 );
			float3 lerpResult20_g8297 = lerp( temp_cast_155 , lerpResult17_g8303 , (float)temp_output_21_0_g8297);
			float3 temp_cast_159 = (1.0).xxx;
			int clampResult8_g8305 = clamp( EmissionGlowZone47_g8297 , 1 , 4 );
			int temp_output_3_0_g8305 = ( clampResult8_g8305 - 1 );
			int Zone15_g8305 = temp_output_3_0_g8305;
			float3 localgetThemeData15_g8305 = getThemeData( Zone15_g8305 );
			int Band11_g8306 = 56;
			int localIsLumaActive11_g8306 = IsLumaActive11_g8306( Band11_g8306 );
			int temp_output_13_0_g8305 = localIsLumaActive11_g8306;
			int lerpResult14_g8305 = lerp( temp_output_3_0_g8305 , ( 63 - temp_output_3_0_g8305 ) , (float)temp_output_13_0_g8305);
			int Band11_g8305 = lerpResult14_g8305;
			float cos6_g8297 = cos( radians( _AlphaChGlowPulseDir ) );
			float sin6_g8297 = sin( radians( _AlphaChGlowPulseDir ) );
			float2 rotator6_g8297 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g8297 , -sin6_g8297 , sin6_g8297 , cos6_g8297 )) + float2( 0.5,0.5 );
			float localGetLocalTime2_g8311 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			int Band6_g8310 = _AlphaChGlowAnimationBand;
			int Mode6_g8310 = ( ( _AlphaChGlowAnimationMode * 2 ) + _AlphaChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g8310 = AudioLinkDecodeDataAsUInt6_g8310( Band6_g8310 , Mode6_g8310 );
			float ifLocalVar289_g8297 = 0;
			if( saturate( ( _AlphaChGlowAnimationMode - 3 ) ) > 0.0 )
				ifLocalVar289_g8297 = localGetLocalTime2_g8311;
			else if( saturate( ( _AlphaChGlowAnimationMode - 3 ) ) == 0.0 )
				ifLocalVar289_g8297 = ( ( localAudioLinkDecodeDataAsUInt6_g8310 % 628319 ) / 100000.0 );
			float EmissionGlowAnimation195_g8297 = ( _AlphaChGlowAnimationStrength * ifLocalVar289_g8297 * step( _AlphaChGlowAnimationBand , 9 ) );
			float x13_g8297 = ( ( rotator6_g8297.x * _AlphaChGlowPulseScale ) + _AlphaChGlowPulseOffset + EmissionGlowAnimation195_g8297 );
			float y13_g8297 = 127.0;
			float localglslmod13_g8297 = glslmod13_g8297( x13_g8297 , y13_g8297 );
			float2 temp_output_34_0_g8299 = ( i.uv_texcoord - _AlphaChGlowRadialCenter );
			float2 break39_g8299 = temp_output_34_0_g8299;
			float2 appendResult50_g8299 = (float2(( _AlphaChGlowPulseScale * ( length( temp_output_34_0_g8299 ) * 2.0 ) ) , ( ( atan2( break39_g8299.x , break39_g8299.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x12_g8297 = ( _AlphaChGlowPulseOffset + appendResult50_g8299.x + EmissionGlowAnimation195_g8297 );
			float y12_g8297 = 127.0;
			float localglslmod12_g8297 = glslmod12_g8297( x12_g8297 , y12_g8297 );
			int EmissionGlowMode35_g8297 = _AlphaChGlowMode;
			int temp_output_37_0_g8297 = ( EmissionGlowMode35_g8297 - 1 );
			float lerpResult5_g8297 = lerp( localglslmod13_g8297 , localglslmod12_g8297 , (float)saturate( temp_output_37_0_g8297 ));
			float DirectionalMap106_g8297 = Direction27_g8228;
			float lerpResult179_g8297 = lerp( DirectionalMap106_g8297 , ( 1.0 - DirectionalMap106_g8297 ) , (float)saturate( ( EmissionGlowMode35_g8297 - 3 ) ));
			float x34_g8297 = ( _AlphaChGlowPulseOffset + ( _AlphaChGlowPulseScale * lerpResult179_g8297 ) + EmissionGlowAnimation195_g8297 );
			float y34_g8297 = 127.0;
			float localglslmod34_g8297 = glslmod34_g8297( x34_g8297 , y34_g8297 );
			float lerpResult30_g8297 = lerp( lerpResult5_g8297 , localglslmod34_g8297 , (float)saturate( ( temp_output_37_0_g8297 - 1 ) ));
			float EmissionGlowDelay56_g8297 = lerpResult30_g8297;
			float Delay11_g8305 = EmissionGlowDelay56_g8297;
			float3 localLumaGlowLerp11_g8305 = LumaGlowLerp11_g8305( Band11_g8305 , Delay11_g8305 );
			float3 lerpResult17_g8305 = lerp( ( localgetThemeData15_g8305 * localLumaGlowLerp11_g8305 ) , localLumaGlowLerp11_g8305 , (float)temp_output_13_0_g8305);
			float3 lerpResult22_g8297 = lerp( temp_cast_159 , lerpResult17_g8305 , (float)temp_output_21_0_g8297);
			float3 lerpResult23_g8297 = lerp( lerpResult20_g8297 , lerpResult22_g8297 , (float)saturate( EmissionGlowMode35_g8297 ));
			float4 temp_cast_168 = (1.0).xxxx;
			float temp_output_10_0_g8307 = EmissionGlowDelay56_g8297;
			float Position1_g8309 = ( temp_output_10_0_g8307 / 127.0 );
			float4 localAudioLinkLerp1_g8309 = AudioLinkLerp1_g8309( Position1_g8309 );
			int clampResult8_g8307 = clamp( ( EmissionGlowZone47_g8297 - 4 ) , 1 , 3 );
			int Band11_g8307 = ( 59 - ( clampResult8_g8307 - 1 ) );
			float Delay11_g8307 = temp_output_10_0_g8307;
			float3 localLumaGlowLerp11_g8307 = LumaGlowLerp11_g8307( Band11_g8307 , Delay11_g8307 );
			int Band11_g8308 = 56;
			int localIsLumaActive11_g8308 = IsLumaActive11_g8308( Band11_g8308 );
			float4 lerpResult14_g8307 = lerp( localAudioLinkLerp1_g8309 , float4( localLumaGlowLerp11_g8307 , 0.0 ) , (float)localIsLumaActive11_g8308);
			float4 lerpResult52_g8297 = lerp( temp_cast_168 , lerpResult14_g8307 , (float)saturate( EmissionGlowZone47_g8297 ));
			float4 lerpResult51_g8297 = lerp( float4( lerpResult23_g8297 , 0.0 ) , lerpResult52_g8297 , (float)saturate( ( EmissionGlowZone47_g8297 - 4 ) ));
			float4 temp_cast_173 = (_AlphaChGlowMinBrightness).xxxx;
			float4 temp_cast_174 = (( _AlphaChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_258_0_g8297 = saturate( EmissionGlowZone47_g8297 );
			int localIfAudioLinkv2Exists1_g8313 = IfAudioLinkv2Exists1_g8313();
			float4 lerpResult283_g8297 = lerp( _AlphaChGlowFallback , ( (temp_cast_173 + (lerpResult51_g8297 - float4( 0,0,0,0 )) * (temp_cast_174 - temp_cast_173) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _AlphaChGlowTint * temp_output_258_0_g8297 ) , (float)localIfAudioLinkv2Exists1_g8313);
			float4 EmissionGlow142_g8297 = lerpResult283_g8297;
			float4 lerpResult261_g8297 = lerp( temp_cast_153 , EmissionGlow142_g8297 , (float)temp_output_258_0_g8297);
			float4 EmissionGlowTog262_g8297 = lerpResult261_g8297;
			int EmissionReactiveBand243_g8297 = _AlphaChReactiveBand;
			int Band3_g8298 = EmissionReactiveBand243_g8297;
			int Delay3_g8298 = 0;
			float localAudioLinkData3_g8298 = AudioLinkData3_g8298( Band3_g8298 , Delay3_g8298 );
			int temp_output_64_0_g8297 = step( _AlphaChReactiveBand , 9 );
			float lerpResult66_g8297 = lerp( 1.0 , localAudioLinkData3_g8298 , (float)temp_output_64_0_g8297);
			int Band3_g8300 = _AlphaChReactiveBand;
			float cos78_g8297 = cos( radians( _AlphaChReactivePulseDir ) );
			float sin78_g8297 = sin( radians( _AlphaChReactivePulseDir ) );
			float2 rotator78_g8297 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g8297 , -sin78_g8297 , sin78_g8297 , cos78_g8297 )) + float2( 0.5,0.5 );
			float x96_g8297 = ( ( rotator78_g8297.x * _AlphaChReactivePulseScale ) + _AlphaChReactivePulseOffset );
			float y96_g8297 = 127.0;
			float localglslmod96_g8297 = glslmod96_g8297( x96_g8297 , y96_g8297 );
			float2 temp_output_34_0_g8301 = ( i.uv_texcoord - _AlphaChReactiveRadialCenter );
			float2 break39_g8301 = temp_output_34_0_g8301;
			float2 appendResult50_g8301 = (float2(( _AlphaChReactivePulseScale * ( length( temp_output_34_0_g8301 ) * 2.0 ) ) , ( ( atan2( break39_g8301.x , break39_g8301.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x97_g8297 = ( _AlphaChReactivePulseOffset + appendResult50_g8301.x );
			float y97_g8297 = 127.0;
			float localglslmod97_g8297 = glslmod97_g8297( x97_g8297 , y97_g8297 );
			int EmissionReactiveMode99_g8297 = _AlphaChReactiveMode;
			int temp_output_90_0_g8297 = ( EmissionReactiveMode99_g8297 - 1 );
			float lerpResult77_g8297 = lerp( localglslmod96_g8297 , localglslmod97_g8297 , (float)saturate( temp_output_90_0_g8297 ));
			float lerpResult174_g8297 = lerp( DirectionalMap106_g8297 , ( 1.0 - DirectionalMap106_g8297 ) , (float)saturate( ( EmissionReactiveMode99_g8297 - 3 ) ));
			float x98_g8297 = ( _AlphaChReactivePulseOffset + ( _AlphaChReactivePulseScale * lerpResult174_g8297 ) );
			float y98_g8297 = 127.0;
			float localglslmod98_g8297 = glslmod98_g8297( x98_g8297 , y98_g8297 );
			float lerpResult87_g8297 = lerp( lerpResult77_g8297 , localglslmod98_g8297 , (float)saturate( ( temp_output_90_0_g8297 - 1 ) ));
			float Delay3_g8300 = lerpResult87_g8297;
			float localAudioLinkLerp3_g8300 = AudioLinkLerp3_g8300( Band3_g8300 , Delay3_g8300 );
			float lerpResult102_g8297 = lerp( 1.0 , localAudioLinkLerp3_g8300 , (float)temp_output_64_0_g8297);
			float lerpResult103_g8297 = lerp( lerpResult66_g8297 , lerpResult102_g8297 , (float)saturate( EmissionReactiveMode99_g8297 ));
			int Band3_g8302 = _AlphaChReactiveBand;
			float FilteredAmount3_g8302 = ( ( 1.0 - _AlphaChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g8302 = AudioLinkLerp3_g8302( Band3_g8302 , FilteredAmount3_g8302 );
			float lerpResult168_g8297 = lerp( 1.0 , localAudioLinkLerp3_g8302 , (float)temp_output_64_0_g8297);
			float lerpResult172_g8297 = lerp( lerpResult103_g8297 , lerpResult168_g8297 , (float)saturate( ( EmissionReactiveMode99_g8297 - 4 ) ));
			float ReactivityAlpha132_g8297 = (_AlphaChReactiveMinBrightness + (lerpResult172_g8297 - 0.0) * (( _AlphaChReactiveMinBrightness + 1.0 ) - _AlphaChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_186 = (1.0).xxxx;
			float4 lerpResult268_g8297 = lerp( temp_cast_186 , _AlphaChReactiveTint , (float)step( EmissionReactiveBand243_g8297 , 9 ));
			float4 FinalReactivity68_g8297 = ( ReactivityAlpha132_g8297 * lerpResult268_g8297 );
			float4 lerpResult146_g8297 = lerp( ( EmissionGlowTog262_g8297 * FinalReactivity68_g8297 ) , ( EmissionGlow142_g8297 + FinalReactivity68_g8297 ) , (float)saturate( _AlphaChReactiveBlendMode ));
			float4 ReversedReactivity152_g8297 = ( ( 1.0 - ReactivityAlpha132_g8297 ) * lerpResult268_g8297 );
			int temp_output_157_0_g8297 = ( _AlphaChReactiveBlendMode - 1 );
			float4 lerpResult114_g8297 = lerp( lerpResult146_g8297 , ( EmissionGlowTog262_g8297 * ReversedReactivity152_g8297 ) , (float)saturate( temp_output_157_0_g8297 ));
			float4 lerpResult164_g8297 = lerp( lerpResult114_g8297 , ( EmissionGlow142_g8297 + ( ReversedReactivity152_g8297 * step( EmissionReactiveBand243_g8297 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g8297 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g8297 , 9 ) ) ));
			float temp_output_236_0_g8297 = (GlowMaskRGBA174_g8228).w;
			int localIfAudioLinkv2Exists1_g8312 = IfAudioLinkv2Exists1_g8312();
			float4 temp_output_213_0_g8297 = ( lerpResult164_g8297 * temp_output_236_0_g8297 * saturate( ( localIfAudioLinkv2Exists1_g8312 + _UseFallback3 ) ) );
			float4 temp_output_286_0_g8297 = ( _AlphaChGlowFallback * temp_output_236_0_g8297 * _UseFallback3 );
			float4 ifLocalVar290_g8297 = 0;
			if( _EnableAlphaChannel > 0.0 )
				ifLocalVar290_g8297 = temp_output_213_0_g8297;
			else if( _EnableAlphaChannel == 0.0 )
				ifLocalVar290_g8297 = temp_output_286_0_g8297;
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float4 EmissionRGBA590 = ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) );
			float temp_output_43_0_g8192 = _EmissionMaskChannel;
			float temp_output_21_0_g8192 = ( temp_output_43_0_g8192 - 1.0 );
			float temp_output_42_0_g8192 = _EmissionMaskMap;
			float temp_output_6_0_g8192 = ( temp_output_42_0_g8192 - 1.0 );
			float temp_output_9_0_g8192 = ( temp_output_6_0_g8192 - 1.0 );
			float4 temp_cast_196 = (1.0).xxxx;
			float4 ifLocalVar10_g8192 = 0;
			if( saturate( temp_output_42_0_g8192 ) > 0.0 )
				ifLocalVar10_g8192 = MM02RGBA175_g8013;
			else if( saturate( temp_output_42_0_g8192 ) == 0.0 )
				ifLocalVar10_g8192 = MM01RGBA176_g8013;
			float4 ifLocalVar14_g8192 = 0;
			if( saturate( temp_output_6_0_g8192 ) > 0.0 )
				ifLocalVar14_g8192 = MM03RGBA177_g8013;
			else if( saturate( temp_output_6_0_g8192 ) == 0.0 )
				ifLocalVar14_g8192 = ifLocalVar10_g8192;
			float4 ifLocalVar17_g8192 = 0;
			if( saturate( temp_output_9_0_g8192 ) > 0.0 )
				ifLocalVar17_g8192 = MM04RGBA178_g8013;
			else if( saturate( temp_output_9_0_g8192 ) == 0.0 )
				ifLocalVar17_g8192 = ifLocalVar14_g8192;
			float4 ifLocalVar19_g8192 = 0;
			if( saturate( ( temp_output_9_0_g8192 - 1.0 ) ) > 0.0 )
				ifLocalVar19_g8192 = temp_cast_196;
			else if( saturate( ( temp_output_9_0_g8192 - 1.0 ) ) == 0.0 )
				ifLocalVar19_g8192 = ifLocalVar17_g8192;
			float ifLocalVar28_g8192 = 0;
			if( saturate( temp_output_43_0_g8192 ) > 0.0 )
				ifLocalVar28_g8192 = (ifLocalVar19_g8192).g;
			else if( saturate( temp_output_43_0_g8192 ) == 0.0 )
				ifLocalVar28_g8192 = (ifLocalVar19_g8192).r;
			float ifLocalVar32_g8192 = 0;
			if( saturate( temp_output_21_0_g8192 ) > 0.0 )
				ifLocalVar32_g8192 = (ifLocalVar19_g8192).b;
			else if( saturate( temp_output_21_0_g8192 ) == 0.0 )
				ifLocalVar32_g8192 = ifLocalVar28_g8192;
			float ifLocalVar33_g8192 = 0;
			if( saturate( ( temp_output_21_0_g8192 - 1.0 ) ) > 0.0 )
				ifLocalVar33_g8192 = (ifLocalVar19_g8192).a;
			else if( saturate( ( temp_output_21_0_g8192 - 1.0 ) ) == 0.0 )
				ifLocalVar33_g8192 = ifLocalVar32_g8192;
			float temp_output_363_0_g8013 = ifLocalVar33_g8192;
			float EmissionMaskChannel676 = temp_output_363_0_g8013;
			float4 EmissionFinal688 = ( EmissionRGBA590 * EmissionMaskChannel676 );
			#ifdef _EMISSION
				float4 staticSwitch886 = EmissionFinal688;
			#else
				float4 staticSwitch886 = float4( 0,0,0,0 );
			#endif
			float4 temp_output_211_0_g8230 = staticSwitch886;
			float4 temp_cast_202 = (1.0).xxxx;
			float3 temp_cast_203 = (1.0).xxx;
			int EmissionGlowZone47_g8230 = _EmissionGlowZone;
			int clampResult8_g8240 = clamp( EmissionGlowZone47_g8230 , 1 , 4 );
			int temp_output_3_0_g8240 = ( clampResult8_g8240 - 1 );
			int Zone16_g8240 = temp_output_3_0_g8240;
			float3 localgetThemeData16_g8240 = getThemeData( Zone16_g8240 );
			int Band11_g8241 = 56;
			int localIsLumaActive11_g8241 = IsLumaActive11_g8241( Band11_g8241 );
			int temp_output_14_0_g8240 = localIsLumaActive11_g8241;
			int lerpResult15_g8240 = lerp( temp_output_3_0_g8240 , ( 63 - temp_output_3_0_g8240 ) , (float)temp_output_14_0_g8240);
			int Band2_g8240 = lerpResult15_g8240;
			int Delay2_g8240 = 0;
			float3 localLumaGlowData2_g8240 = LumaGlowData2_g8240( Band2_g8240 , Delay2_g8240 );
			float3 lerpResult17_g8240 = lerp( ( localgetThemeData16_g8240 * localLumaGlowData2_g8240 ) , localLumaGlowData2_g8240 , (float)temp_output_14_0_g8240);
			int temp_output_21_0_g8230 = saturate( EmissionGlowZone47_g8230 );
			float3 lerpResult20_g8230 = lerp( temp_cast_203 , lerpResult17_g8240 , (float)temp_output_21_0_g8230);
			float3 temp_cast_207 = (1.0).xxx;
			int clampResult8_g8242 = clamp( EmissionGlowZone47_g8230 , 1 , 4 );
			int temp_output_3_0_g8242 = ( clampResult8_g8242 - 1 );
			int Zone15_g8242 = temp_output_3_0_g8242;
			float3 localgetThemeData15_g8242 = getThemeData( Zone15_g8242 );
			int Band11_g8243 = 56;
			int localIsLumaActive11_g8243 = IsLumaActive11_g8243( Band11_g8243 );
			int temp_output_13_0_g8242 = localIsLumaActive11_g8243;
			int lerpResult14_g8242 = lerp( temp_output_3_0_g8242 , ( 63 - temp_output_3_0_g8242 ) , (float)temp_output_13_0_g8242);
			int Band11_g8242 = lerpResult14_g8242;
			float cos6_g8230 = cos( radians( _EmissionGlowPulseDir ) );
			float sin6_g8230 = sin( radians( _EmissionGlowPulseDir ) );
			float2 rotator6_g8230 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g8230 , -sin6_g8230 , sin6_g8230 , cos6_g8230 )) + float2( 0.5,0.5 );
			float localGetLocalTime2_g8236 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			int Band6_g8245 = _EmissionGlowAnimationBand;
			int Mode6_g8245 = ( ( _EmissionGlowAnimationMode * 2 ) + _EmissionGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g8245 = AudioLinkDecodeDataAsUInt6_g8245( Band6_g8245 , Mode6_g8245 );
			float ifLocalVar287_g8230 = 0;
			if( saturate( ( _EmissionGlowAnimationMode - 3 ) ) > 0.0 )
				ifLocalVar287_g8230 = localGetLocalTime2_g8236;
			else if( saturate( ( _EmissionGlowAnimationMode - 3 ) ) == 0.0 )
				ifLocalVar287_g8230 = ( ( localAudioLinkDecodeDataAsUInt6_g8245 % 628319 ) / 100000.0 );
			float EmissionGlowAnimation195_g8230 = ( _EmissionGlowAnimationStrength * ifLocalVar287_g8230 * step( _EmissionGlowAnimationBand , 9 ) );
			float x13_g8230 = ( ( rotator6_g8230.x * _EmissionGlowPulseScale ) + _EmissionGlowPulseOffset + EmissionGlowAnimation195_g8230 );
			float y13_g8230 = 127.0;
			float localglslmod13_g8230 = glslmod13_g8230( x13_g8230 , y13_g8230 );
			float2 temp_output_34_0_g8232 = ( i.uv_texcoord - _EmissionGlowRadialCenter );
			float2 break39_g8232 = temp_output_34_0_g8232;
			float2 appendResult50_g8232 = (float2(( _EmissionGlowPulseScale * ( length( temp_output_34_0_g8232 ) * 2.0 ) ) , ( ( atan2( break39_g8232.x , break39_g8232.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x12_g8230 = ( _EmissionGlowPulseOffset + appendResult50_g8232.x + EmissionGlowAnimation195_g8230 );
			float y12_g8230 = 127.0;
			float localglslmod12_g8230 = glslmod12_g8230( x12_g8230 , y12_g8230 );
			int EmissionGlowMode35_g8230 = _EmissionGlowMode;
			int temp_output_37_0_g8230 = ( EmissionGlowMode35_g8230 - 1 );
			float lerpResult5_g8230 = lerp( localglslmod13_g8230 , localglslmod12_g8230 , (float)saturate( temp_output_37_0_g8230 ));
			float DirectionalMap106_g8230 = Direction27_g8228;
			float lerpResult179_g8230 = lerp( DirectionalMap106_g8230 , ( 1.0 - DirectionalMap106_g8230 ) , (float)saturate( ( EmissionGlowMode35_g8230 - 3 ) ));
			float x34_g8230 = ( _EmissionGlowPulseOffset + ( _EmissionGlowPulseScale * lerpResult179_g8230 ) + EmissionGlowAnimation195_g8230 );
			float y34_g8230 = 127.0;
			float localglslmod34_g8230 = glslmod34_g8230( x34_g8230 , y34_g8230 );
			float lerpResult30_g8230 = lerp( lerpResult5_g8230 , localglslmod34_g8230 , (float)saturate( ( temp_output_37_0_g8230 - 1 ) ));
			float EmissionGlowDelay56_g8230 = lerpResult30_g8230;
			float Delay11_g8242 = EmissionGlowDelay56_g8230;
			float3 localLumaGlowLerp11_g8242 = LumaGlowLerp11_g8242( Band11_g8242 , Delay11_g8242 );
			float3 lerpResult17_g8242 = lerp( ( localgetThemeData15_g8242 * localLumaGlowLerp11_g8242 ) , localLumaGlowLerp11_g8242 , (float)temp_output_13_0_g8242);
			float3 lerpResult22_g8230 = lerp( temp_cast_207 , lerpResult17_g8242 , (float)temp_output_21_0_g8230);
			float3 lerpResult23_g8230 = lerp( lerpResult20_g8230 , lerpResult22_g8230 , (float)saturate( EmissionGlowMode35_g8230 ));
			float4 temp_cast_216 = (1.0).xxxx;
			float temp_output_10_0_g8237 = EmissionGlowDelay56_g8230;
			float Position1_g8239 = ( temp_output_10_0_g8237 / 127.0 );
			float4 localAudioLinkLerp1_g8239 = AudioLinkLerp1_g8239( Position1_g8239 );
			int clampResult8_g8237 = clamp( ( EmissionGlowZone47_g8230 - 4 ) , 1 , 3 );
			int Band11_g8237 = ( 59 - ( clampResult8_g8237 - 1 ) );
			float Delay11_g8237 = temp_output_10_0_g8237;
			float3 localLumaGlowLerp11_g8237 = LumaGlowLerp11_g8237( Band11_g8237 , Delay11_g8237 );
			int Band11_g8238 = 56;
			int localIsLumaActive11_g8238 = IsLumaActive11_g8238( Band11_g8238 );
			float4 lerpResult14_g8237 = lerp( localAudioLinkLerp1_g8239 , float4( localLumaGlowLerp11_g8237 , 0.0 ) , (float)localIsLumaActive11_g8238);
			float4 lerpResult52_g8230 = lerp( temp_cast_216 , lerpResult14_g8237 , (float)saturate( EmissionGlowZone47_g8230 ));
			float4 lerpResult51_g8230 = lerp( float4( lerpResult23_g8230 , 0.0 ) , lerpResult52_g8230 , (float)saturate( ( EmissionGlowZone47_g8230 - 4 ) ));
			float4 temp_cast_221 = (_EmissionGlowMinBrightness).xxxx;
			float4 temp_cast_222 = (( _EmissionGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_245_0_g8230 = saturate( EmissionGlowZone47_g8230 );
			float4 EmissionGlow142_g8230 = ( (temp_cast_221 + (lerpResult51_g8230 - float4( 0,0,0,0 )) * (temp_cast_222 - temp_cast_221) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _EmissionGlowTint * temp_output_245_0_g8230 );
			float4 lerpResult248_g8230 = lerp( temp_cast_202 , EmissionGlow142_g8230 , (float)temp_output_245_0_g8230);
			float4 EmissionGlowTog249_g8230 = lerpResult248_g8230;
			int EmissionReactiveBand254_g8230 = _EmissionReactiveBand;
			int Band3_g8231 = EmissionReactiveBand254_g8230;
			int Delay3_g8231 = 0;
			float localAudioLinkData3_g8231 = AudioLinkData3_g8231( Band3_g8231 , Delay3_g8231 );
			int temp_output_64_0_g8230 = step( _EmissionReactiveBand , 9 );
			float lerpResult66_g8230 = lerp( 1.0 , localAudioLinkData3_g8231 , (float)temp_output_64_0_g8230);
			int Band3_g8233 = _EmissionReactiveBand;
			float cos78_g8230 = cos( radians( _EmissionReactivePulseDir ) );
			float sin78_g8230 = sin( radians( _EmissionReactivePulseDir ) );
			float2 rotator78_g8230 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g8230 , -sin78_g8230 , sin78_g8230 , cos78_g8230 )) + float2( 0.5,0.5 );
			float x96_g8230 = ( ( rotator78_g8230.x * _EmissionReactivePulseScale ) + _EmissionReactivePulseOffset );
			float y96_g8230 = 127.0;
			float localglslmod96_g8230 = glslmod96_g8230( x96_g8230 , y96_g8230 );
			float2 temp_output_34_0_g8234 = ( i.uv_texcoord - _EmissionReactiveRadialCenter );
			float2 break39_g8234 = temp_output_34_0_g8234;
			float2 appendResult50_g8234 = (float2(( _EmissionReactivePulseScale * ( length( temp_output_34_0_g8234 ) * 2.0 ) ) , ( ( atan2( break39_g8234.x , break39_g8234.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float x97_g8230 = ( _EmissionReactivePulseOffset + appendResult50_g8234.x );
			float y97_g8230 = 127.0;
			float localglslmod97_g8230 = glslmod97_g8230( x97_g8230 , y97_g8230 );
			int EmissionReactiveMode99_g8230 = _EmissionReactiveMode;
			int temp_output_90_0_g8230 = ( EmissionReactiveMode99_g8230 - 1 );
			float lerpResult77_g8230 = lerp( localglslmod96_g8230 , localglslmod97_g8230 , (float)saturate( temp_output_90_0_g8230 ));
			float lerpResult174_g8230 = lerp( DirectionalMap106_g8230 , ( 1.0 - DirectionalMap106_g8230 ) , (float)saturate( ( EmissionReactiveMode99_g8230 - 3 ) ));
			float x98_g8230 = ( _EmissionReactivePulseOffset + ( _EmissionReactivePulseScale * lerpResult174_g8230 ) );
			float y98_g8230 = 127.0;
			float localglslmod98_g8230 = glslmod98_g8230( x98_g8230 , y98_g8230 );
			float lerpResult87_g8230 = lerp( lerpResult77_g8230 , localglslmod98_g8230 , (float)saturate( ( temp_output_90_0_g8230 - 1 ) ));
			float Delay3_g8233 = lerpResult87_g8230;
			float localAudioLinkLerp3_g8233 = AudioLinkLerp3_g8233( Band3_g8233 , Delay3_g8233 );
			float lerpResult102_g8230 = lerp( 1.0 , localAudioLinkLerp3_g8233 , (float)temp_output_64_0_g8230);
			float lerpResult103_g8230 = lerp( lerpResult66_g8230 , lerpResult102_g8230 , (float)saturate( EmissionReactiveMode99_g8230 ));
			int Band3_g8235 = _EmissionReactiveBand;
			float FilteredAmount3_g8235 = ( ( 1.0 - _EmissionReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g8235 = AudioLinkLerp3_g8235( Band3_g8235 , FilteredAmount3_g8235 );
			float lerpResult168_g8230 = lerp( 1.0 , localAudioLinkLerp3_g8235 , (float)temp_output_64_0_g8230);
			float lerpResult172_g8230 = lerp( lerpResult103_g8230 , lerpResult168_g8230 , (float)saturate( ( EmissionReactiveMode99_g8230 - 4 ) ));
			float ReactivityAlpha132_g8230 = (_EmissionReactiveMinBrightness + (lerpResult172_g8230 - 0.0) * (( _EmissionReactiveMinBrightness + 1.0 ) - _EmissionReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_233 = (1.0).xxxx;
			float4 lerpResult265_g8230 = lerp( temp_cast_233 , _EmissionReactiveTint , (float)step( EmissionReactiveBand254_g8230 , 9 ));
			float4 FinalReactivity68_g8230 = ( ReactivityAlpha132_g8230 * lerpResult265_g8230 );
			float4 lerpResult146_g8230 = lerp( ( EmissionGlowTog249_g8230 * FinalReactivity68_g8230 ) , ( EmissionGlow142_g8230 + FinalReactivity68_g8230 ) , (float)saturate( _EmissionReactiveBlendMode ));
			float4 ReversedReactivity152_g8230 = ( ( 1.0 - ReactivityAlpha132_g8230 ) * lerpResult265_g8230 );
			int temp_output_157_0_g8230 = ( _EmissionReactiveBlendMode - 1 );
			float4 lerpResult114_g8230 = lerp( lerpResult146_g8230 , ( EmissionGlowTog249_g8230 * ReversedReactivity152_g8230 ) , (float)saturate( temp_output_157_0_g8230 ));
			float4 lerpResult164_g8230 = lerp( lerpResult114_g8230 , ( EmissionGlow142_g8230 + ( ReversedReactivity152_g8230 * step( EmissionReactiveBand254_g8230 , 9 ) ) ) , (float)saturate( ( temp_output_157_0_g8230 - 1 ) ));
			float grayscale214_g8230 = Luminance(temp_output_211_0_g8230.rgb);
			float smoothstepResult215_g8230 = smoothstep( 0.0 , 0.5 , grayscale214_g8230);
			int ReactiveBlendmode272_g8230 = _EmissionReactiveBlendMode;
			float x270_g8230 = (float)ReactiveBlendmode272_g8230;
			float y270_g8230 = 2.0;
			float localglslmod270_g8230 = glslmod270_g8230( x270_g8230 , y270_g8230 );
			float lerpResult271_g8230 = lerp( localglslmod270_g8230 , (float)_EmissionGlowBlendMode , (float)saturate( EmissionGlowZone47_g8230 ));
			float4 lerpResult212_g8230 = lerp( ( lerpResult164_g8230 * temp_output_211_0_g8230 ) , ( ( lerpResult164_g8230 * smoothstepResult215_g8230 ) + temp_output_211_0_g8230 ) , lerpResult271_g8230);
			int localIfAudioLinkv2Exists1_g8244 = IfAudioLinkv2Exists1_g8244();
			float4 lerpResult281_g8230 = lerp( temp_output_211_0_g8230 , lerpResult212_g8230 , (float)localIfAudioLinkv2Exists1_g8244);
			#ifdef _EMISSION
				float4 staticSwitch284_g8230 = lerpResult281_g8230;
			#else
				float4 staticSwitch284_g8230 = float4( 0,0,0,0 );
			#endif
			float4 Emiss1322 = ( ( ifLocalVar295_g8246 + ifLocalVar287_g8263 + ifLocalVar290_g8280 + ifLocalVar290_g8297 ) + staticSwitch284_g8230 );
			o.Emission = Emiss1322.xyz;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows nolightmap  nodirlightmap nometa vertex:vertexDataFunc 

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
				float4 customPack3 : TEXCOORD3;
				float2 customPack4 : TEXCOORD4;
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full_custom v )
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
				o.customPack1.zw = customInputData.vertexToFrag51_g8229;
				o.customPack2.xy = customInputData.vertexToFrag51_g5489;
				o.customPack2.zw = customInputData.vertexToFrag51_g5488;
				o.customPack3.xy = customInputData.vertexToFrag51_g5487;
				o.customPack3.zw = customInputData.vertexToFrag51_g5486;
				o.customPack4.xy = customInputData.vertexToFrag51_g8211;
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
				surfIN.vertexToFrag51_g8229 = IN.customPack1.zw;
				surfIN.vertexToFrag51_g5489 = IN.customPack2.xy;
				surfIN.vertexToFrag51_g5488 = IN.customPack2.zw;
				surfIN.vertexToFrag51_g5487 = IN.customPack3.xy;
				surfIN.vertexToFrag51_g5486 = IN.customPack3.zw;
				surfIN.vertexToFrag51_g8211 = IN.customPack4.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "UmbraShaderUI"
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.CommentaryNode;235;-9424.979,-6467.464;Inherit;False;4467.322;2418.005;Comment;51;686;685;677;281;340;338;627;280;258;268;245;234;212;211;743;747;749;750;751;752;753;756;759;1488;42;1497;43;1575;1584;1389;1673;1675;1676;1677;1678;1679;1680;1681;1682;1683;1685;10;225;230;228;1707;1710;247;1724;1385;1835;Workflow Switcher;0.6670364,1,0.3820755,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;1673;-9336.532,-5408.79;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;8;-10160.09,-2522.909;Inherit;False;3982.787;1722.466;Comment;89;4;6;1371;1370;411;1368;1366;12;11;50;1363;1360;1356;1359;1358;1357;1124;973;972;971;970;975;974;967;966;418;417;416;415;410;409;408;407;218;219;216;17;217;53;18;7;689;1361;23;596;692;691;1362;5;595;22;693;690;590;593;38;594;21;646;645;20;592;589;16;588;587;420;414;412;419;406;296;295;413;52;9;405;51;1388;1393;1394;1395;1396;1401;1402;1403;1404;1832;1859;Texture Assignments;0.1176471,0.3137255,0.627451,1;0;0
Node;AmplifyShaderEditor.DdxOpNode;1675;-9133.217,-5438.194;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DdyOpNode;1676;-9135.217,-5368.194;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;50;-8329.261,-1976.14;Inherit;True;Property;_MaskMap02;Mask Map 02;244;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;11;-8375.626,-2470.025;Inherit;True;Property;_MaskMap01;Mask Map 01;241;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;405;-7289.081,-2353.497;Inherit;True;Property;_MaskMap03;Mask Map 03;246;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DotProductOpNode;1677;-8994.217,-5462.194;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1678;-8992.217,-5370.194;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-8118.705,-1970.098;Inherit;False;MaskMap02Tex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-8149.914,-2469.857;Inherit;False;MaskMap01Tex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;1366;-8348.26,-2254.953;Inherit;False;Property;_MaskMap01UV;MaskMap01UV;242;1;[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1368;-8319.121,-1791.788;Inherit;False;Property;_MaskMap02UV;MaskMap02UV;245;1;[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;411;-7063.568,-2354.629;Inherit;False;MaskMap03Tex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;1370;-7280.11,-2174.296;Inherit;False;Property;_MaskMap03UV;MaskMap03UV;247;1;[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;413;-7287.021,-1938.036;Inherit;True;Property;_MaskMap04;Mask Map 04;248;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;1371;-7278.111,-1747.296;Inherit;False;Property;_MaskMap04UV;MaskMap04UV;249;1;[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1679;-8868.217,-5422.194;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1604;-8141.204,-2278.725;Inherit;False;UV Channel Select;-1;;5486;756457f5c2398324eb74b053d38f83bd;1,50,1;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1605;-8112.065,-1815.56;Inherit;False;UV Channel Select;-1;;5487;756457f5c2398324eb74b053d38f83bd;1,50,1;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1606;-7073.054,-2198.068;Inherit;False;UV Channel Select;-1;;5488;756457f5c2398324eb74b053d38f83bd;1,50,1;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;419;-7054.808,-1939.169;Inherit;False;MaskMap04Tex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1607;-7071.055,-1771.068;Inherit;False;UV Channel Select;-1;;5489;756457f5c2398324eb74b053d38f83bd;1,50,1;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;1680;-8750.217,-5423.194;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1682;-8762.217,-5353.194;Inherit;False;Constant;_Float50;Float 50;119;0;Create;True;0;0;0;False;0;False;0.333;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-7905.46,-2348.815;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-7912.179,-1969.705;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;406;-6849.04,-2354.236;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;414;-6848.282,-1938.776;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;211;-5442.605,-6355.02;Inherit;False;Property;_Workflow;Workflow;240;2;[Header];[Enum];Create;True;0;4;Furality;3;Metallic;0;Specular;1;Packed;2;0;True;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1681;-8547.217,-5422.194;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;295;-7568.321,-2461.267;Inherit;False;MM01RGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;-7575.453,-2078.679;Inherit;False;MM02RGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;412;-6513.314,-2463.209;Inherit;False;MM03RGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;420;-6512.555,-2047.747;Inherit;False;MM04RGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;212;-5281.526,-6370.381;Inherit;False;Workflow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1835;-8381.211,-5342.481;Inherit;False;SpecularAntiAlias;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1853;-2439.751,-8933.565;Inherit;False;1835;SpecularAntiAlias;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1854;-2404.751,-9020.565;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1855;-2421.751,-8834.565;Inherit;False;295;MM01RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1856;-2417.751,-8758.565;Inherit;False;296;MM02RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1858;-2409.751,-8610.565;Inherit;False;420;MM04RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1857;-2410.751,-8691.565;Inherit;False;412;MM03RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;587;-9486.039,-1586.093;Inherit;True;Property;_EmissionMap;EmissionMap;236;1;[Header];Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-7568.299,-2393.18;Inherit;False;MM01R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;227;-9491.711,-6115.233;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1852;-2093.55,-8864.464;Inherit;False;Packed Map Selector;0;;8013;87d7f82645b0a6b4694b5ef8468b48c5;0;6;348;FLOAT;0;False;347;FLOAT;0;False;167;FLOAT4;0,0,0,0;False;168;FLOAT4;0,0,0,0;False;169;FLOAT4;0,0,0,0;False;170;FLOAT4;0,0,0,0;False;20;FLOAT;0;FLOAT;530;FLOAT;528;COLOR;527;FLOAT;526;FLOAT;525;FLOAT;524;FLOAT;523;COLOR;531;FLOAT;529;FLOAT;520;FLOAT;519;FLOAT;518;FLOAT;517;FLOAT;516;FLOAT;515;FLOAT;521;FLOAT;522;FLOAT;532;FLOAT;533
Node;AmplifyShaderEditor.CommentaryNode;234;-9129.711,-6282.38;Inherit;False;1120.352;378.5132;Comment;11;226;229;233;231;694;695;696;224;1705;1706;1708;Metallics;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;588;-9267.763,-1589.364;Inherit;False;EmissionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SaturateNode;228;-9314.673,-6114.867;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;225;-9344.359,-6234.38;Inherit;False;16;MM01R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;230;-9308.673,-6042.867;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;232;-1594.408,-9514.048;Inherit;False;MetallicChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;592;-8344.867,-1656.893;Inherit;True;Property;_DetailNormal;DetailNormal;275;1;[Header];Create;False;1;Detail Normal;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;589;-9035.837,-1591.692;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;645;-9009.097,-1770.446;Inherit;False;Property;_EmissionColor;Emission Tint;237;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,0;0.01,0.01,0.01,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;4;-10050.54,-2432.819;Inherit;True;Property;_MainTex;Main Tex;235;1;[Header];Create;True;1;Main;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LerpOp;226;-9112.358,-6234.38;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;233;-9142.434,-6116.027;Inherit;False;232;MetallicChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;231;-9084.673,-6041.867;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1707;-9082.383,-5965.946;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;20;-9387.941,-1963.747;Inherit;True;Property;_BumpMap;Normal Map;238;0;Create;False;0;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;593;-8118.025,-1659.884;Inherit;False;DetailNormalTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;1393;-8326.467,-1367.27;Inherit;False;Property;_DetailUV;DetailUV;243;1;[Enum];Create;False;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;646;-8733.097,-1650.446;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-9833.266,-2435.09;Inherit;False;MainTexTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.LerpOp;229;-8855.673,-6233.867;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1708;-8927.383,-5967.946;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1706;-8876.383,-6116.946;Inherit;False;16;MM01R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;676;-1568.94,-8245.562;Inherit;False;EmissionMaskChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-9152.033,-1969.67;Inherit;False;NormalTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-9421.629,-1771.309;Inherit;False;Property;_BumpScale;Normal Scale;239;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;594;-8378.557,-1464.456;Inherit;False;Property;_BumpScale1;Detail Normal Scale;276;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1610;-8110.467,-1390.27;Inherit;False;UV Channel Select;-1;;8211;756457f5c2398324eb74b053d38f83bd;1,50,1;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;590;-8580.003,-1649.685;Inherit;False;EmissionRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;690;-9368.858,-2113.604;Inherit;False;676;EmissionMaskChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-9617.34,-2434.419;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;693;-9348.517,-2186.109;Inherit;False;Property;_ReplaceBaseColor;Replace Base Color;250;1;[ToggleUI];Create;True;1;Emission;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1362;-9628.442,-2231.165;Inherit;False;Property;_Color;Color;220;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;694;-8224.161,-6000.491;Inherit;False;Property;_MetallicMult;MetallicMult;251;0;Create;True;0;0;0;False;0;False;1;1.75;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1705;-8611.383,-6231.946;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-8945.507,-1969.277;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;595;-7892.499,-1652.492;Inherit;True;Property;;;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;691;-9146.063,-2236.339;Inherit;False;590;EmissionRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;692;-9116.776,-2147.149;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1361;-9269.643,-2432.665;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;695;-8187.161,-6118.491;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;627;-7725.081,-5189.773;Inherit;False;1085.658;378.5127;Comment;11;642;643;639;641;637;640;638;1580;1581;1582;1583;Detail Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-8626.42,-1964.787;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;596;-7588.001,-1659.933;Inherit;False;DetailNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;268;-7545.961,-6326.3;Inherit;False;1770.602;430.8945;Comment;23;40;222;41;2;223;220;260;262;263;264;266;267;337;924;925;1387;1489;1487;1386;1510;1511;1576;1645;Specular Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;696;-8189.152,-6193.963;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1497;-6591.523,-4674.796;Inherit;False;1120.352;378.5132;Comment;12;1509;1508;1507;1505;1504;1503;1502;1501;1500;1499;1498;1448;Fleck Metallics;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;689;-8836.897,-2440.347;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;923;-1505.906,-9250.398;Inherit;False;SpecularTintCol;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;640;-7691.354,-5053.058;Inherit;False;23;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;638;-7692.354,-4980.058;Inherit;False;596;DetailNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;-8643.507,-2426.412;Inherit;False;MainTexRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;222;-7478.552,-6120.153;Inherit;False;Property;_SpecularTint;Specular Tint;255;0;Create;True;1;Specular Color;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;-8216.358,-6264.38;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1498;-6541.523,-4505.649;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;258;-6192.622,-5750.287;Inherit;False;1102.033;405.5127;Comment;12;252;254;253;250;249;246;1390;1648;1723;1725;248;255;Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;924;-7478.273,-5952.07;Inherit;False;923;SpecularTintCol;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;247;-6456.622,-5567.141;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;626;-1531.33,-8614.289;Inherit;False;DetailNormalChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;637;-7484.354,-5034.058;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;641;-7497.354,-4939.058;Inherit;False;626;DetailNormalChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;642;-7454.354,-5107.058;Inherit;False;23;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-7466.961,-6185.3;Inherit;False;224;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;925;-7249.273,-6124.07;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-7495.961,-6259.299;Inherit;False;7;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1499;-6394.172,-4624.796;Inherit;False;16;MM01R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1500;-6358.485,-4433.283;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1501;-6364.485,-4505.283;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1385;-7458.38,-5866.48;Inherit;False;295;MM01RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;249;-6273.584,-5495.774;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-7577.012,-1918.816;Inherit;False;MM02G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1482;-1546.841,-8100.979;Inherit;False;FleckMetallicChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;-1513.683,-8459.603;Inherit;False;OcclusionChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;639;-7182.354,-5054.058;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;223;-7072.227,-6130.498;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1502;-6162.171,-4624.796;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1504;-6134.485,-4432.283;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1503;-6192.246,-4506.443;Inherit;False;1482;FleckMetallicChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;260;-6831.678,-6104.771;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DiffuseAndSpecularFromMetallicNode;2;-7249.962,-6258.075;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;3;FLOAT3;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1386;-7178.228,-5995.815;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;216;-7569.49,-2314.261;Inherit;False;MM01G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1724;-6048.134,-5421.394;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;253;-6049.585,-5494.774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;-6094.73,-5681.594;Inherit;False;217;MM02G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;252;-6096.346,-5586.934;Inherit;False;257;OcclusionChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1580;-7021.11,-5141.565;Inherit;False;InitialNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1390;-5562.837,-5443.929;Inherit;False;Property;_OcclusionPower;Occlusion Power;254;0;Create;False;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1387;-7022.228,-5997.815;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-6897.55,-6222.153;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;263;-6654.64,-6104.406;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;262;-6648.64,-6032.406;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1505;-5905.485,-4624.283;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1448;-5934.668,-4437.196;Inherit;False;Property;_FleckMetallic;FleckMetallic;212;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1725;-5861.134,-5491.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;254;-5825.585,-5682.774;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;248;-5846.271,-5560.287;Inherit;False;216;MM01G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;202;3688.677,-6496.571;Inherit;False;4100.554;2387.413;Comment;28;200;548;581;553;579;198;176;783;1127;1126;1125;1128;1129;1333;1429;1430;1411;1427;192;1573;1585;1586;1587;1588;1654;1655;1518;1589;Lighting;1,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1648;-5273.817,-5443.662;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;264;-6452.324,-6223.918;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;266;-6425.638,-5983.406;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;280;-7680.977,-5719.77;Inherit;False;1085.658;378.5127;Comment;9;269;271;272;273;276;278;274;275;277;Reflection Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1507;-5648.974,-4510.907;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1723;-5610.134,-5679.394;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1688;7881.619,-5347.341;Inherit;False;1580;InitialNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;279;-1535.821,-8531.815;Inherit;False;ReflectionMaskChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1389;-5294.837,-5563.929;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;267;-6195.638,-6223.406;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;274;-7281.698,-5551.418;Inherit;False;279;ReflectionMaskChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;176;3788.802,-6379.216;Inherit;False;1688.495;505.423;Comment;13;32;35;34;60;33;1275;1324;1417;1422;1424;1328;780;1412;GlintSpecular;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;1508;-5650.964,-4586.379;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1240;-1504.162,-8784.671;Inherit;False;GlintGlossChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1861;8065.747,-5343.97;Inherit;False;VRC Light;-1;;8317;675a2dca12829524d8a7f69e08069f38;0;1;23;FLOAT3;0,0,0;False;2;FLOAT3;21;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1489;-5899.582,-6176.917;Inherit;False;InitialSpec;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;-6837.318,-5668.423;Inherit;False;ReflectionMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;3908.608,-6210.92;Inherit;False;1240;GlintGlossChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1509;-5678.171,-4656.796;Inherit;False;MetallicForFleck;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1510;-7034.496,-6066.408;Inherit;False;GlintSpecCol1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;246;-5332.591,-5673.358;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;3849.242,-6282.301;Inherit;False;Property;_GlintGloss;Glint Gloss;272;0;Create;True;0;0;0;False;0;False;0.95;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;3874.565,-6065.255;Inherit;False;Property;_GlintAmount;Glint Amount;273;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1511;-6870.496,-5994.408;Inherit;False;GlintSpecCol2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;776;8352.248,-5385.528;Inherit;False;LightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;782;8355.786,-5248.801;Inherit;False;LightCol;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1633;-1496.362,-8864.565;Inherit;False;FleckTintCol;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;1422;4159.723,-6113.592;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1438;4197.736,-6715.53;Inherit;False;277;ReflectionMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1414;4195.669,-7029.948;Inherit;True;Property;_DictionaryTex;Texture 0;218;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;1439;4228.549,-6792.672;Inherit;False;246;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;4232.663,-6858.714;Inherit;False;1580;InitialNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1434;4204.447,-7103.763;Inherit;False;1489;InitialSpec;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1275;4289.289,-6227.052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1483;4658.076,-7027.997;Inherit;False;1509;MetallicForFleck;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1513;4630.721,-6944.256;Inherit;False;1510;GlintSpecCol1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1515;4897.142,-7071.809;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1514;4883.77,-6943.228;Inherit;False;1511;GlintSpecCol2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1436;4324.385,-7291.689;Inherit;False;776;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1437;4320.519,-7359.995;Inherit;False;782;LightCol;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1635;4277.722,-7225.604;Inherit;False;1633;FleckTintCol;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1435;4170.602,-7170.005;Inherit;False;7;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1410;4410.086,-6543.163;Inherit;False;Property;_FleckScale;Fleck Scale;215;0;Create;False;0;0;0;False;0;False;500;1500;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1411;4403.586,-6471.663;Inherit;False;Property;_FleckSize;Fleck Size;216;0;Create;False;0;0;0;False;0;False;0.35;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1424;4350.822,-6087.594;Inherit;False;Property;_GlintTimescale;Glint Timescale;217;0;Create;False;0;0;0;False;0;False;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;3873.565,-5994.255;Inherit;False;Property;_GlintDensity;Glint Density;274;0;Create;True;0;0;0;False;0;False;0.5;41;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;542;-1527.262,-8383.046;Inherit;False;GlintChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1528;5576.223,-6754.175;Inherit;False;542;GlintChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1531;5905.467,-6723.654;Inherit;False;1580;InitialNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;245;-9341.006,-5806.67;Inherit;False;1463.023;341.2168;Comment;13;213;215;214;241;236;243;239;697;698;1684;1709;1711;1712;Gloss;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;238;-9634.963,-5612.329;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1862;4910.676,-6632.703;Inherit;False;SparkleSpec;42;;8321;58aee035235c0c144a49b4bba6f3b797;2,127,1,174,1;21;135;FLOAT;0;False;124;FLOAT3;0,0,0;False;125;FLOAT;0;False;123;FLOAT3;0,0,0;False;102;FLOAT;0;False;63;FLOAT3;0,0,0;False;71;FLOAT3;0,0,0;False;191;FLOAT3;0,0,0;False;72;FLOAT3;0,0,0;False;73;FLOAT3;0,0,0;False;51;SAMPLER2D;0;False;53;FLOAT2;0,0;False;60;FLOAT3;0,0,0;False;74;FLOAT;0;False;75;FLOAT;0;False;59;FLOAT;0;False;62;FLOAT;0;False;57;FLOAT;0;False;54;FLOAT;0;False;58;FLOAT;0;False;55;FLOAT;0;False;7;FLOAT3;210;FLOAT;181;FLOAT3;110;FLOAT3;169;FLOAT4;0;FLOAT4;69;FLOAT3;77
Node;AmplifyShaderEditor.LerpOp;1529;6094.467,-6632.654;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-7571.474,-2159.141;Inherit;False;MM01A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;239;-9458.926,-5610.963;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;244;-1525.534,-8312.74;Inherit;False;GlossChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1561;6296.244,-6740.922;Inherit;False;Property;_GlintHighlightToggle1;Glint Highlight;266;0;Create;False;0;0;0;False;0;False;0;0;0;True;_GLINT_HIGHLIGHT_ON;Toggle;2;Key0;Key1;Reference;544;True;False;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;242;-9574.1,-5747.827;Inherit;False;244;GlossChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;243;-9300.926,-5610.963;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-9325.322,-5811.18;Inherit;False;18;MM01A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1710;-9295.779,-5542.52;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1443;6500.138,-6637.986;Inherit;False;FleckNorm;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;241;-9094.985,-5755.197;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1711;-9090.779,-5566.52;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1712;-9109.779,-5639.52;Inherit;False;18;MM01A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1491;5232.7,-7033.944;Inherit;False;1489;InitialSpec;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1583;-7199.009,-4937.565;Inherit;False;1443;FleckNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1579;5001.6,-6729.54;Inherit;False;Property;_AffectDiffuseColor;Affect Diffuse Color;209;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1582;-7099.009,-4889.565;Inherit;False;Property;_AffectDiffuseNormals;AffectDiffuseNormals;210;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1566;5338.969,-6817.645;Inherit;False;Property;_AffectIndirectColor;AffectIndirectColor;211;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1709;-8838.779,-5747.52;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1490;5569.867,-6873.781;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1581;-6904.009,-5028.565;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1578;5216.6,-6663.54;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;214;-8485.32,-5673.946;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-8522.32,-5597.946;Inherit;False;Property;_InvertGloss;Invert Gloss;253;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1527;6072.512,-6929.836;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;338;-7354.245,-6335.094;Inherit;False;Constant;_Float25;Float 25;21;0;Create;True;0;0;0;False;0;False;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1584;-6796.209,-5132.434;Inherit;False;Property;_Keyword2;Keyword 2;266;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;544;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1572;5308.327,-6732.049;Inherit;False;FleckShape;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;213;-8266.261,-5749.987;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;698;-8574.068,-5531.772;Inherit;False;Property;_GlossMult;GlossMult;252;0;Create;True;1;Gloss;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;198;3730.206,-5350.383;Inherit;False;1274.357;1203.484;Comment;37;556;190;561;180;555;186;732;181;735;736;560;558;557;44;54;164;46;45;47;761;777;778;784;1331;1340;1343;1205;1332;1329;1330;1276;1134;1133;1132;1131;1130;1516;GGX Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1562;6314.289,-6983.431;Inherit;False;Property;_GlintHighlightToggle2;Glint Highlight;266;0;Create;False;0;0;0;False;0;False;0;0;0;True;_GLINT_HIGHLIGHT_ON;Toggle;2;Key0;Key1;Reference;544;True;False;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;-7144.714,-6348.828;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1576;-6763.313,-6237.79;Inherit;False;1572;FleckShape;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1573;5356.327,-6454.049;Inherit;False;FleckAlbedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1645;-6761.216,-6171.47;Inherit;False;542;GlintChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1589;3705.477,-5597.418;Inherit;False;1580;InitialNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;697;-8128.068,-5668.772;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;643;-6711.354,-5034.058;Inherit;False;NormalFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;760;-9279.985,-4760.734;Inherit;False;2490.12;632.1313;Comment;10;744;748;754;757;758;741;746;755;742;1860;Clear Coat Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1486;6532.272,-6913.082;Inherit;False;GlintSpecColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;337;-6898.245,-6304.094;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1577;-6891.313,-6408.79;Inherit;False;1573;FleckAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1646;-6572.216,-6266.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1585;3879.677,-5615.619;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;45;3865.577,-5128.354;Inherit;False;643;NormalFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;1684;-8131.18,-5567.124;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;748;-9062.287,-4579.181;Inherit;False;21;NormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;746;-9217.125,-4507.811;Inherit;False;Property;_ClearCoatNormalScale;Clear Coat Normal Scale;263;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;742;-8282.306,-4439.367;Inherit;False;Property;_ClearCoatNormal;Clear Coat Normal;265;1;[Enum];Create;False;0;4;None;0;Normal;1;Detail Normal;2;Both;3;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1859;-7838.337,-1390.86;Inherit;False;DetailNormUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1487;-6188.625,-6079.877;Inherit;False;1486;GlintSpecColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1575;-6534.313,-6410.79;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;1130;4257.464,-4883.995;Inherit;False;FLOAT;2;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;1586;3998.548,-5480.276;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1683;-8304.217,-5453.194;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;744;-8811.566,-4707.837;Inherit;False;Constant;_Vector2;Vector 2;47;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;747;-8847.124,-4556.912;Inherit;True;Property;_TextureSample0;Texture Sample 0;48;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;754;-9100.888,-4361.603;Inherit;False;593;DetailNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SaturateNode;749;-8075.73,-4441.332;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;751;-8074.73,-4369.332;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;755;-9213.971,-4435.162;Inherit;False;Property;_ClearCoatDetailNormalScale;Clear Coat Detail Normal Scale;264;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1860;-9112.255,-4283.221;Inherit;False;1859;DetailNormUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1488;-5875.582,-6081.917;Inherit;False;Property;_Keyword1;Keyword 1;266;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;544;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1574;-6318.025,-6401.966;Inherit;False;Property;_Keyword0;Keyword 0;266;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;544;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NegateNode;1131;4417.494,-4877.76;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;1587;4147.147,-5513.53;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1685;-8147.58,-5456.224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;753;-8853.027,-4353.031;Inherit;True;Property;_TextureSample1;Texture Sample 1;48;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;757;-7906.352,-4294.605;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;752;-7891.729,-4366.332;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;743;-7800.107,-4707.366;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1272;-1553.674,-9428.313;Inherit;False;GlintHighlightChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;-5693.358,-6085.401;Inherit;False;SpecularColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-6000.959,-6400.3;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;1133;4383.202,-4967.127;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwitchByFaceNode;1132;4566.093,-4911.013;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;735;3793.667,-4311.217;Inherit;False;Property;_GlintHighlight;Glint Highlight;268;0;Create;True;0;0;0;False;0;False;0.5;0.565;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;556;3843.156,-4238.315;Inherit;False;1272;GlintHighlightChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1588;4350.037,-5621.648;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1430;4552.984,-5536.31;Inherit;False;Property;_AffectIndirect;Affect Indirect;214;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1429;4331.885,-5498.511;Inherit;False;1443;FleckNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-7985.943,-5454.745;Inherit;False;Gloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;758;-7764.652,-4292.005;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;750;-7524.228,-4708.031;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;759;-7561.089,-4578.033;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1134;4778.083,-4961.931;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;558;3841.328,-4820.069;Inherit;False;277;ReflectionMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;560;3844.525,-4447.646;Inherit;False;246;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;778;4071.688,-4852.028;Inherit;False;776;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;784;4081.196,-4914.008;Inherit;False;782;LightCol;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;736;3846.71,-4379.952;Inherit;False;43;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1276;4097.461,-4301.174;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;557;3838.833,-4602.236;Inherit;False;42;SpecularColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;3859.084,-5197.928;Inherit;False;43;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;777;4099.062,-5309.702;Inherit;False;776;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;783;4095.196,-5378.008;Inherit;False;782;LightCol;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;3846.144,-4903.487;Inherit;False;246;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1427;4783.14,-5667.181;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;3840.452,-5058.076;Inherit;False;42;SpecularColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;3840.609,-4982.084;Inherit;False;10;Gloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;3842.947,-5275.908;Inherit;False;277;ReflectionMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;756;-7311.171,-4708.162;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;553;5088.034,-4843.559;Inherit;False;1425.021;451.9258;Comment;16;499;495;500;549;762;565;1204;1342;507;508;506;504;505;501;1341;1203;Indirect Clear Coat;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;741;-7019.007,-4706.365;Inherit;False;ClearCoatNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1863;4306.257,-4514.011;Inherit;False;GGX_Specular_Light;-1;;8327;a8c3189e23c816d4394170a4738b987b;6,318,0,329,0,322,0,339,1,369,0,326,0;13;366;FLOAT3;0,0,0;False;382;FLOAT3;0,0,0;False;359;FLOAT3;0,0,0;False;338;FLOAT;0;False;328;FLOAT3;0,0,0;False;327;FLOAT3;0,0,0;False;286;FLOAT3;0,0,0;False;30;FLOAT3;0,0,0;False;317;FLOAT3;0,0,0;False;146;FLOAT3;0,0,0;False;147;FLOAT;0;False;368;FLOAT;0;False;302;FLOAT;0;False;8;FLOAT;358;FLOAT;348;FLOAT3;336;FLOAT3;331;FLOAT3;314;FLOAT3;315;FLOAT3;0;FLOAT;316
Node;AmplifyShaderEditor.FunctionNode;1864;4310.834,-5215.458;Inherit;False;GGX_Specular_Light;-1;;8329;a8c3189e23c816d4394170a4738b987b;6,318,0,329,0,322,0,339,1,369,0,326,0;13;366;FLOAT3;0,0,0;False;382;FLOAT3;0,0,0;False;359;FLOAT3;0,0,0;False;338;FLOAT;0;False;328;FLOAT3;0,0,0;False;327;FLOAT3;0,0,0;False;286;FLOAT3;0,0,0;False;30;FLOAT3;0,0,0;False;317;FLOAT3;0,0,0;False;146;FLOAT3;0,0,0;False;147;FLOAT;0;False;368;FLOAT;0;False;302;FLOAT;0;False;8;FLOAT;358;FLOAT;348;FLOAT3;336;FLOAT3;331;FLOAT3;314;FLOAT3;315;FLOAT3;0;FLOAT;316
Node;AmplifyShaderEditor.DynamicAppendNode;1332;4694.144,-4342.206;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;1333;4909.079,-5094.867;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;762;5151.165,-4675.066;Inherit;False;741;ClearCoatNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;579;5503.016,-5905.569;Inherit;False;1349.509;379.459;Comment;15;740;739;572;544;543;547;546;737;545;37;182;177;1653;1517;1671;Final Glint;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;175;5516.828,-6681.481;Inherit;False;GlintSpec;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;732;4763.099,-4432.435;Inherit;False;GlintHighlight;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;4660.121,-5014.451;Inherit;False;ggxSpec;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;1127;5242.624,-4354.962;Inherit;False;FLOAT;2;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;739;5542.793,-5640.431;Inherit;False;732;GlintHighlight;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;5471.016,-5737.019;Inherit;False;186;ggxSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;177;5585.343,-5818.591;Inherit;False;175;GlintSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;1125;5402.654,-4348.727;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1168;-1543.378,-9335.333;Inherit;False;ClearCoatHighlightChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1518;5974.479,-5504.594;Inherit;False;Constant;_Float48;Float 48;114;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;737;6069.782,-5608.317;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwitchByFaceNode;1126;5551.253,-4381.98;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1128;5368.362,-4438.094;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1206;3654.048,-4494.437;Inherit;False;1168;ClearCoatHighlightChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;498;3661.047,-4569.473;Inherit;False;Property;_ClearCoatHighlight;Clear Coat Highlight;257;0;Create;True;0;0;0;False;0;False;0.9;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1517;6240.479,-5605.594;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1671;6077.235,-5698.993;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;555;3857.465,-4742.089;Inherit;False;7;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1129;5763.242,-4432.898;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1205;3969.048,-4535.437;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1516;4074.934,-4608.452;Inherit;False;1489;InitialSpec;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;565;5098.232,-4582.246;Inherit;False;Property;_ClearCoatReflection;Clear Coat Reflection;259;0;Create;True;0;0;0;False;0;False;1;0.95;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1790;802.5137,-1495.903;Inherit;False;2359.104;566.9634;Comment;36;1829;1828;1827;1825;1824;1823;1822;1821;1820;1819;1818;1817;1816;1815;1814;1813;1812;1811;1810;1808;1807;1805;1804;1803;1802;1801;1800;1799;1798;1797;1796;1795;1794;1793;1792;1791;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1202;-1558.334,-8015.899;Inherit;False;ClearCoatReflectionChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;545;5872.958,-5837.723;Inherit;False;186;ggxSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;546;6015.218,-5763.747;Inherit;False;542;GlintChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;740;6394.059,-5644.546;Inherit;False;Property;_GlintHighlightToggle;Glint Highlight;267;0;Create;False;0;0;0;False;0;False;0;0;0;True;_GLINT_HIGHLIGHT_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1204;5105.201,-4781.477;Inherit;False;1202;ClearCoatReflectionChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1829;897.7615,-1264.162;Inherit;False;Property;_OpacityMap;Opacity Map;269;2;[Header];[Enum];Create;False;1;;6;Map 01;0;Map 02;1;Map 03;2;Map 04;3;MainTex;5;None;4;0;True;0;False;5;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1865;4304.216,-4803.619;Inherit;False;GGX_Specular_Light;-1;;8331;a8c3189e23c816d4394170a4738b987b;6,318,0,329,0,322,0,339,1,369,1,326,0;13;366;FLOAT3;0,0,0;False;382;FLOAT3;0,0,0;False;359;FLOAT3;0,0,0;False;338;FLOAT;0;False;328;FLOAT3;0,0,0;False;327;FLOAT3;0,0,0;False;286;FLOAT3;0,0,0;False;30;FLOAT3;0,0,0;False;317;FLOAT3;0,0,0;False;146;FLOAT3;0,0,0;False;147;FLOAT;0;False;368;FLOAT;0;False;302;FLOAT;0;False;8;FLOAT;358;FLOAT;348;FLOAT3;336;FLOAT3;331;FLOAT3;314;FLOAT3;315;FLOAT3;0;FLOAT;316
Node;AmplifyShaderEditor.GetLocalVarNode;547;6213.552,-5854.633;Inherit;False;186;ggxSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;543;6216.41,-5778.868;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;499;5187.034,-4504.633;Inherit;False;246;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1203;5422.201,-4776.477;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1340;4676.104,-4769.536;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;1791;1156.564,-1261.829;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1792;1154.564,-1192.829;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1793;867.3865,-1338.865;Inherit;False;296;MM02RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1794;864.3807,-1415.093;Inherit;False;295;MM01RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1331;4669.144,-4668.206;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;544;6427.516,-5855.569;Inherit;False;Property;_SpecularGlint;Specular Glint;266;0;Create;True;0;0;0;False;0;False;0;0;0;True;_GLINT_ON;Toggle;2;Key0;Key1;Create;True;False;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.IndirectSpecularLight;495;5472.814,-4600.535;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1342;5584.804,-4469.236;Inherit;False;Constant;_Float1;Float 1;81;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1343;4638.646,-5110.267;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;180;4828.821,-4762.181;Inherit;False;CustomIndirect;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;1795;1325.564,-1193.829;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1796;1316.564,-1261.829;Inherit;False;412;MM03RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1797;1326.564,-1122.83;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1798;1156.389,-1389.865;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;581;6689.426,-4773.174;Inherit;False;846.0758;317.3114;Comment;7;580;568;573;566;567;569;571;Specular Clear Coat;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;561;4807.481,-4672.095;Inherit;False;ggxClearCoat;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;572;6595.419,-5852.736;Inherit;False;GlintFinal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;500;5507.035,-4677.633;Inherit;False;180;CustomIndirect;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;1341;5778.504,-4556.336;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;4905.994,-5209.873;Inherit;False;IndirectSpec;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1799;1576.564,-1259.829;Inherit;False;420;MM04RGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1800;1588.53,-1375.564;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1801;1589.564,-1189.829;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1802;1593.164,-974.0739;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;568;6762.311,-4650.267;Inherit;False;Constant;_Float21;Float 0;33;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;566;6739.426,-4730.403;Inherit;False;561;ggxClearCoat;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;573;6778.06,-4568.863;Inherit;False;572;GlintFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;501;5727.928,-4650.633;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;505;5728.496,-4724.84;Inherit;False;Constant;_Float0;Float 0;33;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;507;5715.114,-4793.559;Inherit;False;192;IndirectSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1803;1591.164,-1121.074;Inherit;False;Constant;_Float54;Float 29;58;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1804;1840.529,-1373.564;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1805;1592.164,-1046.074;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1806;1783.465,-835.2646;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;567;6994.313,-4601.267;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;569;6994.931,-4692.986;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;504;5960.495,-4675.84;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;506;5961.114,-4767.559;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;677;-6446.111,-5198.323;Inherit;False;1085.658;378.5127;Comment;2;687;688;Emission Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1807;1746.565,-976.5648;Inherit;False;7;MainTexRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1808;1834.164,-1103.074;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1809;1782.465,-907.265;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;571;7174.871,-4656.902;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;508;6141.054,-4731.475;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;685;-6207.609,-5115.699;Inherit;False;590;EmissionRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;687;-6234.609,-5040.699;Inherit;False;676;EmissionMaskChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1810;1970.165,-993.4651;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1811;1795.87,-1172.574;Inherit;False;Property;_OpacityChannel;Opacity Channel;271;1;[Enum];Create;False;0;4;Red;0;Green;1;Blue;2;Alpha;3;0;True;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;281;-9285.328,-5207.07;Inherit;False;1085.658;378.5127;Comment;9;289;288;287;286;285;284;283;282;402;Specular Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;548;5961.547,-6372.754;Inherit;False;1243.437;387.9226;Comment;9;188;36;586;574;575;576;578;582;577;Final Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;7293.501,-4656.457;Inherit;False;ClearCoatSpecular;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;200;5077.198,-5344.86;Inherit;False;1312.125;373.7759;Comment;8;550;511;194;195;73;503;509;510;Final Indirect Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;549;6269.056,-4732.918;Inherit;False;IndirectClearCoat;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;-5960.609,-5115.699;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;1812;2050.77,-1441.675;Inherit;False;FLOAT;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1813;2064.77,-1168.675;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1814;2050.77,-1370.675;Inherit;False;FLOAT;1;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1815;2067.77,-1297.675;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1816;2064.77,-1099.676;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;493;-1559.892,-8169.281;Inherit;False;ClearCoatChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;-1513.201,-8702.202;Inherit;False;SpecularMaskChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;-8886.05,-5038.718;Inherit;False;291;SpecularMaskChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;577;6078.755,-6094.221;Inherit;False;493;ClearCoatChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;582;6073.168,-6176.331;Inherit;False;580;ClearCoatSpecular;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;578;6085.467,-6260.397;Inherit;False;572;GlintFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;511;5127.176,-5102.847;Inherit;False;493;ClearCoatChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;550;5128.646,-5177.507;Inherit;False;549;IndirectClearCoat;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;5154.938,-5248.915;Inherit;False;192;IndirectSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;688;-5793.609,-5117.699;Inherit;False;EmissionFinal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1817;2268.769,-1422.675;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1818;2260.769,-1299.675;Inherit;False;FLOAT;2;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1819;2272.769,-1227.675;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1820;2256.769,-1076.676;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1821;2257.769,-1149.675;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1076;-1521.133,-9097.02;Inherit;False;GlowMask2Channel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1042;-1509.618,-9023.797;Inherit;False;GlowMask1Channel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1009;-1509.601,-8947.381;Inherit;False;GlowMask0Channel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1110;-1502.519,-9174.77;Inherit;False;GlowMask3Channel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;402;-8432.971,-5162.108;Inherit;False;SpecularMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;576;6325.767,-6229.603;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;575;6300.651,-6313.146;Inherit;False;572;GlintFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;509;5379.057,-5189.546;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;510;5364.176,-5260.846;Inherit;False;192;IndirectSpec;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;591;-10015.99,-3215.344;Inherit;False;688;EmissionFinal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1115;-10059.38,-3374.352;Inherit;False;1076;GlowMask2Channel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1114;-10059.38,-3450.352;Inherit;False;1042;GlowMask1Channel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1113;-10055.68,-3522.17;Inherit;False;1009;GlowMask0Channel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1116;-10057.38,-3305.352;Inherit;False;1110;GlowMask3Channel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1822;2497.769,-1420.675;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1823;2487.769,-1230.675;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1824;2488.769,-1301.675;Inherit;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;574;6530.651,-6251.146;Inherit;False;Property;_ClearCoat1;Clear Coat;256;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;503;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;6532.515,-6154.366;Inherit;False;402;SpecularMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;503;5667.337,-5251.328;Inherit;False;Property;_ClearCoat;Clear Coat;256;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;1117;-9777.38,-3454.352;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;886;-9796.092,-3237.98;Inherit;False;Property;_EnableEmission;Emission;234;0;Create;False;0;0;0;False;0;False;0;0;0;True;_EMISSION;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1825;2710.682,-1422.134;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1826;2257.465,-916.7647;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;586;6783.801,-6245.819;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;73;5879.576,-5249.74;Inherit;False;Property;_UNITY_PASS_FORWARD_ADD;UNITY_PASS_FORWARD_ADD;39;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;ToggleOff;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1373;4810.437,-841.1832;Inherit;False;Property;_TileDiscardUV;TileDiscardUV;310;1;[Enum];Create;True;0;5;UV0;0;UV1;1;UV2;2;UV3;3;UV4;4;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1694;-9583.693,-3302.96;Inherit;False;Luma Glow Properties;49;;8228;601d9734366b2cb4e9b77694fc25ef31;1,260,0;3;266;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;155;FLOAT3;0,0,0;False;3;FLOAT;244;FLOAT4;183;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;1827;2819.065,-1300.265;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1832;-9291.732,-2309.385;Inherit;False;MainTexColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;188;6940.674,-6243.694;Inherit;False;SpecularFinal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;195;6154.94,-5249.196;Inherit;False;IndirectSpecFinal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;769;5144.872,-619.409;Inherit;False;Constant;_Float26;Float 26;49;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;883;-9277.568,-3279.069;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;1608;4996.493,-841.9552;Inherit;False;UV Channel Select;-1;;8314;756457f5c2398324eb74b053d38f83bd;1,50,0;2;2;SAMPLER2D;0;False;14;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;190;4658.432,-5157.637;Inherit;False;AlbedoFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1828;2923.601,-1415.3;Inherit;False;OpacityChannel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1745;5782.14,-1002.616;Inherit;False;1832;MainTexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;189;5053.949,-1203.042;Inherit;False;188;SpecularFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;5062.086,-1041.603;Inherit;False;195;IndirectSpecFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;1746;6038.14,-1004.616;Inherit;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;159;5229.119,-771.5396;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;770;5287.872,-626.4091;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1406;5226.854,-843.709;Inherit;False;UVTileDiscard;277;;8315;495696ca07f989c468e0b68e1fa68101;0;1;19;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1322;-9152.007,-3277.63;Inherit;False;Emiss;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;191;5073.197,-1125.172;Inherit;False;190;AlbedoFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1753;7560.937,-381.1659;Inherit;False;637.5515;488.855;Blend RGB;6;1789;1788;1787;1767;1766;1759;;0,0,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1830;5803.223,-907.6663;Inherit;False;1828;OpacityChannel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1674;-9520.13,-5407.657;Inherit;False;1580;InitialNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-7577.803,-2008.305;Inherit;False;MM02R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1734;5518.531,-1010.4;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1740;5726.531,-1173.4;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;4;False;3;FLOAT;0;False;4;FLOAT;0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1739;5982.531,-1177.4;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1742;6097.531,-1171.4;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1743;6333.531,-1170.4;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1654;5198.351,-5474.229;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1655;5386.851,-5496.329;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1653;5679.281,-5735.711;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1330;4475.396,-5289.907;Inherit;False;Constant;_Float22;Float 22;81;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1329;4693.396,-5307.907;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;4858.023,-5315.383;Inherit;False;CustomSpec;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1412;4343.665,-6001.409;Inherit;False;Property;_GlintFrequency;GlintFrequency;213;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;768;5530.872,-841.409;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1526;4258.53,-6624.728;Inherit;False;10;Gloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;780;4283.781,-6300.116;Inherit;False;776;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1328;5300.577,-6154.941;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LuminanceNode;1324;5102.573,-6112.96;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;269;-7630.976,-5550.624;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;271;-7447.938,-5478.258;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;272;-7453.938,-5550.258;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;278;-7431.028,-5652.988;Inherit;False;Constant;_Float23;Float 23;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;273;-7251.624,-5669.77;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;275;-7188.938,-5481.258;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;-9235.327,-5037.924;Inherit;False;212;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;283;-9052.29,-4965.558;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;284;-9058.29,-5037.558;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-9035.38,-5140.288;Inherit;False;Constant;_Float24;Float 23;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;285;-8855.976,-5157.07;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;289;-8793.29,-4968.558;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;286;-8599.288,-5156.557;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1344;5266.398,-1371.774;Inherit;False;195;IndirectSpecFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1327;5271.634,-1499.762;Inherit;False;188;SpecularFinal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;1345;5493.398,-1375.774;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1334;5496.548,-1483.768;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1336;5643.205,-1492.428;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1347;5662.867,-1375.895;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1346;5820.398,-1442.774;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;761;3857.896,-4673.232;Inherit;False;741;ClearCoatNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-7570.474,-2238.141;Inherit;False;MM01B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;-7577.408,-1835.56;Inherit;False;MM02B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;-7576.618,-1746.075;Inherit;False;MM02A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;407;-6514.665,-2392.835;Inherit;False;MM03R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;408;-6513.874,-2303.348;Inherit;False;MM03G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;409;-6514.269,-2220.092;Inherit;False;MM03B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;410;-6513.479,-2130.606;Inherit;False;MM03A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;415;-6513.906,-1977.374;Inherit;False;MM04R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;416;-6513.115,-1887.887;Inherit;False;MM04G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;417;-6513.509,-1804.631;Inherit;False;MM04B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;418;-6512.719,-1715.145;Inherit;False;MM04A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;966;-7145.192,-1629.061;Inherit;False;Property;_GlobalColor0;Global Color 0;233;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;967;-7149.569,-1461.658;Inherit;False;Property;_GlobalColor1;Global Color 1;232;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;974;-7138.453,-1271.676;Inherit;False;Property;_GlobalColor2;Global Color 2;231;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;975;-7138.453,-1052.796;Inherit;False;Property;_GlobalColor3;Global Color 3;230;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;970;-6915.424,-1626.873;Inherit;False;GlobalColor0;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;971;-6913.235,-1463.847;Inherit;False;GlobalColor1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;972;-6911.664,-1276.219;Inherit;False;GlobalColor2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;973;-6898.217,-1056.245;Inherit;False;GlobalColor3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1124;-6486.82,-1611.824;Inherit;False;Property;_Culling;Culling;48;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1278;-9256.417,-2899.682;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1279;-9141.417,-2904.682;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1280;-9613.907,-2891.097;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1281;-9393.286,-2917.828;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1282;-9668.417,-2815.682;Inherit;False;Detect Light;-1;;8316;ca949bbda0856d040a3b3a723d67d4ef;0;0;2;FLOAT;0;FLOAT;10
Node;AmplifyShaderEditor.OneMinusNode;1283;-9430.286,-2815.828;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1284;-9256.288,-2807.134;Inherit;False;776;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1285;-9256.691,-2740.051;Inherit;False;643;NormalFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1321;-9291.106,-2669.231;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1323;5814.732,-1269.837;Inherit;False;1322;Emiss;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;1335;6028.548,-1440.768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1355;6191.769,-1454.661;Inherit;False;SpecularAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1357;-6442.47,-1527.803;Inherit;False;Property;_BlendOPdst;_BlendOPdst;262;0;Create;True;0;0;0;True;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1358;-6664.266,-1437.581;Inherit;False;Property;_BlendModeIndex;_BlendModeIndex;258;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1359;-6440.47,-1438.803;Inherit;False;Property;_BlendOPIndex;_BlendOPIndex;261;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1356;-6636.47,-1520.803;Inherit;False;Property;_BlendOPsrc;_BlendOPsrc;260;0;Create;True;0;0;0;True;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1363;-6436.512,-1357.944;Inherit;False;Property;_ShowMaps;ShowMaps;219;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1364;-8070.787,-3007.886;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;276;-6994.937,-5669.257;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1360;-6594.919,-1355.498;Inherit;False;Property;_ShowMain;ShowMain;229;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1388;-6605.261,-1271.583;Inherit;False;Property;_ShowLighting;ShowLighting;221;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1394;-6412.515,-1275.131;Inherit;False;Property;_ShowEmission;ShowEmission;223;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1396;-6402.515,-1197.131;Inherit;False;Property;_ShowEmissionMain;ShowEmissionMain;222;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1395;-6612.515,-1196.131;Inherit;False;Property;_ShowEmission01;ShowEmission01;228;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1401;-6620.369,-1116.484;Inherit;False;Property;_ShowEmission02;ShowEmission02;226;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1402;-6410.369,-1117.484;Inherit;False;Property;_ShowEmission03;ShowEmission03;227;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1403;-6627.369,-1045.484;Inherit;False;Property;_ShowEmission04;ShowEmission04;225;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1404;-6406.369,-1041.484;Inherit;False;Property;_ShowTileDiscard;ShowTileDiscard;224;0;Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;3871.622,-6137.979;Inherit;False;Property;_GlintIntensity;Glint Intensity;270;0;Create;True;1;Glinty Specular;0;0;True;0;False;1;1.15;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1426;5531.882,-6626.83;Inherit;False;FleckIndirect;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1417;4758.018,-5987.908;Inherit;False;Property;_GlintIgnoreNormals;Glint Ignore Normals;41;1;[ToggleUI];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;5818.331,-5603.343;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;250;-6279.584,-5566.774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;5543.884,-1146.809;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;1747;6468.925,-1154.496;Inherit;False;Property;_Keyword3;Keyword 3;119;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_SHADOWCASTER;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StickyNoteNode;1759;7816.918,-320.892;Inherit;False;316.5269;103;_SourceBlendRGB;;0,0,0,1;Unity.Engine Enum Class$UnityEngine.Rendering.BlendMode$;0;0
Node;AmplifyShaderEditor.StickyNoteNode;1766;7819.238,-191.3367;Inherit;False;289.5269;100;_DestinationBlendRGB;;0,0,0,1;Unity.Engine Enum Class$UnityEngine.Rendering.BlendMode$;0;0
Node;AmplifyShaderEditor.StickyNoteNode;1767;7815.238,-63.33667;Inherit;False;285.5269;109.007;_BlendOpRGB;;0,0,0,1;Unity.Engine Enum Class$UnityEngine.Rendering.BlendOp$;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1789;7593.019,-319.0129;Inherit;False;Property;_SourceBlendRGB;Source Blend RGB;208;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1788;7591.629,-191.5297;Inherit;False;Property;_DestinationBlendRGB;Destination Blend RGB;207;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1787;7593.819,-67.42957;Inherit;False;Property;_BlendOpRGB;Blend Op RGB;206;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1831;6147.223,-913.6663;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1833;5819.979,-801.0232;Inherit;False;Property;_MaskClipValue;MaskClipValue;205;0;Create;True;0;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1732;5519.531,-1236.4;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;6812.637,-1320.613;Float;False;True;-1;4;UmbraShaderUI;0;0;CustomLighting;Furality/Umbra Shader/Umbra Cutout;False;False;False;False;False;False;True;False;True;False;True;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;True;_SourceBlendRGB;10;True;_DestinationBlendRGB;0;0;False;;0;False;;0;True;_BlendOpRGB;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;1;VRCFallback=Cutout;False;0;0;True;_Culling;-1;0;True;_MaskClipValue;1;Include;;True;1ec20832dfbb48343b8e0764e0864276;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1675;0;1673;0
WireConnection;1676;0;1673;0
WireConnection;1677;0;1675;0
WireConnection;1677;1;1675;0
WireConnection;1678;0;1676;0
WireConnection;1678;1;1676;0
WireConnection;51;0;50;0
WireConnection;12;0;11;0
WireConnection;411;0;405;0
WireConnection;1679;0;1677;0
WireConnection;1679;1;1678;0
WireConnection;1604;2;12;0
WireConnection;1604;14;1366;0
WireConnection;1605;2;51;0
WireConnection;1605;14;1368;0
WireConnection;1606;2;411;0
WireConnection;1606;14;1370;0
WireConnection;419;0;413;0
WireConnection;1607;2;413;0
WireConnection;1607;14;1371;0
WireConnection;1680;0;1679;0
WireConnection;9;0;12;0
WireConnection;9;1;1604;0
WireConnection;52;0;51;0
WireConnection;52;1;1605;0
WireConnection;406;0;411;0
WireConnection;406;1;1606;0
WireConnection;414;0;419;0
WireConnection;414;1;1607;0
WireConnection;1681;0;1680;0
WireConnection;1681;1;1682;0
WireConnection;295;0;9;0
WireConnection;296;0;52;0
WireConnection;412;0;406;0
WireConnection;420;0;414;0
WireConnection;212;0;211;0
WireConnection;1835;0;1681;0
WireConnection;16;0;9;1
WireConnection;1852;348;1854;0
WireConnection;1852;347;1853;0
WireConnection;1852;167;1855;0
WireConnection;1852;168;1856;0
WireConnection;1852;169;1857;0
WireConnection;1852;170;1858;0
WireConnection;588;0;587;0
WireConnection;228;0;227;0
WireConnection;230;0;227;0
WireConnection;232;0;1852;0
WireConnection;589;0;588;0
WireConnection;226;0;225;0
WireConnection;226;2;228;0
WireConnection;231;0;230;0
WireConnection;1707;0;230;0
WireConnection;593;0;592;0
WireConnection;646;0;645;0
WireConnection;646;1;589;0
WireConnection;6;0;4;0
WireConnection;229;0;226;0
WireConnection;229;1;233;0
WireConnection;229;2;231;0
WireConnection;1708;0;1707;0
WireConnection;676;0;1852;521
WireConnection;21;0;20;0
WireConnection;1610;2;593;0
WireConnection;1610;14;1393;0
WireConnection;590;0;646;0
WireConnection;5;0;6;0
WireConnection;1705;0;229;0
WireConnection;1705;1;1706;0
WireConnection;1705;2;1708;0
WireConnection;22;0;21;0
WireConnection;22;5;38;0
WireConnection;595;0;593;0
WireConnection;595;1;1610;0
WireConnection;595;5;594;0
WireConnection;692;0;693;0
WireConnection;692;1;690;0
WireConnection;1361;0;5;0
WireConnection;1361;1;1362;0
WireConnection;695;0;1705;0
WireConnection;695;1;694;0
WireConnection;23;0;22;0
WireConnection;596;0;595;0
WireConnection;696;0;695;0
WireConnection;689;0;1361;0
WireConnection;689;1;691;0
WireConnection;689;2;692;0
WireConnection;923;0;1852;527
WireConnection;7;0;689;0
WireConnection;224;0;696;0
WireConnection;626;0;1852;519
WireConnection;637;0;640;0
WireConnection;637;1;638;0
WireConnection;925;0;222;0
WireConnection;925;1;924;0
WireConnection;1500;0;1498;0
WireConnection;1501;0;1498;0
WireConnection;249;0;247;0
WireConnection;217;0;52;2
WireConnection;1482;0;1852;532
WireConnection;257;0;1852;517
WireConnection;639;0;642;0
WireConnection;639;1;637;0
WireConnection;639;2;641;0
WireConnection;223;0;925;0
WireConnection;1502;0;1499;0
WireConnection;1502;2;1501;0
WireConnection;1504;0;1500;0
WireConnection;2;0;40;0
WireConnection;2;1;41;0
WireConnection;1386;0;222;0
WireConnection;1386;1;1385;0
WireConnection;216;0;9;2
WireConnection;1724;0;249;0
WireConnection;253;0;249;0
WireConnection;1580;0;639;0
WireConnection;1387;0;1386;0
WireConnection;220;0;2;1
WireConnection;220;1;223;0
WireConnection;263;0;260;0
WireConnection;262;0;260;0
WireConnection;1505;0;1502;0
WireConnection;1505;1;1503;0
WireConnection;1505;2;1504;0
WireConnection;1725;0;1724;0
WireConnection;254;0;255;0
WireConnection;254;1;252;0
WireConnection;254;2;253;0
WireConnection;1648;0;1390;0
WireConnection;264;0;220;0
WireConnection;264;1;1387;0
WireConnection;264;2;263;0
WireConnection;266;0;262;0
WireConnection;1507;0;1505;0
WireConnection;1507;1;1448;0
WireConnection;1723;0;254;0
WireConnection;1723;1;248;0
WireConnection;1723;2;1725;0
WireConnection;279;0;1852;518
WireConnection;1389;0;1723;0
WireConnection;1389;1;1648;0
WireConnection;267;0;264;0
WireConnection;267;1;220;0
WireConnection;267;2;266;0
WireConnection;1508;0;1507;0
WireConnection;1240;0;1852;529
WireConnection;1861;23;1688;0
WireConnection;1489;0;267;0
WireConnection;277;0;274;0
WireConnection;1509;0;1508;0
WireConnection;1510;0;223;0
WireConnection;246;0;1389;0
WireConnection;1511;0;1387;0
WireConnection;776;0;1861;21
WireConnection;782;0;1861;0
WireConnection;1633;0;1852;531
WireConnection;1422;0;34;0
WireConnection;1275;0;60;0
WireConnection;1275;1;33;0
WireConnection;542;0;1852;516
WireConnection;1862;124;1514;0
WireConnection;1862;125;1515;0
WireConnection;1862;123;1513;0
WireConnection;1862;102;1483;0
WireConnection;1862;63;1436;0
WireConnection;1862;71;1437;0
WireConnection;1862;191;1635;0
WireConnection;1862;72;1435;0
WireConnection;1862;73;1434;0
WireConnection;1862;51;1414;0
WireConnection;1862;60;644;0
WireConnection;1862;74;1439;0
WireConnection;1862;75;1438;0
WireConnection;1862;59;1275;0
WireConnection;1862;62;1410;0
WireConnection;1862;57;1411;0
WireConnection;1862;54;1422;0
WireConnection;1862;58;35;0
WireConnection;1862;55;1424;0
WireConnection;1529;0;1531;0
WireConnection;1529;1;1862;77
WireConnection;1529;2;1528;0
WireConnection;18;0;9;4
WireConnection;239;0;238;0
WireConnection;244;0;1852;515
WireConnection;1561;1;1531;0
WireConnection;1561;0;1529;0
WireConnection;243;0;239;0
WireConnection;1710;0;239;0
WireConnection;1443;0;1561;0
WireConnection;241;0;236;0
WireConnection;241;1;242;0
WireConnection;241;2;243;0
WireConnection;1711;0;1710;0
WireConnection;1709;0;241;0
WireConnection;1709;1;1712;0
WireConnection;1709;2;1711;0
WireConnection;1490;0;1491;0
WireConnection;1490;1;1862;110
WireConnection;1490;2;1566;0
WireConnection;1581;0;639;0
WireConnection;1581;1;1583;0
WireConnection;1581;2;1582;0
WireConnection;1578;0;1579;0
WireConnection;1578;1;1862;181
WireConnection;214;0;1709;0
WireConnection;1527;0;1491;0
WireConnection;1527;1;1490;0
WireConnection;1527;2;1528;0
WireConnection;1584;1;639;0
WireConnection;1584;0;1581;0
WireConnection;1572;0;1578;0
WireConnection;213;0;1709;0
WireConnection;213;1;214;0
WireConnection;213;2;215;0
WireConnection;1562;1;1491;0
WireConnection;1562;0;1527;0
WireConnection;340;0;338;0
WireConnection;340;1;40;0
WireConnection;1573;0;1862;169
WireConnection;697;0;213;0
WireConnection;697;1;698;0
WireConnection;643;0;1584;0
WireConnection;1486;0;1562;0
WireConnection;337;0;340;0
WireConnection;337;1;2;0
WireConnection;1646;0;1576;0
WireConnection;1646;1;1645;0
WireConnection;1585;0;1589;0
WireConnection;1684;0;697;0
WireConnection;1859;0;1610;0
WireConnection;1575;0;337;0
WireConnection;1575;1;1577;0
WireConnection;1575;2;1646;0
WireConnection;1130;0;45;0
WireConnection;1586;0;1585;2
WireConnection;1683;0;1684;0
WireConnection;1683;1;1681;0
WireConnection;747;0;748;0
WireConnection;747;5;746;0
WireConnection;749;0;742;0
WireConnection;751;0;742;0
WireConnection;1488;1;267;0
WireConnection;1488;0;1487;0
WireConnection;1574;1;337;0
WireConnection;1574;0;1575;0
WireConnection;1131;0;1130;0
WireConnection;1587;0;1585;2
WireConnection;1587;1;1586;0
WireConnection;1685;0;1683;0
WireConnection;753;0;754;0
WireConnection;753;1;1860;0
WireConnection;753;5;755;0
WireConnection;757;0;751;0
WireConnection;752;0;751;0
WireConnection;743;0;744;0
WireConnection;743;1;747;0
WireConnection;743;2;749;0
WireConnection;1272;0;1852;530
WireConnection;42;0;1488;0
WireConnection;43;0;1574;0
WireConnection;1133;0;45;0
WireConnection;1132;0;1130;0
WireConnection;1132;1;1131;0
WireConnection;1588;0;1585;0
WireConnection;1588;1;1585;1
WireConnection;1588;2;1587;0
WireConnection;10;0;1685;0
WireConnection;758;0;757;0
WireConnection;750;0;743;0
WireConnection;750;1;753;0
WireConnection;750;2;752;0
WireConnection;759;0;747;0
WireConnection;759;1;753;0
WireConnection;1134;0;1133;0
WireConnection;1134;2;1132;0
WireConnection;1276;0;735;0
WireConnection;1276;1;556;0
WireConnection;1427;0;1588;0
WireConnection;1427;1;1429;0
WireConnection;1427;2;1430;0
WireConnection;756;0;750;0
WireConnection;756;1;759;0
WireConnection;756;2;758;0
WireConnection;741;0;756;0
WireConnection;1863;338;558;0
WireConnection;1863;328;784;0
WireConnection;1863;327;778;0
WireConnection;1863;286;736;0
WireConnection;1863;30;1134;0
WireConnection;1863;146;557;0
WireConnection;1863;147;1276;0
WireConnection;1863;302;560;0
WireConnection;1864;359;1427;0
WireConnection;1864;338;164;0
WireConnection;1864;328;783;0
WireConnection;1864;327;777;0
WireConnection;1864;286;44;0
WireConnection;1864;30;1134;0
WireConnection;1864;146;46;0
WireConnection;1864;147;47;0
WireConnection;1864;302;54;0
WireConnection;1332;0;1863;0
WireConnection;1332;3;1863;348
WireConnection;1333;0;1864;0
WireConnection;1333;3;1864;348
WireConnection;175;0;1862;0
WireConnection;732;0;1332;0
WireConnection;186;0;1333;0
WireConnection;1127;0;762;0
WireConnection;1125;0;1127;0
WireConnection;1168;0;1852;528
WireConnection;737;0;177;0
WireConnection;737;1;739;0
WireConnection;737;2;182;0
WireConnection;1126;0;1127;0
WireConnection;1126;1;1125;0
WireConnection;1128;0;762;0
WireConnection;1517;0;737;0
WireConnection;1517;1;1518;0
WireConnection;1671;0;177;0
WireConnection;1671;1;182;0
WireConnection;1129;0;1128;0
WireConnection;1129;2;1126;0
WireConnection;1205;0;498;0
WireConnection;1205;1;1206;0
WireConnection;1202;0;1852;533
WireConnection;740;1;1671;0
WireConnection;740;0;1517;0
WireConnection;1865;338;558;0
WireConnection;1865;328;784;0
WireConnection;1865;327;778;0
WireConnection;1865;286;555;0
WireConnection;1865;30;1129;0
WireConnection;1865;146;1516;0
WireConnection;1865;147;1205;0
WireConnection;1865;368;565;0
WireConnection;1865;302;560;0
WireConnection;543;0;545;0
WireConnection;543;1;740;0
WireConnection;543;2;546;0
WireConnection;1203;0;1204;0
WireConnection;1203;1;565;0
WireConnection;1340;0;1865;336
WireConnection;1340;3;1865;358
WireConnection;1791;0;1829;0
WireConnection;1792;0;1829;0
WireConnection;1331;0;1865;0
WireConnection;1331;3;1865;348
WireConnection;544;1;547;0
WireConnection;544;0;543;0
WireConnection;495;0;1129;0
WireConnection;495;1;1203;0
WireConnection;495;2;499;0
WireConnection;1343;0;1864;315
WireConnection;1343;3;1864;358
WireConnection;180;0;1340;0
WireConnection;1795;0;1792;0
WireConnection;1797;0;1792;0
WireConnection;1798;0;1794;0
WireConnection;1798;1;1793;0
WireConnection;1798;2;1791;0
WireConnection;561;0;1331;0
WireConnection;572;0;544;0
WireConnection;1341;0;495;0
WireConnection;1341;3;1342;0
WireConnection;192;0;1343;0
WireConnection;1800;0;1798;0
WireConnection;1800;1;1796;0
WireConnection;1800;2;1795;0
WireConnection;1801;0;1797;0
WireConnection;1802;0;1797;0
WireConnection;501;0;500;0
WireConnection;501;1;1341;0
WireConnection;1804;0;1800;0
WireConnection;1804;1;1799;0
WireConnection;1804;2;1801;0
WireConnection;1805;0;1802;0
WireConnection;1806;0;1802;0
WireConnection;567;0;568;0
WireConnection;567;1;573;0
WireConnection;569;0;566;0
WireConnection;569;1;568;0
WireConnection;504;0;505;0
WireConnection;504;1;501;0
WireConnection;506;0;507;0
WireConnection;506;1;505;0
WireConnection;1808;0;1804;0
WireConnection;1808;1;1803;0
WireConnection;1808;2;1805;0
WireConnection;1809;0;1806;0
WireConnection;571;0;569;0
WireConnection;571;1;567;0
WireConnection;508;0;506;0
WireConnection;508;1;504;0
WireConnection;1810;0;1808;0
WireConnection;1810;1;1807;0
WireConnection;1810;2;1809;0
WireConnection;580;0;571;0
WireConnection;549;0;508;0
WireConnection;686;0;685;0
WireConnection;686;1;687;0
WireConnection;1812;0;1810;0
WireConnection;1813;0;1811;0
WireConnection;1814;0;1810;0
WireConnection;1815;0;1810;0
WireConnection;1816;0;1811;0
WireConnection;493;0;1852;522
WireConnection;291;0;1852;520
WireConnection;688;0;686;0
WireConnection;1817;0;1812;0
WireConnection;1817;1;1814;0
WireConnection;1817;2;1813;0
WireConnection;1818;0;1815;0
WireConnection;1819;0;1815;0
WireConnection;1820;0;1816;0
WireConnection;1821;0;1816;0
WireConnection;1076;0;1852;525
WireConnection;1042;0;1852;524
WireConnection;1009;0;1852;523
WireConnection;1110;0;1852;526
WireConnection;402;0;288;0
WireConnection;576;0;578;0
WireConnection;576;1;582;0
WireConnection;576;2;577;0
WireConnection;509;0;194;0
WireConnection;509;1;550;0
WireConnection;509;2;511;0
WireConnection;1822;0;1817;0
WireConnection;1822;1;1818;0
WireConnection;1822;2;1821;0
WireConnection;1823;0;1820;0
WireConnection;1824;0;1819;0
WireConnection;574;1;575;0
WireConnection;574;0;576;0
WireConnection;503;1;510;0
WireConnection;503;0;509;0
WireConnection;1117;0;1113;0
WireConnection;1117;1;1114;0
WireConnection;1117;2;1115;0
WireConnection;1117;3;1116;0
WireConnection;886;0;591;0
WireConnection;1825;0;1822;0
WireConnection;1825;1;1824;0
WireConnection;1825;2;1823;0
WireConnection;1826;0;1809;0
WireConnection;586;0;574;0
WireConnection;586;1;36;0
WireConnection;73;1;503;0
WireConnection;1694;266;1117;0
WireConnection;1694;1;886;0
WireConnection;1827;0;1825;0
WireConnection;1827;1;1824;0
WireConnection;1827;2;1826;0
WireConnection;1832;0;1362;0
WireConnection;188;0;586;0
WireConnection;195;0;73;0
WireConnection;883;0;1694;183
WireConnection;883;1;1694;0
WireConnection;1608;14;1373;0
WireConnection;190;0;1864;314
WireConnection;1828;0;1827;0
WireConnection;1746;0;1745;0
WireConnection;770;0;769;0
WireConnection;770;1;769;0
WireConnection;1406;19;1608;0
WireConnection;1322;0;883;0
WireConnection;53;0;52;1
WireConnection;1734;0;196;0
WireConnection;1740;0;1732;0
WireConnection;1739;0;1740;0
WireConnection;1739;1;1734;0
WireConnection;1742;0;1739;0
WireConnection;1743;0;1742;0
WireConnection;1743;1;1831;0
WireConnection;1654;0;1864;358
WireConnection;1655;0;1654;0
WireConnection;1653;0;182;0
WireConnection;1329;0;1864;331
WireConnection;1329;3;1330;0
WireConnection;181;0;1329;0
WireConnection;768;0;1406;0
WireConnection;768;2;770;0
WireConnection;768;3;159;0
WireConnection;1328;0;1862;0
WireConnection;1328;1;1862;0
WireConnection;1328;2;1862;0
WireConnection;1328;3;1862;0
WireConnection;1324;0;1862;0
WireConnection;271;0;269;0
WireConnection;272;0;269;0
WireConnection;273;0;278;0
WireConnection;273;1;278;0
WireConnection;273;2;272;0
WireConnection;275;0;271;0
WireConnection;283;0;282;0
WireConnection;284;0;282;0
WireConnection;285;0;287;0
WireConnection;285;1;287;0
WireConnection;285;2;284;0
WireConnection;289;0;283;0
WireConnection;286;0;285;0
WireConnection;286;1;288;0
WireConnection;286;2;289;0
WireConnection;1345;0;1344;0
WireConnection;1334;0;1327;0
WireConnection;1336;0;1334;0
WireConnection;1347;0;1345;0
WireConnection;1346;0;1336;0
WireConnection;1346;1;1347;0
WireConnection;17;0;9;3
WireConnection;219;0;52;3
WireConnection;218;0;52;4
WireConnection;407;0;406;1
WireConnection;408;0;406;2
WireConnection;409;0;406;3
WireConnection;410;0;406;4
WireConnection;415;0;414;1
WireConnection;416;0;414;2
WireConnection;417;0;414;3
WireConnection;418;0;414;4
WireConnection;970;0;966;0
WireConnection;971;0;967;0
WireConnection;972;0;974;0
WireConnection;973;0;975;0
WireConnection;1278;0;1281;0
WireConnection;1278;1;1283;0
WireConnection;1279;0;1278;0
WireConnection;1281;1;1280;0
WireConnection;1283;0;1282;0
WireConnection;1335;0;1346;0
WireConnection;1355;0;1335;0
WireConnection;276;0;274;0
WireConnection;276;1;274;0
WireConnection;276;2;275;0
WireConnection;1426;0;1862;69
WireConnection;37;0;177;0
WireConnection;37;1;1655;0
WireConnection;250;0;247;0
WireConnection;56;0;189;0
WireConnection;56;1;191;0
WireConnection;56;2;196;0
WireConnection;1747;1;1743;0
WireConnection;1747;0;1831;0
WireConnection;1831;0;1746;0
WireConnection;1831;1;1830;0
WireConnection;1732;0;189;0
WireConnection;0;2;1323;0
WireConnection;0;10;1831;0
WireConnection;0;13;56;0
WireConnection;0;11;768;0
ASEEND*/
//CHKSM=98B4F088638DB439C5DA1BC29BDFAAC9847CEA1D