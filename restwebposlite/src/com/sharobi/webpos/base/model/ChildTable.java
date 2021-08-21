/**
 * 
 */
package com.sharobi.webpos.base.model;

/**
 * @author habib
 *
 */
public class ChildTable {
	
	String childTableNo;
	String parentTableNo;
	public String getChildTableNo() {
		return childTableNo;
	}
	public void setChildTableNo(String childTableNo) {
		this.childTableNo = childTableNo;
	}
	public String getParentTableNo() {
		return parentTableNo;
	}
	public void setParentTableNo(String parentTableNo) {
		this.parentTableNo = parentTableNo;
	}
	@Override
	public String toString() {
		return "ChildTable [childTableNo=" + childTableNo + ", parentTableNo="
				+ parentTableNo + "]";
	}

}
