// Made by Nebula Animations: https://nebulaanimations.com/
// This shader and more are avalible for free at: https://ko-fi.com/nebulaanimations/shop
Shader "Nebula Animations/Suresight"
{
	Properties
	{
		[NoScaleOffset][Header(Suresight by Nebula Animations. V1.0)][Space(15)][Header(Main Textures)][Space(10)]_ReticleMask("Reticle Mask", 2D) = "black" {}
		[NoScaleOffset]_ReticleMain("Reticle Main", 2D) = "black" {}
		[NoScaleOffset]_ReticleSecondary("Reticle Secondary", 2D) = "black" {}
		[NoScaleOffset]_ReticleIcon("Reticle Icon", 2D) = "black" {}
		[HDR][Space(10)][Header(Color Settings)][Space(10)]_MainColor("Main Color", Color) = (1024,1024,1024,0)
		[HDR]_MainGradientColor("Main Gradient Color", Color) = (0,0,0,0)
		[ToggleUI]_MainGradientColorToggle("Main Gradient Color Toggle", Float) = 0
		[ToggleUI]_MainHorizontalVerticalGradient("Main Horizontal/Vertical Gradient", Float) = 0
		[HDR][Space(10)]_SecondaryColor("Secondary Color", Color) = (23.96863,23.96863,23.96863,0)
		[HDR]_SecondaryGradientColor("Secondary Gradient Color", Color) = (0,0,0,0)
		[ToggleUI]_SecondaryGradientColorToggle("Secondary Gradient Color Toggle", Float) = 0
		[ToggleUI]_SecondaryHorizontalVerticalGradient("Secondary Horizontal/Vertical Gradient", Float) = 0
		[HDR][Space(10)]_IconColor("Icon Color", Color) = (1024,1024,1024,0)
		[HDR]_IconGradientColor("Icon Gradient Color", Color) = (0,0,0,0)
		[ToggleUI]_IconGradientColorToggle("Icon Gradient Color Toggle", Float) = 0
		[ToggleUI]_IconHorizontalVerticalGradient("Icon Horizontal/Vertical Gradient", Float) = 0
		[Space(10)][Header(Overrides)][Space(10)]_OverallIntensityBoost("Overall Intensity Boost", Range( 1 , 10)) = 1
		_MainIntensityBoost("Main Intensity Boost", Float) = 1
		_SecondaryIntensityBoost("Secondary Intensity Boost", Float) = 1
		_IconIntensityBoost("Icon Intensity Boost", Float) = 1
		_GlowNoiseScale("Glow Noise Scale", Float) = 5
		_Opacity("Opacity", Range( 0 , 1)) = 0.008
		_SecondaryReticleCount("Secondary Reticle Count", Range( 0 , 10)) = 10
		_IconScale("Icon Scale", Range( 0 , 1)) = 0.65
		_IconScaleFlat("Icon Scale Flat", Float) = 1.5
		[Space(10)][Header(Animation Settings)][Space(10)]_PrimaryRotationSpeed("Primary Rotation Speed", Float) = 0
		_SecondaryRotationSpeed("Secondary Rotation Speed", Float) = 0
		[ToggleUI]_ScanlineToggle("Scanline Toggle", Float) = 0
		[Space(10)][Header(Advanced Settings)][Space(10)]_TransitionDistance("Transition Distance", Float) = 1.5
		_ReticleIconVerticalOffset("Reticle Icon Vertical Offset", Float) = 0
		_ReticleIconHorizontalOffset("Reticle Icon Horizontal Offset", Float) = 0
		_Falloff("Falloff", Float) = 1
		_FadeDistance("Fade Distance", Float) = 2
		_ExponentalRotationSpeed("Exponental Rotation Speed", Range( 1 , 2)) = 1
		_DepthFade("Depth Fade", Range( 0 , 1)) = 0
		_SecondaryReticleDepth("Secondary Reticle Depth", Float) = 0.7
		[ToggleUI]_PrimarySecondaryReticle("Primary/Secondary Reticle", Float) = 0
		[ToggleUI]_VisualObjectCenter("Visual/Object Center", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

		#pragma surface surf StandardCustomLighting alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
			float2 vertexToFrag7_g2;
			float2 vertexToFrag7_g3;
			half ASEIsFrontFacing : VFACE;
			float4 screenPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _PrimarySecondaryReticle;
		uniform float _SecondaryReticleCount;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ReticleSecondary);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ReticleMain);
		uniform float4 _ReticleMain_ST;
		uniform float _TransitionDistance;
		uniform float _Falloff;
		uniform float _SecondaryReticleDepth;
		uniform float _SecondaryRotationSpeed;
		uniform float _ExponentalRotationSpeed;
		SamplerState sampler_ReticleSecondary;
		uniform float _SecondaryIntensityBoost;
		uniform float _SecondaryGradientColorToggle;
		uniform float4 _SecondaryColor;
		uniform float _SecondaryHorizontalVerticalGradient;
		uniform float4 _SecondaryGradientColor;
		uniform float _MainGradientColorToggle;
		uniform float4 _MainColor;
		uniform float _MainHorizontalVerticalGradient;
		uniform float4 _MainGradientColor;
		uniform float _PrimaryRotationSpeed;
		SamplerState sampler_Point_Clamp;
		uniform float _MainIntensityBoost;
		uniform float _IconGradientColorToggle;
		uniform float4 _IconColor;
		uniform float _IconHorizontalVerticalGradient;
		uniform float4 _IconGradientColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ReticleIcon);
		uniform float _VisualObjectCenter;
		uniform float _IconScale;
		uniform float _ReticleIconVerticalOffset;
		uniform float _ReticleIconHorizontalOffset;
		uniform float _IconScaleFlat;
		SamplerState sampler_ReticleIcon;
		uniform float _IconIntensityBoost;
		uniform float _GlowNoiseScale;
		uniform float _ScanlineToggle;
		uniform float _OverallIntensityBoost;
		uniform float _Opacity;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ReticleMask);
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthFade;
		uniform float _FadeDistance;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		float2 voronoihash324( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi324( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash324( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 //		if( d<F1 ) {
			 //			F2 = F1;
			 			float h = smoothstep(0.0, 1.0, 0.5 + 0.5 * (F1 - d) / smoothness); F1 = lerp(F1, d, h) - smoothness * h * (1.0 - h);mg = g; mr = r; id = o;
			 //		} else if( d<F2 ) {
			 //			F2 = d;
			
			 //		}
			 	}
			}
			return F1;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 ase_worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
			half tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
			float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * tangentSign;
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 ase_tanViewDir = mul( ase_worldToTangent, ase_worldViewDir );
			float3 break271 = ase_tanViewDir;
			float2 appendResult272 = (float2(break271.x , break271.y));
			float cos1_g2 = cos( radians( 0.0 ) );
			float sin1_g2 = sin( radians( 0.0 ) );
			float2 rotator1_g2 = mul( saturate( ( 1.0 - ( appendResult272 + 0.5 ) ) ) - float2( 0.5,0.5 ) , float2x2( cos1_g2 , -sin1_g2 , sin1_g2 , cos1_g2 )) + float2( 0.5,0.5 );
			float temp_output_379_0 = ( 1.0 - ( distance( ase_worldPos , _WorldSpaceCameraPos ) / 2.0 ) );
			float2 temp_cast_0 = ((30.0 + (( _IconScale * temp_output_379_0 ) - 0.0) * (0.0 - 30.0) / (1.0 - 0.0))).xx;
			float2 temp_output_10_0_g2 = ( temp_cast_0 / 1.0 );
			float2 panner19_g2 = ( _Time.y * float2( 0,0 ) + float2( 0,0 ));
			float2 appendResult390 = (float2(_ReticleIconVerticalOffset , _ReticleIconHorizontalOffset));
			float2 _Vector2 = float2(0.5,0.5);
			o.vertexToFrag7_g2 = ( ( ( ( rotator1_g2 * temp_output_10_0_g2 ) + panner19_g2 ) + appendResult390 ) - ( ( temp_output_10_0_g2 * _Vector2 ) - _Vector2 ) );
			float2 uv_ReticleMain = v.texcoord.xy * _ReticleMain_ST.xy + _ReticleMain_ST.zw;
			float clampResult37 = clamp( pow( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _TransitionDistance ) , _Falloff ) , 0.0 , 1.0 );
			float temp_output_41_0 = ( ( 1.0 - saturate( clampResult37 ) ) * _SecondaryReticleDepth );
			float Parallax42 = temp_output_41_0;
			float3 ViewDir47 = ase_tanViewDir;
			float2 Offset50 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + uv_ReticleMain;
			float2 Offset57 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset50;
			float2 Offset65 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset57;
			float2 Offset69 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset65;
			float2 Offset73 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset69;
			float2 Offset77 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset73;
			float2 Offset81 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset77;
			float2 Offset175 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset81;
			float2 Offset180 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset175;
			float2 Offset185 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset180;
			float2 Offset251 = ( ( -5.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset185;
			float2 ReticleDot258 = Offset251;
			float cos1_g3 = cos( radians( 0.0 ) );
			float sin1_g3 = sin( radians( 0.0 ) );
			float2 rotator1_g3 = mul( ReticleDot258 - float2( 0.5,0.5 ) , float2x2( cos1_g3 , -sin1_g3 , sin1_g3 , cos1_g3 )) + float2( 0.5,0.5 );
			float2 temp_cast_1 = (_IconScaleFlat).xx;
			float2 temp_output_10_0_g3 = ( temp_cast_1 / 1.0 );
			float2 panner19_g3 = ( _Time.y * float2( 0,0 ) + float2( 0,0 ));
			o.vertexToFrag7_g3 = ( ( ( ( rotator1_g3 * temp_output_10_0_g3 ) + panner19_g3 ) + float2( 0,0 ) ) - ( ( temp_output_10_0_g3 * _Vector2 ) - _Vector2 ) );
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float mulTime208 = _Time.y * _PrimaryRotationSpeed;
			float cos96 = cos( mulTime208 );
			float sin96 = sin( mulTime208 );
			float2 rotator96 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos96 , -sin96 , sin96 , cos96 )) + float2( 0.5,0.5 );
			float grayscale9 = dot(SAMPLE_TEXTURE2D( _ReticleMask, sampler_Point_Clamp, rotator96 ).rgb, float3(0.299,0.587,0.114));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float eyeDepth1_g4 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float smoothstepResult4_g4 = smoothstep( 0.0 , 1.0 , ( ( eyeDepth1_g4 - ase_screenPos.w ) / _DepthFade ));
			float3 ase_worldPos = i.worldPos;
			float saferPower351 = abs( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _FadeDistance ) );
			float clampResult352 = clamp( pow( saferPower351 , 1.0 ) , 0.0 , 1.0 );
			float FadeDistance354 = clampResult352;
			float SecondaryRedicleCount192 = _SecondaryReticleCount;
			float2 uv_ReticleMain = i.uv_texcoord * _ReticleMain_ST.xy + _ReticleMain_ST.zw;
			float clampResult37 = clamp( pow( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _TransitionDistance ) , _Falloff ) , 0.0 , 1.0 );
			float temp_output_41_0 = ( ( 1.0 - saturate( clampResult37 ) ) * _SecondaryReticleDepth );
			float Parallax42 = temp_output_41_0;
			float3 ViewDir47 = i.viewDir;
			float2 Offset50 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + uv_ReticleMain;
			float mulTime106 = _Time.y * _SecondaryRotationSpeed;
			float SecondaryRotationSpeed210 = mulTime106;
			float ExponentialRotationSpeed222 = _ExponentalRotationSpeed;
			float temp_output_225_0 = ( SecondaryRotationSpeed210 * ExponentialRotationSpeed222 );
			float cos98 = cos( temp_output_225_0 );
			float sin98 = sin( temp_output_225_0 );
			float2 rotator98 = mul( Offset50 - float2( 0.5,0.5 ) , float2x2( cos98 , -sin98 , sin98 , cos98 )) + float2( 0.5,0.5 );
			float2 Offset57 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset50;
			float temp_output_226_0 = ( temp_output_225_0 * ExponentialRotationSpeed222 );
			float cos99 = cos( temp_output_226_0 );
			float sin99 = sin( temp_output_226_0 );
			float2 rotator99 = mul( Offset57 - float2( 0.5,0.5 ) , float2x2( cos99 , -sin99 , sin99 , cos99 )) + float2( 0.5,0.5 );
			float2 Offset65 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset57;
			float temp_output_227_0 = ( ExponentialRotationSpeed222 * temp_output_226_0 );
			float cos100 = cos( temp_output_227_0 );
			float sin100 = sin( temp_output_227_0 );
			float2 rotator100 = mul( Offset65 - float2( 0.5,0.5 ) , float2x2( cos100 , -sin100 , sin100 , cos100 )) + float2( 0.5,0.5 );
			float2 Offset69 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset65;
			float temp_output_228_0 = ( ExponentialRotationSpeed222 * temp_output_227_0 );
			float cos101 = cos( temp_output_228_0 );
			float sin101 = sin( temp_output_228_0 );
			float2 rotator101 = mul( Offset69 - float2( 0.5,0.5 ) , float2x2( cos101 , -sin101 , sin101 , cos101 )) + float2( 0.5,0.5 );
			float2 Offset73 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset69;
			float temp_output_229_0 = ( ExponentialRotationSpeed222 * temp_output_228_0 );
			float cos102 = cos( temp_output_229_0 );
			float sin102 = sin( temp_output_229_0 );
			float2 rotator102 = mul( Offset73 - float2( 0.5,0.5 ) , float2x2( cos102 , -sin102 , sin102 , cos102 )) + float2( 0.5,0.5 );
			float2 Offset77 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset73;
			float temp_output_237_0 = ( ExponentialRotationSpeed222 * temp_output_229_0 );
			float cos103 = cos( temp_output_237_0 );
			float sin103 = sin( temp_output_237_0 );
			float2 rotator103 = mul( Offset77 - float2( 0.5,0.5 ) , float2x2( cos103 , -sin103 , sin103 , cos103 )) + float2( 0.5,0.5 );
			float2 Offset81 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset77;
			float temp_output_239_0 = ( ExponentialRotationSpeed222 * temp_output_237_0 );
			float cos104 = cos( temp_output_239_0 );
			float sin104 = sin( temp_output_239_0 );
			float2 rotator104 = mul( Offset81 - float2( 0.5,0.5 ) , float2x2( cos104 , -sin104 , sin104 , cos104 )) + float2( 0.5,0.5 );
			float2 Offset175 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset81;
			float temp_output_241_0 = ( ExponentialRotationSpeed222 * temp_output_239_0 );
			float cos176 = cos( temp_output_241_0 );
			float sin176 = sin( temp_output_241_0 );
			float2 rotator176 = mul( Offset175 - float2( 0.5,0.5 ) , float2x2( cos176 , -sin176 , sin176 , cos176 )) + float2( 0.5,0.5 );
			float2 Offset180 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset175;
			float temp_output_243_0 = ( ExponentialRotationSpeed222 * temp_output_241_0 );
			float cos181 = cos( temp_output_243_0 );
			float sin181 = sin( temp_output_243_0 );
			float2 rotator181 = mul( Offset180 - float2( 0.5,0.5 ) , float2x2( cos181 , -sin181 , sin181 , cos181 )) + float2( 0.5,0.5 );
			float2 Offset185 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset180;
			float cos186 = cos( ( ExponentialRotationSpeed222 * temp_output_243_0 ) );
			float sin186 = sin( ( ExponentialRotationSpeed222 * temp_output_243_0 ) );
			float2 rotator186 = mul( Offset185 - float2( 0.5,0.5 ) , float2x2( cos186 , -sin186 , sin186 , cos186 )) + float2( 0.5,0.5 );
			float4 Parallax_Out53 = ( saturate( ( ( SecondaryRedicleCount192 >= 1.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator98 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 2.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator99 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 3.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator100 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 4.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator101 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 5.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator102 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 6.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator103 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 7.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator104 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 8.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator176 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 9.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator181 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 10.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator186 ) : float4( 0,0,0,0 ) ) ) ) * _SecondaryIntensityBoost );
			float4 SecondaryColor392 = (( _SecondaryGradientColorToggle )?( ( ( _SecondaryColor * (( _SecondaryHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _SecondaryGradientColor * ( 1.0 - (( _SecondaryHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _SecondaryColor ));
			float4 MainColor391 = (( _MainGradientColorToggle )?( ( ( _MainColor * (( _MainHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _MainGradientColor * ( 1.0 - (( _MainHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _MainColor ));
			float4 temp_output_394_0 = ( MainColor391 * ( SAMPLE_TEXTURE2D( _ReticleMain, sampler_Point_Clamp, rotator96 ) * _MainIntensityBoost ) );
			float4 IconColor393 = (( _IconGradientColorToggle )?( ( ( _IconColor * (( _IconHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _IconGradientColor * ( 1.0 - (( _IconHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _IconColor ));
			float2 temp_output_315_8 = i.vertexToFrag7_g3;
			float Distance38 = clampResult37;
			float4 temp_cast_7 = (Distance38).xxxx;
			float4 temp_cast_8 = (1.0).xxxx;
			float2 lerpResult311 = lerp( (( _VisualObjectCenter )?( temp_output_315_8 ):( saturate( i.vertexToFrag7_g2 ) )) , temp_output_315_8 , saturate( ( CalculateContrast(5.0,temp_cast_7) - temp_cast_8 ) ).rg);
			float4 temp_output_30_0 = ( temp_output_394_0 * 0.05 );
			float4 switchResult422 = (((i.ASEIsFrontFacing>0)?(( ( ( Parallax_Out53 * 0.01 ) * SecondaryColor392 ) + temp_output_394_0 + ( IconColor393 * ( SAMPLE_TEXTURE2D( _ReticleIcon, sampler_ReticleIcon, lerpResult311 ) * _IconIntensityBoost ) ) )):(temp_output_30_0)));
			float time324 = _Time.y;
			float2 voronoiSmoothId324 = 0;
			float voronoiSmooth324 = 0.29;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 coords324 = ase_worldViewDir.xy * _GlowNoiseScale;
			float2 id324 = 0;
			float2 uv324 = 0;
			float fade324 = 0.5;
			float voroi324 = 0;
			float rest324 = 0;
			for( int it324 = 0; it324 <3; it324++ ){
			voroi324 += fade324 * voronoi324( coords324, time324, id324, uv324, voronoiSmooth324,voronoiSmoothId324 );
			rest324 += fade324;
			coords324 *= 2;
			fade324 *= 0.5;
			}//Voronoi324
			voroi324 /= rest324;
			float mulTime357 = _Time.y * 10.0;
			float2 panner359 = ( mulTime357 * float2( 0,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord358 = i.uv_texcoord * float2( 1,100 ) + panner359;
			float4 temp_output_29_0 = ( ( (( _PrimarySecondaryReticle )?( temp_output_30_0 ):( switchResult422 )) + ( (( _PrimarySecondaryReticle )?( temp_output_30_0 ):( switchResult422 )) * saturate( voroi324 ) * 10.0 * (( _ScanlineToggle )?( saturate( sin( uv_TexCoord358.y ) ) ):( 1.0 )) ) ) * _OverallIntensityBoost );
			c.rgb = temp_output_29_0.rgb;
			c.a = ( ( ( _Opacity * grayscale9 ) * smoothstepResult4_g4 ) * saturate( ( 1.0 - FadeDistance354 ) ) );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float SecondaryRedicleCount192 = _SecondaryReticleCount;
			float2 uv_ReticleMain = i.uv_texcoord * _ReticleMain_ST.xy + _ReticleMain_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float clampResult37 = clamp( pow( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _TransitionDistance ) , _Falloff ) , 0.0 , 1.0 );
			float temp_output_41_0 = ( ( 1.0 - saturate( clampResult37 ) ) * _SecondaryReticleDepth );
			float Parallax42 = temp_output_41_0;
			float3 ViewDir47 = i.viewDir;
			float2 Offset50 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + uv_ReticleMain;
			float mulTime106 = _Time.y * _SecondaryRotationSpeed;
			float SecondaryRotationSpeed210 = mulTime106;
			float ExponentialRotationSpeed222 = _ExponentalRotationSpeed;
			float temp_output_225_0 = ( SecondaryRotationSpeed210 * ExponentialRotationSpeed222 );
			float cos98 = cos( temp_output_225_0 );
			float sin98 = sin( temp_output_225_0 );
			float2 rotator98 = mul( Offset50 - float2( 0.5,0.5 ) , float2x2( cos98 , -sin98 , sin98 , cos98 )) + float2( 0.5,0.5 );
			float2 Offset57 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset50;
			float temp_output_226_0 = ( temp_output_225_0 * ExponentialRotationSpeed222 );
			float cos99 = cos( temp_output_226_0 );
			float sin99 = sin( temp_output_226_0 );
			float2 rotator99 = mul( Offset57 - float2( 0.5,0.5 ) , float2x2( cos99 , -sin99 , sin99 , cos99 )) + float2( 0.5,0.5 );
			float2 Offset65 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset57;
			float temp_output_227_0 = ( ExponentialRotationSpeed222 * temp_output_226_0 );
			float cos100 = cos( temp_output_227_0 );
			float sin100 = sin( temp_output_227_0 );
			float2 rotator100 = mul( Offset65 - float2( 0.5,0.5 ) , float2x2( cos100 , -sin100 , sin100 , cos100 )) + float2( 0.5,0.5 );
			float2 Offset69 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset65;
			float temp_output_228_0 = ( ExponentialRotationSpeed222 * temp_output_227_0 );
			float cos101 = cos( temp_output_228_0 );
			float sin101 = sin( temp_output_228_0 );
			float2 rotator101 = mul( Offset69 - float2( 0.5,0.5 ) , float2x2( cos101 , -sin101 , sin101 , cos101 )) + float2( 0.5,0.5 );
			float2 Offset73 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset69;
			float temp_output_229_0 = ( ExponentialRotationSpeed222 * temp_output_228_0 );
			float cos102 = cos( temp_output_229_0 );
			float sin102 = sin( temp_output_229_0 );
			float2 rotator102 = mul( Offset73 - float2( 0.5,0.5 ) , float2x2( cos102 , -sin102 , sin102 , cos102 )) + float2( 0.5,0.5 );
			float2 Offset77 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset73;
			float temp_output_237_0 = ( ExponentialRotationSpeed222 * temp_output_229_0 );
			float cos103 = cos( temp_output_237_0 );
			float sin103 = sin( temp_output_237_0 );
			float2 rotator103 = mul( Offset77 - float2( 0.5,0.5 ) , float2x2( cos103 , -sin103 , sin103 , cos103 )) + float2( 0.5,0.5 );
			float2 Offset81 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset77;
			float temp_output_239_0 = ( ExponentialRotationSpeed222 * temp_output_237_0 );
			float cos104 = cos( temp_output_239_0 );
			float sin104 = sin( temp_output_239_0 );
			float2 rotator104 = mul( Offset81 - float2( 0.5,0.5 ) , float2x2( cos104 , -sin104 , sin104 , cos104 )) + float2( 0.5,0.5 );
			float2 Offset175 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset81;
			float temp_output_241_0 = ( ExponentialRotationSpeed222 * temp_output_239_0 );
			float cos176 = cos( temp_output_241_0 );
			float sin176 = sin( temp_output_241_0 );
			float2 rotator176 = mul( Offset175 - float2( 0.5,0.5 ) , float2x2( cos176 , -sin176 , sin176 , cos176 )) + float2( 0.5,0.5 );
			float2 Offset180 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset175;
			float temp_output_243_0 = ( ExponentialRotationSpeed222 * temp_output_241_0 );
			float cos181 = cos( temp_output_243_0 );
			float sin181 = sin( temp_output_243_0 );
			float2 rotator181 = mul( Offset180 - float2( 0.5,0.5 ) , float2x2( cos181 , -sin181 , sin181 , cos181 )) + float2( 0.5,0.5 );
			float2 Offset185 = ( ( 0.0 - 1 ) * ( ViewDir47.xy / ViewDir47.z ) * Parallax42 ) + Offset180;
			float cos186 = cos( ( ExponentialRotationSpeed222 * temp_output_243_0 ) );
			float sin186 = sin( ( ExponentialRotationSpeed222 * temp_output_243_0 ) );
			float2 rotator186 = mul( Offset185 - float2( 0.5,0.5 ) , float2x2( cos186 , -sin186 , sin186 , cos186 )) + float2( 0.5,0.5 );
			float4 Parallax_Out53 = ( saturate( ( ( SecondaryRedicleCount192 >= 1.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator98 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 2.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator99 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 3.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator100 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 4.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator101 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 5.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator102 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 6.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator103 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 7.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator104 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 8.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator176 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 9.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator181 ) : float4( 0,0,0,0 ) ) + ( SecondaryRedicleCount192 >= 10.0 ? SAMPLE_TEXTURE2D( _ReticleSecondary, sampler_ReticleSecondary, rotator186 ) : float4( 0,0,0,0 ) ) ) ) * _SecondaryIntensityBoost );
			float4 SecondaryColor392 = (( _SecondaryGradientColorToggle )?( ( ( _SecondaryColor * (( _SecondaryHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _SecondaryGradientColor * ( 1.0 - (( _SecondaryHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _SecondaryColor ));
			float4 MainColor391 = (( _MainGradientColorToggle )?( ( ( _MainColor * (( _MainHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _MainGradientColor * ( 1.0 - (( _MainHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _MainColor ));
			float mulTime208 = _Time.y * _PrimaryRotationSpeed;
			float cos96 = cos( mulTime208 );
			float sin96 = sin( mulTime208 );
			float2 rotator96 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos96 , -sin96 , sin96 , cos96 )) + float2( 0.5,0.5 );
			float4 temp_output_394_0 = ( MainColor391 * ( SAMPLE_TEXTURE2D( _ReticleMain, sampler_Point_Clamp, rotator96 ) * _MainIntensityBoost ) );
			float4 IconColor393 = (( _IconGradientColorToggle )?( ( ( _IconColor * (( _IconHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) + ( _IconGradientColor * ( 1.0 - (( _IconHorizontalVerticalGradient )?( i.uv_texcoord.y ):( i.uv_texcoord.x )) ) ) ) ):( _IconColor ));
			float2 temp_output_315_8 = i.vertexToFrag7_g3;
			float Distance38 = clampResult37;
			float4 temp_cast_0 = (Distance38).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float2 lerpResult311 = lerp( (( _VisualObjectCenter )?( temp_output_315_8 ):( saturate( i.vertexToFrag7_g2 ) )) , temp_output_315_8 , saturate( ( CalculateContrast(5.0,temp_cast_0) - temp_cast_1 ) ).rg);
			float4 temp_output_30_0 = ( temp_output_394_0 * 0.05 );
			float4 switchResult422 = (((i.ASEIsFrontFacing>0)?(( ( ( Parallax_Out53 * 0.01 ) * SecondaryColor392 ) + temp_output_394_0 + ( IconColor393 * ( SAMPLE_TEXTURE2D( _ReticleIcon, sampler_ReticleIcon, lerpResult311 ) * _IconIntensityBoost ) ) )):(temp_output_30_0)));
			float time324 = _Time.y;
			float2 voronoiSmoothId324 = 0;
			float voronoiSmooth324 = 0.29;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 coords324 = ase_worldViewDir.xy * _GlowNoiseScale;
			float2 id324 = 0;
			float2 uv324 = 0;
			float fade324 = 0.5;
			float voroi324 = 0;
			float rest324 = 0;
			for( int it324 = 0; it324 <3; it324++ ){
			voroi324 += fade324 * voronoi324( coords324, time324, id324, uv324, voronoiSmooth324,voronoiSmoothId324 );
			rest324 += fade324;
			coords324 *= 2;
			fade324 *= 0.5;
			}//Voronoi324
			voroi324 /= rest324;
			float mulTime357 = _Time.y * 10.0;
			float2 panner359 = ( mulTime357 * float2( 0,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord358 = i.uv_texcoord * float2( 1,100 ) + panner359;
			float4 temp_output_29_0 = ( ( (( _PrimarySecondaryReticle )?( temp_output_30_0 ):( switchResult422 )) + ( (( _PrimarySecondaryReticle )?( temp_output_30_0 ):( switchResult422 )) * saturate( voroi324 ) * 10.0 * (( _ScanlineToggle )?( saturate( sin( uv_TexCoord358.y ) ) ):( 1.0 )) ) ) * _OverallIntensityBoost );
			o.Albedo = temp_output_29_0.rgb;
			o.Emission = temp_output_29_0.rgb;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}