/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ReturnTypes;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Bill;
import com.sharobi.webpos.base.model.BillSplitManual;
import com.sharobi.webpos.base.model.BillSplitManual_duplicate;
import com.sharobi.webpos.base.model.CommonBean;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Discount;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.model.StoreCustomers;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.vfd.Display;


@Controller
@RequestMapping("/order")
public class OrderController {
	private final static Logger logger = LogManager
			.getLogger(OrderController.class);
	private final static MenuService menuService = new MenuService();
	private final static OrderService orderService = new OrderService();
	private final static MenuMgntService menumgntService = new MenuMgntService();
	private final static StoreService storeService = new StoreService();

	List<OrderItem> orderitemList = null;
	List<OrderItem> orderitemListSplitted = null;
	List<OrderItem> existingOrderitemList = null;
	List<OrderItem> existingOrderitemListSplitBill = null;
	Set<Menu> existingMenuCategoryWise = null;
	List<Menu> existingMenuSplitBillCategoryWise = null;

	@RequestMapping(value = "/vieworder", method = RequestMethod.GET)
	public ModelAndView loadOrderTaking(@RequestParam String ono,
			@RequestParam String tno, @RequestParam String sno, Model model,
			HttpSession session) {
		long st = System.currentTimeMillis();
		logger.debug("In order taking......" + ono + ":" + tno + ":" + sno);

		orderitemList = new ArrayList<OrderItem>();
		existingOrderitemList = new ArrayList<OrderItem>();
		// avoid order item merging
		session.setAttribute("orderitemList", orderitemList);
		session.setAttribute("existingOrderitemList", existingOrderitemList);
		// end avoid order item merging
		ModelAndView mav = new ModelAndView();
		Order orderObj = null;
		Customer customer = null;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		if (ono.equals("x") && tno.equals("x")) {
			mav.addObject("directorderTaking", ono + tno);
		} else {
			// List<Order>
			// unpaidOrderList=orderService.getUnpaidOrderList(customer.getStoreId(),
			// getTodayDate());
			// session.setAttribute(Constants.ALL_UNPAIDORDER_LIST,
			// unpaidOrderList);
			Menu menu = (Menu) session.getAttribute(Constants.MENU_ALL_TREE);
			if (menu == null) {
				System.out.println("inside if");
				Menu allMenuList = menuService.getAllMenuList(
						customer.getStoreId(), session);
				session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
				mav.addObject("allmenu", allMenuList);
				mav.addObject("firsttimecall", "Y");
			} else {
				System.out.println("inside else");
				mav.addObject("allmenu", menu);
			}
			// mav.addObject("tableNo",tno);
			// session.setAttribute("tableNo", tno);
			
			//By SAYANI
			System.out.println("inside else"+ customer.getStoreId());
			List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
			if (orderTypeList.size() > 0) {
				for (OrderType orderType : orderTypeList) {
					if (orderType.getId() == Integer.parseInt(ono)) {
						mav.addObject("orderType", orderType);
						//mav.addObject("orderTypeList", orderType);
						//existingOrderitemList = getOrderItemList(orders);
					//	session.setAttribute("existingOrderitemList", getOrderItemList(orders));
					//	orderObj=new OrderType();
					//	orderObj=orderType;
			 
						break;
					}
				}
			}
			
			mav.addObject("orderTypeName", tno);
		//	mav.addObject("currentSeat", sno.equals("") ? "0" : sno);
			session.setAttribute(Constants.ALL_ORDERTYPE_LIST, orderTypeList);
			
			List<Order> orderList = orderService.getUnpaidOrderList(
					customer.getStoreId(), getTodayDate());// (List<Order>)
															// session.getAttribute(Constants.ALL_UNPAIDORDER_LIST);
			if (orderList != null && orderList.size() > 0) {
				for (Order orders : orderList) {
					if (orders.getId() == Integer.parseInt(ono)) {
						setDiscountFlag(orders);
						setPaidAmt(orders);
						mav.addObject("orders", orders);
						session.setAttribute("existingOrderitemList",getOrderItemList(orders));
						/*List<OrderItem> packingitemlist = new ArrayList<OrderItem>();
						for (OrderItem orderitems : orders.getOrderitem()) {
							if(StringUtils.containsIgnoreCase(orderitems.getItem().getName(), "bowl"))
							{
								packingitemlist.add(orderitems);
								orders.getOrderitem().remove(orderitems);
							}
							
						}
						orders.setPackingitem(packingitemlist);*/
						
						orderObj = new Order();
						orderObj = orders;

						break;
					}
				}
			}
			mav.addObject("currentTable", tno);
			mav.addObject("currentSeat", sno.equals("") ? "0" : sno);
			session.setAttribute(Constants.ALL_UNPAIDORDER_LIST, orderList);
		}
		mav.setViewName(ForwardConstants.VIEW_ORDER_PAGE);
		if (orderObj != null) {
			try {
				DecimalFormat df = new DecimalFormat("00.00");
				showcustomerDisplayTOT(
						"TOT IN RM : "
								+ df.format(orderObj.getOrderBill()
										.getGrossAmt()), "", session);
			} catch (IOException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// advance booking list
	/*	List<Order> bookingList=orderService.getAllPreBookingList(customer.getStoreId());
		mav.addObject("noofpreorder",bookingList.size());*/
		String ordercount=orderService.getCountOfAdvanceBooking(customer.getStoreId());
		mav.addObject("noofpreorder",ordercount);
		
		
		long et = System.currentTimeMillis();
		System.out.println("Elapsed time in webpos for ordertaking:"
				+ (et - st));
		mav.addObject(Constants.ORDER_TAKING, "Y");
		return mav;
	}
	
	@RequestMapping(value = "/updateprintcount",
			method = RequestMethod.POST)
public void updatePrintCount(	@RequestBody String commstring,
							HttpSession session,
							HttpServletResponse response) throws IOException {
logger.debug("in updatePrintCount...{}", commstring);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	Gson gson = new Gson();
	CommonBean commonBean = gson.fromJson(commstring, new TypeToken<CommonBean>() {}.getType());
	String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
	commonBean.setStoreId(customer.getStoreId());
	commonBean.setLang(selLang);
	String res = orderService.updatePrintCountWithReason(commonBean);
	out.print(res);
	out.flush();
}
}

	@RequestMapping(value = "/vieworders", method = RequestMethod.GET)
	public ModelAndView loadOrderTakings(@RequestParam String ono,
			@RequestParam String tno, @RequestParam String sno,
			@RequestParam String itcno, @RequestParam String flg,
			@RequestParam String ptype, Model model, HttpSession session) {
		logger.debug("In order taking......" + ono + ":" + tno + ":" + sno
				+ ":" + itcno + ":" + flg + ":" + ptype);
		orderitemList = new ArrayList<OrderItem>();
		existingOrderitemList = new ArrayList<OrderItem>();
		// avoid order item merging
		session.setAttribute("orderitemList", orderitemList);
		session.setAttribute("existingOrderitemList", existingOrderitemList);
		// end avoid order item merging
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		if (ono.equals("x") && tno.equals("x")) {
			mav.addObject("directorderTaking", ono + tno);
		} else {
			Menu allMenuList = menuService.getAllMenuList(
					customer.getStoreId(), session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
			mav.addObject("allmenu", allMenuList);
			// mav.addObject("tableNo",tno);
			// session.setAttribute("tableNo", tno);
			List<Order> orderList = orderService.getUnpaidOrderList(
					customer.getStoreId(), getTodayDate());// (List<Order>)
															// session.getAttribute(Constants.ALL_UNPAIDORDER_LIST);
			if (orderList.size() > 0) {
				for (Order orders : orderList) {
					if (orders.getId() == Integer.parseInt(ono)) {
						setDiscountFlag(orders);
						setPaidAmt(orders);
						mav.addObject("orders", orders);
						// existingOrderitemList = getOrderItemList(orders);
						session.setAttribute("existingOrderitemList",
								getOrderItemList(orders));
					}
				}
			}
			mav.addObject("currentTable", tno);
			mav.addObject("currentSeat", sno.equals("") ? "0" : sno);
			mav.addObject("itcatno", itcno);
			mav.addObject("itcatno", itcno);
			mav.addObject("flag", flg);
			mav.addObject("ptype", ptype);
		}
		mav.setViewName(ForwardConstants.VIEW_ORDER_PAGE);
		mav.addObject(Constants.ORDER_TAKING, "Y");
		return mav;
	}

	@RequestMapping(value = "/vieworderHD", method = RequestMethod.GET)
	public ModelAndView loadOrderTakingHD(@RequestParam String ono,
			@RequestParam String tno, @RequestParam String sno,
			@RequestParam String ot, Model model, HttpSession session) {
		long st = System.currentTimeMillis();
		logger.debug("In order taking......" + ono + ":" + tno + ":" + sno
				+ ":" + ot);
		orderitemList = new ArrayList<OrderItem>();
		existingOrderitemList = new ArrayList<OrderItem>();
		// avoid order item merging
		session.setAttribute("orderitemList", orderitemList);
		session.setAttribute("existingOrderitemList", existingOrderitemList);
		// end avoid order item merging
		ModelAndView mav = new ModelAndView();
		Order orderObj = null;
		Customer customer = null;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		if (ono.equals("x") && tno.equals("x")) {
			mav.addObject("directorderTaking", ono + tno);
		} else {
			Menu allMenuList = menuService.getAllMenuList(
					customer.getStoreId(), session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
			mav.addObject("allmenu", allMenuList);
			// mav.addObject("tableNo",tno);
			// session.setAttribute("tableNo", tno);
			List<Order> orderList = orderService.getUnpaidOrderList(
					customer.getStoreId(), getTodayDate());// (List<Order>)
															// session.getAttribute(Constants.ALL_UNPAIDORDER_LIST);
			if (orderList.size() > 0) {
				for (Order orders : orderList) {
					if (orders.getId() == Integer.parseInt(ono)) {
						setDiscountFlag(orders);
						setPaidAmt(orders);
						mav.addObject("orders", orders);
						// existingOrderitemList = getOrderItemList(orders);
						session.setAttribute("existingOrderitemList",
								getOrderItemList(orders));
						orderObj = new Order();
						orderObj = orders;
						break;
					}
				}
			}
			mav.addObject("currentTable", tno);
			mav.addObject("currentSeat", sno.equals("") ? "0" : sno);
			mav.addObject("orderType", ot);
		}
		mav.setViewName(ForwardConstants.VIEW_ORDER_PAGE);
		if (orderObj != null) {
			try {
				DecimalFormat df = new DecimalFormat("00.00");
				showcustomerDisplayTOT(
						"TOT IN RM : "
								+ df.format(orderObj.getOrderBill()
										.getGrossAmt()), "", session);
			} catch (IOException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		long et = System.currentTimeMillis();
		System.out.println("Elapsed time in webpos for ordertaking:"
				+ (et - st));
		mav.addObject(Constants.ORDER_TAKING, "Y");
		return mav;
	}

	@RequestMapping(value = "/getallunpaidorder", method = RequestMethod.GET)
	public void getAllUnpaidOrder() {

	}

	@RequestMapping(value = "/addorderitem/{itId}/{itName}/{itPrice}/{disc}/{vat}/{serviceTax}/{promoFlag}/{promoValue}", method = RequestMethod.GET)
	public void addOrderItem(@PathVariable("itId") int itId,
			@PathVariable("itName") String itName,
			@PathVariable("itPrice") double itPrice,
			@PathVariable("disc") String disc, @PathVariable("vat") double vat,
			@PathVariable("serviceTax") double serviceTax,
			@PathVariable("promoFlag") String promoFlag,
			@PathVariable("promoValue") int promoValue, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in addorderitem...{},{},{},{},{},{},{},{}", itId, itName,
				itPrice, disc, vat, serviceTax, promoFlag, promoValue);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			double netPrice = itPrice
					- (itPrice * Integer.parseInt(disc) / 100);
			MenuItem menuItem = new MenuItem();
			menuItem.setId(itId);
			menuItem.setName(itName);
			menuItem.setPrice(itPrice);
			menuItem.setServiceTax(serviceTax);
			menuItem.setVat(vat);
			menuItem.setPromotionFlag(promoFlag);
			menuItem.setPromotionValue(promoValue);
			int itemQty = 1;
			OrderItem orderItem = new OrderItem();
			orderItem.setId(0);
			orderItem.setItemId(itId);
			orderItem.setOrderId(0);
			orderItem.setItemName(itName);
			orderItem.setQuantityOfItem("" + itemQty);
			orderItem.setRate(itPrice);
			orderItem.setDiscount(disc);
			orderItem.setVat(vat);
			orderItem.setServiceTax(serviceTax);
			orderItem.setItem(menuItem);

			// orderitemList = upadteOrderItemList(orderItem, orderitemList);
			// modifiedOrderitemList.addAll(existingOrderitemList);
			// modifiedOrderitemList.addAll(orderitemList);
			List<OrderItem> orderitemlist = upadteOrderItemList(orderItem,
					(List<OrderItem>) session.getAttribute("orderitemList"));
			session.setAttribute("orderitemList", orderitemlist);
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));

			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
			// session.setAttribute("sesorderitemList", orderitemList);
		}
	}

	public synchronized List<OrderItem> upadteOrderItemList(
			OrderItem orderItem, List<OrderItem> ordeList) {
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

	@RequestMapping(value = "/increaseitemquantity/{itemId}", method = RequestMethod.GET)
	public void increaseOrderItem(@PathVariable("itemId") int itemId,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in increaseitemquantity...{}", itemId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			/*
			 * for (OrderItem items : orderitemList) { if (items.getItemId() ==
			 * itemId) { int qty = Integer.parseInt(items.getQuantityOfItem()) +
			 * 1; items.setQuantityOfItem("" + qty); } }
			 * modifiedOrderitemList.addAll(existingOrderitemList);
			 * modifiedOrderitemList.addAll(orderitemList);
			 */
			System.out.println("old list:" + new Gson().toJson(session.getAttribute("orderitemList")) );
			for (OrderItem items : (List<OrderItem>) session
					.getAttribute("orderitemList")) {
				if (items.getItemId() == itemId) {
					/*int qty = Integer.parseInt(items.getQuantityOfItem()) + 1;*/
					double qty = Double.parseDouble(items.getQuantityOfItem()) + 1;
					items.setQuantityOfItem("" + qty);
				}
			}
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
			// session.setAttribute("sesorderitemList", orderitemList);
		}
	}

	@RequestMapping(value = "/decreaseitemquantity/{itemId}", method = RequestMethod.GET)
	public void decreaseOrderItem(@PathVariable("itemId") int itemId,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in decreaseitemquantity...{}", itemId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			/*
			 * if (orderitemList.size() > 0) { for (int i = 0; i <
			 * orderitemList.size(); i++) { if (orderitemList.get(i).getItemId()
			 * == itemId) { int qty = Integer.parseInt(orderitemList.get(i)
			 * .getQuantityOfItem()); qty = qty - 1; if (qty == 0) {
			 * orderitemList.remove(i); } else
			 * orderitemList.get(i).setQuantityOfItem("" + qty); } } }
			 * modifiedOrderitemList.addAll(existingOrderitemList);
			 * modifiedOrderitemList.addAll(orderitemList);
			 */
			if (((List<OrderItem>) session.getAttribute("orderitemList"))
					.size() > 0) {
				for (int i = 0; i < ((List<OrderItem>) session
						.getAttribute("orderitemList")).size(); i++) {
					if (((List<OrderItem>) session
							.getAttribute("orderitemList")).get(i).getItemId() == itemId) {
						/*int qty = Integer.parseInt(((List<OrderItem>) session
								.getAttribute("orderitemList")).get(i)
								.getQuantityOfItem());*/
						double qty = Double.parseDouble(((List<OrderItem>) session
								.getAttribute("orderitemList")).get(i)
								.getQuantityOfItem());
						qty = qty - 1;
						if (qty <= 0) {
							((List<OrderItem>) session
									.getAttribute("orderitemList")).remove(i);
						} else
							((List<OrderItem>) session
									.getAttribute("orderitemList")).get(i)
									.setQuantityOfItem("" + qty);
					}
				}
			}
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
			// session.setAttribute("sesorderitemList", orderitemList);
		}
	}

	// new added  start 
	
	@RequestMapping(value = "/changeItemRate/{itemId}/{itemRate}", method = RequestMethod.GET)
	public void changeOrderitemRate(@PathVariable("itemId") int itemId,@PathVariable("itemRate") double itemRate,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		logger.debug("in changeItemRate...{}{}", itemId,itemRate);
		HttpSession session = request.getSession();		
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			if (((List<OrderItem>) session.getAttribute("orderitemList")).size() > 0) {
				for (OrderItem items : (List<OrderItem>) session.getAttribute("orderitemList")) {
					double newrate=0.0;
					if (items.getItemId() == itemId) {
						 if(customer.getStoreId() == 164 || customer.getStoreId() == 47){
							 double basePrice = itemRate / (1+((items.getVat()+items.getServiceTax())/100));
							 newrate = basePrice;
						 }else{
							 newrate = itemRate;
						 }
						 
						items.setRate(newrate);
					}
				}
				
			}
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
			// session.setAttribute("sesorderitemList", orderitemList);
		}
	  }
	
	
	// new added end
	
	
	@RequestMapping(value = "/manualitemquantity/{newqty}/{itemId}", method = RequestMethod.GET)
	public void enterManualQuantity(@PathVariable("newqty") double qty,
			@PathVariable("itemId") int itemId, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in entermanualitemquantity...{},{}", qty, itemId);
		// System.out.println("qty:"+qty+":itemid:"+itemId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			/*
			 * for (OrderItem items : orderitemList) { if (items.getItemId() ==
			 * itemId) { items.setQuantityOfItem("" + qty); } }
			 * modifiedOrderitemList.addAll(existingOrderitemList);
			 * modifiedOrderitemList.addAll(orderitemList);
			 */
			for (OrderItem items : (List<OrderItem>) session
					.getAttribute("orderitemList")) {
				if (items.getItemId() == itemId) {
					items.setQuantityOfItem("" + qty);
				}
			}
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();

		}

	}

	@RequestMapping(value = "/deleteitems/{selectedRows}", method = RequestMethod.GET)
	public void deleteItems(
			@PathVariable("selectedRows") String[] selectedItems,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in deleteItems...{}", selectedItems.toString());
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			/*
			 * if (orderitemList.size() > 0) { for (int i = 0; i <
			 * orderitemList.size(); i++) { for (int j = 0; j <
			 * selectedItems.length; j++) { if (orderitemList.get(i).getItemId()
			 * == Integer .parseInt(selectedItems[j])) {
			 * orderitemList.remove(i); } } } }
			 * modifiedOrderitemList.addAll(existingOrderitemList);
			 * modifiedOrderitemList.addAll(orderitemList);
			 */
			if (((List<OrderItem>) session.getAttribute("orderitemList"))
					.size() > 0) {
				for (int i = 0; i < ((List<OrderItem>) session
						.getAttribute("orderitemList")).size(); i++) {
					for (int j = 0; j < selectedItems.length; j++) {
						if (((List<OrderItem>) session
								.getAttribute("orderitemList")).get(i)
								.getItemId() == Integer
								.parseInt(selectedItems[j])) {
							((List<OrderItem>) session
									.getAttribute("orderitemList")).remove(i);
						}
					}
				}
			}
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("existingOrderitemList"));
			modifiedOrderitemList.addAll((List<OrderItem>) session
					.getAttribute("orderitemList"));
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/addspecialnote/{id}/{note}", method = RequestMethod.GET)
	public void addSpecialNotes(@PathVariable("id") int id,
			@PathVariable("note") String note, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in addspecialnote...{},{}", id, note);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			/*
			 * for (int i = 0; i < orderitemList.size(); i++) { if
			 * (orderitemList.get(i).getItemId() == id) {
			 * orderitemList.get(i).setSpecialNote(note); } }
			 */
			for (int i = 0; i < ((List<OrderItem>) session
					.getAttribute("orderitemList")).size(); i++) {
				if (((List<OrderItem>) session.getAttribute("orderitemList"))
						.get(i).getItemId() == id) {
					((List<OrderItem>) session.getAttribute("orderitemList"))
							.get(i).setSpecialNote(note);
				}
			}
			// System.out.println("special note added:"+orderitemList.toString());
		}

	}

	@RequestMapping(value = "/showspecialnote", method = RequestMethod.GET)
	public void showSpecialNotes(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in showspecialnote...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			/*
			 * out.print(new Gson().toJson(orderitemList, new
			 * TypeToken<List<OrderItem>>() { }.getType()));
			 */
			out.print(new Gson().toJson(
					(List<OrderItem>) session.getAttribute("orderitemList"),
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
			// System.out.println("special note added:"+orderitemList.toString());
		}

	}
	
	
	
	
	@RequestMapping(value = "/createorder",
			method = RequestMethod.GET)
public void saveOrder(	@RequestParam String delOption,
					@RequestParam String orderno,
					@RequestParam String tableno,
					@RequestParam String custId,
					@RequestParam String custname,
					@RequestParam String custphone,
					@RequestParam String custaddress,
					@RequestParam String deliveryperson,
					@RequestParam String seatno,
					@RequestParam String pax,
					@RequestParam String custvatregno,
					@RequestParam String location,
					@RequestParam String houseno,
					@RequestParam String streetno,
					@RequestParam String state,
					@RequestParam String dob,
					@RequestParam String anniversary,
					@RequestParam String remark,
					
					HttpSession session,
					HttpServletResponse response) throws IOException {
logger.debug("in create order..." + "delOption:" + delOption + ":orderno:" + orderno + ":taleno:" + tableno + ":custname:" + custname + ":custphone:" + custphone + ":custaddress:" + custaddress + ":deliveryperson:" + deliveryperson + ":seatno:" + seatno + ":pax:" + pax + ":custvatregno:" + custvatregno + ":remark:"+remark);
PrintWriter out = response.getWriter();
response.setContentType("text/plain");
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	OrderType ordertype = new OrderType();
	//ordertype.setId(getDeliveryType(delOption));
	ordertype.setId(Integer.parseInt(delOption));
	
	Order order = new Order();
	order.setId(Integer.parseInt(orderno));
	order.setCustomerName(custname);
	order.setCustomerContact(custphone);
	order.setDeliveryAddress(custaddress);
	order.setDeliveryPersonName(deliveryperson);
	order.setCustVatRegNo(custvatregno);
	order.setLocation(location);
	order.setStreet(streetno);
	order.setHouseNo(houseno);
	order.setState(state);
	order.setDob(dob);
	//order.setCustomerId(custId);
	order.setStoreCustomerId(NumberUtils.toInt(custId));
	order.setAnniversary(anniversary);
//	order.setWaiterName(waiterNameForTable);
	order.setSource(Constants.ORDER_SOURCE);
	// order.setOrderDate(new Date());
	order.setLoginCustomerId(customer.getId());
	order.setOrdertype(ordertype);
	order.setStoreId(customer.getStoreId());
	order.setTable_no(tableno);
	order.setOrderTime(getOrderTime());
	// order.setCancelFlag("N");
	// order.setBillReqStatus("No");
	order.setSeatNo(seatno.equals("0") ? null : seatno);
	order.setRemarks(remark);
	// order.setOrderitem(orderitemList);
	List<OrderItem> orderitemlist = (List<OrderItem>) session.getAttribute("orderitemList");
	order.setOrderitem(orderitemlist);
	order.setCustomers(customer);
	order.setNoOfPersons(Integer.parseInt(pax));
	
	String res = orderService.saveOrder(order);
	System.out.println("res:" + res);
	if (!"002".equals(res)) {
		Store store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		//				if (store.getKitchenPrintBt().equalsIgnoreCase("N")) {
		//					new PosKOTPrinter().printKOT(getKotPrintObject(store, orderService.getOrderById(NumberUtils.toInt(res))), customer.getStoreId());
		//				}
		session.removeAttribute("orderitemList");
		session.removeAttribute("existingOrderitemList");
	}

	out.print(res);
	out.flush();
}

}

	
	
	
	
	
	
	
	
	
	/*@RequestMapping(value = "/createorder", method = RequestMethod.POST)
	public void saveOrder(@RequestBody String orderString,
			 HttpSession session,
			HttpServletResponse response) throws IOException {
	logger.debug("in create order..." + "delOption:" + delOption
			+ ":orderno:" + orderno + ":taleno:" + tableno + ":custname:"
			+ custname + ":custphone:" + custphone + ":custaddress:"
			+ custaddress + ":deliveryperson:" + deliveryperson
			+ ":seatno:" + seatno + ":pax:" + pax+ ":custvatregno:" + custvatregno);
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	
	logger.debug("in create order..." + "orderString:" + orderString);
	Customer customer;
	if ((customer = (Customer) session
			.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		
		Gson gson = new GsonBuilder().create();
		Order order =gson.fromJson(orderString, new TypeToken<Order>() {
		}.getType());
		
		order.setSource(Constants.ORDER_SOURCE);
		order.setLoginCustomerId(customer.getId());
		order.setStoreId(customer.getStoreId());
		order.setOrderTime(getOrderTime());
	
		List<OrderItem> orderitemlist=(List<OrderItem>) session.getAttribute("orderitemList");
		order.setOrderitem(orderitemlist);
		order.setCustomers(customer);
	
		String res =orderService.saveOrder(order);
		System.out.println("res:" + res);
		if (!"002".equals(res)) {
			Store store = (Store) session
					.getAttribute(Constants.LOGGED_IN_STORE);

			session.removeAttribute("orderitemList");
			session.removeAttribute("existingOrderitemList");
		}
		
		out.print(res);
		out.flush();
	}

}*/
	/*@RequestMapping(value = "/createorder", method = RequestMethod.GET)
	public void saveOrder(@RequestParam String delOption,
			@RequestParam String orderno, @RequestParam String tableno,
			@RequestParam String custname, @RequestParam String custphone,
			@RequestParam String custaddress,
			@RequestParam String deliveryperson, @RequestParam String seatno,
			@RequestParam String pax, @RequestParam String custvatregno,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in create order..." + "delOption:" + delOption
				+ ":orderno:" + orderno + ":taleno:" + tableno + ":custname:"
				+ custname + ":custphone:" + custphone + ":custaddress:"
				+ custaddress + ":deliveryperson:" + deliveryperson
				+ ":seatno:" + seatno + ":pax:" + pax + ":custvatregno:"
				+ custvatregno);
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			OrderType ordertype = new OrderType();
			ordertype.setId(getDeliveryType(delOption));

			Order order = new Order();
			order.setId(Integer.parseInt(orderno));
			order.setCustomerName(custname);
			order.setCustomerContact(custphone);
			order.setDeliveryAddress(custaddress);
			order.setDeliveryPersonName(deliveryperson);
			order.setCustVatRegNo(custvatregno);
			order.setSource(Constants.ORDER_SOURCE);
			// order.setOrderDate(new Date());
			order.setLoginCustomerId(customer.getId());
			order.setOrdertype(ordertype);
			order.setStoreId(customer.getStoreId());
			order.setTable_no(tableno);
			order.setOrderTime(getOrderTime());
			// order.setCancelFlag("N");
			// order.setBillReqStatus("No");
			order.setSeatNo(seatno.equals("0") ? null : seatno);
			// order.setOrderitem(orderitemList);
			List<OrderItem> orderitemlist = (List<OrderItem>) session
					.getAttribute("orderitemList");
			order.setOrderitem(orderitemlist);
			order.setCustomers(customer);
			order.setNoOfPersons(Integer.parseInt(pax));
			String res = orderService.saveOrder(order);
			System.out.println("res:" + res);
			if (!"002".equals(res)) {
				Store store = (Store) session
						.getAttribute(Constants.LOGGED_IN_STORE);
				// if (store.getKitchenPrintBt().equalsIgnoreCase("Y")) {
				// new PosKOTPrinter().printKOT(
				// getKotPrintObject(store, orderService
				// .getOrderById(NumberUtils.toInt(res))),
				// customer.getStoreId());
				// }
				session.removeAttribute("orderitemList");
				session.removeAttribute("existingOrderitemList");
			}

			out.print(res);
			out.flush();
		}

	}
*/
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
	
/*	@RequestMapping(value = "/getordertype", method = RequestMethod.GET)
	public void getOrderType(@RequestParam String storeID,
			HttpSession session, HttpServletResponse response)
			throws IOException {*/
		@RequestMapping(value = "/getordertype/{storeID}", method = RequestMethod.GET)
		public void getordertype(@PathVariable("storeID") String storeID,
				HttpSession session, HttpServletResponse response)
				throws IOException {	
		Customer customer;
	//	logger.debug("in getpaymentinfo...{}", customer.getStoreId());
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
			//out.print(orderService.getOrderType(NumberUtils.toInt(storeID)));
			//out.print(orderTypeList);
			out.print(gson.toJson(orderTypeList));
			//out.print(menumgntService.getMenuCategoryByStoreId(NumberUtils.toInt(storeID)));
			out.flush();
		}
	}
	
	/*@RequestMapping(value = "/getordertype", method = RequestMethod.GET)
	public void getOrderType(HttpSession session, HttpServletResponse response)
			throws IOException {
		//logger.debug("in getpaymentinfo...{}", storeID);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getOrderType(customer.getStoreId()));
			out.flush();
		}
	}
*/
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

	@RequestMapping(value = "/orderpayment/{orderno}/{amount}/{paidAmount}/{amountToPay}/{tenderAmount}/{paymentMode}/{digit}", method = RequestMethod.GET)
	public void orderPayment(@PathVariable("orderno") String orderno,
			@PathVariable("amount") String amount,
			@PathVariable("paidAmount") String paidAmount,
			@PathVariable("amountToPay") String amountToPay,
			@PathVariable("tenderAmount") String tenderAmount,
			@PathVariable("paymentMode") String paymentMode,
			@PathVariable("digit") String digit, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in orderpayment...{},{}, {}, {},{},{},{},{}", orderno,
				amount, paidAmount, amountToPay, tenderAmount, paymentMode,
				digit);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Order order = new Order();
			order.setId(NumberUtils.toInt(orderno));
			Payment payment = new Payment();
			payment.setOrderPayment(order);
			payment.setAmount(NumberUtils.toDouble(amount));
			payment.setPaidAmount(NumberUtils.toDouble(paidAmount));
			payment.setAmountToPay(NumberUtils.toDouble(amountToPay));
			payment.setTenderAmount(NumberUtils.toDouble(tenderAmount));
			payment.setPaymentMode(paymentMode);
			payment.setCardLastFourDigits(digit);
			payment.setStoreId(customer.getStoreId());
			payment.setSource("web");
			payment.setCreatedBy(customer.getContactNo());
			payment.setCreationDate(getOrderTime());
			out.print(orderService.orderPayment(payment));
			out.flush();
		}

	}

	@RequestMapping(value = "/printbill/{orderid}", method = RequestMethod.GET)
	public void printBill(@PathVariable("orderid") String orderid,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in printbill...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Store store = (Store) session
					.getAttribute(Constants.LOGGED_IN_STORE);
			/*
			 * if (store.getBillPrintBt().equalsIgnoreCase("Y")) { new
			 * PosBillPrinter().printBill( getBillPrintObject(store,
			 * orderService .getOrderById(NumberUtils.toInt(orderid))),
			 * customer.getStoreId()); }
			 */
			out.print(orderService.printBill(NumberUtils.toInt(orderid),
					customer.getStoreId()));
			out.flush();
		}
	}
	
@RequestMapping(value = "/adddiscount/{orderid}/{discper}/{discamt}/{discreason}/{isnoncharge}",
			method = RequestMethod.GET)
public void addDiscount(@PathVariable("orderid") String orderid,
					@PathVariable("discper") String discper,
					@PathVariable("discamt") String discamt,
					@PathVariable("discreason") String discreason,
					@PathVariable("isnoncharge") String isnoncharge,
					HttpSession session,
					HttpServletResponse response) throws IOException {
logger.debug("in adddiscount...{},{},{}", orderid, discper, discamt);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	Discount discount = new Discount();
	discount.setOrderId(NumberUtils.toInt(orderid));
	discount.setStoreId(customer.getStoreId());
	discount.setDiscountPercentage(NumberUtils.toDouble(discper));
	discount.setCustomerDiscount(NumberUtils.toDouble(discamt));
	discount.setDiscountReason(discreason);
	discount.setIsNonchargeable(isnoncharge);
	out.print(orderService.addDiscount(discount));
	out.flush();
}
}

	/*@RequestMapping(value = "/adddiscount/{orderid}/{discper}/{discamt}", method = RequestMethod.GET)
	public void addDiscount(@PathVariable("orderid") String orderid,
			@PathVariable("discper") String discper,
			@PathVariable("discamt") String discamt, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in adddiscount...{},{},{}", orderid, discper, discamt);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Discount discount = new Discount();
			discount.setOrderId(NumberUtils.toInt(orderid));
			discount.setStoreId(customer.getStoreId());
			discount.setDiscountPercentage(NumberUtils.toDouble(discper));
			discount.setCustomerDiscount(NumberUtils.toDouble(discamt));
			out.print(orderService.addDiscount(discount));
			out.flush();
		}
	}*/

	@RequestMapping(value = "/getspecialnotesbyitemid/{itemid}", method = RequestMethod.GET)
	public void getSpecialNotesbyItemId(@PathVariable("itemid") String itemid,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in getspecialnotesbyitemid...{}", itemid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			out.print(orderService.getsplnotebyItemId(
					NumberUtils.toInt(itemid), customer.getStoreId()));
			out.flush();
		}
	}

	@RequestMapping(value = "/autocompleteitemcode", method = RequestMethod.GET)
	public List<MenuItem> getItemCodeAutocompleteList(
			@RequestParam String tagName, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("In autocompleteitemcode......{}", tagName);
		Menu menuCategory = (Menu) session
				.getAttribute(Constants.MENU_ALL_TREE);
		List<MenuItem> itemList = new ArrayList<MenuItem>();
		List<Menu> allMenuCat = menuCategory.getMenucategory();
		Iterator<Menu> allMenuCatItr = allMenuCat.iterator();
		while (allMenuCatItr.hasNext()) {
			Menu submenuCat = allMenuCatItr.next();
			List<Menu> allsubMenuCat = submenuCat.getMenucategory();
			Iterator<Menu> allsubMenuCatItr = allsubMenuCat.iterator();
			while (allsubMenuCatItr.hasNext()) {
				Menu menuItems = allsubMenuCatItr.next();
				List<MenuItem> allItems = menuItems.getItems();
				Iterator<MenuItem> allitemCatItr = allItems.iterator();
				while (allitemCatItr.hasNext()) {
					MenuItem items = allitemCatItr.next();
					// items.setMenucatId(submenuCat.getId());
					// items.setMenucatName(submenuCat.getMenuCategoryName());
					// items.setSubmenucatId(menuItems.getId());
					// items.setSubmenucatName(menuItems.getMenuCategoryName());
					itemList.add(items);
					// System.out.println("menu Items :"+items);
				}
			}
		}
		System.out.println("menu Items List size:" + itemList);
		// session.setAttribute("totalitemList", itemList);
		List<MenuItem> newItemList = new ArrayList<MenuItem>();
		for (MenuItem items : itemList) {
			if (StringUtils.equalsIgnoreCase(items.getProduction(), "Y")) {
				if (StringUtils.startsWithIgnoreCase(items.getName(), tagName)) {
					newItemList.add(items);
				}
			}
		}
		System.out.println("menu Items List :" + newItemList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newItemList));
		return null;

	}

	@RequestMapping(value = "/autocompletecreditcustname", method = RequestMethod.GET)
	public List<MenuItem> getcreditcustnameAutocompleteList(
			@RequestParam String tagName, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("In autocompletecreditcustname......{}", tagName);
		List<StoreCustomers> creditcustomerList = new ArrayList<StoreCustomers>();
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			creditcustomerList = orderService.getallcreditCustomers(customer
					.getStoreId());

		}
		List<StoreCustomers> newcreditcustomerList = new ArrayList<StoreCustomers>();
		for (StoreCustomers customers : creditcustomerList) {
			if (StringUtils
					.equalsIgnoreCase(customers.getCreditCustomer(), "Y")) {
				if (StringUtils.startsWithIgnoreCase(customers.getName(),
						tagName)) {
					newcreditcustomerList.add(customers);
				}
			}
		}
		System.out.println("credit cust autocomplete list:"
				+ newcreditcustomerList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newcreditcustomerList));
		return null;
	}

	@RequestMapping(value = "/autocompletecreditcustcontact", method = RequestMethod.GET)
	public List<MenuItem> getcreditcustcontactAutocompleteList(
			@RequestParam String tagName, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("In autocompletecreditcustname......{}", tagName);
		List<StoreCustomers> creditcustomerList = new ArrayList<StoreCustomers>();
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			creditcustomerList = orderService.getallcreditCustomers(customer
					.getStoreId());

		}
		List<StoreCustomers> newcreditcustomerList = new ArrayList<StoreCustomers>();
		for (StoreCustomers customers : creditcustomerList) {
			if (StringUtils
					.equalsIgnoreCase(customers.getCreditCustomer(), "Y")) {
				if (StringUtils.startsWithIgnoreCase(customers.getContactNo(),
						tagName)) {
					newcreditcustomerList.add(customers);
				}
			}
		}
		System.out.println("credit cust autocomplete list:"
				+ newcreditcustomerList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newcreditcustomerList));
		return null;
	}

	@RequestMapping(value = "/updatecreditsalestatus/{orderid}/{custid}", method = RequestMethod.GET)
	public void updateCreditSaleStatus(@PathVariable("orderid") String orderid,
			@PathVariable("custid") String custid, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in updatecreditsalestatus...{},{}", orderid, custid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.updateCreditSaleStatus(
					NumberUtils.toInt(orderid), customer.getStoreId(),
					NumberUtils.toInt(custid)));
			out.flush();
		}
	}

	@RequestMapping(value = "/updatepax/{orderid}/{noofPax}", method = RequestMethod.GET)
	public void updatePax(@PathVariable("orderid") String orderid,
			@PathVariable("noofPax") String noofPax, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in updatepax...{},{}", orderid, noofPax);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.updatePax(NumberUtils.toInt(orderid),
					NumberUtils.toInt(noofPax)));
			out.flush();
		}
	}

	@RequestMapping(value = "/viewallpaidorder", method = RequestMethod.GET)
	public ModelAndView loadPaidOrder(Model model, HttpSession session) {

		logger.debug("In viewallpaidorder......");
		List<Order> allpaidOrderList = null;
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		String allpaidOrder = orderService.getPaidOrderList(
				customer.getStoreId(), getTodayDate());
		Gson gson = new Gson();
		allpaidOrderList = gson.fromJson(allpaidOrder,
				new TypeToken<List<Order>>() {
				}.getType());
		mav.addObject("allpaidOrderList", allpaidOrderList);
		mav.addObject("today", new Date());
		mav.setViewName(ForwardConstants.VIEW_PAID_ORDER_PAGE);
		mav.addObject(Constants.PAID_ORDER, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewallpaidorderbydate", method = RequestMethod.POST)
	public ModelAndView viewAllPaidOrderByDate(Model model,
			HttpSession session, @ModelAttribute("order") Order order) {

		logger.debug("In viewallpaidorder......");
		System.out.println("ordergetOrderDate()=" + order.getOrderDate());
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(order.getOrderDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<Order> allpaidOrderList = null;
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		String allpaidOrder = orderService.getPaidOrderList(
				customer.getStoreId(), order.getOrderDate());
		Gson gson = new Gson();
		allpaidOrderList = gson.fromJson(allpaidOrder,
				new TypeToken<List<Order>>() {
				}.getType());
		mav.addObject("allpaidOrderList", allpaidOrderList);
		mav.addObject("today", date);
		mav.setViewName(ForwardConstants.VIEW_PAID_ORDER_PAGE);
		mav.addObject(Constants.PAID_ORDER, "Y");

		return mav;
	}

	@RequestMapping(value = "/updatetable/{orderid}/{tabno}", method = RequestMethod.GET)
	public void updateTable(@PathVariable("orderid") String orderid,
			@PathVariable("tabno") String tabno, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in updatepax...{},{}", orderid, tabno);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.updateTable(NumberUtils.toInt(orderid),
					tabno));
			out.flush();
		}
	}

	@RequestMapping(value = "/getsplitbillitemlistbyoderid/{orderid}", method = RequestMethod.GET)
	public void getOrderItemforSplitBill(
			@PathVariable("orderid") String orderid, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in getsplitbillitemlist...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Order order = orderService.getOrderById(NumberUtils.toInt(orderid));
			existingOrderitemListSplitBill = new ArrayList<OrderItem>();
			existingOrderitemListSplitBill = order.getOrderitem();

			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/getsplitbillitemlistcategorywisebyoderid/{orderid}", method = RequestMethod.GET)
	public void getOrderItemCategoryWiseforSplitBill(
			@PathVariable("orderid") String orderid, HttpSession session,
			HttpServletResponse response) throws IOException {

		// @RequestMapping(value = "/getsplitbillitemlistcategorywisebyoderid",
		// method = RequestMethod.GET)
		// public void getOrderItemCategoryWiseforSplitBill(@RequestParam String
		// orderid,HttpSession session,
		// HttpServletResponse response) throws IOException {
		logger.debug("in getsplitbillitemlistcategorywisebyoderid...{}",
				orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Order order = orderService.getOrderByIdForSpiltBill(NumberUtils
					.toInt(orderid));
			List<OrderItem> orderItems = order.getOrderitem();

			Set<Integer> categoriesid = new HashSet<Integer>();
			for (OrderItem orderItem : orderItems) {
				categoriesid.add(orderItem.getItem().getCategoryId());
			}
			Set<Menu> categories = new HashSet<Menu>();
			for (Integer catid : categoriesid) {
				Menu category = new Menu();
				List<MenuItem> items = new ArrayList<MenuItem>();
				for (OrderItem orderItem : orderItems) {
					if (catid.equals(orderItem.getItem().getCategoryId())) {
						System.out.println("Value for key getCategoryName is: "
								+ orderItem.getItem().getCategoryName());
						category.setId(orderItem.getItem().getCategoryId());
						category.setMenuCategoryName(orderItem.getItem()
								.getCategoryName());
						MenuItem menuItem = orderItem.getItem();
						menuItem.setQuantityOfItem(orderItem
								.getQuantityOfItem());
						menuItem.setTotalPriceByItem(orderItem
								.getTotalPriceByItem());
						items.add(menuItem);
						category.setItems(items);
					}
				}
				categories.add(category);

			}
			List<Menu> categorieslist = new ArrayList<Menu>(categories);
			logger.debug("in getsplitbillitemlistcategorywisebyoderid...{}",
					categories);
			existingMenuSplitBillCategoryWise = new ArrayList<Menu>();
			existingMenuSplitBillCategoryWise = categorieslist;
			out.print("success");
			// out.print(new Gson().toJson(existingMenuSplitBillCategoryWise,
			// new TypeToken<List<Menu>>() {
			// }.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/getsplitbillitemlist", method = RequestMethod.GET)
	public void getspliBillItemList(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in getsplitbillitemlist...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			// existingOrderitemListSplitBill=existingOrderitemList;
			List<OrderItem> modifiedOrderitemList = existingOrderitemListSplitBill;
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			// modifiedOrderitemList.addAll(existingOrderitemList);
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/getsplitbillitemlistcategorywise", method = RequestMethod.GET)
	public void getspliBillItemListCategoryWise(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in getspliBillItemListCategoryWise...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			// existingOrderitemListSplitBill=existingOrderitemList;
			List<Menu> modifiedMenuList = existingMenuSplitBillCategoryWise;
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			// modifiedOrderitemList.addAll(existingOrderitemList);
			out.print(new Gson().toJson(modifiedMenuList,
					new TypeToken<List<Menu>>() {
					}.getType()));
			out.flush();
		}
	}

	public synchronized List<OrderItem> upadteSplitOrderItemList(
			OrderItem orderItem, List<OrderItem> ordeList) {
		boolean isPresent = true;
		if (ordeList.size() > 0) {
			for (OrderItem items : ordeList) {
				if (items.getId() == orderItem.getId()) {
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

	@RequestMapping(value = "/additemlisttosplitbillcatwise/{selectedsplitRowscatwise}", method = RequestMethod.GET)
	public void additemlisttoSplitBillcatwise(
			@PathVariable("selectedsplitRowscatwise") String[] selectedsplitRowscatwise,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in additemlisttosplitbillcatwise...{}",
				selectedsplitRowscatwise.toString());
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<Menu> modifiedMenuitemCategory = new ArrayList<Menu>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			if (existingMenuSplitBillCategoryWise.size() > 0) {
				for (int i = 0; i < existingMenuSplitBillCategoryWise.size(); i++) {
					for (int j = 0; j < selectedsplitRowscatwise.length; j++) {
						System.out
								.println("existingMenuSplitBillCategoryWise.get(i).getId()="
										+ existingMenuSplitBillCategoryWise
												.get(i).getId());
						System.out
								.println("Integer.parseInt(selectedsplitRowscatwise[j])="
										+ Integer
												.parseInt(selectedsplitRowscatwise[j]));
						if (existingMenuSplitBillCategoryWise.get(i).getId() == Integer
								.parseInt(selectedsplitRowscatwise[j])) {

							modifiedMenuitemCategory
									.add(existingMenuSplitBillCategoryWise
											.get(i));
							existingMenuSplitBillCategoryWise.remove(i);

						}
					}
				}
			}

			out.print(new Gson().toJson(modifiedMenuitemCategory,
					new TypeToken<List<Menu>>() {
					}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/additemlisttosplitbill/{selectedsplitRows}", method = RequestMethod.GET)
	public void additemlisttoSplitBill(
			@PathVariable("selectedsplitRows") String[] selectedsplitRows,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in additemlisttosplitbill...{}",
				selectedsplitRows.toString());
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			if (existingOrderitemListSplitBill.size() > 0) {
				for (int i = 0; i < existingOrderitemListSplitBill.size(); i++) {
					for (int j = 0; j < selectedsplitRows.length; j++) {
						if (existingOrderitemListSplitBill.get(i).getId() == Integer
								.parseInt(selectedsplitRows[j])) {
							if (Integer.valueOf(existingOrderitemListSplitBill
									.get(i).getQuantityOfItem()) > 1) {
								int qty = Integer
										.valueOf(existingOrderitemListSplitBill
												.get(i).getQuantityOfItem());
								qty = qty - 1;
								System.out.println("qty:" + qty);
								OrderItem modorderitem = new OrderItem();
								// modorderitem=existingOrderitemListSplitBill
								// .get(i);
								modorderitem
										.setId(existingOrderitemListSplitBill
												.get(i).getId());
								modorderitem
										.setItem(existingOrderitemListSplitBill
												.get(i).getItem());
								modorderitem
										.setRate(existingOrderitemListSplitBill
												.get(i).getRate());
								modorderitem.setQuantityOfItem("1");

								modifiedOrderitemList.add(modorderitem);
								// modifiedOrderitemList.get(i).setQuantityOfItem("1");
								existingOrderitemListSplitBill.get(i)
										.setQuantityOfItem(String.valueOf(qty));
							} else {
								modifiedOrderitemList
										.add(existingOrderitemListSplitBill
												.get(i));

								existingOrderitemListSplitBill.remove(i);
							}
						}
					}
				}
			}

			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/deleteitemlisttosplitbill/{deleteitemid}/{orderid}", method = RequestMethod.GET)
	public void deleteitemlisttoSplitBill(
			@PathVariable("deleteitemid") String deleteitemid,
			@PathVariable("orderid") String orderid, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in deleteitemid...{},{}", deleteitemid, orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Order order = orderService.getOrderById(NumberUtils.toInt(orderid));
			orderitemListSplitted = new ArrayList<OrderItem>();
			orderitemListSplitted = order.getOrderitem();
			List<OrderItem> modifiedOrderitemList = new ArrayList<OrderItem>();

			/*
			 * Map mapa=new HashMap(); for(OrderItem
			 * existingOrderitemListSplitBill1:existingOrderitemListSplitBill){
			 * mapa.put(existingOrderitemListSplitBill1.getId(),
			 * existingOrderitemListSplitBill1.getQuantityOfItem());
			 * 
			 * }
			 */

			for (OrderItem orderitemListSplittedori : orderitemListSplitted) {

				// System.out.println("map="+mapa);
				System.out.println("orderitemListSplittedori.getId(="
						+ orderitemListSplittedori.getId());
				// for(OrderItem
				// existingOrderitemListSplitBill1:existingOrderitemListSplitBill){
				if (orderitemListSplittedori.getId() == Integer
						.valueOf(deleteitemid)) {
					OrderItem orderItem = new OrderItem();
					orderItem = orderitemListSplittedori;
					if (Integer.valueOf(orderitemListSplittedori
							.getQuantityOfItem()) > 1) {
						orderItem = new OrderItem();
						orderItem = orderitemListSplittedori;
						orderItem.setQuantityOfItem("1");
						existingOrderitemListSplitBill.add(orderItem);
					} else {

						existingOrderitemListSplitBill.add(orderItem);
					}

				}

			}
			/*
			 * Set<Integer> idset=new HashSet<Integer>(); for(OrderItem
			 * orderitemListnew:existingOrderitemListSplitBill) {
			 * idset.add(orderitemListnew.getId());
			 * System.out.println("ids:"+orderitemListnew.getId()); }
			 * for(Integer in:idset) { System.out.println("innn:"+in); for(int
			 * j=0;j<existingOrderitemListSplitBill.size();j++) {
			 * if(in.equals(Integer.valueOf(deleteitemid))) { int
			 * qty=Integer.parseInt
			 * (existingOrderitemListSplitBill.get(j).getQuantityOfItem());
			 * qty=qty+1; System.out.println("new qty:"+qty); //OrderItem
			 * orderItem=new OrderItem(); //orderItem.setQuantityOfItem(""+qty);
			 * //existingOrderitemListSplitBill.add(orderItem);
			 * existingOrderitemListSplitBill.get(j).setQuantityOfItem(""+qty);
			 * } } }
			 */
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(new Gson().toJson(modifiedOrderitemList,
					new TypeToken<List<OrderItem>>() {
					}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value = "/validatesplitbill", method = RequestMethod.GET)
	public void validateSplitBill(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in validatesplitbill...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			System.out.println("existing list size:"
					+ existingOrderitemListSplitBill.size());
			out.print(existingOrderitemListSplitBill.size());
			out.flush();
		}
	}

	@RequestMapping(value = "/validatesplitbillcatwise", method = RequestMethod.GET)
	public void validateSplitBillCatWise(HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in validatesplitbillcatwise...");
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			System.out.println("existing list size for cat wise:"
					+ existingMenuSplitBillCategoryWise.size());
			out.print(existingMenuSplitBillCategoryWise.size());
			out.flush();
		}
	}

	@RequestMapping(value = "/submitsplitbill/{SpliBill}", method = RequestMethod.GET)
	public void submitSplitBill(@PathVariable("SpliBill") String SpliBill,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in submitsplitbill...{}", SpliBill);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			BillSplitManual_duplicate splidup = new BillSplitManual_duplicate();
			Gson gson = new Gson();
			List<BillSplitManual> splitList = gson.fromJson(SpliBill,
					new TypeToken<List<BillSplitManual>>() {
					}.getType());
			splidup.setBillSplitManuals(splitList);
			String res = orderService.splitBillM(splidup);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/submitsplitbillfors01", method = RequestMethod.POST)
	public void submitSplitBillForS01(@RequestBody String SpliBill,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in submitsplitbillfors01...{}", SpliBill);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			BillSplitManual_duplicate splidup = new BillSplitManual_duplicate();
			Gson gson = new Gson();
			List<BillSplitManual> splitList = gson.fromJson(SpliBill,
					new TypeToken<List<BillSplitManual>>() {
					}.getType());
			splidup.setBillSplitManuals(splitList);
			String res = orderService.splitBillM(splidup);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/getbillwiseitemlist/{orderid}", method = RequestMethod.GET)
	public void getBillWiseItemList(@PathVariable("orderid") String orderid,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in getBillWiseItemList...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = orderService.getBillWiseItemList(NumberUtils
					.toInt(orderid));
			System.out.println("res=" + res);
			Set<Integer> billnos = new TreeSet<Integer>();
			List<BillSplitManual> billSplitManuals = new Gson().fromJson(res,
					new TypeToken<List<BillSplitManual>>() {
					}.getType());
			for (BillSplitManual billSplitManual : billSplitManuals) {
				billnos.add(billSplitManual.getBillNo());
			}
			Set<BillSplitManual> billSplitManualsbillnowise = new HashSet<BillSplitManual>();
			for (Integer billno : billnos) {
				BillSplitManual billNo = new BillSplitManual();
				List<BillSplitManual> items = new ArrayList<BillSplitManual>();
				for (BillSplitManual billSplitManual : billSplitManuals) {
					if (billno.equals(billSplitManual.getBillNo())) {
						billNo.setBillNo(billSplitManual.getBillNo());
						BillSplitManual billNowiseDetails = billSplitManual;
						items.add(billNowiseDetails);
						billNo.setBillSplitManuals(items);
					}
				}
				billSplitManualsbillnowise.add(billNo);
			}
			List<BillSplitManual> BillSplitManuallist = new ArrayList<BillSplitManual>(
					billSplitManualsbillnowise);
			Collections.sort(BillSplitManuallist,
					new Comparator<BillSplitManual>() {

						@Override
						public int compare(BillSplitManual o1,
								BillSplitManual o2) {
							// TODO Auto-generated method stub
							return Integer.compare(o1.getBillNo(),
									o2.getBillNo());
						}

					});
			;

			out.print(new Gson().toJson(BillSplitManuallist,
					new TypeToken<List<BillSplitManual>>() {
					}.getType()));
			// out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/printsplitbill/{orderid}", method = RequestMethod.GET)
	public void printSplitBill(@PathVariable("orderid") String orderid,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in printsplitbill...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Store store = (Store) session
					.getAttribute(Constants.LOGGED_IN_STORE);
			/*
			 * if (store.getBillPrintBt().equalsIgnoreCase("Y")) { new
			 * PosBillPrinter().printBill( getBillPrintObject(store,
			 * orderService .getOrderById(NumberUtils.toInt(orderid))),
			 * customer.getStoreId()); }
			 */
			out.print(orderService.printSplitBill(NumberUtils.toInt(orderid),
					customer.getStoreId()));
			out.flush();
		}
	}

	@RequestMapping(value = "/printkotchecklist/{orderid}", method = RequestMethod.GET)
	public void printKotCheckList(@PathVariable("orderid") String orderid,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in printkotchecklist...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.printKotCheckList(
					NumberUtils.toInt(orderid), customer.getStoreId()));
			out.flush();
		}
	}

	@RequestMapping(value = "/showvfd/{row1}/{row2}", method = RequestMethod.GET)
	public void showcustomerDisplay(@PathVariable("row1") String row1,
			@PathVariable("row2") String row2, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in showvfd...{},{}", row1, row2);
		Store store;
		store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		if (store != null) {
			Display display = new Display(store.getCustomerDisplay());
			display.vfdClient(store.getCustomerDisplay(), row1, row2);
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

	public void showcustomerDisplayTOT(final String row1, final String row2,
			HttpSession session) throws IOException {
		logger.debug("in showcustomerDisplayTOT...{},{}", row1, row2);
		final Store store;
		store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		if (store != null) {
			if (store.getCustomerDisplay().length() > 3) {
				Thread t1 = new Thread(new Runnable() {
					public void run() {
						// code goes here.
						Display display = new Display(
								store.getCustomerDisplay());
						display.vfdClient(store.getCustomerDisplay(), row1,
								row2);
					}
				});
				t1.start();

			}
		}
	}

	public String getOrderTime() {
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		// java.util.Calendar cal=java.util.Calendar.getInstance();
		// System.out.println("date:"+df.format(date));
		return df.format(date);
	}

	public int getDeliveryType(String opt) {
		int delopt = 0;
		if (opt.equals("dineIn")) {
			delopt = 3;
		}
		if (opt.equals("parcel")) {
			delopt = 2;
		}
		if (opt.equals("homeDel")) {
			delopt = 1;
		}
		// System.out.println("deloption:"+delopt);
		return delopt;
	}

	public List<OrderItem> getOrderItemList(Order order) {
		List<OrderItem> orderitemlist = new ArrayList<OrderItem>();
		// Order order=table.getOrder();
		if (order != null) {
			for (OrderItem orderitems : order.getOrderitem()) {
				orderitems.setIsinOrder("Y");
				orderitems.setItemName(orderitems.getItem().getName());
				orderitems.setDiscount(""
						+ orderitems.getItem().getPromotionValue());
				orderitemlist.add(orderitems);
			}
			return orderitemlist;
		} else
			return orderitemlist;
	}

	public Order setDiscountFlag(Order order) {

		try {
			if (order != null) {
				Bill bill = order.getOrderBill();
				// System.out.println("custdisc:"+bill.getCustomerDiscount());
				// System.out.println("custdiscper:"+bill.getDiscountPercentage());
				if ((/* bill.getCustomerDiscount()!=null || */bill
						.getCustomerDiscount() != 0)
						|| (/* bill.getDiscountPercentage()!=null || */bill
								.getDiscountPercentage() != 0)) {
					order.setIsDiscountAdded("Y");
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return order;
	}

	public Order setPaidAmt(Order order) {
		double paidAmount = 0.00;
		List<Payment> paymentLst = orderService.getPaymentListById(order
				.getId());
		Iterator<Payment> iterator = paymentLst.iterator();
		while (iterator.hasNext()) {
			Payment payment = (Payment) iterator.next();
			paidAmount = paidAmount + payment.getPaidAmount();
		}
		order.setPaidAmt(paidAmount);
		return order;
	}

	@RequestMapping(value = "/getcustomerdetails/{contact}", method = RequestMethod.GET)
	public void getcustomerdetails(@PathVariable("contact") String contact,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", contact);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getCustDetails(contact,
					customer.getStoreId()));
			out.flush();
		}
	} 
	@RequestMapping(value = "/getTotaltransactionPerCustomer/{custId}", method = RequestMethod.GET)
	public void getTotaltransactionPerCustomer(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getTotalTransaction(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	@RequestMapping(value = "/getLastVisitDate/{custId}", method = RequestMethod.GET)
	public void getLastVisitDate(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getLastVisitDate(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	@RequestMapping(value = "/getTotalPaidAmt/{custId}", method = RequestMethod.GET)
	public void getTotalPaidAmt(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getTotalPaidAmt(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	@RequestMapping(value = "/getcustmostpurchaseItem/{custId}", method = RequestMethod.GET)
	public void getcustmostpurchaseItem(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getMostPurchaseItem(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	
	@RequestMapping(value = "/getcustomertransactionsummery/{custId}", method = RequestMethod.GET)
	public void getcustomertransactionsummery(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getCustTransactionSummery(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	
	@RequestMapping(value = "/autocompleteordercustcontact", method = RequestMethod.GET)
	public void getordercustomercontacts(@RequestParam String term,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}");
		List<String> custContact = new ArrayList<String>();
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			custContact = orderService.getOrderCustContacts(customer
					.getStoreId());
		}
		List<String> newcustContact = new ArrayList<String>();
		for (String Contact : custContact) {
			if (StringUtils.startsWithIgnoreCase(Contact, term)) {
				newcustContact.add(Contact);
			}
		}
		System.out
				.println(" cust contact  autocomplete list:" + newcustContact);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newcustContact));
		out.flush();
	}
	
	@RequestMapping(value = "/searchcustbyphno",
			method = RequestMethod.GET)
public void searchCustomerByPhno(	@RequestParam(value = "term") String tagName,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in searchCustomerByPhno...{}", tagName);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("application/json");
	Gson gson = new Gson();
	String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
	String custList = orderService.getCustDetbyPhno(customer.getStoreId(), tagName);
	out.print(gson.toJson(custList));
	out.flush();
}
}

	@RequestMapping(value = "/getOrderWithPaymentInfo", method = RequestMethod.POST)
	public void getOrderWithPayment(@RequestBody String orderString,
			HttpSession session, HttpServletResponse response,
			HttpServletRequest request) {

		Gson gson = new GsonBuilder().create();
		Order order = gson.fromJson(orderString, new TypeToken<Order>() {
		}.getType());

		try {
			String orderObj = orderService.getOrderWithPayment(order.getId(),
					order.getStoreId());
			
				Order orderOb = (Order) gson.fromJson(orderObj, new
						 TypeToken<Order>() {}.getType());
				if(orderOb!=null){
					List<OrderItem> orderItemList = orderOb.getOrderitem();
					List<OrderItem> itemlist = new ArrayList<OrderItem>();
					List<OrderItem> packingitemlist = new ArrayList<OrderItem>();
					for (OrderItem orderitems : orderItemList) {
						//if(StringUtils.containsIgnoreCase(orderitems.getItem().getName(), "bowl"))
						if(StringUtils.equalsIgnoreCase(orderitems.getItem().getPackaged(), "Y"))
							{
							packingitemlist.add(orderitems);
							}
						else{
							itemlist.add(orderitems);
						}
	
						}
					orderOb.setOrderitem(itemlist);
					orderOb.setPackingitem(packingitemlist);
					orderObj=gson.toJson(orderOb);
					}
			
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderObj);
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public Object[] getKotPrintObject(Store store, Order order) {
		String s = "\\u0020"; // for space
		char c = (char) Integer.parseInt(s.substring(2), 16);
		String kot = "    KOT";
		String strName = store.getStoreName();
		StringBuffer kitchenHdrStrng = new StringBuffer();
		StringBuffer kitchenItemStrng = new StringBuffer();
		StringBuffer kitchenEndStrng = new StringBuffer();
		kitchenHdrStrng.append(kot);
		kitchenHdrStrng.append("\n");
		kitchenHdrStrng.append(strName); // 1st string
		kitchenHdrStrng.append("\n");
		String ordeTime = order.getOrderTime();

		String[] tempURL = ordeTime.split("/");
		String day = tempURL[0];
		String mnth = tempURL[1];
		String dayMnth = day + "/" + mnth;
		String[] tempURL1 = ordeTime.split(" ");
		String time = tempURL1[1];
		System.out.println("dayMnth.." + dayMnth);
		System.out.println("time.." + time);
		String[] timefull = time.split(":");
		String hr = timefull[0];
		String mins = timefull[1];
		String hrMins = hr + ":" + mins;
		System.out.println("hr mins:::  " + hrMins);
		String dtTime = dayMnth + " " + hrMins;
		System.out.println("dttime:: " + dtTime);
		StringBuffer secndString = new StringBuffer();
		secndString.append(dtTime); // 2nd string start
		secndString.append(" ");
		// get order taken by person info
		Customer customer = order.getCustomers();
		int custId = customer.getId();
		secndString.append("(");
		if (custId > 0) {
			secndString.append("" + custId);
		}
		secndString.append(")"); // 2nd string end
		kitchenHdrStrng.append("\n");
		StringBuffer thrdString = new StringBuffer();
		thrdString.append("Order No:"); // 3rd string start
		thrdString.append("" + order.getId());
		thrdString.append(",");
		thrdString.append("Table-");
		// get table no.
		String tblNo = order.getTable_no();
		if (tblNo != null && tblNo.length() > 0) {
			thrdString.append(tblNo);
		} else {
			thrdString.append("");
		}
		// 3rd string end
		// 4th string start
		String noOfPersons = "No. of persons:" + order.getNoOfPersons() + "";
		// 4th string end

		kitchenHdrStrng.append("\n\n");
		kitchenHdrStrng.append("\n\n");
		// declare a map to hold item name, item quantity
		// get items from order
		Map<String, String> mapToHoldItems = new LinkedHashMap<String, String>();
		// List<OrderItem> orderItemLst = order.getOrderitem();
		Iterator<OrderItem> ordrItr = orderitemList.iterator();
		while (ordrItr.hasNext()) {
			OrderItem orderItem = (OrderItem) ordrItr.next();
			// get the special note
			String specialNote = orderItem.getSpecialNote();
			MenuItem menuItem = orderItem.getItem();
			String itemName = menuItem.getName();
			StringBuffer nameNSpecl = new StringBuffer();
			nameNSpecl.append(itemName);
			nameNSpecl.append("\n" + "##");
			nameNSpecl.append(specialNote);
			String nameWithSpclNote = nameNSpecl.toString();
			// String nameWithSpclNote=itemName+"##"+specialNote;
			int itemLength = itemName.length();
			int maxLength = 28;

			String quantity = orderItem.getQuantityOfItem();
			mapToHoldItems.put(itemName, quantity);
			if (specialNote != null) {
				if (specialNote.length() > 0
						&& !specialNote.equalsIgnoreCase("")) {
					mapToHoldItems.put("  ##" + specialNote, "");

				}
			}
			itemName = String.format("%-35s:%s", itemName, quantity);
			kitchenItemStrng.append(itemName);
			kitchenItemStrng.append("\n");
		}
		kitchenEndStrng.append("..........................");

		Object[] arryToHoldElems = new Object[6];
		arryToHoldElems[0] = kot;
		arryToHoldElems[1] = strName;
		arryToHoldElems[2] = secndString;
		arryToHoldElems[3] = thrdString;
		arryToHoldElems[4] = noOfPersons;
		arryToHoldElems[5] = mapToHoldItems;
		return arryToHoldElems;
	}

	public Object[] getBillPrintObject(Store store, Order order) {
		String roundOffStatus = store.getRoundOffTotalAmtStatus();
		double totalNonVatItemOrderAmt = 0.0;
		double totalVatItemOrderAmt = 0.0;
		double totalVatAmt = 0.0;
		double totalServceTaxAmt = 0.0;
		// int storeId = order.getStoreId();
		String s = "\\u0020"; // for space
		char c = (char) Integer.parseInt(s.substring(2), 16);

		// store name
		String strName = store.getStoreName();
		// store address
		String address = store.getAddress();
		StringBuffer emailId = new StringBuffer();
		emailId.append("Email:");
		emailId.append(store.getEmailId());
		StringBuffer phoneNumbr = new StringBuffer();
		phoneNumbr.append("Ph:");
		// get phone number
		String phone = store.getPhoneNo();
		phoneNumbr.append(phone);
		StringBuffer vatReg = new StringBuffer();
		vatReg.append("VAT Reg. No: ");
		// get vat reg no.
		String vatRegNo = store.getVatRegNo();
		vatReg.append(vatRegNo);
		StringBuffer serviceTax = new StringBuffer();
		serviceTax.append("Service Tax No: ");
		// get service tax no.
		String serviceTaxNo = store.getServiceTaxNo();
		serviceTax.append(serviceTaxNo);
		StringBuffer invoice = new StringBuffer();
		invoice.append("Order No:  ");
		invoice.append(order.getId() + "");
		StringBuffer dateTable = new StringBuffer();
		dateTable.append("Date: ");
		// get order date
		String orderDate = order.getOrderTime();
		/*
		 * String ordDate = new SimpleDateFormat("dd/MM/yyyy")
		 * .format(orderDate);
		 */
		dateTable.append(orderDate);
		// dateTable.append("    ");
		StringBuffer tableNoStrng = new StringBuffer();
		tableNoStrng.append("Table No. ");
		// get table no.
		String tableNo = order.getTable_no();
		if (tableNo != null && tableNo.length() > 0) {
			tableNoStrng.append(tableNo);
		} else {
			tableNoStrng.append("");
		}
		String kitchenPrnt = "";
		String kot = "         KOT";
		StringBuffer kitchenHdrStrng = new StringBuffer();
		StringBuffer kitchenItemStrng = new StringBuffer();
		StringBuffer kitchenEndStrng = new StringBuffer();
		// StringBuffer itemNameStrng = new StringBuffer();
		String finalItemName = "";
		String upTo3Characters = strName.substring(0,
				Math.min(strName.length(), 3));
		kitchenHdrStrng.append(kot);
		kitchenHdrStrng.append("\n");
		kitchenHdrStrng.append(strName); // 1st string
		kitchenHdrStrng.append("\n");
		// get order time
		String ordeTime = order.getOrderTime();

		String[] tempURL = ordeTime.split("/");
		String day = tempURL[0];
		String mnth = tempURL[1];
		String dayMnth = day + "/" + mnth;
		String[] tempURL1 = ordeTime.split(" ");
		String time = tempURL1[1];
		System.out.println("dayMnth.." + dayMnth);
		System.out.println("time.." + time);
		String[] timefull = time.split(":");
		String hr = timefull[0];
		String mins = timefull[1];
		String hrMins = hr + ":" + mins;
		System.out.println("hr mins:::  " + hrMins);
		String dtTime = dayMnth + " " + hrMins;
		System.out.println("dttime:: " + dtTime);
		StringBuffer secndString = new StringBuffer();
		secndString.append(dtTime); // 2nd string start
		secndString.append(" ");
		// get order taken by person info
		Customer customer = order.getCustomers();
		int custId = customer.getId();
		secndString.append("(");
		if (custId > 0) {
			secndString.append("" + custId);
		}
		secndString.append(")"); // 2nd string end
		kitchenHdrStrng.append("\n");
		StringBuffer thrdString = new StringBuffer();
		thrdString.append("Order No:"); // 3rd string start
		thrdString.append("" + order.getId());
		thrdString.append(",");
		thrdString.append("Table-");
		// get table no.
		String tblNo = order.getTable_no();
		if (tblNo != null && tblNo.length() > 0) {
			thrdString.append(tblNo);
		} else {
			thrdString.append("");
		}
		// 3rd string end
		// 4th string start
		String noOfPersons = "No. of persons:" + order.getNoOfPersons() + "";
		// 4th string end
		kitchenHdrStrng.append("\n\n");

		// declare a map to hold item name, item quantity
		// get items from order
		Map<Integer, List<String>> mapToHoldItems = new LinkedHashMap<Integer, List<String>>();
		List<OrderItem> orderItemLst = order.getOrderitem();
		Iterator<OrderItem> ordrItr = orderItemLst.iterator();
		while (ordrItr.hasNext()) {
			OrderItem orderItem = (OrderItem) ordrItr.next();
			// get the special note
			String specialNote = orderItem.getSpecialNote();
			MenuItem menuItem = orderItem.getItem();
			String itemName = menuItem.getName();
			int itemId = menuItem.getId();
			StringBuffer nameNSpecl = new StringBuffer();
			nameNSpecl.append(itemName);
			nameNSpecl.append("\n" + "##");
			nameNSpecl.append(specialNote);
			String nameWithSpclNote = nameNSpecl.toString();
			// String nameWithSpclNote=itemName+"##"+specialNote;
			int itemLength = itemName.length();
			int maxLength = 28;

			/*
			 * if (itemLength > maxLength) itemName = itemName.substring(0,
			 * Math.min(itemName.length(), maxLength));
			 * 
			 * itemLength = itemName.length(); StringBuffer itemNameStrng = new
			 * StringBuffer(); if (itemLength < maxLength + 1) {
			 * itemNameStrng.append(itemName); int remLength = maxLength -
			 * itemLength; for (int i = 1; i <= remLength; i++) {
			 * itemNameStrng.append(c); itemNameStrng.append(c);
			 * 
			 * }
			 * 
			 * itemName = itemNameStrng.toString(); }
			 */
			String quantity = orderItem.getQuantityOfItem();
			double totalPriceByItem = orderItem.getTotalPriceByItem();
			DecimalFormat decim = new DecimalFormat("00.00");
			String totalPriceItem = decim.format(totalPriceByItem);
			List<String> itemLst = new ArrayList<String>();
			itemLst.add(0, itemName);
			itemLst.add(1, quantity);
			itemLst.add(2, totalPriceItem);

			List<String> itemLstOld = mapToHoldItems.get(itemId);

			if (itemLstOld != null && itemLstOld.size() > 0) {
				itemLst.set(1, new Integer(itemLstOld.get(1))
						+ new Integer(itemLst.get(1)) + "");

				double total = new Double(itemLstOld.get(2))
						+ new Double(itemLst.get(2));
				DecimalFormat dec = new DecimalFormat("00.00");
				String totalPrice = dec.format(total);
				itemLst.set(2, totalPrice);

			}

			mapToHoldItems.put(itemId, itemLst);

			// calculate non Vat item order amount
			double vatForItem = menuItem.getVat();
			double itemPrice = menuItem.getPrice();
			// double totalPriceItem=orderItem.getTotalPriceByItem();

			// service tax calculation for each item
			Double itemDiscPer = new Double(menuItem.getPromotionValue());
			Double itemDisc = (itemDiscPer * totalPriceByItem) / 100;
			Double itemServiceTax = menuItem.getServiceTax();
			Double serviceTaxForThsItem = (itemServiceTax * (totalPriceByItem - itemDisc)) / 100;
			if (order.getTable_no().trim().equalsIgnoreCase("0")) {

				if (store.getParcelServiceTax().equalsIgnoreCase("N")) {

					serviceTaxForThsItem = 0.0;

				}
			}
			totalServceTaxAmt = totalServceTaxAmt + serviceTaxForThsItem;

			if (vatForItem <= 0.0) {
				totalNonVatItemOrderAmt = totalNonVatItemOrderAmt
						+ totalPriceByItem;
			} else if (vatForItem > 0.0) {
				totalVatItemOrderAmt = totalVatItemOrderAmt + totalPriceByItem;

				double vatForThsItem = (vatForItem * (totalPriceByItem - itemDisc)) / 100;
				if (order.getTable_no().trim().equalsIgnoreCase("0")) {

					if (store.getParcelVat().equalsIgnoreCase("N")) {

						vatForThsItem = 0.0;

					}
				}
				totalVatAmt = totalVatAmt + vatForThsItem;
			}

			itemName = String.format("%-35s:%s", itemName, quantity);
			kitchenItemStrng.append(itemName);
			kitchenItemStrng.append("\n");
		}
		// create a list to hold the non vat item order amount
		DecimalFormat decim = new DecimalFormat("00.00");
		String totalNonVatItemOrdrAmt = decim.format(totalNonVatItemOrderAmt);
		List<String> nonVatItemOrdrAmt = new ArrayList<String>();
		nonVatItemOrdrAmt.add(0, "Non Vat Item Order Amt");
		nonVatItemOrdrAmt.add(1, totalNonVatItemOrdrAmt);

		// create a list to hold the vat item order amount
		List<String> vatItemOrdrAmt = new ArrayList<String>();
		DecimalFormat decim1 = new DecimalFormat("00.00");
		String totalVatItemOrdrAmt = decim1.format(totalVatItemOrderAmt);
		vatItemOrdrAmt.add(0, "Vat Item Order Amt");
		vatItemOrdrAmt.add(1, totalVatItemOrdrAmt);

		// create a list to hold the total order amount
		double totalOrderAmt = totalNonVatItemOrderAmt + totalVatItemOrderAmt;
		List<String> totalAmt = new ArrayList<String>();
		DecimalFormat decim2 = new DecimalFormat("00.00");
		String totalOrderAmtStr = decim2.format(totalOrderAmt);
		totalAmt.add(0, "Total Order Amt");
		totalAmt.add(1, totalOrderAmtStr);

		// create a list to hold the vat
		List<String> vatAmtLst = new ArrayList<String>();
		vatAmtLst.add(0, "VAT @14.50%");
		// double roundOffVat = Math.round(totalVatAmt * 100.0) / 100.0;
		DecimalFormat decim3 = new DecimalFormat("00.00");
		String roundOffVatStr = decim3.format(totalVatAmt);
		vatAmtLst.add(1, roundOffVatStr);

		// create a list to hold the service tax
		double servcTax = 0.0;
		List<String> servcTaxLst = new ArrayList<String>();
		// double roundOffStax = Math.round(totalServceTaxAmt * 100.0) /
		// 100.0;
		DecimalFormat decim4 = new DecimalFormat("00.00");
		String roundOffStaxStr = decim4.format(totalServceTaxAmt);
		servcTaxLst.add(0, "S Tax @4.44%");
		servcTaxLst.add(1, roundOffStaxStr);

		// create a list to hold the discount
		Double totalDiscnt = 0.0;
		Bill bill = orderService.getBillById(order.getId());
		Double discount = bill.getCustomerDiscount();
		if (discount != null)
			totalDiscnt = discount;
		Double itemsDiscount = bill.getTotalDiscount();
		if (itemsDiscount != null)
			totalDiscnt = totalDiscnt + itemsDiscount;

		List<String> discntLst = new ArrayList<String>();
		String dscntStr = decim4.format(totalDiscnt.doubleValue());
		discntLst.add(0, "Discount");
		discntLst.add(1, dscntStr);

		// create a list to hold the gross bill
		List<String> grossLst = new ArrayList<String>();
		double gross = 0.0;
		double dscnt = 0.0;
		// calculate gross
		// if (discount != null & itemDiscount != null)
		{
			dscnt = totalDiscnt;

		}

		if (order.getTable_no().trim().equalsIgnoreCase("0")) {
			totalServceTaxAmt = 0.0;
		}

		System.out.println("totalOrderAmt   " + totalOrderAmt + " totalVatAmt "
				+ totalVatAmt + " totalServceTaxAmt " + totalServceTaxAmt
				+ " dscnt " + dscnt);
		gross = (totalOrderAmt + totalVatAmt + totalServceTaxAmt) - dscnt;

		if (roundOffStatus != null && !roundOffStatus.equalsIgnoreCase("")
				&& roundOffStatus.equalsIgnoreCase("Y")) {
			gross = new Double(Math.round(gross)); // round
		}

		String roundOffGrossStr = decim4.format(gross);
		if (roundOffStatus != null && !roundOffStatus.equalsIgnoreCase("")
				&& roundOffStatus.equalsIgnoreCase("Y")) {
			grossLst.add(0, "Total(Round off)");
		} else {
			grossLst.add(0, "Total");
		}

		grossLst.add(1, roundOffGrossStr);

		// create a list to hold the paid amount
		List<String> paidAmtLst = new ArrayList<String>();

		double amount = 0.0;
		double paidAmount = 0.0;
		double amtToPay = 0.0;

		try {
			List<Payment> paymentLst = orderService.getPaymentListById(order
					.getId());
			Iterator<Payment> iterator = paymentLst.iterator();
			while (iterator.hasNext()) {
				Payment payment = (Payment) iterator.next();
				amount = payment.getAmount();
				paidAmount = paidAmount + payment.getPaidAmount();
			}
			amtToPay = amount - paidAmount;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String paidAmountToTwoDecimalPlaces = decim4.format(paidAmount);
		paidAmtLst.add(0, "Paid Amount");
		paidAmtLst.add(1, paidAmountToTwoDecimalPlaces);

		// create a list to hold the amount to pay
		List<String> amtToPayLst = new ArrayList<String>();

		String amtToPayToTwoDecimalPlaces = decim4.format(amtToPay);
		amtToPayLst.add(0, "Amount to Pay");
		amtToPayLst.add(1, amtToPayToTwoDecimalPlaces);

		kitchenEndStrng.append("..........................");

		// String s = "\\u0020"; //for space
		// char c = (char) Integer.parseInt(s.substring(2), 16);
		int orientation = 1;
		// String data =
		// "PIZA HUT:2015-01-15::16.18\nOrder No:1752,T-14\n\nChowin: 3\nChicken Tikka: 2\n--------------------";
		/*
		 * kitchenPrnt = kitchenHdrStrng.toString() +
		 * kitchenItemStrng.toString() + kitchenEndStrng.toString();
		 */

		Object[] arryToHoldElems = new Object[20];
		// arryToHoldElems[0] = kot;
		arryToHoldElems[0] = strName;
		arryToHoldElems[1] = address;
		arryToHoldElems[2] = emailId.toString();
		arryToHoldElems[3] = phoneNumbr.toString();
		arryToHoldElems[4] = vatReg.toString();
		arryToHoldElems[5] = serviceTax.toString();
		arryToHoldElems[6] = invoice.toString();
		arryToHoldElems[7] = dateTable.toString();
		arryToHoldElems[8] = mapToHoldItems;
		arryToHoldElems[9] = nonVatItemOrdrAmt;
		arryToHoldElems[10] = vatItemOrdrAmt;
		arryToHoldElems[11] = totalAmt;
		arryToHoldElems[12] = vatAmtLst;
		arryToHoldElems[13] = servcTaxLst;
		arryToHoldElems[14] = discntLst;
		arryToHoldElems[15] = grossLst;
		arryToHoldElems[16] = tableNoStrng.toString();
		arryToHoldElems[17] = paidAmtLst;
		arryToHoldElems[18] = amtToPayLst;

		return arryToHoldElems;
	}

	public String getTodayDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		// java.util.Calendar cal=java.util.Calendar.getInstance();
		System.out.println("date:" + df.format(date));
		return df.format(date);
	}
	
	@RequestMapping(value = "/orderpaymentFromAdmin",
			method = RequestMethod.POST)
public void orderPaymentFromAdmin(	@RequestBody String orderPaymentAdminString,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in orderpayment...{},{}, {}, {},{},{},{},{}", orderPaymentAdminString);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	Order order = new Order();
	/*order.setId(NumberUtils.toInt(orderno));*/
	Payment payment = new Payment();
	/*payment.setOrderPayment(order);*/
	/*payment.setAmount(NumberUtils.toDouble(amount));
	payment.setPaidAmount(NumberUtils.toDouble(paidAmount));
	payment.setAmountToPay(NumberUtils.toDouble(amountToPay));
	payment.setTenderAmount(NumberUtils.toDouble(tenderAmount));
	payment.setPaymentMode(paymentMode);
	payment.setCardLastFourDigits(digit);*/

	Gson gson = new GsonBuilder().create();
	Payment paymentObj = gson.fromJson(orderPaymentAdminString, new TypeToken<Payment>() {}.getType());

	/*paymentObj.setOrderPayment(order);*/
	paymentObj.setStoreId(customer.getStoreId());
	paymentObj.setSource("web");
	paymentObj.setCreatedBy(customer.getContactNo());
	paymentObj.setCreationDate(getOrderTime());
	out.print(orderService.orderPayment(paymentObj));
	out.flush();
}

}
	
	
	
	@RequestMapping(value = "/getprintcount/{orderid}",
			method = RequestMethod.GET)
public void getPrintCount(	@PathVariable("orderid") String orderid,
						HttpSession session,
						HttpServletResponse response) throws IOException {
logger.debug("in getPrintCount...{}", orderid);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	out.print(orderService.getBillPrintCount(NumberUtils.toInt(orderid), customer.getStoreId()));
	out.flush();
}
}
	
	@RequestMapping(value = "/searchorderbyid/{orderid}",
			method = RequestMethod.GET)
public void searchUnpaidOrderById(	@PathVariable("orderid") String orderid,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in searchUnpaidOrderById...{}", orderid);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	Gson gson = new Gson();
	String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
	//	Order order = orderService.getOrderById(NumberUtils.toInt(orderid));
	Order order = orderService.getUnpaidOrderById(NumberUtils.toInt(orderid), customer.getStoreId(), selLang);
	out.print(gson.toJson(order));
	out.flush();
}
}
	
	
	
	
	
	@RequestMapping(value = "/searchcustbyname",
			method = RequestMethod.GET)
			public void searchCustomerByName(	@RequestParam(value = "term") String tagName,
								HttpSession session,
								HttpServletResponse response) throws IOException {
			logger.debug("in searchCustomerByName...{}", tagName);
			Customer customer;
			if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			Gson gson = new Gson();
			String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
			String custList = orderService.getCustContactsbyName(customer.getStoreId(), tagName);
			out.print(gson.toJson(custList));
			out.flush();
			}
	
	
}
	
	@RequestMapping(value = "/searchlocation",
			method = RequestMethod.GET)
public void searchLocation(	@RequestParam(value = "term") String tagName,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in searchLocation...{}", tagName);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("application/json");
	Gson gson = new Gson();
	String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
	String locList = orderService.getLocList(customer.getStoreId(), tagName);
	out.print(gson.toJson(locList));
	out.flush();
}
}	
	
	/*@RequestMapping(value = "/setordertypeservicecharge", method = RequestMethod.GET)
	public void setServiceCharge(	@RequestParam(value = "matchedOrderType") String matchedOrderType,
			 HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in setordertypeservicecharge...{}", matchedOrderType);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			OrderType orderType =gson.fromJson(matchedOrderType, new TypeToken<OrderType>() {
			}.getType());
			
			session.setAttribute("matchedOrderType", orderType);
		//	out.print(orderService.getPaymentInfo(NumberUtils.toInt(orderno)));
			out.flush();
		}
	}*/
	
	@RequestMapping(value = "/setordertypeservicecharge", method = RequestMethod.POST)
	public void setServiceCharge(	@RequestBody String matchedOrderType ,
			 HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.debug("in setordertypeservicecharge...{}", matchedOrderType);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			OrderType orderType =gson.fromJson(matchedOrderType, new TypeToken<OrderType>() {
			}.getType());
			
			session.setAttribute("matchedOrderType", orderType);
		//	out.print(orderService.getPaymentInfo(NumberUtils.toInt(orderno)));
			out.flush();
		}
	}
	
	@RequestMapping(value = "/getspecificorder/{orderNo}", method = RequestMethod.GET)
	public void getSpecificOrder(@PathVariable("orderNo") String orderNo,
			 HttpSession session,
			HttpServletResponse response) throws IOException {
	//	logger.debug("in getpaymentinfo...{}", orderno);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			Order order = orderService.getOrderById(NumberUtils.toInt(orderNo));
			out.print(gson.toJson(order));
			out.flush();
		}
	}
	
	
	
	
	@RequestMapping(value = "/getcustomerdetailsbyid/{custId}", method = RequestMethod.GET)
	public void getcustomerdetailsbyid(@PathVariable("custId") String custId,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.debug("In getcustomerdetails Details......{}", custId);
		Customer customer;
		if ((customer = (Customer) session
				.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(orderService.getCustDetailsbyid(custId,
					customer.getStoreId()));
			out.flush();
		}
	}
	
	
@RequestMapping(value = "/reload",
			method = RequestMethod.GET)
public void welcome(Model model,
						HttpSession session,HttpServletResponse response) throws IOException {
logger.debug("In welcome......");
//ModelAndView mav = new ModelAndView();
Customer customer = null;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
Store store=storeService.getStoreById(customer.getStoreId());

session.setAttribute(Constants.LOGGED_IN_STORE, store);
List<PosModules> posModuless=storeService.getPosModulesByUserId(customer.getContactNo(), customer.getStoreId());

session.setAttribute("posModuless", posModuless);

Menu menu=(Menu)session.getAttribute(Constants.MENU_ALL_TREE);


	Menu allMenuList = menuService
			.getAllMenuListLogin(customer.getStoreId(),session);
	session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);

out.print("success");
out.flush();

}
}
	
// for order refund
@RequestMapping(value = "/openorderrefund", method = RequestMethod.GET)
public ModelAndView loadRefundOrder(Model model, HttpSession session) {

	logger.debug("In viewallpaidorder......");
	List<Order> allpaidOrderList = null;
	ModelAndView mav = new ModelAndView();
	Customer customer = null;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	String allpaidOrder = orderService.getPaidOrderList(customer.getStoreId(), getTodayDate());
	Gson gson = new Gson();
	allpaidOrderList = gson.fromJson(allpaidOrder, new TypeToken<List<Order>>() {
	}.getType());
	List<ReturnTypes> returntypelist = orderService.getAllReturntypes(customer.getStoreId());

	mav.addObject("reasons", returntypelist);
	mav.addObject("allpaidOrderList", allpaidOrderList);
	mav.addObject("today", new Date());
	Store store = storeService.getStoreById(customer.getStoreId());
	System.out.println("___is_acc_in order___" + store.getIs_account());
	mav.addObject("is_acc", store.getIs_account());
	mav.setViewName(ForwardConstants.VIEW_REFUND_ORDER_PAGE);
	return mav;
}
@RequestMapping(value = "/searchorderbyOrderNumber/{orderno}", method = RequestMethod.GET)
public void searchpaidOrderByOrderNo(@PathVariable("orderno") String orderno, HttpSession session,
		HttpServletResponse response) throws IOException {
	logger.debug("in searchpaidOrderById...{}", orderno);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		Gson gson = new Gson();
		List<Order> orders = orderService.getPaidOrderByOrderNo(orderno, customer.getStoreId());
		out.print(gson.toJson(orders));
		out.flush();
	}
}

@RequestMapping(value = "/getpaidorderdatabyid/{orderid}", method = RequestMethod.GET)
public ModelAndView getPaidOrderDetailsById(@PathVariable("orderid") String orderid, Model model,
		HttpSession session, HttpServletRequest request, HttpServletResponse response) {
	logger.debug("In getPaidOrderDetailsById......{}", orderid);
	Gson gson = new GsonBuilder().create();
	Customer customer = null;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	try {
		String paidorder = orderService.getPaidOrderDetailsDataById(orderid, customer.getStoreId());
		logger.debug("Response : " + paidorder);
		if(customer.getStoreId()==120) {
			List<Order> orderOb = gson.fromJson(paidorder, new
					 TypeToken<List<Order>>() {}.getType());
			if(orderOb!=null){
				List<OrderItem> orderItemList = orderOb.get(0).getOrderitem();
				//List<OrderItem> itemlist = new ArrayList<OrderItem>();
				List<OrderItem> packingitemlist = new ArrayList<OrderItem>();
				for (OrderItem orderitems : orderItemList) {
					if(StringUtils.equalsIgnoreCase(orderitems.getItem().getPackaged(), "Y"))
						{
						packingitemlist.add(orderitems);
						}
					}
				orderOb.get(0).setOrderitem(packingitemlist);
				paidorder=gson.toJson(orderOb);
				}
		}
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/plain");
		out.print(paidorder);
		out.flush();
		return null;
	} catch (IOException e) {
		return null;
	}

}

@RequestMapping(value = "/viewallpaidorderbydateforrefund", method = RequestMethod.POST)
public ModelAndView viewAllPaidOrderByDateForRefund(Model model, HttpSession session,
		@ModelAttribute("order") Order order) {

	logger.debug("In viewallpaidorder......");
	System.out.println("ordergetOrderDate()=" + order.getOrderDate());
	String pattern = "yyyy-MM-dd";
	Date date = null;
	SimpleDateFormat format = new SimpleDateFormat(pattern);
	try {
		date = format.parse(order.getOrderDate());
		System.out.println(date);
	} catch (ParseException e) {
		e.printStackTrace();
	}
	List<Order> allpaidOrderList = null;
	ModelAndView mav = new ModelAndView();
	Customer customer = null;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	String allpaidOrder = orderService.getPaidOrderList(customer.getStoreId(), order.getOrderDate());
	Gson gson = new Gson();
	allpaidOrderList = gson.fromJson(allpaidOrder, new TypeToken<List<Order>>() {
	}.getType());
	List<ReturnTypes> returntypelist = orderService.getAllReturntypes(customer.getStoreId());
	mav.addObject("reasons", returntypelist);

	mav.addObject("allpaidOrderList", allpaidOrderList);
	mav.addObject("today", date);
	mav.setViewName(ForwardConstants.VIEW_REFUND_ORDER_PAGE);

	return mav;
}

@RequestMapping(value = "/searchbillbyidforprint/{orderid}", // not user
method = RequestMethod.GET)
public void getBillDetailsForShow(	@PathVariable("orderid") String orderid,
					HttpSession session,
					HttpServletResponse response) throws IOException {
	logger.debug("in getBillDetailsForShow...{}", orderid);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	Gson gson = new Gson();
	String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
	Bill bill = orderService.getBillById(Integer.parseInt(orderid));
	out.print(gson.toJson(bill));
	out.flush();
	}
 }

@RequestMapping(value = "/setorderremarks", method = RequestMethod.POST)
public void setOrderRemarks(@RequestBody String orderstring, HttpSession session, HttpServletResponse response) throws IOException {
	logger.debug("in setOrderRemarks...{}", orderstring);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		Gson gson = new Gson();
		Order cancelOrder = gson.fromJson(orderstring, new TypeToken<Order>() {
		}.getType());
		cancelOrder.setStoreId(customer.getStoreId());
		String res = orderService.setOrderRemarks(cancelOrder);
		out.print(res);
		out.flush();
	}
}

@RequestMapping(value = "/setpackagingnotes", method = RequestMethod.POST)
public void setPackagingNotes(@RequestBody String orderstring, HttpSession session, HttpServletResponse response) throws IOException {
	logger.debug("in setpackagingnotes...{}", orderstring);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		Gson gson = new Gson();
		Order cancelOrder = gson.fromJson(orderstring, new TypeToken<Order>() {
		}.getType());
		cancelOrder.setStoreId(customer.getStoreId());
		String res = orderService.setPackagingNotes(cancelOrder);
		out.print(res);
		out.flush();
	}
}

}

	
	
	
	
	
	
	
	
	



