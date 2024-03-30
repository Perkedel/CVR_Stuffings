Shader "Hidden/Shader Forge/FillColor" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
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
            uniform float4 _Color;

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
                return _Color;
            }
            ENDCG
        }
    }
}
