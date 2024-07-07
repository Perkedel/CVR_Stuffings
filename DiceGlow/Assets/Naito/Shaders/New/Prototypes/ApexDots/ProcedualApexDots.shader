// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/Apex/Neural Net"
{
	Properties
	{
		_FalloffMin("FalloffMin", Float) = 0
		_MineSize("MineSize", Float) = 0
		_MaxSize("MaxSize", Float) = 0
		_FalloffMax("FalloffMax", Float) = 0
		_Normal("Normal", 2D) = "bump" {}
		_SpecMask("SpecMask", 2D) = "white" {}
		_Specular("Specular", Color) = (0,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_DotColor2("DotColor2", Color) = (0.9632353,0.9632353,0.9632353,0)
		_GrowAnimScale("GrowAnimScale", Float) = 1
		_NoiseTiling("NoiseTiling", Float) = 3
		_BackgroundColor("BackgroundColor", Color) = (1,1,1,0)
		_DotColor("DotColor", Color) = (1,1,1,0)
		_MainTex("MainTex", 2D) = "white" {}
		_Fill("Fill", Float) = 0
		_DotPanDir("DotPanDir", Vector) = (0,0,0,0)
		_TileSize("TileSize", Float) = 1
		[Toggle]_1DNoise("1DNoise", Float) = 1
		_NormalScale("NormalScale", Float) = 0
		_EffectMask("Effect Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _BackgroundColor;
		uniform float4 _DotColor2;
		uniform float4 _DotColor;
		uniform float2 _DotPanDir;
		uniform float _TileSize;
		uniform float _1DNoise;
		uniform float _NoiseTiling;
		uniform float _GrowAnimScale;
		uniform float _FalloffMin;
		uniform float _FalloffMax;
		uniform float _MineSize;
		uniform float _MaxSize;
		uniform float _Fill;
		uniform sampler2D _EffectMask;
		uniform float4 _EffectMask_ST;
		uniform float4 _Specular;
		uniform float _Smoothness;
		uniform sampler2D _SpecMask;
		uniform float4 _SpecMask_ST;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode78 = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			o.Normal = tex2DNode78;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_68_0 = ( tex2D( _MainTex, uv_MainTex ) * _BackgroundColor );
			o.Albedo = temp_output_68_0.rgb;
			float2 temp_cast_1 = (( round( _TileSize ) * 3.15 )).xx;
			float2 uv_TexCoord98 = i.uv_texcoord * temp_cast_1;
			float2 panner95 = ( 1.0 * _Time.y * _DotPanDir + uv_TexCoord98);
			float2 break149 = panner95;
			float temp_output_99_0 = ( abs( sin( break149.x ) ) * abs( sin( break149.y ) ) * abs( (1.0 + (sin( break149.x ) - -1.0) * (-1.0 - 1.0) / (1.0 - -1.0)) ) * abs( (1.0 + (sin( break149.y ) - -1.0) * (-1.0 - 1.0) / (1.0 - -1.0)) ) );
			float2 temp_cast_2 = (_NoiseTiling).xx;
			float mulTime26 = _Time.y * _GrowAnimScale;
			float2 temp_cast_3 = (mulTime26).xx;
			float2 uv_TexCoord52 = i.uv_texcoord * temp_cast_2 + temp_cast_3;
			float2 temp_cast_4 = (uv_TexCoord52.x).xx;
			float simplePerlin2D53 = snoise( lerp(uv_TexCoord52,temp_cast_4,_1DNoise) );
			float clampResult71 = clamp( (_FalloffMin + (simplePerlin2D53 - -1.0) * (_FalloffMax - _FalloffMin) / (1.0 - -1.0)) , _MineSize , _MaxSize );
			float temp_output_50_0 = saturate( (clampResult71 + (temp_output_99_0 - 0.0) * (0.9 - clampResult71) / (1.02 - 0.0)) );
			float4 lerpResult61 = lerp( _DotColor2 , _DotColor , temp_output_50_0);
			float2 uv_EffectMask = i.uv_texcoord * _EffectMask_ST.xy + _EffectMask_ST.zw;
			float4 temp_output_63_0 = ( lerpResult61 * temp_output_50_0 * pow( temp_output_99_0 , _Fill ) * tex2D( _EffectMask, uv_EffectMask ).r );
			o.Emission = saturate( temp_output_63_0 ).rgb;
			o.Specular = _Specular.rgb;
			float2 uv_SpecMask = i.uv_texcoord * _SpecMask_ST.xy + _SpecMask_ST.zw;
			o.Smoothness = ( _Smoothness * tex2D( _SpecMask, uv_SpecMask ).r );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16100
7;29;1906;1044;232.4084;568.8537;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;166;-3958.123,-1368.912;Float;False;5604.753;3058.977;I know I'm bad lol;64;103;148;147;23;97;98;26;56;95;52;149;150;123;124;119;140;120;139;89;90;53;144;94;142;141;51;143;93;71;99;22;50;58;62;92;91;72;77;67;69;61;163;74;48;63;161;160;88;96;164;76;155;153;78;152;151;158;159;68;154;156;157;167;168;DO YOU LIKE SPAGHETTI?;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-3908.123,-885.4035;Float;False;Property;_TileSize;TileSize;21;0;Create;True;0;0;False;0;1;25.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;148;-3634.878,-802.8635;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-3453.428,-788.4517;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;3.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1678.276,327.0129;Float;False;Property;_GrowAnimScale;GrowAnimScale;13;0;Create;True;0;0;False;0;1;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;97;-3406.229,-302.6186;Float;False;Property;_DotPanDir;DotPanDir;20;0;Create;True;0;0;False;0;0,0;0.5,-1.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-3263.37,-930.3774;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;26;-1427.698,289.4562;Float;False;1;0;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1832.915,716.7064;Float;False;Property;_NoiseTiling;NoiseTiling;14;0;Create;True;0;0;False;0;3;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;95;-3126.682,-481.2765;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1624.036,688.003;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;149;-2882.004,-669.2246;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ToggleSwitchNode;150;-1241.335,827.0117;Float;False;Property;_1DNoise;1DNoise;22;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;123;-2484.024,-887.3746;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;124;-2414.323,-585.7751;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;119;-2553.166,-1318.912;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;140;-2244.647,-577.3353;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;120;-2527.842,-1106.798;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;139;-2325.846,-862.8351;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-1279.534,164.9601;Float;False;Property;_FalloffMin;FalloffMin;0;0;Create;True;0;0;False;0;0;-1.68;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-1251.904,359.1485;Float;False;Property;_FalloffMax;FalloffMax;6;0;Create;True;0;0;False;0;0;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;53;-918.935,763.3024;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;144;-1793.355,-1253.18;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1104.509,188.8378;Float;False;Property;_MineSize;MineSize;2;0;Create;True;0;0;False;0;0;-3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;142;-1893.455,-838.4792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;141;-1857.056,-594.078;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;51;-1137.964,610.5999;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;-1.74;False;4;FLOAT;1.08;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;143;-1849.255,-976.2791;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-1220.21,270.7382;Float;False;Property;_MaxSize;MaxSize;4;0;Create;True;0;0;False;0;0;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;71;-955.0488,270.2932;Float;False;3;0;FLOAT;0;False;1;FLOAT;-99999;False;2;FLOAT;1.55;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-1362.223,-417.3737;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;22;-812.0952,113.0258;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1.02;False;3;FLOAT;-73;False;4;FLOAT;0.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-512.7417,103.9683;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;58;-116.2858,260.6714;Float;False;Property;_DotColor;DotColor;17;0;Create;True;0;0;False;0;1,1,1,0;0,0.8758621,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;62;-204.042,-139.1874;Float;False;Property;_DotColor2;DotColor2;12;0;Create;True;0;0;False;0;0.9632353,0.9632353,0.9632353,0;0.03346871,0,0.4411764,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;92;-981.4941,-200.7699;Float;False;Property;_Fill;Fill;19;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;167;-190.8087,-359.5532;Float;True;Property;_EffectMask;Effect Mask;24;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;91;-795.6713,-145.4008;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;61;183.958,-58.18738;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;423.1155,-71.9048;Float;True;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;77;555.0728,790.3005;Float;True;Property;_SpecMask;SpecMask;9;0;Create;True;0;0;False;0;None;b9103fa56cb6ec3479f6728cf2533999;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;1013.073,200.3005;Float;False;Property;_Smoothness;Smoothness;11;0;Create;True;0;0;False;0;0;0.47;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;497.3057,212.0417;Float;False;Property;_NormalScale;NormalScale;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;194.3088,379.6232;Float;True;Property;_MainTex;MainTex;18;0;Create;True;0;0;False;0;None;deb08c1d493535a418e20e6fb2616762;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;67;460.3088,548.6232;Float;False;Property;_BackgroundColor;BackgroundColor;16;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-1441.999,-140.1841;Float;True;Property;_Dot;Dot;15;0;Create;True;0;0;False;0;None;3552c0513dd08bf489b933d6a50c17a5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1203.073,275.3005;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;160;-219.8797,1460.065;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;5382af28091ac5e4db19ac2c60d6aee5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;74;943.0728,517.3005;Float;False;Property;_Specular;Specular;10;0;Create;True;0;0;False;0;0,0,0,0;0.3014703,0.3014703,0.3014703,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-632.1379,1130.911;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;96;-3421.14,-568.0571;Float;False;0;48;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;168;1396.492,124.0463;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;164;1107.068,99.22418;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;88;-1106.799,-55.14396;Float;False;Property;_Alpha;Alpha;7;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-472.1376,1162.911;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;78;743.5727,-110.0995;Float;True;Property;_Normal;Normal;8;0;Create;True;0;0;False;0;None;c9f9476708b5ea9499b5e4a09eb6ab35;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;152;-296.1377,1210.911;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;151;-136.1377,1178.911;Float;True;Property;_Matcap;Matcap;1;0;Create;True;0;0;False;0;None;87d2c8399bbb2324e95d799001674483;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;158;-76.28002,1384.465;Float;False;Property;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;156;-872.1379,1146.911;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;159;328.7721,1317.295;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;533.3088,331.6232;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;851.0237,332.9093;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewMatrixNode;157;-888.1379,1082.911;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;154;-648.1379,1258.911;Float;False;Constant;_Float0;Float 0;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1761.63,85.85484;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;Naito/Apex/Neural Net;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;148;0;103;0
WireConnection;147;0;148;0
WireConnection;98;0;147;0
WireConnection;26;0;23;0
WireConnection;95;0;98;0
WireConnection;95;2;97;0
WireConnection;52;0;56;0
WireConnection;52;1;26;0
WireConnection;149;0;95;0
WireConnection;150;0;52;0
WireConnection;150;1;52;1
WireConnection;123;0;149;0
WireConnection;124;0;149;1
WireConnection;119;0;149;0
WireConnection;140;0;124;0
WireConnection;120;0;149;1
WireConnection;139;0;123;0
WireConnection;53;0;150;0
WireConnection;144;0;119;0
WireConnection;142;0;139;0
WireConnection;141;0;140;0
WireConnection;51;0;53;0
WireConnection;51;3;89;0
WireConnection;51;4;90;0
WireConnection;143;0;120;0
WireConnection;71;0;51;0
WireConnection;71;1;94;0
WireConnection;71;2;93;0
WireConnection;99;0;144;0
WireConnection;99;1;143;0
WireConnection;99;2;142;0
WireConnection;99;3;141;0
WireConnection;22;0;99;0
WireConnection;22;3;71;0
WireConnection;50;0;22;0
WireConnection;91;0;99;0
WireConnection;91;1;92;0
WireConnection;61;0;62;0
WireConnection;61;1;58;0
WireConnection;61;2;50;0
WireConnection;63;0;61;0
WireConnection;63;1;50;0
WireConnection;63;2;91;0
WireConnection;63;3;167;1
WireConnection;48;1;95;0
WireConnection;76;0;72;0
WireConnection;76;1;77;1
WireConnection;155;0;157;0
WireConnection;155;1;156;0
WireConnection;168;0;63;0
WireConnection;164;0;63;0
WireConnection;164;1;161;0
WireConnection;88;0;48;1
WireConnection;88;1;48;4
WireConnection;153;0;155;0
WireConnection;153;1;154;0
WireConnection;78;5;163;0
WireConnection;152;0;153;0
WireConnection;152;1;154;0
WireConnection;152;2;78;0
WireConnection;151;1;152;0
WireConnection;159;0;151;0
WireConnection;159;2;158;0
WireConnection;68;0;69;0
WireConnection;68;1;67;0
WireConnection;161;0;68;0
WireConnection;161;1;159;0
WireConnection;0;0;68;0
WireConnection;0;1;78;0
WireConnection;0;2;168;0
WireConnection;0;3;74;0
WireConnection;0;4;76;0
ASEEND*/
//CHKSM=D2DC843516613AC180D3C0E9D2B1B4E3C6DA7D0E