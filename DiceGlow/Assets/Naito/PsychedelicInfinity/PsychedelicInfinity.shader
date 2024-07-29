// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/PsychedelicInfinity"
{
	Properties
	{
		[HideInInspector][NoScaleOffset]_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector][NoScaleOffset]_Rainbow("Rainbow", 2D) = "white" {}
		[HideInInspector][NoScaleOffset][Normal]_DistortMap("Distort Map", 2D) = "bump" {}
		_EffectTint("Effect Tint", Color) = (1,1,1,0)
		[Toggle]_AlignToNormalsHURTSEYESINVR("Align To Normals - HURTS EYES IN VR", Float) = 0
		_CutoffTexture("Cutoff Texture", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.46
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
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

		uniform float4 _EffectTint;
		uniform sampler2D _Rainbow;
		uniform float _AlignToNormalsHURTSEYESINVR;
		uniform sampler2D _DistortMap;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _CutoffTexture;
		uniform float4 _CutoffTexture_ST;
		uniform float _Cutoff = 0.46;


		float MyCustomExpression52_g645( float3 coords )
		{
			float3 normalizedCoords = normalize(coords);
			float latitude = acos(normalizedCoords.y);
			float longitude = atan2(normalizedCoords.z, normalizedCoords.x);
			float2 sphereCoords = float2(longitude, latitude) * float2(0.5/UNITY_PI, 1.0/UNITY_PI);
			sphereCoords = float2(0.5,1.0) - sphereCoords;
			return (sphereCoords + float4(0, 1-unity_StereoEyeIndex,1,0.5).xy) * float4(0, 1-unity_StereoEyeIndex,1,0.5).zw;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_CutoffTexture = i.uv_texcoord * _CutoffTexture_ST.xy + _CutoffTexture_ST.zw;
			float2 uv_TextureSample121_g645 = i.uv_texcoord;
			float4 tex2DNode21_g645 = tex2D( _TextureSample1, uv_TextureSample121_g645 );
			c.rgb = ( 1.0 - tex2DNode21_g645 ).rgb;
			c.a = 1;
			clip( tex2D( _CutoffTexture, uv_CutoffTexture ).a - _Cutoff );
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
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 temp_cast_0 = (0.0).xx;
			float2 temp_cast_1 = (0.0).xx;
			float2 temp_output_42_0_g645 = (temp_cast_0 + (( _SinTime.x * float2( 0,0 ) ) - float2( -1,-1 )) * (temp_cast_1 - temp_cast_0) / (float2( 1,1 ) - float2( -1,-1 )));
			float3 coords52_g645 = ( ase_worldViewDir * float3( -1,-1,-1 ) );
			float localMyCustomExpression52_g645 = MyCustomExpression52_g645( coords52_g645 );
			float temp_output_60_0_g645 = ( 0.0 + localMyCustomExpression52_g645 );
			float2 temp_cast_3 = (temp_output_60_0_g645).xx;
			float2 panner16_g645 = ( 1.0 * _Time.y * float2( 0.04,0.03 ) + temp_cast_3);
			float3 tex2DNode37_g645 = UnpackScaleNormal( tex2D( _DistortMap, panner16_g645 ) ,temp_output_42_0_g645.x );
			float2 temp_cast_4 = (0.0).xx;
			float2 temp_cast_5 = (0.0).xx;
			float2 temp_cast_7 = (temp_output_60_0_g645).xx;
			float2 panner43_g645 = ( ( distance( ase_worldViewDir , reflect( ase_worldViewDir , lerp(tex2DNode37_g645,WorldNormalVector( i , tex2DNode37_g645 ),_AlignToNormalsHURTSEYESINVR) ) ) * ( _SinTime.x * 40.2 ) ) * float2( 0.1,-0.035 ) + temp_cast_7);
			float4 tex2DNode14_g645 = tex2D( _Rainbow, panner43_g645 );
			float2 uv_TextureSample121_g645 = i.uv_texcoord;
			float4 tex2DNode21_g645 = tex2D( _TextureSample1, uv_TextureSample121_g645 );
			o.Emission = ( ( _EffectTint * ( tex2DNode14_g645 * tex2DNode21_g645 ) ) * 2.53 ).rgb;
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
				UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
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
/*ASEBEGIN
Version=15401
154;192;1710;881;1427.238;230.9155;1.201981;True;False
Node;AmplifyShaderEditor.SamplerNode;249;-496.9043,271.5125;Float;True;Property;_CutoffTexture;Cutoff Texture;7;0;Create;True;0;0;False;0;None;ffaa753dbf7ba99458d0290bdca7132a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;255;-805.2134,-25.34711;Float;False;New ShaderFunction;0;;645;68863790ef2a6204e83ae9d8c0f1788d;0;0;3;COLOR;50;COLOR;49;COLOR;51
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Naito/PsychedelicInfinity;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.46;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;8;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;2;255;51
WireConnection;0;10;249;4
WireConnection;0;13;255;49
ASEEND*/
//CHKSM=29D006E6B604936DCFF91DABB43A3207FD6DB046
