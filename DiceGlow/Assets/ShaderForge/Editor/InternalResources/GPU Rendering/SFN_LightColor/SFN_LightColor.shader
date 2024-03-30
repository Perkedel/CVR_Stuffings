Shader "Hidden/Shader Forge/SFN_LightColor" {
    Properties {
        _OutputMask ("Output Mask", Vector) = (1,1,1,1)

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
       		#include "AutoLight.cginc"
            #pragma target 3.0
            uniform float4 _OutputMask;

            uniform float4 _LightColor0;

            struct VertexInput {
                float4 vertex : POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
            	
                // Operator
                float4 outputColor = float4(_LightColor0.rgb,0);

                // Return
                return outputColor * _OutputMask;
            }
            ENDCG
        }
    }
}
