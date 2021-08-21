/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class OrderType implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String orderTypeName;
	private String statusFlag;
	private int storeId;
	private String ordertypeShortName;
	private Double serviceChargeValue;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderTypeName() {
		return orderTypeName;
	}
	public void setOrderTypeName(String orderTypeName) {
		this.orderTypeName = orderTypeName;
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
	public String getOrdertypeShortName() {
		return ordertypeShortName;
	}
	public void setOrdertypeShortName(String ordertypeShortName) {
		this.ordertypeShortName = ordertypeShortName;
	}
	
	public Double getServiceChargeValue() {
		return serviceChargeValue;
	}
	public void setServiceChargeValue(Double serviceChargeValue) {
		this.serviceChargeValue = serviceChargeValue;
	}
	@Override
	public String toString() {
		return "OrderType [id=" + id + ", orderTypeName=" + orderTypeName
				+ ", statusFlag=" + statusFlag + ", storeId=" + storeId
				+ ", ordertypeShortName=" + ordertypeShortName
				+ ", serviceChargeValue=" + serviceChargeValue + "]";
	}

	

}
