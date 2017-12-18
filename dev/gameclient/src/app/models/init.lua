--
--@brief 数据模块，和服务器的数据结构相对应
--@author qyp
--@date 2015/8/12
--

-- 初始化静态数据
cc.exports.Const = import(".Const")
import(".InitData")
-- 语言包
cc.exports.Lang  = import(".Lang").new()
Lang:init()
cc.exports.Event = import(".Event")
-- 服务器配置
require ("app.".. GAME_NAME .. ".ServerConfig")

cc.exports.User = import(".User").new()