using System;
using NAK.AASEmulator.Runtime;
using NAK.AASEmulator.Runtime.SubSystems;
using UnityEditor;
using UnityEngine;
using static NAK.AASEmulator.Editor.EditorExtensions;
using static NAK.AASEmulator.Runtime.AASEmulatorRuntime;

namespace NAK.AASEmulator.Editor
{
    [CustomEditor(typeof(AASEmulatorRuntime))]
    public class AASEmulatorRuntimeEditor : UnityEditor.Editor
    {
        #region Private Variables

        private AASEmulatorRuntime _targetScript;

        #endregion Private Variables

        #region Unity / GUI Methods

        private void OnEnable()
        {
            OnRequestRepaint -= Repaint;
            OnRequestRepaint += Repaint;
            
            // Initialize on select
            _targetScript = (AASEmulatorRuntime)target;
            if (!_targetScript.IsInitialized)
                _targetScript.Initialize();
        }
        private void OnDisable() => OnRequestRepaint -= Repaint;
        
        public override void OnInspectorGUI()
        {
            if (_targetScript == null)
                return;

            Draw_ScriptWarning();

            Draw_RemoteClones();
            //Draw_LocalAvatar();
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
        
        private void Draw_RemoteClones()
        {
            EditorGUILayout.Space();
            _targetScript.remoteClonesFoldout = EditorGUILayout.Foldout(_targetScript.remoteClonesFoldout, "Remote Clones & Mirror Reflection", true, s_BoldFoldoutStyle);

            if (_targetScript.remoteClonesFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");
                
                _targetScript.DisplayMirrorReflection = EditorGUILayout.Toggle("Display Mirror Reflection", _targetScript.DisplayMirrorReflection);
                
                int newRemoteCloneCount = EditorGUILayout.IntField("Remote Clone Count", _targetScript.RemoteCloneCount, s_BoldLabelStyle);
                if (newRemoteCloneCount != _targetScript.RemoteCloneCount) _targetScript.RemoteCloneCount = newRemoteCloneCount;

                EditorGUILayout.BeginHorizontal();
                if (GUILayout.Button("Create Remote Clone"))
                    _targetScript.RemoteCloneCount++;
                if (GUILayout.Button("Destroy All Clones"))
                    _targetScript.RemoteCloneCount = 0;
                EditorGUILayout.EndHorizontal();
                
                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_LocalAvatar()
        {
            EditorGUILayout.Space();
            _targetScript.localAvatarFoldout = EditorGUILayout.Foldout(_targetScript.localAvatarFoldout, "FPRExclusions & Mirror Reflection", true, s_BoldFoldoutStyle);

            if (_targetScript.localAvatarFoldout)
            {   
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");
                
                _targetScript.DisplayFPRExclusions = EditorGUILayout.Toggle("Display FPR Exclusions", _targetScript.DisplayFPRExclusions);
                _targetScript.DisplayMirrorReflection = EditorGUILayout.Toggle("Display Mirror Reflection", _targetScript.DisplayMirrorReflection);

                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }
        
        private void Draw_AvatarInfo()
        {
            EditorGUILayout.Space();
            _targetScript.avatarInfoFoldout = EditorGUILayout.Foldout(_targetScript.avatarInfoFoldout, "Avatar Info", true, s_BoldFoldoutStyle);

            if (_targetScript.avatarInfoFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");

                string aasStatus = _targetScript.IsUsingAvatarAdvancedSettings ? "Using Avatar Advanced Settings" : "Not Using Avatar Advanced Settings";
                EditorGUILayout.LabelField("AAS Status:", aasStatus);
                
                Draw_AASSyncingInfo();
                
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
                
                Draw_BodyControlState();
                
                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_AASSyncingInfo()
        {
            _targetScript.aasSyncingInfoFoldout = EditorGUILayout.Foldout(_targetScript.aasSyncingInfoFoldout, "AAS Syncing Info", true, s_BoldFoldoutStyle);

            if (_targetScript.aasSyncingInfoFoldout)
            {
                EditorGUI.indentLevel++;
                
                EditorGUILayout.LabelField("Float Bit Usage: " + _targetScript.AnimatorManager.SyncedFloatUsage);
                EditorGUILayout.LabelField("Int Bit Usage: " + _targetScript.AnimatorManager.SyncedIntUsage);
                EditorGUILayout.LabelField("Byte Bit Usage: " + _targetScript.AnimatorManager.SyncedByteUsage);
                EditorGUILayout.LabelField("Total Usage: " + _targetScript.AnimatorManager.SyncedTotalUsage + " / " + AvatarDefinitions.AAS_MAX_SYNCED_BITS);
                
                EditorGUI.indentLevel--;
            }
        }
        
        private readonly string[] bodyControlStates = { "On", "Off" };

        private void Draw_BodyControlState()
        {
            EditorGUILayout.Space();
            _targetScript.bodyControlFoldout = EditorGUILayout.Foldout(_targetScript.bodyControlFoldout, "Body Control State (Read-Only)", true, s_BoldFoldoutStyle);

            if (_targetScript.bodyControlFoldout)
            {
                EditorGUI.indentLevel++;
                
                DrawPopup("Head", _targetScript.BodyControl.Head);
                DrawPopup("Pelvis", _targetScript.BodyControl.Pelvis);
                DrawPopup("Left Arm", _targetScript.BodyControl.LeftArm);
                DrawPopup("Right Arm", _targetScript.BodyControl.RightArm);
                DrawPopup("Left Leg", _targetScript.BodyControl.LeftLeg);
                DrawPopup("Right Leg", _targetScript.BodyControl.RightLeg);
                DrawPopup("Locomotion", _targetScript.BodyControl.Locomotion);
                
                EditorGUI.indentLevel--;
            }

            return;
            void DrawPopup(string label, bool state)
            {
                int selectedIndex = state ? 0 : 1;
                EditorGUILayout.Popup(label, selectedIndex, bodyControlStates);
            }
        }

        private void Draw_LipSync()
        {
            EditorGUILayout.Space();
            
            string foldoutLabel = $"Lip Sync / {_targetScript.VisemeMode.ToString().Replace('_', ' ')}";
            _targetScript.lipSyncFoldout = EditorGUILayout.Foldout(_targetScript.lipSyncFoldout, foldoutLabel, true, s_BoldFoldoutStyle);

            if (_targetScript.lipSyncFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");

                switch (_targetScript.VisemeMode)
                {
                    case AvatarDefinitions.VisemeModeIndex.Visemes:
                        int newVisemeIndex = (int)_targetScript.VisemeIdx;
                        newVisemeIndex = EditorGUILayout.Popup("Viseme Index", newVisemeIndex, Enum.GetNames(typeof(AvatarDefinitions.VisemeIndex)));
                        HandlePopupScroll(ref newVisemeIndex, 0, Enum.GetNames(typeof(AvatarDefinitions.VisemeIndex)).Length - 1);
                        _targetScript.VisemeIdx = (AvatarDefinitions.VisemeIndex)newVisemeIndex;
                        _targetScript.Viseme = EditorGUILayout.IntSlider("Viseme", _targetScript.Viseme, 0, 14);
                        _targetScript.VisemeLoudness = EditorGUILayout.Slider("Viseme Loudness", _targetScript.VisemeLoudness, 0f, 1f);
                        break;
                    case AvatarDefinitions.VisemeModeIndex.Single_Blendshape:
                    case AvatarDefinitions.VisemeModeIndex.Jaw_Bone:
                        _targetScript.VisemeLoudness = EditorGUILayout.Slider("Viseme Loudness", _targetScript.VisemeLoudness, 0f, 1f);
                        break;
                }

                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInGestures()
        {
            EditorGUILayout.Space();
            _targetScript.builtInGesturesFoldout = EditorGUILayout.Foldout(_targetScript.builtInGesturesFoldout, "Built-in inputs / Hand Gestures", true, s_BoldFoldoutStyle);

            if (_targetScript.builtInGesturesFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");

                int newLeftGestureIndex = EditorGUILayout.Popup("Gesture Left Idx", (int)_targetScript.GestureLeftIdx, Enum.GetNames(typeof(AvatarDefinitions.GestureIndex)));
                HandlePopupScroll(ref newLeftGestureIndex, 0, Enum.GetNames(typeof(AvatarDefinitions.GestureIndex)).Length - 1);
                if ((AvatarDefinitions.GestureIndex)newLeftGestureIndex != _targetScript.GestureLeftIdx)
                {
                    _targetScript.GestureLeftIdx = (AvatarDefinitions.GestureIndex)newLeftGestureIndex;
                }
                float newLeftGestureValue = EditorGUILayout.Slider("Gesture Left", _targetScript.GestureLeft, -1, 6);
                if (!Mathf.Approximately(newLeftGestureValue, _targetScript.GestureLeft))
                {
                    _targetScript.GestureLeft = newLeftGestureValue;
                }

                int newRightGestureIndex = EditorGUILayout.Popup("Gesture Right Idx", (int)_targetScript.GestureRightIdx, Enum.GetNames(typeof(AvatarDefinitions.GestureIndex)));
                HandlePopupScroll(ref newRightGestureIndex, 0, Enum.GetNames(typeof(AvatarDefinitions.GestureIndex)).Length - 1);
                if ((AvatarDefinitions.GestureIndex)newRightGestureIndex != _targetScript.GestureRightIdx)
                {
                    _targetScript.GestureRightIdx = (AvatarDefinitions.GestureIndex)newRightGestureIndex;
                }
                float newRightGestureValue = EditorGUILayout.Slider("Gesture Right", _targetScript.GestureRight, -1, 6);
                if (!Mathf.Approximately(newRightGestureValue, _targetScript.GestureRight))
                {
                    _targetScript.GestureRight = newRightGestureValue;
                }

                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInLocomotion()
        {
            EditorGUILayout.Space();
            _targetScript.builtInLocomotionFoldout = EditorGUILayout.Foldout(_targetScript.builtInLocomotionFoldout, "Built-in inputs / Locomotion", true, s_BoldFoldoutStyle);

            if (_targetScript.builtInLocomotionFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");

                // Custom joystick GUI
                _targetScript.joystickFoldout = EditorGUILayout.Foldout(_targetScript.joystickFoldout, "Controls", true, s_BoldFoldoutStyle);
                if (_targetScript.joystickFoldout)
                {
                    EditorGUILayout.BeginHorizontal();

                    Rect joystickRect = GUILayoutUtility.GetRect(100, 100, GUILayout.MaxWidth(100), GUILayout.MaxHeight(100));
                    Vector2 newMovementValue = Joystick2DField(joystickRect, _targetScript.Movement, true);
                    if (newMovementValue != _targetScript.Movement)
                        _targetScript.Movement = newMovementValue;
                    
                    

                    EditorGUILayout.BeginVertical();
                    
                    float originalLabelWidth = EditorGUIUtility.labelWidth;
                    EditorGUIUtility.labelWidth = 100f;
                    
                    // upright slider
                    float uprightValue = EditorGUILayout.Slider("Upright", _targetScript.Upright, 0f, 1f);
                    if (!Mathf.Approximately(uprightValue, _targetScript.Upright)) _targetScript.Upright = uprightValue;
                    
                    // spam jump toggle
                    _targetScript.InputJump = EditorGUILayout.Toggle("Spam Jump", _targetScript.InputJump);
                    
                    EditorGUIUtility.labelWidth = originalLabelWidth;
                    
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

                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_BuiltInEmotes()
        {
            EditorGUILayout.Space();
            _targetScript.builtInEmotesFoldout = EditorGUILayout.Foldout(_targetScript.builtInEmotesFoldout, "Built-in inputs / Emotes", true, s_BoldFoldoutStyle);

            if (_targetScript.builtInEmotesFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");

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

                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        private void Draw_AdditionalParameters()
        {
            EditorGUILayout.Space();

            if (_targetScript.AnimatorManager == null)
                return;
            
            _targetScript.floatsFoldout = EditorGUILayout.Foldout(_targetScript.floatsFoldout, "Additional inputs / Floats", true, s_BoldFoldoutStyle);
            if (_targetScript.floatsFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");
                
                foreach (ParameterDefinition floatParam in _targetScript.AnimatorManager.Parameters.GetFloatParameters())
                {
                    if (floatParam.IsCoreParameter) continue;
                    
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(floatParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(floatParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(floatParam.isControlledByCurve);
                    float newFloatValue = EditorGUILayout.FloatField(floatParam.GetFloat());
                    EditorGUI.EndDisabledGroup();
                    if (Math.Abs(floatParam.GetFloat() - newFloatValue) > float.Epsilon)
                        _targetScript.AnimatorManager.Parameters.SetParameter(floatParam.name, newFloatValue);
                    EditorGUILayout.EndHorizontal();
                }
                
                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }

            _targetScript.intsFoldout = EditorGUILayout.Foldout(_targetScript.intsFoldout, "Additional inputs / Ints", true, s_BoldFoldoutStyle);
            if (_targetScript.intsFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");
                
                foreach (ParameterDefinition intParam in _targetScript.AnimatorManager.Parameters.GetIntParameters())
                {
                    if (intParam.IsCoreParameter) continue;
                    
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(intParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(intParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(intParam.isControlledByCurve);
                    int newIntValue = EditorGUILayout.IntField(intParam.GetInt());
                    EditorGUI.EndDisabledGroup();
                    if (intParam.GetInt() != newIntValue)
                        _targetScript.AnimatorManager.Parameters.SetParameter(intParam.name, newIntValue);
                    EditorGUILayout.EndHorizontal();
                }
                
                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
            
            _targetScript.boolsFoldout = EditorGUILayout.Foldout(_targetScript.boolsFoldout, "Additional inputs / Bools", true, s_BoldFoldoutStyle);
            if (_targetScript.boolsFoldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.BeginVertical("box");
                
                foreach (ParameterDefinition boolParam in _targetScript.AnimatorManager.Parameters.GetBoolParameters())
                {
                    if (boolParam.IsCoreParameter) continue;
                    
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.LabelField(boolParam.name, GUILayout.MaxWidth(150));
                    EditorGUILayout.LabelField(boolParam.isLocal ? "Local" : "Synced", GUILayout.MaxWidth(75));
                    EditorGUI.BeginDisabledGroup(boolParam.isControlledByCurve);
                    bool newBoolValue = EditorGUILayout.Toggle(boolParam.GetBool());
                    EditorGUI.EndDisabledGroup();
                    if (boolParam.GetBool() != newBoolValue)
                        _targetScript.AnimatorManager.Parameters.SetParameter(boolParam.name, newBoolValue);
                    EditorGUILayout.EndHorizontal();
                }
                
                EditorGUILayout.EndVertical();
                EditorGUI.indentLevel--;
            }
        }

        #endregion Drawing Methods
    }
}