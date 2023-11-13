using UnityEngine;
using UnityEditor;

public class LegendsShaderGUI : ShaderGUI
{
    Material target;
    MaterialEditor editor;
    MaterialProperty[] properties;
    Shader defaultOpaque = Shader.Find("Furality/Legendary Shader/Legendary Shader");
    Shader defaultCutout = Shader.Find("Furality/Legendary Shader/Legendary Shader - Cutout");
    Shader defaultTransparent = Shader.Find("Furality/Legendary Shader/Legendary Shader - Transparent");
    Shader noOutlineOpaque = Shader.Find("Furality/Legendary Shader/No Outline/Legendary Shader - No Outline");
    Shader noOutlineCutout = Shader.Find("Furality/Legendary Shader/No Outline/Legendary Shader - No Outline Cutout");
    Shader noOutlineTransparent = Shader.Find("Furality/Legendary Shader/No Outline/Legendary Shader - No Outline Transparent");

    bool enableOutline;

    MaterialProperty FindProperty(string name)
    {
        return FindProperty(name, properties);
    }

    static GUIContent staticLabel = new GUIContent();

    static GUIContent MakeLabel(MaterialProperty property, string tooltip = null)
    {
        staticLabel.text = property.displayName;
        staticLabel.tooltip = tooltip;
        return staticLabel;
    }

    bool IsKeywordEnabled(string keyword)
    {
        return target.IsKeywordEnabled(keyword);
    }

    enum BlendMode
    {
        Opaque = 0,
        Cutout = 1,
        Transparent = 2
    }

    enum ShadowStyle
    {
        Default = 0,
        Circle = 1,
        Square = 2,
        Hexagon = 3,
        FourSidedStar = 4,
        EightSidedStar = 5,
        Lines = 6,
        Toon = 7,
        HalfLambert = 8
    }

    enum SpecularStyle
    {
        Default = 0,
        Circle = 1,
        Square = 2,
        Hexagon = 3,
        FourSidedStar = 4,
        EightSidedStar = 5,
        Lines = 6,
        Toon = 7,
    }

    enum RimlightStyle
    {
        Default = 0,
        Circle = 1,
        Square = 2,
        Hexagon = 3,
        FourSidedStar = 4,
        EightSidedStar = 5,
        Lines = 6,
        Toon = 7,
        None = 8
    }

    //void DoFuralityIcon()
    //{
    //    GUILayout.
    //}
    //

    //Main Texture

    void DoMain()
    {
        MaterialProperty mainTex = FindProperty("_MainTex");
        editor.TexturePropertySingleLine(MakeLabel(mainTex, "Albedo (RGB)"), mainTex, FindProperty("_Color"));
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(mainTex);
        EditorGUI.indentLevel -= 2;
    }

    //Normal Map

    void DoNormals()
    {
        MaterialProperty map = FindProperty("_Normal");
        editor.TexturePropertySingleLine(MakeLabel(map), map, FindProperty("_NormalScale"));
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        EditorGUI.indentLevel -= 2;
    }

    //Metallic

    void DoMetallic()
    {
        if (target.GetFloat("_Workflow") == 0)
        {
            MaterialProperty map = FindProperty("_Metallic");
            editor.TexturePropertySingleLine(MakeLabel(map, "Metallic (R) Smoothness (A)"), map, FindProperty("_MetallicVal"));
        }
        else if (target.GetFloat("_Workflow") == 1)
        {
            MaterialProperty map = FindProperty("_Metallic");
            editor.TexturePropertySingleLine(new GUIContent("   Specular", "Specular (RGB) Smoothness (A)"), map, FindProperty("_SpecularTint"));
        }
    }

    //Smoothness

    void DoSmoothness()
    {
        MaterialProperty slider = FindProperty("_Smoothness");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(slider, MakeLabel(slider));
        EditorGUI.indentLevel -= 2;
    }

    //Occlusion

    void DoOcclusion()
    {
        MaterialProperty map = FindProperty("_Occlusion");
        editor.TexturePropertySingleLine(MakeLabel(map, "Ambient Occlusion (G)"), map, FindProperty("_OcclusionPower"));
    }

    //Emission

    void DoEmission()
    {
        MaterialProperty map = FindProperty("_Emission");
        MaterialProperty panning = FindProperty("_EmissionPan");
        MaterialProperty panDir = FindProperty("_EmissionPanSpeed");
        editor.TexturePropertySingleLine(MakeLabel(map), map, FindProperty("_EmissionColor"));
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        if (target.GetFloat("_AdvToggle") == 0)
        {
            editor.ShaderProperty(panning, MakeLabel(panning, "Toggles emission movement"));
            if (target.GetFloat("_EmissionPan") == 1)
            {
                editor.ShaderProperty(panDir, MakeLabel(panDir, "Emission movement speed and direction"));
            }
        }
        EditorGUI.indentLevel -= 2;
    }

    void DoEmissionMaskPan()
    {
        MaterialProperty map = FindProperty("_EmissionMask");
        MaterialProperty panning = FindProperty("_EmissionPan");
        MaterialProperty panDir = FindProperty("_EmissionPanSpeed");
        editor.TexturePropertySingleLine(MakeLabel(map), map);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        editor.ShaderProperty(panning, "   Enable Emission Panning");
        if (target.GetFloat("_EmissionPan") == 1)
        {
            editor.ShaderProperty(panDir, MakeLabel(panDir, "Emission movement speed and direction"));
        }
        EditorGUI.indentLevel -= 2;
    }

    //Settings Level Selector

    void DoSettingSelector()
    {
        MaterialProperty dropdown = FindProperty("_SettingsMode");
        MaterialProperty toggle = FindProperty("_AdvToggle");

        editor.ShaderProperty(dropdown, new GUIContent("Page", "Changes the settings page. Values are saved between pages"));
        DoWorkflowSelector();

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

        editor.ShaderProperty(toggle, new GUIContent("Show Advanced Settings", "Shows additional options"));

    }

    void DoWorkflowSelector()
    {
        MaterialProperty dropdown = FindProperty("_Workflow");
        editor.ShaderProperty(dropdown, new GUIContent("Workflow", "Pick between metallic or specular workflow"));
    }

    //Culling Mode Selector

    void DoCullingMode()
    {
        MaterialProperty dropdown = FindProperty("_Culling");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(dropdown, "Culling");
        EditorGUI.indentLevel -= 2;
    }

    //Debug Mode Selector

    void DoDebugMode()
    {
        MaterialProperty toggle = FindProperty("_DebugMode");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, new GUIContent("Debug Mode", "Toggles dummy data for Luma Glow testing"));
        EditorGUI.indentLevel -= 2;
    }

    //MaskClipCheck

    void DoMaskClip()
    {
        if (target.shader == defaultCutout || target.shader == noOutlineCutout)
        {
            MaterialProperty val = FindProperty("_MaskClip");
            MaterialProperty outlineVal = FindProperty("_OutlineMaskClip");
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(val, MakeLabel(val));
            if(target.shader == defaultCutout)
            {
                editor.ShaderProperty(outlineVal, MakeLabel(outlineVal));
            }
            EditorGUI.indentLevel -= 2;
        }

    }

    //Outline Settings

    void DoOutlines()
    {

        if (target.shader == defaultOpaque ||
            target.shader == defaultCutout ||
            target.shader == defaultTransparent)
        {
            enableOutline = true;
        }
        else
        {
            enableOutline = false;
        }

        GUILayout.Label("Outline Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        EditorGUI.BeginChangeCheck();
        EditorGUILayout.Toggle(new GUIContent("   Enable Outlines"), enableOutline);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Enable Outline");
            if (enableOutline is false)
            {
                if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                {
                    editor.SetShader(defaultOpaque);
                }
                else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                {
                    editor.SetShader(defaultCutout);
                }
                else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
                {
                    editor.SetShader(defaultTransparent);
                }
                enableOutline = true;
            }
            else if (enableOutline is true)
            {
                if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                {
                    editor.SetShader(noOutlineOpaque);
                }
                else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                {
                    editor.SetShader(noOutlineCutout);
                }
                else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
                {
                    editor.SetShader(noOutlineTransparent);
                }
                enableOutline = false;
            }
        }

        if (enableOutline is true)
        {
            MaterialProperty tint = FindProperty("_OutlineColor");
            MaterialProperty width = FindProperty("_OutlineWidth");
            MaterialProperty depth = FindProperty("_OutlineDepthFade");
            editor.ShaderProperty(tint, MakeLabel(tint));
            editor.ShaderProperty(width, MakeLabel(width));
            if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque || (BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
            {
                editor.ShaderProperty(depth, MakeLabel(depth));
            }
        }
        EditorGUI.indentLevel -= 2;
    }

    //Lighting Mode Selectors

    void DoLightingStyles()
    {
        //MaterialProperty shadowStyle = FindProperty("_SHADOW_STYLE");
        //MaterialProperty specularStyle = FindProperty("_SPECULAR_STYLE");
        //MaterialProperty rimlightStyle = FindProperty("_RIMLIGHT_STYLE");
        EditorGUI.indentLevel += 2;

        //editor.ShaderProperty(shadowStyle, MakeLabel(shadowStyle, "Stylizes lighting ramp and shadows"));

        //shadowselector
        ShadowStyle index = (ShadowStyle)target.GetFloat("_ShadowStyleIndex");
        EditorGUI.BeginChangeCheck();
        index = (ShadowStyle)EditorGUILayout.EnumPopup(new GUIContent("   Shadow Style", "Stylizes lighting ramp and shadows"), index);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Shadow Style");
            target.SetFloat("_ShadowStyleIndex", (float)index);
        }

        //editor.ShaderProperty(specularStyle, MakeLabel(specularStyle, "Stylizes specular highlights"));

        //specularselector
        SpecularStyle index2 = (SpecularStyle)target.GetFloat("_SpecularStyleIndex");
        EditorGUI.BeginChangeCheck();
        index2 = (SpecularStyle)EditorGUILayout.EnumPopup(new GUIContent("   Specular Style", "Stylizes specular highlights"), index2);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Specular Style");
            target.SetFloat("_SpecularStyleIndex", (float)index2);
        }

        //editor.ShaderProperty(rimlightStyle, MakeLabel(rimlightStyle, "Stylizes rimlighting"));

        //rimlightselector
        RimlightStyle index3 = (RimlightStyle)target.GetFloat("_RimlightStyleIndex");
        EditorGUI.BeginChangeCheck();
        index3 = (RimlightStyle)EditorGUILayout.EnumPopup(new GUIContent("   Rimlight Style", "Stylizes rimlighting"), index3);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Rimlight Style");
            target.SetFloat("_RimlightStyleIndex", (float)index3);
        }
        EditorGUI.indentLevel -= 2;
    }

    //Default Lighting Settings

        //Specular
    void DoSimpleSpecular()
    {
        MaterialProperty tint = FindProperty("_SpecularTint");
        MaterialProperty scale = FindProperty("_SpecularHaltoneScale");
        MaterialProperty rotation = FindProperty("_SpecularHaltoneRotation");
        GUILayout.Label(" ");
        GUILayout.Label("       Specular Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, MakeLabel(tint));
        EditorGUI.indentLevel -= 2;
        if (target.GetFloat("_SpecularStyleIndex") < 7 && target.GetFloat("_SpecularStyleIndex") > 0)
        {
            GUILayout.Label(" ");
            GUILayout.Label("               Specular Style Settings", EditorStyles.boldLabel);
            EditorGUI.indentLevel += 3;
            editor.ShaderProperty(scale, MakeLabel(scale));
            editor.ShaderProperty(rotation, MakeLabel(rotation));
            EditorGUI.indentLevel -= 3;
        }
    }

        //Rimlight
    void DoSimpleRimlight()
    {
        MaterialProperty tint = FindProperty("_RimlightTint");
        MaterialProperty scale = FindProperty("_RimlightHaltoneScale");
        MaterialProperty rotation = FindProperty("_RimlightHaltoneRotation");
        GUILayout.Label(" ");
        GUILayout.Label("       Rimlight Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, MakeLabel(tint));
        EditorGUI.indentLevel -= 2;
        if (target.GetFloat("_RimlightStyleIndex") < 7 && target.GetFloat("_RimlightStyleIndex") > 0)
        {
            GUILayout.Label(" ");
            GUILayout.Label("               Rimlight Style Settings", EditorStyles.boldLabel);
            EditorGUI.indentLevel += 3;
            editor.ShaderProperty(scale, MakeLabel(scale));
            editor.ShaderProperty(rotation, MakeLabel(rotation));
            EditorGUI.indentLevel -= 3;
        }
    }

        //Shadows
    void DoSimpleShadow()
    {
        MaterialProperty scale = FindProperty("_HaltoneScale");
        MaterialProperty rotation = FindProperty("_HaltoneRotation");
        if (target.GetFloat("_ShadowStyleIndex") < 7 && target.GetFloat("_ShadowStyleIndex") > 0)
        {
            GUILayout.Label(" ");
            GUILayout.Label(new GUIContent("       Shadow Settings", "Settings for custom shadow ramps"), EditorStyles.boldLabel);
            GUILayout.Label("               Shadow Style Settings", EditorStyles.boldLabel);
            EditorGUI.indentLevel += 3;
            editor.ShaderProperty(scale, MakeLabel(scale, "Tiling value for halftone effects"));
            editor.ShaderProperty(rotation, MakeLabel(rotation, "Rotation value for halftone effects"));
            EditorGUI.indentLevel -= 3;
        }
    }

    //Advanced Lighting Settings

        //Shadows
    void DoAdvancedShadow()
    {
        MaterialProperty offset = FindProperty("_ShadowOffset");
        MaterialProperty length = FindProperty("_ShadowLength");
        MaterialProperty scale = FindProperty("_HaltoneScale");
        MaterialProperty rotation = FindProperty("_HaltoneRotation");
        GUILayout.Label(" ");
        GUILayout.Label(new GUIContent("       Shadow Settings", "Settings for custom shadow ramps"), EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(offset, MakeLabel(offset, "Moves shadow ramp forward/back"));
        editor.ShaderProperty(length, MakeLabel(length, "Controls falloff of the shadow ramp"));
        EditorGUI.indentLevel += 1;
        if (target.GetFloat("_ShadowStyleIndex") < 7 && target.GetFloat("_ShadowStyleIndex") > 0)
        {
            GUILayout.Label(" ");
            GUILayout.Label(new GUIContent ("               Shadow Style Settings", "Adjusts stylized shadow properties"), EditorStyles.boldLabel);
            editor.ShaderProperty(scale, MakeLabel(scale, "Tiling value for stylized shadow effects"));
            editor.ShaderProperty(rotation, MakeLabel(rotation, "Rotation value for stylized shadow effects"));
        }
        EditorGUI.indentLevel -= 3;
    }

        //Specular
    void DoAdvancedSpecular()
    {
        MaterialProperty tint = FindProperty("_SpecularTint");
        MaterialProperty scale = FindProperty("_SpecularHaltoneScale");
        MaterialProperty rotation = FindProperty("_SpecularHaltoneRotation");
        GUILayout.Label(" ");
        GUILayout.Label(new GUIContent("       Specular Settings","Settings for custom specular ramps. Does not work on default specular style"), EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, MakeLabel(tint));
        EditorGUI.indentLevel -= 2;

        MaterialProperty offset = FindProperty("_SpecularOffset");
        MaterialProperty length = FindProperty("_SpecularLength");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(offset, MakeLabel(offset, "Moves specular ramp forward/back"));
        editor.ShaderProperty(length, MakeLabel(length, "Controls the falloff of the specular ramp"));
        EditorGUI.indentLevel -= 2;

        if (target.GetFloat("_SpecularStyleIndex") < 7 && target.GetFloat("_SpecularStyleIndex") > 0)
        {
            GUILayout.Label(" ");
            GUILayout.Label(new GUIContent ("               Specular Style Settings", "Adjusts stylized specular properties"), EditorStyles.boldLabel);
            EditorGUI.indentLevel += 3;
            editor.ShaderProperty(scale, MakeLabel(scale, "Tiling value for stylized specular effects"));
            editor.ShaderProperty(rotation, MakeLabel(rotation, "Rotation value for stylized specular effects"));
            EditorGUI.indentLevel -= 3;
        }
    }

        //Rimlight
    void DoAdvancedRimlight()
    {
        MaterialProperty tint = FindProperty("_RimlightTint");
        MaterialProperty scale = FindProperty("_RimlightHaltoneScale");
        MaterialProperty rotation = FindProperty("_RimlightHaltoneRotation");
        GUILayout.Label(" ");
        GUILayout.Label(new GUIContent("           Rimlight Settings", "Settings for custom rimlight ramps"), EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, MakeLabel(tint));
        EditorGUI.indentLevel -= 2;

        MaterialProperty offset = FindProperty("_RimlightOffset");
        MaterialProperty length = FindProperty("_RimlightLength");
        MaterialProperty axis = FindProperty("_RimlightRotationAxis");
        MaterialProperty angle = FindProperty("_RimlightRotationAngle");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(offset, MakeLabel(offset, "Moves rimlighting forward/back"));
        editor.ShaderProperty(length, MakeLabel(length, "Controls the falloff of the rimlighting ramp"));
        editor.ShaderProperty(angle, MakeLabel(angle, "Amount of rotation for the rimlight around configured axis"));
        editor.ShaderProperty(axis, MakeLabel(axis, "Axis of rotation to rotate the rimlight around"));
        EditorGUI.indentLevel -= 2;

        if (target.GetFloat("_RimlightStyleIndex") < 7 && target.GetFloat("_RimlightStyleIndex") > 0)
        {
            GUILayout.Label(new GUIContent ("           Rimlight Style Settings", "Adjusts stylized rimlight properties"), EditorStyles.boldLabel);
            EditorGUI.indentLevel += 3;
            editor.ShaderProperty(scale, MakeLabel(scale, "Tiling value for stylized rimlight effects"));
            editor.ShaderProperty(rotation, MakeLabel(rotation, "Rotation value for stylized rimlight effects"));
            EditorGUI.indentLevel -= 3;
        }
    }

    //Distance Blending Settings

    void DoDistanceBlend()
    {
        bool enable = false;
        MaterialProperty offset = FindProperty("_BlendOffset");
        MaterialProperty scale = FindProperty("_BlendLength");

        if (target.GetFloat("_ShadowStyleIndex") < 7 && target.GetFloat("_ShadowStyleIndex") > 0) { enable = true; }
        if (target.GetFloat("_SpecularStyleIndex") < 7 && target.GetFloat("_SpecularStyleIndex") > 0) { enable = true; }
        if (target.GetFloat("_RimlightStyleIndex") < 7 && target.GetFloat("_RimlightStyleIndex") > 0) { enable = true; }

        if (enable is true)
        {
            GUILayout.Label(" ");
            GUILayout.Label(new GUIContent("       Distance Blending","Blends out stylized effects with distance"), EditorStyles.boldLabel);
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(offset, MakeLabel(offset, "Distance before blend begins"));
            editor.ShaderProperty(scale, MakeLabel(scale, "How long the blend takes to switch"));
            EditorGUI.indentLevel -= 2;
        }
    }

    //Luma Glow Settings

        //Default Luma Glow Settings
    void DoSimpleLumaGlow()
    {
        MaterialProperty enable = FindProperty("_EnableEmissionGlow");
        MaterialProperty zone = FindProperty("_EmissionZone");
        MaterialProperty reactivity = FindProperty("_EmissionReactivity");
        MaterialProperty tint = FindProperty("_EmissionColor");

        GUILayout.Label(" ");
        GUILayout.Label("       Emission Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, new GUIContent("   Tint", "Emission tint. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones","Enables Luma Glow color control effects that are masked by your emission"));
        if (target.GetFloat("_EnableEmissionGlow") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        editor.ShaderProperty(reactivity, new GUIContent("   Audio Reactivity", "Enables additional audio reactive effects that are masked by your emission. Can be enabled separately from Luma Glow"));
        EditorGUI.indentLevel -= 2;
    }

    void DoExtraSimpleSettings()
    {
        MaterialProperty emissionZone = FindProperty("_EmissionZone");

        MaterialProperty emissionReact = FindProperty("_EmissionReactivity");

        MaterialProperty gradientDir = FindProperty("_GradientDirection");
        MaterialProperty lowsDir = FindProperty("_LowsPulseDirection");
        MaterialProperty highsDir = FindProperty("_HighsPulseDirection");

        bool gradientTog = false;
        bool lowsTog = false;
        bool highsTog = false;

        if (target.GetFloat("_EmissionZone") < 3 )
        {
            gradientTog = true;
        }

        if (target.GetFloat("_EmissionReactivity") == 2 )
        {
            lowsTog = true;
        }

        if (target.GetFloat("_EmissionReactivity") == 4 )
        {
            highsTog = true;
        }

        if (target.GetFloat("_EnableEmissionGlow") == 0)
        {
            gradientTog = false;
        }

        if (gradientTog is true ||
            lowsTog is true ||
            highsTog is true)
        {
            GUILayout.Label(" ");
            GUILayout.Label("Additional Properties", EditorStyles.boldLabel);
            EditorGUI.indentLevel += 2;

            if (gradientTog is true)
            {
                editor.ShaderProperty(gradientDir, "   Gradient Direction");
            }

            if (lowsTog is true)
            {
                editor.ShaderProperty(lowsDir, "   Lows Pulse Direction");
            }

            if (highsTog is true)
            {
                editor.ShaderProperty(highsDir, "   Highs Pulse Direction");
            }

            EditorGUI.indentLevel -= 2;
        }
    }

    void DoExtraGlowSettings()
    {
        MaterialProperty emissionZone = FindProperty("_EmissionZone");
        MaterialProperty zoneR = FindProperty("_GlowMaskZoneR");
        MaterialProperty zoneG = FindProperty("_GlowMaskZoneG");
        MaterialProperty zoneB = FindProperty("_GlowMaskZoneB");

        MaterialProperty emissionReact = FindProperty("_EmissionReactivity");
        MaterialProperty reactR = FindProperty("_ReacitvityR");
        MaterialProperty reactG = FindProperty("_ReacitvityG");
        MaterialProperty reactB = FindProperty("_ReacitvityB");

        MaterialProperty gradientDir = FindProperty("_GradientDirection");
        MaterialProperty lowsDir = FindProperty("_LowsPulseDirection");
        MaterialProperty highsDir = FindProperty("_HighsPulseDirection");

        bool gradientTog = false;
        bool lowsTog = false;
        bool highsTog = false;

        //if (target.GetFloat("_EmissionZone") < 3 ||
        //    target.GetFloat("_GlowMaskZoneR") < 3 ||
        //    target.GetFloat("_GlowMaskZoneG") < 3 ||
        //    target.GetFloat("_GlowMaskZoneB") < 3)
        //{
        //    gradientTog = true;
        //}

        if (target.GetFloat("_EmissionZone") < 3 && target.GetFloat("_EnableEmissionGlow") == 1) { gradientTog = true; }
        else if (target.GetFloat("_GlowMaskZoneR") < 3 && target.GetFloat("_EnableGlowMaskR") == 1) { gradientTog = true; }
        else if (target.GetFloat("_GlowMaskZoneG") < 3 && target.GetFloat("_EnableGlowMaskG") == 1) { gradientTog = true; }
        else if (target.GetFloat("_GlowMaskZoneB") < 3 && target.GetFloat("_EnableGlowMaskB") == 1) { gradientTog = true; }

        if (target.GetFloat("_EmissionReactivity") == 2 ||
            target.GetFloat("_ReacitvityR") == 2 ||
            target.GetFloat("_ReacitvityG") == 2 ||
            target.GetFloat("_ReacitvityB") == 2)
        {
            lowsTog = true;
        }

        if (target.GetFloat("_EmissionReactivity") == 4 ||
            target.GetFloat("_ReacitvityR") == 4 ||
            target.GetFloat("_ReacitvityG") == 4 ||
            target.GetFloat("_ReacitvityB") == 4)
        {
            highsTog = true;
        }

        //if (target.GetFloat("_EnableEmissionGlow") == 0 &&
        //    target.GetFloat("_EnableGlowMaskR") == 0 &&
        //    target.GetFloat("_EnableGlowMaskG") == 0 &&
        //    target.GetFloat("_EnableGlowMaskB") == 0)
        //{
        //    gradientTog = false;
        //}

        if (gradientTog is true ||
            lowsTog is true||
            highsTog is true)
        {
            GUILayout.Label(" ");
            GUILayout.Label("Additional Properties", EditorStyles.boldLabel);
            EditorGUI.indentLevel += 2;

            if (gradientTog is true)
            {
                editor.ShaderProperty(gradientDir, "   Gradient Direction");
            }

            if (lowsTog is true)
            {
                editor.ShaderProperty(lowsDir, "   Lows Pulse Direction");
            }

            if (highsTog is true)
            {
                editor.ShaderProperty(highsDir, "   Highs Pulse Direction");
            }

            EditorGUI.indentLevel -= 2;
        }
    }

        //Advanced Luma Glow Settings
    void DoGlowMask()
    {
        MaterialProperty map = FindProperty("_GlowMaskRGB");
        editor.TexturePropertySingleLine(MakeLabel(map, "RGB mask where each channel can be mapped to a different zone"), map);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        EditorGUI.indentLevel -= 2;
    }

    void DoRedChannelGlow()
    {
        MaterialProperty enable = FindProperty("_EnableGlowMaskR");
        MaterialProperty zone = FindProperty("_GlowMaskZoneR");
        MaterialProperty reactivity = FindProperty("_ReacitvityR");
        MaterialProperty tint = FindProperty("_GlowMaskTintR");

        GUILayout.Label(" ");
        GUILayout.Label("       Red Channel Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, new GUIContent("   Tint", "Tint for the red channel of the glow mask. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones", "Enables Luma Glow color control effects for the red channel of the glow mask"));
        if (target.GetFloat("_EnableGlowMaskR") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        editor.ShaderProperty(reactivity, new GUIContent("   Audio Reactivity", "Enables additional audio reactive effects for the red channel of the glow mask. Can be enabled separately from Luma Glow"));
        EditorGUI.indentLevel -= 2;
    }

    void DoGreenChannelGlow()
    {
        MaterialProperty enable = FindProperty("_EnableGlowMaskG");
        MaterialProperty zone = FindProperty("_GlowMaskZoneG");
        MaterialProperty reactivity = FindProperty("_ReacitvityG");
        MaterialProperty tint = FindProperty("_GlowMaskTintG");

        GUILayout.Label(" ");
        GUILayout.Label("       Green Channel Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, new GUIContent("   Tint", "Tint for the green channel of the glow mask. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones", "Enables Luma Glow color control effects for the green channel of the glow mask"));
        if (target.GetFloat("_EnableGlowMaskG") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        editor.ShaderProperty(reactivity, new GUIContent("   Audio Reactivity", "Enables additional audio reactive effects for the green channel of the glow mask. Can be enabled separately from Luma Glow"));
        EditorGUI.indentLevel -= 2;
    }

    void DoBlueChannelGlow()
    {
        MaterialProperty enable = FindProperty("_EnableGlowMaskB");
        MaterialProperty zone = FindProperty("_GlowMaskZoneB");
        MaterialProperty reactivity = FindProperty("_ReacitvityB");
        MaterialProperty tint = FindProperty("_GlowMaskTintB");

        GUILayout.Label(" ");
        GUILayout.Label("       Blue Channel Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, new GUIContent("   Tint", "Tint for the blue channel of the glow mask. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones", "Enables Luma Glow color control effects for the blue channel of the glow mask"));
        if (target.GetFloat("_EnableGlowMaskB") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        editor.ShaderProperty(reactivity, new GUIContent("   Audio Reactivity", "Enables additional audio reactive effects for the blue channel of the glow mask. Can be enabled separately from Luma Glow"));
        EditorGUI.indentLevel -= 2;
    }

    //Draw GUI

    public override void OnGUI(
    MaterialEditor editor, MaterialProperty[] properties
)
    {
        this.target = editor.target as Material;
        this.editor = editor;
        this.properties = properties;
        float settingsLevel = target.GetFloat("_SettingsMode");
        float advMode = target.GetFloat("_AdvToggle");

        DoSettingSelector();

        //Main Settings

        if (settingsLevel == 3)
        {
            GUILayout.Label("Main Settings", EditorStyles.boldLabel);
            GUILayout.Label(" ");
            DoMain();
            DoMetallic();
            DoSmoothness();
            DoNormals();
            DoOcclusion();
            DoEmission();
            if (advMode == 1)
            {
                DoEmissionMaskPan();
            }

            //Outline Settings

            DoOutlines();
        }

        //Lighting Style Selectors

        if (settingsLevel == 0)
        {
            GUILayout.Label("Lighting Settings", EditorStyles.boldLabel);
            GUILayout.Label(" ");
            GUILayout.Label(new GUIContent("           Lighting Styles","Stylizes different aspects of the lighting effects"), EditorStyles.boldLabel);
            DoLightingStyles();

            //Default Lighting Settings

            DoDistanceBlend();
            if (advMode == 1)
            {
                DoAdvancedShadow();
            }
            else if (advMode == 0)
            {
                DoSimpleShadow();
            }
            if (advMode == 1)
            {
                DoAdvancedSpecular();
            }
            else if (advMode == 0)
            {
                DoSimpleSpecular();
            }
            if (advMode == 1)
            {
                DoAdvancedRimlight();
            }
            else if (advMode == 0)
            {
                DoSimpleRimlight();
            }

            //Advanced Lighting Settings
            //if (advMode == 1)
            //{
                //GUILayout.Label("Advanced Lighting Settings", EditorStyles.boldLabel);
                //GUILayout.Label(" ");
                //GUILayout.Label("           Lighting Styles", EditorStyles.boldLabel);
                //DoLightingStyles();

                //DoDistanceBlend();
                //DoAdvancedShadow();
                //DoAdvancedSpecular();
                //DoAdvancedRimlight();
            //}
        }

        //Luma Glow Settings

            //Default Luma glow Settings
        if (settingsLevel == 2)
        {
            GUILayout.Label("Luma Glow Settings", EditorStyles.boldLabel);
            GUILayout.Label(" ");
            DoEmission();
            if (advMode == 1)
            {
                DoEmissionMaskPan();
            }
            DoSimpleLumaGlow();
            if (advMode == 0)
            {
                DoExtraSimpleSettings();
            }

            //Advanced Luma Glow Settings
            if (advMode == 1)
            {
                GUILayout.Label(" ");
                GUILayout.Label("Glow Mask Settings", EditorStyles.boldLabel);
                //DoEmission();
                DoGlowMask();
                GUILayout.Label(" ");
                // DoSimpleLumaGlow();
                DoRedChannelGlow();
                DoGreenChannelGlow();
                DoBlueChannelGlow();
                DoExtraGlowSettings();
            }
        }

        //Misc Settings

        GUILayout.Label(" ");
        GUILayout.Label("Misc Settings", EditorStyles.boldLabel);
        DoMaskClip();
        DoCullingMode();
        DoDebugMode();
        GUILayout.Label(" ");
        editor.RenderQueueField();
    }
}