package com.sharobi.webpos.inv.model;

public class InventoryStockOutItems {
	private int id;
	private double itemQuantity;
	private int storeId;
	private double totalPrice;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String time;
	private String toWhom;
	private String approveFlag = "Y";
	private InventoryStockOut inventoryStockOut;
	private InventoryItems inventoryItems;
	private int unitId;
	private String unitName;
	private MetricUnit unit;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public double getTotalPrice() {
		double itemRate = getInventoryItems().getRate();
		double qty = getItemQuantity();
		totalPrice = itemRate * qty;
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
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

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}

	public String getToWhom() {
		return toWhom;
	}

	public void setToWhom(String toWhom) {
		this.toWhom = toWhom;
	}

	public InventoryStockOut getInventoryStockOut() {
		return inventoryStockOut;
	}

	public void setInventoryStockOut(InventoryStockOut inventoryStockOut) {
		this.inventoryStockOut = inventoryStockOut;
	}

	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}
	
	public MetricUnit getUnit() {
		return unit;
	}

	public void setUnit(MetricUnit unit) {
		this.unit = unit;
	}
	
	public int getUnitId() {
		return unitId;
	}

	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}

	
	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	@Override
	public String toString() {
		return "InventoryStockOutItems [id=" + id + ", itemQuantity=" + itemQuantity + ", storeId=" + storeId + ", totalPrice=" + totalPrice + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", time=" + time + ", toWhom=" + toWhom + ", approveFlag=" + approveFlag + ", inventoryStockOut=" + inventoryStockOut + ", inventoryItems=" + inventoryItems + ", unitId=" + unitId + ", unitName=" + unitName + ", unit=" + unit + "]";
	}

}
