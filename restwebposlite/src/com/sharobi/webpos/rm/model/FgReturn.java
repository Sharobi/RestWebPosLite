package com.sharobi.webpos.rm.model;

import java.util.Date;
import java.util.List;

public class FgReturn {
	private int id;
	private Date date;
	private int storeId;
	private int vendorId;
	private int returnTypeId;
	private int edpId;
	private String billNo;
	private String billDate;
	private Double itemTotal=0.0;
	private Double disPer=0.0;
	private Double disAmt=0.0;
	private Double vatAmt=0.0;
	private Double serviceTaxAmt=0.0;
	private Double roundOffAmt=0.0;
	private Double totalPrice=0.0;
	private String approved="N";
	private String vendorName;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private List<FgReturnItem> fgReturnItems;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public int getReturnTypeId() {
		return returnTypeId;
	}
	public void setReturnTypeId(int returnTypeId) {
		this.returnTypeId = returnTypeId;
	}
	public int getEdpId() {
		return edpId;
	}
	public void setEdpId(int edpId) {
		this.edpId = edpId;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public String getBillDate() {
		return billDate;
	}
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	public Double getItemTotal() {
		return itemTotal;
	}
	public void setItemTotal(Double itemTotal) {
		this.itemTotal = itemTotal;
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
	public Double getVatAmt() {
		return vatAmt;
	}
	public void setVatAmt(Double vatAmt) {
		this.vatAmt = vatAmt;
	}
	public Double getServiceTaxAmt() {
		return serviceTaxAmt;
	}
	public void setServiceTaxAmt(Double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}
	public Double getRoundOffAmt() {
		return roundOffAmt;
	}
	public void setRoundOffAmt(Double roundOffAmt) {
		this.roundOffAmt = roundOffAmt;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getApproved() {
		return approved;
	}
	public void setApproved(String approved) {
		this.approved = approved;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
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
	public List<FgReturnItem> getFgReturnItems() {
		return fgReturnItems;
	}
	public void setFgReturnItems(List<FgReturnItem> fgReturnItems) {
		this.fgReturnItems = fgReturnItems;
	}
	@Override
	public String toString() {
		return "FgReturn [id=" + id + ", date=" + date + ", storeId=" + storeId + ", vendorId=" + vendorId
				+ ", returnTypeId=" + returnTypeId + ", edpId=" + edpId + ", billNo=" + billNo + ", billDate="
				+ billDate + ", itemTotal=" + itemTotal + ", disPer=" + disPer + ", disAmt=" + disAmt + ", vatAmt="
				+ vatAmt + ", serviceTaxAmt=" + serviceTaxAmt + ", roundOffAmt=" + roundOffAmt + ", totalPrice="
				+ totalPrice + ", approved=" + approved + ", vendorName=" + vendorName + ", deleteFlag=" + deleteFlag
				+ ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", fgReturnItems=" + fgReturnItems + "]";
	}
	
}
