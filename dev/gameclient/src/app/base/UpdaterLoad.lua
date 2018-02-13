--
-- Author: lyt
-- Date: 2016-05-25 15:07:26
-- 下载更新文件
local cls = class("UpdaterLoad")

local ERROR_AGIN = 2 -- 每个CDN 试两次

function cls:ctor(cdnIndex, cdnList, key, md5, rhand, uhand, fhand)
	self.cdnIndex      = cdnIndex
	self.cdnList       = cdnList
	self.key           = key
	self.md5           = md5
	self.rhand         = rhand
	self.uhand         = uhand
	self.fhand         = fhand
	self.percent       = 0
	
	self.fileName      = cls.getUrlName(key)
	
	self.loadAglin     = ERROR_AGIN
	self.cdnStartIndex = cdnIndex
	
	self.load          = 0
	self.total         = 0

	self:start()
end

function cls:start()
	local url = self.cdnList[self.cdnIndex] .. self.fileName
	Http.load(url, 
	    handler(self, self.downloadRhand), 
	    false, 
	    handler(self, self.downloadFhand), 
	    handler(self, self.downloadUhand), 
	    false, nil, "GET", 600)
end

function cls:downloadRhand(str, req)
	-- 创建保存目录
	local path1 = device.writablePath .. "upload" .. device.directorySeparator
	local path2 = self.fileName
	while true do
	    local i = string.find(path2,"[\\/]")
	    if not i then break end
	    path1 = path1 .. string.sub(path2,1,i-1) .. device.directorySeparator
	    if path1 == device.writablePath then break end
	    Util:mkdir(path1)
	    path2 = string.sub(path2,i + 1)
	end

	-- 下载保存后再继续下载
	local fileName = cls.getFileName(self.key)
	local path = device.writablePath .. fileName .. ".tmp"
	req:saveResponseData(path)

	-- 文本保存失败
	local isError = false
	if Util:exists(path) then
	    -- MD5文件验证
	    local newMd5 = Crypto.md5file(path)
	    if self.md5 and self.md5 ~= newMd5 then
       		print("*** file md5 error:",fileName)
	        print("*** old md5 : ",self.md5)
	        print("*** new md5 : ",newMd5)
	        isError = true
	        return
	    end
	else
	    print("*** file save error:",fileName)
		isError = true
        return
	end

	if isError then
	    self.fhand(self)
	    return
	end

    self.rhand(self)
end

function cls:downloadFhand()
	if self.loadAglin > 0 then
		self.loadAglin = self.loadAglin - 1
		self:start()
		return
	end

	self.cdnIndex = self.cdnIndex + 1
	if self.cdnIndex > #self.cdnList then
		self.cdnIndex = 1
	end

	if self.cdnStartIndex == self.cdnIndex then
    	self.fhand(self)
    	return
	end
	
	self.loadAglin = ERROR_AGIN
	self:start()
end

function cls:downloadUhand(load, total)
	total        = math.max(1, total)-- 保护不为0
	self.percent = load / total
	self.load    = load / 1024
	self.total   = total / 1024

    self.uhand(self)
end

-- 将KEY转成URL文件名
function cls.getUrlName(key)
    return string.gsub(key,"\\","/")
end

-- 将KEY保存成文件名
function cls.getFileName(key)
	return string.gsub("upload/" .. key, "[\\/]", device.directorySeparator)
end

return cls