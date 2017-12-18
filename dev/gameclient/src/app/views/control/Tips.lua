--
--@brief 游戏提示飘字
--@author qyp
--@date 2016/2/2
--

local cls = class("Tips", cc.Node)

function cls.show(msg, item)
	local currTips =  appView:getChildByTag(TAGS.Tips)
	if currTips then
		currTips:remove()
	end
	local tips = Tips.new(msg, item)
	return tips
end

function cls:ctor(msg, item)
	if appView:getChildByTag(TAGS.Tips) then
		Tips.show(msg, item)
		return
	end
	local bg1 = Util:sprite9Lib("ui/tips_bg_03")
					:size(960,72)
					:addTo(self)
					:scaleY(0)
	local bg2 = Util:sprite9Lib("ui/tips_bg_02")
					:size(960,72)
					:addTo(self)
					:opacity(0)
	self.bg1 = bg1
	self.bg2 = bg2
	self.light = Util:sprite("ui/tips_bg_01")
					:addTo(self)
					:scaleX(0)


	local lab = Util:systemLabel(msg, 20, cc.c3b(0xff,0xe8,0x4d), cc.size(500, 0), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
					:addTo(bg1)
	lab:enableShadow()
	local bgHeight = math.max(bg1:height(), lab:height()+40)
	bg1:height(bgHeight)
	bg2:height(bgHeight)
	lab:center(0,0)

	if item then
		local img = Util:getGoodsIcon(item.type, item.id)
		local tmp = display.newNode()
						:addTo(self)
						:x(-250)
		Util:sprite(img)
			:addTo(tmp)
			:pos(tmp:width()/2, tmp:height()/2)
	end
	self:setCascadeOpacityEnabled(true)
	self:enableNodeEvents()
	self:addTo(appView, TAGS.Tips, TAGS.Tips)
		:pos(display.width/2, display.height*2/3 + 100)
end

function cls:onEnter()
	self.light:run{"seq",
		{"scaleto",0.15,1.2,1},
		{"spa",
			{"scaleto",0.05,1,1},
			{"fadeout",0.05}
		}	
	}
	self.bg1:run{"seq",
		{"scaleto",0.2,1,0.1},
		{"scaleto",0.1,1,1},
		{"delay", 0.3},
		{"fadeto", 1, 255 * 0.5}
	}
	self.bg2:run{"seq",
		{"delay",0.3},
		{"fadein",0.1},
		{"fadeout",0.1},
	}
	self:run{"seq",
		{"delay",2},
		{"fadeout",0.15},
		{"remove"}
	}
	-- self:scaleY(0)
	-- self:run{"seq",
	-- 			{"scaleto",0.15, 1, 1},
	-- 			{"delay", 1.5},
	-- 			{"remove"}
	-- }
end

return cls
