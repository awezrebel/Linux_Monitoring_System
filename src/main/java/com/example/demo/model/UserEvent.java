package com.example.demo.model;

import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class UserEvent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    
    private String serverip;
    private String Timestamp;
    private String event;
    private String username;
     
    private String userip;
    private String command;
	public UserEvent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserEvent(Integer id, String serverip, String timestamp, String event, String username, String userip,
			String command) {
		super();
		this.id = id;
		this.serverip = serverip;
		Timestamp = timestamp;
		this.event = event;
		this.username = username;
		this.userip = userip;
		this.command = command;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getServerip() {
		return serverip;
	}
	public void setServerip(String serverip) {
		this.serverip = serverip;
	}
	public String getTimestamp() {
		return Timestamp;
	}
	public void setTimestamp(String timestamp) {
		Timestamp = timestamp;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserip() {
		return userip;
	}
	public void setUserip(String userip) {
		this.userip = userip;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	@Override
	public String toString() {
		return "UserEvent [id=" + id + ", serverip=" + serverip + ", Timestamp=" + Timestamp + ", event=" + event
				+ ", username=" + username + ", userip=" + userip + ", command=" + command + "]";
	}


    
 

 




    // getters and setters
}

