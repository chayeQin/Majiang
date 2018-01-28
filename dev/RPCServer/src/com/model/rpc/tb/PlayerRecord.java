package com.model.rpc.tb;

import com.model.Column;
import com.model.Model;
import com.model.Table;

@Table(name = "tb_player_record")
public class PlayerRecord extends Model{
	private String rid;
	private String roomId;
	private int round;
	private String players;
	private String time;
	private String content;
	
	public int getRound() {
		return round;
	}
	public void setRound(int round) {
		this.round = round;
	}
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
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
