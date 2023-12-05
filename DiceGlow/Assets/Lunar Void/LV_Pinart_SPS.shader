// This shader is property of Lunar | Void, made to update Rollthered's pinart shader found here:
// https://discord.gg/construct-1024-vrchat-rollthered-762908352493256714

// If you'd like to contact me, you can reach me on Discord (lunarvoid), Twitter (@Lunar__Void)
// or via email (lunarvoidinquiries@gmail.com).
// Feel free to also join my discord server: https://discord.gg/hqkEDCdptz 

Shader "Rollthered/LV Pinart"
{
    Properties
    {
        [NoScaleOffset]_DisplacementRT      ("Displacement Render Texture", 2D)         = "black" {}
        _DisplacementDepth                  ("Displacement Distance", Range(0, 0.2))    = 0.0
        [Toggle]_ForceCubeMap               ("Force Cube Map?", float)                  = 0
        [NoScaleOffset]_CubeMap             ("Cube Map", CUBE)                          = "black" {}
        _CubemapBlur                        ("Cubemap Blur", Range(0, 1))               = 0.05
        _CubeSaturation                     ("Cubemap Saturation", Range(0, 2))         = 1.0
        _CubeBrightness                     ("Cubemap Brightness", Range(0, 2))         = 1.0
        [NoScaleOffset]_PinTexture          ("Pin Background Texture", 2D)              = "white" {}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _DisplacementRT, _PinTexture;
            float4 _PinTexture_ST;
            float _DisplacementDepth, _ForceCubeMap, _CubemapBlur, _CubeSaturation, _CubeBrightness;
            samplerCUBE _CubeMap;


            struct appdata
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex   : POSITION;
                float3 normal   : NORMAL;
                float2 uv       : TEXCOORD0;
            };

            struct v2f
            {
                UNITY_VERTEX_OUTPUT_STEREO
                float4 vertex   : SV_POSITION;
                float3 normal   : NORMAL;
                float2 uv       : TEXCOORD0;

                float3 normalWorldDir   : TEXCOORD1;
                float3 viewDir          : TEXCOORD2;
            };

            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_INITIALIZE_OUTPUT( v2f, o );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );


                // Displacement from RT
                float Displacement = tex2Dlod(_DisplacementRT, float4(v.uv.xy, 0.0, 1.0));
                v.vertex.z += (Displacement * _DisplacementDepth);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                o.normalWorldDir = UnityObjectToWorldNormal(v.normal);
                o.viewDir = WorldSpaceViewDir(v.vertex);
                return o;
            }


        // Functions
            // Sourced originally from: https://www.chilliant.com/rgb2hsv.html
            float3 RGB_Saturation(float3 RBG_IN, float Set_Saturation)
            {
                float Epsilon = 1e-10;

                // RGB to HCV
                float4 HCV_Check = (RBG_IN.g < RBG_IN.b) ? float4(RBG_IN.bg, -1.0, 2.0/3.0) : float4(RBG_IN.gb, 0.0, -1.0/3.0);
                float4 HCV_Value = (RBG_IN.r < HCV_Check.x) ? float4(HCV_Check.xyw, RBG_IN.r) : float4(RBG_IN.r, HCV_Check.yzx);
                float HCV_Chroma = HCV_Value.x - min(HCV_Value.w, HCV_Value.y);
                float HCV_Hue = abs((HCV_Value.w - HCV_Value.y) / (6 * HCV_Chroma + Epsilon) + HCV_Value.z);
                float3 HCV = float3(HCV_Hue, HCV_Chroma, HCV_Value.x);

                // HCV to Saturation
                float Saturation = HCV.y / (HCV.z + Epsilon);
                Saturation *= Set_Saturation;

                // Hue to RGB
                float3 Hue_RGB = float3(0.0, 0.0, 0.0);
                Hue_RGB.x = abs(HCV.x * 6 - 3) - 1;
                Hue_RGB.y = 2 - abs(HCV.x * 6 - 2);
                Hue_RGB.z = 2 - abs(HCV.x * 6 - 4);

                Hue_RGB = saturate(Hue_RGB);

                // HSV to RGB
                float3 RGB_OUT = float3(0.0, 0.0, 0.0);
                RGB_OUT = ((Hue_RGB - 1) * Saturation + 1) * HCV.z;

                return RGB_OUT;
            }
        // End Functions


            fixed4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( i );

                float4 Result = float4(1.0, 1.0, 1.0, 1.0);
                Result.rgb = tex2D(_PinTexture, i.uv);

                // Reflections
                half3 WorldReflection = reflect(-i.viewDir, i.normalWorldDir);
                if (_ForceCubeMap)
                {
                    Result.rgb = Result.rgb *+ texCUBElod(_CubeMap, float4(WorldReflection, (_CubemapBlur * 10)));
                }
                else
                {
                    Result.rgb = Result.rgb *+ DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, WorldReflection, (_CubemapBlur * 10)), unity_SpecCube0_HDR * 2);
                }

                Result.rgb *= _CubeBrightness;
                Result.rgb = RGB_Saturation(Result.rgb, _CubeSaturation);

                return Result;
            }
            ENDCG
        }
    }
}
