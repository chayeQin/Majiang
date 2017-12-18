--
--@brief http模块
--@author qyp
--@date 2015/8/19
--

local cls = class("Http")

function cls.createHttpRequest(callback, url, method)
    method = method or "GET"
    if string.upper(tostring(method)) == "GET" then
        method = cc.kCCHTTPRequestMethodGET
    else
        method = cc.kCCHTTPRequestMethodPOST
    end
    return cc.HTTPRequest:createWithUrl(callback, url, method)
end

-- url,rhand,errTips,fhand,uhand,loading,postData, method, timeout
function cls.open(obj)
    cls.load(obj.url, obj.rhand, obj.errTips, obj.fhand, obj.uhand, obj.loading, obj.postData, obj.method, obj.timeout)
end

function cls.load(url,rhand,errTips,fhand,uhand,loading,postData, method, timeout)
    loading = loading ~= false

    if string.sub(url, 1, 7) ~= "http://" or
        string.find(url, "%%") or
        string.find(url, "{") then
        print("**** 输入URL地址有误", url)
        return
    end

    if errTips == nil then
        errTips = Lang:find("sys_load_fail")
    end

    if loading then
        Loading.show()
        print(">>>loading count", Loading.count())
    end

    local function loadRhand(e)
        if "progress" == e.name or "inprogress" == e.name then
            if uhand then
                local load = e.dltotal -- 当前进度
                local total = e.total
                uhand(load,total)
            end
            return
        end

        if loading then
            Loading.hide()
        end
      
        if "completed" ~= e.name then
          
            if errTips == false then
                if fhand then fhand() end
            else
                if not errTips then
                    errTips = e.request:getErrorCode() .. "," .. e.request:getErrorMessage()
                end
                Msg.createSysMsg(errTips, fhand or function()end)
            end
            print("*** http error " .. e.request:getErrorCode(),e.request:getErrorMessage())
            return
        end

        local str = e.request:getResponseString()
        if rhand then
            rhand(str,e.request)
        end
    end

    method = method or "GET"
    if postData then
        method = "POST"
    end

    local req = cls.createHttpRequest(loadRhand,url,method)
    if postData then
        for k,v in pairs(postData) do
            req:addPOSTValue(k,v)
        end
    end
    timeout = timeout or 1200
    req:setTimeout(timeout)
    req:start()
    return req
end

return cls
