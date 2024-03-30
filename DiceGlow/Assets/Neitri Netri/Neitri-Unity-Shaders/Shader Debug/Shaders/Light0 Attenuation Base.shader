Shader "Neitri/Debug/Light0 Attenuation Base"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "Queue" = "Geometry" "RenderType" = "Opaque" "IgnoreProjector" = "True" }
		Cull Back

		Pass
		{
			Name "FORWARD"
			Tags { "LightMode"="ForwardBase" }
			Cull Back

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "Lighting.cginc"

			#pragma multi_compile_fwdbase

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 worldPos : TEXCOORD0;
				float3 normalDir : TEXCOORD1;
				LIGHTING_COORDS(2,3) // shadow coords
				UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
				o.pos = UnityObjectToClipPos(v.vertex);
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex);
				TRANSFER_VERTEX_TO_FRAGMENT(o) // transfer shadow coords
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				UNITY_LIGHT_ATTENUATION(attenuation, i, i.worldPos.xyz);
				return float4(attenuation, attenuation, attenuation, 1);
			}
			ENDCG
		}
	}

	FallBack Off
}
