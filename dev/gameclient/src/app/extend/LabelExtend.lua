--
-- Author: lyt
-- Date: 2017-05-18 21:10:22
-- Label对系统控件进行扩展
local cls = class("LabelExtend")

function cls:ctor()
end

function cls:exec(lab)
	if not TEST_DEV then
		return
	end
	
	-- 扩展用到的控件
	lab.extendList = {}
	lab.setString_ = lab.setString

	-- 清除所有控件
	lab.clearExtend = function(self)
		for k,v in ipairs(self.extendList) do
			v:remove()
		end

		self.extendList = {}
	end

	-- 描边
	lab.enableOutline = function(self, color, lineWidth)
		if not color then
			return
		end
		self:clearExtend()

		if lineWidth > 1 then
			lineWidth = lineWidth - 1
		end
		self.lineWidth = lineWidth

		local text   = self:getString()
		local size   = self:getSystemFontSize()
		local align  = self:getHorizontalAlignment()
		local valign = self:getVerticalAlignment()

		local labSize = self:getContentSize()
		local cx, cy = labSize.width / 2, labSize.height / 2
		self.extendList[1] = Util:systemLabel(text, size, color, self.dimensions, align, valign, false)
			:addTo(lab, -1)
			:pos(cx - lineWidth, cy - lineWidth)
		self.extendList[2] = Util:systemLabel(text, size, color, self.dimensions, align, valign, false)
			:addTo(lab, -1)
			:pos(cx + lineWidth, cy - lineWidth)
		self.extendList[3] = Util:systemLabel(text, size, color, self.dimensions, align, valign, false)
			:addTo(lab, -1)
			:pos(cx - lineWidth, cy + lineWidth)
		self.extendList[4] = Util:systemLabel(text, size, color, self.dimensions, align, valign, false)
			:addTo(lab, -1)
			:pos(cx + lineWidth, cy + lineWidth)

		lab.setString = function(self, v)
			self:setString_(v)

			if tolua.isnull(self.extendList[1]) then
				return
			end

			local labSize = self:getContentSize()
			local cx, cy = labSize.width / 2, labSize.height / 2
			self.extendList[1]:pos(cx - self.lineWidth, cy - self.lineWidth)
			self.extendList[2]:pos(cx + self.lineWidth, cy - self.lineWidth)
			self.extendList[3]:pos(cx - self.lineWidth, cy + self.lineWidth)
			self.extendList[4]:pos(cx + self.lineWidth, cy + self.lineWidth)
		end
	end
end

return cls