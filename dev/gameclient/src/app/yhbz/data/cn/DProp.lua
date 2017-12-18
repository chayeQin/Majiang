-- d_道具可使用表数值文字表.xlsx
-- id=编号,name=名称,desc=描述,
local DProp = {
  [1001] = {id=1001,name="金属*1000",desc="使用后可获得1000金属"},
  [1002] = {id=1002,name="金属*3000",desc="使用后可获得3000金属"},
  [1003] = {id=1003,name="金属*5000",desc="使用后可获得5000金属"},
  [1004] = {id=1004,name="金属*10000",desc="使用后可获得10000金属"},
  [1005] = {id=1005,name="金属*30000",desc="使用后可获得30000金属"},
  [1006] = {id=1006,name="金属*50000",desc="使用后可获得50000金属"},
  [1007] = {id=1007,name="金属*100000",desc="使用后可获得100000金属"},
  [1008] = {id=1008,name="金属*150000",desc="使用后可获得150000金属"},
  [1009] = {id=1009,name="金属*500000",desc="使用后可获得500000金属"},
  [1010] = {id=1010,name="金属*1000000",desc="使用后可获得1000000金属"},
  [1011] = {id=1011,name="金属*1500000",desc="使用后可获得1500000金属"},
  [1012] = {id=1012,name="金属*80000",desc="使用后可获得80000金属"},
  [1013] = {id=1013,name="金属*40000",desc="使用后可获得40000金属"},
  [1101] = {id=1101,name="燃气*1000",desc="使用后可获得1000燃气"},
  [1102] = {id=1102,name="燃气*3000",desc="使用后可获得3000燃气"},
  [1103] = {id=1103,name="燃气*5000",desc="使用后可获得5000燃气"},
  [1104] = {id=1104,name="燃气*10000",desc="使用后可获得10000燃气"},
  [1105] = {id=1105,name="燃气*30000",desc="使用后可获得30000燃气"},
  [1106] = {id=1106,name="燃气*50000",desc="使用后可获得50000燃气"},
  [1107] = {id=1107,name="燃气*100000",desc="使用后可获得100000燃气"},
  [1108] = {id=1108,name="燃气*150000",desc="使用后可获得150000燃气"},
  [1109] = {id=1109,name="燃气*500000",desc="使用后可获得500000燃气"},
  [1110] = {id=1110,name="燃气*1000000",desc="使用后可获得1000000燃气"},
  [1111] = {id=1111,name="燃气*1500000",desc="使用后可获得1500000燃气"},
  [1112] = {id=1112,name="燃气*80000",desc="使用后可获得80000燃气"},
  [1113] = {id=1113,name="燃气*40000",desc="使用后可获得40000燃气"},
  [1201] = {id=1201,name="能源*160",desc="使用后可获得160能源"},
  [1202] = {id=1202,name="能源*480",desc="使用后可获得480能源"},
  [1203] = {id=1203,name="能源*800",desc="使用后可获得800能源"},
  [1204] = {id=1204,name="能源*1600",desc="使用后可获得1600能源"},
  [1205] = {id=1205,name="能源*4800",desc="使用后可获得4800能源"},
  [1206] = {id=1206,name="能源*8000",desc="使用后可获得8000能源"},
  [1207] = {id=1207,name="能源*16000",desc="使用后可获得16000能源"},
  [1208] = {id=1208,name="能源*25000",desc="使用后可获得25000能源"},
  [1209] = {id=1209,name="能源*80000",desc="使用后可获得80000能源"},
  [1210] = {id=1210,name="能源*160000",desc="使用后可获得160000能源"},
  [1211] = {id=1211,name="能源*250000",desc="使用后可获得250000能源"},
  [1212] = {id=1212,name="能源*300",desc="使用后可获得300能源"},
  [1213] = {id=1213,name="能源*600",desc="使用后可获得600能源"},
  [1214] = {id=1214,name="能源*6000",desc="使用后可获得6000能源"},
  [1301] = {id=1301,name="晶体*40",desc="使用后可获得40晶体"},
  [1302] = {id=1302,name="晶体*120",desc="使用后可获得120晶体"},
  [1303] = {id=1303,name="晶体*150",desc="使用后可获得150晶体"},
  [1304] = {id=1304,name="晶体*400",desc="使用后可获得400晶体"},
  [1305] = {id=1305,name="晶体*1200",desc="使用后可获得1200晶体"},
  [1306] = {id=1306,name="晶体*2000",desc="使用后可获得2000晶体"},
  [1307] = {id=1307,name="晶体*4000",desc="使用后可获得4000晶体"},
  [1308] = {id=1308,name="晶体*6250",desc="使用后可获得6250晶体"},
  [1309] = {id=1309,name="晶体*20000",desc="使用后可获得20000晶体"},
  [1310] = {id=1310,name="晶体*40000",desc="使用后可获得40000晶体"},
  [1311] = {id=1311,name="晶体*62500",desc="使用后可获得62500晶体"},
  [1312] = {id=1312,name="晶体*75",desc="使用后可获得75晶体"},
  [1313] = {id=1313,name="晶体*200",desc="使用后可获得200晶体"},
  [1314] = {id=1314,name="晶体*1500",desc="使用后可获得1500晶体"},
  [1401] = {id=1401,name="钻石*5",desc="使用后可获得5钻石"},
  [1402] = {id=1402,name="钻石*10",desc="使用后可获得10钻石"},
  [1403] = {id=1403,name="钻石*20",desc="使用后可获得20钻石"},
  [1404] = {id=1404,name="钻石*50",desc="使用后可获得50钻石"},
  [1405] = {id=1405,name="钻石*100",desc="使用后可获得100钻石"},
  [1406] = {id=1406,name="钻石*1000",desc="使用后可获得1000钻石"},
  [2001] = {id=2001,name="VIP点数*10",desc="增加10 VIP点数来提升您的VIP等级"},
  [2002] = {id=2002,name="VIP点数*20",desc="增加20 VIP点数来提升您的VIP等级"},
  [2003] = {id=2003,name="VIP点数*50",desc="增加50 VIP点数来提升您的VIP等级"},
  [2004] = {id=2004,name="VIP点数*100",desc="增加100 VIP点数来提升您的VIP等级"},
  [2005] = {id=2005,name="VIP点数*200",desc="增加200 VIP点数来提升您的VIP等级"},
  [2006] = {id=2006,name="VIP点数*300",desc="增加300 VIP点数来提升您的VIP等级"},
  [2007] = {id=2007,name="VIP点数*500",desc="增加500 VIP点数来提升您的VIP等级"},
  [2008] = {id=2008,name="VIP点数*800",desc="增加800 VIP点数来提升您的VIP等级"},
  [2009] = {id=2009,name="VIP点数*1000",desc="增加1000 VIP点数来提升您的VIP等级"},
  [2201] = {id=2201,name="VIP10分钟",desc="使用后激活VIP特权10分钟"},
  [2202] = {id=2202,name="VIP30分钟",desc="使用后激活VIP特权30分钟"},
  [2203] = {id=2203,name="VIP1小时",desc="使用后激活VIP特权1小时"},
  [2204] = {id=2204,name="VIP1天",desc="使用后激活VIP特权1天"},
  [2205] = {id=2205,name="VIP7天",desc="使用后激活VIP特权7天"},
  [2206] = {id=2206,name="VIP30天",desc="使用后激活VIP特权30天"},
  [2401] = {id=2401,name="战舰补给箱 I",desc="使用后获得各类的舰艇各100个"},
  [2402] = {id=2402,name="战舰补给箱 II",desc="使用后获得各类的舰艇各200个"},
  [2501] = {id=2501,name="联邦币*500",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2502] = {id=2502,name="联邦币*1000",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2503] = {id=2503,name="联邦币*1500",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2504] = {id=2504,name="联邦币*3000",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2505] = {id=2505,name="联邦币*10000",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2506] = {id=2506,name="联邦币*100000",desc="使用后获得联邦币，转动休息站-幸运转盘时，需要消耗联邦币"},
  [2601] = {id=2601,name="精晶币*1",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2602] = {id=2602,name="精晶币*5",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2603] = {id=2603,name="精晶币*10",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2604] = {id=2604,name="精晶币*50",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2605] = {id=2605,name="精晶币*100",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2606] = {id=2606,name="精晶币*1000",desc="使用后获得精晶币，在幸运转盘-幸运宝箱中，翻开奖励需要消耗精晶币"},
  [2701] = {id=2701,name="普通材料包",desc="使用后随机获得一个白色，或者绿色材料"},
  [2702] = {id=2702,name="小材料包",desc="使用后随机获得一个白色，或者绿色，或者蓝色材料"},
  [2703] = {id=2703,name="精良材料包",desc="使用后随机获得一个绿色，或者蓝色材料"},
  [2799] = {id=2799,name="外星建材包",desc="使用后可随机获得三件外星建材，外星建材可在星际商店兑换道具奖励"},
  [2801] = {id=2801,name="体力药水*10",desc="使用后恢复指挥官体力值"},
  [2802] = {id=2802,name="体力药水*50",desc="使用后恢复指挥官体力值"},
  [2901] = {id=2901,name="指挥官经验*60",desc="使用后使指挥官立即获得经验"},
  [2902] = {id=2902,name="指挥官经验*100",desc="使用后使指挥官立即获得经验"},
  [2903] = {id=2903,name="指挥官经验*300",desc="使用后使指挥官立即获得经验"},
  [2904] = {id=2904,name="指挥官经验*500",desc="使用后使指挥官立即获得经验"},
  [2905] = {id=2905,name="指挥官经验*1000",desc="使用后使指挥官立即获得经验"},
  [2906] = {id=2906,name="指挥官经验*5000",desc="使用后使指挥官立即获得经验"},
  [2907] = {id=2907,name="指挥官经验*20000",desc="使用后使指挥官立即获得经验"},
  [3001] = {id=3001,name="祝福",desc="使用祝福后可增加一次免费许愿，该许愿在被使用前会一直保留。在文明遗迹优先使用每日赠送的许愿次数。"},
  [3101] = {id=3101,name="钢材 50",desc="使用后可获得50钢材"},
  [3102] = {id=3102,name="钢材*100",desc="使用后可获得100钢材"},
  [3103] = {id=3103,name="钢材*400",desc="使用后可获得400钢材"},
  [3104] = {id=3104,name="钢材*1500",desc="使用后可获得1500钢材"},
  [3105] = {id=3105,name="钢材*5000",desc="使用后可获得5000钢材"},
  [3106] = {id=3106,name="钢材*8000",desc="使用后可获得8000钢材"},
  [3107] = {id=3107,name="钢材*10000",desc="使用后可获得10000钢材"},
  [3108] = {id=3108,name="钢材*15000",desc="使用后可获得15000钢材"},
  [3109] = {id=3109,name="钢材*50000",desc="使用后可获得50000钢材"},
  [3401] = {id=3401,name="1级资源箱",desc="使用后可获得金属和燃气资源"},
  [3402] = {id=3402,name="2级资源箱",desc="使用后可获得金属、燃气、能源资源"},
  [3403] = {id=3403,name="3级资源箱",desc="使用后可获得金属、燃气、能源、晶体资源"},
  [3404] = {id=3404,name="4级资源箱",desc="使用后可获得金属、燃气、能源、晶体资源"},
  [3405] = {id=3405,name="5级资源箱",desc="使用后可获得金属、燃气、能源、晶体资源"},
  [3501] = {id=3501,name="小型战争宝箱",desc="使用后获得12小时攻击加成、12小时防御加成、25%出航上限提升道具"},
  [3601] = {id=3601,name="小型防御宝箱",desc="使用后获得战争守护24小时、随机迁城道具"},
  [3801] = {id=3801,name="新手礼包",desc="使用后可获得1小时通用加速、5分钟通用加速、1级资源箱、体力药水、VIP30分钟道具"},
  [3901] = {id=3901,name="机甲材料包",desc="使用后可获得机甲材料"},
  [4001] = {id=4001,name="1级装备图纸随机包",desc="使用后可获得1级任意部位装备图纸"},
  [4002] = {id=4002,name="10级装备图纸随机包",desc="使用后可获得10级任意部位装备图纸"},
  [4003] = {id=4003,name="20级装备图纸随机包",desc="使用后可获得20级任意部位装备图纸"},
  [4004] = {id=4004,name="30级装备图纸随机包",desc="使用后可获得30级任意部位装备图纸"},
  [4005] = {id=4005,name="40级装备图纸随机包",desc="使用后可获得40级任意部位装备图纸"},
  [4006] = {id=4006,name="50级装备图纸随机包",desc="使用后可获得50级任意部位装备图纸"},
  [4007] = {id=4007,name="60级装备图纸随机包",desc="使用后可获得60级任意部位装备图纸"},
  [4008] = {id=4008,name="70级装备图纸随机包",desc="使用后可获得70级任意部位装备图纸"},
  [4009] = {id=4009,name="80级装备图纸随机包",desc="使用后可获得80级任意部位装备图纸"},
  [4010] = {id=4010,name="90级装备图纸随机包",desc="使用后可获得90级任意部位装备图纸"},
  [4011] = {id=4011,name="100级装备图纸随机包",desc="使用后可获得100级任意部位装备图纸"},
  [5000] = {id=5000,name="投资奖励箱",desc="使用后可随机获得道具"},
  [5101] = {id=5101,name="能量*10",desc="使用后可获得10点巨炮能量"},
  [5102] = {id=5102,name="能量*20",desc="使用后可获得20点巨炮能量"},
  [5103] = {id=5103,name="能量*30",desc="使用后可获得30点巨炮能量"},
  [5104] = {id=5104,name="能量*50",desc="使用后可获得50点巨炮能量"},
  [5105] = {id=5105,name="能量*80",desc="使用后可获得80点巨炮能量"},
  [5106] = {id=5106,name="能量*100",desc="使用后可获得100点巨炮能量"},
  [5501] = {id=5501,name="绿色装甲包",desc="装甲材料包，打开即可以获得1件绿色巨炮装甲"},
  [5502] = {id=5502,name="蓝色装甲包",desc="装甲材料包，打开即可以获得1件蓝色巨炮装甲"},
  [5503] = {id=5503,name="紫色装甲包",desc="装甲材料包，打开即可以获得1件紫色巨炮装甲"},
  [5504] = {id=5504,name="红色装甲包",desc="装甲材料包，打开即可以获得1件红色巨炮装甲"},
  [5601] = {id=5601,name="装甲奖励宝盒Lv.1",desc="装甲随机宝箱，打开即可随机获得一个绿色或蓝色的装甲包"},
  [5602] = {id=5602,name="装甲奖励宝盒Lv.2",desc="装甲随机宝箱，打开即可随机获得一个绿色或蓝色的装甲包"},
  [5603] = {id=5603,name="装甲奖励宝盒Lv.3",desc="装甲随机宝箱，打开即可随机获得一个绿色、蓝色或紫色的装甲包"},
  [5604] = {id=5604,name="装甲奖励宝盒Lv.4",desc="装甲随机宝箱，打开即可随机获得一个绿色、蓝色、紫色或红色的装甲包"},
  [10001] = {id=10001,name="姜饼人",desc="圣诞节道具，可在圣诞兑换活动中兑换丰厚奖励"},
  [10002] = {id=10002,name="圣诞棒",desc="圣诞节道具，可在圣诞兑换活动中兑换丰厚奖励"},
  [10003] = {id=10003,name="圣诞袜",desc="圣诞节道具，可在圣诞兑换活动中兑换丰厚奖励"},
  [10004] = {id=10004,name="火鸡",desc="圣诞节道具，可在圣诞兑换活动中兑换丰厚奖励"},
  [10005] = {id=10005,name="圣诞帽",desc="圣诞节道具，可在圣诞兑换活动中兑换丰厚奖励"},
  [10006] = {id=10006,name="圣诞礼包",desc="圣诞节礼包，使用后可获得大量丰厚道具奖励"},
  [10007] = {id=10007,name="每日邀请奖励礼包",desc="邀请礼包，使用后可随机获得一件道具"},
  [10008] = {id=10008,name="鞭炮",desc="春节节道具，可在春节兑换活动中兑换丰厚奖励"},
  [10009] = {id=10009,name="春联",desc="春节节道具，可在春节兑换活动中兑换丰厚奖励"},
  [10010] = {id=10010,name="灯笼",desc="元宵节道具，可在元宵兑换活动中兑换丰厚奖励"},
  [10011] = {id=10011,name="汤圆",desc="元宵节道具，可在元宵兑换活动中兑换丰厚奖励"},
  [10012] = {id=10012,name="苹果",desc="春节节道具，可在春节兑换活动中兑换丰厚奖励"},
  [10013] = {id=10013,name="元宝",desc="春节节道具，可在春节兑换活动中兑换丰厚奖励"},
  [10014] = {id=10014,name="桔子",desc="元宵节道具，可在元宵兑换活动中兑换丰厚奖励"},
  [10015] = {id=10015,name="大福",desc="春节节道具，可在春节兑换活动中兑换丰厚奖励"},
  [10016] = {id=10016,name="铜钱",desc="元宵节道具，可在元宵兑换活动中兑换丰厚奖励"},
  [10017] = {id=10017,name="梨子",desc="元宵节道具，可在元宵兑换活动中兑换丰厚奖励"},
  [10018] = {id=10018,name="联盟宝箱",desc="购买联盟分享礼包获得的道具，开启可随机获得一件道具奖励"},
  [10019] = {id=10019,name="在线奖励礼包",desc="在线奖励终极礼包，开启可随机获得多件道具奖励"},
  [10020] = {id=10020,name="核子能",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10021] = {id=10021,name="氢动能",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10022] = {id=10022,name="红外线",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10023] = {id=10023,name="星能源",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10024] = {id=10024,name="反应炉",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10025] = {id=10025,name="太空铝",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10026] = {id=10026,name="星级管",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10027] = {id=10027,name="增压轮",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10028] = {id=10028,name="终端机",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10029] = {id=10029,name="能源塔",desc="外星舰队生产战舰专用建材，可以在星际商店兑换各种游戏道具。"},
  [10030] = {id=10030,name="竞技场宝箱",desc="竞技场宝箱，可获得随机奖励"},
  [20001] = {id=20001,name="联盟钻石红包",desc="使用道具后，会在联盟聊天频道开启联盟钻石红包，本联盟玩家可以领取，领取后可随机获得不同数额的奖励！"},
  [21001] = {id=21001,name="世界钻石红包",desc="使用道具后，会在世界聊天频道开启世界钻石红包，本星系玩家可以领取，领取后可随机获得不同数额的奖励！"}
}
return DProp