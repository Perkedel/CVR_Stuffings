Shader "Tsukikomori/Spectra/internal/Spectra_rt"
{
    CGINCLUDE

    #include "UnityCustomRenderTexture.cginc"
    #include "Packages/com.llealloo.audiolink/Runtime/Shaders/AudioLink.cginc"

    float4 frag(v2f_customrendertexture i) : SV_Target
    {
        float2 uv = i.globalTexcoord;

        float dv = 1. / _CustomRenderTextureHeight;

        float4 col;
        float4 colBefore = tex2D(_SelfTexture2D, uv+float2(0, -dv));

        col = colBefore;

        if(uv.y<1/128.)
        {
            col = AudioLinkLerpMultiline( ALPASS_DFT + uint2( uv.x * AUDIOLINK_ETOTALBINS, 0 ));
        }

        return col;
    }

    ENDCG

    SubShader
    {
        Cull Off
        ZWrite Off
        ZTest Always

        Pass
        {
            Name "Update"
            CGPROGRAM
            #pragma vertex CustomRenderTextureVertexShader
            #pragma fragment frag
            ENDCG
        }
    }

}