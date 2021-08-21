/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class Discount implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int orderId;
	private int storeId;
	private Double customerDiscount;
	private Double discountPercentage;
	private String discountReason;
	private String isNonchargeable;
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
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
		return "Discount [orderId=" + orderId + ", storeId=" + storeId + ", customerDiscount=" + customerDiscount + ", discountPercentage=" + discountPercentage + ", discountReason=" + discountReason + ", isNonchargeable=" + isNonchargeable + "]";
	}
	
	/*@Override
	public String toString() {
		return "Discount [orderId=" + orderId + ", storeId=" + storeId
				+ ", customerDiscount=" + customerDiscount
				+ ", discountPercentage=" + discountPercentage + "]";
	}*/

	
}
