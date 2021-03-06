# Palletizing-Robot-Control-by-Arduino
大三機械專題,使用碼垛型機器人來達成專題需求

控制原理:
1.	利用機動學算出末端(夾爪部分)的位置
2.	為了能讓馬達轉到我們所要的角度，我們設計一個矩形座標讓夾爪到某個定點後能傳輸兩個角度給兩個馬達。

![image](https://user-images.githubusercontent.com/80392504/166496154-04a080a4-457e-47b6-baa6-70865a2ccd76.png) 
![image](https://user-images.githubusercontent.com/80392504/166496188-7e3116a4-0c56-44df-86f3-a2a8f6305cdd.png)

依照碼朵行機械手臂特性，我們可以將它的機構簡化成上述兩個簡圖。根據機動學向量法:由於左右兩圖是不同向量圈,但又由於有兩個平行四邊形,而我們已5mm做我們的移動精準度，所以

d代表微分,由於dr/dt為速度,dt為1,所以簡寫為dr

dr4a+ dr4b=5，dr5a+ dr5b=5

![image](https://user-images.githubusercontent.com/80392504/166499668-df4b9619-980a-4fbf-8b7d-4c1ec9131449.png)
![image](https://user-images.githubusercontent.com/80392504/166499710-d1e42c9e-3caf-433f-a2b4-34d2fea7df68.png)
![image](https://user-images.githubusercontent.com/80392504/166499750-f25413cf-6c9a-4fff-b95f-2e2252a33e44.png)
