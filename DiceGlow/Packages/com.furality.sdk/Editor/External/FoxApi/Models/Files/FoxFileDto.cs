using System;
using System.Collections.Generic;
using Furality.SDK.Editor.External.AssetHandling;
using NUnit.Framework;

namespace Furality.SDK.Editor.External.FoxApi.Models.Files
{
    [Serializable]
    public class FoxFileDto : FuralityPackage
    {
        public string fileUuid;
        public string name;
        public string description;
        public string category;
        public string type;
        public bool supporterFile;
        public string thumbnailUrl;
        public string conventionId;

        public override string Name => name;
        public override string Id => fileUuid;
        public override string Description => description;
        public override string Category => category;
        public override AttendanceLevel AttendanceLevel => Enum.TryParse(type, true, out AttendanceLevel lvl) ? lvl : AttendanceLevel.none;
        public override PatreonLevel PatreonLevel => supporterFile ? PatreonLevel.Blue : PatreonLevel.None;
        public override bool IsPublic => !supporterFile;
        public override string ImageUrl => thumbnailUrl;
        public override string ConventionId => conventionId;

        // Supplementary overrides. This data may not be entirely correct but needs to exist to function properly
        public override List<Package> Dependencies
        {
            get
            {
                var list = new List<Package>();
                if (Category == "badge")
                {
                    list.Add(new Package() { Id = "com.furality.badgemaker", Version = new Version(1, 1, 0) });
                }
                
                switch (ConventionId)
                {
                    case "furality06":
                        list.Add(new Package() { Id = "com.furality.sylvashader", Version = new Version(1, 3, 3) });
                        break;
                    
                    case "furality07":
                        list.Add(new Package() { Id = "com.furality.umbrashader", Version = new Version(1, 6, 0)});
                        break;
                }

                return list;
            }
        }

        public override Version Version => new Version(1, 0, 0);    //TODO: Have version in the api
    }
}