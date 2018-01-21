package com.model;

public abstract class Model {
	private int id;
	
	@Column(id = true)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}
