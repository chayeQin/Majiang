package com.model.game.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.statics.TRoomType;

/**
 * 房间状态
 */
public class RoomStatus {
	private String roomId; //房间的编号
	private boolean status; //房间状态
	private int roomType;//房间类型
	private int maxCount;//场次
	private String types;//玩法字符串
	private int maxSize;//人数
	
	private int count;//当前场次
	private int bankerIndex; //庄家下标
	
	private int librarySize;//剩余的牌堆数量
	
	private RoomPlayer[] players; //里面的玩家
	private Map<String, Integer> playerIndexs;//玩家所在的位置
	
	private int outIndex; //出牌的人
	private int outCard;  //出牌的牌
	
	
	
	private List<String> waitPlayers;//等待的列表
	public RoomStatus() {
	}
	public RoomStatus(String roomId, int roomType, int count, String types, int size, String[] players) {
		this.roomType = roomType;
		this.roomId = roomId;
		this.maxCount = count;
		this.types = types;
		this.maxSize = size;
		this.status = false;
		this.bankerIndex = 0;
		this.players = new RoomPlayer[players.length];
		this.playerIndexs = new HashMap<String, Integer>();
		for (int i = 0; i < players.length; i++) {
			this.players[i] = new RoomPlayer(i, players[i]);
			this.playerIndexs.put(players[i], i);
		}
		this.waitPlayers = new ArrayList<>();
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public int getRoomType() {
		return roomType;
	}

	public void setRoomType(int roomType) {
		this.roomType = roomType;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}
	public int getMaxCount() {
		return maxCount;
	}
	public void setMaxCount(int maxCount) {
		this.maxCount = maxCount;
	}
	public int getMaxSize() {
		return maxSize;
	}
	public void setMaxSize(int maxSize) {
		this.maxSize = maxSize;
	}
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public int getBankerIndex() {
		return bankerIndex;
	}

	public void setBankerIndex(int bankerIndex) {
		this.bankerIndex = bankerIndex;
	}

	public int getLibrarySize() {
		return librarySize;
	}

	public void setLibrarySize(int librarySize) {
		this.librarySize = librarySize;
	}

	public RoomPlayer[] getPlayers() {
		return players;
	}
	
	public RoomPlayer getPlayer(String uid) {
		return players[playerIndexs.get(uid)];
	}

	public void setPlayers(RoomPlayer[] players) {
		this.players = players;
	}

	public Map<String, Integer> getPlayerIndexs() {
		return playerIndexs;
	}

	public void setPlayerIndexs(Map<String, Integer> playerIndexs) {
		this.playerIndexs = playerIndexs;
	}

	public int getOutIndex() {
		return outIndex;
	}

	public void setOutIndex(int outIndex) {
		this.outIndex = outIndex;
		if(this.outIndex >= this.players.length){
			this.outIndex = this.outIndex - this.players.length;
		}
	}

	public int getOutCard() {
		return outCard;
	}

	public void setOutCard(int outCard) {
		this.outCard = outCard;
	}

	public List<String> getWaitPlayers() {
		return waitPlayers;
	}

	public void setWaitPlayers(List<String> waitPlayers) {
		this.waitPlayers = waitPlayers;
	}
	/**
	 * 清理掉数据
	 */
	public void clear() {
		for (RoomPlayer p : players) {
			p.clear();
		}
	}

}
