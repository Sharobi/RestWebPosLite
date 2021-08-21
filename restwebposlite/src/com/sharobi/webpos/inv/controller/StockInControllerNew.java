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
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryStockIn;
import com.sharobi.webpos.inv.model.InventoryStockInItem;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.StockInService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/stockinnew")
public class StockInControllerNew {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = LogManager.getLogger(StockInControllerNew.class);
	private final static InventoryService inventoryService = new InventoryService();
	private final static StockInService stockInService = new StockInService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/loadstockin",
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
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_NEW_PAGE);
		List<InventoryStockIn> inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		Date currdate = new Date();
		String date = dateFormat.format(currdate);
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		return mav;
	}

	@RequestMapping(value = "/createorupdatestockin",
					method = RequestMethod.POST)
	public void createOrUpdateStockin(	@RequestBody String invStockIn,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("in createorupdatestockin...{}", invStockIn);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockIn inventoryStockIn = gson.fromJson(invStockIn, new TypeToken<InventoryStockIn>() {}.getType());
			
			if (inventoryStockIn.getId() == 0) {
				for (InventoryStockInItem inventoryStockInItem : inventoryStockIn.getInventoryStockInItems()) {
					InventoryItems inventoryItems = inventoryService.getInventoryItemDetails(customer.getStoreId(), inventoryStockInItem.getInventoryItems().getCode().trim());
					inventoryStockInItem.setInventoryItems(inventoryItems);
					inventoryStockInItem.setStoreId(customer.getStoreId());
					inventoryStockInItem.setCreatedBy(customer.getContactNo());
					inventoryStockInItem.setCreatedDate(Utility.getFormatedDateShort(currDate));
				}
				inventoryStockIn.setUserId(customer.getContactNo());
				inventoryStockIn.setCreatedBy(customer.getContactNo());
				
				stockInService.saveNewStockIn(inventoryStockIn);
			} else {
				String pastcreateddate = "";
				for (InventoryStockInItem inventoryStockInItem : inventoryStockIn.getInventoryStockInItems()) {
					InventoryItems inventoryItems = inventoryService.getInventoryItemDetails(customer.getStoreId(), inventoryStockInItem.getInventoryItems().getCode().trim());
					inventoryStockInItem.setInventoryItems(inventoryItems);
					inventoryStockInItem.setStoreId(customer.getStoreId());
					inventoryStockInItem.setCreatedBy(inventoryItems.getCreatedBy());
					inventoryStockInItem.setCreatedDate(inventoryItems.getCreatedDate());
					inventoryStockInItem.setUpdatedBy(customer.getContactNo());
					inventoryStockInItem.setUpdatedDate(Utility.getFormatedDateShort(currDate));
					pastcreateddate = inventoryItems.getCreatedDate();
				}
				inventoryStockIn.setUserId(customer.getContactNo());
				inventoryStockIn.setCreatedBy(customer.getContactNo());
				inventoryStockIn.setCreatedDate(pastcreateddate);
				inventoryStockIn.setUpdatedBy(customer.getContactNo());
				inventoryStockIn.setUpdatedDate(Utility.getFormatedDateShort(currDate));
				stockInService.updateExistingStockIn(inventoryStockIn);
			}
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/getstockIndetailsbyidanddate/{stockinid}/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockInDetailsByIdandDate(	@PathVariable("stockinid") String stockinid,
														@PathVariable("date") String date,
														Model model,
														HttpSession session,
														HttpServletRequest request,
														HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getstockIndetailsbyidanddate......{},{}", stockinid, date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		//		List<InventoryStockIn> inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), date);
		List<InventoryStockIn> inventoryStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockinid.trim());
		for (InventoryStockIn inventoryStockIn : inventoryStockInList) {
			for (InventoryStockInItem inventoryStockInItem : inventoryStockIn.getInventoryStockInItems()) {
				MetricUnit metricUnit = inventorymgntService.getInvItemUnitDetails(inventoryStockInItem.getUnitId());
				inventoryStockInItem.setUnitName(metricUnit.getUnit());
			}
		}
		logger.debug("inventoryStockInList in controller :: {}", inventoryStockInList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(inventoryStockInList).toString());
		return null;
	}

	@RequestMapping(value = "/deleteEachStockInItem/{stockInItemId}/{stockInId}",
					method = RequestMethod.GET)
	public ModelAndView deleteEachStockInItem(	@PathVariable("stockInItemId") String stockInItemId,
												@PathVariable("stockInId") String stockInId,
												Model model,
												HttpSession session,
												HttpServletRequest request) throws ParseException {
		logger.debug("In deleteEachStockInItem......{}{}", stockInItemId, stockInId);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		stockInService.deleteEachStockInItem(stockInId, stockInItemId, customer.getStoreId());
		return null;
	}

	@RequestMapping(value = "/getstockIndetailsbydate/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockInDetailsByDate(@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getstockIndetailsbydate......{}", date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_NEW_PAGE);
		List<InventoryStockIn> inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), date);
		//		List<InventoryStockIn> inventoryStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockinid.trim());
		for (InventoryStockIn inventoryStockIn : inventoryStockInList) {
			for (InventoryStockInItem inventoryStockInItem : inventoryStockIn.getInventoryStockInItems()) {
				MetricUnit metricUnit = inventorymgntService.getInvItemUnitDetails(inventoryStockInItem.getUnitId());
				inventoryStockInItem.setUnitName(metricUnit.getUnit());
			}
		}
		logger.debug("inventoryStockInList in controller :: {}", inventoryStockInList);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		mav.addObject("vendorList", vendorList);
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		return mav;
	}

	@RequestMapping(value = "/updatestockinitem",
					method = RequestMethod.POST)
	public void updatePOItem(	@RequestBody String invStockinItems,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in updatestockinitem...{}", invStockinItems);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockInItem inventoryStockInItem = gson.fromJson(invStockinItems, new TypeToken<InventoryStockInItem>() {}.getType());
			inventoryStockInItem.setStoreId(customer.getStoreId());
			inventoryStockInItem.setCreatedBy(customer.getName());
			inventoryStockInItem.setDeleteFlag("N");
			stockInService.updateEachStockInItem(inventoryStockInItem);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/stockInClosed",
					method = RequestMethod.GET)
	public ModelAndView stockInClosed(	@RequestParam String stockInId,
										Model model,
										HttpSession session,
										HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In stockInClosed......{}", stockInId);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		inventoryStockIn.setId(Integer.parseInt(stockInId));
		stockInService.stockInClosed(inventoryStockIn);
		out.print("success");
		out.flush();
		return null;
	}
	//added new
		@RequestMapping(value = "/deletestockinbyid/{stockinid}",
				method = RequestMethod.GET)
	public ModelAndView deleteStockinById(	@PathVariable("stockinid") String stockinid,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) {
	logger.debug("In deleteStockin by stockinid......{}",stockinid);
	Customer customer = null;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	try {
		String wsResponse = stockInService.deleteStockinById(stockinid,customer.getStoreId());
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
