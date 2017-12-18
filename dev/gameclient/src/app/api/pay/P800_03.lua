--
-- Author: lyt
-- Date: 2017-04-20 16:16:39
--
local P800Base = import(".P800Base")
local cls = class("P800_3", P800Base)

function cls:ctor()
	cls.super.ctor(self, "yhbz_ios2", "bb7f849b123d465835cf3c4566c777ce", "9100771517621921")
end

return cls