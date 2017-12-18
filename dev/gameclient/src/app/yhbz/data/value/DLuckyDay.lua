-- x_幸运日活动表.xlsx
-- id=编号,dataType=buff类型,dataId=buffid,percent=buff百分比,weight=触发权重值,cd=生效时间,taskSkipType=任务跳转类型,skipType=跳转类型,skipData=跳转数据,helpClick=是否帮助玩家点击,skipFunc=跳转功能,showType=表现方式,
local DLuckyDay = {
  [1] = {id=1,dataType=3,dataId=90,percent=50,weight=100,cd=3600,taskSkipType=1,skipType=1,skipData=4,helpClick=1,skipFunc=20,showType=1},
  [2] = {id=2,dataType=3,dataId=31,percent=50,weight=100,cd=3600,taskSkipType=4,skipType=1,skipData=9,helpClick=1,skipFunc=3,showType=1},
  [3] = {id=3,dataType=3,dataId=43,percent=50,weight=100,cd=3600,taskSkipType=1,skipType=1,skipData=2,helpClick=1,skipFunc=5,showType=1},
  [4] = {id=4,dataType=3,dataId=40,percent=50,weight=100,cd=3600,taskSkipType=1,skipType=1,skipData=1,helpClick=1,skipFunc=2,showType=1},
  [5] = {id=5,dataType=3,dataId=91,percent=20,weight=100,cd=3600,taskSkipType=4,skipType=1,skipData=9,helpClick=1,skipFunc=3,showType=1},
  [6] = {id=6,dataType=3,dataId=92,percent=20,weight=100,cd=3600,taskSkipType=1,skipType=1,skipData=2,helpClick=1,skipFunc=5,showType=1},
  [7] = {id=7,dataType=3,dataId=93,percent=20,weight=100,cd=3600,taskSkipType=1,skipType=1,skipData=1,helpClick=1,skipFunc=2,showType=1}
}
return DLuckyDay