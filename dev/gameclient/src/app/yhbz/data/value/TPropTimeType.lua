-- 游戏资源表.xlsx
-- id=id,key=key,data=data,
local TPropTimeType = {
  [1] = {id=1,key="cd_all",data="可运用去所有通用时间减少"},
  [2] = {id=2,key="cd_build",data="只能建筑时间减少"},
  [3] = {id=3,key="cd_create",data="只能造舰时间减少"},
  [4] = {id=4,key="cd_wounded",data="只能损舰恢复时间减少"},
  [5] = {id=5,key="cd_research",data="只能科研所研发时间减少"},
  [6] = {id=6,key="cd_trap",data="防御塔制造时间减少"},
  [7] = {id=7,key="cd_march_one",data="减少一支舰队的航行时间"},
  [8] = {id=8,key="cd_march_all",data="减少所有舰队的航行时间"},
  [9] = {id=9,key="cd_recall_one",data="快速召回一支舰队"},
  [10] = {id=10,key="cd_recall_all",data="快速召回集结舰队"},
  [11] = {id=11,key="cd_reduce_force_equip",data="减少锻造装备需要的时间"}
}
return TPropTimeType