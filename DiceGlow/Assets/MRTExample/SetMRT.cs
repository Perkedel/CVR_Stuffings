using UnityEngine;

public class SetMRT : MonoBehaviour
{
    public Camera LoopCamera;
    public Camera DBCamera;

    public RenderTexture RT0, RT1, RT2, RT0_DB, RT1_DB, RT2_DB;

    void Start()
    {
        LoopCamera.SetTargetBuffers(
            new RenderBuffer[] { RT0.colorBuffer, RT1.colorBuffer, RT2.colorBuffer }, 
            RT0.depthBuffer);
        DBCamera.SetTargetBuffers(
            new RenderBuffer[] { RT0_DB.colorBuffer, RT1_DB.colorBuffer, RT2_DB.colorBuffer }, 
            RT0_DB.depthBuffer);
    }
}