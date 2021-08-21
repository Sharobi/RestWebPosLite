/**
 * 
 */
package com.sharobi.webpos.inv.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InvStockOutFB;
import com.sharobi.webpos.inv.model.InvStockOutForm;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryStockInItem;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.InventoryStockOutDetails;
import com.sharobi.webpos.inv.model.InventoryStockOutItems;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.model.StockOutMenuCategory;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.StockOutService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

/**
 * @author habib
 * 
 */
@SessionAttributes({ "invStockOutForm" })
@Controller
@RequestMapping("/stockout")
public class StockOutController {
	private final static Logger logger = LogManager.getLogger(StockOutController.class);
	private final static StockOutService stockOutService = new StockOutService();
	private final static InventoryService inventoryService = new InventoryService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/viewstockout",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) {
		logger.debug("In viewstockout......");
		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockOut> inventoryStockOutList = null;
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		double grandTotalItemPrice = 0.0;
		int stockOutId = 0;
		String newStockOut = "N";

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
		String date = dateFormat.format(currDate);
		String dateTime = dateTimeFmt.format(currDate);
		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		if (inventoryStockOutList.size() != 0) {
			for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
				stockOutId = inventoryStockOut.getId();

				invStockOutDetails.setId(inventoryStockOut.getId());
				invStockOutDetails.setUserId(inventoryStockOut.getUserId());
				invStockOutDetails.setCreatedDate(inventoryStockOut.getCreatedDate());
				invStockOutDetails.setTime(inventoryStockOut.getTime());
				invStockOutDetailList.add(invStockOutDetails);

				inventoryStockOutItemList = inventoryStockOut.getInventoryStockOutItemList();
				break;
			}

			for (InventoryStockOutItems inventoryStockOutItems : inventoryStockOutItemList) {
				double itemTotalPrice = inventoryStockOutItems.getTotalPrice();
				grandTotalItemPrice += itemTotalPrice;
			}

		} else {
			invStockOutDetails = new InventoryStockOutDetails();
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);
		}

		session.removeAttribute("invStockOutFbList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", stockOutId);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
		session.setAttribute("newStockOut", newStockOut);
		session.setAttribute("itemAddFlag", "N");
		return mav;
	}

	@RequestMapping(value = "/viewstockoutByDate",
					method = RequestMethod.GET)
	public ModelAndView stockOutByDate(	@RequestParam String date,
										Model model,
										HttpSession session,
										HttpServletRequest request) throws ParseException {
		logger.debug("In stockOutByDate......");
		Customer customer = new Customer();
		List<InventoryStockOut> inventoryStockOutList = null;
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		double grandTotalItemPrice = 0.0;
		String newStockOut = "N";
		int stockOutId = 0;
		Date currDate = new Date();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
		Date utilDate = dateFormat.parse(date);
		String today = dateFormat.format(currDate);
		logger.debug("Today String : " + today);
		String dateTime = dateTimeFmt.format(currDate);
		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(utilDate));
		if (inventoryStockOutList.size() != 0) {
			for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
				stockOutId = inventoryStockOut.getId();

				invStockOutDetails.setId(inventoryStockOut.getId());
				invStockOutDetails.setUserId(inventoryStockOut.getUserId());
				invStockOutDetails.setCreatedDate(inventoryStockOut.getCreatedDate());
				invStockOutDetails.setTime(inventoryStockOut.getTime());
				invStockOutDetailList.add(invStockOutDetails);

				inventoryStockOutItemList = inventoryStockOut.getInventoryStockOutItemList();
				break;
			}

			for (InventoryStockOutItems inventoryStockOutItems : inventoryStockOutItemList) {
				double itemTotalPrice = inventoryStockOutItems.getTotalPrice();
				grandTotalItemPrice += itemTotalPrice;
			}
		} else {
			if (today.equalsIgnoreCase(date)) {
				newStockOut = "Y";
			}
			invStockOutDetails = new InventoryStockOutDetails();
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);
		}
		session.removeAttribute("invStockOutFbList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", stockOutId);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(utilDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
		session.setAttribute("newStockOut", newStockOut);
		session.setAttribute("itemAddFlag", "N");
		return mav;
	}

	@RequestMapping(value = "/stockoutByPoId",
					method = RequestMethod.GET)
	public ModelAndView stockOutByPoId(	@RequestParam String stockOutId,
										@RequestParam String date,
										Model model,
										HttpSession session,
										HttpServletRequest request) throws ParseException {
		logger.debug("In stockOutByPoId......");
		Customer customer = new Customer();
		List<InventoryStockOut> inventoryStockOutList = new ArrayList<InventoryStockOut>();
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		double grandTotalItemPrice = 0.0;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date utilDate = dateFormat.parse(date);
		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(utilDate));
		if (inventoryStockOutList.size() != 0) {

			List<InventoryStockOut> invtStockOutList = stockOutService.getStockOutByPoId(customer.getStoreId(), stockOutId);
			for (InventoryStockOut inventoryStockOut : invtStockOutList) {

				invStockOutDetails.setId(inventoryStockOut.getId());
				invStockOutDetails.setUserId(inventoryStockOut.getUserId());
				invStockOutDetails.setCreatedDate(inventoryStockOut.getCreatedDate());
				invStockOutDetails.setTime(inventoryStockOut.getTime());
				invStockOutDetailList.add(invStockOutDetails);

				inventoryStockOutItemList = inventoryStockOut.getInventoryStockOutItemList();

				break;
			}

			for (InventoryStockOutItems inventoryStockOutItems : inventoryStockOutItemList) {
				double itemTotalPrice = inventoryStockOutItems.getTotalPrice();
				grandTotalItemPrice += itemTotalPrice;
			}
		}
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", NumberUtils.toInt(stockOutId));
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(utilDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
		session.setAttribute("newStockOut", "N");
		session.setAttribute("itemAddFlag", "N");
		return mav;
	}

	@RequestMapping(value = "/newstockout",
					method = RequestMethod.GET)
	public ModelAndView newStockOut(Model model,
									HttpSession session,
									HttpServletRequest request) throws ParseException {
		logger.debug("In newStockOut......");
		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockOut> inventoryStockOutList = new ArrayList<InventoryStockOut>();
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
		String podate = (String) session.getAttribute("podate");
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
		String date = dateFormat.format(currDate);
		String dateTime = dateTimeFmt.format(currDate);
		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		if (inventoryStockOutList.size() != 0) {
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);

		} else {
			invStockOutDetails = new InventoryStockOutDetails();
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);
		}

		session.removeAttribute("invStockOutFbList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("invStockOutForm", new InvStockOutForm());
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", 0);
		session.setAttribute("podate", podate);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", "00.0");
		session.setAttribute("newStockOut", "Y");
		session.setAttribute("itemAddFlag", "N");
		return mav;
	}

	@RequestMapping(value = "/getItemInfoFromPage/{itemCode}/{qty}/{unit}/{menuCategoryName}/{total}/{sumTotal}",
					method = RequestMethod.GET)
	public ModelAndView getItemInfoFromPage(@PathVariable String itemCode,
											@PathVariable String qty,
											@PathVariable String unit,
											@PathVariable String menuCategoryName,
											@PathVariable String total,
											@PathVariable String sumTotal,
											HttpSession session) throws ParseException {
		logger.debug("In getItemInfoFromPage......");
		Customer customer = new Customer();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		List<InvStockOutFB> invStockOutFBs = (List<InvStockOutFB>) session.getAttribute("invStockOutFbList");
		boolean flag = invStockOutFBs == null ? true : false;

		if (flag == false) {
			for (InvStockOutFB invStockOutFB : invStockOutFBs) {
				String itmCode = invStockOutFB.getItemCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					System.out.println("getItemInfoFromPage invStockOutFbList unit="+unit);
					invStockOutFB.setItemQuantity(NumberUtils.toDouble(qty));
					invStockOutFB.setMetricUnitId(NumberUtils.toInt(unit));
					invStockOutFB.setTotalPrice(NumberUtils.toDouble(total));
					invStockOutFB.setMenuCategoryName(menuCategoryName);
					System.out.println("getItemInfoFromPage invStockOutFbList unit="+invStockOutFB.getMetricUnitId());
					System.out.println("getItemInfoFromPage invStockOutFbList getMenuCategoryName="+invStockOutFB.getMenuCategoryName());
				}
			}
		}
		session.setAttribute("invStockOutFbList", invStockOutFBs);
		session.setAttribute("grandTotalItemPrice", NumberUtils.toDouble(sumTotal));

		return null;
	}

	@RequestMapping(value = "/addnewStockOutRow",
					method = RequestMethod.GET)
	public ModelAndView addnewStockOutRow(	@RequestParam String itemCode,
											Model model,
											HttpSession session,
											HttpServletRequest request) throws ParseException {
		logger.debug("In addnewStockOutRow......");
		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockOut> inventoryStockOutList = new ArrayList<InventoryStockOut>();
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		InventoryStockOutItems inventoryStockOutItem = new InventoryStockOutItems();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		List<InvStockOutFB> invStockOutFbList = new ArrayList<InvStockOutFB>();
		InvStockOutForm invStockOutForm = new InvStockOutForm();
		InvStockOutFB invStockOutFB = new InvStockOutFB();
		double grandTotalPrice = 0.0;
		String stockNumber = null;
		boolean itemCodeFlag = false;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
		String podate = (String) session.getAttribute("podate");
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
		String date = dateFormat.format(currDate);
		String dateTime = dateTimeFmt.format(currDate);

		List<StockOutMenuCategory> menuCategoryList = stockOutService.getMenuCategoryByStoreId(customer.getStoreId());
		logger.debug("menuCategoryList ...{} :", menuCategoryList);

		List<InvStockOutFB> invStockOutFBs = (List<InvStockOutFB>) session.getAttribute("invStockOutFbList");
		boolean flag = invStockOutFBs == null ? true : false;

		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		if (inventoryStockOutList.size() != 0) {
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);

		} else {
			invStockOutDetails = new InventoryStockOutDetails();
			invStockOutDetails.setId(0);
			invStockOutDetails.setUserId(customer.getContactNo());
			invStockOutDetails.setCreatedDate(date);
			invStockOutDetails.setTime(dateTime);
			invStockOutDetailList.add(invStockOutDetails);
		}

		inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());
		for (InventoryItems inventoryItem : inventoryItemList) {
			String itmCode = inventoryItem.getCode();
			if (itmCode.equalsIgnoreCase(itemCode)) {
				logger.debug("Inventory Item code ::" + itmCode);
				inventoryItems = inventoryItem;
				break;
			}
		}
		logger.debug("Fetched inventoryItems :: {}", inventoryItems);
		double itemPrice = inventoryItems.getRate();
		if (flag == false) {
			invStockOutFbList = invStockOutFBs;
			for (InvStockOutFB stockOutFB : invStockOutFbList) {
//				System.out.println("stockOutFBgetMetricUnitId="+stockOutFB.getMetricUnitId());
//				invStockOutFB.setMetricUnitId(stockOutFB.getMetricUnitId());
				String stockOuttemcode =  stockOutFB.getItemCode();
				if (stockOuttemcode.equalsIgnoreCase(itemCode)) {
					itemCodeFlag = true;
				}
				double totalPrice = stockOutFB.getTotalPrice();
				grandTotalPrice += totalPrice;
			}
		}
		int itemId = inventoryItems.getId();
		stockNumber = inventoryService.getCurrentStockByItem(customer.getStoreId(), itemId);
		logger.debug("Current Stock for given item : " + stockNumber);
		if(!itemCodeFlag){
		invStockOutFB.setId(0);
		invStockOutFB.setItemCode(inventoryItems.getCode());
		invStockOutFB.setItemName(inventoryItems.getName());
		invStockOutFB.setCurrentStock(NumberUtils.toDouble(stockNumber));
		invStockOutFB.setItemQuantity(1);
		invStockOutFB.setItemUnit(inventoryItems.getUnit());
		invStockOutFB.setMetricUnitId(inventoryItems.getMetricUnitId());
		invStockOutFB.setItemRate(itemPrice);
		invStockOutFB.setTotalPrice(itemPrice);
		invStockOutFB.setTowhom("");
		invStockOutFbList.add(invStockOutFB);
		}
		session.setAttribute("invStockOutFbList", invStockOutFbList);

		invStockOutForm.setInvStockOutFBList(invStockOutFbList);
		
		grandTotalPrice += itemPrice;
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("invStockOutForm", invStockOutForm);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", 0);
		session.setAttribute("podate", podate);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", grandTotalPrice);
		session.setAttribute("newStockOut", "Y");
		session.setAttribute("itemAddFlag", "Y");
		return mav;
	}

	@RequestMapping(value = "/deleteNewlyAddedStockOutItem",
					method = RequestMethod.GET)
	public ModelAndView deleteNewlyAddedStockOutItem(	@RequestParam String itemCode,
														@RequestParam String residualTotalPrice,
														Model model,
														HttpSession session,
														HttpServletRequest request) throws ParseException {
		logger.debug("In deleteNewlyAddedStockOutItem......");
		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockOut> inventoryStockOutList = new ArrayList<>();
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		List<InvStockOutFB> stockOutFBList = new ArrayList<InvStockOutFB>();
		InvStockOutForm invStockOutForm = new InvStockOutForm();
		String itemAddFlag = "Y";

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
		String podate = (String) session.getAttribute("podate");
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
		String date = dateFormat.format(currDate);
		String dateTime = dateTimeFmt.format(currDate);

		List<StockOutMenuCategory> menuCategoryList = stockOutService.getMenuCategoryByStoreId(customer.getStoreId());
		logger.debug("menuCategoryList ...{} :", menuCategoryList);

		List<InvStockOutFB> invStockOutFbList = (List<InvStockOutFB>) session.getAttribute("invStockOutFbList");

		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));

		invStockOutDetails = new InventoryStockOutDetails();
		invStockOutDetails.setId(0);
		invStockOutDetails.setUserId(customer.getContactNo());
		invStockOutDetails.setCreatedDate(date);
		invStockOutDetails.setTime(dateTime);
		invStockOutDetailList.add(invStockOutDetails);

		for (InvStockOutFB invStockOutFB : invStockOutFbList) {
			String itmCode = invStockOutFB.getItemCode();
			if (!itmCode.equalsIgnoreCase(itemCode)) {
				stockOutFBList.add(invStockOutFB);
			}
		}
		logger.debug("stockOutFBList After deletion ...{} :", stockOutFBList);
		session.setAttribute("invStockOutFbList", stockOutFBList);

		if (stockOutFBList.size() == 0) {
			itemAddFlag = "N";
		}

		invStockOutForm.setInvStockOutFBList(stockOutFBList);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
		logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject("invStockOutDetailList", invStockOutDetailList);
		mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
		mav.addObject("invStockOutForm", invStockOutForm);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("response", "success");
		session.setAttribute("stockOutId", 0);
		session.setAttribute("podate", podate);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalItemPrice", NumberUtils.toDouble(residualTotalPrice));
		session.setAttribute("newStockOut", "Y");
		session.setAttribute("itemAddFlag", itemAddFlag);
		return mav;
	}

	@RequestMapping(value = "/createNewStockOut",
					method = RequestMethod.POST)
	public ModelAndView createNewStockOut(	@ModelAttribute("invStockOutForm") InvStockOutForm invStockOutForm,
											Model model,
											HttpSession session,
											HttpServletRequest request) {
		logger.debug("In createNewStockOut......");
		Customer customer = new Customer();
		Date currDate = new Date();
		InventoryStockOut invtoryStockOut = new InventoryStockOut();
		List<InventoryStockOut> inventoryStockOutList = new ArrayList<InventoryStockOut>();
		InventoryStockOutDetails invStockOutDetails = new InventoryStockOutDetails();
		List<InventoryStockOutDetails> invStockOutDetailList = new ArrayList<InventoryStockOutDetails>();
		List<InventoryStockOutItems> inventoryStockOutItemList = new ArrayList<InventoryStockOutItems>();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		List<InvStockOutFB> invStockOutFBList = new ArrayList<InvStockOutFB>();
		double grandTotalItemPrice = 0.0;
		int stockOutId = 0;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
//		String date = dateFormat.format(currDate);
		String date = Utility.getFormatedDateShort(currDate);
		String dateTime = dateTimeFmt.format(currDate);

		logger.debug("InvStockOutForm...{} : ", invStockOutForm);
		invStockOutFBList = invStockOutForm.getInvStockOutFBList();
		logger.debug("invStockOutFBList...{} : ", invStockOutFBList);

		List<StockOutMenuCategory> menuCategoryList = stockOutService.getMenuCategoryByStoreId(customer.getStoreId());
		logger.debug("menuCategoryList ...{} :", menuCategoryList);

		inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());

		for (InvStockOutFB stockOutFB : invStockOutFBList) {

			for (InventoryItems inventoryItem : inventoryItemList) {
				String itmCode = inventoryItem.getCode();
				if (itmCode.equalsIgnoreCase(stockOutFB.getItemCode())) {
					inventoryItems = inventoryItem;
					System.out.println("stockOutFB.getMetricUnitId()="+stockOutFB.getMetricUnitId());
					inventoryItems.setMetricUnitId(stockOutFB.getMetricUnitId());
					break;
				}
			}

			InventoryStockOutItems inventoryStockOutItem = new InventoryStockOutItems();
			inventoryStockOutItem.setItemQuantity(stockOutFB.getItemQuantity());
			inventoryStockOutItem.setStoreId(customer.getStoreId());
			inventoryStockOutItem.setToWhom(stockOutFB.getMenuCategoryName());
			inventoryStockOutItem.setTime(dateTime);
			inventoryStockOutItem.setCreatedBy(customer.getContactNo());
			inventoryStockOutItem.setCreatedDate(date);
			inventoryStockOutItem.setInventoryItems(inventoryItems);
			MetricUnit metricUnit=new MetricUnit();
			metricUnit.setId(stockOutFB.getMetricUnitId());
			inventoryStockOutItem.setUnit(metricUnit);
			inventoryStockOutItemList.add(inventoryStockOutItem);
		}

		invtoryStockOut.setDate(Utility.getFormatedDateShort(currDate));
		invtoryStockOut.setTime(dateTime);
		invtoryStockOut.setUserId(customer.getContactNo());
		invtoryStockOut.setStoreId(customer.getStoreId());
		invtoryStockOut.setCreatedBy(customer.getContactNo());
		invtoryStockOut.setCreatedDate(date);

		invtoryStockOut.setInventoryStockOutItemList(inventoryStockOutItemList);
		logger.debug("Inventory Stockout Obj ready to be persisted. {}", invtoryStockOut);
		String response = stockOutService.createNewStockOut(invtoryStockOut);
		logger.debug("response : " + response);

		inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));

		if (response.equals("001")) {
			logger.debug("in Respnse 00000000000001");
			if (inventoryStockOutList.size() != 0) {
				for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
					stockOutId = inventoryStockOut.getId();

					invStockOutDetails.setId(inventoryStockOut.getId());
					invStockOutDetails.setUserId(inventoryStockOut.getUserId());
					invStockOutDetails.setCreatedDate(inventoryStockOut.getCreatedDate());
					invStockOutDetails.setTime(inventoryStockOut.getTime());
					invStockOutDetailList.add(invStockOutDetails);

					inventoryStockOutItemList = inventoryStockOut.getInventoryStockOutItemList();

					break;
				}

				for (InventoryStockOutItems inventoryStockOutItems : inventoryStockOutItemList) {
					double itemTotalPrice = inventoryStockOutItems.getTotalPrice();
					grandTotalItemPrice += itemTotalPrice;
				}
			} else {
				invStockOutDetails = new InventoryStockOutDetails();
				invStockOutDetails.setId(0);
				invStockOutDetails.setUserId(customer.getContactNo());
				invStockOutDetails.setCreatedDate(date);
				invStockOutDetails.setTime(dateTime);
				invStockOutDetailList.add(invStockOutDetails);
			}
			logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
			logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("inventoryStockOutList", inventoryStockOutList);
			mav.addObject("invStockOutDetailList", invStockOutDetailList);
			mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
			mav.addObject("menuCategoryList", menuCategoryList);
			mav.addObject("response", "success");
			session.setAttribute("podate", date);
			session.setAttribute("stockOutId", stockOutId);
			session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
			session.setAttribute("loginId", customer.getContactNo());
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("newStockOut", "N");
			session.setAttribute("itemAddFlag", "N");
			return mav;
		} else {
			//inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			if (inventoryStockOutList.size() != 0) {
				for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
					stockOutId = inventoryStockOut.getId();

					invStockOutDetails.setId(inventoryStockOut.getId());
					invStockOutDetails.setUserId(inventoryStockOut.getUserId());
					invStockOutDetails.setCreatedDate(inventoryStockOut.getCreatedDate());
					invStockOutDetails.setTime(inventoryStockOut.getTime());
					invStockOutDetailList.add(invStockOutDetails);

					inventoryStockOutItemList = inventoryStockOut.getInventoryStockOutItemList();

					break;
				}
				grandTotalItemPrice = 0.0;

				for (InvStockOutFB stockOutFB : invStockOutFBList) {
					double itemTotalPrice = stockOutFB.getTotalPrice();
					grandTotalItemPrice += itemTotalPrice;
				}
			} else {
				invStockOutDetails = new InventoryStockOutDetails();
				invStockOutDetails.setId(0);
				invStockOutDetails.setUserId(customer.getContactNo());
				invStockOutDetails.setCreatedDate(date);
				invStockOutDetails.setTime(dateTime);
				invStockOutDetailList.add(invStockOutDetails);
			}
			logger.debug("inventoryStockOutList :: {}", inventoryStockOutList);
			logger.debug("inventoryStockOutItemList :: {}", inventoryStockOutItemList);
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("inventoryStockOutList", inventoryStockOutList);
			mav.addObject("invStockOutDetailList", invStockOutDetailList);
			mav.addObject("inventoryStockOutItemList", inventoryStockOutItemList);
			mav.addObject("menuCategoryList", menuCategoryList);
			mav.addObject("invStockOutForm", invStockOutForm);
			mav.addObject("response", response);
			session.setAttribute("podate", date);
			session.setAttribute("stockOutId", stockOutId);
			session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
			session.setAttribute("loginId", customer.getContactNo());
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("newStockOut", "Y");
			session.setAttribute("itemAddFlag", "Y");
			return mav;
		}
	}
}
