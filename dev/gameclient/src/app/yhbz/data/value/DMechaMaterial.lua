-- J_机甲材料表.xlsx
-- id=材料ID,pic=图片ID,name=材料名称,type=材料类型,cd=正常生产时间,quality=品质,count=单次生产个数,desc=文字描述,demand=合成所需材料,itemType=售价类型,itemId=售价ID,init=初始售价,range=上下幅度,integral=积分,sell=是否出售,sellCount=出售数量,dataType=开启类型,dataId=开启ID,value=开启数值,
local DMechaMaterial = {
  [1001] = {id=1001,pic=101,name="压气机轮",type=1,cd=300,quality=1,count=10,desc="压气机轮，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=50,range=50,integral=5,sell=1,sellCount=5,dataType=1,dataId=1,value=1},
  [1002] = {id=1002,pic=102,name="导风轮",type=1,cd=300,quality=1,count=10,desc="导风轮，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=50,range=50,integral=5,sell=1,sellCount=5,dataType=1,dataId=1,value=1},
  [1003] = {id=1003,pic=103,name="叶轮",type=1,cd=300,quality=1,count=10,desc="叶轮，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=50,range=50,integral=5,sell=1,sellCount=5,dataType=1,dataId=1,value=1},
  [1004] = {id=1004,pic=104,name="飞轮",type=1,cd=600,quality=2,count=10,desc="飞轮，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=100,range=40,integral=10,sell=0,sellCount=0,dataType=1,dataId=1,value=13},
  [1005] = {id=1005,pic=105,name="轮盘",type=1,cd=1200,quality=2,count=10,desc="轮盘，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=200,range=40,integral=20,sell=0,sellCount=0,dataType=1,dataId=1,value=13},
  [1006] = {id=1006,pic=106,name="导弹构件",type=1,cd=1800,quality=2,count=10,desc="导弹构件，用于战舰机甲升级、进阶。",demand="",itemType=5,itemId=100,init=300,range=40,integral=30,sell=0,sellCount=0,dataType=1,dataId=1,value=13},
  [2001] = {id=2001,pic=107,name="螺旋桨",type=2,cd=720,quality=1,count=10,desc="螺旋桨，用于战舰机甲升级、进阶。",demand="1001_1|1003_2",itemType=5,itemId=100,init=250,range=40,integral=27,sell=0,sellCount=0,dataType=1,dataId=1,value=13},
  [2002] = {id=2002,pic=108,name="叶片",type=2,cd=720,quality=1,count=10,desc="叶片，用于战舰机甲升级、进阶。",demand="1002_1|1001_2",itemType=5,itemId=100,init=250,range=30,integral=27,sell=0,sellCount=0,dataType=1,dataId=1,value=13},
  [2003] = {id=2003,pic=109,name="连杆",type=2,cd=720,quality=1,count=10,desc="连杆，用于战舰机甲升级、进阶。",demand="1001_2|1003_1",itemType=5,itemId=100,init=250,range=30,integral=27,sell=0,sellCount=0,dataType=1,dataId=1,value=25},
  [3001] = {id=3001,pic=110,name="压缩机",type=2,cd=1500,quality=2,count=10,desc="压缩机，用于战舰机甲升级、进阶。",demand="2002_1|1002_2",itemType=5,itemId=100,init=600,range=30,integral=62,sell=0,sellCount=0,dataType=1,dataId=1,value=25},
  [3002] = {id=3002,pic=111,name="活塞",type=2,cd=2760,quality=2,count=10,desc="活塞，用于战舰机甲升级、进阶。",demand="2003_1|1005_2",itemType=5,itemId=100,init=1100,range=30,integral=113,sell=0,sellCount=0,dataType=1,dataId=1,value=36},
  [4001] = {id=4001,pic=112,name="铆钉",type=2,cd=3000,quality=3,count=10,desc="铆钉，用于战舰机甲升级、进阶。",demand="1004_3|2001_2",itemType=5,itemId=100,init=1300,range=30,integral=134,sell=0,sellCount=0,dataType=1,dataId=1,value=36},
  [4002] = {id=4002,pic=113,name="离心叶轮",type=2,cd=4080,quality=3,count=10,desc="离心叶轮，用于战舰机甲升级、进阶。",demand="2003_2|1006_2",itemType=5,itemId=100,init=1800,range=30,integral=182,sell=0,sellCount=0,dataType=1,dataId=1,value=36},
  [5001] = {id=5001,pic=114,name="电子雷达",type=2,cd=4440,quality=4,count=10,desc="电子雷达，用于战舰机甲升级、进阶。",demand="3002_1|1002_3|1003_4",itemType=5,itemId=100,init=2200,range=20,integral=223,sell=0,sellCount=0,dataType=1,dataId=1,value=51},
  [5002] = {id=5002,pic=115,name="电感器",type=2,cd=4680,quality=4,count=10,desc="电感器，用于战舰机甲升级、进阶。",demand="1005_2|3001_1|2002_2",itemType=5,itemId=100,init=2350,range=20,integral=235,sell=0,sellCount=0,dataType=1,dataId=1,value=51},
  [6001] = {id=6001,pic=116,name="扫描仪",type=2,cd=6960,quality=5,count=10,desc="扫描仪，用于战舰机甲升级、进阶。",demand="1004_1|3002_2|2001_2",itemType=5,itemId=100,init=4050,range=20,integral=408,sell=0,sellCount=0,dataType=1,dataId=1,value=63},
  [6002] = {id=6002,pic=117,name="增压涡轮",type=2,cd=8580,quality=5,count=10,desc="增压涡轮，用于战舰机甲升级、进阶。",demand="3001_3|1006_4|1004_5",itemType=5,itemId=100,init=5000,range=20,integral=502,sell=0,sellCount=0,dataType=1,dataId=1,value=63}
}
return DMechaMaterial