--
-- @brief 翻页容器
-- @author myc
-- @date 2016/9/5
--

local cls = class("PageView",function (width,height)
	return display.newLayer():size(width,height)
end)

cls.SELECT_START_EVENT 	= 1
cls.SELECT_END_EVENT 	= 2
-- callback 参数 event = {name(事件类型), target(点击对象), index, pos(点击的世界坐标)}

function cls.bind(view,placeHolder)
	local pageView = PageView.new(placeHolder:width(),placeHolder:height())
							:addTo(placeHolder)
							:align(display.LEFT_BOTTOM,0,0)
	if view.pageCell then
		pageView.pageCell = handler(view,view.pageCell)
	end
	if view.onPageViewEvent then
		pageView.onPageViewEvent = handler(view,view.onPageViewEvent)
	end
	return pageView
end

-- cls.cell -- 创建单元回调,  必须使用ccui 的控件, 否则会出现触摸穿透
--@param[pageViewEvent] 翻页事件回调
function cls:ctor(width,height,pageViewEvent)
	local layout = ccui.Layout:create():size(width,height)
							:addTo(self)
	layout:setClippingEnabled(true)
	layout:setClippingType(1)
	self.layer_ = ccui.Widget:create()
								:addTo(layout)
	self.layout = layout
	self.onPageViewEvent = pageViewEvent
	self.data_ = {}
	self.currIndex = nil
	self.progressNode = nil
	self.scheduleNode = nil
	self.isAutoSlide = nil
	self.cellList_ = {}
	self.w_ = width
	self.h_ = height
	self.progressY = 50
	self:onTouch(handler(self,self.onTouchHandler),nil,true)
end

function cls:setProgressY(y)
	self.progressY = y
end

function cls:update(data,index)
	self.layout:removeAllChildren()
	self.layer_ = ccui.Widget:create()
					:addTo(self.layout)
					:align(display.LEFT_BOTTOM,0,0)
	if #data <= 0 then
		return
	end
	if self.scheduleNode then
		self.scheduleNode:remove()
		self.scheduleNode = nil
	end
	data = data and clone(data) or {}
	index = index or 1
	index = math.max(1,math.min(#data,index))
	self.data_ = data
	self.currIndex = index
	self.cellList_ = {}
	self.currIndex = index
	local cell = self.pageCell(index,data[index])
	cell:addTo(self.layer_)
	cell:align(display.LEFT_BOTTOM,0,0)
	self.cellList_[index] = cell
	self:initPageViewProgress()
end

-- 初始化pageview进度
function cls:initPageViewProgress(index)
	index = index or self.currIndex or 1
	local length = #self.data_
	if length <= 0 then
		self.progressNode = nil
		return
	end
	local node = display.newNode()
	local progressLst = {}
	local width = nil
	local gap = 10
	for i = 1,length do
		local progress = Util:sprite("ui/chat_zt_02")
		width = width or progress:width()
		local x = -( length * width + gap * (length - 1)) / 2  + (i - 1) * (width + gap)
		progress:addTo(node)
				:x(x,progress:height() / 2)
		table.insert(progressLst,progress)
		if i == index then
			progress:setTexture(Util:path("ui/chat_zt_01"))
		end
		self.index = index
	end
	node.progressLst = progressLst
	node:addTo(self.layout)
		:pos(self:width()/2,self.progressY)
	self.progressNode = node
end

function cls:updateCells()
	local index = self:getCurrPageIndex()
	local lstMap = {}
	local currCell = self.cellList_[index]
	if not currCell or #self.data_ <= 0 then
		self:update(self.data_,index)
		return
	end
	local wp = currCell:convertToWorldSpace(cc.p(0,0))
	local np = self.layout:convertToNodeSpace(wp)
	local np2 = self.layer_:convertToNodeSpace(wp)
	local deltaX = self.w_
	local visibleIndex = nil
	if np.x < 0 then
		visibleIndex = self:getNextIndex(index)
		deltaX = np2.x + self.w_
	elseif np.x > 0 then
		visibleIndex = self:getPreIndex(index)
		deltaX = np2.x - self.w_
	end
	if visibleIndex and not self.cellList_[visibleIndex] then
		local cell = self.pageCell(visibleIndex,self.data_[visibleIndex])
		cell:addTo(self.layer_)
		cell:align(display.LEFT_BOTTOM,deltaX,0)
		self.cellList_[visibleIndex] = cell
	elseif visibleIndex and self.cellList_[visibleIndex] then
		self.cellList_[visibleIndex]:align(display.LEFT_BOTTOM,deltaX,0)
	end
	for i,cell in pairs(self.cellList_) do
		local wp = cell:convertToWorldSpace(cc.p(0,0))
		local np = self.layout:convertToNodeSpace(wp)
		if np.x + self.w_ < 0 or np.x > self.w_ then
			cell:remove()
			self.cellList_[i] = nil
		end
	end
end

function cls:getNextIndex(index)
	index = index + 1
	if #self.data_ <= 1 then
		return
	elseif index > #self.data_ then
		index = 1
	end
	return index
end

function cls:getPreIndex(index)
	index = index - 1
	if #self.data_ <= 1 then
		return
	elseif index <= 0 then
		index = #self.data_
	end
	return index
end

-- 更新pageview进度
function cls:updateProgress()
	local index = self:getCurrPageIndex()
	if not self.progressNode or #self.data_ <= 0 then
		return
	end
	local progressLst = self.progressNode.progressLst
	for i,v in ipairs(progressLst) do
		if i == index then
			v:setTexture(Util:path("ui/chat_zt_01"))
		else
			v:setTexture(Util:path("ui/chat_zt_02"))
		end
	end
end

function cls:onTouchHandler(event)
	if not self.data_ or #self.data_ <= 0 then
		return
	end
	if self.autoNode then
		self.autoNode:remove()
		self.autoNode = nil
	end
	local np = self:convertToNodeSpace(cc.p(event.x, event.y))
	local rect = cc.rect(0, 0, self:width(), self:height())
	if not cc.rectContainsPoint(rect, np) then
		self.isDrag = false
		if event.name == "ended" and self.lastP	then
			if self.isAutoSlide then
				self:setAutoSilde()
			end
			if self.lastP then
				local distanceX = self.lastP.x - event.x
				local inertia = 0
				while math.abs(distanceX) > 5 do
					inertia = inertia + distanceX * 0.9
					distanceX = distanceX * 0.9
				end
				if math.abs(inertia) > self.w_ then
					local index = self.currIndex + math.floor(math.abs(inertia) / inertia)
					if index <= 0 then
						index = #self.data_
					elseif index > #self.data_ then
						index = 1
					end
					self:slideToIndex(index,distanceX)
					return
				end
			end
			self:slideToCloseItem()
		end
		return
	end
	if event.name == "began" then
		self.touchBeganP = cc.p(event.x,event.y)
		self.lastP = self.touchBeganP
		self.isDrag = false
		self.layer_:stop()
		local index,cell = self:getTouchCell(cc.p(event.x,event.y))
		self.onPageViewEvent({name = cls.SELECT_START_EVENT,target = cell,index = index,pos = cc.p(event.x,event.y)})
		self.beganCell_ = cell
		self.beganIndex = index
		return true
	elseif event.name == "moved" then
		if not self.isDrag and cc.pGetDistance(self.touchBeganP,cc.p(event.x,event.y)) > 20 then
			self.isDrag = true
		end
		local index,cell = self:getTouchCell(cc.p(event.x,event.y))
		if cell ~= self.beganCell_ then
			self.isDrag = true
			self.beganCell_ = nil
			self.beganIndex = nil
		end
		self:dragLayer(cc.p(event.x,event.y),self.lastP)
		self.lastP = cc.p(event.x,event.y)
	elseif event.name == "ended" then
		if not self.isDrag and self.beganCell_ and self.beganIndex then
			self.onPageViewEvent({name = cls.SELECT_END_EVENT,target = self.beganCell_,index = self.beganIndex,pos = cc.p(event.x,event.y)})
		end
		if self.isDrag then
			self.isDrag = false
			local deltaX = event.x - self.touchBeganP.x
			if deltaX > 0 and deltaX > 50 then
				self:slideToPreItem()
			elseif deltaX < 0 and math.abs(deltaX) > 50 then
				self:slideToNextItem()
			else
				self:slideToCloseItem()
			end
		else
			self:slideToCloseItem()
		end
		if self.isAutoSlide then
			self:setAutoSilde()
		end
	end
end

function cls:getTouchCell(wp)
	for index,cell in pairs(self.cellList_) do
		local np = cell:convertToNodeSpace(wp)
		local rect = cc.rect(0,0,cell:width(),cell:height())
		if cc.rectContainsPoint(rect,np) then
			return index,cell
		end
	end
end

function cls:dragLayer(newP,lastP)
	local deltaP = cc.pSub(newP,lastP)
	local x = self.layer_:getPositionX() + deltaP.x
	if #self.data_ <= 1 then
		x = self.layer_:getPositionX() + deltaP.x / 5
	end
	self.layer_:setPositionX(x)
	self:updateCells()
end

-- @param[inertia] 惯性距离
function cls:slideToCloseItem()
	local index = nil
	local closeX = nil
	for i,cell in pairs(self.cellList_) do
		local wp = cell:convertToWorldSpace(cc.p(0,0))
		local np = self:convertToNodeSpace(wp)
		if not closeX or math.abs(closeX) > math.abs(np.x) then
			closeX = np.x
			index = i
		end
	end
	self:slideToIndex(index)
end

function cls:slideToIndex(index,perDistance)
	if self.cellList_[index] then
		local wp = self.cellList_[index]:convertToWorldSpace(cc.p(0,0))
		local np = self:convertToNodeSpace(wp)
		local deltaX = np.x
		self.currIndex = index
		if self.scheduleNode and not tolua.isnull(self.scheduleNode) then
			self.scheduleNode:remove()
			self.scheduleNode = nil
		end
		self.layer_:stopAllActions()
		self.scheduleNode = self:schedule(function ()
			self:updateCells()
		end,1/30,true)
		local actionTime = 0.5
		if perDistance then
			actionTime = math.abs(deltaX / perDistance)
		end
		self.layer_:run{
			"seq",
			{"moveby",0.25,cc.p(-deltaX,0)},
			{"call",function ()
				self:updateProgress()
				self.scheduleNode:remove()
				self.scheduleNode = nil
			end}
		}
	else
		self:update(self.data_,index)
	end
end

function cls:slideToNextItem()
	local index = self:getCurrPageIndex()
	index = index + 1
	if index > #self.data_ then
		index = 1
	end
	self:slideToIndex(index)
end

function cls:slideToPreItem()
	local index = self:getCurrPageIndex()
	index = index - 1
	if index <= 0 then
		index = #self.data_
	end
	self:slideToIndex(index)
end

function cls:removeItemByIndex(index)
	if not self.data_[index] then
		return
	end
	if self.cellList_[index] then
		if index == self.currIndex then
			self:slideToNextItem()
		else
			local toIndex = self:getPreIndex(index - 1)
			self:slideToIndex(toIndex)
		end
	else
		
	end
end

function cls:autoSlide()
	if #self.data_ <= 1 or self.isDrag then
		self.layer_:stopAllActions()
		return
	end
	local currIndex = self:getCurrPageIndex()
	local nextIndex = currIndex + 1
	if nextIndex > #self.data_ then
		nextIndex = 1
	end
	self:updateCells()
	if not self.cellList_[nextIndex] then
		local currCell = self.cellList_[currIndex]
		local wp = currCell:convertToWorldSpace(cc.p(0,0))
		local np2 = self.layer_:convertToNodeSpace(wp)
		local deltaX = np2.x + self.w_
		local cell = self.pageCell(nextIndex,self.data_[nextIndex])
		cell:addTo(self.layer_)
		cell:align(display.LEFT_BOTTOM,deltaX,0)
		self.cellList_[nextIndex] = cell
	end
	self:slideToIndex(nextIndex)
end

function cls:getVisibleIndex(currIndex)
	local preIndex = currIndex - 1
	local nextIndex = currIndex + 1
	local length = #self.data_
	if length >= 3 then
		if preIndex <= 0 then
			preIndex = length
		end
		if nextIndex > length then
			nextIndex = 1
		end
	else
		if preIndex <= 0 then
			preIndex = nil
		end
		if nextIndex > #self.data_ then
			nextIndex = nil
		end
	end
	local lst = {}
	table.insert(lst,preIndex)
	table.insert(lst,currIndex)
	table.insert(lst,nextIndex)
	return lst
end

function cls:setAutoSilde()
	self.isAutoSlide = true
	if self.autoNode then return end
	self.autoNode = self:schedule(function ()
		self:autoSlide()
	end,10,true)
end

function cls:pageCell(i,data)
	local cell = ccui.Widget:crete()
	cell:size(self.w_,self.h_)
	return cell
end

function cls:getCurrPageIndex()
	return self.currIndex
end

return cls