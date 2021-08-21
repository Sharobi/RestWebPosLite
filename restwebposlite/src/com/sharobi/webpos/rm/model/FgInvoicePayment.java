package com.sharobi.webpos.rm.model;

public class FgInvoicePayment {
	private int id;
	private int fgStockInId;
	private String fgStockInDate;
	private int vendorId;
	private int storeId;
	private double billAmount;
	private double paidAmount;
	private double amountToPay;
	private double creditLimit;
	private String deleteFlag;
	private String isReturn;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private double returnAmount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFgStockInId() {
		return fgStockInId;
	}
	public void setFgStockInId(int fgStockInId) {
		this.fgStockInId = fgStockInId;
	}
	public String getFgStockInDate() {
		return fgStockInDate;
	}
	public void setFgStockInDate(String fgStockInDate) {
		this.fgStockInDate = fgStockInDate;
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
	public double getBillAmount() {
		return billAmount;
	}
	public void setBillAmount(double billAmount) {
		this.billAmount = billAmount;
	}
	public double getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(double paidAmount) {
		this.paidAmount = paidAmount;
	}
	public double getAmountToPay() {
		return amountToPay;
	}
	public void setAmountToPay(double amountToPay) {
		this.amountToPay = amountToPay;
	}
	public double getCreditLimit() {
		return creditLimit;
	}
	public void setCreditLimit(double creditLimit) {
		this.creditLimit = creditLimit;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getIsReturn() {
		return isReturn;
	}
	public void setIsReturn(String isReturn) {
		this.isReturn = isReturn;
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
	public double getReturnAmount() {
		return returnAmount;
	}
	public void setReturnAmount(double returnAmount) {
		this.returnAmount = returnAmount;
	}
	@Override
	public String toString() {
		return "FgInvoicePayment [id=" + id + ", fgStockInId=" + fgStockInId + ", fgStockInDate=" + fgStockInDate
				+ ", vendorId=" + vendorId + ", storeId=" + storeId + ", billAmount=" + billAmount + ", paidAmount="
				+ paidAmount + ", amountToPay=" + amountToPay + ", creditLimit=" + creditLimit + ", deleteFlag="
				+ deleteFlag + ", isReturn=" + isReturn + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", returnAmount=" + returnAmount + "]";
	}
	
}
