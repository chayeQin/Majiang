--
--@brief: 
--@author: qyp
--@date: 2017/12/24
--

local cls = class("Dice", cc.load("mvc").ViewBase)

function cls:ctor(num)
	cls.super.ctor(self)
	self.num = num
	local res =  string.format("shaizi_%d.png", self.num)
	local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(res)
	self.sp = display.newSprite(frame)
				:addTo(self)
end

function cls:playAni()
	local array = {}
	for i = 1, 6 do
		local num  = math.random(1, 6)
		local res =  string.format("shaizi_%d.png", num)
		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(res)
		table.insert(array,frame)
	end
	local res =  string.format("shaizi_%d.png", self.num)
	local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(res)
	table.insert(array,frame)
	local animation = cc.Animation:createWithSpriteFrames(array, 0.1)
	local action = cc.Animate:create(animation)

	self.sp:runAction(action)
end

return cls