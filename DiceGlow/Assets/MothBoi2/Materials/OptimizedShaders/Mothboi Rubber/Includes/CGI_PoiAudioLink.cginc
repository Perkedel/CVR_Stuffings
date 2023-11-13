#ifndef POI_AUDIOLINK
#define POI_AUDIOLINK

UNITY_DECLARE_TEX2D(_AudioTexture);
float4 _AudioTexture_ST;
fixed _AudioLinkDelay;
fixed _AudioLinkAveraging;
fixed _AudioLinkAverageRange;

// Debug
fixed _EnableAudioLinkDebug;
fixed _AudioLinkDebugTreble;
fixed _AudioLinkDebugHighMid;
fixed _AudioLinkDebugLowMid;
fixed _AudioLinkDebugBass;
fixed _AudioLinkDebugAnimate;
fixed _AudioLinkTextureVisualization;
fixed _AudioLinkAnimToggle;

void AudioTextureExists()
{
	half testw = 0;
	half testh = 0;
	_AudioTexture.GetDimensions(testw, testh);
	poiMods.audioLinkTextureExists = testw >= 32;
	poiMods.audioLinkTextureExists *= float(1);
	switch(testw)
	{
		case 32: // V1
		poiMods.audioLinkVersion = 1;
		break;
		case 128: // V2
		poiMods.audioLinkVersion = 2;
		break;
		default:
		poiMods.audioLinkVersion = 1;
		break;
	}
}

float getBandAtTime(float band, fixed time, fixed width)
{
	float versionUvMultiplier = 1;

	if (poiMods.audioLinkVersion == 2)
	{
		versionUvMultiplier = 0.0625;
	}
	return UNITY_SAMPLE_TEX2D(_AudioTexture, float2(time * width, (band * .25 + .125) * versionUvMultiplier)).r;
}

void initAudioBands()
{
	AudioTextureExists();

	float versionUvMultiplier = 1;

	if (poiMods.audioLinkVersion == 2)
	{
		versionUvMultiplier = 0.0625;
	}

	if (poiMods.audioLinkTextureExists)
	{
		poiMods.audioLink.x = UNITY_SAMPLE_TEX2D(_AudioTexture, float2(float(0), .125 * versionUvMultiplier));
		poiMods.audioLink.y = UNITY_SAMPLE_TEX2D(_AudioTexture, float2(float(0), .375 * versionUvMultiplier));
		poiMods.audioLink.z = UNITY_SAMPLE_TEX2D(_AudioTexture, float2(float(0), .625 * versionUvMultiplier));
		poiMods.audioLink.w = UNITY_SAMPLE_TEX2D(_AudioTexture, float2(float(0), .875 * versionUvMultiplier));

		
		if (float(0))
		{
			float uv = saturate(float(0) + float(0.5) * .25);
			poiMods.audioLink.x += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .125 * versionUvMultiplier));
			poiMods.audioLink.y += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .375 * versionUvMultiplier));
			poiMods.audioLink.z += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .625 * versionUvMultiplier));
			poiMods.audioLink.w += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .875 * versionUvMultiplier));

			uv = saturate(float(0) + float(0.5) * .5);
			poiMods.audioLink.x += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .125 * versionUvMultiplier));
			poiMods.audioLink.y += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .375 * versionUvMultiplier));
			poiMods.audioLink.z += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .625 * versionUvMultiplier));
			poiMods.audioLink.w += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .875 * versionUvMultiplier));

			uv = saturate(float(0) + float(0.5) * .75);
			poiMods.audioLink.x += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .125 * versionUvMultiplier));
			poiMods.audioLink.y += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .375 * versionUvMultiplier));
			poiMods.audioLink.z += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .625 * versionUvMultiplier));
			poiMods.audioLink.w += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .875 * versionUvMultiplier));

			uv = saturate(float(0) + float(0.5));
			poiMods.audioLink.x += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .125 * versionUvMultiplier));
			poiMods.audioLink.y += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .375 * versionUvMultiplier));
			poiMods.audioLink.z += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .625 * versionUvMultiplier));
			poiMods.audioLink.w += UNITY_SAMPLE_TEX2D(_AudioTexture, float2(uv, .875 * versionUvMultiplier));

			poiMods.audioLink /= 5;
		}
	}

	#ifndef OPTIMIZER_ENABLED
		
		if (float(0))
		{
			poiMods.audioLink.x = float(0);
			poiMods.audioLink.y = float(0);
			poiMods.audioLink.z = float(0);
			poiMods.audioLink.w = float(0);

			if (float(0))
			{
				poiMods.audioLink.x *= (sin(_Time.w * 3.1) + 1) * .5;
				poiMods.audioLink.y *= (sin(_Time.w * 3.2) + 1) * .5;
				poiMods.audioLink.z *= (sin(_Time.w * 3.3) + 1) * .5;
				poiMods.audioLink.w *= (sin(_Time.w * 3) + 1) * .5;
			}
			poiMods.audioLinkTextureExists = 1;
		}
		
		
		if (float(0))
		{
			poiMods.audioLinkTexture = UNITY_SAMPLE_TEX2D(_AudioTexture, poiMesh.uv[0]);
		}
	#endif
}

#endif
