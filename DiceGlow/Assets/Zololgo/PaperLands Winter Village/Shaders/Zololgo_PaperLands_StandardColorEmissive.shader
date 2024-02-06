
Shader "Zololgo-PaperLands/Standard Color Emissive" {

	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
	}
	
    SubShader {
	
		LOD 200
		Tags { "RenderType" = "Opaque" }
	  
		CGPROGRAM
		#pragma surface surf StandardSpecular

		struct Input {
			half4 color;
		};
      
		half4 _Color;
	
		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			o.Albedo = _Color.rgb;
			o.Emission = _Color.rgb;
			o.Alpha = _Color.a;
		}
		
		ENDCG
		
    }

	Fallback "VertexLit"
	
}
