--
--@brief 加密模块
--@author qyp
--@date 2015/8/19
--

local cls = class("Crypto")

function cls.md5(input, isRawOutput)
    input = tostring(input)
    if type(isRawOutput) ~= "boolean" then isRawOutput = false end
    return cc.Crypto:MD5(input, isRawOutput)
end


function cls.md5file(path)
    return cc.Crypto:MD5File(path)
end

return cls


