// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-4718-OUT,clip-44-OUT,olwid-4007-OUT,olcol-5271-OUT;n:type:ShaderForge.SFN_LightColor,id:3406,x:32669,y:32940,varname:node_3406,prsc:2;n:type:ShaderForge.SFN_LightVector,id:6869,x:31477,y:32546,varname:node_6869,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9684,x:31477,y:32688,prsc:2,pt:True;n:type:ShaderForge.SFN_HalfVector,id:9471,x:31477,y:32863,varname:node_9471,prsc:2;n:type:ShaderForge.SFN_Dot,id:7782,x:31965,y:32704,cmnt:Lambert,varname:node_7782,prsc:2,dt:1|A-6869-OUT,B-9684-OUT;n:type:ShaderForge.SFN_Dot,id:3269,x:32070,y:32859,cmnt:Blinn-Phong,varname:node_3269,prsc:2,dt:1|A-9684-OUT,B-9471-OUT;n:type:ShaderForge.SFN_Multiply,id:2746,x:32450,y:32977,cmnt:Specular Contribution,varname:node_2746,prsc:2|A-4453-OUT,B-5267-OUT,C-4865-RGB;n:type:ShaderForge.SFN_Tex2d,id:851,x:31935,y:32342,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1941,x:32415,y:32569,cmnt:Diffuse Contribution,varname:node_1941,prsc:2|A-544-OUT,B-4453-OUT;n:type:ShaderForge.SFN_Color,id:5927,x:32070,y:32534,ptovrint:False,ptlb:Diffuse Color,ptin:_DiffuseColor,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Exp,id:1700,x:32070,y:33054,varname:node_1700,prsc:2,et:1|IN-9978-OUT;n:type:ShaderForge.SFN_Slider,id:5328,x:31529,y:33056,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_5328,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Power,id:5267,x:32268,y:32940,varname:node_5267,prsc:2|VAL-3269-OUT,EXP-1700-OUT;n:type:ShaderForge.SFN_Add,id:2159,x:32769,y:32811,cmnt:Combine,varname:node_2159,prsc:2|A-1941-OUT,B-3022-OUT,C-7483-OUT;n:type:ShaderForge.SFN_Multiply,id:5085,x:32979,y:32894,cmnt:Attenuate and Color,varname:node_5085,prsc:2|A-2159-OUT,B-6962-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:9978,x:31858,y:33056,varname:node_9978,prsc:2,a:1,b:11|IN-5328-OUT;n:type:ShaderForge.SFN_Color,id:4865,x:32268,y:33095,ptovrint:False,ptlb:Spec Color,ptin:_SpecColor,varname:node_4865,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:544,x:32301,y:32432,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-5927-RGB;n:type:ShaderForge.SFN_Multiply,id:6962,x:33023,y:33114,varname:node_6962,prsc:2|A-2457-OUT,B-5667-OUT;n:type:ShaderForge.SFN_Slider,id:9752,x:32577,y:33261,ptovrint:False,ptlb:Light Intensity,ptin:_LightIntensity,varname:node_9752,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.05,max:1;n:type:ShaderForge.SFN_RemapRange,id:5667,x:32934,y:33238,varname:node_5667,prsc:2,frmn:0,frmx:1,tomn:0,tomx:35|IN-9752-OUT;n:type:ShaderForge.SFN_Slider,id:1572,x:33145,y:33885,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:node_1572,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-0.5,cur:0.2,max:1;n:type:ShaderForge.SFN_Color,id:7261,x:32414,y:33694,ptovrint:False,ptlb:Outline Color,ptin:_OutlineColor,varname:node_7261,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:1378,x:33163,y:33279,ptovrint:False,ptlb:Outline Width,ptin:_OutlineWidth,varname:node_1378,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:7455,x:33560,y:33282,varname:node_7455,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.06|IN-1378-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5271,x:32973,y:33517,ptovrint:False,ptlb:Outline Tinting,ptin:_OutlineTinting,varname:node_5271,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7261-RGB,B-7803-OUT;n:type:ShaderForge.SFN_Slider,id:4938,x:32257,y:33856,ptovrint:False,ptlb:Outline Brightness,ptin:_OutlineBrightness,varname:node_4938,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:20;n:type:ShaderForge.SFN_Multiply,id:4287,x:32657,y:33704,varname:node_4287,prsc:2|A-7261-RGB,B-4938-OUT;n:type:ShaderForge.SFN_Multiply,id:7803,x:32824,y:33565,varname:node_7803,prsc:2|A-851-RGB,B-4287-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:3022,x:32571,y:32841,ptovrint:False,ptlb:Blinn-Phong Toggle,ptin:_BlinnPhongToggle,varname:node_3022,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7775-OUT,B-2746-OUT;n:type:ShaderForge.SFN_Vector1,id:7775,x:32400,y:32841,varname:node_7775,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:2346,x:32436,y:32352,ptovrint:False,ptlb:Rim Distance,ptin:_RimDistance,varname:node_2346,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8350616,max:1;n:type:ShaderForge.SFN_Fresnel,id:3404,x:32927,y:32391,varname:node_3404,prsc:2|EXP-3571-OUT;n:type:ShaderForge.SFN_RemapRange,id:3571,x:32759,y:32423,varname:node_3571,prsc:2,frmn:0,frmx:1,tomn:2,tomx:50|IN-2346-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:7483,x:33151,y:32315,ptovrint:False,ptlb:Rim Light Toggle,ptin:_RimLightToggle,varname:node_7483,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8138-OUT,B-8106-OUT;n:type:ShaderForge.SFN_Vector1,id:8138,x:32959,y:32227,varname:node_8138,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:8106,x:33113,y:32443,varname:node_8106,prsc:2|A-3404-OUT,B-5385-OUT;n:type:ShaderForge.SFN_Color,id:6128,x:32747,y:32242,ptovrint:False,ptlb:Rim Color,ptin:_RimColor,varname:node_6128,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:255,c2:255,c3:255,c4:255;n:type:ShaderForge.SFN_Multiply,id:7250,x:32633,y:31881,varname:node_7250,prsc:2|A-851-RGB,B-6848-OUT;n:type:ShaderForge.SFN_Multiply,id:6848,x:32910,y:32069,varname:node_6848,prsc:2|A-5543-OUT,B-6128-RGB;n:type:ShaderForge.SFN_Slider,id:9017,x:32696,y:31807,ptovrint:False,ptlb:Rim Brightness,ptin:_RimBrightness,varname:node_9017,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:5543,x:33079,y:31740,varname:node_5543,prsc:2,frmn:0,frmx:1,tomn:0,tomx:35|IN-9017-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5385,x:33136,y:32042,ptovrint:False,ptlb:Rim Light Tinting,ptin:_RimLightTinting,varname:node_5385,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6128-RGB,B-7250-OUT;n:type:ShaderForge.SFN_Tex2d,id:8499,x:32973,y:33664,ptovrint:False,ptlb:Cutoff Texture,ptin:_CutoffTexture,varname:node_8499,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:44,x:33304,y:33382,varname:node_44,prsc:2|A-3442-OUT,B-4905-OUT;n:type:ShaderForge.SFN_Clamp01,id:8620,x:31971,y:33442,varname:node_8620,prsc:2|IN-9648-OUT;n:type:ShaderForge.SFN_Multiply,id:3694,x:32207,y:33442,varname:node_3694,prsc:2|A-8620-OUT,B-2107-OUT;n:type:ShaderForge.SFN_Noise,id:9951,x:31826,y:33712,varname:node_9951,prsc:2|XY-9395-OUT;n:type:ShaderForge.SFN_Lerp,id:2107,x:32084,y:33614,varname:node_2107,prsc:2|A-7993-OUT,B-9951-OUT,T-4745-OUT;n:type:ShaderForge.SFN_Slider,id:9146,x:31326,y:33612,ptovrint:False,ptlb:Distance (rough),ptin:_Distancerough,varname:node_9146,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:500;n:type:ShaderForge.SFN_TexCoord,id:710,x:31451,y:33739,varname:node_710,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_OneMinus,id:8162,x:32483,y:33390,varname:node_8162,prsc:2|IN-3694-OUT;n:type:ShaderForge.SFN_Add,id:3442,x:33413,y:33604,varname:node_3442,prsc:2|A-8499-A,B-1572-OUT;n:type:ShaderForge.SFN_Multiply,id:9648,x:31807,y:33300,varname:node_9648,prsc:2|A-1238-OUT,B-7590-OUT;n:type:ShaderForge.SFN_Slider,id:1775,x:31063,y:33195,ptovrint:False,ptlb:Distance (fine),ptin:_Distancefine,varname:node_1775,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:1238,x:31428,y:33136,varname:node_1238,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.01|IN-1775-OUT;n:type:ShaderForge.SFN_RemapRange,id:7993,x:31644,y:33568,varname:node_7993,prsc:2,frmn:0,frmx:500,tomn:0,tomx:10|IN-9146-OUT;n:type:ShaderForge.SFN_Slider,id:4745,x:31814,y:34004,ptovrint:False,ptlb:Dithering,ptin:_Dithering,varname:node_4745,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4188035,max:1;n:type:ShaderForge.SFN_Multiply,id:9395,x:31660,y:33846,varname:node_9395,prsc:2|A-710-UVOUT,B-4745-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4905,x:33127,y:33365,ptovrint:False,ptlb:Distance Fade,ptin:_DistanceFade,varname:node_4905,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1385-OUT,B-8162-OUT;n:type:ShaderForge.SFN_Vector1,id:1385,x:32762,y:33434,varname:node_1385,prsc:2,v1:1;n:type:ShaderForge.SFN_Color,id:5548,x:32405,y:33275,ptovrint:False,ptlb:Light Tint,ptin:_LightTint,varname:node_5548,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:0;n:type:ShaderForge.SFN_Add,id:2457,x:32807,y:33141,varname:node_2457,prsc:2|A-8019-OUT,B-5548-RGB;n:type:ShaderForge.SFN_Add,id:4718,x:32656,y:32098,cmnt:Final Combine,varname:node_4718,prsc:2|A-2963-OUT,B-5085-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:9123,x:30971,y:33371,varname:node_9123,prsc:2;n:type:ShaderForge.SFN_ObjectPosition,id:4538,x:30971,y:33495,varname:node_4538,prsc:2;n:type:ShaderForge.SFN_Distance,id:2356,x:31220,y:33421,varname:node_2356,prsc:2|A-9123-XYZ,B-4538-XYZ;n:type:ShaderForge.SFN_Distance,id:7590,x:31519,y:33349,varname:node_7590,prsc:2|A-753-OUT,B-2356-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4453,x:32257,y:32709,ptovrint:False,ptlb:Cel-Shading,ptin:_CelShading,varname:node_4453,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7782-OUT,B-8834-OUT;n:type:ShaderForge.SFN_Slider,id:2546,x:31281,y:32269,ptovrint:False,ptlb:Toon Step,ptin:_ToonStep,varname:node_2546,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4871795,max:2;n:type:ShaderForge.SFN_Vector1,id:2963,x:32358,y:32031,varname:node_2963,prsc:2,v1:0;n:type:ShaderForge.SFN_TexCoord,id:3335,x:31523,y:32105,varname:node_3335,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Posterize,id:7642,x:32099,y:32132,varname:node_7642,prsc:2|IN-6606-OUT,STPS-1204-OUT;n:type:ShaderForge.SFN_Slider,id:1204,x:31905,y:32062,ptovrint:False,ptlb:Toon Ramp,ptin:_ToonRamp,varname:node_1204,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1.69,cur:1.69,max:20;n:type:ShaderForge.SFN_Multiply,id:4724,x:31767,y:32136,varname:node_4724,prsc:2|A-3335-U,B-7782-OUT;n:type:ShaderForge.SFN_Vector1,id:5785,x:31582,y:31981,varname:node_5785,prsc:2,v1:0;n:type:ShaderForge.SFN_Smoothstep,id:1291,x:32391,y:32118,varname:node_1291,prsc:2|A-5785-OUT,B-2546-OUT,V-7642-OUT;n:type:ShaderForge.SFN_Set,id:7061,x:34384,y:33139,varname:CameraDist,prsc:2|IN-3776-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4354,x:33809,y:33314,ptovrint:False,ptlb:ScreenSpace Outline,ptin:_ScreenSpaceOutline,varname:node_4354,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7455-OUT,B-4321-OUT;n:type:ShaderForge.SFN_ObjectPosition,id:382,x:33587,y:33533,varname:node_382,prsc:2;n:type:ShaderForge.SFN_ViewPosition,id:7804,x:33587,y:33661,varname:node_7804,prsc:2;n:type:ShaderForge.SFN_Distance,id:7784,x:33844,y:33647,varname:node_7784,prsc:2|A-382-XYZ,B-1988-OUT;n:type:ShaderForge.SFN_Clamp,id:4007,x:33610,y:32951,varname:node_4007,prsc:2|IN-4354-OUT,MIN-1378-OUT,MAX-1453-OUT;n:type:ShaderForge.SFN_Vector1,id:1453,x:33427,y:33085,varname:node_1453,prsc:2,v1:0.0305;n:type:ShaderForge.SFN_Multiply,id:4321,x:34080,y:33518,varname:node_4321,prsc:2|A-7455-OUT,B-7784-OUT,C-2789-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4984,x:33613,y:33949,ptovrint:False,ptlb:Outline Widening Distance,ptin:_OutlineWideningDistance,varname:node_4984,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:1988,x:33812,y:33786,varname:node_1988,prsc:2|A-7804-XYZ,B-4984-OUT;n:type:ShaderForge.SFN_Get,id:2547,x:33566,y:33475,varname:node_2547,prsc:2|IN-7061-OUT;n:type:ShaderForge.SFN_Distance,id:2789,x:33844,y:33518,varname:node_2789,prsc:2|A-2547-OUT,B-382-XYZ;n:type:ShaderForge.SFN_Clamp,id:8019,x:32903,y:32995,varname:node_8019,prsc:2|IN-5962-OUT,MIN-2288-OUT,MAX-6651-OUT;n:type:ShaderForge.SFN_Vector1,id:2288,x:32591,y:33064,varname:node_2288,prsc:2,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6651,x:32591,y:33175,ptovrint:False,ptlb:Max Light Brightness,ptin:_MaxLightBrightness,varname:node_6651,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Clamp,id:8834,x:32561,y:32204,varname:node_8834,prsc:2|IN-1291-OUT,MIN-3434-OUT,MAX-2798-OUT;n:type:ShaderForge.SFN_Vector1,id:2798,x:32274,y:32305,varname:node_2798,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3434,x:32215,y:32257,ptovrint:False,ptlb:Toon Shadow Brightness,ptin:_ToonShadowBrightness,varname:node_3434,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_If,id:8071,x:32235,y:33275,varname:node_8071,prsc:2|A-9012-OUT,B-7839-OUT,GT-3406-RGB,EQ-8813-OUT,LT-8813-OUT;n:type:ShaderForge.SFN_Vector1,id:7839,x:31971,y:33283,varname:node_7839,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:723,x:32359,y:33483,ptovrint:False,ptlb:Ambient Color,ptin:_AmbientColor,varname:node_723,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Power,id:6606,x:31935,y:32182,varname:node_6606,prsc:2|VAL-4724-OUT,EXP-6853-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6853,x:31723,y:32293,ptovrint:False,ptlb:Toon Shadow Contrast,ptin:_ToonShadowContrast,varname:node_6853,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:8838,x:32578,y:33525,cmnt:Ambiance Multiply,varname:node_8838,prsc:2|A-491-OUT,B-723-RGB,C-5976-RGB;n:type:ShaderForge.SFN_ValueProperty,id:491,x:32650,y:33634,ptovrint:False,ptlb:Ambient Multiplier,ptin:_AmbientMultiplier,varname:node_491,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_LightPosition,id:5490,x:31031,y:32656,varname:node_5490,prsc:2;n:type:ShaderForge.SFN_Abs,id:9012,x:31228,y:32656,varname:node_9012,prsc:2|IN-5490-XYZ;n:type:ShaderForge.SFN_Code,id:3776,x:34116,y:32919,varname:node_3776,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBTAEkATgBHAF8AUwBUAEUAUgBFAE8AXwBNAEEAVABSAEkAQwBFAFMAKQANAAoAZgBsAG8AYQB0ADMAIABsAGUAZgB0AEUAeQBlACAAPQAgAHUAbgBpAHQAeQBfAFMAdABlAHIAZQBvAFcAbwByAGwAZABTAHAAYQBjAGUAQwBhAG0AZQByAGEAUABvAHMAWwAwAF0AOwANAAoAZgBsAG8AYQB0ADMAIAByAGkAZwBoAHQARQB5AGUAIAA9ACAAdQBuAGkAdAB5AF8AUwB0AGUAcgBlAG8AVwBvAHIAbABkAFMAcABhAGMAZQBDAGEAbQBlAHIAYQBQAG8AcwBbADEAXQA7AA0ACgANAAoAZgBsAG8AYQB0ADMAIABjAGUAbgB0AGUAcgBFAHkAZQAgAD0AIABsAGUAcgBwACgAbABlAGYAdABFAHkAZQAsACAAcgBpAGcAaAB0AEUAeQBlACwAIAAwAC4ANQApADsADQAKACMAZQBuAGQAaQBmAA0ACgAjAGkAZgAgACEAZABlAGYAaQBuAGUAZAAoAFUAUwBJAE4ARwBfAFMAVABFAFIARQBPAF8ATQBBAFQAUgBJAEMARQBTACkADQAKAGYAbABvAGEAdAAzACAAYwBlAG4AdABlAHIARQB5AGUAIAA9ACAAXwBXAG8AcgBsAGQAUwBwAGEAYwBlAEMAYQBtAGUAcgBhAFAAbwBzADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABjAGUAbgB0AGUAcgBFAHkAZQA7AA==,output:2,fname:GetVRCameraDist,width:247,height:112;n:type:ShaderForge.SFN_Multiply,id:6393,x:34083,y:32346,varname:node_6393,prsc:2|A-851-RGB,B-8427-OUT;n:type:ShaderForge.SFN_Slider,id:8427,x:33503,y:32437,ptovrint:False,ptlb:Diffuse Glow Intensity,ptin:_DiffuseGlowIntensity,varname:node_8427,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:4353,x:33871,y:32060,ptovrint:False,ptlb:GlowMask,ptin:_GlowMask,varname:node_4353,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Set,id:8830,x:35410,y:32311,varname:Glow,prsc:2|IN-8362-OUT;n:type:ShaderForge.SFN_Fresnel,id:1402,x:34126,y:32016,varname:node_1402,prsc:2|NRM-7972-OUT,EXP-9115-OUT;n:type:ShaderForge.SFN_Slider,id:9115,x:33926,y:31817,ptovrint:False,ptlb:Glow Distance,ptin:_GlowDistance,varname:node_9115,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_NormalVector,id:7972,x:33825,y:32236,prsc:2,pt:False;n:type:ShaderForge.SFN_Lerp,id:9357,x:34636,y:32223,varname:node_9357,prsc:2|A-7277-RGB,B-3712-OUT,T-7475-OUT;n:type:ShaderForge.SFN_Color,id:7277,x:34929,y:31869,ptovrint:False,ptlb:Glow Tint,ptin:_GlowTint,varname:node_7277,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_SwitchProperty,id:5400,x:34713,y:31931,ptovrint:False,ptlb:Reverse Glow Direction,ptin:_ReverseGlowDirection,varname:node_5400,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8226-OUT,B-5517-OUT;n:type:ShaderForge.SFN_OneMinus,id:8226,x:34558,y:31885,varname:node_8226,prsc:2|IN-5517-OUT;n:type:ShaderForge.SFN_Multiply,id:1508,x:34334,y:32102,varname:node_1508,prsc:2|A-1402-OUT,B-7119-OUT;n:type:ShaderForge.SFN_Slider,id:7119,x:33892,y:32514,ptovrint:False,ptlb:Edge Intensity,ptin:_EdgeIntensity,varname:node_7119,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_ChannelBlend,id:2464,x:34845,y:32223,varname:node_2464,prsc:2,chbt:0|M-4353-RGB,R-9357-OUT,G-9357-OUT,B-9357-OUT,A-4353-A;n:type:ShaderForge.SFN_SwitchProperty,id:5517,x:34399,y:31936,ptovrint:False,ptlb:Toon Glow,ptin:_ToonGlow,varname:node_5517,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1508-OUT,B-6960-OUT;n:type:ShaderForge.SFN_Posterize,id:6960,x:34312,y:31788,varname:node_6960,prsc:2|IN-1508-OUT,STPS-5742-OUT;n:type:ShaderForge.SFN_Slider,id:5742,x:34403,y:31696,ptovrint:False,ptlb:Toon Glow Steps,ptin:_ToonGlowSteps,varname:node_5742,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_Slider,id:1702,x:35109,y:32139,ptovrint:False,ptlb:Overall Glow Intensity,ptin:_OverallGlowIntensity,varname:node_1702,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_ConstantClamp,id:7475,x:34845,y:32053,varname:node_7475,prsc:2,min:0.01,max:1|IN-5400-OUT;n:type:ShaderForge.SFN_Multiply,id:62,x:35067,y:32301,varname:node_62,prsc:2|A-2464-OUT,B-1702-OUT;n:type:ShaderForge.SFN_ConstantClamp,id:3712,x:34434,y:32270,varname:node_3712,prsc:2,min:0.01,max:1|IN-6393-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:4443,x:34943,y:32514,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:node_4443,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:8362,x:35313,y:32404,varname:node_8362,prsc:2|A-6476-OUT,B-4443-OUT,GT-62-OUT,EQ-5380-OUT,LT-62-OUT;n:type:ShaderForge.SFN_Vector1,id:6476,x:34943,y:32419,varname:node_6476,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:5380,x:34761,y:32456,varname:node_5380,prsc:2|A-4353-RGB,B-6393-OUT;n:type:ShaderForge.SFN_AmbientLight,id:5976,x:32212,y:33675,varname:node_5976,prsc:2;n:type:ShaderForge.SFN_Add,id:8813,x:33001,y:32690,varname:node_8813,prsc:2|A-8128-OUT,B-8838-OUT;n:type:ShaderForge.SFN_Get,id:8128,x:32769,y:32646,varname:node_8128,prsc:2|IN-8830-OUT;n:type:ShaderForge.SFN_Add,id:5962,x:32463,y:33119,cmnt:GlowCombine,varname:node_5962,prsc:2|A-6707-OUT,B-8071-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:6707,x:32571,y:32694,ptovrint:False,ptlb:Only Glow in Dark,ptin:_OnlyGlowinDark,varname:node_6707,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8128-OUT,B-7775-OUT;n:type:ShaderForge.SFN_Get,id:753,x:31067,y:33291,varname:node_753,prsc:2|IN-7061-OUT;proporder:851-5927-8499-1572-4353-4443-5517-5400-7277-9115-8427-7119-1702-5742-5548-6651-4453-1204-2546-3434-6853-3022-5328-723-491-4865-9752-5271-4354-7261-1378-4938-4984-7483-5385-6128-2346-9017-4905-4745-9146-1775-6707;pass:END;sub:END;*/

Shader "Naito/MultiShader" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        [HDR]_DiffuseColor ("Diffuse Color", Color) = (0.5,0.5,0.5,1)
        _CutoffTexture ("Cutoff Texture", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(-0.5, 1)) = 0.2
        [HDR]_GlowMask ("GlowMask", 2D) = "black" {}
        [MaterialToggle] _Fresnel ("Fresnel", Float ) = 0
        [MaterialToggle] _ToonGlow ("Toon Glow", Float ) = 0
        [MaterialToggle] _ReverseGlowDirection ("Reverse Glow Direction", Float ) = 1
        [HDR]_GlowTint ("Glow Tint", Color) = (1,1,1,1)
        _GlowDistance ("Glow Distance", Range(0, 5)) = 1
        _DiffuseGlowIntensity ("Diffuse Glow Intensity", Range(-1, 1)) = 1
        _EdgeIntensity ("Edge Intensity", Range(0, 5)) = 1
        _OverallGlowIntensity ("Overall Glow Intensity", Range(0, 5)) = 1
        _ToonGlowSteps ("Toon Glow Steps", Range(0, 10)) = 0
        _LightTint ("Light Tint", Color) = (0,0,0,0)
        _MaxLightBrightness ("Max Light Brightness", Float ) = 1
        [MaterialToggle] _CelShading ("Cel-Shading", Float ) = 0
        _ToonRamp ("Toon Ramp", Range(1.69, 20)) = 1.69
        _ToonStep ("Toon Step", Range(0, 2)) = 0.4871795
        _ToonShadowBrightness ("Toon Shadow Brightness", Float ) = 0.1
        _ToonShadowContrast ("Toon Shadow Contrast", Float ) = 0
        [MaterialToggle] _BlinnPhongToggle ("Blinn-Phong Toggle", Float ) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0.5
        _AmbientColor ("Ambient Color", Color) = (1,1,1,1)
        _AmbientMultiplier ("Ambient Multiplier", Float ) = 1
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
        _LightIntensity ("Light Intensity", Range(0, 1)) = 0.05
        [MaterialToggle] _OutlineTinting ("Outline Tinting", Float ) = 0.5
        [MaterialToggle] _ScreenSpaceOutline ("ScreenSpace Outline", Float ) = 0
        _OutlineColor ("Outline Color", Color) = (0.5,0.5,0.5,1)
        _OutlineWidth ("Outline Width", Range(0, 1)) = 0
        _OutlineBrightness ("Outline Brightness", Range(0, 20)) = 0
        _OutlineWideningDistance ("Outline Widening Distance", Float ) = 1
        [MaterialToggle] _RimLightToggle ("Rim Light Toggle", Float ) = 0
        [MaterialToggle] _RimLightTinting ("Rim Light Tinting", Float ) = 255
        _RimColor ("Rim Color", Color) = (255,255,255,255)
        _RimDistance ("Rim Distance", Range(0, 1)) = 0.8350616
        _RimBrightness ("Rim Brightness", Range(0, 1)) = 0
        [MaterialToggle] _DistanceFade ("Distance Fade", Float ) = 1
        _Dithering ("Dithering", Range(0, 1)) = 0.4188035
        _Distancerough ("Distance (rough)", Range(0, 500)) = 0
        _Distancefine ("Distance (fine)", Range(0, 1)) = 0
        [MaterialToggle] _OnlyGlowinDark ("Only Glow in Dark", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float _Cutoff;
            uniform float4 _OutlineColor;
            uniform float _OutlineWidth;
            uniform fixed _OutlineTinting;
            uniform float _OutlineBrightness;
            uniform sampler2D _CutoffTexture; uniform float4 _CutoffTexture_ST;
            uniform float _Distancerough;
            uniform float _Distancefine;
            uniform float _Dithering;
            uniform fixed _DistanceFade;
            uniform fixed _ScreenSpaceOutline;
            uniform float _OutlineWideningDistance;
            float3 GetVRCameraDist(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                UNITY_FOG_COORDS(2)
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float node_7455 = (_OutlineWidth*0.06+0.0);
                float3 CameraDist = GetVRCameraDist();
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*clamp(lerp( node_7455, (node_7455*distance(objPos.rgb,(_WorldSpaceCameraPos*_OutlineWideningDistance))*distance(CameraDist,objPos.rgb)), _ScreenSpaceOutline ),_OutlineWidth,0.0305),1) );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float4 _CutoffTexture_var = tex2D(_CutoffTexture,TRANSFORM_TEX(i.uv0, _CutoffTexture));
                float3 CameraDist = GetVRCameraDist();
                float2 node_9395 = (i.uv0*_Dithering);
                float2 node_9951_skew = node_9395 + 0.2127+node_9395.x*0.3713*node_9395.y;
                float2 node_9951_rnd = 4.789*sin(489.123*(node_9951_skew));
                float node_9951 = frac(node_9951_rnd.x*node_9951_rnd.y*(1+node_9951_skew.x));
                clip(((_CutoffTexture_var.a+_Cutoff)*lerp( 1.0, (1.0 - (saturate(((_Distancefine*0.01+0.0)*distance(CameraDist,distance(i.posWorld.rgb,objPos.rgb))))*lerp((_Distancerough*0.02+0.0),node_9951,_Dithering))), _DistanceFade )) - 0.5);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                return fixed4(lerp( _OutlineColor.rgb, (_Diffuse_var.rgb*(_OutlineColor.rgb*_OutlineBrightness)), _OutlineTinting ),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _DiffuseColor;
            uniform float _Gloss;
            uniform float4 _SpecColor;
            uniform float _LightIntensity;
            uniform float _Cutoff;
            uniform fixed _BlinnPhongToggle;
            uniform float _RimDistance;
            uniform fixed _RimLightToggle;
            uniform float4 _RimColor;
            uniform float _RimBrightness;
            uniform fixed _RimLightTinting;
            uniform sampler2D _CutoffTexture; uniform float4 _CutoffTexture_ST;
            uniform float _Distancerough;
            uniform float _Distancefine;
            uniform float _Dithering;
            uniform fixed _DistanceFade;
            uniform float4 _LightTint;
            uniform fixed _CelShading;
            uniform float _ToonStep;
            uniform float _ToonRamp;
            uniform float _MaxLightBrightness;
            uniform float _ToonShadowBrightness;
            uniform float4 _AmbientColor;
            uniform float _ToonShadowContrast;
            uniform float _AmbientMultiplier;
            float3 GetVRCameraDist(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            uniform float _DiffuseGlowIntensity;
            uniform sampler2D _GlowMask; uniform float4 _GlowMask_ST;
            uniform float _GlowDistance;
            uniform float4 _GlowTint;
            uniform fixed _ReverseGlowDirection;
            uniform float _EdgeIntensity;
            uniform fixed _ToonGlow;
            uniform float _ToonGlowSteps;
            uniform float _OverallGlowIntensity;
            uniform fixed _Fresnel;
            uniform fixed _OnlyGlowinDark;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 _CutoffTexture_var = tex2D(_CutoffTexture,TRANSFORM_TEX(i.uv0, _CutoffTexture));
                float3 CameraDist = GetVRCameraDist();
                float2 node_9395 = (i.uv0*_Dithering);
                float2 node_9951_skew = node_9395 + 0.2127+node_9395.x*0.3713*node_9395.y;
                float2 node_9951_rnd = 4.789*sin(489.123*(node_9951_skew));
                float node_9951 = frac(node_9951_rnd.x*node_9951_rnd.y*(1+node_9951_skew.x));
                clip(((_CutoffTexture_var.a+_Cutoff)*lerp( 1.0, (1.0 - (saturate(((_Distancefine*0.01+0.0)*distance(CameraDist,distance(i.posWorld.rgb,objPos.rgb))))*lerp((_Distancerough*0.02+0.0),node_9951,_Dithering))), _DistanceFade )) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_7782 = max(0,dot(lightDirection,normalDirection)); // Lambert
                float _CelShading_var = lerp( node_7782, clamp(smoothstep( 0.0, _ToonStep, floor(pow((i.uv0.r*node_7782),_ToonShadowContrast) * _ToonRamp) / (_ToonRamp - 1) ),_ToonShadowBrightness,1.0), _CelShading );
                float node_7775 = 0.0;
                float node_8362_if_leA = step(0.0,_Fresnel);
                float node_8362_if_leB = step(_Fresnel,0.0);
                float4 _GlowMask_var = tex2D(_GlowMask,TRANSFORM_TEX(i.uv0, _GlowMask));
                float3 node_6393 = (_Diffuse_var.rgb*_DiffuseGlowIntensity);
                float node_1508 = (pow(1.0-max(0,dot(i.normalDir, viewDirection)),_GlowDistance)*_EdgeIntensity);
                float _ToonGlow_var = lerp( node_1508, floor(node_1508 * _ToonGlowSteps) / (_ToonGlowSteps - 1), _ToonGlow );
                float3 node_9357 = lerp(_GlowTint.rgb,clamp(node_6393,0.01,1),clamp(lerp( (1.0 - _ToonGlow_var), _ToonGlow_var, _ReverseGlowDirection ),0.01,1));
                float3 node_62 = ((_GlowMask_var.rgb.r*node_9357 + _GlowMask_var.rgb.g*node_9357 + _GlowMask_var.rgb.b*node_9357)*_OverallGlowIntensity);
                float3 Glow = lerp((node_8362_if_leA*node_62)+(node_8362_if_leB*node_62),(_GlowMask_var.rgb*node_6393),node_8362_if_leA*node_8362_if_leB);
                float3 node_8128 = Glow;
                float node_8071_if_leA = step(abs(_WorldSpaceLightPos0.rgb),0.0);
                float node_8071_if_leB = step(0.0,abs(_WorldSpaceLightPos0.rgb));
                float3 node_8813 = (node_8128+(_AmbientMultiplier*_AmbientColor.rgb*UNITY_LIGHTMODEL_AMBIENT.rgb));
                float3 finalColor = (0.0+((((_Diffuse_var.rgb*_DiffuseColor.rgb)*_CelShading_var)+lerp( node_7775, (_CelShading_var*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_Gloss)))*_SpecColor.rgb), _BlinnPhongToggle )+lerp( 0.0, (pow(1.0-max(0,dot(normalDirection, viewDirection)),(_RimDistance*48.0+2.0))*lerp( _RimColor.rgb, (_Diffuse_var.rgb*((_RimBrightness*35.0+0.0)*_RimColor.rgb)), _RimLightTinting )), _RimLightToggle ))*((clamp((lerp( node_8128, node_7775, _OnlyGlowinDark )+lerp((node_8071_if_leA*node_8813)+(node_8071_if_leB*_LightColor0.rgb),node_8813,node_8071_if_leA*node_8071_if_leB)),0.0,_MaxLightBrightness)+_LightTint.rgb)*(_LightIntensity*35.0+0.0))));
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _DiffuseColor;
            uniform float _Gloss;
            uniform float4 _SpecColor;
            uniform float _LightIntensity;
            uniform float _Cutoff;
            uniform fixed _BlinnPhongToggle;
            uniform float _RimDistance;
            uniform fixed _RimLightToggle;
            uniform float4 _RimColor;
            uniform float _RimBrightness;
            uniform fixed _RimLightTinting;
            uniform sampler2D _CutoffTexture; uniform float4 _CutoffTexture_ST;
            uniform float _Distancerough;
            uniform float _Distancefine;
            uniform float _Dithering;
            uniform fixed _DistanceFade;
            uniform float4 _LightTint;
            uniform fixed _CelShading;
            uniform float _ToonStep;
            uniform float _ToonRamp;
            uniform float _MaxLightBrightness;
            uniform float _ToonShadowBrightness;
            uniform float4 _AmbientColor;
            uniform float _ToonShadowContrast;
            uniform float _AmbientMultiplier;
            float3 GetVRCameraDist(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            uniform float _DiffuseGlowIntensity;
            uniform sampler2D _GlowMask; uniform float4 _GlowMask_ST;
            uniform float _GlowDistance;
            uniform float4 _GlowTint;
            uniform fixed _ReverseGlowDirection;
            uniform float _EdgeIntensity;
            uniform fixed _ToonGlow;
            uniform float _ToonGlowSteps;
            uniform float _OverallGlowIntensity;
            uniform fixed _Fresnel;
            uniform fixed _OnlyGlowinDark;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 _CutoffTexture_var = tex2D(_CutoffTexture,TRANSFORM_TEX(i.uv0, _CutoffTexture));
                float3 CameraDist = GetVRCameraDist();
                float2 node_9395 = (i.uv0*_Dithering);
                float2 node_9951_skew = node_9395 + 0.2127+node_9395.x*0.3713*node_9395.y;
                float2 node_9951_rnd = 4.789*sin(489.123*(node_9951_skew));
                float node_9951 = frac(node_9951_rnd.x*node_9951_rnd.y*(1+node_9951_skew.x));
                clip(((_CutoffTexture_var.a+_Cutoff)*lerp( 1.0, (1.0 - (saturate(((_Distancefine*0.01+0.0)*distance(CameraDist,distance(i.posWorld.rgb,objPos.rgb))))*lerp((_Distancerough*0.02+0.0),node_9951,_Dithering))), _DistanceFade )) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float node_7782 = max(0,dot(lightDirection,normalDirection)); // Lambert
                float _CelShading_var = lerp( node_7782, clamp(smoothstep( 0.0, _ToonStep, floor(pow((i.uv0.r*node_7782),_ToonShadowContrast) * _ToonRamp) / (_ToonRamp - 1) ),_ToonShadowBrightness,1.0), _CelShading );
                float node_7775 = 0.0;
                float node_8362_if_leA = step(0.0,_Fresnel);
                float node_8362_if_leB = step(_Fresnel,0.0);
                float4 _GlowMask_var = tex2D(_GlowMask,TRANSFORM_TEX(i.uv0, _GlowMask));
                float3 node_6393 = (_Diffuse_var.rgb*_DiffuseGlowIntensity);
                float node_1508 = (pow(1.0-max(0,dot(i.normalDir, viewDirection)),_GlowDistance)*_EdgeIntensity);
                float _ToonGlow_var = lerp( node_1508, floor(node_1508 * _ToonGlowSteps) / (_ToonGlowSteps - 1), _ToonGlow );
                float3 node_9357 = lerp(_GlowTint.rgb,clamp(node_6393,0.01,1),clamp(lerp( (1.0 - _ToonGlow_var), _ToonGlow_var, _ReverseGlowDirection ),0.01,1));
                float3 node_62 = ((_GlowMask_var.rgb.r*node_9357 + _GlowMask_var.rgb.g*node_9357 + _GlowMask_var.rgb.b*node_9357)*_OverallGlowIntensity);
                float3 Glow = lerp((node_8362_if_leA*node_62)+(node_8362_if_leB*node_62),(_GlowMask_var.rgb*node_6393),node_8362_if_leA*node_8362_if_leB);
                float3 node_8128 = Glow;
                float node_8071_if_leA = step(abs(_WorldSpaceLightPos0.rgb),0.0);
                float node_8071_if_leB = step(0.0,abs(_WorldSpaceLightPos0.rgb));
                float3 node_8813 = (node_8128+(_AmbientMultiplier*_AmbientColor.rgb*UNITY_LIGHTMODEL_AMBIENT.rgb));
                float3 finalColor = (0.0+((((_Diffuse_var.rgb*_DiffuseColor.rgb)*_CelShading_var)+lerp( node_7775, (_CelShading_var*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_Gloss)))*_SpecColor.rgb), _BlinnPhongToggle )+lerp( 0.0, (pow(1.0-max(0,dot(normalDirection, viewDirection)),(_RimDistance*48.0+2.0))*lerp( _RimColor.rgb, (_Diffuse_var.rgb*((_RimBrightness*35.0+0.0)*_RimColor.rgb)), _RimLightTinting )), _RimLightToggle ))*((clamp((lerp( node_8128, node_7775, _OnlyGlowinDark )+lerp((node_8071_if_leA*node_8813)+(node_8071_if_leB*_LightColor0.rgb),node_8813,node_8071_if_leA*node_8071_if_leB)),0.0,_MaxLightBrightness)+_LightTint.rgb)*(_LightIntensity*35.0+0.0))));
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Cutoff;
            uniform sampler2D _CutoffTexture; uniform float4 _CutoffTexture_ST;
            uniform float _Distancerough;
            uniform float _Distancefine;
            uniform float _Dithering;
            uniform fixed _DistanceFade;
            float3 GetVRCameraDist(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);  // inserted by FixShadersRightEye.cs
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float4 _CutoffTexture_var = tex2D(_CutoffTexture,TRANSFORM_TEX(i.uv0, _CutoffTexture));
                float3 CameraDist = GetVRCameraDist();
                float2 node_9395 = (i.uv0*_Dithering);
                float2 node_9951_skew = node_9395 + 0.2127+node_9395.x*0.3713*node_9395.y;
                float2 node_9951_rnd = 4.789*sin(489.123*(node_9951_skew));
                float node_9951 = frac(node_9951_rnd.x*node_9951_rnd.y*(1+node_9951_skew.x));
                clip(((_CutoffTexture_var.a+_Cutoff)*lerp( 1.0, (1.0 - (saturate(((_Distancefine*0.01+0.0)*distance(CameraDist,distance(i.posWorld.rgb,objPos.rgb))))*lerp((_Distancerough*0.02+0.0),node_9951,_Dithering))), _DistanceFade )) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
