float _OutlineRimLightBlend;
float _OutlineLit;
float _OutlineTintMix;
float2 _MainTexPan;
float _MainTextureUV;
half _OutlineHueOffset;
half _OutlineHueShift;
half _OutlineHueOffsetSpeed;
float4 frag(v2f i, uint facing: SV_IsFrontFace): COLOR
{
	float4 finalColor = 1;
	
	if ((0.0 /*_commentIfZero_EnableOutlinePass*/))
	{
		UNITY_SETUP_INSTANCE_ID(i);
		float3 finalEmission = 0;
		float4 albedo = 1;
		poiMesh.uv[0] = i.uv0.xy;
		poiMesh.uv[1] = i.uv0.zw;
		poiMesh.uv[2] = i.uv1.xy;
		poiMesh.uv[3] = i.uv1.zw;
		calculateAttenuation(i);
		InitializeMeshData(i, facing);
		initializeCamera(i);
		calculateTangentData();
		float4 mainTexture = UNITY_SAMPLE_TEX2D(_MainTex, TRANSFORM_TEX(poiMesh.uv[(0.0 /*_MainTextureUV*/)], _MainTex) + _Time.x * float4(0,0,0,0));
		half3 detailMask = 1;
		calculateNormals(detailMask);
		#ifdef POI_DATA
		calculateLightingData(i);
	#endif
	#ifdef POI_LIGHTING
		calculateBasePassLightMaps();
	#endif
	float3 uselessData0;
	float3 uselessData1;
	initTextureData(albedo, mainTexture, uselessData0, uselessData1, detailMask);
	fixed4 col = mainTexture;
	float alphaMultiplier = smoothstep(float4(0,0,0,0).x, float4(0,0,0,0).y, distance(getCameraPosition(), i.worldPos));
	float OutlineMask = tex2D(_OutlineMask, TRANSFORM_TEX(poiMesh.uv[(0.0 /*_OutlineMaskUV*/)], _OutlineMask) + _Time.x * float4(0,0,0,0)).r;
	clip(OutlineMask * (0.0 /*_LineWidth*/) - 0.001);
	col = col * 0.00000000001 + tex2D(_OutlineTexture, TRANSFORM_TEX(poiMesh.uv[(0.0 /*_OutlineTextureUV*/)], _OutlineTexture) + _Time.x * float4(0,0,0,0));
	col.a *= albedo.a;
	col.a *= alphaMultiplier;
	#ifdef POI_RANDOM
		col.a *= i.angleAlpha;
	#endif
	poiCam.screenUV = calcScreenUVs(i.grabPos);
	col.a *= float4(1,1,1,1).a;
	
	if ((0.0 /*_Mode*/) == 1)
	{
		applyDithering(col);
	}
	clip(col.a - (0.5 /*_Cutoff*/));
	#ifdef POI_MIRROR
		applyMirrorRenderFrag();
	#endif
	
	if ((0.0 /*_OutlineMode*/) == 1)
	{
		#ifdef POI_MIRROR
			applyMirrorTexture(mainTexture);
		#endif
		col.rgb = mainTexture.rgb;
	}
	else if ((0.0 /*_OutlineMode*/) == 2)
	{
		col.rgb = lerp(col.rgb, poiLight.color, (0.0 /*_OutlineRimLightBlend*/));
	}
	col.rgb *= float4(1,1,1,1).rgb;
	if ((0.0 /*_OutlineMode*/) == 1)
	{
		col.rgb = lerp(col.rgb, mainTexture.rgb, (0.0 /*_OutlineTintMix*/));
	}
	finalColor = col;
	
	if ((0.0 /*_OutlineHueShift*/))
	{
		finalColor.rgb = hueShift(finalColor.rgb, (0.0 /*_OutlineHueOffset*/) + (0.0 /*_OutlineHueOffsetSpeed*/) * _Time.x);
	}
	#ifdef POI_LIGHTING
		
		if ((1.0 /*_OutlineLit*/))
		{
			finalColor.rgb *= calculateFinalLighting(finalColor.rgb, finalColor);
		}
	#endif
	finalColor.rgb += (col.rgb * (0.0 /*_OutlineEmission*/));
}
else
{
	clip(-1);
}
return finalColor;
}
