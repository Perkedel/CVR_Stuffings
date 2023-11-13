#if CVR_CCK_EXISTS
using ABI.CCK.Components;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;
using static NAK.EditorTools.AvatarScaleTool;

namespace NAK.EditorTools
{
    public class AvatarScaleToolEditor : EditorWindow
    {
        [MenuItem("NotAKid/Avatar Scale Tool")]
        public static void ShowWindow()
        {
            GetWindow<AvatarScaleToolEditor>("Avatar Scale Tool");
        }

        private void OnEnable()
        {
            SceneView.duringSceneGui -= OnSceneGUI;
            SceneView.duringSceneGui += OnSceneGUI;

            float desiredWidth = 500;
            float desiredHeight = position.height;
            Vector2 currentPosition = position.position;
            position = new Rect(currentPosition.x, currentPosition.y, desiredWidth, desiredHeight);
        }

        private void OnDisable()
        {
            SceneView.duringSceneGui -= OnSceneGUI;
        }

        private void OnGUI()
        {
            DrawAvatarSelection();
            if (cvrAvatar == null)
            {
                DrawAvatarSelectionHint();
                return;
            }

            GetScaleSettings();
            DrawScaleSettings();
            DrawOptionalScaleSettings();
            DrawLocomotionSpeedInfo();
            DrawGenerateScaleAnimationButton();
            DrawSeparator();
            DrawSettingsField();
        }

        private void DrawAvatarSelection()
        {
            cvrAvatar = (CVRAvatar)EditorGUILayout.ObjectField(
                "Selected Avatar", cvrAvatar, typeof(CVRAvatar), true);
            if (GUILayout.Button("Use Selection"))
            {
                cvrAvatar = Selection.gameObjects
                    .Select(obj => obj.GetComponentInParent<CVRAvatar>())
                    .FirstOrDefault();
            }
        }

        private void DrawAvatarSelectionHint()
        {
            EditorGUILayout.HelpBox("Please select an Avatar first.", MessageType.Info);
        }

        private void GetScaleSettings()
        {
            initialHeight = cvrAvatar.viewPosition.y;
        }

        private void DrawScaleSettings()
        {
            GUIStyle box = GUI.skin.GetStyle("box");
            using (new GUILayout.VerticalScope(box))
            {
                GUILayout.Label("Scale Settings (Meters)", EditorStyles.boldLabel);
                EditorGUI.BeginDisabledGroup(useGlobalScaleSettings);
                DrawMinimumHeightField();
                DrawMaximumHeightField();
                EditorGUI.EndDisabledGroup();
                //DrawReferenceAvatarHeightField();
                GUIContent useGlobalScaleSettingsContent = new GUIContent("Global Scale Settings", "Locks scale settings to the predetermined min and max values. This allows for consistant scaling across avatars (same value is same height).");
                useGlobalScaleSettings = EditorGUILayout.Toggle(useGlobalScaleSettingsContent, useGlobalScaleSettings);

            }
            if (useGlobalScaleSettings)
                EditorGUILayout.HelpBox("Settings are locked to use Global Avatar Scale settings. Using this setting allows for consistant scaling values between other avatars that have run through this script.", MessageType.Info);
        }

        private void DrawMinimumHeightField()
        {
            // Don't overwrite users values just because they are curious
            if (useGlobalScaleSettings)
            {
                EditorGUILayout.FloatField("Minimum Height", globalMinHeight);
                return;
            }

            // Display the minimum Height field
            minimumHeight = EditorGUILayout.FloatField("Minimum Height", minimumHeight);

            // Make sure the minimum Height is not greater than the initial Height
            if (minimumHeight > initialHeight)
            {
                minimumHeight = initialHeight;
            }

            // Make sure the minimum Height cannot go to zero
            if (minimumHeight < 0)
            {
                minimumHeight = 0.05f;
            }
        }
        
        private void DrawMaximumHeightField()
        {
            // Don't overwrite users values just because they are curious
            if (useGlobalScaleSettings)
            {
                EditorGUILayout.FloatField("Maximum Height", globalMaxHeight);
                return;
            }

            // Display the maximum Height field
            maximumHeight = EditorGUILayout.FloatField("Maximum Height", maximumHeight);

            // Make sure the maximum Height is not less than the initial Height 
            if (maximumHeight < initialHeight)
            {
                maximumHeight = initialHeight;
            }
        }

        //private void DrawReferenceAvatarHeightField()
        //{
        //    // Reference Avatar Height
        //    EditorGUILayout.BeginHorizontal();
        //    AvatarScaleTool.referenceAvatarHeight = EditorGUILayout.FloatField("Reference Avatar Height", AvatarScaleTool.referenceAvatarHeight);
        //    if (GUILayout.Button("Reset"))
        //    {
        //        AvatarScaleTool.referenceAvatarHeight = 1.8f;
        //    }
        //    EditorGUILayout.EndHorizontal();
        //}

        private void DrawOptionalScaleSettings()
        {
            EditorGUILayout.Space();
            GUILayout.Label("Optional Settings", EditorStyles.boldLabel);
            GUIStyle box = GUI.skin.GetStyle("box");
            using (new GUILayout.VerticalScope(box))
            {
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginVertical();

                float originalLabelWidth = EditorGUIUtility.labelWidth;
                EditorGUIUtility.labelWidth = 200;

                GUIContent motionScaleContent = new GUIContent("#MotionScale Parameter", "Local float parameter useful for adjusting the speed of your locomotion animations.");
                motionScaleFloat = EditorGUILayout.Toggle(motionScaleContent, motionScaleFloat);

                // GUIContent scaleDynamicBoneContent = new GUIContent("Scale Dynamic Bones", "Unused. Dynamic Bone bug with CVRs implementation fucks forces.");
                // scaleDynamicBone = EditorGUILayout.Toggle(scaleDynamicBoneContent, scaleDynamicBone);

                GUIContent scaleAudioSourcesContent = new GUIContent("Scale Audio Sources", "Automatically scale Audio Source minimum and maximum distance.");
                scaleAudioSources = EditorGUILayout.Toggle(scaleAudioSourcesContent, scaleAudioSources);

                GUIContent splitAnimationClipContent = new GUIContent("Split Animation Clip", "Should the exported clip be split into two clips for use in blendtrees?");
                splitAnimationClip = EditorGUILayout.Toggle(splitAnimationClipContent, splitAnimationClip);

                GUIContent scaleTrailRendererWidthContent = new GUIContent("Scale Trail Renderer Width", "Automatically scale Trail Renderer width.");
                scaleTrailRendererWidth = EditorGUILayout.Toggle(scaleTrailRendererWidthContent, scaleTrailRendererWidth);
                
                EditorGUILayout.EndVertical();
                EditorGUILayout.BeginVertical();

                GUIContent scalePositionConstraintOffsetsContent = new GUIContent("Scale Position Constraint Offsets", "Automatically scale Position Constraint rest and translation offsets.");
                scalePositionConstraintOffsets = EditorGUILayout.Toggle(scalePositionConstraintOffsetsContent, scalePositionConstraintOffsets);

                GUIContent scaleParentConstraintOffsetsContent = new GUIContent("Scale Parent Constraint Offsets", "Automatically scale Parent Constraint rest and translation offsets.");
                scaleParentConstraintOffsets = EditorGUILayout.Toggle(scaleParentConstraintOffsetsContent, scaleParentConstraintOffsets);

                GUIContent scaleScaleConstraintOffsetsContent = new GUIContent("Scale Scale Constraint Offsets", "Automatically scale Scale Constraint rest and translation scales.");
                scaleScaleConstraintOffsets = EditorGUILayout.Toggle(scaleScaleConstraintOffsetsContent, scaleScaleConstraintOffsets);

                EditorGUILayout.EndVertical();
                EditorGUILayout.EndHorizontal();

                EditorGUIUtility.labelWidth = originalLabelWidth;
            }
        }

        private void DrawGenerateScaleAnimationButton()
        {
            EditorGUILayout.Space();

            string helpText = null;

            if (useCustomController)
            {
                customController = (AnimatorController)EditorGUILayout.ObjectField("Custom Controller", customController, typeof(AnimatorController), false);

                EditorGUILayout.BeginHorizontal();
                EditorGUI.BeginDisabledGroup(customController == null);
                if (GUILayout.Button("Setup Controller", GUILayout.Width(EditorGUIUtility.currentViewWidth * 0.65f))) SetupCustomController();
                EditorGUI.EndDisabledGroup();
                helpText = "Setup Controller will create the layer, parameter, and clip for you using the selected controller in the slot above.";
            }
            else
            {
                EditorGUILayout.BeginHorizontal();
                if (GUILayout.Button("Add To AAS", GUILayout.Width(EditorGUIUtility.currentViewWidth * 0.65f))) AddToAvatarAdvancedSettings();
                helpText = "Add To AAS will create and add the min and max clips to the CVRAvatar Avatar Advanced Settings GUI. This will always split the animation clip.";
            }

            string buttonText = splitAnimationClip ? "Export Clips" : "Export Clip";
            if (GUILayout.Button(buttonText, GUILayout.Width(EditorGUIUtility.currentViewWidth * 0.35f))) ExportClips();
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.HelpBox(helpText, MessageType.Info);
        }

        private void DrawLocomotionSpeedInfo()
        {
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Avatar Scale Information", EditorStyles.boldLabel);

            GUIStyle box = GUI.skin.GetStyle("box");
            using (new GUILayout.VerticalScope(box))
            {
                float heightPercentage = Mathf.InverseLerp(GetMinimumHeight(), GetMaximumHeight(), initialHeight);
                EditorGUILayout.LabelField("Initial Height Percentage:", $"{heightPercentage:F2}%");

                EditorGUILayout.LabelField("Viewpoint Height:", $"{initialHeight}m (x{CalculateLocomotionSpeed(initialHeight):F2})");
                EditorGUILayout.LabelField("Minimum Height:", $"{GetMinimumHeight()}m (x{CalculateLocomotionSpeed(GetMinimumHeight()):F2})");
                EditorGUILayout.LabelField("Maximum Height:", $"{GetMaximumHeight()}m (x{CalculateLocomotionSpeed(GetMaximumHeight()):F2})");
            }

            string locomotionSpeedInfo = "The right-hand number is the ratio of the reference avatar height to the set minimum and maximum heights. It's used to adjust the speed of locomotion animations to match the avatar's scale.";
            EditorGUILayout.HelpBox(locomotionSpeedInfo, MessageType.Info);
        }

        private void DrawSettingsField()
        {
            useCustomController = EditorGUILayout.Toggle("Use Custom Controller", useCustomController);
            showGizmos = EditorGUILayout.Toggle("Show Gizmos", showGizmos);
        }

        private void OnSceneGUI(SceneView v)
        {
            if (cvrAvatar == null || !showGizmos) return;

            float initHeight = initialHeight;
            float minHeight = GetMinimumHeight();
            float maxHeight = GetMaximumHeight();
            Transform avatarRoot = cvrAvatar.transform;

            Handles.matrix = Matrix4x4.TRS(avatarRoot.position, avatarRoot.rotation, Vector3.one);

            DrawGizmoBackgroundRect(maxHeight);
            DrawGizmoLine(initHeight, Color.blue);
            DrawGizmoLine(minHeight, Color.green);
            DrawGizmoLine(maxHeight, Color.red);
            DrawHeightLabel("Initial Height", initHeight);
            DrawHeightLabel("Minimum Height", minHeight);
            DrawHeightLabel("Maximum Height", maxHeight);

            Handles.matrix = Matrix4x4.identity;
        }

        static void DrawGizmoBackgroundRect(float maxHeight)
        {
            Handles.color = new Color(0.5f, 0.5f, 0.5f, 0.5f);

            Vector3 topLeft = new Vector3(-0.5f, 0f, 0f);
            Vector3 bottomLeft = new Vector3(-0.5f, maxHeight, 0f);
            Vector3 topRight = new Vector3(0.5f, 0f, 0f);
            Vector3 bottomRight = new Vector3(0.5f, maxHeight, 0f);

            Handles.DrawSolidRectangleWithOutline(
                new Vector3[] { topLeft, bottomLeft, bottomRight, topRight },
                new Color(0.5f, 0.5f, 0.5f, 0.5f),
                new Color(0f, 0f, 0f, 0f)
            );
        }

        static void DrawGizmoLine(float height, Color color)
        {
            Handles.color = color;
            Vector3 startPos = new Vector3(0.5f, height, 0f);
            Vector3 endPos = new Vector3(-0.5f, height, 0f);
            Handles.DrawLine(startPos, endPos);
        }

        static void DrawHeightLabel(string heightText, float height)
        {
            GUIStyle style = new GUIStyle();
            style.normal.textColor = Color.white;
            style.alignment = TextAnchor.MiddleCenter;
            style.fontSize = 16;

            string text = $"{heightText}\n{height}m";
            Vector3 pos = new Vector3(-0.5f, height + 0.05f, 0f);
            Handles.Label(pos, text, style);
        }

        //Nicked from commissioned script by Dreadrith
        static void DrawSeparator(int thickness = 2, int padding = 10)
        {
            Rect rect = EditorGUILayout.GetControlRect(GUILayout.Height(thickness + padding));
            rect.height = thickness;
            rect.y += padding / 2f;
            rect.x -= 2;
            rect.width += 6;

            Color lineColor = EditorGUIUtility.isProSkin ? new Color32(89, 89, 89, 255) : new Color32(133, 133, 133, 255);
            EditorGUI.DrawRect(rect, lineColor);
        }
    }
}
#endif