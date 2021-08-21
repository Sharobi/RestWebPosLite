/**
 * 
 */
package com.sharobi.webpos.login.model;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * @author habib
 *
 */
public class User {
	
	@NotEmpty
	private String userName;
	@NotEmpty
	private String password;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "User [userName=" + userName + ", password=****]";
	}
	
	

}
