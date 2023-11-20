/**
by JOELwindows7
Perkedel Technologies
GNU GPL v3
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Perkedel.CCK.Scripts{
    public class PerkedelBolaControl : MonoBehaviour
    {
        /*
        https://docs.unity3d.com/ScriptReference/Rigidbody.AddForce.html
        https://docs.unity3d.com/ScriptReference/ForceMode.Impulse.html
        https://forum.unity.com/threads/addforce-to-direction.245907/
        https://docs.unity3d.com/ScriptReference/Input.GetAxis.html
        */

        public bool controlling = false;
        public float speed = 1f;
        [SerializeField] private Rigidbody anRigid;

        // Start is called before the first frame update
        void Start()
        {
            if(!anRigid)
                anRigid = GetComponent<Rigidbody>();
        }

        // Update is called once per frame
        void Update()
        {
            
        }

        void FixedUpdate()
        {
            if(controlling){
                if(anRigid){
                    anRigid.AddForce(Input.GetAxis("Horizontal")*speed,0f,Input.GetAxis("Vertical")*speed,ForceMode.Impulse);
                }
            }
        }

        public void setControlling(bool into){
            controlling = into;
        }
    }
}