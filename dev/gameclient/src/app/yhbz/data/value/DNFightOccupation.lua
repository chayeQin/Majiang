-- Z_主城职业战斗中数据.xlsx
-- id=舰种类型,atkPos=攻击时阵位,defPos=防守时阵位,atkType=攻击类型,restraintForces=克制兵种,reRestraintForces=被克制兵种,defForcesProportion=防守时兵力分配比例,
local DNFightOccupation = {
  [1] = {id=1,atkPos=1,defPos=-1,atkType=1,restraintForces="2|4",reRestraintForces="3|5",defForcesProportion=25},
  [2] = {id=2,atkPos=2,defPos=-2,atkType=1,restraintForces="3|4",reRestraintForces="1|6",defForcesProportion=25},
  [3] = {id=3,atkPos=3,defPos=-3,atkType=1,restraintForces="1|4",reRestraintForces="2|7",defForcesProportion=25},
  [4] = {id=4,atkPos=5,defPos=-5,atkType=2,restraintForces="5|6|7",reRestraintForces="1|2|3",defForcesProportion=25},
  [5] = {id=5,atkPos=0,defPos=-7,atkType=1,restraintForces="1",reRestraintForces="4",defForcesProportion=0},
  [6] = {id=6,atkPos=0,defPos=-8,atkType=1,restraintForces="2",reRestraintForces="4",defForcesProportion=0},
  [7] = {id=7,atkPos=0,defPos=-9,atkType=1,restraintForces="3",reRestraintForces="4",defForcesProportion=0}
}
return DNFightOccupation