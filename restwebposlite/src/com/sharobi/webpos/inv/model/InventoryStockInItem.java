package com.sharobi.webpos.inv.model;

public class InventoryStockInItem {
	private int id;
	private double itemQuantity;
	private double itemRate;
	private double itemTotalPrice;
	private int storeId;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String itemStatus;
	private String poId;
	private String poDate;
	private String approveFlag = "Y";
	private InventoryStockIn inventoryStockIn;
	private InventoryItems inventoryItems;
	private int unitId;
	private String unitName;
	private Double taxRate;
	private Double taxAmount;
	private Double itemGrossAmount;
	
	private Double edpQuantity;
	private Double currentStockInQuantityEdpWise;
	private MetricUnit metricUnit;
	
	//newly added for accounting 2.05.2018
		private String isTaxExclusive="Y";
		private double discPer;
		private double discAmt;
	
	
	
	public Double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(Double taxRate) {
		this.taxRate = taxRate;
	}

	public Double getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(Double taxAmount) {
		this.taxAmount = taxAmount;
	}

	public Double getItemGrossAmount() {
		return itemGrossAmount;
	}

	public void setItemGrossAmount(Double itemGrossAmount) {
		this.itemGrossAmount = itemGrossAmount;
	}

	

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

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

	public double getItemRate() {
		return itemRate;
	}

	public void setItemRate(double itemRate) {
		this.itemRate = itemRate;
	}

	public double getItemTotalPrice() {
		return itemTotalPrice;
	}

	public void setItemTotalPrice(double itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
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

	public String getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public String getPoId() {
		if (poId == "0") {
			poId = "Not Available";
		}
		return poId;
	}

	public void setPoId(String poId) {
		this.poId = poId;
	}

	public String getPoDate() {
		return poDate;
	}

	public void setPoDate(String poDate) {
		this.poDate = poDate;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}

	public InventoryStockIn getInventoryStockIn() {
		return inventoryStockIn;
	}

	public void setInventoryStockIn(InventoryStockIn inventoryStockIn) {
		this.inventoryStockIn = inventoryStockIn;
	}

	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}

	public int getUnitId() {
		return unitId;
	}

	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}

	public Double getEdpQuantity() {
		return edpQuantity;
	}

	public void setEdpQuantity(Double edpQuantity) {
		this.edpQuantity = edpQuantity;
	}

	public Double getCurrentStockInQuantityEdpWise() {
		return currentStockInQuantityEdpWise;
	}

	public void setCurrentStockInQuantityEdpWise(Double currentStockInQuantityEdpWise) {
		this.currentStockInQuantityEdpWise = currentStockInQuantityEdpWise;
	}

	public MetricUnit getMetricUnit() {
		return metricUnit;
	}

	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}

	public String getIsTaxExclusive() {
		return isTaxExclusive;
	}

	public void setIsTaxExclusive(String isTaxExclusive) {
		this.isTaxExclusive = isTaxExclusive;
	}

	public double getDiscPer() {
		return discPer;
	}

	public void setDiscPer(double discPer) {
		this.discPer = discPer;
	}

	public double getDiscAmt() {
		return discAmt;
	}

	public void setDiscAmt(double discAmt) {
		this.discAmt = discAmt;
	}

	@Override
	public String toString() {
		return "InventoryStockInItem [id=" + id + ", itemQuantity=" + itemQuantity + ", itemRate=" + itemRate
				+ ", itemTotalPrice=" + itemTotalPrice + ", storeId=" + storeId + ", deleteFlag=" + deleteFlag
				+ ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", itemStatus=" + itemStatus + ", poId=" + poId + ", poDate="
				+ poDate + ", approveFlag=" + approveFlag + ", inventoryStockIn=" + inventoryStockIn
				+ ", inventoryItems=" + inventoryItems + ", unitId=" + unitId + ", unitName=" + unitName + ", taxRate="
				+ taxRate + ", taxAmount=" + taxAmount + ", itemGrossAmount=" + itemGrossAmount + ", edpQuantity="
				+ edpQuantity + ", currentStockInQuantityEdpWise=" + currentStockInQuantityEdpWise + ", metricUnit="
				+ metricUnit + ", isTaxExclusive=" + isTaxExclusive + ", discPer=" + discPer + ", discAmt=" + discAmt
				+ "]";
	}

	

}
