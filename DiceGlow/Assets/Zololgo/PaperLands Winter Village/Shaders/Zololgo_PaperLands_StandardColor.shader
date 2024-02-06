
Shader "Zololgo-PaperLands/Standard Color" {

	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_RimColor ("Rim Color", Color) = (0.5,0.5,0.5,0.0)
		_RimPower ("Rim Falloff", Range(0.5,8.0)) = 5.0
	}
	
    SubShader {
	
		LOD 200
		Tags { "RenderType" = "Opaque" }
	  
		CGPROGRAM
		#pragma surface surf StandardSpecular

		struct Input {
			half4 color;
			float3 viewDir;
		};
      
		half4 _Color;
		float4 _RimColor;
		float _RimPower;
	
		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow (rim, _RimPower);
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		
		ENDCG
		
    }

	Fallback "VertexLit"
	
}
