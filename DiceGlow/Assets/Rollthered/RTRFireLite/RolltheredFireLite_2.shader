// Upgrade NOTE: upgraded instancing buffer 'RolltheredFireLite' to new syntax.
// Upgrade NOTE: upgraded instancing buffer 'RolltheredFireLiteOutline' to new syntax.

// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Rollthered/Fire Lite"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HDR]_FlameColor("FlameColor", Color) = (42.72251,5.052473,0,0)
		_BaseOpacity("BaseOpacity", Range( 0 , 1)) = 1
		_MainTexSaturation("MainTexSaturation", Float) = 1
		_MinReactivity("MinReactivity", Range( 0 , 1)) = 0
		_MaxReactivity("MaxReactivity", Range( 0 , 1)) = 1
		_MainTex("_MainTex", 2D) = "black" {}
		_noise("noise", 2D) = "white" {}
		_FlameMask("FlameMask", 2D) = "white" {}
		_GlowFlicker("GlowFlicker", Range( 0 , 2)) = 2
		_FlameIntensity("FlameIntensity", Range( 0 , 1)) = 0.01
		_Y_Mask("Y_Mask", Range( 0 , 5)) = 0.9106492
		_Tesselation("Tesselation", Float) = 2
		[Toggle]_FakeLightingGlow("Fake Lighting (Glow)", Float) = 1
		[Toggle]_DisableFlames("Disable Flames?", Float) = 0
		[Toggle]_Rainbow("Rainbow?", Float) = 1
		[HideInInspector]_Color0("Color 0", Color) = (0,0,0,0)
		[Toggle]_MusicHue("MusicHue?", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		ZTest LEqual
		Cull Front
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc tessellate:tessFunction 
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#endif//ASE Sampling Macros
		
		
		UNITY_INSTANCING_BUFFER_START(RolltheredFireLiteOutline)
		UNITY_INSTANCING_BUFFER_END(RolltheredFireLiteOutline)
		void outlineVertexDataFunc( inout appdata_full v )
		{
			float4 _AudioTexture_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_AudioTexture_ST_arr, _AudioTexture_ST);
			float2 uv_AudioTexture = v.texcoord * _AudioTexture_ST_Instance.xy + _AudioTexture_ST_Instance.zw;
			float4 _FlameMask_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_FlameMask_ST_arr, _FlameMask_ST);
			float2 uv_FlameMask = v.texcoord * _FlameMask_ST_Instance.xy + _FlameMask_ST_Instance.zw;
			float clampResult137 = clamp( SAMPLE_TEXTURE2D_LOD( _AudioTexture, sampler_Point_Repeat, uv_AudioTexture, 0.0 ).r , _MinReactivity , ( _MaxReactivity * SAMPLE_TEXTURE2D_LOD( _FlameMask, sampler_FlameMask, uv_FlameMask, 0.0 ) ).r );
			float3 ase_vertexNormal = v.normal.xyz;
			float cos6 = cos( 0.25 * _Time.y );
			float sin6 = sin( 0.25 * _Time.y );
			float2 rotator6 = mul( ase_vertexNormal.xy - float2( 0,0 ) , float2x2( cos6 , -sin6 , sin6 , cos6 )) + float2( 0,0 );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float temp_output_24_0 = distance( ase_worldNormal.y , _Y_Mask );
			float outlineVar = ( ( clampResult137 * ( CalculateContrast(1.1,SAMPLE_TEXTURE2D_LOD( _noise, sampler_noise, rotator6, 0.0 )) * _FlameIntensity ) ) * temp_output_24_0 ).r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float4 _AudioTexture_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_AudioTexture_ST_arr, _AudioTexture_ST);
			float2 uv_AudioTexture = i.uv_texcoord * _AudioTexture_ST_Instance.xy + _AudioTexture_ST_Instance.zw;
			float4 _FlameMask_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_FlameMask_ST_arr, _FlameMask_ST);
			float2 uv_FlameMask = i.uv_texcoord * _FlameMask_ST_Instance.xy + _FlameMask_ST_Instance.zw;
			float clampResult137 = clamp( SAMPLE_TEXTURE2D( _AudioTexture, sampler_Point_Repeat, uv_AudioTexture ).r , _MinReactivity , ( _MaxReactivity * SAMPLE_TEXTURE2D( _FlameMask, sampler_FlameMask, uv_FlameMask ) ).r );
			float4 lerpResult116 = lerp( _FlameColor , _Color0 , clampResult137);
			float3 hsvTorgb86 = RGBToHSV( _FlameColor.rgb );
			float3 hsvTorgb87 = HSVToRGB( float3((( _MusicHue )?( clampResult137 ):( _Time.x )),hsvTorgb86.y,hsvTorgb86.z) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV10 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode10 = ( 0.5992173 + 3.382353 * pow( 1.0 - fresnelNdotV10, 2.0 ) );
			float4 lerpResult18 = lerp( (( _Rainbow )?( float4( hsvTorgb87 , 0.0 ) ):( lerpResult116 )) , (( _Rainbow )?( float4( hsvTorgb87 , 0.0 ) ):( lerpResult116 )) , fresnelNode10);
			float4 temp_cast_4 = (0.0).xxxx;
			float4 temp_cast_5 = (4.0).xxxx;
			float4 clampResult38 = clamp( lerpResult18 , temp_cast_4 , temp_cast_5 );
			float temp_output_24_0 = distance( ase_worldNormal.y , _Y_Mask );
			float clampResult27 = clamp( ( temp_output_24_0 - 1.969366 ) , 0.0 , 1.0 );
			float temp_output_29_0 = ( 1.0 - clampResult27 );
			float4 temp_output_28_0 = ( clampResult38 * temp_output_29_0 );
			o.Emission = temp_output_28_0.rgb;
			clip( (( _DisableFlames )?( 0.0 ):( temp_output_29_0 )) - _Cutoff );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma multi_compile_instancing
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

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

		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform float _MainTexSaturation;
		uniform float _FakeLightingGlow;
		uniform float _GlowFlicker;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_noise);
		SamplerState sampler_noise;
		uniform float _Rainbow;
		uniform float4 _FlameColor;
		uniform float4 _Color0;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_AudioTexture);
		SamplerState sampler_Point_Repeat;
		uniform float _MinReactivity;
		uniform float _MaxReactivity;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FlameMask);
		SamplerState sampler_FlameMask;
		uniform float _MusicHue;
		uniform float _Y_Mask;
		uniform float _BaseOpacity;
		uniform float _Tesselation;
		uniform float _DisableFlames;
		uniform float _Cutoff = 0.5;
		uniform float _FlameIntensity;

		UNITY_INSTANCING_BUFFER_START(RolltheredFireLite)
			UNITY_DEFINE_INSTANCED_PROP(float4, _MainTex_ST)
#define _MainTex_ST_arr RolltheredFireLite
			UNITY_DEFINE_INSTANCED_PROP(float4, _AudioTexture_ST)
#define _AudioTexture_ST_arr RolltheredFireLite
			UNITY_DEFINE_INSTANCED_PROP(float4, _FlameMask_ST)
#define _FlameMask_ST_arr RolltheredFireLite
		UNITY_INSTANCING_BUFFER_END(RolltheredFireLite)


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

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float clampResult75 = clamp( _Tesselation , 0.0 , 5.0 );
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, 0.0,4.0,clampResult75);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			v.vertex.xyz += 0;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float4 _MainTex_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_MainTex_ST_arr, _MainTex_ST);
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST_Instance.xy + _MainTex_ST_Instance.zw;
			float3 hsvTorgb66 = RGBToHSV( SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, uv_MainTex ).rgb );
			float3 hsvTorgb65 = HSVToRGB( float3(hsvTorgb66.x,( hsvTorgb66.y * _MainTexSaturation ),hsvTorgb66.z) );
			o.Albedo = saturate( hsvTorgb65 );
			float cos55 = cos( 0.6 * _Time.y );
			float sin55 = sin( 0.6 * _Time.y );
			float2 rotator55 = mul( float2( 1,0.5 ) - float2( 0.3,0 ) , float2x2( cos55 , -sin55 , sin55 , cos55 )) + float2( 0.3,0 );
			float4 temp_cast_1 = (0.01).xxxx;
			float4 temp_cast_2 = (0.023).xxxx;
			float4 clampResult57 = clamp( ( _GlowFlicker * SAMPLE_TEXTURE2D( _noise, sampler_noise, rotator55 ) ) , temp_cast_1 , temp_cast_2 );
			float4 _AudioTexture_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_AudioTexture_ST_arr, _AudioTexture_ST);
			float2 uv_AudioTexture = i.uv_texcoord * _AudioTexture_ST_Instance.xy + _AudioTexture_ST_Instance.zw;
			float4 _FlameMask_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_FlameMask_ST_arr, _FlameMask_ST);
			float2 uv_FlameMask = i.uv_texcoord * _FlameMask_ST_Instance.xy + _FlameMask_ST_Instance.zw;
			float clampResult137 = clamp( SAMPLE_TEXTURE2D( _AudioTexture, sampler_Point_Repeat, uv_AudioTexture ).r , _MinReactivity , ( _MaxReactivity * SAMPLE_TEXTURE2D( _FlameMask, sampler_FlameMask, uv_FlameMask ) ).r );
			float4 lerpResult116 = lerp( _FlameColor , _Color0 , clampResult137);
			float3 hsvTorgb86 = RGBToHSV( _FlameColor.rgb );
			float3 hsvTorgb87 = HSVToRGB( float3((( _MusicHue )?( clampResult137 ):( _Time.x )),hsvTorgb86.y,hsvTorgb86.z) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV10 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode10 = ( 0.5992173 + 3.382353 * pow( 1.0 - fresnelNdotV10, 2.0 ) );
			float4 lerpResult18 = lerp( (( _Rainbow )?( float4( hsvTorgb87 , 0.0 ) ):( lerpResult116 )) , (( _Rainbow )?( float4( hsvTorgb87 , 0.0 ) ):( lerpResult116 )) , fresnelNode10);
			float4 temp_cast_7 = (0.0).xxxx;
			float4 temp_cast_8 = (4.0).xxxx;
			float4 clampResult38 = clamp( lerpResult18 , temp_cast_7 , temp_cast_8 );
			float temp_output_24_0 = distance( ase_worldNormal.y , _Y_Mask );
			float clampResult27 = clamp( ( temp_output_24_0 - 1.969366 ) , 0.0 , 1.0 );
			float temp_output_29_0 = ( 1.0 - clampResult27 );
			float4 temp_output_28_0 = ( clampResult38 * temp_output_29_0 );
			o.Emission = saturate( ( (( _FakeLightingGlow )?( ( ( clampResult57 * temp_output_28_0 ) * clampResult137 ) ):( float4( 0,0,0,0 ) )) + float4( ( hsvTorgb65 * 0.323 ) , 0.0 ) ) ).rgb;
			float temp_output_62_0 = 0.0;
			float3 temp_cast_11 = (temp_output_62_0).xxx;
			o.Specular = temp_cast_11;
			o.Smoothness = temp_output_62_0;
			o.Occlusion = 1.0;
			o.Alpha = _BaseOpacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

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
				vertexDataFunc( v );
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
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
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
Version=19105
Node;AmplifyShaderEditor.CommentaryNode;121;-3961.69,-687.3934;Inherit;False;2242.094;537.3305;;13;101;102;105;106;118;119;120;107;108;100;104;103;109;Audio Reactive Stuff;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-3874.695,-503.6663;Inherit;False;InstancedProperty;_PulseRotation;Pulse Rotation;15;0;Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;105;-3911.69,-637.3934;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;102;-3609.994,-509.5618;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;106;-3468.434,-574.3667;Inherit;False;RotateUVFill;-1;;5;;0;0;0
Node;AmplifyShaderEditor.DistanceOpNode;118;-3206.55,-502.4959;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;119;-2962.005,-481.723;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2800.47,-265.063;Inherit;False;InstancedProperty;_Pulse;Pulse;9;0;Create;True;1;Pulse Across UVs;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;120;-2803.513,-574.7401;Inherit;False;Property;_RadialPulseToggle;Radial Pulse Toggle;10;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-2804.097,-468.5419;Inherit;False;InstancedProperty;_Band;Band;7;1;[IntRange];Create;True;1;Audio Section;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-2801.448,-367.826;Inherit;False;InstancedProperty;_Delay;Delay;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-1789.479,52.88806;Inherit;False;Property;_MaxReactivity;MaxReactivity;6;0;Create;True;1;Audio Section;0;0;False;0;False;1;0.79;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;141;-2042.577,158.1782;Inherit;True;Property;_FlameMask;FlameMask;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;104;-2405.052,-527.4914;Inherit;True;BandDelayUV;-1;;6;;0;0;0
Node;AmplifyShaderEditor.SamplerStateNode;103;-2304.742,-302.6117;Inherit;False;0;0;0;0;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.CommentaryNode;21;-1304.348,-1584.873;Inherit;False;1149.364;935.4725;;11;86;18;10;84;11;12;13;87;116;140;89;Flame Color + Fresnel = Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;109;-2040.596,-439.3839;Inherit;True;Global;_AudioTexture;_AudioTexture;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;138;-1797.479,-109.1119;Inherit;False;Property;_MinReactivity;MinReactivity;5;0;Create;True;1;Audio Section;0;0;False;0;False;0;0.024;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-1583.05,266.767;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TimeNode;89;-1252.521,-1543.144;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-1599.957,-1141.932;Inherit;False;Property;_FlameColor;FlameColor;0;1;[HDR];Create;True;0;0;0;False;0;False;42.72251,5.052473,0,0;42.72251,2.652841,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;137;-1506.748,-126.5816;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;22;-1297.183,-597.5958;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;117;-1581.116,-1316.674;Inherit;False;Property;_Color0;Color 0;23;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;86;-965.9643,-1291.562;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ToggleSwitchNode;140;-681.1084,-1573.479;Inherit;False;Property;_MusicHue;MusicHue?;24;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-981.8979,-374.4413;Inherit;False;Property;_Y_Mask;Y_Mask;18;0;Create;True;0;0;0;False;0;False;0.9106492;3.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1267.783,-790.4128;Inherit;False;Constant;_Power;Power;5;0;Create;True;0;0;0;False;0;False;2;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1280.783,-930.4129;Inherit;False;Constant;_Scale;Scale;5;0;Create;True;0;0;0;False;0;False;3.382353;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;24;-729.9209,-611.7958;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;116;-1238.07,-1295.817;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1309.783,-1026.413;Inherit;False;Constant;_Bias;Bias;5;0;Create;True;0;0;0;False;0;False;0.5992173;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;87;-484.65,-1455.542;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;26;-928.9787,-242.64;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;0;False;0;False;1.969366;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;-701.4397,-1185.393;Inherit;False;Property;_Rainbow;Rainbow?;22;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-423.8365,-422.4247;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;10;-989.5511,-943.477;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;55;400.8644,-1289.059;Inherit;False;3;0;FLOAT2;1,0.5;False;1;FLOAT2;0.3,0;False;2;FLOAT;0.6;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-45.17066,-566.6459;Inherit;False;Constant;_clampmax;clampmax;9;0;Create;True;0;0;0;False;0;False;4;0;4;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-403.5143,-1157.822;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;52;988.6638,-1306.211;Inherit;False;Property;_GlowFlicker;GlowFlicker;16;0;Create;True;0;0;0;False;0;False;2;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;27;-197.2343,-392.1375;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;54;672.4893,-1338.04;Inherit;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;4;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;31;-1304.393,164.7483;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-79.65421,-706.9581;Inherit;False;Constant;_clampmin;clampmin;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;6;-1051.445,78.73088;Inherit;False;3;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;2;FLOAT;0.25;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;29;-21.95561,-260.5018;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;1238.61,-1193.639;Inherit;False;Constant;_ClampMax1;ClampMax1;7;0;Create;True;0;0;0;False;0;False;0.023;0;0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;38;171.4106,-732.7088;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1278.61,-1400.639;Inherit;False;Constant;_ClampMin1;ClampMin1;7;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;453.8337,-295.737;Inherit;True;Property;_MainTex;_MainTex;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;1156.668,-1112.802;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-835.7618,47.28276;Inherit;True;Property;_noise;noise;12;0;Create;True;0;0;0;False;0;False;-1;None;03401d5a2c1f5a7479bca34191566a6e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;744.3994,-134.3599;Inherit;False;Property;_MainTexSaturation;MainTexSaturation;3;0;Create;True;1;Other Stuff;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;66;750.5821,-381.7567;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;179.678,-304.5824;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;57;1425.61,-1188.639;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;976.512,-177.5233;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;37;-525.9293,-55.22998;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;1.1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;1588.734,-1091.692;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-825.0314,383.3525;Inherit;False;Property;_FlameIntensity;FlameIntensity;17;0;Create;True;0;0;0;False;0;False;0.01;0.301;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;1438.013,-666.3982;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;658.9769,285.8842;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;0;False;0;False;0.323;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-415.8747,530.7612;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.HSVToRGBNode;65;1086.822,-318.2803;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;42;821.3916,536.1104;Inherit;False;Property;_Tesselation;Tesselation;19;0;Create;True;0;0;0;False;0;False;2;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;61;1650.688,-629.6226;Inherit;False;Property;_FakeLightingGlow;Fake Lighting (Glow);20;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-320.0517,29.18719;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-141.9102,349.0138;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;76;739.5709,662.0643;Inherit;False;Constant;_Float4;Float 4;11;0;Create;True;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;863.7381,284.9856;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;72;-110.072,64.3073;Inherit;False;Property;_DisableFlames;Disable Flames?;21;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;1015.187,233.0648;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;923.6949,863.4532;Inherit;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;166.3368,362.6759;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;75;1076.571,520.0643;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;792.4884,764.8052;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;1158.252,368.7849;Inherit;False;Property;_BaseOpacity;BaseOpacity;2;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;41;1069.606,649.0118;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;69;1559.929,-224.3459;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OutlineNode;1;348.8928,322.4187;Inherit;False;0;True;Masked;0;3;Front;True;True;True;True;0;False;;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;132;-769.3457,643.182;Inherit;False;Constant;_Vector0;Vector 0;21;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;63;1213.835,252.2272;Inherit;False;Constant;_verynice;very nice;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;1214.835,183.2272;Inherit;False;Constant;_nice;nice;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;1213.775,116.1637;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;83;-853.1919,1124.827;Inherit;True;Property;_FireWidthAlphaMap;Fire Width Alpha Map;14;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;e9c4642eaa083a54ab91406d8449e6ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1456.804,199.3185;Float;False;True;-1;6;ASEMaterialInspector;0;0;StandardSpecular;Rollthered/Fire Lite;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;5;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;0;2;0;2;False;1;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;102;0;101;0
WireConnection;119;0;118;0
WireConnection;120;1;119;0
WireConnection;109;7;103;0
WireConnection;143;0;139;0
WireConnection;143;1;141;0
WireConnection;137;0;109;1
WireConnection;137;1;138;0
WireConnection;137;2;143;0
WireConnection;86;0;15;0
WireConnection;140;0;89;1
WireConnection;140;1;137;0
WireConnection;24;0;22;2
WireConnection;24;1;23;0
WireConnection;116;0;15;0
WireConnection;116;1;117;0
WireConnection;116;2;137;0
WireConnection;87;0;140;0
WireConnection;87;1;86;2
WireConnection;87;2;86;3
WireConnection;84;0;116;0
WireConnection;84;1;87;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;10;1;11;0
WireConnection;10;2;12;0
WireConnection;10;3;13;0
WireConnection;18;0;84;0
WireConnection;18;1;84;0
WireConnection;18;2;10;0
WireConnection;27;0;25;0
WireConnection;54;1;55;0
WireConnection;6;0;31;0
WireConnection;29;0;27;0
WireConnection;38;0;18;0
WireConnection;38;1;39;0
WireConnection;38;2;40;0
WireConnection;56;0;52;0
WireConnection;56;1;54;0
WireConnection;4;1;6;0
WireConnection;66;0;34;0
WireConnection;28;0;38;0
WireConnection;28;1;29;0
WireConnection;57;0;56;0
WireConnection;57;1;58;0
WireConnection;57;2;59;0
WireConnection;67;0;66;2
WireConnection;67;1;68;0
WireConnection;37;1;4;0
WireConnection;51;0;57;0
WireConnection;51;1;28;0
WireConnection;122;0;51;0
WireConnection;122;1;137;0
WireConnection;3;0;37;0
WireConnection;3;1;2;0
WireConnection;65;0;66;1
WireConnection;65;1;67;0
WireConnection;65;2;66;3
WireConnection;61;1;122;0
WireConnection;81;0;137;0
WireConnection;81;1;3;0
WireConnection;35;0;65;0
WireConnection;35;1;36;0
WireConnection;72;0;29;0
WireConnection;72;1;74;0
WireConnection;53;0;61;0
WireConnection;53;1;35;0
WireConnection;131;0;81;0
WireConnection;131;1;24;0
WireConnection;75;0;42;0
WireConnection;75;2;76;0
WireConnection;41;0;75;0
WireConnection;41;1;43;0
WireConnection;41;2;44;0
WireConnection;69;0;65;0
WireConnection;1;0;28;0
WireConnection;1;2;72;0
WireConnection;1;1;131;0
WireConnection;70;0;53;0
WireConnection;0;0;69;0
WireConnection;0;2;70;0
WireConnection;0;3;62;0
WireConnection;0;4;62;0
WireConnection;0;5;63;0
WireConnection;0;9;123;0
WireConnection;0;11;1;0
WireConnection;0;14;41;0
ASEEND*/
//CHKSM=49AFAFA97C77A43A0A95031F6F43D59928B289D9