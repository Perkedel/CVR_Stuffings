Shader "JillTheSomething/Waterbed"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal ("Normal Map", 2D) = "bump"{}
        _NormalStrength ("Normal Strength", float) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _RenderTexture ("Render Texture", 2D) = "white" {}
        _Power ("Power", float) = 1
        _SideScale ("Side Scale", float) = 0.25
        _Blur ("Blur", int) = 1
        _TrailBlur ("Trail Blur Increase", int) = 2
        _TrailBlend ("Trail Blend", Range(0,1)) = 1
        _Softness("Softness", int) = 3
        [Toggle] _CameraTop ("Camera on top?", float) = 0
        [Toggle] _NonBlender ("Model not from blender?", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 200

        CGPROGRAM
        
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert alpha


        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        // Declare Structs
        struct Input
        {
            float2 uv_MainTex;
        };
        
        // Declare vars to hold Properties
        sampler2D _MainTex;
        sampler2D _Normal;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _NormalStrength;
        sampler2D _RenderTexture;
        float4 _RenderTexture_ST;
        float _Power;
        float _SideScale;
        float _TrailBlend;
        int _Blur;
        int _TrailBlur;
        int _Softness;
        float _CameraTop;
        float _NonBlender;
        
        void vert(inout appdata_full v){
            // Get the depth from the render texutre and scale by power.
            float offsetBase;
            if (_CameraTop > 0.5) offsetBase = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.xy, _RenderTexture), _Blur, _Blur)).g * -_Power;
            else offsetBase = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.yx, _RenderTexture), _Blur, _Blur)).g * -_Power;
            
            float offsetSoft;
            if (_CameraTop > 0.5) offsetBase = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.xy, _RenderTexture), _Blur+_Softness, _Blur+_Softness)).g * -_Power;
            else offsetSoft = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.yx, _RenderTexture), _Blur+_Softness, _Blur+_Softness)).g * -_Power;
            
            float offsetTrail;
            if (_CameraTop > 0.5) offsetTrail = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.xy, _RenderTexture), _Blur+_TrailBlur, _Blur+_TrailBlur)).b * -_Power;
            else offsetTrail = tex2Dlod(_RenderTexture, float4(TRANSFORM_TEX(v.texcoord.yx, _RenderTexture), _Blur+_TrailBlur, _Blur+_TrailBlur)).b * -_Power;
            
            float offset = min(offsetBase, offsetSoft) + (offsetTrail * _TrailBlend);
            
            // Move verts along their normals.
            v.vertex.z = (v.normal.z*offset)+v.vertex.z;
            v.vertex.xy = (v.normal.xy*_SideScale*offset)+v.vertex.xy; // Scale local x and y direction.
            if (_NonBlender > 0.5) v.vertex.yz = v.vertex.zy; // Flip y and z if local up is y direction.
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Normal
            fixed3 n = UnpackScaleNormal(tex2D(_Normal, IN.uv_MainTex), _NormalStrength).xyz;
            o.Normal = normalize(n);
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Standard"
}
