--
-- @brief loading界面
-- @author qyp
-- @date 2015/11/21
--

local cls = class("Loading", function()
    return display.newLayer(cc.c4b(0,0,0,0)):size(display.width,display.height)
end)

local TIMEOUT = 60 * 3 -- 超时秒

local showCount = 0

function cls.show(time)
	time = time or 10
	showCount = showCount + 1
	local parent = appView
	local loading = parent:getChildByTag(TAGS.Loading)
	if loading then
		loading:showView()
	else
		cls.new()
	end
end

function cls.hide(v)
	if v then
		showCount = 0
	else
		showCount = showCount - 1
	end

	if showCount < 0 then
		showCount = 0
	elseif showCount > 0 then
		return
	end

	local parent = appView
	local loading = parent:getChildByTag(TAGS.Loading)
	if loading then
		loading:hideView()
	end
end

function cls.count()
	return showCount
end

function cls:ctor()
	self.sp = Util:createAniWithCsb("loading",3)
		:addTo(self)
		:pos(display.width/2, display.height/2)

	self:showView()
	self:addTo(appView,TAGS.Loading,TAGS.Loading)
end

function cls:showView()
	self:setVisible(true)
	self.sp:hide()

	self.sp:run{
		"seq",
		{"delay", 0.3},
		{"show"}
	}

	self:onTouch(handler(self, self.onTouchHandler), nil, true)
end

function cls:hideView()
	self:setVisible(false)
	self:setTouchEnabled(false)
end

function cls:onTouchHandler(event)
	if event.name == "ended" then
	end
	return true
end

return cls
