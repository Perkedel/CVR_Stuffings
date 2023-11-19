// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Water/Surface Uber"
{
	Properties
	{
		[Header(Color Settings)]_Color("Color", Color) = (1,1,1,0)
		_Tint("Tint", Color) = (0,0,0,0)
		_ColorFar("Color Far", Color) = (0.1058824,0.5686275,0.7568628,0)
		_ColorClose("Color Close", Color) = (0,0.2196079,0.2627451,0)
		_GradientRadiusFar("Gradient Radius Far", Range( 0 , 2)) = 1.2
		_GradientRadiusClose("Gradient Radius Close", Range( 0 , 1)) = 0.3
		_WaterGradientContrast("Water Gradient Contrast", Range( 0 , 1)) = 0
		_ColorSaturation("Color Saturation", Range( 0 , 2)) = 1
		_ColorContrast("Color Contrast", Range( 0 , 3)) = 1
		[Header(Normal Settings)]_Normal("Normal", 2D) = "bump" {}
		_Normal2nd("Normal 2nd", 2D) = "bump" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.8
		_NormalPower("Normal Power", Range( 0 , 1)) = 1
		_NormalPower2nd("Normal Power 2nd", Range( 0 , 1)) = 0.5
		_Refraction("Refraction", Range( 0 , 1)) = 0.01
		_Refraction2nd("Refraction 2nd", Range( 0 , 1)) = 0.01
		_RefractionDistanceFade("Refraction Distance Fade", Range( 0 , 1)) = 0.6
		[Header(Animation Settings)]_RipplesSpeed("Ripples Speed", Float) = 1
		_RipplesSpeed2nd("Ripples Speed 2nd", Float) = 1
		_SpeedX("Speed X", Float) = 0
		_SpeedY("Speed Y", Float) = 0
		[Header(Depth Settings)]_Depth("Depth", Float) = 0.5
		_DepthColorGradation("Depth Color Gradation", Range( 0 , 2)) = 1
		_DepthSaturation("Depth Saturation", Range( 0 , 1)) = 0
		[Header(Visual Fixes)]_DepthSmoothing("Depth Smoothing", Range( 0 , 1)) = 0.5
		_IntrsectionSmoothing("Intrsection Smoothing", Range( 0 , 0.1)) = 0.02
		[IntRange]_EdgeMaskShiftpx("Edge Mask Shift (px)", Range( 0 , 3)) = 2
		[Toggle]_FixUnderwaterEdges("Fix Underwater Edges", Float) = 1
		[Toggle]_ZWrite("ZWrite", Float) = 1
		[Header(Foam)]_FoamColor("Foam Color", Color) = (0,0,0,0)
		_FoamSmoothness("Foam Smoothness", Range( 0 , 1)) = 0.5
		_FoamMaskDistortionPower("Foam Mask Distortion Power", Range( 0 , 2)) = 1
		_FoamDistortionPower("Foam Distortion Power", Range( 0 , 2)) = 1
		_FoamTexture("Foam Texture", 2D) = "white" {}
		_FoamMaskSize("Foam Mask Size", Float) = 0.05
		_FoamGradation("Foam Gradation", Range( 0 , 15)) = 6
		_FoamTexture2nd("Foam Texture 2nd", 2D) = "white" {}
		_FoamSize2nd("Foam Size 2nd", Float) = 0.15
		_FoamGradation2nd("Foam Gradation 2nd", Range( 0 , 15)) = 15
		_RoatationAnimationRadius("Roatation Animation Radius", Float) = 0.2
		_RotationAnimationSpeed("Rotation Animation Speed", Float) = 1
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
		ZWrite [_ZWrite]
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
			float3 worldNormal;
			INTERNAL_DATA
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
		uniform float _IntrsectionSmoothing;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabWater )
		uniform float _ColorContrast;
		uniform float _FixUnderwaterEdges;
		uniform float _Refraction;
		uniform float _RefractionDistanceFade;
		uniform float _Refraction2nd;
		uniform float _DepthSmoothing;
		uniform float _EdgeMaskShiftpx;
		uniform float _Depth;
		uniform float _DepthColorGradation;
		uniform float _DepthSaturation;
		uniform float4 _Color;
		uniform float4 _ColorFar;
		uniform float4 _ColorClose;
		uniform float _WaterGradientContrast;
		uniform float _GradientRadiusFar;
		uniform float _GradientRadiusClose;
		uniform float _ColorSaturation;
		uniform float4 _FoamColor;
		uniform sampler2D _FoamTexture2nd;
		uniform float4 _FoamTexture2nd_ST;
		uniform float _FoamDistortionPower;
		uniform float _RoatationAnimationRadius;
		uniform float _RotationAnimationSpeed;
		uniform float _FoamMaskDistortionPower;
		uniform float _FoamSize2nd;
		uniform float _FoamGradation2nd;
		uniform sampler2D _FoamTexture;
		uniform float4 _FoamTexture_ST;
		uniform float _FoamMaskSize;
		uniform float _FoamGradation;
		uniform float _Smoothness;
		uniform float _FoamSmoothness;
		uniform float _ZWrite;


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

		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
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
			float smoothstepResult805 = smoothstep( 0.0 , 1.0 , (0.0 + (temp_output_168_0 - 0.0) * (1.0 - 0.0) / (_IntrsectionSmoothing - 0.0)));
			float IntersectSmoothing806 = smoothstepResult805;
			float4 lerpResult807 = lerp( float4( 0,0,0,0 ) , _Tint , IntersectSmoothing806);
			o.Albedo = lerpResult807.rgb;
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor810 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float temp_output_654_0 = ( _Refraction + 0.0001 );
			float3 ase_worldPos = i.worldPos;
			float CameraVertexDistance713 = pow( distance( _WorldSpaceCameraPos , ase_worldPos ) , _RefractionDistanceFade );
			float clampResult684 = clamp( ( pow( saturate( temp_output_654_0 ) , 2.0 ) / CameraVertexDistance713 ) , 0.0 , temp_output_654_0 );
			float RefractionPower682 = clampResult684;
			float temp_output_688_0 = ( _Refraction2nd + 0.0001 );
			float clampResult696 = clamp( ( pow( saturate( temp_output_688_0 ) , 2.0 ) / CameraVertexDistance713 ) , 0.0 , temp_output_688_0 );
			float RefractionPower2nd697 = clampResult696;
			float3 lerpResult710 = lerp( ( RefractionPower682 * temp_output_24_0 ) , ( temp_output_325_0 * RefractionPower2nd697 ) , float3( 0.5,0.5,0.5 ));
			float DepthSmoothing679 = saturate( (0.0 + (temp_output_168_0 - 0.0) * (1.0 - 0.0) / (_DepthSmoothing - 0.0)) );
			float2 appendResult742 = (float2((0.0 + (( 1.0 / ( atan( ( 1.0 / unity_CameraProjection[0].x ) ) * 2.0 ) ) - 0.0) * (1.0 - 0.0) / (UNITY_PI - 0.0)) , (0.0 + (( 1.0 / ( atan( ( 1.0 / unity_CameraProjection[1].y ) ) * 2.0 ) ) - 0.0) * (1.0 - 0.0) / (UNITY_PI - 0.0))));
			float2 FovFactor730 = appendResult742;
			float3 NormalShift237 = ( lerpResult710 * DepthSmoothing679 * float3( FovFactor730 ,  0.0 ) );
			float4 temp_output_214_0 = ( ase_grabScreenPosNorm + float4( NormalShift237 , 0.0 ) );
			float temp_output_436_0 = ( 1.0 / _ScreenParams.y );
			float2 appendResult251 = (float2(0.0 , -temp_output_436_0));
			float2 ShiftDown257 = ( appendResult251 * _EdgeMaskShiftpx );
			float eyeDepth472 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftDown257, 0.0 , 0.0 ) ).xy ));
			float DepthMaskDepth477 = _Depth;
			float2 appendResult254 = (float2(0.0 , temp_output_436_0));
			float2 ShiftUp258 = ( appendResult254 * _EdgeMaskShiftpx );
			float eyeDepth485 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftUp258, 0.0 , 0.0 ) ).xy ));
			float temp_output_435_0 = ( 1.0 / _ScreenParams.x );
			float2 appendResult255 = (float2(-temp_output_435_0 , 0.0));
			float2 ShiftLeft259 = ( appendResult255 * _EdgeMaskShiftpx );
			float eyeDepth491 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftLeft259, 0.0 , 0.0 ) ).xy ));
			float2 appendResult256 = (float2(temp_output_435_0 , 0.0));
			float2 ShiftRight260 = ( appendResult256 * _EdgeMaskShiftpx );
			float eyeDepth497 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftRight260, 0.0 , 0.0 ) ).xy ));
			float temp_output_505_0 = ( saturate( sign( ( 1.0 - (0.0 + (( eyeDepth472 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) ) ) * saturate( sign( ( 1.0 - (0.0 + (( eyeDepth485 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) ) ) * saturate( sign( ( 1.0 - (0.0 + (( eyeDepth491 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) ) ) * saturate( sign( ( 1.0 - (0.0 + (( eyeDepth497 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) ) ) );
			float eyeDepth554 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_grabScreenPosNorm.xy ));
			float DepthMaskUnderwater506 = (( _FixUnderwaterEdges )?( ( temp_output_505_0 - saturate( ( 1.0 - sign( ( 1.0 - (0.0 + (( eyeDepth554 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) ) ) ) ) ):( temp_output_505_0 ));
			float eyeDepth455 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float eyeDepth440 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( ase_screenPosNorm + float4( NormalShift237 , 0.0 ) ).xy ));
			float eyeDepth212 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftDown257, 0.0 , 0.0 ) ).xy ));
			float eyeDepth271 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftUp258, 0.0 , 0.0 ) ).xy ));
			float eyeDepth275 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftLeft259, 0.0 , 0.0 ) ).xy ));
			float eyeDepth279 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( temp_output_214_0 + float4( ShiftRight260, 0.0 , 0.0 ) ).xy ));
			float DepthMask188 = ( 1.0 - saturate( ( ( 1.0 - saturate( (0.0 + (( eyeDepth212 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth271 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth275 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) + ( 1.0 - saturate( (0.0 + (( eyeDepth279 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (1E-05 - 0.0)) ) ) ) ) );
			float lerpResult453 = lerp( saturate( (0.0 + (( eyeDepth455 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) , saturate( (0.0 + (( eyeDepth440 - ase_grabScreenPos.a ) - 0.0) * (1.0 - 0.0) / (DepthMaskDepth477 - 0.0)) ) , DepthMask188);
			float smoothstepResult524 = smoothstep( 0.0 , 1.0 , pow( ( 1.0 - ( DepthMaskUnderwater506 * ( 1.0 - lerpResult453 ) ) ) , _DepthColorGradation ));
			float DepthHeightMap527 = smoothstepResult524;
			float lerpResult665 = lerp( 1.0 , _ColorContrast , DepthHeightMap527);
			float4 screenColor223 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float4 screenColor65 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + NormalShift237 ).xy);
			float4 lerpResult224 = lerp( screenColor223 , screenColor65 , DepthMask188);
			float3 hsvTorgb574 = RGBToHSV( lerpResult224.rgb );
			float lerpResult578 = lerp( hsvTorgb574.y , ( hsvTorgb574.y * _DepthSaturation ) , DepthHeightMap527);
			float3 hsvTorgb575 = HSVToRGB( float3(hsvTorgb574.x,lerpResult578,hsvTorgb574.z) );
			float3 normalizeResult629 = normalize( NormalWater315 );
			float3 lerpResult632 = lerp( float3( 0,0,1 ) , normalizeResult629 , _WaterGradientContrast);
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 ase_tanViewDir = mul( ase_worldToTangent, ase_worldViewDir );
			float dotResult627 = dot( lerpResult632 , ase_tanViewDir );
			float temp_output_537_0 = ( 1.0 - _GradientRadiusFar );
			float smoothstepResult536 = smoothstep( 0.0 , 1.0 , saturate( (0.0 + (dotResult627 - temp_output_537_0) * (1.0 - 0.0) / (( temp_output_537_0 + ( 1.0 - _GradientRadiusClose ) ) - temp_output_537_0)) ));
			float WaterSurfaceGradientMask540 = smoothstepResult536;
			float4 lerpResult542 = lerp( _ColorFar , _ColorClose , WaterSurfaceGradientMask540);
			float4 lerpResult448 = lerp( ( float4( hsvTorgb575 , 0.0 ) * _Color ) , lerpResult542 , DepthHeightMap527);
			float3 hsvTorgb656 = RGBToHSV( lerpResult448.rgb );
			float lerpResult666 = lerp( 1.0 , _ColorSaturation , DepthHeightMap527);
			float3 hsvTorgb657 = HSVToRGB( float3(hsvTorgb656.x,( hsvTorgb656.y * lerpResult666 ),hsvTorgb656.z) );
			float2 uv0_FoamTexture2nd = i.uv_texcoord * _FoamTexture2nd_ST.xy + _FoamTexture2nd_ST.zw;
			float3 NormalShiftSource793 = lerpResult710;
			float3 temp_output_748_0 = ( NormalShiftSource793 * float3( FovFactor730 ,  0.0 ) );
			float3 FoamUVShift763 = ( _FoamDistortionPower * temp_output_748_0 );
			float mulTime773 = _Time.y * _RotationAnimationSpeed;
			float2 appendResult779 = (float2(( _RoatationAnimationRadius * cos( mulTime773 ) ) , ( _RoatationAnimationRadius * sin( mulTime773 ) )));
			float eyeDepth753 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( float4( ( temp_output_748_0 * _FoamMaskDistortionPower ) , 0.0 ) + ase_screenPosNorm ).xy ));
			float temp_output_757_0 = abs( ( eyeDepth753 - ase_screenPos.w ) );
			float smoothstepResult767 = smoothstep( 1.0 , 0.0 , pow( (0.0 + (temp_output_757_0 - 0.0) * (1.0 - 0.0) / (_FoamSize2nd - 0.0)) , _FoamGradation2nd ));
			float FoamMask2nd769 = smoothstepResult767;
			float2 uv0_FoamTexture = i.uv_texcoord * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
			float smoothstepResult768 = smoothstep( 1.0 , 0.0 , pow( (0.0 + (temp_output_757_0 - 0.0) * (1.0 - 0.0) / (_FoamMaskSize - 0.0)) , _FoamGradation ));
			float FoamMask770 = smoothstepResult768;
			float lerpResult791 = lerp( ( tex2D( _FoamTexture2nd, ( float3( uv0_FoamTexture2nd ,  0.0 ) + FoamUVShift763 + float3( appendResult779 ,  0.0 ) ).xy ).r * FoamMask2nd769 ) , tex2D( _FoamTexture, ( float3( uv0_FoamTexture ,  0.0 ) + FoamUVShift763 + float3( appendResult779 ,  0.0 ) ).xy ).r , FoamMask770);
			float FoamFinal792 = lerpResult791;
			float4 lerpResult794 = lerp( CalculateContrast(lerpResult665,float4( hsvTorgb657 , 0.0 )) , _FoamColor , ( _FoamColor.a * FoamFinal792 ));
			float4 lerpResult809 = lerp( screenColor810 , lerpResult794 , IntersectSmoothing806);
			o.Emission = lerpResult809.rgb;
			float lerpResult798 = lerp( _Smoothness , _FoamSmoothness , FoamFinal792);
			float lerpResult813 = lerp( 1.0 , ( lerpResult798 + ( _ZWrite * 0.0 ) ) , IntersectSmoothing806);
			o.Smoothness = lerpResult813;
			o.Occlusion = IntersectSmoothing806;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1927;10;1906;987;2655.573;928.6575;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;714;-3388.879,-1495.971;Inherit;False;977.2473;442.9871;Distance from Camera to Vertex;6;722;720;715;716;717;713;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;-4052.94,-2881.883;Inherit;False;3544.885;1210.885;Normals Generation and Animation;48;708;710;709;315;326;237;98;702;325;683;24;703;318;319;17;23;48;415;396;417;322;416;321;320;422;19;22;423;323;397;410;402;187;21;331;395;403;330;324;426;427;428;401;400;429;409;743;793;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;723;-3972.916,-775.3356;Inherit;False;1567.501;495.8999;FOV from Projection Matrix;17;730;742;739;734;733;729;728;727;726;725;724;740;738;737;736;741;735;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;716;-3374.368,-1443.603;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;717;-3293.918,-1299.803;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;686;-2330.762,-1145.193;Inherit;False;1442.461;323.4593;Reftaction Power 2nd;8;697;719;692;688;687;689;696;694;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;681;-2330.543,-1493.666;Inherit;False;1351.063;305.8954;Reftaction Power;8;682;718;655;585;389;654;684;674;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureTransformNode;409;-3750.497,-2801.853;Inherit;False;17;False;1;0;SAMPLER2D;_Sampler0409;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.RangedFloatNode;400;-3584.495,-2609.163;Float;False;Property;_SpeedX;Speed X;19;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;428;-3492.079,-2816.241;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;715;-3079.137,-1379.161;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;722;-3336.832,-1157.638;Inherit;False;Property;_RefractionDistanceFade;Refraction Distance Fade;16;0;Create;True;0;0;False;0;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;389;-2295.378,-1344.694;Float;False;Property;_Refraction;Refraction;14;0;Create;True;0;0;False;0;0.01;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;-3584.495,-2533.163;Float;False;Property;_SpeedY;Speed Y;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;429;-3489.079,-2727.241;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraProjectionNode;724;-3963.682,-599.9769;Inherit;False;unity_CameraProjection;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;687;-2308.096,-998.8625;Float;False;Property;_Refraction2nd;Refraction 2nd;15;0;Create;True;0;0;False;0;0.01;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;654;-2007.193,-1338.646;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;427;-3250.629,-2515.089;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;720;-2882.106,-1379.669;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VectorFromMatrixNode;735;-3716.874,-724.0046;Inherit;False;Row;0;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;688;-2019.91,-992.8146;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;426;-3249.342,-2610.31;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VectorFromMatrixNode;725;-3713.589,-513.4951;Inherit;False;Row;1;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;331;-3181.358,-1788.573;Float;False;Property;_RipplesSpeed2nd;Ripples Speed 2nd;18;0;Create;True;0;0;False;0;1;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;395;-3099.675,-2590.216;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;403;-3098.184,-2518.295;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;330;-3203.316,-2296.858;Float;False;Property;_RipplesSpeed;Ripples Speed;17;0;Create;True;0;0;False;1;Header(Animation Settings);1;1.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;655;-1863.293,-1410.686;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;726;-3527.685,-487.4951;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;236;-2324.513,-792.6731;Inherit;False;1262.624;723.7359;Regular Depth For Smoothing;12;679;232;230;229;168;166;167;549;803;804;805;806;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;689;-1882.378,-1066.673;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;713;-2701.83,-1384.721;Inherit;False;CameraVertexDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;324;-2947.969,-2126.279;Inherit;False;0;318;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;741;-3513.763,-701.9576;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;692;-1710.561,-1070.731;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;585;-1711.455,-1414.743;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;719;-1830.147,-923.5995;Inherit;False;713;CameraVertexDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;397;-2680.052,-2117.188;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;549;-2313.229,-730.6137;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureTransformNode;410;-3745.479,-2421.971;Inherit;False;318;False;1;0;SAMPLER2D;_Sampler0410;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-2947.475,-2840.462;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;402;-2851.184,-2545.295;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ATanOpNode;736;-3385.064,-701.9576;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;187;-2878.78,-2291.173;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;323;-2874.744,-1782.893;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATanOpNode;727;-3398.986,-487.495;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;718;-1839.467,-1275.707;Inherit;False;713;CameraVertexDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;674;-1543.037,-1414.21;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;321;-2509.189,-1997.057;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;22;-2509.228,-2819.209;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;166;-2294.099,-560.7076;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;19;-2506.773,-2705.996;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;320;-2511.49,-2113.747;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;-2474.701,-2562.698;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;728;-3276.315,-484.2272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;737;-3262.393,-698.6899;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;694;-1515.667,-1065.738;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;-2469.554,-2434.021;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenDepthNode;167;-2083.771,-741.7237;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;729;-3137.115,-505.1942;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;396;-2289.985,-2819.258;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;696;-1339.669,-1060.958;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2602.342,-2288.432;Float;False;Property;_NormalPower;Normal Power;12;0;Create;True;0;0;False;0;1;0.202;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;168;-1873.094,-738.3817;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;684;-1367.04,-1409.431;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;229;-2276.757,-351.7224;Float;False;Property;_DepthSmoothing;Depth Smoothing;24;0;Create;True;0;0;False;1;Header(Visual Fixes);0.5;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;417;-2286.853,-1997.559;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;415;-2289.63,-2705.49;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;322;-2581.932,-1784.474;Float;False;Property;_NormalPower2nd;Normal Power 2nd;13;0;Create;True;0;0;False;0;0.5;0.787;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;416;-2288.067,-2114.02;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;734;-3278.585,-382.6203;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;739;-3273.663,-597.0828;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;738;-3123.193,-719.6566;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;-2156.2,-2117.936;Inherit;True;Property;_TextureSample3;Texture Sample 3;10;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;318;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;740;-2985.162,-713.0824;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;230;-1709.519,-738.9876;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;697;-1187.258,-1066.102;Inherit;False;RefractionPower2nd;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;733;-2999.084,-498.6199;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-2159.645,-2626.125;Inherit;True;Property;_Normal;Normal;9;0;Create;True;0;0;False;1;Header(Normal Settings);-1;None;6d095a40a0b25e746a709fedd6a9aae6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;682;-1220.379,-1415.785;Inherit;False;RefractionPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;318;-2155.74,-1920.477;Inherit;True;Property;_Normal2nd;Normal 2nd;10;0;Create;True;0;0;False;0;-1;None;8d1c512a0b7c09542b55aa818b398907;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;391;189.6031,-4130.25;Inherit;False;1305.877;575.3567;Edge Mask Shift;19;294;250;257;258;260;259;292;293;291;290;251;255;256;254;253;252;431;435;436;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;23;-2160.105,-2823.584;Inherit;True;Property;_Normal2;Normal2;9;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;683;-1839.433,-2814.429;Inherit;False;682;RefractionPower;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;325;-1844.918,-2028.421;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenParams;431;205.0498,-3898.458;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;232;-1524.514,-739.3287;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;742;-2761.34,-574.8028;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendNormalsNode;24;-1845.233,-2727.892;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;703;-1839.194,-1927.021;Inherit;False;697;RefractionPower2nd;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;435;417.8493,-3832.771;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;702;-1449.822,-2000.559;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;436;414.8493,-3933.771;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;730;-2622.313,-579.5356;Inherit;False;FovFactor;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;679;-1363.193,-748.5508;Inherit;False;DepthSmoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-1467.716,-2782.065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;253;617.0249,-3845.319;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;743;-1144.161,-2049.93;Inherit;False;730;FovFactor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;709;-1186.877,-2190.348;Inherit;False;679;DepthSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;626.0594,-4082.837;Float;False;Constant;_Zero;Zero;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;252;625.3783,-3996.193;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;710;-1118.073,-2338.242;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.5,0.5,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;256;813.0477,-3788.448;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;251;809.8784,-4065.288;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;254;814.1044,-3973.358;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;255;813.0477,-3881.432;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;708;-914.8604,-2334.117;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;707.1525,-3669.872;Float;False;Property;_EdgeMaskShiftpx;Edge Mask Shift (px);26;1;[IntRange];Create;True;0;0;False;0;2;2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;290;1003.952,-4065.1;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;293;1006.062,-3777.085;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;1009.227,-3964.875;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;237;-747.1711,-2337.601;Float;False;NormalShift;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;292;1008.172,-3867.815;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;243;149.7014,-3451.1;Inherit;False;2868.108;2047.355;Depth Mask for Ripples;82;188;310;287;285;300;299;301;302;313;314;311;312;307;306;308;309;217;276;272;280;275;212;164;271;279;270;269;278;274;214;283;282;284;261;240;239;471;472;468;476;474;475;481;482;484;485;486;487;488;489;490;491;492;493;494;495;496;497;498;499;500;501;502;503;504;505;506;508;509;510;511;523;554;555;556;557;558;559;560;562;563;564;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;1239.506,-4059.168;Float;False;ShiftDown;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;239;194.3335,-3231.427;Inherit;False;237;NormalShift;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;240;175.0468,-3406.203;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;1241.506,-3966.168;Float;False;ShiftUp;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;1243.506,-3877.168;Float;False;ShiftLeft;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;260;1245.506,-3782.168;Float;False;ShiftRight;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;431.4119,-3145.61;Inherit;False;257;ShiftDown;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;496.8569,-3247.985;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;283;433.9814,-2875.605;Inherit;False;259;ShiftLeft;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;435.9814,-2767.605;Inherit;False;260;ShiftRight;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;282;430.9814,-3008.605;Inherit;False;258;ShiftUp;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;278;667.6458,-2786.296;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;504;444.3877,-1810.975;Inherit;False;260;ShiftRight;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GrabScreenPosition;164;625.4916,-3402.751;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;270;664.6458,-3023.296;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;274;665.6458,-2892.296;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;269;660.8287,-3162.328;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;503;429.9525,-1975.999;Inherit;False;259;ShiftLeft;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;520;-677.012,67.49275;Inherit;False;2805.856;811.592;Mask Blending;26;524;519;518;507;517;453;512;458;444;457;443;456;442;455;440;450;447;454;446;441;477;445;527;547;572;573;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;481;435.9729,-2347.279;Inherit;False;257;ShiftDown;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;502;433.4041,-2169.056;Inherit;False;258;ShiftUp;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenDepthNode;279;815.6219,-2766.246;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;471;682.7201,-2365.358;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;484;686.3845,-2184.333;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenDepthNode;271;812.6219,-3003.246;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;523;881.1487,-3221.001;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;445;-87.25957,771.1047;Float;False;Property;_Depth;Depth;21;0;Create;True;0;0;False;1;Header(Depth Settings);0.5;0.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;275;816.3362,-2872.246;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;490;687.6812,-2006.676;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;496;688.9781,-1826.424;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;562;407.3869,-1673.191;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenDepthNode;212;808.8049,-3142.277;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;276;1032.798,-2868.819;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;554;817.8333,-1610.318;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;491;819.7997,-2000.525;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;217;1027.981,-3138.852;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;497;821.0966,-1820.273;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;280;1034.798,-2762.819;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;477;198.8723,765.1018;Float;False;DepthMaskDepth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;485;818.5031,-2178.183;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;472;814.8386,-2359.207;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;272;1031.798,-2999.818;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;309;1205.435,-2710.332;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;482;957.1179,-2522.879;Inherit;False;477;DepthMaskDepth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;555;1033.744,-1622.231;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;468;1030.749,-2371.12;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;308;1200.435,-2880.332;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;486;1034.413,-2190.096;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;498;1037.007,-1832.187;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;492;1035.71,-2012.438;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;307;1199.435,-3050.332;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;306;1195.062,-3249.259;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E-05;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;487;1209.562,-2225.283;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;493;1210.859,-2047.624;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;476;1205.898,-2406.307;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;556;1217.955,-1653.219;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;499;1212.156,-1867.374;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;314;1390.706,-2710.562;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;311;1365.915,-3255.436;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;312;1390.928,-3044.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;313;1381.548,-2875.015;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;441;-451.9225,499.268;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;299;1515.293,-3248.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;474;1419.018,-2369.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;488;1422.682,-2188.245;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;302;1532.943,-2713.453;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;446;-448.291,675.0431;Inherit;False;237;NormalShift;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;300;1527.193,-3051.801;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;557;1392.195,-1653.171;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;301;1529.943,-2882.453;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;500;1425.276,-1830.335;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;494;1423.979,-2010.587;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;475;1587.846,-2369.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;558;1544.12,-1653.171;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;547;-539.7036,131.6027;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SignOpNode;489;1591.51,-2188.245;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;501;1594.104,-1830.335;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;285;1811.881,-2952.705;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;447;-199.0623,594.0399;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SignOpNode;495;1592.807,-2010.587;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;287;1958.323,-2950.286;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;511;1712.931,-1833.829;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;510;1714.931,-2010.829;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;450;-61.26762,425.549;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;508;1714.931,-2369.83;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;509;1707.931,-2191.83;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;455;-322.3679,131.0657;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;563;1676.507,-1652.374;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;454;-542.4008,311.3089;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;440;-39.1256,595.601;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;505;1924.59,-2146.208;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;442;219.8134,604.1019;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;310;2119.966,-2948.194;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;559;1828.499,-1650.795;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;456;-60.62663,332.2219;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;744;1031.314,2657.617;Inherit;False;2105.521;1021.313;Foam;26;770;769;768;767;766;765;764;763;762;761;760;759;758;757;756;755;754;753;752;751;750;749;748;747;746;745;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;793;-915.1814,-2445.133;Float;False;NormalShiftSource;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;560;2244.67,-1690.284;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;188;2313.015,-2955.893;Float;False;DepthMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;457;506.6825,333.6868;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;443;500.8185,645.7579;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;746;1130.5,3106.95;Inherit;False;730;FovFactor;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;745;1081.314,3022.981;Inherit;False;793;NormalShiftSource;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;326;-1593.01,-2314.902;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;444;709.0895,645.4169;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;458;719.2325,345.4669;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;564;2452.895,-1794.257;Inherit;False;Property;_FixUnderwaterEdges;Fix Underwater Edges;28;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;512;696.9505,727.928;Inherit;False;188;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;453;907.1686,479.7909;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;747;1131.981,3200.243;Inherit;False;Property;_FoamMaskDistortionPower;Foam Mask Distortion Power;32;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;748;1338.865,3033.881;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;-1393.433,-2319.385;Float;False;NormalWater;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;541;461.06,-588.1558;Inherit;False;1653.492;565.3171;Water Surface Gradient Mask;15;629;626;627;529;545;536;531;535;537;539;534;533;540;631;632;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;506;2728.977,-1798.922;Float;False;DepthMaskUnderwater;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;150;-463.2697,-1348.359;Inherit;False;1341.654;394.7715;Final Refracted Image;8;219;224;65;96;238;165;220;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GrabScreenPosition;220;-433.541,-1157.823;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;750;1191.237,3285.189;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;749;1528.342,3076.957;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;507;940.2786,350.846;Inherit;False;506;DepthMaskUnderwater;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;517;1069.384,449.9059;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;626;517.5896,-544.4313;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;751;1690.887,3099.972;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;534;608,-112;Float;False;Property;_GradientRadiusClose;Gradient Radius Close;5;0;Create;True;0;0;False;0;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;165;-190.2426,-1158.619;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;629;741.634,-538.9361;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;533;608,-192;Float;False;Property;_GradientRadiusFar;Gradient Radius Far;4;0;Create;True;0;0;False;0;1.2;1.2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;631;528.1008,-445.5413;Inherit;False;Property;_WaterGradientContrast;Water Gradient Contrast;6;0;Create;True;0;0;False;0;0;0.305;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;238;-196.5595,-1062.076;Inherit;False;237;NormalShift;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;518;1250.024,391.454;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;539;944,-112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;37.33833,-1154.351;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;519;1381.189,395.3361;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;753;1837.634,3114.953;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;752;1685.092,3199.618;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;573;1201.974,556.894;Inherit;False;Property;_DepthColorGradation;Depth Color Gradation;22;0;Create;True;0;0;False;0;1;0.322;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;529;581.6958,-339.2216;Float;False;Tangent;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;771;1071.889,1575.681;Inherit;False;2060.904;959.8669;Fog Visual;21;792;791;790;789;788;787;786;785;784;783;782;781;780;779;778;777;776;775;774;773;772;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;632;914.2594,-512.629;Inherit;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;537;944,-192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;65;167.9453,-1159.875;Float;False;Global;_WaterGrab;WaterGrab;-1;0;Create;True;0;0;False;0;Instance;223;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;219;445.9003,-1067.88;Inherit;False;188;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;772;1142.06,2399.232;Inherit;False;Property;_RotationAnimationSpeed;Rotation Animation Speed;41;0;Create;True;0;0;False;0;1;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;754;2055.311,3118.294;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;627;1063.31,-350.0421;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;535;1120,-144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;572;1529.974,407.8939;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;223;437.7033,-1291.707;Float;False;Global;_GrabWater;GrabWater;-1;0;Create;True;0;0;False;0;Object;-1;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;757;2186.242,3115.539;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;224;693.4555,-1178.158;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;773;1427.62,2406.628;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;580;908.9073,-1207.454;Inherit;False;1206.55;577.2659;Depth Saturation;6;578;579;576;577;574;575;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;756;2109.367,2749.882;Float;False;Property;_FoamSize2nd;Foam Size 2nd;38;0;Create;True;0;0;False;0;0.15;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;755;1168.365,2894.886;Inherit;False;Property;_FoamDistortionPower;Foam Distortion Power;33;0;Create;True;0;0;False;0;1;0.414;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;524;1684.583,389.0819;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;531;1264,-256;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;774;1623.62,2450.628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;761;1527.188,2942.147;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;758;2111.648,3444.954;Float;False;Property;_FoamMaskSize;Foam Mask Size;35;0;Create;True;0;0;False;0;0.05;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;759;2254.961,2882.859;Inherit;False;Property;_FoamGradation2nd;Foam Gradation 2nd;39;0;Create;True;0;0;False;0;15;15;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;760;2342.605,2707.617;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;545;1429.585,-261.9949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;776;1622.62,2361.628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;574;1134.754,-1108.846;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;775;1456.139,2281.43;Inherit;False;Property;_RoatationAnimationRadius;Roatation Animation Radius;40;0;Create;True;0;0;False;0;0.2;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;577;1029.042,-852.0707;Inherit;False;Property;_DepthSaturation;Depth Saturation;23;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;527;1854.339,387.148;Float;False;DepthHeightMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;536;1587.918,-258.0101;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;579;1371.206,-925.3617;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;764;2549.961,2736.859;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;763;1681.543,2937.141;Inherit;False;FoamUVShift;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;765;2341.886,3350.688;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;777;1771.62,2338.628;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;762;2259.242,3563.931;Inherit;False;Property;_FoamGradation;Foam Gradation;36;0;Create;True;0;0;False;0;6;6;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;576;1076.59,-778.4052;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;778;1769.62,2427.628;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;766;2549.241,3379.931;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;779;1911.62,2380.628;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;780;1708.059,2083.351;Inherit;False;763;FoamUVShift;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;767;2706.064,2736.019;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;540;1786.833,-264.0378;Float;False;WaterSurfaceGradientMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;578;1613.322,-954.0599;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;781;1666.756,1940.366;Inherit;False;0;785;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;769;2880.193,2733.047;Inherit;False;FoamMask2nd;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;784;1906.619,1784.863;Inherit;False;763;FoamUVShift;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;783;1885.049,1644.76;Inherit;False;0;790;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;782;1953.059,1948.351;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;393;2201.321,-949.7728;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;1;Header(Color Settings);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;544;2153.902,-421.4179;Inherit;False;540;WaterSurfaceGradientMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;543;2187.306,-768.2104;Float;False;Property;_ColorFar;Color Far;2;0;Create;True;0;0;False;0;0.1058824,0.5686275,0.7568628,0;0.1058803,0.5686274,0.7568628,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HSVToRGBNode;575;1871.243,-1085.539;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;449;2197.108,-599.6501;Float;False;Property;_ColorClose;Color Close;3;0;Create;True;0;0;False;0;0,0.2196079,0.2627451,0;0,0.262743,0.2623914,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;768;2705.345,3379.089;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;770;2893.837,3367.979;Inherit;False;FoamMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;785;2086.927,1924.169;Inherit;True;Property;_FoamTexture2nd;Foam Texture 2nd;37;0;Create;True;0;0;False;0;-1;None;50fdd0fbca63f0e49b8fc67f7b9ac764;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;394;2510.013,-994.9426;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;787;2151.619,1649.863;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;786;2160.952,2123.919;Inherit;False;769;FoamMask2nd;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;528;2232.839,-313.1298;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;542;2514.605,-601.3106;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;662;2679.629,-297.9785;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;659;2673.85,-475.11;Inherit;False;Property;_ColorSaturation;Color Saturation;7;0;Create;True;0;0;False;0;1;1.074;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;790;2285.487,1625.681;Inherit;True;Property;_FoamTexture;Foam Texture;34;0;Create;True;0;0;False;0;-1;None;212f3bfdd0f3ab74c8346cc879f7deee;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;789;2482.388,1847.996;Inherit;False;770;FoamMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;448;2734.398,-639.1109;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;788;2455.952,2001.919;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;656;2918.174,-703.4124;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;666;2993.902,-522.4247;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;791;2735.952,1803.419;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;803;-2277.343,-190.4023;Float;False;Property;_IntrsectionSmoothing;Intrsection Smoothing;25;0;Create;True;0;0;False;0;0.02;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;792;2889.794,1800.979;Inherit;False;FoamFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;658;3172.97,-668.3116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;804;-1710.105,-577.6672;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;661;2674.693,-399.8228;Inherit;False;Property;_ColorContrast;Color Contrast;8;0;Create;True;0;0;False;0;1;1.6;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;799;2662.056,-117.4631;Float;False;Property;_FoamSmoothness;Foam Smoothness;31;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;665;2994.902,-407.4246;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;368;2671.479,-207.7254;Float;False;Property;_Smoothness;Smoothness;11;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;657;3334.171,-694.3114;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SmoothstepOpNode;805;-1519.993,-578.2753;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;795;3554.883,-507.9737;Inherit;False;Property;_FoamColor;Foam Color;30;0;Create;True;0;0;False;1;Header(Foam);0,0,0,0;1,1,1,0.5019608;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;797;3552.447,-338.3739;Inherit;False;792;FoamFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;800;3615.569,-122.9404;Inherit;False;Property;_ZWrite;ZWrite;29;1;[Toggle];Create;True;2;Option1;0;Option2;1;1;;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;796;3751.181,-404.3566;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;660;3586.873,-607.0127;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;798;3758.248,-239.0887;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;815;4190.797,-967.447;Inherit;False;507.3296;705.0847;Intersection Smoothing;8;810;809;811;813;814;812;807;808;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;801;3770.209,-119.8218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;806;-1352.209,-584.6454;Inherit;False;IntersectSmoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;392;3863.127,-900.3196;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;802;3932.07,-236.3965;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;794;3884.296,-603.1996;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;810;4257.139,-736.7093;Float;False;Global;_WaterGrab1;WaterGrab;-1;0;Create;True;0;0;False;0;Instance;223;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;811;4248.681,-545.8719;Inherit;False;806;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;808;4240.797,-816.4413;Inherit;False;806;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;814;4252.127,-453.3623;Inherit;False;806;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;4718.595,-668.0909;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;813;4514.127,-504.3623;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;812;4412.834,-377.3622;Inherit;False;806;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;807;4505.895,-917.447;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;809;4507.702,-631.3647;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5005.147,-687.0005;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;RED_SIM/Water/Surface Uber;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;True;False;Back;0;True;800;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-1;True;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;27;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;428;0;409;0
WireConnection;715;0;716;0
WireConnection;715;1;717;0
WireConnection;429;0;409;0
WireConnection;654;0;389;0
WireConnection;427;0;401;0
WireConnection;427;1;429;0
WireConnection;720;0;715;0
WireConnection;720;1;722;0
WireConnection;735;0;724;0
WireConnection;688;0;687;0
WireConnection;426;0;400;0
WireConnection;426;1;428;0
WireConnection;725;0;724;0
WireConnection;395;0;426;0
WireConnection;403;0;427;0
WireConnection;655;0;654;0
WireConnection;726;1;725;2
WireConnection;689;0;688;0
WireConnection;713;0;720;0
WireConnection;741;1;735;1
WireConnection;692;0;689;0
WireConnection;585;0;655;0
WireConnection;397;0;324;0
WireConnection;402;0;395;0
WireConnection;402;1;403;0
WireConnection;736;0;741;0
WireConnection;187;0;330;0
WireConnection;323;0;331;0
WireConnection;727;0;726;0
WireConnection;674;0;585;0
WireConnection;674;1;718;0
WireConnection;321;0;397;0
WireConnection;321;1;323;0
WireConnection;22;0;21;0
WireConnection;22;1;187;0
WireConnection;19;0;21;0
WireConnection;19;1;187;0
WireConnection;320;0;397;0
WireConnection;320;1;323;0
WireConnection;422;0;409;0
WireConnection;422;1;402;0
WireConnection;728;0;727;0
WireConnection;737;0;736;0
WireConnection;694;0;692;0
WireConnection;694;1;719;0
WireConnection;423;0;402;0
WireConnection;423;1;410;0
WireConnection;167;0;549;0
WireConnection;729;1;728;0
WireConnection;396;0;22;0
WireConnection;396;1;422;0
WireConnection;696;0;694;0
WireConnection;696;2;688;0
WireConnection;168;0;167;0
WireConnection;168;1;166;4
WireConnection;684;0;674;0
WireConnection;684;2;654;0
WireConnection;417;0;321;0
WireConnection;417;1;423;0
WireConnection;415;0;19;0
WireConnection;415;1;422;0
WireConnection;416;0;320;0
WireConnection;416;1;423;0
WireConnection;738;1;737;0
WireConnection;319;1;416;0
WireConnection;319;5;322;0
WireConnection;740;0;738;0
WireConnection;740;2;739;0
WireConnection;230;0;168;0
WireConnection;230;2;229;0
WireConnection;697;0;696;0
WireConnection;733;0;729;0
WireConnection;733;2;734;0
WireConnection;17;1;415;0
WireConnection;17;5;48;0
WireConnection;682;0;684;0
WireConnection;318;1;417;0
WireConnection;318;5;322;0
WireConnection;23;1;396;0
WireConnection;23;5;48;0
WireConnection;325;0;319;0
WireConnection;325;1;318;0
WireConnection;232;0;230;0
WireConnection;742;0;740;0
WireConnection;742;1;733;0
WireConnection;24;0;23;0
WireConnection;24;1;17;0
WireConnection;435;1;431;1
WireConnection;702;0;325;0
WireConnection;702;1;703;0
WireConnection;436;1;431;2
WireConnection;730;0;742;0
WireConnection;679;0;232;0
WireConnection;98;0;683;0
WireConnection;98;1;24;0
WireConnection;253;0;435;0
WireConnection;252;0;436;0
WireConnection;710;0;98;0
WireConnection;710;1;702;0
WireConnection;256;0;435;0
WireConnection;256;1;250;0
WireConnection;251;0;250;0
WireConnection;251;1;252;0
WireConnection;254;0;250;0
WireConnection;254;1;436;0
WireConnection;255;0;253;0
WireConnection;255;1;250;0
WireConnection;708;0;710;0
WireConnection;708;1;709;0
WireConnection;708;2;743;0
WireConnection;290;0;251;0
WireConnection;290;1;294;0
WireConnection;293;0;256;0
WireConnection;293;1;294;0
WireConnection;291;0;254;0
WireConnection;291;1;294;0
WireConnection;237;0;708;0
WireConnection;292;0;255;0
WireConnection;292;1;294;0
WireConnection;257;0;290;0
WireConnection;258;0;291;0
WireConnection;259;0;292;0
WireConnection;260;0;293;0
WireConnection;214;0;240;0
WireConnection;214;1;239;0
WireConnection;278;0;214;0
WireConnection;278;1;284;0
WireConnection;270;0;214;0
WireConnection;270;1;282;0
WireConnection;274;0;214;0
WireConnection;274;1;283;0
WireConnection;269;0;214;0
WireConnection;269;1;261;0
WireConnection;279;0;278;0
WireConnection;471;0;214;0
WireConnection;471;1;481;0
WireConnection;484;0;214;0
WireConnection;484;1;502;0
WireConnection;271;0;270;0
WireConnection;523;0;164;4
WireConnection;275;0;274;0
WireConnection;490;0;214;0
WireConnection;490;1;503;0
WireConnection;496;0;214;0
WireConnection;496;1;504;0
WireConnection;562;0;240;0
WireConnection;212;0;269;0
WireConnection;276;0;275;0
WireConnection;276;1;523;0
WireConnection;554;0;562;0
WireConnection;491;0;490;0
WireConnection;217;0;212;0
WireConnection;217;1;523;0
WireConnection;497;0;496;0
WireConnection;280;0;279;0
WireConnection;280;1;523;0
WireConnection;477;0;445;0
WireConnection;485;0;484;0
WireConnection;472;0;471;0
WireConnection;272;0;271;0
WireConnection;272;1;523;0
WireConnection;309;0;280;0
WireConnection;555;0;554;0
WireConnection;555;1;523;0
WireConnection;468;0;472;0
WireConnection;468;1;523;0
WireConnection;308;0;276;0
WireConnection;486;0;485;0
WireConnection;486;1;523;0
WireConnection;498;0;497;0
WireConnection;498;1;523;0
WireConnection;492;0;491;0
WireConnection;492;1;523;0
WireConnection;307;0;272;0
WireConnection;306;0;217;0
WireConnection;487;0;486;0
WireConnection;487;2;482;0
WireConnection;493;0;492;0
WireConnection;493;2;482;0
WireConnection;476;0;468;0
WireConnection;476;2;482;0
WireConnection;556;0;555;0
WireConnection;556;2;482;0
WireConnection;499;0;498;0
WireConnection;499;2;482;0
WireConnection;314;0;309;0
WireConnection;311;0;306;0
WireConnection;312;0;307;0
WireConnection;313;0;308;0
WireConnection;299;0;311;0
WireConnection;474;0;476;0
WireConnection;488;0;487;0
WireConnection;302;0;314;0
WireConnection;300;0;312;0
WireConnection;557;0;556;0
WireConnection;301;0;313;0
WireConnection;500;0;499;0
WireConnection;494;0;493;0
WireConnection;475;0;474;0
WireConnection;558;0;557;0
WireConnection;489;0;488;0
WireConnection;501;0;500;0
WireConnection;285;0;299;0
WireConnection;285;1;300;0
WireConnection;285;2;301;0
WireConnection;285;3;302;0
WireConnection;447;0;441;0
WireConnection;447;1;446;0
WireConnection;495;0;494;0
WireConnection;287;0;285;0
WireConnection;511;0;501;0
WireConnection;510;0;495;0
WireConnection;508;0;475;0
WireConnection;509;0;489;0
WireConnection;455;0;547;0
WireConnection;563;0;558;0
WireConnection;440;0;447;0
WireConnection;505;0;508;0
WireConnection;505;1;509;0
WireConnection;505;2;510;0
WireConnection;505;3;511;0
WireConnection;442;0;440;0
WireConnection;442;1;450;4
WireConnection;310;0;287;0
WireConnection;559;0;563;0
WireConnection;456;0;455;0
WireConnection;456;1;454;4
WireConnection;793;0;710;0
WireConnection;560;0;505;0
WireConnection;560;1;559;0
WireConnection;188;0;310;0
WireConnection;457;0;456;0
WireConnection;457;2;477;0
WireConnection;443;0;442;0
WireConnection;443;2;477;0
WireConnection;326;0;24;0
WireConnection;326;1;325;0
WireConnection;444;0;443;0
WireConnection;458;0;457;0
WireConnection;564;0;505;0
WireConnection;564;1;560;0
WireConnection;453;0;458;0
WireConnection;453;1;444;0
WireConnection;453;2;512;0
WireConnection;748;0;745;0
WireConnection;748;1;746;0
WireConnection;315;0;326;0
WireConnection;506;0;564;0
WireConnection;749;0;748;0
WireConnection;749;1;747;0
WireConnection;517;0;453;0
WireConnection;751;0;749;0
WireConnection;751;1;750;0
WireConnection;165;0;220;0
WireConnection;629;0;626;0
WireConnection;518;0;507;0
WireConnection;518;1;517;0
WireConnection;539;0;534;0
WireConnection;96;0;165;0
WireConnection;96;1;238;0
WireConnection;519;0;518;0
WireConnection;753;0;751;0
WireConnection;632;1;629;0
WireConnection;632;2;631;0
WireConnection;537;0;533;0
WireConnection;65;0;96;0
WireConnection;754;0;753;0
WireConnection;754;1;752;4
WireConnection;627;0;632;0
WireConnection;627;1;529;0
WireConnection;535;0;537;0
WireConnection;535;1;539;0
WireConnection;572;0;519;0
WireConnection;572;1;573;0
WireConnection;757;0;754;0
WireConnection;224;0;223;0
WireConnection;224;1;65;0
WireConnection;224;2;219;0
WireConnection;773;0;772;0
WireConnection;524;0;572;0
WireConnection;531;0;627;0
WireConnection;531;1;537;0
WireConnection;531;2;535;0
WireConnection;774;0;773;0
WireConnection;761;0;755;0
WireConnection;761;1;748;0
WireConnection;760;0;757;0
WireConnection;760;2;756;0
WireConnection;545;0;531;0
WireConnection;776;0;773;0
WireConnection;574;0;224;0
WireConnection;527;0;524;0
WireConnection;536;0;545;0
WireConnection;579;0;574;2
WireConnection;579;1;577;0
WireConnection;764;0;760;0
WireConnection;764;1;759;0
WireConnection;763;0;761;0
WireConnection;765;0;757;0
WireConnection;765;2;758;0
WireConnection;777;0;775;0
WireConnection;777;1;776;0
WireConnection;778;0;775;0
WireConnection;778;1;774;0
WireConnection;766;0;765;0
WireConnection;766;1;762;0
WireConnection;779;0;777;0
WireConnection;779;1;778;0
WireConnection;767;0;764;0
WireConnection;540;0;536;0
WireConnection;578;0;574;2
WireConnection;578;1;579;0
WireConnection;578;2;576;0
WireConnection;769;0;767;0
WireConnection;782;0;781;0
WireConnection;782;1;780;0
WireConnection;782;2;779;0
WireConnection;575;0;574;1
WireConnection;575;1;578;0
WireConnection;575;2;574;3
WireConnection;768;0;766;0
WireConnection;770;0;768;0
WireConnection;785;1;782;0
WireConnection;394;0;575;0
WireConnection;394;1;393;0
WireConnection;787;0;783;0
WireConnection;787;1;784;0
WireConnection;787;2;779;0
WireConnection;542;0;543;0
WireConnection;542;1;449;0
WireConnection;542;2;544;0
WireConnection;790;1;787;0
WireConnection;448;0;394;0
WireConnection;448;1;542;0
WireConnection;448;2;528;0
WireConnection;788;0;785;1
WireConnection;788;1;786;0
WireConnection;656;0;448;0
WireConnection;666;1;659;0
WireConnection;666;2;662;0
WireConnection;791;0;788;0
WireConnection;791;1;790;1
WireConnection;791;2;789;0
WireConnection;792;0;791;0
WireConnection;658;0;656;2
WireConnection;658;1;666;0
WireConnection;804;0;168;0
WireConnection;804;2;803;0
WireConnection;665;1;661;0
WireConnection;665;2;662;0
WireConnection;657;0;656;1
WireConnection;657;1;658;0
WireConnection;657;2;656;3
WireConnection;805;0;804;0
WireConnection;796;0;795;4
WireConnection;796;1;797;0
WireConnection;660;1;657;0
WireConnection;660;0;665;0
WireConnection;798;0;368;0
WireConnection;798;1;799;0
WireConnection;798;2;797;0
WireConnection;801;0;800;0
WireConnection;806;0;805;0
WireConnection;802;0;798;0
WireConnection;802;1;801;0
WireConnection;794;0;660;0
WireConnection;794;1;795;0
WireConnection;794;2;796;0
WireConnection;813;1;802;0
WireConnection;813;2;814;0
WireConnection;807;1;392;0
WireConnection;807;2;808;0
WireConnection;809;0;810;0
WireConnection;809;1;794;0
WireConnection;809;2;811;0
WireConnection;0;0;807;0
WireConnection;0;1;369;0
WireConnection;0;2;809;0
WireConnection;0;4;813;0
WireConnection;0;5;812;0
ASEEND*/
//CHKSM=7DF82B256B12CB06C6722B6D34BAD7212E9F6DAA