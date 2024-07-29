// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:1,fgcg:1,fgcb:1,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32953,y:32712,varname:node_4795,prsc:2|emission-3169-OUT,alpha-9106-OUT;n:type:ShaderForge.SFN_Tex2d,id:64,x:30942,y:33065,ptovrint:False,ptlb:Smoke3,ptin:_Smoke3,varname:node_64,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:410a46a9277384647a83349548c64d25,ntxv:0,isnm:False|UVIN-6756-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:1445,x:30940,y:32697,ptovrint:False,ptlb:Smoke2,ptin:_Smoke2,varname:node_1445,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:fd935f97b68874140a744c2784a6d3c6,ntxv:0,isnm:False|UVIN-6756-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7462,x:30939,y:32364,ptovrint:False,ptlb:Smoke1,ptin:_Smoke1,varname:node_7462,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:92d79879d68ac6c4e98d72151e1d1293,ntxv:0,isnm:False|UVIN-6756-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:1882,x:31341,y:32904,varname:node_1882,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:9923,x:31677,y:32801,ptovrint:False,ptlb:Thickness,ptin:_Thickness,varname:node_9923,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_RemapRange,id:9324,x:31551,y:32904,varname:node_9324,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-1882-UVOUT;n:type:ShaderForge.SFN_Multiply,id:3274,x:31750,y:32904,varname:node_3274,prsc:2|A-9324-OUT,B-9324-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1399,x:31910,y:32904,varname:node_1399,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3274-OUT;n:type:ShaderForge.SFN_Add,id:7164,x:32161,y:32792,varname:node_7164,prsc:2|A-3321-R,B-3321-G;n:type:ShaderForge.SFN_Lerp,id:2229,x:31582,y:32327,varname:node_2229,prsc:2|A-302-RGB,B-7765-OUT,T-2013-OUT;n:type:ShaderForge.SFN_Lerp,id:3169,x:31848,y:32413,varname:node_3169,prsc:2|A-2229-OUT,B-583-OUT,T-3752-OUT;n:type:ShaderForge.SFN_Set,id:4412,x:30575,y:32537,varname:RNG,prsc:2|IN-8464-OUT;n:type:ShaderForge.SFN_Get,id:2013,x:31177,y:32389,varname:node_2013,prsc:2|IN-4412-OUT;n:type:ShaderForge.SFN_Power,id:1219,x:32347,y:32888,varname:node_1219,prsc:2|VAL-7164-OUT,EXP-8840-OUT;n:type:ShaderForge.SFN_Slider,id:8840,x:31921,y:33148,ptovrint:False,ptlb:Feather,ptin:_Feather,varname:node_8840,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_OneMinus,id:44,x:32618,y:32867,varname:node_44,prsc:2|IN-1219-OUT;n:type:ShaderForge.SFN_Slider,id:265,x:32247,y:33206,ptovrint:False,ptlb:Size,ptin:_Size,varname:node_265,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-50,cur:0,max:0.988;n:type:ShaderForge.SFN_Blend,id:7612,x:31391,y:32538,varname:node_7612,prsc:2,blmd:10,clmp:True|SRC-7462-A,DST-1445-A;n:type:ShaderForge.SFN_Blend,id:89,x:31659,y:32612,varname:node_89,prsc:2,blmd:10,clmp:True|SRC-7612-OUT,DST-64-A;n:type:ShaderForge.SFN_Blend,id:8696,x:32313,y:32562,varname:node_8696,prsc:2,blmd:10,clmp:True|SRC-89-OUT,DST-5933-OUT;n:type:ShaderForge.SFN_Sin,id:2796,x:29990,y:32474,varname:node_2796,prsc:2|IN-3569-OUT;n:type:ShaderForge.SFN_Time,id:5350,x:29601,y:32372,varname:node_5350,prsc:2;n:type:ShaderForge.SFN_Color,id:302,x:30939,y:32081,ptovrint:False,ptlb:Smoke1 Tint,ptin:_Smoke1Tint,varname:node_302,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:6901,x:30939,y:32221,varname:node_6901,prsc:2|A-302-RGB,B-7462-RGB;n:type:ShaderForge.SFN_Color,id:1442,x:30939,y:32540,ptovrint:False,ptlb:Smoke2 Tint,ptin:_Smoke2Tint,varname:node_1442,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:7765,x:31177,y:32508,varname:node_7765,prsc:2|A-1442-RGB,B-1445-RGB;n:type:ShaderForge.SFN_Color,id:6305,x:30940,y:32874,ptovrint:False,ptlb:Smoke3 Tint,ptin:_Smoke3Tint,varname:node_6305,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:583,x:31129,y:32884,varname:node_583,prsc:2|A-6305-RGB,B-64-RGB;n:type:ShaderForge.SFN_Multiply,id:9106,x:32564,y:32614,varname:node_9106,prsc:2|A-8696-OUT,B-9923-OUT;n:type:ShaderForge.SFN_Multiply,id:3569,x:29811,y:32546,varname:node_3569,prsc:2|A-5350-TSL,B-7586-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7586,x:29521,y:32671,ptovrint:False,ptlb:Animation Speed,ptin:_AnimationSpeed,varname:node_7586,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Code,id:2829,x:33974,y:33264,varname:node_2829,prsc:2,code:ZgBsAG8AYQB0ADQAIAB2AGEAbAAgAD0AIABVAE4ASQBUAFkAXwBTAEEATQBQAEwARQBfAFQARQBYAEMAVQBCAEUAXwBMAE8ARAAoAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwACwAIAByAGUAZgBsAFYAZQBjAHQALAAgADcAKQA7AAoAZgBsAG8AYQB0ADMAIAByAGUAZgBsAEMAbwBsACAAPQAgAEQAZQBjAG8AZABlAEgARABSACgAdgBhAGwALAAgAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwAF8ASABEAFIAKQA7AAoAcgBlAHQAdQByAG4AIAByAGUAZgBsAEMAbwBsACAAKgAgADAALgAwADIAOwA=,output:2,fname:CubemapReflections,width:515,height:130,input:2,input_1_label:reflVect;n:type:ShaderForge.SFN_Code,id:7023,x:34038,y:33328,varname:node_7023,prsc:2,code:ZgBsAG8AYQB0ADQAIAB2AGEAbAAgAD0AIABVAE4ASQBUAFkAXwBTAEEATQBQAEwARQBfAFQARQBYAEMAVQBCAEUAXwBMAE8ARAAoAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwACwAIAByAGUAZgBsAFYAZQBjAHQALAAgADcAKQA7AAoAZgBsAG8AYQB0ADMAIAByAGUAZgBsAEMAbwBsACAAPQAgAEQAZQBjAG8AZABlAEgARABSACgAdgBhAGwALAAgAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwAF8ASABEAFIAKQA7AAoAcgBlAHQAdQByAG4AIAByAGUAZgBsAEMAbwBsACAAKgAgADAALgAwADIAOwA=,output:2,fname:CubemapReflections,width:515,height:130,input:2,input_1_label:reflVect;n:type:ShaderForge.SFN_Abs,id:8464,x:30385,y:32537,varname:node_8464,prsc:2|IN-2796-OUT;n:type:ShaderForge.SFN_RemapRange,id:3752,x:31796,y:32178,varname:node_3752,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-2013-OUT;n:type:ShaderForge.SFN_RemapRange,id:7608,x:33159,y:33156,varname:node_7608,prsc:2,frmn:0,frmx:1,tomn:-8,tomx:1|IN-44-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:5933,x:32736,y:33002,varname:node_5933,prsc:2|IN-44-OUT,IMIN-6463-OUT,IMAX-7515-OUT,OMIN-265-OUT,OMAX-5072-OUT;n:type:ShaderForge.SFN_Vector1,id:6463,x:32527,y:33002,varname:node_6463,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:5072,x:32276,y:33367,ptovrint:False,ptlb:Brightness,ptin:_Brightness,varname:node_5072,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Vector1,id:7515,x:32527,y:33066,varname:node_7515,prsc:2,v1:1;n:type:ShaderForge.SFN_Power,id:839,x:32110,y:32985,varname:node_839,prsc:2|VAL-1399-OUT,EXP-435-OUT;n:type:ShaderForge.SFN_ComponentMask,id:3321,x:31982,y:32786,varname:node_3321,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-839-OUT;n:type:ShaderForge.SFN_Slider,id:435,x:31593,y:33097,ptovrint:False,ptlb:Boxify,ptin:_Boxify,varname:node_435,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.4,cur:1,max:3;n:type:ShaderForge.SFN_TexCoord,id:6756,x:30531,y:32705,varname:node_6756,prsc:2,uv:0,uaff:False;proporder:64-1445-7462-9923-8840-265-302-1442-6305-7586-5072-435;pass:END;sub:END;*/

Shader "Naito/SmokeShader" {
    Properties {
        _Smoke3 ("Smoke3", 2D) = "white" {}
        _Smoke2 ("Smoke2", 2D) = "white" {}
        _Smoke1 ("Smoke1", 2D) = "white" {}
        _Thickness ("Thickness", Float ) = 1
        _Feather ("Feather", Range(0, 2)) = 1
        _Size ("Size", Range(-50, 0.988)) = 0
        _Smoke1Tint ("Smoke1 Tint", Color) = (1,1,1,1)
        _Smoke2Tint ("Smoke2 Tint", Color) = (1,1,1,1)
        _Smoke3Tint ("Smoke3 Tint", Color) = (1,1,1,1)
        _AnimationSpeed ("Animation Speed", Float ) = 1
        _Brightness ("Brightness", Range(0, 1)) = 1
        _Boxify ("Boxify", Range(0.4, 3)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
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
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Smoke3; uniform float4 _Smoke3_ST;
            uniform sampler2D _Smoke2; uniform float4 _Smoke2_ST;
            uniform sampler2D _Smoke1; uniform float4 _Smoke1_ST;
            uniform float _Thickness;
            uniform float _Feather;
            uniform float _Size;
            uniform float4 _Smoke1Tint;
            uniform float4 _Smoke2Tint;
            uniform float4 _Smoke3Tint;
            uniform float _AnimationSpeed;
            uniform float _Brightness;
            uniform float _Boxify;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _Smoke2_var = tex2D(_Smoke2,TRANSFORM_TEX(i.uv0, _Smoke2));
                float4 node_5350 = _Time;
                float RNG = abs(sin((node_5350.r*_AnimationSpeed)));
                float node_2013 = RNG;
                float4 _Smoke3_var = tex2D(_Smoke3,TRANSFORM_TEX(i.uv0, _Smoke3));
                float3 emissive = lerp(lerp(_Smoke1Tint.rgb,(_Smoke2Tint.rgb*_Smoke2_var.rgb),node_2013),(_Smoke3Tint.rgb*_Smoke3_var.rgb),(node_2013*-1.0+1.0));
                float3 finalColor = emissive;
                float4 _Smoke1_var = tex2D(_Smoke1,TRANSFORM_TEX(i.uv0, _Smoke1));
                float2 node_9324 = (i.uv0*2.0+-1.0);
                float2 node_3321 = pow((node_9324*node_9324).rg,_Boxify).rg;
                float node_44 = (1.0 - pow((node_3321.r+node_3321.g),_Feather));
                float node_6463 = 0.0;
                fixed4 finalRGBA = fixed4(finalColor,(saturate(( (_Size + ( (node_44 - node_6463) * (_Brightness - _Size) ) / (1.0 - node_6463)) > 0.5 ? (1.0-(1.0-2.0*((_Size + ( (node_44 - node_6463) * (_Brightness - _Size) ) / (1.0 - node_6463))-0.5))*(1.0-saturate(( _Smoke3_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke3_var.a-0.5))*(1.0-saturate(( _Smoke2_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke2_var.a-0.5))*(1.0-_Smoke1_var.a)) : (2.0*_Smoke2_var.a*_Smoke1_var.a) )))) : (2.0*_Smoke3_var.a*saturate(( _Smoke2_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke2_var.a-0.5))*(1.0-_Smoke1_var.a)) : (2.0*_Smoke2_var.a*_Smoke1_var.a) ))) )))) : (2.0*(_Size + ( (node_44 - node_6463) * (_Brightness - _Size) ) / (1.0 - node_6463))*saturate(( _Smoke3_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke3_var.a-0.5))*(1.0-saturate(( _Smoke2_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke2_var.a-0.5))*(1.0-_Smoke1_var.a)) : (2.0*_Smoke2_var.a*_Smoke1_var.a) )))) : (2.0*_Smoke3_var.a*saturate(( _Smoke2_var.a > 0.5 ? (1.0-(1.0-2.0*(_Smoke2_var.a-0.5))*(1.0-_Smoke1_var.a)) : (2.0*_Smoke2_var.a*_Smoke1_var.a) ))) ))) ))*_Thickness));
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(1,1,1,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
