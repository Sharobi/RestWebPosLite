package com.sharobi.webpos.inv.model;


public class InventoryPurchaseOrderItems {
	private int id;
	private double rate;
	private int vendorId;
	private int storeId;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private double itemQuantity;
	private double itemTotalPrice;
	private String vendorName;
	private String oldStock = "Not Available";
	private double requiredQuantity;
	private double shippingCharge;
	private String approveFlag = "Y";
	private int unitId;
	private String unitName;
	private InventoryItems inventoryItems;
	private InventoryPurchaseOrder inventoryPurchaseOrder;
	
	private int estimateDailyProdId;// new added dated 26th April 2018
	//newly added for accounting 26.04.2018
	private String isTaxExclusive;
	private Double taxRate;
	private Double taxAmt;
	private Double totalAmt;
	//newly added for accounting 2.05.2018
		private MetricUnit metricUnit;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public int getVendorId() {
		return vendorId;
	}

	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
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

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public double getItemTotalPrice() {
		return itemTotalPrice;
	}

	public void setItemTotalPrice(double itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getOldStock() {
		return oldStock;
	}

	public void setOldStock(String oldStock) {
		this.oldStock = oldStock;
	}

	public double getRequiredQuantity() {
		return requiredQuantity;
	}

	public void setRequiredQuantity(double requiredQuantity) {
		this.requiredQuantity = requiredQuantity;
	}

	public double getShippingCharge() {
		return shippingCharge;
	}

	public void setShippingCharge(double shippingCharge) {
		this.shippingCharge = shippingCharge;
	}

	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}

	public InventoryPurchaseOrder getInventoryPurchaseOrder() {
		return inventoryPurchaseOrder;
	}

	public void setInventoryPurchaseOrder(InventoryPurchaseOrder inventoryPurchaseOrder) {
		this.inventoryPurchaseOrder = inventoryPurchaseOrder;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
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

	public int getEstimateDailyProdId() {
		return estimateDailyProdId;
	}

	public void setEstimateDailyProdId(int estimateDailyProdId) {
		this.estimateDailyProdId = estimateDailyProdId;
	}

	public String getIsTaxExclusive() {
		return isTaxExclusive;
	}

	public void setIsTaxExclusive(String isTaxExclusive) {
		this.isTaxExclusive = isTaxExclusive;
	}

	public Double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(Double taxRate) {
		this.taxRate = taxRate;
	}

	public Double getTaxAmt() {
		return taxAmt;
	}

	public void setTaxAmt(Double taxAmt) {
		this.taxAmt = taxAmt;
	}

	public Double getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(Double totalAmt) {
		this.totalAmt = totalAmt;
	}

	public MetricUnit getMetricUnit() {
		return metricUnit;
	}

	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}

	@Override
	public String toString() {
		return "InventoryPurchaseOrderItems [id=" + id + ", rate=" + rate + ", vendorId=" + vendorId + ", storeId="
				+ storeId + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", itemQuantity=" + itemQuantity
				+ ", itemTotalPrice=" + itemTotalPrice + ", vendorName=" + vendorName + ", oldStock=" + oldStock
				+ ", requiredQuantity=" + requiredQuantity + ", shippingCharge=" + shippingCharge + ", approveFlag="
				+ approveFlag + ", unitId=" + unitId + ", unitName=" + unitName + ", inventoryItems=" + inventoryItems
				+ ", inventoryPurchaseOrder=" + inventoryPurchaseOrder + ", estimateDailyProdId=" + estimateDailyProdId
				+ ", isTaxExclusive=" + isTaxExclusive + ", taxRate=" + taxRate + ", taxAmt=" + taxAmt + ", totalAmt="
				+ totalAmt + ", metricUnit=" + metricUnit + "]";
	}

	
	

	
}
