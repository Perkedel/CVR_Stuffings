using UnityEngine;
using UnityEngine.Rendering;

namespace NAK.AASEmulator.Runtime
{
    public class MirrorClone : MonoBehaviour
    {
        public static MirrorClone Create(Transform sourceTransform)
        {
            GameObject go = new(sourceTransform.name + " (Mirror)");
            MirrorClone MirrorClone = go.AddComponent<MirrorClone>();
            MirrorClone.sourceTransform = sourceTransform;
            return MirrorClone;
        }
        
        public Transform sourceTransform;

        // Transform references
        public Transform root;
        public Transform playSpace;
        //public Transform attachmentSpace;

        // Camera references
        private Camera _ourCamera;
        private Transform _ourCameraTransform;
        
        private bool _isInitialized;
        private RenderTexture _renderTexture;
        private CommandBuffer _commandBuffer;
        private Material _blitMaterial;

        // Positions and rotations
        private Vector3 viewPos;
        private Quaternion viewRot;
        private Vector3 playerPos;
        private Quaternion playerRot;

        private int _currentWidth;
        private int _currentHeight;

        private void Start()
        {
            // Set up the player clone references
            root = transform;
            if (playSpace == null)
            {
                playSpace = new GameObject("PlaySpace").transform;
                playSpace.SetParent(root, false);
            }
            //attachmentSpace = playSpace.GetChild(0);

            // Set up the render texture
            CreateRenderTexture();

            // Set up the camera
            GameObject cameraObj = new("MirrorCloneCamera");
            _ourCameraTransform = cameraObj.transform;
            _ourCameraTransform.SetParent(playSpace);

            _ourCamera = cameraObj.AddComponent<Camera>();
            _ourCamera.clearFlags = CameraClearFlags.SolidColor;
            _ourCamera.backgroundColor = Color.clear;
            _ourCamera.cullingMask = 1 << 8; // Only player local
            _ourCamera.nearClipPlane = 0.01f;
            _ourCamera.enabled = false;
            _ourCamera.targetTexture = _renderTexture;
            
            _blitMaterial = new Material(Shader.Find("Unlit/BlitCutout"));
            _commandBuffer = new CommandBuffer { name = "MirrorCloneCommandBuffer" };
            _commandBuffer.Blit(_renderTexture, BuiltinRenderTextureType.CameraTarget, _blitMaterial);

            // Attach the command buffer to the scene camera
            Camera.onPreCull += MyOnPreCull;
        }

        private void CreateRenderTexture()
        {
            _currentWidth = Screen.width;
            _currentHeight = Screen.height;
            if (_renderTexture != null) RenderTexture.ReleaseTemporary(_renderTexture);
            _renderTexture = RenderTexture.GetTemporary(_currentWidth, _currentHeight, 24, RenderTextureFormat.ARGBHalf,
                RenderTextureReadWrite.Default, QualitySettings.antiAliasing, RenderTextureMemoryless.None, VRTextureUsage.None);
        }

        private void OnDestroy()
        {
            Camera.onPreCull -= MyOnPreCull;
            if (_renderTexture != null) RenderTexture.ReleaseTemporary(_renderTexture);
            if (_blitMaterial != null) DestroyImmediate(_blitMaterial);
            _commandBuffer?.Clear();
            _commandBuffer?.Dispose();
            _commandBuffer = null;
        }

        private void MyOnPreCull(Camera cam)
        {
            if (cam.name != "SceneCamera")
                return;
            
            if (_commandBuffer == null)
                return;
            
            _ourCamera.CopyFrom(cam);
            _ourCamera.clearFlags = CameraClearFlags.SolidColor;
            _ourCamera.backgroundColor = Color.clear;
            _ourCamera.cullingMask = 1 << 8; // Only player local
            _ourCamera.nearClipPlane = 0.01f;
            
            SetupPositions(cam);
            FinalizeMiniMe();

            // Check and update the render texture size if needed
            int cameraWidth = cam.pixelWidth;
            int cameraHeight = cam.pixelHeight;

            if (_currentWidth != cameraWidth || _currentHeight != cameraHeight)
            {
                _currentWidth = cameraWidth;
                _currentHeight = cameraHeight;
                CreateRenderTexture();
                _ourCamera.targetTexture = _renderTexture;
                _commandBuffer.Clear();
                _commandBuffer.Blit(_renderTexture, BuiltinRenderTextureType.CameraTarget, _blitMaterial);
            }
            
            // the shittiest hack to trick most shaders into thinking we are a mirror lol
            // https://github.com/cnlohr/shadertrixx?tab=readme-ov-file#are-you-in-a-mirror
            Matrix4x4 projectionMatrix = _ourCamera.projectionMatrix;
            projectionMatrix[2, 0] += 1e-5f;
            projectionMatrix[2, 1] += 1e-5f;
            _ourCamera.projectionMatrix = projectionMatrix;
            
            // Render the custom camera to the render texture
            _ourCamera.Render();
            
            if (!_isInitialized)
            {
                _isInitialized = true;
                
                // clear all existing command buffers
                cam.RemoveAllCommandBuffers();
                cam.AddCommandBuffer(CameraEvent.AfterImageEffects, _commandBuffer);
            }
        }

        private void SetupPositions(Component rawComponent)
        {
            // Get player camera position and rotation
            Transform transform1 = rawComponent.transform;
            viewPos = transform1.position;
            viewRot = transform1.rotation;

            // Get player position and rotation
            playerPos = sourceTransform.position;
            playerRot = sourceTransform.rotation;

            // Set our play space position and rotation to the players (makes copying easier)
            playSpace.SetPositionAndRotation(playerPos, playerRot);

            // Same with attachment space
            //attachmentSpace.SetPositionAndRotation(playerPos, playerRot);

            // Copy camera position and rotation (is child of play space, so it will be relative to the player)
            _ourCameraTransform.SetPositionAndRotation(viewPos, viewRot);
        }

        private void FinalizeMiniMe()
        {
            // Adjust camera scale for VR to appear correctly
            // Vector3 camScale = _ourCameraTransform.localScale;
            // camScale.x = // play space scale here
            // _ourCameraTransform.localScale = camScale;

            // Now we can get our relative position and rotation to inverse our play space
            Vector3 relativePos = playerPos - root.position;
            Quaternion inverseOurRot = Quaternion.Inverse(root.rotation);
            Quaternion relativeRot = inverseOurRot * playerRot;

            // Then set our play space position and rotation with that offset, but relative to the player
            playSpace.SetPositionAndRotation(playerPos + (relativeRot * relativePos), playerRot * relativeRot);

            // Set attachment space to root position and rotation
            //attachmentSpace.SetPositionAndRotation(root.position, root.rotation);
        }
    }
}