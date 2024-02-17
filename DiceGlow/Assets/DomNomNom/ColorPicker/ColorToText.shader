// Copyright DomNomNom 2023

Shader "DomNomNom/ColorToText" {
    Properties {
        _FontTexture ("Font Texture", 2D) = "white" {}
        _RenderTexture ("Render Texture", 2D) = "blue" {}
        _SamplePixelPos("_SamplePixelPos", Vector) = (64, 64, 0, 0)
    }
    SubShader {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha

        // ZWrite Off
        // Cull off
        // Blend one one
        LOD 100

        Pass {

CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

sampler2D _FontTexture;
float4 _FontTexture_ST;

sampler2D _RenderTexture;
// float4 _RenderTexture_ST;
float4 _RenderTexture_TexelSize;

float2 _SamplePixelPos;

struct appdata  {
    float4 vertex : POSITION;
    float2 uv0 : TEXCOORD0;
};

struct v2f  {
    float4 vertex : SV_POSITION;
    float2 uv0 : TEXCOORD0;
};

v2f vert (appdata v)  {
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv0 = TRANSFORM_TEX(v.uv0, _FontTexture);
    return o;
}

#ifndef glsl_mod
#define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))
#endif

#define GLYPHS_PER_UV 16.
#define CHAR_HASH (16*2 + 3)
#define CHAR_ZERO (16*3)
#define CHAR_DOT (16*2 + 14)
#define CHAR_A (16*4 + 1   )
#define CHAR_B (16*4 + 2   )
#define CHAR_C (16*4 + 3   )
#define CHAR_D (16*4 + 4   )
#define CHAR_E (16*4 + 5   )
#define CHAR_F (16*4 + 6   )
#define CHAR_G (16*4 + 7   )
#define CHAR_H (16*4 + 8   )
#define CHAR_I (16*4 + 9   )
#define CHAR_J (16*4 + 10  )
#define CHAR_K (16*4 + 11  )
#define CHAR_L (16*4 + 12  )
#define CHAR_M (16*4 + 13  )
#define CHAR_N (16*4 + 14  )
#define CHAR_O (16*4 + 15  )
#define CHAR_P (16*5 + 0   )
#define CHAR_Q (16*5 + 1   )
#define CHAR_R (16*5 + 2   )
#define CHAR_S (16*5 + 3   )
#define CHAR_T (16*5 + 4   )
#define CHAR_U (16*5 + 5   )
#define CHAR_V (16*5 + 6   )
#define CHAR_W (16*5 + 7   )
#define CHAR_X (16*5 + 8   )
#define CHAR_Y (16*5 + 9   )
#define CHAR_Z (16*5 + 10  )

float character(float2 pos, int c) {
    if (pos.x<0.|| pos.x>1. || pos.y<0.|| pos.y>1.) return 0;
    float2 c2 = float2(
        frac(float(c)/GLYPHS_PER_UV),
        (GLYPHS_PER_UV-1)/(GLYPHS_PER_UV) - floor(c/GLYPHS_PER_UV)/GLYPHS_PER_UV
    );
    // See this for an explanation for this texture
    // https://shadertoyunofficial.wordpress.com/2016/07/20/special-shadertoy-features/
    return max(1e-5, tex2D(_FontTexture, pos/GLYPHS_PER_UV + c2).x);
}

int get_digit_base10(float x, float place) {
    return CHAR_ZERO + int(glsl_mod(x/place, 10));
}
int get_last_digit_base16(int x) {
    x = glsl_mod(x, 16);
    if (x<10) return CHAR_ZERO + x;
    return CHAR_A + x-10;
}

float3 RGBToHSV(float3 c) {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

#define TEXT_GRIDSIZE 16
float4 frag (v2f i) : SV_Target  {
    float4 col = float4(0,0,0,0);
    // col = tex2D(_FontTexture, i.uv0);
    // col.rgb = sample_grad_dist(i.uv0, 1).zzz;
    float scl = 1.2;
    // col.rgb = smoothstep(0.5*scl, -0.5*scl, sample_grad_dist(i.uv0, 1).z);
    float4 sample = tex2D(_RenderTexture, (_SamplePixelPos + 0.5) * _RenderTexture_TexelSize.xy);
    float2 uv = i.uv0 * TEXT_GRIDSIZE;

    if (abs(i.uv0.x-.5) + abs(i.uv0.y-.666) < .1) return sample;

    float acc = 0;
    float2 offset;

    offset = float2(1.2, 6.5); {  // RGB 0..1
        acc += character(uv-float2(-1,2)-offset, CHAR_R);
        acc += character(uv-float2(0,2)-offset, get_digit_base10(sample.r, 1.0));
        acc += character(uv-float2(1,2)-offset, CHAR_DOT);
        acc += character(uv-float2(2,2)-offset, get_digit_base10(sample.r, 0.1));
        acc += character(uv-float2(3,2)-offset, get_digit_base10(sample.r, 0.01));
        acc += character(uv-float2(4,2)-offset, get_digit_base10(sample.r, 0.001));

        acc += character(uv-float2(-1,1)-offset, CHAR_G);
        acc += character(uv-float2(0,1)-offset, get_digit_base10(sample.g, 1.0));
        acc += character(uv-float2(1,1)-offset, CHAR_DOT);
        acc += character(uv-float2(2,1)-offset, get_digit_base10(sample.g, 0.1));
        acc += character(uv-float2(3,1)-offset, get_digit_base10(sample.g, 0.01));
        acc += character(uv-float2(4,1)-offset, get_digit_base10(sample.g, 0.001));

        acc += character(uv-float2(-1,0)-offset, CHAR_B);
        acc += character(uv-float2(0,0)-offset, get_digit_base10(sample.b, 1.0));
        acc += character(uv-float2(1,0)-offset, CHAR_DOT);
        acc += character(uv-float2(2,0)-offset, get_digit_base10(sample.b, 0.1));
        acc += character(uv-float2(3,0)-offset, get_digit_base10(sample.b, 0.01));
        acc += character(uv-float2(4,0)-offset, get_digit_base10(sample.b, 0.001));
    }

    offset = float2(6, 1); {  // HSV 0..1
        float3 hsv = RGBToHSV(sample.rgb);
        acc += character(uv-float2(-1,2)-offset, CHAR_H);
        acc += character(uv-float2(0,2)-offset, get_digit_base10(hsv.r, 1.0));
        acc += character(uv-float2(1,2)-offset, CHAR_DOT);
        acc += character(uv-float2(2,2)-offset, get_digit_base10(hsv.r, 0.1));
        acc += character(uv-float2(3,2)-offset, get_digit_base10(hsv.r, 0.01));
        acc += character(uv-float2(4,2)-offset, get_digit_base10(hsv.r, 0.001));

        acc += character(uv-float2(-1,1)-offset, CHAR_S);
        acc += character(uv-float2(0,1)-offset, get_digit_base10(hsv.g, 1.0));
        acc += character(uv-float2(1,1)-offset, CHAR_DOT);
        acc += character(uv-float2(2,1)-offset, get_digit_base10(hsv.g, 0.1));
        acc += character(uv-float2(3,1)-offset, get_digit_base10(hsv.g, 0.01));
        acc += character(uv-float2(4,1)-offset, get_digit_base10(hsv.g, 0.001));

        acc += character(uv-float2(-1,0)-offset, CHAR_V);
        acc += character(uv-float2(0,0)-offset, get_digit_base10(hsv.b, 1.0));
        acc += character(uv-float2(1,0)-offset, CHAR_DOT);
        acc += character(uv-float2(2,0)-offset, get_digit_base10(hsv.b, 0.1));
        acc += character(uv-float2(3,0)-offset, get_digit_base10(hsv.b, 0.01));
        acc += character(uv-float2(4,0)-offset, get_digit_base10(hsv.b, 0.001));
    }

    sample *= 255;

    offset = float2(12, 6.5); {  // RGB 0..255
        acc += character(uv-float2(-1,2)-offset, CHAR_R);
        acc += character(uv-float2(0,2)-offset, get_digit_base10(sample.r, 100.0));
        acc += character(uv-float2(1,2)-offset, get_digit_base10(sample.r, 10.0));
        acc += character(uv-float2(2,2)-offset, get_digit_base10(sample.r, 1.0));

        acc += character(uv-float2(-1,1)-offset, CHAR_G);
        acc += character(uv-float2(0,1)-offset, get_digit_base10(sample.g, 100.0));
        acc += character(uv-float2(1,1)-offset, get_digit_base10(sample.g, 10.0));
        acc += character(uv-float2(2,1)-offset, get_digit_base10(sample.g, 1.0));

        acc += character(uv-float2(-1,0)-offset, CHAR_B);
        acc += character(uv-float2(0,0)-offset, get_digit_base10(sample.b, 100.0));
        acc += character(uv-float2(1,0)-offset, get_digit_base10(sample.b, 10.0));
        acc += character(uv-float2(2,0)-offset, get_digit_base10(sample.b, 1.0));
    }

    offset = float2(4.5, 13); {  // hex
        acc += character(uv-float2(0,0)-offset, CHAR_HASH);
        acc += character(uv-float2(1,0)-offset, get_last_digit_base16(sample.r/16));
        acc += character(uv-float2(2,0)-offset, get_last_digit_base16(sample.r));
        acc += character(uv-float2(3,0)-offset, get_last_digit_base16(sample.g/16));
        acc += character(uv-float2(4,0)-offset, get_last_digit_base16(sample.g));
        acc += character(uv-float2(5,0)-offset, get_last_digit_base16(sample.b/16));
        acc += character(uv-float2(6,0)-offset, get_last_digit_base16(sample.b));
    }


    col.rgba += acc;

    if (acc > 1e-6) col.a = max(col.a, .8);
    return col;
}

            ENDCG
        }
    }
}
