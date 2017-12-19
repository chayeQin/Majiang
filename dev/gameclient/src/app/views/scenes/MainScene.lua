--
--@brief: 主场景
--@author: qyp
--@date: 2016/02/20
--

-- 因为多点触摸的问题， 要放弃界面缓存， 其他界面会的触摸事件会屏蔽多点触摸
local cls = class("MainScene", BaseScene)

local HEART_BEAT_KEY = "HEART_BEAT"

function cls:ctor(...)
	cls.super.ctor(self, ...)
	self:enableNodeEvents()
end

function cls:onEnter()
	cls.super.onEnter(self)
    Sound:unloadSound()

    CacheTextureUtil:reset()
    
    -- 新用户先播放动画
    local showAnimation = false
    if GAME_CFG.area ~= Area.arabic and
        User:getIsNewUser() and
        not TEST_SKIP_ANIMATION then
        User:resetNewUser()
        require("app.views.game.OpeningAnimation").new(function ()
            Sound:music("sound/bg/1", SOUND_PZ)
            Tutorial:checkTutorial()
        end)
        showAnimation = true
    else
        Sound:music("sound/bg/1", SOUND_PZ)
    end
    Util:event(Event.unionUpdate)

    -- self.labMem = Util:labelOutLine(""):addTo(self,9999999)
    --     :align(display.LEFT_CENTER,50,12)
    -- self.labMem:schedule(function()
    --     LuaMem:check()
    --     local text = string.format("LUA:%.02f(%.02f)MB 纹理:%.02f(%.02f)MB",
    --         LuaMem.value,
    --         LuaMem.max,
    --         LuaMem.textureValue,
    --         LuaMem.textureMax)
    --     self.labMem:setString(text)
    -- end,1)
    
    local langDb = db.DLanguage_map[Lang:getLang()]
    local langId = 1
    if langDb then
        langId = langDb.id
    end
    CommanderProxy:setLanguage(langId)


    if User.info.destroyed then --玩家城堡被击飞了
        Msg.createMsg(Lang:find("bl_jfts"), function()
            Net:call(function(v, msg)
                if v.error ~= 0 then
                    return
                end
                User:update(v.result)
                CityCtrl:enterWorld()
            end, "User", "reBuild", User.info.uid)
        end)
    end
    
    -- 广播
    BroadCast.new()

    CrossServerModel:selectServer(PlatformInfo:getServerId())
end

function cls:onExit()
    cls.super.onExit(self)
end

function cls:switch(event)
    local name = event.params[1]
    local currName = self:getCurrViewName()
    if currName == "" and name ~= "" then -- 从主界面切换到其他界面
        CityCtrl:recordScale()
    end

	cls.super.switch(self, event)
    if name == "" then
    	CityCtrl:showCityUI()
        CityCtrl:showBubbleLayer()
        CityCtrl:restoreCityScale()
    else
        CityCtrl:hideBubbleLayer()
    	CityCtrl:hideCityUI()
    end
end

return cls
