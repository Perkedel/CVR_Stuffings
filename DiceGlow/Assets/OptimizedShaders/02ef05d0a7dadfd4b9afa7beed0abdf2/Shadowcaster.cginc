#ifndef SHADOWCASTER_INCLUDED
#define SHADOWCASTER_INCLUDED

// NOTE: had to split shadow functions into separate file,
// otherwise compiler gives trouble with LIGHTING_COORDS macro (in UnityStandardCore.cginc)


#include "UnityCG.cginc"
#include "UnityShaderVariables.cginc"
#include "UnityStandardConfig.cginc"
#include "UnityStandardUtils.cginc"
#include "SharedFunctions.cginc"

#if defined(UNITY_USE_DITHER_MASK_FOR_ALPHABLENDED_SHADOWS)
#define UNITY_STANDARD_USE_DITHER_MASK 1
#endif

#ifdef UNITY_STEREO_INSTANCING_ENABLED
#define UNITY_STANDARD_USE_STEREO_SHADOW_OUTPUT_STRUCT 1
#endif

//-----------------------------------
SamplerState sampler_linear_repeat;

float _Mode;
float _ModeCustom;
float _COLORCOLOR;
float _GlossyReflections;
//
half4 _Color;
half _Cutoff;
UNITY_DECLARE_TEX2D(_MainTex);
float4 _MainTex_ST;
float _MainTexUVSwitch;

#ifdef UNITY_STANDARD_USE_DITHER_MASK
sampler3D   _DitherMaskLOD;
#endif

// Handle PremultipliedAlpha from Fade or Transparent shading mode
half _Metallic;
UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
float4 _MetallicGlossMap_ST;
int _MetallicGlossMapUVSwitch;

UNITY_DECLARE_TEX2D_NOSAMPLER(_ReflectionMask);
float4 _ReflectionMask_ST;
int _ReflectionMaskUVSwitch;
int _ReflectionMaskTexChannelSwitch;

half MetallicSetup_ShadowGetOneMinusReflectivity(half2 uv)
{
return half4(1, 1, 1, 1);
}
//-----------------------------------



struct VertexInput
{
    float4 vertex   : POSITION;
    float3 normal   : NORMAL;
    float2 uv0      : TEXCOORD0;
    float2 uv1      : TEXCOORD1;
    float2 uv2      : TEXCOORD2;
    float2 uv3      : TEXCOORD3;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct VertexOutputShadowCaster
{
    V2F_SHADOW_CASTER_NOPOS
    float2 uv0      : TEXCOORD0;
    float2 uv1      : TEXCOORD1;
    float2 uv2      : TEXCOORD2;
    float2 uv3      : TEXCOORD3;
    float4 screenPos: TEXCOORD8;
};
#ifdef UNITY_STANDARD_USE_STEREO_SHADOW_OUTPUT_STRUCT
struct VertexOutputStereoShadowCaster
{
    UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// We have to do these dances of outputting SV_POSITION separately from the vertex shader,
// and inputting VPOS in the pixel shader, since they both map to "POSITION" semantic on
// some platforms, and then things don't go well.


void vert (VertexInput v, out float4 opos : SV_POSITION, out VertexOutputShadowCaster o
    #ifdef UNITY_STANDARD_USE_STEREO_SHADOW_OUTPUT_STRUCT
    , out VertexOutputStereoShadowCaster os
    #endif
)
{
    UNITY_SETUP_INSTANCE_ID(v);
    #ifdef UNITY_STANDARD_USE_STEREO_SHADOW_OUTPUT_STRUCT
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(os);
    #endif
    TRANSFER_SHADOW_CASTER_NOPOS(o,opos)
    
    o.uv0 = v.uv0;
    o.uv1 = v.uv1;
    o.uv2 = v.uv2;
    o.uv3 = v.uv3;
    
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
        opos.z =     inventoryMask ? opos.z : 1e+9;
    }

    o.screenPos = ComputeScreenPos(opos);
}



half4 frag (UNITY_POSITION(vpos), VertexOutputShadowCaster i) : SV_Target
{
    //we need to do UV Switches in the Fragment shader of the Shadowcaster
    half2 MainTexUV = i.uv0;
    if (_MainTexUVSwitch == 1)
        MainTexUV = i.uv1;
    else if (_MainTexUVSwitch == 2)
        MainTexUV = i.uv2;
    else if (_MainTexUVSwitch == 3)
        MainTexUV = i.uv3;

    half2 MetallicGlossMapUV = i.uv0;
    if (float(0) == 1)
        MetallicGlossMapUV = i.uv1;
    else if (float(0) == 2)
        MetallicGlossMapUV = i.uv2;
    else if (float(0) == 3)
        MetallicGlossMapUV = i.uv3;

    half2 ReflectionMaskUV = i.uv0;
    if (float(0) == 1)
        ReflectionMaskUV = i.uv1;
    else if (float(0) == 2)
        ReflectionMaskUV = i.uv2;
    else if (float(0) == 3)
        ReflectionMaskUV = i.uv3;
    
    
    half alpha = UNITY_SAMPLE_TEX2D(_MainTex, MainTexUV * float4(1,1,0,0).xy + float4(1,1,0,0).zw).a * _Color.a;
    
    if (float(0) == 1)
    {
        clip (alpha - float(0));
    }
    if (float(0) == 2 || float(0) == 3 || float(0) == 1)
    {
        if (float(0) != 2 && float(1) == 1 && float(1) == 1)
        {
            const half oneMinusReflectivity = MetallicSetup_ShadowGetOneMinusReflectivity(MetallicGlossMapUV);
            const half metallic = oneMinusReflectivity * GammaToLinearSpaceExact(float(1));
            const half OneMinusReflFromMetallic = OneMinusReflectivityFromMetallic(metallic);
            
            const half ReflectionMask = TexChannelSwitch(_ReflectionMask, sampler_linear_repeat, ReflectionMaskUV * float4(1,1,0,0).xy + float4(1,1,0,0).zw, float(0));
            const half ModifiedAlpha = lerp(1, OneMinusReflFromMetallic, ReflectionMask);
            alpha = 1-ModifiedAlpha + alpha * ModifiedAlpha;
        }
        
        #if defined(UNITY_STANDARD_USE_DITHER_MASK)
        // Use dither mask for alpha blended shadows, based on pixel position xy
        // and alpha level. Our dither texture is 4x4x16.
        #ifdef LOD_FADE_CROSSFADE
        #define _LOD_FADE_ON_ALPHA
        alpha *= unity_LODFade.y;
        #endif
        half alphaRef = tex3D(_DitherMaskLOD, float3(vpos.xy*0.25,alpha*0.9375)).a;
        clip (alphaRef - 0.01);
        //#else //we always use Cutout in Cutout, Fade, Transparent and Custom Mode
        //clip (alpha - float(0));
        #endif
        clip (alpha - float(0));//needs to be deactivated if the #else above would be used again
    }

    #ifdef LOD_FADE_CROSSFADE
        #ifdef _LOD_FADE_ON_ALPHA
            #undef _LOD_FADE_ON_ALPHA
        #else
            UnityApplyDitherCrossFade(vpos.xy);
        #endif
    #endif


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
        
        float3 InventoryEmissionDummy = 0;
        InventorySystem(InventoryUV, InventoryEmissionDummy);
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
    
    SHADOW_CASTER_FRAGMENT(i)
}

#endif // UNITY_STANDARD_SHADOW_INCLUDED

