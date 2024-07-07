// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/ToonFire"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.51
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Noise1("Noise1", 2D) = "white" {}
		_Noise1Tiling("Noise1 Tiling", Float) = 1
		_Panner1Speed("Panner 1 Speed", Float) = 1
		[Toggle]_LRAnimationToggle("L/R Animation Toggle", Float) = 1
		_XPanSpeed2("X Pan Speed 2", Float) = 0
		_LRAnimation1("L/R Animation 1", Float) = 0.25
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Noise2Size("Noise 2 Size", Float) = 6.5
		_Panner2Speed("Panner 2 Speed", Float) = 1
		_XanimationSpeed1("X animation Speed 1", Float) = 0
		[Toggle]_LRAnimationToggle2("L/R Animation Toggle 2", Float) = 1
		_LRAnimation2("L/R Animation 2", Float) = 0.25
		_Strength("Strength", Float) = 20
		_FireMask1("FireMask 1", 2D) = "white" {}
		_FlameMask2("FlameMask 2", 2D) = "white" {}
		_OuterColor("Outer Color", Color) = (0,0.647059,1,0)
		_InnerColor("Inner Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _FireMask1;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _TextureSample1;
		uniform float _LRAnimationToggle2;
		uniform float _XPanSpeed2;
		uniform float _LRAnimation2;
		uniform float _Panner2Speed;
		uniform float _Noise2Size;
		uniform sampler2D _Noise1;
		uniform float _LRAnimationToggle;
		uniform float _XanimationSpeed1;
		uniform float _LRAnimation1;
		uniform float _Panner1Speed;
		uniform float _Noise1Tiling;
		uniform float _Strength;
		uniform float4 _OuterColor;
		uniform sampler2D _FlameMask2;
		uniform float4 _InnerColor;
		uniform float _Cutoff = 0.51;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 appendResult67 = (float2(lerp(_XPanSpeed2,( _SinTime.x * ( _LRAnimation2 / 1000.0 ) ),_LRAnimationToggle2) , _Panner2Speed));
			float2 temp_cast_0 = (_Noise2Size).xx;
			float2 uv_TexCoord11 = i.uv_texcoord * temp_cast_0;
			float2 panner10 = ( 1.0 * _Time.y * appendResult67 + uv_TexCoord11);
			float2 appendResult74 = (float2(lerp(_XanimationSpeed1,( _SinTime.x * ( _LRAnimation1 / 1000.0 ) ),_LRAnimationToggle) , _Panner1Speed));
			float2 temp_cast_1 = (_Noise1Tiling).xx;
			float2 uv_TexCoord5 = i.uv_texcoord * temp_cast_1;
			float2 panner2 = ( 1.0 * _Time.y * appendResult74 + uv_TexCoord5);
			float2 appendResult34 = (float2(i.uv_texcoord.x , ( i.uv_texcoord.y + ( ( ( i.uv_texcoord.y * ( tex2D( _TextureSample0, uv_TextureSample0 ).r * 1.0 ) ) * saturate( ( tex2D( _TextureSample1, panner10 ).r + tex2D( _Noise1, panner2 ).r ) ) ) * ( 1.0 - _Strength ) ) )));
			float4 tex2DNode26 = tex2D( _FireMask1, appendResult34 );
			float4 tex2DNode27 = tex2D( _FlameMask2, appendResult34 );
			o.Emission = ( ( tex2DNode26.r * _OuterColor ) + ( tex2DNode27.g * _InnerColor ) ).rgb;
			o.Alpha = 1;
			clip( ( 1.0 - (( tex2DNode26 + tex2DNode27 )).b ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
7;192;1710;881;5100.985;-155.0384;1.467219;True;False
Node;AmplifyShaderEditor.RangedFloatNode;75;-5834.896,814.4839;Float;False;Property;_LRAnimation1;L/R Animation 1;7;0;Create;True;0;0;False;0;0.25;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-5684.706,1243.378;Float;False;Property;_LRAnimation2;L/R Animation 2;13;0;Create;True;0;0;False;0;0.25;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;71;-5637.896,682.4839;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinTimeNode;65;-5487.706,1111.378;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;70;-5379.66,1251.929;Float;False;2;0;FLOAT;0;False;1;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;72;-5529.85,823.0349;Float;False;2;0;FLOAT;0;False;1;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-5200.706,1130.378;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-5499.348,576.4429;Float;False;Property;_XanimationSpeed1;X animation Speed 1;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-5337.417,1422.642;Float;False;Property;_XPanSpeed2;X Pan Speed 2;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-5350.896,701.4839;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-5200.706,1273.378;Float;False;Property;_Panner2Speed;Panner 2 Speed;10;0;Create;True;0;0;False;0;1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-5152.536,699.2401;Float;False;Property;_Noise1Tiling;Noise1 Tiling;3;0;Create;True;0;0;False;0;1;5.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-5350.896,844.4839;Float;False;Property;_Panner1Speed;Panner 1 Speed;4;0;Create;True;0;0;False;0;1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-5317.095,961.2944;Float;False;Property;_Noise2Size;Noise 2 Size;9;0;Create;True;0;0;False;0;6.5;4.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;82;-5034.374,1066.734;Float;False;Property;_LRAnimationToggle2;L/R Animation Toggle 2;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;-5160.262,476.6432;Float;False;Property;_LRAnimationToggle;L/R Animation Toggle;5;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-4910.536,663.2401;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-5075.096,925.2944;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;74;-5095.896,779.4839;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-4945.706,1208.378;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;10;-4684.364,1004.678;Float;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-4604.297,766.0236;Float;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;63;-3956.956,1034.633;Float;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;False;0;92d79879d68ac6c4e98d72151e1d1293;28c7aad1372ff114b90d330f8a2dd938;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-4075.97,449.4579;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;576e7ce81f24b664ab35b0f5cf624176;576e7ce81f24b664ab35b0f5cf624176;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-3990.131,779.6401;Float;True;Property;_Noise1;Noise1;2;0;Create;True;0;0;False;0;410a46a9277384647a83349548c64d25;410a46a9277384647a83349548c64d25;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-3498.771,570.3573;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-3196.536,850.8405;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-3571.676,335.2445;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-2470.42,958.6647;Float;False;Property;_Strength;Strength;14;0;Create;True;0;0;False;0;20;13.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;18;-3002.467,853.5479;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-3221.878,504.058;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-2756.733,751.6172;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;57;-2261.505,863.0729;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-2488.385,82.02779;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-2338.047,527.1699;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2080.842,113.1289;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-1921.208,230.8006;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-1614.519,195.9739;Float;True;Property;_FireMask1;FireMask 1;15;0;Create;True;0;0;False;0;cb8334718dc795049abbfc229d302152;cb8334718dc795049abbfc229d302152;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-1462.847,786.6678;Float;True;Property;_FlameMask2;FlameMask 2;16;0;Create;True;0;0;False;0;cb8334718dc795049abbfc229d302152;cb8334718dc795049abbfc229d302152;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-999.8097,643.1705;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;30;-1539.802,505.4213;Float;False;Property;_OuterColor;Outer Color;17;0;Create;True;0;0;False;0;0,0.647059,1,0;1,0.6617647,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;32;-1433.074,1141.979;Float;False;Property;_InnerColor;Inner Color;18;0;Create;True;0;0;False;0;0,0,0,0;0.7275862,0.3851927,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;54;-709.9088,640.5706;Float;False;False;False;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1116.563,358.0973;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-989.4202,996.2762;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;55;-487.6087,644.4703;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-639.592,368.9609;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Naito/ToonFire;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.51;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;70;0;69;0
WireConnection;72;0;75;0
WireConnection;68;0;65;1
WireConnection;68;1;70;0
WireConnection;73;0;71;1
WireConnection;73;1;72;0
WireConnection;82;0;83;0
WireConnection;82;1;68;0
WireConnection;84;0;85;0
WireConnection;84;1;73;0
WireConnection;5;0;6;0
WireConnection;11;0;13;0
WireConnection;74;0;84;0
WireConnection;74;1;76;0
WireConnection;67;0;82;0
WireConnection;67;1;66;0
WireConnection;10;0;11;0
WireConnection;10;2;67;0
WireConnection;2;0;5;0
WireConnection;2;2;74;0
WireConnection;63;1;10;0
WireConnection;7;1;2;0
WireConnection;21;0;20;1
WireConnection;14;0;63;1
WireConnection;14;1;7;1
WireConnection;18;0;14;0
WireConnection;22;0;23;2
WireConnection;22;1;21;0
WireConnection;19;0;22;0
WireConnection;19;1;18;0
WireConnection;57;0;29;0
WireConnection;28;0;19;0
WireConnection;28;1;57;0
WireConnection;24;0;25;2
WireConnection;24;1;28;0
WireConnection;34;0;25;1
WireConnection;34;1;24;0
WireConnection;26;1;34;0
WireConnection;27;1;34;0
WireConnection;53;0;26;0
WireConnection;53;1;27;0
WireConnection;54;0;53;0
WireConnection;31;0;26;1
WireConnection;31;1;30;0
WireConnection;33;0;27;2
WireConnection;33;1;32;0
WireConnection;55;0;54;0
WireConnection;52;0;31;0
WireConnection;52;1;33;0
WireConnection;1;2;52;0
WireConnection;1;10;55;0
ASEEND*/
//CHKSM=E84DC9E8EC29E7A5CE535CCEC8E22EBC5C0FCCB2