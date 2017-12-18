-- Z_战斗引导文字表.xlsx
-- id=id,x=x,y=y,width=宽度,height=高度,openType=内容,
local DFightGuide = {
  [1] = {id=1,x=640,y=88,width=776,height=26,openType="這裡是戰鬥中敵我雙方的名稱，藍方為進攻方，紅方為防守方"},
  [2] = {id=2,x=640,y=55,width=794,height=36,openType="這裡是敵我雙方的士氣，當其中一方士氣為0時，則戰鬥結束，士氣為0的一方為負方"},
  [3] = {id=3,x=640,y=20,width=730,height=40,openType="這裡是敵我雙方的戰艦數量，戰鬥中過程中戰損的戰艦會即時顯示"},
  [4] = {id=4,x=-33,y=-22,width=136,height=60,openType="如果不想觀看戰鬥，可點擊跳過按鈕直接跳過戰鬥錄影"},
  [5] = {id=5,x=640,y=360,width=800,height=400,openType="中間為戰鬥顯示區域，準備開始迎接第一場戰鬥吧"}
}
return DFightGuide