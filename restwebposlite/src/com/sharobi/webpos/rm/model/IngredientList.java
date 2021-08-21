package com.sharobi.webpos.rm.model;

import java.io.Serializable;
import java.util.List;


public class IngredientList implements Serializable {

	private static final long serialVersionUID = 1L;
	private List<Ingredient> ingredients = null;

	public List<Ingredient> getIngredients() {
		return ingredients;
	}

	public void setIngredients(List<Ingredient> ingredients) {
		this.ingredients = ingredients;
	}

	@Override
	public String toString() {
		return "IngredientList [ingredients=" + ingredients + "]";
	}

}