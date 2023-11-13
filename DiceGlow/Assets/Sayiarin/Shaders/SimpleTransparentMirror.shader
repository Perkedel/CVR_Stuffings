Shader "Sayiarin/SimpleTransparentMirror"
{
    Properties
    {
        _ReflectionTexLeft ("_ReflectionTexLeft", 2D) = "white" {}
        _ReflectionTexRight ("_ReflectionTexRight", 2D) = "white" {}
        _FadeDistance("Fade Distance", Range(0, 20)) = 2
        _FadeoutLength("Fade Out Length", Range(0, 10)) = 1
        _ReflectAlpha("Reflection Transparency", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags {
                "RenderType"="Transparent"
                "Queue"="Transparent+1"
                "IgnoreProjector"="True"
            }
        ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityInstancing.cginc"
            
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 refl : TEXCOORD1;
                float4 pos : SV_POSITION;
                float4 distance : TEXCOORD2;
                float3x3 hueRotation : TEXCOORD3;
                
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            struct appdata 
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            float _FadeDistance;
            float _FadeoutLength;
            float _ReflectAlpha;
            
            v2f vert(appdata v)
            {
                v2f o;
                
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.pos = UnityObjectToClipPos(v.vertex);
                o.refl = ComputeNonStereoScreenPos(o.pos);

                return o;
            }
            
            sampler2D _ReflectionTexLeft;
            sampler2D _ReflectionTexRight;
            
            fixed4 frag(v2f i) : SV_Target
            {
                // mostly unaltered CVR ABI default mirror code
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
                
                fixed4 refl;
                float4 projCoord = UNITY_PROJ_COORD(i.refl);
                float2 proj2 = float2(1 - projCoord.x / projCoord.w, projCoord.y / projCoord.w);
                if (unity_StereoEyeIndex == 0) refl = tex2D(_ReflectionTexLeft, proj2);
                else refl = tex2D(_ReflectionTexRight, proj2);

                // distance fade
                refl.a *= 1 - smoothstep(_FadeDistance, _FadeDistance + _FadeoutLength, distance(i.distance, mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1.0))));

                // transparency override to make avatars/objects semi transparent if needed
                refl.a *= _ReflectAlpha;
                return refl;
            }
            ENDCG
        }
    }
}