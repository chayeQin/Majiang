-- Y_月度好礼配置表.xlsx
-- id=编号,name=名称,openType=开启要求类型,openId=开启要求ID,openData=开启数据,closeType=关闭要求类型,closeId=关闭要求ID,closeData=关闭数据,day1=周卡奖励次数,day2=月卡奖励次数,sort=排序ID,pic=图片ID,desc=描述,dayDesc1=周卡奖励次数,dayDesc2=月卡奖励次数,
local DMonthlyGift = {
  [1001] = {id=1001,name="黄金队列卡",openType=1,openId=1,openData=1,closeType=0,closeId=0,closeData=0,day1=7,day2=37,sort=1,pic=1,desc="立即获得连续多天的黄金队列！同样时间，双倍效率！月卡更实惠，额外送7天！",dayDesc1=7,dayDesc2=30},
  [1002] = {id=1002,name="特惠钻石卡",openType=1,openId=1,openData=1,closeType=0,closeId=0,closeData=0,day1=7,day2=37,sort=2,pic=2,desc="每天领取800钻石返还，月卡更实惠，额外送7天，不可错过的超值福利！",dayDesc1=7,dayDesc2=30},
  [1003] = {id=1003,name="特惠城建卡",openType=1,openId=1,openData=1,closeType=0,closeId=0,closeData=0,day1=7,day2=37,sort=3,pic=3,desc="打造战舰、升级建筑的最佳选择，每日大量城建资源直接领取！月卡更实惠，额外送7天！",dayDesc1=7,dayDesc2=30}
}
return DMonthlyGift