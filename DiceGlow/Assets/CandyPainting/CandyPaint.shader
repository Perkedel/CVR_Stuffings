// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/CandyPaint"
{
	Properties
	{
		[Header(Base Paint)]_BaseAlbedo("BaseAlbedo", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		_MOS("MOS", 2D) = "white" {}
		_BaseMetallic("BaseMetallic", Range( 0 , 1)) = 1
		_BaseSmoothness("BaseSmoothness", Range( 0 , 1)) = 0.7
		_AO("AO", Range( 0 , 1)) = 1
		[Normal]_BaseNormal("BaseNormal", 2D) = "bump" {}
		_BaseNormalScale("BaseNormalScale", Float) = 1
		[Header(Clear Color Paint)]_ClearColorTexture("ClearColorTexture", 2D) = "white" {}
		_ClearClolr("ClearClolr", Color) = (0.9,0.9,0.9,0)
		[Normal]_ClearNormal("ClearNormal", 2D) = "bump" {}
		_ClearNormalScale("ClearNormalScale", Float) = 1
		_ThicknessMap("ThicknessMap", 2D) = "white" {}
		_Thickness("Thickness", Float) = 1
		_ThicknessMin("ThicknessMin", Float) = 0.2
		_ThicknessMax("ThicknessMax", Float) = 4
		_ClearSmoothness("ClearSmoothness", Range( 0 , 1)) = 1
		_ClearReflection("ClearReflection", Range( 0 , 1)) = 0.5
		_ClearReflectionBias("ClearReflectionBias", Range( 0 , 1)) = 0.015
		[Header(Debug)][Toggle]_BaseColorOnly("BaseColorOnly", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
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
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
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

		uniform float _BaseColorOnly;
		uniform sampler2D _BaseAlbedo;
		uniform float4 _BaseAlbedo_ST;
		uniform float4 _BaseColor;
		uniform sampler2D _BaseNormal;
		uniform float4 _BaseNormal_ST;
		uniform float _BaseNormalScale;
		uniform float _BaseMetallic;
		uniform sampler2D _MOS;
		uniform float4 _MOS_ST;
		uniform float _BaseSmoothness;
		uniform float _AO;
		uniform sampler2D _ClearColorTexture;
		uniform float4 _ClearColorTexture_ST;
		uniform float4 _ClearClolr;
		uniform float _Thickness;
		uniform float _ThicknessMin;
		uniform sampler2D _ThicknessMap;
		uniform float4 _ThicknessMap_ST;
		uniform float _ThicknessMax;
		uniform sampler2D _ClearNormal;
		uniform float4 _ClearNormal_ST;
		uniform float _ClearNormalScale;
		uniform float _ClearReflectionBias;
		uniform float _ClearReflection;
		uniform float _ClearSmoothness;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s21 = (SurfaceOutputStandard ) 0;
			float2 uv_BaseAlbedo = i.uv_texcoord * _BaseAlbedo_ST.xy + _BaseAlbedo_ST.zw;
			s21.Albedo = ( tex2D( _BaseAlbedo, uv_BaseAlbedo ) * _BaseColor ).rgb;
			float2 uv_BaseNormal = i.uv_texcoord * _BaseNormal_ST.xy + _BaseNormal_ST.zw;
			s21.Normal = WorldNormalVector( i , UnpackScaleNormal( tex2D( _BaseNormal, uv_BaseNormal ), _BaseNormalScale ) );
			s21.Emission = float3( 0,0,0 );
			float2 uv_MOS = i.uv_texcoord * _MOS_ST.xy + _MOS_ST.zw;
			float4 tex2DNode44 = tex2D( _MOS, uv_MOS );
			float Metallic127 = tex2DNode44.r;
			s21.Metallic = ( _BaseMetallic * Metallic127 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 temp_output_76_0 = ddx( ase_normWorldNormal );
			float dotResult79 = dot( temp_output_76_0 , temp_output_76_0 );
			float3 temp_output_77_0 = ddy( ase_normWorldNormal );
			float dotResult78 = dot( temp_output_77_0 , temp_output_77_0 );
			float GSAA86 = ( 1.0 - pow( saturate( max( dotResult79 , dotResult78 ) ) , 0.333 ) );
			s21.Smoothness = min( _BaseSmoothness , GSAA86 );
			float lerpResult48 = lerp( 1.0 , tex2DNode44.g , _AO);
			float AO49 = lerpResult48;
			s21.Occlusion = AO49;

			data.light = gi.light;

			UnityGI gi21 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g21 = UnityGlossyEnvironmentSetup( s21.Smoothness, data.worldViewDir, s21.Normal, float3(0,0,0));
			gi21 = UnityGlobalIllumination( data, s21.Occlusion, s21.Normal, g21 );
			#endif

			float3 surfResult21 = LightingStandard ( s21, viewDir, gi21 ).rgb;
			surfResult21 += s21.Emission;

			#ifdef UNITY_PASS_FORWARDADD//21
			surfResult21 -= s21.Emission;
			#endif//21
			float2 uv_ClearColorTexture = i.uv_texcoord * _ClearColorTexture_ST.xy + _ClearColorTexture_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult132 = normalize( ase_worldViewDir );
			float dotResult8 = dot( normalizeResult132 , ase_worldNormal );
			float clampResult10 = clamp( dotResult8 , 0.1 , 1.0 );
			float2 uv_ThicknessMap = i.uv_texcoord * _ThicknessMap_ST.xy + _ThicknessMap_ST.zw;
			float4 temp_cast_2 = (min( ( ( 0.0 + ( _Thickness / clampResult10 ) + _ThicknessMin ) * tex2D( _ThicknessMap, uv_ThicknessMap ).r ) , _ThicknessMax )).xxxx;
			float3 normalizeResult126 = normalize( ase_worldViewDir );
			float2 uv_ClearNormal = i.uv_texcoord * _ClearNormal_ST.xy + _ClearNormal_ST.zw;
			float3 tex2DNode34 = UnpackScaleNormal( tex2D( _ClearNormal, uv_ClearNormal ), _ClearNormalScale );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float smoothness128 = tex2DNode44.a;
			float fresnelNdotV31 = dot( mul(ase_tangentToWorldFast,tex2DNode34), normalizeResult126 );
			float fresnelNode31 = ( min( ( _ClearReflectionBias * smoothness128 ) , GSAA86 ) + min( ( _ClearReflection * smoothness128 ) , GSAA86 ) * pow( max( 1.0 - fresnelNdotV31 , 0.0001 ), 5.0 ) );
			float temp_output_96_0 = saturate( fresnelNode31 );
			float3 indirectNormal32 = WorldNormalVector( i , tex2DNode34 );
			Unity_GlossyEnvironmentData g32 = UnityGlossyEnvironmentSetup( min( ( _ClearSmoothness * smoothness128 ) , GSAA86 ), data.worldViewDir, indirectNormal32, float3(0,0,0));
			float3 indirectSpecular32 = UnityGI_IndirectSpecular( data, AO49, indirectNormal32, g32 );
			c.rgb = (( _BaseColorOnly )?( float4( surfResult21 , 0.0 ) ):( ( ( float4( surfResult21 , 0.0 ) * saturate( pow( ( tex2D( _ClearColorTexture, uv_ClearColorTexture ) * _ClearClolr ) , temp_cast_2 ) ) * ( 1.0 - temp_output_96_0 ) ) + float4( ( indirectSpecular32 * temp_output_96_0 * AO49 ) , 0.0 ) ) )).rgb;
			c.a = 1;
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
0;-1074;1920;1052;3040.232;-1298.339;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;131;-3312,32;Inherit;False;1269;293;GSAA;10;88;77;76;78;79;80;81;82;83;86;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;88;-3264,144;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DdyOpNode;77;-3072,176;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DdxOpNode;76;-3072,112;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;143;-2706,926;Inherit;False;1857;760;ClearPaint;19;7;26;132;8;9;24;10;11;97;39;23;42;40;43;14;141;142;20;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;78;-2944,176;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;79;-2944,80;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;80;-2816,112;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-2656,1232;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;26;-2480,1312;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;136;-2848,384;Inherit;False;805;366;Comment;6;44;128;47;48;49;127;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;81;-2704,112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;132;-2464,1232;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;8;-2224,1248;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;82;-2576,112;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.333;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;145;-2704,1712;Inherit;False;1853;951;Specular;12;135;144;30;130;34;90;46;50;91;32;33;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2272,1360;Inherit;False;Constant;_UnderRimit;UnderRimit;8;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-2800,432;Inherit;True;Property;_MOS;MOS;2;0;Create;True;0;0;0;False;0;False;-1;None;b411eadfeb6885a4da0c7527911f1121;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;83;-2432,112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;10;-2096,1248;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;135;-2416,2144;Inherit;False;1205.168;506.2805;Frenel;12;96;31;94;92;126;111;93;45;100;29;28;133;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;128;-2448,512;Inherit;False;smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2112,1184;Inherit;False;Property;_Thickness;Thickness;13;0;Create;True;0;0;0;False;0;False;1;0.46;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-2144,2448;Inherit;False;128;smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2208,2544;Inherit;False;Property;_ClearReflection;ClearReflection;17;0;Create;True;0;0;0;False;0;False;0.5;0.519;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2208,2336;Inherit;False;Property;_ClearReflectionBias;ClearReflectionBias;18;0;Create;True;0;0;0;False;0;False;0.015;0.152;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-2000,1360;Inherit;False;Property;_ThicknessMin;ThicknessMin;14;0;Create;True;0;0;0;False;0;False;0.2;0.58;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-2288,112;Float;False;GSAA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;11;-1936,1248;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;100;-2096,2192;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1904,2336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-2656,1824;Inherit;False;Property;_ClearNormalScale;ClearNormalScale;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-1904,2448;Inherit;False;86;GSAA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-1904,2544;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1792,1184;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2784,624;Inherit;False;Property;_AO;AO;5;0;Create;True;0;0;0;False;0;False;1;0.653;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-1968,1456;Inherit;True;Property;_ThicknessMap;ThicknessMap;12;0;Create;True;0;0;0;False;0;False;-1;None;33f3cb12274e7cf4392068eaa9b090a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;48;-2448,592;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1616,1360;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-2448,432;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-1616,1184;Inherit;False;Property;_ClearClolr;ClearClolr;9;0;Create;True;0;0;0;False;0;False;0.9,0.9,0.9,0;0.3277855,0.5471698,0.4561047,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;134;-1850.918,-134.8446;Inherit;False;946.1259;960.9878;Base;13;21;51;89;87;16;137;138;18;140;139;35;19;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMinOpNode;94;-1696,2336;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;126;-1920,2192;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2064,1856;Inherit;False;Property;_ClearSmoothness;ClearSmoothness;16;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;92;-1696,2544;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;-2032,1936;Inherit;False;128;smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;142;-1696,976;Inherit;True;Property;_ClearColorTexture;ClearColorTexture;8;1;[Header];Create;True;1;Clear Color Paint;0;0;False;0;False;-1;None;6fd00d3c15c825c46a8a8db4bc612f96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;-1648,1456;Inherit;False;Property;_ThicknessMax;ThicknessMax;15;0;Create;True;0;0;0;False;0;False;4;2.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-2416,1776;Inherit;True;Property;_ClearNormal;ClearNormal;10;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;bfa7a22a2e2826e48bc3f5b430d43a79;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.8;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;90;-1824,1952;Inherit;False;86;GSAA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;31;-1536,2288;Inherit;False;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1792,1856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1728,560;Inherit;False;Property;_BaseSmoothness;BaseSmoothness;4;0;Create;True;0;0;0;False;0;False;0.7;0.433;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;43;-1456,1392;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-2288,592;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1344,1088;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1632,640;Inherit;False;86;GSAA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-1800.918,-84.84464;Inherit;True;Property;_BaseAlbedo;BaseAlbedo;0;1;[Header];Create;True;1;Base Paint;0;0;False;0;False;-1;None;6fd00d3c15c825c46a8a8db4bc612f96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1728,400;Inherit;False;Property;_BaseMetallic;BaseMetallic;3;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;-1799.355,287.1618;Inherit;False;Property;_BaseNormalScale;BaseNormalScale;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;-1800.918,107.1553;Inherit;False;Property;_BaseColor;BaseColor;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.9245283,0.9142752,0.8852795,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;138;-1632,480;Inherit;False;127;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1456,736;Inherit;False;49;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;17;-1168,1088;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1416.918,91.15536;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;139;-1568,192;Inherit;True;Property;_BaseNormal;BaseNormal;6;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;bfa7a22a2e2826e48bc3f5b430d43a79;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.8;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;96;-1360,2288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1680,2032;Inherit;False;49;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;91;-1632,1888;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;89;-1408,592;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-1408,432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-1024,1088;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomStandardSurface;21;-1184,352;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;33;-1040,1904;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;32;-1424,1776;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-624,992;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1040,1984;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;98;-321.4341,887.9056;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-416,992;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;38;-240,992;Inherit;False;Property;_BaseColorOnly;BaseColorOnly;19;0;Create;True;0;0;0;False;1;Header(Debug);False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;48,768;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;uniuni/CandyPaint;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;77;0;88;0
WireConnection;76;0;88;0
WireConnection;78;0;77;0
WireConnection;78;1;77;0
WireConnection;79;0;76;0
WireConnection;79;1;76;0
WireConnection;80;0;79;0
WireConnection;80;1;78;0
WireConnection;81;0;80;0
WireConnection;132;0;7;0
WireConnection;8;0;132;0
WireConnection;8;1;26;0
WireConnection;82;0;81;0
WireConnection;83;0;82;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;128;0;44;4
WireConnection;86;0;83;0
WireConnection;11;0;24;0
WireConnection;11;1;10;0
WireConnection;45;0;28;0
WireConnection;45;1;133;0
WireConnection;111;0;29;0
WireConnection;111;1;133;0
WireConnection;23;1;11;0
WireConnection;23;2;97;0
WireConnection;48;1;44;2
WireConnection;48;2;47;0
WireConnection;40;0;23;0
WireConnection;40;1;39;1
WireConnection;127;0;44;1
WireConnection;94;0;45;0
WireConnection;94;1;93;0
WireConnection;126;0;100;0
WireConnection;92;0;111;0
WireConnection;92;1;93;0
WireConnection;34;5;144;0
WireConnection;31;0;34;0
WireConnection;31;4;126;0
WireConnection;31;1;94;0
WireConnection;31;2;92;0
WireConnection;46;0;30;0
WireConnection;46;1;130;0
WireConnection;43;0;40;0
WireConnection;43;1;42;0
WireConnection;49;0;48;0
WireConnection;141;0;142;0
WireConnection;141;1;14;0
WireConnection;17;0;141;0
WireConnection;17;1;43;0
WireConnection;35;0;19;0
WireConnection;35;1;36;0
WireConnection;139;5;140;0
WireConnection;96;0;31;0
WireConnection;91;0;46;0
WireConnection;91;1;90;0
WireConnection;89;0;16;0
WireConnection;89;1;87;0
WireConnection;137;0;18;0
WireConnection;137;1;138;0
WireConnection;20;0;17;0
WireConnection;21;0;35;0
WireConnection;21;1;139;0
WireConnection;21;3;137;0
WireConnection;21;4;89;0
WireConnection;21;5;51;0
WireConnection;33;0;96;0
WireConnection;32;0;34;0
WireConnection;32;1;91;0
WireConnection;32;2;50;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;22;2;33;0
WireConnection;27;0;32;0
WireConnection;27;1;96;0
WireConnection;27;2;50;0
WireConnection;98;0;21;0
WireConnection;12;0;22;0
WireConnection;12;1;27;0
WireConnection;38;0;12;0
WireConnection;38;1;98;0
WireConnection;0;13;38;0
ASEEND*/
//CHKSM=E2B7D1CF661632B185A10A8BF2F7BFAFFD5F4ECE