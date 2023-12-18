Shader "Tsukikomori/Spectra/Spectra"
{
    Properties
    {
        [Header(Texture)]
        _SpectrogramRenTex ("Spectrogram Custom Render Texture", 2D) = "white" {}
        
        [Header(Color)]
        [Space(10)]
        _ColorLo("Color(Low)", Color) = (0,0,1,1)
        _ColorHi("Color(High)", Color) = (0,1,0,1)
        _ColorGrad("Grad", Float) = 16
        
        [Header(Scale)]
        [Space(10)]
        _ScaleXZ("Scale XZ", Float) = 0.5
        _ScaleY("Scale Y", Float) = 0.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull OFF
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float amplitude : TEXCOORD1;

                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _SpectrogramRenTex;
            float4 _SpectrogramRenTex_ST;

            float4 _ColorLo;
            float4 _ColorHi;
            float _ColorGrad;

            float _ScaleXZ;
            float _ScaleY;

            v2f vert (appdata v)
            {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


                // 生の頂点座標と1/128へalignした座標を取得
                float4 pos = v.vertex;
                float4 posAligned = pos;
                posAligned.xz = trunc(v.vertex.xz*128.)/128.;

                // AudioLink DFTの直近128回の結果を高さに代入
                float amplitude = tex2Dlod(_SpectrogramRenTex, float4(posAligned.xz + 1/256.,0,0)).g;
                amplitude *= _ScaleY;

                // 各四角メッシュのスケールとローカル位置を設定
                float scale = 0.5;
                float4 posScaled = lerp(posAligned, pos, _ScaleXZ) + float4(0, amplitude, 0, 0);


                o.vertex = UnityObjectToClipPos(posScaled);
                o.uv = TRANSFORM_TEX(v.uv, _SpectrogramRenTex);
                o.amplitude = amplitude;

                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                float4 col = lerp(_ColorLo, _ColorHi, saturate(i.amplitude * _ColorGrad));

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
