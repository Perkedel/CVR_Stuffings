using System;

namespace Furality.SDK.Editor.External.FoxApi.Models.User
{
    [Serializable]
    public class FoxUserDto
    {
        public string id;

        public string displayName;
        
        public string registrationLevel;
        
        public bool registered;
        
        public FoxPatreonDto patreon;

        public AttendanceLevel GetLevel() => Enum.TryParse(registrationLevel, true, out AttendanceLevel lvl)
            ? lvl
            : AttendanceLevel.none;
    }
}