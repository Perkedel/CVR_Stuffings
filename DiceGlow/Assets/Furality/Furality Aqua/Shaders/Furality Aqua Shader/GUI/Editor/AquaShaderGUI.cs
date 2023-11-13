using UnityEngine;
using UnityEditor;

public class AquaShaderGUI : ShaderGUI
{
    Material target;
    MaterialEditor editor;
    MaterialProperty[] properties;
    Shader defaultOpaque = Shader.Find("Furality/Aqua Shader/Aqua Shader");
    Shader defaultCutout = Shader.Find("Furality/Aqua Shader/Aqua Shader - Cutout");
    Shader defaultTransparent = Shader.Find("Furality/Aqua Shader/Aqua Shader - Transparent");
    Shader noOutlineOpaque = Shader.Find("Furality/Aqua Shader/Aqua Shader");
    Shader noOutlineCutout = Shader.Find("Furality/Aqua Shader/Aqua Shader - Cutout");
    Shader noOutlineTransparent = Shader.Find("Furality/Aqua Shader/Aqua Shader - No Outline Transparent");

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

    enum BlendOP
    {
        AlphaBlend = 0,
        Additive = 1,
        SoftAdditive = 2,
        Multiplicative = 3
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

    enum AuraColor
    {
        White = 0,
        Red = 1,
        Green = 2,
        Blue = 3,
        Magenta = 4,
        Cyan = 5,
        Yellow = 6,
        Orange = 7
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

    void DoNoise()
    {
        MaterialProperty mainTex = FindProperty("_Noise");
        editor.TexturePropertySingleLine(MakeLabel(mainTex, "Albedo (RGB)"), mainTex);
    }

    void DoAlpha()
    {
        MaterialProperty mainTex = FindProperty("_AlphaMask");
        editor.TexturePropertySingleLine(MakeLabel(mainTex, "Albedo (RGB)"), mainTex);
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(mainTex);
        EditorGUI.indentLevel -= 2;
    }

    //Normal Map

    void DoNormals()
    {
        MaterialProperty map = FindProperty("_BumpMap");
        editor.TexturePropertySingleLine(MakeLabel(map), map, FindProperty("_BumpScale"));
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        EditorGUI.indentLevel -= 2;
    }

    //Metallic

    void DoMetallic()
    {
        MaterialProperty map = FindProperty("_MetallicGlossMap");
        MaterialProperty metMult = FindProperty("_MetallicMult");
        editor.TexturePropertySingleLine(MakeLabel(map, "Metallic (R) Smoothness (A)"), map, FindProperty("_Metallic"));
        if (target.GetFloat("_AdvToggle") == 1)
        {
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(metMult, MakeLabel(metMult));
            EditorGUI.indentLevel -= 2;
        }
        DoWorkflowSelector();
        if (target.GetFloat("_UseSpecularTexture") == 1)
        {
            MaterialProperty map2 = FindProperty("_Specular");
            editor.TexturePropertySingleLine(new GUIContent("Specular", "Specular (RGB) Smoothness (A)"), map2, FindProperty("_SpecularTint"));
        }
    }

    //Smoothness

    void DoSmoothness()
    {
        MaterialProperty slider = FindProperty("_Glossiness");
        MaterialProperty smoothMult = FindProperty("_SmoothnessMult");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(slider, MakeLabel(slider));
        if (target.GetFloat("_AdvToggle") == 1)
        {
            editor.ShaderProperty(smoothMult, MakeLabel(smoothMult));
        }
        EditorGUI.indentLevel -= 2;
    }

    //Occlusion

    void DoOcclusion()
    {
        MaterialProperty map = FindProperty("_OcclusionMap");
        editor.TexturePropertySingleLine(MakeLabel(map, "Ambient Occlusion (G)"), map, FindProperty("_OcclusionStrength"));
    }

    //Emission

    void DoEmission()
    {
        MaterialProperty map = FindProperty("_EmissionMap");
        MaterialProperty toggle = FindProperty("_EnableEmission");
        MaterialProperty panning = FindProperty("_EmissionPan");
        MaterialProperty panDir = FindProperty("_EmissionPanSpeed");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, MakeLabel(toggle));
        EditorGUI.indentLevel -= 2;
        if (target.GetFloat("_EnableEmission") == 1)
        {
        editor.TexturePropertySingleLine(MakeLabel(map), map, FindProperty("_EmissionColor"));
        EditorGUI.indentLevel += 2;
        editor.TextureScaleOffsetProperty(map);
        //if (target.GetFloat("_AdvToggle") == 0)
        //{
            //editor.ShaderProperty(panning, MakeLabel(panning, "Toggles emission movement"));
            //if (target.GetFloat("_EmissionPan") == 1)
            //{
                //editor.ShaderProperty(panDir, MakeLabel(panDir, "Emission movement speed and direction"));
            //}
        //}
        EditorGUI.indentLevel -= 2;
        }

    }

    void DoEmissionMaskPan()
    {
        MaterialProperty map = FindProperty("_EffectMask");
        MaterialProperty panning = FindProperty("_EmissionPan");
        MaterialProperty panDir = FindProperty("_EmissionPanSpeed");
        MaterialProperty toggle = FindProperty("_MaskEmission");
        if (target.GetFloat("_EnableEmission") == 1 || target.GetFloat("_SettingsMode") == 4)
        {
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(toggle, MakeLabel(toggle));
            EditorGUI.indentLevel -= 2;
            if (target.GetFloat("_MaskEmission") == 1 || target.GetFloat("_SettingsMode") == 4)
            {
                editor.TexturePropertySingleLine(MakeLabel(map), map);
                EditorGUI.indentLevel += 2;
                editor.TextureScaleOffsetProperty(map);
                EditorGUI.indentLevel -= 2;
            }
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(panning, "Enable Emission Panning");

            if (target.GetFloat("_EmissionPan") == 1)
            {
                editor.ShaderProperty(panDir, MakeLabel(panDir, "Emission movement speed and direction"));
            }

            EditorGUI.indentLevel -= 2;
        }

    }

    //Settings Level Selector

    void DoSettingSelector()
    {
        MaterialProperty dropdown = FindProperty("_SettingsMode");
        MaterialProperty toggle = FindProperty("_AdvToggle");

        editor.ShaderProperty(dropdown, new GUIContent("Page", "Changes the settings page. Values are saved between pages"));
        //DoWorkflowSelector();

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

        if (target.GetFloat("_BlendModeIndex") == 2)
        {
            DoBlendOPSelctor();
        }

        editor.ShaderProperty(toggle, new GUIContent("Show Advanced Settings", "Shows additional options"));

    }

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

            if(target.GetFloat("_BlendOPIndex") == 3)
            {
                target.SetFloat("_BlendOPsrc", 2);
                target.SetFloat("_BlendOPdst", 0);
            }

        }

    }

    void DoAuraSelctor()
    {
        AuraColor operation = (AuraColor)target.GetFloat("_AuraColorIndex");
        EditorGUI.BeginChangeCheck();

        operation = (AuraColor)EditorGUILayout.EnumPopup(new GUIContent("         Aura Color Preset"), operation);

        Color orange = new Color(1f, 0.6470588f, 0f, 1f);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("         Aura Color Preset");
            target.SetFloat("_AuraColorIndex", (float)operation);

            if (target.GetFloat("_AuraColorIndex") == 0)
            {
                target.SetColor("_LumaAuraColor", Color.white);
            }

            if (target.GetFloat("_AuraColorIndex") == 1)
            {
                target.SetColor("_LumaAuraColor", Color.red);
            }

            if (target.GetFloat("_AuraColorIndex") == 2)
            {
                target.SetColor("_LumaAuraColor", Color.green);
            }

            if (target.GetFloat("_AuraColorIndex") == 3)
            {
                target.SetColor("_LumaAuraColor", Color.blue);
            }

            if (target.GetFloat("_AuraColorIndex") == 4)
            {
                target.SetColor("_LumaAuraColor", Color.magenta);
            }

            if (target.GetFloat("_AuraColorIndex") == 5)
            {
                target.SetColor("_LumaAuraColor", Color.cyan);
            }

            if (target.GetFloat("_AuraColorIndex") == 6)
            {
                target.SetColor("_LumaAuraColor", Color.yellow);
            }

            if (target.GetFloat("_AuraColorIndex") == 7)
            {
                target.SetColor("_LumaAuraColor", orange);
            }

        }

    }

    void DoWorkflowSelector()
    {
        MaterialProperty toggle = FindProperty("_UseSpecularTexture");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, new GUIContent("Use Specular", "Tints specular colors with this texture"));
        EditorGUI.indentLevel -= 2;
    }

    void DoOpaqueOutlines()
    {
        EditorGUI.indentLevel += 2;
        MaterialProperty toggle = FindProperty("_Outlines");
        MaterialProperty lineColor = FindProperty("_OutlineColor");
        MaterialProperty width = FindProperty("_OutlineWidth");
        editor.ShaderProperty(toggle, new GUIContent("Enable Outlines"));
        if (target.GetFloat("_Outlines") == 1)
        {
            editor.ShaderProperty(lineColor, MakeLabel(lineColor));
            editor.ShaderProperty(width, MakeLabel(width));
        }
        EditorGUI.indentLevel -= 2;
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
            //MaterialProperty outlineVal = FindProperty("_OutlineMaskClip");
            EditorGUI.indentLevel += 2;
            editor.ShaderProperty(val, MakeLabel(val));
            //if(target.shader == defaultCutout)
            //{
                //editor.ShaderProperty(outlineVal, MakeLabel(outlineVal));
            //}
            EditorGUI.indentLevel -= 2;
        }

    }

    //Outline Settings

    void DoOutlines()
    {

        if (target.shader == defaultTransparent)
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
        EditorGUILayout.Toggle(new GUIContent("Enable Outlines"), enableOutline);

        if (EditorGUI.EndChangeCheck())
        {
            editor.RegisterPropertyChangeUndo("Enable Outline");
            if (enableOutline is false)
            {
                //if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                //{
                    //editor.SetShader(defaultOpaque);
                //}
                //else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                //{
                    //editor.SetShader(defaultCutout);
                //}
                if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
                {
                    editor.SetShader(defaultTransparent);
                }
                enableOutline = true;
            }
            else if (enableOutline is true)
            {
                //if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque)
                //{
                    //editor.SetShader(noOutlineOpaque);
                //}
                //else if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
                //{
                    //editor.SetShader(noOutlineCutout);
                //}
                if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Transparent)
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
            //MaterialProperty depth = FindProperty("_OutlineDepthFade");
            editor.ShaderProperty(tint, MakeLabel(tint));
            editor.ShaderProperty(width, MakeLabel(width));
            //if ((BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Opaque || (BlendMode)target.GetFloat("_BlendModeIndex") == BlendMode.Cutout)
            //{
                //editor.ShaderProperty(depth, MakeLabel(depth));
            //}
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
        MaterialProperty toonSpec = FindProperty("_ToonSpecular");
        MaterialProperty toonSpecSize = FindProperty("_ToonSpecularSize");
        //MaterialProperty posterize = FindProperty("_PosterizeSpecular");
        //MaterialProperty pSlices = FindProperty("_PosterizedSpecularSlices");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(tint, MakeLabel(tint));
        editor.ShaderProperty(toonSpec, MakeLabel(toonSpec));
        editor.ShaderProperty(toonSpecSize, MakeLabel(toonSpecSize));
        //editor.ShaderProperty(posterize, MakeLabel(posterize, "Slices specular into steps"));
        //editor.ShaderProperty(pSlices, MakeLabel(pSlices, "The number of posterized slices"));
        EditorGUI.indentLevel -= 2;
    }

        //Rimlight
    void DoSimpleRimlight()
    {
        MaterialProperty tint = FindProperty("_RimlightColor");
        MaterialProperty toonRim = FindProperty("_RimlightToon");
        MaterialProperty toonRimScale = FindProperty("_RimlightScale");
        MaterialProperty toonRimOffset = FindProperty("_RimOffset");
        MaterialProperty posterize = FindProperty("_PosterizeRimLighting");
        MaterialProperty pSlices = FindProperty("_PosterizedRimLightingSlices");
        MaterialProperty rimSpec = FindProperty("_RimlightSpecularInfluence");
        MaterialProperty toggle = FindProperty("_Rimlighting");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, MakeLabel(toggle));
        if (target.GetFloat("_Rimlighting") == 1) 
        {
            editor.ShaderProperty(tint, MakeLabel(tint));
            editor.ShaderProperty(toonRim, MakeLabel(toonRim));
            editor.ShaderProperty(toonRimOffset, MakeLabel(toonRimOffset));
            editor.ShaderProperty(posterize, MakeLabel(posterize, "Slices lighting into steps"));
            editor.ShaderProperty(pSlices, MakeLabel(pSlices, "The number of posterized slices"));
            editor.ShaderProperty(rimSpec, MakeLabel(rimSpec, "Tints rimlighting by specular colors"));
        }

        EditorGUI.indentLevel -= 2;
    }

        //Shadows
    void DoSimpleShadow()
    {
        MaterialProperty soften = FindProperty("_SoftenLighting");
        MaterialProperty toon1 = FindProperty("_ToonLighting1");
        MaterialProperty toon2 = FindProperty("_ToonLighting2");
        MaterialProperty posterize = FindProperty("_PosterizeLighting");
        MaterialProperty pSlices = FindProperty("_PosterizedLightingSlices");
        MaterialProperty offset = FindProperty("_ShadingOffset");
        MaterialProperty secret = FindProperty("_SecretLightingToggle");
        //GUILayout.Label(" ");
        //GUILayout.Label(new GUIContent("       Shadow Settings", "Settings for custom shadow ramps"), EditorStyles.boldLabel);
        //GUILayout.Label("               Shadow Style Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(soften, MakeLabel(soften, "Lightens shadows. Similar to minimum brightness in other shaders"));
        editor.ShaderProperty(toon1, MakeLabel(toon1, "Sharpens the transition between shaded and lit areas"));
        if (target.GetFloat("_SecretLightingToggle") == 1)
        {
        editor.ShaderProperty(toon2, MakeLabel(toon2, "Sharpens the transition of view direction lighting"));
        }
        editor.ShaderProperty(offset, MakeLabel(offset, "Pushes shadow gradient forward/back"));
        editor.ShaderProperty(posterize, MakeLabel(posterize, "Slices lighting into steps"));
        editor.ShaderProperty(pSlices, MakeLabel(pSlices, "The number of posterized slices"));
        EditorGUI.indentLevel -= 2;
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
        if (target.GetFloat("_AdvToggle") == 1)
        {
            editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects that are masked by your emission. Can be enabled separately from Luma Glow"));
        }

        EditorGUI.indentLevel -= 2;
    }

    void DoSimpleOutlineGlow()
    {
        MaterialProperty enable = FindProperty("_EnableOutlineGlow");
        MaterialProperty zone = FindProperty("_OutlineZone");
        MaterialProperty reactivity = FindProperty("_OutlineReactivity");
        //MaterialProperty tint = FindProperty("_OutlineColor");

        GUILayout.Label(" ");
        GUILayout.Label("       Outline Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        //editor.ShaderProperty(tint, new GUIContent("   Tint", "Outline tint. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones", "Enables Luma Glow color control effects for your outlines"));
        if (target.GetFloat("_EnableOutlineGlow") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        if (target.GetFloat("_AdvToggle") == 1)
        {
            editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects that are for your outlines. Should be enabled separately from Luma Glow"));
        }

        EditorGUI.indentLevel -= 2;
    }

    void DoSimpleRimlightGlow()
    {
        MaterialProperty enable = FindProperty("_EnableRimlightGlow");
        MaterialProperty zone = FindProperty("_RimlightZone");
        MaterialProperty reactivity = FindProperty("_RimlightReactivity");
        //MaterialProperty tint = FindProperty("_OutlineColor");

        GUILayout.Label(" ");
        GUILayout.Label("       Rimlight Glow", EditorStyles.boldLabel);
        EditorGUI.indentLevel += 2;
        //editor.ShaderProperty(tint, new GUIContent("   Tint", "Outline tint. Will also tint Luma Glow colors"));
        editor.ShaderProperty(enable, new GUIContent("   Enable Zones", "Enables Luma Glow color control effects for your rimlight"));
        if (target.GetFloat("_EnableRimlightGlow") == 1)
        {
            editor.ShaderProperty(zone, "   Zone");
        }
        if (target.GetFloat("_AdvToggle") == 1)
        {
            editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects that are for your rimlight. Should be enabled separately from Luma Glow"));

        }
        EditorGUI.indentLevel -= 2;
    }

    void DoSparkles()
    {
        MaterialProperty color = FindProperty("_SparkleColor");
        MaterialProperty threshold = FindProperty("_SparkleThreshold");
        MaterialProperty size = FindProperty("_SparkleSize");
        MaterialProperty speed = FindProperty("_SparkleSpeed");
        MaterialProperty tiling = FindProperty("_SparkleTiling");
        MaterialProperty depth = FindProperty("_SparkleDepth");
        MaterialProperty toggle = FindProperty("_Sparkles");
        MaterialProperty togMask = FindProperty("_MaskSparklesB");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, MakeLabel(toggle));
        if (target.GetFloat("_Sparkles") == 1)
        {
            editor.ShaderProperty(color, MakeLabel(color));
            editor.ShaderProperty(tiling, MakeLabel(tiling));
            editor.ShaderProperty(threshold, MakeLabel(threshold));
            editor.ShaderProperty(size, MakeLabel(size));
            editor.ShaderProperty(speed, MakeLabel(speed));
            editor.ShaderProperty(depth, MakeLabel(depth));
            editor.ShaderProperty(togMask, MakeLabel(togMask));
        }
        EditorGUI.indentLevel -= 2;
    }

    void DoLumaFlow()
    {
        MaterialProperty color = FindProperty("_LumaFlowColor");
        MaterialProperty threshold = FindProperty("_SparkleThreshold");
        MaterialProperty size = FindProperty("_LumaFlowTiling");
        MaterialProperty speed = FindProperty("_LumaFlowSpeed");
        MaterialProperty distortion = FindProperty("_LumaFlowDistortion");
        MaterialProperty toggle = FindProperty("_LumaFlow");
        MaterialProperty togMask = FindProperty("_MaskLumaFlowG");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(toggle, MakeLabel(toggle));
        if (target.GetFloat("_LumaFlow") == 1)
        {
            editor.ShaderProperty(color, MakeLabel(color));
            editor.ShaderProperty(size, MakeLabel(size));
            editor.ShaderProperty(distortion, MakeLabel(distortion));
            editor.ShaderProperty(speed, MakeLabel(speed));
            editor.ShaderProperty(togMask, MakeLabel(togMask));
        }
        EditorGUI.indentLevel -= 2;
    }

    void DoLumaAura()
    {
        MaterialProperty color = FindProperty("_LumaAuraColor");
        EditorGUI.indentLevel += 2;
        editor.ShaderProperty(color, MakeLabel(color));
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

        if (target.GetFloat("_EmissionZone") < 3 || target.GetFloat("_OutlineZone") < 3 || target.GetFloat("_RimlightZone") < 3)
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

        if (
            gradientTog is true ||
            lowsTog is true ||
            highsTog is true
           )
        {
            GUILayout.Label(" ");
            GUILayout.Label("Additional Properties", EditorStyles.boldLabel);
            MaterialProperty map = FindProperty("_GradientDirectionMap");
            editor.TexturePropertySingleLine(MakeLabel(map), map);
            EditorGUI.indentLevel += 2;
            editor.TextureScaleOffsetProperty(map);
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
        else if (target.GetFloat("_OutlineZone") < 3 && target.GetFloat("_EnableOutlineGlow") == 1) { gradientTog = true; }
        else if (target.GetFloat("_RimlightZone") < 3 && target.GetFloat("_EnableRimlightGlow") == 1) { gradientTog = true; }

        if (
                target.GetFloat("_EmissionReactivity") == 2 ||
                target.GetFloat("_ReacitvityR") == 2 ||
                target.GetFloat("_ReacitvityG") == 2 ||
                target.GetFloat("_ReacitvityB") == 2 ||
                target.GetFloat("_OutlineReactivity") == 2 ||
                target.GetFloat("_RimlightReactivity") == 2
            )
        {
            lowsTog = true;
        }

        if (
                target.GetFloat("_EmissionReactivity") == 4 ||
                target.GetFloat("_ReacitvityR") == 4 ||
                target.GetFloat("_ReacitvityG") == 4 ||
                target.GetFloat("_ReacitvityB") == 4 ||
                target.GetFloat("_OutlineReactivity") == 4 ||
                target.GetFloat("_RimlightReactivity") == 4
            )
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
            MaterialProperty map = FindProperty("_GradientDirectionMap");
            editor.TexturePropertySingleLine(MakeLabel(map), map);
            EditorGUI.indentLevel += 2;
            editor.TextureScaleOffsetProperty(map);

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
        editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects for the red channel of the glow mask. Can be enabled separately from Luma Glow"));
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
        editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects for the green channel of the glow mask. Can be enabled separately from Luma Glow"));
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
        editor.ShaderProperty(reactivity, new GUIContent("   Spectrum Reactivity", "Enables additional audio reactive effects for the blue channel of the glow mask. Can be enabled separately from Luma Glow"));
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

            if (target.GetFloat("_BlendModeIndex") > 0)
            {
                DoAlpha();
            }

            DoMetallic();
            DoSmoothness();
            DoNormals();
            DoOcclusion();
            DoEmission();
            //if (advMode == 1)
            //{
                DoEmissionMaskPan();
            //}

            //Outline Settings
            GUILayout.Label(" ");

            if (target.GetFloat("_BlendModeIndex") == 2)
            {
                DoOutlines();
            }
            else
            {
                GUILayout.Label("Outline Settings", EditorStyles.boldLabel);
                DoOpaqueOutlines();
            }
        }

        //Lighting Style Selectors

        if (settingsLevel == 0)
        {
            GUILayout.Label("Lighting Settings", EditorStyles.boldLabel);
            GUILayout.Label(" ");
            EditorGUI.indentLevel += 2;
            MaterialProperty fakeLight = FindProperty("_FakeLightDir");
            editor.ShaderProperty(fakeLight, MakeLabel(fakeLight));
            EditorGUI.indentLevel -= 2;
            //GUILayout.Label(" ");
            GUILayout.Label("   Shadow Settings", EditorStyles.boldLabel);
            //GUILayout.Label(new GUIContent("           Lighting Styles","Stylizes different aspects of the lighting effects"), EditorStyles.boldLabel);
            //DoLightingStyles();

            //Default Lighting Settings
            DoSimpleShadow();
            GUILayout.Label(" ");
            GUILayout.Label("   Specular Settings", EditorStyles.boldLabel);
            DoSimpleSpecular();
            GUILayout.Label(" ");
            GUILayout.Label("   Rimlight Settings", EditorStyles.boldLabel);
            DoSimpleRimlight();

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
            //if (advMode == 1)
            //{
                DoEmissionMaskPan();
            //}
            DoSimpleLumaGlow();
            DoSimpleOutlineGlow();
            DoSimpleRimlightGlow();
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

        //Effect settings

        if (settingsLevel == 4)
        {
            GUILayout.Label("Effect Settings", EditorStyles.boldLabel);
            GUILayout.Label(" ");
            DoEmission();
            DoEmissionMaskPan();
            DoNoise();
            GUILayout.Label(" ");
            GUILayout.Label("   Luma Aura Settings", EditorStyles.boldLabel);

            if (advMode == 0)
            {
                DoAuraSelctor();
            }
            else
            {
                DoLumaAura();
            }

            GUILayout.Label(" ");
            GUILayout.Label("   Luma Flow Settings", EditorStyles.boldLabel);
            DoLumaFlow();
            GUILayout.Label(" ");
            GUILayout.Label("   Sparkle Settings", EditorStyles.boldLabel);
            DoSparkles();
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