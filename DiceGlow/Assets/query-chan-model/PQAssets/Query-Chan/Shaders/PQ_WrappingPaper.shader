// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:2,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32524,y:32715|diff-145-OUT,spec-4-OUT,gloss-15-OUT,normal-115-OUT,emission-146-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33285,y:32564,ptlb:Main_Texture,ptin:_Main_Texture,tex:32c7815ef3d68b245aa82415ca645769,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:4,x:33314,y:32743,ptlb:spec,ptin:_spec,min:0,cur:0.6,max:1;n:type:ShaderForge.SFN_Tex2d,id:6,x:33149,y:32941,ptlb:Normal_Texture,ptin:_Normal_Texture,tex:a33c997597636ce4d91c2dd884c3f86c,ntxv:3,isnm:False;n:type:ShaderForge.SFN_Slider,id:15,x:33314,y:32839,ptlb:gross,ptin:_gross,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_Slider,id:87,x:33100,y:33214,ptlb:Normal_area,ptin:_Normal_area,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Vector3,id:114,x:33164,y:33095,v1:0.5,v2:0.5,v3:1;n:type:ShaderForge.SFN_Lerp,id:115,x:32884,y:32959|A-6-RGB,B-114-OUT,T-87-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:143,x:33041,y:32642,ptlb:Unlit On/Off,ptin:_UnlitOnOff,on:True;n:type:ShaderForge.SFN_OneMinus,id:144,x:33041,y:32503|IN-143-OUT;n:type:ShaderForge.SFN_Multiply,id:145,x:32820,y:32503|A-144-OUT,B-2-RGB;n:type:ShaderForge.SFN_Multiply,id:146,x:32820,y:32624|A-143-OUT,B-2-RGB;proporder:2-6-4-15-87-143;pass:END;sub:END;*/

Shader "PQ/PQ_WrappingPaper" {
    Properties {
        _Main_Texture ("Main_Texture", 2D) = "white" {}
        _Normal_Texture ("Normal_Texture", 2D) = "bump" {}
        _spec ("spec", Range(0, 1)) = 0.6
        _gross ("gross", Range(0, 1)) = 0.2
        _Normal_area ("Normal_area", Range(0, 1)) = 0.5
        [MaterialToggle] _UnlitOnOff ("Unlit On/Off", Float ) = 0
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
            uniform float _spec;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _gross;
            uniform float _Normal_area;
            uniform fixed _UnlitOnOff;
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
                float2 node_156 = i.uv0;
                float3 normalLocal = lerp(tex2D(_Normal_Texture,TRANSFORM_TEX(node_156.rg, _Normal_Texture)).rgb,float3(0.5,0.5,1),_Normal_area);
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
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_156.rg, _Main_Texture));
                float3 emissive = (_UnlitOnOff*node_2.rgb);
///////// Gloss:
                float gloss = _gross;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_spec,_spec,_spec);
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * ((1.0 - _UnlitOnOff)*node_2.rgb);
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
            uniform float _spec;
            uniform sampler2D _Normal_Texture; uniform float4 _Normal_Texture_ST;
            uniform float _gross;
            uniform float _Normal_area;
            uniform fixed _UnlitOnOff;
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
                float2 node_157 = i.uv0;
                float3 normalLocal = lerp(tex2D(_Normal_Texture,TRANSFORM_TEX(node_157.rg, _Normal_Texture)).rgb,float3(0.5,0.5,1),_Normal_area);
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
                float gloss = _gross;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_spec,_spec,_spec);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_2 = tex2D(_Main_Texture,TRANSFORM_TEX(node_157.rg, _Main_Texture));
                finalColor += diffuseLight * ((1.0 - _UnlitOnOff)*node_2.rgb);
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
