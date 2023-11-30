using System;
using System.Collections.Generic;
using UnityEngine;

namespace CVRLua
{
    public class LuaScript : MonoBehaviour
    {
        public List<TextAsset> Scripts = new List<TextAsset>();
        public List<string> VariableNames = new List<string>();
        public List<string> VariableValues = new List<string>();
        public List<string> VariableObjectNames = new List<string>();
        public List<UnityEngine.Object> VariableObjectValues = new List<UnityEngine.Object>();
    }
}
