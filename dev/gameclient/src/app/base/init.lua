--
--@brief 游戏基础配置初始化
--@author qyp
--@date 2015/8/12
--

-- 游戏配置
import(".config")
-- 全局函数模块
import(".Func")
-- 界面标记
import(".Tags")

cc.exports.NotifyHandler = import(".NotifyHandler")  -- 推送消息处理
cc.exports.Updater       = import(".Updater")  -- 更新模块
cc.exports.UpdaterLoad   = import(".UpdaterLoad")
cc.exports.Http          = import(".Http").new()  -- http 模块
cc.exports.Net           = import(".Net").new()  -- socket 网络模块
cc.exports.Crypto        = import(".Crypto")  -- 加密模块
cc.exports.Component     = import(".Component")  -- 组件基类
cc.exports.Sound         = import(".Sound").new()  -- 声音模块
cc.exports.WebLogin      = import(".WebLogin")  -- web 登陆
cc.exports.Sqlite        = import(".Sqlite")
cc.exports.SqliteData    = import(".SqliteData")
cc.exports.LuaMem        = import(".LuaMem").new()
cc.exports.RandomSeed    = import(".RandomSeed")
cc.exports.Random        = import(".Random") -- 伪随机数
cc.exports.URLConfig     = import(".URLConfig").new() -- 所有URL地址保存
cc.exports.Area          = import(".Area")