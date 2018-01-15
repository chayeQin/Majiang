--
-- @brief 活动界面
-- @author myc
-- @date 2018/1/9
--

local cls = class("ActivityView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ActivityView.csb"

cls.RESOURCE_BINDING = {
	-- Text Label
	["lab_content"] = {
		varname = "lab_content",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:ctor(content)
	cls.super.ctor(self)
	if not content or content == "" then
		content = "暂无活动！"
	end
	self.lab_content:setString(content)
	Util:touchLayer(self)
	PopupManager:push(self)
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls