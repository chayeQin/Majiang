--
-- Author: lyt
-- Date: 2015-09-23 21:41:07
-- 数字键绑定
local cls = class("TableExtend")

-- 已经创建的类
local CSB_ITEM_CLASS = {}

-- 动态创建子项csb类型
local function createCsbClass(itemCsbName,csbBuidling)
	local itemClass = CSB_ITEM_CLASS[itemCsbName]
	if itemClass then
		return itemClass
	end

	itemClass = class(itemCsbName, cc.load("mvc").ViewBase)
	itemClass.RESOURCE_FILENAME = "csb/" .. itemCsbName .. ".csb"
	itemClass.RESOURCE_BINDING = csbBuidling
	CSB_ITEM_CLASS[itemCsbName] = itemClass

	return itemClass
end

function cls.bind(target,itemCsbName,csbBuidling)
	-- 窗器,子类件csb文件名
	function target:init(itemClass)
		self.itemClass = itemClass
		local layer = display.newLayer(cc.c4b(255,255,255,255))
		self:addChild(layer,100)
		local size = self:getContentSize()
		local item = self.itemClass.new()
		local itemSize = item:getResourceNode():getContentSize()
		self.x_ = 0
		self.y_ = 0
		self.w_ = size.width
		self.h_ = size.height
		self.layer_ = layer
		self.cellH_ = itemSize.height
		self.cellY_ = 0
		self.cellHY_ = self.cellH_ + self.cellY_
		self.lh_ = 100 -- 内容高度(临时设置)
		self.dmscale_ = 2	-- 滚动惯性，值越大。滚得越远

		self.tick_ = handler(self,self.updateTick)
		self.fantan_ = handler(self,self.fantanTick)
		self.tm_ = 0

		layer:onTouch(handler(self,self.onTouchHandler), false, true)
	end

	function target:setCellH(v)
		self.cellY_ = v or 0
		self.cellHY_ = self.cellH_ + self.cellY_
	end

	function target:setCellY(v)
		self.cellH_ = v or 0
		self.cellHY_ = self.cellH_ + self.cellY_
	end

	function target:onTouchHandler(event)
		local x = event.x
		local y = event.y
		if event.name == "began" then
			local parent = self
			while true do
				if not parent then
					break
				elseif parent:isVisible() then
					parent = parent:getParent()
				else
					return false
				end
			end
			self.layer_:stopAllActions()
			local p = self:convertToNodeSpace(cc.p(x,y))
			if p.x < self.x_ or 
				p.y < self.y_ or 
				p.x > self.x_ + self.w_ or 
				p.y > self.y_ + self.h_ then
				return false
			end
			self.tm_ = y
			self.tmGegan_ = self.tm_
			-- 判断点击
			p = self.layer_:convertToNodeSpace(cc.p(x,y))
			local arr = self.layer_:getChildren()
			if not arr or #arr == 0 or arr[1]:getNumberOfRunningActions() > 0 then
				return false
			end

			for i = #arr,1,-1 do
				local obj = arr[i]
				local px,py = obj:getPosition()
				if p.y >= py and p.y <= py + self.cellH_ then
					self:resetClickCell_()
					self.click_item = obj
					self.click_item_x = p.x - px
					self.click_item_y = p.y - py

					if obj.touchEffect ~= false then
						-- obj:setColor(COLOR)
					end
					break
				end
			end
			return true
		elseif event.name == "moved" then
			self.dm_ = y - self.tm_
			if math.abs(self.dm_) < 2 then
				return
			end
			self.tm_ = y
			local ey = self.layer_:getPositionY() + self.dm_
			if ey > 0 or ey < self.h_ - self.lh_ then
				self.dm_ = self.dm_ / 5
			end

			if self.click_item and math.abs(self.tmGegan_ - self.tm_) > 50 then
				self:resetClickCell_()
			end

			self:updateCells(self.dm_)
			return
		end

		-- 移动小于20则判断为点击
		if self.click_item then
			local item = self.click_item
			self:resetClickCell_()
			self.onPressed(item,self.click_item_x,self.click_item_y)
			-- sound:play("ui/1011")
			-- Tutorial.click(item)
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
			table.insert(arr, cc.CallFunc:create(self.fantan_))
			table.insert(arr, cc.DelayTime:create(1/60))
			self.layer_:runAction(cc.RepeatForever:create(cc.Sequence:create(arr)))
			return
		end

		-- 惯性
		if not self.dm_ then
			return
		end
		if math.abs(self.dm_) < 3 then
			return
		else
			self.dm_ = self.dm_ * self.dmscale_
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
		if self.click_item.touchEffect ~= false then
			-- self.click_item:setColor(nil)
		end
		self.click_item = nil
	end

	-- 更新数据
	function target:update(data,index)
		if not data then
			return
		end

		index = index or 1
		index = math.max(index,1)
		index = math.min(index,#data)

		self.click_item = nil
		self.data_ = data
		-- Layer高度
		self.lh_ = #data * self.cellH_ + (#data - 1) * self.cellY_
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
		self.cellList = {}

		if not self.isHideScrollBar then
			if self.scroll_sp then self.scroll_sp:remove() end
			if self.scroll_bg then self.scroll_bg:remove() end

			if self.lh_ > self.h_ then
				self.scroll_sp = Util:sprite9("ship_new/scroll_btn_01", 15, 15, 2, 2)
					:addTo(self,11)
					:pos(self.x_ + self.w_ - 4,0)
				local height = math.max(11,self.h_ / self.lh_ * self.h_)
				self.scroll_sp:size(cc.size(32, height))
				self.scroll_h = height

				self.scroll_bg = Util:sprite("ship_new/scroll_bar_bg_01")
					:addTo(self,10)
					:pos(self.x_ + self.w_ - 4,self.y_ + self.h_ / 2)
				self.scroll_bg:setScaleY(self.h_ / self.scroll_bg:height())
			else
				self.scroll_sp = nil
				self.scroll_bg = nil
			end
		end

		self:updateCells(0)
		for k,v in pairs(self.cellList) do
			self.action(k,v)
		end
	end

	-- 强烈建议隐藏时清空
	function target:clear()
		self.layer_:stopAllActions()
		self.layer_:removeAllChildren()
	end

	-- 反弹
	function target:fantanTick()
		local dy = self.to_y - self.layer_:getPositionY()
		if math.abs(dy) < 3 then
			self.layer_:setPositionY(self.to_y)
			self.layer_:stopAllActions()
			self:updateCells(0)
		else
			self:updateCells(dy / 5)
		end
	end

	-- 定时更新
	function target:updateTick()
		if not self.dm_ or math.abs(self.dm_) < 2 then
			self.layer_:stopAllActions()
			return
		end
		local y = self.layer_:getPositionY() + self.dm_
		if self.dm_ > 0 then
			if y > 0 then
				self.layer_:stopAllActions()
				self.layer_:setPositionY(0)
				self:updateCells(0)
				return
			end
		else
			local y2 = self.h_ - self.lh_
			if y < y2 then
				self.layer_:stopAllActions()
				self.layer_:setPositionY(y2)
				self:updateCells(0)
				return
			end
		end

		self:updateCells(self.dm_)

		self.dm_ = self.dm_ * 0.95
	end

	-- 每次更新位置
	function target:updateCells(dy)
		local y = self.layer_:getPositionY() + dy
		self.layer_:setPositionY(y)
		self:updateScroll()

		y = -y
		local top = y + self.h_
		local cy = 0
		if dy == 0 then
		elseif dy > 0 then
			for k,v in pairs(self.cellList) do
				cy = v:getPositionY()
				if cy > top then
					self.cellList[k] = nil
					v:remove()
				end
			end
		else
			for k,v in pairs(self.cellList) do
				cy = v:getPositionY()
				if cy + self.cellHY_ < y then
					self.cellList[k] = nil
					v:remove()
				end
			end
		end

		y = math.floor(y / self.cellHY_) * self.cellHY_
		top = -self.layer_:getPositionY() + self.h_

		y = math.max(y,0)
		top = math.max(top,0)
		for i = top,y,-self.cellHY_ do
			local j = math.floor(i / self.cellHY_)
			if not self.cellList[j] and j >= 0 and j < #self.data_ then
				local sp = self.itemClass.new():addTo(self.layer_)
				sp:align(display.LEFT_BOTTOM,0,j * self.cellHY_)
				sp.i_ = #self.data_ - j
				sp.data_ = self.data_[sp.i_]
				self.cell(sp,sp.i_,sp.data_)
				self.cellList[j] = sp
			end
		end
	end

	function target:updateScroll()
		if not self.scroll_sp then
			return
		end

		local y = -self.layer_:getPositionY()
		self.scroll_sp:setPositionY(self.y_ + y / (self.lh_ - self.h_) * (self.h_ - self.scroll_h) + self.scroll_h / 2)
	end

	-- 创建每行元素
	function target.cell(cell,i,data)
		print("****** 子类没重构Tabel:cell方法")
	end

	-- 默认左右飞入
	function target.action(i,cell)
	    local x = 500
	    if i % 2 == 1 then
	        x = -x
	    end

	    local y = cell:getPositionY()
	    cell:setPositionX(x)
	    cell:moveTo{time=0.2, x=0, y =y}
	end

	function target.onPressed(cell,x,y)
		print("****** 子类没重构Tabel:onPressed",cell.i_,x,y)
	end

	--通过id得到数据
	function target:getChooseInfo(id,ids,tb)
		tb = tb or "general"
	    local targetData,chooseData = nil,{}
	    for k,v in pairs(user[tb] ) do
	        if ids and target.find(ids, v.id) then
	            table.insert(chooseData, v)
	        elseif id == v.id then
	            targetData = v
	        end
	    end
	    return targetData,chooseData
	end

	function target:hideScrollBar()
		self.isHideScrollBar = true
		if self.scroll_sp then self.scroll_sp:setVisible(false) end
		if self.scroll_bg then self.scroll_bg:setVisible(false) end
	end

	target:init(createCsbClass(itemCsbName,csbBuidling))
end

return cls