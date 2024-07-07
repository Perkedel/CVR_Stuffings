// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Naito/SketchyShader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.69
		_Hatch1("Hatch 1", 2D) = "white" {}
		_Hatch2("Hatch 2", 2D) = "white" {}
		_Hatch3("Hatch 3", 2D) = "white" {}
		_Hatch4("Hatch 4", 2D) = "white" {}
		_Hatch5("Hatch 5", 2D) = "white" {}
		_Hatch6("Hatch 6", 2D) = "white" {}
		_Tiling("Tiling", Float) = 0
		_TriplanarFalloff("Triplanar Falloff", Float) = 1
		_Scale("Scale", Float) = 1
		_Shadow("Shadow", Range( -0.2 , 1)) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_OutlineWidth("Outline Width", Float) = 0
		_Float1("Float 1", Float) = 6
		_OutlineColor("Outline Color", Color) = (0,0,0,0)
		_OutlineMin("Outline Min", Float) = 0.01
		_Color("Color", Color) = (1,1,1,0)
		_Emiss("Emiss", 2D) = "black" {}
		_EmissColor("Emiss Color", Color) = (0,0,0,0)
		_HatchColor("Hatch Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float mulTime265 = _Time.y * 2.0;
			float simplePerlin2D266 = snoise( ( _Float1 * ( ase_vertex3Pos + mulTime265 ) ).xy );
			float outlineVar = (_OutlineMin + (simplePerlin2D266 - 0.0) * (_OutlineWidth - _OutlineMin) / (1.0 - 0.0));
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode257 = tex2D( _MainTex, uv_MainTex );
			o.Emission = _OutlineColor.rgb;
			clip( tex2DNode257.a - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
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
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
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

		uniform float4 _EmissColor;
		uniform sampler2D _Emiss;
		uniform float4 _Emiss_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _HatchColor;
		uniform float4 _Color;
		uniform sampler2D _Hatch6;
		uniform float _Tiling;
		uniform float _TriplanarFalloff;
		uniform sampler2D _Hatch5;
		uniform float _Shadow;
		uniform float _Scale;
		uniform sampler2D _Hatch4;
		uniform sampler2D _Hatch3;
		uniform sampler2D _Hatch2;
		uniform sampler2D _Hatch1;
		uniform float _Cutoff = 0.69;
		uniform float _Float1;
		uniform float _OutlineMin;
		uniform float _OutlineWidth;
		uniform float4 _OutlineColor;


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float tilling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= projNormal.x + projNormal.y + projNormal.z;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( topTexMap, tilling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( topTexMap, tilling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( topTexMap, tilling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
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
			v.vertex.xyz += 0;
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
			float4 tex2DNode257 = tex2D( _MainTex, uv_MainTex );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar252 = TriplanarSamplingSF( _Hatch6, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			float4 triplanar251 = TriplanarSamplingSF( _Hatch5, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult208 = dot( ase_worldNormal , ase_worldlightDir );
			float temp_output_243_0 = saturate( (dotResult208*0.28 + 0.28) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float temp_output_210_0 = saturate( ((_Shadow + (( ase_lightAtten * temp_output_243_0 * ase_lightColor.a ) - 0.0) * (1.0 - _Shadow) / (1.0 - 0.0))*_Scale + 0.0) );
			float4 lerpResult219 = lerp( triplanar252 , triplanar251 , temp_output_210_0);
			float4 triplanar250 = TriplanarSamplingSF( _Hatch4, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			float4 lerpResult217 = lerp( lerpResult219 , triplanar250 , saturate( ( ( temp_output_210_0 * 2.0 ) - 1.3 ) ));
			float4 triplanar249 = TriplanarSamplingSF( _Hatch3, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			float4 lerpResult216 = lerp( lerpResult217 , triplanar249 , saturate( ( ( temp_output_210_0 * 11.0 ) - 8.4 ) ));
			float4 triplanar247 = TriplanarSamplingSF( _Hatch2, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			float4 lerpResult232 = lerp( lerpResult216 , triplanar247 , saturate( ( ( temp_output_210_0 * 21.0 ) - 18.2 ) ));
			float4 triplanar246 = TriplanarSamplingSF( _Hatch1, ase_worldPos, ase_worldNormal, _TriplanarFalloff, _Tiling, 1.0, 0 );
			float4 lerpResult237 = lerp( lerpResult232 , triplanar246 , saturate( ( ( temp_output_210_0 * 31.0 ) - 28.4 ) ));
			float4 lerpResult260 = lerp( lerpResult237 , float4( 1,1,1,1 ) , saturate( ( ( temp_output_210_0 * 41.0 ) - 39.3 ) ));
			float4 lerpResult279 = lerp( _HatchColor , ( tex2DNode257 * _Color ) , lerpResult260);
			c.rgb = lerpResult279.rgb;
			c.a = 1;
			clip( tex2DNode257.a - _Cutoff );
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
			float2 uv_Emiss = i.uv_texcoord * _Emiss_ST.xy + _Emiss_ST.zw;
			o.Emission = ( _EmissColor * tex2D( _Emiss, uv_Emiss ) ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
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
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
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
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16100
151;258;1487;815;728.0115;284.4763;1.416544;True;True
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;204;-1862.163,160.9802;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;206;-1445.242,59.41001;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;245;-1366.356,735.7252;Float;False;Constant;_WrapperValue;Wrapper Value;0;0;Create;True;0;0;False;0;0.28;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;208;-1157.242,123.41;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;244;-1100.954,574.3254;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;203;-2074.786,155.0829;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;243;-863.7023,585.0894;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;278;-919.7015,397.9626;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;277;-532.8234,445.2907;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;242;-552.8342,796.6885;Float;False;Property;_Shadow;Shadow;10;0;Create;True;0;0;False;0;0;0.594;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-1088.786,369.5449;Float;False;Property;_Scale;Scale;9;0;Create;True;0;0;False;0;1;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;241;-307.2662,602.8985;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;209;-895.3799,207.5507;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;210;-176.6029,295.8396;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;253;-979.6765,-412.4713;Float;False;Property;_Tiling;Tiling;7;0;Create;True;0;0;False;0;0;16.44;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-989.519,-222.1711;Float;False;Property;_TriplanarFalloff;Triplanar Falloff;8;0;Create;True;0;0;False;0;1;18.39;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;118.2909,-47.54037;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;251;-477.6772,-602.7722;Float;True;Spherical;World;False;Hatch 5;_Hatch5;white;5;Assets/Naito/Shaders/New/Nappz/5th.png;Mid Texture 4;_MidTexture4;white;-1;None;Bot Texture 4;_BotTexture4;white;-1;None;SecondHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;252;-474.3959,-789.7909;Float;True;Spherical;World;False;Hatch 6;_Hatch6;white;6;Assets/Naito/Shaders/New/Nappz/6th.png;Mid Texture 5;_MidTexture5;white;-1;None;Bot Texture 5;_BotTexture5;white;-1;None;FirstHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;319.3772,77.19859;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;11;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;213;332.4911,-61.84037;Float;False;2;0;FLOAT;0;False;1;FLOAT;1.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;250;-499.0055,-417.3934;Float;True;Spherical;World;False;Hatch 4;_Hatch4;white;4;Assets/Naito/Shaders/New/Nappz/4th.png;Mid Texture 3;_MidTexture3;white;-1;None;Bot Texture 3;_BotTexture3;white;-1;None;ThirdHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;310.377,193.1986;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;21;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;227;534.3772,67.19859;Float;True;2;0;FLOAT;0;False;1;FLOAT;8.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;215;556.6909,-142.6405;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;219;258.613,-278.0252;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;249;-528.5347,-231.0145;Float;True;Spherical;World;False;Hatch 3;_Hatch3;white;3;Assets/Naito/Shaders/New/Nappz/3rd.png;Mid Texture 2;_MidTexture2;white;-1;None;Bot Texture 2;_BotTexture2;white;-1;None;FourthHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;217;686.3936,-467.4094;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;234;295.948,356.4702;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;31;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;230;532.2948,290.0895;Float;True;2;0;FLOAT;0;False;1;FLOAT;18.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;228;770.377,-6.801392;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;267;1815.198,719.1716;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;265;1894.198,996.1716;Float;False;1;0;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;216;993.4578,-162.2063;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;295.1591,455.6798;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;41;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;231;764.2948,276.0895;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;247;-523.6136,-43.99486;Float;True;Spherical;World;False;Hatch 2;_Hatch2;white;2;Assets/Naito/Shaders/New/Nappz/2nd.png;Mid Texture 1;_MidTexture1;white;-1;None;Bot Texture 1;_BotTexture1;white;-1;None;FifthHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;235;577.948,541.4702;Float;True;2;0;FLOAT;0;False;1;FLOAT;28.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;1779.198,599.1716;Float;False;Property;_Float1;Float 1;15;0;Create;True;0;0;False;0;6;500;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;268;2031.198,782.1716;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;232;1302.072,87.5209;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;259;590.1591,772.6798;Float;True;2;0;FLOAT;0;False;1;FLOAT;39.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;236;792.7388,516.454;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;1965.198,559.1716;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TriplanarNode;246;-552.6715,147.9544;Float;True;Spherical;World;False;Hatch 1;_Hatch1;white;1;Assets/Naito/Shaders/New/Nappz/1st.png;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;SixthHatch;False;9;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;261;816.6207,769.641;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;237;1373.84,435.8539;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;273;1563.726,-57.46799;Float;False;Property;_Color;Color;18;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;272;2275.726,822.532;Float;False;Property;_OutlineMin;Outline Min;17;0;Create;True;0;0;False;0;0.01;0.005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;263;1764.198,442.1716;Float;False;Property;_OutlineWidth;Outline Width;14;0;Create;True;0;0;False;0;0;0.016;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;266;2115.198,559.1716;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;257;1471.556,-272.5573;Float;True;Property;_MainTex;MainTex;13;0;Create;True;0;0;False;0;None;879ccb6468195754599c472fe51548f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;260;1552.92,665.6409;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;1,1,1,1;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;280;1612.379,235.8574;Float;False;Property;_HatchColor;Hatch Color;21;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;276;1892.726,-412.468;Float;False;Property;_EmissColor;Emiss Color;20;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;269;2376.198,519.1716;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.01;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;274;1858.726,-218.468;Float;True;Property;_Emiss;Emiss;19;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;264;1911.198,220.1716;Float;False;Property;_OutlineColor;Outline Color;16;0;Create;True;0;0;False;0;0,0,0,0;0.5413792,0.5413792,0.5413792,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;1884.237,40.22266;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;275;2197.726,-282.468;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;279;2119.375,45.99165;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;262;2183.198,314.1716;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;240;-700.2568,590.4249;Float;True;Property;_ToonRamp;Toon Ramp;11;0;Create;True;0;0;False;0;2ce7b663688865c4f822fb8e5f6e3367;2ce7b663688865c4f822fb8e5f6e3367;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;218;370.3936,-539.4094;Float;False;Property;_Light;Light;12;1;[HDR];Create;True;0;0;False;0;0,0,1,0;0.1029411,0.8021194,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2389.991,-151.7357;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Naito/SketchyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.69;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0.012;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;208;0;206;0
WireConnection;208;1;204;0
WireConnection;244;0;208;0
WireConnection;244;1;245;0
WireConnection;244;2;245;0
WireConnection;243;0;244;0
WireConnection;277;0;278;0
WireConnection;277;1;243;0
WireConnection;277;2;203;2
WireConnection;241;0;277;0
WireConnection;241;3;242;0
WireConnection;209;0;241;0
WireConnection;209;1;239;0
WireConnection;210;0;209;0
WireConnection;211;0;210;0
WireConnection;251;3;253;0
WireConnection;251;4;255;0
WireConnection;252;3;253;0
WireConnection;252;4;255;0
WireConnection;226;0;210;0
WireConnection;213;0;211;0
WireConnection;250;3;253;0
WireConnection;250;4;255;0
WireConnection;229;0;210;0
WireConnection;227;0;226;0
WireConnection;215;0;213;0
WireConnection;219;0;252;0
WireConnection;219;1;251;0
WireConnection;219;2;210;0
WireConnection;249;3;253;0
WireConnection;249;4;255;0
WireConnection;217;0;219;0
WireConnection;217;1;250;0
WireConnection;217;2;215;0
WireConnection;234;0;210;0
WireConnection;230;0;229;0
WireConnection;228;0;227;0
WireConnection;216;0;217;0
WireConnection;216;1;249;0
WireConnection;216;2;228;0
WireConnection;258;0;210;0
WireConnection;231;0;230;0
WireConnection;247;3;253;0
WireConnection;247;4;255;0
WireConnection;235;0;234;0
WireConnection;268;0;267;0
WireConnection;268;1;265;0
WireConnection;232;0;216;0
WireConnection;232;1;247;0
WireConnection;232;2;231;0
WireConnection;259;0;258;0
WireConnection;236;0;235;0
WireConnection;270;0;271;0
WireConnection;270;1;268;0
WireConnection;246;3;253;0
WireConnection;246;4;255;0
WireConnection;261;0;259;0
WireConnection;237;0;232;0
WireConnection;237;1;246;0
WireConnection;237;2;236;0
WireConnection;266;0;270;0
WireConnection;260;0;237;0
WireConnection;260;2;261;0
WireConnection;269;0;266;0
WireConnection;269;3;272;0
WireConnection;269;4;263;0
WireConnection;256;0;257;0
WireConnection;256;1;273;0
WireConnection;275;0;276;0
WireConnection;275;1;274;0
WireConnection;279;0;280;0
WireConnection;279;1;256;0
WireConnection;279;2;260;0
WireConnection;262;0;264;0
WireConnection;262;2;257;4
WireConnection;262;1;269;0
WireConnection;240;1;243;0
WireConnection;0;2;275;0
WireConnection;0;10;257;4
WireConnection;0;13;279;0
WireConnection;0;11;262;0
ASEEND*/
//CHKSM=1A78A93816A9E0854EF2DC70643D607CCDF3EAAE