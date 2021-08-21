package com.sharobi.webpos.inv.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ReturnTypes;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.inv.model.InventoryReturn;
import com.sharobi.webpos.inv.model.InventoryReturnItem;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.PurchaseReturnService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

/**
 *
 *
 */

@Controller
@RequestMapping("/purchasereturn")
public class PurchaseReturnController {
	 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 private final static Logger logger = LogManager.getLogger(PurchaseReturnController.class);
	 private final static InventoryService inventoryService = new InventoryService();
	 private final static OrderService orderService = new OrderService();
	 private final static PurchaseReturnService purchaseReturnService = new PurchaseReturnService();
	 private final static StoreService storeService = new StoreService();

	 @RequestMapping(value = "/loadpurchasereturn", method = RequestMethod.GET)
	 public ModelAndView loadSimplePurchaseReturnPage(Model model,HttpSession session,
	                                                  HttpServletRequest request) throws ParseException 
	 {
	      logger.debug("In loadSimplePurchaseReturnPage......");
	      Customer customer = null;
		  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
		      return mav;
		     }
		  Date currDate = new Date();
		  ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_PURCHASE_RETURN_PAGE);
		  List < InventoryReturn > inventoryReturnList = purchaseReturnService.getPurchaseReturnByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		  logger.debug("Fetched returnlist :: {}", inventoryReturnList);
		  List < InventoryVendors > vendorList = inventoryService.getVendors(customer.getStoreId());
		  logger.debug("Fetched vendorList :: {}", vendorList);
		  mav.addObject("vendorList", vendorList);
		  mav.addObject("inventoryPurchaseReturnList", inventoryReturnList);
		  List < ReturnTypes > returntypelist = orderService.getAllReturntypes(customer.getStoreId());
		  List < ReturnTypes > filteredreturntypelist = new ArrayList < ReturnTypes > ();
		
		  for (ReturnTypes ob: returntypelist) {
		       if (ob.getType().equals("PUR")) {
		           filteredreturntypelist.add(ob);
		           }
		     }
		  mav.addObject("reasons", filteredreturntypelist);
		  session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(filteredreturntypelist).toString());
	      Date currdate = new Date();
		  String date = dateFormat.format(currdate);
		  Date today = dateFormat.parse(date);
		  mav.addObject("today", today);
		  mav.addObject(Constants.ACTIVE_INVENTORY, "Y");
		/*Store store = storeService.getStoreById(customer.getStoreId());
		  System.out.println("___is_acc_in order___" + store.getIs_account());
		  mav.addObject("is_acc", store.getIs_account());*/
		  return mav;
	 }
	 @RequestMapping(value = "/createorupdatepurchasereturn", method = RequestMethod.POST)
	 public void createOrUpdatePurchaseReturn(@RequestBody String purchaseReturn,
	                                            HttpSession session,
	                                            HttpServletResponse response) throws IOException, ParseException 
	 {
	      logger.debug("in createOrUpdatePurchaseReturn...{}", purchaseReturn);
		  Customer customer;
		  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		      Date date1 = null;
		      PrintWriter out = response.getWriter();
		      response.setContentType("text/plain");
		      Gson gson = new Gson();
		      InventoryReturn invreturn = gson.fromJson(purchaseReturn, new TypeToken < InventoryReturn > () {}.getType());
		      if (invreturn.getId() == 0) {
			      for (InventoryReturnItem returnitems: invreturn.getInventoryReturnItems()) {
			    	  returnitems.setCreatedBy(customer.getContactNo());
			    	  date1 = new SimpleDateFormat("yyyy-MM-dd").parse(returnitems.getCreatedDate());
			      	}
			      invreturn.setUserId(customer.getContactNo());
			      invreturn.setCreatedBy(customer.getContactNo());
			      invreturn.setCreatedDate(dateFormat.format(date1));
			      purchaseReturnService.saveNewPurchaseReturn(invreturn);
				 } else {
			    String returnid = String.valueOf(invreturn.getId());
			    InventoryReturn invitemreturndata = purchaseReturnService.getPurchaseReturnByReturnId(customer.getStoreId(), returnid);
			    for (InventoryReturnItem newreturnitems: invreturn.getInventoryReturnItems()) {
			    	newreturnitems.setCreatedBy(invitemreturndata.getCreatedBy());
			    	newreturnitems.setCreatedDate(invitemreturndata.getCreatedDate());
			    	date1 = new SimpleDateFormat("yyyy-MM-dd").parse(newreturnitems.getUpdatedDate());
			    	}
			    invreturn.setCreatedBy(invitemreturndata.getCreatedBy());
			    invreturn.setCreatedDate(invitemreturndata.getCreatedDate());
			    invreturn.setUpdatedBy(customer.getContactNo());
			    invreturn.setUpdatedDate(dateFormat.format(date1));
			    purchaseReturnService.updatePurchaseReturn(invreturn);
				}
		   out.print("success");
		   out.flush();
		  }
	 }
	 @RequestMapping(value = "/getpurchaseReturndetailsbyidanddate/{returnid}/{date}", method = RequestMethod.GET)
	 public ModelAndView getpurchaseReturnDetailsByIdandDate(
			 @PathVariable("returnid") String returnid,
			 @PathVariable("date") String date,
			 Model model,
			 HttpSession session,
			 HttpServletRequest request,
			 HttpServletResponse response
			 ) throws ParseException, IOException 
	 {
		  logger.debug("In getpurchaseReturnDetailsByIdandDate......{},{}", returnid, date);
		  Customer customer = null;
		  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			   ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			   return mav;
		  }
		  InventoryReturn invitemreturndata = purchaseReturnService.getPurchaseReturnByReturnId(
				  customer.getStoreId(), 
				  returnid.trim()
				  );
		  logger.debug("return in controller :: {}", invitemreturndata);
		  PrintWriter out = response.getWriter();
		  response.setContentType("application/json");
		  out.print(new Gson().toJson(invitemreturndata).toString());
		  return null;
	}

	 @RequestMapping(value = "/getPurchaseReturndetailsbydate/{date}", method = RequestMethod.GET)
	 public ModelAndView getPurchaseReturnsDate(
			@PathVariable("date") String date,
            Model model,
            HttpSession session,
            HttpServletRequest request,
            HttpServletResponse response
            ) throws ParseException, IOException 
	 {
		 logger.debug("In getPurchaseReturnsDate......{}", date);
		 Customer customer = null;
		 if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			 ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			 return mav;
	  		}
		 ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_PURCHASE_RETURN_PAGE);
		 List < InventoryReturn > inventoryReturnList = purchaseReturnService.getPurchaseReturnByDate(
				 customer.getStoreId(), 
				 date
				 );
		 logger.debug("Fetched returnlist :: {}", inventoryReturnList);
		 List < InventoryVendors > vendorList = inventoryService.getVendors(customer.getStoreId());
		 logger.debug("Fetched vendorList :: {}", vendorList);
		 mav.addObject("vendorList", vendorList);
		 mav.addObject("inventoryPurchaseReturnList", inventoryReturnList);
		 List < ReturnTypes > returntypelist = orderService.getAllReturntypes(customer.getStoreId());
		 List < ReturnTypes > filteredreturntypelist = new ArrayList < ReturnTypes > ();
		 for (ReturnTypes ob: returntypelist) 
		 {
			 if (ob.getType().equals("PUR")) 
			 {
				 filteredreturntypelist.add(ob);
			 }

		 }
		 mav.addObject("reasons", filteredreturntypelist);
		 session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(filteredreturntypelist).toString());
		 Date today = dateFormat.parse(date);
		 mav.addObject("today", today);
		 mav.addObject(Constants.ACTIVE_INVENTORY, "Y");
		 return mav;
	 }



	 @RequestMapping(value = "/purchasereturnclosed", method = RequestMethod.POST)
	 public ModelAndView purchaseReturnClosed(
			 @RequestParam String purchaseReturnId,
			 @RequestBody String invReturn,
			 Model model,
			 HttpSession session,
			 HttpServletResponse response
			 ) throws ParseException, IOException
	 {
	  logger.debug("In purchaseReturnClosed......{}", purchaseReturnId);
	  Customer customer = null;
	  	  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	  		  ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	  		  return mav;
	  	  }
	  PrintWriter out = response.getWriter();
	  response.setContentType("text/plain");
	  Gson gson = new Gson();
	  InventoryReturn inventoryReturn = gson.fromJson(invReturn, new TypeToken < InventoryReturn > () {}.getType());
	  inventoryReturn.setId(Integer.parseInt(purchaseReturnId));
	  /*Store store = storeService.getStoreById(customer.getStoreId());*/
	  /*inventoryReturn.setIs_account(store.getIs_account());
	  inventoryReturn.setQs(Constants.PURCHASE_RETURN_PAYMENT_QS);*/
	  inventoryReturn.setStoreId(customer.getStoreId());
	  System.out.println("___pur return___" + inventoryReturn.toString());
	  purchaseReturnService.purchaseReturnClosed(inventoryReturn);
	  out.print("success");
	  out.flush();
	  return null;
	 }


	 @RequestMapping(value = "/deletepurchasereturnbyid/{purchaseReturnId}",method = RequestMethod.GET)
	 public ModelAndView deletePurchaseReturnById(
			 @PathVariable("purchaseReturnId") String purchaseReturnId,
			 Model model,
			 HttpSession session,
			 HttpServletRequest request,
			 HttpServletResponse response
			 ) 
	 {
	  logger.debug("In deletePurchaseReturnById by purchaseReturnId......{}", purchaseReturnId);
	  Customer customer = null;
	  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		  ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
		  return mav;
	  	}
	  try {
		  String wsResponse = purchaseReturnService.deletePurchaseReturnById(purchaseReturnId, customer.getStoreId());
		  logger.debug("Response : " + wsResponse);
		  PrintWriter out;
		  out = response.getWriter();
		  response.setContentType("text/plain");
		  out.print(wsResponse);
		  out.flush();
		  return null;
	  	 } catch (IOException e) {
	  		 return null;
	  	 }
	
	 }

 }