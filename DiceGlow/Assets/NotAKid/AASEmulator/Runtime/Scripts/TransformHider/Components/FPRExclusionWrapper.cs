using System.Collections.Generic;
using ABI.CCK.Components;
using NAK.AASEmulator.Runtime;
using UnityEngine;

#if UNITY_EDITOR // custom editor
using UnityEditor;

[CustomEditor(typeof(FPRExclusionWrapper))]
public class FPRExclusionWrapperEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        
        FPRExclusionWrapper wrapper = (FPRExclusionWrapper) target;
        
        // display related tasks
        foreach (IFPRExclusionTask related in wrapper.relatedTasks)
        {
            EditorGUILayout.LabelField(related.GetType().Name + " Task" + (related.IsActive ? " (Active)" : " (Inactive)"));
        }
    }
}

#endif

/// <summary>
/// Manual exclusion component for the TransformHider (FPR) system.
/// Allows you to manually hide and show a transform that would otherwise be hidden.
/// </summary>
public class FPRExclusionWrapper : EditorOnlyMonoBehaviour
{
    internal readonly List<int> affectedVertexIndices = new();
    internal readonly List<IFPRExclusionTask> relatedTasks = new();
    
    internal Transform target => _exclusion.target;
    private bool shrinkToZero => _exclusion.shrinkToZero;
    
    private FPRExclusion _exclusion;
    private bool _wasShown;

    internal override void Awake()
    {
        base.Awake();
        _exclusion = gameObject.GetComponent<FPRExclusion>();
    }

    private void Update()
    {
        if (_exclusion.isShown == _wasShown) return;
        SetFPRState(_wasShown = _exclusion.isShown);
    }
    
    public void UpdateFPRState()
        => SetFPRState(_wasShown = _exclusion.isShown);
    
    private void SetFPRState(bool state)
    {
        if (relatedTasks == null) return; // no hiders to set
        foreach (IFPRExclusionTask task in relatedTasks)
        {
            task.IsActive = !state;
            task.ShrinkToZero = shrinkToZero;
        }
    }
}

public interface IFPRExclusionTask
{
    public bool IsActive { get; set; }
    public bool ShrinkToZero { get; set; }
}