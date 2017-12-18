--
-- @brief 服务器地址配置
-- @author qyp
-- @date 2015/3/21
--
-- 多台WEB
cc.exports.SERVER_BASE_LIST = 1

local area = GAME_CFG.area

if area == Area.arabic then-- 中东服务器
	SERVER_BASE_LIST = {
	}

	return
end

-- 默认全球服
-- gs1-yhbz.awwgc.com -- 游戏服
SERVER_BASE_LIST = {
	"g1-new-yhbz.awwgc.com", -- 香港(WEB-真实服务器必须在第一个,查询IP用)
	"g2-new-yhbz.awwgc.com", -- 停用
	"g3-new-yhbz.awwgc.com", -- 广州(桥:WEB+游戏服)
	"g4-new-yhbz.awwgc.com", -- 美国加州(桥:WEB+游戏服)
	"g5-new-yhbz.awwgc.com", -- 欧洲(桥:WEB+游戏服)
	"g6-new-yhbz.awwgc.com",
	"g7-new-yhbz.awwgc.com",
	"g8-new-yhbz.awwgc.com",
	"g9-new-yhbz.awwgc.com",
	"g10-new-yhbz.awwgc.com",
	"yhbz-web.my-seiya.com", -- 香港(备用)
}
