--
-- @brief 应用主控制
-- @author: qyp
-- @date: 2016/04/18
--


-- 游戏基础配置
require("app.config")
-- 文件操作库
require("lfs")
-- sql
require("lsqlite3")
-- socket 初始化
require("socket.core")
-- cocos 引擎初始化
require("cocos.init")

-- cjson
cc.exports.json = require("cjson").new()

local CheckLuaName = require("app.utils.CheckLuaName")

local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:ctor(...)
	local defaultScene = nil
	if TEST_DEV then
		defaultScene = "scenes.DebugScene"
	else
		defaultScene = "scenes.LogoScene"
	end
	if TEST_SCENE then
		defaultScene = "scenes."..TEST_SCENE
	end
	self.super.ctor(self, {defaultSceneName = defaultScene})
    cc.exports.app = self
end

function MyApp:onCreate()
    math.randomseed(os.time())
end

function MyApp:enterScene(sceneName, args, transition, time, more)
	cc.exports.appView = MyApp.super.enterScene(self, sceneName, args, transition, time, more)
end

function MyApp:startGame()
	if self:initModule() then
	    require("app.MyApp"):create():enterScene("scenes.StartScene")
	else
		if LOAD_FAIL_COUNT >= 1 then
			self:enterScene("scenes.RepairScene")
			return
		end
		LOAD_FAIL_COUNT = LOAD_FAIL_COUNT + 1
		clearUpload()
		self:clearModule()
		self:restart()
	end
end

--@brief 重新启动游戏
function MyApp:restart()
	Net:close()
	self:startGame()
end

function MyApp:initModule()
	-- 游戏基础模块初始化
	return require "app.init"
end

--@brief 清除数据
function MyApp:clearModule()
    setmetatable(_G, {
        __newindex =  function(_, name, value)
        rawset(_G, name, value)
    end
    })
	if Controller then
		Controller.disposeAllModules()
	end
	if GlobalTimer then
		GlobalTimer:clear()
	end
	if NotisUtil then
		NotisUtil:clear()
	end
	if CacheTextureUtil then
		CacheTextureUtil:clear()
	end
	if CheckLuaName then
		CheckLuaName.reset()
	end
	if HeartBeatUtil then
		HeartBeatUtil:stop()
	end
	
	local reloadPacks = {
	    "app.",
	    "cocos.",
	    "packages.",
	}
	local excludeFiles = {
	    "app.api.PlatformInfo",
	    "app.api.SDK",
	}

	local function isExclude(file)
	    for _, v in ipairs(excludeFiles) do
	        if file == v then
	            return true
	        end
	    end
	    return false
	end

	for _, packName in ipairs(reloadPacks) do
	    local len = string.len(packName)
	    for k,__ in pairs(package.preload) do
	        if string.sub(k, 1, len) == packName and
	            not isExclude(k) then
	            package.preload[k] = nil
	        end
	    end
	    for k,__ in pairs(package.loaded) do
	        if string.sub(k, 1, len) == packName and
	        not isExclude(k) then
	            package.loaded[k] = nil
	        end
	    end
	end

	local director = cc.Director:getInstance()
	local textureCache = director:getTextureCache()
	local spriteFrameCache = cc.SpriteFrameCache:getInstance()
	spriteFrameCache:removeSpriteFrames()
	textureCache:removeAllTextures()
	cc.FileUtils:getInstance():purgeCachedEntries()
end

return MyApp
