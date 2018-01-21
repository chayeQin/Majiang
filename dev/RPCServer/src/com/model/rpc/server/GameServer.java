package com.model.rpc.server;

public class GameServer{
	private int 	serverId;	//服务器id
	private String	channel;  	//当前连接
	private int 	roomSize; 	//当前房间数量
	private int		playerSize; //当前玩家数量
	
	public int getServerId() {
		return serverId;
	}
	public void setServerId(int serverId) {
		this.serverId = serverId;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	public int getRoomSize() {
		return roomSize;
	}
	public void setRoomSize(int roomSize) {
		this.roomSize = roomSize;
	}
	public int getPlayerSize() {
		return playerSize;
	}
	public void setPlayerSize(int playerSize) {
		this.playerSize = playerSize;
	}
}
