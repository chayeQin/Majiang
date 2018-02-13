--[[

Copyright (c) 2011-2014 chukong-inc.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

--[[--

]]

-- Node
local Node = cc.Node

function Node:remove()
    self:removeSelf()
end

function Node:enabled(b)
    self:setEnabled(b)
    return self
end

function Node:tick(callback,delay)
    transition.execute(self,nil,{delay=delay,onComplete=callback})
    return self
end

function Node:pos(x, y)
    if not x then
        return {x = self:x(), y = self:y()}
    end
    if y then
        self:setPosition(x, y)
    else
        self:setPosition(x)
    end
    return self
end

function Node:alignTo(n, len, isVertical)
    local x = n:x()
    local y = n:y()
    if isVertical then
        self:pos(n:x(), n:y() + len)
    else
        self:pos(n:x() + len, n:y())
    end
    return self
end

function Node:center(offsetx, offsety)
    local parent = self:getParent()
    if not parent or parent:width()==0 then
        self:setPosition(display.cx + (offsetx or 0), display.cy + (offsety or 0))
    else
        self:setPosition(parent:width()/2 + (offsetx or 0),parent:height()/2 + (offsety or 0))
    end
    return self
end

function Node:anchor(x, y)
    if not x then
        return self:getAnchorPoint()
    elseif type(x) == "table" then
        self:setAnchorPoint(x)
    else
        self:setAnchorPoint(cc.p(x, y))
    end
    return self
end

function Node:scale(scale)
    self:setScale(scale)
    return self
end

function Node:unschedule(handle)
    if handle then
        handle:remove()
    end
end

function Node:schedule(callback, interval, forever)
    local scheduleNode = display.newNode()
    self:add(scheduleNode)
    interval = interval or 0
    local action = transition.sequence({
        cc.DelayTime:create(interval),
        cc.CallFunc:create(callback),
    })

    if forever~=false then
        action = scheduleNode:runAction(cc.RepeatForever:create(action))
    else
        action = scheduleNode:runAction(action)
    end
    return scheduleNode
end

function Node:size(width, height)
    if not width then
        return self:getContentSize()
    elseif type(width) == "table" then
        self:setContentSize(width)
    else
        self:setContentSize(cc.size(width, height))
    end
    return self
end

function Node:opacity(opacity)
    self:setOpacity(opacity)
    return self
end

function Node:zorder(z)
    if not z then
        return self:getLocalZOrder()
    end
    
    self:setLocalZOrder(z)
    return self
end

function Node:stop()
    transition.stopTarget(self)
    return self
end

-- 设置按扭显示宽度
function Node:buttonDimensions(width,height)
    local lab = self:getTitleRenderer()
    lab:setDimensions(width, height or 0)
    lab:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    return self
end


-- Sprite
local Sprite = cc.Sprite

Sprite.playOnce = Sprite.playAnimationOnce
Sprite.playForever = Sprite.playAnimationForever

function Sprite:displayFrame(frame, index)
    if type(frame) == "string" then
        self:setDisplayFrame(frame, index or 0)
    else
        self:setDisplayFrame(frame)
    end
    return self
end

function Sprite:flipX(b)
    self:setFlippedX(b)
    return self
end

function Sprite:flipY(b)
    self:setFlippedY(b)
    return self
end

function Sprite:loadTexture(v)
    self:setTexture(v)
    return self
end

--增加监听
function Node:onTouch(callback, isMultiTouches, swallowTouches)
    if type(isMultiTouches) ~= "boolean" then isMultiTouches = false end
    if type(swallowTouches) ~= "boolean" then swallowTouches = false end
    local listener, beganEvent, movedEvent, endedEvent, cancelledEvent = nil

    if isMultiTouches then
        listener = cc.EventListenerTouchAllAtOnce:create()
        beganEvent = cc.Handler.EVENT_TOUCHES_BEGAN
        movedEvent = cc.Handler.EVENT_TOUCHES_MOVED
        endedEvent = cc.Handler.EVENT_TOUCHES_ENDED
        cancelledEvent = cc.Handler.EVENT_TOUCHES_CANCELLED
    else
        listener = cc.EventListenerTouchOneByOne:create()
        beganEvent = cc.Handler.EVENT_TOUCH_BEGAN
        movedEvent = cc.Handler.EVENT_TOUCH_MOVED
        endedEvent = cc.Handler.EVENT_TOUCH_ENDED
        cancelledEvent = cc.Handler.EVENT_TOUCH_CANCELLED
    end

    local function handleTouchEvent(state, touches)
        if not self:isVisible() then --不可见时不响应点击
            return
        end
        local event = {name = state}
        if isMultiTouches then
            local points ={}
            for _, v in ipairs(touches) do
                local x = v:getLocation().x
                local y = v:getLocation().y
                local id = v:getId()
                points[id] = {x = x, y = y, id = id}
            end
            event.points = points
        else
            local touch = touches
            event.x = touch:getLocation().x
            event.y = touch:getLocation().y

            -- local p = self:convertToNodeSpace(cc.p(event.x, event.y))
            -- local rect = cc.rect(0, 0, self:width(), self:height())
            -- if not cc.rectContainsPoint(rect, p) and event.name == "began" then
            --     return false
            -- end

        end
        event.target = self
        return callback(event)
    end

    listener:registerScriptHandler(function(touches, unuseParam)
        return handleTouchEvent("began", touches)
    end, beganEvent)
    listener:registerScriptHandler(function(touches, unuseParam)
        return handleTouchEvent("moved", touches)
    end, movedEvent)
    listener:registerScriptHandler(function(touches, unuseParam)
        return handleTouchEvent("ended", touches)  
    end, endedEvent)
    listener:registerScriptHandler(function(touches, unuseParam)
        return handleTouchEvent("cancelled", touches)
    end, cancelledEvent)

    if not isMultiTouches then
        listener:setSwallowTouches(swallowTouches)
    end
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

--额外扩展

--紧接着对齐
function Node:rightTo(t, offsetx, offsety)
    local align = t:getAnchorPoint()
    self:align(display.LEFT_CENTER, t:x() + (1-align.x)*t:width() + (offsetx or 0), t:y() + (offsety or 0))
    return self
end

function Node:leftTo(t, offsetx, offsety)
    local align = t:getAnchorPoint()
    local x, y = t:x() + (1-align.x)*self:width() + (offsetx or 0), t:y() + (offsety or 0)
    self:align(display.RIGHT_CENTER, x, y)
    return self
end

function Node:rightTop(p, offsetx, offsety)
    local x = p:width() + offsetx
    local y = p:height() + offsety
    self:pos(x, y)
end

function Node:x(v)
    if v ~= nil then
        self:setPositionX(v)
        return self
    end
    return self:getPositionX()
end

function Node:y(v)
    if v ~= nil then
        self:setPositionY(v)
        return self
    end
    return self:getPositionY()
end

function Node:width(v)
    if v ~= nil then
        return self:size(v,self:height())
    end
    return self:getContentSize().width
end

function Node:scaleY(v)
    if v then
        self:setScaleY(v)
    else
        return self:getScaleY()
    end
    return self
end

function Node:scaleX(v)
    if v then
        self:setScaleX(v)
    else
        return self:getScaleX()
    end
    return self
end

function Node:height(v)
    if v ~= nil then
        return self:size(self:width(),v)
    end

    return self:getContentSize().height
end


--判断是否包含点传入世界坐标
function Node:isContain(x, y)
    local np = self:convertToNodeSpace(cc.p(x, y))
    local width = self:width()
    local height = self:height()
    return np.x >= 0 and np.x <= width and np.y >= 0 and np.y <= height
end

local action_map = {
 MOVETO           =  cc.MoveTo,
 MOVEBY           =  cc.MoveBy,
 ROTATETO         =  cc.RotateTo,
 ROTATEBY         =  cc.RotateBy,
 SCALETO          =  cc.ScaleTo,
 SCALEBY          =  cc.ScaleBy,
 FADEIN           =  cc.FadeIn,
 FADEOUT          =  cc.FadeOut,
 FADETO           =  cc.FadeTo,
 SHOW             =  cc.Show,
 HIDE             =  cc.Hide,
 REMOVE           =  cc.RemoveSelf,
 CALL             =  cc.CallFunc,
 DELAY            =  cc.DelayTime,
 FLIPX            =  cc.FlipX,
 FLIPY            =  cc.FlipY,
 CAMERA           =  cc.OrbitCamera,
 PLACE            =  cc.Place,
 REUSEGRID        =  cc.ReuseGrid,
 TOGGLEVISIBILITY =  cc.ToggleVisibility,
 JUMPBY           =  cc.JumpBy,
 PROGRESSTO       =  cc.ProgressTo,
 PROGRESSFROMTO   =  cc.ProgressFromTo,
 REVERSETIME      =  cc.ReverseTime,
 SKEWTO           =  cc.SkewTo,
 TINTTO           =  cc.TintTo,
 TINTBY           =  cc.TintBy,
 SHAKY3D          =  cc.Shaky3D,--{"Shaky3D",1,CCSize(10,10),1,false}
 SHAKYTILES3D     =  cc.ShakyTiles3D,--{"SHAKYTILES3D",10,CCSize(10,10),1,false}
 WAVES            =  cc.Waves,--{"WAVES",10,CCSize(10,10),10,10,true,true}
 WAVES3D          =  cc.Waves3D,--{"WAVES3d",10,CCSize(10,10),10,10}
 FLIPX3D          =  cc.FlipX3D,
 FLIPY3D          =  cc.FlipY3D,
 PAGETURN3D       =  cc.PageTurn3D,
 LENS3D           =  cc.Lens3D,
 Liquid           =  cc.Liquid, -- 只能用cc.NodeGrid:create(), 参数:时间, 网格大小, 速度, 振幅
}

local action_ease = {
    BACKIN           =  cc.EaseBackIn,
    BACKINOUT        =  cc.EaseBackInOut,
    BACKOUT          =  cc.EaseBackOut,
    BOUNCE           =  cc.EaseBounce,
    BOUNCEIN         =  cc.EaseBounceIn,
    BOUNCEINOUT      =  cc.EaseBounceInOut,
    BOUNCEOUT        =  cc.EaseBounceOut,
    ELASTIC          =  cc.EaseElastic,
    ELASTICIN        =  cc.EaseElasticIn,
    ELASTICINOUT     =  cc.EaseElasticInOut,
    ELASTICOUT       =  cc.EaseElasticOut,
    EXPONENTIALIN    =  cc.EaseExponentialIn,
    EXPONENTIALINOUT =  cc.EaseExponentialInOut,
    EXPONENTIALOUT   =  cc.EaseExponentialOut,
    IN               =  cc.EaseIn,
    INOUT            =  cc.EaseInOut,
    OUT              =  cc.EaseOut,
    RATEACTION       =  cc.EaseRateAction,
    SINEIN           =  cc.EaseSineIn,
    SINEINOUT        =  cc.EaseSineInOut,
    SINEOUT          =  cc.EaseSineOut
}
local action_mutil = {
    SEQ  = cc.Sequence,
    SPA  = cc.Spawn,
}
local function createAction(map)
    local key = string.upper(map[1])
    -- 循环
    if "REP" == key then
        return cc.RepeatForever:create(createAction(map[2]))
    elseif "REPC" == key then -- 循环次数
        return cc.Repeat:create(createAction(map[3]),map[2])
    end
    -- 多个效果
    if action_mutil[key] then
        local arr = {}
        for i = 2,#map do
            table.insert(arr,createAction(map[i]))
        end
        return action_mutil[key]:create(arr)
    end
    -- 正常缓类
    local cls1,cls2,j,param1,param2 = nil
    cls1 = key
    cls2 = nil
    -- 查找是否有缓类
    param1 = false
    param2 = nil
    for i = 2,#map do
        if type(map[i]) == "string" then
            param1 = true
            j = i
            cls2 = string.upper(map[i])
            break
        end
    end
    -- 拷贝参数
    if param1 then
        param1 = {}
        param2 = {}
        for i = 2,#map do
            if i < j then
                table.insert(param1,map[i])
            elseif i > j then
                table.insert(param2,map[i])
            end
        end
    else
        param1 = {}
        for i = 2,#map do
            table.insert(param1,map[i])
        end
    end

    -- 创建action
    assert(action_map[cls1] ~= nil,cls1 .. "类不存在")
    cls1 = action_map[cls1]
    j = cls1:create(unpack(param1))
    -- EASE 类
    if cls2 then
        assert(action_ease[cls2] ~= nil,cls2 .. "类不存在")
        cls2 = action_ease[cls2]
        j = cls2:create(j,unpack(param2))
    end
    return j    
end

--[[
单个
{"moveby",5.3,ccp(500,0)}
有EASE的类,ease参数和普通action一样，可以后面跟参数
{"moveby",5.3,ccp(500,0),"elasticout"}
队列 
run({"seq",{"delay",1},{"moveby",5.3,cc.p(500,0)},{"scaleto",5.3,100,0}})
并列
run({"spa",{"delay",1},{"moveby",5.3,cc.p(500,0)},{"scaleto",5.3,100,0}})
循环
run({"rep",{"delay",1},{"moveby",5.3,cc.p(500,0)},{"scaleto",5.3,100,0}})
三合一,停1秒后同时移动和缩放（移动是带EASE）,然后一直循环
run({
     "rep",
     {
         "seq",
         {"delay",1},
         {
             "spa",
             {"moveby",5.3,cc.p(500,0),"elasticout"},
             {"scaleto",5.3,100,0}
         }
     }
 })
--]]

function Node:run(v)
    if not v or type(v) ~= "table" then
        return self
    end
    local action = createAction(v)
    self:runAction(action)
    return self,action
end
