#ifndef POI_DISSOLVE
#define POI_DISSOLVE

float _DissolveType;
float _DissolveEdgeWidth;
float4 _DissolveEdgeColor;
sampler2D _DissolveEdgeGradient; float4 _DissolveEdgeGradient_ST;
float _DissolveEdgeEmission;
float4 _DissolveTextureColor;

#if defined(PROP_DISSOLVETOTEXTURE) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_DissolveToTexture);
#endif

#if defined(PROP_DISSOLVENOISETEXTURE) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_DissolveNoiseTexture);
#endif

#if defined(PROP_DISSOLVEDETAILNOISE) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_DissolveDetailNoise);
#endif

#if defined(PROP_DISSOLVEMASK) || !defined(OPTIMIZER_ENABLED)
    POI_TEXTURE_NOSAMPLER(_DissolveMask);
#endif

float _DissolveMaskInvert;
float _DissolveAlpha;
float _ContinuousDissolve;
float _DissolveDetailStrength;
float _DissolveEdgeHardness;
float _DissolveInvertNoise;
float _DissolveInvertDetailNoise;
float _DissolveToEmissionStrength;

// Point to Point
float _DissolveP2PWorldLocal;
float _DissolveP2PEdgeLength;
float4 _DissolveStartPoint;
float4 _DissolveEndPoint;

// World Dissolve
float _DissolveWorldShape;
float4 _DissolveShapePosition;
float4 _DissolveShapeRotation;
float _DissolveShapeScale;
float _DissolveInvertShape;
float _DissolveShapeEdgeLength;

float _DissolveAlpha0;
float _DissolveAlpha1;
float _DissolveAlpha2;
float _DissolveAlpha3;
float _DissolveAlpha4;
float _DissolveAlpha5;
float _DissolveAlpha6;
float _DissolveAlpha7;
float _DissolveAlpha8;
float _DissolveAlpha9;
// Masking
float _DissolveEmissionSide;
float _DissolveEmission1Side;
float _DissolveUseVertexColors;

// Audio Link
#ifdef POI_AUDIOLINK
    fixed _EnableDissolveAudioLink;
    half _AudioLinkDissolveAlphaBand;
    float2 _AudioLinkDissolveAlpha;
    half _AudioLinkDissolveDetailBand;
    float2 _AudioLinkDissolveDetail;
#endif

float4 edgeColor;
float edgeAlpha;
float dissolveAlpha;
float4 dissolveToTexture;

float _DissolveHueShiftEnabled;
float _DissolveHueShiftSpeed;
float _DissolveHueShift;
float _DissolveEdgeHueShiftEnabled;
float _DissolveEdgeHueShiftSpeed;
float _DissolveEdgeHueShift;
void calculateDissolve(inout float4 albedo, inout float3 dissolveEmission)
{
    #if defined(PROP_DISSOLVEMASK) || !defined(OPTIMIZER_ENABLED)
        float dissolveMask = POI2D_SAMPLER_PAN(_DissolveMask, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)).r;
    #else
        float dissolveMask = 1;
    #endif
    
    if (float(0))
    {
        // Vertex Color Imprecision hype
        dissolveMask = ceil(poiMesh.vertexColor.g * 100000) / 100000;
    }
    
    #if defined(PROP_DISSOLVETOTEXTURE) || !defined(OPTIMIZER_ENABLED)
        dissolveToTexture = POI2D_SAMPLER_PAN(_DissolveToTexture, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)) * float4(1,1,1,1);
    #else
        dissolveToTexture = float4(1,1,1,1);
    #endif
    
    #if defined(PROP_DISSOLVENOISETEXTURE) || !defined(OPTIMIZER_ENABLED)
        float dissolveNoiseTexture = POI2D_SAMPLER_PAN(_DissolveNoiseTexture, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)).r;
    #else
        float dissolveNoiseTexture = 1;
    #endif
    
    float da = float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0)
    + float(0);
    float dds = float(0.1);

    #ifdef POI_AUDIOLINK
        
        if (float(0) && poiMods.audioLinkTextureExists)
        {
            da += lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[float(0)]);
            dds += lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[float(0)]);
        }
    #endif

    da = saturate(da);
    dds = saturate(dds);

    #ifdef POI_BLACKLIGHT
        if (_BlackLightMaskDissolve != 4)
        {
            dissolveMask *= blackLightMask[_BlackLightMaskDissolve];
        }
    #endif
    
    if (float(0))
    {
        dissolveMask = 1 - dissolveMask;
    }
    #if defined(PROP_DISSOLVEDETAILNOISE) || !defined(OPTIMIZER_ENABLED)
        float dissolveDetailNoise = POI2D_SAMPLER_PAN(_DissolveDetailNoise, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
    #else
        float dissolveDetailNoise = 0;
    #endif
    if (float(0))
    {
        dissolveNoiseTexture = 1 - dissolveNoiseTexture;
    }
    if (float(0))
    {
        dissolveDetailNoise = 1 - dissolveDetailNoise;
    }
    if (float(0) != 0)
    {
        da = sin(_Time.y * float(0)) * .5 + .5;
    }
    da *= dissolveMask;
    dissolveAlpha = da;
    edgeAlpha = 0;
    
    
    if (float(1) == 1) // Basic

    {
        da = remap(da, 0, 1, -float(0.025), 1);
        dissolveAlpha = da;
        //Adjust detail strength to avoid artifacts
        dds *= smoothstep(1, .99, da);
        float noise = saturate(dissolveNoiseTexture - dissolveDetailNoise * dds);
        
        noise = saturate(noise + 0.001);
        //noise = remap(noise, 0, 1, float(0.025), 1 - float(0.025));
        dissolveAlpha = dissolveAlpha >= noise;
        edgeAlpha = remapClamped(noise, da + float(0.025), da, 0, 1) * (1 - dissolveAlpha);
    }
    else if (float(1) == 2) // Point to Point

    {
        float3 direction;
        float3 currentPos;
        float distanceTo = 0;
        direction = normalize(float4(0,1,0,0) - float4(0,-1,0,0));
        currentPos = lerp(float4(0,-1,0,0), float4(0,1,0,0), dissolveAlpha);
        
        
        if (float(0) != 1)
        {
            float3 pos = float(0) == 0 ? poiMesh.localPos.rgb: poiMesh.vertexColor.rgb;
            distanceTo = dot(pos - currentPos, direction) - dissolveDetailNoise * dds;
            edgeAlpha = smoothstep(float(0.1) + .00001, 0, distanceTo);
            dissolveAlpha = step(distanceTo, 0);
            edgeAlpha *= 1 - dissolveAlpha;
        }
        else
        {
            distanceTo = dot(poiMesh.worldPos - currentPos, direction) - dissolveDetailNoise * dds;
            edgeAlpha = smoothstep(float(0.1) + .00001, 0, distanceTo);
            dissolveAlpha = step(distanceTo, 0);
            edgeAlpha *= 1 - dissolveAlpha;
        }
    }
    
    #ifndef POI_SHADOW
        
        if (float(0))
        {
            dissolveToTexture.rgb = hueShift(dissolveToTexture.rgb, float(0) + _Time.x * float(0));
        }
    #endif
    albedo = lerp(albedo, dissolveToTexture, dissolveAlpha * .999999);
    
    
    if (float(0.025))
    {
        edgeColor = tex2D(_DissolveEdgeGradient, TRANSFORM_TEX(float2(edgeAlpha, edgeAlpha), _DissolveEdgeGradient)) * float4(1,1,1,1);
        #ifndef POI_SHADOW
            
            if (float(0))
            {
                edgeColor.rgb = hueShift(edgeColor.rgb, float(0) + _Time.x * float(0));
            }
        #endif
        albedo.rgb = lerp(albedo.rgb, edgeColor.rgb, smoothstep(0, 1 - float(0.5) * .99999999999, edgeAlpha));
    }
    
    dissolveEmission = lerp(0, dissolveToTexture * float(0), dissolveAlpha) + lerp(0, edgeColor.rgb * float(0), smoothstep(0, 1 - float(0.5) * .99999999999, edgeAlpha));
}


#endif
