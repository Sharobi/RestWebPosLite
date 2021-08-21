package com.sharobi.webpos.inv.model;

public class InventoryItems {
	private int id;
	private String code;
	private String name;
	//private int quantity;
	private double quantity; // changed 
	private String unit;
	//private float rate;
	private double rate; // changed
	private String barcode;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private int vendorId;
	private int storeId;
	private String vendorName;
	private double shippingCharge;
	//private int dailyRequirement;
	private double dailyRequirement; // changed
	private InventoryType inventoryType;
	private int metricUnitId;
	private String tax;
	private String stockAvailable;
	
	// New added 19th April 2018
	private String isTaxExclusive;
	private double taxRate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
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
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public double getShippingCharge() {
		return shippingCharge;
	}
	public void setShippingCharge(double shippingCharge) {
		this.shippingCharge = shippingCharge;
	}
	public double getDailyRequirement() {
		return dailyRequirement;
	}
	public void setDailyRequirement(double dailyRequirement) {
		this.dailyRequirement = dailyRequirement;
	}
	public InventoryType getInventoryType() {
		return inventoryType;
	}
	public void setInventoryType(InventoryType inventoryType) {
		this.inventoryType = inventoryType;
	}
	public int getMetricUnitId() {
		return metricUnitId;
	}
	public void setMetricUnitId(int metricUnitId) {
		this.metricUnitId = metricUnitId;
	}
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public String getStockAvailable() {
		return stockAvailable;
	}
	public void setStockAvailable(String stockAvailable) {
		this.stockAvailable = stockAvailable;
	}
	public String getIsTaxExclusive() {
		return isTaxExclusive;
	}
	public void setIsTaxExclusive(String isTaxExclusive) {
		this.isTaxExclusive = isTaxExclusive;
	}
	public double getTaxRate() {
		return taxRate;
	}
	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}
	@Override
	public String toString() {
		return "InventoryItems [id=" + id + ", code=" + code + ", name=" + name + ", quantity=" + quantity + ", unit="
				+ unit + ", rate=" + rate + ", barcode=" + barcode + ", deleteFlag=" + deleteFlag + ", createdBy="
				+ createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate="
				+ updatedDate + ", vendorId=" + vendorId + ", storeId=" + storeId + ", vendorName=" + vendorName
				+ ", shippingCharge=" + shippingCharge + ", dailyRequirement=" + dailyRequirement + ", inventoryType="
				+ inventoryType + ", metricUnitId=" + metricUnitId + ", tax=" + tax + ", stockAvailable="
				+ stockAvailable + ", isTaxExclusive=" + isTaxExclusive + ", taxRate=" + taxRate + "]";
	}
	
}
