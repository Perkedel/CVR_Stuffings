using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class QueryMechanimController : MonoBehaviour {

	[SerializeField]
	GameObject queryBodyParts;
	[SerializeField]
	GameObject[] queryHandParts;
	
	public enum QueryChanAnimationType
	{
		// Normal motion
		STAND = 1,
		IDLE = 2,
		WALK = 3,
		RUN = 4,
		JUMP = 5,
		POSE = 6,

		// Fly motion
		FLY_IDLE = 7,
		FLY_STRAIGHT = 8,
		FLY_TORIGHT = 9,
		FLY_TOLEFT = 10,
		FLY_UP = 11,
		FLY_DOWN = 12,
		FLY_ITEMGET = 13,
		FLY_ITEMGET_LOOP = 14,
		FLY_DAMAGE = 15,
		FLY_DISAPPOINTMENT = 16,
		FLY_DISAPPOINTMENT_LOOP = 17,

		// Attack on Query-Chan motion
		AOQ_Idle = 18,
		AOQ_REST_A = 19,
		AOQ_REST_B = 20,
		AOQ_WALK = 21,
		AOQ_HIT = 22,
		AOQ_GLAD = 23,
		AOQ_WARP = 24,

		// Halloween motion
		HW_Stand		= 25,
		HW_Idle			= 26,
		HW_Mahou		= 27,
		HW_TrickOrTreat = 28,
		HW_WaitLong 	= 29,

		// Christmas motion
		CH_Stand		= 30,
		CH_Idle			= 31,
		CH_Dance		= 32,
		CH_Bang		 = 33,
		CH_Deliver 	= 34

	}

	public enum QueryChanHandType
	{

		NORMAL = 0,
		STONE = 1,
		PAPER = 2

	}

	void Update()
	{
		queryBodyParts.transform.localPosition = Vector3.zero;
		queryBodyParts.transform.localRotation = Quaternion.identity;

	}


	public void ChangeAnimation (QueryChanAnimationType animNumber, bool isChangeMechanimState=true)
	{

		var emoControl = this.GetComponent<QueryEmotionalController>();

		switch (animNumber)
		{
		case QueryChanAnimationType.FLY_STRAIGHT:
		case QueryChanAnimationType.FLY_TORIGHT:
		case QueryChanAnimationType.FLY_TOLEFT:
		case QueryChanAnimationType.FLY_UP:
			changeHandPart (QueryChanHandType.PAPER);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.NORMAL_EYEOPEN_MOUTHCLOSE);
			break;

		case QueryChanAnimationType.FLY_ITEMGET:
		case QueryChanAnimationType.FLY_ITEMGET_LOOP:
			changeHandPart (QueryChanHandType.STONE);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.FUN_EYECLOSE_MOUTHOPEN);
			break;

		case QueryChanAnimationType.FLY_DAMAGE:
			changeHandPart (QueryChanHandType.NORMAL);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.SURPRISED_EYEOPEN_MOUTHOPEN_MID);
			break;

		case QueryChanAnimationType.FLY_DISAPPOINTMENT:
		case QueryChanAnimationType.FLY_DISAPPOINTMENT_LOOP:
			changeHandPart (QueryChanHandType.STONE);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.SAD_EYECLOSE_MOUTHOPEN);
			break;

		// attack 

		case QueryChanAnimationType.AOQ_Idle:
		case QueryChanAnimationType.AOQ_WALK:
		case QueryChanAnimationType.AOQ_REST_A:
		case QueryChanAnimationType.AOQ_REST_B:
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.COLD);
			break;

		case QueryChanAnimationType.AOQ_HIT:
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.Guruguru);
			break;

		// Haloween

		case QueryChanAnimationType.HW_TrickOrTreat:
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.SURPRISED_EYEOPEN_MOUTHOPEN);
			break;

		// Christmas

		case QueryChanAnimationType.CH_Idle:
			changeHandPart (QueryChanHandType.NORMAL);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.FUN_EYEOPEN_MOUTHCLOSE);
			break;

		case QueryChanAnimationType.CH_Dance:
			changeHandPart (QueryChanHandType.NORMAL);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.FUN_EYEOPEN_MOUTHOPEN);
			break;

		case QueryChanAnimationType.CH_Bang:
			changeHandPart (QueryChanHandType.STONE);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.ANGER_EYEOPEN_MOUTHOPEN);
			break;

		case QueryChanAnimationType.CH_Deliver:
			changeHandPart (QueryChanHandType.NORMAL);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.FUN_EYECLOSE_MOUTHCLOSE);
			break;

		default:
			changeHandPart (QueryChanHandType.NORMAL);
			emoControl.ChangeEmotion(QueryEmotionalController.QueryChanEmotionalType.NORMAL_EYEOPEN_MOUTHCLOSE);
			break;
		}


		if (isChangeMechanimState) {
			queryBodyParts.GetComponent<Animator>().SetInteger("AnimIndex", (int)animNumber);
		}

	}


	public void changeHandPart (QueryChanHandType handNumber) {

		foreach (GameObject targetHandPart in queryHandParts)
		{
			targetHandPart.SetActive(false);
		}
		queryHandParts[(int)handNumber].SetActive(true);

	}

}
