--
--@brief 全局函数
--@author qyp
--@date 2015/8/19
--
----------------------------------- C++ 网络回调API
local g = {}
	-- 连接成功 
function g.connectRhand()
	Util:tick(handler(Net, Net.connectRhand))
end

-- 连接失败 
function g.connectFhand()
	Util:tick(handler(Net, Net.connectFhand))
end

-- 延迟一次执行，能让
local function revcTmp(v)
	Net:recv(v,msg)
end

-- 接受信息 
function g.recvMsg(v, size)
	if TEST_DEV or DEBUG ~= 0 then
		revcTmp(v)
	else
        pcall(revcTmp, v)
	end
	
	if size then
		Net.recvSize = Net.recvSize + size;
	end
end

function g.__singleton(cls)
    local init = false
    cls.ctor = function(that)
        if init then
            post_error("ERROR*** " .. that.__cname .. ":ctor Reinstantiate a singleton ***" )
            return
        end
        if that.init then
       		that:init()
    	end
        init = true
    end
end

function g.table2string(data, indent)
    if data == nil then
        return "nil,\n"
    end
    local t = type(data)
    if t == "string" then
        return "\"" .. data .. "\",\n"
    end
    if t ~= "table" then
        return tostring(data) .. ",\n"
    end

    local keyLen = 1
    for k,v in pairs(data) do
        local len = string.len(k)
        if type(k) == "string" then
            len = len + 2
        end
        keyLen = math.max(keyLen, len)
    end

    local key = nil
    local empty = nil

    local indent2 = indent .. "    "

    local str = "{\n"
    for k,v in pairs(data) do
        if type(k) == "number" then
            key = k
        else
            key = "\"" .. k .. "\""
        end
        empty = string.rep(" ", keyLen - string.len(key))
        str = str .. indent2 .. key .. empty .. " = "
        str = str .. table2string(v,indent2)
    end
    str = str .. indent .. "},\n"

    return str
end

-- 将内容输出成文件
function g.echo(...)
    local param = {...}
    dump(param)
    local result = ""
    for i,v in ipairs(param) do
        result = result .. table2string(param, "") .. "\n"
    end
    local mode = "w+"
    if g.echo__ then
        mode = "a+"
    end
    g.echo__ = true
    result = os.date() .. ":\n" .. result .. "\n"
    io.writefile("echo.txt", result, mode)
end

table.merge(cc.exports, g)

--冒泡排序算法
function table.bubble(arr,comp)
    for i=1,table.getn(arr) do
        for j=i+1,table.getn(arr) do
            if comp(arr[j],arr[i]) then
                arr[i],arr[j]=arr[j],arr[i]
            end
        end
    end
end

--算字符串长度
cc.exports.utf8str = function(str, start, num)
    local function utf8CharSize(char)
        if not char then
            return 0
        elseif char > 240 then
            return 4
        elseif char > 225 then
            return 3
        elseif char > 192 then
            return 2
        else
            return 1
        end
    end
    local startIdx = 1
    while start > 1 do
        local char = string.byte(str, startIdx)
        startIdx = startIdx + utf8CharSize(char)
        start = start - 1
    end
    local endIdx = startIdx
    while num > 0 do
        if endIdx > #str then
            endIdx = #str
            break
        end
        local char = string.byte(str, idx)
        endIdx = endIdx + utf8CharSize(char)
        num = num - 1
    end
    return str:sub(startIdx, endIdx - 1)
end

--检查字符串
cc.exports.checkNameValid = function(name,maxLimit)
    if name == "" then
        Tips.show(Lang:find("shuru"))
        return false
    end
    local nameLen = 0
    local len = string.len(name)
    local i = 1
    while i <= len do
        local c = string.byte(name,i)
        local shift = 1
        if c > 0 and c <= 127 then
            if c < 47  -- 0
                or c > 57 and c < 65 -- 0 ~ A
                or c > 90 and c < 97 -- Z ~ a
                or c > 122 then -- z
                Tips.show(Lang:find("TErrorCode.5"))
                return false
            end
            shift = 1
        elseif c < 192 then
            shift = 1
        elseif c < 224 then
            shift = 2
        elseif c < 240 then
            shift = 3
        else
            Tips.show(Lang:find("TErrorCode.3"))
            return false
        end 

        i = i + shift

        if shift == 1 then
            nameLen = nameLen + 1
        else
            nameLen = nameLen + 2
        end
    end

    local maxLen = Lang:getLang() == "cn" and 12 or 18
    if maxLimit then maxLen = maxLimit end
    if nameLen > maxLen then
        Tips.show(Lang:find("TErrorCode.6"))
        return false
    end

    return true
end

-- 让SDK调用重登游戏
cc.exports.relogin = function()
    PlatformInfo.isLogout = true
    PlatformInfo:setSdkParam(nil)
    app:clearModule()
    app:restart()
end

function string.splitInt(str, sp)
    local arr = string.split(str , sp)
    for k,v in ipairs(arr) do
        arr[k] = checknumber(v)
    end
    return arr
end

function table.numsall(value)
    local count = 0
    local function tonumsall(value)
        for k, v in pairs(value) do
            if type(v) == "table" then
                tonumsall(v)
            else
                count = count + 1
            end
        end
    end
    tonumsall(value)
    return count
end

function table.valueCount(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + v
    end
    return count
end

__G__TRACKBACK__ = function(v)
    local msg = debug.traceback(v, 3)
    if TEST_DEV or PlatformInfo:isWhiteUser() then
        -- local file = io.open("error.txt", "a+")
        -- file:write(Util:date() .."\t" .. msg .. "\n")
        -- file:write("最后收到的网络返回" .. Net.lastReceivedMsg .. "\n")
        -- file:close()
        -- dump(Net.lastReceivedMsg, "最后收到的网络返回")
      -- postError(msg) -- TODO 增加上传错误
    end

    if not TEST_DEV then
        postError(msg, v)
    end
    print(msg)
    -- 测试环境或者是白名单，就打印最后的网络返回信息
    return msg
end

cc.exports.postError = function(key, msg)
    local uid   = 0
    local level = 0

    if User and User.info then
        uid   = User.info.uid
        level = User.info.level
    end

    local postData = {
        ver       = PlatformInfo:getVer(),
        server_id = PlatformInfo:getServerId(),
        platform  = PlatformInfo:getPlatformName(),
        uid       = uid,
        level     = level,
        trans     = "",
        value     = msg,
        text      = key,
    }

    Http.load(URLConfig.FORMAT_ERROR,
            function(v) print(v) end, 
            false,
            function()end,
            nil,
            false,
            postData, 
            "POST")
end