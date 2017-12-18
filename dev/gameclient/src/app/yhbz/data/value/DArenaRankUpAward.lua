-- J_竞技场排名提升奖励.xlsx
-- id=奖励ID,rankMin=最低排名,rankMax=最高排名,itemType1=基础奖励类型,itemId1=基础奖励ID,itemValue1=基础奖励数量,rankParam=排名系数,
local DArenaRankUpAward = {
  [1] = {id=1,rankMin=2000,rankMax=1001,itemType1=5,itemId1=1000,itemValue1=1600,rankParam=1.6000},
  [2] = {id=2,rankMin=1000,rankMax=500,itemType1=5,itemId1=1000,itemValue1=2505,rankParam=5.0000},
  [3] = {id=3,rankMin=499,rankMax=101,itemType1=5,itemId1=1000,itemValue1=3192,rankParam=8.0000},
  [4] = {id=4,rankMin=100,rankMax=51,itemType1=5,itemId1=1000,itemValue1=2000,rankParam=40.0000},
  [5] = {id=5,rankMin=50,rankMax=11,itemType1=5,itemId1=1000,itemValue1=3200,rankParam=80.0000},
  [6] = {id=6,rankMin=10,rankMax=5,itemType1=5,itemId1=1000,itemValue1=1920,rankParam=320.0000},
  [7] = {id=7,rankMin=4,rankMax=2,itemType1=5,itemId1=1000,itemValue1=1920,rankParam=640.0000},
  [8] = {id=8,rankMin=1,rankMax=1,itemType1=5,itemId1=1000,itemValue1=1280,rankParam=1280.0000}
}
return DArenaRankUpAward