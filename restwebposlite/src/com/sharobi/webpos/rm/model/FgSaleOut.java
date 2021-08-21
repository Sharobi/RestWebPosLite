package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class FgSaleOut implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private int storeId;
	private Date date;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String dateText;
	private List<FgSaleOutItemsChild> fgSaleOutItemsChilds;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
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

	public List<FgSaleOutItemsChild> getFgSaleOutItemsChilds() {
		return fgSaleOutItemsChilds;
	}

	public void setFgSaleOutItemsChilds(
			List<FgSaleOutItemsChild> fgSaleOutItemsChilds) {
		this.fgSaleOutItemsChilds = fgSaleOutItemsChilds;
	}

	public String getDateText() {
		return dateText;
	}

	public void setDateText(String dateText) {
		this.dateText = dateText;
	}

	@Override
	public String toString() {
		return "FgSaleOut [id=" + id + ", storeId=" + storeId + ", date=" + date + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", dateText=" + dateText + ", fgSaleOutItemsChilds=" + fgSaleOutItemsChilds + "]";
	}


	
}
