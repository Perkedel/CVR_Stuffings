// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/GhostyShader - Final"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.19
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_Clouds("Clouds", 2D) = "white" {}
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_MainTex("MainTex", 2D) = "white" {}
		_RimPower("Rim Power", Range( 0 , 10)) = 0.5
		_RimOffset("Rim Offset", Float) = 0.24
		_LightingRamp("LightingRamp", 2D) = "white" {}
		_CloudsOpacity("CloudsOpacity", Float) = 0
		_FadeOffset("Fade Offset", Range( -2 , 1)) = 0
		_FadeFalloff("Fade Falloff", Float) = 1
		_CloudScale("CloudScale", Float) = 1
		_TimeScale("TimeScale", Float) = 0
		_Outline("Outline", Float) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		_DiffuseTint("Diffuse Tint", Color) = (0,0,0,0)
		[HDR]_RimLightColor("RimLightColor", Color) = (0,0,0,0)
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_CloudMax("CloudMax", Float) = 0
		_CloudMin("CloudMin", Float) = 0
		_Shadow("Shadow", Range( 0 , 1)) = 0
		[Toggle]_CloudsToDiffuse("CloudsToDiffuse", Float) = 1
		_FadeDiv("FadeDiv", Float) = 0
		_Cutout("Cutout", 2D) = "white" {}
		_LightBleedColor("LightBleedColor", Color) = (0,0,0,0)
		_Transmission("Transmission", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent-10"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _Outline;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float temp_output_134_0 = ( _TimeScale * _SinTime.x );
			float3 ase_worldPos = i.worldPos;
			float2 appendResult139 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 panner23 = ( temp_output_134_0 * float2( 0,0 ) + appendResult139);
			float cos24 = cos( temp_output_134_0 );
			float sin24 = sin( temp_output_134_0 );
			float2 rotator24 = mul( panner23 - float2( 0,0 ) , float2x2( cos24 , -sin24 , sin24 , cos24 )) + float2( 0,0 );
			float4 tex2DNode5 = tex2D( _Clouds, (rotator24*_CloudScale + 0.0) );
			float temp_output_45_0 = ( 1.0 - temp_output_134_0 );
			float2 panner46 = ( temp_output_45_0 * float2( 0,0 ) + appendResult139);
			float cos47 = cos( temp_output_45_0 );
			float sin47 = sin( temp_output_45_0 );
			float2 rotator47 = mul( panner46 - float2( 0,0 ) , float2x2( cos47 , -sin47 , sin47 , cos47 )) + float2( 0,0 );
			float4 tex2DNode44 = tex2D( _Clouds, (rotator47*_CloudScale + 0.0) );
			float3 worldToObj40 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float temp_output_15_0 = pow( ( worldToObj40.y - _FadeOffset ) , _FadeFalloff );
			float4 temp_output_82_0 = ( _Opacity * saturate( ( ( ( tex2DNode5 * _CloudsOpacity * tex2DNode44 ) * ( temp_output_15_0 / _FadeDiv ) ) + temp_output_15_0 ) ) );
			o.Emission = _Color0.rgb;
			clip( temp_output_82_0.r - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+600" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha DstAlpha
		
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			float3 worldPos;
			float3 viewDir;
		};

		struct SurfaceOutputStandardSpecularCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Specular;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _LightingRamp;
		uniform float _Shadow;
		uniform float _CloudsToDiffuse;
		uniform sampler2D _Clouds;
		uniform float _TimeScale;
		uniform float _CloudScale;
		uniform float _CloudMin;
		uniform float _CloudMax;
		uniform float4 _DiffuseTint;
		uniform float4 _RimLightColor;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float _Transmission;
		uniform float4 _LightBleedColor;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float _Opacity;
		uniform float _CloudsOpacity;
		uniform float _FadeOffset;
		uniform float _FadeFalloff;
		uniform float _FadeDiv;
		uniform sampler2D _Cutout;
		uniform float4 _Cutout_ST;
		uniform float _Cutoff = 0.19;
		uniform float _Outline;
		uniform float4 _Color0;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingStandardSpecularCustom(SurfaceOutputStandardSpecularCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandardSpecular r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Specular = s.Specular;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandardSpecular (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardSpecularCustom_GI(SurfaceOutputStandardSpecularCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardSpecularCustom o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult12_g3 = dot( ase_worldNormal , ase_worldlightDir );
			float2 temp_cast_0 = ((dotResult12_g3*0.35 + 0.35)).xx;
			float4 temp_cast_1 = (_Shadow).xxxx;
			float4 clampResult109 = clamp( tex2D( _LightingRamp, temp_cast_0 ) , temp_cast_1 , float4( 1,1,1,0 ) );
			float temp_output_134_0 = ( _TimeScale * _SinTime.x );
			float temp_output_45_0 = ( 1.0 - temp_output_134_0 );
			float2 appendResult139 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 panner46 = ( temp_output_45_0 * float2( 0,0 ) + appendResult139);
			float cos47 = cos( temp_output_45_0 );
			float sin47 = sin( temp_output_45_0 );
			float2 rotator47 = mul( panner46 - float2( 0,0 ) , float2x2( cos47 , -sin47 , sin47 , cos47 )) + float2( 0,0 );
			float4 tex2DNode44 = tex2D( _Clouds, (rotator47*_CloudScale + 0.0) );
			float2 panner23 = ( temp_output_134_0 * float2( 0,0 ) + appendResult139);
			float cos24 = cos( temp_output_134_0 );
			float sin24 = sin( temp_output_134_0 );
			float2 rotator24 = mul( panner23 - float2( 0,0 ) , float2x2( cos24 , -sin24 , sin24 , cos24 )) + float2( 0,0 );
			float4 tex2DNode5 = tex2D( _Clouds, (rotator24*_CloudScale + 0.0) );
			float4 temp_cast_2 = (_CloudMin).xxxx;
			float4 temp_cast_3 = (_CloudMax).xxxx;
			o.Albedo = ( ( ( tex2D( _MainTex, uv_MainTex ) * clampResult109 ) + lerp(float4( 0,0,0,0 ),saturate( (temp_cast_2 + (( tex2DNode44 * tex2DNode5 ) - float4( 0,0,0,0 )) * (temp_cast_3 - temp_cast_2) / (float4( 1,1,1,0 ) - float4( 0,0,0,0 ))) ),_CloudsToDiffuse) ) * _DiffuseTint ).rgb;
			float dotResult93 = dot( ase_worldNormal , i.viewDir );
			o.Emission = saturate( ( _RimLightColor * saturate( pow( ( 1.0 - saturate( ( dotResult93 + _RimOffset ) ) ) , _RimPower ) ) ) ).rgb;
			o.Transmission = ( _Transmission * _LightBleedColor ).rgb;
			float4 temp_output_123_0 = _LightBleedColor;
			o.Translucency = temp_output_123_0.rgb;
			float3 worldToObj40 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float temp_output_15_0 = pow( ( worldToObj40.y - _FadeOffset ) , _FadeFalloff );
			float4 temp_output_82_0 = ( _Opacity * saturate( ( ( ( tex2DNode5 * _CloudsOpacity * tex2DNode44 ) * ( temp_output_15_0 / _FadeDiv ) ) + temp_output_15_0 ) ) );
			o.Alpha = temp_output_82_0.r;
			float2 uv_Cutout = i.uv_texcoord * _Cutout_ST.xy + _Cutout_ST.zw;
			clip( tex2D( _Cutout, uv_Cutout ).a - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecularCustom keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandardSpecularCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecularCustom, o )
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
Version=15600
7;36;1906;1037;2950.028;511.7339;1.327411;False;False
Node;AmplifyShaderEditor.RangedFloatNode;42;-1869.413,-226.2172;Float;False;Property;_TimeScale;TimeScale;16;0;Create;True;0;0;False;0;0;9E-05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;133;-1842.067,-97.06938;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-1652.007,-127.6386;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;21;-2028.748,154.3054;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;139;-1790.125,124.9498;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;45;-1546.707,-263.8519;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;23;-1374.908,7.187622;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;46;-1364.707,-349.8519;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformPositionNode;40;-1646.317,175.8136;Float;False;World;Object;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;14;-1107.908,345.1876;Float;False;Property;_FadeOffset;Fade Offset;13;0;Create;True;0;0;False;0;0;-1.13;-2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;92;-1887.463,1445.03;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;91;-1935.463,1285.03;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;26;-1145.908,-72.81238;Float;False;Property;_CloudScale;CloudScale;15;0;Create;True;0;0;False;0;1;4.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;24;-1149.908,10.18762;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;47;-1160.707,-395.8519;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-719.908,467.1876;Float;False;Property;_FadeFalloff;Fade Falloff;14;0;Create;True;0;0;False;0;1;-11.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-1187.559,-284.5;Float;True;Property;_Clouds;Clouds;7;0;Create;True;0;0;False;0;41d258bf12135b14eb64a85ee923f7ef;41d258bf12135b14eb64a85ee923f7ef;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DotProductOpNode;93;-1631.462,1365.03;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1644.627,1489.504;Float;False;Property;_RimOffset;Rim Offset;10;0;Create;True;0;0;False;0;0.24;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;48;-946.7065,-285.8519;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-800.908,264.1876;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;25;-909.908,-17.81238;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-1436.627,1377.504;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-675.4128,-826.9803;Float;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;False;0;0.35;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;81;-689.957,-903.2111;Float;False;SimpLambert;-1;;3;67299e254d9394b4dbb9d672d8ab71ca;0;0;1;FLOAT;20
Node;AmplifyShaderEditor.SamplerNode;5;-727.3121,-163.6389;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;15;-521.908,272.1876;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-912.7065,-507.8519;Float;True;Property;_TextureSample3;Texture Sample 3;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-608,128.5;Float;False;Property;_CloudsOpacity;CloudsOpacity;12;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-839.632,689.5057;Float;False;Property;_FadeDiv;FadeDiv;26;0;Create;True;0;0;False;0;0;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;76;-443.5216,-845.6246;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;131;-669.7668,644.7351;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;96;-1286.396,1278.728;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-486.553,-520.7428;Float;False;Property;_CloudMin;CloudMin;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-425,26.5;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-485.9038,-449.791;Float;False;Property;_CloudMax;CloudMax;22;0;Create;True;0;0;False;0;0;2.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-449.317,-322.2636;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1212.627,1505.504;Float;False;Property;_RimPower;Rim Power;9;0;Create;True;0;0;False;0;0.5;1.88;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;113;-248.9041,-481.791;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;135;-1085.164,1347.989;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-177.9038,-1013.791;Float;False;Property;_Shadow;Shadow;24;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-809,-739.5;Float;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;False;0;None;3c29b9c8f08420d44a59c9ebbd0e568e;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;75;-201.1434,-905.0544;Float;True;Property;_LightingRamp;LightingRamp;11;0;Create;True;0;0;False;0;None;2ce7b663688865c4f822fb8e5f6e3367;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-310.61,105.0197;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;99;-908.6275,1377.504;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;-90.38074,241.7986;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;114;-18.90405,-479.791;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-367,-691.5;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;109;172.0961,-897.791;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;80;-10.03743,-174.423;Float;False;Property;_RimLightColor;RimLightColor;20;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.662122,0.8905588,1.710345,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;126;62.36527,-632.5467;Float;False;Property;_CloudsToDiffuse;CloudsToDiffuse;25;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;83;65.71893,62.32838;Float;False;Property;_Opacity;Opacity;21;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;1.188194,-655.7325;Float;False;2;2;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;129;-62.72941,45.59768;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;100;-632.8426,1370.847;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;351.1993,-292.1163;Float;False;2;2;0;COLOR;1,1,1,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;343.8373,-128.0201;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;59;-511.9308,882.2111;Float;False;Property;_Color0;Color 0;18;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;124;839.083,-53.69781;Float;False;Property;_Transmission;Transmission;32;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;61;-292.7201,-218.1931;Float;False;Property;_DiffuseTint;Diffuse Tint;19;0;Create;True;0;0;False;0;0,0,0,0;1,0.7426471,0.9356618,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;111;156.0962,-515.791;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-434.2531,583.9635;Float;False;Property;_Outline;Outline;17;0;Create;True;0;0;False;0;0;2.8E-05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;123;733.083,55.30219;Float;False;Property;_LightBleedColor;LightBleedColor;31;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;115;190.0959,172.209;Float;True;Property;_Displacement;Displacement;27;0;Create;True;0;0;False;0;None;41d258bf12135b14eb64a85ee923f7ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;535.0959,233.209;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosFromTransformMatrix;138;-1834.06,445.5493;Float;False;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;119;-195.9041,346.209;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;136;673.3389,-220.679;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;137;773.6483,526.5099;Float;True;Property;_Cutout;Cutout;28;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;120;-330.0929,524.2669;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;118;177.0959,543.209;Float;False;Property;_DisplacementScale;Displacement Scale;29;0;Create;True;0;0;False;0;0;4E-05;0;0.001;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;117;258.0959,367.209;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OutlineNode;57;833.067,301.1171;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;331.6786,-511.2842;Float;False;2;2;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;121;5.188416,364.9558;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;1019.083,24.30219;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-99.81158,557.9558;Float;False;Property;_DisplacementTiling;Displacement Tiling;30;0;Create;True;0;0;False;0;1;23.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1246.762,-105.6355;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;Naito/GhostyShader - Final;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.19;True;True;600;True;TransparentCutout;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;False;-1;7;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;4E-05;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;134;0;42;0
WireConnection;134;1;133;1
WireConnection;139;0;21;1
WireConnection;139;1;21;2
WireConnection;45;0;134;0
WireConnection;23;0;139;0
WireConnection;23;1;134;0
WireConnection;46;0;139;0
WireConnection;46;1;45;0
WireConnection;40;0;21;0
WireConnection;24;0;23;0
WireConnection;24;2;134;0
WireConnection;47;0;46;0
WireConnection;47;2;45;0
WireConnection;93;0;91;0
WireConnection;93;1;92;0
WireConnection;48;0;47;0
WireConnection;48;1;26;0
WireConnection;13;0;40;2
WireConnection;13;1;14;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;95;0;93;0
WireConnection;95;1;94;0
WireConnection;5;0;1;0
WireConnection;5;1;25;0
WireConnection;15;0;13;0
WireConnection;15;1;16;0
WireConnection;44;0;1;0
WireConnection;44;1;48;0
WireConnection;76;0;81;20
WireConnection;76;1;77;0
WireConnection;76;2;77;0
WireConnection;131;0;15;0
WireConnection;131;1;132;0
WireConnection;96;0;95;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;8;2;44;0
WireConnection;87;0;44;0
WireConnection;87;1;5;0
WireConnection;113;0;87;0
WireConnection;113;3;89;0
WireConnection;113;4;112;0
WireConnection;135;0;96;0
WireConnection;75;1;76;0
WireConnection;17;0;8;0
WireConnection;17;1;131;0
WireConnection;99;0;135;0
WireConnection;99;1;97;0
WireConnection;130;0;17;0
WireConnection;130;1;15;0
WireConnection;114;0;113;0
WireConnection;3;0;2;0
WireConnection;109;0;75;0
WireConnection;109;1;110;0
WireConnection;126;1;114;0
WireConnection;60;0;3;0
WireConnection;60;1;109;0
WireConnection;129;0;130;0
WireConnection;100;0;99;0
WireConnection;79;0;80;0
WireConnection;79;1;100;0
WireConnection;82;0;83;0
WireConnection;82;1;129;0
WireConnection;111;0;60;0
WireConnection;111;1;126;0
WireConnection;115;1;121;0
WireConnection;116;0;115;0
WireConnection;116;1;117;0
WireConnection;116;2;118;0
WireConnection;119;0;120;0
WireConnection;119;1;134;0
WireConnection;136;0;79;0
WireConnection;57;0;59;0
WireConnection;57;2;82;0
WireConnection;57;1;58;0
WireConnection;90;0;111;0
WireConnection;90;1;61;0
WireConnection;121;0;119;0
WireConnection;121;1;122;0
WireConnection;125;0;124;0
WireConnection;125;1;123;0
WireConnection;0;0;90;0
WireConnection;0;2;136;0
WireConnection;0;6;125;0
WireConnection;0;7;123;0
WireConnection;0;9;82;0
WireConnection;0;10;137;4
WireConnection;0;11;57;0
ASEEND*/
//CHKSM=95DA70C46B1377234C07FDE9E0045ED971600C15
