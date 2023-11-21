// Copyright DomNomNom 2023

Shader "DomNomNom/InteractionLayersPreview" {
    Properties {
        _Element ("_Element", 2D) = "white" {}
        _ChoiceElement ("Choice Element", Int) = 0   // 0..2
        _ChoiceSize ("Choice Size", Int) = 0         // 0..1
        _ChoiceQuantity ("Choice Quantiy", Int) = 2  // 1..3
        _MaxQuantity ("Max Quantiy", Int) = 3
        _MaxSize ("Max Size", Int) = 2
    }
    SubShader {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
        // ZWrite Off
        Cull back
        Blend one one
        LOD 100

        Pass {

CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

sampler2D _Element;
float4 _Element_ST;
uint _ChoiceElement;
uint _ChoiceSize;
uint _ChoiceQuantity;
uint _MaxQuantity;
uint _MaxSize;

struct appdata  {
    float4 vertex : POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
};

struct v2f  {
    float4 vertex : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    // float2 uv1 : TEXCOORD1;
};

v2f vert (appdata v)  {
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv0 = TRANSFORM_TEX(v.uv0, _Element);
    // o.uv1 = TRANSFORM_TEX(v.uv1, _Element);
    // float theta = .4*sin(_Time.y);
    // float s = sin(theta);
    // float c = cos(theta);
    // o.uv1 -= .5;
    // o.uv1 = float2(
    //     (o.uv1.x * c) - (o.uv1.y * s),
    //     (o.uv1.x * s) + (o.uv1.y * c)
    // );
    // o.uv1 += .5;

    return o;
}

// We use glsl_mod for most calculations because it behaves better
// on negative numbers, and in some situations actually outperforms
// HLSL's modf().
#ifndef glsl_mod
#define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))
#endif

float4 blend(float4 x, float4 y) {
    // return float4(0.5*(lerp(x.rgb, y.rgb, 1-x.a) + lerp(x.rgb, y.rgb, y.a)), saturate(x.a + y.a));
    // return float4(lerp(x.rgb, y.rgb, 1-x.a), saturate(x.a + y.a));
    return float4(lerp(x.rgb, y.rgb, y.a), 1/(1/x.a + 1/y.a));
    // return float4(lerp(x.rgb, y.rgb, y.a/(x.a + y.a)), saturate(x.a + y.a));
}


float4 frag(v2f i) : SV_Target  {
    float4 col = float4(1,0,0,0);
    float2 uv = i.uv0;

    uv.y *= _MaxQuantity;
    if (uv.y < int(_MaxQuantity) - int(_ChoiceQuantity)) uv.y = 0;
    uv.y = glsl_mod(uv.y, 1.f);
    // if (uv.y > 1) uv.y -= 1;
    // if (uv.y > 1) uv.y -= 1;

    uv -= .5;
    uv *= lerp(float(_MaxSize)*3, 1., float(_ChoiceSize));
    uv += .5;
    uv = saturate(uv);
    // uv.y = clamp(uv.y, 0, 1);

    uv *= .5;
    uv.y += .5;
    uv.x += .5*float(_ChoiceElement % 2);
    uv.y += .5*float(_ChoiceElement / 2);



    col = tex2D(_Element, uv);
    // col += tex2D(_Element, i.uv1) * .2;
    col.rgb *= col.a;
    return col;
}

            ENDCG
        }
    }
}
