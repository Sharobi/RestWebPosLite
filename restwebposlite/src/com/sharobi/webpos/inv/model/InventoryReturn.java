package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryReturn {

	private int id;
	private String date;
	private String userId;
	private int storeId;
	private int vendorId;
	private int edpId;
	private String billNo;
	private String billDate;
	private Double itemTotal;
	private Double disPer;
	private Double disAmt;
	private Double taxAmt;
	private Double roundOffAmt;
	private Double netAmt;
	private Double miscCharge;
	private String approved;
	private String vendorName;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private int returnTypeId;
	private List<InventoryReturnItem> inventoryReturnItems;
	private double totGrossAmt;


	/*
	 * account
	 */
	private int duties_ledger_id;
	private int round_ledger_id;
	private int purchase_ledger_id;
	private int discount_ledger_id;
	private int credior_ledger_id;
	private int missllenous_ledger_id;
	private String qs;
    private String is_account;

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
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
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
	public Double getTaxAmt() {
		return taxAmt;
	}
	public void setTaxAmt(Double taxAmt) {
		this.taxAmt = taxAmt;
	}
	public Double getRoundOffAmt() {
		return roundOffAmt;
	}
	public void setRoundOffAmt(Double roundOffAmt) {
		this.roundOffAmt = roundOffAmt;
	}
	public Double getNetAmt() {
		return netAmt;
	}
	public void setNetAmt(Double netAmt) {
		this.netAmt = netAmt;
	}
	public Double getMiscCharge() {
		return miscCharge;
	}
	public void setMiscCharge(Double miscCharge) {
		this.miscCharge = miscCharge;
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
	public List<InventoryReturnItem> getInventoryReturnItems() {
		return inventoryReturnItems;
	}
	public void setInventoryReturnItems(List<InventoryReturnItem> inventoryReturnItems) {
		this.inventoryReturnItems = inventoryReturnItems;
	}

	public int getReturnTypeId() {
		return returnTypeId;
	}
	public void setReturnTypeId(int returnTypeId) {
		this.returnTypeId = returnTypeId;
	}

	public double getTotGrossAmt() {
		return totGrossAmt;
	}
	public void setTotGrossAmt(double totGrossAmt) {
		this.totGrossAmt = totGrossAmt;
	}


	public int getDuties_ledger_id() {
		return duties_ledger_id;
	}
	public void setDuties_ledger_id(int duties_ledger_id) {
		this.duties_ledger_id = duties_ledger_id;
	}
	public int getRound_ledger_id() {
		return round_ledger_id;
	}
	public void setRound_ledger_id(int round_ledger_id) {
		this.round_ledger_id = round_ledger_id;
	}
	public int getPurchase_ledger_id() {
		return purchase_ledger_id;
	}
	public void setPurchase_ledger_id(int purchase_ledger_id) {
		this.purchase_ledger_id = purchase_ledger_id;
	}
	public int getDiscount_ledger_id() {
		return discount_ledger_id;
	}
	public void setDiscount_ledger_id(int discount_ledger_id) {
		this.discount_ledger_id = discount_ledger_id;
	}
	public int getCredior_ledger_id() {
		return credior_ledger_id;
	}
	public void setCredior_ledger_id(int credior_ledger_id) {
		this.credior_ledger_id = credior_ledger_id;
	}
	public int getMissllenous_ledger_id() {
		return missllenous_ledger_id;
	}
	public void setMissllenous_ledger_id(int missllenous_ledger_id) {
		this.missllenous_ledger_id = missllenous_ledger_id;
	}
	public String getQs() {
		return qs;
	}
	public void setQs(String qs) {
		this.qs = qs;
	}
	public String getIs_account() {
		return is_account;
	}
	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}
	@Override
	public String toString() {
		return "InventoryReturn [id=" + id + ", date=" + date + ", userId=" + userId + ", storeId=" + storeId
				+ ", vendorId=" + vendorId + ", edpId=" + edpId + ", billNo=" + billNo + ", billDate=" + billDate
				+ ", itemTotal=" + itemTotal + ", disPer=" + disPer + ", disAmt=" + disAmt + ", taxAmt=" + taxAmt
				+ ", roundOffAmt=" + roundOffAmt + ", netAmt=" + netAmt + ", miscCharge=" + miscCharge + ", approved="
				+ approved + ", vendorName=" + vendorName + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy
				+ ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
				+ ", returnTypeId=" + returnTypeId + ", inventoryReturnItems=" + inventoryReturnItems + ", totGrossAmt="
				+ totGrossAmt + ", duties_ledger_id=" + duties_ledger_id + ", round_ledger_id=" + round_ledger_id
				+ ", purchase_ledger_id=" + purchase_ledger_id + ", discount_ledger_id=" + discount_ledger_id
				+ ", credior_ledger_id=" + credior_ledger_id + ", missllenous_ledger_id=" + missllenous_ledger_id
				+ ", qs=" + qs + ", is_account=" + is_account + "]";
	}




}
