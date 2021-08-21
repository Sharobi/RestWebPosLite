package com.sharobi.webpos.inv.model;

import com.sharobi.webpos.adm.model.ReturnTypes;

public class InventoryReturnItem {
	private int id;
	private InventoryStockIn inventoryStockIn;
	private InventoryReturn inventoryReturn;
	private InventoryItems inventoryItems;
	private Double itemQuantity;
	private Double itemInvoiceQuantity;
	private Double itemTotalPrice;
	private Double itemRate;
	private Double itemInvoiceRate;
	private Double disPer;
	private Double disAmt;
	private String isTaxExclusive;
	private Double taxRate;
	private Double taxAmount;
	private Double itemGrossAmount;
	private int storeId;
	private int poId;
	private String poDate;
	private int unitId;
	private String billNo;
	private ReturnTypes returnTypes;

	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String remarks;
	private InventoryStockIn inventoryStckIn;
	private MetricUnit metricUnit;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InventoryStockIn getInventoryStockIn() {
		return inventoryStockIn;
	}
	public void setInventoryStockIn(InventoryStockIn inventoryStockIn) {
		this.inventoryStockIn = inventoryStockIn;
	}
	public InventoryReturn getInventoryReturn() {
		return inventoryReturn;
	}
	public void setInventoryReturn(InventoryReturn inventoryReturn) {
		this.inventoryReturn = inventoryReturn;
	}
	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}
	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}
	public Double getItemQuantity() {
		return itemQuantity;
	}
	public void setItemQuantity(Double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}
	public Double getItemTotalPrice() {
		return itemTotalPrice;
	}
	public void setItemTotalPrice(Double itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
	}
	public Double getItemRate() {
		return itemRate;
	}
	public void setItemRate(Double itemRate) {
		this.itemRate = itemRate;
	}
	public Double getItemInvoiceRate() {
		return itemInvoiceRate;
	}
	public void setItemInvoiceRate(Double itemInvoiceRate) {
		this.itemInvoiceRate = itemInvoiceRate;
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
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public int getPoId() {
		return poId;
	}
	public void setPoId(int poId) {
		this.poId = poId;
	}
	public String getPoDate() {
		return poDate;
	}
	public void setPoDate(String poDate) {
		this.poDate = poDate;
	}
	public int getUnitId() {
		return unitId;
	}
	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public ReturnTypes getReturnTypes() {
		return returnTypes;
	}
	public void setReturnTypes(ReturnTypes returnTypes) {
		this.returnTypes = returnTypes;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public InventoryStockIn getInventoryStckIn() {
		return inventoryStckIn;
	}
	public void setInventoryStckIn(InventoryStockIn inventoryStckIn) {
		this.inventoryStckIn = inventoryStckIn;
	}
	
	public Double getItemInvoiceQuantity() {
		return itemInvoiceQuantity;
	}
	public void setItemInvoiceQuantity(Double itemInvoiceQuantity) {
		this.itemInvoiceQuantity = itemInvoiceQuantity;
	}
	
	public MetricUnit getMetricUnit() {
		return metricUnit;
	}
	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}
	@Override
	public String toString() {
		return "InventoryReturnItem [id=" + id + ", inventoryStockIn=" + inventoryStockIn + ", inventoryReturn="
				+ inventoryReturn + ", inventoryItems=" + inventoryItems + ", itemQuantity=" + itemQuantity
				+ ", itemInvoiceQuantity=" + itemInvoiceQuantity + ", itemTotalPrice=" + itemTotalPrice + ", itemRate="
				+ itemRate + ", itemInvoiceRate=" + itemInvoiceRate + ", disPer=" + disPer + ", disAmt=" + disAmt
				+ ", isTaxExclusive=" + isTaxExclusive + ", taxRate=" + taxRate + ", taxAmount=" + taxAmount
				+ ", itemGrossAmount=" + itemGrossAmount + ", storeId=" + storeId + ", poId=" + poId + ", poDate="
				+ poDate + ", unitId=" + unitId + ", billNo=" + billNo + ", returnTypes=" + returnTypes
				+ ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", remarks=" + remarks
				+ ", inventoryStckIn=" + inventoryStckIn + ", metricUnit=" + metricUnit + "]";
	}
	
	
	
}
