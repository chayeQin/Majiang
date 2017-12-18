--
-- Author: lyt
-- Date: 2017-04-20 15:52:32
--
local cls = class("P800Msg", cc.load("mvc").ViewBase)

function cls:ctor(pay)
	self.pay = pay
	cls.super.ctor(self)

	Util:touchLayer(self)
	PopupManager:push(self)
end

function cls:onCreate()
	local size = cc.size(600, 300)
	local node = display.newNode():addTo(self)
		:size(size)
		:pos((display.width - size.width) / 2, (display.height - size.height) / 2)

	Util:sprite9Lib("9sprite/a_9sp_05"):addTo(node)
		:size(size)
		:pos(size.width / 2, size.height / 2)

	Util:label(Lang:find("zffs_zffs")):addTo(node)
		:pos(size.width / 2, size.height - 38)

	Util:button("button/a_btn_guanbi_01", handler(self, self.btn_closeHandler)):addTo(node)
		:pos(size.width - 64, size.height - 38)

	Util:button("ui/ui_pingguozhifu", handler(self, self.btn_iosHandler)):addTo(node)
		:pos(178, 160)
	Util:label(Lang:find("zffs_pgzf")):addTo(node)
		:pos(178, 70)

	Util:button("ui/ui_disanfang", handler(self, self.btn_otherHandler)):addTo(node)
		:pos(446, 160)
	Util:label(Lang:find("zffs_qtzf")):addTo(node)
		:pos(446, 70)
end

function cls:btn_closeHandler()
	PopupManager:popView(self)
	self.pay = nil
end

function cls:btn_iosHandler()
	self.pay:payForSdk()
	self:btn_closeHandler()
end

function cls:btn_otherHandler()
	self.pay:payForWeb()
	self:btn_closeHandler()
	HeartBeatUtil:updateJewel(10) -- 尝试多少次
end

return cls