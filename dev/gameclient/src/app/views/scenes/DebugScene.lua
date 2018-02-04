--
--@breif 选择测试环境
--@author qyp
--@date 2015/8/12
--
local cls = class("DebugScene", cc.load("mvc").ViewBase)

local GAMES = {
    {
        name = "麻将",
        key = "majiang",
    },
}

local DEBUG_SERVER = "debug_server"

local function load(key)
    local str = cc.UserDefault:getInstance():getStringForKey(key)
    if str == nil or str == "" then return end
    return json.decode(str)
end

local function save(key,value)
    if key == nil then return end
    local str = json.encode(value)
    cc.UserDefault:getInstance():setStringForKey(key, str)
end

local function button(v, func, label, labelSize, color3b)
    local btn = ccui.Button:create(v)
    if label then
        labelSize = labelSize or 30
        color3b = color3b or display.COLOR_WHITE
        btn:setTitleText(label)
        btn:setTitleFontSize(labelSize)
        btn:setTitleColor(color3b)
    end

    btn:addClickEventListener(function(target)
        if func then
            func(target)
        end
        --  TODO : play button click sound
    end)


    return btn
end

function cls:onCreate()
    self.testURL = TEST_SERVER
	local debugServer = load(DEBUG_SERVER)
	local text = "点击切换:内网"
	if debugServer and debugServer ~= 1 then
		text = "点击切换:外网"
		TEST_SERVER = false
	end
    self.testServer = button(nil, handler(self, self.chooseTestSeverHander), text, 50, display.COLOR_WHITE)
                            :addTo(self)
                            :setPosition(180, display.height-50)

    button(nil, handler(self, self.testCode), "测试数据", 50, display.COLOR_WHITE)
        :addTo(self)
        :setPosition(180, display.height - 120)    
                            
    for k, v in ipairs(GAMES) do
        local name = string.format("%s(%s)",v.name,v.key)
        local color = cc.c3b(math.random(100,255),math.random(100,255),math.random(100,255))
        local text = name
        local size=50
        local labelBtn = button(nil, handler(self, self.chooseGameHandler), text, size, color)
                            :addTo(self)
                            :setPosition(display.width/2, display.height - 100 - (k-1)*50)
        labelBtn:setTag(k)
    end
end

function cls:onEnter()
    local function tick()
        GAME_NAME = "xjmh"
        self:next()
    end
end

function cls:chooseTestSeverHander()
    if TEST_SERVER then
        TEST_SERVER = false
        self.testServer:setTitleText("点击切换:外网")
        save(DEBUG_SERVER, 2)
    else
        TEST_SERVER = self.testURL
        self.testServer:setTitleText("点击切换:内网")
        save(DEBUG_SERVER, 1)
    end
end

function cls:testCode()
    local path = device.writablePath .. "src/"
    local len = #path + 1
    local dirs = {path .. "app/yhbz"}
    local list = {}
    while #dirs > 0 do
        local dir = dirs[1]
        table.remove(dirs,1)
        for file in lfs.dir(dir) do
            if file ~= "." and file ~= ".." then
                path = dir .. device.directorySeparator .. file
                local attr = lfs.attributes(path)
                if attr.mode == "file" and not string.find(path, "ServerConfig") then
                    local lua = string.sub(path, len, #path - 4)
                    lua = string.gsub(lua, "[/\\]", "%.")
                    package.preload[lua] = nil
                    package.loaded[lua] = nil
                    local result,errorInfo = pcall(require,lua)
                    if not result then
                        local key = "string \"%.\\"
                        local i = string.find(errorInfo, key)
                        local msg = string.sub(errorInfo, i + #key - 1)
                        key = "\"%]:"
                        i = string.find(msg, key)
                        msg = string.sub(msg, i + #key - 1)
                        key = ":"
                        i = string.find(msg, key)
                        local line = string.sub(msg, 1, i - 1)
                        local num = checknumber(line) + 2 -- EXCEL的第6行开始是数据

                        local file = io.open(path, "r")
                        if file then
                            local content = file:read("*l") or "" 
                            io.close(file)
                            if string.sub(content, 1, 3) == "-- " then
                                content = string.sub(content, 4)
                            end
                            line = content .. " 第" .. num .. "行"
                        else
                            line = lua .. " 第" .. num .. "行"
                        end
                        line = line .. path

                        table.insert(list, line)
                    end
                else
                    table.insert(dirs,path)
                end
            end
        end
    end

    if #list == 0 then
        print("*** 数据没问题!!")
        return
    end

    print("*** 加载失败文件列表:")
    for k,v in ipairs(list) do
        print(v)
    end
end

function cls:chooseGameHandler(target)
    local tag = target:getTag()
    self.game = GAMES[tag]
    GAME_NAME = self.game.key

    local res = "res/" .. GAME_NAME .. "/share"
    cc.FileUtils:getInstance():addSearchPath(res)
    local res = "res/" .. GAME_NAME
    cc.FileUtils:getInstance():addSearchPath(res)
    self.app_:enterScene("scenes.LogoScene")
end

function cls:next()
    self.app_:enterScene("scenes.LogoScene")
end

return cls