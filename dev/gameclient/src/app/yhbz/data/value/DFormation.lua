-- b_编队预设.xlsx
-- id=编号,sort=排序,grid=编队格子,dataType=要求类型,dataId=要求ID,data=要求数值,explain=文字说明,
local DFormation = {
  [1] = {id=1,sort=5,grid=1,dataType=5,dataId=27,data=8,explain="需要{1}等级{2}"},
  [2] = {id=2,sort=6,grid=2,dataType=5,dataId=27,data=10,explain="需要{1}等级{2}"},
  [3] = {id=3,sort=2,grid=3,dataType=19,dataId=3,data=9,explain="要求研发{1}"},
  [4] = {id=4,sort=3,grid=4,dataType=19,dataId=3,data=17,explain="要求研发{1}"},
  [5] = {id=5,sort=4,grid=5,dataType=19,dataId=3,data=33,explain="要求研发{1}"},
  [6] = {id=6,sort=1,grid=6,dataType=1,dataId=1,data=1,explain=""}
}
return DFormation