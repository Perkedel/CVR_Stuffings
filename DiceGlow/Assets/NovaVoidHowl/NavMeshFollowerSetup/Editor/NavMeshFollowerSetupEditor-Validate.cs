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

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //// functions to validate data objects
    ////
    private bool ValidateConfigFileData(NmfConfig config)
    {
      bool validData = true;
      if (config == null)
      {

        Debug.LogError("Failed to deserialize JSON data into NmfConfig object");
        validData = false;
      }

       // check if the config object has a follower_level_data object
      if(config.follower_level_data == null)
      {
        Debug.LogError("Null follower_level_data found");
        validData = false;
      }
      // check if the number of levels is correct (should be NMFConstants.maxFollowerLevel + 1, as array starts at 0)
      if(config.follower_level_data.Length != NMFConstants.maxFollowerLevel + 1)
      {
        Debug.LogError("Incorrect number of levels found");
        validData = false;
      }
      // for each level check if it has an animator_file_path set
      int levelCount = 0;
      foreach (FollowerLevelData level in config.follower_level_data)
      {
        // all levels should have a display_name
        if(level.display_name == null || level.display_name == "")
        {
          Debug.LogError("Null/Empty display_name found for level " + levelCount);
          validData = false;
        }

        // for level 0, the animator_file_path should be null or empty
        if(levelCount == 0)
        {
          if(level.animator_file_path != null)
          {
            if(level.animator_file_path != "")
            {
            Debug.LogError("Null/Empty animator_file_path expected for level 0");
            validData = false;
            }
          }
          if(level.agent_path != null)
          {
            if(level.agent_path != "")
            {
            Debug.LogError("Null/Empty agent_path expected for level 0");
            validData = false;
            }
          }
          if(level.look_at_path != null)
          {
            if(level.look_at_path != "")
            {
            Debug.LogError("Null/Empty look_at_path expected for level 0");
            validData = false;
            }
          }
          if(level.sub_syncs.Length != 0)
          {
            Debug.LogError("No sub_syncs expected for level 0");
            validData = false;
          }
        }
        else
        {
          // for all other levels, the agent_path should not be null
          if(level.agent_path == null || level.agent_path == "")
          {
            Debug.LogError("Null agent_path found for level " + levelCount);
            validData = false;
          }
          // for all other levels, the animator_file_path should not be null
          if(level.animator_file_path == null || level.animator_file_path == "")
          {
            Debug.LogError("Null animator_file_path found for level " + levelCount);
            validData = false;
          }
          // if a level has needs_FinalIK set to true then the look_at_path should not be null
          if(level.needs_FinalIK == true)
          {
            if(level.look_at_path == null || level.look_at_path == "")
            {
              Debug.LogError("Null look_at_path found for level " + levelCount);
              validData = false;
            }
          }
        }
        levelCount++;
      }

      if(config.variables == null)
      {
        Debug.LogError("Null variables data found");
        validData = false;
      }

      // check how many variables are in the config file
      if(config.variables.Length == 0)
      {
        Debug.LogError("No variables found in config file");
        validData = false;
      }

      // for each variable in the config file check if it has a Name & Default_value set
      int variableCount = 1;
      foreach (NmfConfigVariable variable in config.variables)
      {
        if(variable.name == null || variable.name == "")
        {
          Debug.LogError("Null variable name found for variable " + variableCount);
          validData = false;
        }
        if(variable.default_value == null || variable.default_value == "")
        {
          Debug.LogError("Null variable default_value found for variable " + variableCount);
          validData = false;
        }
        try
        {
            float myFloat = float.Parse(variable.default_value);
        }
        catch (FormatException e)
        {
            Debug.LogError("Failed to parse variable default_value, for variable " + variableCount + " as float: " + e.Message);
        }

        variableCount++;
      }

      return validData;
  }


    //////////////////////////////////////////
    //// Functions to validate state of items
    ////


    // Function to check if the KAFE_CVR_CCK_NAV_MESH_FOLLOWER_EXISTS scripting define symbol is set
    private bool isKafeCvrCckNavMeshFollowerExists()
    {
      return (
        PlayerSettings
          .GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup)
          .Contains("KAFE_CVR_CCK_NAV_MESH_FOLLOWER_EXISTS")
      );
    }

    // Function to check if the CVR_CCK_EXISTS scripting define symbol is set
    private bool isCvrCckExists()
    {
      return (
        PlayerSettings
          .GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup)
          .Contains("CVR_CCK_EXISTS")
      );
    }

    //Function to check if finalik is installed
    private bool isFinalIKInstalled()
    {
      return (Directory.Exists(NMFConstants.finalIK_folder));
    }

    // Function to check if there is a child object with name "NavMeshAgent" for the game object on which this script is attached
    private bool hasNavMeshAgentCore(GameObject scriptRootObject)
    {
      // Check if scriptRootObject is null
      if (scriptRootObject == null)
      {
        Debug.LogError("[CRITICAL CORE ERROR] scriptRootObject is null");
        return false;
      }
      else
      {
        // Check if scriptRootObject has a child object with name "NavMeshAgent"
        Transform navMeshAgent = scriptRootObject.transform.Find("NavMeshAgent");
        if (navMeshAgent != null)
        {
          return true;
        }
        else
        {
          return false;
        }
      }
    }

    // Function to check if there is a child object with name "[NavMeshFollower]" for the game object on which this script is attached
    private bool hasNavMeshFollowerConfigObjectsCore(GameObject scriptRootObject)
    {
      // Check if scriptRootObject is null
      if (scriptRootObject == null)
      {
        Debug.LogError("[CRITICAL CORE ERROR] scriptRootObject is null");
        return false;
      }
      else
      {
        // Check if scriptRootObject has a child object with name "[NavMeshFollower]"
        Transform navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]");
        if (navMeshFollowerConfigObject != null)
        {
          return true;
        }
        else
        {
          return false;
        }
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "LookAtTarget [Smooth]"
    private bool hasLookAtTargetSmooth(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "LookAtTarget [Smooth]"
          GameObject lookAtTargetSmooth = navMeshFollowerConfigObject.transform
            .Find("LookAtTarget [Smooth]")
            ?.gameObject;
          if (lookAtTargetSmooth != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LookAtTarget [Smooth]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "LookAtTarget [Raw]"
    private bool hasLookAtTargetRaw(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "LookAtTarget [Raw]"
          GameObject lookAtTargetRaw = navMeshFollowerConfigObject.transform.Find("LookAtTarget [Raw]")?.gameObject;
          if (lookAtTargetRaw != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LookAtTarget [Raw]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "LookAtTarget [Raw] -> Offset"
    private bool hasLookAtTargetRawOffset(GameObject scriptRootObject)
    {
      if (!hasLookAtTargetRaw(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "LookAtTarget [Raw]" object
        GameObject lookAtTargetRaw = scriptRootObject.transform
          .Find("[NavMeshFollower]/LookAtTarget [Raw]")
          ?.gameObject;

        if (lookAtTargetRaw != null)
        {
          // Check if lookAtTargetRaw has a child object with name "LookAtTarget [Raw] -> Offset"
          GameObject lookAtTargetRawOffset = lookAtTargetRaw.transform.Find("LookAtTarget [Raw] -> Offset")?.gameObject;
          if (lookAtTargetRawOffset != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LookAtTarget [Raw] -> Offset" is not found, return false
        return false;
      }
    }

    // (Level 2) Function to check if there is a child object of the "[NavMeshFollower]" object with name "NavMeshAgent [Raw]"
    private bool hasNavMeshAgentRawLevelTwo(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "NavMeshAgent"
          GameObject navMeshAgentRaw = navMeshFollowerConfigObject.transform.Find("NavMeshAgent")?.gameObject;
          if (navMeshAgentRaw != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "NavMeshAgent [Raw]" is not found, return false
        return false;
      }
    }

    // (Level 3) Function to check if there is a child object of the "[NavMeshFollower]" object with name "NavMeshAgent [Raw]"
    private bool hasNavMeshAgentRawLevelThree(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "NavMeshAgent [Raw]"
          GameObject navMeshAgentRaw = navMeshFollowerConfigObject.transform.Find("NavMeshAgent [Raw]")?.gameObject;
          if (navMeshAgentRaw != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "NavMeshAgent [Raw]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "VRIK"
    private bool hasVRIK(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "VRIK"
          GameObject vrik = navMeshFollowerConfigObject.transform.Find("VRIK")?.gameObject;
          if (vrik != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "VRIK" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "VRIK" object with name "Targets"
    private bool hasVRIKTargets(GameObject scriptRootObject)
    {
      if (!hasVRIK(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "VRIK" object
        GameObject vrik = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK")?.gameObject;

        if (vrik != null)
        {
          // Check if vrik has a child object with name "Targets"
          GameObject vrikTargets = vrik.transform.Find("Targets")?.gameObject;
          if (vrikTargets != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "Targets" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "VRIK" object with name "Scripts"
    private bool hasVRIKScripts(GameObject scriptRootObject)
    {
      if (!hasVRIK(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "VRIK" object
        GameObject vrik = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK")?.gameObject;

        if (vrik != null)
        {
          // Check if vrik has a child object with name "Scripts"
          GameObject vrikScripts = vrik.transform.Find("Scripts")?.gameObject;
          if (vrikScripts != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "Scripts" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Targets" object with name "LeftArm [Raw]"
    private bool hasVRIKTargetsLeftArmRaw(GameObject scriptRootObject)
    {
      if (!hasVRIKTargets(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Targets" object
        GameObject vrikTargets = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Targets")?.gameObject;

        if (vrikTargets != null)
        {
          // Check if vrikTargets has a child object with name "LeftArm [Raw]"
          GameObject vrikTargetsLeftArmRaw = vrikTargets.transform.Find("LeftArm [Raw]")?.gameObject;
          if (vrikTargetsLeftArmRaw != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LeftArm [Raw]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Targets" object with name "RightArm [Raw]"
    private bool hasVRIKTargetsRightArmRaw(GameObject scriptRootObject)
    {
      if (!hasVRIKTargets(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Targets" object
        GameObject vrikTargets = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Targets")?.gameObject;

        if (vrikTargets != null)
        {
          // Check if vrikTargets has a child object with name "RightArm [Raw]"
          GameObject vrikTargetsRightArmRaw = vrikTargets.transform.Find("RightArm [Raw]")?.gameObject;
          if (vrikTargetsRightArmRaw != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "RightArm [Raw]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Targets" object with name "LeftArm [Smooth]"
    private bool hasVRIKTargetsLeftArmSmooth(GameObject scriptRootObject)
    {
      if (!hasVRIKTargets(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Targets" object
        GameObject vrikTargets = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Targets")?.gameObject;

        if (vrikTargets != null)
        {
          // Check if vrikTargets has a child object with name "LeftArm [Smooth]"
          GameObject vrikTargetsLeftArmSmooth = vrikTargets.transform.Find("LeftArm [Smooth]")?.gameObject;
          if (vrikTargetsLeftArmSmooth != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LeftArm [Smooth]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Targets" object with name "RightArm [Smooth]"
    private bool hasVRIKTargetsRightArmSmooth(GameObject scriptRootObject)
    {
      if (!hasVRIKTargets(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Targets" object
        GameObject vrikTargets = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Targets")?.gameObject;

        if (vrikTargets != null)
        {
          // Check if vrikTargets has a child object with name "RightArm [Smooth]"
          GameObject vrikTargetsRightArmSmooth = vrikTargets.transform.Find("RightArm [Smooth]")?.gameObject;
          if (vrikTargetsRightArmSmooth != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "RightArm [Smooth]" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Scripts" object with name "BothHands"
    private bool hasVRIKScriptsBothHands(GameObject scriptRootObject)
    {
      if (!hasVRIKScripts(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Scripts" object
        GameObject vrikScripts = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Scripts")?.gameObject;

        if (vrikScripts != null)
        {
          // Check if vrikScripts has a child object with name "BothHands"
          GameObject vrikScriptsBothHands = vrikScripts.transform.Find("BothHands")?.gameObject;
          if (vrikScriptsBothHands != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "BothHands" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Scripts" object with name "LeftHand"
    private bool hasVRIKScriptsLeftHand(GameObject scriptRootObject)
    {
      if (!hasVRIKScripts(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Scripts" object
        GameObject vrikScripts = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Scripts")?.gameObject;

        if (vrikScripts != null)
        {
          // Check if vrikScripts has a child object with name "LeftHand"
          GameObject vrikScriptsLeftHand = vrikScripts.transform.Find("LeftHand")?.gameObject;
          if (vrikScriptsLeftHand != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LeftHand" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "Scripts" object with name "RightHand"
    private bool hasVRIKScriptsRightHand(GameObject scriptRootObject)
    {
      if (!hasVRIKScripts(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the "Scripts" object
        GameObject vrikScripts = scriptRootObject.transform.Find("[NavMeshFollower]/VRIK/Scripts")?.gameObject;

        if (vrikScripts != null)
        {
          // Check if vrikScripts has a child object with name "RightHand"
          GameObject vrikScriptsRightHand = vrikScripts.transform.Find("RightHand")?.gameObject;
          if (vrikScriptsRightHand != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "RightHand" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "LeftHandAttachmentPoint"
    private bool hasLeftHandAttachmentPoint(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "LeftHandAttachmentPoint"
          GameObject leftHandAttachmentPoint = navMeshFollowerConfigObject.transform
            .Find("LeftHandAttachmentPoint")
            ?.gameObject;
          if (leftHandAttachmentPoint != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "LeftHandAttachmentPoint" is not found, return false
        return false;
      }
    }

    // Function to check if there is a child object of the "[NavMeshFollower]" object with name "RightHandAttachmentPoint"
    private bool hasRightHandAttachmentPoint(GameObject scriptRootObject)
    {
      if (!hasNavMeshFollowerConfigObjectsCore(scriptRootObject))
      {
        return false;
      }
      else
      {
        // Get the [NavMeshFollower] object
        GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;

        if (navMeshFollowerConfigObject != null)
        {
          // Check if navMeshFollowerConfigObjectCore has a child object with name "RightHandAttachmentPoint"
          GameObject rightHandAttachmentPoint = navMeshFollowerConfigObject.transform
            .Find("RightHandAttachmentPoint")
            ?.gameObject;
          if (rightHandAttachmentPoint != null)
          {
            return true;
          }
        }

        // If any of the objects are null or "RightHandAttachmentPoint" is not found, return false
        return false;
      }
    }


  }
}
