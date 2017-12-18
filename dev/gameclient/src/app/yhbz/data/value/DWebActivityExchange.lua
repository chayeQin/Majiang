-- w_web兑换活动表.xlsx
-- id=兑换ID,activityId=活动ID,idds=出现权重,commonAwardId1=通用奖励库ID,commonAwardNumber1=通用奖励数量,needNumber=需求随机数量,needScore=需求总积分,
local DWebActivityExchange = {
  [1] = {id=1,activityId=5001,idds=100,commonAwardId1=501,commonAwardNumber1="1",needNumber=3,needScore="9|14"},
  [2] = {id=2,activityId=5001,idds=70,commonAwardId1=502,commonAwardNumber1="1",needNumber=4,needScore="16|24"},
  [3] = {id=3,activityId=5001,idds=40,commonAwardId1=503,commonAwardNumber1="1",needNumber=5,needScore="28|42"},
  [4] = {id=4,activityId=5002,idds=100,commonAwardId1=501,commonAwardNumber1="1",needNumber=3,needScore="9|14"},
  [5] = {id=5,activityId=5002,idds=70,commonAwardId1=502,commonAwardNumber1="1",needNumber=4,needScore="20|31"},
  [6] = {id=6,activityId=5002,idds=40,commonAwardId1=503,commonAwardNumber1="1",needNumber=5,needScore="36|54"},
  [7] = {id=7,activityId=5003,idds=100,commonAwardId1=501,commonAwardNumber1="1",needNumber=3,needScore="9|14"},
  [8] = {id=8,activityId=5003,idds=70,commonAwardId1=502,commonAwardNumber1="1",needNumber=4,needScore="16|24"},
  [9] = {id=9,activityId=5003,idds=40,commonAwardId1=503,commonAwardNumber1="1",needNumber=5,needScore="28|42"}
}
return DWebActivityExchange