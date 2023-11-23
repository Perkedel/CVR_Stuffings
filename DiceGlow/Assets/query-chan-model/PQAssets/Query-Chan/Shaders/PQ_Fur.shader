// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:True,ufog:True,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32541,y:32739,cmnt:su_PQ_Fur_in|diff-107-OUT,emission-54-OUT,alpha-151-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33557,y:32643,ptlb:Main_Texture,ptin:_Main_Texture,tex:32c7815ef3d68b245aa82415ca645769,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ToggleProperty,id:30,x:33557,y:32559,ptlb:Unlit_On/Off,ptin:_Unlit_OnOff,on:True;n:type:ShaderForge.SFN_Multiply,id:53,x:33087,y:32521|A-2-RGB,B-68-OUT;n:type:ShaderForge.SFN_Multiply,id:54,x:33087,y:32656|A-2-RGB,B-30-OUT;n:type:ShaderForge.SFN_OneMinus,id:68,x:33321,y:32485|IN-30-OUT;n:type:ShaderForge.SFN_Multiply,id:107,x:32912,y:32504|A-108-OUT,B-53-OUT;n:type:ShaderForge.SFN_Slider,id:108,x:33178,y:32405,ptlb:Brightness,ptin:_Brightness,min:1,cur:1,max:4;n:type:ShaderForge.SFN_Fresnel,id:112,x:33595,y:33086|NRM-113-OUT,EXP-134-OUT;n:type:ShaderForge.SFN_NormalVector,id:113,x:33787,y:33086,pt:False;n:type:ShaderForge.SFN_ValueProperty,id:114,x:33314,y:33296,ptlb:Edge_pow_in,ptin:_Edge_pow_in,glob:False,v1:1.5;n:type:ShaderForge.SFN_OneMinus,id:124,x:33125,y:33148|IN-144-OUT;n:type:ShaderForge.SFN_Slider,id:134,x:33787,y:33249,ptlb:Edge_pow,ptin:_Edge_pow,min:0,cur:4,max:4;n:type:ShaderForge.SFN_Multiply,id:144,x:33296,y:33148|A-112-OUT,B-114-OUT;n:type:ShaderForge.SFN_Tex2d,id:150,x:33557,y:32830,ptlb:Hairball_Texture,ptin:_Hairball_Texture,tex:953c2aff816298d40a42f6f471b1c334,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Add,id:151,x:32805,y:32948|A-176-OUT,B-124-OUT;n:type:ShaderForge.SFN_Multiply,id:172,x:33296,y:32907|A-112-OUT,B-173-OUT;n:type:ShaderForge.SFN_ValueProperty,id:173,x:33296,y:33058,ptlb:Edge_pow_out,ptin:_Edge_pow_out,glob:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:176,x:32997,y:32861|A-150-R,B-172-OUT;proporder:2-150-30-108-134-114-173;pass:END;sub:END;*/

Shader "PQ/PQ_Fur" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "white" {}
        _Hairball_Texture ("Hairball_Texture", 2D) = "black" {}
        [MaterialToggle] _Unlit_OnOff ("Unlit_On/Off", Float ) = 0
        _Brightness ("Brightness", Range(1, 4)) = 1
        _Edge_pow ("Edge_pow", Range(0, 4)) = 4
        _Edge_pow_in ("Edge_pow_in", Float ) = 1.5
        _Edge_pow_out ("Edge_pow_out", Float ) = 2
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform fixed _Unlit_OnOff;
            uniform float _Brightness;
            uniform float _Edge_pow_in;
            uniform float _Edge_pow;
            uniform sampler2D _Hairball_Texture; uniform float4 _Hairball_Texture_ST;
            uniform float _Edge_pow_out;
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
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float2 node_185 = i.uv0;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_185.rg, _Main_Texture));
                float3 emissive = (node_2.rgb*_Unlit_OnOff);
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * (_Brightness*(node_2.rgb*(1.0 - _Unlit_OnOff)));
                finalColor += emissive;
                float node_112 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),_Edge_pow);
/// Final Color:
                return fixed4(finalColor,((tex2D(_Hairball_Texture,TRANSFORM_TEX(node_185.rg, _Hairball_Texture)).r*(node_112*_Edge_pow_out))+(1.0 - (node_112*_Edge_pow_in))));
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform fixed _Unlit_OnOff;
            uniform float _Brightness;
            uniform float _Edge_pow_in;
            uniform float _Edge_pow;
            uniform sampler2D _Hairball_Texture; uniform float4 _Hairball_Texture_ST;
            uniform float _Edge_pow_out;
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
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float2 node_186 = i.uv0;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_186.rg, _Main_Texture));
                finalColor += diffuseLight * (_Brightness*(node_2.rgb*(1.0 - _Unlit_OnOff)));
                float node_112 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),_Edge_pow);
/// Final Color:
                return fixed4(finalColor * ((tex2D(_Hairball_Texture,TRANSFORM_TEX(node_186.rg, _Hairball_Texture)).r*(node_112*_Edge_pow_out))+(1.0 - (node_112*_Edge_pow_in))),0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
