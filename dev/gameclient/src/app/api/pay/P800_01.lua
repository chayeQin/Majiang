--
-- Author: lyt
-- Date: 2017-04-20 16:16:39
--
local P800Base = import(".P800Base")
local cls = class("P800_1", P800Base)

function cls:ctor()
	cls.super.ctor(self, "yhbz_ios", "9903ad55196d751a51ae78405cb2037b", "9100771817601921")
end

return cls