// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:6,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:4,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33813,y:33326,varname:node_3138,prsc:2|emission-1219-OUT,clip-5458-OUT;n:type:ShaderForge.SFN_Multiply,id:5349,x:32426,y:32597,varname:node_5349,prsc:2|A-2103-OUT,B-9092-OUT,C-3617-OUT;n:type:ShaderForge.SFN_Distance,id:8627,x:32076,y:32617,varname:node_8627,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Vector2,id:993,x:31597,y:32709,varname:node_993,prsc:2,v1:0,v2:0;n:type:ShaderForge.SFN_Power,id:9092,x:32245,y:32617,varname:node_9092,prsc:2|VAL-8627-OUT,EXP-2801-OUT;n:type:ShaderForge.SFN_Vector1,id:2801,x:32076,y:32732,varname:node_2801,prsc:2,v1:2;n:type:ShaderForge.SFN_Tex2d,id:4561,x:33187,y:32882,varname:node_4561,prsc:2,ntxv:0,isnm:False|UVIN-6053-OUT,TEX-5194-TEX;n:type:ShaderForge.SFN_Multiply,id:2103,x:31597,y:32596,varname:node_2103,prsc:2|A-6531-OUT,B-4240-OUT;n:type:ShaderForge.SFN_Vector2,id:4240,x:31420,y:32709,varname:node_4240,prsc:2,v1:1,v2:0.5625;n:type:ShaderForge.SFN_Multiply,id:7816,x:32426,y:32761,varname:node_7816,prsc:2|A-2103-OUT,B-2600-OUT,C-7035-OUT;n:type:ShaderForge.SFN_Distance,id:5390,x:32076,y:32781,varname:node_5390,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:2600,x:32245,y:32781,varname:node_2600,prsc:2|VAL-5390-OUT,EXP-7597-OUT;n:type:ShaderForge.SFN_Vector1,id:7597,x:32076,y:32896,varname:node_7597,prsc:2,v1:4;n:type:ShaderForge.SFN_Add,id:8380,x:32652,y:32882,varname:node_8380,prsc:2|A-5349-OUT,B-7816-OUT,C-8389-OUT,D-9771-OUT;n:type:ShaderForge.SFN_Multiply,id:8389,x:32426,y:32923,varname:node_8389,prsc:2|A-2103-OUT,B-6710-OUT,C-7304-OUT;n:type:ShaderForge.SFN_Distance,id:5876,x:32076,y:32943,varname:node_5876,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:6710,x:32245,y:32943,varname:node_6710,prsc:2|VAL-5876-OUT,EXP-906-OUT;n:type:ShaderForge.SFN_Vector1,id:906,x:32076,y:33058,varname:node_906,prsc:2,v1:6;n:type:ShaderForge.SFN_Tex2dAsset,id:5194,x:32985,y:32729,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5194,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3341,x:32426,y:33091,varname:node_3341,prsc:2|A-2103-OUT,B-1797-OUT,C-7992-OUT;n:type:ShaderForge.SFN_Distance,id:8898,x:32076,y:33111,varname:node_8898,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:1797,x:32245,y:33111,varname:node_1797,prsc:2|VAL-8898-OUT,EXP-2220-OUT;n:type:ShaderForge.SFN_Vector1,id:2220,x:32076,y:33226,varname:node_2220,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:1667,x:32426,y:33255,varname:node_1667,prsc:2|A-2103-OUT,B-6260-OUT,C-23-OUT;n:type:ShaderForge.SFN_Distance,id:2200,x:32076,y:33275,varname:node_2200,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:6260,x:32245,y:33275,varname:node_6260,prsc:2|VAL-2200-OUT,EXP-1451-OUT;n:type:ShaderForge.SFN_Vector1,id:1451,x:32076,y:33390,varname:node_1451,prsc:2,v1:4;n:type:ShaderForge.SFN_Add,id:9593,x:32654,y:33236,varname:node_9593,prsc:2|A-3341-OUT,B-1667-OUT,C-8092-OUT,D-1868-OUT;n:type:ShaderForge.SFN_Multiply,id:8092,x:32426,y:33417,varname:node_8092,prsc:2|A-2103-OUT,B-8963-OUT,C-8666-OUT;n:type:ShaderForge.SFN_Distance,id:7683,x:32076,y:33437,varname:node_7683,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:8963,x:32245,y:33437,varname:node_8963,prsc:2|VAL-7683-OUT,EXP-7640-OUT;n:type:ShaderForge.SFN_Vector1,id:7640,x:32076,y:33552,varname:node_7640,prsc:2,v1:6;n:type:ShaderForge.SFN_Multiply,id:4831,x:32426,y:33583,varname:node_4831,prsc:2|A-2103-OUT,B-468-OUT,C-6964-OUT;n:type:ShaderForge.SFN_Distance,id:4946,x:32076,y:33603,varname:node_4946,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:468,x:32245,y:33603,varname:node_468,prsc:2|VAL-4946-OUT,EXP-4071-OUT;n:type:ShaderForge.SFN_Vector1,id:4071,x:32076,y:33718,varname:node_4071,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:5032,x:32426,y:33747,varname:node_5032,prsc:2|A-2103-OUT,B-4019-OUT,C-2650-OUT;n:type:ShaderForge.SFN_Distance,id:6168,x:32076,y:33767,varname:node_6168,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:4019,x:32245,y:33767,varname:node_4019,prsc:2|VAL-6168-OUT,EXP-8965-OUT;n:type:ShaderForge.SFN_Vector1,id:8965,x:32076,y:33882,varname:node_8965,prsc:2,v1:4;n:type:ShaderForge.SFN_Add,id:1611,x:32657,y:33583,varname:node_1611,prsc:2|A-4831-OUT,B-5032-OUT,C-4746-OUT,D-3426-OUT;n:type:ShaderForge.SFN_Multiply,id:4746,x:32426,y:33909,varname:node_4746,prsc:2|A-2103-OUT,B-1725-OUT,C-4371-OUT;n:type:ShaderForge.SFN_Distance,id:9738,x:32076,y:33929,varname:node_9738,prsc:2|A-2103-OUT,B-993-OUT;n:type:ShaderForge.SFN_Power,id:1725,x:32245,y:33929,varname:node_1725,prsc:2|VAL-9738-OUT,EXP-3598-OUT;n:type:ShaderForge.SFN_Vector1,id:3598,x:32076,y:34044,varname:node_3598,prsc:2,v1:6;n:type:ShaderForge.SFN_Tex2d,id:9943,x:33194,y:33236,varname:node_9943,prsc:2,ntxv:0,isnm:False|UVIN-4101-OUT,TEX-5194-TEX;n:type:ShaderForge.SFN_Tex2d,id:2130,x:33192,y:33583,varname:node_2130,prsc:2,ntxv:0,isnm:False|UVIN-4344-OUT,TEX-5194-TEX;n:type:ShaderForge.SFN_Append,id:1219,x:33427,y:33256,varname:node_1219,prsc:2|A-4561-R,B-9943-G,C-2130-B;n:type:ShaderForge.SFN_Vector1,id:1868,x:32426,y:33532,varname:node_1868,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:9771,x:32426,y:33037,varname:node_9771,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:3426,x:32426,y:34024,varname:node_3426,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:3804,x:32827,y:32882,varname:node_3804,prsc:2|A-8380-OUT,B-9193-OUT;n:type:ShaderForge.SFN_Multiply,id:4276,x:32825,y:33236,varname:node_4276,prsc:2|A-9593-OUT,B-9193-OUT;n:type:ShaderForge.SFN_Multiply,id:2265,x:32826,y:33583,varname:node_2265,prsc:2|A-1611-OUT,B-9193-OUT;n:type:ShaderForge.SFN_Abs,id:6531,x:31420,y:32596,varname:node_6531,prsc:2|IN-9066-OUT;n:type:ShaderForge.SFN_Slider,id:9626,x:30659,y:32632,ptovrint:False,ptlb:Remap,ptin:_Remap,varname:node_9626,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:9066,x:31229,y:32553,varname:node_9066,prsc:2|IN-2299-UVOUT,IMIN-6422-OUT,IMAX-7492-OUT,OMIN-7659-OUT,OMAX-9626-OUT;n:type:ShaderForge.SFN_Vector1,id:6422,x:31021,y:32688,varname:node_6422,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7492,x:31021,y:32736,varname:node_7492,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:7659,x:31021,y:32414,varname:node_7659,prsc:2|A-9626-OUT,B-6293-OUT;n:type:ShaderForge.SFN_Vector1,id:6293,x:30816,y:32434,varname:node_6293,prsc:2,v1:-1;n:type:ShaderForge.SFN_RemapRange,id:6053,x:32985,y:32882,varname:node_6053,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-3804-OUT;n:type:ShaderForge.SFN_RemapRange,id:4101,x:32986,y:33236,varname:node_4101,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-4276-OUT;n:type:ShaderForge.SFN_RemapRange,id:4344,x:32987,y:33583,varname:node_4344,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2265-OUT;n:type:ShaderForge.SFN_Relay,id:9193,x:32567,y:32548,varname:node_9193,prsc:2|IN-9066-OUT;n:type:ShaderForge.SFN_Slider,id:5536,x:30992,y:33374,ptovrint:False,ptlb:Chromatic Aberration,ptin:_ChromaticAberration,varname:node_5536,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.9,cur:0.9,max:1.1;n:type:ShaderForge.SFN_Relay,id:7992,x:31656,y:33242,varname:node_7992,prsc:2|IN-9238-OUT;n:type:ShaderForge.SFN_Relay,id:23,x:31656,y:33291,varname:node_23,prsc:2|IN-2269-OUT;n:type:ShaderForge.SFN_Relay,id:8666,x:31656,y:33340,varname:node_8666,prsc:2|IN-9065-OUT;n:type:ShaderForge.SFN_Multiply,id:3617,x:31597,y:32833,varname:node_3617,prsc:2|A-9238-OUT,B-5536-OUT;n:type:ShaderForge.SFN_Multiply,id:7035,x:31597,y:32967,varname:node_7035,prsc:2|A-2269-OUT,B-5536-OUT;n:type:ShaderForge.SFN_Multiply,id:7304,x:31597,y:33101,varname:node_7304,prsc:2|A-9065-OUT,B-5536-OUT;n:type:ShaderForge.SFN_Divide,id:6964,x:31597,y:33390,varname:node_6964,prsc:2|A-9238-OUT,B-5536-OUT;n:type:ShaderForge.SFN_Divide,id:2650,x:31597,y:33505,varname:node_2650,prsc:2|A-2269-OUT,B-5536-OUT;n:type:ShaderForge.SFN_Divide,id:4371,x:31597,y:33629,varname:node_4371,prsc:2|A-9065-OUT,B-5536-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9238,x:31149,y:33161,ptovrint:False,ptlb:Distortion0,ptin:_Distortion0,varname:node_9238,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2269,x:31149,y:33228,ptovrint:False,ptlb:Distortion1,ptin:_Distortion1,varname:_Distortion1,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9065,x:31149,y:33295,ptovrint:False,ptlb:Distortion2,ptin:_Distortion2,varname:_Distortion2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ScreenPos,id:2299,x:31021,y:32553,varname:node_2299,prsc:2,sctp:2;n:type:ShaderForge.SFN_ScreenParameters,id:6222,x:32888,y:33988,varname:node_6222,prsc:2;n:type:ShaderForge.SFN_Divide,id:6740,x:33076,y:33988,varname:node_6740,prsc:2|A-6222-PXH,B-6222-PXW;n:type:ShaderForge.SFN_Tex2d,id:6859,x:33256,y:34122,ptovrint:False,ptlb:SystemCom,ptin:_SystemCom,varname:node_6859,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5458,x:33434,y:33988,varname:node_5458,prsc:2|A-2187-OUT,B-5935-OUT,C-6859-R;n:type:ShaderForge.SFN_If,id:5935,x:33256,y:33988,varname:node_5935,prsc:2|A-6740-OUT,B-8832-OUT,GT-173-OUT,EQ-6551-OUT,LT-173-OUT;n:type:ShaderForge.SFN_Vector1,id:8832,x:33076,y:34103,varname:node_8832,prsc:2,v1:0.5625;n:type:ShaderForge.SFN_TexCoord,id:4192,x:29423,y:32894,varname:node_4192,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:7674,x:29101,y:33020,ptovrint:False,ptlb:Width_copy_copy,ptin:_Width_copy_copy,varname:_Width_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:8057,x:29101,y:33089,ptovrint:False,ptlb:Height_copy_copy,ptin:_Height_copy_copy,varname:_Height_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Divide,id:1071,x:29263,y:33041,varname:node_1071,prsc:2|A-7674-OUT,B-8057-OUT;n:type:ShaderForge.SFN_Append,id:1814,x:29423,y:33041,varname:node_1814,prsc:2|A-1071-OUT,B-4049-OUT;n:type:ShaderForge.SFN_Vector1,id:4049,x:29101,y:33138,varname:node_4049,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:5737,x:29423,y:33201,varname:node_5737,prsc:2|A-8510-OUT,B-2674-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8510,x:29263,y:33201,ptovrint:False,ptlb:U Offset_copy_copy,ptin:_UOffset_copy_copy,varname:_UOffset_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2674,x:29263,y:33267,ptovrint:False,ptlb:V Offset_copy_copy,ptin:_VOffset_copy_copy,varname:_VOffset_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:7711,x:29665,y:32922,varname:node_7711,prsc:2|A-4192-UVOUT,B-1814-OUT;n:type:ShaderForge.SFN_Add,id:9171,x:29838,y:32922,varname:node_9171,prsc:2|A-7711-OUT,B-5737-OUT;n:type:ShaderForge.SFN_Vector1,id:173,x:33076,y:34199,varname:node_173,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6551,x:33076,y:34153,varname:node_6551,prsc:2,v1:1;n:type:ShaderForge.SFN_Step,id:2187,x:33256,y:33874,varname:node_2187,prsc:2|A-6222-PXW,B-168-OUT;n:type:ShaderForge.SFN_ValueProperty,id:168,x:33076,y:33874,ptovrint:False,ptlb:WidthLimit,ptin:_WidthLimit,varname:node_168,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2000;proporder:5194-6859-9626-9238-2269-9065-5536-168;pass:END;sub:END;*/

Shader "uniuni/CustomCamera" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        _SystemCom ("SystemCom", 2D) = "white" {}
        _Remap ("Remap", Range(0, 1)) = 1
        _Distortion0 ("Distortion0", Float ) = 0
        _Distortion1 ("Distortion1", Float ) = 0
        _Distortion2 ("Distortion2", Float ) = 0
        _ChromaticAberration ("Chromatic Aberration", Range(0.9, 1.1)) = 0.9
        _WidthLimit ("WidthLimit", Float ) = 2000
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Overlay"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZTest Always
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float _Remap;
            uniform float _ChromaticAberration;
            uniform float _Distortion0;
            uniform float _Distortion1;
            uniform float _Distortion2;
            uniform sampler2D _SystemCom; uniform float4 _SystemCom_ST;
            uniform float _WidthLimit;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float node_5935_if_leA = step((_ScreenParams.g/_ScreenParams.r),0.5625);
                float node_5935_if_leB = step(0.5625,(_ScreenParams.g/_ScreenParams.r));
                float node_173 = 0.0;
                float4 _SystemCom_var = tex2D(_SystemCom,TRANSFORM_TEX(i.uv0, _SystemCom));
                clip((step(_ScreenParams.r,_WidthLimit)*lerp((node_5935_if_leA*node_173)+(node_5935_if_leB*node_173),1.0,node_5935_if_leA*node_5935_if_leB)*_SystemCom_var.r) - 0.5);
////// Lighting:
////// Emissive:
                float node_6422 = 0.0;
                float node_7659 = (_Remap*(-1.0));
                float2 node_9066 = (node_7659 + ( (sceneUVs.rg - node_6422) * (_Remap - node_7659) ) / (1.0 - node_6422));
                float2 node_2103 = (abs(node_9066)*float2(1,0.5625));
                float2 node_993 = float2(0,0);
                float2 node_9193 = node_9066;
                float2 node_6053 = ((((node_2103*pow(distance(node_2103,node_993),2.0)*(_Distortion0*_ChromaticAberration))+(node_2103*pow(distance(node_2103,node_993),4.0)*(_Distortion1*_ChromaticAberration))+(node_2103*pow(distance(node_2103,node_993),6.0)*(_Distortion2*_ChromaticAberration))+1.0)*node_9193)*0.5+0.5);
                float4 node_4561 = tex2D(_Texture,TRANSFORM_TEX(node_6053, _Texture));
                float2 node_4101 = ((((node_2103*pow(distance(node_2103,node_993),2.0)*_Distortion0)+(node_2103*pow(distance(node_2103,node_993),4.0)*_Distortion1)+(node_2103*pow(distance(node_2103,node_993),6.0)*_Distortion2)+1.0)*node_9193)*0.5+0.5);
                float4 node_9943 = tex2D(_Texture,TRANSFORM_TEX(node_4101, _Texture));
                float2 node_4344 = ((((node_2103*pow(distance(node_2103,node_993),2.0)*(_Distortion0/_ChromaticAberration))+(node_2103*pow(distance(node_2103,node_993),4.0)*(_Distortion1/_ChromaticAberration))+(node_2103*pow(distance(node_2103,node_993),6.0)*(_Distortion2/_ChromaticAberration))+1.0)*node_9193)*0.5+0.5);
                float4 node_2130 = tex2D(_Texture,TRANSFORM_TEX(node_4344, _Texture));
                float3 emissive = float3(node_4561.r,node_9943.g,node_2130.b);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _SystemCom; uniform float4 _SystemCom_ST;
            uniform float _WidthLimit;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float node_5935_if_leA = step((_ScreenParams.g/_ScreenParams.r),0.5625);
                float node_5935_if_leB = step(0.5625,(_ScreenParams.g/_ScreenParams.r));
                float node_173 = 0.0;
                float4 _SystemCom_var = tex2D(_SystemCom,TRANSFORM_TEX(i.uv0, _SystemCom));
                clip((step(_ScreenParams.r,_WidthLimit)*lerp((node_5935_if_leA*node_173)+(node_5935_if_leB*node_173),1.0,node_5935_if_leA*node_5935_if_leB)*_SystemCom_var.r) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
