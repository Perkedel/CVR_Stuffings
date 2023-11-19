// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Simple Sky"
{
	Properties
	{
		[Header(Sky Color Settings)]_DayColorTop("Day Color Top", Color) = (0.2431373,0.7176471,1,1)
		_SkyColorBottom("Sky Color Bottom", Color) = (0.7372549,0.9019608,1,1)
		_DayColorHorizon("Day Color Horizon", Color) = (0.8443396,0.9419298,1,1)
		_NightColorTop("Night Color Top", Color) = (0.03137255,0.03137255,0.09803922,1)
		_NightColorBottom("Night Color Bottom", Color) = (0.09803922,0.07058824,0.2235294,1)
		_NightColorHorizon("Night Color Horizon", Color) = (0.09803922,0.07058824,0.2235294,1)
		_SunsetHorizonColor("Sunset Horizon Color", Color) = (1,0.2705882,0.1686275,1)
		_HorizonHeight("Horizon Height", Range( 0 , 1)) = 0.2
		_SunsetHorizonHeight("Sunset Horizon Height", Range( 0 , 1)) = 0.5
		_SunsetSize("Sunset Size", Range( 0 , 10)) = 2.75
		[Header(Sun Settings)]_SunDayColor("Sun Day Color", Color) = (1,1,1,1)
		_SunSunsetColor("Sun Sunset Color", Color) = (1,0.8075824,0.75,1)
		_SunRadius("Sun Radius", Range( 0 , 1)) = 0.274
		_SunEdge("Sun Edge", Range( 0 , 1)) = 0.743
		_SunHaloRadius("Sun Halo Radius", Range( 0 , 1)) = 0.387
		_SunHaloBrightness("Sun Halo Brightness", Range( 0 , 1)) = 0.195
		[HDR][Header(Stars Settings)]_StarColor("Star Color", Color) = (2.66286,2.25319,1.351914,0)
		[NoScaleOffset]_Tex("Stars Cubmep", CUBE) = "black" {}
		_StarmapContrast("Starmap Contrast", Range( 1 , 1.1)) = 1.014
		_StarHorizonFadePower("Star Horizon Fade Power", Range( 0 , 1)) = 0.5
		_BlinkPower("Blink Power", Range( 0 , 1)) = 0.222
		_BlinkFrequency("Blink Frequency ", Range( 0 , 20)) = 10
		_StarmapRotationAngle("Starmap Rotation Angle", Range( -180 , 180)) = 0
		_StarmapRotationAxis("Starmap Rotation Axis", Vector) = (0.85,1,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _NightColorHorizon;
		uniform float4 _NightColorBottom;
		uniform float4 _NightColorTop;
		uniform float _HorizonHeight;
		uniform float4 _DayColorHorizon;
		uniform float4 _SkyColorBottom;
		uniform float4 _DayColorTop;
		uniform float4 _SunsetHorizonColor;
		uniform float _SunsetHorizonHeight;
		uniform float _SunsetSize;
		uniform float4 _SunSunsetColor;
		uniform float4 _SunDayColor;
		uniform float _SunHaloRadius;
		uniform float _SunHaloBrightness;
		uniform float _SunRadius;
		uniform float _SunEdge;
		uniform float4 _StarColor;
		uniform float _BlinkPower;
		uniform float _BlinkFrequency;
		uniform float _StarHorizonFadePower;
		uniform samplerCUBE _Tex;
		uniform float3 _StarmapRotationAxis;
		uniform float _StarmapRotationAngle;
		uniform float _StarmapContrast;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult898 = normalize( ase_worldPos );
			float3 break932 = normalizeResult898;
			float3 appendResult933 = (float3(break932.x , break932.y , break932.z));
			float3 WorldPositionNormalised916 = appendResult933;
			float temp_output_918_0 = (WorldPositionNormalised916).y;
			float smoothstepResult911 = smoothstep( 0.0 , 1.0 , temp_output_918_0);
			float4 lerpResult947 = lerp( _NightColorBottom , _NightColorTop , smoothstepResult911);
			float smoothstepResult930 = smoothstep( 0.0 , 1.0 , ( temp_output_918_0 / ( _HorizonHeight + 0.001 ) ));
			float4 lerpResult948 = lerp( _NightColorHorizon , lerpResult947 , smoothstepResult930);
			float4 lerpResult248 = lerp( _SkyColorBottom , _DayColorTop , smoothstepResult911);
			float4 lerpResult924 = lerp( _DayColorHorizon , lerpResult248 , smoothstepResult930);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 LightDirection946 = ase_worldlightDir;
			float temp_output_938_0 = (LightDirection946).y;
			float smoothstepResult944 = smoothstep( 0.0 , 1.0 , ( ( temp_output_938_0 + 0.2 ) * 1.2 ));
			float DayNightProgress953 = smoothstepResult944;
			float4 lerpResult952 = lerp( lerpResult948 , lerpResult924 , DayNightProgress953);
			float smoothstepResult970 = smoothstep( 0.0 , 1.0 , ( temp_output_918_0 / ( _SunsetHorizonHeight + 0.001 ) ));
			float SunSkyMask973 = distance( WorldPositionNormalised916 , LightDirection946 );
			float SunHeight964 = temp_output_938_0;
			float temp_output_999_0 = ( ( SunHeight964 * 3.0 ) + -0.4 );
			float smoothstepResult1015 = smoothstep( 0.0 , 1.0 , ( 1.0 - abs( temp_output_999_0 ) ));
			float4 lerpResult966 = lerp( lerpResult952 , _SunsetHorizonColor , ( _SunsetHorizonColor.a * ( ( 1.0 - smoothstepResult970 ) * ( 1.0 - saturate( ( SunSkyMask973 / ( _SunsetSize + 0.001 ) ) ) ) * smoothstepResult1015 ) ));
			float4 Sky1054 = lerpResult966;
			float SunsetProgress1023 = saturate( temp_output_999_0 );
			float4 lerpResult1043 = lerp( _SunSunsetColor , _SunDayColor , SunsetProgress1023);
			float smoothstepResult1016 = smoothstep( 0.0 , 1.0 , ( 1.0 - ( SunSkyMask973 / ( _SunHaloRadius + 0.001 ) ) ));
			float4 Sun1051 = ( lerpResult1043 * saturate( ( ( smoothstepResult1016 * _SunHaloBrightness * SunsetProgress1023 ) + saturate( ( ( 1.0 - ( SunSkyMask973 / ( ( _SunRadius + 0.001 ) / 10.0 ) ) ) * _SunEdge * 10.0 ) ) ) ) );
			float mulTime1088 = _Time.y * _BlinkFrequency;
			float4 StarColor1102 = ( _StarColor * ( 1.0 - saturate( ( _BlinkPower * ( cos( mulTime1088 ) + 1.0 ) ) ) ) );
			float3 normalizeResult1059 = normalize( _StarmapRotationAxis );
			float3 temp_output_1_0_g1743 = normalizeResult1059;
			float3 temp_output_2_0_g1743 = float3(0,1,0);
			float dotResult3_g1743 = dot( temp_output_1_0_g1743 , temp_output_2_0_g1743 );
			float3 break19_g1743 = cross( temp_output_1_0_g1743 , temp_output_2_0_g1743 );
			float4 appendResult23_g1743 = (float4(break19_g1743.x , break19_g1743.y , break19_g1743.z , ( dotResult3_g1743 + 1.0 )));
			float4 normalizeResult24_g1743 = normalize( appendResult23_g1743 );
			float4 ifLocalVar25_g1743 = 0;
			if( dotResult3_g1743 <= 0.999999 )
				ifLocalVar25_g1743 = normalizeResult24_g1743;
			else
				ifLocalVar25_g1743 = float4(0,0,0,1);
			float temp_output_4_0_g1744 = ( UNITY_PI / 2.0 );
			float3 temp_output_8_0_g1743 = cross( float3(1,0,0) , temp_output_1_0_g1743 );
			float3 ifLocalVar10_g1743 = 0;
			if( length( temp_output_8_0_g1743 ) >= 1E-06 )
				ifLocalVar10_g1743 = temp_output_8_0_g1743;
			else
				ifLocalVar10_g1743 = cross( float3(0,1,0) , temp_output_1_0_g1743 );
			float3 normalizeResult13_g1743 = normalize( ifLocalVar10_g1743 );
			float3 break10_g1744 = ( sin( temp_output_4_0_g1744 ) * normalizeResult13_g1743 );
			float4 appendResult8_g1744 = (float4(break10_g1744.x , break10_g1744.y , break10_g1744.z , cos( temp_output_4_0_g1744 )));
			float4 ifLocalVar4_g1743 = 0;
			if( dotResult3_g1743 >= -0.999999 )
				ifLocalVar4_g1743 = ifLocalVar25_g1743;
			else
				ifLocalVar4_g1743 = appendResult8_g1744;
			float4 temp_output_2_0_g1750 = ifLocalVar4_g1743;
			float4 temp_output_1_0_g1751 = temp_output_2_0_g1750;
			float3 temp_output_7_0_g1751 = (temp_output_1_0_g1751).xyz;
			float temp_output_4_0_g1742 = ( radians( _StarmapRotationAngle ) / 2.0 );
			float3 break10_g1742 = ( sin( temp_output_4_0_g1742 ) * normalizeResult1059 );
			float4 appendResult8_g1742 = (float4(break10_g1742.x , break10_g1742.y , break10_g1742.z , cos( temp_output_4_0_g1742 )));
			float4 temp_output_2_0_g1745 = appendResult8_g1742;
			float4 temp_output_1_0_g1746 = temp_output_2_0_g1745;
			float3 temp_output_7_0_g1746 = (temp_output_1_0_g1746).xyz;
			float3 break8_g1745 = WorldPositionNormalised916;
			float4 appendResult9_g1745 = (float4(break8_g1745.x , break8_g1745.y , break8_g1745.z , 0.0));
			float4 temp_output_1_0_g1747 = appendResult9_g1745;
			float3 temp_output_7_0_g1747 = (temp_output_1_0_g1747).xyz;
			float4 temp_output_2_0_g1747 = ( temp_output_2_0_g1745 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1747 = (temp_output_2_0_g1747).w;
			float3 temp_output_3_0_g1747 = (temp_output_2_0_g1747).xyz;
			float temp_output_11_0_g1747 = (temp_output_1_0_g1747).w;
			float3 break17_g1747 = ( ( temp_output_7_0_g1747 * temp_output_10_0_g1747 ) + cross( temp_output_1_0_g1747.xyz , temp_output_2_0_g1747.xyz ) + ( temp_output_3_0_g1747 * temp_output_11_0_g1747 ) );
			float dotResult16_g1747 = dot( temp_output_7_0_g1747 , temp_output_3_0_g1747 );
			float4 appendResult18_g1747 = (float4(break17_g1747.x , break17_g1747.y , break17_g1747.z , ( ( temp_output_11_0_g1747 * temp_output_10_0_g1747 ) - dotResult16_g1747 )));
			float4 temp_output_2_0_g1746 = appendResult18_g1747;
			float temp_output_10_0_g1746 = (temp_output_2_0_g1746).w;
			float3 temp_output_3_0_g1746 = (temp_output_2_0_g1746).xyz;
			float temp_output_11_0_g1746 = (temp_output_1_0_g1746).w;
			float3 break17_g1746 = ( ( temp_output_7_0_g1746 * temp_output_10_0_g1746 ) + cross( temp_output_1_0_g1746.xyz , temp_output_2_0_g1746.xyz ) + ( temp_output_3_0_g1746 * temp_output_11_0_g1746 ) );
			float dotResult16_g1746 = dot( temp_output_7_0_g1746 , temp_output_3_0_g1746 );
			float4 appendResult18_g1746 = (float4(break17_g1746.x , break17_g1746.y , break17_g1746.z , ( ( temp_output_11_0_g1746 * temp_output_10_0_g1746 ) - dotResult16_g1746 )));
			float3 break8_g1750 = (appendResult18_g1746).xyz;
			float4 appendResult9_g1750 = (float4(break8_g1750.x , break8_g1750.y , break8_g1750.z , 0.0));
			float4 temp_output_1_0_g1752 = appendResult9_g1750;
			float3 temp_output_7_0_g1752 = (temp_output_1_0_g1752).xyz;
			float4 temp_output_2_0_g1752 = ( temp_output_2_0_g1750 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1752 = (temp_output_2_0_g1752).w;
			float3 temp_output_3_0_g1752 = (temp_output_2_0_g1752).xyz;
			float temp_output_11_0_g1752 = (temp_output_1_0_g1752).w;
			float3 break17_g1752 = ( ( temp_output_7_0_g1752 * temp_output_10_0_g1752 ) + cross( temp_output_1_0_g1752.xyz , temp_output_2_0_g1752.xyz ) + ( temp_output_3_0_g1752 * temp_output_11_0_g1752 ) );
			float dotResult16_g1752 = dot( temp_output_7_0_g1752 , temp_output_3_0_g1752 );
			float4 appendResult18_g1752 = (float4(break17_g1752.x , break17_g1752.y , break17_g1752.z , ( ( temp_output_11_0_g1752 * temp_output_10_0_g1752 ) - dotResult16_g1752 )));
			float4 temp_output_2_0_g1751 = appendResult18_g1752;
			float temp_output_10_0_g1751 = (temp_output_2_0_g1751).w;
			float3 temp_output_3_0_g1751 = (temp_output_2_0_g1751).xyz;
			float temp_output_11_0_g1751 = (temp_output_1_0_g1751).w;
			float3 break17_g1751 = ( ( temp_output_7_0_g1751 * temp_output_10_0_g1751 ) + cross( temp_output_1_0_g1751.xyz , temp_output_2_0_g1751.xyz ) + ( temp_output_3_0_g1751 * temp_output_11_0_g1751 ) );
			float dotResult16_g1751 = dot( temp_output_7_0_g1751 , temp_output_3_0_g1751 );
			float4 appendResult18_g1751 = (float4(break17_g1751.x , break17_g1751.y , break17_g1751.z , ( ( temp_output_11_0_g1751 * temp_output_10_0_g1751 ) - dotResult16_g1751 )));
			float3 StarmapRotation1067 = (appendResult18_g1751).xyz;
			float4 texCUBENode1068 = texCUBE( _Tex, StarmapRotation1067 );
			float StarMask1101 = ( ( 1.0 - DayNightProgress953 ) * saturate( ( (WorldPositionNormalised916).y / ( _StarHorizonFadePower + 0.001 ) ) ) * saturate( ( ( ( ( ( texCUBENode1068.r + texCUBENode1068.g + texCUBENode1068.b ) / 3.0 ) - 0.5 ) * _StarmapContrast ) + 0.5 ) ) );
			float4 lerpResult1072 = lerp( ( Sky1054 + Sun1051 ) , StarColor1102 , StarMask1101);
			o.Emission = lerpResult1072.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
1927;29;1906;1004;7469.944;-3903.025;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;897;-3678.503,2456.622;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;898;-3455.504,2455.622;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;932;-3302.24,2455.628;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;1056;-6891.968,5384.678;Inherit;False;1533.708;618.3682;Starmap Rotation;11;1057;1063;1067;1066;1061;1065;1064;1059;1058;1060;1062;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;945;-3687.719,2713.554;Inherit;True;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1058;-6836.151,5540.963;Float;False;Property;_StarmapRotationAngle;Starmap Rotation Angle;22;0;Create;True;0;0;False;0;0;0;-180;180;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;933;-2907.354,2455.629;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1057;-6851.971,5649.034;Float;False;Property;_StarmapRotationAxis;Starmap Rotation Axis;23;0;Create;True;0;0;False;0;0.85,1,0;-4.12,3,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;946;-3446.187,2708.315;Float;False;LightDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1059;-6599.515,5653.38;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RadiansOpNode;1060;-6564.36,5544.675;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;916;-2755.071,2451.737;Float;False;WorldPositionNormalised;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;937;-3677.767,2136.179;Inherit;False;946;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1061;-6463.331,5463.015;Inherit;False;916;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;1063;-6604.197,5778.522;Float;False;Constant;_Vector2;Vector 2;56;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;938;-3422.154,2136.276;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1062;-6414.201,5543.914;Inherit;True;RotateAngleAxis;-1;;1742;72edad85bb5dea440905ae88eddfa489;0;2;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;1064;-6411.736,5759.415;Inherit;True;FromToRotation;-1;;1743;ad10913350839ec49a3853aee4185e18;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;1065;-6177.831,5521.764;Inherit;True;RotateVector;-1;;1745;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;964;-3183.405,2093.446;Float;False;SunHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1053;-5019.738,3739.056;Inherit;False;2516.156;2017.858;SKY GENERATION;46;1054;1007;966;971;952;977;954;924;948;965;947;930;972;248;984;1015;923;244;246;1001;970;911;242;936;243;1014;927;928;1000;969;1023;989;1025;968;975;988;929;918;917;987;999;967;997;998;996;1003;;0.6556604,0.8393699,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1050;-7596.027,4644.579;Inherit;False;2245.286;692.5581;SUN GENERATION;26;1051;1045;1043;1042;1041;1044;1038;1035;1022;1037;1016;1020;1032;1026;1049;1031;1034;976;1028;982;983;960;1048;1030;958;1029;;1,0.5408292,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;956;-3134.185,2710.195;Inherit;False;916;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;955;-3101.963,2802.754;Inherit;False;946;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;996;-4830.083,5573.573;Float;False;Constant;_SunsetHorizonScale;Sunset Horizon Scale;18;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1029;-7565.25,5060.011;Float;False;Property;_SunRadius;Sun Radius;12;0;Create;True;0;0;False;0;0.274;0.292;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1066;-5871.827,5736.038;Inherit;True;RotateVector;-1;;1750;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1003;-4784.278,5494.526;Inherit;False;964;SunHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;957;-2824.007,2751.615;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1067;-5597.935,5731.363;Float;False;StarmapRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1030;-7287.251,5065.011;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;998;-4591.496,5514.897;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;958;-7411.018,4803.298;Float;False;Property;_SunHaloRadius;Sun Halo Radius;14;0;Create;True;0;0;False;0;0.387;0.292;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1116;-7229.371,3743.052;Inherit;False;1875.269;865.8018;STARS;30;1113;1102;1101;1108;1098;1079;1114;1073;1107;1100;1078;1093;1112;1106;1111;1095;1076;1109;1105;1099;1075;1077;1096;1071;1089;1070;1088;1090;1068;1069;;0,0.218298,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;997;-4794.71,5658.973;Float;False;Constant;_SunsetHorizonVerticalOffset;Sunset Horizon Vertical Offset;17;0;Create;True;0;0;False;0;-0.4;-0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;973;-2666.115,2747.16;Float;False;SunSkyMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;967;-4825.473,5148.284;Float;False;Property;_SunsetHorizonHeight;Sunset Horizon Height;8;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;999;-4441.911,5514.874;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;987;-4853.335,5387.263;Float;False;Property;_SunsetSize;Sunset Size;9;0;Create;True;0;0;False;0;2.75;0.292;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;983;-7181.531,4723.432;Inherit;False;973;SunSkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1048;-7134.454,5075.472;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;960;-7115.681,4807.045;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1069;-7173.868,4176.368;Inherit;False;1067;StarmapRotation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;917;-4922.013,4317.17;Inherit;False;916;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;939;-3466.867,2223.445;Float;False;Constant;_VerticalNightTimeShift;Vertical Night Time Shift;16;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;918;-4650.643,4317.169;Inherit;True;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;982;-6948.292,4788.28;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;988;-4586.278,5392.139;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1090;-7016.126,4454.973;Float;False;Property;_BlinkFrequency;Blink Frequency ;21;0;Create;True;0;0;False;0;10;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;929;-4832.412,4608;Float;False;Property;_HorizonHeight;Horizon Height;7;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;975;-4666.833,5315.931;Inherit;False;973;SunSkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1025;-4000.764,5635.908;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;941;-3180.323,2170.989;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;940;-3473.904,2302.29;Float;False;Constant;_NightTimeProgressShift;Night Time Progress Shift;17;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;968;-4522.123,5152.944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1028;-6960.151,5050.011;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1068;-6939.64,4154.272;Inherit;True;Property;_Tex;Stars Cubmep;17;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1070;-6646.251,4182.641;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1023;-3813.764,5628.908;Float;False;SunsetProgress;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1049;-6813.454,5168.472;Float;False;Constant;_Float0;Float 0;17;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;1000;-4317.148,5514.98;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;928;-4552.879,4613.188;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;976;-6823.899,4787.945;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;969;-4371.916,5129.655;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1088;-6742.981,4459.749;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1034;-7383.154,5172.745;Float;False;Property;_SunEdge;Sun Edge;13;0;Create;True;0;0;False;0;0.743;0.537;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;942;-3036.698,2173.487;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1031;-6824.655,5057.245;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;989;-4460.978,5340.937;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1071;-6526.251,4181.641;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;243;-4142.467,4940.197;Float;False;Property;_NightColorTop;Night Color Top;3;0;Create;True;0;0;False;0;0.03137255,0.03137255,0.09803922,1;0.01896559,0,0.1617591,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;246;-4147.596,3957.366;Float;False;Property;_SkyColorBottom;Sky Color Bottom;1;0;Create;True;0;0;False;0;0.7372549,0.9019608,1,1;0.7352942,0.9014199,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;944;-2881.669,2174.94;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1001;-4195.176,5515.061;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1016;-6651.166,4786.482;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1032;-6651.255,5054.044;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;242;-4146.099,4124.026;Float;False;Property;_DayColorTop;Day Color Top;0;0;Create;True;0;0;False;1;Header(Sky Color Settings);0.2431373,0.7176471,1,1;0.2426378,0.7179518,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;911;-4081.423,4326.287;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;927;-4351.268,4443.299;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1014;-4253.43,5353.884;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;970;-4232.204,5129.656;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1020;-7409.035,4893.42;Float;False;Property;_SunHaloBrightness;Sun Halo Brightness;15;0;Create;True;0;0;False;0;0.195;0.537;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1089;-6577.881,4461.048;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;936;-4142.84,4760.992;Float;False;Property;_NightColorBottom;Night Color Bottom;4;0;Create;True;0;0;False;0;0.09803922,0.07058824,0.2235294,1;0.01896559,0,0.1617591,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1026;-6849.318,4959.211;Inherit;False;1023;SunsetProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1105;-6700.481,3870.993;Inherit;False;916;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;248;-3861.83,4106.834;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1015;-4024.754,5516.262;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1099;-6447.655,4465.571;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1037;-6512.932,5055.367;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1077;-6559.251,4286.642;Float;False;Property;_StarmapContrast;Starmap Contrast;18;0;Create;True;0;0;False;0;1.014;0;1;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;953;-2704.826,2169.904;Float;False;DayNightProgress;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1022;-6464.637,4878.634;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1075;-6395.251,4181.641;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-6536.235,4074.064;Float;False;Property;_StarHorizonFadePower;Star Horizon Fade Power;19;0;Create;True;0;0;False;0;0.5;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1096;-6606.255,4377.16;Float;False;Property;_BlinkPower;Blink Power;20;0;Create;True;0;0;False;0;0.222;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;947;-3852.209,4695.295;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;244;-4140.793,4591.749;Float;False;Property;_NightColorHorizon;Night Color Horizon;5;0;Create;True;0;0;False;0;0.09803922,0.07058824,0.2235294,1;0.0350346,0.06512492,0.2647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;930;-3803.65,4441.658;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;923;-4148.946,3785.918;Float;False;Property;_DayColorHorizon;Day Color Horizon;2;0;Create;True;0;0;False;0;0.8443396,0.9419298,1,1;0.2426378,0.7179518,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;984;-4044.885,5343.361;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;972;-4048.1,5130.223;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1076;-6245.251,4190.641;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;1106;-6411.111,3870.992;Inherit;True;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1111;-6262.772,4077.768;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;954;-3562.583,4346.461;Inherit;False;953;DayNightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;965;-3409.344,4933.172;Float;False;Property;_SunsetHorizonColor;Sunset Horizon Color;6;0;Create;True;0;0;False;0;1,0.2705882,0.1686275,1;0.0350346,0.06512492,0.2647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;924;-3563.771,4097.102;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;948;-3566.57,4598.001;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1035;-6265.066,5196.831;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1044;-6283.947,5080.196;Inherit;False;1023;SunsetProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;977;-3816.267,5132.029;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1042;-6287.947,4739.196;Float;False;Property;_SunSunsetColor;Sun Sunset Color;11;0;Create;True;0;0;False;0;1,0.8075824,0.75,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1041;-6278.343,4910.2;Float;False;Property;_SunDayColor;Sun Day Color;10;0;Create;True;0;0;False;1;Header(Sun Settings);1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1095;-6312.818,4484.482;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1113;-6411.974,3792.633;Inherit;False;953;DayNightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1038;-6131.327,5197.459;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1112;-6109.425,4057.886;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;971;-3169.285,5113.511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1078;-6107.251,4187.641;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1043;-5973.946,4884.196;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;952;-3257.005,4299.307;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1093;-6169.817,4484.484;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1107;-5972.117,4111.216;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1114;-5973.752,3943.922;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1100;-5987.817,4479.284;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;966;-2994.164,4916.057;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1079;-5969.251,4186.641;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1045;-5766.74,5175.345;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1073;-6069.76,4290.751;Float;False;Property;_StarColor;Star Color;16;1;[HDR];Create;True;0;0;False;1;Header(Stars Settings);2.66286,2.25319,1.351914,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1108;-5773.555,4164.41;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1054;-2733.847,4910.242;Float;False;Sky;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1051;-5616.442,5170.988;Float;False;Sun;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1098;-5800.164,4308.972;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1101;-5627.045,4160.49;Float;False;StarMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1052;394.3591,4837.841;Inherit;False;1051;Sun;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1102;-5643.925,4305.14;Float;True;StarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1055;395.3394,4764.927;Inherit;False;1054;Sky;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1117;-3708.813,2960.144;Inherit;False;1159.77;394.6754;Clouds UV;7;1119;1122;1120;1124;1123;1121;1118;;0.4779412,1,0.9135903,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1104;586.1807,4930.027;Inherit;False;1101;StarMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;963;583.919,4768.075;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1103;586.599,4859.433;Inherit;False;1102;StarColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.AbsOpNode;931;-3050.411,2478.092;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1119;-3673.991,3070.456;Inherit;False;916;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1124;-2901.079,3065.905;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1122;-3262.674,3231.377;Float;False;Constant;_Float5;Float 5;0;0;Create;True;0;0;False;0;1E-05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1120;-3373.913,3074.431;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1123;-3076.774,3064.477;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1007;-3809.714,5508.866;Float;False;SunsetBrightness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1072;803.1974,4817.345;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1121;-3075.68,3165.918;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1118;-2768.173,3062.144;Float;False;CloudsUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1036.555,4796.017;Float;False;True;-1;6;ASEMaterialInspector;0;0;Unlit;RED_SIM/Simple Sky;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;898;0;897;0
WireConnection;932;0;898;0
WireConnection;933;0;932;0
WireConnection;933;1;932;1
WireConnection;933;2;932;2
WireConnection;946;0;945;0
WireConnection;1059;0;1057;0
WireConnection;1060;0;1058;0
WireConnection;916;0;933;0
WireConnection;938;0;937;0
WireConnection;1062;2;1060;0
WireConnection;1062;3;1059;0
WireConnection;1064;1;1059;0
WireConnection;1064;2;1063;0
WireConnection;1065;1;1061;0
WireConnection;1065;2;1062;0
WireConnection;964;0;938;0
WireConnection;1066;1;1065;0
WireConnection;1066;2;1064;0
WireConnection;957;0;956;0
WireConnection;957;1;955;0
WireConnection;1067;0;1066;0
WireConnection;1030;0;1029;0
WireConnection;998;0;1003;0
WireConnection;998;1;996;0
WireConnection;973;0;957;0
WireConnection;999;0;998;0
WireConnection;999;1;997;0
WireConnection;1048;0;1030;0
WireConnection;960;0;958;0
WireConnection;918;0;917;0
WireConnection;982;0;983;0
WireConnection;982;1;960;0
WireConnection;988;0;987;0
WireConnection;1025;0;999;0
WireConnection;941;0;938;0
WireConnection;941;1;939;0
WireConnection;968;0;967;0
WireConnection;1028;0;983;0
WireConnection;1028;1;1048;0
WireConnection;1068;1;1069;0
WireConnection;1070;0;1068;1
WireConnection;1070;1;1068;2
WireConnection;1070;2;1068;3
WireConnection;1023;0;1025;0
WireConnection;1000;0;999;0
WireConnection;928;0;929;0
WireConnection;976;0;982;0
WireConnection;969;0;918;0
WireConnection;969;1;968;0
WireConnection;1088;0;1090;0
WireConnection;942;0;941;0
WireConnection;942;1;940;0
WireConnection;1031;0;1028;0
WireConnection;989;0;975;0
WireConnection;989;1;988;0
WireConnection;1071;0;1070;0
WireConnection;944;0;942;0
WireConnection;1001;0;1000;0
WireConnection;1016;0;976;0
WireConnection;1032;0;1031;0
WireConnection;1032;1;1034;0
WireConnection;1032;2;1049;0
WireConnection;911;0;918;0
WireConnection;927;0;918;0
WireConnection;927;1;928;0
WireConnection;1014;0;989;0
WireConnection;970;0;969;0
WireConnection;1089;0;1088;0
WireConnection;248;0;246;0
WireConnection;248;1;242;0
WireConnection;248;2;911;0
WireConnection;1015;0;1001;0
WireConnection;1099;0;1089;0
WireConnection;1037;0;1032;0
WireConnection;953;0;944;0
WireConnection;1022;0;1016;0
WireConnection;1022;1;1020;0
WireConnection;1022;2;1026;0
WireConnection;1075;0;1071;0
WireConnection;947;0;936;0
WireConnection;947;1;243;0
WireConnection;947;2;911;0
WireConnection;930;0;927;0
WireConnection;984;0;1014;0
WireConnection;972;0;970;0
WireConnection;1076;0;1075;0
WireConnection;1076;1;1077;0
WireConnection;1106;0;1105;0
WireConnection;1111;0;1109;0
WireConnection;924;0;923;0
WireConnection;924;1;248;0
WireConnection;924;2;930;0
WireConnection;948;0;244;0
WireConnection;948;1;947;0
WireConnection;948;2;930;0
WireConnection;1035;0;1022;0
WireConnection;1035;1;1037;0
WireConnection;977;0;972;0
WireConnection;977;1;984;0
WireConnection;977;2;1015;0
WireConnection;1095;0;1096;0
WireConnection;1095;1;1099;0
WireConnection;1038;0;1035;0
WireConnection;1112;0;1106;0
WireConnection;1112;1;1111;0
WireConnection;971;0;965;4
WireConnection;971;1;977;0
WireConnection;1078;0;1076;0
WireConnection;1043;0;1042;0
WireConnection;1043;1;1041;0
WireConnection;1043;2;1044;0
WireConnection;952;0;948;0
WireConnection;952;1;924;0
WireConnection;952;2;954;0
WireConnection;1093;0;1095;0
WireConnection;1107;0;1112;0
WireConnection;1114;0;1113;0
WireConnection;1100;0;1093;0
WireConnection;966;0;952;0
WireConnection;966;1;965;0
WireConnection;966;2;971;0
WireConnection;1079;0;1078;0
WireConnection;1045;0;1043;0
WireConnection;1045;1;1038;0
WireConnection;1108;0;1114;0
WireConnection;1108;1;1107;0
WireConnection;1108;2;1079;0
WireConnection;1054;0;966;0
WireConnection;1051;0;1045;0
WireConnection;1098;0;1073;0
WireConnection;1098;1;1100;0
WireConnection;1101;0;1108;0
WireConnection;1102;0;1098;0
WireConnection;963;0;1055;0
WireConnection;963;1;1052;0
WireConnection;931;0;932;1
WireConnection;1124;0;1123;0
WireConnection;1124;1;1121;0
WireConnection;1120;0;1119;0
WireConnection;1123;0;1120;0
WireConnection;1123;1;1120;2
WireConnection;1007;0;1015;0
WireConnection;1072;0;963;0
WireConnection;1072;1;1103;0
WireConnection;1072;2;1104;0
WireConnection;1121;0;1120;1
WireConnection;1121;2;1120;1
WireConnection;1121;3;1122;0
WireConnection;1121;4;1120;1
WireConnection;1118;0;1124;0
WireConnection;0;2;1072;0
ASEEND*/
//CHKSM=2F72360AEB7EF2910D41CB3F9CF83AC0695AB530