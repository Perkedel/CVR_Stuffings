// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32559,y:32705,cmnt:su_PQ_HW_Ghost|emission-41-OUT,alpha-15-OUT,olwid-13-OUT,olcol-12-RGB;n:type:ShaderForge.SFN_Color,id:3,x:33022,y:32623,ptlb:out_Color,ptin:_out_Color,glob:False,c1:0.8897059,c2:0.8897059,c3:0.8897059,c4:1;n:type:ShaderForge.SFN_Tex2d,id:4,x:33169,y:32867,ptlb:Face_texture,ptin:_Face_texture,tex:2404f9dd0b1dee447bda241a1de64799,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:5,x:33169,y:32703,ptlb:Face_Color,ptin:_Face_Color,glob:False,c1:0.3882353,c2:0.0627451,c3:0.0627451,c4:1;n:type:ShaderForge.SFN_Fresnel,id:7,x:33393,y:33009;n:type:ShaderForge.SFN_Multiply,id:8,x:33042,y:33111|A-9-OUT,B-90-OUT;n:type:ShaderForge.SFN_Multiply,id:9,x:33210,y:33082|A-7-OUT,B-72-OUT;n:type:ShaderForge.SFN_Color,id:12,x:32869,y:33217,ptlb:in_Color,ptin:_in_Color,glob:False,c1:0.572549,c2:0.3568628,c3:0.5764706,c4:1;n:type:ShaderForge.SFN_Vector1,id:13,x:32869,y:33145,v1:0;n:type:ShaderForge.SFN_Add,id:15,x:32826,y:32928|A-4-R,B-8-OUT;n:type:ShaderForge.SFN_Lerp,id:41,x:32826,y:32765|A-3-RGB,B-5-RGB,T-4-RGB;n:type:ShaderForge.SFN_Vector1,id:72,x:33393,y:33139,v1:3.5;n:type:ShaderForge.SFN_Sin,id:86,x:33576,y:33218|IN-87-TTR;n:type:ShaderForge.SFN_Time,id:87,x:33735,y:33228;n:type:ShaderForge.SFN_Divide,id:88,x:33393,y:33218|A-86-OUT,B-89-OUT;n:type:ShaderForge.SFN_Vector1,id:89,x:33407,y:33353,v1:8;n:type:ShaderForge.SFN_Add,id:90,x:33210,y:33218|A-88-OUT,B-91-OUT;n:type:ShaderForge.SFN_Vector1,id:91,x:33222,y:33353,v1:0.6;proporder:4-5-3-12;pass:END;sub:END;*/

Shader "PQ/PQ_HW_Ghost" {
    Properties {
        _Face_texture ("Face_texture", 2D) = "white" {}
        _Face_Color ("Face_Color", Color) = (0.3882353,0.0627451,0.0627451,1)
        _out_Color ("out_Color", Color) = (0.8897059,0.8897059,0.8897059,1)
        _in_Color ("in_Color", Color) = (0.572549,0.3568628,0.5764706,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _in_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*0.0,1));
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                return fixed4(_in_Color.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float4 _out_Color;
            uniform sampler2D _Face_texture; uniform float4 _Face_texture_ST;
            uniform float4 _Face_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
////// Lighting:
////// Emissive:
                float2 node_98 = i.uv0;
                float4 node_4 = tex2D(_Face_texture,TRANSFORM_TEX(node_98.rg, _Face_texture));
                float3 emissive = lerp(_out_Color.rgb,_Face_Color.rgb,node_4.rgb);
                float3 finalColor = emissive;
                float4 node_87 = _Time + _TimeEditor;
/// Final Color:
                return fixed4(finalColor,(node_4.r+(((1.0-max(0,dot(normalDirection, viewDirection)))*3.5)*((sin(node_87.a)/8.0)+0.6))));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
