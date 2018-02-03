
local ViewBase = class("ViewBase", cc.Node)

function ViewBase:ctor(app, name)
    if TEST_DEV and self.__cname~="Majiang" then
        print("****** ",self.__cname)
    end
    
    self:enableNodeEvents()
    self.app_ = app
    self.name_ = name
    -- check CSB resource file
    local res = rawget(self.class, "RESOURCE_FILENAME")
    if res then
        self:createResoueceNode(res)
    end

    local binding = rawget(self.class, "RESOURCE_BINDING")
    if res and binding then
        self:createResoueceBinding(binding)
    end

    if self.onCreate then self:onCreate() end
end

function ViewBase:getApp()
    return self.app_
end

function ViewBase:getName()
    return self.name_
end

function ViewBase:getResourceNode()
    return self.resourceNode_
end

function ViewBase:createResoueceNode(resourceFilename)
    if self.resourceNode_ then
        self.resourceNode_:removeSelf()
        self.resourceNode_ = nil
    end
    
    if not Util:exists(resourceFilename) then
        dump(resourceFilename,"**** CSB 文件不存在")
        return
    end

    self.resourceNode_ = cc.CSLoader:createNode(resourceFilename)
    assert(self.resourceNode_, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", resourceFilename))
    self:addChild(self.resourceNode_)
end

function ViewBase:showWithScene(transition, time, more)
    self:setVisible(true)
    local scene = display.newScene(self.name_)
    scene:addChild(self)
    display.runScene(scene, transition, time, more)
    return self
end

-- demo:
--[[
MainScene.RESOURCE_BINDING = {
    -- 获取按钮，self.btn 并绑定触摸回调 handler(self, self.onButtonEnter)
    ["ProjectNode_1.Button_Enter"] = {
            varname = "btn",
            method = "onButtonEnter",
        }
    -- 获取组件 
    ["ProjectNode_1.label"] = "label",
}
--]]
function ViewBase:createResoueceBinding(binding)
    assert(self.resourceNode_, "ViewBase:createResoueceBinding() - not load resource node")
    for fullName, v in pairs(binding) do
        local var = v
        if type(v) == "string" then
            var = {varname = v}
        end
        local callback = var.method
        local varname = var.varname
        local node = self:findResouece(fullName, callback)
        if node then
            self[varname] = node
            -- 只执行其中一个
            local test = self:buidingTable(varname,node) or 
                         self:buidingEditBox(varname,node)
        else
            print("ERROR*** can not find node", fullName)
        end
    end
end

-- 绑定Table
function ViewBase:buidingTable(varname,node)
    if string.sub(varname,1,5) ~= "table" then
        return false
    end
    local csbName = string.sub(varname,7)
    if not csbName or csbName == "" then
        return false
    end

    local binding = rawget(self.class, varname)
    TableExtend.bind(node,csbName,binding)
    return true
end

-- 绑定EditBox
function ViewBase:buidingEditBox(varname,node)
    if string.sub(varname,1,3) ~= "txt" then
        return false
    end

    local size = node:getContentSize()
    local editBox = Util:editBox(size)
    editBox:setPlaceholderFontSize(20)
    editBox:addTo(node)
        :pos(size.width/2,size.height/2)
    self[varname] = editBox

    return true
end

-- 全名如:layer1.btnOk
function ViewBase:findResouece(fullName,callback)
    if not fullName or fullName == "" then
        return nil
    end

    local names = string.split(fullName,".")
    if not names or #names == 0 then
        return
    end
    local lastName = ""
    local parent = self:getResourceNode()
    for k,name in ipairs(names) do
        if not parent then
            break
        end

        if not parent[name] then
            parent[name] = parent:getChildByName(name)
        end

        lastName = name
        parent = parent[name]
    end

    local typeName = tolua.type(parent)
    if typeName == "ccui.Text" then-- 读取语言包
        -- 读取内容
        local langStr = parent:getString()
        local langText = Lang:find(langStr)
        if langText ~= langStr then 
            parent:setString(langText)
        elseif string.sub(lastName, 1, 5) == "lang_" then
            local txt = string.sub(lastName, 6)
            local str = Lang:find(txt)
            if str ~= langStr then
                parent:setString(str)
            end
        end

        -- 右对齐
        if Lang.isRTL and parent:getTextHorizontalAlignment() == cc.TEXT_ALIGNMENT_LEFT then
            parent:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_RIGHT)
        end
    end

    if typeName == "ccui.Text" or
        typeName == "ccui.TextField" or
        typeName == "ccui.EditBox" then
        parent:setFontName(Lang:getFont())
    end

    if typeName == "ccui.EditBox" and
        Lang.isRTL and
        parent.setTextHorizontalAlignment then
        parent:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_RIGHT)
    end

    if typeName == "ccui.Button" then
        local titleTxt = parent:getTitleText()
        local str = Lang:find(titleTxt)
        parent:setTitleText(str)
        parent:setTitleFontName(Lang:getFont())
        local lab = parent:getTitleRenderer()
        -- lab:enableShadow()
    end

    if not callback or not parent then
        return parent
    end

    local func = self[callback]
    if not func then
        return parent
    end

    if typeName == "ccui.Button" or
        typeName == "ccui.CheckBox" then
        parent:addClickEventListener(function(target)
            -- TODO: play button click sound
            Sound:play("sound/other/"..52)
            Util:event(Event.assistantClick)
            local guideName = target.guideName
            func(self, target)
        end)
    else
        parent:onTouch(handler(self, func))
    end

    return parent
end

function ViewBase:createTimeline()
    local resourceFilename = rawget(self.class, "RESOURCE_FILENAME")
    local timeline = cc.CSLoader:createTimeline(resourceFilename)
    return timeline
end

function ViewBase:runTimeline(startIndex, endIndex, loop, speed)
    local resourceFilename = rawget(self.class, "RESOURCE_FILENAME")
    local timeline = cc.CSLoader:createTimeline(resourceFilename)
    speed = speed or 1
    timeline:setTimeSpeed(speed)
    self:runAction(timeline)
    startIndex = startIndex or 0
    if endIndex then
        timeline:gotoFrameAndPlay(startIndex, endIndex, loop)
    else
        timeline:gotoFrameAndPlay(startIndex, loop)
    end
end

function ViewBase:runTimelineWithName()
end

function ViewBase:onExit_()
    self:onExit()
    if self.onExitCallback_ then
        self:onExitCallback_()
    end
    
    self:removeTexture_(self)
end

local NOT_RELESE = {
    ["cc.Node"]       = true,
    ["ccui.Text"]     = true,
    ["ccui.Layout"]   = true,
    ["cc.Layer"]      = true,
    ["ccui.Widget"]   = true,
    ["cc.Label"]      = true,
    ["cc.LayerColor"] = true,
    ["ccui.RichText"] = true,
    ["cc.LabelAtlas"] = true,
    ["ccui.EditBox"] = true,
    ["ccui.ListView"] = true,
    ["ccui.RadioButtonGroup"] = true,
}

function ViewBase:removeTexture_(parent)
    if not parent or parent.isNotClear then
        return
    end

    local t = tolua.type(parent)
    if t == "cc.Sprite" then
        local texture = parent:getTexture()
        cc.Director:getInstance():getTextureCache():removeTexture(texture)
    elseif t == "ccui.ImageView" or t == "ccui.Button" or t == "ccui.LoadingBar" then
        local sp9     = parent:getVirtualRenderer()
        local sp      = sp9:getSprite()
        if sp then
            local texture = sp:getTexture()
            cc.Director:getInstance():getTextureCache():removeTexture(texture)
        end
    elseif t == "ccui.Scale9Sprite" then
        local sp = parent:getSprite()
        if sp then
            local texture = sp:getTexture()
            cc.Director:getInstance():getTextureCache():removeTexture(texture)
        end
    elseif t == "ccui.CheckBox" or t == "ccui.RadioButton" then
        local sp = parent:getVirtualRenderer()
        if sp then
            local texture = sp:getTexture()
            cc.Director:getInstance():getTextureCache():removeTexture(texture)
        end
    elseif not NOT_RELESE[t] then
        print("****** NOT_RELESE ", t)
    end

    local arr = parent:getChildren()
    for k,v in ipairs(arr) do
        self:removeTexture_(v)
    end
end

return ViewBase
