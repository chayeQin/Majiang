--
-- @brief 各种计算工具
-- @author: qyp
-- @date: 2016/03/12
--

local cls = class("AlgoUtil")

local file = io.open("commanderDetail.txt", "w+")

local function writeDetail(...)
	print(...)
	file:write(...)
	file:write("\n")
end

function cls:sortCards()
end

return cls
