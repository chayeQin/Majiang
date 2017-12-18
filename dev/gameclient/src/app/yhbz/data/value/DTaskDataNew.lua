-- r_任务新号.xlsx
-- id=编号,taskType=任务要求类型,factor=任务要求条件,data=任务要求数据,openType=开启条件数据类型,openId=开启条件数据ID,openData=开启条件数据,name=任务名称,desc=任务描述,icon=图标ID,skipTaskType=跳转任务类型,skipType=跳转类型,skipData=跳转数据,click=是否帮助玩家点击,skipFunc=跳转功能,showWay=表现方式,
local DTaskDataNew = {
  [1] = {id=1,taskType=33,factor=-1,data=400,openType=1,openId=1,openData=1,name="基础金属产量达{1}",desc="提高堡垒中的挖矿场等级，从而提高金属的产量。",icon="33",skipTaskType=4,skipType=1,skipData=100,click=1,skipFunc=3,showWay=1},
  [2] = {id=2,taskType=34,factor=-1,data=400,openType=1,openId=1,openData=1,name="基础燃气产量达{1}",desc="提高堡垒中的炼气场等级，从而提高燃气的产量。",icon="34",skipTaskType=4,skipType=1,skipData=101,click=1,skipFunc=3,showWay=1},
  [3] = {id=3,taskType=25,factor=-1,data=200,openType=1,openId=1,openData=1,name="星系采集{1}金属",desc="你可以在星系中看到各级别的金属矿，采集它们可以获得金属。",icon="25",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=401,showWay=2},
  [4] = {id=4,taskType=3,factor=1,data=30,openType=1,openId=1,openData=1,name="打造{1}个谢尔曼护卫舰",desc="你可以在堡垒中的雷神工厂里打造护卫舰。",icon="3",skipTaskType=4,skipType=1,skipData=8,click=1,skipFunc=3,showWay=1},
  [5] = {id=5,taskType=38,factor=-1,data=5,openType=1,openId=1,openData=1,name="指挥官等级达到{1}级",desc="升级建筑、消灭怪物、完成任务都可以获得指挥官经验，指挥官升级可以获得更多的技能点数",icon="38",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=0,showWay=0},
  [6] = {id=6,taskType=5,factor=1,data=30,openType=1,openId=1,openData=1,name="打造{1}个伊-400巡洋舰",desc="你可以在堡垒中的洛克工厂里打造巡洋舰。",icon="5",skipTaskType=4,skipType=1,skipData=10,click=1,skipFunc=3,showWay=1},
  [7] = {id=7,taskType=37,factor=-1,data=1,openType=1,openId=1,openData=1,name="充值任意金额",desc="充值任意金额即可完成任务！成就霸业，创造辉煌！",icon="37",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=408,showWay=2},
  [8] = {id=8,taskType=11,factor=-1,data=1,openType=1,openId=1,openData=1,name="成功研究{1}次科技",desc="你可以在堡垒中的科研所里研究科技可以整体提升你的实力。",icon="11",skipTaskType=4,skipType=1,skipData=2,click=1,skipFunc=3,showWay=1},
  [9] = {id=9,taskType=12,factor=-1,data=3,openType=1,openId=1,openData=1,name="攻打怪物{1}次",desc="在星系中，摧毁怪物可以获得奖励。",icon="12",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=412,showWay=2},
  [10] = {id=10,taskType=3,factor=1,data=60,openType=1,openId=1,openData=1,name="打造{1}个谢尔曼护卫舰",desc="你可以在堡垒中的雷神工厂里打造护卫舰。",icon="3",skipTaskType=4,skipType=1,skipData=8,click=1,skipFunc=3,showWay=1},
  [11] = {id=11,taskType=4,factor=1,data=50,openType=1,openId=1,openData=1,name="打造{1}个喷火截击舰",desc="你可以在堡垒中的波音工厂里打造截击舰。",icon="4",skipTaskType=4,skipType=1,skipData=9,click=1,skipFunc=3,showWay=1},
  [12] = {id=12,taskType=3,factor=2,data=100,openType=1,openId=1,openData=1,name="打造{1}个百夫长护卫舰",desc="你可以在堡垒中的雷神工厂里打造护卫舰。",icon="3",skipTaskType=4,skipType=1,skipData=8,click=1,skipFunc=3,showWay=1},
  [13] = {id=13,taskType=11,factor=-1,data=2,openType=1,openId=1,openData=1,name="成功研究{1}次科技",desc="你可以在堡垒中的科研所里研究科技可以整体提升你的实力。",icon="11",skipTaskType=4,skipType=1,skipData=2,click=1,skipFunc=3,showWay=1},
  [14] = {id=14,taskType=12,factor=-1,data=4,openType=1,openId=1,openData=1,name="攻打怪物{1}次",desc="在星系中，摧毁怪物可以获得奖励。",icon="12",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=401,showWay=2},
  [15] = {id=15,taskType=7,factor=-1,data=50,openType=1,openId=1,openData=1,name="制造{1}个防御塔",desc="你可以在堡垒中的战备中心里打造防御塔可以增强堡垒的防守能力。",icon="7",skipTaskType=4,skipType=1,skipData=5,click=1,skipFunc=3,showWay=1},
  [16] = {id=16,taskType=12,factor=2,data=3,openType=1,openId=1,openData=1,name="消灭{2}级怪物{1}次",desc="在星系中，摧毁怪物可以获得奖励。",icon="12",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=401,showWay=2},
  [17] = {id=17,taskType=11,factor=-1,data=3,openType=1,openId=1,openData=1,name="成功研究{1}次科技",desc="你可以在堡垒中的科研所里研究科技可以整体提升你的实力。",icon="11",skipTaskType=4,skipType=1,skipData=2,click=1,skipFunc=3,showWay=1},
  [18] = {id=18,taskType=6,factor=1,data=50,openType=1,openId=1,openData=1,name="打造{1}个竞技空母舰",desc="你可以在堡垒中的通用工厂里打造航空母舰。",icon="6",skipTaskType=4,skipType=1,skipData=11,click=1,skipFunc=3,showWay=1},
  [19] = {id=19,taskType=38,factor=-1,data=10,openType=1,openId=1,openData=1,name="指挥官等级达到{1}级",desc="升级建筑、消灭怪物、完成任务都可以获得指挥官经验，指挥官升级可以获得更多的技能点数",icon="38",skipTaskType=0,skipType=0,skipData=0,click=0,skipFunc=0,showWay=0}
}
return DTaskDataNew