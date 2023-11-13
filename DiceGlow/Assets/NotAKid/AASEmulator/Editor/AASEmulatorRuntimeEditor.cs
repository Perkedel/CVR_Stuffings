using System;
using NAK.AASEmulator.Runtime;
using UnityEditor;
using UnityEngine;
using static NAK.AASEmulator.Editor.EditorExtensions;
using static NAK.AASEmulator.Runtime.AASEmulatorRuntime;

namespace NAK.AASEmulator.Editor
{
    [CustomEditor(typeof(AASEmulatorRuntime))]
    public class AASEmulatorRuntimeEditor : UnityEditor.Editor
    {
        #region Variables

        private GUIStyle _boldFoldoutStyle;
        private AASEmulatorRuntime _targetScript;

        #endregion

        #region Unity / GUI Methods

        private void OnEnable()
        {
            OnRequestRepaint -= Repaint;
            OnRequestRepaint += Repaint;
            _boldFoldoutStyle = new GUIStyle(EditorStyles.foldout) { fontStyle = FontStyle.Bold };
            
            // Initialize on select
            _targetScript = (AASEmulatorRuntime)target;
            if (!_targetScript.IsInitialized())
                _targetScript.Initialize();
        }
        private void OnDisable() => OnRequestRepaint -= Repaint;
        
        public override void OnInspectorGUI()
        {
            if (_targetScript == null)
                return;

            Draw_ScriptWarning();

            Draw_AvatarInfo();
            
            Draw_LipSync();
            Draw_BuiltInGestures();
            Draw_BuiltInLocomotion();
            Draw_BuiltInEmotes();

            Draw_AdditionalParameters();
        }

        #endregion Unity / GUI Methods
        
        #region Drawing Methods

        private void Draw_ScriptWarning()
        {
            if (_targetScript.isInitializedExternally) 
                return;

            EditorGUILayout.HelpBox("Warning: Do not upload this script with your avatar!\nThis script is prevented from saving to scenes & prefabs.", MessageType.Warning);
            EditorGUILayout.HelpBox("This script will automatically be added if you enable AASEmulator from the Tools menu (Tools > Enable AAS Emulator).", MessageType.Info);
        }

        private void Draw_AvatarInfo()
        {
            EditorGUILayout.Space();
            _targetScript.avatarInfoFoldout = EditorGUILayout.Foldout(_targetScript.avatarInfoFoldout, "Avatar Info", true, _boldFoldoutStyle);

            if (_targetScript.avatarInfoFoldout)
            {
                EditorGUI.indentLevel++;

                string emoteStatus = _targetScript.IsEmotePlaying ? "Playing an Emote - Tracking Disabled" : "Not Playing an Emote - Tracking Enabled";
                EditorGUILayout.LabelField("Emote Status:", emoteStatus);
                
                string activeBodyOffsetStatus = _targetScript.IsActiveOffset ? "Enabled - Body Offset On" : "Disabled - Body Offset Off";
                EditorGUILayout.LabelField("Body Offset:", activeBodyOffsetStatus);
                
                string eyeMovementStatus = _targetScript.UseEyeMovement ? "Enabled - Eye Look On" : "Disabled - Eye Look Off";
                EditorGUILayout.LabelField("Eye Movement:", eyeMovementStatus);

                string blinkBlendshapesStatus = _targetScript.UseBlinkBlendshapes ? "Enabled - Eye Blink On" : "Disabled - Eye Blink Off";
                EditorGUILayout.LabelField("Blink Blendshapes:", blinkBlendshapesStatus);

                string lipsyncStatus = _targetScript.UseLipsync ? "Enabled - Lipsync On" : "Disabled - Lipsync Off";
                EditorGUILayout.LabelField("Lipsync:", lipsyncStatus);
                
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_LipSync()
        {
            EditorGUILayout.Space();
            
            string foldoutLabel = $"Lip Sync / {_targetScript.VisemeMode.ToString().Replace('_', ' ')}";
            _targetScript.lipSyncFoldout = EditorGUILayout.Foldout(_targetScript.lipSyncFoldout, foldoutLabel, true, _boldFoldoutStyle);

            if (_targetScript.lipSyncFoldout)
            {
                EditorGUI.indentLevel++;

                switch (_targetScript.VisemeMode)
                {
                    case VisemeModeIndex.Visemes:
                        int newVisemeIndex = (int)_targetScript.VisemeIdx;
                        newVisemeIndex = EditorGUILayout.Popup("Viseme Index", newVisemeIndex, Enum.GetNames(typeof(VisemeIndex)));
                        HandlePopupScroll(ref newVisemeIndex, 0, Enum.GetNames(typeof(VisemeIndex)).Length - 1);
                        _targetScript.VisemeIdx = (VisemeIndex)newVisemeIndex;
                        _targetScript.Viseme = EditorGUILayout.IntSlider("Viseme", _targetScript.Viseme, 0, 14);
                        break;
                    case VisemeModeIndex.Single_Blendshape:
                    case VisemeModeIndex.Jaw_Bone:
                        _targetScript.VisemeLoudness = EditorGUILayout.Slider("Viseme Loudness", _targetScript.VisemeLoudness, 0f, 1f);
                        break;
                }

                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInGestures()
        {
            EditorGUILayout.Space();
            _targetScript.builtInGesturesFoldout = EditorGUILayout.Foldout(_targetScript.builtInGesturesFoldout, "Built-in inputs / Hand Gestures", true, _boldFoldoutStyle);

            if (_targetScript.builtInGesturesFoldout)
            {
                EditorGUI.indentLevel++;

                int newLeftGestureIndex = EditorGUILayout.Popup("Gesture Left Index", (int)_targetScript.GestureLeftIdx, Enum.GetNames(typeof(GestureIndex)));
                HandlePopupScroll(ref newLeftGestureIndex, 0, Enum.GetNames(typeof(GestureIndex)).Length - 1);
                if ((GestureIndex)newLeftGestureIndex != _targetScript.GestureLeftIdx)
                {
                    _targetScript.GestureLeftIdx = (GestureIndex)newLeftGestureIndex;
                }
                float newLeftGestureValue = EditorGUILayout.Slider("Gesture Left", _targetScript.GestureLeft, -1, 6);
                if (!Mathf.Approximately(newLeftGestureValue, _targetScript.GestureLeft))
                {
                    _targetScript.GestureLeft = newLeftGestureValue;
                }

                int newRightGestureIndex = EditorGUILayout.Popup("Gesture Right Index", (int)_targetScript.GestureRightIdx, Enum.GetNames(typeof(GestureIndex)));
                HandlePopupScroll(ref newRightGestureIndex, 0, Enum.GetNames(typeof(GestureIndex)).Length - 1);
                if ((GestureIndex)newRightGestureIndex != _targetScript.GestureRightIdx)
                {
                    _targetScript.GestureRightIdx = (GestureIndex)newRightGestureIndex;
                }
                float newRightGestureValue = EditorGUILayout.Slider("Gesture Right", _targetScript.GestureRight, -1, 6);
                if (!Mathf.Approximately(newRightGestureValue, _targetScript.GestureRight))
                {
                    _targetScript.GestureRight = newRightGestureValue;
                }

                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInLocomotion()
        {
            EditorGUILayout.Space();
            _targetScript.builtInLocomotionFoldout = EditorGUILayout.Foldout(_targetScript.builtInLocomotionFoldout, "Built-in inputs / Locomotion", true, _boldFoldoutStyle);

            if (_targetScript.builtInLocomotionFoldout)
            {
                EditorGUI.indentLevel++;

                // Custom joystick GUI
                _targetScript.joystickFoldout = EditorGUILayout.Foldout(_targetScript.joystickFoldout, "Joystick", true, _boldFoldoutStyle);
                if (_targetScript.joystickFoldout)
                {
                    EditorGUILayout.BeginHorizontal();

                    Rect joystickRect = GUILayoutUtility.GetRect(100, 100, GUILayout.MaxWidth(100), GUILayout.MaxHeight(100));
                    Vector2 newMovementValue = Joystick2DField(joystickRect, _targetScript.Movement, true);
                    if (newMovementValue != _targetScript.Movement)
                        _targetScript.Movement = newMovementValue;

                    EditorGUILayout.BeginVertical();
                    GUILayout.FlexibleSpace();
                    EditorGUILayout.HelpBox("Double Click to Reset", MessageType.Info);
                    EditorGUILayout.EndVertical();

                    EditorGUILayout.EndHorizontal();
                }

                // Movement field
                Vector2 newMovementValue2 = EditorGUILayout.Vector2Field("Movement", _targetScript.Movement);
                if (newMovementValue2 != _targetScript.Movement)
                    _targetScript.Movement = newMovementValue2;

                _targetScript.Crouching = EditorGUILayout.Toggle("Crouching", _targetScript.Crouching);
                _targetScript.Prone = EditorGUILayout.Toggle("Prone", _targetScript.Prone);
                _targetScript.Flying = EditorGUILayout.Toggle("Flying", _targetScript.Flying);
                _targetScript.Sitting = EditorGUILayout.Toggle("Sitting", _targetScript.Sitting);
                _targetScript.Swimming = EditorGUILayout.Toggle("Swimming", _targetScript.Swimming);
                _targetScript.Grounded = EditorGUILayout.Toggle("Grounded", _targetScript.Grounded);

                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInEmotes()
        {
            EditorGUILayout.Space();
            _targetScript.builtInEmotesFoldout = EditorGUILayout.Foldout(_targetScript.builtInEmotesFoldout, "Built-in inputs / Emotes", true, _boldFoldoutStyle);

            if (_targetScript.builtInEmotesFoldout)
            {
                EditorGUI.indentLevel++;

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Emote", GUILayout.Width(60));
                for (int i = 0; i <= 8; i++)
                {
                    bool emote = EditorGUILayout.Toggle(_targetScript.Emote == i, GUILayout.Width(30));
                    if (emote) _targetScript.Emote = i;
                }
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("Toggle", GUILayout.Width(60));
                for (int i = 0; i <= 8; i++)
                {
                    bool toggle = EditorGUILayout.Toggle(_targetScript.Toggle == i, GUILayout.Width(30));
                    if (toggle) _targetScript.Toggle = i;
                }
                EditorGUILayout.EndHorizontal();

                _targetScript.CancelEmote = EditorGUILayout.Toggle("Cancel Emote", _targetScript.CancelEmote);

                EditorGUI.indentLevel--;
            }
        }

        private void Draw_AdditionalParameters()
        {
            EditorGUILayout.Space();

            if (_targetScript.AnimatorManager == null)
                return;
            
            _targetScript.floatsFoldout = EditorGUILayout.Foldout(_targetScript.floatsFoldout, "Additional inputs / Floats", true, _boldFoldoutStyle);
            if (_targetScript.floatsFoldout)
            {
                EditorGUI.indentLevel++;
                foreach (var floatParam in _targetScript.AnimatorManager.FloatParameters)
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(floatParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(floatParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(floatParam.isControlledByCurve);
                    float newFloatValue = EditorGUILayout.FloatField(floatParam.value);
                    EditorGUI.EndDisabledGroup();
                    if (floatParam.value != newFloatValue)
                        _targetScript.AnimatorManager.SetParameter(floatParam.name, newFloatValue);
                    EditorGUILayout.EndHorizontal();
                }
                EditorGUI.indentLevel--;
            }

            _targetScript.intsFoldout = EditorGUILayout.Foldout(_targetScript.intsFoldout, "Additional inputs / Ints", true, _boldFoldoutStyle);
            if (_targetScript.intsFoldout)
            {
                EditorGUI.indentLevel++;
                foreach (var intParam in _targetScript.AnimatorManager.IntParameters)
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(intParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(intParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(intParam.isControlledByCurve);
                    int newIntValue = EditorGUILayout.IntField(intParam.value);
                    EditorGUI.EndDisabledGroup();
                    if (intParam.value != newIntValue)
                        _targetScript.AnimatorManager.SetParameter(intParam.name, newIntValue);
                    EditorGUILayout.EndHorizontal();
                }
                EditorGUI.indentLevel--;
            }
            
            _targetScript.boolsFoldout = EditorGUILayout.Foldout(_targetScript.boolsFoldout, "Additional inputs / Bools", true, _boldFoldoutStyle);
            if (_targetScript.boolsFoldout)
            {
                EditorGUI.indentLevel++;
                foreach (var boolParam in _targetScript.AnimatorManager.BoolParameters)
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(boolParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(boolParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(boolParam.isControlledByCurve);
                    bool newBoolValue = EditorGUILayout.Toggle(boolParam.value);
                    EditorGUI.EndDisabledGroup();
                    if (boolParam.value != newBoolValue)
                        _targetScript.AnimatorManager.SetParameter(boolParam.name, newBoolValue);
                    EditorGUILayout.EndHorizontal();
                }
                EditorGUI.indentLevel--;
            }
        }

        #endregion Drawing Methods
    }
}