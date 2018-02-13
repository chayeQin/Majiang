--
-- @brief 创建房间config
-- @author myc
-- @date 2018/1/13
--

local cls = {}
--[[
id	人数	房间模式	消耗房卡	局数	文本
id	count	roomMode	consume	round	desc
]]

cls.ROOM = {
[1] = {id = 1,count = 2, roomMode = 1,consume = 4, round = 6 ,	desc = "6把（房卡x4）"},
[2] = {id = 2,count = 2, roomMode = 2,consume = 4, round = 12, 	desc = "12把（房卡x4）"},
[3] = {id = 3,count = 2, roomMode = 3,consume = 6, round = 26, 	desc = "26把（房卡x6）"},
[4] = {id = 4,count = 3, roomMode = 1,consume = 4, round = 5,	desc = "5把（房卡x4）"},
[5] = {id = 5,count = 3, roomMode = 2,consume = 4, round = 10,	desc = "10把（房卡x4）"},
[6] = {id = 6,count = 3, roomMode = 3,consume = 6, round = 20,	desc = "20把（房卡x6）"},
[7] = {id = 7,count = 4, roomMode = 1,consume = 4, round = 4, 	desc = "1圈（房卡x4）"},
[8] = {id = 8,count = 4, roomMode = 2,consume = 4, round = 8, 	desc = "2圈（房卡x4）"},
[9] = {id = 9,count = 4, roomMode = 3,consume = 6, round = 16, 	desc = "4圈（房卡x6）"},
}

--[[
/**
 * 游戏玩法
 */
public class TGameTypes {
	/** 漏胡 **/
	public static final int t1 = 1;
	/** 刮大风 **/
	public static final int t2 = 2;
	/** 红中满天飞 **/
	public static final int t3 = 3;
	/** 三色胡 **/
	public static final int t4 = 4;
]]
cls.PLAY = {
[1] = {id = 1,desc = "漏胡"},
[2] = {id = 2,desc = "刮大风"},
[3] = {id = 3,desc = "红中满天飞"},
[4] = {id = 4,desc = "三色胡"},
}

return cls