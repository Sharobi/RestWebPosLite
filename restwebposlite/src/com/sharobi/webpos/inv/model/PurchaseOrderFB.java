package com.sharobi.webpos.inv.model;

public class PurchaseOrderFB {
	private int id;
	private String itemCode;
	private String itemName;
	private String oldStock;
	private double requiredQuantity;
	private double itemQuantity;
	private String itemUnit;
	private double itemRate;
	private double shippingCharge;
	private double totalPrice;
	private int vendorId;
	private String vendorName;
	private String stockFlag = "N";
	private String approveFlag = "N";
	private int metricUnitId;

	public PurchaseOrderFB(	int id,
							String itemCode,
							String itemName,
							String oldStock,
							double requiredQuantity,
							double itemQuantity,
							String itemUnit,
							double itemRate,
							double shippingCharge,
							double totalPrice,
							int vendorId,
							String vendorName,
							String stockFlag,
							String approveFlag,
							int metricUnitId) {
		this.id = id;
		this.itemCode = itemCode;
		this.itemName = itemName;
		this.oldStock = oldStock;
		this.requiredQuantity = requiredQuantity;
		this.itemQuantity = itemQuantity;
		this.itemUnit = itemUnit;
		this.itemRate = itemRate;
		this.shippingCharge = shippingCharge;
		this.totalPrice = totalPrice;
		this.vendorId = vendorId;
		this.vendorName = vendorName;
		this.stockFlag = stockFlag;
		this.approveFlag = approveFlag;
		this.metricUnitId=metricUnitId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
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

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public String getItemUnit() {
		return itemUnit;
	}

	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}

	public double getItemRate() {
		return itemRate;
	}

	public void setItemRate(double itemRate) {
		this.itemRate = itemRate;
	}

	public double getShippingCharge() {
		return shippingCharge;
	}

	public void setShippingCharge(double shippingCharge) {
		this.shippingCharge = shippingCharge;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getVendorId() {
		return vendorId;
	}

	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getStockFlag() {
		return stockFlag;
	}

	public void setStockFlag(String stockFlag) {
		this.stockFlag = stockFlag;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}

	public int getMetricUnitId() {
		return metricUnitId;
	}

	public void setMetricUnitId(int metricUnitId) {
		this.metricUnitId = metricUnitId;
	}

	@Override
	public String toString() {
		return "PurchaseOrderFB [id=" + id + ", itemCode=" + itemCode + ", itemName=" + itemName + ", oldStock=" + oldStock + ", requiredQuantity=" + requiredQuantity + ", itemQuantity=" + itemQuantity + ", itemUnit=" + itemUnit + ", itemRate=" + itemRate + ", shippingCharge=" + shippingCharge + ", totalPrice=" + totalPrice + ", vendorId=" + vendorId + ", vendorName=" + vendorName + ", stockFlag=" + stockFlag + ", approveFlag=" + approveFlag + ", metricUnitId=" + metricUnitId + "]";
	}
	
}
