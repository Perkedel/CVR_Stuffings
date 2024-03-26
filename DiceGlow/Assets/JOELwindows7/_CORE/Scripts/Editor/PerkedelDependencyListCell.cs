#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System;
using UnityEngine;
using UnityEngine.UIElements; 
using UnityEditor;


namespace com.perkedel.DiceGlow{
    public enum DependencyScanMethod{
        Defines,
        Files,
    }

    public class PerkedelDependencyListCell
    {
        public string name{ get; set; }
        public DependencyScanMethod scanMethod{ get; set; }
        public string[] basicFilePaths{ get; set; }
        public bool isPaid{ get; set; }
        public string[] fullVersionFilePaths{ get; set; }
        private string scriptingDefines{ get; set; }
        public string whatDefine{ get; set; }

        public PerkedelDependencyListCell(){}

        public PerkedelDependencyListCell(string name){
            name = name;
        }

        public PerkedelDependencyListCell(string name, DependencyScanMethod scanMethod){
            name = name;
            scanMethod = scanMethod;
        }

        public PerkedelDependencyListCell(string name, DependencyScanMethod scanMethod, string whatDefine){
            name = name;
            scanMethod = scanMethod;
            whatDefine = whatDefine;
        }

        public bool executeScan(string handoverDefines = ""){
            scriptingDefines = handoverDefines;
            return executeScan();
        }


        public bool executeScan(){
            // Also NMF. sorry kafeijao
            scriptingDefines = PlayerSettings.GetScriptingDefineSymbolsForGroup(
                EditorUserBuildSettings.selectedBuildTargetGroup
            );
            switch(scanMethod){
                case DependencyScanMethod.Defines:
                    // if(whatDefine)
                        return scriptingDefines.Contains(whatDefine);
                        // return PerkedelWelcome.scriptingDefines.Contains(whatDefine);
                        // if(handoverDefines)
                            // return handoverDefines.Contains(whatDefine);
                    break;
                case DependencyScanMethod.Files:
                    break;
                default:
                    break;
            }
            return false;
        }
    }

}
#endif