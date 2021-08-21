package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.Date;

public class RawCloseChild implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private Date date;
	private int rawClseId;
	private int storeId;
	private int itemId;
	private double stockInQuantity;
	private int unitId;
	private double stockOutQuantity;
	private double calculatedStock;
	private double physicalStock;
	private double waste;
	private double consume;
	private double varience;
	private String frmDate;
	private double toDate;
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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public double getStockInQuantity() {
		return stockInQuantity;
	}

	public void setStockInQuantity(double stockInQuantity) {
		this.stockInQuantity = stockInQuantity;
	}

	public double getStockOutQuantity() {
		return stockOutQuantity;
	}

	public void setStockOutQuantity(double stockOutQuantity) {
		this.stockOutQuantity = stockOutQuantity;
	}

	public double getCalculatedStock() {
		return calculatedStock;
	}

	public void setCalculatedStock(double calculatedStock) {
		this.calculatedStock = calculatedStock;
	}

	public double getPhysicalStock() {
		return physicalStock;
	}

	public void setPhysicalStock(double physicalStock) {
		this.physicalStock = physicalStock;
	}

	public double getWaste() {
		return waste;
	}

	public void setWaste(double waste) {
		this.waste = waste;
	}

	public double getConsume() {
		return consume;
	}

	public void setConsume(double consume) {
		this.consume = consume;
	}

	public double getVarience() {
		return varience;
	}

	public void setVarience(double varience) {
		this.varience = varience;
	}

	public String getFrmDate() {
		return frmDate;
	}

	public void setFrmDate(String frmDate) {
		this.frmDate = frmDate;
	}

	public double getToDate() {
		return toDate;
	}

	public void setToDate(double toDate) {
		this.toDate = toDate;
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

	public int getRawClseId() {
		return rawClseId;
	}

	public void setRawClseId(int rawClseId) {
		this.rawClseId = rawClseId;
	}

	public int getUnitId() {
		return unitId;
	}

	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	@Override
	public String toString() {
		return "RawCloseChild [id=" + id + ", date=" + date + ", rawClseId=" + rawClseId + ", storeId=" + storeId + ", itemId=" + itemId + ", stockInQuantity=" + stockInQuantity + ", unitId=" + unitId + ", stockOutQuantity=" + stockOutQuantity + ", calculatedStock=" + calculatedStock + ", physicalStock=" + physicalStock + ", waste=" + waste + ", consume=" + consume + ", varience=" + varience + ", frmDate=" + frmDate + ", toDate=" + toDate + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", approved=" + approved + "]";
	}

	
}
