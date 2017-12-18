-- Type_联盟消息.xlsx
-- id=id,key=key,data=data,
local TUnionMsg = {
  [1] = {id=1,key="exit_union_msg",data="{1}退出了联盟"},
  [2] = {id=2,key="join_union_msg",data="{1}加入了联盟"},
  [3] = {id=3,key="atk_main_city",data="{1}的堡垒({2},{3})被{4}掠夺了。"},
  [4] = {id=4,key="atk_resource",data="{1}占领的{2}({3},{4})被{5}{6}抢走了。"},
  [5] = {id=5,key="place",data="{1}放置了{2}。"},
  [6] = {id=6,key="science_study",data="{1}开始了联盟科技{2}的研究。"},
  [7] = {id=7,key="black_knight",data="{1}的堡垒被时空战舰攻破了。"},
  [8] = {id=8,key="union_mark",data="请注意，盟主标记了坐标：X:{1} Y:{2}"},
  [9] = {id=9,key="union_kick",data="{1}将{2}踢出了联盟"},
  [11] = {id=11,key="action_initiative_skill",data="{1}使用了{2}技能！"},
  [12] = {id=12,key="union_boss_killed",data="{1}成功击杀了{2}级联盟boss！"},
  [100] = {id=100,key="notice",data="加入我们，一起打造明日辉煌！"}
}
return TUnionMsg