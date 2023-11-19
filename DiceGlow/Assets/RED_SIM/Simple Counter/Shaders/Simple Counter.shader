// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Simple Counter"
{
	Properties
	{
		[HDR]_Color("Color", Color) = (1,1,1,0)
		[NoScaleOffset]_SpriteSheet("Sprite Sheet", 2D) = "white" {}
		_Columns("Columns", Float) = 5
		_Rows("Rows", Float) = 2
		[IntRange]_DisplayLength("Display Length", Range( 1 , 6)) = 3
		_Value("Value", Float) = 1
		[Enum(Show Zeros,0,Right,1,Left,2)]_Align("Align", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Culling("Culling", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Culling]
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _SpriteSheet;
		uniform float _DisplayLength;
		uniform float _Columns;
		uniform float _Rows;
		uniform float _Value;
		uniform float _Align;
		uniform float4 _Color;
		uniform float _Culling;


		int MyCustomExpression67( int Value, int DigitNum )
		{
			return (Value % DigitNum) * 10 / DigitNum;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float temp_output_11_0 = max( round( _DisplayLength ) , 1.0 );
			float DisplayLength82 = temp_output_11_0;
			float2 appendResult7 = (float2(DisplayLength82 , 1.0));
			float2 uv_TexCoord4 = i.uv_texcoord * appendResult7;
			float temp_output_57_0_g24 = round( _Columns );
			float temp_output_58_0_g24 = round( _Rows );
			float2 appendResult7_g24 = (float2(temp_output_57_0_g24 , temp_output_58_0_g24));
			float totalFrames39_g24 = ( temp_output_57_0_g24 * temp_output_58_0_g24 );
			float2 appendResult8_g24 = (float2(totalFrames39_g24 , temp_output_58_0_g24));
			float temp_output_25_0 = round( abs( _Value ) );
			int Value67 = (int)temp_output_25_0;
			float2 uv_TexCoord14 = i.uv_texcoord + float2( -1,0 );
			float DigitsCount83 = ceil( log10( ( max( temp_output_25_0 , 1.0 ) + 0.5 ) ) );
			float AlignMode102 = _Align;
			float lerpResult99 = lerp( 0.0 , ( DisplayLength82 - DigitsCount83 ) , saturate( ( AlignMode102 - 1.0 ) ));
			float temp_output_92_0 = ( ( temp_output_11_0 * uv_TexCoord14.x ) + lerpResult99 );
			float temp_output_18_0 = ceil( -temp_output_92_0 );
			int DigitNum67 = (int)round( pow( 10.0 , temp_output_18_0 ) );
			int localMyCustomExpression67 = MyCustomExpression67( Value67 , DigitNum67 );
			float temp_output_35_0_g24 = frac( ( ( (float)localMyCustomExpression67 + 1E-06 ) / totalFrames39_g24 ) );
			float2 appendResult29_g24 = (float2(temp_output_35_0_g24 , ( 1.0 - temp_output_35_0_g24 )));
			float4 tex2DNode1 = tex2D( _SpriteSheet, ( ( frac( uv_TexCoord4 ) / appendResult7_g24 ) + ( floor( ( appendResult8_g24 * appendResult29_g24 ) ) / appendResult7_g24 ) ) );
			o.Emission = ( tex2DNode1 * _Color ).rgb;
			float temp_output_59_0 = ( ( 1.0 - tex2DNode1.a ) / 0.5 );
			float temp_output_94_0 = saturate( temp_output_18_0 );
			float lerpResult116 = lerp( temp_output_94_0 , ( temp_output_94_0 * saturate( ceil( ( temp_output_92_0 + DigitsCount83 ) ) ) ) , saturate( AlignMode102 ));
			float Mask95 = lerpResult116;
			o.Alpha = ( saturate( ( ( 1.0 - temp_output_59_0 ) / fwidth( temp_output_59_0 ) ) ) * ( Mask95 + ( 0.0 * _Culling ) ) );
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
			AlphaToMask Off
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
-1958;44;1920;895;895.9363;655.1656;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;3;-1556.501,-30.5;Inherit;False;Property;_Value;Value;6;0;Create;True;0;0;0;False;0;False;1;359.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;74;-1403.495,-27.9165;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-1163.414,103.511;Inherit;False;770.5187;167.3442;Digits count;5;83;79;78;77;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RoundOpNode;25;-1288.699,-25.3806;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;80;-1113.414,153.511;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-980.1622,153.8552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2758.303,-227.6499;Inherit;False;Property;_DisplayLength;Display Length;5;1;[IntRange];Create;True;0;0;0;False;0;False;3;6;1;6;0;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;9;-2479.867,-223.5069;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;124;-3135.724,327.1246;Inherit;False;960.0266;367.3333;Align Left;8;102;88;103;89;101;90;99;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Log10OpNode;78;-857.1973,154.5775;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;79;-738.8956,154.5773;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-3085.724,553.2499;Inherit;False;Property;_Align;Align;7;1;[Enum];Create;True;0;3;Show Zeros;0;Right;1;Left;2;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;11;-2342.867,-222.5069;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-2926.762,554.0032;Inherit;False;AlignMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-613.5836,147.4756;Inherit;False;DigitsCount;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-2165.555,-228.9755;Inherit;False;DisplayLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-2737.703,468.1066;Inherit;False;83;DigitsCount;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;103;-2701.131,559.4579;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-2742.703,380.1068;Inherit;False;82;DisplayLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;101;-2542.762,559.0032;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2469.824,55.20343;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-1,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;90;-2539.703,400.1066;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-2215.824,48.20343;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;99;-2357.697,377.1246;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;-2071.33,50.70644;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;15;-1937.824,53.20343;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;18;-1767.824,52.20343;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;13;-1586,52.5;Inherit;True;False;2;0;FLOAT;10;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;125;-2122.283,373.301;Inherit;False;706.0297;308.896;Align right;4;114;105;110;122;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1942.397,-225.2;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RoundOpNode;50;-1353.597,52.84839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-2072.283,445.8658;Inherit;False;83;DigitsCount;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1777.2,-246.9;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1072.942,-178.3042;Inherit;False;Property;_Columns;Columns;2;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;5;-1353.367,-246.6551;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;67;-1120.411,-23.00092;Inherit;False;return (Value % DigitNum) * 10 / DigitNum@;0;Create;2;True;Value;INT;0;In;;Inherit;False;True;DigitNum;INT;0;In;;Inherit;False;My Custom Expression;True;False;0;;False;2;0;INT;0;False;1;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;-1875.304,429.8422;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1068.941,-104.3042;Inherit;False;Property;_Rows;Rows;4;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;129;-862.2705,-249.1576;Inherit;False;Simple Flipbook;-1;;24;df7dab081b5a2ad45bd1b2c7a541f57c;0;4;13;FLOAT2;1,0;False;4;FLOAT;3;False;5;FLOAT;3;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;122;-1754.042,428.197;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;66;-323.1071,-256.3351;Inherit;False;799.6777;325;A2C;6;63;59;58;60;61;62;;1,0.5668886,0,1;0;0
Node;AmplifyShaderEditor.SaturateNode;94;-1568.84,289.5336;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-653.5894,-282.5004;Inherit;True;Property;_SpriteSheet;Sprite Sheet;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;4fb172659ad3cfd469b04fb26f139769;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;117;-1508.359,729.5021;Inherit;False;102;AlignMode;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;114;-1581.254,423.301;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;63;-273.1071,-181.2646;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;118;-1332.368,735.9017;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-1347.502,398.1454;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;116;-1179.956,307.3936;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;59;-116.4284,-181.3353;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1029.94,301.3461;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FWidthOpNode;60;16.57175,-135.3353;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;58;6.571755,-206.3351;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;126;46.91217,189.8615;Inherit;False;Property;_Culling;Culling;8;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;166.7665,93.12384;Inherit;False;95;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;61;160.5712,-189.3353;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;202.9122,170.8615;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;62;278.571,-185.3353;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;128;381.9122,129.8615;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;64;544.7791,-354.4765;Inherit;False;Property;_Color;Color;0;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;753.0637,-448.1656;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;583.2316,-114.3287;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;920.0016,-399.4718;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;RED_SIM/Simple Counter;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;AlphaTest;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;3;-1;-1;-1;0;True;0;0;True;126;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;74;0;3;0
WireConnection;25;0;74;0
WireConnection;80;0;25;0
WireConnection;77;0;80;0
WireConnection;9;0;8;0
WireConnection;78;0;77;0
WireConnection;79;0;78;0
WireConnection;11;0;9;0
WireConnection;102;0;98;0
WireConnection;83;0;79;0
WireConnection;82;0;11;0
WireConnection;103;0;102;0
WireConnection;101;0;103;0
WireConnection;90;0;89;0
WireConnection;90;1;88;0
WireConnection;16;0;11;0
WireConnection;16;1;14;1
WireConnection;99;1;90;0
WireConnection;99;2;101;0
WireConnection;92;0;16;0
WireConnection;92;1;99;0
WireConnection;15;0;92;0
WireConnection;18;0;15;0
WireConnection;13;1;18;0
WireConnection;7;0;82;0
WireConnection;50;0;13;0
WireConnection;4;0;7;0
WireConnection;5;0;4;0
WireConnection;67;0;25;0
WireConnection;67;1;50;0
WireConnection;110;0;92;0
WireConnection;110;1;105;0
WireConnection;129;13;5;0
WireConnection;129;4;26;0
WireConnection;129;5;27;0
WireConnection;129;2;67;0
WireConnection;122;0;110;0
WireConnection;94;0;18;0
WireConnection;1;1;129;0
WireConnection;114;0;122;0
WireConnection;63;0;1;4
WireConnection;118;0;117;0
WireConnection;123;0;94;0
WireConnection;123;1;114;0
WireConnection;116;0;94;0
WireConnection;116;1;123;0
WireConnection;116;2;118;0
WireConnection;59;0;63;0
WireConnection;95;0;116;0
WireConnection;60;0;59;0
WireConnection;58;0;59;0
WireConnection;61;0;58;0
WireConnection;61;1;60;0
WireConnection;127;1;126;0
WireConnection;62;0;61;0
WireConnection;128;0;97;0
WireConnection;128;1;127;0
WireConnection;130;0;1;0
WireConnection;130;1;64;0
WireConnection;96;0;62;0
WireConnection;96;1;128;0
WireConnection;0;2;130;0
WireConnection;0;9;96;0
ASEEND*/
//CHKSM=62FCB04D400997A666B784CE4C77AB94FCC7E013