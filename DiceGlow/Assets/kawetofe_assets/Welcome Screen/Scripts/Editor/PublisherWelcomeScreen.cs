

using System;
using System.Diagnostics;

using UnityEditor;
using UnityEngine;

using Debug = UnityEngine.Debug;


[InitializeOnLoad]
public class PublisherWelcomeScreen:EditorWindow
{
	private static PublisherWelcomeScreen window;
	private static Vector2 windowsSize = new Vector2(500f, 300f);
	private Vector2 scrollPosition;

	private static string windowHeaderText = "Welcome to kawetofe tools";
	private string copyright = "© Copyright " + DateTime.Now.Year + " kawetofe by Thomas Feichtinger";
	
	private const string isShowAtStartEditorPrefs = "WelcomeScreenShowAtStart";
	private static bool isShowAtStart = true;

	private static bool isInited;

	private static GUIStyle headerStyle;
	private static GUIStyle copyrightStyle;

	private static Texture2D allOurAssetsIcon;
	private static Texture2D docsIcon;
	private static Texture2D youTubeIcon;
	private static Texture2D unityConnectIcon;
	private static Texture2D vkIcon;
	private static Texture2D facebookIcon;
	private static Texture2D supportIcon;
	private static Texture2D instagramIcon;
	private static Texture2D twitterIcon;

	static PublisherWelcomeScreen()
	{
		EditorApplication.update -= GetShowAtStart;
		EditorApplication.update += GetShowAtStart;
	}

	private void OnGUI()
	{
		if (!isInited) 
		{
			Init();
		}
		
		if (GUI.Button(new Rect(0f, 0f, windowsSize.x, 58f), "", headerStyle))
			Process.Start("https://kawetofe.com");

		GUILayoutUtility.GetRect(position.width, 70f);

		scrollPosition = EditorGUILayout.BeginScrollView(scrollPosition);

		if (DrawButton(docsIcon, "Docs", "Online version of the documentation.")) 
			Process.Start("https://www.kawetofe.com/wordpress/docs/");

		if (DrawButton(supportIcon, "Support", "First of all, read the docs. If it didn't help, email us.")) 
			Process.Start("mailto:contact@kawetofe.com Games - Asset Support");

		if (DrawButton(allOurAssetsIcon, "All Assets", "See other assets of kawetofe")) 
			Process.Start("https://assetstore.unity.com/publishers/7625");

		if (DrawButton(youTubeIcon, "YouTube Channel", "Our video materials.")) 
			Process.Start("https://www.youtube.com/channel/UCJV0xtMYg0OPy_moNDOk8hQ");

		if (DrawButton(unityConnectIcon, "Unity Connect", "Main news page in English.")) 
			Process.Start("https://connect.unity.com/u/thomas-feichtinger-1-1-1");

		
		//if (DrawButton(instagramIcon, "Instagram page", "Our photos.")) 
			//Process.Start("https://www.instagram.com/makakaorg/");

		if (DrawButton(twitterIcon, "Twitter page", "Our news page in English.")) 
			Process.Start("https://www.twitter.com/kawetofe/");
		
		EditorGUILayout.EndScrollView();

		EditorGUILayout.LabelField(copyright, copyrightStyle);
	}

	private static bool Init()
	{
		try
		{
			headerStyle = new GUIStyle();
			headerStyle.normal.background = Resources.Load("kawetofe_assets_header") as Texture2D;
			headerStyle.normal.textColor = Color.white;
			headerStyle.fontStyle = FontStyle.Bold;
			headerStyle.padding = new RectOffset(340, 0, 27, 0);
			headerStyle.margin = new RectOffset(0, 0, 0, 0);

			copyrightStyle = new GUIStyle();
			copyrightStyle.alignment = TextAnchor.MiddleRight;

			docsIcon = Resources.Load("Docs") as Texture2D;
			allOurAssetsIcon = Resources.Load("kawetofe_button_01") as Texture2D;
			supportIcon = Resources.Load("Support") as Texture2D;
			youTubeIcon = Resources.Load("YouTube") as Texture2D;
			unityConnectIcon = Resources.Load("UnityConnect") as Texture2D;
			twitterIcon = Resources.Load("Twitter") as Texture2D;
			
			isInited = true; 
		}
		catch (Exception e)
		{
			Debug.Log("WELCOME SCREEN INIT: " + e);
			return false;
		}

		return true;
	}

	private static bool DrawButton(Texture2D icon, string title = "", string description = "")
	{
		EditorGUILayout.BeginHorizontal();

        GUILayout.Space(34f);
        GUILayout.Box(icon, GUIStyle.none, GUILayout.MaxWidth(48f), GUILayout.MaxHeight(48f));
        GUILayout.Space(10f);

        EditorGUILayout.BeginVertical();

		GUILayout.Space(1f);
		GUILayout.Label(title, EditorStyles.boldLabel);
		GUILayout.Label(description);

        EditorGUILayout.EndVertical();

        EditorGUILayout.EndHorizontal();

		Rect rect = GUILayoutUtility.GetLastRect();
		EditorGUIUtility.AddCursorRect(rect, MouseCursor.Link);

		GUILayout.Space(10f);

		return Event.current.type == EventType.MouseDown && rect.Contains(Event.current.mousePosition);
	}


	private static void GetShowAtStart()
	{
		EditorApplication.update -= GetShowAtStart;
		
		isShowAtStart = EditorPrefs.GetBool(isShowAtStartEditorPrefs, true);

		if (isShowAtStart)
		{
			EditorApplication.update -= OpenAtStartup;
			EditorApplication.update += OpenAtStartup;
		}
	}

	private static void OpenAtStartup()
	{
		if (isInited && Init()) 
		{
			OpenWindow();

			EditorApplication.update -= OpenAtStartup;
		}
	}

	[MenuItem("kawetofe tools/Welcome Screen", false)]
	public static void OpenWindow()
	{
		if (window == null) 
		{
			window = GetWindow<PublisherWelcomeScreen> (true, windowHeaderText, true);
			window.maxSize = window.minSize = windowsSize;
		}
	}

	private void OnEnable()
	{
		window = this;
	}

	private void OnDestroy()
	{
		window = null;

		EditorPrefs.SetBool(isShowAtStartEditorPrefs, false);
	}
}