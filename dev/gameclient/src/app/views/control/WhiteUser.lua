--
-- @brief 白名单界面
-- @author: qyp
-- @date: 2016/01/11
--
local cls = class("WhiteUser", function()
    return display.newLayer(Const.LayerColor)
			:size(display.width,display.height)
end)

function cls:ctor()
	Util:touchLayer(self)

	Util:button("com/com_btn_create", function()
			PopupManager:popView(self)
		end, "确定")
		:addTo(self)
		:pos(display.width/2, 100)
		:setTitleFontName(nil)
	

	local data={
		{name="关闭新手引导",value=-1,paramName="TEST_TUTORIAL"},
		{name="关闭剧情引导",value=-1,paramName="TEST_STRONG_TUTORIAL"},
		-- {name="功能全开",value=true,paramName="TEST_UNLOCK"},
		{name="输出DEBUG",paramName=handler(self,self.enablePrint)},
	}

	local width = 360
	local tbl = ListView.new(width, 500)
					:addTo(self)
					:pos((display.width-width)/2, 120)
	tbl.cell = handler(self, self.cell)

	tbl:update(data)
	self:size(display.width, display.height)

	self:onTouch(handler(self, self.touchHandler))
	PopupManager:push(self)
end

function cls:cell(i,data)
	local sp = ccui.Widget:create():size(360, 50):anchor(0, 0)
	local check = ccui.CheckBox:create(Util:path("com/com_img_checkboxbg2"), Util:path("com/com_img_checkbox2"))
		:addTo(sp)
		:pos(30, sp:height()/2)
	check:onEvent(function(event)
			if event.name == "selected" then
				if type(data.paramName) == "function" then
					data.paramName(true)
				else
					cc.exports[data.paramName] = data.value
				end
			elseif event.name == "unselected" then
				if type(data.paramName) == "function" then
					data.paramName(false)
				else
					cc.exports[data.paramName] = nil
				end
			end
		end)
	Util:systemLabel(data.name, 22)
		:addTo(sp)
		:anchor(0, 0.5)
		:pos(check:width()/2 + check:x(), check:y())
	return sp
end

function cls:enablePrint(v)
	if v then
		local dimensions = cc.size(display.width,0)
		if not old_print then
			cc.exports.old_print = print
		end
		DEBUG = 2
		cc.exports.CACHE_DEBUG_LOG = {}
		appView:checkWhiteUser()

		function print(...)
			old_print(...)
            local p = {...}
            local str = ""
            for k,v in ipairs(p) do
                str = str .. " " .. tostring(v)
            end
            table.insert(CACHE_DEBUG_LOG, str)

         --    local scene = display.getRunningScene()
         --    local node = scene:getChildByTag(TAGS.Logs)
         --    if not node then
         --        node = display.newNode():addTo(scene,TAGS.Logs,TAGS.Logs)
         --    end
         --    local yy = node:getPositionY()
         --    local label = Util:systemLabel(str, 22, nil, dimensions)
         --        :addTo(node)
         --        :align(display.LEFT_TOP,0,-yy)
         --    yy = yy + label:getContentSize().height
         --    node:setPositionY(yy)
         --    label:run{
         --    	"seq",
         --    	{"delay", 60},
         --    	{"remove"},
	        -- }
		end
		print("*** 测试！")
	else
		function print() end
		cc.exports.CACHE_DEBUG_LOG = nil
	end
end

function cls:touchHandler(e)
	return true
end

-- 创建一个有颜色的时间
function cls.createTime(time)
	local time = math.floor(time * 1000)
	local color = nil
	if time < 0 or time > 1000 then
		color = display.COLOR_RED
	elseif time > 100 then
		color = cc.c3b(255, 255, 0)
	else
		color = display.COLOR_GREEN
	end
		
	if time < 0 then
		time = "超时"
	else
		time = time .. " ms"
	end

	return Util:systemLabel(time, 22, color)
end

return cls
