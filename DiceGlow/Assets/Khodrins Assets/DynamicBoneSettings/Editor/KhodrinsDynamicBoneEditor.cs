using UnityEditor;
using UnityEngine;
using KhodrinsAssets.Tools;
using System.IO;
using UnityEditor.SceneManagement;
using System;
using UnityEditor.Callbacks;
using UnityEditor.Experimental.AssetImporters;

[CustomEditor(typeof(DynamicBone))]
public class KhodrinsDynamicBoneEditor : Editor
{
    private static bool showTools = false;
    private static Animator animator = null;

    public override void OnInspectorGUI()
    {
        DynamicBone db = (DynamicBone)target;

        showTools = EditorGUILayout.Foldout(showTools, "Khodrins Dynamic Bone Tools");

        if (showTools)
        {
            if(animator != null && animator.gameObject != db.gameObject && !db.transform.IsChildOf(animator.transform))
            {
                animator = null;
            }

            if (animator == null)
            {
                animator = db.gameObject.GetComponentInParent(typeof(Animator)) as Animator;
            }

            animator = (Animator)EditorGUILayout.ObjectField("Avatar Animator", animator, typeof(Animator), true);
            EditorGUILayout.LabelField("This is needed For errorchecking and the transfer functions.");
            EditorGUILayout.LabelField("Plase set to the correct value if not detected correctly.");

            if (!animator.isHuman)
            {
                EditorGUILayout.HelpBox("Your Avatar is not setup as Humanoid", MessageType.Error);
            }

            if (db.m_Colliders != null)
            {
                foreach (var collider in db.m_Colliders)
                {
                    if (collider == null) continue;
                    var boneSettingsCollider = new KhodrinsDynamicBoneSettingsCollider();

                    if (collider.GetType().Name == "DynamicBonePlaneCollider")
                    {
                        boneSettingsCollider.getCollider((DynamicBoneCollider)collider, animator);
                    }
                    else
                    {
                        boneSettingsCollider.getCollider((DynamicBoneCollider)collider, animator);
                    }

                    if (boneSettingsCollider.bone.getTransform(animator) == null)
                    {
                        EditorGUILayout.HelpBox("One or more of your colliders seem not to be on a bone that is part of the humanoid rig. They may not be imported correctly.", MessageType.Warning);
                        break;
                    }
                }
            }

            if (db.m_Exclusions != null)
            {
                foreach (var exclusion in db.m_Exclusions)
                {
                    if (exclusion == null) continue;
                    var boneType = KhodrinsDynamicBoneSettings.getBone(exclusion, animator);

                    if (boneType == HumanBodyBones.LastBone)
                    {
                        EditorGUILayout.HelpBox("One or more of your exclusions seem not to be on a bone that is part of the humanoid rig. They may not be imported correctly.", MessageType.Warning);
                        break;
                    }
                }
            }

            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.BeginVertical();

            if (GUILayout.Button("Copy config"))
            {
                KhodrinsDynamicBoneSettings dbs = new KhodrinsDynamicBoneSettings();
                dbs.getSettings(db, animator);
                EditorGUIUtility.systemCopyBuffer = JsonUtility.ToJson(dbs);
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.BeginVertical();

            if (GUILayout.Button("Paste config"))
            {
                KhodrinsDynamicBoneSettings dbs = (KhodrinsDynamicBoneSettings)JsonUtility.FromJson(EditorGUIUtility.systemCopyBuffer, typeof(KhodrinsDynamicBoneSettings));
                dbs.setSettings(db, animator);
                EditorUtility.SetDirty(db.gameObject);
                EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.BeginVertical();

            if (GUILayout.Button("Save config"))
            {
                KhodrinsDynamicBoneSettings dbs = new KhodrinsDynamicBoneSettings();
                dbs.getSettings(db, animator);

                var path = EditorUtility.SaveFilePanel(
                    "Save Dynamic Bone Settings",
                    "",
                    animator.gameObject.name + "_" + db.m_Root.gameObject.name + ".dbs",
                    "dbs"
                );
                if (path != "")
                {
                    File.WriteAllText(path, JsonUtility.ToJson(dbs));
                }
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.BeginVertical();

            if (GUILayout.Button("Load config"))
            {
                var path = EditorUtility.OpenFilePanel("Select Dynamic Bone Settings", "", "dbs");
                if (path != "")
                {
                    KhodrinsDynamicBoneSettings dbs = (KhodrinsDynamicBoneSettings)JsonUtility.FromJson(File.ReadAllText(path), typeof(KhodrinsDynamicBoneSettings));
                    dbs.setSettings(db, animator);
                    EditorUtility.SetDirty(db.gameObject);
                    EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
                }
            }

            EditorGUILayout.EndVertical();
            EditorGUILayout.EndHorizontal();
        }

        //Error Checking
        if(db.m_Root == null)
        {
            EditorGUILayout.HelpBox("No Root Transform selected!", MessageType.Error);
        }

        if (animator != null)
        {

            if (db.m_Colliders != null)
            {
                foreach (var collider in db.m_Colliders)
                {
                    if (collider != null && !collider.transform.IsChildOf(animator.transform))
                    {
                        EditorGUILayout.HelpBox("One or more of your colliders seem to be not part of your avatar!", MessageType.Warning);
                        break;
                    }
                }
            }

            if (db.m_Exclusions != null)
            {
                foreach (var exclusion in db.m_Exclusions)
                {
                    if (exclusion != null && db.m_Root != null && !exclusion.IsChildOf(db.m_Root))
                    {
                        EditorGUILayout.HelpBox("One or more of your exclusion seem to be not a child of your root Bone!", MessageType.Error);
                        break;
                    }
                }
            }

        }

        EditorGUILayout.Separator();

        DrawDefaultInspector();
    }
}

class KhodrinsDynamicBoneEditorWindow : EditorWindow
{
    private Animator animator;
    private Vector2 scrollPos;

    private KhodrinsDynamicBoneSettingsGroup settingsGroup = null;

    private string saveName;
    private string saveDescription;

    private Vector3 importScale;
    
    private static string EDITORFOLDER = "/Khodrins Assets/DynamicBoneSettings/";

    [MenuItem("Window/Khodrins Tools/Dynamic Bone Manager")]
    public static void ShowWindow()
    {
        EditorWindow.GetWindow(typeof(KhodrinsDynamicBoneEditorWindow));
    }

    public void LoadFromFile(string filePath)
    {
        settingsGroup = (KhodrinsDynamicBoneSettingsGroup)JsonUtility.FromJson(File.ReadAllText(filePath), typeof(KhodrinsDynamicBoneSettingsGroup));
        importScale = Vector3.one;
    }

    public void SetSettings(KhodrinsDynamicBoneSettingsGroup settings)
    {
        settingsGroup = settings;
    }

    void OnGUI()
    {
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos);
        
        Texture2D logo = (Texture2D)AssetDatabase.LoadAssetAtPath ("Assets"+EDITORFOLDER+"Logo-Khodrin-dynamicbone-tools.png", typeof(Texture2D));
        GUI.DrawTexture (GUILayoutUtility.GetRect (300,100), logo, ScaleMode.ScaleToFit);

        animator = (Animator)EditorGUILayout.ObjectField("Avatar Animator", animator, typeof(Animator), true);

        if(settingsGroup != null && settingsGroup.list.Count > 0 && animator == null)
        {
            EditorGUILayout.HelpBox("Settings file loaded please select Avatar Animator to continue.", MessageType.Info);
        }

        if (animator != null)
        {
            if(GUILayout.Button("Open Settings File"))
            {
                var path = EditorUtility.OpenFilePanel("Select Dynamic Bone Settings Group", "", "dbsg");
                if (path != "")
                {
                    LoadFromFile(path);
                }
            }

            DynamicBone[] dynamicBones = animator.gameObject.GetComponentsInChildren<DynamicBone>();

            if (settingsGroup != null && settingsGroup.list.Count > 0)
            {
                EditorGUILayout.LabelField("Settings loaded for inport:");
                EditorGUILayout.LabelField(settingsGroup.name);
                GUILayout.Label(settingsGroup.description);

                EditorGUILayout.LabelField("DynamicBones included in file: " + settingsGroup.list.Count);

                for(int i = 0; i < settingsGroup.list.Count; i++)
                {
                    EditorGUILayout.LabelField("DynamicBones #" + (i+1) + ":");

                    settingsGroup.list[i].placement.transformOverride =
                        (Transform)EditorGUILayout.ObjectField("    Placement:", 
                        settingsGroup.list[i].placement.getTransform(animator), typeof(Transform), true);

                    if (settingsGroup.list[i].placement.getTransform(animator) == null && settingsGroup.list[i].placement.name != "")
                    {
                        EditorGUILayout.HelpBox("Placement gameobject could not be relocated. Expected was a gameobject with name \"" + 
                            settingsGroup.list[i].placement.name + "\". If left blank the component will be placed on the root gameobject.", MessageType.Warning);
                    }

                    settingsGroup.list[i].m_Root.transformOverride = 
                        (Transform)EditorGUILayout.ObjectField("    Root:", 
                        settingsGroup.list[i].m_Root.getTransform(animator), typeof(Transform), true);

                    if (settingsGroup.list[i].m_Root.getTransform(animator) == null && settingsGroup.list[i].m_Root.name != "")
                    {
                        EditorGUILayout.HelpBox("Root gameobject could not be relocated. Expected was a gameobject with name \"" +
                            settingsGroup.list[i].m_Root.name + "\". If left blank the component will not work correctly.", MessageType.Error);
                    }

                    EditorGUILayout.LabelField("    Colliders:" + settingsGroup.list[i].m_Colliders.Count);

                    for (int j = 0; j < settingsGroup.list[i].m_Colliders.Count; j++)
                    {
                        settingsGroup.list[i].m_Colliders[j].bone.transformOverride =
                        (Transform)EditorGUILayout.ObjectField("        Collider #" + (j+1) + ":", 
                        settingsGroup.list[i].m_Colliders[j].bone.getTransform(animator), typeof(Transform), true);

                        if(settingsGroup.list[i].m_Colliders[j].bone.getTransform(animator) == null && settingsGroup.list[i].m_Colliders[j].bone.name != "")
                        {
                            EditorGUILayout.HelpBox("Collider gameobject could not be relocated. Expected was a gameobject with name \"" +
                            settingsGroup.list[i].m_Colliders[j].bone.name + "\". If left blank the Collider will not be imported.", MessageType.Error);
                        }
                    }

                    EditorGUILayout.LabelField("    Exclusions:" + settingsGroup.list[i].m_Colliders.Count);

                    for (int j = 0; j < settingsGroup.list[i].m_Exclusions.Count; j++)
                    {
                        settingsGroup.list[i].m_Exclusions[j].transformOverride =
                        (Transform)EditorGUILayout.ObjectField("        Exclusion #" + (j + 1) + ":",
                        settingsGroup.list[i].m_Exclusions[j].getTransform(animator), typeof(Transform), true);

                        if (settingsGroup.list[i].m_Exclusions[j].getTransform(animator) == null && settingsGroup.list[i].m_Exclusions[j].name != "")
                        {
                            EditorGUILayout.HelpBox("Exclusion gameobject could not be relocated. Expected was a gameobject with name \"" +
                            settingsGroup.list[i].m_Exclusions[j].name + "\". If left blank the Collider will not be imported.", MessageType.Error);
                        }
                    }

                    settingsGroup.list[i].m_ReferenceObject.transformOverride =
                        (Transform)EditorGUILayout.ObjectField("    Reference:",
                        settingsGroup.list[i].m_ReferenceObject.getTransform(animator), typeof(Transform), true);

                    if (settingsGroup.list[i].m_ReferenceObject.getTransform(animator) == null && settingsGroup.list[i].m_ReferenceObject.name != "")
                    {
                        EditorGUILayout.HelpBox("Reference gameobject could not be relocated. Expected was a gameobject with name \"" +
                            settingsGroup.list[i].m_ReferenceObject.name + "\". If left blank the Reference will not be imported.", MessageType.Error);
                    }
                }

                importScale = EditorGUILayout.Vector3Field("Import Scale: ", importScale);
                EditorGUILayout.HelpBox("This Option can be used To fix inconsistent Avatar Scaligns. It will scale radii and offsets of bones and collider", 
                    MessageType.Info);

                if (GUILayout.Button("Cancel Import"))
                {
                    settingsGroup = null;
                }

                if (GUILayout.Button("Apply Settings"))
                {
                    foreach(var setting in settingsGroup.list)
                    {
                        var transform = setting.placement.getTransform(animator);
                        if (transform != null)
                        {
                            var db = transform.gameObject.AddComponent<DynamicBone>();
                            setting.setSettings(db, animator, importScale);
                        }
                    }

                    settingsGroup = null;
                }
            }
            else if(dynamicBones.Length > 0)
            { 
                EditorGUILayout.LabelField("DynamicBones found an avatar: " + dynamicBones.Length);

                int i = 1;

                foreach (var dynamicBone in dynamicBones)
                {
                    EditorGUILayout.LabelField("DynamicBones #" + i + " found component on: " + dynamicBone.gameObject.name);
                    i++;

                    if (dynamicBone.m_Root == null)
                    {
                        EditorGUILayout.LabelField("    Root: None");
                    }
                    else
                    {
                        EditorGUILayout.LabelField("    Root: " + dynamicBone.m_Root.gameObject.name);
                    }

                    EditorGUILayout.LabelField("    Found colliders: " + dynamicBone.m_Colliders.Count);

                    foreach (var collider in dynamicBone.m_Colliders)
                    {
                        if (collider == null)
                        {
                            EditorGUILayout.LabelField("        None");
                        }
                        else
                        {
                            EditorGUILayout.LabelField("        " + collider.gameObject.name);
                        }
                    }

                    EditorGUILayout.LabelField("    Found exclusions: " + dynamicBone.m_Exclusions.Count);

                    foreach (var exclusion in dynamicBone.m_Exclusions)
                    {
                        if (exclusion == null)
                        {
                            EditorGUILayout.LabelField("        None");
                        }
                        else
                        {
                            EditorGUILayout.LabelField("        " + exclusion.gameObject.name);
                        }
                    }

                    if (dynamicBone.m_ReferenceObject == null)
                    {
                        EditorGUILayout.LabelField("    Reference Object: None");
                    }
                    else
                    {
                        EditorGUILayout.LabelField("    Reference Object: " + dynamicBone.m_ReferenceObject.gameObject.name);
                    }
                }

                EditorGUILayout.LabelField("Export settings:");
                saveName = EditorGUILayout.TextField("Name:", saveName);
                EditorGUILayout.LabelField("Description:");
                saveDescription = EditorGUILayout.TextArea(saveDescription);

                if (GUILayout.Button("Export DynamicBone settings"))
                {
                    var settingsGroup = new KhodrinsDynamicBoneSettingsGroup();
                    settingsGroup.name = saveName;
                    settingsGroup.description = saveDescription;

                    foreach (var dynamicBone in dynamicBones)
                    {
                        var settings = new KhodrinsDynamicBoneSettings();
                        settings.getSettings(dynamicBone, animator);
                        settingsGroup.list.Add(settings);
                    }

                    var path = EditorUtility.SaveFilePanel(
                        "Save Dynamic Bone Settings Group",
                        "",
                        settingsGroup.name + ".dbsg",
                        "dbsg"
                    );
                    if (path != "")
                    {
                        File.WriteAllText(path, JsonUtility.ToJson(settingsGroup));
                    }
                }

                if (GUILayout.Button("Remove all DynamicBone Components"))
                {
                    bool confirm = EditorUtility.DisplayDialog("Confirm delete", "Are you sure you want to delete all DaynamicBone components from the avatar \""+
                        animator.transform.name+"\"?", "Yes", "No");

                    if (confirm)
                    {
                        for(i = 0; i < dynamicBones.Length; i++)
                        {
                            DestroyImmediate(dynamicBones[i]);
                        }
                        
                        DynamicBoneCollider[] dynamicBonesCollider = animator.gameObject.GetComponentsInChildren<DynamicBoneCollider>();
                        DynamicBonePlaneCollider[] dynamicBonePlaneCollider = animator.gameObject.GetComponentsInChildren<DynamicBonePlaneCollider>();
                        
                        for(i = 0; i < dynamicBonesCollider.Length; i++)
                        {
                            DestroyImmediate(dynamicBonesCollider[i]);
                        }
                        
                        for(i = 0; i < dynamicBonePlaneCollider.Length; i++)
                        {
                            DestroyImmediate(dynamicBonePlaneCollider[i]);
                        }
                    }
                }

            }

        }

        EditorGUILayout.EndScrollView();
    }
}

class KhodrinsDynamicBoneAssetHandler
{
    [OnOpenAssetAttribute(1)]
    public static bool step1(int instanceID, int line)
    {
        var assetObject = EditorUtility.InstanceIDToObject(instanceID);
        var path = AssetDatabase.GetAssetPath(assetObject);

        if(Path.GetExtension(path) == ".dbsg")
        {
            var window = (KhodrinsDynamicBoneEditorWindow)EditorWindow.GetWindow(typeof(KhodrinsDynamicBoneEditorWindow));
            window.LoadFromFile(Path.GetFullPath(path));

            return true;
        }

        return false;
    }
}

[CustomEditor(typeof(DefaultAsset))]
public class KhodrinsDynamicBoneAssetEditor : Editor
{
    AssetImporter _importer;
    bool _validFile;
    String assetPath;

    private void OnEnable()
    {
        assetPath = AssetDatabase.GetAssetPath(target);
        
        if (assetPath.EndsWith(".dbsg"))
        {
            _importer = AssetImporter.GetAtPath(assetPath);

            _validFile = true;
        }
    }

    protected override void OnHeaderGUI()
    {
        base.OnHeaderGUI();
        
        if (_validFile)
        {
            DBSGInspectorGUI();
        }
    }

    private void DBSGInspectorGUI()
    {
        EditorGUILayout.HelpBox("To import press the open button.", MessageType.Info);

        KhodrinsDynamicBoneSettingsGroup settingsGroup = 
            (KhodrinsDynamicBoneSettingsGroup)JsonUtility.FromJson(File.ReadAllText(assetPath), typeof(KhodrinsDynamicBoneSettingsGroup));

        EditorGUILayout.LabelField("Name: "+ settingsGroup.name);
        EditorGUILayout.LabelField("Description:");
        GUILayout.Label(settingsGroup.description);

        EditorGUILayout.LabelField("DynamicBones included in file: " + settingsGroup.list.Count);

        for (int i = 0; i < settingsGroup.list.Count; i++)
        {
            EditorGUILayout.LabelField("DynamicBones #" + (i + 1) + ":");

            EditorGUILayout.LabelField("    Placement:" + settingsGroup.list[i].placement.name);

            EditorGUILayout.LabelField("    Root:" + settingsGroup.list[i].m_Root.name);

            EditorGUILayout.LabelField("    Colliders:" + settingsGroup.list[i].m_Colliders.Count);

            for (int j = 0; j < settingsGroup.list[i].m_Colliders.Count; j++)
            {
                EditorGUILayout.LabelField("        Collider #" + (j + 1) + ":" + settingsGroup.list[i].m_Colliders[j].bone.name);

            }

            EditorGUILayout.LabelField("    Exclusions:" + settingsGroup.list[i].m_Colliders.Count);

            for (int j = 0; j < settingsGroup.list[i].m_Exclusions.Count; j++)
            {
                EditorGUILayout.LabelField("        Exclusion #" + (j + 1) + ":" + settingsGroup.list[i].m_Exclusions[j].name);
            }

            EditorGUILayout.LabelField("    Reference:" + settingsGroup.list[i].m_ReferenceObject.name);
        }
    }
}