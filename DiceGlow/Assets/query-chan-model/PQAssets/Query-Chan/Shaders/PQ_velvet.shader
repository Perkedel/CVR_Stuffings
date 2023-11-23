// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:1,culm:2,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:31144,y:32419,cmnt:su_PQ_velvet|diff-1224-OUT,spec-1082-OUT,gloss-1074-OUT,normal-1117-OUT,emission-1031-OUT,amdfl-1060-OUT,clip-999-A;n:type:ShaderForge.SFN_Tex2d,id:3,x:33349,y:32648,ptlb:Noise_Texture,ptin:_Noise_Texture,tex:192273858bf451c4f910fb14c3ca6f53,ntxv:3,isnm:False;n:type:ShaderForge.SFN_Multiply,id:11,x:32524,y:32841|A-359-OUT,B-222-OUT;n:type:ShaderForge.SFN_Fresnel,id:84,x:33119,y:32841|EXP-146-OUT;n:type:ShaderForge.SFN_Divide,id:101,x:32934,y:32841|A-84-OUT,B-550-OUT;n:type:ShaderForge.SFN_Multiply,id:122,x:32306,y:32452|A-845-OUT,B-545-OUT;n:type:ShaderForge.SFN_ValueProperty,id:146,x:33119,y:32995,ptlb:Fresnel_Edge,ptin:_Fresnel_Edge,glob:False,v1:2.5;n:type:ShaderForge.SFN_ValueProperty,id:222,x:32524,y:32990,ptlb:Emission_pow,ptin:_Emission_pow,glob:False,v1:0.4;n:type:ShaderForge.SFN_Multiply,id:359,x:32721,y:32841|A-845-OUT,B-101-OUT;n:type:ShaderForge.SFN_Multiply,id:465,x:32192,y:32872|A-845-OUT,B-486-OUT;n:type:ShaderForge.SFN_ValueProperty,id:486,x:32192,y:33030,ptlb:Shadow_Level,ptin:_Shadow_Level,glob:False,v1:2;n:type:ShaderForge.SFN_Blend,id:504,x:33106,y:32463,blmd:10,clmp:True|SRC-505-RGB,DST-3-RGB;n:type:ShaderForge.SFN_Tex2d,id:505,x:33349,y:32474,ptlb:Normal_Texture,ptin:_Normal_Texture,tex:4e562414d56e8f6438b9b24732b213e5,ntxv:3,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:512,x:33349,y:32285,tex:70862f446f1c3db44ac3d41a57f57fe5,ntxv:1,isnm:False|TEX-1174-TEX;n:type:ShaderForge.SFN_ValueProperty,id:544,x:32015,y:32265,ptlb:Gloss_pow,ptin:_Gloss_pow,glob:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:545,x:32306,y:32601,ptlb:Spec_pow,ptin:_Spec_pow,glob:False,v1:1.25;n:type:ShaderForge.SFN_ValueProperty,id:550,x:32934,y:32995,ptlb:Fresnel_pow,ptin:_Fresnel_pow,glob:False,v1:0.3;n:type:ShaderForge.SFN_Slider,id:844,x:33027,y:32185,ptlb:Tone,ptin:_Tone,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_Multiply,id:845,x:33106,y:32285|A-844-OUT,B-512-RGB;n:type:ShaderForge.SFN_Tex2d,id:979,x:32775,y:32105,ptlb:Red_Mask,ptin:_Red_Mask,tex:49a9259ea861d874bba46af212d7e147,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:999,x:32543,y:31943,tex:70862f446f1c3db44ac3d41a57f57fe5,ntxv:0,isnm:False|TEX-1174-TEX;n:type:ShaderForge.SFN_Lerp,id:1009,x:31853,y:32077|A-999-RGB,B-845-OUT,T-979-R;n:type:ShaderForge.SFN_Lerp,id:1031,x:32015,y:32663|A-999-RGB,B-11-OUT,T-979-R;n:type:ShaderForge.SFN_Multiply,id:1060,x:32007,y:32847|A-979-R,B-465-OUT;n:type:ShaderForge.SFN_Multiply,id:1074,x:32015,y:32315|A-544-OUT,B-979-R;n:type:ShaderForge.SFN_Multiply,id:1082,x:32015,y:32449|A-979-R,B-122-OUT;n:type:ShaderForge.SFN_Lerp,id:1117,x:32564,y:32492|A-504-OUT,B-1239-RGB,T-1118-OUT;n:type:ShaderForge.SFN_OneMinus,id:1118,x:32749,y:32611|IN-979-R;n:type:ShaderForge.SFN_Tex2dAsset,id:1174,x:33698,y:31988,ptlb:Main_Texture,ptin:_Main_Texture,glob:False,tex:70862f446f1c3db44ac3d41a57f57fe5;n:type:ShaderForge.SFN_Blend,id:1215,x:31664,y:32133,blmd:1,clmp:True|SRC-979-R,DST-1009-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:1224,x:31490,y:32088,ptlb:Unlit_On/Off,ptin:_Unlit_OnOff,on:True|A-1009-OUT,B-1215-OUT;n:type:ShaderForge.SFN_Color,id:1239,x:32781,y:32446,ptlb:flat,ptin:_flat,glob:False,c1:0.4980392,c2:0.4980392,c3:0.9960784,c4:1;proporder:1174-979-505-3-844-222-146-550-486-545-544-1224-1239;pass:END;sub:END;*/

Shader "PQ/PQ_velvet" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "white" {}
        _Red_Mask ("Red_Mask", 2D) = "white" {}
        _Normal_Texture ("Normal_Texture", 2D) = "bump" {}
        _Noise_Texture ("Noise_Texture", 2D) = "bump" {}
        _Tone ("Tone", Range(0, 1)) = 0.8
        _Emission_pow ("Emission_pow", Float ) = 0.4
        _Fresnel_Edge ("Fresnel_Edge", Float ) = 2.5
        _Fresnel_pow ("Fresnel_pow", Float ) = 0.3
        _Shadow_Level ("Shadow_Level", Float ) = 2
        _Spec_pow ("Spec_pow", Float ) = 1.25
        _Gloss_pow ("Gloss_pow", Float ) = 0
        [MaterialToggle] _Unlit_OnOff ("Unlit_On/Off", Float ) = 0.5019608
        _flat ("flat", Color) = (0.4980392,0.4980392,0.9960784,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            uniform sampler2D _Noise_Texture; uniform float4 _Noise_Texture_ST;
            uniform float _Fresnel_Edge;
            uniform float _Emission_pow;
            uniform float _Shadow_Level;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _Gloss_pow;
            uniform float _Spec_pow;
            uniform float _Fresnel_pow;
            uniform float _Tone;
            uniform sampler2D _Red_Mask; uniform float4 _Red_Mask_ST;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform fixed _Unlit_OnOff;
            uniform float4 _flat;
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
                float2 node_1251 = i.uv0;
                float4 node_979 = tex2D(_Red_Mask,TRANSFORM_TEX(node_1251.rg, _Red_Mask));
                float3 normalLocal = lerp(saturate(( tex2D(_Noise_Texture,TRANSFORM_TEX(node_1251.rg, _Noise_Texture)).rgb > 0.5 ? (1.0-(1.0-2.0*(tex2D(_Noise_Texture,TRANSFORM_TEX(node_1251.rg, _Noise_Texture)).rgb-0.5))*(1.0-tex2D(_Normal_Texture,TRANSFORM_TEX(node_1251.rg, _Normal_Texture)).rgb)) : (2.0*tex2D(_Noise_Texture,TRANSFORM_TEX(node_1251.rg, _Noise_Texture)).rgb*tex2D(_Normal_Texture,TRANSFORM_TEX(node_1251.rg, _Normal_Texture)).rgb) )),_flat.rgb,(1.0 - node_979.r));
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float4 node_999 = tex2D(_Main_Texture,TRANSFORM_TEX(node_1251.rg, _Main_Texture));
                clip(node_999.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float3 node_845 = (_Tone*tex2D(_Main_Texture,TRANSFORM_TEX(node_1251.rg, _Main_Texture)).rgb);
                float3 emissive = lerp(node_999.rgb,((node_845*(pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_Edge)/_Fresnel_pow))*_Emission_pow),node_979.r);
///////// Gloss:
                float gloss = (_Gloss_pow*node_979.r);
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = (node_979.r*(node_845*_Spec_pow));
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight += (node_979.r*(node_845*_Shadow_Level)); // Diffuse Ambient Light
                float3 node_1009 = lerp(node_999.rgb,node_845,node_979.r);
                finalColor += diffuseLight * lerp( node_1009, saturate((node_979.r*node_1009)), _Unlit_OnOff );
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
            uniform sampler2D _Noise_Texture; uniform float4 _Noise_Texture_ST;
            uniform float _Fresnel_Edge;
            uniform float _Emission_pow;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _Gloss_pow;
            uniform float _Spec_pow;
            uniform float _Fresnel_pow;
            uniform float _Tone;
            uniform sampler2D _Red_Mask; uniform float4 _Red_Mask_ST;
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            uniform fixed _Unlit_OnOff;
            uniform float4 _flat;
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
                float2 node_1252 = i.uv0;
                float4 node_979 = tex2D(_Red_Mask,TRANSFORM_TEX(node_1252.rg, _Red_Mask));
                float3 normalLocal = lerp(saturate(( tex2D(_Noise_Texture,TRANSFORM_TEX(node_1252.rg, _Noise_Texture)).rgb > 0.5 ? (1.0-(1.0-2.0*(tex2D(_Noise_Texture,TRANSFORM_TEX(node_1252.rg, _Noise_Texture)).rgb-0.5))*(1.0-tex2D(_Normal_Texture,TRANSFORM_TEX(node_1252.rg, _Normal_Texture)).rgb)) : (2.0*tex2D(_Noise_Texture,TRANSFORM_TEX(node_1252.rg, _Noise_Texture)).rgb*tex2D(_Normal_Texture,TRANSFORM_TEX(node_1252.rg, _Normal_Texture)).rgb) )),_flat.rgb,(1.0 - node_979.r));
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float4 node_999 = tex2D(_Main_Texture,TRANSFORM_TEX(node_1252.rg, _Main_Texture));
                clip(node_999.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
///////// Gloss:
                float gloss = (_Gloss_pow*node_979.r);
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 node_845 = (_Tone*tex2D(_Main_Texture,TRANSFORM_TEX(node_1252.rg, _Main_Texture)).rgb);
                float3 specularColor = (node_979.r*(node_845*_Spec_pow));
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float3 node_1009 = lerp(node_999.rgb,node_845,node_979.r);
                finalColor += diffuseLight * lerp( node_1009, saturate((node_979.r*node_1009)), _Unlit_OnOff );
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCollector"
            Tags {
                "LightMode"="ShadowCollector"
            }
            Cull Off
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCOLLECTOR
            #define SHADOW_COLLECTOR_PASS
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcollector
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_COLLECTOR;
                float2 uv0 : TEXCOORD5;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_COLLECTOR(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                float2 node_1253 = i.uv0;
                float4 node_999 = tex2D(_Main_Texture,TRANSFORM_TEX(node_1253.rg, _Main_Texture));
                clip(node_999.a - 0.5);
                SHADOW_COLLECTOR_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Cull Off
            Offset 1, 1
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _Main_Texture; uniform float4 _Main_Texture_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                float2 node_1254 = i.uv0;
                float4 node_999 = tex2D(_Main_Texture,TRANSFORM_TEX(node_1254.rg, _Main_Texture));
                clip(node_999.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
