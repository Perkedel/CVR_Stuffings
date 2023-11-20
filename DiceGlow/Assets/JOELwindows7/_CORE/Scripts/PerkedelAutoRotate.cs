/**
by JOELwindows7
Perkedel Technologies
GNU GPL v3
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Perkedel.CCK.Scripts{
    public class PerkedelAutoRotate : MonoBehaviour
    {
        public bool cycling = false;
        public Vector3 addAngleBy = Vector3.up;
        public float speed = 1.0f;
        [SerializeField] private Transform theTransform;
        // private Quaternion startRot;
        // private Quaternion endRot;
        // private float ratio = 0f;

        // Start is called before the first frame update
        void Start()
        {
            if (!theTransform)
                theTransform = GetComponent<Transform>();
            // ratio = 0f;
            // InitRot();
        }

        // void InitRot(){
        //     startRot = theTransform.eulerAngles;
        //     endRot = startRot * Quaternion.Euler(addAngleBy);
        // }

        // Update is called once per frame
        void Update()
        {
            if(cycling){
                // https://discussions.unity.com/t/add-90-degrees-to-transform-rotation/31852/2
                // https://docs.unity3d.com/ScriptReference/Quaternion.AngleAxis.html
                // https://gamedev.stackexchange.com/questions/172195/adding-90-degree-y-rotation-into-script
                // https://docs.unity3d.com/ScriptReference/GameObject.GetComponent.html
                // https://docs.unity3d.com/ScriptReference/GameObject.GetComponent.html
                // https://discussions.unity.com/t/how-to-add-rotation-to-current-rotation-over-time/182630
                if(theTransform){
                    // theTransform.rotation += addAngleBy * speed * Time.deltaTime;

                    // var rotate = Quaternion.lookRotation(addAngleBy);
                    // rotate *= Quaternion.Euler(0,90,0);
                    // theTransform.rotation = Quaternion.Slerp(theTransform.rotation,rotate,Time.deltaTime * speed);

                    // theTransform.rotation = Quaternion.AngleAxis(speed * Time.deltaTime,addAngleBy) ;

                    // ratio += speed * Time.deltaTime;
                    // theTransform.eulerAngles = Vector3.Lerp(startRot, endRot, ratio);

                    // WORKS
                    // https://docs.unity3d.com/ScriptReference/Transform.RotateAround.html
                    // https://stackoverflow.com/questions/71250042/how-to-have-consistent-rotation-speed-with-transform-rotate-in-unity
                    // 
                    theTransform.RotateAround(theTransform.position, addAngleBy, speed * Time.deltaTime);
                }
            }
        }

        public void toggleCycle(){
            cycling = !cycling;
        }

        public void setCycle(bool into){
            cycling = into;
        }

        public void startCycle(){
            setCycle(true);
        }

        public void stopCycle(){
            setCycle(false);
        }
    }
}

