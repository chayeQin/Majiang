-- x_新版新号7日活动积分.xlsx
-- id=编号,day=注册天数,name=活动名称,type=任务要求类型,lv=要求等级,needScore=获取积分需要数量,score=获得积分,desc=文字描述,
local DNewNoviceTaskIntegral = {
  [1] = {id=1,day=1,name="建造升级建筑可获得任务积分，具体积分规则点击问号查看。",type=40,lv=0,needScore=1,score=5,desc="建造建筑提升1点战斗力可获得5积分"},
  [2] = {id=2,day=2,name="提升指挥官等级可获得任务积分，具体积分规则点击问号查看。",type=38,lv=0,needScore=1,score=5000,desc="指挥官提升1级可获得5000积分"},
  [3] = {id=3,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=1,needScore=1,score=2,desc="打造一艘1级战舰可获得2积分"},
  [4] = {id=4,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=2,needScore=1,score=4,desc="打造一艘2级战舰可获得4积分"},
  [5] = {id=5,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=3,needScore=1,score=10,desc="打造一艘3级战舰可获得10积分"},
  [6] = {id=6,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=4,needScore=1,score=15,desc="打造一艘4级战舰可获得15积分"},
  [7] = {id=7,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=5,needScore=1,score=20,desc="打造一艘5级战舰可获得20积分"},
  [8] = {id=8,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=6,needScore=1,score=30,desc="打造一艘6级战舰可获得30积分"},
  [9] = {id=9,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=7,needScore=1,score=45,desc="打造一艘7级战舰可获得45积分"},
  [10] = {id=10,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=8,needScore=1,score=55,desc="打造一艘8级战舰可获得55积分"},
  [11] = {id=11,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=9,needScore=1,score=80,desc="打造一艘9级战舰可获得80积分"},
  [12] = {id=12,day=3,name="打造战舰可获得任务积分，具体积分规则点击问号查看。",type=44,lv=10,needScore=1,score=100,desc="打造一艘10级战舰可获得100积分"},
  [13] = {id=13,day=4,name="在星系中击杀星际海盗可获得任务积分，具体积分规则点击问号查看。",type=12,lv=0,needScore=1,score=250,desc="每击杀一个星际海盗可获得250积分"},
  [14] = {id=14,day=5,name="研究科技可获得任务积分，具体积分规则点击问号查看。",type=41,lv=0,needScore=1,score=5,desc="研究科技提升1点战斗力可获得5积分"},
  [15] = {id=15,day=6,name="建造防御武器可获得任务积分，具体积分规则点击问号查看。",type=7,lv=1,needScore=1,score=45,desc="打造1个1级防御武器可获得45积分"},
  [16] = {id=16,day=6,name="打造防御设施可获得任务积分，具体积分规则点击问号查看。",type=7,lv=2,needScore=1,score=75,desc="打造1个2级防御武器可获得75积分"},
  [17] = {id=17,day=6,name="打造防御设施可获得任务积分，具体积分规则点击问号查看。",type=7,lv=3,needScore=1,score=105,desc="打造1个3级防御武器可获得105积分"},
  [18] = {id=18,day=6,name="打造防御设施可获得任务积分，具体积分规则点击问号查看。",type=7,lv=4,needScore=1,score=150,desc="打造1个4级防御武器可获得150积分"},
  [19] = {id=19,day=6,name="打造防御设施可获得任务积分，具体积分规则点击问号查看。",type=7,lv=5,needScore=1,score=215,desc="打造1个5级防御武器可获得215积分"},
  [20] = {id=20,day=7,name="在星系中采集资源可获得任务积分，具体积分规则点击问号查看。",type=25,lv=0,needScore=1200,score=250,desc="每采集1200金属可获得250积分"},
  [21] = {id=21,day=7,name="在星系中采集资源可获得任务积分，具体积分规则点击问号查看。",type=26,lv=0,needScore=1200,score=250,desc="每采集1200燃气可获得250积分"},
  [22] = {id=22,day=7,name="在星系中采集资源可获得任务积分，具体积分规则点击问号查看。",type=27,lv=0,needScore=200,score=250,desc="每采集200能源可获得250积分"},
  [23] = {id=23,day=7,name="在星系中采集资源可获得任务积分，具体积分规则点击问号查看。",type=28,lv=0,needScore=50,score=250,desc="每采集50晶体可获得250积分"}
}
return DNewNoviceTaskIntegral