// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Khodrins Shaders/PBR/PBR Scrolling Emission"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_MetallicSmootheness("Metallic Smootheness", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionModifier("Emission Modifier", 2D) = "white" {}
		_ScrollDirection("Scroll Direction", Vector) = (0,0,0,0)
		_ScrollingSpeed("Scrolling Speed", Float) = 0
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

		uniform float _NormalStrength;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionModifier;
		uniform float2 _ScrollDirection;
		uniform float _ScrollingSpeed;
		uniform sampler2D _MetallicSmootheness;
		uniform float4 _MetallicSmootheness_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalStrength );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = tex2D( _Albedo, uv_Albedo ).rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float mulTime9 = _Time.y * _ScrollingSpeed;
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionColor * tex2D( _EmissionModifier, (i.uv_texcoord*2.0 + ( _ScrollDirection * float2( 0.05,0.05 ) * mulTime9 )) ).r ).rgb;
			float2 uv_MetallicSmootheness = i.uv_texcoord * _MetallicSmootheness_ST.xy + _MetallicSmootheness_ST.zw;
			float4 tex2DNode2 = tex2D( _MetallicSmootheness, uv_MetallicSmootheness );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = tex2DNode2.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18100
0;123;1870;906;2106.752;-334.4123;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;10;-1663.451,1027.313;Inherit;False;Property;_ScrollingSpeed;Scrolling Speed;8;0;Create;True;0;0;False;0;False;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1406.05,1027.312;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;14;-1406.052,773.813;Inherit;False;Property;_ScrollDirection;Scroll Direction;7;0;Create;True;0;0;False;0;False;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1442.451,1154.711;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1152.55,1022.112;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0.05,0.05;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;12;-1019.95,1154.711;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1031.65,368.2125;Inherit;False;Property;_NormalStrength;Normal Strength;3;0;Create;True;0;0;False;0;False;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-766,641;Inherit;True;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;False;-1;None;20493f8609758a64b9ba1e206bade948;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-768,1155.4;Inherit;True;Property;_EmissionModifier;Emission Modifier;6;0;Create;True;0;0;False;0;False;-1;None;9edd95568f8baca40a618439898b2ede;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-766.4501,899.9122;Inherit;False;Property;_EmissionColor;Emission Color;5;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;8,8,8,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-767,-127;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;False;-1;None;2f39a6455d92ea34cb1f783e748e7dbe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-767,129;Inherit;True;Property;_MetallicSmootheness;Metallic Smootheness;1;0;Create;True;0;0;False;0;False;-1;None;58d282aa6a80ccf4db381fa91c180142;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-767,387;Inherit;True;Property;_Normal;Normal;2;0;Create;True;0;0;False;0;False;-1;None;3e402b9a093f6f9449e7c6f6fb922175;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-382.9504,768.6126;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Khodrins Shaders/PBR/PBR Scrolling Emission;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;10;0
WireConnection;13;0;14;0
WireConnection;13;2;9;0
WireConnection;12;0;11;0
WireConnection;12;2;13;0
WireConnection;5;1;12;0
WireConnection;3;5;6;0
WireConnection;8;0;4;0
WireConnection;8;1;7;0
WireConnection;8;2;5;1
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;2;8;0
WireConnection;0;3;2;1
WireConnection;0;4;2;4
ASEEND*/
//CHKSM=200D018C0C283547DBCD784601E5FEA52531F698