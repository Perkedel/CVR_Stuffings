// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Silent/RainyMirror"
{
	Properties
	{
		[HideInInspector]_ReflectionTex0("_ReflectionTex0", 2D) = "white" {}
		[HideInInspector]_ReflectionTex1("_ReflectionTex1", 2D) = "white" {}
		[Header(Rain Properties)]_RainPattern("Rain Pattern", 2D) = "gray" {}
		[NoScaleOffset][Normal]_RIppleNormals("Ripple Normals", 2D) = "bump" {}
		[NoScaleOffset][Normal]_DropletNormals("Droplet Normals", 2D) = "bump" {}
		_RainSpeed("Rain Speed", Float) = 1
		_StreakTiling("Streak Tiling", Float) = 1
		_StreakLength("Streak Length", Float) = 1
		[Header(Additional Properties)]_SurfaceMask("Surface Mask", 2D) = "black" {}
		_SurfaceSmoothness("Surface Smoothness ", Range( 0 , 1)) = 0
		_SurfaceLevelTweak("Surface Level Tweak", Range( -1 , 1)) = 0
		_SurfaceSmoothnessTweak("Surface Smoothness Tweak", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
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
			float4 screenPos;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
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

		uniform sampler2D _ReflectionTex0;
		uniform sampler2D _DropletNormals;
		uniform float _RainSpeed;
		uniform float _StreakTiling;
		uniform float _StreakLength;
		uniform sampler2D _RainPattern;
		uniform sampler2D _RIppleNormals;
		uniform float4 _RainPattern_ST;
		uniform sampler2D _ReflectionTex1;
		uniform float _SurfaceSmoothnessTweak;
		uniform sampler2D _SurfaceMask;
		uniform float4 _SurfaceMask_ST;
		uniform float _SurfaceSmoothness;
		uniform float _SurfaceLevelTweak;


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 UV22_g43 = ase_screenPosNorm.xy;
			float2 localUnStereo22_g43 = UnStereo( UV22_g43 );
			float2 baseReflUVs26 = localUnStereo22_g43;
			float3 ase_worldPos = i.worldPos;
			float rainSpeed36 = _RainSpeed;
			float rainSpeed45_g41 = rainSpeed36;
			float streakTiling39 = _StreakTiling;
			float streakTiling50_g41 = streakTiling39;
			float3 break59_g41 = ( ( ase_worldPos + ( _Time.y * float3(0,0,0) * rainSpeed45_g41 ) ) / streakTiling50_g41 );
			float streakLength38 = _StreakLength;
			float streakLength52_g41 = streakLength38;
			float3 appendResult13_g41 = (float3(break59_g41.x , ( break59_g41.y / streakLength52_g41 ) , break59_g41.z));
			float2 temp_output_29_0_g41 = (appendResult13_g41).xy;
			float3 break24_g41 = appendResult13_g41;
			float2 appendResult28_g41 = (float2(break24_g41.z , break24_g41.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float temp_output_30_0_g41 = saturate( abs( ase_worldNormal.x ) );
			float3 lerpResult57_g41 = lerp( UnpackNormal( tex2D( _DropletNormals, temp_output_29_0_g41 ) ) , UnpackNormal( tex2D( _DropletNormals, appendResult28_g41 ) ) , temp_output_30_0_g41);
			float lerpResult36_g41 = lerp( tex2D( _RainPattern, temp_output_29_0_g41 ).g , tex2D( _RainPattern, appendResult28_g41 ).g , temp_output_30_0_g41);
			float3 temp_output_19_0_g41 = ( ( appendResult13_g41 * float3( 1,0.5,1 ) ) + ( _Time.y * float3(0,1,0) * rainSpeed45_g41 ) );
			float3 break20_g41 = temp_output_19_0_g41;
			float2 appendResult22_g41 = (float2(break20_g41.z , break20_g41.y));
			float lerpResult34_g41 = lerp( tex2D( _RainPattern, (temp_output_19_0_g41).xy ).b , tex2D( _RainPattern, appendResult22_g41 ).b , temp_output_30_0_g41);
			float temp_output_40_0_g41 = saturate( ( ( lerpResult36_g41 - pow( lerpResult34_g41 , 4.0 ) ) * 5.0 ) );
			float3 lerpResult58_g41 = lerp( float3( 0,0,1 ) , lerpResult57_g41 , temp_output_40_0_g41);
			float2 worldUVs114_g42 = (ase_worldPos).xz;
			float2 temp_output_20_0_g42 = (worldUVs114_g42*_RainPattern_ST.xy + ( _RainPattern_ST.zw + float2( 0,0 ) ));
			float3 rippleNormalsSample1101_g42 = UnpackNormal( tex2D( _RIppleNormals, temp_output_20_0_g42 ) );
			float2 temp_output_41_0_g42 = (worldUVs114_g42*_RainPattern_ST.xy + ( _RainPattern_ST.zw + 0.1 ));
			float3 rippleNormalsSample2104_g42 = UnpackNormal( tex2D( _RIppleNormals, temp_output_41_0_g42 ) );
			float rainSpeed60_g42 = rainSpeed36;
			float temp_output_19_0_g42 = ( ( _Time.y + 0.0 ) * rainSpeed60_g42 );
			float rainTime29_g42 = temp_output_19_0_g42;
			float temp_output_12_0_g42 = abs( sin( ( rainTime29_g42 * UNITY_PI ) ) );
			float3 lerpResult111_g42 = lerp( rippleNormalsSample1101_g42 , rippleNormalsSample2104_g42 , temp_output_12_0_g42);
			float3 newWorldNormal30 = (WorldNormalVector( i , float3(0,0,1) ));
			float rainAxis47 = saturate( newWorldNormal30.y );
			float3 lerpResult53 = lerp( lerpResult58_g41 , lerpResult111_g42 , rainAxis47);
			float3 rainNormals55 = lerpResult53;
			float noRainArea50 = ( 1.0 - saturate( -newWorldNormal30.y ) );
			float temp_output_25_0_g42 = ( (tex2D( _RainPattern, temp_output_20_0_g42 )).r - ( 1.0 - frac( temp_output_19_0_g42 ) ) );
			float smoothstepResult11_g42 = smoothstep( 0.0 , 1.0 , ( distance( temp_output_25_0_g42 , 0.05 ) / max( 0.05 , saturate( fwidth( temp_output_25_0_g42 ) ) ) ));
			float temp_output_40_0_g42 = ( ( _Time.y + 0.5 ) * rainSpeed60_g42 );
			float temp_output_45_0_g42 = ( (tex2D( _RainPattern, temp_output_41_0_g42 )).r - ( 1.0 - frac( temp_output_40_0_g42 ) ) );
			float smoothstepResult65_g42 = smoothstep( 0.0 , 1.0 , ( distance( temp_output_45_0_g42 , 0.05 ) / max( 0.05 , saturate( fwidth( temp_output_45_0_g42 ) ) ) ));
			float rainTime246_g42 = temp_output_40_0_g42;
			float lerpResult54 = lerp( temp_output_40_0_g41 , ( ( ( 1.0 - smoothstepResult11_g42 ) * temp_output_12_0_g42 ) + ( ( 1.0 - smoothstepResult65_g42 ) * abs( sin( ( rainTime246_g42 * UNITY_PI ) ) ) ) ) , rainAxis47);
			float rainMask57 = ( noRainArea50 * lerpResult54 );
			float2 lerpResult61 = lerp( baseReflUVs26 , ( baseReflUVs26 + (rainNormals55).xy ) , rainMask57);
			float4 lerpResult4 = lerp( tex2D( _ReflectionTex0, lerpResult61 ) , tex2D( _ReflectionTex1, lerpResult61 ) , unity_StereoEyeIndex);
			float3 indirectNormal9 = (WorldNormalVector( i , rainNormals55 ));
			float2 uv_SurfaceMask = i.uv_texcoord * _SurfaceMask_ST.xy + _SurfaceMask_ST.zw;
			float4 tex2DNode65 = tex2D( _SurfaceMask, uv_SurfaceMask );
			float surfaceSmoothness77 = saturate( ( ( saturate( ( _SurfaceSmoothnessTweak + tex2DNode65.r ) ) * _SurfaceSmoothness ) + 0.0 ) );
			Unity_GlossyEnvironmentData g9 = UnityGlossyEnvironmentSetup( surfaceSmoothness77, data.worldViewDir, indirectNormal9, float3(0,0,0));
			float3 indirectSpecular9 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal9, g9 );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float smoothstepResult21 = smoothstep( 0.0 , 1.0 , distance( ase_vertexNormal , float3( 0,0,-1 ) ));
			float surfaceLevel76 = saturate( ( tex2DNode65.r + _SurfaceLevelTweak ) );
			float mirrorOrReflectionSelector15 = saturate( ( saturate( smoothstepResult21 ) + surfaceLevel76 ) );
			float4 lerpResult16 = lerp( lerpResult4 , float4( indirectSpecular9 , 0.0 ) , mirrorOrReflectionSelector15);
			c.rgb = lerpResult16.rgb;
			c.a = 1;
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
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
1911;896;1929;1202;1747.214;602.0377;1.6;True;False
Node;AmplifyShaderEditor.Vector3Node;29;-1754.318,1353.365;Inherit;False;Constant;_001;0,0,1;6;0;Create;True;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;34;-1789.353,496.3107;Inherit;False;Property;_RainSpeed;Rain Speed;5;0;Create;True;0;0;False;0;False;1;0.3333333;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1783.743,659.3428;Inherit;False;Property;_StreakLength;Streak Length;7;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1781.743,581.3428;Inherit;False;Property;_StreakTiling;Streak Tiling;6;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;30;-1594.318,1352.365;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;35;-1322.547,1366.345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1625.222,585.2197;Inherit;False;streakTiling;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-1632.832,500.1887;Inherit;False;rainSpeed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-1628.222,663.2197;Inherit;False;streakLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;33;-1380.707,1504.654;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-2241.008,1390.036;Inherit;False;38;streakLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;43;-2101.245,582.7557;Inherit;True;Property;_RainPattern;Rain Pattern;2;0;Create;True;0;0;False;1;Header(Rain Properties);False;None;287b190ad82c12d4fa2044e30b39a8ef;False;gray;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-2241.008,1230.036;Inherit;False;36;rainSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;46;-2107.744,800.9647;Inherit;True;Property;_RIppleNormals;RIpple Normals;3;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;False;None;fa1aa122c82ea3a4e8d38f9d9ee24ae1;True;bump;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SaturateNode;37;-1235.59,1508.381;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-2241.008,1310.036;Inherit;False;39;streakTiling;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;41;-2108.552,993.638;Inherit;True;Property;_DropletNormals;Droplet Normals;4;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;False;None;b3fce133292218f41884a8cc9135f7a9;True;bump;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-1188.548,1361.345;Inherit;False;rainAxis;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;48;-1768.294,869.9087;Inherit;False;RainGroundRipples;-1;;42;1e4f1751c78baf34ea6ca6afecb86f67;0;3;30;SAMPLER2D;;False;95;SAMPLER2D;;False;31;FLOAT;0;False;2;FLOAT;0;FLOAT3;94
Node;AmplifyShaderEditor.FunctionNode;49;-1767.457,990.5078;Inherit;False;RainWallRipples;-1;;41;ee9ea9189ac23aa45a8a9696e2cd39f3;0;5;44;SAMPLER2D;;False;46;SAMPLER2D;;False;49;FLOAT;0;False;51;FLOAT;0;False;53;FLOAT;0;False;2;FLOAT;0;FLOAT3;43
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1596.83,1153.283;Inherit;False;47;rainAxis;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-131.5947,531.5247;Inherit;False;Property;_SurfaceLevelTweak;Surface Level Tweak;10;0;Create;True;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;65;-147.5947,771.5247;Inherit;True;Property;_SurfaceMask;Surface Mask;8;0;Create;True;0;0;False;1;Header(Additional Properties);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-131.5947,611.5247;Inherit;False;Property;_SurfaceSmoothnessTweak;Surface Smoothness Tweak;11;0;Create;True;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;44;-1086.707,1504.654;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;252.4053,627.5247;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;247.4053,505.5247;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;11;-41.43829,-312.1066;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;7;-1452.5,-290.5;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-914.5898,1496.381;Inherit;False;noRainArea;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;53;-1383.83,1036.283;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;14;130.5618,-316.1066;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;75;467.5212,535.0906;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-1383.83,913.2832;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;68;389.5213,630.0906;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-131.5947,691.5247;Inherit;False;Property;_SurfaceSmoothness;Surface Smoothness ;9;0;Create;True;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-1380.872,814.3197;Inherit;False;50;noRainArea;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;6;-1234.5,-286.5;Inherit;False;Non Stereo Screen Pos;-1;;43;1731ee083b93c104880efc701e11b49b;0;1;23;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-1189.344,1052.392;Inherit;False;rainNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;633.7591,530.0057;Inherit;False;surfaceLevel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-795.5,-294.5;Inherit;False;baseReflUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1209.872,831.3197;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;512.5212,659.0906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1872.237,142.9202;Inherit;False;55;rainNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;21;291.5617,-305.1066;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;18;447.5617,-328.1066;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;60;-1674.237,138.9202;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;659.8044,767.3127;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-1859.5,38.5;Inherit;False;26;baseReflUVs;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;294.1826,-179.4363;Inherit;False;76;surfaceLevel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;-1060.344,899.3918;Inherit;False;rainMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;587.3062,-205.8514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;73;788.8044,768.3127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;-1470.237,121.9202;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-1585.237,-63.07983;Inherit;False;57;rainMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;921.3781,762.6486;Inherit;False;surfaceSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;79;727.1826,-183.4363;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;61;-1222.237,60.92017;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-771.5,113.5;Inherit;True;Property;_ReflectionTex1;_ReflectionTex1;1;1;[HideInInspector];Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-782.5,16.5;Inherit;False;Global;unity_StereoEyeIndex;unity_StereoEyeIndex;2;0;Fetch;True;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-773.5,-188.5;Inherit;True;Property;_ReflectionTex0;_ReflectionTex0;0;1;[HideInInspector];Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;10;-957.5,429.5;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;890.5618,-191.1066;Inherit;False;mirrorOrReflectionSelector;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-973.233,572.7416;Inherit;False;77;surfaceSmoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;4;-435.5,-66.5;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;9;-709.5,432.5;Inherit;False;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-755.5,305.5;Inherit;False;15;mirrorOrReflectionSelector;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;16;-279.5,225.5;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;477.8042,785.3127;Inherit;False;57;rainMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;323.2457,-9.170091;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;RainyMirror;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;29;0
WireConnection;35;0;30;2
WireConnection;39;0;31;0
WireConnection;36;0;34;0
WireConnection;38;0;32;0
WireConnection;33;0;30;2
WireConnection;37;0;33;0
WireConnection;47;0;35;0
WireConnection;48;30;43;0
WireConnection;48;95;46;0
WireConnection;48;31;42;0
WireConnection;49;44;43;0
WireConnection;49;46;41;0
WireConnection;49;49;42;0
WireConnection;49;51;40;0
WireConnection;49;53;45;0
WireConnection;44;0;37;0
WireConnection;66;0;64;0
WireConnection;66;1;65;1
WireConnection;74;0;65;1
WireConnection;74;1;72;0
WireConnection;50;0;44;0
WireConnection;53;0;49;43
WireConnection;53;1;48;94
WireConnection;53;2;51;0
WireConnection;14;0;11;0
WireConnection;75;0;74;0
WireConnection;54;0;49;0
WireConnection;54;1;48;0
WireConnection;54;2;51;0
WireConnection;68;0;66;0
WireConnection;6;23;7;0
WireConnection;55;0;53;0
WireConnection;76;0;75;0
WireConnection;26;0;6;0
WireConnection;56;0;52;0
WireConnection;56;1;54;0
WireConnection;70;0;68;0
WireConnection;70;1;67;0
WireConnection;21;0;14;0
WireConnection;18;0;21;0
WireConnection;60;0;58;0
WireConnection;71;0;70;0
WireConnection;57;0;56;0
WireConnection;63;0;18;0
WireConnection;63;1;78;0
WireConnection;73;0;71;0
WireConnection;59;0;28;0
WireConnection;59;1;60;0
WireConnection;77;0;73;0
WireConnection;79;0;63;0
WireConnection;61;0;28;0
WireConnection;61;1;59;0
WireConnection;61;2;62;0
WireConnection;5;1;61;0
WireConnection;1;1;61;0
WireConnection;10;0;58;0
WireConnection;15;0;79;0
WireConnection;4;0;1;0
WireConnection;4;1;5;0
WireConnection;4;2;8;0
WireConnection;9;0;10;0
WireConnection;9;1;80;0
WireConnection;16;0;4;0
WireConnection;16;1;9;0
WireConnection;16;2;17;0
WireConnection;0;13;16;0
ASEEND*/
//CHKSM=4B1459364CD3574C820AAF4CDCD53DB7A0E619DE