package com.sharobi.webpos.adm.model;

public class DailyExpenditureType{
	/**
	 * 
	 */
	
	private int id;
    private String typeName;
    private String activeFlag;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	@Override
	public String toString() {
		return "DailyExpenditureType [id=" + id + ", typeName=" + typeName + ", activeFlag=" + activeFlag + "]";
	}
	
	
}
