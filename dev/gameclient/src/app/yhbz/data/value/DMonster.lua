-- c_城外怪物数据.xlsx
-- id=怪物等级,occupation=怪物职业,pic=怪物图片ID,type=怪物类型,initCount=初始刷新最低数量,min=16*16区域怪物最低数量,max=16*16区域怪物总数最多,name=名字,speak=对话,areaFight=区域战斗需求次数,needPhysical=体力消耗,
local DMonster = {
  [1] = {id=1,occupation=1,pic=1,type=1,initCount=4,min=3,max=3,name="元首级星舰",speak="战列巡洋舰，舰长：685.3米，翼展：250.6米，舰高：88.2米，舰员：855人。",areaFight=0,needPhysical=10},
  [2] = {id=2,occupation=1,pic=1,type=1,initCount=4,min=3,max=3,name="元首级星舰",speak="战列巡洋舰，舰长：685.3米，翼展：250.6米，舰高：88.2米，舰员：855人。",areaFight=0,needPhysical=10},
  [3] = {id=3,occupation=1,pic=1,type=1,initCount=4,min=3,max=3,name="元首级星舰",speak="战列巡洋舰，舰长：685.3米，翼展：250.6米，舰高：88.2米，舰员：855人。",areaFight=0,needPhysical=10},
  [4] = {id=4,occupation=1,pic=2,type=2,initCount=0,min=2,max=2,name="银河级星舰",speak="战列舰、探索舰，舰长：641米，翼展：457.1米，舰高：137.5米，舰员：1,012人。",areaFight=0,needPhysical=10},
  [5] = {id=5,occupation=1,pic=2,type=2,initCount=0,min=2,max=2,name="银河级星舰",speak="战列舰、探索舰，舰长：641米，翼展：457.1米，舰高：137.5米，舰员：1,012人。",areaFight=0,needPhysical=10},
  [6] = {id=6,occupation=1,pic=2,type=2,initCount=0,min=2,max=2,name="银河级星舰",speak="战列舰、探索舰，舰长：641米，翼展：457.1米，舰高：137.5米，舰员：1,012人。",areaFight=0,needPhysical=11},
  [7] = {id=7,occupation=1,pic=3,type=2,initCount=0,min=2,max=2,name="星云级星舰",speak="探索舰，舰长：465米，翼展：467.1米，舰高：140.5米，舰员：750人。",areaFight=0,needPhysical=11},
  [8] = {id=8,occupation=1,pic=3,type=2,initCount=0,min=2,max=2,name="星云级星舰",speak="探索舰，舰长：465米，翼展：467.1米，舰高：140.5米，舰员：750人。",areaFight=0,needPhysical=11},
  [9] = {id=9,occupation=1,pic=3,type=2,initCount=0,min=2,max=2,name="星云级星舰",speak="探索舰，舰长：465米，翼展：467.1米，舰高：140.5米，舰员：750人。",areaFight=0,needPhysical=11},
  [10] = {id=10,occupation=1,pic=4,type=2,initCount=0,min=1,max=2,name="无畏级星舰",speak="中型巡洋舰、轻型探索船，舰长：344.5米，翼展：132.1米，舰高：64.4米，舰员：150人。",areaFight=0,needPhysical=11},
  [11] = {id=11,occupation=1,pic=4,type=2,initCount=0,min=1,max=2,name="无畏级星舰",speak="中型巡洋舰、轻型探索船，舰长：344.5米，翼展：132.1米，舰高：64.4米，舰员：150人。",areaFight=0,needPhysical=12},
  [12] = {id=12,occupation=1,pic=4,type=2,initCount=0,min=1,max=2,name="无畏级星舰",speak="中型巡洋舰、轻型探索船，舰长：344.5米，翼展：132.1米，舰高：64.4米，舰员：150人。",areaFight=0,needPhysical=12},
  [13] = {id=13,occupation=1,pic=5,type=2,initCount=0,min=1,max=2,name="星宿级星舰",speak="中型巡洋舰，舰长：310米，翼展：175米，舰高：86米，舰员：535人。",areaFight=0,needPhysical=12},
  [14] = {id=14,occupation=1,pic=5,type=2,initCount=0,min=1,max=2,name="星宿级星舰",speak="中型巡洋舰，舰长：310米，翼展：175米，舰高：86米，舰员：535人。",areaFight=0,needPhysical=12},
  [15] = {id=15,occupation=1,pic=5,type=2,initCount=0,min=1,max=2,name="星宿级星舰",speak="中型巡洋舰，舰长：310米，翼展：175米，舰高：86米，舰员：535人。",areaFight=0,needPhysical=13},
  [16] = {id=16,occupation=1,pic=6,type=2,initCount=0,min=1,max=2,name="精进级星舰",speak="探索舰、重型巡洋舰，舰长：467米，翼展：186米，舰高：78米，舰员：750人。",areaFight=0,needPhysical=13},
  [17] = {id=17,occupation=1,pic=6,type=2,initCount=0,min=1,max=2,name="精进级星舰",speak="探索舰、重型巡洋舰，舰长：467米，翼展：186米，舰高：78米，舰员：750人。",areaFight=0,needPhysical=13},
  [18] = {id=18,occupation=1,pic=6,type=2,initCount=0,min=1,max=2,name="精进级星舰",speak="探索舰、重型巡洋舰，舰长：467米，翼展：186米，舰高：78米，舰员：750人。",areaFight=0,needPhysical=13},
  [19] = {id=19,occupation=1,pic=7,type=2,initCount=0,min=1,max=2,name="光明级星舰",speak="航空巡洋舰，舰长：440米，翼展：303米，舰高：82米，舰员：824人。",areaFight=0,needPhysical=14},
  [20] = {id=20,occupation=1,pic=7,type=2,initCount=0,min=1,max=2,name="光明级星舰",speak="航空巡洋舰，舰长：440米，翼展：303米，舰高：82米，舰员：824人。",areaFight=0,needPhysical=14},
  [21] = {id=21,occupation=1,pic=7,type=2,initCount=0,min=1,max=2,name="光明级星舰",speak="航空巡洋舰，舰长：440米，翼展：303米，舰高：82米，舰员：824人。",areaFight=0,needPhysical=14},
  [22] = {id=22,occupation=1,pic=8,type=2,initCount=0,min=1,max=2,name="军刀级星舰",speak="轻型巡洋舰，舰长：223米，翼展：227米，舰高：55米，舰员：40人。",areaFight=0,needPhysical=14},
  [23] = {id=23,occupation=1,pic=8,type=2,initCount=0,min=1,max=2,name="军刀级星舰",speak="轻型巡洋舰，舰长：223米，翼展：227米，舰高：55米，舰员：40人。",areaFight=0,needPhysical=14},
  [24] = {id=24,occupation=1,pic=8,type=2,initCount=0,min=1,max=2,name="军刀级星舰",speak="轻型巡洋舰，舰长：223米，翼展：227米，舰高：55米，舰员：40人。",areaFight=0,needPhysical=15},
  [25] = {id=25,occupation=1,pic=9,type=2,initCount=0,min=1,max=3,name="宪法级星舰",speak="重型巡洋舰，舰长：288.6米，翼展：127.1米，舰高：72.6米，舰员：430人。",areaFight=0,needPhysical=15},
  [26] = {id=26,occupation=1,pic=9,type=2,initCount=0,min=1,max=2,name="宪法级星舰",speak="重型巡洋舰，舰长：288.6米，翼展：127.1米，舰高：72.6米，舰员：430人。",areaFight=0,needPhysical=15},
  [27] = {id=27,occupation=1,pic=9,type=2,initCount=0,min=1,max=2,name="宪法级星舰",speak="重型巡洋舰，舰长：288.6米，翼展：127.1米，舰高：72.6米，舰员：430人。",areaFight=0,needPhysical=15},
  [28] = {id=28,occupation=1,pic=10,type=2,initCount=0,min=1,max=2,name="大使级星舰",speak="重型巡洋舰，舰长：526米，翼展：325米，舰高：124米，舰员：700人。",areaFight=0,needPhysical=16},
  [29] = {id=29,occupation=1,pic=10,type=2,initCount=0,min=1,max=2,name="大使级星舰",speak="重型巡洋舰，舰长：526米，翼展：325米，舰高：124米，舰员：700人。",areaFight=0,needPhysical=16},
  [30] = {id=30,occupation=1,pic=10,type=2,initCount=0,min=1,max=2,name="大使级星舰",speak="重型巡洋舰，舰长：526米，翼展：325米，舰高：124米，舰员：700人。",areaFight=0,needPhysical=16}
}
return DMonster