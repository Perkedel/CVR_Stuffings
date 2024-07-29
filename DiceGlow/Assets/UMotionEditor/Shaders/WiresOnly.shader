Shader "UMotion Editor/Wires Only"
{ 
    Properties 
    {
		_Color("Main Color (RGB)", color) = (1, 1, 1, 1)
		_Size("Wire Size", Range(0, 4)) = 0.9
    }

    SubShader 
    {
		Tags {"Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
		Cull Off

		Pass
	    {
            CGPROGRAM 
		    #pragma vertex vert
	    	#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

			fixed4 _Color;
			half _Size;

			struct vInput
			{
				float4 vertex : POSITION;
				half4 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID  // inserted by FixShadersRightEye.cs
			};

			struct vOutput
			{
				float4 pos : SV_POSITION;
				fixed3 wirecoord : TEXCOORD1;		
				UNITY_VERTEX_OUTPUT_STEREO  // inserted by FixShadersRightEye.cs
			};

			vOutput vert(vInput i)
			{
				vOutput o;
				UNITY_SETUP_INSTANCE_ID(i);  // inserted by FixShadersRightEye.cs
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);  // inserted by FixShadersRightEye.cs

				o.pos = UnityObjectToClipPos(i.vertex);

				o.wirecoord = fixed3(floor(i.texcoord.x), frac(i.texcoord.x) * 10, i.texcoord.y);

				return o;
			}

			fixed4 frag(vOutput i) : SV_Target 
			{
				half3 width = abs(ddx(i.wirecoord.xyz)) + abs(ddy(i.wirecoord.xyz));
				half3 smoothed = smoothstep(half3(0, 0, 0), width * _Size, i.wirecoord.xyz);		
	  			half wireAlpha = min(min(smoothed.x, smoothed.y), smoothed.z);

				return fixed4(_Color.xyz, 1 - wireAlpha);
			}

			ENDCG
    	} //Pass
    } //SubShader
} //Shader
