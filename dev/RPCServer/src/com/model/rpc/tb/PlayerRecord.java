package com.model.rpc.tb;

import com.model.Column;
import com.model.Model;
import com.model.Table;

@Table(name = "tb_player_record")
public class PlayerRecord extends Model{
	private String rid;
	private String roomId;
	private String players;
	private long time;
	private String content;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getPlayers() {
		return players;
	}
	public void setPlayers(String players) {
		this.players = players;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
	@Column(type = "text")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
