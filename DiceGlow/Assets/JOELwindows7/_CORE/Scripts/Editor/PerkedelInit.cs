// Yoink from CCK also!
using System.IO;
using UnityEditor;
using UnityEditor.Build.Content;
using UnityEngine;
using UnityEngine.XR;

#pragma warning disable

[InitializeOnLoad]
public class PerkedelInit{
    static PerkedelInit(){
        const string perkedelSymbol = "PERKEDEL_DICEGLOW";
        BuildTargetGroup selectedTargetGroup = EditorUserBuildSettings.selectedBuildTargetGroup;
        string defines = PlayerSettings.GetScriptingDefineSymbolsForGroup(selectedTargetGroup);

        if(!defines.Contains(perkedelSymbol)){
            PlayerSettings.SetScriptingDefineSymbolsForGroup(selectedTargetGroup, defines + ";" + perkedelSymbol);
            Debug.Log("[Perkedel DiceGlow] Added "+perkedelSymbol+" Scripting Symbol.");
        }
    }
}