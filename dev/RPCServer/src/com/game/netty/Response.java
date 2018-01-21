package com.game.netty;

public class Response {
	private int id;
	private String bean;
	private String method;
	private Object[] params;
	private long time;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBean() {
		return bean;
	}
	public void setBean(String bean) {
		this.bean = bean;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public Object[] getParams() {
		return params;
	}
	public void setParams(Object[] params) {
		this.params = params;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
}
