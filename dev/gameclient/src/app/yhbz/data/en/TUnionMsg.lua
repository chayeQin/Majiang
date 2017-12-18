-- Type_联盟消息文字表.xlsx
-- id=id,key=key,data=data,
local TUnionMsg = {
  [1] = {id=1,key="exit_union_msg",data="{1} just quitted Federation"},
  [2] = {id=2,key="join_union_msg",data="{1} just joined Federation"},
  [3] = {id=3,key="atk_main_city",data="{1}'s Fortress({2},{3}) is plundered by {4}."},
  [4] = {id=4,key="atk_resource",data="The {2}({3},{4}) occupied by {1} is taken by {5} and {6}."},
  [5] = {id=5,key="place",data="{1} just placed {2}."},
  [6] = {id=6,key="science_study",data="{1} just started research on Federation Technology: {2}."},
  [7] = {id=7,key="black_knight",data="{1}'s Fortress is destroyed by Chaos Warship."},
  [8] = {id=8,key="union_mark",data="Attention! The Leader just labeled a location: X:{1} Y:{2}."},
  [9] = {id=9,key="union_kick",data="{1} kicked {2} out of the Federation."},
  [100] = {id=100,key="notice",data="Join us and build together tomorrow!"}
}
return TUnionMsg