Shader "Hidden/Moriohs Shaders/Moris Toon Shader/Toon/02ef05d0a7dadfd4b9afa7beed0abdf2"
{
    Properties
    {
        [ShaderOptimizerLockButton]_ShaderOptimizerEnabled("PLEASE IMPORT KAJSHADEROPTIMIZER SCRIPT WITHIN ITS EDITOR FOLDER", Int) = 0
        //[ShaderVersion]Version("", int) = 0 //For Kajs Shader Editor
        [Enum(Basic,0,Advanced,1,Advanced Plus,2)]_AdvancedExperimentalToggle("Advanced Experimental Toggle", Float) = 0
        //[PresetsEnum] _Mode ("Rendering Mode;Opaque,RenderQueue=-1,RenderType=,_BlendOp=0,_BlendOpAlpha=0,_SrcBlend=1,_DstBlend=0,_SrcBlendAlpha=1,_DstBlendAlpha=0,_AlphaToMask=0,_ZWrite=1,_ZTest=4;Cutout,RenderQueue=2450,RenderType=TransparentCutout,_BlendOp=0,_BlendOpAlpha=0,_SrcBlend=1,_DstBlend=0,_SrcBlendAlpha=1,_DstBlendAlpha=0,_AlphaToMask=0,_ZWrite=1,_ZTest=4;Fade,RenderQueue=3000,RenderType=Transparent,_BlendOp=0,_BlendOpAlpha=0,_SrcBlend=5,_DstBlend=10,_SrcBlendAlpha=5,_DstBlendAlpha=10,_AlphaToMask=0,_ZWrite=0,_ZTest=4;Transparent,RenderQueue=3000,RenderType=Transparent,_BlendOp=0,_BlendOpAlpha=0,_SrcBlend=1,_DstBlend=10,_SrcBlendAlpha=1,_DstBlendAlpha=10,_AlphaToMask=0,_ZWrite=0,_ZTest=4", Int) = 0 //For Kajs Shader Editor
        [Enum(Opaque,0,Cutout,1,Fade,2,Transparent,3)]_Mode("Mode", Int) = 0
        [ToggleUI]_ModeCustom("Mode Custom", Int) = 0
        //Main Settings
        [HideInInspector]_Dummy("_Dummy", Float) = 0 //Do not remove! for custom inspector
        //[HideInInspector]group_MainSettings("Main Settings", Int) = 0
        [ToggleUI]_COLORCOLOR("Toggle Advanced", Int) = 0
            [HideInInspector]_Cutoff("Cutoff", Range( 0 , 1)) = 0
            [HideInInspector]_Color("Color", Color) = (1,1,1,1)
            [ToggleUI]_BC7compressionFix("BC7 Compression Fix", Int) = 1
            _MainTex("Main Tex", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_MainTexUVSwitch("Main Tex UV Switch", Int) = 0
            _Saturation("Saturation", Range( 0 , 10)) = 1
            _HueShiftSpeed("Hue Shift Speed", Range( 0 , 255)) = 0
            [Enum(Off,0,On,1)]_ToggleHueTexforSpeed("Toggle Hue Tex for Speed", Float) = 0
            _HueShiftRandomizer("Hue Shift Randomizer", Range( 0 , 1)) = 0
            [ToggleUI]_HueMaskinverter("Hue Mask inverter", Int) = 0
            _HueShiftblend("Hue Shift blend", Range( 0 , 1)) = 0.5
            _HueMask("HueMask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_HueMaskUVSwitch("HueMask UV Switch", Int) = 0
        //[HideInInspector][ToggleUI]group_toggle_BRDF("Unity BRDF", Int) = 0
            [ToggleUI]_GlossyReflections("Toggle Glossy Reflections", Int) = 0
            [ToggleUI]_ToggleDisneyDiffuse("Toggle Disney Diffuse Term", Int) = 0
            [ToggleUI]_IgnoreNormalsCubemap("Ignore Normals Cubemap", Int) = 0
            [ToggleUI]_SpecularHighlights("Cubemap Specular Toggle", Float) = 1
            [Enum(Dynamic,0,Baked Cubemap only,1,Unitys Metallic Workflow,2)]_WorkflowSwitch("Workflow Switch", Int) = 0
            _Metallic("Metallic", Range( 0 , 1)) = 0.5 //we do not do [Gamma] here cause the optimizer will kill it, so we compute it in Shader
            _Glossiness("Cubemap smoothness", Range( 0 , 1)) = 0.75
            _GlossMapScale("_GlossMapScaleForStandardShader", Range( 0 , 1)) = 0.75
            [ToggleUI]_BRDFReflInheritAniso ("Inherit Anisotropy", Int) = 0
            [HideInInspector]_MetallicGlossMap("MetallicGlossMap", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_MetallicGlossMapUVSwitch ("UV Set", Int) = 0
            _ReflectionMask("Reflection Mask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_ReflectionMaskUVSwitch("Reflection Mask UV Switch", Int) = 0
            //[ToggleUI]_ReflectionMaskInvert ("Invert Reflection Mask", Int) = 0
            [WideEnum(R,0,G,1,B,2,A,3,1 minus R,4,1 minus G,5,1 minus B,6,1 minus A,7)]_ReflectionMaskTexChannelSwitch("Reflection Mask Channel Switch", Int) = 0
            [HDR]_Cubemap("Cubemap", CUBE) = "white" {}
            [ToggleUI]_EnableGSAA("Enable GSAA", Int) = 1
            _GSAAVariance("GSAAVariance", Range( 0 , 1)) = 0.15
            _GSAAThreshold("GSAAThreshold", Range( 0 , 1)) = 0.1
            _CubemapIntensity("Cubemap Intensity", Range( 0 , 1)) = 1
        //[HideInInspector]end_BRDF("", Int) = 0
        //[HideInInspector]group_Toon("Toon shenaniganz", Int) = 0
            [Enum(Off,0,On,1)]_ToggleSteps("Toggle Steps", Int) = 0
            [IntRange]_Steps("Steps", Range(2, 32)) = 3
            _ShadowMask("Shadow Mask", 2D) = "white" {}
            _ShadowMaskStrength("Shadow Mask Strength", Range( 0 , 1)) = 1
            //[ToggleUI]_ShadowMaskinvert("Shadow Mask invert", Int) = 0
            [WideEnum(RR,0,RG,1,RB,2,RA,3,GR,4,GG,5,GB,6,GA,7,BR,8,BG,9,BB,10,BA,11,AR,12,AG,13,AB,14,AA,15,1  minus RR,16,1  minus RG,17,1  minus RB,18,1  minus RA,19,1  minus GR,20,1  minus GG,21,1  minus GB,22,1  minus GA,23,1  minus BR,24,1  minus BG,25,1  minus BB,26,1  minus BA,27,1  minus AR,28,1  minus AG,29,1  minus AB,30,1  minus AA,31)]_ShadowMaskTexChannelSwitch("Shadow Mask Channel Switch", Int) = 1
            _OcclusionMap("Occlusion Map", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_OcclusionMapUVSwitch ("UV Set", Int) = 0
            [HideInInspector]_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
            _ToonRamp("Toon Ramp", 2D) = "white" {}
            _RampOffset("RampOffset", Range( 0 , 1)) = 0.5
            _NdLHalfingControl("NdL Halfing Control", Range( 0.5 , 5)) = 0.5
            _RampColor("Ramp Color", Color) = (0.8588235,0.7647059,0.7098039,0)
            _ShadowColorMap("Shadow Color Map", 2D) = "black" {}
            _ShadowColorMapStrength("Shadow Color Map Strength", Range( 0 , 1)) = 1
            _ColoringPointLights("Coloring Point Lights", Range( 0 , 1)) = 0
            _ColoringDirectEnvLights("Coloring Direct Env Lights", Range( 0 , 1)) = 0
            _DirectShadowIntensity("Direct Shadow Intensity", Range( 0 , 1)) = 1
            _SelfCastShadows("SelfCastShadows", Range( 0 , 1)) = 1
            _PointSpotShadowIntensity("PointSpot Shadow Intensity", Range( 0 , 1)) = 1
            [Enum(Off,0,On,1)]_LightLimiter("Experimental Toggle", Int) = 1
            _MaxLightDirect("Max Light Direct", Range( 0 , 1)) = 1
            _AmbientBoost("Ambient Boost", Range( 1 , 2)) = 1.5
            _IndirectShadowIntensity("Indirect Shadow Intensity", Range( 0 , 1)) = 0.5
            [ToggleUI]_ToggleMonochromePixelLight("Toggle Monochrome Pixel Light", Int) = 0
            [ToggleUI]_ToggleMonochromeEnv("Toggle Monochrome Env", Int) = 0
            [moriohVec3Float]_DistanceFade("Distance Fade", Vector) = (0.115, 0.01, 0, 1)
        //[HideInInspector]end_Toon("", Int) = 0
        //[HideInInspector]end_MainSettings("", Int) = 1 //1 = extend by default
        
        //Rimlight
        //[HideInInspector]group_RimLight("Rim Light", Int) = 0
            [ToggleUI]_RimToggle("Rim Toggle", Int) = 0
            _RimMask("Rim Mask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_RimMaskUVSwitch("Rim Mask UV Switch", Int) = 0
            [WideEnum(R,0,G,1,B,2,A,3,1 minus R,4,1 minus G,5,1 minus B,6,1 minus A,7)]_RimMaskTexChannelSwitch("Rim Mask Channel Switch", Int) = 1
            [Enum(Custom Fresnel,0,Fresnel,1)]_RimDirectionToggle("Rim Direction Toggle", Int) = 0
            //[ToggleUI]_RimLightMaskinv("RimLightMaskinv", Int) = 0
            _RimFresnelBias("Rim Fresnel Bias", Range( 0 , 1)) = 0
            _RimFresnelScale("Rim Fresnel Scale", Range( 0 , 10)) = 1
            _RimFresnelPower("Rim Fresnel Power", Range( 0 , 20)) = 5
            _RimOffset("Rim Offset", Range( 0 , 1)) = 0
            _RimPower("Rim Power", Range( 0 , 10)) = 5
            _RimSpecLightsmoothness("Rim Spec Light smoothness", Range( 0 , 1)) = 0
            [Enum(Off,0,On,1)]_RimSpecToggle("Rim Spec Toggle", Int) = 0
            [ToggleUI]_RimLightReflInheritAniso ("RimLight Refl Inherit Aniso", Int) = 0
            _RimTint("Rim Tint", Range( 0 , 1)) = 0.75
            _RimOpacity("Rim Opacity", Range( 0 , 1)) = 0.25
            [Enum(Off,0,Front,1,Back,2)]_RimFaceCulling("Rim Face Culling", Int) = 0
            [HDR]_RimColor("Rim Color", Color) = (1,1,1,0)
        //[HideInInspector]end_RimLight("", Int) = 0
        
        //Basic Emission
        //[HideInInspector]group_BasicEmission("Basic Emission", Int) = 0
            _EmissionMap("Emission", 2D) = "black" {} //EmissionColor set to 0 in v.2.1, EmissionMap eventually needs to be set to white
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_EmissionMapUVSwitch("Emission UV Switch", Int) = 0
            _EmissionTint("Emission Tint", Range( 0 , 1)) = 1
            [ToggleUI]_EmissionLightscale("Emission Lightscale", Float) = 0
            [HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
        //[HideInInspector]end_BasicEmission("", Int) = 0
        
        //Normal Maps
        //[HideInInspector]group_NormalMaps("Normal Maps", Int) = 0
            [Normal]_BumpMap("Normal Map", 2D) = "bump" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_BumpMapUVSwitch ("UV Set", Int) = 0
            _BumpScale ("Normal Map Scale", Range(-2, 2)) = 0
            [Normal]_DetailNormalMap("Detailed Normal Map", 2D) = "bump" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_DetailNormalMapUVSwitch ("UV Set", Int) = 0
            _DetailNormalMapScale ("Detailed Normal Map Scale", Range(-2, 2)) = 0
            _DetailMask ("Normal Map Mask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_DetailMaskUVSwitch ("UV Set", Int) = 0
            [WideEnum(RR,0,RG,1,RB,2,RA,3,GR,4,GG,5,GB,6,GA,7,BR,8,BG,9,BB,10,BA,11,AR,12,AG,13,AB,14,AA,15,1  minus RR,16,1  minus RG,17,1  minus RB,18,1  minus RA,19,1  minus GR,20,1  minus GG,21,1  minus GB,22,1  minus GA,23,1  minus BR,24,1  minus BG,25,1  minus BB,26,1  minus BA,27,1  minus AR,28,1  minus AG,29,1  minus AB,30,1  minus AA,31)]_DetailMaskTexChannelSwitch("Detail Mask Channel Switch", Int) = 7
        //[HideInInspector]end_NormalMaps("", Int) = 0
        
        //Matcap
        //[HideInInspector]group_Matcap("Matcap", Int) = 0
            //R1
            [HideInInspector]group_MatcapR1("Matcap R1", Int) = 0
                [ToggleUI]_MatcapR1Toggle("MatcapR1Toggle", Int) = 0
                [ToggleUI]_IgnoreNormalsMatcap("Ignore Normals Matcap", Int) = 0
                [Enum(View Dir Singularity,0,View Dir to Object Center,1)]_MatcapViewDir("MatcapViewDir", Int) = 0
                _MatcapR1Color("MatcapR1Color", Color) = (1,1,1,1)
                _MatcapR1("MatcapR1", 2D) = "white" {}
                [Enum(Multiply,0,Add,1,Subtract,2)]_MatcapR1Mode("MatcapR1Mode", Int) = 0
                _MatcapR1Blending("MatcapR1Blending", Range( 0 , 1)) = 1
                _MatcapR1Intensity ("Matcap Intensity", Range(0, 5)) = 1
                _MatcapR1smoothness("MatcapR1smoothness", Range( 0 , 1)) = 1
                _MatcapR1Tint ("Matcap Tint (Add)", Range(0, 1)) = 0
                [ToggleUI]_MatcapR1MaskInvert("Reflection Mask Inverter", Int) = 0
            //[HideInInspector]end_MatcapR1("", Int) = 0
            //G2
            //[HideInInspector]group_MatcapG2("Matcap G2", Int) = 0
                [ToggleUI]_MatcapG2Toggle("MatcapG2Toggle", Int) = 0
                //[ToggleUI]_IgnoreNormalsMatcap("Ignore Normals Matcap", Float) = 0
                _MatcapG2Color("MatcapG2Color", Color) = (1,1,1,1)
                _MatcapG2("MatcapG2", 2D) = "white" {}
                [Enum(Multiply,0,Add,1,Subtract,2)]_MatcapG2Mode("MatcapG2Mode", Int) = 0
                _MatcapG2Blending("MatcapG2Blending", Range( 0 , 1)) = 1
                _MatcapG2Intensity ("Matcap Intensity", Range(0, 5)) = 1
                _MatcapG2smoothness("MatcapG2smoothness", Range( 0 , 1)) = 1
                _MatcapG2Tint ("Matcap Tint (Add)", Range(0, 1)) = 0
                [ToggleUI]_MatcapG2MaskInvert("Reflection Mask Inverter", Int) = 0
            //[HideInInspector]end_MatcapG2("", Int) = 0
            //B3
            //[HideInInspector]group_MatcapB3("Matcap B3", Int) = 0
                [ToggleUI]_MatcapB3Toggle("MatcapB3Toggle", Int) = 0
                //[ToggleUI]_IgnoreNormalsMatcap("Ignore Normals Matcap", Float) = 0
                _MatcapB3Color("MatcapB3Color", Color) = (1,1,1,1)
                _MatcapB3("MatcapB3", 2D) = "white" {}
                [Enum(Multiply,0,Add,1,Subtract,2)]_MatcapB3Mode("MatcapB3Mode", Int) = 0
                _MatcapB3Blending("MatcapB3Blending", Range( 0 , 1)) = 1
                _MatcapB3Intensity ("Matcap Intensity", Range(0, 5)) = 1
                _MatcapB3smoothness("MatcapB3smoothness", Range( 0 , 1)) = 1
                _MatcapB3Tint ("Matcap Tint (Add)", Range(0, 1)) = 0
                [ToggleUI]_MatcapB3MaskInvert("Reflection Mask Inverter", Int) = 0
            //[HideInInspector]end_MatcapB3("", Int) = 0
            //A4
            //[HideInInspector]group_MatcapA4("Matcap A4", Int) = 0
                [ToggleUI]_MatcapA4Toggle("MatcapA4Toggle", Int) = 0
                //[ToggleUI]_IgnoreNormalsMatcap("Ignore Normals Matcap", Float) = 0
                _MatcapA4Color("MatcapA4Color", Color) = (1,1,1,1)
                _MatcapA4("MatcapA4", 2D) = "white" {}
                [Enum(Multiply,0,Add,1,Subtract,2)]_MatcapA4Mode("MatcapA4Mode", Int) = 0
                _MatcapA4Blending("MatcapA4Blending", Range( 0 , 1)) = 1
                _MatcapA4Intensity ("Matcap Intensity", Range(0, 5)) = 1
                _MatcapA4smoothness("MatcapA4smoothness", Range( 0 , 1)) = 1
                _MatcapA4Tint ("Matcap Tint (Add)", Range(0, 1)) = 0
                [ToggleUI]_MatcapA4MaskInvert("Reflection Mask Inverter", Int) = 0
            //[HideInInspector]end_MatcapA4("", Int) = 0
        _MatcapMask ("Matcap Mask RGBA", 2D) = "white" {}
        [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_MatcapMaskUVSwitch ("UV Set", Int) = 0
        //[HideInInspector]end_Matcap("", Int) = 0
        
        //Specular
        //[HideInInspector]group_Specular("Specular Highlights", Int) = 0
            //[HideInInspector][ToggleUI]group_toggle_SpecularAniso("GGX Aniso", Int) = 0
                [ToggleUI]_SpecularToggle("Specular Toggle", Int) = 0
                _SpecularMap("Specular Map", 2D) = "white" {}
                [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_SpecularMapUVSwitch("Specular Map UV Switch", Int) = 0
                _Anisotropy("Anisotropy", Range( -1 , 1)) = 0.8
                [ToggleUI]_AnisoFlickerFix("Aniso Flicker Fix", Int) = 0
                _AnisoFlickerFixOffset("Aniso Flicker Fix Offset", Range( 0 , 0.3)) = 0.2
                //[ToggleUI]_EnableGSAA("Enable GSAA", Float) = 1
                //_GSAAVariance("GSAAVariance", Range( 0 , 1)) = 0.15
                //_GSAAThreshold("GSAAThreshold", Range( 0 , 1)) = 0.1
        
                [Enum(Off,0,Standard NdotL,1,Toon Ramp,2)]_SpecShadowMaskVar("Spec Shadow Mask Var", Int) = 2
                _SpecShadowMaskPower("Spec Shadow Mask Power", Range( -1 , 1)) = 0
                _SpecularTint("Specular Tint", Range( 0 , 1)) = 1
        
                _AnisoDir("AnisoDir", 2D) = "bump" {}
                [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_AnisoDirUVSwitch("AnisoDir UV Switch", Int) = 0
                [HDR]_SpecularColor("Specular Color", Color) = (0.03921569,0.03921569,0.03921569,1)
                _HighlightSmoothness("Highlight Smoothness", Range( 0 , 1)) = 0
                _HighlightOffset("Highlight Offset", Range( -1 , 1)) = 0
                _AnisoScale("Aniso Scale", Range( 0 , 1)) = 1
                [ToggleUI]_AnisoSharpening("Aniso Sharpening", Int) = 0
                _BlinntoAniso("Blinn to Aniso", Range( 0 , 1)) = 0
                [Enum(Toon,0,Unity Standard GGX,1,Anisotropic by James OHare,2,Anisotropic GGX,3)]_SpecularSetting("Specular Setting", Int) = 0
            //[HideInInspector]end_SpecularAniso("", Int) = 0
        //[HideInInspector]end_Specular("", Int) = 0
        
        //SSS
        //[HideInInspector][ToggleUI]group_toggle_SSS("Subsurface Scattering", Int) = 0
            [ToggleUI]_SSSToggle("SSS Toggle", Int) = 0
            [Enum(Light Based,0,Color Based,1,Mixed,2)]_SSSSetting("SSS Setting", Int) = 0
            [HDR]_SSSColor("SSS Color", Color) = (0.9997016,1,0.7028302,0)
            _SSSScale("SSS Scale", Float) = 1
            _SSSTint("SSS Tint", Range( 0 , 1)) = 1
            _SubsurfaceDistortionModifier("Subsurface Distortion Modifier", Float) = 1
            _SSSPower("SSS Power", Float) = 2.5
            [Enum(Color Data,0,Modification Data,1)]_SSSMapMode("SSS Map Mode", Int) = 0
            [ToggleUI]_SSSThicknessinv("SSSThicknessinv", Int) = 0
            _SSSThicknessMap("SSS Thickness Map", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_SSSThicknessMapUVSwitch("SSS Thickness Map UV Switch", Int) = 0
        //[HideInInspector]end_SSS("", Int) = 0
        
        //Shadow/Emissive Rim
        //[HideInInspector]group_ShadowEmissiveRim("Shadow/Emissive Rim", Int) = 0
            [Enum(Shadow,0,Emissive,1)]_RimSwitch("Rim Switch", Int) = 0
            _ShadowRimRange("ShadowRimRange", Range( 0 , 1)) = 0.75
            _ShadowRimSharpness("ShadowRimSharpness", Range( 0 , 1)) = 1
            _ShadowRimOpacity("ShadowRimOpacity", Range( 0 , 1)) = 0
            _RimHueSpeed("Rim Hue Speed", Range( 0 , 1)) = 0
            _EmissiveRimColor("Emissive Rim Color", Color) = (1,1,1,0)
        //[HideInInspector]end_ShadowEmissiveRim("", Int) = 0

        //LTCGI
        //[HideInInspector]group_LTCGI("LTCGI", Int) = 0
            [Toggle(LTCGI)]_LTCGI("Toggle LTCGI", Int) = 0
            [ToggleUI]_ToggleLTCGIDiffuse("Toggle LTCGI Diffuse", Int) = 1
            [ToggleUI]_ToggleLTCGISpecular("Toggle LTCGI Specular", Int) = 1
            [HelpBox(1)]_LTCGInotInstalledTooltip("_LTCGInotInstalledTooltip", Int) = 0
        //[HideInInspector]end_LTCGI("", Int) = 0
        
        //Flipbook
        //[HideInInspector]group_Flipbook("Flipbook", Int) = 0
            [ToggleUI]_FlipbookToggle("Flipbook Toggle", Int) = 0
            _Flipbook("Flipbook", 2D) = "black" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_FlipbookUVSwitch ("UV Set", Int) = 0
            [Enum(Multiply,0,Add,1,Emissive,2)]_FlipbookMode("Flipbook Mode", Int) = 0
            _RotateFlipbook("Rotate Flipbook", Range( -1 , 1)) = 0
            [ToggleUI]_FlipbookAudioLinkToggle("Flipbook AudioLink Toggle", Int) = 0
            _Columns("Columns", Int) = 0
            _Rows("Rows", Int) = 0
            _MaxFrames("Max Frames", Int) = 1
            _Speed("Speed", Int) = 6
            _FlipbookTint("Flipbook Tint", Range( 0 , 1)) = 0
            [IntRange]_FlipbookUVShift("Flipbook UV Shift", Range(0, 16)) = 0
            [HDR]_FlipbookColor("FlipbookColor", Color) = (1,1,1,1)
        //[HideInInspector]end_Flipbook("", Int) = 0
        
        //Decal
        //[HideInInspector]group_Decal("Decal", Int) = 0
            [ToggleUI]_DecalToggle("Decals Toggle", Int) = 0
            _Decal1("_Decal1", 2D) = "black" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_Decal1UVSwitch ("UV Set", Int) = 0
            [Enum(Repeat,0,Clamp,1)]_Decal1WrapMode ("Wrap Mode", Int) = 1
            [Enum(Multiply,0,Add,1,Emissive,2)]_Decal1Mode("_Decal1 Mode", Int) = 0
            _RotateDecal1("Decal1 Rotate", Range( -1 , 1)) = 0
            [ToggleUI]_Decal1AudioLinkToggle("Decal 1 AudioLink Toggle", Int) = 0
            _Decal1Tint("Decal1 Tint", Range( 0 , 1)) = 0
            [HDR]_Decal1Color("Decal1 Color", Color) = (1,1,1,1)
            _Decal2("_Decal2", 2D) = "black" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_Decal2UVSwitch ("UV Set", Int) = 0
            [Enum(Repeat,0,Clamp,1)]_Decal2WrapMode ("Wrap Mode", Int) = 1
            [Enum(Multiply,0,Add,1,Emissive,2)]_Decal2Mode("_Decal2 Mode", Int) = 0
            _RotateDecal2("Decal2 Rotate", Range( -1 , 1)) = 0
            [ToggleUI]_Decal2AudioLinkToggle("Decal 2 AudioLink Toggle", Int) = 0
            _Decal2Tint("Decal2 Tint", Range( 0 , 1)) = 0
            [HDR]_Decal2Color("Decal2 Color", Color) = (1,1,1,1)
            _Decal3("_Decal3", 2D) = "black" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_Decal3UVSwitch ("UV Set", Int) = 0
            [Enum(Repeat,0,Clamp,1)]_Decal3WrapMode ("Wrap Mode", Int) = 1
            [Enum(Multiply,0,Add,1,Emissive,2)]_Decal3Mode("_Decal3 Mode", Int) = 0
            _RotateDecal3("Decal3 Rotate", Range( -1 , 1)) = 0
            [ToggleUI]_Decal3AudioLinkToggle("Decal 3 AudioLink Toggle", Int) = 0
            _Decal3Tint("Decal3 Tint", Range( 0 , 1)) = 0
            [HDR]_Decal3Color("Decal3 Color", Color) = (1,1,1,1)
            _Decal4("_Decal4", 2D) = "black" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_Decal4UVSwitch ("UV Set", Int) = 0
            [Enum(Repeat,0,Clamp,1)]_Decal4WrapMode ("Wrap Mode", Int) = 1
            [Enum(Multiply,0,Add,1,Emissive,2)]_Decal4Mode("_Decal4 Mode", Int) = 0
            _RotateDecal4("Decal4 Rotate", Range( -1 , 1)) = 0
            [ToggleUI]_Decal4AudioLinkToggle("Decal 4 AudioLink Toggle", Int) = 0
            _Decal4Tint("Decal4 Tint", Range( 0 , 1)) = 0
            [HDR]_Decal4Color("Decal4 Color", Color) = (1,1,1,1)
            [IntRange]_DecalUVShift("Decal UV Shift", Range(0, 16)) = 0
            _DecalMask("_DecalMask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_DecalMaskUVSwitch ("UV Set", Int) = 0
        //[HideInInspector]end_Decal("", Int) = 0
        
        //Dither
        //[HideInInspector]group_Dither("Dither", Int) = 0
            _DitherMask("Dither Mask", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_DitherMaskUVSwitch("Dither Mask UV Switch", Float) = 0
            _DitherTexture("Dither Texture", 2D) = "white" {}
            [Enum(Object Center to Camera Distance,0,Diffuse Alpha,1)]_DitherAlphaToggle("DitherAlphaToggle", Float) = 0
            [Enum(Off,0,On,1)]_DitherTextureToggle("DitherTextureToggle", Float) = 0
            _StartDitheringFade("Start Dithering Fade", Range( 0 , 20)) = 0
            _EndDitheringFade("End Dithering Fade", Range( 0 , 20)) = 0
            _DitherTextureTiling("Dither Texture Tiling", Float) = 1
        //[HideInInspector]end_Dither("", Int) = 0
        
        //EmissionScrollV1
        //[HideInInspector]group_ESV1("ESV1", Int) = 0
            //[Enum(Off,0,ES v1,1,ES v2,2)]_EmissionScrollToggle("Emission Scroll Toggle", Float) = 0
            _NoiseTexture("Noise Texture", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_NoiseTextureUVSwitch("Noise Texture UV Switch", Int) = 0
            _Emissionscroll("Emission scroll", 2D) = "white" {}
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_EmissionscrollUVSwitch("Emission scroll UV Switch", Int) = 0
            _NoiseSpeed("Noise Speed", Range( -2 , 2)) = 0.1
            _Emiossionscrollspeed("Emiossion scroll speed", Range( -2 , 2)) = 0
            [moriohVec2Float]_NoiseVectorXY("Noise Vector", Vector) = (0,1,0,0)
            [moriohVec2Float]_VectorXY("Vector", Vector) = (0,1,0,0)
            //_EmissionScrollMask("Emission Scroll Mask", 2D) = "white" {}
            //[Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_EmissionScrollMaskUVSwitch("Emission Scroll Mask UV Switch", Float) = 0
            //[HDR]_EmissionscrollColor("Emission scroll Color", Color) = (1,1,1,1)
        //[HideInInspector]end_ESV1("", Int) = 0
        
        //EmissionScrollV2
        //[HideInInspector]group_ESV2("ESV2", Int) = 0
            [HelpBox(4)]_AudioLinkTooltip("AudioLinkTooltip", Float) = 0
            [Enum(Off,0,ES v1,1,ES v2,2)]_EmissionScrollToggle("Emission Scroll Toggle", Int) = 0
            [Enum(Off,0,On,1)]_IgnoreNormalsESv2("Ignore Normals ESv2", Int) = 0
            [Enum(Vertex Normal based,0,Fresnel Camera based,1,Vertex Position,2,Voronoi,3,Vertex UV based,4)]_ESRenderMethod("ES Render Method", Int) = 2
            _ESVoronoiScale("ES Voronoi Scale", Float) = 1
            _ESVoronoiSpeed("ES Voronoi Speed", Range( -10 , 10)) = 1
            [Enum(Off,0,Bands,1,Waveform,2,Bands plus Waveform,3)]_AudioLinkSwitch("AudioLink Switch", Int) = 1
            _AudioHueSpeed("Audio Hue Speed", Range( 0 , 1)) = 0.05
            [HDR]_AudioLinkColor("AudioLink Color", Color) = (1,1,1,1)
            [IntRange]_AudioLinkBandHistory("AudioLink Band History", Range( 32 , 128)) = 80
            _AudioBandIntensity("AudioBandIntensity", Vector) = (1,0.25,0.25,0.25)
            [Enum(Single,0,Mirrored,1,Mirror filled,2)]_AudioLinkWaveformMirrorToggle("AudioLink Waveform Mirror Toggle", Int) = 0
            _WaveformThickness("Waveform Thickness", Range( 0 , 1)) = 0.1
            _WaveformRotation("Waveform Rotation", Range( -1 , 1)) = 0
            _WaveformCoordinates("Waveform Coordinates", Vector) = (1,1,0,0)
            [IntRange]_WaveformUVShift("Waveform UV Shift", Range(0, 16)) = 0
            _EmissionscrollTint("Emissionscroll Tint", Range( 0 , 1)) = 1
            [HDR]_EmissionscrollColor("Emission scroll Color", Color) = (1,1,1,1)
            _ESSize("ES Size", Range( 0 , 1)) = 1
            _ESSharpness("ES Sharpness", Range( 0 , 1)) = 0
            _ESLevelOffset("ES Level Offset", Range( -1 , 1)) = 0
            _ESSpeed("ES Speed", Range( -10 , 10)) = 0.5
            _ESScrollOffset("ES Scroll Offset", Range( 0 , 1)) = 0
            [moriohVec2Float]_ESCoordinates("ES Coordinates", Vector) = (0,2,0,0)
            _EmissionScrollMask("Emission Scroll Mask", 2D) = "white" {}
            [WideEnum(RR,0,RG,1,RB,2,RA,3,GR,4,GG,5,GB,6,GA,7,BR,8,BG,9,BB,10,BA,11,AR,12,AG,13,AB,14,AA,15,1  minus RR,16,1  minus RG,17,1  minus RB,18,1  minus RA,19,1  minus GR,20,1  minus GG,21,1  minus GB,22,1  minus GA,23,1  minus BR,24,1  minus BG,25,1  minus BB,26,1  minus BA,27,1  minus AR,28,1  minus AG,29,1  minus AB,30,1  minus AA,31)]_EmissionScrollMaskTexChannelSwitch("EmissionScroll Mask Channel Switch", Int) = 1
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_EmissionScrollMaskUVSwitch("Emission Scroll Mask UV Switch", Int) = 0
        //[HideInInspector]end_ESV2("", Int) = 0
        
        // Rendering Options //For Kajs Shader Editor
        //[HideInInspector]group_RenderingOptions("Rendering Options", Int) = 0
        //    [GIFlags] _GIFlags ("Global Illumination", Int) = 4
        //    [DisabledLightModes] _LightModes ("Disabled LightModes", Int) = 0
        //    [DisableBatching] _DisableBatching ("Disable Batching", Int) = 0
        //    [PreviewType] _PreviewType ("Preview Type", Int) = 0
        //    [OverrideTagToggle(IgnoreProjector)] _IgnoreProjector ("IgnoreProjector", Int) = 0
        //    [OverrideTagToggle(ForceNoShadowCasting)] _ForceNoShadowCasting ("ForceNoShadowCasting", Int) = 0
        //    [OverrideTagToggle(CanUseSpriteAtlas)] _CanUseSpriteAtlas ("CanUseSpriteAtlas", Int) = 1
        //    [ToggleUI]_AlphaToMask ("Alpha To Coverage", Int) = 0
        //
        //[HideInInspector]group_Blending("Blending Options", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull", Int) = 2
        //    [WideEnum(Off,0,On,1)] _ZWrite ("ZWrite", Int) = 1
        //    [WideEnum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
        //    _OffsetFactor("Offset Factor", Float) = 0
        //    _OffsetUnits("Offset Units", Float) = 0
        //    [WideEnum(MoriohsShader.BlendOp)]_BlendOp ("RGB Blend Op", Int) = 0
        //    [WideEnum(MoriohsShader.BlendOp)]_BlendOpAlpha ("Alpha Blend Op", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("RGB Source Blend", Int) = 1
        //    [WideEnum(UnityEngine.Rendering.BlendMode)] _DstBlend ("RGB Destination Blend", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.BlendMode)] _SrcBlendAlpha ("Alpha Source Blend", Int) = 1
        //    [WideEnum(UnityEngine.Rendering.BlendMode)] _DstBlendAlpha ("Alpha Destination Blend", Int) = 0
        //    [WideEnum(MoriohsShader.ColorMask)] _ColorMask("Color Mask", Int) = 15
        //[HideInInspector]end_Blending("", Int) = 0
        //
        //[HideInInspector]group_Stencil("Stencil Options", Int) = 0
        //    [IntRange] _Stencil ("Reference Value", Range(0, 255)) = 0
        //    [IntRange] _StencilWriteMask ("ReadMask", Range(0, 255)) = 255
        //    [IntRange] _StencilReadMask ("WriteMask", Range(0, 255)) = 255
        //    [WideEnum(UnityEngine.Rendering.StencilOp)] _StencilPass ("Pass Op", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.StencilOp)] _StencilFail ("Fail Op", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.StencilOp)] _StencilZFail ("ZFail Op", Int) = 0
        //    [WideEnum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Compare Function", Int) = 8
        //    [HideInInspector]end_Stencil("", Int) = 0
        //[HideInInspector]end_RenderingOptions("", Int) = 0
        //[Header(Forward Rendering Options)]
        //[Space(8)]
        //[ToggleOff(_SPECULARHIGHLIGHTS_OFF)] _SpecularHighlights (";_SPECULARHIGHLIGHTS_OFF;;Specular Highlights (BRDF)", Int) = 0
        //[ToggleOff(_GLOSSYREFLECTIONS_OFF)] _GlossyReflections (";_GLOSSYREFLECTIONS_OFF;;Reflections", Int) = 0
        
        //Silents Inventory System
        //[HideInInspector]group_Silents_Inventory("Silents Inventory System", Int) = 0
            [ToggleUI]_UseInventory("Use Inventory", Float) = 0.0
            [Enum(Simple,0,Complex,1)]_InventoryComplexity ("Inventory Complexity", Int) = 0
            [HelpBox(3)]_InventoryComplexityTooltip("_InventoryComplexityTooltip", Int) = 0
		    _InventoryStride("Inventory Stride", Int) = 1
            [ToggleUI]_InventoryRenameProperties("Rename Properties", Int) = 0
		    _InventoryItem01Animated("Toggle Item 1", Range(0, 1)) = 1.0
		    _InventoryItem02Animated("Toggle Item 2", Range(0, 1)) = 1.0
		    _InventoryItem03Animated("Toggle Item 3", Range(0, 1)) = 1.0
		    _InventoryItem04Animated("Toggle Item 4", Range(0, 1)) = 1.0
		    _InventoryItem05Animated("Toggle Item 5", Range(0, 1)) = 1.0
		    _InventoryItem06Animated("Toggle Item 6", Range(0, 1)) = 1.0
		    _InventoryItem07Animated("Toggle Item 7", Range(0, 1)) = 1.0
		    _InventoryItem08Animated("Toggle Item 8", Range(0, 1)) = 1.0
		    _InventoryItem09Animated("Toggle Item 9", Range(0, 1)) = 1.0
		    _InventoryItem10Animated("Toggle Item 10", Range(0, 1)) = 1.0
		    _InventoryItem11Animated("Toggle Item 11", Range(0, 1)) = 1.0
		    _InventoryItem12Animated("Toggle Item 12", Range(0, 1)) = 1.0
		    _InventoryItem13Animated("Toggle Item 13", Range(0, 1)) = 1.0
		    _InventoryItem14Animated("Toggle Item 14", Range(0, 1)) = 1.0
		    _InventoryItem15Animated("Toggle Item 15", Range(0, 1)) = 1.0
		    _InventoryItem16Animated("Toggle Item 16", Range(0, 1)) = 1.0
            [HDR]_EmissiveDissolveColor("Emissive Dissolve Color", Color) = (128,0,255,1)
            _InventoryEmissionThickness("Inventory Emission Thickness", Range(1, 2)) = 1.25
            [Enum(UV0,0,UV1,1,UV2,2,UV3,3)]_InventoryUVSwitch ("UV Set", Int) = 0
            _DissolvePattern ("Dissolve Pattern", 2D) = "white" {}
        //[HideInInspector]end_Silents_Inventory("", Int) = 0
        
        
        
        //Rendering Options
        [Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
        [Enum(UnityEngine.Rendering.BlendMode)]_SrcBlend("Source Blend RGB", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]_DstBlend("Destination Blend RGB", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendOpRGB("Blend Op RGB", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_SourceBlendAlpha("Source Blend Alpha", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]_DestinationBlendAlpha("Destination Blend Alpha", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendOpAlpha("Blend Op Alpha", Float) = 0
        //_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0.5 //Not used anymore
        [Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
        [OverrideTagToggle(IgnoreProjector)]_IgnoreProjector("IgnoreProjector", Int) = 0
        [Enum(UnityEngine.Rendering.ColorWriteMask)]_ColorMask("Color Mask", Float) = 15
        _StencilBufferReference("Stencil Buffer Reference", Range( 0 , 255)) = 0
        _StencilBufferReadMask("Stencil Buffer Read Mask", Range( 0 , 255)) = 255
        _StencilBufferWriteMask("Stencil Buffer Write Mask", Range( 0 , 255)) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilBufferComparison("Stencil Buffer Comparison", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilBufferPassFront("Stencil Buffer Pass Front", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilBufferFailFront("Stencil Buffer Fail Front", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilBufferZFailFront("Stencil Buffer ZFail Front", Float) = 0
        [Enum(Off,0,On,1)]_ZWrite("ZWrite Mode", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Float) = 4
        _DepthOffsetFactor("Depth Offset Factor", Float) = 0
        _DepthOffsetUnits("Depth Offset Units", Float) = 0
        [OverrideTagToggle(ForceNoShadowCasting)] _ForceNoShadowCasting ("ForceNoShadowCasting", Int) = 0
        [DisabledLightModes] _LightModes ("Disabled LightModes", Int) = 0
        
        
        //Animated Properties
        [ToggleUI]_BumpScaleAnimated("_BumpScaleAnimated", Int) = 0
        [ToggleUI]_DetailNormalMapScaleAnimated("_DetailNormalMapScaleAnimated", Int) = 0
        [ToggleUI]_NdLHalfingControlAnimated("_NdLHalfingControlAnimated", Int) = 0
        [ToggleUI]_DirectShadowIntensityAnimated("_DirectShadowIntensityAnimated", Int) = 0
        [ToggleUI]_SelfCastShadowsAnimated("_SelfCastShadowsAnimated", Int) = 0
        [ToggleUI]_PointSpotShadowIntensityAnimated("_PointSpotShadowIntensityAnimated", Int) = 0
        [ToggleUI]_RampOffsetAnimated("_RampOffsetAnimated", Int) = 0
        [ToggleUI]_ToggleStepsAnimated("_ToggleStepsAnimated", Int) = 0
        [ToggleUI]_StepsAnimated("_StepsAnimated", Int) = 0
        //[ToggleUI]_ShadowMaskinvertAnimated("_ShadowMaskinvertAnimated", Int) = 0
        [ToggleUI]_ShadowMaskStrengthAnimated("_ShadowMaskStrengthAnimated", Int) = 0
        [ToggleUI]_ShadowMaskTexChannelSwitchAnimated("_ShadowMaskTexChannelSwitchAnimated", Int) = 0
        [ToggleUI]_ShadowColorMapStrengthAnimated("_ShadowColorMapStrengthAnimated", Int) = 0
        [ToggleUI]_ColoringPointLightsAnimated("_ColoringPointLightsAnimated", Int) = 0
        [ToggleUI]_ColoringDirectEnvLightsAnimated("_ColoringDirectEnvLightsAnimated", Int) = 0
        [ToggleUI]_ToggleMonochromePixelLightAnimated("_ToggleMonochromePixelLightAnimated", Int) = 0
        [ToggleUI]_ToggleMonochromeEnvAnimated("_ToggleMonochromeEnvAnimated", Int) = 0
        [ToggleUI]_DistanceFadeAnimated("_DistanceFadeAnimated", Int) = 0
        [ToggleUI]_IndirectShadowIntensityAnimated("_IndirectShadowIntensityAnimated", Int) = 0
        [ToggleUI]_AmbientBoostAnimated("_AmbientBoostAnimated", Int) = 0
        [ToggleUI]_LightLimiterAnimated("_LightLimiterAnimated", Int) = 0
        [ToggleUI]_MaxLightDirectAnimated("_MaxLightDirectAnimated", Int) = 0
        [ToggleUI]_OcclusionStrengthAnimated("_OcclusionStrengthAnimated", Int) = 0
        [ToggleUI]_MetallicAnimated("_MetallicAnimated", Int) = 0
        [ToggleUI]_CutoffAnimated("_CutoffAnimated", Int) = 0
        [ToggleUI]_BRDFReflInheritAnisoAnimated("_BRDFReflInheritAnisoAnimated", Int) = 0
        [ToggleUI]_EnableGSAAAnimated("_EnableGSAAAnimated", Int) = 0
        [ToggleUI]_GSAAVarianceAnimated("_GSAAVarianceAnimated", Int) = 0
        [ToggleUI]_GSAAThresholdAnimated("_GSAAThresholdAnimated", Int) = 0
        //Hue Shift
        [ToggleUI]_HueShiftSpeedAnimated("_HueShiftSpeedAnimated", Int) = 0
        [ToggleUI]_ToggleHueTexforSpeedAnimated("_ToggleHueTexforSpeedAnimated", Int) = 0
        [ToggleUI]_HueShiftRandomizerAnimated("_HueShiftRandomizerAnimated", Int) = 0
        [ToggleUI]_HueMaskinverterAnimated("_HueMaskinverterAnimated", Int) = 0
        [ToggleUI]_HueShiftblendAnimated("_HueShiftblendAnimated", Int) = 0
        //Desaturation
        [ToggleUI]_SaturationAnimated("_SaturationAnimated", Int) = 0
        //Colors
        [ToggleUI]_ColorAnimated("_ColorAnimated", Int) = 0
        [ToggleUI]_BC7compressionFixAnimated("_BC7compressionFixAnimated", Int) = 0
        [ToggleUI]_RampColorAnimated("_RampColorAnimated", Int) = 0
        //UV Switches
        [ToggleUI]_MainTexUVSwitchAnimated("_MainTexUVSwitchAnimated", Int) = 0
        [ToggleUI]_BumpMapUVSwitchAnimated("_BumpMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_DetailNormalMapUVSwitchAnimated("_DetailNormalMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_DetailMaskUVSwitchAnimated("_DetailMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_DetailMaskTexChannelSwitchAnimated("_DetailMaskTexChannelSwitchAnimated", Int) = 0
        [ToggleUI]_SpecularMapUVSwitchAnimated("_SpecularMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_OcclusionMapUVSwitchAnimated("_OcclusionMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_MetallicGlossMapUVSwitchAnimated("_MetallicGlossMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_ReflectionMaskUVSwitchAnimated("_ReflectionMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_ReflectionMaskTexChannelSwitchAnimated("_ReflectionMaskTexChannelSwitchAnimated", Int) = 0
        //[ToggleUI]_ReflectionMaskInvertAnimated("_ReflectionMaskInvertAnimated", Int) = 0
        [ToggleUI]_SSSThicknessMapUVSwitchAnimated("_SSSThicknessMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_MatcapMaskUVSwitchAnimated("_MatcapMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_HueMaskUVSwitchAnimated("_HueMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_RimMaskUVSwitchAnimated("_RimMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_RimMaskTexChannelSwitchAnimated("_RimMaskTexChannelSwitchAnimated", Int) = 0
        [ToggleUI]_AnisoDirUVSwitchAnimated("_AnisoDirUVSwitchAnimated", Int) = 0
        //Specular Highlights
        [ToggleUI]_AnisotropyAnimated("_AnisotropyAnimated", Int) = 0
        [ToggleUI]_AnisoFlickerFixAnimated("_AnisoFlickerFixAnimated", Int) = 0
        [ToggleUI]_AnisoFlickerFixOffsetAnimated("_AnisoFlickerFixOffsetAnimated", Int) = 0
        [ToggleUI]_SpecShadowMaskVarAnimated("_SpecShadowMaskVarAnimated", Int) = 0
        [ToggleUI]_SpecShadowMaskPowerAnimated("_SpecShadowMaskPowerAnimated", Int) = 0
        [ToggleUI]_SpecularTintAnimated("_SpecularTintAnimated", Int) = 0
        [ToggleUI]_SpecularColorAnimated("_SpecularColorAnimated", Int) = 0
        [ToggleUI]_HighlightSmoothnessAnimated("_HighlightSmoothnessAnimated", Int) = 0
        [ToggleUI]_HighlightOffsetAnimated("_HighlightOffsetAnimated", Int) = 0
        [ToggleUI]_AnisoScaleAnimated("_AnisoScaleAnimated", Int) = 0
        [ToggleUI]_AnisoSharpeningAnimated("_AnisoSharpeningAnimated", Int) = 0
        [ToggleUI]_BlinntoAnisoAnimated("_BlinntoAnisoAnimated", Int) = 0
        [ToggleUI]_SpecularSettingAnimated("_SpecularSettingAnimated", Int) = 0
        //SSS
        [ToggleUI]_SubsurfaceDistortionModifierAnimated("_SubsurfaceDistortionModifierAnimated", Int) = 0
        [ToggleUI]_SSSPowerAnimated("_SSSPowerAnimated", Int) = 0
        [ToggleUI]_SSSTintAnimated("_SSSTintAnimated", Int) = 0
        [ToggleUI]_SSSScaleAnimated("_SSSScaleAnimated", Int) = 0
        [ToggleUI]_SSSMapModeAnimated("_SSSMapModeAnimated", Int) = 0
        [ToggleUI]_SSSThicknessinvAnimated("_SSSThicknessinvAnimated", Int) = 0
        [ToggleUI]_SSSSettingAnimated("_SSSSettingAnimated", Int) = 0
        [ToggleUI]_SSSToggleAnimated("_SSSToggleAnimated", Int) = 0
        [ToggleUI]_SSSColorAnimated("_SSSColorAnimated", Int) = 0
        //Matcap
        [ToggleUI]_MatcapR1ToggleAnimated("_MatcapR1ToggleAnimated", Int) = 0
        [ToggleUI]_MatcapR1smoothnessAnimated("_MatcapR1smoothnessAnimated", Int) = 0
        [ToggleUI]_MatcapR1ColorAnimated("_MatcapR1ColorAnimated", Int) = 0
        [ToggleUI]_MatcapR1IntensityAnimated("_MatcapR1IntensityAnimated", Int) = 0
        [ToggleUI]_MatcapR1TintAnimated("_MatcapR1TintAnimated", Int) = 0
        [ToggleUI]_MatcapR1MaskInvertAnimated("_MatcapR1MaskInvertAnimated", Int) = 0
        [ToggleUI]_MatcapR1ModeAnimated("_MatcapR1ModeAnimated", Int) = 0
        [ToggleUI]_MatcapR1BlendingAnimated("_MatcapR1BlendingAnimated", Int) = 0
        [ToggleUI]_MatcapG2ToggleAnimated("_MatcapG2ToggleAnimated", Int) = 0
        [ToggleUI]_MatcapG2smoothnessAnimated("_MatcapG2smoothnessAnimated", Int) = 0
        [ToggleUI]_MatcapG2ColorAnimated("_MatcapG2ColorAnimated", Int) = 0
        [ToggleUI]_MatcapG2IntensityAnimated("_MatcapG2IntensityAnimated", Int) = 0
        [ToggleUI]_MatcapG2TintAnimated("_MatcapG2TintAnimated", Int) = 0
        [ToggleUI]_MatcapG2MaskInvertAnimated("_MatcapG2MaskInvertAnimated", Int) = 0
        [ToggleUI]_MatcapG2ModeAnimated("_MatcapG2ModeAnimated", Int) = 0
        [ToggleUI]_MatcapG2BlendingAnimated("_MatcapG2BlendingAnimated", Int) = 0
        [ToggleUI]_MatcapB3ToggleAnimated("_MatcapB3ToggleAnimated", Int) = 0
        [ToggleUI]_MatcapB3smoothnessAnimated("_MatcapB3smoothnessAnimated", Int) = 0
        [ToggleUI]_MatcapB3ColorAnimated("_MatcapB3ColorAnimated", Int) = 0
        [ToggleUI]_MatcapB3IntensityAnimated("_MatcapB3IntensityAnimated", Int) = 0
        [ToggleUI]_MatcapB3TintAnimated("_MatcapB3TintAnimated", Int) = 0
        [ToggleUI]_MatcapB3MaskInvertAnimated("_MatcapB3MaskInvertAnimated", Int) = 0
        [ToggleUI]_MatcapB3ModeAnimated("_MatcapB3ModeAnimated", Int) = 0
        [ToggleUI]_MatcapB3BlendingAnimated("_MatcapB3BlendingAnimated", Int) = 0
        [ToggleUI]_MatcapA4ToggleAnimated("_MatcapA4ToggleAnimated", Int) = 0
        [ToggleUI]_MatcapA4smoothnessAnimated("_MatcapA4smoothnessAnimated", Int) = 0
        [ToggleUI]_MatcapA4ColorAnimated("_MatcapA4ColorAnimated", Int) = 0
        [ToggleUI]_MatcapA4IntensityAnimated("_MatcapA4IntensityAnimated", Int) = 0
        [ToggleUI]_MatcapA4TintAnimated("_MatcapA4TintAnimated", Int) = 0
        [ToggleUI]_MatcapA4MaskInvertAnimated("_MatcapA4MaskInvertAnimated", Int) = 0
        [ToggleUI]_MatcapA4ModeAnimated("_MatcapA4ModeAnimated", Int) = 0
        [ToggleUI]_MatcapA4BlendingAnimated("_MatcapA4BlendingAnimated", Int) = 0
        [ToggleUI]_IgnoreNormalsMatcapAnimated("_IgnoreNormalsMatcapAnimated", Int) = 0
        [ToggleUI]_MatcapViewDirAnimated("_MatcapViewDirAnimated", Int) = 0
        //RimLight
        [ToggleUI]_RimDirectionToggleAnimated("_RimDirectionToggleAnimated", Int) = 0
        //[ToggleUI]_RimLightMaskinvAnimated("_RimLightMaskinvAnimated", Int) = 0
        [ToggleUI]_RimFresnelBiasAnimated("_RimFresnelBiasAnimated", Int) = 0
        [ToggleUI]_RimFresnelScaleAnimated("_RimFresnelScaleAnimated", Int) = 0
        [ToggleUI]_RimFresnelPowerAnimated("_RimFresnelPowerAnimated", Int) = 0
        [ToggleUI]_RimOffsetAnimated("_RimOffsetAnimated", Int) = 0
        [ToggleUI]_RimPowerAnimated("_RimPowerAnimated", Int) = 0
        [ToggleUI]_RimSpecLightsmoothnessAnimated("_RimSpecLightsmoothnessAnimated", Int) = 0
        [ToggleUI]_RimSpecToggleAnimated("_RimSpecToggleAnimated", Int) = 0
        [ToggleUI]_RimTintAnimated("_RimTintAnimated", Int) = 0
        [ToggleUI]_RimOpacityAnimated("_RimOpacityAnimated", Int) = 0
        [ToggleUI]_RimFaceCullingAnimated("_RimFaceCullingAnimated", Int) = 0
        [ToggleUI]_RimToggleAnimated("_RimToggleAnimated", Int) = 0
        [ToggleUI]_RimColorAnimated("_RimColorAnimated", Int) = 0
        [ToggleUI]_RimLightReflInheritAnisoAnimated("_RimLightReflInheritAnisoAnimated", Int) = 0
        //BRDF
        [ToggleUI]_CubemapIntensityAnimated("_CubemapIntensityAnimated", Int) = 0
        [ToggleUI]_IgnoreNormalsCubemapAnimated("_IgnoreNormalsCubemapAnimated", Int) = 0
        [ToggleUI]_GlossinessAnimated("_GlossinessAnimated", Int) = 0
        [ToggleUI]_SpecularHighlightsAnimated("_SpecularHighlightsAnimated", Int) = 0
        [ToggleUI]_WorkflowSwitchAnimated("_WorkflowSwitchAnimated", Int) = 0
        //Shadow/Emissive Rim
        [ToggleUI]_ShadowRimRangeAnimated("_ShadowRimRangeAnimated", Int) = 0
        [ToggleUI]_ShadowRimSharpnessAnimated("_ShadowRimSharpnessAnimated", Int) = 0
        [ToggleUI]_ShadowRimOpacityAnimated("_ShadowRimOpacityAnimated", Int) = 0
        [ToggleUI]_RimHueSpeedAnimated("_RimHueSpeedAnimated", Int) = 0
        [ToggleUI]_RimSwitchAnimated("_RimSwitchAnimated", Int) = 0
        [ToggleUI]_EmissiveRimColorAnimated("_EmissiveRimColorAnimated", Int) = 0
        //Flipbook
        [ToggleUI]_FlipbookToggleAnimated("_FlipbookToggleAnimated", Int) = 0
        [ToggleUI]_FlipbookUVSwitchAnimated("_FlipbookUVSwitchAnimated", Int) = 0
        [ToggleUI]_FlipbookModeAnimated("_FlipbookModeAnimated", Int) = 0
        [ToggleUI]_RotateFlipbookAnimated("_RotateFlipbookAnimated", Int) = 0
        [ToggleUI]_FlipbookAudioLinkToggleAnimated("_FlipbookAudioLinkToggleAnimated", Int) = 0
        [ToggleUI]_ColumnsAnimated("_ColumnsAnimated", Int) = 0
        [ToggleUI]_RowsAnimated("_RowsAnimated", Int) = 0
        [ToggleUI]_MaxFramesAnimated("_MaxFramesAnimated", Int) = 0
        [ToggleUI]_SpeedAnimated("_SpeedAnimated", Int) = 0
        [ToggleUI]_FlipbookTintAnimated("_FlipbookTintAnimated", Int) = 0
        [ToggleUI]_FlipbookColorAnimated("_FlipbookColorAnimated", Int) = 0
        [ToggleUI]_FlipbookUVShiftAnimated("_FlipbookUVShiftAnimated", Int) = 0
        //BasicEmission
        [ToggleUI]_EmissionMapUVSwitchAnimated("_EmissionMapUVSwitchAnimated", Int) = 0
        [ToggleUI]_EmissionTintAnimated("_EmissionTintAnimated", Int) = 0
        [ToggleUI]_EmissionLightscaleAnimated("_EmissionLightscaleAnimated", Int) = 0
        [ToggleUI]_EmissionColorAnimated("_EmissionColorAnimated", Int) = 0
        //EmissionScroll shares
        [ToggleUI]_EmissionScrollMaskUVSwitchAnimated("_EmissionScrollMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_EmissionScrollMaskTexChannelSwitchAnimated("_EmissionScrollMaskTexChannelSwitchAnimated", Int) = 0
        [ToggleUI]_EmissionscrollColorAnimated("_EmissionscrollColorAnimated", Int) = 0
        [ToggleUI]_EmissionScrollToggleAnimated("_EmissionScrollToggleAnimated", Int) = 0
        //EmissionScroll V1
        [ToggleUI]_NoiseTextureUVSwitchAnimated("_NoiseTextureUVSwitchAnimated", Int) = 0
        [ToggleUI]_EmissionscrollUVSwitchAnimated("_EmissionscrollUVSwitchAnimated", Int) = 0
        [ToggleUI]_NoiseSpeedAnimated("_NoiseSpeedAnimated", Int) = 0
        [ToggleUI]_EmiossionscrollspeedAnimated("_EmiossionscrollspeedAnimated", Int) = 0
        [ToggleUI]_NoiseVectorXYAnimated("_NoiseVectorXYAnimated", Int) = 0
        [ToggleUI]_VectorXYAnimated("_VectorXYAnimated", Int) = 0
        //Emissionscroll V2
        [ToggleUI]_IgnoreNormalsESv2Animated("_IgnoreNormalsESv2Animated", Int) = 0
        [ToggleUI]_ESVoronoiSpeedAnimated("_ESVoronoiSpeedAnimated", Int) = 0
        [ToggleUI]_ESVoronoiScaleAnimated("_ESVoronoiScaleAnimated", Int) = 0
        [ToggleUI]_ESRenderMethodAnimated("_ESRenderMethodAnimated", Int) = 0
        [ToggleUI]_ESCoordinatesAnimated("_ESCoordinatesAnimated", Int) = 0
        [ToggleUI]_AudioLinkSwitchAnimated("_AudioLinkSwitchAnimated", Int) = 0
        [ToggleUI]_ESSharpnessAnimated("_ESSharpnessAnimated", Int) = 0
        [ToggleUI]_ESSizeAnimated("_ESSizeAnimated", Int) = 0
        [ToggleUI]_ESSpeedAnimated("_ESSpeedAnimated", Int) = 0
        [ToggleUI]_ESScrollOffsetAnimated("_ESScrollOffsetAnimated", Int) = 0
        [ToggleUI]_ESLevelOffsetAnimated("_ESLevelOffsetAnimated", Int) = 0
        [ToggleUI]_AudioLinkBandHistoryAnimated("_AudioLinkBandHistoryAnimated", Int) = 0
        [ToggleUI]_AudioBandIntensityAnimated("_AudioBandIntensityAnimated", Int) = 0
        [ToggleUI]_WaveformCoordinatesAnimated("_WaveformCoordinatesAnimated", Int) = 0
        [ToggleUI]_WaveformUVShiftAnimated("_WaveformUVShiftAnimated", Int) = 0
        [ToggleUI]_WaveformRotationAnimated("_WaveformRotationAnimated", Int) = 0
        [ToggleUI]_WaveformThicknessAnimated("_WaveformThicknessAnimated", Int) = 0
        [ToggleUI]_AudioLinkWaveformMirrorToggleAnimated("_AudioLinkWaveformMirrorToggleAnimated", Int) = 0
        [ToggleUI]_AudioLinkColorAnimated("_AudioLinkColorAnimated", Int) = 0
        [ToggleUI]_AudioHueSpeedAnimated("_AudioHueSpeedAnimated", Int) = 0
        [ToggleUI]_EmissionscrollTintAnimated("_EmissionscrollTintAnimated", Int) = 0
        //Toggles
        [ToggleUI]_GlossyReflectionsAnimated("_GlossyReflectionsAnimated", Int) = 0
        [ToggleUI]_ToggleDisneyDiffuseAnimated("_ToggleDisneyDiffuseAnimated", Int) = 0
        [ToggleUI]_SpecularToggleAnimated("_SpecularToggleAnimated", Int) = 0
        [ToggleUI]_ModeAnimated("_ModeAnimated", Int) = 0
        [ToggleUI]_ModeCustomAnimated("_ModeCustomAnimated", Int) = 0
        // Inventory
        [ToggleUI]_UseInventoryAnimated("_UseInventoryAnimated", Int) = 0
        [ToggleUI]_InventoryStrideAnimated("_InventoryStrideAnimated", Int) = 0
        [ToggleUI]_InventoryRenamePropertiesAnimated("_InventoryRenamePropertiesAnimated", Int) = 0
        [ToggleUI]_EmissiveDissolveColorAnimated("_EmissiveDissolveColorAnimated", Int) = 0
        [ToggleUI]_InventoryEmissionThicknessAnimated("_InventoryEmissionThicknessAnimated", Int) = 0
        [ToggleUI]_InventoryUVSwitchAnimated("_InventoryUVSwitchAnimated", Int) = 0
        //Dither
        [ToggleUI]_DitherMaskUVSwitchAnimated("_DitherMaskUVSwitchAnimated", Int) = 0
        [ToggleUI]_DitherTextureUVSwitchAnimated("_DitherTextureUVSwitchAnimated", Int) = 0
        [ToggleUI]_DitherTextureToggleAnimated("_DitherTextureToggleAnimated", Int) = 0
        [ToggleUI]_DitherAlphaToggleAnimated("_DitherAlphaToggleAnimated", Int) = 0
        [ToggleUI]_EndDitheringFadeAnimated("_EndDitheringFadeAnimated", Int) = 0
        [ToggleUI]_StartDitheringFadeAnimated("_StartDitheringFadeAnimated", Int) = 0
        [ToggleUI]_DitherTextureTilingAnimated("_DitherTextureTilingAnimated", Int) = 0
        //LTCGI
        [ToggleUI]_ToggleLTCGIDiffuseAnimated("_ToggleLTCGIDiffuseAnimated", Int) = 0
        [ToggleUI]_ToggleLTCGISpecularAnimated("_ToggleLTCGISpecularAnimated", Int) = 0
        //Decals
        [ToggleUI]_DecalToggleAnimated("_DecalToggleAnimated", Int) = 0
        [ToggleUI]_Decal1ModeAnimated("_Decal1ModeAnimated", Int) = 0
        [ToggleUI]_RotateDecal1Animated("_RotateDecal1Animated", Int) = 0
        [ToggleUI]_Decal1AudioLinkToggleAnimated("_Decal1AudioLinkToggleAnimated", Int) = 0
        [ToggleUI]_Decal1WrapModeAnimated("_Decal1WrapModeAnimated", Int) = 0
        [ToggleUI]_Decal1UVSwitchAnimated("_Decal1UVSwitchAnimated", Int) = 0
        [ToggleUI]_Decal1TintAnimated("_Decal1TintAnimated", Int) = 0
        [ToggleUI]_Decal1ColorAnimated("_Decal1ColorAnimated", Int) = 0
        [ToggleUI]_Decal2ModeAnimated("_Decal2ModeAnimated", Int) = 0
        [ToggleUI]_RotateDecal2Animated("_RotateDecal2Animated", Int) = 0
        [ToggleUI]_Decal2AudioLinkToggleAnimated("_Decal2AudioLinkToggleAnimated", Int) = 0
        [ToggleUI]_Decal2WrapModeAnimated("_Decal2WrapModeAnimated", Int) = 0
        [ToggleUI]_Decal2UVSwitchAnimated("_Decal2UVSwitchAnimated", Int) = 0
        [ToggleUI]_Decal2TintAnimated("_Decal2TintAnimated", Int) = 0
        [ToggleUI]_Decal2ColorAnimated("_Decal2ColorAnimated", Int) = 0
        [ToggleUI]_Decal3ModeAnimated("_Decal3ModeAnimated", Int) = 0
        [ToggleUI]_RotateDecal3Animated("_RotateDecal3Animated", Int) = 0
        [ToggleUI]_Decal3AudioLinkToggleAnimated("_Decal3AudioLinkToggleAnimated", Int) = 0
        [ToggleUI]_Decal3WrapModeAnimated("_Decal3WrapModeAnimated", Int) = 0
        [ToggleUI]_Decal3UVSwitchAnimated("_Decal3UVSwitchAnimated", Int) = 0
        [ToggleUI]_Decal3TintAnimated("_Decal3TintAnimated", Int) = 0
        [ToggleUI]_Decal3ColorAnimated("_Decal3ColorAnimated", Int) = 0
        [ToggleUI]_Decal4ModeAnimated("_Decal4ModeAnimated", Int) = 0
        [ToggleUI]_RotateDecal4Animated("_RotateDecal4Animated", Int) = 0
        [ToggleUI]_Decal4AudioLinkToggleAnimated("_Decal4AudioLinkToggleAnimated", Int) = 0
        [ToggleUI]_Decal4WrapModeAnimated("_Decal4WrapModeAnimated", Int) = 0
        [ToggleUI]_Decal4UVSwitchAnimated("_Decal4UVSwitchAnimated", Int) = 0
        [ToggleUI]_Decal4TintAnimated("_Decal4TintAnimated", Int) = 0
        [ToggleUI]_Decal4ColorAnimated("_Decal4ColorAnimated", Int) = 0
        [ToggleUI]_DecalUVShiftAnimated("_DecalUVShiftAnimated", Int) = 0
        [ToggleUI]_DecalMaskUVSwitchAnimated("_DecalMaskUVSwitchAnimated", Int) = 0
    }

    CustomEditor "Morioh.Moriohs_Toon_Shader.Editor.MorisMaterialInspector"CGINCLUDE
#define OPTIMIZER_ENABLED
#define PROP_SHADEROPTIMIZERENABLED 1
#define PROP_ADVANCEDEXPERIMENTALTOGGLE 2
#define PROP_MODE 0
#define PROP_MODECUSTOM 0
#define PROP_DUMMY 0
#define PROP_COLORCOLOR 1
#define PROP_CUTOFF 0
#define PROP_BC7COMPRESSIONFIX 0
#define PROP_MAINTEXUVSWITCH 0
#define PROP_SATURATION 0.78
#define PROP_HUESHIFTSPEED 0
#define PROP_TOGGLEHUETEXFORSPEED 1
#define PROP_HUESHIFTRANDOMIZER 0
#define PROP_HUEMASKINVERTER 0
#define PROP_HUESHIFTBLEND 0.5
#define PROP_HUEMASKUVSWITCH 0
#define PROP_GLOSSYREFLECTIONS 1
#define PROP_TOGGLEDISNEYDIFFUSE 1
#define PROP_IGNORENORMALSCUBEMAP 0
#define PROP_SPECULARHIGHLIGHTS 1
#define PROP_WORKFLOWSWITCH 0
#define PROP_METALLIC 1
#define PROP_GLOSSINESS 1
#define PROP_GLOSSMAPSCALE 1
#define PROP_BRDFREFLINHERITANISO 0
#define PROP_METALLICGLOSSMAPUVSWITCH 0
#define PROP_REFLECTIONMASKUVSWITCH 0
#define PROP_REFLECTIONMASKTEXCHANNELSWITCH 0
#define PROP_ENABLEGSAA 1
#define PROP_GSAAVARIANCE 0.15
#define PROP_GSAATHRESHOLD 0.1
#define PROP_CUBEMAPINTENSITY 1
#define PROP_TOGGLESTEPS 1
#define PROP_STEPS 8
#define PROP_SHADOWMASKSTRENGTH 1
#define PROP_SHADOWMASKTEXCHANNELSWITCH 1
#define PROP_OCCLUSIONMAPUVSWITCH 0
#define PROP_OCCLUSIONSTRENGTH 1
#define PROP_TOONRAMP
#define PROP_RAMPOFFSET 0.5
#define PROP_NDLHALFINGCONTROL 0.5
#define PROP_SHADOWCOLORMAPSTRENGTH 1
#define PROP_COLORINGPOINTLIGHTS 0
#define PROP_COLORINGDIRECTENVLIGHTS 0
#define PROP_DIRECTSHADOWINTENSITY 1
#define PROP_SELFCASTSHADOWS 1
#define PROP_POINTSPOTSHADOWINTENSITY 1
#define PROP_LIGHTLIMITER 1
#define PROP_MAXLIGHTDIRECT 1
#define PROP_AMBIENTBOOST 1.5
#define PROP_INDIRECTSHADOWINTENSITY 0.5
#define PROP_TOGGLEMONOCHROMEPIXELLIGHT 0
#define PROP_TOGGLEMONOCHROMEENV 0
#define PROP_RIMTOGGLE 1
#define PROP_RIMMASKUVSWITCH 0
#define PROP_RIMMASKTEXCHANNELSWITCH 1
#define PROP_RIMDIRECTIONTOGGLE 0
#define PROP_RIMFRESNELBIAS 0
#define PROP_RIMFRESNELSCALE 1
#define PROP_RIMFRESNELPOWER 5
#define PROP_RIMOFFSET 0.097
#define PROP_RIMPOWER 5
#define PROP_RIMSPECLIGHTSMOOTHNESS 0
#define PROP_RIMSPECTOGGLE 0
#define PROP_RIMLIGHTREFLINHERITANISO 0
#define PROP_RIMTINT 0.731
#define PROP_RIMOPACITY 0.25
#define PROP_RIMFACECULLING 1
#define PROP_EMISSIONMAPUVSWITCH 0
#define PROP_EMISSIONTINT 1
#define PROP_EMISSIONLIGHTSCALE 0
#define PROP_BUMPMAPUVSWITCH 0
#define PROP_BUMPSCALE 0
#define PROP_DETAILNORMALMAPUVSWITCH 0
#define PROP_DETAILNORMALMAPSCALE 0
#define PROP_DETAILMASKUVSWITCH 0
#define PROP_DETAILMASKTEXCHANNELSWITCH 7
#define PROPGROUP_MATCAPR1 0
#define PROP_MATCAPR1TOGGLE 1
#define PROP_IGNORENORMALSMATCAP 0
#define PROP_MATCAPVIEWDIR 0
#define PROP_MATCAPR1
#define PROP_MATCAPR1MODE 0
#define PROP_MATCAPR1BLENDING 1
#define PROP_MATCAPR1INTENSITY 1
#define PROP_MATCAPR1SMOOTHNESS 1
#define PROP_MATCAPR1TINT 0
#define PROP_MATCAPR1MASKINVERT 0
#define PROP_MATCAPG2TOGGLE 0
#define PROP_MATCAPG2MODE 0
#define PROP_MATCAPG2BLENDING 1
#define PROP_MATCAPG2INTENSITY 1
#define PROP_MATCAPG2SMOOTHNESS 1
#define PROP_MATCAPG2TINT 0
#define PROP_MATCAPG2MASKINVERT 0
#define PROP_MATCAPB3TOGGLE 0
#define PROP_MATCAPB3MODE 0
#define PROP_MATCAPB3BLENDING 1
#define PROP_MATCAPB3INTENSITY 1
#define PROP_MATCAPB3SMOOTHNESS 1
#define PROP_MATCAPB3TINT 0
#define PROP_MATCAPB3MASKINVERT 0
#define PROP_MATCAPA4TOGGLE 0
#define PROP_MATCAPA4MODE 0
#define PROP_MATCAPA4BLENDING 1
#define PROP_MATCAPA4INTENSITY 1
#define PROP_MATCAPA4SMOOTHNESS 1
#define PROP_MATCAPA4TINT 0
#define PROP_MATCAPA4MASKINVERT 0
#define PROP_MATCAPMASKUVSWITCH 0
#define PROP_SPECULARTOGGLE 0
#define PROP_SPECULARMAPUVSWITCH 0
#define PROP_ANISOTROPY 0.8
#define PROP_ANISOFLICKERFIX 0
#define PROP_ANISOFLICKERFIXOFFSET 0.2
#define PROP_SPECSHADOWMASKVAR 2
#define PROP_SPECSHADOWMASKPOWER 0
#define PROP_SPECULARTINT 1
#define PROP_ANISODIRUVSWITCH 0
#define PROP_HIGHLIGHTSMOOTHNESS 0
#define PROP_HIGHLIGHTOFFSET 0
#define PROP_ANISOSCALE 1
#define PROP_ANISOSHARPENING 0
#define PROP_BLINNTOANISO 0
#define PROP_SPECULARSETTING 0
#define PROP_SSSTOGGLE 1
#define PROP_SSSSETTING 0
#define PROP_SSSSCALE 1
#define PROP_SSSTINT 1
#define PROP_SUBSURFACEDISTORTIONMODIFIER 1
#define PROP_SSSPOWER 2.5
#define PROP_SSSMAPMODE 0
#define PROP_SSSTHICKNESSINV 0
#define PROP_SSSTHICKNESSMAPUVSWITCH 0
#define PROP_RIMSWITCH 0
#define PROP_SHADOWRIMRANGE 0.75
#define PROP_SHADOWRIMSHARPNESS 1
#define PROP_SHADOWRIMOPACITY 0
#define PROP_RIMHUESPEED 0
#define PROP_LTCGI 0
#define PROP_TOGGLELTCGIDIFFUSE 1
#define PROP_TOGGLELTCGISPECULAR 1
#define PROP_LTCGINOTINSTALLEDTOOLTIP 0
#define PROP_FLIPBOOKTOGGLE 0
#define PROP_FLIPBOOKUVSWITCH 0
#define PROP_FLIPBOOKMODE 0
#define PROP_ROTATEFLIPBOOK 0
#define PROP_FLIPBOOKAUDIOLINKTOGGLE 0
#define PROP_COLUMNS 0
#define PROP_ROWS 0
#define PROP_MAXFRAMES 1
#define PROP_SPEED 6
#define PROP_FLIPBOOKTINT 0
#define PROP_FLIPBOOKUVSHIFT 0
#define PROP_DECALTOGGLE 0
#define PROP_DECAL1UVSWITCH 0
#define PROP_DECAL1WRAPMODE 1
#define PROP_DECAL1MODE 0
#define PROP_ROTATEDECAL1 0
#define PROP_DECAL1AUDIOLINKTOGGLE 0
#define PROP_DECAL1TINT 0
#define PROP_DECAL2UVSWITCH 0
#define PROP_DECAL2WRAPMODE 1
#define PROP_DECAL2MODE 0
#define PROP_ROTATEDECAL2 0
#define PROP_DECAL2AUDIOLINKTOGGLE 0
#define PROP_DECAL2TINT 0
#define PROP_DECAL3UVSWITCH 0
#define PROP_DECAL3WRAPMODE 1
#define PROP_DECAL3MODE 0
#define PROP_ROTATEDECAL3 0
#define PROP_DECAL3AUDIOLINKTOGGLE 0
#define PROP_DECAL3TINT 0
#define PROP_DECAL4UVSWITCH 0
#define PROP_DECAL4WRAPMODE 1
#define PROP_DECAL4MODE 0
#define PROP_ROTATEDECAL4 0
#define PROP_DECAL4AUDIOLINKTOGGLE 0
#define PROP_DECAL4TINT 0
#define PROP_DECALUVSHIFT 0
#define PROP_DECALMASKUVSWITCH 0
#define PROP_DITHERMASKUVSWITCH 0
#define PROP_DITHERALPHATOGGLE 0
#define PROP_DITHERTEXTURETOGGLE 0
#define PROP_STARTDITHERINGFADE 0
#define PROP_ENDDITHERINGFADE 0
#define PROP_DITHERTEXTURETILING 1
#define PROP_NOISETEXTUREUVSWITCH 0
#define PROP_EMISSIONSCROLLUVSWITCH 0
#define PROP_NOISESPEED 0.1
#define PROP_EMIOSSIONSCROLLSPEED 0
#define PROP_AUDIOLINKTOOLTIP 0
#define PROP_EMISSIONSCROLLTOGGLE 2
#define PROP_IGNORENORMALSESV2 0
#define PROP_ESRENDERMETHOD 4
#define PROP_ESVORONOISCALE 1
#define PROP_ESVORONOISPEED 1
#define PROP_AUDIOLINKSWITCH 2
#define PROP_AUDIOHUESPEED 0.7
#define PROP_AUDIOLINKBANDHISTORY 80
#define PROP_AUDIOLINKWAVEFORMMIRRORTOGGLE 0
#define PROP_WAVEFORMTHICKNESS 0.578
#define PROP_WAVEFORMROTATION 0
#define PROP_WAVEFORMUVSHIFT 0
#define PROP_EMISSIONSCROLLTINT 1
#define PROP_ESSIZE 1
#define PROP_ESSHARPNESS 0
#define PROP_ESLEVELOFFSET 0
#define PROP_ESSPEED 0.5
#define PROP_ESSCROLLOFFSET 0
#define PROP_EMISSIONSCROLLMASKTEXCHANNELSWITCH 1
#define PROP_EMISSIONSCROLLMASKUVSWITCH 0
#define PROP_USEINVENTORY 0
#define PROP_INVENTORYCOMPLEXITY 0
#define PROP_INVENTORYCOMPLEXITYTOOLTIP 0
#define PROP_INVENTORYSTRIDE 1
#define PROP_INVENTORYRENAMEPROPERTIES 0
#define PROP_INVENTORYITEM01ANIMATED 1
#define PROP_INVENTORYITEM02ANIMATED 1
#define PROP_INVENTORYITEM03ANIMATED 1
#define PROP_INVENTORYITEM04ANIMATED 1
#define PROP_INVENTORYITEM05ANIMATED 1
#define PROP_INVENTORYITEM06ANIMATED 1
#define PROP_INVENTORYITEM07ANIMATED 1
#define PROP_INVENTORYITEM08ANIMATED 1
#define PROP_INVENTORYITEM09ANIMATED 1
#define PROP_INVENTORYITEM10ANIMATED 1
#define PROP_INVENTORYITEM11ANIMATED 1
#define PROP_INVENTORYITEM12ANIMATED 1
#define PROP_INVENTORYITEM13ANIMATED 1
#define PROP_INVENTORYITEM14ANIMATED 1
#define PROP_INVENTORYITEM15ANIMATED 1
#define PROP_INVENTORYITEM16ANIMATED 1
#define PROP_INVENTORYEMISSIONTHICKNESS 1.25
#define PROP_INVENTORYUVSWITCH 0
#define PROP_CULLMODE 0
#define PROP_SRCBLEND 1
#define PROP_DSTBLEND 0
#define PROP_BLENDOPRGB 0
#define PROP_SOURCEBLENDALPHA 1
#define PROP_DESTINATIONBLENDALPHA 0
#define PROP_BLENDOPALPHA 0
#define PROP_ALPHATOCOVERAGE 0
#define PROP_IGNOREPROJECTOR 0
#define PROP_COLORMASK 15
#define PROP_STENCILBUFFERREFERENCE 0
#define PROP_STENCILBUFFERREADMASK 255
#define PROP_STENCILBUFFERWRITEMASK 255
#define PROP_STENCILBUFFERCOMPARISON 0
#define PROP_STENCILBUFFERPASSFRONT 0
#define PROP_STENCILBUFFERFAILFRONT 0
#define PROP_STENCILBUFFERZFAILFRONT 0
#define PROP_ZWRITE 1
#define PROP_ZTESTMODE 4
#define PROP_DEPTHOFFSETFACTOR 0
#define PROP_DEPTHOFFSETUNITS 0
#define PROP_FORCENOSHADOWCASTING 0
#define PROP_LIGHTMODES 0
#define PROP_BUMPSCALEANIMATED 0
#define PROP_DETAILNORMALMAPSCALEANIMATED 0
#define PROP_NDLHALFINGCONTROLANIMATED 0
#define PROP_DIRECTSHADOWINTENSITYANIMATED 0
#define PROP_SELFCASTSHADOWSANIMATED 0
#define PROP_POINTSPOTSHADOWINTENSITYANIMATED 0
#define PROP_RAMPOFFSETANIMATED 0
#define PROP_TOGGLESTEPSANIMATED 0
#define PROP_STEPSANIMATED 0
#define PROP_SHADOWMASKSTRENGTHANIMATED 0
#define PROP_SHADOWMASKTEXCHANNELSWITCHANIMATED 0
#define PROP_SHADOWCOLORMAPSTRENGTHANIMATED 0
#define PROP_COLORINGPOINTLIGHTSANIMATED 0
#define PROP_COLORINGDIRECTENVLIGHTSANIMATED 0
#define PROP_TOGGLEMONOCHROMEPIXELLIGHTANIMATED 0
#define PROP_TOGGLEMONOCHROMEENVANIMATED 0
#define PROP_DISTANCEFADEANIMATED 0
#define PROP_INDIRECTSHADOWINTENSITYANIMATED 0
#define PROP_AMBIENTBOOSTANIMATED 0
#define PROP_LIGHTLIMITERANIMATED 0
#define PROP_MAXLIGHTDIRECTANIMATED 0
#define PROP_OCCLUSIONSTRENGTHANIMATED 0
#define PROP_METALLICANIMATED 0
#define PROP_CUTOFFANIMATED 0
#define PROP_BRDFREFLINHERITANISOANIMATED 0
#define PROP_ENABLEGSAAANIMATED 0
#define PROP_GSAAVARIANCEANIMATED 0
#define PROP_GSAATHRESHOLDANIMATED 0
#define PROP_HUESHIFTSPEEDANIMATED 0
#define PROP_TOGGLEHUETEXFORSPEEDANIMATED 0
#define PROP_HUESHIFTRANDOMIZERANIMATED 0
#define PROP_HUEMASKINVERTERANIMATED 0
#define PROP_HUESHIFTBLENDANIMATED 0
#define PROP_SATURATIONANIMATED 0
#define PROP_COLORANIMATED 1
#define PROP_BC7COMPRESSIONFIXANIMATED 0
#define PROP_RAMPCOLORANIMATED 0
#define PROP_MAINTEXUVSWITCHANIMATED 1
#define PROP_BUMPMAPUVSWITCHANIMATED 0
#define PROP_DETAILNORMALMAPUVSWITCHANIMATED 0
#define PROP_DETAILMASKUVSWITCHANIMATED 0
#define PROP_DETAILMASKTEXCHANNELSWITCHANIMATED 0
#define PROP_SPECULARMAPUVSWITCHANIMATED 0
#define PROP_OCCLUSIONMAPUVSWITCHANIMATED 0
#define PROP_METALLICGLOSSMAPUVSWITCHANIMATED 0
#define PROP_REFLECTIONMASKUVSWITCHANIMATED 0
#define PROP_REFLECTIONMASKTEXCHANNELSWITCHANIMATED 0
#define PROP_SSSTHICKNESSMAPUVSWITCHANIMATED 0
#define PROP_MATCAPMASKUVSWITCHANIMATED 0
#define PROP_HUEMASKUVSWITCHANIMATED 0
#define PROP_RIMMASKUVSWITCHANIMATED 0
#define PROP_RIMMASKTEXCHANNELSWITCHANIMATED 0
#define PROP_ANISODIRUVSWITCHANIMATED 0
#define PROP_ANISOTROPYANIMATED 0
#define PROP_ANISOFLICKERFIXANIMATED 0
#define PROP_ANISOFLICKERFIXOFFSETANIMATED 0
#define PROP_SPECSHADOWMASKVARANIMATED 0
#define PROP_SPECSHADOWMASKPOWERANIMATED 0
#define PROP_SPECULARTINTANIMATED 0
#define PROP_SPECULARCOLORANIMATED 0
#define PROP_HIGHLIGHTSMOOTHNESSANIMATED 0
#define PROP_HIGHLIGHTOFFSETANIMATED 0
#define PROP_ANISOSCALEANIMATED 0
#define PROP_ANISOSHARPENINGANIMATED 0
#define PROP_BLINNTOANISOANIMATED 0
#define PROP_SPECULARSETTINGANIMATED 0
#define PROP_SUBSURFACEDISTORTIONMODIFIERANIMATED 0
#define PROP_SSSPOWERANIMATED 0
#define PROP_SSSTINTANIMATED 0
#define PROP_SSSSCALEANIMATED 0
#define PROP_SSSMAPMODEANIMATED 0
#define PROP_SSSTHICKNESSINVANIMATED 0
#define PROP_SSSSETTINGANIMATED 0
#define PROP_SSSTOGGLEANIMATED 0
#define PROP_SSSCOLORANIMATED 0
#define PROP_MATCAPR1TOGGLEANIMATED 0
#define PROP_MATCAPR1SMOOTHNESSANIMATED 0
#define PROP_MATCAPR1COLORANIMATED 0
#define PROP_MATCAPR1INTENSITYANIMATED 0
#define PROP_MATCAPR1TINTANIMATED 0
#define PROP_MATCAPR1MASKINVERTANIMATED 0
#define PROP_MATCAPR1MODEANIMATED 0
#define PROP_MATCAPR1BLENDINGANIMATED 0
#define PROP_MATCAPG2TOGGLEANIMATED 0
#define PROP_MATCAPG2SMOOTHNESSANIMATED 0
#define PROP_MATCAPG2COLORANIMATED 0
#define PROP_MATCAPG2INTENSITYANIMATED 0
#define PROP_MATCAPG2TINTANIMATED 0
#define PROP_MATCAPG2MASKINVERTANIMATED 0
#define PROP_MATCAPG2MODEANIMATED 0
#define PROP_MATCAPG2BLENDINGANIMATED 0
#define PROP_MATCAPB3TOGGLEANIMATED 0
#define PROP_MATCAPB3SMOOTHNESSANIMATED 0
#define PROP_MATCAPB3COLORANIMATED 0
#define PROP_MATCAPB3INTENSITYANIMATED 0
#define PROP_MATCAPB3TINTANIMATED 0
#define PROP_MATCAPB3MASKINVERTANIMATED 0
#define PROP_MATCAPB3MODEANIMATED 0
#define PROP_MATCAPB3BLENDINGANIMATED 0
#define PROP_MATCAPA4TOGGLEANIMATED 0
#define PROP_MATCAPA4SMOOTHNESSANIMATED 0
#define PROP_MATCAPA4COLORANIMATED 0
#define PROP_MATCAPA4INTENSITYANIMATED 0
#define PROP_MATCAPA4TINTANIMATED 0
#define PROP_MATCAPA4MASKINVERTANIMATED 0
#define PROP_MATCAPA4MODEANIMATED 0
#define PROP_MATCAPA4BLENDINGANIMATED 0
#define PROP_IGNORENORMALSMATCAPANIMATED 0
#define PROP_MATCAPVIEWDIRANIMATED 0
#define PROP_RIMDIRECTIONTOGGLEANIMATED 0
#define PROP_RIMFRESNELBIASANIMATED 0
#define PROP_RIMFRESNELSCALEANIMATED 0
#define PROP_RIMFRESNELPOWERANIMATED 0
#define PROP_RIMOFFSETANIMATED 0
#define PROP_RIMPOWERANIMATED 0
#define PROP_RIMSPECLIGHTSMOOTHNESSANIMATED 0
#define PROP_RIMSPECTOGGLEANIMATED 0
#define PROP_RIMTINTANIMATED 0
#define PROP_RIMOPACITYANIMATED 0
#define PROP_RIMFACECULLINGANIMATED 0
#define PROP_RIMTOGGLEANIMATED 0
#define PROP_RIMCOLORANIMATED 0
#define PROP_RIMLIGHTREFLINHERITANISOANIMATED 0
#define PROP_CUBEMAPINTENSITYANIMATED 0
#define PROP_IGNORENORMALSCUBEMAPANIMATED 0
#define PROP_GLOSSINESSANIMATED 0
#define PROP_SPECULARHIGHLIGHTSANIMATED 0
#define PROP_WORKFLOWSWITCHANIMATED 0
#define PROP_SHADOWRIMRANGEANIMATED 0
#define PROP_SHADOWRIMSHARPNESSANIMATED 0
#define PROP_SHADOWRIMOPACITYANIMATED 0
#define PROP_RIMHUESPEEDANIMATED 0
#define PROP_RIMSWITCHANIMATED 0
#define PROP_EMISSIVERIMCOLORANIMATED 0
#define PROP_FLIPBOOKTOGGLEANIMATED 0
#define PROP_FLIPBOOKUVSWITCHANIMATED 0
#define PROP_FLIPBOOKMODEANIMATED 0
#define PROP_ROTATEFLIPBOOKANIMATED 0
#define PROP_FLIPBOOKAUDIOLINKTOGGLEANIMATED 0
#define PROP_COLUMNSANIMATED 0
#define PROP_ROWSANIMATED 0
#define PROP_MAXFRAMESANIMATED 0
#define PROP_SPEEDANIMATED 0
#define PROP_FLIPBOOKTINTANIMATED 0
#define PROP_FLIPBOOKCOLORANIMATED 0
#define PROP_FLIPBOOKUVSHIFTANIMATED 0
#define PROP_EMISSIONMAPUVSWITCHANIMATED 0
#define PROP_EMISSIONTINTANIMATED 0
#define PROP_EMISSIONLIGHTSCALEANIMATED 0
#define PROP_EMISSIONCOLORANIMATED 0
#define PROP_EMISSIONSCROLLMASKUVSWITCHANIMATED 0
#define PROP_EMISSIONSCROLLMASKTEXCHANNELSWITCHANIMATED 0
#define PROP_EMISSIONSCROLLCOLORANIMATED 0
#define PROP_EMISSIONSCROLLTOGGLEANIMATED 0
#define PROP_NOISETEXTUREUVSWITCHANIMATED 0
#define PROP_EMISSIONSCROLLUVSWITCHANIMATED 0
#define PROP_NOISESPEEDANIMATED 0
#define PROP_EMIOSSIONSCROLLSPEEDANIMATED 0
#define PROP_NOISEVECTORXYANIMATED 0
#define PROP_VECTORXYANIMATED 0
#define PROP_IGNORENORMALSESV2ANIMATED 0
#define PROP_ESVORONOISPEEDANIMATED 0
#define PROP_ESVORONOISCALEANIMATED 0
#define PROP_ESRENDERMETHODANIMATED 1
#define PROP_ESCOORDINATESANIMATED 0
#define PROP_AUDIOLINKSWITCHANIMATED 0
#define PROP_ESSHARPNESSANIMATED 0
#define PROP_ESSIZEANIMATED 0
#define PROP_ESSPEEDANIMATED 0
#define PROP_ESSCROLLOFFSETANIMATED 0
#define PROP_ESLEVELOFFSETANIMATED 0
#define PROP_AUDIOLINKBANDHISTORYANIMATED 0
#define PROP_AUDIOBANDINTENSITYANIMATED 0
#define PROP_WAVEFORMCOORDINATESANIMATED 0
#define PROP_WAVEFORMUVSHIFTANIMATED 0
#define PROP_WAVEFORMROTATIONANIMATED 0
#define PROP_WAVEFORMTHICKNESSANIMATED 0
#define PROP_AUDIOLINKWAVEFORMMIRRORTOGGLEANIMATED 0
#define PROP_AUDIOLINKCOLORANIMATED 0
#define PROP_AUDIOHUESPEEDANIMATED 0
#define PROP_EMISSIONSCROLLTINTANIMATED 0
#define PROP_GLOSSYREFLECTIONSANIMATED 0
#define PROP_TOGGLEDISNEYDIFFUSEANIMATED 0
#define PROP_SPECULARTOGGLEANIMATED 0
#define PROP_MODEANIMATED 0
#define PROP_MODECUSTOMANIMATED 0
#define PROP_USEINVENTORYANIMATED 0
#define PROP_INVENTORYSTRIDEANIMATED 0
#define PROP_INVENTORYRENAMEPROPERTIESANIMATED 0
#define PROP_EMISSIVEDISSOLVECOLORANIMATED 0
#define PROP_INVENTORYEMISSIONTHICKNESSANIMATED 0
#define PROP_INVENTORYUVSWITCHANIMATED 0
#define PROP_DITHERMASKUVSWITCHANIMATED 0
#define PROP_DITHERTEXTUREUVSWITCHANIMATED 0
#define PROP_DITHERTEXTURETOGGLEANIMATED 0
#define PROP_DITHERALPHATOGGLEANIMATED 0
#define PROP_ENDDITHERINGFADEANIMATED 0
#define PROP_STARTDITHERINGFADEANIMATED 0
#define PROP_DITHERTEXTURETILINGANIMATED 0
#define PROP_TOGGLELTCGIDIFFUSEANIMATED 0
#define PROP_TOGGLELTCGISPECULARANIMATED 0
#define PROP_DECALTOGGLEANIMATED 0
#define PROP_DECAL1MODEANIMATED 0
#define PROP_ROTATEDECAL1ANIMATED 0
#define PROP_DECAL1AUDIOLINKTOGGLEANIMATED 0
#define PROP_DECAL1WRAPMODEANIMATED 0
#define PROP_DECAL1UVSWITCHANIMATED 0
#define PROP_DECAL1TINTANIMATED 0
#define PROP_DECAL1COLORANIMATED 0
#define PROP_DECAL2MODEANIMATED 0
#define PROP_ROTATEDECAL2ANIMATED 0
#define PROP_DECAL2AUDIOLINKTOGGLEANIMATED 0
#define PROP_DECAL2WRAPMODEANIMATED 0
#define PROP_DECAL2UVSWITCHANIMATED 0
#define PROP_DECAL2TINTANIMATED 0
#define PROP_DECAL2COLORANIMATED 0
#define PROP_DECAL3MODEANIMATED 0
#define PROP_ROTATEDECAL3ANIMATED 0
#define PROP_DECAL3AUDIOLINKTOGGLEANIMATED 0
#define PROP_DECAL3WRAPMODEANIMATED 0
#define PROP_DECAL3UVSWITCHANIMATED 0
#define PROP_DECAL3TINTANIMATED 0
#define PROP_DECAL3COLORANIMATED 0
#define PROP_DECAL4MODEANIMATED 0
#define PROP_ROTATEDECAL4ANIMATED 0
#define PROP_DECAL4AUDIOLINKTOGGLEANIMATED 0
#define PROP_DECAL4WRAPMODEANIMATED 0
#define PROP_DECAL4UVSWITCHANIMATED 0
#define PROP_DECAL4TINTANIMATED 0
#define PROP_DECAL4COLORANIMATED 0
#define PROP_DECALUVSHIFTANIMATED 0
#define PROP_DECALMASKUVSWITCHANIMATED 0
ENDCG
    SubShader
    {
        CGINCLUDE
        #pragma target 5.0
        #pragma only_renderers d3d11 glcore gles3 vulkan nomrt
        #pragma vertex vert
        #pragma fragment frag
        ENDCG
        
        Tags { "RenderType"="Opaque" 
               "Queue"="Geometry+0" 
               "LTCGI"="_LTCGI" 
               //"IgnoreProjector"="True"      // Override tags/editor toggle doesn't work on these
               //"ForceNoShadowCasting"="True" // Use the optimizer to lock in, which will uncomment if they're used
             }
        
        Cull [_CullMode]
        ZTest [_ZTestMode]
        ColorMask [_ColorMask]
        Offset [_DepthOffsetFactor], [_DepthOffsetUnits]
        AlphaToMask [_AlphatoCoverage]
        
        Stencil
        {
            Ref [_StencilBufferReference]
            ReadMask [_StencilBufferReadMask]
            WriteMask [_StencilBufferWriteMask]
            Comp [_StencilBufferComparison]
            Pass [_StencilBufferPassFront]
            Fail [_StencilBufferFailFront]
            ZFail [_StencilBufferZFailFront]
        }

        Pass
        {
            Name "FORWARDBASE"
            Tags { "LightMode" = "ForwardBase" }
            ZWrite [_ZWrite]
            BlendOp [_BlendOpRGB], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SourceBlendAlpha] [_DestinationBlendAlpha]

            CGPROGRAM
            #pragma multi_compile_fwdbase
            #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma multi_compile _ VERTEXLIGHT_ON
            #pragma skip_variants DYNAMICLIGHTMAP_ON LIGHTMAP_ON LIGHTMAP_SHADOW_MIXING DIRLIGHTMAP_COMBINED
            #pragma skip_variants SHADOWS_DEPTH SHADOWS_SOFT SHADOWS_SHADOWMASK

//            #pragma shader_feature_local LTCGI
            
            #ifndef UNITY_PASS_FORWARDBASE
                #define UNITY_PASS_FORWARDBASE
            #endif
            
#include "Base.cginc"
            ENDCG
        }

        Pass
        {
            Name "FORWARDADD"
            Tags { "LightMode" = "ForwardAdd" }
            Fog
            {
                Color (0,0,0,0)
            }
            ZWrite Off
            ZTest LEqual
            BlendOp [_BlendOpRGB], [_BlendOpAlpha]
            Blend [_SrcBlend] One

            CGPROGRAM
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma skip_variants LIGHTPROBE_SH DYNAMICLIGHTMAP_ON LIGHTMAP_ON LIGHTMAP_SHADOW_MIXING DIRLIGHTMAP_COMBINED
            #pragma skip_variants SHADOWS_SHADOWMASK
            
            #ifndef UNITY_PASS_FORWARDADD
                #define UNITY_PASS_FORWARDADD
            #endif
            
#include "Base.cginc"
            ENDCG
        }

        Pass
        {
            Name "SHADOWCASTER"
            Tags { "LightMode"="ShadowCaster" }
            AlphaToMask Off
            ZWrite On
            ZTest LEqual

            CGPROGRAM
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing
            
            #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma skip_variants LIGHTPROBE_SH DYNAMICLIGHTMAP_ON LIGHTMAP_ON LIGHTMAP_SHADOW_MIXING DIRLIGHTMAP_COMBINED
            #pragma skip_variants SHADOWS_DEPTH SHADOWS_SCREEN SHADOWS_CUBE SHADOWS_SOFT SHADOWS_SHADOWMASK
            
            #ifndef UNITY_PASS_SHADOWCASTER
                #define UNITY_PASS_SHADOWCASTER
            #endif

#include "Shadowcaster.cginc"
            
            ENDCG
        }
    }
    Fallback "Standard"
}

