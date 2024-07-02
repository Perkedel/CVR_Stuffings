#if UNITY_EDITOR
using System;
using System.Reflection;
using UnityEditor;
using UnityEngine;

namespace NAK.SimpleAAS.Extensions
{
    public static class SerializedPropertyExtensions
    {
        // Method to create a serialized property that uses the default values it should (recursive too)
        public static SerializedProperty AddWithDefaults<T>(this SerializedProperty property) where T : new()
        {
            property.arraySize++;
            SerializedProperty newArrayElement = property.GetArrayElementAtIndex(property.arraySize - 1);
            newArrayElement.SetDefaultValues(typeof(T));
            return newArrayElement;
        }

        private static void SetDefaultValues(this SerializedProperty property, Type type)
        {
            if (type.GetConstructor(Type.EmptyTypes) == null)
            {
                //Debug.LogWarning($"Type {type.Name} does not have a default constructor");
                return;
            }
            
            object instance = Activator.CreateInstance(type);

            foreach (FieldInfo fieldInfo in type.GetFields(BindingFlags.Public | BindingFlags.Instance))
            {
                SerializedProperty fieldProperty = property.FindPropertyRelative(fieldInfo.Name);
                if (fieldProperty == null)
                {
                    //Debug.LogWarning($"Field {fieldInfo.Name} not found in serialized property");
                    continue;
                }

                SetFieldValue(fieldProperty, fieldInfo.FieldType, fieldInfo.GetValue(instance));
            }

            foreach (PropertyInfo propertyInfo in type.GetProperties(BindingFlags.Public | BindingFlags.Instance))
            {
                SerializedProperty fieldProperty = property.FindPropertyRelative(propertyInfo.Name);
                if (fieldProperty == null)
                {
                    //Debug.LogWarning($"Property {propertyInfo.Name} not found in serialized property");
                    continue;
                }

                SetFieldValue(fieldProperty, propertyInfo.PropertyType, propertyInfo.GetValue(instance));
            }
        }
        
        private static void SetFieldValue(SerializedProperty fieldProperty, Type fieldType, object value)
        {
            if (value == null)
            {
                if (fieldType.IsClass) fieldProperty.SetDefaultValues(fieldType);
                return;
            }

            if (fieldType == typeof(float))
            {
                fieldProperty.floatValue = (float)value;
            }
            else if (fieldType == typeof(int))
            {
                fieldProperty.intValue = (int)value;
            }
            else if (fieldType.IsEnum)
            {
                fieldProperty.intValue = (int)value;
            }
            else if (fieldType == typeof(Vector2))
            {
                fieldProperty.vector2Value = (Vector2)value;
            }
            else if (fieldType == typeof(Vector3))
            {
                fieldProperty.vector3Value = (Vector3)value;
            }
            else if (fieldType == typeof(bool))
            {
                fieldProperty.boolValue = (bool)value;
            }
            else if (fieldType == typeof(string))
            {
                fieldProperty.stringValue = (string)value;
            }
            else if (fieldType == typeof(Color))
            {
                fieldProperty.colorValue = (Color)value;
            }
            else if (fieldType == typeof(AnimationCurve))
            {
                fieldProperty.animationCurveValue = (AnimationCurve)value;
            }
            else if (fieldType.IsClass)
            {
                fieldProperty.SetDefaultValues(fieldType);
            }
        }
    }
}
#endif
