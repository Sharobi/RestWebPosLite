package com.sharobi.webpos.inv.model;

public class StockOutMenuCategory {
	private int menuId;
	private String menuCategoryName;
	private String bgColor;

	public int getId() {
		return menuId;
	}

	public void setId(int menuId) {
		this.menuId = menuId;
	}

	public String getMenuCategoryName() {
		return menuCategoryName;
	}

	public void setMenuCategoryName(String menuCategoryName) {
		this.menuCategoryName = menuCategoryName;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}

	@Override
	public String toString() {
		return "StockOutMenuCategory [menuId=" + menuId + ", menuCategoryName=" + menuCategoryName + ", bgColor=" + bgColor + "]";
	}
}
