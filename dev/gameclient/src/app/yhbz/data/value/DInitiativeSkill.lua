-- z_主动技能表.xlsx
-- id=编号,name=名称,desc=描述,dataType=数据类型,dataId=数据ID,dataValue=数值,dataPercentage=数据百分比,sustain=持续时间,cd=冷却时间,
local DInitiativeSkill = {
  [1] = {id=1,name="立即返回",desc="主动技能，使所有外出的舰队在3秒内返回您的堡垒。不包括参与组队战斗中的舰队。",dataType=0,dataId=0,dataValue=3,dataPercentage=0,sustain=0,cd=28800},
  [2] = {id=2,name="总动员",desc="主动技能，使用后舰队出航上限增加10%，持续时间1小时。",dataType=3,dataId=16,dataValue=0,dataPercentage=10,sustain=3600,cd=28800},
  [3] = {id=3,name="救援",desc="主动技能，使用技能后的第一次单人出航战斗（仅包括进攻其他指挥官堡垒），损失的舰艇会成为损舰进入维修中心。",dataType=0,dataId=0,dataValue=1,dataPercentage=0,sustain=0,cd=86400},
  [4] = {id=4,name="收获",desc="主动技能，使你的所有资源矿立即获得5小时的产出。",dataType=0,dataId=0,dataValue=18000,dataPercentage=0,sustain=0,cd=28800},
  [5] = {id=5,name="疯狂采集",desc="主动技能，使用技能后采集资源速度提升100%，持续时间2小时。",dataType=3,dataId=77,dataValue=0,dataPercentage=100,sustain=7200,cd=28800},
  [6] = {id=6,name="资源保护",desc="主动技能，使你的堡垒中所有资源在2小时内不会被掠夺。",dataType=0,dataId=0,dataValue=0,dataPercentage=0,sustain=7200,cd=28800},
  [7] = {id=7,name="体力充沛",desc="主动技能，使用后立即获得30体力。",dataType=5,dataId=11,dataValue=30,dataPercentage=0,sustain=0,cd=28800},
  [8] = {id=8,name="歼击机能量I",desc="提高所有歼击机的能量",dataType=0,dataId=0,dataValue=500,dataPercentage=0,sustain=0,cd=28800},
  [9] = {id=9,name="歼击机防御II",desc="提高所有歼击机的防御",dataType=0,dataId=0,dataValue=5,dataPercentage=0,sustain=1800,cd=28800}
}
return DInitiativeSkill