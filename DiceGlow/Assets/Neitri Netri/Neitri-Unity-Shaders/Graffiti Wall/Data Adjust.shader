Shader "Neitri/Graffiti Wall/Data Adjust"
{
	Properties
	{
		_Color("_Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { 
			"Queue" = "Transparent"
			"RenderType"="Transparent" 
		}
		Blend One Zero
		ZWrite Off
		Cull Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
			};

			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return _Color;
			}
			ENDCG
		}
	}
}
