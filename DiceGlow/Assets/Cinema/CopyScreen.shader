// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CopyScreen"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
		_RedContribution("Red Contribution", Range( 0 , 1)) = 0
		_GreenContribution("Green Contribution", Range( 0 , 1)) = 0
		_BlueContribution("Blue Contribution", Range( 0 , 1)) = 0
		_Width("Width", Float) = 1920
		_Height("Height", Float) = 1080
		_Border("Border", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _Width;
			uniform float _Border;
			uniform float _Height;
			uniform float _RedContribution;
			uniform float _GreenContribution;
			uniform float _BlueContribution;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
				float2 texCoord1 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_47_0 = ( _Width + ( _Border * 2.0 ) );
				float2 appendResult50 = (float2(( temp_output_47_0 / _Width ) , ( temp_output_47_0 / _Height )));
				float2 appendResult57 = (float2(( ( _Border / temp_output_47_0 ) * -1.0 ) , ( ( ( ( ( _Width - _Height ) / 2.0 ) + _Border ) / temp_output_47_0 ) * -1.0 )));
				float2 temp_output_2_0 = (texCoord1*appendResult50 + ( appendResult57 * appendResult50 ));
				float4 tex2DNode6 = tex2D( _MainTex, temp_output_2_0 );
				float2 break21 = temp_output_2_0;
				float temp_output_36_0 = ( ( ( tex2DNode6.r * _RedContribution ) + ( tex2DNode6.g * _GreenContribution ) + ( tex2DNode6.b * _BlueContribution ) ) * ( step( break21.x , 1.0 ) * step( 0.0 , break21.x ) * step( 0.0 , break21.y ) * step( break21.y , 1.0 ) ) );
				float4 appendResult40 = (float4(temp_output_36_0 , temp_output_36_0 , temp_output_36_0 , temp_output_36_0));
				
				
				finalColor = appendResult40;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18707
39;91;1870;834;2372.135;-127.2369;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;44;-2050.409,382.3726;Inherit;False;Property;_Height;Height;5;0;Create;True;0;0;False;0;False;1080;1080;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-2050.409,510.3726;Inherit;False;Property;_Border;Border;6;0;Create;True;0;0;False;0;False;1;15.28;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2049.409,255.3726;Inherit;False;Property;_Width;Width;4;0;Create;True;0;0;False;0;False;1920;1920;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;64;-1777.135,595.2369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;53;-1855.135,641.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1663.409,481.3726;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;63;-1747.135,561.2369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;62;-1597.135,619.2369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;55;-1694.135,642.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1567.135,257.2369;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;59;-1581.135,593.2369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-1566.135,641.2369;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;51;-1406.135,513.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;60;-1405.135,641.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1277.135,641.2369;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;49;-1406.135,385.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-1406.135,255.2369;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-1278.135,514.2369;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;50;-1153.135,256.2369;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-1150.135,513.2369;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1023,2;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-939.135,517.2369;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2;-637,2;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-382.9301,50.71991;Inherit;False;Property;_RedContribution;Red Contribution;1;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-383.9304,-130.2801;Inherit;True;Property;_MainTex;Main Tex;0;0;Create;True;0;0;False;0;False;-1;None;ef90257f195c85248bc47ade54226278;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-380.9301,186.7199;Inherit;False;Property;_BlueContribution;Blue Contribution;3;0;Create;True;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;21;-506.9301,259.7199;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;33;-382.9301,117.7199;Inherit;False;Property;_GreenContribution;Green Contribution;2;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;20;-317.9301,256.7199;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;23;-321.4301,510.2199;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1.069946,33.71989;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;2.069946,128.7199;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;24;-92.42999,511.2199;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;2.069946,-63.28011;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-93.93005,257.7199;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;161.0699,257.7199;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;194.0699,1.71991;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;455.1698,132.0199;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;707.9809,130.9189;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;4;-1024,386;Inherit;False;Constant;_Offset;Offset;0;0;Create;True;0;0;False;0;False;-0.0005208334,-0.3898149;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;3;-1023,257;Inherit;False;Constant;_Scale;Scale;0;0;Create;True;0;0;False;0;False;1.001042,1.77963;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;39;900.2998,130.7001;Float;False;True;-1;2;ASEMaterialInspector;100;1;CopyScreen;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;64;0;45;0
WireConnection;53;0;43;0
WireConnection;53;1;44;0
WireConnection;46;0;45;0
WireConnection;63;0;45;0
WireConnection;62;0;64;0
WireConnection;55;0;53;0
WireConnection;47;0;43;0
WireConnection;47;1;46;0
WireConnection;59;0;63;0
WireConnection;61;0;55;0
WireConnection;61;1;62;0
WireConnection;51;0;59;0
WireConnection;51;1;47;0
WireConnection;60;0;61;0
WireConnection;60;1;47;0
WireConnection;56;0;60;0
WireConnection;49;0;47;0
WireConnection;49;1;44;0
WireConnection;48;0;47;0
WireConnection;48;1;43;0
WireConnection;52;0;51;0
WireConnection;50;0;48;0
WireConnection;50;1;49;0
WireConnection;57;0;52;0
WireConnection;57;1;56;0
WireConnection;58;0;57;0
WireConnection;58;1;50;0
WireConnection;2;0;1;0
WireConnection;2;1;50;0
WireConnection;2;2;58;0
WireConnection;6;1;2;0
WireConnection;21;0;2;0
WireConnection;20;1;21;0
WireConnection;23;1;21;1
WireConnection;28;0;6;2
WireConnection;28;1;33;0
WireConnection;29;0;6;3
WireConnection;29;1;34;0
WireConnection;24;0;21;1
WireConnection;27;0;6;1
WireConnection;27;1;30;0
WireConnection;22;0;21;0
WireConnection;25;0;22;0
WireConnection;25;1;20;0
WireConnection;25;2;23;0
WireConnection;25;3;24;0
WireConnection;35;0;27;0
WireConnection;35;1;28;0
WireConnection;35;2;29;0
WireConnection;36;0;35;0
WireConnection;36;1;25;0
WireConnection;40;0;36;0
WireConnection;40;1;36;0
WireConnection;40;2;36;0
WireConnection;40;3;36;0
WireConnection;39;0;40;0
ASEEND*/
//CHKSM=7494576D2F14241BF18F93AA040FA28FEF0A814F