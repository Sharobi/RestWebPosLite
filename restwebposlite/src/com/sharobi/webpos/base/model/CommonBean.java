package com.sharobi.webpos.base.model;

import java.io.Serializable;
/**
 * @author Manodip
 */
public class CommonBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int orderId;
    private int storeId;
    private String billPrintReason;
    private String lang;
    
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

	public String getBillPrintReason() {
		return billPrintReason;
	}

	public void setBillPrintReason(String billPrintReason) {
		this.billPrintReason = billPrintReason;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	@Override
	public String toString() {
		return "CommonBean [orderId=" + orderId + ", storeId=" + storeId + ", billPrintReason=" + billPrintReason + ", lang=" + lang + "]";
	}
    
}
