--@brief 游戏框架配置
--@author qyp
--@date 2015/8/13
--

-- -- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- 重置了屏幕高度,比720多的值
RESET_DISPLAY_HEIGHT = 0

-- -- for module display
CC_DESIGN_RESOLUTION = {
    width = 1280,
    height = 720,
    -- autoscale = "EXACT_FIT", -- 拉伸
    autoscale = "EXACT_FIT",
    -- callback = function(framesize)
    --     local ratio = framesize.width / framesize.height
    --     if ratio <= 1.77 then
    --         local height = 1280 / ratio
    --         RESET_DISPLAY_HEIGHT = height - 720
    --         -- iPad 768*1024(1536*2048) is 4:3 screen
    --         return {autoscale = "SHOW_ALL",
    --                 width = 1280,
    --                 height = height}
    --     else
    --         return {autoscale = "SHOW_ALL",
    --                 width = 720 * ratio,
    --                 height = 720}
    --     end
    -- end
}


DESIGN_FPS = 30

cc.Director:getInstance():setAnimationInterval(1/DESIGN_FPS)

-- 加载语言本文件
local str = cc.FileUtils:getInstance():getStringFromFile("game.cfg")
print(str)
if str ~= "" then

    local json = require("cjson").new()
    local data = json.decode(str)
    if data then
        if data.no_cfg then
            require("TestCode")
            return
        end
        GAME_NAME = data.game_name
        DEBUG     = data.game_debug or 0
    end
    -- 游戏配置
    GAME_CFG = data
else
    require("TestCode")
end

--[[
game.cfg 参数说明
login_sdk = true            是否使用SDK默认不存在.使用游客登陆并使用绑定系统
game_name = "yhbz"          游戏名字(资源目录名字)
game_logo = ""              指定LOGO.png (需要res/xxx/yyy.png 完全路径)
game_init_logo = ""         指定初始化LOGO.png (需要res/xxx/yyy.png 完全路径)
game_debug = 2              测试输出 为0时.会覆盖dump,print方法无输出
area = "china"            区域
in_review_update            true 则审核中也启用更新
--]]