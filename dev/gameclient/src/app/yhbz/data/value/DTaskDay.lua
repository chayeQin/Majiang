-- r_日常任务.xlsx
-- id=ID,name=名称,icon=图标ID,param=参数,count=次数,integral=每次积分,dataType=开启条件数据类型,dataId=开启条件数据ID,value=数值,desc=任务描述,target=任务目标,jumpType=跳转类型,jumpId=跳转id,
local DTaskDay = {
  [1] = {id=1,name="联盟帮助",icon="1",param=1,count=25,integral=1,dataType=1,dataId=14,value=1,desc="在联盟中帮助盟友可以帮他们节省时间",target="在联盟中帮助其他盟友25次",jumpType=3,jumpId=402},
  [2] = {id=2,name="领取在线奖励",icon="2",param=1,count=2,integral=5,dataType=1,dataId=1,value=1,desc="每日领取在线奖励可以获得丰富的奖励",target="领取在线奖励2次",jumpType=3,jumpId=403},
  [3] = {id=3,name="打造护卫舰",icon="5",param=50,count=5,integral=5,dataType=1,dataId=8,value=1,desc="你可以在护卫舰工厂中打造护卫舰",target="打造250艘护卫舰，每完成50艘护卫舰可获得5积分",jumpType=1,jumpId=8},
  [4] = {id=4,name="打造截击舰",icon="3",param=50,count=5,integral=5,dataType=1,dataId=9,value=1,desc="你可以在截击舰工厂中打造截击舰",target="打造250艘截击舰，每完成50艘截击舰可获得5积分",jumpType=1,jumpId=9},
  [5] = {id=5,name="打造巡洋舰",icon="4",param=50,count=5,integral=5,dataType=1,dataId=10,value=1,desc="你可以在巡洋舰工厂中打造巡洋舰",target="打造250艘巡洋舰，每完成50艘巡洋舰可获得5积分",jumpType=1,jumpId=10},
  [6] = {id=6,name="打造空母舰",icon="6",param=50,count=5,integral=5,dataType=1,dataId=11,value=1,desc="你可以在空母舰工厂中打造空母舰",target="打造250艘空母舰，每完成50艘空母舰可获得5积分",jumpType=1,jumpId=11},
  [7] = {id=7,name="打造防御武器",icon="7",param=30,count=5,integral=4,dataType=1,dataId=5,value=1,desc="打造防御武器可以增强堡垒的防守能力",target="打造150防御武器，每完成30个防御武器获得4积分",jumpType=1,jumpId=5},
  [8] = {id=8,name="升级建筑",icon="8",param=1,count=1,integral=40,dataType=1,dataId=1,value=1,desc="在堡垒中升级任意建筑都会提升你的战斗力",target="成功升级堡垒中的任意建筑1次",jumpType=0,jumpId=0},
  [9] = {id=9,name="维修损舰",icon="9",param=30,count=1,integral=10,dataType=1,dataId=105,value=1,desc="堡垒中的维修中心可以维修损舰，维修损舰可以快速恢复战斗力",target="前往维修中心维修40艘损舰",jumpType=1,jumpId=105},
  [10] = {id=10,name="联盟捐献",icon="10",param=1,count=40,integral=1,dataType=1,dataId=1,value=1,desc="在联盟中捐献联盟科技可以让联盟更强大",target="在联盟进行40次捐献",jumpType=3,jumpId=602},
  [11] = {id=11,name="研究科技",icon="11",param=1,count=1,integral=20,dataType=1,dataId=2,value=1,desc="研究科技可以整体提升你的实力",target="在科研所研究1次科技",jumpType=1,jumpId=2},
  [12] = {id=12,name="消灭怪物",icon="12",param=1,count=10,integral=5,dataType=1,dataId=1,value=1,desc="消灭怪物可以获得丰富奖励",target="在星系中消灭任意等级怪物10次",jumpType=3,jumpId=401},
  [13] = {id=13,name="合成装备材料",icon="13",param=1,count=1,integral=30,dataType=1,dataId=17,value=1,desc="使用高级材料合成出的装备能力值会更高",target="在锻造厂内合成1次装备材料,每次合成可获得30积分",jumpType=1,jumpId=17},
  [14] = {id=14,name="制造装备",icon="14",param=1,count=1,integral=10,dataType=1,dataId=10,value=1,desc="穿戴装备会提升相应属性",target="在锻造厂内制造1件装备",jumpType=1,jumpId=17},
  [15] = {id=15,name="许愿",icon="15",param=1,count=20,integral=1,dataType=1,dataId=4,value=1,desc="许愿可以获得相应资源",target="在文明遗迹中许愿20次",jumpType=1,jumpId=4},
  [16] = {id=16,name="联盟交易",icon="16",param=15000,count=1,integral=10,dataType=1,dataId=16,value=1,desc="同联盟的盟友之间可以互相进行资源援助",target="在联盟中援助盟友15000资源1次",jumpType=1,jumpId=16},
  [17] = {id=17,name="舰艇增援",icon="17",param=1000,count=1,integral=10,dataType=1,dataId=14,value=1,desc="同联盟的盟友之间可以互相进行舰艇援助",target="在联盟中援助盟友1000艘战舰1次",jumpType=3,jumpId=402},
  [18] = {id=18,name="星际商船",icon="18",param=1,count=20,integral=2,dataType=1,dataId=1,value=6,desc="星际商人经常会出售一些超值的物品",target="在星际商人处购买20次道具",jumpType=3,jumpId=406},
  [21] = {id=21,name="提升炼气场产量",icon="21",param=1,count=1,integral=5,dataType=1,dataId=1,value=1,desc="使用炼气场提升道具或钻石可以提升堡垒内炼气场的产量",target="使炼气场产量提升1次",jumpType=3,jumpId=400},
  [22] = {id=22,name="提升挖矿场产量",icon="22",param=1,count=1,integral=5,dataType=1,dataId=1,value=1,desc="使用挖矿场提升道具或钻石可以提升堡垒内挖矿场的产量",target="使挖矿场产量提升1次",jumpType=3,jumpId=400},
  [23] = {id=23,name="提升能源场产量",icon="23",param=1,count=1,integral=5,dataType=1,dataId=1,value=25,desc="使用能源场提升道具或钻石可以提升堡垒内能源场的产量",target="使能源场产量提升1次",jumpType=3,jumpId=400},
  [24] = {id=24,name="提升掘晶场产量",icon="24",param=1,count=1,integral=5,dataType=1,dataId=1,value=41,desc="使用掘晶场提升道具或钻石可以提升堡垒内掘晶场的产量",target="使晶体场产量提升1次",jumpType=3,jumpId=400},
  [25] = {id=25,name="采集金属",icon="25",param=5000,count=5,integral=3,dataType=1,dataId=1,value=1,desc="你可以在星系中看到各级别的金属矿，采集它们可以获得金属",target="在星系中采集25000点金属，每采集5000点金属可获得3积分",jumpType=3,jumpId=401},
  [26] = {id=26,name="采集燃气",icon="26",param=5000,count=5,integral=3,dataType=1,dataId=1,value=1,desc="你可以在星系中看到各级别的燃气矿，采集它们可以获得燃气",target="在星系中采集25000点燃气，每采集5000点燃气可获得3积分",jumpType=3,jumpId=401},
  [27] = {id=27,name="采集能源",icon="27",param=1500,count=5,integral=5,dataType=1,dataId=1,value=25,desc="你可以在星系中看到各级别的能源矿，采集它们可以获得能源",target="在星系中采集7500点能源，每采集1500点能源可获得5积分",jumpType=3,jumpId=401},
  [28] = {id=28,name="采集晶体",icon="28",param=800,count=5,integral=5,dataType=1,dataId=1,value=41,desc="你可以在星系中看到各级别的晶体矿，采集它们可以获得晶体",target="在星系中采集4000点晶体，每采集800点晶体可获得5积分",jumpType=3,jumpId=401},
  [48] = {id=48,name="城邦投资",icon="16",param=10000,count=25,integral=2,dataType=1,dataId=1,value=9,desc="前往星际商人中任意星际城邦投资",target="在星际城邦中投资250000投资值，每投资10000投资值可获得2积分",jumpType=3,jumpId=503},
  [50] = {id=50,name="战役胜利",icon="12",param=1,count=10,integral=5,dataType=1,dataId=9,value=1,desc="前往战役副本战斗并获得胜利",target="在战役中战斗胜利10次，每战斗胜利1次可获得5积分",jumpType=3,jumpId=501},
  [51] = {id=51,name="制作机甲材料",icon="16",param=1,count=1,integral=15,dataType=1,dataId=9,value=2,desc="前往材料工坊，制作任意原材料或合成品",target="前往材料工坊，制作1次任意原材料或合成品",jumpType=1,jumpId=1000},
  [52] = {id=52,name="提升机甲等级",icon="17",param=1,count=1,integral=15,dataType=1,dataId=10,value=2,desc="前往机甲中心，升级任意机甲",target="前往机甲中心，升级1次任意机甲",jumpType=1,jumpId=1001},
  [53] = {id=53,name="储存资源",icon="19",param=10000,count=1,integral=10,dataType=1,dataId=18,value=1,desc="在储备中心储存10k重量的资源",target="在储备中心存储10000资源1次",jumpType=1,jumpId=18},
  [54] = {id=54,name="星系聊天",icon="20",param=1,count=1,integral=5,dataType=1,dataId=1,value=5,desc="前往星系聊天频道发布一条聊天信息",target="在星系聊天频道中发言1次，可获得5积分",jumpType=3,jumpId=702},
  [55] = {id=55,name="领袖升级",icon="38",param=1,count=1,integral=5,dataType=1,dataId=19,value=1,desc="前往智能研究所，给任意领袖升级",target="在智能科研所给领袖升级1次，可获得5积分",jumpType=1,jumpId=19},
  [56] = {id=56,name="竞技场",icon="1",param=1,count=1,integral=5,dataType=1,dataId=1,value=15,desc="前往竞技场，进行一场挑战，无论输赢",target="在竞技场挑战1次，无论胜负均可获得5积分",jumpType=3,jumpId=803}
}
return DTaskDay