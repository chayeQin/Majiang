--
-- @brief 
-- @author: qyp
-- @date: 2016/02/18
--

local cls = class("TestMap", cc.Node)

function cls:ctor()
	Util:button("button/button_close_01", handler(self, self.close))
		:addTo(self, 10, 10)
		:pos(display.width - 50, display.height - 50)
	Util:button("lang/btn", function()
		Util:event(Event.gameSwitch, "test.TestMap2")
	end, "swtich2")

		:addTo(self, 10, 10)
		:pos(300, 300)

	local mapInfo = require("app.views.test.TestMapObj")
	self.mapInfo = mapInfo
	local rowCount = mapInfo.mapSize[1]
	local colCount = mapInfo.mapSize[2]
	self.rowCount = rowCount
	self.colCount = colCount
	local blockWidth = mapInfo.blockSize[1]
	local blockHeight = mapInfo.blockSize[2]
	self.blockWidth = blockWidth
	self.blockHeight = blockHeight
	local width = colCount*blockWidth
	local height = rowCount*blockHeight

	local map = require("app.views.MapBase").new(width, height, nil, nil, handler(self, self.clickRhand))
												:addTo(self, 1)
	self.map = map



 	self:initMap()


	self.blockLayer = display.newNode()
	map:addLayer(self.blockLayer)
    for i = 0, rowCount do
        local y = i * blockHeight
        local drawNode = cc.DrawNode:create()
        drawNode:drawLine(cc.p(0, y), cc.p(width, y), cc.c4f(1,0,0,1))
        drawNode:addTo(self.blockLayer)
    end
    for i = 0, colCount do
        local x = i * blockWidth
        local drawNode = cc.DrawNode:create()
        drawNode:drawLine(cc.p(x, 0), cc.p(x, height), cc.c4f(1,0,0,1))
        drawNode:addTo(self.blockLayer)
    end

    self.blockInfo = {}
    for i = 1, colCount*rowCount do
		self.blockInfo[i] = 0
    end

    self.itemLst = {}

    self:initBlockInfo()
    self:createBlock()
end

function cls:updateUI()
	display.newLayer():size(display.width, display.height)
		:addTo(self, -1)
		:onTouch(function()
			return true 
		end, nil, true)
end

function cls:createBlock()
	for index, v in ipairs(self.blockInfo) do
		if v ~= 0 then
			local row, col = self:indexToRowCol(index)
			local pos = self:rcToXY(row, col)
			Util:label(v):addTo(self.blockLayer):pos(pos)
		end
	end


	for index, imgId in pairs(self.itemLst) do
		local row, col = self:indexToRowCol(index)
		local pos = self:rcToXY(row, col)
		local imgPath = "testMapRes/"..imgId
		if Util:exists(Util:path(imgPath)) then
			Util:sprite(imgPath)
				:addTo(self.blockLayer)
				:anchor(0, 0)
				:pos(pos.x - self.blockWidth/2, pos.y - self.blockHeight/2)
		end
	end
end

function cls:initMap()
	local layer1 = display.newNode()
	local x = 0
	local mapWidth = 0
	local mapHeight = 0
	for i = 1, 5 do
		local sp = Util:jpg("planet/1_0"..i)
						:anchor(0, 0)
						:addTo(layer1)
						:x(x)
		x = x + sp:width()
		mapWidth = mapWidth + sp:width()
		mapHeight = sp:height()
	end
		for i = 1, 5 do
		local sp = Util:jpg("planet/1_0"..i)
						:anchor(0, 0)
						:addTo(layer1)
						:x(x)
		x = x + sp:width()
		mapWidth = mapWidth + sp:width()
		mapHeight = sp:height()
	end
		for i = 1, 5 do
		local sp = Util:jpg("planet/1_0"..i)
						:anchor(0, 0)
						:addTo(layer1)
						:x(x)
		x = x + sp:width()
		mapWidth = mapWidth + sp:width()
		mapHeight = sp:height()
	end
	self.map:size(mapWidth, mapHeight)
	self.map:addLayer(layer1, 1, cc.p(0.5,0.5), cc.p(0, 0))
	self.map:addLayer(Util:sprite("planet/3"):anchor(0, 1), 2, cc.p(1.23, 1.41), cc.p(109, 589))
	self.map:addLayer(Util:sprite("planet/4"):anchor(0, 1), 2, cc.p(1.23, 1.41), cc.p(1025, 892))
	self.map:addLayer(Util:sprite("planet/5"):anchor(0, 1), 2, cc.p(1.23, 1.41), cc.p(314, 912))
	self.map:addLayer(Util:sprite("planet/6"):anchor(0, 1), 2, cc.p(1.47, 1.83), cc.p(55, 670))
	self.map:addLayer(Util:sprite("planet/7"):anchor(0, 1), 2, cc.p(1.71, 2.25), cc.p(66, 564))
	self.map:addLayer(Util:sprite("planet/8"):anchor(0, 1), 2, cc.p(1.47, 1.83), cc.p(890, 486))
	self.map:addLayer(Util:sprite("planet/9"):anchor(0, 1), 2, cc.p(3, 2.25), cc.p(900, 573))
end


function cls:initBlockInfo()
	local function randItemPos(blockKey, blockSize)
		local randPos = 0
		local index = 0
		local retryCount = 0
		while index == 0 and retryCount < self.rowCount*self.colCount do
			local placeAry = {}
			index = math.random(1, #self.blockInfo)
			table.insert(placeAry, index)
			if self.blockInfo[index] ~= 0 then
				index = 0
			elseif blockSize > 1 then
				local row, col = self:indexToRowCol(index)
				for i = row, row+blockSize-1 do
					for j = col, col+blockSize-1 do
						if i > self.rowCount or j > self.colCount then
							index = 0 
							break
						end
						local tmpIndex = self:rowColToIndex(i, j)
						table.insert(placeAry, tmpIndex)
						if self.blockInfo[tmpIndex] ~= 0 then
							index = 0
							break
						end
					end
				end
			end

			if index ~= 0 then
				for i, v in ipairs(placeAry) do
					self.blockInfo[v] = blockKey
				end
				self.itemLst[index] = blockKey
			end

			retryCount = retryCount + 1
		end

		if retryCount >= self.rowCount*self.colCount then
			print("无法随机到目标位置", blockKey)
			return -1
		end
	end


	local randCount = 0
	for key, val in ipairs(self.mapInfo) do
		if type(key) == "number" then
			for i = 1, val[2] do
				local ret = randItemPos(key, val[1])
				randCount = randCount + 1
				if ret == -1 then
					print("randCount", randCount)
					return
				end
			end
		end
	end

end

function cls:rowColToIndex(row, col)
	return (row-1)*self.colCount + col
end

function cls:indexToRowCol(index)
	index = index-1
	local row = math.floor(index / self.colCount) + 1
	local col = index % self.colCount + 1
	return row, col
end

--@brief 转换行列变坐标
function cls:rcToXY(row, col)
	return {y = row*self.blockHeight - self.blockHeight/2, x=col*self.blockWidth - self.blockWidth/2}
end

--@brief 行列转坐标
function cls:xyToRC(x, y)
	return {row = math.floor(y/self.blockHeight) + 1, col = math.floor(x/self.blockWidth) + 1}
end

function cls:clickRhand(pos)
	dump(self:xyToRC(pos.x, pos.y), "click cell")
	self.map:focusTo(pos)
end

function cls:close()
	Util:event(Event.gameSwitch, "test.TestSelectView")
end

return cls
