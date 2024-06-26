using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Furality.SDK.Editor.External.Boop;
using Furality.SDK.Editor.External.Boop.Types;
using Furality.SDK.Editor.External.FoxApi.Endpoints;
using UnityEditor;
using UnityEngine;

namespace Furality.SDK.Editor.External.FoxApi
{
    public class FoxApi
    {
        private const string BaseUrl = "https://api.fynn.ai/v2/";

        private static string _authToken
        {
            get => SessionState.GetString("furality:authToken", null);
            set => SessionState.SetString("furality:authToken", value);
        }

        public FoxFiles FilesApi;
        public FoxUsers UsersApi;

        public bool IsLoggedIn => !string.IsNullOrEmpty(_authToken) && FilesApi.HasFinishedLogin && UsersApi.HasFinishedLogin;

        public FoxApi()
        {
            BoopAuth.OnLoggedIn += OnLogin;
            BoopAuth.OnLoggedOut += Logout;
            
            FilesApi = new FoxFiles(this);
            UsersApi = new FoxUsers(this);
        }

        private void Logout()
        {
            _authToken = null;
            
            FilesApi.Dispose();
            UsersApi.Dispose();
        }

        private void OnLogin(TokenResponse token)
        {
            _authToken = token.access_token;
            
            FilesApi.OnPostLogin();
            UsersApi.OnPostLogin();
        }

        public async Task<T> Get<T>(string endpoint) where T : class
        {
            if (string.IsNullOrEmpty(_authToken))
            {
                return null;
            }

            // Send a GET request to the endpoint
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authToken);
                var response = await client.GetAsync(BaseUrl + endpoint);

                if (!response.IsSuccessStatusCode)
                {
                    Debug.LogError($"Failed to GET {endpoint}: {response.StatusCode}");
                    return null;
                }

                var json = await response.Content.ReadAsStringAsync();
                return JsonUtility.FromJson<T>(json);
            }
        }
    }
}