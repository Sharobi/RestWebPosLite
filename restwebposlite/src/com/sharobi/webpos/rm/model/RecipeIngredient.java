package com.sharobi.webpos.rm.model;

import java.io.Serializable;

import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.inv.model.InventoryItems;



public class RecipeIngredient implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private MenuItem menuItem;
	private InventoryItems inventoryItems;
	private CookingUnit cookingUnit;
	private MetricUnit metricUnit;
	private double cookingAmount;
	private double metricAmount;
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

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public double getCookingAmount() {
		return cookingAmount;
	}

	public void setCookingAmount(double cookingAmount) {
		this.cookingAmount = cookingAmount;
	}

	public double getMetricAmount() {
		return metricAmount;
	}

	public void setMetricAmount(double metricAmount) {
		this.metricAmount = metricAmount;
	}

	public double getCostAmount() {
		return costAmount;
	}

	public void setCostAmount(double costAmount) {
		this.costAmount = costAmount;
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

	public MenuItem getMenuItem() {
		return menuItem;
	}

	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}

	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}

	public CookingUnit getCookingUnit() {
		return cookingUnit;
	}

	public void setCookingUnit(CookingUnit cookingUnit) {
		this.cookingUnit = cookingUnit;
	}

	public MetricUnit getMetricUnit() {
		return metricUnit;
	}

	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}

	@Override
	public String toString() {
		return "RecipeIngredient [id=" + id + ", storeId=" + storeId + ", menuItem=" + menuItem + ", inventoryItems=" + inventoryItems + ", cookingUnit=" + cookingUnit + ", metricUnit=" + metricUnit + ", cookingAmount=" + cookingAmount + ", metricAmount=" + metricAmount + ", costAmount=" + costAmount + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
	}

}
