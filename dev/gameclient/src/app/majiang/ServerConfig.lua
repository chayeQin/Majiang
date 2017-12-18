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

}
