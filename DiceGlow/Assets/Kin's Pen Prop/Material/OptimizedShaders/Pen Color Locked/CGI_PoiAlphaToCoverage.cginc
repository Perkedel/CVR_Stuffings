#ifndef POI_ALPHA_TO_COVERAGE
    #define POI_ALPHA_TO_COVERAGE
    half _MainMipScale;
    float _MainAlphaToCoverage;
    float CalcMipLevel(float2 texture_coord)
    {
        float2 dx = ddx(texture_coord);
        float2 dy = ddy(texture_coord);
        float delta_max_sqr = max(dot(dx, dx), dot(dy, dy));
        return 0.5 * log2(delta_max_sqr);
    }
    void ApplyAlphaToCoverage(inout float4 finalColor)
    {
        
        if ((0.0 /*_Mode*/) == 1)
        {
            
            if((0.0 /*_MainAlphaToCoverage*/))
            {
                finalColor.a *= 1 + max(0, CalcMipLevel(poiMesh.uv[0] * float4(0.25,0.25,4,4).zw)) * (0.25 /*_MainMipScale*/);
                finalColor.a = (finalColor.a - (0.5 /*_Cutoff*/)) / max(fwidth(finalColor.a), 0.0001) + (0.5 /*_Cutoff*/);
            }
        }
    }
#endif
