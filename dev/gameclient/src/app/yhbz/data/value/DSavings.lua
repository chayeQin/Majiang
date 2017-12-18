-- C_储蓄计划数值表.xlsx
-- id=ID,name=存款名称,condition=购买条件,itemType=消耗类型,itemId=消耗ID,min=最低数量,max=最大数量,scale=获利比例,day=返还天数,
local DSavings = {
  [1] = {id=1,name="1天存款",condition=1,itemType=5,itemId=1000,min=1000,max=1500,scale=7,day=1},
  [2] = {id=2,name="7天存款",condition=0,itemType=5,itemId=1000,min=1000,max=1500,scale=7,day=7},
  [3] = {id=3,name="15天存款",condition=0,itemType=5,itemId=1000,min=1000,max=1500,scale=20,day=15},
  [4] = {id=4,name="30天存款",condition=0,itemType=5,itemId=1000,min=1000,max=1500,scale=50,day=30}
}
return DSavings