Shader "Sayiarin/ColourGradientTime"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [HDR]_MainColour("Main Colour", Color) = (1, 1, 1, 1)
        [HDR]_HighlightColour("Highlight Colour", Color) = (0, 0, 0, 0)
        _Speed("Highlight Speed", Range(0, 10)) = 1
        _HighlightMask("Highlight Mask", 2D) = "black" {}
        _Brightness("Brightness", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
            "IsEmissive"="true"
        }
        Cull Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _HighlightMask;
            float4 _MainTex_ST;
            float4 _MainColour;
            float4 _HighlightColour;
            float _Speed;
            float _Brightness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 colour;
                fixed4 mainColour = tex2D(_MainTex, i.uv) * _MainColour;
                fixed4 highlightColour = tex2D(_MainTex, i.uv) * _HighlightColour;
                i.uv.y += _Time.x * _Speed;
                fixed highlightMask = tex2D(_HighlightMask, i.uv).xyz / 3;

                colour = lerp(mainColour, highlightColour, highlightMask);
                colour *= _Brightness;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, colour);
                return colour;
            }
            ENDCG
        }
    }
}
