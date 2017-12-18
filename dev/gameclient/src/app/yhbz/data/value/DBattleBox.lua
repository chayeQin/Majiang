-- z_战役宝箱数据表.xlsx
-- id=编号,boxId=宝箱ID,needStar=星级要求,battleChapterId=章节ID,itemType=奖励内容类型,itemId=奖励内容ID,itemCount=奖励内容数量,
local DBattleBox = {
  [1] = {id=1,boxId=1,needStar=15,battleChapterId=1001,itemType=6,itemId=2401,itemCount=1},
  [2] = {id=2,boxId=1,needStar=15,battleChapterId=1001,itemType=6,itemId=2203,itemCount=1},
  [3] = {id=3,boxId=1,needStar=15,battleChapterId=1001,itemType=5,itemId=57,itemCount=8},
  [4] = {id=4,boxId=2,needStar=30,battleChapterId=1001,itemType=6,itemId=2401,itemCount=2},
  [5] = {id=5,boxId=2,needStar=30,battleChapterId=1001,itemType=5,itemId=20,itemCount=4},
  [6] = {id=6,boxId=2,needStar=30,battleChapterId=1001,itemType=6,itemId=4001,itemCount=4},
  [7] = {id=7,boxId=3,needStar=45,battleChapterId=1001,itemType=6,itemId=2401,itemCount=3},
  [8] = {id=8,boxId=3,needStar=45,battleChapterId=1001,itemType=5,itemId=20,itemCount=4},
  [9] = {id=9,boxId=3,needStar=45,battleChapterId=1001,itemType=6,itemId=1404,itemCount=1},
  [101] = {id=101,boxId=1,needStar=15,battleChapterId=1002,itemType=5,itemId=100,itemCount=1000},
  [102] = {id=102,boxId=1,needStar=15,battleChapterId=1002,itemType=6,itemId=2203,itemCount=1},
  [103] = {id=103,boxId=1,needStar=15,battleChapterId=1002,itemType=5,itemId=57,itemCount=8},
  [104] = {id=104,boxId=2,needStar=30,battleChapterId=1002,itemType=6,itemId=2401,itemCount=1},
  [105] = {id=105,boxId=2,needStar=30,battleChapterId=1002,itemType=5,itemId=20,itemCount=4},
  [106] = {id=106,boxId=2,needStar=30,battleChapterId=1002,itemType=6,itemId=4002,itemCount=4},
  [107] = {id=107,boxId=3,needStar=45,battleChapterId=1002,itemType=6,itemId=2703,itemCount=1},
  [108] = {id=108,boxId=3,needStar=45,battleChapterId=1002,itemType=5,itemId=20,itemCount=4},
  [109] = {id=109,boxId=3,needStar=45,battleChapterId=1002,itemType=6,itemId=1404,itemCount=1},
  [201] = {id=201,boxId=1,needStar=15,battleChapterId=1003,itemType=5,itemId=100,itemCount=1000},
  [202] = {id=202,boxId=1,needStar=15,battleChapterId=1003,itemType=6,itemId=2203,itemCount=1},
  [203] = {id=203,boxId=1,needStar=15,battleChapterId=1003,itemType=5,itemId=57,itemCount=8},
  [204] = {id=204,boxId=2,needStar=30,battleChapterId=1003,itemType=5,itemId=100,itemCount=1500},
  [205] = {id=205,boxId=2,needStar=30,battleChapterId=1003,itemType=5,itemId=20,itemCount=5},
  [206] = {id=206,boxId=2,needStar=30,battleChapterId=1003,itemType=6,itemId=4002,itemCount=4},
  [207] = {id=207,boxId=3,needStar=45,battleChapterId=1003,itemType=6,itemId=2703,itemCount=2},
  [208] = {id=208,boxId=3,needStar=45,battleChapterId=1003,itemType=5,itemId=20,itemCount=5},
  [209] = {id=209,boxId=3,needStar=45,battleChapterId=1003,itemType=6,itemId=1404,itemCount=1},
  [301] = {id=301,boxId=1,needStar=15,battleChapterId=1004,itemType=5,itemId=100,itemCount=1200},
  [302] = {id=302,boxId=1,needStar=15,battleChapterId=1004,itemType=6,itemId=2203,itemCount=1},
  [303] = {id=303,boxId=1,needStar=15,battleChapterId=1004,itemType=5,itemId=57,itemCount=8},
  [304] = {id=304,boxId=2,needStar=30,battleChapterId=1004,itemType=5,itemId=100,itemCount=2000},
  [305] = {id=305,boxId=2,needStar=30,battleChapterId=1004,itemType=5,itemId=20,itemCount=5},
  [306] = {id=306,boxId=2,needStar=30,battleChapterId=1004,itemType=6,itemId=4003,itemCount=8},
  [307] = {id=307,boxId=3,needStar=45,battleChapterId=1004,itemType=6,itemId=2703,itemCount=2},
  [308] = {id=308,boxId=3,needStar=45,battleChapterId=1004,itemType=5,itemId=20,itemCount=5},
  [309] = {id=309,boxId=3,needStar=45,battleChapterId=1004,itemType=6,itemId=1404,itemCount=1},
  [401] = {id=401,boxId=1,needStar=15,battleChapterId=1005,itemType=5,itemId=100,itemCount=1500},
  [402] = {id=402,boxId=1,needStar=15,battleChapterId=1005,itemType=6,itemId=2203,itemCount=1},
  [403] = {id=403,boxId=1,needStar=15,battleChapterId=1005,itemType=5,itemId=57,itemCount=8},
  [404] = {id=404,boxId=2,needStar=30,battleChapterId=1005,itemType=5,itemId=100,itemCount=2500},
  [405] = {id=405,boxId=2,needStar=30,battleChapterId=1005,itemType=5,itemId=20,itemCount=8},
  [406] = {id=406,boxId=2,needStar=30,battleChapterId=1005,itemType=6,itemId=4003,itemCount=8},
  [407] = {id=407,boxId=3,needStar=45,battleChapterId=1005,itemType=6,itemId=2703,itemCount=2},
  [408] = {id=408,boxId=3,needStar=45,battleChapterId=1005,itemType=5,itemId=20,itemCount=8},
  [409] = {id=409,boxId=3,needStar=45,battleChapterId=1005,itemType=6,itemId=1404,itemCount=1},
  [501] = {id=501,boxId=1,needStar=15,battleChapterId=1006,itemType=5,itemId=100,itemCount=1800},
  [502] = {id=502,boxId=1,needStar=15,battleChapterId=1006,itemType=6,itemId=2203,itemCount=1},
  [503] = {id=503,boxId=1,needStar=15,battleChapterId=1006,itemType=5,itemId=57,itemCount=8},
  [504] = {id=504,boxId=2,needStar=30,battleChapterId=1006,itemType=5,itemId=100,itemCount=3000},
  [505] = {id=505,boxId=2,needStar=30,battleChapterId=1006,itemType=5,itemId=20,itemCount=8},
  [506] = {id=506,boxId=2,needStar=30,battleChapterId=1006,itemType=6,itemId=4004,itemCount=8},
  [507] = {id=507,boxId=3,needStar=45,battleChapterId=1006,itemType=6,itemId=2703,itemCount=4},
  [508] = {id=508,boxId=3,needStar=45,battleChapterId=1006,itemType=5,itemId=20,itemCount=8},
  [509] = {id=509,boxId=3,needStar=45,battleChapterId=1006,itemType=6,itemId=1404,itemCount=1},
  [601] = {id=601,boxId=1,needStar=15,battleChapterId=1007,itemType=5,itemId=100,itemCount=2100},
  [602] = {id=602,boxId=1,needStar=15,battleChapterId=1007,itemType=6,itemId=2203,itemCount=1},
  [603] = {id=603,boxId=1,needStar=15,battleChapterId=1007,itemType=5,itemId=57,itemCount=8},
  [604] = {id=604,boxId=2,needStar=30,battleChapterId=1007,itemType=5,itemId=100,itemCount=3500},
  [605] = {id=605,boxId=2,needStar=30,battleChapterId=1007,itemType=5,itemId=20,itemCount=10},
  [606] = {id=606,boxId=2,needStar=30,battleChapterId=1007,itemType=6,itemId=4004,itemCount=8},
  [607] = {id=607,boxId=3,needStar=45,battleChapterId=1007,itemType=6,itemId=2703,itemCount=4},
  [608] = {id=608,boxId=3,needStar=45,battleChapterId=1007,itemType=5,itemId=20,itemCount=10},
  [609] = {id=609,boxId=3,needStar=45,battleChapterId=1007,itemType=6,itemId=1404,itemCount=1},
  [701] = {id=701,boxId=1,needStar=15,battleChapterId=1008,itemType=5,itemId=100,itemCount=2400},
  [702] = {id=702,boxId=1,needStar=15,battleChapterId=1008,itemType=6,itemId=2203,itemCount=1},
  [703] = {id=703,boxId=1,needStar=15,battleChapterId=1008,itemType=5,itemId=57,itemCount=8},
  [704] = {id=704,boxId=2,needStar=30,battleChapterId=1008,itemType=5,itemId=100,itemCount=4000},
  [705] = {id=705,boxId=2,needStar=30,battleChapterId=1008,itemType=5,itemId=20,itemCount=10},
  [706] = {id=706,boxId=2,needStar=30,battleChapterId=1008,itemType=6,itemId=4005,itemCount=16},
  [707] = {id=707,boxId=3,needStar=45,battleChapterId=1008,itemType=6,itemId=2703,itemCount=4},
  [708] = {id=708,boxId=3,needStar=45,battleChapterId=1008,itemType=5,itemId=20,itemCount=10},
  [709] = {id=709,boxId=3,needStar=45,battleChapterId=1008,itemType=6,itemId=1404,itemCount=1},
  [801] = {id=801,boxId=1,needStar=15,battleChapterId=1009,itemType=5,itemId=100,itemCount=2700},
  [802] = {id=802,boxId=1,needStar=15,battleChapterId=1009,itemType=6,itemId=2203,itemCount=1},
  [803] = {id=803,boxId=1,needStar=15,battleChapterId=1009,itemType=5,itemId=57,itemCount=8},
  [804] = {id=804,boxId=2,needStar=30,battleChapterId=1009,itemType=5,itemId=100,itemCount=4500},
  [805] = {id=805,boxId=2,needStar=30,battleChapterId=1009,itemType=5,itemId=20,itemCount=10},
  [806] = {id=806,boxId=2,needStar=30,battleChapterId=1009,itemType=6,itemId=4005,itemCount=16},
  [807] = {id=807,boxId=3,needStar=45,battleChapterId=1009,itemType=6,itemId=2703,itemCount=6},
  [808] = {id=808,boxId=3,needStar=45,battleChapterId=1009,itemType=5,itemId=20,itemCount=10},
  [809] = {id=809,boxId=3,needStar=45,battleChapterId=1009,itemType=6,itemId=1404,itemCount=1},
  [901] = {id=901,boxId=1,needStar=15,battleChapterId=1010,itemType=5,itemId=100,itemCount=3000},
  [902] = {id=902,boxId=1,needStar=15,battleChapterId=1010,itemType=6,itemId=2203,itemCount=1},
  [903] = {id=903,boxId=1,needStar=15,battleChapterId=1010,itemType=5,itemId=57,itemCount=8},
  [904] = {id=904,boxId=2,needStar=30,battleChapterId=1010,itemType=5,itemId=100,itemCount=5000},
  [905] = {id=905,boxId=2,needStar=30,battleChapterId=1010,itemType=5,itemId=20,itemCount=15},
  [906] = {id=906,boxId=2,needStar=30,battleChapterId=1010,itemType=6,itemId=4006,itemCount=16},
  [907] = {id=907,boxId=3,needStar=45,battleChapterId=1010,itemType=6,itemId=2703,itemCount=6},
  [908] = {id=908,boxId=3,needStar=45,battleChapterId=1010,itemType=5,itemId=20,itemCount=15},
  [909] = {id=909,boxId=3,needStar=45,battleChapterId=1010,itemType=6,itemId=1404,itemCount=1},
  [1001] = {id=1001,boxId=1,needStar=15,battleChapterId=1011,itemType=5,itemId=100,itemCount=3300},
  [1002] = {id=1002,boxId=1,needStar=15,battleChapterId=1011,itemType=6,itemId=2203,itemCount=1},
  [1003] = {id=1003,boxId=1,needStar=15,battleChapterId=1011,itemType=5,itemId=57,itemCount=8},
  [1004] = {id=1004,boxId=2,needStar=30,battleChapterId=1011,itemType=5,itemId=100,itemCount=5500},
  [1005] = {id=1005,boxId=2,needStar=30,battleChapterId=1011,itemType=5,itemId=20,itemCount=15},
  [1006] = {id=1006,boxId=2,needStar=30,battleChapterId=1011,itemType=6,itemId=4006,itemCount=16},
  [1007] = {id=1007,boxId=3,needStar=45,battleChapterId=1011,itemType=6,itemId=2703,itemCount=6},
  [1008] = {id=1008,boxId=3,needStar=45,battleChapterId=1011,itemType=5,itemId=20,itemCount=15},
  [1009] = {id=1009,boxId=3,needStar=45,battleChapterId=1011,itemType=6,itemId=1404,itemCount=1},
  [1101] = {id=1101,boxId=1,needStar=15,battleChapterId=1012,itemType=5,itemId=100,itemCount=3600},
  [1102] = {id=1102,boxId=1,needStar=15,battleChapterId=1012,itemType=6,itemId=2203,itemCount=1},
  [1103] = {id=1103,boxId=1,needStar=15,battleChapterId=1012,itemType=5,itemId=57,itemCount=8},
  [1104] = {id=1104,boxId=2,needStar=30,battleChapterId=1012,itemType=5,itemId=100,itemCount=6000},
  [1105] = {id=1105,boxId=2,needStar=30,battleChapterId=1012,itemType=5,itemId=20,itemCount=15},
  [1106] = {id=1106,boxId=2,needStar=30,battleChapterId=1012,itemType=6,itemId=4007,itemCount=16},
  [1107] = {id=1107,boxId=3,needStar=45,battleChapterId=1012,itemType=6,itemId=2703,itemCount=8},
  [1108] = {id=1108,boxId=3,needStar=45,battleChapterId=1012,itemType=5,itemId=20,itemCount=15},
  [1109] = {id=1109,boxId=3,needStar=45,battleChapterId=1012,itemType=6,itemId=1404,itemCount=1},
  [1201] = {id=1201,boxId=1,needStar=15,battleChapterId=1013,itemType=5,itemId=100,itemCount=3600},
  [1202] = {id=1202,boxId=1,needStar=15,battleChapterId=1013,itemType=6,itemId=2203,itemCount=1},
  [1203] = {id=1203,boxId=1,needStar=15,battleChapterId=1013,itemType=5,itemId=57,itemCount=8},
  [1204] = {id=1204,boxId=2,needStar=30,battleChapterId=1013,itemType=5,itemId=100,itemCount=6000},
  [1205] = {id=1205,boxId=2,needStar=30,battleChapterId=1013,itemType=5,itemId=20,itemCount=15},
  [1206] = {id=1206,boxId=2,needStar=30,battleChapterId=1013,itemType=6,itemId=4007,itemCount=16},
  [1207] = {id=1207,boxId=3,needStar=45,battleChapterId=1013,itemType=6,itemId=2703,itemCount=8},
  [1208] = {id=1208,boxId=3,needStar=45,battleChapterId=1013,itemType=5,itemId=20,itemCount=15},
  [1209] = {id=1209,boxId=3,needStar=45,battleChapterId=1013,itemType=6,itemId=1404,itemCount=1},
  [1301] = {id=1301,boxId=1,needStar=15,battleChapterId=1014,itemType=5,itemId=100,itemCount=3600},
  [1302] = {id=1302,boxId=1,needStar=15,battleChapterId=1014,itemType=6,itemId=2203,itemCount=1},
  [1303] = {id=1303,boxId=1,needStar=15,battleChapterId=1014,itemType=5,itemId=57,itemCount=8},
  [1304] = {id=1304,boxId=2,needStar=30,battleChapterId=1014,itemType=5,itemId=100,itemCount=6000},
  [1305] = {id=1305,boxId=2,needStar=30,battleChapterId=1014,itemType=5,itemId=20,itemCount=15},
  [1306] = {id=1306,boxId=2,needStar=30,battleChapterId=1014,itemType=6,itemId=4008,itemCount=16},
  [1307] = {id=1307,boxId=3,needStar=45,battleChapterId=1014,itemType=6,itemId=2703,itemCount=8},
  [1308] = {id=1308,boxId=3,needStar=45,battleChapterId=1014,itemType=5,itemId=20,itemCount=15},
  [1309] = {id=1309,boxId=3,needStar=45,battleChapterId=1014,itemType=6,itemId=1404,itemCount=1},
  [1401] = {id=1401,boxId=1,needStar=15,battleChapterId=1015,itemType=5,itemId=100,itemCount=3600},
  [1402] = {id=1402,boxId=1,needStar=15,battleChapterId=1015,itemType=6,itemId=2203,itemCount=1},
  [1403] = {id=1403,boxId=1,needStar=15,battleChapterId=1015,itemType=5,itemId=57,itemCount=8},
  [1404] = {id=1404,boxId=2,needStar=30,battleChapterId=1015,itemType=5,itemId=100,itemCount=6000},
  [1405] = {id=1405,boxId=2,needStar=30,battleChapterId=1015,itemType=5,itemId=20,itemCount=15},
  [1406] = {id=1406,boxId=2,needStar=30,battleChapterId=1015,itemType=6,itemId=4008,itemCount=16},
  [1407] = {id=1407,boxId=3,needStar=45,battleChapterId=1015,itemType=6,itemId=2703,itemCount=8},
  [1408] = {id=1408,boxId=3,needStar=45,battleChapterId=1015,itemType=5,itemId=20,itemCount=15},
  [1409] = {id=1409,boxId=3,needStar=45,battleChapterId=1015,itemType=6,itemId=1404,itemCount=1},
  [1501] = {id=1501,boxId=1,needStar=15,battleChapterId=1016,itemType=5,itemId=100,itemCount=3600},
  [1502] = {id=1502,boxId=1,needStar=15,battleChapterId=1016,itemType=6,itemId=2203,itemCount=1},
  [1503] = {id=1503,boxId=1,needStar=15,battleChapterId=1016,itemType=5,itemId=57,itemCount=8},
  [1504] = {id=1504,boxId=2,needStar=30,battleChapterId=1016,itemType=5,itemId=100,itemCount=6000},
  [1505] = {id=1505,boxId=2,needStar=30,battleChapterId=1016,itemType=5,itemId=20,itemCount=15},
  [1506] = {id=1506,boxId=2,needStar=30,battleChapterId=1016,itemType=6,itemId=4009,itemCount=16},
  [1507] = {id=1507,boxId=3,needStar=45,battleChapterId=1016,itemType=6,itemId=2703,itemCount=8},
  [1508] = {id=1508,boxId=3,needStar=45,battleChapterId=1016,itemType=5,itemId=20,itemCount=15},
  [1509] = {id=1509,boxId=3,needStar=45,battleChapterId=1016,itemType=6,itemId=1404,itemCount=1},
  [1601] = {id=1601,boxId=1,needStar=15,battleChapterId=1017,itemType=5,itemId=100,itemCount=3600},
  [1602] = {id=1602,boxId=1,needStar=15,battleChapterId=1017,itemType=6,itemId=2203,itemCount=1},
  [1603] = {id=1603,boxId=1,needStar=15,battleChapterId=1017,itemType=5,itemId=57,itemCount=8},
  [1604] = {id=1604,boxId=2,needStar=30,battleChapterId=1017,itemType=5,itemId=100,itemCount=6000},
  [1605] = {id=1605,boxId=2,needStar=30,battleChapterId=1017,itemType=5,itemId=20,itemCount=15},
  [1606] = {id=1606,boxId=2,needStar=30,battleChapterId=1017,itemType=6,itemId=4009,itemCount=16},
  [1607] = {id=1607,boxId=3,needStar=45,battleChapterId=1017,itemType=6,itemId=2703,itemCount=8},
  [1608] = {id=1608,boxId=3,needStar=45,battleChapterId=1017,itemType=5,itemId=20,itemCount=15},
  [1609] = {id=1609,boxId=3,needStar=45,battleChapterId=1017,itemType=6,itemId=1404,itemCount=1},
  [1701] = {id=1701,boxId=1,needStar=15,battleChapterId=1018,itemType=5,itemId=100,itemCount=3600},
  [1702] = {id=1702,boxId=1,needStar=15,battleChapterId=1018,itemType=6,itemId=2203,itemCount=1},
  [1703] = {id=1703,boxId=1,needStar=15,battleChapterId=1018,itemType=5,itemId=57,itemCount=8},
  [1704] = {id=1704,boxId=2,needStar=30,battleChapterId=1018,itemType=5,itemId=100,itemCount=6000},
  [1705] = {id=1705,boxId=2,needStar=30,battleChapterId=1018,itemType=5,itemId=20,itemCount=15},
  [1706] = {id=1706,boxId=2,needStar=30,battleChapterId=1018,itemType=6,itemId=4010,itemCount=16},
  [1707] = {id=1707,boxId=3,needStar=45,battleChapterId=1018,itemType=6,itemId=2703,itemCount=8},
  [1708] = {id=1708,boxId=3,needStar=45,battleChapterId=1018,itemType=5,itemId=20,itemCount=15},
  [1709] = {id=1709,boxId=3,needStar=45,battleChapterId=1018,itemType=6,itemId=1404,itemCount=1},
  [1801] = {id=1801,boxId=1,needStar=15,battleChapterId=1019,itemType=5,itemId=100,itemCount=3600},
  [1802] = {id=1802,boxId=1,needStar=15,battleChapterId=1019,itemType=6,itemId=2203,itemCount=1},
  [1803] = {id=1803,boxId=1,needStar=15,battleChapterId=1019,itemType=5,itemId=57,itemCount=8},
  [1804] = {id=1804,boxId=2,needStar=30,battleChapterId=1019,itemType=5,itemId=100,itemCount=6000},
  [1805] = {id=1805,boxId=2,needStar=30,battleChapterId=1019,itemType=5,itemId=20,itemCount=15},
  [1806] = {id=1806,boxId=2,needStar=30,battleChapterId=1019,itemType=6,itemId=4010,itemCount=16},
  [1807] = {id=1807,boxId=3,needStar=45,battleChapterId=1019,itemType=6,itemId=2703,itemCount=8},
  [1808] = {id=1808,boxId=3,needStar=45,battleChapterId=1019,itemType=5,itemId=20,itemCount=15},
  [1809] = {id=1809,boxId=3,needStar=45,battleChapterId=1019,itemType=6,itemId=1404,itemCount=1},
  [1901] = {id=1901,boxId=1,needStar=15,battleChapterId=1020,itemType=5,itemId=100,itemCount=3600},
  [1902] = {id=1902,boxId=1,needStar=15,battleChapterId=1020,itemType=6,itemId=2203,itemCount=1},
  [1903] = {id=1903,boxId=1,needStar=15,battleChapterId=1020,itemType=5,itemId=57,itemCount=8},
  [1904] = {id=1904,boxId=2,needStar=30,battleChapterId=1020,itemType=5,itemId=100,itemCount=6000},
  [1905] = {id=1905,boxId=2,needStar=30,battleChapterId=1020,itemType=5,itemId=20,itemCount=15},
  [1906] = {id=1906,boxId=2,needStar=30,battleChapterId=1020,itemType=6,itemId=4010,itemCount=16},
  [1907] = {id=1907,boxId=3,needStar=45,battleChapterId=1020,itemType=6,itemId=2703,itemCount=8},
  [1908] = {id=1908,boxId=3,needStar=45,battleChapterId=1020,itemType=5,itemId=20,itemCount=15},
  [1909] = {id=1909,boxId=3,needStar=45,battleChapterId=1020,itemType=6,itemId=1404,itemCount=1},
  [2001] = {id=2001,boxId=1,needStar=15,battleChapterId=1021,itemType=5,itemId=100,itemCount=3600},
  [2002] = {id=2002,boxId=1,needStar=15,battleChapterId=1021,itemType=6,itemId=2203,itemCount=1},
  [2003] = {id=2003,boxId=1,needStar=15,battleChapterId=1021,itemType=5,itemId=57,itemCount=8},
  [2004] = {id=2004,boxId=2,needStar=30,battleChapterId=1021,itemType=5,itemId=100,itemCount=6000},
  [2005] = {id=2005,boxId=2,needStar=30,battleChapterId=1021,itemType=5,itemId=20,itemCount=15},
  [2006] = {id=2006,boxId=2,needStar=30,battleChapterId=1021,itemType=6,itemId=4011,itemCount=16},
  [2007] = {id=2007,boxId=3,needStar=45,battleChapterId=1021,itemType=6,itemId=2703,itemCount=8},
  [2008] = {id=2008,boxId=3,needStar=45,battleChapterId=1021,itemType=5,itemId=20,itemCount=15},
  [2009] = {id=2009,boxId=3,needStar=45,battleChapterId=1021,itemType=6,itemId=1404,itemCount=1},
  [2101] = {id=2101,boxId=1,needStar=15,battleChapterId=1022,itemType=5,itemId=100,itemCount=3600},
  [2102] = {id=2102,boxId=1,needStar=15,battleChapterId=1022,itemType=6,itemId=2203,itemCount=1},
  [2103] = {id=2103,boxId=1,needStar=15,battleChapterId=1022,itemType=5,itemId=57,itemCount=8},
  [2104] = {id=2104,boxId=2,needStar=30,battleChapterId=1022,itemType=5,itemId=100,itemCount=6000},
  [2105] = {id=2105,boxId=2,needStar=30,battleChapterId=1022,itemType=5,itemId=20,itemCount=15},
  [2106] = {id=2106,boxId=2,needStar=30,battleChapterId=1022,itemType=6,itemId=4011,itemCount=16},
  [2107] = {id=2107,boxId=3,needStar=45,battleChapterId=1022,itemType=6,itemId=2703,itemCount=8},
  [2108] = {id=2108,boxId=3,needStar=45,battleChapterId=1022,itemType=5,itemId=20,itemCount=15},
  [2109] = {id=2109,boxId=3,needStar=45,battleChapterId=1022,itemType=6,itemId=1404,itemCount=1},
  [2201] = {id=2201,boxId=1,needStar=15,battleChapterId=1023,itemType=5,itemId=100,itemCount=3600},
  [2202] = {id=2202,boxId=1,needStar=15,battleChapterId=1023,itemType=6,itemId=2203,itemCount=1},
  [2203] = {id=2203,boxId=1,needStar=15,battleChapterId=1023,itemType=5,itemId=57,itemCount=8},
  [2204] = {id=2204,boxId=2,needStar=30,battleChapterId=1023,itemType=5,itemId=100,itemCount=6000},
  [2205] = {id=2205,boxId=2,needStar=30,battleChapterId=1023,itemType=5,itemId=20,itemCount=15},
  [2206] = {id=2206,boxId=2,needStar=30,battleChapterId=1023,itemType=6,itemId=4011,itemCount=16},
  [2207] = {id=2207,boxId=3,needStar=45,battleChapterId=1023,itemType=6,itemId=2703,itemCount=8},
  [2208] = {id=2208,boxId=3,needStar=45,battleChapterId=1023,itemType=5,itemId=20,itemCount=15},
  [2209] = {id=2209,boxId=3,needStar=45,battleChapterId=1023,itemType=6,itemId=1404,itemCount=1}
}
return DBattleBox