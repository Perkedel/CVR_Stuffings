// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Glow/Buffer"
{
	Properties
	{
		_Buffer("Buffer", 2D) = "black" {}
		_Depth("Depth", 2D) = "black" {}
		_DissolveSpeed("Dissolve Speed", Range( 0 , 0.05)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow nofog 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Depth;
		uniform float4 _Depth_ST;
		uniform sampler2D _Buffer;
		uniform float4 _Buffer_ST;
		uniform float _DissolveSpeed;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Depth = i.uv_texcoord * _Depth_ST.xy + _Depth_ST.zw;
			float2 uv_Buffer = i.uv_texcoord * _Buffer_ST.xy + _Buffer_ST.zw;
			float3 temp_cast_0 = (( ( tex2D( _Depth, uv_Depth ).r + tex2D( _Buffer, uv_Buffer ).r ) - _DissolveSpeed )).xxx;
			o.Emission = temp_cast_0;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1924;32;1906;987;1255;397.5;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-794,-61.5;Inherit;True;Property;_Depth;Depth;1;0;Create;True;0;0;False;0;-1;None;a21e2d8130c430a4ca3215ed1e3f9bc7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-794,129.5;Inherit;True;Property;_Buffer;Buffer;0;0;Create;True;0;0;False;0;-1;None;71c9e098b81a6224e8e29613030867b9;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-440,44.5;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-780,324.5;Inherit;False;Property;_DissolveSpeed;Dissolve Speed;2;0;Create;True;0;0;False;0;0;0.0036;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-294,102.5;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;RED_SIM/Glow/Buffer;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;1
WireConnection;3;1;2;1
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=496153DEBBF1AFA639430EEBC01160506E74E894