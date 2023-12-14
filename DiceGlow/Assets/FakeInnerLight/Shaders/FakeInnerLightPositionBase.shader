// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/FakeInnerLightPositionBase"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_MOS("MOS", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColorBase("EmissionColorBase", Color) = (1,1,1,0)
		_BaseBrightness("BaseBrightness", Float) = 0.2
		[HDR]_EmissionColorLight("EmissionColorLight", Color) = (1,1,1,0)
		_LightBrightness("LightBrightness", Float) = 1
		_Position("Position", Vector) = (0,0,0,0)
		_diffusion("diffusion", Float) = 0.1
		[Toggle]_GaussianDiffuse("GaussianDiffuse", Float) = 1
		[Toggle]_SmoothToneMap1("SmoothToneMap", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
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
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Color;
		uniform float _SmoothToneMap1;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColorBase;
		uniform float _BaseBrightness;
		uniform float _GaussianDiffuse;
		uniform float3 _Position;
		uniform float _diffusion;
		uniform float4 _EmissionColorLight;
		uniform float _LightBrightness;
		uniform sampler2D _MOS;
		uniform float4 _MOS_ST;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = tex2D( _Normal, uv_Normal ).rgb;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * _Color ).rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode42 = tex2D( _Emission, uv_Emission );
			float4 appendResult132 = (float4(_Position , 1.0));
			float4 transform129 = mul(unity_ObjectToWorld,appendResult132);
			float3 temp_output_135_0 = (transform129).xyz;
			float3 normalizeResult141 = normalize( ( temp_output_135_0 - _WorldSpaceCameraPos ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult157 = normalize( ase_worldViewDir );
			float3 ViewDirNormalized158 = normalizeResult157;
			float dotResult142 = dot( normalizeResult141 , -ViewDirNormalized158 );
			float temp_output_148_0 = distance( temp_output_135_0 , ( _WorldSpaceCameraPos + ( distance( temp_output_135_0 , _WorldSpaceCameraPos ) * dotResult142 * -ViewDirNormalized158 ) ) );
			float4 temp_output_47_0 = ( ( tex2DNode42 * _EmissionColorBase * _BaseBrightness ) + ( exp2( ( (( _GaussianDiffuse )?( ( temp_output_148_0 * temp_output_148_0 ) ):( temp_output_148_0 )) / -_diffusion ) ) * tex2DNode42 * _EmissionColorLight * _LightBrightness ) );
			float4 temp_cast_2 = (40.0).xxxx;
			float4 break162 = min( temp_output_47_0 , temp_cast_2 );
			float3 appendResult166 = (float3(tanh( break162.r ) , tanh( break162.g ) , tanh( break162.b )));
			o.Emission = (( _SmoothToneMap1 )?( float4( appendResult166 , 0.0 ) ):( temp_output_47_0 )).rgb;
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
12;-1076;1906;1051;2434.597;260.6531;1.749279;True;False
Node;AmplifyShaderEditor.CommentaryNode;102;-2288.4,304;Inherit;False;2794.278;867.3332;光源描画;6;135;129;132;130;147;136;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;155;-757.129,-230.2421;Inherit;False;703;236;ViewDirのSafeNomalizeが機能しないので;3;158;157;156;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;130;-2192,608;Inherit;False;Property;_Position;Position;11;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;156;-718.46,-188.7047;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;132;-2000,608;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;157;-474.1295,-180.2421;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;136;-1440,544;Inherit;False;1286.509;448.2318;点と直線の距離;11;148;146;145;144;143;142;141;140;139;138;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;129;-1856,608;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceCameraPos;137;-1408,816;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;135;-1648,608;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;158;-330.1295,-180.2421;Inherit;False;ViewDirNormalized;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;138;-1056,800;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-1136,896;Inherit;False;158;ViewDirNormalized;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;141;-912,800;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;140;-896,896;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;142;-752,832;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;143;-1056,704;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;145;-736,672;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;-608,816;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;146;-448,736;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;147;-144,544;Inherit;False;624;314;拡散のしかた;6;154;153;152;151;150;149;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;148;-304,608;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-80,768;Inherit;False;Property;_diffusion;diffusion;12;0;Create;True;0;0;0;False;0;False;0.1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-128,672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;151;80,768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;152;16,608;Inherit;False;Property;_GaussianDiffuse;GaussianDiffuse;13;0;Create;True;0;0;0;False;0;False;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;153;240,672;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;624,608;Inherit;False;Property;_EmissionColorBase;EmissionColorBase;7;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.3207547,0.3207547,0.3207547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Exp2OpNode;154;352,672;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;672,528;Inherit;False;Property;_BaseBrightness;BaseBrightness;8;0;Create;True;0;0;0;False;0;False;0.2;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;128;624,880;Inherit;False;Property;_EmissionColorLight;EmissionColorLight;9;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.171983,1.171983,1.171983,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;576,336;Inherit;True;Property;_Emission;Emission;6;0;Create;True;0;0;0;False;0;False;-1;None;28fd5c945e5747b479f596580d7e4a4d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;672,800;Inherit;False;Property;_LightBrightness;LightBrightness;10;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;928,672;Inherit;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;928,432;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;159;1152,640;Inherit;False;694;273;SmoothToneMaping;7;166;165;164;163;162;161;160;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;1120,544;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;160;1168,800;Inherit;False;Constant;_max1;max;23;0;Create;True;0;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;161;1312,736;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;162;1424,736;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;70;1200,16;Inherit;True;Property;_MOS;MOS;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TanhOpNode;165;1552,768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;164;1552,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TanhOpNode;163;1552,832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;1568,80;Inherit;False;Property;_Metallic;Metallic;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;105;1520,240;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;1600,-352;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;1520,-544;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;1568,192;Inherit;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;0;False;0;False;0;0.334;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;166;1680,736;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;73;1696,-176;Inherit;True;Property;_Normal;Normal;3;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;1856,128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;1856,-448;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;1856,16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;167;1888,544;Inherit;False;Property;_SmoothToneMap1;SmoothToneMap;14;0;Create;True;0;0;0;False;0;False;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;106;1936,240;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2224,-16;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;uniuni/FakeInnerLightPositionBase;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;132;0;130;0
WireConnection;157;0;156;0
WireConnection;129;0;132;0
WireConnection;135;0;129;0
WireConnection;158;0;157;0
WireConnection;138;0;135;0
WireConnection;138;1;137;0
WireConnection;141;0;138;0
WireConnection;140;0;139;0
WireConnection;142;0;141;0
WireConnection;142;1;140;0
WireConnection;143;0;135;0
WireConnection;143;1;137;0
WireConnection;144;0;143;0
WireConnection;144;1;142;0
WireConnection;144;2;140;0
WireConnection;146;0;145;0
WireConnection;146;1;144;0
WireConnection;148;0;135;0
WireConnection;148;1;146;0
WireConnection;149;0;148;0
WireConnection;149;1;148;0
WireConnection;151;0;150;0
WireConnection;152;0;148;0
WireConnection;152;1;149;0
WireConnection;153;0;152;0
WireConnection;153;1;151;0
WireConnection;154;0;153;0
WireConnection;45;0;154;0
WireConnection;45;1;42;0
WireConnection;45;2;128;0
WireConnection;45;3;46;0
WireConnection;52;0;42;0
WireConnection;52;1;43;0
WireConnection;52;2;51;0
WireConnection;47;0;52;0
WireConnection;47;1;45;0
WireConnection;161;0;47;0
WireConnection;161;1;160;0
WireConnection;162;0;161;0
WireConnection;165;0;162;1
WireConnection;164;0;162;0
WireConnection;163;0;162;2
WireConnection;105;0;70;2
WireConnection;166;0;164;0
WireConnection;166;1;165;0
WireConnection;166;2;163;0
WireConnection;72;0;70;4
WireConnection;72;1;50;0
WireConnection;55;0;41;0
WireConnection;55;1;54;0
WireConnection;71;0;70;1
WireConnection;71;1;49;0
WireConnection;167;0;47;0
WireConnection;167;1;166;0
WireConnection;106;0;105;0
WireConnection;0;0;55;0
WireConnection;0;1;73;0
WireConnection;0;2;167;0
WireConnection;0;3;71;0
WireConnection;0;4;72;0
WireConnection;0;5;106;0
ASEEND*/
//CHKSM=B3058746EA78400453EFE94B589B8B5BDF0D4DC8