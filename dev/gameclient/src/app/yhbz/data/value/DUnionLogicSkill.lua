-- l_联盟逻辑技能数据表.xlsx
-- id=编号,name=名称,pic=图片,itemType=消耗类型,itemId=消耗ID,itemCount=消耗参数,cd=冷却时间,desc=描述,param=功能参数,
local DUnionLogicSkill = {
  [10001] = {id=10001,name="全盟保护",pic=10001,itemType=13,itemId=2,itemCount=70000,cd=86400,desc="使用技能后，全联盟所有成员将开启8小时的战争保护",param=28800},
  [10002] = {id=10002,name="盟主庇护",pic=10002,itemType=13,itemId=2,itemCount=3000,cd=3600,desc="使用技能后，可指定给任意一个联盟成员开启8小时的战争保护",param=28800},
  [10003] = {id=10003,name="定位",pic=10003,itemType=13,itemId=2,itemCount=3000,cd=3600,desc="使用技能后，可搜索游戏中任意一个玩家所在的坐标",param=0},
  [10004] = {id=10004,name="快速修复",pic=10004,itemType=13,itemId=2,itemCount=50000,cd=86400,desc="使用技能后，全联盟所有成员的堡垒都会立即灭火，且城防值恢复为全满",param=0},
  [10005] = {id=10005,name="联盟红包",pic=10005,itemType=13,itemId=2,itemCount=60000,cd=28800,desc="使用技能后，会在联盟频道发放一个价值5000钻石的联盟红包",param=5000},
  [10006] = {id=10006,name="联盟大炮",pic=10006,itemType=13,itemId=2,itemCount=70000,cd=360,desc="使用技能后，可以对指定任意一个玩家堡垒造成攻击，立即减少对方5000点城防值",param=5000}
}
return DUnionLogicSkill