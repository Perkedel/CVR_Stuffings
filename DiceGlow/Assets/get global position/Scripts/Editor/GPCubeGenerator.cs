using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditorInternal;
using UnityEditor;
using UnityEditor.Presets;
using UnityEngine.UI;
using UnityEngine.Events;
using UnityEditor.Events;
using ABI.CCK.Components;

[CustomEditor(typeof(GenerateCubes))]
public class GPCubeGenerator : Editor
{
    private GenerateCubes _myScript;
    // Start is called before the first frame update
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        _myScript = (GenerateCubes)target;

        if (GUILayout.Button("Generate Objects"))
        {
            generateCubes();
        }
    }

    public void generateCubes()
    {
        // We empty the interactable list first
        while (_myScript.cubeParent.transform.childCount > 0)
        {
            GameObject.DestroyImmediate(_myScript.cubeParent.transform.GetChild(0).gameObject);
        }

        _myScript.gameController.teams.Clear();

        for (int i = 0; i < _myScript.nbTeams; i++)
        {
            // We create a new cube
            GameObject duplicateCube = Instantiate(_myScript.cube);

            // We add it to the parent
            duplicateCube.transform.parent = _myScript.cubeParent.transform;

            duplicateCube.name = "(" + i + ")";

            // We get the object to turn on on team join
            GameObject childToEnable = duplicateCube.transform.GetChild(1).gameObject;

            Team teamToAdd = new Team();

            teamToAdd.playerLimit = 1;

            UnityEventTools.AddBoolPersistentListener(teamToAdd.teamJoinedEvent, childToEnable.SetActive, true);

            _myScript.gameController.teams.Add(teamToAdd);
        }
    }
}
