// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/FakeInnerLightUVBase"
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
		_LightDepth("LightDepth", Float) = 0.5
		_ScaleU("ScaleU", Float) = 1
		_ScaleV("ScaleV", Float) = 1
		_LoopU("LoopU", Float) = 1
		_LoopV("LoopV", Float) = 1
		_OffsetU("OffsetU", Float) = 0
		_OffsetV("OffsetV", Float) = 0
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
		uniform float _OffsetU;
		uniform float _OffsetV;
		uniform float _LightDepth;
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
			float3 localDeriveTangentBasis1_g3 = ( float3( 0,0,0 ) );
			float3 WorldPosition1_g3 = ase_worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 WorldNormal1_g3 = ase_normWorldNormal;
			float2 UV1_g3 = (( _UseUV2 )?( i.uv2_texcoord2 ):( i.uv_texcoord ));
			float3x3 TangentToWorld1_g3 = float3x3( 1,0,0,1,1,1,1,0,1 );
			float3x3 WorldToTangent1_g3 = float3x3( 1,0,0,1,1,1,1,0,1 );
			DeriveTangentBasis( WorldPosition1_g3 , WorldNormal1_g3 , UV1_g3 , TangentToWorld1_g3 , WorldToTangent1_g3 );
			float2 appendResult195 = (float2(_LoopU , _LoopV));
			float2 appendResult197 = (float2(_LoopOffsetU , _LoopOffsetV));
			float2 uv_RefractionNormal = i.uv_texcoord * _RefractionNormal_ST.xy + _RefractionNormal_ST.zw;
			float2 temp_output_291_0 = (UnpackScaleNormal( tex2D( _RefractionNormal, uv_RefractionNormal ), _RefractionNormalScale )).xy;
			float2 lerpResult293 = lerp( float2( 0,0 ) , temp_output_291_0 , (( _RefractionMode )?( 1.0 ):( 0.0 )));
			float2 appendResult206 = (float2(_ScaleU , _ScaleV));
			float2 appendResult208 = (float2(_OffsetU , _OffsetV));
			float2 lerpResult294 = lerp( temp_output_291_0 , float2( 0,0 ) , (( _RefractionMode )?( 1.0 ):( 0.0 )));
			float3 appendResult211 = (float3(( ( (float2( -0.5,-0.5 ) + (frac( ( ( (( _UseUV2 )?( i.uv2_texcoord2 ):( i.uv_texcoord )) * appendResult195 ) + appendResult197 + lerpResult293 ) ) - float2( 0,0 )) * (float2( 0.5,0.5 ) - float2( -0.5,-0.5 )) / (float2( 1,1 ) - float2( 0,0 ))) * appendResult206 ) + appendResult208 + lerpResult294 ) , _LightDepth));
			float3 temp_output_215_0 = ( ase_worldPos - mul( TangentToWorld1_g3, appendResult211 ) );
			float3 normalizeResult244 = normalize( ( temp_output_215_0 - _WorldSpaceCameraPos ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult258 = normalize( ase_worldViewDir );
			float3 ViewDirNormalized259 = normalizeResult258;
			float dotResult247 = dot( normalizeResult244 , -ViewDirNormalized259 );
			float temp_output_251_0 = distance( temp_output_215_0 , ( _WorldSpaceCameraPos + ( distance( temp_output_215_0 , _WorldSpaceCameraPos ) * dotResult247 * -ViewDirNormalized259 ) ) );
			float4 temp_output_47_0 = ( ( tex2DNode42 * _EmissionColorBase ) + ( exp2( ( (( _GaussianDiffuse )?( ( temp_output_251_0 * temp_output_251_0 ) ):( temp_output_251_0 )) / -_diffusion ) ) * tex2DNode42 * _EmissionColorLight ) );
			float4 temp_cast_1 = (40.0).xxxx;
			float4 break278 = min( temp_output_47_0 , temp_cast_1 );
			float3 appendResult282 = (float3(tanh( break278.r ) , tanh( break278.g ) , tanh( break278.b )));
			o.Emission = (( _SmoothToneMap )?( float4( appendResult282 , 0.0 ) ):( temp_output_47_0 )).rgb;
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
12;-1076;1906;1051;-977.1002;-8.784729;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;190;-3184,384;Inherit;False;3875.026;775.2756;光源描画;3;263;239;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;191;-3152,400;Inherit;False;1887.889;701.7146;UVの座標空間上の点をTangent座標系からWorld座標系へ変換;25;235;215;214;213;212;211;210;209;208;207;206;205;204;203;202;201;200;199;198;197;196;195;194;193;192;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;237;-3632,480;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;289;-3568,1232;Inherit;False;Property;_RefractionNormalScale;RefractionNormalScale;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;236;-3632,592;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;238;-3376,512;Inherit;False;Property;_UseUV2;UseUV2;23;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;290;-3328,1184;Inherit;True;Property;_RefractionNormal;RefractionNormal;7;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;193;-3104,688;Inherit;False;Property;_LoopU;LoopU;17;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-3104,768;Inherit;False;Property;_LoopV;LoopV;18;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-3120,928;Inherit;False;Property;_LoopOffsetV;LoopOffsetV;22;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;292;-2992,1376;Inherit;False;Property;_RefractionMode;RefractionMode;9;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;235;-3120,512;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;196;-3120,848;Inherit;False;Property;_LoopOffsetU;LoopOffsetU;21;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;291;-3040,1184;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;195;-2944,688;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;293;-2752,1264;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;-2768,608;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;197;-2944,848;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;-2608,608;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-2480,784;Inherit;False;Property;_ScaleU;ScaleU;15;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-2480,864;Inherit;False;Property;_ScaleV;ScaleV;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;202;-2480,608;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;-2320,784;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-2480,944;Inherit;False;Property;_OffsetU;OffsetU;19;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;-2480,1024;Inherit;False;Property;_OffsetV;OffsetV;20;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;205;-2352,608;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-0.5,-0.5;False;4;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;208;-2320,944;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;207;-2144,608;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;294;-2256,1184;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-2016,736;Inherit;False;Property;_LightDepth;LightDepth;14;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;209;-1984,608;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;256;-1014.669,6.462597;Inherit;False;703;236;ViewDirのSafeNomalizeが機能しないので;3;257;259;258;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;257;-976,48;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;212;-1952,512;Inherit;False;Derive Tangent Basis;-1;;3;fee816718ad753c4f9b25822c0d67438;0;1;5;FLOAT2;0,0;False;2;FLOAT3x3;0;FLOAT3x3;6
Node;AmplifyShaderEditor.DynamicAppendNode;211;-1840,608;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;213;-1648,464;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;258;-731.6695,56.46259;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;239;-1248,544;Inherit;False;1286.509;448.2318;点と直線の距離;11;251;250;249;248;247;246;245;244;243;242;240;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-1616,608;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;240;-1216,816;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;-587.6695,56.46259;Inherit;False;ViewDirNormalized;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;215;-1424,608;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;242;-864,800;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;243;-944,896;Inherit;False;259;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;245;-704,896;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;244;-720,800;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;247;-560,832;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;246;-864,704;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;248;-416,816;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;249;-544,672;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;250;-256,736;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;263;48,544;Inherit;False;624;314;拡散のしかた;6;269;268;267;266;265;264;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;251;-112,608;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;64,672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;264;112,768;Inherit;False;Property;_diffusion;diffusion;13;0;Create;True;0;0;0;False;0;False;0.15;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;267;272,768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;266;208,608;Inherit;False;Property;_GaussianDiffuse;GaussianDiffuse;24;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;268;432,672;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;832,544;Inherit;False;Property;_EmissionColorBase;EmissionColorBase;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.3207547,0.3207547,0.3207547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;128;832,768;Inherit;False;Property;_EmissionColorLight;EmissionColorLight;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.171983,1.171983,1.171983,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Exp2OpNode;269;544,672;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;768,352;Inherit;True;Property;_Emission;Emission;10;0;Create;True;0;0;0;False;0;False;-1;None;28fd5c945e5747b479f596580d7e4a4d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;277;1376,640;Inherit;False;694;273;SmoothToneMaping;7;284;283;282;281;280;279;278;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1168,672;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1168,432;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;1344,544;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;284;1392,800;Inherit;False;Constant;_max;max;23;0;Create;True;0;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;283;1536,736;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;278;1648,736;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TanhOpNode;281;1776,832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;280;1776,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;279;1776,768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;1248,-16;Inherit;True;Property;_MOS;MOS;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;105;1568,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;295;1552,-160;Inherit;False;Property;_NormalScale;NormalScale;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;282;1904,736;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;49;1616,48;Inherit;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;1648,-384;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;1616,160;Inherit;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;0;False;0;False;0;0.334;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;1568,-576;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;1904,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;106;1984,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;73;1744,-208;Inherit;True;Property;_Normal;Normal;5;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;1904,-480;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;276;2112,544;Inherit;False;Property;_SmoothToneMap;SmoothToneMap;25;0;Create;True;0;0;0;False;0;False;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;1904,-16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2272,-48;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;uniuni/FakeInnerLightUVBase;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;238;0;237;0
WireConnection;238;1;236;0
WireConnection;290;5;289;0
WireConnection;235;0;238;0
WireConnection;291;0;290;0
WireConnection;195;0;193;0
WireConnection;195;1;192;0
WireConnection;293;1;291;0
WireConnection;293;2;292;0
WireConnection;198;0;235;0
WireConnection;198;1;195;0
WireConnection;197;0;196;0
WireConnection;197;1;194;0
WireConnection;199;0;198;0
WireConnection;199;1;197;0
WireConnection;199;2;293;0
WireConnection;202;0;199;0
WireConnection;206;0;200;0
WireConnection;206;1;201;0
WireConnection;205;0;202;0
WireConnection;208;0;204;0
WireConnection;208;1;203;0
WireConnection;207;0;205;0
WireConnection;207;1;206;0
WireConnection;294;0;291;0
WireConnection;294;2;292;0
WireConnection;209;0;207;0
WireConnection;209;1;208;0
WireConnection;209;2;294;0
WireConnection;212;5;235;0
WireConnection;211;0;209;0
WireConnection;211;2;210;0
WireConnection;258;0;257;0
WireConnection;214;0;212;0
WireConnection;214;1;211;0
WireConnection;259;0;258;0
WireConnection;215;0;213;0
WireConnection;215;1;214;0
WireConnection;242;0;215;0
WireConnection;242;1;240;0
WireConnection;245;0;243;0
WireConnection;244;0;242;0
WireConnection;247;0;244;0
WireConnection;247;1;245;0
WireConnection;246;0;215;0
WireConnection;246;1;240;0
WireConnection;248;0;246;0
WireConnection;248;1;247;0
WireConnection;248;2;245;0
WireConnection;250;0;249;0
WireConnection;250;1;248;0
WireConnection;251;0;215;0
WireConnection;251;1;250;0
WireConnection;265;0;251;0
WireConnection;265;1;251;0
WireConnection;267;0;264;0
WireConnection;266;0;251;0
WireConnection;266;1;265;0
WireConnection;268;0;266;0
WireConnection;268;1;267;0
WireConnection;269;0;268;0
WireConnection;45;0;269;0
WireConnection;45;1;42;0
WireConnection;45;2;128;0
WireConnection;52;0;42;0
WireConnection;52;1;43;0
WireConnection;47;0;52;0
WireConnection;47;1;45;0
WireConnection;283;0;47;0
WireConnection;283;1;284;0
WireConnection;278;0;283;0
WireConnection;281;0;278;2
WireConnection;280;0;278;0
WireConnection;279;0;278;1
WireConnection;105;0;70;2
WireConnection;282;0;280;0
WireConnection;282;1;279;0
WireConnection;282;2;281;0
WireConnection;72;0;70;4
WireConnection;72;1;50;0
WireConnection;106;0;105;0
WireConnection;73;5;295;0
WireConnection;55;0;41;0
WireConnection;55;1;54;0
WireConnection;276;0;47;0
WireConnection;276;1;282;0
WireConnection;71;0;70;1
WireConnection;71;1;49;0
WireConnection;0;0;55;0
WireConnection;0;1;73;0
WireConnection;0;2;276;0
WireConnection;0;3;71;0
WireConnection;0;4;72;0
WireConnection;0;5;106;0
ASEEND*/
//CHKSM=9CE3BE4D83E9EDFEA09FC67B0316CCB1D5D5CADE