using System;
using System.Linq;
using System.Net.Sockets;
using System.Threading;

namespace Furality.SDK.Editor.External.Boop
{
    // Probably violates some http spec requirements, but it doesn't need to that secure given that its only use is for 
    // handling the callback from the browser
    public class HttpCallbackManager
    {
        private class HttpRequest
        {
            public string Method;
            public string Path;
            public string Version;
            
            public HttpRequest(string request)
            {
                var lines = request.Split('\n');
                var firstLine = lines[0].Split(' ');
                
                Method = firstLine[0];
                Path = firstLine[1];
                Version = firstLine[2];
            }
        }
        
        private readonly TcpListener _socket;
        private readonly string _callbackPath;
        private readonly Action<string> _callback;
        
        public HttpCallbackManager(Action<string> callback, int port = 8080, string callbackPath = "/callback")
        {
            _socket = new TcpListener(System.Net.IPAddress.Parse("127.0.0.1"), port);
            var listenerThread = new Thread(Listen);
            _callbackPath = callbackPath;
            _callback = callback;
            listenerThread.Start();
        }

        private static string BuildFriendlyResponse(string message, string status = "200 OK")
        {
            var body = "<h1>"+message+"</h1>";
            
            var response = $"HTTP/1.1 {status}\r\n";
            response += "Connection: close\r\n";
            response += $"Content-Length: {body.Length}\r\n";
            response += "Content-Type: text/html\r\n";
            response += "X-Powered-By: Small little kobolds clinging onto Kakious' tail\r\n";
            response += "\r\n";
            response += body;
            
            return response;
        }

        private static void Respond(ref NetworkStream stream, string messageContent)
        {
            var responseBytes = System.Text.Encoding.ASCII.GetBytes(messageContent);
            stream.Write(responseBytes, 0, responseBytes.Length);
        }
        
        private void Listen()
        {
            // Attempt to start a socket on localhost:port, if we cant then just throw
            try
            {
                _socket.Start();
            }
            catch (Exception e)
            {
                throw new Exception("Failed to start http callback server. ", e);
            }
            
            while (true)
            {
                var client = _socket.AcceptTcpClient();
                var stream = client.GetStream();
                var buffer = new byte[client.ReceiveBufferSize];
                var bytesRead = stream.Read(buffer, 0, client.ReceiveBufferSize);
                var request = System.Text.Encoding.ASCII.GetString(buffer, 0, bytesRead);
                
                // Now we parse the request to extract the path
                var req = new HttpRequest(request);
                
                // If our path starts with /callback then this is the request we're looking for
                if (req.Path.StartsWith(_callbackPath))
                {
                    // We need to extract the url parameters from the rest of the path
                    var parameters = req.Path.Substring(_callbackPath.Length + 1)
                        .Split('&')
                        .Select(p => p.Split('='))
                        .ToDictionary(p => p[0], p => p[1]);

                    // Ensure we actually got a code
                    if (parameters.TryGetValue("code", out var parameter))
                    {
                        Respond(
                        // Send a friendly response to the browser
                            ref stream,
                            BuildFriendlyResponse(
                                "Success! You can now close this window."
                            )
                        );

                        // We got a code, so we can stop listening
                        _socket.Stop();

                        // Now we can call the callback with the code
                        _callback?.Invoke(parameter);
                        return;
                    }
                }

                // Return a 404
                Respond(
                    ref stream,
                    BuildFriendlyResponse(
                        "Whatever you're looking for, best of luck finding it!",
                        "404 Not Found"
                    )
                );
            }
        }
    }
}