using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;

namespace ml_prm
{
    static class ModUi
    {
        enum UiIndex
        {
            Hotkey = 0,
            Gravity,
            PointersReaction,
            IgnoreLocal,
            CombatReaction,
            AutoRecover,
            Slipperiness,
            Bounciness,
            ViewVelocity,
            JumpRecover,
            Buoyancy,
            VelocityMultiplier,
            MovementDrag,
            AngularDrag,
            RecoverDelay
        }

        static public event Action SwitchChange;

        static List<object> ms_uiElements = null;

        internal static void Init()
        {
            ms_uiElements = new List<object>();

            if(MelonLoader.MelonMod.RegisteredMelons.FirstOrDefault(m => m.Info.Name == "BTKUILib") != null)
                CreateUi();
        }

        // Separated method, otherwise exception is thrown, funny CSharp and optional references, smh
        static void CreateUi()
        {
            BTKUILib.QuickMenuAPI.PrepareIcon("PlayerRagdollMod", "PRM-Person", GetIconStream("person.png"));

            var l_modRoot = new BTKUILib.UIObjects.Page("PlayerRagdollMod", "MainPage", true, "PRM-Person");
            l_modRoot.MenuTitle = "Player Ragdoll Mod";
            l_modRoot.MenuSubtitle = "Become a ragdoll and change various settings for people amusement";

            var l_modCategory = l_modRoot.AddCategory("Settings");

            l_modCategory.AddButton("Switch ragdoll", "PRM-Person", "Switch between normal and ragdoll state.").OnPress += () => SwitchChange?.Invoke();

            ms_uiElements.Add(l_modCategory.AddToggle("Use hotkey", "Switch ragdoll mode with 'R' key", Settings.Hotkey));
            (ms_uiElements[(int)UiIndex.Hotkey] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.Hotkey, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Use gravity", "Apply gravity to ragdoll", Settings.Gravity));
            (ms_uiElements[(int)UiIndex.Gravity] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.Gravity, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Pointers reaction", "React to trigger colliders with CVRPointer component of 'ragdoll' type", Settings.PointersReaction));
            (ms_uiElements[(int)UiIndex.PointersReaction] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.PointersReaction, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Ignore local pointers", "Ignore local avatar's CVRPointer components of 'ragdoll' type", Settings.IgnoreLocal));
            (ms_uiElements[(int)UiIndex.IgnoreLocal] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.IgnoreLocal, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Combat reaction", "Ragdoll upon combat system death", Settings.CombatReaction));
            (ms_uiElements[(int)UiIndex.CombatReaction] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.CombatReaction, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Auto recover", "Automatically unragdoll after set recover delay", Settings.AutoRecover));
            (ms_uiElements[(int)UiIndex.AutoRecover] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.AutoRecover, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Slipperiness", "Enables/disables friction of ragdoll", Settings.Slipperiness));
            (ms_uiElements[(int)UiIndex.Slipperiness] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.Slipperiness, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Bounciness", "Enables/disables bounciness of ragdoll", Settings.Bounciness));
            (ms_uiElements[(int)UiIndex.Bounciness] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.Bounciness, state);

            ms_uiElements.Add(l_modCategory.AddToggle("View direction velocity", "Apply velocity to camera view direction", Settings.ViewVelocity));
            (ms_uiElements[(int)UiIndex.ViewVelocity] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.ViewVelocity, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Jump recover", "Recover from ragdoll state by jumping", Settings.JumpRecover));
            (ms_uiElements[(int)UiIndex.JumpRecover] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.JumpRecover, state);

            ms_uiElements.Add(l_modCategory.AddToggle("Buoyancy", "Enable buoyancy in fluid volumes. Warning: constantly changes movement and air drag of hips, spine and chest.", Settings.Buoyancy));
            (ms_uiElements[(int)UiIndex.Buoyancy] as BTKUILib.UIObjects.Components.ToggleButton).OnValueUpdated += (state) => OnToggleUpdate(UiIndex.Buoyancy, state);

            ms_uiElements.Add(l_modRoot.AddSlider("Velocity multiplier", "Velocity multiplier upon entering ragdoll state", Settings.VelocityMultiplier, 1f, 50f));
            (ms_uiElements[(int)UiIndex.VelocityMultiplier] as BTKUILib.UIObjects.Components.SliderFloat).OnValueUpdated += (value) => OnSliderUpdate(UiIndex.VelocityMultiplier, value);

            ms_uiElements.Add(l_modRoot.AddSlider("Movement drag", "Movement resistance", Settings.MovementDrag, 0f, 50f));
            (ms_uiElements[(int)UiIndex.MovementDrag] as BTKUILib.UIObjects.Components.SliderFloat).OnValueUpdated += (value) => OnSliderUpdate(UiIndex.MovementDrag, value);

            ms_uiElements.Add(l_modRoot.AddSlider("Angular movement drag", "Rotation movement resistance", Settings.AngularDrag, 0f, 50f));
            (ms_uiElements[(int)UiIndex.AngularDrag] as BTKUILib.UIObjects.Components.SliderFloat).OnValueUpdated += (value) => OnSliderUpdate(UiIndex.AngularDrag, value);

            ms_uiElements.Add(l_modRoot.AddSlider("Recover delay (seconds)", "Recover delay for automatic recover", Settings.RecoverDelay, 1f, 10f));
            (ms_uiElements[(int)UiIndex.RecoverDelay] as BTKUILib.UIObjects.Components.SliderFloat).OnValueUpdated += (value) => OnSliderUpdate(UiIndex.RecoverDelay, value);

            l_modCategory.AddButton("Reset settings", "", "Reset mod settings to default").OnPress += Reset;
        }

        static void OnToggleUpdate(UiIndex p_index, bool p_state, bool p_force = false)
        {
            switch(p_index)
            {
                case UiIndex.Hotkey:
                    Settings.SetSetting(Settings.ModSetting.Hotkey, p_state);
                    break;

                case UiIndex.Gravity:
                    Settings.SetSetting(Settings.ModSetting.Gravity, p_state);
                    break;

                case UiIndex.PointersReaction:
                    Settings.SetSetting(Settings.ModSetting.PointersReaction, p_state);
                    break;

                case UiIndex.IgnoreLocal:
                    Settings.SetSetting(Settings.ModSetting.IgnoreLocal, p_state);
                    break;

                case UiIndex.CombatReaction:
                    Settings.SetSetting(Settings.ModSetting.CombatReaction, p_state);
                    break;

                case UiIndex.AutoRecover:
                    Settings.SetSetting(Settings.ModSetting.AutoRecover, p_state);
                    break;

                case UiIndex.Slipperiness:
                    Settings.SetSetting(Settings.ModSetting.Slipperiness, p_state);
                    break;

                case UiIndex.Bounciness:
                    Settings.SetSetting(Settings.ModSetting.Bounciness, p_state);
                    break;

                case UiIndex.ViewVelocity:
                    Settings.SetSetting(Settings.ModSetting.ViewVelocity, p_state);
                    break;

                case UiIndex.JumpRecover:
                    Settings.SetSetting(Settings.ModSetting.JumpRecover, p_state);
                    break;

                case UiIndex.Buoyancy:
                    Settings.SetSetting(Settings.ModSetting.Buoyancy, p_state);
                    break;
            }

            if(p_force)
                (ms_uiElements[(int)p_index] as BTKUILib.UIObjects.Components.ToggleButton).ToggleValue = p_state;
        }

        static void OnSliderUpdate(UiIndex p_index, float p_value, bool p_force = false)
        {
            switch(p_index)
            {
                case UiIndex.VelocityMultiplier:
                    Settings.SetSetting(Settings.ModSetting.VelocityMultiplier, p_value);
                    break;

                case UiIndex.MovementDrag:
                    Settings.SetSetting(Settings.ModSetting.MovementDrag, p_value);
                    break;

                case UiIndex.AngularDrag:
                    Settings.SetSetting(Settings.ModSetting.AngularDrag, p_value);
                    break;

                case UiIndex.RecoverDelay:
                    Settings.SetSetting(Settings.ModSetting.RecoverDelay, p_value);
                    break;
            }

            if(p_force)
                (ms_uiElements[(int)p_index] as BTKUILib.UIObjects.Components.SliderFloat).SetSliderValue(p_value);
        }

        static void Reset()
        {
            OnToggleUpdate(UiIndex.Hotkey, true, true);
            OnToggleUpdate(UiIndex.Gravity, true, true);
            OnToggleUpdate(UiIndex.PointersReaction, true, true);
            OnToggleUpdate(UiIndex.IgnoreLocal, true, true);
            OnToggleUpdate(UiIndex.CombatReaction, true, true);
            OnToggleUpdate(UiIndex.AutoRecover, false, true);
            OnToggleUpdate(UiIndex.Slipperiness, false, true);
            OnToggleUpdate(UiIndex.Bounciness, false, true);
            OnToggleUpdate(UiIndex.ViewVelocity, false, true);
            OnToggleUpdate(UiIndex.JumpRecover, false, true);
            OnToggleUpdate(UiIndex.Buoyancy, true, true);
            OnSliderUpdate(UiIndex.VelocityMultiplier, 2f, true);
            OnSliderUpdate(UiIndex.MovementDrag, 1f, true);
            OnSliderUpdate(UiIndex.AngularDrag, 1f, true);
            OnSliderUpdate(UiIndex.RecoverDelay, 3f, true);
        }

        static Stream GetIconStream(string p_name)
        {
            Assembly l_assembly = Assembly.GetExecutingAssembly();
            string l_assemblyName = l_assembly.GetName().Name;
            return l_assembly.GetManifestResourceStream(l_assemblyName + ".resources." + p_name);
        }
    }
}
