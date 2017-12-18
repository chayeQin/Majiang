--
-- @brief 滑动竖直效果
-- @author myc
-- @date 2016/3/18
--

local cls = class("SlideVertical")

-- listView 创建绑定
function cls.bind(target)
	-- listView重构，创建空白Layer
	-- @param[offset]	偏移量
	function target:init(width,height,offset)
		local size = self:getContentSize()
		local layer = display.newLayer(cc.c4b(255,255,255,255))
		self:addChild(layer,100)

		-- 初始化坐标
		self.x_ = 0
		self.y_ = 0
		self.w_ = size.width
		self.h_ = size.height
		self.layer_ = layer
		self.cellH_ = height or 0
		self.cellX_ = 0
		self.cellY_ = 0
		self.cellW_ = width or 0
		self.offset = offset or 0.5
		self.cellHY_ = self.cellH_ + self.cellY_
		self.maxScale = 1
		self.dmScale_ = 0.5	-- 滚动惯性，值越大。滚得越远
		self.minScale = 0.8
		self.maxScale = 1

		self.tick_ = handler(self,self.updateTick)
		self.fantan_ = handler(self,self.fantanTick)
		self.tm_ = 0
		self.touch = true
		layer:onTouch(handler(self,self.touchHandler),false,true)
	end

	function target:setCellY(v)
		self.cellY_ = v or 0
		self.cellHY_ = self.cellH_ + self.cellY_
	end

	function target:setEnabledTouch(boolean)
		self.touch = boolean
	end

	function target:touchHandler(event)
		local x = event.x
		local y = event.y
		local np = self:convertToNodeSpace(cc.p(x,y))
		if event.name == "began" then
			local param = self
			while true do
				if not parent then
					break
				elseif parent:isVisible() then
					parent = parent:getParent()
				else
					return false
				end
			end
			-- 判断触摸点是否在ListView内
			if np.x < self.x_ or
				np.y < self.y_ or
				np.x > self.x_ + self.w_ or
				np.y > self.y_ + self.h_ then
				return false
			end
			self.layer_:stopAllActions()
			self.tm_ = y
			self.tmBegan_ = self.tm_	-- 记录起始点
			-- 是否有cell
			local arr = self.layer_:getChildren()
			if not arr or #arr == 0 or arr[1]:getNumberOfRunningActions() > 0 then
				return false
			end
			-- 判断点击
			local p = self.layer_:convertToNodeSpace(cc.p(x,y))
			for i = #arr,1,-1 do
				local obj = arr[i]
				local px,py = obj:getPosition()
				if p.y >= py and p.y <= py + obj:height() then
					self:resetClickCell_()
					self.click_item = obj
					self.click_item_x = p.x - px
					self.click_item_y = p.y - py
					break
				end
			end
			return true and self.touch == true
		elseif event.name == "moved" then
			self.dm_ = y - self.tm_
			if math.abs(self.dm_) < 2 then
				return
			end
			self.tm_ = y
			local ey = self.layer_:getPositionY() + self.dm_

			-- 是否到达顶部or底部
			if ey > 0 or ey < self.h_ - self.lh_ then
				self.dm_ = self.dm_ / 5
			end

			-- 重设被点击对象
			if self.click_item and math.abs(self.tmBegan_ - self.tm_) > 50 then
				self:resetClickCell_()
			end

			self:updateCells(self.dm_)
			return
		end

		-- 移动小于50则判断为点击
		if self.click_item then
			local item = self.click_item
			self:resetClickCell_()
			self.onPressed(item,self.click_item_x,self.click_item_y)
			return
		end

		-- 反弹
		local ft = false
		local y = self.layer_:getPositionY()
		if y > 0 then
			y = 0
			self.to_y = 0
			ft = true
		end

		local y2 = self.h_ - self.lh_
		if y < y2 then
			self.to_y = y2
			ft = true
		end

		if ft then
			local arr = {}
			table.insert(arr,cc.CallFunc:create(self.fantan_))
			table.insert(arr,cc.DelayTime:create(1/60))
			self.layer_:runAction(cc.RepeatForever:create(cc.Sequence:create(arr)))
			return
		end

		-- 惯性
		if not self.dm_ then
			return
		end
		if math.abs(self.dm_) < 2 then
			self:slideToCloseItem()
			return
		else
			-- 惯性计算
			self.dm_ = self.dm_ * self.dmScale_
			local slideY = 0
			local time = 0
			local dm = clone(self.dm_)
			while math.abs(dm) >= 2 do
				time = time + 1
				slideY = slideY + dm
				dm = dm * 0.9
			end
			if math.abs(slideY) < 2 then
				self:slideToCloseItem()
				return
			end
			-- 最终停止位置
			local finalY = self.layer_:getPositionY() + slideY
			if finalY > 0 or finalY < self.h_ - self.lh_ then
				-- 到边缘，不做动作
			else
				local index = #self.data_ - math.floor(math.abs(finalY / self.cellHY_))
				local temFinalY = -(#self.data_ - index) * self.cellHY_
				-- -- 反推算出self.dm_
				local coefficient = 1
				for i = 1,time do
					coefficient = coefficient + 1 * math.pow(0.9,i)
				end
				self.dm_ = (temFinalY - self.layer_:getPositionY() - dm)/ (coefficient)
			end
		end

		local arr = {}
		table.insert(arr, cc.CallFunc:create(self.tick_))
		table.insert(arr, cc.DelayTime:create(1/60))
		self.layer_:runAction(cc.RepeatForever:create(cc.Sequence:create(arr)))
	end

	-- 清除点击控件
	function target:resetClickCell_()
		if not self.click_item then return end
		if not self.click_item.pos then
			self.click_item = nil
			return
		end
		self.click_item = nil
	end

	-- 强烈建议隐藏时清空
	function target:clear()
		self.layer_:stopAllActions()
		self.layer_:removeAllChildren()
	end

		-- 反弹
	function target:fantanTick()
		local dy = self.to_y - self.layer_:getPositionY()
		if math.abs(dy) < 5 then
			self.layer_:setPositionY(self.to_y)
			self.layer_:stopAllActions()
			self:updateCells(0)
			self:slideToCloseItem()
		else
			self:updateCells(dy / 5)
		end
	end

	-- 定时更新
	function target:updateTick()
		if not self.dm_ or math.abs(self.dm_) < 2 then
			self.layer_:stopAllActions()
			self:slideToCloseItem()
			return
		end
		local y = self.layer_:getPositionY() + self.dm_
		if self.dm_ > 0 then
			if y > 0 then
				self.layer_:stopAllActions()
				self.layer_:setPositionY(0)
				self.onPressed(self.cellList[#self.data_],0,0)
				self:updateCells(0)
				return
			end
		else
			local y2 = self.h_ - self.lh_
			if y < y2 then
				self.layer_:stopAllActions()
				self.layer_:setPositionY(y2)
				self.onPressed(self.cellList[1],0,0)
				self:updateCells(0)
				return
			end
		end

		self:updateCells(self.dm_)

		self.dm_ = self.dm_ * 0.9
	end

	-- @brief 更新数据
	function target:update(data,index)
		self:clear()
		if not data or #data <= 0 then
			return
		end

		index = index or 1
		index = math.max(index,1)
		index = math.min(index,#data)

		self.click_item = nil
		self.data_ = data

		self.cellList = {}
		-- Layer高度
		self.lh_ = #data * self.cellH_ + (#data - 1) * self.cellY_ + self.h_ - self.cellHY_
		self.layer_:stopAllActions()
		self.layer_:removeAllChildren()
		local y = 0
		if self.lh_ < self.h_ then
			y = self.h_ - self.lh_
		else
			y = (index - 1) * self.cellHY_ + self.h_ - self.lh_
			if y > 0 then
				y = 0
			end
		end
		self.layer_:setPositionY(y)
		self:updateCells(0)

	end

	-- 每次更新位置
	function target:updateCells(dy)
		local y = self.layer_:getPositionY() + dy
		self.layer_:setPositionY(y)

		y = math.abs(y)
		local top = y + self.h_
		local bottom = y
		local cy = 0
		for k,v in pairs(self.cellList) do
			local cy = v:getPositionY()
			if cy > top then
				self.cellList[k] = nil
				v:remove()
			elseif cy + self.cellHY_ < y then
				self.cellList[k] = nil
				v:remove()
			end
		end

		-- 偏移量
		local offsetY = self.h_ * self.offset
		local top = math.min(self.lh_,y + self.h_ - offsetY)
		local bottom = y - offsetY
		local max = math.ceil(top / self.cellHY_) --+ 1
		local min = math.ceil(bottom / self.cellHY_) + 1
		for j = min,max do
			local index = #self.data_ + 1 - j
			if not self.cellList[index] and index > 0 and index <= #self.data_ then
				local sp = self.cell(index,self.data_[index])
				sp:addTo(self.layer_)
				sp:align(display.LEFT_BOTTOM,0,(j - 1) * self.cellHY_ + offsetY - self.cellHY_ / 2)
				sp.i_ = index
				sp.data_ = self.data_[index]
				self.cellList[index] = sp
			elseif index <= 0 or index > #self.data_ then
				if index <= math.floor(-offsetY / self.cellHY_) + 1 or
				index >= math.floor(offsetY / self.cellHY_) + 1 + #self.data_ then
				elseif self.insertEmpty and not self.cellList[index] then
					local sp = self.insertEmpty(index)
					sp:addTo(self.layer_)
					sp:align(display.LEFT_BOTTOM,0,(j - 1) * self.cellHY_ + offsetY - self.cellHY_ / 2)
					self.cellList[index] = sp
				end
			end
		end
		self:sliding(self.layer_:getPositionY())
		self.slidingEvent(dy)
	end

	-- 设置最大scale
	function target:setMaxScale(v)
		self.maxScale = v or self.maxScale
	end

	-- 设置最小scale
	function target:setMinScale(v)
		self.minScale = v or self.minScale
	end

	-- 创建每行元素
	function target.cell(cell,i,data)
		print("****** 子类没重构Tabel:cell方法")
	end

	-- 点击这一行
	function target.onPressed(cell,x,y)
		print("****** 子类没重构Tabel:onPressed",cell.i_,x,y)
	end

	-- 创建空白
	function target.insertEmpty(cell,x,y)
		print("****** 子类没重构Tabel:insertEmpty")
	end

	-- 滑动结束
	function target.slideEndEvent(cell,x,y)
		print("****** 子类没重构Tabel:slideEndEvent")
	end

	-- 滑动中
	function target.slidingEvent()
		print("****** 子类没重构Tabel:slidingEvent")
	end

	-- 滑动事件
	function target:sliding(y)
		local y = math.abs(y)
		local offsetY = y + self.h_ * self.offset
		local maxScale = self.maxScale
		local minScale = self.minScale
		local maxZorder = 100
		local minZorder = 1
		for _,cell in pairs(self.cellList) do
			local cellY = cell:getPositionY() + self.cellHY_ / 2
			local distance = math.abs(cellY - offsetY)
			local scale = maxScale - distance / (self.h_ * self.offset) * (maxScale - minScale)
			local zorder = maxZorder - distance / (self.h_ * self.offset) * (maxZorder - minZorder)
			cell:setLocalZOrder(zorder)
			local children = cell:getChildren()
			for i = 1,#children,1 do
				local obj = children[i]
				obj:setScale(scale)
			end
		end
	end

	-- 滑动到最近item
	function target:slideToCloseItem(index)
		local y = self.layer_:getPositionY()
		local offsetY = math.abs(y) + self.h_ * self.offset
		local minDistance = nil
		if not index then
			index = 0
			for i,cell in pairs(self.cellList) do
				local distance = math.abs(cell:getPositionY() + self.cellHY_ / 2 - offsetY)
				if not minDistance then
					index = i
					minDistance = distance
				elseif distance < minDistance then
					minDistance = distance
					index = i
				end
			end
		else
			minDistance = 0
		end
		if minDistance then
			local offsetY = self.h_ * self.offset
			local lastY = -(#self.data_ - index) * self.cellHY_
			self.layer_:run{
			"rep",
			{"seq",
				{"delay",1/60},
				{"call",function ()
				local distance = self.layer_:getPositionY() - lastY
				if math.abs(distance) > 5 then
					distance = distance * 0.8
					local y = distance + lastY
					self.layer_:setPositionY(y)
				else
					self.layer_:setPositionY(lastY)
					self.slideEndEvent(self.cellList[index],0,0)
					self.layer_:stopAllActions()
					return
				end
				self:updateCells(0)
			end}
			}
		}
		end
	end

end

return cls