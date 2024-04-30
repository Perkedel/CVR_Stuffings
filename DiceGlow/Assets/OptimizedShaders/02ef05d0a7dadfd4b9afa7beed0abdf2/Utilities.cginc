#ifndef UTILITIES_INCLUDED
#define UTILITIES_INCLUDED

//General stuff
float2 UVSwitch(int UVSwitchProp)
{
	[forcecase] switch (UVSwitchProp)
	{
	case 1:
		return input.uv1;
	case 2:
		return input.uv2;
	case 3:
		return input.uv3;
	default: return input.uv0;
	}
}

#ifndef UNITY_PASS_FORWARD_OUTLINE
half3 calcViewDir()
{
	const half3 viewDir = _WorldSpaceCameraPos - input.worldPos;
	return normalize(viewDir);
}

half3 calcStereoViewDir()
{
	#if UNITY_SINGLE_PASS_STEREO
	half3 cameraPos = half3((unity_StereoWorldSpaceCameraPos[0]+ unity_StereoWorldSpaceCameraPos[1])*.5);
	#else
	const half3 cameraPos = _WorldSpaceCameraPos;
	#endif
	const half3 viewDir = cameraPos - input.worldPos;
	return viewDir; //on use check if needs to be normalized
}

#else
half3 calcViewDir()
{
	const half3 viewDir = _WorldSpaceCameraPos - input.worldPos;
	return -normalize(viewDir);
}

half3 calcStereoViewDir()
{
	#if UNITY_SINGLE_PASS_STEREO
	half3 cameraPos = half3((unity_StereoWorldSpaceCameraPos[0]+ unity_StereoWorldSpaceCameraPos[1])*.5);
	#else
	const half3 cameraPos = _WorldSpaceCameraPos;
	#endif
	const half3 viewDir = cameraPos - input.worldPos;
	return -normalize(viewDir); //on use check if needs to be normalized
}
#endif



half3 calcReflView(half3 worldnormal)
{
	return reflect(-calcViewDir(), worldnormal);
}

half3 calcReflLight(half3 lightDir, half3 worldnormal)
{
	return reflect(lightDir, worldnormal);
}
//General stuff end

//Lighting stuff
half3 calcLightDir()
{
	return normalize(UnityWorldSpaceLightDir(input.worldPos));
}

half3 calcLightDirAmbient()
{
	//Source: "https://web.archive.org/web/20160313132301/http://www.geomerics.com/wp-content/uploads/2015/08/CEDEC_Geomerics_ReconstructingDiffuseLighting1.pdf" Page 18
	return normalize(unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz);
}

float CorrectNegativeNdotV(float3 viewDir, float3 worldnormal)
{
	#define UNITY_HANDLE_CORRECTLY_NEGATIVE_NDOTV 0
	#if UNITY_HANDLE_CORRECTLY_NEGATIVE_NDOTV
	// The amount we shift the normal toward the view vector is defined by the dot product.
	half shiftAmount = dot(normal, viewDir);
	normal = shiftAmount < 0.0f ? normal + viewDir * (-shiftAmount + 1e-5f) : normal;
	// A re-normalization should be applied here but as the shift is small we don't do it to save ALU.
	//normal = normalize(normal);
	float nv = saturate(dot(normal, viewDir)); // TODO: this saturate should no be necessary here
	#else
	half nv = abs(dot(worldnormal, viewDir));    // This abs allow to limit artifact
	#endif
	return nv;
}

float V_SmithGGXCorrelated_Anisotropic(const float at, const float ab, const float ToV, const float BoV, const float ToL, const float BoL, const float NoV, const float NoL)
{
	const float lambdaV = NoL * length(float3(at * ToV, ab * BoV, NoV));
	const float lambdaL = NoV * length(float3(at * ToL, ab * BoL, NoL));
	const float v = 0.5 / (lambdaV + lambdaL);
	return saturate(v);
}

float D_GGX_Anisotropic(const float NoH, const float3 h, const float3 t, const float3 b, const float at, const float ab)
{
	const float ToH = dot(t, h);
	const float BoH = dot(b, h);
	const float a2 = at * ab;
	const float3 v = float3(ab * ToH, at * BoH, a2 * NoH);
	const float v2 = dot(v, v);
	const float w2 = a2 / v2;
	return a2 * w2 * w2 * (1.0 / UNITY_PI);
}

float shEvaluateDiffuseL1Geomerics_local(float L0, float3 L1, float3 n)
{
	/* http://www.geomerics.com/wp-content/uploads/2015/08/CEDEC_Geomerics_ReconstructingDiffuseLighting1.pdf */
	// average energy
	// Add max0 to fix an issue caused by probes having a negative ambient component (???)
	// I'm not sure how normal that is but this can't handle it
	const float R0 = max(L0, 0);

	// avg direction of incoming light
	const float3 R1 = 0.5f * L1;

	// directional brightness
	const float lenR1 = length(R1);

	// linear angle between normal and direction 0-1
	float q = dot(normalize(R1), n) * 0.5 + 0.5;
	q = saturate(q); // Thanks to ScruffyRuffles for the bug identity.

	// power for q
	// lerps from 1 (linear) to 3 (cubic) based on directionality
	const float p = 1.0f + 2.0f * lenR1 / R0;

	// dynamic range constant
	// should vary between 4 (highly directional) and 0 (ambient)
	const float a = (1.0f - lenR1 / R0) / (1.0f + lenR1 / R0);

	return R0 * (a + (1.0f - a) * (p + 1.0f) * pow(q, p));
}

half3 BetterSH9(half4 normal) {
	float3 indirect;
	float3 L0 = float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w)
	 + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
	indirect.r = shEvaluateDiffuseL1Geomerics_local(L0.r, unity_SHAr.xyz, normal);
	indirect.g = shEvaluateDiffuseL1Geomerics_local(L0.g, unity_SHAg.xyz, normal);
	indirect.b = shEvaluateDiffuseL1Geomerics_local(L0.b, unity_SHAb.xyz, normal);
	indirect = max(0, indirect);
	indirect += SHEvalLinearL2(normal);
	return indirect;
}

float rcpSqrtIEEEIntApproximation(float inX, const int inRcpSqrtConst)
{
	int x = asint(inX);
	x = inRcpSqrtConst - (x >> 1);
	return asfloat(x);
}

float fastRcpSqrtNR0(float inX)
{
	const float  xRcpSqrt = rcpSqrtIEEEIntApproximation(inX, 0x5f3759df);
	return xRcpSqrt;
}

void Shade4PointLights(float3 normal,
	out half4 VertexLightNdLNONMAX, out half4 ndl, out half4 attenuation,
	out half3 VLDirOne, out half3 VLDirTwo, out half3 VLDirThree, out half3 VLDirFour)
{
	// to light vectors
	float4 toLightX = unity_4LightPosX0 - input.worldPos.x;
	float4 toLightY = unity_4LightPosY0 - input.worldPos.y;
	float4 toLightZ = unity_4LightPosZ0 - input.worldPos.z;
	// squared lengths
	float4 lengthSq = 0;
	lengthSq += toLightX * toLightX;
	lengthSq += toLightY * toLightY;
	lengthSq += toLightZ * toLightZ;
	// don't produce NaNs if some vertex position overlaps with the light
	lengthSq = max(lengthSq, 0.000001);

	// NdotL
	float4 ndotl = 0;
	ndotl += toLightX * normal.x;
	ndotl += toLightY * normal.y;
	ndotl += toLightZ * normal.z;
	// correct NdotL
	float4 corr = 0;//rsqrt(lengthSq);
	corr.x = fastRcpSqrtNR0(lengthSq.x);
	corr.y = fastRcpSqrtNR0(lengthSq.y);
	corr.z = fastRcpSqrtNR0(lengthSq.z);
	corr.w = fastRcpSqrtNR0(lengthSq.w);

	ndotl = corr * ndotl;
	VertexLightNdLNONMAX = ndotl;
	ndotl = max (float4(0,0,0,0), ndotl);
	// attenuation
	// Fixes popin. Thanks, d4rkplayer!
	float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
	const float4 atten2 = saturate(1 - (lengthSq * unity_4LightAtten0 / 25));
	atten = min(atten, atten2 * atten2);

	//out params
	ndl = ndotl;
	attenuation = atten;
	VLDirOne = normalize(float3(toLightX.x, toLightY.x, toLightZ.x));
	VLDirTwo = normalize(float3(toLightX.y, toLightY.y, toLightZ.y));
	VLDirThree = normalize(float3(toLightX.z, toLightY.z, toLightZ.z));
	VLDirFour = normalize(float3(toLightX.w, toLightY.w, toLightZ.w));

	//For Standard Diffuse Vertex Lights, does not have the #ifdef LIGHTMAP_ON #elif UNITY_SHOULD_SAMPLE_SH...
	//ndotl = saturate(ndotl * float(0.5));
	//ndotl = lerp(ndotl, 1, _ShadowLift);
	//float4 diff = ndotl * atten;
	//const float3 VLFinalOne = diff.x * unity_LightColor[0];
	//const float3 VLFinalTwo = diff.y * unity_LightColor[1];
	//const float3 VLFinalThree = diff.z * unity_LightColor[2];
	//const float3 VLFinalFour = diff.w * unity_LightColor[3];
	//return VLFinalOne + VLFinalTwo + VLFinalThree + VLFinalFour;
}

float GSAA_Filament(float3 normal, float perceptualRoughness)
{
	// Kaplanyan 2016, "Stable specular highlights"
	// Tokuyoshi 2017, "Error Reduction and Simplification for Shading Anti-Aliasing"
	// Tokuyoshi and Kaplanyan 2019, "Improved Geometric Specular Antialiasing"
				
	// This implementation is meant for deferred rendering in the original paper but
	// we use it in forward rendering as well (as discussed in Tokuyoshi and Kaplanyan
	// 2019). The main reason is that the forward version requires an expensive transform
	// of the float vector by the tangent frame for every light. This is therefore an
	// approximation but it works well enough for our needs and provides an improvement
	// over our original implementation based on Vlachos 2015, "Advanced VR Rendering".

	const float3 du = ddx(normal);
	const float3 dv = ddy(normal);

	const float variance = float(0.15) * (dot(du, du) + dot(dv, dv));

	const float roughness = perceptualRoughness * perceptualRoughness;
	const float kernelRoughness = min(2.0 * variance, float(0.1));
	const float squareRoughness = saturate(roughness * roughness + kernelRoughness);

	return 1-sqrt(sqrt(squareRoughness));
}
//Lighting stuff end

float3 HSVToRGB( float3 c )
{
	float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
	float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
	return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
}

float inverseLerp(float a, float b, float t)
{
	return (t - a) / (b - a);
}

float4 inverseLerp4(float a, float b, float4 t)
{
	return (t - a) / (b - a);
}

half2 VoronoiHash( half2 p )
{
	p = half2( dot( p, half2( 127.1, 311.7 ) ), dot( p, half2( 269.5, 183.3 ) ) );
	return frac( sin( p ) *43758.5453);
}

half Voronoi( half2 v, half time, inout half2 id, inout half2 mr, half smoothness, inout half2 smoothId )
{
	half2 n = floor( v );
	half2 f = frac( v );
	half F1 = 8.0;
	half F2 = 8.0; half2 mg = 0;
	for ( int j = -1; j <= 1; j++ )
	{
		for ( int i = -1; i <= 1; i++ )
		{
			half2 g = half2( i, j );
			half2 o = VoronoiHash( n + g );
			o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); half2 r = f - g - o;
			half d = 0.5 * dot( r, r );
			if( d<F1 ) {
				F2 = F1;
				F1 = d; mg = g; mr = r; id = o;
			} else if( d<F2 ) {
				F2 = d;
			
			}
		}
	}
	return F1;
}

//Texture Samples with common additions
float4 SpecularMapSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float3 AnisoDirSample()
{
	const float2 UV = UVSwitch(float(0));
return half3(0, 0, 1);
}

float4 MainTexSample()
{
	const float2 UV = UVSwitch(_MainTexUVSwitch);
	return UNITY_SAMPLE_TEX2D(_MainTex, UV * float4(1,1,0,0).xy + float4(1,1,0,0).zw);
}

float HueMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float HueMaskSamplePoint()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float3 ToonRampSample(float uv)
{
	return UNITY_SAMPLE_TEX2D_SAMPLER(_ToonRamp, _linear_clamp, uv);
}

float2 ShadowMaskSample()
{
return half4(1, 1, 1, 1);
}

float3 ShadowColorMapSample()
{
return half4(0, 0, 0, 0);
}

float3 TangentNormalSample()
{
	const float2 UV = UVSwitch(float(0));
return half3(0, 0, 1);
}

float3 DetailedTangentNormalSample()
{
	const float2 UV = UVSwitch(float(0));
return half3(0, 0, 1);
}

float2 NormalMapMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float OcclusionMapSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float4 MetallicGlossMapSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float ReflectionMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float3 SSSThickenessMapSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

half2 matcapSample(half3 worldnormal)
{
	const half3 worldUp = float3(0,1,0);
	half3 viewDir = calcViewDir();
	if (float(0) == 1)
	{
		viewDir = normalize(WorldSpaceViewDir(float4(0,0,0,1)));
	}
	const half3 worldViewUp = normalize(worldUp - viewDir * dot(viewDir, worldUp));
	const half3 worldViewRight = normalize(cross(viewDir, worldViewUp));
	half2 matcapUV = half2(dot(worldViewRight, worldnormal), dot(worldViewUp, worldnormal)) * 0.5 + 0.5;
	return matcapUV;
}

float3 MatcapR1Sample(half3 worldnormal)
{
	const float2 UV = matcapSample(worldnormal);
	return UNITY_SAMPLE_TEX2D_SAMPLER_LOD(_MatcapR1, _trilinear_repeat, UV * float4(1,1,0,0).xy + float4(1,1,0,0).zw, (1-float(1)) * 10);
}

float3 MatcapG2Sample(half3 worldnormal)
{
	const float2 UV = matcapSample(worldnormal);
return half4(1, 1, 1, 1);
}

float3 MatcapB3Sample(half3 worldnormal)
{
	const float2 UV = matcapSample(worldnormal);
return half4(1, 1, 1, 1);
}

float3 MatcapA4Sample(half3 worldnormal)
{
	const float2 UV = matcapSample(worldnormal);
return half4(1, 1, 1, 1);
}

float4 MatcapMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float RimMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

float3 EmissionSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(0, 0, 0, 0);
}

float3 NoiseTextureSample(half2 UV)
{
return half4(1, 1, 1, 1);
}

float3 EmissionscrollSample(half2 UV)
{
return half4(1, 1, 1, 1);
}

float2 EmissionScrollMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}

half4 DecalMaskSample()
{
	const float2 UV = UVSwitch(float(0));
return half4(1, 1, 1, 1);
}
//Texture Samples end


#endif //END
