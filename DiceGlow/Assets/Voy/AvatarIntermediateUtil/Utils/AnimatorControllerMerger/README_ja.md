# AnimatorControllerMerger

## 特徴
- 複数の AnimatorController を1つの AnimatorController にマージできます。
- どの AnimatorController をどこにマージするかの設定を保存できます。
  - これにより、何度でも同じ設定でマージを実行できます。
- 設定したすべてのマージを一度に実行することができます。マージは設定ファイルの名前順に実行されます。
  - これにより、複数のマージ設定を組み合わせて複雑な AnimationController を生成できます。



## インストール

### Unity Package Manager でのインストール

Unity Package Manager で以下の URL を追加します。`https://github.com/sakano/AnimatorControllerMerger.git?path=Assets/Biscrat/AnimatorControllerMerger`

### UnityPackage でインストール

[リリース](https://github.com/sakano/AnimatorControllerMerger/releases)ページから最新版をダウンロードできます。



## イントロダクション

### 簡単なマージを実行する

まずは AnimatorController をマージするための設定ファイルを作成します。

1. Project ウィンドウを右クリックし、`Create > Biscrat > New Animator Controller Merge Setting` を選択します。
2. 作成した設定ファイルを選択します。
3. インスペクタで設定します。`Source Animator Controllers` が `Destination Animator Controller` にマージされます。`Destination Animator Controller` に設定された AnimationController の現在の状態はクリアされるので注意してください。

`Merge`ボタンをクリックするとマージが実行されます。

### すべてのマージを実行する

メニューの `Tools > Biscrat > Run All Merge Settings` をクリックすると、すべての設定ファイルを実行できます。

設定ファイルはその名前の順番で実行されます。例えば、"00_FirstMerge" は "10_NextMerge" の前に実行されます。つまり、"00_FirstMerge"で生成した AnimatorController を"10_NextMerge"でさらにマージできます。
