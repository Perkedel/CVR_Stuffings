// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered/FireReduxNoTessellation "
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
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 normalizeResult138 = normalize( float3(0,1,0) );
			float4 transform143 = mul(unity_WorldToObject,float4( normalizeResult138 , 0.0 ));
			float4 appendResult118 = (float4(0.12 , 0.06 , 0.0 , 0.0));
			float2 panner136 = ( 1.0 * _Time.y * ( appendResult118 * _FlameSpeed ).xy + v.texcoord.xy);
			float4 lerpResult146 = lerp( float4( 0,0,0,0 ) , transform143 , tex2Dlod( _NoiseMap, float4( panner136, 0, 0.0) ));
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float clampResult122 = clamp( ( distance( ase_worldNormal.y , 3.63 ) - _FlameCoverage ) , 0.0 , 1.0 );
			float temp_output_129_0 = ( 1.0 - clampResult122 );
			float4 lerpResult158 = lerp( float4( 0,0,0,0 ) , lerpResult146 , temp_output_129_0);
			float2 uv_TexCoord117 = v.texcoord.xy * float2( 0,0 );
			float clampResult134 = clamp( tex2Dlod( _AudioTexture, float4( uv_TexCoord117, 0, 0.0) ).r , _MinReactivity , _MaxReactivity );
			float3 ase_vertexNormal = v.normal.xyz;
			float4 lerpResult172 = lerp( ( lerpResult158 * (( _UseAudioLink )?( ( _FlameScale * clampResult134 ) ):( _FlameScale )) ) , float4( ( ase_vertexNormal * 1.2 ) , 0.0 ) , _MeshOffsetFixesZFighting);
			v.vertex.xyz += lerpResult172.xyz;
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
			float fresnelNdotV121 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode121 = ( 0.01176471 + 1.047126 * pow( 1.0 - fresnelNdotV121, 2.941176 ) );
			float4 lerpResult137 = lerp( _FlameColour2 , _FlameColour1 , fresnelNode121);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 panner120 = ( 1.0 * _Time.y * float2( 11,11 ) + ase_grabScreenPosNorm.xy);
			float simplePerlin2D127 = snoise( panner120*700.0 );
			simplePerlin2D127 = simplePerlin2D127*0.5 + 0.5;
			float clampResult135 = clamp( simplePerlin2D127 , 0.55 , 1.97 );
			float4 temp_output_160_0 = saturate( (( _Noise )?( ( clampResult135 * lerpResult137 ) ):( lerpResult137 )) );
			o.Emission = (( _HDR )?( ( _Brightness * temp_output_160_0 ) ):( temp_output_160_0 )).rgb;
			float2 uv_FlameOpacityMask = i.uv_texcoord * _FlameOpacityMask_ST.xy + _FlameOpacityMask_ST.zw;
			float clampResult122 = clamp( ( distance( ase_worldNormal.y , 3.63 ) - _FlameCoverage ) , 0.0 , 1.0 );
			float temp_output_129_0 = ( 1.0 - clampResult122 );
			float temp_output_139_0 = ( saturate( fresnelNode121 ) * temp_output_129_0 );
			float2 uv_TexCoord117 = i.uv_texcoord * float2( 0,0 );
			float clampResult134 = clamp( tex2D( _AudioTexture, uv_TexCoord117 ).r , _MinReactivity , _MaxReactivity );
			float lerpResult152 = lerp( (( _AudioLinkFade )?( ( temp_output_139_0 * clampResult134 ) ):( temp_output_139_0 )) , 0.0 , ( 1.0 - _MasterOpacity ));
			o.Alpha = saturate( ( tex2D( _FlameOpacityMask, uv_FlameOpacityMask ) * lerpResult152 ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

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
				vertexDataFunc( v, customInputData );
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
765;73;1154;926;1242.722;2219.849;2.104463;True;False
Node;AmplifyShaderEditor.WorldNormalVector;105;-3029.414,122.0165;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;106;-3027.509,332.8577;Inherit;False;Constant;_Y_Mask;Y_Mask;2;0;Create;True;0;0;0;False;0;False;3.63;3.63;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-3023.857,412.2524;Inherit;False;Property;_FlameCoverage;Flame Coverage;10;0;Create;True;0;0;0;False;0;False;1.853566;2.21;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;108;-2739.962,113.9262;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;-2613.069,1330.995;Inherit;False;Constant;_U;U;6;0;Create;True;0;0;0;False;0;False;0.12;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-2611.069,1404.995;Inherit;False;Constant;_V;V;7;0;Create;True;0;0;0;False;0;False;0.06;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;111;-3542.899,-2689.828;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;112;-2512.925,370.8723;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-3045.685,-963.8776;Inherit;False;Constant;_Bias;Bias;11;0;Create;True;0;0;0;False;0;False;0.01176471;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-3044.685,-786.0774;Inherit;False;Constant;_Power;Power;11;0;Create;True;0;0;0;False;0;False;2.941176;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-3045.685,-876.7776;Inherit;False;Constant;_Scale;Scale;11;0;Create;True;0;0;0;False;0;False;1.047126;1.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;116;-4008.094,1857.574;Inherit;False;2242.094;537.3305;;2;128;117;Audio Reactive Stuff;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;119;-2329.24,1483.807;Inherit;False;Property;_FlameSpeed;Flame Speed;11;0;Create;True;0;0;0;False;0;False;2;1.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;122;-2414.779,118.42;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;121;-2709.484,-877.1777;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;120;-3328.57,-2475.491;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;11,11;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;118;-2329.069,1341.995;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-2370.476,1972.187;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;131;-1895.683,2528.654;Inherit;False;Property;_MaxReactivity;MaxReactivity;9;0;Create;True;1;Audio Section;0;0;False;0;False;1;0.258;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;123;-2194.903,994.1798;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;124;-2674.301,-1107.409;Inherit;False;Property;_FlameColour1;FlameColour1;0;0;Create;True;0;0;0;False;0;False;1,0.5347033,0,0;1,0.4613509,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-2106.068,1367.995;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;126;-2671.382,-1284.41;Inherit;False;Property;_FlameColour2;FlameColour2;1;0;Create;True;0;0;0;False;0;False;0.6886792,0,0,0;1,0.3251419,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;127;-2943.043,-2585.675;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;700;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-2096.577,1972.701;Inherit;True;Global;_AudioTexture;_AudioTexture;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;129;-2289.342,290.8401;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-1843.883,2435.855;Inherit;False;Property;_MinReactivity;MinReactivity;8;0;Create;True;1;Audio Section;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;133;-2429.069,1188.995;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;132;-2300.833,-934.6146;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;138;-2024.921,999.6967;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;139;-1701.368,-212.9672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;137;-2397.563,-1156.888;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;135;-2623.374,-2531.767;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.55;False;2;FLOAT;1.97;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;136;-2160.412,1191.628;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;134;-1553.152,2418.386;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-2358.286,-1951.151;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;141;-1927.588,1169.926;Inherit;True;Property;_NoiseMap;NoiseMap;2;0;Create;True;0;0;0;False;0;False;-1;fd87fe0cd8b988b4583b67788c36a199;fd87fe0cd8b988b4583b67788c36a199;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;142;-1891.286,1741.835;Inherit;False;Property;_FlameScale;Flame Scale;6;0;Create;True;0;0;0;False;0;False;0;0.597;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;143;-1875.767,999.1105;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;144;-1582.494,-698.3588;Inherit;False;Property;_MasterOpacity;MasterOpacity;5;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1445.388,-210.465;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;151;-1349.794,-802.3588;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-1243.194,-1074.059;Inherit;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-1418.342,2142.722;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;150;-1305.309,-584.3799;Inherit;False;Property;_AudioLinkFade;AudioLink Fade?;14;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;146;-1558.213,1330.01;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;147;-2184.11,-2491.972;Inherit;False;Property;_Noise;Noise?;15;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;152;-1096.294,-924.5584;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;153;-1916.033,-2547.963;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;0;False;0;False;3;20.04;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;-1246.471,-289.5105;Inherit;False;Constant;_Float5;Float 5;21;0;Create;True;0;0;0;False;0;False;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;156;-208.94,-1035.443;Inherit;True;Property;_FlameOpacityMask;Flame Opacity Mask;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;158;-1401.822,1174.524;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;159;-1449.776,1998.383;Inherit;False;Property;_UseAudioLink;Use AudioLink?;13;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;160;-1723.199,-2252.399;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;161;-1303.471,-458.5104;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;167;-1201.471,-195.5105;Inherit;False;Property;_MeshOffsetFixesZFighting;MeshOffset (Fixes Z Fighting);16;0;Create;True;0;0;0;False;0;False;0.0015;0.0004;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;473.433,-713.7169;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;163;-1055.09,160.2686;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-1099.471,-451.5104;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-1540.245,-2487.944;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;175;-1699.49,-319.2248;Inherit;False;187;100;Use Mask On Opacity;;1,1,1,1;Mix the generated mask for opacity.;0;0
Node;AmplifyShaderEditor.StickyNoteNode;176;-3041.664,-1243.462;Inherit;False;327.082;262.8522;Base Colour Stuff;;1,1,1,1;Calculating the surface color with blending between two color values via fresnel.;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;174;-1071.877,-2522.979;Inherit;False;Property;_HDR;HDR?;12;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;178;596.666,-705.9424;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;171;-1409.571,987.5879;Inherit;False;278.7753;165.3486;Calculate Displacement From Y;;1,1,1,1;Calculate displacement from Y normals so the flame always moves up and control the scale.;0;0
Node;AmplifyShaderEditor.NormalVertexDataNode;170;962.595,-604.0669;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StickyNoteNode;177;-3029.137,-40.8115;Inherit;False;730;150;Calculate mask;;1,1,1,1;Calculate a black and white mask using the world normal so that the flame color stays on top.;0;0
Node;AmplifyShaderEditor.LerpOp;172;-953.4709,-535.5104;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;740.6106,-878.8163;Float;False;True;-1;6;ASEMaterialInspector;0;0;Unlit;Rollthered/FireReduxNoTessellation ;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;32;0.1;0.4;True;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;1;DisableBatching=True;False;0;0;False;96;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;108;0;105;2
WireConnection;108;1;106;0
WireConnection;112;0;108;0
WireConnection;112;1;107;0
WireConnection;122;0;112;0
WireConnection;121;1;113;0
WireConnection;121;2;115;0
WireConnection;121;3;114;0
WireConnection;120;0;111;0
WireConnection;118;0;109;0
WireConnection;118;1;110;0
WireConnection;125;0;118;0
WireConnection;125;1;119;0
WireConnection;127;0;120;0
WireConnection;128;1;117;0
WireConnection;129;0;122;0
WireConnection;132;0;121;0
WireConnection;138;0;123;0
WireConnection;139;0;132;0
WireConnection;139;1;129;0
WireConnection;137;0;126;0
WireConnection;137;1;124;0
WireConnection;137;2;121;0
WireConnection;135;0;127;0
WireConnection;136;0;133;0
WireConnection;136;2;125;0
WireConnection;134;0;128;1
WireConnection;134;1;130;0
WireConnection;134;2;131;0
WireConnection;140;0;135;0
WireConnection;140;1;137;0
WireConnection;141;1;136;0
WireConnection;143;0;138;0
WireConnection;145;0;139;0
WireConnection;145;1;134;0
WireConnection;151;0;144;0
WireConnection;148;0;142;0
WireConnection;148;1;134;0
WireConnection;150;0;139;0
WireConnection;150;1;145;0
WireConnection;146;1;143;0
WireConnection;146;2;141;0
WireConnection;147;0;137;0
WireConnection;147;1;140;0
WireConnection;152;0;150;0
WireConnection;152;1;149;0
WireConnection;152;2;151;0
WireConnection;158;1;146;0
WireConnection;158;2;129;0
WireConnection;159;0;142;0
WireConnection;159;1;148;0
WireConnection;160;0;147;0
WireConnection;169;0;156;0
WireConnection;169;1;152;0
WireConnection;163;0;158;0
WireConnection;163;1;159;0
WireConnection;164;0;161;0
WireConnection;164;1;154;0
WireConnection;168;0;153;0
WireConnection;168;1;160;0
WireConnection;174;0;160;0
WireConnection;174;1;168;0
WireConnection;178;0;169;0
WireConnection;172;0;163;0
WireConnection;172;1;164;0
WireConnection;172;2;167;0
WireConnection;0;2;174;0
WireConnection;0;9;178;0
WireConnection;0;11;172;0
WireConnection;0;12;170;0
ASEEND*/
//CHKSM=DBFB14905FF18C3DA34063821D97EDE69E006547