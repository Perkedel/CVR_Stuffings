using System.Collections.Generic;
using UnityEngine;

namespace NAK.AASEmulator.Runtime.SubSystems
{
    public class ParameterAccess
    {
        private readonly Dictionary<string, ParameterDefinition> Parameters = new();
        
        // this is for the Editor GUI only (because i am lazy)
        private readonly List<ParameterDefinition> FloatParameters = new();
        private readonly List<ParameterDefinition> IntParameters = new();
        private readonly List<ParameterDefinition> BoolParameters = new(); // + trigger

        internal void Add(string name, ParameterDefinition parameterDefinition)
        {
            Parameters.Add(name, parameterDefinition);
            switch (parameterDefinition.GetParameterType())
            {
                case AnimatorControllerParameterType.Trigger:
                case AnimatorControllerParameterType.Bool:
                    BoolParameters.Add(parameterDefinition);
                    break;
                case AnimatorControllerParameterType.Float:
                    FloatParameters.Add(parameterDefinition);
                    break;
                case AnimatorControllerParameterType.Int:
                    IntParameters.Add(parameterDefinition);
                    break;
            }
        }

        internal void Clear()
        {
            Parameters.Clear();
            FloatParameters.Clear();
            IntParameters.Clear();
            BoolParameters.Clear();
        }
        
        public bool IsFilled => Parameters.Count > 0;
        
        public Dictionary<string,ParameterDefinition>.ValueCollection GetParameters()
            => Parameters.Values;
        
        public List<ParameterDefinition> GetFloatParameters()
            => FloatParameters;
        
        public List<ParameterDefinition> GetIntParameters()
            => IntParameters;
        
        public List<ParameterDefinition> GetBoolParameters()
            => BoolParameters;
        
        #region HasParameter
        
        public bool HasParameter(string paramName)
            => Parameters.ContainsKey(paramName);

        #endregion
        
        #region SetParameter
        
        public bool SetParameter(string paramName, bool value, bool force = false)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
                return false;
            
            parameter.SetParameter(value, force);
            return true;
        }

        public bool SetParameter(string paramName, float value, bool force = false)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
                return false;
            
            parameter.SetParameter(value, force);
            return true;
        }

        public bool SetParameter(string paramName, int value, bool force = false)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
                return false;
            
            parameter.SetParameter(value, force);
            return true;
        }
        
        #endregion SetParameter
        
        #region GetParameter

        public bool GetParameter(string paramName, out bool value)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
            {
                value = false;
                return false;
            }
            
            parameter.GetParameter(out value);
            return true;
        }

        public bool GetParameter(string paramName, out float value)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
            {
                value = 0f;
                return false;
            }
            
            parameter.GetParameter(out value);
            return true;
        }

        public bool GetParameter(string paramName, out int value)
        {
            if (!Parameters.TryGetValue(paramName, out ParameterDefinition parameter)) 
            {
                value = 0;
                return false;
            }
            
            parameter.GetParameter(out value);
            return true;
        }
        
        #endregion GetParameter
    }
}