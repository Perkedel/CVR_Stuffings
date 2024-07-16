using System;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace NAK.AASEmulator.Runtime.SubSystems
{
    [AddComponentMenu("")]
    [HelpURL(AASEmulatorCore.AAS_EMULATOR_GIT_URL)]
    public class ShaderGlobalController : EditorOnlyMonoBehaviour
    {
        #region Shader Property IDs
        
        private static readonly int CvrTime = Shader.PropertyToID("_CVRTime");
        private static readonly int CvrGlobalParams1 = Shader.PropertyToID("_CVRGlobalParams1");
        private static readonly int CvrGlobalParams2 = Shader.PropertyToID("_CVRGlobalParams2");

        #endregion Shader Property IDs

        #region Public Properties
        
        public float Ping { get; set; }
        public float PlayersInInstance { get; set; }
        public float LeftControllerBattery { get; set; }
        public float RightControllerBattery { get; set; }
        public float FullbodyActive { get; set; }
        public float LeftFootBattery { get; set; }
        public float RightFootBattery { get; set; }
        public float HipBattery { get; set; }
        
        #endregion Public Properties

        #region Private Variables
        
        private Vector4 CVRTime;
        private Vector4 CVRGlobalParams1;
        private Vector4 CVRGlobalParams2;
        
        #endregion Private Variables

        #region Unity Events
        
        private void Update()
        {
            SetShaderGlobals();
        }
        
        #endregion Unity Events

        #region Private Methods
        
        private void SetShaderGlobals()
        {
            CVRTime.x = (float)DateTime.Now.TimeOfDay.TotalSeconds;
            CVRTime.y = (float)DateTime.UtcNow.TimeOfDay.TotalSeconds;
            CVRTime.z = DateTime.Now.DayOfYear;
            CVRTime.w = DateTime.IsLeapYear(DateTime.Now.Year) ? 1f : 0f;
            Shader.SetGlobalVector(CvrTime, CVRTime);
            
            CVRGlobalParams1.x = Ping;
            CVRGlobalParams1.y = PlayersInInstance;
            CVRGlobalParams1.z = LeftControllerBattery;
            CVRGlobalParams1.w = RightControllerBattery;
            Shader.SetGlobalVector(CvrGlobalParams1, CVRGlobalParams1);

            CVRGlobalParams2.x = FullbodyActive;
            CVRGlobalParams2.y = LeftFootBattery;
            CVRGlobalParams2.z = RightFootBattery;
            CVRGlobalParams2.w = HipBattery;
            Shader.SetGlobalVector(CvrGlobalParams2, CVRGlobalParams2);
        }
        
        #endregion Private Methods

        #if UNITY_EDITOR
        [CustomEditor(typeof(ShaderGlobalController))]
        public class ShaderGlobalControllerEditor : Editor
        {
            public override void OnInspectorGUI()
            {
                ShaderGlobalController controller = (ShaderGlobalController)target;

                GUILayout.Label("Public Properties", EditorStyles.boldLabel);
                controller.Ping = EditorGUILayout.FloatField("Ping", controller.Ping);
                controller.PlayersInInstance = EditorGUILayout.FloatField("Players In Instance", controller.PlayersInInstance);
                controller.LeftControllerBattery = EditorGUILayout.FloatField("Left Controller Battery", controller.LeftControllerBattery);
                controller.RightControllerBattery = EditorGUILayout.FloatField("Right Controller Battery", controller.RightControllerBattery);
                controller.FullbodyActive = EditorGUILayout.FloatField("Fullbody Active", controller.FullbodyActive);
                controller.LeftFootBattery = EditorGUILayout.FloatField("Left Foot Battery", controller.LeftFootBattery);
                controller.RightFootBattery = EditorGUILayout.FloatField("Right Foot Battery", controller.RightFootBattery);
                controller.HipBattery = EditorGUILayout.FloatField("Hip Battery", controller.HipBattery);

                GUILayout.Label("Output Values", EditorStyles.boldLabel);
                EditorGUILayout.Vector4Field("CVRTime", controller.CVRTime);
                EditorGUILayout.Vector4Field("CVRGlobalParams1", controller.CVRGlobalParams1);
                EditorGUILayout.Vector4Field("CVRGlobalParams2", controller.CVRGlobalParams2);

                if (GUI.changed)
                {
                    EditorUtility.SetDirty(target);
                }
            }
        }
        #endif
    }
}