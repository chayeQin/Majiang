--
-- @brief 玩家头像
-- @author myc
-- @date 2018/1/9
--

local cls = class("PlayerIcon",cc.Node)

function cls:ctor(url)
	local bg = Util:sprite("com/com_img_iconframe")
	self:size(bg:size())
	self:anchor(display.CENTER)
	bg:addTo(self)
		:center()
	self.icon = Util:sprite("com/com_icon_head")
	self.icon:addTo(self)
				:center()
	self:loadIcon(url)
end

function cls:loadIcon(url,isStep)
	if not url or url == "" then
		return
	end
	local fileName = Crypto.md5(url)
	local path1 = device.writablePath .. "user_icon" .. device.directorySeparator
	Util:mkdir(path1)
	local path2 = path1 .. fileName
	if Util:exists(path2) then
		self.icon:setTexture(path2)
		local scaleX = self:width() / self.icon:width()
		local scaleY = self:height() / self.icon:height()
		local scale = math.max(scaleX, scaleY)
		self.icon:scale(scale)
		return
	elseif isStep then
		return
	end
	Http.load(url, function(str, req)
		req:saveResponseData(path2)
		if not tolua.isnull(self) then
			self:loadIcon(url, true)
		end
	end, false, nil, nil, false)
end

return cls