using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Furality.SDK.Editor.DependencyResolving.Providers;
using Furality.SDK.Editor.External.AssetHandling;
using Furality.SDK.Editor.External.FoxApi.Models.Files;
using Furality.SDK.Editor.Helpers;
using UnityEngine;

namespace Furality.SDK.Editor.External.FoxApi.Endpoints
{
    public class FoxFiles : FoxResource, IDependencyProvider, IPackageDataSource
    { 
        private FoxFileDto[] _files;

        public FoxFiles(FoxApi api) : base(api)
        {
            DependencyManager.AddProvider(this);
        }

        public FuralityPackage FindPackage(string id) => _files.ToList().Find(x => x.Id == id);

        public async Task<string> PreSignDownload(string fileId)
        {
            // Request on https://api.fynn.ai/v1/file/{fileId} with bearer token
            // Returns a presigned download link
            var resp = await API.Get<FileResponse>($"file/{fileId}");
            // Replace to rationalized URL, this is a temporary fix until we can get the API to return the correct URL.
            return resp?.url?.Replace("media-furality-online.nyc3.digitaloceanspaces.com", "media.furality.online");
        }
        
        public async Task<bool> Resolve(Package package)
        {
            // Attempt to presign the download for this ID, if it fails, return false
            var url = await PreSignDownload(package.Id);
            if (url == null)
                return false;

            Debug.Log("Downloading Package: " + package.Id);
            DownloadHelper.Enqueue(package.Id, url);
            return true;
        }

        public override async void OnPostLogin()
        {
            var filesResp = await API.Get<FoxFilesDto>("file");
            _files = filesResp?.files;
            
            base.OnPostLogin();
        }

        public override void Dispose()
        {
            _files = null;
        }

        public IEnumerable<FuralityPackage> GetPackages()
        {
            return _files;
        }

        public Version GetInstalledPackage(string id)
        {
            // Query assetDatabase for any assets with the name {id}.json
            // If there are any, return the first one
            // If there are none, return nul
            var foundVersion = PlayerPrefs.GetString("furality:packageVersion:" + id);
            return string.IsNullOrEmpty(foundVersion) ? null : new Version(foundVersion);
        }
    }
}