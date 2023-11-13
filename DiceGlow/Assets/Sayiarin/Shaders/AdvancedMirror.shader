Shader "Sayiarin/AdvancedMirror"
{
    Properties
    {
        _ReflectionTexLeft ("_ReflectionTexLeft", 2D) = "white" {}
        _ReflectionTexRight ("_ReflectionTexRight", 2D) = "white" {}
        _FadeDistance("Fade Distance", Range(0, 20)) = 2
        _FadeoutLength("Fade Out Length", Range(0, 10)) = 1
        _HueShift("Hue Shift", Range(0, 360)) = 0
        _Saturation("Saturation", Range(0, 1)) = 1
        _ReflectAlpha("Reflection Transparency", Range(0, 1)) = 1
        _AlphaMask("Alpha Mask", 2D) = "white" {}
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
            float _HueShift;
            float _Saturation;
            float _ReflectAlpha;
            
            sampler2D _ReflectionTexLeft;
            sampler2D _ReflectionTexRight;
            UNITY_DECLARE_TEX2D(_AlphaMask);
            float4 _AlphaMask_ST;

            #define DEG_AS_RAD 0.01745329251

            float3x3 GetHueRotation(float degrees)
            {
                float3x3 rotation;
                float cosA = cos(DEG_AS_RAD * degrees);
                float sinA = sin(DEG_AS_RAD * degrees);

                rotation[0][0] = cosA + (1.0 - cosA) / 3.0;
                rotation[0][1] = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0 ) * sinA;
                rotation[0][2] = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0 ) * sinA;
                rotation[1][0] = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0 ) * sinA;
                rotation[1][1] = cosA + 1.0 / 3.0 * (1.0 - cosA);
                rotation[1][2] = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0) * sinA;
                rotation[2][0] = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0) * sinA;
                rotation[2][1] = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0) * sinA;
                rotation[2][2] = cosA + 1.0 / 3.0 * (1.0 - cosA);
                return rotation;
            }

            float3 TransformHue(float3 colour, float3x3 hue_rot)
            {
                float3 ret;
                ret.r = colour.r * hue_rot[0][0] + colour.g * hue_rot[0][1] + colour.b * hue_rot[0][2];
                ret.g = colour.r * hue_rot[1][0] + colour.g * hue_rot[1][1] + colour.b * hue_rot[1][2];
                ret.b = colour.r * hue_rot[2][0] + colour.g * hue_rot[2][1] + colour.b * hue_rot[2][2];
                return saturate(ret);
            }

            // hsv comes in as sv.x = Saturation, sv.y = Value and the hue rotation matrix calculated before
            float4 ApplyHSVChangesToRGB(float4 colour, float3x3 hue_rot, float2 sv)
            {
                colour.rgb = TransformHue(colour.rgb, hue_rot);
                float averageColourValue = (colour.r + colour.g + colour.b) / 3.0;
                colour.rgb = lerp(averageColourValue, colour.rgb, sv.x);
                colour.rgb *= sv.y;
                return colour;
            }
            
            v2f vert(appdata v)
            {
                v2f o;
                
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.pos = UnityObjectToClipPos(v.vertex);
                o.refl = ComputeNonStereoScreenPos(o.pos);
                o.uv = TRANSFORM_TEX(v.uv, _AlphaMask);

                o.hueRotation = GetHueRotation(_HueShift);

                return o;
            }
            
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

                // hsv changes
                refl = ApplyHSVChangesToRGB(refl, i.hueRotation, fixed2(_Saturation, 1));

                // transparency override to make avatars/objects semi transparent if needed
                refl.a *= _ReflectAlpha;

                // lastly apply alpha mask
                refl.a *= UNITY_SAMPLE_TEX2D(_AlphaMask, i.uv);
                return refl;
            }
            ENDCG
        }
    }
}