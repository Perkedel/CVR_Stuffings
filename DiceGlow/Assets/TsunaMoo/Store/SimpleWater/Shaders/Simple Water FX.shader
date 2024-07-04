// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Simple Water FX"
{
	Properties
	{
		_Matcap("Matcap", 2D) = "white" {}
		[HDR]_Color("Color", Color) = (1,1,1,0)
		_Water1("Water 1", 2D) = "bump" {}
		_Strength1("Strength", Range( -2 , 3)) = 1
		_SpeedX1("Speed X", Range( -2 , 2)) = 0
		_SpeedY1("Speed Y", Range( -2 , 2)) = 0
		_Water2("Water 2", 2D) = "bump" {}
		_Strength2("Strength", Range( -2 , 3)) = 1
		_SpeedX2("Speed X", Range( -2 , 2)) = 0
		_SpeedY2("Speed Y", Range( -2 , 2)) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent+1" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			#define ASE_ABSOLUTE_VERTEX_POS 1


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityStandardBRDF.cginc"
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				half4 ase_tangent : TANGENT;
				half3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _Matcap;
			uniform sampler2D _Water1;
			uniform half4 _Water1_ST;
			uniform half _SpeedX1;
			uniform half _SpeedY1;
			uniform half _Strength1;
			uniform sampler2D _Water2;
			uniform half _SpeedX2;
			uniform half _SpeedY2;
			uniform half4 _Water2_ST;
			uniform half _Strength2;
			uniform half4 _Color;
			half2 matcapSample8( half3 viewDirection, half3 normalDirection )
			{
				half3 worldUp = float3(0,1,0);
				half3 worldViewUp = normalize(worldUp - viewDirection * dot(viewDirection, worldUp));
				half3 worldViewRight = normalize(cross(viewDirection, worldViewUp));
				half2 matcapUV = half2(dot(worldViewRight, normalDirection), dot(worldViewUp, normalDirection)) * 0.5 + 0.5;
				return matcapUV;
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				o.ase_texcoord2.xyz = ase_worldTangent;
				half3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				half ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord4.xyz = ase_worldBitangent;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(WorldPosition);
				ase_worldViewDir = Unity_SafeNormalize( ase_worldViewDir );
				half3 viewDirection8 = ase_worldViewDir;
				half2 uv_Water1 = i.ase_texcoord1.xy * _Water1_ST.xy + _Water1_ST.zw;
				half2 appendResult28 = (half2(_SpeedX1 , _SpeedY1));
				half2 appendResult31 = (half2(_SpeedX2 , _SpeedY2));
				half2 uv_Water2 = i.ase_texcoord1.xy * _Water2_ST.xy + _Water2_ST.zw;
				half3 ase_worldTangent = i.ase_texcoord2.xyz;
				half3 ase_worldNormal = i.ase_texcoord3.xyz;
				float3 ase_worldBitangent = i.ase_texcoord4.xyz;
				half3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				half3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				half3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal10 = ( UnpackScaleNormal( tex2D( _Water1, ( uv_Water1 + ( _Time.y * appendResult28 ) ) ), _Strength1 ) + UnpackScaleNormal( tex2D( _Water2, ( ( _Time.y * appendResult31 ) + uv_Water2 ) ), _Strength2 ) );
				half3 worldNormal10 = normalize( float3(dot(tanToWorld0,tanNormal10), dot(tanToWorld1,tanNormal10), dot(tanToWorld2,tanNormal10)) );
				half3 normalDirection8 = worldNormal10;
				half2 localmatcapSample8 = matcapSample8( viewDirection8 , normalDirection8 );
				
				
				finalColor = ( tex2D( _Matcap, localmatcapSample8 ) * _Color );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18921
3352;613.6;1735;841;1383.549;836.2925;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;30;-3642.947,370.8177;Inherit;True;Property;_SpeedY2;Speed Y;9;0;Create;False;0;0;0;False;0;False;0;0;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-3623.107,-103.1334;Inherit;True;Property;_SpeedY1;Speed Y;5;0;Create;False;0;0;0;False;0;False;0;0;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-3646.915,145.9665;Inherit;True;Property;_SpeedX2;Speed X;8;0;Create;False;0;0;0;False;0;False;0;-0.026;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3640.302,-330.6299;Inherit;True;Property;_SpeedX1;Speed X;4;0;Create;False;0;0;0;False;0;False;0;0.144;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-3180.016,-223.4949;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-3186.629,253.1015;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;18;-3150.62,9.67354;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-2916.442,-142.5203;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-2917.602,105.622;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-2911.417,-440.8793;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2921.3,338.4901;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;12;-2517.566,-791.1954;Float;True;Property;_Matcap;Matcap;0;0;Create;True;0;0;0;False;0;False;None;0407d0937b6005246b416856a64d4f90;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;34;-2560.878,217.874;Inherit;True;Property;_Strength2;Strength;7;0;Create;False;0;0;0;False;0;False;1;1.11;-2;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2560.231,-543.3827;Inherit;True;Property;_Strength1;Strength;3;0;Create;False;0;0;0;False;0;False;1;0.66;-2;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-2533.728,-265.148;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-2532.092,-24.39916;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-2108.256,-242.8265;Inherit;True;Property;_Water1;Water 1;2;0;Create;True;0;0;0;False;0;False;-1;None;c27307a8c223e114dba47fa1631f8e42;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2106.256,-19.82646;Inherit;True;Property;_Water2;Water 2;6;0;Create;True;0;0;0;False;0;False;-1;None;b35398d99cae1e94cac729691a20fd8e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1699.256,-118.8265;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;9;-1397.938,-493.7587;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;10;-1398.138,-198.8148;Inherit;True;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CustomExpressionNode;8;-1117.16,-463.5039;Inherit;False;half3 worldUp = float3(0,1,0)@$half3 worldViewUp = normalize(worldUp - viewDirection * dot(viewDirection, worldUp))@$half3 worldViewRight = normalize(cross(viewDirection, worldViewUp))@$half2 matcapUV = half2(dot(worldViewRight, normalDirection), dot(worldViewUp, normalDirection)) * 0.5 + 0.5@$return matcapUV@;2;Create;2;True;viewDirection;FLOAT3;0,0,0;In;;Inherit;False;True;normalDirection;FLOAT3;0,0,0;In;;Inherit;False;matcapSample;True;False;0;;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-772.7232,-587.4269;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-700.0922,-377.2726;Inherit;False;Property;_Color;Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.3065148,0.339992,0.5283019,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldReflectionVector;44;-1091.235,-885.1592;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-102.4556,-589.3036;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;42;235.4,-633.5001;Half;False;True;-1;2;ASEMaterialInspector;0;1;TsunaMoo/Simple Water FX;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;1;0;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;1;False;-1;True;3;False;-1;True;False;-1;False;-1;-1;False;-1;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;0;0;1;True;False;;False;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;31;0;32;0
WireConnection;31;1;30;0
WireConnection;24;0;18;0
WireConnection;24;1;28;0
WireConnection;20;0;18;0
WireConnection;20;1;31;0
WireConnection;25;0;26;0
WireConnection;25;1;24;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;1;1;25;0
WireConnection;1;5;33;0
WireConnection;1;7;12;1
WireConnection;2;1;21;0
WireConnection;2;5;34;0
WireConnection;2;7;12;1
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;10;0;3;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;11;0;12;0
WireConnection;11;1;8;0
WireConnection;11;7;12;1
WireConnection;48;0;11;0
WireConnection;48;1;4;0
WireConnection;42;0;48;0
ASEEND*/
//CHKSM=90933A45D467DBB77DF1B687FAE49A9BEC44B957