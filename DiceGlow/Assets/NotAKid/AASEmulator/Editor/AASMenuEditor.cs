using NAK.AASEmulator.Runtime;
using UnityEditor;
using UnityEngine;
using static ABI.CCK.Scripts.CVRAdvancedSettingsEntry;
using static NAK.AASEmulator.Runtime.AASEmulatorRuntime;
using static NAK.AASEmulator.Runtime.AASMenu;

namespace NAK.AASEmulator.Editor
{
    [CustomEditor(typeof(AASMenu))]
    public class AASMenuEditor : UnityEditor.Editor
    {
        #region Variables

        private AASMenu _targetScript;

        #endregion

        #region Unity / GUI Methods

        private void OnEnable()
        {
            OnRequestRepaint -= Repaint;
            OnRequestRepaint += Repaint;
            _targetScript = (AASMenu)target;
        }
        private void OnDisable() => OnRequestRepaint -= Repaint;

        public override void OnInspectorGUI()
        {
            if (_targetScript == null)
                return;

            Draw_ScriptWarning();

            Draw_AASMenus();
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

        private void Draw_AASMenus()
        {
            foreach (AASMenuEntry t in _targetScript.entries)
                DisplayMenuEntry(t);
        }
        
        private void DisplayMenuEntry(AASMenuEntry entry)
        {
            GUILayout.BeginVertical("box");

            EditorGUILayout.LabelField("Menu Name", entry.menuName);
            EditorGUILayout.LabelField("Machine Name", entry.machineName);
            EditorGUILayout.LabelField("Settings Type", entry.settingType.ToString());
            
            switch (entry.settingType)
            {
                case SettingsType.GameObjectDropdown:
                    int oldIndex = (int)entry.valueX;
                    int newIndex = EditorGUILayout.Popup("Value", oldIndex, entry.menuOptions);
                    if (newIndex != oldIndex)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newIndex);
                        entry.valueX = newIndex;
                    }
                    break;
                case SettingsType.GameObjectToggle:
                    bool oldValue = entry.valueX >= 0.5f;
                    bool newValue = EditorGUILayout.Toggle("Value", oldValue);
                    if (newValue != oldValue)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newValue);
                        entry.valueX = newValue ? 1f : 0f;
                    }
                    break;
                case SettingsType.Slider:
                    float oldSliderValue = entry.valueX;
                    float newSliderValue = EditorGUILayout.Slider("Value", oldSliderValue, 0f, 1f);
                    if (newSliderValue != oldSliderValue)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newSliderValue);
                        entry.valueX = newSliderValue;
                    }
                    break;
                case SettingsType.InputSingle:
                    float oldSingleValue = entry.valueX;
                    float newSingleValue = EditorGUILayout.FloatField("Value", oldSingleValue);
                    if (newSingleValue != oldSingleValue)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newSingleValue);
                        entry.valueX = newSingleValue;
                    }
                    break;
                case SettingsType.InputVector2:
                    Vector2 oldVector2Value = new Vector2(entry.valueX, entry.valueY);
                    Vector2 newVector2Value = EditorGUILayout.Vector2Field("Value", oldVector2Value);
                    if (newVector2Value != oldVector2Value)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newVector2Value);
                        entry.valueX = newVector2Value.x;
                        entry.valueY = newVector2Value.y;
                    }
                    break;
                case SettingsType.InputVector3:
                    Vector3 oldVector3Value = new Vector3(entry.valueX, entry.valueY, entry.valueZ);
                    Vector3 newVector3Value = EditorGUILayout.Vector3Field("Value", oldVector3Value);
                    if (newVector3Value != oldVector3Value)
                    {
                        _targetScript.AnimatorManager.SetParameter(entry.machineName, newVector3Value);
                        entry.valueX = newVector3Value.x;
                        entry.valueY = newVector3Value.y;
                        entry.valueZ = newVector3Value.z;
                    }
                    break;
                // TODO: AAAAAAAAAAAA
                case SettingsType.MaterialColor:
                case SettingsType.Joystick2D:
                case SettingsType.Joystick3D:
                default:
                    break;
            }

            GUILayout.EndVertical();
        }

        #endregion
    }
}