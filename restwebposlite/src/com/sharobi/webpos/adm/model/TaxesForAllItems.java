/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class TaxesForAllItems implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int storeId;
	private String vatTaxText;
	private String serviceTaxText;
	private String discountText;
	private double vatAmt;
	private double serviceTaxAmt;
	private double discountValue;
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getVatTaxText() {
		return vatTaxText;
	}
	public void setVatTaxText(String vatTaxText) {
		this.vatTaxText = vatTaxText;
	}
	public String getServiceTaxText() {
		return serviceTaxText;
	}
	public void setServiceTaxText(String serviceTaxText) {
		this.serviceTaxText = serviceTaxText;
	}
	public String getDiscountText() {
		return discountText;
	}
	public void setDiscountText(String discountText) {
		this.discountText = discountText;
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
	public double getDiscountValue() {
		return discountValue;
	}
	public void setDiscountValue(double discountValue) {
		this.discountValue = discountValue;
	}
	@Override
	public String toString() {
		return "TaxesForAllItems [storeId=" + storeId + ", vatTaxText="
				+ vatTaxText + ", serviceTaxText=" + serviceTaxText
				+ ", discountText=" + discountText + ", vatAmt=" + vatAmt
				+ ", serviceTaxAmt=" + serviceTaxAmt + ", discountValue="
				+ discountValue + "]";
	}
	
	
	
}
