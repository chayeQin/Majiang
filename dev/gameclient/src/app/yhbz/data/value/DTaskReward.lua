-- r_任务奖励内容.xlsx
-- id=编号,classify=道具分类,itemType=奖励类型,itemid=奖励id,itemCount=奖励数值,playerLv=指挥官等级参数,commandLv=指挥所等级参数,floatValue=浮动值,factorType=奖励发放条件类型,factorId=奖励发放条件ID,factorValue=奖励发放条件数据,
local DTaskReward = {
  [1] = {id=1,classify=1,itemType=5,itemid=2000,itemCount=40,playerLv=2,commandLv=0,floatValue=0.0000,factorType=1,factorId=1,factorValue=1},
  [2] = {id=2,classify=2,itemType=5,itemid=1,itemCount=2000,playerLv=0,commandLv=100,floatValue=0.1000,factorType=1,factorId=100,factorValue=1},
  [3] = {id=3,classify=3,itemType=5,itemid=2,itemCount=1000,playerLv=0,commandLv=50,floatValue=0.1000,factorType=1,factorId=101,factorValue=1},
  [4] = {id=4,classify=4,itemType=5,itemid=3,itemCount=400,playerLv=0,commandLv=20,floatValue=0.1000,factorType=1,factorId=102,factorValue=1},
  [5] = {id=5,classify=5,itemType=5,itemid=4,itemCount=100,playerLv=0,commandLv=10,floatValue=0.1000,factorType=1,factorId=103,factorValue=1}
}
return DTaskReward