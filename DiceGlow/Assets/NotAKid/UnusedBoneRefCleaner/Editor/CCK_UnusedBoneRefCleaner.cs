using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace NAK.UnusedBoneRefCleaner
{
    public static class CCK_UnusedBoneRefCleaner
    {
        public const string TempAssetPath = "Assets/NotAKid/UnusedBoneRefCleaner/GeneratedMeshes/";
        
        public static void CleanupNoWeightBonesOnCopy(SkinnedMeshRenderer renderer)
        {
            Mesh sharedMesh = renderer.sharedMesh;
            if (sharedMesh == null)
            {
                Debug.LogWarning("No shared mesh found on SkinnedMeshRenderer. Skipping cleanup...");
                return;
            }
            
            // Clone the mesh to avoid modifying the original
            sharedMesh = renderer.sharedMesh = Object.Instantiate(sharedMesh);
            
            // Remove bones with no weight for this renderer
            CleanupNoWeightBonesFromSkinnedMeshRenderer(renderer);
            
            // Save the mesh to an asset
            string assetPath = TempAssetPath + renderer.sharedMesh.name + "_CleanedBoneReferences";
            string assetPathWithExtension = assetPath + ".asset";
            
            // Lets hope that the bundle does not include the old mesh as well, because sometimes it just does :>
            // Unsure how to properly handle this- potentially need to do this to the source mesh instead?
            
            // Ensure the asset path is valid
            if (!AssetDatabase.IsValidFolder(TempAssetPath))
                AssetDatabase.CreateFolder("Assets/NotAKid/UnusedBoneRefCleaner", "GeneratedMeshes");
            
            // Save the mesh to an asset so it can be included in the final bundle
            string assetPathUnique = AssetDatabase.GenerateUniqueAssetPath(assetPathWithExtension);
            AssetDatabase.CreateAsset(sharedMesh, assetPathUnique);
        }
        
        /// <summary>
        ///     Removes bones that have no weight from the SkinnedMeshRenderer.
        ///     This is needed as Unity does not seem to handle this properly when building the asset bundle,
        ///     leading to the Client to assume *all mesh* are affected by *all bones*.
        ///     This is highly important for performance reasons with our head-hiding technique.
        /// </summary>
        /// <param name="renderer"></param>
        public static void CleanupNoWeightBonesFromSkinnedMeshRenderer(SkinnedMeshRenderer renderer)
        {
            Mesh sharedMesh = renderer.sharedMesh;
            if (sharedMesh == null)
            {
                Debug.LogWarning("No shared mesh found on SkinnedMeshRenderer. Skipping cleanup...");
                return;
            }
            
            var bones = renderer.bones;
            var boneWeights = sharedMesh.boneWeights;
            var bindposes = sharedMesh.bindposes;

            const float minWeightThreshold = 0.01f;
            var hasSignificantWeight = new bool[bones.Length];

            // Check each bone weight for each vertex to see if any bone has a significant weight
            foreach (BoneWeight weight in boneWeights)
            {
                if (weight.weight0 >= minWeightThreshold) hasSignificantWeight[weight.boneIndex0] = true;
                if (weight.weight1 >= minWeightThreshold) hasSignificantWeight[weight.boneIndex1] = true;
                if (weight.weight2 >= minWeightThreshold) hasSignificantWeight[weight.boneIndex2] = true;
                if (weight.weight3 >= minWeightThreshold) hasSignificantWeight[weight.boneIndex3] = true;
            }

            // Filter bones and bindposes based on significant weight
            var newBones = new List<Transform>();
            var newBindposes = new List<Matrix4x4>();
            var boneIndexMap = new Dictionary<int, int>();

            for (var i = 0; i < bones.Length; i++)
            {
                if (!hasSignificantWeight[i]) 
                    continue;
                
                // Only add bones back that have significant weight
                boneIndexMap[i] = newBones.Count;
                newBones.Add(bones[i]);
                newBindposes.Add(bindposes[i]);
            }
            
            // Update bone weights to new bone indices
            var newBoneWeights = new BoneWeight[boneWeights.Length];
            for (var i = 0; i < boneWeights.Length; i++)
            {
                BoneWeight bw = boneWeights[i];
                newBoneWeights[i] = new BoneWeight
                {
                    weight0 = bw.weight0,
                    boneIndex0 = bw.boneIndex0 >= 0 && hasSignificantWeight[bw.boneIndex0]
                        ? boneIndexMap[bw.boneIndex0]
                        : 0,
                    weight1 = bw.weight1,
                    boneIndex1 = bw.boneIndex1 >= 0 && hasSignificantWeight[bw.boneIndex1]
                        ? boneIndexMap[bw.boneIndex1]
                        : 0,
                    weight2 = bw.weight2,
                    boneIndex2 = bw.boneIndex2 >= 0 && hasSignificantWeight[bw.boneIndex2]
                        ? boneIndexMap[bw.boneIndex2]
                        : 0,
                    weight3 = bw.weight3,
                    boneIndex3 = bw.boneIndex3 >= 0 && hasSignificantWeight[bw.boneIndex3]
                        ? boneIndexMap[bw.boneIndex3]
                        : 0
                };
            }

            // Apply the changes back to the renderer and mesh
            renderer.bones = newBones.ToArray();
            sharedMesh.bindposes = newBindposes.ToArray();
            sharedMesh.boneWeights = newBoneWeights;
        }
    }
}