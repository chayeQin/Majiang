--
-- @brief 界面层级控制
-- @author qyp
-- @date 2015/11/21
--


local names = {
	"Chat", -- 聊天按钮
	"Popup", -- 弹窗
	"FloatItem", -- 漂浮特效
	"Tutorial", -- 引导
	"Reconnect", -- 重新连接
	"Sys", -- 系统消息
	"Tips",-- 漂字提醒
	"FIGHT",-- 战斗力提升
	"Daily",--日常漂字
	"BroadCast",-- 广播
	"Loading",-- Loading界面
	"Opening",-- 开场动画
	"Exit", -- 退出
	"Logs",-- 屏幕日志输出
}

cc.exports.TAGS = {}

for i,key in ipairs(names) do
	TAGS[key] = 1000 + i
end
