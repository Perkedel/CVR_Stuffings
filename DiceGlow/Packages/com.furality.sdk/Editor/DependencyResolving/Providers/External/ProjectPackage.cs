using System.Threading.Tasks;
using Furality.SDK.Editor.External.AssetHandling;
using Furality.SDK.Editor.External.VCC;

namespace Furality.SDK.Editor.DependencyResolving.Providers.External
{
    public class ProjectPackage : IDependencyProvider
    {
        public class AddPackageRequest : BasePackageRequest
        {
            public string version;
        }

        public class BasePackageRequest
        {
            public string projectId;

            public string packageId;
        }

        public static async Task<bool> AddPackage(AddPackageRequest request)
        {
            var response = await VccComms.Request<string>("projects/packages", "POST", request);
            return response != null && response.success;
        }

        public async Task<bool> RemovePackage(BasePackageRequest request)
        {
            var response = await VccComms.Request<string>("projects/packages", "DELETE", request);
            return response.success;
        }
        
        public async Task RemovePackage(string projectId, string packageId) => await RemovePackage(new BasePackageRequest
        {
            projectId = projectId,
            packageId = packageId
        });

        public async Task<bool> Resolve(Package package)
        {
            return await AddPackage(new AddPackageRequest
            {
                projectId = ProjectManifest.ProjectId,
                packageId = package.Id,
                version = package.Version.ToString()
            });
        }
    }
}