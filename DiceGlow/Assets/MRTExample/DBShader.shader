Shader "Unlit/DBShader"
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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _RT0;
            sampler2D _RT1;
            sampler2D _RT2;

            v2f vert (appdata v)
            {
                v2f o;
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
                res.color0 = tex2D(_RT0, i.uv);
                res.color1 = tex2D(_RT1, i.uv);
                res.color2 = tex2D(_RT2, i.uv);
                return res;
            }
            ENDCG
        }
    }
}
