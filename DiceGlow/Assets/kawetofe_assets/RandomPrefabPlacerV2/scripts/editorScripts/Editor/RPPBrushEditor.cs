
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEditorInternal;


namespace kawetofe.randomPrefabPlacer
{

    [CustomEditor(typeof(RPPBrush))]
    public class RPPBrushEditor : Editor
    {
        public RPPBrush brush;
        public ReorderableList reorderableList;
        public int selectedItem = -1;
       // public RandomPrefabPlacer placer = null;

        
               
        public void OnEnable()
        {
           
            if(this.brush == null)
                brush = (RPPBrush)target;
            reorderableList = new ReorderableList(brush.prefabs, typeof(PlacementPrefab), true, true, true, true);

            // Add Listeners to draw events
            reorderableList.drawHeaderCallback += DrawHeader;
            reorderableList.drawElementCallback += DrawElement;
            reorderableList.onAddCallback += AddItem;
            reorderableList.onRemoveCallback += RemoveItem;
            reorderableList.onSelectCallback += SelectItem;
        }

       

        public void OnDisable()
        {
            reorderableList.drawHeaderCallback -= DrawHeader;
            reorderableList.drawElementCallback -= DrawElement;

            reorderableList.onAddCallback -= AddItem;
            reorderableList.onRemoveCallback -= RemoveItem;
            
        }


        public override void OnInspectorGUI()
        {
            selectedItem = reorderableList.index;
            reorderableList.DoLayoutList();
            PlacementPrefab p;
            p = new PlacementPrefab();
            AssetPreview.SetPreviewTextureCacheSize(5000);
            if (selectedItem != -1)
            {
                p = brush.prefabs[selectedItem];
                Texture2D brushImg = new Texture2D(100, 100);
                Texture2D tx = AssetPreview.GetAssetPreview(p.prefab);
                if(tx != null)
                {
                    brushImg = new Texture2D(tx.width, tx.height);
                    brushImg.SetPixels(tx.GetPixels());
                    brushImg.Apply();
                } else
                {
                    brushImg = (Texture2D)AssetDatabase.LoadAssetAtPath("Assets/kawetofe_assets/RandomPrefabPlacerV2/scripts/editorScripts/Images/kw_icon_brush.png", typeof(Texture2D));
                }
                            
                //brushImg = (Texture2D)AssetDatabase.LoadAssetAtPath("Assets/kawetofe_assets/RandomPrefabPlacer/scripts/editorScripts/Images/kw_icon_brush.png", typeof(Texture));
                
                //if (p.prefab.name != "unassigned")
                //{
                //    brushImg = null;
                //    int counter = 0;
                    

                //    if (AssetPreview.GetAssetPreview(p.prefab) != null) {
                //        //brushImg = AssetPreview.GetAssetPreview(p.prefab);
                        
                //    } else
                //    {
                //        brushImg = AssetPreview.GetMiniThumbnail(p.prefab);
                //        EditorGUILayout.LabelField(p.prefab.name + AssetPreview.IsLoadingAssetPreviews());
                //    }

                //} else
                //{
                //    brushImg = AssetPreview.GetMiniThumbnail(p.prefab);
                //}
                
                EditorGUI.DrawPreviewTexture(EditorGUILayout.GetControlRect(false, GUILayout.Width(100),GUILayout.Height(100)), brushImg);
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Prefab Object");
                brush.prefabs[selectedItem].prefab = EditorGUILayout.ObjectField(brush.prefabs[selectedItem].prefab, typeof(GameObject), false) as GameObject;
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                brush.prefabs[selectedItem].allowedLayers = LayerMaskField("Allowed Layers", brush.prefabs[selectedItem].allowedLayers);            
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.Separator();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Possibility");
                brush.prefabs[selectedItem].possibility = EditorGUILayout.Slider(brush.prefabs[selectedItem].possibility, 0, 1f);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.Separator();
                EditorGUILayout.BeginHorizontal();            
                EditorGUILayout.MinMaxSlider("Scale Range", ref brush.prefabs[selectedItem].scaleMin, ref brush.prefabs[selectedItem].scaleMax, 0, 10f);
                                
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginVertical();
                EditorGUILayout.LabelField("min = "+brush.prefabs[selectedItem].scaleMin.ToString());
                EditorGUILayout.LabelField("max = "+brush.prefabs[selectedItem].scaleMax.ToString());
                EditorGUILayout.EndVertical();
                EditorGUILayout.EndHorizontal();
           
                EditorGUILayout.Separator();
                EditorGUILayout.BeginHorizontal();
            
                bool xLock = IntToBool((int)p.lockedRotations.x);
                bool yLock = IntToBool((int)p.lockedRotations.y);
                bool zLock = IntToBool((int)p.lockedRotations.z);
                EditorGUILayout.LabelField("Locked Rotations");
                EditorGUILayout.BeginVertical();
                xLock = EditorGUILayout.Toggle("x",xLock);
                yLock = EditorGUILayout.Toggle("y",yLock);
                zLock = EditorGUILayout.Toggle("z",zLock);
                EditorGUILayout.EndVertical();
                Vector3 rotLock = new Vector3(BoolToInt(xLock), BoolToInt(yLock), BoolToInt(zLock));
                p.lockedRotations = rotLock;
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                p.maxSlopeAngle = EditorGUILayout.Slider("max slope angle:", p.maxSlopeAngle, 1f, 360f);
                EditorGUILayout.EndHorizontal();
                p.useNormalsForRotation = EditorGUILayout.Toggle("use normals for rotation",p.useNormalsForRotation);
            }
        }

        private void DrawHeader(Rect rect)
        {
            GUI.Label(rect, "Prefabs");
        }

        private void DrawElement(Rect rect, int index, bool active, bool focused)
        {
            PlacementPrefab prefab = brush.prefabs[index];

            EditorGUI.BeginChangeCheck();
            Texture2D brushImg = AssetPreview.GetAssetPreview(prefab.prefab);
            if(brushImg == null)
            {
                brushImg = (Texture2D)AssetDatabase.LoadAssetAtPath("Assets/kawetofe_assets/RandomPrefabPlacerV2/scripts/editorScripts/Images/kw_icon_brush.png", typeof(Texture));
            }
            GUI.DrawTexture(rect, brushImg,ScaleMode.ScaleToFit);
            GUILayout.BeginHorizontal();
            string name = "Empty";
            if(prefab.prefab != null)
            {
                name = prefab.prefab.name;
            }
            GUI.Label(rect, name);            
            GUILayout.EndHorizontal();
            

            if (EditorGUI.EndChangeCheck()){
                EditorUtility.SetDirty(target);
            }
            EditorUtility.SetDirty(target);
        }

        private void AddItem(ReorderableList list)
        {
            PlacementPrefab p = new PlacementPrefab();
            p.prefab = new GameObject();
            p.prefab.name = "unassigned";
            p.allowedLayers = ~0;
            p.lockedRotations = new Vector3(1, 0, 1);
            p.maxSlopeAngle = 45f;

            brush.prefabs.Add(p);
            selectedItem = brush.prefabs.Count - 1;
            

            EditorUtility.SetDirty(target);
        }
        
        private void RemoveItem(ReorderableList list)
        {
            brush.prefabs.RemoveAt(list.index);
            selectedItem = -1;
            EditorUtility.SetDirty(target);
        }

        private void SelectItem(ReorderableList list)
        {
           
            selectedItem = list.index;
           
            EditorUtility.SetDirty(target);
        }

        static List<int> layerNumbers = new List<int>();

        static LayerMask LayerMaskField(string label, LayerMask layerMask)
        {
            var layers = InternalEditorUtility.layers;

            layerNumbers.Clear();

            for (int i = 0; i < layers.Length; i++)
                layerNumbers.Add(LayerMask.NameToLayer(layers[i]));

            int maskWithoutEmpty = 0;
            for (int i = 0; i < layerNumbers.Count; i++)
            {
                if (((1 << layerNumbers[i]) & layerMask.value) > 0)
                    maskWithoutEmpty |= (1 << i);
            }

            maskWithoutEmpty = UnityEditor.EditorGUILayout.MaskField(label, maskWithoutEmpty, layers);

            int mask = 0;
            for (int i = 0; i < layerNumbers.Count; i++)
            {
                if ((maskWithoutEmpty & (1 << i)) > 0)
                    mask |= (1 << layerNumbers[i]);
            }
            layerMask.value = mask;

            return layerMask;
        }

        static int BoolToInt(bool b)
        {
            int val;
            if (b)
            {
                val = 1;
            } else
            {
                val = 0;
            }
            return val;
        }

        static bool IntToBool(int i)
        {
            bool val;
            if (i > 0)
            {
                val = true;
            }
            else
            {
                val = false;
            }
            return val;
        }

    }
}
