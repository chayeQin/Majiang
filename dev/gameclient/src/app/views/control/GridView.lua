--
-- @brief 网格容器
-- @author: qyp
-- @date: 2017/02/06
--

--[[ 纵向
1,2,3
4,5,6
]]
--[[ 横向
1,4
2,5
3,6
]]
local cls = class("GridView", function(width, height)
	return display.newLayer():size(width, height) --cc.c4b(255, 255, 255, 125)
end)


local EMPTY_TAG = "__EMPTY__"
cls.EMPTY_TAG = EMPTY_TAG
cls.ELASTIC_TOP_EVENT = 1
cls.ELASTIC_BOTTOM_EVENT  = 2
cls.SCROLL_EVENT = 3
cls.MOVED_EVENT = 4
cls.SELECT_START_EVENT = 5
cls.SELECT_END_EVENT = 6 -- callback 参数 event = {name(事件类型), target(点击对象), index, pos(点击的世界坐标)}

--@brief 绑定指定界面。 placeHolder为在cocostudio的占位容器， 用来设置listView的位置与大小
function cls.bind(view, placeHolder, isHorizontal)
	local grid = GridView.new(placeHolder:width(), placeHolder:height(), isHorizontal)
							:addTo(placeHolder)
	if view.cell then
		grid.cell = handler(view, view.cell)
	end
	if view.emptyCell then
		grid.emptyCell = function(row, col)
			local node = view:emptyCell(row, col)
			node.isEmpty_ = true
			return node
		end
	end
	if view.onGridViewEvent then
		grid.callback = handler(view, view.onGridViewEvent)
	end
	return grid
end

function cls:ctor(width, height, isHorizontal, callback)
	local layout = ccui.Layout:create():size(width, height)
				:addTo(self)
	layout:setClippingEnabled(true)
	layout:setClippingType(1)
	self.layout = layout
	self.layer_ = ccui.Widget:create()
						:addTo(self.layout)
	self.isHorizontal_ = isHorizontal
	self.callback_ = callback
	self.data_ = {}
	self.cellMap_= {}
	self.selectedIndex = -1
	self.isDragSlow = true
	self.isDynamicCreate = true -- 是否动态创建
	self:onTouch(handler(self, self.onTouchHandler), nil, true)
end

-- 下标从(1,1) 开始
function cls:update(dataLst, colCount, minRowCount, index)
	index = index or 1
	self.data_ = clone(dataLst)
	for row, m in pairs(self.cellMap_) do
		for col, v in pairs(m) do
			v:remove()
		end
	end
	self.cellMap_= {}
	self.maxCol_ = colCount
	self.minRowCount = minRowCount or 0
	local tmp = self.emptyCell(1,1)
	self.cellHeight_ = tmp:height()
	self.cellWidth_ = tmp:width()

	if self.isHorizontal_ then
		self.maxCol_ = self.maxCol_ or math.ceil(self:height() / self.cellHeight_)
		self.layer_:pos(0, 0)
		local focusRow = math.ceil(index/ self.maxCol_)
		self:fillEmptyData()
		local x = -(focusRow-1)* self.cellWidth_ 
		x = math.max(x, self:width() - self.totalLength_)
		self.layer_:anchor(x, 0)
	else
		self.maxCol_ = self.maxCol_ or math.ceil(self:width() / self.cellWidth_)
		self.layer_:anchor(0, 1)
		local focusRow = math.ceil(index/ self.maxCol_)
		self:fillEmptyData()
		local y = self:height() + (focusRow-1)*self.cellHeight_
		y = math.min(y, self.totalLength_)
		self.layer_:pos(0, y)
	end
	
	self:checkCells()
end

function cls:insertCell(index, data)
	index = index or #self.data_ + 1
	index = math.max(1, math.min(index, #self.data_ + 1))
	self.layer_:stop()
	local row = math.ceil(index /self.maxCol_)
	local col = (index-1) % self.maxCol_+1

	for tmpRow = self.maxRow_, row, -1 do
		for tmpCol = self.maxCol_, 1, -1  do
			if self.cellMap_[tmpRow] and
				self.cellMap_[tmpRow][tmpCol] then
				local tmpIndex = (tmpRow-1) * self.maxCol_ + tmpCol
				if tmpIndex >= index then -- 插入位置以后的cell后移
					local sp = self.cellMap_[tmpRow][tmpCol]
					if tmpCol == self.maxCol_ then
						self:setCellPos(tmpRow+1, 1, sp)
						self.cellMap_[tmpRow+1] = self.cellMap_[tmpRow+1] or {}
						self.cellMap_[tmpRow+1][1] = sp
					else
						self:setCellPos(tmpRow, tmpCol+1, sp)
						self.cellMap_[tmpRow][tmpCol+1] = sp
					end

					self.cellMap_[tmpRow][tmpCol] = nil
					if tmpIndex == index then
						local sp = nil
						if not data then
							sp = self.emptyCell(row, col)
						else
							sp = self.cell(row, col, data)
						end
						sp:addTo(self.layer_, 2)
						self:setCellPos(tmpRow, tmpCol, sp)
						self.cellMap_[tmpRow][tmpCol] = sp
						break
					end
				end
			end
		end
	end
	if not data then
		table.insert(self.data_, index, EMPTY_TAG)
	else
		table.insert(self.data_, index, data)
	end
	self:fillEmptyData()

	if self.isEnabledSelected and
		index <= self.selectedIndex then
		self:updateSelectedImgPos(self.selectedIndex + 1)
	end
end

function cls:removeCell(index)
	if not index or index < 1 or index > #self.data_ then
		return
	end
	self.layer_:stop()
	local row = math.ceil(index /self.maxCol_)
	local col = (index-1) % self.maxCol_+1
	local rmCell = nil 
	if self.cellMap_[row] and
		self.cellMap_[row][col] then
		rmCell = self.cellMap_[row][col]
		rmCell:remove()
		self.cellMap_[row][col] = nil
	end

	table.remove(self.data_, index)
	print("***remove cell ", index, self.selectedIndex)
	if self.isEnabledSelected then
		if index < self.selectedIndex then
			self:selectedItem(self.selectedIndex - 1)
		elseif index == self.selectedIndex then
			if self.data_[self.selectedIndex] and
				self.data_[self.selectedIndex] ~= EMPTY_TAG then
				self:selectedItem(self.selectedIndex)
			elseif self.data_[self.selectedIndex-1] and
				self.data_[self.selectedIndex-1] ~= EMPTY_TAG then
				self:selectedItem(self.selectedIndex - 1)
			else
				print("****empty****")
				self:selectedItem(- 1)
			end
		end
	end

	-- 调整位置
	for tmpRow = row, self.maxRow_ do
		for tmpCol = 1, self.maxCol_ do
			local tmpIndex = (tmpRow-1) * self.maxCol_ + tmpCol
			if tmpIndex > index then
				if self.cellMap_[tmpRow] and
					self.cellMap_[tmpRow][tmpCol] then
					local sp = self.cellMap_[tmpRow][tmpCol]
					if tmpCol == 1 then
						local newRow = tmpRow-1
						local newCol = self.maxCol_
						if not self.cellMap_[newRow] then
							sp:remove()
						else
							self:setCellPos(newRow, newCol, sp)
							self.cellMap_[newRow][newCol] = sp
						end
					else
						self:setCellPos(tmpRow, tmpCol-1, sp)
						self.cellMap_[tmpRow][tmpCol-1] = sp
					end
					self.cellMap_[tmpRow][tmpCol] = nil
				end
			end
		end
	end
	self:fillEmptyData()

	if self.cellMap_[row] and #self.cellMap_[row] == 0 then
		self.cellMap_[row] = nil
	end

	self:checkCells()
end

function cls:fillEmptyData()
	local maxRow = math.ceil(#self.data_ / self.maxCol_)
	maxRow = math.max(maxRow, self.minRowCount)
	self.maxRow_ = maxRow
	local maxCount = maxRow * self.maxCol_
	if #self.data_ < maxCount then
		local start = #self.data_ + 1
		for i = start, maxCount do
			table.insert(self.data_, EMPTY_TAG)
		end
	end
	self:updateTotalLength()
end

function cls:updateTotalLength()
	if self.isHorizontal_ then
		self.totalLength_ = self.cellHeight_*self.maxRow_
		self.totalLength_ = math.max(self.totalLength_, self:width())
	else
		self.totalLength_ = self.cellHeight_*self.maxRow_
		self.totalLength_ = math.max(self.totalLength_, self:height())
	end
end


function cls:setCellPos(row, col, sp)
	if self.isHorizontal_ then
		local x = (row-1)* self.cellWidth_
		local y = self:height() - col * self.cellHeight_
		sp:pos(x, y)
	else
		local x = (col-1) * self.cellWidth_
		local y = -row*self.cellHeight_
		sp:pos(x, y)
	end
end

function cls.cell(row, col, data)
	print("cell", row, col)
	local sp = Util:sprite("ui/cd_jindutiao_35"):anchor(0, 0)
	Util:label(row .. "," .. col)
		:addTo(sp)
		:pos(sp:width()/2, sp:height()/2)
	return sp
end

function cls.emptyCell(row, col)
	local sp = Util:sprite("ui/cd_jindutiao_36"):anchor(0, 0)
	Util:label(row .. "," .. col)
		:addTo(sp)
		:pos(sp:width()/2, sp:height()/2)
	return sp
end

function cls:checkCells()
	local fromRow = 1
	local toRow = self.maxRow_
	if self.isHorizontal_ then
		local minX = -self.layer_:x()
		local maxX = minX + self:width()
		fromRow = math.floor(minX/self.cellHeight_) + 1
		toRow = math.floor(maxX/self.cellHeight_) + 1
	else
		local minY = self.layer_:y() - self:height()
		local maxY = minY + self:height()
		fromRow = math.floor(minY/self.cellHeight_) + 1
		toRow = math.floor(maxY/self.cellHeight_) + 1
	end
	
	fromRow = math.max(fromRow, 1)
	toRow = math.min(self.maxRow_, toRow)

	for row, m in pairs(self.cellMap_) do
		if self.isDynamicCreate and 
			(row < fromRow or row > toRow) then -- 删除可视范围外的单元
			for col, v in pairs(m) do
				v:remove()
			end
			self.cellMap_[row] = nil
		end
	end

	for row = fromRow, toRow do
		local tmp = self.cellMap_[row] or {}
		for col = 1, self.maxCol_ do
			local index = (row-1) * self.maxCol_ + col
			local val = self.data_[index]
			if not tmp[col] and val then
				local sp = nil
				if val == "__EMPTY__" then
					sp = self.emptyCell(row, col)
				else
					sp = self.cell(row, col, val)
				end
				sp:addTo(self.layer_, 2)
				self:setCellPos(row, col, sp)
				self.cellMap_[row] = self.cellMap_[row] or {}
				self.cellMap_[row][col] = sp
			end
		end
	end
end

function cls:onTouchHandler(event)
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
			self.clickedItem, self.tmpClickedIndex = self:checkClickCell(event.x, event.y)
			if self.clickedItem and self.clickedItem.isEmpty_ then
				self.clickedItem = nil
			end

			if self.clickedItem then
				if self.callback then
					self.callback({name=cls.SELECT_START_EVENT, target=self.clickedItem, index=self.tmpClickedIndex, pos=cc.p(event.x, event.y)})
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
			self:dragLayer(event, self.lastP)
			self:checkCells()
		end
		self.lastP = event
	elseif event.name == "ended" then
		if self.isDrag then
			if self:isOverBottom() or self:isOverTop() then
				self:elasticScroll()
			else
				self:inertiaScroll()
			end
		else
			if self.clickedItem and not self.clickedItem.isEmpty_ then
				self:selectedItem(self.tmpClickedIndex, cc.p(event.x, event.y))
				self.clickedItem = nil
			end
		end
	end
end

function cls:checkClickCell(x, y)
	for row, m in pairs(self.cellMap_) do
		for col, v in pairs(m) do
			local np = v:convertToNodeSpace(cc.p(x, y))
			local rect = cc.rect(0, 0, v:width(), v:height())
			if cc.rectContainsPoint(rect, np) then
				local index = (row-1) * self.maxCol_ + col
				return v, index
			end
		end
	end
end

function cls:selectedItem(index, pos)
	pos = pos or cc.p(0, 0)
	self.selectedIndex = index
	if self.callback then
		self.callback({name=cls.SELECT_END_EVENT, target=self.clickedItem, index=index, pos=pos})
	end

	if not self.isEnabledSelected or not self.selectedImg then
		return
	end
	self:updateSelectedImgPos(index)
end

function cls:enabledSelected(boo)
	if boo then
		if self.selectedImg then
			self.selectedImg:show()
		end
		self:selectedItem(1)
	elseif self.selectedImg then
		self.selectedImg:hide()
	end
	self.isEnabledSelected = boo
end

function cls:setSelectedImg(sp, isBelow)
	if self.selectedImg then
		self.selectedImg:remove()
	end
	if sp and not tolua.isnull(sp) then
		self.selectedImg = sp
		local zorder = 3
		if isBelow then
			zorder = 1
		end
		sp:addTo(self.layer_, zorder)
		self:enabledSelected(true)
		self:selectedItem(1)
	end
end

function cls:updateSelectedImgPos(index)
	if not self.selectedImg then
		return
	end
	if index < 0 or index > #self.data_ or self.data_[index] == cls.EMPTY_TAG then
		self.selectedImg:hide()
		return
	end

	self.selectedImg:show()
	local row = math.ceil(index/ self.maxCol_)
	local col = (index-1) % self.maxCol_+1
	print("***row, col", index, row, col)
	if self.isHorizontal_ then
		local x = (row-1)* self.cellWidth_ 
		local y = self:height() - col * self.cellHeight_ 
		self.selectedImg:pos(x + self.cellWidth_/2, y + self.cellHeight_/2)
	else
		local x = (col-1) * self.cellWidth_ 
		local y = -row*self.cellHeight_
		self.selectedImg:pos(x + self.cellWidth_/2, y + self.cellHeight_/2)
	end
	
end


function cls:isOverTop()
	if self.isHorizontal_ then
		local maxX = 0
		if self.layer_:x() > maxX then
			return true
		end
	else
		local minY = self:height()
		if self.layer_:y() < minY then
			return true
		end
	end
	return false
end

function cls:isOverBottom()
	if self.isHorizontal_ then
		local minX = self:width() - self.totalLength_
		if self.layer_:x() < minX then
			return true
		end
	else
		local maxY = self.totalLength_ 
		if self.layer_:y() > maxY then
			return true
		end
	end
	return false

end

function cls:getSelectedData()
	return self.data_[self.selectedIndex]
end

function cls:dragLayer(newP, lastP)
	local deltaP = cc.pSub(newP, lastP)
	if self.isHorizontal_ then
		local x = self.layer_:getPositionX() + deltaP.x
		if x > 0 then
			if self.isDragSlow then
				x = self.layer_:getPositionX() + deltaP.x * 0.2
			else
				x = 0
			end
		else
			local bottom = self:width() - self.totalLength_
			if x < bottom then
				if self.isDragSlow then
					x = self.layer_:getPositionX() + deltaP.x * 0.2
				else
					x = bottom
				end
			end
		end
		self.layer_:setPositionX(x)
	else
		local y = self.layer_:getPositionY() + deltaP.y
		local maxY = self.totalLength_
		if maxY < y then
			if self.isDragSlow then
				y = self.layer_:getPositionY() + deltaP.y * 0.2
			else
				y = maxY
			end
		end

		local minY =  self:height()
		if y < minY then
			if self.isDragSlow then
				y = self.layer_:getPositionY() + deltaP.y * 0.2
			else
				y = minY
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
				if self:isOverBottom() or self:isOverTop() then	
					self.layer_:stop()
					self:elasticScroll()
					return
				end
				if cc.pGetLength(deltaP) < 3 then
					self.layer_:stop()
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
	if self:isOverTop() then
		local to = nil
		if self.isHorizontal_ then
			to = cc.p(0, 0)
		else
			to = cc.p(0, self:height())
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
	elseif self:isOverBottom() then
		local to = nil
		if self.isHorizontal_ then
			to = cc.p(self:width()-self.totalLength_, 0)
		else
			to = cc.p(0, self.totalLength_)
		end
		self.layer_:run{"rep", 
							{"seq",
								{"delay", 1/60},
								{"call", function()
									 -- 向下回弹
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
								end}
							}}
	end
end

return cls