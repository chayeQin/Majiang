--
--@brief 工具类
--@author qyp
--@date 2015/8/12
---

local cls = class("Util")

-- 保存数据使用的加密KEY
cls.key = "f4fx2xZ,*s1"

function cls:ctor()
	self.serverDtime = 0
	self.serverTimeZone = 0 -- 时区修正
	self.eventCenter = {}
	cc.bind(self.eventCenter, "event")
	self.animationTime_ = {} -- 所有PLIST 播放的总时间

	-- 后缀名替换
	self.pz = {
		png = TEXTURE_PZ,
		jpg = TEXTURE_JPG,
		mp3 = SOUND_PZ
	}
end

function cls:sprite(v, resType)
	v = self:path(v)

	if ccui.TextureResType.plistType == resType then
		return display.newSprite("#" .. v)
	end

	if not self:exists(v) then
		print("**not exits", v)
		return self:label(v,30, cc.convertColor(display.COLOR_RED, "4b"))
	end
	return display.newSprite(v)
end

function cls:sprite9(v,x,y,w,h,isJpg)
	local suffix = nil
	if isJpg then
		suffix = ".jpg"
	end
	v = self:path(v, suffix)
	local params = {scale9 = true,
					capInsets = cc.rect(x, y, w, h)}
	return display.newSprite(v, params)
end

function cls:jpg(v, resType)
	v = self:path(v, ".jpg")
	if ccui.TextureResType.plistType == resType then
		return display.newSprite("#" .. v)
	end
	
	if not self:exists(v) then
		return self:label(v, 30, cc.convertColor(display.COLOR_RED, "4b"))
	end
	cc.Texture2D:setDefaultAlphaPixelFormat(TEXTURE_CFG.jpg)
	local sp = display.newSprite(v)
	cc.Texture2D:setDefaultAlphaPixelFormat(TEXTURE_CFG.png)

	return sp
end

function cls:path(v, suffix)
	suffix = suffix or ".png" 
	if not v then
		print("Util:path ***ERROR resource name is nil")
		return 
	end

	local str = "lang" -- 资源路径替换成对应的语言路径
	if string.sub(v, 1,string.len(str)) == str then
		v =  Lang:getLang() .. string.sub(v, string.len(str)+1, string.len(v))
	end

	if suffix == ".jpg" then
		return v .. TEXTURE_JPG
	elseif suffix == ".png" then
		return v .. TEXTURE_PZ
	else 
		return v .. suffix
	end
end

function cls:exists(v)
	local ret = cc.FileUtils:getInstance():isFileExist(v)
	return ret
end

function cls:mkdir(path)
	cc.FileUtils:getInstance():createDirectory(path)
end

function cls:label(text,size,color4b,dimensions,align,valign)
	if Lang:getFont() == "" then
		return self:systemLabel(text,size,color4b,dimensions,align,valign)
	end

	text = text or ""
	size = size or 22
	color4b = color4b or cc.convertColor(display.COLOR_WHITE, "4b")
	if not align then
		if Lang.isRTL then
			align = cc.TEXT_ALIGNMENT_RIGHT -- 右对齐
		else
			align = cc.TEXT_ALIGNMENT_LEFT -- 左对齐
		end
	end
	
	valign = valign or cc.VERTICAL_TEXT_ALIGNMENT_TOP -- cc.VERTICAL_TEXT_ALIGNMENT_CENTER cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM
	local ttfConfig = {
		fontFilePath = Lang:getFont(),
		fontSize = size,
	}

	local lab = cc.Label:createWithTTF(ttfConfig,text, align, valign)
	lab:setTextColor(color4b)

	if dimensions then
		-- lab:setDimensions(dimensions.width,dimensions.height)
		lab:setMaxLineWidth(dimensions.width)
		-- lab:setLineBreakWithoutSpace(false)
	end
	return lab
end

function cls:systemLabel(text, size, color4b, dimensions, align, valign, notExtend)
	text = text or ""
	size = size or 22
	color4b = color4b or cc.convertColor(display.COLOR_WHITE, "4b")
	valign = valign or cc.VERTICAL_TEXT_ALIGNMENT_TOP

	if not align then
		if Lang.isRTL then
			align = cc.TEXT_ALIGNMENT_RIGHT -- 右对齐
		else
			align = cc.TEXT_ALIGNMENT_LEFT -- 左对齐
		end
	end

	local lab = cc.Label:createWithSystemFont(text, nil, size)
	lab:setTextColor(color4b)

	lab:setAlignment(align,valign)
	
	if dimensions then
		lab:setDimensions(dimensions.width or 0, dimensions.height or 0)
	end

	if notExtend ~= false then
		self.dimensions = dimensions
		LabelExtend:exec(lab)
	end

	return lab
end

function cls:labelOutLine(text,size,color4b,dimensions,align,valign,outlineColor)
	local label = self:label(text,size,color4b,dimensions,align,valign)
	outlineColor = outlineColor or cc.convertColor(display.COLOR_BLACK, "4b")

	label:enableOutline(outlineColor, 2)

	return label
end

function cls:labelWithShadow(text,size,color4b,dimensions,align,valign, shadowColor, offset)
	local label = self:label(text,size,color4b,dimensions,align,valign)
	shadowColor = shadowColor or cc.c4b(0, 0, 0, 225)
	offset = offset or cc.size(2, -2)
	label:enableShadow(shadowColor, offset)
	return label
end

function cls:button(v, func, label, labelSize, color3b, resType)
	local res = {}
	local resType = resType or ccui.TextureResType.localType -- ccui.TextureResType.plistType
	if type(v) == "table"then
		for i, _ in ipairs(v) do
			if resType == ccui.TextureResType.plistType then
				res[i] = self:path(v[i])
			else
				res[i] = self:path(v[i])
			end
			
		end
	else
		if resType == ccui.TextureResType.plistType then
			res[1] = self:path(v)
		else
			res[1] = self:path(v)
		end
	end

	local btn = ccui.Button:create(res[1], res[2], res[3], resType)

	if label then
		labelSize = labelSize or 30
		color3b = color3b or display.COLOR_WHITE
		btn:setTitleFontName(Lang:getFont())
		btn:setTitleText(label)
		btn:setTitleFontSize(labelSize)
		btn:setTitleColor(color3b)
		local lab = btn:getTitleRenderer()
		-- lab:enableShadow()
	end

	btn:addClickEventListener(function(target)
		if btn.guide_name then
			if User.notOpenFunc[btn.guide_name] then
				Tips.show(User.notOpenFunc[btn.guide_name].hint)
				return
			end
		end
		Util:event(Event.assistantClick)
		local guideName = target.guideName
		if func then
			func(target)
		end

		--  TODO : play button click sound
		Sound:play("sound/other/"..52)
	end)

	return btn
end

function cls:editBox(size, func, bgPath)
	bgPath = bgPath or self:path("9sprite/m_9")
	local edit = ccui.EditBox:create(size, bgPath)
	edit:setInputFlag(cc.EDITBOX_INPUT_FLAG_SENSITIVE)
	edit:setInputMode(cc.EDITBOX_INPUT_MODE_EMAILADDR)
	if func then
		edit:registerScriptEditBoxHandler(function(strEventName,pSender)
				if strEventName == "return" then
					func(pSender)
				end
		end)
	end

	if Lang.isRTL and edit.setTextHorizontalAlignment then
		edit:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_RIGHT)
	end

	return edit
end

function cls:loadBar(v, direction, rect, size)
	if rect then
		local nodeClip = ccui.Layout:create()
		nodeClip:setClippingEnabled(true)
		nodeClip:setClippingType(0)
		nodeClip:setAnchorPoint(display.CENTER)
		nodeClip:size(size or cc.size(100, 50))

		local loadingBar = ccui.LoadingBar:create()
		loadingBar:setTag(0)
		loadingBar:setName("LoadingBar")
		loadingBar:loadTexture(self:path(v))
		loadingBar:setScale9Enabled(true)
		loadingBar:setCapInsets(rect or cc.rect(5, 5, 5, 5))
		loadingBar:setContentSize(cc.size(nodeClip:width(), nodeClip:height()))
		loadingBar:setDirection(direction or ccui.LoadingBarDirection.LEFT)
		loadingBar:addTo(nodeClip):center()
		loadingBar:setPercent(100)

		function nodeClip:setPercent( value )
			loadingBar:setPercent(value)
		end
		
		return nodeClip
	else
		local loadingBar = ccui.LoadingBar:create(self:path(v), 100)
		loadingBar:setDirection(direction or ccui.LoadingBarDirection.LEFT)
		return loadingBar
	end
end

-- 圆形的进度条
function cls:loadRadial(v,bg,showNum)
	local node = display.newNode()
	local bar = cc.ProgressTimer:create(Util:sprite(v))
	bar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	if showNum then
		bar.num = self:label("",22):addTo(bar):center()
	end
	node:size(bar:getContentSize())
	if bg then
		self:sprite(bg):addTo(node):center()
	end
	bar:addTo(node):center()
	node.bar = bar
	function node:value(num,time)
		if not num then
			return bar:getPercentage()
		end
		if time then
			local to = cc.ProgressTo:create(time, num)
			bar:runAction(cc.RepeatForever:create(to))
		else
			bar:setPercentage(num)
		end
		if bar.num then
			bar.num:setString(string.format("%d%%",num))
		end
	end
	node:setAnchorPoint(display.CENTER)
	return node
end

function cls:load(key,user)
	if key == nil then return nil end
	if user and user.info then
		key = key .. "_" .. user.info.uid .. "_" .. PlatformInfo:getServerId()
	end
	local str = cc.UserDefault:getInstance():getStringForKey(key)
	if str == nil or str == "" then return end
	return json.decode(str)
end

function cls:save(key,value,user)
	if key == nil then return end

	if user and user.info.uid then
		key = key .. "_" .. user.info.uid .. "_" .. PlatformInfo:getServerId()
	end

	local str = json.encode(value)
	cc.UserDefault:getInstance():setStringForKey(key, str)
    cc.UserDefault:getInstance():flush()
end

function cls:loadBool(key, user)
	if user and user.info.uid then
		key = key .. "_" .. user.info.uid .. "_" .. PlatformInfo:getServerId()
	end
	local value = cc.UserDefault:getInstance():getBoolForKey(key)
	return value ~= false
end

function cls:saveBool(key, value, user)
	if user and user.info.uid then
		key = key .. "_" .. user.info.uid .. "_" .. PlatformInfo:getServerId()
	end
    cc.UserDefault:getInstance():setBoolForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

-- 下次循环再调用
function cls:tick(func,delay)
	if not func then return end
	if not delay then delay = 0 end
	local loop = nil
	local function tick()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(loop)
		func()
	end
	loop = cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,delay,false)
	return loop
end

-- 算出时区
function cls:timeZone(now)
	return os.difftime(now, os.time(os.date("!*t", now)))
end

function cls:initTime(v, stz)
	if stz == nil then
		stz = 8
	end
	if stz < 3600 then
		stz = stz * 3600
	end
	local cTime = os.time()
	local ctz = self:timeZone(cTime)
	self.serverTimeZone = stz - ctz
	self.serverDtime = v - cTime
	-- print("*** time diff ",self.serverDtime,self.serverTimeZone)
	-- print("*** client time ",self:date("%c",self:time()))   
end

-- 服务器时间
function cls:time(v)
	if v and type(v) == "table" then
		return os.time(v) - self.serverTimeZone
	end

	return os.time() + self.serverDtime
end

-- 服务器转换时间
-- "%Y/%m/%d %H:%M:%S"
function cls:date(format,time)
	time = time or self:time()
	return os.date(format,time + self.serverTimeZone)
end

-- 注册事件
-- 参数：事件名，回调函数
function cls:addEvent(eventName, listener)
	local target, handle = self.eventCenter:addEventListener(eventName, listener)
	return handle
end

-- 派发事件
function cls:event(name,...)
	local event = {}
	event.name = name
	event.params = {...}
	self.eventCenter:dispatchEvent(event)
end

-- 删除事件监听
function cls:removeEvent(handle)
   self.eventCenter:removeEventListener(handle) 
end

function cls:rename(old,new)
	if not self:exists(old) then
		return false
	end

	if self:exists(new) then
		os.remove(new)
	end
	
	os.rename(old,new)

	return true
end

--@brief 界面居中显示
function cls:center(view)
	if not view or view.resourceNode_ then
		return
	end
	local vSize = view.resourceNode_:getContentSize()
	local x = (display.width - vSize.width)/2
	local y = (display.height - vSize.height)/2
	view:pos(x, y)
end

function cls:plist(name,rhand)
	local plist = self:path("plist/"..name, ".plist")
	local png = self:path("plist/"..name, ".png")
	if display.getImage(png) then
		if rhand then
			self:tick(function()
				rhand(name)
				end,0)
		end
		return true
	end
	if not self:exists(plist) then
		print("*** not file",plist)
		if rhand then
			self:tick(function()
				rhand(name)
				end,0)
		end
		return false
	end
	if not self:exists(png) then
		print("*** not file",png)
		if rhand then
			self:tick(function()
				rhand(name)
				end,0)
		end
		return false
	end
	self:unplist(name)

	if not rhand then
		display.loadSpriteFrames(plist, png)
		return true
	end

	display.loadImage(png,function(texture)
		display.loadSpriteFrames(plist, png)
		rhand(name)
		end)

	return true
end

function cls:unplist(name)
	local plist = self:path("plist/"..name, ".plist")
	local png = self:path("plist/"..name, ".png")
	display.removeSpriteFrames(plist, png)
end

function cls:getAnimation(id,time,forever,func,isSumTime,delay, format)
	local animation = display.getAnimationCache(id)
	format = format or "%s_%02d.png"
	if not animation then
		local array = {}
		for i = 1,999 do
			local frameName = string.format(format,id,i)
			local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(frameName)
			if not frame then break end
			table.insert(array,frame)
		end

		if #array < 1 then
			print("*** util:animation nil = " .. id)
			return nil,false
		end
		
		-- if isSumTime ~= true then
		--     time = time * #array
		-- end
		animation = cc.Animation:createWithSpriteFrames(array, time)
		self.animationTime_[id] = animation:getDuration()

		display.setAnimationCache(id, animation)
	end

	local action = cc.Animate:create(animation)
	if forever then
		action = cc.RepeatForever:create(action)
	elseif func then
		local arr = {}
		if delay then
			table.insert(arr,cc.Hide:create())
			table.insert(arr,cc.DelayTime:create(delay))
			table.insert(arr,cc.Show:create())
		end
		table.insert(arr,action)
		if func == "remove" then
			table.insert(arr,cc.RemoveSelf:create())
		else
			table.insert(arr,cc.CallFunc:create(func))
		end
		action = transition.sequence(arr)
	end

	return action,true
end

-- 获取动画队列，id=map(map_01.png)   ,是否循环,不循环支持回调
-- 返回值,sp,是否成功创建动画
-- time 每帧时间
-- isSumTime = true 时表示总时间
function cls:animation(id,time,forever,func,isSumTime,delay, format)
	time = time or 1 / DESIGN_FPS
	format = format or "%s_%02d.png"
	local action,result = self:getAnimation(id,time,forever,func,isSumTime,delay, format)
	
	local sp = nil
	if result then
		sp = display.newSprite("#" .. string.format(format,id,1))
		action:setTag(10001)
		sp:stopActionByTag(10001)
		sp:runAction(action)
	else
		sp = self:sprite("empty")
	end

	return sp,result
end

-- 获取动画时间
function cls:getAnimationTime(id)
	return self.animationTime_[id] or 0
end

function cls:texture(v)
	return display.loadImage(self:path(v))
end

function cls:untexture(v,isJpg)
	local suffix = nil
	if isJpg then
		suffix = ".jpg"
	end

	v = self:path(v, suffix)
	display.removeImage(v)
end


function cls:number(t,center,ifdot)
	local num = nil
	
	if 1 == t then
		num = Number.new(":",  self:path("number/num_01"),25,35,":0123456789dh ")
	elseif 2 == t then
		num = Number.new("0",  self:path("number/num_02"),30,58,"0123456789")
	elseif 3 == t then
		num = Number.new("0",  self:path("number/num_03"),31,35,"0123456789")
	elseif 4 == t then
		num = Number.new(":",  self:path("number/num_04"),31,35,":0123456789")
	elseif 5 == t then
		num = Number.new("0",  self:path("number/num_05"),40,80,"0123456789,-+KMB.")
	elseif 6 == t then
		num = Number.new("1",  self:path("number/num_06"),12,15,"1234567890,.kmb+-")
	elseif 7 == t then
		num = Number.new("0",  self:path("number/num_07"),32,64,"0123456789,")
	elseif 8 == t then
		num = Number.new("0", self:path("number/num_08"), 32, 64, "0123456789,.+kM")
	elseif 9 == t then
		num = Number.new("0", self:path("number/num_09"), 11, 16, "0123456789:/.d ") -- 建筑倒计时间
	elseif 10 == t then
		num = Number.new("0", self:path("number/num_10"), 11, 16, "1234567890,.kmb+hdsMAX-")
	elseif 11 == t then
		num = Number.new("0",  self:path("number/num_11"),15,29,"0123456789,")
	elseif 12 == t then
		num = Number.new("0",  self:path("number/num_12"),38,52,"1234567890%")
	elseif 13 == t then
		-- 特殊符号转换
		local map = {
		["￥"] = "a",
		["฿"] = "b",
		["₫"] = "c",
	}
		local str = "1234567890￥$฿NT₫."
		for sym,con in pairs(map) do
			str = string.gsub(str,sym,con)
		end
		num = Number.new("0", self:path("number/num_13"),19,21,str)
		num:setConvertMap(map)
	elseif 14 == t then
		num = Number.new("0",  self:path("number/num_14"),15,20,"1234567890")
	elseif 15 == t then
		num = Number.new("0",  self:path("number/num_15"),24,30,"1234567890")
	elseif 16 == t then
		num = Number.new("0",  self:path("number/num_16"),18,38,"0123456789")
	elseif 17 == t then
		num = Number.new("0",  self:path("number/num_17"),14,18,"1234567890-+KM%") -- 战斗伤害
	elseif 18 == t then
		num = Number.new("0",  self:path("number/num_18"),25,32,"+1234567890")
	elseif 19 == t then
		num = Number.new("0",  self:path("number/num_19"),40,80,"0123456789,-+KMB.")
	end
	
	num.dot = ifdot
	if center then
		num:setAnchorPoint(display.CENTER)
	end
	return num
end

--@brief 数字滚动动画
function cls:numberRoll(numberNode, fromNum, toNum, totalTime)
	totalTime = totalTime or 3
	local num = fromNum
	local add = toNum > fromNum and 1 or -1
	local interval = 0.1 -- 0.3s 循环变化一次数字
	local repCount = math.abs(toNum-fromNum) -- 每次+1所需的循环次数
	local needTime = repCount * 0.3
	add = add * math.abs(toNum-fromNum) / (totalTime/interval) -- 最多持续3s
	if numberNode.rollAct then
		numberNode:unschedule(numberNode.rollAct)
		numberNode.rollAct = nil
	end

	local function addNum()
		if num >= toNum then
			numberNode:value(toNum)
			numberNode:unschedule(numberNode.rollAct)
			numberNode.rollAct = nil
			return
		end
		numberNode:value(num)
		num = num + add
	end
	numberNode.rollAct = numberNode:schedule(addNum, interval, true)
	addNum()
end

function cls:gray(node, boo)
	local programname = boo ~= false and "ShaderUIGrayScale" or "ShaderPositionTextureColor_noMVP"
	local glprog = cc.GLProgramState:getOrCreateWithGLProgramName(programname)
	local function itrchild(node)
		local childrens = node:getChildren()
		for _, child in ipairs(childrens) do
			itrchild(child)
		end
		if node.getRendererFrontCross then
			itrchild(node:getRendererFrontCross())
		end
		node = node.getVirtualRenderer and node:getVirtualRenderer() or node
		if tolua.type(node) == "ccui.Scale9Sprite" then
			node:setState(boo and 1 or 0)
		elseif tolua.type(node) == "cc.Label" then
			if boo then
				node.origColor__ = node:getTextColor()
				node:setTextColor(display.COLOR_WHITE)
			elseif node.origColor__ then
				node:setTextColor(node.origColor__)
			end
		else 
			node:setGLProgramState(glprog)
		end
	end
	itrchild(node)
	if tolua.type(node) == "ccui.Button" then
		 node:setColor(boo ~= false and cc.c4b(80,80,80,255) or cc.c4b(255,255,255,0))
	end
end

-- @brief 时间差转换为时:分:秒
function cls:formatTime(timeDiff)
	if timeDiff > 86400 then
	   	return string.format("%dd %.2d:%.2d:%.2d",
			math.floor(timeDiff / 86400),
			math.floor(timeDiff % 86400 / 3600),
			math.floor(timeDiff % 3600 / 60),
			math.floor(timeDiff % 60)) 
	end
	return string.format("%.2d:%.2d:%.2d",
		math.floor(timeDiff / 3600),
		math.floor(timeDiff % 3600 / 60),
		math.floor(timeDiff % 60))
end

-- 返回时间格式(必须大到小)
local FORMAT_TIME_LIST = {
	86400,"day","d",
	3600,"hour","h",
	60,"minute","m",
	1,"second", "s",-- 算法问题.最后一个是1
}

-- 只返回一个单位的值
function cls:formatTimeString(timeDiff, isShort)
	local min = FORMAT_TIME_LIST[#FORMAT_TIME_LIST - 2]
	local key = FORMAT_TIME_LIST[#FORMAT_TIME_LIST - 1]
	local key2 = FORMAT_TIME_LIST[#FORMAT_TIME_LIST]
	if timeDiff <= min then
		if isShort then
			return string.format("%d%s", timeDiff, key2)
		else
			return string.format("%d%s", timeDiff, Lang:find(key))
		end
	end

	for i = 1, #FORMAT_TIME_LIST, 3 do
		local value = FORMAT_TIME_LIST[i]
		local key   = FORMAT_TIME_LIST[i + 1]
		local key2 = FORMAT_TIME_LIST[i + 2]
		if timeDiff >= value then
			if isShort then
				return string.format("%d%s", math.floor(timeDiff / value), key2)
			else
				return string.format("%d%s", math.floor(timeDiff / value), Lang:find(key))
			end
		end
	end

	return ""
end

-- @brief 富文本
function cls:richText(list,size,width,height, sysFont, isRTL)
	local size = size or 20
	local richText = ccui.RichText:create()
	if width then
		richText:ignoreContentAdaptWithSize(false)
		richText:setContentSize(width,height or 0)
	end

	for k,v in ipairs(list) do
		local element = nil
		if v.text then
			local font = nil -- 使用系统字体
			if not sysFont then
				font = v.font or Lang:getFont()
			end
			element = ccui.RichElementText:create(k,v.color or display.COLOR_WHITE,v.opacity or 255, v.text, font ,v.size or size)
		elseif v.image then
			element = ccui.RichElementImage:create(k,v.color,v.opacity or 255,v.image)
		else
			local node = display.newNode():size(v.width or 0,v.height or 0)
			element = ccui.RichElementCustomNode:create(k,v.color,v.opacity or 255,node)
		end

		if isRTL and Lang.isRTL then
			richText:insertElement(element, 0)
		else
			richText:pushBackElement(element)
		end
	end

	-- 设置左上角坐标
	function richText:posLT(x,y)
		self:setPosition(x + (width or 0) / 2, y - (height or 0) / 2)
		return self
	end

	-- 设置中心点
	-- function richText:posCenter(x,y)
	--     self:setPosition(x + )
	--     return self
	-- end

	return richText
end

-- 将字符串拆成richText使用的
-- src 源字符 : {1}你好
-- args 对应{1}你好,的第一个参数:{"fd"}
-- normalColor 正文颜色
-- keyColor 被替换字的颜色
function cls:split2rich(src,args,normalColor,keyColor,keySize)
	normalColor = normalColor or display.COLOR_WHITE
	keyColor    = keyColor or display.COLOR_RED
	keySize = keySize or 20
	local list = {}
	local indexLst = {}
	for i = 1,999 do
		local key = "{"..i.."}"
		local index,indexEnd = string.find(src,key)
		if index then
			table.insert(indexLst,i)
		end
	end
	for _,i in ipairs(indexLst) do
		local key = "{" .. i .. "}"
		local index,indexEnd = string.find(src,key)
		if not index then
			table.insert(list,{text=src,color=normalColor})
			break
		end
		-- 前半
		table.insert(list,{text=string.sub(src,1,index - 1),color=normalColor})
		-- 关键字
		table.insert(list,{text=args[i],isKey=true,color=keyColor,size = keySize})
		-- 剩余继续查找
		src = string.sub(src,indexEnd + 1)
	end
	table.insert(list,{text=src,color=normalColor})
	return list
end

-- @brief node水平分布
function cls:horizonAlign(itemLst,gap,col,rowGap)
	local row = math.ceil(#itemLst / col)
	rowGap = rowGap or 0
	local node = display.newNode()
	if #itemLst == 0 then return node end
	local rest = #itemLst % col
	if rest == 0 then
		rest = col
	end
	local y = itemLst[1]:size().height / 2
	local colNum = nil
	for i = 1,row do
		local x = nil
		if i == row then
			x = - (rest-1) / 2 * gap
			colNum = rest
		else
			x = - (col-1) / 2 * gap
			colNum = col
		end
		for j = 1,colNum do
			itemLst[(i-1)*col+j]:addTo(node):pos(x,y)
			x = x + gap
		end
		y = y - rowGap
	end
	return node
end

--@brief 分割字符串
function cls:strSplit(str, seperator)
	str = str or ""
	seperator = seperator or ","
	local ary =  string.split(str, seperator)
	for i = #ary, 1, -1 do
		if ary[i] == "" then
			table.remove(ary, i)
		end
	end
	return ary
end
cls.split = cls.strSplit

--@brief 
function cls:gm(itemType, itemId, itemCount)
	Net:call_(function(v, msg)
		if v.error ~= 0 then
			return 
		end
		dump(v)
	 --  	if v.result[1] then -- 物品更新推送
		-- 	PackModel:update(v.result[1])
		-- end

		Tips.show("发送成功")
	end, "gm", "sendItem", User.info.uid,itemType, itemId, itemCount)
end

--@brief 过滤服务器存储字段
function cls:filterSaveField(tbl)
	tbl.insert = nil
	tbl.delete = nil
	tbl.sid = nil
	tbl.update = nil
	return tbl
end

--@brief 遮罩层
function cls:focusLayer(node, isShowBuildingName, layer)
	local circle = Util:sprite("ui/circle")
	if not layer then
		layer = display.newLayer(cc.c4b(0,0,0,0.95)):size(display.width,display.height)
		circle:pos(490, 380)
	else
		circle:pos(display.width/2, display.height/2)
	end

	local src = gl.ZERO -- 不使用源颜色
	local dst = gl.ONE_MINUS_SRC_ALPHA -- 使用源透明度
	local blend = cc.blendFunc(src, dst)
	circle:setBlendFunc(blend)
	local rt =  cc.RenderTexture:create(display.width, display.height)
	rt:begin()
	layer:visit() -- dst
	circle:visit() -- src
	rt:endToLua()
	local renderMist = cc.Sprite:createWithTexture(rt:getSprite():getTexture())
	renderMist:setFlippedY(true)
	renderMist:anchor(0, 0)
					:pos(0, 0)
	renderMist:onTouch(function() return true end,nil,true)
	renderMist:addTo(node, -1)

	if isShowBuildingName then
		local tmp = Util:sprite("ui/kuan_09")
					:addTo(renderMist)
					:pos(490, 460)
		local nameLab = Util:label(name, 20, Const.Color.LightBlue)
							:addTo(tmp)
							:pos(tmp:width()/2, tmp:height()/2)
		renderMist.nameLab = nameLab
	end

	return renderMist
end

--@brief 遮罩层
function cls:focusLayerBlack(node, isShowBuildingName)
	local src = gl.ZERO -- 不使用源颜色
	local dst = gl.ONE_MINUS_SRC_ALPHA -- 使用源透明度
	local blend = cc.blendFunc(src, dst)
	local rt =  cc.RenderTexture:create(display.width, display.height)
	rt:begin()
	rt:endToLua()
	local renderMist = cc.Sprite:createWithTexture(rt:getSprite():getTexture())
	renderMist:setFlippedY(true)
	renderMist:anchor(0, 0)
					:pos(0, 0)
	renderMist:onTouch(function() return true end,nil,true)
	renderMist:addTo(node, -1)

	if isShowBuildingName then
		local tmp = Util:sprite("ui/kuan_09")
					:addTo(renderMist)
					:pos(730, 460)
		local nameLab = Util:label(name, 20, Const.Color.LightBlue)
							:addTo(tmp)
							:pos(tmp:width()/2, tmp:height()/2)
		renderMist.nameLab = nameLab
	end

	return renderMist
end


-- @brief 大数量处理, 数值小于limit 时则返回千分符,limit为nil时直接返回k的格式
function cls:numProcess(num, limit)
	if not num then return "" end
	-- if TEST_DEV then
	--     return num
	-- end
	if limit ~= nil and num < limit then
		return string.formatnumberthousands(num)
	end

	if num >= 1000000000 then
		local tmp = math.floor(num/100000000)
		return string.format("%.1fB",tmp/10)
	end

	if num >= 1000000 then
		local tmp = math.floor(num/100000)
		return string.format("%.1fM",tmp/10)
	end

	if num >= 1000 then
		local tmp = math.floor(num/100)
		return string.format("%.1fK",tmp/10)
	end
	return num
end


-- 转换子列表
function cls:convertSubLst(orignLst,cellNum)
	if cellNum < 2 then
		return
	end
	local convertLst = {}
	local num = 1
	convertLst[num] = {}
	for _,v in ipairs(orignLst) do
		if #convertLst[num] >= cellNum then
			num = num + 1
			convertLst[num] = {}
		end
		table.insert(convertLst[num],v)
	end
	return convertLst
end

--@brief 获取升级所需物品
function cls:getUpgradeItemNeeded(plotId, buildType, lv)
	local buildInfo = nil
	if not plotId then
		buildInfo = BuildingModel:getBuildingByType(buildType)[1]
	else
		buildInfo = BuildingModel:getBuildingByPlotId(plotId)
	end
	lv = lv or buildInfo and(buildInfo.lv + 1) or 1
	local lvDataLst = db.DBuildConfig_type_lv_map[buildType]
	lv = math.max(math.min(lv, #lvDataLst), 1)
	local data = lvDataLst[lv]
	local lst = {}
	for i = 1, 20 do
		if not data["itemType"..i] or
			data["itemType"..i] == 0 then
		else
			table.insert(lst, {type=data["itemType"..i], id = data["itemId"..i], count=data["itemCount"..i]})
		end
	end
	return lst
end

--@brief 获取建筑升级需求
--@param[data] 数据表的对应数据
function cls:getBuildingUpgradeRequire(data,level)
	local lst = {}
	if data.explain then
		table.insert(lst,{type="string",desc = data.explain})
	end
	local maxLv = #db.DBuildConfig_type_lv_map[Const.TBuild.command_center]
	if level and data.otherExplain ~= "1" and level < maxLv - 1 then
		table.insert(lst,{type="nextLv",data = data})
	end
	-- if not BuildQueueModel:getFreeQueue() then
	-- table.insert(lst,{type="queue"})
	table.insert(lst,{type="ageLv",data = data.ageLv})
	-- end

	for i = 1, 999 do -- 建筑要求
		if data["buildType"..i] and 
			data["buildType"..i] > 0 then
			local buildType = data["buildType"..i]
			local buildLv = data["buildLv"..i]
			local staticVo = db.DBuildConfig_type_lv_map[buildType][buildLv]
			table.insert(lst, {type=Const.TData.TBuild, id=buildType, count=buildLv})
		else
			break
		end
	end
	for i = 1, 999 do -- 物品消耗要求
		if data["itemType"..i] and
			data["itemType"..i] > 0  then
			local itemType = data["itemType"..i]
			local itemId = data["itemId"..i]
			local itemCount = data["itemCount"..i]

			if itemCount> 0 then
				table.insert(lst, {type=itemType, id=itemId, count = itemCount})
			end 
		else
			break
		end
	end
	return lst
end

--@brief 获取生产所需物品列表
function cls:getProductNeeded(forceType, count, cacheReducePercent, cacheReduceCount)
	local data = ForceModel:getForceDbData(forceType)
	if not data then
		return {}
	end
	local tmp = Util:split(data.buildType, "|")
	local needBuildType = checknumber(tmp[1])

	local reducePercent = 1
	local reduceCount = 0

	if cacheReducePercent and cacheReduceCount then
		reducePercent = cacheReducePercent
		reduceCount = cacheReduceCount
	else
		if needBuildType == Const.TBuild.combat_center then -- 陷阱
			reducePercent = AlgoUtil:getTotalData(Const.TData.TBuildData,Const.TBuildData.reduce_trap_consume,true)
			reducePercent = 1 - reducePercent/100
			reduceCount = AlgoUtil:getTotalData(Const.TData.TBuildData,Const.TBuildData.reduce_trap_consume)
		end
	end

	local lst = {}
	for i = 1, 20 do
		if not data["itemType"..i] or
			data["itemType"..i] == 0 then
		else
			if data["itemCount"..i] > 0 then
				local tmpCount = math.max(data["itemCount"..i] * count - reduceCount, 0)
				tmpCount = math.floor(tmpCount * reducePercent)
				table.insert(lst, {type=data["itemType"..i], id = data["itemId"..i], count=tmpCount})
			end
		end
		
	end
	return lst, reduceCount, reducePercent
end

--@brief 获取研究所需物品列表
function cls:getResearchNeeded(dbType, scienceType, lv)
	local dbName = db.TScience[dbType].key
	local lvDataLst = db[dbName.."_type_lv_map"][scienceType]
	local scienceData = ScienceModel:getScienceData(dbType, scienceType)
	lv = lv or scienceData and scienceData.lv + 1 or 1
	lv = math.max(math.min(lv, #lvDataLst), 1)
	local data = lvDataLst[lv]
	local lst = {}
	for i = 1, 20 do
		if not data["dataType"..i] or
			data["dataType"..i] == 0 then
		else
			if data["dataType"..i] == Const.TData.TPropCannot then
				local needCount = data["data"..i]
				if data["dataId"..i] == Const.TPropCannot.science_factor then
					needCount = AlgoUtil:scienceFactorConsume(needCount)
				end
				table.insert(lst, {type=data["dataType"..i], id=data["dataId"..i], count=needCount})
			end
		end
	end
	return lst
end

function cls:sprite9Lib(v)
	local rect = self:sprite9Size(v)
	return self:sprite9(v, unpack(rect))
end

function cls:sprite9Size(v)
	local rect = {1,1,1,1}
	if v == "9sprite/9sp_01" then
		rect = {10, 10, 30, 30}
	elseif v == "9sprite/9sp_02" then
		rect = {41, 13, 44, 14}
	elseif v == "9sprite/9sp_03" then
		rect = {81, 25, 86, 26}
	elseif v == "9sprite/9sp_04" then
		rect = {23, 7, 34, 9}
	elseif v == "9sprite/9sp_05" then
		rect = {38, 11, 1, 1}
	elseif v == "9sprite/9sp_06" then
		rect = {110, 34, 115, 14}
	elseif v == "9sprite/9sp_07" then
		rect = {80, 63, 38, 66}
	elseif v == "9sprite/9sp_08" then
		rect = {12, 11, 13, 14}
	elseif v == "9sprite/9sp_09" then
		rect = {13, 13, 14, 15} 
	elseif v == "9sprite/9sp_10" then
		rect = {9, 9, 12, 12}
	elseif v == "9sprite/9sp_11" then
		rect = {25, 11, 28, 12}
	elseif v == "9sprite/9sp_12" then
		rect = {34, 11, 38, 14}
	elseif v == "9sprite/9sp_13" then
		rect = {30,30,128,115}
	elseif v == "ui/title_bg_01" then
		rect = {25, 8, 27, 9}
	elseif v == "ui/chat_srk_01" then
		rect = {13,13,16,16}
	elseif v == "ui/chat_ltk_02" then
		rect = {16,16,16,16}
	elseif v == "ui/chat_ltk_04" then
		rect = {16,16,16,16}
	elseif v == "ui/chat_ltk_05" then
		rect = {16,16,16,16}
	elseif v == "ui/title_bg_04" then
		rect = {29, 11, 26, 13}
	elseif v == "ui/zhuangshi_17" then
	   rect = {32,26,32,26}
	elseif v == "ui/by_line_02" then
		rect = {7,0,7,0}
	elseif v == "ui/kuang_30"   then
		rect = {30,35,16,18}
	elseif v == "ui/kuang_34"   then
		rect = {25,25,134,1}
	elseif v == "ui/xz_union_01" then
		rect = {40,40,20,20}
	elseif v == "ui/zhuangshi_44" then
		rect = {362,142,362,142}
	elseif v == "ui/ui_tongyong_9sp_01" then
		rect = {77,112,2,2}
	elseif v == "ui/kuang_46" then
		rect = {29,11,29,11}
	elseif v == "ui/kuang_42" then
		rect = {50,50,130,40}
	elseif v == "ui/kuang_49" then
		rect = {44, 44, 46, 46}
	elseif v == "ui/kuang_14" then
		rect = {20,20,60,5}
	elseif v =="ui/xjsr_line_01" then
		rect = {7,0,7,0}
	elseif v =="ui/kuang_39" then
		rect = {40,40,490,50}
	elseif v == "ui/zhuangshi_53" then
		rect = {264, 90, 3,3}
	elseif v == "ui/title_bg_06" then
		rect = {76, 19, 3, 3}
	elseif v == "button/btn_main_05" then
		rect = {34, 22, 30, 30}
	elseif v == "world_res/point" then
		rect = {7, 7, 2, 2}
	elseif v == "world_res/point2" then
		rect = {7, 7, 2, 2}
	elseif v == "ui/xyzl_iteam_01" then
		rect = {28, 28, 30, 30}
	elseif v == "9sprite/9sp_di02" then
		rect = {28, 10, 30, 13}
	elseif v == "ui/kuan_09" then
		rect = {28, 10, 30, 13}
	elseif v == "ui/fg_03" then
		rect = {24,17,332,36}
	elseif v == "ui/fg_04" then
		rect = {24,17,332,36}
	elseif v == "ui/fg_05" then
		rect = {24,17,332,36}
	elseif v == "ui/fg_06" then
		rect = {24,17,332,36}
	elseif v == "ui/zhuangshi_25" then
		rect = {12, 25, 5, 5}
	elseif v == "ui/kuang_17" then
		rect = {50,50,620,188}
	elseif v == "ui/kuang_45" then
		rect = {53,25,300,25}
	elseif v == "ui/kuang_30_02" then
		rect = {30,35,16,18}
	elseif v == "ui/kuang_30_03" then
		rect = {30,35,16,18}
	elseif v == "ui/kuang_30_04" then
		rect = {30,35,16,18}	
	elseif v == "9sprite/9sp_15" then
		rect = {9,9,9,9}		
	elseif v == "ui/by_line_01" then
		rect = {20,0,20,0}
	elseif v == "ui/cd_jindutiao_03" then
		rect = {38,3,38,3}
	elseif v == "ui/kuang_20" then
		rect = {8, 8, 8 , 8}
	elseif v == "ui/cd_jindutiao_22" then
		rect = {66, 19, 66 , 19}	
	elseif v == "ui/zhuangshi_105" then
		rect = {66, 19, 66 , 19}
	elseif v == "ui/kuang_78" then
		rect = {34,33,34,33}
	elseif v == "9sprite/9sp_16" then
		rect = {46,46,46,46}			
	elseif v == "ui/yd_k_02" then
		rect = {21,21,22,22}
	elseif v == "ui/yd_k_01" then
		rect = {21,21,22,22}
	elseif v == "ui/kuan_10" then
		rect = {93,52,93,52}
	elseif v == "9sprite/9sp_17" then
		rect = {16,16,16,16}
	elseif v == "ui/kuang_48" then
		rect = {61, 21, 64, 23}
	elseif v == "ui/kuang_24" then
		rect = {100, 43, 100, 46}
	elseif v == "9sprite/9sp_19" then
		rect = {11,11,11,11}
	elseif v == "ui/tf_k_02" then
		rect = {37,37,37,37}
	elseif v == "ui/kuang_58" then
		rect = {30,42,5,42}
	elseif v == "ui/chat_gg_bg_01" then
		rect = {135,22,5,22}
	elseif v == "ui/kuang_18" then
		rect = {50,24,10,24}
	elseif v == "ui/kuan_04" then
		rect = {80,90,2,3}
	elseif v == "9sprite/9sp_21" then
		rect = {46,46,46,46}			
	elseif v == "ui/kuang_69" then
		rect = {145,50,82,32}
	elseif v == "ui/kuang_80" then
		rect = {10,10,18,6}
	elseif v == "9sprite/9sp_18" then
		rect = {13,13,14,14}
	elseif v == "9sprite/9sp_24" then
		rect = {46,46,46,46}
	elseif v == "9sprite/9sp_28" then
		rect = {46,46,46,46}
	elseif v == "9sprite/9sp_26" then
		rect = {46,46,46,46}
	elseif v == "ui/tips_bg_03" then
		rect = {186,30,40,10}
	elseif v == "ui/tips_bg_02" then
		rect = {186,30,40,10}
	elseif v == "9sprite/9sp_35" then
		rect = {18,18,18,18}
	elseif v == "ui/kuang_81" then
		rect = {140,15,140,15}
	elseif v == "ui/rw_iteam_01" then
		rect  = {28,28,28,28}
	elseif v == "ui/hongbao_bg_01" then
		rect  = {128,40, 49, 20}
	elseif v == "9sprite/9sp_33" then
		rect = {21, 22, 23, 23}
	elseif v == "9sprite/9sp_22" then
		rect = {4, 4, 2, 2}
	elseif v == "ui/kuang_86" then
		rect = {200, 112, 22, 10}
	elseif v == "9sprite/9sp_25" then
		rect = {50, 10, 17, 8}
	elseif v == "ui/zhuangshi_75" then
		rect = {450, 250, 66, 77}
	elseif v == "9sprite/9sp_heidi" then
		rect = {13, 13, 14, 14}
	elseif v == "9sprite/9sp_27" then
		rect = {22, 18, 22, 18}
	elseif v == "9sprite/a_9sp_06" then
		rect = {31,37,31,37}
	elseif v == "9sprite/a_9sp_03" then
		rect = {22,24,22,24}
	elseif v == "9sprite/a_9sp_05" then
		rect = {141,96,141,96}
	elseif v == "9sprite/a_9sp_02" then
		rect = {22,10,22,50}
	elseif v == "ui/a_line_01" then
		rect = {16,0,16,0}
	elseif v == "ui/a_line_02" then
		rect = {9,0,9,0}
	elseif v == "9sprite/a_9sp_ty_02" then
		rect = {35,35,40,40}
	elseif v == "9sprite/a_9sp_ty_02_02" then
		rect = {35,35,40,40}
	elseif v == "ui/by_line_03" then
		rect = {7,0,7,0}
	elseif v == "ui/a_k_bg_01" then
		rect = {135,23,40,23}
	elseif v == "9sprite/a_9sp_14" then
		rect = {15,15,15,15}
	elseif v == "9sprite/9sp_main_cl_02" then
		rect = {9,9,9,9}
	elseif v == "9sprite/a_9sp_13" then
		rect = {10,10,10,10}
	elseif v == "9sprite/a_9sp_ct_02" then
		rect = {3,3,3,3}
	elseif v == "9sprite/a_9sp_08_02" then
		rect = {3,3,3,3}
	elseif v == "9sprite/a_9sp_zz_01" then
		rect = {14,14,14,14}
	elseif v == "9sprite/a_9sp_18" then
		rect = {80,20,80,20}
	elseif v == "9sprite/a_9sp_ct_01" then
		rect = {8,8,8,8}
	elseif v == "9sprite/a_9sp_17" then
		rect = {33,33,33,33}
	elseif v == "ui/a_cangbaotubg_02" then
		rect = {220,40,50,40}
	elseif v == "9sprite/a_9sp_16" then
		rect = {25,25,25,25}
	elseif v == "9sprite/9sp_main_cl_01" then
		rect = {9,9,12,10}
	elseif v == "9sprite/a_9sp_hy_01" then
		rect = {80,54,10,10}
	elseif v == "ui/a_line_03" then
		rect = {20,3,20,3}
	elseif v == "9sprite/a_9sp_07" then
		rect = {60,20,10,20}
	elseif v == "9sprite/a_9sp_10" then
		rect = {36,36,36,36}
	elseif v == "9sprite/9sp_info_mask_01" then
		rect = {10,10,12,12}
	elseif v == "9sprite/a_9sp_25" then
		rect = {31,37,31,37}
	elseif v == "9sprite/a_9sp_20" then
		rect = {6,6,6,6}
	elseif v == "9sprite/a_9sp_26" then
		rect = {30,30,8,8}
	elseif v == "9sprite/a_9sp_22" then
		rect = {30,50,8,8}
	elseif v == "ui/chat_txk_01" then
		rect = {40, 40, 10, 10}
	elseif v == "9sprite/a_9sp_19" then
		rect = {50, 30, 8, 8}
	elseif v == "9sprite/a_9sp_29" then
		rect = {18, 20, 20, 22}
	elseif v == "9sprite/a_9sp_38" then
		rect = {20,38,20,38}
	elseif v == "9sprite/a_9sp_15" then
		rect = {16,16,16,16}
	elseif v == "9sprite/a_9sp_30" then
		rect = {33,24,33,24}
	elseif v == "9sprite/a_9sp_43" then
		rect = {50, 9, 45, 11}
	elseif v == "9sprite/a_9sp_27" then
		rect = {18, 21, 28, 14}
	elseif v == "9sprite/a_9sp_34" then
		rect = {22,26,22,26}
	elseif v == "9sprite/a_9sp_35" then
		rect = {22,26,22,26}
	elseif v == "9sprite/a_9sp_36" then
		rect = {22,26,22,26}
	elseif v == "9sprite/a_9sp_37" then
		rect = {22,26,22,26}
	elseif v == "9sprite/a_9sp_44" then
		rect = {22,26,22,26}
	elseif v == "9sprite/a_9sp_31" then
		rect = {46,20,46,20}
	elseif v == "9sprite/a_9sp_ct_03" then
		rect = {3,3,3,3}
	elseif v == "9sprite/a_9sp_12" then
		rect = {36,40,36,20}
	elseif v == "9sprite/a_9sp_40" then
		rect = {226,20,20,20}
	elseif v == "button/btn_41" then
		rect = {33,33,33,33}
	elseif v == "leader_res/jzxt_9sp_01" then
		rect = {44,44,44,44}
	elseif v == "9sprite/a_9sp_41" then
		rect = {44,10,44,10}
	elseif v == "9sprite/a_9sp_42" then
		rect = {44,10,44,10}
	elseif v == "9sprite/a_9sp_51" then
		rect = {38,11,38,11}
	end
	return rect
end


--@param    sName:要切割的字符串  
--@return   nMaxCount，字符串上限,中文字为2的倍数  
--@param    nShowCount：显示英文字个数，中文字为2的倍数,可为空  
--@note     函数实现：截取字符串一部分，剩余用“...”替换 
function cls:indentString(sName, nMaxCount, nShowCount)  
	if sName == nil or nMaxCount == nil then  
		return  
	end  
	local sStr = sName  
	local tCode = {}  
	local tName = {}  
	local nLenInByte = #sStr  
	local nWidth = 0  
	if nShowCount == nil then  
	   nShowCount = nMaxCount - 3  
	end  
	for i=1,nLenInByte do  
		local curByte = string.byte(sStr, i)  
		local byteCount = 0;  
		if curByte>0 and curByte<=127 then  
			byteCount = 1  
		elseif curByte>=192 and curByte<223 then  
			byteCount = 2  
		elseif curByte>=224 and curByte<239 then  
			byteCount = 3  
		elseif curByte>=240 and curByte<=247 then  
			byteCount = 4  
		end  
		local char = nil  
		if byteCount > 0 then  
			char = string.sub(sStr, i, i+byteCount-1)  
			i = i + byteCount -1  
		end  
		if byteCount == 1 then  
			nWidth = nWidth + 1  
			table.insert(tName,char)  
			table.insert(tCode,1)  
			  
		elseif byteCount > 1 then  
			nWidth = nWidth + 2  
			table.insert(tName,char)  
			table.insert(tCode,2)  
		end  
	end  
	  
	if nWidth > nMaxCount then  
		local _sN = ""  
		local _len = 0  
		for i=1,#tName do  
			_sN = _sN .. tName[i]  
			_len = _len + tCode[i]  
			if _len >= nShowCount then  
				break  
			end  
		end  
		sName = _sN .. "..."  
	end  
	return sName  

end

--@brief 屏蔽触摸阴影层
function cls:touchLayer(node, touch)
	local layer = display.newLayer(Const.LayerColor):size(display.width,display.height)--cc.c4b(0,0,0,0.95)
	layer:onTouch(function() 
		if touch == nil then
			return true 
		end
		return touch
	end, nil, true)
	layer:addTo(node, -1)
	return layer
end

function cls:centerView(view)
	if RESET_DISPLAY_HEIGHT <= 0 then
		return
	end

	view:setPositionY(view:getPositionY() + RESET_DISPLAY_HEIGHT / 2)
end

function cls:addBlackLayer(node)
	if RESET_DISPLAY_HEIGHT <= 0 then
		return
	end

	local dy = RESET_DISPLAY_HEIGHT / 2
	display.newLayer(cc.c4b(0,0,0,1)):addTo(node, -10):pos(0, -dy)
	node:setPositionY(dy)
end

-- 窗体自适应常规处理
-- posList 统计一向便宜屏幕增加高度
-- heightList 所有高度增加屏幕增加高度（记得向下对齐）
-- scaleList　所有缩放值用当前屏幕高度/720(记得向下对齐)
-- posList2 偏移半高
function cls:resize(posList, heightList, scaleList, posList2)
	if RESET_DISPLAY_HEIGHT == 0 then
		return
	end
	posList = posList or {}
	heightList = heightList or {}
	scaleList = scaleList or {}
	posList2 = posList2 or {}
	-- 按扭整体偏移
	for k,v in ipairs(posList) do
		v:setPositionY(v:getPositionY() + RESET_DISPLAY_HEIGHT)
	end

	-- 窗体变高
	for k,v in ipairs(heightList) do
		local size = v:getContentSize()
		size.height = size.height + RESET_DISPLAY_HEIGHT
		v:setContentSize(size)
	end

	-- 缩放
	for k,v in ipairs(scaleList) do
		local size = v:getContentSize()
		v:scale(display.height / 720)
	end

	-- 按扭整体偏移/半高
	if posList2 then
		local dy = RESET_DISPLAY_HEIGHT / 2
		for k,v in ipairs(posList2) do
			v:setPositionY(v:getPositionY() + dy)
		end
	end
end

function cls:touchLayout(node)
	local layout = ccui.Layout:create()
	layout:setContentSize(display.size)
	layout:setAnchorPoint(display.CENTER)
	layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	layout:setBackGroundColor(Const.LayerColor)
	layout:setOpacity(255*0.5)
	layout:addTo(node, -1):center()
end

--@brief 获取兵种的某属性值
function cls:getForceAttr(forceId, attrType)
	local forceAttr = db.DBarracksAttr[forceId]
	for i =1, 99 do
		if not forceAttr["dataType"..i] or
			forceAttr["dataType"..i] == 0 then
			break
		end
		if forceAttr["dataId"..i] == attrType then
			return forceAttr["value"..i]
		end
	end
	return 0
end

--@brief 获得物品信息
function cls:getGoodsData(type, id)
	local vo = {}
	if type == Const.TData.TPropCannot then                 -- 不可使用道具
		vo = id and db.DPropCannot[id] or db.DPropCannot
	elseif type == Const.TData.TProp then                   -- 可使用道具
		vo = id and db.DProp[id] or db.DProp
	elseif type == Const.TData.TPropTime then               -- 可使用缩短时间道具
		vo = id and db.DPropTime[id] or db.DPropTime
	elseif type == Const.TData.TPropLogic then              -- 可使用逻辑性道具  
		vo = id and db.DPropLogic[id] or db.DPropLogic
	elseif type == Const.TData.TPropTimeType then           -- 缩短时间逻辑类型
		vo = id and db.TPropTimeType[id] or db.TPropTimeType
	elseif type == Const.TData.TPropImmediately then        -- 道具立即使用类
		vo = id and db.DPropImmediately[id] or db.DPropImmediately
	elseif type == Const.TData.TEquipMaterial then          --装备材料
		vo = id and db.DEquipMaterial[id] or db.DEquipMaterial
	elseif type == Const.TData.TEquip then                  --装备
		vo = id and db.DEquip[id]
	elseif type == Const.TData.TForce then
		vo = id and db.DNForcesAttr[id] or db.DNForcesAttr
	elseif type == Const.TData.TPropUnion then
		vo = id and db.DPropUnion[id] or db.TPropUnion
	elseif type == Const.TData.TPropCommon then
		vo = id and db.DPropCommon[id] or db.DPropCommon
	elseif type == Const.TData.TMechaMaterial then
		vo = id and db.DMechaMaterial[id] or db.DMechaMaterial
	elseif type == Const.TData.TEquipDrawing then
		vo = id and db.DEquipDrawing[id] or db.DEquipDrawing
	elseif type == Const.TData.TForceType then
		local level = AlgoUtil:getForceLevel(id)
		vo = id and db.DNForcesAttr_type_lv_map[id][level]
	elseif type == Const.TData.TLeaderDebris then
		vo = id and db.DLeaderDebris[id] or db.DLeaderDebris
	elseif type == Const.TData.TLeader then
		vo = id and db.DLeader[id] or db.DLeader
	elseif type == Const.TData.TCannonArmour then
		vo = id and db.DCannonArmour[id] or db.DCannonArmour
	end
	return vo
end

--获取物品配置 大类型，小类型
function cls:getConfigsTSType(itemtype, smalltype)
	local configs = self:getGoodsData(itemtype)
	local datas = {}
	for k, v in pairs(configs or {}) do
		if v.type and smalltype == v.type then
			table.insert(datas, v)
		end
	end

	table.sort(datas, function (a, b)
		if a.quality and b.quality then
			return a.quality < b.quality
		end
	end)

	return datas
end

--@brief 获得物品图标
function cls:getGoodsIcon(type, id, isSmallType)
	if not type or not id then
		return ""
	end
	local vo = nil
	local path = nil
	if type == Const.TData.TEquipMaterial then      --装备材料
		path = "equip_materials"
	elseif type == Const.TData.TEquip then              --装备
		path = "equip"
	elseif type == Const.TData.TForce then 				--兵种
		path = "flagship"
	elseif type == Const.TData.TMechaMaterial then 			--联盟集体积分
		path = "materials"
	elseif type == Const.TData.TEquipDrawing then --装备图纸
		path = "equip_materials"
	elseif type == Const.TData.TForceType then
		path = "flagship"
	elseif type == Const.TData.TLeader then
		path = "leader"
	elseif type == Const.TData.TLeaderDebris then
		path = "leader_debris"
	elseif type == Const.TData.TCannonArmour then
		path = "armour_icon"
	else
		path = "prop"
	end

	if isSmallType then
		if type == Const.TData.TForce or type == Const.TData.TForceType then
			path = path .. "90"
		elseif type ~= Const.TData.TEquip and
				type ~= Const.TData.TLeaderDebris and
				type ~= Const.TData.TLeader and
				type ~= Const.TData.TCannonArmour  then
			path = path .. "40"
		end
	end

	vo = self:getGoodsData(type, id)
	path = path .."/" ..(vo and (vo.pic or vo.id) or "")
	if not self:exists(self:path(path)) then
		print("Util:getGoodsIcon---------->>", string.format("没找到类型 %d,ID %d的图标%s", type, id, path))
		path = "ui/build_menu_icon_3001"
	end
	return path
end

function cls:getItemQualityIcon(quality,itemType,itemId)
	if itemType == Const.TData.TEquip then
		return string.format("quality/m_zb_ad_0%d", checknumber(quality))
	elseif itemType == Const.TData.TMechaMaterial then
		local config = Util:getGoodsData(itemType,itemId)
		if config and config.type == 2 then
			return string.format("quality/chengpin_0%d", checknumber(quality))
		else
			return string.format("quality/bk_0%d", checknumber(quality))
		end
	elseif itemType == Const.TData.TLeader then
		return string.format("quality/bk_0%d", checknumber(quality))
	elseif itemType == Const.TData.TCannonArmour then
		return string.format("quality/chengpin_0%d", checknumber(quality))
	else
		return string.format("quality/bk_0%d", checknumber(quality))
	end
end

function cls:getItemNameIcon(quality,itemType)
	if itemType == Const.TData.TEquip then
		return string.format("quality/zl_0%d", checknumber(quality))
	else
		return string.format("quality/sl_0%d", checknumber(quality))
	end
end

function cls:getEquipQualityIcon(quality)
	return string.format("quality/m_zb_ad_0%d", checknumber(quality))
end

--@brief 获取缺少的资源数量
function cls:getNeededMoreItemLst(lst)
	local needMore = {}
	for _, v in ipairs(lst) do
		local count = v.count - PackModel:getItemCount(v.type, v.id)
		if count > 0 then
			table.insert(needMore, {type=v.type, id=v.id, count=count})
		end
	end
	return needMore
end

--@brief 获取建筑效果
function cls:getBuildingEffect(buildingType, buildingLv)
	local buildEffect = db.DBuildEffect_type_lv_map[buildingType][buildingLv]
	local lst = {}
	for i = 1, 20 do
		local dataType = buildEffect["dataType"..i]
		local dataId = buildEffect["dataId"..i]
		local value = buildEffect["value"..i]
		local percent = buildEffect["percent"..i]
		if not dataType or
			dataType == 0 then
		else
			if value > 0 then
				table.insert(lst, {dataType=dataType, dataId=dataId, value=value})
			end
			if percent > 0 then
				table.insert(lst, {dataType=dataType, dataId=dataId, percent=percent})
			end
		end

		
	end
	return lst
end

--@brief 几个小时之前
function cls:before(time)
	local formerly = self:time() - time
	--天数
	local d = formerly / 60 / 60 /24
	--小时
	local h = formerly / 60 / 60 
	--分钟
	local m = formerly / 60 
	--秒
	local s = formerly
	if math.floor(d) ~= 0 then
		return self:split2rich(Lang:find("jilutian"),{math.floor(d)},Const.Color.ExplainStair,Const.Color.ExplainStair)
	elseif math.floor(h) ~= 0 then
		return self:split2rich(Lang:find("jilushi"),{math.floor(h)},Const.Color.ExplainStair,Const.Color.ExplainStair)
	elseif math.floor(m) ~= 0 then
		return self:split2rich(Lang:find("jilufen"),{math.floor(m)},Const.Color.ExplainStair,Const.Color.ExplainStair)
	elseif math.floor(s) ~= 0 then
		return self:split2rich(Lang:find("jilumiao"),{math.floor(s)},Const.Color.ExplainStair,Const.Color.ExplainStair)
	end
end



function cls:createConsumeToButton(itemdata, isShowWhite)
	local layout = ccui.Layout:create()
	layout:setAnchorPoint(display.CENTER)
	-- layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
	-- layout:setBackGroundColor(cc.c3b(64, 64, 64), cc.c3b(192, 192, 192))
	layout:setContentSize(cc.size(0, 30))

	local spiItemIcon = false
	local lblNumber = false
	local list = {}

	function layout:setItemData(itemdata)
		layout:removeAllChildren()
		layout:setContentSize(cc.size(0, 30))
		spiItemIcon = false
		lblNumber = false
		list = {}

		if not spiItemIcon then
			spiItemIcon = Util:sprite("empty")
			table.insert(list, spiItemIcon)
		end
		
		local wordColor = Const.Color.SystemHint
		if isShowWhite then
			wordColor = Const.Color.ExplainFoxpro
		end

		if not lblNumber then
			lblNumber = Util:label("", 16, wordColor)
			table.insert(list, lblNumber)
		end

		if not itemdata then
			return
		end

		local path = Util:path(Util:getGoodsIcon(itemdata:getDataType(), itemdata:getItemId(), true))
		spiItemIcon:loadTexture(Util:exists(path) and path or Util:path("button/btn_main_09"))
		spiItemIcon:scale(0.7)
		layout.icon = spiItemIcon
		layout.num = lblNumber
		lblNumber:setString(itemdata:getItemCount())

		Util:addToCenter(layout, list, -10)
	end

	layout:setItemData(itemdata)
	return layout
end


--@brief 获取玩家头像
function cls:getUserHead(uuid, defaultIconId)
	-- TODO : 查找本地头像文件
	defaultIconId = defaultIconId or 1 -- 玩家自定义头像之外的默认头像
	local path = "head/dk_" .. defaultIconId
	if GAME_CFG.area == Area.arabic then
		path = "ar/" .. path
	end
	if not self:exists(self:path(path)) then
		print("****ERROR 玩家头像不存在",defaultIconId)
		path = "head/dk_1"
	end

	return path
end

function cls:getUserBody(uuid, defaultImgId)
	defaultImgId = defaultImgId or 1 -- 玩家自定义头像之外的默认头像

	local path = "head/hk_" .. defaultImgId
	if GAME_CFG.area == Area.arabic then
		path = "ar/" .. path
	end
	if not self:exists(self:path(path)) then
		print("****ERROR 玩家头像不存在",defaultIconId)
		path = "head/hk_1"
	end
	return path
end
--
function cls:formatToString(data, format)
	local x = ""
	for k, v in pairs(data or {}) do
		if k == table.nums(data) then
			x = x..v
		else
			x = x..v..format
		end
	end
	return x
end

function cls:checknumbers(values)
	local datas = {}
	for k, v in pairs(values) do
		datas[k] = checknumber(v)
	end
	return datas
end

--@brie 根据数据类型获取减cd 的道具,sort 是否需要排序
function cls:getAcceleratePropLst(dataType, sort)
	local canUseLst = {} -- 可用于建筑减cd 的数据id, type
	for _, v in pairs(db.DPropTime) do
		if v.dataId == Const.TPropTimeType.cd_all or
			v.dataId == dataType then
			table.insert(canUseLst, {id=v.id, type=Const.TData.TPropTime, dataId = v.dataId})
		end
	end
	local propLst = {} -- 背包拥有的道具
	for _, v in ipairs(canUseLst) do
		local prop = PackModel:getItem(v.type, v.id)
		if prop and prop.count > 0 then
			prop.dataId = v.dataId
			table.insert(propLst, prop)
		end
	end

	if not sort then
		return propLst
	end

	table.sort(propLst, function(v1, v2)
		if v1.dataId == v2.dataId then -- 同类型
			local dbData1 = db.DPropTime[v1.id]
			local dbData2 = db.DPropTime[v2.id]
			if dbData1.value > 0 and dbData2.value > 0 then
				return dbData1.value < dbData2.value
			elseif dbData1.percent > 0 and dbData2.percent > 0 then
				return dbData1.percent < dbData2.percent
			end
		end

		return v1.dataId > v2.dataId
	end)

	return propLst
end

function cls:addToCenter(layout, items, offsetX)
	if not layout then
		layout = ccui.Layout:create()
		layout:setContentSize(cc.size(0, 0))
		layout:setAnchorPoint(display.CENTER)
		-- layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
		-- layout:setBackGroundColor(cc.c3b(64, 64, 64), cc.c3b(192, 192, 192))
	end
	local tap = clone(layout:getAnchorPoint())
	layout:setAnchorPoint(display.LEFT_CENTER)

	offsetX = offsetX or 80
	local lw = layout:width()
	local lh = layout:height()
	for n, m in ipairs(items) do
		if m:height() > lh then
			lh = m:height()
		end
		m:addTo(layout)
		lw = layout:width() + (m:width() + offsetX)
		layout:width(lw)
	end
	layout:height(layout:height() > 0 and layout:height() or lh)

	local tw = offsetX/2
	for i, v in ipairs(items) do
		v:setAnchorPoint(display.LEFT_CENTER)
		v:pos(tw, layout:height()/2)
		tw = tw + v:width() + offsetX
	end
	layout:setAnchorPoint(tap)
	return layout
end

function cls:checkNodeHitNode(node1, node2, offsetW1, offsetH1)
	local wp1 = node1:getParent():convertToWorldSpace(node1:pos())
	local up1 = cc.Director:getInstance():convertToUI(wp1)
	local glp1 = cc.Director:getInstance():convertToGL(up1)
	
	local wp2 = node2:getParent():convertToWorldSpace(node2:pos())
	local up2 = cc.Director:getInstance():convertToUI(wp2)
	local glp2 = cc.Director:getInstance():convertToGL(up2)
	
	local rect1 = node1:getBoundingBox()
	local rect2 = node2:getBoundingBox()
	rect1 = cc.rect(math.abs(rect1.x), math.abs(rect1.y), rect1.width + offsetW1, rect1.height + offsetH1)
	rect2 = cc.rect(math.abs(rect2.x), math.abs(rect2.y), rect2.width, rect2.height)
	
	rect1.x = glp1.x
	rect1.y = glp1.y
	
	rect2.x = glp2.x
	rect2.y = glp2.y

	-- print("checkNodeHitNode----->>11", rect1.x, rect1.y, rect1.width, rect1.height)
	-- print("checkNodeHitNode----->>22", rect2.x, rect2.y, rect2.width, rect2.height)
	return cc.rectIntersectsRect(rect1, rect2)
end

function cls:checkTouchInNode(event, node, parent)
	local np = false
	if parent then
		np = parent:convertToNodeSpace(cc.p(event.x, event.y))
	else
		local up = cc.Director:getInstance():convertToUI(cc.p(event.x, event.y))
		np = cc.Director:getInstance():convertToGL(up)
	end
	local rect = node:getBoundingBox()
	rect = cc.rect(math.abs(rect.x), math.abs(rect.y), rect.width, rect.height)
	return cc.rectContainsPoint(rect, np)
end

function cls:checkOpen(dataType, dataId, value)
	if dataType == Const.TData.TBuild then
		local building = BuildingModel:getBuilding(dataId)
		if not building then
			return false
		end
		return building.lv >= value
	elseif dataType == Const.TData.TPlayerData then
		if dataId == Const.TPlayerData.player_lv then
			return User.info.level >= value 
		elseif dataId == Const.TPlayerData.monster_plan then
			return User.mstRecord >= value
		end
	end
end

function cls:getValue(dataType, dataId)
	if dataType == Const.TData.TBuild then
		local building = BuildingModel:getBuilding(dataId)
		if not building then
			return 0
		end
		return building.lv
	elseif dataType == Const.TData.TPlayerData then
		if dataId == Const.TPlayerData.player_lv then
			return User.info.level
		elseif dataId == Const.TPlayerData.monster_plan then
			return User.mstRecord
		end
	else
		return PackModel:getItemCount(dataType, dataId)
	end
	return 0
end

function cls:checkOpenFuncDb(openFuncId, isShowTips, buyOpenRhand)
	local isOpened, isCharged, openDb = FuncOpenModel:checkOpenFuncDb(openFuncId)
	if not isOpened and isShowTips then
		local dataType = openDb.dataType
		local dataId = openDb.dataId
		local value = openDb.value
		local isOpened = false
		local str = ""
		if dataType == Const.TData.TBuild then
			local name = db.DBuildConfig_type_lv_map[dataId][1].name
			str = Lang:format(openDb.clickAlert, {name, value})
		elseif dataType == 2 then
			local t = Util:time() - User.timeInfo.registerTime
			local leftTime = value - t
			str = Lang:find("xjjp_jhtx", Util:formatTime(leftTime))
			if value == -1 then
				str = Lang:format(openDb.clickAlert)
			end
		end

		if openDb.clickAlert ~= "" then
			Tips.show(str)
		end
	end

	if isOpened and not isCharged and isShowTips then -- 功能可以开启，但是需要购买
		local chargeDb = db.DBuildConfig_type_lv_map[openDb.chargeId][1]
		local itemdata = ItemBaseData:create(Const.TPropCannot.jewel, Const.TData.TPropCannot, chargeDb.itemCount1)
		local chargeLst = {}
		local name = ""
		for i = 1, 9 do
			local itemType = chargeDb["itemType" .. i]
			local itemId = chargeDb["itemId" ..i]
			local itemCount =chargeDb["itemCount" .. i]
			if itemType and itemType > 0 then
				local dbData = Util:getGoodsData(itemType, itemId)
				name = name .. dbData.name..itemCount .. ","
			else
				break
			end
		end
		name = string.sub(name , 1, string.len(name)-1)
		local msg = Msg.createConsumeMsg(Lang:find("sureOpenFunc", name, openDb.explain),
			function()
				Net:call(function(v, msg)
					if v.error ~= 0 then
						return
					end
					local openFunc = v.result[1]
					local items = v.result[2]
					local funcId = checknumber(openFunc.typeId)
					if v.result[2] then
						PackModel:update(items)
					end
					FuncOpenModel:updateChargedLst(funcId)
					if buyOpenRhand then
						buyOpenRhand(funcId)
					end
				end, "MainCity", "funcOpen", User.info.uid, openFuncId)
			end)
		TaskTutorial:checkGuideId(msg, OPEN_PLOT_GUIDEID1)
		TaskTutorial:checkGuideId(msg, OPEN_PLOT_GUIDEID2)
	end

	return isOpened and isCharged
end


function cls:createAniWithCsb(fileName, speed, startIndex, endIndex, loop)
	local path = Util:path("csb/" .. fileName, ".csb")
	if not self:exists(path) then
		dump(path,"**** CSB 文件不存在")
		return nil,nil
	end

    local node = cc.CSLoader:createNode(path)
    local timeline = cc.CSLoader:createTimeline(path)
	local _, action = node:runAction(timeline)
	node.runTimeline = function (speed, startIndex, endIndex, loop)
		speed = speed or 1
		if loop ~= false then
			loop = true
		end
	    timeline:setTimeSpeed(speed)
	    if startIndex and endIndex then
	    	timeline:gotoFrameAndPlay(startIndex, endIndex, loop)
		elseif endIndex then
		    timeline:gotoFrameAndPlay(0, endIndex, loop)
		else
			startIndex = startIndex or 0
	        timeline:gotoFrameAndPlay(startIndex, loop)
		end
	end
	node.runTimeline(speed, startIndex, endIndex, loop)
    return node, timeline
end

function cls:getTalentIcon(pic)
	local path = self:path(string.format("talent/%d", pic))
	if not self:exists(path) then
		print("can not find path---------->>", path)
		path = self:path("ui/build_menu_icon_3001")
	end
	return path
end

--@brief 检测是否可以迁城
function cls:checkIsCanMoveCity()
	for _, v in ipairs(MarchQueueModel.marchQueues) do
		if v.status ~= MarchQueueModel.STATE_IDLE then
			Tips.show(Lang:find("moveCityNeeded"))
			return false	
		end
	end

	local activityData = ActivityModel:getActivityData(Const.TActivityType.HBOSS)
	local now = Util:time()
	local hasJoin = HBossUtil:hasJoinActivity()

	if activityData and 
		now < activityData.endTime and
		now > activityData.startTime and
		HBossModel.hBossUnion and
		HBossModel.hBossUnion.timeId < #db.DHBossTime and
		hasJoin and HBossModel.hBossUser.failureCount < 2 then
		 -- 3511 【时空大战】在活动期间可以用“迁城”
		Tips.show(Lang:find("cant_move_city_in_hboss"))
		return false
	end
	return true
end

---------------------------------------------------------------------
-- 使用物品 itemdata (ItemBaseData)
function cls:useItem(itemdata, infoview)
	local itemid = itemdata:getItemId()
	local itemtype = itemdata:getDataType()
	local itemcount = itemdata:getItemCount()

	local function toCallFunc(inputcount)
		--使用立即使用道具
		if itemtype == Const.TData.TPropImmediately then
			if itemid == Const.TPropImmediately.random_move then -- 随机迁城
				if not Util:checkIsCanMoveCity() then
					return
				end

				Msg.new(Lang:find("sureRandomMoveCity"), function()
					Net:call(function(v, msg)
						if v.error ~= 0 then
							return
						end
						User:update(v.result[1])
						PackModel:update(v.result[3])
						CityCtrl:enterWorld()
					end,"Map", "randomMoveBuild", User.info.uid)
				end)
				return
			elseif itemid == Const.TPropImmediately.talent_reset then -- 天赋重置
				TalentCtrl:openTalentView()
				return
			elseif itemid == Const.TPropImmediately.alter_name then -- 领主改名
				CommanderCtrl:openCommanderRenameView()
				return
			elseif itemid == Const.TPropImmediately.alter_image then -- 更换形象
				CommanderCtrl:openCommanderImageView()
				return
			elseif itemid == Const.TPropImmediately.horn then 		-- 喇叭
				CityCtrl:backToMainView()
				SocialCtrl:showChatView(ChannelType.PUBLIC_CHAT, true)
				return
			elseif itemid == Const.TPropImmediately.union_moved then -- 联盟迁城令
				if not Util:checkIsCanMoveCity() then
					return
				end
				Net:call(function(v, msg)
					if v.error ~= 0 then
						return
					end
					ViewStack:clear()
					ViewStack:pop()

					local targetCell = WorldMapModel:strToRC(v.result)
					WorldCtrl:unionMoveCastle(targetCell)
				end,"Map", "unionMoved", User.info.uid)
			elseif itemid == Const.TPropImmediately.advanced_move then -- 高级迁城
				if not Util:checkIsCanMoveCity() then
					return
				end
				local userCell = WorldMapModel:strToRC(User.info.area)
				WorldCtrl:moveCity(userCell)
				PackCtrl:closePackWin()
			end
		--使用可使用道具
		elseif itemtype == Const.TData.TProp then
			if inputcount <= 0 then
				Tips.show(Lang:find("GoodsImporCount"))
				return
			end

			PackProxy:useItem(itemid, inputcount)
			
		--使用逻辑性道具
		elseif itemtype == Const.TData.TPropLogic then
			local isuse = false
			local dbInfo = nil
			-- 在主城增益道具购买查看对应ID的buff类型
			for _ ,v in pairs(db.DGainBuy) do
				if v.itemType == Const.TData.TPropLogic and v.itemId == itemid then
					dbInfo = v
					break
				end
			end
			for i,v in pairs(CityBuffModel.buffLst) do
				-- 同类型buff只可覆盖
				local curInfo = db.DGainBuy[v.id]
				if dbInfo and curInfo and dbInfo.type == curInfo.type then
					isuse = true
					break
				end
			end
			local dbInfo = Util:getGoodsData(itemtype,itemid)
			if dbInfo.dataType == Const.TData.TPropLogicType and dbInfo.dataId == Const.TPropLogicType.vip_temporary_point then
				local vipInfo = VIPModel:getUserVipInfo()
				if vipInfo.time + vipInfo.tmpCd > Util:time() then
					isuse = true
				end
			end
			if not isuse then
				local useitem = clone(itemdata)
				useitem:setItemCount(1)
				local isAcclerateCollection = false
				local buildType = nil
				if itemid == Const.TPropLogic.increase_metal then -- 铁矿场提升
					isAcclerateCollection = true
					buildType = Const.TBuild.metal_factory
				elseif itemid == Const.TPropLogic.increase_gas then -- 炼气场提升
					isAcclerateCollection = true
					buildType = Const.TBuild.gas_factory
				elseif itemid == Const.TPropLogic.increase_energy then -- 能源场提升
					isAcclerateCollection = true
					buildType = Const.TBuild.energy_factory
				elseif itemid == Const.TPropLogic.increase_crystal then -- 掘晶场提升
					isAcclerateCollection = true
					buildType = Const.TBuild.crystal_factory
				end

				if isAcclerateCollection then
					local buildingLst = BuildingModel:getAllNoBuffCollectionBuilding(buildType)
					local count = inputcount
					if #buildingLst > 0 and count > 0 then
						local lvStr = ""
						local typeId = ""
						local name = ""
						local day = db.DPropLogic[itemid].time/(60*60*24)
						for i,buildInfo in ipairs(buildingLst) do
							local dbData = db.DBuildConfig_type_lv_map[buildInfo.type][1]
							name = dbData.name
							if i <= count then
								typeId = typeId .. buildInfo.typeId .. ","
								lvStr = lvStr == "" and buildInfo.lv or Lang:find("link",lvStr,buildInfo.lv)
							end
						end
						if typeId == "" then return end
						Msg:create(Lang:find("buildProduceSpeedUse", lvStr, name, day), function()
							CityCtrl:propIncreaseResource(typeId)
						end, function()end)
					else
						Tips.show(Lang:find("noMineCanAcclerate"))
					end
				elseif dbInfo.dataType == Const.TData.TPropLogicType and dbInfo.dataId == Const.TPropLogicType.treasure_map then
					-- 藏宝图
					CityCtrl:gotoUseTreasureProp()
				else
					PackModel:consumeItem(useitem, Lang:find("useItem", useitem:getItemName()), function ( ... )
						PackProxy:usePropLogic(itemid)
					end, confirmtxt, noRemind)
				end
			else
				-- 同类型道具
				Msg.new(Lang:find("same_city_buff"), function ( ... )
					PackProxy:usePropLogic(itemid)
				end, function()end)
				return
			end
		elseif itemtype == Const.TData.TPropCannot then
			if itemid == Const.TPropCannot.machine_key then
				MaterialCtrl:addCapacityView(function ()
				end)
			end
		else
			Tips.show(Lang:find("不可使用道具")..itemdata:getItemName())
		end
		PackCtrl:closeItemOperateView()
	end
	
	if itemtype == Const.TData.TPropLogic and not infoview then
		toCallFunc()
	else
		if infoview then
			infoview:setData(itemdata, toCallFunc)
		else
			PackCtrl:openItemOperateView(itemdata, toCallFunc)
		end
	end
end

-- 购买物品
function cls:buyItem(shopid, infoview)
	local shopvo = ShopModel:getShopVo(shopid)
	local shopconfig = shopvo.shopConfig
	local itemdata = shopvo.shopData
	if not itemdata or itemdata:getItemId() <= 0 then
		return
	end
	local function toCallFunc(inputcount)
		if ShopModel:getCanBuyCount(shopvo.shopId) > 0 then
			PackModel:useJewel(
				shopconfig.consumeCount * inputcount,
				Lang:find("surebuyGoodFromShop",
				shopconfig.consumeCount * inputcount,
				inputcount, itemdata:getItemName()),
				function()
					PackProxy:buy(checknumber(shopvo.shopId), checknumber(inputcount))
				end
			,nil,"ShopBuy")
		else
			GiftCtrl:enterView()
			-- GoldGuideView.new()
		end
	end
	if infoview then
		infoview:setData(itemdata, toCallFunc, shopvo.shopId)
	else
		PackCtrl:openItemOperateView(itemdata, toCallFunc, shopvo.shopId)
	end
end

--[[比较两个时间，返回相差多少时间]]  
-- function cls:timediff(long_time,short_time)  
--     local n_short_time,n_long_time,carry,diff = os.date('*t',short_time),os.date('*t',long_time),false,{}  
--     local colMax = {60,60,24,os.date('*t',os.time{year=n_short_time.year,month=n_short_time.month+1,day=0}).day,12,0}  
--     n_long_time.hour = n_long_time.hour - (n_long_time.isdst and 1 or 0) + (n_short_time.isdst and 1 or 0) -- handle dst  
--     for i,v in ipairs({'sec','min','hour','day','month','year'}) do  
--         diff[v] = n_long_time[v] - n_short_time[v] + (carry and -1 or 0)  
--         carry = diff[v] < 0  
--         if carry then  
--             diff[v] = diff[v] + colMax[i]  
--         end  
--     end  
--     return diff  
-- end  
  
 function cls:timediff(long_time,short_time)  
	local n_short_time = os.date('*t',short_time)
	local n_long_time  = os.date('*t',long_time)
	local carry        = false
	local diff         = {}
	
    local colMax = {os.date('*t',os.time{year=n_short_time.year,month=n_short_time.month+1,day=0}).day,12,0}

    for i,v in ipairs({'day','month','year'}) do  
        diff[v] = n_long_time[v] - n_short_time[v] + (carry and -1 or 0)  
        carry = diff[v] < 0  
        if carry then  
            diff[v] = diff[v] + colMax[i]  
        end  
    end  
    return diff  
end  

function cls:numToShort(count)
	if count >= 1000 then
		local x, y = math.modf(count / 1000)
		-- count = string.format("%.3fk", x..y)
		-- count = string.format("%.dk", x)
		count = (x + y).."k"
	end
	return count
end

-- 随机提示
function cls:randomTips(tipsType)
    local str = ""
    local lst = {}
    local totalWeight = 0
    for _,v in pairs(db.DTipsContent) do
        if v.type == tipsType then
        	totalWeight = totalWeight + v.weight
        	table.insert(lst,{desc = v.desc,weight = totalWeight})
        end
    end
    local index = math.random(1,totalWeight)
    local desc = ""
    local preWeight = 0
    for _,v in ipairs(lst) do
    	if index > preWeight and index <= v.weight then
    		desc = v.desc
    		break
    	end
    	preWeight = v.weight
    end
    return desc
end

-- 行星距离
function cls:kilometer(v)
	return Lang:find("kilometer" , string.format("%.3f ", v / 10))
end

function cls:splitToItem(param, itemclass)
	local list = {}
	local datas = {}
	itemclass = itemclass or ItemCell
	if not param or param == "" then
		return list, datas
	end
	local params = string.split(param, ",")
	for i, v in ipairs(params) do
		local info = Util:checknumbers(string.split(v, "_"))
		local cell, celldata = itemclass:createItemFromDb(info[1], info[2], info[3])
		table.insert(list, cell)
		table.insert(datas, celldata)
	end
	return list, datas
end

function cls:centerNode(gap,...)
	gap = gap or 0
	local node = display.newNode()
	local param = ...
    local itemLst = nil
    if type(param) ~= "table" then
        itemLst = {...}
    else
        itemLst = param
    end
    local width = 0
    local height = 0
    for _,v in ipairs(itemLst) do
        v:addTo(node)
        width = width + v:width()
        height = math.max(height,v:height())
    end
    width = width + (#itemLst - 1) * gap
    node:size(width,height)
    node:anchor(display.CENTER)
    local x = 0
    for i,v in ipairs(itemLst) do
    	v:align(display.LEFT_CENTER,x,height / 2)
    	x = x + v:width() + gap
    end
    return node
end

function cls:popupHandler(view,rectNode,callback)
	if not view then
		return
	end
	local layer = display.newLayer(Const.LayerColor)
	layer:addTo(view,-100)
	layer:onTouch(function (event)
		local np = rectNode:convertToNodeSpace(cc.p(event.x,event.y))
		local rect = cc.rect(0,0,rectNode:width(),rectNode:height())
		if not cc.rectContainsPoint(rect,np) then
			if event.name == "ended" then
				if callback then
					callback()
				end
			end
			return true
		end
		return true
	end,nil,true)
end

-- 返回数据排序,默认按ID
function cls:getSortData(data, func)
	if not func then
		func = function(v1, v2)
			return v1.id < v2.id
		end
	end

	local list = {}
	for k1,v1 in pairs(data) do
		local isAdd = false
		for k2,v2 in ipairs(list) do
			if func(v1, v2) then
				isAdd = true
				table.insert(list, k2, v1)
				break
			end
		end

		if not isAdd then
			table.insert(list, v1)
		end
	end

	return list
end

function cls:createEmptySp(view)
	view.emptyImg = Util:sprite("empty")
						:size(150,70)
						:addTo(view)
						:align(display.RIGHT_BOTTOM,display.width,0)
end

-- 仓库可购买资源道具显示列表
function cls:getStorageBuyLst(itemType,itemId)
	local showLst = {}
	for _,dbInfo in pairs(db.DStorageBuy) do
		if dbInfo.itemType == itemType and dbInfo.itemId == itemId then
			local count = PackModel:getItemCount(dbInfo.showType,dbInfo.showId)
			if dbInfo.buy == 1 then
				if count > 0 then
					table.insert(showLst,dbInfo)
				end
			elseif dbInfo.buy == 2 then
				table.insert(showLst,dbInfo)
			end
		end
	end
	table.sort(showLst,function (a,b)
		return a.id < b.id
	end)
	return showLst
end

function cls:getStringLen(str)
	return string.len(str)
	-- if str == "" then
	-- 	return 0
	-- end
	-- local strLen = 0
 --    local len = string.len(str)
 --    local i = 1
 --    while i <= len do
 --        local c = string.byte(str,i)
 --        local shift = 1
 --        if c > 0 and c <= 127 then
 --            if c < 47  -- 0
 --                or c > 57 and c < 65 -- 0 ~ A
 --                or c > 90 and c < 97 -- Z ~ a
 --                or c > 122 then -- z
 --            end
 --            shift = 1
 --        elseif c < 192 then
 --            shift = 1
 --        elseif c < 224 then
 --            shift = 2
 --        elseif c < 240 then
 --            shift = 3
 --        elseif notName ~= true then
 --            Tips.new(lang:get(3))
 --            return false
 --        end 

 --        i = i + shift

 --        if shift == 1 then
 --            strLen = strLen + 1
 --        else
 --            strLen = strLen + 2
 --        end
 --    end

 --    return strLen
end

--@brief 从数据库获取奖励数据
function cls:getRewardFromDb(data, keys)
    if not data then
        return {}
    end
    keys = keys or {"itemType", "itemId", "itemCount"}
    local lst = {}
    for i = 1, 999 do
        local vType = data[keys[1]..i]
        local id = data[keys[2]..i]
        local count = data[keys[3]..i]
        if not id or not vType or not count then
            break
        end
        if vType ~= 0 or id ~= 0 then
            table.insert(lst, {itemType = vType, itemId = id, itemCount = count})
        end
    end
    return lst
end

function cls:button9Scale(btn,width,height)
	if not btn then return end
	btn:ignoreContentAdaptWithSize(false)
	btn:setScale9Enabled(true)
	btn:size(width,height)
end

function cls:getFightSpaceShipPic(shipId, direction)
	local attrDb = db.DNForcesAttr[shipId]
	local path = ""
	if direction == 1 then
		path = string.format("f_spaceship/l_%d", attrDb.pic)
	else
		path = string.format("f_spaceship/r_%d", attrDb.pic)
	end
	if not Util:exists(Util:path(path)) then
		print("***ERROR 不存在飞船图片", shipId, direction)
		if direction == 1 then
			path = string.format("f_spaceship/l_%d", 101)
		else
			path = string.format("f_spaceship/r_%d", 101)
		end
	end

	return path
end

function cls:createAgeStar(level,gap)
	gap = gap or 8
	local dbInfo = db.DAgeLevelConfig[level]
	if not dbInfo then return display.newNode() end
	local maxStar = 0
	local curStar = 0
	for _,v in pairs(db.DAgeLevelConfig) do
		if v.stage == dbInfo.stage then
			maxStar = maxStar + 1
			if dbInfo.id >= v.id then
				curStar = curStar + 1
			end
		end
	end
	local starPath = "wenming/a_xingxing_01"
	local starLst = {}
	for i = 1,maxStar do
		if i <= curStar then
			local sp = Util:sprite(starPath)
			table.insert(starLst,sp)
		else
			local sp = Util:sprite("wenming/a_xingxing_02")
			table.insert(starLst,sp)
		end
	end
	local centerNode = Util:centerNode(gap,starLst)
	return centerNode
end

function cls:arrowAction(node,time,offsetY)
	node:run{"rep",
		{"seq",
			{"moveby",time,cc.p(0,offsetY)},
			{"moveby",time,cc.p(0,-offsetY)}
		}
	}
end

function cls:createItemIcon(itemType,itemId,itemCount,useLeaderData)
	if itemType ~= Const.TData.TLeader then
		return ItemCell:createItemFromDb(itemType,itemId,itemCount)
	else
		return LeaderIcon.new(itemId,useLeaderData)
	end
end

-- 飘字action
function cls:labelAction(label)
    label:run{
        "seq",
        {"scaleto",0.1,1.1},
        {"scaleto",0.01,1},
        {
            "spa",
            {"moveby",0.8,cc.p(0,60)},
            {"fadeout",0.8},
        },
        {"remove"},
    }
end

function cls:gameCountDown(view,callback)
	local layer = display.newLayer()
	layer:addTo(view)
	layer:onTouch(function ()
		return true
	end,false,true)
	local numSp = Util:number(12,true)
					:addTo(layer)
					:pos(display.cx,display.cy)
	local value = 3
	numSp:value(value)
	numSp:scale(3)
	numSp:opacity(0)
	numSp:run{"rep",
		{"seq",
			{"spa",
				{"scaleto",1,1},
				{"fadein",1},
			},
			{"call",function ()
				value = value - 1
				numSp:value(value)
				numSp:scale(3)
				numSp:opacity(0)
				if value <= 0 then
					layer:remove()
					callback()
				end
			end}
		}
	}
end

return cls

