// Version: 1.0.0
using System.IO;
using UnityEngine;
using UnityEditor;
using uk.novavoidhowl.dev.navmeshfollowersetup;

#if NVH_COMMON_EXISTS
  using NVHCommonUI = uk.novavoidhowl.dev.common.ui;
#endif

namespace uk.novavoidhowl.dev.navmeshfollowersetup
{
  public partial class NavMeshFollowerSetupEditor : Editor
  {

    public bool NMFIsConfigFileExists()
    {
      return isConfigFileExists();
    }

    public bool NMFIsConfigFileExistsInPackagesFolder()
    {
      return isConfigFileExistsInPackagesFolder();
    }

    public string NMFGetCommonUIPackageVersion()
    {
      return GetCommonUIPackageVersion();
    }
  }

  public abstract class AttachmentPointGizmoEditor : Editor
  {
    private Color foldoutTitleBackgroundColor = new Color(0.18f, 0.18f, 0.18f, 1.0f);

    protected void OnSceneGUI()
    {
      AttachmentPointGizmo gizmoTarget = (target as AttachmentPointGizmo);

      if (gizmoTarget == null || gizmoTarget.parent_navmesh_follower_setup == null)
      {
        return;
      }

      NavMeshFollowerSetup navMeshFollowerSetup = gizmoTarget.parent_navmesh_follower_setup.GetComponent<NavMeshFollowerSetup>();

      if (navMeshFollowerSetup == null)
      {
        return;
      }

      if (navMeshFollowerSetup.showLeftHandAttachmentPointGizmos && target is LeftHandAttachmentPointGizmo)
      {
        LeftHandAttachmentPointGizmo leftHandAttachmentPointGizmo = (LeftHandAttachmentPointGizmo)target;
        gizmoTarget.DrawHandle(leftHandAttachmentPointGizmo.transform.position, leftHandAttachmentPointGizmo.transform.rotation, leftHandAttachmentPointGizmo.gameObject.name, leftHandAttachmentPointGizmo.transform);
      }

      if (navMeshFollowerSetup.showRightHandAttachmentPointGizmos && target is RightHandAttachmentPointGizmo)
      {
        RightHandAttachmentPointGizmo rightHandAttachmentPointGizmo = (RightHandAttachmentPointGizmo)target;
        gizmoTarget.DrawHandle(rightHandAttachmentPointGizmo.transform.position, rightHandAttachmentPointGizmo.transform.rotation, rightHandAttachmentPointGizmo.gameObject.name, rightHandAttachmentPointGizmo.transform);
      }
    }


    public override void OnInspectorGUI()
    {
      // check is core UI is installed

      NavMeshFollowerSetupEditor NMFSeditor = ScriptableObject.CreateInstance<NavMeshFollowerSetupEditor>();

      if (NMFSeditor.NMFGetCommonUIPackageVersion() == "Not Installed")
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

      // check if this component has a value for parent_navmesh_follower_setup
      if ((target as AttachmentPointGizmo).parent_navmesh_follower_setup == null)
      {
        // show message that no parent_navmesh_follower_setup has been set
        EditorGUILayout.HelpBox("No parent navmesh follower setup has been linked to this component."
                                , MessageType.Warning);

        //show button to remove this component
        if (GUILayout.Button("Remove this component"))
        {
          DestroyImmediate(target);
        }
        NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Advanced Options",
          ref (target as AttachmentPointGizmo).showAdvancedOptions,
          () =>
          {
            // show button to attempt to find the parent_navmesh_follower_setup from the parent object tree
            if (GUILayout.Button("Attempt to find parent navmesh follower setup component"))
            {
              NavMeshFollowerSetup navMeshFollowerSetupHunt = GetNavMeshFollowerSetup((target as Component).transform);
              if (navMeshFollowerSetupHunt != null)
              {
                (target as AttachmentPointGizmo).parent_navmesh_follower_setup = navMeshFollowerSetupHunt.gameObject;
              }
            }
          },
          foldoutTitleBackgroundColor
        );


        return;
      }

      // show message to say that this component is required
      EditorGUILayout.HelpBox("This component is required for the NavMeshFollowerSetup component to work correctly.", MessageType.Info);
      // add gap
      GUILayout.Space(10);

      // show button to select the parent_navmesh_follower_setup gameobject
      if (GUILayout.Button("Select linked navmesh follower setup gameobject"))
      {
        Selection.activeGameObject = (target as AttachmentPointGizmo).parent_navmesh_follower_setup;
      }
      NVHCommonUI.CoreUI.RenderFoldoutSection(
          "Advanced Options",
          ref (target as AttachmentPointGizmo).showAdvancedOptions,
          () =>
          {
            // show button to attempt to find the parent_navmesh_follower_setup from the parent object tree
            if (GUILayout.Button("Re-attempt to find parent navmesh follower setup component"))
            {
              NavMeshFollowerSetup navMeshFollowerSetupHunt = GetNavMeshFollowerSetup((target as Component).transform);
              if (navMeshFollowerSetupHunt != null)
              {
                (target as AttachmentPointGizmo).parent_navmesh_follower_setup = navMeshFollowerSetupHunt.gameObject;
              }
            }

            // show disabled filed for parent_navmesh_follower_setup
            GUI.enabled = false;
            EditorGUILayout.ObjectField("Parent NavMesh Follower Setup", (target as AttachmentPointGizmo).parent_navmesh_follower_setup, typeof(GameObject), true);
            GUI.enabled = true;
          },
          foldoutTitleBackgroundColor
        );

      if((target as AttachmentPointGizmo).showAdvancedOptions)
      {
        // add gap
        GUILayout.Space(10);
      }



      // get the NavMeshFollowerSetup component from the parent_navmesh_follower_setup gameobject
      NavMeshFollowerSetup navMeshFollowerSetup = (target as AttachmentPointGizmo).parent_navmesh_follower_setup.GetComponent<NavMeshFollowerSetup>();


      // show message to say this component is actively showing a gizmo if navMeshFollowerSetup.showLeftHandAttachmentPointGizmos or navMeshFollowerSetup.showRightHandAttachmentPointGizmos is true
      if ((navMeshFollowerSetup.showLeftHandAttachmentPointGizmos && target is LeftHandAttachmentPointGizmo) || (navMeshFollowerSetup.showRightHandAttachmentPointGizmos && target is RightHandAttachmentPointGizmo))
      {
        EditorGUILayout.HelpBox("This component is actively showing a gizmo.", MessageType.Info);

        // show button to hide the gizmo
        if (GUILayout.Button("Hide Gizmo"))
        {
          if (target is LeftHandAttachmentPointGizmo)
          {
            navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = false;
          }
          else if (target is RightHandAttachmentPointGizmo)
          {
            navMeshFollowerSetup.showRightHandAttachmentPointGizmos = false;
          }
        }
      }
      else
      {
        // show button to show the gizmo
        if (GUILayout.Button("Show Gizmo"))
        {
          if (target is LeftHandAttachmentPointGizmo)
          {
            navMeshFollowerSetup.showLeftHandAttachmentPointGizmos = true;
          }
          else if (target is RightHandAttachmentPointGizmo)
          {
            navMeshFollowerSetup.showRightHandAttachmentPointGizmos = true;
          }
        }
      }
    }

    // Function to check if a parent object has a NavMeshFollowerSetup component and if so return it
    protected NavMeshFollowerSetup GetNavMeshFollowerSetup(Transform transform)
    {
      NavMeshFollowerSetup navMeshFollowerSetup = null;
      Transform parent = transform.parent;
      while (parent != null)
      {
        navMeshFollowerSetup = parent.GetComponent<NavMeshFollowerSetup>();
        if (navMeshFollowerSetup != null)
        {
          break;
        }
        parent = parent.parent;
      }
      return navMeshFollowerSetup;
    }



  }

  [CustomEditor(typeof(LeftHandAttachmentPointGizmo))]
  public class LeftHandAttachmentPointGizmoEditor : AttachmentPointGizmoEditor
  {
    private void OnDrawGizmos()
    {
      AttachmentPointGizmo gizmoTarget = (target as AttachmentPointGizmo);
      if (gizmoTarget != null)
      {
        gizmoTarget.DrawGizmo();
      }
    }
  }

  [CustomEditor(typeof(RightHandAttachmentPointGizmo))]
  public class RightHandAttachmentPointGizmoEditor : AttachmentPointGizmoEditor
  {
    private void OnDrawGizmos()
    {
      AttachmentPointGizmo gizmoTarget = (target as AttachmentPointGizmo);
        if (gizmoTarget != null)
        {
          gizmoTarget.DrawGizmo();
        }
    }
  }
}
