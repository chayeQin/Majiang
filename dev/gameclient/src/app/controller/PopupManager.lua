--
-- @brief 弹窗管理
-- @author qyp
-- @date 2015/09/21
--

local cls = class("PopupManager")

local __singleton = false

-- 弹窗tag(用于寻找view)
cls.AcceleratePanel = 10000

function cls:ctor()
	if __singleton then
		post_error("ERROR*** PopupManager:ctor  Reinstantiate a singleton ***")
		return
	end
	self.z = 1
	__singleton = true
	self.popupList = {}
end

--@brief 添加弹窗,
function cls:push(view, tag)
	if view then
		print("==============PopupManager:addView==============", view.__cname, self.z)
		local node = self:checkNodeValid()
		-- for _, v in ipairs(self.popupList) do -- 隐藏后面的弹窗
		-- 	v:hide()
		-- end
		table.insert(self.popupList, view)
		view:addTo(node, self.z, tag)
		self.z = self.z + 1
	end
end

--@brief 移除弹窗
function cls:pop()
	self:popView(self.popupList[#self.popupList])
end

--@brief 移除指定弹窗
function cls:popView(view)
	if not view or tolua.isnull(view) then
		return
	end
	local node = appView:getChildByTag(TAGS.Popup)
	if not node then-- 如果当前场景没有弹窗节点，则表示切换过场景
		self.popupList = {}
		return
	end
	print("==============PopupManager:popView==============", view.__cname)
	local index = nil
	for i, v in pairs(self.popupList) do
		if v == view then
			index = i
			break
		end
	end
	if index then
		table.remove(self.popupList, index)
	end
	view:remove()
	if self.popupList[#self.popupList] then
		self.popupList[#self.popupList]:show()
	else
		self:clear()
	end
end

--@brief 检测弹窗节点是否还在当前场景
function cls:checkNodeValid()
	local node = appView:getChildByTag(TAGS.Popup)
	if not node then-- 如果当前场景没有弹窗节点，则表示切换过场景
		self.popupList = {}
		node = display.newLayer()
						:addTo(appView, TAGS.Popup, TAGS.Popup)
						:size(display.width, display.height)
						:pos(0, 0)
		node:onTouch(function()
			if #self.popupList > 0 then
				return true 
			else
				return false
			end
		end, nil, true)
	end
	return node
end

--@brief 清除所有弹窗
function cls:clear()
	print("=====PopupManager:clear=====")
	appView:removeChildByTag(TAGS.Popup)
	self.popupList = {}
	self.z = 1
end

function cls:getViewByTag(tag)
	local node = appView:getChildByTag(TAGS.Popup)
	if node then
		return node:getChildByTag(tag)
	end
end

return cls
