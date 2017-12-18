--
-- Author: lyt
-- Date: 2017-02-15 14:36:26
-- 翻译
local cls = class("LangTrans")

local URL = "http://fanyi.baidu.com/v2transapi"

local MAP = {
	cn = "zh",
	tw = "cht",
	vi = "vie", -- 越语
	ar = "ara", -- 啊啦伯
	sp = "spa", -- 西班牙
}

local QUERY_CACHE = {} -- 查询记录

local sqliteData = nil
local SQLITE_TABLE = "lang_trans"
local DEFAULT_VALUE = {
	id     = "",
	src    = "",
	target = "",
	text   = "",
	dst    = "",
}

function cls.query(src, target, text)
	print("**** ",str, target, text)
	if checknumber(text) ~= 0 then
		return
	end
	
	target = TEST_LANG_TRANS or target
	if src == nil or src == "" or
		target == nil or target == "" or
		src == target or 
		text == nil or text == "" then
		return
	end

	local dst = cls:getDst(target, text)
	if dst then
		return
	end

	local id = cls:getKey(target, text)
	if QUERY_CACHE[id] then
		return
	end

	QUERY_CACHE[id] = true

	return cls.new(src, target, text)
end

function cls:ctor(src, target, text)
	self.src    = src
	self.target = target
	self.text   = text

	local param = {
		from  = MAP[src] or src,
		to    = MAP[target] or target,
		query = self.text
	}

	Http.load(URL, handler(self, self.loadRhand), false, function()end, nil, false, param)
end

function cls:getKey(target, text)
	target = TEST_LANG_TRANS or target
	return Crypto.md5(target .. "_" .. text)
end

function cls:getDst(target, text)
	target = TEST_LANG_TRANS or target

	local key = self:getKey(target, text)
	if not sqliteData then
		sqliteData = SqliteData.new(SQLITE_TABLE, DEFAULT_VALUE, "id")
	end
	return sqliteData:getData(key)
end

function cls:loadRhand(v)
	local obj = json.decode(v)
	if not obj then
		return
	end
	
	obj = obj.trans_result
	if not obj then
		return
	end

	obj = obj.data
	if not obj or #obj == 0 then
		return
	end

	obj = obj[1].dst

	print("*** trans lang :", self.text, obj)

	local data = {
		id     = self:getKey(self.target, self.text),
		src    = self.src,
		target = self.target,
		text   = self.text,
		dst    = obj
	}
	sqliteData:insert(data)

	Util:event(Event.LangTrans, data)
end

return cls