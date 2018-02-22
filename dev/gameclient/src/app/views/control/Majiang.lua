--
--@brief: 
--@author: qyp
--@date: 2017/12/25
--

local cls = class("Majiang", cc.load("mvc").ViewBase)

local RES_FORMAT = {
	[1] = "majiang_icon_tong%d", -- 筒子
	[2] = "majiang_icon_tiao%d", -- 条子
	[3] = "majiang_icon_w%d", -- 万字
}

local SPECIAL_FORMAT = {
	"dong", --东
	"nan", --南
	"xi", -- 西
	"bei", --北
	"zhong", -- 中
	"fa", --发
	"bai" -- 白
}

local M_TYPE_BG = {
	"mjCardBg_1_1", -- 手牌1
	"mjCardBg_1_5", -- 手牌2
	"mjCardBg_1_3", -- 手牌3
	"mjCardBg_1_4", -- 手牌4
	"mjCardBg_1_2", -- 开牌1
	"mjCardBg_1_6", -- 开牌2
	"mjCardBg_1_2", -- 开牌3
	"mjCardBg_1_6", -- 开牌4
	"mjCardBg_1_2", -- 开牌1
	"mjCardBg_1_6", -- 开牌2
	"mjCardBg_1_2", -- 开牌3
	"mjCardBg_1_6", -- 开牌4
}

-- 左下角anchor
function cls:ctor(mType, num)
	cls.super.ctor(self)
	self.mType = mType
	self.num = num
	local bgRes = M_TYPE_BG[mType]
	local bg = Util:sprite("mjCardBg/" ..bgRes)
					:addTo(self)
	self.bg = bg
	bg:pos(bg:width()/2, bg:height()/2)
	
	if num and (self.mType == 1 or self.mType >= 5)then
		local cardType = math.floor(num / 10)
		local cardNum = (num-1) % 10 + 1
		local res = ""
		if cardType == 0 then
			res = SPECIAL_FORMAT[cardNum]
		else
			res = string.format(RES_FORMAT[cardType], cardNum)
		end
		self.cardNum = Util:sprite("majiang/" .. res)
						:addTo(bg)
						:pos(bg:width()/2, bg:height()/2)
		self.blueShadow = display.newLayer(cc.c4b(0, 162, 232, 0.4))
								:addTo(self)
								:size(self.bg:width(), self.bg:height())
								:hide()
	end

	self:size(self.bg:width() - 2, bg:height())
	self:initType()
end

function cls:initType()
	if self.mType == 1 then 
		self.cardNum:y(self.cardNum:y() - 6)
		self:scale(1.25)
	elseif self.mType == 2 then
		self:scale(0.9)
	elseif self.mType == 3 then
		self:scale(0.9)
	elseif self.mType == 4 then
		self:scale(0.9)
	elseif self.mType == 5 then
		self:scale(1.3)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:y(self.cardNum:y() + 6)
	elseif self.mType == 6 then
		self:scale(0.85)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.60)
		self.cardNum:pos(self.cardNum:x() , self.cardNum:y() + 7)
		self.cardNum:rotate(90)
	elseif self.mType == 7 then
		self:scale(0.9)
		self.cardNum:pos(self.cardNum:x(),self.cardNum:y() + 6)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:rotate(180)
	elseif self.mType == 8 then
		self:scale(0.9)
		self.cardNum:rotate(-90)
		self.cardNum:pos(self.cardNum:x(), self.cardNum:y() + 8)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.6)
	elseif self.mType == 9 then
		self:scale(1.3)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:y(self.cardNum:y() + 6)
	elseif self.mType == 10 then
		self:scale(1.3)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.60)
		self.cardNum:pos(self.cardNum:x() , self.cardNum:y() + 7)
		self.cardNum:rotate(90)
	elseif self.mType == 11 then
		self:scale(1.3)
		self.cardNum:pos(self.cardNum:x(),self.cardNum:y() + 6)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:rotate(180)
	elseif self.mType == 12 then
		self:scale(1.3)
		self.cardNum:rotate(-90)
		self.cardNum:pos(self.cardNum:x(), self.cardNum:y() + 8)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.6)
	end

end

function cls:showBlueShadow(boo)
	self.blueShadow:setVisible(boo)
end

return cls
