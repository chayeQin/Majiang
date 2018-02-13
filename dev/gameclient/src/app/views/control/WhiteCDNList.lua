--
-- Author: lyt
-- Date: 2017-02-09 10:17:52
-- 服务器选择列表
local cls = class("WhiteCDNList", function()
    return display.newLayer(Const.LayerColor)
			:size(display.width,display.height)
end)

function cls:ctor()
	Util:touchLayer(self)
	PopupManager:push(self)

	Util:sprite9Lib("9sprite/9sp_16"):addTo(self)
		:pos(display.cx, display.cy)
		:size(display.width - 100, display.height - 100)

	Util:sprite9Lib("9sprite/9sp_08"):addTo(self)
		:pos(565, 370)
		:size(852, 502)

	Util:button("button/button_bg_01", handler(self, self.btnDelHandler), "删除数据")
		:addTo(self)
		:pos(1110, 360)
		:setTitleFontName(nil)

	Util:button("button/button_bg_01", handler(self, self.btnUpdateHandler), "强制更新")
		:addTo(self)
		:pos(1110, 290)
		:setTitleFontName(nil)

	Util:button("button/button_bg_01", handler(self, self.btnOkHandler), "确定")
		:addTo(self)
		:pos(1110, 220)
		:setTitleFontName(nil)
	Util:button("button/button_bg_01", handler(self, self.remove), "取消")
		:addTo(self)
		:pos(1110, 150)
		:setTitleFontName(nil)

	local lsv1 = ListView.new(852, 500)
					:addTo(self)
					:pos(140, 120)
	lsv1.cell = handler(self, self.cell1)
	lsv1.callback = handler(self, self.touch1)

	self.lsv1 = lsv1

	self.selectIndex1 = 1
	lsv1:update(PlatformInfo:getCdnList())
end

function cls:cell1(i,data)
	local node = display.newNode():size(852,50)
	node.data = data

	node.select = Util:sprite9Lib("9sprite/a_9sp_10"):addTo(node)
		:pos(426, 25)
		:size(852,50)

	Util:systemLabel(data,22):addTo(node,1)
		:pos(426, 25)

	if self.selectIndex1 ~= i  then
		node.select:hide()
	end

	local verUrl = data .. "cdn"
	TestHttp.new(verUrl, function(http)
		if tolua.isnull(node) then
			return
		end

		local time = http.time
		if http.req then
		    local save_file = device.writablePath .. "upload/cdn" .. ".tmp"
		    if Util:exists(save_file) then
		        os.remove(save_file)
		    end
		    http.req:saveResponseData(save_file)

		    local old = Crypto.md5file(cc.FileUtils:getInstance():fullPathForFilename("cdn"))
		    local new = Crypto.md5file(save_file)

		    if old ~= new then
				time = -1
		    end
		else
			time = -1
		end
		WhiteUser.createTime(time):addTo(node, 2)
			:align(display.RIGHT_CENTER, 822, 25)
	end)

	return node
end

function cls:touch1(event)
	if event.name ~= ListView.SELECT_END_EVENT then
		return
	end

	self.selectIndex1 = event.index
	local data = event.target.data
	for k,v in pairs(self.lsv1.cellLst_) do
		if v ~= event.target then
			v.select:hide()
		end
	end
	event.target.select:show()
end

function cls:btnOkHandler()
	local data1 = self.lsv1.data_[self.selectIndex1]

	cc.exports.TEST_SELECT_SERVER_CDN = data1

	Tips.new("设置成功\n" .. data1)
	
	PopupManager:popView(self)
end

function cls:btnUpdateHandler()
	clearUpload()
	app:clearModule()
	app:restart()
end

function cls:btnDelHandler()
	local writablePath = cc.FileUtils:getInstance():getWritablePath()
	os.remove(writablePath .. "UserDefault.xml")

	for file in lfs.dir(writablePath) do
	    if file ~= "." and file ~= ".." then
	        local path = writablePath .. device.directorySeparator .. file
	        local attr = lfs.attributes(path)
	        if attr.mode == "file" then
	            local pz = string.sub(file, string.len(file) - 2)
	            if pz == ".db" then
	            	os.remove(path)
	            end
	        end
	    end
	end

	Tips.new("删除成功")
end

return cls