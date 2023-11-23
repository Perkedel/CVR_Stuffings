using UnityEngine;
using System.Collections;

public class CoolMaidEdit : MonoBehaviour {
	
	public EditCamera viewCam;
	
	GameObject obj;
	public GameObject chara;
	string viewerTextPath = "Texts";
	string[] motionList;
	Animator animator;
	AnimatorStateInfo currentAsi;
	AnimatorStateInfo prevAsi;
	AnimatorStateInfo currentAsi_F;
	AnimatorStateInfo prevAsi_F;

	int currentMotion = 0;
	
	TextAsset txt;
	
	void Start () {
		
		viewCam = GameObject.Find("Main Camera").GetComponent<EditCamera>();
		
		txt = Resources.Load(viewerTextPath + "/ToonMaidCool_MotionList") as TextAsset;
		motionList = txt.text.Split(new char[]{'\n'},4);
		
		SetInitModel();
		
		currentAsi = animator.GetCurrentAnimatorStateInfo(0);
		prevAsi = currentAsi;
		currentAsi_F = animator.GetCurrentAnimatorStateInfo(1);
		prevAsi_F = currentAsi_F;
		
	}
	
	void Update () {
		if(animator.GetBool("Next")){
			currentAsi = animator.GetCurrentAnimatorStateInfo(0);
			if(prevAsi.fullPathHash != currentAsi.fullPathHash){
				animator.SetBool("Next", false);
				prevAsi = currentAsi;
				NextMotion(1);
			}
		}
		
		if(animator.GetBool("Back")){
			currentAsi = animator.GetCurrentAnimatorStateInfo(0);
			if(prevAsi.fullPathHash != currentAsi.fullPathHash){
				animator.SetBool("Back", false);
				prevAsi = currentAsi;
				NextMotion(-1);
			}
		}
		
		animator.SetLayerWeight (1, 1);
		
		if(animator.GetBool("Lipsync")){
			currentAsi_F = animator.GetCurrentAnimatorStateInfo(1);
			if(prevAsi_F.fullPathHash != currentAsi_F.fullPathHash){
				animator.SetBool("Lipsync", false);
				prevAsi_F = currentAsi_F;
			}
		}

	}
	
	void SetInitModel() { 
		ModelAppear(chara);
	} 
	
	void OnGUI(){

		GUI.skin.box.alignment = TextAnchor.MiddleLeft;
		
		GUI.Box (new Rect(70,15,200,25), motionList[currentMotion]);
		if(GUI.Button (new Rect(10,20,55,20), "Back")) animator.SetBool("Back",true);
		
		if(GUI.Button (new Rect(275,20,55,20), "Next")) animator.SetBool("Next",true);
		
		if(GUI.Button (new Rect(Screen.width - 100,20,95,20), "Lip Sync")) animator.SetBool("Lipsync",true);
		
		
		GUI.skin.box.alignment = TextAnchor.UpperCenter;
		
		GUI.Box (new Rect(Screen.width - 220,(Screen.height / 2) + 50 ,250,150), "Camera Control");
		GUI.Label (new Rect(Screen.width - 210,(Screen.height / 2) + 80 ,250,25),"Mouse LeftDrag : Camrera Rotate");
		GUI.Label (new Rect(Screen.width - 210,(Screen.height / 2) + 110 ,250,25),"Wheel Scroll : Camrera Zoom");
		GUI.Label (new Rect(Screen.width - 210,(Screen.height / 2) +140 ,250,25),"Mouse WheelDrag : Camrera Move");

	}
	
	void ModelAppear(GameObject _name){
		
		GameObject loaded = _name;
		Destroy(obj);
		
		obj = Instantiate(loaded) as GameObject;
		animator = obj.GetComponent<Animator>();
		animator.runtimeAnimatorController = Resources.Load("AnimatorController/ToonMaid_Cool")
			as RuntimeAnimatorController;
		

	}
	
	void NextMotion(int _motion){

		currentMotion += _motion;
		if(currentMotion >= 3)currentMotion = 0;
		if(currentMotion <= -1)currentMotion = 2;
		
	}
	
}
