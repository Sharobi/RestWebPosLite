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
public class SpecialNoteListContainer implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<MenuItemNotes> menuItemNotes = null;
	private int itemId;
	private int storeId;
	
	public List<MenuItemNotes> getMenuItemNotes() {
		return menuItemNotes;
	}
	public void setMenuItemNotes(List<MenuItemNotes> menuItemNotes) {
		this.menuItemNotes = menuItemNotes;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	
}
