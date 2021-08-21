package com.sharobi.webpos.login.model;

public class KeyBean {
	private static final long serialVersionUID = 1L;

	private int id;
	private String license_key = "";
	private String username;
	private String product_id;
	private String user_id;
	private String store_id;
	private String no_of_users;
	private String versions;
	private String from_date;
	private String to_date;
	private String no_of_month;
	private String mac_id = "";
	private String email_id;
	private String delete_flag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String status;
	private String storeName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLicense_key() {
		return license_key;
	}
	public void setLicense_key(String license_key) {
		this.license_key = license_key;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getNo_of_users() {
		return no_of_users;
	}
	public void setNo_of_users(String no_of_users) {
		this.no_of_users = no_of_users;
	}
	public String getVersions() {
		return versions;
	}
	public void setVersions(String versions) {
		this.versions = versions;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public String getNo_of_month() {
		return no_of_month;
	}
	public void setNo_of_month(String no_of_month) {
		this.no_of_month = no_of_month;
	}
	public String getMac_id() {
		return mac_id;
	}
	public void setMac_id(String mac_id) {
		this.mac_id = mac_id;
	}
	public String getEmail_id() {
		return email_id;
	}
	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}
	public String getDelete_flag() {
		return delete_flag;
	}
	public void setDelete_flag(String delete_flag) {
		this.delete_flag = delete_flag;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public String getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	@Override
	public String toString() {
		return "KeyBean [id=" + id + ", license_key=" + license_key + ", username=" + username + ", product_id=" + product_id + ", user_id=" + user_id + ", store_id=" + store_id + ", no_of_users=" + no_of_users + ", versions=" + versions + ", from_date=" + from_date + ", to_date=" + to_date + ", no_of_month=" + no_of_month + ", mac_id=" + mac_id + ", email_id=" + email_id + ", delete_flag=" + delete_flag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", status=" + status + ", storeName=" + storeName + "]";
	}
	
}
