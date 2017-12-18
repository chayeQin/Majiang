-- t_特殊礼包子礼包设定.xlsx
-- id=ID,groupId=礼包分组ID,sonId=礼包子ID,nextId=下一礼包子ID,count=可购买次数,pic=图片ID,grade=充值档位,percent=百分比显示用数字,name=礼包名字,desc=礼包描述,
local DSpecialGiftBagSetting = {
  [1] = {id=1,groupId=1,sonId=1,nextId=0,count=1,pic=21,grade=7,percent=3749,name="新手礼包Lv.1",desc="新手礼包1.0，高价值，高性价比，没有比这个更划算的充值礼包，终身只可购买一次，错过就不会再遇到了，赶快购买吧！"},
  [2] = {id=2,groupId=3,sonId=2,nextId=0,count=1,pic=21,grade=1,percent=2058,name="新手礼包Lv.2",desc="新手礼包2.0，高价值，高性价比，没有比这个更划算的充值礼包，终身只可购买一次，错过就不会再遇到了，赶快购买吧！"},
  [101] = {id=101,groupId=2,sonId=101,nextId=102,count=1,pic=21,grade=1,percent=3028,name="初级联盟礼包",desc="超高性价比，比任何礼包都要划算，购买后，全联盟成员还可获得联盟宝箱，让他们与您一起分享礼包的乐趣！"},
  [102] = {id=102,groupId=2,sonId=102,nextId=-1,count=1,pic=21,grade=2,percent=2603,name="高级联盟礼包",desc="超高性价比，比任何礼包都要划算，购买后，全联盟成员还可获得联盟宝箱，让他们与您一起分享礼包的乐趣！"},
  [301] = {id=301,groupId=4,sonId=401,nextId=402,count=1,pic=1,grade=7,percent=1750,name="指挥官超值礼包Lv.1",desc="指挥官超值礼包，快速升级指挥官属性的必备礼包，赶快购买吧！"},
  [302] = {id=302,groupId=4,sonId=402,nextId=403,count=1,pic=1,grade=1,percent=2268,name="指挥官超值礼包Lv.2",desc="指挥官超值礼包，快速升级指挥官属性的必备礼包，赶快购买吧！"},
  [303] = {id=303,groupId=4,sonId=403,nextId=404,count=1,pic=1,grade=3,percent=1746,name="指挥官超值礼包Lv.3",desc="指挥官超值礼包，快速升级指挥官属性的必备礼包，赶快购买吧！"},
  [304] = {id=304,groupId=4,sonId=404,nextId=405,count=1,pic=1,grade=4,percent=1319,name="指挥官超值礼包Lv.4",desc="指挥官超值礼包，快速升级指挥官属性的必备礼包，赶快购买吧！"},
  [305] = {id=305,groupId=4,sonId=405,nextId=0,count=0,pic=1,grade=5,percent=1130,name="指挥官超值礼包Lv.5",desc="指挥官超值礼包，快速升级指挥官属性的必备礼包，赶快购买吧！"},
  [401] = {id=401,groupId=5,sonId=501,nextId=502,count=1,pic=2,grade=7,percent=1828,name="战舰超值礼包Lv.1",desc="战舰超值礼包，让你快速拥有强大舰队，快速打造战舰，赶快购买吧！"},
  [402] = {id=402,groupId=5,sonId=502,nextId=503,count=1,pic=2,grade=1,percent=2268,name="战舰超值礼包Lv.2",desc="战舰超值礼包，让你快速拥有强大舰队，快速打造战舰，赶快购买吧！"},
  [403] = {id=403,groupId=5,sonId=503,nextId=504,count=1,pic=2,grade=3,percent=1721,name="战舰超值礼包Lv.3",desc="战舰超值礼包，让你快速拥有强大舰队，快速打造战舰，赶快购买吧！"},
  [404] = {id=404,groupId=5,sonId=504,nextId=505,count=1,pic=2,grade=4,percent=1300,name="战舰超值礼包Lv.4",desc="战舰超值礼包，让你快速拥有强大舰队，快速打造战舰，赶快购买吧！"},
  [405] = {id=405,groupId=5,sonId=505,nextId=0,count=0,pic=2,grade=5,percent=1114,name="战舰超值礼包Lv.5",desc="战舰超值礼包，让你快速拥有强大舰队，快速打造战舰，赶快购买吧！"},
  [501] = {id=501,groupId=6,sonId=601,nextId=602,count=1,pic=3,grade=7,percent=1907,name="科技超值礼包Lv.1",desc="科技超值礼包，研究科技不用愁，不用为科技因子烦恼了！"},
  [502] = {id=502,groupId=6,sonId=602,nextId=603,count=1,pic=3,grade=1,percent=2085,name="科技超值礼包Lv.2",desc="科技超值礼包，研究科技不用愁，不用为科技因子烦恼了！"},
  [503] = {id=503,groupId=6,sonId=603,nextId=604,count=1,pic=3,grade=3,percent=1680,name="科技超值礼包Lv.3",desc="科技超值礼包，研究科技不用愁，不用为科技因子烦恼了！"},
  [504] = {id=504,groupId=6,sonId=604,nextId=605,count=1,pic=3,grade=4,percent=1269,name="科技超值礼包Lv.4",desc="科技超值礼包，研究科技不用愁，不用为科技因子烦恼了！"},
  [505] = {id=505,groupId=6,sonId=605,nextId=0,count=0,pic=3,grade=5,percent=1088,name="科技超值礼包Lv.5",desc="科技超值礼包，研究科技不用愁，不用为科技因子烦恼了！"},
  [601] = {id=601,groupId=7,sonId=701,nextId=702,count=1,pic=4,grade=7,percent=1591,name="装备超值礼包Lv.1",desc="装备超值礼包，橙色指挥官装备，你值得用以后，赶快购买装备超值礼包吧！"},
  [602] = {id=602,groupId=7,sonId=702,nextId=703,count=1,pic=4,grade=1,percent=2001,name="装备超值礼包Lv.2",desc="装备超值礼包，橙色指挥官装备，你值得用以后，赶快购买装备超值礼包吧！"},
  [603] = {id=603,groupId=7,sonId=703,nextId=704,count=1,pic=4,grade=2,percent=1961,name="装备超值礼包Lv.3",desc="装备超值礼包，橙色指挥官装备，你值得用以后，赶快购买装备超值礼包吧！"},
  [604] = {id=604,groupId=7,sonId=704,nextId=705,count=1,pic=4,grade=3,percent=1763,name="装备超值礼包Lv.4",desc="装备超值礼包，橙色指挥官装备，你值得用以后，赶快购买装备超值礼包吧！"},
  [605] = {id=605,groupId=7,sonId=705,nextId=0,count=0,pic=4,grade=4,percent=1085,name="装备超值礼包Lv.5",desc="装备超值礼包，橙色指挥官装备，你值得用以后，赶快购买装备超值礼包吧！"},
  [701] = {id=701,groupId=8,sonId=801,nextId=802,count=1,pic=5,grade=7,percent=1528,name="机甲超值礼包Lv.1",desc="机甲超值礼包，大量钢材和材料，还在等什么？赶快来买吧！"},
  [702] = {id=702,groupId=8,sonId=802,nextId=803,count=1,pic=5,grade=1,percent=1930,name="机甲超值礼包Lv.2",desc="机甲超值礼包，大量钢材和材料，还在等什么？赶快来买吧！"},
  [703] = {id=703,groupId=8,sonId=803,nextId=804,count=1,pic=5,grade=2,percent=1600,name="机甲超值礼包Lv.3",desc="机甲超值礼包，大量钢材和材料，还在等什么？赶快来买吧！"},
  [704] = {id=704,groupId=8,sonId=804,nextId=805,count=1,pic=5,grade=2,percent=1325,name="机甲超值礼包Lv.3",desc="机甲超值礼包，大量钢材和材料，还在等什么？赶快来买吧！"},
  [705] = {id=705,groupId=8,sonId=805,nextId=0,count=0,pic=5,grade=2,percent=1126,name="机甲超值礼包Lv.3",desc="机甲超值礼包，大量钢材和材料，还在等什么？赶快来买吧！"},
  [801] = {id=801,groupId=9,sonId=901,nextId=0,count=0,pic=1,grade=1,percent=5902,name="金属超值礼包Lv.1",desc=""},
  [901] = {id=901,groupId=10,sonId=902,nextId=0,count=0,pic=1,grade=4,percent=5328,name="金属超值礼包Lv.2",desc=""},
  [1001] = {id=1001,groupId=11,sonId=1001,nextId=0,count=0,pic=2,grade=1,percent=5902,name="燃气超值礼包Lv.1",desc=""},
  [1101] = {id=1101,groupId=12,sonId=1002,nextId=0,count=0,pic=2,grade=4,percent=5328,name="燃气超值礼包Lv.2",desc=""},
  [1201] = {id=1201,groupId=13,sonId=1101,nextId=0,count=0,pic=3,grade=1,percent=5945,name="能源超值礼包Lv.1",desc=""},
  [1301] = {id=1301,groupId=14,sonId=1102,nextId=0,count=0,pic=3,grade=4,percent=5435,name="能源超值礼包Lv.2",desc=""},
  [1401] = {id=1401,groupId=15,sonId=1201,nextId=0,count=0,pic=4,grade=1,percent=5945,name="晶体超值礼包Lv.1",desc=""},
  [1501] = {id=1501,groupId=16,sonId=1202,nextId=0,count=0,pic=4,grade=4,percent=5435,name="晶体超值礼包Lv.2",desc=""}
}
return DSpecialGiftBagSetting