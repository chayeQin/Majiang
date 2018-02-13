-- --
-- --@brief PC 配置文件
-- --@author qyp
-- --@date 2015/8/13
-- --

-- -- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- -- dump memory info every 10 seconds
DEBUG_MEM = false

-- -- disable create unexpected global variable
CC_DISABLE_GLOBAL = true

-- -- show FPS on screen
-- CC_SHOW_FPS = true

-- -- 测试logo路径
-- LOGO = "res/yhbz/share/logo/login_logo_01.png"

NOT_USE_DEPRECATE = true

-- -- 使用源码
TEST_DEV = true

-- 测试WEB地址
-- TEST_SERVER = "192.168.1.72"

-- TEST_GAME_SERVER  = "192.168.1.72"

-- -- 测试更新
TEST_UPDATE = false 

GAME_NAME = "majiang"
PLAT_NAME = "game" -- 测试平台名字
-- --显示战斗信息
-- -- TEST_REPORT = true

-- --显示剧情引导,-1不显示引导
-- TEST_TUTORIAL = 1

--显示功能开放引导，-1不显示，>0测试关卡引导
-- -- TEST_FUNC = 46

-- 功能全开
TEST_UNLOCK = true

TEST_NO_LOGIN = false

-- 世界地图分块测试
SHOW_BLOCK = false

TEST_WORLD_BLOCK_SIZE = true

TEST_KINGDOM_AREA = false

-- 测试开关审核模式
-- IN_REVIEW = true

TEST_ALGO = false

-- 测试语言包(单纯语言包表)
-- TEST_LANG = true

GAME_CFG = {}
GAME_CFG.login_sdk = true -- 使用SDK登陆|||||||
GAME_CFG.area = "youda" 
GAME_CFG.game_logo_bg = "bg/big_img_loginbg.png"
-- 新手动画是否播放
-- TEST_SKIP_ANIMATION = 0

-- 测试自定义头像
TEST_ICON_URL = "http://www.jf258.com/uploads/2013-07-28/144106867.jpg"

TEST_GM_TASK_ID = 51405

TEST_LANG_TRANS = "en" -- 测试翻译成该语言

TEST_STRONG_TUTORIAL = -1

TEST_CLIENT_PROXY = false


