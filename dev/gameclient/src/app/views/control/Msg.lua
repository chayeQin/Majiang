--
--@brief 游戏消息提示弹窗
--@author qyp
--@date 2016/2/2
--

--
-- @brief msg
-- @author myc
-- @date 2018/1/9
--

local cls = class("MsgDialog",cc.Node)

function cls:ctor(msg, yesFunc, noFunc, yesLabel, noLabel)
	self.msg = msg
	self.yesFunc = yesFunc
	self.noFunc = noFunc
	self.yesLabel = yesLabel
	self.noLabel = noLabel
	self:enableNodeEvents()
	self:initDialog()
	-- self:onTouch(handler(self,self.onTouchHandler), false, true)
	PopupManager:push(self)
end

function cls:initDialog()
	-- 遮罩
	Util:touchLayer(self)
	self.spBg = Util:sprite("img/big_img_panel2")
	self.spBg:addTo(self):pos(display.cx,display.cy)
	self.spTitle = display.newSprite("#other_txt_title_ts.png")
	self.spTitle:addTo(self.spBg):pos(self.spBg:width() / 2,self.spBg:height() - 50)
	self.labMsg = Util:label(self.msg,28,Const.COLOR_GRAY,{width = self.spBg:width() - 60},
		cc.TEXT_ALIGNMENT_CENTER,cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	self.labMsg:addTo(self.spBg):center()
	local btnConfirm = Util:button("com_btn_number0",handler(self,self.btn_yesHandler),
				self.yesLabel or "确定",28, display.COLOR_WHITE,ccui.TextureResType.plistType)
				:addTo(self.spBg)
				:pos(self.spBg:width() / 2,100)
	if self.noFunc or self.noLabel then
		btnConfirm:x(self.spBg:width() / 2 - 200)
		Util:button("com_btn_number0",handler(self,self.btn_noHandler),
			self.yesLabel or "取消",28, display.COLOR_WHITE,ccui.TextureResType.plistType)
			:addTo(self.spBg)
			:pos(self.spBg:width() / 2 + 200,100)
	end
end

function cls:btn_yesHandler(target)
	if self.yesFunc then
		self.yesFunc()
	end
	PopupManager:popView(self)
end

function cls:btn_noHandler(target)
	if self.noFunc then
		self.noFunc()
	end
	PopupManager:popView(self)
end

return cls

-- local cls = class("Msg", function()
--     return display.newLayer(Const.LayerColor)
--     				:size(display.width,display.height)
-- end)

-- -- 有消费信息的窗口
-- function cls.createConsumeMsg(msg, yesFunc, yesLab, costItem, noRemind)
-- 	return cls.new(msg, yesFunc, function()end, yesLab, nil, nil, costItem, nil, nil, noRemind)
-- end

-- -- 有时钟的消息窗口， 倒计时完毕自动关闭窗口
-- function cls.createTimeMsg(msg, yesFunc, yesLab, costItem, endTime, endTimeRhand)
-- 	return cls.new(msg, yesFunc, nil, yesLab, nil, nil, costItem, endTime, nil, nil, endTimeRhand)
-- end

-- -- 不能点任意地方关闭的消息
-- function cls.createMsg(msg, yesFunc, noFunc, yeslabel, nolabel, title)
-- 	local msg = cls.new(msg, yesFunc, noFunc, yeslabel, nolabel, title)
-- 	msg.isCanClose = false
-- 	return msg
-- end

-- --@brief 系统消息
-- function cls.createSysMsg(msg, yesFunc, noFunc, yeslabel, nolabel, title)
-- 	local msg = cls.new(msg, yesFunc, noFunc, yeslabel, nolabel, title, nil, nil, nil, nil, nil, true)
-- 	msg.isCanClose = false
-- 	return msg
-- end

-- --@brief 搜索玩家通用消息
-- function cls.createSearchUserMsg(title, tips, rhand)
-- 	local showSearchMsg = nil
-- 	-- 处理搜索结果
-- 	local function showSearchResultMsg(userInfo)
-- 		if userInfo then
-- 			dump(userInfo)
-- 			local placeHolder = string.rep("\n", 5)
-- 			local msg = Msg.new(placeHolder, function()
-- 				if rhand then
-- 					rhand(userInfo)
-- 				end
-- 			end, function() -- 重新搜素
-- 				showSearchMsg()
-- 			end, Lang:find("ok"), Lang:find("xjzb_cxss"), title)
-- 			-- 创建玩家头像
-- 			local icon =  Util:sprite("ui/chat_txk_02")
-- 								:addTo(msg)
-- 								:pos(msg:width()/2, msg:height()/2 + 30)
-- 			Util:sprite("ui/chat_txk_01")
-- 							:addTo(icon)				
-- 							:pos(icon:width()/2, icon:height()/2)
-- 			UserIcon.new({uid=userInfo.uid, icon=userInfo.icon})
-- 				:addTo(icon)
-- 				:pos(icon:width()/2, icon:height()/2)
-- 			local name = Util:systemLabel(userInfo.name, 20, Const.Color.QualityWhite)
-- 							:addTo(icon)
-- 							:pos(icon:width()/2, -20)
-- 		else
-- 			local placeHolder = string.rep("\n", 2)
-- 			local txt = placeHolder .. tips .. placeHolder
-- 			local msg = Msg.new(txt, function() -- 重新搜索
-- 				showSearchMsg()
-- 			end, nil, nil, nil, Lang:find("xjzb_qdwj"))
-- 			msg.lblMsg:setTextColor(Const.Color.SystemWarning)
-- 		end
-- 	end

-- 	-- 组装msg
-- 	showSearchMsg = function ()
-- 		local placeHolder = string.rep("\n", 5)
-- 		local inputNode = display.newNode()
-- 		Util:systemLabel(Lang:find("inputName"), 20, Const.Color.QualityWhite)
-- 			:anchor(0, 0.5)
-- 			:addTo(inputNode)
-- 			:pos(-240, 35)
-- 		Util:sprite9Lib("ui/kuang_48")
-- 			:addTo(inputNode)
-- 			:size(515, 65)
-- 		local inputBox = Util:editBox(cc.size(470, 30))
-- 							:addTo(inputNode)
-- 		inputBox:setPlaceHolder(Lang:find("cjlmDjjr"))
-- 		inputBox:setPlaceholderFontColor(Const.Color.SystemImport)
-- 		local msg = Msg.new(placeHolder, function()
-- 			-- 请求服务器搜索指定玩家名字
-- 			local name = inputBox:getText()
-- 			if name == "" then
-- 				showSearchResultMsg(false)
-- 			else
-- 				Net:call(function(v, msg)
-- 					if v.error ~= 0 then
-- 						return
-- 					end
-- 					if v.result then
-- 						showSearchResultMsg(v.result)
-- 					else
-- 						showSearchResultMsg(false)
-- 					end
-- 				end, "User", "searchPlayer", User.info.uid, name)
-- 			end
			
-- 		end, nil, Lang:find("szjmSosu"), nil, Lang:find("xjzb_qdwj"))
-- 		Util:button({"button/btn_102", "button/btn_102_02"}, function()
-- 			PopupManager:popView(msg)
-- 		end):addTo(msg.spiPanel)
-- 			:pos(msg.spiPanel:width()-20, msg.spiPanel:height()-20)
-- 		inputNode:addTo(msg.spiPanel)
-- 				:pos(msg.spiPanel:width()/2, msg.spiPanel:height()/2)
-- 		msg.isCanClose = false
-- 	end
-- 	showSearchMsg()
-- end

-- function cls:ctor(msg, yesFunc, noFunc, yeslabel, nolabel, title, costItem, endTime, extraInfo, noRemind, endTimeRhand, isSysMsg)
-- 	self.data = self.data or {}
-- 	self.data.msg = msg
-- 	self.data.noFunc = noFunc
-- 	self.data.yesFunc = yesFunc
-- 	self.data.nolabel = nolabel
-- 	self.data.yeslabel = yeslabel
-- 	self.data.title = title or Lang:find("MsgTitle")
-- 	self.data.costItem = costItem
-- 	self.data.endTime = endTime
-- 	self.data.extraInfo = extraInfo
-- 	self.data.noRemind = noRemind
-- 	self.data.endTimeRhand = endTimeRhand
-- 	self.spiPanel = false
-- 	self.lblMsg = false
-- 	self.btnYes = false
-- 	self.btnNo = false
-- 	self.lblTitle = false
-- 	self.isCanClose = true -- 是否点击任意区域关闭面板
-- 	self.isSysMsg = isSysMsg
-- 	self:enableNodeEvents()
-- 	self:onCreate()
-- 	if not isSysMsg then
-- 		PopupManager:push(self)
-- 	else
-- 		self:addTo(appView, TAGS.Sys)
-- 	end
   
-- 	self:onTouch(handler(self,self.onTouchHandler), false, true)
-- end

-- function cls:onEnter()
-- 	appView.tutorialMsg = self
-- end

-- function cls:onExit()
-- 	appView.tutorialMsg = nil
-- end

-- function cls:onCleanup()
-- end

-- function cls:onCreate()
-- 	self.spiPanel = ccui.ImageView:create()
-- 	self.spiPanel:loadTexture(Util:path("9sprite/9sp_07"))
-- 	self.spiPanel:setTouchEnabled(true)
-- 	self.spiPanel:setScale9Enabled(true)
-- 	self.spiPanel:width(550)
-- 	self.spiPanel:addTo(self):center()

-- 	-- 从下到上布局坐标才不会因为spiPanel大小变化而变化
-- 	local btnY = 50
-- 	if self.data.yesFunc then
-- 		local yesRhand = function()
		
-- 		    if self.data.yesFunc then
-- 		    	self.data.yesFunc()
-- 		    end
-- 		end
-- 		self.btnYes = Util:button("button/btn_27",self:btnHandler(yesRhand), self.data.yeslabel or Lang:find("ok"), 20)
-- 							:addTo(self.spiPanel)
-- 							:pos(self.spiPanel:width() -155, btnY)
-- 							:setScale9Enabled(true)
-- 							:size(160,60)

-- 		if not self.data.noFunc then
-- 			self.btnYes:pos(self.spiPanel:width()/2, btnY)
-- 		end
-- 	end


-- 	if self.data.noFunc then
-- 		self.btnNo = Util:button("button/btn_28",self:btnHandler(self.data.noFunc), self.data.nolabel or Lang:find("cancel"), 20)
-- 						:addTo(self.spiPanel)
-- 						:pos(155, btnY)
-- 						:setScale9Enabled(true)
-- 						:size(160,60)
-- 	end
-- 	local bottomLineY = btnY + 45
-- 	if self.data.noRemind then--不再提醒
-- 		local chk = ccui.CheckBox:create(Util:path("9sprite/9sp_09"), Util:path("ui/icon_xuanzhong_01"))
-- 								:addTo(self.spiPanel)
-- 								:pos(self.spiPanel:width() - 100, btnY + 70)
-- 		Util:systemLabel(Lang:find("noRemind"), 22, Const.Color.ExplainStair)
-- 			:anchor(1, 0.5)
-- 			:addTo(self.spiPanel)
-- 			:pos(chk:x() - chk:width(), btnY + 70)
-- 		self.chk = chk
-- 		bottomLineY = bottomLineY + 50
-- 	end

-- 	self.lineBottom = Util:sprite9Lib("ui/by_line_02")
-- 						:addTo(self.spiPanel)
-- 						:size(self.spiPanel:width() - 10, 2)
-- 						:pos(self.spiPanel:width()/2, bottomLineY)

-- 	local msgY = self.lineBottom:y() + 20
-- 	-- 消费扣除
-- 	if self.data.costItem then
-- 		Util:systemLabel(Lang:find("wish_cost") .. ":", 20, Const.Color.ExplainStair)
-- 			:addTo(self.spiPanel)
-- 			:anchor(1, 0.5)
-- 			:pos(self.spiPanel:width()/2, self.lineBottom:y() + 15)
-- 		local tmp = Util:sprite(self.data.costItem:getItemPic(true))
-- 						:addTo(self.spiPanel)
-- 						:anchor(0, 0.5)
-- 						:pos(self.spiPanel:width()/2 + 5, self.lineBottom:y() + 15)
-- 		local count = self.data.costItem:getItemCount()
-- 		string.formatnumberthousands(count)
-- 		Util:systemLabel(count, 20, Const.Color.SystemHint)
-- 			:addTo(self.spiPanel)
-- 			:anchor(0, 0.5)
-- 			:pos(tmp:x() + tmp:width() + 5 , tmp:y())
-- 		msgY = tmp:y() + 70
-- 	end

-- 	if self.data.extraInfo then
-- 		local tmp = Util:systemLabel(self.data.extraInfo.lab, 20, Const.Color.ExplainStair)
-- 						:addTo(self.spiPanel)
-- 						:anchor(0, 0.5)
-- 						:pos(10, self.lineBottom:y() + 15)
-- 		Util:systemLabel(self.data.extraInfo.count, 20, Const.Color.SystemHint)
-- 			:addTo(self.spiPanel)
-- 			:anchor(0, 0.5)
-- 			:pos(tmp:x() + tmp:width() + 5 , tmp:y())
-- 		msgY = tmp:y() + 70
-- 	end


-- 	self.lblMsg = Util:systemLabel(self.data.msg,20, Const.Color.ExplainStair,cc.size(520, 0), cc.TEXT_ALIGNMENT_CENTER)
-- 			:addTo(self.spiPanel)
-- 			:anchor(0.5, 0)
-- 			:pos(self.spiPanel:width()/2, msgY)

-- 	self.lineTop = Util:sprite9Lib("ui/by_line_02")
-- 						:addTo(self.spiPanel)
-- 						:size(self.spiPanel:width() - 10, 2)
-- 						:pos(self.spiPanel:width()/2, self.lblMsg:y() + self.lblMsg:height() + 15)


-- 	self.lblTitle = Util:systemLabel(self.data.title or "",20, Const.Color.SystemHint,cc.size(self.spiPanel:width() - 70, 0),cc.TEXT_ALIGNMENT_CENTER,cc.TEXT_ALIGNMENT_CENTER)
-- 						:addTo(self.spiPanel)
-- 						:pos(self.spiPanel:width()/2, self.lineTop:y() + 20)

-- 	local totalHeight = self.lineTop:y() + 40

-- 	-- 倒计时
-- 	if self.data.endTime then
-- 		self.lblTitle:hide()
-- 		local day = Util:number(1, true)
-- 							:addTo(self.spiPanel)
-- 							:y(self.lineTop:y() + 30)
-- 		local hour = Util:number(1, true)
-- 							:addTo(self.spiPanel)
-- 							:y(self.lineTop:y() + 30)
-- 		local function countdown()
-- 			local t = self.data.endTime - Util:time()
-- 			if t <= 0 then
-- 				if self.data.endTimeRhand then
-- 					self.data.endTimeRhand()
-- 				end
-- 				self:onClose()
-- 				return
-- 			end
-- 			local ary = Util:strSplit(Util:formatTime(t), " ")
-- 			if #ary > 1 then
-- 				day:value(ary[1])
-- 				hour:value(ary[2])
-- 				local width = day:width() + hour:width() + 10
-- 				local dayX = day:width()/2
-- 				day:x(self.spiPanel:width()/2 - width/2 + day:width()/2)
-- 				hour:x(self.spiPanel:width()/2 + width/2 - hour:width()/2)
-- 			else
-- 				day:hide()
-- 				hour:value(ary[1])
-- 				hour:x(self.spiPanel:width()/2)
-- 			end
-- 		end
-- 		self:schedule(countdown, 1)
-- 		countdown()
-- 		totalHeight = self.lineTop:y() + 70
-- 	end

-- 	self.spiPanel:height(totalHeight)
-- end

-- function cls:update()
-- end

-- function cls:flush()
-- end

-- function cls:setEnabledConfirm(boo)
-- 	self.btnYes:setEnabled(boo)
-- end

-- function cls:btnHandler(callback)
-- 	return function()
-- 		if self.chk and self.chk:isSelected() then -- 不再提醒
-- 	    	User:costRemind(self.data.noRemind, true)
-- 	    end
	    
-- 		if callback then
-- 			callback(self)
-- 		end
-- 		if not tolua.isnull(self) then
-- 			self:onClose()
-- 		end
-- 	end
-- end

-- function cls:yesHandler()
-- 	if self.data.yesFunc  then
-- 		self.data.yesFunc(self)
-- 	end
-- 	self:onClose()
-- end

-- function cls:onTouchHandler(event)
-- 	if event.name == "ended" then
-- 		if self.isCanClose and
-- 			not self.spiPanel:isContain(event.x, event.y) then
-- 			self:onClose()
-- 		end
-- 	end
-- 	return true
-- end

-- function cls:onClose()
-- 	if self.isSysMsg then
-- 		self:remove()
-- 	else
-- 		PopupManager:popView(self)
-- 	end
-- end

-- return cls
