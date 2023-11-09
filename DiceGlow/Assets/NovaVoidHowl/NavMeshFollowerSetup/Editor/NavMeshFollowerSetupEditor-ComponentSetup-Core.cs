// Version: 1.1.5
using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Animations;
using uk.novavoidhowl.dev.navmeshfollowersetup;
// using NVHCommonUI = uk.novavoidhowl.dev.common.ui;

// Dynamic loads
#if CVR_CCK_EXISTS
using ABI.CCK.Components;
#endif

#if KAFE_CVR_CCK_NAV_MESH_FOLLOWER_EXISTS
using Kafe.NavMeshFollower.CCK;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {


// Common functions ------------------------------------------------------------------------------------------------------------------------------

    // Function to align navMeshFollowerBody to 0,0,0 position relative to parent
    private void alignFollowerBody(GameObject navMeshFollowerBody)
    {
      // set navMeshFollowerBody to 0,0,0 position relative to parent
      navMeshFollowerBody.transform.localPosition = Vector3.zero;
    }

    // Function to add parent constraint to navMeshFollowerBody
    private void addFollowerBodyParentConstraint(GameObject navMeshFollowerBody, GameObject scriptRootObject)
    {
      // Check if navMeshFollowerBody has a parent constraint
      ParentConstraint parentConstraint = navMeshFollowerBody.GetComponent<ParentConstraint>();
      if (parentConstraint == null)
      {
        // Add parent constraint to navMeshFollowerBody
        parentConstraint = navMeshFollowerBody.AddComponent<ParentConstraint>();
        Debug.Log("added parent constraint to navMeshFollowerBody");
      }
      else
      {
        // check if parent constraint has any sources
        if (parentConstraint.sourceCount > 0)
        {
          // Remove existing sources from parent constraint
          parentConstraint.RemoveSource(0);
        }
      }

      // remove existing sources from parent constraint

      // Get the list of sources.
      SerializedObject serializedConstraint = new SerializedObject(parentConstraint);
      SerializedProperty sourcesProperty = serializedConstraint.FindProperty("m_Sources");

      // Clear all sources by removing them one by one.
      sourcesProperty.ClearArray();

      // Apply the changes to the constraint.
      serializedConstraint.ApplyModifiedProperties();

      // deactivate parent constraint
      parentConstraint.constraintActive = false;

      // Set parent constraint to follow navMeshFollowerBody
      ConstraintSource constraintSourceBody = new ConstraintSource();
      constraintSourceBody.sourceTransform = navMeshFollowerBody.transform;
      constraintSourceBody.weight = 1;

      // Set parent constraint to follow NavMeshAgent object under scriptRootObject (for level 1 follower)
      GameObject navMeshAgent = scriptRootObject.transform.Find("NavMeshAgent")?.gameObject;
      // Set parent constraint to follow "NavMeshAgent" object under "[NavMeshFollower]" game object under scriptRootObject (for level 2 followers)
      if (navMeshAgent == null)
      {
        navMeshAgent = scriptRootObject.transform.Find("[NavMeshFollower]/NavMeshAgent")?.gameObject;
      }
      // Set parent constraint to follow "NavMeshAgent [Raw]" object under "[NavMeshFollower]" game object under scriptRootObject (for level 3 followers)
      if (navMeshAgent == null)
      {
        navMeshAgent = scriptRootObject.transform.Find("[NavMeshFollower]/NavMeshAgent [Raw]")?.gameObject;
      }

      ConstraintSource constraintSourceAgent = new ConstraintSource();
      constraintSourceAgent.sourceTransform = navMeshAgent.transform;
      constraintSourceAgent.weight = 0.25F;

      parentConstraint.AddSource(constraintSourceBody);
      parentConstraint.AddSource(constraintSourceAgent);

      parentConstraint.SetTranslationOffset(0, Vector3.zero);
      parentConstraint.SetRotationOffset(0, Vector3.zero);
      parentConstraint.constraintActive = true;
      Debug.Log("updating parent constraint on navMeshFollowerBody");
    }

    //function to ensure that the folder for generated animators exists
    private static void CreateFoldersInAssetsRecursively(string folderPath)
    {
      string[] folders = folderPath.Split('/');
      string currentPath = "Assets";
      foreach (string folder in folders)
      {
        if (!AssetDatabase.IsValidFolder(currentPath + "/" + folder))
        {
          AssetDatabase.CreateFolder(currentPath, folder);
        }
        currentPath += "/" + folder;
      }
    }

    private void addSpawnable(GameObject scriptRootObject, NavMeshFollowerSetup navMeshFollowerSetup)
    {

      // check if CVRSpawnable component exists
      CVRSpawnable CVRSpawnableComponent = scriptRootObject.GetComponent<CVRSpawnable>();
      if (CVRSpawnableComponent == null)
      {
        // Add CVRSpawnable component to scriptRootObject
        CVRSpawnableComponent = scriptRootObject.AddComponent<CVRSpawnable>();
      }

    }
    private void setupSpawnableValuesCore(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject)
    {
      // Get the CVRSpawnable component
      CVRSpawnable CVRSpawnableComponent = scriptRootObject.GetComponent<CVRSpawnable>();

      // Set the enable flag for Sync Variables
      CVRSpawnableComponent.useAdditionalValues = true;

      // Get the animator controller from the navMeshFollowerBody
      Animator navMeshFollowerBodyAnimator = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();

      // get the current list of values
      List<CVRSpawnableValue> syncValues = CVRSpawnableComponent.syncValues;

      // merge the navMeshFollowerSetup.nmfConfigVariables and navMeshFollowerSetup.nmfAnimatorControllerVariables lists
      List<NmfConfigVariable> mergedNmfConfigVariables = new List<NmfConfigVariable>();
      mergedNmfConfigVariables.AddRange(navMeshFollowerSetup.nmfConfigVariables);
      mergedNmfConfigVariables.AddRange(navMeshFollowerSetup.nmfAnimatorControllerVariables);


      // for each enabled variable in navMeshFollowerSetup.nmfConfigVariables check if it exists in the CVRSpawnable component and add it if it doesn't
      foreach (NmfConfigVariable nmfConfigVariable in mergedNmfConfigVariables)
      {
        if (nmfConfigVariable.enabled)
        {
          if (!isInCVRSpawnableValueList(syncValues, nmfConfigVariable.name, navMeshFollowerBodyAnimator, nmfConfigVariable.name))
          {
            // add value to the CVRSpawnable component for the variable
            syncValues.Add(new CVRSpawnableValue{
                                  name = nmfConfigVariable.name,
                                  startValue = float.Parse(nmfConfigVariable.default_value),
                                  updatedBy = CVRSpawnableValue.UpdatedBy.None,
                                  updateMethod = CVRSpawnableValue.UpdateMethod.Override,
                                  animator = navMeshFollowerBodyAnimator,
                                  animatorParameterName = nmfConfigVariable.name
                                }
                          );
          }
        }
        else
        {
          // remove value from the CVRSpawnable component for the variable
          syncValues.RemoveAll(x => x.name == nmfConfigVariable.name && x.animator == navMeshFollowerBodyAnimator && x.animatorParameterName == nmfConfigVariable.name);
        }
      }

      // write the updated list of values back to the CVRSpawnable component
      CVRSpawnableComponent.syncValues = syncValues;

    }



    private void setupSpawnableIKValues(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject)
    {
      // Get the CVRSpawnable component
      CVRSpawnable CVRSpawnableComponent = scriptRootObject.GetComponent<CVRSpawnable>();

      // Set the enable flag for Sync Variables
      CVRSpawnableComponent.useAdditionalValues = true;

      // Get the animator controller from the the game object under the scriptRootObject at the path NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_root_path
      Animator animator = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_root_path)?.gameObject.GetComponent<Animator>();


      // get the current list of values
      List<CVRSpawnableValue> syncValues = CVRSpawnableComponent.syncValues;

      // check through the list of spawnable values and remove any that are linked to the animator to prevent duplicates
      syncValues.RemoveAll(x => x.animator == animator);

      // for each enabled variable in navMeshFollowerSetup.nmfIKVariables add it to the CVRSpawnable component
      foreach (NmfConfigVariable nmfIKVariable in navMeshFollowerSetup.nmfIKVariables)
      {
        if (nmfIKVariable.enabled)
        {
          // add value to the CVRSpawnable component for the variable
          syncValues.Add(new CVRSpawnableValue{
                                name = nmfIKVariable.name,
                                startValue = float.Parse(nmfIKVariable.default_value),
                                updatedBy = CVRSpawnableValue.UpdatedBy.None,
                                updateMethod = CVRSpawnableValue.UpdateMethod.Override,
                                animator = animator,
                                animatorParameterName = nmfIKVariable.name
                              }
                        );
        }
      }

      // write the updated list of values back to the CVRSpawnable component
      CVRSpawnableComponent.syncValues = syncValues;

    }





    public bool isInCVRSpawnableValueList(List<CVRSpawnableValue> syncValues, string valueName, Animator animator, string animatorParameterName)
    {
      // loop through the list of CVRSpawnableValue objects
      foreach (CVRSpawnableValue syncValue in syncValues)
      {
        // check if the valueName matches the name of the CVRSpawnableValue object
        if (syncValue.name == valueName)
        {
          // check if the animator matches the animator of the CVRSpawnableValue object
          if (syncValue.animator == animator)
          {
            // check if the animatorParameterName matches the animatorParameterName of the CVRSpawnableValue object
            if (syncValue.animatorParameterName == animatorParameterName)
            {
              // return true if all three match
              return true;
            }
          }
        }
      }
      // return false if no match is found
      return false;
    }

    // Function to setup bones in the UI
    public void setupUIbonesList(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // bone count
      int boneCount = 4; // default number of bones is 4 (Spine, Chest, Upper Chest, Neck)
      // check if the bones Spine, Chest, Upper Chest, Neck and decrement boneCount if they do not exist
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Spine) == null)
      {
        boneCount--;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Chest) == null)
      {
        boneCount--;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.UpperChest) == null)
      {
        boneCount--;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Neck) == null)
      {
        boneCount--;
      }

      // set spineBones array to default setup
      navMeshFollowerSetup.spineBones = new Transform[boneCount];

      // set the spineBones that exist
      int boneSetterCount = 0;

      // set the spineBones that exist

      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Spine) != null)
      {
        navMeshFollowerSetup.spineBones[boneSetterCount] = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Spine);
        boneSetterCount++;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Chest) != null)
      {
        navMeshFollowerSetup.spineBones[boneSetterCount] = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Chest);
        boneSetterCount++;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.UpperChest) != null)
      {
        navMeshFollowerSetup.spineBones[boneSetterCount] = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.UpperChest);
        boneSetterCount++;
      }
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Neck) != null)
      {
        navMeshFollowerSetup.spineBones[boneSetterCount] = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.Neck);
        boneSetterCount++;
      }
    }

    private void setupNMFAnimator(NavMeshFollowerSetup navMeshFollowerSetup, GameObject navMeshFollowerBody, int followerLevel)
    {
      // Check if the Animator component exists on the navMeshFollowerBody game object
      Animator navMeshFollowerBodyAnimator = navMeshFollowerBody.GetComponent<Animator>();
      if (navMeshFollowerBodyAnimator == null)
      {
        // Add the Animator component to the navMeshFollowerBody game object
        navMeshFollowerBodyAnimator = navMeshFollowerBody.AddComponent<Animator>();
      }

      // get the name of the navMeshFollowerBody game object
      string navMeshFollowerBodyName = navMeshFollowerBody.name;

      CreateFoldersInAssetsRecursively("NMF/GeneratedAnimators/" + navMeshFollowerBodyName);

      // check if the animator controller exists at Assets\NMF\GeneratedAnimators\{navMeshFollowerBodyName}\{navMeshFollowerBodyName}_Level_{followerLevel}_Animator.controller
      if (AssetDatabase.LoadAssetAtPath("Assets/NMF/GeneratedAnimators/" + navMeshFollowerBodyName + "/" + navMeshFollowerBodyName + "_Level_" + followerLevel + "_Animator.controller", typeof(RuntimeAnimatorController)) == null)
      {

        // copy the animator to the folder made above
        AssetDatabase.CopyAsset(NMFSConfig.follower_level_data[followerLevel].animator_file_path, "Assets/NMF/GeneratedAnimators/" + navMeshFollowerBodyName + "/" + navMeshFollowerBodyName + "_Level_" + followerLevel + "_Animator.controller");
      }

      // set the animator controller on the navMeshFollowerBodyAnimator to be the one we just copied
      navMeshFollowerBodyAnimator.runtimeAnimatorController = (RuntimeAnimatorController)AssetDatabase.LoadAssetAtPath("Assets/NMF/GeneratedAnimators/" + navMeshFollowerBodyName + "/" + navMeshFollowerBodyName + "_Level_" + followerLevel + "_Animator.controller", typeof(RuntimeAnimatorController));

      // set animator culling mode to always animate
      navMeshFollowerBodyAnimator.cullingMode = AnimatorCullingMode.AlwaysAnimate;

      // check if the navMeshFollowerBody animator avatar is null or not
      if (navMeshFollowerBodyAnimator.avatar != null)
      {
        // harvest the avatar from the navMeshFollowerBodyAnimator before we set the animator controller up so we can put it back later if needed
        navMeshFollowerSetup.avatar = navMeshFollowerBodyAnimator.avatar;
      }

      if (NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].blank_avatar)
      {
        // ensure that Avatar is set to None
        navMeshFollowerBodyAnimator.avatar = null;
      }
      else
      {
        // if navMeshFollowerSetup.avatar is not null
        if (navMeshFollowerSetup.avatar != null)
        {
          // set the avatar on the navMeshFollowerBodyAnimator to be the one from the navMeshFollowerSetup
          navMeshFollowerBodyAnimator.avatar = navMeshFollowerSetup.avatar;
        }
        // if not harvested to the setup object already, there is nothing we can do about it being null


      }

    }

    private void setupNMFSpawnableSubSync(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject)
    {
      // Get the CVRSpawnable component
      CVRSpawnable CVRSpawnableComponent = scriptRootObject.GetComponent<CVRSpawnable>();


      // get current list of sub syncs
      List<CVRSpawnableSubSync> subSyncs = CVRSpawnableComponent.subSyncs;


      // for each subsync in NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].sub_syncs
      foreach(NmfSubSync subsync in NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].sub_syncs)
      {
        // check if the transform from subsync matches any of the transforms in the sub syncs list from the spawnable component

        if (subSyncs.Count > 0)
        {
          // there are sub syncs in the list, so loop through them
          for (int i = 0; i < subSyncs.Count; i++)
          {
            if (subSyncs[i].transform == scriptRootObject.transform.Find(subsync.object_path))
            {
              // managed subsync found so remove it from the list (to prevent duplicates)
              subSyncs.RemoveAt(i);
            }
          }
        }


        // Convert the synced values list to a CVRSpawnableSubSync.SyncFlags variable
        CVRSpawnableSubSync.SyncFlags syncedValuesFromConfig = 0;
        foreach (string flagName in subsync.sync_flags)
        {
          CVRSpawnableSubSync.SyncFlags flag = (CVRSpawnableSubSync.SyncFlags)System.Enum.Parse(typeof(CVRSpawnableSubSync.SyncFlags), flagName);
          syncedValuesFromConfig |= flag;
        }


        // subsync add it to the sub syncs list
        subSyncs.Add(new CVRSpawnableSubSync
        {
          transform = scriptRootObject.transform.Find(subsync.object_path),
          precision = CVRSpawnableSubSync.SyncPrecision.Full,
          syncedValues = syncedValuesFromConfig
        });


      }

      // set the sub syncs
      CVRSpawnableComponent.subSyncs = subSyncs;
    }

    private void updateNMFNavMeshAgent(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject)
    {
      // Get the navmesh agent object
      GameObject navMeshAgent = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].agent_path)?.gameObject;
      // zero out position and rotation, just in case someone/something moved it
      navMeshAgent.transform.localPosition = Vector3.zero;
      navMeshAgent.transform.localRotation = Quaternion.identity;
      // get navmesh agent component
      UnityEngine.AI.NavMeshAgent agent = navMeshAgent.GetComponent<UnityEngine.AI.NavMeshAgent>();
      agent.speed = navMeshFollowerSetup.agent_speed;
      agent.angularSpeed = navMeshFollowerSetup.agent_angularSpeed;
      agent.acceleration = navMeshFollowerSetup.agent_acceleration;
      agent.stoppingDistance = navMeshFollowerSetup.agent_stoppingDistance;
      agent.autoBraking = true; // locked to true
      agent.radius = navMeshFollowerSetup.agent_radius;
      agent.height = navMeshFollowerSetup.agent_height;
      agent.avoidancePriority = 50; // locked
      agent.autoTraverseOffMeshLink = true; // locked
      agent.autoRepath = true; // locked
      agent.areaMask = -1; // locked
      // disable navmeshagent component
      agent.enabled = false; // locked

      Debug.Log("Updated NavMeshAgent");
    }


    // level 2 & 3 shared functions ------------------------------------------------------------------------------------------------------------------------------

    private void updateLookAtTargetPosition(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject, GameObject navMeshFollowerBody)
    {
      // get the 'LookAtTarget [Raw]' gameObject under the navMeshFollowerConfigObject
      Transform lookAtTargetRaw = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path)?.gameObject.transform;
      // check if lookAtTargetRaw is null
      if (lookAtTargetRaw == null)
      {
        // show error message popup
        EditorUtility.DisplayDialog("Error", NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path + " not found", "OK");
      }
      else
      {
        //print the fact that we found the lookAtTargetRaw to the console
        DebugConsoleLog("Found" + NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path);
      }

      // get the 'LookAtTarget [Raw] -> Offset' gameObject under the lookAtTargetRaw gameObject
      Transform lookAtTargetRawOffset = lookAtTargetRaw.transform.Find("LookAtTarget [Raw] -> Offset")?.gameObject.transform;
      // check if lookAtTargetRawOffset is null
      if (lookAtTargetRawOffset == null)
      {
        // show error message popup
        EditorUtility.DisplayDialog("Error", "LookAtTarget [Raw] -> Offset not found", "OK");
      }
      else
      {
        //print the fact that we found the lookAtTargetRawOffset to the console
        DebugConsoleLog("Found LookAtTarget [Raw] -> Offset");
      }

      // reparent the lookAtTargetRawOffset to the headBone
      lookAtTargetRaw.transform.parent = navMeshFollowerSetup.headBone;

      // zero out the y position of the lookAtTargetRawOffset, leaving the x and z position untouched
      lookAtTargetRaw.transform.localPosition = new Vector3(lookAtTargetRawOffset.transform.localPosition.x, 0, lookAtTargetRawOffset.transform.localPosition.z);

      // reparent the lookAtTargetRawOffset back to the '[NavMeshFollower]' gameObject under the scriptRootObject
      lookAtTargetRaw.transform.parent = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject.transform;


      // get the leftEyeBone gameObject from the navMeshFollowerSetup
      Transform leftEyeBone = navMeshFollowerSetup.leftEyeBone;
      // check if leftEyeBone is null
      if (leftEyeBone == null)
      {
        // show error message popup
        EditorUtility.DisplayDialog("Error", "leftEyeBone not found \nswitching to head position for look offset, this will not be as accurate", "OK");

        // zero out the position and rotation of the lookAtTargetRawOffset
        lookAtTargetRawOffset.transform.localPosition = Vector3.zero;

      }
      else
      {
        //print the fact that we found the leftEyeBone to the console
        Debug.Log("Found leftEyeBone");

        // zero out the position and rotation of the lookAtTargetRawOffset
        lookAtTargetRawOffset.transform.localPosition = Vector3.zero;

        // reparent the lookAtTargetRawOffset to the leftEyeBone
        lookAtTargetRawOffset.transform.parent = leftEyeBone;

        // zero out the y position of the lookAtTargetRawOffset, leaving the x and z position untouched
        lookAtTargetRawOffset.transform.localPosition = new Vector3(lookAtTargetRawOffset.transform.localPosition.x, 0, lookAtTargetRawOffset.transform.localPosition.z);

        // reparent the lookAtTargetRawOffset back to under the lookAtTargetRaw gameObject
        lookAtTargetRawOffset.transform.parent = lookAtTargetRaw.transform;

        //zero out the x and z position of the lookAtTargetRawOffset, leaving the y position untouched
        lookAtTargetRawOffset.transform.localPosition = new Vector3(0, lookAtTargetRawOffset.transform.localPosition.y, 0);

        // set the Z position of the lookAtTargetRaw to 0.678413
        lookAtTargetRaw.transform.localPosition = new Vector3(lookAtTargetRaw.transform.localPosition.x, lookAtTargetRaw.transform.localPosition.y, 0.678413f);
      }
    }


    private void ResetParentConstraint(ParentConstraint parentConstraint)
    {
        // Remove all sources from the constraint
        while (parentConstraint.sourceCount > 0)
        {
            parentConstraint.RemoveSource(0);
        }

        // Reset the constraint's translation and rotation offsets to zero
        // parentConstraint.translationOffset = Vector3.zero;
        // parentConstraint.rotationOffset = Quaternion.identity;
    }

  }
}
