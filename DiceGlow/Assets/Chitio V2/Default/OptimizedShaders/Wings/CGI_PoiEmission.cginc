#ifndef POI_EMISSION
#define POI_EMISSION
float4 _EmissionColor;
#if defined(PROP_EMISSIONMAP) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_EmissionMap);
#endif
#if defined(PROP_EMISSIONMASK) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_EmissionMask);
#endif
#if defined(PROP_EMISSIONSCROLLINGCURVE) || !defined(OPTIMIZER_ENABLED)
    UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionScrollingCurve); float4 _EmissionScrollingCurve_ST;
#endif
float _EmissionBaseColorAsMap;
float _EmissionStrength;
float _EnableEmission;
float _EmissionHueShift;
float4 _EmissiveScroll_Direction;
float _EmissiveScroll_Width;
float _EmissiveScroll_Velocity;
float _EmissiveScroll_Interval;
float _EmissionBlinkingEnabled;
float _EmissiveBlink_Min;
float _EmissiveBlink_Max;
float _EmissiveBlink_Velocity;
float _ScrollingEmission;
float _EnableGITDEmission;
float _GITDEMinEmissionMultiplier;
float _GITDEMaxEmissionMultiplier;
float _GITDEMinLight;
float _GITDEMaxLight;
float _GITDEWorldOrMesh;
float _EmissionCenterOutEnabled;
float _EmissionCenterOutSpeed;
float _EmissionHueShiftEnabled;
float _EmissionBlinkingOffset;
float _EmissionScrollingOffset;
float _EmissionHueShiftSpeed;
float _EmissionHueShiftSpeed1;
float4 _EmissionColor1;
float _EmissionBaseColorAsMap1;
float _EmissionStrength1;
float _EnableEmission1;
float _EmissionHueShift1;
float4 _EmissiveScroll_Direction1;
float _EmissiveScroll_Width1;
float _EmissiveScroll_Velocity1;
float _EmissiveScroll_Interval1;
float _EmissionBlinkingEnabled1;
float _EmissiveBlink_Min1;
float _EmissiveBlink_Max1;
float _EmissiveBlink_Velocity1;
float _ScrollingEmission1;
float _EnableGITDEmission1;
float _GITDEMinEmissionMultiplier1;
float _GITDEMaxEmissionMultiplier1;
float _GITDEMinLight1;
float _GITDEMaxLight1;
float _GITDEWorldOrMesh1;
float _EmissionCenterOutEnabled1;
float _EmissionCenterOutSpeed1;
float _EmissionHueShiftEnabled1;
float _EmissionBlinkingOffset1;
float _EmissionScrollingOffset1;
float _EmissionReplace;
float _EmissionScrollingVertexColor;
float _EmissionScrollingVertexColor1;
float _EmissionScrollingUseCurve;
float _EmissionScrollingUseCurve1;
#ifdef POI_AUDIOLINK
    half _EnableEmissionStrengthAudioLink;
    half _AudioLinkEmissionStrengthBand;
    half _EnableEmissionCenterOutAudioLink;
    half _AudioLinkEmissionCenterOutBand;
    float2 _AudioLinkAddEmission;
    half _AudioLinkAddEmissionBand;
    float2 _EmissionCenterOutAddAudioLink;
    half _AudioLinkEmissionCenterOutAddBand;
    half _EnableEmission1StrengthAudioLink;
    half _AudioLinkEmission1StrengthBand;
    half _EnableEmission1CenterOutAudioLink;
    half _AudioLinkEmission1CenterOutBand;
    float2 _AudioLinkAddEmission1;
    half _AudioLinkAddEmission1Band;
    float2 _EmissionCenterOutAddAudioLink1;
    half _AudioLinkEmission1CenterOutAddBand;
    fixed _EmissionCenterOutAudioLinkWidth;
    fixed _EmissionCenterOutAddAudioLinkwidth;
    fixed _Emission1CenterOutAudioLinkWidth;
    fixed _Emission1CenterOutAddAudioLinkwidth;
#endif
float calculateGlowInTheDark(in float minLight, in float maxLight, in float minEmissionMultiplier, in float maxEmissionMultiplier, in float enabled, in float worldOrMesh)
{
    float glowInTheDarkMultiplier = 1;
    
    if (enabled)
    {
        #ifdef POI_LIGHTING
            float3 lightValue = worldOrMesh ? calculateluminance(poiLight.finalLighting.rgb): calculateluminance(poiLight.directLighting.rgb);
            float gitdeAlpha = saturate(inverseLerp(minLight, maxLight, lightValue));
            glowInTheDarkMultiplier = lerp(minEmissionMultiplier, maxEmissionMultiplier, gitdeAlpha);
        #endif
    }
    return glowInTheDarkMultiplier;
}
float calculateScrollingEmission(in float3 direction, in float velocity, in float interval, in float scrollWidth, float offset, float3 position)
{
    float phase = 0;
    phase = dot(position, direction);
    phase -= (_Time.y + offset) * velocity;
    phase /= interval;
    phase -= floor(phase);
    phase = saturate(phase);
    return(pow(phase, scrollWidth) + pow(1 - phase, scrollWidth * 4)) * 0.5;
}
float calculateBlinkingEmission(in float blinkMin, in float blinkMax, in float blinkVelocity, float offset)
{
    float amplitude = (blinkMax - blinkMin) * 0.5f;
    float base = blinkMin + amplitude;
    return sin((_Time.y + offset) * blinkVelocity) * amplitude + base;
}
float3 calculateEmissionNew(in float3 baseColor, inout float4 finalColor)
{
    float3 emission0 = 0;
    float emissionStrength0 = (1.0 /*_EmissionStrength*/);
    float3 emissionColor0 = 0;
    #ifdef POI_AUDIOLINK
        
        if (poiMods.audioLinkTextureExists)
        {
            
            if ((0.0 /*_EnableEmissionStrengthAudioLink*/))
            {
                emissionStrength0 *= poiMods.audioLink[(0.0 /*_AudioLinkEmissionStrengthBand*/)];
            }
            
            if ((0.0 /*_EnableEmissionCenterOutAudioLink*/))
            {
                emissionStrength0 *= getBandAtTime((0.0 /*_AudioLinkEmissionCenterOutBand*/), saturate(1 - poiLight.nDotV), (1.0 /*_EmissionCenterOutAudioLinkWidth*/));
            }
            emissionStrength0 += lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, getBandAtTime((0.0 /*_AudioLinkEmissionCenterOutAddBand*/), saturate(1 - poiLight.nDotV), (1.0 /*_EmissionCenterOutAddAudioLinkwidth*/)));
            emissionStrength0 += lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[(0.0 /*_AudioLinkAddEmissionBand*/)]);
            emissionStrength0 = max(emissionStrength0, 0);
        }
    #endif
    float glowInTheDarkMultiplier0 = calculateGlowInTheDark((0.0 /*_GITDEMinLight*/), (1.0 /*_GITDEMaxLight*/), (1.0 /*_GITDEMinEmissionMultiplier*/), (0.0 /*_GITDEMaxEmissionMultiplier*/), (0.0 /*_EnableGITDEmission*/), (0.0 /*_GITDEWorldOrMesh*/));
    #if defined(PROP_EMISSIONMAP) || !defined(OPTIMIZER_ENABLED)
        
        if (!(0.0 /*_EmissionCenterOutEnabled*/))
        {
            emissionColor0 = POI2D_SAMPLER_PAN(_EmissionMap, _MainTex, poiMesh.uv[(0.0 /*_EmissionMapUV*/)], float4(0,0,0,0)).rgb * lerp(1, baseColor, (0.0 /*_EmissionBaseColorAsMap*/)).rgb * float4(1,1,1,1).rgb;
        }
        else
        {
            emissionColor0 = UNITY_SAMPLE_TEX2D_SAMPLER(_EmissionMap, _MainTex, ((.5 + poiLight.nDotV * .5) * float4(1,1,0,0).xy) + _Time.x * (5.0 /*_EmissionCenterOutSpeed*/)).rgb * lerp(1, baseColor, (0.0 /*_EmissionBaseColorAsMap*/)).rgb * float4(1,1,1,1).rgb;
        }
    #else
        emissionColor0 = lerp(1, baseColor, (0.0 /*_EmissionBaseColorAsMap*/)).rgb * float4(1,1,1,1).rgb;
    #endif
    
    if ((0.0 /*_ScrollingEmission*/))
    {
        float3 pos = poiMesh.localPos;
        
        if ((0.0 /*_EmissionScrollingVertexColor*/))
        {
            pos = poiMesh.vertexColor.rgb;
        }
        
        if ((0.0 /*_EmissionScrollingUseCurve*/))
        {
            #if defined(PROP_EMISSIONSCROLLINGCURVE) || !defined(OPTIMIZER_ENABLED)
                emissionStrength0 *= UNITY_SAMPLE_TEX2D_SAMPLER(_EmissionScrollingCurve, _MainTex, TRANSFORM_TEX(poiMesh.uv[(0.0 /*_EmissionMapUV*/)], _EmissionScrollingCurve) + (dot(pos, float4(0,-10,0,0).xyz) * (20.0 /*_EmissiveScroll_Interval*/)) + _Time.x * (10.0 /*_EmissiveScroll_Velocity*/)).r;
            #endif
        }
        else
        {
            emissionStrength0 *= calculateScrollingEmission(float4(0,-10,0,0).xyz, (10.0 /*_EmissiveScroll_Velocity*/), (20.0 /*_EmissiveScroll_Interval*/), (10.0 /*_EmissiveScroll_Width*/), (0.0 /*_EmissionScrollingOffset*/), pos);
        }
    }
    
    if ((0.0 /*_EmissionBlinkingEnabled*/))
    {
        emissionStrength0 *= calculateBlinkingEmission((0.0 /*_EmissiveBlink_Min*/), (1.0 /*_EmissiveBlink_Max*/), (4.0 /*_EmissiveBlink_Velocity*/), (0.0 /*_EmissionBlinkingOffset*/));
    }
    emissionColor0 = hueShift(emissionColor0, frac((0.0 /*_EmissionHueShift*/) + (0.0 /*_EmissionHueShiftSpeed*/) * _Time.x) * (0.0 /*_EmissionHueShiftEnabled*/));
    #if defined(PROP_EMISSIONMASK) || !defined(OPTIMIZER_ENABLED)
        float emissionMask0 = UNITY_SAMPLE_TEX2D_SAMPLER(_EmissionMask, _MainTex, TRANSFORM_TEX(poiMesh.uv[(0.0 /*_EmissionMaskUV*/)], _EmissionMask) + _Time.x * float4(0,0,0,0)).r;
    #else
        float emissionMask0 = 1;
    #endif
    #ifdef POI_BLACKLIGHT
        if (_BlackLightMaskEmission != 4)
        {
            emissionMask0 *= blackLightMask[_BlackLightMaskEmission];
        }
    #endif
    emissionStrength0 *= glowInTheDarkMultiplier0 * emissionMask0;
    emission0 = emissionStrength0 * emissionColor0;
    #ifdef POI_DISSOLVE
        
        if ((2.0 /*_DissolveEmissionSide*/) != 2)
        {
            emission0 *= lerp(1 - dissolveAlpha, dissolveAlpha, (2.0 /*_DissolveEmissionSide*/));
        }
    #endif
    float3 emission1 = 0;
    float emissionStrength1 = 0;
    float3 emissionColor1 = 0;
    finalColor.rgb = lerp(finalColor.rgb, saturate(emissionColor0 + emissionColor1), saturate(emissionStrength0 + emissionStrength1) * (0.0 /*_EmissionReplace*/) * poiMax(emission0 + emission1));
    return emission0 + emission1;
}
#endif
