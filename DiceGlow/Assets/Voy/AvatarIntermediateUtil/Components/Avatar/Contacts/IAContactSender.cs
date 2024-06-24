using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Voy.IntermediateAvatar.Components
{

    public class IAContactSender : MonoBehaviour
    {

        //Equivalent of Contact Sender
        public Transform RootTransform;
        public ShapeTypes ShapeType;
        public float Radius = 0.5f;
        public float Height = 2f;
        public Vector3 Position;
        public Quaternion Rotation;
        public List<string> CollisionTags;

    }
}