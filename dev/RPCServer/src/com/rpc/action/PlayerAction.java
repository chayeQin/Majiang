package com.rpc.action;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.model.rpc.tb.Player;
import com.rpc.netty.SystemHandler;
import com.statics.ErrorException;
import com.statics.TResponseCode;
import com.util.MySqlUtil;

public class PlayerAction {
	private static final Map<String, Player> players = new ConcurrentHashMap<String, Player>();
	
	public static Player getPlayer(String uid) throws Exception{
		if(players.containsKey(uid)){
			return players.get(uid);
		}
		Player player = MySqlUtil.getOneBySql(Player.class, "select * from tb_player where uid=?", uid);
		if(null == player){
			return null;
		}
		players.put(uid, player);
		return player;
	}
	/**
	 * 注册
	 * @param uid
	 * @param nickname 昵称
	 * @param headimgurl 头像
	 * @return [0=uid;1=昵称;2=当前房卡数]
	 */
	public static Object register(String uid, String nickname, String headimgurl) throws Exception{
		Player player = getPlayer(uid);
		if(null != player){
			return playerReturn(player);
		}
		player = new Player();
		player.setUid(uid);
		player.setNickname(nickname);
		player.setHeadimgurl(headimgurl);
		player.setCardNumber(4);
		MySqlUtil.insert(player);
		player.setId(MySqlUtil.getOneBySql(Integer.class, "select id from tb_player where uid=?", uid));
		players.put(uid, player);
		
		return playerReturn(player);
	}
	public static Object getPlayerInfo(String uid,String uuid) throws Exception{
		return playerReturn(uuid);
	}
	public static Map<String, Object> playerReturn(String uid) throws Exception {
		Player player = getPlayer(uid);
		return playerReturn(player);
	}
	public static Map<String, Object> playerReturn(Player player) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(null != player){
			map.put("uid", player.getUid());
			map.put("nickname", player.getNickname());
			map.put("headimgurl", player.getHeadimgurl());
			map.put("num", player.getCardNumber());
		}
		return map;
	}
	/**
	 * 登录
	 * @param uid
	 * @param nickname 昵称
	 * @param headimgurl 头像
	 * @return [0=uid;1=昵称;2=当前房卡数]
	 */
	public static Object login(String uid, String nickname, String headimgurl) throws Exception{
		if(uid == null || uid.isEmpty())return null;
		Player player = getPlayer(uid);
		if(null == player){
			return register(uid, nickname, headimgurl);
		}
		return playerReturn(player);
	}
}
