using System.Collections;
using UnityEngine;

namespace Voy.IntermediateAvatar.Behaviours
{
    public class IATrackingControl: StateMachineBehaviour
    {
        public Tracking Head;
        public Tracking LeftHand;
        public Tracking RightHand;
        public Tracking Hip;
        public Tracking LeftFoot;
        public Tracking RightFoot;
        public Tracking LeftFingers;
        public Tracking RightFingers;
        public Tracking Eyes;
        public Tracking Mouth;

        public enum Tracking : int
        {
            NoChange,
            Tracking,
            Animation
        }
        
    }
}