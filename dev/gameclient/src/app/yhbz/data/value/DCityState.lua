-- C_城邦配置表.xlsx
-- id=城市ID,cityName=城市名称,countryType=国家类型,countryId=国家ID,countryName=国家名称,mayorName=市长名称,investment=市长原始投资值,pic=图片,
local DCityState = {
  [11011] = {id=11011,cityName="洛杉矶",countryType=1,countryId=101,countryName="美国",mayorName="史密斯",investment=1800000,pic=11011},
  [11012] = {id=11012,cityName="旧金山",countryType=1,countryId=101,countryName="美国",mayorName="约翰逊",investment=1800000,pic=11012},
  [11013] = {id=11013,cityName="华盛顿",countryType=1,countryId=101,countryName="美国",mayorName="威廉姆斯",investment=1800000,pic=11013},
  [11014] = {id=11014,cityName="芝加哥",countryType=1,countryId=101,countryName="美国",mayorName="布朗",investment=1800000,pic=11014},
  [11021] = {id=11021,cityName="东京",countryType=1,countryId=102,countryName="日本",mayorName="织田信长",investment=1800000,pic=11021},
  [11022] = {id=11022,cityName="大阪",countryType=1,countryId=102,countryName="日本",mayorName="坂本龙马",investment=1800000,pic=11022},
  [11023] = {id=11023,cityName="神户",countryType=1,countryId=102,countryName="日本",mayorName="德川家康",investment=1800000,pic=11023},
  [11024] = {id=11024,cityName="名古屋",countryType=1,countryId=102,countryName="日本",mayorName="丰臣秀吉",investment=1800000,pic=11024},
  [11031] = {id=11031,cityName="首尔",countryType=1,countryId=103,countryName="韩国",mayorName="金泰贤",investment=1800000,pic=11031},
  [11032] = {id=11032,cityName="釜山",countryType=1,countryId=103,countryName="韩国",mayorName="宋钟基",investment=1800000,pic=11032},
  [11033] = {id=11033,cityName="仁川",countryType=1,countryId=103,countryName="韩国",mayorName="车永俊",investment=1800000,pic=11033},
  [11034] = {id=11034,cityName="济州",countryType=1,countryId=103,countryName="韩国",mayorName="李孝利",investment=1800000,pic=11034},
  [11041] = {id=11041,cityName="伦敦",countryType=1,countryId=104,countryName="英国",mayorName="奥斯顿",investment=1800000,pic=11041},
  [11042] = {id=11042,cityName="利物浦",countryType=1,countryId=104,countryName="英国",mayorName="布兰登",investment=1800000,pic=11042},
  [11043] = {id=11043,cityName="曼彻斯特",countryType=1,countryId=104,countryName="英国",mayorName="拜伦",investment=1800000,pic=11043},
  [11044] = {id=11044,cityName="伯明翰",countryType=1,countryId=104,countryName="英国",mayorName="爱德华",investment=1800000,pic=11044},
  [11051] = {id=11051,cityName="巴黎",countryType=1,countryId=105,countryName="法国",mayorName="安得烈",investment=1800000,pic=11051},
  [11052] = {id=11052,cityName="马赛",countryType=1,countryId=105,countryName="法国",mayorName="达尔西",investment=1800000,pic=11052},
  [11053] = {id=11053,cityName="里昂",countryType=1,countryId=105,countryName="法国",mayorName="埃利奥特",investment=1800000,pic=11053},
  [11054] = {id=11054,cityName="波尔多",countryType=1,countryId=105,countryName="法国",mayorName="哈维",investment=1800000,pic=11054},
  [11061] = {id=11061,cityName="柏林",countryType=1,countryId=106,countryName="德国",mayorName="亚尔曼",investment=1800000,pic=11061},
  [11062] = {id=11062,cityName="汉堡",countryType=1,countryId=106,countryName="德国",mayorName="比尔",investment=1800000,pic=11062},
  [11063] = {id=11063,cityName="慕尼黑",countryType=1,countryId=106,countryName="德国",mayorName="卡尔",investment=1800000,pic=11063},
  [11064] = {id=11064,cityName="法兰克福",countryType=1,countryId=106,countryName="德国",mayorName="戴里克",investment=1800000,pic=11064},
  [11071] = {id=11071,cityName="米兰",countryType=1,countryId=107,countryName="意大利",mayorName="安其罗",investment=1800000,pic=11071},
  [11072] = {id=11072,cityName="佛罗伦萨",countryType=1,countryId=107,countryName="意大利",mayorName="布鲁诺",investment=1800000,pic=11072},
  [11073] = {id=11073,cityName="罗马",countryType=1,countryId=107,countryName="意大利",mayorName="拉斐尔",investment=1800000,pic=11073},
  [11074] = {id=11074,cityName="威尼斯",countryType=1,countryId=107,countryName="意大利",mayorName="费里尼",investment=1800000,pic=11074},
  [11081] = {id=11081,cityName="马德里",countryType=1,countryId=108,countryName="西班牙",mayorName="班德拉斯",investment=1800000,pic=11081},
  [11082] = {id=11082,cityName="巴塞罗那",countryType=1,countryId=108,countryName="西班牙",mayorName="克鲁兹",investment=1800000,pic=11082},
  [11083] = {id=11083,cityName="瓦伦西亚",countryType=1,countryId=108,countryName="西班牙",mayorName="高第",investment=1800000,pic=11083},
  [11084] = {id=11084,cityName="塞维利亚",countryType=1,countryId=108,countryName="西班牙",mayorName="加尔多士斯",investment=1800000,pic=11084},
  [11091] = {id=11091,cityName="渥太华",countryType=1,countryId=109,countryName="加拿大",mayorName="克雷蒂安",investment=1800000,pic=11091},
  [11092] = {id=11092,cityName="多伦多",countryType=1,countryId=109,countryName="加拿大",mayorName="白求恩",investment=1800000,pic=11092},
  [11093] = {id=11093,cityName="温哥华",countryType=1,countryId=109,countryName="加拿大",mayorName="特鲁多",investment=1800000,pic=11093},
  [11094] = {id=11094,cityName="蒙特利尔",countryType=1,countryId=109,countryName="加拿大",mayorName="席琳·迪翁",investment=1800000,pic=11094},
  [22011] = {id=22011,cityName="莫斯科",countryType=2,countryId=201,countryName="俄罗斯",mayorName="普希金",investment=1500000,pic=22011},
  [22012] = {id=22012,cityName="圣彼得堡",countryType=2,countryId=201,countryName="俄罗斯",mayorName="赫尔岑",investment=1500000,pic=22012},
  [22013] = {id=22013,cityName="叶卡捷琳堡",countryType=2,countryId=201,countryName="俄罗斯",mayorName="托尔斯泰",investment=1500000,pic=22013},
  [22014] = {id=22014,cityName="伏尔加格勒",countryType=2,countryId=201,countryName="俄罗斯",mayorName="柴科夫斯基",investment=1500000,pic=22014},
  [22021] = {id=22021,cityName="北京",countryType=2,countryId=202,countryName="中国",mayorName="韩梅梅",investment=1500000,pic=22021},
  [22022] = {id=22022,cityName="上海",countryType=2,countryId=202,countryName="中国",mayorName="李雷",investment=1500000,pic=22022},
  [22023] = {id=22023,cityName="广州",countryType=2,countryId=202,countryName="中国",mayorName="黄尚",investment=1500000,pic=22023},
  [22024] = {id=22024,cityName="深圳",countryType=2,countryId=202,countryName="中国",mayorName="恭竺",investment=1500000,pic=22024},
  [22031] = {id=22031,cityName="里斯本",countryType=2,countryId=203,countryName="葡萄牙",mayorName="麦哲伦",investment=1500000,pic=22031},
  [22032] = {id=22032,cityName="阿尔加维",countryType=2,countryId=203,countryName="葡萄牙",mayorName="哥伦布",investment=1500000,pic=22032},
  [22033] = {id=22033,cityName="科英布拉",countryType=2,countryId=203,countryName="葡萄牙",mayorName="达伽马",investment=1500000,pic=22033},
  [22034] = {id=22034,cityName="波尔图",countryType=2,countryId=203,countryName="葡萄牙",mayorName="尤西比奥",investment=1500000,pic=22034},
  [22041] = {id=22041,cityName="伯尔尼",countryType=2,countryId=204,countryName="瑞士",mayorName="迪伦马特",investment=1500000,pic=22041},
  [22042] = {id=22042,cityName="苏黎世",countryType=2,countryId=204,countryName="瑞士",mayorName="费德勒",investment=1500000,pic=22042},
  [22043] = {id=22043,cityName="日内瓦",countryType=2,countryId=204,countryName="瑞士",mayorName="班得瑞",investment=1500000,pic=22043},
  [22044] = {id=22044,cityName="巴塞尔",countryType=2,countryId=204,countryName="瑞士",mayorName="卢梭",investment=1500000,pic=22044},
  [33011] = {id=33011,cityName="新德里",countryType=3,countryId=301,countryName="印度",mayorName="甘地",investment=1200000,pic=33011},
  [33012] = {id=33012,cityName="孟买",countryType=3,countryId=301,countryName="印度",mayorName="泰戈尔",investment=1200000,pic=33012},
  [33013] = {id=33013,cityName="班加罗尔",countryType=3,countryId=301,countryName="印度",mayorName="尼南贾纳",investment=1200000,pic=33013},
  [33014] = {id=33014,cityName="加尔各答",countryType=3,countryId=301,countryName="印度",mayorName="查卡拉巴提",investment=1200000,pic=33014},
  [33021] = {id=33021,cityName="悉尼",countryType=3,countryId=302,countryName="澳大利亚",mayorName="彼德森",investment=1200000,pic=33021},
  [33022] = {id=33022,cityName="墨尔本",countryType=3,countryId=302,countryName="澳大利亚",mayorName="洛森",investment=1200000,pic=33022},
  [33023] = {id=33023,cityName="佩斯",countryType=3,countryId=302,countryName="澳大利亚",mayorName="肯尼利",investment=1200000,pic=33023},
  [33024] = {id=33024,cityName="堪培拉",countryType=3,countryId=302,countryName="澳大利亚",mayorName="弗洛里",investment=1200000,pic=33024}
}
return DCityState