/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
/*This bean class is used only for edit table in table management,due to bad practice of web service*/
public class TableMaster implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String tableNo;
	private String tableDescription;
	private int seatingCapacity;
	private String status;
	private int storeId;
	private Short availableForOnlineBbooking;
	private String styleId;
	private String deleteFlag;
	private String multiOrder;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	public Short getAvailableForOnlineBbooking() {
		return availableForOnlineBbooking;
	}
	public void setAvailableForOnlineBbooking(Short availableForOnlineBbooking) {
		this.availableForOnlineBbooking = availableForOnlineBbooking;
	}
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	
	public String getMultiOrder() {
		return multiOrder;
	}
	public void setMultiOrder(String multiOrder) {
		this.multiOrder = multiOrder;
	}
	@Override
	public String toString() {
		return "TableMaster [id=" + id + ", tableNo=" + tableNo
				+ ", tableDescription=" + tableDescription
				+ ", seatingCapacity=" + seatingCapacity + ", status=" + status
				+ ", storeId=" + storeId + ", availableForOnlineBbooking="
				+ availableForOnlineBbooking + ", styleId=" + styleId
				+ ", deleteFlag=" + deleteFlag + ", multiOrder=" + multiOrder
				+ "]";
	}
	
	

}
