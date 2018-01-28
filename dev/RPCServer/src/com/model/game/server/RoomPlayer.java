package com.model.game.server;

import java.util.ArrayList;
import java.util.List;

/**
 * 房间里面的玩家
 */
public class RoomPlayer {
	private int index;
	private String uid;
	/** 手牌 **/
	private List<Integer> hand;
	/** 玩家丢弃的牌 **/
	private List<Integer> lose;
	/** 玩家头顶上特殊处理的牌 **/
	private List<List<Integer>> top;
	
	/** 是否听牌 **/
	private boolean listen;
	/** 当前积分 **/
	private int socre;
	
	/** 玩家可以有的操作[吃,碰,杠,胡,听] **/
	private List<Integer> actions;
	public RoomPlayer() {
	}
	public RoomPlayer(int index,String uid) {
		this.index = index;
		this.uid = uid;
		this.hand = new ArrayList<Integer>();
		this.lose = new ArrayList<Integer>();
		this.top = new ArrayList<>();
		this.actions = new ArrayList<>();
		this.listen = false;
	}
	/**
	 * 清理掉数据
	 */
	public void clear() {
		this.listen = false;
		this.hand.clear();
		this.lose.clear();
		this.top.clear();
		this.actions.clear();
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public List<Integer> getHand() {
		return hand;
	}
	public void setHand(List<Integer> hand) {
		this.hand = hand;
	}
	public List<Integer> getLose() {
		return lose;
	}

	public void setLose(List<Integer> lose) {
		this.lose = lose;
	}

	public List<List<Integer>> getTop() {
		return top;
	}

	public void setTop(List<List<Integer>> top) {
		this.top = top;
	}

	public List<Integer> getActions() {
		return actions;
	}

	public void setActions(List<Integer> playerActions) {
		this.actions = playerActions;
	}
	@Override
	public boolean equals(Object obj) {
		if(null == obj)return false;
		if(obj instanceof RoomPlayer){
			return this.uid.equals(((RoomPlayer) obj).getUid());
		}
		return false;
	}
	public boolean isListen() {
		return listen;
	}
	public void setListen(boolean listen) {
		this.listen = listen;
	}
	public int getSocre() {
		return socre;
	}
	public void setSocre(int socre) {
		this.socre = socre;
	}
}
