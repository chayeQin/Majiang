-- z_主动技能表文字表.xlsx
-- id=编号,name=名称,desc=描述,
local DInitiativeSkill = {
  [1] = {id=1,name="Regreso Inmediato",desc="Habilidad Activa. Llama a todas las tropas fuera de tu Fortaleza para que regresen en 3 segundos. No se incluyen las tropas en marcha."},
  [2] = {id=2,name="Movilización General",desc="Habilidad Activa. Usada para incrementar la capacidad de marcha en 10% durante 1 hora."},
  [3] = {id=3,name="Ayuda",desc="Habilidad Activa, usada sólo después de la primera batalla (solo cuando atacas Fortalezas de otros Comandantes y tropas de campaña. Los Navíos dañados serán enviados al Centro de Mantenimiento en lugar de ser destruidos, hasta que el Centro de Mantenimiento esté lleno."},
  [4] = {id=4,name="Cosecha Abundante",desc="Habilidad Activa. Usada para que todas las minas obtengan inmediatamente 5 horas de ganancias."},
  [5] = {id=5,name="Recolección Loca",desc="Habilidad Activa. Acelera la recolección de recursos en 100% durante 2 horas."},
  [6] = {id=6,name="Protección de Recursos",desc="Habilidad Activa. Usada para que los recursos en tu Fortaleza no puedan ser saqueados durante 2 horas."},
  [7] = {id=7,name="Energético",desc="Habilidad Activa. Obtén 30 AP inmediatamente."},
  [8] = {id=8,name="Defensa Rápida",desc="Habilidad Activa. Obtén 500 Torres de Defensa inmediatamente. El tipo de Torre se eligirá a partir de uno de los niveles más altos de tus Armas Defensivas."},
  [9] = {id=9,name="Trampa Temporal",desc="Habilidad Activa. Los enemigos que te detecten o ataquen requerirán 5 veces el tiempo de marcha. (Sólo es efectivo antes de ser detectado o atacado. Sin efecto en batallas fuera de la Fortaleza). Dura 30 minutos."}
}
return DInitiativeSkill