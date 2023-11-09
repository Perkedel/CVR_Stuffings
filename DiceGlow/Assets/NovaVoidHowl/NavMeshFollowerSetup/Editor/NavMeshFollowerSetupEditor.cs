// Version: 1.0.10
using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;
using ParentConstraint = UnityEngine.Animations.ParentConstraint;
using AnimatorController = UnityEditor.Animations.AnimatorController;
using AnimatorControllerParameter = UnityEngine.AnimatorControllerParameter;
using AnimatorControllerParameterType = UnityEngine.AnimatorControllerParameterType;
#endif
using uk.novavoidhowl.dev.navmeshfollowersetup;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Dynamic loads

#if NVH_COMMON_EXISTS
using NVHCommonUI = uk.novavoidhowl.dev.common.ui;
#endif

#if KAFE_CVR_CCK_NAV_MESH_FOLLOWER_EXISTS
using Kafe.NavMeshFollower.CCK;
#endif

#if CVR_CCK_EXISTS
using ABI.CCK.Components;
#endif

// using RootMotion.FinalIK;


namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  [ExecuteInEditMode]
  [CustomEditor(typeof(NavMeshFollowerSetup))]
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    SerializedProperty exoticEyes;
    SerializedProperty spineBones;

    NmfConfig NMFSConfig = null;



    private void OnEnable()
    {
        exoticEyes = serializedObject.FindProperty("exoticEyes");
    }


    public override void OnInspectorGUI()
    {

      // check is core UI is installed

      if (GetCommonUIPackageVersion() == "Not Installed")
      {
        EditorGUILayout.HelpBox(
          "Common UI is not installed. Please install Common UI to use this package.",
          MessageType.Error
        );

        // add button to open the NMFToolSetup window
        if (GUILayout.Button("Open Setup Window"))
        {
          NMFToolSetup.ShowWindow();
        }


        // add button to visit Common UI page on GitHub
        if (GUILayout.Button("Get the Common UI package from GitHub"))
        {
          Application.OpenURL("https://github.com/NovaVoidHowl/Common-Unity-Resources");
        }


        return;
      }

      // after this we need the CoreUI to be installed
      #if NVH_COMMON_EXISTS

      // formatting setup

      setupFollowerButtonStyle = new GUIStyle(GUI.skin.button);
      setupFollowerButtonStyle.fontStyle = FontStyle.Bold;
      setupFollowerButtonStyle.fontSize = 14;
      setupFollowerButtonStyle.normal.background = NVHCommonUI.CoreUIHelpers.MakeTextureFromColour(1, 1, NVHCommonUI.CoreUIHelpers.HexToColour("#000088"));  // Set the color to your desired value
      // get object this script is attached to

      NavMeshFollowerSetup setupScript = (NavMeshFollowerSetup)target;
      GameObject scriptRootObject = setupScript.gameObject;

       // button to toggle extended info
      NVHCommonUI.CoreUI.RenderToggleButton(
        ref setupScript.extendedInfoShow,
        "Extended Info Shown",
        "Extended Info Hidden"
      );

      NVHCommonUI.CoreUI.RenderHorizontalSeparator();
      // Show package version
      GUILayout.Label("Navmesh Follower Setup v" + GetPackageVersion(), EditorStyles.boldLabel);

      if(setupScript.extendedInfoShow)
      {
        NVHCommonUI.CoreUI.RenderFoldoutSection(
                "Component Versions",
                ref setupScript.versionsShow,
                () =>
                {
                  GUILayout.Label("Common UI v" + GetCommonUIPackageVersion());
                },
                foldoutVersionBackgroundColor
              );
      }

      NVHCommonUI.CoreUI.RenderHorizontalSeparator();



      if (!isKafeCvrCckNavMeshFollowerExists())
      {
        EditorGUILayout.HelpBox(
          "KafeCVR CCK NavMeshFollower is not installed. Please install KafeCVR CCK NavMeshFollower to use this package.",
          MessageType.Warning
        );
        // add button to visit KafeCVR CCK NavMeshFollower page on GitHub
        if (GUILayout.Button("Visit KafeCVR CCK NavMeshFollower on GitHub"))
        {
          Application.OpenURL("https://github.com/kafeijao/Kafe_CVR_CCKs/tree/master/NavMeshFollower");
        }
        return;
      }


      if (!isConfigFileExists())
      {
        // ok not found in the NMF folder, check if it exists in the packages folder
        if (!isConfigFileExistsInPackagesFolder())
        {
          // not found in the packages folder, stuck at this point so show warning message
          EditorGUILayout.HelpBox(
            "Primary and Fall back config files not found." +
            "\nPlease re-install NavMesh Follower setup package.",
            MessageType.Error
          );
          return;
        }
        else
        {
          EditorGUILayout.HelpBox(
          "Config file not found. in the NMF folder." +
          "\nPlease Update to the latest version of the NMF package.",
          MessageType.Warning
          );
          if(setupScript.extendedInfoShow)
          {
            EditorGUILayout.HelpBox(
            "Using fallback config file",
            MessageType.Info
            );
          }

          // primary config file Not found, load fallback and continue
          string jsonString = File.ReadAllText(NMFConstants.configFilePath_fallback);
          // Deserialize the JSON data into an object
          NMFSConfig = JsonUtility.FromJson<NmfConfig>(jsonString);
        }
      }
      else
      {
        // primary config file found, load and continue
        string jsonString = File.ReadAllText(NMFConstants.configFilePath_primary);

        // Deserialize the JSON data into an object
        NMFSConfig = JsonUtility.FromJson<NmfConfig>(jsonString);
      }



      if(!ValidateConfigFileData(NMFSConfig))
      {
        EditorGUILayout.HelpBox(
        "Config file load error. see console for details.",
        MessageType.Error);
        return;
      }


      if (!isCvrCckExists())
      {
        EditorGUILayout.HelpBox(
          "CVR CCK is not installed. Please install CVR CCK to use this package.",
          MessageType.Warning
        );
        // add button to visit CVR CCK page
        if (GUILayout.Button("Visit CVR CCK documentation page"))
        {
          Application.OpenURL("https://docs.abinteractive.net/cck/setup/");
        }
        return;
      }

      GUILayout.Space(10);

      // Show field for navMeshFollowerBody
      NavMeshFollowerSetup navMeshFollowerSetup = (NavMeshFollowerSetup)target;

      navMeshFollowerSetup.navMeshFollowerBody = (GameObject)
        EditorGUILayout.ObjectField(
          "Follower Body",
          navMeshFollowerSetup.navMeshFollowerBody,
          typeof(GameObject),
          true
        );

      GUILayout.Space(20);

      if (navMeshFollowerSetup.navMeshFollowerBody == null)
      {
        EditorGUILayout.HelpBox("Please select a Navmesh Follower Body.", MessageType.Info);
        // show button for each game object under the scriptRootObject that has an animator component,
        // to set navMeshFollowerBody, excluding items under the [NavMeshFollower] object
        Animator[] animatorComponents = scriptRootObject.GetComponentsInChildren<Animator>();
        foreach (Animator animatorComponent in animatorComponents)
        {
          if (animatorComponent.transform.parent.name != "[NavMeshFollower]")
          {
            if (GUILayout.Button("Set Follower Body to " + animatorComponent.gameObject.name))
            {
              navMeshFollowerSetup.navMeshFollowerBody = animatorComponent.gameObject;
              Debug.Log("Set Follower Body to " + animatorComponent.gameObject.name);

              // disable the other game objects from the list
              foreach (Animator animatorComponent2 in animatorComponents)
              {
                if (animatorComponent2.gameObject != animatorComponent.gameObject)
                {
                  animatorComponent2.gameObject.SetActive(false);
                }
              }
            }
          }
        }

        return;
      }



      /// make string array from  NMFSConfig.follower_level_data[].display_name then use as dropdown
      string[] followerLevelNames = new string[NMFSConfig.follower_level_data.Length];
      for (int i = 0; i < NMFSConfig.follower_level_data.Length; i++)
      {
        followerLevelNames[i] = NMFSConfig.follower_level_data[i].display_name;
      }

      navMeshFollowerSetup.followerLevel = EditorGUILayout.Popup(
        "Follower Level",
        navMeshFollowerSetup.followerLevel,
        followerLevelNames
      );

      // check if current followerLevel needs FinalIK and if FinalIK is installed
      if(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].needs_FinalIK && !isFinalIKInstalled())
      {
        // Show error message
        EditorGUILayout.HelpBox(
          "FinalIK is not installed. Please install FinalIK to use "+ NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].display_name + ".",
          MessageType.Error
        );
        // Stop here
        return;
      }

      // check if current followerLevel has 'blank_avatar' set to false
      if(!NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].blank_avatar)
      {
        //check if navMeshFollowerSetup.avatar is null
        if (navMeshFollowerSetup.avatar == null)
        {
          // nothing we can do automatically, to put the avatar back in the animator if it has been removed

          // check if the avatar value of the animator on the navMeshFollowerBody is null
          Animator animatorComponent = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();
          if (animatorComponent.avatar == null)
          {
            // show error message
            EditorGUILayout.HelpBox(
            "Avatar is not set, \nLevel " + navMeshFollowerSetup.followerLevel + " requires this please check the animator.",
            MessageType.Error
            );

            // show button to select the navMeshFollowerBody game object
            if (GUILayout.Button("Select Animator"))
            {
              Selection.activeGameObject = navMeshFollowerSetup.navMeshFollowerBody;
            }

            // stop here
            return;
          }

        }
        else
        {
          // check if the avatar value of the animator on the navMeshFollowerBody is null
          Animator animatorComponent = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();
          if (animatorComponent.avatar == null)
          {
            // put the avatar back in the animator
            animatorComponent.avatar = navMeshFollowerSetup.avatar;
          }
        }
      }


      GUILayout.Space(20);

      // when followerLevel is 0, show info message
      if (navMeshFollowerSetup.followerLevel == 0)
      {
        EditorGUILayout.HelpBox("Please select a follower level.", MessageType.Info);
        return;
      }

      if (navMeshFollowerSetup.followerLevel > 0)
      {

        // check if CVRSpawnable component exists
        CVRSpawnable CVRSpawnableComponent = scriptRootObject.GetComponent<CVRSpawnable>();

        if (CVRSpawnableComponent == null)
        {
          // Add CVRSpawnable component to scriptRootObject
          CVRSpawnableComponent = scriptRootObject.AddComponent<CVRSpawnable>();
          // console message to say that missing CVRSpawnable component was added
          Debug.Log("Added CVRSpawnable component to " + scriptRootObject.name);
        }

        float SubSyncCosts = getSubSyncCosts(CVRSpawnableComponent);

        var SyncCost = CVRSpawnableComponent.syncValues.Count + SubSyncCosts;

        // get percentage of SyncCost / 40
        float progress = SyncCost / 40f;
        // proportional  convert the progress to a pair of hex characters
        string progressHex = Mathf.FloorToInt(progress * 255).ToString("X2");

        Rect _rect = EditorGUILayout.GetControlRect(false, EditorGUIUtility.singleLineHeight * 2 + EditorGUIUtility.standardVerticalSpacing);
        string label = Mathf.CeilToInt(SyncCost) + " of 40 Synced Parameter Slots used\n" +
          "Note this only updates upon pressing the Setup Follower button";
        EditorGUI.ProgressBar(_rect, progress, "");
        Rect labelRect = new Rect(_rect.x, _rect.y, _rect.width, _rect.height);
        EditorGUI.DrawRect(new Rect(_rect.x, _rect.y, _rect.width * progress, _rect.height), NVHCommonUI.CoreUIHelpers.HexToColour(NMFConstants.progress_bar_fill_color + progressHex));
        EditorGUI.LabelField(labelRect, label, new GUIStyle(EditorStyles.centeredGreyMiniLabel) { normal = { textColor = Color.white } });
        EditorGUILayout.Space();


        NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Follower Agent Settings",
          ref navMeshFollowerSetup.followerAgentSettingsSectionShow,
          () =>
          {
            // show field for agent.speed
            navMeshFollowerSetup.agent_speed = EditorGUILayout.FloatField("Speed", navMeshFollowerSetup.agent_speed);
            // show field for agent.angularSpeed
            navMeshFollowerSetup.agent_angularSpeed = EditorGUILayout.FloatField(
              "Angular Speed",
              navMeshFollowerSetup.agent_angularSpeed
            );
            // show field for agent_acceleration
            navMeshFollowerSetup.agent_acceleration = EditorGUILayout.FloatField(
              "Acceleration",
              navMeshFollowerSetup.agent_acceleration
            );
            // show field for agent_stoppingDistance
            navMeshFollowerSetup.agent_stoppingDistance = EditorGUILayout.FloatField(
              "Stopping Distance",
              navMeshFollowerSetup.agent_stoppingDistance
            );
            // show field for agent_radius
            navMeshFollowerSetup.agent_radius = EditorGUILayout.FloatField(
              "Collision Radius",
              navMeshFollowerSetup.agent_radius
            );
            // show field for agent_height
            navMeshFollowerSetup.agent_height = EditorGUILayout.FloatField(
              "Collision Height",
              navMeshFollowerSetup.agent_height
            );
          },
          foldoutTitleBackgroundColor
        );


        ///////////////////////////////////// sync values update from config file /////////////////////////////////////

        // check if navMeshFollowerSetup.nmfConfigVariables is empty
        if (navMeshFollowerSetup.nmfConfigVariables.Length == 0)
        {
          // if empty, populate with data from NMFSConfig
          navMeshFollowerSetup.nmfConfigVariables = NMFSConfig.variables;
        }
        else
        {
          // if not empty, check if there are more variables in navMeshFollowerSetup.nmfConfigVariables than in NMFSConfig.variables
          if (navMeshFollowerSetup.nmfConfigVariables.Length > NMFSConfig.variables.Length)
          {
            // warn the user that there the current follower variables are not compatible with the current config file
            EditorGUILayout.HelpBox(
              "The current follower variables are not compatible with the current config file." +
              "\nPlease update the config file or reset the follower variables.",
              MessageType.Warning
            );
            // show button to reset follower variables to default
            if (GUILayout.Button("Reset Follower Variables"))
            {
              // reset follower variables to default
              navMeshFollowerSetup.nmfConfigVariables = NMFSConfig.variables;
              Debug.Log("Reset Follower Variables");
            }
            // stop here as the user needs to update the config file or reset the follower variables
            return;
          }

          // if not empty, check if there are less variables in navMeshFollowerSetup.nmfConfigVariables than in NMFSConfig.variables
          if (navMeshFollowerSetup.nmfConfigVariables.Length < NMFSConfig.variables.Length)
          {
            // let the user know that there are now more variables available in the config file
            EditorGUILayout.HelpBox(
              "There are now more variables available in the config file." +
              "\nPlease update the follower variables.",
              MessageType.Info
            );
            // show button to add new variables to follower variables
            if (GUILayout.Button("Add New Variables"))
            {
              // for each variable in NMFSConfig.variables that is not in navMeshFollowerSetup.nmfConfigVariables, add it to navMeshFollowerSetup.nmfConfigVariables
              foreach (NmfConfigVariable variable in NMFSConfig.variables)
              {
                if (!Array.Exists(navMeshFollowerSetup.nmfConfigVariables, element => element.name == variable.name))
                {
                  // add variable to navMeshFollowerSetup.nmfConfigVariables
                  Array.Resize(ref navMeshFollowerSetup.nmfConfigVariables, navMeshFollowerSetup.nmfConfigVariables.Length + 1);
                  navMeshFollowerSetup.nmfConfigVariables[navMeshFollowerSetup.nmfConfigVariables.Length - 1] = variable;
                }
              }
            }
            // stop here as the user needs to update the follower variables
            return;
          }
        }

        // for each variable in NMFSConfig.variables update the mandatory_for_levels in navMeshFollowerSetup.nmfConfigVariables
        foreach (NmfConfigVariable variable in NMFSConfig.variables)
        {
          // check if variable exists in navMeshFollowerSetup.nmfConfigVariables
          if (Array.Exists(navMeshFollowerSetup.nmfConfigVariables, element => element.name == variable.name))
          {
            // variable exists in navMeshFollowerSetup.nmfConfigVariables, so update mandatory_for_levels
            // get index of variable in navMeshFollowerSetup.nmfConfigVariables
            int index = Array.FindIndex(navMeshFollowerSetup.nmfConfigVariables, element => element.name == variable.name);
            // update mandatory_for_levels
            navMeshFollowerSetup.nmfConfigVariables[index].mandatory_for_levels = variable.mandatory_for_levels;
          }
        }


        // check if navMeshFollowerSetup.nmfIKVariables is empty
        if (navMeshFollowerSetup.nmfIKVariables.Length == 0)
        {
          // if empty, populate with data from NMFSConfig
          navMeshFollowerSetup.nmfIKVariables = NMFSConfig.ik_variables;
        }
        else
        {
          // if not empty, check if there are more variables in navMeshFollowerSetup.nmfIKVariables than in NMFSConfig.ik_variables
          if (navMeshFollowerSetup.nmfIKVariables.Length > NMFSConfig.ik_variables.Length)
          {
            // warn the user that there the current follower ik variables are not compatible with the current config file
            EditorGUILayout.HelpBox(
              "The current follower ik variables are not compatible with the current config file." +
              "\nPlease update the config file or reset the follower ik variables.",
              MessageType.Warning
            );
            // show button to reset follower variables to default
            if (GUILayout.Button("Reset Follower IK Variables"))
            {
              // reset follower variables to default
              navMeshFollowerSetup.nmfIKVariables = NMFSConfig.ik_variables;
              Debug.Log("Reset Follower Variables");
            }
            // stop here as the user needs to update the config file or reset the follower variables
            return;
          }

          // if not empty, check if there are less variables in navMeshFollowerSetup.nmfIKVariables than in NMFSConfig.variables
          if (navMeshFollowerSetup.nmfIKVariables.Length < NMFSConfig.ik_variables.Length)
          {
            // let the user know that there are now more variables available in the config file
            EditorGUILayout.HelpBox(
              "There are now more IK variables available in the config file." +
              "\nPlease update the follower variables.",
              MessageType.Info
            );
            // show button to add new variables to follower variables
            if (GUILayout.Button("Add New Variables"))
            {
              // for each variable in NMFSConfig.variables that is not in navMeshFollowerSetup.nmfIKVariables, add it to navMeshFollowerSetup.nmfIKVariables
              foreach (NmfConfigVariable variable in NMFSConfig.ik_variables)
              {
                if (!Array.Exists(navMeshFollowerSetup.nmfIKVariables, element => element.name == variable.name))
                {
                  // add variable to navMeshFollowerSetup.nmfIKVariables
                  Array.Resize(ref navMeshFollowerSetup.nmfIKVariables, navMeshFollowerSetup.nmfIKVariables.Length + 1);
                  navMeshFollowerSetup.nmfIKVariables[navMeshFollowerSetup.nmfIKVariables.Length - 1] = variable;
                }
              }
            }
            // stop here as the user needs to update the follower variables
            return;
          }
        }

        // for each variable in NMFSConfig.ik_variables update the mandatory_for_levels in navMeshFollowerSetup.nmfIKVariables
        foreach (NmfConfigVariable variable in NMFSConfig.ik_variables)
        {
          // check if variable exists in navMeshFollowerSetup.nmfIKVariables
          if (Array.Exists(navMeshFollowerSetup.nmfIKVariables, element => element.name == variable.name))
          {
            // variable exists in navMeshFollowerSetup.nmfIKVariables, so update mandatory_for_levels
            // get index of variable in navMeshFollowerSetup.nmfIKVariables
            int index = Array.FindIndex(navMeshFollowerSetup.nmfIKVariables, element => element.name == variable.name);
            // update mandatory_for_levels
            navMeshFollowerSetup.nmfIKVariables[index].mandatory_for_levels = variable.mandatory_for_levels;
          }
        }





        ////////////////////////////////////////////// UI render continue //////////////////////////////////////////////

        // get animator controller from animator component
        Animator animatorComponent = navMeshFollowerSetup.navMeshFollowerBody.GetComponent<Animator>();

        // if animatorComponent is null, show error message
        if (animatorComponent == null)
        {
          EditorGUILayout.HelpBox(
            "Animator component not found on " + navMeshFollowerSetup.navMeshFollowerBody.name,
            MessageType.Error
          );
          // button to add animator component to navMeshFollowerBody
          if (GUILayout.Button("Add Animator Component"))
          {
            navMeshFollowerSetup.navMeshFollowerBody.AddComponent<Animator>();
          }

          return;
        }



        // get animator controller from animator component
        AnimatorController controller = animatorComponent.runtimeAnimatorController as AnimatorController;

        // if controller is null, show error message
        if (controller == null)
        {
          EditorGUILayout.HelpBox(
            "Animator Controller not found on " + navMeshFollowerSetup.navMeshFollowerBody.name,
            MessageType.Error
          );
          // button to add animator controller to navMeshFollowerBody
          if (GUILayout.Button("Add Animator Controller"))
          {
            // get animator controller file path from NMFSConfig
            string animatorFilePath = NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].animator_file_path;


            // check if animator controller file exists at animatorFilePath
            if (File.Exists(animatorFilePath))
            {

              CreateFoldersInAssetsRecursively("NMF/GeneratedAnimators/" + navMeshFollowerSetup.navMeshFollowerBody.name);
              // copy the animator to the folder made above
              AssetDatabase.CopyAsset(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].animator_file_path, NMFConstants.generatedAnimatorsPath + navMeshFollowerSetup.navMeshFollowerBody.name + "/" + navMeshFollowerSetup.navMeshFollowerBody.name + "_Level_" + navMeshFollowerSetup.followerLevel + "_Animator.controller");

              // set the animator controller on the navMeshFollowerBodyAnimator to be the one we just copied
              animatorComponent.runtimeAnimatorController = (RuntimeAnimatorController)AssetDatabase.LoadAssetAtPath(NMFConstants.generatedAnimatorsPath + navMeshFollowerSetup.navMeshFollowerBody.name + "/" + navMeshFollowerSetup.navMeshFollowerBody.name + "_Level_" + navMeshFollowerSetup.followerLevel + "_Animator.controller", typeof(RuntimeAnimatorController));

            }
            else
            {
              // this should never happen as the animator controller file path is set in the config file
              // animator controller file does not exist at animatorFilePath, so show error message
              EditorGUILayout.HelpBox(
                "Animator Controller file not found at " + animatorFilePath,
                MessageType.Error
              );
              // stop here
              return;
            }
          }

          return;
        }

        // get list of animatorParameters from animator controller
        AnimatorControllerParameter[] animatorParameters = controller.parameters;



        NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Follower Variables Enablement",
          ref navMeshFollowerSetup.ModSupportedVariableSectionShow,
          () =>
          {
            foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfConfigVariables)
            {
              bool variableExists = false;
              // check if variable is in the list of parameters from animator
              if (Array.Exists(animatorParameters, element => element.name == variable.name))
              {
                // variable is in the list of parameters from animator
                variableExists = true;
              }

              // check if variable is mandatory for current follower level
              if (Array.Exists(variable.mandatory_for_levels, element => element == navMeshFollowerSetup.followerLevel))
              {
                // variable is mandatory for current follower level, so enable and lock button
                GUI.enabled = false;
                // force variable.enabled to true
                variable.enabled = true;
                // show button for variable
                NVHCommonUI.CoreUI.RenderToggleButton(
                  ref variable.enabled,
                  variable.name + " is enabled (mandatory for level " + navMeshFollowerSetup.followerLevel + ")",
                  variable.name + " is disabled"
                );
                GUI.enabled = true;
              }
              else
              {
                // if variable is not in the list of parameters from animator, disable and lock button
                if (!variableExists)
                {
                  GUI.enabled = false;
                  // force variable.enabled to false
                  variable.enabled = false;
                  // show button for variable
                  NVHCommonUI.CoreUI.RenderToggleButton(
                    ref variable.enabled,
                    variable.name + " is enabled",
                    variable.name + " is disabled (not in animator)"
                  );
                  GUI.enabled = true;
                }
                else
                {
                  // variable is not mandatory for current follower level, so show button
                  // show button for variable
                  NVHCommonUI.CoreUI.RenderToggleButton(
                    ref variable.enabled,
                    variable.name + " is enabled",
                    variable.name + " is disabled"
                  );
                }
              }
            }
          },
          foldoutTitleBackgroundColor
        );
        //////////////////////////////// process custom params ////////////////////////////////

        bool nonFloatVariablesExist = false;

        //get list of parameter names from navMeshFollowerSetup.nmfConfigVariables
        string[] parameterNames = new string[navMeshFollowerSetup.nmfConfigVariables.Length];
        for (int i = 0; i < navMeshFollowerSetup.nmfConfigVariables.Length; i++)
        {
          parameterNames[i] = navMeshFollowerSetup.nmfConfigVariables[i].name;
        }

        //get a list of parameter names from animatorParameters
        string[] animatorParameterNames = new string[animatorParameters.Length];
        for (int i = 0; i < animatorParameters.Length; i++)
        {
          //check if parameter type is float (we only want float parameters as that is all that will sync on a prop)
          if (animatorParameters[i].type == AnimatorControllerParameterType.Float)
          {
            // parameter type is float, so add to list
            animatorParameterNames[i] = animatorParameters[i].name;
          }
          else
          {
            // parameter type is not float, so set message bool
            nonFloatVariablesExist = true;
          }
        }

        // remove all blank entries from animatorParameterNames
        animatorParameterNames = Array.FindAll(animatorParameterNames, element => !string.IsNullOrEmpty(element));

        // remove all names that start with a #
        animatorParameterNames = Array.FindAll(animatorParameterNames, element => !element.StartsWith("#"));

        // remove all names that already exist in parameterNames
        animatorParameterNames = Array.FindAll(animatorParameterNames, element => !Array.Exists(parameterNames, element2 => element2 == element));

        // sort animatorParameterNames alphabetically
        Array.Sort(animatorParameterNames);

        // if navMeshFollowerSetup.nmfAnimatorControllerVariables is empty, populate it with the list of animatorParameterNames
        if(navMeshFollowerSetup.nmfAnimatorControllerVariables.Length == 0 || navMeshFollowerSetup.nmfAnimatorControllerVariables == null)
        {
          //for each animatorParameterName, add it to navMeshFollowerSetup.nmfAnimatorControllerVariables
          foreach (string parameterName in animatorParameterNames)
          {
            // make new NmfConfigVariable instance
            NmfConfigVariable newVariable = new NmfConfigVariable();
            // set name
            newVariable.name = parameterName;

            // get the default value from the animator
            AnimatorControllerParameter[] animatorParameters2 = controller.parameters;
            AnimatorControllerParameter animatorParameter = Array.Find(animatorParameters2, element => element.name == parameterName);
            newVariable.default_value = animatorParameter.defaultFloat.ToString();

            // set enabled to false
            newVariable.enabled = false;
            // set mandatory_for_levels to empty array
            newVariable.mandatory_for_levels = new int[0];
            // add newVariable to navMeshFollowerSetup.nmfAnimatorControllerVariables
            Array.Resize(ref navMeshFollowerSetup.nmfAnimatorControllerVariables, navMeshFollowerSetup.nmfAnimatorControllerVariables.Length + 1);
            navMeshFollowerSetup.nmfAnimatorControllerVariables[navMeshFollowerSetup.nmfAnimatorControllerVariables.Length - 1] = newVariable;
          }
        }

        //check if there are more variables in animatorParameterNames than in navMeshFollowerSetup.nmfAnimatorControllerVariables
        if (animatorParameterNames.Length > navMeshFollowerSetup.nmfAnimatorControllerVariables.Length)
        {
          // for each animatorParameterName that is not in navMeshFollowerSetup.nmfAnimatorControllerVariables, add it to navMeshFollowerSetup.nmfAnimatorControllerVariables
          foreach (string parameterName in animatorParameterNames)
          {
            if (!Array.Exists(navMeshFollowerSetup.nmfAnimatorControllerVariables, element => element.name == parameterName))
            {
              // make new NmfConfigVariable instance
              NmfConfigVariable newVariable = new NmfConfigVariable();
              // set name
              newVariable.name = parameterName;
              // set enabled to false
              newVariable.enabled = false;
              // set mandatory_for_levels to empty array
              newVariable.mandatory_for_levels = new int[0];
              // add newVariable to navMeshFollowerSetup.nmfAnimatorControllerVariables
              Array.Resize(ref navMeshFollowerSetup.nmfAnimatorControllerVariables, navMeshFollowerSetup.nmfAnimatorControllerVariables.Length + 1);
              navMeshFollowerSetup.nmfAnimatorControllerVariables[navMeshFollowerSetup.nmfAnimatorControllerVariables.Length - 1] = newVariable;
            }
          }
        }

        // for each variable in navMeshFollowerSetup.nmfAnimatorControllerVariables that is not in animatorParameterNames, remove it from navMeshFollowerSetup.nmfAnimatorControllerVariables
        foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfAnimatorControllerVariables)
        {
          if (!Array.Exists(animatorParameterNames, element => element == variable.name))
          {
            // remove variable from navMeshFollowerSetup.nmfAnimatorControllerVariables
            navMeshFollowerSetup.nmfAnimatorControllerVariables = Array.FindAll(navMeshFollowerSetup.nmfAnimatorControllerVariables, element => element.name != variable.name);
          }
        }

        // for each variable in navMeshFollowerSetup.nmfAnimatorControllerVariables, update default_value from the animator
        foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfAnimatorControllerVariables)
        {
          // get the default value from the animator
          AnimatorControllerParameter[] animatorParameters2 = controller.parameters;
          AnimatorControllerParameter animatorParameter = Array.Find(animatorParameters2, element => element.name == variable.name);
          variable.default_value = animatorParameter.defaultFloat.ToString();
        }



        //////////////////////////////// UI render continue ////////////////////////////////

        NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Follower Custom Variables Enablement",
          ref navMeshFollowerSetup.CustomVariableSectionShow,
          () =>
          {
            // show message box to let the user know that non float variables exist
            if (nonFloatVariablesExist && setupScript.extendedInfoShow)
            {
              EditorGUILayout.HelpBox(
                "Non-float variables exist in the animator, these will not sync on a prop " +
                "\n and thus will not show up in this list.",
                MessageType.Info
              );
            }

            foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfAnimatorControllerVariables)
            {
              // start box
              EditorGUILayout.BeginVertical("Box");
              // show button for variable
              NVHCommonUI.CoreUI.RenderToggleButton(
                ref variable.enabled,
                variable.name + " is enabled",
                variable.name + " is disabled"
              );
              // show disabled field for variable.default_value
              GUI.enabled = false;
              EditorGUILayout.TextField("Default Value", variable.default_value);
              GUI.enabled = true;
              // end box
              EditorGUILayout.EndVertical();
            }


          },
          foldoutTitleBackgroundColor
        );

        //////////////

        foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfIKVariables)
        {
          if (Array.Exists(variable.mandatory_for_levels, element => element == navMeshFollowerSetup.followerLevel))
          {
            // force variable.enabled to true
            variable.enabled = true;
          }
          else
          {
            // force variable.enabled to false
            variable.enabled = false;
          }
        }

        if(setupScript.extendedInfoShow)
        {
          NVHCommonUI.CoreUI.RenderFoldoutSection(
            "Follower IK Variables",
            ref navMeshFollowerSetup.ModSupportedIKVariableSectionShow,
            () =>
            {
              foreach (NmfConfigVariable variable in navMeshFollowerSetup.nmfIKVariables)
              {
                //check if variable is enabled or disabled and show a label to tell the user its state
                if (variable.enabled)
                {
                  // variable is enabled, so show label to tell the user its state
                  EditorGUILayout.LabelField(variable.name + " is enabled");
                }
                else
                {
                  // variable is disabled, so show label to tell the user its state
                  EditorGUILayout.LabelField(variable.name + " is disabled");
                }
              }
            },
            foldoutTitleBackgroundColor
          );
        }
      }

      GUILayout.Space(20);

      // when followerLevel is 1
      if (navMeshFollowerSetup.followerLevel == 1)
      {
        if (levelOneFollowerCheckup(scriptRootObject))
        {
          // show button to reset follower agent settings
          if (GUILayout.Button("Reset Follower Agent Settings"))
          {
            navMeshFollowerSetup.agent_speed = 3f;
            navMeshFollowerSetup.agent_angularSpeed = 240f;
            navMeshFollowerSetup.agent_acceleration = 10f;
            navMeshFollowerSetup.agent_stoppingDistance = 1.5f;
            navMeshFollowerSetup.agent_radius = 0.15f;
            navMeshFollowerSetup.agent_height = 0.3f;
            Debug.Log("Reset Follower Agent Settings");
          }

          GUILayout.Space(10);
          RenderAnimatorControl(navMeshFollowerSetup);

          GUILayout.Space(20);
          // show button to setup follower
          if (GUILayout.Button("Setup Follower", setupFollowerButtonStyle, GUILayout.Height(setupFollowerButtonHeight)))
          {
            setupLevelOneFollower(navMeshFollowerSetup, navMeshFollowerSetup.navMeshFollowerBody, scriptRootObject);
          }
        }
        else
        {
          // checkup failed
          // show button to add NavMeshAgent object under the scriptRootObject
          if (GUILayout.Button("Add NavMeshAgent"))
          {
            // if [NavMeshAgent] object already exists (from level 2/3), remove it
            GameObject navMeshAgentLevelTwoOrThree = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject;
            if (navMeshAgentLevelTwoOrThree != null)
            {
              DestroyImmediate(navMeshAgentLevelTwoOrThree);
            }

            // setup for level 1
            GameObject navMeshAgent = new GameObject("NavMeshAgent");
            navMeshAgent.transform.parent = scriptRootObject.transform;
            // zero out position and rotation
            navMeshAgent.transform.localPosition = Vector3.zero;
            navMeshAgent.transform.localRotation = Quaternion.identity;
            UnityEngine.AI.NavMeshAgent agent = navMeshAgent.AddComponent<UnityEngine.AI.NavMeshAgent>();
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

            Debug.Log("Added NavMeshAgent");
          }

          return;
        }
      }


      if (navMeshFollowerSetup.followerLevel == 2)
      {
        if (levelTwoFollowerCheckup(scriptRootObject))
        {
          // passed test, show setup options

          // setup head bone
          setHeadBoneFromnavMeshFollowerBody(navMeshFollowerSetup);

          if (!isHeadBoneSet(navMeshFollowerSetup))
          {
            // show error message if head bone is not set
            EditorGUILayout.HelpBox(
            "Head bone is not set, please set the head bone.",
            MessageType.Error
            );
            // if head bone is not set, stop here
            return;
          }

          // setup eye bones
          GUILayout.Space(10);
          // show a button to toggle if you want to use the eye bones based on the eyeIKenabled bool, if bool is true make the button say "Disable Eye IK" and vice versa
          NVHCommonUI.CoreUI.RenderToggleButton(
            ref navMeshFollowerSetup.eyeIKenabled,
            "Eye IK is enabled, Click to disable",
            "Eye IK is disabled, Click to enable"
          );


          // if eyeIKenabled is true, show the eye bones section
          if (navMeshFollowerSetup.eyeIKenabled)
          {
            // put the following eye ik in a foldout based on the eyeIKsectionShow bool
            NVHCommonUI.CoreUI.RenderFoldoutSection(
              "Eye IK",
              ref navMeshFollowerSetup.eyeIKsectionShow,
              () =>
              {
                setEyeBonesFromNavMeshFollowerBody(navMeshFollowerSetup);
                GUILayout.Space(5);
                NVHCommonUI.CoreUI.RenderToggleButton(
                  ref navMeshFollowerSetup.eyeExoticMode,
                  "Exotic Eye IK is enabled, Click to disable",
                  "Exotic Eye IK is disabled, Click to enable"
                );
                if (navMeshFollowerSetup.eyeExoticMode)
                {
                  //exotic eye setup (more that 2 eyes)
                  setExoticEyeBones(navMeshFollowerSetup);
                }
              },
              foldoutTitleBackgroundColor
            );


            if (!isLeftEyeBoneSet(navMeshFollowerSetup))
            {
              // show error message if left eye bone is not set
              EditorGUILayout.HelpBox(
              "Left eye bone is not set, please set the left eye bone.",
              MessageType.Error
              );
            }
            if (!isRightEyeBoneSet(navMeshFollowerSetup))
            {
              // show error message if right eye bone is not set
              EditorGUILayout.HelpBox(
              "Right eye bone is not set, please set the right eye bone.",
              MessageType.Error
              );
            }
          }
          // show a button to toggle if you want to use the spine IK based on the spineIKenabled bool, if bool is true make the button say "Disable Spine IK" and vice versa
          NVHCommonUI.CoreUI.RenderToggleButton(
            ref navMeshFollowerSetup.spineIKenabled,
            "Spine IK is enabled, Click to disable",
            "Spine IK is disabled, Click to enable"
          );

          // foldout for spine IK section
          if (navMeshFollowerSetup.spineIKenabled)
          {
            NVHCommonUI.CoreUI.RenderFoldoutSection(
              "Spine IK",
              ref navMeshFollowerSetup.spineIKsectionShow,
              () =>
              {
                // show field for spineBones array
                serializedObject.Update();
                EditorGUILayout.PropertyField(serializedObject.FindProperty("spineBones"), true);
                serializedObject.ApplyModifiedProperties();

                // show button to clear spineBones array
                if (GUILayout.Button("Clear all spine bones"))
                {
                  // get the number of bones that exist in the current array
                  int currentBoneCount = navMeshFollowerSetup.spineBones.Length;
                  if (currentBoneCount > 0)
                  {
                  // show warning popup to confirm
                    if (EditorUtility.DisplayDialog("Clear all spine bones", "Are you sure you want to clear all spine bones? \n\nThis will remove the " + currentBoneCount + " current bones from your current list", "Yes", "No"))
                    {
                      // clear spineBones array
                      navMeshFollowerSetup.spineBones = new Transform[0];
                    }
                  }
                  else
                  {
                    // if the current bone count is 0, just clear the array, just to be sure
                    navMeshFollowerSetup.spineBones = new Transform[0];
                  }

                }

                // show button to set spineBones array to default setup, that being Spine, Chest, Upper Chest, Neck in that order
                if (GUILayout.Button("Set spine bones to default"))
                {
                  // get the number of bones that exist in the current array
                  int currentBoneCount = navMeshFollowerSetup.spineBones.Length;

                  // if the current bone count is > 0 show warning popup to confirm
                  if (currentBoneCount > 0)
                  {
                      if (EditorUtility.DisplayDialog("Set spine bones to default", "Are you sure you want to set spine bones to default? \n\nThis will remove the " + currentBoneCount + " current bones from your current list", "Yes", "No"))
                      {
                        // wipe spineBones array
                        navMeshFollowerSetup.spineBones = new Transform[0];
                        setupUIbonesList(navMeshFollowerSetup);
                      }
                  }
                  else
                  {
                    // if the current bone count is 0, just set the default bones
                    setupUIbonesList(navMeshFollowerSetup);
                  }
                }
              },
              foldoutTitleBackgroundColor
            );
          }
          else
          {
            // show warning message if spine IK is disabled, stating that this is not recommended
            EditorGUILayout.HelpBox(
            "Spine IK is disabled, this is not recommended.",
            MessageType.Warning
            );
          }

          if (navMeshFollowerSetup.eyeIKenabled)
          {
            if (!isLeftEyeBoneSet(navMeshFollowerSetup) || !isRightEyeBoneSet(navMeshFollowerSetup))
            {
              // if either eye bone is not set, stop here
              return;
            }
          }

          GUILayout.Space(10);
          RenderAnimatorControl(navMeshFollowerSetup);


          GUILayout.Space(20);
          if (GUILayout.Button("Setup Follower", setupFollowerButtonStyle, GUILayout.Height(setupFollowerButtonHeight)))
          {
            setupLevelTwoFollower(navMeshFollowerSetup, navMeshFollowerSetup.navMeshFollowerBody, scriptRootObject);
          }
        }
        else
        {
          // show button to add the [NavMeshFollower] object under the scriptRootObject
          if (GUILayout.Button("Add NavMeshFollower Config Objects"))
          {
            // if NavMeshAgent object already exists (from level 1), remove it
            GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("NavMeshAgent")?.gameObject;
            if (navMeshFollowerConfigObject != null)
            {
              DestroyImmediate(navMeshFollowerConfigObject);
            }

            // setup for level 2
            GameObject prefabNMLevelTwo = Resources.Load<GameObject>("[NavMeshFollower]-level2");
            GameObject navMeshFollowerConfigObjectLevelTwo = Instantiate(prefabNMLevelTwo);
            navMeshFollowerConfigObjectLevelTwo.name = "[NavMeshFollower]";
            navMeshFollowerConfigObjectLevelTwo.transform.parent = scriptRootObject.transform;
            // zero out position and rotation
            navMeshFollowerConfigObjectLevelTwo.transform.localPosition = Vector3.zero;
            navMeshFollowerConfigObjectLevelTwo.transform.localRotation = Quaternion.identity;
            Debug.Log("Added NavMeshFollower Config Objects");
          }

          // if checkup failed stop here
          return;
        }
      }

      if (navMeshFollowerSetup.followerLevel == 3)
      {

        if (levelThreeFollowerCheckup(scriptRootObject))
        {
          // passed test, show setup options
          setHeadBoneFromnavMeshFollowerBody(navMeshFollowerSetup);

          if (!isHeadBoneSet(navMeshFollowerSetup))
          {
            // if head bone is not set, stop here
            return;
          }

          // setup eye bones
          GUILayout.Space(10);
          // show a button to toggle if you want to use the eye bones based on the eyeIKenabled bool, if bool is true make the button say "Disable Eye IK" and vice versa
          NVHCommonUI.CoreUI.RenderToggleButton(
            ref navMeshFollowerSetup.eyeIKenabled,
            "Eye IK is enabled, Click to disable",
            "Eye IK is disabled, Click to enable"
          );


          // if eyeIKenabled is true, show the eye bones section
          if (navMeshFollowerSetup.eyeIKenabled)
          {
            // put the following eye ik in a foldout based on the eyeIKsectionShow bool
            NVHCommonUI.CoreUI.RenderFoldoutSection(
              "Eye IK",
              ref navMeshFollowerSetup.eyeIKsectionShow,
              () =>
              {
                setEyeBonesFromNavMeshFollowerBody(navMeshFollowerSetup);
                GUILayout.Space(5);
                NVHCommonUI.CoreUI.RenderToggleButton(
                  ref navMeshFollowerSetup.eyeExoticMode,
                  "Exotic Eye IK is enabled, Click to disable",
                  "Exotic Eye IK is disabled, Click to enable"
                );
                if (navMeshFollowerSetup.eyeExoticMode)
                {
                  //exotic eye setup (more that 2 eyes)
                  setExoticEyeBones(navMeshFollowerSetup);
                }
              },
              foldoutTitleBackgroundColor
            );


            if (!isLeftEyeBoneSet(navMeshFollowerSetup))
            {
              // show error message if left eye bone is not set
              EditorGUILayout.HelpBox(
              "Left eye bone is not set, please set the left eye bone.",
              MessageType.Error
              );
            }
            if (!isRightEyeBoneSet(navMeshFollowerSetup))
            {
              // show error message if right eye bone is not set
              EditorGUILayout.HelpBox(
              "Right eye bone is not set, please set the right eye bone.",
              MessageType.Error
              );
            }


          }
          // show a button to toggle if you want to use the spine IK based on the spineIKenabled bool, if bool is true make the button say "Disable Spine IK" and vice versa
          NVHCommonUI.CoreUI.RenderToggleButton(
            ref navMeshFollowerSetup.spineIKenabled,
            "Spine IK is enabled, Click to disable",
            "Spine IK is disabled, Click to enable"
          );
          // foldout for spine IK section
          if (navMeshFollowerSetup.spineIKenabled)
          {
            NVHCommonUI.CoreUI.RenderFoldoutSection(
              "Spine IK",
              ref navMeshFollowerSetup.spineIKsectionShow,
              () =>
              {
                // show field for spineBones array
                serializedObject.Update();
                EditorGUILayout.PropertyField(serializedObject.FindProperty("spineBones"), true);
                serializedObject.ApplyModifiedProperties();

                // show button to clear spineBones array
                if (GUILayout.Button("Clear all spine bones"))
                {
                  // check if spineBones array is null
                  if (navMeshFollowerSetup.spineBones == null)
                  {
                    // spineBones array is null, so just clear it
                    navMeshFollowerSetup.spineBones = new Transform[0];
                  }

                  // get the number of bones that exist in the current array
                  int currentBoneCount = navMeshFollowerSetup.spineBones.Length;
                  if (currentBoneCount > 0)
                  {
                  // show warning popup to confirm
                    if (EditorUtility.DisplayDialog("Clear all spine bones", "Are you sure you want to clear all spine bones? \n\nThis will remove the " + currentBoneCount + " current bones from your current list", "Yes", "No"))
                    {
                      // clear spineBones array
                      navMeshFollowerSetup.spineBones = new Transform[0];
                    }
                  }
                  else
                  {
                    // if the current bone count is 0, just clear the array, just to be sure
                    navMeshFollowerSetup.spineBones = new Transform[0];
                  }

                }

                // show button to set spineBones array to default setup, that being Spine, Chest, Upper Chest, Neck in that order
                if (GUILayout.Button("Set spine bones to default"))
                {
                  // check if spineBones array is null
                  if (navMeshFollowerSetup.spineBones == null)
                  {
                    // spineBones array is null, so just clear it
                    navMeshFollowerSetup.spineBones = new Transform[0];
                  }

                  // get the number of bones that exist in the current array
                  int currentBoneCount = navMeshFollowerSetup.spineBones.Length;

                  // if the current bone count is > 0 show warning popup to confirm
                  if (currentBoneCount > 0)
                  {
                      if (EditorUtility.DisplayDialog("Set spine bones to default", "Are you sure you want to set spine bones to default? \n\nThis will remove the " + currentBoneCount + " current bones from your current list", "Yes", "No"))
                      {
                        // wipe spineBones array
                        navMeshFollowerSetup.spineBones = new Transform[0];
                        setupUIbonesList(navMeshFollowerSetup);
                      }
                  }
                  else
                  {
                    // if the current bone count is 0, just set the default bones
                    setupUIbonesList(navMeshFollowerSetup);
                  }
                }
              },
              foldoutTitleBackgroundColor
            );
          }
          else
          {
            // show warning message if spine IK is disabled, stating that this is not recommended
            EditorGUILayout.HelpBox(
            "Spine IK is disabled, this is not recommended.",
            MessageType.Warning
            );
          }

          if (navMeshFollowerSetup.eyeIKenabled)
          {
            if (!isLeftEyeBoneSet(navMeshFollowerSetup) || !isRightEyeBoneSet(navMeshFollowerSetup))
            {
              // if either eye bone is not set, stop here
              return;
            }
          }

          GUILayout.Space(10);
          bool handIKerror = false;

          // foldout for hand IK section
          NVHCommonUI.CoreUI.RenderFoldoutSection(
            "Hand IK",
            ref navMeshFollowerSetup.handIKsectionShow,
            () =>
            {
            // button to enable/disable left hand IK
            NVHCommonUI.CoreUI.RenderToggleButton(
              ref navMeshFollowerSetup.leftHandIKenabled,
              "Left hand IK is enabled, Click to disable",
              "Left hand IK is disabled, Click to enable"
            );

            if(navMeshFollowerSetup.leftHandIKenabled)
            {
              // foldout for hand IK section
              NVHCommonUI.CoreUI.RenderFoldoutSection(
                "Left Hand IK",
                ref navMeshFollowerSetup.leftHandIKsectionShow,
                () =>
                {
                  setLeftHandFromNavMeshFollowerBody(navMeshFollowerSetup);
                  if (!isLeftHandSet(navMeshFollowerSetup))
                  {
                    // message to say that hand IK is enabled, but either hand is not set
                    EditorGUILayout.HelpBox(
                    "Hand IK is enabled, but left hand is not set.",
                    MessageType.Error
                    );
                  }
                },
                foldoutTitleBackgroundColor
              );
            }

            // gap
            GUILayout.Space(10);

            // button to enable/disable right hand IK
            NVHCommonUI.CoreUI.RenderToggleButton(
              ref navMeshFollowerSetup.rightHandIKenabled,
              "Right hand IK is enabled, Click to disable",
              "Right hand IK is disabled, Click to enable"
            );

            if(navMeshFollowerSetup.rightHandIKenabled)
            {
              // foldout for hand IK section
              NVHCommonUI.CoreUI.RenderFoldoutSection(
                "Right Hand IK",
                ref navMeshFollowerSetup.rightHandIKsectionShow,
                () =>
                {

                  setRightHandFromNavMeshFollowerBody(navMeshFollowerSetup);
                  if (!isRightHandSet(navMeshFollowerSetup))
                  {
                    // message to say that hand IK is enabled, but either hand is not set
                    EditorGUILayout.HelpBox(
                    "Hand IK is enabled, but right hand is not set.",
                    MessageType.Error
                    );
                  }
                },
                foldoutTitleBackgroundColor
              );
            }
          },
          foldoutTitleBackgroundColor
        );


        NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Attachment Points",
          ref navMeshFollowerSetup.showAttachmentPointSection,
          () =>
          {

             // get the object under the scriptRootObject at the path held in the variable NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].left_hand_attach_point_path
              GameObject leftHandAttachmentPoint = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].left_hand_attach_point_path)?.gameObject;

            // get the object under the scriptRootObject at the path held in the variable NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].right_hand_attach_point_path
              GameObject rightHandAttachmentPoint = scriptRootObject.transform.Find(NMFSConfig.follower_level_data[navMeshFollowerSetup.followerLevel].right_hand_attach_point_path)?.gameObject;

            // check if leftHandAttachmentPoint has a LeftHandAttachmentPointGizmo
            if (leftHandAttachmentPoint.GetComponent<LeftHandAttachmentPointGizmo>() == null)
            {
              // if not, add one
              leftHandAttachmentPoint.AddComponent<LeftHandAttachmentPointGizmo>();

              // set the parent_navmesh_follower_setup of the above LeftHandAttachmentPointGizmo to navMeshFollowerSetup
              leftHandAttachmentPoint.GetComponent<LeftHandAttachmentPointGizmo>().parent_navmesh_follower_setup = navMeshFollowerSetup.gameObject;
            }

            // check if rightHandAttachmentPoint has a RightHandAttachmentPointGizmo
            if (rightHandAttachmentPoint.GetComponent<RightHandAttachmentPointGizmo>() == null)
            {
              // if not, add one
              rightHandAttachmentPoint.AddComponent<RightHandAttachmentPointGizmo>();

              // set the parent_navmesh_follower_setup of the above RightHandAttachmentPointGizmo to navMeshFollowerSetup
              rightHandAttachmentPoint.GetComponent<RightHandAttachmentPointGizmo>().parent_navmesh_follower_setup = navMeshFollowerSetup.gameObject;
            }

            // check if the parent constraint component on the left hand attachment point is active

            if(leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive || rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
            {
              // start box
              EditorGUILayout.BeginVertical("Box");
              GUILayout.Space(2);
              // if the parent constraint component on the left hand attachment point is active, show a warning message
              EditorGUILayout.HelpBox(
              "Hand attachment point parent constraint is active, related controls are disabled.",
              MessageType.Info
              );
            }

            if (leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
            {
              // show button to disable the parent constraint component on the left hand attachment point
              if (GUILayout.Button("Disable left hand attachment point parent constraint"))
              {
                // disable the parent constraint component on the left hand attachment point
                leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive = false;
              }
            }

            // check if the parent constraint component on the right hand attachment point is active
            if (rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
            {
              // show button to disable the parent constraint component on the right hand attachment point
              if (GUILayout.Button("Disable right hand attachment point parent constraint"))
              {
                // disable the parent constraint component on the right hand attachment point
                rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive = false;
              }
            }

            if(leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive || rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
            {
              GUILayout.Space(2);
              // end box
              EditorGUILayout.EndVertical();
              GUILayout.Space(5);
            }



            if(navMeshFollowerSetup.leftHandIKenabled)
            {
              // show button to snap left LeftHandAttachmentPoint to left hand
              if(leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
              {
                GUI.enabled = false;
              }
                if (!isLeftHandSet(navMeshFollowerSetup) || !navMeshFollowerSetup.leftHandIKenabled)
                {
                  // disable ui if left hand is not set
                  GUI.enabled = false;
                  if (GUILayout.Button("Snap pickup point to left hand (disabled, left hand not set)"))
                  {
                  }
                  GUI.enabled = true;
                }
                else
                {
                  if (GUILayout.Button("Snap pickup point to left hand"))
                  {

                    // if left hand is set, snap LeftHandAttachmentPoint to left hand
                    snapLeftHandAttachmentPointToHand(navMeshFollowerSetup);
                  }
                }

              // enable ui
              GUI.enabled = true;
            }
            if(navMeshFollowerSetup.rightHandIKenabled)
            {
              // show button to snap RightHandAttachmentPoint to right hand
              if(rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
              {
                GUI.enabled = false;
              }
                if (!isRightHandSet(navMeshFollowerSetup) || !navMeshFollowerSetup.rightHandIKenabled)
                {
                  // disable ui if right hand is not set
                  GUI.enabled = false;
                  if (GUILayout.Button("Snap pickup point to right hand (disabled, right hand not set)"))
                  {
                  }
                  GUI.enabled = true;
                }
                else
                {
                  if (GUILayout.Button("Snap pickup point to right hand"))
                  {
                    // if right hand is set, snap RightHandAttachmentPoint to right hand
                    snapRightHandAttachmentPointToHand(navMeshFollowerSetup);
                  }
                }
              // enable ui
              GUI.enabled = true;
            }

            // start box
            EditorGUILayout.BeginVertical("Box");
            GUILayout.Space(2);

            if(navMeshFollowerSetup.leftHandIKenabled)
            {
              // show button to enable/disable gizmos on LeftHandAttachmentPoint
              NVHCommonUI.CoreUI.RenderToggleButton(
                ref navMeshFollowerSetup.showLeftHandAttachmentPointGizmos,
                "LeftHandAttachmentPoint Gizmos are enabled, Click to disable",
                "LeftHandAttachmentPoint Gizmos are disabled, Click to enable"
              );
            }
            else
            {
              // disable gizmos on LeftHandAttachmentPoint
              navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = false;
            }
            if(navMeshFollowerSetup.rightHandIKenabled)
            {
              // show button to enable/disable gizmos on RightHandAttachmentPoint
              NVHCommonUI.CoreUI.RenderToggleButton(
                ref navMeshFollowerSetup.showRightHandAttachmentPointGizmos,
                "RightHandAttachmentPoint Gizmos are enabled, Click to disable",
                "RightHandAttachmentPoint Gizmos are disabled, Click to enable"
              );
            }
            else
            {
              // disable gizmos on RightHandAttachmentPoint
              navMeshFollowerSetup.showRightHandAttachmentPointGizmos = false;
            }

            if(navMeshFollowerSetup.leftHandIKenabled && navMeshFollowerSetup.rightHandIKenabled)
            {
              // show button to disable gizmos on both LeftHandAttachmentPoint and RightHandAttachmentPoint
              if (GUILayout.Button("Disable all HandAttachmentPoint Gizmos"))
              {
                navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = false;
                navMeshFollowerSetup.showRightHandAttachmentPointGizmos = false;
              }

              // show button to enable gizmos on both LeftHandAttachmentPoint and RightHandAttachmentPoint
              if (GUILayout.Button("Enable all HandAttachmentPoint Gizmos"))
              {
                navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = true;
                navMeshFollowerSetup.showRightHandAttachmentPointGizmos = true;
              }
            }
            GUILayout.Space(2);
            // end box
            EditorGUILayout.EndVertical();

            if(!navMeshFollowerSetup.leftHandIKenabled || navMeshFollowerSetup.leftHand == null)
            {
              // auto collapse foldout section if left hand IK is disabled
              navMeshFollowerSetup.leftHandAttachmentPointPositionAndRotationSectionShow = false;
            }
            else
            {
              // foldout section for LeftHandAttachmentPoint position and rotation settings
              NVHCommonUI.CoreUI.RenderFoldoutSection(
                "LeftHandAttachmentPoint Position and Rotation Settings",
                ref navMeshFollowerSetup.leftHandAttachmentPointPositionAndRotationSectionShow,
                () =>
                {
                  if(leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive || navMeshFollowerSetup.rightHand == null)
                  {
                    GUI.enabled = false;
                  }
                  // show button to mirror position settings from right hand attachment point
                  if (GUILayout.Button("Mirror position settings from right hand attachment point"))
                  {
                    // if right hand attachment point exists, mirror position settings from right hand attachment point
                    if (rightHandAttachmentPoint != null)
                    {
                      // show popup to confirm
                      if (EditorUtility.DisplayDialog("Mirror position settings from right hand attachment point", "Are you sure you want to mirror position settings from right hand attachment point? \n\nThis will mirror the position settings from the right hand attachment point to the left hand attachment point.", "Yes", "No"))
                      {
                        // mirror position settings from right hand attachment point
                        leftHandAttachmentPoint.transform.localPosition = rightHandAttachmentPoint.transform.localPosition;
                        // set the x value to the negative of the current x value
                        leftHandAttachmentPoint.transform.localPosition = new Vector3(-leftHandAttachmentPoint.transform.localPosition.x, leftHandAttachmentPoint.transform.localPosition.y, leftHandAttachmentPoint.transform.localPosition.z);
                      }
                    }
                  }
                  GUI.enabled = true;

                  if(leftHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
                  {
                    GUI.enabled = false;
                  }

                  // gap
                  GUILayout.Space(5);

                  // start box
                  EditorGUILayout.BeginVertical("Box");
                  GUILayout.Space(2);
                  // show a field to set the position of the LeftHandAttachmentPoint
                  leftHandAttachmentPoint.transform.localPosition = EditorGUILayout.Vector3Field("Position", leftHandAttachmentPoint.transform.localPosition);

                  // show filed to set how much pressing the buttons will move the LeftHandAttachmentPoint
                  navMeshFollowerSetup.positionStep = EditorGUILayout.FloatField("Position Step", navMeshFollowerSetup.positionStep);

                  // show a set of buttons to move the leftHandAttachmentPoint up/down, left/right, forward/backward
                  EditorGUILayout.BeginHorizontal();
                  if (GUILayout.Button("Up"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x, leftHandAttachmentPoint.transform.localPosition.y + navMeshFollowerSetup.positionStep, leftHandAttachmentPoint.transform.localPosition.z);
                  }
                  if (GUILayout.Button("Down"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x, leftHandAttachmentPoint.transform.localPosition.y - navMeshFollowerSetup.positionStep, leftHandAttachmentPoint.transform.localPosition.z);
                  }

                  GUILayout.Space(5);
                  if (GUILayout.Button("Left"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x - navMeshFollowerSetup.positionStep, leftHandAttachmentPoint.transform.localPosition.y, leftHandAttachmentPoint.transform.localPosition.z);
                  }
                  if (GUILayout.Button("Right"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x + navMeshFollowerSetup.positionStep, leftHandAttachmentPoint.transform.localPosition.y, leftHandAttachmentPoint.transform.localPosition.z);
                  }

                  GUILayout.Space(5);
                  if (GUILayout.Button("Forward"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x, leftHandAttachmentPoint.transform.localPosition.y, leftHandAttachmentPoint.transform.localPosition.z + navMeshFollowerSetup.positionStep);
                  }
                  if (GUILayout.Button("Backward"))
                  {
                    leftHandAttachmentPoint.transform.localPosition = new Vector3(leftHandAttachmentPoint.transform.localPosition.x, leftHandAttachmentPoint.transform.localPosition.y, leftHandAttachmentPoint.transform.localPosition.z - navMeshFollowerSetup.positionStep);
                  }
                  EditorGUILayout.EndHorizontal();

                  GUILayout.Space(2);
                  // end box
                  EditorGUILayout.EndVertical();

                  // start box
                  EditorGUILayout.BeginVertical("Box");
                  GUILayout.Space(2);
                  // disable gui
                  GUI.enabled = false;
                  // show a field to set the rotation of the LeftHandAttachmentPoint
                  leftHandAttachmentPoint.transform.localRotation = Quaternion.Euler(EditorGUILayout.Vector3Field("Rotation", leftHandAttachmentPoint.transform.localRotation.eulerAngles));
                  // enable gui
                  GUI.enabled = true;
                  //show a message to say that the rotation of the LeftHandAttachmentPoint can only be set directly on the LeftHandAttachmentPoint gameobject
                  EditorGUILayout.HelpBox(
                  "The rotation of the LeftHandAttachmentPoint can only be set directly on the LeftHandAttachmentPoint gameobject.",
                  MessageType.Info
                  );
                  // add button to select the LeftHandAttachmentPoint gameobject
                  if (GUILayout.Button("Select LeftHandAttachmentPoint"))
                  {
                    Selection.activeGameObject = leftHandAttachmentPoint;
                  }
                  GUILayout.Space(2);
                  // end box
                  EditorGUILayout.EndVertical();

                },
                foldoutTitleBackgroundColor
              );
            }

            if(!navMeshFollowerSetup.rightHandIKenabled || navMeshFollowerSetup.rightHand == null)
            {
              // auto collapse foldout section if right hand IK is disabled
              navMeshFollowerSetup.rightHandAttachmentPointPositionAndRotationSectionShow = false;
            }
            else
            {
              // foldout section for RightHandAttachmentPoint position and rotation settings
              NVHCommonUI.CoreUI.RenderFoldoutSection(
                "RightHandAttachmentPoint Position and Rotation Settings",
                ref navMeshFollowerSetup.rightHandAttachmentPointPositionAndRotationSectionShow,
                () =>
                {
                  if(rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive || navMeshFollowerSetup.leftHand == null)
                  {
                    GUI.enabled = false;
                  }
                  // show button to mirror position settings from left hand attachment point
                  if (GUILayout.Button("Mirror position settings from left hand attachment point"))
                  {
                    // if left hand attachment point exists, mirror position settings from left hand attachment point
                    if (leftHandAttachmentPoint != null)
                    {
                      // show popup to confirm
                      if (EditorUtility.DisplayDialog("Mirror position settings from left hand attachment point", "Are you sure you want to mirror position settings from left hand attachment point? \n\nThis will mirror the position settings from the left hand attachment point to the right hand attachment point.", "Yes", "No"))
                      {
                        // mirror position settings from left hand attachment point
                        rightHandAttachmentPoint.transform.localPosition = leftHandAttachmentPoint.transform.localPosition;
                        // set the x value to the negative of the current x value
                        rightHandAttachmentPoint.transform.localPosition = new Vector3(-rightHandAttachmentPoint.transform.localPosition.x, rightHandAttachmentPoint.transform.localPosition.y, rightHandAttachmentPoint.transform.localPosition.z);
                      }
                    }
                  }

                  GUI.enabled = true;
                  if(rightHandAttachmentPoint.GetComponent<ParentConstraint>().constraintActive)
                  {
                    GUI.enabled = false;
                  }

                  // start box
                  EditorGUILayout.BeginVertical("Box");
                  GUILayout.Space(2);
                  // show a field to set the position of the RightHandAttachmentPoint
                  rightHandAttachmentPoint.transform.localPosition = EditorGUILayout.Vector3Field("Position", rightHandAttachmentPoint.transform.localPosition);

                  // show filed to set how much pressing the buttons will move the RightHandAttachmentPoint
                  navMeshFollowerSetup.positionStep = EditorGUILayout.FloatField("Position Step", navMeshFollowerSetup.positionStep);

                  // show a set of buttons to move the RightHandAttachmentPoint up/down, left/right, forward/backward
                  EditorGUILayout.BeginHorizontal();
                  if (GUILayout.Button("Up"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x, rightHandAttachmentPoint.transform.localPosition.y + navMeshFollowerSetup.positionStep, rightHandAttachmentPoint.transform.localPosition.z);
                  }
                  if (GUILayout.Button("Down"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x, rightHandAttachmentPoint.transform.localPosition.y - navMeshFollowerSetup.positionStep, rightHandAttachmentPoint.transform.localPosition.z);
                  }

                  GUILayout.Space(5);
                  if (GUILayout.Button("Left"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x - navMeshFollowerSetup.positionStep, rightHandAttachmentPoint.transform.localPosition.y, rightHandAttachmentPoint.transform.localPosition.z);
                  }
                  if (GUILayout.Button("Right"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x + navMeshFollowerSetup.positionStep, rightHandAttachmentPoint.transform.localPosition.y, rightHandAttachmentPoint.transform.localPosition.z);
                  }

                  GUILayout.Space(5);
                  if (GUILayout.Button("Forward"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x, rightHandAttachmentPoint.transform.localPosition.y, rightHandAttachmentPoint.transform.localPosition.z + navMeshFollowerSetup.positionStep);
                  }
                  if (GUILayout.Button("Backward"))
                  {
                    rightHandAttachmentPoint.transform.localPosition = new Vector3(rightHandAttachmentPoint.transform.localPosition.x, rightHandAttachmentPoint.transform.localPosition.y, rightHandAttachmentPoint.transform.localPosition.z - navMeshFollowerSetup.positionStep);
                  }
                  EditorGUILayout.EndHorizontal();

                  GUILayout.Space(2);
                  // end box
                  EditorGUILayout.EndVertical();

                  // start box
                  EditorGUILayout.BeginVertical("Box");
                  GUILayout.Space(2);
                  // disable gui
                  GUI.enabled = false;
                  // show a field to set the rotation of the RightHandAttachmentPoint
                  rightHandAttachmentPoint.transform.localRotation = Quaternion.Euler(EditorGUILayout.Vector3Field("Rotation", rightHandAttachmentPoint.transform.localRotation.eulerAngles));
                  // enable gui
                  GUI.enabled = true;
                  //show a message to say that the rotation of the RightHandAttachmentPoint can only be set directly on the RightHandAttachmentPoint gameobject
                  EditorGUILayout.HelpBox(
                  "The rotation of the RightHandAttachmentPoint can only be set directly on the RightHandAttachmentPoint gameobject.",
                  MessageType.Info
                  );
                  // add button to select the RightHandAttachmentPoint gameobject
                  if (GUILayout.Button("Select RightHandAttachmentPoint"))
                  {
                    Selection.activeGameObject = rightHandAttachmentPoint;
                  }
                  GUILayout.Space(2);
                  // end box
                  EditorGUILayout.EndVertical();

                },
                foldoutTitleBackgroundColor
              );
            }




          },
          foldoutTitleBackgroundColor
          );

          if (navMeshFollowerSetup.rightHandIKenabled && !isRightHandSet(navMeshFollowerSetup))
          {
            handIKerror = true;
            navMeshFollowerSetup.rightHandIKsectionShow = true;
          }

          if (navMeshFollowerSetup.leftHandIKenabled && !isLeftHandSet(navMeshFollowerSetup))
          {
            handIKerror = true;
            navMeshFollowerSetup.leftHandIKsectionShow = true;
          }

          // if hand IK is enabled, but either hand is not set, stop here
          if (handIKerror)
          {
            navMeshFollowerSetup.handIKsectionShow = true;
            return;
          }





          GUILayout.Space(10);
          RenderAnimatorControl(navMeshFollowerSetup);


          GUILayout.Space(20);
          if (GUILayout.Button("Setup Follower", setupFollowerButtonStyle, GUILayout.Height(setupFollowerButtonHeight)))
          {
            //turn off gizmos
            navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = false;
            navMeshFollowerSetup.showRightHandAttachmentPointGizmos = false;
            // run setup for level 3
            setupLevelThreeFollower(navMeshFollowerSetup, navMeshFollowerSetup.navMeshFollowerBody, scriptRootObject);
          }
        }
        else
        {
          if (GUILayout.Button("Add NavMeshFollower Config Objects"))
          {
            // if NavMeshAgent object already exists (from level 1), remove it
            GameObject navMeshFollowerConfigObject = scriptRootObject.transform.Find("NavMeshAgent")?.gameObject;
            if (navMeshFollowerConfigObject != null)
            {
              DestroyImmediate(navMeshFollowerConfigObject);
            }
            // if [NavMeshFollower] object already exists (from level 2), remove it
            GameObject navMeshAgentLevelTwo = scriptRootObject.transform.Find("[NavMeshFollower]")?.gameObject.transform.Find("NavMeshAgent")?.gameObject;
            if (navMeshAgentLevelTwo != null)
            {
              DestroyImmediate(navMeshAgentLevelTwo);
            }

            // setup for level 3
            GameObject prefabNMLevelThree = Resources.Load<GameObject>("[NavMeshFollower]-level3");
            GameObject navMeshFollowerConfigObjectLevelThree = Instantiate(prefabNMLevelThree);
            navMeshFollowerConfigObjectLevelThree.name = "[NavMeshFollower]";
            navMeshFollowerConfigObjectLevelThree.transform.parent = scriptRootObject.transform;
            // zero out position and rotation
            navMeshFollowerConfigObjectLevelThree.transform.localPosition = Vector3.zero;
            navMeshFollowerConfigObjectLevelThree.transform.localRotation = Quaternion.identity;
            Debug.Log("Added NavMeshFollower Config Objects");
          }
          // if checkup failed stop here
          return;
        }
      }

      // stop #if NVH_COMMON_EXISTS
      #endif
    }


  }
}
