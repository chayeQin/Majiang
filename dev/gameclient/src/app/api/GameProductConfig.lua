--
-- @brief 游戏商品设定
-- @author: qyp
-- @date: 2016/07/22
--
-- key = 货币,value = 符号
cc.exports.CurrencySymbol = {
  ["CNY"] = "￥",
  ["USB"] = "$",
  ["THB"] = "฿",
  ["TWD"] = "NT$",
  ["VND"] = "₫",
}

--[[ 充值列表
	"award",    -- 奖励钻石
	"buyCnt",   -- 可购买次数
	"buyType",  -- 购买类型(0:'无限制',1:'永久可购买(购买次数限制)',2:'当天可购买(购买次数限制)') 
	"cnt",      -- 已购买次数
	"currency", -- 货币类型(CNY:人民币, USB:美元, THB:泰铢, TWD:新台币, VND:越南盾)
	"heat",     -- 是否热卖
	"iap",      -- ios in app purchase 码 
	"id" ,      -- 商品唯一id   
	"item",     -- 获得钻石   
	"name",     -- 商品名字    
	"price",    -- 价格  
	"step",     --    
	"vipExp",    -- 获得VIP经验   
-]]

--[[ 礼包列表
   "addStep",   
   "currency",  -- 货币类型(CNY:人民币, USB:美元, THB:泰铢, TWD:新台币, VND:越南盾)
   "id",        -- 礼包唯一id  
   "itemList" = {
       1 = {
           "item", -- 奖励物品Id
           "num",  -- 奖励物品数量
           "type", -- 奖励物品类型
       }
   }
   "name",   	-- 礼包名字
   "nextId", 	-- 下一个礼包id 
   "prodId", 	-- 对应充值列表的id,价格 
   "price",  	-- 价格
   "tag",    	-- 是否新号礼包
   "startTime", -- 开启时间
   "endTime",   -- 结束时间
]]