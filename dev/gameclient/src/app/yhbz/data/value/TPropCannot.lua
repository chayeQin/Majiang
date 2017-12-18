-- 游戏资源表.xlsx
-- id=id,key=key,data=data,
local TPropCannot = {
  [1] = {id=1,key="metal",data="金属"},
  [2] = {id=2,key="gas",data="燃气"},
  [3] = {id=3,key="energy",data="能源"},
  [4] = {id=4,key="crystal",data="晶体"},
  [5] = {id=5,key="strategy_map",data="战略地图"},
  [6] = {id=6,key="shell",data="星际炮弹"},
  [7] = {id=7,key="copper",data="联邦币"},
  [8] = {id=8,key="dragon",data="精晶币"},
  [9] = {id=9,key="science_exp",data="科技经验"},
  [11] = {id=11,key="physical",data="体力"},
  [12] = {id=12,key="blessing",data="祝福"},
  [13] = {id=13,key="silver",data="银币"},
  [14] = {id=14,key="tong_shuai",data="统帅等级"},
  [15] = {id=15,key="military_lv",data="军衔等级"},
  [16] = {id=16,key="military",data="军功值"},
  [17] = {id=17,key="civilization_lv",data="文明等级"},
  [18] = {id=18,key="boom",data="繁荣度"},
  [19] = {id=19,key="kingdom_contribute",data="王国贡献"},
  [20] = {id=20,key="tong_shuai_order",data="统帅令"},
  [21] = {id=21,key="player_lv",data="指挥官等级"},
  [22] = {id=22,key="monster_plan",data="怪物进度"},
  [23] = {id=23,key="metal_yield",data="金属当前产量"},
  [24] = {id=24,key="gas_yield",data="燃气当前产量"},
  [25] = {id=25,key="energy_yield",data="能源当前产量"},
  [26] = {id=26,key="crystal_yield",data="晶体当前产量"},
  [27] = {id=27,key="vip_lv",data="VIP等级"},
  [28] = {id=28,key="battleId",data="战役进度"},
  [29] = {id=29,key="science_prosperity",data="科研值"},
  [30] = {id=30,key="pay_num",data="充值金额"},
  [31] = {id=31,key="register_day",data="注册天数"},
  [32] = {id=32,key="city_state",data="城邦令"},
  [33] = {id=33,key="force_fight",data="舰队战斗力"},
  [34] = {id=34,key="traps_fight",data="防御塔战斗力"},
  [35] = {id=35,key="metal_all",data="金属资源总和"},
  [36] = {id=36,key="gas_all",data="燃气资源总和"},
  [37] = {id=37,key="energy_all",data="能源资源总和"},
  [38] = {id=38,key="crystal_all",data="晶体资源总和"},
  [39] = {id=39,key="mecha_all_lv",data="机甲等级和"},
  [40] = {id=40,key="city_state_all_invest",data="城邦投资值和"},
  [41] = {id=41,key="equip_all_lv",data="已穿戴装备的等级和"},
  [42] = {id=42,key="equip_all_quality",data="已穿戴装备的品质和"},
  [43] = {id=43,key="wounded_fight",data="损舰战斗力"},
  [44] = {id=44,key="equip_all_count",data="锻造装备次数"},
  [45] = {id=45,key="locke_factory_create_forces_count",data="洛克工厂造兵次数"},
  [46] = {id=46,key="production_materials_count",data="机甲材料制作数量"},
  [47] = {id=47,key="combat_center_create_forces_count",data="战备中心造兵次数"},
  [48] = {id=48,key="map_march_monster",data="打怪次数"},
  [49] = {id=49,key="map_march_resource",data="采集次数"},
  [50] = {id=50,key="commander_fight",data="指挥官战斗力"},
  [51] = {id=51,key="build_fight",data="建筑战斗力"},
  [52] = {id=52,key="science_fight",data="科技战斗力"},
  [53] = {id=53,key="equip_fight",data="装备战斗力"},
  [54] = {id=54,key="machine_key",data="机械钥匙"},
  [55] = {id=55,key="pay_score",data="充值积分"},
  [56] = {id=56,key="active_point",data="活跃度"},
  [57] = {id=57,key="challenge",data="挑战书"},
  [58] = {id=58,key="science_factor",data="科技因子"},
  [59] = {id=59,key="cellar_metal",data="地窖金属"},
  [60] = {id=60,key="cellar_gas",data="地窖燃气"},
  [61] = {id=61,key="cellar_energy",data="地窖能源"},
  [62] = {id=62,key="cellar_crystal",data="地窖晶体"},
  [63] = {id=63,key="age_lv",data="时代等级"},
  [64] = {id=64,key="kingdom_silver",data="国王银币"},
  [65] = {id=65,key="commander_lv_fight",data="指挥官等级战斗力"},
  [66] = {id=66,key="civilization_fight",data="文明战斗力"},
  [67] = {id=67,key="military_fight",data="军衔战斗力"},
  [68] = {id=68,key="mecha_fight",data="机甲战斗力"},
  [69] = {id=69,key="tongshuai_fight",data="统帅战斗力"},
  [70] = {id=70,key="union_initiative_skill1",data="玫红元素"},
  [71] = {id=71,key="union_initiative_skill2",data="淡黄元素"},
  [72] = {id=72,key="union_initiative_skill3",data="青绿元素"},
  [73] = {id=73,key="union_initiative_skill4",data="蔚蓝元素"},
  [74] = {id=74,key="union_initiative_skill5",data="猩红元素"},
  [75] = {id=75,key="union_initiative_skill6",data="合金元素"},
  [76] = {id=76,key="union_skill_donate_item",data="联盟技能捐献道具"},
  [77] = {id=77,key="arena_integral",data="竞技场积分"},
  [78] = {id=78,key="arena_honor",data="竞技场荣誉"},
  [79] = {id=79,key="arena_honor_lv",data="竞技场荣誉等级"},
  [80] = {id=80,key="wisdom",data="智能芯片"},
  [81] = {id=81,key="pebble",data="智能水晶"},
  [82] = {id=82,key="cannon_energy",data="巨炮能量"},
  [83] = {id=83,key="poukim",data="铂晶石"},
  [84] = {id=84,key="titanium_alloy",data="钛合金"},
  [85] = {id=85,key="cannon_exp",data="巨炮经验"},
  [86] = {id=86,key="cannon_fight",data="巨炮战斗力"},
  [87] = {id=87,key="task_chapter_id",data="章节任务章节Id"},
  [100] = {id=100,key="steel",data="钢材"},
  [200] = {id=200,key="vip_exp",data="vip经验"},
  [201] = {id=201,key="svip_exp",data="Svip经验"},
  [210] = {id=210,key="vip_day",data="vip天数"},
  [211] = {id=211,key="svip_day",data="Svip天数"},
  [300] = {id=300,key="union_member_integral",data="联盟荣誉"},
  [1000] = {id=1000,key="jewel",data="钻石"},
  [2000] = {id=2000,key="exp",data="指挥官经验"},
  [10001] = {id=10001,key="map_search_count",data="地图搜索次数"},
  [20001] = {id=20001,key="status_rescue",data="救援状态"},
  [20002] = {id=20002,key="status_protect",data="保护状态"},
  [20003] = {id=20003,key="status_force_limit",data="舰队出航上限"},
  [20004] = {id=20004,key="status_resources_speed",data="疯狂采集状态"},
  [20005] = {id=20005,key="status_cd_speed",data="时间防御塔状态"},
  [10001001] = {id=10001001,key="queue_card",data="黄金队列卡"},
  [10001002] = {id=10001002,key="jewel_card",data="特惠钻石卡"},
  [10001003] = {id=10001003,key="resource_card",data="特惠城建卡"},
  [20000001] = {id=20000001,key="red_pack_id_1",data="188红包"},
  [20000002] = {id=20000002,key="red_pack_id_2",data="888红包"},
  [20000003] = {id=20000003,key="red_pack_id_3",data="1888红包"},
  [20000004] = {id=20000004,key="red_pack_id_4",data="3888红包"}
}
return TPropCannot