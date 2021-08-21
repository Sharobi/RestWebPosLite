package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryStockOut {
	private int id;
	private String date;
	private String time;
	private String userId;
	private int storeId;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private List<InventoryStockOutItems> inventoryStockOutItems;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
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

	public List<InventoryStockOutItems> getInventoryStockOutItemList() {
		return inventoryStockOutItems;
	}

	public void setInventoryStockOutItemList(List<InventoryStockOutItems> inventoryStockOutItems) {
		this.inventoryStockOutItems = inventoryStockOutItems;
	}

	@Override
	public String toString() {
		return "InventoryStockOut [id=" + id + ", date=" + date + ", time=" + time + ", userId=" + userId + ", storeId=" + storeId + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", inventoryStockOutItems=" + inventoryStockOutItems + "]";
	}
}
