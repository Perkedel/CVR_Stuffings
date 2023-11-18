// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered/FireRedux"
{
	Properties
	{
		_FlameColour1("FlameColour1", Color) = (1,0.5347033,0,0)
		_FlameColour2("FlameColour2", Color) = (0.6886792,0,0,0)
		_NoiseMap("NoiseMap", 2D) = "white" {}
		_FlameOpacityMask("Flame Opacity Mask", 2D) = "white" {}
		_Brightness("Brightness", Range( 1 , 50)) = 3
		_MasterOpacity("MasterOpacity", Range( 0 , 1)) = 1
		_FlameScale("Flame Scale", Range( 0 , 1)) = 0
		_MinReactivity("MinReactivity", Range( 0 , 1)) = 0
		_MaxReactivity("MaxReactivity", Range( 0 , 1)) = 1
		_FlameCoverage("Flame Coverage", Range( 0 , 5)) = 1.853566
		_Tesselation("Tesselation", Range( 0 , 11)) = 2
		_FlameSpeed("Flame Speed", Float) = 2
		[Toggle]_HDR("HDR?", Float) = 1
		[Toggle]_UseAudioLink("Use AudioLink?", Float) = 1
		[Toggle]_AudioLinkFade("AudioLink Fade?", Float) = 1
		[Toggle]_Noise("Noise?", Float) = 1
		_MeshOffsetFixesZFighting("MeshOffset (Fixes Z Fighting)", Float) = 0.0015
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  "DisableBatching"="True" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma multi_compile_instancing
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _NoiseMap;
		uniform float _FlameSpeed;
		uniform float _FlameCoverage;
		uniform float _UseAudioLink;
		uniform float _FlameScale;
		uniform sampler2D _AudioTexture;
		uniform float _MinReactivity;
		uniform float _MaxReactivity;
		uniform float _MeshOffsetFixesZFighting;
		uniform float _HDR;
		uniform float _Noise;
		uniform float4 _FlameColour2;
		uniform float4 _FlameColour1;
		uniform float _Brightness;
		uniform sampler2D _FlameOpacityMask;
		uniform float4 _FlameOpacityMask_ST;
		uniform float _AudioLinkFade;
		uniform float _MasterOpacity;
		uniform float _Tesselation;


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


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float clampResult89 = clamp( _Tesselation , 0.0001 , 7.0 );
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, 1.0,6.0,clampResult89);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 normalizeResult46 = normalize( float3(0,1,0) );
			float4 transform25 = mul(unity_WorldToObject,float4( normalizeResult46 , 0.0 ));
			float4 appendResult38 = (float4(0.12 , 0.06 , 0.0 , 0.0));
			float2 panner32 = ( 1.0 * _Time.y * ( appendResult38 * _FlameSpeed ).xy + v.texcoord.xy);
			float4 lerpResult31 = lerp( float4( 0,0,0,0 ) , transform25 , tex2Dlod( _NoiseMap, float4( panner32, 0, 0.0) ));
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float clampResult18 = clamp( ( distance( ase_worldNormal.y , 3.63 ) - _FlameCoverage ) , 0.0 , 1.0 );
			float temp_output_22_0 = ( 1.0 - clampResult18 );
			float4 lerpResult26 = lerp( float4( 0,0,0,0 ) , lerpResult31 , temp_output_22_0);
			float2 uv_TexCoord123 = v.texcoord.xy * float2( 0,0 );
			float clampResult67 = clamp( tex2Dlod( _AudioTexture, float4( uv_TexCoord123, 0, 0.0) ).r , _MinReactivity , _MaxReactivity );
			float3 ase_vertexNormal = v.normal.xyz;
			float4 lerpResult117 = lerp( ( lerpResult26 * (( _UseAudioLink )?( ( _FlameScale * clampResult67 ) ):( _FlameScale )) ) , float4( ( ase_vertexNormal * 1.2 ) , 0.0 ) , _MeshOffsetFixesZFighting);
			v.vertex.xyz += lerpResult117.xyz;
			v.vertex.w = 1;
			v.normal = ase_vertexNormal;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV6 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode6 = ( 0.01176471 + 1.047126 * pow( 1.0 - fresnelNdotV6, 2.941176 ) );
			float4 lerpResult7 = lerp( _FlameColour2 , _FlameColour1 , fresnelNode6);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 panner138 = ( 1.0 * _Time.y * float2( 11,11 ) + ase_grabScreenPosNorm.xy);
			float simplePerlin2D136 = snoise( panner138*700.0 );
			simplePerlin2D136 = simplePerlin2D136*0.5 + 0.5;
			float clampResult144 = clamp( simplePerlin2D136 , 0.55 , 1.97 );
			float4 temp_output_99_0 = saturate( (( _Noise )?( ( clampResult144 * lerpResult7 ) ):( lerpResult7 )) );
			o.Emission = (( _HDR )?( ( _Brightness * temp_output_99_0 ) ):( temp_output_99_0 )).rgb;
			float2 uv_FlameOpacityMask = i.uv_texcoord * _FlameOpacityMask_ST.xy + _FlameOpacityMask_ST.zw;
			float clampResult18 = clamp( ( distance( ase_worldNormal.y , 3.63 ) - _FlameCoverage ) , 0.0 , 1.0 );
			float temp_output_22_0 = ( 1.0 - clampResult18 );
			float temp_output_20_0 = ( saturate( fresnelNode6 ) * temp_output_22_0 );
			float2 uv_TexCoord123 = i.uv_texcoord * float2( 0,0 );
			float clampResult67 = clamp( tex2D( _AudioTexture, uv_TexCoord123 ).r , _MinReactivity , _MaxReactivity );
			float lerpResult101 = lerp( (( _AudioLinkFade )?( ( temp_output_20_0 * clampResult67 ) ):( temp_output_20_0 )) , 0.0 , ( 1.0 - _MasterOpacity ));
			o.Alpha = saturate( ( tex2D( _FlameOpacityMask, uv_FlameOpacityMask ) * lerpResult101 ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				float3 worldNormal : TEXCOORD4;
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
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
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
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
409;73;1510;926;-1033.385;1492.911;1;True;False
Node;AmplifyShaderEditor.WorldNormalVector;12;-1213,-19.86676;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;13;-1211.095,190.9744;Inherit;False;Constant;_Y_Mask;Y_Mask;2;0;Create;True;0;0;0;False;0;False;3.63;3.63;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1207.443,270.3691;Inherit;False;Property;_FlameCoverage;Flame Coverage;11;0;Create;True;0;0;0;False;0;False;1.853566;2.21;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;14;-923.5477,-27.95709;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-796.6549,1189.112;Inherit;False;Constant;_U;U;6;0;Create;True;0;0;0;False;0;False;0.12;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-794.6549,1263.112;Inherit;False;Constant;_V;V;7;0;Create;True;0;0;0;False;0;False;0.06;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;140;-1726.485,-2831.711;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;15;-696.5112,228.989;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1229.271,-1105.761;Inherit;False;Constant;_Bias;Bias;11;0;Create;True;0;0;0;False;0;False;0.01176471;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1228.271,-927.9608;Inherit;False;Constant;_Power;Power;11;0;Create;True;0;0;0;False;0;False;2.941176;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1229.271,-1018.661;Inherit;False;Constant;_Scale;Scale;11;0;Create;True;0;0;0;False;0;False;1.047126;1.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;-2191.68,1715.691;Inherit;False;2242.094;537.3305;;2;66;123;Audio Reactive Stuff;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-554.0625,1830.304;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-512.6549,1200.112;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-512.8262,1341.924;Inherit;False;Property;_FlameSpeed;Flame Speed;13;0;Create;True;0;0;0;False;0;False;2;1.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;138;-1512.156,-2617.374;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;11,11;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;6;-893.0701,-1019.061;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;18;-598.3643,-23.46333;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;24;-378.4891,852.2966;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;5;-857.8867,-1249.292;Inherit;False;Property;_FlameColour1;FlameColour1;1;0;Create;True;0;0;0;False;0;False;1,0.5347033,0,0;1,0.4613509,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-289.6549,1226.112;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;4;-854.9681,-1426.293;Inherit;False;Property;_FlameColour2;FlameColour2;2;0;Create;True;0;0;0;False;0;False;0.6886792,0,0,0;1,0.3251419,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;136;-1126.629,-2727.558;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;700;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;66;-280.164,1830.818;Inherit;True;Global;_AudioTexture;_AudioTexture;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;22;-472.9273,148.9568;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-27.47027,2293.972;Inherit;False;Property;_MinReactivity;MinReactivity;9;0;Create;True;1;Audio Section;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-79.2702,2386.771;Inherit;False;Property;_MaxReactivity;MaxReactivity;10;0;Create;True;1;Audio Section;0;0;False;0;False;1;0.258;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-484.4186,-1076.498;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-612.6549,1047.112;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;67;263.2608,2276.503;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;144;-806.9603,-2673.65;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.55;False;2;FLOAT;1.97;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;32;-343.9982,1049.745;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;7;-581.1494,-1298.771;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;46;-208.5078,857.8134;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;115.045,-354.8505;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;139;-541.8721,-2093.034;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;30;-111.1752,1028.043;Inherit;True;Property;_NoiseMap;NoiseMap;3;0;Create;True;0;0;0;False;0;False;-1;fd87fe0cd8b988b4583b67788c36a199;fd87fe0cd8b988b4583b67788c36a199;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-74.87294,1599.952;Inherit;False;Property;_FlameScale;Flame Scale;7;0;Create;True;0;0;0;False;0;False;0;0.597;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;25;-59.35371,857.2272;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;102;233.9184,-840.2422;Inherit;False;Property;_MasterOpacity;MasterOpacity;6;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;371.0249,-352.3483;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;31;258.1996,1188.127;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;145;-367.6958,-2633.855;Inherit;False;Property;_Noise;Noise?;17;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;398.0708,2000.838;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;573.2184,-1215.942;Inherit;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;97;511.1038,-726.2633;Inherit;False;Property;_AudioLinkFade;AudioLink Fade?;16;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;104;466.6185,-944.2422;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;101;720.1184,-1066.442;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-99.62049,-2689.846;Inherit;False;Property;_Brightness;Brightness;5;0;Create;True;0;0;0;False;0;False;3;20.04;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;569.9421,-431.3938;Inherit;False;Constant;_Float5;Float 5;21;0;Create;True;0;0;0;False;0;False;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;1859.214,-645.2853;Inherit;False;Property;_Tesselation;Tesselation;12;0;Create;True;0;0;0;False;0;False;2;11;0;11;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;147;1607.473,-1177.326;Inherit;True;Property;_FlameOpacityMask;Flame Opacity Mask;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;84;1849.217,-499.9915;Inherit;False;Constant;_Float4;Float 4;11;0;Create;True;0;0;0;False;0;False;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;414.5911,1032.641;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;53;366.6368,1856.5;Inherit;False;Property;_UseAudioLink;Use AudioLink?;15;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;99;93.21384,-2394.282;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;122;512.9421,-600.3938;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;89;2179.494,-640.1053;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.0001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;761.3232,18.38534;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;716.9421,-593.3938;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;86;1902.134,-397.2505;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;2033.34,-298.6026;Inherit;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;614.9421,-337.3938;Inherit;False;Property;_MeshOffsetFixesZFighting;MeshOffset (Fixes Z Fighting);18;0;Create;True;0;0;0;False;0;False;0.0015;0.0004;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;276.1676,-2629.827;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;2289.846,-855.6003;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;23;2779.008,-745.9503;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StickyNoteNode;29;406.8422,845.7046;Inherit;False;278.7753;165.3486;Calculate Displacement From Y;;1,1,1,1;Calculate displacement from Y normals so the flame always moves up and control the scale.;0;0
Node;AmplifyShaderEditor.LerpOp;117;862.9421,-677.3938;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;88;2179.252,-513.0439;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;100;744.5359,-2664.862;Inherit;False;Property;_HDR;HDR?;14;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;21;116.9232,-461.1081;Inherit;False;187;100;Use Mask On Opacity;;1,1,1,1;Mix the generated mask for opacity.;0;0
Node;AmplifyShaderEditor.StickyNoteNode;8;-1225.25,-1385.345;Inherit;False;327.082;262.8522;Base Colour Stuff;;1,1,1,1;Calculating the surface color with blending between two color values via fresnel.;0;0
Node;AmplifyShaderEditor.StickyNoteNode;19;-1212.723,-182.6948;Inherit;False;730;150;Calculate mask;;1,1,1,1;Calculate a black and white mask using the world normal so that the flame color stays on top.;0;0
Node;AmplifyShaderEditor.SaturateNode;148;2413.079,-847.8258;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2553.405,-1023.55;Float;False;True;-1;6;ASEMaterialInspector;0;0;Unlit;Rollthered/FireRedux;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;ForwardOnly;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;0;32;0.1;0.4;False;0.404;True;2;5;False;-1;10;False;-1;0;5;False;-1;9;False;-1;0;False;-1;0;False;-1;0;False;0.02;0,0,0,0;VertexScale;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;1;DisableBatching=True;False;0;0;False;96;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;12;2
WireConnection;14;1;13;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;38;0;35;0
WireConnection;38;1;36;0
WireConnection;138;0;140;0
WireConnection;6;1;2;0
WireConnection;6;2;1;0
WireConnection;6;3;3;0
WireConnection;18;0;15;0
WireConnection;39;0;38;0
WireConnection;39;1;40;0
WireConnection;136;0;138;0
WireConnection;66;1;123;0
WireConnection;22;0;18;0
WireConnection;9;0;6;0
WireConnection;67;0;66;1
WireConnection;67;1;62;0
WireConnection;67;2;68;0
WireConnection;144;0;136;0
WireConnection;32;0;33;0
WireConnection;32;2;39;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;7;2;6;0
WireConnection;46;0;24;0
WireConnection;20;0;9;0
WireConnection;20;1;22;0
WireConnection;139;0;144;0
WireConnection;139;1;7;0
WireConnection;30;1;32;0
WireConnection;25;0;46;0
WireConnection;98;0;20;0
WireConnection;98;1;67;0
WireConnection;31;1;25;0
WireConnection;31;2;30;0
WireConnection;145;0;7;0
WireConnection;145;1;139;0
WireConnection;52;0;27;0
WireConnection;52;1;67;0
WireConnection;97;0;20;0
WireConnection;97;1;98;0
WireConnection;104;0;102;0
WireConnection;101;0;97;0
WireConnection;101;1;103;0
WireConnection;101;2;104;0
WireConnection;26;1;31;0
WireConnection;26;2;22;0
WireConnection;53;0;27;0
WireConnection;53;1;52;0
WireConnection;99;0;145;0
WireConnection;89;0;85;0
WireConnection;89;2;84;0
WireConnection;28;0;26;0
WireConnection;28;1;53;0
WireConnection;120;0;122;0
WireConnection;120;1;121;0
WireConnection;10;0;11;0
WireConnection;10;1;99;0
WireConnection;146;0;147;0
WireConnection;146;1;101;0
WireConnection;117;0;28;0
WireConnection;117;1;120;0
WireConnection;117;2;118;0
WireConnection;88;0;89;0
WireConnection;88;1;86;0
WireConnection;88;2;87;0
WireConnection;100;0;99;0
WireConnection;100;1;10;0
WireConnection;148;0;146;0
WireConnection;0;2;100;0
WireConnection;0;9;148;0
WireConnection;0;11;117;0
WireConnection;0;12;23;0
WireConnection;0;14;88;0
ASEEND*/
//CHKSM=FAFB669E9A55B84BAB82A0F858EB4D747D85E4AC