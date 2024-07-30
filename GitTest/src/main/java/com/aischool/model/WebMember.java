package com.aischool.model;

public class WebMember {
	public String email;
	public String pw;
	public String name;
	public String id;
	private int scheduleCount;
	
	public WebMember() {}
	
	public WebMember(String email, String pw, String name, String id) {
		super();
		this.email = email;
		this.pw = pw;
		this.name = name;
		this.id = id;
	}
	
	public WebMember(String email, String pw, String name, String id, int scheduleCount) {
        this.email = email;
        this.pw = pw;
        this.name = name;
        this.id = id;
        this.scheduleCount = scheduleCount;
    }
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getScheduleCount() {
        return scheduleCount;
    }

    public void setScheduleCount(int scheduleCount) {
        this.scheduleCount = scheduleCount;
    }

			
}
