-- l_联盟科技效果.xlsx
-- id=编号,relevanceId=关联ID,grade=级别,type=所属类型,beforeId=连线层级,name=名称,pic=图片ID,effect=作用效果,star=经验条个数,donateId=捐献类型,lvLimit=等级上限,donate=升级要求捐献,dataType=效果数据类型,dataId=效果数据ID,percent=效果百分比,value=效果值,cd=研发时间,
local DUnionScience = {
  [1] = {id=1,relevanceId=1,grade=2,type=1,beforeId="",name="存储专家",pic=103,effect="联盟仓库每日存储上限增加",star=5,donateId=3,lvLimit=5,donate=32000,dataType=3,dataId=70,percent=0,value=20000,cd=5400},
  [2] = {id=2,relevanceId=2,grade=3,type=1,beforeId="1",name="燃气专家",pic=101,effect="燃气产量增加",star=4,donateId=6,lvLimit=20,donate=64000,dataType=3,dataId=23,percent=0.5000,value=0,cd=7200},
  [3] = {id=3,relevanceId=3,grade=3,type=1,beforeId="1",name="金属专家",pic=102,effect="金属产量增加",star=4,donateId=7,lvLimit=20,donate=64000,dataType=3,dataId=21,percent=0.5000,value=0,cd=7200},
  [4] = {id=4,relevanceId=4,grade=3,type=1,beforeId="1",name="存储专家",pic=103,effect="联盟仓库每日存储上限增加",star=3,donateId=7,lvLimit=20,donate=96000,dataType=3,dataId=70,percent=0,value=20000,cd=7200},
  [5] = {id=5,relevanceId=5,grade=3,type=1,beforeId="1",name="晶体专家",pic=104,effect="晶体产量增加",star=4,donateId=6,lvLimit=20,donate=64000,dataType=3,dataId=27,percent=0.5000,value=0,cd=7200},
  [6] = {id=6,relevanceId=6,grade=3,type=1,beforeId="1",name="能源专家",pic=105,effect="能源产量增加",star=4,donateId=5,lvLimit=20,donate=64000,dataType=3,dataId=25,percent=0.5000,value=0,cd=7200},
  [101] = {id=101,relevanceId=101,grade=1,type=2,beforeId="0",name="大联盟一",pic=107,effect="联盟人数上限增加",star=3,donateId=1,lvLimit=5,donate=64000,dataType=3,dataId=72,percent=0,value=4,cd=3600},
  [102] = {id=102,relevanceId=102,grade=1,type=2,beforeId="101",name="联盟工会",pic=108,effect="加快建筑建造升级速度",star=5,donateId=1,lvLimit=10,donate=128000,dataType=3,dataId=40,percent=0.5000,value=0,cd=3600},
  [103] = {id=103,relevanceId=103,grade=2,type=2,beforeId="101",name="联盟学院",pic=109,effect="减少科技因子消耗",star=5,donateId=4,lvLimit=10,donate=128000,dataType=3,dataId=109,percent=0.5000,value=0,cd=5400},
  [104] = {id=104,relevanceId=104,grade=1,type=2,beforeId="101",name="援助之手",pic=110,effect="增加帮助的时间",star=3,donateId=2,lvLimit=1,donate=128000,dataType=3,dataId=18,percent=0,value=20,cd=3600},
  [105] = {id=105,relevanceId=105,grade=3,type=2,beforeId="103",name="联盟工会",pic=108,effect="加快建筑建造升级速度",star=5,donateId=8,lvLimit=10,donate=256000,dataType=3,dataId=40,percent=0.5000,value=0,cd=7200},
  [106] = {id=106,relevanceId=106,grade=3,type=2,beforeId="103",name="大联盟二",pic=107,effect="联盟人数上限增加",star=4,donateId=6,lvLimit=5,donate=128000,dataType=3,dataId=72,percent=0,value=4,cd=7200},
  [107] = {id=107,relevanceId=107,grade=3,type=2,beforeId="103",name="珍贵友谊",pic=112,effect="增加帮助的时间",star=5,donateId=7,lvLimit=1,donate=64000,dataType=3,dataId=18,percent=0,value=20,cd=7200},
  [201] = {id=201,relevanceId=201,grade=1,type=3,beforeId="0",name="城防建设",pic=113,effect="缩短防御武器建造时间",star=4,donateId=2,lvLimit=5,donate=16000,dataType=3,dataId=36,percent=10.0000,value=0,cd=3600},
  [202] = {id=202,relevanceId=202,grade=1,type=3,beforeId="201",name="联盟城防",pic=114,effect="提升全体联盟成员防御武器的伤害",star=3,donateId=2,lvLimit=5,donate=12000,dataType=4,dataId=501,percent=0.5000,value=0,cd=3600},
  [203] = {id=203,relevanceId=203,grade=3,type=3,beforeId="202",name="庞大军团",pic=115,effect="增加战略中心的集结数量",star=3,donateId=5,lvLimit=20,donate=128000,dataType=3,dataId=20,percent=0,value=12500,cd=7200},
  [301] = {id=301,relevanceId=301,grade=1,type=4,beforeId="0",name="扩充队伍",pic=116,effect="增加集结进攻的队员空位",star=2,donateId=1,lvLimit=5,donate=80000,dataType=3,dataId=74,percent=0,value=2,cd=3600},
  [302] = {id=302,relevanceId=302,grade=1,type=4,beforeId="301",name="庞大军团",pic=115,effect="增加战略中心的集结数量",star=2,donateId=2,lvLimit=20,donate=48000,dataType=3,dataId=20,percent=0,value=12500,cd=5400},
  [303] = {id=303,relevanceId=303,grade=2,type=4,beforeId="302",name="护卫之王",pic=121,effect="提升全体联盟成员护卫舰的伤害",star=5,donateId=3,lvLimit=20,donate=32000,dataType=4,dataId=101,percent=0.5000,value=0,cd=5400},
  [304] = {id=304,relevanceId=304,grade=2,type=4,beforeId="302",name="截击之王",pic=117,effect="提升全体联盟成员截击舰的伤害",star=5,donateId=3,lvLimit=20,donate=32000,dataType=4,dataId=201,percent=0.5000,value=0,cd=5400},
  [305] = {id=305,relevanceId=305,grade=2,type=4,beforeId="302",name="快速集结",pic=119,effect="加速集结舰队的行军速度",star=2,donateId=3,lvLimit=10,donate=192000,dataType=3,dataId=75,percent=10.0000,value=0,cd=5400},
  [306] = {id=306,relevanceId=306,grade=2,type=4,beforeId="302",name="航母之王",pic=120,effect="提升全体联盟成员航空母舰的伤害",star=5,donateId=4,lvLimit=20,donate=32000,dataType=4,dataId=401,percent=0.5000,value=0,cd=5400},
  [307] = {id=307,relevanceId=307,grade=2,type=4,beforeId="302",name="巡洋之王",pic=118,effect="提升全体联盟成员巡洋舰的伤害",star=5,donateId=4,lvLimit=20,donate=32000,dataType=4,dataId=301,percent=0.5000,value=0,cd=5400},
  [308] = {id=308,relevanceId=308,grade=2,type=4,beforeId="305",name="护卫克星",pic=126,effect="降低联盟成员受到护卫舰的伤害",star=5,donateId=3,lvLimit=20,donate=32000,dataType=4,dataId=3101,percent=0.5000,value=0,cd=5400},
  [309] = {id=309,relevanceId=309,grade=2,type=4,beforeId="305",name="截击克星",pic=122,effect="降低联盟成员受到截击舰的伤害",star=5,donateId=4,lvLimit=20,donate=32000,dataType=4,dataId=3201,percent=0.5000,value=0,cd=5400},
  [310] = {id=310,relevanceId=310,grade=2,type=4,beforeId="305",name="航母克星",pic=125,effect="降低联盟成员受到航空母舰的伤害",star=5,donateId=4,lvLimit=20,donate=32000,dataType=4,dataId=3401,percent=0.5000,value=0,cd=5400},
  [311] = {id=311,relevanceId=311,grade=3,type=4,beforeId="305",name="巡洋克星",pic=123,effect="降低联盟成员受到巡洋舰的伤害",star=1,donateId=8,lvLimit=20,donate=32000,dataType=4,dataId=3301,percent=0.5000,value=0,cd=5400}
}
return DUnionScience