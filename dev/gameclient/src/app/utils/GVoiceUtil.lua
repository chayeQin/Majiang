--
-- Author: lyt
-- Date: 2017-06-21 17:45:05
-- 设置
local cls = class("GVoiceUtil")

cls.MODE_CHAT    = 1 -- 实时语音
cls.MODE_MESSAGE = 2 -- 语音信息
cls.MODE_TEXT    = 3 -- 语音转文字

cls.SAVE_DIR = "gvoice"

cls.URL_CN = "udp://cn.voice.gcloudcs.com:10001"
cls.URL_HK = "udp://hk.voice.gcloudcs.com:10013"
cls.URL_TW = "udp://tw.voice.gcloudcs.com:8700"
cls.URL_KR = "udp://kr.voice.gcloudcs.com:8700"
cls.URL_JP = "udp://jp.voice.gcloudcs.com:8700"
cls.URL_SG = "udp://sg.voice.gcloudcs.com:8700"
cls.URL_VN = "udp://vn.voice.gcloudcs.com:8700"
cls.URL_TH = "udp://th.voice.gcloudcs.com:8700"
cls.URL_MY = "udp://my.voice.gcloudcs.com:8700"
cls.URL_ID = "udp://id.voice.gcloudcs.com:8700"

function cls:ctor()
	self.count = 3
end

function cls:init(rhand)
	if not TEST_DEV and not PlatformInfo.platform.GVoice then
		return
	end

	local writablePath = cc.FileUtils:getInstance():getWritablePath()
	local dir          = writablePath .. cls.SAVE_DIR
	cc.FileUtils:getInstance():createDirectory(dir)
	self.dir           = dir .. device.directorySeparator

	local data = {
		uid  = User.info.uid,
		type = cls.MODE_MESSAGE,
		url  = cls.URL_HK,
	}
	self:open(data, function()
		self:applyMessageKey({}, function()
			if rhand then
				rhand()
			end
			self.isInit = true
		end, function(obj)
			self:retry(rhand)
		end)
	end, function(obj)
		self:retry(rhand)
	end)
end

function cls:retry(rhand)
	self.count = self.count - 1
	if self.count < 1 then
		return
	end

	Util:tick(function()
		self:init(rhand)
	end, 1)
end

-- 说话,正常返回
function cls:say(rhand)
	if self.isSay then
		print("*** 正在说话中!!")
		return
	end

	self.isSay = true
	self.path = self.dir .. "temp.wav"
	self:startRecording({path = self.path}, rhand, function()
		self.isSay = false
		Tips.show(Lang:find("recording_init"))
		self:init()
	end)
end

-- 说话完成
function cls:sayCmp(rhand)
	if not self.isSay then
		print("*** 你没有在说话!!")
		return
	end

	self.isSay = false
	self:stopRecording({}, function()
		self.isHttp = true
		self:uploadFile({path = self.path}, function(obj)
			self.isHttp = false
			if rhand then
				rhand(obj.fileID)
			end
		end, function()
			self.isHttp = false
			Tips.show(Lang:find("recording_sayerror"))
		end)
	end)
end

function cls:play(fileID, rhand)
	if not self.isInit then
		self:init(function()
			self:play(fileID, rhand)
		end)
		return true
	end

	if self.isPlay == fileID then
		self.fileID = nil
		self.isPlay = nil
		self:stopPlayFile()
		return false
	end

	self.fileID = fileID

	if self.isPlay then
		if self.isHttp then
			Tips.show(Lang:find("recording_filetimeout"))
			return false
		else
			self:stopPlayFile()
		end
	end

	local path = self.dir .. fileID
	self.isPlay = fileID
	if Util:exists(path) then
		self:playPath(path, rhand)
		return true
	end

	self.isHttp = true
	self:downFile({path = path, fileID = fileID}, function()
		self.isHttp = false
		self:playPath(path, rhand)
	end, function()
		self.isHttp = false
		self.isPlay = false
		Tips.show(Lang:find("recording_filetimeout"))
		if rhand then
			rhand()
		end
	end)

	return true
end

function cls:stop()
	self.isPlay = false
	self:stopPlayFile()
end

function cls:playPath(path, rhand)
	Sound:pauseMusic()
	self:playFile({path=path}, function()
		Sound:resumeMusic()
		self.isPlay = false
		if rhand then
			rhand()
		end
	end, function()
		Sound:resumeMusic()
		self.isPlay = false
		Tips.show(Lang:find("recording_filetimeout"))
		if rhand then
			rhand()
		end
	end)
end

-- 基本接口
local METHODS = {
	"open", -- 初始函数{uid=用户唯一ID, type=语音模式, url=语音服务器地址}

	-- 实时语音
	"jionTeamRoom", -- 加入队伍(20人)房间{roomID=房间ID}
	"joinNationalRoom", -- 加入公会聊天(5人+无限听){roomID=房间ID, roleType=角色1说2听}
	"joinFMRoom", -- 加入房间(不知道什么鬼,没文档){roomID=房间ID}
	"quickRoom", -- 退出房间{roomID=房间ID}
	"openMic", -- 打开麦克风(同时发送语音)
	"closeMic", -- 关闭麦克风(同时关闭声音数据)Close players's micro phone and stop to send player's voice data.
	"openSpeaker", -- 打开扬声器,并开始接受语音
	"closeSpeaker", -- 关闭扬声器

	-- 语音信息
	"applyMessageKey", -- 申请离线语音
	"maxLength", -- MAX录音时间(毫秒)(max=时间毫秒)
	"startRecording", -- 开始录音{path=文件保存绝对路径}
	"stopRecording", -- 停止录音
	"uploadFile", -- 上传文件{path=文件保存绝对路径},返回fileID
	"downFile", -- 下载文件{fileID=文件ID,path=文件保存绝对路径}
	"playFile", -- 播放文件{path=文件保存绝对路径}
	"stopPlayFile", -- 停止播放文件

	-- 语音转文字
	"speechToText", -- 语音转文字（中文）{fileID=文件ID}
}

for k,v in ipairs(METHODS) do
	cls[v] = function(self, data, rhand, fhand)
		self:call(v, data, rhand, fhand)
	end
end

-- 调用API接口
function cls:call(method, data, rhand, fhand)
	data = data or {}
	Api:call("GVoiceInfo", method, data, function(str)
		if DEBUG > 0 then
			print("*** 回调:", method, str)
		end

		local obj = json.decode(str) or {}
		Util:tick(function()
			if obj.status == "ok" then
				if rhand then
					rhand(obj)
				end
			else
				if fhand then
					fhand(obj)
				end
			end
		end, 0)
	end)
end

return cls