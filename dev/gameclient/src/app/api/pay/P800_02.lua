--
-- Author: lyt
-- Date: 2017-04-20 16:16:39
--
local P800Base = import(".P800Base")
local cls = class("P800_2", P800Base)

function cls:ctor()
	cls.super.ctor(self, "yhbz_ios1", "1a14dd16d60c8d81a9ea1ef30b4ffd38", "9100771517601921")
end

return cls