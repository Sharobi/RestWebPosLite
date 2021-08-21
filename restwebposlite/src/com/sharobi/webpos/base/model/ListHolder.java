package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author Manodip
 */
public class ListHolder implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private List<PaymentType> paymentTypes;
	private int size;
	public List<PaymentType> getPaymentTypes() {
		return paymentTypes;
	}
	public void setPaymentTypes(List<PaymentType> paymentTypes) {
		this.paymentTypes = paymentTypes;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	@Override
	public String toString() {
		return "ListHolder [paymentTypes=" + paymentTypes + ", size=" + size + "]";
	}

}
