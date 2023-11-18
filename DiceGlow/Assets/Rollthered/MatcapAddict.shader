// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / Matcap Abuser"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "black" {}
		_Matcap("Matcap", 2D) = "black" {}
		_ao("ao", 2D) = "white" {}
		_emission("emission", 2D) = "black" {}
		_NormalMap("NormalMap", 2D) = "black" {}
		_NormalScale("NormalScale", Float) = 1
		_matcaprotation("matcap rotation", Range( 0 , 360)) = 0
		_ScaleMatcap("ScaleMatcap", Range( 0.01 , 1)) = 0.01
		[Toggle]_RotateScaleSwitch("Rotate/Scale Switch", Float) = 0
		[HDR]_MatcapColor("MatcapColor", Color) = (1,1,1,0)
		[HDR]_emissioncolor("emission color", Color) = (1,1,1,0)
		[HideInInspector]_max("max", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			float3 worldNormal;
		};

		uniform float4 _emissioncolor;
		uniform sampler2D _emission;
		uniform float4 _emission_ST;
		uniform sampler2D _ao;
		uniform float4 _ao_ST;
		uniform float4 _MatcapColor;
		uniform sampler2D _Matcap;
		uniform float _RotateScaleSwitch;
		uniform float _max;
		uniform float _ScaleMatcap;
		uniform float _matcaprotation;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalScale;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;


		float2 RemapUV4( float4 viewDir, float4 worldNormal )
		{
			float3 sampleY = float3(0,1,0);
			float3 VcrossY = cross(viewDir, sampleY);
			float3 VCYcrossV = cross(VcrossY, viewDir);
			float3 x =  viewDir;
			float3 y = VcrossY;
			float3 z = VCYcrossV;
			float4x4 tMat = {x.x,y.x,z.x,0,
					x.y,y.y,z.y,0,
					x.z,y.z,z.z,0,
					0  ,0  ,0  ,0};
			float2 remapUV = mul(worldNormal, tMat).yz;
			remapUV = remapUV * 0.5 + 0.5;
			return remapUV;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_emission = i.uv_texcoord * _emission_ST.xy + _emission_ST.zw;
			float2 uv_ao = i.uv_texcoord * _ao_ST.xy + _ao_ST.zw;
			float4 viewDir4 = float4( i.viewDir , 0.0 );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 transform3 = mul(unity_ObjectToWorld,float4( ase_vertexNormal , 0.0 ));
			float4 worldNormal4 = transform3;
			float2 localRemapUV4 = RemapUV4( viewDir4 , worldNormal4 );
			float2 temp_cast_2 = (1.0).xx;
			float2 temp_cast_3 = (_max).xx;
			float2 temp_cast_4 = (0.5).xx;
			float2 temp_cast_5 = (0.0).xx;
			float2 temp_output_38_0 = ( ( (temp_cast_4 + (localRemapUV4 - temp_cast_2) * (temp_cast_5 - temp_cast_4) / (temp_cast_3 - temp_cast_2)) * _ScaleMatcap ) + float2( 0.5,0.5 ) );
			float cos20 = cos( radians( _matcaprotation ) );
			float sin20 = sin( radians( _matcaprotation ) );
			float2 rotator20 = mul( localRemapUV4 - float2( 0.5,0.5 ) , float2x2( cos20 , -sin20 , sin20 , cos20 )) + float2( 0.5,0.5 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Emission = ( ( _emissioncolor * tex2D( _emission, uv_emission ) ) + saturate( ( tex2D( _ao, uv_ao ) * ( ( _MatcapColor * tex2D( _Matcap, ( float3( (( _RotateScaleSwitch )?( rotator20 ):( temp_output_38_0 )) ,  0.0 ) + UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalScale ) ).xy, float2( 0,0 ), float2( 0,0 ) ) ) + tex2D( _MainTex, uv_MainTex ) ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
1084;73;834;927;2204.548;1597.52;1.56289;True;False
Node;AmplifyShaderEditor.NormalVertexDataNode;1;-1665.716,218.7073;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;3;-1411.991,133.4376;Inherit;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;2;-1215.626,-114.7833;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;43;-1565.098,-1625.212;Inherit;False;Constant;_min;min;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1613.098,-1302.212;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1577.098,-1422.212;Inherit;False;Property;_max;max;11;1;[HideInInspector];Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1606.098,-1206.212;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;4;-875.9583,-58.75555;Float;False;$float3 sampleY = float3(0,1,0)@$float3 VcrossY = cross(viewDir, sampleY)@$float3 VCYcrossV = cross(VcrossY, viewDir)@$$float3 x =  viewDir@$float3 y = VcrossY@$float3 z = VCYcrossV@$$float4x4 tMat = {x.x,y.x,z.x,0,$		x.y,y.y,z.y,0,$		x.z,y.z,z.z,0,$		0  ,0  ,0  ,0}@$$float2 remapUV = mul(worldNormal, tMat).yz@$remapUV = remapUV * 0.5 + 0.5@$return remapUV@;2;False;2;True;viewDir;FLOAT4;0,0,0,0;In;;Float;False;True;worldNormal;FLOAT4;0,0,0,0;In;;Float;False;RemapUV;True;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2125.778,-416.7727;Inherit;False;Property;_matcaprotation;matcap rotation;6;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1630.487,-1060.171;Inherit;False;Property;_ScaleMatcap;ScaleMatcap;7;0;Create;True;0;0;0;False;0;False;0.01;1;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;34;-1331.816,-1445.891;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1003.758,-1349.469;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;29;-1802.219,-454.0175;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-1398.071,-954.925;Inherit;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;65;-1496.557,-717.6135;Inherit;False;Property;_NormalScale;NormalScale;5;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-984.4445,-1159.017;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;20;-621.1653,-409.8246;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;63;-1274.625,-744.1817;Inherit;True;Property;_NormalMap;NormalMap;4;0;Create;True;0;0;0;True;0;False;-1;None;None;True;0;False;black;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;51;-758.159,-925.9197;Inherit;False;Property;_RotateScaleSwitch;Rotate/Scale Switch;8;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-910.4734,-844.207;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;53;-307.4585,-1333.085;Inherit;False;Property;_MatcapColor;MatcapColor;9;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-468.6621,-1038.878;Inherit;True;Property;_Matcap;Matcap;1;0;Create;True;0;0;0;False;0;False;-1;None;7c40f8d71a4f895449eb7fd63b2541c1;True;0;False;black;Auto;False;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-194.473,-681.2978;Inherit;True;Property;_MainTex;_MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;0.9071798,-925.7628;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;321.5255,-972.9985;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;57;154.2863,-538.105;Inherit;True;Property;_ao;ao;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;502.3876,-522.0387;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;602.3547,-705.908;Inherit;True;Property;_emission;emission;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;62;837.6613,-904.0588;Inherit;False;Property;_emissioncolor;emission color;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;58;502.3873,-284.6161;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1023.315,-588.0898;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;832.6371,-345.3114;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;867.0958,-180.2986;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / Matcap Abuser;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;0
WireConnection;4;0;2;0
WireConnection;4;1;3;0
WireConnection;34;0;4;0
WireConnection;34;1;43;0
WireConnection;34;2;44;0
WireConnection;34;3;45;0
WireConnection;34;4;46;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;29;0;30;0
WireConnection;38;0;35;0
WireConnection;38;1;41;0
WireConnection;20;0;4;0
WireConnection;20;2;29;0
WireConnection;63;5;65;0
WireConnection;51;0;38;0
WireConnection;51;1;20;0
WireConnection;64;0;51;0
WireConnection;64;1;63;0
WireConnection;15;1;64;0
WireConnection;52;0;53;0
WireConnection;52;1;15;0
WireConnection;55;0;52;0
WireConnection;55;1;54;0
WireConnection;56;0;57;0
WireConnection;56;1;55;0
WireConnection;58;0;56;0
WireConnection;61;0;62;0
WireConnection;61;1;59;0
WireConnection;60;0;61;0
WireConnection;60;1;58;0
WireConnection;0;2;60;0
ASEEND*/
//CHKSM=360C1B108213D373AE6001A1D48928787F3B1E8D