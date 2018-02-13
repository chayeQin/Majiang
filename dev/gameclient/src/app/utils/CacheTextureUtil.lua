--
-- Author: lyt
-- Date: 2016-12-05 10:42:16
-- 纹理检测类
local cls = class("CacheTextureUtil")

local IMAGE = "cache_check.png"

function cls:ctor()
end

function cls:clear()
	if not self.loop then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
	self.loop = nil
end
function cls:reset()
	-- if self.loop then
	-- 	return
	-- end
	-- self.loop = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.tickHandler), 1, false)
	-- display.loadImage(IMAGE)
end

function cls:tickHandler()
	local img = display.getImage(IMAGE)
	if img then
		return
	end

	self:clear()
	local msg = Msg.new(Lang:find("sys_no_handle") .. ":2",handler(app,app.restart))
	msg.isCanClose = false
end

return cls