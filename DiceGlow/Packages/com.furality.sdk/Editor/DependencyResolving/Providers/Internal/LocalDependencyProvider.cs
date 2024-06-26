using System;
using System.Linq;
using System.Threading.Tasks;
using Furality.SDK.Editor.External.AssetHandling;
using Furality.SDK.Editor.Helpers;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.DependencyResolving.Providers.Internal
{
    /**
     * Local dependency resolver is responsible for removing our requirement for the VCC.
     * In the future, I'd like to modify this to actually request on VRChat's official and curated package lists
     * and then just download the packages from there instead of hard-coding it
     */
    public class LocalDependencyProvider : IDependencyProvider
    {
        private static readonly FuralityPackage[] _fallbacks = new []
        {
            new FuralityPackage()
            {
                Id = "com.llealloo.audiolink",
                Version = new Version(0, 3, 2),
                FallbackUrl = 
                    "https://github.com/llealloo/vrc-udon-audio-link/releases/download/0.3.2/AudioLink_0.3.2_minimal.unitypackage"
            },
        };
        
        public async Task<bool> Resolve(Package packageToResolve)
        {
            var package = new LocalDataSource().FindPackage(packageToResolve.Id);

            if (package == null) package = _fallbacks.ToList().Find(x => x.Id == packageToResolve.Id && x.Version == packageToResolve.Version);
            
            if (package == null || package.FallbackUrl == null)
                return false;

            string path = await AsyncHelper.MainThread(() => $"{Application.temporaryCachePath}/{packageToResolve.Id}.unitypackage");
                
            // If the ID is badgemaker, we need to (for now) delete all assets matching the name "Magick.Native-Q8-x64", "Magick.NET-Q8-x64" and "Magick.NET.Core" as they are already incluyded
            if (packageToResolve.Id == "com.furality.badgemaker")
            {
                // Find all assets matching the name
                var assets = AssetDatabase.FindAssets("Magick.Native-Q8-x64");
                foreach (var asset in assets)
                {
                    var assetPath = AssetDatabase.GUIDToAssetPath(asset);
                    AssetDatabase.DeleteAsset(assetPath);
                }
                assets = AssetDatabase.FindAssets("Magick.NET-Q8-x64");
                foreach (var asset in assets)
                {
                    var assetPath = AssetDatabase.GUIDToAssetPath(asset);
                    AssetDatabase.DeleteAsset(assetPath);
                }

                assets = AssetDatabase.FindAssets("Magick.NET.Core");
                foreach (var asset in assets)
                {
                    var assetPath = AssetDatabase.GUIDToAssetPath(asset);
                    AssetDatabase.DeleteAsset(assetPath);
                }
            }

            // Install our dependencies first
            if (package.Dependencies != null)
            {
                foreach (var dependency in package.Dependencies)
                {
                    if (!await DependencyManager.Resolve(dependency))
                    {
                        return false;
                    }
                }
            }
            
            // Then install the package
            DownloadHelper.Enqueue(package.Id, package.FallbackUrl);
            return true;
        }
    }
}