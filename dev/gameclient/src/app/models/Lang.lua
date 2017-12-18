--
-- Author: lyt
-- Date: 2013-12-12 10:13:15
-- 语言包处理类
local Lang = class("Lang")
Lang.__index = Lang

Lang.FONTS = {
}

Lang.RTL = { -- 向右对齐的语言
    ar = true,
}

function Lang:init()
    self.map = nil
    local lang = Util:load("game_lang")
    if not lang then
        lang = GAME_CFG.lang or device.language
    end
    if not Lang.FONTS[lang] then
        lang = "en"
    end
    self:setLang(lang)
end

function Lang:setLang(lang)
    self.lang_        = lang
    self.langFont     = Lang.FONTS[lang] or ""
    self.isRTL        = Lang.RTL[lang]
    initData()
    self.map = {}
    if db.TGameText then
        for k,v in pairs(db.TGameText) do
            self.map[v.key] = v
        end
    end
    Util:save("game_lang",lang)
end

function Lang:getFont()
    return self.langFont
end

function Lang:getLang()
    return self.lang_
end

function Lang:randName()
    local name = db.DName
    local str=name[math.random(1,#name)].name
    if string.len(str)<=9 then
        local str2=name[math.random(1,#name)].name
        while string.len(str .. str2)>18 do 
            str2=name[math.random(1,#name)].name
        end
        str=str .. str2
    end
    return str
end

-- 将fmt 里的{1}{2}....换成对应的参数
function Lang:format(fmt,...)
    local params = ...
    if type(params) ~= "table" then
        params = {...}
    end

    local index = nil
    for _k,v in pairs(params) do
        index = string.find(v,"%%")
        if index then
            v = string.gsub(v,"%%", "%%%%")
        end
        fmt = string.gsub(fmt,"{" .. _k .. "}",v)
    end
    return fmt
end

function Lang:find(key,...)
    local item = self.map[key]
    -- print("k1=" .. key1 .. " k2=" .. key2)
    if item == nil or item.data == nil then
        return key
    end

    if item.data == "" then
        return item.data
    end

    if TEST_LANG then
        return key
    end
    return self:format(item.data, ...)
end

-- 将字符连接在一起,自动处理是左右阅读(阿拉拍)
function Lang:link(...)
    local args = {...}
    local str = ""
    if self.isRTL then
        for k, v in ipairs(args) do
            str = self:find(v) .. " " .. str
        end
    else
        for k, v in ipairs(args) do
            str = str .. self:find(v)
        end
    end

    return str
end

-- 窗口排序转换
function Lang:initAlignNode()
    if not Lang.LINK_NODE_RTL then
        Lang.LINK_NODE_RTL = {
            [display.LEFT_TOP] = display.RIGHT_TOP,
            [display.LEFT_CENTER] = display.RIGHT_CENTER,
            [display.LEFT_BOTTOM] = display.RIGHT_BOTTOM,
        }
        Lang.LINK_NODE_LTL = {
            [display.RIGHT_TOP] = display.LEFT_TOP,
            [display.RIGHT_CENTER] = display.LEFT_CENTER,
            [display.RIGHT_BOTTOM] = display.LEFT_BOTTOM,
        }
    end
end

-- 所有控件左向右排序
function Lang:linkNode(leftX, y, rightX, dWidth, align, ...)
    self:initAlignNode()

    align = align or display.LEFT_BOTTOM

    local args = {...}
    local sx , dx, dxs = 0, 0, 1

    if self.isRTL then
        local tmpAlign = Lang.LINK_NODE_RTL[align]
        if tmpAlign ~= nil then
            align = tmpAlign
        end

        sx = rightX
        dx = -dWidth
        dxs = -1 -- 减去控件大小
    else
        sx = leftX
        dx = dWidth
        dxs = 1 -- 加上控件大小
    end

    for k,v in ipairs(args) do
        v:setPosition(sx, y)
        v:setAnchorPoint(align)
        sx = sx + dx + v:getContentSize().width * dxs
    end
end

-- 两个控件左右贴边
function Lang:balance(leftX, y, rightX, leftAlign, left, right)
    self:initAlignNode()

    leftAlign        = leftAlign or display.LEFT_BOTTOM
    local rightAlign = display.RIGHT_CENTER
    local tmpAlign   = Lang.LINK_NODE_RTL[leftAlign]
    if tmpAlign ~= nil then
        rightAlign = tmpAlign
    else
        rightAlign   = Lang.LINK_NODE_LTL[leftAlign] or leftAlign
    end

    if self.isRTL then
        leftX, rightX        = rightX, leftX
        leftAlign,rightAlign = rightAlign, leftAlign
    end

    if left then
        left:setPosition(leftX, y)
        left:setAnchorPoint(leftAlign)
    end

    if right then
        right:setPosition(rightX, y)
        right:setAnchorPoint(rightAlign)
    end
end

return Lang