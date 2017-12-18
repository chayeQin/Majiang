--
--@brief: 视图控制器基类
--@author: qyp
--@date: 2016/03/27
--

local cls = class("Controller")

local CTRL_LST = {} -- 游戏里所有的controller, 静态变量。 不使用全局变量

function cls:ctor()
	table.insert(CTRL_LST, self) -- 注册controler
end

function cls:clear()
	print("***子类重写此方法清空界面的lua引用,清空所有临时数据***", self.__cname)
end

function cls:init()
	print("***子类初始化界面的lua引用, 初始化临时数据结构***", self.__cname)
end


function cls.initialize()
	for _, v in ipairs(CTRL_LST) do
		v:init()
	end
end

--@brief 重登或切换场景的时候需要清除所有的界面
function cls.disposeAllModules()
	for _, v in ipairs(CTRL_LST) do
		v:clear()
	end
end

return cls
