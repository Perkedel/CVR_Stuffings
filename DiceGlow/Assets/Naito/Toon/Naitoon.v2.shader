// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/Naitoon.v2"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.84
		[HDR]_GlowColor("Glow Color", Color) = (0,0,0,0)
		_GlowSteps("Glow Steps", Range( 38 , 150)) = 38
		_DiffuseIntensity("Diffuse Intensity", Float) = 0
		_DarkenGlow("Darken Glow", Range( 0 , 1)) = 1
		_OuterGlow("Outer Glow", Float) = 0
		_InnerGlow("Inner Glow", Float) = 0
		_GlowDistance("Glow Distance", Float) = 0
		_BrightenGlow("Brighten Glow", Range( 0 , 1)) = 0
		_GlowContrast("Glow Contrast", Range( 0 , 10)) = 0
		_EdgeIntensity("Edge Intensity", Float) = 0
		_TextureSample0("Glow Mask", 2D) = "white" {}
		_Diffuse("Diffuse", 2D) = "white" {}
		[HDR]_DiffuseTint("Diffuse Tint", Color) = (1,1,1,0)
		[Toggle]_ToggleGlow("Toggle Glow", Float) = 1
		_Ramp("Ramp", 2D) = "white" {}
		_MaxLightIntensity("Max Light Intensity", Float) = 1
		_ShadowOffset("Shadow Offset", Float) = 0.5
		[Toggle]_GenerateShadowRamp("Generate Shadow Ramp", Float) = 0
		_Slices("Slices", Range( 30 , 140)) = 52
		_OverallDarken("Overall Darken", Range( 0 , 0.8)) = 0.8
		_ShadowContrast("Shadow Contrast", Float) = 3
		_Cutout("Cutout", 2D) = "white" {}
		_ShadowBrightness("Shadow Brightness", Range( 0 , 0.8)) = 0.453
		_NormalIntensity("Normal Intensity", Float) = 0
		[HDR]_Color0("Specular Color", Color) = (1,1,1,0)
		[Toggle]_SpecularTinting("Specular Tinting", Float) = 0
		_SpecularTintIntensity("Specular Tint Intensity", Float) = 0
		_Gloss("Gloss", Range( 0.01 , 1)) = 0.1
		_SpecularMask("Specular Mask", 2D) = "white" {}
		_DetailContrast("Detail Contrast", Float) = 2
		_Specularity("Specularity", Float) = 2.8
		[Toggle]_SpecularMasktoTextureDetail("Specular Mask to Texture Detail", Float) = 1
		_Float1("Specular Brightness", Float) = 0
		_DetailBrightness("Detail Brightness", Float) = -1
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalMask("Normal Mask", 2D) = "white" {}
		_OutlineWidth("Outline Width", Range( 0 , 1)) = 0
		_OutlineColor("Outline Color", Color) = (0,0,0,0)
		[Toggle]_ToggleOutlineTinting("Toggle Outline Tinting", Float) = 0
		[Toggle]_InvertedOutlineTinting("Inverted Outline Tinting", Float) = 0
		_OutlineTintBrightness("Outline Tint Brightness", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = (0.0 + (_OutlineWidth - 0.0) * (0.09 - 0.0) / (1.0 - 0.0));
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode2_g1027 = tex2D( _Diffuse, uv_Diffuse );
			float4 temp_output_301_0 = ( tex2DNode2_g1027 * _DiffuseTint );
			float2 uv_Cutout = i.uv_texcoord * _Cutout_ST.xy + _Cutout_ST.zw;
			float temp_output_297_87 = tex2D( _Cutout, uv_Cutout ).a;
			o.Emission = lerp(_OutlineColor,( lerp(temp_output_301_0,( 1.0 - temp_output_301_0 ),_InvertedOutlineTinting) + _OutlineTintBrightness ),_ToggleOutlineTinting).rgb;
			clip( temp_output_297_87 - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _ToggleGlow;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float4 _DiffuseTint;
		uniform float _DiffuseIntensity;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _EdgeIntensity;
		uniform float _GlowContrast;
		uniform float _GlowSteps;
		uniform float _InnerGlow;
		uniform float _OuterGlow;
		uniform float _GlowDistance;
		uniform float _BrightenGlow;
		uniform float _DarkenGlow;
		uniform float4 _GlowColor;
		uniform sampler2D _Cutout;
		uniform float4 _Cutout_ST;
		uniform sampler2D _NormalMask;
		uniform float4 _NormalMask_ST;
		uniform float _SpecularTinting;
		uniform float4 _Color0;
		uniform float _SpecularTintIntensity;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalIntensity;
		uniform float _Gloss;
		uniform float _Specularity;
		uniform sampler2D _SpecularMask;
		uniform float4 _SpecularMask_ST;
		uniform float _Float1;
		uniform float _GenerateShadowRamp;
		uniform sampler2D _Ramp;
		uniform float _ShadowOffset;
		uniform float _ShadowContrast;
		uniform float _Slices;
		uniform float _ShadowBrightness;
		uniform float _OverallDarken;
		uniform float _MaxLightIntensity;
		uniform float _SpecularMasktoTextureDetail;
		uniform float _DetailContrast;
		uniform float _DetailBrightness;
		uniform float _Cutoff = 0.84;
		uniform float _OutlineWidth;
		uniform float _ToggleOutlineTinting;
		uniform float4 _OutlineColor;
		uniform float _InvertedOutlineTinting;
		uniform float _OutlineTintBrightness;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_Cutout = i.uv_texcoord * _Cutout_ST.xy + _Cutout_ST.zw;
			float temp_output_297_87 = tex2D( _Cutout, uv_Cutout ).a;
			float2 uv_NormalMask = i.uv_texcoord * _NormalMask_ST.xy + _NormalMask_ST.zw;
			float4 tex2DNode244 = tex2D( _NormalMask, uv_NormalMask );
			float4 temp_output_21_0_g1040 = tex2DNode244;
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode2_g1029 = tex2D( _Diffuse, uv_Diffuse );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult4_g1030 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float4 lerpResult49_g1028 = lerp( ( float4( UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) , 0.0 ) * tex2DNode244 ) , float4( float3(0,0,1) , 0.0 ) , _NormalIntensity);
			float3 normalizeResult7_g1028 = normalize( WorldNormalVector( i , lerpResult49_g1028.rgb ) );
			float dotResult29_g1028 = dot( normalizeResult4_g1030 , normalizeResult7_g1028 );
			float2 uv_SpecularMask = i.uv_texcoord * _SpecularMask_ST.xy + _SpecularMask_ST.zw;
			float4 tex2DNode15_g1040 = tex2D( _SpecularMask, uv_SpecularMask );
			float4 appendResult53_g1040 = (float4(tex2DNode15_g1040.r , tex2DNode15_g1040.g , 0.0 , tex2DNode15_g1040.b));
			float4 break57_g1040 = ( tex2DNode15_g1040 * appendResult53_g1040 );
			float4 temp_cast_10 = (( 1.0 - ( break57_g1040.r + break57_g1040.g ) )).xxxx;
			float4 blendOpSrc85_g1040 = ( lerp(_Color0,( ( tex2DNode2_g1029 * _DiffuseTint ) * _SpecularTintIntensity ),_SpecularTinting) * pow( max( dotResult29_g1028 , 0.0 ) , ( _Gloss * 128.0 ) ) );
			float4 blendOpDest85_g1040 = ( 1.0 - CalculateContrast(_Specularity,temp_cast_10) );
			float4 temp_output_242_0_g1032 = lerpResult49_g1028;
			float dotResult72_g1032 = dot( WorldNormalVector( i , temp_output_242_0_g1032.rgb ) , ase_worldlightDir );
			float temp_output_76_0_g1032 = saturate( (dotResult72_g1032*_ShadowOffset + _ShadowOffset) );
			float2 temp_cast_12 = (temp_output_76_0_g1032).xx;
			float4 temp_cast_14 = (temp_output_76_0_g1032).xxxx;
			float div97_g1032=256.0/float((int)_Slices);
			float4 posterize97_g1032 = ( floor( temp_cast_14 * div97_g1032 ) / div97_g1032 );
			float4 temp_cast_15 = (_ShadowBrightness).xxxx;
			float4 temp_cast_16 = (_OverallDarken).xxxx;
			float4 clampResult101_g1032 = clamp( CalculateContrast(_ShadowContrast,posterize97_g1032) , temp_cast_15 , temp_cast_16 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_cast_17 = (_MaxLightIntensity).xxxx;
			float4 clampResult89_g1032 = clamp( ase_lightColor , float4( 0,0,0,0 ) , temp_cast_17 );
			float4 temp_cast_18 = (1.0).xxxx;
			float4 temp_cast_19 = (1.0).xxxx;
			float4 ifLocalVar118_g1032 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar118_g1032 = temp_cast_19;
			else
				ifLocalVar118_g1032 = clampResult89_g1032;
			float4 temp_cast_20 = (1.0).xxxx;
			UnityGI gi85_g1032 = gi;
			float3 diffNorm85_g1032 = WorldNormalVector( i , temp_output_242_0_g1032.rgb );
			gi85_g1032 = UnityGI_Base( data, 1, diffNorm85_g1032 );
			float3 indirectDiffuse85_g1032 = gi85_g1032.indirect.diffuse + diffNorm85_g1032 * 0.0001;
			float grayscale222_g1032 = dot(indirectDiffuse85_g1032, float3(0.299,0.587,0.114));
			float4 temp_cast_22 = ((0.0 + (grayscale222_g1032 - 0.0) * (7.5 - 0.0) / (1.0 - 0.0))).xxxx;
			float div223_g1032=256.0/float(140);
			float4 posterize223_g1032 = ( floor( temp_cast_22 * div223_g1032 ) / div223_g1032 );
			float4 temp_output_159_0_g1032 = ( saturate( posterize223_g1032 ) + ase_lightAtten );
			float4 ifLocalVar153_g1032 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar153_g1032 = temp_output_159_0_g1032;
			else
				ifLocalVar153_g1032 = temp_cast_20;
			float4 tex2DNode2_g1041 = tex2D( _Diffuse, uv_Diffuse );
			float4 temp_output_108_0_g1040 = ( tex2DNode2_g1041 * _DiffuseTint );
			float3 desaturateInitialColor6_g1040 = tex2D( _SpecularMask, uv_SpecularMask ).rgb;
			float desaturateDot6_g1040 = dot( desaturateInitialColor6_g1040, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar6_g1040 = lerp( desaturateInitialColor6_g1040, desaturateDot6_g1040.xxx, 0.0 );
			float4 tex2DNode2_g1042 = tex2D( _Diffuse, uv_Diffuse );
			c.rgb = ( ( temp_output_21_0_g1040 * ( saturate( ( blendOpSrc85_g1040 * blendOpDest85_g1040 ) )) * _Float1 ) + ( saturate( ( lerp(tex2D( _Ramp, temp_cast_12 ),saturate( clampResult101_g1032 ),_GenerateShadowRamp) * ( ifLocalVar118_g1032 * ifLocalVar153_g1032 ) ) ) * ( ( temp_output_108_0_g1040 * ( 1.0 - temp_output_21_0_g1040 ) ) + ( ( temp_output_108_0_g1040 * temp_output_21_0_g1040 ) + saturate( ( ( lerp(float4( 1,1,1,0 ),( CalculateContrast(_DetailContrast,float4( desaturateVar6_g1040 , 0.0 )) + _DetailBrightness ),_SpecularMasktoTextureDetail) * temp_output_21_0_g1040 ) * ( ( tex2DNode2_g1042 * _DiffuseTint ) * temp_output_21_0_g1040 ) ) ) ) ) ) ).rgb;
			c.a = 1;
			clip( temp_output_297_87 - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_cast_0 = (0.0).xxxx;
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode2_g1044 = tex2D( _Diffuse, uv_Diffuse );
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV16_g1043 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode16_g1043 = ( _InnerGlow + _OuterGlow * pow( 1.0 - fresnelNdotV16_g1043, _GlowDistance ) );
			float4 temp_cast_2 = (fresnelNode16_g1043).xxxx;
			float div21_g1043=256.0/float((int)_GlowSteps);
			float4 posterize21_g1043 = ( floor( temp_cast_2 * div21_g1043 ) / div21_g1043 );
			float4 temp_cast_3 = (_BrightenGlow).xxxx;
			float4 temp_cast_4 = (_DarkenGlow).xxxx;
			float4 clampResult26_g1043 = clamp( CalculateContrast(_GlowContrast,posterize21_g1043) , temp_cast_3 , temp_cast_4 );
			float4 temp_output_43_0_g1043 = saturate( ( ( ( tex2DNode2_g1044 * _DiffuseTint ) * _DiffuseIntensity ) * tex2D( _TextureSample0, uv_TextureSample0 ).a * ( _EdgeIntensity * clampResult26_g1043 * _GlowColor ) ) );
			float4 ifLocalVar44_g1043 = 0;
			if( ase_lightColor.a <= 2.0 )
				ifLocalVar44_g1043 = temp_output_43_0_g1043;
			else
				ifLocalVar44_g1043 = temp_cast_0;
			o.Emission = lerp(float4( 0,0,0,0 ),ifLocalVar44_g1043,_ToggleGlow).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
203;219;1710;854;-655.6394;104.362;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;300;482.8569,48.46582;Float;False;1615.268;550.6001;Outline Shit;10;309;308;307;306;305;304;303;302;301;310;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;301;510.9834,320.9666;Float;False;SimpDiffuse;13;;1027;70caef02384b5204592faf92829b1438;0;0;5;COLOR;0;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;7
Node;AmplifyShaderEditor.OneMinusNode;302;756.823,322.7057;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;244;-1472.657,-106.7891;Float;True;Property;_NormalMask;Normal Mask;44;0;Create;True;0;0;False;0;None;2fdc4733e97294b43842828e01d7cb80;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;245;-1521.657,221.2109;Float;True;Property;_NormalMap;Normal Map;43;0;Create;True;0;0;False;0;None;a8adfa68a661b6e4a8dcbb0c6ea90b3c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;303;747.8569,484.0659;Float;False;Property;_OutlineTintBrightness;Outline Tint Brightness;49;0;Create;True;0;0;False;0;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;299;-1219.929,114.2289;Float;False;LambertPlusPhong;27;;1028;b79916e7c9556e242a75ee7f1ce448bb;0;2;55;COLOR;0,0,0,0;False;52;COLOR;0,0,0,0;False;3;COLOR;79;FLOAT;37;COLOR;38
Node;AmplifyShaderEditor.ToggleSwitchNode;304;1000.211,273.7803;Float;False;Property;_InvertedOutlineTinting;Inverted Outline Tinting;48;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;305;1311.778,273.551;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;297;-1028.113,-116.5205;Float;False;SimpleToon;17;;1032;ffaca806d2eaa7c47b01eddbfea9d93b;0;1;242;COLOR;0,0,0,0;False;2;COLOR;88;FLOAT;87
Node;AmplifyShaderEditor.ColorNode;306;1126.458,98.46582;Float;False;Property;_OutlineColor;Outline Color;46;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;307;1307.373,398.0204;Float;False;Property;_OutlineWidth;Outline Width;45;0;Create;True;0;0;False;0;0;0.09;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;308;1506.674,103.3393;Float;False;Property;_ToggleOutlineTinting;Toggle Outline Tinting;47;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;310;1677.639,357.6379;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.09;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;298;-816.657,28.21091;Float;False;Specular Mask;34;;1040;961a1dfd23713e042b92207337f02541;0;3;22;COLOR;0,0,0,0;False;23;COLOR;0,0,0,0;False;21;COLOR;0,0,0,0;False;2;COLOR;29;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;286;-504.2279,-151.3589;Float;False;FresnelGlow;1;;1043;6bdb41b5f53c3b746876624e5ddb91c5;0;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;241;-321.6571,56.2109;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;309;1783.656,191.2907;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;287;-272.686,-102.3405;Float;False;Property;_ToggleGlow;Toggle Glow;16;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Naito/Naitoon.v2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.84;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;302;0;301;0
WireConnection;299;55;244;0
WireConnection;299;52;245;0
WireConnection;304;0;301;0
WireConnection;304;1;302;0
WireConnection;305;0;304;0
WireConnection;305;1;303;0
WireConnection;297;242;299;79
WireConnection;308;0;306;0
WireConnection;308;1;305;0
WireConnection;310;0;307;0
WireConnection;298;22;297;88
WireConnection;298;23;299;38
WireConnection;298;21;244;0
WireConnection;241;0;298;29
WireConnection;241;1;298;0
WireConnection;309;0;308;0
WireConnection;309;2;297;87
WireConnection;309;1;310;0
WireConnection;287;1;286;0
WireConnection;0;2;287;0
WireConnection;0;10;297;87
WireConnection;0;13;241;0
WireConnection;0;11;309;0
ASEEND*/
//CHKSM=0E57B4D8C320588B8F2BB7C1D485C58CC4222BB8