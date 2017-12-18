-- J_机甲材料贸易库.xlsx
-- id=材料ID,name=材料名称,integral=材料积分,count=数量,openData=开启类型,openId=开启ID,value=开启参数,weight=权重值,refershCd=刷新时间,tradeCd=单个贸易时间,
local DMechaTrade = {
  [1001] = {id=1001,name="压气机轮",integral=5,count="4|6",openData=1,openId=1,value=1,weight=200,refershCd=300,tradeCd=450},
  [1002] = {id=1002,name="导风轮",integral=5,count="4|6",openData=1,openId=1,value=1,weight=200,refershCd=300,tradeCd=450},
  [1003] = {id=1003,name="叶轮",integral=5,count="4|6",openData=1,openId=1,value=1,weight=200,refershCd=300,tradeCd=450},
  [1004] = {id=1004,name="飞轮",integral=10,count="2|3",openData=1,openId=1,value=25,weight=200,refershCd=300,tradeCd=900},
  [1005] = {id=1005,name="轮盘",integral=20,count="3|6",openData=1,openId=1,value=25,weight=200,refershCd=300,tradeCd=450},
  [1006] = {id=1006,name="导弹构件",integral=30,count="2|4",openData=1,openId=1,value=25,weight=200,refershCd=300,tradeCd=675},
  [2001] = {id=2001,name="螺旋桨",integral=30,count="2|4",openData=1,openId=1,value=13,weight=200,refershCd=300,tradeCd=675},
  [2002] = {id=2002,name="叶片",integral=30,count="2|4",openData=1,openId=1,value=13,weight=200,refershCd=300,tradeCd=675},
  [2003] = {id=2003,name="连杆",integral=30,count="2|4",openData=1,openId=1,value=36,weight=200,refershCd=300,tradeCd=675},
  [3001] = {id=3001,name="压缩机",integral=60,count="1|2",openData=1,openId=1,value=36,weight=200,refershCd=300,tradeCd=1350},
  [3002] = {id=3002,name="活塞",integral=120,count="1|2",openData=1,openId=1,value=51,weight=200,refershCd=300,tradeCd=1350},
  [4001] = {id=4001,name="铆钉",integral=120,count="1|2",openData=1,openId=1,value=51,weight=200,refershCd=300,tradeCd=1350},
  [4002] = {id=4002,name="离心叶轮",integral=180,count="1|1",openData=1,openId=1,value=51,weight=60,refershCd=300,tradeCd=2700},
  [5001] = {id=5001,name="电子雷达",integral=240,count="1|1",openData=1,openId=1,value=63,weight=60,refershCd=300,tradeCd=2700},
  [5002] = {id=5002,name="电感器",integral=240,count="1|1",openData=1,openId=1,value=63,weight=60,refershCd=300,tradeCd=2700},
  [6001] = {id=6001,name="扫描仪",integral=420,count="1|1",openData=1,openId=1,value=75,weight=60,refershCd=300,tradeCd=2700},
  [6002] = {id=6002,name="增压涡轮",integral=480,count="1|1",openData=1,openId=1,value=75,weight=60,refershCd=300,tradeCd=2700}
}
return DMechaTrade