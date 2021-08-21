package com.sharobi.webpos.rm.model;

import java.io.Serializable;

public class UnitConversion implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private MetricUnit metricUnit1;
	private Double toUnitAmount;
	private MetricUnit metricUnit;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;

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

	

	public MetricUnit getMetricUnit1() {
		return metricUnit1;
	}

	public void setMetricUnit1(MetricUnit metricUnit1) {
		this.metricUnit1 = metricUnit1;
	}

	public MetricUnit getMetricUnit() {
		return metricUnit;
	}

	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}

	public Double getToUnitAmount() {
		return toUnitAmount;
	}

	public void setToUnitAmount(Double toUnitAmount) {
		this.toUnitAmount = toUnitAmount;
	}

	@Override
	public String toString() {
		return "UnitConversion [id=" + id + ", storeId=" + storeId + ", metricUnit1=" + metricUnit1 + ", toUnitAmount=" + toUnitAmount + ", metricUnit=" + metricUnit + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
	}

	

}