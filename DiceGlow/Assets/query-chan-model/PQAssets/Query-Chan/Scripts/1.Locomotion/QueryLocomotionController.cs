using UnityEngine;
using System.Collections;

public class QueryLocomotionController : MonoBehaviour {

	float moveSpeed			= 1.3f;
	float dashSpeed			= 4f;
	float rotationSpeed		= 400f;

	float jumpPower			= 5f;
	float jumpInterval		= 1.3f;
	float gravity			= 0.2f;

	QuerySoundController.QueryChanSoundType[] jumpSounds = {
		QuerySoundController.QueryChanSoundType.ONE_TWO,
		QuerySoundController.QueryChanSoundType.GO_AHEAD,
	};

	//--------------------------

	CharacterController controller;
	Animator animator;
	QuerySoundController querySound;
	QueryMechanimController queryMechanim;

	//--------------------------

	Vector3 moveDirection		= Vector3.zero;
	float nextAllowedJumpTime	= 0;



	//========================================================

	void Start()
	{
		controller = GetComponent<CharacterController>();
		animator = GetComponentInChildren<Animator>();
		querySound = GetComponent<QuerySoundController>();
		queryMechanim = GetComponent<QueryMechanimController>();

		queryMechanim.ChangeAnimation(QueryMechanimController.QueryChanAnimationType.IDLE, false);
	}


	//=========================================================

	void Update()
	{
		updateMove();
	}


	void updateMove()
	{
		float inputX = Input.GetAxis("Horizontal");
		float inputY = Input.GetAxis("Vertical");
		bool dash = Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift);
		bool inputJump = Input.GetButton ("Jump");
		bool jumped = false;

		// movement -----------------------------------
		if (controller.isGrounded) {
			
			moveDirection = new Vector3(0, 0, inputY);
			moveDirection = transform.TransformDirection(moveDirection);

			if (inputY > 0 && dash) {
				moveDirection *= dashSpeed;
			}
			else {
				moveDirection *= moveSpeed;
			}


			if (inputJump && animator.IsInTransition(0) == false && nextAllowedJumpTime <= Time.time) {
				moveDirection.y = jumpPower;
				jumped = true;
				nextAllowedJumpTime = Time.time + jumpInterval;

				PlayJumpSound();
			}


			transform.Rotate(new Vector3(0, inputX * rotationSpeed * Time.deltaTime, 0));
		}
		else {
			moveDirection.y -= gravity;
		}
		controller.Move(moveDirection * Time.deltaTime);


		//animation ---------------------------------------
		
		animator.SetBool("Jump", jumped);
		
		if (controller.isGrounded && jumped == false && animator.IsInTransition(0) == false) {
			animator.SetFloat("Speed", inputY * (dash ? 2 : 1));
		}


	}

	//=====================================================================

	void PlayJumpSound()
	{
		PlaySound( jumpSounds[ Random.Range(0, jumpSounds.Length) ] );
	}

	void PlaySound(QuerySoundController.QueryChanSoundType soundType)
	{
		querySound.PlaySoundByType(soundType);
	}


}

