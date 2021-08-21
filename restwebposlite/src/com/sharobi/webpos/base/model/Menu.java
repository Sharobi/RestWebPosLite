/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.List;



/**
 * @author habib
 *
 */
public class Menu implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String menuCategoryName;
	private Menu menutype;
	private List<Menu> menucategory;
	private List<MenuItem> items;
	//private String bgColor;
	private String categoryId;
	private int storeId;
	private String deleteFlag;
	private String type;
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
	public Menu getMenutype() {
		return menutype;
	}
	public void setMenutype(Menu menutype) {
		this.menutype = menutype;
	}
	public List<Menu> getMenucategory() {
		return menucategory;
	}
	public void setMenucategory(List<Menu> menucategory) {
		this.menucategory = menucategory;
	}
	public List<MenuItem> getItems() {
		return items;
	}
	public void setItems(List<MenuItem> items) {
		this.items = items;
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
	
	@Override
	public String toString() {
		return "Menu [id=" + id + ", menuCategoryName=" + menuCategoryName
				+ ", menutype=" + menutype + ", menucategory=" + menucategory
				+ ", items=" + items + ", categoryId=" + categoryId
				+ ", storeId=" + storeId + ", deleteFlag=" + deleteFlag
				+ ", type=" + type + "]";
	}
	
}
