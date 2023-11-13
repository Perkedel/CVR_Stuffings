// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Furality/Luma Avatar Shader - Cutout (Specular)"
{
	Properties
	{
		[Header(Main)]_MainTex("Main Texture", 2D) = "white" {}
		_Color("     Color", Color) = (1,1,1,1)
		[Header(Normals)][Normal][SingleLineTexture]_Normal("", 2D) = "bump" {}
		_NormalScale("     Normal Scale", Range( 0 , 1)) = 1
		_NormalTiling("     Normal Tiling", Vector) = (1,1,0,0)
		[Header(Specular)][NoScaleOffset][SingleLineTexture]_Specular("", 2D) = "black" {}
		_Smoothness("     Smoothness", Range( 0 , 1)) = 0
		[HDR]_SpecularColor("     Specular Color", Color) = (1,1,1,1)
		[Header(Emission)][SingleLineTexture]_Emission("", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_Mask("Mask", 2D) = "white" {}
		[HDR]_EmissionTint("     Emission Tint", Color) = (1,1,1,0)
		_MinEmission("     Min Emission", Range( 0 , 3)) = 0
		_EmissionTiling("     Emission Tiling", Vector) = (1,1,0,0)
		_EmissionPanDirection("     Emission Pan Direction", Vector) = (0,0,0,0)
		[Header(Ambient Occlusion)][NoScaleOffset][SingleLineTexture]_Occlusion("", 2D) = "white" {}
		_OcclusionPower("     Occlusion Power", Range( 0 , 1)) = 1
		[Header(Misc)]_MaskClipValue("     Mask Clip Value", Float) = 0.5
		[Enum(Off,0,Front,1,Back,2)]_Culling("     Culling", Float) = 2
		[Enum(Lambert,0,HalfLambert,1,Toon,2)]_ShadingStyle("     Shading Style", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull [_Culling]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
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
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
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

		uniform float _MaskClipValue;
		uniform float _Culling;
		uniform sampler2D _Emission;
		uniform float2 _EmissionPanDirection;
		uniform float2 _EmissionTiling;
		uniform sampler2D _Mask;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _EmissionTint;
		uniform sampler2D _Stored;
		uniform float _MinEmission;
		uniform sampler2D _Normal;
		uniform float2 _NormalTiling;
		uniform float _NormalScale;
		uniform int _ShadingStyle;
		uniform sampler2D _Occlusion;
		uniform float _OcclusionPower;
		uniform float4 _Color;
		uniform sampler2D _Specular;
		float4 _Specular_TexelSize;
		uniform float _Smoothness;
		uniform float4 _SpecularColor;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float3 ReflectionProbeSample361( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode46 = tex2D( _MainTex, uv_MainTex );
			float2 uv_TexCoord57 = i.uv_texcoord * _NormalTiling;
			int ShadingStyle43 = _ShadingStyle;
			float lerpResult150 = lerp( _NormalScale , ( _NormalScale * 0.7 ) , (float)saturate( ( ShadingStyle43 - 1 ) ));
			float3 tex2DNode34 = UnpackScaleNormal( tex2D( _Normal, uv_TexCoord57 ), lerpResult150 );
			float3 appendResult424 = (float3(tex2DNode34.xy , ( tex2DNode34.b * i.ASEVFace )));
			float3 Normal49 = appendResult424;
			UnityGI gi47 = gi;
			float3 diffNorm47 = WorldNormalVector( i , Normal49 );
			gi47 = UnityGI_Base( data, 1, diffNorm47 );
			float3 indirectDiffuse47 = gi47.indirect.diffuse + diffNorm47 * 0.0001;
			float3 newWorldNormal368 = (WorldNormalVector( i , Normal49 ));
			float3 uvw361 = newWorldNormal368;
			float3 localReflectionProbeSample361 = ReflectionProbeSample361( uvw361 );
			float3 CustomProbe369 = localReflectionProbeSample361;
			float2 break357 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult219 = (float2(break357.x , break357.y));
			float2 SquaresOffset287 = ( float2( -995,-525 ) * appendResult219 );
			float2 break354 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult236 = (float2(break354.x , break354.y));
			float2 FirstOffset292 = float2( 0.1,-0.5 );
			float2 _Vector4 = float2(-0.72,-0.01);
			float RPtoLP245 = min( tex2Dlod( _Stored, float4( ( ( ( ( SquaresOffset287 + i.uv_texcoord ) * appendResult236 ) - FirstOffset292 ) - _Vector4 ), 0, 0.0) ).r , 1.0 );
			float3 lerpResult233 = lerp( indirectDiffuse47 , ( indirectDiffuse47 + CustomProbe369 ) , RPtoLP245);
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
			float dotResult2 = dot( (WorldNormalVector( i , appendResult424 )) , ase_worldlightDir );
			float Lambert22 = saturate( dotResult2 );
			float HalfLambert21 = saturate( (dotResult2*0.5 + 0.5) );
			float lerpResult8 = lerp( Lambert22 , HalfLambert21 , (float)saturate( _ShadingStyle ));
			float2 _Vector1 = float2(0,0.05362779);
			float smoothstepResult16 = smoothstep( _Vector1.x , _Vector1.y , ( dotResult2 * 0.5 ));
			float ToonShading20 = saturate( ( smoothstepResult16 + 0.5 ) );
			float lerpResult13 = lerp( lerpResult8 , ToonShading20 , (float)saturate( ( _ShadingStyle - 1 ) ));
			float BaseLighting41 = lerpResult13;
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch168 = ase_lightAtten;
			#else
				float staticSwitch168 = 1.0;
			#endif
			float3 temp_output_53_0 = ( ase_lightColor.rgb * BaseLighting41 * staticSwitch168 );
			float saferPower87 = max( tex2D( _Occlusion, uv_MainTex ).g , 0.0001 );
			float lerpResult90 = lerp( pow( saferPower87 , _OcclusionPower ) , 1.0 , BaseLighting41);
			float Occlusion96 = lerpResult90;
			float3 LightingColored55 = ( ( lerpResult233 + temp_output_53_0 ) * Occlusion96 );
			float4 Albedo59 = ( _Color * tex2DNode46 );
			float3 indirectNormal60 = WorldNormalVector( i , Normal49 );
			float4 tex2DNode65 = tex2D( _Specular, uv_MainTex );
			float SpecularExists415 = step( max( _Specular_TexelSize.z , _Specular_TexelSize.w ) , 1.0 );
			float temp_output_200_0 = ( ( tex2DNode65.a + SpecularExists415 ) * _Smoothness );
			float4 tex2DNode70 = tex2D( _Occlusion, uv_MainTex );
			Unity_GlossyEnvironmentData g60 = UnityGlossyEnvironmentSetup( temp_output_200_0, data.worldViewDir, indirectNormal60, float3(0,0,0));
			float3 indirectSpecular60 = UnityGI_IndirectSpecular( data, tex2DNode70.g, indirectNormal60, g60 );
			float3 temp_output_183_0 = (_SpecularColor).rgb;
			float3 temp_output_260_0 = ( ( SpecularExists415 + (tex2D( _Specular, uv_MainTex )).rgb ) * temp_output_183_0 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV75 = dot( (WorldNormalVector( i , Normal49 )), ase_worldViewDir );
			float fresnelNode75 = ( saturate( ( 0.25 + temp_output_200_0 ) ) + temp_output_200_0 * pow( 1.0 - fresnelNdotV75, 5.0 ) );
			float3 IndirectLighting79 = ( ( indirectSpecular60 * temp_output_260_0 ) * saturate( fresnelNode75 ) );
			c.rgb = ( ( float4( LightingColored55 , 0.0 ) * Albedo59 ) + float4( IndirectLighting79 , 0.0 ) ).rgb;
			c.a = 1;
			clip( tex2DNode46.a - _MaskClipValue );
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
			float2 uv_TexCoord272 = i.uv_texcoord * _EmissionTiling;
			float2 panner271 = ( 1.0 * _Time.y * _EmissionPanDirection + uv_TexCoord272);
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode373 = tex2D( _Mask, uv_MainTex );
			float temp_output_375_0 = max( max( tex2DNode373.r , tex2DNode373.g ) , tex2DNode373.b );
			float3 hsvTorgb401 = RGBToHSV( tex2D( _MainTex, float2( 0.5,0.5 ) ).rgb );
			float temp_output_228_0 = ceil( fmod( ( saturate( hsvTorgb401.x ) * 255.0 ) , 4.0 ) );
			float2 lerpResult207 = lerp( float2( 0.955,0.022 ) , float2( 0.955,0.008 ) , temp_output_228_0);
			float temp_output_214_0 = ( temp_output_228_0 - 1.0 );
			float2 lerpResult209 = lerp( lerpResult207 , float2( 0.964,0.022 ) , saturate( temp_output_214_0 ));
			float2 lerpResult211 = lerp( lerpResult209 , float2( 0.964,0.008 ) , saturate( ( temp_output_214_0 - 1.0 ) ));
			float2 FirstOffset292 = float2( 0.1,-0.5 );
			float3 hsvTorgb277 = RGBToHSV( tex2Dlod( _Stored, float4( ( lerpResult211 - FirstOffset292 ), 0, 0.0) ).rgb );
			float3 hsvTorgb278 = HSVToRGB( float3(hsvTorgb277.x,hsvTorgb277.y,(_MinEmission + (hsvTorgb277.z - 0.0) * (( _MinEmission + 2.0 ) - _MinEmission) / (1.0 - 0.0))) );
			float2 break357 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult219 = (float2(break357.x , break357.y));
			float2 SquaresOffset287 = ( float2( -995,-525 ) * appendResult219 );
			float2 break351 = ( float2( 1,1 ) / float2( 1920,1080 ) );
			float2 appendResult317 = (float2(break351.x , break351.y));
			float2 _Vector11 = float2(-0.73,-0.01);
			float4 tex2DNode324 = tex2Dlod( _Stored, float4( ( ( ( ( SquaresOffset287 + i.uv_texcoord ) * appendResult317 ) - FirstOffset292 ) - _Vector11 ), 0, 0.0) );
			float IsActive326 = ( min( tex2DNode324.r , 1.0 ) * step( max( tex2DNode324.g , tex2DNode324.b ) , 0.0 ) );
			float3 lerpResult345 = lerp( float3( 1,1,1 ) , hsvTorgb278 , IsActive326);
			float4 Emission252 = ( ( tex2D( _Emission, panner271 ) * temp_output_375_0 * _EmissionTint ) * float4( lerpResult345 , 0.0 ) );
			o.Emission = Emission252.rgb;
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
/*ASEBEGIN
Version=18906
257.3333;536;1834;620;866.1898;2245.996;1.652532;True;False
Node;AmplifyShaderEditor.CommentaryNode;40;-1413.562,162.0834;Inherit;False;1356.281;529.0198;Shading Style Selector;13;41;13;26;25;27;8;15;12;24;14;23;43;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;11;-1364.56,439.0307;Inherit;False;Property;_ShadingStyle;     Shading Style;31;1;[Enum];Create;True;0;3;Lambert;0;HalfLambert;1;Toon;2;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1164.57,549.0568;Inherit;False;ShadingStyle;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;28;-4081.783,143.6109;Inherit;False;2638.98;576.8051;Calculate Shading;28;157;20;49;154;22;21;16;36;9;4;153;6;2;3;1;34;150;33;57;149;152;151;35;147;158;160;195;394;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-3955.8,606.1334;Inherit;False;43;ShadingStyle;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;32;-4439.199,773.8618;Inherit;False;769.4817;1684.206;Texture Assignments;15;105;104;38;39;68;67;63;62;31;30;108;109;411;412;413;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-4010.69,461.7375;Inherit;False;Property;_NormalScale;     Normal Scale;4;0;Create;True;0;0;0;False;0;False;1;0.074;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3675.425,610.7297;Inherit;False;2;0;INT;0;False;1;INT;1;False;1;INT;0
Node;AmplifyShaderEditor.TexturePropertyNode;30;-4351.033,823.8618;Inherit;True;Property;_Normal;;3;3;[Header];[Normal];[SingleLineTexture];Create;False;1;Normals;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-4068.598,823.0428;Inherit;False;NormalTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-3673.125,521.1005;Inherit;False;2;2;0;FLOAT;0.2;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;394;-3985.559,285.899;Inherit;False;Property;_NormalTiling;     Normal Tiling;5;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;152;-3526.042,608.4314;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.LerpOp;150;-3381.255,467.0936;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;39;-4355.687,1066.58;Inherit;True;Property;_MainTex;Main Texture;1;1;[Header];Create;False;1;Main;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-3567.038,309.8113;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;33;-3457.016,217.4499;Inherit;False;31;NormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-4077.098,1065.58;Inherit;False;MainTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;355;-373.2663,-459.8121;Inherit;False;Constant;_Vector17;Vector 17;27;0;Create;True;0;0;0;False;0;False;1920,1080;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;34;-3214.696,233.4085;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FaceVariableNode;426;-3152.016,27.75046;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;425;-2927.487,-88.57193;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;-2685.116,-736.155;Inherit;False;38;MainTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;356;-104.2663,-476.8121;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;400;-2681.686,-661.8754;Inherit;False;Constant;_Vector19;Vector 19;32;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;399;-2428.686,-701.8754;Inherit;True;Property;_TextureSample10;Texture Sample 10;32;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;357;20.73367,-478.8121;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;424;-2781.409,-150.791;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RGBToHSVNode;401;-2109.686,-683.8754;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;219;251.1964,-619.0646;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;286;-515.3741,-755.3838;Inherit;False;Constant;_Vector6;Vector 6;20;0;Create;True;0;0;0;False;0;False;-995,-525;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1;-2838.308,443.4783;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;3;-2831.448,305.1675;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;285;-274.7787,-691.2153;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;2;-2534.049,338.3674;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;403;-1901.686,-664.8754;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;352;1669.281,-452.1137;Inherit;False;Constant;_Vector16;Vector 16;27;0;Create;True;0;0;0;False;0;False;1920,1080;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;6;-2117.587,292.4931;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;353;1938.281,-469.1137;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-2274.977,415.1022;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;405;-1766.808,-655.7896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;255;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;36;-2475.088,542.9016;Inherit;False;Constant;_Vector1;Vector 1;1;1;[RemapSliders];Create;True;0;0;0;False;0;False;0,0.05362779;0,0.05362779;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;348;2302.873,-1143.854;Inherit;False;Constant;_Vector15;Vector 15;27;0;Create;True;0;0;0;False;0;False;1920,1080;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;287;-46.55648,-757.8878;Inherit;False;SquaresOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;2086.127,-985.3851;Inherit;False;287;SquaresOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;354;2063.281,-471.1137;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;4;-1890.086,295.093;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;350;2571.873,-1160.854;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;280;-426.0281,-1034.921;Inherit;False;Constant;_Vector5;Vector 5;20;0;Create;True;0;0;0;False;0;False;0.1,-0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;62;-4366.274,1317.518;Inherit;True;Property;_Specular;;6;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;False;1;Specular;0;0;False;0;False;None;36689d4181ca3504fb09048e23c695a0;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;238;2064.747,-868.8316;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FmodOpNode;407;-1616.783,-658.8181;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;16;-2101.015,412.1769;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-2090.089,200.9931;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;351;2696.873,-1162.854;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;292;-165.7366,-1074.832;Inherit;False;FirstOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-1726.351,193.6109;Inherit;False;Lambert;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;236;2202.796,-662.1586;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;154;-1925.047,414.4625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;289;2397.343,-861.157;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexelSizeNode;411;-4122.435,1391.271;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;406;-1501.783,-658.8181;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-1728.952,288.5108;Inherit;False;HalfLambert;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;315;2708.105,-1629.973;Inherit;False;287;SquaresOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;314;2686.725,-1513.419;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;24;-1186.474,290.083;Inherit;False;21;HalfLambert;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-2829.642,232.4631;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;12;-1141.819,368.3051;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;2440.286,-646.3173;Inherit;False;292;FirstOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;-1137.406,444.8112;Inherit;False;2;0;INT;0;False;1;INT;1;False;1;INT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;413;-3931.952,1462.45;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;2521.283,-767.7622;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;157;-1804.986,413.7977;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;228;-1370.6,-737.9302;Inherit;False;True;False;False;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1168.275,212.0834;Inherit;False;22;Lambert;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;317;2824.774,-1306.746;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;316;3019.321,-1505.745;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;15;-880.2056,421.5112;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;205;-1325.349,-1143.131;Inherit;False;Constant;_Zone1;Zone 1;16;0;Create;True;0;0;0;False;0;False;0.955,0.022;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;214;-1084.644,-800.2482;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;237.9639,1329.914;Inherit;False;49;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;81;-2208.291,765.8812;Inherit;False;2042.179;619.1633;Indirect Specular;26;69;70;73;71;77;64;76;72;61;75;60;78;79;65;199;200;202;254;258;253;262;265;264;310;417;420;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;237;2679.005,-622.9371;Inherit;False;Constant;_Vector4;Vector 4;19;0;Create;True;0;0;0;False;0;False;-0.72,-0.01;-0.72,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StepOpNode;412;-3801.718,1461.272;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-1655.682,407.8647;Inherit;False;ToonShading;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;8;-903.009,246.8654;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;-4076.274,1312.518;Inherit;False;SpecularTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;318;3062.264,-1290.905;Inherit;False;292;FirstOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;208;-1322.107,-1014.429;Inherit;False;Constant;_Zone2;Zone 2;16;0;Create;True;0;0;0;False;0;False;0.955,0.008;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;67;-4363.791,1578.533;Inherit;True;Property;_Occlusion;;17;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;False;1;Ambient Occlusion;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleSubtractOpNode;241;2693.424,-768.3057;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;319;3143.261,-1412.35;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;216;-854.6437,-801.2482;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;294;2963.626,-752.1365;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;97;-3565.305,1182.074;Inherit;False;1310.964;435.4747;Occlusion;8;86;85;95;94;87;90;96;257;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;26;-661.6743,274.0831;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;258;-2188.825,1264.206;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-4061.67,1575.101;Inherit;False;OcclusionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-2158.291,897.9981;Inherit;False;63;SpecularTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.LerpOp;207;-1071.107,-1143.428;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;210;-1082.107,-1006.429;Inherit;False;Constant;_Zone3;Zone 3;16;0;Create;True;0;0;0;False;0;False;0.964,0.022;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;321;3315.402,-1412.893;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;368;411.28,1334.101;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;25;-748.3749,335.5829;Inherit;False;20;ToonShading;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;320;3300.983,-1267.525;Inherit;False;Constant;_Vector11;Vector 11;19;0;Create;True;0;0;0;False;0;False;-0.73,-0.01;-0.73,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;27;-586.2744,417.0829;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;415;-3685.301,1456.597;Inherit;False;SpecularExists;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;215;-917.6437,-872.2482;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;257;-3548.14,1316.408;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;56;-3639.72,770.6382;Inherit;False;1406.378;400.7708;Light Colors;18;55;99;52;98;175;47;48;174;53;54;168;50;167;169;233;249;371;248;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;417;-2191.094,992.343;Inherit;False;415;SpecularExists;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-491.8059,295.8116;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;3342.504,-601.5397;Inherit;False;Constant;_Float3;Float 3;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;212;-820.6437,-1009.248;Inherit;False;Constant;_Zone4;Zone 4;16;0;Create;True;0;0;0;False;0;False;0.964,0.008;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;209;-854.1074,-1142.428;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-3515.305,1237.22;Inherit;False;68;OcclusionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;65;-1901.53,915.0768;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;361;1072.922,1320.288;Inherit;False;half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5)@ //('cubemap', 'sample coordinate', 'map-map level')$         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR)@$         return half4(skyColor, 1.0)@;3;Create;1;True;uvw;FLOAT3;0,0,0;In;;Inherit;False;ReflectionProbeSample;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;322;3585.604,-1396.724;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;217;-684.6437,-875.2482;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;242;3201.045,-795.1876;Inherit;True;Property;_TextureSample8;Texture Sample 8;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;204;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-291.8362,290.2045;Inherit;False;BaseLighting;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;211;-573.6232,-1143.828;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-3625.185,826.1757;Inherit;False;49;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;369;1300.941,1314.355;Inherit;False;CustomProbe;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMinOpNode;244;3596.504,-753.5397;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-3269.698,1422.29;Inherit;False;Property;_OcclusionPower;     Occlusion Power;18;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;85;-3281.814,1232.074;Inherit;True;Property;_TextureSample3;Texture Sample 3;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;202;-2169.137,1073.205;Inherit;False;Property;_Smoothness;     Smoothness;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;420;-1600.749,1035.548;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;324;3823.023,-1439.775;Inherit;True;Property;_TextureSample6;Texture Sample 6;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;204;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;87;-2954.817,1238.208;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;378;-498.936,-1774.456;Inherit;False;38;MainTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;197;-2191.732,1692.877;Inherit;False;2052.868;519.6117;Blinn-Phong;19;163;162;164;165;172;177;178;179;176;170;171;181;183;182;184;173;198;266;267;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;371;-3630.295,900.783;Inherit;False;369;CustomProbe;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-3201.074,1502.549;Inherit;False;41;BaseLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;-1459.678,1063.596;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;47;-3432.378,827.1741;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;245;3741.298,-757.7164;Inherit;False;RPtoLP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;256;-1803.925,1435.653;Inherit;True;Property;_TextureSample9;Texture Sample 9;18;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;323;4159.395,-1430.718;Inherit;False;Constant;_Float5;Float 5;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-3535.394,1015.001;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;167;-3569.826,1098.617;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;332;4164.531,-1339.602;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;290;66.14336,-1186.907;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;249;-3185.89,817.8441;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;377;-220.736,-1736.756;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;397;-527.6939,-1972.679;Inherit;False;Property;_EmissionTiling;     Emission Tiling;15;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;248;-3619.684,963.6495;Inherit;False;245;RPtoLP;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;90;-2773.791,1238.588;Inherit;True;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;423;-1482.845,1546.591;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;181;-1296.623,2007.089;Inherit;False;Property;_SpecularColor;     Specular Color;9;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;2.118547,1.020452,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;264;-1216.167,1113.943;Inherit;False;2;2;0;FLOAT;0.25;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;325;4338.731,-1449.585;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;104;-4368.32,1875.739;Inherit;True;Property;_Emission;;11;2;[Header];[SingleLineTexture];Create;False;1;Emission;0;0;False;0;False;None;36689d4181ca3504fb09048e23c695a0;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;54;-3296.276,1003.279;Inherit;False;41;BaseLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;336;4299.974,-1339.443;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-1256.625,958.0158;Inherit;False;49;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;275;350.4601,-986.7307;Inherit;False;Property;_MinEmission;     Min Emission;14;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;204;309.1395,-1181.25;Inherit;True;Global;_Stored;_Stored;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;168;-3357.092,1069.107;Inherit;False;Property;_Keyword0;Keyword 0;12;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;False;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;50;-3225.719,898.5659;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;69;-2152.369,1154.044;Inherit;False;68;OcclusionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;273;-224.3388,-1857.64;Inherit;False;Property;_EmissionPanDirection;     Emission Pan Direction;16;0;Create;True;0;0;0;False;0;False;0,0;0,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;373;41.56404,-1777.056;Inherit;True;Property;_Mask;Mask;12;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-3020.854,910.9594;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;265;-1051.578,1139.856;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;4598.335,-1407.858;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;276;666.6972,-936.9727;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;96;-2503.008,1232.999;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;-1924.552,1194.081;Inherit;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;272;-234.4059,-1987.008;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;233;-3046.581,789.7767;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1821.306,819.3297;Inherit;False;49;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-4064.32,1869.739;Inherit;False;PatternTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RGBToHSVNode;277;642.3716,-1273.114;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;76;-1075.58,961.4534;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;183;-1056.847,1999.143;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;422;-1478.744,1420.91;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-65.90641,-2.234868;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;98;-2861.96,936.3388;Inherit;False;96;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;374;372.064,-1756.256;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;60;-1241.306,828.3297;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;271;82.59409,-1959.008;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;326;4789.76,-1410.302;Inherit;False;IsActive;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-1230.496,1430.764;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;75;-859.0143,959.1617;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.025;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-479.2581,-2086.416;Inherit;False;105;PatternTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-2851.095,812.9725;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;274;821.4985,-1063.027;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-30.652,-84.00507;Inherit;False;38;MainTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;311;524.9701,-1541.638;Inherit;False;Property;_EmissionTint;     Emission Tint;13;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HSVToRGBNode;278;1094.613,-1263.162;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMaxOpNode;375;499.4639,-1749.756;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;310;-581.972,974.4172;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;107;361.2386,-2018.065;Inherit;True;Property;_TextureSample4;Texture Sample 4;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;346;1122.534,-1123.536;Inherit;False;326;IsActive;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-2694.687,821.0835;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;269;231.4459,-251.1487;Inherit;False;Property;_Color;     Color;2;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;171.3479,-85.00507;Inherit;True;Property;;;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-839.2977,845.886;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;508.4044,-97.98795;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;345;1529.786,-1317.66;Inherit;False;3;0;FLOAT3;1,1,1;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-2470.091,820.6382;Inherit;False;LightingColored;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-593.1759,823.9511;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;1380.514,-1997.264;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;659.8027,-145.0188;Inherit;False;55;LightingColored;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;1763.133,-1410.735;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;-422.7778,815.8812;Inherit;False;IndirectLighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;668.0807,-75.22603;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;661.1178,9.358015;Inherit;False;79;IndirectLighting;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;389;2794.719,-285.269;Inherit;False;250.3334;266;DO NOT DELETE;2;388;396;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;908.619,-91.91428;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;1940.8,-1418.307;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;117;347.9789,566.8648;Inherit;False;Property;_Vector0;Vector 0;22;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMaxOpNode;376;619.064,-1728.956;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;220;196.2129,-451.3954;Inherit;False;Constant;_Vector3;Vector 3;18;0;Create;True;0;0;0;False;0;False;7.5,7.5;7.5,7.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;253;-1448.197,1261.884;Inherit;False;59;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;227;-1727.739,-870.6405;Inherit;False;226;Zone;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;163;-2117.5,1742.877;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;363;798.9139,306.5728;Inherit;False;Constant;_Float6;Float 6;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;306;2796.03,-484.0164;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;297;1419.764,60.06665;Inherit;False;226;Zone;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;113;287.0922,486.675;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;328;3130.172,-1098.828;Inherit;False;Property;_Vector12;Vector 12;28;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;198;-1581.867,2087.403;Inherit;False;199;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-2806.447,1026.636;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;304;716.9474,-551.7731;Inherit;False;Property;_Vector8;Vector 8;25;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;224;-55.09199,-874.0628;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;329;3379.008,-1133.604;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;222;1191.127,-848.2005;Inherit;True;Property;_TextureSample7;Texture Sample 7;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;204;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;393;867.8572,1043.279;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;359;1666.763,-804.2675;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;176;-1179.045,1816.52;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;307;2508.194,-454.2403;Inherit;False;Property;_Vector9;Vector 9;27;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;179;-835.1423,1827.289;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;-444.7029,-911.1397;Inherit;False;281;Texel;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;364;1102.392,311.2692;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;172;-1422.197,1818.659;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;71;-1598.324,1288.455;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;372;459.9094,79.39758;Inherit;False;Constant;_Float7;Float 7;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;110;1132.72,499.8112;Inherit;True;Property;_TextureSample5;Texture Sample 5;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;390;582.8573,1046.279;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LightAttenuation;158;-2606.479,246.9866;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;396;2829.118,-140.9778;Inherit;False;Property;_MaskClipValue;     Mask Clip Value;29;1;[Header];Create;True;1;Misc;0;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;112;19.09221,410.675;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;298;755.3627,-694.3289;Inherit;False;Constant;_Vector7;Vector 7;21;0;Create;True;0;0;0;False;0;False;-0.71,-0.01;-0.71,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;162;-2141.732,1891.776;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;281;484.1074,-610.9201;Inherit;False;Texel;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-995.1425,1891.289;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;128;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;226;1806.848,-822.0498;Inherit;False;Zone;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;303;987.9474,-630.7731;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;184;-689.4095,2095.504;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;388;2844.719,-235.2691;Inherit;False;Property;_Culling;     Culling;30;1;[Enum];Create;True;0;3;Off;0;Front;1;Back;2;0;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;1332.586,-654.5529;Inherit;False;Constant;_Float2;Float 2;18;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;246;1297.491,-265.1962;Inherit;False;252;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;230;1577.781,-658.1326;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;1088.698,-77.83611;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;284;370.0261,-848.9885;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;283;-232.2555,-983.243;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;392;713.8572,1122.279;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;98.89789,222.4195;Inherit;False;Constant;_Float1;Float 1;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;296;536.8721,-695.5957;Inherit;False;292;FirstOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-4074.497,2193.223;Inherit;False;VideoTestTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexelSizeNode;313;2542.057,-1335.797;Inherit;False;204;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;302;904.9474,-503.7731;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;330;3117.878,-502.2151;Inherit;False;Property;_Vector13;Vector 13;21;0;Create;True;0;0;0;False;0;False;-0.709,-0.01;-0.72,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMinOpNode;160;-2369.718,187.6421;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;254;-1032.275,1225.23;Inherit;False;3;0;FLOAT3;1,1,1;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;262;-1269.137,1235.016;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-574.3162,2115.118;Inherit;False;Constant;_Float4;Float 4;18;0;Create;True;0;0;0;False;0;False;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;844.291,467.3558;Inherit;False;109;VideoTestTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;295;996.0615,-815.0344;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.7,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-1795.214,1621.726;Inherit;False;Property;_Metalness;     Metalness;7;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-3023.508,1076.069;Inherit;False;173;Specular;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;309;1137.073,-460.678;Inherit;False;Property;_Vector10;Vector 10;26;0;Create;True;0;0;0;False;0;False;-0.7,0;-0.7,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;114;464.0922,430.675;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;299;1072.687,-565.0485;Inherit;False;SecondOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexelSizeNode;218;-36.72478,-646.3804;Inherit;False;204;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StickyNoteNode;268;1940.19,-290.5078;Inherit;False;832.1149;390.5089;Credits;Credits;1,1,1,1;Shader created by Naito Ookami for the Furality Luma VR Furry Convention.$$Send business inquiries to NaitoOokami on Twitter$$Excuse the mess.  Didn't think anyone would open this;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;173;-387.5298,1906.272;Inherit;False;Specular;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;165;-1701.5,1806.877;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;367;955.9265,24.55839;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;384;1037.852,-1537.661;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.1,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;387;855.3605,-1415.54;Inherit;False;Constant;_Vector18;Vector 18;28;0;Create;True;0;0;0;False;0;False;0.1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;108;-4387.497,2189.223;Inherit;True;Property;_VideoTest;VideoTest;19;0;Create;True;0;0;0;False;0;False;None;5085477d40b8bdc489a8c7a93f30f8bb;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.WorldReflectionVector;362;829.2614,136.4929;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;291;131.6225,-1060.326;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-592.78,1905.644;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;305;2920.097,-584.5109;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.HSVToRGBNode;386;1164.594,-1802.236;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexelSizeNode;235;1920.079,-691.2093;Inherit;False;204;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;170;-1709.69,1891.083;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;199;-1524.378,925.7456;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;164;-1861.5,1806.877;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;581.1422,-436.1028;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-1299.142,1923.289;Float;False;Property;_Shininess;Shininess;10;0;Create;True;0;0;0;False;0;False;0.1;0.5994547;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;116;731.0832,551.0814;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;347;3747.564,-1193.181;Inherit;False;Property;_Vector14;Vector 14;20;0;Create;True;0;0;0;False;0;False;-0.72,-0.01;-0.73,-0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;266;-412.8678,2036.187;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;327;3542.075,-1229.098;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;73;-1485.369,1245.044;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;385;749.5111,-1567.761;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;581.8492,-815.5753;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;223;752.2031,-812.173;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;118;349.0277,712.5345;Inherit;False;Property;_Vector2;Vector 2;23;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMaxOpNode;358;1518.343,-836.9705;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;391;706.8572,1032.279;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;366;948.3356,311.6001;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;72;-1424.369,1158.044;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-2092.475,2030.142;Inherit;False;49;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-1274.644,-885.2482;Inherit;False;Property;_ZoneSelect;ZoneSelect;24;1;[Enum];Create;True;0;4;Zone01;0;Zone02;1;Zone03;2;Zone04;3;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;195;-3848.202,190.902;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1655.68,-327.4505;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Furality/Luma Avatar Shader - Cutout (Specular);False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;388;-1;0;True;396;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;43;0;11;0
WireConnection;151;0;147;0
WireConnection;31;0;30;0
WireConnection;149;0;35;0
WireConnection;152;0;151;0
WireConnection;150;0;35;0
WireConnection;150;1;149;0
WireConnection;150;2;152;0
WireConnection;57;0;394;0
WireConnection;38;0;39;0
WireConnection;34;0;33;0
WireConnection;34;1;57;0
WireConnection;34;5;150;0
WireConnection;425;0;34;3
WireConnection;425;1;426;0
WireConnection;356;1;355;0
WireConnection;399;0;398;0
WireConnection;399;1;400;0
WireConnection;357;0;356;0
WireConnection;424;0;34;0
WireConnection;424;2;425;0
WireConnection;401;0;399;0
WireConnection;219;0;357;0
WireConnection;219;1;357;1
WireConnection;3;0;424;0
WireConnection;285;0;286;0
WireConnection;285;1;219;0
WireConnection;2;0;3;0
WireConnection;2;1;1;0
WireConnection;403;0;401;1
WireConnection;6;0;2;0
WireConnection;353;1;352;0
WireConnection;153;0;2;0
WireConnection;405;0;403;0
WireConnection;287;0;285;0
WireConnection;354;0;353;0
WireConnection;4;0;6;0
WireConnection;350;1;348;0
WireConnection;407;0;405;0
WireConnection;16;0;153;0
WireConnection;16;1;36;1
WireConnection;16;2;36;2
WireConnection;9;0;2;0
WireConnection;351;0;350;0
WireConnection;292;0;280;0
WireConnection;22;0;9;0
WireConnection;236;0;354;0
WireConnection;236;1;354;1
WireConnection;154;0;16;0
WireConnection;289;0;288;0
WireConnection;289;1;238;0
WireConnection;411;0;62;0
WireConnection;406;0;407;0
WireConnection;21;0;4;0
WireConnection;49;0;424;0
WireConnection;12;0;11;0
WireConnection;14;0;11;0
WireConnection;413;0;411;3
WireConnection;413;1;411;4
WireConnection;239;0;289;0
WireConnection;239;1;236;0
WireConnection;157;0;154;0
WireConnection;228;0;406;0
WireConnection;317;0;351;0
WireConnection;317;1;351;1
WireConnection;316;0;315;0
WireConnection;316;1;314;0
WireConnection;15;0;14;0
WireConnection;214;0;228;0
WireConnection;412;0;413;0
WireConnection;20;0;157;0
WireConnection;8;0;23;0
WireConnection;8;1;24;0
WireConnection;8;2;12;0
WireConnection;63;0;62;0
WireConnection;241;0;239;0
WireConnection;241;1;293;0
WireConnection;319;0;316;0
WireConnection;319;1;317;0
WireConnection;216;0;214;0
WireConnection;294;0;241;0
WireConnection;294;1;237;0
WireConnection;26;0;8;0
WireConnection;68;0;67;0
WireConnection;207;0;205;0
WireConnection;207;1;208;0
WireConnection;207;2;228;0
WireConnection;321;0;319;0
WireConnection;321;1;318;0
WireConnection;368;0;370;0
WireConnection;27;0;15;0
WireConnection;415;0;412;0
WireConnection;215;0;214;0
WireConnection;13;0;26;0
WireConnection;13;1;25;0
WireConnection;13;2;27;0
WireConnection;209;0;207;0
WireConnection;209;1;210;0
WireConnection;209;2;215;0
WireConnection;65;0;64;0
WireConnection;65;1;258;0
WireConnection;361;0;368;0
WireConnection;322;0;321;0
WireConnection;322;1;320;0
WireConnection;217;0;216;0
WireConnection;242;1;294;0
WireConnection;41;0;13;0
WireConnection;211;0;209;0
WireConnection;211;1;212;0
WireConnection;211;2;217;0
WireConnection;369;0;361;0
WireConnection;244;0;242;1
WireConnection;244;1;243;0
WireConnection;85;0;86;0
WireConnection;85;1;257;0
WireConnection;420;0;65;4
WireConnection;420;1;417;0
WireConnection;324;1;322;0
WireConnection;87;0;85;2
WireConnection;87;1;95;0
WireConnection;200;0;420;0
WireConnection;200;1;202;0
WireConnection;47;0;48;0
WireConnection;245;0;244;0
WireConnection;256;0;64;0
WireConnection;256;1;258;0
WireConnection;332;0;324;2
WireConnection;332;1;324;3
WireConnection;290;0;211;0
WireConnection;290;1;292;0
WireConnection;249;0;47;0
WireConnection;249;1;371;0
WireConnection;377;2;378;0
WireConnection;90;0;87;0
WireConnection;90;2;94;0
WireConnection;423;0;256;0
WireConnection;264;1;200;0
WireConnection;325;0;324;1
WireConnection;325;1;323;0
WireConnection;336;0;332;0
WireConnection;204;1;290;0
WireConnection;168;1;169;0
WireConnection;168;0;167;0
WireConnection;373;1;377;0
WireConnection;53;0;50;1
WireConnection;53;1;54;0
WireConnection;53;2;168;0
WireConnection;265;0;264;0
WireConnection;334;0;325;0
WireConnection;334;1;336;0
WireConnection;276;0;275;0
WireConnection;96;0;90;0
WireConnection;70;0;69;0
WireConnection;70;1;258;0
WireConnection;272;0;397;0
WireConnection;233;0;47;0
WireConnection;233;1;249;0
WireConnection;233;2;248;0
WireConnection;105;0;104;0
WireConnection;277;0;204;0
WireConnection;76;0;77;0
WireConnection;183;0;181;0
WireConnection;422;0;417;0
WireConnection;422;1;423;0
WireConnection;374;0;373;1
WireConnection;374;1;373;2
WireConnection;60;0;61;0
WireConnection;60;1;200;0
WireConnection;60;2;70;2
WireConnection;271;0;272;0
WireConnection;271;2;273;0
WireConnection;326;0;334;0
WireConnection;260;0;422;0
WireConnection;260;1;183;0
WireConnection;75;0;76;0
WireConnection;75;1;265;0
WireConnection;75;2;200;0
WireConnection;52;0;233;0
WireConnection;52;1;53;0
WireConnection;274;0;277;3
WireConnection;274;3;275;0
WireConnection;274;4;276;0
WireConnection;278;0;277;1
WireConnection;278;1;277;2
WireConnection;278;2;274;0
WireConnection;375;0;374;0
WireConnection;375;1;373;3
WireConnection;310;0;75;0
WireConnection;107;0;106;0
WireConnection;107;1;271;0
WireConnection;99;0;52;0
WireConnection;99;1;98;0
WireConnection;46;0;45;0
WireConnection;46;1;58;0
WireConnection;261;0;60;0
WireConnection;261;1;260;0
WireConnection;270;0;269;0
WireConnection;270;1;46;0
WireConnection;345;1;278;0
WireConnection;345;2;346;0
WireConnection;55;0;99;0
WireConnection;78;0;261;0
WireConnection;78;1;310;0
WireConnection;312;0;107;0
WireConnection;312;1;375;0
WireConnection;312;2;311;0
WireConnection;119;0;312;0
WireConnection;119;1;345;0
WireConnection;79;0;78;0
WireConnection;59;0;270;0
WireConnection;44;0;42;0
WireConnection;44;1;59;0
WireConnection;252;0;119;0
WireConnection;376;0;375;0
WireConnection;376;1;373;4
WireConnection;306;0;236;0
WireConnection;306;1;307;0
WireConnection;113;0;112;2
WireConnection;175;0;54;0
WireConnection;175;1;174;0
WireConnection;175;2;53;0
WireConnection;329;0;317;0
WireConnection;329;1;328;0
WireConnection;222;1;299;0
WireConnection;393;0;391;0
WireConnection;393;1;390;1
WireConnection;393;2;392;0
WireConnection;359;0;358;0
WireConnection;359;1;222;3
WireConnection;176;0;172;0
WireConnection;179;0;176;0
WireConnection;179;1;178;0
WireConnection;364;0;366;0
WireConnection;172;0;165;0
WireConnection;172;1;170;0
WireConnection;71;0;70;1
WireConnection;71;1;70;2
WireConnection;110;0;111;0
WireConnection;110;1;116;0
WireConnection;390;0;368;0
WireConnection;281;0;219;0
WireConnection;178;0;177;0
WireConnection;178;2;198;0
WireConnection;226;0;359;0
WireConnection;303;1;302;0
WireConnection;184;0;181;4
WireConnection;230;1;231;0
WireConnection;74;0;44;0
WireConnection;74;1;80;0
WireConnection;284;0;224;0
WireConnection;284;1;287;0
WireConnection;283;1;282;0
WireConnection;392;0;390;2
WireConnection;109;0;108;0
WireConnection;302;0;304;0
WireConnection;302;1;281;0
WireConnection;160;0;158;0
WireConnection;254;1;262;0
WireConnection;254;2;260;0
WireConnection;262;0;253;0
WireConnection;295;0;223;0
WireConnection;295;1;298;0
WireConnection;114;0;112;1
WireConnection;114;1;113;0
WireConnection;299;0;295;0
WireConnection;173;0;266;0
WireConnection;165;0;164;0
WireConnection;384;0;311;0
WireConnection;384;1;387;1
WireConnection;384;2;387;2
WireConnection;182;0;179;0
WireConnection;182;1;183;0
WireConnection;182;2;184;0
WireConnection;182;3;254;0
WireConnection;305;0;237;0
WireConnection;305;1;306;0
WireConnection;386;0;385;1
WireConnection;386;1;385;2
WireConnection;386;2;384;0
WireConnection;170;0;171;0
WireConnection;199;0;65;4
WireConnection;164;0;163;0
WireConnection;164;1;162;0
WireConnection;221;0;220;0
WireConnection;221;1;219;0
WireConnection;116;0;114;0
WireConnection;116;1;117;0
WireConnection;116;2;118;0
WireConnection;266;0;182;0
WireConnection;266;2;267;0
WireConnection;327;0;320;0
WireConnection;327;1;329;0
WireConnection;73;0;70;3
WireConnection;385;0;311;0
WireConnection;225;0;284;0
WireConnection;225;1;219;0
WireConnection;223;0;225;0
WireConnection;223;1;296;0
WireConnection;358;0;222;1
WireConnection;358;1;222;2
WireConnection;391;0;390;0
WireConnection;366;0;363;0
WireConnection;72;0;71;0
WireConnection;72;1;73;0
WireConnection;0;2;246;0
WireConnection;0;10;46;4
WireConnection;0;13;74;0
ASEEND*/
//CHKSM=20A42B0FCB94FCF0763EDA3928825A1FDEED9A3F