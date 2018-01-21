package com.model.rpc.server;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.model.game.server.RoomStatus;
import com.model.rpc.tb.PlayerRecord;
import com.statics.TRoomType;

public class Room {
	private String roomId;
	private int count;
	private String types;
	private int size;
	private int serverId;
	private int roomType;
	
	private String[] players;
	private boolean[] playerState;
	private int playerSize = 0;
	
	private boolean roomState;
	//当前牌局的记录
	private PlayerRecord record;
	private List<PlayerRecordContent> recordContents;
	private RoomStatus roomStatus = null;	
	
	public Room(String roomId, String uid, int count, String types, int size) {
		this.roomType = TRoomType.def;
		this.roomId = roomId;
		this.players = new String[size];
		this.playerState = new boolean[size];
		this.players[0] = uid;
		this.playerState[0] = true; //默认准备
		this.playerSize++;
		this.roomState = false;
		this.count = count;
		this.types = types;
		this.size = size;
	}
	/** 是否满了 **/
	public boolean isFull(){
		return this.playerSize >= this.size;
	}
	/** 加入房间 **/
	public void join(String uid) {
		for (int i = 0; i < players.length; i++) {
			if(players[i] == null){
				players[i] = uid;
				this.playerSize++;
				break;
			}
		}
	}
	/** 准备 **/
	public void prepare(String uid) {
		for (int i = 0; i < players.length; i++) {
			if(uid.equals(players[i])){
				playerState[i] = true;
				break;
			}
		}
	}
	/** 开始游戏 **/
	public void start() {
		this.roomState = true;
		restart();
	}
	
	/**
	 * 重新开始
	 */
	public void restart() {
		String uuid = UUID.randomUUID().toString();
		uuid = uuid.replaceAll("-", "");
		this.record = new PlayerRecord();
		this.record.setRid(uuid);
		this.recordContents = new ArrayList<>();
	}
	
	public String[] getPlayers() {
		return this.players;
	}
	public boolean getPlayerState(int i) {
		return this.playerState[i];
	}
	public String getRoomId() {
		return this.roomId;
	}
	/** 是否是房主 **/
	public boolean isRoomOwners(String uid) {
		return uid.equals(players[0]);
	}
	/** 是否都准备好了 **/
	public boolean isPrepare() {
		if(playerSize < this.size)return false;
		
		for(int i = 0;i < playerState.length;i++){
			if(playerState[i] == false){
				return false;
			}
		}
		return true;
	}
	public boolean getRoomState() {
		return this.roomState;
	}
	public void setServerId(int serverId) {
		this.serverId = serverId;
	}
	public int getServerId(){
		return this.serverId;
	}
	public boolean isStart() {
		return this.roomState;
	}
	public void addPlayerRecord(String uid, int type, Object content) {
		this.recordContents.add(new PlayerRecordContent(uid, type, content));
	}
	public boolean isDoAction(String uid) {
		if(roomStatus == null)return false;
		return roomStatus.getWaitPlayers().contains(uid);
	}
	public void setRoomStatus(RoomStatus roomStatus) {
		this.roomStatus = roomStatus;
	}
	public RoomStatus getRoomStatus() {
		return roomStatus;
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
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getRoomType() {
		return this.roomType;
	}
	
}
