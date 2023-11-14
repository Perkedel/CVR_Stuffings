using System;
using UnityEngine;
using UnityEditor;

public class ProgramGenerator : EditorWindow {
	[MenuItem("Tools / Tholin / 1802 Namebade program generator")]
	public static void ShowWindow() {
		EditorWindow w = GetWindow<ProgramGenerator>(false, "1802 Program Generator", true);
		w.minSize = new Vector2(300, 170);
	}

	Texture2D pgmTex;
	string text;
	string lastError = null;

	public static string alphabet = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,+-?!@:/_*()#";

	private void OnGUI() {
		EditorGUI.BeginChangeCheck();
		pgmTex = (Texture2D)EditorGUILayout.ObjectField("Source Program", pgmTex, typeof(Texture2D), true);
		bool errors = false;
		if(pgmTex != null) {
			string texPath = AssetDatabase.GetAssetPath(pgmTex);
			TextureImporter pgmImporter = (TextureImporter)AssetImporter.GetAtPath(texPath);
			TextureImporterSettings pgmSettings = new TextureImporterSettings();
			TextureImporterFormat pgmFmt = new TextureImporterFormat();
			pgmImporter.ReadTextureSettings(pgmSettings);
			int texSize;
			pgmImporter.GetPlatformTextureSettings("Standalone", out texSize, out pgmFmt);
			if(pgmFmt != TextureImporterFormat.R8) {
				EditorGUILayout.HelpBox("Source texture has wrong format. Needs to be single-channel/R8.", MessageType.Error);
				errors = true;
			}
			if(pgmSettings.filterMode != FilterMode.Point) {
				EditorGUILayout.HelpBox("Source texture has wrong filter mode. Needs to be \"Point\".", MessageType.Error);
				errors = true;
			}
			if(pgmSettings.mipmapEnabled) {
				EditorGUILayout.HelpBox("Source texture has mipmaps enabled. This shouldn’t be.", MessageType.Error);
				errors = true;
			}
			if(pgmImporter.textureCompression != TextureImporterCompression.Uncompressed) {
				EditorGUILayout.HelpBox("Source texture has compression enabled. This will corrupt the program. Disable it.", MessageType.Error);
				errors = true;
			}
			if(pgmImporter.maxTextureSize != 256 || texSize != 256) {
				EditorGUILayout.HelpBox("Source texture has invalid dimensions. MUST be 256x256.", MessageType.Error);
				errors = true;
			}
		}
		if(errors) return;
		text = EditorGUILayout.TextField("Sign text", text);
		if(GUILayout.Button("Generate", GUILayout.Width(100), GUILayout.Height(30))) {
			if(string.IsNullOrWhiteSpace(text)) {
				lastError = "Text is empty.";
				return;
			}
			if(text.Length > 250) {
				lastError = "Text is too long. Must be 250 characters at most.";
				return;
			}

			uint[] textData = new uint[253];
			for(int i = 0; i < text.Length; i++) {
				char c = text[i];
				int idx = -1;
				for(int j = 0; j < alphabet.Length; j++) if(alphabet[j] == c) { idx = j; break; }
				if(idx == -1) {
					lastError = $"Unsupported character '{c}' in sign text.\nAllowed characters are \n[a-z], [A-Z], [0-0] and .,+-?!@:/_*()#";
					return;
				}
				textData[i + 1] = (uint)idx;
			}
			textData[text.Length + 2] = 128;

			int pxy = 0x0200 / 256;
			for(int i = 0; i < textData.Length; i++) {
				pgmTex.SetPixel(i, pxy, new Color((float)textData[i] / 255.0f, 0, 0));
			}

			pgmTex.Apply();
			byte[] texData = pgmTex.EncodeToPNG();
			System.IO.FileStream stream = System.IO.File.Create(AssetDatabase.GetAssetPath(pgmTex));
			stream.Write(texData, 0, texData.Length);
			stream.Dispose();
			AssetDatabase.Refresh();
			lastError = null;
		}
		if(lastError != null) {
			EditorGUILayout.HelpBox(lastError, MessageType.Error);
		}
	}
}
