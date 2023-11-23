// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MaidSurfaceShader_Brow" {
	Properties
	{
		_Color("Color(RGBA)", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}
		_Shininess ("Shininess", Float) = 1.0
		_Lambert ("LightDiffse", Float)= 0.5

		_ViewDiff ("ViewDiffse", Float)= 0.5
		
		_EdgeSize("EdgeSize", Range(0,0.002)) = 0.001
		_EdgeColor("EdgeColor", Color) = (0, 0, 0, 1)
	}

	SubShader
	{
		Tags {"Queue" = "Transparent+1" "IgnoreProjector"="False" "RenderType" = "Transparent"}
		 
		Cull OFF
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma surface surf Toon alphatest:off vertex:vert
		#pragma exclude_renderers flash

		float4 _Color;
		sampler2D _MainTex;
		float	_Shininess;
		uniform float _ViewDiff;
		uniform float _Lambert;
		
		struct Input
		{
			float2 uv_MainTex;
			float4 pos;
		};

		struct ToonSurfaceOutput
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Gloss;
			half Specular;
			half Alpha;
			half4 Color;
		};

		inline half4 LightingToon (ToonSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			if (_WorldSpaceLightPos0.w == 0.0){
			atten =1.0;
			}
			//Lighting paramater
			float4	lightColor = _LightColor0 * atten;
			
			half viewCos = dot(viewDir, s.Normal) * _ViewDiff - _ViewDiff;
			
			float4 lambert = (saturate(dot(lightDir, s.Normal)) *_Lambert)+(-_Lambert +1.0)*1.1;

			float4 color = _Color * (lightColor) * s.Color * (atten) * _Shininess;
			
			color *= lambert;
			color.rgb += viewCos;
			color.a = s.Alpha;
			return color;
		}

		void vert (inout appdata_full v, out Input o) {
		    UNITY_INITIALIZE_OUTPUT(Input,o);
		}

		void surf (Input IN, inout ToonSurfaceOutput o)
		{

			o.Albedo = 0.0;
			o.Emission = 0.0;
			o.Gloss = 0.0;
			o.Specular = 0.0;

			half4 c		= tex2D(_MainTex, IN.uv_MainTex) * _Color; 
			o.Color		= c;
			o.Alpha		= c.a;
		}

		ENDCG
		
		Pass {
			Name "OUTLINE"
			Tags {"LightMode" = "Always" }
			Cull Front
			ZWrite On
			ColorMask RGB
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "HLSLSupport.cginc"
			#include "UnityShaderVariables.cginc"
			#define UNITY_PASS_FORWARDBASE
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
			#define INTERNAL_DATA
			#define WorldReflectionVector(data,normal) data.worldRefl
			#define WorldNormalVector(data,normal) normal
			uniform float _EdgeSize;
			uniform float4 _EdgeColor;

			struct v2f {
				float4 pos : SV_POSITION;
				float4 color : COLOR;
				half3 viewDir : TEXCOORD1;
				float3 posWorld : TEXCOORD2;
			};
			

			v2f vert (appdata_full v)
			{
			
				v2f o;
				float4 world_pos = mul(UNITY_MATRIX_MV, v.vertex);
			float r_proj_near = (-UNITY_MATRIX_P[3][2] - UNITY_MATRIX_P[2][2]) / UNITY_MATRIX_P[2][3];
			float r_proj_y = UNITY_MATRIX_P[1][1] * r_proj_near * 0.5f;
			
			o.viewDir = (half3)WorldSpaceViewDir(v.vertex);
			o.posWorld = mul(unity_ObjectToWorld, v.vertex);
			float viewLength = length(_WorldSpaceCameraPos.xyz - o.posWorld.xyz);
			
			float edge_size = abs( (_EdgeSize * 1/viewLength) / r_proj_y * world_pos.z * r_proj_near);
			
				o.pos = UnityObjectToClipPos(v.vertex + float4(v.normal.xyz * edge_size,0.0));

				o.color = _EdgeColor;

				return o;
			}
			
			
			half4 frag(v2f i) :COLOR { return i.color; }

			ENDCG
		}
	
	}

	Fallback "Diffuse"
}
