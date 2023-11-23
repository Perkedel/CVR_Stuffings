using UnityEngine;
using System.Collections;

public class EditCamera : MonoBehaviour {

	string mode = "rote";

	public Transform target;

	public float xRote = 180f;
	public float yRote = 50f;
	public float distance = 5f;

	float xSpeed = 10.0f;
	float ySpeed = 6.0f;
	float moveSpeed = 0.5f;

	private float movX;
	private float movY;
	private float wheel;

	float yMinLimit = -90.0f;
	float yMaxLimit = 90.0f;

	public bool isMouseLocked = false;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void LateUpdate () {
		movX = Input.GetAxis("Mouse X");
		movY = Input.GetAxis("Mouse Y");
		wheel = Input.GetAxis("Mouse ScrollWheel");

		if(!isMouseLocked && Input.GetMouseButton(0)){

			switch(mode){

			case "rote": CameraRotate(movX, movY); break;
			case "move": TargetMove(movX, movY); break;
			case "zoom": CameraZoom(movX, movY); break;

			}
		}

		if(Input.GetMouseButton(1)) CameraZoom(movX, movY);

		if(Input.GetMouseButton(2)){
			TargetMove(movX, movY);
		}

		var rotation = Quaternion.Euler(yRote, xRote, 0);
		var position = rotation * new Vector3(0, 0, -distance) + target.position;
		
		transform.position = position;
		
		this.transform.LookAt(target.position, Vector3.up);

		CameraZoom (wheel*5f, 0);
	
	}

	void CameraRotate(float _x, float _y){
		xRote += _x* xSpeed;
		yRote -= _y* ySpeed;
		yRote = ClampAngle(yRote, yMinLimit, yMaxLimit);

	}

	void TargetMove(float _x, float _y){

		Vector3 camMove = new Vector3(0, -_y * 0.5f, 0);
		//camMove = camera.cameraToWorldMatrix.MultiplyVector(camMove);
		target.Translate(camMove);
	}

	void CameraZoom(float _x, float _y){
		distance += -_x * moveSpeed;
		distance += -_y * moveSpeed;
		distance = Mathf.Clamp(distance, 1.5f, 10);
	}

	public void ModeRote(){
		mode = "rote";
	}

	public void ModeMove(){
		mode = "move";
	}

	public void ModeZoom(){
		mode = "zoom";
	}

	public void MouseLock(bool _flag){
		if(!_flag && Input.GetMouseButton(0))return;
		isMouseLocked = _flag;
	}

	static float ClampAngle(float angle, float min, float max){
		if(angle>360f) angle -= 360f;
		if(angle <-360f) angle += 360f;
		return Mathf.Clamp(angle, min, max);
	}

}
