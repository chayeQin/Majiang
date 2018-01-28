package com.model.rpc.server;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import com.model.game.server.RoomStatus;
import com.model.rpc.tb.PlayerRecord;
import com.statics.TRoomType;
import com.util.DateUtil;

public class Room {
	private String roomId;
	private int maxCount;
	private String types;
	private int maxSize;
	private int serverId;
	private int roomType;
	
	private int count;
	
	private String[] players;
	private boolean[] playerState;
	private int playerSize = 0;
	
	private boolean roomState;
	//当前牌局的记录
	private PlayerRecord record;
	private List<PlayerRecordContent> recordContents;
	private RoomStatus roomStatus = null;
	
	private List<String> exitUids;
	
	public Room(String roomId, String uid, int maxCount, String types, int maxSize) {
		this.roomType = TRoomType.def;
		this.roomId = roomId;
		this.players = new String[maxSize];
		this.playerState = new boolean[maxSize];
		this.players[0] = uid;
		this.playerState[0] = true; //默认准备
		this.playerSize++;
		this.roomState = false;
		this.maxCount = maxCount;
		this.types = types;
		this.maxSize = maxSize;
		this.count = 0;
		this.exitUids = new ArrayList<String>();
	}
	/** 是否满了 **/
	public boolean isFull(){
		return this.playerSize >= this.maxSize;
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
		this.count++;
		String uuid = UUID.randomUUID().toString();
		uuid = uuid.replaceAll("-", "");
		this.record = new PlayerRecord();
		this.record.setRid(uuid);
		this.record.setRoomId(roomId);
		this.record.setRound(this.count);
		String playersStr = "";
		for (int i = 0;i < players.length;i++) {
			uuid = players[i];
			if(null == uuid)continue;
			if(i == players.length-1){
				playersStr = playersStr + uuid;
			}else{
				playersStr = playersStr + uuid + ",";
			}
		}
		if(playersStr.endsWith(",")) playersStr = playersStr.substring(0,playersStr.length() - 1);
		this.record.setPlayers(playersStr);
		this.record.setTime(DateUtil.format.format(new Date()));
		this.recordContents = new ArrayList<>();
	}
	/*** 申请退出房间 **/
	public void exit(String uid) {
		if(! this.exitUids.contains(uid) ){
			this.exitUids.add(uid);
		}
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
		if(playerSize < this.maxSize)return false;
		
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
	public int getMaxCount() {
		return maxCount;
	}
	public void setMaxCount(int count) {
		this.maxCount = count;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	public int getMaxSize() {
		return maxSize;
	}
	public void setMaxSize(int maxSize) {
		this.maxSize = maxSize;
	}
	public int getRoomType() {
		return this.roomType;
	}
	public PlayerRecord getRecord() {
		return record;
	}
	public List<PlayerRecordContent> getRecordContents() {
		return recordContents;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<String> getExitUids() {
		return exitUids;
	}
	public void setExitUids(List<String> exitUids) {
		this.exitUids = exitUids;
	}
	public int getPlayerSize() {
		return this.playerSize;
	}
}
