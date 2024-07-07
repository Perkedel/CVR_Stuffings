// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/Mosaic"
{
	Properties
	{
		_EdgeDarken("Edge Darken", Float) = 0
		_PixelationFactor("Pixelation Factor", Range( 0 , 500)) = 500
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Front
		ZTest Always
		GrabPass{ }
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D _GrabTexture;
		uniform float _PixelationFactor;
		uniform float _EdgeDarken;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult139 = (float2(ase_grabScreenPosNorm.r , ase_grabScreenPosNorm.g));
			float temp_output_143_0 = ( _PixelationFactor - 500.0 );
			float pixelWidth137 =  1.0f / temp_output_143_0;
			float pixelHeight137 = 1.0f / temp_output_143_0;
			half2 pixelateduv137 = half2((int)(appendResult139.x / pixelWidth137) * pixelWidth137, (int)(appendResult139.y / pixelHeight137) * pixelHeight137);
			float4 screenColor127 = tex2D( _GrabTexture, pixelateduv137 );
			float3 temp_output_1_0_g131 = screenColor127.rgb;
			float3 temp_output_2_0_g131 = ddx( temp_output_1_0_g131 );
			float dotResult4_g131 = dot( temp_output_2_0_g131 , temp_output_2_0_g131 );
			float3 temp_output_3_0_g131 = ddy( temp_output_1_0_g131 );
			float dotResult5_g131 = dot( temp_output_3_0_g131 , temp_output_3_0_g131 );
			float ifLocalVar6_g131 = 0;
			if( dotResult4_g131 <= dotResult5_g131 )
				ifLocalVar6_g131 = dotResult5_g131;
			else
				ifLocalVar6_g131 = dotResult4_g131;
			o.Emission = ( ( 1.0 - ( sqrt( ifLocalVar6_g131 ) * _EdgeDarken ) ) * screenColor127 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
115;120;1710;953;1900.449;529.107;1.874043;True;False
Node;AmplifyShaderEditor.GrabScreenPosition;138;-751.7229,25.2037;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;141;-707.0302,309.0457;Float;False;Property;_PixelationFactor;Pixelation Factor;2;0;Create;True;0;0;False;0;500;250;0;500;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;139;-449.5781,148.1553;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;143;-367.1765,305.2279;Float;False;2;0;FLOAT;0;False;1;FLOAT;500;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;137;-282.7229,131.2037;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;127;-63.7229,94.20374;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;130;134.2771,-5.796265;Float;False;ComputeFilterWidth;-1;;131;326bea850683cca44ae7af083d880d70;0;1;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;390.2771,88.20374;Float;False;Property;_EdgeDarken;Edge Darken;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;388.6271,-215.4823;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;131;577.2771,-32.79626;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;563.2771,128.2037;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;859.5849,-28.02994;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Naito/Mosaic;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Front;0;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Overlay;;Overlay;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;1;False;-1;255;False;-1;255;False;-1;8;False;-1;2;False;-1;2;False;-1;0;False;-1;5;False;-1;2;False;-1;2;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;139;0;138;1
WireConnection;139;1;138;2
WireConnection;143;0;141;0
WireConnection;137;0;139;0
WireConnection;137;1;143;0
WireConnection;137;2;143;0
WireConnection;127;0;137;0
WireConnection;130;1;127;0
WireConnection;142;0;130;0
WireConnection;142;1;136;0
WireConnection;131;0;142;0
WireConnection;133;0;131;0
WireConnection;133;1;127;0
WireConnection;0;2;133;0
ASEEND*/
//CHKSM=F92546572A6849793C7D3BC6639F33D689948B4C