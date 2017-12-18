-- Z_章节配置表.xlsx
-- id=章节ID,nextId=下一章节,chapterName=篇章名称,name=章节名称,desc=章节描述,pic=图片ID,centerLv=指挥中心等级,
local DTaskChapter = {
  [1001] = {id=1001,nextId=1002,chapterName="初篇",name="初入星系",desc="想在星系中生存，首先需要拥有强大的舰队，打造战舰是必不可少的",pic=0,centerLv=1},
  [1002] = {id=1002,nextId=1003,chapterName="第一篇",name="丰衣足食",desc="囤积资源有利快速的发展，建造资源矿和在星系中采集资源都是获得资源的主要途径",pic=0,centerLv=1},
  [1003] = {id=1003,nextId=1004,chapterName="第二篇",name="打造装备",desc="指挥官装备能快速提升自己的实力，打造多类型的战舰能让你的舰队更加强大",pic=0,centerLv=1},
  [1004] = {id=1004,nextId=1005,chapterName="第三篇",name="智能领袖",desc="智能领袖能加强你的战舰能力，出征时别忘了带上你的领袖一同出征",pic=0,centerLv=1},
  [1005] = {id=1005,nextId=1006,chapterName="第四篇",name="研究科技",desc="强大的堡垒少不了科技的支持，研究科技能多方面提升堡垒的实力，多击杀星际海盗可以获得科技因子",pic=0,centerLv=4},
  [1006] = {id=1006,nextId=1007,chapterName="第五篇",name="互相帮助",desc="多与联盟内的玩家多交流，您一定能获益匪浅，大家相互帮助还能提升建筑升级速度",pic=0,centerLv=5},
  [1007] = {id=1007,nextId=1008,chapterName="第六篇",name="额外收入",desc="想快速获得更多的资源，文明遗迹、星际商船都能够帮助到你",pic=0,centerLv=6},
  [1008] = {id=1008,nextId=1009,chapterName="第七篇",name="齐心协力",desc="与联盟中的朋友一起扬帆起航吧，一起集结能强大舰队的实力，挑战更高难度的玩家",pic=0,centerLv=7},
  [1009] = {id=1009,nextId=1010,chapterName="第八篇",name="星际探索",desc="在黄道十二星座中探索宇宙的奥秘，能够让你获益良多，还能获得装备打造的材料",pic=0,centerLv=9},
  [1010] = {id=1010,nextId=1011,chapterName="第九篇",name="战舰机甲",desc="战舰机甲能提升战舰的基础属性，机甲材料除了可以自己生产外，还能与其他玩家交易",pic=0,centerLv=14},
  [1011] = {id=1011,nextId=0,chapterName="第十篇",name="城邦投资",desc="在星际城邦中进行投资，能获得强大的buff加成，赶快去获取资源对城邦进行投资吧",pic=0,centerLv=19}
}
return DTaskChapter