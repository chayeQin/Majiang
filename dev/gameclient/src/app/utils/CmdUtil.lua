--
-- Author: lyt
-- Date: 2017-05-12 16:55:05
--
local cls = class("CmdUtil")

function cls:ctor()
end

function cls:call(cmd)
    local o = io.popen(cmd)
    local str = o:read("*all")
    o:close()

    return str
end

return cls