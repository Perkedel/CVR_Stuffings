Shader "Racush/BeachBall"
{
	Properties
	{
		[NoScaleOffset]_Albedo("Albedo", 2D) = "white" {}
		[NoScaleOffset]_MetalLogo("Metal Logo", 2D) = "white" {}
		[HDR][NoScaleOffset]_Normal("Normal", 2D) = "bump" {}
		[HDR]_Fake_Reflection("Fake_Reflection", Range( 0 , 1)) = 0
		[HDR]_Primary_Color("Primary_Color", Color) = (1,0.3368608,0,1)
		[HDR]_Secondary_Color("Secondary_Color", Color) = (1,1,1,1)
		[HDR]_Tertiary_Color("Tertiary_Color", Color) = (1,0,0,1)
		[HDR]_Logo_Color("Logo_Color", Color) = (0.00965035,1,0,1)
		_LogoSizeX("Logo SizeX", Float) = 0
		_LogooffsetX("Logo offsetX", Float) = 0
		_LogoSizeY("Logo SizeY", Float) = 0
		_LogoOffsetY("Logo OffsetY", Float) = 0
		_Metal("Metal", Range( 0 , 1)) = 0.5411765
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[HDR][NoScaleOffset]_reflecalt("reflecalt", CUBE) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
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
			float2 uv2_texcoord2;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Normal;
		uniform sampler2D _Albedo;
		uniform float4 _Primary_Color;
		uniform float4 _Secondary_Color;
		uniform float4 _Tertiary_Color;
		uniform sampler2D _MetalLogo;
		uniform float _LogoSizeX;
		uniform float _LogoSizeY;
		uniform float _LogooffsetX;
		uniform float _LogoOffsetY;
		uniform float4 _Logo_Color;
		uniform samplerCUBE _reflecalt;
		uniform float _Fake_Reflection;
		uniform float _Metal;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal63 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal63 ) );
			float2 uv_Albedo4 = i.uv_texcoord;
			float4 tex2DNode4 = tex2D( _Albedo, uv_Albedo4 );
			float R5 = tex2DNode4.r;
			float G6 = tex2DNode4.g;
			float B7 = tex2DNode4.b;
			float2 _LogoSize = float2(1,1);
			float2 appendResult41 = (float2(( _LogoSizeX * _LogoSize.x ) , ( _LogoSize.y * _LogoSizeY )));
			float2 _LogoOffsets = float2(0,0);
			float2 appendResult47 = (float2(( _LogooffsetX + _LogoOffsets.x ) , ( _LogoOffsets.y + _LogoOffsetY )));
			float2 uv2_TexCoord34 = i.uv2_texcoord2 * appendResult41 + appendResult47;
			float Logo8 = tex2D( _MetalLogo, uv2_TexCoord34 ).g;
			float4 Colors50 = ( ( R5 * _Primary_Color ) + ( G6 * _Secondary_Color ) + ( B7 * _Tertiary_Color ) + ( Logo8 * _Logo_Color ) );
			o.Albedo = Colors50.rgb;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			o.Emission = ( texCUBE( _reflecalt, ase_worldNormal ) * _Fake_Reflection ).rgb;
			o.Metallic = _Metal;
			float2 uv_MetalLogo83 = i.uv_texcoord;
			float Smoothness55 = tex2D( _MetalLogo, uv_MetalLogo83 ).r;
			o.Smoothness = ( Smoothness55 * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d11 
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
				float4 customPack1 : TEXCOORD1;
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
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
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
				surfIN.uv2_texcoord2 = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Standard"
}