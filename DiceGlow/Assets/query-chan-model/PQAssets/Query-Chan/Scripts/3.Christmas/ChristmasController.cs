using UnityEngine;
using System.Collections;
using System;

public class ChristmasController : MonoBehaviour {

	[SerializeField]
	protected GameObject queryChan;

	[SerializeField]
	protected GameObject santaChan;
	private float rotationSpeed = 15f;

	[SerializeField]
	protected GameObject house;
	[SerializeField]
	protected GameObject floor;

	private bool isCalendar;
	Vector3 PosDefault;
	Vector3 RotDefault;
	float FovDefault;
	[SerializeField]
	GameObject CameraObj;

	[SerializeField]
	GameObject[] adventDoorItems;
	[SerializeField]
	GameObject[] adventItems;

	[SerializeField]
	GameObject lightDirectional;
	[SerializeField]
	GameObject lightSpot;
	 

	// Use this for initialization
	void Start () {
		queryChan.GetComponent<QueryMechanimController>().ChangeAnimation(QueryMechanimController.QueryChanAnimationType.CH_Dance);
		PosDefault = CameraObj.transform.localPosition;
		RotDefault = CameraObj.transform.localEulerAngles;
		FovDefault = CameraObj.GetComponent<Camera>().fieldOfView;
		isCalendar = false;
	}
	
	// Update is called once per frame
	void Update () {
		updateRotation();
	}

	void OnGUI () {

		if (GUI.Button (new Rect (20, 20, 200, 70), "Bang !!!"))
		{
			if (isCalendar == true)
			{
				changeCalendarMode(false);
			}
			else
			{
				changeCalendarMode(true);
			}
		}

	}


	//=======================================================
	
	void updateRotation()
	{

		// update rotation
		var tmpRot = santaChan.transform.eulerAngles;
		tmpRot.y -= rotationSpeed * Time.deltaTime;
		santaChan.transform.eulerAngles = tmpRot;

	}

	//=======================================================

	void changeCalendarMode (bool calendarOn)
	{

		if (calendarOn == true)
		{
			CameraObj.transform.localPosition = new Vector3 (-420, 20, 530);
			CameraObj.transform.localEulerAngles = new Vector3 (-10, 150, 0);
			CameraObj.GetComponent<Camera>().fieldOfView = 22.8f;
			queryChan.GetComponent<QueryMechanimController>().ChangeAnimation(QueryMechanimController.QueryChanAnimationType.CH_Bang);

			floor.SetActive(false);
			house.GetComponent<Animation>()["TurnHouseAnimation"].time = 0;
			house.GetComponent<Animation>()["TurnHouseAnimation"].speed = 1.0f;
			house.GetComponent<Animation>().Play("TurnHouseAnimation");

			isCalendar = true;
			StopCoroutine("startAdvent");
			StartCoroutine("startAdvent");
			StopCoroutine("ChangeAdventLight");
			StartCoroutine("ChangeAdventLight", true);
		}
		else
		{
			queryChan.GetComponent<QueryMechanimController>().ChangeAnimation(QueryMechanimController.QueryChanAnimationType.CH_Dance);
			CameraObj.transform.localPosition = PosDefault;
			CameraObj.transform.localEulerAngles = RotDefault;
			CameraObj.GetComponent<Camera>().fieldOfView = FovDefault;

			floor.SetActive(true);
			house.GetComponent<Animation>()["TurnHouseAnimation"].time = 0;
			//house.animation["TurnHouseAnimation"].time = house.animation["TurnHouseAnimation"].clip.length;
			house.GetComponent<Animation>()["TurnHouseAnimation"].speed = -1.0f;
			house.GetComponent<Animation>().Play("TurnHouseAnimation");

			disableClendars (1);
			
			isCalendar = false;
			StopCoroutine("ChangeAdventLight");
			StartCoroutine("ChangeAdventLight", false);
		}

	}

	IEnumerator startAdvent ()
	{
		DateTime thisDay = DateTime.Now;
		Debug.Log (thisDay.ToString("dd"));
		int today = int.Parse(thisDay.ToString("dd"));

		if (today < 1)
		{
			today = 1;
		}
		else if (today > 25)
		{
			today = 25;
		}

		disableClendars (today);
		setLightSpotPos (today);
		yield return new WaitForSeconds(2.2f);
		bangCalendar (today);

		yield return new WaitForSeconds(3.0f);
		changeCalendarMode (false);
	}


	void disableClendars (int today)
	{
		foreach (GameObject adventitem in adventDoorItems)
		{
			adventitem.SetActive(true);
		}

		for (int i = 0; i < today - 1; i++)
		{
			adventDoorItems[i].SetActive(false);
		}
	}

	void bangCalendar (int today)
	{
		adventDoorItems[today - 1].SetActive(false);
	}


	void setLightSpotPos (int today)
	{
		lightSpot.transform.localPosition =
			new Vector3(adventItems[today -1].transform.localPosition.x, adventItems[today -1].transform.localPosition.y, lightSpot.transform.localPosition.z);
	}

	IEnumerator ChangeAdventLight (bool modeAdvent)
	{
		if (modeAdvent == true)
		{
			yield return new WaitForSeconds(1.0f);
			lightDirectional.GetComponent<Light>().intensity = 0.1f;
			lightSpot.GetComponent<Light>().range = 1000;
		}
		else
		{
			lightDirectional.GetComponent<Light>().intensity = 0.5f;
			lightSpot.GetComponent<Light>().range = 0;
		}
	}
	

}
