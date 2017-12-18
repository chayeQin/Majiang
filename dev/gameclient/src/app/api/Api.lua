--
-- Author: lyt
-- Date: 2014-03-26 10:27:56
--
local Api = class("Api")

function Api:ctor()
end

-- 初始支付
function Api:initPay()
    if SDK.init then
        SDK.init()
    end
end

-- 支付
function Api:pay(id,rmb)
    -- SDK:pay(id,rmb)
    --测试充值
    require("app.api.pay.Empty").new():pay(id,rmb)
end

-- 更新C++
function Api:upload()
end

-- 评论
function Api:like()
    print("***** like")
end

-- 分享
function Api:share()
    print("***** share")
end

-- 震动
function Api:shake()
    return util:load("shake") ~= false
end

-- 定时消息推送
function Api:notis(msg, time)
    print("**** notis ", msg , time)
    return true
end

function Api:removeNotis()
end


-- 播放视频
function Api:play(url,rhand)
    if rhand then
        rhand()
    end
    return "res/video/" .. url .. ".mp4"
end

-- 客户端版本
function Api:ver()
    return 1
end

-- 上传数据
function Api:post(params)
    if SDK.postUser then
        SDK.postUser(params)
    end
end

-- 调用通用接口
function Api:call(className,method,param,rhand)
    print("*** ", className, ":", method)
    if rhand then rhand(v) end
end

-- "...............network status..........."
-- cc.kCCNetworkStatusNotReachable 0
-- cc.kCCNetworkStatusReachableViaWiFi 1
-- cc.kCCNetworkStatusReachableViaWWAN 2
function Api:isWifi()
    print("...net work status...", cc.Network:getInternetConnectionStatus())
    return cc.Network:getInternetConnectionStatus() == cc.kCCNetworkStatusReachableViaWiFi
end

-- 打开url
function Api:openUrl(url)
    cc.Application:getInstance():openURL(url)
    print("api openUrl = ",url)
end

function Api:exit()
end

return Api
