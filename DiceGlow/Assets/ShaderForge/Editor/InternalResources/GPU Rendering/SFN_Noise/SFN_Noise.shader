Shader "Hidden/Shader Forge/SFN_Noise" {
    Properties {
        _OutputMask ("Output Mask", Vector) = (1,1,1,1)
        _XY ("XY", 2D) = "black" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _OutputMask;
            uniform sampler2D _XY;

            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {

                // Read inputs
                float4 _xy = tex2D( _XY, i.uv );

                // Operator
float2 s = _xy + 0.2127+_xy.x*0.3713*_xy.y;
                float2 r = 4.789*sin(489.123*s);
                float4 outputColor = frac(r.x*r.y*(1+s.x));

                // Return
                return outputColor * _OutputMask;
            }
            ENDCG
        }
    }
}
