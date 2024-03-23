using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace kawetofe.randomPrefabPlacer {
    [CreateAssetMenu(fileName = "RPPBrush", menuName = "RandomPrefabPlacer/RPPBrush")]
    [Serializable]
    public class RPPBrush : ScriptableObject {
        [TextArea]
        [Tooltip("Doesn't do anything. Just comments shown in inspector")]
        public string Notes = "This script needs Random Prefab Placer Asset to work \n https://assetstore.unity.com/packages/tools/terrain/random-prefab-placer-104765 ";
        public List<PlacementPrefab> prefabs = new List<PlacementPrefab>();
        public int objectsToPlace = 10;
    } }
