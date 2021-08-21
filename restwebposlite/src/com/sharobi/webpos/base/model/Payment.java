/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class Payment implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private double amount;
	private double paidAmount;
	private double amountToPay;
	private double tenderAmount;
	private double changeAmt;
	private String cardLastFourDigits;
	private String remarks;
	private String paymentMode;
	private int storeId;
	private String source;
	private String createdBy;
	private String creationDate;
	private Order orderPayment;
	private Double customerDiscount;
	private Double discountPercentage;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
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
	public double getTenderAmount() {
		return tenderAmount;
	}
	public void setTenderAmount(double tenderAmount) {
		this.tenderAmount = tenderAmount;
	}
	public double getChangeAmt() {
		return changeAmt;
	}
	public void setChangeAmt(double changeAmt) {
		this.changeAmt = changeAmt;
	}
	public String getCardLastFourDigits() {
		return cardLastFourDigits;
	}
	public void setCardLastFourDigits(String cardLastFourDigits) {
		this.cardLastFourDigits = cardLastFourDigits;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	public Order getOrderPayment() {
		return orderPayment;
	}
	public void setOrderPayment(Order orderPayment) {
		this.orderPayment = orderPayment;
	}
	
	public Double getCustomerDiscount() {
		return customerDiscount;
	}
	public void setCustomerDiscount(Double customerDiscount) {
		this.customerDiscount = customerDiscount;
	}
	
	public Double getDiscountPercentage() {
		return discountPercentage;
	}
	public void setDiscountPercentage(Double discountPercentage) {
		this.discountPercentage = discountPercentage;
	}
	@Override
	public String toString() {
		return "Payment [id=" + id + ", amount=" + amount + ", paidAmount="
				+ paidAmount + ", amountToPay=" + amountToPay
				+ ", tenderAmount=" + tenderAmount + ", changeAmt=" + changeAmt
				+ ", cardLastFourDigits=" + cardLastFourDigits + ", remarks="
				+ remarks + ", paymentMode=" + paymentMode + ", storeId="
				+ storeId + ", source=" + source + ", createdBy=" + createdBy
				+ ", creationDate=" + creationDate + ", orderPayment="
				+ orderPayment + ", customerDiscount=" + customerDiscount
				+ ", discountPercentage=" + discountPercentage + "]";
	}
	
	
}
