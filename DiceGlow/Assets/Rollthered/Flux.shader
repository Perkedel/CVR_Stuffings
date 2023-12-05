// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered / f.lux"
{
	Properties
	{
		_Flux("F.lux", Range( 0 , 0.5)) = 0
		[HideInInspector]_ConstantMaskClip("ConstantMaskClip", Float) = 0.01
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+1" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		
		GrabPass{ "_Grabass" }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float eyeDepth;
		};

		uniform float _Flux;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _Grabass )
		uniform float _ConstantMaskClip;


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


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float clampResult23 = clamp( ( _Flux + 1.0 ) , 0.0 , 1.02 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor1 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_Grabass,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 temp_cast_0 = (( 1.0 - _Flux )).xxxx;
			float4 clampResult11 = clamp( screenColor1 , float4( 0,0,0,0 ) , temp_cast_0 );
			float3 desaturateInitialColor24 = CalculateContrast(clampResult23,clampResult11).rgb;
			float desaturateDot24 = dot( desaturateInitialColor24, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar24 = lerp( desaturateInitialColor24, desaturateDot24.xxx, _Flux );
			o.Emission = desaturateVar24;
			float cameraDepthFade30 = (( i.eyeDepth -_ProjectionParams.y - 0.57 ) / -0.2);
			float4 temp_cast_2 = (cameraDepthFade30).xxxx;
			o.Alpha = saturate( CalculateContrast(22.0,temp_cast_2) ).r;
			float temp_output_12_0 = _Flux;
			clip( temp_output_12_0 - _ConstantMaskClip );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1373;73;545;927;635.105;-142.6302;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;12;-810.1581,582.5648;Inherit;False;Property;_Flux;F.lux;0;0;Create;True;0;0;False;0;False;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-721.312,372.2873;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;20;-463.9122,653.0873;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-577.0121,364.4874;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;1;-725.5884,11.36942;Inherit;False;Global;_Grabass;Grabass;0;0;Create;True;0;0;False;0;False;Object;-1;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-320.1783,736.8003;Inherit;False;Constant;_Fade;Fade;1;0;Create;True;0;0;False;0;False;-0.2;-0.2;-0.2;-0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-222.9863,817.4598;Inherit;False;Constant;_Offset;Offset;2;0;Create;True;0;0;False;0;False;0.57;0.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;11;-322.5586,366.7646;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;23;-438.4125,173.6875;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1.02;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;30;-130.5827,496.1833;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;14;-320.9116,174.6873;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;33;100.7584,624.4386;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;22;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;219.2263,422.2259;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;24;-343.9793,12.28924;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;29;16.80368,-680.3587;Inherit;False;Constant;_ConstantMaskClip;ConstantMaskClip;2;1;[HideInInspector];Create;True;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Rollthered / f.lux;False;False;False;False;True;True;True;True;True;True;False;False;False;False;True;True;True;False;False;False;False;Off;1;False;-1;7;False;-1;False;1;False;-1;1;False;-1;False;0;Custom;19.28;True;False;1;True;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Spherical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;29;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;12;0
WireConnection;21;0;12;0
WireConnection;21;1;22;0
WireConnection;11;0;1;0
WireConnection;11;2;20;0
WireConnection;23;0;21;0
WireConnection;30;0;31;0
WireConnection;30;1;32;0
WireConnection;14;1;11;0
WireConnection;14;0;23;0
WireConnection;33;1;30;0
WireConnection;34;0;33;0
WireConnection;24;0;14;0
WireConnection;24;1;12;0
WireConnection;0;2;24;0
WireConnection;0;9;34;0
WireConnection;0;10;12;0
ASEEND*/
//CHKSM=D456775EDB1DD924E52F01042F3337171494F277