#if UNITY_EDITOR

using UnityEngine;
using UnityEditor;

public class FuralityShaderUI : ShaderGUI
{
    //Set variables
    private Texture2D logoImage;
    private bool showMainProperties;
    MaterialEditor editor;
    MaterialProperty[] properties;
    Material target;

    //Shader locations
    Shader defaultOpaque = Shader.Find("Furality/Sylva Shader/Sylva Opaque Outline");
    Shader defaultCutout = Shader.Find("Furality/Sylva Shader/Sylva Cutout Outline");
    Shader defaultTransparent = Shader.Find("Furality/Sylva Shader/Sylva Transparent Outline");
    Shader noOutlineOpaque = Shader.Find("Furality/Sylva Shader/Sylva Opaque");
    Shader noOutlineCutout = Shader.Find("Furality/Sylva Shader/Sylva Cutout");
    Shader noOutlineTransparent = Shader.Find("Furality/Sylva Shader/Sylva Transparent");

    bool enableOutline;

    //Enums
    enum Zone
    {
        None = 0,
        Zone1 = 1,
        Zone2 = 2,
        Zone3 = 3,
        Zone4 = 4,
        Gradient1 = 5,
        Gradient2 = 6,
        Gradient3 = 7
    }

    enum BlendOP
    {
        AlphaBlend = 0,
        Additive = 1,
        SoftAdditive = 2,
        Multiplicative = 3
    }

    enum BlendMode
    {
        Opaque = 0,
        Cutout = 1,
        Transparent = 2
    }

    //This is where the GUI is drawn
    public override void OnGUI(
        MaterialEditor editor, MaterialProperty[] properties
    )
    {
        this.editor = editor;
        this.properties = properties;
        this.target = editor.target as Material;

        //Setup UI
        SetLogoImage();

        //Blend OP Selector
        //EditorGUI.indentLevel += 2;
        DoBlendMode();

        if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
        {
            DoBlendOPSelctor();
        }

        if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
        {
            DoMaskClip();
        }

        //EditorGUI.indentLevel -= 2;

        //Main Properties
        DoMainProperties();

        //Luma Glow Properties
        DoLumaProperties();

        //Effects
        DoEffects();
    }

    //Entirely functions below this point

    //Set logo
    void SetLogoImage()
    {
        //Load logo image
        logoImage = AssetDatabase.LoadAssetAtPath<Texture2D>("Packages/com.furality.sylvashader/Runtime/UI/SylvaIcon.png");

        // Center the image in a horizontal and vertical layout group
        GUILayout.BeginHorizontal();
        GUILayout.FlexibleSpace();
        GUILayout.BeginVertical();
        GUILayout.FlexibleSpace();
        GUILayout.Label(logoImage, GUILayout.MaxHeight(100));
        GUILayout.FlexibleSpace();
        GUILayout.EndVertical();
        GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();
    }

    //Modify FindProperty to only require a string
    MaterialProperty FindProperty(string name)
    {
        return FindProperty(name, properties);
    }

    //Function to create labels for properties
    static GUIContent staticLabel = new GUIContent();
    static GUIContent MakeLabel(string text, string tooltip = null)
    {
        staticLabel.text = text;
        staticLabel.tooltip = tooltip;
        return staticLabel;
    }

    //Create foldout that contains main properties
    void DoMainProperties()
    {
        //Convert material int to bool
        bool ShowMain;
        string tog = "_ShowMain";
        string title = "Main Properties";

        if (target.GetFloat(tog) == 1)
        {
            ShowMain = true;
        }
        else
        {
            ShowMain = false;
        }

        //Create foldout
        ShowMain = EditorGUILayout.Foldout(ShowMain, title, true, EditorStyles.foldoutHeader);
        if (ShowMain)
        {
            target.SetFloat(tog, 1);

            DoMainTex();
            DoMetallic();
            DoSpecular();
            DoNormals();
            DoOcclusion();
            DoEffectMask();
            DoEmission();

            DoOutlineToggle();
            if (enableOutline is true)
            {
                DoOutlines();
            }

            DoMisc();
        }
        else
        {
            target.SetFloat(tog, 0);
        }
    }

    //Create Foldout that contains Luma Glow properties
    void DoLumaProperties()
    {
        bool showProperties;
        MaterialProperty glowMask = FindProperty("_GlowMask");
        if (target.GetFloat("_ShowGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        //Create foldout
        showProperties = EditorGUILayout.Foldout(showProperties, "Luma Glow/AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowGlow", 1);

            DoGlowMask();

            if (target.GetFloat("_EnableEmission") == 1)
            {
                DoEmissionGlow();
                DoEmissionAL();
            }

            if (enableOutline is true)
            {
                DoOutlineGlow();
                DoOutlineAL();
            }


            if (glowMask.textureValue != null)
            {
                MaterialProperty redTog = FindProperty("_EnableRedChannel");
                EditorGUI.indentLevel += 2;
                editor.ShaderProperty(redTog, MakeLabel("Enable Red Channel", "Use Luma Glow with Glow Mask(R)"));
                EditorGUI.indentLevel -= 2;
                if (target.GetFloat("_EnableRedChannel") == 1)
                {
                    DoRedChGlow();
                    DoRedChAL();
                }

                MaterialProperty greenTog = FindProperty("_EnableGreenChannel");
                EditorGUI.indentLevel += 2;
                editor.ShaderProperty(greenTog, MakeLabel("Enable Green Channel", "Use Luma Glow with Glow Mask(G)"));
                EditorGUI.indentLevel -= 2;
                if (target.GetFloat("_EnableGreenChannel") == 1)
                {
                    DoGreenChGlow();
                    DoGreenChAL();
                }

                MaterialProperty blueTog = FindProperty("_EnableBlueChannel");
                EditorGUI.indentLevel += 2;
                editor.ShaderProperty(blueTog, MakeLabel("Enable Blue Channel", "Use Luma Glow with Glow Mask(B)"));
                EditorGUI.indentLevel -= 2;
                if (target.GetFloat("_EnableBlueChannel") == 1)
                {
                    DoBlueChGlow();
                    DoBlueChAL();
                }

                MaterialProperty alphaTog = FindProperty("_EnableAlphaChannel");
                EditorGUI.indentLevel += 2;
                editor.ShaderProperty(alphaTog, MakeLabel("Enable Alpha Channel", "Use Luma Glow with Glow Mask(A)"));
                EditorGUI.indentLevel -= 2;
                if (target.GetFloat("_EnableAlphaChannel") == 1)
                {
                    DoAlphaChGlow();
                    DoAlphaChAL();
                }

             }

            if (target.GetFloat("_EnableSparkles") == 1)
            {
            DoSparkleGlow();
            DoSparkleAL();
            }

        }
        else
        {
            target.SetFloat("_ShowGlow", 0);
        }
    }

    //Create Foldout that contains Effect properties
    void DoEffects()
    {
        MaterialProperty mask = FindProperty("_EffectMask");
        bool showProperties;
        if (target.GetFloat("_ShowEffects") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        //Create foldout
        showProperties = EditorGUILayout.Foldout(showProperties, "Special Effects", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowEffects", 1);
            DoEffectMask();
            DoSparkles();
            DoRainbow();
            DoIridescence();

            if (enableOutline is true)
            {
                DoOutlines2();
            }

        }
        else
        {
            target.SetFloat("_ShowEffects", 0);
        }
    }

    //Main Texture func
    void DoMainTex()
    {
        MaterialProperty mainTex = FindProperty("_MainTex");
        MaterialProperty mainColor = FindProperty("_Color");
        editor.TexturePropertySingleLine(MakeLabel("Main Tex", "Texture, main colors with alpha"), mainTex, mainColor);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(mainTex);
        EditorGUI.indentLevel -= 2;
    }

    //Metallic texture and smoothness
    void DoMetallic()
    {
        MaterialProperty Tex = FindProperty("_MetallicGlossMap");
        MaterialProperty InlineProperty = FindProperty("_Metallic");
        MaterialProperty Smoothness = FindProperty("_Glossiness");
        MaterialProperty SmoothnessScale = FindProperty("_GlossMapScale");

        //editor.TexturePropertySingleLine(
        //    MakeLabel("Metallic", "uwu this is an easter egg I guess :3"), Tex,
        //    Tex.textureValue ? InlineProperty : null);

        editor.TexturePropertySingleLine(MakeLabel("Metallic", "Texture, R: Metallic, A: Smoothness"), Tex, InlineProperty);

        EditorGUI.indentLevel += 2;
        if (Tex.textureValue != null)
        {
            editor.ShaderProperty(SmoothnessScale, MakeLabel("Smoothness", "How reflective the material is"));
        }
        else
        {
            editor.ShaderProperty(Smoothness, MakeLabel("Smoothness", "How reflective the material is"));
        }
        EditorGUI.indentLevel -= 2;
    }

    //Specular map and rimlight
    void DoSpecular()
    {
        MaterialProperty color = FindProperty("_RimlightColor");
        MaterialProperty toggle = FindProperty("_EnableSpecularMap");
        MaterialProperty Tex = FindProperty("_SpecGlossMap");
        MaterialProperty SpecColor = FindProperty("_SpecColor");
        EditorGUI.indentLevel += 2;
        editor.ColorProperty(color, "Rimlight Color");
        editor.ShaderProperty(toggle, "Specular Map");
        EditorGUI.indentLevel -= 2;
        if (target.GetFloat("_EnableSpecularMap") == 1)
        {
            editor.TexturePropertySingleLine(MakeLabel("Specular Map", "Texture, tints the color of specular highlights"), Tex, SpecColor);
        }
    }

    //Normal map
    void DoNormals()
    {
        MaterialProperty tex = FindProperty("_BumpMap");
        MaterialProperty scale = FindProperty("_BumpScale");
        editor.TexturePropertySingleLine(MakeLabel("Normal Map", "Texture to simulate bumps"), tex, scale);
    }

    //Occlusion
    void DoOcclusion()
    {
        MaterialProperty tex = FindProperty("_OcclusionMap");
        MaterialProperty scale = FindProperty("_OcclusionStrength");
        editor.TexturePropertySingleLine(MakeLabel("Occlusion Map", "Texture, adds shadow detail"), tex, scale);
    }

    //Effect Mask
    void DoEffectMask()
    {
        MaterialProperty tex = FindProperty("_EffectMask");
        editor.TexturePropertySingleLine(MakeLabel("Effect Mask", "Texture, masks effects using color channels (RGBA)"), tex);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(tex);
        EditorGUI.indentLevel -= 2;
    }

    //Emission
    void DoEmission()
    {
        MaterialProperty tex = FindProperty("_EmissionMap");
        MaterialProperty color = FindProperty("_EmissionColor");
        MaterialProperty tog = FindProperty("_EnableEmission");
        MaterialProperty maskCH = FindProperty("_EmissionMaskingChannel");
        MaterialProperty maskTog = FindProperty("_EmissionMaskPan");
        MaterialProperty maskSpeed = FindProperty("_EmissionMaskPanSpeed");
        MaterialProperty panTog = FindProperty("_EmissionPan");
        MaterialProperty panSpeed = FindProperty("_EmissionPanSpeed");
        float togfl = target.GetFloat("_EnableEmission");
        float maskTogfl = target.GetFloat("_EmissionMaskPan");
        float panTogfl = target.GetFloat("_EmissionPan");
        float maskCHfl = target.GetFloat("_EmissionMaskingChannel");

        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tog, MakeLabel("Enable Emission", "Texture/color, adds glow"));
        EditorGUI.indentLevel -= 2;
        editor.TexturePropertySingleLine(MakeLabel("Emission"), tex, color);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(tex);

        if (togfl == 1)
        {
            editor.ShaderProperty(maskCH, MakeLabel("Masking Channel", "Hides emissions by an Effect Mask color channel"));
            if (maskCHfl > 0)
            {
                editor.ShaderProperty(maskTog, MakeLabel("Mask Panning", "Animated emission mask"));
                if (maskTogfl == 1)
                {
                    editor.ShaderProperty(maskSpeed, MakeLabel("Mask Speed", "Animation speed"));
                }
            }
            editor.ShaderProperty(panTog, MakeLabel("Emission Panning", "Animated emissions"));
            if (panTogfl == 1)
            {
                editor.ShaderProperty(panSpeed, MakeLabel("Emission Speed", "Animation speed"));
            }
        }
        EditorGUI.indentLevel -= 2;
    }

    //Outlines
    void DoOutlines()
    {
        bool showProperties;
        if (target.GetFloat("_ShowOutline") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Outline Settings", true, EditorStyles.foldoutHeader);

        MaterialProperty maskCH = FindProperty("_OutlineMaskingChannel");
        MaterialProperty color = FindProperty("_OutlineColor");
        MaterialProperty width = FindProperty("_OutlineWidth");
        MaterialProperty maxWidth = FindProperty("_MaxOutlineWidth");
        MaterialProperty fudge = FindProperty("_ViewFudge");

        if (showProperties)
        {
            EditorGUI.indentLevel += 1;
            target.SetFloat("_ShowOutline", 1);

            editor.ShaderProperty(maskCH, MakeLabel("Masking Channel", "Hides outlines by an Effect Mask color channel"));
            editor.ShaderProperty(color, MakeLabel("Color"));
            editor.ShaderProperty(width, MakeLabel("Width"));
            editor.ShaderProperty(maxWidth, MakeLabel("Max Width", "Maximum distance scaling width"));
            editor.ShaderProperty(fudge, MakeLabel("Push Outline", "Helps fix ugly internal outlines"));
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowOutline", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Outlines
    void DoOutlines2()
    {
        bool showProperties;
        if (target.GetFloat("_ShowOutline2") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Outline Settings", true, EditorStyles.foldoutHeader);

        MaterialProperty maskCH = FindProperty("_OutlineMaskingChannel");
        MaterialProperty color = FindProperty("_OutlineColor");
        MaterialProperty width = FindProperty("_OutlineWidth");
        MaterialProperty maxWidth = FindProperty("_MaxOutlineWidth");
        MaterialProperty fudge = FindProperty("_ViewFudge");

        if (showProperties)
        {
            EditorGUI.indentLevel += 1;
            target.SetFloat("_ShowOutline2", 1);

            editor.ShaderProperty(maskCH, MakeLabel("Masking Channel", "Hides outlines by an Effect Mask color channel"));
            editor.ShaderProperty(color, MakeLabel("Color"));
            editor.ShaderProperty(width, MakeLabel("Width"));
            editor.ShaderProperty(maxWidth, MakeLabel("Max Width", "Maximum distance scaling width"));
            editor.ShaderProperty(fudge, MakeLabel("Push Outline", "Helps fix ugly internal outlines"));
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowOutline2", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Misc
    void DoMisc()
    {
        MaterialProperty clip = FindProperty("_Culling");
        //MaterialProperty cull = FindProperty("");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(clip, MakeLabel("Culling"));
        EditorGUI.indentLevel -= 2;
    }

    //Directional map and Glow Mask
    void DoGlowMask()
    {
        MaterialProperty map = FindProperty("_DirectionalMap");
        MaterialProperty mask = FindProperty("_GlowMask");

        editor.TexturePropertySingleLine(MakeLabel("Direction Map", "Helps fix UV seams and add detail"), map);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        EditorGUI.indentLevel -= 2;
        editor.TexturePropertySingleLine(MakeLabel("Glow Mask", "Texture, hides glow effects using color channels (RGBA)"), mask);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(mask);
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoEmissionZone()
    {
        Zone operation = (Zone)target.GetFloat("_EmissionGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by Emission"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Emission Glow Zone");
            target.SetFloat("_EmissionGlowZone", (float)operation);
        }
    }

    //Emission Glow Settings
    void DoEmissionGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowEmissGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_EmissionGlowMode");
        MaterialProperty BlendMode = FindProperty("_EmissionGlowBlendMode");
        MaterialProperty Tint = FindProperty("_EmissionGlowTint");
        MaterialProperty MinBrightness = FindProperty("_EmissionGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_EmissionGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_EmissionGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_EmissionGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_EmissionGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_EmissionGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_EmissionGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_EmissionGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_EmissionGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Emission Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowEmissGlow", 1);

            EditorGUI.indentLevel += 1;
            DoEmissionZone();

            if (target.GetFloat("_EmissionGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "How the effect combines"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_EmissionGlowZone") > 4 || target.GetFloat("_EmissionGlowMode") > 0)
                {
                    if (target.GetFloat("_EmissionGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_EmissionGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_EmissionGlowZone") > 4 || target.GetFloat("_EmissionGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation Speed/Chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation Strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowEmissGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Emission AL Settings
    void DoEmissionAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowEmissAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_EmissionReactiveMode");
        MaterialProperty BlendMode = FindProperty("_EmissionReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_EmissionReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_EmissionReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_EmissionReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_EmissionReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_EmissionReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_EmissionReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_EmissionReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Emission AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowEmissAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_EmissionReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation Type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How the effect combines"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_EmissionReactiveBand") > 4 || target.GetFloat("_EmissionReactiveMode") > 0 && target.GetFloat("_EmissionReactiveMode") != 5)
                {
                    if (target.GetFloat("_EmissionReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "AudioLink: Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "AudioLink: Pulse mode animation offset"));
                }

                if (target.GetFloat("_EmissionReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "AudioLink: Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowEmissAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoOutlineZone()
    {
        Zone operation = (Zone)target.GetFloat("_OutlineGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by outline"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Outline Glow Zone");
            target.SetFloat("_OutlineGlowZone", (float)operation);
        }
    }

    //Outline Glow Settings
    void DoOutlineGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowOutlineGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_OutlineGlowMode");
        MaterialProperty BlendMode = FindProperty("_OutlineGlowBlendMode");
        MaterialProperty Tint = FindProperty("_OutlineGlowTint");
        MaterialProperty MinBrightness = FindProperty("_OutlineGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_OutlineGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_OutlineGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_OutlineGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_OutlineGlowRadialCenter");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Outline Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowOutlineGlow", 1);

            EditorGUI.indentLevel += 1;
            DoOutlineZone();

            if (target.GetFloat("_OutlineGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "How the effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_OutlineGlowZone") > 4 || target.GetFloat("_OutlineGlowMode") > 0)
                {
                    if (target.GetFloat("_OutlineGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_OutlineGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowOutlineGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Outline AL Settings
    void DoOutlineAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowOutlineAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_OutlineReactiveMode");
        MaterialProperty BlendMode = FindProperty("_OutlineReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_OutlineReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_OutlineReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_OutlineReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_OutlineReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_OutlineReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_OutlineReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_OutlineReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Outline AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowOutlineAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_OutlineReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How the effect combines"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_OutlineReactiveBand") > 4 || target.GetFloat("_OutlineReactiveMode") > 0 && target.GetFloat("_OutlineReactiveMode") != 5)
                {
                    if (target.GetFloat("_OutlineReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "AudioLink: Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "AudioLink: Pulse mode animation offset"));
                }

                if (target.GetFloat("_OutlineReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "AudioLink: Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowOutlineAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoRedChZone()
    {
        Zone operation = (Zone)target.GetFloat("_RedChGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by Glow Mask(R)"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Red Channel Glow Zone");
            target.SetFloat("_RedChGlowZone", (float)operation);
        }
    }

    //RedCh Glow Settings
    void DoRedChGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowRedGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_RedChGlowMode");
        MaterialProperty Tint = FindProperty("_RedChGlowTint");
        MaterialProperty MinBrightness = FindProperty("_RedChGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_RedChGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_RedChGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_RedChGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_RedChGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_RedChGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_RedChGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_RedChGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_RedChGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "RedCh Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowRedGlow", 1);

            EditorGUI.indentLevel += 1;

            DoRedChZone();

            if (target.GetFloat("_RedChGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_RedChGlowZone") > 4 || target.GetFloat("_RedChGlowMode") > 0)
                {
                    if (target.GetFloat("_RedChGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_RedChGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_RedChGlowZone") > 4 || target.GetFloat("_RedChGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/Chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowRedGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //RedCh AL Settings
    void DoRedChAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowRedAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_RedChReactiveMode");
        MaterialProperty BlendMode = FindProperty("_RedChReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_RedChReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_RedChReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_RedChReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_RedChReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_RedChReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_RedChReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_RedChReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "RedCh AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowRedAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_RedChReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_RedChReactiveBand") > 4 || target.GetFloat("_RedChReactiveMode") > 0 && target.GetFloat("_RedChReactiveMode") != 5)
                {
                    if (target.GetFloat("_RedChReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "AudioLink: Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "AudioLink: Pulse mode animation offset"));
                }

                if (target.GetFloat("_RedChReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "AudioLink: Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowRedAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoGreenChZone()
    {
        Zone operation = (Zone)target.GetFloat("_GreenChGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by Glow Mask(G)"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Green Channel Glow Zone");
            target.SetFloat("_GreenChGlowZone", (float)operation);
        }
    }

    //GreenCh Glow Settings
    void DoGreenChGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowGreenGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_GreenChGlowMode");
        MaterialProperty Tint = FindProperty("_GreenChGlowTint");
        MaterialProperty MinBrightness = FindProperty("_GreenChGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_GreenChGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_GreenChGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_GreenChGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_GreenChGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_GreenChGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_GreenChGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_GreenChGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_GreenChGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "GreenCh Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowGreenGlow", 1);

            EditorGUI.indentLevel += 1;
            DoGreenChZone();

            if (target.GetFloat("_GreenChGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_GreenChGlowZone") > 4 || target.GetFloat("_GreenChGlowMode") > 0)
                {
                    if (target.GetFloat("_GreenChGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_GreenChGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_GreenChGlowZone") > 4 || target.GetFloat("_GreenChGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowGreenGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //GreenCh AL Settings
    void DoGreenChAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowGreenAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_GreenChReactiveMode");
        MaterialProperty BlendMode = FindProperty("_GreenChReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_GreenChReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_GreenChReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_GreenChReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_GreenChReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_GreenChReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_GreenChReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_GreenChReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "GreenCh AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowGreenAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_GreenChReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_GreenChReactiveBand") > 4 || target.GetFloat("_GreenChReactiveMode") > 0 && target.GetFloat("_GreenChReactiveMode") != 5)
                {
                    if (target.GetFloat("_GreenChReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_GreenChReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowGreenAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoBlueChZone()
    {
        Zone operation = (Zone)target.GetFloat("_BlueChGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by Glow Mask(B)"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Blue Channel Glow Zone");
            target.SetFloat("_BlueChGlowZone", (float)operation);
        }
    }

    //BlueCh Glow Settings
    void DoBlueChGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowBlueGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_BlueChGlowMode");
        MaterialProperty Tint = FindProperty("_BlueChGlowTint");
        MaterialProperty MinBrightness = FindProperty("_BlueChGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_BlueChGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_BlueChGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_BlueChGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_BlueChGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_BlueChGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_BlueChGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_BlueChGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_BlueChGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "BlueCh Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowBlueGlow", 1);

            EditorGUI.indentLevel += 1;
            DoBlueChZone();

            if (target.GetFloat("_BlueChGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_BlueChGlowZone") > 4 || target.GetFloat("_BlueChGlowMode") > 0)
                {
                    if (target.GetFloat("_BlueChGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_BlueChGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_BlueChGlowZone") > 4 || target.GetFloat("_BlueChGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowBlueGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //BlueCh AL Settings
    void DoBlueChAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowBlueAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_BlueChReactiveMode");
        MaterialProperty BlendMode = FindProperty("_BlueChReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_BlueChReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_BlueChReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_BlueChReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_BlueChReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_BlueChReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_BlueChReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_BlueChReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "BlueCh AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowBlueAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_BlueChReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_BlueChReactiveBand") > 4 || target.GetFloat("_BlueChReactiveMode") > 0 && target.GetFloat("_BlueChReactiveMode") != 5)
                {
                    if (target.GetFloat("_BlueChReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "AudioLink: Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "AudioLink: Pulse mode animation offset"));
                }

                if (target.GetFloat("_BlueChReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "AudioLink: Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowBlueAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoAlphaChZone()
    {
        Zone operation = (Zone)target.GetFloat("_AlphaChGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by Glow Mask(A)"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Alpha Channel Glow Zone");
            target.SetFloat("_AlphaChGlowZone", (float)operation);
        }
    }

    //AlphaCh Glow Settings
    void DoAlphaChGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowAlphaGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_AlphaChGlowMode");
        MaterialProperty Tint = FindProperty("_AlphaChGlowTint");
        MaterialProperty MinBrightness = FindProperty("_AlphaChGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_AlphaChGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_AlphaChGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_AlphaChGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_AlphaChGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_AlphaChGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_AlphaChGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_AlphaChGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_AlphaChGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "AlphaCh Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowAlphaGlow", 1);

            EditorGUI.indentLevel += 1;
            DoAlphaChZone();

            if (target.GetFloat("_AlphaChGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limts how dim effects become"));

                if (target.GetFloat("_AlphaChGlowZone") > 4 || target.GetFloat("_AlphaChGlowMode") > 0)
                {
                    if (target.GetFloat("_AlphaChGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_AlphaChGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_AlphaChGlowZone") > 4 || target.GetFloat("_AlphaChGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowAlphaGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //AlphaCh AL Settings
    void DoAlphaChAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowAlphaAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_AlphaChReactiveMode");
        MaterialProperty BlendMode = FindProperty("_AlphaChReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_AlphaChReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_AlphaChReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_AlphaChReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_AlphaChReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_AlphaChReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_AlphaChReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_AlphaChReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "AlphaCh AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowAlphaAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_AlphaChReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_AlphaChReactiveBand") > 4 || target.GetFloat("_AlphaChReactiveMode") > 0 && target.GetFloat("_AlphaChReactiveMode") != 5)
                {
                    if (target.GetFloat("_AlphaChReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "AudioLink: Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "AudioLink: Pulse mode animation offset"));
                }

                if (target.GetFloat("_AlphaChReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "AudioLink: Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowAlphaAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Zone selector
    void DoSparkleZone()
    {
        Zone operation = (Zone)target.GetFloat("_SparkleGlowZone");
        EditorGUI.BeginChangeCheck();
        operation = (Zone)EditorGUILayout.EnumPopup(MakeLabel("Zone", "Select a zone to enable Luma Glow, masked by sparkles"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Sparkle Channel Glow Zone");
            target.SetFloat("_SparkleGlowZone", (float)operation);
        }
    }

    //Sparkle Glow Settings
    void DoSparkleGlow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowSparkleGlow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_SparkleGlowMode");
        MaterialProperty Tint = FindProperty("_SparkleGlowTint");
        MaterialProperty MinBrightness = FindProperty("_SparkleGlowMinBrightness");
        MaterialProperty PulseDir = FindProperty("_SparkleGlowPulseDir");
        MaterialProperty PulseScale = FindProperty("_SparkleGlowPulseScale");
        MaterialProperty PulseOffset = FindProperty("_SparkleGlowPulseOffset");
        MaterialProperty PulseCenter = FindProperty("_SparkleGlowRadialCenter");
        MaterialProperty AnimBand = FindProperty("_SparkleGlowAnimationBand");
        MaterialProperty AnimMode = FindProperty("_SparkleGlowAnimationMode");
        MaterialProperty AnimSpeed = FindProperty("_SparkleGlowAnimationSpeed");
        MaterialProperty AnimStr = FindProperty("_SparkleGlowAnimationStrength");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Sparkle Glow", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowSparkleGlow", 1);

            EditorGUI.indentLevel += 1;
            DoSparkleZone();

            if (target.GetFloat("_SparkleGlowZone") > 0)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "Animation type"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "Limits how dim effects become"));

                if (target.GetFloat("_SparkleGlowZone") > 4 || target.GetFloat("_SparkleGlowMode") > 0)
                {
                    if (target.GetFloat("_SparkleGlowMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));

                }

                if (target.GetFloat("_SparkleGlowMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }

                if (target.GetFloat("_SparkleGlowZone") > 4 || target.GetFloat("_SparkleGlowMode") > 0)
                {
                editor.ShaderProperty(AnimBand, MakeLabel("Animation Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
                }

            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowSparkleGlow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Sparkle AL Settings
    void DoSparkleAL()
    {
        bool showProperties;
        if (target.GetFloat("_ShowSparkleAL") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        MaterialProperty Mode = FindProperty("_SparkleReactiveMode");
        MaterialProperty BlendMode = FindProperty("_SparkleReactiveBlendMode");
        MaterialProperty Tint = FindProperty("_SparkleReactiveTint");
        MaterialProperty MinBrightness = FindProperty("_SparkleReactiveMinBrightness");
        MaterialProperty PulseDir = FindProperty("_SparkleReactivePulseDir");
        MaterialProperty PulseScale = FindProperty("_SparkleReactivePulseScale");
        MaterialProperty PulseOffset = FindProperty("_SparkleReactivePulseOffset");
        MaterialProperty PulseCenter = FindProperty("_SparkleReactiveRadialCenter");
        MaterialProperty Band = FindProperty("_SparkleReactiveBand");

        //Create Foldout
        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Sparkle AudioLink", true, EditorStyles.foldoutHeader);
        if (showProperties)
        {
            target.SetFloat("_ShowSparkleAL", 1);

            EditorGUI.indentLevel += 1;
            editor.ShaderProperty(Band, MakeLabel("AudioLink Band"));

            if (target.GetFloat("_SparkleReactiveBand") < 10)
            {
                editor.ShaderProperty(Mode, MakeLabel("Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(BlendMode, MakeLabel("Blend Mode", "AudioLink: How effects combine"));
                editor.ColorProperty(Tint, "Tint");
                editor.ShaderProperty(MinBrightness, MakeLabel("Min Brightness", "AudioLink: Limits how dim effects become"));

                if (target.GetFloat("_SparkleReactiveBand") > 4 || target.GetFloat("_SparkleReactiveMode") > 0 && target.GetFloat("_SparkleReactiveMode") != 5)
                {
                    if (target.GetFloat("_SparkleReactiveMode") < 2)
                    {
                        editor.ShaderProperty(PulseDir, MakeLabel("Pulse Dir", "AudioLink: Pulse mode animation direction"));
                    }
                    editor.ShaderProperty(PulseScale, MakeLabel("Pulse Scale", "Pulse mode animation scale"));
                    editor.ShaderProperty(PulseOffset, MakeLabel("Pulse Offset", "Pulse mode animation offset"));
                }

                if (target.GetFloat("_SparkleReactiveMode") == 2)
                {
                    editor.ShaderProperty(PulseCenter, MakeLabel("Radial Center", "Radial mode animation center"));
                }
            }
            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowSparkleAL", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Sparkles
    void DoSparkles()
    {
        bool showProperties;
        if (target.GetFloat("_ShowSparkles") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Sparkles", true, EditorStyles.foldoutHeader);

        if (showProperties)
        {
            EditorGUI.indentLevel += 1;
            target.SetFloat("_ShowSparkles", 1);
            MaterialProperty tog = FindProperty("_EnableSparkles");
            float toglFl = target.GetFloat("_EnableSparkles");
            editor.ShaderProperty(tog, MakeLabel("Enable Sparkles"));

            if (toglFl == 1)
            {
                MaterialProperty mode = FindProperty("_SparkleMode");
                MaterialProperty shape = FindProperty("_SparkleShape");
                MaterialProperty maskCh = FindProperty("_SparkleMaskingChannel");
                MaterialProperty color = FindProperty("_SparkleColor");
                MaterialProperty size = FindProperty("_SparkleSize");
                MaterialProperty scale = FindProperty("_SparkleScale");
                MaterialProperty speed = FindProperty("_SparkleSpeed");
                MaterialProperty seed = FindProperty("_SparkleSeed");
                MaterialProperty blendMode = FindProperty("_SparkleBlendMode");

                editor.ShaderProperty(maskCh, MakeLabel("Masking Channel", "Effect Mask color channel to use"));
                editor.ShaderProperty(mode, MakeLabel("Mode", "How sparkles react to light"));

                if (target.GetFloat("_SparkleMode") > 0)
                {
                editor.ShaderProperty(blendMode, MakeLabel("Blend Mode", "How the effect combines with lighting"));
                }

                editor.ShaderProperty(shape, MakeLabel("Shape", "Changes the shape of sparkles"));
                editor.ColorProperty(color, "Sparkle Color");
                editor.ShaderProperty(size, MakeLabel("Size", "Sparkle size"));
                editor.ShaderProperty(scale, MakeLabel("Scale", "Sparkle tiling"));
                editor.ShaderProperty(speed, MakeLabel("Speed", "Sparkle flicker rate"));
                editor.ShaderProperty(seed, MakeLabel("Seed", "Use a high number for best results"));

                EditorGUI.indentLevel -= 2;
                DoSparkleGlow();
                DoSparkleAL();
                EditorGUI.indentLevel += 2;
            }

            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowSparkles", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Scrolling Rainbow
    void DoRainbow()
    {
        bool showProperties;
        if (target.GetFloat("_ShowRainbow") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Scrolling Rainbow", true, EditorStyles.foldoutHeader);

        if (showProperties)
        {
            EditorGUI.indentLevel += 1;
            target.SetFloat("_ShowRainbow", 1);
            MaterialProperty tog = FindProperty("_EnableScrollingRainbow");
            float toglFl = target.GetFloat("_EnableScrollingRainbow");
            editor.ShaderProperty(tog, MakeLabel("Enable Rainbow"));

            if (toglFl == 1)
            {
                MaterialProperty maskCh = FindProperty("_RainbowMaskingChannel");
                MaterialProperty mode = FindProperty("_RainbowUVMode");
                MaterialProperty hueRange = FindProperty("_RainbowHueRange");
                MaterialProperty hue = FindProperty("_RainbowHue");
                MaterialProperty sat = FindProperty("_RainbowSaturation");
                MaterialProperty val = FindProperty("_RainbowValue");
                MaterialProperty rot = FindProperty("_RainbowRotation");
                MaterialProperty scale = FindProperty("_RainbowScale");
                MaterialProperty curve = FindProperty("_RainbowSpiralCurve");
                MaterialProperty center = FindProperty("_RainbowRadialCenter");
                MaterialProperty AnimBand = FindProperty("_RainbowALAnimationBand");
                MaterialProperty AnimMode = FindProperty("_RainbowALAnimationMode");
                MaterialProperty AnimSpeed = FindProperty("_RainbowALAnimationSpeed");
                MaterialProperty AnimStr = FindProperty("_RainbowALAnimationStrength");

                editor.ShaderProperty(maskCh, MakeLabel("Masking Channel", "Effect mask color channel to use"));
                editor.ShaderProperty(mode, MakeLabel("Mode", "Animation type"));
                editor.ShaderProperty(hueRange, MakeLabel("Hue Range", "Range of colors to show"));
                editor.ShaderProperty(hue, MakeLabel("Hue"));
                editor.ShaderProperty(sat, MakeLabel("Saturation"));
                editor.ShaderProperty(val, MakeLabel("Value"));

                if (target.GetFloat("_RainbowUVMode") > 0 && target.GetFloat("_RainbowUVMode") < 3)
                {
                    editor.ShaderProperty(rot, MakeLabel("Rotation"));
                }

                editor.ShaderProperty(scale, MakeLabel("Scale"));

                if (target.GetFloat("_RainbowUVMode") == 2)
                {
                editor.ShaderProperty(curve, MakeLabel("Spiral Curve", "Tightens the spiral effct"));
                }

                if (target.GetFloat("_RainbowUVMode") == 1 || target.GetFloat("_RainbowUVMode") == 2)
                {
                    editor.ShaderProperty(center, MakeLabel("Radial Center"));
                }

                editor.ShaderProperty(AnimBand, MakeLabel("AudioLink Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
            }

            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowRainbow", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Iridescence
    void DoIridescence()
    {
        bool showProperties;
        if (target.GetFloat("_ShowIridescence") == 1)
        {
            showProperties = true;
        }
        else
        {
            showProperties = false;
        }

        EditorGUI.indentLevel += 2;
        showProperties = EditorGUILayout.Foldout(showProperties, "Iridescence", true, EditorStyles.foldoutHeader);

        if (showProperties)
        {
            EditorGUI.indentLevel += 1;
            target.SetFloat("_ShowIridescence", 1);
            MaterialProperty tog = FindProperty("_Enableiridescence");
            float toglFl = target.GetFloat("_Enableiridescence");
            editor.ShaderProperty(tog, MakeLabel("Enable Iridescence"));

            if (toglFl == 1)
            {
                MaterialProperty maskCh = FindProperty("_IridescentMaskingChannel");
                MaterialProperty mode = FindProperty("_IridescentEmissionMode");
                MaterialProperty mode2 = FindProperty("_IridescentMode2");
                MaterialProperty lightMode = FindProperty("_IridescenceLightMode");
                MaterialProperty intensity = FindProperty("_IridescentIntensity");
                MaterialProperty scale = FindProperty("_IridescentScale");
                MaterialProperty offset = FindProperty("_IridescentOffset");
                MaterialProperty color1 = FindProperty("_IridescentEmissionColor1");
                MaterialProperty color2 = FindProperty("_IridescentEmissionColor2");
                MaterialProperty color3 = FindProperty("_IridescentEmissionColor3");
                MaterialProperty AnimBand = FindProperty("_IridescentALAnimationBand");
                MaterialProperty AnimMode = FindProperty("_IridescentALAnimationMode");
                MaterialProperty AnimSpeed = FindProperty("_IridescentALAnimationSpeed");
                MaterialProperty AnimStr = FindProperty("_IridescentALAnimationStrength");

                editor.ShaderProperty(maskCh, MakeLabel("Masking Channel", "Effect Mask color channel to use"));
                editor.ShaderProperty(mode2, MakeLabel("Mode", "How the effect reacts to light"));
                editor.ShaderProperty(mode, MakeLabel("Color Mode", "How the effect displays colors"));
                editor.ShaderProperty(lightMode, MakeLabel("Light Mode", "Which lighting to react to"));
                editor.ShaderProperty(intensity, MakeLabel("Intensity"));
                editor.ShaderProperty(scale, MakeLabel("Scale"));
                editor.ShaderProperty(offset, MakeLabel("Offset"));
                if (target.GetFloat("_IridescentEmissionMode") != 2 && target.GetFloat("_IridescentEmissionMode") != 4)
                {
                    editor.ColorProperty(color1, "Color 1");
                    editor.ColorProperty(color2, "Color 2");
                    editor.ColorProperty(color3, "Color 3");
                }

                editor.ShaderProperty(AnimBand, MakeLabel("AudioLink Band", "AudioLink: Audio band to listen to"));
                editor.ShaderProperty(AnimMode, MakeLabel("Animation Mode", "AudioLink: Animation type"));
                editor.ShaderProperty(AnimSpeed, MakeLabel("Animation Speed", "AudioLink: Animation speed/chronotensity"));
                editor.ShaderProperty(AnimStr, MakeLabel("Animation Strength", "AudioLink: Animation strength"));
            }

            EditorGUI.indentLevel -= 1;
        }
        else
        {
            target.SetFloat("_ShowIridescence", 0);
        }
        EditorGUI.indentLevel -= 2;
    }

    //BlendOP Selector
    void DoBlendOPSelctor()
    {
        MaterialProperty src = FindProperty("_BlendOPsrc");
        MaterialProperty dst = FindProperty("_BlendOPdst");

        BlendOP operation = (BlendOP)target.GetFloat("_BlendOPIndex");
        EditorGUI.BeginChangeCheck();

        operation = (BlendOP)EditorGUILayout.EnumPopup(new GUIContent("Blend Operation"), operation);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Blend Operation");
            target.SetFloat("_BlendOPIndex", (float)operation);

            if (target.GetFloat("_BlendOPIndex") == 0)
            {
                target.SetFloat("_BlendOPsrc", 5);
                target.SetFloat("_BlendOPdst", 10);
            }

            if (target.GetFloat("_BlendOPIndex") == 1)
            {
                target.SetFloat("_BlendOPsrc", 1);
                target.SetFloat("_BlendOPdst", 1);
            }

            if (target.GetFloat("_BlendOPIndex") == 2)
            {
                target.SetFloat("_BlendOPsrc", 4);
                target.SetFloat("_BlendOPdst", 1);
            }

            if (target.GetFloat("_BlendOPIndex") == 3)
            {
                target.SetFloat("_BlendOPsrc", 2);
                target.SetFloat("_BlendOPdst", 0);
            }

        }

    }

    void DoMaskClip()
    {
        MaterialProperty clip = FindProperty("_MaskClipValue");

        editor.ShaderProperty(clip, MakeLabel("Mask Clip"));
    }

    void DoBlendMode()
    {
        BlendMode mode = (BlendMode)target.GetFloat("_BlendModeIndex");

        if (target.shader == defaultOpaque || target.shader == noOutlineOpaque)
        {
            mode = BlendMode.Opaque;
        }

        else if (target.shader == defaultCutout || target.shader == noOutlineCutout)
        {
            mode = BlendMode.Cutout;
        }

        else if (target.shader == defaultTransparent || target.shader == noOutlineTransparent)
        {
            mode = BlendMode.Transparent;
        }

        EditorGUI.BeginChangeCheck();
        mode = (BlendMode)EditorGUILayout.EnumPopup(new GUIContent("Rendering Mode"), mode);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Blend Mode");
            target.SetFloat("_BlendModeIndex", (float)mode);

            if (enableOutline is true)
            {
                if (target.GetFloat("_BlendModeIndex") == 0)
                {
                    editor.SetShader(defaultOpaque);
                }

                else if (target.GetFloat("_BlendModeIndex") == 1)
                {
                    editor.SetShader(defaultCutout);
                }

                else if (target.GetFloat("_BlendModeIndex") == 2)
                {
                    editor.SetShader(defaultTransparent);
                }
            }

            else if (enableOutline is false)
            {
                if (target.GetFloat("_BlendModeIndex") == 0)
                {
                    editor.SetShader(noOutlineOpaque);
                }

                else if (target.GetFloat("_BlendModeIndex") == 1)
                {
                    editor.SetShader(noOutlineCutout);
                }

                else if (target.GetFloat("_BlendModeIndex") == 2)
                {
                    editor.SetShader(noOutlineTransparent);
                }
            }
        }
    }

    void DoOutlineToggle()
    {
            if (target.shader == defaultTransparent || target.shader == defaultOpaque || target.shader == defaultCutout)
            {
                enableOutline = true;
            }
            else
            {
                enableOutline = false;
            }

            EditorGUI.indentLevel += 2;
            EditorGUI.BeginChangeCheck();
            EditorGUILayout.Toggle(new GUIContent("Enable Outlines"), enableOutline);

            if (EditorGUI.EndChangeCheck())
            {
                editor.RegisterPropertyChangeUndo("Enable Outline");
                if (enableOutline is false)
                {
                    if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
                    {
                        editor.SetShader(defaultTransparent);
                    }
                    else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                    {
                        editor.SetShader(defaultCutout);
                    }
                    else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                    {
                        editor.SetShader(defaultOpaque);
                    }
                    enableOutline = true;
                }
                else if (enableOutline is true)
                {
                    if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
                    {
                        editor.SetShader(noOutlineTransparent);
                    }
                    else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                    {
                        editor.SetShader(noOutlineCutout);
                    }
                    else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                    {
                        editor.SetShader(noOutlineOpaque);
                    }
                enableOutline = false;
                }
            }
            EditorGUI.indentLevel -= 2;
    }
}

#endif