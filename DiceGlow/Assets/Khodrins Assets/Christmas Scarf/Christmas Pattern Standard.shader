// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Khodrins Shaders/Christmas Pattern Standard"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Roughness("Roughness", 2D) = "black" {}
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_Oclusion("Oclusion", 2D) = "white" {}
		_Pattern("Pattern", 2D) = "white" {}
		_PatternSize("Pattern Size", Vector) = (0,0,0,0)
		_StrandMap("Strand Map", 2D) = "white" {}
		_MapSize("Map Size", Vector) = (0,0,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		_NoiseScale("Noise Scale", Float) = 0.2
		_NoiseStrengh("Noise Strengh", Float) = 0.2
		_WrapCorrection("WrapCorrection", Vector) = (0.36,0.2,0.36,0.2)
		_Emission("Emission", 2D) = "black" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionModifier("Emission Modifier", 2D) = "white" {}
		_ModifierScrolltime("Modifier Scrolltime", Float) = 1
		_ModifierScrolldirection("Modifier Scrolldirection", Vector) = (0,0,0,0)
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
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float2 _PatternSize;
		uniform float2 _MapSize;
		uniform float2 _Offset;
		uniform float _NoiseScale;
		uniform float _NoiseStrengh;
		uniform float _NormalScale;
		uniform sampler2D _Albedo;
		uniform sampler2D _Pattern;
		uniform sampler2D _StrandMap;
		uniform float4 _WrapCorrection;
		uniform sampler2D _Emission;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionModifier;
		uniform float _ModifierScrolltime;
		uniform float2 _ModifierScrolldirection;
		uniform sampler2D _Roughness;
		uniform sampler2D _Oclusion;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_55_0 = ( _PatternSize / _MapSize );
			float2 uv_TexCoord12 = i.uv_texcoord * temp_output_55_0 + _Offset;
			float simplePerlin2D59 = snoise( uv_TexCoord12*_NoiseScale );
			simplePerlin2D59 = simplePerlin2D59*0.5 + 0.5;
			float2 UVs57 = ( ( simplePerlin2D59 * _NoiseStrengh ) + uv_TexCoord12 );
			o.Normal = UnpackScaleNormal( tex2D( _Normal, UVs57 ), _NormalScale );
			float4 tex2DNode1 = tex2D( _StrandMap, UVs57 );
			float2 appendResult53 = (float2(tex2DNode1.r , tex2DNode1.g));
			float2 temp_output_68_0 = ( appendResult53 * ( 1.0 - ( float2( 1,1 ) / _MapSize ) ) );
			float2 temp_output_27_0 = step( fmod( UVs57 , float2( 1,1 ) ) , float2( 0.5,0.5 ) );
			float2 appendResult73 = (float2(_WrapCorrection.x , _WrapCorrection.y));
			float2 appendResult74 = (float2(_WrapCorrection.z , _WrapCorrection.w));
			float2 temp_output_21_0 = ( ( floor( UVs57 ) + temp_output_68_0 + ( (( temp_output_27_0 * step( appendResult73 , temp_output_68_0 ) )).xy * float2( -1,-1 ) ) + (( ( 1.0 - temp_output_27_0 ) * step( temp_output_68_0 , appendResult74 ) )).xy + ( float2( 0.5,0.5 ) / _MapSize ) ) / temp_output_55_0 );
			o.Albedo = ( tex2D( _Albedo, UVs57 ) * tex2D( _Pattern, temp_output_21_0 ) ).rgb;
			float mulTime80 = _Time.y * _ModifierScrolltime;
			o.Emission = ( tex2D( _Emission, temp_output_21_0 ) * _EmissionColor * tex2D( _EmissionModifier, ( temp_output_21_0 + ( mulTime80 * _ModifierScrolldirection ) ) ).r ).rgb;
			o.Smoothness = tex2D( _Roughness, UVs57 ).r;
			o.Occlusion = tex2D( _Oclusion, UVs57 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18921
53;463;2104;926;117.5017;550.054;1.459836;True;True
Node;AmplifyShaderEditor.Vector2Node;46;-3188.594,320.6021;Inherit;False;Property;_MapSize;Map Size;8;0;Create;True;0;0;0;False;0;False;0,0;4,6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;54;-3190.297,193.3272;Inherit;False;Property;_PatternSize;Pattern Size;6;0;Create;True;0;0;0;False;0;False;0,0;64,128;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;55;-2809.297,192.3272;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;17;-2807.286,322.6494;Inherit;False;Property;_Offset;Offset;9;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;61;-2941.212,-127.1089;Inherit;False;Property;_NoiseScale;Noise Scale;10;0;Create;True;0;0;0;False;0;False;0.2;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2554.174,129.0264;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;63;-2941.212,3.891052;Inherit;False;Property;_NoiseStrengh;Noise Strengh;11;0;Create;True;0;0;0;False;0;False;0.2;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;59;-2556.212,-128.1089;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-2266.212,1.891052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-2110.212,0.8910522;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;-1916.322,7.29611;Inherit;False;UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1767.612,-88.33481;Inherit;False;57;UVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1405,389.8673;Inherit;True;Property;_StrandMap;Strand Map;7;0;Create;True;0;0;0;False;0;False;-1;None;9c9cfbd6602dee143aa44e16d996a1ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;2;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;69;-2804.807,557.3592;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;70;-2558.763,516.399;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;53;-1087.134,387.2735;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;72;-1085.826,640.7761;Inherit;False;Property;_WrapCorrection;WrapCorrection;12;0;Create;True;0;0;0;False;0;False;0.36,0.2,0.36,0.2;0.71,0.69,0.05,0.18;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-860.9965,387.1783;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.8,0.8;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FmodOpNode;26;-1405.139,127.9532;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-805.826,586.7761;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;27;-1154.261,128.8086;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;28;-508.8651,386.6861;Inherit;True;2;0;FLOAT2;0.36,0;False;1;FLOAT2;0.532,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;74;-794.826,713.7761;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-252.8653,376.6861;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;36;-253.3287,627.1655;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;33;-506.3291,629.1655;Inherit;True;2;0;FLOAT2;1,1;False;1;FLOAT2;0.2,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-66.32862,629.1655;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;13;-1410.21,-128.8253;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;31;3.67146,371.1651;Inherit;True;FLOAT2;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;388.1902,770.8994;Inherit;False;Property;_ModifierScrolltime;Modifier Scrolltime;16;0;Create;True;0;0;0;False;0;False;1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;195.6714,374.1651;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-1,-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;66;-55.16399,81.24347;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;38;195.6713,628.1655;Inherit;True;FLOAT2;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;56;-2807.074,451.4355;Inherit;False;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;80;609.1896,770.8994;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;81;610.4897,896.9993;Inherit;False;Property;_ModifierScrolldirection;Modifier Scrolldirection;17;0;Create;True;0;0;0;False;0;False;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;14;448.9511,113.5117;Inherit;True;5;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;828.8896,770.8994;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;21;776.1261,116.8001;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;1022.59,770.8993;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1785.628,643.8908;Inherit;False;Property;_NormalScale;Normal Scale;3;0;Create;True;0;0;0;False;0;False;1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;76;1155.193,772.7332;Inherit;False;Property;_EmissionColor;Emission Color;14;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;16,16,16,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;79;1152.59,961.9995;Inherit;True;Property;_EmissionModifier;Emission Modifier;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;75;1151.763,544.6658;Inherit;True;Property;_Emission;Emission;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;1157.302,-138.2908;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;99c9b85eb516503488c7d0b99553d1a9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;1158.944,119.8198;Inherit;True;Property;_Pattern;Pattern;5;0;Create;True;0;0;0;False;0;False;-1;None;67081223c27eb35419d5fd06ccfedb44;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1407,895.8672;Inherit;True;Property;_Normal;Normal;2;0;Create;True;0;0;0;False;0;False;-1;None;93234c73b6ac27e4ea357c61739d67fa;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;1539.193,639.7332;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;85;1155.096,-383.5889;Inherit;True;Property;_Roughness;Roughness;1;0;Create;True;0;0;0;False;0;False;-1;None;1b62cf27221022545931c8dae5e15cc3;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;25;1521.021,1265.819;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1669.233,129.219;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;45;1154.348,342.3582;Inherit;True;Property;_Oclusion;Oclusion;4;0;Create;True;0;0;0;False;0;False;-1;None;3ba2d2d6849c3bf449d48f1343a6e933;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2049.088,131.4423;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Khodrins Shaders/Christmas Pattern Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;55;0;54;0
WireConnection;55;1;46;0
WireConnection;12;0;55;0
WireConnection;12;1;17;0
WireConnection;59;0;12;0
WireConnection;59;1;61;0
WireConnection;62;0;59;0
WireConnection;62;1;63;0
WireConnection;60;0;62;0
WireConnection;60;1;12;0
WireConnection;57;0;60;0
WireConnection;1;1;58;0
WireConnection;69;1;46;0
WireConnection;70;0;69;0
WireConnection;53;0;1;1
WireConnection;53;1;1;2
WireConnection;68;0;53;0
WireConnection;68;1;70;0
WireConnection;26;0;58;0
WireConnection;73;0;72;1
WireConnection;73;1;72;2
WireConnection;27;0;26;0
WireConnection;28;0;73;0
WireConnection;28;1;68;0
WireConnection;74;0;72;3
WireConnection;74;1;72;4
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;36;0;27;0
WireConnection;33;0;68;0
WireConnection;33;1;74;0
WireConnection;37;0;36;0
WireConnection;37;1;33;0
WireConnection;13;0;58;0
WireConnection;31;0;29;0
WireConnection;32;0;31;0
WireConnection;66;0;13;0
WireConnection;38;0;37;0
WireConnection;56;1;46;0
WireConnection;80;0;84;0
WireConnection;14;0;66;0
WireConnection;14;1;68;0
WireConnection;14;2;32;0
WireConnection;14;3;38;0
WireConnection;14;4;56;0
WireConnection;82;0;80;0
WireConnection;82;1;81;0
WireConnection;21;0;14;0
WireConnection;21;1;55;0
WireConnection;78;0;21;0
WireConnection;78;1;82;0
WireConnection;79;1;78;0
WireConnection;75;1;21;0
WireConnection;22;1;58;0
WireConnection;18;1;21;0
WireConnection;2;1;58;0
WireConnection;2;5;24;0
WireConnection;77;0;75;0
WireConnection;77;1;76;0
WireConnection;77;2;79;1
WireConnection;85;1;58;0
WireConnection;25;0;2;0
WireConnection;23;0;22;0
WireConnection;23;1;18;0
WireConnection;45;1;58;0
WireConnection;0;0;23;0
WireConnection;0;1;25;0
WireConnection;0;2;77;0
WireConnection;0;4;85;1
WireConnection;0;5;45;1
ASEEND*/
//CHKSM=EEBEDCF5445B93E8C795A2BD8360FED4BBC018A9