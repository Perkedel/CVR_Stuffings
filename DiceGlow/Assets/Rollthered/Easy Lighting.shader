// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / Simple Skin"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "white" {}
		_Brightness("Brightness", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+1" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Brightness;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode3 = tex2D( _MainTex, uv_MainTex );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float fresnelNdotV66 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode66 = ( -1.0 + 0.03 * pow( max( 1.0 - fresnelNdotV66 , 0.0001 ), -4.04 ) );
			float4 clampResult70 = clamp( ( CalculateContrast(2.0,tex2DNode3) * ( 0.02 * fresnelNode66 ) ) , float4( 0,0,0,0 ) , float4( 0.03921569,0.03921569,0.03921569,0 ) );
			float4 color29 = IsGammaSpace() ? float4(0.517,0.2427652,0.1191348,0) : float4(0.2301148,0.04802769,0.01325316,0);
			float3 desaturateInitialColor51 = color29.rgb;
			float desaturateDot51 = dot( desaturateInitialColor51, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar51 = lerp( desaturateInitialColor51, desaturateDot51.xxx, 1.0 );
			float fresnelNdotV42 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode42 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV42, 0.69 ) );
			float4 color40 = IsGammaSpace() ? float4(0.02,0.02,0.02,0) : float4(0.001547988,0.001547988,0.001547988,0);
			float4 color55 = IsGammaSpace() ? float4(0.7446786,0.503,1,0) : float4(0.51427,0.2168284,1,0);
			float4 temp_output_57_0 = CalculateContrast(2.0,( color55 * tex2DNode3 ));
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult37 = dot( normalize( (WorldNormalVector( i , temp_output_57_0.rgb )) ) , ( ase_worldlightDir + float3( 0,0,0 ) ) );
			float4 clampResult54 = clamp( ( color40 * dotResult37 ) , float4( 0,0,0,0 ) , float4( 0.189,0.189,0.189,0 ) );
			float dotResult21 = dot( normalize( (WorldNormalVector( i , temp_output_57_0.rgb )) ) , -( ase_worldlightDir + ( (WorldNormalVector( i , temp_output_57_0.rgb )) * 0.3919433 ) ) );
			float4 clampResult19 = clamp( ( ( tex2DNode3 * float4( ( 1.0 * ( desaturateVar51 * fresnelNode42 ) ) , 0.0 ) ) + clampResult54 + ( color29 * ( tex2DNode3 * dotResult21 ) ) ) , float4( 4.99736E-23,4.99736E-23,4.99736E-23,0 ) , float4( 1,1,1,0 ) );
			float4 temp_cast_5 = (0.2).xxxx;
			float4 temp_output_43_0_g10 = temp_cast_5;
			float3 normalizeResult4_g11 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float3 normalizeResult64_g10 = normalize( (WorldNormalVector( i , float3(0,0,1) )) );
			float dotResult19_g10 = dot( normalizeResult4_g11 , normalizeResult64_g10 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_40_0_g10 = ( ase_lightColor * 1 );
			float dotResult14_g10 = dot( normalizeResult64_g10 , ase_worldlightDir );
			float4 temp_output_42_0_g10 = tex2DNode3;
			o.Emission = saturate( ( clampResult70 + CalculateContrast(1.01,( _Brightness * ( clampResult19 + ( ( tex2DNode3 * 0.6 ) + ( tex2DNode3 * ( ( float4( (temp_output_43_0_g10).rgb , 0.0 ) * (temp_output_43_0_g10).a * pow( max( dotResult19_g10 , 0.0 ) , ( 0.01 * 128.0 ) ) * temp_output_40_0_g10 ) + ( ( ( temp_output_40_0_g10 * max( dotResult14_g10 , 0.0 ) ) + float4( float3(0,0,0) , 0.0 ) ) * float4( (temp_output_42_0_g10).rgb , 0.0 ) ) ) ) ) ) )) ) ).rgb;
			o.Alpha = tex2DNode3.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows exclude_path:deferred 

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
			sampler3D _DitherMaskLOD;
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
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1176;73;742;937;867.9218;123.1431;1;True;False
Node;AmplifyShaderEditor.ColorNode;55;-1584.359,1938.199;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;False;0;False;0.7446786,0.503,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-576.9799,-739.9339;Inherit;True;Property;_MainTex;_MainTex;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1312.538,2001.472;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;57;-1172.744,1867.16;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;23;-1129.354,1428.615;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;22;-1010.188,1607.366;Inherit;False;Constant;_SSSDistort;SSS Distort;3;0;Create;True;0;0;False;0;False;0.3919433;0.135;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-775.4648,1448.476;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;25;-1329.63,1207.035;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-997.5488,1289.586;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;29;-572.26,1546.24;Inherit;False;Constant;_Subsurface;Subsurface;3;0;Create;True;0;0;False;0;False;0.517,0.2427652,0.1191348,0;0.3098039,0.09387054,0.09387054,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;38;-1136.576,2353.331;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FresnelNode;42;-868.0571,2137.475;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.69;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-804.4951,2435.882;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-1339.062,1047.523;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;27;-834.8337,1217.492;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;36;-1146.008,2193.819;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DesaturateOpNode;51;-854.7732,2011.355;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;40;-366.5593,2221.576;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;False;0;False;0.02,0.02,0.02,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;21;-559.8528,1358.219;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-651.881,1924.903;Inherit;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;37;-366.799,2504.515;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-627.5089,2055.156;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-370.96,1221.364;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-92.49163,2144.771;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-446.2944,1970.179;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-433.1755,546.5118;Inherit;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-468.2819,1788.062;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;74;-375.462,316.5204;Inherit;False;Blinn-Phong Light;0;;10;cf814dba44d007a4e958d2ddd5813da6;0;3;42;COLOR;0,0,0,0;False;52;FLOAT3;0,0,0;False;43;COLOR;0,0,0,0;False;2;COLOR;0;FLOAT;57
Node;AmplifyShaderEditor.ClampOpNode;54;-183.4636,1992.047;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.189,0.189,0.189,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-301.3945,-123.2548;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;False;0.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-276.5143,1528.021;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-191.4649,62.0937;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-220.3011,-229.8185;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;21.49799,1889.177;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;19;-50.88617,1663.054;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;4.99736E-23,4.99736E-23,4.99736E-23,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;69;365.9872,-28.52577;Inherit;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;False;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-94.912,-84.96831;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;66;213.3583,86.76708;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-1;False;2;FLOAT;0.03;False;3;FLOAT;-4.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;485.2498,100.9178;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;65.25185,335.6016;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-31.29644,575.142;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;73;176.3226,-530.0652;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;206.7497,486.3396;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;665.5983,-3.800596;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;70;723.7753,116.9165;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.03921569,0.03921569,0.03921569,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;52;261.1861,704.0206;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;1.01;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;528.8826,273.994;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;53;388.234,606.8613;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;-1528.954,1511.713;Inherit;False;Maintex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;579.7593,468.1688;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / Simple Skin;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;1;False;TransparentCutout;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;55;0
WireConnection;56;1;3;0
WireConnection;57;1;56;0
WireConnection;23;0;57;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;34;0;38;0
WireConnection;28;0;57;0
WireConnection;27;0;26;0
WireConnection;36;0;57;0
WireConnection;51;0;29;0
WireConnection;21;0;28;0
WireConnection;21;1;27;0
WireConnection;37;0;36;0
WireConnection;37;1;34;0
WireConnection;50;0;51;0
WireConnection;50;1;42;0
WireConnection;30;0;3;0
WireConnection;30;1;21;0
WireConnection;39;0;40;0
WireConnection;39;1;37;0
WireConnection;43;0;45;0
WireConnection;43;1;50;0
WireConnection;46;0;3;0
WireConnection;46;1;43;0
WireConnection;74;42;3;0
WireConnection;74;43;63;0
WireConnection;54;0;39;0
WireConnection;20;0;29;0
WireConnection;20;1;30;0
WireConnection;2;0;3;0
WireConnection;2;1;74;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;41;0;46;0
WireConnection;41;1;54;0
WireConnection;41;2;20;0
WireConnection;19;0;41;0
WireConnection;6;0;5;0
WireConnection;6;1;2;0
WireConnection;68;0;69;0
WireConnection;68;1;66;0
WireConnection;17;0;19;0
WireConnection;17;1;6;0
WireConnection;73;1;3;0
WireConnection;64;0;65;0
WireConnection;64;1;17;0
WireConnection;71;0;73;0
WireConnection;71;1;68;0
WireConnection;70;0;71;0
WireConnection;52;1;64;0
WireConnection;67;0;70;0
WireConnection;67;1;52;0
WireConnection;53;0;67;0
WireConnection;60;0;3;0
WireConnection;0;2;53;0
WireConnection;0;9;3;4
ASEEND*/
//CHKSM=231B175A8C4FEF97EA7F1672CEE4E243CCDDE487