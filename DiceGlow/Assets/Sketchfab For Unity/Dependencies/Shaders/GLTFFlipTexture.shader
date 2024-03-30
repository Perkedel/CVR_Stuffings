
Shader "GLTF/FlipTexture" {
	Properties{
		_TextureToFlip("Texture", 2D) = "white" {}
	}

	SubShader {
		 Pass {
			 CGPROGRAM

			 #pragma vertex vert
			 #pragma fragment frag
			 #include "UnityCG.cginc"

			 struct vertInput {
			 float4 pos : POSITION;
			 float2 texcoord : TEXCOORD0;
			 UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
			 };

			 struct vertOutput {
			 float4 pos : SV_POSITION;
			 float2 texcoord : TEXCOORD0;
			 UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
			 };

			 sampler2D _TextureToFlip;
			 int _FlipY;

			 vertOutput vert(vertInput input) {
				 vertOutput o;
				 UNITY_SETUP_INSTANCE_ID(input);  // inserted by FixShadersRightEye.cs
				 UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
				 o.pos = UnityObjectToClipPos(input.pos);
				 o.texcoord.x = input.texcoord.x;
				 o.texcoord.y = 1.0 - input.texcoord.y;

				 return o;
			 }

			 float4 frag(vertOutput output) : COLOR {
			 	return tex2D(_TextureToFlip, output.texcoord);
			 }

			ENDCG
		}
	}
}
