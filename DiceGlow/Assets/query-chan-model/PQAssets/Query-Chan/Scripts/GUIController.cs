using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEditor;
using System.IO;

public class GUIController : MonoBehaviour {

	Vector3 PosDefault;
	[SerializeField]
	GameObject CameraObj;
	private bool cameraUp;
	[SerializeField]
	protected GameObject queryChan;
	private int querySoundNumber;
	private int targetNum;
	List<string> targetSounds = new List<string>();
	
	//===============================

	[SerializeField]
	QueryAnimationController.QueryChanAnimationType defaultAnimType = QueryAnimationController.QueryChanAnimationType.STAND;

	[SerializeField]
	bool showNormal, showFly, showAttack, showHalloween, showChristmas;
	
	[SerializeField]
	string NextSceneName = "";
	
	[SerializeField]
	string NextSceneButtonLabel = "";
	
	class ButtonInfo {
		public string buttonLabel;
		public int id;
		
		public ButtonInfo(string label, object _id) {
			buttonLabel = label;
			id =  (int)_id;
		}
	}
	
	private ButtonInfo[] animButtonInfoNormal = {
		// default animations
		new ButtonInfo("Stand",		QueryMechanimController.QueryChanAnimationType.STAND),
		new ButtonInfo("Idle",		QueryMechanimController.QueryChanAnimationType.IDLE),
		new ButtonInfo("Walk",		QueryMechanimController.QueryChanAnimationType.WALK),
		new ButtonInfo("Run",		QueryMechanimController.QueryChanAnimationType.RUN),
		new ButtonInfo("Jump",		QueryMechanimController.QueryChanAnimationType.JUMP),
		new ButtonInfo("Pose",		QueryMechanimController.QueryChanAnimationType.POSE),
	};
	
	private ButtonInfo[] animButtonInfoFly = {
		// Fly animations
		new ButtonInfo("Fly_Idle",			QueryMechanimController.QueryChanAnimationType.FLY_IDLE),
		new ButtonInfo("Fly_Straight",		QueryMechanimController.QueryChanAnimationType.FLY_STRAIGHT),
		new ButtonInfo("Fly_toRight",		QueryMechanimController.QueryChanAnimationType.FLY_TORIGHT),
		new ButtonInfo("Fly_toLeft",		QueryMechanimController.QueryChanAnimationType.FLY_TOLEFT),
		new ButtonInfo("Fly_Up",			QueryMechanimController.QueryChanAnimationType.FLY_UP),
		new ButtonInfo("Fly_Down",			QueryMechanimController.QueryChanAnimationType.FLY_DOWN),
		new ButtonInfo("Fly_ItemGet",		QueryMechanimController.QueryChanAnimationType.FLY_ITEMGET),
		new ButtonInfo("Fly_ItemGetLoop",	QueryMechanimController.QueryChanAnimationType.FLY_ITEMGET_LOOP),
		new ButtonInfo("Fly_Damage",		QueryMechanimController.QueryChanAnimationType.FLY_DAMAGE),
		new ButtonInfo("Fly_Disapo",		QueryMechanimController.QueryChanAnimationType.FLY_DISAPPOINTMENT),
		new ButtonInfo("Fly_DisapoLoop",	QueryMechanimController.QueryChanAnimationType.FLY_DISAPPOINTMENT_LOOP),
	};
	
	private ButtonInfo[] animButtonInfoAttack = {
		
		// Attack on Query-Chan
		new ButtonInfo("AOQ_Idle",			QueryMechanimController.QueryChanAnimationType.AOQ_Idle),
		new ButtonInfo("AOQ_RestA",			QueryMechanimController.QueryChanAnimationType.AOQ_REST_A),
		new ButtonInfo("AOQ_RestB",			QueryMechanimController.QueryChanAnimationType.AOQ_REST_B),
		new ButtonInfo("AOQ_Walk",			QueryMechanimController.QueryChanAnimationType.AOQ_WALK),
		new ButtonInfo("AOQ_Hit",			QueryMechanimController.QueryChanAnimationType.AOQ_HIT),
		new ButtonInfo("AOQ_Glad",			QueryMechanimController.QueryChanAnimationType.AOQ_GLAD),
		new ButtonInfo("AOQ_Warp",			QueryMechanimController.QueryChanAnimationType.AOQ_WARP),
	};
	
	private ButtonInfo[] animButtonInfoHalloween = {
		// Halloween animations
		new ButtonInfo("HW_Stand",			QueryMechanimController.QueryChanAnimationType.HW_Stand),
		new ButtonInfo("HW_Idle",			QueryMechanimController.QueryChanAnimationType.HW_Idle),
		new ButtonInfo("HW_Mahou",			QueryMechanimController.QueryChanAnimationType.HW_Mahou),
		new ButtonInfo("HW_TrickOrTreat",	QueryMechanimController.QueryChanAnimationType.HW_TrickOrTreat),
		new ButtonInfo("HW_WaitLong",		QueryMechanimController.QueryChanAnimationType.HW_WaitLong),
		
	};

	private ButtonInfo[] animButtonInfoChristmas = {
		// Christmas animations
		new ButtonInfo("CH_Stand",			QueryMechanimController.QueryChanAnimationType.CH_Stand),
		new ButtonInfo("CH_Idle",			QueryMechanimController.QueryChanAnimationType.CH_Idle),
		new ButtonInfo("CH_Dance",			QueryMechanimController.QueryChanAnimationType.CH_Dance),
		new ButtonInfo("CH_Bang",	QueryMechanimController.QueryChanAnimationType.CH_Bang),
		new ButtonInfo("CH_Deliver",		QueryMechanimController.QueryChanAnimationType.CH_Deliver),
		
	};
	
	// ------------------------------------
	
	private ButtonInfo[] emotionButtonInfo = {
		new ButtonInfo("Normal",		QueryEmotionalController.QueryChanEmotionalType.NORMAL_EYEOPEN_MOUTHCLOSE),
		new ButtonInfo("Mabataki",		QueryEmotionalController.QueryChanEmotionalType.NORMAL_EYECLOSE_MOUTHCLOSE),
		new ButtonInfo("Anger",			QueryEmotionalController.QueryChanEmotionalType.ANGER_EYEOPEN_MOUTHCLOSE),
		new ButtonInfo("Sad",			QueryEmotionalController.QueryChanEmotionalType.SAD_EYEOPEN_MOUTHCLOSE),
		new ButtonInfo("Fun",			QueryEmotionalController.QueryChanEmotionalType.FUN_EYEOPEN_MOUTHCLOSE),
		new ButtonInfo("Surprised",		QueryEmotionalController.QueryChanEmotionalType.SURPRISED_EYEOPEN_MOUTHCLOSE),
		new ButtonInfo("Cold",			QueryEmotionalController.QueryChanEmotionalType.COLD),
		new ButtonInfo("Guruguru",		QueryEmotionalController.QueryChanEmotionalType.Guruguru),
	};
	
	//==============================
	
	
	
	void Start() {
		
		PosDefault = CameraObj.transform.localPosition;
		cameraUp = false;
		querySoundNumber = 0;
		
		foreach (AudioClip targetAudio in queryChan.GetComponent<QuerySoundController>().soundData)
		{
			targetSounds.Add(targetAudio.name);
		}
		targetNum = targetSounds.Count - 1;
		
		ChangeAnimation((int)defaultAnimType);
		
	}
	
	void OnGUI(){
		
		//AnimationChange ------------------------------------------------
		float animButtonHeight = Screen.height/ (animButtonInfoNormal.Length + animButtonInfoFly.Length + 1 ) - 3;
		
		
		GUILayout.BeginHorizontal(GUILayout.Width(Screen.width/4));
			
			GUILayout.BeginVertical();
			
				if (showNormal) 	{ ShowAnimationButtons(animButtonInfoNormal, 	animButtonHeight); }
				if (showFly)		{ ShowAnimationButtons(animButtonInfoFly, 		animButtonHeight); }
				if (showAttack)		{ ShowAnimationButtons(animButtonInfoAttack, 	animButtonHeight); }
				if (showHalloween)	{ ShowAnimationButtons(animButtonInfoHalloween, animButtonHeight); }
				if (showChristmas)	{ ShowAnimationButtons(animButtonInfoChristmas, animButtonHeight); }
			
			GUILayout.EndVertical();
			
		GUILayout.EndHorizontal();
		
		
		//FaceChange ------------------------------------------------
		float emotionButtonHeight =  (Screen.height-200) / (emotionButtonInfo.Length+1) - 3;
		
		GUILayout.BeginArea(new Rect(Screen.width- Screen.width/4, 0, Screen.width/4, Screen.height-200));
			
			GUILayout.BeginVertical();
				
				foreach (var tmpInfo in emotionButtonInfo) {
					if (GUILayout.Button(tmpInfo.buttonLabel, GUILayout.Height(emotionButtonHeight))) {
						ChangeFace((QueryEmotionalController.QueryChanEmotionalType)tmpInfo.id);
					}
				}
			
			GUILayout.EndVertical();
		
		GUILayout.EndArea();
		
		
		//CameraChange --------------------------------------------
		
		if (GUI.Button (new Rect (Screen.width / 2 -75, 0, 150, 80), "Camera"))
		{
			if (cameraUp == true)
			{
				CameraObj.GetComponent<Camera>().fieldOfView = 60;
				CameraObj.transform.localPosition = new Vector3(PosDefault.x, PosDefault.y, PosDefault.z);
				cameraUp = false;
			}
			else
			{
				CameraObj.GetComponent<Camera>().fieldOfView = 25;
				CameraObj.transform.localPosition = new Vector3(PosDefault.x, PosDefault.y + 0.5f, PosDefault.z);
				cameraUp = true;
			}
		}
		
		
		//Sound ---------------------------------------------------------
		
		if(GUI.Button(new Rect(Screen.width / 2 - 150, Screen.height - 100, 50 ,100), "<---"))
		{
			querySoundNumber--;
			if (querySoundNumber < 0)
			{
				querySoundNumber = targetNum;
			}
		}
		if(GUI.Button(new Rect(Screen.width / 2 + 100, Screen.height - 100, 50 ,100), "--->"))
		{
			querySoundNumber++;
			if (querySoundNumber > targetNum)
			{
				querySoundNumber = 0;
			}
			
		}
		if(GUI.Button(new Rect(Screen.width / 2 - 100, Screen.height - 70, 200 ,70), "Play"))
		{
			queryChan.GetComponent<QuerySoundController>().PlaySoundByNumber(querySoundNumber);
		}
		
		GUI.Label (new Rect(Screen.width / 2 - 100, Screen.height - 100, 200, 30), (querySoundNumber+1) + " / " + (targetNum+1) + "  :  " + targetSounds[querySoundNumber]);
		
		
		//SceneChange --------------------------------------------
		
		if (GUI.Button (new Rect (Screen.width -100, Screen.height-100, 100,100), NextSceneButtonLabel))
		{

            //Application.LoadLevel( NextSceneName );
            SceneManager.LoadScene(NextSceneName);

		}
		
	}
	
	
	void ShowAnimationButtons(ButtonInfo[] infos, float buttonHeight)
	{
		foreach (var tmpInfo in infos) {
			if ( GUILayout.Button(tmpInfo.buttonLabel, GUILayout.Height(buttonHeight)) ){
				ChangeAnimation(tmpInfo.id);
			}
		}
	}
	
	
	void ChangeFace (QueryEmotionalController.QueryChanEmotionalType faceNumber) {
		
		queryChan.GetComponent<QueryEmotionalController>().ChangeEmotion(faceNumber);
		
	}
	
	
	protected virtual void ChangeAnimation (int animNumber) {
		
		queryChan.GetComponent<QueryAnimationController>().ChangeAnimation((QueryAnimationController.QueryChanAnimationType)animNumber);
		
	}


 

}
