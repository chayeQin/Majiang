-- l_联盟科技开启条件.xlsx
-- id=编号,lv=级别,pic=图片ID,sumLv=开启需要科技能等级之和,point1=初级捐献获得科技点,point2=中级捐献获得科技点,point3=高级捐献获得科技点,
local DUnionScienceOpen = {
  [1] = {id=1,lv=1,pic=1,sumLv=0,point1=40,point2=200,point3=1000},
  [2] = {id=2,lv=2,pic=2,sumLv=8,point1=100,point2=500,point3=2500},
  [3] = {id=3,lv=3,pic=3,sumLv=77,point1=200,point2=1000,point3=5000}
}
return DUnionScienceOpen