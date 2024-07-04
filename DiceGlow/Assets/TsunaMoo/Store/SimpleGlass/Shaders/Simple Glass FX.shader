// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Simple Glass FX"
{
	Properties
	{
		[HideInInspector]shader_is_using_thry_editor("", Float) = 0
		[HideInInspector]shader_properties_label_file("TsunaMooLabels", Float) = 0
		[HideInInspector]shader_master_label("<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}}", Float) = 0
		[Enum(None,0,Front,1,Back,2)]_Cull("Cull", Float) = 2
		[HideInInspector]LightmapFlags("LightmapFlags", Float) = 0
		[HideInInspector]DSGI("DSGI", Float) = 0
		[HideInInspector]Instancing("Instancing", Float) = 1
		[HideInInspector]m_Main("Main", Float) = 0
		[NoScaleOffset][SingleLineTexture]_AlbedoMapreference_property_Color("Albedo Map--{reference_property:_Color}}", 2D) = "white" {}
		[HideInInspector]_Color("Color + Transparency", Color) = (1,1,1,0.2039216)
		_Metaliic("Metallic Slider", Range( 0 , 1)) = 0
		_Glossiness("Smoothness Slider", Range( 0 , 1)) = 1
		_AntiAliasingVarianceSm("Anti Aliasing Variance", Range( 0 , 5)) = 0.01
		_AntiAliasingThresholdSm("Anti Aliasing Threshold", Range( 0 , 1)) = 1
		[Toggle(_NormalMap_ON)] _UseNormalMap("Enable Normal Map", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map--{reference_property:_NormalMapSlider,condition_show:{type:PROPERTY_BOOL,data:_UseNormalMap==1}}", 2D) = "bump" {}
		[HideInInspector]_NormalMapSlider("Normal Map Slider", Range( 0 , 5)) = 1
		[Vector2][Space]_Tiling("Tiling", Vector) = (1,1,0,0)
		[Vector2]_Offset("Offset", Vector) = (0,0,0,0)
		[HideInInspector]m_Rim("Rim", Float) = 0
		_EmissionColor("Color", Color) = (0.04705882,0.04705882,0.04705882,0)
		_Bias("Bias", Range( 0 , 1)) = 0
		_Scale("Scale", Range( 0 , 4)) = 4
		_Power("Power", Range( 0 , 4)) = 4
		_Strength("Strength", Range( 0 , 1)) = 0.75
		[HideInInspector]footer_discord("", Float) = 0
		[HideInInspector]footer_booth("", Float) = 0
		[HideInInspector]footer_github("", Float) = 0
		[HideInInspector]footer_patreon("", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull]
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _NormalMap_ON
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

		#pragma exclude_renderers xbox360 xboxone xboxseries ps4 playstation psp2 n3ds wiiu switch 
		#pragma surface surf Standard alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			half3 worldNormal;
			INTERNAL_DATA
		};

		uniform half shader_properties_label_file;
		uniform half LightmapFlags;
		uniform half shader_is_using_thry_editor;
		uniform half footer_patreon;
		uniform half Instancing;
		uniform half footer_discord;
		uniform half footer_github;
		uniform half m_Main;
		uniform half m_Rim;
		uniform half DSGI;
		uniform half _Cull;
		uniform half shader_master_label;
		uniform half footer_booth;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform half2 _Tiling;
		uniform half2 _Offset;
		SamplerState sampler_linear_repeat;
		uniform half _NormalMapSlider;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_AlbedoMapreference_property_Color);
		uniform half4 _Color;
		uniform half4 _EmissionColor;
		uniform half _Bias;
		uniform half _Scale;
		uniform half _Power;
		uniform half _Strength;
		uniform half _Metaliic;
		uniform half _Glossiness;
		uniform half _AntiAliasingVarianceSm;
		uniform half _AntiAliasingThresholdSm;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord263 = i.uv_texcoord * _Tiling + _Offset;
			#ifdef _NormalMap_ON
				half3 staticSwitch258 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_linear_repeat, uv_TexCoord263 ), _NormalMapSlider );
			#else
				half3 staticSwitch258 = half3(0,0,1);
			#endif
			half3 NormalData277 = staticSwitch258;
			o.Normal = NormalData277;
			o.Albedo = ( SAMPLE_TEXTURE2D( _AlbedoMapreference_property_Color, sampler_linear_repeat, uv_TexCoord263 ) * _Color ).rgb;
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 newWorldNormal266 = (WorldNormalVector( i , NormalData277 ));
			half fresnelNdotV211 = dot( newWorldNormal266, ase_worldViewDir );
			half fresnelNode211 = ( _Bias + _Scale * pow( 1.0 - fresnelNdotV211, _Power ) );
			half temp_output_288_0 = ( fresnelNode211 * _Strength );
			half4 clampResult240 = clamp( ( _EmissionColor * temp_output_288_0 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Emission = clampResult240.rgb;
			o.Metallic = _Metaliic;
			half3 temp_output_1_0_g320 = newWorldNormal266;
			half3 temp_output_4_0_g320 = ddx( temp_output_1_0_g320 );
			half dotResult6_g320 = dot( temp_output_4_0_g320 , temp_output_4_0_g320 );
			half3 temp_output_5_0_g320 = ddy( temp_output_1_0_g320 );
			half dotResult8_g320 = dot( temp_output_5_0_g320 , temp_output_5_0_g320 );
			half lerpResult282 = lerp( _Glossiness , 0.0 , sqrt( sqrt( saturate( min( ( ( ( dotResult6_g320 + dotResult8_g320 ) * _AntiAliasingVarianceSm ) * 2.0 ) , _AntiAliasingThresholdSm ) ) ) ));
			half clampResult272 = clamp( ( lerpResult282 + ( temp_output_288_0 * 0.5 * lerpResult282 ) ) , 0.0 , 1.0 );
			o.Smoothness = clampResult272;
			half clampResult223 = clamp( ( _Color.a + temp_output_288_0 ) , 0.0 , 1.0 );
			o.Alpha = clampResult223;
		}

		ENDCG
	}
	CustomEditor "Thry.ShaderEditor"
}
/*ASEBEGIN
Version=18921
259.2;768.8;1513;639;-2304.833;78.37531;1;True;False
Node;AmplifyShaderEditor.Vector2Node;265;1277.993,-421.377;Inherit;False;Property;_Offset;Offset;18;0;Create;True;0;0;0;False;1;Vector2;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;264;1278.983,-554.126;Inherit;False;Property;_Tiling;Tiling;17;0;Create;True;0;0;0;False;2;Vector2;Space;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;255;1725.301,-714.7183;Inherit;False;Property;_NormalMapSlider;Normal Map Slider;16;1;[HideInInspector];Create;False;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerStateNode;262;1793.739,-504.0954;Inherit;False;0;0;0;1;-1;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;263;1498.222,-538.4319;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;257;2361.396,-814.1044;Inherit;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;256;2006.004,-635.3441;Inherit;True;Property;_BumpMap;Normal Map--{reference_property:_NormalMapSlider,condition_show:{type:PROPERTY_BOOL,data:_UseNormalMap==1}};15;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;258;2586.786,-661.1118;Inherit;False;Property;_UseNormalMap;Enable Normal Map;14;0;Create;False;0;0;0;False;0;False;0;0;0;True;_NormalMap_ON;Toggle;2;Key0;Key1;Create;True;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;2975.761,-667.017;Inherit;False;NormalData;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;1753.586,431.4426;Inherit;False;277;NormalData;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;214;1899.703,684.465;Inherit;False;Property;_Scale;Scale;22;0;Create;True;0;0;0;False;0;False;4;2;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;1900.775,780.9266;Inherit;False;Property;_Power;Power;23;0;Create;True;0;0;0;False;0;False;4;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;1897.558,605.1521;Inherit;False;Property;_Bias;Bias;21;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;266;1947.944,439.6055;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;280;1857.85,169.9939;Inherit;False;Property;_AntiAliasingVarianceSm;Anti Aliasing Variance;12;0;Create;False;0;0;0;False;0;False;0.01;0.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;279;1856.63,258.3389;Inherit;False;Property;_AntiAliasingThresholdSm;Anti Aliasing Threshold;13;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;281;2153.019,114.2588;Inherit;False;GSAA;-1;;320;a3c5c6cf9d1dd744589a5e3146f5a3a1;0;3;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;211;2235.352,564.3677;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;2292.65,417.3541;Inherit;False;Property;_Strength;Strength;24;0;Create;True;0;0;0;False;0;False;0.75;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;2282.228,-18.37154;Inherit;False;Property;_Glossiness;Smoothness Slider;11;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;282;2591.897,77.10664;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;288;2657.609,431.0939;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;186;2036.334,-149.3847;Inherit;False;Property;_Color;Color + Transparency;9;1;[HideInInspector];Create;False;0;0;0;False;0;False;1,1,1,0.2039216;1,1,1,0.2039216;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;285;2591.387,-161.6513;Inherit;False;Property;_EmissionColor;Color;20;0;Create;False;0;0;0;False;0;False;0.04705882,0.04705882,0.04705882,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;273;2809.478,123.7998;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;260;2025.834,-408.3521;Inherit;True;Property;_AlbedoMapreference_property_Color;Albedo Map--{reference_property:_Color}};8;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;276;3012.616,-18.39443;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;241;3003.78,962.458;Inherit;False;670.9143;415.154;;9;250;249;248;247;246;245;243;242;284;ThryEditor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;217;3031.312,415.223;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;3003.517,-160.502;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;249;3220.526,1023.105;Inherit;False;Property;shader_master_label;<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}};2;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;248;3040.037,1247.239;Inherit;False;Property;footer_booth;;26;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;3359.842,1246.157;Inherit;False;Property;footer_github;;27;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;245;3410.415,1019.12;Inherit;False;Property;shader_properties_label_file;TsunaMooLabels;1;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;3292.231,831.1091;Inherit;False;Property;_Cull;Cull;3;1;[Enum];Create;False;0;3;None;0;Front;1;Back;2;0;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;223;3237.122,430.275;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;246;3182.057,1134.759;Inherit;False;Property;m_Main;Main;7;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;272;3236.096,-32.04724;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;247;3191.892,1248.873;Inherit;False;Property;footer_patreon;;28;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;1643.814,726.9521;Inherit;False;Property;DSGI;DSGI;5;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;240;3215.105,-178.9393;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;284;3341.336,1140.785;Inherit;False;Property;m_Rim;Rim;19;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;3045.184,1022.817;Inherit;False;Property;shader_is_using_thry_editor;;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;1641.994,644.4053;Inherit;False;Property;LightmapFlags;LightmapFlags;4;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;283;3081.267,824.3247;Inherit;False;Property;Instancing;Instancing;6;1;[HideInInspector];Create;False;0;0;0;True;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;242;3508.79,1246.137;Inherit;False;Property;footer_discord;;25;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;208;2501.559,285.3619;Inherit;False;Property;_Metaliic;Metallic Slider;10;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;2600.834,-416.3521;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3617.379,-277.8437;Half;False;True;-1;2;Thry.ShaderEditor;0;0;Standard;TsunaMoo/Simple Glass FX;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;9;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;nomrt;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;210;-1;0;True;212;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;263;0;264;0
WireConnection;263;1;265;0
WireConnection;256;1;263;0
WireConnection;256;5;255;0
WireConnection;256;7;262;0
WireConnection;258;1;257;0
WireConnection;258;0;256;0
WireConnection;277;0;258;0
WireConnection;266;0;278;0
WireConnection;281;1;266;0
WireConnection;281;10;280;0
WireConnection;281;12;279;0
WireConnection;211;0;266;0
WireConnection;211;1;213;0
WireConnection;211;2;214;0
WireConnection;211;3;215;0
WireConnection;282;0;209;0
WireConnection;282;2;281;0
WireConnection;288;0;211;0
WireConnection;288;1;289;0
WireConnection;273;0;288;0
WireConnection;273;2;282;0
WireConnection;260;1;263;0
WireConnection;260;7;262;0
WireConnection;276;0;282;0
WireConnection;276;1;273;0
WireConnection;217;0;186;4
WireConnection;217;1;288;0
WireConnection;227;0;285;0
WireConnection;227;1;288;0
WireConnection;223;0;217;0
WireConnection;272;0;276;0
WireConnection;240;0;227;0
WireConnection;261;0;260;0
WireConnection;261;1;186;0
WireConnection;0;0;261;0
WireConnection;0;1;277;0
WireConnection;0;2;240;0
WireConnection;0;3;208;0
WireConnection;0;4;272;0
WireConnection;0;9;223;0
ASEEND*/
//CHKSM=46CA36355B2FABACDFC0A2538C71BD0B5179E783