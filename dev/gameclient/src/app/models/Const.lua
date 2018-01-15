--
--@brief 游戏常量
--@author qyp
--@date 2016/2/3
--
local cls = {}

-- 使用的游戏地址
cls.CHECK_GAME_URL_KEY = "last_check_game_url_key"
-- 上次使用的CDN地址
cls.LAST_SAVE_KEY = "last_upload_cdn"
-- 上次使用的IP
cls.SAVE_IP_KEY = "last_login_ip"
-- 自动翻译
cls.SAVE_AUTO_LANG = "save_auto_lang"

-- 灰色颜色
cls.COLOR_GRAY = cc.c3b(0xa5,0x2a,0x2a)

-- 绿色颜色
cls.COLOR_GREEN = cc.c3b(0x4c,0xa6,0x40)

-- 遮罩颜色
cls.LayerColor = cc.c4b(0,0,0,0.8)

return cls