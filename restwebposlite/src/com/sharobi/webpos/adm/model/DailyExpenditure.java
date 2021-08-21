package com.sharobi.webpos.adm.model;

import java.util.Date;

public class DailyExpenditure {
	private int id;
	private Double amount;
	private int storeId;
	private String particulars;
	//private int voucherId;
	private String voucherId;
	private String voucherDate;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	
	//new fields added in 19th Apr 2018
		private String vendorName;
		private Double taxRate;
		private Double taxAmt;
		private Double netAmt;
		
	// new field added in 18th May 2018
		private int expenditureTypeId;
		private String  expenditureTypeName;
	 
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getParticulars() {
		return particulars;
	}
	public void setParticulars(String particulars) {
		this.particulars = particulars;
	}
	
	
	
	public String getVoucherId() {
		return voucherId;
	}
	public void setVoucherId(String voucherId) {
		this.voucherId = voucherId;
	}
	public String getVoucherDate() {
		return voucherDate;
	}
	public void setVoucherDate(String voucherDate) {
		this.voucherDate = voucherDate;
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
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
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
	public Double getNetAmt() {
		return netAmt;
	}
	public void setNetAmt(Double netAmt) {
		this.netAmt = netAmt;
	}
	public int getExpenditureTypeId() {
		return expenditureTypeId;
	}
	public void setExpenditureTypeId(int expenditureTypeId) {
		this.expenditureTypeId = expenditureTypeId;
	}
	public String getExpenditureTypeName() {
		return expenditureTypeName;
	}
	public void setExpenditureTypeName(String expenditureTypeName) {
		this.expenditureTypeName = expenditureTypeName;
	}
	@Override
	public String toString() {
		return "DailyExpenditure [id=" + id + ", amount=" + amount + ", storeId=" + storeId + ", particulars="
				+ particulars + ", voucherId=" + voucherId + ", voucherDate=" + voucherDate + ", deleteFlag="
				+ deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", vendorName=" + vendorName + ", taxRate=" + taxRate + ", taxAmt="
				+ taxAmt + ", netAmt=" + netAmt + ", expenditureTypeId=" + expenditureTypeId + ", expenditureTypeName="
				+ expenditureTypeName + "]";
	}
	
	
	
		 
}
