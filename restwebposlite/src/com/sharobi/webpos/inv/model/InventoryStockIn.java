package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryStockIn {
	private int id;
	private String date;
	private String userId;
	private int storeId;
	private double totalQuantity;
	private double totalPrice;
	private double miscCharge;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String closed;
	private int vendorId;
	private String vendorName;
	private String billNo;
	private String billDate;
	private List<InventoryStockInItem> inventoryStockInItems;
    
	//newly added for accounting 2.05.2018

		private int poId;
		private double itemTotal;
		private double discPer;
		private double discAmt;
		private double taxAmt;
		private Double roundOffAmt;
		
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

	public double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public double getMiscCharge() {
		return miscCharge;
	}

	public void setMiscCharge(double miscCharge) {
		this.miscCharge = miscCharge;
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

	public String getClosed() {
		return closed;
	}

	public void setClosed(String closed) {
		this.closed = closed;
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

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public List<InventoryStockInItem> getInventoryStockInItems() {
		return inventoryStockInItems;
	}

	public void setInventoryStockInItems(List<InventoryStockInItem> inventoryStockInItems) {
		this.inventoryStockInItems = inventoryStockInItems;
	}
	
	

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
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

	public double getTaxAmt() {
		return taxAmt;
	}

	public void setTaxAmt(double taxAmt) {
		this.taxAmt = taxAmt;
	}

	public Double getRoundOffAmt() {
		return roundOffAmt;
	}

	public void setRoundOffAmt(Double roundOffAmt) {
		this.roundOffAmt = roundOffAmt;
	}

	@Override
	public String toString() {
		return "InventoryStockIn [id=" + id + ", date=" + date + ", userId=" + userId + ", storeId=" + storeId
				+ ", totalQuantity=" + totalQuantity + ", totalPrice=" + totalPrice + ", miscCharge=" + miscCharge
				+ ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", closed=" + closed + ", vendorId="
				+ vendorId + ", vendorName=" + vendorName + ", billNo=" + billNo + ", billDate=" + billDate
				+ ", inventoryStockInItems=" + inventoryStockInItems + ", poId=" + poId + ", itemTotal=" + itemTotal
				+ ", discPer=" + discPer + ", discAmt=" + discAmt + ", taxAmt=" + taxAmt + ", roundOffAmt="
				+ roundOffAmt + "]";
	}

	

	
}
