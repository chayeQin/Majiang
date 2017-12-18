--
--@brief 启动文件，配置搜索路径
--@author qyp
--@date 2015/8/2
--

LOAD_FAIL_COUNT = 0

-- 在func.lua里会重新定义
__G__TRACKBACK__ = function(msg)
    local msg = debug.traceback(msg, 3)
    print(msg)
    return msg
end

-- 文件搜索路径
function __initSearchPath()
    local writablePath = cc.FileUtils:getInstance():getWritablePath()

    -- 创建upload 目录
    local uploadPath = writablePath .. "upload"
    cc.FileUtils:getInstance():createDirectory(uploadPath)
    print(">>>>Upload path", uploadPath)
    local searchPathAry = {
        -- 更新目录
        uploadPath, -- 读取更新目录
        uploadPath .. "/bin", -- 读取更新目录
        uploadPath .. "/share",-- 读取更新资源目录
        --安装目录
        "extend",
        "res", 
        "res/share",
        "res/bin", 
        "src",
    }

    cc.FileUtils:getInstance():setSearchPaths(searchPathAry)
end

-- 清空下载目录
function clearUpload()
    local path = device.writablePath .. "upload"
    local dirs = {path}
    while #dirs > 0 do
        local dir = dirs[1]
        table.remove(dirs,1)
        for file in lfs.dir(dir) do
            if file ~= "." and file ~= ".." then
                path = dir .. device.directorySeparator .. file
                local attr = lfs.attributes(path)
                if attr.mode == "file" then
                    os.remove(path)
                else
                    table.insert(dirs,path)
                end
            end
        end
    end

    local cmd = nil
    if device.platform == "windows" then
        cmd = "rmdir /s /q " .. string.gsub(path, "/", "\\")
    else
        cmd = "rm -rf " .. path
    end
    -- os.execute(cmd)
    local o = io.popen(cmd)
    o:read("*all")
    o:close()
end


--应用启动只需要初始化文件搜索路径
local function main()
	__initSearchPath()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end