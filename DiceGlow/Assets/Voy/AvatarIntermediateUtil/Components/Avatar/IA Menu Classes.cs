using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Voy.IntermediateAvatar;

namespace Voy.IntermediateAvatar.MenuSystem
{

    [Serializable]
    public class Option
    {
        public enum OptionType : int
        {
            Button, // Not Directly Supported in CVR
            Toggle,
            Joystick2D,
            Slider,
            Joystick4Axis
        }

        public string Name;

        public bool local;

        public string ParentMenuName;

        public OptionType optionType;

        public string MainParameter;

        public string JoystickUpYParameter;

        public string JoystickRightXParameter;

        public string JoystickDownYParameter;

        public string JoystickLeftXParameter;

        public string SliderParameter;

        public float Value;

        public List<string> SubMenuHistory;

    }

    [Serializable]
    public class Parameter
    {

        public string Name;

        public bool Local;

        public ParameterType Type;

        public enum ParameterType
        {
            Float, Int, Bool
        }

        public string FormerName;

        public float DefaultValue = 0f;

    }

}