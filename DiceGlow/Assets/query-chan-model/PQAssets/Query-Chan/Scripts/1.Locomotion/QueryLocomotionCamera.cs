using UnityEngine;
using System.Collections;

public class QueryLocomotionCamera : MonoBehaviour {

	[SerializeField]
	Transform target;

	//-----------------------

	float lerpSpeed = 0.2f;

	//-----------------------

	Vector3 targetOffset;

	//=====================================


	// Use this for initialization
	void Start () {
		targetOffset = transform.position - target.transform.position;

	}
	
	// Update is called once per frame
	void Update () {
		transform.position = Vector3.Lerp(transform.position, target.transform.position + targetOffset, lerpSpeed);
	}
}
