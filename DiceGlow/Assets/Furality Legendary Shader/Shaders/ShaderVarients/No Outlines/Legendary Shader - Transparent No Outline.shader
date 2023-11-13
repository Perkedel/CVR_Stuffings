// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Furality/Legendary Shader/No Outline/Legendary Shader - No Outline Transparent"
{
	Properties
	{
		[Header(Main Settings)]_MainTex("   MainTex", 2D) = "white" {}
		_Color("   Color", Color) = (1,1,1,1)
		[Normal]_Normal("   Normal", 2D) = "bump" {}
		_NormalScale("   Normal Scale", Float) = 1
		_Metallic("   Metallic", 2D) = "black" {}
		_MetallicVal("   Metallic", Range( 0 , 1)) = 0
		_Smoothness("   Smoothness", Range( 0 , 1)) = 0.5
		_Occlusion("   Occlusion", 2D) = "white" {}
		_OcclusionPower("   Occlusion Power", Range( 0 , 1)) = 1
		_EmissionMask("   Emission Mask", 2D) = "white" {}
		_Emission("   Emission", 2D) = "white" {}
		[HDR]_EmissionColor("   Emission Color", Color) = (0,0,0,1)
		_ShadowOffset("   Offset", Range( -1 , 1)) = 0
		_ShadowLength("   Length", Range( 0 , 16)) = 2
		[HDR]_SpecularTint("   Specular Tint", Color) = (1,1,1,1)
		_SpecularOffset("   Offset", Range( -1 , 1)) = 0
		_SpecularLength("   Length", Range( 0 , 16)) = 0
		[HDR]_RimlightTint("   Rimlight Tint", Color) = (1,1,1,1)
		_RimlightLength("   Length", Range( 0 , 16)) = 2
		_RimlightOffset("   Offset", Range( -1 , 5)) = 1
		_RimlightRotationAngle("   Rotation Angle", Float) = 0
		_RimlightRotationAxis("   Rotation Axis", Vector) = (0,1,0,0)
		_BlendOffset("   Blend Offset", Float) = 0.25
		_BlendLength("   Blend Length", Float) = 5
		_HaltoneScale("   Halftone Scale", Float) = 100
		_HaltoneRotation("   Halftone Rotation", Float) = 45
		_SpecularHaltoneScale("   Halftone Scale", Float) = 100
		_SpecularHaltoneRotation("   Halftone Rotation", Float) = 45
		_RimlightHaltoneScale("   Halftone Scale", Float) = 100
		_RimlightHaltoneRotation("   Halftone Rotation", Float) = 45
		_OutlineColor("   Outline Color", Color) = (0,0,0,1)
		_OutlineWidth("   Outline Width", Float) = 0
		[Header(Luma Glow 2)]_GlowMaskRGB("   Glow Mask", 2D) = "black" {}
		[ToggleUI]_EnableEmissionGlow("   Enable Emission Glow", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Heros 1,3,Heros 2,4,Villains 1,5,Villains 2,6)]_EmissionZone("   Emission Zone", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_EmissionReactivity("   Emission Reactivity", Int) = 0
		[ToggleUI]_EnableGlowMaskR("   Enable Glow Mask (R)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Heros 1,3,Heros 2,4,Villains 1,5,Villains 2,6)]_GlowMaskZoneR("   Glow Mask Zone (R)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityR("   Reacitvity (R)", Int) = 0
		[HDR]_GlowMaskTintR("   Glow Mask Tint (R)", Color) = (0,0,0,1)
		[ToggleUI]_EnableGlowMaskG("   Enable Glow Mask (G)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Heros 1,3,Heros 2,4,Villains 1,5,Villains 2,6)]_GlowMaskZoneG("   Glow Mask Zone (G)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityG("   Reacitvity (G)", Int) = 0
		[HDR]_GlowMaskTintG("   Glow Mask Tint (G)", Color) = (0,0,0,1)
		[ToggleUI]_EnableGlowMaskB("   Enable Glow Mask (B)", Float) = 0
		[Enum(Gradient 1,0,Gradient 2,1,Gradient 3,2,Heros 1,3,Heros 2,4,Villains 1,5,Villains 2,6)]_GlowMaskZoneB("   Glow Mask Zone (B)", Int) = 0
		[Enum(Off,0,Lows Blink,1,Lows Pulse,2,Highs Blink,3,Highs Pulse,4)]_ReacitvityB("   Reacitvity (B)", Int) = 0
		[HDR]_GlowMaskTintB("   Glow Mask Tint (B)", Color) = (0,0,0,1)
		_LowsPulseDirection("   Lows Pulse Direction", Float) = 180
		_HighsPulseDirection("   Highs Pulse Direction", Float) = 180
		_GradientDirection("   Gradient Direction", Float) = 0
		[ToggleUI]_DebugMode("   Debug Mode", Float) = 0
		_BlendModeIndex("BlendModeIndex", Float) = 0
		_OutlineMaskClip("   Outline Mask Clip", Float) = 0.5
		_OutlineDepthFade("   Outline Depth Fade", Float) = 0.075
		_SpecularStyleIndex("SpecularStyleIndex", Float) = 0
		_RimlightStyleIndex("RimlightStyleIndex", Float) = 0
		_ShadowStyleIndex("ShadowStyleIndex", Float) = 0
		[Enum(Metallic,0,Specular,1)]_Workflow("Workflow", Float) = 0
		_MaskClip("Mask Clip Value", Float) = 0.5
		[ToggleUI]_EmissionPan("Enable Emission Panning", Float) = 0
		_EmissionPanSpeed("Emission Pan Speed", Vector) = (1,1,0,0)
		[ToggleUI]_AdvToggle("Toggle Advanced Settings", Float) = 0
		[Enum(Main Settings,3,Lighting Settings,0,Luma Glow Settings,2)]_SettingsMode("   Mode", Float) = 3
		[Enum(Back,2,Front,1,Off,0)]_Culling("   Culling", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZWrite On
		}

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Culling]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
			float3 worldPos;
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

		uniform float _OutlineWidth;
		uniform float _BlendModeIndex;
		uniform float _OutlineDepthFade;
		uniform float _Culling;
		uniform float _SettingsMode;
		uniform float _MaskClip;
		uniform float4 _OutlineColor;
		uniform float _AdvToggle;
		uniform float _OutlineMaskClip;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform sampler2D _Metallic;
		uniform float _MetallicVal;
		float4 _Metallic_TexelSize;
		uniform float _Workflow;
		uniform sampler2D _Stored;
		uniform float _GradientDirection;
		uniform int _EmissionZone;
		uniform float _EnableEmissionGlow;
		float4 _Stored_TexelSize;
		uniform float _DebugMode;
		uniform sampler2D _Emission;
		uniform float _EmissionPan;
		uniform float2 _EmissionPanSpeed;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMask;
		uniform float4 _EmissionMask_ST;
		uniform int _EmissionReactivity;
		uniform float _LowsPulseDirection;
		uniform float _HighsPulseDirection;
		uniform int _GlowMaskZoneR;
		uniform float _EnableGlowMaskR;
		uniform float4 _GlowMaskTintR;
		uniform sampler2D _GlowMaskRGB;
		uniform float4 _GlowMaskRGB_ST;
		uniform int _ReacitvityR;
		uniform int _GlowMaskZoneG;
		uniform float _EnableGlowMaskG;
		uniform float4 _GlowMaskTintG;
		uniform int _ReacitvityG;
		uniform int _GlowMaskZoneB;
		uniform float _EnableGlowMaskB;
		uniform float4 _GlowMaskTintB;
		uniform int _ReacitvityB;
		uniform float _ShadowLength;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _NormalScale;
		uniform float _ShadowOffset;
		uniform float _HaltoneScale;
		uniform float _HaltoneRotation;
		uniform float _ShadowStyleIndex;
		uniform float _BlendOffset;
		uniform float _BlendLength;
		uniform sampler2D _Occlusion;
		uniform float _OcclusionPower;
		uniform float _Smoothness;
		uniform float _SpecularHaltoneScale;
		uniform float _SpecularHaltoneRotation;
		uniform float _SpecularLength;
		uniform float _SpecularOffset;
		uniform float _SpecularStyleIndex;
		uniform float4 _SpecularTint;
		uniform float _RimlightLength;
		uniform float3 _RimlightRotationAxis;
		uniform float _RimlightRotationAngle;
		uniform float _RimlightOffset;
		uniform float _RimlightHaltoneScale;
		uniform float _RimlightHaltoneRotation;
		uniform float _RimlightStyleIndex;
		uniform float4 _RimlightTint;


		float RoughnessCalc( float nh, float roughness )
		{
			return GGXTerm(nh, roughness);
		}


		float Hexagon( float2 p, float r )
		{
			    const float3 k = float3(-0.866025404,0.5,0.577350269);
			    p += -0.5;
			    p = abs(p);
			    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy;
			    p -= float2(clamp(p.x, -k.z*r, k.z*r), r);
			    return length(p)*sign(p.y);
		}


		float RegularStar( float2 p, float r, int n, float m )
		{
			    // next 4 lines can be precomputed for a given shape
			p += -0.5;
			p = abs(p);
			    float an = 3.141593/float(n);
			    float en = 3.141593/m;  // m is between 2 and n
			    float2  acs = float2(cos(an),sin(an));
			    float2  ecs = float2(cos(en),sin(en)); // ecs=float2(0,1) for regular polygon
			    float bn = fmod(atan2(p.x,p.y),2.0*an) - an;
			    p = length(p)*float2(cos(bn),abs(sin(bn)));
			    p -= r*acs;
			    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y);
			    return length(p)*sign(p.x);
		}


		float3 CustomReflectionProbeSample2048( float3 uvw )
		{
			half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5); //('cubemap', 'sample coordinate', 'map-map level')
			         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
			         return half4(skyColor, 1.0);
		}


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Albedo33 = ( tex2D( _MainTex, uv_MainTex ) * _Color );
			float AlbedoAlpha1495 = Albedo33.a;
			float4 tex2DNode1399 = tex2D( _Metallic, uv_MainTex );
			float isMetallicMissing1405 = step( max( _Metallic_TexelSize.z , _Metallic_TexelSize.w ) , 1.0 );
			float lerpResult1473 = lerp( ( tex2DNode1399.r * _MetallicVal ) , _MetallicVal , isMetallicMissing1405);
			float Workflow1671 = _Workflow;
			float lerpResult1689 = lerp( lerpResult1473 , 0.0 , Workflow1671);
			float Metallic1113 = lerpResult1689;
			half3 specColor1307 = (0).xxx;
			half oneMinusReflectivity1307 = 0;
			half3 diffuseAndSpecularFromMetallic1307 = DiffuseAndSpecularFromMetallic(Albedo33.rgb,Metallic1113,specColor1307,oneMinusReflectivity1307);
			float3 MetAlbedo1310 = diffuseAndSpecularFromMetallic1307;
			float saferPower2_g265 = max( ( 1.0 / 2.71828 ) , 0.0001 );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode4 = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			float3 appendResult936 = (float3(tex2DNode4.xy , ( tex2DNode4.b * i.ASEVFace )));
			float3 Normal7 = appendResult936;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			#ifdef UNITY_PASS_FORWARDBASE
				float staticSwitch1700 = step( ase_lightColor.a , 0.01 );
			#else
				float staticSwitch1700 = 0.0;
			#endif
			float isLightMissing1721 = staticSwitch1700;
			float3 normalizeResult1740 = normalize( float3(0.6,1,-0.3) );
			float3 LightDir1710 = ( ( ase_worldlightDir * ( 1.0 - staticSwitch1700 ) ) + ( isLightMissing1721 * normalizeResult1740 ) );
			float dotResult10 = dot( (WorldNormalVector( i , Normal7 )) , LightDir1710 );
			float saferPower1_g265 = max( ( -( 1.0 - (2.0 + (_ShadowLength - 0.0) * (16.0 - 2.0) / (16.0 - 0.0)) ) * ( dotResult10 + _ShadowOffset ) ) , 0.0001 );
			float temp_output_2_0_g265 = pow( saferPower2_g265 , pow( saferPower1_g265 , 2.0 ) );
			float NdotL23 = ( 1.0 - temp_output_2_0_g265 );
			float EffectTiling105 = _HaltoneScale;
			float HalftoneRotation170 = radians( _HaltoneRotation );
			float cos91 = cos( HalftoneRotation170 );
			float sin91 = sin( HalftoneRotation170 );
			float2 rotator91 = mul( ( i.uv_texcoord * EffectTiling105 ) - float2( 0,0 ) , float2x2( cos91 , -sin91 , sin91 , cos91 )) + float2( 0,0 );
			float2 HalftoneUVS63 = frac( rotator91 );
			float temp_output_14_0 = length( ( HalftoneUVS63 + float2( -0.5,-0.5 ) ) );
			float temp_output_3_0_g366 = ( 0.0 - ( temp_output_14_0 - ( 1.0 - NdotL23 ) ) );
			float BaseNdotL286 = dotResult10;
			float CircularEffectLighting25 = ( 1.0 - ( saturate( ( temp_output_3_0_g366 / fwidth( temp_output_3_0_g366 ) ) ) * ( 1.0 - saturate( BaseNdotL286 ) ) ) );
			float ShadowStyleIndex1758 = _ShadowStyleIndex;
			float lerpResult1754 = lerp( saturate( NdotL23 ) , CircularEffectLighting25 , saturate( ShadowStyleIndex1758 ));
			float2 break67 = HalftoneUVS63;
			float2 break70 = ( 1.0 - HalftoneUVS63 );
			float temp_output_78_0 = ( ( max( max( break67.x , break67.y ) , max( break70.x , break70.y ) ) * 1.5 ) - 0.85 );
			float temp_output_3_0_g369 = ( 0.0 - ( temp_output_78_0 - ( 1.0 - NdotL23 ) ) );
			float SquareEffectLighting86 = ( 1.0 - ( saturate( ( temp_output_3_0_g369 / fwidth( temp_output_3_0_g369 ) ) ) * ( 1.0 - saturate( BaseNdotL286 ) ) ) );
			float lerpResult1762 = lerp( lerpResult1754 , SquareEffectLighting86 , saturate( ( ShadowStyleIndex1758 - 1.0 ) ));
			float2 p228 = HalftoneUVS63;
			float r228 = ( 1.0 - NdotL23 );
			float localHexagon228 = Hexagon( p228 , r228 );
			float temp_output_3_0_g370 = ( 0.0 - localHexagon228 );
			float HalftoneHexagon243 = ( 1.0 - ( saturate( ( temp_output_3_0_g370 / fwidth( temp_output_3_0_g370 ) ) ) * ( 1.0 - saturate( BaseNdotL286 ) ) ) );
			float lerpResult1773 = lerp( lerpResult1762 , HalftoneHexagon243 , saturate( ( ShadowStyleIndex1758 - 2.0 ) ));
			float2 p214 = HalftoneUVS63;
			float r214 = (0.0 + (saturate( ( 1.0 - NdotL23 ) ) - 0.0) * (5.0 - 0.0) / (1.0 - 0.0));
			int n214 = 4;
			float m214 = 3.0;
			float localRegularStar214 = RegularStar( p214 , r214 , n214 , m214 );
			float temp_output_3_0_g371 = ( 0.0 - localRegularStar214 );
			float Halftone4SidedStar221 = ( 1.0 - ( saturate( ( temp_output_3_0_g371 / fwidth( temp_output_3_0_g371 ) ) ) * ( 1.0 - saturate( BaseNdotL286 ) ) ) );
			float lerpResult1779 = lerp( lerpResult1773 , Halftone4SidedStar221 , saturate( ( ShadowStyleIndex1758 - 3.0 ) ));
			float2 p184 = HalftoneUVS63;
			float r184 = (0.0 + (saturate( ( 1.0 - NdotL23 ) ) - 0.0) * (2.75 - 0.0) / (1.0 - 0.0));
			int n184 = 8;
			float m184 = 3.0;
			float localRegularStar184 = RegularStar( p184 , r184 , n184 , m184 );
			float temp_output_3_0_g372 = ( 0.0 - localRegularStar184 );
			float Halftone8SidedStar205 = ( 1.0 - ( saturate( ( temp_output_3_0_g372 / fwidth( temp_output_3_0_g372 ) ) ) * ( 1.0 - saturate( BaseNdotL286 ) ) ) );
			float lerpResult1783 = lerp( lerpResult1779 , Halftone8SidedStar205 , saturate( ( ShadowStyleIndex1758 - 4.0 ) ));
			float cos109 = cos( HalftoneRotation170 );
			float sin109 = sin( HalftoneRotation170 );
			float2 rotator109 = mul( ( i.uv_texcoord * ( EffectTiling105 * 3.0 ) ) - float2( 0,0 ) , float2x2( cos109 , -sin109 , sin109 , cos109 )) + float2( 0,0 );
			float temp_output_89_0 = abs( sin( rotator109.x ) );
			float temp_output_3_0_g373 = ( 0.56 - ( temp_output_89_0 - NdotL23 ) );
			float SketchyEffectLighting103 = ( saturate( ( temp_output_3_0_g373 / fwidth( temp_output_3_0_g373 ) ) ) * saturate( BaseNdotL286 ) );
			float lerpResult1787 = lerp( lerpResult1783 , SketchyEffectLighting103 , saturate( ( ShadowStyleIndex1758 - 5.0 ) ));
			float temp_output_38_0 = saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - _BlendOffset ) / _BlendLength ) );
			float DistanceBlendAlpha2081 = temp_output_38_0;
			float lerpResult2086 = lerp( lerpResult1787 , saturate( NdotL23 ) , DistanceBlendAlpha2081);
			float saferPower2_g453 = max( ( 1.0 / 2.71828 ) , 0.0001 );
			float ShadowLength1497 = _ShadowLength;
			float ShadowOffset1502 = _ShadowOffset;
			float saferPower1_g453 = max( ( -( 1.0 - (6.0 + (ShadowLength1497 - 0.0) * (64.0 - 6.0) / (16.0 - 0.0)) ) * ( BaseNdotL286 + ShadowOffset1502 ) ) , 0.0001 );
			float temp_output_2_0_g453 = pow( saferPower2_g453 , pow( saferPower1_g453 , 2.0 ) );
			float ToonLighting1505 = ( 1.0 - temp_output_2_0_g453 );
			float lerpResult1796 = lerp( lerpResult2086 , ToonLighting1505 , saturate( ( ShadowStyleIndex1758 - 6.0 ) ));
			float saferPower2_g454 = max( ( 1.0 / 2.71828 ) , 0.0001 );
			float saferPower1_g454 = max( ( -( 1.0 - (2.0 + (ShadowLength1497 - 0.0) * (16.0 - 2.0) / (16.0 - 0.0)) ) * ( (BaseNdotL286*0.5 + 0.5) + ShadowOffset1502 ) ) , 0.0001 );
			float temp_output_2_0_g454 = pow( saferPower2_g454 , pow( saferPower1_g454 , 2.0 ) );
			float HalfLambert1522 = ( 1.0 - temp_output_2_0_g454 );
			float lerpResult1800 = lerp( lerpResult1796 , HalfLambert1522 , saturate( ( ShadowStyleIndex1758 - 7.0 ) ));
			float SelectedLightingStyle165 = lerpResult1800;
			float Circles338 = temp_output_14_0;
			float temp_output_3_0_g456 = ( 0.0 - ( Circles338 - ( 1.0 - ase_lightAtten ) ) );
			float CircularShadows967 = ( 1.0 - ( saturate( ( temp_output_3_0_g456 / fwidth( temp_output_3_0_g456 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1814 = lerp( ase_lightAtten , CircularShadows967 , saturate( ShadowStyleIndex1758 ));
			float Squares684 = temp_output_78_0;
			float temp_output_3_0_g457 = ( 0.0 - ( ( Squares684 * 0.5 ) - ( 1.0 - ase_lightAtten ) ) );
			float SquareShadows988 = ( 1.0 - ( saturate( ( temp_output_3_0_g457 / fwidth( temp_output_3_0_g457 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1819 = lerp( lerpResult1814 , SquareShadows988 , saturate( ( ShadowStyleIndex1758 - 1.0 ) ));
			float2 p1064 = HalftoneUVS63;
			float r1064 = ( ( 1.0 - ase_lightAtten ) * 1.25 );
			float localHexagon1064 = Hexagon( p1064 , r1064 );
			float temp_output_3_0_g458 = ( 0.0 - localHexagon1064 );
			float HexagonalShadows1051 = ( 1.0 - ( saturate( ( temp_output_3_0_g458 / fwidth( temp_output_3_0_g458 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1826 = lerp( lerpResult1819 , HexagonalShadows1051 , saturate( ( ShadowStyleIndex1758 - 2.0 ) ));
			float2 p1038 = HalftoneUVS63;
			float r1038 = ( (0.0 + (saturate( ( 1.0 - ase_lightAtten ) ) - 0.0) * (2.75 - 0.0) / (1.0 - 0.0)) * 1.75 );
			int n1038 = 4;
			float m1038 = 3.0;
			float localRegularStar1038 = RegularStar( p1038 , r1038 , n1038 , m1038 );
			float temp_output_3_0_g459 = ( 0.0 - localRegularStar1038 );
			float StarShadows21034 = ( 1.0 - ( saturate( ( temp_output_3_0_g459 / fwidth( temp_output_3_0_g459 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1827 = lerp( lerpResult1826 , StarShadows21034 , saturate( ( ShadowStyleIndex1758 - 3.0 ) ));
			float2 p1024 = HalftoneUVS63;
			float r1024 = (0.0 + (saturate( ( 1.0 - ase_lightAtten ) ) - 0.0) * (2.75 - 0.0) / (1.0 - 0.0));
			int n1024 = 8;
			float m1024 = 3.0;
			float localRegularStar1024 = RegularStar( p1024 , r1024 , n1024 , m1024 );
			float temp_output_3_0_g461 = ( 0.0 - localRegularStar1024 );
			float StarShadows11021 = ( 1.0 - ( saturate( ( temp_output_3_0_g461 / fwidth( temp_output_3_0_g461 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1836 = lerp( lerpResult1827 , StarShadows11021 , saturate( ( ShadowStyleIndex1758 - 4.0 ) ));
			float Lines725 = temp_output_89_0;
			float temp_output_3_0_g465 = ( 0.0 - ( ( Lines725 * 0.5 ) - ( 1.0 - ase_lightAtten ) ) );
			float LineShadows1003 = ( 1.0 - ( saturate( ( temp_output_3_0_g465 / fwidth( temp_output_3_0_g465 ) ) ) * ( 1.0 - ase_lightAtten ) ) );
			float lerpResult1837 = lerp( lerpResult1836 , LineShadows1003 , saturate( ( ShadowStyleIndex1758 - 5.0 ) ));
			float lerpResult2095 = lerp( lerpResult1837 , ase_lightAtten , DistanceBlendAlpha2081);
			float smoothstepResult1848 = smoothstep( (0.5 + (ShadowLength1497 - 0.0) * (0.65 - 0.5) / (16.0 - 0.0)) , (1.0 + (ShadowLength1497 - 0.0) * (0.66 - 1.0) / (16.0 - 0.0)) , ase_lightAtten);
			float lerpResult1841 = lerp( lerpResult2095 , smoothstepResult1848 , saturate( ( ShadowStyleIndex1758 - 6.0 ) ));
			float lerpResult1844 = lerp( lerpResult1841 , (ase_lightAtten*0.5 + 0.5) , saturate( ( ShadowStyleIndex1758 - 7.0 ) ));
			float StylizedAttenuation1077 = lerpResult1844;
			UnityGI gi726 = gi;
			float3 diffNorm726 = WorldNormalVector( i , Normal7 );
			gi726 = UnityGI_Base( data, 1, diffNorm726 );
			float3 indirectDiffuse726 = gi726.indirect.diffuse + diffNorm726 * 0.0001;
			float saferPower1416 = max( tex2D( _Occlusion, uv_MainTex ).g , 0.0001 );
			float Occlusion1417 = pow( saferPower1416 , _OcclusionPower );
			float3 temp_output_1419_0 = ( indirectDiffuse726 * Occlusion1417 );
			float3 uvw2048 = (WorldNormalVector( i , Normal7 ));
			float3 localCustomReflectionProbeSample2048 = CustomReflectionProbeSample2048( uvw2048 );
			float3 CustomProbe2049 = localCustomReflectionProbeSample2048;
			float3 lerpResult2058 = lerp( temp_output_1419_0 , ( ( temp_output_1419_0 + CustomProbe2049 ) * float3( 0.5,0.5,0.5 ) ) , isLightMissing1721);
			float3 IndirectDiffuse728 = lerpResult2058;
			float3 lerpResult1706 = lerp( ( ase_lightColor.rgb * StylizedAttenuation1077 ) , ( ( IndirectDiffuse728 + CustomProbe2049 ) * float3( 0.5,0.5,0.5 ) ) , isLightMissing1721);
			float3 AttenuatedLightColor942 = lerpResult1706;
			float3 normalizeResult314 = normalize( ( ( float3( 2,2,2 ) * (WorldNormalVector( i , Normal7 )) ) - LightDir1710 ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult315 = dot( normalizeResult314 , ase_worldViewDir );
			float BaseSpecular768 = dotResult315;
			float nh328 = saturate( BaseSpecular768 );
			float lerpResult1406 = lerp( ( tex2DNode1399.a * _Smoothness ) , _Smoothness , isMetallicMissing1405);
			float Smoothness354 = lerpResult1406;
			float temp_output_329_0 = ( 1.0 - (0.0 + (Smoothness354 - 0.0) * (0.935 - 0.0) / (1.0 - 0.0)) );
			float roughness328 = ( temp_output_329_0 * temp_output_329_0 );
			float localRoughnessCalc328 = RoughnessCalc( nh328 , roughness328 );
			float DefaultSpecular324 = ( localRoughnessCalc328 * SelectedLightingStyle165 );
			float SpecularHalftoneTiling410 = _SpecularHaltoneScale;
			float SpecularHalftoneRotation413 = radians( _SpecularHaltoneRotation );
			float cos414 = cos( SpecularHalftoneRotation413 );
			float sin414 = sin( SpecularHalftoneRotation413 );
			float2 rotator414 = mul( ( i.uv_texcoord * SpecularHalftoneTiling410 ) - float2( 0,0 ) , float2x2( cos414 , -sin414 , sin414 , cos414 )) + float2( 0,0 );
			float2 SpecularHalftoneUVS416 = frac( rotator414 );
			float SpecularProduct351 = ( ( BaseSpecular768 + 2.4 + _SpecularOffset ) * 0.3 );
			float smoothstepResult1450 = smoothstep( min( ( _SpecularLength / 16.0 ) , 0.99 ) , 1.0 , pow( saturate( SpecularProduct351 ) , max( ( Smoothness354 * 64.0 ) , 0.01 ) ));
			float HalftoneSpecular379 = ( smoothstepResult1450 * SelectedLightingStyle165 );
			float temp_output_3_0_g468 = ( 0.0 - ( length( ( SpecularHalftoneUVS416 + float2( -0.5,-0.5 ) ) ) - HalftoneSpecular379 ) );
			float CircularSpecular404 = ( ( saturate( ( temp_output_3_0_g468 / fwidth( temp_output_3_0_g468 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float SpecularStyleIndex1995 = _SpecularStyleIndex;
			float lerpResult2005 = lerp( DefaultSpecular324 , CircularSpecular404 , saturate( SpecularStyleIndex1995 ));
			float2 break426 = SpecularHalftoneUVS416;
			float2 break427 = ( 1.0 - SpecularHalftoneUVS416 );
			float temp_output_3_0_g470 = ( 0.0 - ( ( ( max( max( break426.x , break426.y ) , max( break427.x , break427.y ) ) * 1.9 ) - 1.5 ) - HalftoneSpecular379 ) );
			float SquareSpecular444 = ( ( saturate( ( temp_output_3_0_g470 / fwidth( temp_output_3_0_g470 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float lerpResult2009 = lerp( lerpResult2005 , SquareSpecular444 , saturate( ( SpecularStyleIndex1995 - 1.0 ) ));
			float2 p525 = HalftoneUVS63;
			float r525 = HalftoneSpecular379;
			float localHexagon525 = Hexagon( p525 , r525 );
			float temp_output_3_0_g471 = ( 0.0 - localHexagon525 );
			float SpecularHexagon531 = ( ( saturate( ( temp_output_3_0_g471 / fwidth( temp_output_3_0_g471 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float lerpResult2015 = lerp( lerpResult2009 , SpecularHexagon531 , saturate( ( SpecularStyleIndex1995 - 2.0 ) ));
			float2 p508 = SpecularHalftoneUVS416;
			float r508 = (0.0 + (saturate( HalftoneSpecular379 ) - 0.0) * (5.0 - 0.0) / (1.0 - 0.0));
			int n508 = 4;
			float m508 = 3.0;
			float localRegularStar508 = RegularStar( p508 , r508 , n508 , m508 );
			float temp_output_3_0_g474 = ( 0.0 - localRegularStar508 );
			float Specular4SidedStar513 = ( ( saturate( ( temp_output_3_0_g474 / fwidth( temp_output_3_0_g474 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float lerpResult2021 = lerp( lerpResult2015 , Specular4SidedStar513 , saturate( ( SpecularStyleIndex1995 - 3.0 ) ));
			float2 p486 = SpecularHalftoneUVS416;
			float r486 = (-0.25 + (saturate( HalftoneSpecular379 ) - 0.0) * (1.0 - -0.25) / (1.0 - 0.0));
			int n486 = 8;
			float m486 = 3.0;
			float localRegularStar486 = RegularStar( p486 , r486 , n486 , m486 );
			float temp_output_3_0_g476 = ( 0.0 - localRegularStar486 );
			float Specular8SidedStar491 = ( ( saturate( ( temp_output_3_0_g476 / fwidth( temp_output_3_0_g476 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float lerpResult2025 = lerp( lerpResult2021 , Specular8SidedStar491 , saturate( ( SpecularStyleIndex1995 - 4.0 ) ));
			float cos455 = cos( SpecularHalftoneRotation413 );
			float sin455 = sin( SpecularHalftoneRotation413 );
			float2 rotator455 = mul( ( i.uv_texcoord * ( SpecularHalftoneTiling410 * 3.0 ) ) - float2( 0,0 ) , float2x2( cos455 , -sin455 , sin455 , cos455 )) + float2( 0,0 );
			float temp_output_3_0_g478 = ( 0.0 - ( ( abs( sin( rotator455.x ) ) * 0.5 ) - HalftoneSpecular379 ) );
			float LinesSpecular467 = ( ( saturate( ( temp_output_3_0_g478 / fwidth( temp_output_3_0_g478 ) ) ) * 3.5 ) * ( DefaultSpecular324 + ( HalftoneSpecular379 * 2.0 ) ) * Smoothness354 );
			float lerpResult2031 = lerp( lerpResult2025 , LinesSpecular467 , saturate( ( SpecularStyleIndex1995 - 5.0 ) ));
			float lerpResult2099 = lerp( lerpResult2031 , DefaultSpecular324 , DistanceBlendAlpha2081);
			float ToonSpecular1545 = ( ( HalftoneSpecular379 * 3.5 ) * ( HalftoneSpecular379 * 2.0 ) );
			float lerpResult2033 = lerp( lerpResult2099 , ToonSpecular1545 , saturate( ( SpecularStyleIndex1995 - 6.0 ) ));
			float SelectedSpecularStyle388 = lerpResult2033;
			float saferPower2_g455 = max( ( 1.0 / 2.71828 ) , 0.0001 );
			float3 rotatedValue734 = RotateAroundAxis( float3( 0,0,0 ), (WorldNormalVector( i , Normal7 )), normalize( _RimlightRotationAxis ), radians( _RimlightRotationAngle ) );
			float dotResult738 = dot( rotatedValue734 , ase_worldViewDir );
			float saferPower1_g455 = max( ( -( 1.0 - _RimlightLength ) * ( -dotResult738 + _RimlightOffset ) ) , 0.0001 );
			float temp_output_2_0_g455 = pow( saferPower2_g455 , pow( saferPower1_g455 , 2.0 ) );
			float temp_output_1451_0 = ( 1.0 - temp_output_2_0_g455 );
			float Rimlight773 = ( SelectedLightingStyle165 * temp_output_1451_0 );
			float RimlightHalftoneTiling779 = _RimlightHaltoneScale;
			float RimlightHalftoneRotation780 = radians( _RimlightHaltoneRotation );
			float cos782 = cos( RimlightHalftoneRotation780 );
			float sin782 = sin( RimlightHalftoneRotation780 );
			float2 rotator782 = mul( ( i.uv_texcoord * RimlightHalftoneTiling779 ) - float2( 0,0 ) , float2x2( cos782 , -sin782 , sin782 , cos782 )) + float2( 0,0 );
			float2 RimlightHalftoneUVS784 = frac( rotator782 );
			float lerpResult37 = lerp( 0.0 , 2.0 , temp_output_38_0);
			float DistanceBlend40 = lerpResult37;
			float temp_output_3_0_g462 = ( 0.0 - ( length( ( RimlightHalftoneUVS784 + float2( -0.5,-0.5 ) ) ) - ( Rimlight773 + DistanceBlend40 ) ) );
			float BaseRimlight769 = ( temp_output_1451_0 * SelectedLightingStyle165 * 2.0 );
			float CircularRimlight786 = ( saturate( ( temp_output_3_0_g462 / fwidth( temp_output_3_0_g462 ) ) ) * BaseRimlight769 );
			float RimlightStyleIndex1942 = _RimlightStyleIndex;
			float lerpResult1905 = lerp( saturate( Rimlight773 ) , CircularRimlight786 , saturate( RimlightStyleIndex1942 ));
			float2 break807 = RimlightHalftoneUVS784;
			float2 break806 = ( 1.0 - RimlightHalftoneUVS784 );
			float temp_output_3_0_g466 = ( 0.0 - ( ( ( max( max( break807.x , break807.y ) , max( break806.x , break806.y ) ) * 2.0 ) - 1.5 ) - Rimlight773 ) );
			float SquareRimlight824 = ( saturate( ( temp_output_3_0_g466 / fwidth( temp_output_3_0_g466 ) ) ) * BaseRimlight769 );
			float lerpResult1913 = lerp( lerpResult1905 , SquareRimlight824 , saturate( ( RimlightStyleIndex1942 - 1.0 ) ));
			float2 p919 = RimlightHalftoneUVS784;
			float r919 = Rimlight773;
			float localHexagon919 = Hexagon( p919 , r919 );
			float temp_output_3_0_g467 = ( 0.0 - localHexagon919 );
			float RimlightHexagon927 = ( saturate( ( temp_output_3_0_g467 / fwidth( temp_output_3_0_g467 ) ) ) * BaseRimlight769 );
			float lerpResult1918 = lerp( lerpResult1913 , RimlightHexagon927 , saturate( ( RimlightStyleIndex1942 - 2.0 ) ));
			float2 p905 = RimlightHalftoneUVS784;
			float r905 = (0.0 + (saturate( Rimlight773 ) - 0.0) * (5.0 - 0.0) / (1.0 - 0.0));
			int n905 = 4;
			float m905 = 3.0;
			float localRegularStar905 = RegularStar( p905 , r905 , n905 , m905 );
			float temp_output_3_0_g469 = ( 0.0 - localRegularStar905 );
			float Rimlight4SidedStar913 = ( saturate( ( temp_output_3_0_g469 / fwidth( temp_output_3_0_g469 ) ) ) * BaseRimlight769 );
			float lerpResult1920 = lerp( lerpResult1918 , Rimlight4SidedStar913 , saturate( ( RimlightStyleIndex1942 - 3.0 ) ));
			float2 p888 = RimlightHalftoneUVS784;
			float r888 = (0.0 + (saturate( Rimlight773 ) - 0.0) * (2.75 - 0.0) / (1.0 - 0.0));
			int n888 = 8;
			float m888 = 3.0;
			float localRegularStar888 = RegularStar( p888 , r888 , n888 , m888 );
			float temp_output_3_0_g472 = ( 0.0 - localRegularStar888 );
			float Rimlight8SidedStar894 = ( saturate( ( temp_output_3_0_g472 / fwidth( temp_output_3_0_g472 ) ) ) * BaseRimlight769 );
			float lerpResult1926 = lerp( lerpResult1920 , Rimlight8SidedStar894 , saturate( ( RimlightStyleIndex1942 - 4.0 ) ));
			float cos868 = cos( RimlightHalftoneRotation780 );
			float sin868 = sin( RimlightHalftoneRotation780 );
			float2 rotator868 = mul( ( i.uv_texcoord * ( RimlightHalftoneTiling779 * 3.0 ) ) - float2( 0,0 ) , float2x2( cos868 , -sin868 , sin868 , cos868 )) + float2( 0,0 );
			float temp_output_3_0_g475 = ( 0.56 - ( abs( sin( rotator868.x ) ) - Rimlight773 ) );
			float RimlightLines862 = ( saturate( ( temp_output_3_0_g475 / fwidth( temp_output_3_0_g475 ) ) ) * BaseRimlight769 );
			float lerpResult1935 = lerp( lerpResult1926 , RimlightLines862 , saturate( ( RimlightStyleIndex1942 - 5.0 ) ));
			float lerpResult2091 = lerp( lerpResult1935 , saturate( Rimlight773 ) , DistanceBlendAlpha2081);
			float saferPower2_g477 = max( ( 1.0 / 2.71828 ) , 0.0001 );
			float RimlightLength1560 = _RimlightLength;
			float BaseRimlightForToon1744 = -dotResult738;
			float RimlightOffset1561 = _RimlightOffset;
			float saferPower1_g477 = max( ( -( 1.0 - (6.0 + (RimlightLength1560 - 0.0) * (32.0 - 6.0) / (16.0 - 0.0)) ) * ( BaseRimlightForToon1744 + (0.3 + (RimlightOffset1561 - -1.0) * (1.0 - 0.3) / (5.0 - -1.0)) ) ) , 0.0001 );
			float temp_output_2_0_g477 = pow( saferPower2_g477 , pow( saferPower1_g477 , 2.0 ) );
			float ToonRimlight1559 = ( ( 1.0 - temp_output_2_0_g477 ) * SelectedLightingStyle165 );
			float lerpResult1938 = lerp( lerpResult2091 , ToonRimlight1559 , saturate( ( RimlightStyleIndex1942 - 6.0 ) ));
			float lerpResult1939 = lerp( lerpResult1938 , 0.0 , saturate( ( RimlightStyleIndex1942 - 7.0 ) ));
			float SelectedRimlightStyle796 = lerpResult1939;
			float Reflectivity1377 = oneMinusReflectivity1307;
			float clampResult1395 = clamp( Reflectivity1377 , 0.15 , 1.0 );
			float fresnelNdotV544 = dot( (WorldNormalVector( i , Normal7 )), ase_worldViewDir );
			float fresnelNode544 = ( ((0.05 + (Smoothness354 - 0.0) * (1.0 - 0.05) / (1.0 - 0.0)) + (Metallic1113 - 0.0) * ((0.4 + (Smoothness354 - 0.0) * (1.0 - 0.4) / (1.0 - 0.0)) - (0.05 + (Smoothness354 - 0.0) * (1.0 - 0.05) / (1.0 - 0.0))) / (1.0 - 0.0)) + Smoothness354 * pow( 1.0 - fresnelNdotV544, 5.0 ) );
			float3 indirectNormal541 = WorldNormalVector( i , Normal7 );
			Unity_GlossyEnvironmentData g541 = UnityGlossyEnvironmentSetup( Smoothness354, data.worldViewDir, indirectNormal541, float3(0,0,0));
			float3 indirectSpecular541 = UnityGI_IndirectSpecular( data, Occlusion1417, indirectNormal541, g541 );
			float3 IndirectSpecular548 = ( saturate( fresnelNode544 ) * indirectSpecular541 );
			float4 Specular1672 = tex2DNode1399;
			float4 lerpResult1693 = lerp( Specular1672 , float4( 1,1,1,1 ) , isMetallicMissing1405);
			float4 lerpResult1683 = lerp( float4( specColor1307 , 0.0 ) , ( float4( specColor1307 , 0.0 ) * lerpResult1693 ) , Workflow1671);
			float4 SpecColor1311 = lerpResult1683;
			c.rgb = ( float4( ( MetAlbedo1310 * ( ( SelectedLightingStyle165 * AttenuatedLightColor942 ) + IndirectDiffuse728 ) ) , 0.0 ) + ( ( ( SelectedSpecularStyle388 * float4( AttenuatedLightColor942 , 0.0 ) * _SpecularTint ) + ( float4( ( AttenuatedLightColor942 * ( SelectedRimlightStyle796 * 5.0 ) * clampResult1395 ) , 0.0 ) * ( Smoothness354 * 3.5 ) * _RimlightTint ) + float4( IndirectSpecular548 , 0.0 ) ) * SpecColor1311 ) ).rgb;
			c.a = AlbedoAlpha1495;
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Albedo33 = ( tex2D( _MainTex, uv_MainTex ) * _Color );
			float4 tex2DNode1399 = tex2D( _Metallic, uv_MainTex );
			float isMetallicMissing1405 = step( max( _Metallic_TexelSize.z , _Metallic_TexelSize.w ) , 1.0 );
			float lerpResult1473 = lerp( ( tex2DNode1399.r * _MetallicVal ) , _MetallicVal , isMetallicMissing1405);
			float Workflow1671 = _Workflow;
			float lerpResult1689 = lerp( lerpResult1473 , 0.0 , Workflow1671);
			float Metallic1113 = lerpResult1689;
			half3 specColor1307 = (0).xxx;
			half oneMinusReflectivity1307 = 0;
			half3 diffuseAndSpecularFromMetallic1307 = DiffuseAndSpecularFromMetallic(Albedo33.rgb,Metallic1113,specColor1307,oneMinusReflectivity1307);
			float3 MetAlbedo1310 = diffuseAndSpecularFromMetallic1307;
			o.Albedo = MetAlbedo1310;
			float cos695_g479 = cos( radians( _GradientDirection ) );
			float sin695_g479 = sin( radians( _GradientDirection ) );
			float2 rotator695_g479 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos695_g479 , -sin695_g479 , sin695_g479 , cos695_g479 )) + float2( 0.5,0.5 );
			float2 GradientUVs698_g479 = rotator695_g479;
			float4 _GradientZone2 = float4(9.4,0,0.57,0.49);
			float2 appendResult34_g479 = (float2(( 1.0 / _GradientZone2.x ) , 0.0));
			float2 appendResult42_g479 = (float2(_GradientZone2.z , _GradientZone2.w));
			float2 clampResult707_g479 = clamp( (GradientUVs698_g479*appendResult34_g479 + appendResult42_g479) , float2( 0.571,0 ) , float2( 0.676,1 ) );
			float2 GradientZone0175_g479 = clampResult707_g479;
			float4 _GradientZone3 = float4(9.4,0,0.6805,0.49);
			float2 appendResult38_g479 = (float2(( 1.0 / _GradientZone3.x ) , 0.0));
			float2 appendResult41_g479 = (float2(_GradientZone3.z , _GradientZone3.w));
			float2 clampResult710_g479 = clamp( (GradientUVs698_g479*appendResult38_g479 + appendResult41_g479) , float2( 0.681,0 ) , float2( 0.786,1 ) );
			float2 GradientZone0282_g479 = clampResult710_g479;
			int EmissionZoneIndex47_g479 = _EmissionZone;
			float2 lerpResult169_g479 = lerp( GradientZone0175_g479 , GradientZone0282_g479 , (float)saturate( EmissionZoneIndex47_g479 ));
			float4 _GradientZone4 = float4(9.4,0,0.791,0.49);
			float2 appendResult57_g479 = (float2(( 1.0 / _GradientZone4.x ) , 0.0));
			float2 appendResult52_g479 = (float2(_GradientZone4.z , _GradientZone4.w));
			float2 clampResult711_g479 = clamp( (GradientUVs698_g479*appendResult57_g479 + appendResult52_g479) , float2( 0.792,0 ) , float2( 0.896,1 ) );
			float2 GradientZone03122_g479 = clampResult711_g479;
			float2 lerpResult214_g479 = lerp( lerpResult169_g479 , GradientZone03122_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 1 ) ));
			float2 OriginalOffset44_g479 = float2( 0.1,0.471 );
			float2 Zone01138_g479 = ( float2( 0.955,0.992 ) - OriginalOffset44_g479 );
			float2 lerpResult249_g479 = lerp( lerpResult214_g479 , Zone01138_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 2 ) ));
			float2 Zone02188_g479 = ( float2( 0.964,0.992 ) - OriginalOffset44_g479 );
			float2 lerpResult286_g479 = lerp( lerpResult249_g479 , Zone02188_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 3 ) ));
			float2 Zone03224_g479 = ( float2( 0.955,0.978 ) - OriginalOffset44_g479 );
			float2 lerpResult343_g479 = lerp( lerpResult286_g479 , Zone03224_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 4 ) ));
			float2 Zone04291_g479 = ( float2( 0.964,0.978 ) - OriginalOffset44_g479 );
			float2 lerpResult364_g479 = lerp( lerpResult343_g479 , Zone04291_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 5 ) ));
			float2 EmissionZoneUV375_g479 = lerpResult364_g479;
			float temp_output_423_0_g479 = ( 1.0 - _EnableEmissionGlow );
			float StoredTextureTog669_g479 = step( max( _Stored_TexelSize.z , _Stored_TexelSize.w ) , 500.0 );
			float temp_output_712_0_g479 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g479.x + _Time.y ) ) ) ) );
			float3 appendResult65_g479 = (float3(temp_output_712_0_g479 , temp_output_712_0_g479 , temp_output_712_0_g479));
			float3 DebugGradient1111_g479 = appendResult65_g479;
			float temp_output_713_0_g479 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g479.x + _Time.y + 0.3 ) ) ) ) );
			float3 appendResult72_g479 = (float3(temp_output_713_0_g479 , temp_output_713_0_g479 , 0.0));
			float3 DebugGradient2110_g479 = appendResult72_g479;
			float3 lerpResult181_g479 = lerp( DebugGradient1111_g479 , DebugGradient2110_g479 , (float)saturate( EmissionZoneIndex47_g479 ));
			float temp_output_714_0_g479 = saturate( ( 1.0 - abs( sin( ( GradientUVs698_g479.x + _Time.y + 0.6 ) ) ) ) );
			float3 appendResult96_g479 = (float3(0.0 , temp_output_714_0_g479 , temp_output_714_0_g479));
			float3 DebugGradient3173_g479 = appendResult96_g479;
			float3 lerpResult244_g479 = lerp( lerpResult181_g479 , DebugGradient3173_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 1 ) ));
			float3 appendResult139_g479 = (float3(0.0 , 0.0 , saturate( ( 1.0 - abs( sin( _Time.y ) ) ) )));
			float3 DebugZone1195_g479 = appendResult139_g479;
			float3 lerpResult278_g479 = lerp( lerpResult244_g479 , DebugZone1195_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 2 ) ));
			float temp_output_716_0_g479 = saturate( ( 1.0 - abs( sin( ( _Time.y + 0.2 ) ) ) ) );
			float3 appendResult192_g479 = (float3(temp_output_716_0_g479 , temp_output_716_0_g479 , temp_output_716_0_g479));
			float3 DebugZone2250_g479 = appendResult192_g479;
			float3 lerpResult352_g479 = lerp( lerpResult278_g479 , DebugZone2250_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 3 ) ));
			float3 appendResult259_g479 = (float3(saturate( ( 1.0 - abs( sin( ( _Time.y + 0.4 ) ) ) ) ) , 0.0 , 0.0));
			float3 DebugZone3309_g479 = appendResult259_g479;
			float3 lerpResult362_g479 = lerp( lerpResult352_g479 , DebugZone3309_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 4 ) ));
			float3 appendResult306_g479 = (float3(0.0 , saturate( ( 1.0 - abs( sin( ( _Time.y + 0.6 ) ) ) ) ) , 0.0));
			float3 DebugZone4332_g479 = appendResult306_g479;
			float3 lerpResult379_g479 = lerp( lerpResult362_g479 , DebugZone4332_g479 , (float)saturate( ( EmissionZoneIndex47_g479 - 5 ) ));
			float EnableGlowMaskEmission683_g479 = temp_output_423_0_g479;
			float3 DebugEmissionColor399_g479 = saturate( ( lerpResult379_g479 + EnableGlowMaskEmission683_g479 ) );
			float DebugSwitch628_g479 = _DebugMode;
			float4 lerpResult634_g479 = lerp( saturate( ( tex2Dlod( _Stored, float4( EmissionZoneUV375_g479, 0, 0.0) ) + temp_output_423_0_g479 + StoredTextureTog669_g479 ) ) , float4( DebugEmissionColor399_g479 , 0.0 ) , DebugSwitch628_g479);
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float2 panner1666 = ( 1.0 * _Time.y * ( _EmissionPan * _EmissionPanSpeed ) + uv_Emission);
			float2 uv_EmissionMask = i.uv_texcoord * _EmissionMask_ST.xy + _EmissionMask_ST.zw;
			float3 Emission436_g479 = ( tex2D( _Emission, panner1666 ) * _EmissionColor * tex2D( _EmissionMask, uv_EmissionMask ).r ).rgb;
			float4 EmissionGlowColor471_g479 = ( lerpResult634_g479 * float4( Emission436_g479 , 0.0 ) );
			float2 ReactiveZone365_g479 = ( float2( 0.673,0.985 ) - OriginalOffset44_g479 );
			float mulTime293_g479 = _Time.y * 13.0;
			float3 appendResult390_g479 = (float3(saturate( sin( mulTime293_g479 ) ) , saturate( sin( ( mulTime293_g479 + 0.5 ) ) ) , 0.0));
			float4 lerpResult637_g479 = lerp( saturate( ( StoredTextureTog669_g479 + tex2D( _Stored, ReactiveZone365_g479 ) ) ) , float4( appendResult390_g479 , 0.0 ) , DebugSwitch628_g479);
			float4 break417_g479 = lerpResult637_g479;
			float LowBlink431_g479 = break417_g479.r;
			int ReactivityIndexEmission470_g479 = _EmissionReactivity;
			float4 lerpResult532_g479 = lerp( EmissionGlowColor471_g479 , ( EmissionGlowColor471_g479 * LowBlink431_g479 ) , (float)saturate( ReactivityIndexEmission470_g479 ));
			float cos437_g479 = cos( radians( _LowsPulseDirection ) );
			float sin437_g479 = sin( radians( _LowsPulseDirection ) );
			float2 rotator437_g479 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos437_g479 , -sin437_g479 , sin437_g479 , cos437_g479 )) + float2( 0.5,0.5 );
			float LowPulse493_g479 = saturate( ( rotator437_g479.y - ( 1.0 - LowBlink431_g479 ) ) );
			float4 lerpResult580_g479 = lerp( lerpResult532_g479 , ( EmissionGlowColor471_g479 * LowPulse493_g479 ) , (float)saturate( ( ReactivityIndexEmission470_g479 - 1 ) ));
			float HighBlink464_g479 = break417_g479.g;
			float4 lerpResult590_g479 = lerp( lerpResult580_g479 , ( EmissionGlowColor471_g479 * HighBlink464_g479 ) , (float)saturate( ( ReactivityIndexEmission470_g479 - 2 ) ));
			float cos456_g479 = cos( radians( _HighsPulseDirection ) );
			float sin456_g479 = sin( radians( _HighsPulseDirection ) );
			float2 rotator456_g479 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos456_g479 , -sin456_g479 , sin456_g479 , cos456_g479 )) + float2( 0.5,0.5 );
			float HighPulse556_g479 = saturate( ( rotator456_g479.y - ( 1.0 - HighBlink464_g479 ) ) );
			float4 lerpResult596_g479 = lerp( lerpResult590_g479 , ( EmissionGlowColor471_g479 * HighPulse556_g479 ) , (float)saturate( ( ReactivityIndexEmission470_g479 - 3 ) ));
			float4 FinalGlowEmission600_g479 = lerpResult596_g479;
			int GlowMaskRIndex48_g479 = _GlowMaskZoneR;
			float2 lerpResult170_g479 = lerp( GradientZone0175_g479 , GradientZone0282_g479 , (float)saturate( GlowMaskRIndex48_g479 ));
			float2 lerpResult216_g479 = lerp( lerpResult170_g479 , GradientZone03122_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 1 ) ));
			float2 lerpResult263_g479 = lerp( lerpResult216_g479 , Zone01138_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 2 ) ));
			float2 lerpResult298_g479 = lerp( lerpResult263_g479 , Zone02188_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 3 ) ));
			float2 lerpResult338_g479 = lerp( lerpResult298_g479 , Zone03224_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 4 ) ));
			float2 lerpResult355_g479 = lerp( lerpResult338_g479 , Zone04291_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 5 ) ));
			float2 GlowMaskZoneRUV376_g479 = lerpResult355_g479;
			float temp_output_424_0_g479 = ( 1.0 - _EnableGlowMaskR );
			float3 lerpResult175_g479 = lerp( DebugGradient1111_g479 , DebugGradient2110_g479 , (float)saturate( GlowMaskRIndex48_g479 ));
			float3 lerpResult233_g479 = lerp( lerpResult175_g479 , DebugGradient3173_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 1 ) ));
			float3 lerpResult305_g479 = lerp( lerpResult233_g479 , DebugZone1195_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 2 ) ));
			float3 lerpResult321_g479 = lerp( lerpResult305_g479 , DebugZone2250_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 3 ) ));
			float3 lerpResult363_g479 = lerp( lerpResult321_g479 , DebugZone3309_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 4 ) ));
			float3 lerpResult387_g479 = lerp( lerpResult363_g479 , DebugZone4332_g479 , (float)saturate( ( GlowMaskRIndex48_g479 - 5 ) ));
			float EnableGlowMaskR682_g479 = temp_output_424_0_g479;
			float3 DebugGlowMaskR397_g479 = saturate( ( lerpResult387_g479 + EnableGlowMaskR682_g479 ) );
			float4 lerpResult633_g479 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneRUV376_g479, 0, 0.0) ) + temp_output_424_0_g479 + StoredTextureTog669_g479 ) ) , float4( DebugGlowMaskR397_g479 , 0.0 ) , DebugSwitch628_g479);
			float2 uv_GlowMaskRGB = i.uv_texcoord * _GlowMaskRGB_ST.xy + _GlowMaskRGB_ST.zw;
			float3 GlowMask605_g479 = (tex2D( _GlowMaskRGB, uv_GlowMaskRGB ).rgb).xyz;
			float4 GlowMaskZoneRColor468_g479 = ( lerpResult633_g479 * _GlowMaskTintR * GlowMask605_g479.x );
			int ReactivityIndexR469_g479 = _ReacitvityR;
			float4 lerpResult539_g479 = lerp( GlowMaskZoneRColor468_g479 , ( GlowMaskZoneRColor468_g479 * LowBlink431_g479 ) , (float)saturate( ReactivityIndexR469_g479 ));
			float4 lerpResult577_g479 = lerp( lerpResult539_g479 , ( GlowMaskZoneRColor468_g479 * LowPulse493_g479 ) , (float)saturate( ( ReactivityIndexR469_g479 - 1 ) ));
			float4 lerpResult588_g479 = lerp( lerpResult577_g479 , ( GlowMaskZoneRColor468_g479 * HighBlink464_g479 ) , (float)saturate( ( ReactivityIndexR469_g479 - 2 ) ));
			float4 lerpResult595_g479 = lerp( lerpResult588_g479 , ( GlowMaskZoneRColor468_g479 * HighPulse556_g479 ) , (float)saturate( ( ReactivityIndexR469_g479 - 3 ) ));
			float4 FinalGlowR599_g479 = lerpResult595_g479;
			int GlowMaskGIndex45_g479 = _GlowMaskZoneG;
			float2 lerpResult155_g479 = lerp( GradientZone0175_g479 , GradientZone0282_g479 , (float)saturate( GlowMaskGIndex45_g479 ));
			float2 lerpResult222_g479 = lerp( lerpResult155_g479 , GradientZone03122_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 1 ) ));
			float2 lerpResult230_g479 = lerp( lerpResult222_g479 , Zone01138_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 2 ) ));
			float2 lerpResult300_g479 = lerp( lerpResult230_g479 , Zone02188_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 3 ) ));
			float2 lerpResult330_g479 = lerp( lerpResult300_g479 , Zone03224_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 4 ) ));
			float2 lerpResult367_g479 = lerp( lerpResult330_g479 , Zone04291_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 5 ) ));
			float2 GlowMaskZoneGUV385_g479 = lerpResult367_g479;
			float temp_output_419_0_g479 = ( 1.0 - _EnableGlowMaskG );
			float3 lerpResult212_g479 = lerp( DebugGradient1111_g479 , DebugGradient2110_g479 , (float)saturate( GlowMaskGIndex45_g479 ));
			float3 lerpResult236_g479 = lerp( lerpResult212_g479 , DebugGradient3173_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 1 ) ));
			float3 lerpResult296_g479 = lerp( lerpResult236_g479 , DebugZone1195_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 2 ) ));
			float3 lerpResult323_g479 = lerp( lerpResult296_g479 , DebugZone2250_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 3 ) ));
			float3 lerpResult354_g479 = lerp( lerpResult323_g479 , DebugZone3309_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 4 ) ));
			float3 lerpResult388_g479 = lerp( lerpResult354_g479 , DebugZone4332_g479 , (float)saturate( ( GlowMaskGIndex45_g479 - 5 ) ));
			float EnableGlowMaskG681_g479 = temp_output_419_0_g479;
			float3 DebugGlowMaskG396_g479 = saturate( ( lerpResult388_g479 + EnableGlowMaskG681_g479 ) );
			float4 lerpResult630_g479 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneGUV385_g479, 0, 0.0) ) + temp_output_419_0_g479 + StoredTextureTog669_g479 ) ) , float4( DebugGlowMaskG396_g479 , 0.0 ) , DebugSwitch628_g479);
			float4 GlowMaskZoneGColor472_g479 = ( lerpResult630_g479 * _GlowMaskTintG * GlowMask605_g479.y );
			int ReactivityIndexG467_g479 = _ReacitvityG;
			float4 lerpResult551_g479 = lerp( GlowMaskZoneGColor472_g479 , ( GlowMaskZoneGColor472_g479 * LowBlink431_g479 ) , (float)saturate( ReactivityIndexG467_g479 ));
			float4 lerpResult564_g479 = lerp( lerpResult551_g479 , ( GlowMaskZoneGColor472_g479 * LowPulse493_g479 ) , (float)saturate( ( ReactivityIndexG467_g479 - 1 ) ));
			float4 lerpResult585_g479 = lerp( lerpResult564_g479 , ( GlowMaskZoneGColor472_g479 * HighBlink464_g479 ) , (float)saturate( ( ReactivityIndexG467_g479 - 2 ) ));
			float4 lerpResult593_g479 = lerp( lerpResult585_g479 , ( GlowMaskZoneGColor472_g479 * HighPulse556_g479 ) , (float)saturate( ( ReactivityIndexG467_g479 - 3 ) ));
			float4 FinalGlowG598_g479 = lerpResult593_g479;
			int GlowMaskBIndex50_g479 = _GlowMaskZoneB;
			float2 lerpResult157_g479 = lerp( GradientZone0175_g479 , GradientZone0282_g479 , (float)saturate( GlowMaskBIndex50_g479 ));
			float2 lerpResult205_g479 = lerp( lerpResult157_g479 , GradientZone03122_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 1 ) ));
			float2 lerpResult262_g479 = lerp( lerpResult205_g479 , Zone01138_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 2 ) ));
			float2 lerpResult311_g479 = lerp( lerpResult262_g479 , Zone02188_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 3 ) ));
			float2 lerpResult336_g479 = lerp( lerpResult311_g479 , Zone03224_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 4 ) ));
			float2 lerpResult370_g479 = lerp( lerpResult336_g479 , Zone04291_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 5 ) ));
			float2 GlowMaskZoneBUV383_g479 = lerpResult370_g479;
			float temp_output_421_0_g479 = ( 1.0 - _EnableGlowMaskB );
			float3 lerpResult197_g479 = lerp( DebugGradient1111_g479 , DebugGradient2110_g479 , (float)saturate( GlowMaskBIndex50_g479 ));
			float3 lerpResult237_g479 = lerp( lerpResult197_g479 , DebugGradient3173_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 1 ) ));
			float3 lerpResult287_g479 = lerp( lerpResult237_g479 , DebugZone1195_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 2 ) ));
			float3 lerpResult339_g479 = lerp( lerpResult287_g479 , DebugZone2250_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 3 ) ));
			float3 lerpResult360_g479 = lerp( lerpResult339_g479 , DebugZone3309_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 4 ) ));
			float3 lerpResult384_g479 = lerp( lerpResult360_g479 , DebugZone4332_g479 , (float)saturate( ( GlowMaskBIndex50_g479 - 5 ) ));
			float EnableGlowMaskB680_g479 = temp_output_421_0_g479;
			float3 DebugGlowMaskB401_g479 = saturate( ( lerpResult384_g479 + EnableGlowMaskB680_g479 ) );
			float4 lerpResult626_g479 = lerp( saturate( ( tex2Dlod( _Stored, float4( GlowMaskZoneBUV383_g479, 0, 0.0) ) + temp_output_421_0_g479 + StoredTextureTog669_g479 ) ) , float4( DebugGlowMaskB401_g479 , 0.0 ) , DebugSwitch628_g479);
			float4 GlowMaskZoneBColor466_g479 = ( lerpResult626_g479 * _GlowMaskTintB * GlowMask605_g479.z );
			int ReactivityIndexB480_g479 = _ReacitvityB;
			float4 lerpResult553_g479 = lerp( GlowMaskZoneBColor466_g479 , ( GlowMaskZoneBColor466_g479 * LowBlink431_g479 ) , (float)saturate( ReactivityIndexB480_g479 ));
			float4 lerpResult574_g479 = lerp( lerpResult553_g479 , ( GlowMaskZoneBColor466_g479 * LowPulse493_g479 ) , (float)saturate( ( ReactivityIndexB480_g479 - 1 ) ));
			float4 lerpResult591_g479 = lerp( lerpResult574_g479 , ( GlowMaskZoneBColor466_g479 * HighBlink464_g479 ) , (float)saturate( ( ReactivityIndexB480_g479 - 2 ) ));
			float4 lerpResult594_g479 = lerp( lerpResult591_g479 , ( GlowMaskZoneBColor466_g479 * HighPulse556_g479 ) , (float)saturate( ( ReactivityIndexB480_g479 - 3 ) ));
			float4 FinalGlowB597_g479 = lerpResult594_g479;
			float4 Emission1488 = ( FinalGlowEmission600_g479 + FinalGlowR599_g479 + FinalGlowG598_g479 + FinalGlowB597_g479 );
			o.Emission = Emission1488.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
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
	CustomEditor "LegendsShaderGUI"
}
/*ASEBEGIN
Version=18906
566;670.6667;1891;724;-3925.61;-4041.198;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;285;12791.42,1480.654;Inherit;False;2194.738;2092.908;Texture Assignment;73;1657;1495;1658;1660;1661;933;1494;1488;1659;1634;1650;1624;1664;1649;1484;1665;1483;1663;1666;1669;1482;1662;1668;1477;1667;1417;1672;1416;1410;33;1113;1412;1409;1299;1689;1411;1473;31;1680;1408;1493;1298;1401;1671;32;1670;1476;1104;354;1406;1407;1405;304;1399;1403;1398;1404;1397;1402;1400;1396;30;29;7;936;935;4;934;5;1564;6;3;2042;Texture Assignment;0.8455408,0.2776789,0.9811321,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;13140.94,1524.81;Inherit;True;Property;_Normal;   Normal;2;1;[Normal];Create;True;0;0;0;False;0;False;None;19d1869b509f6c0489ae08a2b8c8019f;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LightColorNode;1722;11945.65,237.0297;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;283;1316.517,7391.053;Inherit;False;2051.217;3418.291;;9;1521;226;244;111;227;28;87;65;2074;Lighting Styles;0.2658419,0.9716981,0.3154366,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;13422.94,1518.81;Inherit;False;NormalTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;13414.94,1592.81;Inherit;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1564;13450.36,1710.23;Inherit;False;Property;_NormalScale;   Normal Scale;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;1701;12111.12,268.6843;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1703;12093.17,197.1143;Inherit;False;Constant;_Float11;Float 11;45;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;1366.517,7441.052;Inherit;False;1271.911;315.6205;Halftone UVS;10;171;105;63;17;91;170;18;13;19;92;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;1406.677,7601.673;Inherit;False;Property;_HaltoneScale;   Halftone Scale;25;0;Create;False;0;0;0;False;0;False;100;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;13643.12,1517.677;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;1737;12389.62,356.0851;Inherit;False;Constant;_FallbackDir;FallbackDir;44;0;Create;True;0;0;0;False;0;False;0.6,1,-0.3;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FaceVariableNode;934;13936.6,1639.051;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;171;1397.892,7678.642;Inherit;False;Property;_HaltoneRotation;   Halftone Rotation;26;0;Create;False;0;0;0;False;0;False;45;45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1700;12250.01,218.2305;Inherit;False;Property;_Keyword0;Keyword 0;44;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDBASE;Toggle;2;Key0;Key1;Fetch;False;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1718;12582.87,218.6713;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;1407.927,7469.638;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;1637.283,7534.402;Inherit;False;EffectTiling;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;92;1659.461,7625.002;Inherit;False;1;0;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1721;12555.56,286.0972;Inherit;False;isLightMissing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;935;14049.6,1592.051;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1709;12540.61,79.09723;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;1740;12614.52,357.3851;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;170;1827.017,7594.919;Inherit;False;HalftoneRotation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;1889.808,7472.079;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1717;12802.23,181.4534;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1719;12802.45,278.5493;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;936;14203.6,1524.051;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;538;10203.23,518.9999;Inherit;False;2345.553;2830.088;;9;729;943;1655;549;785;352;27;728;2058;Lighting Calculations;1,0.9828576,0.1981132,1;0;0
Node;AmplifyShaderEditor.RotatorNode;91;2040.642,7485.014;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;7;14339.01,1518.999;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1720;12977.23,232.6856;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;10243.15,555.7958;Inherit;False;1514.091;403.2091;Base Lighting Calculation;13;1502;286;1497;23;1444;55;1518;54;56;10;1;9;1711;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;9;10299.15,600.9948;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1710;13103.63,224.859;Inherit;False;LightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FractNode;17;2215.678,7487.672;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;87;1377.725,8110.888;Inherit;False;1908.546;380.3793;SquareEffectLighting;22;86;82;183;81;80;176;83;73;79;78;85;76;84;72;68;71;70;67;69;66;684;1438;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;2329.825,7479.655;Inherit;False;HalftoneUVS;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;1;10455.62,605.7958;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1711;10496.56,752.9788;Inherit;False;1710;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;1425.725,8158.888;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;10;10667.15,606.9948;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;10767.98,820.0058;Inherit;False;Property;_ShadowLength;   Length;13;0;Create;False;0;0;0;False;0;False;2;2.07;0;16;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;10744.47,684.6049;Inherit;False;Property;_ShadowOffset;   Offset;12;0;Create;False;1;Shadow Settings;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1518;11238.62,716.632;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;2;False;4;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;11025.28,604.2538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;69;1601.725,8254.891;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;67;1729.726,8158.888;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;28;1381.502,7760.777;Inherit;False;1159.949;333.3966;CircleEffectLighting;16;64;20;48;47;21;50;14;45;24;16;25;260;178;261;338;1437;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;70;1745.726,8254.891;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;1444;11267.79,593.4709;Inherit;False;ExponentialSquared Blend;-1;;265;28efb435c6e4d7a48baa2d68777a317c;1,7,1;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;68;1889.726,8158.888;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;71;1889.726,8254.891;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;1397.502,7824.777;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;11519.59,590.7639;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;227;1377.725,9246.891;Inherit;False;1892.369;407.7058;4Sided Halftone;17;224;206;221;220;208;216;217;218;219;214;212;213;209;210;211;225;1440;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;286;10761.16,751.5659;Inherit;False;BaseNdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;111;1377.725,8494.891;Inherit;False;1741.949;329.9518;SketchyEffectLighting;19;106;108;107;109;90;104;98;97;99;89;95;100;94;101;102;103;262;291;725;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;1573.502,7824.777;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.5,-0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;72;2033.724,8206.891;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;1413.502,7904.778;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;1864.726,8346.891;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;226;1377.725,8830.891;Inherit;False;1869.667;407.7065;8Sided Halftone;17;194;223;222;195;197;189;200;193;188;184;202;192;199;203;204;205;1439;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;2161.724,8206.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;1724.502,8014.777;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;1407.731,9317.893;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;244;1374.225,9677.591;Inherit;False;1421.734;341.7715;Halftone Hexagon;13;236;234;235;237;231;228;239;232;240;242;241;243;1441;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;1388.884,8653.901;Inherit;False;105;EffectTiling;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;14;1685.502,7824.777;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1437;1579.227,7915.449;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;2283.724,8398.891;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;1399.856,8914.49;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1440;1574.549,9324.935;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;1388.035,9805.591;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;1895.502,8017.777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1438;2074.346,8322.237;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;78;2289.724,8190.889;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.85;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;1559.597,8653.762;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;106;1425.725,8542.891;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;1829.502,7824.777;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;1662.226,9725.591;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;81;2518.656,8292.467;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;20;1973.502,7824.777;Inherit;False;Step Antialiasing;-1;;366;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1441;1545.736,9807.911;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1801;-89.49092,6779.424;Inherit;False;4979.211;414.8498;Lighting Style Selector;43;1753;1758;1759;1763;1769;1760;1761;1757;1755;1775;1768;1754;1756;1771;1777;1770;1762;1774;1780;1784;1788;1782;1776;1773;1779;1781;1793;1786;1789;1797;1785;1794;1790;1783;1787;1795;1791;1798;1796;1799;1792;1800;165;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;1439;1562.132,8918.268;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;261;2021.502,8016.777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;1681.726,8558.891;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;79;2417.724,8190.889;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;237;1736.727,9902.994;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;208;1841.726,9326.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;291;1504.854,8748.17;Inherit;False;170;HalftoneRotation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;212;2145.724,9406.891;Inherit;False;Constant;_Int1;Int 1;11;0;Create;True;0;0;0;False;0;False;4;8;False;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;239;1928.437,9858.794;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;109;1809.726,8558.891;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;73;2561.724,8190.889;Inherit;False;Step Antialiasing;-1;;369;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;228;1838.226,9725.591;Inherit;False;    const float3 k = float3(-0.866025404,0.5,0.577350269)@$    p += -0.5@$    p = abs(p)@$    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy@$    p -= float2(clamp(p.x, -k.z*r, k.z*r), r)@$    return length(p)*sign(p.y)@;1;Create;2;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;0.2;In;;Inherit;False;Hexagon;False;False;1;230;;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;2145.724,9486.891;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;2258.724,9559.891;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;2142.501,7920.777;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;195;1825.726,8925.643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1753;-39.49089,6997.445;Inherit;False;Property;_ShadowStyleIndex;ShadowStyleIndex;59;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;2193.724,9310.891;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;183;2646.656,8292.467;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;213;1976.675,9333.448;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1758;160.9917,6994.115;Inherit;False;ShadowStyleIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;217;2449.724,9486.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;232;2030.224,9725.591;Inherit;False;Step Antialiasing;-1;;370;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;240;2104.631,9828.203;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;214;2385.724,9310.891;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;539;4210.069,4263.341;Inherit;False;1593.346;441.5303;;1;57;Distance Blending;1,0.3679245,0.3679245,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;178;2149.501,7824.777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;193;2177.724,8878.891;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;189;2129.724,8990.891;Inherit;False;Constant;_Int0;Int 0;11;0;Create;True;0;0;0;False;0;False;8;8;False;0;1;INT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;90;1985.726,8558.891;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;2785.724,8190.889;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;2129.724,9070.891;Inherit;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;2198.724,9149.891;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;197;1960.675,8919.087;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;2293.501,7824.777;Inherit;False;CircularEffectLighting;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;184;2369.724,8894.891;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;202;2401.724,9054.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;104;2113.724,8558.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;176;2904.724,8189.889;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;219;2609.724,9470.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;241;2259.428,9736.191;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1763;563.5952,7022.933;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;216;2545.724,9310.891;Inherit;False;Step Antialiasing;-1;;371;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;4260.069,4313.341;Inherit;False;1480.991;334.9148;Distance Blending;11;40;37;38;52;44;36;42;35;34;1453;2081;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1759;214.3462,6829.424;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;203;2529.724,9054.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;34;4305.148,4353.548;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;35;4296.398,4494.389;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1761;248.22,6908.748;Inherit;False;25;CircularEffectLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;2753.724,9390.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1757;372.287,6996.127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;89;2240.108,8558.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1755;787.0906,7026.655;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;2047.535,8646.089;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;3049.724,8185.889;Inherit;False;SquareEffectLighting;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;192;2513.724,8894.891;Inherit;False;Step Antialiasing;-1;;372;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1760;384.289,6834.507;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;352;10237.22,975.0168;Inherit;False;1814.525;400.3383;Specular Calculation;13;351;768;315;316;314;309;307;312;313;383;1446;1448;1712;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;242;2400.022,9738.187;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1769;1120.485,7026.348;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1756;924.9352,7026.655;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1754;561.2324,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;218;2881.724,9374.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1768;705.2324,6939.739;Inherit;False;86;SquareEffectLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;2721.724,8926.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;243;2558.42,9732.789;Inherit;False;HalftoneHexagon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;2334.724,8719.891;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1771;1343.979,7030.07;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1775;1654.516,7027.644;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;313;10263.76,1142.609;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;4554.629,4496.279;Inherit;False;Property;_BlendOffset;   Blend Offset;23;0;Create;True;1;Halftone Settings;0;0;False;0;False;0.25;7.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;36;4559.188,4400.896;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;95;2385.724,8590.891;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;221;3041.724,9358.891;Inherit;False;Halftone4SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1502;11041.46,694.2438;Inherit;False;ShadowOffset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;101;2545.724,8686.891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1770;1481.824,7030.07;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1774;1345.232,6939.739;Inherit;False;243;HalftoneHexagon;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1497;11224.73,874.2529;Inherit;False;ShadowLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2074;1373.757,10034.27;Inherit;False;1475.756;347.8193;Toon Lighting;7;2080;2079;2078;2077;2076;2075;1505;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;94;2513.724,8590.891;Inherit;False;Step Antialiasing;-1;;373;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0.56;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;928;6801.586,7320.029;Inherit;False;3068.318;2460.014;;9;914;896;877;787;740;803;849;774;2063;Rimlight Styles;0.05079699,0,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;312;10433.12,1132.586;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;199;2844.131,8928.69;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1780;2193.232,7035.739;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;4802.699,4404.813;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1762;1121.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;4807.249,4497.576;Inherit;False;Property;_BlendLength;   Blend Length;24;0;Create;True;0;0;0;False;0;False;5;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1521;1357.143,10401.23;Inherit;False;1475.756;347.8193;Half Lambert;8;1532;1529;1527;1526;1525;1524;1522;1534;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;29;13143.59,1873.143;Inherit;True;Property;_MainTex;   MainTex;0;1;[Header];Create;True;1;Main Settings;0;0;False;0;False;None;3424bb82b689c394697955e6c8d83530;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1777;1878.011,7031.366;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1788;1886.993,6948.324;Inherit;False;221;Halftone4SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;2721.724,8590.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1532;1384.705,10451.15;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;10743.64,1033.433;Inherit;False;2;2;0;FLOAT3;2,2,2;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;774;6851.586,7378.458;Inherit;False;1271.911;315.6205;Rimlight Halftone UVS;10;784;783;782;781;780;779;778;777;776;775;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2075;1581.32,10103.2;Inherit;False;286;BaseNdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2077;1461.925,10205.15;Inherit;False;1502;ShadowOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2076;1781.078,10275.02;Inherit;False;1497;ShadowLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1784;2769.232,7035.739;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1712;10724.83,1139.505;Inherit;False;1710;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1773;1665.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1782;2417.232,7035.739;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;205;2997.322,8916.094;Inherit;False;Halftone8SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1453;5038.967,4406.496;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;13437.58,1873.143;Inherit;False;AlbedoTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;1396;13146.74,2237.376;Inherit;True;Property;_Metallic;   Metallic;4;0;Create;True;1;Main Settings;0;0;False;0;False;None;69510a2fd8d44804f82003231feb604d;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SaturateNode;1776;2015.856,7031.366;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2078;2050.868,10115.46;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2079;2024.986,10204.21;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;6;False;4;FLOAT;64;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2082;3139.982,6399.082;Inherit;False;682.3669;239.6001;Blend default lighting at distance;4;2086;2085;2084;2083;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;309;10886.22,1034.955;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;2849.724,8590.891;Inherit;False;SketchyEffectLighting;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;537;22011.91,7221.166;Inherit;False;2377.537;3369.101;;10;1547;518;389;496;474;325;423;449;387;406;Specular Styles;0.03921568,0.6800092,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;776;6882.955,7616.047;Inherit;False;Property;_RimlightHaltoneRotation;   Halftone Rotation;30;0;Create;False;0;0;0;False;0;False;45;-45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;775;6891.743,7539.076;Inherit;False;Property;_RimlightHaltoneScale;   Halftone Scale;29;0;Create;False;0;0;0;False;0;False;100;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1779;2209.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1527;1557.254,10570.02;Inherit;False;1502;ShadowOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1786;2993.232,7035.739;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;5179.829,4405.451;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1781;2561.232,7035.739;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1534;1561.904,10454.4;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;785;10247.19,1591.343;Inherit;False;1852.234;604.5469;Rimlight;25;876;874;802;875;769;872;773;801;871;772;771;738;731;734;737;736;732;735;733;1169;1451;1561;1560;1452;1744;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1789;2451.992,6945.324;Inherit;False;205;Halftone8SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1529;1801.463,10566.97;Inherit;False;1497;ShadowLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1400;13240.09,2425.266;Inherit;False;30;AlbedoTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexelSizeNode;1402;13437.32,2432.16;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;778;7144.524,7562.406;Inherit;False;1;0;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;779;7122.343,7471.807;Inherit;False;RimlightHalftoneTiling;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;735;10296.19,1772.061;Inherit;False;Property;_RimlightRotationAngle;   Rotation Angle;21;0;Create;False;0;0;0;False;0;False;0;-65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;777;6895.592,7416.145;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1783;2753.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1526;1780.253,10456.41;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2081;5382.146,4504.052;Inherit;False;DistanceBlendAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1793;3329.232,7035.739;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1525;2001.369,10572.16;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;2;False;4;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;406;22084.66,10216.91;Inherit;False;1271.911;315.6205;Specular Halftone UVS;10;416;415;414;413;412;411;410;409;408;407;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;1785;3137.232,7035.739;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1404;13632.32,2501.06;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2083;3187.982,6447.082;Inherit;False;23;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;314;11020.39,1025.017;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1398;13437.4,2314.465;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1397;13433.5,2235.165;Inherit;False;MetallicTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;316;11007.29,1094.018;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;733;10356.51,1843.684;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2080;2236.088,10111.31;Inherit;False;ExponentialSquared Blend;-1;;453;28efb435c6e4d7a48baa2d68777a317c;1,7,1;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1790;3019.992,6944.324;Inherit;False;103;SketchyEffectLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2085;3267.982,6527.082;Inherit;False;2081;DistanceBlendAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;781;7374.865,7409.485;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;736;10566.17,1780.3;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1524;2198.472,10457.26;Inherit;False;ExponentialSquared Blend;-1;;454;28efb435c6e4d7a48baa2d68777a317c;1,7,1;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;780;7312.074,7532.322;Inherit;False;RimlightHalftoneRotation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;408;22124.82,10377.53;Inherit;False;Property;_SpecularHaltoneScale;   Halftone Scale;27;0;Create;False;0;0;0;False;0;False;100;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2084;3363.982,6463.082;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1505;2546.849,10107.34;Inherit;False;ToonLighting;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;737;10539.36,1641.343;Inherit;False;Property;_RimlightRotationAxis;   Rotation Axis;22;0;Create;False;0;0;0;False;0;False;0,1,0;0.5,1,-0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;315;11205.99,1034.118;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1797;3889.232,7019.739;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;13908.39,2426.057;Inherit;False;Property;_Smoothness;   Smoothness;6;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1399;13655.8,2244.265;Inherit;True;Property;_TextureSample2;Texture Sample 2;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;1403;13779.22,2502.361;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;407;22116.03,10454.5;Inherit;False;Property;_SpecularHaltoneRotation;   Halftone Rotation;28;0;Create;False;0;0;0;False;0;False;45;45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1787;3329.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1794;3553.232,7035.739;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;732;10516.19,1849.779;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;731;10913.56,1915.599;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;1405;13893.62,2498.46;Inherit;False;isMetallicMissing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;409;22128.67,10254.59;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1798;4113.232,7019.739;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1407;14178.32,2338.56;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;782;7573.167,7422.42;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;734;10786.79,1780.3;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;410;22355.42,10310.25;Inherit;False;SpecularHalftoneTiling;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1522;2449.909,10456.25;Inherit;False;HalfLambert;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;411;22377.6,10400.86;Inherit;False;1;0;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;768;11322.25,1033.93;Inherit;False;BaseSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;383;11231.27,1146.422;Inherit;False;Property;_SpecularOffset;   Offset;15;0;Create;False;0;0;0;False;0;False;0;-0.07;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2086;3651.982,6463.082;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1791;3647.218,6945.382;Inherit;False;1505;ToonLighting;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1795;3697.232,7035.739;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;413;22545.15,10370.77;Inherit;False;SpecularHalftoneRotation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1799;4257.233,7019.739;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;738;11117.12,1838.808;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1792;4185.569,6937.865;Inherit;False;1522;HalfLambert;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;783;7748.208,7425.078;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1796;3889.232,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1406;14396.72,2415.259;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1085;14278.21,7074.256;Inherit;False;2058.924;2246.939;Stylize Attenuation;6;990;976;952;1047;1008;1029;Stylized Attenuation;1,0.4842433,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1448;11516.91,1042.571;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;2.4;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;412;22607.94,10247.93;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;772;11188.65,1926.384;Inherit;False;Property;_RimlightOffset;   Offset;20;0;Create;False;0;0;0;False;0;False;1;-0.27;-1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;414;22758.78,10260.87;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;784;7862.349,7417.061;Inherit;False;RimlightHalftoneUVS;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1800;4449.233,6875.739;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1029;14329.07,8565.839;Inherit;False;1971.675;357.0963;4Sided Shadows;17;1045;1044;1043;1042;1041;1040;1039;1038;1037;1036;1035;1034;1033;1032;1031;1030;1046;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NegateNode;871;11253.14,1776.697;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;952;14332.59,7124.256;Inherit;False;1419.175;345.3966;Circular Shadows;12;967;966;961;959;957;955;972;973;974;970;969;975;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1446;11680.95,1046.649;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;354;14553.67,2407.26;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;387;22071.14,7572.167;Inherit;False;1290.656;323.2999;Halftone Specular Shape Definition;13;361;371;360;370;379;357;422;420;1447;1450;382;1491;1492;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;803;6871.634,7741.111;Inherit;False;1943.27;394.5841;Rimlight Squares;17;824;823;819;818;817;815;814;813;812;811;810;809;808;807;806;805;804;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FractNode;415;22933.82,10263.53;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1452;11410.56,1752.13;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;804;6900.222,7785.276;Inherit;False;784;RimlightHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;684;2539.797,8384.574;Inherit;False;Squares;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;338;1853.674,7921.919;Inherit;False;Circles;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;165;4621.053,6869.56;Inherit;False;SelectedLightingStyle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;361;22097.24,7702.47;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;771;11420.55,1858.713;Inherit;False;Property;_RimlightLength;   Length;19;0;Create;False;0;0;0;False;0;False;2;4.72;0;16;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;351;11847.08,1043.49;Inherit;False;SpecularProduct;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1042;14360.36,8627.383;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;969;14362.89,7263.799;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1047;14335.25,8938.349;Inherit;False;1971.675;357.0963;Hexagonal Shadows;15;1063;1062;1061;1060;1059;1056;1055;1054;1053;1052;1051;1050;1049;1064;1065;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;976;14334.56,7484.203;Inherit;False;1419.175;345.3966;Square Shadows;13;988;987;986;985;984;983;982;981;980;979;978;977;989;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;416;23047.96,10255.51;Inherit;False;SpecularHalftoneUVS;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1451;11554.56,1730.175;Inherit;False;ExponentialSquared Blend;-1;;455;28efb435c6e4d7a48baa2d68777a317c;1,7,1;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;981;14569.04,7531.709;Inherit;False;684;Squares;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;802;11416.38,1647.429;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;325;22070.74,7271.607;Inherit;False;1268.324;293.9796;Default Specular;10;329;353;330;324;323;328;321;1158;1229;355;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;975;14685.07,7179.763;Inherit;False;338;Circles;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1043;14550.04,8628.854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;805;7114.573,7885.111;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;382;22244.63,7801.139;Inherit;False;Property;_SpecularLength;   Length;16;0;Create;False;0;0;0;False;0;False;0;1.25;0;16;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;972;14552.57,7265.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;357;22274.73,7620.299;Inherit;False;351;SpecularProduct;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1063;14366.55,8999.895;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;423;22072.6,8265.855;Inherit;False;1943.27;394.5841;Specular Squares;22;444;442;431;424;441;438;436;435;434;433;430;429;428;427;426;425;1333;1334;1336;1337;1335;1371;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1008;14328.21,8196.371;Inherit;False;1971.675;357.0963;8Sided Shadows;16;1016;1012;1011;1009;1026;1027;1028;1024;1025;1023;1022;1021;1020;1019;1017;1018;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;371;22279.77,7702.274;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;64;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;977;14364.84,7623.745;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;740;8143.447,7370.029;Inherit;False;1419.175;345.3966;Rimlight Cirlces;11;754;751;750;747;746;745;744;743;742;741;786;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;37;5329.828,4362.635;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;424;22101.19,8310.019;Inherit;False;416;SpecularHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;959;14872.59,7188.257;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;355;22090.78,7398.579;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;807;7242.574,7789.111;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;1062;14556.23,9001.363;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;978;14554.53,7625.213;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;801;11772.51,1633.116;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;989;14735.66,7535.643;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;970;14849.07,7300.799;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;806;7258.575,7885.111;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleDivideOpNode;1491;22562.38,7773.957;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;360;22411.21,7691.14;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1009;14359.5,8257.917;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1447;22556.76,7668.697;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1040;14828.17,8662.182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1039;14967.02,8660.826;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1011;14549.17,8259.386;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;425;22315.54,8409.855;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;741;8189.447,7427.029;Inherit;False;784;RimlightHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;773;11902.74,1637.214;Inherit;False;Rimlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;982;14874.56,7548.203;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;809;7402.575,7789.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1065;14930.39,9058.019;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;808;7402.575,7885.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;961;15016.59,7188.257;Inherit;False;Step Antialiasing;-1;;456;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;5515.029,4363.319;Inherit;False;DistanceBlend;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1492;22704.38,7751.957;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.99;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;849;6885.769,8150.51;Inherit;False;1835.949;336.9518;SketchyEffectLighting;17;862;861;860;858;857;856;855;853;854;852;851;868;867;850;866;865;864;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;370;22703.63,7663.257;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;973;15037.57,7293.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1054;14819.87,8985.057;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LightAttenuation;983;14851.04,7660.745;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1229;22265.9,7400.847;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.935;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;864;6911.928,8305.521;Inherit;False;779;RimlightHalftoneTiling;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1027;14827.31,8292.714;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1060;15377.94,9155.792;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;810;7546.575,7837.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1046;15225.99,8657.665;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;420;22824.45,7787.91;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;353;22300.15,7317.58;Inherit;False;768;BaseSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1035;15139.3,8811.615;Inherit;False;Constant;_Float7;Float 7;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;985;15018.56,7548.203;Inherit;False;Step Antialiasing;-1;;457;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;329;22434.93,7404.455;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;427;22459.53,8409.855;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1037;15187.3,8619.615;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;743;8221.446,7506.027;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;449;22071.1,8670.127;Inherit;False;2018.848;339.0517;Specular Lines;23;467;465;463;470;461;458;457;460;459;456;455;453;454;451;452;450;1343;1372;1345;1340;1341;1342;1339;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;426;22443.53,8313.855;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;744;8243.855,7587.525;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;389;22069.54,7907.707;Inherit;False;1585.96;352.4688;Circular Halftone Specular;17;1255;404;1265;378;1368;1326;1332;397;401;1328;398;395;396;391;393;394;390;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;1036;15139.3,8731.615;Inherit;False;Constant;_Int7;Int 7;11;0;Create;True;0;0;0;False;0;False;4;8;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;742;8427.444,7434.029;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.5,-0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1169;11554.76,2114.767;Inherit;False;Constant;_Float10;Float 10;26;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;984;15039.53,7653.213;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;725;2377.089,8522.066;Inherit;False;Lines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;966;15222.4,7187.534;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1450;22856.19,7654.665;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;990;14332.83,7843.567;Inherit;False;1419.175;345.3966;Line Shadows;13;1003;1002;1001;1000;999;998;997;996;995;994;993;992;991;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;876;11309.82,2111.531;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1064;15261.47,9001.295;Inherit;False;    const float3 k = float3(-0.866025404,0.5,0.577350269)@$    p += -0.5@$    p = abs(p)@$    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy@$    p -= float2(clamp(p.x, -k.z*r, k.z*r), r)@$    return length(p)*sign(p.y)@;1;Create;2;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;0.2;In;;Inherit;False;Hexagon;False;False;1;230;;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;746;8536.742,7507.527;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1028;14966.16,8291.357;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;994;14567.32,7891.075;Inherit;False;725;Lines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;875;11587.3,2004.39;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;865;7161.64,8309.38;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1038;15379.3,8635.615;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;812;7674.575,7837.111;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1158;22575.82,7321.078;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1025;15186.44,8250.147;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;428;22603.53,8313.855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;390;22115.55,7964.707;Inherit;False;416;SpecularHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1053;15570.16,9026.35;Inherit;False;Step Antialiasing;-1;;458;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1045;15371.75,8783.281;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1059;15591.13,9131.362;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;23043.06,7665.511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1022;15138.44,8442.148;Inherit;False;Constant;_Float6;Float 6;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;22583.45,7393.233;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;128;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;745;8539.443,7434.029;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1802;12842.78,6451.536;Inherit;False;4979.211;414.8498;Stylized Attenuation Selector;43;1844;1842;1841;1840;1838;1837;1836;1834;1833;1832;1830;1829;1828;1827;1826;1825;1824;1822;1821;1819;1818;1817;1816;1815;1814;1812;1811;1810;1807;1806;1846;1079;1080;1082;1084;1083;1081;1847;1848;1850;1849;1077;1851;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;986;15224.36,7547.479;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;450;22082.26,8829.138;Inherit;False;410;SpecularHalftoneTiling;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;974;15364.57,7185.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;429;22603.53,8409.855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;866;7027.769,8198.51;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;991;14363.13,7983.109;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;1023;15138.44,8362.148;Inherit;False;Constant;_Int6;Int 6;11;0;Create;True;0;0;0;False;0;False;8;8;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;896;6924.574,8918.958;Inherit;False;1892.369;407.7058;4Sided Halftone;13;912;909;907;905;904;903;902;901;900;899;898;897;913;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;393;22353.54,7971.707;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.5,-0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;1024;15378.44,8266.147;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1031;15563.97,8653.84;Inherit;False;Step Antialiasing;-1;;459;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;967;15535.41,7181.659;Inherit;False;CircularShadows;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1049;15775.96,9025.627;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;867;7283.769,8214.51;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;850;7106.896,8403.788;Inherit;False;780;RimlightHalftoneRotation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;769;11869.09,2033.307;Inherit;False;BaseRimlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1897;6022.961,6764.2;Inherit;False;4979.211;414.8498;Stylized Rimlight Selector;42;1939;1938;1937;1935;1934;1933;1929;1928;1926;1923;1922;1920;1918;1917;1916;1913;1911;1910;1907;1906;1905;1901;1900;1899;1941;1942;1943;1944;1945;1946;1947;1948;792;800;794;788;790;793;789;791;1562;796;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;996;14733.4,7895.953;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1851;13090.05,6671.106;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;747;8683.444,7434.029;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1030;15584.94,8758.853;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;430;22747.53,8361.855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;815;7802.573,7821.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;452;22119.1,8718.127;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;898;6988.377,8986.059;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;987;15366.53,7545.213;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1493;13248.8,2791.12;Inherit;False;30;AlbedoTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;451;22310.96,8828.997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;328;22736.63,7310.874;Inherit;False;return GGXTerm(nh, roughness)@;1;Create;2;True;nh;FLOAT;0;In;;Inherit;False;True;roughness;FLOAT;0;In;;Inherit;False;RoughnessCalc;False;True;0;;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1016;15370.89,8413.814;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1408;13139.22,2600.121;Inherit;True;Property;_Occlusion;   Occlusion;7;0;Create;True;1;Main Settings;0;0;False;0;False;None;69510a2fd8d44804f82003231feb604d;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;1806;13495.87,6695.045;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;877;6925.21,8495.333;Inherit;False;1869.667;407.7065;8Sided Halftone;13;894;892;890;888;887;886;885;884;883;882;881;880;878;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;813;7560.461,7961.636;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;914;6930.16,9341.22;Inherit;False;1421.734;341.7715;Halftone Hexagon;9;927;926;922;921;919;918;917;916;915;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;321;22733.12,7402.768;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;379;23167.57,7661.952;Inherit;False;HalftoneSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;992;14552.81,7984.58;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;395;22465.54,7971.707;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1811;13719.36,6698.766;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;22987.92,7330.086;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1846;13230.22,6502.795;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;917;7125.159,9378.22;Inherit;False;784;RimlightHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;997;14872.83,7907.567;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1050;15918.13,9023.362;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;454;22198.22,8923.405;Inherit;False;413;SpecularHalftoneRotation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;453;22375.1,8734.127;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;1810;13304.56,6668.239;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1941;6059.416,6985.878;Inherit;False;Property;_RimlightStyleIndex;RimlightStyleIndex;58;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;751;8837.221,7535.26;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1807;14052.76,6698.46;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;817;7930.573,7821.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;900;7388.573,8998.958;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;998;14849.32,8020.109;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;868;7411.768,8214.51;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;433;22875.53,8361.855;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1079;13220.31,6579.065;Inherit;False;967;CircularShadows;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1018;15584.08,8389.384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;750;8827.441,7434.029;Inherit;False;Step Antialiasing;-1;;462;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1032;15769.77,8653.118;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;988;15537.37,7541.604;Inherit;False;SquareShadows;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1017;15563.11,8284.372;Inherit;False;Step Antialiasing;-1;;461;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1411;13417.4,2667.722;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;916;7008.969,9466.22;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1409;13426.5,2594.922;Inherit;False;OcclusionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;878;7059.14,8565.933;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;391;22155.55,8051.707;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;496;22076.7,9443.333;Inherit;False;1892.369;407.7058;4Sided Halftone;18;513;509;508;506;505;504;503;501;500;499;497;1357;1374;1359;1354;1356;1355;1353;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;818;8090.846,7916.411;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1080;13776.58,6602.29;Inherit;False;988;SquareShadows;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1816;14276.25,6702.182;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1328;22481.74,8149.322;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;455;22503.1,8734.127;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1942;6264.416,6982.878;Inherit;False;RimlightStyleIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;324;23131.44,7325.521;Inherit;False;DefaultSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1812;14586.79,6699.756;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;819;8074.575,7821.111;Inherit;False;Step Antialiasing;-1;;466;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;902;7692.573,9158.958;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1019;15768.91,8283.649;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;436;23003.53,8345.855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2046;12718.75,691.1246;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1815;13857.21,6698.767;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;999;15016.83,7907.567;Inherit;False;Step Antialiasing;-1;;465;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;882;7373.21,8590.085;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1410;13624.11,2597.521;Inherit;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;901;7523.521,9005.514;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1814;13493.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;904;7685.973,8958.258;Inherit;False;784;RimlightHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;919;7394.16,9389.22;Inherit;False;    const float3 k = float3(-0.866025404,0.5,0.577350269)@$    p += -0.5@$    p = abs(p)@$    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy@$    p -= float2(clamp(p.x, -k.z*r, k.z*r), r)@$    return length(p)*sign(p.y)@;1;Create;2;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;0.2;In;;Inherit;False;Hexagon;False;False;1;230;;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;398;22728.54,7972.973;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;754;9186.243,7433.304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;903;7692.573,9078.958;Inherit;False;Constant;_Int5;Int 5;11;0;Create;True;0;0;0;False;0;False;4;8;False;0;1;INT;0
Node;AmplifyShaderEditor.OneMinusNode;1000;15037.81,8012.58;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1051;16088.97,9019.752;Inherit;False;HexagonalShadows;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1033;15911.94,8650.853;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;518;22076.37,9861.771;Inherit;False;1421.734;341.7715;Halftone Hexagon;14;531;528;525;523;522;520;519;1364;1375;1366;1361;1363;1362;1360;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;474;22077,9021.351;Inherit;False;1869.667;407.7065;8Sided Halftone Specular;18;491;487;486;484;483;481;480;479;478;477;475;1352;1350;1373;1347;1348;1349;1346;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;22777.95,8463.505;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;497;22140.5,9510.437;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1412;13638.4,2786.022;Inherit;False;Property;_OcclusionPower;   Occlusion Power;8;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;851;7587.768,8214.51;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;438;23131.53,8345.855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;519;22090.18,9989.771;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;729;10268.55,1397.536;Inherit;False;785.5322;163.8323;Indirect Diffuse Light;4;1419;1420;726;727;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;501;22540.69,9523.333;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;905;7932.574,8982.958;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1034;16082.78,8647.243;Inherit;False;StarShadows2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1817;14810.28,6703.477;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;922;7608.663,9489.624;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;401;22895.03,7965.543;Inherit;False;Step Antialiasing;-1;;468;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;883;7677.21,8655.333;Inherit;False;Constant;_Int4;Int 4;11;0;Create;True;0;0;0;False;0;False;8;8;False;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;522;22364.37,9909.771;Inherit;False;63;HalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;885;7677.21,8735.333;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1020;15911.08,8281.383;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1416;13930.9,2648.222;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1332;22717.85,8145.088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1993;20689.38,6541.498;Inherit;False;4438.35;402.7634;Stylized Rimlight Selector;37;388;1995;1994;2033;2031;2030;2025;2024;2023;2021;2020;2019;2015;2014;2013;2011;2010;2009;2006;2005;2004;2001;2000;1472;386;448;535;517;492;468;1546;2036;2037;2038;2039;2040;2041;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;1818;14414.1,6702.182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;886;7677.21,8535.333;Inherit;False;784;RimlightHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;792;6307.368,6813.027;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1001;15222.64,7906.842;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1082;14310.94,6610.562;Inherit;False;1051;HexagonalShadows;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;456;22679.1,8734.127;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1899;6676.051,7007.708;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;852;7715.768,8214.51;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1333;22992.01,8554.175;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;475;22140.64,9140.702;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;2047;12875.75,691.1246;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;1819;14053.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1821;15125.5,6707.85;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;22655.21,8066.72;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;786;9332.787,7428.062;Inherit;False;CircularRimlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;823;8461.269,7824.039;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;921;7586.16,9389.22;Inherit;False;Step Antialiasing;-1;;467;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;887;7508.159,8583.529;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;479;22487.55,9149.804;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1822;15701.5,6707.85;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;824;8599.312,7819.174;Inherit;False;SquareRimlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;856;7842.153,8214.51;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1335;23243.86,8562.228;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1994;20725.84,6763.176;Inherit;False;Property;_SpecularStyleIndex;SpecularStyleIndex;57;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;907;8138.373,9112.357;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;503;22844.69,9603.333;Inherit;False;Constant;_Int3;Int 3;11;0;Create;True;0;0;0;False;0;False;4;8;False;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;727;10312.33,1429.819;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;1002;15364.81,7904.58;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1326;23127.1,7971.723;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1360;22398.89,10106.02;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1368;22897.86,8059.454;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;441;23275.53,8345.855;Inherit;False;Step Antialiasing;-1;;470;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1825;14948.13,6703.477;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;800;6487.274,6816.469;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;2048;13055.75,691.1246;Inherit;False;half4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, uvw, 5)@ //('cubemap', 'sample coordinate', 'map-map level')$         half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR)@$         return half4(skyColor, 1.0)@;3;Create;1;True;uvw;FLOAT3;0,0,0;In;;Inherit;False;CustomReflectionProbeSample;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1084;14829.4,6624.737;Inherit;False;1034;StarShadows2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;888;7917.21,8559.333;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;909;8092.575,8982.958;Inherit;False;Step Antialiasing;-1;;469;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;505;22844.69,9683.333;Inherit;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1561;11535.7,1925.988;Inherit;False;RimlightOffset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;525;22540.37,9909.771;Inherit;False;    const float3 k = float3(-0.866025404,0.5,0.577350269)@$    p += -0.5@$    p = abs(p)@$    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy@$    p -= float2(clamp(p.x, -k.z*r, k.z*r), r)@$    return length(p)*sign(p.y)@;1;Create;2;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;0.2;In;;Inherit;False;Hexagon;False;False;1;230;;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1336;23183.92,8487.559;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1417;14075.21,2644.322;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;459;22807.1,8734.127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;926;7973.365,9403.821;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;504;22838.09,9482.634;Inherit;False;416;SpecularHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1826;14597.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;872;11186.27,1995.165;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;794;6420.036,6892.286;Inherit;False;786;CircularRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2063;8368.064,9350.355;Inherit;False;1475.756;347.8193;Toon Rimlight;11;2073;2072;2071;2070;2069;2068;2067;2066;2065;2064;1559;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;854;7683.14,8302.235;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1021;16081.92,8277.774;Inherit;False;StarShadows1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;506;22675.64,9529.892;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1901;6484.74,6980.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1943;7222.448,7009.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1824;15349.5,6707.85;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;378;22870.4,8169.918;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1900;6899.541,7011.429;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1906;7037.391,7011.43;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;912;8395.469,9020.057;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;484;22800.59,9096.899;Inherit;False;416;SpecularHalftoneUVS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1420;10502.38,1495.601;Inherit;False;1417;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;480;22791.55,9215.052;Inherit;False;Constant;_Int2;Int 2;11;0;Create;True;0;0;0;False;0;False;8;8;False;0;1;INT;0
Node;AmplifyShaderEditor.AbsOpNode;460;22927.1,8735.127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1827;15141.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;481;22622.5,9143.247;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.25;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1744;11078.05,2075.687;Inherit;False;BaseRimlightForToon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;857;7987.767,8252.51;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;884;8068.154,8659.619;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1362;22650.74,10114.07;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1265;23272,7971.993;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1353;22900.49,9741.222;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1371;23436.8,8467.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;483;22791.55,9295.052;Inherit;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1830;15925.5,6707.85;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1560;11721.88,1831.224;Inherit;False;RimlightLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1995;20930.84,6760.176;Inherit;False;SpecularStyleIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1907;7456.431,7014.845;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1363;22590.8,10039.41;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;528;22775.32,9913.095;Inherit;False;Step Antialiasing;-1;;471;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1944;7742.448,7006.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;15425.15,6616.012;Inherit;False;1021;StarShadows1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1905;6673.681,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1003;15535.65,7900.967;Inherit;False;LineShadows;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;508;23084.69,9507.333;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;726;10474.44,1432.35;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;927;8114.354,9396.418;Inherit;False;RimlightHexagon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1828;15493.5,6707.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1337;23495.11,8343.061;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2049;13326.22,686.3169;Inherit;False;CustomProbe;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1334;23405.91,8577.257;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;788;6976.007,6929.187;Inherit;False;824;SquareRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;890;8061.209,8559.333;Inherit;False;Step Antialiasing;-1;;472;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2064;8386.176,9512.146;Inherit;False;1561;RimlightOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2062;16163.7,6882.755;Inherit;False;1497;ShadowLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1910;7594.28,7014.845;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;457;22721.9,8823.325;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2055;10931.61,1441.697;Inherit;False;2049;CustomProbe;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;404;23403.3,7965.446;Inherit;False;CircularSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1945;8262.448,7055.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1419;10711.38,1446.601;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1364;22959.19,9907.907;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1913;7233.681,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;913;8564.362,9022.164;Inherit;False;Rimlight4SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;442;23661.88,8349.69;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;860;8115.768,8252.51;Inherit;False;Step Antialiasing;-1;;475;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0.56;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1833;16069.5,6707.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1911;7990.461,7016.14;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1081;15959.56,6629.118;Inherit;False;1003;LineShadows;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1829;16261.5,6707.85;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2067;8775.386,9591.104;Inherit;False;1560;RimlightLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;509;23244.69,9507.333;Inherit;False;Step Antialiasing;-1;;474;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2066;8590.079,9514.712;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;5;False;3;FLOAT;0.3;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2092;16022.98,6125.718;Inherit;False;682.3669;239.6001;Blend default lighting at distance;3;2095;2094;2093;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1356;23092.4,9674.604;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1355;23152.34,9749.272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;470;23051.73,8728.799;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;858;8112.099,8347.14;Inherit;False;769;BaseRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;486;23031.55,9119.052;Inherit;False;    // next 4 lines can be precomputed for a given shape$p += -0.5@$p = abs(p)@$    float an = 3.141593/float(n)@$    float en = 3.141593/m@  // m is between 2 and n$    float2  acs = float2(cos(an),sin(an))@$    float2  ecs = float2(cos(en),sin(en))@ // ecs=float2(0,1) for regular polygon$$    float bn = fmod(atan2(p.x,p.y),2.0*an) - an@$    p = length(p)*float2(cos(bn),abs(sin(bn)))@$    p -= r*acs@$    p += ecs*clamp( -dot(p,ecs), 0.0, r*acs.y/ecs.y)@$    return length(p)*sign(p.x)@;1;Create;4;True;p;FLOAT2;0,0;In;;Inherit;False;True;r;FLOAT;2.75;In;;Inherit;False;True;n;INT;5;In;;Inherit;False;True;m;FLOAT;2;In;;Inherit;False;RegularStar;False;False;0;;False;4;0;FLOAT2;0,0;False;1;FLOAT;2.75;False;2;INT;5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1361;22812.79,10129.1;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1375;22864.77,10000;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2036;21326.59,6777.041;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1836;15685.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;892;8269.207,8591.333;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2065;8575.628,9419.282;Inherit;False;1744;BaseRimlightForToon;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1346;22904.02,9312.636;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;790;7505.355,6935.579;Inherit;False;927;RimlightHexagon;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1670;14357.54,1803.801;Inherit;False;Property;_Workflow;Workflow;60;1;[Enum];Create;True;0;2;Metallic;0;Specular;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;386;21094.57,6667.249;Inherit;False;404;CircularSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2000;21565.96,6788.727;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;487;23175.55,9119.052;Inherit;False;Step Antialiasing;-1;;476;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1349;23095.93,9246.019;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;2093;16172.07,6172.089;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;463;23206.49,8759.626;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;861;8323.768,8246.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2037;21890.11,6783.085;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1847;16403.07,6612.18;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1917;8128.31,7016.14;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1374;23365.65,9654.224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;793;8022.66,6930.675;Inherit;False;913;Rimlight4SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1339;22998.47,8917.979;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1472;21102.81,6586.938;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1918;7777.681,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2094;16176.04,6244.519;Inherit;False;2081;DistanceBlendAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;444;23800.27,8343.918;Inherit;False;SquareSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2068;9045.176,9431.545;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1946;8850.448,7046.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2001;21151.16,6758.2;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1354;23314.39,9764.304;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1366;23102.97,9924.339;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2060;16588.7,6887.755;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;1;False;4;FLOAT;0.66;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1348;23155.87,9320.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;894;8544.812,8580.536;Inherit;False;Rimlight8SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1104;13974.02,2266.971;Inherit;False;Property;_MetallicVal;   Metallic;5;0;Create;False;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1476;13962.26,2237.89;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1834;16485.51,6707.85;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1837;16261.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2056;11204.88,1438.501;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1832;16821.5,6691.85;Inherit;False;1758;ShadowStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2061;16395.7,6886.755;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;0.5;False;4;FLOAT;0.65;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2069;9019.293,9520.295;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;3;FLOAT;6;False;4;FLOAT;32;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1916;8529.683,7020.513;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1357;23449.09,9509.306;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2070;9338.428,9614.872;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1848;16623.79,6596.61;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;1849;16988.41,6602.229;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;465;23351.19,8762.227;Inherit;False;Step Antialiasing;-1;;478;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2059;10934.28,1508.789;Inherit;False;1721;isLightMissing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1671;14503.54,1803.801;Inherit;False;Workflow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1922;9105.683,7020.513;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;448;21642.87,6698.845;Inherit;False;444;SquareSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;13435.58,1942.143;Inherit;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1920;8321.683,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1840;17045.5,6691.85;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;7;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1347;23317.92,9335.718;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1838;16629.5,6707.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2005;21340.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1350;23430.52,9123.62;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1401;14249.08,2191.786;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1359;23604.56,9559.536;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1373;23364.23,9230.181;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2006;21703.81,6788.728;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;789;8564.579,6932.504;Inherit;False;894;Rimlight8SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2004;22122.85,6792.143;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2038;22424.93,6801.213;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1341;23250.33,8926.03;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1342;23190.39,8851.362;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2095;16534.98,6187.021;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1923;8673.683,7020.513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;862;8451.768,8246.51;Inherit;False;RimlightLines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2057;11322.34,1436.51;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.5,0.5,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;2087;9209.799,6415.179;Inherit;False;682.3669;239.6001;Blend default lighting at distance;4;2091;2090;2089;2088;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;531;23260.56,9916.968;Inherit;False;SpecularHexagon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2071;9230.395,9427.395;Inherit;False;ExponentialSquared Blend;-1;;477;28efb435c6e4d7a48baa2d68777a317c;1,7,1;2;12;FLOAT;0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1947;9401.448,7068.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2010;22656.88,6793.438;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1926;8865.683,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1340;23412.37,8941.062;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;535;22192.7,6712.147;Inherit;False;531;SpecularHexagon;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1473;14397.66,2193.09;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2011;22260.7,6792.143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1352;23608.09,9130.95;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1929;9249.683,7020.513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1343;23567.87,8752.364;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1372;23431.11,8854.517;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;31;13656.19,1879.434;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2058;11463.89,1407.978;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1547;23516.28,9866.315;Inherit;False;791.5913;277.0374;ToonSpecular;6;1543;1542;1538;1545;1544;1539;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2039;22950.68,6793.66;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1850;17164.84,6582.558;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2088;9250.465,6454.83;Inherit;False;773;Rimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1842;17189.5,6691.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1841;16821.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2009;21900.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1298;13704.38,2065.93;Inherit;False;Property;_Color;   Color;1;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;513;23738.09,9582.634;Inherit;False;Specular4SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1680;14406.95,2316.76;Inherit;False;1671;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2072;9640.612,9551.793;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;9167.141,6934.229;Inherit;False;862;RimlightLines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1543;23569.1,9916.315;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2090;9427.8,6467.179;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2089;9343.579,6553.69;Inherit;False;2081;DistanceBlendAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1844;17381.5,6547.85;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;943;11798.43,587.8798;Inherit;False;806.6416;384.319;Light Color;10;1706;942;941;939;1086;2050;2051;2052;2053;2054;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;549;10253.77,2227.298;Inherit;False;1595.64;639.9946;IndirectSpecular;17;541;1418;543;542;548;547;1390;1196;1226;1225;1369;1370;1112;546;1117;545;544;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1538;23566.28,9991.071;Inherit;False;379;HalftoneSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1689;14595.33,2191.678;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1928;9665.692,7020.513;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2014;22794.73,6793.438;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1559;9651.569,9418.432;Inherit;False;ToonRimlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2040;23533.85,6783.084;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;491;23719.37,9131.312;Inherit;False;Specular8SidedStar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1345;23717.75,8757.193;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2013;23196.1,6797.811;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1935;9441.683,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2015;22444.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1948;9978.448,7064.02;Inherit;False;1942;RimlightStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;728;11751.98,1399.183;Inherit;False;IndirectDiffuse;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;517;22692.54,6704.369;Inherit;False;513;Specular4SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1299;13996.38,1883.929;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1225;10296.6,2646.146;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1933;9809.683,7020.513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1369;10279.77,2498.378;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1113;14756.49,2185.774;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;14153.5,1876.744;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2019;23340.1,6797.811;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2091;9721.799,6476.481;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1562;9761.18,6924.309;Inherit;False;1559;ToonRimlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2050;11822.05,830.184;Inherit;False;728;IndirectDiffuse;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2020;23772.1,6797.811;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1934;10225.68,7004.513;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1077;17567.51,6544.854;Inherit;False;StylizedAttenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;492;23243.39,6711.942;Inherit;False;491;Specular8SidedStar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;467;23924.53,8772.347;Inherit;False;LinesSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1539;23798.47,10004.35;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1655;10272.28,2890.455;Inherit;False;1425.59;405.6421;Metallic/Specular Calcs;12;1310;1311;1377;1684;1682;1683;1308;1306;1307;1692;1693;1694;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;2021;22988.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2051;12048.88,881.0269;Inherit;False;2049;CustomProbe;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1544;23794.67,9913.862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2023;23916.1,6797.811;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1370;10487.77,2495.378;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.05;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1226;10486.6,2651.146;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.4;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1308;10329.29,3029.921;Inherit;False;1113;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2041;24092.85,6787.617;Inherit;False;1995;SpecularStyleIndex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1937;10369.68,7004.513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;468;23821.89,6704.136;Inherit;False;467;LinesSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1542;23950.26,9922.862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;939;11851.16,642.1308;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;2025;23532.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2098;23796.38,6194.374;Inherit;False;682.3669;239.6001;Blend default lighting at distance;3;2099;2097;2096;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1306;10330.43,2957.999;Inherit;False;33;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1112;10448.58,2401.302;Inherit;False;1113;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;546;10521.97,2293.221;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1938;10001.68,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1086;11815.7,759.0888;Inherit;False;1077;StylizedAttenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2052;12252.81,833.507;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;941;12063.8,659.894;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1545;24096.87,9942.288;Inherit;False;ToonSpecular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;545;10691.1,2299.522;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;1672;13976.13,2151.079;Inherit;False;Specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DiffuseAndSpecularFromMetallicNode;1307;10527.52,2985.299;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;3;FLOAT3;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2054;12395.04,836.7031;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.5,0.5,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1939;10561.68,6860.513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2024;24332.12,6797.811;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2031;24108.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1117;10698.32,2432.629;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.05;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2097;23942.16,6241.427;Inherit;False;324;DefaultSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2096;23954.38,6332.613;Inherit;False;2081;DistanceBlendAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1196;10684.08,2597.249;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2053;11818.02,896.1652;Inherit;False;1721;isLightMissing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1418;11000.95,2732.345;Inherit;False;1417;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1706;12216.04,664.6469;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;1667;12914.84,3211.496;Inherit;False;Property;_EmissionPanSpeed;Emission Pan Speed;63;0;Create;False;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;2099;24308.38,6255.675;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1546;24395.52,6711.732;Inherit;False;1545;ToonSpecular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;543;10983.91,2657.586;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;796;10739.58,6850.46;Inherit;False;SelectedRimlightStyle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;544;10963.36,2431.857;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.15;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;542;10997.37,2584.389;Inherit;False;7;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1682;10484.66,3135.806;Inherit;False;1672;Specular;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1377;10920.52,3292.569;Inherit;False;Reflectivity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1692;10462.53,3210.636;Inherit;False;1405;isMetallicMissing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2030;24476.1,6797.811;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1668;12884.79,3113.831;Inherit;False;Property;_EmissionPan;Enable Emission Panning;62;1;[ToggleUI];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1477;12873.76,2903.898;Inherit;True;Property;_Emission;   Emission;10;0;Create;True;1;Main Settings;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SaturateNode;1390;11187.14,2436.733;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1693;10776.53,3154.636;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;541;11208.89,2588.285;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;1662;13173.13,3302.286;Inherit;True;Property;_EmissionMask;   Emission Mask;9;0;Create;True;1;Main Settings;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1669;13201.83,3107.82;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;2033;24668.1,6637.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1391;9106.396,-1607.811;Inherit;False;1377;Reflectivity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;942;12382.27,666.101;Inherit;False;AttenuatedLightColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1482;13147.62,2969.298;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1315;9345.32,-1683.588;Inherit;False;796;SelectedRimlightStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;1666;13428.71,2971.09;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1483;13156.72,2896.498;Inherit;False;EmissionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;388;24851.58,6629.629;Inherit;False;SelectedSpecularStyle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1379;9582.077,-1676.733;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;547;11429.68,2438.094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1665;13406.12,3370.444;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1383;9560.112,-1573.102;Inherit;False;354;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1694;10958.21,3128.674;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1395;9414.396,-1602.811;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.15;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1684;10936.69,3221.76;Inherit;False;1671;Workflow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1386;9487.397,-1754.962;Inherit;False;942;AttenuatedLightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1663;13416.13,3294.286;Inherit;False;EmissionMaskTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;1664;13636.39,3298.013;Inherit;True;Property;_TextureSample5;Texture Sample 5;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1314;9739.896,-2010.388;Inherit;False;388;SelectedSpecularStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1649;13688.61,3087.361;Inherit;False;Property;_EmissionColor;   Emission Color;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1382;9751.112,-1572.102;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1389;9768.026,-1865.315;Inherit;False;Property;_SpecularTint;   Specular Tint;14;1;[HDR];Create;True;1;Specular Settings;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1301;9757.529,-2087.679;Inherit;False;942;AttenuatedLightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1484;13635.82,2902.279;Inherit;True;Property;_TextureSample4;Texture Sample 4;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1683;11145.69,3094.76;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1321;9750.652,-1686.931;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;548;11566.61,2434.947;Inherit;False;IndirectSpecular;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1388;9674.248,-1480.145;Inherit;False;Property;_RimlightTint;   Rimlight Tint;17;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.3962264,0.1634876,0.05606977,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1300;9765.933,-2165.339;Inherit;False;165;SelectedLightingStyle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1319;9747.982,-1938.602;Inherit;False;942;AttenuatedLightColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1317;10015.03,-1986.595;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1311;11330,3091.2;Inherit;False;SpecColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1310;11334.86,2978.526;Inherit;False;MetAlbedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1316;9992.177,-1492.132;Inherit;False;548;IndirectSpecular;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;1634;13937.29,2757.361;Inherit;True;Global;_Stored;_Stored;18;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1624;13956.72,3073.217;Inherit;True;Property;_GlowMaskRGB;   Glow Mask;33;1;[Header];Create;False;1;Luma Glow 2;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1376;10008.37,-1607.972;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1650;13954.28,2947.912;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1303;10008.95,-2158.321;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1302;10009.29,-2058.33;Inherit;False;728;IndirectDiffuse;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1494;14354.73,1882.213;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1312;10184.68,-2240.787;Inherit;False;1310;MetAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1304;10239.66,-2157.315;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1659;14290.16,2925.887;Inherit;False;LumaGlowFunction;34;;479;b17985a035b3ebb42b5dfc7fc9435eb2;0;3;618;SAMPLER2D;0;False;612;FLOAT3;0,0,0;False;611;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;10295.59,-1875.829;Inherit;False;1311;SpecColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1320;10294.88,-1997.582;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1235;15072.44,1469.517;Inherit;False;895.8398;535.298;Outline;7;932;931;1743;929;1132;930;2043;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1322;10441.4,-2000.582;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1488;14566.64,2920.853;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1305;10409.94,-2175.49;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1495;14468,1945.865;Inherit;False;AlbedoAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2044;14796.45,1673.029;Inherit;False;Property;_MaskClip;Mask Clip Value;61;0;Create;False;0;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1657;14358.4,1631.335;Inherit;False;Property;_SettingsMode;   Mode;65;1;[Enum];Create;False;0;3;Main Settings;3;Lighting Settings;0;Luma Glow Settings;2;0;True;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;933;14588.8,1531.665;Inherit;False;Property;_Culling;   Culling;66;2;[Header];[Enum];Create;True;0;3;Back;2;Front;1;Off;0;0;True;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1715;10808.07,-1669.041;Inherit;False;1710;LightDir;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1490;10830.45,-2195.141;Inherit;False;1310;MetAlbedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1489;10837.45,-2110.141;Inherit;False;1488;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2045;15160.16,1309.059;Inherit;False;Property;_OutlineDepthFade;   Outline Depth Fade;56;0;Create;False;0;0;0;True;0;False;0.075;0.075;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;458;22743.1,8894.128;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1323;10707.4,-1950.768;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;932;15387.36,1909.815;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;874;11361.98,2042.115;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2042;14768.12,1527.162;Inherit;False;Property;_BlendModeIndex;BlendModeIndex;54;0;Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1255;22583.06,7970.436;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1132;15777.28,1668.366;Inherit;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1056;15145.49,9184.126;Inherit;False;Constant;_Float8;Float 8;10;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1658;14540.4,1619.335;Inherit;False;SettingsLevel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;853;7651.768,8374.51;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;929;15566.08,1643.841;Inherit;False;0;True;Transparent;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;1502.225,9885.591;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1660;14284.69,1730.333;Inherit;False;Property;_AdvToggle;Toggle Advanced Settings;64;1;[ToggleUI];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;224;1726.321,9328.495;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;2059.724,8397.891;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;930;15194.95,1519.517;Inherit;False;Property;_OutlineColor;   Outline Color;31;0;Create;True;1;Outline Settings;0;0;True;0;False;0,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;435;23003.53,8457.856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;500;22425.29,9524.938;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;478;22375.55,9151.052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;523;22351.37,9989.771;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;235;1710.226,9805.591;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;1728.298,7904.778;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;225;1432.533,9390.5;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;1509.502,7984.777;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;855;7859.769,8294.51;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;2289.724,8302.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1133;10838.35,-1751.069;Inherit;False;1132;Outline;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;2049.724,8718.891;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;223;1491.862,8989.252;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;6985.159,9559.22;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;520;22131.37,10079.77;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;897;6979.381,9062.566;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;993;14433.25,8061.066;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1026;14701.02,8291.361;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1055;14708.07,9033.339;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;814;7802.573,7933.111;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1012;14429.62,8335.874;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;811;7507.689,8043.732;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1041;14701.88,8660.83;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1061;14436.67,9077.851;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;957;14725.9,7261.757;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;955;14433,7341.756;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1044;14430.48,8705.341;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;99;2257.724,8638.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;980;14727.86,7621.703;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;979;14434.97,7701.702;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;995;14726.14,7981.067;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2073;9479.242,9426.41;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;477;22153.69,9213.413;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1743;15188.79,1755.207;Inherit;False;1495;AlbedoAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;1052;15145.49,9104.126;Inherit;False;Constant;_Int8;Int 8;11;0;Create;True;0;0;0;False;0;False;8;8;False;0;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1661;14533.69,1726.333;Inherit;False;AdvToggle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1496;10829.02,-2034.963;Inherit;False;1495;AlbedoAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;931;15197.44,1906.077;Inherit;False;Property;_OutlineWidth;   Outline Width;32;0;Create;True;0;0;0;True;0;False;0;0.002;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2043;15419.64,1694.812;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;899;7273.169,9000.562;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;222;1713.726,8926.891;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;434;22773.53,8552.856;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;396;22462.85,8045.207;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;461;22951.1,8814.128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;499;22131.5,9586.942;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;918;7205.16,9469.22;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;880;7039.346,8653.694;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;394;22169.96,8125.207;Inherit;False;40;DistanceBlend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;881;7261.21,8591.333;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2100;4601.61,4164.198;Inherit;False;Property;_OutlineMaskClip;   Outline Mask Clip;55;0;Create;True;0;0;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;11028.64,-2168.996;Float;False;True;-1;2;LegendsShaderGUI;0;0;CustomLighting;Furality/Legendary Shader/No Outline/Legendary Shader - No Outline Transparent;False;False;False;False;False;False;True;True;True;False;True;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;True;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;933;-1;0;True;1742;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;787;8843.066,7734.727;Inherit;False;973.9639;751.2849;Rimlight Style Selector;0;;1,1,1,1;0;0
WireConnection;5;0;3;0
WireConnection;6;2;3;0
WireConnection;1701;0;1722;2
WireConnection;4;0;5;0
WireConnection;4;1;6;0
WireConnection;4;5;1564;0
WireConnection;1700;1;1703;0
WireConnection;1700;0;1701;0
WireConnection;1718;0;1700;0
WireConnection;105;0;19;0
WireConnection;92;0;171;0
WireConnection;1721;0;1700;0
WireConnection;935;0;4;3
WireConnection;935;1;934;0
WireConnection;1740;0;1737;0
WireConnection;170;0;92;0
WireConnection;18;0;13;0
WireConnection;18;1;105;0
WireConnection;1717;0;1709;0
WireConnection;1717;1;1718;0
WireConnection;1719;0;1721;0
WireConnection;1719;1;1740;0
WireConnection;936;0;4;0
WireConnection;936;2;935;0
WireConnection;91;0;18;0
WireConnection;91;2;170;0
WireConnection;7;0;936;0
WireConnection;1720;0;1717;0
WireConnection;1720;1;1719;0
WireConnection;1710;0;1720;0
WireConnection;17;0;91;0
WireConnection;63;0;17;0
WireConnection;1;0;9;0
WireConnection;10;0;1;0
WireConnection;10;1;1711;0
WireConnection;1518;0;56;0
WireConnection;55;0;10;0
WireConnection;55;1;54;0
WireConnection;69;0;66;0
WireConnection;67;0;66;0
WireConnection;70;0;69;0
WireConnection;1444;12;55;0
WireConnection;1444;9;1518;0
WireConnection;68;0;67;0
WireConnection;68;1;67;1
WireConnection;71;0;70;0
WireConnection;71;1;70;1
WireConnection;23;0;1444;0
WireConnection;286;0;10;0
WireConnection;16;0;64;0
WireConnection;72;0;68;0
WireConnection;72;1;71;0
WireConnection;76;0;72;0
WireConnection;14;0;16;0
WireConnection;1437;0;24;0
WireConnection;1440;0;206;0
WireConnection;48;0;47;0
WireConnection;1438;0;83;0
WireConnection;78;0;76;0
WireConnection;262;0;108;0
WireConnection;21;0;14;0
WireConnection;21;1;1437;0
WireConnection;81;0;80;0
WireConnection;20;1;21;0
WireConnection;1441;0;236;0
WireConnection;1439;0;194;0
WireConnection;261;0;48;0
WireConnection;107;0;106;0
WireConnection;107;1;262;0
WireConnection;79;0;78;0
WireConnection;79;1;1438;0
WireConnection;208;0;1440;0
WireConnection;239;0;237;0
WireConnection;109;0;107;0
WireConnection;109;2;291;0
WireConnection;73;1;79;0
WireConnection;228;0;231;0
WireConnection;228;1;1441;0
WireConnection;260;0;20;0
WireConnection;260;1;261;0
WireConnection;195;0;1439;0
WireConnection;183;0;81;0
WireConnection;213;0;208;0
WireConnection;1758;0;1753;0
WireConnection;217;0;211;0
WireConnection;232;1;228;0
WireConnection;240;0;239;0
WireConnection;214;0;209;0
WireConnection;214;1;213;0
WireConnection;214;2;212;0
WireConnection;214;3;210;0
WireConnection;178;0;260;0
WireConnection;90;0;109;0
WireConnection;82;0;73;0
WireConnection;82;1;183;0
WireConnection;197;0;195;0
WireConnection;25;0;178;0
WireConnection;184;0;193;0
WireConnection;184;1;197;0
WireConnection;184;2;189;0
WireConnection;184;3;188;0
WireConnection;202;0;200;0
WireConnection;104;0;90;0
WireConnection;176;0;82;0
WireConnection;219;0;217;0
WireConnection;241;0;232;0
WireConnection;241;1;240;0
WireConnection;216;1;214;0
WireConnection;203;0;202;0
WireConnection;220;0;216;0
WireConnection;220;1;219;0
WireConnection;1757;0;1758;0
WireConnection;89;0;104;0
WireConnection;1755;0;1763;0
WireConnection;86;0;176;0
WireConnection;192;1;184;0
WireConnection;1760;0;1759;0
WireConnection;242;0;241;0
WireConnection;1756;0;1755;0
WireConnection;1754;0;1760;0
WireConnection;1754;1;1761;0
WireConnection;1754;2;1757;0
WireConnection;218;0;220;0
WireConnection;204;0;192;0
WireConnection;204;1;203;0
WireConnection;243;0;242;0
WireConnection;1771;0;1769;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;95;0;89;0
WireConnection;95;1;98;0
WireConnection;221;0;218;0
WireConnection;1502;0;54;0
WireConnection;101;0;100;0
WireConnection;1770;0;1771;0
WireConnection;1497;0;56;0
WireConnection;94;1;95;0
WireConnection;312;0;313;0
WireConnection;199;0;204;0
WireConnection;52;0;36;0
WireConnection;52;1;42;0
WireConnection;1762;0;1754;0
WireConnection;1762;1;1768;0
WireConnection;1762;2;1756;0
WireConnection;1777;0;1775;0
WireConnection;102;0;94;0
WireConnection;102;1;101;0
WireConnection;307;1;312;0
WireConnection;1773;0;1762;0
WireConnection;1773;1;1774;0
WireConnection;1773;2;1770;0
WireConnection;1782;0;1780;0
WireConnection;205;0;199;0
WireConnection;1453;0;52;0
WireConnection;1453;1;44;0
WireConnection;30;0;29;0
WireConnection;1776;0;1777;0
WireConnection;2078;0;2075;0
WireConnection;2078;1;2077;0
WireConnection;2079;0;2076;0
WireConnection;309;0;307;0
WireConnection;309;1;1712;0
WireConnection;103;0;102;0
WireConnection;1779;0;1773;0
WireConnection;1779;1;1788;0
WireConnection;1779;2;1776;0
WireConnection;1786;0;1784;0
WireConnection;38;0;1453;0
WireConnection;1781;0;1782;0
WireConnection;1534;0;1532;0
WireConnection;1402;0;1396;0
WireConnection;778;0;776;0
WireConnection;779;0;775;0
WireConnection;1783;0;1779;0
WireConnection;1783;1;1789;0
WireConnection;1783;2;1781;0
WireConnection;1526;0;1534;0
WireConnection;1526;1;1527;0
WireConnection;2081;0;38;0
WireConnection;1525;0;1529;0
WireConnection;1785;0;1786;0
WireConnection;1404;0;1402;3
WireConnection;1404;1;1402;4
WireConnection;314;0;309;0
WireConnection;1398;2;1400;0
WireConnection;1397;0;1396;0
WireConnection;2080;12;2078;0
WireConnection;2080;9;2079;0
WireConnection;781;0;777;0
WireConnection;781;1;779;0
WireConnection;736;0;735;0
WireConnection;1524;12;1526;0
WireConnection;1524;9;1525;0
WireConnection;780;0;778;0
WireConnection;2084;0;2083;0
WireConnection;1505;0;2080;0
WireConnection;315;0;314;0
WireConnection;315;1;316;0
WireConnection;1399;0;1397;0
WireConnection;1399;1;1398;0
WireConnection;1403;0;1404;0
WireConnection;1787;0;1783;0
WireConnection;1787;1;1790;0
WireConnection;1787;2;1785;0
WireConnection;1794;0;1793;0
WireConnection;732;0;733;0
WireConnection;1405;0;1403;0
WireConnection;1798;0;1797;0
WireConnection;1407;0;1399;4
WireConnection;1407;1;304;0
WireConnection;782;0;781;0
WireConnection;782;2;780;0
WireConnection;734;0;737;0
WireConnection;734;1;736;0
WireConnection;734;3;732;0
WireConnection;410;0;408;0
WireConnection;1522;0;1524;0
WireConnection;411;0;407;0
WireConnection;768;0;315;0
WireConnection;2086;0;1787;0
WireConnection;2086;1;2084;0
WireConnection;2086;2;2085;0
WireConnection;1795;0;1794;0
WireConnection;413;0;411;0
WireConnection;1799;0;1798;0
WireConnection;738;0;734;0
WireConnection;738;1;731;0
WireConnection;783;0;782;0
WireConnection;1796;0;2086;0
WireConnection;1796;1;1791;0
WireConnection;1796;2;1795;0
WireConnection;1406;0;1407;0
WireConnection;1406;1;304;0
WireConnection;1406;2;1405;0
WireConnection;1448;0;768;0
WireConnection;1448;2;383;0
WireConnection;412;0;409;0
WireConnection;412;1;410;0
WireConnection;414;0;412;0
WireConnection;414;2;413;0
WireConnection;784;0;783;0
WireConnection;1800;0;1796;0
WireConnection;1800;1;1792;0
WireConnection;1800;2;1799;0
WireConnection;871;0;738;0
WireConnection;1446;0;1448;0
WireConnection;354;0;1406;0
WireConnection;415;0;414;0
WireConnection;1452;0;871;0
WireConnection;1452;1;772;0
WireConnection;684;0;78;0
WireConnection;338;0;14;0
WireConnection;165;0;1800;0
WireConnection;351;0;1446;0
WireConnection;416;0;415;0
WireConnection;1451;12;1452;0
WireConnection;1451;9;771;0
WireConnection;1043;0;1042;0
WireConnection;805;0;804;0
WireConnection;972;0;969;0
WireConnection;371;0;361;0
WireConnection;37;2;38;0
WireConnection;959;0;975;0
WireConnection;959;1;972;0
WireConnection;807;0;804;0
WireConnection;1062;0;1063;0
WireConnection;978;0;977;0
WireConnection;801;0;802;0
WireConnection;801;1;1451;0
WireConnection;989;0;981;0
WireConnection;806;0;805;0
WireConnection;1491;0;382;0
WireConnection;360;0;371;0
WireConnection;1447;0;357;0
WireConnection;1040;0;1043;0
WireConnection;1039;0;1040;0
WireConnection;1011;0;1009;0
WireConnection;425;0;424;0
WireConnection;773;0;801;0
WireConnection;982;0;989;0
WireConnection;982;1;978;0
WireConnection;809;0;807;0
WireConnection;809;1;807;1
WireConnection;1065;0;1062;0
WireConnection;808;0;806;0
WireConnection;808;1;806;1
WireConnection;961;1;959;0
WireConnection;40;0;37;0
WireConnection;1492;0;1491;0
WireConnection;370;0;1447;0
WireConnection;370;1;360;0
WireConnection;973;0;970;0
WireConnection;1229;0;355;0
WireConnection;1027;0;1011;0
WireConnection;810;0;809;0
WireConnection;810;1;808;0
WireConnection;1046;0;1039;0
WireConnection;985;1;982;0
WireConnection;329;0;1229;0
WireConnection;427;0;425;0
WireConnection;426;0;424;0
WireConnection;742;0;741;0
WireConnection;984;0;983;0
WireConnection;725;0;89;0
WireConnection;966;0;961;0
WireConnection;966;1;973;0
WireConnection;1450;0;370;0
WireConnection;1450;1;1492;0
WireConnection;1064;0;1054;0
WireConnection;1064;1;1065;0
WireConnection;746;0;743;0
WireConnection;746;1;744;0
WireConnection;1028;0;1027;0
WireConnection;875;0;1451;0
WireConnection;875;1;876;0
WireConnection;875;2;1169;0
WireConnection;865;0;864;0
WireConnection;1038;0;1037;0
WireConnection;1038;1;1046;0
WireConnection;1038;2;1036;0
WireConnection;1038;3;1035;0
WireConnection;812;0;810;0
WireConnection;1158;0;353;0
WireConnection;428;0;426;0
WireConnection;428;1;426;1
WireConnection;1053;1;1064;0
WireConnection;1059;0;1060;0
WireConnection;422;0;1450;0
WireConnection;422;1;420;0
WireConnection;330;0;329;0
WireConnection;330;1;329;0
WireConnection;745;0;742;0
WireConnection;986;0;985;0
WireConnection;986;1;984;0
WireConnection;974;0;966;0
WireConnection;429;0;427;0
WireConnection;429;1;427;1
WireConnection;393;0;390;0
WireConnection;1024;0;1025;0
WireConnection;1024;1;1028;0
WireConnection;1024;2;1023;0
WireConnection;1024;3;1022;0
WireConnection;1031;1;1038;0
WireConnection;967;0;974;0
WireConnection;1049;0;1053;0
WireConnection;1049;1;1059;0
WireConnection;867;0;866;0
WireConnection;867;1;865;0
WireConnection;769;0;875;0
WireConnection;996;0;994;0
WireConnection;747;0;745;0
WireConnection;747;1;746;0
WireConnection;1030;0;1045;0
WireConnection;430;0;428;0
WireConnection;430;1;429;0
WireConnection;815;0;812;0
WireConnection;987;0;986;0
WireConnection;451;0;450;0
WireConnection;328;0;1158;0
WireConnection;328;1;330;0
WireConnection;379;0;422;0
WireConnection;992;0;991;0
WireConnection;395;0;393;0
WireConnection;1811;0;1806;0
WireConnection;323;0;328;0
WireConnection;323;1;321;0
WireConnection;997;0;996;0
WireConnection;997;1;992;0
WireConnection;1050;0;1049;0
WireConnection;453;0;452;0
WireConnection;453;1;451;0
WireConnection;1810;0;1851;0
WireConnection;817;0;815;0
WireConnection;817;1;813;0
WireConnection;900;0;898;0
WireConnection;868;0;867;0
WireConnection;868;2;850;0
WireConnection;433;0;430;0
WireConnection;1018;0;1016;0
WireConnection;750;1;747;0
WireConnection;1032;0;1031;0
WireConnection;1032;1;1030;0
WireConnection;988;0;987;0
WireConnection;1017;1;1024;0
WireConnection;1411;2;1493;0
WireConnection;1409;0;1408;0
WireConnection;1816;0;1807;0
WireConnection;455;0;453;0
WireConnection;455;2;454;0
WireConnection;1942;0;1941;0
WireConnection;324;0;323;0
WireConnection;819;1;817;0
WireConnection;1019;0;1017;0
WireConnection;1019;1;1018;0
WireConnection;436;0;433;0
WireConnection;1815;0;1811;0
WireConnection;999;1;997;0
WireConnection;882;0;878;0
WireConnection;1410;0;1409;0
WireConnection;1410;1;1411;0
WireConnection;901;0;900;0
WireConnection;1814;0;1846;0
WireConnection;1814;1;1079;0
WireConnection;1814;2;1810;0
WireConnection;919;0;917;0
WireConnection;919;1;916;0
WireConnection;398;0;395;0
WireConnection;398;1;391;0
WireConnection;754;0;750;0
WireConnection;754;1;751;0
WireConnection;1000;0;998;0
WireConnection;1051;0;1050;0
WireConnection;1033;0;1032;0
WireConnection;851;0;868;0
WireConnection;438;0;436;0
WireConnection;438;1;431;0
WireConnection;501;0;497;0
WireConnection;905;0;904;0
WireConnection;905;1;901;0
WireConnection;905;2;903;0
WireConnection;905;3;902;0
WireConnection;1034;0;1033;0
WireConnection;1817;0;1812;0
WireConnection;401;1;398;0
WireConnection;1020;0;1019;0
WireConnection;1416;0;1410;2
WireConnection;1416;1;1412;0
WireConnection;1332;0;1328;0
WireConnection;1818;0;1816;0
WireConnection;1001;0;999;0
WireConnection;1001;1;1000;0
WireConnection;456;0;455;0
WireConnection;852;0;851;0
WireConnection;2047;0;2046;0
WireConnection;1819;0;1814;0
WireConnection;1819;1;1080;0
WireConnection;1819;2;1815;0
WireConnection;786;0;754;0
WireConnection;823;0;819;0
WireConnection;823;1;818;0
WireConnection;921;1;919;0
WireConnection;887;0;882;0
WireConnection;479;0;475;0
WireConnection;824;0;823;0
WireConnection;856;0;852;0
WireConnection;1335;0;1333;0
WireConnection;1002;0;1001;0
WireConnection;1326;0;401;0
WireConnection;1368;0;397;0
WireConnection;1368;1;1332;0
WireConnection;441;1;438;0
WireConnection;1825;0;1817;0
WireConnection;800;0;792;0
WireConnection;2048;0;2047;0
WireConnection;888;0;886;0
WireConnection;888;1;887;0
WireConnection;888;2;883;0
WireConnection;888;3;885;0
WireConnection;909;1;905;0
WireConnection;1561;0;772;0
WireConnection;525;0;522;0
WireConnection;525;1;519;0
WireConnection;1417;0;1416;0
WireConnection;459;0;456;0
WireConnection;926;0;921;0
WireConnection;926;1;922;0
WireConnection;1826;0;1819;0
WireConnection;1826;1;1082;0
WireConnection;1826;2;1818;0
WireConnection;872;0;738;0
WireConnection;1021;0;1020;0
WireConnection;506;0;501;0
WireConnection;1901;0;1942;0
WireConnection;1824;0;1821;0
WireConnection;1900;0;1899;0
WireConnection;1906;0;1900;0
WireConnection;912;0;909;0
WireConnection;912;1;907;0
WireConnection;460;0;459;0
WireConnection;1827;0;1826;0
WireConnection;1827;1;1084;0
WireConnection;1827;2;1825;0
WireConnection;481;0;479;0
WireConnection;1744;0;872;0
WireConnection;857;0;856;0
WireConnection;857;1;854;0
WireConnection;1362;0;1360;0
WireConnection;1265;0;1326;0
WireConnection;1265;1;1368;0
WireConnection;1265;2;378;0
WireConnection;1371;0;1336;0
WireConnection;1371;1;1335;0
WireConnection;1830;0;1822;0
WireConnection;1560;0;771;0
WireConnection;1995;0;1994;0
WireConnection;1907;0;1943;0
WireConnection;528;1;525;0
WireConnection;1905;0;800;0
WireConnection;1905;1;794;0
WireConnection;1905;2;1901;0
WireConnection;1003;0;1002;0
WireConnection;508;0;504;0
WireConnection;508;1;506;0
WireConnection;508;2;503;0
WireConnection;508;3;505;0
WireConnection;726;0;727;0
WireConnection;927;0;926;0
WireConnection;1828;0;1824;0
WireConnection;1337;0;441;0
WireConnection;2049;0;2048;0
WireConnection;890;1;888;0
WireConnection;1910;0;1907;0
WireConnection;404;0;1265;0
WireConnection;1419;0;726;0
WireConnection;1419;1;1420;0
WireConnection;1364;0;528;0
WireConnection;1913;0;1905;0
WireConnection;1913;1;788;0
WireConnection;1913;2;1906;0
WireConnection;913;0;912;0
WireConnection;442;0;1337;0
WireConnection;442;1;1371;0
WireConnection;442;2;1334;0
WireConnection;860;1;857;0
WireConnection;1833;0;1830;0
WireConnection;1911;0;1944;0
WireConnection;509;1;508;0
WireConnection;2066;0;2064;0
WireConnection;1355;0;1353;0
WireConnection;470;0;460;0
WireConnection;486;0;484;0
WireConnection;486;1;481;0
WireConnection;486;2;480;0
WireConnection;486;3;483;0
WireConnection;1375;0;1363;0
WireConnection;1375;1;1362;0
WireConnection;1836;0;1827;0
WireConnection;1836;1;1083;0
WireConnection;1836;2;1828;0
WireConnection;892;0;890;0
WireConnection;892;1;884;0
WireConnection;2000;0;2036;0
WireConnection;487;1;486;0
WireConnection;463;0;470;0
WireConnection;463;1;457;0
WireConnection;861;0;860;0
WireConnection;861;1;858;0
WireConnection;1917;0;1911;0
WireConnection;1374;0;1356;0
WireConnection;1374;1;1355;0
WireConnection;1918;0;1913;0
WireConnection;1918;1;790;0
WireConnection;1918;2;1910;0
WireConnection;444;0;442;0
WireConnection;2068;0;2065;0
WireConnection;2068;1;2066;0
WireConnection;2001;0;1995;0
WireConnection;1366;0;1364;0
WireConnection;1366;1;1375;0
WireConnection;1366;2;1361;0
WireConnection;2060;0;2062;0
WireConnection;1348;0;1346;0
WireConnection;894;0;892;0
WireConnection;1476;0;1399;1
WireConnection;1834;0;1829;0
WireConnection;1837;0;1836;0
WireConnection;1837;1;1081;0
WireConnection;1837;2;1833;0
WireConnection;2056;0;1419;0
WireConnection;2056;1;2055;0
WireConnection;2061;0;2062;0
WireConnection;2069;0;2067;0
WireConnection;1916;0;1945;0
WireConnection;1357;0;509;0
WireConnection;1848;0;1847;0
WireConnection;1848;1;2061;0
WireConnection;1848;2;2060;0
WireConnection;465;1;463;0
WireConnection;1671;0;1670;0
WireConnection;1922;0;1946;0
WireConnection;32;2;29;0
WireConnection;1920;0;1918;0
WireConnection;1920;1;793;0
WireConnection;1920;2;1917;0
WireConnection;1840;0;1832;0
WireConnection;1838;0;1834;0
WireConnection;2005;0;1472;0
WireConnection;2005;1;386;0
WireConnection;2005;2;2001;0
WireConnection;1350;0;487;0
WireConnection;1401;0;1476;0
WireConnection;1401;1;1104;0
WireConnection;1359;0;1357;0
WireConnection;1359;1;1374;0
WireConnection;1359;2;1354;0
WireConnection;1373;0;1349;0
WireConnection;1373;1;1348;0
WireConnection;2006;0;2000;0
WireConnection;2004;0;2037;0
WireConnection;1341;0;1339;0
WireConnection;2095;0;1837;0
WireConnection;2095;1;2093;0
WireConnection;2095;2;2094;0
WireConnection;1923;0;1916;0
WireConnection;862;0;861;0
WireConnection;2057;0;2056;0
WireConnection;531;0;1366;0
WireConnection;2071;12;2068;0
WireConnection;2071;9;2069;0
WireConnection;2010;0;2038;0
WireConnection;1926;0;1920;0
WireConnection;1926;1;789;0
WireConnection;1926;2;1923;0
WireConnection;1473;0;1401;0
WireConnection;1473;1;1104;0
WireConnection;1473;2;1405;0
WireConnection;2011;0;2004;0
WireConnection;1352;0;1350;0
WireConnection;1352;1;1373;0
WireConnection;1352;2;1347;0
WireConnection;1929;0;1922;0
WireConnection;1343;0;465;0
WireConnection;1372;0;1342;0
WireConnection;1372;1;1341;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;2058;0;1419;0
WireConnection;2058;1;2057;0
WireConnection;2058;2;2059;0
WireConnection;1850;0;1849;0
WireConnection;1842;0;1840;0
WireConnection;1841;0;2095;0
WireConnection;1841;1;1848;0
WireConnection;1841;2;1838;0
WireConnection;2009;0;2005;0
WireConnection;2009;1;448;0
WireConnection;2009;2;2006;0
WireConnection;513;0;1359;0
WireConnection;2072;0;2071;0
WireConnection;2072;1;2070;0
WireConnection;2090;0;2088;0
WireConnection;1844;0;1841;0
WireConnection;1844;1;1850;0
WireConnection;1844;2;1842;0
WireConnection;1689;0;1473;0
WireConnection;1689;2;1680;0
WireConnection;1928;0;1947;0
WireConnection;2014;0;2010;0
WireConnection;1559;0;2072;0
WireConnection;491;0;1352;0
WireConnection;1345;0;1343;0
WireConnection;1345;1;1372;0
WireConnection;1345;2;1340;0
WireConnection;2013;0;2039;0
WireConnection;1935;0;1926;0
WireConnection;1935;1;791;0
WireConnection;1935;2;1929;0
WireConnection;2015;0;2009;0
WireConnection;2015;1;535;0
WireConnection;2015;2;2011;0
WireConnection;728;0;2058;0
WireConnection;1299;0;31;0
WireConnection;1299;1;1298;0
WireConnection;1933;0;1928;0
WireConnection;1113;0;1689;0
WireConnection;33;0;1299;0
WireConnection;2019;0;2013;0
WireConnection;2091;0;1935;0
WireConnection;2091;1;2090;0
WireConnection;2091;2;2089;0
WireConnection;2020;0;2040;0
WireConnection;1934;0;1948;0
WireConnection;1077;0;1844;0
WireConnection;467;0;1345;0
WireConnection;1539;0;1538;0
WireConnection;2021;0;2015;0
WireConnection;2021;1;517;0
WireConnection;2021;2;2014;0
WireConnection;1544;0;1543;0
WireConnection;2023;0;2020;0
WireConnection;1370;0;1369;0
WireConnection;1226;0;1225;0
WireConnection;1937;0;1934;0
WireConnection;1542;0;1544;0
WireConnection;1542;1;1539;0
WireConnection;2025;0;2021;0
WireConnection;2025;1;492;0
WireConnection;2025;2;2019;0
WireConnection;1938;0;2091;0
WireConnection;1938;1;1562;0
WireConnection;1938;2;1933;0
WireConnection;2052;0;2050;0
WireConnection;2052;1;2051;0
WireConnection;941;0;939;1
WireConnection;941;1;1086;0
WireConnection;1545;0;1542;0
WireConnection;545;0;546;0
WireConnection;1672;0;1399;0
WireConnection;1307;0;1306;0
WireConnection;1307;1;1308;0
WireConnection;2054;0;2052;0
WireConnection;1939;0;1938;0
WireConnection;1939;2;1937;0
WireConnection;2024;0;2041;0
WireConnection;2031;0;2025;0
WireConnection;2031;1;468;0
WireConnection;2031;2;2023;0
WireConnection;1117;0;1112;0
WireConnection;1117;3;1370;0
WireConnection;1117;4;1226;0
WireConnection;1706;0;941;0
WireConnection;1706;1;2054;0
WireConnection;1706;2;2053;0
WireConnection;2099;0;2031;0
WireConnection;2099;1;2097;0
WireConnection;2099;2;2096;0
WireConnection;796;0;1939;0
WireConnection;544;0;545;0
WireConnection;544;1;1117;0
WireConnection;544;2;1196;0
WireConnection;1377;0;1307;2
WireConnection;2030;0;2024;0
WireConnection;1390;0;544;0
WireConnection;1693;0;1682;0
WireConnection;1693;2;1692;0
WireConnection;541;0;542;0
WireConnection;541;1;543;0
WireConnection;541;2;1418;0
WireConnection;1669;0;1668;0
WireConnection;1669;1;1667;0
WireConnection;2033;0;2099;0
WireConnection;2033;1;1546;0
WireConnection;2033;2;2030;0
WireConnection;942;0;1706;0
WireConnection;1482;2;1477;0
WireConnection;1666;0;1482;0
WireConnection;1666;2;1669;0
WireConnection;1483;0;1477;0
WireConnection;388;0;2033;0
WireConnection;1379;0;1315;0
WireConnection;547;0;1390;0
WireConnection;547;1;541;0
WireConnection;1665;2;1662;0
WireConnection;1694;0;1307;1
WireConnection;1694;1;1693;0
WireConnection;1395;0;1391;0
WireConnection;1663;0;1662;0
WireConnection;1664;0;1663;0
WireConnection;1664;1;1665;0
WireConnection;1382;0;1383;0
WireConnection;1484;0;1483;0
WireConnection;1484;1;1666;0
WireConnection;1683;0;1307;1
WireConnection;1683;1;1694;0
WireConnection;1683;2;1684;0
WireConnection;1321;0;1386;0
WireConnection;1321;1;1379;0
WireConnection;1321;2;1395;0
WireConnection;548;0;547;0
WireConnection;1317;0;1314;0
WireConnection;1317;1;1319;0
WireConnection;1317;2;1389;0
WireConnection;1311;0;1683;0
WireConnection;1310;0;1307;0
WireConnection;1376;0;1321;0
WireConnection;1376;1;1382;0
WireConnection;1376;2;1388;0
WireConnection;1650;0;1484;0
WireConnection;1650;1;1649;0
WireConnection;1650;2;1664;1
WireConnection;1303;0;1300;0
WireConnection;1303;1;1301;0
WireConnection;1494;0;33;0
WireConnection;1304;0;1303;0
WireConnection;1304;1;1302;0
WireConnection;1659;618;1634;0
WireConnection;1659;612;1650;0
WireConnection;1659;611;1624;0
WireConnection;1320;0;1317;0
WireConnection;1320;1;1376;0
WireConnection;1320;2;1316;0
WireConnection;1322;0;1320;0
WireConnection;1322;1;1313;0
WireConnection;1488;0;1659;0
WireConnection;1305;0;1312;0
WireConnection;1305;1;1304;0
WireConnection;1495;0;1494;3
WireConnection;1323;0;1305;0
WireConnection;1323;1;1322;0
WireConnection;932;0;931;0
WireConnection;874;0;872;0
WireConnection;1132;0;929;0
WireConnection;1658;0;1657;0
WireConnection;929;0;930;0
WireConnection;929;2;2043;0
WireConnection;929;1;932;0
WireConnection;224;1;225;0
WireConnection;435;1;434;0
WireConnection;500;1;499;0
WireConnection;478;1;477;0
WireConnection;523;1;520;0
WireConnection;235;1;234;0
WireConnection;50;1;45;0
WireConnection;855;1;853;0
WireConnection;85;1;84;0
WireConnection;1026;1;1012;0
WireConnection;1055;1;1061;0
WireConnection;814;1;811;0
WireConnection;1041;1;1044;0
WireConnection;957;1;955;0
WireConnection;99;1;97;0
WireConnection;980;1;979;0
WireConnection;995;1;993;0
WireConnection;1661;0;1660;0
WireConnection;2043;0;930;4
WireConnection;2043;1;1743;0
WireConnection;899;1;897;0
WireConnection;222;1;223;0
WireConnection;396;1;394;0
WireConnection;461;1;458;0
WireConnection;918;1;915;0
WireConnection;881;1;880;0
WireConnection;0;0;1490;0
WireConnection;0;2;1489;0
WireConnection;0;9;1496;0
WireConnection;0;13;1323;0
ASEEND*/
//CHKSM=7E31EF98A208538C4F89FC5DBAB3A510A59AA0A5