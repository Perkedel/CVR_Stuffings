// Version: 1.0.0
using UnityEditor.PackageManager;
using UnityEngine;
using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine.Animations;
using uk.novavoidhowl.dev.navmeshfollowersetup;
// using NVHCommonUI = uk.novavoidhowl.dev.common.ui;

// Dynamic loads
#if CVR_CCK_EXISTS
using ABI.CCK.Components;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {


    ////////////////////////////////////////////////////////////////////////////////////////////////
    //// package version functions

    // Function to get the package version of NavMeshFollowerSetup
    private string GetPackageVersion()
    {
      string packagePath = "Packages/uk.novavoidhowl.dev.navmeshfollowersetup/package.json";
      string packageJson = File.ReadAllText(packagePath);
      Match match = Regex.Match(packageJson, @"""version""\s*:\s*""([^""]+)""");
      if (match.Success)
      {
        return match.Groups[1].Value;
      }
      return "Unknown";
    }

    // Function to get the package version common ui package
    private string GetCommonUIPackageVersion()
    {
      string packagePath = "Packages/uk.novavoidhowl.dev.common/package.json";
      // check if common ui package exists
      if (isCommonUIPackageInstalled())
      {
        string packageJson = File.ReadAllText(packagePath);
        Match match = Regex.Match(packageJson, @"""version""\s*:\s*""([^""]+)""");
        if (match.Success)
        {
          return match.Groups[1].Value;
        }
        return "Unknown";
      }
      else
      {
        return "Not Installed";
      }
    }
    private bool isCommonUIPackageInstalled()
    {
      #if NVH_COMMON_EXISTS
        return true;
      #else
        return false;
      #endif
    }


    //////////////////////////////////////////////////////////////////////////////////////////////////
    //// Check config file
    ////
    ///

    // Function to check if config file exists in Kaefijao's NMF folder
    private bool isConfigFileExists(){
        return File.Exists(NMFConstants.configFilePath_primary);
    }

    private bool isConfigFileExistsInPackagesFolder(){

      if (File.Exists(NMFConstants.configFilePath_fallback))
      {
        return true;
      }
      else
      {
        return false;
      }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // Functions that require CVR_CCK_EXISTS

    #if CVR_CCK_EXISTS
    public float getSubSyncCosts(CVRSpawnable _spawnable)
    {
      float SubSyncCosts = 0f;

      foreach (var subSync in _spawnable.subSyncs)
      {
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.TransformX))
          SubSyncCosts += (int) subSync.precision / 4f;
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.TransformY))
          SubSyncCosts += (int) subSync.precision / 4f;
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.TransformZ))
          SubSyncCosts += (int) subSync.precision / 4f;
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.RotationX))
          SubSyncCosts += (int) subSync.precision / 4f;
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.RotationY))
          SubSyncCosts += (int) subSync.precision / 4f;
        if (subSync.syncedValues.HasFlag(CVRSpawnableSubSync.SyncFlags.RotationZ))
          SubSyncCosts += (int) subSync.precision / 4f;
      }

      return SubSyncCosts;
    }

    #endif

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //// Functions to lookup/find components and add that data to the navMeshFollowerSetup component
    ////

    // Function to check if headbone is set
    private bool isHeadBoneSet(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      if (navMeshFollowerSetup.headBone == null)
      {
        return false;
      }
      else
      {
        return true;
      }
    }

    // Function to check if leftHand is set
    private bool isLeftHandSet(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      if (navMeshFollowerSetup.leftHand == null)
      {
        return false;
      }
      else
      {
        return true;
      }
    }

    // Function to check if rightHand is set
    private bool isRightHandSet(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      if (navMeshFollowerSetup.rightHand == null)
      {
        return false;
      }
      else
      {
        return true;
      }
    }

    // Function to check if leftEyeBone is set
    private bool isLeftEyeBoneSet(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      if (navMeshFollowerSetup.leftEyeBone == null)
      {
        return false;
      }
      else
      {
        return true;
      }
    }

    // Function to check if rightEyeBone is set
    private bool isRightEyeBoneSet(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      if (navMeshFollowerSetup.rightEyeBone == null)
      {
        return false;
      }
      else
      {
        return true;
      }
    }

    // Function to return the head bone given the navMeshFollowerBody
    private Transform getHeadBone(GameObject navMeshFollowerBody)
    {
      // Output error if navMeshFollowerBody is null
      if (navMeshFollowerBody == null)
      {
        Debug.LogError("Navmesh Follower Body is null");
        return null;
      }
      else
      {
        Debug.Log("Navmesh Follower Body detected");
        // Check if navMeshFollowerBody has an animator component
        Animator animator = navMeshFollowerBody.GetComponent<Animator>();
        if (animator == null)
        {
          Debug.LogError("Navmesh Follower Body does not have Animator component");
          return null;
        }
        else
        {
          Debug.Log("Navmesh Follower Body has Animator component");
          // Get the head bone transform directly from the animator
          Transform headBone = animator.GetBoneTransform(HumanBodyBones.Head);
          if (headBone != null)
          {
            Debug.Log("Navmesh Follower Body has Head Bone");
            return headBone;
          }
          else
          {
            Debug.LogError("Head Bone transform is null");
            return null;
          }
        }
      }
    }

    // Function to set the head bone value in navMeshFollowerSetup
    private void setHeadBoneFromnavMeshFollowerBody(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // check if navMeshFollowerBody has an avatar value
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().avatar == null)
      {
        // disable ui, for the button if avatar is null
        GUI.enabled = false;
        if (GUILayout.Button("Get Head Bone (unavailable as Avatar is null)"))
        {
        }
        GUI.enabled = true;

      }
      else
      {
        // Show button to get headBone from navMeshFollowerBody
        if (GUILayout.Button("Get Head Bone"))
        {
          navMeshFollowerSetup.headBone = getHeadBone(navMeshFollowerSetup.navMeshFollowerBody);
        }
      }

      // Show field for headBone
      navMeshFollowerSetup.headBone = (Transform)
        EditorGUILayout.ObjectField("Head Bone", navMeshFollowerSetup.headBone, typeof(Transform), true);
    }


    // function to set the left hand value in navMeshFollowerSetup
    private void setLeftHandFromNavMeshFollowerBody(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // check if navMeshFollowerBody has an avatar value
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().avatar == null)
      {
        // disable ui, for the button if avatar is null
        GUI.enabled = false;
        if (GUILayout.Button("Get Left Hand (unavailable as Avatar is null)"))
        {
        }
        GUI.enabled = true;

      }
      else
      {
        // Show button to get leftHand from navMeshFollowerBody
        if (GUILayout.Button("Get Left Hand"))
        {
          navMeshFollowerSetup.leftHand = getLeftHand(navMeshFollowerSetup.navMeshFollowerBody);
        }
      }

      // Show field for leftHand
      navMeshFollowerSetup.leftHand = (Transform)
        EditorGUILayout.ObjectField("Left Hand", navMeshFollowerSetup.leftHand, typeof(Transform), true);
    }

    // function to set the right hand value in navMeshFollowerSetup
    private void setRightHandFromNavMeshFollowerBody(NavMeshFollowerSetup navMeshFollowerSetup)
    {
       // check if navMeshFollowerBody has an avatar value
      if (navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().avatar == null)
      {
        // disable ui, for the button if avatar is null
        GUI.enabled = false;
        if (GUILayout.Button("Get Right Hand (unavailable as Avatar is null)"))
        {
        }
        GUI.enabled = true;

      }
      else
      {
        // Show button to get rightHand from navMeshFollowerBody
        if (GUILayout.Button("Get Right Hand"))
        {
          navMeshFollowerSetup.rightHand = getRightHand(navMeshFollowerSetup.navMeshFollowerBody);
        }
      }

      // Show field for rightHand
      navMeshFollowerSetup.rightHand = (Transform)
        EditorGUILayout.ObjectField("Right Hand", navMeshFollowerSetup.rightHand, typeof(Transform), true);
    }

    // function to get the left hand transform from the navMeshFollowerBody
    private Transform getLeftHand(GameObject navMeshFollowerBody)
    {
      // Output error if navMeshFollowerBody is null
      if (navMeshFollowerBody == null)
      {
        Debug.LogError("Navmesh Follower Body is null");
        return null;
      }
      else
      {
        Debug.Log("Navmesh Follower Body detected");
        // Check if navMeshFollowerBody has an animator component
        Animator animator = navMeshFollowerBody.GetComponent<Animator>();
        if (animator == null)
        {
          Debug.LogError("Navmesh Follower Body does not have Animator component");
          return null;
        }
        else
        {
          Debug.Log("Navmesh Follower Body has Animator component");
          // Get the left hand transform directly from the animator
          Transform leftHand = animator.GetBoneTransform(HumanBodyBones.LeftHand);
          if (leftHand != null)
          {
            Debug.Log("Navmesh Follower Body has Left Hand");
            return leftHand;
          }
          else
          {
            Debug.LogError("Left Hand transform is null");
            return null;
          }
        }
      }
    }

    // function to get the right hand transform from the navMeshFollowerBody
    private Transform getRightHand(GameObject navMeshFollowerBody)
    {
      // Output error if navMeshFollowerBody is null
      if (navMeshFollowerBody == null)
      {
        Debug.LogError("Navmesh Follower Body is null");
        return null;
      }
      else
      {
        Debug.Log("Navmesh Follower Body detected");
        // Check if navMeshFollowerBody has an animator component
        Animator animator = navMeshFollowerBody.GetComponent<Animator>();
        if (animator == null)
        {
          Debug.LogError("Navmesh Follower Body does not have Animator component");
          return null;
        }
        else
        {
          Debug.Log("Navmesh Follower Body has Animator component");
          // Get the right hand transform directly from the animator
          Transform rightHand = animator.GetBoneTransform(HumanBodyBones.RightHand);
          if (rightHand != null)
          {
            Debug.Log("Navmesh Follower Body has Right Hand");
            return rightHand;
          }
          else
          {
            Debug.LogError("Right Hand transform is null");
            return null;
          }
        }
      }
    }

    // function to get the left eye bone transform from the navMeshFollowerBody
    private Transform getLeftEyeBone(GameObject navMeshFollowerBody)
    {
      // Output error if navMeshFollowerBody is null
      if (navMeshFollowerBody == null)
      {
        Debug.LogError("Navmesh Follower Body is null");
        return null;
      }
      else
      {
        Debug.Log("Navmesh Follower Body detected");
        // Check if navMeshFollowerBody has an animator component
        Animator animator = navMeshFollowerBody.GetComponent<Animator>();
        if (animator == null)
        {
          Debug.LogError("Navmesh Follower Body does not have Animator component");
          return null;
        }
        else
        {
          Debug.Log("Navmesh Follower Body has Animator component");
          // Get the left eye bone transform directly from the animator
          Transform leftEyeBone = animator.GetBoneTransform(HumanBodyBones.LeftEye);
          if (leftEyeBone != null)
          {
            Debug.Log("Navmesh Follower Body has Left Eye Bone");
            return leftEyeBone;
          }
          else
          {
            Debug.LogError("Left Eye Bone transform is null");
            return null;
          }
        }
      }
    }

    // function to get the right eye bone transform from the navMeshFollowerBody
    private Transform getRightEyeBone(GameObject navMeshFollowerBody)
    {
      // Output error if navMeshFollowerBody is null
      if (navMeshFollowerBody == null)
      {
        Debug.LogError("Navmesh Follower Body is null");
        return null;
      }
      else
      {
        Debug.Log("Navmesh Follower Body detected");
        // Check if navMeshFollowerBody has an animator component
        Animator animator = navMeshFollowerBody.GetComponent<Animator>();
        if (animator == null)
        {
          Debug.LogError("Navmesh Follower Body does not have Animator component");
          return null;
        }
        else
        {
          Debug.Log("Navmesh Follower Body has Animator component");
          // Get the right eye bone transform directly from the animator
          Transform rightEyeBone = animator.GetBoneTransform(HumanBodyBones.RightEye);
          if (rightEyeBone != null)
          {
            Debug.Log("Navmesh Follower Body has Right Eye Bone");
            return rightEyeBone;
          }
          else
          {
            Debug.LogError("Right Eye Bone transform is null");
            return null;
          }
        }
      }
    }

    // function to set the left and right eye bone values in navMeshFollowerSetup
    private void setEyeBonesFromNavMeshFollowerBody(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // Show button to get leftEyeBone from navMeshFollowerBody
      if (GUILayout.Button("Get Left Eye Bone"))
      {
        navMeshFollowerSetup.leftEyeBone = getLeftEyeBone(navMeshFollowerSetup.navMeshFollowerBody);
      }

      // Show field for leftEyeBone readonly
      navMeshFollowerSetup.leftEyeBone = (Transform)
        EditorGUILayout.ObjectField("Left Eye Bone", navMeshFollowerSetup.leftEyeBone, typeof(Transform), true);

      // Show button to get rightEyeBone from navMeshFollowerBody
      if (GUILayout.Button("Get Right Eye Bone"))
      {
        navMeshFollowerSetup.rightEyeBone = getRightEyeBone(navMeshFollowerSetup.navMeshFollowerBody);
      }

      // Show field for rightEyeBone readonly
      navMeshFollowerSetup.rightEyeBone = (Transform)
        EditorGUILayout.ObjectField("Right Eye Bone", navMeshFollowerSetup.rightEyeBone, typeof(Transform), true);
    }


    private void setExoticEyeBones(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      serializedObject.Update();
      EditorGUILayout.PropertyField(exoticEyes, true);
      serializedObject.ApplyModifiedProperties();
    }


  }
}
