using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Blitter : MonoBehaviour
{
    // Copies aTexture to rTex and displays it in all cameras.

    public Texture aTexture;
    public RenderTexture rTex;
    public Material mat;

    void Start()
    {
        if (!aTexture || !rTex || !mat)
        {
            Debug.LogError("A texture or a render texture are missing, assign them.");
        }
    }

    void Update()
    {
        Graphics.Blit(aTexture, rTex, mat);
    }
}
