package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class FgStockIn implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private int edpId;
	private int storeId;
	private Date date;
	private int estimatedItems;
	private int currentItems;
	private String approved;
	private String approvedBy;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private List<FgStockInItemsChild> fgStockInItemsChilds;
	private String stockInType; // new added for Simple Item Stock in
	
	// new added 17.6.2019
	private int vendorId;
	private String vendorName;
	private String billNo;
	private String billDate;
	private double itemTotal;
	private double discPer;
	private double discAmt;
	private double vatAmt;
	private double serviceTaxAmt;
	private Double roundOffAmt;
	private double totalPrice;
	
	public int getEdpId() {
		return edpId;
	}

	public void setEdpId(int edpId) {
		this.edpId = edpId;
	}

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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getEstimatedItems() {
		return estimatedItems;
	}

	public void setEstimatedItems(int estimatedItems) {
		this.estimatedItems = estimatedItems;
	}

	public int getCurrentItems() {
		return currentItems;
	}

	public void setCurrentItems(int currentItems) {
		this.currentItems = currentItems;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
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

	public List<FgStockInItemsChild> getFgStockInItemsChilds() {
		return fgStockInItemsChilds;
	}

	public void setFgStockInItemsChilds(
			List<FgStockInItemsChild> fgStockInItemsChilds) {
		this.fgStockInItemsChilds = fgStockInItemsChilds;
	}

	
	public String getStockInType() {
		return stockInType;
	}

	public void setStockInType(String stockInType) {
		this.stockInType = stockInType;
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

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
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

	public double getVatAmt() {
		return vatAmt;
	}

	public void setVatAmt(double vatAmt) {
		this.vatAmt = vatAmt;
	}

	public double getServiceTaxAmt() {
		return serviceTaxAmt;
	}

	public void setServiceTaxAmt(double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}

	public Double getRoundOffAmt() {
		return roundOffAmt;
	}

	public void setRoundOffAmt(Double roundOffAmt) {
		this.roundOffAmt = roundOffAmt;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "FgStockIn [id=" + id + ", edpId=" + edpId + ", storeId=" + storeId + ", date=" + date
				+ ", estimatedItems=" + estimatedItems + ", currentItems=" + currentItems + ", approved=" + approved
				+ ", approvedBy=" + approvedBy + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy
				+ ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
				+ ", fgStockInItemsChilds=" + fgStockInItemsChilds + ", stockInType=" + stockInType + ", vendorId="
				+ vendorId + ", vendorName=" + vendorName + ", billNo=" + billNo + ", billDate=" + billDate
				+ ", itemTotal=" + itemTotal + ", discPer=" + discPer + ", discAmt=" + discAmt + ", vatAmt=" + vatAmt
				+ ", serviceTaxAmt=" + serviceTaxAmt + ", roundOffAmt=" + roundOffAmt + ", totalPrice=" + totalPrice
				+ "]";
	}

	


}
