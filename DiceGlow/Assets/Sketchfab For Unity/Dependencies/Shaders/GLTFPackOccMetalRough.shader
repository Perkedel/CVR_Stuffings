
Shader "GLTF/PackOcclusionMetalRough" {
	Properties{
		_MetallicGlossMap("Texture", 2D) = "white" {}
		_OcclusionMap("Texture", 2D) = "white" {}
		_FlipY("Flip texture Y", Int) = 0
	}

	SubShader {
		 Pass {
			 CGPROGRAM

			 #pragma vertex vert
			 #pragma fragment frag
			 #include "UnityCG.cginc"
			 #include "GLTFColorSpace.cginc"

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

			 sampler2D _MetallicGlossMap;
			 sampler2D _OcclusionMap;
			 int _FlipY;


			 vertOutput vert(vertInput input) {
				 vertOutput o;
				 UNITY_SETUP_INSTANCE_ID(input);  // inserted by FixShadersRightEye.cs
				 UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
				 o.pos = UnityObjectToClipPos(input.pos);
				 o.texcoord.x = input.texcoord.x;
				 if(_FlipY == 1)
					o.texcoord.y = 1.0 - input.texcoord.y;
				 else
					 o.texcoord.y = input.texcoord.y;

				 return o;
			 }

			 half4 frag(vertOutput output) : COLOR {
			 	half4 final = half4(0.0, 0.0, 0.0 ,1.0);

			 	float4 occ = linearToSrgb(tex2D(_OcclusionMap, output.texcoord));
			 	float4 metalr = linearToSrgb(tex2D(_MetallicGlossMap, output.texcoord));

			 	final.r = occ.r;
				final.g = 1.0 - metalr.a;
				final.b = metalr.r;

			 	final.a = 1.0f;

			 	return final;
			 }

			ENDCG
		}
	}
}
