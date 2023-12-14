// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/FakeInnerLightPositionBaseLine"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_MOS("MOS", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("NormalScale", Float) = 1
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColorBase("EmissionColorBase", Color) = (0,0,0,0)
		[HDR]_EmissionColorLight("EmissionColorLight", Color) = (1,1,1,0)
		_diffusion("diffusion", Float) = 0.15
		_PointA("PointA", Vector) = (0,0,0.5,0)
		_PointB("PointB", Vector) = (1,1,0.5,0)
		[Toggle]_GaussianDiffuse("GaussianDiffuse", Float) = 1
		[Toggle]_SmoothToneMap("SmoothToneMap", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _NormalScale;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Color;
		uniform float _SmoothToneMap;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColorBase;
		uniform float _GaussianDiffuse;
		uniform float3 _PointA;
		uniform float3 _PointB;
		uniform float _diffusion;
		uniform float4 _EmissionColorLight;
		uniform sampler2D _MOS;
		uniform float4 _MOS_ST;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * _Color ).rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode42 = tex2D( _Emission, uv_Emission );
			float4 appendResult416 = (float4(_PointA , 1.0));
			float4 transform417 = mul(unity_ObjectToWorld,appendResult416);
			float3 temp_output_418_0 = (transform417).xyz;
			float4 appendResult419 = (float4(_PointB , 1.0));
			float4 transform420 = mul(unity_ObjectToWorld,appendResult419);
			float3 temp_output_421_0 = (transform420).xyz;
			float3 temp_output_232_0 = ( temp_output_418_0 - temp_output_421_0 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 temp_output_234_0 = cross( temp_output_232_0 , ase_worldViewDir );
			float3 normalizeResult236 = normalize( cross( temp_output_234_0 , temp_output_232_0 ) );
			float3 normalizeResult233 = normalize( temp_output_232_0 );
			float3 normalizeResult169 = normalize( temp_output_234_0 );
			float3 WorldSpacePointA336 = temp_output_418_0;
			float3 break253 = mul( float3x3(normalizeResult236, normalizeResult233, normalizeResult169), ( _WorldSpaceCameraPos - WorldSpacePointA336 ) );
			float3 normalizeResult330 = normalize( ( WorldSpacePointA336 - _WorldSpaceCameraPos ) );
			float3 normalizeResult342 = normalize( ase_worldViewDir );
			float3 ViewDirNormalized344 = normalizeResult342;
			float dotResult324 = dot( normalizeResult330 , -ViewDirNormalized344 );
			float3 break306 = mul( float3x3(normalizeResult236, normalizeResult233, normalizeResult169), ViewDirNormalized344 );
			float3 WorldSpacePointB337 = temp_output_421_0;
			float temp_output_316_0 = ceil( ( ( break253.y - ( ( break253.x / break306.x ) * break306.y ) ) / distance( WorldSpacePointA336 , WorldSpacePointB337 ) ) );
			float lerpResult335 = lerp( abs( break253.z ) , distance( WorldSpacePointA336 , ( _WorldSpaceCameraPos + ( distance( WorldSpacePointA336 , _WorldSpaceCameraPos ) * dotResult324 * -ViewDirNormalized344 ) ) ) , saturate( temp_output_316_0 ));
			float3 normalizeResult356 = normalize( ( WorldSpacePointB337 - _WorldSpaceCameraPos ) );
			float dotResult360 = dot( normalizeResult356 , -ViewDirNormalized344 );
			float lerpResult350 = lerp( lerpResult335 , distance( WorldSpacePointB337 , ( _WorldSpaceCameraPos + ( distance( WorldSpacePointB337 , _WorldSpaceCameraPos ) * dotResult360 * -ViewDirNormalized344 ) ) ) , saturate( -temp_output_316_0 ));
			float4 temp_output_47_0 = ( ( tex2DNode42 * _EmissionColorBase ) + ( exp2( ( (( _GaussianDiffuse )?( ( lerpResult350 * lerpResult350 ) ):( lerpResult350 )) / -_diffusion ) ) * tex2DNode42 * _EmissionColorLight ) );
			float4 temp_cast_1 = (40.0).xxxx;
			float4 break391 = min( temp_output_47_0 , temp_cast_1 );
			float3 appendResult392 = (float3(tanh( break391.r ) , tanh( break391.g ) , tanh( break391.b )));
			o.Emission = (( _SmoothToneMap )?( float4( appendResult392 , 0.0 ) ):( temp_output_47_0 )).rgb;
			float2 uv_MOS = i.uv_texcoord * _MOS_ST.xy + _MOS_ST.zw;
			float4 tex2DNode70 = tex2D( _MOS, uv_MOS );
			o.Metallic = ( tex2DNode70.r * _Metallic );
			o.Smoothness = ( tex2DNode70.a * _Smoothness );
			o.Occlusion = tex2DNode70.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
12;-1076;1906;1051;3636.426;-202.5263;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;162;-2973.167,496;Inherit;False;4712.932;906.1855;光源描画;17;222;418;417;416;421;420;419;229;336;337;350;389;335;375;376;377;373;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;229;-2880,944;Inherit;False;Property;_PointB;PointB;12;0;Create;True;0;0;0;False;0;False;1,1,0.5;1,1,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;222;-2880,736;Inherit;False;Property;_PointA;PointA;11;0;Create;True;0;0;0;False;0;False;0,0,0.5;0,0,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;416;-2672,736;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;419;-2672,944;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;417;-2528,736;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;420;-2528,944;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;421;-2320,944;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;373;-2032,720;Inherit;False;996;374;光源直線とViewDirの最短直線を基準とした座標空間への変換行列;8;238;169;233;236;235;234;166;232;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;418;-2320,736;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;232;-1952,832;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;166;-1984,928;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;380;-1808,144;Inherit;False;646;234;ViewDirのSafeNomalizeが機能しないので;3;341;342;344;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CrossProductOpNode;234;-1792,896;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;235;-1584,768;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;341;-1760,192;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;-1984,624;Inherit;False;WorldSpacePointA;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;342;-1584,192;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;377;-960,544;Inherit;False;988.3944;380.311;Z座標が最短距離;8;286;366;378;253;262;282;374;261;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;169;-1424,896;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;233;-1424,832;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;236;-1424,768;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;261;-912,672;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;344;-1440,192;Inherit;False;ViewDirNormalized;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;366;-912,816;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;376;-720,944;Inherit;False;1556.786;435.9519;端の境界 カメラ始点の視線ベクトルがX=0となる地点が光源直線上の位置;12;349;334;348;316;315;309;307;305;306;302;345;381;;1,1,1,1;0;0
Node;AmplifyShaderEditor.MatrixFromVectors;238;-1264,800;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;345;-672,1088;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;375;-928,992;Inherit;False;1;0;FLOAT3x3;1,0,0,0,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.CommentaryNode;372;-768,-544;Inherit;False;1386.444;1008.2;末端の距離関数;2;370;371;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;374;-944,640;Inherit;False;1;0;FLOAT3x3;1,0,0,0,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;282;-656,672;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-512,592;Inherit;False;2;2;0;FLOAT3x3;0,0,0,0,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;371;-720,-16;Inherit;False;1286.509;448.2318;点と直線の距離 A点;12;340;331;329;328;327;324;320;330;325;323;346;322;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;302;-416,1024;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;337;-1984,1120;Inherit;False;WorldSpacePointB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;306;-288,1024;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;253;-368,592;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;370;-720,-480;Inherit;False;1285.315;449.4827;点と直線の距離 B点;12;351;364;357;359;362;360;361;356;355;354;353;363;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;-672,48;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;322;-688,224;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;363;-688,-240;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;346;-416,336;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;-672,-416;Inherit;False;337;WorldSpacePointB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;323;-336,240;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;305;-160,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;381;-256,1152;Inherit;False;495;218;光源直線にに長さで倍率をかけ、範囲を0-1にリマップ;3;314;338;339;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;378;-128,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;353;-416,-128;Inherit;False;344;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;325;-176,336;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-16,1024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;354;-336,-224;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;330;-192,240;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;-208,1200;Inherit;False;336;WorldSpacePointA;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;339;-208,1280;Inherit;False;337;WorldSpacePointB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;320;-336,144;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;356;-192,-224;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;355;-176,-128;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;324;-32,272;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;309;128,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;314;64,1232;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;315;272,992;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;328;-16,112;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;327;112,256;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;361;-336,-320;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;360;-32,-192;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;329;272,176;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CeilOpNode;316;400,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;112,-208;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;359;-16,-352;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;348;528,1072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;334;528,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;357;272,-288;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;286;-128,640;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;331;416,48;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;349;656,1072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;335;752,640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;351;416,-416;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;350;912,640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;389;1080,590;Inherit;False;624;314;拡散のしかた;6;385;382;384;383;388;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;387;1104,704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;384;1152,800;Inherit;False;Property;_diffusion;diffusion;10;0;Create;True;0;0;0;False;0;False;0.15;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;388;1248,640;Inherit;False;Property;_GaussianDiffuse;GaussianDiffuse;13;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;385;1312,800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;383;1472,704;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;1872,560;Inherit;False;Property;_EmissionColorBase;EmissionColorBase;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.3207547,0.3207547,0.3207547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;1808,368;Inherit;True;Property;_Emission;Emission;7;0;Create;True;0;0;0;False;0;False;-1;None;28fd5c945e5747b479f596580d7e4a4d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Exp2OpNode;382;1584,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;128;1872,816;Inherit;False;Property;_EmissionColorLight;EmissionColorLight;9;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.171983,1.171983,1.171983,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;2192,464;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2192,704;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;405;2432,688;Inherit;False;694;273;SmoothToneMaping;7;401;404;392;394;390;393;391;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;401;2448,832;Inherit;False;Constant;_max;max;23;0;Create;True;0;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;2384,576;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;404;2592,768;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;391;2704,768;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;70;2544,-80;Inherit;True;Property;_MOS;MOS;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TanhOpNode;393;2832,800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;394;2832,864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;390;2832,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;2944,16;Inherit;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;407;2848,-192;Inherit;False;Property;_NormalScale;NormalScale;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;2960,-416;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;105;2880,176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;392;2960,768;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;41;2880,-608;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;2944,112;Inherit;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;0;False;0;False;0;0.334;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;106;2928,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;3216,-512;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;73;3056,-240;Inherit;True;Property;_Normal;Normal;5;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;398;3168,576;Inherit;False;Property;_SmoothToneMap;SmoothToneMap;14;0;Create;True;0;0;0;False;0;False;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;3216,-48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;3216,64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3536,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;uniuni/FakeInnerLightPositionBaseLine;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;416;0;222;0
WireConnection;419;0;229;0
WireConnection;417;0;416;0
WireConnection;420;0;419;0
WireConnection;421;0;420;0
WireConnection;418;0;417;0
WireConnection;232;0;418;0
WireConnection;232;1;421;0
WireConnection;234;0;232;0
WireConnection;234;1;166;0
WireConnection;235;0;234;0
WireConnection;235;1;232;0
WireConnection;336;0;418;0
WireConnection;342;0;341;0
WireConnection;169;0;234;0
WireConnection;233;0;232;0
WireConnection;236;0;235;0
WireConnection;344;0;342;0
WireConnection;238;0;236;0
WireConnection;238;1;233;0
WireConnection;238;2;169;0
WireConnection;375;0;238;0
WireConnection;374;0;238;0
WireConnection;282;0;261;0
WireConnection;282;1;366;0
WireConnection;262;0;374;0
WireConnection;262;1;282;0
WireConnection;302;0;375;0
WireConnection;302;1;345;0
WireConnection;337;0;421;0
WireConnection;306;0;302;0
WireConnection;253;0;262;0
WireConnection;323;0;340;0
WireConnection;323;1;322;0
WireConnection;305;0;253;0
WireConnection;305;1;306;0
WireConnection;378;0;253;1
WireConnection;325;0;346;0
WireConnection;307;0;305;0
WireConnection;307;1;306;1
WireConnection;354;0;364;0
WireConnection;354;1;363;0
WireConnection;330;0;323;0
WireConnection;320;0;340;0
WireConnection;320;1;322;0
WireConnection;356;0;354;0
WireConnection;355;0;353;0
WireConnection;324;0;330;0
WireConnection;324;1;325;0
WireConnection;309;0;378;0
WireConnection;309;1;307;0
WireConnection;314;0;338;0
WireConnection;314;1;339;0
WireConnection;315;0;309;0
WireConnection;315;1;314;0
WireConnection;327;0;320;0
WireConnection;327;1;324;0
WireConnection;327;2;325;0
WireConnection;361;0;364;0
WireConnection;361;1;363;0
WireConnection;360;0;356;0
WireConnection;360;1;355;0
WireConnection;329;0;328;0
WireConnection;329;1;327;0
WireConnection;316;0;315;0
WireConnection;362;0;361;0
WireConnection;362;1;360;0
WireConnection;362;2;355;0
WireConnection;348;0;316;0
WireConnection;334;0;316;0
WireConnection;357;0;359;0
WireConnection;357;1;362;0
WireConnection;286;0;253;2
WireConnection;331;0;340;0
WireConnection;331;1;329;0
WireConnection;349;0;348;0
WireConnection;335;0;286;0
WireConnection;335;1;331;0
WireConnection;335;2;334;0
WireConnection;351;0;364;0
WireConnection;351;1;357;0
WireConnection;350;0;335;0
WireConnection;350;1;351;0
WireConnection;350;2;349;0
WireConnection;387;0;350;0
WireConnection;387;1;350;0
WireConnection;388;0;350;0
WireConnection;388;1;387;0
WireConnection;385;0;384;0
WireConnection;383;0;388;0
WireConnection;383;1;385;0
WireConnection;382;0;383;0
WireConnection;52;0;42;0
WireConnection;52;1;43;0
WireConnection;45;0;382;0
WireConnection;45;1;42;0
WireConnection;45;2;128;0
WireConnection;47;0;52;0
WireConnection;47;1;45;0
WireConnection;404;0;47;0
WireConnection;404;1;401;0
WireConnection;391;0;404;0
WireConnection;393;0;391;1
WireConnection;394;0;391;2
WireConnection;390;0;391;0
WireConnection;105;0;70;2
WireConnection;392;0;390;0
WireConnection;392;1;393;0
WireConnection;392;2;394;0
WireConnection;106;0;105;0
WireConnection;55;0;41;0
WireConnection;55;1;54;0
WireConnection;73;5;407;0
WireConnection;398;0;47;0
WireConnection;398;1;392;0
WireConnection;71;0;70;1
WireConnection;71;1;49;0
WireConnection;72;0;70;4
WireConnection;72;1;50;0
WireConnection;0;0;55;0
WireConnection;0;1;73;0
WireConnection;0;2;398;0
WireConnection;0;3;71;0
WireConnection;0;4;72;0
WireConnection;0;5;106;0
ASEEND*/
//CHKSM=2D1AC9B80CCDC861FF318711E260C5E7B24938F5