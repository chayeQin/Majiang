-- t_提示气泡奖励内容.xlsx
-- id=编号,parcel=包裹ID,rate=几率,dataType=要求类型,dataId=要求ID,data=要求数值,itemType=奖励类型,itemId=奖励ID,itemCount=奖励基础数值,floatValue=浮动值,
local DBubble = {
  [1] = {id=1,parcel=1,rate=35,dataType=1,dataId=1,data=1,itemType=5,itemId=1,itemCount=1000,floatValue=100},
  [2] = {id=2,parcel=2,rate=35,dataType=1,dataId=1,data=1,itemType=5,itemId=2,itemCount=1000,floatValue=100},
  [3] = {id=3,parcel=3,rate=15,dataType=1,dataId=1,data=10,itemType=5,itemId=3,itemCount=50,floatValue=10},
  [4] = {id=4,parcel=4,rate=10,dataType=1,dataId=1,data=15,itemType=5,itemId=4,itemCount=10,floatValue=5},
  [5] = {id=5,parcel=5,rate=5,dataType=1,dataId=1,data=1,itemType=5,itemId=1000,itemCount=5,floatValue=0}
}
return DBubble