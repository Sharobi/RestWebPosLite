/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.util.List;


/**
 * @author habib
 *
 */
public class BillSplitManual {

	private int id;

	private int billId;

	
	private String mode;

	private int billNo;

	private String printBillNumber;

	private int orderId;

	private String itemName;

	private Double itemRate;

	private int itemQuantity;

	private Double billAmount;

	private String creationDate;


	private String type;

	private int totalBillNo;

	private String deliveryType;

	private String modeValue;

	private Double total;

	private int itemId;
	
	private int categoryId;
	
	private List<BillSplitManual> billSplitManuals;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBillId() {
		return billId;
	}

	public void setBillId(int billId) {
		this.billId = billId;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public int getBillNo() {
		return billNo;
	}

	public void setBillNo(int billNo) {
		this.billNo = billNo;
	}

	public String getPrintBillNumber() {
		return printBillNumber;
	}

	public void setPrintBillNumber(String printBillNumber) {
		this.printBillNumber = printBillNumber;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Double getItemRate() {
		return itemRate;
	}

	public void setItemRate(Double itemRate) {
		this.itemRate = itemRate;
	}

	public int getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(int itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public Double getBillAmount() {
		return billAmount;
	}

	public void setBillAmount(Double billAmount) {
		this.billAmount = billAmount;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getTotalBillNo() {
		return totalBillNo;
	}

	public void setTotalBillNo(int totalBillNo) {
		this.totalBillNo = totalBillNo;
	}

	public String getDeliveryType() {
		return deliveryType;
	}

	public void setDeliveryType(String deliveryType) {
		this.deliveryType = deliveryType;
	}

	public String getModeValue() {
		return modeValue;
	}

	public void setModeValue(String modeValue) {
		this.modeValue = modeValue;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public List<BillSplitManual> getBillSplitManuals() {
		return billSplitManuals;
	}

	public void setBillSplitManuals(List<BillSplitManual> billSplitManuals) {
		this.billSplitManuals = billSplitManuals;
	}
	
}
