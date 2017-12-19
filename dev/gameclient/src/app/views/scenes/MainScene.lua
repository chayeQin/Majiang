--
--@brief: 主场景
--@author: qyp
--@date: 2016/02/20
--

local cls = class("MainScene", BaseScene)

local HEART_BEAT_KEY = "HEART_BEAT"

function cls:ctor(...)
	cls.super.ctor(self, ...)
	self:enableNodeEvents()
end

function cls:onEnter()
	cls.super.onEnter(self)
    -- self.labMem = Util:labelOutLine(""):addTo(self,9999999)
    --     :align(display.LEFT_CENTER,50,12)
    -- self.labMem:schedule(function()
    --     LuaMem:check()
    --     local text = string.format("LUA:%.02f(%.02f)MB 纹理:%.02f(%.02f)MB",
    --         LuaMem.value,
    --         LuaMem.max,
    --         LuaMem.textureValue,
    --         LuaMem.textureMax)
    --     self.labMem:setString(text)
    -- end,1)
    
 
end

function cls:onExit()
    cls.super.onExit(self)
end

return cls
