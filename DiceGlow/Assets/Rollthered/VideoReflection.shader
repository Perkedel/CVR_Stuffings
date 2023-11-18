// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / VideoReflection"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "black" {}
		_AlbedoTexture("Albedo Texture", 2D) = "black" {}
		_normalmap("normalmap", 2D) = "bump" {}
		_ao("ao", 2D) = "white" {}
		_RealtimeRoughness("RealtimeRoughness", Float) = 0
		_RealtimeReflection("RealtimeReflection", Color) = (1,1,1,0)
		_Albedo("Albedo", Color) = (0,0,0,0)
		[Toggle]_MappingMode("MappingMode", Float) = 0
		_BakedMetallic("BakedMetallic", Range( 0 , 1)) = 0
		_BakedSmoothness("BakedSmoothness", Range( 0 , 1)) = 0
		_RoughnessMap("RoughnessMap", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _normalmap;
		uniform float4 _normalmap_ST;
		uniform float4 _Albedo;
		uniform sampler2D _AlbedoTexture;
		uniform float4 _AlbedoTexture_ST;
		uniform float4 _RealtimeReflection;
		uniform sampler2D _MainTex;
		uniform float _MappingMode;
		uniform sampler2D _RoughnessMap;
		uniform float4 _RoughnessMap_ST;
		uniform float _RealtimeRoughness;
		uniform float _BakedMetallic;
		uniform float _BakedSmoothness;
		uniform sampler2D _ao;
		uniform float4 _ao_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_normalmap = i.uv_texcoord * _normalmap_ST.xy + _normalmap_ST.zw;
			float3 tex2DNode22 = UnpackNormal( tex2D( _normalmap, uv_normalmap ) );
			o.Normal = tex2DNode22;
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			o.Albedo = ( _Albedo * tex2D( _AlbedoTexture, uv_AlbedoTexture ) ).rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 temp_cast_1 = (ase_worldViewDir.z).xxx;
			float2 uv_RoughnessMap = i.uv_texcoord * _RoughnessMap_ST.xy + _RoughnessMap_ST.zw;
			float4 tex2DNode35 = tex2D( _RoughnessMap, uv_RoughnessMap );
			o.Emission = ( _RealtimeReflection * tex2Dlod( _MainTex, float4( ( tex2DNode22 + (( _MappingMode )?( temp_cast_1 ):( ase_worldViewDir )) ).xy, 0, ( tex2DNode35 * _RealtimeRoughness ).r) ) ).rgb;
			o.Metallic = _BakedMetallic;
			o.Smoothness = ( tex2DNode35 * _BakedSmoothness ).r;
			float2 uv_ao = i.uv_texcoord * _ao_ST.xy + _ao_ST.zw;
			o.Occlusion = tex2D( _ao, uv_ao ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
746.4;73.6;788;711;960.3566;885.0408;2.084522;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;19;-917.6442,54.99542;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;23;-378.4135,304.4572;Inherit;False;Property;_RealtimeRoughness;RealtimeRoughness;4;0;Create;True;0;0;0;False;0;False;0;14.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-856.7627,-358.2342;Inherit;True;Property;_normalmap;normalmap;2;0;Create;True;0;0;0;True;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;24;-660.0232,228.9868;Inherit;False;Property;_MappingMode;MappingMode;7;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;35;-302.3549,-2.677711;Inherit;True;Property;_RoughnessMap;RoughnessMap;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-467.2592,37.20084;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;51.33164,112.5116;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;26;-49.484,-553.7444;Inherit;False;Property;_RealtimeReflection;RealtimeReflection;5;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;29;167.3436,-64.08595;Inherit;False;Property;_Albedo;Albedo;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.07699998,0.07699998,0.07699998,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;362.7829,-155.7775;Inherit;False;Property;_BakedSmoothness;BakedSmoothness;9;0;Create;True;0;0;0;False;0;False;0;0.894;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-59.07946,239.2118;Inherit;True;Property;_AlbedoTexture;Albedo Texture;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-306.2469,-210.0952;Inherit;True;Property;_MainTex;_MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;e1c9f065f3f6b8c44b0e55634a46baf1;True;0;False;black;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;369.0849,-439.2983;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;390.4197,108.2303;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;30;430.3226,315.0237;Inherit;True;Property;_ao;ao;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;363.3943,-229.3884;Inherit;False;Property;_BakedMetallic;BakedMetallic;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;728.4065,-339.3438;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;945.6594,-59.63562;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Rollthered / VideoReflection;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;19;0
WireConnection;24;1;19;3
WireConnection;21;0;22;0
WireConnection;21;1;24;0
WireConnection;34;0;35;0
WireConnection;34;1;23;0
WireConnection;20;1;21;0
WireConnection;20;2;34;0
WireConnection;25;0;26;0
WireConnection;25;1;20;0
WireConnection;28;0;29;0
WireConnection;28;1;27;0
WireConnection;33;0;35;0
WireConnection;33;1;32;0
WireConnection;0;0;28;0
WireConnection;0;1;22;0
WireConnection;0;2;25;0
WireConnection;0;3;31;0
WireConnection;0;4;33;0
WireConnection;0;5;30;0
ASEEND*/
//CHKSM=5995C5CC6598D1F2474031AEFA1D3342198720DD