#ifndef BASE_INCLUDED
#define BASE_INCLUDED

UNITY_DECLARE_TEX2D(_MainTex);
float4 _MainTex_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_ToonRamp);
UNITY_DECLARE_TEX2D_NOSAMPLER(_ShadowMask);
UNITY_DECLARE_TEX2D_NOSAMPLER(_ShadowColorMap);
UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
float4 _BumpMap_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_HueMask);
float4 _HueMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailNormalMap);
float4 _DetailNormalMap_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailMask);
float4 _DetailMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
float4 _OcclusionMap_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
float4 _MetallicGlossMap_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_ReflectionMask);
float4 _ReflectionMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_RimMask);
float4 _RimMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_AnisoDir);
float4 _AnisoDir_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Decal1);
float4 _Decal1_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Decal2);
float4 _Decal2_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Decal3);
float4 _Decal3_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Decal4);
float4 _Decal4_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_DecalMask);
float4 _DecalMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Flipbook);
float4 _Flipbook_ST;
samplerCUBE _Cubemap;
SamplerState sampler_linear_repeat;
SamplerState sampler_linear_clamp;
SamplerState sampler_trilinear_repeat;
SamplerState sampler_point_repeat;
//
int _ShaderOptimizerEnabled;
half _BumpScale;
half _DetailNormalMapScale;
int _DetailMaskTexChannelSwitch;
half _NdLHalfingControl;
half _DirectShadowIntensity;
half _SelfCastShadows;
half _PointSpotShadowIntensity;
half _RampOffset;
int _ToggleSteps;
int _Steps;
int _ShadowMaskinvert;
half _ShadowMaskStrength;
int _ShadowMaskTexChannelSwitch;
half _ShadowColorMapStrength;
half _ColoringPointLights;
half _ColoringDirectEnvLights;
int _ToggleMonochromePixelLight;
int _ToggleMonochromeEnv;
fixed3 _DistanceFade; //(min, max, strength)
half _IndirectShadowIntensity;
half _AmbientBoost;
int _LightLimiter;
half _MaxLightDirect;
half _OcclusionStrength;
half _Metallic; //dont forget to do (GammaToLinearSpaceExact(float(1))) on all calls of this property
//#define float(1) GammaToLinearSpaceExact(float(1)) //would that work ?
half _Cutoff;
int _BRDFReflInheritAniso;
int _EnableGSAA;
half _GSAAVariance;
half _GSAAThreshold;
//Hue Shift
half _HueShiftSpeed;
half _ToggleHueTexforSpeed;
half _HueShiftRandomizer;
int _HueMaskinverter;
half _HueShiftblend;
//Desaturation
half _Saturation;
//Colors
fixed4 _Color;
int _BC7compressionFix;
fixed4 _RampColor;
//UV Switches
int _MainTexUVSwitch;
int _BumpMapUVSwitch;
int _DetailNormalMapUVSwitch;
int _DetailMaskUVSwitch;
int _SpecularMapUVSwitch;
int _OcclusionMapUVSwitch;
int _MetallicGlossMapUVSwitch;
int _ReflectionMaskUVSwitch;
int _ReflectionMaskTexChannelSwitch;
int _SSSThicknessMapUVSwitch;
int _MatcapMaskUVSwitch;
int _HueMaskUVSwitch;
int _RimMaskUVSwitch;
int _AnisoDirUVSwitch;
//Specular Highlights
UNITY_DECLARE_TEX2D_NOSAMPLER(_SpecularMap);
float4 _SpecularMap_ST;
half _Anisotropy;
int _AnisoFlickerFix;
half _AnisoFlickerFixOffset;
int _SpecShadowMaskVar;
half _SpecShadowMaskPower;
half _SpecularTint;
fixed4 _SpecularColor;
half _HighlightSmoothness;
half _HighlightOffset;
half _AnisoScale;
int _AnisoSharpening;
half _BlinntoAniso;
int _SpecularSetting;
//SSS
UNITY_DECLARE_TEX2D_NOSAMPLER(_SSSThicknessMap);
float4 _SSSThicknessMap_ST;
half _SubsurfaceDistortionModifier;
half _SSSPower;
half _SSSTint;
half _SSSScale;
int _SSSMapMode;
int _SSSThicknessinv;
int _SSSSetting;
int _SSSToggle;
fixed4 _SSSColor;
//Matcap
UNITY_DECLARE_TEX2D_NOSAMPLER(_MatcapMask);
float4 _MatcapMask_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MatcapR1);
float4 _MatcapR1_ST;
int _MatcapR1Toggle;
half _MatcapR1smoothness;
fixed4 _MatcapR1Color;
half _MatcapR1Intensity;
half _MatcapR1Tint;
int _MatcapR1Mode;
half _MatcapR1Blending;
int _MatcapR1MaskInvert;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MatcapG2);
float4 _MatcapG2_ST;
int _MatcapG2Toggle;
half _MatcapG2smoothness;
fixed4 _MatcapG2Color;
half _MatcapG2Intensity;
half _MatcapG2Tint;
int _MatcapG2Mode;
half _MatcapG2Blending;
int _MatcapG2MaskInvert;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MatcapB3);
float4 _MatcapB3_ST;
int _MatcapB3Toggle;
half _MatcapB3smoothness;
fixed4 _MatcapB3Color;
half _MatcapB3Intensity;
half _MatcapB3Tint;
int _MatcapB3Mode;
half _MatcapB3Blending;
int _MatcapB3MaskInvert;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MatcapA4);
float4 _MatcapA4_ST;
int _MatcapA4Toggle;
half _MatcapA4smoothness;
fixed4 _MatcapA4Color;
half _MatcapA4Intensity;
half _MatcapA4Tint;
int _MatcapA4Mode;
half _MatcapA4Blending;
int _MatcapA4MaskInvert;
int _IgnoreNormalsMatcap;
int _MatcapViewDir;
//RimLight
int _RimMaskTexChannelSwitch;
int _RimDirectionToggle;
int _RimLightMaskinv;
half _RimFresnelBias;
half _RimFresnelScale;
half _RimFresnelPower;
half _RimOffset;
half _RimPower;
half _RimSpecLightsmoothness;
int _RimSpecToggle;
half _RimTint;
half _RimOpacity;
int _RimFaceCulling;
int _RimToggle;
fixed4 _RimColor;
int _RimLightReflInheritAniso;
//BRDF
half _CubemapIntensity;
int _IgnoreNormalsCubemap;
half _Glossiness;
half _SpecularHighlights;
int _WorkflowSwitch;
int _ReflectionMaskInvert;
//Shadow/Emissive Rim
half _ShadowRimRange;
half _ShadowRimSharpness;
half _ShadowRimOpacity;
half _RimHueSpeed;
int _RimSwitch;
fixed4 _EmissiveRimColor;
//Flipbook
int _FlipbookToggle;
int _FlipbookUVSwitch;
half _RotateFlipbook;
int _Columns;
int _Rows;
int _MaxFrames;
int _Speed;
half _FlipbookTint;
int _FlipbookMode;
fixed4 _FlipbookColor;
int _FlipbookUVShift;
int _FlipbookAudioLinkToggle;
//BasicEmission
UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionMap);
float4 _EmissionMap_ST;
int _EmissionMapUVSwitch;
half _EmissionTint;
half _EmissionLightscale;
fixed4 _EmissionColor;
//EmissionScroll shares
UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionScrollMask);
float4 _EmissionScrollMask_ST;
int _EmissionScrollMaskUVSwitch;
int _EmissionScrollMaskTexChannelSwitch;
fixed4 _EmissionscrollColor;
int _EmissionScrollToggle;
//EmissionScroll V1
UNITY_DECLARE_TEX2D_NOSAMPLER(_NoiseTexture);
int _NoiseTextureUVSwitch;
float4 _NoiseTexture_ST;
UNITY_DECLARE_TEX2D_NOSAMPLER(_Emissionscroll);
int _EmissionscrollUVSwitch;
float4 _Emissionscroll_ST;
half _NoiseSpeed;
half _Emiossionscrollspeed;
float2 _NoiseVectorXY;
float2 _VectorXY;
//Emissionscroll V2
int _IgnoreNormalsESv2;
half _ESVoronoiSpeed;
half _ESVoronoiScale;
int _ESRenderMethod;
half2 _ESCoordinates;
int _AudioLinkSwitch;
half _ESSharpness;
half _ESSize;
half _ESSpeed;
half _ESScrollOffset;
half _ESLevelOffset;
int _AudioLinkBandHistory;
half4 _AudioBandIntensity;
half4 _WaveformCoordinates;
half _WaveformRotation;
half _WaveformThickness;
int _AudioLinkWaveformMirrorToggle;
fixed4 _AudioLinkColor;
half _AudioHueSpeed;
half _EmissionscrollTint;
int _WaveformUVShift;
//Toggles
int _GlossyReflections;
int _ToggleDisneyDiffuse;
int _SpecularToggle;
int _Mode;
int _ModeCustom;
int _COLORCOLOR; //= ToggleAdvanced
//Outline
#ifdef UNITY_PASS_FORWARD_OUTLINE
float3 _OutlineColor;
int _OutlineMode;
half _OutlineTint;
half _OutlineHueSpeed;
half _OutlineDepthFadeDistance;
half _OutlineDistancethickening;
Texture2D _OutlineMask;
SamplerState sampler_OutlineMask;
float4 _OutlineMask_ST;
half _OutlineWidth;
int _OutlineMaskUVSwitch;
#endif
//LTCGI
int _LTCGI; //local keyword
int _ToggleLTCGIDiffuse;
int _ToggleLTCGISpecular;
//Decals
int _DecalUVShift;
int _DecalToggle;
int _DecalUVSwitch;
fixed4 _Decal1Color;
int _Decal1Mode;
half _Decal1Tint;
half _RotateDecal1;
int _Decal1AudioLinkToggle;
int _Decal1WrapMode;
int _Decal1UVSwitch;
fixed4 _Decal2Color;
int _Decal2Mode;
half _Decal2Tint;
half _RotateDecal2;
int _Decal2AudioLinkToggle;
int _Decal2WrapMode;
int _Decal2UVSwitch;
fixed4 _Decal3Color;
int _Decal3Mode;
half _Decal3Tint;
half _RotateDecal3;
int _Decal3AudioLinkToggle;
int _Decal3WrapMode;
int _Decal3UVSwitch;
fixed4 _Decal4Color;
int _Decal4Mode;
half _Decal4Tint;
half _RotateDecal4;
int _Decal4AudioLinkToggle;
int _Decal4WrapMode;
int _Decal4UVSwitch;
int _DecalMaskUVSwitch;




//Additional Defines
#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)


#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "UnityStandardUtils.cginc"
#include "UnityStandardBRDF.cginc"


struct appdata //VertexInput
{
    float4 vertex : POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float2 uv3 : TEXCOORD3;
    float3 normal : NORMAL;
    float4 tangent : TANGENT;
    fixed4 color : COLOR;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct v2f //VertexOutput
{
    float3 normal : NORMAL;
    float4 pos : SV_POSITION;
    fixed4 color : COLOR;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float2 uv3 : TEXCOORD3;
    float3 worldPos : TEXCOORD4;
    float4 tangent : TEXCOORD5;
    float3 bitangent : TEXCOORD6;
    float3 worldNormal : TEXCOORD7;
    float4 screenPos : TEXCOORD8;
    float4 vertex : TEXCOORD11;
    
    #if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
        UNITY_FOG_COORDS(9)
    #endif
    UNITY_SHADOW_COORDS(10)
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
};
static v2f input;

#include "SharedFunctions.cginc"

v2f vert (appdata v)
{
    v2f o;
    UNITY_INITIALIZE_OUTPUT(v2f, o);
    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_TRANSFER_INSTANCE_ID(v, o);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

    o.uv0 = v.uv0;
    o.uv1 = v.uv1;
    o.uv2 = v.uv2;
    o.uv3 = v.uv3;

    //OUTLINE
    #ifdef UNITY_PASS_FORWARD_OUTLINE
        float2 OutlineMaskUV = v.uv0;
        if (_OutlineMaskUVSwitch == 1)
            OutlineMaskUV = v.uv1;
        else if (_OutlineMaskUVSwitch == 2)
            OutlineMaskUV = v.uv2;
        else if (_OutlineMaskUVSwitch == 3)
            OutlineMaskUV = v.uv3;
        
        float cameraDepthFade = (-UnityObjectToViewPos(v.vertex.xyz).z -_ProjectionParams.y - _OutlineDepthFadeDistance) / 1.0;
        cameraDepthFade = saturate(-cameraDepthFade);
        if (_OutlineDepthFadeDistance == 0)
        {
            cameraDepthFade = 1;
        }
        
        float ObjectToClipPos = UnityObjectToClipPos(v.vertex.xyz).w;
        ObjectToClipPos = min(ObjectToClipPos, _OutlineDistancethickening);
        if (_OutlineDistancethickening == 0)
        {
            ObjectToClipPos = 1;
        }
        
        half OutlineMask = SAMPLE_TEXTURE2D_LOD(_OutlineMask, sampler_OutlineMask, _OutlineMask_ST.xy * OutlineMaskUV + _OutlineMask_ST.zw, 0.0).r;
        
        half OutlineWidth = cameraDepthFade * ObjectToClipPos * OutlineMask * _OutlineWidth;
        
        v.vertex.xyz += (v.normal * OutlineWidth);
    #endif
    //OUTLINE END
    
    
    o.vertex = v.vertex;
    o.normal = v.normal;
    o.pos = UnityObjectToClipPos(v.vertex);
    o.screenPos = ComputeScreenPos(o.pos);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.tangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
    o.tangent.w = v.tangent.w * unity_WorldTransformParams.w; //tangentSign
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    o.bitangent = cross(o.worldNormal , o.tangent.xyz) * o.tangent.w;
    o.color = v.color;

    // Simple inventory handling.
    if (float(0) && float(0) == 0)
    {
        float2 InventoryUV = v.uv0;
        if (float(0) == 1)
            InventoryUV = v.uv1;
        else if (float(0) == 2)
            InventoryUV = v.uv2;
        else if (float(0) == 3)
            InventoryUV = v.uv3;
        
        float inventoryMask = 0;
        InventorySystemSimple(InventoryUV, inventoryMask);
    
        // Apply the inventory mask.
    
        // Set the output variables based on the mask to completely remove it.
        // - Set the clip-space position to one that won't be rendered
        // - Set the vertex alpha to zero
        // - Disable outlines
        o.pos.z =     inventoryMask ? o.pos.z : 1e+9;
        o.worldPos =  inventoryMask ? o.worldPos : 0;
        o.vertex =    inventoryMask ? o.vertex : 1e+9;
        o.color.a =   inventoryMask ? o.color.a : -1;
    }
    
    UNITY_TRANSFER_SHADOW(o, v.uv1.xy);
    UNITY_TRANSFER_FOG(o, o.pos);
    return o;
}

#include "ForwardShadows.cginc"
#include "Utilities.cginc"
#include "AudioLink.cginc"
#include "LightingFunctions.cginc"

//LTCGI
#ifdef LTCGI
    // preamble: include this first to get access to required types
    #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI_structs.cginc"

    // then define the accumulator type and callback functions (can forward-declare functions to keep things tidy)
    // note the function signatures, especially that the accumulator is "inout" so it will keep modifications between calls
    struct accumulator_struct {
        // let your imagination run wild on what to accumulate here...
        float3 diffuse;
        float3 specular;
        float3 worldNormal;
    };
    void callback_diffuse(inout accumulator_struct acc, in ltcgi_output output);
    void callback_specular(inout accumulator_struct acc, in ltcgi_output output);

    // tell LTCGI that we want the V2 API, and which constructs to use
    #define LTCGI_V2_CUSTOM_INPUT accumulator_struct
    #define LTCGI_V2_DIFFUSE_CALLBACK callback_diffuse
    #define LTCGI_V2_SPECULAR_CALLBACK callback_specular
    
    // then include this to finish the deal
    #include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"

    // now we declare LTCGI APIv2 functions for real
    void callback_diffuse(inout accumulator_struct acc, in ltcgi_output output) {

        //Toon styled, this solution is pretty dumb and does not take the closest normal point on the screen
        //instead we get the center of all normal points.
        //also, output.intensity will be a smooth falloff to the lightsource
        //half3 TriDirOne   = normalize(output.input.Lw[0]);
        //half3 TriDirTwo   = normalize(output.input.Lw[1]);
        //half3 TriDirThree = normalize(output.input.Lw[2]);
        //half3 TriDirFour  = normalize(output.input.Lw[3]);
        //half3 LTCGItriDir = normalize(TriDirOne + TriDirTwo + TriDirThree + TriDirFour);
        //
        //half Trindl = dot(LTCGItriDir, acc.worldNormal);
        //half LTCGIndlDiffuse = saturate(Trindl * float(0.5) + float(0.5));
        //half3 LTCGIndlToonRamped = ToonRampSample(LTCGIndlDiffuse);
        //
        //half LTCGIndlDiffuse1 = saturate(output.intensity * float(0.5) + float(0.5));
        //half3 LTCGIndlToonRamped1 = ToonRampSample(LTCGIndlDiffuse1);
        //
        //acc.diffuse += LTCGIndlToonRamped * LTCGIndlDiffuse1 * output.color;
        acc.diffuse += output.intensity * output.color;
    }
    void callback_specular(inout accumulator_struct acc, in ltcgi_output output) {
        // same here, this example one is pretty boring though.
        // you could accumulate intensity separately for example,
        // to emulate total{Specular,Diffuse}Intensity from APIv1
        acc.specular += output.intensity * output.color;
    }
#endif

float4 frag(v2f i, uint facing : SV_IsFrontFace) : SV_Target
{   
    input = i;
    UNITY_SETUP_INSTANCE_ID(i)

    //Normal Maps
    float2 NormalMapMask = NormalMapMaskSample();
    float3 tangentNormal = TangentNormalSample();
    tangentNormal = lerp(float3(0,0,1), tangentNormal, NormalMapMask.g);
    float3 detailedtangentNormal = DetailedTangentNormalSample();
    detailedtangentNormal = lerp(float3(0,0,1), detailedtangentNormal, NormalMapMask.r);
    tangentNormal = BlendNormals(tangentNormal, detailedtangentNormal);
    
    float3 worldNormal = i.worldNormal;
    float3 tangent = i.tangent.xyz;
    float3 bitangent = i.bitangent;
    #ifndef UNITY_PASS_FORWARD_OUTLINE //Make sure we do not negate Outlines
        
        if (!facing)
        {
            worldNormal = -worldNormal;
            tangent = -tangent;
            bitangent = -bitangent;
        }
    #endif

    //Intercept for bentNormals before Normal Mapping
    float3 worldNormalIgnoredNormalMaps = normalize(worldNormal); 
    float3 tangentIgnoredNormalMaps = normalize(cross(bitangent, worldNormalIgnoredNormalMaps));
    float3 bitangentIgnoredNormalMaps = normalize(cross(worldNormalIgnoredNormalMaps, tangentIgnoredNormalMaps));
    
    const float3 calcedNormal = normalize
    (
        tangentNormal.x * tangent +
        tangentNormal.y * bitangent +
        tangentNormal.z * worldNormal
    );
    worldNormal = calcedNormal;
    tangent = normalize(cross(bitangent, worldNormal));
    bitangent = normalize(cross(worldNormal, tangent));


    //Calc anisotropic bent normals
    float3 worldNormalBent = worldNormalIgnoredNormalMaps;
    if (float(0) == 0)
    {
        worldNormalBent = worldNormal;
        tangentIgnoredNormalMaps = tangent;
        bitangentIgnoredNormalMaps = bitangent;
    }
    //Anisotropic normal bending
    const float3 anisotropicDirection = float(0.8) >= 0.0 ? bitangentIgnoredNormalMaps : tangentIgnoredNormalMaps;
    const float3 anisotropicTangent = cross(anisotropicDirection, calcViewDir());
    const float3 anisotropicNormal = cross(anisotropicTangent, anisotropicDirection);
    const float bendFactor = abs(float(0.8)) * saturate(5.0 * 1-(MetallicGlossMapSample().a * float(1))); //use smoothness from below with GSAA or maybe not since it's just a direction
    float3 bentNormal = normalize(lerp(worldNormalBent, anisotropicNormal, bendFactor));
    //Apply bent normals
    half3 bentNormalsForRimLight = worldNormalBent;
    half3 bentNormalsForBRDF = worldNormalBent;
    if (float(0) == 1)
    {
        bentNormalsForBRDF = bentNormal;
    }
    if (float(0))
    {
        bentNormalsForRimLight = bentNormal;
    }

    
    
    //MainTex with Hue Shift
    half4 Maintex = MainTexSample();
    if (float(0)) //This is a workaround to fix the BC7 Compressor bug with Alpha values
        Maintex.a = Maintex.a >= (253.5 / 255.0) ? 1 : Maintex.a;
    Maintex *= _Color;
    half alpha = Maintex.a;

    
    float HueShiftTexForSpeed = 1;
    if (float(1) == 1)
    {
        HueShiftTexForSpeed = HueMaskSamplePoint();
    }
    HueShiftTexForSpeed *= float(0);
    HueShiftTexForSpeed = HueShiftTexForSpeed * _Time.y + float(0);
    float3 HueShift = HSVToRGB(float3(HueShiftTexForSpeed, 1, 1));
    HueShift *= (Maintex.r + Maintex.g + Maintex.b) / 3;
    float HueShiftIF = float(0) + float(0);
    float3 Hue = Maintex.rgb;
    if (HueShiftIF > 0)
    {
        Hue = HueShift;
    }
    
    float HueMask = HueMaskSample();
    if (float(1) == 1)
        HueMask = HueMaskSamplePoint();
    if (float(0) == 1)
        HueMask = 1-HueMask;
    
    HueMask = lerp(0, HueMask, float(0.5));
    Maintex.rgb = lerp(Maintex.rgb, Hue, HueMask);

    //Desaturation
    half desaturateDot = dot(Maintex.rgb, float3(0.299, 0.587, 0.114));
    Maintex.rgb = lerp(Maintex.rgb, desaturateDot, 1-float(0.78));
    
    
    
    //Emission Scroll v1 + v2
    float3 AudioLinkEffect = 0;
    #ifdef UNITY_PASS_FORWARDBASE
    half3 emissionScrollV1 = EmissionScrollV1(Maintex);
    half3 emissionScrollV2 = EmissionScrollV2(tangentNormal.xy, worldNormal, worldNormalIgnoredNormalMaps, Maintex, AudioLinkEffect);
        
    half3 emissionScroll = 0;
    if (float(2) == 1 && float(1) == 1)
    {
        emissionScroll = emissionScrollV1;
    }
    else if (float(2) == 2 && float(1) == 1)
    {
        emissionScroll = emissionScrollV2;
        AudioLinkEffect = 0;
    }
    #endif
    
    
    
    //Add Decals and Flipbook to MainTex and apply Emissive later
    //Doing this step here allows those features to be present on Metallic surfaces
    half3 EmissiveDecal1 = 0, EmissiveDecal2 = 0, EmissiveDecal3 = 0, EmissiveDecal4 = 0, EmissiveFlipbook = 0;
    half4 DecalMask = DecalMaskSample();
    half4 Decal1Color = half4(float4(1,1,1,1).rgb, float4(1,1,1,1).a * DecalMask.r);
    half4 Decal2Color = half4(float4(1,1,1,1).rgb, float4(1,1,1,1).a * DecalMask.g);
    half4 Decal3Color = half4(float4(1,1,1,1).rgb, float4(1,1,1,1).a * DecalMask.b);
    half4 Decal4Color = half4(float4(1,1,1,1).rgb, float4(1,1,1,1).a * DecalMask.a);
    DecalsAndFlipbook(Maintex.rgb, EmissiveDecal1, AudioLinkEffect * float(0), float(0), float(0), float(1), float(0), Decal1Color, float(0), float(0), float(0), false, float4(1,1,0,0), _Decal1);
    DecalsAndFlipbook(Maintex.rgb, EmissiveDecal2, AudioLinkEffect * float(0), float(0), float(0), float(1), float(0), Decal2Color, float(0), float(0), float(0), false, float4(1,1,0,0), _Decal2);
    DecalsAndFlipbook(Maintex.rgb, EmissiveDecal3, AudioLinkEffect * float(0), float(0), float(0), float(1), float(0), Decal3Color, float(0), float(0), float(0), false, float4(1,1,0,0), _Decal3);
    DecalsAndFlipbook(Maintex.rgb, EmissiveDecal4, AudioLinkEffect * float(0), float(0), float(0), float(1), float(0), Decal4Color, float(0), float(0), float(0), false, float4(1,1,0,0), _Decal4);
    DecalsAndFlipbook(Maintex.rgb, EmissiveFlipbook, AudioLinkEffect * float(0), float(0), float(0), 1, float(0), float4(1,1,1,1), float(0), float(0), float(0), true, float4(1,1,0,0), _Flipbook);
    half3 EmissiveDecalsAndFlipbook = EmissiveDecal1 + EmissiveDecal2 + EmissiveDecal3 + EmissiveDecal4 + EmissiveFlipbook;
    
    
    
    //Dot Products, Directions
    const float3 halfVector = Unity_SafeNormalize(calcLightDir() + calcViewDir());
    half ndl = dot(calcLightDir(), worldNormal);
    half ndlDiffuse = saturate(ndl * float(0.5) + float(0.5));
    const half ndh = DotClamped(worldNormal, halfVector);
    const half ndv = dot(worldNormal, calcViewDir());
    const half ndvcorr = CorrectNegativeNdotV(calcViewDir(), worldNormal);
    const half ldh = DotClamped(calcLightDir(), halfVector);

    //Dot Products, Directions for Ambient
    #ifdef UNITY_PASS_FORWARDBASE
        const float3 halfVectorAmbient = normalize(calcLightDirAmbient() + calcViewDir());
        const float3 halfVectorAmbientUnityNormalized = Unity_SafeNormalize(calcLightDirAmbient() + calcViewDir());
        half ndlAmbient = dot(calcLightDirAmbient(), worldNormal);
        half ndlAmbientDiffuse = saturate(ndlAmbient * float(0.5) + float(0.5));
        const half ndhAmbient = DotClamped(worldNormal, halfVectorAmbientUnityNormalized);
        const half ldhAmbient = DotClamped(calcLightDirAmbient(), halfVectorAmbientUnityNormalized);
    #endif
    
    


    
    //##Lighting and Shadows##
    //Pixel Light and Shadow Calculations_______________________________________________________________________________
    LIGHT_ATTENUATION_NO_SHADOW_MUL(lightAttenNoShadows, i, i.worldPos.xyz); //never change lightAttenNoShadows!
    fixed shadowADDLight = shadow;
    shadow *= lightAttenNoShadows;

    half FinalOcclusionMap = lerp(1, OcclusionMapSample(), float(1));
    
    float3 ToonRampTexNDL = ToonRampSample(ndlDiffuse); //NdL Toon Ramped
    #ifdef UNITY_PASS_FORWARDADD
        ToonRampTexNDL = lerp(1, ToonRampTexNDL, float(1));
    #else
        ToonRampTexNDL = lerp(1, ToonRampTexNDL, float(1));
    #endif
    
    float3 ToonRampTexATTEN = ToonRampSample(shadow); //Shadow Caster Toon Ramped
    #ifndef DIRECTIONAL
        ToonRampTexATTEN = float3(1,1,1);
    #endif
    float3 ToonRampTexATTENLerpIntensity = lerp(1, ToonRampTexATTEN, float(1));

    float3 NdLminAttenShadow = min(ToonRampTexATTENLerpIntensity, ToonRampTexNDL);
    
    
    float SCSNdL = ndlDiffuse * float(8); //For Step Based Cell Shading NdL
    SCSNdL = floor(SCSNdL);
    SCSNdL = saturate(SCSNdL / (float(8) - 1));
    float SCSNdLNoIntensity = SCSNdL;
    #ifdef UNITY_PASS_FORWARDADD
        SCSNdL = lerp(1, SCSNdL, float(1));
    #else
        SCSNdL = lerp(1, SCSNdL, float(1));
    #endif

    float StepShadow = 1;
    #ifdef DIRECTIONAL //For Step Based Cell Shading Atten
        StepShadow = shadow;
    #endif
    float SCSAtten = StepShadow * float(8);
    SCSAtten = floor(SCSAtten);
    SCSAtten = saturate(SCSAtten / (float(8) - 1));
    float SCSAttenNoIntensity = SCSAtten;
    SCSAtten = lerp(1, SCSAtten, float(1));

    float3 SCS = min(SCSNdL, SCSAtten);

    float3 PreFinalShadowCalc = 0;
    float3 ProFinalShadowCalcOutline = 0;
    if (float(1) == 1)
    {
        PreFinalShadowCalc = SCS;
        ProFinalShadowCalcOutline = SCSNdL;
    }
    else
    {
        PreFinalShadowCalc = NdLminAttenShadow;
        ProFinalShadowCalcOutline = ToonRampTexNDL;
    }

    float2 ShadowMask = ShadowMaskSample(); //Shadow Mask
    if (_ShadowMaskinvert == 1)
    {
        ShadowMask = 1-ShadowMask;
    }
    ShadowMask *= float(1); //.r = PixelShadowMask, .g = IndirectShadowMask
    
    PreFinalShadowCalc = lerp(1, PreFinalShadowCalc, ShadowMask.r);
    ProFinalShadowCalcOutline = lerp(1, ProFinalShadowCalcOutline, ShadowMask.r);

    half3 RampColor = lerp(float4(1,0,0.2754452,0), ShadowColorMapSample(), max(max(ShadowColorMapSample().r, ShadowColorMapSample().g), ShadowColorMapSample().b) * float(1));

    float3 ToonRampPixelShadows = 0;
    #ifndef DIRECTIONAL
        #ifdef UNITY_PASS_FORWARDADD
        ToonRampPixelShadows = lerp(PreFinalShadowCalc, RampColor, float(0));
        ToonRampPixelShadows = lerp(ToonRampPixelShadows, 1, LinearRgbToLuminance(PreFinalShadowCalc));
        ToonRampPixelShadows *= lerp(1, shadowADDLight, float(1)) * lightAttenNoShadows;
        #endif
    #else
        #ifndef UNITY_PASS_FORWARD_OUTLINE
            ToonRampPixelShadows = lerp(PreFinalShadowCalc, RampColor, float(0));
            ToonRampPixelShadows = lerp(ToonRampPixelShadows, 1, LinearRgbToLuminance(PreFinalShadowCalc));
        #else
            ToonRampPixelShadows = lerp(ProFinalShadowCalcOutline, RampColor, float(0));
            ToonRampPixelShadows = lerp(ToonRampPixelShadows, 1, LinearRgbToLuminance(ProFinalShadowCalcOutline));
        #endif
    #endif
    
    float3 PixelLightCalculation = _LightColor0.rgb;
    if (float(0) == 1)
    {
        PixelLightCalculation = LinearRgbToLuminance(_LightColor0.rgb);
    }
    float3 RGBtoMonochromePixelLight = PixelLightCalculation;
    
    
    
    //Ambient Light and Shadow Calculation______________________________________________________________________________
    #ifndef UNITY_PASS_FORWARDBASE
        float3 AmbientLight = 0.0;
        float3 AmbientLightBoosted = 0.0;
        float AmbientLightLuminanced = 0.0;
        float SCSAmbient = 0.0;
        float3 ToonRampTexAmbient = 0.0;
        half ndlAmbient = 0.0;
        float3 AmbientShadows = 0.0;
    #else
        float3 ToonRampTexAmbient = ToonRampSample(ndlAmbientDiffuse);
        
        float SCSAmbient = ndlAmbientDiffuse * float(8);
        SCSAmbient = floor(SCSAmbient);
        SCSAmbient = saturate(SCSAmbient / (float(8) - 1));
        
        float3 AmbientShadows = 0;
        if (float(1) == 1)
        {
            AmbientShadows = SCSAmbient;
        }
        else
        {
            AmbientShadows = ToonRampTexAmbient;
        }
        AmbientShadows = lerp(1, AmbientShadows, ShadowMask.g);
        float AmbientShadowsLuminanced = LinearRgbToLuminance(AmbientShadows);
        AmbientShadows = lerp(AmbientShadows, RampColor, float(0));
        AmbientShadows = lerp(AmbientShadows, 1, AmbientShadowsLuminanced);
        AmbientShadows = lerp(1, AmbientShadows, max(float(0.5), 0.000001));
        
        //Diffuse Ambient Light calculation with low frequency boost
        float3 AmbientLight = float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w) + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
        float3 AmbientLightBoosted = lerp(AmbientLight * float(1.5), AmbientLight, saturate(max(max(AmbientLight.r, AmbientLight.g), AmbientLight.b)));
        float AmbientLightLuminanced = LinearRgbToLuminance(AmbientLightBoosted);
        if (float(0) == 1)
        {
            AmbientLight = AmbientLightLuminanced;
        }
        AmbientShadows *= FinalOcclusionMap;
    #endif


    //BRDF diffuseTerm, mul by Pixel and Vertex Lighting only
    //We also change Ambient light to BetterSH9 to get a more Standard like look, we could also DisneyDiffuse Ambientlight instead
    //does not inherit float(0.5) nor float(0.5) and no shadow coloring, not sure if i want to add that here
    if (float(1) == 1 && float(1) == 1 && float(1) == 1)
    {
        float ndldiffuseTerm = max(ndl, 0);
        half smoothnessdiffuseTerm = MetallicGlossMapSample().a * float(1); //GSAA smoothness instead ? probably not
        float perceptualRoughnessdiffuseTerm = SmoothnessToPerceptualRoughness(smoothnessdiffuseTerm);
        half diffuseTerm = DisneyDiffuse(ndvcorr, ndldiffuseTerm, ldh, perceptualRoughnessdiffuseTerm) * ndldiffuseTerm * shadow;
        half3 finalDiffuseTerm = lerp(ToonRampPixelShadows, diffuseTerm, ReflectionMaskSample());//Mask diffuseTerm over ReflectionMask
        PixelLightCalculation *= finalDiffuseTerm;

        #ifdef UNITY_PASS_FORWARDBASE
        AmbientLight = lerp(AmbientLightBoosted * AmbientShadows, BetterSH9(float4(worldNormal,1)), ReflectionMaskSample());
        #endif
    }
    else
    {
        PixelLightCalculation *= ToonRampPixelShadows;

        #ifdef UNITY_PASS_FORWARDBASE
        AmbientLight = AmbientLightBoosted * AmbientShadows;
        #endif
    }
    

    
    //Final Light with Grayscaled Clamp_________________________________________________________________________________
    //We need to do the limiter three times to max each individual lightsource first and then combine it in a final limiter
    float3 DirectionalLightNoShadows = 0;
    #ifdef DIRECTIONAL
        DirectionalLightNoShadows = RGBtoMonochromePixelLight;
    #endif
    float DirectionalLightNoShadowsMaxChain = max(max(DirectionalLightNoShadows.r, DirectionalLightNoShadows.g), DirectionalLightNoShadows.b);
    float LightLimiterTogglePixelLight = DirectionalLightNoShadowsMaxChain * float(1);
    float3 ForFinalPixelLightCalculation = PixelLightCalculation;
    if (LightLimiterTogglePixelLight > 1) //Source: https://github.com/ACIIL/ACLS-Shader
    {
        ForFinalPixelLightCalculation = max(ForFinalPixelLightCalculation, float3(0,0,0) + 1e-10) / DirectionalLightNoShadowsMaxChain;
    }

    #ifdef UNITY_PASS_FORWARDBASE
        float AmbientLightMaxChain = max(max(AmbientLightBoosted.r, AmbientLightBoosted.g), AmbientLightBoosted.b);
        float LightLimiterToggleAmbientLight = AmbientLightMaxChain * float(1);
        if (LightLimiterToggleAmbientLight > 1) //Source: https://github.com/ACIIL/ACLS-Shader
        {
            AmbientLight = max(AmbientLight, float3(0,0,0) + 1e-10) / AmbientLightMaxChain;
        }
    #endif
    
    float3 CombinedLighting = ForFinalPixelLightCalculation + AmbientLight;
    float3 DirectionalLight = 0;
    #ifdef DIRECTIONAL
        DirectionalLight = ForFinalPixelLightCalculation;
    #endif
    float3 CombinedLightingDirectional = DirectionalLight + AmbientLight;
    float CombinedLightingLuminanced = LinearRgbToLuminance(CombinedLightingDirectional);
    float LightLimiterToggleCombinedLighting = CombinedLightingLuminanced * float(1);
    if (LightLimiterToggleCombinedLighting > 1) //Source: https://github.com/ACIIL/ACLS-Shader
    {
        CombinedLighting = max(CombinedLighting, float3(0,0,0) + 1e-10) / CombinedLightingLuminanced;
    }
    CombinedLighting *= float(1);
    float3 PreFinalLight = CombinedLighting;
    float3 FinalLight = CombinedLighting * Maintex;
    
    
    //Diffuse + Specular Vertex Lighting________________________________________________________________________________
    half3 DiffuseVertexLighting = 0; //Diffuse Vertex Lights
    half DiffuseVertexLightingLuminanced = 0; //Diffuse Vertex Lights luminanced for features that depend on always being luminanced
    half3 DiffuseVertexLightingNoMainTexMul = 0; //Diffuse Vertex Lights without MainTex
    half3 VertexLightSSS = 0; // Vertex Light SubsurfaceScattering
    half3 VertexLightSpecular = 0; //Specular Highlights Aniso and BRDF Vertex Lights
    half4 VLShadowsPre = 0;

    //BRDF stuff
    half3 specColor = 0;
    half smoothness = float(1) * MetallicGlossMapSample().a;
    half smoothnessRimLight = float(0); //For Rimlight
    half smoothnessAdditionalSH = float(0) * SpecularMapSample().a; //For Additional Specular Highlights in Speuclar workflow
    //GSAA
    if (float(1) == 1)
    {
        smoothness = GSAA_Filament(bentNormalsForBRDF, 1-smoothness);
        smoothnessRimLight = GSAA_Filament(bentNormalsForRimLight, 1-smoothnessRimLight);
        smoothnessAdditionalSH = GSAA_Filament(worldNormal, 1-smoothnessAdditionalSH);
    }
    half oneMinusReflectivity = 0;
    const half metallic = MetallicGlossMapSample().r * GammaToLinearSpaceExact(float(1));
    half3 GetDiffuseAndSpecularFromMetallic = DiffuseAndSpecularFromMetallic(Maintex, metallic, specColor, oneMinusReflectivity);
    GetDiffuseAndSpecularFromMetallic = lerp(GetDiffuseAndSpecularFromMetallic, Maintex, 1-ReflectionMaskSample());
    
    #ifndef LIGHTMAP_ON
    FinalVertexLight(worldNormal, ndvcorr, Maintex, specColor, FinalOcclusionMap, smoothness, smoothnessAdditionalSH, tangent, bitangent, RampColor, VLShadowsPre, DiffuseVertexLightingNoMainTexMul, DiffuseVertexLightingLuminanced, VertexLightSSS, VertexLightSpecular);
    #endif
    float LuminancedLight = LinearRgbToLuminance(_LightColor0.rgb * ToonRampPixelShadows) + LinearRgbToLuminance((float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w) + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0) * AmbientShadows) + DiffuseVertexLightingLuminanced; //Luminanced Lighting with shadows
    
    half3 IndirectSpecular = calcIndirectSpecular(calcReflView(bentNormalsForBRDF), LuminancedLight, FinalOcclusionMap, smoothness); //For BRDF
    const half3 IndirectSpecularRimLight = calcIndirectSpecular(calcReflView(bentNormalsForRimLight), LuminancedLight, FinalOcclusionMap, smoothnessRimLight); //For Rimlight

    //LTCGI
	#ifdef LTCGI
        #ifdef UNITY_PASS_FORWARDBASE

        const float perceptualRoughness = SmoothnessToPerceptualRoughness (smoothness);
    
        //V1
            //float3 ltcgiSpecular = 0;
	    	//float3 indirectDiffuse = 0;
            //LTCGI_Contribution(i.worldPos, worldNormal, calcViewDir(), perceptualRoughness, float2(0, 0), indirectDiffuse, ltcgiSpecular);
            ////IndirectSpecular += ltcgiSpecular + indirectDiffuse; //For BRDF
            //IndirectSpecular += ltcgiSpecular; //For BRDF
            //FinalLight = indirectDiffuse;
        
        //V2 (current)
            // first, we create the struct that'll be passed through
            accumulator_struct acc = (accumulator_struct)0;
            acc.worldNormal = worldNormal;
            
            // then we make the LTCGI_Contribution call as usual, but with slightly different params
            //We do not use the diffuse output since the specular output can give us a more flat shaded look at high roughness,
            //thanks you Aciil for sugesting this approach, saying that it's still not actually toon shaded so i gotta wait for pi on that one if he finds the time
            LTCGI_Contribution(
                acc, // our accumulator
                i.worldPos, // world position of the shaded point
                worldNormal, // world space normal, in our case the final worldNormal for BRDF specifically
                calcViewDir(), // view vector to shaded point, normalized
                1000, // roughness
                float2(0, 0)); // shadowmap coordinates (the normal Unity ones, they should be in sync with LTCGI maps)

            if (float(1))
                FinalLight += (acc.specular * 2) * Maintex * FinalOcclusionMap;
    
            LTCGI_Contribution(
                acc, // our accumulator
                i.worldPos, // world position of the shaded point
                bentNormalsForBRDF, // world space normal, in our case the final worldNormal for BRDF specifically
                calcViewDir(), // view vector to shaded point, normalized
                perceptualRoughness, // roughness
                float2(0, 0)); // shadowmap coordinates (the normal Unity ones, they should be in sync with LTCGI maps)
        
            if (float(1))
                IndirectSpecular += acc.specular * FinalOcclusionMap; //For BRDF
	    #endif
    #endif

    DiffuseVertexLighting = DiffuseVertexLightingNoMainTexMul * Maintex;
    FinalLight += DiffuseVertexLighting; //Final Diffuse Lighting

    
    
    //Other Lighting Calculations for other Features____________________________________________________________________
    PreFinalLight += DiffuseVertexLightingNoMainTexMul; //= FinalLight but without MainTex mul
    float3 PreClampFinalLight = PixelLightCalculation + AmbientLight + DiffuseVertexLightingNoMainTexMul; //= FinalLight but without the Clamp nor MainTex mul
    float3 AmbientFeatureLight = (float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w) + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0) * FinalOcclusionMap;
    float3 PixelFeatureLight = _LightColor0.rgb;
    float3 PreClampedFinalLightNoShadows = _LightColor0.rgb * lightAttenNoShadows + AmbientLightBoosted + DiffuseVertexLightingNoMainTexMul; //Light without Shadows nor Clamp nor MainTex mul
    half LuminancedLightNoShadows = LinearRgbToLuminance(_LightColor0.rgb * lightAttenNoShadows) + (AmbientLightLuminanced * 2) + DiffuseVertexLightingLuminanced; //=PreClampedFinalLightNoShadows but Luminanced with Ambient lift
    half4 NdLVertexLightsShadows = VLShadowsPre; //Vertex Lighting NdL Shadow Ramped, includes saturate!
    
    //Non DIffuse Shadows for Specular Highlights
    float DirectNdLPixelShadows = 0; //Pixel Lighting NdL Shadows without Intensity nor Shadow Color Map etc., basically raw NdL shadows without Diffuse changes
    float DirectionalAttenuation = 0; //Pixel Lighting Atten Shadows without Intensity nor Shadow Color Map etc., basically raw Atten shadows without Diffuse changes
    float AmbientRampLumninanced = 0; //Luminanced Ambient Light Shadow Ramped
    if (float(1) == 1)
    {
        DirectNdLPixelShadows = min(SCSAttenNoIntensity, SCSNdLNoIntensity);
        DirectionalAttenuation = SCSAttenNoIntensity;
        AmbientRampLumninanced = SCSAmbient;
    }
    else
    {
        DirectNdLPixelShadows = LinearRgbToLuminance(min(ToonRampSample(max(ndl * 0.5 + 0.5, 0)), ToonRampTexATTEN));
        DirectionalAttenuation = LinearRgbToLuminance(ToonRampTexATTEN);
        AmbientRampLumninanced = ToonRampTexAmbient;
    }

    //Specular Hightlight + BRDF Shadow Calc
    float NdLGGX = 1;
    float NdLGGXRamp = inverseLerp(-max(-0.99, float(0)), 1, DirectNdLPixelShadows);
    float NdLGGXRampt = saturate(float(0)) * 0.5;
    NdLGGXRampt = NdLGGXRampt * float(0) + NdLGGXRampt;
    NdLGGXRamp = saturate(lerp(NdLGGXRamp, 1, NdLGGXRampt));
    if (float(2) == 1)
    {
        NdLGGX = ndl;
    }
    else if (float(2) == 2)
    {
        NdLGGX = NdLGGXRamp;
    }
    float AdditionalShadowRamp = NdLGGX;
    #ifdef UNITY_PASS_FORWARDADD
        AdditionalShadowRamp = NdLGGX * shadow;
    #endif
    
    float AttenGGXDir = shadow;
    float AttenGGX = shadow;
    #ifndef UNITY_PASS_FORWARDADD
        AttenGGX = 1;
    #endif
    float AttenGGXButDirIs1 = AttenGGX;
    if (float(2) == 1)
    {
        AttenGGX = AttenGGXDir;
    }

    float ShadowsToonAniso = AttenGGXButDirIs1;
    if (float(2) == 1)
    {
        ShadowsToonAniso = saturate(shadow * ndl);
    }
    else if (float(2) == 2)
    {
        ShadowsToonAniso = AdditionalShadowRamp;
    }
    
    float ShadowsIndirectNdL = 1;
    float ShadowsIndirectNdLRamp = inverseLerp(-max(-0.99, float(0)), 1, AmbientRampLumninanced);
    float ShadowsIndirectNdLRampt = saturate(float(0)) * 0.5;
    ShadowsIndirectNdLRampt = ShadowsIndirectNdLRampt * float(0) + ShadowsIndirectNdLRampt;
    ShadowsIndirectNdLRamp = saturate(lerp(ShadowsIndirectNdLRamp, 1, ShadowsIndirectNdLRampt));
    if (float(2) == 1)
    {
        ShadowsIndirectNdL = saturate(ndlAmbient);
    }
    else if (float(2) == 2)
    {
        ShadowsIndirectNdL = ShadowsIndirectNdLRamp;
    }

    //SSS Atten
    float SSSTangentNormalAtten = dot(tangent, shadow);
    SSSTangentNormalAtten = SSSTangentNormalAtten * float(0.5) + 0.5;
    SSSTangentNormalAtten += 1-float(0.5) * 0.5 - 0.25 + float(0.5) + 0.5;
    float SSSTangentNormalAttenToonRampTex = LinearRgbToLuminance(ToonRampSample(SSSTangentNormalAtten));
    #ifndef DIRECTIONAL
        SSSTangentNormalAtten = float3(1,1,1);
        SSSTangentNormalAttenToonRampTex = 1;
    #endif
    float SCSSSSAtten = SSSTangentNormalAtten * float(8);
    SCSSSSAtten = floor(SCSSSSAtten);
    SCSSSSAtten = saturate(SCSSSSAtten / (float(8) - 1));
    float SSSAtten = 1;
    #ifdef UNITY_PASS_FORWARDADD
        //technically unsure if we should use pointlight Shadowcaster Shadows here or not
        SSSAtten *= lightAttenNoShadows;
    #endif
    if (float(1) == 1)
    {
        SSSAtten *= SCSSSSAtten;
    }
    else
    {
        SSSAtten *= SSSTangentNormalAttenToonRampTex;
    }
    
    



    
    //##Other Features##________________________________________________________________________________________________
    bool LightCheck = (max(max(_LightColor0.r, _LightColor0.g), _LightColor0.b) * _LightColor0.a) == 0;
    
    
    //Rim Light
    //unsure if we should clamp the lighting here TODO: replace with PreFinalLight ?
    float3 RimLighting = RimLight(ndv, Maintex, PreClampFinalLight, IndirectSpecularRimLight, facing);
    FinalLight += RimLighting;
    
    
    
    //Shadow/Emissive Rim
    half ShadowRim = 1;
    half3 EmissiveRim = 0;
    ShadowEmissiveRim(ndvcorr, ShadowRim, EmissiveRim);
    #ifdef UNITY_PASS_FORWARDBASE
        FinalLight *= ShadowRim;
        FinalLight += EmissiveRim;
    #endif
    
    
    
    //Generally Premultiply in Transparent and Custom BlendMode
    if (float(0) == 3 || float(0) == 1)
    {
        FinalLight *= alpha;
    }
    
    
    
    //Matcap
    half MatcapLightAbsobtion = 0;
    const half3 Matcap = calcMatcap(worldNormal, worldNormalIgnoredNormalMaps, Maintex, PreClampedFinalLightNoShadows, LuminancedLightNoShadows, FinalOcclusionMap, MatcapLightAbsobtion);
    if (float(1) == 0 || float(1) == 0)
        FinalLight = lerp(Matcap + FinalLight, Matcap, MatcapLightAbsobtion); //need to do this here so things below here are not affected by LightAbsorbtion, we also use this in BRDF to be able to use BRDF with Mul Matcaps
    
    
    
    //BRDF Metallic Workflow, Reflections + Specular Highlights
    //Needs to be down here for the Alpha Premultiply step below
    float3 BRDF = BRDF1(specColor, oneMinusReflectivity, smoothness, IndirectSpecular, ndvcorr);
    half3 SpecularBRDFPixelMetallicWF = calcSpecularBRDF(smoothness, specColor, max(NdLGGX,0), ndvcorr, ndh, ldh, PixelFeatureLight * AttenGGX);
    half3 AmbientSpecularBRDFMetallicWF = 0;
    if (LightCheck)
    {
        SpecularBRDFPixelMetallicWF = 0.0;
        #ifdef UNITY_PASS_FORWARDBASE
        AmbientSpecularBRDFMetallicWF = calcSpecularBRDF(smoothness, specColor, max(ShadowsIndirectNdL,0), ndvcorr, ndhAmbient, ldhAmbient, AmbientFeatureLight);
        #endif
    }
    //BRDF specific permutations
    if (float(1) == 1 && float(1) == 1)
    {
        half CubemapLightAbsorbtion = float(1) * ReflectionMaskSample() * (MetallicGlossMapSample().r * GammaToLinearSpaceExact(float(1)));
        
        FinalLight = lerp(FinalLight, 0, CubemapLightAbsorbtion);
        FinalLight = lerp(Matcap + FinalLight, Matcap, MatcapLightAbsobtion); //need to add this here to be able to use BRDF with Mul Matcaps
        half3 SpecularHighlightsMetallicSum = 0;
        if (float(1) == 1)
            SpecularHighlightsMetallicSum = SpecularBRDFPixelMetallicWF + AmbientSpecularBRDFMetallicWF;
        
        FinalLight += (BRDF + SpecularHighlightsMetallicSum) * ReflectionMaskSample() * float(1);
    }
    
    
    
    //Specular Highlights GGX Unity BRDF + GGX Anisotropic from Filament
    float3 SpecColorAdditionalSH = lerp(1, Maintex, float(1)) * float4(0.03921569,0.03921569,0.03921569,1).rgb;
    half3 SpecularBRDFPixel = 0.0;
    if (float(0) == 1 && float(0) == 1)
    {
        SpecularBRDFPixel = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, max(NdLGGX,0), ndvcorr, ndh, ldh, PixelFeatureLight * AttenGGX) * SpecularMapSample().rgb * float4(0.03921569,0.03921569,0.03921569,1).a;
    }
    half3 SpecularPixelAnisoGGX = calcSpecularAnisoGGX(max(NdLGGX,0), ndh, ndvcorr, ldh, smoothnessAdditionalSH, calcLightDir(), PixelFeatureLight * ShadowsToonAniso, halfVector, Maintex, tangent, bitangent);
    float3 SpecularPixelToon = calcSpecularToon(ndh, Maintex, PixelFeatureLight, ShadowsToonAniso);
    float3 SpecularPixelAniso = calcSpecularAniso(worldNormal, halfVector, ndh, Maintex, PixelFeatureLight, ShadowsToonAniso);
    half3 AmbientSpecularBRDF = 0.0;
    half3 AmbientSpecularAnisoGGX = 0.0;
    float3 SpecularAmbientToon = 0.0;
    float3 SpecularAmbientAniso = 0.0;
    if (LightCheck)
    {
        SpecularBRDFPixel = 0.0;
        SpecularPixelAnisoGGX = 0.0;
        SpecularPixelToon = 0.0;
        SpecularPixelAniso = 0.0;
        #ifdef UNITY_PASS_FORWARDBASE
            if (float(0) == 1 && float(0) == 1)
            {
                AmbientSpecularBRDF = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, max(ShadowsIndirectNdL,0), ndvcorr, ndhAmbient, ldhAmbient, AmbientFeatureLight) * SpecularMapSample().rgb * float4(0.03921569,0.03921569,0.03921569,1).a;
            }
            AmbientSpecularAnisoGGX = calcSpecularAnisoGGX(max(ShadowsIndirectNdL,0), ndhAmbient, ndvcorr, ldhAmbient, smoothnessAdditionalSH, calcLightDirAmbient(), AmbientFeatureLight * ShadowsIndirectNdL, halfVectorAmbient, Maintex, tangent, bitangent);
            SpecularAmbientToon = calcSpecularToon(ndhAmbient, Maintex, AmbientFeatureLight, ShadowsIndirectNdL);
            SpecularAmbientAniso = calcSpecularAniso(worldNormal, halfVectorAmbient, ndhAmbient, Maintex, AmbientFeatureLight, ShadowsIndirectNdL);
        #endif
    }
    
    FinalLight += SpecularBRDFPixel + SpecularPixelAnisoGGX + SpecularPixelToon + SpecularPixelAniso + AmbientSpecularBRDF + AmbientSpecularAnisoGGX + SpecularAmbientToon + SpecularAmbientAniso + VertexLightSpecular;
    
    
    
    //Distance Darkening
    float depth = length(calcStereoViewDir());
    float distFade = saturate((depth - float4(0.115,0.01,0,1).x) / (float4(0.115,0.01,0,1).y - float4(0.115,0.01,0,1).x));
    distFade *= saturate(float4(0.115,0.01,0,1).z);
    FinalLight = lerp(FinalLight, float3(0,0,0), distFade);
    
    
    
    //Inventory System
    if (float(0) && float(0) == 1)
    {
        float2 InventoryUV = i.uv0;
        if (float(0) == 1)
            InventoryUV = i.uv1;
        else if (float(0) == 2)
            InventoryUV = i.uv2;
        else if (float(0) == 3)
            InventoryUV = i.uv3;
        
        float3 InventoryEmission = 0;
        InventorySystem(InventoryUV, InventoryEmission);
        FinalLight += InventoryEmission;
    }
    
    
    
    //Dither
    float2 DitherMaskUV = i.uv0;
    if (float(0) == 1)
        DitherMaskUV = i.uv1;
    else if (float(0) == 2)
        DitherMaskUV = i.uv2;
    else if (float(0) == 3)
        DitherMaskUV = i.uv3;
    Dither(alpha, DitherMaskUV, i.screenPos);
    
    
    
    //alpha, alpha here should be (_MainTex.a * _Color.a)
    if (float(0) == 1 || float(0) == 2) //Cutout and Fade
    {
        clip (alpha - float(0));
    }
    else if ((float(0) == 3 && float(1) == 1 && float(1) == 1) || (float(0) == 1 && float(1) == 1 && float(1) == 1)) //Transparent BRDF
    {
        half ModifiedAlpha = lerp(1, oneMinusReflectivity, ReflectionMaskSample());
        alpha = 1-ModifiedAlpha + alpha * ModifiedAlpha;
        clip (alpha - float(0));
    }
    else if ((float(0) == 3 && float(1) == 0) || (float(0) == 3 && float(1) == 0) || (float(0) == 1 && float(1) == 0) || (float(0) == 1 && float(1) == 0)) //Transparent
    {
        clip (alpha - float(0));
    }
    else //Opaque
    {
        alpha = 1;
    }
    
    
    
    //SSS
    half3 SubsurfaceScattering = SSS(worldNormal, calcLightDir(), PixelFeatureLight, SSSAtten);
    half3 AmbientSubsurfaceScattering = 0.0;
    if (LightCheck)
    {
        SubsurfaceScattering = 0.0;
        #ifdef UNITY_PASS_FORWARDBASE
        AmbientSubsurfaceScattering = SSS(worldNormal, calcLightDirAmbient(), AmbientFeatureLight, 1);
        #endif
    }
    if (float(0) == 3 || float(0) == 1) //Premultiply in Transparent and Custom BlendMode, we need to put SSS after the Distance Darkening hence why we need to Premultiply here again with SSS
        FinalLight += (SubsurfaceScattering + AmbientSubsurfaceScattering + VertexLightSSS) * alpha;
    else
        FinalLight += SubsurfaceScattering + AmbientSubsurfaceScattering + VertexLightSSS;
    
    
    
    //Apply basic Emission including EmissionScroll v1 and v2
    #ifdef UNITY_PASS_FORWARDBASE
    half3 basicEmission = BasicEmission(Maintex, LuminancedLight);
    FinalLight += basicEmission;
    FinalLight += emissionScroll;
    //Emissive Decals and Emissive Flipbook
    FinalLight += EmissiveDecalsAndFlipbook;
    #endif
    
    
    
    //OUTLINE
    #ifdef UNITY_PASS_FORWARD_OUTLINE
        //Need to add MainTex here otherwise the Optimizer will strip Maintex out sometimes, 1e-10 for fp16 and above
        //This should theoretically be fixed in the Shader Optimizer
        half3 OutlineMode = (PreFinalLight + (Maintex * 1e-10)) * _OutlineColor;
        if (_OutlineMode == 1)
        {
            OutlineMode = _OutlineColor;
        }
        
        half3 OutlineTint = OutlineMode * lerp(1, Maintex, _OutlineTint);
        half3 OutlineHue = 1;
        if (_OutlineHueSpeed > 0)
        {
            OutlineHue = HSVToRGB(float3(_OutlineHueSpeed * _Time.y, 1, 1));
        }
    
        float2 OutlineMaskUV = UVSwitch(_OutlineMaskUVSwitch);
        half OutlineMask = SAMPLE_TEXTURE2D_LOD(_OutlineMask, sampler_OutlineMask, _OutlineMask_ST.xy * OutlineMaskUV + _OutlineMask_ST.zw, 0.0).r;
        half3 OutlineColor = OutlineTint * OutlineHue * OutlineMask;
        
        UNITY_APPLY_FOG(i.fogCoord, OutlineColor);
        return float4(OutlineColor, alpha);
    //OUTLINE END
    #else
        UNITY_APPLY_FOG(i.fogCoord, FinalLight);
        return float4(FinalLight + (Maintex.rgb * 1e-10), alpha);
    #endif
}
#endif//end
