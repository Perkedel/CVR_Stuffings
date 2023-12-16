Shader "Luc/WorldBorder"
{
    Properties
    {
        [Header(_______ Texture Settings ________)]
        [Space(10)]
        [HDR]_Color("Color", Color) = (1,1,1,1)
        _MainTex("Texture", 2D) = "white" {}
        _ScrollXSpeed("Scroll Speed X", Range(0,10)) = 2
        _ScrollYSpeed("Scroll Speed Y", Range(0,10)) = 3
        [KeywordEnum(Both,Albedo,Emission)]_RenderMode("Render Mode", Int) = 0
        _EmissionStrengh("Emission Stregh", Range(0, 10)) = 0
        [Header(_______ Fade Settings ________)]
        [Space(10)]
        _MinDistance ("Minimum Distance", Range(0, 100)) = 2
        _MaxDistance ("Maximum Distance", Range(0, 100)) = 3
        _IntDistance ("Fade Strengh", Range(0, 10)) = 1
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "RenderType"="Transparent" }
        LOD 200
        ColorMask 0
        Cull Off
        CGPROGRAM
        
        #pragma surface surf Standard fullforwardshadows alpha:fade
        #pragma target 3.0
        
        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };
        
        sampler2D _MainTex;
        fixed4 _Color;
        float _ScrollXSpeed;
        float _ScrollYSpeed;
        float _EmissionStrengh;
        float _MinDistance;
        float _MaxDistance;
        float _IntDistance;
        float _RenderMode;
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed2 scrolledUV = IN.uv_MainTex;
            fixed xScrollValue = _ScrollXSpeed * _Time;
            fixed yScrollValue = _ScrollYSpeed * _Time;

            scrolledUV += fixed2(xScrollValue, yScrollValue);
            half4 c = tex2D(_MainTex, scrolledUV);
            c.rgba = c.rgba * _Color;
            if(_RenderMode != 2) {
                o.Albedo = c.rbg;
            }
            if(_RenderMode != 1) {
                o.Emission = c.rgb * _EmissionStrengh;
            }

            float distanceFromCamera = distance(IN.worldPos, _WorldSpaceCameraPos);
            float fade = saturate((distanceFromCamera - _MinDistance) * -1 / _MaxDistance);
         
            o.Alpha = c.a * fade * _IntDistance;
        }
        ENDCG
    }
    Fallback "Diffuse"
}