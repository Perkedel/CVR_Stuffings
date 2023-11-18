// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered /InstantLatex"
{
	Properties
	{
		[Toggle]_SeeThrough("See Through?", Float) = 1
		[Toggle]_UseOldVersion("Use Old Version?", Float) = 0
		_MainTex("_MainTex", 2D) = "black" {}
		[HDR]_Color("Color", Color) = (0,0,0,0)
		[HideInInspector]_Vector2("Vector 2", Vector) = (0,0,0,0)
		[HideInInspector]_Vector4("Vector 4", Vector) = (0,0,0,0)
		[HideInInspector]_Vector3("Vector 3", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityCG.cginc"
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

		uniform float _UseOldVersion;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform float4 _Vector2;
		uniform float4 _Vector3;
		uniform float4 _Vector4;
		uniform float _SeeThrough;


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
			float4 tex2DNode85 = tex2D( _MainTex, uv_MainTex );
			float4 temp_cast_0 = (0.0).xxxx;
			float4 temp_cast_1 = (2.0).xxxx;
			float4 clampResult161 = clamp( _Color , temp_cast_0 , temp_cast_1 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV126 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode126 = ( 0.0 + 4.85 * pow( max( 1.0 - fresnelNdotV126 , 0.0001 ), 5.0 ) );
			float4 temp_cast_2 = (( 0.1 * saturate( fresnelNode126 ) )).xxxx;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV108 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode108 = ( 1.0 + -49.9 * pow( max( 1.0 - fresnelNdotV108 , 0.0001 ), 0.88 ) );
			float4 temp_cast_4 = (saturate( fresnelNode108 )).xxxx;
			float fresnelNdotV114 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode114 = ( 4.5 + -175.94 * pow( 1.0 - fresnelNdotV114, 2.78 ) );
			float fresnelNdotV102 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode102 = ( 2.67 + -358.5 * pow( 1.0 - fresnelNdotV102, 6.95 ) );
			float fresnelNdotV109 = dot( mul(ase_tangentToWorldFast,_Vector3.xyz), ase_worldViewDir );
			float fresnelNode109 = ( 34.31 + -446.3 * pow( 1.0 - fresnelNdotV109, 1.05 ) );
			float fresnelNdotV110 = dot( mul(ase_tangentToWorldFast,_Vector3.xyz), ase_worldViewDir );
			float fresnelNode110 = ( 1.0 + -2.9 * pow( 1.0 - fresnelNdotV110, 0.43 ) );
			float4 color113 = IsGammaSpace() ? float4(0.035,0.035,0.035,0) : float4(0.002708978,0.002708978,0.002708978,0);
			float fresnelNdotV104 = dot( normalize( _Vector4.xyz ), ase_worldViewDir );
			float fresnelNode104 = ( 0.9 + -1.43 * pow( max( 1.0 - fresnelNdotV104 , 0.0001 ), 4.77 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float fresnelNdotV107 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode107 = ( -2.07 + 150.29 * pow( max( 1.0 - fresnelNdotV107 , 0.0001 ), 6.9 ) );
			float fresnelNdotV112 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode112 = ( 0.15 + 0.1 * pow( max( 1.0 - fresnelNdotV112 , 0.0001 ), -165.1 ) );
			float fresnelNdotV105 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode105 = ( -0.71 + 129.8 * pow( max( 1.0 - fresnelNdotV105 , 0.0001 ), 58.15 ) );
			float fresnelNdotV106 = dot( mul(ase_tangentToWorldFast,_Vector2.xyz), ase_worldViewDir );
			float fresnelNode106 = ( 0.9 + 4.5 * pow( max( 1.0 - fresnelNdotV106 , 0.0001 ), 4.77 ) );
			float luminance147 = Luminance(( CalculateContrast(2.0,temp_cast_2) + saturate( ( CalculateContrast(70.0,temp_cast_4) + ( 0.004 * saturate( fresnelNode114 ) ) + ( 0.01 * saturate( ( 1.0 - fresnelNode102 ) ) ) + ( 0.003 * saturate( fresnelNode109 ) ) + ( 0.012 * saturate( fresnelNode110 ) ) + saturate( ( color113 * fresnelNode104 ) ) ) ) + ( 0.014 * ( saturate( ( fresnelNode107 + fresnelNode112 ) ) - ( saturate( fresnelNode105 ) + saturate( fresnelNode106 ) ) ) ) ).rgb);
			float4 temp_cast_14 = (luminance147).xxxx;
			float4 temp_output_148_0 = CalculateContrast(3.0,temp_cast_14);
			float3 gammaToLinear149 = GammaToLinearSpace( temp_output_148_0.rgb );
			float4 lerpResult151 = lerp( float4( gammaToLinear149 , 0.0 ) , temp_output_148_0 , 0.8);
			float4 temp_cast_18 = (0.0).xxxx;
			float4 temp_cast_19 = (2.0).xxxx;
			float4 clampResult90 = clamp( _Color , temp_cast_18 , temp_cast_19 );
			float fresnelNdotV11 = dot( ase_worldNormal, ase_worldViewDir );
			float ior11 = 1.23;
			ior11 = pow( ( 1 - ior11 ) / ( 1 + ior11 ), 2 );
			float fresnelNode11 = ( ior11 + ( 1.0 - ior11 ) * pow( 1.0 - fresnelNdotV11, 5 ) );
			float4 temp_cast_20 = (( 0.1 * fresnelNode11 )).xxxx;
			float fresnelNdotV24 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode24 = ( -2.8 + 2.01 * pow( max( 1.0 - fresnelNdotV24 , 0.0001 ), -0.07 ) );
			float4 temp_cast_21 = (saturate( fresnelNode24 )).xxxx;
			float fresnelNdotV2 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode2 = ( -0.69 + 57.11 * pow( max( 1.0 - fresnelNdotV2 , 0.0001 ), 2.24 ) );
			float fresnelNdotV3 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode3 = ( -4.0 + 13.63 * pow( max( 1.0 - fresnelNdotV3 , 0.0001 ), 0.65 ) );
			float fresnelNdotV4 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode4 = ( -4.79 + 277.67 * pow( max( 1.0 - fresnelNdotV4 , 0.0001 ), 4.7 ) );
			float fresnelNdotV1 = dot( ase_normWorldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.9 + -6.35 * pow( max( 1.0 - fresnelNdotV1 , 0.0001 ), 8.21 ) );
			o.Emission = (( _UseOldVersion )?( ( tex2DNode85 + saturate( ( clampResult90 * ( CalculateContrast(2.0,temp_cast_20) + CalculateContrast(11.0,temp_cast_21) + ( 0.01 * ( ( saturate( fresnelNode2 ) + saturate( fresnelNode3 ) ) - ( saturate( fresnelNode4 ) + saturate( fresnelNode1 ) ) ) ) ) ) ) ) ):( ( tex2DNode85 + saturate( ( clampResult161 * lerpResult151 ) ) ) )).rgb;
			o.Alpha = (( _SeeThrough )?( 0.85 ):( 1.0 ));
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

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
768;73;1150;927;1629.323;2001.661;2.185996;True;False
Node;AmplifyShaderEditor.Vector4Node;100;-3782.925,-6326.945;Inherit;False;Property;_Vector2;Vector 2;5;1;[HideInInspector];Create;True;0;0;False;0;False;0,0,0,0;0.26,-0.18,0.947,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;101;-3567.595,-3741.584;Inherit;False;Property;_Vector3;Vector 3;7;1;[HideInInspector];Create;True;0;0;False;0;False;0,0,0,0;-0.303,0.14,0.94223,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;102;-3217.73,-4045.193;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;2.67;False;2;FLOAT;-358.5;False;3;FLOAT;6.95;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;103;-1996.889,-4051.582;Inherit;False;Property;_Vector4;Vector 4;6;1;[HideInInspector];Create;True;0;0;False;0;False;0,0,0,0;-6.85,-5,-0.26,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;104;-1649.766,-4041.218;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.9;False;2;FLOAT;-1.43;False;3;FLOAT;4.77;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;107;-3434.778,-5491.719;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-2.07;False;2;FLOAT;150.29;False;3;FLOAT;6.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;111;-2934.115,-3832.452;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;110;-2999.557,-2640.757;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT;-2.9;False;3;FLOAT;0.43;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;109;-2952.549,-3092.057;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;34.31;False;2;FLOAT;-446.3;False;3;FLOAT;1.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;113;-2052.53,-4295.439;Inherit;False;Constant;_Color1;Color 1;27;0;Create;True;0;0;False;0;False;0.035,0.035,0.035,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;112;-3418.495,-5163.861;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.15;False;2;FLOAT;0.1;False;3;FLOAT;-165.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;114;-3092.187,-4494.786;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;4.5;False;2;FLOAT;-175.94;False;3;FLOAT;2.78;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;105;-3567.847,-6136.854;Inherit;True;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-0.71;False;2;FLOAT;129.8;False;3;FLOAT;58.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;108;-3013.634,-4944.612;Inherit;True;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT;-49.9;False;3;FLOAT;0.88;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;106;-3465.82,-5751.469;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.9;False;2;FLOAT;4.5;False;3;FLOAT;4.77;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-2699.115,-4522.633;Inherit;False;Constant;_Float13;Float 13;24;0;Create;True;0;0;False;0;False;0.004;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;126;-3451.942,-6395.658;Inherit;True;Standard;TangentNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;4.85;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;-2974.604,-5372.458;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;119;-2615.881,-4897.763;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;118;-2799.66,-4416.954;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-2956.248,-4124.876;Inherit;False;Constant;_Float16;Float 16;24;0;Create;True;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-1691.542,-4178.336;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;120;-3264.682,-5976.57;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;121;-2660.021,-3014.224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2606.484,-2668.603;Inherit;False;Constant;_Float15;Float 15;24;0;Create;True;0;0;False;0;False;0.012;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;127;-2846.668,-3965.653;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;116;-3219.868,-5751.534;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;124;-2707.03,-2562.924;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-2559.477,-3119.904;Inherit;False;Constant;_Float14;Float 14;24;0;Create;True;0;0;False;0;False;0.003;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-2728.819,-6140.435;Inherit;False;Constant;_Float17;Float 17;20;0;Create;True;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;138;-2376.046,-4772.349;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;70;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;-2992.19,-5682.73;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;135;-2883.334,-5955.206;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;136;-1375.405,-4049.972;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;133;-2628.437,-5322.489;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-2627.396,-3880.985;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-2487.758,-2478.255;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-2580.39,-4332.285;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;-2440.751,-2929.555;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-2455.561,-5853.725;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-2126.41,-4765.568;Inherit;False;6;6;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-2631.692,-5636.717;Inherit;False;Constant;_Float18;Float 18;20;0;Create;True;0;0;False;0;False;0.014;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;139;-2611.327,-5527.086;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;145;-2222.664,-5682.541;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;3;-1787.772,637.6238;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-4;False;2;FLOAT;13.63;False;3;FLOAT;0.65;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2;-1908.443,347.7588;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-0.69;False;2;FLOAT;57.11;False;3;FLOAT;2.24;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;144;-2222.658,-4942.677;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;1;-1954.746,59.74084;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.9;False;2;FLOAT;-6.35;False;3;FLOAT;8.21;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-2155.512,-5504.327;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;4;-1945.122,-187.4552;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-4.79;False;2;FLOAT;277.67;False;3;FLOAT;4.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;146;-1849.518,-5779.579;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;8;-1635.62,-175.0852;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;5;-1447.765,601.0718;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-1494.24,376.0369;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;-1589.145,49.94983;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1361.467,118.7538;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;11;-1121.206,-24.25415;Inherit;False;SchlickIOR;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1.23;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-986.688,-121.5941;Inherit;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;24;-1267.388,870.2899;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-2.8;False;2;FLOAT;2.01;False;3;FLOAT;-0.07;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1300.902,514.1588;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LuminanceNode;147;-2176.125,-6025.614;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-763.729,44.81384;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-880.8411,183.0739;Inherit;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-980.605,274.3978;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;-969.9631,775.6339;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;148;-2183.054,-6288.673;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;3;False;1;COLOR;0
Node;AmplifyShaderEditor.GammaToLinearNode;149;-2065.594,-6469.654;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;89;-1088.593,-755.4095;Inherit;False;Property;_Color;Color;4;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;1024,136.1153,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;150;-2014.5,-6208.282;Inherit;False;Constant;_Float19;Float 19;27;0;Create;True;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;21;-580.8372,709.0018;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;11;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;20;-667.3682,151.2686;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-891.7514,-590.058;Inherit;False;Constant;_Float11;Float 11;8;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-966.3662,-476.9745;Inherit;False;Constant;_Float12;Float 12;8;0;Create;True;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-827.3623,-1944.946;Inherit;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-901.9772,-1831.862;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-524.79,297.1569;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;151;-1826.286,-6348.214;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;161;-668.3171,-1848.862;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-622.8174,-314.3467;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;90;-732.7063,-493.974;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;162;-450.6581,-1825.286;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-646.1224,-504.6785;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;85;-501.3948,-769.8025;Inherit;True;Property;_MainTex;_MainTex;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;152;-61.2094,-1452.743;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;23;-284.861,-302.1596;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;81;491.2681,22.22549;Inherit;False;Constant;_Float10;Float 10;3;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;-112.362,-527.2817;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;164;582.8681,-1513.154;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;79;509.1833,181.5606;Inherit;False;Constant;_Float9;Float 9;3;0;Create;True;0;0;False;0;False;0.85;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;80;643.9081,86.45445;Inherit;False;Property;_SeeThrough;See Through?;1;0;Create;True;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;83;478.8539,-747.7352;Inherit;False;Property;_UseOldVersion;Use Old Version?;2;0;Create;True;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;240.5996,-427.7327;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered /InstantLatex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;102;0;100;0
WireConnection;104;0;103;0
WireConnection;111;0;102;0
WireConnection;110;0;101;0
WireConnection;109;0;101;0
WireConnection;112;0;100;0
WireConnection;114;0;100;0
WireConnection;105;0;100;0
WireConnection;108;0;100;0
WireConnection;106;0;100;0
WireConnection;122;0;107;0
WireConnection;122;1;112;0
WireConnection;119;0;108;0
WireConnection;118;0;114;0
WireConnection;117;0;113;0
WireConnection;117;1;104;0
WireConnection;120;0;105;0
WireConnection;121;0;109;0
WireConnection;127;0;111;0
WireConnection;116;0;106;0
WireConnection;124;0;110;0
WireConnection;138;1;119;0
WireConnection;132;0;120;0
WireConnection;132;1;116;0
WireConnection;135;0;126;0
WireConnection;136;0;117;0
WireConnection;133;0;122;0
WireConnection;134;0;128;0
WireConnection;134;1;127;0
WireConnection;130;0;125;0
WireConnection;130;1;124;0
WireConnection;129;0;115;0
WireConnection;129;1;118;0
WireConnection;131;0;123;0
WireConnection;131;1;121;0
WireConnection;142;0;137;0
WireConnection;142;1;135;0
WireConnection;140;0;138;0
WireConnection;140;1;129;0
WireConnection;140;2;134;0
WireConnection;140;3;131;0
WireConnection;140;4;130;0
WireConnection;140;5;136;0
WireConnection;139;0;133;0
WireConnection;139;1;132;0
WireConnection;145;1;142;0
WireConnection;144;0;140;0
WireConnection;143;0;141;0
WireConnection;143;1;139;0
WireConnection;146;0;145;0
WireConnection;146;1;144;0
WireConnection;146;2;143;0
WireConnection;8;0;4;0
WireConnection;5;0;3;0
WireConnection;9;0;2;0
WireConnection;6;0;1;0
WireConnection;12;0;8;0
WireConnection;12;1;6;0
WireConnection;14;0;9;0
WireConnection;14;1;5;0
WireConnection;147;0;146;0
WireConnection;15;0;10;0
WireConnection;15;1;11;0
WireConnection;18;0;14;0
WireConnection;18;1;12;0
WireConnection;17;0;24;0
WireConnection;148;1;147;0
WireConnection;149;0;148;0
WireConnection;21;1;17;0
WireConnection;20;1;15;0
WireConnection;19;0;16;0
WireConnection;19;1;18;0
WireConnection;151;0;149;0
WireConnection;151;1;148;0
WireConnection;151;2;150;0
WireConnection;161;0;89;0
WireConnection;161;1;160;0
WireConnection;161;2;158;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;22;2;19;0
WireConnection;90;0;89;0
WireConnection;90;1;91;0
WireConnection;90;2;92;0
WireConnection;162;0;161;0
WireConnection;162;1;151;0
WireConnection;87;0;90;0
WireConnection;87;1;22;0
WireConnection;152;0;162;0
WireConnection;23;0;87;0
WireConnection;84;0;85;0
WireConnection;84;1;23;0
WireConnection;164;0;85;0
WireConnection;164;1;152;0
WireConnection;80;0;81;0
WireConnection;80;1;79;0
WireConnection;83;0;164;0
WireConnection;83;1;84;0
WireConnection;0;2;83;0
WireConnection;0;9;80;0
ASEEND*/
//CHKSM=10CBDE8B04D5BD637F83230D62749F62CA304AAD