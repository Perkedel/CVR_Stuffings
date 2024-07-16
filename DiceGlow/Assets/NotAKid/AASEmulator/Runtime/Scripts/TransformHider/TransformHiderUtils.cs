using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using ABI.CCK.Components;
using UnityEngine;
using Debug = UnityEngine.Debug;

public static class TransformHiderUtils
{
    private static ComputeShader _shader;

    public static ComputeShader shader
    {
        get
        {
            if (_shader != null) return _shader;
            return _shader = Resources.Load<ComputeShader>("BoneHider");
        }
    }

    public static void SetupAvatar(GameObject avatar)
    {
        Animator animator = avatar.GetComponent<Animator>();
        if (animator == null || animator.avatar == null || animator.avatar.isHuman == false)
            return;

        Transform headBone = animator.GetBoneTransform(HumanBodyBones.Head);
        if (headBone == null)
            return;

        var renderers = avatar.GetComponentsInChildren<Renderer>(true);
        if (renderers == null || renderers.Length == 0)
            return;

        // start stopwatch
        //Stopwatch stopwatch = new();
        //stopwatch.Start();
        
        ProcessRenderers(renderers, avatar.transform, headBone);
        
        // stop stopwatch
        //stopwatch.Stop();
        //Debug.Log($"SetupAvatar execution time: {stopwatch.ElapsedMilliseconds} ms");
    }

    private static void ProcessRenderers(IEnumerable<Renderer> renderers, Component root, Transform headBone)
    {
        var exclusions = CollectTransformToExclusionMap(root, headBone);
        foreach (Renderer renderer in renderers)
        {
            ConfigureRenderer(renderer);
            if (TransformHiderManager.TryCreateTransformHider(renderer, exclusions, out ITransformHider hider))
                TransformHiderManager.Instance.AddTransformHider(hider);
        }
    }

    private static void ConfigureRenderer(Renderer renderer)
    {
        // generic optimizations
        renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;

        // don't let visual/shadow mesh cull in weird worlds
        // (third person stripped local player naked when camera was slightly occluded)
        renderer.allowOcclusionWhenDynamic = false;
        
        if (renderer is not SkinnedMeshRenderer skinnedMeshRenderer)
            return;

        // GraphicsBuffer becomes stale randomly otherwise ???
        //skinnedMeshRenderer.updateWhenOffscreen = true;

        // skin mesh renderer optimizations
        skinnedMeshRenderer.skinnedMotionVectors = false;
        skinnedMeshRenderer.forceMatrixRecalculationPerRender = false; // expensive
        skinnedMeshRenderer.quality = SkinQuality.Bone4;
    }

    private static Dictionary<Transform, FPRExclusionWrapper> CollectTransformToExclusionMap(
        Component root,
        Transform headBone)
    {
        //Stopwatch stopwatch = new();
        //stopwatch.Start();

        if (!headBone.TryGetComponent(out FPRExclusion _)) // creator can override
        {
            FPRExclusion headExclusion = headBone.gameObject.AddComponent<FPRExclusion>();
            headExclusion.isShown = false; // default generate hidden
            headExclusion.target = headBone;
        }

        // find all exclusions so we can create wrappers
        var allFPRExclusions = root.GetComponentsInChildren<FPRExclusion>(true);
        Dictionary<Transform, FPRExclusionWrapper> exclusionTargets = new(allFPRExclusions.Length);

        foreach (FPRExclusion exclusion in allFPRExclusions)
        {
            if (exclusion.target == null
                || !exclusion.target.gameObject.scene.IsValid())
                continue; // invalid target

            FPRExclusionWrapper wrapper = exclusion.gameObject.AddComponent<FPRExclusionWrapper>();

            // populate known roots
            exclusionTargets.TryAdd(wrapper.target, wrapper);
        }

        // recursive find all affected children, stopping at known roots
        var rootCount = exclusionTargets.Count;
        for (var i = 0; i < rootCount; i++)
        {
            FPRExclusionWrapper exclusion = exclusionTargets.Values.ElementAt(i);
            ProcessExclusion(exclusion, exclusion.target);
        }

        //stopwatch.Stop();
        //Debug.Log($"CollectTransformToExclusionMap execution time: {stopwatch.ElapsedMilliseconds} ms");

        return exclusionTargets;
        void ProcessExclusion(FPRExclusionWrapper exclusion, Transform transform)
        {
            if (exclusionTargets.ContainsKey(transform)
                && exclusionTargets[transform] != exclusion)
                return; // found known root

            exclusionTargets.TryAdd(transform, exclusion); // associate with the exclusion

            foreach (Transform child in transform) // recursive
                ProcessExclusion(exclusion, child);
        }
    }
}