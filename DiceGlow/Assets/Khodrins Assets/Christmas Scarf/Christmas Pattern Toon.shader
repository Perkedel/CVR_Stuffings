// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Khodrins Shaders/Christmas Pattern Toon"
{
	Properties
	{
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_Oclusion("Oclusion", 2D) = "white" {}
		_Pattern("Pattern", 2D) = "white" {}
		_PatternSize("Pattern Size", Vector) = (0,0,0,0)
		_StrandMap("Strand Map", 2D) = "white" {}
		_MapSize("Map Size", Vector) = (0,0,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		_NoiseScale("Noise Scale", Float) = 0.2
		_NoiseStrengh("Noise Strengh", Float) = 0.2
		_WrapCorrection("WrapCorrection", Vector) = (0.36,0.2,0.36,0.2)
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_Emission("Emission", 2D) = "black" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionModifier("Emission Modifier", 2D) = "white" {}
		_ModifierScrolltime("Modifier Scrolltime", Float) = 1
		_ModifierScrolldirection("Modifier Scrolldirection", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
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

		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionModifier;
		uniform float _ModifierScrolltime;
		uniform float2 _ModifierScrolldirection;
		uniform sampler2D _Albedo;
		uniform float2 _PatternSize;
		uniform float2 _MapSize;
		uniform float2 _Offset;
		uniform float _NoiseScale;
		uniform float _NoiseStrengh;
		uniform sampler2D _Pattern;
		uniform sampler2D _StrandMap;
		uniform float4 _WrapCorrection;
		uniform sampler2D _Oclusion;
		uniform float4 _Color;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _Normal;
		uniform float _NormalScale;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_output_55_0 = ( _PatternSize / _MapSize );
			float2 uv_TexCoord12 = i.uv_texcoord * temp_output_55_0 + _Offset;
			float simplePerlin2D59 = snoise( uv_TexCoord12*_NoiseScale );
			simplePerlin2D59 = simplePerlin2D59*0.5 + 0.5;
			float2 UVs57 = ( ( simplePerlin2D59 * _NoiseStrengh ) + uv_TexCoord12 );
			float4 tex2DNode1 = tex2D( _StrandMap, UVs57 );
			float2 appendResult53 = (float2(tex2DNode1.r , tex2DNode1.g));
			float2 temp_output_68_0 = ( appendResult53 * ( 1.0 - ( float2( 1,1 ) / _MapSize ) ) );
			float2 temp_output_27_0 = step( fmod( UVs57 , float2( 1,1 ) ) , float2( 0.5,0.5 ) );
			float2 appendResult73 = (float2(_WrapCorrection.x , _WrapCorrection.y));
			float2 appendResult74 = (float2(_WrapCorrection.z , _WrapCorrection.w));
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult76 = dot( BlendNormals( UnpackScaleNormal( tex2D( _Normal, UVs57 ), _NormalScale ) , ase_vertexNormal ) , ase_worldlightDir );
			float clampResult87 = clamp( (0.0 + (dotResult76 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.01 , 0.99 );
			float2 temp_cast_1 = (clampResult87).xx;
			c.rgb = ( tex2D( _Albedo, UVs57 ) * tex2D( _Pattern, ( ( floor( UVs57 ) + temp_output_68_0 + ( (( temp_output_27_0 * step( appendResult73 , temp_output_68_0 ) )).xy * float2( -1,-1 ) ) + (( ( 1.0 - temp_output_27_0 ) * step( temp_output_68_0 , appendResult74 ) )).xy + ( float2( 0.5,0.5 ) / _MapSize ) ) / temp_output_55_0 ) ) * tex2D( _Oclusion, UVs57 ) * _Color * tex2D( _ToonRamp, temp_cast_1 ) ).rgb;
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
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float mulTime91 = _Time.y * _ModifierScrolltime;
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionColor * tex2D( _EmissionModifier, ( float2( 0,0 ) + ( mulTime91 * _ModifierScrolldirection ) ) ).r ).rgb;
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
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
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
Version=18921
224;641;2104;938;1158.552;123.6095;2.117894;True;True
Node;AmplifyShaderEditor.Vector2Node;46;-3188.594,320.6021;Inherit;False;Property;_MapSize;Map Size;8;0;Create;True;0;0;0;False;0;False;0,0;4,6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;54;-3190.297,193.3272;Inherit;False;Property;_PatternSize;Pattern Size;6;0;Create;True;0;0;0;False;0;False;0,0;64,128;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;17;-2807.286,322.6494;Inherit;False;Property;_Offset;Offset;9;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;55;-2809.297,192.3272;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2554.174,129.0264;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-2941.212,-127.1089;Inherit;False;Property;_NoiseScale;Noise Scale;10;0;Create;True;0;0;0;False;0;False;0.2;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;59;-2556.212,-128.1089;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-2941.212,3.891052;Inherit;False;Property;_NoiseStrengh;Noise Strengh;11;0;Create;True;0;0;0;False;0;False;0.2;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-2266.212,1.891052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-2110.212,0.8910522;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;-1916.322,7.29611;Inherit;False;UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1767.612,-88.33481;Inherit;False;57;UVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;69;-2804.807,557.3592;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1405,389.8673;Inherit;True;Property;_StrandMap;Strand Map;7;0;Create;True;0;0;0;False;0;False;-1;None;9c9cfbd6602dee143aa44e16d996a1ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;2;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;72;-1085.826,640.7761;Inherit;False;Property;_WrapCorrection;WrapCorrection;12;0;Create;True;0;0;0;False;0;False;0.36,0.2,0.36,0.2;0.71,0.69,0.05,0.18;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;70;-2558.763,516.399;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;53;-1087.134,387.2735;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1785.628,643.8908;Inherit;False;Property;_NormalScale;Normal Scale;3;0;Create;True;0;0;0;False;0;False;1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-805.826,586.7761;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-860.9965,387.1783;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.8,0.8;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FmodOpNode;26;-1405.139,127.9532;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;27;-1154.261,128.8086;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalVertexDataNode;77;-1408.345,1327.885;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1407,895.8672;Inherit;True;Property;_Normal;Normal;2;0;Create;True;0;0;0;False;0;False;-1;None;93234c73b6ac27e4ea357c61739d67fa;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;74;-794.826,713.7761;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;28;-508.8651,386.6861;Inherit;True;2;0;FLOAT2;0.36,0;False;1;FLOAT2;0.532,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-252.8653,376.6861;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;33;-506.3291,629.1655;Inherit;True;2;0;FLOAT2;1,1;False;1;FLOAT2;0.2,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;36;-253.3287,627.1655;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;75;-1398.314,1153.784;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BlendNormalsNode;78;-1085.345,900.8845;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-66.32862,629.1655;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;31;3.67146,371.1651;Inherit;True;FLOAT2;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;13;-1410.21,-128.8253;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;90;390.1206,778.2704;Inherit;False;Property;_ModifierScrolltime;Modifier Scrolltime;17;0;Create;True;0;0;0;False;0;False;1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;76;-707.8011,898.5096;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;56;-2807.074,451.4355;Inherit;False;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;80;-384.4604,898.6254;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;66;-55.16399,81.24347;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;92;612.4199,904.3705;Inherit;False;Property;_ModifierScrolldirection;Modifier Scrolldirection;18;0;Create;True;0;0;0;False;0;False;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;91;611.1199,778.2704;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;195.6714,374.1651;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-1,-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;38;195.6713,628.1655;Inherit;True;FLOAT2;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;87;-119.7407,900.3373;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;0.99;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;830.8198,778.2704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;448.9511,113.5117;Inherit;True;5;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;21;776.1261,116.8001;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;81;384.0859,1060.398;Inherit;True;Property;_ToonRamp;Toon Ramp;13;0;Create;True;0;0;0;False;0;False;-1;None;33f0be12db407fc448e23c0edb0c1166;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;94;1024.52,778.2704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;45;1154.348,342.3582;Inherit;True;Property;_Oclusion;Oclusion;4;0;Create;True;0;0;0;False;0;False;-1;None;3ba2d2d6849c3bf449d48f1343a6e933;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;95;1153.693,552.0367;Inherit;True;Property;_Emission;Emission;14;0;Create;True;0;0;0;False;0;False;-1;None;89a57d3904d2fae49957be316f14b629;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;1157.302,-138.2908;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;0;False;0;False;-1;None;99c9b85eb516503488c7d0b99553d1a9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;113;1646.483,1135.363;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;18;1158.944,119.8198;Inherit;True;Property;_Pattern;Pattern;5;0;Create;True;0;0;0;False;0;False;-1;None;537998425da36434c945276acaef6835;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;88;1154.222,-378.3011;Inherit;False;Property;_Color;Color;0;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;2,2,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;97;1154.52,969.3708;Inherit;True;Property;_EmissionModifier;Emission Modifier;16;0;Create;True;0;0;0;False;0;False;-1;None;6bef3728daf9cb446a29eb5286a0c3a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;96;1157.123,780.1044;Inherit;False;Property;_EmissionColor;Emission Color;15;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;16,16,16,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1669.233,129.219;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;1541.123,647.1044;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2049.088,131.4423;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Khodrins Shaders/Christmas Pattern Toon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;55;0;54;0
WireConnection;55;1;46;0
WireConnection;12;0;55;0
WireConnection;12;1;17;0
WireConnection;59;0;12;0
WireConnection;59;1;61;0
WireConnection;62;0;59;0
WireConnection;62;1;63;0
WireConnection;60;0;62;0
WireConnection;60;1;12;0
WireConnection;57;0;60;0
WireConnection;69;1;46;0
WireConnection;1;1;58;0
WireConnection;70;0;69;0
WireConnection;53;0;1;1
WireConnection;53;1;1;2
WireConnection;73;0;72;1
WireConnection;73;1;72;2
WireConnection;68;0;53;0
WireConnection;68;1;70;0
WireConnection;26;0;58;0
WireConnection;27;0;26;0
WireConnection;2;1;58;0
WireConnection;2;5;24;0
WireConnection;74;0;72;3
WireConnection;74;1;72;4
WireConnection;28;0;73;0
WireConnection;28;1;68;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;33;0;68;0
WireConnection;33;1;74;0
WireConnection;36;0;27;0
WireConnection;78;0;2;0
WireConnection;78;1;77;0
WireConnection;37;0;36;0
WireConnection;37;1;33;0
WireConnection;31;0;29;0
WireConnection;13;0;58;0
WireConnection;76;0;78;0
WireConnection;76;1;75;0
WireConnection;56;1;46;0
WireConnection;80;0;76;0
WireConnection;66;0;13;0
WireConnection;91;0;90;0
WireConnection;32;0;31;0
WireConnection;38;0;37;0
WireConnection;87;0;80;0
WireConnection;93;0;91;0
WireConnection;93;1;92;0
WireConnection;14;0;66;0
WireConnection;14;1;68;0
WireConnection;14;2;32;0
WireConnection;14;3;38;0
WireConnection;14;4;56;0
WireConnection;21;0;14;0
WireConnection;21;1;55;0
WireConnection;81;1;87;0
WireConnection;94;1;93;0
WireConnection;45;1;58;0
WireConnection;22;1;58;0
WireConnection;113;0;81;0
WireConnection;18;1;21;0
WireConnection;97;1;94;0
WireConnection;23;0;22;0
WireConnection;23;1;18;0
WireConnection;23;2;45;0
WireConnection;23;3;88;0
WireConnection;23;4;113;0
WireConnection;98;0;95;0
WireConnection;98;1;96;0
WireConnection;98;2;97;1
WireConnection;0;2;98;0
WireConnection;0;13;23;0
ASEEND*/
//CHKSM=68B039EB9D047B48598A7DD82151DF44D425E2EF