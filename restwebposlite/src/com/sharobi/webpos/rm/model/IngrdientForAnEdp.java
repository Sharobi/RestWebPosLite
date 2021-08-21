package com.sharobi.webpos.rm.model;

import java.io.Serializable;


public class IngrdientForAnEdp implements Serializable {

	private static final long serialVersionUID = 1L;
	private int invTypeItemId;
	private Ingredient ingredient;
	private double totalQuantity;
	private double reqQuantity;

	public int getInvTypeItemId() {
		return invTypeItemId;
	}

	public void setInvTypeItemId(int invTypeItemId) {
		this.invTypeItemId = invTypeItemId;
	}

	public Ingredient getIngredient() {
		return ingredient;
	}

	public void setIngredient(Ingredient ingredient) {
		this.ingredient = ingredient;
	}

	public double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public double getReqQuantity() {
		return reqQuantity;
	}

	public void setReqQuantity(double reqQuantity) {
		this.reqQuantity = reqQuantity;
	}

	@Override
	public String toString() {
		return "IngrdientForAnEdp [invTypeItemId=" + invTypeItemId + ", ingredient=" + ingredient + ", totalQuantity=" + totalQuantity + ", reqQuantity=" + reqQuantity + "]";
	}

}