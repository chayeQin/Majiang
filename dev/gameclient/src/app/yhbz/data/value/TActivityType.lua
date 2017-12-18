-- h_活动开启规则设定.xlsx
-- id=id,key=key,data=data,
local TActivityType = {
  [1] = {id=1,key="MATCH1",data="限时比赛1"},
  [2] = {id=2,key="MATCH2",data="限时比赛2"},
  [3] = {id=3,key="HBOSS",data="时空大战"},
  [4] = {id=4,key="Kingdom",data="王座争夺战"},
  [7] = {id=7,key="DAY_PHYSICAL",data="领取体力"},
  [8] = {id=8,key="RED_RECHARGE",data="红包充值"},
  [9] = {id=9,key="WEB_ANSWER",data="答题"},
  [10] = {id=10,key="WEB_TASK",data="任务活动"},
  [11] = {id=11,key="WEB_TURN_CARD",data="翻牌活动"},
  [12] = {id=12,key="WEB_MONSTER",data="WEB打怪活动"},
  [13] = {id=13,key="LUCKY_DAY",data="幸运日"},
  [14] = {id=14,key="JEWEL_SNATCH",data="钻石夺宝"}
}
return TActivityType