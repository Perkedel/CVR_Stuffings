Shader "JillTheSomething/Blit Exponential"
{
    Properties
    {
        _Src ("Source", 2D) = "white" {}
        _Dest ("Destination", 2D) = "white" {}
        _Decay ("Decay", Range(1,1.5)) = 1.1
        _Threshold ("Threshold", Range(0, 1)) = 0.2
        [ToggleOff] _RChannel ("Combined Channel", float) = 0
        [Toggle] _GChannel ("Source Channel", float) = 0
        [Toggle] _BChannel ("Trail Channel", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry-1000"}
        LOD 100

        Pass
        {
            ZTest Always
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
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };

            sampler2D _Src;
            float4 _Src_ST;
            sampler2D _Dest;
            float4 _Dest_ST;
            float _Decay;
            float _Threshold;
            float _RChannel;
            float _GChannel;
            float _BChannel;

            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _Src);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed src_depth = tex2D(_Src, i.uv).r;
                //fixed dest_depth = tex2D(_Dest, i.uv).r * (1-_Decay); // Linear Decay
                fixed dest_depth = pow(tex2D(_Dest, i.uv).r, _Decay); // Exponential Decay
                if(dest_depth < _Threshold) dest_depth = 0;
                if(dest_depth < src_depth) dest_depth = src_depth;
                if(dest_depth > 1-_Threshold) dest_depth = 1-_Threshold-0.01;
                fixed4 final_color = fixed4(saturate(dest_depth)*_RChannel, src_depth*_GChannel, (dest_depth-src_depth)*_BChannel, 0);
                return final_color;
            }
            ENDCG
        }
    }
}
