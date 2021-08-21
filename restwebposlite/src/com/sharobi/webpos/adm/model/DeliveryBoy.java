package com.sharobi.webpos.adm.model;


import java.io.Serializable;


public class DeliveryBoy implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int id;
	private String name;
	private String address;
	private String phone_no;
	private String email;
	private String DOB;
	private String DOJ;
	private String uniqueId;
	private String store_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone_no() {
		return phone_no;
	}
	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	@Override
	public String toString() {
		return "DeliveryBoy [id=" + id + ", name=" + name + ", address="
				+ address + ", phone_no=" + phone_no + ", email=" + email
				+ ", DOB=" + DOB + ", DOJ=" + DOJ + ", uniqueId=" + uniqueId
				+ ", store_id=" + store_id + "]";
	}
}
