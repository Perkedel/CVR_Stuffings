#ifndef POI_MIRROR
    #define POI_MIRROR
    float _Mirror;
    float _EnableMirrorTexture;
    #if defined(PROP_MIRRORTEXTURE) || !defined(OPTIMIZER_ENABLED)
        POI_TEXTURE_NOSAMPLER(_MirrorTexture);
    #endif
    void applyMirrorRenderVert(inout float4 vertex)
    {
        
        if ((0.0 /*_Mirror*/) != 0)
        {
            bool inMirror = IsInMirror();
            if((0.0 /*_Mirror*/) == 1 && inMirror)
            {
                return;
            }
            if((0.0 /*_Mirror*/) == 1 && !inMirror)
            {
                vertex = -1;
                return;
            }
            if((0.0 /*_Mirror*/) == 2 && inMirror)
            {
                vertex = -1;
                return;
            }
            if((0.0 /*_Mirror*/) == 2 && !inMirror)
            {
                return;
            }
        }
    }
    void applyMirrorRenderFrag()
    {
        
        if((0.0 /*_Mirror*/) != 0)
        {
            bool inMirror = IsInMirror();
            if((0.0 /*_Mirror*/) == 1 && inMirror)
            {
                return;
            }
            if((0.0 /*_Mirror*/) == 1 && !inMirror)
            {
                clip(-1);
                return;
            }
            if((0.0 /*_Mirror*/) == 2 && inMirror)
            {
                clip(-1);
                return;
            }
            if((0.0 /*_Mirror*/) == 2 && !inMirror)
            {
                return;
            }
        }
    }
    #if(defined(FORWARD_BASE_PASS) || defined(FORWARD_ADD_PASS))
        void applyMirrorTexture(inout float4 mainTexture)
        {
            
            if((0.0 /*_EnableMirrorTexture*/))
            {
                if(IsInMirror())
                {
                    #if defined(PROP_MIRRORTEXTURE) || !defined(OPTIMIZER_ENABLED)
                        mainTexture = POI2D_SAMPLER_PAN(_MirrorTexture, _MainTex, poiMesh.uv[(0.0 /*_MirrorTextureUV*/)], float4(0,0,0,0));
                    #endif
                }
            }
        }
    #endif
#endif
