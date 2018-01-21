package com.model.rpc.server;

/**
 * 回合记录的内容
 */
public class PlayerRecordContent {
	private String uid;
	private int type;
	private Object content;
	public PlayerRecordContent(String uid, int type,Object content) {
		this.uid = uid;
		this.type = type;
		this.content = content;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public Object getContent() {
		return content;
	}
	public void setContent(Object content) {
		this.content = content;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
