using System;
using UnityEditor;

namespace Furality.SDK.Editor.Helpers
{
    /**
     * Due to the way Unity handles package imports, it's imperative we have a way to allow data to persist across domain
     * reloads. This class was designed in such a way. It saves data to SessionState and supports default values.
     * If data already exists in SessionState, it will not be overwritten.
     */
    public class SavedState<T>
    {
        private const string NamePrefix = "furality:";
        
        private readonly string _name;
        private T _value;
        
        public SavedState(string name, T initialValue = default)
        {
            _name = NamePrefix + name;
            Value = GetValue(_name, initialValue);
        }

        public T Value
        {
            get => GetValue(_name, _value);
            set
            {
                SetValue(_name, value);
                _value = value;
            }
        }

        private static T GetValue(string key, T defaultValue)
        {
            if (typeof(T) == typeof(bool))
            {
                return (T)Convert.ChangeType(
                    SessionState.GetBool(key, (bool)Convert.ChangeType(defaultValue, typeof(bool))), typeof(T));
            }

            if (typeof(T) == typeof(float))
            {
                return (T)Convert.ChangeType(
                    SessionState.GetFloat(key, (float)Convert.ChangeType(defaultValue, typeof(float))), typeof(T));
            }
            
            if (typeof(T) == typeof(int))
            {
                return (T)Convert.ChangeType(
                    SessionState.GetInt(key, (int)Convert.ChangeType(defaultValue, typeof(int))), typeof(T));
            }

            if (typeof(T) == typeof(string[]))
            {
                var defaultVal = (string[])Convert.ChangeType(defaultValue, typeof(string[]));
                var length = SessionState.GetInt(key+":length", 0);
                if (length == 0)
                {
                    return (T)Convert.ChangeType(defaultVal, typeof(T));
                }
                var array = new string[length];
                for (var i = 0; i < length; i++)
                {
                    array[i] = SessionState.GetString(key + ":" + i, "");
                }

                return (T)Convert.ChangeType(array, typeof(T));
            }

            return default;
        }

        private static void SetValue(string key, T value)
        {
            if (typeof(T) == typeof(bool))
            {
                SessionState.SetBool(key, (bool)Convert.ChangeType(value, typeof(bool)));
            }

            if (typeof(T) == typeof(float))
            {
                SessionState.SetFloat(key, (float)Convert.ChangeType(value, typeof(float)));
            }
            
            if (typeof(T) == typeof(int))
            {
                SessionState.SetInt(key, (int)Convert.ChangeType(value, typeof(int)));
            }

            if (typeof(T) == typeof(string[]))
            {
                var inputArray = (string[])Convert.ChangeType(value, typeof(string[]));
                SessionState.SetInt(key+":length", inputArray.Length);
                for (var i = 0; i < inputArray.Length; i++)
                {
                    SessionState.SetString(key+":"+i, inputArray[i]);
                }
            }
        }
    }
}