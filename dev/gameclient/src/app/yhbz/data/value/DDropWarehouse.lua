-- c_城外掉落库.xlsx
-- id=编号,type=掉落库类型,itemType=掉落数据类型,itemId=掉落数据ID,itemValue=掉落数值,itemOdds=权重,
local DDropWarehouse = {
  [1001] = {id=1001,type=1,itemType=5,itemId=12,itemValue=1,itemOdds=500},
  [1002] = {id=1002,type=1,itemType=6,itemId=2201,itemValue=1,itemOdds=500},
  [1003] = {id=1003,type=1,itemType=6,itemId=2701,itemValue=1,itemOdds=333},
  [1004] = {id=1004,type=1,itemType=6,itemId=1001,itemValue=1,itemOdds=250},
  [1005] = {id=1005,type=1,itemType=6,itemId=1101,itemValue=1,itemOdds=250},
  [1006] = {id=1006,type=1,itemType=6,itemId=1201,itemValue=1,itemOdds=250},
  [1007] = {id=1007,type=1,itemType=6,itemId=1301,itemValue=1,itemOdds=250},
  [1008] = {id=1008,type=1,itemType=6,itemId=2901,itemValue=1,itemOdds=250},
  [1009] = {id=1009,type=1,itemType=6,itemId=1401,itemValue=1,itemOdds=200},
  [1010] = {id=1010,type=1,itemType=6,itemId=2202,itemValue=1,itemOdds=200},
  [1011] = {id=1011,type=1,itemType=6,itemId=2501,itemValue=1,itemOdds=200},
  [1012] = {id=1012,type=1,itemType=5,itemId=5,itemValue=1,itemOdds=200},
  [1013] = {id=1013,type=1,itemType=6,itemId=1212,itemValue=1,itemOdds=142},
  [1014] = {id=1014,type=1,itemType=6,itemId=1312,itemValue=1,itemOdds=142},
  [1015] = {id=1015,type=1,itemType=6,itemId=2902,itemValue=1,itemOdds=142},
  [1016] = {id=1016,type=1,itemType=6,itemId=3101,itemValue=1,itemOdds=125},
  [1017] = {id=1017,type=1,itemType=6,itemId=2203,itemValue=1,itemOdds=125},
  [1018] = {id=1018,type=1,itemType=6,itemId=3401,itemValue=1,itemOdds=125},
  [1019] = {id=1019,type=1,itemType=6,itemId=1402,itemValue=1,itemOdds=100},
  [1020] = {id=1020,type=1,itemType=6,itemId=2502,itemValue=1,itemOdds=100},
  [1021] = {id=1021,type=1,itemType=6,itemId=2702,itemValue=1,itemOdds=100},
  [1022] = {id=1022,type=1,itemType=6,itemId=1202,itemValue=1,itemOdds=83},
  [1023] = {id=1023,type=1,itemType=6,itemId=1302,itemValue=1,itemOdds=83},
  [1024] = {id=1024,type=1,itemType=6,itemId=2503,itemValue=1,itemOdds=71},
  [1025] = {id=1025,type=1,itemType=6,itemId=1002,itemValue=1,itemOdds=66},
  [1026] = {id=1026,type=1,itemType=6,itemId=1102,itemValue=1,itemOdds=66},
  [1027] = {id=1027,type=1,itemType=6,itemId=1213,itemValue=1,itemOdds=66},
  [1028] = {id=1028,type=1,itemType=6,itemId=1303,itemValue=1,itemOdds=66},
  [1029] = {id=1029,type=1,itemType=6,itemId=2001,itemValue=1,itemOdds=66},
  [1030] = {id=1030,type=1,itemType=5,itemId=6,itemValue=1,itemOdds=66},
  [1031] = {id=1031,type=1,itemType=6,itemId=3102,itemValue=1,itemOdds=62},
  [1032] = {id=1032,type=1,itemType=6,itemId=1203,itemValue=1,itemOdds=55},
  [1033] = {id=1033,type=1,itemType=6,itemId=1313,itemValue=1,itemOdds=55},
  [1034] = {id=1034,type=1,itemType=6,itemId=1003,itemValue=1,itemOdds=50},
  [1035] = {id=1035,type=1,itemType=6,itemId=1103,itemValue=1,itemOdds=50},
  [1036] = {id=1036,type=1,itemType=6,itemId=1403,itemValue=1,itemOdds=50},
  [1037] = {id=1037,type=1,itemType=6,itemId=2601,itemValue=1,itemOdds=50},
  [1038] = {id=1038,type=1,itemType=6,itemId=2903,itemValue=1,itemOdds=50},
  [1039] = {id=1039,type=1,itemType=6,itemId=3402,itemValue=1,itemOdds=50},
  [1040] = {id=1040,type=1,itemType=6,itemId=2504,itemValue=1,itemOdds=37},
  [1041] = {id=1041,type=1,itemType=6,itemId=1204,itemValue=1,itemOdds=33},
  [1042] = {id=1042,type=1,itemType=6,itemId=1304,itemValue=1,itemOdds=33},
  [1043] = {id=1043,type=1,itemType=6,itemId=2002,itemValue=1,itemOdds=33},
  [1044] = {id=1044,type=1,itemType=6,itemId=2703,itemValue=1,itemOdds=33},
  [1045] = {id=1045,type=1,itemType=6,itemId=2904,itemValue=1,itemOdds=33},
  [1046] = {id=1046,type=1,itemType=7,itemId=1,itemValue=1,itemOdds=33},
  [1047] = {id=1047,type=1,itemType=7,itemId=101,itemValue=1,itemOdds=33},
  [1048] = {id=1048,type=1,itemType=7,itemId=201,itemValue=1,itemOdds=33},
  [1049] = {id=1049,type=1,itemType=7,itemId=301,itemValue=1,itemOdds=33},
  [1050] = {id=1050,type=1,itemType=7,itemId=401,itemValue=1,itemOdds=33},
  [1051] = {id=1051,type=1,itemType=7,itemId=501,itemValue=1,itemOdds=33},
  [1052] = {id=1052,type=1,itemType=8,itemId=18,itemValue=1,itemOdds=33},
  [1053] = {id=1053,type=1,itemType=8,itemId=19,itemValue=1,itemOdds=33},
  [1054] = {id=1054,type=1,itemType=6,itemId=1004,itemValue=1,itemOdds=25},
  [1055] = {id=1055,type=1,itemType=6,itemId=1104,itemValue=1,itemOdds=25},
  [1056] = {id=1056,type=1,itemType=6,itemId=2801,itemValue=1,itemOdds=25},
  [1057] = {id=1057,type=1,itemType=5,itemId=32,itemValue=1,itemOdds=25},
  [1058] = {id=1058,type=1,itemType=6,itemId=3403,itemValue=1,itemOdds=22},
  [1059] = {id=1059,type=1,itemType=6,itemId=1404,itemValue=1,itemOdds=20},
  [1060] = {id=1060,type=1,itemType=7,itemId=801,itemValue=1,itemOdds=20},
  [1061] = {id=1061,type=1,itemType=8,itemId=20,itemValue=1,itemOdds=20},
  [1062] = {id=1062,type=1,itemType=8,itemId=23,itemValue=1,itemOdds=20},
  [1063] = {id=1063,type=1,itemType=6,itemId=3103,itemValue=1,itemOdds=17},
  [1064] = {id=1064,type=1,itemType=6,itemId=2905,itemValue=1,itemOdds=16},
  [1065] = {id=1065,type=1,itemType=8,itemId=21,itemValue=1,itemOdds=14},
  [1066] = {id=1066,type=1,itemType=6,itemId=2003,itemValue=1,itemOdds=13},
  [1067] = {id=1067,type=1,itemType=6,itemId=2505,itemValue=1,itemOdds=11},
  [1068] = {id=1068,type=1,itemType=6,itemId=1205,itemValue=1,itemOdds=11},
  [1069] = {id=1069,type=1,itemType=6,itemId=3404,itemValue=1,itemOdds=10},
  [1070] = {id=1070,type=1,itemType=6,itemId=1405,itemValue=1,itemOdds=10},
  [1071] = {id=1071,type=1,itemType=6,itemId=2602,itemValue=1,itemOdds=10},
  [1072] = {id=1072,type=1,itemType=5,itemId=20,itemValue=1,itemOdds=10},
  [1073] = {id=1073,type=1,itemType=6,itemId=1005,itemValue=1,itemOdds=9},
  [1074] = {id=1074,type=1,itemType=6,itemId=1105,itemValue=1,itemOdds=9},
  [1075] = {id=1075,type=1,itemType=6,itemId=2004,itemValue=1,itemOdds=6},
  [1076] = {id=1076,type=1,itemType=6,itemId=2204,itemValue=1,itemOdds=5},
  [1077] = {id=1077,type=1,itemType=7,itemId=2,itemValue=1,itemOdds=5},
  [1078] = {id=1078,type=1,itemType=7,itemId=102,itemValue=1,itemOdds=5},
  [1079] = {id=1079,type=1,itemType=7,itemId=202,itemValue=1,itemOdds=5},
  [1080] = {id=1080,type=1,itemType=7,itemId=302,itemValue=1,itemOdds=5},
  [1081] = {id=1081,type=1,itemType=7,itemId=402,itemValue=1,itemOdds=5},
  [1082] = {id=1082,type=1,itemType=7,itemId=502,itemValue=1,itemOdds=5},
  [1083] = {id=1083,type=1,itemType=6,itemId=2603,itemValue=1,itemOdds=5},
  [1084] = {id=1084,type=1,itemType=6,itemId=3104,itemValue=1,itemOdds=5},
  [1085] = {id=1085,type=1,itemType=6,itemId=2802,itemValue=1,itemOdds=5},
  [1086] = {id=1086,type=1,itemType=7,itemId=503,itemValue=1,itemOdds=4},
  [1087] = {id=1087,type=1,itemType=8,itemId=5,itemValue=1,itemOdds=4},
  [1088] = {id=1088,type=1,itemType=8,itemId=7,itemValue=1,itemOdds=4},
  [1089] = {id=1089,type=1,itemType=6,itemId=2005,itemValue=1,itemOdds=3},
  [1090] = {id=1090,type=1,itemType=6,itemId=3405,itemValue=1,itemOdds=3},
  [3001] = {id=3001,type=3,itemType=6,itemId=1001,itemValue=1,itemOdds=250},
  [3002] = {id=3002,type=3,itemType=6,itemId=1002,itemValue=1,itemOdds=66},
  [3003] = {id=3003,type=3,itemType=6,itemId=1003,itemValue=1,itemOdds=50},
  [3004] = {id=3004,type=3,itemType=6,itemId=1004,itemValue=1,itemOdds=25},
  [3005] = {id=3005,type=3,itemType=6,itemId=1005,itemValue=1,itemOdds=9},
  [3006] = {id=3006,type=3,itemType=6,itemId=1013,itemValue=1,itemOdds=7},
  [3007] = {id=3007,type=3,itemType=6,itemId=1101,itemValue=1,itemOdds=250},
  [3008] = {id=3008,type=3,itemType=6,itemId=1102,itemValue=1,itemOdds=66},
  [3009] = {id=3009,type=3,itemType=6,itemId=1103,itemValue=1,itemOdds=50},
  [3010] = {id=3010,type=3,itemType=6,itemId=1104,itemValue=1,itemOdds=25},
  [3011] = {id=3011,type=3,itemType=6,itemId=1105,itemValue=1,itemOdds=9},
  [3012] = {id=3012,type=3,itemType=6,itemId=1113,itemValue=1,itemOdds=7},
  [3013] = {id=3013,type=3,itemType=6,itemId=1304,itemValue=1,itemOdds=33},
  [3014] = {id=3014,type=3,itemType=6,itemId=1212,itemValue=1,itemOdds=142},
  [3015] = {id=3015,type=3,itemType=6,itemId=1202,itemValue=1,itemOdds=83},
  [3016] = {id=3016,type=3,itemType=6,itemId=1213,itemValue=1,itemOdds=66},
  [3017] = {id=3017,type=3,itemType=6,itemId=1203,itemValue=1,itemOdds=55},
  [3018] = {id=3018,type=3,itemType=6,itemId=1301,itemValue=1,itemOdds=250},
  [3019] = {id=3019,type=3,itemType=6,itemId=1312,itemValue=1,itemOdds=142},
  [3020] = {id=3020,type=3,itemType=6,itemId=1302,itemValue=1,itemOdds=83},
  [3021] = {id=3021,type=3,itemType=6,itemId=1303,itemValue=1,itemOdds=66},
  [3022] = {id=3022,type=3,itemType=6,itemId=1313,itemValue=1,itemOdds=55},
  [14001] = {id=14001,type=14,itemType=5,itemId=12,itemValue=1,itemOdds=200},
  [14002] = {id=14002,type=14,itemType=6,itemId=2201,itemValue=1,itemOdds=500},
  [14003] = {id=14003,type=14,itemType=6,itemId=1001,itemValue=1,itemOdds=250},
  [14004] = {id=14004,type=14,itemType=6,itemId=1101,itemValue=1,itemOdds=250},
  [14005] = {id=14005,type=14,itemType=6,itemId=1201,itemValue=1,itemOdds=250},
  [14006] = {id=14006,type=14,itemType=6,itemId=1301,itemValue=1,itemOdds=250},
  [14007] = {id=14007,type=14,itemType=6,itemId=1401,itemValue=1,itemOdds=200},
  [14008] = {id=14008,type=14,itemType=6,itemId=2202,itemValue=1,itemOdds=200},
  [14009] = {id=14009,type=14,itemType=6,itemId=2501,itemValue=1,itemOdds=200},
  [14010] = {id=14010,type=14,itemType=5,itemId=5,itemValue=1,itemOdds=200},
  [14011] = {id=14011,type=14,itemType=6,itemId=1212,itemValue=1,itemOdds=142},
  [14012] = {id=14012,type=14,itemType=6,itemId=1312,itemValue=1,itemOdds=142},
  [14013] = {id=14013,type=14,itemType=6,itemId=2902,itemValue=1,itemOdds=142},
  [14014] = {id=14014,type=14,itemType=6,itemId=3101,itemValue=1,itemOdds=125},
  [14015] = {id=14015,type=14,itemType=6,itemId=2203,itemValue=1,itemOdds=125},
  [14016] = {id=14016,type=14,itemType=6,itemId=3401,itemValue=1,itemOdds=125},
  [14017] = {id=14017,type=14,itemType=6,itemId=1402,itemValue=1,itemOdds=100},
  [14018] = {id=14018,type=14,itemType=6,itemId=2502,itemValue=1,itemOdds=100},
  [14019] = {id=14019,type=14,itemType=6,itemId=2702,itemValue=1,itemOdds=100},
  [14020] = {id=14020,type=14,itemType=6,itemId=1202,itemValue=1,itemOdds=83},
  [14021] = {id=14021,type=14,itemType=6,itemId=1302,itemValue=1,itemOdds=83},
  [14022] = {id=14022,type=14,itemType=6,itemId=2503,itemValue=1,itemOdds=71},
  [14023] = {id=14023,type=14,itemType=6,itemId=1002,itemValue=1,itemOdds=66},
  [14024] = {id=14024,type=14,itemType=6,itemId=1102,itemValue=1,itemOdds=66},
  [14025] = {id=14025,type=14,itemType=6,itemId=1213,itemValue=1,itemOdds=66},
  [14026] = {id=14026,type=14,itemType=6,itemId=1303,itemValue=1,itemOdds=66},
  [14027] = {id=14027,type=14,itemType=6,itemId=2001,itemValue=1,itemOdds=66},
  [14028] = {id=14028,type=14,itemType=5,itemId=6,itemValue=1,itemOdds=66},
  [14029] = {id=14029,type=14,itemType=6,itemId=3102,itemValue=1,itemOdds=62},
  [14030] = {id=14030,type=14,itemType=6,itemId=1203,itemValue=1,itemOdds=55},
  [14031] = {id=14031,type=14,itemType=6,itemId=1313,itemValue=1,itemOdds=55},
  [14032] = {id=14032,type=14,itemType=6,itemId=1003,itemValue=1,itemOdds=50},
  [14033] = {id=14033,type=14,itemType=6,itemId=1103,itemValue=1,itemOdds=50},
  [14034] = {id=14034,type=14,itemType=6,itemId=1403,itemValue=1,itemOdds=50},
  [14035] = {id=14035,type=14,itemType=6,itemId=2601,itemValue=1,itemOdds=50},
  [14036] = {id=14036,type=14,itemType=6,itemId=2903,itemValue=1,itemOdds=50},
  [14037] = {id=14037,type=14,itemType=6,itemId=3402,itemValue=1,itemOdds=50},
  [14038] = {id=14038,type=14,itemType=6,itemId=2504,itemValue=1,itemOdds=37},
  [14039] = {id=14039,type=14,itemType=6,itemId=1204,itemValue=1,itemOdds=33},
  [14040] = {id=14040,type=14,itemType=6,itemId=1304,itemValue=1,itemOdds=33},
  [14041] = {id=14041,type=14,itemType=6,itemId=2002,itemValue=1,itemOdds=33},
  [14042] = {id=14042,type=14,itemType=6,itemId=2703,itemValue=1,itemOdds=33},
  [14043] = {id=14043,type=14,itemType=6,itemId=2904,itemValue=1,itemOdds=33},
  [14044] = {id=14044,type=14,itemType=7,itemId=1,itemValue=1,itemOdds=33},
  [14045] = {id=14045,type=14,itemType=7,itemId=101,itemValue=1,itemOdds=33},
  [14046] = {id=14046,type=14,itemType=7,itemId=201,itemValue=1,itemOdds=33},
  [14047] = {id=14047,type=14,itemType=7,itemId=301,itemValue=1,itemOdds=33},
  [14048] = {id=14048,type=14,itemType=7,itemId=401,itemValue=1,itemOdds=33},
  [14049] = {id=14049,type=14,itemType=7,itemId=501,itemValue=1,itemOdds=33},
  [14050] = {id=14050,type=14,itemType=8,itemId=18,itemValue=1,itemOdds=33},
  [14051] = {id=14051,type=14,itemType=8,itemId=19,itemValue=1,itemOdds=33},
  [14052] = {id=14052,type=14,itemType=6,itemId=1004,itemValue=1,itemOdds=25},
  [14053] = {id=14053,type=14,itemType=6,itemId=1104,itemValue=1,itemOdds=25},
  [14054] = {id=14054,type=14,itemType=6,itemId=2801,itemValue=1,itemOdds=25},
  [14055] = {id=14055,type=14,itemType=5,itemId=32,itemValue=1,itemOdds=25},
  [14056] = {id=14056,type=14,itemType=6,itemId=3403,itemValue=1,itemOdds=22},
  [14057] = {id=14057,type=14,itemType=6,itemId=1404,itemValue=1,itemOdds=20},
  [14058] = {id=14058,type=14,itemType=7,itemId=801,itemValue=1,itemOdds=20},
  [14059] = {id=14059,type=14,itemType=8,itemId=20,itemValue=1,itemOdds=20},
  [14060] = {id=14060,type=14,itemType=8,itemId=23,itemValue=1,itemOdds=20},
  [14061] = {id=14061,type=14,itemType=6,itemId=3103,itemValue=1,itemOdds=17},
  [14062] = {id=14062,type=14,itemType=6,itemId=2905,itemValue=1,itemOdds=16},
  [14063] = {id=14063,type=14,itemType=8,itemId=21,itemValue=1,itemOdds=14},
  [14064] = {id=14064,type=14,itemType=6,itemId=2003,itemValue=1,itemOdds=13},
  [14065] = {id=14065,type=14,itemType=6,itemId=2505,itemValue=1,itemOdds=11},
  [14066] = {id=14066,type=14,itemType=6,itemId=1205,itemValue=1,itemOdds=11},
  [14067] = {id=14067,type=14,itemType=6,itemId=3404,itemValue=1,itemOdds=10},
  [14068] = {id=14068,type=14,itemType=6,itemId=1405,itemValue=1,itemOdds=10},
  [14069] = {id=14069,type=14,itemType=6,itemId=2602,itemValue=1,itemOdds=10},
  [14070] = {id=14070,type=14,itemType=5,itemId=20,itemValue=1,itemOdds=10},
  [14071] = {id=14071,type=14,itemType=6,itemId=1005,itemValue=1,itemOdds=9},
  [14072] = {id=14072,type=14,itemType=6,itemId=1105,itemValue=1,itemOdds=9},
  [15001] = {id=15001,type=15,itemType=14,itemId=1,itemValue=1,itemOdds=500},
  [15002] = {id=15002,type=15,itemType=14,itemId=101,itemValue=1,itemOdds=500},
  [15003] = {id=15003,type=15,itemType=14,itemId=201,itemValue=1,itemOdds=500},
  [15004] = {id=15004,type=15,itemType=14,itemId=301,itemValue=1,itemOdds=500},
  [15005] = {id=15005,type=15,itemType=14,itemId=401,itemValue=1,itemOdds=500},
  [15006] = {id=15006,type=15,itemType=14,itemId=501,itemValue=1,itemOdds=500},
  [15007] = {id=15007,type=15,itemType=14,itemId=601,itemValue=1,itemOdds=500},
  [15008] = {id=15008,type=15,itemType=14,itemId=701,itemValue=1,itemOdds=500},
  [15009] = {id=15009,type=15,itemType=14,itemId=801,itemValue=1,itemOdds=500},
  [15010] = {id=15010,type=15,itemType=14,itemId=901,itemValue=1,itemOdds=500},
  [15011] = {id=15011,type=15,itemType=14,itemId=1001,itemValue=1,itemOdds=500},
  [15012] = {id=15012,type=15,itemType=14,itemId=1101,itemValue=1,itemOdds=500}
}
return DDropWarehouse