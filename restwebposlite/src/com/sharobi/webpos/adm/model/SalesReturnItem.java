package com.sharobi.webpos.adm.model;

import java.io.Serializable;
import java.util.Date;

import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.inv.model.MetricUnit;


public class SalesReturnItem implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private SalesReturn salesReturn; //for joining
	private Date date;
	private MenuItem menuItem;
	private String barcode;
	private int storeId;
	private Double itemSoldQuantity;
	private Double itemReturnQuantity;
	private Double itemRate;
	private Double itemReturnRate;
	private Double itemPrice;
	private Double disPer;
	private Double disAmt;
	private Double vat;
	private Double vatAmt;
	private Double serviceTax;
	private Double serviceTaxAmt;
	private Double itemReturnPrice;
	private MetricUnit metricUnit;
	private ReturnTypes returnTypes;
	private String remarks;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String unitName;
	private int unitId;
	private int orderId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public SalesReturn getSalesReturn() {
		return salesReturn;
	}
	public void setSalesReturn(SalesReturn salesReturn) {
		this.salesReturn = salesReturn;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public MenuItem getMenuItem() {
		return menuItem;
	}
	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public Double getItemSoldQuantity() {
		return itemSoldQuantity;
	}
	public void setItemSoldQuantity(Double itemSoldQuantity) {
		this.itemSoldQuantity = itemSoldQuantity;
	}
	public Double getItemReturnQuantity() {
		return itemReturnQuantity;
	}
	public void setItemReturnQuantity(Double itemReturnQuantity) {
		this.itemReturnQuantity = itemReturnQuantity;
	}
	public Double getItemRate() {
		return itemRate;
	}
	public void setItemRate(Double itemRate) {
		this.itemRate = itemRate;
	}
	public Double getItemReturnRate() {
		return itemReturnRate;
	}
	public void setItemReturnRate(Double itemReturnRate) {
		this.itemReturnRate = itemReturnRate;
	}
	public Double getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(Double itemPrice) {
		this.itemPrice = itemPrice;
	}
	public Double getDisPer() {
		return disPer;
	}
	public void setDisPer(Double disPer) {
		this.disPer = disPer;
	}
	public Double getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(Double disAmt) {
		this.disAmt = disAmt;
	}
	public Double getVat() {
		return vat;
	}
	public void setVat(Double vat) {
		this.vat = vat;
	}
	public Double getVatAmt() {
		return vatAmt;
	}
	public void setVatAmt(Double vatAmt) {
		this.vatAmt = vatAmt;
	}
	public Double getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(Double serviceTax) {
		this.serviceTax = serviceTax;
	}
	public Double getServiceTaxAmt() {
		return serviceTaxAmt;
	}
	public void setServiceTaxAmt(Double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}
	public Double getItemReturnPrice() {
		return itemReturnPrice;
	}
	public void setItemReturnPrice(Double itemReturnPrice) {
		this.itemReturnPrice = itemReturnPrice;
	}
	public MetricUnit getMetricUnit() {
		return metricUnit;
	}
	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}
	public ReturnTypes getReturnTypes() {
		return returnTypes;
	}
	public void setReturnTypes(ReturnTypes returnTypes) {
		this.returnTypes = returnTypes;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	
	public int getUnitId() {
		return unitId;
	}
	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	@Override
	public String toString() {
		return "SalesReturnItem [id=" + id + ", salesReturn=" + salesReturn + ", date=" + date + ", menuItem="
				+ menuItem + ", barcode=" + barcode + ", storeId=" + storeId + ", itemSoldQuantity=" + itemSoldQuantity
				+ ", itemReturnQuantity=" + itemReturnQuantity + ", itemRate=" + itemRate + ", itemReturnRate="
				+ itemReturnRate + ", itemPrice=" + itemPrice + ", disPer=" + disPer + ", disAmt=" + disAmt + ", vat="
				+ vat + ", vatAmt=" + vatAmt + ", serviceTax=" + serviceTax + ", serviceTaxAmt=" + serviceTaxAmt
				+ ", itemReturnPrice=" + itemReturnPrice + ", metricUnit=" + metricUnit + ", returnTypes=" + returnTypes
				+ ", remarks=" + remarks + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate="
				+ createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", unitName=" + unitName
				+ ", unitId=" + unitId + ", orderId=" + orderId + "]";
	}
	
	

}
