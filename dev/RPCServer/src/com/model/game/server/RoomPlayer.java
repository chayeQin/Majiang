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
	private int[] actions;
	public RoomPlayer() {
	}
	public RoomPlayer(int index,String uid) {
		this.index = index;
		this.uid = uid;
		this.hand = new ArrayList<Integer>();
		this.lose = new ArrayList<Integer>();
		this.top = new ArrayList<>();
		this.actions = new int[4];
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
		for (int i = 0;i < this.actions.length; i++) {
			this.actions[i] = 0;
		}
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

	public int[] getActions() {
		return actions;
	}

	public void setActions(int[] playerActions) {
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
	public void doActions(boolean chi, boolean peng, boolean gang, boolean hu) {
		this.actions[0] = chi ? 1 : 0;
		this.actions[1] = peng ? 1 : 0;
		this.actions[2] = gang ? 1 : 0;
		this.actions[3] = hu ? 1 : 0;
	}
	public void doActions(int chi, int peng, int gang, int hu) {
		this.actions[0] = chi;
		this.actions[1] = peng;
		this.actions[2] = gang;
		this.actions[3] = hu;
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
