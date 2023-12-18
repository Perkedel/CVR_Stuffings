# OpenLit
This library makes it easy to create toon shaders that do the same lighting. This library is licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).

## Purpose of this library
- Good behavior in environments where the user has no control over the lighting
- Make the brightness close to Standard Shader
- Make the brightness the same as your friends in VRSNS
- Make it easy to use multiple different shaders with one avatar

Lightmaps are not supported. This is because the user has control over the lighting in the world.

## core.hlsl
This file is a library that contains lighting functions. When copying and using it, delete `.meta` so that the problem due to duplicate UUID does not occur.

## OpenToonLit.shader
This file is a shader example using OpenLit Library. It may be easier to create a custom shader by copying only what you need from this shader.

## Details
This library supports these lighting environments.

- Directional Light
- Point Light
- Spot Light
- Environment Light
- Light Probe

"Environment Light" and "Light Probe" are implemented using `ShadeSH9()`. However, it looks bad as a toon shader, so some changes have been made.

### Light Direction

First, the light direction is implemented as follows. Since `unity_SHAr.xyz` represents the bias of [spherical harmonics](https://docs.unity3d.com/Manual/LightProbes-TechnicalInformation.html), the direction of `ShadeSH9()` can be calculated in a pseudo manner from here. Finally, blend this with the directional light to find the brightest point. However, since spherical harmonics are rarely used to control the direction of the light, the one with the light direction facing up is used for shading. If the light direction does not exist, it will fall back to the `Light Direction Override` set in the material.

https://github.com/lilxyzw/OpenLit/blob/main/Assets/OpenLit/core.hlsl#L65-L86
```HLSL
float3 ComputeCustomLightDirection(float4 lightDirectionOverride)
{
    float3 customDir = length(lightDirectionOverride.xyz) * normalize(mul((float3x3)OPENLIT_MATRIX_M, lightDirectionOverride.xyz));
    return lightDirectionOverride.w ? customDir : lightDirectionOverride.xyz;
}

void ComputeLightDirection(out float3 lightDirection, out float3 lightDirectionForSH9, float4 lightDirectionOverride)
{
    float3 mainDir = OPENLIT_LIGHT_DIRECTION * OpenLitLuminance(OPENLIT_LIGHT_COLOR);
    #if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
        float3 sh9Dir = unity_SHAr.xyz * 0.333333 + unity_SHAg.xyz * 0.333333 + unity_SHAb.xyz * 0.333333;
        float3 sh9DirAbs = float3(sh9Dir.x, abs(sh9Dir.y), sh9Dir.z);
    #else
        float3 sh9Dir = 0;
        float3 sh9DirAbs = 0;
    #endif
    float3 customDir = ComputeCustomLightDirection(lightDirectionOverride);

    lightDirection = normalize(sh9DirAbs + mainDir + customDir);
    lightDirectionForSH9 = sh9Dir + mainDir;
    lightDirectionForSH9 = dot(lightDirectionForSH9,lightDirectionForSH9) < 0.000001 ? 0 : normalize(lightDirectionForSH9);
}
```

### Environment Light / Light Probe
Then calculate `ShadeSH9()` using the light direction. Find the brightest point using the light vector calculated earlier. Also, invert the vector to find the shadow color. However, if you use the light vector as is, it will be extremely bright, so the vector is made a little smaller.

https://github.com/lilxyzw/OpenLit/blob/main/Assets/OpenLit/core.hlsl#L95-L121
```HLSL
void ShadeSH9ToonDouble(float3 lightDirection, out float3 shMax, out float3 shMin)
{
    #if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
        float3 N = lightDirection * 0.666666;
        float4 vB = N.xyzz * N.yzzx;
        // L0 L2
        float3 res = float3(unity_SHAr.w,unity_SHAg.w,unity_SHAb.w);
        res.r += dot(unity_SHBr, vB);
        res.g += dot(unity_SHBg, vB);
        res.b += dot(unity_SHBb, vB);
        res += unity_SHC.rgb * (N.x * N.x - N.y * N.y);
        // L1
        float3 l1;
        l1.r = dot(unity_SHAr.rgb, N);
        l1.g = dot(unity_SHAg.rgb, N);
        l1.b = dot(unity_SHAb.rgb, N);
        shMax = res + l1;
        shMin = res - l1;
        #if defined(UNITY_COLORSPACE_GAMMA)
            shMax = OpenLitLinearToSRGB(shMax);
            shMin = OpenLitLinearToSRGB(shMin);
        #endif
    #else
        shMax = 0.0;
        shMin = 0.0;
    #endif
}
```

And the color of the directional light is added.

https://github.com/lilxyzw/OpenLit/blob/main/Assets/OpenLit/core.hlsl#L146-L178
```HLSL
void ComputeSHLightsAndDirection(out float3 lightDirection, out float3 directLight, out float3 indirectLight, float4 lightDirectionOverride)
{
    float3 lightDirectionForSH9;
    ComputeLightDirection(lightDirection, lightDirectionForSH9, lightDirectionOverride);
    ShadeSH9ToonDouble(lightDirectionForSH9, directLight, indirectLight);
}

void ComputeLights(out float3 lightDirection, out float3 directLight, out float3 indirectLight, float4 lightDirectionOverride)
{
    ComputeSHLightsAndDirection(lightDirection, directLight, indirectLight, lightDirectionOverride);
    directLight += OPENLIT_LIGHT_COLOR;
}
```

### Vertex Light
Vertex light attenuation is different from what is calculated by ForwardAdd. This causes the problem of sudden darkening when the mesh goes out of range of the light. So I created a function that reproduces the `_LightTexture0` used to attenuate ForwardAdd.

https://github.com/lilxyzw/OpenLit/blob/main/Assets/OpenLit/core.hlsl#L242-L262
```HLSL
float3 ComputeAdditionalLights(float3 positionWS, float3 positionCS)
{
    float4 toLightX = unity_4LightPosX0 - positionWS.x;
    float4 toLightY = unity_4LightPosY0 - positionWS.y;
    float4 toLightZ = unity_4LightPosZ0 - positionWS.z;

    float4 lengthSq = toLightX * toLightX + 0.000001;
    lengthSq += toLightY * toLightY;
    lengthSq += toLightZ * toLightZ;

    //float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
    float4 atten = saturate(saturate((25.0 - lengthSq * unity_4LightAtten0) * 0.111375) / (0.987725 + lengthSq * unity_4LightAtten0));

    float3 additionalLightColor;
    additionalLightColor =                        unity_LightColor[0].rgb * atten.x;
    additionalLightColor = additionalLightColor + unity_LightColor[1].rgb * atten.y;
    additionalLightColor = additionalLightColor + unity_LightColor[2].rgb * atten.z;
    additionalLightColor = additionalLightColor + unity_LightColor[3].rgb * atten.w;

    return additionalLightColor;
}
```

Normally, vertex lights should be added, but spotlights set to `Not Important` cause problems. This is because the `Spot Angle` is ignored and calculated as a point light. Therefore, avatars with multiple skinned mesh renderers will have different brightness for each mesh. Originally these should be combined into one, but due to convenience issues many users use multiple skinned mesh renderers. So the intensity of the vertex light is set to 0 by default.

### ForwardAdd
ForwardAdd attenuation is basically calculated in the same way as standard shader. However, if you add it as it is, it will cause severe overexposure. Therefore, `BlendOp Max` is used to work around this issue. This will prevent overexposure if the fragment shader output is clamped. However, this blending method causes problems with transparent materials, so transparency is boosted.

https://github.com/lilxyzw/OpenLit/blob/main/Assets/OpenLit/OpenToonLit.shader#L273-L274
```HLSL
// [OpenLit] Premultiply (only for transparent materials)
col.rgb *= saturate(col.a * _AlphaBoostFA);
```

## Others
This library isn't perfect and there may be better lighting calculations. So welcome your ideas for improvement.

Special thanks to [poiyomi](https://twitter.com/poiyomi)