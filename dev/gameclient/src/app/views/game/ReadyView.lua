--
--@brief: 准备界面
--@author: qyp
--@date: 2017/12/24
--

local cls = class("ReadyView", cc.load("mvc").ViewBase)

function cls:ctor()
end

function cls:updateUI( ... )

end


function cls:onEnter()
	-- 监听玩家进入房间事件, 玩家准备状态改变
end

function cls:onExit()
end

return cls
