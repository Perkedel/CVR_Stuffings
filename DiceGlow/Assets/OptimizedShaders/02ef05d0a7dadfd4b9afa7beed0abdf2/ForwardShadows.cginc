#ifndef SHADOWS_INCLUDED
#define SHADOWS_INCLUDED

// https://github.com/DarthShader/Kaj-Unity-Shaders/blob/926f07a0bf3dc950db4d7346d022c89f9dfdb440/Shaders/Kaj/KajCore.cginc#L1041
#ifdef POINT
    #define LIGHT_ATTENUATION_NO_SHADOW_MUL(destName, input, worldPos) \
    unityShadowCoord3 lightCoord = mul(unity_WorldToLight, unityShadowCoord4(worldPos, 1)).xyz; \
    fixed shadow = UNITY_SHADOW_ATTENUATION(input, worldPos); \
    fixed destName = tex2D(_LightTexture0, dot(lightCoord, lightCoord).rr).r;
#endif
#ifdef SPOT
    #define LIGHT_ATTENUATION_NO_SHADOW_MUL(destName, input, worldPos) \
    DECLARE_LIGHT_COORD(input, worldPos); \
    fixed shadow = UNITY_SHADOW_ATTENUATION(input, worldPos); \
    fixed destName = (lightCoord.z > 0) * UnitySpotCookie(lightCoord) * UnitySpotAttenuate(lightCoord.xyz);
#endif
#ifdef DIRECTIONAL
    #define LIGHT_ATTENUATION_NO_SHADOW_MUL(destName, input, worldPos) \
    fixed shadow = UNITY_SHADOW_ATTENUATION(input, worldPos); \
    fixed destName = 1;
#endif
#ifdef POINT_COOKIE
    #define LIGHT_ATTENUATION_NO_SHADOW_MUL(destName, input, worldPos) \
    DECLARE_LIGHT_COORD(input, worldPos); \
    fixed shadow = UNITY_SHADOW_ATTENUATION(input, worldPos); \
    fixed destName = tex2D(_LightTextureB0, dot(lightCoord, lightCoord).rr).r * texCUBE(_LightTexture0, lightCoord).w;
#endif
#ifdef DIRECTIONAL_COOKIE
    #define LIGHT_ATTENUATION_NO_SHADOW_MUL(destName, input, worldPos) \
    DECLARE_LIGHT_COORD(input, worldPos); \
    fixed shadow = UNITY_SHADOW_ATTENUATION(input, worldPos); \
    fixed destName = tex2D(_LightTexture0, lightCoord).w;
#endif
//END

#endif //END
