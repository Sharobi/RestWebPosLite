package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import 	java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.base.model.Table;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.TableService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
@Controller
@RequestMapping("/advancebooking")
public class AdvanceBookingController {
	
	private final static Logger logger=LogManager.getLogger(AdvanceBookingController.class);
	//@Autowired StoreCustomerMgntService storecustomermgntService;
	//@Autowired AdvanceBookingService advanceBookingService;
	private final static OrderService orderService=new OrderService();
	private final static TableService tableService=new TableService();

	private final static Gson gson=new Gson();
	
	List<OrderItem> orderitemList1 = null;
    List<OrderItem> existingOrderitemList1 = null;

	@RequestMapping(value="/loadadvancebooking",method=RequestMethod.GET)
	public ModelAndView loadAdvanceBookingData(HttpSession session) throws ParseException
	{
		logger.debug("in loadadvancetablebooking...! ");
	 
		orderitemList1 = new ArrayList<OrderItem>();
    existingOrderitemList1 = new ArrayList<OrderItem>();
    // avoid order item merging
    session.setAttribute("orderitemList1", orderitemList1);
    session.setAttribute("existingOrderitemList1", existingOrderitemList1);
    
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		//List<Table> tableList=tableService.getTableList(customer.getStoreId()); // no table in F&B lite
		List<Table> nonmultiordertablelist=new ArrayList<Table>();
		/*if(tableList.size()>0){ 
		for(Table ob: tableList){
			if(!ob.getMultiOrder().equals("Y")){
				nonmultiordertablelist.add(ob);
			}
		 }
		}*/
		mav.addObject("tableList",nonmultiordertablelist);	
	    mav.addObject("tables",gson.toJson(nonmultiordertablelist));
		List<Order> bookingList=orderService.getAllPreBookingList(customer.getStoreId());
		System.out.println("Booking Data:"+gson.toJson(bookingList));
		DateFormat formatter = new SimpleDateFormat("MMM d, yyyy HH:mm:ss a"); 
		if(bookingList!=null){
			if(bookingList.size()>0){
		       for(Order ob1: bookingList){
			       Date date = (Date)formatter.parse(ob1.getOrderDate());
			       SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
			       String finalString = newFormat.format(date);
                   ob1.setOrderDate(finalString);
            
                  /* Order ob2=setPaidAmt(ob1);
                   ob1.setPaidAmt(ob2.getPaidAmt());*/
              
                  }
		       }
	        }
		List<OrderType> orderTypes= orderService.getOrderType(customer.getStoreId());
		
	    mav.addObject("orderTypeList",orderTypes);
	    mav.addObject("orderTypes",gson.toJson(orderTypes));
		mav.addObject("advanceTableBookingList",bookingList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_ADV_TBL_BOOK_PAGE);
		return mav;
	}

	public Order setPaidAmt(Order order) {
		double paidAmount = 0.00;
		List<Payment> paymentLst = orderService.getPaymentListById(order.getId());
		Iterator<Payment> iterator = paymentLst.iterator();
		while (iterator.hasNext()) {
			Payment payment = (Payment) iterator.next();
			paidAmount = paidAmount + payment.getPaidAmount();
		}
		order.setPaidAmt(paidAmount);
		return order;
	}
	
	
	@RequestMapping(value="/addtablebookingdata",method=RequestMethod.POST)
	public void addStoreCustomer(@RequestBody String addBookingDetails,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addadvancetablebookingdetails......{}",addBookingDetails);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
		  OrderType ordertype = new OrderType();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");						
			Gson gson = new GsonBuilder().create();
			Order bookingdetails =gson.fromJson(addBookingDetails, new TypeToken<Order>() {
			}.getType());
			
			bookingdetails.setStoreId(customer.getStoreId());
			bookingdetails.setCustomers(customer);
			
			/*int otypeno=0;
			List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
			if (orderTypeList.size() > 0) { //temporary
				
				for (OrderType orderType : orderTypeList) {
					System.out.println("orderType=" + orderType.getOrderTypeName());
					if (orderType.getOrderTypeName().equalsIgnoreCase("Dine In")) {
						otypeno=orderType.getId();
						bookingdetails.setOrdertype(orderType);
						break;
					}
				}
			}*/
			
			bookingdetails.setSource(Constants.ORDER_SOURCE);
			bookingdetails.setOrderTime(getOrderTime());
			List<OrderItem> orderitemlist = (List<OrderItem>) session.getAttribute("orderitemList1");
			bookingdetails.setOrderitem(orderitemlist);
			bookingdetails.setCustomers(customer);
			ordertype.setId(bookingdetails.getOrdertype().getId());
			bookingdetails.setOrdertype(ordertype);
			bookingdetails.setStoreId(customer.getStoreId());
			System.out.println("INSERT DATA ::"+gson.toJson(bookingdetails));
			String res=orderService.addTablePreBookingData(bookingdetails);
			System.out.println("res:"+res);
			if (!"002".equals(res)) {
			session.removeAttribute("orderitemList1");
      session.removeAttribute("existingOrderitemList1");
			}
			out.print(res);
			out.flush();
		}
	}
	
	 public String getOrderTime() {
	    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    Date date = new Date();
	    // java.util.Calendar cal=java.util.Calendar.getInstance();
	    // System.out.println("date:"+df.format(date));
	    return df.format(date);
	  }
	
	
	
	
	
	
	@RequestMapping(value="/gettabledetails",method=RequestMethod.GET)
	public void getTableDetails(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In gettabledetailslist......{}");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			//List<Table> tableList=tableService.getTableList(customer.getStoreId()); // No table in F&B Lite
			List<Table> nonmultiordertablelist=new ArrayList<Table>();
			/*for(Table ob: tableList){
				if(!ob.getMultiOrder().equals("Y")){
					nonmultiordertablelist.add(ob);
				}
			}	*/		
			out.print(nonmultiordertablelist);
			out.flush();
		}
	}

	
	
	@RequestMapping(value="/edittablebookingdata",method=RequestMethod.POST)
	public void editTableBookingData(@RequestBody String editprebooktableString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editprebooktable......{},{},{},{},{},{},{}",editprebooktableString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
		  OrderType ordertype = new OrderType();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Order prebooktable =gson.fromJson(editprebooktableString, new TypeToken<Order>() {
			}.getType());
			
			prebooktable.setStoreId(customer.getStoreId());
			/*List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
			
			if (orderTypeList.size() > 0) {				
				for (OrderType orderType : orderTypeList) {
					//System.out.println("orderType=" + orderType.getOrderTypeName());
					if (orderType.getOrderTypeName().equalsIgnoreCase("Dine In")) {						
						prebooktable.setOrdertype(orderType);
						break;
					}
				}
			}*/
				
			prebooktable.setSource(Constants.ORDER_SOURCE);
			prebooktable.setOrderTime(getOrderTime());
      List<OrderItem> orderitemlist = (List<OrderItem>) session.getAttribute("orderitemList1");
      prebooktable.setOrderitem(orderitemlist);
      prebooktable.setCustomers(customer);
      ordertype.setId(prebooktable.getOrdertype().getId());
      prebooktable.setOrdertype(ordertype);
      prebooktable.setStoreId(customer.getStoreId());
      System.out.println("UPDATE DATA ::"+gson.toJson(prebooktable));
      String res=orderService.editPreBookingTableDetails(prebooktable);
      System.out.println("res:"+res);
      if (!"002".equals(res)) {
      session.removeAttribute("orderitemList1");
      session.removeAttribute("existingOrderitemList1");
      }
			
			//System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
		
	
	
	
	/*@RequestMapping(value="/listfrom/{from}/{to}",method=RequestMethod.GET)
	public void bookinglistbetweendate(	@PathVariable("from") String from,	@PathVariable("to") String to,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getadvbookedtabledetailslist......{}{}",from,to);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> bookingList=orderService.getAllPreBookingList(customer.getStoreId());
			String result = gson.toJson(bookingList);
			out.print(result);
			out.flush();
		}
	}*/

	
	
	@RequestMapping(value="/fetchprebookdata",method=RequestMethod.GET)
	public void showprebookingdata(HttpSession session,HttpServletResponse response) throws IOException, ParseException
	{
		logger.debug("in fetchadvancetablebookingdata...! ");
		     Customer customer=null;
		     Calendar calendar = Calendar.getInstance();
		  /*   Date today = calendar.getTime();		*/
		     calendar.add(Calendar.DAY_OF_YEAR, 1);
		     /*Date tomorrow = calendar.getTime();*/
		     SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
		     /*String todaydate = newFormat.format(today);*/
         /*String tomorrowdate = newFormat.format(tomorrow);*/
        // System.out.println("TODAY::"+todaydate+"TOMORROW:"+tomorrowdate);
        if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	   	{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> bookingList=orderService.getAllPreBookingList(customer.getStoreId());
			/*List<Order> filteredbookingList=new ArrayList<Order>();*/
			DateFormat formatter = new SimpleDateFormat("MMM d, yyyy HH:mm:ss a"); 
			/*for(Order ob1: bookingList){
				Date date = (Date)formatter.parse(ob1.getOrderDate());				
				String finalString = newFormat.format(date);
	            ob1.setOrderDate(finalString);
	            Order ob2=setPaidAmt(ob1);	            	            	            
	            ob1.setPaidAmt(ob2.getPaidAmt());
                }*/
			/*for(Order ob2: bookingList){
				
				if(ob2.getOrderDate().equals(todaydate) || ob2.getOrderDate().equals(tomorrowdate)){
					filteredbookingList.add(ob2);
				}
				
			}*/
			//System.out.println("res:"+filteredbookingList);
			out.print(gson.toJson(bookingList));
			out.flush();						
	   }
	}
	
 @RequestMapping(value="/advpayment/{bookingid}/ammt/{advpayammt}",method=RequestMethod.GET)
	public void prebookadvancepayment(@PathVariable("bookingid") String bookingid ,@PathVariable("advpayammt") String advpayammt,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In advancepayforprebooktable......{}{}");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Payment pay = new Payment();
			Order order = new Order();
			order.setId(NumberUtils.toInt(bookingid));
			pay.setOrderPayment(order);
			pay.setPaidAmount(NumberUtils.toDouble(advpayammt));
			pay.setStoreId(customer.getStoreId());			
			out.print(orderService.preBookTblPayInAdv(pay));
			out.flush();
		}
	}
	
	
 
 
 
 // use for testing sms integration
/* @RequestMapping(value = "/sendsms/{orderno}/subtot/{subtot}",
			method = RequestMethod.GET)
	public void sendSMS(@PathVariable("orderno") String orderno,@PathVariable("subtot") String subtot,HttpSession session,HttpServletResponse response) throws ParseException, IOException
	{
		logger.debug("in sendsms for...{}", orderno);
		Customer customer;
		Order order;
		String urlresponse = "";
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Gson gson = new Gson();
			//String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);			
			 order = orderService.getOrderById(NumberUtils.toInt(orderno));
			String demo = gson.toJson(order);
			System.out.println("demo:" + demo);
			 //out.print(gson.toJson(order));
			 SimpleDateFormat newFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a");
			 Date dt = newFormat.parse(order.getOrderDate());
			 SimpleDateFormat newFormat1 = new SimpleDateFormat("yyyy-MM-dd");
			 String orderdate = newFormat1.format(dt);
			 
			 String time1 = order.getOrderTime();
			 String[] splitingtime = time1.split("\\s+");
		      
			
			// String urlParameters = "{\"mobile_no\":\"9832631490\",\"bill_no\":\"12211221011212\",\"bill_amount\":\"100\",\"merchant_id\":\"7804\",\"email\":\"sanjay.einfo@gmail.com\",\"sub_id\":\"109\",\"date\":\"2018-01-12\",\"type\":\"sub\",\"time\":\"12:08:50\",\"name\":\"Manish Mirani\"}";
			    String mobile_no = order.getCustomerContact();
				String bill_no = orderno;
				String bill_amount = subtot;
				String merchant_id = "7804";
				String email = "sanjay.einfo@gmail.com";
				String sub_id = "109";
				String date = orderdate;
				String type = "sub";
				String time = splitingtime[1];
				String name = order.getCustomerName();
			 
			 
				//String urlParameters = "{\"mobile_no\":\""+mobile_no+"\",\"bill_no\":\""+bill_no+"\",\"bill_amount\":\""+bill_amount+"\",\"merchant_id\":\""+merchant_id+"\",\"email\":\""+email+"\",\"sub_id\":\""+sub_id+"\",\"date\":\""+date+"\",\"type\":\""+type+"\",\"time\":\""+time+"\",\"name\":\""+name+"\"}";
			 
			 SmsParameter parameter = new SmsParameter();
		     parameter.setMobile_no(mobile_no);
		     parameter.setBill_no(bill_no);
		     parameter.setBill_amount(bill_amount);
		     parameter.setMerchant_id(merchant_id);
		     parameter.setEmail(email);
		     parameter.setSub_id(sub_id);
		     parameter.setDate(date);
		     parameter.setType(type);
		     parameter.setTime(time);
		     parameter.setName(name);
		    
		    
		    
		
		     String urlParameters= gson.toJson(parameter);
		     System.out.println("urlparameter:"+urlParameters);
		     
		     try{
		    		String requestUrl="http://54.255.175.62/public/api/v1/merchant/v4/posAddPoint";
		    		URL url = new URL(requestUrl);
		    		HttpURLConnection uc = (HttpURLConnection)url.openConnection();
		    		uc.setDoOutput( true );
		    		uc.setInstanceFollowRedirects( false );
		    		uc.setRequestMethod("POST");
		    		uc.setRequestProperty("Content-Type", "application/json");
		    		
		    		
		    		uc.setRequestProperty("merchantid","$2y$10$utAZUJrV.TpXSh1Go.dhtuFCqP8hlGAxftltCRwvTxWY/sg8SzMVm");
		    		
		    		//Sending raw json data in the request body

		    		DataOutputStream dataoutput = new DataOutputStream(uc.getOutputStream());
		    		dataoutput .write(urlParameters.getBytes("UTF-8"));
		    		dataoutput .flush();
		    			    		
		    		urlresponse = uc.getResponseMessage();	    		
		    	    System.out.println(uc.getResponseCode());
		    		System.out.println(uc.getResponseMessage());
		    		System.out.println(uc.getErrorStream());
		    		
		    		
		    		uc.disconnect();
		    		} catch (UnsupportedEncodingException e) {
		    			
		    			e.printStackTrace();
		    		} catch (MalformedURLException e) {
		    			
		    			e.printStackTrace();
		    		} catch (IOException e) {
		    			
		    			e.printStackTrace();
		    		}
		     
		    	}
		out.print(urlresponse);
		out.flush();
		
	}*/

 
 
 @RequestMapping(value = "/addadvorderitempost", method = RequestMethod.POST)
 public void addOrderItemPost(@RequestBody String menuItemString, HttpSession session, HttpServletResponse response,
     HttpServletRequest request) throws IOException {
   // logger.debug("in addorderitem...{},{},{},{},{},{},{},{}", itId,
   // itName, itPrice, disc, vat, serviceTax, promoFlag, promoValue);
   Customer customer;
   System.out.println("menuItemString=" + menuItemString);

   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     /*
      * request.setCharacterEncoding("UTF-8");
      * response.setContentType("charset=utf-8");
      * response.setCharacterEncoding("UTF-8");
      */
     Gson gson = new GsonBuilder().create();
     MenuItem menuItem = gson.fromJson(menuItemString, new TypeToken<MenuItem>() {
     }.getType());
     double netPrice = menuItem.getPrice() - (menuItem.getPrice() * (menuItem.getPromotionValue()) / 100);
     System.out.println("menuItem.getName()=" + menuItem.getName());
     /*
      * menuItem.setId(itId); menuItem.setName(itName);
      * menuItem.setPrice(itPrice); menuItem.setServiceTax(serviceTax);
      * menuItem.setVat(vat); menuItem.setPromotionFlag(promoFlag);
      * menuItem.setPromotionValue(promoValue);
      */
     int itemQty = 1;
     OrderItem orderItem = new OrderItem();
     orderItem.setId(0);
     orderItem.setItemId(menuItem.getId());
     orderItem.setOrderId(0);
     orderItem.setItemName(menuItem.getName());
     orderItem.setQuantityOfItem("" + itemQty);
     orderItem.setRate(menuItem.getPrice());
     orderItem.setDiscount(String.valueOf(menuItem.getPromotionValue()));
     orderItem.setVat(menuItem.getVat());
     orderItem.setServiceTax(menuItem.getServiceTax());
     orderItem.setItem(menuItem);
     System.out.println("orderItem.getItemName()=" + orderItem.getItemName());
     // orderitemList = upadteOrderItemList(orderItem, orderitemList);
     // modifiedOrderitemList.addAll(existingOrderitemList1);
     // modifiedOrderitemList.addAll(orderitemList);
     List<OrderItem> orderitemlist = upadteOrderItemList(orderItem,
         (List<OrderItem>) session.getAttribute("orderitemList1"));
     session.setAttribute("orderitemList1", orderitemlist);
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("existingOrderitemList1"));
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("orderitemList1"));
     for (OrderItem orderItem2 : modifiedOrderitemList) {
       System.out.println("orderItem2.getItemName()=" + orderItem2.getItemName());
     }
     out.print(gson.toJson(modifiedOrderitemList, new TypeToken<List<OrderItem>>() {
     }.getType()));
     out.flush();
     // session.setAttribute("sesorderitemList", orderitemList);

   }
 }
 
 public synchronized List<OrderItem> upadteOrderItemList(OrderItem orderItem, List<OrderItem> ordeList) {
   boolean isPresent = true;
   if (ordeList.size() > 0) {
     for (OrderItem items : ordeList) {
       if (items.getItemId() == orderItem.getItemId()) {
         isPresent = false;
         int qty = Integer.parseInt(items.getQuantityOfItem()) + 1;
         items.setQuantityOfItem("" + qty);
       } else {

       }
     }
     if (isPresent) {
       ordeList.add(orderItem);
     }
     return ordeList;
   } else {
     ordeList.add(orderItem);
     return ordeList;
   }

 }
 
 
 
 @RequestMapping(value = "/increaseitemqty/{itemId}", method = RequestMethod.GET)
 public void increaseOrderItem(@PathVariable("itemId") int itemId, HttpSession session, HttpServletResponse response)
     throws IOException {
   logger.debug("in increaseitemquantity...{}", itemId);
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     
     for (OrderItem items : (List<OrderItem>) session.getAttribute("orderitemList1")) {
       if (items.getItemId() == itemId) {
         int qty = Integer.parseInt(items.getQuantityOfItem()) + 1;
         items.setQuantityOfItem("" + qty);
       }
     }
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("existingOrderitemList1"));
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("orderitemList1"));
     out.print(new Gson().toJson(modifiedOrderitemList, new TypeToken<List<OrderItem>>() {
     }.getType()));
     out.flush();
   }
 }
 
 @RequestMapping(value = "/decreaseitemqty/{itemId}", method = RequestMethod.GET)
 public void decreaseOrderItem(@PathVariable("itemId") int itemId, HttpSession session, HttpServletResponse response)
     throws IOException {
   logger.debug("in decreaseitemquantity...{}", itemId);
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     
     if (((List<OrderItem>) session.getAttribute("orderitemList1")).size() > 0) {
       for (int i = 0; i < ((List<OrderItem>) session.getAttribute("orderitemList1")).size(); i++) {
         if (((List<OrderItem>) session.getAttribute("orderitemList1")).get(i).getItemId() == itemId) {
           int qty = Integer.parseInt(
               ((List<OrderItem>) session.getAttribute("orderitemList1")).get(i).getQuantityOfItem());
           qty = qty - 1;
           if (qty == 0) {
             ((List<OrderItem>) session.getAttribute("orderitemList1")).remove(i);
           } else
             ((List<OrderItem>) session.getAttribute("orderitemList1")).get(i)
                 .setQuantityOfItem("" + qty);
         }
       }
     }
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("existingOrderitemList1"));
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("orderitemList1"));
     out.print(new Gson().toJson(modifiedOrderitemList, new TypeToken<List<OrderItem>>() {
     }.getType()));
     out.flush();
     
   }
 }

 @RequestMapping(value = "/manualitemqty/{newqty}/{itemId}", method = RequestMethod.GET)
 public void enterManualQuantity(@PathVariable("newqty") int qty, @PathVariable("itemId") int itemId,
     HttpSession session, HttpServletResponse response) throws IOException {
   logger.debug("in entermanualitemquantity...{},{}", qty, itemId);
   // System.out.println("qty:"+qty+":itemid:"+itemId);
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     
     for (OrderItem items : (List<OrderItem>) session.getAttribute("orderitemList1")) {
       if (items.getItemId() == itemId) {
         items.setQuantityOfItem("" + qty);
       }
     }
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("existingOrderitemList1"));
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("orderitemList1"));
     out.print(new Gson().toJson(modifiedOrderitemList, new TypeToken<List<OrderItem>>() {
     }.getType()));
     out.flush();

   }

 }
 
 @RequestMapping(value = "/deleteitms/{selectedRows}", method = RequestMethod.GET)
 public void deleteItems(@PathVariable("selectedRows") String[] selectedItems, HttpSession session,
     HttpServletResponse response) throws IOException {
   logger.debug("in deleteItems...{}", selectedItems.toString());
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     
     if (((List<OrderItem>) session.getAttribute("orderitemList1")).size() > 0) {
       for (int i = 0; i < ((List<OrderItem>) session.getAttribute("orderitemList1")).size(); i++) {
         for (int j = 0; j < selectedItems.length; j++) {
           if (((List<OrderItem>) session.getAttribute("orderitemList1")).get(i).getItemId() == Integer
               .parseInt(selectedItems[j])) {
             ((List<OrderItem>) session.getAttribute("orderitemList1")).remove(i);
           }
         }
       }
     }
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("existingOrderitemList1"));
     modifiedOrderitemList.addAll((List<OrderItem>) session.getAttribute("orderitemList1"));
     out.print(new Gson().toJson(modifiedOrderitemList, new TypeToken<List<OrderItem>>() {
     }.getType()));
     out.flush();
   }
 }

 
 @RequestMapping(value = "/clearordersession", method = RequestMethod.GET)
 public void clearOrderSession( HttpSession session, HttpServletResponse response) throws IOException {
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     
      List<OrderItem> existingorderitem = new ArrayList<OrderItem>();
      existingorderitem=(List<OrderItem>) session.getAttribute("existingOrderitemList1");
      List<OrderItem> neworderitem = new ArrayList<OrderItem>();
      neworderitem=(List<OrderItem>) session.getAttribute("orderitemList1");
      if (existingorderitem.size()>0) {
           existingOrderitemList1 = new ArrayList<OrderItem>();
           session.setAttribute("existingOrderitemList1", existingOrderitemList1);
     }
     if (neworderitem.size()>0) {
            orderitemList1 = new ArrayList<OrderItem>();
            session.setAttribute("orderitemList1", orderitemList1);
     }
     out.flush();
   }
 }
 
 
 
 
 
 @RequestMapping(value = "/getorder/{orderno}", method = RequestMethod.GET)
 public void getOrder(@PathVariable("orderno") String orderno, HttpSession session,
     HttpServletResponse response) throws IOException {
   logger.debug("in getOrder...{}", orderno);
   Customer customer;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
     PrintWriter out = response.getWriter();
     response.setContentType("text/plain");
     String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
     Order order = orderService.getUnpaidOrderByOrderNo(orderno, customer.getStoreId(), selLang);
     session.setAttribute("existingOrderitemList1", getOrderItemList(order));
     out.print(gson.toJson(order));
     out.flush();
   }
 }

 
 public List<OrderItem> getOrderItemList(Order order) {
   List<OrderItem> orderitemlist = new ArrayList<OrderItem>();
   // Order order=table.getOrder();
   if (order != null) {
     for (OrderItem orderitems : order.getOrderitem()) {
       orderitems.setIsinOrder("Y");
       orderitems.setItemName(orderitems.getItem().getName());
       orderitems.setDiscount("" + orderitems.getItem().getPromotionValue());
       orderitemlist.add(orderitems);
     }
     return orderitemlist;
   } else
     return orderitemlist;
 }
 
 
 
 
 
 
 
 
 
 
}
