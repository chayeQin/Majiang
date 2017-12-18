-- C_藏宝图宝藏数据表.xlsx
-- id=id,name=宝藏名字,odds=随机权重,productLib=奖励库ID,count=奖励数量,
local DTreasureStorehouse = {
  [1] = {id=1,name="1级宝藏",odds=600,productLib=1205,count="1|3"},
  [2] = {id=2,name="2级宝藏",odds=500,productLib=1205,count="2|4"},
  [3] = {id=3,name="3级宝藏",odds=400,productLib=1205,count="3|5"},
  [4] = {id=4,name="4级宝藏",odds=300,productLib=1205,count="4|6"},
  [5] = {id=5,name="5级宝藏",odds=200,productLib=1205,count="5|7"}
}
return DTreasureStorehouse