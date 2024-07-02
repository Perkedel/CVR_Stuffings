#if UNITY_EDITOR && CVR_CCK_EXISTS
using System.Collections.Generic;
using ABI.CCK.Scripts;
using UnityEngine;

[CreateAssetMenu(fileName = "SimpleAAS_Parameters", menuName = "NAKSimpleAAS/SimpleAAS_Parameters")]
public class NAKModularSettings : ScriptableObject
{
    public List<CVRAdvancedSettingsEntry> settings = new List<CVRAdvancedSettingsEntry>();
}
#endif