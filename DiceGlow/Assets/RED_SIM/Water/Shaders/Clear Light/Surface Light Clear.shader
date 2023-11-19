// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Water/Surface Light Clear"
{
	Properties
	{
		[Header(Color Settings)]_Color("Color", Color) = (1,1,1,0)
		_Tint("Tint", Color) = (0,0,0,0)
		[Header(Normal Settings)]_Normal("Normal", 2D) = "bump" {}
		_Normal2nd("Normal 2nd", 2D) = "bump" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.8
		_NormalPower("Normal Power", Range( 0 , 1)) = 1
		_NormalPower2nd("Normal Power 2nd", Range( 0 , 1)) = 0.5
		[Header(Animation Settings)]_RipplesSpeed("Ripples Speed", Float) = 1
		_RipplesSpeed2nd("Ripples Speed 2nd", Float) = 1
		_SpeedX("Speed X", Float) = 0
		_SpeedY("Speed Y", Float) = 0
		[Toggle][Header(Visual Fixes)]_ZWrite1("ZWrite", Float) = 1
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
		ZWrite [_ZWrite1]
		GrabPass{ "_GrabWater" }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
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
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabWater )
		uniform float4 _Color;
		uniform float _Smoothness;
		uniform float _ZWrite1;


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
			o.Albedo = _Tint.rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor223 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabWater,ase_grabScreenPos.xy/ase_grabScreenPos.w);
			o.Emission = ( screenColor223 * _Color ).rgb;
			o.Smoothness = ( _Smoothness + ( _ZWrite1 * 0.0 ) );
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
1925;31;1906;987;-2275.99;1340.963;1.102817;True;False
Node;AmplifyShaderEditor.CommentaryNode;151;-429.3249,-1651.695;Inherit;False;3042.45;1297.318;Normals Generation and Animation;38;315;326;325;24;17;319;318;23;417;416;396;48;415;322;320;423;22;321;422;19;402;397;21;187;323;410;403;395;331;330;324;426;427;428;429;400;401;409;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureTransformNode;409;-126.8821,-1571.665;Inherit;False;17;False;1;0;SAMPLER2D;_Sampler0409;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.ComponentMaskNode;429;134.5359,-1497.053;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;428;131.5359,-1586.053;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;39.11987,-1302.975;Float;False;Property;_SpeedY;Speed Y;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;400;39.11987,-1378.975;Float;False;Property;_SpeedX;Speed X;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;426;374.2729,-1380.122;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;427;372.986,-1284.901;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;395;523.9399,-1360.028;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;403;525.4308,-1288.107;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;442.257,-558.3849;Float;False;Property;_RipplesSpeed2nd;Ripples Speed 2nd;9;0;Create;True;0;0;False;0;1;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;324;675.646,-896.0911;Inherit;False;0;318;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;330;420.299,-1066.67;Float;False;Property;_RipplesSpeed;Ripples Speed;8;0;Create;True;0;0;False;1;Header(Animation Settings);1;1.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;676.1399,-1610.274;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;397;943.5629,-886.9999;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;402;772.4309,-1315.107;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;410;-121.864,-1191.783;Inherit;False;318;False;1;0;SAMPLER2D;_Sampler0410;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleTimeNode;323;748.8711,-552.7049;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;187;744.835,-1060.985;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;22;1114.387,-1589.021;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;1154.061,-1203.833;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;320;1112.125,-883.559;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;19;1116.842,-1475.808;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.03,0.03;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;422;1148.914,-1332.51;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;321;1114.426,-766.869;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.04,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;396;1333.63,-1589.07;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;416;1335.548,-883.832;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;417;1336.762,-767.3709;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;322;1041.683,-554.2859;Float;False;Property;_NormalPower2nd;Normal Power 2nd;7;0;Create;True;0;0;False;0;0.5;0.616;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;415;1333.985,-1475.302;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;1021.273,-1058.244;Float;False;Property;_NormalPower;Normal Power;6;0;Create;True;0;0;False;0;1;0.139;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;1467.415,-887.748;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;318;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;1463.97,-1395.937;Inherit;True;Property;_Normal;Normal;3;0;Create;True;0;0;False;1;Header(Normal Settings);-1;None;6d095a40a0b25e746a709fedd6a9aae6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;1463.51,-1593.396;Inherit;True;Property;_Normal2;Normal2;3;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;318;1467.875,-690.289;Inherit;True;Property;_Normal2nd;Normal 2nd;4;0;Create;True;0;0;False;0;-1;None;8d1c512a0b7c09542b55aa818b398907;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;325;1778.697,-798.233;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;24;1778.382,-1497.704;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;430;2960.06,-680.5049;Inherit;False;Property;_ZWrite1;ZWrite;12;1;[Toggle];Create;True;2;Option1;0;Option2;1;1;;False;1;Header(Visual Fixes);1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;326;2029.67,-1294.093;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;368;3016.246,-826.3799;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;431;3114.7,-677.3863;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;2252.395,-1299.188;Float;False;NormalWater;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenColorNode;223;2698.58,-1087.561;Float;False;Global;_GrabWater;GrabWater;-1;0;Create;True;0;0;False;0;Object;-1;True;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;393;2669.953,-915.6675;Float;False;Property;_Color;Color;1;0;Create;True;0;0;False;1;Header(Color Settings);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;432;3296.7,-807.3863;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;392;2702.15,-1347.954;Float;False;Property;_Tint;Tint;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;369;2700.141,-1160.13;Inherit;False;315;NormalWater;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;394;3002.737,-1009.02;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3437.594,-1195.612;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;RED_SIM/Water/Surface Light Clear;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;True;False;Back;0;True;430;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-1;True;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;429;0;409;0
WireConnection;428;0;409;0
WireConnection;426;0;400;0
WireConnection;426;1;428;0
WireConnection;427;0;401;0
WireConnection;427;1;429;0
WireConnection;395;0;426;0
WireConnection;403;0;427;0
WireConnection;397;0;324;0
WireConnection;402;0;395;0
WireConnection;402;1;403;0
WireConnection;323;0;331;0
WireConnection;187;0;330;0
WireConnection;22;0;21;0
WireConnection;22;1;187;0
WireConnection;423;0;402;0
WireConnection;423;1;410;0
WireConnection;320;0;397;0
WireConnection;320;1;323;0
WireConnection;19;0;21;0
WireConnection;19;1;187;0
WireConnection;422;0;409;0
WireConnection;422;1;402;0
WireConnection;321;0;397;0
WireConnection;321;1;323;0
WireConnection;396;0;22;0
WireConnection;396;1;422;0
WireConnection;416;0;320;0
WireConnection;416;1;423;0
WireConnection;417;0;321;0
WireConnection;417;1;423;0
WireConnection;415;0;19;0
WireConnection;415;1;422;0
WireConnection;319;1;416;0
WireConnection;319;5;322;0
WireConnection;17;1;415;0
WireConnection;17;5;48;0
WireConnection;23;1;396;0
WireConnection;23;5;48;0
WireConnection;318;1;417;0
WireConnection;318;5;322;0
WireConnection;325;0;319;0
WireConnection;325;1;318;0
WireConnection;24;0;23;0
WireConnection;24;1;17;0
WireConnection;326;0;24;0
WireConnection;326;1;325;0
WireConnection;431;0;430;0
WireConnection;315;0;326;0
WireConnection;432;0;368;0
WireConnection;432;1;431;0
WireConnection;394;0;223;0
WireConnection;394;1;393;0
WireConnection;0;0;392;0
WireConnection;0;1;369;0
WireConnection;0;2;394;0
WireConnection;0;4;432;0
ASEEND*/
//CHKSM=29D9143959348D9F71AD78EAB11713AAADEF674A