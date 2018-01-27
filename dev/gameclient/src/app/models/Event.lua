--
-- @brief 游戏事件
-- @author: qyp
-- @date: 2016/02/18
--

local keys = {
	--------------基础模块事件------------------
	netError = "netError",
	netConnectSuccess = "netConnectSuccess",
	netConnectFail = "netConnectFail",
	gameSwitch = "gameSwitch", 						-- 界面切换
	loadServerFinish = "loadServerFinish",     		-- 加载服务器列表成功
	gameUpdateProgress = "gameUpdateProgress", 				-- 游戏更新进度
	loadUserInfo = "loadUserInfo",					-- 加载用户数据进度

	--------------基础模块事件------------------
	roomInfoUpdate = "roomInfoUpdate",				-- 房间信息更新
	gameInfoUpdate = "gameInfoUpdate",				-- 局内信息更新
	

}

return keys
