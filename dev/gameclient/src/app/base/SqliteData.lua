--
-- Author: lyt
-- Date: 2016-09-05 12:11:48
-- Sqlite查询使用,不用再手拼SQL
-- 需要注意 ： boolean 会以 0 和 1 存
-- 转换的类型取出时会还原，只是写SQL条件时需要注意
local cls = class("SqliteData")

function cls:ctor(tableName, defaultValue, primaryKey)
	assert(tableName ~= nil and tableName ~= "", "tableName is nil or empty")
	assert(defaultValue ~= nil, "defaultValue is nil")
	assert(primaryKey ~= nil and primaryKey ~= "", "primaryKey is nil or empty")

	self.tableName    = tableName -- 表名
	self.defaultValue = defaultValue -- 默认数据(也是数据格式)
	self.primaryKey   = primaryKey   -- 主建

	self.booleanMap = {} -- 保存所有值为boolean类型的KEY(提高性能)
	self.stringTransMap = {} -- 
	local columns = {}
	local types = {}
	for k,v in pairs(defaultValue) do
		local t = type(v)
		local typeValue = nil
		if type(k) == "number" then
			dump(v, "table 的key 必须是字符串:")

		elseif t == "number" then
			typeValue = "INTEGER"

		elseif t == "boolean" then
			typeValue = "INTEGER"
			self.booleanMap[k] = true

		elseif t == "string" then
			typeValue = "TEXT"
			self.stringTransMap[k] = true
		else
			dump(v, "table的value必须是字符串、整数或布尔值:")
		end

		if typeValue ~= nil then
			if k == primaryKey then
				table.insert(columns, 1, k)
				table.insert(types, 1, typeValue)
			else
				table.insert(columns, k)
				table.insert(types, typeValue)
			end
		end
	end

	self.columns = columns
	self.types = types
	if #columns == 0 or #types == 0 then
		dump(tableName,"*** 无可用字段")
	end

	if not Sqlite.exists(tableName) then
		local result = Sqlite.create(tableName, columns, types)
		if result ~= 0 then
			print("*** 创建表出错:", tableName)
		end
		return
	end

	local data = Sqlite.structure(tableName)
	if not data then
		print("*** 获取表结构失败:",tableName)
		self:reCreate()
		return
	end

	data = data.sql
	local index = string.find(data, "%(")
	data = string.sub(data, index + 1, string.len(data) - 1)
	local arr = string.split(data, ",")
	local map = {}
	self.oldKey = {}
	for k,v in ipairs(arr) do
		local arr2 = string.split(v, " ")
		while arr2[1] == "" do
			table.remove(arr2, 1)
		end
		if arr2[1] and arr2[2] then
			local key = string.gsub(arr2[1], "[%[ '\"%]]", "")
			local value = string.gsub(arr2[2], "[%[ '\"%]]", "")
			map[key] = value
		end
	end

	local newKey = {}
	for i,key in ipairs(columns) do
		local type1 = map[key]
		local type2 = types[i]
		if type1 ~= nil then
			if type1 ~= type2 then
				print("*** 表字符类型发生变化:",tableName)
				self:reCreate()
				return
			else
				map[key] = nil -- 相同的KEY
				table.insert(self.oldKey, key)
			end
		else
			newKey[key] = type2
		end
	end

	-- 存在不使用的key
	for k,v in pairs(map) do
		print("*** 表存在不使用字段:",tableName)
		self:reCreate()
		return
	end

	for k,v in pairs(newKey) do
		print("*** 表增加新字段:", k, v)
		Sqlite.addColumn(tableName, k, v)
	end
end

-- 重新创建表格
function cls:reCreate()
	if not self.oldKey then
		Sqlite.drop(self.tableName)
		Sqlite.create(self.tableName, self.columns, self.types)
		return
	end

	local tempName = Sqlite.getTempTableName()
	Sqlite.rename(self.tableName, tempName)
	Sqlite.create(self.tableName, self.columns, self.types)
	Sqlite.copy(tempName, self.tableName, self.oldKey)
end

-- 获取单条数据
function cls:getData(id)
	if not id or id == "" then
		dump("ID 为空")
		if TEST_DEV then
			assert(false)
		end
		
		return nil
	end
	local data = self:getList(self.primaryKey .. "='" .. id .. "'", nil, 1)
	
	return data[1]
end

-- 获取多条数据
function cls:getList(cond, order, limit, offset, keys)
	local list = Sqlite.select(self.tableName, cond, order, limit, offset, keys)
	for k,v in ipairs(list) do
		self:fixData(v)
	end

	return list
end

-- 查询指定字段
function cls:select(column, cond, order, limit, offset)
	local list = Sqlite.select(self.tableName, cond, order, limit, offset, column)
	for k,v in ipairs(list) do
		for key,value in pairs(v) do
			v[key] = self:restoreType(key, value)
		end
	end

	return list
end

-- 获取所有主键
function cls:getPrimaryKeyList(cond, order, limit, offset)
	local list = Sqlite.select(self.tableName, cond, order, limit, offset, self.primaryKey)
	local result = {}
	for k,v in ipairs(list) do
		table.insert(result, v[self.primaryKey])
	end

	return result
end

function cls:getCount(cond)
	return Sqlite.count(self.tableName, cond)
end

function cls:getCountByPrimaryKey(key)
	return self:getCount(self.primaryKey .. "='" .. key .. "'")
end

-- 插入数据和defaultValue格式是一样,多余的数值不会被插入
function cls:insert(data)
	local values = {}
	for i,key in ipairs(self.columns) do
		local value = data[key]
		if value == nil then
			value = self.defaultValue[key]
		end
		values[i] = self:transType(key, value)
	end
	return Sqlite.insert(self.tableName, self.columns, values)
end

-- 更新数据
function cls:update(data, keys, cond)
	local setstr = ""
	keys = keys or self.columns
	for i,key in ipairs(keys) do
		if self.primaryKey ~= key then
			local value = data[key]
			if value ~= nil then
				value  = self:transType(key, value)
				setstr = setstr .. key .. "='" .. value .. "',"
			end
		end
	end

	if setstr == "" then
		print("*** 没有需要更新字段数据")
		return false
	end
	setstr = string.sub(setstr, 0, string.len(setstr) - 1)

	local cond2 = self.primaryKey .. "='" .. data[self.primaryKey] .. "'"
	if cond then
		cond2 = cond2 .. " and " .. cond
	end

	return Sqlite.update(self.tableName, cond2, setstr)
end

-- 更新某几个字段
function cls:updateColumns(data, cond)
	local setstr = ""
	for i,key in ipairs(self.columns) do
		local value = data[key]
		if value ~= nil then
			value  = self:transType(key, value)
			setstr = setstr .. key .. "='" .. value .. "',"
		end
	end

	if setstr == "" then
		print("*** 没有需要更新字段数据")
		return false
	end
	setstr = string.sub(setstr, 0, string.len(setstr) - 1)

	return Sqlite.update(self.tableName, cond, setstr)
end

function cls:deleteByPrimaryKey(key)
	return self:delete(self.primaryKey .. "='" .. key .. "'")
end

function cls:delete(cond)
	return Sqlite.delete(self.tableName, cond)
end

function cls:deleteLimit(cond, order, limit, offset)
	return Sqlite.deleteLimit(self.tableName, self.primaryKey, cond, order, limit, offset)
end

function cls:clear()
	return Sqlite.clear(self.tableName)
end

-- 完善数据
function cls:fixData(data)
	for k,v in pairs(self.defaultValue) do
		if data[k] == nil then
			data[k] = v
		else
			data[k] = self:restoreType(k, data[k])
		end
	end
end

-- 将数据转换成存储数据
function cls:transType(key, value)
	if self.booleanMap[key] then
		value = value and 1 or 0
		return value
	elseif self.stringTransMap[key] then
		local saveStr = string.gsub(value, "'", "''")
		return saveStr
	end

	return value
end

-- 还原数据
function cls:restoreType(key, value)
	if self.booleanMap[key] then
		return value == 1
	end

	return value
end

return cls