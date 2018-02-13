--
-- @brief msg
-- @author myc
-- @date 2018/1/9
--

local cls = class("MsgDialog",cc.Node)

function cls:ctor(msg, yesFunc, noFunc, yesLabel, noLabel)
	self.msg = msg
	self.yesFunc = yesFunc
	self.noFunc = noFunc
	self.yesLabel = yesLabel
	self.noLabel = noLabel
	self:enableNodeEvents()
	self:initDialog()
	-- self:onTouch(handler(self,self.onTouchHandler), false, true)
	PopupManager:push(self)
end

function cls:initDialog()
	-- 遮罩
	Util:touchLayer(self)
	self.spBg = Util:sprite("img/big_img_panel2")
	self.spBg:addTo(self):pos(display.cx,display.cy)
	self.spTitle = Util:sprite("other/other_txt_title_ts")
	self.spTitle:addTo(self.spBg):pos(self.spBg:width() / 2,self.spBg:height() - 50)
	self.labMsg = Util:label(self.msg,28,Const.COLOR_GRAY,{width = self.spBg:width() - 60},
		cc.TEXT_ALIGNMENT_CENTER,cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	self.labMsg:addTo(self.spBg):center()
	local btnConfirm = Util:button("com/com_btn_number0",handler(self,self.btn_yesHandler),
				self.yesLabel or "确定",28, display.COLOR_WHITE)
				:addTo(self.spBg)
				:pos(self.spBg:width() / 2,100)
	if self.noFunc or self.noLabel then
		btnConfirm:x(self.spBg:width() / 2 - 200)
		Util:button("com/com_btn_number0",handler(self,self.btn_noHandler),
			self.yesLabel or "取消",28, display.COLOR_WHITE)
			:addTo(self.spBg)
			:pos(self.spBg:width() / 2 + 200,100)
	end
end

function cls:btn_yesHandler(target)
	if self.yesFunc then
		self.yesFunc()
	end
	PopupManager:popView(self)
end

function cls:btn_noHandler(target)
	if self.noFunc then
		self.noFunc()
	end
	PopupManager:popView(self)
end

return cls