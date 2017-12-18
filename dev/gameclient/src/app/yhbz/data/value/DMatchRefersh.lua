-- x_限时比赛活动刷新规则.xlsx
-- id=编号,flag=限时活动类型,order=活动顺序,activityType=活动类型,continueDay=活动持续天数,rewardId=奖励关联ID,desc=任务描述,
local DMatchRefersh = {
  [1] = {id=1,flag=1,order=1,activityType=4,continueDay=1,rewardId=1,desc="堡垒发展"},
  [2] = {id=2,flag=1,order=2,activityType=2,continueDay=1,rewardId=1,desc="攻打怪物"},
  [3] = {id=3,flag=1,order=3,activityType=1,continueDay=1,rewardId=1,desc="采集资源"},
  [4] = {id=4,flag=1,order=4,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [5] = {id=5,flag=1,order=5,activityType=2,continueDay=1,rewardId=1,desc="攻打怪物"},
  [6] = {id=6,flag=1,order=6,activityType=1,continueDay=1,rewardId=1,desc="采集资源"},
  [7] = {id=7,flag=1,order=7,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [8] = {id=8,flag=1,order=8,activityType=5,continueDay=1,rewardId=1,desc="打造舰艇"},
  [9] = {id=9,flag=1,order=9,activityType=6,continueDay=3,rewardId=2,desc="击败敌人"},
  [10] = {id=10,flag=2,order=1,activityType=1,continueDay=1,rewardId=1,desc="采集资源"},
  [11] = {id=11,flag=2,order=1,activityType=2,continueDay=1,rewardId=1,desc="攻打怪物"},
  [12] = {id=12,flag=2,order=1,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [13] = {id=13,flag=2,order=1,activityType=4,continueDay=1,rewardId=1,desc="堡垒发展"},
  [14] = {id=14,flag=2,order=2,activityType=1,continueDay=1,rewardId=1,desc="采集资源"},
  [15] = {id=15,flag=2,order=2,activityType=2,continueDay=1,rewardId=1,desc="攻打怪物"},
  [16] = {id=16,flag=2,order=2,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [17] = {id=17,flag=2,order=2,activityType=4,continueDay=1,rewardId=1,desc="堡垒发展"},
  [18] = {id=18,flag=2,order=3,activityType=1,continueDay=1,rewardId=1,desc="采集资源"},
  [19] = {id=19,flag=2,order=3,activityType=2,continueDay=1,rewardId=1,desc="攻打怪物"},
  [20] = {id=20,flag=2,order=3,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [21] = {id=21,flag=2,order=3,activityType=4,continueDay=1,rewardId=1,desc="堡垒发展"},
  [22] = {id=22,flag=2,order=4,activityType=3,continueDay=1,rewardId=1,desc="提升实力"},
  [23] = {id=23,flag=2,order=4,activityType=5,continueDay=1,rewardId=1,desc="打造舰艇"},
  [24] = {id=24,flag=2,order=5,activityType=6,continueDay=3,rewardId=2,desc="击败敌人"}
}
return DMatchRefersh