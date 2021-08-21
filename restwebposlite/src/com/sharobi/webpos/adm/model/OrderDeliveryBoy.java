package com.sharobi.webpos.adm.model;

import java.io.Serializable;

public class OrderDeliveryBoy implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int orderId;
	private String deliveryPersonName;
	
	private String store_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getDeliveryPersonName() {
		return deliveryPersonName;
	}
	public void setDeliveryPersonName(String deliveryPersonName) {
		this.deliveryPersonName = deliveryPersonName;
	}
	/*public String getDeliveryPersonAddress() {
		return deliveryPersonAddress;
	}
	public void setDeliveryPersonAddress(String deliveryPersonAddress) {
		this.deliveryPersonAddress = deliveryPersonAddress;
	}
	public String getDeliveryPersonphone_no() {
		return deliveryPersonphone_no;
	}
	public void setDeliveryPersonphone_no(String deliveryPersonphone_no) {
		this.deliveryPersonphone_no = deliveryPersonphone_no;
	}
	public String getDeliveryPersonemail() {
		return deliveryPersonemail;
	}
	public void setDeliveryPersonemail(String deliveryPersonemail) {
		this.deliveryPersonemail = deliveryPersonemail;
	}
	public String getDOB() {
		return DOB;
	}
	public void setDOB(String dOB) {
		DOB = dOB;
	}
	public String getDOJ() {
		return DOJ;
	}
	public void setDOJ(String dOJ) {
		DOJ = dOJ;
	}
	public String getUniqueId() {
		return uniqueId;
	}
	public void setUniqueId(String uniqueId) {
		this.uniqueId = uniqueId;
	}*/
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	@Override
	public String toString() {
		return "OrderDeliveryBoy [id=" + id + ", orderId=" + orderId
				+ ", deliveryPersonName=" + deliveryPersonName + ", store_id="
				+ store_id + "]";
	}
	
	
	
	
}
