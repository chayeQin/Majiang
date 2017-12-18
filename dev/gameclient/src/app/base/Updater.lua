 --
--@brief 游戏更新模块
--@author qyp
--@date 2015/8/13
--

local cls = class("Updater")

-- 同时最多下载进程
local THREAD = 5

local TEMP_PATH = device.writablePath .. "upload/upload.tmp" -- 临时目录，记录下载进度
local NEW_PATH  = device.writablePath .. "upload/upload.new" -- 最新文件列表
local TEST_CDN  = "cdn" -- 测试CDN 使用的文件

cls.STATE_NONE         = 0 
cls.STATE_CHECK_UPDATE = 1 -- 检测更新
cls.STATE_UPDATING     = 2 -- 更新中
cls.STATE_UPDATE_FINISH= 3 -- 更新完毕


--@brief 检测更新
--@param[rhand] 检测完毕回调
--@param[stateCallback] 状态回调 stateCallback(state, data)
function cls:checkUpdate(stateCallback)
    self.sumsize         = 0
    self.sizeName        = "KB"
    self.loadList        = {}      -- 正在下载http
    self.isErrorUpdate   = false
    self.state           = cls.STATE_NONE
    self.stateCallback   = stateCallback

    self.loadSize        = 0         -- 当前加载大小
    self.loadTime        = os.time() -- 当前加载时间

    self.cdnIndex = 1
    self.cdnList  = PlatformInfo:getCdnList()

    self.state = cls.STATE_CHECK_UPDATE
    self.stateCallback(self.state)
    if TEST_UPDATE or 
        GAME_CFG.in_review_update or
        (not TEST_DEV and not PlatformInfo:isInReview()) then
    else
        self:finish()
        return
    end

    -- 读取上次CDN地址
    if TEST_SELECT_SERVER_CDN then
        self.cdnList = {TEST_SELECT_SERVER_CDN}
        Msg.new("使用测试CDN：\n" .. TEST_SELECT_SERVER_CDN)
        self:begin()
        return
    else
        local old = Util:load(Const.LAST_SAVE_KEY)

        for k,v in ipairs(self.cdnList) do
            if v == old then
                self.cdnIndex = k
                self:begin()
                return
            end
        end
    end

    -- 没有使用过CDN,进行CDN测试
    print("*** 测试CDN")
    self:testCdn()
end

function cls:testCdn()
    self.testCdnIndex = #self.cdnList
    local func = handler(self, self.testCdnRhand)
    for k,base in ipairs(self.cdnList) do
        local verUrl  = base .. TEST_CDN
        local http = TestHttp.new(verUrl, func)
        http.index = k
    end
end

function cls:testCdnRhand(http)
    print("**** 测试CDN结果:", http.index, http.time)
    if self.testCdnIndex < 1 then
        return
    end

    self.testCdnIndex = self.testCdnIndex - 1

    if http.req then
        local save_file = device.writablePath .. "upload/" .. TEST_CDN .. ".tmp"
        if Util:exists(save_file) then
            os.remove(save_file)
        end
        http.req:saveResponseData(save_file)

        local old = Crypto.md5file(cc.FileUtils:getInstance():fullPathForFilename(TEST_CDN))
        local new = Crypto.md5file(save_file)

        if old == new then
            self.testCdnIndex = 0 -- 一个返回就结束测试
        else
            print("*** cdn 无效,")
            print("*** 本地:", old)
            print("*** 网上:", new)
        end
    end

    if self.testCdnIndex > 0 then
        return
    end

    -- 如果所有测试都无郊,用第一个
    local index = http.index
    if not http.req then
        index = 1
        print("*** 所有CDN都不合法,使用第一个CDN")
    end

    local cdn = self.cdnList[index]
    Util:save(Const.LAST_SAVE_KEY, cdn)
    print("*** 使用CDN :", cdn)
    self:begin()
end

-- 更新进度
function cls:updatePercent(percent, loadSize)
    local time  = math.max(1, os.time() - self.loadTime)
    local speed = loadSize / time
    self.stateCallback(self.state, {
            percent,
            self.sumsize,
            self.sizeName,
            speed
        })
end

--@brief 向CDN获取当前版本
function cls:begin()
    self.loadPathIndex = self.cdnIndex
    self:getVer()
end

-- 下载配置文件
function cls:getVer()
    local verUrl  = self.cdnList[self.cdnIndex] .. UPDATA_VER
    Http.load(verUrl,
        handler(self,self.verHandler),
        false,
        handler(self,self.getVerFhand),
        nil, nil, nil, nil, 5000)
end

-- 一直重试
function cls:getVerFhand()
    self.cdnIndex = self.cdnIndex + 1
    if self.cdnIndex > #self.cdnList then
        self.cdnIndex = 1
    end

    if self.loadPathIndex == self.cdnIndex then
        Msg.createSysMsg(Lang:find("sys_server_code_error"), handler(app,app.restart))
        return
    end

    -- 更换CDN
    local cdn = self.cdnList[self.cdnIndex]
    Util:save(Const.LAST_SAVE_KEY, cdn)
    self:getVer()
end

--@brief CDN与本地版本对比
function cls:verHandler(str)
    local cdnVer = json.decode(str)
    if not cdnVer then
        self:getVerFhand()
        return
    end
    PostEvent:updateVer()

    self.cdnVerStr = str
    -- 获取本地版本信息
    local oldVer = cc.FileUtils:getInstance():getStringFromFile(UPDATA_VER)
    if oldVer == "" then 
        print("获取本地版本信息失败")
        oldVer = {
            code ="-1",
            ver  ="0.0.0"
        }
    else
        oldVer = json.decode(oldVer)
    end
    app.ver = oldVer.ver
    local codeVer1 = checknumber(oldVer.code) -- 本地代码版本
    local codeVer2 = checknumber(cdnVer.code) -- cdn 代码版本
    if codeVer1 == codeVer2 then
        self:finish()
        return
    end
    self.ver = codeVer2
    self.verNum = cdnVer.ver -- 游戏版本号
    self.cdnVer = cdnVer
    -- 更新开始
    self:updatePercent(0, 0)-- 显示正在更新
    local tmp = cc.FileUtils:getInstance():fullPathForFilename(UPDATA_VER)
    -- 判断上次是否有未更新完成
    while true do
        if not Util:exists(TEMP_PATH) then break end
        local downRecord = cc.FileUtils:getInstance():getStringFromFile(TEMP_PATH)
        if not downRecord then break end
        downRecord = json.decode(downRecord)
        if not downRecord then break end
        if downRecord.ver ~= codeVer2 then break end
        -- 下载中的还原成未下载
        for k,m in pairs(downRecord.loadMap) do
            downRecord.sumMap[k] = m
        end
        downRecord.loadMap = {}
        self.up = downRecord
        self:start()
        return
    end

    self.loadPathIndex = self.cdnIndex
    self:loadPath()
end

-- 下载最新列表
function cls:loadPath()
    local listUrl = self.cdnList[self.cdnIndex] .. UPDATA_LIST
    print("...listUrl", listUrl)
    Http.load(listUrl,
        handler(self,self.listRhand),
        false,
        handler(self,self.loadPath),
        nil, nil, nil, nil, 10000)
end

function cls:listFhand()
    self.cdnIndex = self.cdnIndex + 1
    if self.cdnIndex > #self.cdnList then
        self.cdnIndex = 1
    end

    -- 转一圈
    if self.loadPathIndex == self.cdnIndex then
        Msg.createSysMsg(Lang:find("sys_list_error"), handler(app,app.restart))
        return
    end

    self:loadPath()
end

function cls:listRhand(str,req)
    req:saveResponseData(NEW_PATH)
    local lst, ret = readZip(UPDATA_LIST)
    local list1, list2
    if ret then
        list1 = json.decode(lst)
    else
        print("*** 本地upload.list 不存在")
        list1 = {} 
    end

    local lst, ret = readZip(NEW_PATH)
    if ret then
        list2 = json.decode(lst)
    else
        Msg.createSysMsg(Lang:find("sys_down_error"),handler(self,self.loadPath)) -- 读取新文件列表出错
        print("*** upload.new 不存在")
        return
    end

    PostEvent:updateList()

    local map = {}
    local sumSize = 0
    local sumCount = 0
    for k,v in pairs(list2) do
        local fileName = UpdaterLoad.getUrlName(k)
        if not list1[k] or -- 新文件
            not Util:exists(fileName) or --  文件不存在
            list1[k].md5 ~= v.md5 then
            if v.size ~= nil then
                sumSize = sumSize + v.size
            end
            map[k] = v.md5
            sumCount = sumCount + 1
        end
    end
    print("*** new version : ", self.ver)
    self.up = {
        ver       = self.ver,
        downList  = {},                  -- 已经下载列表KEY
        sumMap    = map,                 -- 需要下载
        loadMap   = {},                  -- 下载中列表
        downCount = 0,                   -- 已经下载数量
        sumCount  = sumCount,            -- 总共需要下载文件数
        size      = math.floor(sumSize), -- 总大小
    }

    if self:checkComplete() then
        self:downloadFinish()
        return
    end

    io.writefile(TEMP_PATH, json.encode(self.up))
    self:start()
end

-- 是否加载完
function cls:checkComplete()
    if self.up.sumCount == 0 then
        return true
    end

    if #self.loadList > 0 then
        return false
    end

    for k,v in pairs(self.up.loadMap) do
        return false
    end

    if self.up.downCount < self.up.sumCount then
        return false
    end
    
    return true
end

function cls:start()
    self.state = cls.STATE_UPDATING
    if self.up.sumCount < 1 then
        self:download()
        return
    end

    SDKEvent:updateStart()
    PostEvent:updateStart()
    
    self.addPercent = 100 / self.up.sumCount
    self.percent = self.up.downCount * self.addPercent
    self.sumsize = self.up.size / 1024
    if self.sumsize < 1024 then
        self.sizeName = "KB"
    else
        self.sizeName = "MB"
        self.sumsize = self.sumsize / 1024
    end

    -- 下载使用更新函数
    self.downloadRhand_ = handler(self, self.downloadRhand)
    self.downloadUhand_ = handler(self, self.downloadUhand)
    self.downloadFhand_ = handler(self, self.downloadFhand)

    local function startDownload()
        self.loadSize        = 0         -- 当前加载大小
        self.loadTime        = os.time() -- 当前加载时间

        for i = 1,THREAD do
            self:download()
        end
    end

    if true or Api:isWifi() then
        startDownload()
    else
        Msg.createSysMsg(string.format(Lang:find("sys_need_update") .."%.1f%s"..Lang:find("sys_down_sure"),self.sumsize,self.sizeName),
            function()
                startDownload()
            end,
            handler(self, self.clearUpdate))
    end
end

function cls:download()
    if self.isErrorUpdate then
        return
    end

    if self:checkComplete() then
        Util:tick(handler(self,self.downloadFinish),0)
        return
    end

    local key,md5 = nil,nil
    for k,v in pairs(self.up.sumMap) do
        key = k
        md5 = v
        break
    end

    if not key then
        return
    end

    self.up.sumMap[key]  = nil
    self.up.loadMap[key] = md5

    local load = UpdaterLoad.new(self.cdnIndex,
        self.cdnList,
        key,
        md5,
        self.downloadRhand_,
        self.downloadUhand_,
        self.downloadFhand_)
    table.insert(self.loadList,load)
end

--@brief 正在下载文件
function cls:downloadUhand(load)
    local percent  = self.percent
    local loadSize = self.loadSize
    for k,v in pairs(self.loadList) do
        percent = percent + v.percent * self.addPercent
    end
    self:updatePercent(percent, loadSize)
end

--@brief 下载文件失败
function cls:downloadFhand(load)
    self.isErrorUpdate = true
    Msg.createSysMsg(Lang:find("sys_down_file",load.fileName), handler(self, self.clearUpdate))
    PostEvent:updateErrorFile()
end

--@brief 下载文件成功
function cls:downloadRhand(load)
    if self.isErrorUpdate then
        return
    end
    self.percent  = self.percent + self.addPercent
    self.loadSize = self.loadSize + load.total
    self:updatePercent(self.percent, self.loadSize)

    self.up.downCount = self.up.downCount + 1
    table.insert(self.up.downList, load.key)
    self.up.loadMap[load.key] = nil

    for i = #self.loadList,1,-1 do
        if self.loadList[i] == load then
            table.remove(self.loadList, i)
        end
    end

    -- 保存文件进度
    io.writefile(TEMP_PATH,json.encode(self.up))
    self:download()
end

--@brief 下载完成
function cls:downloadFinish()
    if self.isErrorUpdate then
        return
    end
    -- 限制这方法只执行一次
    if self.downloadFinish_ then
        return
    end
    self.downloadFinish_ = true

    -- 生成唯一文件(防止重复更新)
    local map = {}
    for i,key in pairs(self.up.downList) do
        local path = UpdaterLoad.getFileName(key)
        path = device.writablePath .. path
        local temp = path .. ".tmp"
        map[temp] = path
    end

    -- 覆盖文件
    for temp,path in pairs(map) do
        -- 把新文件覆盖旧文件(尝试三次)
        for j = 1, 3 do
            Util:rename(temp, path)
            if Util:exists(path) then
                break
            end
        end

        if not Util:exists(path) then -- 不完全更新
            -- 更新出错, 清空更新目录，重新进入开始界面
            PostEvent:updateErrorCopy()
            Msg.createSysMsg(Lang:find("sys_update_error_copy",key), handler(self, self.clearUploadDir))
            return
        end
    end

    -- 保存信息
    Util:rename(NEW_PATH, device.writablePath .. "upload/" .. UPDATA_LIST)
    io.writefile(device.writablePath .. "upload/" .. UPDATA_VER, self.cdnVerStr)
    os.remove(TEMP_PATH)

    -- 上传数据更新完成
    SDKEvent:updateComplete()
    PostEvent:updateComplete()

    -- 重新启动
    app.ver = self.verNum
    app:clearModule()
    app:restart()
end

-- 清空更新目录
function cls:clearUploadDir()
    app:enterScene("scenes.RepairScene")
end

-- 取消这次更新
function cls:clearUpdate()
    os.remove(NEW_PATH)
    os.remove(TEMP_PATH)
    app:clearModule()
    app:restart()
end

function cls:finish()
    if self.isErrorUpdate then
        return
    end
    self.state = cls.STATE_UPDATE_FINISH
    self.stateCallback(cls.STATE_UPDATE_FINISH)
end

return cls