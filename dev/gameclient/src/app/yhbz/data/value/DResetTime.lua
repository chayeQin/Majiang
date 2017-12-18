-- z_自动更新次数时间表.xlsx
-- id=编号,remark=文本备注,type=类型,cd=时间间隔,
local DResetTime = {
  [1] = {id=1,remark="星际商人重置时间",type=1,cd=1},
  [2] = {id=2,remark="星际商人物品重新刷新时间",type=1,cd=1},
  [3] = {id=3,remark="锻造加速重置时间",type=1,cd=1},
  [4] = {id=4,remark="玩家可许愿重置时间",type=1,cd=1}
}
return DResetTime