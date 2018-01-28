package com.model.game.server;

/**
 * 房间结算界面
 */
public class RoomSettlement {
	private String uid;
	private int[] score;//分数列表（胡分、杠分、总计）
	private int type;//类型;1=自摸;2=胡牌;3=放炮
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int[] getScore() {
		return score;
	}
	public void setScore(int[] score) {
		this.score = score;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
