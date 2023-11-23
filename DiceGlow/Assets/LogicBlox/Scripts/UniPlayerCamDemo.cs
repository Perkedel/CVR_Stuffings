using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;

// Ver 1.3 - Demo camera operator
// Developed by Mike Hogan (2018) - Granby Games - mhogan@remhouse.com
// Free for personal use, requires permission to resell.


public class UniPlayerCamDemo : MonoBehaviour{
       
     
    Vector2 _mouseAbsolute;
    Vector2 _smoothMouse;

    public Vector2 clampInDegrees = new Vector2(360, 360);

    public Vector2 sensitivity = new Vector2(1, 1);
    public Vector2 smoothing = new Vector2(3, 3);
    Vector2 targetDirection = new Vector2();
 

    private KeyCode cam_Up = KeyCode.PageUp;
    private KeyCode cam_Dn = KeyCode.PageDown;
    private KeyCode cam_Left = KeyCode.LeftArrow;
    private KeyCode cam_Right = KeyCode.RightArrow;
    private KeyCode cam_Fwd = KeyCode.UpArrow;
    private KeyCode cam_Back = KeyCode.DownArrow;
    private KeyCode cam_FreeMouse = KeyCode.LeftControl;

    private KeyCode obj_Left = KeyCode.A;
    private KeyCode obj_Right = KeyCode.D;
    private KeyCode obj_Fwd = KeyCode.W;
    private KeyCode obj_Back = KeyCode.S;


    float zoomSpeed = 2;
    float orthographicSizeMin=2;
    float orthographicSizeMax=1000;
    float fovMin=.05f;
    float fovMax = 120;
    bool freeMouse;

    float orbitSensitivity = 1;
    float targetDirectionOrbit;
    Vector3 offset;
   
   Camera playerCamera;
       
    float camFlySpeed = .2f;
    float camHeightY = 0, camDistanceZ = 0,camStrafeX=100;
   
    float _camDistanceZ, _camHeightY=10, _camStrafeX=40;

    float fps_Height=1.5f, fps_Distance=.5f, fps_Offset = .5f;
    float _fps_Height=1.5f, _fps_Distance=.2f, _fps_Offset = .5f;
   
    void Start()
    {
        playerCamera = GetComponent<Camera>();

        _camDistanceZ = playerCamera.transform.position.z;
        _camHeightY = playerCamera.transform.position.y;
        _camStrafeX = playerCamera.transform.position.x;
        _fps_Distance = fps_Distance;
        _fps_Height = fps_Height;
        _fps_Offset = fps_Offset;

        playerCamera = GetComponentInChildren<Camera>();
        playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);

    }



    void Update()
    {
        mouseAim();

        if (Input.GetKey(cam_FreeMouse))
        {
      
        }

        if (Input.GetKey(cam_Up))
        {
            _camHeightY = _camHeightY + camFlySpeed;
             playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }


        if (Input.GetKey(cam_Dn))
        {
            _camHeightY = _camHeightY - camFlySpeed;
             playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }

    
        if (Input.GetKey(cam_Fwd) || Input.GetKey(obj_Fwd))
        {
            _camDistanceZ = _camDistanceZ + camFlySpeed;
            playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }


        if (Input.GetKey(cam_Back) || Input.GetKey(obj_Back))
        {
            _camDistanceZ = _camDistanceZ - camFlySpeed;
             playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }

     

        if (Input.GetKey(cam_Left) || Input.GetKey(obj_Left))
        {
            _camStrafeX = _camStrafeX - camFlySpeed;
            playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }


        if (Input.GetKey(cam_Right) || Input.GetKey(obj_Right))
        {
            _camStrafeX = _camStrafeX + camFlySpeed;
             playerCamera.transform.localPosition = new Vector3(_camStrafeX, _camHeightY, _camDistanceZ);
        }

       

    }

    void FixedUpdate()
    {
        

    }


    public int mouseAim()
    {

        if (freeMouse == true)
        {

            var targetOrientation = Quaternion.Euler(targetDirection);
            var mouseDelta = new Vector2(Input.GetAxisRaw("Mouse X"), Input.GetAxisRaw("Mouse Y"));
            mouseDelta = Vector2.Scale(mouseDelta, new Vector2(sensitivity.x * smoothing.x, sensitivity.y * smoothing.y));

            _smoothMouse.x = Mathf.Lerp(_smoothMouse.x, mouseDelta.x, 1f / smoothing.x);
            _smoothMouse.y = Mathf.Lerp(_smoothMouse.y, mouseDelta.y, 1f / smoothing.y);

            _mouseAbsolute += _smoothMouse;

            if (clampInDegrees.x < 360)
                _mouseAbsolute.x = Mathf.Clamp(_mouseAbsolute.x, -clampInDegrees.x * 0.5f, clampInDegrees.x * 0.5f);

            if (clampInDegrees.y < 360)
                _mouseAbsolute.y = Mathf.Clamp(_mouseAbsolute.y, -clampInDegrees.y * 0.5f, clampInDegrees.y * 0.5f);


            transform.localRotation = Quaternion.AngleAxis(0, targetOrientation * Vector3.right) * targetOrientation;
            var yRotation = Quaternion.AngleAxis(_mouseAbsolute.x, transform.InverseTransformDirection(Vector3.up));
            transform.localRotation *= yRotation;


            if (playerCamera.orthographic)
            {
                if (Input.GetAxis("Mouse ScrollWheel") < 0)
                    playerCamera.orthographicSize += zoomSpeed;
                if (Input.GetAxis("Mouse ScrollWheel") > 0)
                    playerCamera.orthographicSize -= zoomSpeed;

                playerCamera.orthographicSize = Mathf.Clamp(playerCamera.orthographicSize, orthographicSizeMin, orthographicSizeMax);
            }
            else
            {
                if (Input.GetAxis("Mouse ScrollWheel") < 0)
                       playerCamera.fieldOfView += zoomSpeed;
           
                if (Input.GetAxis("Mouse ScrollWheel") > 0)
                        playerCamera.fieldOfView -= zoomSpeed;
 
                playerCamera.fieldOfView = Mathf.Clamp(playerCamera.fieldOfView, fovMin, fovMax);
            }


        }
      
        return (int)playerCamera.fieldOfView;

    }


    public void endDemo()
    {
        Application.Quit();
    }


}

