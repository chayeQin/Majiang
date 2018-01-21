package com.statics;

public class ErrorException extends Exception{
	private static final long serialVersionUID = 1L;
	private String msg;
	public ErrorException(String msg) {
		this.msg = msg;
	}
	public String getMsg(){
		return msg;
	}
}
