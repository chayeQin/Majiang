-- l.联盟商城.xlsx
-- id=编号,goodsType=商品数据类型,goodsId=商品数据ID,goodsCount=商品数值,unionType=联盟购买所需数据类型,unionId=联盟购买所需数据id,unionCount=联盟购买所需数值,itemType=个人购买所需数据类型,itemId=个人购买所需数据ID,itemCount=个人购买所需数值,sort=排序ID,show=是否上架,
local DUnionShop = {
  [1] = {id=1,goodsType=7,goodsId=101,goodsCount=1,unionType=13,unionId=1,unionCount=3000,itemType=5,itemId=300,itemCount=3000,sort=4,show=0},
  [2] = {id=2,goodsType=7,goodsId=102,goodsCount=1,unionType=13,unionId=1,unionCount=30000,itemType=5,itemId=300,itemCount=30000,sort=5,show=1},
  [3] = {id=3,goodsType=7,goodsId=104,goodsCount=1,unionType=13,unionId=1,unionCount=190000,itemType=5,itemId=300,itemCount=190000,sort=6,show=0},
  [4] = {id=4,goodsType=12,goodsId=1,goodsCount=1,unionType=13,unionId=1,unionCount=100000,itemType=5,itemId=300,itemCount=100000,sort=2,show=1},
  [5] = {id=5,goodsType=12,goodsId=2,goodsCount=1,unionType=13,unionId=1,unionCount=400000,itemType=5,itemId=300,itemCount=400000,sort=3,show=1},
  [6] = {id=6,goodsType=6,goodsId=2906,goodsCount=1,unionType=13,unionId=1,unionCount=48000,itemType=5,itemId=300,itemCount=48000,sort=7,show=1},
  [7] = {id=7,goodsType=6,goodsId=2504,goodsCount=1,unionType=13,unionId=1,unionCount=8000,itemType=5,itemId=300,itemCount=8000,sort=8,show=1},
  [8] = {id=8,goodsType=6,goodsId=2602,goodsCount=1,unionType=13,unionId=1,unionCount=24000,itemType=5,itemId=300,itemCount=24000,sort=9,show=1},
  [9] = {id=9,goodsType=6,goodsId=2004,goodsCount=1,unionType=13,unionId=1,unionCount=30000,itemType=5,itemId=300,itemCount=30000,sort=10,show=1},
  [10] = {id=10,goodsType=7,goodsId=801,goodsCount=1,unionType=13,unionId=1,unionCount=10000,itemType=5,itemId=300,itemCount=10000,sort=11,show=1},
  [11] = {id=11,goodsType=8,goodsId=18,goodsCount=1,unionType=13,unionId=1,unionCount=6000,itemType=5,itemId=300,itemCount=6000,sort=12,show=1},
  [12] = {id=12,goodsType=8,goodsId=19,goodsCount=1,unionType=13,unionId=1,unionCount=6000,itemType=5,itemId=300,itemCount=6000,sort=13,show=1},
  [13] = {id=13,goodsType=8,goodsId=20,goodsCount=1,unionType=13,unionId=1,unionCount=10000,itemType=5,itemId=300,itemCount=10000,sort=14,show=1},
  [14] = {id=14,goodsType=8,goodsId=21,goodsCount=1,unionType=13,unionId=1,unionCount=14000,itemType=5,itemId=300,itemCount=14000,sort=15,show=1},
  [15] = {id=15,goodsType=8,goodsId=16,goodsCount=1,unionType=13,unionId=1,unionCount=120000,itemType=5,itemId=300,itemCount=120000,sort=16,show=1},
  [16] = {id=16,goodsType=8,goodsId=1,goodsCount=1,unionType=13,unionId=1,unionCount=100000,itemType=5,itemId=300,itemCount=100000,sort=17,show=1},
  [17] = {id=17,goodsType=8,goodsId=5,goodsCount=1,unionType=13,unionId=1,unionCount=50000,itemType=5,itemId=300,itemCount=50000,sort=18,show=1},
  [18] = {id=18,goodsType=8,goodsId=7,goodsCount=1,unionType=13,unionId=1,unionCount=50000,itemType=5,itemId=300,itemCount=50000,sort=19,show=1},
  [20] = {id=20,goodsType=8,goodsId=22,goodsCount=1,unionType=13,unionId=1,unionCount=100000,itemType=5,itemId=300,itemCount=100000,sort=20,show=1},
  [21] = {id=21,goodsType=12,goodsId=4,goodsCount=1,unionType=13,unionId=1,unionCount=200000,itemType=5,itemId=300,itemCount=200000,sort=21,show=1},
  [22] = {id=22,goodsType=12,goodsId=5,goodsCount=1,unionType=13,unionId=1,unionCount=40000,itemType=5,itemId=300,itemCount=40000,sort=22,show=1},
  [23] = {id=23,goodsType=12,goodsId=6,goodsCount=1,unionType=13,unionId=1,unionCount=80000,itemType=5,itemId=300,itemCount=80000,sort=23,show=1},
  [24] = {id=24,goodsType=12,goodsId=8,goodsCount=1,unionType=13,unionId=1,unionCount=80000,itemType=5,itemId=300,itemCount=80000,sort=1,show=1},
  [25] = {id=25,goodsType=7,goodsId=501,goodsCount=1,unionType=13,unionId=1,unionCount=3000,itemType=5,itemId=300,itemCount=3000,sort=4,show=0},
  [26] = {id=26,goodsType=7,goodsId=502,goodsCount=1,unionType=13,unionId=1,unionCount=30000,itemType=5,itemId=300,itemCount=30000,sort=5,show=1},
  [27] = {id=27,goodsType=7,goodsId=504,goodsCount=1,unionType=13,unionId=1,unionCount=190000,itemType=5,itemId=300,itemCount=190000,sort=6,show=0},
  [28] = {id=28,goodsType=7,goodsId=201,goodsCount=1,unionType=13,unionId=1,unionCount=3000,itemType=5,itemId=300,itemCount=3000,sort=4,show=0},
  [29] = {id=29,goodsType=7,goodsId=202,goodsCount=1,unionType=13,unionId=1,unionCount=30000,itemType=5,itemId=300,itemCount=30000,sort=5,show=1},
  [30] = {id=30,goodsType=7,goodsId=204,goodsCount=1,unionType=13,unionId=1,unionCount=190000,itemType=5,itemId=300,itemCount=190000,sort=6,show=0},
  [31] = {id=31,goodsType=7,goodsId=301,goodsCount=1,unionType=13,unionId=1,unionCount=3000,itemType=5,itemId=300,itemCount=3000,sort=4,show=0},
  [32] = {id=32,goodsType=7,goodsId=302,goodsCount=1,unionType=13,unionId=1,unionCount=30000,itemType=5,itemId=300,itemCount=30000,sort=5,show=1},
  [33] = {id=33,goodsType=7,goodsId=304,goodsCount=1,unionType=13,unionId=1,unionCount=190000,itemType=5,itemId=300,itemCount=190000,sort=6,show=0},
  [34] = {id=34,goodsType=24,goodsId=10012,goodsCount=1,unionType=13,unionId=1,unionCount=40000,itemType=5,itemId=300,itemCount=40000,sort=24,show=1},
  [35] = {id=35,goodsType=24,goodsId=10014,goodsCount=1,unionType=13,unionId=1,unionCount=40000,itemType=5,itemId=300,itemCount=40000,sort=25,show=1},
  [36] = {id=36,goodsType=24,goodsId=10041,goodsCount=1,unionType=13,unionId=1,unionCount=40000,itemType=5,itemId=300,itemCount=40000,sort=26,show=1}
}
return DUnionShop