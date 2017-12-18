--
-- @brief 
-- @author: yjg
-- @date: 2016年6月13日20:01:02
--

local cls = class("TestGetProp", cc.load("mvc").ViewBase)

--爆出来的物品散落的区域，消失的位置，道具的类型，道具的id，道具的数量
function cls:ctor(node,over,type,id,count)
	cls.super.ctor(self)
	self.node = node
	self.over = over or cc.p(100,100)
	self.type = type or 5
	self.id = id or 1
	self.count = count or 5000

	self.sp = {}
	if self.count  >  20 then
		self.count  = 20
	end
	for i=1,self.count do
		local path =  Util:getGoodsIcon(self.type,self.id)

		local sX = self.node:x() -  (self.node:width()/2) + 45 
		local eX = self.node:x() +  (self.node:width()/2) - 45 
		local x = math.random(sX ,eX)

		local sY = self.node:y() -  (self.node:height()/2) + 45 
		local eY = self.node:y() +  (self.node:height()/2) - 45 		
		local y = math.random(sY,eY)

		print(x,y)
		self.sp[i] = Util:sprite(path):addTo(self):pos(x,y)
	end

	for i=1,#self.sp do
		local x = self.sp[i]:x()
		local y = self.sp[i]:y()
		local time = math.abs( (self.over.x+self.over.y)-(x+y)) * 0.01 / 2 / 2 / 2
		self.sp[i]:run({
				"seq",
				{"delay",1},
				{"moveto",time,cc.p(self.over.x,self.over.y)},
				{"call",function() 
					self.sp[i]:remove() 
					self.sp[i] = nil 
				end}
				})
	end

	self:addTo(appView)
end
--退出
function cls:quit(event)
	if event.name == "began" then
		return true
	elseif event.name == "moved" then
	elseif event.name == "ended" then
		self.layer:remove()
	end
end

return cls