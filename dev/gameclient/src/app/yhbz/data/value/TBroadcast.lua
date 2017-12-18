-- g_广播公告配置表.xlsx
-- id=id,key=key,data=data,
local TBroadcast = {
  [1] = {id=1,key="equip_quality",data="玩家锻造装备出需求品质的装备时，触发广播公告"},
  [2] = {id=2,key="mecha_steps",data="玩家机甲进阶到需求等阶时，触发广播公告"},
  [3] = {id=3,key="citystate_rank",data="超越其他玩家成为城邦需求名次时，触发广播公告"},
  [4] = {id=4,key="age_lv",data="玩家时代升级到需求时代等级时，触发广播公告"},
  [5] = {id=5,key="hboss_union_rank",data="获得时空大战第N名联盟，时空大战结束时触发广播公告"},
  [6] = {id=6,key="hboss_player_rank",data="获得时空大战第N名玩家，时空大战结束时触发广播公告"},
  [7] = {id=7,key="match_stage_rank",data="获得限时比赛阶段排名第N名玩家，每个阶段结束时触发广播公告"},
  [8] = {id=8,key="match_total_rank",data="获得限时比赛总排名第N名玩家，限时比赛结束时触发广播公告"},
  [9] = {id=9,key="web_monster_union_rank",data="获得外敌入侵活动第N名联盟，外敌入侵结束时触发广播公告"},
  [10] = {id=10,key="web_monster_player_rank",data="获得外敌入侵活动第N名玩家，外敌入侵结束时触发广播公告"},
  [11] = {id=11,key="web_answer_rank",data="获得答题活动第N名玩家，答题活动结束时触发广播公告"},
  [12] = {id=12,key="vip_lv",data="玩家vip等级提升到N级时，触发广播公告"},
  [13] = {id=13,key="monster_lv",data="玩家首次击杀需求等级星际海盗时，触发广播公告"},
  [14] = {id=14,key="red_packet",data="玩法发放红包后，触发广播公告"},
  [15] = {id=15,key="kingdom_open",data="王座争夺战开启时，触发广播公告"},
  [16] = {id=16,key="kingdom_office",data="任命官职时，触发广播公告"},
  [17] = {id=17,key="kingdom_occupy",data="王座争夺战期间，成功占领星际堡垒时，触发广播公告"},
  [18] = {id=18,key="web_gift",data="玩家购买了web礼包时，触发广播公告"},
  [19] = {id=19,key="month_card",data="玩家购买了月卡时，触发广播公告"},
  [20] = {id=20,key="special_gift",data="玩家购买了特殊礼包时，触发广播公告"},
  [21] = {id=21,key="king_login",data="当星际霸主上线时，触发广播公告"},
  [22] = {id=22,key="pack",data="常规礼包"},
  [23] = {id=23,key="union_boss_killed",data="联盟boss被击杀时，触发广播公告"},
  [24] = {id=24,key="jewel_snatch",data="钻石夺宝抽中领袖成品时，触发广播公告"}
}
return TBroadcast