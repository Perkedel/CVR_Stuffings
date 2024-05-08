// using ABI.CCK.Components;
// using System;
// using UnityEngine;
//
// namespace NAK.AASEmulator.Runtime.SubSystems
// {
//     public class AvatarLipSyncHandler
//     {
//         // Viseme handling
//         private int _visemeSmoothing = 50;
//         private float _visemeSmoothingFactor = 0.5f;
//         private float[] m_visemeCurrentBlendShapeWeights;
//
//         // Jaw Bone handling
//         private static int _jawBoneMuscleIndex = -1;
//
//         // Avatar info
//         private readonly AASEmulatorRuntime m_runtime;
//         private readonly CVRAvatar m_avatar;
//         private int[] m_visemeBlendShapeIndicies;
//
//         public AvatarLipSyncHandler(AASEmulatorRuntime runtime)
//         {
//             m_runtime = runtime;
//             m_avatar = runtime.m_avatar;
//             InitializeLipSync();
//         }
//
//         public void OnLateUpdate()
//         {
//             Apply_LipSync();
//         }
//
//         private void InitializeLipSync()
//         {
//             // Get jaw bone index
//             if (_jawBoneMuscleIndex == -1)
//                 _jawBoneMuscleIndex = Array.FindIndex(HumanTrait.MuscleName, muscle => muscle.Contains("Jaw"));
//
//             if (m_avatar.bodyMesh != null && m_avatar.visemeBlendshapes != null)
//             {
//                 // Rough replication of games iffy viseme smoothing... OVRLipSync only wants 1-100!
//                 _visemeSmoothing = m_avatar.visemeSmoothing;
//                 _visemeSmoothingFactor = Mathf.Clamp(100 - _visemeSmoothing, 1f, 100f) / 100f;
//
//                 m_visemeBlendShapeIndicies =
//                     new int[m_avatar.visemeBlendshapes?.Length ?? 0];
//
//                 if (m_avatar.visemeBlendshapes == null)
//                     return;
//
//                 for (var i = 0; i < m_avatar.visemeBlendshapes.Length; i++)
//                     m_visemeBlendShapeIndicies[i] =
//                         m_avatar.bodyMesh.sharedMesh.GetBlendShapeIndex(m_avatar.visemeBlendshapes[i]);
//             }
//             else
//             {
//                 m_visemeBlendShapeIndicies = Array.Empty<int>();
//             }
//         }
//
//         private void Apply_LipSync()
//         {
//             if (m_avatar.bodyMesh == null)
//                 return;
//
//             float useVisemeLipsync = m_avatar.useVisemeLipsync ? 1f : 0f;
//
//             switch (m_avatar.visemeMode)
//             {
//                 case CVRAvatar.CVRAvatarVisemeMode.Visemes:
//                     {
//                         if (_visemeSmoothing != m_avatar.visemeSmoothing)
//                             _visemeSmoothingFactor = Mathf.Clamp(100 - m_avatar.visemeSmoothing, 1f, 100f) / 100f;
//                         _visemeSmoothing = m_avatar.visemeSmoothing;
//
//                         if (m_visemeCurrentBlendShapeWeights == null || m_visemeCurrentBlendShapeWeights.Length != m_visemeBlendShapeIndicies.Length)
//                             m_visemeCurrentBlendShapeWeights = new float[m_visemeBlendShapeIndicies.Length];
//
//                         for (var i = 0; i < m_visemeBlendShapeIndicies.Length; i++)
//                             if (m_visemeBlendShapeIndicies[i] != -1)
//                                 m_avatar.bodyMesh.SetBlendShapeWeight(m_visemeBlendShapeIndicies[i],
//                                     m_visemeCurrentBlendShapeWeights[i] = Mathf.Lerp(m_visemeCurrentBlendShapeWeights[i],
//                                         i == m_runtime.Viseme ? 100.0f : 0.0f, _visemeSmoothingFactor) * useVisemeLipsync);
//                         break;
//                     }
//                 case CVRAvatar.CVRAvatarVisemeMode.SingleBlendshape:
//                     {
//                         if (m_visemeBlendShapeIndicies.Length > 0 && m_visemeBlendShapeIndicies[0] != -1)
//                             m_avatar.bodyMesh.SetBlendShapeWeight(m_visemeBlendShapeIndicies[0],
//                                 m_runtime.VisemeLoudness * 100.0f * useVisemeLipsync);
//                         break;
//                     }
//                 case CVRAvatar.CVRAvatarVisemeMode.JawBone when m_runtime.m_animator.isHuman:
//                     {
//                         m_runtime.m_humanPoseHandler.GetHumanPose(ref m_runtime.m_humanPose);
//                         if (_jawBoneMuscleIndex < m_runtime.m_humanPose.muscles.Length)
//                         {
//                             m_runtime.m_humanPose.muscles[_jawBoneMuscleIndex] = m_runtime.VisemeLoudness * useVisemeLipsync;
//                             m_runtime.m_humanPoseHandler.SetHumanPose(ref m_runtime.m_humanPose);
//                         }
//                         break;
//                     }
//             }
//         }
//     }
// }