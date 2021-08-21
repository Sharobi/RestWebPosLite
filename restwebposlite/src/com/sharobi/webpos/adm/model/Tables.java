/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class Tables implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int tableId;
	private String tableNo;
	private String tableDescription;
	private int seatingCapacity;
	private String status;
	private String isBooked="N";
	private int storeId;
	private String multiOrder;
	public int getTableId() {
		return tableId;
	}
	public void setTableId(int tableId) {
		this.tableId = tableId;
	}
	public String getTableNo() {
		return tableNo;
	}
	public void setTableNo(String tableNo) {
		this.tableNo = tableNo;
	}
	public String getTableDescription() {
		return tableDescription;
	}
	public void setTableDescription(String tableDescription) {
		this.tableDescription = tableDescription;
	}
	public int getSeatingCapacity() {
		return seatingCapacity;
	}
	public void setSeatingCapacity(int seatingCapacity) {
		this.seatingCapacity = seatingCapacity;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsBooked() {
		return isBooked;
	}
	public void setIsBooked(String isBooked) {
		this.isBooked = isBooked;
	}
	
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	public String getMultiOrder() {
		return multiOrder;
	}
	public void setMultiOrder(String multiOrder) {
		this.multiOrder = multiOrder;
	}
	@Override
	public String toString() {
		return "Tables [tableId=" + tableId + ", tableNo=" + tableNo
				+ ", tableDescription=" + tableDescription
				+ ", seatingCapacity=" + seatingCapacity + ", status=" + status
				+ ", isBooked=" + isBooked + ", storeId=" + storeId
				+ ", multiOrder=" + multiOrder + "]";
	}
	

}
