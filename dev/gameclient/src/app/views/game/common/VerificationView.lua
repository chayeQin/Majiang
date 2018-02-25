--
-- @brief 实名验证
-- @author myc
-- @date 2018/2/25
--

local cls = class("VerificationView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/VerificationView.csb"

cls.RESOURCE_BINDING = {
	["btn_confirm"] = {
		varname = "btn_confirm",
		method = "btn_confirmHandler",
	},
	["img_id"] = {
		varname = "img_id",
	},
	["img_name"] = {
		varname = "img_name",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
	["img_bg"] = {
		varname = "img_bg",
	},
}


function cls:onCreate()
	Util:touchLayer(self)
	PopupManager:push(self)
	local size = self.img_name:size()
	size.width = size.width * 0.7
	size.height = size.height * 0.8
	self.txt_name = Util:editBox(size,nil,"empty.png")
	self.txt_name:addTo(self.img_name)
				:center()
	self.txt_id = Util:editBox(size,nil,"empty.png")
	self.txt_id:addTo(self.img_id)
				:center()
	self.txt_name:setPlaceHolder("请输入姓名")
	self.txt_id:setPlaceHolder("请输入身份证号")
	self.txt_name:setPlaceholderFontColor(Const.COLOR_GRAY)
	self.txt_name:setFontColor(Const.COLOR_GRAY)
	self.txt_id:setPlaceholderFontColor(Const.COLOR_GRAY)
	self.txt_id:setFontColor(Const.COLOR_GRAY)
end

function cls:btn_confirmHandler(target)
	local name = self.txt_name:getText()
	local id = self.txt_id:getText()
	if (name == "") then
		Msg.new("名字不能为空")
		return
	elseif (id == "") then
		Msg.new("身份证不能为空")
		return
	end
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls