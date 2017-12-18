-- w_web翻牌收费表.xlsx
-- id=活动ID,name=活动名称,libraryId=奖励库ID,free=免费次数,itemType=道具收费类型,itemId=道具收费ID,itemCount=道具收费数量,jewelType=钻石收费类型,jewelId=钻石收费ID,jewelCount=钻石收费数量,refreshType=刷新收费类型,refreshId=刷新收费ID,refreshCount=刷新收费数量,guaranteeCount=保底刷新次数,
local DWebTurnCardConfig = {
  [11] = {id=11,name="翻牌活动",libraryId=1,free=3,itemType=0,itemId=0,itemCount=0,jewelType=5,jewelId=1000,jewelCount=100,refreshType=5,refreshId=1000,refreshCount=5,guaranteeCount=10},
  [7002] = {id=7002,name="翻牌活动",libraryId=1,free=3,itemType=0,itemId=0,itemCount=0,jewelType=5,jewelId=1000,jewelCount=100,refreshType=5,refreshId=1000,refreshCount=5,guaranteeCount=10}
}
return DWebTurnCardConfig