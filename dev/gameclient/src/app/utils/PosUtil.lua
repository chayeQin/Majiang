--
-- Author: lyt
-- Date: 2017-01-09 17:46:10
-- 为坐标 LABEL增加点击事件
local cls = class("PosUtil")

function cls:ctor()
end

-- 为坐标标签增加点击
function cls:onTouch(lab, x, y)
	if not lab then 
		return
	end

	x = checknumber(x)
	y = checknumber(y)
	local size = lab:getContentSize()

	lab:onTouch(function(event)
		if event.name ~= "ended" then
			return true
		end

		local p = lab:convertToNodeSpace(cc.p(event.x, event.y))
		if p.x > 0 and p.y > 0 and p.x < size.width and p.y < size.height then
			ViewStack:clear()
			ViewStack:pop()
			WorldCtrl:jumpTo(y, x, true)
		end
	end)
end

return cls