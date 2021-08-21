/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class PrintKotMaster implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private String printerIp;
	private int cuisineTypeId;
	private String name;
	private String kitchenLocation;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getPrinterIp() {
		return printerIp;
	}
	public void setPrinterIp(String printerIp) {
		this.printerIp = printerIp;
	}
	public int getCuisineTypeId() {
		return cuisineTypeId;
	}
	public void setCuisineTypeId(int cuisineTypeId) {
		this.cuisineTypeId = cuisineTypeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKitchenLocation() {
		return kitchenLocation;
	}
	public void setKitchenLocation(String kitchenLocation) {
		this.kitchenLocation = kitchenLocation;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public String getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}
	@Override
	public String toString() {
		return "PrintKotMaster [id=" + id + ", storeId=" + storeId
				+ ", printerIp=" + printerIp + ", cuisineTypeId="
				+ cuisineTypeId + ", name=" + name + ", kitchenLocation="
				+ kitchenLocation + ", deleteFlag=" + deleteFlag
				+ ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
				+ "]";
	}
	
	

}
