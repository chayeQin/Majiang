-- d_道具立即使用类.xlsx
-- id=编号,name=名称,packType=背包类型,canUse=可否直接实用,skip=功能跳转,pic=图片ID,quality=品质,buyGold=金币要求,explain1=文本说明,desc=功能说明,
local DPropImmediately = {
  [1] = {id=1,name="随机迁城",packType=2,canUse=1,skip=0,pic=5001,quality=3,buyGold=500,explain1="",desc="将您的城市随机迁往本星系的某个位置"},
  [2] = {id=2,name="高级迁城",packType=2,canUse=1,skip=1,pic=5002,quality=4,buyGold=2000,explain1="",desc="将您的城市迁往本星系的任意位置，注意堡垒等级达到6级后将不能迁往其他星系"},
  [4] = {id=4,name="指挥官天赋重置",packType=4,canUse=1,skip=2,pic=5004,quality=4,buyGold=1000,explain1="",desc="使用后可以重置您的所有技能点数。重置后，技能点全部返还，您需要重新学习技能"},
  [5] = {id=5,name="指挥官改名",packType=4,canUse=1,skip=3,pic=5005,quality=4,buyGold=200,explain1="",desc="使用该道具可以修改您的昵称"},
  [6] = {id=6,name="更换形象",packType=4,canUse=1,skip=4,pic=5006,quality=4,buyGold=400,explain1="",desc="使用该道具可以修改您的指挥官形象"},
  [7] = {id=7,name="喇叭",packType=4,canUse=1,skip=5,pic=5007,quality=4,buyGold=500,explain1="",desc="使用喇叭可以发送一条全星系可见的公告"},
  [8] = {id=8,name="联盟迁城",packType=4,canUse=1,skip=1,pic=5008,quality=4,buyGold=0,explain1="",desc="使用联盟迁城，可迁往盟主附近的位置"},
  [9] = {id=9,name="新手迁城",packType=4,canUse=1,skip=1,pic=5009,quality=0,buyGold=0,explain1="",desc="注册3天内，堡垒小于19级（不含19级）的指挥官可以将堡垒迁往其他星系的随机位置"}
}
return DPropImmediately