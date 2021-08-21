/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author habib
 *
 */
public class MenuItemTime implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private Date fromTime;
	private Date toTime;
	private int storeId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getFromTime() {
		return fromTime;
	}
	public void setFromTime(Date fromTime) {
		this.fromTime = fromTime;
	}
	public Date getToTime() {
		return toTime;
	}
	public void setToTime(Date toTime) {
		this.toTime = toTime;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	@Override
	public String toString() {
		return "MenuItemTime [id=" + id + ", fromTime=" + fromTime
				+ ", toTime=" + toTime + ", storeId=" + storeId + "]";
	}
	

}
