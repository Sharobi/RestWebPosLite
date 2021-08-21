package com.sharobi.webpos.login.model;

import java.io.Serializable;

public class PosModules implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
    private String moduleName;
    private int storeId;
    private int order;
    private String status;
    private String deleteFlag;
    private String createdBy;
    private String createdDate;
    private String updatedBy;
    private String updatedDate;
    private String isReport;
    private String admin;
    private String reportSize;
    private boolean present;
    private String modPresent;
    private String reportCode;        

    
    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getIsReport() {
		return isReport;
	}
	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getReportSize() {
		return reportSize;
	}
	public void setReportSize(String reportSize) {
		this.reportSize = reportSize;
	}
	public boolean isPresent() {
		return present;
	}
	public void setPresent(boolean present) {
		this.present = present;
	}
	public String getModPresent() {
		return modPresent;
	}
	public void setModPresent(String modPresent) {
		this.modPresent = modPresent;
	}
	public String getReportCode() {
		return reportCode;
	}
	public void setReportCode(String reportCode) {
		this.reportCode = reportCode;
	}
	@Override
	public String toString() {
		return "PosModules [id=" + id + ", moduleName=" + moduleName
				+ ", storeId=" + storeId + ", order=" + order + ", status="
				+ status + ", deleteFlag=" + deleteFlag + ", createdBy="
				+ createdBy + ", createdDate=" + createdDate + ", updatedBy="
				+ updatedBy + ", updatedDate=" + updatedDate + ", isReport="
				+ isReport + ", admin=" + admin + ", reportSize=" + reportSize
				+ ", present=" + present + ", modPresent=" + modPresent
				+ ", reportCode=" + reportCode + "]";
	}
	
}
