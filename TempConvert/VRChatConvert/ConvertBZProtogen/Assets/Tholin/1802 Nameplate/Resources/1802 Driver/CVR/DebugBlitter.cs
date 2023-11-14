using UnityEngine;

public class DebugBlitter : MonoBehaviour {
	public RenderTexture source,dest;
	public Material mat;

	void Update() {
		Graphics.Blit(source, dest, mat);
	}
}
