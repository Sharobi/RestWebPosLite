package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import com.sharobi.webpos.base.model.MenuItem;


public class EstimateDailyProdItem implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private int estimateDailyProdId;
	private MenuItem menuItem;
	private Double oldStock;
	private int edProdAmount;
	private String minDuantity;
	private String requiredQuantity;
	private String edpStatus;
	private double costAmount;
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

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public int getEdProdAmount() {
		return edProdAmount;
	}

	public void setEdProdAmount(int edProdAmount) {
		this.edProdAmount = edProdAmount;
	}

	public String getMinDuantity() {
		return minDuantity;
	}

	public void setMinDuantity(String minDuantity) {
		this.minDuantity = minDuantity;
	}

	public String getRequiredQuantity() {
		return requiredQuantity;
	}

	public void setRequiredQuantity(String requiredQuantity) {
		this.requiredQuantity = requiredQuantity;
	}

	public double getCostAmount() {
		return costAmount;
	}

	public void setCostAmount(double costAmount) {
		this.costAmount = costAmount;
	}

	public int getEstimateDailyProdId() {
		return estimateDailyProdId;
	}

	public void setEstimateDailyProdId(int estimateDailyProdId) {
		this.estimateDailyProdId = estimateDailyProdId;
	}

	public MenuItem getMenuItem() {
		return menuItem;
	}

	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}

	public Double getOldStock() {
		return oldStock;
	}

	public void setOldStock(Double oldStock) {
		this.oldStock = oldStock;
	}

	public String getEdpStatus() {
		return edpStatus;
	}

	public void setEdpStatus(String edpStatus) {
		this.edpStatus = edpStatus;
	}

	@Override
	public String toString() {
		return "EstimateDailyProdItem [id=" + id + ", storeId=" + storeId + ", estimateDailyProdId=" + estimateDailyProdId + ", menuItem=" + menuItem + ", oldStock=" + oldStock + ", edProdAmount=" + edProdAmount + ", minDuantity=" + minDuantity + ", requiredQuantity=" + requiredQuantity + ", edpStatus=" + edpStatus + ", costAmount=" + costAmount + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
	}
	
	

}
