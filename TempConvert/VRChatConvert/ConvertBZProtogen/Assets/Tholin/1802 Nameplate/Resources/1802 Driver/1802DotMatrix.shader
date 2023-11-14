Shader "Tholin/1802DotMatrix"
{
	Properties
	{
		_MainTex ("Emulator Texture", 2D) = "black" {}
		_ColorMargins ("Margins Color", Color) = (0, 0, 0, 1)
		_ColorPixOff ("Pixel Off Color", Color) = (0.2, 0.2, 0.2, 1)
		_ColorPixOn ("Pixel On Color", Color) = (1, 1, 0, 1)
		_PixelSize ("Pixel Size", Range(0, 1)) = 0.9
		[Toggle] _Round ("Round", Int) = 0
		_Width ("Width", Int) = 32
		_Height ("Height", Int) = 8
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		Cull Off
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma target 3.0

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
			};

			Texture2D<uint4> _MainTex;
			fixed4 _ColorMargins;
			fixed4 _ColorPixOff;
			fixed4 _ColorPixOn;
			float _PixelSize;
			int _Round;
			int _Width;
			int _Height;

			v2f vert (appdata v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			uint read_memory_byte(int address) {
				return _MainTex[uint2(address & 0xFF, address >> 8)].x & 0xFF;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				uint idxx = _Width - 1 - (uint)(i.uv.x * _Width);
				uint idxy = _Height - 1 - (uint)(i.uv.y * _Height);

				int ipx = (int)(i.uv.x * _Width) % _Width;
				int ipy = (int)(i.uv.y * _Height) % _Height;
				half fpx = i.uv.x * _Width - ipx;
				half fpy = i.uv.y * _Height - ipy;
				if(!_Round && (fpx > _PixelSize || fpy > _PixelSize) || _Round && sqrt((fpx - 0.5) * (fpx - 0.5) + (fpy - 0.5) * (fpy - 0.5)) * 2.0 > _PixelSize) {
					fixed4 col = _ColorMargins;
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}

				int addr = (16 + (3 - (idxx / _Height)) * _Height) * 256;
				addr += idxy;
				uint x = (read_memory_byte(addr) >> (_Height - 1 - (idxx % _Height))) & 1;

				fixed4 col = _ColorPixOff;
				if(!x) col = _ColorPixOn;

				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
