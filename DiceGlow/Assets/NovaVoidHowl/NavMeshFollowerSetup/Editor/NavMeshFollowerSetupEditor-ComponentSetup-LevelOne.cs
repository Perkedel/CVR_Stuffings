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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    // level 1 functions------------------------------------------------------------------------------------------------------------------------------

    // Function to setup level 1 follower
    private void setupLevelOneFollower(
      NavMeshFollowerSetup navMeshFollowerSetup,
      GameObject navMeshFollowerBody,
      GameObject scriptRootObject
    )
    {
      alignFollowerBody(navMeshFollowerBody);
      addFollowerBodyParentConstraint(navMeshFollowerBody, scriptRootObject);
      updateNMFNavMeshAgent(navMeshFollowerSetup, scriptRootObject);
      addSpawnable(scriptRootObject, navMeshFollowerSetup);
      updateFollowerInfoLevelOne(scriptRootObject, navMeshFollowerSetup);
      setupNMFAnimator(navMeshFollowerSetup, navMeshFollowerBody, 1);
      setupSpawnableValuesCore(navMeshFollowerSetup, scriptRootObject);
      setupSpawnableIKValues(navMeshFollowerSetup, scriptRootObject);
      setupNMFSpawnableSubSync(navMeshFollowerSetup, scriptRootObject);
    }


    private void updateFollowerInfoLevelOne(GameObject scriptRootObject, NavMeshFollowerSetup navMeshFollowerSetup)
    {

      // check if FollowerInfo component exists
      FollowerInfo followerInfoComponent = scriptRootObject.GetComponent<FollowerInfo>();
      if (followerInfoComponent == null)
      {
        // Add FollowerInfo component to scriptRootObject
        followerInfoComponent = scriptRootObject.AddComponent<FollowerInfo>();
      }

      // Check if the NavMeshAgent object exists under the scriptRootObject
      if (scriptRootObject.transform.Find(NMFSConfig.follower_level_data[1].agent_path)?.gameObject == null)
      {
        // Add the NavMeshAgent object under the scriptRootObject
        GameObject navMeshAgent = new GameObject(NMFSConfig.follower_level_data[1].agent_path);
        navMeshAgent.transform.parent = scriptRootObject.transform;
        navMeshAgent.transform.localPosition = Vector3.zero;
        navMeshAgent.transform.localRotation = Quaternion.identity;
        navMeshAgent.AddComponent<UnityEngine.AI.NavMeshAgent>();
      }

      // Get the NavMeshAgent object under the scriptRootObject
      GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[1].agent_path)?.gameObject;

      // Get the NavMeshFollowerInfo component

      FollowerInfo navMeshFollowerInfoComponent = scriptRootObject.GetComponent<FollowerInfo>();

      // Update the NavMeshFollowerInfo component

      navMeshFollowerInfoComponent.spawnable =
        scriptRootObject.GetComponent<CVRSpawnable>();
      navMeshFollowerInfoComponent.navMeshAgent =
        navMeshFollowerConfigObject.GetComponent<UnityEngine.AI.NavMeshAgent>();
      navMeshFollowerInfoComponent.hasLookAt = false;
      navMeshFollowerInfoComponent.lookAtTargetTransform = null;
      navMeshFollowerInfoComponent.headTransform = null;
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
