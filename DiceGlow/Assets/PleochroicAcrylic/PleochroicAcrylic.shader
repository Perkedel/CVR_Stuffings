Shader "Pleochroic Acrylic/Pleochroic Acrylic"
{
    Properties
    {
        [HDR] _Color("Color", Color) = (1, 1, 1, 1)
        _Power("Power", Float) = 2.77
        _Alpha("Alpha", Range(0,1)) = 0.1
        _Gradation("Gradation", Float) = 0.01
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
        LOD 100
        ZWrite Off
        Cull Off
        Offset -1,-1
        Blend SrcAlpha OneMinusSrcAlpha

        // VRCが自動でBatchしてしまうので暫定対応
        GrabPass
        {
            "_BackgroundTexture"
        }

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
                float3 normal : NORMAL;

                UNITY_VERTEX_INPUT_INSTANCE_ID 
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float3 viewDir : TEXCOORD2;
                float3 camViewDiff : TEXCOORD3;

                UNITY_VERTEX_OUTPUT_STEREO
            };

            float4 _MainTex_ST;
            half4 _Color;
            float _Power;
            float _Alpha;
            float _Gradation;


            v2f vert (appdata v)
            {
                v2f o;

                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);

                float3 cameraPos = _WorldSpaceCameraPos;
                #if defined(USING_STEREO_MATRICES)
                cameraPos = (unity_StereoWorldSpaceCameraPos[0] + unity_StereoWorldSpaceCameraPos[1]) * .5;
                #endif

                o.viewDir = normalize(cameraPos - mul(unity_ObjectToWorld, v.vertex));
                o.camViewDiff = o.viewDir - normalize(cameraPos - unity_ObjectToWorld._m03_m13_m23);

                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                // エッジを出す。ワールドノーマルと視線方向の内積をとり、0付近(直角付近)で1になるようにする。
                // 裏面も描画するため絶対値をとってから1から引いている。
                float edge = 1.-abs(dot(i.normal, i.viewDir));
                // エッジの明るさ設定
                edge = pow(edge, _Power);
                // 非エッジの透明度下限設定
                edge = edge*(1-_Alpha) + _Alpha;

                //return float4(i.viewDir.xyz*.5+.5, edge);
                
                // 色を決める。モデル行列からローカル各軸の向きを取り出し、ワールドY軸(0,1,0)と内積を取る。
                // 例えばRotationが全て0の場合、ローカルY軸とワールドY軸は一致し内積が1となり、ローカルX軸およびZ軸はワールドY軸と90度ずれているため内積は0となる。
                // 上の場合、(X,Y,Z)=(R,G,B)=(0,1,0):緑色 が代入される。
                float3 c = float3(
                    dot(unity_ObjectToWorld._m00_m10_m20, float3(0,1,0)),
                    dot(unity_ObjectToWorld._m01_m11_m21, float3(0,1,0)),
                    dot(unity_ObjectToWorld._m02_m12_m22, float3(0,1,0))
                );

                // 一応正規化(不要かも)
                c = normalize(c);

                // 色がマイナスの場合、色相が180度異なる色を作る。
                c.gb += -c.r * step(c.r, 0);
                c.rb += -c.g * step(c.g, 0);
                c.rg += -c.b * step(c.b, 0);
                

                // 透明度を含むベースカラーを決定
                half4 col = half4(c, edge);
                // グラデーションをかける
                float depth = i.vertex.z;
                col += half4(i.camViewDiff * _Gradation / depth, 0);
                // InspectorのColorをかける
                col *= _Color;
                


                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }

    }
}
