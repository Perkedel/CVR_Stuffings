using System.Collections.Generic;
using NAK.AASEmulator.Runtime;
using Unity.Profiling;
using UnityEngine;

public class TransformHiderManager : MonoBehaviour
{
    #region Singleton Implementation

    // private static TransformHiderManager _instance;
    public static TransformHiderManager Instance { get; private set; }
    // {
    //     get
    //     {
    //         if (_instance != null) return _instance;
    //         _instance = new GameObject("Koneko.TransformHiderManager").AddComponent<TransformHiderManager>();
    //         DontDestroyOnLoad(_instance.gameObject);
    //         return _instance;
    //     }
    // }

    #endregion Singleton Implementation
    
    // Implementation
    private bool _resetAfterThisRender;
    
    // Shadow Clones
    private readonly List<ITransformHider> s_TransformHider = new();
    internal void AddTransformHider(ITransformHider clone)
        => s_TransformHider.Add(clone);
    
    private static ProfilerMarker s_OnPreRenderMarker = new("TransformHiderManager.OnPreRender");
    private static ProfilerMarker s_OnPostRenderMarker = new("TransformHiderManager.OnPostRender");
    
    #region Unity Events

    private void Awake()
    {
        if (Instance != null
            && Instance != this)
        {
            Destroy(this);
        }
        Instance = this;
    }

    private void OnEnable()
    {
        Camera.onPreRender += MyOnPreRender;
        Camera.onPostRender += MyOnPostRender;
    }

    private void OnDisable()
    {
        Camera.onPreRender -= MyOnPreRender;
        Camera.onPostRender -= MyOnPostRender;
    }

    private void OnDestroy()
    {
        foreach (ITransformHider hider in s_TransformHider) 
            hider.Dispose();
        s_TransformHider.Clear();
    }

    #endregion Unity Events
    
    #region Transform Hider Managment

    private void Update()
    {
        _resetAfterThisRender = false;
    }
    
    private void MyOnPreRender(Camera cam)
    {
        if (!AASEmulatorCore.Instance.EmulateFPRExclusions)
            return; // don't hide if FPRExclusions are disabled
        
        if (_resetAfterThisRender) 
            return; // can only hide head once per frame
        
        if (cam.name != "SceneCamera")
            return; // only hide in scene view
        
        // if (cam != Camera.main)
        //     return; // only hide in scene view
        
        #if UNITY_EDITOR
        s_OnPreRenderMarker.Begin();
        #endif
        
        _resetAfterThisRender = true;
        
        for (int i = s_TransformHider.Count - 1; i >= 0; i--)
        {
            ITransformHider hider = s_TransformHider[i];
            if (hider is not { IsValid: true })
            {
                hider?.Dispose();
                s_TransformHider.RemoveAt(i);
                continue; // invalid or dead
            }
        
            if (hider.IsActive && !hider.IsHidden) 
                hider.HideTransform();
        }
        
        #if UNITY_EDITOR
        s_OnPreRenderMarker.End();
        #endif
    }

    private void MyOnPostRender(Camera cam)
    {
        if (!_resetAfterThisRender) 
            return; // only show head once per frame
        
        #if UNITY_EDITOR
        s_OnPostRenderMarker.Begin();
        #endif
        
        for (int i = s_TransformHider.Count - 1; i >= 0; i--)
        {
            ITransformHider hider = s_TransformHider[i];
            if (hider is not { IsValid: true })
            {
                hider?.Dispose();
                s_TransformHider.RemoveAt(i);
                continue; // invalid or dead
            }
            
            if (hider.IsActive && hider.IsHidden) 
                hider.ShowTransform();
        }
        
        #if UNITY_EDITOR
        s_OnPostRenderMarker.End();
        #endif
    }

    #endregion Transform Hider Managment

    #region Static Helpers

    private static bool IsLegacyFPRExcluded(Component renderer)
        => renderer.gameObject.name.Contains("[FPR]");
    
    internal static bool TryCreateTransformHider(
        Component renderer, 
        IReadOnlyDictionary<Transform, FPRExclusionWrapper> exclusions, 
        out ITransformHider hider)
    {
        hider = null;
        if (IsLegacyFPRExcluded(renderer))
            return false;

        switch (renderer)
        {
            // catches any renderer that is entirely excluded
            // MeshRenderers, SkinnedMeshRenderers, TrailRenderers, LineRenderers, etc.
            case Renderer baseRenderer when exclusions.ContainsKey(renderer.transform):
                hider = new MeshTransformHider(baseRenderer, exclusions);
                return true;
            
            // catches any SkinnedMeshRenderers that is partially excluded
            case SkinnedMeshRenderer skinnedMeshRenderer:
                if (skinnedMeshRenderer.sharedMesh == null 
                    || skinnedMeshRenderer.sharedMesh.vertexCount == 0 
                    || skinnedMeshRenderer.sharedMesh.vertexBufferCount == 0 
                    || skinnedMeshRenderer.sharedMaterials == null 
                    || skinnedMeshRenderer.sharedMaterials.Length == 0)
                    return false; // invalid skinned mesh renderer

                SkinnedTransformHider skinnedHider = new(skinnedMeshRenderer);
                SkinnedTransformHider.SubTask.FindExclusionVertList(skinnedMeshRenderer, exclusions);

                // each exclusion has a list of verts we reuse, idk how else to do this
                foreach ((_, FPRExclusionWrapper fprExclusion) in exclusions)
                {
                    if (fprExclusion.affectedVertexIndices.Count == 0)
                        continue; // no affected verts
                    
                    fprExclusion.relatedTasks.Add(skinnedHider.AddSubTask(fprExclusion));
                    fprExclusion.affectedVertexIndices.Clear(); // clear list for next SkinnedTransformHider
                    fprExclusion.UpdateFPRState(); // set initial state
                }
                
                hider = skinnedHider;
                return true;
            
            // completely invalid and ineligible for exclusion
            default:
                return false;
        }
    }

    #endregion Static Helpers
}