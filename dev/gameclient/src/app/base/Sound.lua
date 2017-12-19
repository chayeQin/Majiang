--
-- @brief 音效模块
-- @author qyp
-- @date 2015/12/01
--

local cls = class("Sound")
local audio = AudioEngine

function cls:ctor()
	if not Util:load("SYSTEMSETTING_INIT") then
		Util:save("sound", true)
		Util:save("music", true)
	end
	self.isEffect  = Util:load("sound")
	self.isMusic   = Util:load("music")
	self.effectMap = {}
end

function cls:play(path, isLoop)
	path = Util:path(path, SOUND_PZ)
	if not self.isEffect then
		return 0
	end

	if not Util:exists(path) then
		return 0
	end

	self.effectMap[path] = true
	audio.playEffect(path, isLoop == true)
end

-- 预加载声音
function cls:preloadSound(filename)
	if not self.isEffect then
		return 0
	end

	if not Util:exists(path) then
		return 0
	end

	path = Util:path(path, SOUND_PZ)
	audio.preloadEffect(path)
end

function cls:music(path, loop)
	self.music_ = path
	path = Util:path(path, SOUND_PZ)
	if not self.isMusic then
		return 0
	end

	if not Util:exists(path) then
		return 0
	end

	if self.isMusic and Util:exists(path) then
		audio.playMusic(path, loop ~= false)
	end
end

function cls:enableMusic(v)
	self.isMusic = v
	if v then
		if self.music_ then
			self:music(self.music_)
		end
	else
		audio.stopMusic(true)
	end
end

function cls:enableEffect(v)
	self.isEffect = v
	if not v then
		audio.stopAllEffects()
	end
end

-- 卸载所有声音
function cls:unloadSound()
	audio.stopAllEffects()
	for filename,v in pairs(self.effectMap) do
		audio.unloadEffect(filename)
	end
	self.effectMap = {}
end

function cls:resumeMusic()
	if not self.lastMusicEnable then
		return
	end

	self:enableMusic(true)
end

function cls:pauseMusic()
	self.lastMusicEnable = self.isMusic
	if not self.isMusic then
		return
	end

	self:enableMusic(false)
	self:unloadSound()
end

return cls