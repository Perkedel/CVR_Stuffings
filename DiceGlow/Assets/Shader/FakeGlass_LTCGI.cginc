#ifndef FAKE_GLASS_LTCGI
#define FAKE_GLASS_LTCGI

#if defined(_LTCGI)
    #if defined(_SPECULARHIGHLIGHTS_OFF)
        #define LTCGI_SPECULAR_OFF
    #endif
#include "Assets/_pi_/_LTCGI/Shaders/LTCGI.cginc"
#else
void LTCGI_Contribution(float3 pos, float3 normal, float3 view, 
    float roughness, float2 lightmapUV, float3 diffuse, float3 spec, float specContrib)
{
    // nothing
}
#endif

#endif // FAKE_GLASS_LTCGI