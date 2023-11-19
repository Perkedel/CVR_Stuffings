// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Water/Surface Uber Clear"
{
	Properties
	{
		[Header(Color Settings)]_Color("Color", Color) = (1,1,1,0)
		_Tint("Tint", Color) = (0,0,0,0)
		[Header(Normal Settings)]_Normal("Normal", 2D) = "bump" {}
		_Normal2nd("Normal 2nd", 2D) = "bump" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.8
		_NormalPower("Normal Power", Range( 0 , 1)) = 1
		_NormalPower2nd("Normal Power 2nd", Range( 0 , 1)) = 0.5
		_Refraction("Refraction", Range( 0 , 1)) = 0.01
		_Refraction2nd("Refraction 2nd", Range( 0 , 1)) = 0.01
		_RefractionDistanceFade1("Refraction Distance Fade", Range( 0 , 1)) = 0.6
		[Header(Animation Settings)]_RipplesSpeed("Ripples Speed", Float) = 1
		_RipplesSpeed2nd("Ripples Speed 2nd", Float) = 1
		_SpeedX("Speed X", Float) = 0
		_SpeedY("Speed Y", Float) = 0
		[Header(Visual Fixes)]_DepthSmoothing("Depth Smoothing", Range( 0 , 1)) = 0.5
		_IntersectionSmoothing("Intersection Smoothing", Range( 0 , 0.1)) = 0.02
		[IntRange]_EdgeMaskShiftpx("Edge Mask Shift (px)", Range( 0 , 3)) = 2
		[Toggle]_ZWrite1("ZWrite", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent-1" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite [_ZWrite1]
		GrabPass{ }
		GrabPass{ "_GrabWater" }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 5.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
			float3 worldPos;
		};

		uniform sampler2D _Normal;
		uniform float _NormalPower;
		uniform float _RipplesSpeed;
		uniform float4 _Normal_ST;
		uniform sampler2D _Sampler0409;
		uniform float _SpeedX;
		uniform float _SpeedY;
		uniform sampler2D _Normal2nd;
		uniform float _NormalPower2nd;
		uniform float _RipplesSpeed2nd;
		uniform float4 _Normal2nd_ST;
		uniform sampler2D _Sampler0410;
		uniform float4 _Tint;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _IntersectionSmoothing;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabWater )
		uniform float _Refraction;
		uniform float _RefractionDistanceFade1;
		uniform float _Refraction2nd;
		uniform float _DepthSmoothing;
		uniform float _EdgeMaskShiftpx;
		uniform float4 _Color;
		uniform float _Smoothness;
		uniform float _ZWrite1;


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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime187 = _Time.y * _RipplesSpeed;
			float2 uv0_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float2 panner22 = ( mulTime187 * float2( -0.04,0 ) + uv0_Normal);
			float mulTime395 = _Time.y * ( _SpeedX / (_Normal_ST.xy).x );
			float mulTime403 = _Time.y * ( _SpeedY / (_Normal_ST.xy).y );
			float2 appendResult402 = (float2(mulTime395 , mulTime403));
			float2 temp_output_422_0 = ( _Normal_ST.xy * appendResult402 );
			float2 panner19 = ( mulTime187 * float2( 0.03,0.03 ) + uv0_Normal);
			float3 temp_output_24_0 = BlendNormals( UnpackScaleNormal( tex2D( _Normal, ( panner22 + temp_output_422_0 ) ), _NormalPower ) , UnpackScaleNormal( tex2D( _Normal, ( panner19 + temp_output_422_0 ) ), _NormalPower ) );
			float mulTime323 = _Time.y * _RipplesSpeed2nd;
			float2 uv0_Normal2nd = i.uv_texcoord * _Normal2nd_ST.xy + _Normal2nd_ST.zw;
			float2 temp_output_397_0 = ( uv0_Normal2nd + float2( 0,0 ) );
			float2 panner320 = ( mulTime323 * float2( 0.03,0.03 ) + temp_output_397_0);
			float2 temp_output_423_0 = ( appendResult402 * _Normal2nd_ST.xy );
			float2 panner321 = ( mulTime323 * float2( -0.04,0 ) + temp_output_397_0);
			float3 temp_output_325_0 = BlendNormals( UnpackScaleNormal( tex2D( _Normal2nd, ( panner320 + temp_output_423_0 ) ), _NormalPower2nd ) , UnpackScaleNormal( tex2D( _Normal2nd, ( panner321 + temp_output_423_0 ) ), _NormalPower2nd ) );
			float3 NormalWater315 = BlendNormals( temp_output_24_0 , temp_output_325_0 );
			o.Normal = NormalWater315;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float eyeDepth167 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float temp_output_168_0 = ( eyeDepth167 - ase_screenPos.w );
			float smoothstepResult725 = smoothstep( 0.0 , 1.0 , (0.0 + (temp_output_168_0 - 0.0) * (1.0 - 0.0) / (_IntersectionSmoothing - 0.0)));
			float IntersectSmoothing714 = smoothstepResult725;
			float4 lerpResult715 = lerp( float4( 0,0,0,0 ) , _Tint , IntersectSmoothing714);
			o.Albedo = lerpResult715.rgb;
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor717 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 screenColor223 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float temp_output_668_0 = ( _Refraction + 0.0001 );
			float3 ase_worldPos = i.worldPos;
			float CameraVertexDistance670 = pow( distance( _WorldSpaceCameraPos , ase_worldPos ) , _RefractionDistanceFade1 );
			float clampResult680 = clamp( ( pow( saturate( temp_output_668_0 ) , 2.0 ) / CameraVertexDistance670 ) , 0.0 , temp_output_668_0 );
			float RefractionPower682 = clampResult680;
			float temp_output_669_0 = ( _Refraction2nd + 0.0001 );
			float clampResult679 = clamp( ( pow( saturate( temp_output_669_0 ) , 2.0 ) / CameraVertexDistance670 ) , 0.0 , temp_output_669_0 );
			float RefractionPower2nd681 = clampResult679;
			float3 lerpResult687 = lerp( ( RefractionPower682 * temp_output_24_0 ) , ( temp_output_325_0 * RefractionPower2nd681 ) , float3( 0.5,0.5,0.5 ));
			float DepthSmoothing658 = saturate( (0.0 + (temp_output_168_0 - 0.0) * (1.0 - 0.0) / (_DepthSmoothing - 0.0)) );
			float2 appendResult706 = (float2((0.0 + (( 1.0 / ( atan( ( 1.0 / unity_CameraProjection[0].x ) ) * 2.0 ) ) - 0.0) * (1.0 - 0.0) / (UNITY_PI - 0.0)) , (0.0 + (( 1.0 / ( atan( ( 1.0 / unity_CameraProjection[1].y ) ) * 2.0 ) ) - 0.0) * (1.0 - 0.0) / (UNITY_PI - 0.0))));
			float2 FovFactor707 = appendResult706;
			float3 NormalShift237 = ( lerpResult687 * DepthSmoothing658 * float3( FovFactor707 ,  0.0 ) );
			float4 screenColor65 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + NormalShift237 ).xy);
			float4 temp_output_214_0 = ( ase_grabScreenPosNorm + float4( NormalShift237 , 0.0 ) );
			float temp_output_436_0 = ( 1.0 / _ScreenParams.y );
			float2 appendResult251 = (float2(0.0 , -temp_output_436_0));
			float2 ShiftDown257 = ( appendResult251 * _EdgeMaskShiftpx );
			float eyeDepth212 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftDown257, 0.0 , 0.0 ) ).xy ));
			float2 appendResult254 = (float2(0.0 , temp_output_436_0));
			float2 ShiftUp258 = ( appendResult254 * _EdgeMaskShiftpx );
			float eyeDepth271 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftUp258, 0.0 , 0.0 ) ).xy ));
			float temp_output_435_0 = ( 1.0 / _ScreenParams.x );
			float2 appendResult255 = (float2(-temp_output_435_0 , 0.0));
			float2 ShiftLeft259 = ( appendResult255 * _EdgeMaskShiftpx );
			float eyeDepth275 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftLeft259, 0.0 , 0.0 ) ).xy ));
			float2 appendResult256 = (float2(temp_output_435_0 , 0.0));
			float2 ShiftRight260 = ( appendResult256 * _EdgeMaskShiftpx );
			float eyeDepth279 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftRight260, 0.0 , 0.0 ) ).xy ));
			float DepthMask188 = ( 1.0 - saturate( ( ( 1.0 - saturate( (0.0 + (( eyeDepth212 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth271 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth275 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth279 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) ) ) );
			float4 lerpResult224 = lerp( screenColor223 , screenColor65 , DepthMask188);
			float4 lerpResult718 = lerp( screenColor717 , ( lerpResult224 * _Color ) , IntersectSmoothing714);
			o.Emission = lerpResult718.rgb;
			float lerpResult720 = lerp( 1.0 , ( _Smoothness + ( _ZWrite1 * 0.0 ) ) , IntersectSmoothing714);
			o.Smoothness = lerpResult720;
			o.Occlusion = IntersectSmoothing714;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1927;10;1906;987;2743.3;1074.812;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;151;-4052.94,-2881.883;Inherit;False;3686.834;1339.161;Normals Generation and Animation;47;409;315;237;98;326;325;24;17;318;319;23;415;416;417;396;322;48;19;22;321;320;187;21;397;410;323;402;331;324;330;403;395;400;401;422;423;426;427;428;429;659;683;684;686;685;687;708;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;661;-3636.935,-1528.689;Inherit;False;1107.247;499.9871;Distance from Camera to Vertex;6;670;667;666;663;688;689;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;660;-2448.599,-1526.384;Inherit;False;1351.063;305.8954;Reftaction Power;8;682;680;678;675;674;671;668;665;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;662;-2448.818,-1177.912;Inherit;False;1442.461;323.4593;Reftaction Power 2nd;8;681;679;677;676;673;672;669;664;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureTransformNode;409;-3750.497,-2801.853;Inherit;False;17;False;1;0;SAMPLER2D;_Sampler0409;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.WorldSpaceCameraPos;663;-3604.424,-1476.321;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;666;-3523.974,-1332.521;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;690;-4094.436,-1007.125;Inherit;False;1567.501;495.8999;FOV from Projection Matrix;17;707;706;705;704;703;702;701;700;699;698;697;696;695;694;693;692;691;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;664;-2426.152,-1031.581;Float;False;Property;_Refraction2nd;Refraction 2nd;9;0;Create;True;0;0;False;0;0.01;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;665;-2411.821,-1377.412;Float;False;Property;_Refraction;Refraction;8;0;Create;True;0;0;False;0;0.01;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;400;-3584.495,-2609.163;Float;False;Property;_SpeedX;Speed X;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;688;-3507.4,-1160.951;Inherit;False;Property;_RefractionDistanceFade1;Refraction Distance Fade;10;0;Create;True;0;0;False;0;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;667;-3309.193,-1411.879;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;-3584.495,-2533.163;Float;False;Property;_SpeedY;Speed Y;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;428;-3492.079,-2816.241;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraProjectionNode;691;-4085.202,-831.7666;Inherit;False;unity_CameraProjection;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.ComponentMaskNode;429;-3489.079,-2727.241;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;689;-3052.674,-1382.982;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;668;-2125.25,-1371.364;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;426;-3249.342,-2610.31;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VectorFromMatrixNode;692;-3838.394,-955.7943;Inherit;False;Row;0;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VectorFromMatrixNode;693;-3835.109,-745.2847;Inherit;False;Row;1;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;669;-2137.966,-1025.533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;427;-3250.629,-2515.089;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;671;-1981.35,-1443.404;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;236;-2441.883,-827.1228;Inherit;False;1230.95;635.3815;Regular Depth For Smoothing;12;714;712;713;229;230;658;232;168;166;167;549;725;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;403;-3098.184,-2518.295;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;395;-3099.675,-2590.216;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;330;-3203.316,-2296.858;Float;False;Property;_RipplesSpeed;Ripples Speed;11;0;Create;True;0;0;False;1;Header(Animation Settings);1;1.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;694;-3635.283,-933.7473;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;695;-3649.205,-719.2847;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;672;-2000.435,-1099.392;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;324;-2947.969,-2126.279;Inherit;False;0;318;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;670;-2819.886,-1417.439;Inherit;False;CameraVertexDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;-3181.358,-1788.573;Float;False;Property;_RipplesSpeed2nd;Ripples Speed 2nd;12;0;Create;True;0;0;False;0;1;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;187;-2878.78,-2291.173;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;676;-1948.204,-956.3184;Inherit;False;670;CameraVertexDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;549;-2402.314,-765.0637;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;323;-2874.744,-1782.893;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureTransformNode;410;-3745.479,-2421.971;Inherit;False;318;False;1;0;SAMPLER2D;_Sampler0410;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-2947.475,-2840.462;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;397;-2680.052,-2117.188;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;402;-2851.184,-2545.295;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ATanOpNode;697;-3520.506,-719.2846;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATanOpNode;696;-3506.584,-933.7473;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;673;-1828.617,-1103.45;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;675;-1829.511,-1447.461;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;674;-1957.524,-1308.425;Inherit;False;670;CameraVertexDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;677;-1633.724,-1098.457;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;-2469.554,-2434.021;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;19;-2506.773,-2705.996;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;321;-2509.189,-1997.057;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;22;-2509.228,-2819.209;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;320;-2511.49,-2113.747;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenDepthNode;167;-2172.855,-776.1737;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;678;-1661.094,-1446.928;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;166;-2383.184,-595.1577;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;-2474.701,-2562.698;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;699;-3397.834,-716.0169;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;698;-3383.913,-930.4796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2602.342,-2288.432;Float;False;Property;_NormalPower;Normal Power;6;0;Create;True;0;0;False;0;1;0.202;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;680;-1485.097,-1442.149;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;322;-2581.932,-1784.474;Float;False;Property;_NormalPower2nd;Normal Power 2nd;7;0;Create;True;0;0;False;0;0.5;0.787;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;396;-2289.985,-2819.258;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;417;-2286.853,-1997.559;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;679;-1457.725,-1093.677;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;700;-3244.713,-951.4464;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;703;-3400.104,-614.41;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;702;-3258.635,-736.9838;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;701;-3395.183,-828.8725;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;415;-2289.63,-2705.49;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;168;-1955.177,-772.8317;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;416;-2288.067,-2114.02;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;229;-2365.842,-386.1727;Float;False;Property;_DepthSmoothing;Depth Smoothing;15;0;Create;True;0;0;False;1;Header(Visual Fixes);0.5;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;391;358.3218,-2960.722;Inherit;False;1305.877;575.3567;Edge Mask Shift;19;294;250;257;258;260;259;292;293;291;290;251;255;256;254;253;252;431;435;436;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;17;-2159.645,-2626.125;Inherit;True;Property;_Normal;Normal;3;0;Create;True;0;0;False;1;Header(Normal Settings);-1;None;6d095a40a0b25e746a709fedd6a9aae6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;681;-1305.314,-1098.821;Inherit;False;RefractionPower2nd;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;318;-2155.74,-1920.477;Inherit;True;Property;_Normal2nd;Normal 2nd;4;0;Create;True;0;0;False;0;-1;None;8d1c512a0b7c09542b55aa818b398907;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;682;-1338.435,-1448.503;Inherit;False;RefractionPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;704;-3106.682,-944.8721;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;705;-3120.604,-730.4096;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;230;-1798.6,-773.4376;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;-2156.2,-2117.936;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;318;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-2160.105,-2823.584;Inherit;True;Property;_Normal2;Normal2;3;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;232;-1613.595,-773.7787;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;24;-1845.233,-2727.892;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;683;-1845.858,-2806.8;Inherit;False;682;RefractionPower;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;325;-1844.918,-2028.421;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;706;-2882.86,-806.5925;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;684;-1848.893,-1905.281;Inherit;False;681;RefractionPower2nd;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenParams;431;373.7685,-2728.93;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;707;-2743.833,-811.3253;Inherit;False;FovFactor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;436;583.5682,-2764.243;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;435;586.5682,-2663.243;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;685;-1574.188,-1990.273;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;-1580.259,-2776.447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;658;-1464.496,-776.8046;Inherit;False;DepthSmoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;659;-1161.665,-2261.305;Inherit;False;658;DepthSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;708;-1097.84,-2166.924;Inherit;False;707;FovFactor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;252;794.0972,-2826.666;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;687;-1127.982,-2397.02;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.5,0.5,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;253;785.7438,-2675.792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;794.7783,-2913.309;Float;False;Constant;_Zero;Zero;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;254;982.8233,-2803.83;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;981.7667,-2618.92;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;255;981.7667,-2711.904;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-875.0182,-2371.182;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;875.8714,-2500.344;Float;False;Property;_EdgeMaskShiftpx;Edge Mask Shift (px);17;1;[IntRange];Create;True;0;0;False;0;2;2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;251;978.5974,-2895.76;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;1177.946,-2795.347;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;292;1176.891,-2698.287;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;243;344.0999,-2312.985;Inherit;False;2395.505;939.7832;Depth Mask for Ripples;37;188;310;287;285;302;300;301;299;314;312;313;311;309;307;308;306;272;217;280;276;279;275;523;212;271;270;274;164;269;278;214;283;261;282;284;240;239;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;237;-716.3003,-2375.541;Float;False;NormalShift;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;290;1172.671,-2895.573;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;293;1174.781,-2607.557;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GrabScreenPosition;240;369.4453,-2268.087;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;1412.225,-2707.64;Float;False;ShiftLeft;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1410.225,-2796.64;Float;False;ShiftUp;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;239;388.732,-2093.312;Inherit;False;237;NormalShift;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;1408.225,-2889.64;Float;False;ShiftDown;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;260;1414.225,-2612.64;Float;False;ShiftRight;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;625.38,-1870.49;Inherit;False;258;ShiftUp;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;691.2556,-2109.87;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;630.3801,-1629.49;Inherit;False;260;ShiftRight;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;625.8105,-2007.495;Inherit;False;257;ShiftDown;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;283;628.38,-1737.49;Inherit;False;259;ShiftLeft;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;269;855.2273,-2024.213;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;274;860.0444,-1754.181;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;270;859.0444,-1885.181;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;278;862.0444,-1648.181;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GrabScreenPosition;164;819.8902,-2264.636;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;271;1007.02,-1865.131;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;523;1075.547,-2082.886;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;212;1003.203,-2004.162;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;279;1010.02,-1628.131;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;275;1010.735,-1734.131;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;272;1226.196,-1861.703;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;217;1222.379,-2000.737;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;276;1227.196,-1730.704;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;280;1229.196,-1624.704;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;308;1394.833,-1742.217;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;309;1399.833,-1572.217;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;307;1393.833,-1912.217;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;306;1389.46,-2111.144;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;312;1585.326,-1906.787;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;314;1585.104,-1572.447;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;313;1575.946,-1736.9;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;311;1560.313,-2117.321;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;300;1721.591,-1913.686;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;299;1709.691,-2110.787;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;301;1724.341,-1744.338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;302;1727.341,-1575.338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;150;792.0497,-1210.58;Inherit;False;1341.654;394.7715;Final Refracted Image;8;219;224;65;96;238;165;220;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;285;2006.279,-1814.59;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;220;821.7784,-1020.044;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;287;2152.721,-1812.171;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;238;1058.76,-924.2972;Inherit;False;237;NormalShift;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;310;2314.365,-1810.079;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;713;-2369.21,-293.1714;Float;False;Property;_IntersectionSmoothing;Intersection Smoothing;16;0;Create;True;0;0;False;0;0.02;0.03;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;165;1065.077,-1020.84;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;1292.657,-1016.572;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;188;2507.413,-1817.778;Float;False;DepthMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;712;-1799.098,-612.2631;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;219;1701.219,-930.1011;Inherit;False;188;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;709;2169.396,-551.1917;Inherit;False;Property;_ZWrite1;ZWrite;18;1;[Toggle];Create;True;2;Option1;0;Option2;1;1;;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;223;1693.022,-1153.928;Float;False;Global;_GrabWater;GrabWater;-1;0;Create;True;0;0;False;0;Object;-1;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;725;-1618.3,-613.8123;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;65;1423.265,-1022.096;Float;False;Global;_WaterGrab;WaterGrab;-1;0;Create;True;0;0;False;0;Instance;223;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;724;2938.886,-1345.045;Inherit;False;506;706.3606;Intersection Smoothing;8;718;715;716;719;720;717;721;723;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;710;2324.037,-548.0731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;368;2212.302,-690.4073;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;326;-1595.463,-2378.58;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;393;2177.229,-901.5897;Float;False;Property;_Color;Color;1;0;Create;True;0;0;False;1;Header(Color Settings);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;714;-1453.51,-618.9005;Inherit;False;IntersectSmoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;224;1948.775,-1040.379;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;716;3000.513,-1208.163;Inherit;False;714;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;711;2506.037,-678.0731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;392;2712.526,-1277.976;Float;False;Property;_Tint;Tint;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;719;2993.168,-928.4714;Inherit;False;714;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;721;2988.886,-834.6844;Inherit;False;714;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;717;3003.431,-1129.979;Float;False;Global;_WaterGrab1;WaterGrab;-1;0;Create;True;0;0;False;0;Instance;223;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;-1381.326,-2382.552;Float;False;NormalWater;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;394;2510.013,-994.9426;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;3471.017,-1060.152;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;723;3159.886,-753.6844;Inherit;False;714;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;718;3258.83,-1018.679;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;715;3254.678,-1295.045;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;720;3260.886,-874.6844;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3805.863,-1067.325;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;RED_SIM/Water/Surface Uber Clear;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;True;False;Back;0;True;709;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-1;True;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;667;0;663;0
WireConnection;667;1;666;0
WireConnection;428;0;409;0
WireConnection;429;0;409;0
WireConnection;689;0;667;0
WireConnection;689;1;688;0
WireConnection;668;0;665;0
WireConnection;426;0;400;0
WireConnection;426;1;428;0
WireConnection;692;0;691;0
WireConnection;693;0;691;0
WireConnection;669;0;664;0
WireConnection;427;0;401;0
WireConnection;427;1;429;0
WireConnection;671;0;668;0
WireConnection;403;0;427;0
WireConnection;395;0;426;0
WireConnection;694;1;692;1
WireConnection;695;1;693;2
WireConnection;672;0;669;0
WireConnection;670;0;689;0
WireConnection;187;0;330;0
WireConnection;323;0;331;0
WireConnection;397;0;324;0
WireConnection;402;0;395;0
WireConnection;402;1;403;0
WireConnection;697;0;695;0
WireConnection;696;0;694;0
WireConnection;673;0;672;0
WireConnection;675;0;671;0
WireConnection;677;0;673;0
WireConnection;677;1;676;0
WireConnection;423;0;402;0
WireConnection;423;1;410;0
WireConnection;19;0;21;0
WireConnection;19;1;187;0
WireConnection;321;0;397;0
WireConnection;321;1;323;0
WireConnection;22;0;21;0
WireConnection;22;1;187;0
WireConnection;320;0;397;0
WireConnection;320;1;323;0
WireConnection;167;0;549;0
WireConnection;678;0;675;0
WireConnection;678;1;674;0
WireConnection;422;0;409;0
WireConnection;422;1;402;0
WireConnection;699;0;697;0
WireConnection;698;0;696;0
WireConnection;680;0;678;0
WireConnection;680;2;668;0
WireConnection;396;0;22;0
WireConnection;396;1;422;0
WireConnection;417;0;321;0
WireConnection;417;1;423;0
WireConnection;679;0;677;0
WireConnection;679;2;669;0
WireConnection;700;1;698;0
WireConnection;702;1;699;0
WireConnection;415;0;19;0
WireConnection;415;1;422;0
WireConnection;168;0;167;0
WireConnection;168;1;166;4
WireConnection;416;0;320;0
WireConnection;416;1;423;0
WireConnection;17;1;415;0
WireConnection;17;5;48;0
WireConnection;681;0;679;0
WireConnection;318;1;417;0
WireConnection;318;5;322;0
WireConnection;682;0;680;0
WireConnection;704;0;700;0
WireConnection;704;2;701;0
WireConnection;705;0;702;0
WireConnection;705;2;703;0
WireConnection;230;0;168;0
WireConnection;230;2;229;0
WireConnection;319;1;416;0
WireConnection;319;5;322;0
WireConnection;23;1;396;0
WireConnection;23;5;48;0
WireConnection;232;0;230;0
WireConnection;24;0;23;0
WireConnection;24;1;17;0
WireConnection;325;0;319;0
WireConnection;325;1;318;0
WireConnection;706;0;704;0
WireConnection;706;1;705;0
WireConnection;707;0;706;0
WireConnection;436;1;431;2
WireConnection;435;1;431;1
WireConnection;685;0;325;0
WireConnection;685;1;684;0
WireConnection;686;0;683;0
WireConnection;686;1;24;0
WireConnection;658;0;232;0
WireConnection;252;0;436;0
WireConnection;687;0;686;0
WireConnection;687;1;685;0
WireConnection;253;0;435;0
WireConnection;254;0;250;0
WireConnection;254;1;436;0
WireConnection;256;0;435;0
WireConnection;256;1;250;0
WireConnection;255;0;253;0
WireConnection;255;1;250;0
WireConnection;98;0;687;0
WireConnection;98;1;659;0
WireConnection;98;2;708;0
WireConnection;251;0;250;0
WireConnection;251;1;252;0
WireConnection;291;0;254;0
WireConnection;291;1;294;0
WireConnection;292;0;255;0
WireConnection;292;1;294;0
WireConnection;237;0;98;0
WireConnection;290;0;251;0
WireConnection;290;1;294;0
WireConnection;293;0;256;0
WireConnection;293;1;294;0
WireConnection;259;0;292;0
WireConnection;258;0;291;0
WireConnection;257;0;290;0
WireConnection;260;0;293;0
WireConnection;214;0;240;0
WireConnection;214;1;239;0
WireConnection;269;0;214;0
WireConnection;269;1;261;0
WireConnection;274;0;214;0
WireConnection;274;1;283;0
WireConnection;270;0;214;0
WireConnection;270;1;282;0
WireConnection;278;0;214;0
WireConnection;278;1;284;0
WireConnection;271;0;270;0
WireConnection;523;0;164;4
WireConnection;212;0;269;0
WireConnection;279;0;278;0
WireConnection;275;0;274;0
WireConnection;272;0;271;0
WireConnection;272;1;523;0
WireConnection;217;0;212;0
WireConnection;217;1;523;0
WireConnection;276;0;275;0
WireConnection;276;1;523;0
WireConnection;280;0;279;0
WireConnection;280;1;523;0
WireConnection;308;0;276;0
WireConnection;309;0;280;0
WireConnection;307;0;272;0
WireConnection;306;0;217;0
WireConnection;312;0;307;0
WireConnection;314;0;309;0
WireConnection;313;0;308;0
WireConnection;311;0;306;0
WireConnection;300;0;312;0
WireConnection;299;0;311;0
WireConnection;301;0;313;0
WireConnection;302;0;314;0
WireConnection;285;0;299;0
WireConnection;285;1;300;0
WireConnection;285;2;301;0
WireConnection;285;3;302;0
WireConnection;287;0;285;0
WireConnection;310;0;287;0
WireConnection;165;0;220;0
WireConnection;96;0;165;0
WireConnection;96;1;238;0
WireConnection;188;0;310;0
WireConnection;712;0;168;0
WireConnection;712;2;713;0
WireConnection;725;0;712;0
WireConnection;65;0;96;0
WireConnection;710;0;709;0
WireConnection;326;0;24;0
WireConnection;326;1;325;0
WireConnection;714;0;725;0
WireConnection;224;0;223;0
WireConnection;224;1;65;0
WireConnection;224;2;219;0
WireConnection;711;0;368;0
WireConnection;711;1;710;0
WireConnection;315;0;326;0
WireConnection;394;0;224;0
WireConnection;394;1;393;0
WireConnection;718;0;717;0
WireConnection;718;1;394;0
WireConnection;718;2;719;0
WireConnection;715;1;392;0
WireConnection;715;2;716;0
WireConnection;720;1;711;0
WireConnection;720;2;721;0
WireConnection;0;0;715;0
WireConnection;0;1;369;0
WireConnection;0;2;718;0
WireConnection;0;4;720;0
WireConnection;0;5;723;0
ASEEND*/
//CHKSM=9D1E9D38DB7585A2EDA702456F8B1C97ABDC51A4