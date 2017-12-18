-- j_军衔数据.xlsx
-- id=军衔编号,commandLv=指挥官等级需求,limit=人数限制,lv=军衔等级,name=军衔名称,itemType=需求道具类型,itemId=需求道具ID,itemCount=需求道具数量,fight=战斗力,
local DMilitaryRank = {
  [1] = {id=1,commandLv=5,limit=-1,lv=1,name="列兵",itemType=5,itemId=16,itemCount=60000,fight=400},
  [2] = {id=2,commandLv=10,limit=-1,lv=2,name="下士",itemType=5,itemId=16,itemCount=190000,fight=800},
  [3] = {id=3,commandLv=15,limit=-1,lv=3,name="中士",itemType=5,itemId=16,itemCount=470000,fight=1950},
  [4] = {id=4,commandLv=20,limit=-1,lv=4,name="上士",itemType=5,itemId=16,itemCount=1070000,fight=2700},
  [5] = {id=5,commandLv=25,limit=-1,lv=5,name="军士长",itemType=5,itemId=16,itemCount=2350000,fight=4800},
  [6] = {id=6,commandLv=30,limit=-1,lv=6,name="少尉",itemType=5,itemId=16,itemCount=4730000,fight=6000},
  [7] = {id=7,commandLv=35,limit=-1,lv=7,name="中尉",itemType=5,itemId=16,itemCount=9140000,fight=7200},
  [8] = {id=8,commandLv=40,limit=-1,lv=8,name="上尉",itemType=5,itemId=16,itemCount=17286200,fight=10500},
  [9] = {id=9,commandLv=45,limit=-1,lv=9,name="少校",itemType=5,itemId=16,itemCount=32292400,fight=12250},
  [10] = {id=10,commandLv=50,limit=-1,lv=10,name="中校",itemType=5,itemId=16,itemCount=55927200,fight=14000},
  [11] = {id=11,commandLv=50,limit=50,lv=11,name="上校",itemType=5,itemId=16,itemCount=93067600,fight=18900},
  [12] = {id=12,commandLv=50,limit=30,lv=12,name="大校",itemType=5,itemId=16,itemCount=151310600,fight=21000},
  [13] = {id=13,commandLv=50,limit=15,lv=13,name="少将",itemType=5,itemId=16,itemCount=242473500,fight=26950},
  [14] = {id=14,commandLv=50,limit=15,lv=14,name="中将",itemType=5,itemId=16,itemCount=384915600,fight=29400},
  [15] = {id=15,commandLv=50,limit=8,lv=15,name="三星上将",itemType=5,itemId=16,itemCount=607125300,fight=35490},
  [16] = {id=16,commandLv=50,limit=5,lv=16,name="四星上将",itemType=5,itemId=16,itemCount=953259600,fight=38610},
  [17] = {id=17,commandLv=50,limit=2,lv=17,name="五星上将",itemType=5,itemId=16,itemCount=1491690800,fight=41340},
  [18] = {id=18,commandLv=50,limit=2,lv=18,name="元帅",itemType=5,itemId=16,itemCount=2328182200,fight=48590},
  [19] = {id=19,commandLv=50,limit=1,lv=19,name="总参谋长",itemType=5,itemId=16,itemCount=3626186100,fight=52030},
  [20] = {id=20,commandLv=50,limit=1,lv=20,name="国防部长",itemType=5,itemId=16,itemCount=5638092200,fight=60630},
  [21] = {id=21,commandLv=-1,limit=1,lv=21,name="总统",itemType=5,itemId=16,itemCount=-1,fight=63920}
}
return DMilitaryRank