/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author habib
 *
 */
public class Order implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String customerName;
	private String customerContact;
	private String orderDate;
	private String deliveryAddress;
	private String deliveryPersonName;
	private String activationFlag;
	private int storeId;
	private String table_no;
	private Double distance;
	private String specialNote;
	private String orderTime;
	private String billReqStatus;
	private String billReqTime;
	private String changeNote;
	private String cancelFlag;
	private int loginCustomerId;
	private String loginCustomerName;
	private int paymentTypeId;
	private String paymentTypeName;
	/*private int orderTypeId;
	private String orderTypeName;*/
	private OrderType ordertype;
	private int paymentId;
	private Double paymentAmount;
	private String remarks;
	private String paymentMode;
	private String billCreatedBy;
	private String billCreationDate;
	private List<OrderItem> orderitem;
	private Customer customers;
	private Bill orderBill;
	private int noOfPersons;
	private String isDiscountAdded="N";
	private double paidAmt;
	private String childTables = "";
	private String seatNo;
	private int printerId;
	private int storeCustomerId;
	private String creditFlag;
	private String source;
	private String cancelRemark;
	private String custVatRegNo;
	private String location;
    private String houseNo;
    private String street;
    private String state;

    private String dob;
    private String anniversary;
    private String customerId;
    
    private String orderNo; // New added in 17th July 2018
    private List<Payment> payments; // for advance order taking
    private String time;
    private String refundStatus;
    private List<OrderItem> packingitem; // for red-onion to separate packaging items in bill on 09/03/2021
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerContact() {
		return customerContact;
	}
	public void setCustomerContact(String customerContact) {
		this.customerContact = customerContact;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	
	public String getDeliveryPersonName() {
		return deliveryPersonName;
	}
	public void setDeliveryPersonName(String deliveryPersonName) {
		this.deliveryPersonName = deliveryPersonName;
	}
	public String getActivationFlag() {
		return activationFlag;
	}
	public void setActivationFlag(String activationFlag) {
		this.activationFlag = activationFlag;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	public String getTable_no() {
		return table_no;
	}
	public void setTable_no(String table_no) {
		this.table_no = table_no;
	}
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	public String getSpecialNote() {
		return specialNote;
	}
	public void setSpecialNote(String specialNote) {
		this.specialNote = specialNote;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getBillReqStatus() {
		return billReqStatus;
	}
	public void setBillReqStatus(String billReqStatus) {
		this.billReqStatus = billReqStatus;
	}
	public String getBillReqTime() {
		return billReqTime;
	}
	public void setBillReqTime(String billReqTime) {
		this.billReqTime = billReqTime;
	}
	public String getChangeNote() {
		return changeNote;
	}
	public void setChangeNote(String changeNote) {
		this.changeNote = changeNote;
	}
	public String getCancelFlag() {
		return cancelFlag;
	}
	public void setCancelFlag(String cancelFlag) {
		this.cancelFlag = cancelFlag;
	}
	public int getLoginCustomerId() {
		return loginCustomerId;
	}
	public void setLoginCustomerId(int loginCustomerId) {
		this.loginCustomerId = loginCustomerId;
	}
	public String getLoginCustomerName() {
		return loginCustomerName;
	}
	public void setLoginCustomerName(String loginCustomerName) {
		this.loginCustomerName = loginCustomerName;
	}
	public int getPaymentTypeId() {
		return paymentTypeId;
	}
	public void setPaymentTypeId(int paymentTypeId) {
		this.paymentTypeId = paymentTypeId;
	}
	public String getPaymentTypeName() {
		return paymentTypeName;
	}
	public void setPaymentTypeName(String paymentTypeName) {
		this.paymentTypeName = paymentTypeName;
	}
	/*public int getOrderTypeId() {
		return orderTypeId;
	}
	public void setOrderTypeId(int orderTypeId) {
		this.orderTypeId = orderTypeId;
	}
	public String getOrderTypeName() {
		return orderTypeName;
	}
	public void setOrderTypeName(String orderTypeName) {
		this.orderTypeName = orderTypeName;
	}*/
	
	public int getPaymentId() {
		return paymentId;
	}
	public OrderType getOrdertype() {
		return ordertype;
	}
	public void setOrdertype(OrderType ordertype) {
		this.ordertype = ordertype;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public Double getPaymentAmount() {
		return paymentAmount;
	}
	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public String getBillCreatedBy() {
		return billCreatedBy;
	}
	public void setBillCreatedBy(String billCreatedBy) {
		this.billCreatedBy = billCreatedBy;
	}
	public String getBillCreationDate() {
		return billCreationDate;
	}
	public void setBillCreationDate(String billCreationDate) {
		this.billCreationDate = billCreationDate;
	}
	
	public List<OrderItem> getOrderitem() {
		return orderitem;
	}
	public void setOrderitem(List<OrderItem> orderitem) {
		this.orderitem = orderitem;
	}
	
	public Customer getCustomers() {
		return customers;
	}
	public void setCustomers(Customer customers) {
		this.customers = customers;
	}
	
	public Bill getOrderBill() {
		return orderBill;
	}
	public void setOrderBill(Bill orderBill) {
		this.orderBill = orderBill;
	}
	
	public int getNoOfPersons() {
		return noOfPersons;
	}
	public void setNoOfPersons(int noOfPersons) {
		this.noOfPersons = noOfPersons;
	}
	
	public String getIsDiscountAdded() {
		return isDiscountAdded;
	}
	public void setIsDiscountAdded(String isDiscountAdded) {
		this.isDiscountAdded = isDiscountAdded;
	}
	
	public double getPaidAmt() {
		return paidAmt;
	}
	public void setPaidAmt(double paidAmt) {
		this.paidAmt = paidAmt;
	}
	
	public String getChildTables() {
		return childTables;
	}
	public void setChildTables(String childTables) {
		this.childTables = childTables;
	}
	
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	
	public int getPrinterId() {
		return printerId;
	}
	public void setPrinterId(int printerId) {
		this.printerId = printerId;
	}
	public int getStoreCustomerId() {
		return storeCustomerId;
	}
	public void setStoreCustomerId(int storeCustomerId) {
		this.storeCustomerId = storeCustomerId;
	}
	public String getCreditFlag() {
		return creditFlag;
	}
	public void setCreditFlag(String creditFlag) {
		this.creditFlag = creditFlag;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getCancelRemark() {
		return cancelRemark;
	}
	public void setCancelRemark(String cancelRemark) {
		this.cancelRemark = cancelRemark;
	}
	public String getCustVatRegNo() {
		return custVatRegNo;
	}
	public void setCustVatRegNo(String custVatRegNo) {
		this.custVatRegNo = custVatRegNo;
	}
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getHouseNo() {
		return houseNo;
	}
	public void setHouseNo(String houseNo) {
		this.houseNo = houseNo;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	
	
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getAnniversary() {
		return anniversary;
	}
	public void setAnniversary(String anniversary) {
		this.anniversary = anniversary;
	}
	
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	public List<Payment> getPayments() {
		return payments;
	}
	public void setPayments(List<Payment> payments) {
		this.payments = payments;
	}
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	public String getRefundStatus() {
		return refundStatus;
	}
	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}
	
	
	public List<OrderItem> getPackingitem() {
		return packingitem;
	}
	public void setPackingitem(List<OrderItem> packingitem) {
		this.packingitem = packingitem;
	}
	@Override
	public String toString() {
		return "Order [id=" + id + ", customerName=" + customerName + ", customerContact=" + customerContact
				+ ", orderDate=" + orderDate + ", deliveryAddress=" + deliveryAddress + ", deliveryPersonName="
				+ deliveryPersonName + ", activationFlag=" + activationFlag + ", storeId=" + storeId + ", table_no="
				+ table_no + ", distance=" + distance + ", specialNote=" + specialNote + ", orderTime=" + orderTime
				+ ", billReqStatus=" + billReqStatus + ", billReqTime=" + billReqTime + ", changeNote=" + changeNote
				+ ", cancelFlag=" + cancelFlag + ", loginCustomerId=" + loginCustomerId + ", loginCustomerName="
				+ loginCustomerName + ", paymentTypeId=" + paymentTypeId + ", paymentTypeName=" + paymentTypeName
				+ ", ordertype=" + ordertype + ", paymentId=" + paymentId + ", paymentAmount=" + paymentAmount
				+ ", remarks=" + remarks + ", paymentMode=" + paymentMode + ", billCreatedBy=" + billCreatedBy
				+ ", billCreationDate=" + billCreationDate + ", orderitem=" + orderitem + ", customers=" + customers
				+ ", orderBill=" + orderBill + ", noOfPersons=" + noOfPersons + ", isDiscountAdded=" + isDiscountAdded
				+ ", paidAmt=" + paidAmt + ", childTables=" + childTables + ", seatNo=" + seatNo + ", printerId="
				+ printerId + ", storeCustomerId=" + storeCustomerId + ", creditFlag=" + creditFlag + ", source="
				+ source + ", cancelRemark=" + cancelRemark + ", custVatRegNo=" + custVatRegNo + ", location="
				+ location + ", houseNo=" + houseNo + ", street=" + street + ", state=" + state + ", dob=" + dob
				+ ", anniversary=" + anniversary + ", customerId=" + customerId + ", orderNo=" + orderNo + ", payments="
				+ payments + ", time=" + time + ", refundStatus=" + refundStatus + ", packingitem=" + packingitem + "]";
	}
	

	
	
	
	
	
}
