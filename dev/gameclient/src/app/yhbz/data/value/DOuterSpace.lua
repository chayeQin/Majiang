-- X_星际迷航基础数据表.xlsx
-- id=玩法类型,name=玩法名称,openWeek=开放时间,count=免费次数,speed=场景移动速度,moveScore=场景移动积分,comsume=能量消耗,init=初始能量值,
local DOuterSpace = {
  [1] = {id=1,name="太空跳跃",openWeek="1,3,5,7",count=2,speed=150,moveScore=0,comsume=0,init=0},
  [2] = {id=2,name="太空飞行",openWeek="2,4,6,7",count=2,speed=300,moveScore=30,comsume=500,init=10}
}
return DOuterSpace