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

using RootMotion.FinalIK;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {


    private void addNMFLookAtIK(NavMeshFollowerSetup navMeshFollowerSetup, GameObject scriptRootObject, GameObject navMeshFollowerBody )
    {
      LookAtIK lookAtIKComponent = null;
      // get the 'LookAtTarget [Raw]' gameObject under the navMeshFollowerConfigObject
      Transform lookAtTargetRaw = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path)?.gameObject.transform;
      // check if lookAtTargetRaw has is null
      if (lookAtTargetRaw == null)
      {
        // show error message popup
        EditorUtility.DisplayDialog("Error", NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path + " not found", "OK");
      }
      else
      {
        //print the fact that we found the lookAtTargetRaw to the console
        DebugConsoleLog("Found " + NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].look_at_path);
      }

      // check if navMeshFollowerBody has a LookAtIK component
      if (navMeshFollowerBody.GetComponent<LookAtIK>() == null)
      {
        // add LookAtIK component to navMeshFollowerBody
        lookAtIKComponent = navMeshFollowerBody.AddComponent<LookAtIK>();
      }

      // Get the LookAtIK component on the navMeshFollowerBody
      lookAtIKComponent = navMeshFollowerBody.GetComponent<LookAtIK>();

      // set the LookAtIK component properties
      lookAtIKComponent.solver.target = lookAtTargetRaw;
      lookAtIKComponent.solver.headWeight = 1;
      lookAtIKComponent.solver.eyesWeight = 1;
      lookAtIKComponent.solver.bodyWeight = 0.5f;
      lookAtIKComponent.solver.clampWeight = 0.5f;
      lookAtIKComponent.solver.clampWeightHead = 0.75f;
      lookAtIKComponent.solver.clampWeightEyes = 0.5f;
      lookAtIKComponent.solver.clampSmoothing = 2;
      lookAtIKComponent.solver.head.transform = navMeshFollowerSetup.headBone;

      if(navMeshFollowerSetup.eyeIKenabled == true)
      {
        //wipe the eyes array, to prevent errors from exiting transforms/blanks
        lookAtIKComponent.solver.eyes = null;
        int exoticEyesCount = 0;

        if(navMeshFollowerSetup.eyeExoticMode)
        {
          // get count of eye bones in exoticEyes array
          exoticEyesCount = navMeshFollowerSetup.exoticEyes.Length;
        }
        else
        {
          // zero out exoticEyesCount
          exoticEyesCount = 0;
        }

        // add left and right eye bones to a RootMotion.FinalIK.IKSolverLookAt.LookAtBone[] array and set the LookAtIK component solver eyes to that array
        RootMotion.FinalIK.IKSolverLookAt.LookAtBone[] eyes = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone[2 + exoticEyesCount];

        // eyebones can't be null, as it would have been trapped by the setup checks carried out before this function was called
        // however still check for null just in case

        if (navMeshFollowerSetup.leftEyeBone != null)
        {
            RootMotion.FinalIK.IKSolverLookAt.LookAtBone leftLookAtBone = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone();
            leftLookAtBone.transform = navMeshFollowerSetup.leftEyeBone;
            eyes[0] = leftLookAtBone;
        }
        else
        {
            Debug.Log("leftEyeBone is null");
        }

        if (navMeshFollowerSetup.rightEyeBone != null)
        {
            RootMotion.FinalIK.IKSolverLookAt.LookAtBone rightLookAtBone = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone();
            rightLookAtBone.transform = navMeshFollowerSetup.rightEyeBone;
            eyes[1] = rightLookAtBone;
        }
        else
        {
            Debug.Log("rightEyeBone is null");
        }

        // check if exoticEyesCount is greater than 0 and if exoticEyesMode is enabled
        if(navMeshFollowerSetup.eyeExoticMode && exoticEyesCount > 0)
        {
          // loop through exoticEyes array and add each bone to the eyes array
          for (int i = 0; i < exoticEyesCount; i++)
          {
            RootMotion.FinalIK.IKSolverLookAt.LookAtBone exoticLookAtBone = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone();
            exoticLookAtBone.transform = navMeshFollowerSetup.exoticEyes[i];
            eyes[i + 2] = exoticLookAtBone;
          }
        }


        // Assign the array to the LookAtIK component
        lookAtIKComponent.solver.eyes = eyes;
      }
      else
      {
        lookAtIKComponent.solver.eyes = null;
      }

      // spine setup section

      // get count of spine bones in spineBones array
      int spineBonesCount = navMeshFollowerSetup.spineBones.Length;

      RootMotion.FinalIK.IKSolverLookAt.LookAtBone[] spine = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone[spineBonesCount];
      // if spineIKenabled is true, set the spineBones array to the LookAtIK component solver spine
      if (navMeshFollowerSetup.spineIKenabled == true && spineBonesCount > 0 )
      {
        for (int i = 0; i < spineBonesCount; i++)
        {
          RootMotion.FinalIK.IKSolverLookAt.LookAtBone spineBone = new RootMotion.FinalIK.IKSolverLookAt.LookAtBone();
          spineBone.transform = navMeshFollowerSetup.spineBones[i];
          spine[i] = spineBone;
        }

        lookAtIKComponent.solver.spine = spine;
      }
      else
      {
        lookAtIKComponent.solver.spine = null;
      }



      // print the fact that we added the LookAtIK component to the navMeshFollowerBody to the console
      Debug.Log("Added LookAtIK component to navMeshFollowerBody");


    }




  }
}
