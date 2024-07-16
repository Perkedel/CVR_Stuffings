using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class MeshTransformHider : ITransformHider, IFPRExclusionTask
{
    // mesh
    private readonly Renderer _mainMesh;
    private bool _enabledState;
    
    #region ITransformHider Implementation
    
    public bool IsActive { get; set; } = true; // default hide, but FPRExclusion can override
    public bool IsValid => _mainMesh != null; // anything player can touch is suspect to death
    public bool IsHidden => !_mainMesh.enabled || !_mainMesh.gameObject.activeInHierarchy;
    
    public bool ShrinkToZero { get; set; } // unused

    public MeshTransformHider(Renderer renderer, IReadOnlyDictionary<Transform, FPRExclusionWrapper> exclusions)
    {
        Transform rootBone = renderer.transform;
        
        // if no key found, dispose
        if (!exclusions.TryGetValue(rootBone, out FPRExclusionWrapper exclusion))
        {
            Dispose();
            return;
        }

        exclusion.relatedTasks.Add(this);
        _mainMesh = renderer;
    }

    public bool PostProcess()
        => true;

    public void HideTransform()
    {
        _enabledState = _mainMesh.enabled;
        _mainMesh.enabled = false;
    }
    
    public void ShowTransform()
    {
        _mainMesh.enabled = _enabledState;
    }

    public void Dispose()
    {
        
    }
    
    #endregion ITransformHider Methods
}