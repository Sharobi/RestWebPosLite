package com.sharobi.webpos.rm.model;

import java.io.Serializable;

public class FgCloseChild implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private int itemId;
	private int fgClseId;
	private double stockInQuantity;
	private double saleOutQuantity;
	private double edpQuantity;
	private double currentStock;
	private double waste;
	private double consume;
	private double reStockIn;
	private double variance;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String approved;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getConsume() {
		return consume;
	}

	public void setConsume(double consume) {
		this.consume = consume;
	}

	public double getVariance() {
		return variance;
	}

	public void setVariance(double variance) {
		this.variance = variance;
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

	public double getCurrentStock() {
		return currentStock;
	}

	public void setCurrentStock(double currentStock) {
		this.currentStock = currentStock;
	}

	public double getWaste() {
		return waste;
	}

	public void setWaste(double waste) {
		this.waste = waste;
	}

	public double getReStockIn() {
		return reStockIn;
	}

	public void setReStockIn(double reStockIn) {
		this.reStockIn = reStockIn;
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

	public double getEdpQuantity() {
		return edpQuantity;
	}

	public void setEdpQuantity(double edpQuantity) {
		this.edpQuantity = edpQuantity;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public int getFgClseId() {
		return fgClseId;
	}

	public void setFgClseId(int fgClseId) {
		this.fgClseId = fgClseId;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	@Override
	public String toString() {
		return "FgCloseChild [id=" + id + ", storeId=" + storeId + ", itemId=" + itemId + ", fgClseId=" + fgClseId + ", stockInQuantity=" + stockInQuantity + ", saleOutQuantity=" + saleOutQuantity + ", edpQuantity=" + edpQuantity + ", currentStock=" + currentStock + ", waste=" + waste + ", consume=" + consume + ", reStockIn=" + reStockIn + ", variance=" + variance + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", approved=" + approved + "]";
	}
	
	

}
