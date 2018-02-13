--
--@brief 平台相关接口
--@author qyp
--@date 2015/8/13
--
cc.exports.Api          = import("."..API)-- 平台接口
cc.exports.PlatformInfo = PlatformInfo or import(".PlatformInfo").new()-- 平台信息
cc.exports.SDK          = SDK or import(".SDK").new()-- SDK接口
cc.exports.FBInvite     = import(".FBInvite").new()-- Facebook 邀请

import(".GameProductConfig")-- 游戏商品