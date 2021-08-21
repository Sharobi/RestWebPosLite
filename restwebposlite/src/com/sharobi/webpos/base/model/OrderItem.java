/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * @author habib
 *
 */
public class OrderItem implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int orderId;
	private int itemId;
	private String quantityOfItem;
	private Double totalPriceByItem;
	private String changeNote;
	private String specialNote;
	private String discount;
	private double vat;
	private double serviceTax;
	private String itemName;
	private double rate;
	private double promotionValue;
	private double promotionDiscountAmt;
	private MenuItem item;
	//new add
	private int ordrId;
	private String orderTime;
	private String kitchenName;
	private String chefName="Deafult";
	private String cookingStatus;
	private String cookingTime;
	private String cookingStartTime;
	private String cookingEndTime;
	private String serveStatus;
	private String kitchenOut;
	private int ordertype;
	//end new add
	private String isinOrder="N";
	
	//for categorywise splitbill
	private List<Menu> category;
	private Set<Menu> categoryDes;
	
	
	private String orderNo; // new added 10.8.2018
	
	 private double discountPercentage;
	 private double customerDiscount;
	 private Double netPrice;
	public Set<Menu> getCategoryDes() {
		return categoryDes;
	}
	public void setCategoryDes(Set<Menu> categoryDes) {
		this.categoryDes = categoryDes;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	
	public String getQuantityOfItem() {
		return quantityOfItem;
	}
	public void setQuantityOfItem(String quantityOfItem) {
		this.quantityOfItem = quantityOfItem;
	}
	
	public Double getTotalPriceByItem() {
		return totalPriceByItem;
	}
	public void setTotalPriceByItem(Double totalPriceByItem) {
		this.totalPriceByItem = totalPriceByItem;
	}
	public String getChangeNote() {
		return changeNote;
	}
	public void setChangeNote(String changeNote) {
		this.changeNote = changeNote;
	}
	
	public String getSpecialNote() {
		return specialNote;
	}
	public void setSpecialNote(String specialNote) {
		this.specialNote = specialNote;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
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
	
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	
	
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	
	public double getPromotionValue() {
		return promotionValue;
	}
	public void setPromotionValue(double promotionValue) {
		this.promotionValue = promotionValue;
	}
	public double getPromotionDiscountAmt() {
		return promotionDiscountAmt;
	}
	public void setPromotionDiscountAmt(double promotionDiscountAmt) {
		this.promotionDiscountAmt = promotionDiscountAmt;
	}
	public MenuItem getItem() {
		return item;
	}
	public void setItem(MenuItem item) {
		this.item = item;
	}
	
	public int getOrdrId() {
		return ordrId;
	}
	public void setOrdrId(int ordrId) {
		this.ordrId = ordrId;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getKitchenName() {
		return kitchenName;
	}
	public void setKitchenName(String kitchenName) {
		this.kitchenName = kitchenName;
	}
	public String getChefName() {
		return chefName;
	}
	public void setChefName(String chefName) {
		this.chefName = chefName;
	}
	public String getCookingStatus() {
		return cookingStatus;
	}
	public void setCookingStatus(String cookingStatus) {
		this.cookingStatus = cookingStatus;
	}
	public String getCookingTime() {
		return cookingTime;
	}
	public void setCookingTime(String cookingTime) {
		this.cookingTime = cookingTime;
	}
	public String getCookingStartTime() {
		return cookingStartTime;
	}
	public void setCookingStartTime(String cookingStartTime) {
		this.cookingStartTime = cookingStartTime;
	}
	public String getCookingEndTime() {
		return cookingEndTime;
	}
	public void setCookingEndTime(String cookingEndTime) {
		this.cookingEndTime = cookingEndTime;
	}
	public String getServeStatus() {
		return serveStatus;
	}
	public void setServeStatus(String serveStatus) {
		this.serveStatus = serveStatus;
	}
	public String getKitchenOut() {
		return kitchenOut;
	}
	public void setKitchenOut(String kitchenOut) {
		this.kitchenOut = kitchenOut;
	}
	
	public int getOrdertype() {
		return ordertype;
	}
	public void setOrdertype(int ordertype) {
		this.ordertype = ordertype;
	}
	public String getIsinOrder() {
		return isinOrder;
	}
	public void setIsinOrder(String isinOrder) {
		this.isinOrder = isinOrder;
	}
	public List<Menu> getCategory() {
		return category;
	}
	public void setCategory(List<Menu> category) {
		this.category = category;
	}
	/*@Override
	public String toString() {
		return "OrderItem [id=" + id + ", orderId=" + orderId + ", itemId=" + itemId + ", quantityOfItem=" + quantityOfItem + ", totalPriceByItem=" + totalPriceByItem + ", changeNote=" + changeNote + ", specialNote=" + specialNote + ", discount=" + discount + ", vat=" + vat + ", serviceTax=" + serviceTax + ", itemName=" + itemName + ", rate=" + rate + ", promotionValue=" + promotionValue + ", promotionDiscountAmt=" + promotionDiscountAmt + ", item=" + item + ", ordrId=" + ordrId + ", orderTime=" + orderTime + ", kitchenName=" + kitchenName + ", chefName=" + chefName + ", cookingStatus=" + cookingStatus + ", cookingTime=" + cookingTime + ", cookingStartTime=" + cookingStartTime + ", cookingEndTime=" + cookingEndTime + ", serveStatus=" + serveStatus + ", kitchenOut=" + kitchenOut + ", ordertype=" + ordertype + ", isinOrder=" + isinOrder + ", category=" + category + "]";
	}*/
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	public double getDiscountPercentage() {
		return discountPercentage;
	}
	public void setDiscountPercentage(double discountPercentage) {
		this.discountPercentage = discountPercentage;
	}
	public double getCustomerDiscount() {
		return customerDiscount;
	}
	public void setCustomerDiscount(double customerDiscount) {
		this.customerDiscount = customerDiscount;
	}
	
	public Double getNetPrice() {
		return netPrice;
	}
	public void setNetPrice(Double netPrice) {
		this.netPrice = netPrice;
	}
	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", orderId=" + orderId + ", itemId=" + itemId + ", quantityOfItem="
				+ quantityOfItem + ", totalPriceByItem=" + totalPriceByItem + ", changeNote=" + changeNote
				+ ", specialNote=" + specialNote + ", discount=" + discount + ", vat=" + vat + ", serviceTax="
				+ serviceTax + ", itemName=" + itemName + ", rate=" + rate + ", promotionValue=" + promotionValue
				+ ", promotionDiscountAmt=" + promotionDiscountAmt + ", item=" + item + ", ordrId=" + ordrId
				+ ", orderTime=" + orderTime + ", kitchenName=" + kitchenName + ", chefName=" + chefName
				+ ", cookingStatus=" + cookingStatus + ", cookingTime=" + cookingTime + ", cookingStartTime="
				+ cookingStartTime + ", cookingEndTime=" + cookingEndTime + ", serveStatus=" + serveStatus
				+ ", kitchenOut=" + kitchenOut + ", ordertype=" + ordertype + ", isinOrder=" + isinOrder + ", category="
				+ category + ", categoryDes=" + categoryDes + ", orderNo=" + orderNo + ", discountPercentage="
				+ discountPercentage + ", customerDiscount=" + customerDiscount + ", netPrice=" + netPrice + "]";
	}
	
	
	
	
	
	
}
