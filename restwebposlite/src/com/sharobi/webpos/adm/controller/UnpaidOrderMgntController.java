package com.sharobi.webpos.adm.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.base.controller.UnpaidOrderController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.UnpaidOrderService;
import com.sharobi.webpos.adm.service.AdminUnpaidOrderService;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.vfd.Display;

@Controller
@RequestMapping("/unpaidorderlist")
public class UnpaidOrderMgntController {

	private final static Logger logger=LogManager.getLogger(UnpaidOrderController.class);
	private final static AdminUnpaidOrderService unpaidorderService=new AdminUnpaidOrderService();
	private final static OrderService orderService = new OrderService();
	
	@RequestMapping(value="/loadunpaidorder",method=RequestMethod.GET)
	public ModelAndView loadUnapidOrder(Model model, HttpSession session)
	{
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			
			return mav;
		}
				
		List<Order> allunpaidOrderList=unpaidorderService.getAllUnpaidOrderList(customer.getStoreId(), getTodayDate());
		session.setAttribute(Constants.ALL_UNPAIDORDER_LIST_ADMIN, allunpaidOrderList);
		mav.addObject("allunpaidOrderList",allunpaidOrderList);
		mav.addObject("currentTable", '0');
		//mav.addObject("date", getTodayDate());
		Gson gson = new Gson();
		System.out.println("data:"+gson.toJson(allunpaidOrderList));
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_UNPAID_ORDER_MGNT_PAGE);
		
		
		
	/*	
		List<Order> allunpaidOrderList=unpaidorderService.getAllUnpaidOrderList(customer.getStoreId(), getTodayDate());
		session.setAttribute(Constants.ALL_UNPAIDORDER_LIST_ADMIN, allunpaidOrderList);
		mav.addObject("allunpaidOrderList",allunpaidOrderList);
		mav.addObject("currentTable", '0');
		//mav.addObject("date", getTodayDate());
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_UNPAID_ORDER_MGNT_PAGE);*/
		
		
		
		
		
		
		return mav;
	}
	
	@RequestMapping(value = "/unpaidorderspecificdate",
			method = RequestMethod.GET)
	public ModelAndView unpaidorderspecificdate(@RequestParam String storeId,
			   @RequestParam String fromdate, @RequestParam String todate,
			//   @PathVariable("storeId") String storeId,
//			      @PathVariable("date") String date,
			      HttpSession session,
			      HttpServletResponse response) throws IOException {
			 
			 logger.debug("In loadUnapidOrder......");
			 ModelAndView mav = new ModelAndView();
			 Customer customer=null;
			// String pattern = "yyyy-MM-dd";
			// Date date1 = null;
			// SimpleDateFormat format = new SimpleDateFormat(pattern);
			// try {
			//  date1 = format.parse(date);
			//  System.out.println(date1);
			// } catch (ParseException e) {
			//  e.printStackTrace();
			// }
			 if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			  
			  mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			  return mav;
			 }
			 List<Order> allunpaidOrderList=unpaidorderService.getAllUnpaidOrderListPeriodWise(customer.getStoreId(), fromdate, todate);
			 session.setAttribute(Constants.ALL_UNPAIDORDER_LIST_ADMIN, allunpaidOrderList);
			 mav.addObject("allunpaidOrderList",allunpaidOrderList);
			 mav.addObject("fromdate", fromdate);
			 mav.addObject("todate", todate);
			 logger.debug("allunpaidOrderList in controller :: {}", allunpaidOrderList);
			 mav.addObject("currentTable", '0');
			 mav.addObject(Constants.ADMIN,"Y");

			 mav.setViewName(ForwardConstants.VIEW_UNPAID_ORDER_MGNT_PAGE);
			 return mav;
			 }
	/*public ModelAndView addMenuItems(@RequestParam String storeId,
			@RequestParam String date,	
//			@PathVariable("storeId") String storeId,
//						@PathVariable("date") String date,
						HttpSession session,
						HttpServletResponse response) throws IOException {
	
	logger.debug("In loadUnapidOrder......");
	ModelAndView mav = new ModelAndView();
	Customer customer=null;
//	String pattern = "yyyy-MM-dd";
//	Date date1 = null;
//	SimpleDateFormat format = new SimpleDateFormat(pattern);
//	try {
//		date1 = format.parse(date);
//		System.out.println(date1);
//	} catch (ParseException e) {
//		e.printStackTrace();
//	}
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	List<Order> allunpaidOrderList=unpaidorderService.getAllUnpaidOrderList(customer.getStoreId(), date);
	session.setAttribute(Constants.ALL_UNPAIDORDER_LIST_ADMIN, allunpaidOrderList);
	mav.addObject("allunpaidOrderList",allunpaidOrderList);
	System.out.println("given date - "+date);
	mav.addObject("date", date);
	logger.debug("allunpaidOrderList in controller :: {}", allunpaidOrderList);
	mav.addObject("currentTable", '0');
	mav.addObject(Constants.ADMIN,"Y");

	mav.setViewName(ForwardConstants.VIEW_UNPAID_ORDER_MGNT_PAGE);
	return mav;
	}*/
		
	@RequestMapping(value = "/getpaymentinfo/{orderno}", method = RequestMethod.GET)
	public void getPaymentInfo(@PathVariable("orderno") String orderno,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in getpaymentinfo...{}", orderno);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getPaymentInfo(NumberUtils.toInt(orderno)));
			out.flush();
		}
	}
	

	@RequestMapping(value = "/getpaymenttypebystore", method = RequestMethod.GET)
	public void getPaymentTypeByStore(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in getPaymentTypeByStore...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getPaymentTypeByStore(customer.getStoreId()));
			out.flush();
		}
	}
	
	@RequestMapping(value = "/showvfdpay/{row1}/{row2}", method = RequestMethod.GET)
	public void showcustomerpayDisplay(@PathVariable("row1") String row1,
			@PathVariable("row2") String row2, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in showvfd...{},{}", row1, row2);
		Store store;
		store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		if (store != null) {
			Display display = new Display(store.getCustomerDisplay());
			display.vfdpayClient(store.getCustomerDisplay(), row1, row2);
		}
	}
	
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
