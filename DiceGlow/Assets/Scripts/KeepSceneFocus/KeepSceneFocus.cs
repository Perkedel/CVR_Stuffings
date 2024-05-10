#if UNITY_EDITOR
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using System.Collections;


[InitializeOnLoad]
public class KeepSceneFocus : EditorWindow
{
    public double Version = 1.1;
    public bool Debugging = false;

    [SerializeField]
    public static bool KSFEnable;
    [SerializeField]
    public static bool VRCSDKBypass;
    [SerializeField]
    public static bool CVRCCKBypass;
    [SerializeField]
    private bool Activated;




    //Create a tab at the top of Unity
    [MenuItem("KSF/Keep Scene Focus")]
    public static void Init()
    { 
        //When tab button clicked, launch Window
        GetWindow<KeepSceneFocus>("Keep Scene Focus");
    }


    private void RefreshScript(bool Verbose)
    {
        //Defaults Toggled ON
        GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().KSFEnable = true;
        GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().VRCSDKBypass = true;
        GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().CVRCCKBypass = true;
        Activated = true;
        if (Verbose) Debug.Log("<color=#bb33ff>KSF: </color> Done!");
    }


    //KSF Window:
    void OnGUI()
    {
        GUILayout.Label(Debugging ? "Internal Build v" + Version : "Public Build Beta v" + Version);
        GUILayout.Space(40);

        GUILayout.Label("Press to activate script");

        //Button that creates the GameObject and checks for a duplicate
        if (GUILayout.Button("Create GameObject / Reload"))
        {
            if (GameObject.Find("Keep Scene Focus") == null) //Create GameObject if it doesn't exist
            {
                GameObject KSF = new GameObject("Keep Scene Focus");
                KSF.transform.SetAsFirstSibling(); //make it top of the hierarchy instead of bottom
                KSF.AddComponent<KeepSceneFocusWindow>();
                RefreshScript(true);
                Activated = true;
            }
            else
            {
                //If GameObject exists, but was missing the script component
                if (GameObject.Find("Keep Scene Focus") && GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>() == null)
                {
                    GameObject.Find("Keep Scene Focus").AddComponent<KeepSceneFocusWindow>();
                    RefreshScript(true);
                    Activated = true;
                }

                //Otherwise say "GameObject already exists"
                else 
                {
                    Debug.Log("<color=#bb33ff>KSF: </color><color=orange> GameObject already exists.</color>");

                    Activated = true;
                    //RefreshScript(false);
                    

                }
            }
        }
        
        //On the off chance that the script dissappears from the GameObject, notify in window.
        if (Activated == false)
        {
            GUILayout.Label( (GameObject.Find("Keep Scene Focus") && GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>() == null) ? "!!!GameObject is missing it's script. Activate again!!!" : "GameObject is required in a scene's hierarchy to function");
        }

        //If the GameObject gets renamed or deleted, notify then change variable to avoid errors.
        if (Activated == true && !GameObject.Find("Keep Scene Focus"))
        {
            Debug.Log("<color=#bb33ff>KSF:</color> <color=orange> Was the GameObject renamed or deleted? Ignore this if it was intentional.</color>");
            Activated = false;
        }


        //Check and set variable to notify for borked/vanished script from GameObject (and avoid errors)
        if (Activated== true && (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>() == null))
        {
            Debug.Log("<color=#bb33ff>KSF:</color> <color=orange> Script not found inside the \"Keep Scene Focus\" GameObject. Please open KSF window and press the button again.</color>");
            Activated = false;
        }

        if (Activated == true && GameObject.Find("Keep Scene Focus"))   //Only proceed if button was pressed and GameObject already exists
        {
            
            //Update variables from GameObject
            KSFEnable = (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().KSFEnable);
            VRCSDKBypass = (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().VRCSDKBypass);
            CVRCCKBypass = (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().CVRCCKBypass);
            //Update variables from GameObject


            //Toggles
            GUILayout.Space(40);
            EditorGUILayout.LabelField("Settings:", EditorStyles.label);
            GUILayout.Space(20);

            KSFEnable = EditorGUILayout.Toggle("KSF Toggle", KSFEnable);
            GUILayout.Space(10);

            EditorGUI.BeginDisabledGroup(KSFEnable == false); //If KSF is disabled, Bypass buttons are untouchable
            VRCSDKBypass = EditorGUILayout.Toggle("       VRC SDK Bypass", VRCSDKBypass);
            GUILayout.Space(5);
            CVRCCKBypass = EditorGUILayout.Toggle("       CVR CCK Bypass", CVRCCKBypass);
            EditorGUI.EndDisabledGroup();

            GUILayout.Space(50);

            GUILayout.Label("Hold Shift when you press Play to bypass KSF's scene focus.");

            //Update variables from GUI window
            (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().KSFEnable) = KSFEnable;
            (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().VRCSDKBypass) = VRCSDKBypass;
            (GameObject.Find("Keep Scene Focus").GetComponent<KeepSceneFocusWindow>().CVRCCKBypass) = CVRCCKBypass;
            //Update variables from GUI window
        }
    }
}
#endif

//GameObject Script
public class KeepSceneFocusWindow : MonoBehaviour
{
    [Header("Settings")]
    [SerializeField] //no idea if this actually works or not
    public bool KSFEnable;
    [SerializeField]
    public bool VRCSDKBypass;
    [SerializeField]
    public bool CVRCCKBypass;
    [TextArea(3, 5)]
    public string Info = "Hold Shift when you press Play to allow the Game window be focused instead.";

    private bool DoNotLoop = false;

    private void Update()
    {
        StartCoroutine(DelayedCheck());
    }

    private IEnumerator DelayedCheck()
    {
        if (CVRCCKBypass){ //Unfortunately we need to skip 2 frames with the CCK since it doesn't create the gameobjects until later
        yield return null; //Skip one frame
        yield return null; //Skip one frame
        }

        //Check if Script is enabled by user, if the editor is active and if it's the first loop
        if (KSFEnable && Application.isEditor && !DoNotLoop)
        {
            //Debug.Log("<color=#bb33ff>KSF: </color> KSFEnable Check.");
            DoNotLoop = true;

            //Check if SHIFT was pressed OR if Bypass is enabled AND if VRCSDK/CVRCCK exists in the hierarchy (aka: "Build & Publish" was pressed) to Bypass script
            //If VRCSDK/CVRCCK exists and Bypass is enabled, then bypass this script and write a pretty message to the console
            if (KSFShiftPlayModeEditor.KSFShiftPressed) {Debug.Log("<color=#bb33ff>KSF:</color> Bypassed using Shift.");}
            else if (VRCSDKBypass && GameObject.Find("VRCSDK")!= null) {Debug.Log("<color=#bb33ff>KSF:</color> Bypassed from VRCSDK.");}
            else if (CVRCCKBypass && GameObject.Find("ShotCam for CVR CCK")!= null) {Debug.Log("<color=#bb33ff>KSF:</color> Bypassed from CVRCCK.");}

            else
            {
                //If none of the bypasses exist, then Keep Scene view focused
                #if UNITY_EDITOR
                UnityEditor.SceneView.FocusWindowIfItsOpen(typeof(UnityEditor.SceneView));
                Debug.Log("<color=#bb33ff>KSF:</color> Kept Scene Focus.");
                #endif
            }
        }
    }
}


//Deal with Shift press and PlayMode change while retaining value trough runtime and resetting once left (for later use if I decide to do something with it)
//Duct taped this super quick so it barely works.
[InitializeOnLoad]
public static class KSFShiftPlayModeEditor
{
    private const string KSFShiftPressedKey = "KSF_ShiftPlayMode_ShiftPressed";

    public static bool KSFShiftPressed
    {
        get { return EditorPrefs.GetBool(KSFShiftPressedKey, false); }
        private set { EditorPrefs.SetBool(KSFShiftPressedKey, value); }
    }

    static KSFShiftPlayModeEditor()
    {
        EditorApplication.playModeStateChanged += OnPlayModeStateChanged;
    }

    private static void OnPlayModeStateChanged(PlayModeStateChange state)
    {
        if (state == PlayModeStateChange.ExitingEditMode && Event.current != null && Event.current.shift)
        {
            KSFShiftPressed = true;
            //Debug.Log("KSFShift");
        }

        if (state == PlayModeStateChange.EnteredEditMode)
        {
            KSFShiftPressed = false;
        }
    }
}
#endif

//I love nesting! fite me.

//ToDo:     -refactor to use public bools (set get) with both namespaces
//          -fix to remove the reload button
//          -fix some of the highly specific unity errors when deleting the GameObject