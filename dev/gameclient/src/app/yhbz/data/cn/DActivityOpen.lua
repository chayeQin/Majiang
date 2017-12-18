-- h_活动开启规则设定文字表.xlsx
-- id=活动类型,name=活动名称,desc=活动描述,
local DActivityOpen = {
  [1] = {id=1,name="开服比赛",desc="1.开服比赛分为多个阶段，不同阶段完成不同任务可以获得比赛积分。\n2.每个阶段只要达到阶段需求积分即可获得阶段奖励。\n3.每个阶段会根据积分进行阶段排名，排名前100名的玩家可以获得阶段排名奖励。\n4.活动结束后，还会根据所有阶段总积分进行排名，排名前100名的玩家可以获得活动排名奖励。"},
  [2] = {id=2,name="限时比赛",desc="1.限时比赛分为多个阶段，不同阶段完成不同任务可以获得比赛积分。\n2.每个阶段只要达到阶段需求积分即可获得阶段奖励。\n3.每个阶段会根据积分进行阶段排名，排名前100名的玩家可以获得阶段排名奖励。\n4.活动结束后，还会根据所有阶段总积分进行排名，排名前100名的玩家可以获得活动排名奖励。"},
  [3] = {id=3,name="时空大战",desc="1.时空大战活动开启后，联盟R5、R4的成员可以开启时空大战活动。\n2.战争守护道具对时空大战无效。\n3.抵御外星舰队的攻击次数越多，则获得积分越多。\n4.守城失败2次后，则不会再受到黑洞攻击，您可以选择援助联盟其他成员。\n5.当联盟内所有成员都守城失败2次后，则本联盟的活动结束。\n6.活动期间每个联盟只能开启1次活动。\n7.外星舰队不会抢夺您的资源，它的进攻只会给您造成少量伤兵。\n8.活动中退出联盟将不会获得任何奖励。"},
  [4] = {id=4,name="王座争夺战",desc="1.首次王座争夺战在开服15天后开启，之后固定在周六4点开始，王座争夺战只有加入联盟的玩家才能参与。\n2.每次活动开启后，将持续24小时后，24小时候进行结算。\n3.活动开启后，所有联盟均可抢夺星际堡垒和星际基站，持续占领建筑可获得王座积分。\n4.活动结束后，获得王座积分排名第一的联盟将拥有星际霸主分配权力。\n5.其他参与王座争夺战的联盟则可以根据获得王座积分，获得王座争夺战参与者奖励，奖励在活动结束后通过邮件发放。\n6.王座争夺战结束后，获胜的联盟可以由盟主在一小时内任命星际霸主，如果盟主不任命，一小时后则由盟主当选星际霸主。\n7.星际堡垒处于争夺状态时，任何指挥官都可以向星际堡垒出兵。\n8.派出的舰队到达星际堡垒时，如果星际堡垒占领者是自己的联盟，则舰队进行援助。\n9.如果星际堡垒占领者不是自己的联盟，则发生战斗。\n10.星际堡垒中的最大舰队数量由占领者的出征上限和战略中心的等级决定。"},
  [5] = {id=5,name="银河战场",desc="1.堡垒达到15级以上的玩家可以报名参加银河战场活动。\n2.活动开启后，所有星系的玩家都会被传送到银河战场。\n3.银河战场中，同星系的玩家之间不能发生战斗，只能攻击其他星系的玩家。\n4.击杀其他星系的玩家可以获得积分，最终根据个人积分排名和星际积分排名获得奖励。"},
  [6] = {id=6,name="星盟争霸",desc="1.活动开启后，联盟R5、R4的成员可以报名参加星盟争霸。\n2.报名成功后，系统会随机匹配对战的联盟，盟战胜利的联盟可以晋级下一轮。\n3.参加星盟争霸的联盟可以获得大量的道具奖励。"},
  [7] = {id=7,name="每日补给",desc="1.每天所有指挥官都能获得四次免费补给，指挥官上线后可领取。\n2.挑战书可用于攻打战役副本，战役产出大量的装备材料和游戏道具。\n3.体力则可用于在星系中攻打星际海盗，星际海盗产出科技因子和统帅令等稀缺道具。\n4.体力在达到上限后，则无法再继续领取，请消耗以后再进行领取。\n5.每天上线后不要忘记去活动中心领取每日补给哦！"},
  [8] = {id=8,name="红包充值",desc="1.红包也叫压岁钱，是中国过农历春节时长辈给小孩儿用红纸包裹的钱，表示把新的一年的祝福和好运带给他们。\n2.购买红包后，可以选择领取红包的人数以及你想发送的聊天频道。\n3.领取红包时，会随机获得红包中不等额的钻石，总值为红包中的钻石总数。\n4.购买后，自己无法获得钻石，但可以领取自己发送的红包，抢夺红包中的钻石。"},
  [9] = {id=9,name="有奖答题",desc="1.活动期间每日有5次答题机会，每次答题之间有CD时间。\n2.答题时无论答题对错，均可获得奖励，答题正确奖励价值更高。\n3.答题正确可获得答题积分，连续答题正确获得积分更多，答题积分会进行排名。\n4.答题活动结束后，根据答题积分排名发放奖励，奖励通过邮件发放。"},
  [10] = {id=10,name="任务有奖",desc="1.活动期间完成指定任务，可以获得道具奖励。\n2.活动奖励在完成任务后直接通过邮件发放。\n3.每天都会有不同的任务，请注意查看。"},
  [11] = {id=11,name="幸运翻牌",desc="1.活动期间每天有3次免费翻牌机会，之后可以花费钻石进行翻牌。\n2.如果对奖励不满意，可以花费少量钻石刷新奖励。\n3.每次翻牌只能选择一个奖励，三个奖励的价值都大于花费的钻石数量。\n4.奖励分为三个档次，档次越高价值越高，不同档次还有不同的积分。\n5.活动结束后会根据积分排名发放奖励，奖励通过邮件发放。"},
  [12] = {id=12,name="外敌入侵",desc="1.活动期间，星系地图上会出现大量的外星战舰，攻击外星战舰，可获得大量的道具奖励。\n2.外星战舰分为多个等级，不同等级的战舰难度各不相同。\n3.获得的奖励多少与攻击外星舰队的血量多少相关，击杀能获得额外的奖励。\n4.攻击和击杀外星舰队都能获得活动积分，活动结束后会根据活动积分发放排名奖励。"},
  [13] = {id=13,name="幸运日",desc="1.幸运日活动开启期间，在游戏过程中有几率获得幸运BUFF。\n2.幸运BUFF分为多个类型，包括建筑升级时间减少、建筑升级消耗减少、科技研究时间减少等。\n3.幸运BUFF存在有时间限制，时间到了以后不再生效。\4.玩家每天获得幸运BUFF的次数有限制，次数为0时，不再获得幸运BUFF。"},
  [14] = {id=14,name="钻石夺宝",desc="1.花费钻石可在钻石夺宝处获得珍惜道具，五次夺宝享受9折优惠。\n2.智能水晶可在夺宝商店中兑换稀有领袖和领袖碎片，夺宝商店会不定期更新。\n3.累计夺宝次数达到指定数量时，还可以领取额外奖励，累计次数会在每周一0点重置；\n4.每夺宝一次，均会增加一定数量的幸运值，幸运值满时，必定获得稀有物品；\n5.获得稀有物品时，幸运值会重置为0，重新计算；\n6.已拥有领袖时，当夺宝抽中时会转换为该领袖的碎片；\n7.钻石夺宝的奖励每周一0点重置更换；"}
}
return DActivityOpen