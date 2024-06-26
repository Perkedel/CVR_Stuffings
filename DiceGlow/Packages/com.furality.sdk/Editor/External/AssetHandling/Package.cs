using System;
using System.Collections.Generic;

namespace Furality.SDK.Editor.External.AssetHandling
{
    public class Package
    {
        public virtual string Id { get; set; }
        public virtual Version Version { get; set; }
        public virtual List<Package> Dependencies { get; set; } = new();    // Id, Version
    }
}