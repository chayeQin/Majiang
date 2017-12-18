--
--@brief: 列表容器
--@author: qyp
--@date: 2016/03/21
--

local cls = class("ListView", function(width, height)
	return display.newLayer():size(width, height) --cc.c4b(255, 255, 255, 125)
end)

cls.ELASTIC_TOP_EVENT = 1
cls.ELASTIC_BOTTOM_EVENT  = 2
cls.SCROLL_EVENT = 3
cls.MOVED_EVENT = 4
cls.SELECT_START_EVENT = 5
cls.SELECT_END_EVENT = 6 -- callback 参数 event = {name(事件类型), target(点击对象), index, pos(点击的世界坐标)}
cls.ELASTIC_END = 7 	-- 滑动结束

--@brief 绑定指定界面。 placeHolder为在cocostudio的占位容器， 用来设置listView的位置与大小
function cls.bind(view, placeHolder, isHorizontal)
	local listView = ListView.new(placeHolder:width(), placeHolder:height(), isHorizontal)
							:addTo(placeHolder)
	if view.cell then
		listView.cell = handler(view, view.cell)
	end
	if view.onListViewEvent then
		listView.callback = handler(view, view.onListViewEvent)
	end
	return listView
end

--[[ 支持效果
 self.isUpdateEffect -- 更新列表时的动画效果
]]

-- cls.cell -- 创建单元回调,  必须使用ccui 的控件, 否则会出现触摸穿透
--@param[callback] 列表事件回调
function cls:ctor(width, height, isHorizontal, callback)
	local layout = ccui.Layout:create():size(width, height)
						:addTo(self)
	layout:setClippingEnabled(true)
	layout:setClippingType(1)  -- 默认剪裁STENCIL （0） 在部分机型会剪裁失败
	self.layer_ = ccui.Widget:create()
						:addTo(layout)
	self.layout = layout
	self.isHorizontal_ = isHorizontal
	self.head_ = 1
	self.tail_ = 1
	self.callback = callback
	self.data_ = {}
	self.cellLst_ = {}
	self.isDragSlow = true -- 当拖出屏幕后是否减速(如果FALSE则不能拖)
	self.isDynamicCreate = true -- 是否动态创建
	self.isUpdateEffect = false -- 第一次创建列表播放动画
	self.isTipsArrowEnabled = false
	self.isDisableTouch = false 	-- 是否屏蔽触摸
	self:onTouch(handler(self, self.onTouchHandler), nil, true)
end

function cls:update(data, index)
	data = data and clone(data) or {}
	if not index then
		-- if self.isHorizontal_ and Lang.isRTL then
		-- 	index = #data
		-- else
			index = 1
		-- end
	end
	index = math.max(1, math.min(#data, index))
	self.data_ = data
	self.head_ = index
	self.tail_ = index
	self.cellLst_ = {}
	self.clickedItem = nil
	if self.layer_ then
		self.layer_:remove()
		self.layer_ = nil
	end
	self.layer_ = ccui.Widget:create()
						:addTo(self.layout)
	if #self.data_ == 0 then -- 空列表
		self.head_ = 0
		self.tail_ = 0
	end

	-- 创建第一个
	local isFull = false		
	local visibleTop = self:getVisibleTop()
	if self.data_[self.head_] then
		local val = self.data_[self.head_]
		local sp = self:createCell(self.head_, val)
		self:pushfront(sp)
		self.cellLst_[self.head_] = sp
		if self:isReachBottom(sp) then
			isFull = true
		end
	end

	-- 向下创建cell
	while self.data_[self.tail_ + 1] and not isFull do
		local tmp = self.tail_ + 1
		local val = self.data_[tmp]
		local sp = self:createCell(tmp, val)
		self:pushback(sp)
		self.tail_ = tmp
		self.cellLst_[self.tail_] = sp
		if self:isReachBottom(sp) then
			isFull = true
		end
	end

	-- 向上创建cell
	while self.data_[self.head_ - 1] and not isFull do
		local tmp = self.head_ - 1
		local val = self.data_[tmp]
		local sp = self:createCell(tmp, val)
		local moveBy = cc.p(0, - sp:height())
		if self.isHorizontal_ then
			moveBy = cc.p(sp:width(), 0)
		end

		self.layer_:pos(cc.pAdd(self.layer_:pos(), moveBy))-- 移动一个位置
		local tailCell = self.cellLst_[self.tail_]
		if self:isReachBottom(tailCell) then -- 移动后超出显示, 则还原
			self.layer_:pos(cc.pSub(self.layer_:pos(), moveBy))
			isFull = true
		else
			self:pushfront(sp)
			self.head_ = tmp
			self.cellLst_[self.head_] = sp
		end
	end

	if self.isUpdateEffect then
		local delay = 0
		for _, v in pairs(self.cellLst_) do
			local dt = delay
			v:x(-v:width())
			v:run{"seq",
					{"delay", dt},
					{"moveby", 0.2, cc.p(v:width(), 0)}
				}
			delay = delay + 0.05
		end
	end

	self.visibleCellCount = self.tail_ - self.head_ + 1
	self:selectedItem(index)
	self:updateScrollBarSize()
	self:checkTipsArrow()
end

function cls:setDisableTouch(boolean)
	self.isDisableTouch = boolean
end

function cls:getCellByIndex(i)
	return self.cellLst_[i]
end

function cls.cell(i, data)
	local sp = nil
	if i % 2 == 0 then
		sp = Util:sprite("ui/main_item_bg_04"):anchor(0, 0)
	else
		sp = Util:sprite("ui/kuang_18"):anchor(0, 0)
	end
	Util:label(data):addTo(sp):pos(sp:width()/2, sp:height()/2)
	sp.data = data
	return sp
end

function cls:onTouchHandler(event)
	if self.isDisableTouch then 
		self.lastP = nil
		self.isDrag = false
		return false 
	end
	if not self.data_ or #self.data_ <= 0 then
		local np = self:convertToNodeSpace(cc.p(event.x, event.y))
		local rect = cc.rect(0, 0, self:width(), self:height())
		if cc.rectContainsPoint(rect, np) then
			return true
		else
			return false
		end
	end

	if event.name == "began" then
		local np = self:convertToNodeSpace(cc.p(event.x, event.y))
		local rect = cc.rect(0, 0, self:width(), self:height())
		if cc.rectContainsPoint(rect, np) then
			self.touchBeganP = cc.p(event.x, event.y)
			self.lastP = self.touchBeganP
			self.isDrag = false
			self.layer_:stop()
			self.clickedItem, self.clickItemIndex = self:checkClickCell(event.x, event.y)
			if self.clickedItem then
				if self.callback then
					self.callback({name=cls.SELECT_START_EVENT, target=self.clickedItem, index=self.clickItemIndex, pos=cc.p(event.x, event.y)})
				end
				if self.isPressedEffect then
					self.clickedItem:scale(1.1)
				end
			end
		
			return true
		end
	elseif event.name == "moved" then
		if not self.isDrag and cc.pGetDistance(self.touchBeganP,cc.p(event.x, event.y)) > 20 then
			self.isDrag = true
			if self.callback then
				self.callback({name=cls.MOVED_EVENT})
			end
		end

		if self.isDrag then
			if self.clickedItem then
				self.clickedItem:scale(1.0)
				self.clickedItem = nil
			end
			self:dragLayer(event, self.lastP)
			self:checkCells()
		end
		self.lastP = event
	elseif event.name == "ended" then
		if self.isDrag then
			local headSp = self.cellLst_[self.head_]
			local tailSp = self.cellLst_[self.tail_]
			if not self:isReachTop(headSp) or not self:isReachBottom(tailSp) then	
				self:elasticScroll()
			else
				self:inertiaScroll()
			end
		else
			if self.clickedItem then
				self.clickedItem:scale(1.0)
				if self.callback then
					self:selectedItem(self.clickItemIndex)
					Util:event(Event.assistantClick)
					self.callback({name=cls.SELECT_END_EVENT, target=self.clickedItem, index=self.clickItemIndex, pos=cc.p(event.x, event.y)})
				end
				self.clickedItem = nil
			end
		end
	end
end

function cls:setTipsArrow(res, rotate)

	res = res or "ui/jijia_jiantou"
	if self.preArrow then
		self.preArrow:remove()
		self.preArrow = nil
	end
	if self.nxtArrow then
		self.nxtArrow:remove()
		self.nxtArrow = nil
	end
	self.preArrow = Util:sprite(res)
						:addTo(self)
						:run{"rep",
							{"seq",
								{"fadein", 1},
								{"fadeout",1}
							}
						}
	self.nxtArrow = Util:sprite(res)
						:addTo(self)
						:run{"rep",
							{"seq",
								{"fadein", 1},
								{"fadeout",1}
							}
						}
	if self.isHorizontal_ then
		self.preArrow:pos(0, self:height()/2)
		self.nxtArrow:pos(self:width(), self:height()/2)
		rotate = rotate or -90
	else
		self.preArrow:pos(self:width()/2, self:height())
		self.nxtArrow:pos(self:width()/2, 0)
		rotate = rotate or 0
		
	end
	self.nxtArrow:rotate(rotate)
	self.preArrow:rotate(rotate+180)
	self:enableTipsArrow(true)
end

function cls:setScrollBar(scrollBar, bg, posx)
	scrollBar = scrollBar or "ui/chat_zt_01"
	bg = bg or "ui/chat_zt_02"
	self.posx = posx
	if self.scrollBg then
		self.scrollBg:remove()
		self.scrollBg = nil
	end

	if self.scrollBar then
		self.scrollBar:remove()
		self.scrollBar = nil
	end

	if bg then
		local tmp = Util:sprite(bg)
		self.scrollBg = Util:sprite9(bg, (tmp:width()-2)/2, (tmp:height()-2)/2, 1, 1)
							:addTo(self.layout)
		if self.isHorizontal_ then
			self.scrollBg:width(self:width())
				:pos(posx or self:width()/2, self.scrollBg:height()/2)
		else
			self.scrollBg:height(self:height())
				:pos(posx or self:width()-self.scrollBg:width()/2, self:height()/2)
		end
	end
	local tmp = Util:sprite(scrollBar)
	self.scrollBar = Util:sprite9(scrollBar, (tmp:width()-2)/2, (tmp:height()-2)/2, 1, 1)
						:addTo(self.layout)
	self:updateScrollBarSize()
end

function cls:updateScrollBarSizeSingle()
	local cell = self.cellLst_[1]
	if not cell then return end
	local bar = self.scrollBar
	if not bar then return end
	bar.scale_ = nil
	local height1 = self:height()
	local height2 = cell:height()
	if height2 < height1 then
		bar:height(height1)
		bar:y(height1)
		return
	end
	local scale = height1 / height2
	local height3 = height1 * scale
	bar:height(height3)
	bar.scale_ = scale
end

-- 单个控件时
function cls:updateScrollBarSingle()
	local cell = self.cellLst_[1]
	if not cell then return end
	local bar = self.scrollBar
	if not bar then return end
	if not bar.scale_ then return end
	local height1 = self:height()
	local y = self.layer_:y()
	bar:y(height1 - y * bar.scale_)
end

function cls:updateScrollBarSize()
	if #self.data_ == 1 then
		self:updateScrollBarSizeSingle()
		return
	end

	local visiblePercent = #self.data_ > 0 and (self.visibleCellCount)/#self.data_ or 0
	if self.scrollBar then
		if self.isHorizontal_ then
			self.scrollBar:width(visiblePercent * self:width())
							:anchor(0, 0.5)
		else
			self.scrollBar:height(visiblePercent * self:height())
							:anchor(0.5, 1)
		end
	end
	self:updateScrollBar()
end

function cls:updateScrollBar()
	if #self.data_ == 1 then
		self:updateScrollBarSingle()
		return
	end

	local scrollPercent = 0
	if #self.data_ > 0 then
		scrollPercent = (self.head_ - 1)/(#self.data_ - self.visibleCellCount)
	end
	local headSp = self.cellLst_[self.head_]
	local addPercent = 0
	if headSp then
		local top = self:getVisibleTop()
		if self.isHorizontal_ then
		else
			addPercent = (headSp:height() - (top-headSp:y()))/headSp:height()
		end
	end

	if #self.data_ > 0 then
		addPercent = math.max(addPercent, 0) / #self.data_
	else 
		addPercent = 0
	end
	scrollPercent = scrollPercent + addPercent
	scrollPercent = math.min(scrollPercent, 1)
	if not self.scrollBar then
		return
	end
	if self.isHorizontal_ then
		local x = (self:width()- self.scrollBar:width()) * scrollPercent
		self.scrollBar:pos(self.posx or x, self.scrollBar:height()/2)
	else
		local y = self:height() - (self:height()- self.scrollBar:height()) * scrollPercent
		self.scrollBar:pos(self.posx or self:width() - self.scrollBar:width()/2, y)
	end
end

function cls:checkClickCell(x, y)
	for i, v in pairs(self.cellLst_) do
		local np = v:convertToNodeSpace(cc.p(x, y))
		local rect = cc.rect(0, 0, v:width(), v:height())
		if cc.rectContainsPoint(rect, np) then
			return v, i
		end
	end
end

function cls:dragLayer(newP, lastP)
	local deltaP = cc.pSub(newP, lastP)
	if self.isHorizontal_ then
		local x = self.layer_:getPositionX() + deltaP.x
		if x > 0 and deltaP.x > 0 then
			if self.isDragSlow then
				x = self.layer_:getPositionX() + deltaP.x * 0.2
			else
				x = 0
			end
		else
			if self.tail_ == #self.data_ then
				local tailSp = self.cellLst_[self.tail_]
				local bottom = tailSp:getPositionX() + tailSp:getContentSize().width
				bottom = self:getContentSize().width - bottom
				if x < bottom and deltaP.x < 0 then
					if self.isDragSlow then
						x = self.layer_:getPositionX() + deltaP.x * 0.2
					else
						x = bottom
					end
				end
			end
		end
		self.layer_:setPositionX(x)
	else
		local size = self:getContentSize()
		local y = self.layer_:getPositionY() + deltaP.y
		if self.head_ == 1 then
			local top = self:getVisibleTop()
			local headSp = self.cellLst_[self.head_]
			local maxY = self.layer_:y() + top - headSp:y() - headSp:height()
			if maxY > y and deltaP.y < 0 then
				if self.isDragSlow then
					y = self.layer_:getPositionY() + deltaP.y * 0.2
				else
					y = maxY
				end
			end
		elseif self.tail_ == #self.data_ then
			local bottom = self:getVisibleBottom()
			local tailSp = self.cellLst_[self.tail_]
			local minY = self.layer_:y() + bottom - tailSp:y()
			if minY < y and deltaP.y > 0 then
				if self.isDragSlow then
					y = self.layer_:getPositionY() + deltaP.y * 0.2
				else
					y = minY
				end
			end
		end

		self.layer_:setPositionY(y)
	end
	self.deltaP = deltaP
end

--@brief 惯性滚动
function cls:inertiaScroll()
	local deltaP = self.deltaP
	if self.isHorizontal_ then
		deltaP.y = 0
	else
		deltaP.x = 0
	end

	self.layer_:run{
		"rep",
		{
			"seq",
			{"delay", 1/60},
			{"call", function()
				local headSp = self.cellLst_[self.head_]
				local tailSp = self.cellLst_[self.tail_]
				if not self:isReachTop(headSp) or  not self:isReachBottom(tailSp) then	
					self.layer_:stop()
					self:elasticScroll()
					return
				end
				if cc.pGetLength(deltaP) < 3 then
					self.layer_:stop()
					if self.callback then
						self.callback({name = cls.ELASTIC_END})
					end
				else
					self.layer_:pos(cc.pAdd(self.layer_:pos(), deltaP))
					deltaP = cc.pMul(deltaP, 0.95)
				end
				self:checkCells()
			end}
		}
	}
end

--@brief 回弹
function cls:elasticScroll()
	local headSp = self.cellLst_[self.head_]
	local tailSp = self.cellLst_[self.tail_]
	if not self:isReachTop(headSp) then
		local top = self:getVisibleTop()
		local to = nil
		if self.isHorizontal_ then
			to = cc.p(self.layer_:x() - headSp:x() + top, self.layer_:y() )
		else
			to = cc.p(self.layer_:x(), self.layer_:y() + top - headSp:y() - headSp:height())
		end
		self.layer_:run{
			"rep", 
			{"seq",
				{"delay", 1/60},
				{"call", function()
					local dp = cc.pSub(to, self.layer_:pos())
					if cc.pGetLength(dp) < 3 then
						self.layer_:pos(to)
						self.layer_:stop()
						self:checkCells()
						if self.callback then
							self.callback({name=cls.ELASTIC_TOP_EVENT})
						end
					else
						self:checkCells()
						self.layer_:pos(cc.pAdd(self.layer_:pos(), cc.pMul(dp, 0.25)))
					end

				end}
			}
		}
	elseif not self:isReachBottom(tailSp) then
		local bottom = self:getVisibleBottom()
		local to = nil
		if self.isHorizontal_ then
			to = cc.p(self.layer_:x() + bottom - tailSp:x() - tailSp:width(), self.layer_:y())
		else
			to = cc.p(self.layer_:x(), self.layer_:y() + bottom - tailSp:y())
		end
		self.layer_:run{"rep", 
							{"seq",
								{"delay", 1/60},
								{"call", function()
									local headSp = self.cellLst_[self.head_]
									if not self:isReachTop(headSp) then -- 向上回弹
										local top = self:getVisibleTop()
										local to = nil
										if self.isHorizontal_ then
											to = cc.p(self.layer_:x() - headSp:x() + top, self.layer_:y() )
										else
											to = cc.p(self.layer_:x(), self.layer_:y() + top - headSp:y() - headSp:height())
										end
										self.layer_:pos(to)
										self.layer_:stop()
									else -- 向下回弹
										local dp = cc.pSub(to, self.layer_:pos())
										if cc.pGetLength(dp) < 3 then
											self.layer_:pos(to)
											self.layer_:stop()
											self:checkCells()
											if self.callback then
												self.callback({name=cls.ELASTIC_BOTTOM_EVENT})
											end
										else
											self.layer_:pos(cc.pAdd(self.layer_:pos(), cc.pMul(dp, 0.25)))
											self:checkCells()
										end
									end
								end}
							}}
	end
	if self.callback then
		self.callback({name = cls.ELASTIC_END})
	end
end

function cls:checkCells()
	-- 删除范围外的cell
	while self.cellLst_[self.head_] and 
		self:isOverTop(self.cellLst_[self.head_]) and  
		self.cellLst_[self.head_ + 1] do
		if self.isDynamicCreate then
			self.cellLst_[self.head_]:remove()
			self.cellLst_[self.head_] = nil
		end
		self.head_ = self.head_ + 1
	end

	while self.cellLst_[self.tail_] and self.cellLst_[self.tail_ - 1] 
		and self:isOverBottom(self.cellLst_[self.tail_]) do
		if self.isDynamicCreate then
			self.cellLst_[self.tail_]:remove()
			self.cellLst_[self.tail_] = nil
		end
		self.tail_ = self.tail_ - 1
	end

	-- 创建下方cell
	while self.data_[self.tail_ + 1] and 
		(self.cellLst_[self.tail_] and 
 		not self:isReachBottom(self.cellLst_[self.tail_]) or 
 		not self.cellLst_[self.tail_]) do
		local tmp = self.tail_ + 1
		if not self.cellLst_[tmp] then
			local val = self.data_[tmp]
			local sp = self:createCell(tmp, val)
			self:pushback(sp)
			self.tail_ = tmp
			self.cellLst_[self.tail_] = sp
		else
			self.tail_ = tmp
		end
	end
	-- 创建上方cell
	while self.data_[self.head_ - 1] and 
		(self.cellLst_[self.head_] and 
 		not self:isReachTop(self.cellLst_[self.head_]) or
		not self.cellLst_[self.head_]) do
		local tmp = self.head_ - 1
		if not self.cellLst_[tmp] then
			local val = self.data_[tmp]
			local sp = self:createCell(tmp, val)
			self:pushfront(sp)
			self.head_ = tmp
			self.cellLst_[self.head_] = sp
		else
			self.head_ = tmp
		end
	end

	self:updateScrollBar()
	if TEST_DEV then
		-- self:getCellCount()
	end

	if self.isTipsArrowEnabled then
		self:checkTipsArrow()
	end
end

function cls:checkTipsArrow()
	if self.isTipsArrowEnabled then
		if not self.preArrow then
			self:setTipsArrow()
			return
		end

		local boo1 = false
		local headSp = self.cellLst_[self.head_]
		if headSp then
			local visibleTop = self:getVisibleTop()
			local pos1 = headSp:pos()
			if self.isHorizontal_ then
				boo1 = pos1.x < visibleTop
			else
				boo1 = pos1.y + headSp:height() > visibleTop
			end
		end
		if boo1 or self.head_ > 1 then
			self.preArrow:show()
		else
			self.preArrow:hide()
		end

		local boo2 = false
		local tailSp = self.cellLst_[self.tail_]
		if tailSp then
			local visibleBottom = self:getVisibleBottom()
			local pos = tailSp:pos()
			if self.isHorizontal_ then
				boo2 = pos.x + tailSp:width() > visibleBottom
			else
				boo2 = pos.y < visibleBottom
			end
		end

		if boo2 or self.tail_ < #self.data_ then
			self.nxtArrow:show()
		else
			self.nxtArrow:hide()
		end

	end
end

--@brief 插入一条信息
--@param[isPush] 如果插入的位置是显示范围内, 
--默认把指定index之前的cell位置向前推，index之后的位置不变
function cls:insert(data, index, isPush)
	if isPush ~= false then
		isPush = true
	end 
	if not self.data_ or #self.data_ <= 0 then
		self:update({data})
		return
	end
	index = index or #self.data_ + 1
	index = math.max(1, math.min(index, #self.data_ + 1))
	self.layer_:stop()

	local insertPos = nil
	local cell = self:createCell(index, data)
	for i = #self.data_, 1, -1  do -- 必须逆序查找
		-- 调整已经创建了的cell的位置
		-- if isPush then
		if i < index and self.cellLst_[i] then--index之前的cell不处理
			if i == index - 1 then
				insertPos = self.cellLst_[i]:pos()
				if self.isHorizontal_ then
					insertPos.x = insertPos.x + cell:width()
				else
					insertPos.y = insertPos.y - cell:height()
				end
				cell:addTo(self.layer_)
				cell:pos(insertPos)
				self.cellLst_[index] = cell
			end
		elseif i >= index and self.cellLst_[i] then --index之后的cell向后移动
			local celli = self.cellLst_[i]
			local oldPos = self.cellLst_[i]:pos()
			local newPos = oldPos
			if self.isHorizontal_ then
				newPos = cc.p(cell:width() + oldPos.x, oldPos.y)
			else
				newPos = cc.p(oldPos.x, oldPos.y - cell:height())
			end
			celli:pos(newPos)
		end
		-- 调整index 之后的cell的索引
		if i >= index and self.cellLst_[i] then --index之后的cell索引向后移动
			self.cellLst_[i+1] = self.cellLst_[i]
			self.cellLst_[i] = nil
		end
 	end

 	if index <= self.tail_ then
 		self.tail_ = self.tail_ + 1
 	end
 	if index <= self.head_ then
 		self.head_ = self.head_ + 1
 	end

 	-- 有前或有后才可push
 	if isPush and (self.cellLst_[index - 1] or self.cellLst_[index + 1]) then
 		local pos = cell:pos()
		local visibleBottom = self:getVisibleBottom()
		local delta = 0
		if self.isHorizontal_ then
			if pos.x + cell:width() > visibleBottom then
				delta = pos.x - visibleBottom
			end
			self.layer_:setPositionX(self.layer_:x() - delta)
		else
			if pos.y < visibleBottom then
				delta = pos.y - visibleBottom
			end
			self.layer_:setPositionY(self.layer_:y() - delta)
		end
 	end

 	-- if insertPos then
		-- cell:addTo(self.layer_)
		-- cell:pos(insertPos)
		-- self.cellLst_[index] = cell
 	-- end
	table.insert(self.data_, index, data)

	self:checkCells()
	self:updateScrollBarSize()
end

-- 重新算一次容器里已有元素的位置
function cls:updatePos()
	local keys = table.keys(self.cellLst_)

	if self.isHorizontal_ then
		table.sort(keys, function(v1,v2)
			return v1 < v2
		end)
		local cell = self.cellLst_[keys[1]]
		local x1,y1 = cell:getPosition()

		for _,i in ipairs(keys) do
			cell = self.cellLst_[i]
			cell:setPosition(x1, y1)
			x1 = x1 + cell:width()
		end
	else
		table.sort(keys, function(v1,v2)
			return v1 > v2
		end)
		local cell = self.cellLst_[keys[1]]
		local x1,y1 = cell:getPosition()
		for _,i in ipairs(keys) do
			cell = self.cellLst_[i]
			cell:setPosition(x1, y1)
			y1 = y1 + cell:height()
		end
	end

	self:checkCells()
end

--@breif 删除单元
function cls:removeCell(index)
	if not index or index < 1 or index > #self.data_ then
		return
	end
	self.layer_:stop()
	local rmCell = self.cellLst_[index]
	self.cellLst_[index] = nil
	-- 指定位置index 之后的cell 往前移动
	for i = 1, #self.data_ do
		if i > index and self.cellLst_[i] then
			if rmCell then
				local oldPos = self.cellLst_[i]:pos()
				local newPos = oldPos
				if self.isHorizontal_ then
					newPos = cc.p(oldPos.x - rmCell:width(), oldPos.y)
				else
					newPos = cc.p(oldPos.x, oldPos.y + rmCell:height())
				end
				self.cellLst_[i]:pos(newPos)
			end
			--index之后的cell索引向前移动
			self.cellLst_[i-1] = self.cellLst_[i]
			self.cellLst_[i] = nil
		end
	end

	if index < self.head_ then
		self.head_ = self.head_ - 1
	end

	if index <= self.tail_ then
		self.tail_ = self.tail_ - 1
	end
	table.remove(self.data_, index)
	if rmCell then
		rmCell:remove()
	end

	-- 删除后填充满空白的区域
	local isFull = false
	local tailSp = self.cellLst_[self.tail_]
	if tailSp and
		self:isReachBottom(tailSp) then
		isFull = true
	end
	-- 向下创建cell
	while self.data_[self.tail_ + 1] and not isFull do
		local tmp = self.tail_ + 1
		local val = self.data_[tmp]
		local sp = self.cellLst_[tmp]
		if not sp then
			sp = self:createCell(tmp, val)
			self:pushback(sp)
		end

		self.tail_ = tmp
		self.cellLst_[self.tail_] = sp
		if self:isReachBottom(sp) then
			isFull = true
		end
	end

	-- 向上创建cell
	while self.data_[self.head_ - 1] and not isFull do
		local tmp = self.head_ - 1
		local val = self.data_[tmp]
		local sp = self.cellLst_[tmp]
		if not sp then
			sp = self:createCell(tmp, val)
		end
		local moveBy = cc.p(0, - sp:height())
		if self.isHorizontal_ then
			moveBy = cc.p(sp:width(), 0)
		end
		self.layer_:pos(cc.pAdd(self.layer_:pos(), moveBy))-- 移动一个位置
		local tailCell = self.cellLst_[self.tail_]
		if tailCell and self:isReachBottom(tailCell) then -- 移动后超出显示, 则还原
			self.layer_:pos(cc.pSub(self.layer_:pos(), moveBy))
			isFull = true
		else
			if not self.cellLst_[tmp] then
				self:pushfront(sp)
				self.cellLst_[tmp] = sp
			end
			self.head_ = tmp
		end
	end

	if not isFull and headSp then -- 移动layer填满可视范围
		local top = self:getVisibleTop()
		local moveBy = cc.p(0, top-headSp:y()-headSp:height())
		if self.isHorizontal_ then
			moveBy = cc.p(top-headSp:x(), 0)
		end
		self.layer_:pos(cc.pAdd(self.layer_:pos(), moveBy))
	end

	self:updateScrollBarSize()
end


--@brief 可视范围顶部
function cls:getVisibleTop()
	local selfTop = self.isHorizontal_ and self:convertToWorldSpace(cc.p(0, 0)) or self:convertToWorldSpace(cc.p(0, self:height()))
	local np = self.layer_:convertToNodeSpace(selfTop)
	return self.isHorizontal_ and np.x or np.y
end

--@brief 可视范围底部
function cls:getVisibleBottom()
	local selfBottom = self.isHorizontal_ and self:convertToWorldSpace(cc.p(self:width(), 0)) or self:convertToWorldSpace(cc.p(0, 0))
	local np = self.layer_:convertToNodeSpace(selfBottom)
	return self.isHorizontal_ and np.x or np.y
end

--@brief 每个cell长度
function cls:getCellLength(cell)
	return self.isHorizontal_ and cell:width() or cell:height()
end

--@brief
function cls:pushfront(cell)
	local headSp = self.cellLst_[self.head_]
	local pos = nil
	if not headSp then
		local visibleTop = self:getVisibleTop()
		pos = self.isHorizontal_ and cc.p(visibleTop, 0) or cc.p(0, visibleTop - cell:height())
	else
		pos = self.isHorizontal_ and cc.p(headSp:x() - cell:width(), 0) or cc.p(0, headSp:y() + headSp:height())
	end
	cell:addTo(self.layer_)
	cell:pos(pos)
end

function cls:pushback(cell)
	local tailSp = self.cellLst_[self.tail_]
	local pos = nil
	if not tailSp then
		local visibleTop = self:getVisibleTop()
		pos = self.isHorizontal_ and cc.p(visibleTop, 0) or cc.p(0, visibleTop - cell:height())
	else
		pos = self.isHorizontal_ and cc.p(tailSp:x() + tailSp:width(), 0) or cc.p(0, tailSp:y() - cell:height())
	end
	cell:addTo(self.layer_)
	cell:pos(pos)
end

function cls:isReachBottom(cell)
	if not cell then
		return true
	end
	local pos = cell:pos()
	local visibleBottom = self:getVisibleBottom()
	if self.isHorizontal_ then
		return pos.x + cell:width() >= visibleBottom
	else
		return pos.y <= visibleBottom
	end
end

function cls:isReachTop(cell)
	if not cell then
		return true
	end
	local pos = cell:pos()
	local visibleTop = self:getVisibleTop()
	if self.isHorizontal_ then
		return pos.x <= visibleTop
	else
		return pos.y + cell:height() >= visibleTop
	end
end

function cls:isOverBottom(cell)
	if not cell then
		return false
	end
	local pos = cell:pos()
	local visibleBottom = self:getVisibleBottom()
	if self.isHorizontal_ then
		return pos.x > visibleBottom
	else
		return pos.y + cell:height() < visibleBottom
	end
end

function cls:isOverTop(cell)
	if not cell then
		return false
	end
	local pos = cell:pos()
	local visibleTop = self:getVisibleTop()
	if self.isHorizontal_ then
		return pos.x + cell:width() < visibleTop
	else
		return pos.y > visibleTop
	end
end

function cls:selectedItem(index)
	if index < 0 or index > #self.data_ then
		return
	end

	for _, v in pairs(self.cellLst_) do
		if v.setStatus then
			v:setStatus(false)
		end
	end
	local v = self.cellLst_[index]
	if v and v.setStatus then
		v:setStatus(true)
	end

	self.selectedIndex = index
end

function cls:createCell(i, data)
	local cell = self.cell(i, data)
	if cell and cell.setStatus then
		if self.selectedIndex == i then
			cell:setStatus(true)
		else
			cell:setStatus(false)
		end
	end

	return cell
end

--@brief 开启滑动提示箭头
function cls:enableTipsArrow(boo)
	self.isTipsArrowEnabled = boo
	if self.isTipsArrowEnabled then
		self:checkTipsArrow()
	else
		if self.preArrow then
			self.nxtArrow:hide()
			self.preArrow:hide()
		end
	end
end

function cls:getItems()
	return self.cellLst_
end

function cls:getItem(index)
	return self.cellLst_[index]
end

function cls:getCellCount()
	local count = 0
	for _, v in pairs(self.cellLst_) do
		count = count + 1
	end
	local childLst = self.layer_:getChildren()
	local cCount = #childLst
	if cCount ~= count then
		local str = string.format("WARRNING*** 内存泄漏啦!!! c++ 引用 %d, lua 引用数 %d", cCount, count)
		print(str)
	end

	return count
end

-- 到最接近cell
function cls:getCloseCell(offset)
	local items = self:getItems()
	local index = nil
	local distance = nil
	for i,item in pairs(items) do
		local wp = item:convertToWorldSpace(cc.p(item:width()/2,item:height()/2))
		local np = self.layout:convertToNodeSpace(wp)
		local distanceY = math.abs(np.y - self:height() + offset)
		if not distance then
			index = i
			distance = distanceY
		elseif distanceY < distance then
			index = i
			distance = distanceY
		end
	end
	if index and distance then
		local item = self:getItem(index)
		local wp = item:convertToWorldSpace(cc.p(0,item:height()))
		local np = self.layer_:convertToNodeSpace(wp)
		self.layer_:pos(self.layer_:x(),self.layer_:y() + np.y - self:height())
		self:checkCells()
		self.layer_:stop()
		return index
	end
end

return cls