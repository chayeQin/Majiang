--
-- @brief 推送消息处理器
-- @author qyp
-- @date 2015/09/18
--

local cls = class("NotifyHandler")

-- 注册服务器推送事件
cc.exports.NotifyEvent = {
	mail 						= "1",	 -- 邮件
	broadcast   				= "2",	 -- 系统广播公告
	date 						= "3",	 -- 日期更新
	task 						= "4",	 -- 任务数据更新
	recharge 					= "5",   -- 充值更新
	funcopen 					= "6",	 -- 功能开启
	chat 						= "7",	 -- 聊天系统
	friend_add  				= "8",	 -- 好友申请
	friend_duct 				= "9",	 -- 好友解除
	friend_present 				= "10",	 -- 好友赠送
	logout_relogin				= "11",  -- 重复登录踢下线
	logout_kick					= "12",  -- GM踢下线
	fight               		= "13",  -- 玩家战斗力更新
	march_status				= "14",  -- 行军状态改变
	union_help 					= "15",  -- 联盟帮助
	union_applys 				= "16",  -- 联盟申请消息
	union_receive_help			= "17",  -- 联盟接到帮助
	union_dismiss				= "18",	 -- 联盟解散
	union_support_resource		= "19",  -- 资源援助
	union_refused				= "20",	 -- 申请被联盟拒绝
	union_agree 				= "21",	 -- 同意申请消息
	union_kick 					= "22",	 -- 踢出消息
	union_exit 					= "23",	 -- 退出联盟消息
	union_recall 				= "24",	 -- 撤消申请消息
	union_transfer 				= "25",	 -- 转让推送消息
	union_helped				= "26",  -- 联盟被帮助
	union_help_del				= "27",  -- 帮助移除
	union_buy_record			= "28",  -- 联盟购买物品记录消息
	union_tag 					= "29",  -- 联盟标记
	march_forces 				= "30",  -- 行军返回，兵种数据更新
	march_resource 				= "31",  -- 世界资源数据
	mail_monster 				= "32",	 -- 怪物邮件更新
	mail_resources 				= "33",	 -- 资源邮件更新
	mail_pvp					= "34",  -- PVP邮件更新
	mail_investigation			= "35",  -- 侦查邮件更新
	mail_union					= "36",  -- 联盟邮件
	attack_monster				= "37",  -- 攻击怪物提醒
	march_info_update			= "38",  -- 有人向自己行军
	march_info_del				= "39",  -- 行军消失
	mail_activity				= "40",  -- 活动邮件
	mail_cannon 				= "41",  -- 巨炮邮件
	web                 		= "100", -- web返回
	friend_agree 				= "200", -- 好友同意
	friend_reject 				= "201", -- 好友拒绝
	friend_info					= "202", -- 好友信息推送
	honor_medal					= "250", -- 荣誉勋章更新
	item_update 			 	= "270", -- 物品更新
	item_update_tips			= "271", -- 带弹窗的物品更新
	equip_suc 				 	= "290", -- 装备锻造完成
	equip_material_update		= "291", -- 材料队列更新
	equip_forge_record 			= "292", -- 装备锻造记录
	union_science			  	= "350", -- 联盟科技信息更新 
	union_science_queue 	  	= "351", -- 科技队列信息更新
	union_war 			  	  	= "352", -- 联盟集结信息
	union_war_cancel 		  	= "353", -- 联盟集结取消信息更新, 联盟战争移除
	union_build_update  	  	= "354", -- 联盟建筑更新
	union_new_msg 			  	= "355", -- 联盟消息提醒
	union_appoint_info 	      	= "357", -- 提升职位提醒
	union_build_delete 			= "358", -- 联盟建筑删除
	union_members_update 		= "359", -- 联盟成员更新
	union_agree_join			= "360", -- 同意入盟邀请
	union_delete_member 		= "361", -- 删除联盟成员
	union_extra         		= "362", -- 联盟额外信息更新
	union_kingdom_war 			= "363", -- 联盟王国战争更新
	buildQueue 					= "500", -- 建造队列更新
	queue_collect_success 		= "501", -- 资源采集数据
	chat_forum 					= "550", -- 群聊信息
	chat_forum_info 			= "551", -- 群组信息变更推送
	chat_forum_kick 			= "552", -- 群聊被踢推送
	task_day_suc				= "561", -- 每日任务完成积分
	novice_task					= "563", -- 新手7天任务
	task_main					= "560", -- 主线任务数据
	task_day_suc_push			= "562", --	每日任务完成推送
	horn 						= "570", -- 玩家喇叭公告
	honor                       = "571", --	荣誉数据更新
	wall_info					= "572", -- 城墙信息推送
	vip_update					= "573", --vip数据更新
	view_update					= "574", -- 世界地图视线范围内的目标状态
	svip_update					= "575", --vip数据更新
	buffer_update				= "576", -- 城市buffer数据更新
	union_science_count			= "577", -- 联盟科技可学习个数针对R4，R5
	protect						= "601", -- 新号保护更新
	affairs_skill_update		= "700", -- 内政技能推送
	affairs_kindom_info_update  = "701"; --王国信息更新
	player_area_update 			= "702", -- 玩家地图位置更新
	military_lv_update			= "703", -- 军衔等级变更
	hboss_union_info			= "1000", -- 黑骑士推送-公会信息 成员信息
	activity_update				= "1100", --活动更新
	citystate_update 			= "704", --城邦个人数据更新
	citystate_union_update		= "705", --城邦联盟数据更新
	cityDestory 				= "706", --城市被摧毁推送
	science_queue_update		= "707", -- 科技队列更新
	month_card_update			= "709", -- 月卡信息推送
	web_task_info				= "710", -- 任务活动推送
	union_invite				= "711", -- 触发联盟邀请推送
	special_gift_bag			= "712", -- 特殊礼包推送
	task_novice_info			= "713", -- 新手任务基本信息推送
	player_time_info			= "714", -- 玩家时间更新
	union_task_info				= "715", -- 联盟任务推送
	map_send					= "716", -- 地图数据推送
	union_create_touch			= "717", -- 触发联盟创建推送
	gift_bag_remind				= "718", -- 礼包提醒推送
	map_send_queue				= "719", -- 地图队列数据推送
	lucky_day_info				= "720", -- 幸运日数据推送
	age_condition				= "721", -- 文明时代任务推送
	savings_info				= "722", -- 储蓄计划推送
	treasure_info				= "723", -- 挖宝事件推送
	pack_library_info			= "724", -- 常规礼包数据推送
	collect_info				= "725", -- 采集信息推送
	union_initiative_info		= "726", -- 联盟主动技能信息推送
	union_logic_info			= "727", -- 联盟逻辑技能信息推送
	union_battle_info 			= "728", -- 联盟副本每日重置
	cannon_armour				= "729", -- 巨炮装甲信息
	task_chapter_info			= "730", -- 章节任务推送
	send_start_login            = "999", -- 登录接口
	cross_map_list				= "2000", -- 服务器列表
	cross_map_moved 			= "2001", -- 跨服请求地图数据
	cross_map_getCommander		= "2002", -- 跨服指挥官详情
	cross_map_moveding			= "2003", -- 跨服地图迁城中
	cross_map_getFightInfo      = "2004", -- 跨服获取指挥官战斗力
	cross_map_getBuildInfo		= "2005", -- 获取建筑详细信息
	cross_map_getOtherUnion 	= "2006", -- 跨服获取其他联盟信息
	cross_map_getPlaceObj		= "2007", -- 跨服获取地块信息
	cross_map_getKingdomInfo    = "2008", -- 获取王国的信息
	cross_map_kingdomRank   	= "2009", -- 获取王国排行榜

}

-- 输出推送信息
local DEBUG_NOTIFY = {
	["activity_update"] = true,
}

function cls.handleEvent(v, msg)
	local strType = tostring(v.type)
	local func = NotifyEvent.MAP[strType]

	if TEST_DEV and not User.isInitFinished and strType ~= NotifyEvent.send_start_login then
		print("ERROR*** 用户数据尚未初始化完成收到推送事件", strType)
	end

	if func then
		-- print("收到推送", k)
		-- if  User.isInitFinished then
		-- 	dump(v.result, " Notify Event "..strType)
		-- end
		func(NotifyHandler, v.result)
	else
		print("ERROR***  客户端添加推送事件！！！！  " , strType)
	end
end

function cls:chat_forum(data)
	dump(data, "chat_forum------------->>")
	ChatModel:updateForumMsg(data.uid, data)
	-- MailModel:setMailRead(MAILTYPE.MESSAGE, 0, data.uid, false)
	Util:event(Event.chatForumMsgUpdate, data)
end

function cls:chat_forum_info(data)
	dump(data, "chat_forum_info------------->>")
	local forum = data[1]
	local peoples = data[2]
	if forum then
		ChatModel:updateForum(forum)
		if peoples then
			CommanderModel:updateCommander(peoples)
		end
		Util:event(Event.chatForumUpdate, data)
	end
end

function cls:chat_forum_kick(data)
	local forumId = data
	ChatModel:removeForum(forumId)
	Util:event(Event.chatForumRemove, forumId)
end

function cls:mail(data)
	local umail = data
	MailModel:updateMail(umail)
	MailModel:update()
	MailCtrl:flush()
end

function cls:broadcast(data)
	local tmpBroadCast = data
	ChatModel:addbroadcast(tmpBroadCast,Const.BType.system)
end

function cls:date(data)
	local time = data[1]
	local timezone = data[2]
	Util:initTime(time, timezone)
end

function cls:task(data)
	local newtaskLst = {data}
	TaskModel:updateTask(newtaskLst)
end

function cls:recharge(data)
	PackModel:update(data[1], 3)
	if data[2] then
		VIPModel:initVip(data[2])
	end
	User:update(data[3])
	GiftModel:getInfo(nil,true)
	Util:event(Event.recharge)
	SDKEvent:payComplete()
end

function cls:funcopen(data)
end

function cls:chat(data)
	-- dump(data,">>>>>>>>>>>>")
	local tmpChat = data
	ChatModel:addChat(tmpChat)
end

function cls:friend_add(data)
	local tmpFriend = data
	Tips.show(tmpFriend.name ..Lang:find("sqtjnwhy"))
	FriendModel:setNewApplyLst(tmpFriend)
end

function cls:friend_duct(data)
	local tmpFriend = data
	Tips.show(tmpFriend.name ..Lang:find("yjbnchylbzyc"))
	FriendModel:removeFriendLst(tmpFriend)
	FriendProxy:getFriendsInfo()
end

function cls:friend_present(data)
end

function cls:logout_relogin(data)
	Loading.hide(true)
	Msg.createSysMsg(Lang:find("accountReLogin"), function()
		app:restart()
	end, function () app:restart() end)
	Net:close()
end

function cls:logout_kick(data)
	Loading.hide(true)
	Msg.createSysMsg(Lang:find("accountKickOut"), function()
		app:restart()
	end, function () app:restart() end) 
	Net:close()
end

function cls:fight(data)
	local tmpFight = data
	User:update({fight=tmpFight})
end

function cls:march_status(data)
	local queueWar = data[1]
	--[[
		/** 正常状态-队列信息更新*/
		public static int NORMAL = 0 ;
		/** 行军到达*/
		public static int ARRIVE = 1 ;
		/** 行军返回*/
		public static int GOBACK = 2 ;
		public static int ARRIVE_HOME = 3;
	]]
	local statusType = data[2]
	if statusType == MarchQueueModel.STATUS_TYPE_ARRIVE then
		Sound:play("sound/other/"..46)
		Tips.show(Lang:find("marchToEndPoint"))
	elseif statusType == MarchQueueModel.STATUS_TYPE_ARRIVE_HOME then
		Sound:play("sound/other/"..46)
		Tips.show(Lang:find("marchBack"))
	end

	MarchQueueModel:update(queueWar)
	if queueWar.status == MarchQueueModel.STATE_GO then
		WorldCtrl:followTeam(User.info.uid, queueWar.typeId)
	end
end

--@brief 联盟帮助信息更新
function cls:union_help(data)
	local tmpUnionHelpLst = data
	HelpModel:updateHelpData(tmpUnionHelpLst)
end

function cls:union_support_resource(data)
	PackModel:update(data)
end

function cls:union_applys(data)
	local unionvo = data[1]
	local membervo = data[2]
	local playervo = data[3]
	UnionMemberModel:updateMemberData(unionvo.typeId, membervo)
	UnionModel:setUnion(unionvo)
	UnionMemberModel:updatePlayerInfo({playervo})
end

function cls:union_dismiss(data)
	if UnionModel:getUnionPosition() < 5 then
		Tips.show(Lang:find("lmjsts"))
	end
	UnionModel:setMember(data)
end

function cls:union_refused(data)
	UnionModel:setMember(data[1])
	UnionModel:setUnion(data[2])
end

function cls:union_agree(data)
	UnionModel:setMember(data[2])
	UnionModel:setUnion(data[1])
	if UnionModel:isHasUnion() then
		UnionProxy:initUnionDatas()
	end

	Msg:create(
		Lang:find("lmsqCjlm", UnionModel:getUnionName()), 
	function() end)
end

function cls:union_kick(data)
	if data.uid == User.info.uid then
		UnionModel:setMember(data)
		UnionModel:setUnion(nil)
	else
		UnionMemberModel:removeMember(data.historyUnion, data.uid)
	end
end

function cls:union_exit(data)
	local unionvo = data[1]
	local membervo = data[2]
	local playervo = data[3]
	-- local applys = data[4]
	UnionMemberModel:removeMember(unionvo.typeId, membervo.uid)
	UnionModel:setUnion(unionvo)
end

function cls:union_recall(data)
	local unionvo = data[1]
	local membervo = data[2]
	local playervo = data[3]
	UnionMemberModel:removeMember(unionvo.typeId, membervo.uid)
	UnionModel:setUnion(unionvo)
end

function cls:union_transfer(data)
	local unionvo = data[1]
	local membervo1 = data[2]
	local membervo2 = data[3]
	UnionMemberModel:updateMemberData(membervo1.currUnion, {membervo1, membervo2})
	UnionModel:setUnion(unionvo)
end

-- 接收到别人的帮助
function cls:union_helped(data)
	-- local queueData = data[1]
--[[
	TmpUnionHelped : {
		/** 帮助者名字*/
		private String name ;
		/** 帮助类型*/
		private int type ;
		/** 参数1*/
		private String param1 ;
		/** 参数2*/
		private String param2 ;
		
	}
]]
		-- local helpData = data[2]
	for i, helpData in ipairs(data[1]) do
		local queueData = data[2][i]
		local helpStr = ""
		local params = Util:strSplit(helpData.param, ",")
		local param1 = checknumber(params[1])
		local param2 = checknumber(params[2])
		if tonumber(helpData.type) == HelpModel.HELP_TYPE_UPGRADE then --建造
			local buildDb = db.DBuildConfig_type_lv_map[param1][param2]
			helpStr = Lang:find("bangwojianzao", HelpModel.HELP_STR[tonumber(helpData.type)], param2, buildDb.name)
		elseif tonumber(helpData.type) == HelpModel.HELP_TYPE_RESEARCH then --研究
			if db.TScience[param2] then
				local dbName = db.TScience[param2].key
				if db[dbName] then
					for _, v in pairs(db[dbName]) do
						if v.relevanceId == param1 then
							helpStr = Lang:find("bangwoyanjiu", v.name)
							break
						end
					end
				end
			end
		elseif tonumber(helpData.type) == HelpModel.HELP_TYPE_MAINTAIN then --维修
			helpStr = Lang:find("bangwoweixiu")
		elseif tonumber(helpData.type) == HelpModel.HELP_TYPE_FORGE then -- 锻造
			local dbData = db.DEquip[checknumber(checknumber(param1))]
			helpStr =  Lang:find("helpMeForge", dbData.name)
		end
		

		if helpData.type == HelpModel.HELP_TYPE_UPGRADE then
			dump(BuildQueueModel.queues)
			BuildQueueModel:update(queueData)
		elseif helpData.type == HelpModel.HELP_TYPE_RESEARCH then
			ScienceModel:updateQueue(queueData)
		elseif helpData.type == HelpModel.HELP_TYPE_MAINTAIN then
			CureModel:update(queueData)
		elseif helpData.type == HelpModel.HELP_TYPE_FORGE then
		    EquipForgeModel:updateQueue(queueData)
			EquipForgeModel:update()
			EquipCtrl:flush()
		end
		print("****helped", helpData.name .. helpStr)

		TipsController:addTips(helpData.name .. helpStr)
	end
	
end

--@brief 删除帮助
function cls:union_help_del(data)
	if data.typeId then
		data = {data}
	end
	for _, v in ipairs(data) do
		HelpModel:removeHelp(v)
	end
end

--@brief 行军队列更新
function cls:march_forces(data)
	-- dump(data)
	ForceModel:update(data)
end

function cls:union_tag(data)
	if UnionModel:isHasUnion() then
		UnionModel.union.tagPos = data
		Util:event(Event.unionTag)
	end
end

function cls:march_resource(data)
	local cell = WorldMapModel:strToRC(data.pos)
	-- WorldMapModel:updateCell(cell.row, cell.col)
end

function cls:mail_monster(data)
	MailModel:updateMail(data)
	MailModel:update()
	MailCtrl:flush()
end

function cls:mail_resources(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
end

function cls:mail_pvp(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
end

function cls:mail_investigation(data)
	dump(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
	FormationModel:updateOthersFormation(data)
end

function cls:mail_union(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
end

function cls:web(data)
end

function cls:friend_agree(data)

	Tips.show(data.name ..Lang:find("yjbnjwhy"))
	FriendModel:setNewFriendLst(data)
	FriendModel:removeApplyLst(data)
	FriendProxy:getFriendsInfo()
end

function cls:friend_reject(data)
	Tips.show(data.name ..Lang:find("jjtjnwhy"))
	FriendModel:removeApplyLst(data)
end

function cls:honor_medal(data)
	User:setHonorMetal(data)
end

function cls:item_update(data)
	PackModel:update(data)
end

function cls:item_update_tips(data)
	PackModel:update(data, 1)
end

function cls:equip_suc(data)
	EquipModel:updateEquip(data)
	if data.typeId then
		data = {data}
	end
	for _,v in ipairs(data) do
		EquipCtrl:showNewEquip(v)
	end
end

function cls:union_recommend(data)
	UnionScienceModel:updateScienceData(data)
end

function cls:union_science_queue(data)
	UnionScienceModel:updateScienceQueue(data[1])
	UnionScienceModel:updateScienceData(data[2])
end

function cls:union_war(data)
	dump(data)
	UnionWarModel:updateIds(data[1])
	UnionWarModel:updatePveIds(data[2])
end

function cls:union_war_cancel(data)
	dump(data)
	UnionWarModel:removeWarInfo(data)
end

function cls:union_build_update(data)
	UnionBuildingModel:updateBuilding(data)
end

function cls:union_new_msg(data)
	UnionNoticeModel:addNotice(data)
end

function cls:union_science_queue_start(data)
	UnionScienceModel:updateScienceQueue(data)
end

function cls:union_appoint_info(data)
	local unionvo = data[1]
	local membervo = data[2]
	local playervo = data[3]
	UnionMemberModel:updateMemberData(unionvo.typeId, membervo)
	UnionModel:setUnion(unionvo)
	UnionMemberModel:updatePlayerInfo(playervo)
end

function cls:union_build_delete(data)
	local buildId = data
	UnionBuildingModel:removeBuilding(buildId)
end

function cls:union_members_update(data)
	local unionvo = data[1]
	local membervo = data[2]
	local playervo = data[3]
	UnionMemberModel:updateMemberData(unionvo.typeId, membervo)
	UnionModel:setUnion(unionvo)
	UnionMemberModel:updatePlayerInfo(playervo)
end

function cls:union_agree_join(data)
	local unionvo = data[1]
	local members = data[2]
	local players = data[3]
	UnionMemberModel:updateMemberData(unionvo.typeId, members)
	UnionModel:setUnion(unionvo)
	UnionMemberModel:updatePlayerInfo(players)
end

function cls:union_delete_member(data)
	local unionvo = data[1]
	local memberuid = data[2]
	UnionModel:setUnion(unionvo)
	UnionMemberModel:removeMember(unionvo.typeId, memberuid)
end

function cls:union_extra(data)
	UnionModel:setUnionExtra(data)
end

function cls:horn(data)
	ChatModel:addbroadcast(data,Const.BType.nonSystem)
end

function cls:task_day_suc(data)
	local taskId = data[1]
	local point = data[2]
end

function cls:task_main(data)
	TaskModel:updateTask(data)
end

function cls:attack_monster(data)
	local mstInfo = data[1]
	local str = ""
	if data[3] == 0 then -- 普通怪物
		if data[2] ~= 1 then --战斗失败
			str = Lang:find("yjjmHbxn", mstInfo.lv, db.DMonster[mstInfo.lv].name)
		else
			if User.mstRecord.maxLevel < mstInfo.lv then --首次战胜
				User.mstRecord.maxLevel = mstInfo.lv
				SearchModel:recordMstLv(User.mstRecord.maxLevel + 1)
				str = Lang:find("yjjmGxns", mstInfo.lv, mstInfo.lv + 1)
			else
				str = Lang:find("wonMst", mstInfo.lv, db.DMonster[mstInfo.lv].name)
			end
		end
	elseif data[3] == 1 then -- web怪物
		local dbData = db.DWebActivityMonster[mstInfo.monsterTableId]
		if data[2] ~= 1 then --战斗失败
			str = Lang:find("yjjmHbxn", mstInfo.lv, dbData.monsterName)
		else
			str = Lang:find("wonMst", mstInfo.lv, dbData.monsterName)
		end
	elseif data[3] == 2 then -- 藏宝图外形舰队
		local dbInfo = db.DTreasureShip[mstInfo.id]
		if data[2] ~= 1 then -- 战斗失败
			str = Lang:find("cbt_zdsb",dbInfo.name)
		else
			str = Lang:find("cbt_zdsl",dbInfo.name)
		end
	end
	Util:tick(function()
		Tips.show(str)
	end, 2)
	
end

function cls:honor(data)
	CommanderModel:setDeleteAndAddData(data)
	CommanderModel:setHonorSingleData(data)
end

function cls:task_day_suc_push(data)
	local dailyTaskBoxInfo = data[2]
	if dailyTaskBoxInfo then
		User:setDailyBox(data[2])
		-- User:setDailyBox(dailyTaskBoxInfo.integral,dailyTaskBoxInfo.info)
	end
end

function cls:queue_collect_success(data)
	ProductionModel:updateCollection(data)
end

function cls:march_info_update(data)
	MiReportModel:update(data)
end

function cls:march_info_del(data)
	MiReportModel:removeReport(data)
end

function cls:wall_info(data)
	WallModel:update(data)
end

function cls:vip_update(data)
	VIPModel:initVip(data)
end

function cls:svip_update(data)
	VIPModel:initSVip(data)
end

function cls:view_update(data)
	--[[
	 * data[1] worldType 类型(TWorldType)
	 * data[2] action 动作类型;1=创建;2=消失
	 * data[3] data 影响的数据
	 */
	 ]]
	dump(data, "************收到视觉推送")

	local worldType  = data[1]
	local actionType = data[2]
	local detail 	 = data[3]
	local function PlaceObj(type, tag, pos)
		return {
			tag = tag,
			type = type,
			typeId = pos
		}
	end
	local infos = {}
 	local cell = WorldMapModel:strToRC(detail.pos)
	-- 客户端组织资源占用地块的范围
	if worldType == Const.TWorld.metal or
		worldType == Const.TWorld.gas or
	    worldType == Const.TWorld.energy or
	    worldType == Const.TWorld.crystal or
	    worldType == Const.TWorld.jewel or 
	    worldType == Const.TWorld.monster or 
	    worldType == Const.TWorld.arrowTower or
	    worldType == Const.TWorld.union_base then -- 占1格的世界资源
	    local tmp = PlaceObj(worldType, detail.pos, detail.pos)
	    table.insert(infos, tmp)
	elseif worldType == Const.TWorld.fort or
		 	worldType == Const.TWorld.storage or
		 	worldType == Const.TWorld.mine or
		 	worldType == Const.TWorld.fort then -- 占9格的世界资源
		 	for row = cell.row - 1, cell.row + 1 do
		 		for col = cell.col - 1, cell.col + 1 do
		 			local tmp = PlaceObj(worldType, detail.uid .. "_" .. detail.buildId, col..","..row)
		 			table.insert(infos, tmp)
		 		end
		 	end
	elseif worldType == Const.TWorld.main_city or 
	worldType == Const.TWorld.union_altar then -- 占4格的世界资源
		for row = cell.row, cell.row + 1 do
			for col = cell.col, cell.col + 1 do
				local tmp = PlaceObj(worldType, detail.uid, col..","..row)
	 			table.insert(infos, tmp)
			end
		end
	end

	if actionType == 1 then
		if worldType == Const.TWorld.kingdom_attack then
			WorldCtrl:addKingTowerAttackEffect(detail)
		else
			WorldMapModel:updateCellInfo(infos)
			WorldMapModel:updateResDetails({detail})
		end
	elseif actionType == 2 then
		WorldMapModel:removeRes(detail, true)
	end
end

function cls:buffer_update(data)
	if not data[1] then
		data = {data}
	end
	CityBuffModel:update(data)
end

function cls:union_science_count(data)
	dump(data,"")
	UnionScienceCountModel:updates(data)
end

function cls:protect(state)
	User:update({protect=state})
end

function cls:equip_material_update(data)
	dump(data)
	if data.typeId == "1" then
		MaterialModel:update(data)
	elseif data.typeId == "2" then
		MaterialModel:updateComposeQueue(data)
	end
end

function cls:hboss_union_info(data)
	HBossModel:setHBossUnion(data[1])
	HBossModel:setHBossUser(data[2])
	Util:event(Event.hBossDataUpdate, data)
end

function cls:affairs_skill_update(data)
	AffairsModel:updateSkill(data)
end

function cls:player_area_update(data)
	local tmpArea = data
	User:update({area=tmpArea})
end

-- 军衔等级变更
function cls:military_lv_update(data)
	local preMiliLv = PackModel:getItemNormalCount(Const.TData.TPropCannot,Const.TPropCannot.military_lv)
	if preMiliLv ~= data then
		local dbInfo = CommanderModel:getMilitaryConfig(data)
		if dbInfo then
			PackModel:setItemCount(Const.TData.TPropCannot,Const.TData.military_lv,data,0)
			Tips.new(Lang:find("junx_djbg",dbInfo.name))
		end
	end
end

function cls:activity_update(data)
	ActivityModel:updateActivity(data)
end

function cls:novice_task(data)
	print("收到7天任务完成推送>>>>>>>>>>>>>>")
	TaskModel:updateNoviceTask(data)
end

function cls:equip_forge_record(data)
	EquipForgeModel:updateRecords(data)
end


-- 个人投资数据
function cls:citystate_update(data)
	dump(data, "citystate_update")
	-- 同一个国家所有的排名都推送， 并不止推送最高排名的城市
	CityInvestModel:updateUserInvest(data, true)
end


function cls:citystate_union_update(data)
	dump(data, "citystate_union_update")
	CityInvestModel:updateUnionInvest(data)
end

function cls:cityDestory(data)
	dump(data,"你被打飞字段>>>>>>>>>>>>>>>>>>>>>")
	local tmpArea = data
	User:update({destroyed=tmpArea})
	if User.info.destroyed and
	(CityCtrl.cityView or WorldCtrl.worldView) then --玩家城堡被击飞了
        Msg.createMsg(Lang:find("bl_jfts"), function()
            Net:call(function(v, msg)
                if v.error ~= 0 then
                    return
                end
                User:update(v.result)
                CityCtrl:enterWorld()
            end, "User", "reBuild", User.info.uid)
        end)
    end
end

function cls:buildQueue(data)
	BuildQueueModel:update(data)
end

function cls:science_queue_update(data)
	dump(data)
	ScienceModel:updateQueue(data)
end

function cls:month_card_update(data)
	dump(data)
	MonthCardModel:update(data)
end

function cls:web_task_info(data)
	WebTaskActivityModel:updateUTask(data)
end

function cls:mail_activity(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
end

function cls:union_invite(data)
	print("联盟推荐推送********************************")
	dump(data)
	UnionModel:setUnionInviteData(data)
end

function cls:special_gift_bag(data)
	GiftModel:updateSpecialGift(data)
end

function cls:task_novice_info(data)
	dump(data)
	TaskModel:updateNoviceInfo(data)
end

function cls:player_time_info(data)
	User:setTimeInfo(data)
end

function cls:union_task_info(data)
	UnionTaskModel:updateTaskData(data)
end

function cls:map_send(data)
	if appView.__cname ~= "WorldScene" then
		return
	end
  	-- print("地图数据推送*******", data[1], #data[3])
	WorldMapModel:updateCellInfo(data[2])
	WorldMapModel:updateResDetails(data[3])
	if WorldCtrl.tmpBuilding then -- 如果有建筑正在放置
		WorldCtrl.tmpBuilding:updateCells(true)
	end
	if WorldCtrl.showMenuCell then
		print(">>>刷新世界地图菜单", WorldCtrl.showMenuCell.row, WorldCtrl.showMenuCell.col)
		WorldCtrl:closeWorldMenu()
		WorldCtrl:showWorldMenu(WorldCtrl.showMenuCell)
		WorldCtrl.showMenuCell = nil
	end
end

function cls:union_create_touch(data)
	print("收到创建联盟推送>>>>>>>>主界面会弹出创建联盟tips")
	UnionModel:setUnionCreateTips()
end

function cls:send_start_login(data)
	InitUser:loginBlack(data)
end

function cls:gift_bag_remind(data)
	print(">>>>>>>>>>>>>>>>>>>收到联盟礼包购买推送")
	dump(data)
	GiftModel:updateSpecialGift(data)
end

function cls:lucky_day_info(data)
	print("有新的幸运日buff>>>>>>>>>>>>>>>")
	LuckyDayModel:updateData(data)
	ActivityCtrl:openLuckyDayActivity(true)
end

function cls:map_send_queue(data)
	if appView.__cname ~= "WorldScene" or not WorldCtrl.worldView then
		return
	end
	
	print(">>>>>>行军信息数量", #data)
    for i, marchInfo in ipairs(data[1]) do
    	local userInfo = data[2][i]
		WorldCtrl.worldView:marchUpdate(marchInfo, userInfo)
	end

end

function cls:union_kingdom_war(data)
	KingdomWarModel:updateWar(data)
end

function cls:affairs_kindom_info_update(data)
	KingdomModel:updateKindomInfo(data)
end

function cls:age_condition(data)
	CivilizationAgeModel:updateData(data)
end

function cls:savings_info(data)
	SavingsModel:updateData(data)
end

function cls:union_science(data)
	dump(data)
end

function cls:treasure_info(data)
	TreasureModel:updateData(data)
end

function cls:friend_info(data)
	FriendModel:setFriendInfo(data)
end

function cls:pack_library_info(data)
	dump(data)
	GiftModel:updateLibraryInfo(data)
end

function cls:collect_info(data)
	PackModel:update(data[1])
	for _,v in ipairs(data[2]) do
		ProductionModel:updateCollection(v)
	end
	BuildQueueModel:updateResRobot(data[3])
end

function cls:union_initiative_info(data)
	dump(data)
	UnionAltarModel:updateActive(data[1])
	if data[2] then
		PackModel:update(data[2])
	end
end

function cls:union_logic_info(data)
	dump(data)
	UnionAltarModel:updateLogic(data[1])
	if data[2] then
		PackModel:update(data[2])
	end
end

function cls:union_battle_info(data)
	UnionBattleModel:updateData(data)
end

function cls:cannon_armour(data)
	CannonArmourModel:updateArmour(data)
end

function cls:task_chapter_info(data)
	ChapterTaskModel:updateData(data)
end

function cls:cross_map_getOtherUnion(data)
	if data.typeId == UnionModel:getUnionTypeId() then
		UnionModel:setUnion(data)
	else
		UnionModel:updateUnionData(data)
	end
end

function cls:cross_map_moved(data)
	-- dump(data)
	if appView.__cname ~= "WorldScene" then
		return
	end
  	print("跨服地图数据推送*******", data[1], #data[3])
	WorldMapModel:updateCellInfo(data[2])
	WorldMapModel:updateResDetails(data[3])
	if WorldCtrl.tmpBuilding then -- 如果有建筑正在放置
		WorldCtrl.tmpBuilding:updateCells(true)
	end
	if WorldCtrl.showMenuCell then
		print(">>>刷新世界地图菜单", WorldCtrl.showMenuCell.row, WorldCtrl.showMenuCell.col)
		WorldCtrl:closeWorldMenu()
		WorldCtrl:showWorldMenu(WorldCtrl.showMenuCell)
		WorldCtrl.showMenuCell = nil
	end
end

--[[
  "kingdomName" = ""
  "serverId"    = 554
  "starName"    = ""
]]
function cls:cross_map_list(data)
	CrossServerModel:updateServerLst(data)
	Util:event(Event.crossServerList)
end

function cls:cross_map_getCommander(data)
	CommanderModel:updateCommander(data[1])
	CommanderModel:setFocusUser(data[1])
	Util:event(Event.commanderInfoUpdate, data)
end		

function cls:cross_map_moveding(data)
	if data then
		Util:event(Event.crossServerFinish)
	else
		Msg.new(Lang:find("crs_mving"), function()
			app:restart()
		end)
	end
end

function cls:cross_map_getFightInfo(data)
	dump(data, "cross_map_getFightInfo")
	CommanderModel:updateFightDetailedDatas(data[2].uid, FightDetailedVo(data[1] or {}, data[2] or {}, data[3] or {}, data[4] or {}))
end

function cls:cross_map_getBuildInfo(data)
	local buildingInfo = data[1]
	local marchQueueLst = data[2] or {}
	local __ = data[3] -- 暂时不用
	local userInfoLst = data[4] or {}
	local extraInfo = data[5] or {}
	ViewData["UnionBuildingDetail"] = {buildingInfo, marchQueueLst, userInfoLst, extraInfo}
	Util:event(Event.worldBuildDetailUpdate)
end

function cls:cross_map_getPlaceObj(data)
	Util:event(Event.worldPlaceUpdate, data[1], data[2])
end

function cls:mail_cannon(data)
	local maildata = data
	MailModel:updateMail(maildata)
	MailModel:update()
	MailCtrl:flush()
end

function cls:cross_map_getKingdomInfo(data)
	Util:event(Event.crossMapKingdomInfoUpdate, data)
end

function cls:cross_map_kingdomRank(data)
	Util:event(Event.crossMapKingRankUpdate, data)
end

-- 将TYPE转为function
NotifyEvent.MAP = {}
for key, eventType in pairs(NotifyEvent) do
	NotifyEvent.MAP[eventType] = cls[key]
end

return cls