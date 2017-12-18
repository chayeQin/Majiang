-- C_藏宝图兑换随机表.xlsx
-- id=兑换ID,odds=出现权重,commonAwardId1=通用奖励库ID,commonAwardNumber1=通用奖励数量,needNumber=需求随机数量,needScore=需求总积分,
local DTreasureExchange = {
  [1] = {id=1,odds=200,commonAwardId1=504,commonAwardNumber1="1",needNumber=1,needScore="5|10"},
  [2] = {id=2,odds=450,commonAwardId1=505,commonAwardNumber1="1",needNumber=2,needScore="10|20"},
  [3] = {id=3,odds=350,commonAwardId1=506,commonAwardNumber1="1",needNumber=3,needScore="15|30"}
}
return DTreasureExchange