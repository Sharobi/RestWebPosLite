/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class Bill implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private Double billAmount;
	private Double grossAmt;
	private int storeId;
	private Double totalDiscount;
	private Double customerDiscount;
	private Double roundOffAmt;
	private Double discountPercentage;
	
	// new added
	
	private Double serviceTaxAmt;
	private Double vatAmt;
	private Double subTotalAmt;
	private String discountReason;
	private String isNonchargeable;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Double getBillAmount() {
		return billAmount;
	}
	public void setBillAmount(Double billAmount) {
		this.billAmount = billAmount;
	}
	
	public Double getGrossAmt() {
		return grossAmt;
	}
	public void setGrossAmt(Double grossAmt) {
		this.grossAmt = grossAmt;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public Double getTotalDiscount() {
		return totalDiscount;
	}
	public void setTotalDiscount(Double totalDiscount) {
		this.totalDiscount = totalDiscount;
	}
	public Double getCustomerDiscount() {
		return customerDiscount;
	}
	public void setCustomerDiscount(Double customerDiscount) {
		this.customerDiscount = customerDiscount;
	}
	
	public Double getRoundOffAmt() {
		return roundOffAmt;
	}
	public void setRoundOffAmt(Double roundOffAmt) {
		this.roundOffAmt = roundOffAmt;
	}
	public Double getDiscountPercentage() {
		return discountPercentage;
	}
	public void setDiscountPercentage(Double discountPercentage) {
		this.discountPercentage = discountPercentage;
	}
	public Double getServiceTaxAmt() {
		return serviceTaxAmt;
	}
	public void setServiceTaxAmt(Double serviceTaxAmt) {
		this.serviceTaxAmt = serviceTaxAmt;
	}
	public Double getVatAmt() {
		return vatAmt;
	}
	public void setVatAmt(Double vatAmt) {
		this.vatAmt = vatAmt;
	}
	public Double getSubTotalAmt() {
		return subTotalAmt;
	}
	public void setSubTotalAmt(Double subTotalAmt) {
		this.subTotalAmt = subTotalAmt;
	}
	public String getDiscountReason() {
		return discountReason;
	}
	public void setDiscountReason(String discountReason) {
		this.discountReason = discountReason;
	}
	public String getIsNonchargeable() {
		return isNonchargeable;
	}
	public void setIsNonchargeable(String isNonchargeable) {
		this.isNonchargeable = isNonchargeable;
	}
	@Override
	public String toString() {
		return "Bill [id=" + id + ", billAmount=" + billAmount + ", grossAmt=" + grossAmt + ", storeId=" + storeId
				+ ", totalDiscount=" + totalDiscount + ", customerDiscount=" + customerDiscount + ", roundOffAmt="
				+ roundOffAmt + ", discountPercentage=" + discountPercentage + ", serviceTaxAmt=" + serviceTaxAmt
				+ ", vatAmt=" + vatAmt + ", subTotalAmt=" + subTotalAmt + ", discountReason=" + discountReason
				+ ", isNonchargeable=" + isNonchargeable + "]";
	}
	
	

}
