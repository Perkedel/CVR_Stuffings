using System.Threading.Tasks;
using Furality.SDK.Editor.External.AssetHandling;

namespace Furality.SDK.Editor.DependencyResolving.Providers
{
    public interface IDependencyProvider
    {
        // Complete all steps necessary to download and install this package
        Task<bool> Resolve(Package package);
    }
}