// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Firework"
{
	Properties
	{
		[NoScaleOffset][Header(Color Settings)]_ColorMap("Color Map", 2D) = "white" {}
		_ColorMapSpeed("Color Map Speed", Range( 0 , 0.05)) = 0
		_Saturation("Saturation", Range( 0 , 1)) = 1
		_Brightness("Brightness", Float) = 1
		[Toggle]_Brightnessoverlifetime("Brightness over life time", Float) = 0
		[Header(Shape Settings)]_MaxRadius("Max Radius", Float) = 20
		_Ramp("Ramp", Range( 0 , 1)) = 0
		[NoScaleOffset]_NoiseMap("Noise Map", 2D) = "white" {}
		_NoiseMapScale("Noise Map Scale", Float) = 1
		_NoisePower("Noise Power", Range( 0 , 1)) = 0
		_TrailLength("Trail Length", Float) = 0
		[Header(Gravity Settings)]_Gravity("Gravity", Float) = 9.8
		_TrailTimeoffset("Trail Time offset", Range( 0 , 0.1)) = 0
		_FullCycleTime("Full Cycle Time", Float) = 1
		[NoScaleOffset][Header(Render Texture Settings)]_MainTex("Render Texture", 2D) = "black" {}
		_Progress("Progress", Range( 0 , 1)) = 0
		_SourceX("Source X", Range( 0 , 1)) = 0
		[HideInInspector][Toggle]_Configuremode("Configure mode 2", Float) = 0
		_SourceY("Source Y", Range( 0 , 1)) = 0.7529412
		[Header(Debug Modes)]_TimeScale("Time Scale", Float) = 1
		_TimeOffset("Time Offset", Range( 0 , 1)) = 0
		[Toggle]_TestAnimation("Test Animation", Float) = 1
		[Toggle]_Configuremode("Configure mode", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Configuremode;
		uniform sampler2D _NoiseMap;
		uniform float _NoiseMapScale;
		uniform float _NoisePower;
		uniform float _MaxRadius;
		uniform float _TestAnimation;
		uniform float _Progress;
		uniform sampler2D _MainTex;
		uniform float _SourceX;
		uniform float _SourceY;
		uniform float _TimeScale;
		uniform float _TimeOffset;
		uniform float _Ramp;
		uniform float _TrailLength;
		uniform float _FullCycleTime;
		uniform float _Gravity;
		uniform float _TrailTimeoffset;
		uniform sampler2D _ColorMap;
		uniform float _ColorMapSpeed;
		uniform float _Saturation;
		uniform float _Brightnessoverlifetime;
		uniform float _Brightness;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float smoothstepResult89 = smoothstep( 0.0 , 1.0 , tex2Dlod( _NoiseMap, float4( ( v.texcoord.xy * _NoiseMapScale ), 0, 0.0) ).r);
			float2 appendResult98 = (float2(_SourceX , _SourceY));
			float2 RTProgressCoords115 = appendResult98;
			float4 tex2DNode116 = tex2Dlod( _MainTex, float4( RTProgressCoords115, 0, 0.0) );
			float mulTime29 = _Time.y * _TimeScale;
			float Progress34 = (( _TestAnimation )?( frac( ( mulTime29 + _TimeOffset ) ) ):( saturate( ( _Progress + (-0.05 + (( ( tex2DNode116.r + tex2DNode116.g + tex2DNode116.b ) / 3.0 ) - 0.0) * (1.05 - -0.05) / (1.0 - 0.0)) ) ) ));
			float temp_output_26_0 = pow( Progress34 , ( _Ramp + 0.0001 ) );
			float lerpResult22 = lerp( 0.0 , _MaxRadius , temp_output_26_0);
			float Radius37 = lerpResult22;
			float ProgressRamped41 = temp_output_26_0;
			float ProgressFaded55 = ( ProgressRamped41 * ( 1.0 - ProgressRamped41 ) );
			float lerpResult51 = lerp( 0.0 , _TrailLength , ProgressFaded55);
			float lerpResult45 = lerp( Radius37 , ( Radius37 - lerpResult51 ) , v.color.r);
			float3 ase_vertexNormal = v.normal.xyz;
			float3 break73 = ( ( ( smoothstepResult89 * _NoisePower * lerpResult45 ) + lerpResult45 ) * ase_vertexNormal );
			float temp_output_90_0 = ( _Gravity / 2.0 );
			float lerpResult86 = lerp( ( _TrailLength * _TrailTimeoffset ) , 0.0 , ProgressRamped41);
			float lerpResult77 = lerp( ( pow( ( Progress34 * _FullCycleTime ) , 2.0 ) * temp_output_90_0 ) , ( pow( ( ( _FullCycleTime * Progress34 ) - lerpResult86 ) , 2.0 ) * temp_output_90_0 ) , v.color.r);
			float lerpResult93 = lerp( 0.0 , lerpResult77 , ProgressRamped41);
			float3 appendResult74 = (float3(break73.x , break73.y , ( break73.z - lerpResult93 )));
			v.vertex.xyz += (( _Configuremode )?( float3( 0,0,0 ) ):( appendResult74 ));
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float mulTime19 = _Time.y * _ColorMapSpeed;
			float3 hsvTorgb16 = RGBToHSV( tex2D( _ColorMap, ( i.uv_texcoord + mulTime19 ) ).rgb );
			float2 appendResult98 = (float2(_SourceX , _SourceY));
			float2 RTProgressCoords115 = appendResult98;
			float4 tex2DNode116 = tex2D( _MainTex, RTProgressCoords115 );
			float mulTime29 = _Time.y * _TimeScale;
			float Progress34 = (( _TestAnimation )?( frac( ( mulTime29 + _TimeOffset ) ) ):( saturate( ( _Progress + (-0.05 + (( ( tex2DNode116.r + tex2DNode116.g + tex2DNode116.b ) / 3.0 ) - 0.0) * (1.05 - -0.05) / (1.0 - 0.0)) ) ) ));
			float lerpResult43 = lerp( _Brightness , 0.0 , Progress34);
			float3 hsvTorgb17 = HSVToRGB( float3(hsvTorgb16.x,_Saturation,(( _Brightnessoverlifetime )?( lerpResult43 ):( _Brightness ))) );
			float2 uv_MainTex110 = i.uv_texcoord;
			float4 color112 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			float4 lerpResult111 = lerp( tex2D( _MainTex, uv_MainTex110 ) , color112 , saturate( ( 1.0 - sign( (0.0 + (distance( i.uv_texcoord , RTProgressCoords115 ) - 0.01) * (1.0 - 0.0) / (1.0 - 0.01)) ) ) ));
			o.Emission = (( _Configuremode )?( lerpResult111 ):( float4( hsvTorgb17 , 0.0 ) )).rgb;
			float lerpResult129 = lerp( 0.0 , 1.0 , ceil( Progress34 ));
			o.Alpha = lerpResult129;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
1927;29;1906;1004;3072.49;1261.302;1.747288;True;False
Node;AmplifyShaderEditor.RangedFloatNode;97;-1810.474,57.6035;Inherit;False;Property;_SourceY;Source Y;17;0;Create;True;0;0;False;0;0.7529412;0.7529412;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-1812.474,-24.3965;Inherit;False;Property;_SourceX;Source X;16;0;Create;True;0;0;False;0;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;98;-1522.474,11.6035;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1390.732,6.59729;Inherit;False;RTProgressCoords;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;36;-3735.521,-237.8242;Inherit;False;1892.955;438.9436;Progress;15;138;122;119;120;125;116;34;32;30;137;136;29;31;117;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-3699.173,-130.7757;Inherit;False;115;RTProgressCoords;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;116;-3457.173,-153.7757;Inherit;True;Property;_RenderTextureRef;Render Texture Ref;14;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Instance;110;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-3160.739,-125.4318;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-3032.292,45.92107;Inherit;False;Property;_TimeScale;Time Scale;18;0;Create;True;0;0;False;1;Header(Debug Modes);1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;119;-3043.708,-127.0447;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-3006.757,-202.1772;Inherit;False;Property;_Progress;Progress;15;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-2971.326,120.2649;Inherit;False;Property;_TimeOffset;Time Offset;19;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;29;-2871.292,50.92108;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;122;-2923.16,-127.2425;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.05;False;4;FLOAT;1.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;138;-2736.995,-145.2215;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;137;-2681.806,72.95447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;30;-2562.292,72.92109;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;125;-2614.732,-122.0973;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;38;-3441.615,211.0331;Inherit;False;1018.262;379.2267;Radius;8;27;28;35;26;1;22;37;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;32;-2361.521,33.77751;Inherit;False;Property;_TestAnimation;Test Animation;20;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-2115.166,35.70098;Inherit;False;Progress;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3391.615,452.2592;Inherit;False;Property;_Ramp;Ramp;6;0;Create;True;0;0;False;0;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-3111.615,457.2592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-3168.986,368.5077;Inherit;False;34;Progress;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;26;-2984.615,370.2595;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;-3440.079,603.8451;Inherit;False;816.9951;238.6823;Progress Faded;5;53;50;52;54;55;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-2822.955,386.4037;Inherit;False;ProgressRamped;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-3390.079,727.1448;Inherit;False;41;ProgressRamped;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;52;-3164.462,732.5274;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-3387.628,653.8451;Inherit;False;41;ProgressRamped;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-3002.366,286.8128;Inherit;False;Property;_MaxRadius;Max Radius;5;0;Create;True;0;0;False;1;Header(Shape Settings);20;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-3004.802,661.3005;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-2874.084,655.3235;Inherit;False;ProgressFaded;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;22;-2820.615,266.2597;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-1641.093,838.2243;Inherit;False;55;ProgressFaded;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;37;-2666.352,261.033;Inherit;False;Radius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1833.728,351.2031;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;85;-1652.238,1198.927;Inherit;False;Property;_TrailTimeoffset;Trail Time offset;12;0;Create;True;0;0;False;0;0;0.0194;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1803.113,462.2332;Inherit;False;Property;_NoiseMapScale;Noise Map Scale;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1588.119,768.5794;Inherit;False;Property;_TrailLength;Trail Length;10;0;Create;True;0;0;False;0;0;45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;51;-1402.151,749.9951;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1373.376,1181.511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1268.756,1277.1;Inherit;False;41;ProgressRamped;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-1570.113,349.2332;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-1214.556,1017.612;Inherit;False;Property;_FullCycleTime;Full Cycle Time;13;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-1426.119,678.58;Inherit;False;37;Radius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-1212.398,1093.714;Inherit;False;34;Progress;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;59;-1416.113,320.2332;Inherit;True;Property;_NoiseMap;Noise Map;7;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;16d574e53541bba44a84052fa38778df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-1253.118,682.58;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;86;-1031.756,1193.1;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-1020.578,1063.683;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-1206.376,943.6425;Inherit;False;34;Progress;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;49;-1387.483,877.3973;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;39;-1287.275,598.1702;Inherit;False;37;Radius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;45;-1097.118,659.5798;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-878.7191,1189.595;Inherit;False;Property;_Gravity;Gravity;11;0;Create;True;0;0;False;1;Header(Gravity Settings);9.8;9.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1227.828,513.1031;Inherit;False;Property;_NoisePower;Noise Power;9;0;Create;True;0;0;False;0;0;0.12;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;89;-1129.34,347.8967;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;84;-887.2374,1099.627;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-1413.078,-173.1611;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1021.557,952.6118;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;100;-1147.474,-47.3965;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-909.828,496.1031;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;90;-727.7191,1193.595;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;79;-746.7035,1066.259;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;70;-747.6816,955.1875;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1446.962,-812.9195;Inherit;False;Property;_ColorMapSpeed;Color Map Speed;1;0;Create;True;0;0;False;0;0;0;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-1229.448,-929.9892;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;102;-972.0778,-47.16105;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-1181.762,-807.8195;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-524.7035,1067.259;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;4.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-525.6816,956.1875;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;4.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;78;-556.5092,1161.052;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-788.8281,729.1031;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-720.8281,635.1031;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-617.7191,1322.595;Inherit;False;41;ProgressRamped;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-590.828,635.1031;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-826.1282,-675.4326;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;False;0;1;81.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-978.0616,-930.3194;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;77;-366.9932,1044.551;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;105;-797.0778,-47.16105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-827.1466,-598.3133;Inherit;False;34;Progress;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;93;-169.7191,1020.595;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;73;-453.7499,636.6467;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;14;-855.261,-958.5195;Inherit;True;Property;_ColorMap;Color Map;0;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Color Settings);-1;None;38956f4b67ba0984587b1a913d05beea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;43;-624.6976,-604.4461;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;108;-677.0778,-47.16105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-736.4185,-758.601;Inherit;False;Property;_Saturation;Saturation;2;0;Create;True;0;0;False;0;1;0.904;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;135;-463.5558,-679.6906;Inherit;False;Property;_Brightnessoverlifetime;Brightness over life time;4;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;109;-526.0778,-47.16105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;95.66573,399.7364;Inherit;False;34;Progress;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;112;-683.3967,-231.9478;Inherit;False;Constant;_Color0;Color 0;20;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;72;41.0388,723.4886;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;16;-568.913,-953.4695;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;110;-767.4884,-421.8365;Inherit;True;Property;_MainTex;Render Texture;14;1;[NoScaleOffset];Create;False;0;0;False;1;Header(Render Texture Settings);-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;126;278.2962,405.6554;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;74;185.8539,636.9852;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;17;-104.9157,-951.4432;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;111;-302.5379,-91.71782;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;94;633.0816,75.32553;Inherit;False;Property;_Configuremode;Configure mode;21;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;131;-262.2301,-1323.435;Inherit;False;Global;_GrabScreen0;Grab Screen 0;21;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;121;371.1589,632.5366;Inherit;False;Property;_Configuremode;Configure mode 2;16;0;Create;False;0;0;False;1;HideInInspector;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;129;408.4721,359.0238;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;950.8267,35.52368;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;RED_SIM/Firework;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;98;0;96;0
WireConnection;98;1;97;0
WireConnection;115;0;98;0
WireConnection;116;1;117;0
WireConnection;120;0;116;1
WireConnection;120;1;116;2
WireConnection;120;2;116;3
WireConnection;119;0;120;0
WireConnection;29;0;31;0
WireConnection;122;0;119;0
WireConnection;138;0;139;0
WireConnection;138;1;122;0
WireConnection;137;0;29;0
WireConnection;137;1;136;0
WireConnection;30;0;137;0
WireConnection;125;0;138;0
WireConnection;32;0;125;0
WireConnection;32;1;30;0
WireConnection;34;0;32;0
WireConnection;28;0;27;0
WireConnection;26;0;35;0
WireConnection;26;1;28;0
WireConnection;41;0;26;0
WireConnection;52;0;53;0
WireConnection;54;0;50;0
WireConnection;54;1;52;0
WireConnection;55;0;54;0
WireConnection;22;1;1;0
WireConnection;22;2;26;0
WireConnection;37;0;22;0
WireConnection;51;1;48;0
WireConnection;51;2;57;0
WireConnection;88;0;48;0
WireConnection;88;1;85;0
WireConnection;60;0;7;0
WireConnection;60;1;61;0
WireConnection;59;1;60;0
WireConnection;47;0;46;0
WireConnection;47;1;51;0
WireConnection;86;0;88;0
WireConnection;86;2;87;0
WireConnection;83;0;76;0
WireConnection;83;1;81;0
WireConnection;45;0;39;0
WireConnection;45;1;47;0
WireConnection;45;2;49;1
WireConnection;89;0;59;1
WireConnection;84;0;83;0
WireConnection;84;1;86;0
WireConnection;75;0;67;0
WireConnection;75;1;76;0
WireConnection;100;0;101;0
WireConnection;100;1;115;0
WireConnection;9;0;89;0
WireConnection;9;1;10;0
WireConnection;9;2;45;0
WireConnection;90;0;91;0
WireConnection;79;0;84;0
WireConnection;70;0;75;0
WireConnection;102;0;100;0
WireConnection;19;0;21;0
WireConnection;80;0;79;0
WireConnection;80;1;90;0
WireConnection;71;0;70;0
WireConnection;71;1;90;0
WireConnection;8;0;9;0
WireConnection;8;1;45;0
WireConnection;3;0;8;0
WireConnection;3;1;2;0
WireConnection;20;0;63;0
WireConnection;20;1;19;0
WireConnection;77;0;71;0
WireConnection;77;1;80;0
WireConnection;77;2;78;1
WireConnection;105;0;102;0
WireConnection;93;1;77;0
WireConnection;93;2;92;0
WireConnection;73;0;3;0
WireConnection;14;1;20;0
WireConnection;43;0;15;0
WireConnection;43;2;44;0
WireConnection;108;0;105;0
WireConnection;135;0;15;0
WireConnection;135;1;43;0
WireConnection;109;0;108;0
WireConnection;72;0;73;2
WireConnection;72;1;93;0
WireConnection;16;0;14;0
WireConnection;126;0;128;0
WireConnection;74;0;73;0
WireConnection;74;1;73;1
WireConnection;74;2;72;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;17;2;135;0
WireConnection;111;0;110;0
WireConnection;111;1;112;0
WireConnection;111;2;109;0
WireConnection;94;0;17;0
WireConnection;94;1;111;0
WireConnection;121;0;74;0
WireConnection;129;2;126;0
WireConnection;0;2;94;0
WireConnection;0;9;129;0
WireConnection;0;11;121;0
ASEEND*/
//CHKSM=A965A9F0CC12000B84849E7506FEFBAB71DEB030