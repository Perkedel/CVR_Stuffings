// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Furality/Sylva Shader/Sylva Transparent Outline"
{
	Properties
	{
		[HDR]_OutlineGlowTint("OutlineGlowTint", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_OutlineGlowZone("OutlineGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_OutlineGlowMode("OutlineGlowMode", Int) = 0
		[Enum(Multiply,0,Additive,1)]_OutlineGlowBlendMode("OutlineGlowBlendMode", Int) = 0
		_OutlineGlowMinBrightness("OutlineGlowMinBrightness", Range( 0 , 1)) = 0
		_OutlineGlowPulseDir("OutlineGlowPulseDir", Float) = 0
		_OutlineGlowPulseScale("OutlineGlowPulseScale", Float) = 127
		_OutlineGlowPulseOffset("OutlineGlowPulseOffset", Float) = 0
		_OutlineGlowRadialCenter("OutlineGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_OutlineReactiveTint("OutlineReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_OutlineReactiveBand("OutlineReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_OutlineReactiveMode("OutlineReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_OutlineReactiveBlendMode("OutlineReactiveBlendMode", Int) = 0
		_OutlineReactiveMinBrightness("OutlineReactiveMinBrightness", Range( 0 , 1)) = 0
		_OutlineReactiveGlobalSmoothing("OutlineReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_OutlineReactivePulseDir("OutlineReactivePulseDir", Float) = 0
		_OutlineReactivePulseScale("OutlineReactivePulseScale", Float) = 127
		_OutlineReactivePulseOffset("OutlineReactivePulseOffset", Float) = 0
		_OutlineReactiveRadialCenter("OutlineReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowOutlineGlow("_ShowOutlineGlow", Float) = 0
		_ShowOutlineAL("_ShowOutlineAL", Float) = 0
		_MainTex("Main Tex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_EffectMask("Effect Mask", 2D) = "white" {}
		_EmissionMap("EmissionMap", 2D) = "white" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		[Enum(None,0,R,1,G,2,B,3,A,4)]_EmissionMaskingChannel("Emission Masking Channel", Int) = 0
		[ToggleUI]_EmissionMaskPan("Emission Mask Pan", Float) = 0
		_EmissionMaskPanSpeed("Emission Mask Pan Speed", Vector) = (1,1,0,0)
		[ToggleUI]_EmissionPan("Emission Pan", Float) = 0
		_EmissionPanSpeed("Emission Pan Speed", Vector) = (1,1,0,0)
		[Normal][SingleLineTexture]_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 1)) = 1
		[SingleLineTexture]_MetallicGlossMap("Metallic", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		_GlossMapScale("GlossMapScale", Range( 0 , 1)) = 1
		[SingleLineTexture]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionStrength("Occlusion Strength", Range( 0 , 1)) = 1
		[ToggleUI]_EnableSpecularMap("Enable Specular Map", Float) = 0
		[SingleLineTexture]_SpecGlossMap("Specular", 2D) = "white" {}
		_SpecColor("Specular Color", Color) = (1,1,1,0)
		[HDR]_RimlightColor("Rimlight Color", Color) = (1,1,1,0)
		_OutlineWidth("Outline Width", Range( 0 , 1000)) = 1
		_MaxOutlineWidth("Max Outline Width", Range( 0 , 1000)) = 850
		_ViewFudge("ViewFudge", Float) = 0
		[Enum(None,0,R,1,G,2,B,3,A,4)]_OutlineMaskingChannel("Outline Masking Channel", Int) = 0
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_DirectionalMap("Directional Map", 2D) = "white" {}
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
		_GlowMask("GlowMask", 2D) = "black" {}
		[HDR]_RedChGlowTint("RedChGlowTint", Color) = (1,1,1,0)
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
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HDR]_RedChReactiveTint("RedChReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_RedChReactiveBand("RedChReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_RedChReactiveMode("RedChReactiveMode", Int) = 0
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
		[HDR]_GreenChGlowTint("GreenChGlowTint", Color) = (1,1,1,0)
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
		[HDR]_BlueChGlowTint("BlueChGlowTint", Color) = (1,1,1,0)
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
		[HDR]_AlphaChGlowTint("AlphaChGlowTint", Color) = (1,1,1,0)
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
		_BlendModeIndex("_BlendModeIndex", Float) = 0
		_BlendOPsrc("_BlendOPsrc", Float) = 5
		_BlendOPIndex("_BlendOPIndex", Float) = 0
		_BlendOPdst("_BlendOPdst", Float) = 10
		[Toggle(UNITY_PASS_FORWARDADD)] _Keyword3("Keyword 3", Float) = 0
		[HideInInspector]_ShowEffects("ShowEffects", Float) = 0
		[HideInInspector]_ShowGlow("ShowGlow", Float) = 0
		[HideInInspector]_ShowOutline("ShowOutline", Float) = 0
		[HideInInspector]_ShowOutline2("ShowOutline2", Float) = 0
		[HideInInspector]_ShowMain("ShowMain", Float) = 0
		[Toggle(_EMISSION)] _EnableEmission("_Enable Emission", Float) = 0
		[Enum(Iridescent Colors,0,Emission Multiply,1,Rainbow,2,Texture HueSelect,3,Holographic,4,Texture HueShift,5)]_IridescentEmissionMode("Iridescent Emission Mode", Int) = 0
		[Enum(None,0,R,1,G,2,B,3,A,4)]_IridescentMaskingChannel("Iridescent Masking Channel", Int) = 0
		_IridescentEmissionColor1("Iridescent Emission Color 1", Color) = (1,0,0,0)
		_IridescentEmissionColor2("Iridescent Emission Color 2", Color) = (0,1,0,0)
		_IridescentEmissionColor3("Iridescent Emission Color 3", Color) = (0,0,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_IridescentALAnimationBand("IridescentALAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_IridescentALAnimationMode("IridescentALAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_IridescentALAnimationSpeed("IridescentALAnimationSpeed", Int) = 0
		_IridescentALAnimationStrength("IridescentALAnimationStrength", Float) = 1
		_ShowIridescence("_ShowIridescence", Float) = 0
		_IridescentIntensity("IridescentIntensity", Range( 0 , 10)) = 1
		[Toggle(UNITY_PASS_FORWARDBASE)] _Keyword0("Keyword 0", Float) = 0
		[Enum(Facing,0,Reflection,1,Light Direction,2)]_IridescentMode2("Iridescent Mode 2", Int) = 0
		_IridescentScale("IridescentScale", Float) = 1
		_IridescentOffset("IridescentOffset", Float) = 0
		[Enum(Global,0,Specular,1,Rimlight,2,Both,3)]_IridescenceLightMode("Iridescence Light Mode", Int) = 0
		[ToggleUI]_Enableiridescence("_Enableiridescence", Float) = 0
		[Enum(Default,0,Specular,1,Rimlight,2,SpecRim,3,All,4)]_SparkleMode("Sparkle Mode", Int) = 0
		[Enum(Circle,0,Square,1,Star,2,Heart,3)]_SparkleShape("Sparkle Shape", Int) = 0
		[Enum(None,0,R,1,G,2,B,3,A,4)]_SparkleMaskingChannel("Sparkle Masking Channel", Int) = 0
		[HDR]_SparkleColor("Sparkle Color", Color) = (1,1,1,0)
		_SparkleSize("Sparkle Size", Range( 0 , 0.75)) = 0.5
		_SparkleScale("Sparkle Scale", Float) = 1
		_SparkleSpeed("Sparkle Speed", Float) = 1
		_SparkleSeed("Sparkle Seed", Float) = 20
		[HDR]_SparkleGlowTint("SparkleGlowTint", Color) = (1,1,1,0)
		[Enum(None,0,Zone 1,1,Zone 2,2,Zone 3,3,Zone 4,4,Gradient 1,5,Gradient 2,6,Gradient 3,7)]_SparkleGlowZone("SparkleGlowZone", Int) = 0
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4)]_SparkleGlowMode("SparkleGlowMode", Int) = 0
		_SparkleGlowMinBrightness("SparkleGlowMinBrightness", Range( 0 , 1)) = 0
		_SparkleGlowPulseDir("SparkleGlowPulseDir", Float) = 0
		_SparkleGlowPulseScale("SparkleGlowPulseScale", Float) = 127
		_SparkleGlowPulseOffset("SparkleGlowPulseOffset", Float) = 0
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_SparkleGlowAnimationBand("SparkleGlowAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_SparkleGlowAnimationMode("SparkleGlowAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_SparkleGlowAnimationSpeed("SparkleGlowAnimationSpeed", Int) = 0
		_SparkleGlowAnimationStrength("SparkleGlowAnimationStrength", Float) = 1
		_SparkleGlowRadialCenter("SparkleGlowRadialCenter", Vector) = (0.5,0.5,0,0)
		[HDR]_SparkleReactiveTint("SparkleReactiveTint", Color) = (1,1,1,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_SparkleReactiveBand("SparkleReactiveBand", Int) = 10
		[Enum(Global,0,Pulse,1,Radial,2,Direction Map,3,Reversed Direction Map,4,Smooth Global,5)]_SparkleReactiveMode("SparkleReactiveMode", Int) = 0
		[Enum(Multiply,0,Additive,1,Reversed Multiply,2,Reversed Additve,3)]_SparkleReactiveBlendMode("SparkleReactiveBlendMode", Int) = 0
		_SparkleReactiveMinBrightness("SparkleReactiveMinBrightness", Range( 0 , 1)) = 0
		_SparkleReactiveGlobalSmoothing("SparkleReactiveGlobalSmoothing", Range( 0 , 2)) = 1
		_SparkleReactivePulseDir("SparkleReactivePulseDir", Float) = 0
		_SparkleReactivePulseScale("SparkleReactivePulseScale", Float) = 127
		_SparkleReactivePulseOffset("SparkleReactivePulseOffset", Float) = 0
		_SparkleReactiveRadialCenter("SparkleReactiveRadialCenter", Vector) = (0.5,0.5,0,0)
		_ShowSparkleGlow("_ShowSparkleGlow", Float) = 0
		_ShowSparkleAL("_ShowSparkleAL", Float) = 0
		[Toggle(UNITY_PASS_FORWARDBASE)] _Keyword1("Keyword 0", Float) = 0
		[Enum(Multiply,0,Additive,1)]_SparkleBlendMode("Sparkle Blend Mode", Int) = 0
		_ShowSparkles("_ShowSparkles", Float) = 0
		[Toggle(_SPARKLES)] _EnableSparkles("Enable Sparkles", Float) = 0
		[Enum(None,0,R,1,G,2,B,3,A,4)]_RainbowMaskingChannel("Rainbow Masking Channel", Int) = 0
		[Enum(Default,0,Radial,1,Spiral,2,Direction Map,3,Reverse Direction,4)]_RainbowUVMode("Rainbow UV Mode", Int) = 0
		_RainbowHue("Rainbow Hue", Range( 0 , 1)) = 1
		_RainbowSaturation("Rainbow Saturation", Range( 0 , 1)) = 1
		_RainbowValue("Rainbow Value", Range( 0 , 1)) = 1
		_RainbowHueRange("Rainbow Hue Range", Range( 0 , 1)) = 1
		_RainbowRotation("Rainbow Rotation", Float) = 0
		_RainbowScale("Rainbow Scale", Float) = 1
		_RainbowSpiralCurve("Rainbow Spiral Curve", Float) = 1
		_RainbowRadialCenter("Rainbow Radial Center", Vector) = (0.5,0.5,0,0)
		[Enum(None,10,Bass,0,Low Mid,1,High Mid,2,Treble,3)]_RainbowALAnimationBand("RainbowALAnimationBand", Int) = 10
		[Enum(Default,0,Wobble,1,Smooth,2,Hard Stop,3,Constant,4)]_RainbowALAnimationMode("RainbowALAnimationMode", Int) = 0
		[Enum(Slow,0,Fast,1)]_RainbowALAnimationSpeed("RainbowALAnimationSpeed", Int) = 0
		_RainbowALAnimationStrength("RainbowALAnimationStrength", Float) = 1
		_ShowRainbow("_ShowRainbow", Float) = 0
		[ToggleUI]_EnableScrollingRainbow("_EnableScrollingRainbow", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Culling("Culling", Float) = 0
		_MaskClipValue("Mask Clip Value", Float) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZWrite On
		}

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		ZWrite On
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float lerpResult824 = lerp( 0.0 , ( _OutlineWidth / 10000.0 ) , saturate( _OutlineWidth ));
			float lerpResult829 = lerp( 0.0 , ( _MaxOutlineWidth / 10000.0 ) , saturate( _MaxOutlineWidth ));
			float2 uv_EffectMask = v.texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float4 EffectMaskRGBA871 = tex2Dlod( _EffectMask, float4( uv_EffectMask, 0, 0.0) );
			float4 break1044 = EffectMaskRGBA871;
			int temp_output_18_0_g4913 = _OutlineMaskingChannel;
			float lerpResult1_g4913 = lerp( 1.0 , break1044.r , (float)saturate( temp_output_18_0_g4913 ));
			int temp_output_5_0_g4913 = ( temp_output_18_0_g4913 - 1 );
			float lerpResult12_g4913 = lerp( lerpResult1_g4913 , break1044.g , (float)saturate( temp_output_5_0_g4913 ));
			int temp_output_6_0_g4913 = ( temp_output_5_0_g4913 - 1 );
			float lerpResult10_g4913 = lerp( lerpResult12_g4913 , break1044.b , (float)saturate( temp_output_6_0_g4913 ));
			float lerpResult11_g4913 = lerp( lerpResult10_g4913 , break1044.a , (float)saturate( ( temp_output_6_0_g4913 - 1 ) ));
			float temp_output_1042_0 = lerpResult11_g4913;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 worldToObjDir1060 = mul( unity_WorldToObject, float4( ( ( ase_worldNormal * min( ( lerpResult824 + ( lerpResult824 * eyeDepth ) ) , lerpResult829 ) * temp_output_1042_0 ) + ( -ase_worldViewDir * _ViewFudge ) ), 0 ) ).xyz;
			float3 outlineVar = worldToObjDir1060;
			v.vertex.xyz += outlineVar;
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float4 OutlineRGB788 = _OutlineColor;
			float3 temp_output_229_0_g4914 = OutlineRGB788.rgb;
			int EmissionReactiveBand236_g4914 = _OutlineReactiveBand;
			int Band3_g4915 = EmissionReactiveBand236_g4914;
			int Delay3_g4915 = 0;
			float localAudioLinkData3_g4915 = AudioLinkData3_g4915( Band3_g4915 , Delay3_g4915 );
			int temp_output_64_0_g4914 = step( _OutlineReactiveBand , 9 );
			float lerpResult66_g4914 = lerp( 1.0 , localAudioLinkData3_g4915 , (float)temp_output_64_0_g4914);
			int Band3_g4917 = _OutlineReactiveBand;
			float cos78_g4914 = cos( radians( _OutlineReactivePulseDir ) );
			float sin78_g4914 = sin( radians( _OutlineReactivePulseDir ) );
			float2 rotator78_g4914 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4914 , -sin78_g4914 , sin78_g4914 , cos78_g4914 )) + float2( 0.5,0.5 );
			float x96_g4914 = ( ( rotator78_g4914.x * _OutlineReactivePulseScale ) + _OutlineReactivePulseOffset );
			float y96_g4914 = 127.0;
			float localglslmod96_g4914 = glslmod96_g4914( x96_g4914 , y96_g4914 );
			float2 CenteredUV15_g4918 = ( i.uv_texcoord - _OutlineReactiveRadialCenter );
			float2 break17_g4918 = CenteredUV15_g4918;
			float2 appendResult23_g4918 = (float2(( length( CenteredUV15_g4918 ) * _OutlineReactivePulseScale * 2.0 ) , ( atan2( break17_g4918.x , break17_g4918.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4914 = ( _OutlineReactivePulseOffset + appendResult23_g4918.x );
			float y97_g4914 = 127.0;
			float localglslmod97_g4914 = glslmod97_g4914( x97_g4914 , y97_g4914 );
			int EmissionReactiveMode99_g4914 = _OutlineReactiveMode;
			int temp_output_90_0_g4914 = ( EmissionReactiveMode99_g4914 - 1 );
			float lerpResult77_g4914 = lerp( localglslmod96_g4914 , localglslmod97_g4914 , (float)saturate( temp_output_90_0_g4914 ));
			float2 uv_DirectionalMap = i.uv_texcoord * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float Direction27_g4606 = tex2D( _DirectionalMap, uv_DirectionalMap ).r;
			float temp_output_1074_244 = Direction27_g4606;
			float DirectionalMap106_g4914 = temp_output_1074_244;
			float lerpResult174_g4914 = lerp( DirectionalMap106_g4914 , ( 1.0 - DirectionalMap106_g4914 ) , (float)saturate( ( EmissionReactiveMode99_g4914 - 3 ) ));
			float x98_g4914 = ( _OutlineReactivePulseOffset + ( _OutlineReactivePulseScale * lerpResult174_g4914 ) );
			float y98_g4914 = 127.0;
			float localglslmod98_g4914 = glslmod98_g4914( x98_g4914 , y98_g4914 );
			float lerpResult87_g4914 = lerp( lerpResult77_g4914 , localglslmod98_g4914 , (float)saturate( ( temp_output_90_0_g4914 - 1 ) ));
			float Delay3_g4917 = lerpResult87_g4914;
			float localAudioLinkLerp3_g4917 = AudioLinkLerp3_g4917( Band3_g4917 , Delay3_g4917 );
			float lerpResult102_g4914 = lerp( 1.0 , localAudioLinkLerp3_g4917 , (float)temp_output_64_0_g4914);
			float lerpResult103_g4914 = lerp( lerpResult66_g4914 , lerpResult102_g4914 , (float)saturate( EmissionReactiveMode99_g4914 ));
			int Band3_g4919 = _OutlineReactiveBand;
			float FilteredAmount3_g4919 = ( ( 1.0 - _OutlineReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4919 = AudioLinkLerp3_g4919( Band3_g4919 , FilteredAmount3_g4919 );
			float lerpResult168_g4914 = lerp( 1.0 , localAudioLinkLerp3_g4919 , (float)temp_output_64_0_g4914);
			float lerpResult172_g4914 = lerp( lerpResult103_g4914 , lerpResult168_g4914 , (float)saturate( ( EmissionReactiveMode99_g4914 - 4 ) ));
			float ReactivityAlpha132_g4914 = (_OutlineReactiveMinBrightness + (lerpResult172_g4914 - 0.0) * (( _OutlineReactiveMinBrightness + 1.0 ) - _OutlineReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_10 = (1.0).xxxx;
			float4 lerpResult240_g4914 = lerp( temp_cast_10 , _OutlineReactiveTint , (float)step( EmissionReactiveBand236_g4914 , 9 ));
			float4 FinalReactivity68_g4914 = ( ReactivityAlpha132_g4914 * lerpResult240_g4914 );
			float4 temp_cast_12 = (1.0).xxxx;
			float3 temp_cast_13 = (1.0).xxx;
			int EmissionGlowZone47_g4914 = _OutlineGlowZone;
			int clampResult8_g4921 = clamp( EmissionGlowZone47_g4914 , 1 , 4 );
			int temp_output_3_0_g4921 = ( clampResult8_g4921 - 1 );
			int Zone16_g4921 = temp_output_3_0_g4921;
			float3 localgetThemeData16_g4921 = getThemeData( Zone16_g4921 );
			int Band11_g4922 = 56;
			int localIsLumaActive11_g4922 = IsLumaActive11_g4922( Band11_g4922 );
			int temp_output_14_0_g4921 = localIsLumaActive11_g4922;
			int lerpResult15_g4921 = lerp( temp_output_3_0_g4921 , ( 63 - temp_output_3_0_g4921 ) , (float)temp_output_14_0_g4921);
			int Band2_g4921 = lerpResult15_g4921;
			int Delay2_g4921 = 0;
			float3 localLumaGlowData2_g4921 = LumaGlowData2_g4921( Band2_g4921 , Delay2_g4921 );
			float3 lerpResult17_g4921 = lerp( ( localgetThemeData16_g4921 * localLumaGlowData2_g4921 ) , localLumaGlowData2_g4921 , (float)temp_output_14_0_g4921);
			int temp_output_21_0_g4914 = saturate( EmissionGlowZone47_g4914 );
			float3 lerpResult20_g4914 = lerp( temp_cast_13 , lerpResult17_g4921 , (float)temp_output_21_0_g4914);
			float3 temp_cast_17 = (1.0).xxx;
			int clampResult8_g4923 = clamp( EmissionGlowZone47_g4914 , 1 , 4 );
			int temp_output_3_0_g4923 = ( clampResult8_g4923 - 1 );
			int Zone15_g4923 = temp_output_3_0_g4923;
			float3 localgetThemeData15_g4923 = getThemeData( Zone15_g4923 );
			int Band11_g4924 = 56;
			int localIsLumaActive11_g4924 = IsLumaActive11_g4924( Band11_g4924 );
			int temp_output_13_0_g4923 = localIsLumaActive11_g4924;
			int lerpResult14_g4923 = lerp( temp_output_3_0_g4923 , ( 63 - temp_output_3_0_g4923 ) , (float)temp_output_13_0_g4923);
			int Band11_g4923 = lerpResult14_g4923;
			float cos6_g4914 = cos( radians( _OutlineGlowPulseDir ) );
			float sin6_g4914 = sin( radians( _OutlineGlowPulseDir ) );
			float2 rotator6_g4914 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4914 , -sin6_g4914 , sin6_g4914 , cos6_g4914 )) + float2( 0.5,0.5 );
			float x13_g4914 = ( ( rotator6_g4914.x * _OutlineGlowPulseScale ) + _OutlineGlowPulseOffset );
			float y13_g4914 = 127.0;
			float localglslmod13_g4914 = glslmod13_g4914( x13_g4914 , y13_g4914 );
			float2 CenteredUV15_g4916 = ( i.uv_texcoord - _OutlineGlowRadialCenter );
			float2 break17_g4916 = CenteredUV15_g4916;
			float2 appendResult23_g4916 = (float2(( length( CenteredUV15_g4916 ) * _OutlineGlowPulseScale * 2.0 ) , ( atan2( break17_g4916.x , break17_g4916.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4914 = ( _OutlineGlowPulseOffset + appendResult23_g4916.x );
			float y12_g4914 = 127.0;
			float localglslmod12_g4914 = glslmod12_g4914( x12_g4914 , y12_g4914 );
			int EmissionGlowMode35_g4914 = _OutlineGlowMode;
			int temp_output_37_0_g4914 = ( EmissionGlowMode35_g4914 - 1 );
			float lerpResult5_g4914 = lerp( localglslmod13_g4914 , localglslmod12_g4914 , (float)saturate( temp_output_37_0_g4914 ));
			float lerpResult179_g4914 = lerp( DirectionalMap106_g4914 , ( 1.0 - DirectionalMap106_g4914 ) , (float)saturate( ( EmissionGlowMode35_g4914 - 3 ) ));
			float x34_g4914 = ( _OutlineGlowPulseOffset + ( _OutlineGlowPulseScale * lerpResult179_g4914 ) );
			float y34_g4914 = 127.0;
			float localglslmod34_g4914 = glslmod34_g4914( x34_g4914 , y34_g4914 );
			float lerpResult30_g4914 = lerp( lerpResult5_g4914 , localglslmod34_g4914 , (float)saturate( ( temp_output_37_0_g4914 - 1 ) ));
			float EmissionGlowDelay56_g4914 = lerpResult30_g4914;
			float Delay11_g4923 = EmissionGlowDelay56_g4914;
			float3 localLumaGlowLerp11_g4923 = LumaGlowLerp11_g4923( Band11_g4923 , Delay11_g4923 );
			float3 lerpResult17_g4923 = lerp( ( localgetThemeData15_g4923 * localLumaGlowLerp11_g4923 ) , localLumaGlowLerp11_g4923 , (float)temp_output_13_0_g4923);
			float3 lerpResult22_g4914 = lerp( temp_cast_17 , lerpResult17_g4923 , (float)temp_output_21_0_g4914);
			float3 lerpResult23_g4914 = lerp( lerpResult20_g4914 , lerpResult22_g4914 , (float)saturate( EmissionGlowMode35_g4914 ));
			float4 temp_cast_26 = (1.0).xxxx;
			float temp_output_10_0_g4925 = EmissionGlowDelay56_g4914;
			float Position1_g4927 = ( temp_output_10_0_g4925 / 127.0 );
			float4 localAudioLinkLerp1_g4927 = AudioLinkLerp1_g4927( Position1_g4927 );
			int clampResult8_g4925 = clamp( ( EmissionGlowZone47_g4914 - 4 ) , 1 , 3 );
			int Band11_g4925 = ( 59 - ( clampResult8_g4925 - 1 ) );
			float Delay11_g4925 = temp_output_10_0_g4925;
			float3 localLumaGlowLerp11_g4925 = LumaGlowLerp11_g4925( Band11_g4925 , Delay11_g4925 );
			int Band11_g4926 = 56;
			int localIsLumaActive11_g4926 = IsLumaActive11_g4926( Band11_g4926 );
			float4 lerpResult14_g4925 = lerp( localAudioLinkLerp1_g4927 , float4( localLumaGlowLerp11_g4925 , 0.0 ) , (float)localIsLumaActive11_g4926);
			float4 lerpResult52_g4914 = lerp( temp_cast_26 , lerpResult14_g4925 , (float)saturate( EmissionGlowZone47_g4914 ));
			float4 lerpResult51_g4914 = lerp( float4( lerpResult23_g4914 , 0.0 ) , lerpResult52_g4914 , (float)saturate( ( EmissionGlowZone47_g4914 - 4 ) ));
			float4 temp_cast_31 = (_OutlineGlowMinBrightness).xxxx;
			float4 temp_cast_32 = (( _OutlineGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_234_0_g4914 = saturate( EmissionGlowZone47_g4914 );
			float4 EmissionGlow142_g4914 = ( (temp_cast_31 + (lerpResult51_g4914 - float4( 0,0,0,0 )) * (temp_cast_32 - temp_cast_31) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _OutlineGlowTint * temp_output_234_0_g4914 );
			float4 lerpResult248_g4914 = lerp( temp_cast_12 , EmissionGlow142_g4914 , (float)temp_output_234_0_g4914);
			float4 EmissionGlowTog250_g4914 = lerpResult248_g4914;
			float4 lerpResult146_g4914 = lerp( ( FinalReactivity68_g4914 * EmissionGlowTog250_g4914 ) , ( EmissionGlow142_g4914 + ( FinalReactivity68_g4914 * step( EmissionReactiveBand236_g4914 , 9 ) ) ) , (float)saturate( _OutlineReactiveBlendMode ));
			float4 ReversedReactivity152_g4914 = ( ( 1.0 - ReactivityAlpha132_g4914 ) * lerpResult240_g4914 );
			int temp_output_157_0_g4914 = ( _OutlineReactiveBlendMode - 1 );
			float4 lerpResult114_g4914 = lerp( lerpResult146_g4914 , ( EmissionGlowTog250_g4914 * ReversedReactivity152_g4914 ) , (float)saturate( temp_output_157_0_g4914 ));
			float4 lerpResult164_g4914 = lerp( lerpResult114_g4914 , ( EmissionGlow142_g4914 + ( ReversedReactivity152_g4914 * step( EmissionReactiveBand236_g4914 , 9 ) ) ) , (float)saturate( ( temp_output_157_0_g4914 - 1 ) ));
			int ReactiveBlendmode257_g4914 = _OutlineReactiveBlendMode;
			float x266_g4914 = (float)ReactiveBlendmode257_g4914;
			float y266_g4914 = 2.0;
			float localglslmod266_g4914 = glslmod266_g4914( x266_g4914 , y266_g4914 );
			float lerpResult253_g4914 = lerp( localglslmod266_g4914 , (float)_OutlineGlowBlendMode , (float)saturate( EmissionGlowZone47_g4914 ));
			float4 lerpResult222_g4914 = lerp( ( lerpResult164_g4914 * float4( temp_output_229_0_g4914 , 0.0 ) ) , ( lerpResult164_g4914 + float4( temp_output_229_0_g4914 , 0.0 ) ) , lerpResult253_g4914);
			float localIfAudioLinkv2Exists1_g4929 = IfAudioLinkv2Exists1_g4929();
			float4 lerpResult273_g4914 = lerp( float4( temp_output_229_0_g4914 , 0.0 ) , lerpResult222_g4914 , localIfAudioLinkv2Exists1_g4929);
			float4 OutlineGlow790 = lerpResult273_g4914;
			float2 uv_EffectMask = i.uv_texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float4 EffectMaskRGBA871 = tex2D( _EffectMask, uv_EffectMask );
			float4 break1044 = EffectMaskRGBA871;
			int temp_output_18_0_g4913 = _OutlineMaskingChannel;
			float lerpResult1_g4913 = lerp( 1.0 , break1044.r , (float)saturate( temp_output_18_0_g4913 ));
			int temp_output_5_0_g4913 = ( temp_output_18_0_g4913 - 1 );
			float lerpResult12_g4913 = lerp( lerpResult1_g4913 , break1044.g , (float)saturate( temp_output_5_0_g4913 ));
			int temp_output_6_0_g4913 = ( temp_output_5_0_g4913 - 1 );
			float lerpResult10_g4913 = lerp( lerpResult12_g4913 , break1044.b , (float)saturate( temp_output_6_0_g4913 ));
			float lerpResult11_g4913 = lerp( lerpResult10_g4913 , break1044.a , (float)saturate( ( temp_output_6_0_g4913 - 1 ) ));
			float temp_output_1042_0 = lerpResult11_g4913;
			o.Emission = OutlineGlow790.xyz;
			o.Alpha = min( temp_output_1042_0 , _OutlineColor.a );
		}
		ENDCG
		

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Culling]
		ZWrite On
		Blend [_BlendOPsrc] [_BlendOPdst]
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
		#pragma shader_feature_local _EMISSION
		#pragma shader_feature_local _SPARKLES
		#include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"
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
			float3 worldRefl;
			INTERNAL_DATA
			half ASEIsFrontFacing : VFACE;
			float3 worldPos;
			float3 worldNormal;
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

		uniform float _Culling;
		uniform float _ShowMain;
		uniform float _ShowGlow;
		uniform float _ShowEmissGlow;
		uniform float _ShowEmissAL;
		uniform float _ShowRedGlow;
		uniform float _ShowRedAL;
		uniform float _EnableRedChannel;
		uniform float _ShowGreenGlow;
		uniform float _ShowGreenAL;
		uniform float _ShowBlueGlow;
		uniform float _ShowBlueAL;
		uniform float _ShowAlphaGlow;
		uniform float _ShowAlphaAL;
		uniform float _ShowEffects;
		uniform float _ShowOutline;
		uniform float _ShowOutline2;
		uniform float _ShowIridescence;
		uniform float _BlendOPsrc;
		uniform float _BlendOPdst;
		uniform float _MaskClipValue;
		uniform float _BlendOPIndex;
		uniform float _BlendModeIndex;
		uniform float _ShowOutlineGlow;
		uniform float _ShowOutlineAL;
		uniform float _ShowRainbow;
		uniform float _ShowSparkles;
		uniform float _ShowSparkleGlow;
		uniform float _ShowSparkleAL;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform int _RedChGlowZone;
		uniform float _RedChGlowPulseDir;
		uniform float _RedChGlowPulseScale;
		uniform float _RedChGlowPulseOffset;
		uniform float _RedChGlowAnimationStrength;
		uniform int _RedChGlowAnimationBand;
		uniform int _RedChGlowAnimationMode;
		uniform int _RedChGlowAnimationSpeed;
		uniform float2 _RedChGlowRadialCenter;
		uniform int _RedChGlowMode;
		uniform sampler2D _DirectionalMap;
		uniform float4 _DirectionalMap_ST;
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
		uniform sampler2D _GlowMask;
		uniform float4 _GlowMask_ST;
		uniform int _GreenChGlowZone;
		uniform float _GreenChGlowPulseDir;
		uniform float _GreenChGlowPulseScale;
		uniform float _GreenChGlowPulseOffset;
		uniform float _GreenChGlowAnimationStrength;
		uniform int _GreenChGlowAnimationBand;
		uniform int _GreenChGlowAnimationMode;
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
		uniform float _EnableGreenChannel;
		uniform int _BlueChGlowZone;
		uniform float _BlueChGlowPulseDir;
		uniform float _BlueChGlowPulseScale;
		uniform float _BlueChGlowPulseOffset;
		uniform float _BlueChGlowAnimationStrength;
		uniform int _BlueChGlowAnimationBand;
		uniform int _BlueChGlowAnimationMode;
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
		uniform float _EnableBlueChannel;
		uniform int _AlphaChGlowZone;
		uniform float _AlphaChGlowPulseDir;
		uniform float _AlphaChGlowPulseScale;
		uniform float _AlphaChGlowPulseOffset;
		uniform float _AlphaChGlowAnimationStrength;
		uniform int _AlphaChGlowAnimationBand;
		uniform int _AlphaChGlowAnimationMode;
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
		uniform float _EnableAlphaChannel;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float2 _EmissionPanSpeed;
		uniform float _EmissionPan;
		uniform sampler2D _EffectMask;
		uniform float4 _EffectMask_ST;
		uniform float2 _EmissionMaskPanSpeed;
		uniform float _EmissionMaskPan;
		uniform int _EmissionMaskingChannel;
		uniform int _EmissionGlowZone;
		uniform float _EmissionGlowPulseDir;
		uniform float _EmissionGlowPulseScale;
		uniform float _EmissionGlowPulseOffset;
		uniform float _EmissionGlowAnimationStrength;
		uniform int _EmissionGlowAnimationBand;
		uniform int _EmissionGlowAnimationMode;
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
		uniform int _IridescentMaskingChannel;
		uniform float4 _IridescentEmissionColor1;
		uniform float4 _IridescentEmissionColor2;
		uniform float _IridescentALAnimationStrength;
		uniform int _IridescentALAnimationBand;
		uniform int _IridescentALAnimationMode;
		uniform int _IridescentALAnimationSpeed;
		uniform sampler2D _BumpMap;
		uniform float _BumpScale;
		uniform int _IridescentMode2;
		uniform float _IridescentScale;
		uniform float _IridescentOffset;
		uniform float4 _IridescentEmissionColor3;
		uniform float _Glossiness;
		uniform sampler2D _MetallicGlossMap;
		uniform float _GlossMapScale;
		float4 _MetallicGlossMap_TexelSize;
		uniform int _IridescenceLightMode;
		uniform float _IridescentIntensity;
		uniform int _IridescentEmissionMode;
		uniform float _Enableiridescence;
		uniform float4 _Color;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform sampler2D _SpecGlossMap;
		uniform float _Metallic;
		uniform float _EnableSpecularMap;
		uniform float4 _SparkleColor;
		uniform float _SparkleScale;
		uniform float _SparkleSize;
		uniform float _SparkleSeed;
		uniform float _SparkleSpeed;
		uniform int _SparkleShape;
		uniform int _SparkleMaskingChannel;
		uniform float4 _SparkleGlowTint;
		uniform int _SparkleGlowZone;
		uniform float _SparkleGlowPulseDir;
		uniform float _SparkleGlowPulseScale;
		uniform float _SparkleGlowPulseOffset;
		uniform float _SparkleGlowAnimationStrength;
		uniform int _SparkleGlowAnimationBand;
		uniform int _SparkleGlowAnimationMode;
		uniform int _SparkleGlowAnimationSpeed;
		uniform float2 _SparkleGlowRadialCenter;
		uniform int _SparkleGlowMode;
		uniform float _SparkleGlowMinBrightness;
		uniform int _SparkleReactiveBand;
		uniform float _SparkleReactivePulseDir;
		uniform float _SparkleReactivePulseScale;
		uniform float _SparkleReactivePulseOffset;
		uniform float2 _SparkleReactiveRadialCenter;
		uniform int _SparkleReactiveMode;
		uniform float _SparkleReactiveGlobalSmoothing;
		uniform float _SparkleReactiveMinBrightness;
		uniform float4 _SparkleReactiveTint;
		uniform int _SparkleReactiveBlendMode;
		uniform int _SparkleBlendMode;
		uniform int _SparkleMode;
		uniform float _RainbowALAnimationStrength;
		uniform int _RainbowALAnimationBand;
		uniform int _RainbowALAnimationMode;
		uniform int _RainbowALAnimationSpeed;
		uniform float _RainbowRotation;
		uniform float2 _RainbowRadialCenter;
		uniform float _RainbowSpiralCurve;
		uniform int _RainbowUVMode;
		uniform float _RainbowScale;
		uniform float _RainbowHueRange;
		uniform float _RainbowHue;
		uniform float _RainbowSaturation;
		uniform float _RainbowValue;
		uniform int _RainbowMaskingChannel;
		uniform float _EnableScrollingRainbow;
		uniform float4 _RimlightColor;
		uniform float4 _OutlineColor;
		uniform int _OutlineReactiveBand;
		uniform float _OutlineReactivePulseDir;
		uniform float _OutlineReactivePulseScale;
		uniform float _OutlineReactivePulseOffset;
		uniform float2 _OutlineReactiveRadialCenter;
		uniform int _OutlineReactiveMode;
		uniform float _OutlineReactiveGlobalSmoothing;
		uniform float _OutlineReactiveMinBrightness;
		uniform float4 _OutlineReactiveTint;
		uniform int _OutlineGlowZone;
		uniform float _OutlineGlowPulseDir;
		uniform float _OutlineGlowPulseScale;
		uniform float _OutlineGlowPulseOffset;
		uniform float2 _OutlineGlowRadialCenter;
		uniform int _OutlineGlowMode;
		uniform float _OutlineGlowMinBrightness;
		uniform float4 _OutlineGlowTint;
		uniform int _OutlineReactiveBlendMode;
		uniform int _OutlineGlowBlendMode;
		uniform int _OutlineMaskingChannel;
		uniform float _OutlineWidth;
		uniform float _MaxOutlineWidth;
		uniform float _ViewFudge;


		float SchlickGGX( float k, float NdotL, float NdotV )
		{
			float L = (NdotL) / (NdotL * (1- k) + k);
			float V = (NdotV) / (NdotV * (1-k) +k);
			return L*V;
		}


		float3 BRDF( float3 N, float G, float F, float NdotL, float NdotV )
		{
			return (N*G*F) / (4 * (NdotL*NdotV));
		}


		float MixFunc( float i, float j, float x )
		{
			return j*x+i*(1-x);
		}


		float SchlickFresnel( float i )
		{
			float x = saturate(1-i);
			float x2 = x*x;
			return x2*x2*x;
		}


		float3 getThemeData( int Zone )
		{
			float3 result = lerp(AudioLinkData(ALPASS_THEME_COLOR0),AudioLinkData(ALPASS_THEME_COLOR1),saturate(Zone));
			result = lerp(result,AudioLinkData(ALPASS_THEME_COLOR2),saturate(Zone-1));
			result = lerp(result,AudioLinkData(ALPASS_THEME_COLOR3),saturate(Zone-2));
			return result;
		}


		float geometricRoughness( float3 WorldNormal )
		{
			float3 nDdx = ddx_fine(WorldNormal);
			float3 nDdy = ddy_fine(WorldNormal);
			return pow( saturate( max( dot( nDdx, nDdx ), dot( nDdy, nDdy ) ) ), 0.333 );
		}


		float3 ReflectionProbeSample( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
		}


		float sdStar5( float2 p, float r, float rf )
		{
			    const float2 k1 = float2(0.809016994375, -0.587785252292);
			    const float2 k2 = float2(-k1.x,k1.y);
			    p.x = abs(p.x);
			    p -= 2.0*max(dot(k1,p),0.0)*k1;
			    p -= 2.0*max(dot(k2,p),0.0)*k2;
			    p.x = abs(p.x);
			    p.y -= r;
			    float2 ba = rf*float2(-k1.y,k1.x) - float2(0,1);
			    float h = clamp( dot(p,ba)/dot(ba,ba), 0.0, r );
			    return length(p-ba*h) * sin(p.y*ba.x-p.x*ba.y);
		}


		float dot2( float2 a )
		{
			return dot(a,a);
		}


		float sdHeart( float2 p )
		{
			    p.x = abs(p.x);
			    if( p.y+p.x>1.0 )
			        return sqrt(dot2(p-float2(0.25,0.75))) - sqrt(2.0)/4.0;
			    return sqrt(min(dot2(p-float2(0.00,1.00)),
			                    dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
		}


		inline int IsLumaActive11_g4630( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4629( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4632( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4636( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4631( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4635( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4633( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4634( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4624( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4623( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4626( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4628( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		float IfAudioLinkv2Exists1_g4638(  )
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


		inline int IsLumaActive11_g4646( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4645( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4648( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4652( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4647( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4651( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4649( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4650( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4640( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4639( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4642( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4644( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		float IfAudioLinkv2Exists1_g4654(  )
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


		inline int IsLumaActive11_g4662( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4661( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4664( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4668( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4663( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4667( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4665( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4666( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4656( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4655( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4658( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4660( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		float IfAudioLinkv2Exists1_g4670(  )
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


		inline int IsLumaActive11_g4678( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4677( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4680( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4684( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4679( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4683( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4681( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4682( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4672( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4671( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4674( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4676( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		float IfAudioLinkv2Exists1_g4686(  )
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


		inline int IsLumaActive11_g4619( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4618( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4621( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4613( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4620( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4617( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4615( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4616( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4608( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4610( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4612( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		inline float glslmod270_g4607( float x, float y )
		{
			return glsl_mod(x,y);
		}


		float IfAudioLinkv2Exists1_g4622(  )
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


		inline int AudioLinkDecodeDataAsUInt6_g4906( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		float IfAudioLinkv2Exists1_g4909(  )
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


		inline float ggx( float nh, float roughness )
		{
			return GGXTerm(nh, roughness);
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

		float2 voronoihash2_g4945( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi2_g4945( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash2_g4945( n + g );
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


		inline int IsLumaActive11_g4954( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4953( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4956( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline int AudioLinkDecodeDataAsUInt6_g4960( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		inline float glslmod13_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4955( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4959( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4957( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4958( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float AudioLinkData3_g4948( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4947( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4950( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4952( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		float IfAudioLinkv2Exists1_g4962(  )
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


		float IfAudioLinkv2Exists1_g4963(  )
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


		float F0138( float NdotL, float NdotV, float LdotH, float roughness )
		{
			float FresnelLight = SchlickFresnel(NdotL);
			float FresnelView = SchlickFresnel(NdotV);
			float FresnelDiffuse = 0.5 + 2 * LdotH*LdotH * roughness;
			return MixFunc(1, FresnelDiffuse, FresnelLight) * MixFunc(1, FresnelDiffuse, FresnelView);
		}


		inline float3 getProbes( float4 uvw )
		{
			return ShadeSH9(uvw);
		}


		inline int AudioLinkDecodeDataAsUInt6_g4942( int Band, int Mode )
		{
			return AudioLinkDecodeDataAsUInt( ALPASS_CHRONOTENSITY + int2(Mode, Band));
		}


		float IfAudioLinkv2Exists1_g4943(  )
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


		inline float AudioLinkData3_g4915( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) ).rrrr;
		}


		inline float glslmod96_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod97_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod98_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float AudioLinkLerp3_g4917( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) ).r;
		}


		inline float AudioLinkLerp3_g4919( int Band, float FilteredAmount )
		{
			return AudioLinkLerp( ALPASS_FILTEREDAUDIOLINK + float2( FilteredAmount, Band ) ).r;
		}


		inline int IsLumaActive11_g4922( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float3 LumaGlowData2_g4921( int Band, int Delay )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4924( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float glslmod13_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod12_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float glslmod34_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		inline float3 LumaGlowLerp11_g4923( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline float4 AudioLinkLerp1_g4927( float Position )
		{
			return AudioLinkLerp( ALPASS_CCSTRIP + float2( Position * 128., 0 ) ).rgba;;
		}


		inline float3 LumaGlowLerp11_g4925( int Band, float Delay )
		{
			return AudioLinkLerp( ALPASS_AUDIOLINK + float2( Delay, Band ) );
		}


		inline int IsLumaActive11_g4926( int Band )
		{
			return AudioLinkData( ALPASS_AUDIOLINK + uint2( 0, Band ) ).r;
		}


		inline float glslmod266_g4914( float x, float y )
		{
			return glsl_mod(x,y);
		}


		float IfAudioLinkv2Exists1_g4929(  )
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
			v.vertex.xyz += 0;
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 MainTex224 = tex2D( _MainTex, uv_MainTex );
			float Alpha1147 = ( MainTex224.a * _Color.a );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float3 objToWorldDir101 = mul( unity_ObjectToWorld, float4( ase_vertexNormal, 0 ) ).xyz;
			float3 tex2DNode241 = UnpackScaleNormal( tex2D( _BumpMap, uv_MainTex ), ( _BumpScale * 1.25 ) );
			float3 appendResult1198 = (float3(tex2DNode241.xy , ( tex2DNode241.b * ( ( i.ASEIsFrontFacing * 2.0 ) - 1.0 ) )));
			float3 Normal243 = appendResult1198;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float3 tangentToWorldDir257 = mul( ase_tangentToWorldFast, Normal243 );
			float3 normalizeResult259 = normalize( ( objToWorldDir101 + tangentToWorldDir257 ) );
			float3 worldNorm31 = normalizeResult259;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 viewDir29 = ase_worldViewDir;
			float3 normalizeResult592 = normalize( float3(1,1,2) );
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
			float3 break569 = ase_lightColor.rgb;
			float temp_output_571_0 = max( max( break569.x , break569.y ) , break569.z );
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch575 = saturate( temp_output_571_0 );
			#else
				float staticSwitch575 = 1.0;
			#endif
			float3 lerpResult584 = lerp( normalizeResult592 , ase_worldlightDir , staticSwitch575);
			float3 lightDir32 = lerpResult584;
			float3 normalizeResult13 = normalize( ( viewDir29 + lightDir32 ) );
			float3 halfDir25 = normalizeResult13;
			float dotResult50 = dot( worldNorm31 , halfDir25 );
			float NdotH38 = max( dotResult50 , 0.0 );
			float nh413 = NdotH38;
			float4 tex2DNode246 = tex2D( _MetallicGlossMap, uv_MainTex );
			float lerpResult255 = lerp( _Glossiness , ( tex2DNode246.a * _GlossMapScale ) , step( 10.0 , max( _MetallicGlossMap_TexelSize.z , _MetallicGlossMap_TexelSize.w ) ));
			float Smoothness90 = lerpResult255;
			float temp_output_47_0 = ( 1.0 - saturate( min( (0.3 + (Smoothness90 - 0.0) * (1.0 - 0.3) / (1.0 - 0.0)) , 0.999 ) ) );
			float roughness17 = temp_output_47_0;
			float roughness413 = roughness17;
			float localggx413 = ggx( nh413 , roughness413 );
			float smoothstepResult436 = smoothstep( saturate( ( -0.4 + 0.48 ) ) , saturate( ( -0.4 + ( 1.0 - 0.48 ) ) ) , localggx413);
			float temp_output_452_0 = ( smoothstepResult436 * Smoothness90 );
			float smoothstepResult469 = smoothstep( 0.8 , 1.0 , Smoothness90);
			float ToonSpecular444 = ( temp_output_452_0 + ( smoothstepResult469 * 5.0 * temp_output_452_0 ) );
			float dotResult544 = dot( viewDir29 , worldNorm31 );
			float temp_output_2_0_g1 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 20.0 ) * max( ( dotResult544 + -0.2 ) , 0.0 ) ) , 2.0 ) );
			float temp_output_547_0 = temp_output_2_0_g1;
			float RimAlpha1134 = temp_output_547_0;
			float smoothstepResult1143 = smoothstep( 0.15 , 0.4 , lerpResult255);
			float SmoothnessColorMult1144 = smoothstepResult1143;
			float temp_output_1170_0 = max( saturate( Alpha1147 ) , ( max( saturate( ToonSpecular444 ) , RimAlpha1134 ) * SmoothnessColorMult1144 ) );
			float3 indirectNormal151 = worldNorm31;
			float4 tex2DNode386 = tex2D( _OcclusionMap, uv_MainTex );
			float Occlusion272 = (( 1.0 - _OcclusionStrength ) + (tex2DNode386.g - 0.0) * (1.0 - ( 1.0 - _OcclusionStrength )) / (1.0 - 0.0));
			Unity_GlossyEnvironmentData g151 = UnityGlossyEnvironmentSetup( Smoothness90, data.worldViewDir, indirectNormal151, float3(0,0,0));
			float3 indirectSpecular151 = UnityGI_IndirectSpecular( data, Occlusion272, indirectNormal151, g151 );
			float temp_output_208_0 = ( 1.0 - ( Smoothness90 * Smoothness90 ) );
			float temp_output_200_0 = max( ( 1.0 - ( temp_output_208_0 * temp_output_208_0 * temp_output_208_0 ) ) , 0.1 );
			float fresnelNdotV161 = dot( worldNorm31, ase_worldViewDir );
			float fresnelNode161 = ( 0.0 + temp_output_200_0 * pow( 1.0 - fresnelNdotV161, 4.0 ) );
			float smoothstepResult480 = smoothstep( 0.0 , 0.35 , fresnelNode161);
			float IndirectAlpha1165 = saturate( ( 0.01 + smoothstepResult480 ) );
			float4 temp_cast_242 = (IndirectAlpha1165).xxxx;
			float4 SpecularTex394 = ( tex2D( _SpecGlossMap, uv_MainTex ) * _SpecColor );
			float4 MainTex147_g4905 = MainTex224;
			int Band6_g4906 = _IridescentALAnimationBand;
			int Mode6_g4906 = ( ( _IridescentALAnimationMode * 2 ) + _IridescentALAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4906 = AudioLinkDecodeDataAsUInt6_g4906( Band6_g4906 , Mode6_g4906 );
			float localGetNetworkTime4_g4908 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_NETWORK_TIME ) );
			float localIfAudioLinkv2Exists1_g4909 = IfAudioLinkv2Exists1_g4909();
			float lerpResult118_g4905 = lerp( _Time.y , localGetNetworkTime4_g4908 , localIfAudioLinkv2Exists1_g4909);
			float lerpResult121_g4905 = lerp( ( ( ( localAudioLinkDecodeDataAsUInt6_g4906 % 628319 ) / 100000.0 ) * step( _IridescentALAnimationBand , 9 ) ) , lerpResult118_g4905 , (float)saturate( ( _IridescentALAnimationMode - 3 ) ));
			float EmissionGlowAnimation62_g4905 = ( _IridescentALAnimationStrength * lerpResult121_g4905 );
			float3 temp_output_21_0_g4905 = Normal243;
			float3 normalizeResult4_g4905 = normalize( ( WorldReflectionVector( i , temp_output_21_0_g4905 ) + ase_worldViewDir ) );
			float dotResult18_g4905 = dot( normalizeResult4_g4905 , ase_worldViewDir );
			float temp_output_197_0_g4905 = ( dotResult18_g4905 * 0.5 );
			float3 temp_output_165_0_g4905 = lightDir32;
			float3 normalizeResult168_g4905 = normalize( ( temp_output_165_0_g4905 + ase_worldViewDir ) );
			float3 wNorm170_g4905 = temp_output_21_0_g4905;
			float3 newWorldNormal169_g4905 = (WorldNormalVector( i , wNorm170_g4905 ));
			float dotResult172_g4905 = dot( normalizeResult168_g4905 , newWorldNormal169_g4905 );
			float Specular209_g4905 = max( dotResult172_g4905 , 0.0 );
			float dotResult177_g4905 = dot( temp_output_165_0_g4905 , newWorldNormal169_g4905 );
			float temp_output_182_0_g4905 = max( dotResult177_g4905 , 0.0 );
			float smoothstepResult194_g4905 = smoothstep( -0.125 , 0.5 , temp_output_182_0_g4905);
			float lerpResult630 = lerp( (ase_lightAtten*0.5 + 0.5) , ase_lightAtten , _WorldSpaceLightPos0.w);
			float lerpResult580 = lerp( 1.0 , lerpResult630 , staticSwitch575);
			float Attenuation533 = lerpResult580;
			float temp_output_208_0_g4905 = ( smoothstepResult194_g4905 * Attenuation533 );
			float lerpResult198_g4905 = lerp( temp_output_197_0_g4905 , Specular209_g4905 , temp_output_208_0_g4905);
			float lerpResult175_g4905 = lerp( dotResult18_g4905 , lerpResult198_g4905 , (float)saturate( _IridescentMode2 ));
			float lerpResult192_g4905 = lerp( temp_output_197_0_g4905 , temp_output_182_0_g4905 , temp_output_208_0_g4905);
			float lerpResult179_g4905 = lerp( lerpResult175_g4905 , lerpResult192_g4905 , (float)saturate( ( _IridescentMode2 - 1 ) ));
			float temp_output_211_0_g4905 = ( ( lerpResult179_g4905 * _IridescentScale ) + _IridescentOffset );
			float temp_output_34_0_g4905 = ( max( abs( sin( ( EmissionGlowAnimation62_g4905 + temp_output_211_0_g4905 ) ) ) , 0.0 ) * 2.0 );
			float temp_output_2_0_g4907 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 2.5 ) * temp_output_34_0_g4905 ) , 2.0 ) );
			float temp_output_41_0_g4905 = ( 1.0 - temp_output_2_0_g4907 );
			float4 lerpResult26_g4905 = lerp( _IridescentEmissionColor1 , _IridescentEmissionColor2 , temp_output_41_0_g4905);
			float temp_output_2_0_g4910 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 4.0 ) * max( ( temp_output_34_0_g4905 - 1.0 ) , 0.0 ) ) , 2.0 ) );
			float temp_output_38_0_g4905 = ( 1.0 - temp_output_2_0_g4910 );
			float4 lerpResult32_g4905 = lerp( lerpResult26_g4905 , _IridescentEmissionColor3 , temp_output_38_0_g4905);
			float4 Colors149_g4905 = lerpResult32_g4905;
			float3 hsvTorgb86_g4905 = RGBToHSV( Colors149_g4905.rgb );
			float3 hsvTorgb85_g4905 = RGBToHSV( MainTex147_g4905.rgb );
			float3 hsvTorgb87_g4905 = HSVToRGB( float3(hsvTorgb86_g4905.x,hsvTorgb85_g4905.y,hsvTorgb85_g4905.z) );
			float Intensity132_g4905 = _IridescentIntensity;
			float4 lerpResult205_g4905 = lerp( MainTex147_g4905 , float4( hsvTorgb87_g4905 , 0.0 ) , saturate( Intensity132_g4905 ));
			int temp_output_52_0_g4905 = ( _IridescentEmissionMode - 1 );
			int temp_output_90_0_g4905 = ( temp_output_52_0_g4905 - 1 );
			int temp_output_91_0_g4905 = saturate( temp_output_90_0_g4905 );
			int ModeTransferSat145_g4905 = temp_output_91_0_g4905;
			float4 lerpResult92_g4905 = lerp( MainTex147_g4905 , ( lerpResult205_g4905 * max( Intensity132_g4905 , 1.0 ) ) , (float)ModeTransferSat145_g4905);
			float AnimatedDot130_g4905 = ( temp_output_211_0_g4905 + EmissionGlowAnimation62_g4905 );
			float3 hsvTorgb99_g4905 = RGBToHSV( MainTex147_g4905.rgb );
			float3 hsvTorgb100_g4905 = HSVToRGB( float3(( AnimatedDot130_g4905 + hsvTorgb99_g4905.x ),hsvTorgb99_g4905.y,hsvTorgb99_g4905.y) );
			float4 lerpResult199_g4905 = lerp( MainTex147_g4905 , float4( hsvTorgb100_g4905 , 0.0 ) , saturate( Intensity132_g4905 ));
			float4 Holographic153_g4905 = ( lerpResult199_g4905 * max( Intensity132_g4905 , 1.0 ) );
			int ModeTransfer143_g4905 = temp_output_90_0_g4905;
			int temp_output_97_0_g4905 = ( ModeTransfer143_g4905 - 1 );
			float4 lerpResult96_g4905 = lerp( lerpResult92_g4905 , Holographic153_g4905 , (float)saturate( temp_output_97_0_g4905 ));
			float3 hsvTorgb124_g4905 = RGBToHSV( MainTex147_g4905.rgb );
			float3 hsvTorgb126_g4905 = HSVToRGB( float3(( hsvTorgb124_g4905.x + AnimatedDot130_g4905 ),hsvTorgb124_g4905.y,hsvTorgb124_g4905.z) );
			float4 lerpResult203_g4905 = lerp( MainTex147_g4905 , float4( hsvTorgb126_g4905 , 0.0 ) , saturate( Intensity132_g4905 ));
			float4 Hueshift152_g4905 = ( lerpResult203_g4905 * max( Intensity132_g4905 , 1.0 ) );
			float4 lerpResult127_g4905 = lerp( lerpResult96_g4905 , Hueshift152_g4905 , (float)saturate( ( temp_output_97_0_g4905 - 1 ) ));
			float GGXTerm1132 = localggx413;
			float temp_output_214_0_g4905 = GGXTerm1132;
			int temp_output_225_0_g4905 = saturate( _IridescenceLightMode );
			float lerpResult218_g4905 = lerp( 0.0 , temp_output_214_0_g4905 , (float)temp_output_225_0_g4905);
			float temp_output_215_0_g4905 = RimAlpha1134;
			int temp_output_220_0_g4905 = ( _IridescenceLightMode - 1 );
			float lerpResult219_g4905 = lerp( lerpResult218_g4905 , temp_output_215_0_g4905 , (float)saturate( temp_output_220_0_g4905 ));
			float lerpResult222_g4905 = lerp( lerpResult219_g4905 , max( temp_output_214_0_g4905 , temp_output_215_0_g4905 ) , (float)saturate( ( temp_output_220_0_g4905 - 1 ) ));
			float Atten232_g4905 = temp_output_208_0_g4905;
			float temp_output_233_0_g4905 = ( lerpResult222_g4905 * Atten232_g4905 );
			float4 lerpResult227_g4905 = lerp( MainTex147_g4905 , lerpResult127_g4905 , temp_output_233_0_g4905);
			float4 lerpResult236_g4905 = lerp( lerpResult127_g4905 , lerpResult227_g4905 , (float)temp_output_225_0_g4905);
			float2 uv_EffectMask = i.uv_texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float4 EffectMaskRGBA871 = tex2D( _EffectMask, uv_EffectMask );
			float4 break57_g4905 = EffectMaskRGBA871;
			int temp_output_18_0_g4911 = _IridescentMaskingChannel;
			float lerpResult1_g4911 = lerp( 1.0 , break57_g4905.r , (float)saturate( temp_output_18_0_g4911 ));
			int temp_output_5_0_g4911 = ( temp_output_18_0_g4911 - 1 );
			float lerpResult12_g4911 = lerp( lerpResult1_g4911 , break57_g4905.g , (float)saturate( temp_output_5_0_g4911 ));
			int temp_output_6_0_g4911 = ( temp_output_5_0_g4911 - 1 );
			float lerpResult10_g4911 = lerp( lerpResult12_g4911 , break57_g4905.b , (float)saturate( temp_output_6_0_g4911 ));
			float lerpResult11_g4911 = lerp( lerpResult10_g4911 , break57_g4905.a , (float)saturate( ( temp_output_6_0_g4911 - 1 ) ));
			float temp_output_55_0_g4905 = lerpResult11_g4911;
			float EffectMask140_g4905 = temp_output_55_0_g4905;
			float4 lerpResult95_g4905 = lerp( MainTex147_g4905 , lerpResult236_g4905 , EffectMask140_g4905);
			float4 lerpResult248_g4905 = lerp( MainTex147_g4905 , lerpResult95_g4905 , _Enableiridescence);
			float4 IridescentMainTex1049 = lerpResult248_g4905;
			float4 temp_output_227_0 = ( _Color * IridescentMainTex1049 );
			float MetallticFromTex247 = tex2DNode246.r;
			float metallic46 = ( _Metallic * MetallticFromTex247 );
			half3 specColor163 = (0).xxx;
			half oneMinusReflectivity163 = 0;
			half3 diffuseAndSpecularFromMetallic163 = DiffuseAndSpecularFromMetallic(temp_output_227_0.rgb,metallic46,specColor163,oneMinusReflectivity163);
			float lerpResult401 = lerp( 1.0 , metallic46 , _EnableSpecularMap);
			float4 lerpResult381 = lerp( SpecularTex394 , float4( specColor163 , 0.0 ) , lerpResult401);
			float4 specColor21191 = lerpResult381;
			float4 temp_cast_266 = (1.0).xxxx;
			float fresnelNdotV202 = dot( worldNorm31, ase_worldViewDir );
			float fresnelNode202 = ( 0.0 + temp_output_200_0 * pow( 1.0 - fresnelNdotV202, 5.0 ) );
			float smoothstepResult482 = smoothstep( 0.0 , 0.35 , fresnelNode202);
			float4 lerpResult213 = lerp( specColor21191 , temp_cast_266 , saturate( smoothstepResult482 ));
			float4 lerpResult204 = lerp( temp_cast_242 , lerpResult213 , metallic46);
			float lerpResult1192 = lerp( ( Smoothness90 * Smoothness90 ) , 1.0 , metallic46);
			float4 IndirectSpecular158 = ( float4( indirectSpecular151 , 0.0 ) * lerpResult204 * lerpResult1192 );
			float3 diffuse23 = diffuseAndSpecularFromMetallic163;
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1152 = temp_output_1170_0;
			#else
				float staticSwitch1152 = 1.0;
			#endif
			float Opacity1155 = staticSwitch1152;
			float4 specColor44 = ( lerpResult381 * SmoothnessColorMult1144 );
			float4 ColoredSpec987 = ( saturate( ( 1.2 * specColor44 ) ) * ToonSpecular444 );
			float3 temp_output_125_0_g4945 = ColoredSpec987.rgb;
			float3 SpecularIN194_g4945 = temp_output_125_0_g4945;
			float time2_g4945 = 0.0;
			float2 voronoiSmoothId2_g4945 = 0;
			float2 coords2_g4945 = i.uv_texcoord * _SparkleScale;
			float2 id2_g4945 = 0;
			float2 uv2_g4945 = 0;
			float voroi2_g4945 = voronoi2_g4945( coords2_g4945, time2_g4945, id2_g4945, uv2_g4945, 0, voronoiSmoothId2_g4945 );
			float2 ID44_g4945 = id2_g4945;
			float2 break71_g4945 = ( ID44_g4945 * float2( 360,360 ) );
			float cos68_g4945 = cos( radians( max( break71_g4945.x , break71_g4945.y ) ) );
			float sin68_g4945 = sin( radians( max( break71_g4945.x , break71_g4945.y ) ) );
			float2 rotator68_g4945 = mul( uv2_g4945 - float2( 0,0 ) , float2x2( cos68_g4945 , -sin68_g4945 , sin68_g4945 , cos68_g4945 )) + float2( 0,0 );
			float2 UV45_g4945 = rotator68_g4945;
			float mulTime14_g4945 = _Time.y * _SparkleSpeed;
			float simplePerlin2D37_g4945 = snoise( ( ( ID44_g4945 * _SparkleSeed ) + mulTime14_g4945 ) );
			simplePerlin2D37_g4945 = simplePerlin2D37_g4945*0.5 + 0.5;
			float Noise50_g4945 = ( _SparkleSize * simplePerlin2D37_g4945 );
			float smoothstepResult31_g4945 = smoothstep( 0.2 , 0.1 , ( length( UV45_g4945 ) - (-0.5 + (Noise50_g4945 - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) ));
			float Sphere52_g4945 = smoothstepResult31_g4945;
			float2 temp_cast_270 = (( 0.4 + (-0.5 + (Noise50_g4945 - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) )).xx;
			float2 temp_output_54_0_g4945 = ( abs( UV45_g4945 ) - temp_cast_270 );
			float2 temp_cast_271 = (( 0.4 + (-0.5 + (Noise50_g4945 - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) )).xx;
			float2 break59_g4945 = temp_output_54_0_g4945;
			float smoothstepResult62_g4945 = smoothstep( 0.01 , 0.0 , ( length( max( temp_output_54_0_g4945 , float2( 0,0 ) ) ) + min( max( break59_g4945.x , break59_g4945.y ) , 0.0 ) ));
			float Square63_g4945 = smoothstepResult62_g4945;
			float lerpResult111_g4945 = lerp( Sphere52_g4945 , Square63_g4945 , (float)saturate( _SparkleShape ));
			float2 p73_g4945 = UV45_g4945;
			float r73_g4945 = (-0.5 + (Noise50_g4945 - 0.0) * (0.5 - -0.5) / (1.0 - 0.0));
			float rf73_g4945 = 0.25;
			float localsdStar573_g4945 = sdStar5( p73_g4945 , r73_g4945 , rf73_g4945 );
			float smoothstepResult79_g4945 = smoothstep( 0.01 , 0.0 , localsdStar573_g4945);
			float Star80_g4945 = smoothstepResult79_g4945;
			int temp_output_114_0_g4945 = ( _SparkleShape - 1 );
			float lerpResult112_g4945 = lerp( lerpResult111_g4945 , Star80_g4945 , (float)saturate( temp_output_114_0_g4945 ));
			float temp_output_99_0_g4945 = (-0.25 + (Noise50_g4945 - 0.0) * (0.0 - -0.25) / (1.0 - 0.0));
			float2 p85_g4945 = ( UV45_g4945 * 2.15 );
			float localsdHeart85_g4945 = sdHeart( p85_g4945 );
			float smoothstepResult91_g4945 = smoothstep( ( temp_output_99_0_g4945 + 0.01 ) , temp_output_99_0_g4945 , ( localsdHeart85_g4945 / 2.15 ));
			float Heart90_g4945 = smoothstepResult91_g4945;
			float lerpResult113_g4945 = lerp( lerpResult112_g4945 , Heart90_g4945 , (float)saturate( ( temp_output_114_0_g4945 - 1 ) ));
			float4 temp_output_2_0_g4930 = EffectMaskRGBA871;
			float4 break120_g4945 = temp_output_2_0_g4930;
			int temp_output_18_0_g4946 = _SparkleMaskingChannel;
			float lerpResult1_g4946 = lerp( 1.0 , break120_g4945.r , (float)saturate( temp_output_18_0_g4946 ));
			int temp_output_5_0_g4946 = ( temp_output_18_0_g4946 - 1 );
			float lerpResult12_g4946 = lerp( lerpResult1_g4946 , break120_g4945.g , (float)saturate( temp_output_5_0_g4946 ));
			int temp_output_6_0_g4946 = ( temp_output_5_0_g4946 - 1 );
			float lerpResult10_g4946 = lerp( lerpResult12_g4946 , break120_g4945.b , (float)saturate( temp_output_6_0_g4946 ));
			float lerpResult11_g4946 = lerp( lerpResult10_g4946 , break120_g4945.a , (float)saturate( ( temp_output_6_0_g4946 - 1 ) ));
			float SparkleAlpha129_g4945 = ( lerpResult113_g4945 * lerpResult11_g4946 );
			float4 temp_cast_280 = (1.0).xxxx;
			float4 temp_cast_282 = (1.0).xxxx;
			float3 temp_cast_283 = (1.0).xxx;
			int EmissionGlowZone47_g4947 = _SparkleGlowZone;
			int clampResult8_g4953 = clamp( EmissionGlowZone47_g4947 , 1 , 4 );
			int temp_output_3_0_g4953 = ( clampResult8_g4953 - 1 );
			int Zone16_g4953 = temp_output_3_0_g4953;
			float3 localgetThemeData16_g4953 = getThemeData( Zone16_g4953 );
			int Band11_g4954 = 56;
			int localIsLumaActive11_g4954 = IsLumaActive11_g4954( Band11_g4954 );
			int temp_output_14_0_g4953 = localIsLumaActive11_g4954;
			int lerpResult15_g4953 = lerp( temp_output_3_0_g4953 , ( 63 - temp_output_3_0_g4953 ) , (float)temp_output_14_0_g4953);
			int Band2_g4953 = lerpResult15_g4953;
			int Delay2_g4953 = 0;
			float3 localLumaGlowData2_g4953 = LumaGlowData2_g4953( Band2_g4953 , Delay2_g4953 );
			float3 lerpResult17_g4953 = lerp( ( localgetThemeData16_g4953 * localLumaGlowData2_g4953 ) , localLumaGlowData2_g4953 , (float)temp_output_14_0_g4953);
			int temp_output_21_0_g4947 = saturate( EmissionGlowZone47_g4947 );
			float3 lerpResult20_g4947 = lerp( temp_cast_283 , lerpResult17_g4953 , (float)temp_output_21_0_g4947);
			float3 temp_cast_287 = (1.0).xxx;
			int clampResult8_g4955 = clamp( EmissionGlowZone47_g4947 , 1 , 4 );
			int temp_output_3_0_g4955 = ( clampResult8_g4955 - 1 );
			int Zone15_g4955 = temp_output_3_0_g4955;
			float3 localgetThemeData15_g4955 = getThemeData( Zone15_g4955 );
			int Band11_g4956 = 56;
			int localIsLumaActive11_g4956 = IsLumaActive11_g4956( Band11_g4956 );
			int temp_output_13_0_g4955 = localIsLumaActive11_g4956;
			int lerpResult14_g4955 = lerp( temp_output_3_0_g4955 , ( 63 - temp_output_3_0_g4955 ) , (float)temp_output_13_0_g4955);
			int Band11_g4955 = lerpResult14_g4955;
			float cos6_g4947 = cos( radians( _SparkleGlowPulseDir ) );
			float sin6_g4947 = sin( radians( _SparkleGlowPulseDir ) );
			float2 rotator6_g4947 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4947 , -sin6_g4947 , sin6_g4947 , cos6_g4947 )) + float2( 0.5,0.5 );
			int Band6_g4960 = _SparkleGlowAnimationBand;
			int Mode6_g4960 = ( ( _SparkleGlowAnimationMode * 2 ) + _SparkleGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4960 = AudioLinkDecodeDataAsUInt6_g4960( Band6_g4960 , Mode6_g4960 );
			float localGetLocalTime2_g4961 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4947 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4960 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4961 , (float)saturate( ( _SparkleGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4947 = ( _SparkleGlowAnimationStrength * lerpResult206_g4947 * step( _SparkleGlowAnimationBand , 9 ) );
			float x13_g4947 = ( ( rotator6_g4947.x * _SparkleGlowPulseScale ) + _SparkleGlowPulseOffset + EmissionGlowAnimation195_g4947 );
			float y13_g4947 = 127.0;
			float localglslmod13_g4947 = glslmod13_g4947( x13_g4947 , y13_g4947 );
			float2 CenteredUV15_g4949 = ( i.uv_texcoord - _SparkleGlowRadialCenter );
			float2 break17_g4949 = CenteredUV15_g4949;
			float2 appendResult23_g4949 = (float2(( length( CenteredUV15_g4949 ) * _SparkleGlowPulseScale * 2.0 ) , ( atan2( break17_g4949.x , break17_g4949.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4947 = ( _SparkleGlowPulseOffset + appendResult23_g4949.x + EmissionGlowAnimation195_g4947 );
			float y12_g4947 = 127.0;
			float localglslmod12_g4947 = glslmod12_g4947( x12_g4947 , y12_g4947 );
			int EmissionGlowMode35_g4947 = _SparkleGlowMode;
			int temp_output_37_0_g4947 = ( EmissionGlowMode35_g4947 - 1 );
			float lerpResult5_g4947 = lerp( localglslmod13_g4947 , localglslmod12_g4947 , (float)saturate( temp_output_37_0_g4947 ));
			float2 uv_DirectionalMap = i.uv_texcoord * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float Direction27_g4606 = tex2D( _DirectionalMap, uv_DirectionalMap ).r;
			float temp_output_1074_244 = Direction27_g4606;
			float DirectionMap1031 = temp_output_1074_244;
			float temp_output_23_0_g4930 = DirectionMap1031;
			float DirectionalMap106_g4947 = temp_output_23_0_g4930;
			float lerpResult179_g4947 = lerp( DirectionalMap106_g4947 , ( 1.0 - DirectionalMap106_g4947 ) , (float)saturate( ( EmissionGlowMode35_g4947 - 3 ) ));
			float x34_g4947 = ( _SparkleGlowPulseOffset + ( _SparkleGlowPulseScale * lerpResult179_g4947 ) + EmissionGlowAnimation195_g4947 );
			float y34_g4947 = 127.0;
			float localglslmod34_g4947 = glslmod34_g4947( x34_g4947 , y34_g4947 );
			float lerpResult30_g4947 = lerp( lerpResult5_g4947 , localglslmod34_g4947 , (float)saturate( ( temp_output_37_0_g4947 - 1 ) ));
			float EmissionGlowDelay56_g4947 = lerpResult30_g4947;
			float Delay11_g4955 = EmissionGlowDelay56_g4947;
			float3 localLumaGlowLerp11_g4955 = LumaGlowLerp11_g4955( Band11_g4955 , Delay11_g4955 );
			float3 lerpResult17_g4955 = lerp( ( localgetThemeData15_g4955 * localLumaGlowLerp11_g4955 ) , localLumaGlowLerp11_g4955 , (float)temp_output_13_0_g4955);
			float3 lerpResult22_g4947 = lerp( temp_cast_287 , lerpResult17_g4955 , (float)temp_output_21_0_g4947);
			float3 lerpResult23_g4947 = lerp( lerpResult20_g4947 , lerpResult22_g4947 , (float)saturate( EmissionGlowMode35_g4947 ));
			float4 temp_cast_297 = (1.0).xxxx;
			float temp_output_10_0_g4957 = EmissionGlowDelay56_g4947;
			float Position1_g4959 = ( temp_output_10_0_g4957 / 127.0 );
			float4 localAudioLinkLerp1_g4959 = AudioLinkLerp1_g4959( Position1_g4959 );
			int clampResult8_g4957 = clamp( ( EmissionGlowZone47_g4947 - 4 ) , 1 , 3 );
			int Band11_g4957 = ( 59 - ( clampResult8_g4957 - 1 ) );
			float Delay11_g4957 = temp_output_10_0_g4957;
			float3 localLumaGlowLerp11_g4957 = LumaGlowLerp11_g4957( Band11_g4957 , Delay11_g4957 );
			int Band11_g4958 = 56;
			int localIsLumaActive11_g4958 = IsLumaActive11_g4958( Band11_g4958 );
			float4 lerpResult14_g4957 = lerp( localAudioLinkLerp1_g4959 , float4( localLumaGlowLerp11_g4957 , 0.0 ) , (float)localIsLumaActive11_g4958);
			float4 lerpResult52_g4947 = lerp( temp_cast_297 , lerpResult14_g4957 , (float)saturate( EmissionGlowZone47_g4947 ));
			float4 lerpResult51_g4947 = lerp( float4( lerpResult23_g4947 , 0.0 ) , lerpResult52_g4947 , (float)saturate( ( EmissionGlowZone47_g4947 - 4 ) ));
			float4 temp_cast_302 = (_SparkleGlowMinBrightness).xxxx;
			float4 temp_cast_303 = (( _SparkleGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_258_0_g4947 = saturate( EmissionGlowZone47_g4947 );
			float4 EmissionGlow142_g4947 = ( (temp_cast_302 + (lerpResult51_g4947 - float4( 0,0,0,0 )) * (temp_cast_303 - temp_cast_302) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _SparkleGlowTint * temp_output_258_0_g4947 );
			float4 lerpResult261_g4947 = lerp( temp_cast_282 , EmissionGlow142_g4947 , (float)temp_output_258_0_g4947);
			float4 EmissionGlowTog262_g4947 = lerpResult261_g4947;
			int EmissionReactiveBand243_g4947 = _SparkleReactiveBand;
			int Band3_g4948 = EmissionReactiveBand243_g4947;
			int Delay3_g4948 = 0;
			float localAudioLinkData3_g4948 = AudioLinkData3_g4948( Band3_g4948 , Delay3_g4948 );
			int temp_output_64_0_g4947 = step( _SparkleReactiveBand , 9 );
			float lerpResult66_g4947 = lerp( 1.0 , localAudioLinkData3_g4948 , (float)temp_output_64_0_g4947);
			int Band3_g4950 = _SparkleReactiveBand;
			float cos78_g4947 = cos( radians( _SparkleReactivePulseDir ) );
			float sin78_g4947 = sin( radians( _SparkleReactivePulseDir ) );
			float2 rotator78_g4947 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4947 , -sin78_g4947 , sin78_g4947 , cos78_g4947 )) + float2( 0.5,0.5 );
			float x96_g4947 = ( ( rotator78_g4947.x * _SparkleReactivePulseScale ) + _SparkleReactivePulseOffset );
			float y96_g4947 = 127.0;
			float localglslmod96_g4947 = glslmod96_g4947( x96_g4947 , y96_g4947 );
			float2 CenteredUV15_g4951 = ( i.uv_texcoord - _SparkleReactiveRadialCenter );
			float2 break17_g4951 = CenteredUV15_g4951;
			float2 appendResult23_g4951 = (float2(( length( CenteredUV15_g4951 ) * _SparkleReactivePulseScale * 2.0 ) , ( atan2( break17_g4951.x , break17_g4951.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4947 = ( _SparkleReactivePulseOffset + appendResult23_g4951.x );
			float y97_g4947 = 127.0;
			float localglslmod97_g4947 = glslmod97_g4947( x97_g4947 , y97_g4947 );
			int EmissionReactiveMode99_g4947 = _SparkleReactiveMode;
			int temp_output_90_0_g4947 = ( EmissionReactiveMode99_g4947 - 1 );
			float lerpResult77_g4947 = lerp( localglslmod96_g4947 , localglslmod97_g4947 , (float)saturate( temp_output_90_0_g4947 ));
			float lerpResult174_g4947 = lerp( DirectionalMap106_g4947 , ( 1.0 - DirectionalMap106_g4947 ) , (float)saturate( ( EmissionReactiveMode99_g4947 - 3 ) ));
			float x98_g4947 = ( _SparkleReactivePulseOffset + ( _SparkleReactivePulseScale * lerpResult174_g4947 ) );
			float y98_g4947 = 127.0;
			float localglslmod98_g4947 = glslmod98_g4947( x98_g4947 , y98_g4947 );
			float lerpResult87_g4947 = lerp( lerpResult77_g4947 , localglslmod98_g4947 , (float)saturate( ( temp_output_90_0_g4947 - 1 ) ));
			float Delay3_g4950 = lerpResult87_g4947;
			float localAudioLinkLerp3_g4950 = AudioLinkLerp3_g4950( Band3_g4950 , Delay3_g4950 );
			float lerpResult102_g4947 = lerp( 1.0 , localAudioLinkLerp3_g4950 , (float)temp_output_64_0_g4947);
			float lerpResult103_g4947 = lerp( lerpResult66_g4947 , lerpResult102_g4947 , (float)saturate( EmissionReactiveMode99_g4947 ));
			int Band3_g4952 = _SparkleReactiveBand;
			float FilteredAmount3_g4952 = ( ( 1.0 - _SparkleReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4952 = AudioLinkLerp3_g4952( Band3_g4952 , FilteredAmount3_g4952 );
			float lerpResult168_g4947 = lerp( 1.0 , localAudioLinkLerp3_g4952 , (float)temp_output_64_0_g4947);
			float lerpResult172_g4947 = lerp( lerpResult103_g4947 , lerpResult168_g4947 , (float)saturate( ( EmissionReactiveMode99_g4947 - 4 ) ));
			float ReactivityAlpha132_g4947 = (_SparkleReactiveMinBrightness + (lerpResult172_g4947 - 0.0) * (( _SparkleReactiveMinBrightness + 1.0 ) - _SparkleReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_314 = (1.0).xxxx;
			float4 lerpResult268_g4947 = lerp( temp_cast_314 , _SparkleReactiveTint , (float)step( EmissionReactiveBand243_g4947 , 9 ));
			float4 FinalReactivity68_g4947 = ( ReactivityAlpha132_g4947 * lerpResult268_g4947 );
			float4 lerpResult146_g4947 = lerp( ( EmissionGlowTog262_g4947 * FinalReactivity68_g4947 ) , ( EmissionGlow142_g4947 + FinalReactivity68_g4947 ) , (float)saturate( _SparkleReactiveBlendMode ));
			float4 ReversedReactivity152_g4947 = ( ( 1.0 - ReactivityAlpha132_g4947 ) * lerpResult268_g4947 );
			int temp_output_157_0_g4947 = ( _SparkleReactiveBlendMode - 1 );
			float4 lerpResult114_g4947 = lerp( lerpResult146_g4947 , ( EmissionGlowTog262_g4947 * ReversedReactivity152_g4947 ) , (float)saturate( temp_output_157_0_g4947 ));
			int temp_output_255_0_g4947 = step( EmissionReactiveBand243_g4947 , 9 );
			float4 lerpResult164_g4947 = lerp( lerpResult114_g4947 , ( EmissionGlow142_g4947 + ( ReversedReactivity152_g4947 * temp_output_255_0_g4947 ) ) , (float)max( saturate( ( temp_output_157_0_g4947 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g4947 , 9 ) ) ));
			float4 lerpResult280_g4947 = lerp( _SparkleGlowTint , lerpResult164_g4947 , (float)max( temp_output_255_0_g4947 , saturate( EmissionGlowZone47_g4947 ) ));
			float localIfAudioLinkv2Exists1_g4962 = IfAudioLinkv2Exists1_g4962();
			float4 lerpResult275_g4947 = lerp( temp_cast_280 , ( lerpResult280_g4947 * SparkleAlpha129_g4945 ) , localIfAudioLinkv2Exists1_g4962);
			float localIfAudioLinkv2Exists1_g4963 = IfAudioLinkv2Exists1_g4963();
			float4 lerpResult172_g4945 = lerp( ( _SparkleColor * SparkleAlpha129_g4945 ) , lerpResult275_g4947 , ( saturate( EmissionGlowZone47_g4947 ) * localIfAudioLinkv2Exists1_g4963 ));
			float4 Sparkles152_g4945 = lerpResult172_g4945;
			float4 lerpResult190_g4945 = lerp( ( Sparkles152_g4945 * float4( temp_output_125_0_g4945 , 0.0 ) ) , ( Sparkles152_g4945 + float4( temp_output_125_0_g4945 , 0.0 ) ) , (float)_SparkleBlendMode);
			float4 SpecularSparkles142_g4945 = lerpResult190_g4945;
			int temp_output_133_0_g4945 = saturate( _SparkleMode );
			float4 lerpResult127_g4945 = lerp( float4( SpecularIN194_g4945 , 0.0 ) , SpecularSparkles142_g4945 , (float)temp_output_133_0_g4945);
			int temp_output_137_0_g4945 = ( _SparkleMode - 1 );
			float4 lerpResult198_g4945 = lerp( lerpResult127_g4945 , float4( SpecularIN194_g4945 , 0.0 ) , (float)saturate( temp_output_137_0_g4945 ));
			int temp_output_150_0_g4945 = ( temp_output_137_0_g4945 - 1 );
			int temp_output_151_0_g4945 = saturate( temp_output_150_0_g4945 );
			float4 lerpResult149_g4945 = lerp( lerpResult198_g4945 , SpecularSparkles142_g4945 , (float)temp_output_151_0_g4945);
			int temp_output_160_0_g4945 = saturate( ( temp_output_150_0_g4945 - 1 ) );
			float4 lerpResult153_g4945 = lerp( lerpResult149_g4945 , SpecularSparkles142_g4945 , (float)temp_output_160_0_g4945);
			#ifdef _SPARKLES
				float4 staticSwitch173_g4945 = lerpResult153_g4945;
			#else
				float4 staticSwitch173_g4945 = float4( SpecularIN194_g4945 , 0.0 );
			#endif
			float4 SpecEffects1117 = staticSwitch173_g4945;
			float3 N123 = SpecEffects1117.xyz;
			float k379 = roughness17;
			float dotResult14 = dot( worldNorm31 , lightDir32 );
			float NdotL39 = max( dotResult14 , 0.0 );
			float smoothstepResult460 = smoothstep( 0.125 , 0.15 , NdotL39);
			float lerpResult636 = lerp( (smoothstepResult460*0.5 + 0.5) , smoothstepResult460 , _WorldSpaceLightPos0.w);
			float ToonNdotL514 = lerpResult636;
			float NdotL379 = ToonNdotL514;
			float dotResult24 = dot( worldNorm31 , viewDir29 );
			float NdotV11 = max( dotResult24 , 0.0 );
			float NdotV379 = NdotV11;
			float localSchlickGGX379 = SchlickGGX( k379 , NdotL379 , NdotV379 );
			float G123 = localSchlickGGX379;
			float NdotL138 = ToonNdotL514;
			float smoothstepResult461 = smoothstep( 0.0 , 0.25 , NdotV11);
			float ToonNdotV565 = smoothstepResult461;
			float NdotV138 = ToonNdotV565;
			float LdotH138 = NdotH38;
			float roughness138 = roughness17;
			float localF0138 = F0138( NdotL138 , NdotV138 , LdotH138 , roughness138 );
			float F123 = localF0138;
			float NdotL123 = lerpResult636;
			float NdotV123 = NdotV11;
			float3 localBRDF123 = BRDF( N123 , G123 , F123 , NdotL123 , NdotV123 );
			float3 temp_cast_333 = (0.001).xxx;
			float4 appendResult511 = (float4(-lightDir32 , 1.0));
			float4 uvw501 = appendResult511;
			float3 localgetProbes501 = getProbes( uvw501 );
			float4 appendResult517 = (float4(lightDir32 , 1.0));
			float4 uvw518 = appendResult517;
			float3 localgetProbes518 = getProbes( uvw518 );
			float3 lerpResult520 = lerp( ( localgetProbes501 * 0.65 ) , localgetProbes518 , ( ToonNdotL514 * Attenuation533 ));
			float3 uvw1204 = (WorldNormalVector( i , Normal243 ));
			float3 localReflectionProbeSample1204 = ReflectionProbeSample( uvw1204 );
			float3 lerpResult1206 = lerp( lerpResult520 , localReflectionProbeSample1204 , 0.5);
			float3 ToonAmbience521 = lerpResult1206;
			float4 lerpResult578 = lerp( float4( ToonAmbience521 , 0.0 ) , ase_lightColor , staticSwitch575);
			float4 InitialLightColor589 = ( lerpResult578 * Attenuation533 );
			float4 lightColor45 = InitialLightColor589;
			float4 BRDF219 = ( float4( ( ( diffuse23 * Occlusion272 * Opacity1155 ) + ( max( localBRDF123 , temp_cast_333 ) * smoothstepResult460 * Attenuation533 ) ) , 0.0 ) * ( float4( ToonAmbience521 , 0.0 ) + ( lightColor45 * ToonNdotL514 ) ) );
			float4 lerpResult182_g4945 = lerp( Sparkles152_g4945 , float4( 0,0,0,0 ) , (float)temp_output_133_0_g4945);
			#ifdef UNITY_PASS_FORWARDBASE
				float4 staticSwitch177_g4945 = Sparkles152_g4945;
			#else
				float4 staticSwitch177_g4945 = float4( 0,0,0,0 );
			#endif
			float4 lerpResult185_g4945 = lerp( lerpResult182_g4945 , staticSwitch177_g4945 , (float)temp_output_160_0_g4945);
			#ifdef _SPARKLES
				float4 staticSwitch178_g4945 = lerpResult185_g4945;
			#else
				float4 staticSwitch178_g4945 = float4( 0,0,0,0 );
			#endif
			int Band6_g4942 = _RainbowALAnimationBand;
			int Mode6_g4942 = ( ( _RainbowALAnimationMode * 2 ) + _RainbowALAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4942 = AudioLinkDecodeDataAsUInt6_g4942( Band6_g4942 , Mode6_g4942 );
			float localGetNetworkTime4_g4944 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_NETWORK_TIME ) );
			float localIfAudioLinkv2Exists1_g4943 = IfAudioLinkv2Exists1_g4943();
			float temp_output_95_0_g4939 = localIfAudioLinkv2Exists1_g4943;
			float lerpResult94_g4939 = lerp( _Time.y , localGetNetworkTime4_g4944 , temp_output_95_0_g4939);
			float lerpResult66_g4939 = lerp( ( ( ( localAudioLinkDecodeDataAsUInt6_g4942 % 628319 ) / 100000.0 ) * step( _RainbowALAnimationBand , 9 ) ) , lerpResult94_g4939 , (float)saturate( ( _RainbowALAnimationMode - 3 ) ));
			float lerpResult96_g4939 = lerp( _Time.y , lerpResult66_g4939 , temp_output_95_0_g4939);
			float EmissionGlowAnimation67_g4939 = ( _RainbowALAnimationStrength * lerpResult96_g4939 );
			float cos45_g4939 = cos( radians( _RainbowRotation ) );
			float sin45_g4939 = sin( radians( _RainbowRotation ) );
			float2 rotator45_g4939 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos45_g4939 , -sin45_g4939 , sin45_g4939 , cos45_g4939 )) + float2( 0.5,0.5 );
			float2 CenteredUV15_g4941 = ( i.uv_texcoord - _RainbowRadialCenter );
			float2 break17_g4941 = CenteredUV15_g4941;
			float2 appendResult23_g4941 = (float2(( length( CenteredUV15_g4941 ) * _RainbowSpiralCurve * 2.0 ) , ( atan2( break17_g4941.x , break17_g4941.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float2 break50_g4939 = appendResult23_g4941;
			float lerpResult49_g4939 = lerp( rotator45_g4939.x , break50_g4939.x , (float)saturate( _RainbowUVMode ));
			int temp_output_60_0_g4939 = ( _RainbowUVMode - 1 );
			float lerpResult63_g4939 = lerp( lerpResult49_g4939 , ( break50_g4939.x + ( break50_g4939.y * ( 2.0 * UNITY_PI ) ) ) , (float)saturate( temp_output_60_0_g4939 ));
			float temp_output_85_0_g4939 = temp_output_23_0_g4930;
			int temp_output_81_0_g4939 = ( temp_output_60_0_g4939 - 1 );
			float lerpResult79_g4939 = lerp( lerpResult63_g4939 , temp_output_85_0_g4939 , (float)saturate( temp_output_81_0_g4939 ));
			float lerpResult80_g4939 = lerp( lerpResult79_g4939 , ( 1.0 - temp_output_85_0_g4939 ) , (float)saturate( ( temp_output_81_0_g4939 - 1 ) ));
			float temp_output_24_0_g4939 = ( ( 1.0 - _RainbowHueRange ) * 0.5 );
			float3 hsvTorgb3_g4939 = HSVToRGB( float3(( (temp_output_24_0_g4939 + (sin( ( EmissionGlowAnimation67_g4939 + ( lerpResult80_g4939 * _RainbowScale ) ) ) - -1.0) * (( 1.0 - temp_output_24_0_g4939 ) - temp_output_24_0_g4939) / (1.0 - -1.0)) + _RainbowHue ),_RainbowSaturation,_RainbowValue) );
			float4 EffectMaskRGBA8_g4930 = temp_output_2_0_g4930;
			float4 break38_g4939 = EffectMaskRGBA8_g4930;
			int temp_output_18_0_g4940 = _RainbowMaskingChannel;
			float lerpResult1_g4940 = lerp( 1.0 , break38_g4939.r , (float)saturate( temp_output_18_0_g4940 ));
			int temp_output_5_0_g4940 = ( temp_output_18_0_g4940 - 1 );
			float lerpResult12_g4940 = lerp( lerpResult1_g4940 , break38_g4939.g , (float)saturate( temp_output_5_0_g4940 ));
			int temp_output_6_0_g4940 = ( temp_output_5_0_g4940 - 1 );
			float lerpResult10_g4940 = lerp( lerpResult12_g4940 , break38_g4939.b , (float)saturate( temp_output_6_0_g4940 ));
			float lerpResult11_g4940 = lerp( lerpResult10_g4940 , break38_g4939.a , (float)saturate( ( temp_output_6_0_g4940 - 1 ) ));
			float3 lerpResult98_g4939 = lerp( float3( 0,0,0 ) , ( hsvTorgb3_g4939 * lerpResult11_g4940 ) , _EnableScrollingRainbow);
			#ifdef UNITY_PASS_FORWARDBASE
				float3 staticSwitch35_g4930 = lerpResult98_g4939;
			#else
				float3 staticSwitch35_g4930 = float3( 0,0,0 );
			#endif
			float dotResult617 = dot( worldNorm31 , lightDir32 );
			float dotResult610 = dot( worldNorm31 , float3(0,1,0) );
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch625 = max( ( dotResult610 + 0.5 ) , 0.0 );
			#else
				float staticSwitch625 = 1.0;
			#endif
			float4 Rimlighting557 = ( max( dotResult617 , 0.0 ) * temp_output_547_0 * ( ( lightColor45 + float4( ToonAmbience521 , 0.0 ) ) / 2.0 ) * _RimlightColor * specColor21191 * staticSwitch625 );
			float3 temp_output_126_0_g4945 = Rimlighting557.rgb;
			float3 RimlightIN195_g4945 = temp_output_126_0_g4945;
			float4 lerpResult191_g4945 = lerp( ( Sparkles152_g4945 * float4( temp_output_126_0_g4945 , 0.0 ) ) , ( Sparkles152_g4945 + float4( temp_output_126_0_g4945 , 0.0 ) ) , (float)_SparkleBlendMode);
			float4 RimlightSparkles143_g4945 = lerpResult191_g4945;
			float4 lerpResult136_g4945 = lerp( float4( RimlightIN195_g4945 , 0.0 ) , RimlightSparkles143_g4945 , (float)saturate( temp_output_137_0_g4945 ));
			float4 lerpResult181_g4945 = lerp( lerpResult136_g4945 , RimlightSparkles143_g4945 , (float)temp_output_151_0_g4945);
			float4 lerpResult183_g4945 = lerp( lerpResult181_g4945 , RimlightSparkles143_g4945 , (float)temp_output_160_0_g4945);
			#ifdef _SPARKLES
				float4 staticSwitch187_g4945 = lerpResult183_g4945;
			#else
				float4 staticSwitch187_g4945 = float4( RimlightIN195_g4945 , 0.0 );
			#endif
			float4 RimlightEffects1118 = staticSwitch187_g4945;
			c.rgb = ( IndirectSpecular158 + BRDF219 + ( staticSwitch178_g4945 + float4( staticSwitch35_g4930 , 0.0 ) ) + RimlightEffects1118 ).rgb;
			c.a = temp_output_1170_0;
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
			float4 MainTex224 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = MainTex224.rgb;
			float4 temp_cast_1 = (1.0).xxxx;
			float3 temp_cast_2 = (1.0).xxx;
			int EmissionGlowZone47_g4623 = _RedChGlowZone;
			int clampResult8_g4629 = clamp( EmissionGlowZone47_g4623 , 1 , 4 );
			int temp_output_3_0_g4629 = ( clampResult8_g4629 - 1 );
			int Zone16_g4629 = temp_output_3_0_g4629;
			float3 localgetThemeData16_g4629 = getThemeData( Zone16_g4629 );
			int Band11_g4630 = 56;
			int localIsLumaActive11_g4630 = IsLumaActive11_g4630( Band11_g4630 );
			int temp_output_14_0_g4629 = localIsLumaActive11_g4630;
			int lerpResult15_g4629 = lerp( temp_output_3_0_g4629 , ( 63 - temp_output_3_0_g4629 ) , (float)temp_output_14_0_g4629);
			int Band2_g4629 = lerpResult15_g4629;
			int Delay2_g4629 = 0;
			float3 localLumaGlowData2_g4629 = LumaGlowData2_g4629( Band2_g4629 , Delay2_g4629 );
			float3 lerpResult17_g4629 = lerp( ( localgetThemeData16_g4629 * localLumaGlowData2_g4629 ) , localLumaGlowData2_g4629 , (float)temp_output_14_0_g4629);
			int temp_output_21_0_g4623 = saturate( EmissionGlowZone47_g4623 );
			float3 lerpResult20_g4623 = lerp( temp_cast_2 , lerpResult17_g4629 , (float)temp_output_21_0_g4623);
			float3 temp_cast_6 = (1.0).xxx;
			int clampResult8_g4631 = clamp( EmissionGlowZone47_g4623 , 1 , 4 );
			int temp_output_3_0_g4631 = ( clampResult8_g4631 - 1 );
			int Zone15_g4631 = temp_output_3_0_g4631;
			float3 localgetThemeData15_g4631 = getThemeData( Zone15_g4631 );
			int Band11_g4632 = 56;
			int localIsLumaActive11_g4632 = IsLumaActive11_g4632( Band11_g4632 );
			int temp_output_13_0_g4631 = localIsLumaActive11_g4632;
			int lerpResult14_g4631 = lerp( temp_output_3_0_g4631 , ( 63 - temp_output_3_0_g4631 ) , (float)temp_output_13_0_g4631);
			int Band11_g4631 = lerpResult14_g4631;
			float cos6_g4623 = cos( radians( _RedChGlowPulseDir ) );
			float sin6_g4623 = sin( radians( _RedChGlowPulseDir ) );
			float2 rotator6_g4623 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4623 , -sin6_g4623 , sin6_g4623 , cos6_g4623 )) + float2( 0.5,0.5 );
			int Band6_g4636 = _RedChGlowAnimationBand;
			int Mode6_g4636 = ( ( _RedChGlowAnimationMode * 2 ) + _RedChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4636 = AudioLinkDecodeDataAsUInt6_g4636( Band6_g4636 , Mode6_g4636 );
			float localGetLocalTime2_g4637 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4623 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4636 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4637 , (float)saturate( ( _RedChGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4623 = ( _RedChGlowAnimationStrength * lerpResult206_g4623 * step( _RedChGlowAnimationBand , 9 ) );
			float x13_g4623 = ( ( rotator6_g4623.x * _RedChGlowPulseScale ) + _RedChGlowPulseOffset + EmissionGlowAnimation195_g4623 );
			float y13_g4623 = 127.0;
			float localglslmod13_g4623 = glslmod13_g4623( x13_g4623 , y13_g4623 );
			float2 CenteredUV15_g4625 = ( i.uv_texcoord - _RedChGlowRadialCenter );
			float2 break17_g4625 = CenteredUV15_g4625;
			float2 appendResult23_g4625 = (float2(( length( CenteredUV15_g4625 ) * _RedChGlowPulseScale * 2.0 ) , ( atan2( break17_g4625.x , break17_g4625.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4623 = ( _RedChGlowPulseOffset + appendResult23_g4625.x + EmissionGlowAnimation195_g4623 );
			float y12_g4623 = 127.0;
			float localglslmod12_g4623 = glslmod12_g4623( x12_g4623 , y12_g4623 );
			int EmissionGlowMode35_g4623 = _RedChGlowMode;
			int temp_output_37_0_g4623 = ( EmissionGlowMode35_g4623 - 1 );
			float lerpResult5_g4623 = lerp( localglslmod13_g4623 , localglslmod12_g4623 , (float)saturate( temp_output_37_0_g4623 ));
			float2 uv_DirectionalMap = i.uv_texcoord * _DirectionalMap_ST.xy + _DirectionalMap_ST.zw;
			float Direction27_g4606 = tex2D( _DirectionalMap, uv_DirectionalMap ).r;
			float DirectionalMap106_g4623 = Direction27_g4606;
			float lerpResult179_g4623 = lerp( DirectionalMap106_g4623 , ( 1.0 - DirectionalMap106_g4623 ) , (float)saturate( ( EmissionGlowMode35_g4623 - 3 ) ));
			float x34_g4623 = ( _RedChGlowPulseOffset + ( _RedChGlowPulseScale * lerpResult179_g4623 ) + EmissionGlowAnimation195_g4623 );
			float y34_g4623 = 127.0;
			float localglslmod34_g4623 = glslmod34_g4623( x34_g4623 , y34_g4623 );
			float lerpResult30_g4623 = lerp( lerpResult5_g4623 , localglslmod34_g4623 , (float)saturate( ( temp_output_37_0_g4623 - 1 ) ));
			float EmissionGlowDelay56_g4623 = lerpResult30_g4623;
			float Delay11_g4631 = EmissionGlowDelay56_g4623;
			float3 localLumaGlowLerp11_g4631 = LumaGlowLerp11_g4631( Band11_g4631 , Delay11_g4631 );
			float3 lerpResult17_g4631 = lerp( ( localgetThemeData15_g4631 * localLumaGlowLerp11_g4631 ) , localLumaGlowLerp11_g4631 , (float)temp_output_13_0_g4631);
			float3 lerpResult22_g4623 = lerp( temp_cast_6 , lerpResult17_g4631 , (float)temp_output_21_0_g4623);
			float3 lerpResult23_g4623 = lerp( lerpResult20_g4623 , lerpResult22_g4623 , (float)saturate( EmissionGlowMode35_g4623 ));
			float4 temp_cast_16 = (1.0).xxxx;
			float temp_output_10_0_g4633 = EmissionGlowDelay56_g4623;
			float Position1_g4635 = ( temp_output_10_0_g4633 / 127.0 );
			float4 localAudioLinkLerp1_g4635 = AudioLinkLerp1_g4635( Position1_g4635 );
			int clampResult8_g4633 = clamp( ( EmissionGlowZone47_g4623 - 4 ) , 1 , 3 );
			int Band11_g4633 = ( 59 - ( clampResult8_g4633 - 1 ) );
			float Delay11_g4633 = temp_output_10_0_g4633;
			float3 localLumaGlowLerp11_g4633 = LumaGlowLerp11_g4633( Band11_g4633 , Delay11_g4633 );
			int Band11_g4634 = 56;
			int localIsLumaActive11_g4634 = IsLumaActive11_g4634( Band11_g4634 );
			float4 lerpResult14_g4633 = lerp( localAudioLinkLerp1_g4635 , float4( localLumaGlowLerp11_g4633 , 0.0 ) , (float)localIsLumaActive11_g4634);
			float4 lerpResult52_g4623 = lerp( temp_cast_16 , lerpResult14_g4633 , (float)saturate( EmissionGlowZone47_g4623 ));
			float4 lerpResult51_g4623 = lerp( float4( lerpResult23_g4623 , 0.0 ) , lerpResult52_g4623 , (float)saturate( ( EmissionGlowZone47_g4623 - 4 ) ));
			float4 temp_cast_21 = (_RedChGlowMinBrightness).xxxx;
			float4 temp_cast_22 = (( _RedChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_254_0_g4623 = saturate( EmissionGlowZone47_g4623 );
			float4 EmissionGlow142_g4623 = ( (temp_cast_21 + (lerpResult51_g4623 - float4( 0,0,0,0 )) * (temp_cast_22 - temp_cast_21) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _RedChGlowTint * temp_output_254_0_g4623 );
			float4 lerpResult257_g4623 = lerp( temp_cast_1 , EmissionGlow142_g4623 , (float)temp_output_254_0_g4623);
			float4 EmissionGlowTog258_g4623 = lerpResult257_g4623;
			int EmissionReactiveBand243_g4623 = _RedChReactiveBand;
			int Band3_g4624 = EmissionReactiveBand243_g4623;
			int Delay3_g4624 = 0;
			float localAudioLinkData3_g4624 = AudioLinkData3_g4624( Band3_g4624 , Delay3_g4624 );
			int temp_output_64_0_g4623 = step( _RedChReactiveBand , 9 );
			float lerpResult66_g4623 = lerp( 1.0 , localAudioLinkData3_g4624 , (float)temp_output_64_0_g4623);
			int Band3_g4626 = _RedChReactiveBand;
			float cos78_g4623 = cos( radians( _RedChReactivePulseDir ) );
			float sin78_g4623 = sin( radians( _RedChReactivePulseDir ) );
			float2 rotator78_g4623 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4623 , -sin78_g4623 , sin78_g4623 , cos78_g4623 )) + float2( 0.5,0.5 );
			float x96_g4623 = ( ( rotator78_g4623.x * _RedChReactivePulseScale ) + _RedChReactivePulseOffset );
			float y96_g4623 = 127.0;
			float localglslmod96_g4623 = glslmod96_g4623( x96_g4623 , y96_g4623 );
			float2 CenteredUV15_g4627 = ( i.uv_texcoord - _RedChReactiveRadialCenter );
			float2 break17_g4627 = CenteredUV15_g4627;
			float2 appendResult23_g4627 = (float2(( length( CenteredUV15_g4627 ) * _RedChReactivePulseScale * 2.0 ) , ( atan2( break17_g4627.x , break17_g4627.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4623 = ( _RedChReactivePulseOffset + appendResult23_g4627.x );
			float y97_g4623 = 127.0;
			float localglslmod97_g4623 = glslmod97_g4623( x97_g4623 , y97_g4623 );
			int EmissionReactiveMode99_g4623 = _RedChReactiveMode;
			int temp_output_90_0_g4623 = ( EmissionReactiveMode99_g4623 - 1 );
			float lerpResult77_g4623 = lerp( localglslmod96_g4623 , localglslmod97_g4623 , (float)saturate( temp_output_90_0_g4623 ));
			float lerpResult174_g4623 = lerp( DirectionalMap106_g4623 , ( 1.0 - DirectionalMap106_g4623 ) , (float)saturate( ( EmissionReactiveMode99_g4623 - 3 ) ));
			float x98_g4623 = ( _RedChReactivePulseOffset + ( _RedChReactivePulseScale * lerpResult174_g4623 ) );
			float y98_g4623 = 127.0;
			float localglslmod98_g4623 = glslmod98_g4623( x98_g4623 , y98_g4623 );
			float lerpResult87_g4623 = lerp( lerpResult77_g4623 , localglslmod98_g4623 , (float)saturate( ( temp_output_90_0_g4623 - 1 ) ));
			float Delay3_g4626 = lerpResult87_g4623;
			float localAudioLinkLerp3_g4626 = AudioLinkLerp3_g4626( Band3_g4626 , Delay3_g4626 );
			float lerpResult102_g4623 = lerp( 1.0 , localAudioLinkLerp3_g4626 , (float)temp_output_64_0_g4623);
			float lerpResult103_g4623 = lerp( lerpResult66_g4623 , lerpResult102_g4623 , (float)saturate( EmissionReactiveMode99_g4623 ));
			int Band3_g4628 = _RedChReactiveBand;
			float FilteredAmount3_g4628 = ( ( 1.0 - _RedChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4628 = AudioLinkLerp3_g4628( Band3_g4628 , FilteredAmount3_g4628 );
			float lerpResult168_g4623 = lerp( 1.0 , localAudioLinkLerp3_g4628 , (float)temp_output_64_0_g4623);
			float lerpResult172_g4623 = lerp( lerpResult103_g4623 , lerpResult168_g4623 , (float)saturate( ( EmissionReactiveMode99_g4623 - 4 ) ));
			float ReactivityAlpha132_g4623 = (_RedChReactiveMinBrightness + (lerpResult172_g4623 - 0.0) * (( _RedChReactiveMinBrightness + 1.0 ) - _RedChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_33 = (1.0).xxxx;
			float4 lerpResult253_g4623 = lerp( temp_cast_33 , _RedChReactiveTint , (float)step( EmissionReactiveBand243_g4623 , 9 ));
			float4 FinalReactivity68_g4623 = ( ReactivityAlpha132_g4623 * lerpResult253_g4623 );
			float4 lerpResult146_g4623 = lerp( ( EmissionGlowTog258_g4623 * FinalReactivity68_g4623 ) , ( EmissionGlow142_g4623 + FinalReactivity68_g4623 ) , (float)saturate( _RedChReactiveBlendMode ));
			float4 ReversedReactivity152_g4623 = ( ( 1.0 - ReactivityAlpha132_g4623 ) * lerpResult253_g4623 );
			int temp_output_157_0_g4623 = ( _RedChReactiveBlendMode - 1 );
			float4 lerpResult114_g4623 = lerp( lerpResult146_g4623 , ( EmissionGlowTog258_g4623 * ReversedReactivity152_g4623 ) , (float)saturate( temp_output_157_0_g4623 ));
			float4 lerpResult164_g4623 = lerp( lerpResult114_g4623 , ( EmissionGlow142_g4623 + ( ReversedReactivity152_g4623 * step( EmissionReactiveBand243_g4623 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g4623 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g4623 , 9 ) ) ));
			float2 uv_GlowMask = i.uv_texcoord * _GlowMask_ST.xy + _GlowMask_ST.zw;
			float4 GlowMaskRGBA174_g4606 = tex2D( _GlowMask, uv_GlowMask );
			float localIfAudioLinkv2Exists1_g4638 = IfAudioLinkv2Exists1_g4638();
			float4 lerpResult280_g4623 = lerp( float4( 0,0,0,0 ) , ( lerpResult164_g4623 * (GlowMaskRGBA174_g4606).ra.x * localIfAudioLinkv2Exists1_g4638 ) , _EnableRedChannel);
			float4 temp_cast_43 = (1.0).xxxx;
			float3 temp_cast_44 = (1.0).xxx;
			int EmissionGlowZone47_g4639 = _GreenChGlowZone;
			int clampResult8_g4645 = clamp( EmissionGlowZone47_g4639 , 1 , 4 );
			int temp_output_3_0_g4645 = ( clampResult8_g4645 - 1 );
			int Zone16_g4645 = temp_output_3_0_g4645;
			float3 localgetThemeData16_g4645 = getThemeData( Zone16_g4645 );
			int Band11_g4646 = 56;
			int localIsLumaActive11_g4646 = IsLumaActive11_g4646( Band11_g4646 );
			int temp_output_14_0_g4645 = localIsLumaActive11_g4646;
			int lerpResult15_g4645 = lerp( temp_output_3_0_g4645 , ( 63 - temp_output_3_0_g4645 ) , (float)temp_output_14_0_g4645);
			int Band2_g4645 = lerpResult15_g4645;
			int Delay2_g4645 = 0;
			float3 localLumaGlowData2_g4645 = LumaGlowData2_g4645( Band2_g4645 , Delay2_g4645 );
			float3 lerpResult17_g4645 = lerp( ( localgetThemeData16_g4645 * localLumaGlowData2_g4645 ) , localLumaGlowData2_g4645 , (float)temp_output_14_0_g4645);
			int temp_output_21_0_g4639 = saturate( EmissionGlowZone47_g4639 );
			float3 lerpResult20_g4639 = lerp( temp_cast_44 , lerpResult17_g4645 , (float)temp_output_21_0_g4639);
			float3 temp_cast_48 = (1.0).xxx;
			int clampResult8_g4647 = clamp( EmissionGlowZone47_g4639 , 1 , 4 );
			int temp_output_3_0_g4647 = ( clampResult8_g4647 - 1 );
			int Zone15_g4647 = temp_output_3_0_g4647;
			float3 localgetThemeData15_g4647 = getThemeData( Zone15_g4647 );
			int Band11_g4648 = 56;
			int localIsLumaActive11_g4648 = IsLumaActive11_g4648( Band11_g4648 );
			int temp_output_13_0_g4647 = localIsLumaActive11_g4648;
			int lerpResult14_g4647 = lerp( temp_output_3_0_g4647 , ( 63 - temp_output_3_0_g4647 ) , (float)temp_output_13_0_g4647);
			int Band11_g4647 = lerpResult14_g4647;
			float cos6_g4639 = cos( radians( _GreenChGlowPulseDir ) );
			float sin6_g4639 = sin( radians( _GreenChGlowPulseDir ) );
			float2 rotator6_g4639 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4639 , -sin6_g4639 , sin6_g4639 , cos6_g4639 )) + float2( 0.5,0.5 );
			int Band6_g4652 = _GreenChGlowAnimationBand;
			int Mode6_g4652 = ( ( _GreenChGlowAnimationMode * 2 ) + _GreenChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4652 = AudioLinkDecodeDataAsUInt6_g4652( Band6_g4652 , Mode6_g4652 );
			float localGetLocalTime2_g4653 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4639 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4652 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4653 , (float)saturate( ( _GreenChGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4639 = ( _GreenChGlowAnimationStrength * lerpResult206_g4639 * step( _GreenChGlowAnimationBand , 9 ) );
			float x13_g4639 = ( ( rotator6_g4639.x * _GreenChGlowPulseScale ) + _GreenChGlowPulseOffset + EmissionGlowAnimation195_g4639 );
			float y13_g4639 = 127.0;
			float localglslmod13_g4639 = glslmod13_g4639( x13_g4639 , y13_g4639 );
			float2 CenteredUV15_g4641 = ( i.uv_texcoord - _GreenChGlowRadialCenter );
			float2 break17_g4641 = CenteredUV15_g4641;
			float2 appendResult23_g4641 = (float2(( length( CenteredUV15_g4641 ) * _GreenChGlowPulseScale * 2.0 ) , ( atan2( break17_g4641.x , break17_g4641.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4639 = ( _GreenChGlowPulseOffset + appendResult23_g4641.x + EmissionGlowAnimation195_g4639 );
			float y12_g4639 = 127.0;
			float localglslmod12_g4639 = glslmod12_g4639( x12_g4639 , y12_g4639 );
			int EmissionGlowMode35_g4639 = _GreenChGlowMode;
			int temp_output_37_0_g4639 = ( EmissionGlowMode35_g4639 - 1 );
			float lerpResult5_g4639 = lerp( localglslmod13_g4639 , localglslmod12_g4639 , (float)saturate( temp_output_37_0_g4639 ));
			float DirectionalMap106_g4639 = Direction27_g4606;
			float lerpResult179_g4639 = lerp( DirectionalMap106_g4639 , ( 1.0 - DirectionalMap106_g4639 ) , (float)saturate( ( EmissionGlowMode35_g4639 - 3 ) ));
			float x34_g4639 = ( _GreenChGlowPulseOffset + ( _GreenChGlowPulseScale * lerpResult179_g4639 ) + EmissionGlowAnimation195_g4639 );
			float y34_g4639 = 127.0;
			float localglslmod34_g4639 = glslmod34_g4639( x34_g4639 , y34_g4639 );
			float lerpResult30_g4639 = lerp( lerpResult5_g4639 , localglslmod34_g4639 , (float)saturate( ( temp_output_37_0_g4639 - 1 ) ));
			float EmissionGlowDelay56_g4639 = lerpResult30_g4639;
			float Delay11_g4647 = EmissionGlowDelay56_g4639;
			float3 localLumaGlowLerp11_g4647 = LumaGlowLerp11_g4647( Band11_g4647 , Delay11_g4647 );
			float3 lerpResult17_g4647 = lerp( ( localgetThemeData15_g4647 * localLumaGlowLerp11_g4647 ) , localLumaGlowLerp11_g4647 , (float)temp_output_13_0_g4647);
			float3 lerpResult22_g4639 = lerp( temp_cast_48 , lerpResult17_g4647 , (float)temp_output_21_0_g4639);
			float3 lerpResult23_g4639 = lerp( lerpResult20_g4639 , lerpResult22_g4639 , (float)saturate( EmissionGlowMode35_g4639 ));
			float4 temp_cast_58 = (1.0).xxxx;
			float temp_output_10_0_g4649 = EmissionGlowDelay56_g4639;
			float Position1_g4651 = ( temp_output_10_0_g4649 / 127.0 );
			float4 localAudioLinkLerp1_g4651 = AudioLinkLerp1_g4651( Position1_g4651 );
			int clampResult8_g4649 = clamp( ( EmissionGlowZone47_g4639 - 4 ) , 1 , 3 );
			int Band11_g4649 = ( 59 - ( clampResult8_g4649 - 1 ) );
			float Delay11_g4649 = temp_output_10_0_g4649;
			float3 localLumaGlowLerp11_g4649 = LumaGlowLerp11_g4649( Band11_g4649 , Delay11_g4649 );
			int Band11_g4650 = 56;
			int localIsLumaActive11_g4650 = IsLumaActive11_g4650( Band11_g4650 );
			float4 lerpResult14_g4649 = lerp( localAudioLinkLerp1_g4651 , float4( localLumaGlowLerp11_g4649 , 0.0 ) , (float)localIsLumaActive11_g4650);
			float4 lerpResult52_g4639 = lerp( temp_cast_58 , lerpResult14_g4649 , (float)saturate( EmissionGlowZone47_g4639 ));
			float4 lerpResult51_g4639 = lerp( float4( lerpResult23_g4639 , 0.0 ) , lerpResult52_g4639 , (float)saturate( ( EmissionGlowZone47_g4639 - 4 ) ));
			float4 temp_cast_63 = (_GreenChGlowMinBrightness).xxxx;
			float4 temp_cast_64 = (( _GreenChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_255_0_g4639 = saturate( EmissionGlowZone47_g4639 );
			float4 EmissionGlow142_g4639 = ( (temp_cast_63 + (lerpResult51_g4639 - float4( 0,0,0,0 )) * (temp_cast_64 - temp_cast_63) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _GreenChGlowTint * temp_output_255_0_g4639 );
			float4 lerpResult258_g4639 = lerp( temp_cast_43 , EmissionGlow142_g4639 , (float)temp_output_255_0_g4639);
			float4 EmissionGlowTog259_g4639 = lerpResult258_g4639;
			int EmissionReactiveBand243_g4639 = _GreenChReactiveBand;
			int Band3_g4640 = EmissionReactiveBand243_g4639;
			int Delay3_g4640 = 0;
			float localAudioLinkData3_g4640 = AudioLinkData3_g4640( Band3_g4640 , Delay3_g4640 );
			int temp_output_64_0_g4639 = step( _GreenChReactiveBand , 9 );
			float lerpResult66_g4639 = lerp( 1.0 , localAudioLinkData3_g4640 , (float)temp_output_64_0_g4639);
			int Band3_g4642 = _GreenChReactiveBand;
			float cos78_g4639 = cos( radians( _GreenChReactivePulseDir ) );
			float sin78_g4639 = sin( radians( _GreenChReactivePulseDir ) );
			float2 rotator78_g4639 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4639 , -sin78_g4639 , sin78_g4639 , cos78_g4639 )) + float2( 0.5,0.5 );
			float x96_g4639 = ( ( rotator78_g4639.x * _GreenChReactivePulseScale ) + _GreenChReactivePulseOffset );
			float y96_g4639 = 127.0;
			float localglslmod96_g4639 = glslmod96_g4639( x96_g4639 , y96_g4639 );
			float2 CenteredUV15_g4643 = ( i.uv_texcoord - _GreenChReactiveRadialCenter );
			float2 break17_g4643 = CenteredUV15_g4643;
			float2 appendResult23_g4643 = (float2(( length( CenteredUV15_g4643 ) * _GreenChReactivePulseScale * 2.0 ) , ( atan2( break17_g4643.x , break17_g4643.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4639 = ( _GreenChReactivePulseOffset + appendResult23_g4643.x );
			float y97_g4639 = 127.0;
			float localglslmod97_g4639 = glslmod97_g4639( x97_g4639 , y97_g4639 );
			int EmissionReactiveMode99_g4639 = _GreenChReactiveMode;
			int temp_output_90_0_g4639 = ( EmissionReactiveMode99_g4639 - 1 );
			float lerpResult77_g4639 = lerp( localglslmod96_g4639 , localglslmod97_g4639 , (float)saturate( temp_output_90_0_g4639 ));
			float lerpResult174_g4639 = lerp( DirectionalMap106_g4639 , ( 1.0 - DirectionalMap106_g4639 ) , (float)saturate( ( EmissionReactiveMode99_g4639 - 3 ) ));
			float x98_g4639 = ( _GreenChReactivePulseOffset + ( _GreenChReactivePulseScale * lerpResult174_g4639 ) );
			float y98_g4639 = 127.0;
			float localglslmod98_g4639 = glslmod98_g4639( x98_g4639 , y98_g4639 );
			float lerpResult87_g4639 = lerp( lerpResult77_g4639 , localglslmod98_g4639 , (float)saturate( ( temp_output_90_0_g4639 - 1 ) ));
			float Delay3_g4642 = lerpResult87_g4639;
			float localAudioLinkLerp3_g4642 = AudioLinkLerp3_g4642( Band3_g4642 , Delay3_g4642 );
			float lerpResult102_g4639 = lerp( 1.0 , localAudioLinkLerp3_g4642 , (float)temp_output_64_0_g4639);
			float lerpResult103_g4639 = lerp( lerpResult66_g4639 , lerpResult102_g4639 , (float)saturate( EmissionReactiveMode99_g4639 ));
			int Band3_g4644 = _GreenChReactiveBand;
			float FilteredAmount3_g4644 = ( ( 1.0 - _GreenChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4644 = AudioLinkLerp3_g4644( Band3_g4644 , FilteredAmount3_g4644 );
			float lerpResult168_g4639 = lerp( 1.0 , localAudioLinkLerp3_g4644 , (float)temp_output_64_0_g4639);
			float lerpResult172_g4639 = lerp( lerpResult103_g4639 , lerpResult168_g4639 , (float)saturate( ( EmissionReactiveMode99_g4639 - 4 ) ));
			float ReactivityAlpha132_g4639 = (_GreenChReactiveMinBrightness + (lerpResult172_g4639 - 0.0) * (( _GreenChReactiveMinBrightness + 1.0 ) - _GreenChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_75 = (1.0).xxxx;
			float4 lerpResult264_g4639 = lerp( temp_cast_75 , _GreenChReactiveTint , (float)step( EmissionReactiveBand243_g4639 , 9 ));
			float4 FinalReactivity68_g4639 = ( ReactivityAlpha132_g4639 * lerpResult264_g4639 );
			float4 lerpResult146_g4639 = lerp( ( EmissionGlowTog259_g4639 * FinalReactivity68_g4639 ) , ( EmissionGlow142_g4639 + FinalReactivity68_g4639 ) , (float)saturate( _GreenChReactiveBlendMode ));
			float4 ReversedReactivity152_g4639 = ( ( 1.0 - ReactivityAlpha132_g4639 ) * lerpResult264_g4639 );
			int temp_output_157_0_g4639 = ( _GreenChReactiveBlendMode - 1 );
			float4 lerpResult114_g4639 = lerp( lerpResult146_g4639 , ( EmissionGlowTog259_g4639 * ReversedReactivity152_g4639 ) , (float)saturate( temp_output_157_0_g4639 ));
			float4 lerpResult164_g4639 = lerp( lerpResult114_g4639 , ( EmissionGlow142_g4639 + ( ReversedReactivity152_g4639 * step( EmissionReactiveBand243_g4639 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g4639 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g4639 , 9 ) ) ));
			float localIfAudioLinkv2Exists1_g4654 = IfAudioLinkv2Exists1_g4654();
			float4 lerpResult276_g4639 = lerp( float4( 0,0,0,0 ) , ( lerpResult164_g4639 * (GlowMaskRGBA174_g4606).ga.x * localIfAudioLinkv2Exists1_g4654 ) , _EnableGreenChannel);
			float4 temp_cast_85 = (1.0).xxxx;
			float3 temp_cast_86 = (1.0).xxx;
			int EmissionGlowZone47_g4655 = _BlueChGlowZone;
			int clampResult8_g4661 = clamp( EmissionGlowZone47_g4655 , 1 , 4 );
			int temp_output_3_0_g4661 = ( clampResult8_g4661 - 1 );
			int Zone16_g4661 = temp_output_3_0_g4661;
			float3 localgetThemeData16_g4661 = getThemeData( Zone16_g4661 );
			int Band11_g4662 = 56;
			int localIsLumaActive11_g4662 = IsLumaActive11_g4662( Band11_g4662 );
			int temp_output_14_0_g4661 = localIsLumaActive11_g4662;
			int lerpResult15_g4661 = lerp( temp_output_3_0_g4661 , ( 63 - temp_output_3_0_g4661 ) , (float)temp_output_14_0_g4661);
			int Band2_g4661 = lerpResult15_g4661;
			int Delay2_g4661 = 0;
			float3 localLumaGlowData2_g4661 = LumaGlowData2_g4661( Band2_g4661 , Delay2_g4661 );
			float3 lerpResult17_g4661 = lerp( ( localgetThemeData16_g4661 * localLumaGlowData2_g4661 ) , localLumaGlowData2_g4661 , (float)temp_output_14_0_g4661);
			int temp_output_21_0_g4655 = saturate( EmissionGlowZone47_g4655 );
			float3 lerpResult20_g4655 = lerp( temp_cast_86 , lerpResult17_g4661 , (float)temp_output_21_0_g4655);
			float3 temp_cast_90 = (1.0).xxx;
			int clampResult8_g4663 = clamp( EmissionGlowZone47_g4655 , 1 , 4 );
			int temp_output_3_0_g4663 = ( clampResult8_g4663 - 1 );
			int Zone15_g4663 = temp_output_3_0_g4663;
			float3 localgetThemeData15_g4663 = getThemeData( Zone15_g4663 );
			int Band11_g4664 = 56;
			int localIsLumaActive11_g4664 = IsLumaActive11_g4664( Band11_g4664 );
			int temp_output_13_0_g4663 = localIsLumaActive11_g4664;
			int lerpResult14_g4663 = lerp( temp_output_3_0_g4663 , ( 63 - temp_output_3_0_g4663 ) , (float)temp_output_13_0_g4663);
			int Band11_g4663 = lerpResult14_g4663;
			float cos6_g4655 = cos( radians( _BlueChGlowPulseDir ) );
			float sin6_g4655 = sin( radians( _BlueChGlowPulseDir ) );
			float2 rotator6_g4655 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4655 , -sin6_g4655 , sin6_g4655 , cos6_g4655 )) + float2( 0.5,0.5 );
			int Band6_g4668 = _BlueChGlowAnimationBand;
			int Mode6_g4668 = ( ( _BlueChGlowAnimationMode * 2 ) + _BlueChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4668 = AudioLinkDecodeDataAsUInt6_g4668( Band6_g4668 , Mode6_g4668 );
			float localGetLocalTime2_g4669 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4655 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4668 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4669 , (float)saturate( ( _BlueChGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4655 = ( _BlueChGlowAnimationStrength * lerpResult206_g4655 * step( _BlueChGlowAnimationBand , 9 ) );
			float x13_g4655 = ( ( rotator6_g4655.x * _BlueChGlowPulseScale ) + _BlueChGlowPulseOffset + EmissionGlowAnimation195_g4655 );
			float y13_g4655 = 127.0;
			float localglslmod13_g4655 = glslmod13_g4655( x13_g4655 , y13_g4655 );
			float2 CenteredUV15_g4657 = ( i.uv_texcoord - _BlueChGlowRadialCenter );
			float2 break17_g4657 = CenteredUV15_g4657;
			float2 appendResult23_g4657 = (float2(( length( CenteredUV15_g4657 ) * _BlueChGlowPulseScale * 2.0 ) , ( atan2( break17_g4657.x , break17_g4657.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4655 = ( _BlueChGlowPulseOffset + appendResult23_g4657.x + EmissionGlowAnimation195_g4655 );
			float y12_g4655 = 127.0;
			float localglslmod12_g4655 = glslmod12_g4655( x12_g4655 , y12_g4655 );
			int EmissionGlowMode35_g4655 = _BlueChGlowMode;
			int temp_output_37_0_g4655 = ( EmissionGlowMode35_g4655 - 1 );
			float lerpResult5_g4655 = lerp( localglslmod13_g4655 , localglslmod12_g4655 , (float)saturate( temp_output_37_0_g4655 ));
			float DirectionalMap106_g4655 = Direction27_g4606;
			float lerpResult179_g4655 = lerp( DirectionalMap106_g4655 , ( 1.0 - DirectionalMap106_g4655 ) , (float)saturate( ( EmissionGlowMode35_g4655 - 3 ) ));
			float x34_g4655 = ( _BlueChGlowPulseOffset + ( _BlueChGlowPulseScale * lerpResult179_g4655 ) + EmissionGlowAnimation195_g4655 );
			float y34_g4655 = 127.0;
			float localglslmod34_g4655 = glslmod34_g4655( x34_g4655 , y34_g4655 );
			float lerpResult30_g4655 = lerp( lerpResult5_g4655 , localglslmod34_g4655 , (float)saturate( ( temp_output_37_0_g4655 - 1 ) ));
			float EmissionGlowDelay56_g4655 = lerpResult30_g4655;
			float Delay11_g4663 = EmissionGlowDelay56_g4655;
			float3 localLumaGlowLerp11_g4663 = LumaGlowLerp11_g4663( Band11_g4663 , Delay11_g4663 );
			float3 lerpResult17_g4663 = lerp( ( localgetThemeData15_g4663 * localLumaGlowLerp11_g4663 ) , localLumaGlowLerp11_g4663 , (float)temp_output_13_0_g4663);
			float3 lerpResult22_g4655 = lerp( temp_cast_90 , lerpResult17_g4663 , (float)temp_output_21_0_g4655);
			float3 lerpResult23_g4655 = lerp( lerpResult20_g4655 , lerpResult22_g4655 , (float)saturate( EmissionGlowMode35_g4655 ));
			float4 temp_cast_100 = (1.0).xxxx;
			float temp_output_10_0_g4665 = EmissionGlowDelay56_g4655;
			float Position1_g4667 = ( temp_output_10_0_g4665 / 127.0 );
			float4 localAudioLinkLerp1_g4667 = AudioLinkLerp1_g4667( Position1_g4667 );
			int clampResult8_g4665 = clamp( ( EmissionGlowZone47_g4655 - 4 ) , 1 , 3 );
			int Band11_g4665 = ( 59 - ( clampResult8_g4665 - 1 ) );
			float Delay11_g4665 = temp_output_10_0_g4665;
			float3 localLumaGlowLerp11_g4665 = LumaGlowLerp11_g4665( Band11_g4665 , Delay11_g4665 );
			int Band11_g4666 = 56;
			int localIsLumaActive11_g4666 = IsLumaActive11_g4666( Band11_g4666 );
			float4 lerpResult14_g4665 = lerp( localAudioLinkLerp1_g4667 , float4( localLumaGlowLerp11_g4665 , 0.0 ) , (float)localIsLumaActive11_g4666);
			float4 lerpResult52_g4655 = lerp( temp_cast_100 , lerpResult14_g4665 , (float)saturate( EmissionGlowZone47_g4655 ));
			float4 lerpResult51_g4655 = lerp( float4( lerpResult23_g4655 , 0.0 ) , lerpResult52_g4655 , (float)saturate( ( EmissionGlowZone47_g4655 - 4 ) ));
			float4 temp_cast_105 = (_BlueChGlowMinBrightness).xxxx;
			float4 temp_cast_106 = (( _BlueChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_258_0_g4655 = saturate( EmissionGlowZone47_g4655 );
			float4 EmissionGlow142_g4655 = ( (temp_cast_105 + (lerpResult51_g4655 - float4( 0,0,0,0 )) * (temp_cast_106 - temp_cast_105) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _BlueChGlowTint * temp_output_258_0_g4655 );
			float4 lerpResult261_g4655 = lerp( temp_cast_85 , EmissionGlow142_g4655 , (float)temp_output_258_0_g4655);
			float4 EmissionGlowTog262_g4655 = lerpResult261_g4655;
			int EmissionReactiveBand243_g4655 = _BlueChReactiveBand;
			int Band3_g4656 = EmissionReactiveBand243_g4655;
			int Delay3_g4656 = 0;
			float localAudioLinkData3_g4656 = AudioLinkData3_g4656( Band3_g4656 , Delay3_g4656 );
			int temp_output_64_0_g4655 = step( _BlueChReactiveBand , 9 );
			float lerpResult66_g4655 = lerp( 1.0 , localAudioLinkData3_g4656 , (float)temp_output_64_0_g4655);
			int Band3_g4658 = _BlueChReactiveBand;
			float cos78_g4655 = cos( radians( _BlueChReactivePulseDir ) );
			float sin78_g4655 = sin( radians( _BlueChReactivePulseDir ) );
			float2 rotator78_g4655 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4655 , -sin78_g4655 , sin78_g4655 , cos78_g4655 )) + float2( 0.5,0.5 );
			float x96_g4655 = ( ( rotator78_g4655.x * _BlueChReactivePulseScale ) + _BlueChReactivePulseOffset );
			float y96_g4655 = 127.0;
			float localglslmod96_g4655 = glslmod96_g4655( x96_g4655 , y96_g4655 );
			float2 CenteredUV15_g4659 = ( i.uv_texcoord - _BlueChReactiveRadialCenter );
			float2 break17_g4659 = CenteredUV15_g4659;
			float2 appendResult23_g4659 = (float2(( length( CenteredUV15_g4659 ) * _BlueChReactivePulseScale * 2.0 ) , ( atan2( break17_g4659.x , break17_g4659.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4655 = ( _BlueChReactivePulseOffset + appendResult23_g4659.x );
			float y97_g4655 = 127.0;
			float localglslmod97_g4655 = glslmod97_g4655( x97_g4655 , y97_g4655 );
			int EmissionReactiveMode99_g4655 = _BlueChReactiveMode;
			int temp_output_90_0_g4655 = ( EmissionReactiveMode99_g4655 - 1 );
			float lerpResult77_g4655 = lerp( localglslmod96_g4655 , localglslmod97_g4655 , (float)saturate( temp_output_90_0_g4655 ));
			float lerpResult174_g4655 = lerp( DirectionalMap106_g4655 , ( 1.0 - DirectionalMap106_g4655 ) , (float)saturate( ( EmissionReactiveMode99_g4655 - 3 ) ));
			float x98_g4655 = ( _BlueChReactivePulseOffset + ( _BlueChReactivePulseScale * lerpResult174_g4655 ) );
			float y98_g4655 = 127.0;
			float localglslmod98_g4655 = glslmod98_g4655( x98_g4655 , y98_g4655 );
			float lerpResult87_g4655 = lerp( lerpResult77_g4655 , localglslmod98_g4655 , (float)saturate( ( temp_output_90_0_g4655 - 1 ) ));
			float Delay3_g4658 = lerpResult87_g4655;
			float localAudioLinkLerp3_g4658 = AudioLinkLerp3_g4658( Band3_g4658 , Delay3_g4658 );
			float lerpResult102_g4655 = lerp( 1.0 , localAudioLinkLerp3_g4658 , (float)temp_output_64_0_g4655);
			float lerpResult103_g4655 = lerp( lerpResult66_g4655 , lerpResult102_g4655 , (float)saturate( EmissionReactiveMode99_g4655 ));
			int Band3_g4660 = _BlueChReactiveBand;
			float FilteredAmount3_g4660 = ( ( 1.0 - _BlueChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4660 = AudioLinkLerp3_g4660( Band3_g4660 , FilteredAmount3_g4660 );
			float lerpResult168_g4655 = lerp( 1.0 , localAudioLinkLerp3_g4660 , (float)temp_output_64_0_g4655);
			float lerpResult172_g4655 = lerp( lerpResult103_g4655 , lerpResult168_g4655 , (float)saturate( ( EmissionReactiveMode99_g4655 - 4 ) ));
			float ReactivityAlpha132_g4655 = (_BlueChReactiveMinBrightness + (lerpResult172_g4655 - 0.0) * (( _BlueChReactiveMinBrightness + 1.0 ) - _BlueChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_117 = (1.0).xxxx;
			float4 lerpResult268_g4655 = lerp( temp_cast_117 , _BlueChReactiveTint , (float)step( EmissionReactiveBand243_g4655 , 9 ));
			float4 FinalReactivity68_g4655 = ( ReactivityAlpha132_g4655 * lerpResult268_g4655 );
			float4 lerpResult146_g4655 = lerp( ( EmissionGlowTog262_g4655 * FinalReactivity68_g4655 ) , ( EmissionGlow142_g4655 + FinalReactivity68_g4655 ) , (float)saturate( _BlueChReactiveBlendMode ));
			float4 ReversedReactivity152_g4655 = ( ( 1.0 - ReactivityAlpha132_g4655 ) * lerpResult268_g4655 );
			int temp_output_157_0_g4655 = ( _BlueChReactiveBlendMode - 1 );
			float4 lerpResult114_g4655 = lerp( lerpResult146_g4655 , ( EmissionGlowTog262_g4655 * ReversedReactivity152_g4655 ) , (float)saturate( temp_output_157_0_g4655 ));
			float4 lerpResult164_g4655 = lerp( lerpResult114_g4655 , ( EmissionGlow142_g4655 + ( ReversedReactivity152_g4655 * step( EmissionReactiveBand243_g4655 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g4655 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g4655 , 9 ) ) ));
			float localIfAudioLinkv2Exists1_g4670 = IfAudioLinkv2Exists1_g4670();
			float4 lerpResult278_g4655 = lerp( float4( 0,0,0,0 ) , ( lerpResult164_g4655 * (GlowMaskRGBA174_g4606).ba.x * localIfAudioLinkv2Exists1_g4670 ) , _EnableBlueChannel);
			float4 temp_cast_127 = (1.0).xxxx;
			float3 temp_cast_128 = (1.0).xxx;
			int EmissionGlowZone47_g4671 = _AlphaChGlowZone;
			int clampResult8_g4677 = clamp( EmissionGlowZone47_g4671 , 1 , 4 );
			int temp_output_3_0_g4677 = ( clampResult8_g4677 - 1 );
			int Zone16_g4677 = temp_output_3_0_g4677;
			float3 localgetThemeData16_g4677 = getThemeData( Zone16_g4677 );
			int Band11_g4678 = 56;
			int localIsLumaActive11_g4678 = IsLumaActive11_g4678( Band11_g4678 );
			int temp_output_14_0_g4677 = localIsLumaActive11_g4678;
			int lerpResult15_g4677 = lerp( temp_output_3_0_g4677 , ( 63 - temp_output_3_0_g4677 ) , (float)temp_output_14_0_g4677);
			int Band2_g4677 = lerpResult15_g4677;
			int Delay2_g4677 = 0;
			float3 localLumaGlowData2_g4677 = LumaGlowData2_g4677( Band2_g4677 , Delay2_g4677 );
			float3 lerpResult17_g4677 = lerp( ( localgetThemeData16_g4677 * localLumaGlowData2_g4677 ) , localLumaGlowData2_g4677 , (float)temp_output_14_0_g4677);
			int temp_output_21_0_g4671 = saturate( EmissionGlowZone47_g4671 );
			float3 lerpResult20_g4671 = lerp( temp_cast_128 , lerpResult17_g4677 , (float)temp_output_21_0_g4671);
			float3 temp_cast_132 = (1.0).xxx;
			int clampResult8_g4679 = clamp( EmissionGlowZone47_g4671 , 1 , 4 );
			int temp_output_3_0_g4679 = ( clampResult8_g4679 - 1 );
			int Zone15_g4679 = temp_output_3_0_g4679;
			float3 localgetThemeData15_g4679 = getThemeData( Zone15_g4679 );
			int Band11_g4680 = 56;
			int localIsLumaActive11_g4680 = IsLumaActive11_g4680( Band11_g4680 );
			int temp_output_13_0_g4679 = localIsLumaActive11_g4680;
			int lerpResult14_g4679 = lerp( temp_output_3_0_g4679 , ( 63 - temp_output_3_0_g4679 ) , (float)temp_output_13_0_g4679);
			int Band11_g4679 = lerpResult14_g4679;
			float cos6_g4671 = cos( radians( _AlphaChGlowPulseDir ) );
			float sin6_g4671 = sin( radians( _AlphaChGlowPulseDir ) );
			float2 rotator6_g4671 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4671 , -sin6_g4671 , sin6_g4671 , cos6_g4671 )) + float2( 0.5,0.5 );
			int Band6_g4684 = _AlphaChGlowAnimationBand;
			int Mode6_g4684 = ( ( _AlphaChGlowAnimationMode * 2 ) + _AlphaChGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4684 = AudioLinkDecodeDataAsUInt6_g4684( Band6_g4684 , Mode6_g4684 );
			float localGetLocalTime2_g4685 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4671 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4684 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4685 , (float)saturate( ( _AlphaChGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4671 = ( _AlphaChGlowAnimationStrength * lerpResult206_g4671 * step( _AlphaChGlowAnimationBand , 9 ) );
			float x13_g4671 = ( ( rotator6_g4671.x * _AlphaChGlowPulseScale ) + _AlphaChGlowPulseOffset + EmissionGlowAnimation195_g4671 );
			float y13_g4671 = 127.0;
			float localglslmod13_g4671 = glslmod13_g4671( x13_g4671 , y13_g4671 );
			float2 CenteredUV15_g4673 = ( i.uv_texcoord - _AlphaChGlowRadialCenter );
			float2 break17_g4673 = CenteredUV15_g4673;
			float2 appendResult23_g4673 = (float2(( length( CenteredUV15_g4673 ) * _AlphaChGlowPulseScale * 2.0 ) , ( atan2( break17_g4673.x , break17_g4673.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4671 = ( _AlphaChGlowPulseOffset + appendResult23_g4673.x + EmissionGlowAnimation195_g4671 );
			float y12_g4671 = 127.0;
			float localglslmod12_g4671 = glslmod12_g4671( x12_g4671 , y12_g4671 );
			int EmissionGlowMode35_g4671 = _AlphaChGlowMode;
			int temp_output_37_0_g4671 = ( EmissionGlowMode35_g4671 - 1 );
			float lerpResult5_g4671 = lerp( localglslmod13_g4671 , localglslmod12_g4671 , (float)saturate( temp_output_37_0_g4671 ));
			float DirectionalMap106_g4671 = Direction27_g4606;
			float lerpResult179_g4671 = lerp( DirectionalMap106_g4671 , ( 1.0 - DirectionalMap106_g4671 ) , (float)saturate( ( EmissionGlowMode35_g4671 - 3 ) ));
			float x34_g4671 = ( _AlphaChGlowPulseOffset + ( _AlphaChGlowPulseScale * lerpResult179_g4671 ) + EmissionGlowAnimation195_g4671 );
			float y34_g4671 = 127.0;
			float localglslmod34_g4671 = glslmod34_g4671( x34_g4671 , y34_g4671 );
			float lerpResult30_g4671 = lerp( lerpResult5_g4671 , localglslmod34_g4671 , (float)saturate( ( temp_output_37_0_g4671 - 1 ) ));
			float EmissionGlowDelay56_g4671 = lerpResult30_g4671;
			float Delay11_g4679 = EmissionGlowDelay56_g4671;
			float3 localLumaGlowLerp11_g4679 = LumaGlowLerp11_g4679( Band11_g4679 , Delay11_g4679 );
			float3 lerpResult17_g4679 = lerp( ( localgetThemeData15_g4679 * localLumaGlowLerp11_g4679 ) , localLumaGlowLerp11_g4679 , (float)temp_output_13_0_g4679);
			float3 lerpResult22_g4671 = lerp( temp_cast_132 , lerpResult17_g4679 , (float)temp_output_21_0_g4671);
			float3 lerpResult23_g4671 = lerp( lerpResult20_g4671 , lerpResult22_g4671 , (float)saturate( EmissionGlowMode35_g4671 ));
			float4 temp_cast_142 = (1.0).xxxx;
			float temp_output_10_0_g4681 = EmissionGlowDelay56_g4671;
			float Position1_g4683 = ( temp_output_10_0_g4681 / 127.0 );
			float4 localAudioLinkLerp1_g4683 = AudioLinkLerp1_g4683( Position1_g4683 );
			int clampResult8_g4681 = clamp( ( EmissionGlowZone47_g4671 - 4 ) , 1 , 3 );
			int Band11_g4681 = ( 59 - ( clampResult8_g4681 - 1 ) );
			float Delay11_g4681 = temp_output_10_0_g4681;
			float3 localLumaGlowLerp11_g4681 = LumaGlowLerp11_g4681( Band11_g4681 , Delay11_g4681 );
			int Band11_g4682 = 56;
			int localIsLumaActive11_g4682 = IsLumaActive11_g4682( Band11_g4682 );
			float4 lerpResult14_g4681 = lerp( localAudioLinkLerp1_g4683 , float4( localLumaGlowLerp11_g4681 , 0.0 ) , (float)localIsLumaActive11_g4682);
			float4 lerpResult52_g4671 = lerp( temp_cast_142 , lerpResult14_g4681 , (float)saturate( EmissionGlowZone47_g4671 ));
			float4 lerpResult51_g4671 = lerp( float4( lerpResult23_g4671 , 0.0 ) , lerpResult52_g4671 , (float)saturate( ( EmissionGlowZone47_g4671 - 4 ) ));
			float4 temp_cast_147 = (_AlphaChGlowMinBrightness).xxxx;
			float4 temp_cast_148 = (( _AlphaChGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_258_0_g4671 = saturate( EmissionGlowZone47_g4671 );
			float4 EmissionGlow142_g4671 = ( (temp_cast_147 + (lerpResult51_g4671 - float4( 0,0,0,0 )) * (temp_cast_148 - temp_cast_147) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _AlphaChGlowTint * temp_output_258_0_g4671 );
			float4 lerpResult261_g4671 = lerp( temp_cast_127 , EmissionGlow142_g4671 , (float)temp_output_258_0_g4671);
			float4 EmissionGlowTog262_g4671 = lerpResult261_g4671;
			int EmissionReactiveBand243_g4671 = _AlphaChReactiveBand;
			int Band3_g4672 = EmissionReactiveBand243_g4671;
			int Delay3_g4672 = 0;
			float localAudioLinkData3_g4672 = AudioLinkData3_g4672( Band3_g4672 , Delay3_g4672 );
			int temp_output_64_0_g4671 = step( _AlphaChReactiveBand , 9 );
			float lerpResult66_g4671 = lerp( 1.0 , localAudioLinkData3_g4672 , (float)temp_output_64_0_g4671);
			int Band3_g4674 = _AlphaChReactiveBand;
			float cos78_g4671 = cos( radians( _AlphaChReactivePulseDir ) );
			float sin78_g4671 = sin( radians( _AlphaChReactivePulseDir ) );
			float2 rotator78_g4671 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4671 , -sin78_g4671 , sin78_g4671 , cos78_g4671 )) + float2( 0.5,0.5 );
			float x96_g4671 = ( ( rotator78_g4671.x * _AlphaChReactivePulseScale ) + _AlphaChReactivePulseOffset );
			float y96_g4671 = 127.0;
			float localglslmod96_g4671 = glslmod96_g4671( x96_g4671 , y96_g4671 );
			float2 CenteredUV15_g4675 = ( i.uv_texcoord - _AlphaChReactiveRadialCenter );
			float2 break17_g4675 = CenteredUV15_g4675;
			float2 appendResult23_g4675 = (float2(( length( CenteredUV15_g4675 ) * _AlphaChReactivePulseScale * 2.0 ) , ( atan2( break17_g4675.x , break17_g4675.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4671 = ( _AlphaChReactivePulseOffset + appendResult23_g4675.x );
			float y97_g4671 = 127.0;
			float localglslmod97_g4671 = glslmod97_g4671( x97_g4671 , y97_g4671 );
			int EmissionReactiveMode99_g4671 = _AlphaChReactiveMode;
			int temp_output_90_0_g4671 = ( EmissionReactiveMode99_g4671 - 1 );
			float lerpResult77_g4671 = lerp( localglslmod96_g4671 , localglslmod97_g4671 , (float)saturate( temp_output_90_0_g4671 ));
			float lerpResult174_g4671 = lerp( DirectionalMap106_g4671 , ( 1.0 - DirectionalMap106_g4671 ) , (float)saturate( ( EmissionReactiveMode99_g4671 - 3 ) ));
			float x98_g4671 = ( _AlphaChReactivePulseOffset + ( _AlphaChReactivePulseScale * lerpResult174_g4671 ) );
			float y98_g4671 = 127.0;
			float localglslmod98_g4671 = glslmod98_g4671( x98_g4671 , y98_g4671 );
			float lerpResult87_g4671 = lerp( lerpResult77_g4671 , localglslmod98_g4671 , (float)saturate( ( temp_output_90_0_g4671 - 1 ) ));
			float Delay3_g4674 = lerpResult87_g4671;
			float localAudioLinkLerp3_g4674 = AudioLinkLerp3_g4674( Band3_g4674 , Delay3_g4674 );
			float lerpResult102_g4671 = lerp( 1.0 , localAudioLinkLerp3_g4674 , (float)temp_output_64_0_g4671);
			float lerpResult103_g4671 = lerp( lerpResult66_g4671 , lerpResult102_g4671 , (float)saturate( EmissionReactiveMode99_g4671 ));
			int Band3_g4676 = _AlphaChReactiveBand;
			float FilteredAmount3_g4676 = ( ( 1.0 - _AlphaChReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4676 = AudioLinkLerp3_g4676( Band3_g4676 , FilteredAmount3_g4676 );
			float lerpResult168_g4671 = lerp( 1.0 , localAudioLinkLerp3_g4676 , (float)temp_output_64_0_g4671);
			float lerpResult172_g4671 = lerp( lerpResult103_g4671 , lerpResult168_g4671 , (float)saturate( ( EmissionReactiveMode99_g4671 - 4 ) ));
			float ReactivityAlpha132_g4671 = (_AlphaChReactiveMinBrightness + (lerpResult172_g4671 - 0.0) * (( _AlphaChReactiveMinBrightness + 1.0 ) - _AlphaChReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_159 = (1.0).xxxx;
			float4 lerpResult268_g4671 = lerp( temp_cast_159 , _AlphaChReactiveTint , (float)step( EmissionReactiveBand243_g4671 , 9 ));
			float4 FinalReactivity68_g4671 = ( ReactivityAlpha132_g4671 * lerpResult268_g4671 );
			float4 lerpResult146_g4671 = lerp( ( EmissionGlowTog262_g4671 * FinalReactivity68_g4671 ) , ( EmissionGlow142_g4671 + FinalReactivity68_g4671 ) , (float)saturate( _AlphaChReactiveBlendMode ));
			float4 ReversedReactivity152_g4671 = ( ( 1.0 - ReactivityAlpha132_g4671 ) * lerpResult268_g4671 );
			int temp_output_157_0_g4671 = ( _AlphaChReactiveBlendMode - 1 );
			float4 lerpResult114_g4671 = lerp( lerpResult146_g4671 , ( EmissionGlowTog262_g4671 * ReversedReactivity152_g4671 ) , (float)saturate( temp_output_157_0_g4671 ));
			float4 lerpResult164_g4671 = lerp( lerpResult114_g4671 , ( EmissionGlow142_g4671 + ( ReversedReactivity152_g4671 * step( EmissionReactiveBand243_g4671 , 9 ) ) ) , (float)max( saturate( ( temp_output_157_0_g4671 - 1 ) ) , ( 1.0 - step( EmissionReactiveBand243_g4671 , 9 ) ) ));
			float localIfAudioLinkv2Exists1_g4686 = IfAudioLinkv2Exists1_g4686();
			float4 lerpResult278_g4671 = lerp( float4( 0,0,0,0 ) , ( lerpResult164_g4671 * (GlowMaskRGBA174_g4606).a * localIfAudioLinkv2Exists1_g4686 ) , _EnableAlphaChannel);
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 temp_cast_168 = (1.0).xx;
			float2 lerpResult859 = lerp( temp_cast_168 , ( _EmissionPanSpeed * _Time.y ) , _EmissionPan);
			float2 uv_EffectMask = i.uv_texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float2 temp_cast_169 = (1.0).xx;
			float2 lerpResult906 = lerp( temp_cast_169 , ( _EmissionMaskPanSpeed * _Time.y ) , _EmissionMaskPan);
			float4 tex2DNode866 = tex2D( _EffectMask, ( uv_EffectMask + lerpResult906 ) );
			int temp_output_18_0_g3967 = _EmissionMaskingChannel;
			float lerpResult1_g3967 = lerp( 1.0 , tex2DNode866.r , (float)saturate( temp_output_18_0_g3967 ));
			int temp_output_5_0_g3967 = ( temp_output_18_0_g3967 - 1 );
			float lerpResult12_g3967 = lerp( lerpResult1_g3967 , tex2DNode866.g , (float)saturate( temp_output_5_0_g3967 ));
			int temp_output_6_0_g3967 = ( temp_output_5_0_g3967 - 1 );
			float lerpResult10_g3967 = lerp( lerpResult12_g3967 , tex2DNode866.b , (float)saturate( temp_output_6_0_g3967 ));
			float lerpResult11_g3967 = lerp( lerpResult10_g3967 , tex2DNode866.a , (float)saturate( ( temp_output_6_0_g3967 - 1 ) ));
			#ifdef _EMISSION
				float4 staticSwitch1062 = ( _EmissionColor * tex2D( _EmissionMap, ( uv_EmissionMap + lerpResult859 ) ) * lerpResult11_g3967 );
			#else
				float4 staticSwitch1062 = float4( 0,0,0,0 );
			#endif
			float4 EmissionRGBA786 = staticSwitch1062;
			float4 temp_output_211_0_g4607 = EmissionRGBA786;
			float4 temp_cast_175 = (1.0).xxxx;
			float3 temp_cast_176 = (1.0).xxx;
			int EmissionGlowZone47_g4607 = _EmissionGlowZone;
			int clampResult8_g4618 = clamp( EmissionGlowZone47_g4607 , 1 , 4 );
			int temp_output_3_0_g4618 = ( clampResult8_g4618 - 1 );
			int Zone16_g4618 = temp_output_3_0_g4618;
			float3 localgetThemeData16_g4618 = getThemeData( Zone16_g4618 );
			int Band11_g4619 = 56;
			int localIsLumaActive11_g4619 = IsLumaActive11_g4619( Band11_g4619 );
			int temp_output_14_0_g4618 = localIsLumaActive11_g4619;
			int lerpResult15_g4618 = lerp( temp_output_3_0_g4618 , ( 63 - temp_output_3_0_g4618 ) , (float)temp_output_14_0_g4618);
			int Band2_g4618 = lerpResult15_g4618;
			int Delay2_g4618 = 0;
			float3 localLumaGlowData2_g4618 = LumaGlowData2_g4618( Band2_g4618 , Delay2_g4618 );
			float3 lerpResult17_g4618 = lerp( ( localgetThemeData16_g4618 * localLumaGlowData2_g4618 ) , localLumaGlowData2_g4618 , (float)temp_output_14_0_g4618);
			int temp_output_21_0_g4607 = saturate( EmissionGlowZone47_g4607 );
			float3 lerpResult20_g4607 = lerp( temp_cast_176 , lerpResult17_g4618 , (float)temp_output_21_0_g4607);
			float3 temp_cast_180 = (1.0).xxx;
			int clampResult8_g4620 = clamp( EmissionGlowZone47_g4607 , 1 , 4 );
			int temp_output_3_0_g4620 = ( clampResult8_g4620 - 1 );
			int Zone15_g4620 = temp_output_3_0_g4620;
			float3 localgetThemeData15_g4620 = getThemeData( Zone15_g4620 );
			int Band11_g4621 = 56;
			int localIsLumaActive11_g4621 = IsLumaActive11_g4621( Band11_g4621 );
			int temp_output_13_0_g4620 = localIsLumaActive11_g4621;
			int lerpResult14_g4620 = lerp( temp_output_3_0_g4620 , ( 63 - temp_output_3_0_g4620 ) , (float)temp_output_13_0_g4620);
			int Band11_g4620 = lerpResult14_g4620;
			float cos6_g4607 = cos( radians( _EmissionGlowPulseDir ) );
			float sin6_g4607 = sin( radians( _EmissionGlowPulseDir ) );
			float2 rotator6_g4607 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos6_g4607 , -sin6_g4607 , sin6_g4607 , cos6_g4607 )) + float2( 0.5,0.5 );
			int Band6_g4613 = _EmissionGlowAnimationBand;
			int Mode6_g4613 = ( ( _EmissionGlowAnimationMode * 2 ) + _EmissionGlowAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4613 = AudioLinkDecodeDataAsUInt6_g4613( Band6_g4613 , Mode6_g4613 );
			float localGetLocalTime2_g4614 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_LOCAL_TIME ) );
			float lerpResult206_g4607 = lerp( ( ( localAudioLinkDecodeDataAsUInt6_g4613 % 628319 ) / 100000.0 ) , localGetLocalTime2_g4614 , (float)saturate( ( _EmissionGlowAnimationMode - 3 ) ));
			float EmissionGlowAnimation195_g4607 = ( _EmissionGlowAnimationStrength * lerpResult206_g4607 * step( _EmissionGlowAnimationBand , 9 ) );
			float x13_g4607 = ( ( rotator6_g4607.x * _EmissionGlowPulseScale ) + _EmissionGlowPulseOffset + EmissionGlowAnimation195_g4607 );
			float y13_g4607 = 127.0;
			float localglslmod13_g4607 = glslmod13_g4607( x13_g4607 , y13_g4607 );
			float2 CenteredUV15_g4609 = ( i.uv_texcoord - _EmissionGlowRadialCenter );
			float2 break17_g4609 = CenteredUV15_g4609;
			float2 appendResult23_g4609 = (float2(( length( CenteredUV15_g4609 ) * _EmissionGlowPulseScale * 2.0 ) , ( atan2( break17_g4609.x , break17_g4609.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x12_g4607 = ( _EmissionGlowPulseOffset + appendResult23_g4609.x + EmissionGlowAnimation195_g4607 );
			float y12_g4607 = 127.0;
			float localglslmod12_g4607 = glslmod12_g4607( x12_g4607 , y12_g4607 );
			int EmissionGlowMode35_g4607 = _EmissionGlowMode;
			int temp_output_37_0_g4607 = ( EmissionGlowMode35_g4607 - 1 );
			float lerpResult5_g4607 = lerp( localglslmod13_g4607 , localglslmod12_g4607 , (float)saturate( temp_output_37_0_g4607 ));
			float DirectionalMap106_g4607 = Direction27_g4606;
			float lerpResult179_g4607 = lerp( DirectionalMap106_g4607 , ( 1.0 - DirectionalMap106_g4607 ) , (float)saturate( ( EmissionGlowMode35_g4607 - 3 ) ));
			float x34_g4607 = ( _EmissionGlowPulseOffset + ( _EmissionGlowPulseScale * lerpResult179_g4607 ) + EmissionGlowAnimation195_g4607 );
			float y34_g4607 = 127.0;
			float localglslmod34_g4607 = glslmod34_g4607( x34_g4607 , y34_g4607 );
			float lerpResult30_g4607 = lerp( lerpResult5_g4607 , localglslmod34_g4607 , (float)saturate( ( temp_output_37_0_g4607 - 1 ) ));
			float EmissionGlowDelay56_g4607 = lerpResult30_g4607;
			float Delay11_g4620 = EmissionGlowDelay56_g4607;
			float3 localLumaGlowLerp11_g4620 = LumaGlowLerp11_g4620( Band11_g4620 , Delay11_g4620 );
			float3 lerpResult17_g4620 = lerp( ( localgetThemeData15_g4620 * localLumaGlowLerp11_g4620 ) , localLumaGlowLerp11_g4620 , (float)temp_output_13_0_g4620);
			float3 lerpResult22_g4607 = lerp( temp_cast_180 , lerpResult17_g4620 , (float)temp_output_21_0_g4607);
			float3 lerpResult23_g4607 = lerp( lerpResult20_g4607 , lerpResult22_g4607 , (float)saturate( EmissionGlowMode35_g4607 ));
			float4 temp_cast_190 = (1.0).xxxx;
			float temp_output_10_0_g4615 = EmissionGlowDelay56_g4607;
			float Position1_g4617 = ( temp_output_10_0_g4615 / 127.0 );
			float4 localAudioLinkLerp1_g4617 = AudioLinkLerp1_g4617( Position1_g4617 );
			int clampResult8_g4615 = clamp( ( EmissionGlowZone47_g4607 - 4 ) , 1 , 3 );
			int Band11_g4615 = ( 59 - ( clampResult8_g4615 - 1 ) );
			float Delay11_g4615 = temp_output_10_0_g4615;
			float3 localLumaGlowLerp11_g4615 = LumaGlowLerp11_g4615( Band11_g4615 , Delay11_g4615 );
			int Band11_g4616 = 56;
			int localIsLumaActive11_g4616 = IsLumaActive11_g4616( Band11_g4616 );
			float4 lerpResult14_g4615 = lerp( localAudioLinkLerp1_g4617 , float4( localLumaGlowLerp11_g4615 , 0.0 ) , (float)localIsLumaActive11_g4616);
			float4 lerpResult52_g4607 = lerp( temp_cast_190 , lerpResult14_g4615 , (float)saturate( EmissionGlowZone47_g4607 ));
			float4 lerpResult51_g4607 = lerp( float4( lerpResult23_g4607 , 0.0 ) , lerpResult52_g4607 , (float)saturate( ( EmissionGlowZone47_g4607 - 4 ) ));
			float4 temp_cast_195 = (_EmissionGlowMinBrightness).xxxx;
			float4 temp_cast_196 = (( _EmissionGlowMinBrightness + 1.0 )).xxxx;
			int temp_output_245_0_g4607 = saturate( EmissionGlowZone47_g4607 );
			float4 EmissionGlow142_g4607 = ( (temp_cast_195 + (lerpResult51_g4607 - float4( 0,0,0,0 )) * (temp_cast_196 - temp_cast_195) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 ))) * _EmissionGlowTint * temp_output_245_0_g4607 );
			float4 lerpResult248_g4607 = lerp( temp_cast_175 , EmissionGlow142_g4607 , (float)temp_output_245_0_g4607);
			float4 EmissionGlowTog249_g4607 = lerpResult248_g4607;
			int EmissionReactiveBand254_g4607 = _EmissionReactiveBand;
			int Band3_g4608 = EmissionReactiveBand254_g4607;
			int Delay3_g4608 = 0;
			float localAudioLinkData3_g4608 = AudioLinkData3_g4608( Band3_g4608 , Delay3_g4608 );
			int temp_output_64_0_g4607 = step( _EmissionReactiveBand , 9 );
			float lerpResult66_g4607 = lerp( 1.0 , localAudioLinkData3_g4608 , (float)temp_output_64_0_g4607);
			int Band3_g4610 = _EmissionReactiveBand;
			float cos78_g4607 = cos( radians( _EmissionReactivePulseDir ) );
			float sin78_g4607 = sin( radians( _EmissionReactivePulseDir ) );
			float2 rotator78_g4607 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos78_g4607 , -sin78_g4607 , sin78_g4607 , cos78_g4607 )) + float2( 0.5,0.5 );
			float x96_g4607 = ( ( rotator78_g4607.x * _EmissionReactivePulseScale ) + _EmissionReactivePulseOffset );
			float y96_g4607 = 127.0;
			float localglslmod96_g4607 = glslmod96_g4607( x96_g4607 , y96_g4607 );
			float2 CenteredUV15_g4611 = ( i.uv_texcoord - _EmissionReactiveRadialCenter );
			float2 break17_g4611 = CenteredUV15_g4611;
			float2 appendResult23_g4611 = (float2(( length( CenteredUV15_g4611 ) * _EmissionReactivePulseScale * 2.0 ) , ( atan2( break17_g4611.x , break17_g4611.y ) * ( 1.0 / 6.28318548202515 ) * 1.0 )));
			float x97_g4607 = ( _EmissionReactivePulseOffset + appendResult23_g4611.x );
			float y97_g4607 = 127.0;
			float localglslmod97_g4607 = glslmod97_g4607( x97_g4607 , y97_g4607 );
			int EmissionReactiveMode99_g4607 = _EmissionReactiveMode;
			int temp_output_90_0_g4607 = ( EmissionReactiveMode99_g4607 - 1 );
			float lerpResult77_g4607 = lerp( localglslmod96_g4607 , localglslmod97_g4607 , (float)saturate( temp_output_90_0_g4607 ));
			float lerpResult174_g4607 = lerp( DirectionalMap106_g4607 , ( 1.0 - DirectionalMap106_g4607 ) , (float)saturate( ( EmissionReactiveMode99_g4607 - 3 ) ));
			float x98_g4607 = ( _EmissionReactivePulseOffset + ( _EmissionReactivePulseScale * lerpResult174_g4607 ) );
			float y98_g4607 = 127.0;
			float localglslmod98_g4607 = glslmod98_g4607( x98_g4607 , y98_g4607 );
			float lerpResult87_g4607 = lerp( lerpResult77_g4607 , localglslmod98_g4607 , (float)saturate( ( temp_output_90_0_g4607 - 1 ) ));
			float Delay3_g4610 = lerpResult87_g4607;
			float localAudioLinkLerp3_g4610 = AudioLinkLerp3_g4610( Band3_g4610 , Delay3_g4610 );
			float lerpResult102_g4607 = lerp( 1.0 , localAudioLinkLerp3_g4610 , (float)temp_output_64_0_g4607);
			float lerpResult103_g4607 = lerp( lerpResult66_g4607 , lerpResult102_g4607 , (float)saturate( EmissionReactiveMode99_g4607 ));
			int Band3_g4612 = _EmissionReactiveBand;
			float FilteredAmount3_g4612 = ( ( 1.0 - _EmissionReactiveGlobalSmoothing ) * 15.0 );
			float localAudioLinkLerp3_g4612 = AudioLinkLerp3_g4612( Band3_g4612 , FilteredAmount3_g4612 );
			float lerpResult168_g4607 = lerp( 1.0 , localAudioLinkLerp3_g4612 , (float)temp_output_64_0_g4607);
			float lerpResult172_g4607 = lerp( lerpResult103_g4607 , lerpResult168_g4607 , (float)saturate( ( EmissionReactiveMode99_g4607 - 4 ) ));
			float ReactivityAlpha132_g4607 = (_EmissionReactiveMinBrightness + (lerpResult172_g4607 - 0.0) * (( _EmissionReactiveMinBrightness + 1.0 ) - _EmissionReactiveMinBrightness) / (1.0 - 0.0));
			float4 temp_cast_207 = (1.0).xxxx;
			float4 lerpResult265_g4607 = lerp( temp_cast_207 , _EmissionReactiveTint , (float)step( EmissionReactiveBand254_g4607 , 9 ));
			float4 FinalReactivity68_g4607 = ( ReactivityAlpha132_g4607 * lerpResult265_g4607 );
			float4 lerpResult146_g4607 = lerp( ( EmissionGlowTog249_g4607 * FinalReactivity68_g4607 ) , ( EmissionGlow142_g4607 + FinalReactivity68_g4607 ) , (float)saturate( _EmissionReactiveBlendMode ));
			float4 ReversedReactivity152_g4607 = ( ( 1.0 - ReactivityAlpha132_g4607 ) * lerpResult265_g4607 );
			int temp_output_157_0_g4607 = ( _EmissionReactiveBlendMode - 1 );
			float4 lerpResult114_g4607 = lerp( lerpResult146_g4607 , ( EmissionGlowTog249_g4607 * ReversedReactivity152_g4607 ) , (float)saturate( temp_output_157_0_g4607 ));
			float4 lerpResult164_g4607 = lerp( lerpResult114_g4607 , ( EmissionGlow142_g4607 + ( ReversedReactivity152_g4607 * step( EmissionReactiveBand254_g4607 , 9 ) ) ) , (float)saturate( ( temp_output_157_0_g4607 - 1 ) ));
			float grayscale214_g4607 = Luminance(temp_output_211_0_g4607.rgb);
			float smoothstepResult215_g4607 = smoothstep( 0.0 , 0.5 , grayscale214_g4607);
			int ReactiveBlendmode272_g4607 = _EmissionReactiveBlendMode;
			float x270_g4607 = (float)ReactiveBlendmode272_g4607;
			float y270_g4607 = 2.0;
			float localglslmod270_g4607 = glslmod270_g4607( x270_g4607 , y270_g4607 );
			float lerpResult271_g4607 = lerp( localglslmod270_g4607 , (float)_EmissionGlowBlendMode , (float)saturate( EmissionGlowZone47_g4607 ));
			float4 lerpResult212_g4607 = lerp( ( lerpResult164_g4607 * temp_output_211_0_g4607 ) , ( ( lerpResult164_g4607 * smoothstepResult215_g4607 ) + temp_output_211_0_g4607 ) , lerpResult271_g4607);
			float localIfAudioLinkv2Exists1_g4622 = IfAudioLinkv2Exists1_g4622();
			float4 lerpResult281_g4607 = lerp( temp_output_211_0_g4607 , lerpResult212_g4607 , localIfAudioLinkv2Exists1_g4622);
			#ifdef _EMISSION
				float4 staticSwitch284_g4607 = lerpResult281_g4607;
			#else
				float4 staticSwitch284_g4607 = float4( 0,0,0,0 );
			#endif
			float4 EmissionGlow791 = ( ( lerpResult280_g4623 + lerpResult276_g4639 + lerpResult278_g4655 + lerpResult278_g4671 ) + staticSwitch284_g4607 );
			float4 EmissionRGBA135_g4905 = EmissionGlow791;
			float4 EffectMaskRGBA871 = tex2D( _EffectMask, uv_EffectMask );
			float4 break57_g4905 = EffectMaskRGBA871;
			int temp_output_18_0_g4911 = _IridescentMaskingChannel;
			float lerpResult1_g4911 = lerp( 1.0 , break57_g4905.r , (float)saturate( temp_output_18_0_g4911 ));
			int temp_output_5_0_g4911 = ( temp_output_18_0_g4911 - 1 );
			float lerpResult12_g4911 = lerp( lerpResult1_g4911 , break57_g4905.g , (float)saturate( temp_output_5_0_g4911 ));
			int temp_output_6_0_g4911 = ( temp_output_5_0_g4911 - 1 );
			float lerpResult10_g4911 = lerp( lerpResult12_g4911 , break57_g4905.b , (float)saturate( temp_output_6_0_g4911 ));
			float lerpResult11_g4911 = lerp( lerpResult10_g4911 , break57_g4905.a , (float)saturate( ( temp_output_6_0_g4911 - 1 ) ));
			float temp_output_55_0_g4905 = lerpResult11_g4911;
			int Band6_g4906 = _IridescentALAnimationBand;
			int Mode6_g4906 = ( ( _IridescentALAnimationMode * 2 ) + _IridescentALAnimationSpeed );
			int localAudioLinkDecodeDataAsUInt6_g4906 = AudioLinkDecodeDataAsUInt6_g4906( Band6_g4906 , Mode6_g4906 );
			float localGetNetworkTime4_g4908 = ( AudioLinkDecodeDataAsSeconds( ALPASS_GENERALVU_NETWORK_TIME ) );
			float localIfAudioLinkv2Exists1_g4909 = IfAudioLinkv2Exists1_g4909();
			float lerpResult118_g4905 = lerp( _Time.y , localGetNetworkTime4_g4908 , localIfAudioLinkv2Exists1_g4909);
			float lerpResult121_g4905 = lerp( ( ( ( localAudioLinkDecodeDataAsUInt6_g4906 % 628319 ) / 100000.0 ) * step( _IridescentALAnimationBand , 9 ) ) , lerpResult118_g4905 , (float)saturate( ( _IridescentALAnimationMode - 3 ) ));
			float EmissionGlowAnimation62_g4905 = ( _IridescentALAnimationStrength * lerpResult121_g4905 );
			float3 tex2DNode241 = UnpackScaleNormal( tex2D( _BumpMap, uv_MainTex ), ( _BumpScale * 1.25 ) );
			float3 appendResult1198 = (float3(tex2DNode241.xy , ( tex2DNode241.b * ( ( i.ASEIsFrontFacing * 2.0 ) - 1.0 ) )));
			float3 Normal243 = appendResult1198;
			float3 temp_output_21_0_g4905 = Normal243;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult4_g4905 = normalize( ( WorldReflectionVector( i , temp_output_21_0_g4905 ) + ase_worldViewDir ) );
			float dotResult18_g4905 = dot( normalizeResult4_g4905 , ase_worldViewDir );
			float temp_output_197_0_g4905 = ( dotResult18_g4905 * 0.5 );
			float3 normalizeResult592 = normalize( float3(1,1,2) );
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
			float3 break569 = ase_lightColor.rgb;
			float temp_output_571_0 = max( max( break569.x , break569.y ) , break569.z );
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch575 = saturate( temp_output_571_0 );
			#else
				float staticSwitch575 = 1.0;
			#endif
			float3 lerpResult584 = lerp( normalizeResult592 , ase_worldlightDir , staticSwitch575);
			float3 lightDir32 = lerpResult584;
			float3 temp_output_165_0_g4905 = lightDir32;
			float3 normalizeResult168_g4905 = normalize( ( temp_output_165_0_g4905 + ase_worldViewDir ) );
			float3 wNorm170_g4905 = temp_output_21_0_g4905;
			float3 newWorldNormal169_g4905 = (WorldNormalVector( i , wNorm170_g4905 ));
			float dotResult172_g4905 = dot( normalizeResult168_g4905 , newWorldNormal169_g4905 );
			float Specular209_g4905 = max( dotResult172_g4905 , 0.0 );
			float dotResult177_g4905 = dot( temp_output_165_0_g4905 , newWorldNormal169_g4905 );
			float temp_output_182_0_g4905 = max( dotResult177_g4905 , 0.0 );
			float smoothstepResult194_g4905 = smoothstep( -0.125 , 0.5 , temp_output_182_0_g4905);
			float lerpResult630 = lerp( (1*0.5 + 0.5) , 1 , _WorldSpaceLightPos0.w);
			float lerpResult580 = lerp( 1.0 , lerpResult630 , staticSwitch575);
			float Attenuation533 = lerpResult580;
			float temp_output_208_0_g4905 = ( smoothstepResult194_g4905 * Attenuation533 );
			float lerpResult198_g4905 = lerp( temp_output_197_0_g4905 , Specular209_g4905 , temp_output_208_0_g4905);
			float lerpResult175_g4905 = lerp( dotResult18_g4905 , lerpResult198_g4905 , (float)saturate( _IridescentMode2 ));
			float lerpResult192_g4905 = lerp( temp_output_197_0_g4905 , temp_output_182_0_g4905 , temp_output_208_0_g4905);
			float lerpResult179_g4905 = lerp( lerpResult175_g4905 , lerpResult192_g4905 , (float)saturate( ( _IridescentMode2 - 1 ) ));
			float temp_output_211_0_g4905 = ( ( lerpResult179_g4905 * _IridescentScale ) + _IridescentOffset );
			float temp_output_34_0_g4905 = ( max( abs( sin( ( EmissionGlowAnimation62_g4905 + temp_output_211_0_g4905 ) ) ) , 0.0 ) * 2.0 );
			float temp_output_2_0_g4907 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 2.5 ) * temp_output_34_0_g4905 ) , 2.0 ) );
			float temp_output_41_0_g4905 = ( 1.0 - temp_output_2_0_g4907 );
			float4 lerpResult26_g4905 = lerp( _IridescentEmissionColor1 , _IridescentEmissionColor2 , temp_output_41_0_g4905);
			float temp_output_2_0_g4910 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 4.0 ) * max( ( temp_output_34_0_g4905 - 1.0 ) , 0.0 ) ) , 2.0 ) );
			float temp_output_38_0_g4905 = ( 1.0 - temp_output_2_0_g4910 );
			float4 lerpResult32_g4905 = lerp( lerpResult26_g4905 , _IridescentEmissionColor3 , temp_output_38_0_g4905);
			#ifdef UNITY_PASS_FORWARDBASE
				float4 staticSwitch108_g4905 = lerpResult32_g4905;
			#else
				float4 staticSwitch108_g4905 = float4( 0,0,0,0 );
			#endif
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float3 objToWorldDir101 = mul( unity_ObjectToWorld, float4( ase_vertexNormal, 0 ) ).xyz;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float3 tangentToWorldDir257 = mul( ase_tangentToWorldFast, Normal243 );
			float3 normalizeResult259 = normalize( ( objToWorldDir101 + tangentToWorldDir257 ) );
			float3 worldNorm31 = normalizeResult259;
			float3 viewDir29 = ase_worldViewDir;
			float3 normalizeResult13 = normalize( ( viewDir29 + lightDir32 ) );
			float3 halfDir25 = normalizeResult13;
			float dotResult50 = dot( worldNorm31 , halfDir25 );
			float NdotH38 = max( dotResult50 , 0.0 );
			float nh413 = NdotH38;
			float4 tex2DNode246 = tex2D( _MetallicGlossMap, uv_MainTex );
			float lerpResult255 = lerp( _Glossiness , ( tex2DNode246.a * _GlossMapScale ) , step( 10.0 , max( _MetallicGlossMap_TexelSize.z , _MetallicGlossMap_TexelSize.w ) ));
			float Smoothness90 = lerpResult255;
			float temp_output_47_0 = ( 1.0 - saturate( min( (0.3 + (Smoothness90 - 0.0) * (1.0 - 0.3) / (1.0 - 0.0)) , 0.999 ) ) );
			float roughness17 = temp_output_47_0;
			float roughness413 = roughness17;
			float localggx413 = ggx( nh413 , roughness413 );
			float GGXTerm1132 = localggx413;
			float temp_output_214_0_g4905 = GGXTerm1132;
			int temp_output_225_0_g4905 = saturate( _IridescenceLightMode );
			float lerpResult218_g4905 = lerp( 0.0 , temp_output_214_0_g4905 , (float)temp_output_225_0_g4905);
			float dotResult544 = dot( viewDir29 , worldNorm31 );
			float temp_output_2_0_g1 = pow( ( 1.0 / 2.71828 ) , pow( ( -( 1.0 - 20.0 ) * max( ( dotResult544 + -0.2 ) , 0.0 ) ) , 2.0 ) );
			float temp_output_547_0 = temp_output_2_0_g1;
			float RimAlpha1134 = temp_output_547_0;
			float temp_output_215_0_g4905 = RimAlpha1134;
			int temp_output_220_0_g4905 = ( _IridescenceLightMode - 1 );
			float lerpResult219_g4905 = lerp( lerpResult218_g4905 , temp_output_215_0_g4905 , (float)saturate( temp_output_220_0_g4905 ));
			float lerpResult222_g4905 = lerp( lerpResult219_g4905 , max( temp_output_214_0_g4905 , temp_output_215_0_g4905 ) , (float)saturate( ( temp_output_220_0_g4905 - 1 ) ));
			float Atten232_g4905 = temp_output_208_0_g4905;
			float temp_output_233_0_g4905 = ( lerpResult222_g4905 * Atten232_g4905 );
			float4 lerpResult229_g4905 = lerp( staticSwitch108_g4905 , ( staticSwitch108_g4905 * temp_output_233_0_g4905 ) , (float)temp_output_225_0_g4905);
			float Intensity132_g4905 = _IridescentIntensity;
			float4 temp_output_110_0_g4905 = ( lerpResult229_g4905 * Intensity132_g4905 );
			float4 lerpResult46_g4905 = lerp( ( temp_output_110_0_g4905 + EmissionRGBA135_g4905 ) , ( temp_output_110_0_g4905 * EmissionRGBA135_g4905 ) , (float)saturate( _IridescentEmissionMode ));
			float AnimatedDot130_g4905 = ( temp_output_211_0_g4905 + EmissionGlowAnimation62_g4905 );
			float3 hsvTorgb3_g4912 = HSVToRGB( float3(AnimatedDot130_g4905,1.0,1.0) );
			int temp_output_52_0_g4905 = ( _IridescentEmissionMode - 1 );
			float4 lerpResult54_g4905 = lerp( lerpResult46_g4905 , ( EmissionRGBA135_g4905 + float4( ( hsvTorgb3_g4912 * Intensity132_g4905 ) , 0.0 ) ) , (float)saturate( temp_output_52_0_g4905 ));
			int temp_output_90_0_g4905 = ( temp_output_52_0_g4905 - 1 );
			int temp_output_91_0_g4905 = saturate( temp_output_90_0_g4905 );
			float4 lerpResult89_g4905 = lerp( lerpResult54_g4905 , EmissionRGBA135_g4905 , (float)temp_output_91_0_g4905);
			float4 lerpResult82_g4905 = lerp( EmissionRGBA135_g4905 , ( temp_output_55_0_g4905 * lerpResult89_g4905 ) , temp_output_55_0_g4905);
			float4 lerpResult246_g4905 = lerp( EmissionRGBA135_g4905 , lerpResult82_g4905 , _Enableiridescence);
			float4 FinalEmission1029 = lerpResult246_g4905;
			o.Emission = FinalEmission1029.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
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
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "FuralityShaderUI"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.CommentaryNode;794;1332.497,1390.873;Inherit;False;961.6262;243.937;Comment;5;791;798;790;789;787;Luma Glow;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;639;-8884.074,-1676.043;Inherit;False;3010.964;860.379;Comment;27;568;569;570;571;572;574;573;577;575;583;592;582;576;584;32;588;578;581;589;580;533;627;629;630;632;628;1199;Light Color + Attenuation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;403;-3335.939,-3496.149;Inherit;False;2162.522;1530.744;Comment;42;90;1143;1142;386;241;223;391;246;302;1065;383;380;852;225;272;392;385;394;384;224;393;247;255;254;252;7;253;251;269;250;243;388;242;389;1144;1194;1195;1196;1197;1198;1200;1201;Texture Assignment;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;389;-3188.197,-3056.841;Inherit;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;0;False;0;False;1.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;242;-3006.6,-3221.549;Inherit;False;0;223;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;388;-2970.259,-3105.271;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;5;-3238.615,-1376.222;Inherit;False;1756.584;1421.47;Comment;53;22;284;285;362;30;45;23;68;17;47;44;211;381;401;303;163;395;54;396;402;31;227;176;259;46;59;226;256;212;177;258;249;101;41;248;257;29;100;245;6;795;587;590;1145;1147;1148;1150;1180;1181;1182;1188;1189;1191;Input Assignment;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalVertexDataNode;100;-2593.113,-255.3687;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;245;-2547.908,-114.6905;Inherit;False;243;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode;101;-2379.915,-261.8687;Inherit;False;Object;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;257;-2372.083,-114.9804;Inherit;False;Tangent;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexelSizeNode;250;-2892.26,-2840.326;Inherit;False;246;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;269;-3020.702,-3015.853;Inherit;False;0;223;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;258;-2121.888,-254.5151;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;251;-2670.343,-2766.867;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-2330.628,-1069.771;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;259;-2008.888,-253.5151;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;253;-2664.241,-2840.508;Inherit;False;Property;_GlossMapScale;GlossMapScale;43;0;Create;True;0;0;0;False;0;False;1;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2304.152,-2910.047;Inherit;False;Property;_Glossiness;Smoothness;42;0;Create;False;0;0;0;False;0;False;0.5;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;252;-2559.297,-2766.867;Inherit;False;2;0;FLOAT;10;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;254;-2220.061,-2832.362;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;4;-1449.85,-1331.164;Inherit;False;957.896;1201.264;Comment;38;56;40;604;600;48;74;597;36;598;42;33;596;607;37;18;75;605;599;11;72;24;27;49;38;73;50;28;52;25;39;13;71;19;14;8;15;26;10;Dot Products;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;-2027.33,-1071.781;Inherit;False;viewDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1815.471,-256.4359;Inherit;False;worldNorm;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;10;-1395.339,-1281.164;Inherit;False;29;viewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-1397.544,-1043.199;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1399.849,-1118.233;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;8;-1396.339,-1211.164;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;255;-2027.867,-2837.701;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;14;-1207.206,-1086.684;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1215.339,-1257.164;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-2855.798,-845.3053;Inherit;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;256;-2846.284,-985.8676;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;71;-1072.621,-1085.356;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-2854.646,-916.5242;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0.3;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;13;-1100.339,-1258.164;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;563;-6117.17,1090.775;Inherit;False;1218.21;440.525;Comment;14;512;516;519;511;534;513;517;501;535;518;520;521;594;1206;Toon Ambience;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-939.8036,-1090.568;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;176;-2657.246,-978.5247;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-960.3385,-1262.164;Inherit;False;halfDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;220;-4332.81,70.03413;Inherit;False;2632.908;1547.742;Comment;46;460;636;635;634;139;140;219;190;310;128;312;311;522;274;313;132;306;275;623;129;314;123;566;138;379;121;231;116;230;445;232;115;301;117;114;300;565;461;233;120;125;514;124;987;1120;1160;BRDF;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;512;-6067.17,1140.775;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-1397.545,-736.2602;Inherit;False;25;halfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-1399.85,-811.295;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMinOpNode;303;-2463.311,-925.2256;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.999;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;456;-6422.013,407.4249;Inherit;False;1957.475;517.7657;Comment;19;450;471;452;469;444;476;415;477;473;472;413;451;470;436;478;479;475;416;1132;Stylize Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;211;-2342.89,-903.3854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;50;-1207.207,-779.7461;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;516;-5894.896,1145.77;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;-2436.355,-3015.931;Inherit;False;MetallticFromTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;73;-1065.78,-781.5579;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;476;-6344.136,724.7207;Inherit;False;Constant;_ToonSpecular;Toon Specular;20;0;Create;True;0;0;0;False;0;False;0.48;0.479;0;0.499;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;248;-2629.301,-709.2548;Inherit;False;247;MetallticFromTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;511;-5761.434,1145.739;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;519;-5944.896,1237.77;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;47;-2111.788,-903.9219;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2693.438,-787.5811;Inherit;False;Property;_Metallic;Metallic;41;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;393;-3172.445,-2357.431;Inherit;False;0;223;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;514;-2719.453,985.0649;Inherit;False;ToonNdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;501;-5623.576,1144.053;Inherit;False;ShadeSH9(uvw);3;Create;1;True;uvw;FLOAT4;0,0,0,0;In;;Inherit;False;getProbes;False;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;534;-5780.627,1416.3;Inherit;False;533;Attenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-919.9026,-783.9518;Inherit;False;NdotH;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;473;-6345.945,648.5159;Inherit;False;Constant;_ToonOffset;Toon Offset;16;0;Create;True;0;0;0;False;0;False;-0.4;-0.39;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-2412.301,-763.2548;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;517;-5760.825,1242.613;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1935.923,-820.6301;Inherit;False;roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;513;-5776.97,1337.775;Inherit;False;514;ToonNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;594;-5601.755,1091.489;Inherit;False;Constant;_Float13;Float 13;20;0;Create;True;0;0;0;False;0;False;0.65;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;477;-6067.136,806.7207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;384;-2437.779,-2302.501;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;518;-5622.967,1240.927;Inherit;False;ShadeSH9(uvw);3;Create;1;True;uvw;FLOAT4;0,0,0,0;In;;Inherit;False;getProbes;False;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-1399.055,-960.3293;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;472;-5895.945,655.5159;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;535;-5599.627,1374.3;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;475;-5902.945,770.5159;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-2269.892,-769.3549;Inherit;False;metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;416;-6164.954,464.0959;Inherit;False;38;NdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;415;-6173.801,539.6567;Inherit;False;17;roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1396.75,-885.2946;Inherit;False;29;viewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;593;-5431.755,1149.489;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;394;-2098.372,-2307.369;Inherit;False;SpecularTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;479;-5755.136,750.7207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;24;-1206.412,-928.7805;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;217;-1594.872,200.3197;Inherit;False;2616.111;764.0852;Comment;33;174;175;156;204;162;213;205;214;215;203;161;202;166;200;201;191;181;208;315;180;158;165;151;152;276;153;480;481;484;482;498;1165;1192;Indirect Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;478;-5760.136,643.7207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;413;-5946.941,511.468;Inherit;False;GGXTerm(nh, roughness);1;Create;2;True;nh;FLOAT;0;In;;Inherit;False;True;roughness;FLOAT;0;In;;Inherit;False;ggx;False;False;0;;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;-2831.27,-633.0755;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;396;-2327.961,-390.6081;Inherit;False;Property;_EnableSpecularMap;Enable Specular Map;46;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;402;-2220.789,-483.7458;Inherit;False;Constant;_Float5;Float 5;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-2628.055,-457.5206;Inherit;False;46;metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;520;-5308.896,1242.77;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;-5210.727,730.8561;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;395;-2066.061,-680.9556;Inherit;False;394;SpecularTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;436;-5605.002,544.9354;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;72;-1073.99,-930.7202;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;451;-5604.283,672.5679;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DiffuseAndSpecularFromMetallicNode;163;-2399.557,-597.6036;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;3;FLOAT3;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;180;-1514.461,680.5375;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;401;-2051.101,-479.9181;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-941.7469,-929.9261;Inherit;False;NdotV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;452;-5209.375,553.4788;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;315;-1300.661,675.7377;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;469;-4966.727,731.8561;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-3174.562,1070.987;Inherit;False;11;NdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;208;-1151.827,677.0204;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;471;-4799.567,730.9291;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-3569.558,177.7777;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;1.2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-982.5577,650.3491;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;461;-2980.706,1074.058;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;450;-4769.774,574.9086;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;191;-853.3322,650.4323;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;444;-4651.538,570.9512;Inherit;False;ToonSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;565;-2804.095,1073.13;Inherit;False;ToonNdotV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;385;-3013.247,-2640.655;Inherit;False;0;223;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;-3386.994,223.6072;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;114;-3461.573,805.1125;Inherit;False;565;ToonNdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;590;-2621.987,-1305.75;Inherit;False;589;InitialLightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-3462.64,952.4464;Inherit;False;17;roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;301;-3254.994,223.6072;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-488.3773,654.145;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-3463.573,734.1125;Inherit;False;514;ToonNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;166;-702.3997,453.5815;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;200;-677.7151,648.213;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;-3388.666,589.1027;Inherit;False;11;NdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;560;-1245.632,1312.672;Inherit;False;1886.165;1162.995;Comment;37;591;542;622;621;595;557;545;625;567;547;558;619;555;548;613;549;620;626;554;556;614;552;550;617;553;610;551;615;618;544;616;537;612;543;609;853;1134;Rimlighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-3390.865,428.9026;Inherit;False;17;roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;116;-3462.773,880.1125;Inherit;False;38;NdotH;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;-3388.366,506.7026;Inherit;False;514;ToonNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2378.209,-1304.412;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;609;-498.8056,2203.786;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;161;-509.7723,469.6328;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;392;-2451.833,-2613.263;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;543;-1187.779,1789.996;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;202;-300.1848,678.6759;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;379;-3135.121,470.3841;Inherit;False;float L = (NdotL) / (NdotL * (1- k) + k)@$float V = (NdotV) / (NdotV * (1-k) +k)@$$return L*V@;1;Create;3;True;k;FLOAT;0;In;;Inherit;False;True;NdotL;FLOAT;0;In;;Inherit;False;True;NdotV;FLOAT;0;In;;Inherit;False;SchlickGGX;False;True;0;;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;138;-3189.65,726.0227;Inherit;False;float FresnelLight = SchlickFresnel(NdotL)@$float FresnelView = SchlickFresnel(NdotV)@$float FresnelDiffuse = 0.5 + 2 * LdotH*LdotH * roughness@$return MixFunc(1, FresnelDiffuse, FresnelLight) * MixFunc(1, FresnelDiffuse, FresnelView)@;1;Create;4;True;NdotL;FLOAT;0;In;;Inherit;False;True;NdotV;FLOAT;0;In;;Inherit;False;True;LdotH;FLOAT;0;In;;Inherit;False;True;roughness;FLOAT;0;In;;Inherit;False;F0;True;False;2;139;140;;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;566;-3170.882,867.2664;Inherit;False;11;NdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;612;-477.8056,2287.786;Inherit;False;Constant;_Vector0;Vector 0;20;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;537;-1181.791,1709.072;Inherit;False;29;viewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;616;-673.2114,1454.868;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;272;-2284.777,-2618.305;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-2079.385,-604.7594;Inherit;False;diffuse;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;544;-972.4919,1731.102;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;618;-669.238,1542.556;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;615;-313.6245,2334.562;Inherit;False;Constant;_Float15;Float 15;20;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;480;-283.3387,506.084;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.35;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;551;-994.2482,1828.831;Inherit;False;Constant;_Float11;Float 11;21;0;Create;True;0;0;0;False;0;False;-0.2;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;123;-2829.634,444.2128;Inherit;False;return (N*G*F) / (4 * (NdotL*NdotV))@;3;Create;5;True;N;FLOAT3;0,0,0;In;;Inherit;False;True;G;FLOAT;0;In;;Inherit;False;True;F;FLOAT;0;In;;Inherit;False;True;NdotL;FLOAT;0;In;;Inherit;False;True;NdotV;FLOAT;0;In;;Inherit;False;BRDF;False;True;0;;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;482;-68.33875,789.084;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.35;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;610;-307.3041,2238.428;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;314;-2832.01,372.4067;Inherit;False;Constant;_Float7;Float 7;10;0;Create;True;0;0;0;False;0;False;0.001;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;214;-77.45105,524.8002;Inherit;False;1191;specColor2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;553;-842.7739,1978.127;Inherit;False;521;ToonAmbience;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;550;-845.248,1736.831;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-64.47279,601.2673;Inherit;False;Constant;_Float4;Float 4;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;561;2095.64,27.8058;Inherit;False;2082.213;872.7515;Comment;38;831;830;829;828;827;826;823;822;824;819;818;490;524;792;497;788;486;494;489;495;492;532;488;496;493;529;491;832;1042;1045;1046;1058;1060;1059;1066;1081;1185;1186;Outlines;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;623;-2658.41,622.8109;Inherit;False;533;Attenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;203;-58.52485,674.2479;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;275;-2675.618,355.3681;Inherit;False;272;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;481;-253.3387,402.084;Inherit;False;2;2;0;FLOAT;0.01;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-2699.387,905.8491;Inherit;False;45;lightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;132;-2651.551,446.4316;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;552;-804.2864,1907.889;Inherit;False;45;lightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;614;-184.6245,2238.562;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;313;-2657.845,542.0784;Inherit;False;514;ToonNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;556;-644.5186,2003.105;Inherit;False;Constant;_Float12;Float 12;20;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;554;-648.5186,1913.105;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;626;-64.21997,2164.697;Inherit;False;Constant;_Float17;Float 17;21;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;-2481.617,300.3679;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;491;3076.28,552.4065;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;549;-727.676,1835.152;Inherit;False;Constant;_Float8;Float 8;20;0;Create;True;0;0;0;False;0;False;20;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;311;-2495.592,917.2233;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;-2476.895,448.7652;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;40.03976,402.8723;Inherit;False;272;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;613;-59.30401,2235.428;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;213;131.8297,544.2889;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;162;-122.9196,431.788;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;32.36602,250.3197;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;129.113,663.7913;Inherit;False;46;metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;548;-717.1375,1742.013;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;529;3380.719,431.3767;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;555;-524.5184,1917.105;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;128;-2302.115,345.1725;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectSpecularLight;151;227.3664,278.3197;Inherit;False;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;310;-2346.613,816.7513;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;558;-504.3968,2017.898;Inherit;False;Property;_RimlightColor;Rimlight Color;49;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;11.98431,11.98431,11.98431,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;547;-563.4562,1738.109;Inherit;False;ExponentialSquared_Blend;-1;;1;7792fe74aab0b2f4d8615a784f562aa2;1,7,0;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;625;75.78027,2222.697;Inherit;False;Property;_Keyword0;Keyword 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDBASE;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;545;58.48236,1477.761;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;547.4448,426.1721;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;532;3520.733,382.9306;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;562;-426.9865,-1298.826;Inherit;False;2708.104;1199.057;Comment;25;905;911;912;909;910;908;907;906;268;864;863;861;860;859;858;871;868;866;862;786;266;267;265;913;1062;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.TransformDirectionNode;492;3363.496,547.6183;Inherit;False;World;Object;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;-2167.837,347.7095;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;222;3678.678,-355.4811;Inherit;False;440.5804;266.2591;Comment;4;169;221;159;1119;Composite;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;-2029.515,342.5311;Inherit;False;BRDF;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;557;340.3037,1469.082;Inherit;False;Rimlighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;265;1209.963,-1067.859;Inherit;True;Property;_EmissionMap;EmissionMap;31;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;159;3706.322,-313.2809;Inherit;False;158;IndirectSpecular;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;267;1330.802,-1248.826;Inherit;False;Property;_EmissionColor;Emission Color;32;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,0.5188679,0.5188679,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;221;3730.281,-237.8131;Inherit;False;219;BRDF;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-816.4901,529.5698;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;140;-2813.083,603.2727;Inherit;False;return j*x+i*(1-x)@;1;Create;3;True;i;FLOAT;0;In;;Inherit;False;True;j;FLOAT;0;In;;Inherit;False;True;x;FLOAT;0;In;;Inherit;False;MixFunc;False;True;0;;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1931.422,-916.1447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;599;-822.542,-307.6921;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;-3030.983,-472.9721;Inherit;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;605;-1093.615,-232.9525;Inherit;False;Constant;_Float14;Float 14;20;0;Create;True;0;0;0;False;0;False;0.1;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;595;-463.6266,1369.061;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;75;-1071.254,-468.1801;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1399.849,-658.295;Inherit;False;29;viewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-987.3672,523.5707;Inherit;False;46;metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;174;-668.5641,526.8943;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.03;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;1570.802,-1101.826;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-1397.826,-503.7185;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;621;-370.3684,1572.545;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;607;-1086.071,-307.0391;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;596;-1401.809,-263.1957;Inherit;False;29;viewDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;33;-1207.206,-626.7461;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;362;-2129.13,-156.8327;Inherit;False;clearcoatNorm;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;-950.3943,-631.1833;Inherit;False;VdotH;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-1791.587,-919.7219;Inherit;False;roughnessSquared;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;598;-1204.471,-306.6816;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1402.521,-428.6837;Inherit;False;25;halfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;597;-1397.114,-338.2305;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;542;-641.7698,1365.349;Inherit;False;39;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;74;-1073.991,-625.5533;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;139;-2812.083,713.2732;Inherit;False;float x = saturate(1-i)@$float x2 = x*x@$return x2*x2*x@;1;Create;1;True;i;FLOAT;0;In;;Inherit;False;SchlickFresnel;False;True;0;;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;591;-229.3808,2146.77;Inherit;False;600;LdotV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-1397.544,-583.2602;Inherit;False;25;halfDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;600;-698.5538,-311.3818;Inherit;False;LdotV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;284;-2635.655,-620.5502;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;604;-958.6155,-306.9525;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;40;-1205.183,-472.1696;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;169;3994.139,-276.3966;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-944.2661,-473.8698;Inherit;False;LdotH;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;587;-2603.063,-1230.459;Inherit;False;533;Attenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-2031.958,-1307.261;Inherit;False;lightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;634;-3188.233,1238.03;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;635;-2982.671,1391.145;Inherit;False;Global;_WorldSpaceLightPos0;_WorldSpaceLightPos0;15;0;Fetch;True;0;0;0;False;0;False;0,0,0,0;-0.3735284,0.9245684,0.07516718,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;636;-2683.895,1302.977;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;568;-8834.074,-1222.282;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;569;-8681.742,-1198.18;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMaxOpNode;570;-8559.542,-1198.18;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;571;-8442.542,-1178.68;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;572;-8320.396,-1179.31;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;574;-8184.584,-1271.711;Inherit;False;Constant;_Float9;Float 9;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;573;-8192.156,-1184.819;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;577;-7802.581,-1318.901;Inherit;False;int lightEnv = int(any(_WorldSpaceLightPos0.xyz))@       $if(lightEnv != 1){$	return 0@$	}$return 1@;0;Create;0;LightExists;True;False;0;;False;0;1;INT;0
Node;AmplifyShaderEditor.StaticSwitch;575;-8015.616,-1225.002;Inherit;False;Property;_Keyword0;Keyword 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDBASE;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;583;-7672.467,-1626.043;Inherit;False;Constant;_FakeLightDir;Fake Light Dir;0;0;Create;True;0;0;0;False;0;False;1,1,2;1,1,2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;592;-7492.139,-1619.998;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;582;-7677.819,-1475.114;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;576;-7656.862,-1317.273;Inherit;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;584;-7325.008,-1619.547;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-7165.986,-1623.907;Inherit;False;lightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-6689.845,-1532.681;Inherit;False;521;ToonAmbience;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;578;-6439.266,-1411.936;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;581;-6248.605,-1415.129;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;589;-6106.444,-1419.762;Inherit;False;InitialLightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;580;-6606.341,-1293.334;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;533;-6459.45,-1297.361;Inherit;False;Attenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;627;-7325.271,-1094.686;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;629;-7336.423,-1022.664;Inherit;False;Global;_WorldSpaceLightPos0;_WorldSpaceLightPos0;15;0;Fetch;True;0;0;0;False;0;False;0,0,0,0;-0.3735284,0.9245684,0.07516718,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;630;-6807.647,-1120.831;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;632;-6667.123,-1432.648;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;628;-7069.139,-1200;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;793;4084.51,-419.9491;Inherit;False;1029;FinalEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;378;4100.366,-511.162;Inherit;False;224;MainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;787;1382.497,1440.873;Inherit;False;786;EmissionRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;789;1392.707,1516.109;Inherit;False;788;OutlineRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;795;-3209.973,-1321.565;Inherit;False;Property;_Culling;Culling;306;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;790;2002.123,1543.81;Inherit;False;OutlineGlow;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;798;1961.58,1450.408;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;791;2081.115,1445.012;Inherit;False;EmissionGlow;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SurfaceDepthNode;524;3118.077,458.5213;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;819;2748.469,326.6143;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;824;2956.071,303.7247;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;822;2550.839,340.7459;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1000;False;3;FLOAT;1000;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;823;2570.85,500.8378;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;827;2521.599,567.8765;Inherit;False;Constant;_Float16;Float 16;26;0;Create;True;0;0;0;False;0;False;1000;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;828;2680.669,636.316;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;829;2888.271,613.4264;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;830;2483.039,650.4476;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1000;False;3;FLOAT;1000;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;831;2503.05,810.5396;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;225;-3007.329,-3413.345;Inherit;False;0;223;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;498;485.348,590.3273;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;484;306.6857,585.6535;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;852;-2074.02,-2722.352;Inherit;False;851;SpecularAntiAlias;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;862;1041.562,-1033.402;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;859;751.5616,-913.4023;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;860;561.5616,-938.4023;Inherit;False;Constant;_Float18;Float 18;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;863;219.952,-742.4731;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;864;558.0835,-863.7878;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;268;716.8016,-1035.826;Inherit;False;0;265;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;906;208.5399,-512.4272;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;910;15.06175,-462.8127;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;909;-323.0697,-341.498;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;912;486.7254,-565.1698;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;911;-3.374744,-656.1698;Inherit;False;0;866;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;871;1003.037,-350.0024;Inherit;False;EffectMaskRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;913;676.2248,-352.4956;Inherit;True;Property;_TextureSample0;Texture Sample 0;30;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;866;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;984;1174.184,-646.1843;Inherit;True;EffectMaskChannel;-1;;3967;9aff8198f8f27794787d8759aa359a04;0;5;14;FLOAT;0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;18;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-3173.241,958.7939;Inherit;False;39;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1027;4291.965,105.7077;Inherit;False;791;EmissionGlow;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1031;1959.949,1643.783;Inherit;False;DirectionMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1032;4430.452,465.3638;Inherit;False;1031;DirectionMap;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;792;3756.018,53.18221;Inherit;False;790;OutlineGlow;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;788;2525.206,109.5492;Inherit;False;OutlineRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1043;2795.438,112.6829;Inherit;False;871;EffectMaskRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1044;3034.638,113.9829;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1011;4262.274,6.535469;Inherit;False;243;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;226;-3076.27,-549.0756;Inherit;False;1049;IridescentMainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;1058;3137.704,747.7896;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;495;3640.296,550.8184;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;489;3680.985,243.5691;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMinOpNode;832;3638.739,385.1481;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;493;3237.892,553.2095;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;494;3833.85,241.0057;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode;1059;3854.503,558.9896;Inherit;False;Object;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;1060;3875.304,715.7897;Inherit;False;World;Object;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1061;3312.104,-28.2103;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalVertexDataNode;488;3480.785,242.0691;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;818;2589.399,258.1747;Inherit;False;Constant;_Float10;Float 10;26;0;Create;True;0;0;0;False;0;False;10000;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;786;2002.439,-932.0972;Inherit;False;EmissionRGBA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1064;1629.501,-909.2549;Inherit;False;Constant;_Float20;Float 20;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;380;-2930.957,-2386.695;Inherit;True;Property;_SpecGlossMap;Specular;47;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;383;-2699.411,-2185.3;Inherit;False;Property;_SpecColor;Specular Color;48;0;Fetch;False;0;0;0;False;0;False;1,1,1,0;0.3169973,0.3169973,0.3169973,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1065;-1840.527,-3445.194;Inherit;False;Property;_ShowMain;ShowMain;208;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-3285.939,-3140.613;Inherit;False;Property;_BumpScale;Normal Scale;39;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;391;-2771.034,-2477.877;Inherit;False;Property;_OcclusionStrength;Occlusion Strength;45;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;223;-2790.1,-3446.149;Inherit;True;Property;_MainTex;Main Tex;28;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;241;-2788.6,-3244.549;Inherit;True;Property;_BumpMap;Normal;38;2;[Normal];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;866;671.9223,-679.6194;Inherit;True;Property;_EffectMask;Effect Mask;30;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;907;75.53984,-539.4272;Inherit;False;Constant;_Float19;Float 19;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;868;705.1241,-481.1015;Inherit;False;Property;_EmissionMaskingChannel;Emission Masking Channel;33;1;[Enum];Create;False;0;5;None;0;R;1;G;2;B;3;A;4;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;908;-2.460165,-365.4272;Inherit;False;Property;_EmissionMaskPan;Emission Mask Pan;34;1;[ToggleUI];Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;905;-346.4601,-469.4272;Inherit;False;Property;_EmissionMaskPanSpeed;Emission Mask Pan Speed;35;0;Create;False;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;861;540.5616,-766.4023;Inherit;False;Property;_EmissionPan;Emission Pan;36;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;858;200.5616,-870.4023;Inherit;False;Property;_EmissionPanSpeed;Emission Pan Speed;37;0;Create;False;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;1067;1402.106,1599.42;Inherit;False;Property;_ShowGlow;ShowGlow;205;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1074;1625.512,1469.38;Inherit;False;Luma Glow Properties;55;;4606;7b40ef0e4b7a40f4f9276cd62640845c;1,260,0;2;1;COLOR;0,0,0,0;False;155;FLOAT3;0,0,0;False;3;FLOAT;244;FLOAT4;183;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1075;4763.708,211.9052;Inherit;False;Property;_ShowEffects;ShowEffects;204;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1062;1764.78,-943.7126;Inherit;False;Property;_EnableEmission;_Enable Emission;209;0;Create;False;0;0;0;False;0;False;0;0;0;True;_EMISSION;Toggle;2;Key0;Key1;Create;True;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1066;2124.162,89.25903;Inherit;False;Property;_ShowOutline;ShowOutline;206;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1081;2121.584,167.0743;Inherit;False;Property;_ShowOutline2;ShowOutline2;207;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1095;4455.95,550.3781;Inherit;False;32;lightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;460;-2981.99,956.8101;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.125;False;2;FLOAT;0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;983;4391.114,201.3586;Inherit;False;871;EffectMaskRGBA;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1029;5287.174,278.7382;Inherit;False;FinalEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;986;4408.033,344.0441;Inherit;False;557;Rimlighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1118;5024.975,112.8467;Inherit;False;RimlightEffects;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1119;3712.385,-167.4584;Inherit;False;1118;RimlightEffects;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;988;4397.987,266.4666;Inherit;False;987;ColoredSpec;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-3038.383,159.6466;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;987;-2860.835,149.3844;Inherit;False;ColoredSpec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1120;-3083.43,383.6133;Inherit;False;1117;SpecEffects;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1117;5016.975,3.84671;Inherit;False;SpecEffects;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;445;-3270.5,299.042;Inherit;False;444;ToonSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1132;-5621.691,460.2031;Inherit;False;GGXTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;617;-481.7099,1489.51;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;620;-347.238,1489.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;619;-182.238,1488.556;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1134;38.33276,1373.834;Inherit;False;RimAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1127;4223.965,452.6614;Inherit;False;533;Attenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1141;4793.75,336.9004;Inherit;False;Iridescent Emission;210;;4905;2a6b7ed36109aad45b1d6a13ef93c485;0;8;214;FLOAT;0;False;215;FLOAT;0;False;207;FLOAT;0;False;165;FLOAT3;0,0,0;False;84;COLOR;0,0,0,0;False;21;FLOAT3;0,0,1;False;44;COLOR;0,0,0,0;False;56;COLOR;0,0,0,0;False;2;COLOR;0;COLOR;93
Node;AmplifyShaderEditor.SimpleMinOpNode;1142;-1548.589,-2761.705;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1410.964,-2767.599;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1144;-1546.305,-2910.684;Inherit;False;SmoothnessColorMult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1146;-1698.886,-501.7159;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;-2484.676,-3439.029;Inherit;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1048;4322.479,-94.13754;Inherit;False;224;MainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1149;-2887.883,-734.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1148;-3251.883,-930.886;Inherit;False;224;MainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1150;-3073.883,-974.886;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;59;-3111.619,-716.5183;Inherit;False;Property;_Color;Color;29;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.9,0.9,0.9,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1147;-3110.883,-802.886;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5503.371,-421.687;Float;False;True;-1;5;FuralityShaderUI;0;0;CustomLighting;Furality/Sylva Shader/Sylva Transparent Outline;False;False;False;False;False;False;True;True;True;False;True;False;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;True;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;True;_BlendOPsrc;10;True;_BlendOPdst;0;5;False;;10;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;_Culling;-1;0;True;_MaskClipValue;1;Include;;True;1ec20832dfbb48343b8e0764e0864276;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;522;-2643.834,795.6546;Inherit;False;521;ToonAmbience;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;521;-5129.626,1237.589;Inherit;False;ToonAmbience;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-2672.565,275.1928;Inherit;False;23;diffuse;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1160;-2670.334,200.1979;Inherit;False;1155;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1135;4221.086,375.6588;Inherit;False;1134;RimAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1133;4486.572,701.4352;Inherit;False;1132;GGXTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1154;4563.932,-907.7635;Inherit;False;Constant;_Float21;Float 21;49;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1165;101.98,461.387;Inherit;False;IndirectAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1168;1511.465,577.6862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;850;1694.621,568.6945;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1169;1218.465,607.6862;Inherit;False;1144;SmoothnessColorMult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;847;1088.521,513.8946;Inherit;False;31;worldNorm;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;848;1266.621,508.6945;Inherit;False;float3 nDdx = ddx_fine(WorldNormal)@$float3 nDdy = ddy_fine(WorldNormal)@$return pow( saturate( max( dot( nDdx, nDdx ), dot( nDdy, nDdy ) ) ), 0.333 )@;1;Create;1;True;WorldNormal;FLOAT3;0,0,0;In;;Inherit;False;geometricRoughness;False;True;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1170;4714.897,-772.7258;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1172;4452.577,-804.3515;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1049;5381.64,400.6321;Inherit;False;IridescentMainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;4082.013,-676.3953;Inherit;False;1144;SmoothnessColorMult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1175;4418.013,-707.3953;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1162;3713.449,-850.2751;Inherit;False;444;ToonSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1177;3737.299,-754.6938;Inherit;False;1134;RimAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1171;3942.885,-861.8574;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1179;4102.299,-795.6938;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1180;-3056.033,-1322.008;Inherit;False;Property;_BlendOPsrc;_BlendOPsrc;200;0;Create;True;0;0;0;True;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1181;-2884.033,-1321.008;Inherit;False;Property;_BlendOPdst;_BlendOPdst;202;0;Create;True;0;0;0;True;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1151;4245.475,-858.7676;Inherit;False;1147;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1176;5015.775,-989.7418;Inherit;False;Constant;_Float22;Float 22;49;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1046;3934.238,344.0829;Inherit;False;Property;_MaskClipValue;Mask Clip Value;307;0;Create;True;0;0;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;1045;3173.738,250.4829;Inherit;False;Property;_OutlineMaskingChannel;Outline Masking Channel;53;1;[Enum];Create;False;0;5;None;0;R;1;G;2;B;3;A;4;0;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;496;3392.317,690.8503;Inherit;False;Property;_ViewFudge;ViewFudge;52;0;Create;True;0;0;0;True;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;490;2224.805,337.181;Inherit;False;Property;_OutlineWidth;Outline Width;50;0;Create;False;0;0;0;True;0;False;1;20;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;826;2157.005,646.8827;Inherit;False;Property;_MaxOutlineWidth;Max Outline Width;51;0;Create;True;0;0;0;True;0;False;850;1000;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1183;5035.267,-264.119;Inherit;False;1147;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1185;3759.467,144.6142;Inherit;False;1147;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;486;3973.185,203.869;Inherit;False;2;False;Transparent;1;0;Front;True;True;True;True;0;False;;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1152;4949.605,-904.1158;Inherit;False;Property;_Keyword3;Keyword 3;203;0;Create;True;0;0;0;False;0;False;0;0;0;True;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1155;5226.195,-903.2067;Inherit;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1042;3327.138,80.1829;Inherit;False;EffectMaskChannel;-1;;4913;9aff8198f8f27794787d8759aa359a04;0;5;14;FLOAT;0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;18;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1186;3810.882,364.3489;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;497;2296.051,106.4058;Inherit;False;Property;_OutlineColor;Outline Color;54;0;Create;True;0;0;0;True;0;False;0,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1182;-2967.033,-1241.008;Inherit;False;Property;_BlendOPIndex;_BlendOPIndex;201;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1188;-3189.549,-1230.567;Inherit;False;Property;_BlendModeIndex;_BlendModeIndex;199;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1189;-3184.549,-1142.567;Inherit;False;Property;_EnableOutline;EnableOutline;198;1;[Toggle];Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1190;1636.223,1683.217;Inherit;False;Outline Glow;0;;4914;a95beee5cd09a3848994f1983d4ef324;0;2;229;FLOAT3;0,0,0;False;42;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;158;785.2396,421.767;Inherit;False;IndirectSpecular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;853;-24.64026,1740.427;Inherit;False;851;SpecularAntiAlias;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;851;1863.677,556.974;Inherit;False;SpecularAntiAlias;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;567;-239.0434,2075.365;Inherit;False;1191;specColor2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1720.645,-591.458;Inherit;False;specColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;381;-1868.959,-588.0468;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1191;-1711.13,-387.8441;Inherit;False;specColor2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;622;-231.1782,1347.674;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;204;310.205,469.0058;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;29.06121,326.3416;Inherit;False;90;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1145;-2345.992,-693.0366;Inherit;False;1144;SmoothnessColorMult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;-1744.155,-2986.72;Inherit;False;Constant;_Float23;Float 23;54;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;386;-2786.9,-2663.733;Inherit;True;Property;_OcclusionMap;OcclusionMap;44;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;1143;-1795.298,-2903.922;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.15;False;2;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;-3571.68,274.0615;Inherit;False;44;specColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1192;710.3632,615.0679;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1194;-2370.449,-3114.486;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.FaceVariableNode;1195;-2496.449,-3115.486;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1196;-2242.449,-3111.486;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1197;-2109.449,-3178.486;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1198;-1972.449,-3225.486;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;243;-1822.6,-3252.549;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;246;-2794.355,-3038.931;Inherit;True;Property;_MetallicGlossMap;Metallic;40;1;[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;1199;-8269.242,-1074.533;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1200;-2290.453,-2541.947;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1201;-2464.453,-2464.947;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1202;-5910.369,1571.476;Inherit;False;243;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;1203;-5744.238,1575.878;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CustomExpressionNode;1204;-5531.652,1566.237;Inherit;False;half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5)@ //('cubemap', 'sample coordinate', 'map-map level')$         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR)@$         return half4(skyColor, 1.0)@;3;Create;1;True;uvw;FLOAT3;0,0,0;In;;Inherit;False;ReflectionProbeSample;False;True;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1205;-5432.411,1644.196;Inherit;False;Constant;_Float24;Float 23;54;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1206;-5176.411,1389.196;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1207;4586.708,44.20444;Inherit;False;Applfy Effects;228;;4930;86ee36ff59e1113469676c1c5ac8dd3c;0;7;31;COLOR;0,0,0,0;False;15;FLOAT3;0,0,1;False;16;COLOR;0,0,1,0;False;2;COLOR;0,0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;23;FLOAT;0;False;3;FLOAT4;0;FLOAT4;38;FLOAT4;39
WireConnection;388;0;302;0
WireConnection;388;1;389;0
WireConnection;101;0;100;0
WireConnection;257;0;245;0
WireConnection;258;0;101;0
WireConnection;258;1;257;0
WireConnection;251;0;250;3
WireConnection;251;1;250;4
WireConnection;259;0;258;0
WireConnection;252;1;251;0
WireConnection;254;0;246;4
WireConnection;254;1;253;0
WireConnection;29;0;6;0
WireConnection;31;0;259;0
WireConnection;255;0;7;0
WireConnection;255;1;254;0
WireConnection;255;2;252;0
WireConnection;14;0;15;0
WireConnection;14;1;26;0
WireConnection;19;0;10;0
WireConnection;19;1;8;0
WireConnection;71;0;14;0
WireConnection;13;0;19;0
WireConnection;39;0;71;0
WireConnection;176;0;256;0
WireConnection;176;3;177;0
WireConnection;176;4;212;0
WireConnection;25;0;13;0
WireConnection;303;0;176;0
WireConnection;211;0;303;0
WireConnection;50;0;28;0
WireConnection;50;1;52;0
WireConnection;516;0;512;0
WireConnection;247;0;246;1
WireConnection;73;0;50;0
WireConnection;511;0;516;0
WireConnection;47;0;211;0
WireConnection;514;0;636;0
WireConnection;501;0;511;0
WireConnection;38;0;73;0
WireConnection;249;0;41;0
WireConnection;249;1;248;0
WireConnection;517;0;519;0
WireConnection;17;0;47;0
WireConnection;477;0;476;0
WireConnection;384;0;380;0
WireConnection;384;1;383;0
WireConnection;518;0;517;0
WireConnection;472;0;473;0
WireConnection;472;1;476;0
WireConnection;535;0;513;0
WireConnection;535;1;534;0
WireConnection;475;0;473;0
WireConnection;475;1;477;0
WireConnection;46;0;249;0
WireConnection;593;0;501;0
WireConnection;593;1;594;0
WireConnection;394;0;384;0
WireConnection;479;0;475;0
WireConnection;24;0;49;0
WireConnection;24;1;27;0
WireConnection;478;0;472;0
WireConnection;413;0;416;0
WireConnection;413;1;415;0
WireConnection;227;0;59;0
WireConnection;227;1;226;0
WireConnection;520;0;593;0
WireConnection;520;1;518;0
WireConnection;520;2;535;0
WireConnection;436;0;413;0
WireConnection;436;1;478;0
WireConnection;436;2;479;0
WireConnection;72;0;24;0
WireConnection;163;0;227;0
WireConnection;163;1;54;0
WireConnection;401;0;402;0
WireConnection;401;1;54;0
WireConnection;401;2;396;0
WireConnection;11;0;72;0
WireConnection;452;0;436;0
WireConnection;452;1;451;0
WireConnection;315;0;180;0
WireConnection;315;1;180;0
WireConnection;469;0;470;0
WireConnection;208;0;315;0
WireConnection;471;0;469;0
WireConnection;471;2;452;0
WireConnection;181;0;208;0
WireConnection;181;1;208;0
WireConnection;181;2;208;0
WireConnection;461;0;125;0
WireConnection;450;0;452;0
WireConnection;450;1;471;0
WireConnection;191;0;181;0
WireConnection;444;0;450;0
WireConnection;565;0;461;0
WireConnection;300;0;233;0
WireConnection;300;1;120;0
WireConnection;301;0;300;0
WireConnection;200;0;191;0
WireConnection;68;1;587;0
WireConnection;161;0;166;0
WireConnection;161;2;200;0
WireConnection;392;0;386;2
WireConnection;392;1;391;0
WireConnection;202;0;201;0
WireConnection;202;2;200;0
WireConnection;379;0;230;0
WireConnection;379;1;231;0
WireConnection;379;2;232;0
WireConnection;138;0;115;0
WireConnection;138;1;114;0
WireConnection;138;2;116;0
WireConnection;138;3;117;0
WireConnection;272;0;1200;0
WireConnection;23;0;163;0
WireConnection;544;0;537;0
WireConnection;544;1;543;0
WireConnection;480;0;161;0
WireConnection;123;0;1120;0
WireConnection;123;1;379;0
WireConnection;123;2;138;0
WireConnection;123;3;636;0
WireConnection;123;4;566;0
WireConnection;482;0;202;0
WireConnection;610;0;609;0
WireConnection;610;1;612;0
WireConnection;550;0;544;0
WireConnection;550;1;551;0
WireConnection;203;0;482;0
WireConnection;481;1;480;0
WireConnection;132;0;123;0
WireConnection;132;1;314;0
WireConnection;614;0;610;0
WireConnection;614;1;615;0
WireConnection;554;0;552;0
WireConnection;554;1;553;0
WireConnection;274;0;129;0
WireConnection;274;1;275;0
WireConnection;274;2;1160;0
WireConnection;311;0;306;0
WireConnection;311;1;514;0
WireConnection;312;0;132;0
WireConnection;312;1;460;0
WireConnection;312;2;623;0
WireConnection;613;0;614;0
WireConnection;213;0;214;0
WireConnection;213;1;215;0
WireConnection;213;2;203;0
WireConnection;162;0;481;0
WireConnection;548;0;550;0
WireConnection;529;0;824;0
WireConnection;529;1;524;0
WireConnection;555;0;554;0
WireConnection;555;1;556;0
WireConnection;128;0;274;0
WireConnection;128;1;312;0
WireConnection;151;0;153;0
WireConnection;151;1;152;0
WireConnection;151;2;276;0
WireConnection;310;0;522;0
WireConnection;310;1;311;0
WireConnection;547;12;548;0
WireConnection;547;9;549;0
WireConnection;625;1;626;0
WireConnection;625;0;613;0
WireConnection;545;0;619;0
WireConnection;545;1;547;0
WireConnection;545;2;555;0
WireConnection;545;3;558;0
WireConnection;545;4;567;0
WireConnection;545;5;625;0
WireConnection;165;0;151;0
WireConnection;165;1;204;0
WireConnection;165;2;1192;0
WireConnection;532;0;824;0
WireConnection;532;1;529;0
WireConnection;190;0;128;0
WireConnection;190;1;310;0
WireConnection;219;0;190;0
WireConnection;557;0;545;0
WireConnection;265;1;862;0
WireConnection;175;0;156;0
WireConnection;30;0;47;0
WireConnection;30;1;47;0
WireConnection;599;0;604;0
WireConnection;595;0;542;0
WireConnection;75;0;40;0
WireConnection;174;0;175;0
WireConnection;266;0;267;0
WireConnection;266;1;265;0
WireConnection;266;2;984;0
WireConnection;621;0;622;0
WireConnection;607;0;598;0
WireConnection;33;0;18;0
WireConnection;33;1;48;0
WireConnection;362;0;101;0
WireConnection;42;0;74;0
WireConnection;22;0;30;0
WireConnection;598;0;597;0
WireConnection;598;1;596;0
WireConnection;74;0;33;0
WireConnection;600;0;599;0
WireConnection;284;0;227;0
WireConnection;604;0;607;0
WireConnection;604;1;605;0
WireConnection;40;0;37;0
WireConnection;40;1;36;0
WireConnection;169;0;159;0
WireConnection;169;1;221;0
WireConnection;169;2;1207;0
WireConnection;169;3;1119;0
WireConnection;56;0;75;0
WireConnection;45;0;590;0
WireConnection;634;0;460;0
WireConnection;636;0;634;0
WireConnection;636;1;460;0
WireConnection;636;2;635;4
WireConnection;569;0;568;1
WireConnection;570;0;569;0
WireConnection;570;1;569;1
WireConnection;571;0;570;0
WireConnection;571;1;569;2
WireConnection;572;0;571;0
WireConnection;573;0;572;0
WireConnection;575;1;574;0
WireConnection;575;0;1199;0
WireConnection;592;0;583;0
WireConnection;576;0;577;0
WireConnection;576;1;575;0
WireConnection;584;0;592;0
WireConnection;584;1;582;0
WireConnection;584;2;575;0
WireConnection;32;0;584;0
WireConnection;578;0;588;0
WireConnection;578;1;632;0
WireConnection;578;2;575;0
WireConnection;581;0;578;0
WireConnection;581;1;533;0
WireConnection;589;0;581;0
WireConnection;580;1;630;0
WireConnection;580;2;575;0
WireConnection;533;0;580;0
WireConnection;630;0;628;0
WireConnection;630;1;627;0
WireConnection;630;2;629;4
WireConnection;628;0;627;0
WireConnection;790;0;1190;0
WireConnection;798;0;1074;183
WireConnection;798;1;1074;0
WireConnection;791;0;798;0
WireConnection;819;0;490;0
WireConnection;819;1;818;0
WireConnection;824;1;819;0
WireConnection;824;2;823;0
WireConnection;822;0;490;0
WireConnection;823;0;490;0
WireConnection;828;0;826;0
WireConnection;828;1;818;0
WireConnection;829;1;828;0
WireConnection;829;2;831;0
WireConnection;830;0;826;0
WireConnection;831;0;826;0
WireConnection;498;0;484;0
WireConnection;498;1;484;0
WireConnection;862;0;268;0
WireConnection;862;1;859;0
WireConnection;859;0;860;0
WireConnection;859;1;864;0
WireConnection;859;2;861;0
WireConnection;864;0;858;0
WireConnection;864;1;863;0
WireConnection;906;0;907;0
WireConnection;906;1;910;0
WireConnection;906;2;908;0
WireConnection;910;0;905;0
WireConnection;910;1;909;0
WireConnection;912;0;911;0
WireConnection;912;1;906;0
WireConnection;871;0;913;0
WireConnection;984;14;866;1
WireConnection;984;15;866;2
WireConnection;984;16;866;3
WireConnection;984;17;866;4
WireConnection;984;18;868;0
WireConnection;1031;0;1074;244
WireConnection;788;0;497;0
WireConnection;1044;0;1043;0
WireConnection;495;0;493;0
WireConnection;495;1;496;0
WireConnection;489;0;1061;0
WireConnection;489;1;832;0
WireConnection;489;2;1042;0
WireConnection;832;0;532;0
WireConnection;832;1;829;0
WireConnection;493;0;491;0
WireConnection;494;0;489;0
WireConnection;494;1;495;0
WireConnection;1059;0;488;0
WireConnection;1060;0;494;0
WireConnection;786;0;1062;0
WireConnection;380;1;393;0
WireConnection;223;1;225;0
WireConnection;241;1;242;0
WireConnection;241;5;388;0
WireConnection;866;1;912;0
WireConnection;1074;1;787;0
WireConnection;1062;0;266;0
WireConnection;460;0;124;0
WireConnection;1029;0;1141;0
WireConnection;1118;0;1207;39
WireConnection;121;0;301;0
WireConnection;121;1;445;0
WireConnection;987;0;121;0
WireConnection;1117;0;1207;38
WireConnection;1132;0;413;0
WireConnection;617;0;616;0
WireConnection;617;1;618;0
WireConnection;619;0;617;0
WireConnection;1134;0;547;0
WireConnection;1141;214;1133;0
WireConnection;1141;215;1135;0
WireConnection;1141;207;1127;0
WireConnection;1141;165;1095;0
WireConnection;1141;84;1048;0
WireConnection;1141;21;1011;0
WireConnection;1141;44;1027;0
WireConnection;1141;56;983;0
WireConnection;1142;1;852;0
WireConnection;90;0;255;0
WireConnection;1144;0;1143;0
WireConnection;1146;0;381;0
WireConnection;1146;1;1145;0
WireConnection;224;0;223;0
WireConnection;1149;0;1150;3
WireConnection;1149;1;59;4
WireConnection;1150;0;1148;0
WireConnection;1147;0;1149;0
WireConnection;0;0;378;0
WireConnection;0;2;793;0
WireConnection;0;9;1170;0
WireConnection;0;13;169;0
WireConnection;0;11;486;0
WireConnection;521;0;1206;0
WireConnection;1165;0;162;0
WireConnection;1168;0;848;0
WireConnection;1168;1;1169;0
WireConnection;850;0;1168;0
WireConnection;848;0;847;0
WireConnection;1170;0;1172;0
WireConnection;1170;1;1175;0
WireConnection;1172;0;1151;0
WireConnection;1049;0;1141;93
WireConnection;1175;0;1179;0
WireConnection;1175;1;1174;0
WireConnection;1171;0;1162;0
WireConnection;1179;0;1171;0
WireConnection;1179;1;1177;0
WireConnection;486;0;792;0
WireConnection;486;2;1186;0
WireConnection;486;1;1060;0
WireConnection;1152;1;1154;0
WireConnection;1152;0;1170;0
WireConnection;1155;0;1152;0
WireConnection;1042;14;1044;0
WireConnection;1042;15;1044;1
WireConnection;1042;16;1044;2
WireConnection;1042;17;1044;3
WireConnection;1042;18;1045;0
WireConnection;1186;0;1042;0
WireConnection;1186;1;497;4
WireConnection;1190;229;789;0
WireConnection;1190;42;1074;244
WireConnection;158;0;165;0
WireConnection;851;0;850;0
WireConnection;44;0;1146;0
WireConnection;381;0;395;0
WireConnection;381;1;163;1
WireConnection;381;2;401;0
WireConnection;1191;0;381;0
WireConnection;622;0;617;0
WireConnection;204;0;1165;0
WireConnection;204;1;213;0
WireConnection;204;2;205;0
WireConnection;386;1;385;0
WireConnection;1143;0;255;0
WireConnection;1192;0;498;0
WireConnection;1192;1;215;0
WireConnection;1192;2;205;0
WireConnection;1194;0;1195;0
WireConnection;1196;0;1194;0
WireConnection;1197;0;241;3
WireConnection;1197;1;1196;0
WireConnection;1198;0;241;0
WireConnection;1198;2;1197;0
WireConnection;243;0;1198;0
WireConnection;246;1;269;0
WireConnection;1199;0;571;0
WireConnection;1200;0;386;2
WireConnection;1200;3;1201;0
WireConnection;1201;0;391;0
WireConnection;1203;0;1202;0
WireConnection;1204;0;1203;0
WireConnection;1206;0;520;0
WireConnection;1206;1;1204;0
WireConnection;1206;2;1205;0
WireConnection;1207;2;983;0
WireConnection;1207;3;988;0
WireConnection;1207;4;986;0
WireConnection;1207;23;1032;0
ASEEND*/
//CHKSM=BEC27FA0CB04563425CFD43760DF646C85407809