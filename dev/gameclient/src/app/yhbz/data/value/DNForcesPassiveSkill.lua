-- Z_主城兵种被动技能表.xlsx
-- id=技能ID,iconId=图片ID,name=技能名称,desc=技能描述,
local DNForcesPassiveSkill = {
  [1] = {id=1,iconId=3,name="联合攻击",desc="当战斗单位被排列在同一纵列上，前排单位攻击时，后排单位将会同时攻击，给敌人造成更多伤害！"},
  [2] = {id=2,iconId=4,name="溅射",desc="当战斗单位攻击被自己克制的单位时，将有几率造成溅射，对目标相邻的单位也造成伤害！"},
  [3] = {id=3,iconId=5,name="迷惑",desc="当战斗单位攻击克制自己的单位时，有一定几率被迷惑，自身攻击力降低，持续一回合！"}
}
return DNForcesPassiveSkill