Shader "Sayiarin/Unlit HDR PenTrail"
{
    Properties
    {
        [HDR]_Colour("Colour", Color) = (1, 1, 1, 1)
        _Brightness("Brightness", Range(0, 2)) = 1
        [Enum(Off, 0, Back, 1, Front, 2)]_CullMode("Culling Mode", int) = 0
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
            "IsEmissive"="true"
        }
        LOD 100
        Cull[_CullMode]

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

            float4 _Colour;
            float _Brightness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return _Colour * _Brightness;
            }
            ENDCG
        }
    }
}
