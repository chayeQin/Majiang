-- l.联盟boss排名奖励表.xlsx
-- id=编号,type=类型,min=最小排名,max=最大排名,itemType=奖励类型,itemId=奖励ID,itemCount=奖励数量,
local DUnionBossRank = {
  [1] = {id=1,type=1,min=1,max=1,itemType=5,itemId=1000,itemCount=800},
  [2] = {id=2,type=1,min=1,max=1,itemType=5,itemId=70,itemCount=100},
  [3] = {id=3,type=1,min=1,max=1,itemType=5,itemId=71,itemCount=100},
  [4] = {id=4,type=1,min=1,max=1,itemType=5,itemId=72,itemCount=100},
  [5] = {id=5,type=1,min=1,max=1,itemType=5,itemId=73,itemCount=100},
  [6] = {id=6,type=1,min=1,max=1,itemType=5,itemId=74,itemCount=100},
  [7] = {id=7,type=1,min=1,max=1,itemType=5,itemId=75,itemCount=100},
  [8] = {id=8,type=1,min=2,max=2,itemType=5,itemId=1000,itemCount=600},
  [9] = {id=9,type=1,min=2,max=2,itemType=5,itemId=70,itemCount=80},
  [10] = {id=10,type=1,min=2,max=2,itemType=5,itemId=71,itemCount=80},
  [11] = {id=11,type=1,min=2,max=2,itemType=5,itemId=72,itemCount=80},
  [12] = {id=12,type=1,min=2,max=2,itemType=5,itemId=73,itemCount=80},
  [13] = {id=13,type=1,min=2,max=2,itemType=5,itemId=74,itemCount=80},
  [14] = {id=14,type=1,min=2,max=2,itemType=5,itemId=75,itemCount=80},
  [15] = {id=15,type=1,min=3,max=3,itemType=5,itemId=1000,itemCount=400},
  [16] = {id=16,type=1,min=3,max=3,itemType=5,itemId=70,itemCount=50},
  [17] = {id=17,type=1,min=3,max=3,itemType=5,itemId=71,itemCount=50},
  [18] = {id=18,type=1,min=3,max=3,itemType=5,itemId=72,itemCount=50},
  [19] = {id=19,type=1,min=3,max=3,itemType=5,itemId=73,itemCount=50},
  [20] = {id=20,type=1,min=3,max=3,itemType=5,itemId=74,itemCount=50},
  [21] = {id=21,type=1,min=3,max=3,itemType=5,itemId=75,itemCount=50},
  [22] = {id=22,type=1,min=4,max=10,itemType=5,itemId=1000,itemCount=300},
  [23] = {id=23,type=1,min=4,max=10,itemType=5,itemId=70,itemCount=35},
  [24] = {id=24,type=1,min=4,max=10,itemType=5,itemId=71,itemCount=35},
  [25] = {id=25,type=1,min=4,max=10,itemType=5,itemId=72,itemCount=35},
  [26] = {id=26,type=1,min=4,max=10,itemType=5,itemId=73,itemCount=35},
  [27] = {id=27,type=1,min=4,max=10,itemType=5,itemId=74,itemCount=35},
  [28] = {id=28,type=1,min=4,max=10,itemType=5,itemId=75,itemCount=35},
  [29] = {id=29,type=1,min=11,max=30,itemType=5,itemId=1000,itemCount=200},
  [30] = {id=30,type=1,min=11,max=30,itemType=5,itemId=70,itemCount=25},
  [31] = {id=31,type=1,min=11,max=30,itemType=5,itemId=71,itemCount=25},
  [32] = {id=32,type=1,min=11,max=30,itemType=5,itemId=72,itemCount=25},
  [33] = {id=33,type=1,min=11,max=30,itemType=5,itemId=73,itemCount=25},
  [34] = {id=34,type=1,min=11,max=30,itemType=5,itemId=74,itemCount=25},
  [35] = {id=35,type=1,min=11,max=30,itemType=5,itemId=75,itemCount=25},
  [36] = {id=36,type=1,min=31,max=60,itemType=5,itemId=1000,itemCount=100},
  [37] = {id=37,type=1,min=31,max=60,itemType=5,itemId=70,itemCount=15},
  [38] = {id=38,type=1,min=31,max=60,itemType=5,itemId=71,itemCount=15},
  [39] = {id=39,type=1,min=31,max=60,itemType=5,itemId=72,itemCount=15},
  [40] = {id=40,type=1,min=31,max=60,itemType=5,itemId=73,itemCount=15},
  [41] = {id=41,type=1,min=31,max=60,itemType=5,itemId=74,itemCount=15},
  [42] = {id=42,type=1,min=31,max=60,itemType=5,itemId=75,itemCount=15},
  [43] = {id=43,type=1,min=61,max=100,itemType=5,itemId=1000,itemCount=50},
  [44] = {id=44,type=1,min=61,max=100,itemType=5,itemId=70,itemCount=10},
  [45] = {id=45,type=1,min=61,max=100,itemType=5,itemId=71,itemCount=10},
  [46] = {id=46,type=1,min=61,max=100,itemType=5,itemId=72,itemCount=10},
  [47] = {id=47,type=1,min=61,max=100,itemType=5,itemId=73,itemCount=10},
  [48] = {id=48,type=1,min=61,max=100,itemType=5,itemId=74,itemCount=10},
  [49] = {id=49,type=1,min=61,max=100,itemType=5,itemId=75,itemCount=10},
  [50] = {id=50,type=2,min=1,max=1,itemType=5,itemId=1000,itemCount=300},
  [51] = {id=51,type=2,min=1,max=1,itemType=5,itemId=1,itemCount=200000},
  [52] = {id=52,type=2,min=1,max=1,itemType=5,itemId=2,itemCount=200000},
  [53] = {id=53,type=2,min=1,max=1,itemType=5,itemId=3,itemCount=50000},
  [54] = {id=54,type=2,min=1,max=1,itemType=5,itemId=4,itemCount=10000},
  [55] = {id=55,type=2,min=2,max=2,itemType=5,itemId=1000,itemCount=200},
  [56] = {id=56,type=2,min=2,max=2,itemType=5,itemId=1,itemCount=150000},
  [57] = {id=57,type=2,min=2,max=2,itemType=5,itemId=2,itemCount=150000},
  [58] = {id=58,type=2,min=2,max=2,itemType=5,itemId=3,itemCount=37500},
  [59] = {id=59,type=2,min=2,max=2,itemType=5,itemId=4,itemCount=7500},
  [60] = {id=60,type=2,min=3,max=3,itemType=5,itemId=1000,itemCount=100},
  [61] = {id=61,type=2,min=3,max=3,itemType=5,itemId=1,itemCount=100000},
  [62] = {id=62,type=2,min=3,max=3,itemType=5,itemId=2,itemCount=100000},
  [63] = {id=63,type=2,min=3,max=3,itemType=5,itemId=3,itemCount=25000},
  [64] = {id=64,type=2,min=3,max=3,itemType=5,itemId=4,itemCount=5000},
  [65] = {id=65,type=2,min=4,max=10,itemType=5,itemId=1000,itemCount=50},
  [66] = {id=66,type=2,min=4,max=10,itemType=5,itemId=1,itemCount=50000},
  [67] = {id=67,type=2,min=4,max=10,itemType=5,itemId=2,itemCount=50000},
  [68] = {id=68,type=2,min=4,max=10,itemType=5,itemId=3,itemCount=12500},
  [69] = {id=69,type=2,min=4,max=10,itemType=5,itemId=4,itemCount=2500}
}
return DUnionBossRank