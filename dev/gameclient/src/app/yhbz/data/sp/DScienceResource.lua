-- k_科研所科技资源文字表.xlsx
-- id=编号,name=名称,explain=说明,
local DScienceResource = {
  [1] = {id=1,name="Producción de Metal I",explain="Incrementar la producción de Metal"},
  [2] = {id=2,name="Producción de Metal I",explain="Incrementar la producción de Metal"},
  [3] = {id=3,name="Producción de Metal I",explain="Incrementar la producción de Metal"},
  [4] = {id=4,name="Producción de Metal I",explain="Incrementar la producción de Metal"},
  [5] = {id=5,name="Producción de Metal I",explain="Incrementar la producción de Metal"},
  [101] = {id=101,name="Producción de Combustible I",explain="Incrementar la producción de Combustible"},
  [102] = {id=102,name="Producción de Combustible I",explain="Incrementar la producción de Combustible"},
  [103] = {id=103,name="Producción de Combustible I",explain="Incrementar la producción de Combustible"},
  [104] = {id=104,name="Producción de Combustible I",explain="Incrementar la producción de Combustible"},
  [105] = {id=105,name="Producción de Combustible I",explain="Incrementar la producción de Combustible"},
  [201] = {id=201,name="Almacén I",explain="Incrementar los recursos protegidos en el Almacén"},
  [202] = {id=202,name="Almacén I",explain="Incrementar los recursos protegidos en el Almacén"},
  [203] = {id=203,name="Almacén I",explain="Incrementar los recursos protegidos en el Almacén"},
  [204] = {id=204,name="Almacén I",explain="Incrementar los recursos protegidos en el Almacén"},
  [205] = {id=205,name="Almacén I",explain="Incrementar los recursos protegidos en el Almacén"},
  [301] = {id=301,name="Refinación de Metal I",explain="Acelerar la recolección mundial de Metal"},
  [302] = {id=302,name="Refinación de Metal I",explain="Acelerar la recolección mundial de Metal"},
  [303] = {id=303,name="Refinación de Metal I",explain="Acelerar la recolección mundial de Metal"},
  [304] = {id=304,name="Refinación de Metal I",explain="Acelerar la recolección mundial de Metal"},
  [305] = {id=305,name="Refinación de Metal I",explain="Acelerar la recolección mundial de Metal"},
  [401] = {id=401,name="Refinación de Gas",explain="Acelerar la recolección mundial de Combustible"},
  [402] = {id=402,name="Refinación de Gas",explain="Acelerar la recolección mundial de Combustible"},
  [403] = {id=403,name="Refinación de Gas",explain="Acelerar la recolección mundial de Combustible"},
  [404] = {id=404,name="Refinación de Gas",explain="Acelerar la recolección mundial de Combustible"},
  [405] = {id=405,name="Refinación de Gas",explain="Acelerar la recolección mundial de Combustible"},
  [501] = {id=501,name="Producción de Energía I",explain="Incrementar la producción de Energía"},
  [502] = {id=502,name="Producción de Energía I",explain="Incrementar la producción de Energía"},
  [503] = {id=503,name="Producción de Energía I",explain="Incrementar la producción de Energía"},
  [504] = {id=504,name="Producción de Energía I",explain="Incrementar la producción de Energía"},
  [505] = {id=505,name="Producción de Energía I",explain="Incrementar la producción de Energía"},
  [601] = {id=601,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [602] = {id=602,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [603] = {id=603,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [604] = {id=604,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [605] = {id=605,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [606] = {id=606,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [607] = {id=607,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [608] = {id=608,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [609] = {id=609,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [610] = {id=610,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [611] = {id=611,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [612] = {id=612,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [613] = {id=613,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [614] = {id=614,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [615] = {id=615,name="Refinación de Energía I",explain="Acelerar la recolección mundial de Energía"},
  [701] = {id=701,name="Producción de Cristal I",explain="Incrementar la producción de Cristal"},
  [702] = {id=702,name="Producción de Cristal I",explain="Incrementar la producción de Cristal"},
  [703] = {id=703,name="Producción de Cristal I",explain="Incrementar la producción de Cristal"},
  [704] = {id=704,name="Producción de Cristal I",explain="Incrementar la producción de Cristal"},
  [705] = {id=705,name="Producción de Cristal I",explain="Incrementar la producción de Cristal"},
  [801] = {id=801,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [802] = {id=802,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [803] = {id=803,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [804] = {id=804,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [805] = {id=805,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [806] = {id=806,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [807] = {id=807,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [808] = {id=808,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [809] = {id=809,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [810] = {id=810,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [811] = {id=811,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [812] = {id=812,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [813] = {id=813,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [814] = {id=814,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [815] = {id=815,name="Refinación de Cristal I",explain="Acelerar la recolección mundial de Cristal"},
  [901] = {id=901,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [902] = {id=902,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [903] = {id=903,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [904] = {id=904,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [905] = {id=905,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [906] = {id=906,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [907] = {id=907,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [908] = {id=908,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [909] = {id=909,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [910] = {id=910,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [911] = {id=911,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [912] = {id=912,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [913] = {id=913,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [914] = {id=914,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [915] = {id=915,name="Refinación de Diamante I",explain="Acelerar la recolección mundial de Diamantes"},
  [1001] = {id=1001,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1002] = {id=1002,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1003] = {id=1003,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1004] = {id=1004,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1005] = {id=1005,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1006] = {id=1006,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1007] = {id=1007,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1008] = {id=1008,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1009] = {id=1009,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1010] = {id=1010,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1011] = {id=1011,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1012] = {id=1012,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1013] = {id=1013,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1014] = {id=1014,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1015] = {id=1015,name="Producción de Metal II",explain="Incrementar la producción de Metal"},
  [1101] = {id=1101,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1102] = {id=1102,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1103] = {id=1103,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1104] = {id=1104,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1105] = {id=1105,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1106] = {id=1106,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1107] = {id=1107,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1108] = {id=1108,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1109] = {id=1109,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1110] = {id=1110,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1111] = {id=1111,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1112] = {id=1112,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1113] = {id=1113,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1114] = {id=1114,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1115] = {id=1115,name="Producción de Combustible II",explain="Incrementar la producción de Combustible"},
  [1201] = {id=1201,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1202] = {id=1202,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1203] = {id=1203,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1204] = {id=1204,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1205] = {id=1205,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1206] = {id=1206,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1207] = {id=1207,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1208] = {id=1208,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1209] = {id=1209,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1210] = {id=1210,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1211] = {id=1211,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1212] = {id=1212,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1213] = {id=1213,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1214] = {id=1214,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1215] = {id=1215,name="Almacén II",explain="Incrementar los recursos protegidos en el Almacén"},
  [1301] = {id=1301,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1302] = {id=1302,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1303] = {id=1303,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1304] = {id=1304,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1305] = {id=1305,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1306] = {id=1306,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1307] = {id=1307,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1308] = {id=1308,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1309] = {id=1309,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1310] = {id=1310,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1311] = {id=1311,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1312] = {id=1312,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1313] = {id=1313,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1314] = {id=1314,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1315] = {id=1315,name="Refinación de Metal II",explain="Acelerar la recolección mundial de Metal"},
  [1401] = {id=1401,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1402] = {id=1402,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1403] = {id=1403,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1404] = {id=1404,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1405] = {id=1405,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1406] = {id=1406,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1407] = {id=1407,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1408] = {id=1408,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1409] = {id=1409,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1410] = {id=1410,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1411] = {id=1411,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1412] = {id=1412,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1413] = {id=1413,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1414] = {id=1414,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1415] = {id=1415,name="Refinación de Gas II",explain="Acelerar la recolección mundial de Combustible"},
  [1501] = {id=1501,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1502] = {id=1502,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1503] = {id=1503,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1504] = {id=1504,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1505] = {id=1505,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1506] = {id=1506,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1507] = {id=1507,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1508] = {id=1508,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1509] = {id=1509,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1510] = {id=1510,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1511] = {id=1511,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1512] = {id=1512,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1513] = {id=1513,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1514] = {id=1514,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1515] = {id=1515,name="Producción de Energía II",explain="Incrementar la producción de Energía"},
  [1601] = {id=1601,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1602] = {id=1602,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1603] = {id=1603,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1604] = {id=1604,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1605] = {id=1605,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1606] = {id=1606,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1607] = {id=1607,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1608] = {id=1608,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1609] = {id=1609,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1610] = {id=1610,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1611] = {id=1611,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1612] = {id=1612,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1613] = {id=1613,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1614] = {id=1614,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1615] = {id=1615,name="Refinación de Energía II",explain="Acelerar la recolección mundial de Energía"},
  [1701] = {id=1701,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1702] = {id=1702,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1703] = {id=1703,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1704] = {id=1704,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1705] = {id=1705,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1706] = {id=1706,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1707] = {id=1707,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1708] = {id=1708,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1709] = {id=1709,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1710] = {id=1710,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1711] = {id=1711,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1712] = {id=1712,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1713] = {id=1713,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1714] = {id=1714,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1715] = {id=1715,name="Producción de Cristal II",explain="Incrementar la producción de Cristal"},
  [1801] = {id=1801,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1802] = {id=1802,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1803] = {id=1803,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1804] = {id=1804,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1805] = {id=1805,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1806] = {id=1806,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1807] = {id=1807,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1808] = {id=1808,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1809] = {id=1809,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1810] = {id=1810,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1811] = {id=1811,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1812] = {id=1812,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1813] = {id=1813,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1814] = {id=1814,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1815] = {id=1815,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Cristal"},
  [1901] = {id=1901,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1902] = {id=1902,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1903] = {id=1903,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1904] = {id=1904,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1905] = {id=1905,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1906] = {id=1906,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1907] = {id=1907,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1908] = {id=1908,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1909] = {id=1909,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"},
  [1910] = {id=1910,name="Refinación de Cristal II",explain="Acelerar la recolección mundial de Diamantes"}
}
return DScienceResource