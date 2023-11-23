// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32507,y:32693,cmnt:su_PQ_TransBlue|diff-2-RGB,spec-3-RGB,gloss-4-OUT,emission-36-OUT,alpha-2-A;n:type:ShaderForge.SFN_Tex2d,id:2,x:33827,y:32379,ptlb:Main_Texture,ptin:_Main_Texture,tex:23c24b333995e0c47803ec0c3d97eeda,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:3,x:32822,y:33172,ptlb:Spec_Texture,ptin:_Spec_Texture,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Slider,id:4,x:32958,y:33231,ptlb:Spec_zone,ptin:_Spec_zone,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:7,x:33349,y:33071|A-9-OUT,B-8-RGB;n:type:ShaderForge.SFN_Cubemap,id:8,x:33556,y:33126,ptlb:CubeMap,ptin:_CubeMap|DIR-180-XYZ;n:type:ShaderForge.SFN_Slider,id:9,x:33541,y:33037,ptlb:Reflect_power,ptin:_Reflect_power,min:0,cur:0.3,max:1;n:type:ShaderForge.SFN_Add,id:36,x:32887,y:32747|A-51-OUT,B-7-OUT;n:type:ShaderForge.SFN_Color,id:38,x:33806,y:32629,ptlb:Rim_Color,ptin:_Rim_Color,glob:False,c1:0,c2:0.7882353,c3:0.9960784,c4:1;n:type:ShaderForge.SFN_Multiply,id:39,x:33593,y:32629|A-2-RGB,B-38-RGB;n:type:ShaderForge.SFN_Multiply,id:40,x:33310,y:32659|A-42-OUT,B-39-OUT;n:type:ShaderForge.SFN_Slider,id:42,x:33287,y:32575,ptlb:Rim_power,ptin:_Rim_power,min:0,cur:3,max:6;n:type:ShaderForge.SFN_Fresnel,id:48,x:33343,y:32797|EXP-50-OUT;n:type:ShaderForge.SFN_Slider,id:50,x:33541,y:32903,ptlb:Rim_zone,ptin:_Rim_zone,min:0,cur:1,max:4;n:type:ShaderForge.SFN_Multiply,id:51,x:33136,y:32726|A-40-OUT,B-48-OUT;n:type:ShaderForge.SFN_NormalVector,id:179,x:33940,y:33131,pt:False;n:type:ShaderForge.SFN_Transform,id:180,x:33748,y:33155,tffrom:3,tfto:0|IN-179-OUT;proporder:2-38-42-50-8-9-3-4;pass:END;sub:END;*/

Shader "PQ/PQ_TransBlue" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "white" {}
        _Rim_Color ("Rim_Color", Color) = (0,0.7882353,0.9960784,1)
        _Rim_power ("Rim_power", Range(0, 6)) = 3
        _Rim_zone ("Rim_zone", Range(0, 4)) = 1
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _Reflect_power ("Reflect_power", Range(0, 1)) = 0.3
        _Spec_Texture ("Spec_Texture", 2D) = "black" {}
        _Spec_zone ("Spec_zone", Range(0, 1)) = 0
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
            ZWrite Off
            
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
            uniform sampler2D _Spec_Texture; uniform float4 _Spec_Texture_ST;
            uniform float _Spec_zone;
            uniform samplerCUBE _CubeMap;
            uniform float _Reflect_power;
            uniform float4 _Rim_Color;
            uniform float _Rim_power;
            uniform float _Rim_zone;
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
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float2 node_230 = i.uv0;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_230.rg, _Main_Texture));
                float3 emissive = (((_Rim_power*(node_2.rgb*_Rim_Color.rgb))*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Rim_zone))+(_Reflect_power*texCUBE(_CubeMap,mul( float4(i.normalDir,0), UNITY_MATRIX_V ).xyz.rgb).rgb));
///////// Gloss:
                float gloss = _Spec_zone;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = tex2D(_Spec_Texture,TRANSFORM_TEX(node_230.rg, _Spec_Texture)).rgb;
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * node_2.rgb;
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,node_2.a);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
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
            uniform sampler2D _Spec_Texture; uniform float4 _Spec_Texture_ST;
            uniform float _Spec_zone;
            uniform samplerCUBE _CubeMap;
            uniform float _Reflect_power;
            uniform float4 _Rim_Color;
            uniform float _Rim_power;
            uniform float _Rim_zone;
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
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
///////// Gloss:
                float gloss = _Spec_zone;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float2 node_231 = i.uv0;
                float3 specularColor = tex2D(_Spec_Texture,TRANSFORM_TEX(node_231.rg, _Spec_Texture)).rgb;
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_231.rg, _Main_Texture));
                finalColor += diffuseLight * node_2.rgb;
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * node_2.a,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
