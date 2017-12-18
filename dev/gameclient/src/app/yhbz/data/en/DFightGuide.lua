-- Z_战斗引导文字表.xlsx
-- id=id,x=x,y=y,width=宽度,height=高度,openType=内容,
local DFightGuide = {
  [1] = {id=1,x=640,y=88,width=776,height=26,openType="Here is the name of the battle between two sides, the blue side for the offensive, defensive side is red."},
  [2] = {id=2,x=640,y=55,width=794,height=36,openType="Here is the morale of both sides, when one party morale is 0, then the battle ends. The 0 morale part lost."},
  [3] = {id=3,x=640,y=20,width=730,height=40,openType="Here is the number of warships on both sides of the enemy. Damaged warships number will be displayerd during battle."},
  [4] = {id=4,x=-33,y=-22,width=136,height=60,openType="Don't want to watch the battle? Click the skip button."},
  [5] = {id=5,x=640,y=360,width=800,height=400,openType="The center area dispalys battle, ready to begin the first battle."}
}
return DFightGuide