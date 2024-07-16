using System.Globalization;
using NAK.AASEmulator.Runtime;
using UnityEditor;
using static NAK.AASEmulator.Editor.EditorExtensions;

namespace NAK.AASEmulator.Editor
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(AASEmulatorRemote))]
    public class AASEmulatorRemoteEditor : UnityEditor.Editor
    {
        #region EditorGUI Fields

        private static bool _guiAvatarInfoFoldout = true;
        private static bool _guiCoreParameterInfoFoldout;

        #endregion EditorGUI Fields
        
        #region Private Variables

        private AASEmulatorRemote _remote;

        #endregion Private Variables

        #region Unity Events

        private void OnEnable()
        {
            if (target == null) return;
            _remote = (AASEmulatorRemote)target;
        }
        
        public override void OnInspectorGUI()
        {
            if (_remote == null)
                return;
            
            Draw_ScriptWarning();

            Draw_SourceRuntime();
            Draw_AvatarInfo();
            Draw_CoreParameterInfo();
        }

        #endregion Unity Events

        #region Drawing Methods
        
        private void Draw_ScriptWarning()
        {
            if (_remote.isInitializedExternally)
                return;

            EditorGUILayout.HelpBox("Warning: Do not upload this script with your avatar!\nThis script is prevented from saving to scenes & prefabs.", MessageType.Warning);
            EditorGUILayout.HelpBox("This script will automatically be added if you enable AASEmulator from the Tools menu (Tools > Enable AAS Emulator).", MessageType.Info);
        }

        private void Draw_SourceRuntime()
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.ObjectField("Source Runtime:", _remote.SourceRuntime, typeof(AASEmulatorRuntime), true);
            EditorGUILayout.EndHorizontal();
        }
        
        private void Draw_AvatarInfo()
        {
            EditorGUILayout.Space();
            _guiAvatarInfoFoldout = EditorGUILayout.Foldout(_guiAvatarInfoFoldout, "Avatar Info", true, s_BoldFoldoutStyle);
            if (!_guiAvatarInfoFoldout) return;
            
            EditorGUI.indentLevel++;
            EditorGUILayout.BeginVertical("box");
            
            string netIkStatus = _remote.IsApplyingNetIk ? "Applying Net IK" : "Not Applying Net IK";
            EditorGUILayout.LabelField("Net IK Status:", netIkStatus);
            
            string emoteStatus = _remote.IsEmotePlaying ? "Playing an Emote - Net IK Disabled" : "Not Playing an Emote - Net IK Enabled";
            EditorGUILayout.LabelField("Emote Status:", emoteStatus);
            
            string eyeMovementStatus = _remote.UseEyeMovement ? "Enabled - Eye Look On" : "Disabled - Eye Look Off";
            EditorGUILayout.LabelField("Eye Movement:", eyeMovementStatus);

            string blinkBlendshapesStatus = _remote.UseBlinkBlendshapes ? "Enabled - Eye Blink On" : "Disabled - Eye Blink Off";
            EditorGUILayout.LabelField("Blink Blendshapes:", blinkBlendshapesStatus);

            string lipsyncStatus = _remote.UseLipsync ? "Enabled - Lipsync On" : "Disabled - Lipsync Off";
            EditorGUILayout.LabelField("Lipsync:", lipsyncStatus);
            
            EditorGUILayout.EndVertical();
            EditorGUI.indentLevel--;
        }

        private void Draw_CoreParameterInfo()
        {
            EditorGUILayout.Space();
            _guiCoreParameterInfoFoldout = EditorGUILayout.Foldout(_guiCoreParameterInfoFoldout, "Core Parameter Info", true, s_BoldFoldoutStyle);
            if (!_guiCoreParameterInfoFoldout) return;
            
            EditorGUI.indentLevel++;
            EditorGUILayout.BeginVertical("box");
            
            string isLocal = _remote.AnimatorManager.IsLocal.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Is Local:", isLocal);
                        
            string distanceTo = _remote.AnimatorManager.DistanceTo.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Distance To:", distanceTo);
            
            string gestureRight = _remote.AnimatorManager.GestureRight.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Gesture Right:", gestureRight);
            
            string gestureLeft = _remote.AnimatorManager.GestureLeft.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Gesture Left:", gestureLeft);
            
            string movementX = _remote.AnimatorManager.MovementX.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Movement X:", movementX);
            
            string movementY = _remote.AnimatorManager.MovementY.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Movement Y:", movementY);
            
            string crouching = _remote.AnimatorManager.Crouching.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Crouching:", crouching);
            
            string prone = _remote.AnimatorManager.Prone.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Prone:", prone);
            
            string flying = _remote.AnimatorManager.Flying.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Flying:", flying);
            
            string sitting = _remote.AnimatorManager.Sitting.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Sitting:", sitting);
            
            string grounded = _remote.AnimatorManager.Grounded.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Grounded:", grounded);
            
            string toggle = _remote.AnimatorManager.Toggle.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Toggle:", toggle);
            
            string emote = _remote.AnimatorManager.Emote.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Emote:", emote);
            
            string cancelEmote = _remote.AnimatorManager.CancelEmote.ToString(CultureInfo.InvariantCulture);
            EditorGUILayout.LabelField("Cancel Emote:", cancelEmote);
            
            EditorGUILayout.EndVertical();
            EditorGUI.indentLevel--;
        }
        
        #endregion Drawing Methods
    }
}