--
-- @brief 组件基类
-- @author qyp
-- @date 2015/09/07
--

local cls = class("Component")

function cls:init_()
end

function cls:bind(target)
    local methods = rawget(self.class, "EXPORTED_METHODS")
    self:init_()
    cc.setmethods(target, self, methods)
    self.target_ = target
end

function cls:unbind(target)
    local methods = rawget(self.class, "EXPORTED_METHODS")
    cc.unsetmethods(target, methods)
    self:init_()
end

return cls