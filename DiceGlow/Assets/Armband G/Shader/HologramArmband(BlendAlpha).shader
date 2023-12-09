Shader "Custom/HologramArmbandShader(BlendAlpha)"
{
	Properties
	{
		_Brightness("Brightness", Range(0.1, 6.0)) = 3.0
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		_Alpha ("Alpha", Range (0.0, 1.0)) = 1.0
		[Space]
		_Direction ("Direction", Vector) = (0,1,0,0)
		[Space]
		_MainTex ("MainTexture", 2D) = "white" {}
		_MainColor ("MainColor", Color) = (1,1,1,1)
		[Space]
		_RimColor ("Rim Color", Color) = (1,1,1,1)
		_RimPower ("Rim Power", Range(0.1, 10)) = 5.0
		[Space]
		_ScanTiling ("Scan Tiling", Range(0, 10.0)) = 0
		_ScanSpeed ("Scan Speed", Range(-2.0, 2.0)) = 1.0
		[Space]
		[Toggle(_GLOW_ON)]
		_GLOW_ON ("GLOW_ON", Float) = 0
		_GlowTiling ("Glow Tiling", Range(0.01, 1.0)) = 0.05
		_GlowSpeed ("Glow Speed", Range(-10.0, 10.0)) = 1.0
		[Space]
		[Toggle(_GLITCH_ON)]
		_GLITCH_ON ("GLITCH_ON", Float) = 0
		_GlitchSpeed ("Glitch Speed", Range(0, 50)) = 1.0
		_GlitchIntensity ("Glitch Intensity", Float) = 0
		[Space]
		_FlickerTex ("Flicker Control Texture", 2D) = "white" {}
		_FlickerSpeed ("Flicker Speed", Range(0.01, 100)) = 1.0
		[Space]
		[Toggle(IS_PIXELATE_SCROLL)]
		_IsPixelateScroll ("Pixelate Scroll", Float) = 0 
		_SpeedX ("Scroll SpeedX", Range(-10.0, 10.0)) = 1.0
		_SpeedY ("Scroll SpeedY", Range(-10.0, 10.0)) = 0
		[Space]
		_SizeX ("Side Display Size X", Int) = 1
		_SizeY ("Side Display Size Y", Int) = 1
		_TexSizeX ("Side Texture Size X", Int) = 1
		_TexSizeY ("Side Texture Size Y", Int) = 1
		[Space]
		_SizeX2 ("Vertical Display Size X", Int) = 1
		_SizeY2 ("Vertical Display Size Y", Int) = 1
		_TexSizeX2 ("Vertical Texture Size X", Int) = 1
		_TexSizeY2 ("Vertical Texture Size Y", Int) = 1

		[HideInInspector] _Fold("__fld", Float) = 1.0
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		//Blend SrcAlpha OneMinusSrcAlpha
		Blend SrcAlpha One
		LOD 100
		ColorMask RGB
        Cull off

		Pass
		{
			CGPROGRAM
			#pragma shader_feature _SCAN_ON
			#pragma shader_feature _GLOW_ON
			#pragma shader_feature _GLITCH_ON
			#pragma vertex vert
			#pragma fragment frag
			#pragma shader_feature IS_PIXELATE_SCROLL
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 worldVertex : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
				float3 worldNormal : NORMAL;
			};

			sampler2D _MainTex;
			sampler2D _FlickerTex;

			float4 _Direction;
			float4 _MainTex_ST;
			float4 _MainColor;
			float4 _RimColor;

			float _RimPower;
			float _GlitchSpeed;
			float _GlitchIntensity;
			float _Brightness;
			float _Alpha;
			float _ScanTiling;
			float _ScanSpeed;
			float _GlowTiling;
			float _GlowSpeed;
			float _FlickerSpeed;

			fixed _Cutoff;
			fixed _SpeedX;
			fixed _SpeedY;
			fixed _SizeX;
			fixed _SizeY;
			fixed _TexSizeX;
			fixed _TexSizeY;
			fixed _SizeX2;
			fixed _SizeY2;
			fixed _TexSizeX2;
			fixed _TexSizeY2;

			v2f vert (appdata v)
			{
				v2f o;
				
				// Glitches
				#if _GLITCH_ON
					v.vertex.x += _GlitchIntensity * (step(0.5, sin(_Time.y * 2.0 + v.vertex.y * 1.0)) * step(0.99, sin(_Time.y*_GlitchSpeed * 0.5)));
				#endif

				o.vertex = UnityObjectToClipPos(v.vertex);
				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.worldVertex = mul(unity_ObjectToWorld, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = normalize(UnityWorldSpaceViewDir(o.worldVertex.xyz));
				fixed hogeX = max(_SizeX, _SizeY) / min(_SizeX, _SizeY);

				float scaleX = max(_TexSizeX, _TexSizeY) / min(_TexSizeX, _TexSizeY);

				fixed hogeY = max(_SizeX2, _SizeY2) / min(_SizeX2, _SizeY2);

				float scaleY = max(_TexSizeX2, _TexSizeY2) / min(_TexSizeX2, _TexSizeY2);
					
				fixed speed = 1 / (scaleY / hogeX);
				float2 pivot_uv = float2(0.5, 0.5);
				float2 r = (o.uv.x - pivot_uv) * ((1 / (scaleX / hogeX)));
				
				#ifdef IS_PIXELATE_SCROLL
					o.uv.x = r + pivot_uv + round((_SpeedX * speed * _Time.y) / (1 / _TexSizeX)) * (1 / _TexSizeX);
				#else
					o.uv.x = r + pivot_uv + (_SpeedX * speed * _Time.y);
				#endif
				float2 u = (o.uv.y - pivot_uv) * ((1 / (scaleY / hogeY)));
				
				#ifdef IS_PIXELATE_SCROLL
					o.uv.y = u + pivot_uv + round((_SpeedY * speed * _Time.y) / (1 / _TexSizeX)) * (1 / _TexSizeX);
				#else
					o.uv.y = u + pivot_uv + (_SpeedY * speed * _Time.y);
				#endif

				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 texColor = tex2D(_MainTex, i.uv);

				half dirVertex = (dot(i.worldVertex, normalize(float4(_Direction.xyz, 1.0))) + 1) / 2;

				// Scanlines
				float scan = 0.0;
				#ifdef _SCAN_ON
					scan = step(frac(dirVertex * _ScanTiling + _Time.w * _ScanSpeed), 0.5) * 0.65;
				#endif

				// Glow
				float glow = 0.0;
				#ifdef _GLOW_ON
					glow = frac(dirVertex * _GlowTiling - _Time.x * _GlowSpeed);
				#endif

				// Flicker
				fixed4 flicker = tex2D(_FlickerTex, _Time * _FlickerSpeed);

				// Rim Light
				half rim = 1.0-saturate(dot(i.viewDir, i.worldNormal));
				fixed4 rimColor = _RimColor * pow (rim, _RimPower);

				fixed4 col = texColor * _MainColor + (glow * 0.35 * _MainColor) + rimColor;
				col.a = texColor.a * _Alpha* (scan +  glow) * flicker;
				clip(col.a - _Cutoff);
				col.rgb *= _Brightness;
				return col;
			}
			ENDCG
		}
	}

	
}
