// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CombatSystemOverlay"
{
	Properties
	{
		_HealthColor("HealthColor", Color) = (0,1,0,0.3921569)
		_ShieldColor("ShieldColor", Color) = (0,1,1,0.3921569)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest Always
		GrabPass{ }
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows 
		struct Input
		{
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

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float4 _CVRCombatSystemHealth;
		uniform float4 _HealthColor;
		uniform float4 _ShieldColor;
		uniform float4 _CVRCombatSystemShield;


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


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			c.rgb = 0;
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
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor1 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,ase_grabScreenPosNorm.xy);
			float4 color13 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float4 lerpResult16 = lerp( screenColor1 , color13 , float4( 0.4,0.4,0.4,0 ));
			float clampResult11 = clamp( _CVRCombatSystemHealth.w , 0.0 , 1.0 );
			float4 lerpResult10 = lerp( lerpResult16 , screenColor1 , clampResult11);
			float3 hsvTorgb3 = RGBToHSV( screenColor1.rgb );
			float4 temp_cast_2 = (hsvTorgb3.z).xxxx;
			float4 lerpResult6 = lerp( lerpResult10 , temp_cast_2 , step( _CVRCombatSystemHealth.x , 0.0 ));
			float temp_output_28_0 = ( 1.0 - step( ase_grabScreenPosNorm.g , 0.95 ) );
			float temp_output_26_0 = step( ase_grabScreenPosNorm.r , 0.25 );
			float temp_output_19_0 = ( ase_grabScreenPosNorm.r * 4.0 );
			float clampResult44 = clamp( ( temp_output_28_0 * temp_output_26_0 * step( temp_output_19_0 , ( _CVRCombatSystemHealth.x / _CVRCombatSystemHealth.y ) ) * _HealthColor.a ) , 0.0 , 1.0 );
			float4 lerpResult38 = lerp( lerpResult6 , _HealthColor , clampResult44);
			float clampResult45 = clamp( ( ( ( 1.0 - step( ase_grabScreenPosNorm.g , 0.9 ) ) - temp_output_28_0 ) * temp_output_26_0 * step( temp_output_19_0 , ( _CVRCombatSystemShield.x / _CVRCombatSystemShield.y ) ) * _ShieldColor.a ) , 0.0 , 1.0 );
			float4 lerpResult39 = lerp( lerpResult38 , _ShieldColor , clampResult45);
			o.Emission = lerpResult39.rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
142;245;2289;938;2887.545;183.7323;1.875861;True;True
Node;AmplifyShaderEditor.GrabScreenPosition;2;-2172.6,-130.5001;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-257.7496,771.2624;Inherit;False;Property;_HealthColor;HealthColor;1;0;Create;True;0;0;0;False;0;False;0,1,0,0.3921569;0,1,0,0.3921569;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;4;-1532.5,260;Inherit;False;Global;_CVRCombatSystemHealth;_CVRCombatSystemHealth;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;35;-1678.058,1134.422;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;34;-1684.658,1264.221;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-1280.5,64.89992;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;1;-1278.9,-125.7;Inherit;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;27;-1021.366,1282.369;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.95;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1533.568,771.4693;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;29;-1018.766,1539.769;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;23;-1534.867,1027.569;Inherit;False;Global;_CVRCombatSystemShield;_CVRCombatSystemShield;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;-254.8646,1024.984;Inherit;False;Property;_ShieldColor;ShieldColor;2;0;Create;True;0;0;0;False;0;False;0,1,1,0.3921569;0,1,1,0.3921569;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;21;-1281.369,514.0696;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;42;-79.89617,947.7507;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-766.5661,1282.369;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;26;-771.7661,546.5697;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-767.8831,1542.174;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;40;-272.5762,978.8628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-1277.468,1026.268;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;16;-895.5,31;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.4,0.4,0.4,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;11;-988.5,513;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-1023.967,771.4691;Inherit;True;2;0;FLOAT;0.9;False;1;FLOAT;0.96;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;43;-81.19615,1197.32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;25;-1022.667,1027.568;Inherit;True;2;0;FLOAT;0.9;False;1;FLOAT;0.96;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;41;-274.0551,1237.643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;10;-638.5,260;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-510.4832,1539.574;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;3;-1022.5,-124;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-251.7822,1279.574;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;5;-1149.5,258;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;6;-381.5,2;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-253.082,1539.574;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;44;-0.2046471,1153.527;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;45;131.0792,1279.613;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;38;128.1101,768.8518;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;39;385.4066,896.9221;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StickyNoteNode;46;-1915.48,132.9598;Inherit;False;334;162;_CVRCombatSystemHealth Definition;;1,1,1,1;x: current health$y: max health$z: health regeneration delay$w: time since last damage$$Also available for armor and shield;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;767.6,264.6;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;CombatSystemOverlay;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Overlay;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;2;2
WireConnection;34;0;2;2
WireConnection;1;0;2;0
WireConnection;27;0;35;0
WireConnection;19;0;2;1
WireConnection;29;0;34;0
WireConnection;21;0;4;1
WireConnection;21;1;4;2
WireConnection;42;0;36;4
WireConnection;28;0;27;0
WireConnection;26;0;2;1
WireConnection;30;0;29;0
WireConnection;40;0;42;0
WireConnection;24;0;23;1
WireConnection;24;1;23;2
WireConnection;16;0;1;0
WireConnection;16;1;13;0
WireConnection;11;0;4;4
WireConnection;22;0;19;0
WireConnection;22;1;21;0
WireConnection;43;0;37;4
WireConnection;25;0;19;0
WireConnection;25;1;24;0
WireConnection;41;0;43;0
WireConnection;10;0;16;0
WireConnection;10;1;1;0
WireConnection;10;2;11;0
WireConnection;31;0;30;0
WireConnection;31;1;28;0
WireConnection;3;0;1;0
WireConnection;32;0;28;0
WireConnection;32;1;26;0
WireConnection;32;2;22;0
WireConnection;32;3;40;0
WireConnection;5;0;4;1
WireConnection;6;0;10;0
WireConnection;6;1;3;3
WireConnection;6;2;5;0
WireConnection;33;0;31;0
WireConnection;33;1;26;0
WireConnection;33;2;25;0
WireConnection;33;3;41;0
WireConnection;44;0;32;0
WireConnection;45;0;33;0
WireConnection;38;0;6;0
WireConnection;38;1;36;0
WireConnection;38;2;44;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;39;2;45;0
WireConnection;0;2;39;0
ASEEND*/
//CHKSM=C0667CFED413E42BC92AA6BC9BD69F69DC8A4F06