/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;



/**
 * @author habib
 *
 */
public class InventoryItem implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */

	private int id;
	private InvType inventoryType;
	private String code;
	private String name;
	private double quantity;
	private String unit;
	private double rate;
	private String barcode;
	private int vendorId;
	private int storeId;
	private int metricUnitId;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private double shippingCharge;
	private double dailyRequirement;
	private String tax;
	
	// new added 20th April 2018
	private double taxRate;
	private String vendorName;
	private String isTaxExclusive;
	
	
	
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InvType getInventoryType() {
		return inventoryType;
	}
	public void setInventoryType(InvType inventoryType) {
		this.inventoryType = inventoryType;
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
	public int getMetricUnitId() {
		return metricUnitId;
	}
	public void setMetricUnitId(int metricUnitId) {
		this.metricUnitId = metricUnitId;
	}
	
	public double getTaxRate() {
		return taxRate;
	}
	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public String getIsTaxExclusive() {
		return isTaxExclusive;
	}
	public void setIsTaxExclusive(String isTaxExclusive) {
		this.isTaxExclusive = isTaxExclusive;
	}
	/*@Override
	public String toString() {
		return "InventoryItem [id=" + id + ", inventoryType=" + inventoryType + ", code=" + code + ", name=" + name + ", quantity=" + quantity + ", unit=" + unit + ", rate=" + rate + ", barcode=" + barcode + ", vendorId=" + vendorId + ", storeId=" + storeId + ", metricUnitId=" + metricUnitId + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", shippingCharge=" + shippingCharge + ", dailyRequirement=" + dailyRequirement + ", tax=" + tax + "]";
	}*/
	@Override
	public String toString() {
		return "InventoryItem [id=" + id + ", inventoryType=" + inventoryType + ", code=" + code + ", name=" + name
				+ ", quantity=" + quantity + ", unit=" + unit + ", rate=" + rate + ", barcode=" + barcode
				+ ", vendorId=" + vendorId + ", storeId=" + storeId + ", metricUnitId=" + metricUnitId + ", deleteFlag="
				+ deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", shippingCharge=" + shippingCharge + ", dailyRequirement="
				+ dailyRequirement + ", tax=" + tax + ", taxRate=" + taxRate + ", vendorName=" + vendorName
				+ ", isTaxExclusive=" + isTaxExclusive + "]";
	}
	
	
}
