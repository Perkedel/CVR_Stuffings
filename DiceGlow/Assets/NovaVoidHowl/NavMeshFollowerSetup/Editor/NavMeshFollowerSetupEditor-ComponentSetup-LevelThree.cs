// Version: 1.1.45
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

using RootMotion.FinalIK;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    private void setupLevelThreeFollower(
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
      updateLookAtTargetPosition(navMeshFollowerSetup, scriptRootObject, navMeshFollowerBody);
      setupNMFAnimator(navMeshFollowerSetup, navMeshFollowerBody, 3);
      setupSpawnableValuesCore(navMeshFollowerSetup, scriptRootObject);
      setupSpawnableIKValues(navMeshFollowerSetup, scriptRootObject);
      setupNMFSpawnableSubSync(navMeshFollowerSetup, scriptRootObject);
      setupHandsIK(navMeshFollowerSetup, navMeshFollowerBody);
      setupVRIKScripts(navMeshFollowerSetup, navMeshFollowerBody);
      setupVRIKTargets(navMeshFollowerSetup, navMeshFollowerBody);
      updateFollowerInfoLevelThree(scriptRootObject, navMeshFollowerSetup);

    }
    private void updateFollowerInfoLevelThree(GameObject scriptRootObject, NavMeshFollowerSetup navMeshFollowerSetup)
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

      // check if NavMeshAgent gameObject exists
      if (scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].agent_path)?.gameObject == null)
      {
        //should never be possible to reach this point, but just in case
        Debug.Log("CRITICAL ERROR: NavMeshAgent gameObject not found");
      }
      else
      {
        // Get the NavMeshAgent object
        navMeshAgent = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].agent_path)?.gameObject;
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
      GameObject lookAtTargetRaw = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path)?.gameObject;

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
      navMeshFollowerInfoComponent.humanoidAnimator = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();

      // check if navMeshFollowerSetup.rightHand is not null and rightHandIKenabled is true
      if (navMeshFollowerSetup.rightHand != null && navMeshFollowerSetup.rightHandIKenabled == true)
      {
        // set the navMeshFollowerInfoComponent.hasRightArmIK to true
        navMeshFollowerInfoComponent.hasRightArmIK = true;

        // set the navMeshFollowerInfoComponent.vrikRightArmTargetTransform to navMeshFollowerSetup.rightHand
        navMeshFollowerInfoComponent.vrikRightArmTargetTransform = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_right_arm_raw_path);

        // set the navMeshFollowerInfoComponent.rightHandAttachmentPoint to the right hand attachment point gameObject
        navMeshFollowerInfoComponent.rightHandAttachmentPoint = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].right_hand_attach_point_path);
      }

      // check if navMeshFollowerSetup.leftHand is not null and leftHandIKenabled is true
      if (navMeshFollowerSetup.leftHand != null && navMeshFollowerSetup.leftHandIKenabled == true)
      {
        // set the navMeshFollowerInfoComponent.hasLeftArmIK to true
        navMeshFollowerInfoComponent.hasLeftArmIK = true;

        // set the navMeshFollowerInfoComponent.vrikLeftArmTargetTransform to navMeshFollowerSetup.leftHand
        navMeshFollowerInfoComponent.vrikLeftArmTargetTransform = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_left_arm_raw_path);

        // set the navMeshFollowerInfoComponent.leftHandAttachmentPoint to the left hand attachment point gameObject
        navMeshFollowerInfoComponent.leftHandAttachmentPoint = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].left_hand_attach_point_path);
      }
    }


    private void setupHandsIK(NavMeshFollowerSetup navMeshFollowerSetup, GameObject navMeshFollowerBody)
    {
      // get the left hand gameObject from the navMeshFollowerSetup.navMeshFollowerBody animator
      GameObject leftHand = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.LeftHand)?.gameObject;

      // get the right hand gameObject from the navMeshFollowerSetup.navMeshFollowerBody animator
      GameObject rightHand = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.RightHand)?.gameObject;

      // get the left hand attachment point gameObject
      GameObject leftHandAttachmentPoint = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].left_hand_attach_point_path)?.gameObject;

      // get the right hand attachment point gameObject
      GameObject rightHandAttachmentPoint = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].right_hand_attach_point_path)?.gameObject;

      //get the parent constraint component on the left hand attachment point gameObject
      ParentConstraint leftHandAttachmentPointParentConstraint = leftHandAttachmentPoint.GetComponent<ParentConstraint>();

      //get the parent constraint component on the right hand attachment point gameObject
      ParentConstraint rightHandAttachmentPointParentConstraint = rightHandAttachmentPoint.GetComponent<ParentConstraint>();

      // deactivate the parent constraints
      leftHandAttachmentPointParentConstraint.constraintActive = false;
      rightHandAttachmentPointParentConstraint.constraintActive = false;

      // Remove all sources from the constraints
      while (leftHandAttachmentPointParentConstraint.sourceCount > 0)
      {
          leftHandAttachmentPointParentConstraint.RemoveSource(0);
      }
      while (rightHandAttachmentPointParentConstraint.sourceCount > 0)
      {
          rightHandAttachmentPointParentConstraint.RemoveSource(0);
      }

      // left hand section
      // get the current offset of the left hand attachment point parent constraint
      //Vector3 leftHandTranslationOffset = leftHandAttachmentPointParentConstraint.transform.position - leftHand.transform.position;

      // create a new source for the left hand attachment point parent constraint
      ConstraintSource leftHandSource = new ConstraintSource { sourceTransform = leftHand.transform, weight = 1 };
      leftHandAttachmentPointParentConstraint.AddSource(leftHandSource);

      // set the translation offsets for the left hand attachment point parent constraint
      //leftHandAttachmentPointParentConstraint.SetTranslationOffset(0, leftHandTranslationOffset);

      // right hand section
      // get the current offset of the right hand attachment point parent constraint
     // Vector3 rightHandTranslationOffset = rightHandAttachmentPointParentConstraint.transform.position - rightHand.transform.position;

      // create a new source for the right hand attachment point parent constraint
      ConstraintSource rightHandSource = new ConstraintSource { sourceTransform = rightHand.transform, weight = 1 };
      rightHandAttachmentPointParentConstraint.AddSource(rightHandSource);

      // set the translation offsets for the right hand attachment point parent constraint
      //rightHandAttachmentPointParentConstraint.SetTranslationOffset(0, rightHandTranslationOffset);


      // Use reflection to get the ActivateAndPreserveOffset method on RightHandAttachmentPointParentConstraint
      var methodInfoRH = typeof(ParentConstraint).GetMethod("ActivateAndPreserveOffset", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);

      if (methodInfoRH != null)
      {
          methodInfoRH.Invoke(rightHandAttachmentPointParentConstraint, null);
          DebugConsoleLog("RH Parent Constraint activated!");
      }
      else
      {
          Debug.LogError("Right Hand Failed to find the ActivateAndPreserveOffset method on ParentConstraint");
      }

      // Use reflection to get the ActivateAndPreserveOffset method on LeftHandAttachmentPointParentConstraint
      var methodInfoLH = typeof(ParentConstraint).GetMethod("ActivateAndPreserveOffset", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);

      if (methodInfoLH != null)
      {
          methodInfoLH.Invoke(leftHandAttachmentPointParentConstraint, null);
          DebugConsoleLog("LH Parent Constraint activated!");
      }
      else
      {
          Debug.LogError("Left Hand Failed to find the ActivateAndPreserveOffset method on ParentConstraint");
      }

    }

    private void setupVRIKScripts(NavMeshFollowerSetup navMeshFollowerSetup, GameObject navMeshFollowerBody)
    {
      // get the VRIK holder gameObject
      GameObject VRIKHolder = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_script_path)?.gameObject;

      // get the animator.avatar from the navMeshFollowerBody animator
      Animator animator = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();

      //navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.LeftHand)?.gameObject;

      // get a list of the gameobjects under the VRIK holder gameObject
      List<GameObject> VRIKHolderChildren = new List<GameObject>();
      foreach (Transform child in VRIKHolder.transform)
      {
        VRIKHolderChildren.Add(child.gameObject);
      }

      // for each in the above list, check if the gameObject has a VRIK component

      foreach (GameObject VRIKHolderChild in VRIKHolderChildren)
      {
        if (VRIKHolderChild.GetComponent<VRIK>() != null)
        {
          // if component found disable the component
          VRIKHolderChild.GetComponent<VRIK>().enabled = false;

          // set the VRIK component references to the avatar bones from the navMeshFollowerBody animator avatar
          VRIKHolderChild.GetComponent<VRIK>().references.root = navMeshFollowerBody.transform;
          VRIKHolderChild.GetComponent<VRIK>().references.pelvis = animator.GetBoneTransform(HumanBodyBones.Hips);
          VRIKHolderChild.GetComponent<VRIK>().references.spine = animator.GetBoneTransform(HumanBodyBones.Spine);
          VRIKHolderChild.GetComponent<VRIK>().references.chest = animator.GetBoneTransform(HumanBodyBones.Chest);
          VRIKHolderChild.GetComponent<VRIK>().references.neck = animator.GetBoneTransform(HumanBodyBones.Neck);
          VRIKHolderChild.GetComponent<VRIK>().references.head = animator.GetBoneTransform(HumanBodyBones.Head);
          VRIKHolderChild.GetComponent<VRIK>().references.leftShoulder = animator.GetBoneTransform(HumanBodyBones.LeftShoulder);
          VRIKHolderChild.GetComponent<VRIK>().references.leftUpperArm = animator.GetBoneTransform(HumanBodyBones.LeftUpperArm);
          VRIKHolderChild.GetComponent<VRIK>().references.leftForearm = animator.GetBoneTransform(HumanBodyBones.LeftLowerArm);
          VRIKHolderChild.GetComponent<VRIK>().references.leftHand = animator.GetBoneTransform(HumanBodyBones.LeftHand);
          VRIKHolderChild.GetComponent<VRIK>().references.rightShoulder = animator.GetBoneTransform(HumanBodyBones.RightShoulder);
          VRIKHolderChild.GetComponent<VRIK>().references.rightUpperArm = animator.GetBoneTransform(HumanBodyBones.RightUpperArm);
          VRIKHolderChild.GetComponent<VRIK>().references.rightForearm = animator.GetBoneTransform(HumanBodyBones.RightLowerArm);
          VRIKHolderChild.GetComponent<VRIK>().references.rightHand = animator.GetBoneTransform(HumanBodyBones.RightHand);
          VRIKHolderChild.GetComponent<VRIK>().references.leftThigh = animator.GetBoneTransform(HumanBodyBones.LeftUpperLeg);
          VRIKHolderChild.GetComponent<VRIK>().references.leftCalf = animator.GetBoneTransform(HumanBodyBones.LeftLowerLeg);
          VRIKHolderChild.GetComponent<VRIK>().references.leftFoot = animator.GetBoneTransform(HumanBodyBones.LeftFoot);
          VRIKHolderChild.GetComponent<VRIK>().references.leftToes = animator.GetBoneTransform(HumanBodyBones.LeftToes);
          VRIKHolderChild.GetComponent<VRIK>().references.rightThigh = animator.GetBoneTransform(HumanBodyBones.RightUpperLeg);
          VRIKHolderChild.GetComponent<VRIK>().references.rightCalf = animator.GetBoneTransform(HumanBodyBones.RightLowerLeg);
          VRIKHolderChild.GetComponent<VRIK>().references.rightFoot = animator.GetBoneTransform(HumanBodyBones.RightFoot);
          VRIKHolderChild.GetComponent<VRIK>().references.rightToes = animator.GetBoneTransform(HumanBodyBones.RightToes);


        }
      }
    }

    private void setupVRIKTargets(NavMeshFollowerSetup navMeshFollowerSetup, GameObject navMeshFollowerBody)
    {
      // get navMeshFollowerSetup.leftHand
      GameObject leftHand = navMeshFollowerSetup.leftHand.gameObject;

      // get navMeshFollowerSetup.rightHand
      GameObject rightHand = navMeshFollowerSetup.rightHand.gameObject;


      // section for left hand
      // check if navMeshFollowerSetup.leftHand is not null and leftHandIKenabled is true
      if (navMeshFollowerSetup.leftHand != null && navMeshFollowerSetup.leftHandIKenabled == true)
      {
        // get the LeftArm[Raw] gameObject
        GameObject leftArmRaw = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_left_arm_raw_path)?.gameObject;

        // get the ParentConstraint component on the leftArmRaw gameObject
        ParentConstraint leftArmRawParentConstraint = leftArmRaw.GetComponent<ParentConstraint>();

        // check if the leftArmRawParentConstraint is null
        if (leftArmRawParentConstraint != null)
        {
          // constraint exists so remove it
          // remove parent constraint component
          DestroyImmediate(leftArmRawParentConstraint);
        }

        // add parent constraint component
        leftArmRaw.AddComponent<ParentConstraint>();

        // get the ParentConstraint component on the leftArmRaw gameObject (as we just recreated it)
        leftArmRawParentConstraint = leftArmRaw.GetComponent<ParentConstraint>();

        // ensure the constraint is deactivated
        leftArmRawParentConstraint.constraintActive = false;

        // set the leftArmRaw parent constraint source to the left hand gameObject
        leftArmRawParentConstraint.AddSource(new ConstraintSource { sourceTransform = leftHand.transform, weight = 1 });

        // set the position of the leftArmRaw to the position of the left hand
        leftArmRaw.transform.position = leftHand.transform.position;
        leftArmRaw.transform.rotation = leftHand.transform.rotation;

        // active the leftArmRaw parent constraint
        leftArmRawParentConstraint.constraintActive = true;
      }


      // section for right hand
      // check if navMeshFollowerSetup.rightHand is not null and rightHandIKenabled is true
      if (navMeshFollowerSetup.rightHand != null && navMeshFollowerSetup.rightHandIKenabled == true)
      {
        // get the RightArm[Raw] gameObject
        GameObject rightArmRaw = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].ik_right_arm_raw_path)?.gameObject;

        // get the ParentConstraint component on the rightArmRaw gameObject
        ParentConstraint rightArmRawParentConstraint = rightArmRaw.GetComponent<ParentConstraint>();

        // check if the rightArmRawParentConstraint is null
        if (rightArmRawParentConstraint != null)
        {
          // constraint exists so remove it
          // remove parent constraint component
          DestroyImmediate(rightArmRawParentConstraint);
        }

        // add parent constraint component
        rightArmRaw.AddComponent<ParentConstraint>();

        // get the ParentConstraint component on the rightArmRaw gameObject (as we just recreated it)
        rightArmRawParentConstraint = rightArmRaw.GetComponent<ParentConstraint>();

        // ensure the constraint is deactivated
        rightArmRawParentConstraint.constraintActive = false;

        // set the rightArmRaw parent constraint source to the right hand gameObject
        rightArmRawParentConstraint.AddSource(new ConstraintSource { sourceTransform = rightHand.transform, weight = 1 });

        // set the position of the rightArmRaw to the position of the right hand
        rightArmRaw.transform.position = rightHand.transform.position;
        rightArmRaw.transform.rotation = rightHand.transform.rotation;

        // active the rightArmRaw parent constraint
        rightArmRawParentConstraint.constraintActive = true;
      }




    }

    private void snapLeftHandAttachmentPointToHand(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // get the left hand attachment point gameObject
      GameObject leftHandAttachmentPoint = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].left_hand_attach_point_path)?.gameObject;

      // get the left hand gameObject from the navMeshFollowerSetup.navMeshFollowerBody animator
      GameObject leftHand = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.LeftHand)?.gameObject;

      //get the parent constraint component on the left hand attachment point gameObject
      ParentConstraint leftHandAttachmentPointParentConstraint = leftHandAttachmentPoint.GetComponent<ParentConstraint>();

      // Remove all sources from the constraint
      while (leftHandAttachmentPointParentConstraint.sourceCount > 0)
      {
          leftHandAttachmentPointParentConstraint.RemoveSource(0);
      }

      // deactivate the parent constraint
      leftHandAttachmentPointParentConstraint.constraintActive = false;

      // set the left hand attachment point parent constraint source to the left hand gameObject
      leftHandAttachmentPointParentConstraint.AddSource(new ConstraintSource { sourceTransform = leftHand.transform, weight = 1 });

      // set the position of the left hand attachment point to the position of the left hand
      leftHandAttachmentPoint.transform.position = leftHand.transform.position;

      // set the rotation of the left hand attachment point to the rotation of the left hand
      leftHandAttachmentPoint.transform.rotation = leftHand.transform.rotation;

      // subtract 90 degrees to the x rotation of the left hand attachment point
      leftHandAttachmentPoint.transform.Rotate(-90, 0, 0);

      // add 90 degrees to the z rotation of the left hand attachment point
      leftHandAttachmentPoint.transform.Rotate(0, 0, 90);

    }

    private void snapRightHandAttachmentPointToHand(NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // get the right hand attachment point gameObject
      GameObject rightHandAttachmentPoint = navMeshFollowerSetup.gameObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].right_hand_attach_point_path)?.gameObject;

      // get the right hand gameObject from the navMeshFollowerSetup.navMeshFollowerBody animator
      GameObject rightHand = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>().GetBoneTransform(HumanBodyBones.RightHand)?.gameObject;

      //get the parent constraint component on the right hand attachment point gameObject
      ParentConstraint rightHandAttachmentPointParentConstraint = rightHandAttachmentPoint.GetComponent<ParentConstraint>();

      // Remove all sources from the constraint
      while (rightHandAttachmentPointParentConstraint.sourceCount > 0)
      {
          rightHandAttachmentPointParentConstraint.RemoveSource(0);
      }

      // deactivate the parent constraint
      rightHandAttachmentPointParentConstraint.constraintActive = false;

      // set the right hand attachment point parent constraint source to the right hand gameObject
      rightHandAttachmentPointParentConstraint.AddSource(new ConstraintSource { sourceTransform = rightHand.transform, weight = 1 });

      // set the position of the right hand attachment point to the position of the right hand
      rightHandAttachmentPoint.transform.position = rightHand.transform.position;

      // set the rotation of the right hand attachment point to the rotation of the right hand
      rightHandAttachmentPoint.transform.rotation = rightHand.transform.rotation;

      // subtract 90 degrees to the x rotation of the left hand attachment point
      rightHandAttachmentPoint.transform.Rotate(-90, 0, 0);

      // subtract 90 degrees to the z rotation of the left hand attachment point
      rightHandAttachmentPoint.transform.Rotate(0, 0, -90);

    }


  }
}
