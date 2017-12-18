-- Type_联盟消息文字表.xlsx
-- id=id,key=key,data=data,
local TUnionMsg = {
  [1] = {id=1,key="exit_union_msg",data="{1} acaba de retirarse de la Federación"},
  [2] = {id=2,key="join_union_msg",data="{1} se acaba de unir a la  Federación"},
  [3] = {id=3,key="atk_main_city",data="La Foratleza de {1} ({2},{3}) ha sido saqueada por {4}."},
  [4] = {id=4,key="atk_resource",data="{2}({3},{4}) ocupado por {1} ha sido tomado por {5} y {6}."},
  [5] = {id=5,key="place",data="{1} acaba de posicionar {2}."},
  [6] = {id=6,key="science_study",data="{1} acaba de empezar una investigación de Tecnología de la Federación {2}."},
  [7] = {id=7,key="black_knight",data="La Fortaleza de {1} ha sido destruida por el Navío Chaos."},
  [8] = {id=8,key="union_mark",data="¡Atención! El líder acaba de marcar la ubicación X:{1} Y:{2}."},
  [9] = {id=9,key="union_kick",data="{1} ha expulsado a {2} de la Federación."},
  [100] = {id=100,key="notice",data="¡Unetenos y construyamos juntos un mejor mañana!"}
}
return TUnionMsg