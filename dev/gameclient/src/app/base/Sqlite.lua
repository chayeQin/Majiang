--
-- @brief 数据查询
-- @author: qyp
-- @date: 2016/03/21
--

local cls = {}

local db      = nil

cls.ERROR_SQL        = 1 -- SQL错误
cls.LOCKED           = 6 -- 表锁定
cls.SAME_PRIMARY_KEY = 19 -- 相同主键

-- 临时表名
-- 使用getTempTableName方法获取
-- 以统一删除临时表,程序中经常出现
-- 查询中造成锁表没法删除,只好下次启动时删除
cls.TEMP_NAME = "__temp_table_"

-- isCreateNew 是否删除原有数据库
function cls.open(name, isCreateNew)
	cls.close()
	local path = device.writablePath .. name .. ".db"
	if isCreateNew and Util:exists(path) then
		os.remove(path)
	end

	db         = sqlite3.open(path)
	db:nrows("PRAGMA synchronous = OFF;") -- 关闭同步写入
	
	cls.removeTempTable()

	return db
end

-- 创建TABLE
function cls.create(tblName, columns, types)
	columns = columns or {"key","value"}
	local col = ""
	for i, v in ipairs(columns) do
		col = col .. v .." "..(types[i] or "TEXT ")
		if i == 1 then
			col = col .. " PRIMARY KEY NOT NULL,"
		else
			col = col .. ","
		end
	end
	col = string.sub(col, 0, string.len(col) - 1)
	local sql = "CREATE TABLE " .. tblName .. "(" .. col .. ");"
	return db:exec(sql)
end

-- 插入数据
function cls.insert(tblName, keys, values)
	local key = ""
	for _, v in ipairs(keys) do
		key = key .. v .. ","
	end
	key = string.sub(key, 0, string.len(key) - 1)
	local val = ""
	for _, v in ipairs(values) do
		val = val .. "'" .. v .. "',"
	end
	val = string.sub(val, 0, string.len(val) - 1)
	local sql = "INSERT INTO '" .. tblName .. "' (".. key ..") " .. "VALUES (" .. val ..");"
	local result = db:exec(sql)

	return result == 0 or result
end

-- 删除数据(表名,主键)
function cls.delete(tableName, cond)
	local sql = "DELETE FROM " .. tableName .. " WHERE " .. cond
	local result = db:exec(sql)
	return result == 0 or result
end

-- 删除指定行数
function cls.deleteLimit(tableName, primaryKey, cond, order, limit, offset)
	local sql = string.format([[
			SELECT %s
			FROM %s
		]], primaryKey, tableName)
	if cond then
		sql = sql .. " WHERE " .. cond
	end
	if order then
		sql = sql .. " ORDER BY " .. order
	end
	if limit then
		sql = sql .. " limit " .. limit
	end
	if offset then
		sql = sql .. " offset " .. offset
	end

	sql = string.format([[
		DELETE FROM %s
		where %s in (%s)
		]],tableName, primaryKey, sql)
	local result = db:exec(sql)
	return result == 0 or result
end

-- 更新数据(表名,主键名称,主键值,更新TABLE[key=value])
function cls.update(tableName, cond, setstr)
	local sql = string.format([[
		UPDATE '%s' 
		SET %s
		]], tableName, setstr)

	if cond then
		sql = sql .. " WHERE " .. cond
	end

	local result = db:exec(sql)
	return result == 0 or result
end

-- 查询数据
--@param[tableName] 表名
--@param[cond] 查询条件
--@param[order] 顺序 /  () DESC/ASC
--@param[limit] 查询结果条数限制
--@param[offset] 查询的偏移index
function cls.select(tableName, cond, order, limit, offset, keys)
	if not keys then
		keys = "*"
	elseif type(keys) == "table" then
		keys = table.concat(keys, ",")
	end
	local sql = string.format([[
		SELECT %s
		FROM %s
		]],keys, tableName)
	cond = cond and " WHERE " .. cond or ""
	order = order and " ORDER BY " .. order or ""
	limit = limit and " LIMIT " .. limit or ""
	offset = offset and " OFFSET " .. offset or ""
	sql = sql .. cond .. order .. limit .. offset
	local list = {}
	for data in db:nrows(sql) do
		table.insert(list,data)
	end
	return list
end

-- 返回数量
function cls.count(tableName, cond)
	local sql = string.format([[
		SELECT COUNT(*) as count
		FROM %s
		]],tableName)

	if cond then
		sql = sql .. " WHERE " .. cond
	end
	
	for data in db:nrows(sql) do
		return data.count
	end
	return 0
end

-- 将旧表变成新TABLE,第二个参数是主键
function cls.rename(tableName,newname)
	local sql =	string.format([[
		ALTER TABLE %s RENAME TO %s;
	]],tableName,newname)

	local result = db:exec(sql)
	return result == 0 or result
end

-- 检查表是否存在
function cls.exists(tableName)
	local sql = string.format([[
		SELECT COUNT(*) as count
		FROM sqlite_master 
		where type='table' and name='%s';
		]],tableName)

	for it in db:nrows(sql) do
		if it.count > 0 then
			return true
		end
	end
	return false
end

-- 获取表结构
function cls.structure(tableName)
	local sql = string.format([[
		SELECT *
		FROM sqlite_master 
		where type='table' and name='%s';
		]],tableName)

	for it in db:nrows(sql) do
		return it
	end
	return nil
end

-- 拷贝数据
function cls.copy(src,target,keys)
	local strKey = ""
	for _, v in ipairs(keys) do
		strKey = strKey .. v .. ","
	end
	strKey = string.sub(strKey, 0, string.len(strKey) - 1)

	local sql = string.format([[
		INSERT INTO '%s' (%s)
		SELECT %s FROM '%s';
		]],target, strKey, strKey, src)

	local result = db:execute(sql)
	return result == 0 or result
end

-- 删除表
function cls.drop(tableName)
	local sql = string.format("DROP TABLE if exists %s;",tableName)

	local result = db:execute(sql)
	return result == 0 or result
end

function cls.addColumn(tableName, column, ctype)
	if column == nil or column == "" then
		print("**** error column : ",column)
		return false
	end
	if ctype == nil or ctype == "" then
		print("**** error type : ",ctype)
		return false
	end

	local sql = string.format("ALTER TABLE %s ADD COLUMN %s %s;", tableName, column, ctype)

	local result = db:execute(sql)
	return result == 0 or result
end

-- 清空表名
function cls.clear(tableName)
	local sql = string.format([[
		DELETE FROM %s;
		]],tableName)

	local result = db:execute(sql)
	return result == 0 or result
end

-- 显示所有表
function cls.tables()
	local sql = "select * from sqlite_master where type='table';"

	local list = {}
	for data in db:nrows(sql) do
		table.insert(list,data)
	end
	return list
end

-- 关闭链接
function cls.close()
	if db then
		db:close()
		db = nil
	end
end

-- 生成临时表名.
function cls.getTempTableName()
	return cls.TEMP_NAME .. os.time()
end

function cls.removeTempTable()
	local sql = string.format([[
		SELECT *
		FROM sqlite_master;
		]])

	local len = string.len(cls.TEMP_NAME)
	local list = {}
	for it in db:nrows(sql) do
		if string.sub(it.name,1,len) == cls.TEMP_NAME then
			table.insert(list, it.name)
		end
	end

	-- 在db:nrows里是锁表的..只能放出来
	for k,v in pairs(list) do
		print("************ 删除表", v, cls.drop(v))
	end
end

return cls