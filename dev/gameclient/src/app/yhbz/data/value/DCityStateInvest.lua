-- C_城邦投资表.xlsx
-- id=ID,value=货币价值,itemType=消耗类型,itemId=消耗ID,itemCount=单次最大投资额度,cd=单次投资CD,flag=是否可自定义数量,
local DCityStateInvest = {
  [1] = {id=1,value=2,itemType=5,itemId=1,itemCount=12500,cd=720,flag=0},
  [2] = {id=2,value=2,itemType=5,itemId=2,itemCount=12500,cd=720,flag=0},
  [3] = {id=3,value=10,itemType=5,itemId=3,itemCount=2500,cd=720,flag=0},
  [4] = {id=4,value=50,itemType=5,itemId=4,itemCount=500,cd=720,flag=0},
  [5] = {id=5,value=1250,itemType=5,itemId=1000,itemCount=20,cd=0,flag=1},
  [6] = {id=6,value=25,itemType=5,itemId=100,itemCount=1000,cd=0,flag=1}
}
return DCityStateInvest