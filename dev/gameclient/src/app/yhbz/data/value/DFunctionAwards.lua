-- g_功能奖励库.xlsx
-- id=编号,faId=奖励库ID,itemType=奖励类型,itemId=奖励ID,itemCount=奖励数据,
local DFunctionAwards = {
  [1] = {id=1,faId=1,itemType=5,itemId=1000,itemCount=25},
  [2] = {id=2,faId=1,itemType=6,itemId=3402,itemCount=1},
  [3] = {id=3,faId=2,itemType=5,itemId=1000,itemCount=25},
  [4] = {id=4,faId=2,itemType=6,itemId=3402,itemCount=2},
  [5] = {id=5,faId=3,itemType=5,itemId=1000,itemCount=25},
  [6] = {id=6,faId=3,itemType=6,itemId=3402,itemCount=3},
  [7] = {id=7,faId=4,itemType=5,itemId=1000,itemCount=25},
  [8] = {id=8,faId=4,itemType=6,itemId=3402,itemCount=5},
  [9] = {id=9,faId=5,itemType=5,itemId=1000,itemCount=25},
  [10] = {id=10,faId=5,itemType=6,itemId=3402,itemCount=5},
  [11] = {id=11,faId=6,itemType=5,itemId=1000,itemCount=25},
  [12] = {id=12,faId=6,itemType=6,itemId=3402,itemCount=6},
  [13] = {id=13,faId=7,itemType=5,itemId=1000,itemCount=25},
  [14] = {id=14,faId=7,itemType=6,itemId=3402,itemCount=7},
  [15] = {id=15,faId=8,itemType=5,itemId=1000,itemCount=25},
  [16] = {id=16,faId=8,itemType=6,itemId=3402,itemCount=8},
  [17] = {id=17,faId=9,itemType=5,itemId=1000,itemCount=25},
  [18] = {id=18,faId=9,itemType=6,itemId=3402,itemCount=9},
  [19] = {id=19,faId=10,itemType=5,itemId=1000,itemCount=50},
  [20] = {id=20,faId=10,itemType=6,itemId=3402,itemCount=10},
  [21] = {id=21,faId=10,itemType=6,itemId=2904,itemCount=5},
  [22] = {id=22,faId=11,itemType=5,itemId=1000,itemCount=50},
  [23] = {id=23,faId=11,itemType=6,itemId=3402,itemCount=10},
  [24] = {id=24,faId=11,itemType=6,itemId=2904,itemCount=7},
  [25] = {id=25,faId=12,itemType=5,itemId=1000,itemCount=50},
  [26] = {id=26,faId=12,itemType=6,itemId=3402,itemCount=10},
  [27] = {id=27,faId=12,itemType=6,itemId=2904,itemCount=9},
  [28] = {id=28,faId=13,itemType=5,itemId=1000,itemCount=50},
  [29] = {id=29,faId=13,itemType=6,itemId=3402,itemCount=10},
  [30] = {id=30,faId=13,itemType=6,itemId=2904,itemCount=11},
  [31] = {id=31,faId=14,itemType=5,itemId=1000,itemCount=75},
  [32] = {id=32,faId=14,itemType=6,itemId=3402,itemCount=10},
  [33] = {id=33,faId=14,itemType=6,itemId=2904,itemCount=13},
  [34] = {id=34,faId=15,itemType=5,itemId=1000,itemCount=75},
  [35] = {id=35,faId=15,itemType=6,itemId=3402,itemCount=10},
  [36] = {id=36,faId=15,itemType=6,itemId=2904,itemCount=15},
  [37] = {id=37,faId=16,itemType=5,itemId=1000,itemCount=75},
  [38] = {id=38,faId=16,itemType=6,itemId=3402,itemCount=15},
  [39] = {id=39,faId=16,itemType=6,itemId=2904,itemCount=15},
  [40] = {id=40,faId=17,itemType=5,itemId=1000,itemCount=75},
  [41] = {id=41,faId=17,itemType=6,itemId=3402,itemCount=20},
  [42] = {id=42,faId=17,itemType=6,itemId=2904,itemCount=15},
  [43] = {id=43,faId=18,itemType=5,itemId=1000,itemCount=75},
  [44] = {id=44,faId=18,itemType=6,itemId=3402,itemCount=25},
  [45] = {id=45,faId=18,itemType=6,itemId=2904,itemCount=15},
  [46] = {id=46,faId=19,itemType=5,itemId=1000,itemCount=75},
  [47] = {id=47,faId=19,itemType=6,itemId=3402,itemCount=30},
  [48] = {id=48,faId=19,itemType=6,itemId=2904,itemCount=15},
  [49] = {id=49,faId=20,itemType=5,itemId=1000,itemCount=100},
  [50] = {id=50,faId=20,itemType=6,itemId=3402,itemCount=35},
  [51] = {id=51,faId=20,itemType=6,itemId=2904,itemCount=20},
  [52] = {id=52,faId=20,itemType=6,itemId=2702,itemCount=1},
  [53] = {id=53,faId=21,itemType=5,itemId=1000,itemCount=100},
  [54] = {id=54,faId=21,itemType=6,itemId=3402,itemCount=40},
  [55] = {id=55,faId=21,itemType=6,itemId=2904,itemCount=20},
  [56] = {id=56,faId=21,itemType=6,itemId=2702,itemCount=2},
  [57] = {id=57,faId=22,itemType=5,itemId=1000,itemCount=100},
  [58] = {id=58,faId=22,itemType=6,itemId=3402,itemCount=45},
  [59] = {id=59,faId=22,itemType=6,itemId=2904,itemCount=20},
  [60] = {id=60,faId=22,itemType=6,itemId=2702,itemCount=3},
  [61] = {id=61,faId=23,itemType=5,itemId=1000,itemCount=100},
  [62] = {id=62,faId=23,itemType=6,itemId=3402,itemCount=50},
  [63] = {id=63,faId=23,itemType=6,itemId=2904,itemCount=20},
  [64] = {id=64,faId=23,itemType=6,itemId=2702,itemCount=4},
  [65] = {id=65,faId=24,itemType=5,itemId=1000,itemCount=100},
  [66] = {id=66,faId=24,itemType=6,itemId=3402,itemCount=55},
  [67] = {id=67,faId=24,itemType=6,itemId=2904,itemCount=20},
  [68] = {id=68,faId=24,itemType=6,itemId=2702,itemCount=5},
  [69] = {id=69,faId=25,itemType=5,itemId=1000,itemCount=150},
  [70] = {id=70,faId=25,itemType=6,itemId=3402,itemCount=60},
  [71] = {id=71,faId=25,itemType=6,itemId=2904,itemCount=20},
  [72] = {id=72,faId=25,itemType=6,itemId=2702,itemCount=6},
  [73] = {id=73,faId=25,itemType=5,itemId=300,itemCount=10000},
  [74] = {id=74,faId=1001,itemType=5,itemId=1000,itemCount=250},
  [75] = {id=75,faId=1001,itemType=5,itemId=300,itemCount=50000},
  [76] = {id=76,faId=1001,itemType=13,itemId=1,itemCount=50000},
  [77] = {id=77,faId=1001,itemType=6,itemId=2906,itemCount=2},
  [78] = {id=78,faId=1001,itemType=5,itemId=1,itemCount=150000},
  [79] = {id=79,faId=1001,itemType=5,itemId=2,itemCount=150000},
  [80] = {id=80,faId=1001,itemType=6,itemId=2602,itemCount=5},
  [81] = {id=81,faId=1002,itemType=5,itemId=1000,itemCount=175},
  [82] = {id=82,faId=1002,itemType=5,itemId=300,itemCount=50000},
  [83] = {id=83,faId=1002,itemType=13,itemId=1,itemCount=50000},
  [84] = {id=84,faId=1002,itemType=6,itemId=2906,itemCount=2},
  [85] = {id=85,faId=1002,itemType=5,itemId=1,itemCount=150000},
  [86] = {id=86,faId=1002,itemType=5,itemId=2,itemCount=150000},
  [87] = {id=87,faId=1002,itemType=6,itemId=2602,itemCount=4},
  [88] = {id=88,faId=1003,itemType=5,itemId=1000,itemCount=125},
  [89] = {id=89,faId=1003,itemType=5,itemId=300,itemCount=50000},
  [90] = {id=90,faId=1003,itemType=13,itemId=1,itemCount=50000},
  [91] = {id=91,faId=1003,itemType=6,itemId=2906,itemCount=1},
  [92] = {id=92,faId=1003,itemType=5,itemId=1,itemCount=100000},
  [93] = {id=93,faId=1003,itemType=5,itemId=2,itemCount=100000},
  [94] = {id=94,faId=1003,itemType=6,itemId=2602,itemCount=4},
  [95] = {id=95,faId=1004,itemType=5,itemId=1000,itemCount=100},
  [96] = {id=96,faId=1004,itemType=5,itemId=300,itemCount=40000},
  [97] = {id=97,faId=1004,itemType=13,itemId=1,itemCount=40000},
  [98] = {id=98,faId=1004,itemType=6,itemId=2906,itemCount=1},
  [99] = {id=99,faId=1004,itemType=5,itemId=1,itemCount=50000},
  [100] = {id=100,faId=1004,itemType=5,itemId=2,itemCount=50000},
  [101] = {id=101,faId=1004,itemType=6,itemId=2602,itemCount=4},
  [102] = {id=102,faId=1005,itemType=5,itemId=1000,itemCount=75},
  [103] = {id=103,faId=1005,itemType=5,itemId=300,itemCount=20000},
  [104] = {id=104,faId=1005,itemType=13,itemId=1,itemCount=20000},
  [105] = {id=105,faId=1005,itemType=6,itemId=2906,itemCount=1},
  [106] = {id=106,faId=1005,itemType=5,itemId=1,itemCount=30000},
  [107] = {id=107,faId=1005,itemType=5,itemId=2,itemCount=30000},
  [108] = {id=108,faId=1005,itemType=6,itemId=2602,itemCount=4},
  [109] = {id=109,faId=1006,itemType=5,itemId=1000,itemCount=50},
  [110] = {id=110,faId=1006,itemType=5,itemId=300,itemCount=15000},
  [111] = {id=111,faId=1006,itemType=13,itemId=1,itemCount=15000},
  [112] = {id=112,faId=1006,itemType=6,itemId=2906,itemCount=1},
  [113] = {id=113,faId=1006,itemType=5,itemId=1,itemCount=20000},
  [114] = {id=114,faId=1006,itemType=5,itemId=2,itemCount=20000},
  [115] = {id=115,faId=1006,itemType=6,itemId=2602,itemCount=3},
  [116] = {id=116,faId=1007,itemType=5,itemId=1000,itemCount=35},
  [117] = {id=117,faId=1007,itemType=5,itemId=300,itemCount=15000},
  [118] = {id=118,faId=1007,itemType=13,itemId=1,itemCount=15000},
  [119] = {id=119,faId=1007,itemType=6,itemId=2906,itemCount=1},
  [120] = {id=120,faId=1007,itemType=5,itemId=1,itemCount=20000},
  [121] = {id=121,faId=1007,itemType=5,itemId=2,itemCount=20000},
  [122] = {id=122,faId=1007,itemType=6,itemId=2602,itemCount=3},
  [123] = {id=123,faId=1008,itemType=5,itemId=1000,itemCount=25},
  [124] = {id=124,faId=1008,itemType=5,itemId=300,itemCount=10000},
  [125] = {id=125,faId=1008,itemType=13,itemId=1,itemCount=10000},
  [126] = {id=126,faId=1008,itemType=6,itemId=2906,itemCount=1},
  [127] = {id=127,faId=1008,itemType=5,itemId=1,itemCount=20000},
  [128] = {id=128,faId=1008,itemType=5,itemId=2,itemCount=20000},
  [129] = {id=129,faId=1008,itemType=6,itemId=2602,itemCount=3},
  [130] = {id=130,faId=1009,itemType=5,itemId=1000,itemCount=25},
  [131] = {id=131,faId=1009,itemType=5,itemId=300,itemCount=5000},
  [132] = {id=132,faId=1009,itemType=13,itemId=1,itemCount=5000},
  [133] = {id=133,faId=1009,itemType=6,itemId=2906,itemCount=1},
  [134] = {id=134,faId=1009,itemType=5,itemId=1,itemCount=20000},
  [135] = {id=135,faId=1009,itemType=5,itemId=2,itemCount=20000},
  [136] = {id=136,faId=1009,itemType=6,itemId=2602,itemCount=3},
  [137] = {id=137,faId=1010,itemType=5,itemId=1000,itemCount=25},
  [138] = {id=138,faId=1010,itemType=5,itemId=300,itemCount=5000},
  [139] = {id=139,faId=1010,itemType=13,itemId=1,itemCount=5000},
  [140] = {id=140,faId=1010,itemType=6,itemId=2906,itemCount=1},
  [141] = {id=141,faId=1010,itemType=5,itemId=1,itemCount=20000},
  [142] = {id=142,faId=1010,itemType=5,itemId=2,itemCount=20000},
  [143] = {id=143,faId=1010,itemType=6,itemId=2602,itemCount=3},
  [144] = {id=144,faId=2001,itemType=5,itemId=1000,itemCount=3500},
  [145] = {id=145,faId=2001,itemType=5,itemId=300,itemCount=100000},
  [146] = {id=146,faId=2001,itemType=13,itemId=1,itemCount=100000},
  [147] = {id=147,faId=2001,itemType=7,itemId=103,itemCount=2},
  [148] = {id=148,faId=2001,itemType=7,itemId=203,itemCount=3},
  [149] = {id=149,faId=2001,itemType=7,itemId=503,itemCount=2},
  [150] = {id=150,faId=2001,itemType=5,itemId=1,itemCount=100000},
  [151] = {id=151,faId=2001,itemType=5,itemId=2,itemCount=100000},
  [152] = {id=152,faId=2002,itemType=5,itemId=1000,itemCount=2500},
  [153] = {id=153,faId=2002,itemType=5,itemId=300,itemCount=50000},
  [154] = {id=154,faId=2002,itemType=13,itemId=1,itemCount=50000},
  [155] = {id=155,faId=2002,itemType=7,itemId=103,itemCount=2},
  [156] = {id=156,faId=2002,itemType=7,itemId=203,itemCount=3},
  [157] = {id=157,faId=2002,itemType=7,itemId=503,itemCount=2},
  [158] = {id=158,faId=2002,itemType=5,itemId=1,itemCount=100000},
  [159] = {id=159,faId=2002,itemType=5,itemId=2,itemCount=100000},
  [160] = {id=160,faId=2003,itemType=5,itemId=1000,itemCount=2000},
  [161] = {id=161,faId=2003,itemType=5,itemId=300,itemCount=50000},
  [162] = {id=162,faId=2003,itemType=13,itemId=1,itemCount=50000},
  [163] = {id=163,faId=2003,itemType=7,itemId=103,itemCount=1},
  [164] = {id=164,faId=2003,itemType=7,itemId=203,itemCount=2},
  [165] = {id=165,faId=2003,itemType=7,itemId=503,itemCount=1},
  [166] = {id=166,faId=2003,itemType=5,itemId=1,itemCount=50000},
  [167] = {id=167,faId=2003,itemType=5,itemId=2,itemCount=50000},
  [168] = {id=168,faId=2004,itemType=5,itemId=1000,itemCount=1250},
  [169] = {id=169,faId=2004,itemType=5,itemId=300,itemCount=30000},
  [170] = {id=170,faId=2004,itemType=13,itemId=1,itemCount=30000},
  [171] = {id=171,faId=2004,itemType=7,itemId=103,itemCount=1},
  [172] = {id=172,faId=2004,itemType=7,itemId=203,itemCount=2},
  [173] = {id=173,faId=2004,itemType=7,itemId=503,itemCount=1},
  [174] = {id=174,faId=2004,itemType=5,itemId=1,itemCount=50000},
  [175] = {id=175,faId=2004,itemType=5,itemId=2,itemCount=50000},
  [176] = {id=176,faId=2005,itemType=5,itemId=1000,itemCount=500},
  [177] = {id=177,faId=2005,itemType=5,itemId=300,itemCount=10000},
  [178] = {id=178,faId=2005,itemType=13,itemId=1,itemCount=10000},
  [179] = {id=179,faId=2005,itemType=7,itemId=103,itemCount=1},
  [180] = {id=180,faId=2005,itemType=7,itemId=203,itemCount=2},
  [181] = {id=181,faId=2005,itemType=7,itemId=503,itemCount=1},
  [182] = {id=182,faId=2005,itemType=5,itemId=1,itemCount=30000},
  [183] = {id=183,faId=2005,itemType=5,itemId=2,itemCount=30000},
  [184] = {id=184,faId=2006,itemType=5,itemId=1000,itemCount=250},
  [185] = {id=185,faId=2006,itemType=5,itemId=300,itemCount=5000},
  [186] = {id=186,faId=2006,itemType=13,itemId=1,itemCount=5000},
  [187] = {id=187,faId=2006,itemType=7,itemId=103,itemCount=1},
  [188] = {id=188,faId=2007,itemType=5,itemId=1000,itemCount=200},
  [189] = {id=189,faId=2007,itemType=5,itemId=300,itemCount=5000},
  [190] = {id=190,faId=2007,itemType=13,itemId=1,itemCount=5000},
  [191] = {id=191,faId=2007,itemType=7,itemId=103,itemCount=1},
  [192] = {id=192,faId=2008,itemType=5,itemId=1000,itemCount=150},
  [193] = {id=193,faId=2008,itemType=5,itemId=300,itemCount=5000},
  [194] = {id=194,faId=2008,itemType=13,itemId=1,itemCount=5000},
  [195] = {id=195,faId=2008,itemType=7,itemId=103,itemCount=1},
  [196] = {id=196,faId=2009,itemType=5,itemId=1000,itemCount=100},
  [197] = {id=197,faId=2009,itemType=5,itemId=300,itemCount=5000},
  [198] = {id=198,faId=2009,itemType=13,itemId=1,itemCount=5000},
  [199] = {id=199,faId=2009,itemType=7,itemId=103,itemCount=1},
  [200] = {id=200,faId=2010,itemType=5,itemId=1000,itemCount=50},
  [201] = {id=201,faId=2010,itemType=5,itemId=300,itemCount=5000},
  [202] = {id=202,faId=2010,itemType=13,itemId=1,itemCount=5000},
  [203] = {id=203,faId=2010,itemType=7,itemId=103,itemCount=1},
  [204] = {id=204,faId=10001,itemType=5,itemId=1000,itemCount=1000},
  [205] = {id=205,faId=10002,itemType=5,itemId=1000,itemCount=500},
  [206] = {id=206,faId=10003,itemType=5,itemId=1000,itemCount=250},
  [207] = {id=207,faId=10004,itemType=5,itemId=1000,itemCount=125},
  [208] = {id=208,faId=10005,itemType=5,itemId=1000,itemCount=75},
  [209] = {id=209,faId=10006,itemType=5,itemId=1000,itemCount=50},
  [210] = {id=210,faId=10007,itemType=5,itemId=1000,itemCount=45},
  [211] = {id=211,faId=10008,itemType=5,itemId=1000,itemCount=40},
  [212] = {id=212,faId=10009,itemType=5,itemId=1000,itemCount=35},
  [213] = {id=213,faId=10010,itemType=5,itemId=1000,itemCount=30},
  [214] = {id=214,faId=10011,itemType=5,itemId=1000,itemCount=30},
  [215] = {id=215,faId=10020,itemType=5,itemId=1000,itemCount=25},
  [216] = {id=216,faId=10030,itemType=5,itemId=1000,itemCount=20},
  [217] = {id=217,faId=10040,itemType=5,itemId=1000,itemCount=15},
  [218] = {id=218,faId=10050,itemType=5,itemId=1000,itemCount=10},
  [219] = {id=219,faId=10060,itemType=5,itemId=1000,itemCount=10},
  [220] = {id=220,faId=10070,itemType=5,itemId=1000,itemCount=10},
  [221] = {id=221,faId=10080,itemType=5,itemId=1000,itemCount=10},
  [222] = {id=222,faId=10090,itemType=5,itemId=1000,itemCount=10},
  [223] = {id=223,faId=10001,itemType=5,itemId=300,itemCount=20000},
  [224] = {id=224,faId=10002,itemType=5,itemId=300,itemCount=16000},
  [225] = {id=225,faId=10003,itemType=5,itemId=300,itemCount=12000},
  [226] = {id=226,faId=10004,itemType=5,itemId=300,itemCount=8000},
  [227] = {id=227,faId=10005,itemType=5,itemId=300,itemCount=7000},
  [228] = {id=228,faId=10006,itemType=5,itemId=300,itemCount=6000},
  [229] = {id=229,faId=10007,itemType=5,itemId=300,itemCount=5000},
  [230] = {id=230,faId=10008,itemType=5,itemId=300,itemCount=4000},
  [231] = {id=231,faId=10009,itemType=5,itemId=300,itemCount=3000},
  [232] = {id=232,faId=10010,itemType=5,itemId=300,itemCount=2000},
  [233] = {id=233,faId=10011,itemType=5,itemId=300,itemCount=1800},
  [234] = {id=234,faId=10020,itemType=5,itemId=300,itemCount=1600},
  [235] = {id=235,faId=10030,itemType=5,itemId=300,itemCount=1400},
  [236] = {id=236,faId=10040,itemType=5,itemId=300,itemCount=1200},
  [237] = {id=237,faId=10050,itemType=5,itemId=300,itemCount=1000},
  [238] = {id=238,faId=10060,itemType=5,itemId=300,itemCount=800},
  [239] = {id=239,faId=10070,itemType=5,itemId=300,itemCount=600},
  [240] = {id=240,faId=10080,itemType=5,itemId=300,itemCount=400},
  [241] = {id=241,faId=10090,itemType=5,itemId=300,itemCount=200},
  [242] = {id=242,faId=10001,itemType=13,itemId=1,itemCount=20000},
  [243] = {id=243,faId=10002,itemType=13,itemId=1,itemCount=16000},
  [244] = {id=244,faId=10003,itemType=13,itemId=1,itemCount=12000},
  [245] = {id=245,faId=10004,itemType=13,itemId=1,itemCount=8000},
  [246] = {id=246,faId=10005,itemType=13,itemId=1,itemCount=7000},
  [247] = {id=247,faId=10006,itemType=13,itemId=1,itemCount=6000},
  [248] = {id=248,faId=10007,itemType=13,itemId=1,itemCount=5000},
  [249] = {id=249,faId=10008,itemType=13,itemId=1,itemCount=4000},
  [250] = {id=250,faId=10009,itemType=13,itemId=1,itemCount=3000},
  [251] = {id=251,faId=10010,itemType=13,itemId=1,itemCount=2000},
  [252] = {id=252,faId=10011,itemType=13,itemId=1,itemCount=1800},
  [253] = {id=253,faId=10020,itemType=13,itemId=1,itemCount=1600},
  [254] = {id=254,faId=10030,itemType=13,itemId=1,itemCount=1400},
  [255] = {id=255,faId=10040,itemType=13,itemId=1,itemCount=1200},
  [256] = {id=256,faId=10050,itemType=13,itemId=1,itemCount=1000},
  [257] = {id=257,faId=10060,itemType=13,itemId=1,itemCount=800},
  [258] = {id=258,faId=10070,itemType=13,itemId=1,itemCount=600},
  [259] = {id=259,faId=10080,itemType=13,itemId=1,itemCount=400},
  [260] = {id=260,faId=10090,itemType=13,itemId=1,itemCount=200},
  [261] = {id=261,faId=10001,itemType=8,itemId=19,itemCount=30},
  [262] = {id=262,faId=10002,itemType=8,itemId=19,itemCount=20},
  [263] = {id=263,faId=10003,itemType=8,itemId=19,itemCount=10},
  [264] = {id=264,faId=10004,itemType=8,itemId=19,itemCount=9},
  [265] = {id=265,faId=10005,itemType=8,itemId=19,itemCount=8},
  [266] = {id=266,faId=10006,itemType=8,itemId=19,itemCount=7},
  [267] = {id=267,faId=10007,itemType=8,itemId=19,itemCount=7},
  [268] = {id=268,faId=10008,itemType=8,itemId=19,itemCount=7},
  [269] = {id=269,faId=10009,itemType=8,itemId=19,itemCount=7},
  [270] = {id=270,faId=10010,itemType=8,itemId=19,itemCount=6},
  [271] = {id=271,faId=10011,itemType=8,itemId=19,itemCount=5},
  [272] = {id=272,faId=10020,itemType=8,itemId=19,itemCount=4},
  [273] = {id=273,faId=10030,itemType=8,itemId=19,itemCount=4},
  [274] = {id=274,faId=10040,itemType=8,itemId=19,itemCount=3},
  [275] = {id=275,faId=10050,itemType=8,itemId=19,itemCount=3},
  [276] = {id=276,faId=10060,itemType=8,itemId=19,itemCount=2},
  [277] = {id=277,faId=10070,itemType=8,itemId=19,itemCount=3},
  [278] = {id=278,faId=10080,itemType=8,itemId=19,itemCount=1},
  [279] = {id=279,faId=10090,itemType=8,itemId=19,itemCount=1},
  [280] = {id=280,faId=11001,itemType=5,itemId=1000,itemCount=5000},
  [281] = {id=281,faId=11002,itemType=5,itemId=1000,itemCount=2500},
  [282] = {id=282,faId=11003,itemType=5,itemId=1000,itemCount=1250},
  [283] = {id=283,faId=11004,itemType=5,itemId=1000,itemCount=625},
  [284] = {id=284,faId=11005,itemType=5,itemId=1000,itemCount=375},
  [285] = {id=285,faId=11006,itemType=5,itemId=1000,itemCount=250},
  [286] = {id=286,faId=11007,itemType=5,itemId=1000,itemCount=225},
  [287] = {id=287,faId=11008,itemType=5,itemId=1000,itemCount=200},
  [288] = {id=288,faId=11009,itemType=5,itemId=1000,itemCount=175},
  [289] = {id=289,faId=11010,itemType=5,itemId=1000,itemCount=160},
  [290] = {id=290,faId=11011,itemType=5,itemId=1000,itemCount=150},
  [291] = {id=291,faId=11020,itemType=5,itemId=1000,itemCount=125},
  [292] = {id=292,faId=11030,itemType=5,itemId=1000,itemCount=100},
  [293] = {id=293,faId=11040,itemType=5,itemId=1000,itemCount=75},
  [294] = {id=294,faId=11050,itemType=5,itemId=1000,itemCount=60},
  [295] = {id=295,faId=11060,itemType=5,itemId=1000,itemCount=50},
  [296] = {id=296,faId=11070,itemType=5,itemId=1000,itemCount=35},
  [297] = {id=297,faId=11080,itemType=5,itemId=1000,itemCount=25},
  [298] = {id=298,faId=11090,itemType=5,itemId=1000,itemCount=20},
  [299] = {id=299,faId=11001,itemType=5,itemId=300,itemCount=100000},
  [300] = {id=300,faId=11002,itemType=5,itemId=300,itemCount=80000},
  [301] = {id=301,faId=11003,itemType=5,itemId=300,itemCount=60000},
  [302] = {id=302,faId=11004,itemType=5,itemId=300,itemCount=40000},
  [303] = {id=303,faId=11005,itemType=5,itemId=300,itemCount=35000},
  [304] = {id=304,faId=11006,itemType=5,itemId=300,itemCount=30000},
  [305] = {id=305,faId=11007,itemType=5,itemId=300,itemCount=25000},
  [306] = {id=306,faId=11008,itemType=5,itemId=300,itemCount=20000},
  [307] = {id=307,faId=11009,itemType=5,itemId=300,itemCount=15000},
  [308] = {id=308,faId=11010,itemType=5,itemId=300,itemCount=10000},
  [309] = {id=309,faId=11011,itemType=5,itemId=300,itemCount=9000},
  [310] = {id=310,faId=11020,itemType=5,itemId=300,itemCount=8000},
  [311] = {id=311,faId=11030,itemType=5,itemId=300,itemCount=7000},
  [312] = {id=312,faId=11040,itemType=5,itemId=300,itemCount=6000},
  [313] = {id=313,faId=11050,itemType=5,itemId=300,itemCount=5000},
  [314] = {id=314,faId=11060,itemType=5,itemId=300,itemCount=4000},
  [315] = {id=315,faId=11070,itemType=5,itemId=300,itemCount=3000},
  [316] = {id=316,faId=11080,itemType=5,itemId=300,itemCount=2000},
  [317] = {id=317,faId=11090,itemType=5,itemId=300,itemCount=1000},
  [318] = {id=318,faId=11001,itemType=13,itemId=1,itemCount=100000},
  [319] = {id=319,faId=11002,itemType=13,itemId=1,itemCount=80000},
  [320] = {id=320,faId=11003,itemType=13,itemId=1,itemCount=60000},
  [321] = {id=321,faId=11004,itemType=13,itemId=1,itemCount=40000},
  [322] = {id=322,faId=11005,itemType=13,itemId=1,itemCount=35000},
  [323] = {id=323,faId=11006,itemType=13,itemId=1,itemCount=30000},
  [324] = {id=324,faId=11007,itemType=13,itemId=1,itemCount=25000},
  [325] = {id=325,faId=11008,itemType=13,itemId=1,itemCount=20000},
  [326] = {id=326,faId=11009,itemType=13,itemId=1,itemCount=15000},
  [327] = {id=327,faId=11010,itemType=13,itemId=1,itemCount=10000},
  [328] = {id=328,faId=11011,itemType=13,itemId=1,itemCount=9000},
  [329] = {id=329,faId=11020,itemType=13,itemId=1,itemCount=8000},
  [330] = {id=330,faId=11030,itemType=13,itemId=1,itemCount=7000},
  [331] = {id=331,faId=11040,itemType=13,itemId=1,itemCount=6000},
  [332] = {id=332,faId=11050,itemType=13,itemId=1,itemCount=5000},
  [333] = {id=333,faId=11060,itemType=13,itemId=1,itemCount=4000},
  [334] = {id=334,faId=11070,itemType=13,itemId=1,itemCount=3000},
  [335] = {id=335,faId=11080,itemType=13,itemId=1,itemCount=2000},
  [336] = {id=336,faId=11090,itemType=13,itemId=1,itemCount=1000},
  [337] = {id=337,faId=11001,itemType=7,itemId=2,itemCount=50},
  [338] = {id=338,faId=11002,itemType=7,itemId=2,itemCount=40},
  [339] = {id=339,faId=11003,itemType=7,itemId=2,itemCount=30},
  [340] = {id=340,faId=11004,itemType=7,itemId=2,itemCount=20},
  [341] = {id=341,faId=11005,itemType=7,itemId=2,itemCount=20},
  [342] = {id=342,faId=11006,itemType=7,itemId=2,itemCount=15},
  [343] = {id=343,faId=11007,itemType=7,itemId=2,itemCount=15},
  [344] = {id=344,faId=11008,itemType=7,itemId=2,itemCount=15},
  [345] = {id=345,faId=11009,itemType=7,itemId=2,itemCount=15},
  [346] = {id=346,faId=11010,itemType=7,itemId=2,itemCount=13},
  [347] = {id=347,faId=11011,itemType=7,itemId=2,itemCount=12},
  [348] = {id=348,faId=11020,itemType=7,itemId=2,itemCount=10},
  [349] = {id=349,faId=11030,itemType=7,itemId=2,itemCount=8},
  [350] = {id=350,faId=11040,itemType=7,itemId=2,itemCount=6},
  [351] = {id=351,faId=11050,itemType=7,itemId=2,itemCount=5},
  [352] = {id=352,faId=11060,itemType=7,itemId=2,itemCount=4},
  [353] = {id=353,faId=11070,itemType=7,itemId=2,itemCount=3},
  [354] = {id=354,faId=11080,itemType=7,itemId=2,itemCount=2},
  [355] = {id=355,faId=11090,itemType=7,itemId=2,itemCount=1},
  [356] = {id=356,faId=12001,itemType=5,itemId=1000,itemCount=10000},
  [357] = {id=357,faId=12002,itemType=5,itemId=1000,itemCount=5000},
  [358] = {id=358,faId=12003,itemType=5,itemId=1000,itemCount=2500},
  [359] = {id=359,faId=12004,itemType=5,itemId=1000,itemCount=1250},
  [360] = {id=360,faId=12005,itemType=5,itemId=1000,itemCount=750},
  [361] = {id=361,faId=12006,itemType=5,itemId=1000,itemCount=500},
  [362] = {id=362,faId=12007,itemType=5,itemId=1000,itemCount=450},
  [363] = {id=363,faId=12008,itemType=5,itemId=1000,itemCount=400},
  [364] = {id=364,faId=12009,itemType=5,itemId=1000,itemCount=350},
  [365] = {id=365,faId=12010,itemType=5,itemId=1000,itemCount=320},
  [366] = {id=366,faId=12011,itemType=5,itemId=1000,itemCount=300},
  [367] = {id=367,faId=12020,itemType=5,itemId=1000,itemCount=250},
  [368] = {id=368,faId=12030,itemType=5,itemId=1000,itemCount=200},
  [369] = {id=369,faId=12040,itemType=5,itemId=1000,itemCount=150},
  [370] = {id=370,faId=12050,itemType=5,itemId=1000,itemCount=125},
  [371] = {id=371,faId=12060,itemType=5,itemId=1000,itemCount=60},
  [372] = {id=372,faId=12070,itemType=5,itemId=1000,itemCount=75},
  [373] = {id=373,faId=12080,itemType=5,itemId=1000,itemCount=35},
  [374] = {id=374,faId=12090,itemType=5,itemId=1000,itemCount=25},
  [375] = {id=375,faId=12001,itemType=5,itemId=300,itemCount=200000},
  [376] = {id=376,faId=12002,itemType=5,itemId=300,itemCount=160000},
  [377] = {id=377,faId=12003,itemType=5,itemId=300,itemCount=120000},
  [378] = {id=378,faId=12004,itemType=5,itemId=300,itemCount=80000},
  [379] = {id=379,faId=12005,itemType=5,itemId=300,itemCount=70000},
  [380] = {id=380,faId=12006,itemType=5,itemId=300,itemCount=60000},
  [381] = {id=381,faId=12007,itemType=5,itemId=300,itemCount=50000},
  [382] = {id=382,faId=12008,itemType=5,itemId=300,itemCount=40000},
  [383] = {id=383,faId=12009,itemType=5,itemId=300,itemCount=30000},
  [384] = {id=384,faId=12010,itemType=5,itemId=300,itemCount=20000},
  [385] = {id=385,faId=12011,itemType=5,itemId=300,itemCount=18000},
  [386] = {id=386,faId=12020,itemType=5,itemId=300,itemCount=16000},
  [387] = {id=387,faId=12030,itemType=5,itemId=300,itemCount=14000},
  [388] = {id=388,faId=12040,itemType=5,itemId=300,itemCount=12000},
  [389] = {id=389,faId=12050,itemType=5,itemId=300,itemCount=10000},
  [390] = {id=390,faId=12060,itemType=5,itemId=300,itemCount=8000},
  [391] = {id=391,faId=12070,itemType=5,itemId=300,itemCount=6000},
  [392] = {id=392,faId=12080,itemType=5,itemId=300,itemCount=4000},
  [393] = {id=393,faId=12090,itemType=5,itemId=300,itemCount=2000},
  [394] = {id=394,faId=12001,itemType=13,itemId=1,itemCount=200000},
  [395] = {id=395,faId=12002,itemType=13,itemId=1,itemCount=160000},
  [396] = {id=396,faId=12003,itemType=13,itemId=1,itemCount=120000},
  [397] = {id=397,faId=12004,itemType=13,itemId=1,itemCount=80000},
  [398] = {id=398,faId=12005,itemType=13,itemId=1,itemCount=70000},
  [399] = {id=399,faId=12006,itemType=13,itemId=1,itemCount=60000},
  [400] = {id=400,faId=12007,itemType=13,itemId=1,itemCount=50000},
  [401] = {id=401,faId=12008,itemType=13,itemId=1,itemCount=40000},
  [402] = {id=402,faId=12009,itemType=13,itemId=1,itemCount=30000},
  [403] = {id=403,faId=12010,itemType=13,itemId=1,itemCount=20000},
  [404] = {id=404,faId=12011,itemType=13,itemId=1,itemCount=18000},
  [405] = {id=405,faId=12020,itemType=13,itemId=1,itemCount=16000},
  [406] = {id=406,faId=12030,itemType=13,itemId=1,itemCount=14000},
  [407] = {id=407,faId=12040,itemType=13,itemId=1,itemCount=12000},
  [408] = {id=408,faId=12050,itemType=13,itemId=1,itemCount=10000},
  [409] = {id=409,faId=12060,itemType=13,itemId=1,itemCount=8000},
  [410] = {id=410,faId=12070,itemType=13,itemId=1,itemCount=6000},
  [411] = {id=411,faId=12080,itemType=13,itemId=1,itemCount=4000},
  [412] = {id=412,faId=12090,itemType=13,itemId=1,itemCount=2000},
  [413] = {id=413,faId=12001,itemType=6,itemId=3404,itemCount=30},
  [414] = {id=414,faId=12002,itemType=6,itemId=3404,itemCount=25},
  [415] = {id=415,faId=12003,itemType=6,itemId=3404,itemCount=20},
  [416] = {id=416,faId=12004,itemType=6,itemId=3404,itemCount=15},
  [417] = {id=417,faId=12005,itemType=6,itemId=3404,itemCount=12},
  [418] = {id=418,faId=12006,itemType=6,itemId=3404,itemCount=11},
  [419] = {id=419,faId=12007,itemType=6,itemId=3404,itemCount=10},
  [420] = {id=420,faId=12008,itemType=6,itemId=3404,itemCount=9},
  [421] = {id=421,faId=12009,itemType=6,itemId=3404,itemCount=8},
  [422] = {id=422,faId=12010,itemType=6,itemId=3404,itemCount=7},
  [423] = {id=423,faId=12011,itemType=6,itemId=3404,itemCount=6},
  [424] = {id=424,faId=12020,itemType=6,itemId=3403,itemCount=25},
  [425] = {id=425,faId=12030,itemType=6,itemId=3403,itemCount=20},
  [426] = {id=426,faId=12040,itemType=6,itemId=3403,itemCount=16},
  [427] = {id=427,faId=12050,itemType=6,itemId=3403,itemCount=14},
  [428] = {id=428,faId=12060,itemType=6,itemId=3402,itemCount=30},
  [429] = {id=429,faId=12070,itemType=6,itemId=3402,itemCount=25},
  [430] = {id=430,faId=12080,itemType=6,itemId=3402,itemCount=20},
  [431] = {id=431,faId=12090,itemType=6,itemId=3401,itemCount=50}
}
return DFunctionAwards