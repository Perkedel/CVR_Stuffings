 #if UNITY_EDITOR

// Copyright DomNomNom 2023

using System.Collections.Generic;
using System.Linq;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEditor.UIElements;
using UnityEngine.Animations;
using UnityEditor.Animations;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

public class FixShadersRightEye : EditorWindow
{
    private List<ShaderInfo> allShaders = new List<ShaderInfo>();
    private Vector2 scrollPos = Vector2.zero;
    private int progressID;

    [MenuItem("Tools/DomNomNom/FixShadersRightEye")]
    public static void ShowMyEditor() {
      // This method is called when the user selects the menu item in the Editor
      EditorWindow wnd = GetWindow<FixShadersRightEye>();
      wnd.titleContent = new GUIContent("FixShadersRightEye");
    }

    public class ShaderInfo {
        public ShaderInfo() {}
        public string displayName;
        public string path;
        public bool has_been_scanned = false;
        public bool too_complex = false;
        public bool fixable = false;
        public bool completion_marker0 = false;
        public bool completion_marker1 = false;
        public bool completion_marker2 = false;
        public bool completion_marker3 = false;
        public bool upgradeIntroducesErrors = false;
        public bool upgradeChangesSomething = false;
        public bool shouldProcess = false;

        public new string ToString() {
            string prefix = "";
            int completion_markers =
                (completion_marker0? 1 : 0) +
                (completion_marker1? 1 : 0) +
                (completion_marker2? 1 : 0) +
                (completion_marker3? 1 : 0);
            if (!has_been_scanned) {
                prefix = "scanning...";
            } else if (too_complex) {
                prefix = "too difficult";
            } else if (completion_markers == 4) {
                prefix = "Done";
            } else if (!upgradeChangesSomething) {
                prefix = "no change";
            } else {
                prefix = $"{completion_markers}/4";
                // prefix = "needs manual work";
            }
            prefix = $"[{prefix}] ";
            return prefix + displayName;
        }
    }

    public void CreateGUI()
    {
        // Each editor window contains a root VisualElement object
        VisualElement root = rootVisualElement;

        // VisualElements objects can contain other VisualElement following a tree hierarchy.
        VisualElement label = new Label("Select Shaders to upgrade:");
        root.Add(label);

        var scroll = new ScrollView(ScrollViewMode.VerticalAndHorizontal);
        scroll.name = "shaderToggles";
        root.Add(scroll);

        var button_row = new VisualElement();
        button_row.style.flexDirection = FlexDirection.Row;
        {
            Button refresh = new Button();
            refresh.name = refresh.text = "Refresh";
            refresh.RegisterCallback<ClickEvent>(RefreshClicked);
            button_row.Add(refresh);

            Button SelectNone = new Button();
            SelectNone.name = SelectNone.text = "Select None";
            SelectNone.RegisterCallback<ClickEvent>(SelectNoneClicked);
            button_row.Add(SelectNone);

            Button SelectFixable = new Button();
            SelectFixable.name = SelectFixable.text = "Select Fixable";
            SelectFixable.RegisterCallback<ClickEvent>(SelectFixableClicked);
            button_row.Add(SelectFixable);
        }
        root.Add(button_row);

        Button go = new Button();
        go.name = go.text = "Fix Shaders!";
        go.RegisterCallback<ClickEvent>(GoClicked);
        root.Add(go);

        Refresh();
    }

    private void SelectNoneClicked(ClickEvent _) {
        foreach (ShaderInfo s in allShaders) {
            s.shouldProcess = false;
        }
        AllShadersToGUI();
    }
    private void SelectFixableClicked(ClickEvent _) {
        foreach (ShaderInfo s in allShaders) {
            s.shouldProcess = s.fixable;
        }
        AllShadersToGUI();
    }
    private void RefreshClicked(ClickEvent _) {
        Refresh();
    }
    private void GoClicked(ClickEvent _) {
        Go();
        Refresh();
    }
    private void Refresh() {
        allShaders = findAllShaders(new DirectoryInfo("Assets"));
        AllShadersToGUI();
        var _ = Task.Run(ScanShaders);
    }
    private void AllShadersToGUI() {
        var scroll = rootVisualElement.Q<ScrollView>("shaderToggles");
        while (allShaders.Count > scroll.childCount) {
            Toggle toggle = new Toggle();
            toggle.RegisterValueChangedCallback(OnToggleClicked);
            scroll.Add(toggle);
        }
        while (allShaders.Count < scroll.childCount) {
            scroll.Remove(scroll[scroll.childCount-1]);
        }
        // foreach (ShaderInfo s in allShaders) {
        for (int i=0; i<allShaders.Count; i++) {
            ShaderInfo s = allShaders[i];
            Toggle toggle = scroll[i] as Toggle;
            toggle.name = s.displayName;
            toggle.text = s.ToString();
            toggle.value = s.shouldProcess;
        }
    }
    private void OnToggleClicked(ChangeEvent<bool> e) {
        Toggle toggle = e.currentTarget as Toggle;
        int i = toggle.parent.IndexOf(toggle);
        allShaders[i].shouldProcess = toggle.value;
    }


    public void OnInspectorUpdate() {
        // This will only get called 10 times per second.
        // This is so we pick up updates from ScanShaders which is in a different thread.
        AllShadersToGUI();
        // Repaint();
    }

    public const string upgrade_comment = " // inserted by FixShadersRightEye.cs";
    private Regex pragma_vertex_finder = new Regex(@"^\s*#pragma\s+vertex\s+(.*)\b", RegexOptions.Compiled);
    private Regex return_finder = new Regex(@"^\s*return\s+(.*);", RegexOptions.Compiled);
    private Regex indent_finder = new Regex(@"^(\s*)", RegexOptions.Compiled);
    private string getIndent(string s) {
        return indent_finder.Matches(s)[0].Groups[1].Value;
    }
    public string upgradeShader(string path) {
        List<string> lines = File.ReadLines(path).ToList();
        for (int i=0; i<lines.Count; ++i) {
            // note: we assume that "#pragma vert" is above the function and struct declaration

            var vertex_matches = pragma_vertex_finder.Matches(lines[i]);
            if (vertex_matches.Count == 0) continue;
            string vertex_func_name = vertex_matches[0].Groups[1].Value;

            string v2f_struct_type = "";  // usually "v2f"
            string v2f_in_var_name = "";  // usually "v"
            string appdata_type = "";
            Regex v2f_func_finder = new Regex($@"^\s*(.*)\s+{vertex_func_name}\s*\((.+?)\s+(.+?)\b", RegexOptions.Compiled);
            int vert_func_i;
            for (vert_func_i=i; vert_func_i<lines.Count; vert_func_i++) {
                var v2f_func_matches = v2f_func_finder.Matches(lines[vert_func_i]);
                if (v2f_func_matches.Count == 0) continue;
                v2f_struct_type = v2f_func_matches[0].Groups[1].Value;
                appdata_type    = v2f_func_matches[0].Groups[2].Value;
                v2f_in_var_name = v2f_func_matches[0].Groups[3].Value;
                break;
            }
            if (v2f_struct_type == "") continue;
            if (v2f_struct_type == "void") continue; // this seems to be a surface shader that we can't do much about.

            // find the return statement
            int return_i;
            string v2f_out_var_name = ""; // usually "o"
            bool found_UNITY_SETUP_INSTANCE_ID = false;
            bool found_UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO = false;
            for (return_i=vert_func_i+1; return_i < lines.Count; ++return_i) {
                string line = lines[return_i];
                var return_matches = return_finder.Matches(line);
                if (line.Contains("UNITY_SETUP_INSTANCE_ID")) {
                    found_UNITY_SETUP_INSTANCE_ID = true;
                }
                if (line.Contains("UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO")) {
                    found_UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO = true;
                }
                if (return_matches.Count == 0) continue;
                v2f_out_var_name = return_matches[0].Groups[1].Value;
                break;
            }
            if (v2f_out_var_name == "") {
                Debug.LogError($"couldn't find return for vert function in shader: {path}");
                return null;
            }

            // search for the declaration of the return variable.
            // (usually on the first line of the vertex shader function)
            int v2f_declaration_i;
            Regex declaration_finder = new Regex($@"^\s*{v2f_struct_type}\s+{v2f_out_var_name}", RegexOptions.Compiled);
            for (v2f_declaration_i=vert_func_i; v2f_declaration_i<return_i; ++v2f_declaration_i){
                var declaration_matches = declaration_finder.Matches(lines[v2f_declaration_i]);
                if (declaration_matches.Count == 0) continue;
                break;
            }
            if (v2f_declaration_i == return_i) {
                Debug.LogError($"couldn't find declaration '{v2f_struct_type} {v2f_out_var_name}' in shader: {path}");
                return null;
            }
            if (lines[v2f_declaration_i].Contains("{")) {
                // struct initialization is too complex to auto port.
                return null;
            }
            // insert new code there.
            int insert_pos = v2f_declaration_i + 1;
            string indent = getIndent(lines[v2f_declaration_i]);
            if (!found_UNITY_SETUP_INSTANCE_ID) {
                lines.Insert(insert_pos, $"{indent}UNITY_SETUP_INSTANCE_ID({v2f_in_var_name}); {upgrade_comment}");
                insert_pos++;
            }
            if (!found_UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO) {
                lines.Insert(insert_pos, $"{indent}UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO({v2f_out_var_name}); {upgrade_comment}");
                insert_pos++;
            }


            // add UNITY_VERTEX_OUTPUT_STEREO to struct v2f
            int struct_v2f_i;
            Regex struct_v2f_finder = new Regex($@"^\s*struct\s+{v2f_struct_type}");
            for (struct_v2f_i = i; struct_v2f_i<lines.Count; ++struct_v2f_i) {
                if (struct_v2f_finder.Matches(lines[struct_v2f_i]).Count > 0) {
                    break;
                }
            }
            if (struct_v2f_i == lines.Count) {
                Debug.LogWarning($"couldn't find 'struct {v2f_struct_type}' in shader: {path}");
            } else {
                // note: we assume the '{' is on a different line to '}'
                int closing_brace_i;
                bool found_UNITY_VERTEX_OUTPUT_STEREO = false;
                for (closing_brace_i = struct_v2f_i; closing_brace_i<lines.Count; ++closing_brace_i) {
                    if (lines[closing_brace_i].Contains("UNITY_VERTEX_OUTPUT_STEREO")) found_UNITY_VERTEX_OUTPUT_STEREO = true;
                    if (lines[closing_brace_i].Contains("}")) break;
                }
                if (closing_brace_i==lines.Count) {
                    Debug.LogError($"couldn't find end of 'struct {v2f_struct_type}' in shader: {path}");
                } else if (!found_UNITY_VERTEX_OUTPUT_STEREO) {
                    insert_pos = closing_brace_i;
                    indent = getIndent(lines[insert_pos - 1]);
                    lines.Insert(insert_pos, $"{indent}UNITY_VERTEX_OUTPUT_STEREO {upgrade_comment}");
                }
            }

            // add UNITY_VERTEX_INPUT_INSTANCE_ID to appdata
            int struct_appdata_i;
            Regex struct_appdata_finder = new Regex($@"^\s*struct\s+{appdata_type}");
            for (struct_appdata_i = i; struct_appdata_i<lines.Count; ++struct_appdata_i) {
                if (struct_appdata_finder.Matches(lines[struct_appdata_i]).Count > 0) {
                    break;
                }
            }
            if (struct_appdata_i == lines.Count) {
                // might not be neccessary in appdata_full
                // Debug.LogWarning($"couldn't find 'struct {appdata_type}' in shader: {path}");
            } else {
                // note: we assume the '{' is on a different line to '}'
                int closing_brace_i;
                bool found_UNITY_VERTEX_INPUT_INSTANCE_ID = false;
                for (closing_brace_i = struct_appdata_i; closing_brace_i<lines.Count; ++closing_brace_i) {
                    if (lines[closing_brace_i].Contains("UNITY_VERTEX_INPUT_INSTANCE_ID")) found_UNITY_VERTEX_INPUT_INSTANCE_ID = true;
                    if (lines[closing_brace_i].Contains("}")) break;
                }
                if (closing_brace_i==lines.Count) {
                    Debug.LogError($"couldn't find end of 'struct {appdata_type}' in shader: {path}");
                } else if (!found_UNITY_VERTEX_INPUT_INSTANCE_ID) {
                    insert_pos = closing_brace_i;
                    indent = getIndent(lines[insert_pos - 1]);
                    lines.Insert(insert_pos, $"{indent}UNITY_VERTEX_INPUT_INSTANCE_ID {upgrade_comment}");
                }
            }
        }

        string endl = "\r\n";
        return System.String.Join(endl, lines) + endl;
    }

    public List<ShaderInfo> findAllShaders(DirectoryInfo dir) {
        List<ShaderInfo> allShaders = new List<ShaderInfo>();
        foreach (DirectoryInfo d2 in dir.GetDirectories()) {
            allShaders.AddRange(findAllShaders(d2));
        }
        FileInfo[] files = dir.GetFiles("*.shader");
        foreach (FileInfo file in files) {
            ShaderInfo info = new ShaderInfo();
            info.path = ("" + file);
            info.displayName = info.path;
            if (info.displayName.Contains("Assets")) {
                info.displayName = info.displayName.Split("Assets")[1];
                info.displayName = info.displayName.Replace("\\", "/");
                info.displayName = info.displayName.Trim('/');
            }
            allShaders.Add(info);
        }
        return allShaders;

    }

    public async void ScanShaders() {
        int progressID = Progress.Start("Scanning shaders");
        Regex completion_finder = new Regex(@"\b(UNITY_VERTEX_INPUT_INSTANCE_ID)|(UNITY_VERTEX_OUTPUT_STEREO)|(UNITY_SETUP_INSTANCE_ID)|(UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO)\b", RegexOptions.Compiled);
        for (int i=0; i< allShaders.Count; ++i) {
            ShaderInfo s = allShaders[i];
            if (s.has_been_scanned) continue;
            Progress.Report(progressID, i+1, allShaders.Count, "Scanning " + s.displayName);

            try {
                foreach (string line in File.ReadLines(s.path)) {
                    if (completion_finder.Matches(line).Count > 0) {
                        if (line.Contains("UNITY_VERTEX_INPUT_INSTANCE_ID")) s.completion_marker0 = true;
                        if (line.Contains("UNITY_VERTEX_OUTPUT_STEREO")) s.completion_marker1 = true;
                        if (line.Contains("UNITY_SETUP_INSTANCE_ID")) s.completion_marker2 = true;
                        if (line.Contains("UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO")) s.completion_marker3 = true;
                    }
                }

                // Do a dry run of upgrading.
                string unmodifiedCode = File.ReadAllText(s.path);
                string upgradedCode = upgradeShader(s.path);
                s.upgradeChangesSomething = (upgradedCode != null) && (
                    Regex.Replace(unmodifiedCode, @"\r|\n", "") !=
                    Regex.Replace(upgradedCode, @"\r|\n", "")
                );
                if (upgradedCode == null) {
                    s.has_been_scanned = true;
                    s.too_complex = true;
                    continue;
                }
            } catch (System.Exception e) {
                Debug.LogError(e + " on shader: " + s.path);
            }

            if (s.upgradeChangesSomething) {
                s.fixable = true;
                s.shouldProcess = true;
            }
            s.has_been_scanned = true;
            await Task.Delay(10);
        }
        Progress.Remove(progressID);
    }


    public void Go() {
        int progressID = Progress.Start("Fixing shaders");

        for (int i=0; i<allShaders.Count; ++i) {
            ShaderInfo shader = allShaders[i];
            if (!shader.shouldProcess) continue;
            Progress.Report(progressID, i+1, allShaders.Count, "Fixing " + shader.displayName);

            Shader unmodified = ShaderUtil.CreateShaderAsset(File.ReadAllText(shader.path), /*compileInitialShaderVariants*/ false);
            string upgradedCode = upgradeShader(shader.path);
            if (upgradedCode == null) continue; // we expect an error message to be printed already
            Shader upgraded = ShaderUtil.CreateShaderAsset(upgradedCode, /*compileInitialShaderVariants*/ false);

            if (ShaderUtil.GetShaderMessageCount(upgraded) > ShaderUtil.GetShaderMessageCount(unmodified)) {
                Debug.LogError("Upgrading this shader would introduce more errors: " + shader.path);
                continue;
            }
            File.WriteAllText(shader.path, upgradedCode);
        }
        Progress.Remove(progressID);
    }

}
#else
 public class FixShadersRightEye{}
#endif
