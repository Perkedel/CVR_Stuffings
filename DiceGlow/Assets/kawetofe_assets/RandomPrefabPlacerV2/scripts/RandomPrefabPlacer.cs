using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEditor;
using UnityEngine;

namespace kawetofe.randomPrefabPlacer
{
    [AddComponentMenu("kawetofe_Assets/Random Prefab placer")]
    [SelectionBase]
    public class RandomPrefabPlacer : MonoBehaviour
    {
        [HideInInspector]
        public RPPBrush rppBrush;
        [Tooltip("Object to place the prefabs on")]
        public Transform objectToPlacePrefabs = null;
        public List<PlacementPrefab> prefabs = new List<PlacementPrefab>();
        public Transform placementCircleCenter;
        [Tooltip("Adjust the placement radius")]
        public float placementRadius = 1f;
        public bool showGizmos = true;
        [HideInInspector]
        public bool brushMode = false;
        [Tooltip("Define how many objects in total should be randomly placed")]
        [SerializeField]
        public int objectsToPlace = 10;
        [Tooltip("If checked, placement is done in Playmode on Awake()")]
        [SerializeField]
        public bool placeOnAwake = false;
        [SerializeField]
        [HideInInspector]
        public float removalAlpha = 100;
        [HideInInspector]
        public bool placementAllowed = true;
        [HideInInspector]
        [Tooltip("Slope angle is ignored (useful when using on spheric objects)")]
        public bool ignoreSlopeAngle = false;
        [HideInInspector]
        public List<GameObject> objList = new List<GameObject>();
        [HideInInspector]
        public int lastBrushSetting = 0;
        [HideInInspector]
        public int selectedBrushId = 0;
        [HideInInspector]
        public float percentComplete = 0f;
        [HideInInspector]
        public bool eraseAll = false;

        //public RangeAttribute scaleRange = new RangeAttribute(0.8f,1.2f);



        // Use this for initialization
        void Awake()
        {
            if (placeOnAwake)
            {

                PlaceObjects();
            }
        }


        /// <summary>
        /// Places the Random GameObject
        /// </summary>

        public virtual void PlaceObjects()
        {
            // List<Object> objList = new List<Object>();
            if (objectToPlacePrefabs == null)
            {
                //objectToPlacePrefabs = this.gameObject.transform;
            }
            if (placementCircleCenter == null)
            {
                placementCircleCenter = transform;
            }
            for (int i = 0; i < objectsToPlace; i++)
            {
                PlacementPrefab obj = PickRandomObject();
                if (obj != null)
                {
                   

                    GameObject placed = PlaceObjectWithRandomValues(obj);

                    if (placed != null)
                    {
                        
                        placed.transform.SetParent(objectToPlacePrefabs);
                        placed.name = placed.name.Replace("Clone", "RPPClone");

                        //Register the placement for the Unity Editor undo function
#if UNITY_EDITOR
                        Undo.RegisterCreatedObjectUndo(placed.gameObject, "Object placed");

#endif
                        
                        if (!placed.name.Contains("RPPClone"))
                        {
                            placed.name = placed.name + "(RPPClone)";
                        }

                        PlacingEffect effect = placed.AddComponent<PlacingEffect>();                        
                        effect.StartEffect();
                        objList.Add(placed);
                        obj.prefab.transform.localScale = originalPrefabScale;
                        obj.prefab.transform.position = originalPrefabPos;
                        obj.prefab.transform.rotation = originalPrefabRotation;

                        //ReconnectToPrefabs();
                        //objList.Add(placed);
                    }
                }



            }
            

        }

        public void PlaceObjectWithFlowRate(float flowRate)
        {
            if (placementAllowed)
                PlaceObjects();           
            StartCoroutine(TimePassSwitch(flowRate));

        }

        /// <summary>
        /// Removes all placed object which are persistent in the selected RPP Brush
        public void RemovePlacedObjects()
        {
            
            

          
            foreach (GameObject c in objList)
            {
               
                if (c.name.Contains("(RPPClone)") && c.transform.parent == objectToPlacePrefabs)

                {
                    string a = c.name.ToString();
                    a = a.Replace("(RPPClone)", "");
                    if (rppBrush.prefabs.Exists(x => x.prefab.name == a))
                    {
                        objList.Remove(c);
                        DestroyImmediate(c);
                    }

                }
            }

        }

#if UNITY_EDITOR
        public void ReconnectToPrefabs()
        {
            //objList.Clear();
            int childCount = objectToPlacePrefabs.childCount;
            GameObject[] gameObjects = new GameObject[childCount];
            for(int i = 0; i<childCount; i++)
            {
                gameObjects[i] = objectToPlacePrefabs.GetChild(i).gameObject;
            }

            percentComplete = 0f;
            float percentDelta = 100f / childCount;
            //GameObject[] gameObjects = FindObjectsOfType<GameObject>() as GameObject[];
            foreach (GameObject c in gameObjects) 
            {
               
                if (c.name.Contains("(RPPClone)") && c.transform.parent == objectToPlacePrefabs)

                {
                    string a = c.name.ToString();
                    a = a.Replace("(RPPClone)", "");
                    if (rppBrush.prefabs.Exists(x => x.prefab.name == a))
                    {
                        Vector3 pos = c.transform.position;
                        Quaternion rot = c.transform.rotation;
                        Vector3 scale = c.transform.localScale;
                       
                        GameObject original = rppBrush.prefabs.Find(x => x.prefab.name == a).prefab.gameObject;                        
                        GameObject newC = PrefabUtility.ConnectGameObjectToPrefab(c, original);
                        newC.transform.position = pos;
                        newC.transform.rotation = rot;
                        newC.transform.localScale = scale;
                        newC.name = a + "(RPPPrefab)";
                        
                    }

                }
                percentComplete += percentDelta;
            }
        }

        #endif
        

       
    


          


        

        public void RemovePlacedObjectsInCircleWithFlowRate(float flowRate){
            if(placementAllowed)
                RemovePlacedObjectsInCircle();
            StartCoroutine(TimePassSwitch(flowRate));
        }

        /// <summary>
        /// Removes the placed objects within the displayed circle
        /// </summary>
        public void RemovePlacedObjectsInCircle()
        {
            UpdateObjList();
            //GameObject[] placedObjects = FindObjectsOfType<GameObject>() as GameObject[];
            for (int i = 0; i < objList.Count; i++)
             
            {
                GameObject c = objList[i];
                if (c.name.Contains("(RPPClone)") || c.name.Contains("(RPPPrefab)"))
               
                {
                    string a = c.name.ToString();
                    a = a.Replace("(RPPClone)","");
                    a = a.Replace("(RPPPrefab)", "");
                    Vector3 diff = placementCircleCenter.position - c.transform.position;
                    float dist = diff.sqrMagnitude;
                    if(dist <= this.placementRadius*this.placementRadius)
                    {
                        if (Random.Range(0f, 100f) < removalAlpha)
                            if (!eraseAll)
                            {
                                if (rppBrush.prefabs.Exists(x => x.prefab.name == a))
                                {
                                    PlacingEffect effect = c.AddComponent<PlacingEffect>();
                                    objList.Remove(c);
                                    effect.EraseEffect();
                                    
                                    //DestroyImmediate(c);
                                }
                            } else
                            {
                                PlacingEffect effect;
                                if (c.GetComponent<PlacingEffect>() == null)
                                {
                                    effect = c.AddComponent<PlacingEffect>();
                                } else
                                {
                                    effect = c.GetComponent<PlacingEffect>();
                                }
                                objList.Remove(c);
                                effect.EraseEffect();
                                
                            }
                           
                    }
                }
                
            }

        }

        /// <summary>
        /// Picks the random object.
        /// </summary>
        /// <returns>The random object.</returns>

        Vector3 originalPrefabScale = new Vector3(1, 1, 1);
        Vector3 originalPrefabPos = new Vector3(0, 0, 0);
        Quaternion originalPrefabRotation;
        protected virtual PlacementPrefab PickRandomObject(){
			if (prefabs.Count > 0) {
					PlacementPrefab picked = null;
					while (picked == null) {
						int randomPrefabInt = Random.Range (0, prefabs.Count);
						float randomPickNumber = Random.Range (0, 1f);
						if(randomPickNumber < prefabs[randomPrefabInt].possibility){
							picked = prefabs [randomPrefabInt];
                            originalPrefabScale = picked.prefab.transform.localScale;
                            originalPrefabPos = picked.prefab.transform.position;
                            originalPrefabRotation = picked.prefab.transform.rotation;
							Vector3 scale = RandomScale (prefabs[randomPrefabInt]);
							picked.prefab.transform.localScale = scale;
						}
				}
				return picked;
				
			
			} else {
				Debug.Log ("placement Prefabs not set in RandomObjectPlacer of gameObject "+gameObject.name);
				return null;
			}
		}

		/// <summary>
		/// Places the object with random values.
		/// </summary>
		/// <returns>The object with random values.</returns>
		/// <param name="obj">Object.</param>
		protected virtual GameObject PlaceObjectWithRandomValues(PlacementPrefab obj){
			Vector3 pos = Vector3.zero;
            bool placingAllowed = true;
			int count = 0;
			while (pos == Vector3.zero && count < 100) {
				pos = RandomPositionOnRegistredSurface + obj.placementOffset;
				count++;
			}
			GameObject newObj = null;
			Quaternion rot = RandomRotation (obj);
            Vector3 normalAngles = Quaternion.FromToRotation(Vector3.up, tempNormal).eulerAngles;
            //if(pos.x < .8f && pos.y < .8f && pos.z < 0.8f)
            //{
            //    placingAllowed = false;
            //}

            for (int i = 0; i < 3; i++)
            {
                if (!ignoreSlopeAngle)
                {
                    if (Mathf.Abs(normalAngles[i]) >= obj.maxSlopeAngle && Mathf.Abs(normalAngles[i]) <= 360f - obj.maxSlopeAngle)
                    {
                        placingAllowed = false;
                        break;
                    }
                }
            }


           // Allow only when object to place prefabs is inside preset layer mask
            if(!(obj.allowedLayers ==(obj.allowedLayers | (1 << objectToPlacePrefabs.gameObject.layer))))
            {

                placingAllowed = false;
            }
            
            if (obj.useNormalsForRotation || ignoreSlopeAngle)
            {
                rot = Quaternion.FromToRotation(Vector3.up, tempNormal)*rot;
                
            }
			if (pos != Vector3.zero) {
                RaycastHit hit;
                if(!Physics.SphereCast(pos, 5f, Vector3.up, out hit)|| ignoreSlopeAngle)
                             
                {
                    #if UNITY_EDITOR
                    // Instantiate Object
                    if (placingAllowed)
                    {
                        Object prefabObj = PrefabUtility.InstantiatePrefab(obj.prefab);
                        newObj = (GameObject)prefabObj;
                        newObj.transform.position = pos;
                        newObj.transform.rotation = rot;

                                               
                    }
                    #endif
                }
			} 
			return newObj;
		}

		/// <summary>
		/// Randoms the scale.
		/// </summary>
		/// <returns>The scale.</returns>
		Vector3 RandomScale(PlacementPrefab pprefab){
			float randomScaleFactor = Random.Range (pprefab.scaleMin, pprefab.scaleMax);
			return new Vector3 (randomScaleFactor, randomScaleFactor, randomScaleFactor);
		}


		/// <summary>
		/// Randoms the rotation in y.
		/// </summary>
		/// <returns>The rotation in y.</returns>
		Quaternion RandomRotation(PlacementPrefab pprefab){
            Vector3 rotLock = pprefab.lockedRotations;
            float xrot = 0;
            float yrot = 0;
            float zrot = 0;
            if(rotLock.x == 0)
            {
                xrot = Random.Range(0, 359f);
            }
            if (rotLock.y == 0)
            {
                yrot = Random.Range(0, 359f);
            }
            if (rotLock.z == 0)
            {
                zrot = Random.Range(0, 359f);
            }
            
			Quaternion returnQuaternion = Quaternion.Euler (new Vector3 (xrot, yrot, zrot));
			return returnQuaternion;

		}

        private Vector3 tempNormal;
        [HideInInspector]
        public Vector3 tempHitNormal;
        /// <summary>
        /// Randoms the position on registred surface.
        /// </summary>
        /// <returns>The position on registred surface.</returns>
        protected virtual Vector3 RandomPositionOnRegistredSurface
        {
            get
            {
                
                Vector3 centerPos = placementCircleCenter.position + tempHitNormal * 10f;            
                Vector3 randomPos; 
                randomPos = centerPos + Random.insideUnitSphere * placementRadius;
                Vector3 returnPos = Vector3.zero;
                RaycastHit hit;
                Vector3 raycastDirection = tempHitNormal * -1;
                if (Physics.Raycast(randomPos, raycastDirection, out hit))
                {
                    if (hit.collider.gameObject == objectToPlacePrefabs.gameObject)
                    {
                        returnPos = hit.point;
                        tempNormal = hit.normal;
                        
                        
                       
                    }
                }
                return returnPos;
            }
        }

        [HideInInspector]
        public bool removeMode = false;

        void OnDrawGizmosSelected(){
			if (showGizmos) {
				if (placementCircleCenter == null) {
					placementCircleCenter = transform;
				}
				Gizmos.color = Color.cyan;
                if (removeMode)
                {
                    Gizmos.color = Color.red;
                }
				Gizmos.DrawWireSphere (placementCircleCenter.position, this.placementRadius);
                Gizmos.color = new Color(255, 0, 0, .3f);
                Gizmos.DrawSphere(placementCircleCenter.position, this.placementRadius/10);
                
			}

		}

        // Make a RPPBrush for the Painter
#if UNITY_EDITOR
        public void MakeABrush()
        {
            

            RPPBrush brush = (RPPBrush)ScriptableObjectUtility.CreateAsset<RPPBrush>();
            brush.objectsToPlace = objectsToPlace;
            brush.prefabs = new List<PlacementPrefab>();
            foreach(PlacementPrefab p in this.prefabs)
            {
                brush.prefabs.Add(p);
            }            
            
            
            
        }
#endif
       

        public void MakeObjectsPermanent()
        {
            Transform[] components = objectToPlacePrefabs.GetComponentsInChildren<Transform>();
            foreach(Transform t in components)
            {
                if (t.gameObject.name.Contains("(RPPClone)") || t.gameObject.name.Contains("(RPPPrefab)"))
                {
                    t.gameObject.name = t.gameObject.name.Replace("(RPPClone)", "(Clone)");
                    objList.Remove(t.gameObject);
                }
            }
        }

         IEnumerator TimePassSwitch(float seconds){
            placementAllowed = false;
            yield return new WaitForSeconds(seconds);
            placementAllowed = true;
        }

        /// <summary>
        /// 
        /// </summary>
        public void SynchronizeWithPrefabChanges()
        {
            foreach(GameObject c in objList)
            {
                string a = c.name.Replace("(RPPClone)", "");
                if (rppBrush.prefabs.Exists(x => x.prefab.name == a))
                {
                    GameObject pref = rppBrush.prefabs.Find(x => x.prefab.name == a).prefab;
                    UpdateObjectToPrefabChanges(c, pref);
                }
            }

            //ReconnectToPrefabs();
        }

        public void RefreshObjList()
        {
            if (objList == null)
            {
                objList = new List<GameObject>();
            }
            else 
            {
                objList.Clear();
                for (int i = 0; i < objectToPlacePrefabs.transform.childCount; i++)
                {
                    if (objectToPlacePrefabs.transform.GetChild(i).name.Contains("(RPPClone)") || objectToPlacePrefabs.transform.GetChild(i).name.Contains("(RPPClone)"))
                    {
                        objList.Add(objectToPlacePrefabs.transform.GetChild(i).gameObject);
                    }
                }
            }
        }


        /// <summary>
        /// Update objList
        /// </summary>
        private void UpdateObjList()
        {
            if (objList == null)
            {
                objList = new List<GameObject>();
            } else if(objList.Count != 0){ 
                objList.Clear();
                for (int i = 0; i < objectToPlacePrefabs.transform.childCount; i++)
                {
                    if (objectToPlacePrefabs.transform.GetChild(i).name.Contains("(RPPClone)") || objectToPlacePrefabs.transform.GetChild(i).name.Contains("(RPPClone)"))
                    {
                        objList.Add(objectToPlacePrefabs.transform.GetChild(i).gameObject);
                    }
                }
            }
        }


		public void UpdateObjectToPrefabChanges(GameObject obj, GameObject pref)
        {
            // Check if component was deleted
            foreach (Component o2 in obj.GetComponents<Component>())
            {
                if (pref.GetComponent(o2.GetType()) == null)
                {
                    DestroyImmediate(obj.GetComponent(o2.GetType()));
                }
            }

            foreach (Component original in pref.GetComponents<Component>())
            {
                


                //if not transform
                if(original.GetType() != typeof(Transform))
                {
                    //adds component if not exists
                    Component copied;
                    if (obj.GetComponent(original.GetType()) == null)
                    {
                        copied = obj.AddComponent(original.GetType());
                    } else
                    {
                        copied = obj.GetComponent(original.GetType());
                    }

                        //get Fields
                        foreach (FieldInfo info in original.GetType().GetFields())
                        {
                            //copies fields
                            info.SetValue(copied, info.GetValue(original));
                        }
                     
                }
            }
        }
       
    }


	/// <summary>
	/// Placement prefab Class.
	/// </summary>

	[System.Serializable]
	public class PlacementPrefab:System.Object{
        [SerializeField]
        [Tooltip("Placement of this object will only be allowed on objects with these set layers")]
        public LayerMask allowedLayers = ~0;
		[SerializeField]
		[Tooltip("Drag your game prefabs here")]
        public GameObject prefab;        
        [SerializeField]
		[Tooltip("Set the possibility of appearence 0 - 1")]
		[Range(0,1f)]
		public float possibility = 0.8f;        
		[SerializeField]
		[Range(0.1f,10f)]
		public float scaleMin = .8f;
		[SerializeField]
		[Range(0.0f,100f)]
		public float scaleMax = 1.2f;       
        [Header("origin offset")]
        [Tooltip("origin offset when placing")]
        [SerializeField]
        public Vector3 placementOffset = Vector3.zero;
        [SerializeField]
        [Header("Locked rotations (1=locked, 0=free)")]
        public Vector3 lockedRotations = new Vector3(1, 0, 1);
        [SerializeField]
        [Header("let the object face the normal direction to the ground surface")]
        public bool useNormalsForRotation= false;
        [SerializeField]
        [Tooltip("max slope angle of the surface to Vector3.up to place the object")]
        public float maxSlopeAngle = 45f;       
        private Texture2D thumbnbnail;
    }

    




}



