#ifndef POI_RIM
#define POI_RIM

float4 _RimLightColor;
float _RimLightingInvert;
float _RimWidth;
float _RimStrength;
float _RimSharpness;
float _RimLightColorBias;
float _ShadowMix;
float _ShadowMixThreshold;
float _ShadowMixWidthMod;
float _EnableRimLighting;
float _RimBrighten;
float _RimLightNormal;
float _RimHueShiftEnabled;
float _RimHueShiftSpeed;
float _RimHueShift;

#ifdef POI_AUDIOLINK
    half _AudioLinkRimWidthBand;
    float2 _AudioLinkRimWidthAdd;
    half _AudioLinkRimEmissionBand;
    float2 _AudioLinkRimEmissionAdd;
    half _AudioLinkRimBrightnessBand;
    float2 _AudioLinkRimBrightnessAdd;
#endif

#if defined(PROP_RIMTEX) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_RimTex);
#endif
#if defined(PROP_RIMMASK) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_RimMask);
#endif
#if defined(PROP_RIMWIDTHNOISETEXTURE) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_RimWidthNoiseTexture);
#endif

float _RimWidthNoiseStrength;

float4 rimColor = float4(0, 0, 0, 0);
float rim = 0;

void applyRimLighting(inout float4 albedo, inout float3 rimLightEmission)
{
    #if defined(PROP_RIMWIDTHNOISETEXTURE) || !defined(OPTIMIZER_ENABLED)
        float rimNoise = POI2D_SAMPLER_PAN(_RimWidthNoiseTexture, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
    #else
        float rimNoise = 0;
    #endif
    rimNoise = (rimNoise - .5) * float(0.1);
    
    float viewDotNormal = saturate(abs(dot(poiCam.viewDir, poiMesh.normals[float(1)])));

    
    if (float(0))
    {
        viewDotNormal = 1 - viewDotNormal;
    }
    float rimStrength = float(0);
    float rimBrighten = float(0);

    float rimWidth = lerp( - .05, 1, float(0.5));
    #ifdef POI_AUDIOLINK
        
        if (poiMods.audioLinkTextureExists)
        {
            rimWidth = clamp(rimWidth + lerp(_AudioLinkRimWidthAdd.x, _AudioLinkRimWidthAdd.y, poiMods.audioLink[_AudioLinkRimWidthBand]), - .05, 1);
            rimStrength += lerp(_AudioLinkRimEmissionAdd.x, _AudioLinkRimEmissionAdd.y, poiMods.audioLink[_AudioLinkRimEmissionBand]);
            rimBrighten += lerp(_AudioLinkRimBrightnessAdd.x, _AudioLinkRimBrightnessAdd.y, poiMods.audioLink[_AudioLinkRimBrightnessBand]);
        }
    #endif

    rimWidth -= rimNoise;
    #if defined(PROP_RIMMASK) || !defined(OPTIMIZER_ENABLED)
        float rimMask = POI2D_SAMPLER_PAN(_RimMask, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
    #else
        float rimMask = 1;
    #endif
    
    #if defined(PROP_RIMTEX) || !defined(OPTIMIZER_ENABLED)
        rimColor = POI2D_SAMPLER_PAN(_RimTex, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)) * float4(0,0,0,1);
    #else
        rimColor = float4(0,0,0,1);
    #endif
    
    
    if (_RimHueShiftEnabled)
    {
        rimColor.rgb = hueShift(rimColor.rgb, _RimHueShift + _Time.x * _RimHueShiftSpeed);
    }
    
    rimWidth = max(lerp(rimWidth, rimWidth * lerp(0, 1, poiLight.lightMap - float(0.5)) * float(0.5), float(0)), 0);
    rim = 1 - smoothstep(min(float(0.25), rimWidth), rimWidth, viewDotNormal);
    rim *= float4(0,0,0,1).a * rimColor.a * rimMask;
    rimLightEmission = rim * lerp(albedo, rimColor, float(0)) * rimStrength;
    albedo.rgb = lerp(albedo.rgb, lerp(albedo.rgb, rimColor, float(0)) + lerp(albedo.rgb, rimColor, float(0)) * rimBrighten, rim);
}
#endif
