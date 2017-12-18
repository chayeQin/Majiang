-- g_广播公告文字表.xlsx
-- id=编号,content=文本内容,
local DBroadcast = {
  [1] = {id=1,content="{1}' is lucky enough to forge a purple '{2}' in Forging Factory!"},
  [2] = {id=2,content="{1}' is lucky enough to forge a red '{2}' in Forging Factory!"},
  [3] = {id=3,content="{1}' is lucky enough to forge an orange '{2}' in Forging Factory!"},
  [4] = {id=4,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 3!"},
  [5] = {id=5,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 5!"},
  [6] = {id=6,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 6!"},
  [7] = {id=7,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 7!"},
  [8] = {id=8,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 8!"},
  [9] = {id=9,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 9!"},
  [10] = {id=10,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 10!"},
  [11] = {id=11,content="Under '{1}' unremitting efforts, he upgraded mecha '{2}{3}' to lvl 11!"},
  [12] = {id=12,content="Millionaire '{1}' invested large amount of resources in '{2}{3}' and won the first place!"},
  [15] = {id=15,content="Under '{1}' unremitting efforts, he upgraded Age to 'Genesis Age Lv.3'!"},
  [16] = {id=16,content="Under '{1}' unremitting efforts, he upgraded Age to 'Genesis Age Lv.5'!"},
  [17] = {id=17,content="Under '{1}' unremitting efforts, he upgraded Age to 'Star Age Lv.3'!"},
  [18] = {id=18,content="Under '{1}' unremitting efforts, he upgraded Age to 'Star Age Lv.5'!"},
  [19] = {id=19,content="Under '{1}' unremitting efforts, he upgraded Age to 'Infinite Age Lv.1'!"},
  [20] = {id=20,content="Under '{1}' unremitting efforts, he upgraded Age to 'Infinite Age Lv.2'!"},
  [21] = {id=21,content="Under '{1}' unremitting efforts, he upgraded Age to 'Infinite Age Lv.3'!"},
  [22] = {id=22,content="Under '{1}' unremitting efforts, he upgraded Age to 'Infinite Age Lv.4'!"},
  [23] = {id=23,content="Under '{1}' unremitting efforts, he upgraded Age to 'Infinite Age Lv.5'!"},
  [24] = {id=24,content="Under '{1}' unremitting efforts, he upgraded Age to 'Empty Age Lv.1'!"},
  [25] = {id=25,content="Under '{1}' unremitting efforts, he upgraded Age to 'Empty Age Lv.2'!"},
  [26] = {id=26,content="Under '{1}' unremitting efforts, he upgraded Age to 'Empty Age Lv.3'!"},
  [27] = {id=27,content="Under '{1}' unremitting efforts, he upgraded Age to 'Empty Age Lv.4'!"},
  [28] = {id=28,content="Under '{1}' unremitting efforts, he upgraded Age to 'Empty Age Lv.5'!"},
  [29] = {id=29,content="Under '{1}' unremitting efforts, he upgraded Age to 'welkin Age Lv.1'!"},
  [30] = {id=30,content="Under '{1}' unremitting efforts, he upgraded Age to 'welkin Age Lv.2'!"},
  [31] = {id=31,content="Under '{1}' unremitting efforts, he upgraded Age to 'welkin Age Lv.3'!"},
  [32] = {id=32,content="Under '{1}' unremitting efforts, he upgraded Age to 'welkin Age Lv.4'!"},
  [33] = {id=33,content="Under '{1}' unremitting efforts, he upgraded Age to 'welkin Age Lv.5'!"},
  [34] = {id=34,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 3!"},
  [35] = {id=35,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 5!"},
  [36] = {id=36,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 8!"},
  [37] = {id=37,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 9!"},
  [38] = {id=38,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 10!"},
  [39] = {id=39,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 11!"},
  [40] = {id=40,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 12!"},
  [41] = {id=41,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 13!"},
  [42] = {id=42,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 14!"},
  [43] = {id=43,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 15!"},
  [44] = {id=44,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 16!"},
  [45] = {id=45,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 17!"},
  [46] = {id=46,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 18!"},
  [47] = {id=47,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 19!"},
  [48] = {id=48,content="VIP privileges, the pursuit of high-end players. '{1}' upgraded VIP to lvl 20!"},
  [49] = {id=49,content="The fleet of '{1}' is expanding and defeated lvl 3 galaxy pirates!"},
  [50] = {id=50,content="The fleet of '{1}' is expanding and defeated lvl 5 galaxy pirates!"},
  [51] = {id=51,content="The fleet of '{1}' is expanding and defeated lvl 8 galaxy pirates!"},
  [52] = {id=52,content="The fleet of '{1}' is expanding and defeated lvl 10 galaxy pirates!"},
  [53] = {id=53,content="The fleet of '{1}' is expanding and defeated lvl 11 galaxy pirates!"},
  [54] = {id=54,content="The fleet of '{1}' is expanding and defeated lvl 12 galaxy pirates!"},
  [55] = {id=55,content="The fleet of '{1}' is expanding and defeated lvl 13 galaxy pirates!"},
  [56] = {id=56,content="The fleet of '{1}' is expanding and defeated lvl 14 galaxy pirates!"},
  [57] = {id=57,content="The fleet of '{1}' is expanding and defeated lvl 15 galaxy pirates!"},
  [58] = {id=58,content="The fleet of '{1}' is expanding and defeated lvl 16 galaxy pirates!"},
  [59] = {id=59,content="The fleet of '{1}' is expanding and defeated lvl 17 galaxy pirates!"},
  [60] = {id=60,content="The fleet of '{1}' is expanding and defeated lvl 18 galaxy pirates!"},
  [61] = {id=61,content="The fleet of '{1}' is expanding and defeated lvl 19 galaxy pirates!"},
  [62] = {id=62,content="The fleet of '{1}' is expanding and defeated lvl 20 galaxy pirates!"},
  [63] = {id=63,content="The fleet of '{1}' is expanding and defeated lvl 21 galaxy pirates!"},
  [64] = {id=64,content="The fleet of '{1}' is expanding and defeated lvl 22 galaxy pirates!"},
  [65] = {id=65,content="The fleet of '{1}' is expanding and defeated lvl 23 galaxy pirates!"},
  [66] = {id=66,content="The fleet of '{1}' is expanding and defeated lvl 24 galaxy pirates!"},
  [67] = {id=67,content="The fleet of '{1}' is expanding and defeated lvl 25 galaxy pirates!"},
  [68] = {id=68,content="The fleet of '{1}' is expanding and defeated lvl 26 galaxy pirates!"},
  [69] = {id=69,content="The fleet of '{1}' is expanding and defeated lvl 27 galaxy pirates!"},
  [70] = {id=70,content="The fleet of '{1}' is expanding and defeated lvl 28 galaxy pirates!"},
  [71] = {id=71,content="The fleet of '{1}' is expanding and defeated lvl 29 galaxy pirates!"},
  [72] = {id=72,content="The fleet of '{1}' is expanding and defeated lvl 30 galaxy pirates!"},
  [73] = {id=73,content="Millionaire '{1}' is so nice! 188 diamonds are waiting for you!"},
  [74] = {id=74,content="Millionaire '{1}' is so nice! 888 diamonds are waiting for you!"},
  [75] = {id=75,content="Millionaire '{1}' is so nice! 1888 diamonds are waiting for you!"},
  [76] = {id=76,content="Millionaire '{1}' is so nice! 3888 diamonds are waiting for you!"},
  [77] = {id=77,content="Battle of Mastership has started. Please organize all players to start the war!"},
  [78] = {id=78,content="Battle of Mastership was over. '{1}' controls the star fortress and becomes the galaxy overlord!"},
  [79] = {id=79,content="Battle of Mastership is going on! '{1}' successfully occupied the star fortress. Count down begins!"},
  [80] = {id=80,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [81] = {id=81,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [82] = {id=82,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [83] = {id=83,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [84] = {id=84,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [85] = {id=85,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [86] = {id=86,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [87] = {id=87,content="‘{1}’made great contribution in Battle of Mastership. Galaxy Overlord appointed him '{2}'. Congratulations!"},
  [88] = {id=88,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [89] = {id=89,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [90] = {id=90,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [91] = {id=91,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [92] = {id=92,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [93] = {id=93,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [94] = {id=94,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [95] = {id=95,content="‘{1}’was detested by Galaxy Overlord and dismissed him as '{2}'. Ley's mourn for him!"},
  [96] = {id=96,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [97] = {id=97,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [98] = {id=98,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [99] = {id=99,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [100] = {id=100,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [101] = {id=101,content="{1}'possess the potential of the rich and purchased a '{2}'!"},
  [102] = {id=102,content="Own a card, own the world. '{1}' bought 'Second Queue Card'. No worry to update constructions!"},
  [103] = {id=103,content="A diamond is forever. '{1}' bought 'Preferential Diamond Card'. Free diamonds everyday!"},
  [104] = {id=104,content="{1}' bought 'Preferential Construction Card'. Large amount of resources everyday!"},
  [105] = {id=105,content="{1}' bought 'Novice Pack Lv.1'. Early development will be speedup!"},
  [106] = {id=106,content="{1}' bought 'Novice Pack Lv.2'. Early development will be speedup!"},
  [107] = {id=107,content="{1}' bought 'Primary Federation Pack'. Cheer for him!"},
  [108] = {id=108,content="{1}' bought 'Advanced Federation Pack'. Cheer for him!"},
  [109] = {id=109,content="{1}' bought 'Commander Value Pack Lv.1'. You can quickly upgrade the commander attributes!"},
  [110] = {id=110,content="{1}' bought 'Commander Value Pack Lv.2'. You can quickly upgrade the commander attributes!"},
  [111] = {id=111,content="{1}' bought 'Commander Value Pack Lv.3'. You can quickly upgrade the commander attributes!"},
  [112] = {id=112,content="{1}' bought 'Warship Value Pack Lv.1'. Making warships is so easy!"},
  [113] = {id=113,content="{1}' bought 'Warship Value Pack Lv.2'. Making warships is so easy!"},
  [114] = {id=114,content="{1}' bought 'Warship Value Pack Lv.3'. Making warships is so easy!"},
  [115] = {id=115,content="{1}' bought 'Technology Value Pack Lv.1'. I am the technology talent!"},
  [116] = {id=116,content="{1}' bought 'Technology Value Pack Lv.2'. I am the technology talent!"},
  [117] = {id=117,content="{1}' bought 'Technology Value Pack Lv.3'. I am the technology talent!"},
  [118] = {id=118,content="{1}' bought 'Equipment Value Pack Lv.1'. Advanced equip is readily available!"},
  [119] = {id=119,content="{1}' bought 'Equipment Value Pack Lv.2'. Advanced equip is readily available!"},
  [120] = {id=120,content="{1}' bought 'Equipment Value Pack Lv.3'. Advanced equip is readily available!"},
  [121] = {id=121,content="{1}' bought 'Mecha Value Pack Lv.1'. Fast upgrading mecha, making super warship!"},
  [122] = {id=122,content="{1}' bought 'Mecha Value Pack Lv.2'. Fast upgrading mecha, making super warship!"},
  [123] = {id=123,content="{1}' bought 'Mecha Value Pack Lv.3'. Fast upgrading mecha, making super warship!"},
  [124] = {id=124,content="Infinite Interstellar, honourable overlord. The star overlord {1} is online!"},
  [125] = {id=125,content="{1} has killed {2} Federation Boss successfully. {3} Federation Boss gets stronger!"},
  [126] = {id=126,content="{1}' bought 'Commander Value Pack Lv.4'. You can quickly upgrade the commander attributes!"},
  [127] = {id=127,content="{1}' bought 'Commander Value Pack Lv.5'. You can quickly upgrade the commander attributes!"},
  [128] = {id=128,content="{1}' bought 'Warship Value Pack Lv.4'. Making warships is so easy!"},
  [129] = {id=129,content="{1}' bought 'Warship Value Pack Lv.5'. Making warships is so easy!"},
  [130] = {id=130,content="{1}' bought 'Technology Value Pack Lv.4'. I am the technology talent!"},
  [131] = {id=131,content="{1}' bought 'Technology Value Pack Lv.5'. I am the technology talent!"},
  [132] = {id=132,content="{1}' bought 'Equipment Value Pack Lv.4'. Advanced equip is readily available!"},
  [133] = {id=133,content="{1}' bought 'Equipment Value Pack Lv.5'. Advanced equip is readily available!"},
  [134] = {id=134,content="{1}' bought 'Mecha Value Pack Lv.4'. Fast upgrading mecha, making super warship!"},
  [135] = {id=135,content="{1}' bought 'Mecha Value Pack Lv.5'. Fast upgrading mecha, making super warship!"},
  [136] = {id=136,content="'{1}' lucky out, in the diamond won the treasure in the '{2}', we also quickly get together treasure it!"}
}
return DBroadcast