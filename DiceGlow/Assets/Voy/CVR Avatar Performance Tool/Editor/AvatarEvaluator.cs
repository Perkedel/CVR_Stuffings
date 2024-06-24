#if UNITY_EDITOR
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Animations;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Profiling;
using UnityEngine.SceneManagement;
#if CVR_CCK_EXISTS
using ABI.CCK.Components;
#endif

namespace Voy.AvatarHelpers {
    public class AvatarEvaluator : EditorWindow
    {
        public const string VERSION = "1.1.0";
        public const string VERSIONBASED = "By VoyVivika Based on Thry's Avatar Evaluator v1.3.6";

        public static readonly string[] BUILTINSHADERS = {
            "Mobile/Particles/Additive",
            "Mobile/Particles/Alpha Blended",
            "Mobile/Particles/Multiply",
            "Mobile/Particles/VertexLit Blended",
            "Mobile/Bumped Diffuse",
            "Mobile/Bumped Specular",
            "Mobile/Bumped Specular (1 Directional Realtime Light)",
            "Mobile/Diffuse",
            "Mobile/Skybox",
            "Mobile/Unlit (Supports Lightmap)",
            "Mobile/VertexLit",
            "Mobile/VertexLit (Only Directional Lights)",
            "Nature/Terrain/Diffuse",
            "Nature/Terrain/Specular",
            "Nature/Terrain/Standard",
            "Nature/SpeedTree",
            "Nature/SpeedTree Billboard",
            "Nature/SpeedTree8",
            "Nature/Tree Creator Bark",
            "Nature/Tree Creator Leaves",
            "Nature/Tree Creator Leaves Fast",
            "Nature/Tree Soft Occlusion Bark",
            "Nature/Tree Soft Occlusion Leaves",
            "UI/Lit/Bumped",
            "UI/Lit/Detail",
            "UI/Lit/Refration",
            "UI/Lit/Refration Detail",
            "UI/Lit/Transparent",
            "UI/Unlit/Detail",
            "UI/Unlit/Text",
            "UI/Unlit/Text Detail",
            "UI/Unlit/Transparent",
            "UI/Default",
            "UI/Default Font",
            "UI/DefaultETC1",
            "VR/SpatialMapping/Occlusion",
            "VR/SpatialMapping/Wireframe",
            "FX/Flare",
            "GUI/Text Shader",
            "Particles/Standard Surface",
            "Particles/Standard Unlit",
            "Skybox/6 Sided",
            "Skybox/Cubemap",
            "Skybox/Panoramic",
            "Skybox/Procedural",
            "Sprites/Default",
            "Sprites/Diffuse",
            "Sprites/Mask",
            "Unlit/Color",
            "Unlit/ProfileAnalyzerShader",
            "Unlit/Texture",
            "Unlit/Transparent",
            "Unlit/Transparent Cutout",
            "Autodesk Interactive",
            "Standard",
            "Standard (Specular setup)",
            "Legacy Shaders/Bumped Diffuse",
            "Legacy Shaders/Bumped Specular",
            "Legacy Shaders/Decal",
            "Legacy Shaders/Diffuse",
            "Legacy Shaders/Diffuse Detail",
            "Legacy Shaders/Diffuse Fast",
            "Legacy Shaders/Lightmapped/Bumped Diffuse",
            "Legacy Shaders/Lightmapped/Bumped Specular",
            "Legacy Shaders/Lightmapped/Diffuse",
            "Legacy Shaders/Lightmapped/Specular",
            "Legacy Shaders/Lightmapped/VertexLit",
            "Legacy Shaders/Parallax Diffuse",
            "Legacy Shaders/Parallax Specular",
            "Legacy Shaders/Particles/~Additive-Multiply",
            "Legacy Shaders/Particles/Additive",
            "Legacy Shaders/Particles/Additive (Soft)",
            "Legacy Shaders/Particles/Alpha Blended",
            "Legacy Shaders/Particles/Alpha Blended Premultiply",
            "Legacy Shaders/Particles/Anim Alpha Blended",
            "Legacy Shaders/Particles/Multiply",
            "Legacy Shaders/Particles/Multiply (Double)",
            "Legacy Shaders/Particles/VertexLit Blended",
            "Legacy Shaders/Reflective/Bumped Diffuse",
            "Legacy Shaders/Reflective/Bumped Specular",
            "Legacy Shaders/Reflective/Bumped Unlit",
            "Legacy Shaders/Reflective/Bumped VertexLit",
            "Legacy Shaders/Reflective/Diffuse",
            "Legacy Shaders/Reflective/Parallax Diffuse",
            "Legacy Shaders/Reflective/Parallax Specular",
            "Legacy Shaders/Reflective/Specular",
            "Legacy Shaders/Reflective/VertexLit",
            "Legacy Shaders/Self-Illumin/Bumped Diffuse",
            "Legacy Shaders/Self-Illumin/Bumped Specular",
            "Legacy Shaders/Self-Illumin/Diffuse",
            "Legacy Shaders/Self-Illumin/Parallax Diffuse",
            "Legacy Shaders/Self-Illumin/Parallax Specular",
            "Legacy Shaders/Self-Illumin/Specular",
            "Legacy Shaders/Self-Illumin/VertexLit",
            "Legacy Shaders/Specular",
            "Legacy Shaders/Transparent/Bumped Diffuse",
            "Legacy Shaders/Transparent/Bumped Specular",
            "Legacy Shaders/Transparent/Cutout/Bumped Diffuse",
            "Legacy Shaders/Transparent/Cutout/Bumped Specular",
            "Legacy Shaders/Transparent/Cutout/Diffuse",
            "Legacy Shaders/Transparent/Cutout/Soft Edge Unlit",
            "Legacy Shaders/Transparent/Cutout/Specular",
            "Legacy Shaders/Transparent/Cutout/VertexLit",
            "Legacy Shaders/Transparent/Diffuse",
            "Legacy Shaders/Transparent/Parallax Diffuse",
            "Legacy Shaders/Transparent/Parallax Specular",
            "Legacy Shaders/Transparent/Specular",
            "Legacy Shaders/Transparent/VertexLit",
            "VertexLit"

        };

        [MenuItem("Voy/Avatar/Avatar Evaluator")]
        static void Init()
        {
            AvatarEvaluator window = (AvatarEvaluator)EditorWindow.GetWindow(typeof(AvatarEvaluator));
            window.titleContent = new GUIContent("Avatar Evaluation");
            window.Show();
        }

        [MenuItem("GameObject/Voy/Avatar/CVR Avatar Evaluator", true, 0)]
        static bool CanShowFromSelection() => Selection.activeGameObject != null;

        [MenuItem("GameObject/Voy/Avatar/CVR Avatar Evaluator", false, 0)]
        public static void ShowFromSelection()
        {
            AvatarEvaluator window = (AvatarEvaluator)EditorWindow.GetWindow(typeof(AvatarEvaluator));
            window.titleContent = new GUIContent("Avatar Calculator");
            window._avatar = Selection.activeGameObject;
            window.Show();
        }

        GUIContent refreshIcon;

        //ui variables
        GameObject _avatar;
        bool _writeDefaultsFoldout;
        bool _emptyStatesFoldout;
        Vector2 _scrollPosition;

        //eval variables
        long _vramSize = 0;

        int _grabpassCount = 0;
        bool _grabpassFoldout = false;

        (SkinnedMeshRenderer renderer, int verticies, int blendshapeCount)[] _skinendMeshesWithBlendshapes;
        long _totalBlendshapeVerticies = 0;
        bool _blendshapeFoldout;

        int _anyStateTransitions = 0;
        bool _anyStateFoldout = false;

        int _layerCount = 0;
        bool _layerCountFoldout = false;

        int _materialSlotCount = 0;
        int _materialSlotActiveCount = 0;
        bool _materialCountFoldout = false;

        Shader[] _shadersWithGrabpass;

        bool _shaderSPSIFoldout = false;
        Shader[] _shadersWithSPSI;
        Shader[] _shadersWithoutSPSI;
        Material[] _materialsWithoutSPSI;
        int _nonSPSIShaderCount = 0;
        int _nonSPSIMaterialCount = 0;

        //write defaults
        bool _writeDefault;
        string[] _writeDefaultoutliers;

        string[] _emptyStates;

        //mesh shenanigans
        int gameobjectsWithMeshes = 0;
        Renderer[] meshRenderers;

        private void OnEnable() {
            refreshIcon = EditorGUIUtility.IconContent("RotateTool On", "Recalculate");
            if (_avatar != null) Evaluate();
        }

        private void OnGUI()
        {
            EditorGUILayout.Space();
            EditorGUILayout.LabelField($"<size=20><color=magenta>CVR Avatar Evaluator</color></size> v{VERSION}", new GUIStyle(EditorStyles.label) { richText = true, alignment = TextAnchor.MiddleCenter });
            EditorGUILayout.LabelField(VERSIONBASED, EditorStyles.centeredGreyMiniLabel);
            if (GUILayout.Button("Based on work by Thryrallo, Click here to follow them on twitter", EditorStyles.centeredGreyMiniLabel))
                Application.OpenURL("https://twitter.com/thryrallo");
            EditorGUILayout.Space();
            if (GUILayout.Button("Edited by VoyVivika for CVR CCK Compatibility, Click here to visit my Linktree!", EditorStyles.centeredGreyMiniLabel))
                Application.OpenURL("https://linktr.ee/voyvivika");

            _scrollPosition = EditorGUILayout.BeginScrollView(_scrollPosition);

            EditorGUILayout.LabelField("Input", EditorStyles.boldLabel);
            EditorGUI.BeginChangeCheck();
            using (new EditorGUILayout.HorizontalScope())
            {
                GUI.enabled = _avatar != null;
                if(GUILayout.Button(refreshIcon, GUILayout.Width(30), GUILayout.Height(30))) {
                    Evaluate();
                }
                GUI.enabled = true;

                _avatar = (GameObject)EditorGUILayout.ObjectField(GUIContent.none, _avatar, typeof(GameObject), true, GUILayout.Height(30));
                if (EditorGUI.EndChangeCheck() && _avatar != null) {
                    Evaluate();
                }

            }

            if (_avatar == null)
            {
#if CVR_CCK_EXISTS
                IEnumerable<CVRAvatar> avatars = new List<CVRAvatar>();
                for(int i=0;i<EditorSceneManager.sceneCount;i++)

                    avatars = avatars.Concat( EditorSceneManager.GetSceneAt(i).GetRootGameObjects().SelectMany(r => r.GetComponentsInChildren<CVRAvatar>()).Where( d => d.gameObject.activeInHierarchy) );
                if(avatars.Count() > 0)
                {
                    _avatar = avatars.First().gameObject;
                    Evaluate();
                }
#endif
            }

            if (_avatar != null)
            {
                if (_shadersWithGrabpass == null) Evaluate();
                if (_skinendMeshesWithBlendshapes == null) Evaluate();
                EditorGUILayout.Space();
                DrawLine(1);
                //VRAM

                if(DrawSection("VRAM", ToMebiByteString(_vramSize), false))
                    TextureVRAM.Init(_avatar);

                Rect r;

                // Material count
                _materialCountFoldout = DrawSection("Material Slots",
                    _materialSlotCount.ToString() + " (" + _materialSlotActiveCount.ToString() + " Active in Scene)"
                    , _materialCountFoldout);
                if (_materialCountFoldout)
                {

                    DrawMaterialSlots();

                }

                _shaderSPSIFoldout = DrawSection("Non-SPSI Shaders", _nonSPSIShaderCount.ToString(), _shaderSPSIFoldout);
                if (_shaderSPSIFoldout)
                {

                    DrawSPSIFoldout();

                }

                //Grabpasses
                _grabpassFoldout = DrawSection("Grabpasses", _grabpassCount.ToString(), _grabpassFoldout);
                if(_grabpassFoldout)
                {
                    DrawGrabpassFoldout();
                }
                //Blendshapes
                _blendshapeFoldout = DrawSection("Blendshapes", _totalBlendshapeVerticies.ToString(), _blendshapeFoldout);
                if(_blendshapeFoldout)
                {
                    DrawBlendshapeFoldout();
                }

                // Any states
                _anyStateFoldout = DrawSection("Any State Transitions", _anyStateTransitions.ToString(), _anyStateFoldout);
                if(_anyStateFoldout)
                {
                    using(new DetailsFoldout("For each any state transition the conditons are checked every frame. " +
                        "This makes them expensive compared to normal transitions and a large number of them can seriously impact the CPU usage. A healty limit is around 50 transitions."))
                        {

                        }
                }

                // Layer count
                _layerCountFoldout = DrawSection("Layer Count", _layerCount.ToString(), _layerCountFoldout);
                if(_layerCountFoldout)
                {
                    using(new DetailsFoldout("The more layers you have the more expensive the animator is to run. " +
                        "Animators run on the CPU and while lots of things are multithreaded in CVR lower-end PCs might suffer, " +
                        "aim to keep this low."))
                        {

                        }
                }

                EditorGUILayout.Space();
                DrawLine(1);

                //Write defaults
                r = GUILayoutUtility.GetRect(new GUIContent(), EditorStyles.boldLabel);
                GUI.Label(r, "Write Defaults: ", EditorStyles.boldLabel);
                r.x += 140;
                GUI.Label(r, "" + _writeDefault);
                EditorGUILayout.HelpBox("Unity needs all the states in your animator to have the same write default value: Either all off or all on. "+
                    "If a state is marked with write defaults it means that the values animated by this state will be set to their default values when not in this state. " +
                    "This can be useful to make compact toggles, but is very prohibiting when making more complex systems." +
                    "Click here for more information on animator states.", MessageType.None);
                if (Event.current.type == EventType.MouseDown && GUILayoutUtility.GetLastRect().Contains(Event.current.mousePosition))
                    Application.OpenURL("https://docs.unity3d.com/Manual/class-State.html");
                if (_writeDefaultoutliers.Length > 0)
                {
                    EditorGUILayout.HelpBox("Not all of your states have the same write default value.", MessageType.Warning);
                    _writeDefaultsFoldout = EditorGUILayout.BeginFoldoutHeaderGroup(_writeDefaultsFoldout, "Outliers", EditorStyles.foldout);
                    if (_writeDefaultsFoldout)
                    {
                        foreach (string s in _writeDefaultoutliers)
                            EditorGUILayout.LabelField(s);
                    }
                    EditorGUILayout.EndFoldoutHeaderGroup();
                }

                EditorGUILayout.Space();
                DrawLine(1);

                //Empty states
                r = GUILayoutUtility.GetRect(new GUIContent(), EditorStyles.boldLabel);
                GUI.Label(r, "Empty States: ", EditorStyles.boldLabel);
                r.x += 140;
                GUI.Label(r, "" + _emptyStates.Length);
                if (_emptyStates.Length > 0)
                {
                    EditorGUILayout.HelpBox("Some of your states do not have a motion. This might cause issues. " +
                        "You can place an empty animation clip in them to prevent this.", MessageType.Warning);
                    _emptyStatesFoldout = EditorGUILayout.BeginFoldoutHeaderGroup(_emptyStatesFoldout, "Outliers", EditorStyles.foldout);
                    if (_emptyStatesFoldout)
                    {
                        foreach (string s in _emptyStates)
                            EditorGUILayout.LabelField(s);
                    }
                    EditorGUILayout.EndFoldoutHeaderGroup();
                }
            }
            EditorGUILayout.EndScrollView();
        }

        bool DrawSection(string header, string value, bool foldout)
        {
            EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField($"{header}:", EditorStyles.boldLabel, GUILayout.Width(150));
                EditorGUILayout.LabelField(value, GUILayout.Width(200));
                GUILayout.FlexibleSpace();
                if(GUILayout.Button(foldout ? "Hide Details" : "Show Details", GUILayout.Width(150)))
                {
                    foldout = !foldout;
                }
            EditorGUILayout.EndHorizontal();
            return foldout;
        }

        class DetailsFoldout : GUI.Scope
        {
            public DetailsFoldout(string info)
            {
                GUILayout.BeginHorizontal();
                GUILayout.Space(30);
                GUILayout.BeginVertical();
                if (string.IsNullOrWhiteSpace(info) == false)
                    EditorGUILayout.HelpBox(info, MessageType.Info);
                EditorGUILayout.Space();
            }

            protected override void CloseScope()
            {
                GUILayout.EndVertical();
                GUILayout.EndHorizontal();
            }
        }

        class GUILayoutIndent : GUI.Scope
        {
            public GUILayoutIndent(int indent)
            {
                GUILayout.BeginHorizontal();
                GUILayout.Space(indent * 15);
                GUILayout.BeginVertical();
            }

            protected override void CloseScope()
            {
                GUILayout.EndHorizontal();
            }
        }

        void DrawSPSIFoldout()
        {
            using (new DetailsFoldout("ChilloutVR uses Single-Pass Stereo Instanced Rendering (SPSI or SPS-I) in VR Mode. The Shaders you" +
                " use on your Avatar need to support this, if not the Avatar will not Appear in the Right Eye (except in Mirrors). " +
                "it is Highly Advised you either Fix This or Choose a Different Shader."))
            {

                EditorGUILayout.HelpBox("This list may not be Entirely Accurate. Please be mindful of that.", MessageType.Info);

                IEnumerable<Material> materials = GetMaterials(_avatar)[1];

                switch (_nonSPSIShaderCount) 
                {
                    case 0:
                        break;
                    case 1:
                        EditorGUILayout.HelpBox("One Material may not be SPS-I Compatible. It may not Look Right in VR! Please use a different Shader for that Material!", MessageType.Warning);
                        break;
                    case > 1:
                        EditorGUILayout.HelpBox("More than One Material may not be SPS-I Compatible. They may not Look Right in VR! Please use a different Shader for those Materials!", MessageType.Warning);
                        break;
                }

                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();

                    EditorGUILayout.LabelField("Material");
                    EditorGUILayout.LabelField("Shader");

                EditorGUILayout.EndHorizontal();

                foreach (Material material in materials)
                {
                    Shader shader = material.shader;

                    if (_shadersWithoutSPSI.Contains(shader))
                    { 
                        EditorGUILayout.BeginHorizontal();

                        EditorGUILayout.ObjectField(material, typeof(Material), true);

                        EditorGUILayout.ObjectField(shader, typeof(Shader), true);

                        EditorGUILayout.EndHorizontal();
                    }

                }

                /*
                foreach (Shader shader in _shadersWithoutSPSI)
                {
                    
                    EditorGUILayout.BeginHorizontal();

                    EditorGUILayout.ObjectField(shader, typeof(Shader), true);

                    EditorGUILayout.EndHorizontal();
                    

                }
                */
            }



        }

        void DrawMaterialSlots()
        {
            using (new DetailsFoldout("For each material slot you have on your Avatar your CPU needs to call on your " +
                "GPU to draw it (draw calls). The more this needs to be done the more time it takes for your Avatar to Render. " +
                "For this reason you should try to keep this low."))
            {
                EditorGUILayout.HelpBox("Material Swaps don't change the material slot count.", MessageType.Info);

                switch (_nonSPSIShaderCount) 
                {
                    case 0:
                        break;
                    case 1:
                        EditorGUILayout.HelpBox("One Material may not be SPSI Compatible. It may not Look Right in VR! Please use a different Shader for that Material!", MessageType.Warning);
                        break;
                    case > 1:
                        EditorGUILayout.HelpBox("More than One Material may not be SPSI Compatible. They may not Look Right in VR! Please use a different Shader for those Materials!", MessageType.Warning);
                        break;
                }

                if (16 < _materialSlotCount && 32 > _materialSlotCount)
                {
                    EditorGUILayout.HelpBox(" Your Material Count is Higher than 16 " +
                        "(" + _materialSlotCount.ToString() +
                        "), this won't prevent you from uploading but it is getting a little high.", MessageType.Warning);
                }

                else if (_materialSlotCount > 32)
                {
                    EditorGUILayout.HelpBox(" Your Material Count is Higher than 32 " +
                        "(" + _materialSlotCount.ToString() +
                        "), this won't prevent you from uploading but it is very high!", MessageType.Error);
                }

                EditorGUILayout.Space();

                EditorGUILayout.BeginHorizontal();

                    EditorGUILayout.LabelField("Mesh Renderers");
                    EditorGUILayout.LabelField("Material Slots");
                    EditorGUILayout.LabelField("Non-SPSI Materials");

                EditorGUILayout.EndHorizontal();

                foreach (Renderer renderer in meshRenderers)
                {
                    if (renderer == null)
                    {
                        EditorGUILayout.LabelField("Missing or Deleted. Please Refresh.");
                        continue;
                    }

                    EditorGUILayout.BeginHorizontal();

                    
                    EditorGUILayout.ObjectField(renderer, typeof(Renderer), true);

                    int loc_matCount = renderer.sharedMaterials.Count(); 
                    string matOrMats = " Materials";
                    if (loc_matCount == 1) matOrMats = " Material";
                    EditorGUILayout.LabelField("=> " + loc_matCount.ToString() + matOrMats);

                    int nonSPSIcount = 0;

                    foreach (Material mat in renderer.sharedMaterials)
                    {

                        if (_shadersWithoutSPSI.Contains(mat.shader))
                        {

                            nonSPSIcount += 1;

                        }

                    }

                    EditorGUILayout.LabelField(nonSPSIcount.ToString());

                    EditorGUILayout.EndHorizontal();
                }
            }
        }

        void DrawGrabpassFoldout()
        {
            using(new DetailsFoldout("Grabpasses are very expensive. They save your whole screen at a certain point in the rendering process to use it as a texture in the shader."))
            {
                if (_grabpassCount > 0)
                {
                    foreach (Shader s in _shadersWithGrabpass)
                        EditorGUILayout.ObjectField(s, typeof(Shader), false);
                }
            }
        }

        void DrawBlendshapeFoldout()
        {
            using(new DetailsFoldout("The performance impact of blendshapes grows linearly with polygon count. The general consensus is that above 32,000 triangles splitting your mesh will improve performance." +
                    " Click here for more information on blendshapes from the VRChat Documentation."))
            {
                if(Event.current.type == EventType.MouseDown && GUILayoutUtility.GetLastRect().Contains(Event.current.mousePosition))
                    Application.OpenURL("https://docs.vrchat.com/docs/avatar-optimizing-tips#-except-when-youre-using-shapekeys");

                    EditorGUILayout.BeginHorizontal(GUI.skin.box);
                            EditorGUILayout.LabelField("Blendshape Triangles: ", _totalBlendshapeVerticies.ToString());    
                    EditorGUILayout.EndHorizontal();
                    EditorGUILayout.BeginHorizontal(GUI.skin.box);
                            EditorGUILayout.LabelField("#Meshes: ", _skinendMeshesWithBlendshapes.Length.ToString());    
                    EditorGUILayout.EndHorizontal();

                EditorGUILayout.Space();

                if (_skinendMeshesWithBlendshapes.Count() > 0 && _skinendMeshesWithBlendshapes.First().Item2 > 32000)
                    EditorGUILayout.HelpBox($"Consider splitting \"{_skinendMeshesWithBlendshapes.First().Item1.name}\" into multiple meshes where only one has blendshapes. " +
                        $"This will reduce the amount polygons actively affected by blendshapes.", MessageType.Error);

                EditorGUILayout.Space();

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Skinned Mesh Renderer");
                EditorGUILayout.LabelField("Affected Triangles");
                EditorGUILayout.EndHorizontal();
                foreach ((SkinnedMeshRenderer, int, int) mesh in _skinendMeshesWithBlendshapes)
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.ObjectField(mesh.Item1, typeof(SkinnedMeshRenderer), true);
                    EditorGUILayout.LabelField($"=> {mesh.Item2} triangles.");
                    EditorGUILayout.EndHorizontal();
                }
            }
        }
        
        void DrawLine(int i_height)
        {
            Rect rect = EditorGUILayout.GetControlRect(false, i_height);
            rect.height = i_height;
            EditorGUI.DrawRect(rect, new Color(0.5f, 0.5f, 0.5f, 1));
        }

        Renderer[] GetRenderers(GameObject avatar)
        {
            Renderer[] rend = avatar.GetComponentsInChildren<Renderer>(true).Where(r => r.gameObject.GetComponentsInParent<Transform>(true).All(g => g.tag != "EditorOnly")).OrderByDescending(c => c.sharedMaterials.Count()).ToArray();
            
            return rend;
        }

        void Evaluate()
        {
            _vramSize = TextureVRAM.QuickCalc(_avatar);
            IEnumerable<Material> materials = GetMaterials(_avatar)[1];
            _materialSlotCount = GetMaterialSlotCount(_avatar)[0]; //GetMaterials(_avatar)[2].Count();
            _materialSlotActiveCount = GetMaterialSlotCount(_avatar)[1]; //GetMaterials(_avatar)[0].Count();
            meshRenderers = GetRenderers(_avatar);
            IEnumerable<Shader> shaders = materials.Where(m => m!= null && m.shader != null).Select(m => m.shader).Distinct();
            _shadersWithGrabpass = shaders.Where(s => File.Exists(AssetDatabase.GetAssetPath(s)) &&  Regex.Match(File.ReadAllText(AssetDatabase.GetAssetPath(s)), @"GrabPass\s*{\s*""(\w|_)+""\s+}").Success ).ToArray();
            _grabpassCount = _shadersWithGrabpass.Count();
            IEnumerable<Shader> nonBuiltinShaders = shaders.Where(s => !BUILTINSHADERS.Contains(s.name)).Distinct();

            /*Shader[] nonBuiltinShaders = { };

            foreach (Shader shader in shaders)
            {
                if (!BUILTINSHADERS.Contains(shader.name))
                {
                    nonBuiltinShaders.Append(shader);
                }
            }*/

            _shadersWithSPSI = nonBuiltinShaders.Where(s => File.Exists(AssetDatabase.GetAssetPath(s)) && (Regex.Match(File.ReadAllText(AssetDatabase.GetAssetPath(s)), @"UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO\([^)]*\)").Success || Regex.Match(File.ReadAllText(AssetDatabase.GetAssetPath(s)), @"UNITY_INITIALIZE_OUTPUT\( [A-Za-z]+, [A-Za-z]+ \)").Success) || Regex.Match(File.ReadAllText(AssetDatabase.GetAssetPath(s)), @"UNITY_INSTANCING_BUFFER_START\([^)]*\)").Success ).ToArray();
            _shadersWithoutSPSI = nonBuiltinShaders.Except(_shadersWithSPSI).ToArray();
            _nonSPSIShaderCount = _shadersWithoutSPSI.Count();
            _materialsWithoutSPSI = materials.Where(m => !_shadersWithoutSPSI.Contains(m.shader)).ToArray();
            _nonSPSIMaterialCount = _materialsWithoutSPSI.Count();

#if CVR_CCK_EXISTS
            CVRAvatar descriptor = _avatar.GetComponent<CVRAvatar>();

            AnimatorController controller = UnityEditor.AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(descriptor.overrides.runtimeAnimatorController));

            IEnumerable<AnimatorControllerLayer> layers = controller.layers.Where(l => l != null);
            IEnumerable<AnimatorStateMachine> statesMachines = layers.Select(l => l.stateMachine).Where(s => s != null);
            _anyStateTransitions = statesMachines.SelectMany(l => l.anyStateTransitions).Count();
            IEnumerable<(AnimatorState,string)> states = statesMachines.SelectMany(m => m.states.Select(s => (s.state, m.name+"/"+s.state.name)));

            _emptyStates = states.Where(s => s.Item1.motion == null).Select(s => s.Item2).ToArray();

            IEnumerable<(AnimatorState, string)> wdOn = states.Where(s => s.Item1.writeDefaultValues);
            IEnumerable<(AnimatorState, string)> wdOff = states.Where(s => !s.Item1.writeDefaultValues);
            _writeDefault = wdOn.Count() >= wdOff.Count();
            if (_writeDefault) _writeDefaultoutliers = wdOff.Select(s => s.Item2).ToArray();
            else _writeDefaultoutliers = wdOn.Select(s => s.Item2).ToArray();

            _layerCount = layers.Count();
#endif

            _skinendMeshesWithBlendshapes =  _avatar.GetComponentsInChildren<SkinnedMeshRenderer>(true).Where(r => r.sharedMesh != null && r.sharedMesh.blendShapeCount > 0).Select(r => (r, r.sharedMesh.triangles.Length / 3, r.sharedMesh.blendShapeCount)).OrderByDescending(i => i.Item2).ToArray();
            _totalBlendshapeVerticies = _skinendMeshesWithBlendshapes.Sum(i => i.verticies);
        }

        public int[] GetMaterialSlotCount(GameObject avatar)
        {

            Renderer[] allBuiltRenderers = avatar.GetComponentsInChildren<Renderer>(true).Where(r => r.gameObject.GetComponentsInParent<Transform>(true).All(g => g.tag != "EditorOnly")).ToArray();
            int[] materialSlots = {0, 0};
            foreach (Renderer renderer in allBuiltRenderers)
            {
                foreach (Material material in renderer.sharedMaterials)
                {

                    materialSlots[0] += 1;
                    if (renderer.enabled && renderer.gameObject.activeInHierarchy) materialSlots[1] += 1;

                }
            }

            return materialSlots;

        }

        public static IEnumerable<Material>[] GetMaterials(GameObject avatar)
        {
            IEnumerable<Renderer> allBuiltRenderers = avatar.GetComponentsInChildren<Renderer>(true).Where(r => r.gameObject.GetComponentsInParent<Transform>(true).All(g => g.tag != "EditorOnly"));

            List<Material> materialsActive = allBuiltRenderers.Where(r => r.gameObject.activeInHierarchy).SelectMany(r => r.sharedMaterials).ToList();
            List<Material> materialsAll = allBuiltRenderers.SelectMany(r => r.sharedMaterials).ToList();
            //Doing this just cause I need the true number of materials in the scene without the clip count.
            //It'd probably be better to do this not in here... too bad.
            List<Material> materialsTotal = allBuiltRenderers.SelectMany(r => r.sharedMaterials).ToList();

#if CVR_CCK_EXISTS
            //animation materials
            CVRAvatar descriptor = avatar.GetComponent<CVRAvatar>();

            if (descriptor != null)
            {
                AnimatorController controller = UnityEditor.AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetDatabase.GetAssetPath(descriptor.overrides.runtimeAnimatorController));

                IEnumerable<AnimationClip> clips = controller.animationClips.Distinct();
                foreach (AnimationClip clip in clips)
                {
                    IEnumerable<Material> clipMaterials = AnimationUtility.GetObjectReferenceCurveBindings(clip).Where(b => b.isPPtrCurve && b.type.IsSubclassOf(typeof(Renderer)) && b.propertyName.StartsWith("m_Materials"))
                        .SelectMany(b => AnimationUtility.GetObjectReferenceCurve(clip, b)).Select(r => r.value as Material);
                    materialsAll.AddRange(clipMaterials);
                }
            }

#endif
            return new IEnumerable<Material>[] { materialsActive.Distinct(), materialsAll.Distinct(), materialsTotal.Distinct() };
        }

        public static string ToByteString(long l)
        {
            if (l < 1000) return l + " B";
            if (l < 1000000) return (l / 1000f).ToString("n2") + " KB";
            if (l < 1000000000) return (l / 1000000f).ToString("n2") + " MB";
            else return (l / 1000000000f).ToString("n2") + " GB";
        }

        public static string ToMebiByteString(long l)
        {
            if (l < Math.Pow(2, 10)) return l + " B";
            if (l < Math.Pow(2, 20)) return (l / Math.Pow(2, 10)).ToString("n2") + " KiB";
            if (l < Math.Pow(2, 30)) return (l / Math.Pow(2, 20)).ToString("n2") + " MiB";
            else return (l / Math.Pow(2, 30)).ToString("n2") + " GiB";
        }

        public static string ToShortMebiByteString(long l)
        {
            if (l < Math.Pow(2, 10)) return l + " B";
            if (l < Math.Pow(2, 20)) return (l / Math.Pow(2, 10)).ToString("n0") + " KiB";
            if (l < Math.Pow(2, 30)) return (l / Math.Pow(2, 20)).ToString("n1") + " MiB";
            else return (l / Math.Pow(2, 30)).ToString("n1") + " GiB";
        }
    }
}
#endif
