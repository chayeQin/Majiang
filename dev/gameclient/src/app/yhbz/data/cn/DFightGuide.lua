-- Z_战斗引导文字表.xlsx
-- id=id,x=x,y=y,width=宽度,height=高度,openType=内容,
local DFightGuide = {
  [1] = {id=1,x=640,y=88,width=776,height=26,openType="这里是战斗中敌我双方的名称，蓝方为进攻方，红方为防守方"},
  [2] = {id=2,x=640,y=55,width=794,height=36,openType="这里是敌我双方的士气，当其中一方士气为0时，则战斗结束，士气为0的一方为负方"},
  [3] = {id=3,x=640,y=20,width=730,height=40,openType="这里是敌我双方的战舰数量，战斗中过程中战损的战舰会实时显示"},
  [4] = {id=4,x=-33,y=-22,width=136,height=60,openType="如果不想观看战斗，可点击跳过按钮直接跳过战斗录像"},
  [5] = {id=5,x=640,y=360,width=800,height=400,openType="中间为战斗显示区域，准备开始迎接第一场战斗吧"}
}
return DFightGuide