--
--@brief 加载静态表
--@author qyp
--@date 2015/8/14
--

cc.exports.ViewData = {} -- 界面数据
cc.exports.db = {}

local function loadData(name)
	-- 数据
	local dir         = "app/".. GAME_NAME .."/data/value/"
	local pkgName     = "app.".. GAME_NAME ..".data.value."
	if Util:exists(dir .. name .. ".lua") then
		return require(pkgName .. name)
	end

	return nil
end

local function loadLang(name)
	local dirLang     = "app/".. GAME_NAME .."/data/" .. Lang:getLang() .. "/"
	local pkgLangName = "app.".. GAME_NAME ..".data." .. Lang:getLang() .. "."
	if Util:exists(dirLang .. name .. ".lua") then
		return require(pkgLangName .. name)
	end

	return nil
end

local function load(name)
	local data     = loadData(name)
	local dataLang = loadLang(name)
	if data and dataLang then
		local v2 = nil
		for id,v1 in pairs(dataLang) do
			v2 = data[v1.id]
			if v2 then
				table.merge(v2,v1)
			end
		end
	end
	-- 兼容只在语言没有数据表
	return data or dataLang
end

-- 数据类型初始化
local function initType()
	local function init(typeName) --  初始化常量
		db[typeName] = load(typeName)
		if not db[typeName] then
			print("*** initdata not find : ", typeName)
			if TEST_DEV then
				return
			else
				db[typeName] = {}
			end
		end
		Const[typeName] = {}
		for _, v in pairs(db[typeName]) do
			Const[typeName][v.key] = v.id
		end
	end

end

cc.exports.initData = function()
	local function init(typeName)
		db[typeName] = load(typeName)
	end
	-- 初始化SOCKET 类型映射表
	-- initProtoMap(load("keys"))
	-- initTypeMap(load("map_string"))
	-- init("TGameText") 			-- y_游戏文本文字.xlsx
	-- init("TErrorCode")			-- Type_错误提示.xlsx

	-- 初始化类型常量
	initType()
end
