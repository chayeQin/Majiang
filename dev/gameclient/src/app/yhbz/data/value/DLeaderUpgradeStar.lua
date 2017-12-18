-- L_领袖升星消耗表.xlsx
-- id=英雄星级,grow1=属性成长1,grow2=属性成长2,need=升星碎片数量,convert=转换碎片数量,compound=合成碎片数量,skillCount=开启天赋数量,
local DLeaderUpgradeStar = {
  [1] = {id=1,grow1=200,grow2=150,need=20,convert=7,compound=10,skillCount=1},
  [2] = {id=2,grow1=250,grow2=200,need=40,convert=10,compound=30,skillCount=2},
  [3] = {id=3,grow1=300,grow2=250,need=60,convert=15,compound=70,skillCount=2},
  [4] = {id=4,grow1=325,grow2=300,need=80,convert=0,compound=0,skillCount=3},
  [5] = {id=5,grow1=350,grow2=375,need=90,convert=0,compound=0,skillCount=3},
  [6] = {id=6,grow1=375,grow2=425,need=95,convert=0,compound=0,skillCount=4},
  [7] = {id=7,grow1=425,grow2=475,need=100,convert=0,compound=0,skillCount=4},
  [8] = {id=8,grow1=500,grow2=500,need=0,convert=0,compound=0,skillCount=4}
}
return DLeaderUpgradeStar