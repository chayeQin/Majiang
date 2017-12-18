-- T_推送信息表.xlsx
-- id=id,key=key,data=data,
local TMsgInform = {
  [1] = {id=1,key="upgrade_build",data="{1}级{2}升级完成！"},
  [2] = {id=2,key="upgrade_force",data="{1}级{2}打造完成！"},
  [3] = {id=3,key="upgrade_traps",data="{1}级{2}建造完成！"},
  [4] = {id=4,key="upgrade_science",data="{1}级{2}研究完成！"},
  [5] = {id=5,key="fight_investigation",data="{1}对您的堡垒发起了侦查，是否予以反击？指挥官。"},
  [6] = {id=6,key="fight_attack",data="{1}对您的堡垒发起了攻击，赶快组织援军保卫您的堡垒吧！"},
  [7] = {id=7,key="fight_support",data="{1}对您的堡垒派遣了援军。"},
  [8] = {id=8,key="union_fight",data="{1}对{2}发起了集结攻击！"},
  [9] = {id=9,key="mail_remind",data="您有新的个人邮件！"},
  [10] = {id=10,key="union_mail",data="联盟全体邮件：{1}"},
  [11] = {id=11,key="active_open",data="{1}已开启时空大战活动！赶快将舰队返回组织防御吧！"},
  [12] = {id=12,key="resource_full",data="资源已满仓，暂时停止生产！"},
  [13] = {id=13,key="reward_online",data="在线奖励已可以领取！"},
  [14] = {id=14,key="reward_physical",data="体力奖励已可以领取！"},
  [15] = {id=15,key="union_chat",data="{1}:{2}"},
  [16] = {id=16,key="force_back",data="舰队已返回堡垒！"},
  [17] = {id=17,key="physical_full",data="您的体力已经恢复满了！"},
  [18] = {id=18,key="citystate_reduce",data="您在{1}的投资排名已经跌出前10名，请赶快前往投资！"},
  [20] = {id=20,key="kingdom_war",data="尊敬的指挥官：有人对您的星际堡垒发起了攻击，赶快组织援军防守吧！"},
  [22] = {id=22,key="union_fight_monster",data="尊敬的指挥官：您的联盟成员发起了集结攻击（PVE）！"},
  [23] = {id=23,key="red_packet_world",data="尊敬的指挥官：有人发放了星系红包，赶快前往抢夺吧！"},
  [24] = {id=24,key="red_packet_union",data="尊敬的指挥官：有人发放了联盟红包，赶快前往抢夺吧！"},
  [25] = {id=25,key="union_be_attacked",data="尊敬的指挥官：您的联盟成员正在受到其他玩家的攻击，请赶快进行援助！"}
}
return TMsgInform