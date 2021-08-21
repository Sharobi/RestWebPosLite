package com.sharobi.webpos.rm.model;

import java.io.Serializable;


public class FgSaleOutItemsChild implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int fgSaleOutId;
	private int storeId;
	private int itemId;
	private double stockInQuantity;
	private double saleOutQuantity;
	private double edpQuantity;
	private String currentStock;
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

	public int getFgSaleOutId() {
		return fgSaleOutId;
	}

	public void setFgSaleOutId(int fgSaleOutId) {
		this.fgSaleOutId = fgSaleOutId;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public double getStockInQuantity() {
		return stockInQuantity;
	}

	public void setStockInQuantity(double stockInQuantity) {
		this.stockInQuantity = stockInQuantity;
	}

	public double getSaleOutQuantity() {
		return saleOutQuantity;
	}

	public void setSaleOutQuantity(double saleOutQuantity) {
		this.saleOutQuantity = saleOutQuantity;
	}

	public String getCurrentStock() {
		return currentStock;
	}

	public void setCurrentStock(String currentStock) {
		this.currentStock = currentStock;
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

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public double getEdpQuantity() {
		return edpQuantity;
	}

	public void setEdpQuantity(double edpQuantity) {
		this.edpQuantity = edpQuantity;
	}

	@Override
	public String toString() {
		return "FgSaleOutItemsChild [id=" + id + ", fgSaleOutId=" + fgSaleOutId + ", storeId=" + storeId + ", itemId=" + itemId + ", stockInQuantity=" + stockInQuantity + ", saleOutQuantity=" + saleOutQuantity + ", edpQuantity=" + edpQuantity + ", currentStock=" + currentStock + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
	}

}
