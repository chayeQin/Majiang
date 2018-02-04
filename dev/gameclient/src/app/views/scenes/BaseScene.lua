--
--@brief: 场景基类
--@author: qyp
--@date: 2016/4/6
--

local cls = class("BaseScene", cc.load("mvc").ViewBase)

local CACHE_VIEW = false

function cls:ctor(app, name, enterCallback)
	cls.super.ctor(self, app, name)
	self.viewLst = {}
	self.curr = nil
	self.afterEnterCallback_ = enterCallback



	if TEST_DEV then
		-- Util:button("button/btn_09", function()
		-- 	local tempMap = {}
		-- 	local function itrchild(node)
		-- 		local childrens = node:getChildren()
		-- 		for _, child in ipairs(childrens) do
		-- 			itrchild(child)
		-- 		end
		-- 		if node.getRendererFrontCross then
		-- 			itrchild(node:getRendererFrontCross())
		-- 		end
		-- 		node = node.getVirtualRenderer and node:getVirtualRenderer() or node
		-- 		if node.getTexture then
		-- 			local texture = node:getTexture()
		-- 			local director = cc.Director:getInstance()
		-- 			local textureCache = director:getTextureCache()
		-- 			local path = textureCache:getTextureFilePath(texture)
		-- 			if string.find(path, "/ui") or
		-- 				string.find(path, "/9sprite") then
		-- 				tempMap[path] = true
		-- 			end
		-- 		end
		-- 	end
		-- 	itrchild(appView)
		-- 	local file = io.open("ResOutput.txt", "w+")
		-- 	for path, _ in pairs(tempMap) do
		-- 		file:write(path)
		-- 		file:write("\n")
		-- 	end
		-- 	io.close(file)
		-- 	print("输出完毕")
		-- end, "资源路径"):addTo(self, 100):pos(100, 50)
	end


	self:enableNodeEvents()
end

function cls:checkWhiteUser()
	if CACHE_DEBUG_LOG and not self.logBtn then
		self.logBtn = Util:button("com/com_btn_create", function()
			GMLogView.new()
		end, "日志")
		
		self.logBtn:addTo(self, TAGS.Logs, TAGS.Logs)
			:pos(display.width - 50, 150)
			:setTitleFontName(nil)
	end

	if CACHE_DEBUG_LOG and not self.btnGvoice then
		self.btnGvoice = Util:button("com/com_btn_create", function()
			if not GVoiceUtil.isInit then
				GVoiceUtil:init(function()
					Msg.new("Init OK")
				end)
				Msg.new("初始语音")
				return
			end

			GVoiceUtil:say(function()
				local time = os.time()
				Msg.new("请说话.说完点确定", function()
					GVoiceUtil:sayCmp(function(fileID)
						time = os.time() - time
						local message = "gvoice#" .. fileID .. "#" .. time
						ChatProxy:sendMessage(ChannelType.PUBLIC_CHAT ,"", message)
						Msg.new("上传完成")
					end)
				end)
			end)
		end, "语音")
		
		self.btnGvoice:addTo(self, TAGS.Logs, TAGS.Logs)
			:pos(display.width - 50, 250)
			:setTitleFontName(nil)
	end
end

function cls:onEnter()
	Controller.initialize()
	if device.platform == "android" or device.platform == "windows" then
		local keypadLayer = display.newLayer()
									:addTo(self)
		self:run{"seq",
					{"delay", 0.5},   -- avoid unmeant back
					{"call", function()
						 -- keypad layer, for android
						keypadLayer:onKeypad(function(event)
							if event == "backClicked" then
								if StrongTutorial.isInTutorial then
									return
								end

								if self:getCurrViewName() == "" then
									SDK:exit()
								else
									ViewStack:pop()
								end
							elseif event == "menuClicked" then

							end
						end)
					end}
				}
	end

	self:checkWhiteUser()
	self.switchHandle = Util:addEvent(Event.gameSwitch, handler(self, self.switch))
end

function cls:onEnterTransitionFinish()
	if self.afterEnterCallback_ then -- do sth after enter scene
		self.afterEnterCallback_()
	end
end

function cls:onExit()
	Util:removeEvent(self.switchHandle)
	self.switchHandle = nil
	ViewStack:clear()
	Controller.disposeAllModules() -- 销毁所有的控制器临时变量
	PopupManager:clear()
end

function cls:switch(event)
	self.startSwitchTime = socket.gettime()
	local name = event.params[1]
	local isPushStack = event.params[2]
	if self.curr then
		if self.curr._vname == name then
			self.curr:updateUI()
			return
		end
		if isPushStack ~= false then
			print("...push view", self.curr._vname)
			ViewStack:push(self.curr._vname)
		end

		if self.curr.switchOut then
			self.curr:switchOut()
		end
		self.curr:hide()
		self.curr:pos(-999999, -9999999)

		if not CACHE_VIEW then
			local pre = self.curr
			pre:remove()
		end
		self.curr = nil
	end

	print("***************  Switch View ", name, isPushStack)
	if name == "" then
		return
	end

	if CACHE_VIEW then
		self.curr = self.viewLst[name]
	end

	if not self.curr and name then
		self.curr = require("app.views.game." ..name).new()
		self.curr._vname = name
		self.curr:addTo(self)
		if CACHE_VIEW then
			self.viewLst[name] = self.curr
		end
	end

	if self.curr.updateUI then
		self.curr:updateUI()
	end

	self.curr:pos(0,0)
	self.curr:show()

	print(string.format("打开界面耗时%f", socket.gettime()-self.startSwitchTime))
end

function cls:getCurrView()
	return self.curr
end

function cls:getCurrViewName()
	return self.curr and self.curr._vname or ""
end

function cls:closeView()
	ViewStack:clear()
	ViewStack:pop()
end

return cls