#if UNITY_EDITOR

using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.Linq;
using System;



namespace SatorImaging.PoseEditor
{
    public class PoseEditorManager : MonoBehaviour
    {
        [Range(1f, 50f)] public float worldSize = 1.0f;
        [Range(0f, 0.1f)] public float handleSize = 0.025f;
        [Space()]
        [Range(0.0f, 2.0f)] public float fingerHandleScale = 0.3f;
        [Range(0.5f, 1.5f)] public float highlightScale = 0.75f;

        [Space()]
        public bool drawSkeleton = true;
        public Color handleColor = new Color(0, 0.5f, 1.0f);
        public Color inactiveHandleColor = new Color(0.0f, 0.32f, 0.0f, 1.0f); //new Color(0.125f, 0.125f, 0.125f, 0.5f);
        public bool multiColor = true;
        [Range(1f, 36f)] public int multiColorVariation = 6;
        [Range(0f, 1f)] public float multiColorSaturation = 1.0f;
        [Range(0f, 1f)] public float multiColorBrightness = 1.0f;

        [Header("Joint/Skeleton Name Filter")]
        public bool caseSensitive;
        public string nameFilter;

        [Space]
        public bool drawLabel = true;
        [Range(0f, 256f)] public int labelFontSize = 16;
        public Color labelColor = new Color(0.0f, 0.64f, 0.0f, 1.0f);
        public Color inactiveLabelColor = new Color(0.0f, 0.32f, 0.0f, 1.0f);
        public bool inheritHandleColor = true;

        //[Space]
        public GUIStyle labelStyle;


        Transform[] bones = new Transform[] { };
        Transform[][] childBones = new Transform[][] { };






        [MenuItem("GameObject/Add Pose Editor", priority = 39)]
        [MenuItem("Component/Add Pose Editor", priority = 9999)]
        static void AddPoseEditor()
        {
            foreach (var s in Selection.GetTransforms(SelectionMode.Unfiltered))
            {
                var poseman = s.GetComponent<PoseEditorManager>();
                if (null == poseman)
                {
                    s.gameObject.AddComponent<PoseEditorManager>();
                }
            }

        }





        public void RemovePoseEditor()
        {
            foreach (var b in bones)
            {
                var handles = b.GetComponentsInChildren<SelectionHandle>();
                foreach (var h in handles)
                {
                    DestroyImmediate(h);
                }
            }
            DestroyImmediate(this);
        }



        
        
        public void UpdatePoseEditor()
        {
            var result = new List<Transform>();

            System.StringComparison compType =
                caseSensitive ? System.StringComparison.CurrentCulture : System.StringComparison.CurrentCultureIgnoreCase;


            // first, find objects already has handle
            foreach (var o in GetComponentsInChildren<SelectionHandle>())
            {
                var t = o.transform;
                // ignore duplicate
                if (result.Contains(t))
                {
                    continue;
                }
                result.Add(t);
            }
            // second, add skinned mesh bones.
            foreach (var m in GetComponentsInChildren<SkinnedMeshRenderer>())
            {
                foreach (var b in m.bones)
                {
                    // ignore duplicate
                    if (result.Contains(b))
                    {
                        continue;
                    }
                    result.Add(b);
                }
            }
            // third, add humanoid bones
            var fingerBoneList = new List<Transform>();
            foreach (var animator in GetComponentsInChildren<Animator>())
            {
                if (!animator.isHuman) continue;

                foreach (var boneId in Enum.GetValues(typeof(HumanBodyBones)))
                {
                    if ((HumanBodyBones)boneId == HumanBodyBones.LastBone)
                    {
                        break;
                    }

                    var bone = animator.GetBoneTransform((HumanBodyBones)boneId);
                    if (null == bone || result.Contains(bone))
                    {
                        continue;
                    }
                    result.Add(bone);
                    //Debug.Log(bone);
                }

                // finger bones
                foreach (var fingerBoneId in new HumanBodyBones[] {
                    HumanBodyBones.LeftIndexProximal,
                    HumanBodyBones.LeftMiddleProximal,
                    HumanBodyBones.LeftRingProximal,
                    HumanBodyBones.LeftLittleProximal,
                    HumanBodyBones.LeftThumbProximal,
                    HumanBodyBones.RightIndexProximal,
                    HumanBodyBones.RightMiddleProximal,
                    HumanBodyBones.RightLittleProximal,
                    HumanBodyBones.RightRingProximal,
                    HumanBodyBones.RightThumbProximal,
                })
                {
                    var fingerBone = animator.GetBoneTransform(fingerBoneId);
                    if (null == fingerBone) continue;

                    foreach (var t in fingerBone.GetComponentsInChildren<Transform>())
                    {
                        fingerBoneList.Add(t);
                    }
                }

            }




            // add handle to bones except for hidden/filtered children.
            var hiddenBones = new List<Transform>();
            foreach (var b in result)
            {
                // naming filter first
                if (!string.IsNullOrEmpty(nameFilter) && -1 == b.name.IndexOf(nameFilter, compType))
                {
                    hiddenBones.Add(b);
                }

                var handle = b.GetComponent<SelectionHandle>();
                if (null == handle)
                {
                    handle = b.gameObject.AddComponent<SelectionHandle>();
                    // finger handle scale
                    if (fingerBoneList.Contains(b))
                    {
                        handle.handleScale = fingerHandleScale;
                    }
                }
                handle.manager = this;

                // hide children
                if (handle.hideChildren)
                {
                    var children = handle.GetComponentsInChildren<SelectionHandle>(true);
                    // 0 is itself
                    //Debug.Log("I'm " + handle.name + " and index 0 is: " + children[0]);
                    for (var cidx = 1; cidx < children.Length; cidx++)
                    {
                        if (hiddenBones.Contains(children[cidx].transform))
                        {
                            continue;
                        }
                        hiddenBones.Add(children[cidx].transform);
                    }
                }
            }
            result.RemoveAll(b => hiddenBones.Contains(b));
            // reverse order to change drawing order to root->child
            result.Reverse();
            bones = result.ToArray();



            // find child bones
            childBones = new Transform[bones.Length][];
            for (var i = 0; i < bones.Length; i++)
            {
                // skip if hide children
                if (bones[i].GetComponent<SelectionHandle>().hideChildren)
                {
                    continue;
                }

                var children = bones[i].GetComponentsInChildren<SelectionHandle>(true);
                var found = new List<Transform>();
                foreach (var c in children)
                {
                    if (c.transform == bones[i])
                    {
                        continue;
                    }

                    if (c.transform.parent == bones[i])
                    {
                        found.Add(c.transform);
                    }
                }
                if (0 == found.Count)
                {
                    childBones[i] = null;
                }
                else
                {
                    childBones[i] = found.ToArray();
                }

            }





        }





        // tricky way to update all finger bones thru inspector.
        float lastFingerHandleScale;
        PoseEditorManager()
        {
            // initialize with saved value.
            lastFingerHandleScale = fingerHandleScale;
        }


        // update finger bone children here.
        void OnValidate()
        {
            // finger handle scale
            if (fingerHandleScale != lastFingerHandleScale)
            {
                lastFingerHandleScale = fingerHandleScale;

                foreach (var animator in GetComponentsInChildren<Animator>())
                {
                    if (!animator.isHuman) continue;

                    foreach (var fingerBoneId in new HumanBodyBones[] {
                        HumanBodyBones.LeftIndexProximal,
                        HumanBodyBones.LeftMiddleProximal,
                        HumanBodyBones.LeftRingProximal,
                        HumanBodyBones.LeftLittleProximal,
                        HumanBodyBones.LeftThumbProximal,
                        HumanBodyBones.RightIndexProximal,
                        HumanBodyBones.RightMiddleProximal,
                        HumanBodyBones.RightLittleProximal,
                        HumanBodyBones.RightRingProximal,
                        HumanBodyBones.RightThumbProximal,
                    })
                    {
                        var fingerBone = animator.GetBoneTransform(fingerBoneId);
                        if (null == fingerBone) continue;

                        foreach (var handle in fingerBone.GetComponentsInChildren<SelectionHandle>())
                        {
                            handle.handleScale = fingerHandleScale;
                        }
                    }
                }
                // need to force update
                SceneView.RepaintAll();
            }



            EditorApplication.delayCall += () =>
            {
                UpdatePoseEditor();
                OnSelectionChanged();
            };


        }







        // draw gizmos while inactive
        void OnDrawGizmos()
        {
            DrawHandle(false);
        }




        public void DrawHandle(bool colorize = true)
        {
            // camera angle
            var cameraDir = Camera.current.transform.rotation * Vector3.forward;


            // build gui style first time.
            if (null == labelStyle || string.IsNullOrEmpty(labelStyle.name))
            {
                labelStyle = new GUIStyle(EditorStyles.largeLabel)
                {
                    alignment = TextAnchor.LowerCenter,
                    clipping = TextClipping.Overflow,
                    fixedWidth = 1,
                    fixedHeight = 1,
                    contentOffset = new Vector2(5.5f, 0),
                    fontSize = 10, // must be initialize with non-zero value.
                };

            }
            labelStyle.fontSize = labelFontSize;
            labelStyle.normal.textColor = colorize ? labelColor : inactiveLabelColor;



            Handles.color = colorize ? handleColor : inactiveHandleColor;

            var colorIndex = 0;
            for (var i = 0; i < bones.Length; i++)
            {
                if (null == bones[i] || !bones[i].gameObject.activeInHierarchy)
                {
                    continue;
                }

                if (colorize && multiColor && (0 == i || 1 < bones[i].parent.childCount))
                {
                    Handles.color = Color.HSVToRGB(colorIndex * (1f / multiColorVariation) % 1f, multiColorSaturation, multiColorBrightness);
                    colorIndex++;
                }



                var bonePosition = bones[i].position;

                // draw skeleton
                if (null != childBones[i])
                {
                    for (var c = 0; c < childBones[i].Length; c++)
                    {
                        if (null == childBones[i][c])
                        {
                            continue;
                        }

                        if (drawSkeleton)
                        {
                            Handles.DrawLine(bonePosition, childBones[i][c].position);
                        }

                        //Handles.Slider(bones[i].position, childBones[i][c].position - bones[i].position);
                    }
                }



                // handle option
                var handle = bones[i].GetComponent<SelectionHandle>();

                // draw label
                if (drawLabel)
                {
                    if (null != handle && !string.IsNullOrEmpty(handle.label))
                    {
                        if (colorize && inheritHandleColor)
                        {
                            labelStyle.normal.textColor = Handles.color;
                        }
                        Handles.Label(bonePosition, handle.label, labelStyle);
                    }
                }

                // is selected
                if (handle.selected)
                {
                    Handles.DrawSolidDisc(bones[i].position, cameraDir, handleSize * worldSize * handle.handleScale * highlightScale);
                }



                // ignore while navigating scene view.
                if (Event.current.alt && Event.current.isMouse)
                {
                    continue;
                }


                EditorGUI.BeginChangeCheck();
                Handles.FreeMoveHandle(bones[i].position, bones[i].rotation, handleSize * worldSize * handle.handleScale, Vector3.zero, Handles.SphereHandleCap);
                //Handles.FreeRotateHandle(bones[i].rotation, bones[i].position, handleSize);
                //Handles.RotationHandle(bones[i].rotation, bones[i].position);




                if (EditorGUI.EndChangeCheck())
                {
                    var selList = new List<UnityEngine.Object>(Selection.objects);

                    // shift
                    if (Event.current.shift)
                    {
                        // reorder
                        if (Selection.objects.Contains(bones[i].gameObject))
                        {
                            selList.Remove(bones[i].gameObject);
                        }
                        selList.Insert(0, bones[i].gameObject);
                    }
                    // ctrl
                    else if (Event.current.control)
                    {
                        if (Selection.objects.Contains(bones[i].gameObject))
                        {
                            selList.Remove(bones[i].gameObject);
                        }
                    }
                    else
                    {
                        selList.Clear();
                        selList.Add(bones[i].gameObject);
                    }


                    // update selection state
                    if (0 < selList.Count)
                    {
                        // need to set active transform first
                        Selection.activeTransform = (selList[0] as GameObject).transform;
                    }
                    Selection.objects = selList.ToArray();
                    OnSelectionChanged();

                }

            }


        }




        public void OnSelectionChanged()
        {
            // avoid error on destroy
            if (this)
            {
                foreach (var handle in this.GetComponentsInChildren<SelectionHandle>())
                {
                    handle.selected = Selection.Contains(handle.gameObject);
                }

            }

            // change pivot mode
            if (PivotMode.Pivot != Tools.pivotMode)
            {
                Tools.pivotMode = PivotMode.Pivot;
                // notification
                var windows = Resources.FindObjectsOfTypeAll(typeof(SceneView)) as SceneView[];
                foreach (var window in windows)
                {
                    if (window == null) continue;
                    window.ShowNotification(new GUIContent("Tool Mode is set to Pivot"));
                }

            }

        }







    }//class
}//namespace
#endif
