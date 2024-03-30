Shader "Hidden/Shader Forge/SFN_NormalBlend" {
    Properties {
        _OutputMask ("Output Mask", Vector) = (1,1,1,1)
        _BSE ("Base", 2D) = "black" {}
        _DTL ("Det.", 2D) = "black" {}
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
            uniform sampler2D _BSE;
            uniform sampler2D _DTL;

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
                float4 _bse = tex2D( _BSE, i.uv );
                float4 _dtl = tex2D( _DTL, i.uv );

                // Operator
float3 bse = _bse.xyz + float3(0,0,1);
                float3 dtl = _dtl.xyz * float3(-1,-1,1);
                float4 outputColor = float4(bse*dot(bse, dtl)/bse.z - dtl,0);

                // Return
                return outputColor * _OutputMask;
            }
            ENDCG
        }
    }
}
