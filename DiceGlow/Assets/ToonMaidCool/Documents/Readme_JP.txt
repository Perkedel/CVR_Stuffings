////////////////////////////////////////////////////////
Toon Maid Cool ver.1.03

販売者及び著作権所有者　Virtet
////////////////////////////////////////////////////////

 ヴィクトリアン調メイドの３Dトゥーンモデル、そのクール系キャラバージョンです。
アセットに3つのアニメーション、2つのフェイシャルアニメーション、
4のブレンドシェイプなどが含まれています。

別アセットの"Toon Maid Asset"とアニメーションを共有できます。

<Version>

-ver.1.00 初版

-ver.1.02
 ・シェーダーファイルを修正しました。

-ver.1.03
 ・頭、髪の毛、体、ヘッドドレスを別々のオブジェクトに分割しました。
 ・スクリプトを最適化しました。
 ・服にノーマルマップを適用しました。
 ・モデルが影を受けるようにしました。
 

========================================================
注意事項
========================================================
<Projest Settings - Quallity Settings>
　アニメーションが自然に動くように、Blend Weightsの値は"4 Bones"にしてください。
"2 Bones"以下に設定すると、モーションによってはポリゴンが貫通する場合があります。


========================================================
Shaders
========================================================
　各シェーダーの違いは以下のようになっております。

MaidSurfaceShader	
	
-RenderType" = "Opaque"
-Render Queue = Geometory = 2000

MaidSurfaceShader_Brow	
	
-RenderType" = "Transparent"
-Render Queue :transparent + 1 = 3001

MaidSurfaceShader_Hair

-RenderType" = "Transparent"
-Render Queue :transparent + 2 = 3002

MaidSurfaceShader_PettiCoat

-RenderType" = "Transparent"
-Render Queue :transparent + 3 = 3003	
	
<parameter>
-Shiness-
　モデルの明るさを設定します。

-LightDiffse-
　法線ベクトルとライトの方向のドット積によって光の減衰率を計算します。

-ViewDiffse-
　法線ベクトルとカメラの方向のドット積によって光の減衰率を計算します。

-EdgeSize-
　輪郭線の太さを調節します。

-EdgeColor-
　輪郭線の色を調節します。
