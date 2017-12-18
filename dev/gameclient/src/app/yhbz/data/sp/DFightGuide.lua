-- Z_战斗引导文字表.xlsx
-- id=id,x=x,y=y,width=宽度,height=高度,openType=内容,
local DFightGuide = {
  [1] = {id=1,x=640,y=88,width=776,height=26,openType="Aquí están los nombres de ambos contrincantes de la batalla. El lado azul es para la ofensiva, el lado rojo es para la defensiva."},
  [2] = {id=2,x=640,y=55,width=794,height=36,openType="Aquí está la moral de ambos bandos en la batalla. La batalla terminará cuando la moral baje a 0. Quien llegue a 0 perderá la batalla."},
  [3] = {id=3,x=640,y=20,width=730,height=40,openType="Aquí está el número de navíos de ambos contrincantes. La cantidad de navíos dañados se mostrará durante la batalla."},
  [4] = {id=4,x=-33,y=-22,width=136,height=60,openType="¿No quieres ver la batalla? Entonces toca sobre el botón de Saltar."},
  [5] = {id=5,x=640,y=360,width=800,height=400,openType="En el área central se muestra la batalla, listo para empezar la primera batalla."}
}
return DFightGuide