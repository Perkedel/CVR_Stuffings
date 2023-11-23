using UnityEngine;
using System.Collections;

public class GhostController : MonoBehaviour {

	[SerializeField]
	GameObject rotationTarget;

	[SerializeField]
	float rotationSpeed = 15f;

	[SerializeField]
	float shakeRange = 0.3f;

	[SerializeField]
	float shakeSpeed = 1.5f;

	[SerializeField]
	Texture[] faceTextures;
	//-----------------------

	GameObject parentGameObject;
	float startLocalPosY;

	float nextFaceChangeTime = 0;

	//-----------------------


	// Use this for initialization
	void Start () {
		parentGameObject = new GameObject("GhostParent");
		parentGameObject.transform.position = rotationTarget.transform.position;

		transform.parent = parentGameObject.transform;
		startLocalPosY = transform.localPosition.y;
	}

	//=======================================================
	
	// Update is called once per frame
	void Update () {

		updateRotation();
	
		updateFace();
	}

	//=======================================================

	void updateRotation()
	{

		// update target pos
		parentGameObject.transform.position = rotationTarget.transform.position;
		
		// update rotation
		var tmpRot = parentGameObject.transform.eulerAngles;
		tmpRot.y += rotationSpeed * Time.deltaTime;
		parentGameObject.transform.eulerAngles = tmpRot;
		
		// update shake
		var tmpPos = transform.localPosition;
		tmpPos.y = startLocalPosY + Mathf.Sin(tmpRot.y * Mathf.Deg2Rad * shakeSpeed) * shakeRange;
		transform.localPosition = tmpPos;
	}

	//=======================================================


	void updateFace()
	{
		if (Time.time >= nextFaceChangeTime) {
			nextFaceChangeTime = Time.time + Random.Range(3, 5);

			ChangeFace(Random.Range(0, faceTextures.Length));
		}
	}

	public void ChangeFace(int index)
	{
		if (index < 0 || index >= faceTextures.Length) {
			return;
		}
		GetComponent<Renderer>().material.SetTexture("_Face_texture", faceTextures[index]);
	}
}
