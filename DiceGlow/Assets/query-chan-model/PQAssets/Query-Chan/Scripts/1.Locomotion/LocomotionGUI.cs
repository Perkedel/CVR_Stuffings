using UnityEngine;
using System.Collections;

public class LocomotionGUI : MonoBehaviour {

	[SerializeField]
	string NextSceneButtonLabel = "to\nStand\nMode";

	[SerializeField]
	string NextSceneName = "01_OperateQuery_Standing";


	void OnGUI()
	{
		showHowToPlayGUI();

		if ( GUI.Button(new Rect(Screen.width-100, Screen.height-100, 100, 100), NextSceneButtonLabel) ) {
			Application.LoadLevel(NextSceneName);
		}
	}

	void showHowToPlayGUI()
	{
		GUI.Box(new Rect(10, 10 ,200 ,100), "Interaction");
		GUI.Label(new Rect(30, 40, 160, 60),
		          "Arrow : Move\n" +
		          "Shift : Run\n" +
		          "Space : Jump");

	}

}
