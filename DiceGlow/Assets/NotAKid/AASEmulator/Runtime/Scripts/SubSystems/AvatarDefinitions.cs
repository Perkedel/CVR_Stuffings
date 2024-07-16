using System.Collections.Generic;
using JetBrains.Annotations;

/// <summary>
/// AAS, Core Parameters, Default layer names, and other Avatar-specific definitions are stored here.
/// </summary>
namespace NAK.AASEmulator.Runtime.SubSystems
{
    [PublicAPI]
    public static class AvatarDefinitions
    {
        #region AAS
        
        // Sync usage- may change in future?
        public const int AAS_MAX_SYNCED_BITS = 3200;
        public const int AAS_FLOAT_BIT_USAGE = 32;
        public const int AAS_INT_BIT_USAGE = 32;
        //public const int AAS_BOOL_BIT_USAGE = 1;
        //public const int AAS_BYTE_BIT_USAGE = 8;
        
        #endregion AAS

        #region Layers
        
        // Hardcoded layer names
        public const string LOCOMOTION_EMOTES_LAYER_NAME = "Locomotion/Emotes";
        public const string HAND_LEFT_LAYER_NAME = "LeftHand";
        public const string HAND_RIGHT_LAYER_NAME = "RightHand";
        public const string TOGGLES_LAYER_NAME = "Toggles";
        
        #endregion Layers

        #region Parameters
        
        // Hardcoded prefix to signify non-synced parameters
        public const string LOCAL_PARAMETER_PREFIX = "#";
        
        // Synced Core Parameters (synced by owner client)
        public const string MovementX = "MovementX";
        public const string MovementY = "MovementY";
        public const string Grounded = "Grounded";
        public const string Crouching = "Crouching";
        public const string Prone = "Prone";
        public const string Flying = "Flying";
        public const string Sitting = "Sitting";
        //public const string Swimming = "Swimming"; // TODO: This is still not yet a core param, eats 1 bit of AAS
        public const string GestureRight = "GestureRight";
        public const string GestureLeft = "GestureLeft";
        public const string Toggle = "Toggle";
        public const string Emote = "Emote";
        public const string CancelEmote = "CancelEmote";
        
        // Local Core Parameters (set by all clients)
        public const string IsLocal = "IsLocal";
        public const string GestureLeftIdx = "GestureLeftIdx";
        public const string GestureRightIdx = "GestureRightIdx";
        public const string DistanceTo = "DistanceTo";
        public const string VisemeIdx = "VisemeIdx";

        public static readonly HashSet<string> CoreParameters = new()
        {
            // Synced Core Parameters
            MovementX,
            MovementY,
            Grounded,
            Crouching,
            Prone,
            Flying,
            Sitting,
            CancelEmote,
            //Swimming, // swimming is not yet a core parameter
            GestureRight,
            GestureLeft,
            Toggle,
            Emote,
            
            // Local Core Parameters
            IsLocal,
            GestureLeftIdx,
            GestureRightIdx,
            DistanceTo,
            VisemeIdx
        };
        
        public static bool IsCoreParameter(string name)
        {
            return CoreParameters.Contains(name);
        }

        public static bool IsLocalParameter(string name)
        {
            return name.StartsWith(LOCAL_PARAMETER_PREFIX);
        }
        
        #endregion Parameters
        
        #region Enums
        
        // Oculus Lipsync
        public enum VisemeIndex
        {
            sil,
            PP,
            FF,
            TH,
            DD,
            kk,
            CH,
            SS,
            nn,
            RR,
            aa,
            E,
            I,
            O,
            U
        }

        // -1f to 6f, 0-1f is Fist weight
        public enum GestureIndex
        {
            HandOpen, // enum starts at 0 cause enum field doesn't like negative values
            Neutral,
            Fist,
            ThumbsUp,
            HandGun,
            Fingerpoint,
            Victory,
            RockNRoll
        }

        // Oculus Lipsync, Loudness, Loudness
        public enum VisemeModeIndex
        {
            Visemes = 0,
            Single_Blendshape,
            Jaw_Bone,
        }
        
        #endregion Enums
    }
}