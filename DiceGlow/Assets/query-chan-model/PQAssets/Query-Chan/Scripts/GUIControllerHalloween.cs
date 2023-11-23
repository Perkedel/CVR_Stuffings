using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GUIControllerHalloween : GUIController {


	protected override void ChangeAnimation (int animNumber)
	{
		queryChan.GetComponent<QueryMechanimController>().ChangeAnimation((QueryMechanimController.QueryChanAnimationType)animNumber);
	}

}
