Shader "Unlit/LoopShader"
{
    Properties
    {
    _RT0("RT0", 2D) = "white"{}
    _RT1("RT1", 2D) = "white"{}
    _RT2("RT2", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };

            sampler2D _RT0;
            sampler2D _RT1;
            sampler2D _RT2;

            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            struct fragout
            {
                float4 color0 : SV_Target0;
                float4 color1 : SV_Target1;
                float4 color2 : SV_Target2;
            };

            fragout frag (v2f i)
            {
                fragout res;

                res.color0 = frac(tex2D(_RT0, i.uv) + 0.01);
                res.color1 = frac(tex2D(_RT1, i.uv) + 0.03);
                res.color2 = frac(tex2D(_RT2, i.uv) + 0.05);

                return res;
            }
            ENDCG
        }
    }
}
