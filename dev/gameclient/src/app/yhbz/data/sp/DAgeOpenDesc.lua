-- s_时代开启说明文字表.xlsx
-- id=id,level=时代等级,desc=开启说明,
local DAgeOpenDesc = {
  [1] = {id=1,level=1,desc="El límite superior de construcción es Nivel 3"},
  [2] = {id=2,level=1,desc="Nave de guerra clase Campañol disponible para construcción"},
  [3] = {id=3,level=1,desc="Arma defensiva de clase Campañol disponible para construcción"},
  [4] = {id=4,level=1,desc="Ataque de nave de guerra y otras 18 tecnologías, disponibles para investigación"},
  [5] = {id=5,level=2,desc="El límite superior de construcción se ha incrementado a Nivel 12"},
  [6] = {id=6,level=2,desc="Nave de guerra clase Campañol disponible para construcción"},
  [7] = {id=7,level=2,desc="Arma defensiva de clase Campañol disponible para construcción"},
  [8] = {id=8,level=2,desc="Meca de calidad blanca disponible para activación"},
  [9] = {id=9,level=2,desc="Máquina de construcción y otras 15 tecnologías, disponibles para investigación"},
  [10] = {id=10,level=2,desc="Obtén una nueva apariencia de la fortaleza"},
  [11] = {id=11,level=3,desc="El límite superior de construcción se ha incrementado a Nivel 18"},
  [12] = {id=12,level=3,desc="Incremento de la capacidad de marcha de las flotas +1"},
  [13] = {id=13,level=3,desc="Nave de guerra clase Lince disponible para construcción"},
  [14] = {id=14,level=3,desc="Arma defensiva de clase Lince disponible para construcción"},
  [15] = {id=15,level=3,desc="Meca de calidad verde disponible para activación"},
  [16] = {id=16,level=3,desc="Desbloquea ataque de nave de guerra Intermedio y 13 nuevas tecnologías"},
  [17] = {id=17,level=4,desc="El límite superior de construcción se ha incrementado a Nivel 24"},
  [18] = {id=18,level=4,desc="Nave de guerra clase Lince disponible para construcción"},
  [19] = {id=19,level=4,desc="Arma defensiva de clase Lince disponible para construcción"},
  [20] = {id=20,level=4,desc="Meca de calidad verde disponible para activación"},
  [21] = {id=21,level=4,desc="Desbloquea defensa de nave de guerra Intermedio y 9 nuevas tecnologías"},
  [22] = {id=22,level=4,desc="Obtén una nueva apariencia de la fortaleza"},
  [23] = {id=23,level=5,desc="El límite superior de construcción se ha incrementado a Nivel 30"},
  [24] = {id=24,level=5,desc="Nave de guerra clase Hiena disponible para construcción"},
  [25] = {id=25,level=5,desc="Arma defensiva de clase Hiena disponible para construcción"},
  [26] = {id=26,level=5,desc="Meca de calidad azul disponible para activación"},
  [27] = {id=27,level=5,desc="Desbloquea Maestría de Armadura y 7 nuevas tecnologías"},
  [28] = {id=28,level=6,desc="El límite superior de construcción se ha incrementado a Nivel 35"},
  [29] = {id=29,level=6,desc="Nave de guerra clase Hiena disponible para construcción"},
  [30] = {id=30,level=6,desc="Arma defensiva de clase Hiena disponible para construcción"},
  [31] = {id=31,level=6,desc="Meca de calidad azul disponible para activación"},
  [32] = {id=32,level=6,desc="Desbloquea la energía de flota Intermedia y 9 nuevas tecnologías"},
  [33] = {id=33,level=6,desc="Obtén una nueva apariencia de la fortaleza"},
  [34] = {id=34,level=7,desc="El límite superior de construcción se ha incrementado a Nivel 40"},
  [35] = {id=35,level=7,desc="Nave de guerra clase Chacal disponible para construcción"},
  [36] = {id=36,level=7,desc="Arma defensiva de clase Chacal disponible para construcción"},
  [37] = {id=37,level=7,desc="Meca de calidad azul+1 disponible para activación"},
  [38] = {id=38,level=7,desc="Desbloquea la flota Senior y 4 nuevas tecnologías"},
  [39] = {id=39,level=8,desc="El límite superior de construcción se ha incrementado a Nivel 45"},
  [40] = {id=40,level=8,desc="Incremento de la capacidad de marcha de las flotas +1"},
  [41] = {id=41,level=8,desc="Nave de guerra clase Chacal disponible para construcción"},
  [42] = {id=42,level=8,desc="Arma defensiva de clase Chacal disponible para construcción"},
  [43] = {id=43,level=8,desc="Meca de calidad azul+1 disponible para activación"},
  [44] = {id=44,level=8,desc="Desbloquea la flota Senior y 16 nuevas tecnologías"},
  [45] = {id=45,level=8,desc="Obtén una nueva apariencia de la fortaleza"},
  [46] = {id=46,level=9,desc="El límite superior de construcción se ha incrementado a Nivel 50"},
  [47] = {id=47,level=9,desc="Nave de guerra clase Chacal disponible para construcción"},
  [48] = {id=48,level=9,desc="Arma defensiva de clase Chacal disponible para construcción"},
  [49] = {id=49,level=9,desc="Meca de calidad azul+1 disponible para activación"},
  [50] = {id=50,level=9,desc="Desbloquea defensa de nave de guerra Senior y 9 nuevas tecnologías"},
  [51] = {id=51,level=10,desc="El límite superior de construcción se ha incrementado a Nivel 54"},
  [52] = {id=52,level=10,desc="Nave de guerra clase Chita disponible para construcción"},
  [53] = {id=53,level=10,desc="Arma defensiva de clase Chita disponible para construcción"},
  [54] = {id=54,level=10,desc="Meca de calidad púrpura disponible para activación"},
  [55] = {id=55,level=10,desc="Desbloquea la energía de flota Senior y 11 nuevas tecnologías"},
  [56] = {id=56,level=11,desc="El límite superior de construcción se ha incrementado a Nivel 58"},
  [57] = {id=57,level=11,desc="Nave de guerra clase Chita disponible para construcción"},
  [58] = {id=58,level=11,desc="Arma defensiva de clase Chita disponible para construcción"},
  [59] = {id=59,level=11,desc="Meca de calidad púrpura disponible para activación"},
  [60] = {id=60,level=11,desc="Desbloquea Maestría de Armas y 2 nuevas tecnologías"},
  [61] = {id=61,level=11,desc="Obtén una nueva apariencia de la fortaleza"},
  [62] = {id=62,level=12,desc="El límite superior de construcción se ha incrementado a Nivel 62"},
  [63] = {id=63,level=12,desc="Nave de guerra clase Chita disponible para construcción"},
  [64] = {id=64,level=12,desc="Arma defensiva de clase Chita disponible para construcción"},
  [65] = {id=65,level=12,desc="Meca de calidad púrpura disponible para activación"},
  [66] = {id=66,level=13,desc="El límite superior de construcción se ha incrementado a Nivel 66"},
  [67] = {id=67,level=13,desc="Incremento de la capacidad de marcha de las flotas +1"},
  [68] = {id=68,level=13,desc="Nave de guerra clase Tigre disponible para construcción"},
  [69] = {id=69,level=13,desc="Arma defensiva de clase Tigre disponible para construcción"},
  [70] = {id=70,level=13,desc="Meca de calidad púrpura+1 disponible para activación"},
  [71] = {id=71,level=13,desc="Obtén una nueva apariencia de la fortaleza"},
  [72] = {id=72,level=13,desc="Desbloquea la defensa de la ciudad Senior y 5 nuevas tecnologías"},
  [73] = {id=73,level=14,desc="El límite superior de construcción se ha incrementado a Nivel 70"},
  [74] = {id=74,level=14,desc="Nave de guerra clase Tigre disponible para construcción"},
  [75] = {id=75,level=14,desc="Arma defensiva de clase Tigre disponible para construcción"},
  [76] = {id=76,level=14,desc="Meca de calidad púrpura+1 disponible para activación"},
  [77] = {id=77,level=15,desc="El límite superior de construcción se ha incrementado a Nivel 74"},
  [78] = {id=78,level=15,desc="Nave de guerra clase Tigre disponible para construcción"},
  [79] = {id=79,level=15,desc="Arma defensiva de clase Tigre disponible para construcción"},
  [80] = {id=80,level=15,desc="Meca de calidad púrpura+1 disponible para activación"},
  [81] = {id=81,level=16,desc="El límite superior de construcción se ha incrementado a Nivel 78"},
  [82] = {id=82,level=16,desc="Nave de guerra clase León disponible para construcción"},
  [83] = {id=83,level=16,desc="Arma defensiva de clase León disponible para construcción"},
  [84] = {id=84,level=16,desc="Investiga en tecnología de flota Senior y puedes agregar una cola de expedición"},
  [85] = {id=85,level=16,desc="Obtén una nueva apariencia de la fortaleza"},
  [86] = {id=86,level=17,desc="El límite superior de construcción se ha incrementado a Nivel 82"},
  [87] = {id=87,level=17,desc="Incremento de la capacidad de marcha de las flotas +1"},
  [88] = {id=88,level=17,desc="Nave de guerra clase León disponible para construcción"},
  [89] = {id=89,level=17,desc="Arma defensiva de clase León disponible para construcción"},
  [90] = {id=90,level=17,desc="Meca de calidad roja disponible para activación"},
  [91] = {id=91,level=18,desc="El límite superior de construcción se ha incrementado a Nivel 86"},
  [92] = {id=92,level=18,desc="Nave de guerra clase León disponible para construcción"},
  [93] = {id=93,level=18,desc="Arma defensiva de clase León disponible para construcción"},
  [94] = {id=94,level=18,desc="Meca de calidad roja disponible para activación"},
  [95] = {id=95,level=18,desc="Obtén una nueva apariencia de la fortaleza"},
  [96] = {id=96,level=19,desc="El límite superior de construcción se ha incrementado a Nivel 90"},
  [97] = {id=97,level=19,desc="Nave de guerra clase Oso disponible para construcción"},
  [98] = {id=98,level=19,desc="Arma defensiva de clase Oso disponible para construcción"},
  [99] = {id=99,level=19,desc="Meca de calidad roja+1 disponible para activación"},
  [100] = {id=100,level=20,desc="El límite superior de construcción se ha incrementado a Nivel 94"},
  [101] = {id=101,level=20,desc="Nave de guerra clase Oso disponible para construcción"},
  [102] = {id=102,level=20,desc="Arma defensiva de clase Oso disponible para construcción"},
  [103] = {id=103,level=20,desc="Meca de calidad roja+1 disponible para activación"},
  [104] = {id=104,level=21,desc="El límite superior de construcción se ha incrementado a Nivel 98"},
  [105] = {id=105,level=21,desc="Nave de guerra clase Oso disponible para construcción"},
  [106] = {id=106,level=21,desc="Arma defensiva de clase Oso disponible para construcción"},
  [107] = {id=107,level=21,desc="Meca de calidad roja+1 disponible para activación"},
  [108] = {id=108,level=21,desc="Obtén una nueva apariencia de la fortaleza"},
  [109] = {id=109,level=22,desc="El límite superior de construcción se ha incrementado a Nivel 102"},
  [110] = {id=110,level=22,desc="Nave de guerra clase Aguila disponible para construcción"},
  [111] = {id=111,level=22,desc="Arma defensiva de clase Aguila disponible para construcción"},
  [112] = {id=112,level=22,desc="Meca de calidad naranja disponible para activación"},
  [113] = {id=113,level=23,desc="El límite superior de construcción se ha incrementado a Nivel 106"},
  [114] = {id=114,level=23,desc="Nave de guerra clase Aguila disponible para construcción"},
  [115] = {id=115,level=23,desc="Arma defensiva de clase Aguila disponible para construcción"},
  [116] = {id=116,level=23,desc="Meca de calidad naranja disponible para activación"},
  [117] = {id=117,level=24,desc="El límite superior de construcción se ha incrementado a Nivel 110"},
  [118] = {id=118,level=24,desc="Nave de guerra clase Aguila disponible para construcción"},
  [119] = {id=119,level=24,desc="Arma defensiva de clase Aguila disponible para construcción"},
  [120] = {id=120,level=24,desc="Meca de calidad naranja disponible para activación"},
  [121] = {id=121,level=25,desc="El límite superior de construcción se ha incrementado a Nivel 120"},
  [122] = {id=122,level=25,desc="Nave de guerra clase Elefante disponible para construcción"},
  [123] = {id=123,level=25,desc="Defensa de clase Elefante o Aguila disponible para construcción"},
  [124] = {id=124,level=25,desc="Meca de calidad naranja+1 disponible para activación"}
}
return DAgeOpenDesc