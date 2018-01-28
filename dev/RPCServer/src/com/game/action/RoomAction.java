package com.game.action;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class RoomAction {
	private static final Map<String, RoomLogic> roomLogics = new ConcurrentHashMap<>();
	
	/**
	 * 开始游戏
	 * @param roomId
	 * @param players 玩家列表(uid,uid,uid)
	 */
	public static void start(String roomId,int roomType, int count, String types, int size, String players){
		if(players.endsWith(","))players = players.substring(0,players.length()-1);
		
		RoomLogic logic = new RoomLogic(roomId, roomType, count, types, size, players);
		logic.start();
		roomLogics.put(roomId, logic);
	}
	/**
	 * 重新开始游戏
	 */
	public static void restart(String roomId) {
		RoomLogic logic = roomLogics.get(roomId);
		if(null != logic){
			logic.start();
		}
	}
	/**
	 * 解散房间
	 */
	public static void exit(String roomId) {
		roomLogics.remove(roomId);
	}
	/**
	 * 执行动作
	 */
	public static void doAction(String roomId, String uid, int type){
		doAction(roomId, uid, type, null);
	}
	/**
	 * 执行动作
	 * @param roomId
	 * @param uid
	 * @param type 操作类型
	 * @param cards 操作的牌
	 */
	public static void doAction(String roomId, String uid, int type, int[] cards){
		RoomLogic logic = roomLogics.get(roomId);
		if(null != logic){
			logic.doAction(uid, type, cards);
		}
	}
}
