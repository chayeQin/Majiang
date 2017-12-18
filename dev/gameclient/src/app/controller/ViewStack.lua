--@brief 界面栈，记录界面之间的跳转顺序
--@author qyp
--@date 2015/1/27

local ViewStack = class("ViewStack")

local __singleton = false
function ViewStack:ctor()
	if __singleton then
		post_error("ERROR*** ViewStack:ctor  Reinstantiate a singleton ***")
		return
	end
	__singleton = true
	self.viewList = {}
end

--@param[viewName] 场景名字
function ViewStack:push(viewName)
	if type(viewName) ~= "string" then
		post_error("ERROR*** ViewStack:push invalid View name *** " .. (viewName or ""))
	end
	table.insert(self.viewList, viewName)
end

--@brief 弹出啊一个场景并切换
--@return viewName 场景名字
function ViewStack:pop(...)
	local viewName = self:popWithoutSwitchView()
	Util:event(Event.gameSwitch, viewName, false,...)
	return viewName
end

--@brief 只弹出一个场景， 不切换
function ViewStack:popWithoutSwitchView()
	local viewName = self.viewList[#self.viewList]
	table.remove(self.viewList, #self.viewList)
	if not viewName then
		return ""
	else
		return viewName
	end
end

function ViewStack:count()
	return #self.viewList
end

function ViewStack:getViewList()
	return self.viewList
end

function ViewStack:clear()
	self.viewList = {}
end

return ViewStack