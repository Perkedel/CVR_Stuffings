// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uniuni/Planet"
{
	Properties
	{
		_Radius("Radius", Range( 0 , 1)) = 0.5
		_Position("Position", Vector) = (0,0,1,0)
		_Axis("Axis", Vector) = (-0.2,1,0.2,0)
		_RotationSpeed("RotationSpeed", Float) = 0.01
		_EdgeSharpness("EdgeSharpness", Float) = 80
		[NoScaleOffset][SingleLineTexture]_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		[NoScaleOffset][SingleLineTexture]_MetallicSmoothness("Metallic Smoothness", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothenss("Smoothenss", Range( 0 , 1)) = 0.5
		[NoScaleOffset][Normal][SingleLineTexture]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("NormalScale", Range( -1 , 1)) = 0.3
		_TillingU("TillingU", Float) = 1
		_TillingV("TillingV", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.6
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog 
		struct Input
		{
			float3 viewDir;
			float3 worldNormal;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float3 _Position;
		uniform float _Radius;
		uniform float _EdgeSharpness;
		uniform sampler2D _Albedo;
		uniform float _RotationSpeed;
		uniform float3 _Axis;
		uniform float _TillingU;
		uniform float _TillingV;
		uniform float4 _Color;
		uniform sampler2D _Normal;
		uniform float _NormalScale;
		uniform sampler2D _MetallicSmoothness;
		uniform float _Metallic;
		uniform float _Smoothenss;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float3 normalizeResult4 = normalize( _Position );
			float dotResult5 = dot( i.viewDir , normalizeResult4 );
			float3 normalizeResult15 = normalize( ( ( i.viewDir * ( dotResult5 + sqrt( ( ( ( dotResult5 * dotResult5 ) - 1.0 ) + ( _Radius * _Radius ) ) ) ) ) - normalizeResult4 ) );
			float3 worldNormal107 = normalizeResult15;
			float dotResult71 = dot( i.viewDir , worldNormal107 );
			float hemiMask77 = ceil( -dotResult5 );
			float mask170 = ( saturate( ( dotResult71 * dotResult71 * _EdgeSharpness ) ) * hemiMask77 );
			SurfaceOutputStandard s96 = (SurfaceOutputStandard ) 0;
			float mulTime34 = _Time.y * _RotationSpeed;
			float2 appendResult35 = (float2(mulTime34 , 0.0));
			float3 normalizeResult20 = normalize( -_Axis );
			float3 positionVector48 = normalizeResult4;
			float3 normalizeResult51 = normalize( cross( positionVector48 , normalizeResult20 ) );
			float3 normalizeResult56 = normalize( cross( normalizeResult20 , normalizeResult51 ) );
			float dotResult54 = dot( worldNormal107 , normalizeResult56 );
			float dotResult52 = dot( worldNormal107 , normalizeResult51 );
			float dotResult21 = dot( worldNormal107 , normalizeResult20 );
			float2 appendResult30 = (float2(atan2( dotResult54 , dotResult52 ) , acos( dotResult21 )));
			float2 appendResult159 = (float2(( 2.0 * UNITY_PI ) , UNITY_PI));
			float2 appendResult180 = (float2(_TillingU , _TillingV));
			float2 UV114 = ( ( appendResult30 / appendResult159 ) * appendResult180 );
			float2 temp_output_33_0 = ( appendResult35 + UV114 );
			float2 temp_output_103_0 = abs( UV114 );
			float2 DDX115 = ddx( temp_output_103_0 );
			float2 DDY116 = ddy( temp_output_103_0 );
			s96.Albedo = ( tex2D( _Albedo, temp_output_33_0, DDX115, DDY116 ) * _Color * mask170 ).rgb;
			float3 tex2DNode118 = UnpackScaleNormal( tex2D( _Normal, temp_output_33_0, DDX115, DDY116 ), _NormalScale );
			float3 normalizeResult124 = normalize( cross( normalizeResult20 , worldNormal107 ) );
			float3 worldTangent128 = normalizeResult124;
			float3 normalizeResult127 = normalize( cross( normalizeResult124 , worldNormal107 ) );
			float3 worldBitangent130 = normalizeResult127;
			float3 normalizeResult138 = normalize( ( ( tex2DNode118.r * worldTangent128 ) + ( tex2DNode118.g * worldBitangent130 ) + ( tex2DNode118.b * worldNormal107 ) ) );
			s96.Normal = normalizeResult138;
			s96.Emission = float3( 0,0,0 );
			float4 tex2DNode186 = tex2D( _MetallicSmoothness, temp_output_33_0, DDX115, DDY116 );
			s96.Metallic = ( tex2DNode186.r * _Metallic );
			s96.Smoothness = ( tex2DNode186.a * _Smoothenss );
			s96.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi96 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g96 = UnityGlossyEnvironmentSetup( s96.Smoothness, data.worldViewDir, s96.Normal, float3(0,0,0));
			gi96 = UnityGlobalIllumination( data, s96.Occlusion, s96.Normal, g96 );
			#endif

			float3 surfResult96 = LightingStandard ( s96, viewDir, gi96 ).rgb;
			surfResult96 += s96.Emission;

			#ifdef UNITY_PASS_FORWARDADD//96
			surfResult96 -= s96.Emission;
			#endif//96
			c.rgb = surfResult96;
			c.a = mask170;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;-1080;1920;1058;-1888.395;541.496;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;65;224,-880;Inherit;False;2233.608;400.4217;WorldNormal;18;107;15;14;13;177;18;7;48;12;11;10;8;2;9;5;1;4;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;3;240,-624;Inherit;False;Property;_Position;Position;1;0;Create;True;0;0;0;False;0;False;0,0,1;0,0.95,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;4;416,-624;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1;400,-784;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;5;624,-688;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;896,-832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;768,-736;Inherit;False;Property;_Radius;Radius;0;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;1040,-736;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;1040,-832;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;1200,-800;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;96,144;Inherit;False;2364.084;542.3253;UVMaping;26;17;114;181;183;59;180;159;30;157;179;160;58;55;36;54;21;52;172;56;53;166;51;26;20;50;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;17;144,448;Inherit;False;Property;_Axis;Axis;2;0;Create;True;0;0;0;False;0;False;-0.2,1,0.2;0.2,1,-0.32;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SqrtOpNode;12;1328,-800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;18;1488,-832;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;191;320,448;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;1488,-688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;624,-560;Inherit;False;positionVector;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;20;448,448;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;386.9012,343.2964;Inherit;False;48;positionVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;177;1705.198,-611.8188;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;1776,-784;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.01;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;26;688,368;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;1936,-752;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;166;640,352;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;15;2080,-752;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;51;832,368;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;53;1008,288;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;2240,-752;Inherit;False;worldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;56;1152,288;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;172;1104,208;Inherit;False;107;worldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;52;1392,320;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;21;1392,432;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;54;1392,208;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ACosOpNode;36;1552,432;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;55;1552,208;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;58;1392,528;Inherit;False;1;0;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;160;1392,592;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;1712,304;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;157;1808,464;Inherit;False;Property;_TillingU;TillingU;12;0;Create;True;0;0;0;False;0;False;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;179;1808,544;Inherit;False;Property;_TillingV;TillingV;13;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;159;1584,560;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;180;1952,512;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;59;1840,304;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;183;768,640;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;2112,304;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;165;1152,944;Inherit;False;1309;414.8042;Tangent, Bitangent vector;3;148;125;147;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;1040,-448;Inherit;False;1419.039;560.1333;Mask;5;170;105;80;112;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;147;1472,992;Inherit;False;617;158;tangent;3;128;124;123;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;106;1744,704;Inherit;False;716.864;209.2001;Mip;6;116;115;64;63;103;168;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;182;1060.048,1003.337;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;2240,304;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;1200,1136;Inherit;False;107;worldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;111;1072,-400;Inherit;False;554.3297;138.8357;OneSideMask;3;77;76;74;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;112;1072,-240;Inherit;False;768.8501;325;EdgeMask;6;82;81;85;71;70;173;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;1760,784;Inherit;False;114;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CrossProductOpNode;123;1520,1040;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;124;1680,1040;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;192;2480,-128;Inherit;False;Property;_RotationSpeed;RotationSpeed;3;0;Create;True;0;0;0;False;0;False;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;173;1088,-48;Inherit;False;107;worldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;70;1104,-192;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;148;1840,1184;Inherit;False;592;155;bitangent;3;130;127;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NegateNode;74;1120,-352;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;103;1936,784;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DdyOpNode;64;2096,832;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DdxOpNode;63;2096,752;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;85;1328,-32;Inherit;False;Property;_EdgeSharpness;EdgeSharpness;4;0;Create;True;0;0;0;False;0;False;80;529.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;34;2656,-128;Inherit;False;1;0;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;71;1312,-128;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;76;1248,-352;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;126;1888,1232;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;2816,-128;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;1520,-128;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;30;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;1408,-352;Inherit;False;hemiMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;127;2048,1232;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;146;2963.36,738.4948;Inherit;False;1385.1;378.4;NormalMapVector;12;143;138;137;135;131;133;134;132;136;118;184;185;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;2240,752;Inherit;False;DDX;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;2768,-32;Inherit;False;114;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;2240,832;Inherit;False;DDY;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;2208,1232;Inherit;False;worldBitangent;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;3077.36,866.4947;Inherit;False;115;DDX;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;82;1664,-128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;2976,-80;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;143;2997.36,1026.495;Inherit;False;Property;_NormalScale;NormalScale;11;0;Create;True;0;0;0;False;0;False;0.3;0.45;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;1872,-48;Inherit;False;77;hemiMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;128;1872,1040;Inherit;False;worldTangent;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;3077.36,946.4947;Inherit;False;116;DDY;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;3653.36,1026.495;Inherit;False;107;worldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;118;3317.36,866.4947;Inherit;True;Property;_Normal;Normal;10;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;ab683c724a1272142893921a8acec1f7;True;0;True;bump;Auto;True;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;136;3637.36,914.4947;Inherit;False;130;worldBitangent;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;3653.36,802.4947;Inherit;False;128;worldTangent;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;2080,-128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;170;2224,-128;Inherit;False;mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;176;3136,64;Inherit;False;116;DDY;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;3136,-16;Inherit;False;115;DDX;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;189;3136,464;Inherit;False;116;DDY;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;3136,384;Inherit;False;115;DDX;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;3877.36,786.4947;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;3877.36,898.4947;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;3877.36,1010.495;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;104;3456,80;Inherit;False;Property;_Color;Color;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;97;3392,528;Inherit;False;Property;_Metallic;Metallic;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;32;3360,-112;Inherit;True;Property;_Albedo;Albedo;5;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;5fa471249e4d5c444a47465191792c4d;True;0;False;white;Auto;False;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;186;3376,336;Inherit;True;Property;_MetallicSmoothness;Metallic Smoothness;7;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;153;3392,608;Inherit;False;Property;_Smoothenss;Smoothenss;9;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;137;4037.36,866.4947;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;3472,256;Inherit;False;170;mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;3744,432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;138;4165.36,866.4947;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;3760,-80;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;3744,336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;175;4512,-176;Inherit;False;170;mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;96;4464,-80;Inherit;False;Metallic;World;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4752,-336;Float;False;True;-1;6;ASEMaterialInspector;0;0;CustomLighting;uniuni/Planet;False;False;False;False;True;True;True;True;True;True;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;5;0;1;0
WireConnection;5;1;4;0
WireConnection;9;0;5;0
WireConnection;9;1;5;0
WireConnection;10;0;2;0
WireConnection;10;1;2;0
WireConnection;8;0;9;0
WireConnection;11;0;8;0
WireConnection;11;1;10;0
WireConnection;12;0;11;0
WireConnection;191;0;17;0
WireConnection;7;0;5;0
WireConnection;7;1;12;0
WireConnection;48;0;4;0
WireConnection;20;0;191;0
WireConnection;177;0;4;0
WireConnection;13;0;18;0
WireConnection;13;1;7;0
WireConnection;26;0;50;0
WireConnection;26;1;20;0
WireConnection;14;0;13;0
WireConnection;14;1;177;0
WireConnection;166;0;20;0
WireConnection;15;0;14;0
WireConnection;51;0;26;0
WireConnection;53;0;166;0
WireConnection;53;1;51;0
WireConnection;107;0;15;0
WireConnection;56;0;53;0
WireConnection;52;0;172;0
WireConnection;52;1;51;0
WireConnection;21;0;172;0
WireConnection;21;1;20;0
WireConnection;54;0;172;0
WireConnection;54;1;56;0
WireConnection;36;0;21;0
WireConnection;55;0;54;0
WireConnection;55;1;52;0
WireConnection;30;0;55;0
WireConnection;30;1;36;0
WireConnection;159;0;58;0
WireConnection;159;1;160;0
WireConnection;180;0;157;0
WireConnection;180;1;179;0
WireConnection;59;0;30;0
WireConnection;59;1;159;0
WireConnection;183;0;20;0
WireConnection;181;0;59;0
WireConnection;181;1;180;0
WireConnection;182;0;183;0
WireConnection;114;0;181;0
WireConnection;123;0;182;0
WireConnection;123;1;125;0
WireConnection;124;0;123;0
WireConnection;74;0;5;0
WireConnection;103;0;168;0
WireConnection;64;0;103;0
WireConnection;63;0;103;0
WireConnection;34;0;192;0
WireConnection;71;0;70;0
WireConnection;71;1;173;0
WireConnection;76;0;74;0
WireConnection;126;0;124;0
WireConnection;126;1;125;0
WireConnection;35;0;34;0
WireConnection;81;0;71;0
WireConnection;81;1;71;0
WireConnection;81;2;85;0
WireConnection;77;0;76;0
WireConnection;127;0;126;0
WireConnection;115;0;63;0
WireConnection;116;0;64;0
WireConnection;130;0;127;0
WireConnection;82;0;81;0
WireConnection;33;0;35;0
WireConnection;33;1;178;0
WireConnection;128;0;124;0
WireConnection;118;1;33;0
WireConnection;118;3;184;0
WireConnection;118;4;185;0
WireConnection;118;5;143;0
WireConnection;105;0;82;0
WireConnection;105;1;80;0
WireConnection;170;0;105;0
WireConnection;133;0;118;1
WireConnection;133;1;134;0
WireConnection;135;0;118;2
WireConnection;135;1;136;0
WireConnection;131;0;118;3
WireConnection;131;1;132;0
WireConnection;32;1;33;0
WireConnection;32;3;169;0
WireConnection;32;4;176;0
WireConnection;186;1;33;0
WireConnection;186;3;190;0
WireConnection;186;4;189;0
WireConnection;137;0;133;0
WireConnection;137;1;135;0
WireConnection;137;2;131;0
WireConnection;188;0;186;4
WireConnection;188;1;153;0
WireConnection;138;0;137;0
WireConnection;79;0;32;0
WireConnection;79;1;104;0
WireConnection;79;2;174;0
WireConnection;187;0;186;1
WireConnection;187;1;97;0
WireConnection;96;0;79;0
WireConnection;96;1;138;0
WireConnection;96;3;187;0
WireConnection;96;4;188;0
WireConnection;0;9;175;0
WireConnection;0;13;96;0
ASEEND*/
//CHKSM=67C03860FE236219CFB9BBB058B30A2A8C97FBEA