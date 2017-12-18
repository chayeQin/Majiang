--
-- Author: lyt
-- Date: 2017-04-20 16:16:39
--
local P800Base = import(".P800Base")
local cls = class("P800_4", P800Base)

function cls:ctor()
	cls.super.ctor(self, "yhbz_ios3", "aea0690dc61963d4f89db662db75fcd3", "9100771518021921")
end

return cls