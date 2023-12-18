Shader "Tsukikomiri/Lamellar/Lamellar"
{
    Properties
    {
        [HDR]_MainColor ("Main Color", Color) = (1,1,1,1)

        _BaseColor ("Base Color", Color) = (0.1,0.1,0.1,1)

        

        [Header(Rotation)]
        [Space(10)]
        _Density("Scale", Float) = 2.0
        _Theta("Lattice Angle", Range(0,360)) = 0
        _ThetaX("Rotation X", Range(0,360)) = 0
        _ThetaY("Rotation Y", Range(0,360)) = 0
        _ThetaZ("Rotation Z", Range(0,360)) = 0
        _OffsetX("Offset X", Float) = 0
        _OffsetY("Offset Y", Float) = 0

        [Header(Crystal 1)]
        [Space(10)]
        _Color01("Color", Color) = (0.8,0.8,0.8,1)
        _Freq01("Frequency", Float) = 13.0
        _Width01("Width", Float) = 0.1

        [Header(Crystal 2)]
        [Space(10)]
        _Color02("Color", Color) = (0.6,0.6,0.6,1)
        _Freq02("Frequency", Float) = 8
        _Width02("Width", Float) = 0.2

        [Header(Crystal 3)]
        [Space(10)]
        _Color03("Color", Color) = (0.6,0.6,0.6,1)
        _Freq03("Frequency", Float) = 4.0
        _Width03("Width", Float) = 0.05

        [Header(Crystal 4)]
        [Space(10)]
        _Color04("Color", Color) = (0.2,0.2,0.2,1)
        _Freq04("Frequency", Float) = 10.0
        _Width04("Width", Float) = 0.3

        [Header(Crystal 5)]
        [Space(10)]
        _Color05("Color", Color) = (0.35,0.35,0.35,1)
        _Freq05("Frequency", Float) = 9.0
        _Width05("Width", Float) = 0.3

        [Header(Crystal 6)]
        [Space(10)]
        _Color06("Color", Color) = (0.65,0.65,0.65,1)
        _Freq06("Frequency", Float) = 9.0
        _Width06("Width", Float) = 0.3

        [Header(Crystal 7)]
        [Space(10)]
        _Color07("Color", Color) = (0.07,0.07,0.07,1)
        _Freq07("Frequency", Float) = 12.0
        _Width07("Width", Float) = 0.5

        [Header(Crystal 8)]
        [Space(10)]
        _Color08("Color", Color) = (0.4,0.4,0.4,1)
        _Freq08("Frequency", Float) = 5.0
        _Width08("Width", Float) = 0.4

        [Header(Crystal 9)]
        [Space(10)]
        _Color09("Color", Color) = (0.32,0.32,0.32,1)
        _Freq09("Frequency", Float) = 8.0
        _Width09("Width", Float) = 0.6

        [Header(Crystal 10)]
        [Space(10)]
        _Color10("Color", Color) = (0.15,0.15,0.15,1)
        _Freq10("Frequency", Float) = 6.0
        _Width10("Width", Float) = 0.5

        [Header(Crystal 11)]
        [Space(10)]
        _Color11("Color", Color) = (0.18,0.18,0.18,1)
        _Freq11("Frequency", Float) = 2.0
        _Width11("Width", Float) = 0.8

        [Header(Crystal 12)]
        [Space(10)]
        _Color12("Color", Color) = (0.2,0.2,0.2,1)
        _Freq12("Frequency", Float) = 3.0
        _Width12("Width", Float) = 1.2

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 localPos;
        };

        float4 _MainColor;
        float4 _BaseColor;
        float _Theta;
        float _ThetaX;
        float _ThetaY;
        float _ThetaZ;
        float _Seed;

        float _OffsetX;
        float _OffsetY;

        float _Density;

        float4 _Color01;
        float _Freq01;
        float _Width01;

        float4 _Color02;
        float _Freq02;
        float _Width02;

        float4 _Color03;
        float _Freq03;
        float _Width03;

        float4 _Color04;
        float _Freq04;
        float _Width04;

        float4 _Color05;
        float _Freq05;
        float _Width05;

        float4 _Color06;
        float _Freq06;
        float _Width06;

        float4 _Color07;
        float _Freq07;
        float _Width07;

        float4 _Color08;
        float _Freq08;
        float _Width08;

        float4 _Color09;
        float _Freq09;
        float _Width09;

        float4 _Color10;
        float _Freq10;
        float _Width10;

        float4 _Color11;
        float _Freq11;
        float _Width11;

        float4 _Color12;
        float _Freq12;
        float _Width12;


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert (inout appdata_full v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            o.localPos = v.vertex.xyz;
        }

        void drawWidLine(inout float4 col, inout float id, inout float isFilled, float freq, float theta, float3 pos, float4 width, float4 baseColor, float4 lineColor)
        {
            float2x2 fMatrix = float2x2(
                cos(theta), -sin(theta),
                sin(theta), cos(theta)
            );

            pos.xy = mul(pos.xy, fMatrix);

            float id1 = floor(pos.x * freq);
            float th = (sin((id+id1*id)*0.8)+0.3)*width;

            float res = step(frac(pos.x * freq), th);
            
            float3 layer = lerp(baseColor.xyz, lineColor.xyz, res); 

            col.xyz = lerp(layer, col.xyz, isFilled);
            isFilled = saturate(isFilled + res);

            id = id1;
        }

        float3 Rotate3D(float3 position)
        {
            float3 rotationAngles = radians(float3(_ThetaX, _ThetaY, _ThetaZ));

            float3x3 rotationMatrix = float3x3(
                cos(rotationAngles.y) * cos(rotationAngles.z),
                cos(rotationAngles.y) * sin(rotationAngles.z),
                -sin(rotationAngles.y),
                sin(rotationAngles.x) * sin(rotationAngles.y) * cos(rotationAngles.z) - cos(rotationAngles.x) * sin(rotationAngles.z),
                sin(rotationAngles.x) * sin(rotationAngles.y) * sin(rotationAngles.z) + cos(rotationAngles.x) * cos(rotationAngles.z),
                sin(rotationAngles.x) * cos(rotationAngles.y),
                cos(rotationAngles.x) * sin(rotationAngles.y) * cos(rotationAngles.z) + sin(rotationAngles.x) * sin(rotationAngles.z),
                cos(rotationAngles.x) * sin(rotationAngles.y) * sin(rotationAngles.z) - sin(rotationAngles.x) * cos(rotationAngles.z),
                cos(rotationAngles.x) * cos(rotationAngles.y)
            );
            
            return mul(rotationMatrix, position);
        }


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // sample the texture
            float4 col = float4(0.3,0.3,0.3,1);

            float id = 0;
            float isFilled=0;

            float latticeAngle = radians(_Theta);

            float3 localPos = IN.localPos;
            float3 offset = float3(_OffsetX, _OffsetY, 0);
            float3 uv = (Rotate3D(localPos))*_Density+offset;


            drawWidLine(col, id, isFilled, _Freq01, -latticeAngle, uv, _Width01, _BaseColor, _Color01);
            drawWidLine(col, id, isFilled, _Freq02, latticeAngle, uv, _Width02, _BaseColor, _Color02);
            drawWidLine(col, id, isFilled, _Freq03, 0, uv, _Width03, _BaseColor, _Color03);

            drawWidLine(col, id, isFilled, _Freq04, -latticeAngle, uv, _Width04, _BaseColor, _Color04);
            drawWidLine(col, id, isFilled, _Freq05, latticeAngle, uv, _Width05, _BaseColor, _Color05);
            drawWidLine(col, id, isFilled, _Freq06, 0, uv, _Width06, _BaseColor, _Color06);

            drawWidLine(col, id, isFilled, _Freq07, -latticeAngle, uv, _Width07, _BaseColor, _Color07);
            drawWidLine(col, id, isFilled, _Freq08, latticeAngle, uv, _Width08, _BaseColor, _Color08);
            drawWidLine(col, id, isFilled, _Freq09, 0, uv, _Width09, _BaseColor, _Color09);

            drawWidLine(col, id, isFilled, _Freq10, -latticeAngle, uv, _Width10, _BaseColor, _Color10);
            drawWidLine(col, id, isFilled, _Freq11, latticeAngle, uv, _Width11, _BaseColor, _Color11);
            drawWidLine(col, id, isFilled, _Freq12, 0, uv, _Width12, _BaseColor, _Color12);

            // Albedo comes from a texture tinted by color
            o.Albedo = col.rgb * _MainColor.xyz;
            // Metallic and smoothness come from slider variables
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            o.Metallic = col*0.6+0.5;
            o.Smoothness = col*0.6+0.5;
            o.Alpha = col.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
