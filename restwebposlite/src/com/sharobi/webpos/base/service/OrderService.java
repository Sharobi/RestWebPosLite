/**
 * 
 */
package com.sharobi.webpos.base.service;

import java.util.ArrayList;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ReturnTypes;
import com.sharobi.webpos.adm.model.SalesReturn;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.base.model.Bill;
import com.sharobi.webpos.base.model.BillSplitManual_duplicate;
import com.sharobi.webpos.base.model.CommonBean;
import com.sharobi.webpos.base.model.Discount;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.base.model.StoreCustomers;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;


public class OrderService {
	private final static Logger logger = LogManager
			.getLogger(OrderService.class);
	private final static Gson gson = new Gson();

	public String saveOrder(Order order) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(CommonResource.WEBSERVICE_ORDER_SAVE);
			logger.debug("url....{}", url);
		/*	ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			String json = ow.writeValueAsString(order);
		*/

			ClientResponse response = WebServiceClient.callPost(url,
					gson.toJson(order));
			String responseString = response.getEntity(String.class);
			logger.debug("generated order id...{}", responseString);
			return responseString;

		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public List<Order> getUnpaidOrderList(int storeId, String toDay) {
		List<Order> allUnpaidOrderList = new ArrayList<Order>();
		try {
			logger.debug("Input [store id] [to day date]: {},{}", storeId,
					toDay);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETUNPAIDORDERLIST)
							.replace("{1}", String.valueOf(storeId))
							.replace("{2}", String.valueOf(toDay));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get unpaid orderlist list: {}",
					responseString);
			allUnpaidOrderList = gson.fromJson(responseString,
					new TypeToken<List<Order>>() {
					}.getType());
			logger.debug("all unpaid order List fetched: {}",
					allUnpaidOrderList);
			return allUnpaidOrderList;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String getPaidOrderList(int storeId, String toDay) {
		// List<Order> allUnpaidOrderList=new ArrayList<Order>();
		try {
			logger.debug("Input [store id] [to day date]: {},{}", storeId,
					toDay);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETALLPAIDORDER)
							.replace("{1}", String.valueOf(storeId))
							.replace("{2}", String.valueOf(toDay));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get paid orderlist list: {}",
					responseString);
			// allUnpaidOrderList=gson.fromJson(responseString, new
			// TypeToken<List<Order>>() {}.getType());
			// logger.debug("all unpaid order List fetched: {}",
			// allUnpaidOrderList);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String getPaymentInfo(int orderNo) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(
							CommonResource.WEBSERVICE_BILL_PAYMENTINFO)
							.replace("{1}", String.valueOf(orderNo));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get payment info: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}
	

	public String getPaymentTypeByStore(int storeid) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETPAYMENTTYPEBYSTORE)
							.replace("{1}", String.valueOf(storeid));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get payment info: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public List<Payment> getPaymentListById(int orderNo) {
		List<Payment> payemntList = new ArrayList<Payment>();
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(
							CommonResource.WEBSERVICE_BILL_PAYMENTINFO)
							.replace("{1}", String.valueOf(orderNo));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get payment info: {}",
					responseString);
			payemntList = gson.fromJson(responseString,
					new TypeToken<List<Payment>>() {
					}.getType());
			return payemntList;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public String orderPayment(Payment payment) {
		try {
			ClientResponse response = WebServiceClient
					.callPost(
							CommonResource
									.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
									+ CommonResource
											.getProperty(CommonResource.WEBSERVICE_BILL_PAYMENT),
							gson.toJson(payment));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String printBill(int orderId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_BILL_PRINT)
							.replace("{1}", String.valueOf(orderId))
							.replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in print bill: {}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public Order getOrderById(int orderId) {
		Order order = new Order();
		try {
			logger.debug("Input [order id] : {}", orderId);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_UNPAID_ORDER_GETORDERBYID)
							.replace("{1}", String.valueOf(orderId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			order = gson.fromJson(responseString, new TypeToken<Order>() {
			}.getType());
			logger.debug("order fetched: {}", order);
			return order;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public List<OrderType> getOrderType(int storeId) {
		
		List<OrderType> orderTypeList = new ArrayList<OrderType>();
		try {
			
			String url =CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_TYPE).replace("{1}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			System.out.println("ORDER TAKING"+responseString);
			orderTypeList = gson.fromJson(responseString, new TypeToken<List<OrderType>>() {}.getType());
			
			logger.debug("Response string: {}", responseString);
			return orderTypeList;
		
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public Order getOrderByIdForSpiltBill(int orderId) {
		Order order = new Order();
		try {
			logger.debug("Input [order id] : {}", orderId);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_UNPAID_ORDER_GETORDERBYID_FOR_SPLITBILL)
							.replace("{1}", String.valueOf(orderId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			order = gson.fromJson(responseString, new TypeToken<Order>() {
			}.getType());
			logger.debug("order fetched: {}", order);
			return order;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public Bill getBillById(int orderId) {
		Bill bill = new Bill();
		try {
			logger.debug("Input [order id] : {}", orderId);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(
							CommonResource.WEBSERVICE_BILL_GETBILLBYID)
							.replace("{1}", String.valueOf(orderId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			bill = gson.fromJson(responseString, new TypeToken<Bill>() {
			}.getType());
			logger.debug("order fetched: {}", bill);
			return bill;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String addDiscount(Discount discount) {
		try {
			ClientResponse response = WebServiceClient
					.callPost(
							CommonResource
									.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
									+ CommonResource
											.getProperty(CommonResource.WEBSERVICE_BILL_ADDDISCOUNT),
							gson.toJson(discount));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String getsplnotebyItemId(int itemId, int storeId) {
		// List<MenuItemNote> menuitemnoteList=new ArrayList<MenuItemNote>();
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETSPLNOTEBYITEMID)
							.replace("{1}", String.valueOf(itemId))
							.replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug(
					"Response string in get specialnote by item id info: {}",
					responseString);
			// menuitemnoteList=gson.fromJson(responseString, new
			// TypeToken<List<MenuItemNote>>() {}.getType());
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public List<StoreCustomers> getallcreditCustomers(int storeId) {
		List<StoreCustomers> creditcustomerList = new ArrayList<StoreCustomers>();
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_GETSTORECUSTOMER)
							.replace("{1}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all credit customers: {}",
					responseString);
			creditcustomerList = gson.fromJson(responseString,
					new TypeToken<List<StoreCustomers>>() {
					}.getType());
			return creditcustomerList;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String updateCreditSaleStatus(int orderid, int storeId, int custid) {
		// List<MenuItemNote> menuitemnoteList=new ArrayList<MenuItemNote>();
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_UPDATE_CREDITSALE)
							.replace("{1}", String.valueOf(orderid))
							.replace("{2}", String.valueOf(storeId))
							.replace("{3}", String.valueOf(custid));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in updateCreditSaleStatus : {}",
					responseString);
			// menuitemnoteList=gson.fromJson(responseString, new
			// TypeToken<List<MenuItemNote>>() {}.getType());
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String updatePax(int orderid, int pax) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_UPDATE_PAX)
							.replace("{1}", String.valueOf(orderid))
							.replace("{2}", String.valueOf(pax));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in updatePax : {}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String updateTable(int orderid, String tabno) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_UPDATE_TABLE)
							.replace("{1}", String.valueOf(orderid))
							.replace("{2}", String.valueOf(tabno));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in updateTable : {}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String splitBillM(BillSplitManual_duplicate splitBill) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(CommonResource.WEBSERVICE_BILL_SPLIT_M);
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url,
					gson.toJson(splitBill));
			String responseString = response.getEntity(String.class);
			logger.debug("billsplitted...{}", responseString);
			return responseString;

		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public String printSplitBill(int orderId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_BILL_SPLIT_PRINT)
							.replace("{1}", String.valueOf(orderId))
							.replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in print split bill: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public String printKotCheckList(int orderId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_KOT_CHECKLIST_PRINT)
							.replace("{1}", String.valueOf(orderId))
							.replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in print kot checklist: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}

	public String getBillWiseItemList(int orderId) {
		try {
			logger.debug("Input [order id] : {}", orderId);
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_SPLIT_BILL_MANUAL_BYORDERID)
							.replace("{1}", String.valueOf(orderId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String getCustDetails(String contact, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETCUSTOMER_BYCONTACT)
							.replace("{1}", String.valueOf(storeId)).replace(
							"{2}", String.valueOf(contact)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String getCustDetailsbyid(String custid, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETCUSTOMER_BYID)
							.replace("{1}", String.valueOf(storeId)).replace(
							"{2}", String.valueOf(custid)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String getTotalTransaction(String custId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETTOTALTRANSACTION_CUSTID)
							.replace("{1}", String.valueOf(custId)).replace(
							"{2}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	public String getLastVisitDate(String custId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETLASTVISITDATE_CUSTID)
							.replace("{1}", String.valueOf(custId)).replace(
							"{2}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String getTotalPaidAmt(String custId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETTOTALPAIDAMOUNT_CUSTID)
							.replace("{1}", String.valueOf(custId)).replace(
							"{2}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String getMostPurchaseItem(String custId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETCUSTMOSTPURCHASEITEM_CUSTID)
							.replace("{1}", String.valueOf(custId)).replace(
							"{2}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}// getCustTransactionSummery
	
	public String getCustTransactionSummery(String custId, int storeId) {
		try {
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_ORDER_GETCUSTTRANSACTIONSUMMARY_CUSTID)
							.replace("{1}", String.valueOf(custId)).replace(
							"{2}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getCustDetails: {}",
					responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public List<String> getOrderCustContacts(int storeId) {

		try {
			List<String> custContact = new ArrayList<String>();
			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ (CommonResource
							.getProperty(CommonResource.WEBSERVICE_ORDER_GETCUSTOMERCONTACT)
							.replace("{1}", String.valueOf(storeId)));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get customer contact info: {}",
					responseString);
			custContact = gson.fromJson(responseString,
					new TypeToken<List<String>>() {
					}.getType());
			return custContact;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String updatePrintCountWithReason(CommonBean commonBean)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_UPDATE_BILLPRINT_COUNT);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(commonBean));
			String responseString=response.getEntity(String.class);
			logger.debug("updatePrintCountWithReason...{}",responseString);
			return responseString;
			
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}

	public String getOrderWithPayment(int orderId, int storeId) {

		try {

			logger.debug("Input [order id][stode id] : {}{}{}", orderId,
					storeId);

			String url = CommonResource
					.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource
							.getProperty(
									CommonResource.WEBSERVICE_PRINT_BILL_CASH)
							.replace("{1}", String.valueOf(orderId))
							.replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("responseString : {}{}{}", responseString);
			// Order order = (Order) gson.fromJson(responseString, new
			// TypeToken<Order>() {}.getType());
			return responseString;

		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}

	}
	
	
	
	public String getBillPrintCount(int orderId,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GET_BILLPRINT_COUNT).replace("{1}", String.valueOf(orderId)).replace("{2}", String.valueOf(storeId));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in getBillPrintCount: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	
	public Order getUnpaidOrderById(int orderId,int storeid,String lang)
	{
		Order order=new Order();
		try{
			logger.debug("Input [order id] : {}",orderId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYID).replace("{1}", String.valueOf(orderId)).replace("{2}", String.valueOf(storeid)).replace("{3}", String.valueOf(lang));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			order=gson.fromJson(responseString, new TypeToken<Order>() {}.getType());
			logger.debug("order fetched: {}", order);
			return order;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	
	public String getCustDetbyPhno(int storeId,String phno){
		
		try{
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYPHNO).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(phno));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer details info: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	
	
public String getCustContactsbyName(int storeId,String name){
		
		try{
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYNAME).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(name));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer details info: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}

public String getLocList(int storeId,String loc){
	
	try{
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETCUSTOMER_LOCATION).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(loc));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get getLocList details info: {}", responseString);
		return responseString;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}

	
}

//for advance booking
// Prebooking table by admin part service section  start   Advance Booking part)


public List<Order> getAllPreBookingList(int storeId) {

	List<Order> prebookedtableList=new ArrayList<Order>();
	try{
		logger.debug("Input [store id] for getting prebook table details: {}",storeId);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_TABLE_PREBOOKLIST).replace("{1}", String.valueOf(storeId));
		logger.debug("get prebook table list URL: {}", url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get prebook table list: {}", responseString);
		prebookedtableList=gson.fromJson(responseString, new TypeToken<List<Order>>() {}.getType());
		logger.debug("Prebook Table List fetched: {}", prebookedtableList);
		return prebookedtableList;
	}catch (Exception e) {
		e.printStackTrace();
		return null;
	}	}

public String addTablePreBookingData(Order bookingdetails) {
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADDBOOKINGDETAILS);
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(bookingdetails));
		String responseString=response.getEntity(String.class);
		logger.debug("response string...{}",responseString);
		return responseString;
	}
	catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}
public String editPreBookingTableDetails(Order prebooktable) {
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_PREBOOKINGTABLE_EDITBOOKINGDETAILS);
		logger.debug("edit prebook table data url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(prebooktable));
		String responseString=response.getEntity(String.class);
		logger.debug("response string in edit prebook table data...{}",responseString);
		return responseString;
	}
	catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}



public String preBookTblPayInAdv(Payment paymentdetail) {
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADVANCEPAY);
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(paymentdetail));
		String responseString=response.getEntity(String.class);
		logger.debug("response string...{}",responseString);
		return responseString;
	}
	catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}
public String savePreBookCustomer(StoreCustomer cust) {
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_ADDSTORECUSTOMER);
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(cust));
		String responseString=response.getEntity(String.class);
		logger.debug("response string...{}",responseString);
		return responseString;
	}
	catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}

public Order getUnpaidOrderByOrderNo(String orderno, int storeId, String selLang) {
	Order order=new Order();
	try{
		logger.debug("Input [order no] : {}",orderno);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYNUMBER).replace("{1}", String.valueOf(orderno)).replace("{2}", String.valueOf(storeId)).replace("{3}", String.valueOf(selLang));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		order=gson.fromJson(responseString, new TypeToken<Order>() {}.getType());
		logger.debug("order fetched: {}", order);
		return order;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
	
	
	
	
}

public String getCountOfAdvanceBooking(int storeId) {
	String count=null;
	try{
		logger.debug("Input [store id] for getting prebook table count: {}",storeId);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADVANCE_ORDER_COUNT).replace("{1}", String.valueOf(storeId));
		logger.debug("get prebook table list URL: {}", url);
		//ClientResponse response=WebServiceClient.callGet(url);
		ClientResponse response=WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		count=response.getEntity(String.class);
		
		logger.debug("Prebook Table count: {}", count);
		return count;
	}catch (Exception e) {
		e.printStackTrace();
		return null;
	}
}

// Order refund (sale refund)
public void saveSalesRefundData(SalesReturn salesReturn) {
	try {
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_ORDER_SAVEREFUND));
		logger.debug("URL :: {}", url);
		ClientResponse response = WebServiceClient.callPost(url, gson.toJson(salesReturn));
		String responseString = response.getEntity(String.class);
		logger.debug("Response :: {}", responseString);
	} catch (Exception e) {
		logger.error("Exception", e);
	}
	
  }

public String getRefundOrderDetailsDataById(String orderid, int storeId) {
	String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_REFUNDORDERDETAILS_BYORDERID).replace("{1}", orderid).replace("{2}", String.valueOf(storeId)));
	ClientResponse response = WebServiceClient.callGet(url);
	logger.debug("Response : {}", response);
	String responseString = response.getEntity(String.class);
	logger.debug("Response string: {}", responseString);
	return responseString;
}

public String approveSalesRefundData(SalesReturn salesreturn) {

	try{
		ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_ORDERREFUND_APPROVE), gson.toJson(salesreturn));
		String responseString=response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		return responseString;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return "Failure";
	}
}

public String deleteSalesReturnDataById(String salesreturnid, int storeId) {
	try {
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_ORDERREFUND_DELETE).replace("{1}", salesreturnid).replace("{2}", String.valueOf(storeId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		return responseString;
	} catch (Exception e) {
		logger.error("Exception", e);
		return "Failure";
	}
}

public String printOrderRefundBill(int orderId, int storeId) {
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_REFUND_BILL_PRINT).replace("{1}", String.valueOf(orderId)).replace("{2}", String.valueOf(storeId));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in print bill: {}", responseString);
		return responseString;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}

public List<Order> getPaidOrderByOrderNo(String orderno, int storeId) {
	List<Order> orders=new ArrayList<>();
	try{
		logger.debug("Input [order no] : {}",orderno);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERNUMBER).replace("{1}", String.valueOf(orderno)).replace("{2}", String.valueOf(storeId));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		orders=gson.fromJson(responseString, new TypeToken<List<Order>>() {}.getType());
		logger.debug("order fetched: {}", orders);
		return orders;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}

public String getPaidOrderDetailsDataById(String orderid, int storeId) {
	String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERID).replace("{1}", orderid).replace("{2}", String.valueOf(storeId)));
	ClientResponse response = WebServiceClient.callGet(url);
	logger.debug("Response : {}", response);
	String responseString = response.getEntity(String.class);
	logger.debug("Response string: {}", responseString);
	return responseString;
}

public List<ReturnTypes> getAllReturntypes(int storeId) {
	List<ReturnTypes> returnreasons=new ArrayList<ReturnTypes>();
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_REFUND_REASONS).replace("{1}",String.valueOf(storeId));
		System.out.println("url:"+url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		returnreasons=gson.fromJson(responseString, new TypeToken<List<ReturnTypes>>() {}.getType());
		logger.debug("all return reasons List fetched: {}", returnreasons);
		return returnreasons;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}

public String setOrderRemarks(Order order) {
	try {
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_SETREMARKS);
		
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(order));
		String responseString=response.getEntity(String.class);
		logger.debug("setOrderRemarks...{}",responseString);
		return responseString;
	} catch (Exception ex) {
		logger.debug("Exception", ex);
		return null;
	}
}

public String setPackagingNotes(Order order) {
	try {
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_SETPACKAGINGNOTE);
		
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(order));
		String responseString=response.getEntity(String.class);
		logger.debug("setPackagingNotes...{}",responseString);
		return responseString;
	} catch (Exception ex) {
		logger.debug("Exception", ex);
		return null;
	}
}


}
