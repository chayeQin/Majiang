package com.rpc.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.model.game.server.RoomStatus;
import com.model.rpc.server.GameServer;
import com.model.rpc.server.Room;
import com.model.rpc.tb.Player;
import com.model.rpc.tb.PlayerRecord;
import com.rpc.netty.SystemHandler;
import com.statics.ErrorException;
import com.statics.TResponseCode;
import com.util.MySqlUtil;

/**
 * 房间管理器
 */
public class RoomAction {
	/** 玩家的房间数据 **/
	private static final Map<String, String> userRooms = new ConcurrentHashMap<String, String>();
	/** 当前的房间 **/
	private static final Map<String, Room> rooms = new ConcurrentHashMap<>();
	
	private static final Random RANDOM = new Random();
	/**
	 * 创建房间
	 * @param uid
	 * @return 
	 */
	public static String create(String uid, int count, String types, int size) throws Exception{
		if(userRooms.containsKey(uid)){
			String roomId = userRooms.get(uid);
			//已经进入了房间,推送房间信息给玩家
			sendRoomInfo(uid, roomId);
			return roomId;
		}
		String roomId = getRandomRoomId();
		Room room = new Room(roomId, uid, count, types, size);
		rooms.put(roomId, room);
		userRooms.put(uid, roomId);
		sendRoomInfo(uid, roomId);
		return roomId;
	}
	/**
	 * 加入房间
	 * @param uid
	 * @param roomId
	 * @return 
	 */
	public static String join(String uid,String roomId) throws Exception{
		if(userRooms.containsKey(uid)){
			roomId = userRooms.get(uid);
			//已经进入了房间,推送房间信息给玩家
			sendRoomInfo(uid, roomId);
			return roomId;
		}
		//不存在
		if(!rooms.containsKey(roomId)){
			throw new ErrorException("房间不存在");
		}
		//人数已满
		Room room = rooms.get(roomId);
		if(room.isFull()){
			throw new ErrorException("房间人数已满");
		}
		room.join(uid);
		userRooms.put(uid, roomId);
		String[] players = room.getPlayers();
		for (String uuid : players) {
			if(null == uuid)continue;
			sendRoomInfo(uuid, roomId);
		}
		return roomId;
	}
	
	/** 
	 * 准备  
	 * @param uid
	 */
	public static String prepare(String uid) throws Exception{
		if(!userRooms.containsKey(uid)){
			throw new ErrorException("未加入房间");
		}
		String roomId = userRooms.get(uid);
		Room room = rooms.get(roomId);
		if(null == room){
			throw new ErrorException("房间已解散");
		}
		room.prepare(uid);
		String[] players = room.getPlayers();
		for (String uuid : players) {
			if(null == uuid)continue;
			sendRoomInfo(uuid, roomId);
		}
		
		//如果全部是准备状态,并且局数未超过最大局
		if(room.isPrepare() && room.getCount() < room.getMaxCount()){
			start(room.getPlayers()[0]);
		}
		return roomId;
	}
	/**
	 * 开始游戏
	 * @param uid
	 */
	public static void start(String uid) throws Exception{
		if(!userRooms.containsKey(uid)){
			throw new ErrorException("未加入房间");
		}
		String roomId = userRooms.get(uid);
		Room room = rooms.get(roomId);
		if(null == room){
			throw new ErrorException("房间已解散");
		}
		if(room.getCount() >= room.getMaxCount()){
			throw new ErrorException("房间次数不足");
		}
		if(!room.isRoomOwners(uid)){
			throw new ErrorException("您不是房主,没有权限操作!");
		}
		if(!room.isPrepare()){
			throw new ErrorException("没有全部准备!");
		}
		//已经开始
		if(room.isStart()){
			sendRoomInfo(uid, roomId);
			return;
		}
		//随机一个服务器
		if(room.getServerId() <= 0){
			int serverId = GameServerAction.getServerByWeight();
			if(serverId <= 0){
				throw new ErrorException("操作失败,请稍后重试!");
			}
			room.setServerId(serverId);
		}
		if(room.getRecord() == null){
			room.start();
			String playersStr = "";
			String[] players = room.getPlayers();
			for (int i = 0;i < players.length;i++) {
				String uuid = players[i];
				if(null == uuid)continue;
				sendRoomInfo(uuid, roomId);
				if(i == players.length-1){
					playersStr = playersStr + uuid;
				}else{
					playersStr = playersStr + uuid + ",";
				}
			}
			if(playersStr.endsWith(",")) playersStr = playersStr.substring(0,playersStr.length() - 1);
			//通知游戏服务器
			GameServerAction.send(room.getServerId(), "room", "start", roomId, room.getRoomType(), room.getMaxCount(), room.getTypes(), room.getMaxSize(), playersStr);
			GameServerAction.roomCreate(room.getServerId());
		}else{
			//保存上一句的记录
			PlayerRecord record = room.getRecord();
			String content = JSON.toJSONString(room.getRecordContents());
			record.setContent(content);
			MySqlUtil.insert(record);
			
			room.start();
			//通知游戏服务器
			GameServerAction.send(room.getServerId(), "room", "restart", roomId);
		}
	}
	/**
	 * 随机一个房间id
	 * @return
	 */
	private static String getRandomRoomId() {
		String str = String.valueOf(RANDOM.nextInt(999999));
		for(int i = str.length();i < 6; i ++){
			str = str + RANDOM.nextInt(10);
		}
		if(rooms.containsKey(str)){
			return getRandomRoomId();
		}
		return str;
	}

	/**
	 * 发送房间信息给玩家
	 * @param uid
	 * @param roomId
	 */
	private static void sendRoomInfo(String uid, String roomId) throws Exception {
		Room room = rooms.get(roomId);
		List<Map<String, Object>> list = new ArrayList<>(4);
		String[] players = room.getPlayers();
		for (int i = 0;i < players.length;i++) {
			String uuid = players[i];
			if(uuid == null)continue;
			Map<String, Object> map = new HashMap<>();
			map.put("uid", uuid);
			map.put("index", i);
			map.put("state", room.getPlayerState(i));
			map.putAll(PlayerAction.playerReturn(uuid));
			list.add(map);
		}
		Map<String, Object> map = new HashMap<>();
		map.put("roomId", room.getRoomId());
		map.put("status", room.getRoomState());
		map.put("maxSize", room.getMaxSize());
		map.put("maxCount", room.getMaxCount());
		map.put("types", room.getTypes());
		map.put("roomType", room.getRoomType());
		map.put("players", list);
		map.put("exitUids", room.getExitUids());
		SystemHandler.send(uid, TResponseCode.update_room, map);
	}
	
	/**
	 * 获取房间状态(断线重连后)
	 * @param uid
	 */
	public static Object getRoomStatus(String uid) throws Exception{
		if(!userRooms.containsKey(uid)){
			return -1;
		}
		String roomId = userRooms.get(uid);
		Room room = rooms.get(roomId);
		if(null == room){
			userRooms.remove(uid);
			return -1;
		}
		sendRoomInfo(uid, roomId);
		return roomId;
	}
	/**
	 * 获取游戏状态(断线重连后)
	 * @param uid
	 */
	public static Object getGameStatus(String uid) throws Exception{
		if(!userRooms.containsKey(uid)){
			return -1;
		}
		String roomId = userRooms.get(uid);
		Room room = rooms.get(roomId);
		if(null == room){
			return -1;
		}
		if(null != room.getRoomStatus()){
			SystemHandler.send(uid, TResponseCode.update_game, room.getRoomStatus());
		}
		return roomId;
	}
	
	/**
	 * 更新房间
	 */
	public static void gs_updateGame(JSONObject obj) {
		RoomStatus roomStatus = JSON.parseObject(obj.toJSONString(), RoomStatus.class);
		Room room = rooms.get(roomStatus.getRoomId());
		if(null == room){
			return;
		}
		room.setRoomStatus(roomStatus);
		String[] players = room.getPlayers();
		for (String uuid : players) {
			SystemHandler.send(uuid, TResponseCode.update_game, roomStatus);
		}
	}
	
	/**
	 * 操作
	 * @param uid
	 * @param type 操作类型
	 * @return 
	 */
	public static int doAction(String uid, int type){
		return doAction(uid, type, null);
	}
	/**
	 * 操作
	 * @param uid
	 * @param type 操作类型
	 * @param card 操作的牌
	 * @return 
	 */
	public static int doAction(String uid, int type,int[] card){
		String roomId = userRooms.get(uid);
		if(roomId == null)return type;
		Room room = rooms.get(roomId);
		if(null == room)return type;
		if(room.isDoAction(uid)){
			int serverId = room.getServerId();
			if(serverId > 0){
				if(null == card){
					GameServerAction.send(serverId, "room", "doAction", roomId, uid, type);
				}else{
					GameServerAction.send(serverId, "room", "doAction", roomId, uid, type, card);
				}
			}
		}
		return type;
	}
	
	public static void gs_doAction(String roomId, String uid, int type) {
		gs_doAction(roomId, uid, type, null);
	}
	public static void gs_doAction(String roomId, String uid, int type,int[] card) {
		Room room = rooms.get(roomId);
		if(null == room)return;
		String[] players = room.getPlayers();
		for (String uuid : players) {
			if(null == card){
				SystemHandler.send(uuid, TResponseCode.do_action, uid, type);
			}else{
				SystemHandler.send(uuid, TResponseCode.do_action, uid, type, card);
			}
		}
	}
	
	/**
	 * 聊天
	 * @param uid
	 * @param str
	 * @return 
	 */
	public static String chat(String uid,String str){
		String roomId = userRooms.get(uid);
		if(roomId == null)return uid ;
		Room room = rooms.get(roomId);
		if(null == room)return uid;
		String[] players = room.getPlayers();
		for (String uuid : players) {
			SystemHandler.send(uuid, TResponseCode.chat, uid, str);
		}
		return roomId;
	}
	/**
	 * 退出房间
	 * @return 
	 */
	public static String exit(String uid) throws Exception{
		String roomId = userRooms.get(uid);
		if(roomId == null)return uid;
		Room room = rooms.get(roomId);
		if(null == room)return uid;
		room.exit(uid);
		
		if(room.getExitUids().size() >= room.getPlayerSize()){
			//通知游戏服务器
			GameServerAction.send(room.getServerId(), "room", "exit", roomId);
			rooms.remove(roomId);
			String[] players = room.getPlayers();
			for (String uuid : players) {
				if(null != uuid){
					userRooms.remove(uuid);
				}
			}
			GameServerAction.roomExit(room.getServerId());
		}
		return roomId;
	}
}
