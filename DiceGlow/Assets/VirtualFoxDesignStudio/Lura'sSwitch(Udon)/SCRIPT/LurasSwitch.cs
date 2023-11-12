
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

[UdonBehaviourSyncMode(BehaviourSyncMode.Manual)]

public class LurasSwitch : UdonSharpBehaviour
{
    [Header("------------------------------------------------------------------")]
    [Header("■■■　機能切り替えスライダー／Function switching slider　■■■")]
    [Header("------------------------------------------------------------------")]
    [Header("[0]トグルスイッチ／ToggleSwitch")]
    [Header("[1] シーケンススイッチ／Sequence switch")]
    [Header("[2] 位置リセットスイッチ／Position Reset switch (Global)")]

    [Space(20)]

    [Range(0, 2)] public int switchID;

    [Space(10)]

    [SerializeField] private bool isGlobal = false;

    [Space(10)]

    [Header("------------------------------------------------------------------")]

    [Header("ターゲットオブジェクトのsizeに数を入れて切り替えたいオブジェクトをドラッグ＆ドロップ")]
    [Header("Enter a number in size and drag and drop the object you want to switch")]
    [Header("TargetObjectには空きが出ないようにする必要があります")]
    [Header("TargetObject should not be left empty")]
   

    [Space(10)]

    [SerializeField] private GameObject[] targetObject;

    private Vector3[] defaultPosition;
    private Quaternion[] defaultRotation;
    private Rigidbody[] targetRigidbody;
    private int localActiveObjectIndex = 0;
    [UdonSynced] int globalActiveObjectIndex = 0;
    [UdonSynced] bool[] isEnabled;
    

    void Start()
    {
        isEnabled = new bool[targetObject.Length];  //配列を初期化

        switch (switchID)
        {
            case 0:
                if (isGlobal)
                {
                    

                    for (int x = 0; x < targetObject.Length; x = x + 1)
                    {
                        if (targetObject[x] != null)     //配列内のNullチェック
                        {
                            isEnabled[x] = targetObject[x].activeSelf;  //現在の状態を配列の同期変数に代入
                        }
                    }
                }
                break;

            case 1:
                if (isGlobal)
                {
                    SwitchActiveObjectGlobal();
                }
                break;

            case 2:

                defaultPosition = new Vector3[targetObject.Length];
                defaultRotation = new Quaternion[targetObject.Length];
                targetRigidbody = new Rigidbody[targetObject.Length];

                for (int i = 0; i < targetObject.Length; i++)
                {
                    if (targetObject[i] != null)
                    {
                        defaultPosition[i] = targetObject[i].transform.position;
                        defaultRotation[i] = targetObject[i].transform.rotation;
                        targetRigidbody[i] = targetObject[i].GetComponent<Rigidbody>();
                    }
                }
                break;
        }
    }

    public override void Interact()
    {
        switch (switchID)
        {
            case 0:
                //  SwitchType -ToggleObject-

                if (!isGlobal)
                {
                    //Local
                    ToggleObjectLocal();    //ObjectIndexのオンオフを反転させる
                }
                if (isGlobal)
                {
                    //Global

                    if (!Networking.IsOwner(gameObject))
                    {
                        Networking.SetOwner(Networking.LocalPlayer, gameObject);
                    }
                    for (int x = 0; x < targetObject.Length; x = x + 1)
                    {
                        if (targetObject[x] != null)     //配列内のNullチェック
                        {
                            isEnabled[x] = !isEnabled[x];       //同期変数のBoolを反転
                        }
                    }

                    SetObjectFromGlobal();   //オブジェクトのアクティブを切り替え
                    RequestSerialization(); //同期をリクエスト
                }
                break;

            case 1:
                //  SwitchType -SwitchSequenceObjectLocal-

                if (!isGlobal)
                {
                    //Local
                    NextObjectIndexLocal();     //次のObjectIndexに切り替える(Local)
                }
                else
                {
                    //Global
                    if (!Networking.IsOwner(gameObject))
                    {
                        Networking.SetOwner(Networking.LocalPlayer, gameObject);
                    }
                    NextObjectIndexGlobal();    //次のObjectIndexに切り替える(Global)
                }
                break;

            case 2:
                //SwitchType -Position Reset Switch-
                for (int i = 0; i < targetObject.Length; i++)
                {
                    Networking.SetOwner(Networking.LocalPlayer, targetObject[i]);
                }

                for (int i = 0; i < targetObject.Length; i++)
                {
                    if (targetObject[i] != null)
                    {
                        if (defaultPosition[i] != null)
                        {
                            targetObject[i].transform.position = defaultPosition[i];
                            targetObject[i].transform.rotation = defaultRotation[i];
                            targetRigidbody[i].Sleep();
                        }
                    }
                }
                break;
        }
    }

    public override void OnDeserialization()
    {
        if (isGlobal)
        {
            switch (switchID)
            {
                case 0:
                    if (!Networking.IsOwner(gameObject))
                    {
                        SetObjectFromGlobal();      //受信したisEnabledの状態を反映
                    }
                    
                    break;

                case 1:
                    if (!Networking.IsOwner(gameObject))
                    {
                        SwitchActiveObjectGlobal();   //受信したactiveObjectIndexを反映
                    }
                    
                    break;
            }
        }
    }

    public void ToggleObjectLocal()     //オブジェクトのアクティブを切り替え
    {
        for (int x = 0; x < targetObject.Length; x = x + 1)
        {
            if (targetObject[x] != null)     //配列内のNullチェック
            {
                targetObject[x].SetActive(!targetObject[x].activeSelf);     //現在の状態を確認してオブジェクトのアクティブを反転
            }
        }
    }

    public void SetObjectFromGlobal()
    {
        for (int x = 0; x < targetObject.Length; x = x + 1)
        {
            if (targetObject[x] != null)     //配列内のNullチェック
            {
                targetObject[x].SetActive(isEnabled[x]);     //現在の状態を確認してオブジェクトのアクティブを反転
            }
        }
    }

    private void SwitchActiveObjectLocal()    //activeObjectIndexをセットして反映させる
    {
        for (int x = 0; x < targetObject.Length; x = x + 1)
        {
            if (targetObject[x] != null)    //配列内のNullチェック
            {
                targetObject[x].SetActive(x == localActiveObjectIndex);      //番号に対応したオブジェクトをオンにする
            }
        }
    }

    private void SwitchActiveObjectGlobal()    //activeObjectIndexをセットして反映させる
    {
        for (int x = 0; x < targetObject.Length; x = x + 1)
        {
            if (targetObject[x] != null)    //配列内のNullチェック
            {
                targetObject[x].SetActive(x == globalActiveObjectIndex);      //番号に対応したオブジェクトをオンにする
            }
        }
    }

    private void AddActiveObjectIndexLocal()  //activeObjectIndexに１を足す(Local)
    {
        localActiveObjectIndex = localActiveObjectIndex + 1;

        if (localActiveObjectIndex >= targetObject.Length)
        {
            localActiveObjectIndex = 0;
        }
    }

    private void AddActiveObjectIndexGlobal()  //activeObjectIndexに１を足す(Global)
    {
        globalActiveObjectIndex = globalActiveObjectIndex + 1;

        if (globalActiveObjectIndex >= targetObject.Length)
        {
            globalActiveObjectIndex = 0;
        }
    }

    private void NextObjectIndexLocal()   //次のObjectIndexに切り替える(Local)
    {
        AddActiveObjectIndexLocal();     //activeObjectIndexに１を足す
        SwitchActiveObjectLocal();       //activeObjectIndexをセットして反映させる(Local)
    }

    private void NextObjectIndexGlobal()   //次のObjectIndexに切り替える(Global)
    {
        AddActiveObjectIndexGlobal();     //activeObjectIndexに１を足す
        SwitchActiveObjectGlobal();       //activeObjectIndexをセットして反映させる(Global)
        RequestSerialization();
    }
}
