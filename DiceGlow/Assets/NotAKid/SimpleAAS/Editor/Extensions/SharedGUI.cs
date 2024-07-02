using UnityEngine;

namespace NAK.SimpleAAS.Extensions
{
    public static class SharedGUI
    {
        #region Constructor

        static SharedGUI()
        {
            s_ReorderableListAltRowTex = new Texture2D(1, 1);
            s_ReorderableListAltRowTex.SetPixel(0, 0, new Color(0.2f, 0.2f, 0.2f, 0.6f));
            s_ReorderableListAltRowTex.Apply();
        }

        #endregion Constructor
        
        #region ReorderableList Background

        private static readonly Texture2D s_ReorderableListAltRowTex;
        
        public static void DrawAlternateBackground(Rect rect)
        {
            Rect bgRect = new(rect);
            
            //const int dragAreaPadding = 20;
            //bgRect.x -= dragAreaPadding;
            //bgRect.width +=dragAreaPadding;
            DrawTexture(bgRect, s_ReorderableListAltRowTex);
        }

        #endregion ReorderableList Background
        
        #region Texture Drawing

        private static void DrawTexture(Rect rect, Texture2D texture, ScaleMode scaleMode = ScaleMode.StretchToFill)
        {
            if (Event.current.type != EventType.Repaint) return;
            GUI.DrawTexture(rect, texture, scaleMode);
        }
        
        #endregion Texture Drawing
    }
}