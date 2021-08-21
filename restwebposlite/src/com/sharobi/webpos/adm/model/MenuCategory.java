/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author habib
 *
 */
public class MenuCategory implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String menuCategoryName;
	private String categoryId;
	private int storeId;
	private String deleteFlag;
	private String type;
	private String bgColor;
	private String directCat;
	private List<MenuCategory> menucategory;
	private List<MenuItems> items;
	private String parentCatId;  
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMenuCategoryName() {
		return menuCategoryName;
	}
	public void setMenuCategoryName(String menuCategoryName) {
		this.menuCategoryName = menuCategoryName;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBgColor() {
		return bgColor;
	}
	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}
	public List<MenuCategory> getMenucategory() {
		return menucategory;
	}
	public void setMenucategory(List<MenuCategory> menucategory) {
		this.menucategory = menucategory;
	}
	public List<MenuItems> getItems() {
		return items;
	}
	public void setItems(List<MenuItems> items) {
		this.items = items;
	}
	
	public String getDirectCat() {
		return directCat;
	}
	public void setDirectCat(String directCat) {
		this.directCat = directCat;
	}
	
	public String getParentCatId() {
		return parentCatId;
	}
	public void setParentCatId(String parentCatId) {
		this.parentCatId = parentCatId;
	}
	@Override
	public String toString() {
		return "MenuCategory [id=" + id + ", menuCategoryName=" + menuCategoryName + ", categoryId=" + categoryId + ", storeId=" + storeId + ", deleteFlag=" + deleteFlag + ", type=" + type + ", bgColor=" + bgColor + ", directCat=" + directCat + ", menucategory=" + menucategory + ", items=" + items + ", parentCatId=" + parentCatId + "]";
	}	
}

