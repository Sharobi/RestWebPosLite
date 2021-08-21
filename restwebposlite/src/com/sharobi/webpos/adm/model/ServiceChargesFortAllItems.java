package com.sharobi.webpos.adm.model;

import java.io.Serializable;
public class ServiceChargesFortAllItems {
	
	
	private static final long serialVersionUID = 1L;
	 private int storeId;
	 private String orderTypeId;
	 private String orderTypeName;
	 private String orderTypeShortName;
	 private double scValue;
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getOrderTypeId() {
		return orderTypeId;
	}
	public void setOrderTypeId(String orderTypeId) {
		this.orderTypeId = orderTypeId;
	}
	public String getOrderTypeName() {
		return orderTypeName;
	}
	public void setOrderTypeName(String orderTypeName) {
		this.orderTypeName = orderTypeName;
	}
	public String getOrderTypeShortName() {
		return orderTypeShortName;
	}
	public void setOrderTypeShortName(String orderTypeShortName) {
		this.orderTypeShortName = orderTypeShortName;
	}
	public double getScValue() {
		return scValue;
	}
	public void setScValue(double scValue) {
		this.scValue = scValue;
	}
	@Override
	public String toString() {
		return "ServiceChargesFortAllItems [storeId=" + storeId
				+ ", orderTypeId=" + orderTypeId + ", orderTypeName="
				+ orderTypeName + ", orderTypeShortName=" + orderTypeShortName
				+ ", scValue=" + scValue + "]";
	}
	
	 
	
	
	

}
