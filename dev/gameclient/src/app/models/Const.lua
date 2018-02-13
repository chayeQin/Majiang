--
--@brief 游戏常量
--@author qyp
--@date 2016/2/3
--
local cls = {}

-- 使用的游戏地址
cls.CHECK_GAME_URL_KEY = "last_check_game_url_key"
-- 上次使用的CDN地址
cls.LAST_SAVE_KEY = "last_upload_cdn"
-- 上次使用的IP
cls.SAVE_IP_KEY = "last_login_ip"
-- 自动翻译
cls.SAVE_AUTO_LANG = "save_auto_lang"

-- 灰色颜色
cls.COLOR_GRAY = cc.c3b(0xa5,0x2a,0x2a)

-- 绿色颜色
cls.COLOR_GREEN = cc.c3b(0x4c,0xa6,0x40)

-- 遮罩颜色
cls.LayerColor = cc.c4b(0,0,0,0.8)

cls.CARD_LIBS = {
	
}


cls.CARD_LIBS = {}
for i = 1, 7 do
    table.insert(cls.CARD_LIBS, i)
end

for i = 1, 3 do
  for j = 1, 9 do
      local val = 10*i + j
      table.insert(cls.CARD_LIBS, val)
  end
end

cls.testGameInfo = {
    ["bankerIndex"]  = 0,
    ["baopai"]      = 26,
    ["count"]        = 1,
    ["getCard"]      = 24,
    ["librarySize"]  = 83,
    ["maxCount"]     = 12,
    ["maxSize"]      = 2,
    ["outCard"]      = -1,
    ["outIndex"]     = 1,
    ["outTime"]      = 1518481606,

    ["playerIndexs"] = {
        ["a08r47qbzx0"] = 1,
        ["a9f9jsi12yd"] = 0,
	},

    ["players"] = {
        [1] = {
            	["actions"] = {
            	},
                ["hand"] = {
                    [1]  = 15,
                    [2]  = 17,
                    [3]  = 21,
                    [4]  = 22,
                    [5]  = 25,
                    [6]  = 26,
                    [7]  = 29,
					[8]  = 29,
                  	[9]  = 35,
                    [10] = 36,
				},
                ["index"]   = 0,
                ["listen"]  = false,
                ["lose"] = {
                    [1] = 11,
                    [2] = 32,
                },
                ["socre"]   = 0,
                ["top"] = {
                    [1] = {
                        [1] = 31,
                        [2] = 32,
                        [3] = 33,
                      }
                },
                ["uid"]     = "a9f9jsi12yd"
              },
            [2] = {
              	["actions"] = {
                  	[1] = 11
              	},
              	["hand"] = {
              		[1]  = 16,
                  	[2]  = 17,
             	 	[3]  = 18,
                  	[4]  = 22,
                  	[5]  = 23,
                  	[6]  = 24,
                  	[7]  = 25,
                  	[8]  = 26,
                  	[9]  = 27,
                  	[10] = 27,
                  	[11] = 28,
                  	[12] = 28,
                  	[13] = 37,
                  	[14] = 38,
             	},
              	["index"]   = 1,
              	["listen"]  = false,
              	["lose"] = {
              	},
              	["socre"]   = 0,
              	["top"] = {
              	},
              	["uid"]     = "a08r47qbzx0"
              }
          }
}

cls.testRoomInfo = {
        ["countType"] = 101,
        ["exitUids"] = {
        },
        ["maxCount"]  = 12,
        ["maxSize"]   = 2,
        ["payType"]   = 102,
        ["players"] = {
            [1] = {
                 ["headimgurl"] = "",
                [ "index" ]     = 0,
                 ["nickname"]   = "a9f9jsi12yd",
                 ["num"]        = 4,
                 ["serverTime"] = 1518482583,
                 ["serverZone"] = 28800000,
                 ["state"]      = true,
                 ["uid"]        = "a9f9jsi12yd",
            },
             [2] = {
                 ["headimgurl"] = "",
                 ["index"]      = 1,
                 ["nickname"]   = "a08r47qbzx0",
                 ["num"]        = 4,
                 ["serverTime"] = 1518482583,
                 ["serverZone"] = 28800000,
                 ["state"]      = true,
                 ["uid"]        = "a08r47qbzx0",
             }
         },
         ["roomId"]   = "563632",
         ["roomType"]  = 0,
         ["status"]    = true,
         ["types"]     = "1,2,3,4"
     }


return cls