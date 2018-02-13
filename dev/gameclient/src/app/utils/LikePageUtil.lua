--
-- Author: lyt
-- Date: 2017-01-24 16:20:19
-- 跳转粉丝页或主页
local cls = class("LikePageUtil")

function cls:ctor()
end

function cls:openFeedBack()
	Api:openUrl("http://yhbz-log.awwgc.com/feedback.html")
end

function cls:open()
	local url = PlatformInfo:getQQ()
	-- url = "http://www.baidu.com/cn=cn,tw|http://www.baidu.com/en=en"
	if not string.find(url, "|") then
		Api:openUrl(url)
		return
	end

	local arr = string.split(url, "|")
	local map = {}
	local defaultUrl = nil
	for k1,line in ipairs(arr) do
		local arr2 = string.split(line, "=")
		local url2 = arr2[1]
		local arr3 = string.split(arr2[2], ",")
		for k2,lang in ipairs(arr3) do
			map[lang] = url2

			-- 第一个连接为默认连接
			if not defaultUrl then
				defaultUrl = url2
			end
		end
	end

	-- 选择相应语言连接
	url = map[Lang:getLang()]
	if not url then
		url = defaultUrl
	end
	Api:openUrl(url)
end

return cls