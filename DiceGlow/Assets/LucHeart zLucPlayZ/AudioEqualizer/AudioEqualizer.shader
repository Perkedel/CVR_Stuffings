//Original Made by Leviant,

Shader "Luc/AudioEqualizer Addendum"
{
    Properties
    {
        [Header(General)]
        [Space]
        _MainColor("MainColor", Color) = (0,0,0,1)
        _Smoothness("Smoothness", Range( 0 , 1)) = 0
        
        [Header(Background)]
        [Space]
        _VideoTexture("Video texture", 2D) = "black" {}
        _VideoBrightness("Video Brightness", Range( 0 , 1)) = 0.2
        
        [Header(Waves)]
        [Space]
        _MultiplyMap("Multiply Map", Float) = 1
        _WaveSpeed("Wave Speed", Float) = 1
        [HDR]_CustomColor("Wave Color", Color) = (0,0,0,0)
        [KeywordEnum(Addition, Video Texture)] _ColorAddMode ("Color Add Mode", Float) = 0
        _FallOffTexture("Fall Off texture", 2D) = "white" {}
        [Toggle]_UseNoise("Use noise", Float) = 0
        

        [HideInInspector] __dirty( "", Int ) = 1
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque" "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"
        }
        Cull Back
        CGPROGRAM
        #pragma target 5.0
        #pragma surface surf Standard vertex:vertexDataFunc

        #include "UnityCG.cginc"
        #include "Assets/AudioLink/Shaders/AudioLink.cginc"
        #include "ClassicNoise3D.hlsl"

        struct Input
        {
            float2 texcoord_0 : TEXCOORD0;
            float vert_y;
        };
        
        uniform sampler2D _FallOffTexture;
        uniform sampler2D _VideoTexture;
        uniform float _WaveSpeed;
        uniform float _MultiplyMap;
        uniform float _ColorAddMode;
        uniform float4 _MainColor;
        uniform float _VideoBrightness;
        uniform float _Smoothness;
        uniform float _UseNoise;
        uniform float4 _CustomColor;

        void vertexDataFunc(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.texcoord_0 = v.texcoord.xy;
            float fall_off = tex2Dlod(_FallOffTexture, v.texcoord).r;
            float2 uv_offset = v.texcoord.xy + float2(-0.5, -0.5);
            float delay = sqrt(uv_offset.x * uv_offset.x + uv_offset.y * uv_offset.y) * 127 * _WaveSpeed;
            float4 audio_data = AudioLinkData(ALPASS_AUDIOLINK + uint2( delay, 0 )).rrrr;
            
            float noise = lerp(1, ClassicNoise(float3(o.texcoord_0 * 7, _Time.y / 2)), _UseNoise);
            
            float3 vertex_offset = float3(0.0, audio_data.a * _MultiplyMap * v.vertex.y, 0.0);
            float cm = fall_off.r * max(0, noise);
            v.vertex.xyz += vertex_offset * cm;
            o.vert_y = audio_data.a * cm;
        }
        
        void surf(Input i, inout SurfaceOutputStandard o)
        {
            o.Albedo = _MainColor.rgb;
            const float3 vid = tex2Dlod(_VideoTexture, float4(i.texcoord_0, 0, 5)).rgb;
            const float3 fin = lerp(1, vid * _CustomColor.a, _ColorAddMode);
            o.Emission = vid * _VideoBrightness + _CustomColor.rgb * fin * i.vert_y;
            o.Smoothness = _Smoothness;
            o.Alpha = 1;
        }
        ENDCG
    }
    Fallback "Diffuse"
}