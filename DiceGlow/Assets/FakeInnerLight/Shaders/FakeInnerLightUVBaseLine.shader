// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/FakeInnerLightUVBaseLine"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_MOS("MOS", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("NormalScale", Float) = 1
		[Normal]_RefractionNormal("RefractionNormal", 2D) = "bump" {}
		_RefractionNormalScale("RefractionNormalScale", Float) = 1
		[Toggle]_RefractionMode("RefractionMode", Float) = 0
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColorBase("EmissionColorBase", Color) = (0,0,0,0)
		[HDR]_EmissionColorLight("EmissionColorLight", Color) = (1,1,1,0)
		_diffusion("diffusion", Float) = 0.15
		_PointA("PointA", Vector) = (0,0,0.5,0)
		_PointB("PointB", Vector) = (1,1,0.5,0)
		_ScaleU("ScaleU", Float) = 1
		_ScaleV("ScaleV", Float) = 1
		_LoopU("LoopU", Float) = 1
		_LoopV("LoopV", Float) = 1
		_LoopOffsetU("LoopOffsetU", Float) = 0
		_LoopOffsetV("LoopOffsetV", Float) = 0
		[Toggle]_UseUV2("UseUV2", Float) = 0
		[Toggle]_GaussianDiffuse("GaussianDiffuse", Float) = 1
		[Toggle]_SmoothToneMap("SmoothToneMap", Float) = 1
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
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
			float2 uv2_texcoord2;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _NormalScale;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Color;
		uniform float _SmoothToneMap;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColorBase;
		uniform float _GaussianDiffuse;
		uniform float _UseUV2;
		uniform float _LoopU;
		uniform float _LoopV;
		uniform float _LoopOffsetU;
		uniform float _LoopOffsetV;
		uniform sampler2D _RefractionNormal;
		uniform float4 _RefractionNormal_ST;
		uniform float _RefractionNormalScale;
		uniform float _RefractionMode;
		uniform float _ScaleU;
		uniform float _ScaleV;
		uniform float3 _PointA;
		uniform float3 _PointB;
		uniform float _diffusion;
		uniform float4 _EmissionColorLight;
		uniform sampler2D _MOS;
		uniform float4 _MOS_ST;
		uniform float _Metallic;
		uniform float _Smoothness;


		void DeriveTangentBasis( float3 WorldPosition, float3 WorldNormal, float2 UV, out float3x3 TangentToWorld, out float3x3 WorldToTangent )
		{
			#if (SHADER_TARGET >= 45)
			float3 dPdx = ddx_fine( WorldPosition );
			float3 dPdy = ddy_fine( WorldPosition );
			#else
			float3 dPdx = ddx( WorldPosition );
			float3 dPdy = ddy( WorldPosition );
			#endif
			float3 sigmaX = dPdx - dot( dPdx, WorldNormal ) * WorldNormal;
			float3 sigmaY = dPdy - dot( dPdy, WorldNormal ) * WorldNormal;
			float flip_sign = dot( dPdy, cross( WorldNormal, dPdx ) ) < 0 ? -1 : 1;
			#if (SHADER_TARGET >= 45)
			float2 dSTdx = ddx_fine( UV );
			float2 dSTdy = ddy_fine( UV );
			#else
			float2 dSTdx = ddx( UV );
			float2 dSTdy = ddy( UV );
			#endif
			float det = dot( dSTdx, float2( dSTdy.y, -dSTdy.x ) );
			float sign_det = ( det < 0 ) ? -1 : 1;
			float2 invC0 = sign_det * float2( dSTdy.y, -dSTdx.y );
			float3 T = sigmaX * invC0.x + sigmaY * invC0.y;
			if ( abs( det ) > 0 ) T = normalize( T );
			float3 B = ( sign_det * flip_sign ) * cross( WorldNormal, T );
			WorldToTangent = float3x3( T, B, WorldNormal );
			TangentToWorld = transpose( WorldToTangent );
			return;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * _Color ).rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode42 = tex2D( _Emission, uv_Emission );
			float3 ase_worldPos = i.worldPos;
			float3 localDeriveTangentBasis1_g4 = ( float3( 0,0,0 ) );
			float3 WorldPosition1_g4 = ase_worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 WorldNormal1_g4 = ase_normWorldNormal;
			float2 UV1_g4 = (( _UseUV2 )?( i.uv2_texcoord2 ):( i.uv_texcoord ));
			float3x3 TangentToWorld1_g4 = float3x3( 1,0,0,1,1,1,1,0,1 );
			float3x3 WorldToTangent1_g4 = float3x3( 1,0,0,1,1,1,1,0,1 );
			DeriveTangentBasis( WorldPosition1_g4 , WorldNormal1_g4 , UV1_g4 , TangentToWorld1_g4 , WorldToTangent1_g4 );
			float3x3 temp_output_415_0 = TangentToWorld1_g4;
			float2 appendResult185 = (float2(_LoopU , _LoopV));
			float2 appendResult190 = (float2(_LoopOffsetU , _LoopOffsetV));
			float2 uv_RefractionNormal = i.uv_texcoord * _RefractionNormal_ST.xy + _RefractionNormal_ST.zw;
			float2 temp_output_406_0 = (UnpackScaleNormal( tex2D( _RefractionNormal, uv_RefractionNormal ), _RefractionNormalScale )).xy;
			float2 lerpResult414 = lerp( float2( 0,0 ) , temp_output_406_0 , (( _RefractionMode )?( 1.0 ):( 0.0 )));
			float2 appendResult195 = (float2(_ScaleU , _ScaleV));
			float2 temp_output_199_0 = ( (float2( -0.5,-0.5 ) + (frac( ( ( (( _UseUV2 )?( i.uv2_texcoord2 ):( i.uv_texcoord )) * appendResult185 ) + appendResult190 + lerpResult414 ) ) - float2( 0,0 )) * (float2( 0.5,0.5 ) - float2( -0.5,-0.5 )) / (float2( 1,1 ) - float2( 0,0 ))) * appendResult195 );
			float2 appendResult200 = (float2(_PointA.x , _PointA.y));
			float2 lerpResult413 = lerp( temp_output_406_0 , float2( 0,0 ) , (( _RefractionMode )?( 1.0 ):( 0.0 )));
			float3 appendResult203 = (float3(( temp_output_199_0 + appendResult200 + lerpResult413 ) , _PointA.z));
			float3 temp_output_207_0 = ( ase_worldPos - mul( temp_output_415_0, appendResult203 ) );
			float2 appendResult228 = (float2(_PointB.x , _PointB.y));
			float3 appendResult225 = (float3(( temp_output_199_0 + appendResult228 + lerpResult413 ) , _PointB.z));
			float3 temp_output_227_0 = ( ase_worldPos - mul( temp_output_415_0, appendResult225 ) );
			float3 temp_output_232_0 = ( temp_output_207_0 - temp_output_227_0 );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 temp_output_234_0 = cross( temp_output_232_0 , ase_worldViewDir );
			float3 normalizeResult236 = normalize( cross( temp_output_234_0 , temp_output_232_0 ) );
			float3 normalizeResult233 = normalize( temp_output_232_0 );
			float3 normalizeResult169 = normalize( temp_output_234_0 );
			float3 WorldSpacePointA336 = temp_output_207_0;
			float3 break253 = mul( float3x3(normalizeResult236, normalizeResult233, normalizeResult169), ( _WorldSpaceCameraPos - WorldSpacePointA336 ) );
			float3 normalizeResult330 = normalize( ( WorldSpacePointA336 - _WorldSpaceCameraPos ) );
			float3 normalizeResult342 = normalize( ase_worldViewDir );
			float3 ViewDirNormalized344 = normalizeResult342;
			float dotResult324 = dot( normalizeResult330 , -ViewDirNormalized344 );
			float3 break306 = mul( float3x3(normalizeResult236, normalizeResult233, normalizeResult169), ViewDirNormalized344 );
			float3 WorldSpacePointB337 = temp_output_227_0;
			float temp_output_316_0 = ceil( ( ( break253.y - ( ( break253.x / break306.x ) * break306.y ) ) / distance( WorldSpacePointA336 , WorldSpacePointB337 ) ) );
			float lerpResult335 = lerp( abs( break253.z ) , distance( WorldSpacePointA336 , ( _WorldSpaceCameraPos + ( distance( WorldSpacePointA336 , _WorldSpaceCameraPos ) * dotResult324 * -ViewDirNormalized344 ) ) ) , saturate( temp_output_316_0 ));
			float3 normalizeResult356 = normalize( ( WorldSpacePointB337 - _WorldSpaceCameraPos ) );
			float dotResult360 = dot( normalizeResult356 , -ViewDirNormalized344 );
			float lerpResult350 = lerp( lerpResult335 , distance( WorldSpacePointB337 , ( _WorldSpaceCameraPos + ( distance( WorldSpacePointB337 , _WorldSpaceCameraPos ) * dotResult360 * -ViewDirNormalized344 ) ) ) , saturate( -temp_output_316_0 ));
			float4 temp_output_47_0 = ( ( tex2DNode42 * _EmissionColorBase ) + ( exp2( ( (( _GaussianDiffuse )?( ( lerpResult350 * lerpResult350 ) ):( lerpResult350 )) / -_diffusion ) ) * tex2DNode42 * _EmissionColorLight ) );
			float4 temp_cast_1 = (40.0).xxxx;
			float4 break391 = min( temp_output_47_0 , temp_cast_1 );
			float3 appendResult392 = (float3(tanh( break391.r ) , tanh( break391.g ) , tanh( break391.b )));
			o.Emission = (( _SmoothToneMap )?( float4( appendResult392 , 0.0 ) ):( temp_output_47_0 )).rgb;
			float2 uv_MOS = i.uv_texcoord * _MOS_ST.xy + _MOS_ST.zw;
			float4 tex2DNode70 = tex2D( _MOS, uv_MOS );
			o.Metallic = ( tex2DNode70.r * _Metallic );
			o.Smoothness = ( tex2DNode70.a * _Smoothness );
			o.Occlusion = tex2DNode70.g;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
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
			#pragma target 4.6
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
				surfIN.worldPos = worldPos;
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
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
12;-1076;1906;1051;102.2552;1225.645;3.154763;True;False
Node;AmplifyShaderEditor.CommentaryNode;162;-3984,496;Inherit;False;5723.762;902.7356;光源描画;10;350;335;337;375;336;376;377;373;163;389;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;163;-3952,544;Inherit;False;1895.671;837.8978;UVの座標空間上の点をTangent座標系からWorld座標系へ変換;30;229;224;227;226;225;231;230;207;205;203;201;199;222;228;200;206;195;194;193;192;191;190;189;187;211;188;185;182;181;283;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;184;-4496,624;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;409;-4368,1552;Inherit;False;Property;_RefractionNormalScale;RefractionNormalScale;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;183;-4496,736;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;181;-3904,832;Inherit;False;Property;_LoopU;LoopU;18;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;408;-4128,1504;Inherit;True;Property;_RefractionNormal;RefractionNormal;7;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;182;-3904,912;Inherit;False;Property;_LoopV;LoopV;19;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;186;-4208,656;Inherit;False;Property;_UseUV2;UseUV2;22;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;406;-3840,1504;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;410;-3792,1696;Inherit;False;Property;_RefractionMode;RefractionMode;9;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-3920,992;Inherit;False;Property;_LoopOffsetU;LoopOffsetU;20;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;185;-3744,832;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RelayNode;211;-3920,656;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-3920,1072;Inherit;False;Property;_LoopOffsetV;LoopOffsetV;21;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;190;-3744,992;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-3568,752;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;414;-3552,1584;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;-3408,752;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;192;-3280,752;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-3280,928;Inherit;False;Property;_ScaleU;ScaleU;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;-3280,1008;Inherit;False;Property;_ScaleV;ScaleV;17;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;283;-3152,752;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-0.5,-0.5;False;4;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;195;-3120,928;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;229;-3328,1232;Inherit;False;Property;_PointB;PointB;15;0;Create;True;0;0;0;False;0;False;1,1,0.5;1,1,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;222;-3328,1088;Inherit;False;Property;_PointA;PointA;14;0;Create;True;0;0;0;False;0;False;0,0,0.5;0,0,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;228;-3120,1232;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;200;-3120,1088;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;-2944,752;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;413;-3056,1504;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;230;-2944,1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;231;-2992,1168;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;201;-2768,752;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;224;-2768,960;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;415;-2736,656;Inherit;False;Derive Tangent Basis;-1;;4;fee816718ad753c4f9b25822c0d67438;0;1;5;FLOAT2;0,0;False;2;FLOAT3x3;0;FLOAT3x3;6
Node;AmplifyShaderEditor.DynamicAppendNode;225;-2624,960;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;203;-2624,752;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;206;-2448,608;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-2400,752;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;-2400,960;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;207;-2208,752;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;227;-2208,960;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;373;-2032,720;Inherit;False;996;374;光源直線とViewDirの最短直線を基準とした座標空間への変換行列;8;238;169;233;236;235;234;166;232;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;166;-1984,928;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;232;-1952,832;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;380;-1808,144;Inherit;False;646;234;ViewDirのSafeNomalizeが機能しないので;3;341;342;344;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CrossProductOpNode;234;-1792,896;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;341;-1760,192;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CrossProductOpNode;235;-1584,768;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;-1984,624;Inherit;False;WorldSpacePointA;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;342;-1584,192;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;377;-960,544;Inherit;False;988.3944;380.311;Z座標が最短距離;8;286;366;378;253;262;282;374;261;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;169;-1424,896;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;233;-1424,832;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;236;-1424,768;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;366;-912,816;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;238;-1264,800;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;344;-1440,192;Inherit;False;ViewDirNormalized;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;376;-720,944;Inherit;False;1556.786;435.9519;端の境界 カメラ始点の視線ベクトルがX=0となる地点が光源直線上の位置;12;349;334;348;316;315;309;307;305;306;302;345;381;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;261;-912,672;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;374;-944,640;Inherit;False;1;0;FLOAT3x3;1,0,0,0,0,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;345;-672,1088;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;375;-928,992;Inherit;False;1;0;FLOAT3x3;1,0,0,0,0,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;282;-656,672;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;372;-768,-544;Inherit;False;1386.444;1008.2;末端の距離関数;2;370;371;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-512,592;Inherit;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;371;-720,-16;Inherit;False;1286.509;448.2318;点と直線の距離 A点;12;340;331;329;328;327;324;320;330;325;323;346;322;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;302;-416,1024;Inherit;False;2;2;0;FLOAT3x3;0,0,0,0,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;306;-288,1024;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;253;-368,592;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;370;-720,-480;Inherit;False;1285.315;449.4827;点と直線の距離 B点;12;351;364;357;359;362;360;361;356;355;354;353;363;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;337;-1984,1120;Inherit;False;WorldSpacePointB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;-672,48;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;322;-688,224;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;323;-336,240;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;363;-688,-240;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;381;-256,1152;Inherit;False;495;218;光源直線にに長さで倍率をかけ、範囲を0-1にリマップ;3;314;338;339;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;-416,336;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;-672,-416;Inherit;False;337;WorldSpacePointB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;305;-160,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;325;-176,336;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-16,1024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;354;-336,-224;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;330;-192,240;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;-208,1200;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;378;-128,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;339;-208,1280;Inherit;False;337;WorldSpacePointB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;353;-416,-128;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;309;128,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;314;64,1232;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;324;-32,272;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;320;-336,144;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;355;-176,-128;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;356;-192,-224;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;361;-336,-320;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;327;112,256;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;328;-16,112;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;315;272,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;360;-32,-192;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;316;400,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;112,-208;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;329;272,176;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;359;-16,-352;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;331;416,48;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;286;-128,640;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;357;272,-288;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;334;528,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;348;528,1072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;349;656,1072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;335;752,640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;351;416,-416;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;389;1080,590;Inherit;False;624;314;拡散のしかた;6;385;382;384;383;388;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;350;912,640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;384;1152,800;Inherit;False;Property;_diffusion;diffusion;13;0;Create;True;0;0;0;False;0;False;0.15;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;387;1104,704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;385;1312,800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;388;1248,640;Inherit;False;Property;_GaussianDiffuse;GaussianDiffuse;23;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;383;1472,704;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;1872,560;Inherit;False;Property;_EmissionColorBase;EmissionColorBase;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.3207547,0.3207547,0.3207547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;1808,368;Inherit;True;Property;_Emission;Emission;10;0;Create;True;0;0;0;False;0;False;-1;None;28fd5c945e5747b479f596580d7e4a4d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Exp2OpNode;382;1584,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;128;1872,816;Inherit;False;Property;_EmissionColorLight;EmissionColorLight;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.171983,1.171983,1.171983,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;405;2432,688;Inherit;False;694;273;SmoothToneMaping;7;401;404;392;394;390;393;391;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2192,704;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;2192,464;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;2384,576;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;401;2448,832;Inherit;False;Constant;_max;max;23;0;Create;True;0;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;404;2592,768;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;391;2704,768;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TanhOpNode;394;2832,864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;2544,-80;Inherit;True;Property;_MOS;MOS;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TanhOpNode;393;2832,800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;390;2832,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;2944,112;Inherit;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;0;False;0;False;0;0.334;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;2880,-608;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;392;2960,768;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;105;2880,176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;2960,-416;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;2944,16;Inherit;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;407;2848,-192;Inherit;False;Property;_NormalScale;NormalScale;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;106;2928,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;3216,-512;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;3216,64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;73;3056,-240;Inherit;True;Property;_Normal;Normal;5;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;3216,-48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;398;3168,576;Inherit;False;Property;_SmoothToneMap;SmoothToneMap;24;0;Create;True;0;0;0;False;0;False;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3536,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;uniuni/FakeInnerLightUVBaseLine;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;408;5;409;0
WireConnection;186;0;184;0
WireConnection;186;1;183;0
WireConnection;406;0;408;0
WireConnection;185;0;181;0
WireConnection;185;1;182;0
WireConnection;211;0;186;0
WireConnection;190;0;188;0
WireConnection;190;1;187;0
WireConnection;189;0;211;0
WireConnection;189;1;185;0
WireConnection;414;1;406;0
WireConnection;414;2;410;0
WireConnection;191;0;189;0
WireConnection;191;1;190;0
WireConnection;191;2;414;0
WireConnection;192;0;191;0
WireConnection;283;0;192;0
WireConnection;195;0;194;0
WireConnection;195;1;193;0
WireConnection;228;0;229;1
WireConnection;228;1;229;2
WireConnection;200;0;222;1
WireConnection;200;1;222;2
WireConnection;199;0;283;0
WireConnection;199;1;195;0
WireConnection;413;0;406;0
WireConnection;413;2;410;0
WireConnection;230;0;229;3
WireConnection;231;0;222;3
WireConnection;201;0;199;0
WireConnection;201;1;200;0
WireConnection;201;2;413;0
WireConnection;224;0;199;0
WireConnection;224;1;228;0
WireConnection;224;2;413;0
WireConnection;415;5;211;0
WireConnection;225;0;224;0
WireConnection;225;2;230;0
WireConnection;203;0;201;0
WireConnection;203;2;231;0
WireConnection;205;0;415;0
WireConnection;205;1;203;0
WireConnection;226;0;415;0
WireConnection;226;1;225;0
WireConnection;207;0;206;0
WireConnection;207;1;205;0
WireConnection;227;0;206;0
WireConnection;227;1;226;0
WireConnection;232;0;207;0
WireConnection;232;1;227;0
WireConnection;234;0;232;0
WireConnection;234;1;166;0
WireConnection;235;0;234;0
WireConnection;235;1;232;0
WireConnection;336;0;207;0
WireConnection;342;0;341;0
WireConnection;169;0;234;0
WireConnection;233;0;232;0
WireConnection;236;0;235;0
WireConnection;238;0;236;0
WireConnection;238;1;233;0
WireConnection;238;2;169;0
WireConnection;344;0;342;0
WireConnection;374;0;238;0
WireConnection;375;0;238;0
WireConnection;282;0;261;0
WireConnection;282;1;366;0
WireConnection;262;0;374;0
WireConnection;262;1;282;0
WireConnection;302;0;375;0
WireConnection;302;1;345;0
WireConnection;306;0;302;0
WireConnection;253;0;262;0
WireConnection;337;0;227;0
WireConnection;323;0;340;0
WireConnection;323;1;322;0
WireConnection;305;0;253;0
WireConnection;305;1;306;0
WireConnection;325;0;346;0
WireConnection;307;0;305;0
WireConnection;307;1;306;1
WireConnection;354;0;364;0
WireConnection;354;1;363;0
WireConnection;330;0;323;0
WireConnection;378;0;253;1
WireConnection;309;0;378;0
WireConnection;309;1;307;0
WireConnection;314;0;338;0
WireConnection;314;1;339;0
WireConnection;324;0;330;0
WireConnection;324;1;325;0
WireConnection;320;0;340;0
WireConnection;320;1;322;0
WireConnection;355;0;353;0
WireConnection;356;0;354;0
WireConnection;361;0;364;0
WireConnection;361;1;363;0
WireConnection;327;0;320;0
WireConnection;327;1;324;0
WireConnection;327;2;325;0
WireConnection;315;0;309;0
WireConnection;315;1;314;0
WireConnection;360;0;356;0
WireConnection;360;1;355;0
WireConnection;316;0;315;0
WireConnection;362;0;361;0
WireConnection;362;1;360;0
WireConnection;362;2;355;0
WireConnection;329;0;328;0
WireConnection;329;1;327;0
WireConnection;331;0;340;0
WireConnection;331;1;329;0
WireConnection;286;0;253;2
WireConnection;357;0;359;0
WireConnection;357;1;362;0
WireConnection;334;0;316;0
WireConnection;348;0;316;0
WireConnection;349;0;348;0
WireConnection;335;0;286;0
WireConnection;335;1;331;0
WireConnection;335;2;334;0
WireConnection;351;0;364;0
WireConnection;351;1;357;0
WireConnection;350;0;335;0
WireConnection;350;1;351;0
WireConnection;350;2;349;0
WireConnection;387;0;350;0
WireConnection;387;1;350;0
WireConnection;385;0;384;0
WireConnection;388;0;350;0
WireConnection;388;1;387;0
WireConnection;383;0;388;0
WireConnection;383;1;385;0
WireConnection;382;0;383;0
WireConnection;45;0;382;0
WireConnection;45;1;42;0
WireConnection;45;2;128;0
WireConnection;52;0;42;0
WireConnection;52;1;43;0
WireConnection;47;0;52;0
WireConnection;47;1;45;0
WireConnection;404;0;47;0
WireConnection;404;1;401;0
WireConnection;391;0;404;0
WireConnection;394;0;391;2
WireConnection;393;0;391;1
WireConnection;390;0;391;0
WireConnection;392;0;390;0
WireConnection;392;1;393;0
WireConnection;392;2;394;0
WireConnection;105;0;70;2
WireConnection;106;0;105;0
WireConnection;55;0;41;0
WireConnection;55;1;54;0
WireConnection;72;0;70;4
WireConnection;72;1;50;0
WireConnection;73;5;407;0
WireConnection;71;0;70;1
WireConnection;71;1;49;0
WireConnection;398;0;47;0
WireConnection;398;1;392;0
WireConnection;0;0;55;0
WireConnection;0;1;73;0
WireConnection;0;2;398;0
WireConnection;0;3;71;0
WireConnection;0;4;72;0
WireConnection;0;5;106;0
ASEEND*/
//CHKSM=4DE5EFBE2E7FCD0CE7225D745A1301FBFDBD62EA