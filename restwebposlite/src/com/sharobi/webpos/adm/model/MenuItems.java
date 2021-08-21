/**
 * 
 */
package com.sharobi.webpos.adm.model;


import java.io.Serializable;

import com.sharobi.webpos.base.model.MenuItemTime;

/**
 * @author habib
 *
 */
public class MenuItems implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String description;
	private double price;
	private MenuCategory menucategory;
	private MenuItemTime itemtime;
	private String deleteFlag;
	private int storeId;
	private String veg = "N";
	private String promotionDesc = "";
	private int promotionValue;
	private String promotionFlag = "N";
	private String foodOption1;
	private String foodOption2;
	private String foodOptionFlag;
	private String beverages = "N";
	private String desert="N";
	private String spicy="N";
	private String houseSpecial="N";
	private double vat;
	private double serviceTax;
	private int menucatId;
	private String menucatName;
	private int submenucatId;
	private String submenucatName;
	private String code;
	private int dailyMinQty;
	private String unit;
	private String packaged;
	private String production;
	private int cookingTimeInMins;
	private String specialNote;
	private String printerList;
	private String spotDiscount;
	private String isKotPrint;
	private double purchasePrice=0.0; // new added 27.6.2019
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public MenuCategory getMenucategory() {
		return menucategory;
	}
	public void setMenucategory(MenuCategory menucategory) {
		this.menucategory = menucategory;
	}
	public MenuItemTime getItemtime() {
		return itemtime;
	}
	public void setItemtime(MenuItemTime itemtime) {
		this.itemtime = itemtime;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getVeg() {
		return veg;
	}
	public void setVeg(String veg) {
		this.veg = veg;
	}
	public String getPromotionDesc() {
		return promotionDesc;
	}
	public void setPromotionDesc(String promotionDesc) {
		this.promotionDesc = promotionDesc;
	}
	public int getPromotionValue() {
		return promotionValue;
	}
	public void setPromotionValue(int promotionValue) {
		this.promotionValue = promotionValue;
	}
	public String getPromotionFlag() {
		return promotionFlag;
	}
	public void setPromotionFlag(String promotionFlag) {
		this.promotionFlag = promotionFlag;
	}
	public String getFoodOption1() {
		return foodOption1;
	}
	public void setFoodOption1(String foodOption1) {
		this.foodOption1 = foodOption1;
	}
	public String getFoodOption2() {
		return foodOption2;
	}
	public void setFoodOption2(String foodOption2) {
		this.foodOption2 = foodOption2;
	}
	public String getFoodOptionFlag() {
		return foodOptionFlag;
	}
	public void setFoodOptionFlag(String foodOptionFlag) {
		this.foodOptionFlag = foodOptionFlag;
	}
	public String getBeverages() {
		return beverages;
	}
	public void setBeverages(String beverages) {
		this.beverages = beverages;
	}
	public String getDesert() {
		return desert;
	}
	public void setDesert(String desert) {
		this.desert = desert;
	}
	public String getSpicy() {
		return spicy;
	}
	public void setSpicy(String spicy) {
		this.spicy = spicy;
	}
	public String getHouseSpecial() {
		return houseSpecial;
	}
	public void setHouseSpecial(String houseSpecial) {
		this.houseSpecial = houseSpecial;
	}
	public double getVat() {
		return vat;
	}
	public void setVat(double vat) {
		this.vat = vat;
	}
	public double getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(double serviceTax) {
		this.serviceTax = serviceTax;
	}
	
	
	public int getMenucatId() {
		return menucatId;
	}
	public void setMenucatId(int menucatId) {
		this.menucatId = menucatId;
	}
	public String getMenucatName() {
		return menucatName;
	}
	public void setMenucatName(String menucatName) {
		this.menucatName = menucatName;
	}
	public int getSubmenucatId() {
		return submenucatId;
	}
	public void setSubmenucatId(int submenucatId) {
		this.submenucatId = submenucatId;
	}
	public String getSubmenucatName() {
		return submenucatName;
	}
	public void setSubmenucatName(String submenucatName) {
		this.submenucatName = submenucatName;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getDailyMinQty() {
		return dailyMinQty;
	}
	public void setDailyMinQty(int dailyMinQty) {
		this.dailyMinQty = dailyMinQty;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getPackaged() {
		return packaged;
	}
	public void setPackaged(String packaged) {
		this.packaged = packaged;
	}
	public String getProduction() {
		return production;
	}
	public void setProduction(String production) {
		this.production = production;
	}
	public int getCookingTimeInMins() {
		return cookingTimeInMins;
	}
	public void setCookingTimeInMins(int cookingTimeInMins) {
		this.cookingTimeInMins = cookingTimeInMins;
	}
	
	public String getSpecialNote() {
		return specialNote;
	}
	public void setSpecialNote(String specialNote) {
		this.specialNote = specialNote;
	}
	
	public String getPrinterList() {
		return printerList;
	}
	public void setPrinterList(String printerList) {
		this.printerList = printerList;
	}
	
	public String getSpotDiscount() {
		return spotDiscount;
	}
	public void setSpotDiscount(String spotDiscount) {
		this.spotDiscount = spotDiscount;
	}
	
	public double getPurchasePrice() {
		return purchasePrice;
	}
	public void setPurchasePrice(double purchasePrice) {
		this.purchasePrice = purchasePrice;
	}
	
	public String getIsKotPrint() {
		return isKotPrint;
	}
	public void setIsKotPrint(String isKotPrint) {
		this.isKotPrint = isKotPrint;
	}
	@Override
	public String toString() {
		return "MenuItems [id=" + id + ", name=" + name + ", description=" + description + ", price=" + price
				+ ", menucategory=" + menucategory + ", itemtime=" + itemtime + ", deleteFlag=" + deleteFlag
				+ ", storeId=" + storeId + ", veg=" + veg + ", promotionDesc=" + promotionDesc + ", promotionValue="
				+ promotionValue + ", promotionFlag=" + promotionFlag + ", foodOption1=" + foodOption1
				+ ", foodOption2=" + foodOption2 + ", foodOptionFlag=" + foodOptionFlag + ", beverages=" + beverages
				+ ", desert=" + desert + ", spicy=" + spicy + ", houseSpecial=" + houseSpecial + ", vat=" + vat
				+ ", serviceTax=" + serviceTax + ", menucatId=" + menucatId + ", menucatName=" + menucatName
				+ ", submenucatId=" + submenucatId + ", submenucatName=" + submenucatName + ", code=" + code
				+ ", dailyMinQty=" + dailyMinQty + ", unit=" + unit + ", packaged=" + packaged + ", production="
				+ production + ", cookingTimeInMins=" + cookingTimeInMins + ", specialNote=" + specialNote
				+ ", printerList=" + printerList + ", spotDiscount=" + spotDiscount + ", isKotPrint=" + isKotPrint
				+ ", purchasePrice=" + purchasePrice + "]";
	}
	
	
	

}
