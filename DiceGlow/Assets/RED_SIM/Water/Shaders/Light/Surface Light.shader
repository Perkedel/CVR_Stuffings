// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Water/Surface Light"
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
		[Header(Animation Settings)]_RipplesSpeed("Ripples Speed", Float) = 1
		_RipplesSpeed2nd("Ripples Speed 2nd", Float) = 1
		_SpeedX("Speed X", Float) = 0
		_SpeedY("Speed Y", Float) = 0
		[Header(Depth Settings)]_Depth("Depth", Float) = 0.5
		_DepthColorGradation("Depth Color Gradation", Range( 0 , 2)) = 1
		_DepthSaturation("Depth Saturation", Range( 0 , 1)) = 0
		[Header(Visual Fixes)]_IntersectionSmoothing("Intersection Smoothing", Range( 0 , 0.1)) = 0.02
		[Toggle]_ZWrite("ZWrite", Float) = 1
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
			float3 worldNormal;
			INTERNAL_DATA
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
		uniform float _ColorContrast;
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
		uniform float _Smoothness;
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
			float mulTime323 = _Time.y * _RipplesSpeed2nd;
			float2 uv0_Normal2nd = i.uv_texcoord * _Normal2nd_ST.xy + _Normal2nd_ST.zw;
			float2 temp_output_397_0 = ( uv0_Normal2nd + float2( 0,0 ) );
			float2 panner320 = ( mulTime323 * float2( 0.03,0.03 ) + temp_output_397_0);
			float2 temp_output_423_0 = ( appendResult402 * _Normal2nd_ST.xy );
			float2 panner321 = ( mulTime323 * float2( -0.04,0 ) + temp_output_397_0);
			float3 NormalWater315 = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _Normal, ( panner22 + temp_output_422_0 ) ), _NormalPower ) , UnpackScaleNormal( tex2D( _Normal, ( panner19 + temp_output_422_0 ) ), _NormalPower ) ) , BlendNormals( UnpackScaleNormal( tex2D( _Normal2nd, ( panner320 + temp_output_423_0 ) ), _NormalPower2nd ) , UnpackScaleNormal( tex2D( _Normal2nd, ( panner321 + temp_output_423_0 ) ), _NormalPower2nd ) ) );
			o.Normal = NormalWater315;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float eyeDepth440 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float temp_output_442_0 = ( eyeDepth440 - ase_grabScreenPos.a );
			float smoothstepResult647 = smoothstep( 0.0 , 1.0 , (0.0 + (temp_output_442_0 - 0.0) * (1.0 - 0.0) / (_IntersectionSmoothing - 0.0)));
			float IntersectSmoothing648 = smoothstepResult647;
			float4 lerpResult649 = lerp( float4( 0,0,0,0 ) , _Tint , IntersectSmoothing648);
			o.Albedo = lerpResult649.rgb;
			float4 screenColor658 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float smoothstepResult524 = smoothstep( 0.0 , 1.0 , pow( saturate( (0.0 + (temp_output_442_0 - 0.0) * (1.0 - 0.0) / (_Depth - 0.0)) ) , _DepthColorGradation ));
			float DepthHeightMap527 = smoothstepResult524;
			float lerpResult638 = lerp( 1.0 , _ColorContrast , DepthHeightMap527);
			float4 screenColor223 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			float3 hsvTorgb574 = RGBToHSV( screenColor223.rgb );
			float lerpResult578 = lerp( hsvTorgb574.y , ( hsvTorgb574.y * _DepthSaturation ) , DepthHeightMap527);
			float3 hsvTorgb575 = HSVToRGB( float3(hsvTorgb574.x,lerpResult578,hsvTorgb574.z) );
			float3 normalizeResult629 = normalize( NormalWater315 );
			float3 lerpResult632 = lerp( float3( 0,0,1 ) , normalizeResult629 , _WaterGradientContrast);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 ase_tanViewDir = mul( ase_worldToTangent, ase_worldViewDir );
			float dotResult627 = dot( lerpResult632 , ase_tanViewDir );
			float temp_output_537_0 = ( 1.0 - _GradientRadiusFar );
			float smoothstepResult536 = smoothstep( 0.0 , 1.0 , (0.0 + (dotResult627 - temp_output_537_0) * (1.0 - 0.0) / (( temp_output_537_0 + ( 1.0 - _GradientRadiusClose ) ) - temp_output_537_0)));
			float WaterSurfaceGradientMask540 = smoothstepResult536;
			float4 lerpResult542 = lerp( _ColorFar , _ColorClose , WaterSurfaceGradientMask540);
			float4 lerpResult448 = lerp( ( float4( hsvTorgb575 , 0.0 ) * _Color ) , lerpResult542 , DepthHeightMap527);
			float3 hsvTorgb634 = RGBToHSV( lerpResult448.rgb );
			float lerpResult635 = lerp( 1.0 , _ColorSaturation , DepthHeightMap527);
			float3 hsvTorgb637 = HSVToRGB( float3(hsvTorgb634.x,( hsvTorgb634.y * lerpResult635 ),hsvTorgb634.z) );
			float4 lerpResult651 = lerp( screenColor658 , CalculateContrast(lerpResult638,float4( hsvTorgb637 , 0.0 )) , IntersectSmoothing648);
			o.Emission = lerpResult651.rgb;
			float lerpResult653 = lerp( 1.0 , ( _Smoothness + ( _ZWrite * 0.0 ) ) , IntersectSmoothing648);
			o.Smoothness = lerpResult653;
			o.Occlusion = IntersectSmoothing648;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1927;10;1906;987;-476.1441;735.6047;1.772119;True;False
Node;AmplifyShaderEditor.CommentaryNode;151;-3367.734,-1265.635;Inherit;False;3686.834;1339.161;Normals Generation and Animation;38;409;315;326;325;24;17;318;319;23;415;416;417;396;322;48;19;22;321;320;187;21;397;410;323;402;331;324;330;403;395;400;401;422;423;426;427;428;429;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureTransformNode;409;-3065.291,-1185.605;Inherit;False;17;False;1;0;SAMPLER2D;_Sampler0409;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.ComponentMaskNode;428;-2806.873,-1199.993;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;429;-2803.873,-1110.993;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;-2899.289,-916.9153;Float;False;Property;_SpeedY;Speed Y;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;400;-2899.289,-992.9153;Float;False;Property;_SpeedX;Speed X;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;426;-2564.136,-994.0623;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;427;-2565.423,-898.8414;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;-2496.152,-172.3248;Float;False;Property;_RipplesSpeed2nd;Ripples Speed 2nd;15;0;Create;True;0;0;False;0;1;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;395;-2414.469,-973.9683;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;330;-2518.11,-680.6104;Float;False;Property;_RipplesSpeed;Ripples Speed;14;0;Create;True;0;0;False;1;Header(Animation Settings);1;1.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;403;-2412.978,-902.0472;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;324;-2262.763,-510.0306;Inherit;False;0;318;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;402;-2165.978,-929.0471;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-2262.269,-1224.214;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;187;-2193.574,-674.9256;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;397;-1994.846,-500.9396;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;410;-3060.273,-805.7232;Inherit;False;318;False;1;0;SAMPLER2D;_Sampler0410;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleTimeNode;323;-2189.538,-166.6447;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;320;-1826.284,-497.4987;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;321;-1823.983,-380.8087;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;22;-1824.022,-1202.961;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;-1784.348,-817.7733;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;-1789.495,-946.4502;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;19;-1821.567,-1089.748;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;396;-1604.779,-1203.01;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1917.136,-672.1844;Float;False;Property;_NormalPower;Normal Power;12;0;Create;True;0;0;False;0;1;0.139;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;415;-1604.424,-1089.242;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;417;-1601.647,-381.3107;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;416;-1602.861,-497.7716;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;322;-1896.726,-168.2257;Float;False;Property;_NormalPower2nd;Normal Power 2nd;13;0;Create;True;0;0;False;0;0.5;0.616;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;-1470.994,-501.6876;Inherit;True;Property;_TextureSample3;Texture Sample 3;10;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;318;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;318;-1470.534,-304.2289;Inherit;True;Property;_Normal2nd;Normal 2nd;10;0;Create;True;0;0;False;0;-1;None;8d1c512a0b7c09542b55aa818b398907;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;520;504.0828,72.69276;Inherit;False;1592.456;553.3965;Mask Blending;15;646;648;647;645;527;524;572;573;444;443;442;445;450;440;441;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;17;-1474.439,-1009.877;Inherit;True;Property;_Normal;Normal;9;0;Create;True;0;0;False;1;Header(Normal Settings);-1;None;6d095a40a0b25e746a709fedd6a9aae6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-1474.899,-1207.336;Inherit;True;Property;_Normal2;Normal2;9;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;24;-1160.027,-1111.644;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;441;518.1641,127.0599;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;325;-1159.712,-412.1727;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;450;730.7191,219.7407;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;440;735.9613,124.5927;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;326;-908.7394,-908.0333;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;541;537.0305,-555.3503;Inherit;False;1466.513;564.2172;Water Surface Gradient Mask;14;540;536;626;531;535;627;632;539;537;529;533;629;534;631;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;-693.5065,-915.6451;Float;False;NormalWater;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;445;977.1947,236.3966;Float;False;Property;_Depth;Depth;18;0;Create;True;0;0;False;1;Header(Depth Settings);0.5;0.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;442;994.9006,133.0936;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;443;1160.205,155.2497;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;626;593.5602,-512.6799;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;629;817.6046,-506.1306;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;534;683.9706,-79.19459;Float;False;Property;_GradientRadiusClose;Gradient Radius Close;5;0;Create;True;0;0;False;0;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;533;683.9706,-159.1945;Float;False;Property;_GradientRadiusFar;Gradient Radius Far;4;0;Create;True;0;0;False;0;1.2;1.2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;444;1368.476,154.9087;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;631;604.0714,-412.7358;Inherit;False;Property;_WaterGradientContrast;Water Gradient Contrast;6;0;Create;True;0;0;False;0;0;0.305;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;573;1167.974,318.1941;Inherit;False;Property;_DepthColorGradation;Depth Color Gradation;19;0;Create;True;0;0;False;0;1;0.322;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;580;908.9073,-1207.454;Inherit;False;1206.55;577.2659;Depth Saturation;7;578;579;576;577;574;575;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;529;600.7128,-315.5694;Float;False;Tangent;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;537;1019.971,-159.1945;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;632;990.23,-479.8236;Inherit;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;539;1019.971,-79.19459;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;572;1519.574,154.3941;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;627;1139.281,-317.2367;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;223;957.8367,-1114.631;Float;False;Global;_GrabWater;GrabWater;-1;0;Create;True;0;0;False;0;Object;-1;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;524;1674.183,153.7218;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;535;1195.97,-111.1946;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;574;1134.754,-1108.846;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;531;1339.97,-223.1945;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;527;1847.237,155.086;Float;False;DepthHeightMap;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;577;1029.042,-852.0707;Inherit;False;Property;_DepthSaturation;Depth Saturation;20;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;536;1526.404,-223.0049;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;579;1371.206,-925.3617;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;576;1076.59,-778.4052;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;578;1613.322,-954.0599;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;540;1693.424,-227.9328;Float;False;WaterSurfaceGradientMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;575;1871.243,-1085.539;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;543;2187.306,-768.2104;Float;False;Property;_ColorFar;Color Far;2;0;Create;True;0;0;False;0;0.1058824,0.5686275,0.7568628,0;0.1058819,0.5686274,0.7568628,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;449;2197.108,-596.8314;Float;False;Property;_ColorClose;Color Close;3;0;Create;True;0;0;False;0;0,0.2196079,0.2627451,0;0,0.2627445,0.2623929,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;544;2153.902,-421.4179;Inherit;False;540;WaterSurfaceGradientMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;393;2201.321,-949.7728;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;1;Header(Color Settings);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;542;2514.605,-601.3106;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;394;2510.013,-994.9426;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;528;2232.839,-313.1298;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;448;2996.777,-937.4474;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;646;866.0558,465.976;Inherit;False;Property;_IntersectionSmoothing;Intersection Smoothing;22;0;Create;True;0;0;False;1;Header(Visual Fixes);0.02;0.02;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;633;2986.48,-592.7349;Inherit;False;527;DepthHeightMap;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;640;2980.702,-769.8665;Inherit;False;Property;_ColorSaturation;Color Saturation;7;0;Create;True;0;0;False;0;1;1.074;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;635;3300.755,-817.181;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;634;3225.027,-998.1689;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;645;1166.056,428.976;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;642;3118.848,-324.1795;Inherit;False;Property;_ZWrite;ZWrite;23;1;[Toggle];Create;True;2;Option1;0;Option2;1;1;;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;636;3469.357,-995.631;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;647;1364.375,429.6571;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;641;2981.545,-694.5792;Inherit;False;Property;_ColorContrast;Color Contrast;8;0;Create;True;0;0;False;0;1;1.6;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;638;3301.755,-702.181;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;368;3134.147,-464.0956;Float;False;Property;_Smoothness;Smoothness;11;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;637;3625.907,-1042.565;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;657;4129.104,-1364.519;Inherit;False;525.3604;718.0568;Intersection Smoothing;8;653;651;649;656;650;655;652;658;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;643;3273.488,-321.0609;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;648;1536.974,425.1695;Inherit;False;IntersectSmoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;392;3884.831,-1329.463;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;658;4174.509,-1165.005;Float;False;Global;_GrabWater1;GrabWater;-1;0;Create;True;0;0;False;0;Instance;223;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;655;4179.994,-853.4688;Inherit;False;648;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;652;4178.104,-944.1421;Inherit;False;648;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;644;3455.488,-451.0609;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;650;4170.458,-1247.46;Inherit;False;648;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;639;3886.727,-1044.769;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;4698.577,-1071.376;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;649;4457.733,-1318.519;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;653;4454.254,-897.0691;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;651;4446.973,-1031.436;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;4354.99,-767.7952;Inherit;False;648;IntersectSmoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4941.368,-1093.04;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;RED_SIM/Water/Surface Light;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;True;False;Back;0;True;642;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-1;True;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;21;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;428;0;409;0
WireConnection;429;0;409;0
WireConnection;426;0;400;0
WireConnection;426;1;428;0
WireConnection;427;0;401;0
WireConnection;427;1;429;0
WireConnection;395;0;426;0
WireConnection;403;0;427;0
WireConnection;402;0;395;0
WireConnection;402;1;403;0
WireConnection;187;0;330;0
WireConnection;397;0;324;0
WireConnection;323;0;331;0
WireConnection;320;0;397;0
WireConnection;320;1;323;0
WireConnection;321;0;397;0
WireConnection;321;1;323;0
WireConnection;22;0;21;0
WireConnection;22;1;187;0
WireConnection;423;0;402;0
WireConnection;423;1;410;0
WireConnection;422;0;409;0
WireConnection;422;1;402;0
WireConnection;19;0;21;0
WireConnection;19;1;187;0
WireConnection;396;0;22;0
WireConnection;396;1;422;0
WireConnection;415;0;19;0
WireConnection;415;1;422;0
WireConnection;417;0;321;0
WireConnection;417;1;423;0
WireConnection;416;0;320;0
WireConnection;416;1;423;0
WireConnection;319;1;416;0
WireConnection;319;5;322;0
WireConnection;318;1;417;0
WireConnection;318;5;322;0
WireConnection;17;1;415;0
WireConnection;17;5;48;0
WireConnection;23;1;396;0
WireConnection;23;5;48;0
WireConnection;24;0;23;0
WireConnection;24;1;17;0
WireConnection;325;0;319;0
WireConnection;325;1;318;0
WireConnection;440;0;441;0
WireConnection;326;0;24;0
WireConnection;326;1;325;0
WireConnection;315;0;326;0
WireConnection;442;0;440;0
WireConnection;442;1;450;4
WireConnection;443;0;442;0
WireConnection;443;2;445;0
WireConnection;629;0;626;0
WireConnection;444;0;443;0
WireConnection;537;0;533;0
WireConnection;632;1;629;0
WireConnection;632;2;631;0
WireConnection;539;0;534;0
WireConnection;572;0;444;0
WireConnection;572;1;573;0
WireConnection;627;0;632;0
WireConnection;627;1;529;0
WireConnection;524;0;572;0
WireConnection;535;0;537;0
WireConnection;535;1;539;0
WireConnection;574;0;223;0
WireConnection;531;0;627;0
WireConnection;531;1;537;0
WireConnection;531;2;535;0
WireConnection;527;0;524;0
WireConnection;536;0;531;0
WireConnection;579;0;574;2
WireConnection;579;1;577;0
WireConnection;578;0;574;2
WireConnection;578;1;579;0
WireConnection;578;2;576;0
WireConnection;540;0;536;0
WireConnection;575;0;574;1
WireConnection;575;1;578;0
WireConnection;575;2;574;3
WireConnection;542;0;543;0
WireConnection;542;1;449;0
WireConnection;542;2;544;0
WireConnection;394;0;575;0
WireConnection;394;1;393;0
WireConnection;448;0;394;0
WireConnection;448;1;542;0
WireConnection;448;2;528;0
WireConnection;635;1;640;0
WireConnection;635;2;633;0
WireConnection;634;0;448;0
WireConnection;645;0;442;0
WireConnection;645;2;646;0
WireConnection;636;0;634;2
WireConnection;636;1;635;0
WireConnection;647;0;645;0
WireConnection;638;1;641;0
WireConnection;638;2;633;0
WireConnection;637;0;634;1
WireConnection;637;1;636;0
WireConnection;637;2;634;3
WireConnection;643;0;642;0
WireConnection;648;0;647;0
WireConnection;644;0;368;0
WireConnection;644;1;643;0
WireConnection;639;1;637;0
WireConnection;639;0;638;0
WireConnection;649;1;392;0
WireConnection;649;2;650;0
WireConnection;653;1;644;0
WireConnection;653;2;655;0
WireConnection;651;0;658;0
WireConnection;651;1;639;0
WireConnection;651;2;652;0
WireConnection;0;0;649;0
WireConnection;0;1;369;0
WireConnection;0;2;651;0
WireConnection;0;4;653;0
WireConnection;0;5;656;0
ASEEND*/
//CHKSM=0D52E0B98773B0D29EA27A2A9DB5252F4CA5D6CE