--
-- @brief 
-- @author: qyp
-- @date: 2016/02/18
--

local cls = class("TestSelectView", cc.load("mvc").ViewBase)
-- local CityUI = require("app.views.game.CityUI")

function cls:ctor()

	-- local testLst = {
	-- 	"test.TestMap",
	-- 	"game.CityView",
	-- 	"game.WorldView",
	-- 	"test.TestRotate",
	-- 	"test.TestCocosCode",
	-- }

	-- for i, v in ipairs(testLst) do
	-- 	Util:button("button/button_bg_01", function()
	-- 		self:switch(v)
	-- 	end, v)
	-- 		:addTo(self)
	-- 		:pos(300, display.height - i*100)
	-- end


	-- local listView = require("app.views.control.ListView").new(800, 500)
	-- 				:addTo(self)
	-- 				:pos(200, 100)
	-- -- listView.isUpdateEffect = true

	-- local lst = {}
	-- for i = 1, 20 do
	-- 	lst[i] = i
	-- end
	-- listView:update(lst, 1)
	-- listView:setScrollBar("ui/chat_zt_01", "ui/chat_zt_02")


	-- Util:button("button/button_bg_01", function()
	-- 	-- for i = 1, 10 do
	-- 		listView:insert(99, 3)
	-- 	-- end
	-- 		-- listView:update(lst, 1)

	-- end, "insert")
	-- 	:addTo(self)
	-- 	:pos(300, 50)

	-- Util:button("button/button_bg_01", function()
	-- 	listView:removeCell(listView.tail_)
	-- 	-- listView:removeCell(3)
	-- end, "removeCell")
	-- 	:addTo(self)
	-- 	:pos(500, 50)
	-- local lst  = {}
	-- for i = 1, 25 do
	-- 	table.insert(lst, i)
	-- end

	-- table.insert(lst, 100)
	-- table.insert(lst, 201)
	-- table.insert(lst, 202)
	-- table.insert(lst, 203)
	-- table.insert(lst, 204)
	-- table.insert(lst, 301)
	-- table.insert(lst, 302)
	-- table.insert(lst, 303)
	-- table.insert(lst, 304)

	-- local origY = display.height - 50
	-- local origX = display.cx
	-- for i, v in ipairs(lst) do

	-- 	local x = (i-1)%5 * 100 + origX
	-- 	local y = origY - 100 * math.floor((i-1)/5)
	-- 	require ("app.views.control.BuildingMenuButton").new(nil, v)
	-- 	:addTo(self)
	-- 	:pos(x,y)	
	-- end

	-- local list = ccui.ListView:create()
	-- 	:addTo(self)
	-- 	:pos(300, 300)
	-- 	:size(300, 600)

	-- list:setDirection(ccui.ScrollViewDir.vertical)
	
	-- for i = 1, 10 do
	-- 	local childLst = ccui.ListView:create()
	-- 						:size(300, 300)
	-- 	childLst:setDirection(ccui.ScrollViewDir.horizontal)
	-- 	for j = 1, 10 do
	-- 		local sp = Util:button("quality/xzbs")
	-- 		childLst:pushBackCustomItem(sp)
	-- 	end
	-- 	list:pushBackCustomItem(childLst)
	-- end

	self.img = {}
	self.text_num_1 = 0
	local x = display.cx
	for i=1,9 do
		self.img[i] = Util:sprite("props_u/100"..i):addTo(self):pos(x,display.cy):scale(1-(i*0.01))
		x = x + 50
	end

	local layer = display.newLayer(cc.c4b(0,0,0,0)):size(display.width,display.height):addTo(self,999)
	layer:onTouch(handler(self,self.onTouchHandler), nil, true)
end

function cls:createCell(i, data)
	local node = display.newNode():size(150, 150)


	return node
end
function cls:btnHandler(target)
	print(target.tag)
end

function cls:onSlide(event)
	local target =event.target
	print(target:getPercent())
end

function cls:switch(view)
	Util:event(Event.gameSwitch, view)
end

--翻牌
function cls:fanpai( ... )
	-- 翻牌
	local A = Util:sprite("logo/login_logo_01"):addTo(self):pos(display.cx,display.cy)
		A:run({
				"seq",
				{"camera", 5 , 45,0 , 0,90 , 0,0},
				{"call",function ( ... )
					A:remove()
					A = nil
					local C = Util:sprite("logo/login_logo_01"):addTo(self):pos(display.cx,display.cy)
					C:run{"camera", 5 , 45,0 , -90,90 , 0,0}
				end}
			})
end


function cls:onTouchHandler( event )
	local world = self:convertToNodeSpace(cc.p(event.x,event.y))
	if event.name == "began" then
		print("123")
		self.touchBeganP = cc.p(world.x, world.y)
		self.lastP = self.touchBeganP
		self.isDrag = false
		return true
	elseif event.name == "moved" then
		if not self.isDrag and math.abs(self.touchBeganP.x - world.x) > 30 then
			self.isDrag = true
			print("456")
		end
	elseif event.name == "ended" then
		if self.isDrag then
			if world.x - self.touchBeganP.x > 0 then -- 向右滑动
				print("→")
				self:zhuandong(1)
			else
				print("←")
				self:zhuandong(1)
			end

		end
	end
end

function cls:xingzuo( ... )
	for i=1,#self.img do
		self.img[i]:run({
						     "rep",
						     {
						         "seq",
									{"moveBy",0.5,cc.p(30  ,0)},
									{"call",function( ... )
										if self.img[i]:x() > display.cx + 240 then
											self.img[i]:x(display.cx) 
										end
									end}
						     }
 						})
	end
end

function cls:xiangyou( ... )
	for i=1,#self.img do
		print("1")
		self.img[i]:run({
						     "rep",
						     {
						         "seq",
									{"moveBy",0.5,cc.p(-30  ,0)},
									{"call",function( ... )
										if self.img[i]:x() < display.cx then
											self.img[i]:x(display.cx + 240) 
										end
									end}
						     }
 						})
	end
end

function cls:zhuandong( num )
	local count = nil
	local max = 1.1
	local step = 180/10
	local extra = nil 
	local extraCount = 0	
	count = 0 
	local sum = num - 1 - self.text_num_1
	extra = sum + 130
	self.text_num_1 = num 

	local function play()
		local time = max - math.sin(math.rad(count)) - 0.05
		for i=1,#self.img do
				local function moveEnd()
				--如果图片的Y轴超出则重设图片的位置
				if self.img[i]:x() < display.cx then
					self.img[i]:x(display.cx + 400)
				end
				if i == #self.img then
					if time < 0.11 then
						if extraCount < extra then
							extraCount = extraCount + 1
							play()
							return
						end
					end
					count = count + step
					if count > 180 then
						print("转完了=========")
					else
						play()
					end
 				end
			end
			self.img[i]:run{
				"seq",
				{"moveby",time,cc.p(-50,0)},
				{"call",moveEnd}
			}
		end
	end
	play()

	-- self:run{
	-- 		"seq",
	-- 		{"delay",2},
	-- 		{"call",play}
	-- 	}

end

return cls

