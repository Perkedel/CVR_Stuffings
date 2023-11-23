// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:2,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32597,y:32711|diff-2-RGB,spec-42-OUT,gloss-21-OUT,normal-4-RGB,emission-27-OUT,amdfl-34-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33324,y:32486,ptlb:Main_Texture,ptin:_Main_Texture,tex:592e345a7e3d70d49b45ab84d06dbc7f,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4,x:32955,y:32796,ptlb:Normal_Texture,ptin:_Normal_Texture,tex:192273858bf451c4f910fb14c3ca6f53,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Slider,id:20,x:33536,y:32681,ptlb:Spec,ptin:_Spec,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:21,x:33536,y:32772,ptlb:Gloss,ptin:_Gloss,min:0,cur:0.3,max:1;n:type:ShaderForge.SFN_Fresnel,id:23,x:33323,y:32989|EXP-24-OUT;n:type:ShaderForge.SFN_Vector1,id:24,x:33485,y:33008,v1:4;n:type:ShaderForge.SFN_Divide,id:25,x:33140,y:32989|A-23-OUT,B-26-OUT;n:type:ShaderForge.SFN_Slider,id:26,x:33347,y:33147,ptlb:Edge_Light,ptin:_Edge_Light,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Multiply,id:27,x:32955,y:32970|A-2-RGB,B-25-OUT;n:type:ShaderForge.SFN_Multiply,id:34,x:33032,y:32400|A-2-RGB,B-35-OUT;n:type:ShaderForge.SFN_Slider,id:35,x:33307,y:32387,ptlb:Ambient,ptin:_Ambient,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:42,x:32955,y:32629|A-56-RGB,B-20-OUT;n:type:ShaderForge.SFN_Color,id:56,x:33140,y:32629,ptlb:Spec_Color,ptin:_Spec_Color,glob:False,c1:0.9944219,c2:1,c3:0.5955882,c4:1;proporder:2-4-56-20-21-26-35;pass:END;sub:END;*/

Shader "PQ/PQ_Ribbon" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "black" {}
        _Normal_Texture ("Normal_Texture", 2D) = "black" {}
        _Spec_Color ("Spec_Color", Color) = (0.9944219,1,0.5955882,1)
        _Spec ("Spec", Range(0, 1)) = 1
        _Gloss ("Gloss", Range(0, 1)) = 0.3
        _Edge_Light ("Edge_Light", Range(0, 1)) = 0.7
        _Ambient ("Ambient", Range(0, 1)) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _Spec;
            uniform float _Gloss;
            uniform float _Edge_Light;
            uniform float _Ambient;
            uniform float4 _Spec_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_196 = i.uv0;
                float3 normalLocal = tex2D(_Normal_Texture,TRANSFORM_TEX(node_196.rg, _Normal_Texture)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_196.rg, _Main_Texture));
                float3 emissive = (node_2.rgb*(pow(1.0-max(0,dot(normalDirection, viewDirection)),4.0)/_Edge_Light));
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = (_Spec_Color.rgb*_Spec);
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight += (node_2.rgb*_Ambient); // Diffuse Ambient Light
                finalColor += diffuseLight * node_2.rgb;
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _Spec;
            uniform float _Gloss;
            uniform float _Edge_Light;
            uniform float4 _Spec_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_197 = i.uv0;
                float3 normalLocal = tex2D(_Normal_Texture,TRANSFORM_TEX(node_197.rg, _Normal_Texture)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = (_Spec_Color.rgb*_Spec);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_197.rg, _Main_Texture));
                finalColor += diffuseLight * node_2.rgb;
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
