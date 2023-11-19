// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Glow/Standard"
{
	Properties
	{
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		[NoScaleOffset]_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Scale", Range( 0 , 1)) = 0
		[NoScaleOffset]_EmissionMap("Emission", 2D) = "white" {}
		[NoScaleOffset]_GlowMask("Glow Mask", 2D) = "white" {}
		[HDR]_EmissionColor("Color", Color) = (0,0,0,0)
		[NoScaleOffset]_MetallicGlossMap("Metallic & Smoothness", 2D) = "white" {}
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		[Gamma]_Metallic("Metallic", Range( 0 , 1)) = 0
		[NoScaleOffset]_OcclusionMap("Occlusion", 2D) = "white" {}
		_OcclusionStrength("Strength", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform sampler2D _GlowMask;
		uniform float _Metallic;
		uniform sampler2D _MetallicGlossMap;
		uniform float _Glossiness;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV35 = uv0_MainTex;
			float3 Normal11 = UnpackScaleNormal( tex2D( _BumpMap, UV35 ), _BumpScale );
			o.Normal = Normal11;
			float4 Albedo5 = ( _Color * tex2D( _MainTex, UV35 ) );
			o.Albedo = Albedo5.rgb;
			float2 uv_TexCoord45 = i.uv_texcoord * float2( -1,1 ) + float2( 1,0 );
			float4 Emission16 = ( _EmissionColor * tex2D( _EmissionMap, UV35 ) * tex2D( _GlowMask, uv_TexCoord45 ).r );
			o.Emission = Emission16.rgb;
			float4 tex2DNode18 = tex2D( _MetallicGlossMap, UV35 );
			float Metallic24 = ( _Metallic * tex2DNode18.r );
			o.Metallic = Metallic24;
			float Smoothness21 = ( tex2DNode18.a * _Glossiness );
			o.Smoothness = Smoothness21;
			float lerpResult42 = lerp( 1.0 , tex2D( _OcclusionMap, UV35 ).g , _OcclusionStrength);
			float Occlusion31 = lerpResult42;
			o.Occlusion = Occlusion31;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1924;32;1906;987;1822.83;450.4965;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1343.375,-304.5203;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;-1116.019,-304.8432;Float;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-1302.344,1339.224;Inherit;False;35;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1335.905,48.20313;Inherit;False;35;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-1341.527,700.4767;Inherit;False;35;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-1322.143,1651.824;Inherit;False;35;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-1402.606,905.9966;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;-1,1;False;1;FLOAT2;1,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1146,24;Inherit;True;Property;_MainTex;Albedo;0;0;Create;False;0;0;False;0;-1;None;6b5d792336d84b94b98aaa3290dffdc5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-1428,368;Float;False;Property;_BumpScale;Scale;3;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-1061,497;Float;False;Property;_EmissionColor;Color;6;1;[HDR];Create;False;0;0;False;0;0,0,0,0;5.516001,2.341503,0.7706178,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;43;-1154.198,878.4474;Inherit;True;Property;_GlowMask;Glow Mask;5;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;d80dc41411ce8374294bf0ac4770b515;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;37;-1335.527,280.4767;Inherit;False;35;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;2;-1061,-145;Float;False;Property;_Color;Color;1;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1124.238,1316.469;Inherit;True;Property;_MetallicGlossMap;Metallic & Smoothness;7;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1107.04,1819.106;Float;False;Property;_OcclusionStrength;Strength;11;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-1153,677;Inherit;True;Property;_EmissionMap;Emission;4;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;1518a12cffe71bd4e8101c08400e55a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;-1123.04,1627.106;Inherit;True;Property;_OcclusionMap;Occlusion;10;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;de33ef60e12461b4ba883c91c64c28c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-1112.238,1509.47;Float;False;Property;_Glossiness;Smoothness;8;0;Create;False;0;0;False;0;0.5;0.299;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1117.238,1221.47;Float;False;Property;_Metallic;Metallic;9;1;[Gamma];Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-776,-59;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;9;-1154,257;Inherit;True;Property;_BumpMap;Normal;2;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;b57c1a9408d5f0e47afff75d4ebe6fb2;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-791,586;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-813.238,1461.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-807.238,1295.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;42;-793.6937,1717.921;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-656.238,1455.47;Float;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-625,-64;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-638.04,1713.106;Float;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-657.238,1289.47;Float;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-835,256;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-624,581;Float;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-244.6098,17.90436;Inherit;False;16;Emission;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;7;-242.6096,-118.0956;Inherit;False;5;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-247.9649,224.1659;Inherit;False;31;Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-243.833,86.26373;Inherit;False;24;Metallic;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-268.7586,152.7608;Inherit;False;21;Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-242.6096,-50.09583;Inherit;False;11;Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;22.56539,-81.46602;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;RED_SIM/Glow/Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;True;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;34;0
WireConnection;1;1;36;0
WireConnection;43;1;45;0
WireConnection;18;1;39;0
WireConnection;13;1;38;0
WireConnection;28;1;40;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;9;1;37;0
WireConnection;9;5;10;0
WireConnection;15;0;14;0
WireConnection;15;1;13;0
WireConnection;15;2;43;1
WireConnection;20;0;18;4
WireConnection;20;1;19;0
WireConnection;23;0;22;0
WireConnection;23;1;18;1
WireConnection;42;1;28;2
WireConnection;42;2;29;0
WireConnection;21;0;20;0
WireConnection;5;0;3;0
WireConnection;31;0;42;0
WireConnection;24;0;23;0
WireConnection;11;0;9;0
WireConnection;16;0;15;0
WireConnection;0;0;7;0
WireConnection;0;1;12;0
WireConnection;0;2;17;0
WireConnection;0;3;26;0
WireConnection;0;4;27;0
WireConnection;0;5;32;0
ASEEND*/
//CHKSM=932910593BE0346CFF736F6D29887108826F5177