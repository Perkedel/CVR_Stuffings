// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PBRToon Ultra"
{
	Properties
	{
		[Header(Main Settings)]_MaskClipThreshold("Mask Clip Threshold", Float) = 0
		_Albedo("Albedo", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		_OcclusionPower("Occlusion Power", Range( 0 , 1)) = 1
		[Enum(Metallic Alpha,0,Albedo Alpha,1,Roughness Texture,2)][Header(Reflectivity Settings)]_RoughnessSource("Roughness Source", Float) = 0
		_Roughness("Roughness", 2D) = "black" {}
		_Metallic("Metallic", 2D) = "white" {}
		_Specular("Specular", 2D) = "white" {}
		_Metalness("Metalness", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 5)) = 0
		[HDR]_ShineColor("Shine Color", Color) = (1,1,1,0)
		_Shininess("Shininess", Range( 0.01 , 1)) = 0.1
		_ReflectionBrightness("ReflectionBrightness", Float) = 0
		_ShadowBrightness("Shadow Brightness", Range( 0 , 1)) = 0.01
		[Header(Sub Surface Scattering Settings)]_SSSThickness("SSS Thickness", 2D) = "white" {}
		_SSSDistortion("SSS Distortion", Float) = 0
		_SSSScale("SSS Scale", Float) = 0
		_SSSPower("SSS Power", Float) = 0
		[HDR]_SSSColor("SSS Color", Color) = (1,1,1,0)
		_SSSAlbedoSaturation("SSS Albedo Saturation", Range( 0 , 1)) = 0
		_SSSPointLightIntensity("SSS Point Light Intensity", Float) = 0
		_SSSAbledoContribution("SSS Abledo Contribution", Range( 0 , 1)) = 0
		[Header(Rimlight Settings)]_RimlightBias("Rimlight Bias", Float) = 0
		_RimlightScale("Rimlight Scale", Float) = 0
		_RimlightPower("Rimlight Power", Float) = 0
		_RimlightAlbedoContribution("Rimlight Albedo Contribution", Range( 0 , 1)) = 0
		[HDR]_RimlightColor("Rimlight Color", Color) = (1,1,1,0)
		[Header(Sparkle Settings)]_SparkleSize("Sparkle Size", Float) = 0
		_SparkleTimescale("Sparkle Timescale", Float) = 0
		_SparkleIntensity("Sparkle Intensity", Float) = 0
		_SparkleHDR("SparkleHDR", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(Other Settings)]_CullMode("Cull Mode", Float) = 2
		_Emission("Emission", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
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
			half ASEVFace : VFACE;
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

		uniform float4 _EmissionColor;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _ShadowBrightness;
		uniform sampler2D _Occlusion;
		uniform float4 _Occlusion_ST;
		uniform float _OcclusionPower;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _RoughnessSource;
		uniform sampler2D _Roughness;
		uniform float4 _Roughness_ST;
		uniform float _Smoothness;
		uniform float _ReflectionBrightness;
		uniform float _Metalness;
		uniform float _Shininess;
		uniform sampler2D _Specular;
		uniform float4 _Specular_ST;
		uniform float4 _ShineColor;
		uniform float _SparkleSize;
		uniform float _SparkleTimescale;
		uniform float _SparkleIntensity;
		uniform float _SparkleHDR;
		uniform float _CullMode;
		uniform float _MaskClipThreshold;
		uniform float _SSSDistortion;
		uniform float _SSSPower;
		uniform float _SSSScale;
		uniform float4 _SSSColor;
		uniform float _SSSAlbedoSaturation;
		uniform float _SSSAbledoContribution;
		uniform float _SSSPointLightIntensity;
		uniform sampler2D _SSSThickness;
		uniform float4 _SSSThickness_ST;
		uniform float _RimlightBias;
		uniform float _RimlightScale;
		uniform float _RimlightPower;
		uniform float _RimlightAlbedoContribution;
		uniform float4 _RimlightColor;


		float2 voronoihash210( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi210( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash210( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
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
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode1 = tex2D( _Albedo, uv_Albedo );
			float4 AlbedoColor55 = tex2DNode1;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 LightDir319 = ase_worldlightDir;
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode3 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float4 appendResult9 = (float4(tex2DNode3.r , tex2DNode3.g , ( tex2DNode3.b * i.ASEVFace ) , 0.0));
			float4 Normal74 = appendResult9;
			float dotResult179 = dot( LightDir319 , (WorldNormalVector( i , Normal74.xyz )) );
			float smoothstepResult207 = smoothstep( 0.0 , 0.025 , (dotResult179*1.0 + -0.25));
			UnityGI gi198 = gi;
			float3 diffNorm198 = WorldNormalVector( i , Normal74.xyz );
			gi198 = UnityGI_Base( data, 1, diffNorm198 );
			float3 indirectDiffuse198 = gi198.indirect.diffuse + diffNorm198 * 0.0001;
			float3 temp_cast_3 = (_ShadowBrightness).xxx;
			float2 uv_Occlusion = i.uv_texcoord * _Occlusion_ST.xy + _Occlusion_ST.zw;
			float3 Lighting181 = ( (temp_cast_3 + (saturate( ( ( ( ase_lightColor.rgb * ase_lightAtten ) * saturate( smoothstepResult207 ) ) + indirectDiffuse198 ) ) - float3( 0,0,0 )) * (float3( 1,1,1 ) - temp_cast_3) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * saturate( pow( tex2D( _Occlusion, uv_Occlusion ).r , _OcclusionPower ) ) );
			float3 indirectNormal72 = WorldNormalVector( i , Normal74.xyz );
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float lerpResult248 = lerp( tex2D( _Metallic, uv_Metallic ).a , (AlbedoColor55).a , _RoughnessSource);
			float2 uv_Roughness = i.uv_texcoord * _Roughness_ST.xy + _Roughness_ST.zw;
			float lerpResult252 = lerp( lerpResult248 , tex2D( _Roughness, uv_Roughness ).r , saturate( ( _RoughnessSource - 1.0 ) ));
			float RoughnessSource242 = lerpResult252;
			float temp_output_22_0 = saturate( ( RoughnessSource242 * _Smoothness ) );
			Unity_GlossyEnvironmentData g72 = UnityGlossyEnvironmentSetup( temp_output_22_0, data.worldViewDir, indirectNormal72, float3(0,0,0));
			float3 indirectSpecular72 = UnityGI_IndirectSpecular( data, RoughnessSource242, indirectNormal72, g72 );
			float3 lerpResult156 = lerp( indirectSpecular72 , ( indirectSpecular72 * _ReflectionBrightness ) , tex2D( _Metallic, uv_Metallic ).r);
			float4 lerpResult143 = lerp( AlbedoColor55 , float4( 0,0,0,0 ) , tex2D( _Metallic, uv_Metallic ).r);
			float4 IndirSpec78 = saturate( ( float4( lerpResult156 , 0.0 ) * saturate( ( lerpResult143 + ( 1.0 - _Metalness ) ) ) ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult4_g90 = normalize( ( ase_worldViewDir + LightDir319 ) );
			float3 normalizeResult107 = normalize( (WorldNormalVector( i , Normal74.xyz )) );
			float dotResult108 = dot( normalizeResult4_g90 , normalizeResult107 );
			float smoothstepResult241 = smoothstep( 0.5 , 0.6 , pow( max( dotResult108 , 0.0 ) , ( _Shininess * 256.0 ) ));
			float PhongSpecular121 = ( smoothstepResult241 * tex2D( _Metallic, uv_Metallic ).a );
			float4 temp_output_127_0 = ( ase_lightColor * ase_lightAtten );
			float2 uv_Specular = i.uv_texcoord * _Specular_ST.xy + _Specular_ST.zw;
			float4 SpecularColors130 = ( PhongSpecular121 * temp_output_127_0 * tex2D( _Specular, uv_Specular ) * _ShineColor );
			float mulTime215 = _Time.y * _SparkleTimescale;
			float time210 = mulTime215;
			float2 coords210 = i.uv_texcoord * _SparkleSize;
			float2 id210 = 0;
			float voroi210 = voronoi210( coords210, time210,id210, 0 );
			float smoothstepResult213 = smoothstep( 0.995 , 1.0 , ( 1.0 - voroi210 ));
			float4 temp_cast_9 = (_SparkleHDR).xxxx;
			float4 clampResult236 = clamp( ( smoothstepResult213 * PhongSpecular121 * SpecularColors130 * _SparkleIntensity ) , float4( 0,0,0,0 ) , temp_cast_9 );
			float4 Sparkles225 = clampResult236;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 objToWorldDir24 = mul( unity_ObjectToWorld, float4( ase_vertexNormal, 0 ) ).xyz;
			float3 normalizeResult27 = normalize( BlendNormals( objToWorldDir24 , (WorldNormalVector( i , Normal74.xyz )) ) );
			float dotResult33 = dot( ase_worldViewDir , ( ( _SSSDistortion * normalizeResult27 ) + -LightDir319 ) );
			float dotResult37 = dot( pow( dotResult33 , _SSSPower ) , _SSSScale );
			float3 desaturateInitialColor39 = AlbedoColor55.rgb;
			float desaturateDot39 = dot( desaturateInitialColor39, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar39 = lerp( desaturateInitialColor39, desaturateDot39.xxx, ( 1.0 - _SSSAlbedoSaturation ) );
			UnityGI gi164 = gi;
			float3 diffNorm164 = WorldNormalVector( i , Normal74.xyz );
			gi164 = UnityGI_Base( data, 1, diffNorm164 );
			float3 indirectDiffuse164 = gi164.indirect.diffuse + diffNorm164 * 0.0001;
			float3 temp_output_165_0 = ( ( ase_lightColor.rgb * ase_lightAtten ) + indirectDiffuse164 );
			float3 lerpResult49 = lerp( temp_output_165_0 , ( temp_output_165_0 * _WorldSpaceLightPos0.w * _SSSPointLightIntensity ) , _WorldSpaceLightPos0.w);
			float2 uv_SSSThickness = i.uv_texcoord * _SSSThickness_ST.xy + _SSSThickness_ST.zw;
			float4 SubSurface53 = ( saturate( dotResult37 ) * _SSSColor * float4( saturate( ( desaturateVar39 + ( 1.0 - _SSSAbledoContribution ) ) ) , 0.0 ) * float4( lerpResult49 , 0.0 ) * tex2D( _SSSThickness, uv_SSSThickness ) );
			float fresnelNdotV276 = dot( (WorldNormalVector( i , Normal74.xyz )), ase_worldViewDir );
			float fresnelNode276 = ( _RimlightBias + _RimlightScale * pow( 1.0 - fresnelNdotV276, _RimlightPower ) );
			float dotResult278 = dot( -ase_worldViewDir , LightDir319 );
			float4 temp_cast_16 = (3.0).xxxx;
			float4 clampResult290 = clamp( ( ( ( ase_lightAtten * ase_lightColor ) * saturate( fresnelNode276 ) * saturate( dotResult278 ) * saturate( ( AlbedoColor55 + _RimlightAlbedoContribution ) ) * tex2D( _Specular, uv_Specular ) ) * _RimlightColor * RoughnessSource242 ) , float4( 0,0,0,0 ) , temp_cast_16 );
			float4 Rimlighting292 = clampResult290;
			c.rgb = ( ( ( float4( Lighting181 , 0.0 ) * ( saturate( ( tex2DNode1 + IndirSpec78 ) ) + SpecularColors130 + Sparkles225 ) ) + ( _CullMode * 0.0 * _MaskClipThreshold ) ) + SubSurface53 + Rimlighting292 ).rgb;
			c.a = 1;
			clip( (AlbedoColor55).a - _MaskClipThreshold );
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
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( _EmissionColor * tex2D( _Emission, uv_Emission ) ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
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
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
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

//CHKSM=40336353EF84D725C9C789478B1D03D0D005FA66