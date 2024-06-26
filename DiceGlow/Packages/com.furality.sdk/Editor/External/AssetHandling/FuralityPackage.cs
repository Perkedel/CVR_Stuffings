using System;
using Furality.SDK.Editor.External.FoxApi;

namespace Furality.SDK.Editor.External.AssetHandling
{
    public class FuralityPackage : Package
    {
        public virtual string Name { get; set; }
        public virtual string Description { get; set; }
        public virtual string ImageUrl { get; set; }
        public virtual string ConventionId { get; set; }
        public virtual string Category { get; set; }
        public virtual bool IsPublic { get; set; }
        public virtual DateTime CreatedAt { get; set; }
        public virtual AttendanceLevel AttendanceLevel { get; set; }
        public virtual PatreonLevel PatreonLevel { get; set; } = PatreonLevel.None;
        public virtual string FallbackUrl { get; set; }
    }
}