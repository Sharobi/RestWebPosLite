package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author Manodip
 */
public class PaymentType implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int id;
    private String paymentTypeName;
    private String statusFlag;
    private int storeId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPaymentTypeName() {
		return paymentTypeName;
	}
	public void setPaymentTypeName(String paymentTypeName) {
		this.paymentTypeName = paymentTypeName;
	}
	public String getStatusFlag() {
		return statusFlag;
	}
	public void setStatusFlag(String statusFlag) {
		this.statusFlag = statusFlag;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	@Override
	public String toString() {
		return "PaymentType [id=" + id + ", paymentTypeName=" + paymentTypeName + ", statusFlag=" + statusFlag + ", storeId=" + storeId + "]";
	}

}
