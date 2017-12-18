-- z_自动更新次数时间表.xlsx
-- id=编号,remark=文本备注,type=类型,cd=时间间隔,count=重置为多少次/数量,
local DUpdateTime = {
  [1] = {id=1,remark="星际商人重置时间/以刷新次数",type=1,cd=1,count=0},
  [2] = {id=2,remark="星际商人物品重新刷新时间/个数",type=1,cd=1,count=4},
  [3] = {id=3,remark="锻造加速重置时间/可加速次数",type=1,cd=1,count=20},
  [4] = {id=4,remark="玩家可许愿重置时间/可许愿次数",type=1,cd=1,count=200}
}
return DUpdateTime