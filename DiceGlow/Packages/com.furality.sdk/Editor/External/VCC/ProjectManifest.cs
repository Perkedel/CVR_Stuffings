using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using JetBrains.Annotations;
using UnityEditor.PackageManager;
using UnityEngine;

namespace Furality.SDK.Editor.External.VCC
{
    public static class ProjectManifest
    {
        public static string ProjectId;
        
        [Serializable]
        public class Dependency
        {
            public string Id;
            public string Version;
        }

        [Serializable]
        public class ProjectManifestResponse
        {
            public List<Dependency> dependencies;
            public string path;
            public string name;
            public string type;
        }

        public class ProjectManifestRequest
        {
            public string id;
        }

        [Serializable]
        private class VCCProject
        {
            public string ProjectId;
        }
        
        [ItemCanBeNull]
        public static async Task<ProjectManifestResponse> GetProjectManifest(string projectPath)
        {
            // First, we get our project ID from path
            var idResp = await VccComms.Request<VCCProject>($"projects/project?path={projectPath}", "GET");
            if (idResp == null || !idResp.success)
            {
                Debug.LogError($"Failed to get project ID for: {projectPath}");
                return null;
            }

            ProjectId = idResp.data.ProjectId;
            var manifestRequest = new ProjectManifestRequest
            {
                id = idResp.data.ProjectId
            };
            
            var resp =  await VccComms.Request<ProjectManifestResponse>("projects/manifest", "POST", manifestRequest);
                
            if (resp == null || !resp.success)
            {
                Debug.LogError($"Failed to get project manifest for: {projectPath}");
                return null;
            }
            
            return resp.data;
        }

        public static async Task<bool> IsDependencyInstalled(string id, Version minVersion)
        {
            // Get the root of our project, right before the Assets folder including the slash
            var projectPath = Application.dataPath.Substring(0, Application.dataPath.LastIndexOf("/Assets", StringComparison.Ordinal));
            projectPath = projectPath.Replace("/", "\\");
            // Replace the forward slashes with two backslashes
            var manifest = await GetProjectManifest(projectPath);
            if (manifest != null)
            {
                if (manifest.dependencies.Any(d => d.Id == id && new Version(d.Version) >= minVersion))
                    return true;
            }
            
            // We got this far, and a VCC connection could not be established. Fall back to using UPM
            var list = Client.List();
            while (!list.IsCompleted)
            {
                Thread.Sleep(10);
            }
            if (list.IsCompleted && list.Status == StatusCode.Success)
            {
                return list.Result.Any(p => p.name == id && new Version(p.version) >= minVersion);
            }

            return false;
        }
    }
}