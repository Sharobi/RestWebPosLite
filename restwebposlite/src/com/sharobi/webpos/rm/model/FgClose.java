package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public class FgClose implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private Date date;
	private String approved;
	private String approvedBy;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String dateText;
	private List<FgCloseChild> fgCloseChilds;

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

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
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

	public String getDateText() {
		return dateText;
	}

	public void setDateText(String dateText) {
		this.dateText = dateText;
	}

	public List<FgCloseChild> getFgCloseChilds() {
		return fgCloseChilds;
	}

	public void setFgCloseChilds(List<FgCloseChild> fgCloseChilds) {
		this.fgCloseChilds = fgCloseChilds;
	}

	@Override
	public String toString() {
		return "FgClose [id=" + id + ", storeId=" + storeId + ", date=" + date + ", approved=" + approved + ", approvedBy=" + approvedBy + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", dateText=" + dateText + ", fgCloseChilds=" + fgCloseChilds + "]";
	}

}
