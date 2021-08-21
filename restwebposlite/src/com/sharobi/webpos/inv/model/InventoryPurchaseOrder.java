package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryPurchaseOrder {
	private int id;
	private String date;
	private String time;
	private String userId;
	private double shippingCharge;
	private double totalPrice;
	private double totalQuantity;
	private int storeId;
	private String deleteFlag;
	private String poStatus;
	private String poBy;
	private String approvedBy;
	private String approved;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private List<InventoryPurchaseOrderItems> inventoryPurchaseOrderItems;
	
	//newly added for accounting 26.04.2018
		private int vendorId;
		private String vendorName;
		private double itemTotal;
		private double taxAmt;

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

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(double totalQuantity) {
		this.totalQuantity = totalQuantity;
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

	public String getPoStatus() {
		return poStatus;
	}

	public void setPoStatus(String poStatus) {
		this.poStatus = poStatus;
	}

	public String getPoBy() {
		return poBy;
	}

	public void setPoBy(String poBy) {
		this.poBy = poBy;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
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

	public List<InventoryPurchaseOrderItems> getInventoryPurchaseOrderItems() {
		return inventoryPurchaseOrderItems;
	}

	public void setInventoryPurchaseOrderItems(List<InventoryPurchaseOrderItems> inventoryPurchaseOrderItems) {
		this.inventoryPurchaseOrderItems = inventoryPurchaseOrderItems;
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

	public double getItemTotal() {
		return itemTotal;
	}

	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
	}

	public double getTaxAmt() {
		return taxAmt;
	}

	public void setTaxAmt(double taxAmt) {
		this.taxAmt = taxAmt;
	}

	@Override
	public String toString() {
		return "InventoryPurchaseOrder [id=" + id + ", date=" + date + ", time=" + time + ", userId=" + userId
				+ ", shippingCharge=" + shippingCharge + ", totalPrice=" + totalPrice + ", totalQuantity="
				+ totalQuantity + ", storeId=" + storeId + ", deleteFlag=" + deleteFlag + ", poStatus=" + poStatus
				+ ", poBy=" + poBy + ", approvedBy=" + approvedBy + ", approved=" + approved + ", createdBy="
				+ createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate="
				+ updatedDate + ", inventoryPurchaseOrderItems=" + inventoryPurchaseOrderItems + ", vendorId="
				+ vendorId + ", vendorName=" + vendorName + ", itemTotal=" + itemTotal + ", taxAmt=" + taxAmt + "]";
	}

	
}
