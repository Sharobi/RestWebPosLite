package com.sharobi.webpos.inv.model;

public class InvStockInUpdateItem {
	private int itemId;
	private double itemQuantity;
	private double itemPrice;
	private double totalItemPrice;
	private String poNo;
	private String response;

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public double getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}

	public double getTotalItemPrice() {
		return totalItemPrice;
	}

	public void setTotalItemPrice(double totalItemPrice) {
		this.totalItemPrice = totalItemPrice;
	}

	public String getPoNo() {
		return poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}

	@Override
	public String toString() {
		return "InvStockInUpdateItem [itemId=" + itemId + ", itemQuantity=" + itemQuantity + ", itemPrice=" + itemPrice + ", totalItemPrice=" + totalItemPrice + ", poNo=" + poNo + ", response=" + response + "]";
	}
}
