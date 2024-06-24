using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Voy.IntermediateAvatar.Components
{
    public enum ShapeTypes : int
    {
        Sphere,
        Capsule,
        Cube
    }

    public enum ReceiverTypeEnum : int
    {
        Constant,
        OnEnter,
        Proximity
    }
    public class IAContactReciever : MonoBehaviour
    {

        //Equivalent of Contact Reciever
        public Transform RootTransform;
        public ShapeTypes ShapeType;
        public float Radius = 0.5f;
        public float Height = 2f;
        public Vector3 Position;
        public Quaternion Rotation;
        public List<string> CollisionTags;
        public bool AllowSelf = true;
        public bool AllowOthers = true;
        public bool LocalOnly = false;
        public ReceiverTypeEnum ReceiverType;
        public string Parameter;
        public float MinVelocity;

    }
}