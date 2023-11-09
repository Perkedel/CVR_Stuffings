// Version: 1.0.0
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    //////////////////////////////////////////
    //// Functions to checkup followers
    ////


    private bool levelOneFollowerCheckup(GameObject scriptRootObject)
    {
      //show error message if hasNavMeshAgentCore is false
      if (!hasNavMeshAgentCore(scriptRootObject))
      {
        EditorGUILayout.HelpBox("Navmesh Follower Config Object not found.", MessageType.Warning);
        return false;
      }
      else
      {
        return true;
      }
    }

    private bool levelTwoFollowerCheckup(GameObject scriptRootObject)
    {
      //show error message if hasNavMeshFollowerConfigObjectsCore is false
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        EditorGUILayout.HelpBox("Navmesh Follower Config Object not found.", MessageType.Warning);
        return false;
      }
      else
      {
        bool navMeshFollowerConfigObjectsCoreError = false;
        //check each of the required objects exist, if not show error message
        if (hasLookAtTargetSmooth(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Smooth] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasLookAtTargetRaw(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasLookAtTargetRawOffset(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Raw] -> Offset sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasNavMeshAgentRawLevelTwo(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("NavMeshAgent [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }

        if (navMeshFollowerConfigObjectsCoreError)
        {
          // button to remove the [NavMeshFollower] object
          if (GUILayout.Button("Remove Corrupt NavMeshFollower Config Objects"))
          {
            // Get the [NavMeshFollower] object
            GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

            if (navMeshFollowerConfigObject != null)
            {
              // Destroy the [NavMeshFollower] object
              DestroyImmediate(navMeshFollowerConfigObject);
              Debug.Log("Removed NavMeshFollower Config Objects");
            }
          }
          return false;
        }
        else
        {
          return true;
        }
      }
    }

    private bool levelThreeFollowerCheckup(GameObject scriptRootObject)
    {
      //show error message if hasNavMeshFollowerConfigObjectsCore is false
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        EditorGUILayout.HelpBox("Navmesh Follower Config Object pack not found.", MessageType.Warning);
        return false;
      }
      else
      {
        bool navMeshFollowerConfigObjectsCoreError = false;
        //check each of the required objects exist, if not show error message
        if (hasLookAtTargetSmooth(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Smooth] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasLookAtTargetRaw(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasLookAtTargetRawOffset(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LookAtTarget [Raw] -> Offset sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasNavMeshAgentRawLevelThree(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("NavMeshAgent [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIK(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKTargets(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Targets sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKScripts(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Scripts sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKTargetsLeftArmRaw(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Targets -> LeftArm [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKTargetsRightArmRaw(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Targets -> RightArm [Raw] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKTargetsLeftArmSmooth(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Targets -> LeftArm [Smooth] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKTargetsRightArmSmooth(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Targets -> RightArm [Smooth] sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKScriptsBothHands(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Scripts -> BothHands sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKScriptsLeftHand(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Scripts -> LeftHand sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasVRIKScriptsRightHand(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("VRIK -> Scripts -> RightHand sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasLeftHandAttachmentPoint(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("LeftHandAttachmentPoint sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }
        if (hasRightHandAttachmentPoint(scriptRootObject) == false)
        {
          EditorGUILayout.HelpBox("RightHandAttachmentPoint sub component not found.", MessageType.Error);
          navMeshFollowerConfigObjectsCoreError = true;
        }

        if (navMeshFollowerConfigObjectsCoreError)
        {
          // button to remove the [NavMeshFollower] object
          if (GUILayout.Button("Remove Corrupt NavMeshFollower Config Objects"))
          {
            // Get the [NavMeshFollower] object
            GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

            if (navMeshFollowerConfigObject != null)
            {
              // Destroy the [NavMeshFollower] object
              DestroyImmediate(navMeshFollowerConfigObject);
              Debug.Log("Removed NavMeshFollower Config Objects");
            }
          }
          return false;
        }
        else
        {
          return true;
        }
      }
    }

  }
}
