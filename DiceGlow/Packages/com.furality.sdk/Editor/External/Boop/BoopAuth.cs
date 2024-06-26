using System;
using Furality.SDK.Editor.External.Boop.Types;
using Furality.SDK.Editor.Helpers;
using UnityEngine;
using UnityEngine.Networking;

namespace Furality.SDK.Editor.External.Boop
{
    // AuthManager is our one port of call for authentication, be it initiating a login or logout, or monitoring our login state
    public static class BoopAuth
    {
        private const string ClientID = "3P3Tje3pKEB9bkLTYY7vnJyv";
        private const string TokenEndpoint = "https://boop.fynn.ai/oidc/token";
        private const int Port = 43621;
        private static readonly string AuthURL = $"https://boop.fynn.ai/oidc/auth?response_type=code&client_id={ClientID}&scope=openid+profile+vrchat+discord+discord:modify+roles+connection+connection:unlink+connection:link+patreon&redirect_uri=http://localhost:{Port}/callback";

        public static Action<TokenResponse> OnLoggedIn;
        public static Action OnLoggedOut;
        
        private static HttpCallbackManager CallbackManager { get; set; }
        
        public static bool IsAwaitingCallback => CallbackManager != null;

        public static TokenResponse AttemptCachedLogin()
        {
            if (!PlayerPrefs.HasKey("boop.refresh_token")) return null;
            
            // Attempt to use cached credentials
            /*var expiry = PlayerPrefs.GetInt("boop.expires_at");
            // If we have a refresh token and it hasn't expired, use it
            DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            dateTime = dateTime.AddSeconds( expiry ).ToLocalTime();*/
            
            Debug.Log("Using cached refresh token to log in");
            var refreshToken = PlayerPrefs.GetString("boop.refresh_token");
            return ExchangeToken("refresh_token", refreshToken);
        }

        // Takes a callback to main thread so we can run HandleCodeCallback from it
        public static void Login()
        {
            var cachedLoginResult = AttemptCachedLogin();
            if (cachedLoginResult != null)
            {
                OnLoggedIn(cachedLoginResult);
                return;
            }
            
            Application.OpenURL(AuthURL);
            CallbackManager = new HttpCallbackManager(s => AsyncHelper.EnqueueOnMainThread(() => HandleCodeCallback(s)), Port);
        }

        /// <summary>
        /// Exchanges either an authorization code or refresh token for a valid auth token, and saves to playerprefs
        /// </summary>
        /// <param name="grantType">Either refresh_token or authorization_code</param>
        /// <param name="code">The specified code for the passed in grant type</param>
        /// <returns>A valid authorization token</returns>
        private static TokenResponse ExchangeToken(string grantType, string code)
        {
            TokenResponse response;
            using (var request = new UnityWebRequest(TokenEndpoint, "POST"))
            {
                var body = $"grant_type={grantType}&{(grantType == "refresh_token" ? "refresh_token" : "code")}={code}&client_id={ClientID}&redirect_uri=http://localhost:{Port}/callback";
                request.uploadHandler = new UploadHandlerRaw(System.Text.Encoding.UTF8.GetBytes(body));
                request.downloadHandler = new DownloadHandlerBuffer();
                request.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                var sent = request.SendWebRequest();
                while (!sent.isDone)
                {
                    // Wait for the request to finish
                }
                if (request.isNetworkError || request.isHttpError)
                {
                    return null;
                }
                
                response = JsonUtility.FromJson<TokenResponse>(request.downloadHandler.text);
            }
            
            // Parse the user data from the jwt
            //CurrentUser = ParseUserDataFromJwt(response.id_token);
            // Store the refresh token in playerprefs
            PlayerPrefs.SetString("boop.refresh_token", response.refresh_token);
            var expiryTime = DateTime.Now.AddSeconds(response.expires_in);
            var dto = new DateTimeOffset(expiryTime);
            PlayerPrefs.SetInt("boop.expires_at", (int)dto.ToUnixTimeSeconds());

            return response;
        }

        private static void HandleCodeCallback(string code)
        {
            // Destroy the callback manager to kill the server
            CallbackManager = null;
            
            // POST a web request to the auth server with the code in x-www-form-urlencoded format using unitywebrequest
            var response = ExchangeToken("authorization_code", code);
            if (response != null)
            {
                OnLoggedIn(response);
            }
        }

        private static UserData ParseUserDataFromJwt(string jwt)
        {
            // First, we split the jwt into three parts, the header, the payload, and the signature
            var parts = jwt.Split('.');

            // We only care about the payload, so we decode the second part of the jwt from base64
            try
            {
                var b64 = Base64UrlDecode(parts[1]);
                var payload = System.Text.Encoding.UTF8.GetString(b64);

                // Then we parse the json payload into a UserData object
                return JsonUtility.FromJson<UserData>(payload);
            }
            catch (Exception ex)
            {
                // Handle any exceptions and log or report the error
                Console.WriteLine($"Failed to parse JWT payload: {ex.Message}");
                return null; // or throw an exception, depending on your requirements
            }
        }

        private static byte[] Base64UrlDecode(string input)
        {
            string paddedInput = PadBase64String(input);
            // Replace URL-safe characters with regular base64 characters
            paddedInput = paddedInput.Replace('-', '+').Replace('_', '/');
            return Convert.FromBase64String(paddedInput);
        }

        private static string PadBase64String(string input)
        {
            // Add padding characters if necessary
            switch (input.Length % 4)
            {
                case 2: return input + "==";
                case 3: return input + "=";
                default: return input;
            }
        }
        
        public static void Logout()
        {
            OnLoggedOut();
            PlayerPrefs.DeleteKey("boop.refresh_token");
            PlayerPrefs.DeleteKey("boop.expires_at");
        }
    }
}