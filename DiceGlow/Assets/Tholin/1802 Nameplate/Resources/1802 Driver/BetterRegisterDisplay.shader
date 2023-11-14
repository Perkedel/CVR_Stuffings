Shader "Tholin/BetterRegisterDisplay"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MarginHorizontal ("Horizontal Margin", Range(0, 1)) = 0.1
		_MarginVertical ("Vertical Margin", Range(0, 1)) = 0.2
		_MarginPixel ("Pixel Margin", Range(0, 1)) = 0.1
		_ColorPixOff ("Pixel Off Color", Color) = (0.2, 0.2, 0.2, 1)
		_ColorPixOn ("Pixel On Color", Color) = (1, 1, 0, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Cutout" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

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
			fixed4 _ColorPixOff;
			fixed4 _ColorPixOn;
			half _MarginHorizontal;
			half _MarginVertical;
			half _MarginPixel;

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

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(0, 0, 0, 0);
				i.uv.y = 1 - i.uv.y;

				int region = 0;

				if(i.uv.x < 0.333333) {
					region = 0;
				}else if(i.uv.x < 2.0 / 3.0) {
					region = 1;
					i.uv.x -= 1.0 / 3.0;
				}else {
					region = 2;
					i.uv.x -= 2.0 / 3.0;
				}
				i.uv.x /= (1.0 / 3.0);

				if(i.uv.x > 1 - _MarginHorizontal) {
					discard;
					return col;
				}
				i.uv.x /= 1 - _MarginHorizontal;

				int reg = (int)(i.uv.y * 8.0);
				if(reg < 0 || reg > 7) {
					discard;
					return col;
				}

				if(region == 2 && reg > 4) {
					discard;
					return col;
				}

				float fiy = (i.uv.y - ((float)reg / 8.0)) / (1.0 / 8.0);
				if(fiy > 1 - _MarginVertical) {
					discard;
					return col;
				}
				fiy /= 1 - _MarginVertical;

				int registerBits = region == 0 ? 16 : (region == 1 ? 16 : (reg == 0 ? 8 : (reg == 1 ? 1 : (reg == 2 ? 4 : (reg == 3 ? 4 : 1)))));
				if(i.uv.x > (float)registerBits / 16.0) {
					discard;
					return col;
				}

				int currBit = (int)(i.uv.x * 16);
				int currBitActual = registerBits - currBit - 1;

				if((i.uv.x - (float)currBit / 16.0) / (1.0 / 16.0) > 1 - _MarginPixel) {
					discard;
					return col;
				}

				int registerAddr;
				if(region == 0 || region == 1) {
					registerAddr = region * 8 + reg + 59905;
				}else {
					if(reg == 0 || reg == 1) registerAddr = 59921;
					else if(reg == 2) registerAddr = 59922;
					else if(reg == 3) registerAddr = 59923;
					else registerAddr = 59926;
				}

				uint registerValue = _MainTex[uint2((registerAddr) & 0xFF, (registerAddr) >> 8)].y;
				if(region == 2 && reg == 1) registerValue >>= 8;

				if((registerValue >> currBitActual) & 1) col = _ColorPixOn;
				else col = _ColorPixOff;

				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
