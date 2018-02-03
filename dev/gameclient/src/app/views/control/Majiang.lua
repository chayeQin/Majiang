--
--@brief: 
--@author: qyp
--@date: 2017/12/25
--

local cls = class("Majiang", cc.load("mvc").ViewBase)

local RES_FORMAT = {
	[1] = "#majiang_icon_tong%d.png", -- 筒子
	[2] = "#majiang_icon_tiao%d.png", -- 条子
	[3] = "#majiang_icon_w%d.png", -- 万字
}

local SPECIAL_FORMAT = {
	"#dong.png", --东
	"#nan.png", --南
	"#xi.png", -- 西
	"#bei.png", --北
	"#zhong.png", -- 中
	"#fa.png", --发
	"#bai.png" -- 白
}

local M_TYPE_BG = {
	"#mjCardBg_1_1.png", -- 手牌1
	"#mjCardBg_1_5.png", -- 手牌2
	"#mjCardBg_1_3.png", -- 手牌3
	"#mjCardBg_1_4.png", -- 手牌4
	"#mjCardBg_1_2.png", -- 开牌1
	"#mjCardBg_1_6.png", -- 开牌2
	"#mjCardBg_1_2.png", -- 开牌3
	"#mjCardBg_1_6.png"  -- 开牌4
}

function cls:ctor(mType, num)
	cls.super.ctor(self)
	self.mType = mType
	self.num = num
	local bgRes = M_TYPE_BG[mType]
	local bg = display.newSprite(bgRes)
					:addTo(self)

	self.bg = bg
	bg:pos(bg:width()/2, bg:height()/2)
	
	if num and (self.mType == 1 or self.mType == 5 or 
				self.mType == 6 or self.mType == 7 or 
				self.mType == 8)then
		local cardType = math.floor(num / 10)
		local cardNum = (num-1) % 10 + 1
		local res = ""
		if cardType == 0 then
			res = SPECIAL_FORMAT[cardNum]
		else
			res = string.format(RES_FORMAT[cardType], cardNum)
		end
		self.cardNum = display.newSprite(res)
						:addTo(bg)
						:pos(bg:width()/2, bg:height()/2)
	end

	self:size(self.bg:width() - 2, bg:height())


	self:initType()
end


function cls:initType()
	if self.mType == 1 then
	elseif self.mType == 2 then
		self:scale(0.8)
	elseif self.mType == 3 then
		self:scale(0.8)
	elseif self.mType == 4 then
		self:scale(0.8)
	elseif self.mType == 5 then
		self:scale(0.8)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:y(self.cardNum:y() + 12)
	elseif self.mType == 6 then
		self:scale(0.8)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.60)
		self.cardNum:pos(self.cardNum:x() + 6, self.cardNum:y() + 7)
		self.cardNum:rotate(90)
	elseif self.mType == 7 then
		self:scale(0.8)
		self.cardNum:pos(self.cardNum:x(),self.cardNum:y() + 4)
		self.cardNum:scaleX(0.55)
		self.cardNum:scaleY(0.50)
		self.cardNum:rotate(180)
	elseif self.mType == 8 then
		self:scale(0.8)
		self.cardNum:rotate(-90)
		self.cardNum:pos(self.cardNum:x() -4, self.cardNum:y() + 8)
		self.cardNum:scaleX(0.5)
		self.cardNum:scaleY(0.6)
	end
end


return cls
