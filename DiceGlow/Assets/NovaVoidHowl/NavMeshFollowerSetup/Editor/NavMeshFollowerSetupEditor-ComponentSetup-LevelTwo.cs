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

// Dynamic loads
#if CVR_CCK_EXISTS
using ABI.CCK.Components;
#endif

#if KAFE_CVR_CCK_NAV_MESH_FOLLOWER_EXISTS
using Kafe.NavMeshFollower.CCK;
#endif

//using RootMotion.FinalIK;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {
  // level 2 functions------------------------------------------------------------------------------------------------------------------------------
    private void setupLevelTwoFollower(
      NavMeshFollowerSetup navMeshFollowerSetup,
      GameObject navMeshFollowerBody,
      GameObject scriptRootObject
    )
    {
      alignFollowerBody(navMeshFollowerBody);
      addFollowerBodyParentConstraint(navMeshFollowerBody, scriptRootObject);
      updateNMFNavMeshAgent(navMeshFollowerSetup, scriptRootObject);
      addSpawnable(scriptRootObject, navMeshFollowerSetup);
      addNMFLookAtIK(navMeshFollowerSetup, scriptRootObject, navMeshFollowerBody);
      updateFollowerInfoLevelTwo(scriptRootObject, navMeshFollowerSetup);
      updateLookAtTargetPosition(navMeshFollowerSetup, scriptRootObject, navMeshFollowerBody);
      setupNMFAnimator(navMeshFollowerSetup, navMeshFollowerBody, 2);
      setupSpawnableValuesCore(navMeshFollowerSetup, scriptRootObject);
      setupSpawnableIKValues(navMeshFollowerSetup, scriptRootObject);
      setupNMFSpawnableSubSync(navMeshFollowerSetup, scriptRootObject);
    }

    private void updateFollowerInfoLevelTwo(GameObject scriptRootObject, NavMeshFollowerSetup navMeshFollowerSetup)
    {
      GameObject navMeshFollowerConfigObject = null;
      GameObject navMeshAgent = null;

      // check if FollowerInfo component exists
      FollowerInfo followerInfoComponent = scriptRootObject.GetComponent<FollowerInfo>();
      if (followerInfoComponent == null)
      {
        // Add FollowerInfo component to scriptRootObject
        followerInfoComponent = scriptRootObject.AddComponent<FollowerInfo>();
      }


      // Check if the [NavMashFollower] gameObject exists under the scriptRootObject
      if (scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject == null)
      {
        // should never be possible to reach this point, but just in case
        Debug.Log("CRITICAL ERROR: [NavMeshFollower] gameObject not found");
        return;
      }
      else
      {
        // Get the [NavMashFollower] object under the scriptRootObject
        navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;
      }

      // check if NavMeshAgent gameObject exists under the navMeshFollowerConfigObject gameObject we just got
      if (navMeshFollowerConfigObject.transform.Find("NavMeshAgent")?.gameObject == null)
      {
        //should never be possible to reach this point, but just in case
        Debug.Log("CRITICAL ERROR: NavMeshAgent gameObject not found");
      }
      else
      {
        // Get the NavMeshAgent object under the navMeshFollowerConfigObject
        navMeshAgent = navMeshFollowerConfigObject.transform.Find("NavMeshAgent")?.gameObject;
      }

      // check if navMeshAgent gameObject has a NavMeshAgent component
      if (navMeshAgent.GetComponent<UnityEngine.AI.NavMeshAgent>() == null)
      {
        // add NavMeshAgent component to navMeshAgent
        navMeshAgent.AddComponent<UnityEngine.AI.NavMeshAgent>();
      }

      // Get the NavMeshAgent component on the navMeshAgent object
      UnityEngine.AI.NavMeshAgent agent = navMeshAgent.GetComponent<UnityEngine.AI.NavMeshAgent>();

      // Get the NavMeshFollowerInfo component
      FollowerInfo navMeshFollowerInfoComponent = scriptRootObject.GetComponent<FollowerInfo>();

      // get the 'LookAtTarget [Raw]' gameObject under the navMeshFollowerConfigObject
      GameObject lookAtTargetRaw = navMeshFollowerConfigObject.transform.Find("LookAtTarget [Raw]")?.gameObject;

      // Update the NavMeshFollowerInfo component
      navMeshFollowerInfoComponent.spawnable =
        scriptRootObject.GetComponent<CVRSpawnable>();
      navMeshFollowerInfoComponent.navMeshAgent = agent;
      navMeshFollowerInfoComponent.hasLookAt = true;
      navMeshFollowerInfoComponent.lookAtTargetTransform = lookAtTargetRaw.transform;
      navMeshFollowerInfoComponent.headTransform = navMeshFollowerSetup.headBone;
      navMeshFollowerInfoComponent.hasVRIK = false;
      navMeshFollowerInfoComponent.hasLeftArmIK = false;
      navMeshFollowerInfoComponent.vrikLeftArmTargetTransform = null;
      navMeshFollowerInfoComponent.leftHandAttachmentPoint = null;
      navMeshFollowerInfoComponent.hasRightArmIK = false;
      navMeshFollowerInfoComponent.vrikRightArmTargetTransform = null;
      navMeshFollowerInfoComponent.rightHandAttachmentPoint = null;
    }

  }
}
