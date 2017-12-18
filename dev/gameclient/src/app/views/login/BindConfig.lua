--
-- Author: lyt
-- Date: 2016-11-23 18:45:46
-- 绑定变量
local cls = {}

cls.FACE_BOOK = {
	name = "facebook", -- fb
	icon = "ui/ui_fb",
	call = "login",
}

cls.JYX = {
	name = "jyx", -- 极印象
	icon = "ui/ui_jyx", -- 图标
	call = "", -- 调用 SDK方法名
}

cls.SDKS = {
	cls.JYX,
}

if not GAME_CFG.no_facebook then
	table.insert(cls.SDKS, cls.FACE_BOOK)
end

return cls