using UnityEditor;
using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;
using System.Linq;

namespace SilentFakeGlass.Unity
{
	public partial class FakeGlassInspector : ShaderGUI
	{

		sealed class DefaultStyles
		{
			public static GUIStyle scmStyle;
			public static GUIStyle sectionHeader;
			public static GUIStyle sectionHeaderBox;
            static DefaultStyles()
            {
				scmStyle = new GUIStyle("DropDownButton");
				sectionHeader = new GUIStyle(EditorStyles.miniBoldLabel);
				sectionHeader.padding.left = 24;
				sectionHeader.padding.right = -24;
				sectionHeaderBox = new GUIStyle( GUI.skin.box );
				sectionHeaderBox.alignment = TextAnchor.MiddleLeft;
				sectionHeaderBox.padding.left = 5;
				sectionHeaderBox.padding.right = -5;
				sectionHeaderBox.padding.top = 0;
				sectionHeaderBox.padding.bottom = 0;
			}
		}	

		sealed class HeaderExDecorator : MaterialPropertyDrawer
    	{
	        private readonly string header;

	        public HeaderExDecorator(string header)
	        {
	            this.header = header;
	        }

	        // so that we can accept Header(1) and display that as text
	        public HeaderExDecorator(float headerAsNumber)
	        {
	            this.header = headerAsNumber.ToString();
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	        {
	            return 24f;
	        }

	        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
	        {/*
	            position.y += 8;
	            position = EditorGUI.IndentedRect(position);
	            GUI.Label(position, header, EditorStyles.boldLabel);
*/
            Rect r = position;
				r.x -= 2.0f;
				r.y += 2.0f;
				r.height = 18.0f;
				r.width -= 0.0f;
			GUI.Box(r, EditorGUIUtility.IconContent("d_FilterByType"), DefaultStyles.sectionHeaderBox);
			position.y += 2;
			GUI.Label(position, header, DefaultStyles.sectionHeader);
	        }
    	}

	    sealed class SetKeywordDrawer : MaterialPropertyDrawer
	    {
	        static bool s_drawing;

	        readonly string _keyword;

	        public SetKeywordDrawer() : this(default) { }

	        public SetKeywordDrawer(string keyword)
	        {
	            _keyword = keyword;
	        }

	        public override void Apply(MaterialProperty prop)
	        {
	            if (!string.IsNullOrEmpty(_keyword))
	            {
	                foreach (Material mat in prop.targets)
	                {
	                    if (mat.GetTexture(prop.name) != null)
	                        mat.EnableKeyword(_keyword);
	                    else
	                        mat.DisableKeyword(_keyword);
	                }
	            }
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	            => 0;

	        public override void OnGUI(Rect position, MaterialProperty prop, GUIContent label, MaterialEditor editor)
	        {
	            if (s_drawing)
	            {
	                editor.DefaultShaderProperty(position, prop, label.text);
	            }
	            else if (prop.type == MaterialProperty.PropType.Texture)
	            {
	                var oldLabelWidth = EditorGUIUtility.labelWidth;
	                EditorGUIUtility.labelWidth = 0f;
	                s_drawing = true;
	                try
	                {
	                    EditorGUI.BeginChangeCheck();
	                    {
	                        editor.TextureProperty(prop, label.text);
	                    }
	                    if (EditorGUI.EndChangeCheck())
	                    {
	                        if (!string.IsNullOrEmpty(_keyword))
	                        {
	                            var useTexture = prop.textureValue != null;
	                            foreach (Material mat in prop.targets)
	                            {
	                                if (useTexture)
	                                    mat.EnableKeyword(_keyword);
	                                else
	                                    mat.DisableKeyword(_keyword);
	                            }
	                        }
	                    }
	                }
	                finally
	                {
	                    s_drawing = false;
	                    EditorGUIUtility.labelWidth = oldLabelWidth;
	                }
	            }
	        }
	    }

    	// From momoma's GeneLit, used with permission
    	// https://github.com/momoma-null/GeneLit
	    sealed class SingleLineDrawer : MaterialPropertyDrawer
	    {
	        static bool s_drawing;

	        readonly string _extraPropName;
	        readonly string _keyword;

	        public SingleLineDrawer() : this(default, default) { }

	        public SingleLineDrawer(string extraPropName) : this(extraPropName, default) { }

	        public SingleLineDrawer(string extraPropName, string keyword)
	        {
	            _extraPropName = extraPropName;
	            _keyword = keyword;
	        }

	        public override void Apply(MaterialProperty prop)
	        {
	            if (!string.IsNullOrEmpty(_keyword))
	            {
	                foreach (Material mat in prop.targets)
	                {
	                    if (mat.GetTexture(prop.name) != null)
	                        mat.EnableKeyword(_keyword);
	                    else
	                        mat.DisableKeyword(_keyword);
	                }
	            }
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	            => 0;

	        public override void OnGUI(Rect position, MaterialProperty prop, GUIContent label, MaterialEditor editor)
	        {
	            if (s_drawing)
	            {
	                editor.DefaultShaderProperty(position, prop, label.text);
	            }
	            else if (prop.type == MaterialProperty.PropType.Texture)
	            {
	                var oldLabelWidth = EditorGUIUtility.labelWidth;
	                EditorGUIUtility.labelWidth = 0f;
	                s_drawing = true;
	                try
	                {
	                    EditorGUI.BeginChangeCheck();
	                    if (string.IsNullOrEmpty(_extraPropName))
	                    {
	                        editor.TexturePropertySingleLine(label, prop);
	                    }
	                    else
	                    {
	                        var extraProp = MaterialEditor.GetMaterialProperty(prop.targets, _extraPropName);
	                        if (extraProp.type == MaterialProperty.PropType.Color && (extraProp.flags & MaterialProperty.PropFlags.HDR) > 0)
	                            editor.TexturePropertyWithHDRColor(label, prop, extraProp, false);
	                        else
	                            editor.TexturePropertySingleLine(label, prop, extraProp);
	                    }
	                    if (EditorGUI.EndChangeCheck())
	                    {
	                        if (!string.IsNullOrEmpty(_keyword))
	                        {
	                            var useTexture = prop.textureValue != null;
	                            foreach (Material mat in prop.targets)
	                            {
	                                if (useTexture)
	                                    mat.EnableKeyword(_keyword);
	                                else
	                                    mat.DisableKeyword(_keyword);
	                            }
	                        }
	                    }
	                }
	                finally
	                {
	                    s_drawing = false;
	                    EditorGUIUtility.labelWidth = oldLabelWidth;
	                }
	            }
	        }
	    }

    	sealed class ScaleOffsetDecorator : MaterialPropertyDrawer
    	{
    	    bool _initialized = false;
	
    	    public ScaleOffsetDecorator() { }
	
    	    public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
    	    {
    	        if (!_initialized)
    	        {
    	            prop.ReplacePostDecorator(this);
    	            _initialized = true;
    	        }
    	        return 2f * EditorGUIUtility.singleLineHeight + EditorGUIUtility.standardVerticalSpacing;
    	    }
	
    	    public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
    	    {
    	        position.xMin += 15f;
    	        position.y = position.yMax - (2f * EditorGUIUtility.singleLineHeight + 2.5f * EditorGUIUtility.standardVerticalSpacing);
    	        editor.TextureScaleOffsetProperty(position, prop);
    	    }
    	}
    	
	    sealed class IfDefDecorator : MaterialPropertyDrawer
	    {
	        readonly string _keyword;

	        public IfDefDecorator(string keyword)
	        {
	            _keyword = keyword;
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	        {
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            var enabled = materials[0].IsKeywordEnabled(_keyword);
	            if (!enabled)
	            {
	                prop.SkipRemainingDrawers(this);
	            }
	            else
	            {
	                for (var i = 1; i < materials.Length; ++i)
	                {
	                    if (materials[i].IsKeywordEnabled(_keyword) != enabled)
	                    {
	                        prop.SkipRemainingDrawers(this);
	                        break;
	                    }
	                }
	            }
	            return 0;
	        }

	        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
	        {
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            var enabled = materials[0].IsKeywordEnabled(_keyword);
	            if (!enabled)
	            {
	                prop.SkipRemainingDrawers(this);
	            }
	            else
	            {
	                for (var i = 1; i < materials.Length; ++i)
	                {
	                    if (materials[i].IsKeywordEnabled(_keyword) != enabled)
	                    {
	                        prop.SkipRemainingDrawers(this);
	                        break;
	                    }
	                }
	            }
	        }
	    }

	    sealed class IfNDefDecorator : MaterialPropertyDrawer
	    {
	        static readonly float s_helpBoxHeight = EditorStyles.helpBox.CalcHeight(GUIContent.none, 0f);

	        readonly string _keyword;

	        public IfNDefDecorator(string keyword)
	        {
	            _keyword = keyword;
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	        {
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            var enabled = materials[0].IsKeywordEnabled(_keyword);
	            if (enabled)
	            {
	                prop.SkipRemainingDrawers(this);
	            }
	            else
	            {
	                for (var i = 1; i < materials.Length; ++i)
	                {
	                    if (materials[i].IsKeywordEnabled(_keyword) != enabled)
	                    {
	                        prop.SkipRemainingDrawers(this);
	                        break;
	                    }
	                }
	            }
	            return 0;
	        }

	        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
	        {
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            var enabled = materials[0].IsKeywordEnabled(_keyword);
	            if (enabled)
	            {
	                prop.SkipRemainingDrawers(this);
	            }
	            else
	            {
	                for (var i = 1; i < materials.Length; ++i)
	                {
	                    if (materials[i].IsKeywordEnabled(_keyword) != enabled)
	                    {
	                        prop.SkipRemainingDrawers(this);
	                        break;
	                    }
	                }
	            }
	        }
	    }
    	
	    sealed class LTCGIDecorator : MaterialPropertyDrawer
	    {
	        readonly string _keyword;

	        public LTCGIDecorator(string keyword)
	        {
	            _keyword = keyword;
	        }

	        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
	        {
    			#if LTCGI_INCLUDED
	            return 0;
	            #else
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            for (var i = 1; i < materials.Length; ++i)
				{
                    materials[i].SetFloat(_keyword, 0.0f);
                    materials[i].DisableKeyword(_keyword);
				}
				prop.SkipRemainingDrawers(this);
	            return 0;
				#endif
	        }

	        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
	        {
    			#if LTCGI_INCLUDED
	            return;
	            #else
	            var materials = Array.ConvertAll(prop.targets, o => o as Material);
	            for (var i = 1; i < materials.Length; ++i)
				{
                    materials[i].SetFloat(_keyword, 0.0f);
                    materials[i].DisableKeyword(_keyword);
				}
				prop.SkipRemainingDrawers(this);
				#endif
	        }
	    }
    }
}
