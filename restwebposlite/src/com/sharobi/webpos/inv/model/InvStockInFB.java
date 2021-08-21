package com.sharobi.webpos.inv.model;

public class InvStockInFB {
	private int id;
	private String itemCode;
	private String itemName;
	private int currentStock;
	private double itemQuantity;
	private String itemUnit;
	private double itemRate;
	private double totalPrice;
	private String poNo;
	private String approveFlag;
	private double tax;
	private double taxAmount;
	private double amountWithoutTax;
	private int metricUnitId;

	public InvStockInFB(int id,
						String itemCode,
						String itemName,
						int currentStock,
						double itemQuantity,
						String itemUnit,
						double itemRate,
						double totalPrice,
						String poNo,
						String approveFlag,
						double tax,
						double taxAmount,
						double amountWithoutTax,
						int metricUnitId) {
		this.id = id;
		this.itemCode = itemCode;
		this.itemName = itemName;
		this.currentStock = currentStock;
		this.itemQuantity = itemQuantity;
		this.itemUnit = itemUnit;
		this.itemRate = itemRate;
		this.totalPrice = totalPrice;
		this.poNo = poNo;
		this.approveFlag = approveFlag;
		this.tax=tax;
		this.taxAmount=taxAmount;
		this.amountWithoutTax=amountWithoutTax;
		this.metricUnitId=metricUnitId;
	}

	public int getMetricUnitId() {
		return metricUnitId;
	}

	public void setMetricUnitId(int metricUnitId) {
		this.metricUnitId = metricUnitId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCurrentStock() {
		return currentStock;
	}

	public void setCurrentStock(int currentStock) {
		this.currentStock = currentStock;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public String getItemUnit() {
		return itemUnit;
	}

	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}

	public double getItemRate() {
		return itemRate;
	}

	public void setItemRate(double itemRate) {
		this.itemRate = itemRate;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPoNo() {
		return poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}
	
	public double getTax() {
		return tax;
	}

	public void setTax(double tax) {
		this.tax = tax;
	}

	public double getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(double taxAmount) {
		this.taxAmount = taxAmount;
	}

	public double getAmountWithoutTax() {
		return amountWithoutTax;
	}

	public void setAmountWithoutTax(double amountWithoutTax) {
		this.amountWithoutTax = amountWithoutTax;
	}

	@Override
	public String toString() {
		return "InvStockInFB [id=" + id + ", itemCode=" + itemCode + ", itemName=" + itemName + ", currentStock=" + currentStock + ", itemQuantity=" + itemQuantity + ", itemUnit=" + itemUnit + ", itemRate=" + itemRate + ", totalPrice=" + totalPrice + ", poNo=" + poNo + ", approveFlag=" + approveFlag + ", tax=" + tax + ", taxAmount=" + taxAmount + ", amountWithoutTax=" + amountWithoutTax + ", metricUnitId=" + metricUnitId + "]";
	}

	
}
