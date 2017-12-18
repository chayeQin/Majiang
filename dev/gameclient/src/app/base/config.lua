--
--@brief 
--@author qyp
--@date 2015/8/12
--

cc.exports.FONT = "simhei"
cc.exports.TEXTURE_PZ  = ".png"
cc.exports.TEXTURE_JPG = ".jpg"
cc.exports.SOUND_PZ    = ".mp3"
cc.exports.API         = "Api"
cc.exports.UPDATA_VER = "upload.ver"
cc.exports.UPDATA_LIST = "upload.pc"

-- 后缀名
if device.platform == "ios" then
	cc.exports.UPDATA_LIST = "upload.ios"
	cc.exports.API         = "Ios"
elseif device.platform == "android" then
	cc.exports.UPDATA_LIST = "upload.android"
	cc.exports.UPDATA_MD5  = "upload_md5.android"
	cc.exports.API         = "Android"
end

cc.exports.TEXTURE_CFG = {
	jpg   = cc.TEXTURE2_D_PIXEL_FORMAT_RG_B565, -- JPG
	png   = cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888, -- 默认格式
}