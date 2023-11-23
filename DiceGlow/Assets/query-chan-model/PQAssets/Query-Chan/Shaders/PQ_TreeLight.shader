// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:2,dpts:2,wrdp:True,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32094,y:32585|emission-123-OUT,alpha-64-A;n:type:ShaderForge.SFN_TexCoord,id:2,x:33381,y:32647,uv:1;n:type:ShaderForge.SFN_Tex2d,id:3,x:33023,y:32791,ptlb:Bright_Texture,ptin:_Bright_Texture,tex:8e254ad5d3bccb144a1c9c686e22e7a7,ntxv:2,isnm:False|UVIN-27-UVOUT;n:type:ShaderForge.SFN_Panner,id:27,x:33200,y:32791,spu:0,spv:1|UVIN-2-UVOUT,DIST-65-OUT;n:type:ShaderForge.SFN_Time,id:46,x:34259,y:32821;n:type:ShaderForge.SFN_ValueProperty,id:50,x:34259,y:32965,ptlb:Blink Speed,ptin:_BlinkSpeed,glob:False,v1:4;n:type:ShaderForge.SFN_Multiply,id:51,x:34084,y:32821|A-46-TSL,B-50-OUT;n:type:ShaderForge.SFN_Vector1,id:59,x:33567,y:33036,v1:0.25;n:type:ShaderForge.SFN_Multiply,id:60,x:33567,y:32877|A-63-OUT,B-59-OUT;n:type:ShaderForge.SFN_Vector1,id:61,x:33886,y:33020,v1:4;n:type:ShaderForge.SFN_Multiply,id:62,x:33886,y:32877|A-51-OUT,B-61-OUT;n:type:ShaderForge.SFN_Floor,id:63,x:33726,y:32877|IN-62-OUT;n:type:ShaderForge.SFN_Tex2d,id:64,x:32849,y:32602,ptlb:Main_Texture,ptin:_Main_Texture,tex:fe095e7f36d58fb499b97118948dba1f,ntxv:2,isnm:False;n:type:ShaderForge.SFN_SwitchProperty,id:65,x:33381,y:32814,ptlb:Smooth_Light,ptin:_Smooth_Light,on:False|A-60-OUT,B-51-OUT;n:type:ShaderForge.SFN_ConstantClamp,id:108,x:32849,y:32791,min:0.25,max:1|IN-3-RGB;n:type:ShaderForge.SFN_Multiply,id:118,x:32571,y:32603|A-64-RGB,B-108-OUT;n:type:ShaderForge.SFN_Slider,id:122,x:32431,y:32893,ptlb:Brightness,ptin:_Brightness,min:0.5,cur:2,max:3;n:type:ShaderForge.SFN_Multiply,id:123,x:32372,y:32625|A-118-OUT,B-122-OUT,C-108-OUT;n:type:ShaderForge.SFN_Vector1,id:222,x:33729,y:32719,v1:1;proporder:64-3-50-65-122;pass:END;sub:END;*/

Shader "PQ/PQ_TreeLight" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "black" {}
        _Bright_Texture ("Bright_Texture", 2D) = "black" {}
        _BlinkSpeed ("Blink Speed", Float ) = 4
        [MaterialToggle] _Smooth_Light ("Smooth_Light", Float ) = 0
        _Brightness ("Brightness", Range(0.5, 3)) = 2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _Bright_Texture; uniform float4 _Bright_Texture_ST;
            uniform float _BlinkSpeed;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform fixed _Smooth_Light;
            uniform float _Brightness;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float2 node_234 = i.uv0;
                float4 node_64 = tex2D(_Main_Texture,TRANSFORM_TEX(node_234.rg, _Main_Texture));
                float4 node_46 = _Time + _TimeEditor;
                float node_51 = (node_46.r*_BlinkSpeed);
                float2 node_27 = (i.uv1.rg+lerp( (floor((node_51*4.0))*0.25), node_51, _Smooth_Light )*float2(0,1));
                float3 node_108 = clamp(tex2D(_Bright_Texture,TRANSFORM_TEX(node_27, _Bright_Texture)).rgb,0.25,1);
                float3 emissive = ((node_64.rgb*node_108)*_Brightness*node_108);
                float3 finalColor = emissive;
/// Final Color:
                return fixed4(finalColor,node_64.a);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
