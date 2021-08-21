package com.sharobi.webpos.adm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class SalesReturn implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private Date date;
	private String userId;
	private int storeId;
	private int orderId;
	private String customerName;
	private String customerContact;
	private String deliveryAddress;
	private String deliveryPersonName;
	private String waiterName;
	private int storeCustId;
	private ReturnTypes returnTypes;
	private Double itemTotal;
	private Double disPer;
	private Double disAmt;
	private Double serviceCharge;
	private Double serviceChargeRate;
	private Double vatAmt;
	private Double serviceTaxAmt;
	private Double netAmt;
	private String approved;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String isAdjusted;
	private List<SalesReturnItem> salesReturnItems;
	private String remark;
	private String orderNo;
	/*private String returnStatus; // 24.6.2019*/
	
	
	//for accounts
	private String qs;
	private int duties_ledger_id;
	private int round_ledger_id;
	private int sale_ledger_id;
	private int discount_ledger_id;
	private int debitor_ledger_id;
	private int debitor_cash_ledger_id;
	private int card_ledger_id;
	private String is_account;
	private int service_charge_ledger_id;
	private double grossAmt;
	private double discAmt;
	private double taxVatAmt;
	private double serviceChargeAmt;
	
	
	
	
	
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
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerContact() {
		return customerContact;
	}
	public void setCustomerContact(String customerContact) {
		this.customerContact = customerContact;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public String getDeliveryPersonName() {
		return deliveryPersonName;
	}
	public void setDeliveryPersonName(String deliveryPersonName) {
		this.deliveryPersonName = deliveryPersonName;
	}
	public String getWaiterName() {
		return waiterName;
	}
	public void setWaiterName(String waiterName) {
		this.waiterName = waiterName;
	}
	public int getStoreCustId() {
		return storeCustId;
	}
	public void setStoreCustId(int storeCustId) {
		this.storeCustId = storeCustId;
	}
	public ReturnTypes getReturnTypes() {
		return returnTypes;
	}
	public void setReturnTypes(ReturnTypes returnTypes) {
		this.returnTypes = returnTypes;
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
	public Double getServiceCharge() {
		return serviceCharge;
	}
	public void setServiceCharge(Double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}
	public Double getServiceChargeRate() {
		return serviceChargeRate;
	}
	public void setServiceChargeRate(Double serviceChargeRate) {
		this.serviceChargeRate = serviceChargeRate;
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
	public Double getNetAmt() {
		return netAmt;
	}
	public void setNetAmt(Double netAmt) {
		this.netAmt = netAmt;
	}
	public String getApproved() {
		return approved;
	}
	public void setApproved(String approved) {
		this.approved = approved;
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
	public String getIsAdjusted() {
		return isAdjusted;
	}
	public void setIsAdjusted(String isAdjusted) {
		this.isAdjusted = isAdjusted;
	}
	public List<SalesReturnItem> getSalesReturnItems() {
		return salesReturnItems;
	}
	public void setSalesReturnItems(List<SalesReturnItem> salesReturnItems) {
		this.salesReturnItems = salesReturnItems;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	

	public String getQs() {
		return qs;
	}
	public void setQs(String qs) {
		this.qs = qs;
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
	public int getSale_ledger_id() {
		return sale_ledger_id;
	}
	public void setSale_ledger_id(int sale_ledger_id) {
		this.sale_ledger_id = sale_ledger_id;
	}
	public int getDiscount_ledger_id() {
		return discount_ledger_id;
	}
	public void setDiscount_ledger_id(int discount_ledger_id) {
		this.discount_ledger_id = discount_ledger_id;
	}
	public int getDebitor_ledger_id() {
		return debitor_ledger_id;
	}
	public void setDebitor_ledger_id(int debitor_ledger_id) {
		this.debitor_ledger_id = debitor_ledger_id;
	}
	public int getDebitor_cash_ledger_id() {
		return debitor_cash_ledger_id;
	}
	public void setDebitor_cash_ledger_id(int debitor_cash_ledger_id) {
		this.debitor_cash_ledger_id = debitor_cash_ledger_id;
	}
	public int getCard_ledger_id() {
		return card_ledger_id;
	}
	public void setCard_ledger_id(int card_ledger_id) {
		this.card_ledger_id = card_ledger_id;
	}
	public String getIs_account() {
		return is_account;
	}
	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}
	public int getService_charge_ledger_id() {
		return service_charge_ledger_id;
	}
	public void setService_charge_ledger_id(int service_charge_ledger_id) {
		this.service_charge_ledger_id = service_charge_ledger_id;
	}
	public double getGrossAmt() {
		return grossAmt;
	}
	public void setGrossAmt(double grossAmt) {
		this.grossAmt = grossAmt;
	}
	public double getDiscAmt() {
		return discAmt;
	}
	public void setDiscAmt(double discAmt) {
		this.discAmt = discAmt;
	}
	public double getTaxVatAmt() {
		return taxVatAmt;
	}
	public void setTaxVatAmt(double taxVatAmt) {
		this.taxVatAmt = taxVatAmt;
	}
	public double getServiceChargeAmt() {
		return serviceChargeAmt;
	}
	public void setServiceChargeAmt(double serviceChargeAmt) {
		this.serviceChargeAmt = serviceChargeAmt;
	}
	
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	@Override
	public String toString() {
		return "SalesReturn [id=" + id + ", date=" + date + ", userId=" + userId + ", storeId=" + storeId + ", orderId="
				+ orderId + ", customerName=" + customerName + ", customerContact=" + customerContact
				+ ", deliveryAddress=" + deliveryAddress + ", deliveryPersonName=" + deliveryPersonName
				+ ", waiterName=" + waiterName + ", storeCustId=" + storeCustId + ", returnTypes=" + returnTypes
				+ ", itemTotal=" + itemTotal + ", disPer=" + disPer + ", disAmt=" + disAmt + ", serviceCharge="
				+ serviceCharge + ", serviceChargeRate=" + serviceChargeRate + ", vatAmt=" + vatAmt + ", serviceTaxAmt="
				+ serviceTaxAmt + ", netAmt=" + netAmt + ", approved=" + approved + ", deleteFlag=" + deleteFlag
				+ ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + ", isAdjusted=" + isAdjusted + ", salesReturnItems="
				+ salesReturnItems + ", remark=" + remark + ", orderNo=" + orderNo + ", qs=" + qs
				+ ", duties_ledger_id=" + duties_ledger_id + ", round_ledger_id=" + round_ledger_id
				+ ", sale_ledger_id=" + sale_ledger_id + ", discount_ledger_id=" + discount_ledger_id
				+ ", debitor_ledger_id=" + debitor_ledger_id + ", debitor_cash_ledger_id=" + debitor_cash_ledger_id
				+ ", card_ledger_id=" + card_ledger_id + ", is_account=" + is_account + ", service_charge_ledger_id="
				+ service_charge_ledger_id + ", grossAmt=" + grossAmt + ", discAmt=" + discAmt + ", taxVatAmt="
				+ taxVatAmt + ", serviceChargeAmt=" + serviceChargeAmt + "]";
	}
	
	
	
	
	

}
