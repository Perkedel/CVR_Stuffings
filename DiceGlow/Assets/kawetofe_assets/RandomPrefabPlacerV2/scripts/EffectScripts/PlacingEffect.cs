using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace kawetofe.randomPrefabPlacer
{
    [ExecuteInEditMode]
    public class PlacingEffect : MonoBehaviour
    {

        Vector3 initialScale = Vector3.zero;
        Vector3 wantedScale;
        float effectSpeed = 5f;



        // Use this for initialization
        //void Awake()
        //{
        //    wantedScale = transform.localScale;
        //    transform.localScale = initialScale;
        //    ReconnectToPrefab();
        //}

        private void Awake()
        {
            StartCoroutine(SelfDestruction());
        }



        public void StartEffect()

        {
            
            wantedScale = transform.localScale;
            transform.localScale = initialScale;
            StartCoroutine(ScaleEffect());
            StartCoroutine(SelfDestruction());
        }

        IEnumerator ScaleEffect()
        {
            effectSpeed = 5f;
            while (transform.localScale != wantedScale)
            {
                transform.localScale = Vector3.Lerp(transform.localScale, wantedScale, Time.deltaTime * effectSpeed);
                yield return null;
            }

            DestroyImmediate(this);
        }

        IEnumerator CREraseEffect()
        {
            float time1 = Time.time;
            while (transform.localScale != wantedScale)
            {
                transform.localScale = Vector3.Lerp(transform.localScale, wantedScale, Time.deltaTime * effectSpeed);
                yield return null;
                if (Time.time > time1 + .22f)
                {
                    //Debug.Log("Break");
                    break;
                }
            }
            DestroyImmediate(transform.gameObject);
        }

        

        public void EraseEffect()
        {
            initialScale = transform.localScale;
            wantedScale = Vector3.zero;
            StartCoroutine(CREraseEffect());
            effectSpeed = 1f;
            
        }

        IEnumerator SelfDestruction()
        {
            yield return new WaitForSeconds(5f);
            DestroyImmediate(this);
        }

        

       
    }
}
