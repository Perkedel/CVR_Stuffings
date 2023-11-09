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

#if NVH_COMMON_EXISTS
  using NVHCommonUI = uk.novavoidhowl.dev.common.ui;
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// Common UI variables for this package

    private Color foldoutTitleBackgroundColor = new Color(0.18f, 0.18f, 0.18f, 1.0f);
    private Color foldoutVersionBackgroundColor = new Color(0.0f, 0.0f, 0.0f, 0.0f);
    private GUIStyle setupFollowerButtonStyle;
    private float setupFollowerButtonHeight = 30.0f;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Common Render UI functions for this package
    // this lot depends on NVHCommonUI
    #if NVH_COMMON_EXISTS
    private void RenderAnimatorControl (NavMeshFollowerSetup navMeshFollowerSetup)
    {
      // path to the animator controller file
      string animatorControllerPath = "Assets/NMF/GeneratedAnimators/" + navMeshFollowerSetup.navMeshFollowerBody.name + "/" + navMeshFollowerSetup.navMeshFollowerBody.name + "_Level_" + navMeshFollowerSetup.followerLevel + "_Animator.controller";


      NVHCommonUI.CoreUI.RenderFoldoutSection(
              "Animator Controller",
              ref navMeshFollowerSetup.animatorSectionShow,
              () =>{
                // get the name of the navMeshFollowerBody game object
                string navMeshFollowerBodyName = navMeshFollowerSetup.navMeshFollowerBody.name;

                // check if the animator controller file exists at Assets\NMF\GeneratedAnimators\{navMeshFollowerBodyName}\{navMeshFollowerBodyName}_Level_{followerLevel}_Animator.controller
                if (AssetDatabase.LoadAssetAtPath(animatorControllerPath, typeof(RuntimeAnimatorController)) == null)
                {
                  // bold label to say that no animator controller file exists for this navMeshFollowerBody at the current level
                  GUILayout.Label("No Animator Controller exists for " + navMeshFollowerBodyName + " at level " + navMeshFollowerSetup.followerLevel + ".", EditorStyles.boldLabel);
                  GUILayout.Space(5);
                  // show disabled delete button, as there is no animator controller to delete
                  GUI.enabled = false;
                  if (GUILayout.Button("Delete Animator Controller"))
                  {
                  }
                  GUI.enabled = true;
                }
                else
                {
                  // bold label to say that no animator controller file exists for this navMeshFollowerBody at the current level
                  GUILayout.Label("Animator Controller details for " + navMeshFollowerBodyName + " at level " + navMeshFollowerSetup.followerLevel + ".", EditorStyles.boldLabel);
                  GUILayout.Space(5);
                  // show path to animator controller file
                  GUILayout.Label("Path: " + animatorControllerPath);
                  // button to open animator controller file
                  if (GUILayout.Button("Open Animator Controller"))
                  {
                    // open the animator controller file
                    AssetDatabase.OpenAsset(AssetDatabase.LoadAssetAtPath(animatorControllerPath, typeof(RuntimeAnimatorController)));
                  }

                  GUILayout.Space(10);
                  // if animator controller exists provide a button to delete it
                  if (GUILayout.Button("Delete Animator Controller"))
                  {
                    // show warning popup to confirm
                    if (EditorUtility.DisplayDialog("Delete Animator Controller", "Are you sure you want to delete the Animator Controller? \n\nThis will remove the Animator Controller from your project. \n\n WARNING this action can not be undone", "Yes", "No"))
                    {
                      // delete the animator controller
                      AssetDatabase.DeleteAsset(animatorControllerPath);
                    }
                  }

                }
              },
              foldoutTitleBackgroundColor
            );
    }
    #endif

    private void DebugConsoleLog(string message)
    {
      if (NMFConstants.debug_mode)
      {
        Debug.Log(message);
      }
    }

  }
}
