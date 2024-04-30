#ifndef LIGHTINGFUNCTIONS_INCLUDED
#define LIGHTINGFUNCTIONS_INCLUDED

half3 calcSpecularAnisoGGX(const float ndl, const float ndh, const float vdn, const float ldh, const half smoothness, const half3 LightDir, const half3 lightCol, const half3 halfVector, const float3 diffuseColor, const float3 tangent, const float3 bitangent)
{
    const float3 t = tangent;
    const float3 b = bitangent;
    const float ToV = dot(t, calcViewDir());
    const float BoV = dot(b, calcViewDir());
    const float ToL = dot(t, LightDir);
    const float BoL = dot(b, LightDir);

    const float perceptualRoughness = SmoothnessToPerceptualRoughness(smoothness);
    //perceptualRoughness = clamp(perceptualRoughness, 0.089, 1.0); //for ClearCoat only
    const float roughness = PerceptualRoughnessToRoughness(perceptualRoughness);
    const float rough = roughness;
    
    const float anisotropy = float(0.8) * SpecularMapSample().b;
    const float at = max(rough * (1.0 + anisotropy), 0.002025); //Mobile MIN_ROUGHNESS = 0.007921
    const float ab = max(rough * (1.0 - anisotropy), 0.002025);
    const float V = V_SmithGGXCorrelated_Anisotropic(at, ab, ToV, BoV, ToL, BoL, vdn, ndl);
    const float D = D_GGX_Anisotropic(ndh, halfVector, tangent, bitangent, at, ab);

    //Specular workflow
    const half3 f0 = lerp(float3(1.0,1.0,1.0), diffuseColor, float(1)) * float4(0.03921569,0.03921569,0.03921569,1).rgb;
    //Metallic workflow
    //const half3 f0 = lerp(unity_ColorSpaceDielectricSpec.rgb, diffuseColor, GammaToLinearSpaceExact(float(1)));
    
    half3 F = FresnelTerm(f0, ldh); //Fresnel_Schlick

    //Flicker fix
    if (float(0) == 1)
    {
        //this is not mathematically correct, only use when needed
        //F *= ndl * ndh; //old basic variant, works very well to mitigate the flickering but reduces overall quality too much
        const float squish = 8;
        const float offset = float(0.2);
        F *= saturate((ndl - offset) * squish) * saturate((ndh - offset) * squish);
    }
    
    half3 specular = max(0, D * V * F * UNITY_PI); //Torrance-Sparrow model
    specular = lerp(specular, smoothstep(0.25, 0.26, specular), float(0) * SpecularMapSample().g) * lightCol * SpecularMapSample().r * float4(0.03921569,0.03921569,0.03921569,1).a;
    if (float(0) != 3 || float(0) == 0)
    {
        specular = 0.0;
    }
    return specular;
}

half3 calcSpecularBRDF(half smoothness, half3 specColor, half ndl, half vdn, half ndh, half LdotH, half3 lightcolor)
{
    const float perceptualRoughness = SmoothnessToPerceptualRoughness (smoothness);
    // Specular term
    // HACK: theoretically we should divide diffuseTerm by Pi and not multiply specularTerm!
    // BUT 1) that will make shader look significantly darker than Legacy ones
    // and 2) on engine side "Non-important" lights have to be divided by Pi too in cases when they are injected into ambient SH
    float roughness = PerceptualRoughnessToRoughness(perceptualRoughness);

    // GGX with roughtness to 0 would mean no specular at all, using max(roughness, 0.002) here to match HDrenderloop roughtness remapping.
    roughness = max(roughness, 0.002);
    const float V = SmithJointGGXVisibilityTerm (ndl, vdn, roughness);
    const float D = GGXTerm (ndh, roughness);

    float specularTerm = V*D * UNITY_PI; // Torrance-Sparrow model, Fresnel is applied later

    #   ifdef UNITY_COLORSPACE_GAMMA
    specularTerm = sqrt(max(1e-4h, specularTerm));
    #   endif

    // specularTerm * nl can be NaN on Metal in some cases, use max() to make sure it's a sane value
    specularTerm = max(0, specularTerm * ndl);
    // To provide true Lambert lighting, we need to be able to kill specular completely.
    specularTerm *= any(specColor) ? 1.0 : 0.0;
    
    return specularTerm * lightcolor * FresnelTerm(specColor, LdotH);
}

half3 calcSpecularToon(half ndh, half3 MainTex, half3 Lighting, half ShadowToonAniso)
{
    half lobe = saturate((ndh + float(0)) / max(float(0), 1e-06));
    half3 lobeMul = lobe * float4(0.03921569,0.03921569,0.03921569,1).rgb * float4(0.03921569,0.03921569,0.03921569,1).a * LerpWhiteTo(MainTex, float(1)) * SpecularMapSample().rgb * Lighting * ShadowToonAniso;
    if (float(0) != 0 || float(0) == 0)
    {
        lobeMul = 0.0;
    }
    return lobeMul;
}

half3 calcSpecularAniso(float3 worldNormal, float3 halfVector, float NdH, float3 MainTex, float3 Lighting, float3 ShadowToonAniso)
{
    float3 AnisoDir = normalize(AnisoDirSample() + worldNormal);
    float HdA = dot(AnisoDir, halfVector);
    float Aniso = max(0, sin(radians((HdA + float(0)) * 180)));
    float SpecLerp = lerp(saturate(NdH), Aniso, float(0) * SpecularMapSample().b);
    float SpecPow = pow(SpecLerp, (1-float(1)) * SpecularMapSample().g * lerp(128, 4096, float(0)));
    float Spec = SpecPow * SpecularMapSample().r;
    Spec = saturate(Spec / (1-float(0)));
    Spec *= float4(0.03921569,0.03921569,0.03921569,1).a;

    float3 SpecColor = Spec * float4(0.03921569,0.03921569,0.03921569,1).rgb * LerpWhiteTo(MainTex, float(1)) * Lighting * max(ShadowToonAniso * 2, 0);
    if (float(0) != 2 || float(0) == 0)
    {
        SpecColor = 0.0;
    }
    return SpecColor;
}

half3 SSS(half3 WorldNormal, half3 LightDir, half3 lightColor, half AttenNoNDL)
{
    float SubsurfaceDistortionModifier = float(1);
    float SSSPower = float(2.5);
    float SSSScale = float(1);
    float3 SSSThickenessMap = SSSThickenessMapSample();
    if(float(0) == 1)
    {
        SSSThickenessMap = 1-SSSThickenessMap;
    }
    if (float(0) == 1)
    {
        SubsurfaceDistortionModifier = float(1) * SSSThickenessMap.b;
        SSSPower = float(2.5) * SSSThickenessMap.g;
        SSSScale = float(1) * SSSThickenessMap.r;
        SSSThickenessMap = float3(1,1,1);
    }
    
    const half3 a = WorldNormal * SubsurfaceDistortionModifier;
    const half3 b = -(LightDir + a);
    const half c = saturate(dot(b, calcViewDir()));
    const half d = saturate(pow(c, SSSPower));
    const half e = d * SSSScale;
    const half3 diffuseMul = e * MainTexSample();
    const half3 diffuselerp = lerp(e, diffuseMul, float(1));
    half3 finalSSS = diffuselerp * (lightColor * AttenNoNDL);
    
    if (float(0) == 1)
    {
        finalSSS = diffuselerp * (LinearRgbToLuminance(lightColor) * AttenNoNDL) * float4(0.9997016,1,0.7028302,0).rgb;
    }
    else if (float(0) == 2)
    {
        finalSSS *= float4(0.9997016,1,0.7028302,0).rgb;
    }

    finalSSS *= SSSThickenessMap;
    if (float(1) == 1 && float(1) == 1)//need to make sure that metallic areas are never affected by SSS
    {
        finalSSS *= lerp(1, 1-MetallicGlossMapSample().r * ReflectionMaskSample(), GammaToLinearSpaceExact(float(1))); 
    }

    if (float(1) == 0 || float(1) == 0)
    {
        finalSSS = 0.0;
    }
    return finalSSS;
}

void FinalVertexLight(half3 worldNormal, half ndv, half3 diffuseColor, half3 specColor, half OcclusionMap, half smoothness, half smoothnessAdditionalSH, half3 tangent, half3 bitangent, half3 RampColor, out half4 VLShadowsPre, out half3 DiffuseVertexLights, out half DiffuseVertexLightingLuminanced, out half3 VLSubsurfaceScattering, out half3 VertexLightSpecular)
{
    VertexLightSpecular = 0;
    DiffuseVertexLights = 0;
    DiffuseVertexLightingLuminanced = 0;
    VLSubsurfaceScattering = 0;
    VLShadowsPre = 0;
    #if UNITY_SHOULD_SAMPLE_SH
        #ifdef VERTEXLIGHT_ON
            #ifdef UNITY_PASS_FORWARDBASE
                half4 VertexLightNdLNONMAX = 0;
                half4 VLndl = 0;
                half4 VLAtten = 0;
                half3 VLDirOne = 0;
                half3 VLDirTwo = 0;
                half3 VLDirThree = 0;
                half3 VLDirFour = 0;
                Shade4PointLights(worldNormal, VertexLightNdLNONMAX, VLndl, VLAtten, VLDirOne, VLDirTwo, VLDirThree, VLDirFour); //populating VLDir*s
                //VL1 Data
                half3 VLhalfVector0 = Unity_SafeNormalize(VLDirOne + calcViewDir());
                half VLndh0 = DotClamped(worldNormal, VLhalfVector0);
                half ldh0 = DotClamped(VLDirOne, VLhalfVector0);
                //VL2 Data
                half3 VLhalfVector1 = Unity_SafeNormalize(VLDirTwo + calcViewDir());
                half VLndh1 = DotClamped(worldNormal, VLhalfVector1);
                half ldh1 = DotClamped(VLDirTwo, VLhalfVector1);
                //VL3 Data
                half3 VLhalfVector2 = Unity_SafeNormalize(VLDirThree + calcViewDir());
                half VLndh2 = DotClamped(worldNormal, VLhalfVector2);
                half ldh2 = DotClamped(VLDirThree, VLhalfVector2);
                //VL4 Data
                half3 VLhalfVector3 = Unity_SafeNormalize(VLDirFour + calcViewDir());
                half VLndh3 = DotClamped(worldNormal, VLhalfVector3);
                half ldh3 = DotClamped(VLDirFour, VLhalfVector3);
    
                //BRDF diffuseTerm, mul by Pixel and Vertex Lighting only
                half4 diffuseTerm = 1.0;
                if (float(1) == 1 && float(1) == 1 && float(1) == 1)
                {
                    half smoothnessdiffuseTerm = MetallicGlossMapSample().a * float(1);
                    const float perceptualRoughnessdiffuseTerm = SmoothnessToPerceptualRoughness (smoothnessdiffuseTerm);
                    half diffuseTerm0 = DisneyDiffuse(ndv, VLndl.x, ldh0, perceptualRoughnessdiffuseTerm) * VLndl.x;
                    half diffuseTerm1 = DisneyDiffuse(ndv, VLndl.y, ldh1, perceptualRoughnessdiffuseTerm) * VLndl.y;
                    half diffuseTerm2 = DisneyDiffuse(ndv, VLndl.z, ldh2, perceptualRoughnessdiffuseTerm) * VLndl.z;
                    half diffuseTerm3 = DisneyDiffuse(ndv, VLndl.w, ldh3, perceptualRoughnessdiffuseTerm) * VLndl.w;
                    diffuseTerm = lerp(1, half4(diffuseTerm0, diffuseTerm1, diffuseTerm2, diffuseTerm3), ReflectionMaskSample());//Mask diffuseTerm over ReflectionMask
                }

    
                //Diffuse Vertex Lights
                float4 VLNdLHalfing = VertexLightNdLNONMAX * float(0.5);
                VLNdLHalfing = saturate(VLNdLHalfing + float(0.5));
                float4 VLShadowsPreEnd = 0;
                if (float(1) == 1)
                {
                    float4 SCSVL = VLNdLHalfing * float(8);
                    SCSVL = floor(SCSVL);
                    SCSVL = saturate(SCSVL / (float(8) - 1));
                    
                    VLShadowsPre = SCSVL;
                    VLShadowsPreEnd = saturate(lerp(1, VLShadowsPre, float(1)));
            
                    float3 VLShadowsOne = lerp(VLShadowsPreEnd.x, RampColor, float(0));         // Shadow Coloring
                    VLShadowsOne = lerp(VLShadowsOne, 1, VLShadowsPreEnd.x);                                // Shadow Intensity
                    VLShadowsOne = VLShadowsOne * unity_LightColor[0] * VLAtten.x;                          // Attenuation and Light
                    VLShadowsOne *= diffuseTerm.x;                                                          // diffuseTerm
                    float3 VLShadowsTwo = lerp(VLShadowsPreEnd.y, RampColor, float(0));         // Shadow Coloring
                    VLShadowsTwo = lerp(VLShadowsTwo, 1, VLShadowsPreEnd.y);                                // Shadow Intensity
                    VLShadowsTwo = VLShadowsTwo * unity_LightColor[1] * VLAtten.y;                          // Attenuation and Light
                    VLShadowsTwo *= diffuseTerm.y;                                                          // diffuseTerm
                    float3 VLShadowsThree = lerp(VLShadowsPreEnd.z, RampColor, float(0));       // Shadow Coloring
                    VLShadowsThree = lerp(VLShadowsThree, 1, VLShadowsPreEnd.z);                            // Shadow Intensity
                    VLShadowsThree = VLShadowsThree * unity_LightColor[2] * VLAtten.z;                      // Attenuation and Light
                    VLShadowsThree *= diffuseTerm.z;                                                        // diffuseTerm
                    float3 VLShadowsFour = lerp(VLShadowsPreEnd.w, RampColor, float(0));        // Shadow Coloring
                    VLShadowsFour = lerp(VLShadowsFour, 1, VLShadowsPreEnd.w);                              // Shadow Intensity
                    VLShadowsFour = VLShadowsFour * unity_LightColor[3] * VLAtten.w;                        // Attenuation and Light
                    VLShadowsFour *= diffuseTerm.w;                                                         // diffuseTerm
                    
                    DiffuseVertexLights = VLShadowsOne + VLShadowsTwo + VLShadowsThree + VLShadowsFour;
                }
                else
                {
                    float3 ToonRampTexVLOne = ToonRampSample(VLNdLHalfing.x);
                    float3 ToonRampTexVLTwo = ToonRampSample(VLNdLHalfing.y);
                    float3 ToonRampTexVLThree = ToonRampSample(VLNdLHalfing.z);
                    float3 ToonRampTexVLFour = ToonRampSample(VLNdLHalfing.w);
                    float ToonRampTexVLOneLuminanced = LinearRgbToLuminance(ToonRampSample(VLNdLHalfing.x));
                    float ToonRampTexVLTwoLuminanced = LinearRgbToLuminance(ToonRampSample(VLNdLHalfing.y));
                    float ToonRampTexVLThreeLuminanced = LinearRgbToLuminance(ToonRampSample(VLNdLHalfing.z));
                    float ToonRampTexVLFourLuminanced = LinearRgbToLuminance(ToonRampSample(VLNdLHalfing.w));
                    float4 ToonRampTexVLCombined = float4(ToonRampTexVLOneLuminanced, ToonRampTexVLTwoLuminanced, ToonRampTexVLThreeLuminanced, ToonRampTexVLFourLuminanced);
                    
                    VLShadowsPre = ToonRampTexVLCombined;
                    VLShadowsPreEnd = saturate(lerp(1, VLShadowsPre, float(1)));
            
                    float3 VLShadowsOne = lerp(ToonRampTexVLOne, RampColor, float(0));          // Shadow Coloring
                    VLShadowsOne = lerp(VLShadowsOne, 1, VLShadowsPreEnd.x);                                // Shadow Intensity
                    VLShadowsOne = VLShadowsOne * unity_LightColor[0] * VLAtten.x;                          // Attenuation and Light
                    VLShadowsOne *= diffuseTerm.x;                                                          // diffuseTerm
                    float3 VLShadowsTwo = lerp(ToonRampTexVLTwo, RampColor, float(0));          // Shadow Coloring
                    VLShadowsTwo = lerp(VLShadowsTwo, 1, VLShadowsPreEnd.y);                                // Shadow Intensity
                    VLShadowsTwo = VLShadowsTwo * unity_LightColor[1] * VLAtten.y;                          // Attenuation and Light
                    VLShadowsTwo *= diffuseTerm.y;                                                          // diffuseTerm
                    float3 VLShadowsThree = lerp(ToonRampTexVLThree, RampColor, float(0));      // Shadow Coloring
                    VLShadowsThree = lerp(VLShadowsThree, 1, VLShadowsPreEnd.z);                            // Shadow Intensity
                    VLShadowsThree = VLShadowsThree * unity_LightColor[2] * VLAtten.z;                      // Attenuation and Light
                    VLShadowsThree *= diffuseTerm.z;                                                        // diffuseTerm
                    float3 VLShadowsFour = lerp(ToonRampTexVLFour, RampColor, float(0));        // Shadow Coloring
                    VLShadowsFour = lerp(VLShadowsFour, 1, VLShadowsPreEnd.w);                              // Shadow Intensity
                    VLShadowsFour = VLShadowsFour * unity_LightColor[3] * VLAtten.w;                        // Attenuation and Light
                    VLShadowsFour *= diffuseTerm.w;                                                         // diffuseTerm
                    
                    DiffuseVertexLights = VLShadowsOne + VLShadowsTwo + VLShadowsThree + VLShadowsFour;
                }
                DiffuseVertexLights *= OcclusionMap;
                DiffuseVertexLightingLuminanced = LinearRgbToLuminance(DiffuseVertexLights);
                if (float(0) == 1)
                {
                    DiffuseVertexLights = DiffuseVertexLightingLuminanced;
                }
    
                //VL Specular Highlight NdL with Toon Ramp setting
                float4 VLSpecNdL = float4(1,1,1,1);
                float4 VLSpecNdLRamp = inverseLerp4(-max(-0.99, float(0)), 1, VLShadowsPre);
                float4 VLSpecNdLRampt = saturate(float(0)) * 0.5;
                VLSpecNdLRampt = VLSpecNdLRampt * float(0) + VLSpecNdLRampt;
                VLSpecNdLRamp = saturate(lerp(VLSpecNdLRamp, 1, VLSpecNdLRampt));
                float4 ShadowsVLToonAniso = VLAtten;
                if (float(2) == 1)
                {
                    VLSpecNdL = VLndl;
                    ShadowsVLToonAniso = VLndl * VLAtten;
                }
                else if (float(2) == 2)
                {
                    VLSpecNdL = VLSpecNdLRamp;
                    ShadowsVLToonAniso = VLSpecNdLRamp * VLAtten;
                }
                //Subsurface Scattering
                half3 VLSSS0 = SSS(worldNormal, VLDirOne, unity_LightColor[0], VLAtten.x);
                half3 VLSSS1 = SSS(worldNormal, VLDirTwo, unity_LightColor[1], VLAtten.y);
                half3 VLSSS2 = SSS(worldNormal, VLDirThree, unity_LightColor[2], VLAtten.z);
                half3 VLSSS3 = SSS(worldNormal, VLDirFour, unity_LightColor[3], VLAtten.w);
                VLSubsurfaceScattering = VLSSS0 + VLSSS1 + VLSSS2 + VLSSS3;
                //BRDF Specular Highlight Specular workflow
                half3 SpecColorAdditionalSH = lerp(1, diffuseColor, float(1)) * float4(0.03921569,0.03921569,0.03921569,1).rgb; //For additional Specular Highlights we want to operate in Specular Workflow, not metallic
                half3 VertexLightSpecularBRDF0 = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, VLSpecNdL.x, ndv, VLndh0, ldh0, unity_LightColor[0] * VLAtten.x);
                half3 VertexLightSpecularBRDF1 = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, VLSpecNdL.y, ndv, VLndh1, ldh1, unity_LightColor[1] * VLAtten.y);
                half3 VertexLightSpecularBRDF2 = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, VLSpecNdL.z, ndv, VLndh2, ldh2, unity_LightColor[2] * VLAtten.z);
                half3 VertexLightSpecularBRDF3 = calcSpecularBRDF(smoothnessAdditionalSH, SpecColorAdditionalSH, VLSpecNdL.w, ndv, VLndh3, ldh3, unity_LightColor[3] * VLAtten.w);
                if (float(0) == 1 && float(0) == 1)
                    VertexLightSpecular = (VertexLightSpecularBRDF0 + VertexLightSpecularBRDF1 + VertexLightSpecularBRDF2 + VertexLightSpecularBRDF3) * SpecularMapSample().rgb * float4(0.03921569,0.03921569,0.03921569,1).a;

                //BRDF Specular Highlight Metallic workflow
                half3 VertexLightSpecularBRDFMetallicWF0 = calcSpecularBRDF(smoothness, specColor, VLSpecNdL.x, ndv, VLndh0, ldh0, unity_LightColor[0] * VLAtten.x);
                half3 VertexLightSpecularBRDFMetallicWF1 = calcSpecularBRDF(smoothness, specColor, VLSpecNdL.y, ndv, VLndh1, ldh1, unity_LightColor[1] * VLAtten.y);
                half3 VertexLightSpecularBRDFMetallicWF2 = calcSpecularBRDF(smoothness, specColor, VLSpecNdL.z, ndv, VLndh2, ldh2, unity_LightColor[2] * VLAtten.z);
                half3 VertexLightSpecularBRDFMetallicWF3 = calcSpecularBRDF(smoothness, specColor, VLSpecNdL.w, ndv, VLndh3, ldh3, unity_LightColor[3] * VLAtten.w);
                if (float(1) == 1 && float(1) == 1 && float(1) == 1)
                    VertexLightSpecular += (VertexLightSpecularBRDFMetallicWF0 + VertexLightSpecularBRDFMetallicWF1 + VertexLightSpecularBRDFMetallicWF2 + VertexLightSpecularBRDFMetallicWF3) * ReflectionMaskSample();
    
                //Calc Spec Aniso GGX
                half3 VertexLightSpecularAnisoGGX0 = calcSpecularAnisoGGX(VLndl.x, VLndh0, ndv, ldh0, smoothnessAdditionalSH, VLDirOne, unity_LightColor[0] * ShadowsVLToonAniso.x, VLhalfVector0, diffuseColor, tangent, bitangent);
                half3 VertexLightSpecularAnisoGGX1 = calcSpecularAnisoGGX(VLndl.y, VLndh1, ndv, ldh1, smoothnessAdditionalSH, VLDirTwo, unity_LightColor[1] * ShadowsVLToonAniso.y, VLhalfVector1, diffuseColor, tangent, bitangent);
                half3 VertexLightSpecularAnisoGGX2 = calcSpecularAnisoGGX(VLndl.z, VLndh2, ndv, ldh2, smoothnessAdditionalSH, VLDirThree, unity_LightColor[2] * ShadowsVLToonAniso.z, VLhalfVector2, diffuseColor, tangent, bitangent);
                half3 VertexLightSpecularAnisoGGX3 = calcSpecularAnisoGGX(VLndl.w, VLndh3, ndv, ldh3, smoothnessAdditionalSH, VLDirFour, unity_LightColor[3] * ShadowsVLToonAniso.w, VLhalfVector3, diffuseColor, tangent, bitangent);
                VertexLightSpecular += VertexLightSpecularAnisoGGX0 + VertexLightSpecularAnisoGGX1 + VertexLightSpecularAnisoGGX2 + VertexLightSpecularAnisoGGX3;

                //Calc Spec Toon
                half3 VertexLightSpecularToon0 = calcSpecularToon(VLndh0, diffuseColor, unity_LightColor[0], ShadowsVLToonAniso.x);
                half3 VertexLightSpecularToon1 = calcSpecularToon(VLndh1, diffuseColor, unity_LightColor[1], ShadowsVLToonAniso.y);
                half3 VertexLightSpecularToon2 = calcSpecularToon(VLndh2, diffuseColor, unity_LightColor[2], ShadowsVLToonAniso.z);
                half3 VertexLightSpecularToon3 = calcSpecularToon(VLndh3, diffuseColor, unity_LightColor[3], ShadowsVLToonAniso.w);
                VertexLightSpecular += VertexLightSpecularToon0 + VertexLightSpecularToon1 + VertexLightSpecularToon2 + VertexLightSpecularToon3;

                //Calc Spec Aniso "James O'Hare"
                half3 VertexLightSpecularAniso0 = calcSpecularAniso(worldNormal, VLhalfVector0, VLndh0, diffuseColor, unity_LightColor[0], ShadowsVLToonAniso.x);
                half3 VertexLightSpecularAniso1 = calcSpecularAniso(worldNormal, VLhalfVector1, VLndh1, diffuseColor, unity_LightColor[1], ShadowsVLToonAniso.y);
                half3 VertexLightSpecularAniso2 = calcSpecularAniso(worldNormal, VLhalfVector2, VLndh2, diffuseColor, unity_LightColor[2], ShadowsVLToonAniso.z);
                half3 VertexLightSpecularAniso3 = calcSpecularAniso(worldNormal, VLhalfVector3, VLndh3, diffuseColor, unity_LightColor[3], ShadowsVLToonAniso.w);
                VertexLightSpecular += VertexLightSpecularAniso0 + VertexLightSpecularAniso1 + VertexLightSpecularAniso2 + VertexLightSpecularAniso3;
            #endif
        #endif
    #endif
}

half3 getReflectionUV(half3 direction, half3 position, half4 cubemapPosition, half3 boxMin, half3 boxMax)
{
    #if UNITY_SPECCUBE_BOX_PROJECTION
    if (cubemapPosition.w > 0) {
        half3 factors = ((direction > 0 ? boxMax : boxMin) - position) / direction;
        half scalar = min(min(factors.x, factors.y), factors.z);
        direction = direction * scalar + (position - cubemapPosition);
    }
    #endif
    return direction;
}

half3 calcIndirectSpecular(half3 reflDir, half3 indirectLight, half OcclusionMap, half smoothness)
{//This function handls Unity style reflections and a baked in fallback cubemap.
    half3 spec = half3(0,0,0);
        #if defined(UNITY_PASS_FORWARDBASE)
        half3 reflectionUV1 = getReflectionUV(reflDir, input.worldPos, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);
        half roughness = 1-smoothness;
        roughness *= 1.7 - 0.7 * roughness;
        half4 probe0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectionUV1, roughness * UNITY_SPECCUBE_LOD_STEPS);
        half3 probe0sample = DecodeHDR(probe0, unity_SpecCube0_HDR);
        
        half3 indirectSpecular;
        half interpolator = unity_SpecCube0_BoxMin.w;

        
        if (interpolator < 0.99999)
        {
            half3 reflectionUV2 = getReflectionUV(reflDir, input.worldPos, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax);
            half4 probe1 = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflectionUV2, roughness * UNITY_SPECCUBE_LOD_STEPS);
            half3 probe1sample = DecodeHDR(probe1, unity_SpecCube1_HDR);
            indirectSpecular = lerp(probe1sample, probe0sample, interpolator);
        }
        else
        {
            indirectSpecular = probe0sample;
        }
        indirectSpecular *= OcclusionMap;
    
        float testW = 0;
        float testH = 0;
        unity_SpecCube0.GetDimensions(testW,testH);
        if (testW < 16 && float(0) == 0 || float(0) == 1)
        {
            indirectSpecular = texCUBElod(_Cubemap, half4(reflDir, roughness * UNITY_SPECCUBE_LOD_STEPS));
            indirectSpecular *= indirectLight; //indirectLight comes pre multiplied with the OcclusionMap
        }

        //No need to branch over this as we toggle all cubemap reflections on or off with float(1) and on top we are using this function for Rimlights too
        //if (float(1) == 1)
        //{
            spec = indirectSpecular;
        //}
        //else
        //{
        //    spec = unity_IndirectSpecColor;
        //}
        #endif
    
    return spec;
}

half3 BRDF1(half3 specColor, half oneMinusReflectivity, half smoothness, half3 gispecular, half ndv)
{
    //gispecular is already multiplied here with the occlusion map
    const float perceptualRoughness = SmoothnessToPerceptualRoughness (smoothness);

    // Diffuse term, doing this outside in an earlier step since we have a custom Lighting system
    //diffuseTerm = DisneyDiffuse(ndv, ndl, ldh, perceptualRoughness) * ndl;

    // Specular term
    // HACK: theoretically we should divide diffuseTerm by Pi and not multiply specularTerm!
    // BUT 1) that will make shader look significantly darker than Legacy ones
    // and 2) on engine side "Non-important" lights have to be divided by Pi too in cases when they are injected into ambient SH
    float roughness = PerceptualRoughnessToRoughness(perceptualRoughness);

    // GGX with roughtness to 0 would mean no specular at all, using max(roughness, 0.002) here to match HDrenderloop roughtness remapping.
    roughness = max(roughness, 0.002);
    
    // surfaceReduction = Int D(NdotH) * NdotH * Id(NdotL>0) dH = 1/(roughness^2+1)
    half surfaceReduction;
#   ifdef UNITY_COLORSPACE_GAMMA
        surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;      // 1-0.28*x^3 as approximation for (1/(x^4+1))^(1/2.2) on the domain [0;1]
#   else
        surfaceReduction = 1.0 / (roughness*roughness + 1.0);           // fade \in [0.5;1]
#   endif

    const half grazingTerm = saturate(smoothness + (1-oneMinusReflectivity));

    const half3 color = surfaceReduction * gispecular * FresnelLerp (specColor, grazingTerm, ndv);
    
    return color;
}

half3 calcMatcap(half3 worldNormal, half3 worldNormalIgnoredNormalMaps,  half3 MainTex, half3 PreClampFinalLight, half LuminancedLightNoShadows, half OcclusionMap, out half MatcapLightAbsobtion)
{
    if (float(0) == 1)
    {
        worldNormal = worldNormalIgnoredNormalMaps;
    }
    half4 MatcapMask = MatcapMaskSample();
    if (float(0))
        MatcapMask.r = 1-MatcapMask.r;
    if (float(0))
        MatcapMask.g = 1-MatcapMask.g;
    if (float(0))
        MatcapMask.b = 1-MatcapMask.b;
    if (float(0))
        MatcapMask.a = 1-MatcapMask.a;
    
    //Lighting (Matcap Base)
    const half3 LightingMul = saturate(LuminancedLightNoShadows) * MainTex * OcclusionMap; //No Shadows and clamp for pure illumination
    const half3 LightingAdd = PreClampFinalLight; //Additive colored Lighting
    
    //R1 Base + Modes
    const half3 MatcapR1Tex = MatcapR1Sample(worldNormal);
    const half3 MatcapR1Base = float4(1,1,1,1).rgb * float4(1,1,1,1).a * float(1) * float(1) * MatcapMask.r;
    const half3 MatcapR1Tint = lerp(1, MainTex, float(0));
    const half3 MatcapR1ModeMul = MatcapR1Tex * MatcapR1Base * LightingMul;
    const half3 MatcapR1ModeAdd = MatcapR1Tex * MatcapR1Base * LightingAdd;
    const half3 MatcapR1ModeSub = (1-MatcapR1Tex) * MatcapR1Base * LightingAdd;
    
    half3 MatcapR1 = 0;
    if (float(0) == 0 && float(1) == 1 && float(1) == 1)
    {
        MatcapR1 = MatcapR1ModeMul;
    }
    else if (float(0) == 1 && float(1) == 1 && float(1) == 1)
    {
        MatcapR1 = MatcapR1ModeAdd * MatcapR1Tint;
    }
    else if (float(0) == 2 && float(1) == 1 && float(1) == 1)
    {
        MatcapR1 = MatcapR1ModeSub * MatcapR1Tint;
    }

    //G2 Base + Modes
    const half3 MatcapG2Tex = MatcapG2Sample(worldNormal);
    const half3 MatcapG2Base = float4(1,1,1,1).rgb * float4(1,1,1,1).a * float(1) * float(1) * MatcapMask.g;
    const half3 MatcapG2Tint = lerp(1, MainTex, float(0));
    const half3 MatcapG2ModeMul = MatcapG2Tex * MatcapG2Base * LightingMul;
    const half3 MatcapG2ModeAdd = MatcapG2Tex * MatcapG2Base * LightingAdd;
    const half3 MatcapG2ModeSub = (1-MatcapG2Tex) * MatcapG2Base * LightingAdd;
    
    half3 MatcapG2 = 0;
    if (float(0) == 0 && float(0) == 1 && float(1) == 1)
    {
        MatcapG2 = MatcapG2ModeMul;
    }
    else if (float(0) == 1 && float(0) == 1 && float(1) == 1)
    {
        MatcapG2 = MatcapG2ModeAdd * MatcapG2Tint;
    }
    else if (float(0) == 2 && float(0) == 1 && float(1) == 1)
    {
        MatcapG2 = MatcapG2ModeSub * MatcapG2Tint;
    }

    //B3 Base + Modes
    const half3 MatcapB3Tex = MatcapB3Sample(worldNormal);
    const half3 MatcapB3Base = float4(1,1,1,1).rgb * float4(1,1,1,1).a * float(1) * float(1) * MatcapMask.b;
    const half3 MatcapB3Tint = lerp(1, MainTex, float(0));
    const half3 MatcapB3ModeMul = MatcapB3Tex * MatcapB3Base * LightingMul;
    const half3 MatcapB3ModeAdd = MatcapB3Tex * MatcapB3Base * LightingAdd;
    const half3 MatcapB3ModeSub = (1-MatcapB3Tex) * MatcapB3Base * LightingAdd;
    
    half3 MatcapB3 = 0;
    if (float(0) == 0 && float(0) == 1 && float(1) == 1)
    {
        MatcapB3 = MatcapB3ModeMul;
    }
    else if (float(0) == 1 && float(0) == 1 && float(1) == 1)
    {
        MatcapB3 = MatcapB3ModeAdd * MatcapB3Tint;
    }
    else if (float(0) == 2 && float(0) == 1 && float(1) == 1)
    {
        MatcapB3 = MatcapB3ModeSub * MatcapB3Tint;
    }

    //A4 Base + Modes
    const half3 MatcapA4Tex = MatcapA4Sample(worldNormal);
    const half3 MatcapA4Base = float4(1,1,1,1).rgb * float4(1,1,1,1).a * float(1) * float(1) * MatcapMask.a;
    const half3 MatcapA4Tint = lerp(1, MainTex, float(0));
    const half3 MatcapA4ModeMul = MatcapA4Tex * MatcapA4Base * LightingMul;
    const half3 MatcapA4ModeAdd = MatcapA4Tex * MatcapA4Base * LightingAdd;
    const half3 MatcapA4ModeSub = (1-MatcapA4Tex) * MatcapA4Base * LightingAdd;
    
    half3 MatcapA4 = 0;
    if (float(0) == 0 && float(0) == 1 && float(1) == 1)
    {
        MatcapA4 = MatcapA4ModeMul;
    }
    else if (float(0) == 1 && float(0) == 1 && float(1) == 1)
    {
        MatcapA4 = MatcapA4ModeAdd * MatcapA4Tint;
    }
    else if (float(0) == 2 && float(0) == 1 && float(1) == 1)
    {
        MatcapA4 = MatcapA4ModeSub * MatcapA4Tint;
    }

    //Lightabsorbtion
    MatcapLightAbsobtion = 0;
    if (float(1) == 1 && float(0) == 0 && float(1) == 1)
    {
        MatcapLightAbsobtion = float(1) * MatcapMask.r;
    }
    if (float(0) == 1 && float(0) == 0 && float(1) == 1)
    {
        MatcapLightAbsobtion += float(1) * MatcapMask.g;
    }
    if (float(0) == 1 && float(0) == 0 && float(1) == 1)
    {
        MatcapLightAbsobtion += float(1) * MatcapMask.b;
    }
    if (float(0) == 1 && float(0) == 0 && float(1) == 1)
    {
        MatcapLightAbsobtion += float(1) * MatcapMask.a;
    }
    MatcapLightAbsobtion = saturate(MatcapLightAbsobtion);
    
    return MatcapR1 + MatcapG2 + MatcapB3 + MatcapA4;
}

half3 RimLight(float NdV, float3 MainTex, float3 PrecalculatedLight, float3 IndirectSpecular, uint facing)
{
    float RimMask = RimMaskSample();
    if (_RimLightMaskinv == 1)
    {
        RimMask = 1-RimMaskSample();
    }
    float Fresnel = float(0) + float(1) * pow( 1.0 - NdV, float(5) );
    Fresnel = clamp(Fresnel, 0, 10);

    const float CustomFresnel = pow(1.0 - saturate(NdV + float(0.097)) , max(float(5), 1E-06 + 1E-06));

    float FresnelMode = CustomFresnel;
    if (float(0) == 1)
    {
        FresnelMode = Fresnel;
    }

    const float3 RimTint = LerpWhiteTo(MainTex, float(0.731));

    float3 IndirectSpecularLight = 0;
    if (float(0) == 1)
    {
        IndirectSpecularLight = IndirectSpecular * FresnelMode;
    }
    IndirectSpecularLight = IndirectSpecularLight * RimTint * RimMask * float(0.25);
    
    float3 FresnelLighting = FresnelMode * PrecalculatedLight * RimTint * RimMask * float4(0,1,0.3690176,0);
    FresnelLighting += IndirectSpecularLight;


    const float3 FresnelLightingFrontFace = facing>0?FresnelLighting:float3(0, 0, 0);
    const float3 FresnelLightingBackFace = facing>0?float3(0, 0, 0):FresnelLighting;

    float3 RimLight = FresnelLighting;
    if (float(1) == 1)
    {
        RimLight = FresnelLightingFrontFace;
    }
    else if (float(1) == 2)
    {
        RimLight = FresnelLightingBackFace;
    }

    if(float(1) == 0 || float(1) == 0)
    {
        RimLight = 0.0;
    }
    return RimLight;
}

void ShadowEmissiveRim(half ndv, out half ShadowRim, out half3 EmissiveRim)
{
    half3 EmissiveRimHueShift = 1;
    if (float(0) > 0)
    {
        EmissiveRimHueShift = HSVToRGB(float3(_Time.y * float(0), 1, 1));
    }
    
    ShadowRim = lerp(1, smoothstep(min(float(1), 1), 1.000001, ndv + float(0.75)), float(0));
    EmissiveRim = (1-ShadowRim) * float4(1,1,1,0).rgb * EmissiveRimHueShift;
    
    //EmissiveRim needs to be 0 before the if statement
    if (float(0) == 0)
    {
        EmissiveRim = 0;
    }
    if (float(0) == 1)
    {
        ShadowRim = 1;
    }
}

//Emissive stuff
half3 BasicEmission(half3 MainTex, half luminancedLight)
{
    half3 calcEmission = EmissionSample() * float4(0,0.04407716,1,1) * lerp(1, MainTex, float(1));
    half3 emissionLightScaled = lerp(calcEmission, 0, saturate(float(0) * luminancedLight));
    return emissionLightScaled;
}

half3 EmissionScrollV1(half3 MainTex)
{
    half2 NoiseTexUV = UVSwitch(float(0));
    NoiseTexUV *= float4(1,1,0,0).xy + float4(1,1,0,0).zw;
    const half2 NoiseTexPannerRandOffs = (_Time.y * float(0.1)) * float4(0,1,0,0) + NoiseTexUV + 0.25;
    const half2 NoiseTexPannerInverted = 1-(_Time.y * float(0.1) * 2.179) * float4(0,1,0,0) + NoiseTexUV;
    const half3 NoiseTex = NoiseTextureSample(NoiseTexPannerRandOffs) * NoiseTextureSample(NoiseTexPannerInverted);

    half2 ScrollTexUV = input.vertex.xy;
    ScrollTexUV *= float4(1,1,0,0).xy + float4(1,1,0,0).zw;
    const half2 ScrollTexPanner = (_Time.y * float(0)) * float4(0,1,0,0) + ScrollTexUV;
    const half3 ScrollTex = EmissionscrollSample(ScrollTexPanner);

    const half3 EmissionScroll = NoiseTex * ScrollTex * EmissionScrollMaskSample().r * float4(0,0.2405078,1,1);
    const half3 DiffuseTint = LerpWhiteTo(MainTex, float(1));
    return EmissionScroll * DiffuseTint;
}

half3 EmissionScrollV2(half2 tangentNormalsXY, half3 worldNormal, half3 worldNormalIgnoredNormalMaps, half3 MainTex, out half3 finalAudioLink)
{
    //Methods
    if (float(0) == 1)
    {
        tangentNormalsXY = float2(0, 0);
        worldNormal = worldNormalIgnoredNormalMaps;
    }
    const half NdV = dot(worldNormal, calcViewDir());
    const half2 vertexNormal = input.normal.xy + tangentNormalsXY;
    const half fresnelCamera = pow(1.0 - NdV, 5);
    const half2 vertexPos = (input.vertex.xy + tangentNormalsXY) * 10;
    half2 voronoiData = half2(0, 0);
    const half voronoiTime = _Time.y * float(1);
    half voronoi = Voronoi(vertexPos * float(1), voronoiTime, voronoiData, voronoiData, 0, voronoiData);
    const half2 vertexUV = input.uv0 + tangentNormalsXY;

    half2 renderMethod = vertexNormal;
    if (_ESRenderMethod == 1)
        renderMethod = fresnelCamera;
    else if (_ESRenderMethod == 2)
        renderMethod = vertexPos;
    else if (_ESRenderMethod == 3)
        renderMethod = voronoi;
    else if (_ESRenderMethod == 4)
        renderMethod = vertexUV;
    
    renderMethod = dot(renderMethod, float4(0,2,0,0));

    
    //Emission Scroll base calculation with AudioLink corrections
    float w = 0;
    float h = 0;
    _AudioTexture.GetDimensions(w, h);
    const float audioLinkCheckwithToggle = ( w + float(2) );
    const float audioLinkV1SizeCheck = (( audioLinkCheckwithToggle >= 33.0 && audioLinkCheckwithToggle <= 35.0 ) ? 1.0 :  0.0 );
    const float audioLinkV2SizeCheck = (( audioLinkCheckwithToggle >= 129.0 && audioLinkCheckwithToggle <= 131.0 ) ? 1.0 :  0.0 );
    //const float audioLinkTextureCheck = audioLinkV1SizeCheck || audioLinkV2SizeCheck;
    const float audioLinkTextureCheck = w > 31;
    
    half emissionScrollSharpness = float(0);
    if (audioLinkTextureCheck == 1)
    {
        emissionScrollSharpness = 0;
    }
    half emissionScrollSize = float(1);
    if (audioLinkTextureCheck == 1)
    {
        emissionScrollSize = 1;
    }

    half emissionScrollVectorCalc = (_Time.y * float(0.5)) + float(0);
    emissionScrollVectorCalc -= renderMethod;
    emissionScrollVectorCalc = frac(emissionScrollVectorCalc);
    emissionScrollVectorCalc /= emissionScrollSize;
    emissionScrollVectorCalc = 1-emissionScrollVectorCalc;
    emissionScrollVectorCalc = pow(emissionScrollVectorCalc, 1-emissionScrollSharpness);
    emissionScrollVectorCalc += 0.000001;
    emissionScrollVectorCalc += float(0);
    emissionScrollVectorCalc = saturate(emissionScrollVectorCalc);

    half3 emissionScrollBase = emissionScrollVectorCalc * float4(0,0.2405078,1,1).rgb * EmissionScrollMaskSample().r;

    
    //AudioLink Bands
    half audioLinkBandHistory = float(80);
    if (w == 32)
    {
        audioLinkBandHistory = 32;
    }
    audioLinkBandHistory *= emissionScrollVectorCalc;

    const half audioLinkLerp1 = AudioLinkLerp(ALPASS_AUDIOLINK + float2(audioLinkBandHistory, saturate(input.uv0.y)    )).r * float4(1,0.25,0.25,0.25).r; //saturate here due to issues in AudioLink
    const half audioLinkLerp2 = AudioLinkLerp(ALPASS_AUDIOLINK + float2(audioLinkBandHistory, saturate(input.uv0.y) + 1)).r * float4(1,0.25,0.25,0.25).g;
    const half audioLinkLerp3 = AudioLinkLerp(ALPASS_AUDIOLINK + float2(audioLinkBandHistory, saturate(input.uv0.y) + 2)).r * float4(1,0.25,0.25,0.25).b;
    const half audioLinkLerp4 = AudioLinkLerp(ALPASS_AUDIOLINK + float2(audioLinkBandHistory, saturate(input.uv0.y) + 3)).r * float4(1,0.25,0.25,0.25).a;
    half audioLinkV1V2Bands = audioLinkLerp1 + audioLinkLerp2 + audioLinkLerp3 + audioLinkLerp4;
    audioLinkV1V2Bands *= EmissionScrollMaskSample().r;

    
    //Waveform calc and sample
	const float waveformRotcos = cos(float(0) * UNITY_PI);
	const float waveformRotsin = sin(float(0) * UNITY_PI);
    const float2x2 UVRotate = float2x2(waveformRotcos, -waveformRotsin, waveformRotsin, waveformRotcos);

    //If the material is shifted for the Inventory System then we need to shift the UVs according to the new position if not at 0-1
    const float2 UVShift = float2(float(0), 0);
    
    const float2 waveformTiling = float2(float4(1,1,0,0).x, float4(1,1,0,0).y);
    const float2 waveformOffset = float2(float4(1,1,0,0).z, float4(1,1,0,0).w);
    const float2 UVs = mul((input.uv0.xy - UVShift + waveformOffset - 0.5) * waveformTiling, UVRotate).xy + 0.5; // -0.5 then +0.5 shift the center of the coordinates to (0,0) then after calculation to (0.5,0.5)

    const float Waveformsample = AudioLinkWaveformsample(UVs, float(0.578)).y;
    
    const float WaveformsampleMirrored = AudioLinkWaveformsample(float2(UVs.x, 1.0-UVs.y), float(0.578)).y;
    
    const float waveformsampleMirrorFilled = AudioLinkWaveformsampleMirrorFilled(UVs).y;
    
    
    //Waveform UV Clamp
    const float UVsmax = floor(max(UVs.x, UVs.y));
    const float UVsmin = floor(1.0-min(UVs.x, UVs.y));
    const float UVsSplit = 1.0-(UVsmax || UVsmin);


    //Final stuff
    float waveformMode = Waveformsample;
    if(float(0) == 1)
    {
        waveformMode = max(Waveformsample, WaveformsampleMirrored);
    }
    else if(float(0) == 2)
    {
        waveformMode = waveformsampleMirrorFilled;
    }
    
    const float AudioLinkWaveform = waveformMode * UVsSplit * float4(0.6051182,1,0,1).a * EmissionScrollMaskSample().g;


    float audioLinkSelector = 0;
    if (float(2) == 1)
    {
        audioLinkSelector = audioLinkV1V2Bands;
    }
    else if (float(2) == 2)
    {
        audioLinkSelector = AudioLinkWaveform;
    }
    else if (float(2) == 3)
    {
        audioLinkSelector = audioLinkV1V2Bands + AudioLinkWaveform;
    }

    float3 HueShift = HSVToRGB(half3(_Time.y * float(0.7), 1, 1));
    HueShift *= max(max(float4(0.6051182,1,0,1).r, float4(0.6051182,1,0,1).g), float4(0.6051182,1,0,1).b);

    float3 AudioLinkColor = float4(0.6051182,1,0,1).rgb;
    if (float(0.7) > 0)
    {
        AudioLinkColor = HueShift;
    }
    
    if (audioLinkTextureCheck == 1)
    {
        finalAudioLink = audioLinkSelector * AudioLinkColor;
        emissionScrollBase = finalAudioLink;
    }

    const half3 DiffuseTint = LerpWhiteTo(MainTex, float(1));
    emissionScrollBase *= DiffuseTint;

    return emissionScrollBase;
}

void DecalsAndFlipbook(inout half3 MainTex, out half3 EmissiveOutput, half3 AudioLinkEffect, int FunctionToggle, half Rotator, int WrapMode, half Tint, fixed4 Color, int Mode, int UVShiftProp, int UVSwitchProp, bool IsFlipbook, float4 Tex2D_ST, Texture2D Tex2D)
{
    EmissiveOutput = 0;
    const float2 inputUVs = UVSwitch(UVSwitchProp);
    const float2 UVShift = float2(UVShiftProp, 0);
    const half RotCos = cos(Rotator * UNITY_PI);
    const half RotSin = sin(Rotator * UNITY_PI);
    const float2x2 UVRotate = float2x2(RotCos, -RotSin, RotSin, RotCos);
    float2 UVs = mul((inputUVs - UVShift + Tex2D_ST.zw - 0.5) * Tex2D_ST.xy, UVRotate).xy + 0.5; // -0.5 then +0.5 shift the center of the coordinates to (0,0) then after calculation to (0.5,0.5)
    
    //UV Calc
    half2 UVcalc = UVs;
    if (IsFlipbook)
    {
        const half2 divisor = half2(float(0), float(0)) + 1e-10;
        const half totalFrames = float(0) * float(0) + 1e-10;
        const half mulTime = _Time.y * float(6);
        const half clampTotalFrames = clamp(0, 0.0001, totalFrames - 1); //0.0 for Start Frame
        const half frameData = frac((fmod(mulTime, float(1)) + clampTotalFrames) / totalFrames);
        const half2 combinedFrameData = half2(frameData, 1-frameData);
        UVcalc = UVs / divisor + floor(half2(totalFrames, float(0) + 1e-10) * combinedFrameData) / divisor;
    }

    //Texture Sample
    const half4 decalTex = Tex2D.Sample(sampler_linear_repeat, UVcalc);

    //AudioLink
    const half3 DecalTint = LerpWhiteTo(decalTex, float(1));
    AudioLinkEffect *= DecalTint;

    //Clamp
    const half maxLevels = floor(max(UVs.x, UVs.y));
    const half minLevels = floor(1-min(UVs.x, UVs.y));
    half uvSplit = 1;
    if (WrapMode == 1)
        uvSplit = 1-(maxLevels || minLevels);
        

    //Final Decal
    const half3 lightingAndTint = lerp(1, MainTex, Tint);
    
    const half3 DecalAdd = lerp(AudioLinkEffect + decalTex.rgb * Color.rgb * lightingAndTint, 0, 1-decalTex.a * Color.a * uvSplit);
    const half3 DecalMul = lerp(AudioLinkEffect + decalTex.rgb * Color.rgb * lightingAndTint, MainTex, 1-decalTex.a * Color.a * uvSplit);
    
    if (Mode == 0 && (FunctionToggle == 1 && float(1) == 1))
        MainTex = DecalMul;
    else if (Mode == 1 && (FunctionToggle == 1 && float(1) == 1))
        MainTex += DecalAdd;
    else if (Mode == 2 && (FunctionToggle == 1 && float(1) == 1))
    EmissiveOutput = DecalAdd;
}

#endif//end
