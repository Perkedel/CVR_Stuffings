Shader "Custom/PropCameraShader" {
	Properties{
		_MainTex("Txture", 2D) = "white" {}
		_Alpha("Alpha" , Float) = 1
	}
	SubShader{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent+1000" "DisableBatching" = "True"}
		LOD 200
		ZTest Always

			//左右目判定
			//https://github.com/tsgcpp/StereoEyeShaderSample-Unity/blob/master/Assets/Shaders/StereoEyeTexture.shader

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			   
			#include "UnityCG.cginc"

			#define COLORS 32.0

			struct appdata
			{
				float4 Vertex : POSITION;
				float4 texcoord : TEXCOORD0;

				// instanceID変数の宣言
				UNITY_VERTEX_INPUT_INSTANCE_ID

			};

			struct v2f
			{
				float4 ScreenPos   : TEXCOORD0;
				float4 Vertex : SV_POSITION;
				// instanceIDをfragに送る場合は必要(今回は不要)
				UNITY_VERTEX_INPUT_INSTANCE_ID

				// fragにunity_StereoEyeIndexなどの情報を流すための変数を追加
				UNITY_VERTEX_OUTPUT_STEREO
			};

			v2f vert(appdata v) {
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs

				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.Vertex = UnityObjectToClipPos(v.Vertex);
				o.ScreenPos = ComputeScreenPos(o.Vertex);
				return o;
			};

			sampler2D _MainTex;
			float _Alpha;

			fixed4 frag(v2f i) : SV_Target
			{

				// inputを使用しなくても、以下の関数でunity_StereoEyeIndexを更新可能(今回は不使用)
				UNITY_SETUP_INSTANCE_ID(i);

#if defined(USING_STEREO_MATRICES)
				//if (UNITY_MATRIX_P[0][2] == 0) {
					return float4(0, 0, 0, 0);
				//}
#endif				
				float2 suv = ((i.ScreenPos.xy) / i.ScreenPos.w);
				fixed4 col = saturate(tex2D(_MainTex, suv));
				fixed4 c = fixed4(col.rgb, col.a* _Alpha);
				return c;	
			}
			ENDCG
		}
	}
}
