package com.sharobi.webpos.inv.model;

public class InvStockOutFB {
	private int id;
	private String itemCode;
	private String itemName;
	private double currentStock;
	private double itemQuantity;
	private String itemUnit;
	private double itemRate;
	private double totalPrice;
	private String towhom;
	private String menuCategoryName;
	private int metricUnitId;

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

	public double getCurrentStock() {
		return currentStock;
	}

	public void setCurrentStock(double currentStock) {
		this.currentStock = currentStock;
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

	public String getTowhom() {
		return towhom;
	}

	public void setTowhom(String towhom) {
		this.towhom = towhom;
	}
	
	public String getMenuCategoryName() {
		return menuCategoryName;
	}

	public void setMenuCategoryName(String menuCategoryName) {
		this.menuCategoryName = menuCategoryName;
	}

	@Override
	public String toString() {
		return "InvStockOutFB [id=" + id + ", itemCode=" + itemCode + ", itemName=" + itemName + ", currentStock=" + currentStock + ", itemQuantity=" + itemQuantity + ", itemUnit=" + itemUnit + ", itemRate=" + itemRate + ", totalPrice=" + totalPrice + ", towhom=" + towhom + ", menuCategoryName=" + menuCategoryName + ", metricUnitId=" + metricUnitId + "]";
	}

}
