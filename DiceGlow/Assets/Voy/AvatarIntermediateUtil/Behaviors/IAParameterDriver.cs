using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Animations;
using Voy.IntermediateAvatar.MenuSystem;

namespace Voy.IntermediateAvatar.Behaviours
{
    public class IAParameterDriver : StateMachineBehaviour
    {
        public bool LocalOnly;

        public List<Task> Tasks = new List<Task>();

        public void DeleteDriver(int idx)
        {
            Tasks.RemoveAt(idx);
        }

        public void MoveDriver(int idx, int amount)
        {
            if (idx + amount >= Tasks.Count) return;
            if (idx + amount < 0) return;

            Task main = Tasks[idx];
            Task outOfWay = Tasks[idx + amount];

            Tasks[idx + amount] = main;
            Tasks[idx] = outOfWay;
        }

        public void Add(int idx)
        {
            if (idx >= 0) Tasks.Insert(idx, new Task());
            else Tasks.Add(new Task());
        }
    }

    public enum TypeList : int
    {
        Set,
        Add,
        Random,
        Copy
    }

    [Serializable]
    public class Task
    {

        public enum ParamType
        {
        
        }

        public TypeList Type;
        public string Dest;
        public string Src;
        public float Val;
        public float RandomMax;
    }

    [CustomEditor(typeof(IAParameterDriver))]
    public class IAParameterDriverEditor : Editor
    {
        /*
        List<AnimatorControllerParameter> parameters = new List<AnimatorControllerParameter>();
        string[] displayParams = { };
        AnimatorController parentController;
        public void OnEnable()
        {
            var behaviourcontext = AnimatorController.FindStateMachineBehaviourContext((IAParameterDriver)target);
            parentController = behaviourcontext[0].animatorController;

            
        }
        */
        
        /*
        public void UpdateParameterList()
        {
            parameters.Clear();
            foreach (AnimatorControllerParameter parameter in parentController.parameters)
            {
                List<string> tempDisplays = new List<string>();
                parameters.Add(parameter);
                tempDisplays.Add(parameter.name + ", " + parameter.type.ToString());
                displayParams = tempDisplays.ToArray();
            }
        }
        */
        public override void OnInspectorGUI()
        {
            //if (parameters.Count < 0) UpdateParameterList();

            int idx = 0;

            bool delete = false;
            int deleteIdx = -10;

            bool moveUp = false;
            int moveUpIdx = -10;

            bool moveDown = false;
            int moveDownIdx = -10;

            bool addAfter = false;
            int addAfterIdx = -10;

            //bool destChange = false;
            //int destChangeIdx = -10;
            //int destChangeParamIdx = -10;

            //bool srcChange = false;
            //int srcChangeIdx = -10;
            //int srcChangeParamIdx = -10;

            IAParameterDriver driver = (IAParameterDriver)target;

            driver.LocalOnly = EditorGUILayout.Toggle("Local Only", driver.LocalOnly);

            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Driver Tasks");

            bool add = false;

            add = GUILayout.Button("Add at Start");

            if (add)
            {
                driver.Add(0);
                add = false;
            }

            if (driver.Tasks.Count > 0)
            {
                foreach (Task Task in driver.Tasks)
                {
                    EditorGUILayout.BeginVertical("box");


                        EditorGUILayout.BeginHorizontal();
                            EditorGUILayout.LabelField("Type");
                            Task.Type = (TypeList)EditorGUILayout.EnumPopup(Task.Type);
                        EditorGUILayout.EndHorizontal();


                        if (Task.Type == TypeList.Copy)
                        {
                            EditorGUILayout.BeginHorizontal();
                            EditorGUILayout.LabelField("Source");
                            Task.Src = EditorGUILayout.TextField(Task.Src);
                            EditorGUILayout.EndHorizontal();
                        }

                        EditorGUILayout.BeginHorizontal();
                        EditorGUILayout.LabelField("Destination");
                        Task.Dest = EditorGUILayout.TextField(Task.Dest);
                        EditorGUILayout.EndHorizontal();

                        if (Task.Type != TypeList.Copy)
                        {
                            string type;

                            if (Task.Type != (TypeList.Random)) type = "Value";
                            else type = "Random Min";

                            EditorGUILayout.BeginHorizontal();
                        
                                EditorGUILayout.LabelField(type);
                                Task.Val = EditorGUILayout.FloatField(Task.Val);

                            EditorGUILayout.EndHorizontal();
                        }

                        if (Task.Type == TypeList.Random)
                        {

                            EditorGUILayout.BeginHorizontal();

                                EditorGUILayout.LabelField("Random Max");

                                Task.RandomMax = EditorGUILayout.FloatField(Task.RandomMax);

                            EditorGUILayout.EndHorizontal();

                        }

                    EditorGUILayout.BeginHorizontal();

                    addAfter = GUILayout.Button("Add After");
                    moveUp = GUILayout.Button("Move Up");
                    moveDown = GUILayout.Button("Move Down");
                    delete = GUILayout.Button("Delete");

                    EditorGUILayout.EndHorizontal();

                    if (moveUp)
                    { 
                        moveUpIdx = idx;
                        moveUp = false;
                    }
                    if (moveDown)
                    {
                        moveDownIdx = idx;
                        moveDown = false;
                    }
                    if (delete)
                    {
                        deleteIdx = idx;
                        delete = false;
                    }
                    if (addAfter)
                    { 
                        addAfterIdx = idx;
                        addAfter = false;
                    }
                    /*
                    if (destChange)
                    {
                        destChangeIdx = idx;
                        destChange = false;
                    }
                    if (srcChange)
                    {
                        srcChangeIdx = idx;
                        srcChange = false;
                    }
                    */

                    EditorGUILayout.EndVertical();

                    EditorGUILayout.Space();

                    idx ++;
                }
            }
            /*
            if (destChangeIdx >= 0)
            {
                driver.Tasks[destChangeIdx].Dest = parameters[destChangeParamIdx].name;
                destChangeIdx = -10;
                destChangeParamIdx = -10;
            }
            if (srcChangeIdx >= 0)
            {
                driver.Tasks[srcChangeIdx].Src = parameters[srcChangeParamIdx].name;
                srcChangeIdx = -10;
                srcChangeParamIdx = -10;
            }
            */


            // All the refactoring I had to avoid modifying a list I am accessing.
            if (deleteIdx > -10)
            {
                driver.DeleteDriver(deleteIdx);
                deleteIdx = -10;
            }

            if (moveUpIdx > -10)
            {
                driver.MoveDriver(moveUpIdx, -1);
                moveUpIdx = -10;
            }

            if (moveDownIdx > -10)
            {
                driver.MoveDriver(moveDownIdx, 1);
                moveDownIdx = -10;
            }

            if (addAfterIdx > -10)
            {
                driver.Add(addAfterIdx + 1);
                addAfterIdx = -10;
            }

            idx = 0;

            add = GUILayout.Button("Add at End");

            if (add)
            {
                driver.Add(-1);
                add = false;
            }

        }

    }

}

#endif
