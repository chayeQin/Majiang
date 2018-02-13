--
-- Author: lyt
-- Date: 2017-03-07 09:56:36
--
local cls = {}

if not TEST_DEV then
	cls.reset = function()end
	return cls
end

cls.require = require

function cls.reset()
	require = cls.require
end

function cls.find(dir, fileName)
	for file in lfs.dir(dir) do
	    if file == fileName then
	    	return true
	    elseif string.lower(file) == string.lower(fileName) then
	    	return false,file
	    end
	end

	return false
end

-- local t = io.popen('svn help')
-- local a = t:read("*all")
require = function(name, ...)
	local arr = string.split(name, ".")
	arr[#arr] = arr[#arr] .. ".lua"
	local path = "src/"

	for k,v in ipairs(arr) do
		local check,file = cls.find(path, v)
		if check then
			path = path .. v .. "/"
		else
			if file then
				print("*** 文件大小写不一样:")
				print("*** 你输入的是:", name)
				local arr2 = string.split(path, "/")
				table.remove(arr2, 1)
				file = table.concat(arr2, ".") .. file
				print("*** 实际文件名为:", file)
			else
				print("*** 文件不存在:", name)
			end
			assert(false)
		end
	end

	return cls.require(name, ...)
end

return cls