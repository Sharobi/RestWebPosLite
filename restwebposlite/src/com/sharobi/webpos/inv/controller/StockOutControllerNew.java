package com.sharobi.webpos.inv.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryStockIn;
import com.sharobi.webpos.inv.model.InventoryStockInItem;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.InventoryStockOutItems;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.model.StockOutMenuCategory;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.StockOutService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/stockoutnew")
public class StockOutControllerNew {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = LogManager.getLogger(StockOutControllerNew.class);
	private final static StockOutService stockOutService = new StockOutService();
	private final static InventoryService inventoryService = new InventoryService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/loadstockout",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) throws ParseException {
		logger.debug("In loadstockin......");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Date currDate = new Date();
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_NEW_PAGE);
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDateNew(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		Date currdate = new Date();
		String date = dateFormat.format(currdate);
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		return mav;
	}

	@RequestMapping(value = "/getmenucategorylist",
					method = RequestMethod.GET)
	public ModelAndView getMenuCategoryList(Model model,
											HttpSession session,
											HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getmenucategorylist......{}");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		out.print(new Gson().toJson(menuCategoryList).toString());
		out.flush();
		return null;
	}

	@RequestMapping(value = "/createstockout",
					method = RequestMethod.POST)
	public void createStockOut(	@RequestBody String invStockOut,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in createstockout...{}", invStockOut);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
			String date = Utility.getFormatedDateShort(currDate);
			String dateTime = dateTimeFmt.format(currDate);
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockOut inventoryStockOut = gson.fromJson(invStockOut, new TypeToken<InventoryStockOut>() {}.getType());
			for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				InventoryItems inventoryItems = inventoryService.getInventoryItemDetails(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getCode().trim());
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				inventoryStockOutItem.setStoreId(customer.getStoreId());
//				inventoryStockOutItem.setTime(dateTime);
				inventoryStockOutItem.setCreatedBy(customer.getContactNo());
//				inventoryStockOutItem.setCreatedDate(date);
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				MetricUnit metricUnit = new MetricUnit();
				metricUnit.setId(inventoryStockOutItem.getUnitId());
				inventoryStockOutItem.setUnit(metricUnit);
			}
//			inventoryStockOut.setDate(date);
//			inventoryStockOut.setTime(dateTime);
			inventoryStockOut.setUserId(customer.getContactNo());
			inventoryStockOut.setStoreId(customer.getStoreId());
			inventoryStockOut.setCreatedBy(customer.getContactNo());
//			inventoryStockOut.setCreatedDate(date);
			stockOutService.createNewStockOut(inventoryStockOut);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/getstockOutdetailsbyid/{stockOutId}/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockOutDetailsById(	@PathVariable("stockOutId") String stockOutId,
	                                           	@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getStockOutDetailsById......{},{}", stockOutId, date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getStockOutByPoId(customer.getStoreId(), stockOutId.trim());
		for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
			for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getId());
				inventoryStockOutItem.getInventoryItems().setStockAvailable(stockAvailable);
				inventoryStockOutItem.setUnitName(inventoryStockOutItem.getUnit().getUnit());
			}
		}
		logger.debug("inventoryStockInList in controller :: {}", inventoryStockOutList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(inventoryStockOutList).toString());
		return null;
	}

	@RequestMapping(value = "/getstockOutdetailsbydate/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockInDetailsByDate(@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getstockOutdetailsbydate......{}", date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_NEW_PAGE);
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), date);
		for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
			for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getId());
				inventoryStockOutItem.getInventoryItems().setStockAvailable(stockAvailable);
				inventoryStockOutItem.setUnitName(inventoryStockOutItem.getUnit().getUnit());
			}
		}
		logger.debug("inventoryStockInList in controller :: {}", inventoryStockOutList);
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");

		return mav;
	}
}
