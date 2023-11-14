// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Silent/RainyStandard"
{
	Properties
	{
		_RainPattern("Rain Pattern", 2D) = "gray" {}
		[NoScaleOffset]_RippleNormals("Ripple Normals", 2D) = "bump" {}
		[NoScaleOffset]_DropletNormals("Droplet Normals", 2D) = "bump" {}
		_RainSpeed("Rain Speed", Float) = 1
		_StreakTiling("Streak Tiling", Float) = 64
		_StreakLength("Streak Length", Float) = 2
		_MainTexture("MainTexture", 2D) = "white" {}
		_BumpMap("BumpMap", 2D) = "bump" {}
		_MetallicGlossMap("Metallic / Occlusion / Emission / Smoothness", 2D) = "black" {}
		_GlossMapScale("Smoothness", Range( 0 , 1)) = 1
		_RainFade1("Rain Fade", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _RippleNormals;
		uniform sampler2D _RainPattern;
		uniform float4 _RainPattern_ST;
		uniform float _RainSpeed;
		uniform sampler2D _DropletNormals;
		uniform float _StreakTiling;
		uniform float _StreakLength;
		uniform float _RainFade1;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform float _GlossMapScale;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 normal83 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 ase_worldPos = i.worldPos;
			float2 worldUVs114_g39 = (ase_worldPos).xz;
			float2 temp_output_20_0_g39 = (worldUVs114_g39*_RainPattern_ST.xy + ( _RainPattern_ST.zw + float2( 0,0 ) ));
			float3 rippleNormalsSample1101_g39 = UnpackNormal( tex2D( _RippleNormals, temp_output_20_0_g39 ) );
			float2 temp_output_41_0_g39 = (worldUVs114_g39*_RainPattern_ST.xy + ( _RainPattern_ST.zw + 0.1 ));
			float3 rippleNormalsSample2104_g39 = UnpackNormal( tex2D( _RippleNormals, temp_output_41_0_g39 ) );
			float rainSpeed23 = _RainSpeed;
			float rainSpeed60_g39 = rainSpeed23;
			float temp_output_19_0_g39 = ( ( _Time.y + 0.0 ) * rainSpeed60_g39 );
			float rainTime29_g39 = temp_output_19_0_g39;
			float temp_output_12_0_g39 = abs( sin( ( rainTime29_g39 * UNITY_PI ) ) );
			float3 lerpResult111_g39 = lerp( rippleNormalsSample1101_g39 , rippleNormalsSample2104_g39 , temp_output_12_0_g39);
			float rainSpeed45_g38 = rainSpeed23;
			float streakTiling107 = _StreakTiling;
			float streakTiling50_g38 = streakTiling107;
			float3 break59_g38 = ( ( ase_worldPos + ( _Time.y * float3(0,0,0) * rainSpeed45_g38 ) ) / streakTiling50_g38 );
			float streakLength109 = _StreakLength;
			float streakLength52_g38 = streakLength109;
			float3 appendResult13_g38 = (float3(break59_g38.x , ( break59_g38.y / streakLength52_g38 ) , break59_g38.z));
			float2 temp_output_29_0_g38 = (appendResult13_g38).xy;
			float3 break24_g38 = appendResult13_g38;
			float2 appendResult28_g38 = (float2(break24_g38.z , break24_g38.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float temp_output_30_0_g38 = saturate( abs( ase_worldNormal.x ) );
			float3 lerpResult57_g38 = lerp( UnpackNormal( tex2D( _DropletNormals, temp_output_29_0_g38 ) ) , UnpackNormal( tex2D( _DropletNormals, appendResult28_g38 ) ) , temp_output_30_0_g38);
			float lerpResult36_g38 = lerp( tex2D( _RainPattern, temp_output_29_0_g38 ).g , tex2D( _RainPattern, appendResult28_g38 ).g , temp_output_30_0_g38);
			float3 temp_output_19_0_g38 = ( ( appendResult13_g38 * float3( 1,0.5,1 ) ) + ( _Time.y * float3(0,1,0) * rainSpeed45_g38 ) );
			float3 break20_g38 = temp_output_19_0_g38;
			float2 appendResult22_g38 = (float2(break20_g38.z , break20_g38.y));
			float lerpResult34_g38 = lerp( tex2D( _RainPattern, (temp_output_19_0_g38).xy ).b , tex2D( _RainPattern, appendResult22_g38 ).b , temp_output_30_0_g38);
			float temp_output_40_0_g38 = saturate( ( ( lerpResult36_g38 - pow( lerpResult34_g38 , 4.0 ) ) * 5.0 ) );
			float3 lerpResult58_g38 = lerp( float3( 0,0,1 ) , lerpResult57_g38 , temp_output_40_0_g38);
			float3 newWorldNormal104 = (WorldNormalVector( i , float3(0,0,1) ));
			float rainAxis169 = saturate( newWorldNormal104.y );
			float3 lerpResult172 = lerp( lerpResult111_g39 , lerpResult58_g38 , rainAxis169);
			float3 rainNormals95 = lerpResult172;
			float noRainArea181 = ( 1.0 - saturate( -newWorldNormal104.y ) );
			float temp_output_25_0_g39 = ( (tex2D( _RainPattern, temp_output_20_0_g39 )).r - ( 1.0 - frac( temp_output_19_0_g39 ) ) );
			float smoothstepResult11_g39 = smoothstep( 0.0 , 1.0 , ( distance( temp_output_25_0_g39 , 0.05 ) / max( 0.05 , saturate( fwidth( temp_output_25_0_g39 ) ) ) ));
			float temp_output_40_0_g39 = ( ( _Time.y + 0.5 ) * rainSpeed60_g39 );
			float temp_output_45_0_g39 = ( (tex2D( _RainPattern, temp_output_41_0_g39 )).r - ( 1.0 - frac( temp_output_40_0_g39 ) ) );
			float smoothstepResult65_g39 = smoothstep( 0.0 , 1.0 , ( distance( temp_output_45_0_g39 , 0.05 ) / max( 0.05 , saturate( fwidth( temp_output_45_0_g39 ) ) ) ));
			float rainTime246_g39 = temp_output_40_0_g39;
			float lerpResult170 = lerp( temp_output_40_0_g38 , ( ( ( 1.0 - smoothstepResult11_g39 ) * temp_output_12_0_g39 ) + ( ( 1.0 - smoothstepResult65_g39 ) * abs( sin( ( rainTime246_g39 * UNITY_PI ) ) ) ) ) , rainAxis169);
			float rainMask94 = ( noRainArea181 * lerpResult170 * _RainFade1 );
			float3 lerpResult72 = lerp( normal83 , BlendNormals( normal83 , rainNormals95 ) , rainMask94);
			o.Normal = lerpResult72;
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 albedo81 = tex2D( _MainTexture, uv_MainTexture );
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode86 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			float metalness87 = tex2DNode86.r;
			float4 lerpResult176 = lerp( ( albedo81 * albedo81 ) , albedo81 , metalness87);
			o.Albedo = lerpResult176.rgb;
			float lerpResult101 = lerp( metalness87 , 0.0 , rainMask94);
			o.Metallic = lerpResult101;
			float smoothness91 = ( tex2DNode86.a * _GlossMapScale );
			float lerpResult93 = lerp( smoothness91 , 1.0 , rainMask94);
			o.Smoothness = lerpResult93;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
Version=18800
2085;425;1599;1521;840.6495;613.8325;1;True;False
Node;AmplifyShaderEditor.Vector3Node;105;341.2166,1202.67;Inherit;False;Constant;_001;0,0,1;6;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;104;501.2166,1201.67;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;108;-56.60321,-323.2779;Inherit;False;Property;_StreakLength;Streak Length;5;0;Create;True;0;0;0;False;0;False;2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-54.60321,-401.2779;Inherit;False;Property;_StreakTiling;Streak Tiling;4;0;Create;True;0;0;0;False;0;False;64;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-62.21326,-486.3096;Inherit;False;Property;_RainSpeed;Rain Speed;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;184;714.8278,1353.959;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;98.91766,-319.4002;Inherit;False;streakLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;180;859.9448,1357.686;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;101.9177,-397.4002;Inherit;False;streakTiling;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;168;772.9872,1215.65;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;94.30762,-482.4319;Inherit;False;rainSpeed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;169;917.9872,1213.65;Inherit;False;rainAxis;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-360.4286,-271.8782;Inherit;True;Property;_RainPattern;Rain Pattern;0;0;Create;True;0;0;0;False;0;False;None;None;False;gray;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;24;-352,144;Inherit;False;23;rainSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;68;-366.9276,-53.66895;Inherit;True;Property;_RippleNormals;Ripple Normals;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.OneMinusNode;185;1008.828,1353.959;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-352,224;Inherit;False;107;streakTiling;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;-352,304;Inherit;False;109;streakLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;160;-354.7356,388.0042;Inherit;True;Property;_DropletNormals;Droplet Normals;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;None;None;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;1180.945,1345.686;Inherit;False;noRainArea;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;189;-26.63965,134.8741;Inherit;False;RainWallRipples;-1;;38;ee9ea9189ac23aa45a8a9696e2cd39f3;0;5;44;SAMPLER2D;;False;46;SAMPLER2D;;False;49;FLOAT;0;False;51;FLOAT;0;False;53;FLOAT;0;False;2;FLOAT;0;FLOAT3;43
Node;AmplifyShaderEditor.FunctionNode;134;-27.47714,15.27545;Inherit;False;RainGroundRipples;-1;;39;1e4f1751c78baf34ea6ca6afecb86f67;0;3;30;SAMPLER2D;;False;95;SAMPLER2D;;False;31;FLOAT;0;False;2;FLOAT;0;FLOAT3;94
Node;AmplifyShaderEditor.GetLocalVarNode;171;143.9872,298.6495;Inherit;False;169;rainAxis;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;80;-573.2625,1355.961;Inherit;True;Property;_MainTexture;MainTexture;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;82;-574.2784,1551.038;Inherit;True;Property;_BumpMap;BumpMap;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;174;-568.4089,1972.794;Inherit;False;Property;_GlossMapScale;Smoothness;9;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;86;-575.054,1744.115;Inherit;True;Property;_MetallicGlossMap;Metallic / Occlusion / Emission / Smoothness;8;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;172;347.9872,174.6495;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;170;351.9872,43.64954;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;254.8626,-140.0419;Inherit;False;Property;_RainFade1;Rain Fade;10;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;354.9448,-55.31396;Inherit;False;181;noRainArea;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;656.4727,137.7581;Inherit;False;rainNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;-186.4089,1935.794;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;594.9448,-49.31396;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-271.5026,1571.359;Inherit;False;normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-245.0858,1361.041;Inherit;False;albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;226.9077,796.1983;Inherit;False;83;normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;749.4727,-50.24194;Inherit;False;rainMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-0.5273438,1933.758;Inherit;False;smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;87;-223.2044,1701.5;Inherit;False;metalness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;241.4727,914.7581;Inherit;False;95;rainNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;639.2381,335.6136;Inherit;False;81;albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;75;438.0724,895.3311;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;614.4727,461.7581;Inherit;False;87;metalness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;839.1996,370.5432;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;683.4727,554.7581;Inherit;False;94;rainMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;457.4727,1002.758;Inherit;False;94;rainMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;690.4727,722.7581;Inherit;False;94;rainMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;676.4727,634.7581;Inherit;False;91;smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-221.5273,1775.758;Inherit;False;occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;176;897.1996,212.5432;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;93;855.4727,685.7581;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;72;681.0724,810.3311;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;101;894.4727,512.7581;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;875.3116,1028.417;Inherit;False;125;__debug__;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-219.5273,1850.758;Inherit;False;emission;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;1302.6,1037.228;Inherit;False;__debug__;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;866.6249,853.1573;Inherit;False;finalNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1452.8,292.6;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Silent/RainyStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;104;0;105;0
WireConnection;184;0;104;2
WireConnection;109;0;108;0
WireConnection;180;0;184;0
WireConnection;107;0;106;0
WireConnection;168;0;104;2
WireConnection;23;0;11;0
WireConnection;169;0;168;0
WireConnection;185;0;180;0
WireConnection;181;0;185;0
WireConnection;189;44;2;0
WireConnection;189;46;160;0
WireConnection;189;49;24;0
WireConnection;189;51;163;0
WireConnection;189;53;162;0
WireConnection;134;30;2;0
WireConnection;134;95;68;0
WireConnection;134;31;24;0
WireConnection;172;0;134;94
WireConnection;172;1;189;43
WireConnection;172;2;171;0
WireConnection;170;0;189;0
WireConnection;170;1;134;0
WireConnection;170;2;171;0
WireConnection;95;0;172;0
WireConnection;173;0;86;4
WireConnection;173;1;174;0
WireConnection;182;0;183;0
WireConnection;182;1;170;0
WireConnection;182;2;190;0
WireConnection;83;0;82;0
WireConnection;81;0;80;0
WireConnection;94;0;182;0
WireConnection;91;0;173;0
WireConnection;87;0;86;1
WireConnection;75;0;84;0
WireConnection;75;1;96;0
WireConnection;175;0;88;0
WireConnection;175;1;88;0
WireConnection;89;0;86;2
WireConnection;176;0;175;0
WireConnection;176;1;88;0
WireConnection;176;2;99;0
WireConnection;93;0;92;0
WireConnection;93;2;98;0
WireConnection;72;0;84;0
WireConnection;72;1;75;0
WireConnection;72;2;97;0
WireConnection;101;0;99;0
WireConnection;101;2;100;0
WireConnection;90;0;86;3
WireConnection;191;0;72;0
WireConnection;0;0;176;0
WireConnection;0;1;72;0
WireConnection;0;3;101;0
WireConnection;0;4;93;0
ASEEND*/
//CHKSM=CCDACE5C60D5C602F3055BA93ECEB97579D0BC4D