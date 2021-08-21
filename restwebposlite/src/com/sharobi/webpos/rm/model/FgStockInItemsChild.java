package com.sharobi.webpos.rm.model;

import java.io.Serializable;

import com.sharobi.webpos.base.model.MenuItem;


public class FgStockInItemsChild implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private MenuItem menuItem;
	//private int fgStockInId;
	private FgStockIn fgStockInId;
	private String fgStatus;
	private double edProdAmount;
	private double stockInQuantity;
	private double oldStockInQuantity;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	
	// new added 17.6.2019
	private String unit;
	private double itemRate=0.0;
	private double itemTotal=0.0;
	private double discPer=0.0;
	private double discAmt=0.0;
	private double vatRate=0.0;
	private double vatAmt=0.0;
	private double serviceTaxRate=0.0;
	private double serviceTaxAmt=0.0;
	private double totalPrice=0.0;
	private double curStock=0.0;
	private double prevretQty=0.0;
	
	private int stockId;
	private String stockDate;
	private int vndrId;
	private String vndrName;
	private String invNo;
	

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

	public String getFgStatus() {
		return fgStatus;
	}

	public void setFgStatus(String fgStatus) {
		this.fgStatus = fgStatus;
	}

	/*
	 * public double getEstimatedQuantity() { return estimatedQuantity; }
	 * 
	 * public void setEstimatedQuantity(double estimatedQuantity) {
	 * this.estimatedQuantity = estimatedQuantity; }
	 */

	public double getStockInQuantity() {
		return stockInQuantity;
	}

	public double getEdProdAmount() {
		return edProdAmount;
	}

	public void setEdProdAmount(double edProdAmount) {
		this.edProdAmount = edProdAmount;
	}

	public void setStockInQuantity(double stockInQuantity) {
		this.stockInQuantity = stockInQuantity;
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

	/*
	 * public int getItemId() { return itemId; }
	 * 
	 * public void setItemId(int itemId) { this.itemId = itemId; }
	 */

	
	public MenuItem getMenuItem() {
		return menuItem;
	}

	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}

	

	public double getOldStockInQuantity() {
		return oldStockInQuantity;
	}

	public void setOldStockInQuantity(double oldStockInQuantity) {
		this.oldStockInQuantity = oldStockInQuantity;
	}

	public FgStockIn getFgStockInId() {
		return fgStockInId;
	}

	public void setFgStockInId(FgStockIn fgStockInId) {
		this.fgStockInId = fgStockInId;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public double getItemRate() {
		return itemRate;
	}

	public void setItemRate(double itemRate) {
		this.itemRate = itemRate;
	}

	public double getItemTotal() {
		return itemTotal;
	}

	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
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

	public double getVatRate() {
		return vatRate;
	}

	public void setVatRate(double vatRate) {
		this.vatRate = vatRate;
	}

	public double getVatAmt() {
		return vatAmt;
	}

	public void setVatAmt(double vatAmt) {
		this.vatAmt = vatAmt;
	}

	public double getServiceTaxRate() {
		return serviceTaxRate;
	}

	public void setServiceTaxRate(double serviceTaxRate) {
		this.serviceTaxRate = serviceTaxRate;
	}

	public double getServiceTaxAmt() {
		return serviceTaxAmt;
	}

	public void setServiceTaxAmt(double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public double getCurStock() {
		return curStock;
	}

	public void setCurStock(double curStock) {
		this.curStock = curStock;
	}

	public double getPrevretQty() {
		return prevretQty;
	}

	public void setPrevretQty(double prevretQty) {
		this.prevretQty = prevretQty;
	}
	
	
	

	public int getStockId() {
		return stockId;
	}

	public void setStockId(int stockId) {
		this.stockId = stockId;
	}

	public String getStockDate() {
		return stockDate;
	}

	public void setStockDate(String stockDate) {
		this.stockDate = stockDate;
	}

	public int getVndrId() {
		return vndrId;
	}

	public void setVndrId(int vndrId) {
		this.vndrId = vndrId;
	}

	public String getVndrName() {
		return vndrName;
	}

	public void setVndrName(String vndrName) {
		this.vndrName = vndrName;
	}
	
	

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	@Override
	public String toString() {
		return "FgStockInItemsChild [id=" + id + ", storeId=" + storeId + ", menuItem=" + menuItem + ", fgStockInId="
				+ fgStockInId + ", fgStatus=" + fgStatus + ", edProdAmount=" + edProdAmount + ", stockInQuantity="
				+ stockInQuantity + ", oldStockInQuantity=" + oldStockInQuantity + ", deleteFlag=" + deleteFlag
				+ ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", unit=" + unit + ", itemRate=" + itemRate + ", itemTotal="
				+ itemTotal + ", discPer=" + discPer + ", discAmt=" + discAmt + ", vatRate=" + vatRate + ", vatAmt="
				+ vatAmt + ", serviceTaxRate=" + serviceTaxRate + ", serviceTaxAmt=" + serviceTaxAmt + ", totalPrice="
				+ totalPrice + ", curStock=" + curStock + ", prevretQty=" + prevretQty + ", stockId=" + stockId
				+ ", stockDate=" + stockDate + ", vndrId=" + vndrId + ", vndrName=" + vndrName + ", invNo=" + invNo
				+ "]";
	}

	
	

	

	

	

}
