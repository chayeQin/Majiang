--
-- Author: lyt
-- Date: 2015-09-23 23:21:29
-- 加载基本模块
--

local function init()
	-- 工具模块初始化
	require "app.utils.init"
	-- 基础模块初始化
	require "app.base.init"
	-- 扩展初始化
	require "app.extend.init"
	-- 平台相关接口
	require "app.api.init"
	-- 游戏数据结构初始化
	require "app.models.init"
	-- 控制器
	require "app.controller.init"
	require "app.views.control.init"
	require "app.views.login.init"
	-- 各个模块初始化
	require "app.views.scenes.init"

	if DEBUG == 0 then
		dump = function()end
		print = dump
	end
end

local status, msg = xpcall(init, __G__TRACKBACK__)
print("加载基本模块", status)
if status then
	return true -- 正常
end

return false