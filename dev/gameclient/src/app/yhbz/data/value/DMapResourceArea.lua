-- s_世界地图资源区域划分.xlsx
-- id=编号,tab=资源区域编号,startPoint=半径初始点,endPoint=半径起始点,minLv=资源点最小等级,maxLv=资源点最大等级,
local DMapResourceArea = {
  [1] = {id=1,tab=1,startPoint=1,endPoint=25,minLv=8,maxLv=8},
  [2] = {id=2,tab=2,startPoint=26,endPoint=100,minLv=4,maxLv=7},
  [3] = {id=3,tab=3,startPoint=101,endPoint=200,minLv=3,maxLv=5},
  [4] = {id=4,tab=4,startPoint=201,endPoint=300,minLv=2,maxLv=4},
  [5] = {id=5,tab=5,startPoint=301,endPoint=400,minLv=1,maxLv=3}
}
return DMapResourceArea