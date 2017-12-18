--
-- Author: qyp
-- Date: 2017/02/20
--

local cls = class("UnicodeUtil")

--@brief 获取输入语言的语种
function cls:getInputLang(input)
	local len  = string.len(input)
    local left = len
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    local langMap = {}
    local enCache = {}
    while left ~= 0 do
    	local start = len-left+1
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end

        local val = 0
        for j = 1, i do -- utf-8 转unicode字符集
        	local index = start -1 + j
        	local c = string.byte(input, index)
        	if j == 1 then
        		c = c - arr[i]
        	else
        		c = c - 0x80
        	end
        	val = val + c * 2^(6*(i-j))
        end

        local lang = UnicodeUtil:charLang(val)
        if lang ~= -1 then
	        langMap[lang] = langMap[lang] or 0
	        langMap[lang] = langMap[lang] + 1
	    end
    end

    local lang =  nil
    local count = 0
    for tmpLang ,v in pairs(langMap) do
    	if v > count then
    		lang = tmpLang
    		count = v
    	end
    end

    return lang
end

function cls:charLang(val)
	if val >= 0x4E00 and val <= 0x9FA5 then -- 中文
		return cc.LANGUAGE_CHINESE
	elseif  0x3040 <= val and
		val <= 0x309F or
		0x30A0 <= val and
		val <= 0x30FF then -- 日文
		return cc.LANGUAGE_JAPANESE
	elseif 0x1100 <= val and
		val <= 0x11FF or --韩文字母
		0x3130 <= val and 
		val <= 0x318F  or -- 韩文兼容字母 
		0xAC00 <= val and
		val <= 0xD7AF or -- 韩文音节 
		0xA960 <= val and
		val <= 0xA97F or-- 韩文字母扩展A
		0xD7B0 <= val and
		val <= 0xD7FF then -- 韩文字母扩展B
		return cc.LANGUAGE_KOREAN
	elseif 65 <= val and
		val <= 122 then -- 英文
		return cc.LANGUAGE_ENGLISH
	elseif 0x0100 <= val and
		val <= 0x017F then -- 法文
		return cc.LANGUAGE_FRENCH
	elseif 0x0400 <= val and
		val <= 0x04FF then -- 俄文
		return cc.LANGUAGE_RUSSIAN 
	else
		return -1
	end
end

return cls
