-- Type_联盟消息文字表.xlsx
-- id=id,key=key,data=data,
local TUnionMsg = {
  [1] = {id=1,key="exit_union_msg",data="{1}退出了聯盟"},
  [2] = {id=2,key="join_union_msg",data="{1}加入了聯盟"},
  [3] = {id=3,key="atk_main_city",data="{1}的堡壘({2},{3})被{4}掠奪了。"},
  [4] = {id=4,key="atk_resource",data="{1}佔領的{2}({3},{4})被{5}{6}搶走了。"},
  [5] = {id=5,key="place",data="{1}放置了{2}。"},
  [6] = {id=6,key="science_study",data="{1}開始了聯盟科技{2}的研究。"},
  [7] = {id=7,key="black_knight",data="{1}的堡壘被時空戰艦攻破了。"},
  [8] = {id=8,key="union_mark",data="請注意，盟主標記了座標：X:{1} Y:{2}"},
  [9] = {id=9,key="union_kick",data="{1}將{2}踢出了聯盟"},
  [100] = {id=100,key="notice",data="加入我們，一起打造明日輝煌！"}
}
return TUnionMsg