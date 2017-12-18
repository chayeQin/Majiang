-- x_星际王国地图.xlsx
-- id=编号,buildType=王国建筑类型,name=名字,pos=位置,area=占地面积,img=图片,score=每分钟积分,
local DKingdomMap = {
  [1] = {id=1,buildType=300,name="星际堡垒",pos="600,600",area=3,img="king_fort",score=100},
  [2] = {id=2,buildType=301,name="1号星际基站",pos="604,595",area=2,img="star_tower1",score=35},
  [3] = {id=3,buildType=301,name="3号星际基站",pos="595,595",area=2,img="star_tower2",score=35},
  [4] = {id=4,buildType=301,name="5号星际基站",pos="595,604",area=2,img="star_tower3",score=35},
  [5] = {id=5,buildType=301,name="6号星际基站",pos="604,604",area=2,img="star_tower4",score=35},
  [6] = {id=6,buildType=301,name="2号星际基站",pos="600,595",area=2,img="star_tower4",score=35},
  [7] = {id=7,buildType=301,name="4号星际基站",pos="595,600",area=2,img="star_tower4",score=35},
  [8] = {id=8,buildType=301,name="7号星际基站",pos="604,600",area=2,img="star_tower4",score=35},
  [10] = {id=10,buildType=304,name="",pos="600,603",area=1,img="king_rank_tower",score=1},
  [1000] = {id=1000,buildType=-1,name="黑土地，已堡垒为中心",pos="",area=51,img="",score=0},
  [1001] = {id=1001,buildType=-2,name="王国领地，已堡垒为中心",pos="",area=11,img="",score=0}
}
return DKingdomMap