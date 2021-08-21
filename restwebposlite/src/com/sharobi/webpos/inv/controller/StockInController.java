/**
 * 
 */
package com.sharobi.webpos.inv.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.google.gson.Gson;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.inv.model.InvStockInFB;
import com.sharobi.webpos.inv.model.InvStockInForm;
import com.sharobi.webpos.inv.model.InvStockInUpdateItem;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryStockIn;
import com.sharobi.webpos.inv.model.InventoryStockInDetails;
import com.sharobi.webpos.inv.model.InventoryStockInItem;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.StockInService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

/**
 * @author habib
 * 
 */
@SessionAttributes({ "invStockInForm" })
@Controller
@RequestMapping("/stockin")
public class StockInController {
	private final static Logger logger = LogManager.getLogger(StockInController.class);
	private final static InventoryService inventoryService = new InventoryService();
	private final static StockInService stockInService = new StockInService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/viewstockin",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) {
		logger.debug("In viewstockin......");

		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		int stockInId = 0;
		String searchBoxDisplay = "Y";
		double misCharge = 0.00;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date = dateFormat.format(currDate);

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		logger.debug("inventoryStockInList for checking : {}", inventoryStockInList.size());
		if (inventoryStockInList.size() != 0) {
			for (InventoryStockIn invStockIn : inventoryStockInList) {
				closeStatus = invStockIn.getClosed();
				stockInId = invStockIn.getId();
				misCharge = invStockIn.getMiscCharge();
//				grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(invStockIn.getBillNo());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				stockInDetails.setClosed(invStockIn.getClosed());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();

				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
				if(invStockInItem.getItemGrossAmount()!=null){
				grandTotalPrice = grandTotalPrice+invStockInItem.getItemGrossAmount();
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

		} else {
			logger.debug("Else Part");
			searchBoxDisplay = "N";
			stockInDetails.setId(0);
			stockInDetails.setUserId(customer.getContactNo());
			stockInDetails.setCreatedBy(customer.getContactNo());
			stockInDetails.setCreatedDate(date);
			stockInDetails.setBillNo("");
			stockInDetails.setBillDate("");
			inventoryStockInDetailList.add(stockInDetails);
		}
		grandTotalPrice=grandTotalPrice+misCharge;
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		session.removeAttribute("invStockInItemList");
		Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
		System.out.println("store.getVatAmt()="+store.getVatAmt());
		mav.addObject("vat", store.getVatAmt());
		logger.debug("inventoryStockInDetailList :: {}", inventoryStockInDetailList);
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("stockInId", stockInId);
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", searchBoxDisplay);
		session.setAttribute("misCharge", misCharge);
		return mav;
	}

	@RequestMapping(value = "/stockInByDate",
					method = RequestMethod.GET)
	public ModelAndView stockInByDate(	@RequestParam String date,
										Model model,
										HttpSession session,
										HttpServletRequest request) throws ParseException {
		logger.debug("In stockInByDate......");

		Customer customer = new Customer();
		Date toDay = new Date();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		String searchBoxDisplay = "Y";
		double misCharge = 0.00;
		int stockInId = 0;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String toDayString = dateFormat.format(toDay);
		logger.debug("toDayString : " + toDayString);
		Date utilDate = dateFormat.parse(date);
		logger.debug("Today's DATE : " + toDay);
		logger.debug("SELECTED DATE : " + utilDate);

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(utilDate));
		logger.debug("inventoryStockInList Size : {}", inventoryStockInList.size());
		if (inventoryStockInList.size() != 0) {
			for (InventoryStockIn invStockIn : inventoryStockInList) {
				closeStatus = invStockIn.getClosed();
				stockInId = invStockIn.getId();
				misCharge = invStockIn.getMiscCharge();
//				grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(invStockIn.getBillNo());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				stockInDetails.setClosed(invStockIn.getClosed());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();
//				
				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
				if(invStockInItem.getItemGrossAmount()!=null){
				grandTotalPrice =grandTotalPrice+ invStockInItem.getItemGrossAmount();
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

		} else {
			stockInDetails.setId(0);
			stockInDetails.setUserId(customer.getContactNo());
			stockInDetails.setCreatedBy(customer.getContactNo());
			stockInDetails.setCreatedDate(date);
			stockInDetails.setBillNo("");
			stockInDetails.setBillDate("");
			inventoryStockInDetailList.add(stockInDetails);
		}

		if (!toDayString.equalsIgnoreCase(date)) {
			logger.debug("Successful match string");
			searchBoxDisplay = "N";
		}
		grandTotalPrice=grandTotalPrice+misCharge;
		session.removeAttribute("invStockInItemList");
		logger.debug("inventoryStockInDetailList :: {}", inventoryStockInDetailList);
		logger.debug("Close Status :: " + closeStatus);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
		System.out.println("store.getVatAmt()="+store.getVatAmt());
		mav.addObject("vat", store.getVatAmt());
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(utilDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("stockInId", stockInId);
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", searchBoxDisplay);
		session.setAttribute("misCharge", misCharge);

		return mav;
	}

	@RequestMapping(value = "/stockInByPoId",
					method = RequestMethod.GET)
	public ModelAndView stockInByPoId(	@RequestParam String stockId,
										@RequestParam String date,
										Model model,
										HttpSession session,
										HttpServletRequest request) throws ParseException {
		logger.debug("In stockInByPoId......");

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		int stockInId = 0;
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date utilDate = dateFormat.parse(date);

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(utilDate));

		if (inventoryStockInList.size() != 0) {

			List<InventoryStockIn> invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockId);
			for (InventoryStockIn invStockIn : invStockInList) {
				closeStatus = invStockIn.getClosed();
				stockInId = invStockIn.getId();
				misCharge = invStockIn.getMiscCharge();
//				grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(invStockIn.getBillNo());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				stockInDetails.setClosed(invStockIn.getClosed());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();

				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
				if(invStockInItem.getItemGrossAmount()!=null){
				grandTotalPrice=grandTotalPrice+invStockInItem.getItemGrossAmount();
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

		} else {
			stockInDetails.setId(0);
			stockInDetails.setUserId(customer.getContactNo());
			stockInDetails.setCreatedBy(customer.getContactNo());
			stockInDetails.setCreatedDate(date);
			stockInDetails.setBillNo("");
			stockInDetails.setBillDate("");
			inventoryStockInDetailList.add(stockInDetails);
		}
		System.out.println("misCharge="+misCharge);
		grandTotalPrice=grandTotalPrice+misCharge;
		System.out.println("grandTotalPrice="+grandTotalPrice);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		session.removeAttribute("invStockInItemList");
		logger.debug("inventoryStockInDetailList :: {}", inventoryStockInDetailList);
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(utilDate));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("stockInId", stockInId);
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);

		return mav;
	}

	@RequestMapping(value = "/stockInClosed",
					method = RequestMethod.GET)
	public ModelAndView stockInClosed(	@RequestParam String stockInId,
										Model model,
										HttpSession session,
										HttpServletRequest request) throws ParseException {
		logger.debug("In stockInClosed......{}", stockInId);

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
		String date = (String) session.getAttribute("podate");

		String sessionDate = (String) session.getAttribute("sessionDate");
		logger.debug("sessionDate : " + sessionDate);
		InventoryStockIn inventoryStockindata = new InventoryStockIn();
		inventoryStockindata.setId(Integer.parseInt(stockInId));
		stockInService.stockInClosed(inventoryStockindata);

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);
		if (inventoryStockInList.size() != 0) {

			List<InventoryStockIn> invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockInId);
			for (InventoryStockIn invStockIn : invStockInList) {
				closeStatus = invStockIn.getClosed();
				misCharge = invStockIn.getMiscCharge();
//				grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(invStockIn.getBillNo());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				stockInDetails.setClosed(invStockIn.getClosed());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();

				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
				if(invStockInItem.getItemGrossAmount()!=null){
				grandTotalPrice=grandTotalPrice+invStockInItem.getItemGrossAmount();
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

		}
		grandTotalPrice=grandTotalPrice+misCharge;
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		session.removeAttribute("invStockInItemList");
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", sessionDate);
		session.setAttribute("stockInId", NumberUtils.toInt(stockInId));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);
		return mav;
	}

	@RequestMapping(value = "/updateEachStockInItem/{itemId}/{itemQty}/{rate}/{totalPriceValue}/{poNoValue}/{date}/{stockId}",
					method = RequestMethod.GET)
	public ModelAndView updateEachStockInItem(	@PathVariable("itemId") String itemId,
												@PathVariable("itemQty") String itemQty,
												@PathVariable("rate") String rate,
												@PathVariable("totalPriceValue") String totalPriceValue,
												@PathVariable("date") String date,
												@PathVariable("poNoValue") String poNoValue,
												@PathVariable("stockId") String stockId,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In updateEachStockInItem......{},{},{},{},{}");

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockIn> invStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInItem invtoryStockInItem = new InventoryStockInItem();
		InventoryStockIn InvtoryStockIn = new InventoryStockIn();
		InvStockInUpdateItem invUpdateItem = new InvStockInUpdateItem();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date utilDate = dateFormat.parse(date);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(utilDate));
		if (inventoryStockInList.size() != 0) {

			invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockId);
			for (InventoryStockIn invStockIn : invStockInList) {
				closeStatus = invStockIn.getClosed();
				InvtoryStockIn = invStockIn;
				misCharge = invStockIn.getMiscCharge();
				inventoryStockInItemList = invStockIn.getInventoryStockInItems();
				break;
			}
		}
		logger.debug("inventoryStockInItemList :: {}", inventoryStockInItemList);

		for (InventoryStockInItem inventoryStockInItem : inventoryStockInItemList) {
			if (inventoryStockInItem.getId() == NumberUtils.toInt(itemId)) {
				inventoryStockInItem.setItemQuantity(NumberUtils.toDouble(itemQty));
				inventoryStockInItem.setItemRate(NumberUtils.toDouble(rate));
//				inventoryStockInItem.setItemTotalPrice(NumberUtils.toDouble(totalPriceValue));
				Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
				System.out.println("store.getVatAmt()="+store.getVatAmt());
				Double grossamt=0.0;
				Double taxamt=0.0;
				Double amtwithouttax=0.0;
				grossamt=NumberUtils.toDouble(itemQty)*NumberUtils.toDouble(rate);
				taxamt=grossamt*store.getVatAmt()/100;
				amtwithouttax=grossamt-taxamt;
				inventoryStockInItem.setItemTotalPrice(amtwithouttax);
				inventoryStockInItem.setTaxRate(store.getVatAmt());
				inventoryStockInItem.setTaxAmount(taxamt);
				inventoryStockInItem.setItemGrossAmount(grossamt);
				inventoryStockInItem.setPoId(poNoValue);
				invtoryStockInItem = inventoryStockInItem;
				break;
			}
		}
		logger.debug("StockinItem object to be updated :: {}", invtoryStockInItem);
		InvtoryStockIn.setInventoryStockInItems(null);
		invtoryStockInItem.setInventoryStockIn(InvtoryStockIn);
		logger.debug("Final StockinItem object to be updated :: {}", invtoryStockInItem);
		String jsonResponse = stockInService.updateEachStockInItem(invtoryStockInItem);
		logger.debug("In Controller...jsonResponse :" + jsonResponse);

		invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockId);
		for (InventoryStockIn invStockIn : invStockInList) {
			closeStatus = invStockIn.getClosed();
			inventoryStockInItemList = invStockIn.getInventoryStockInItems();
			break;
		}

		for (InventoryStockInItem item : inventoryStockInItemList) {
			if (NumberUtils.toInt(itemId) == item.getId()) {
				invUpdateItem.setItemId(item.getId());
				invUpdateItem.setItemQuantity(item.getItemQuantity());
				invUpdateItem.setItemPrice(item.getItemRate());
				invUpdateItem.setTotalItemPrice(item.getItemTotalPrice());
				invUpdateItem.setPoNo(item.getPoId());
				invUpdateItem.setResponse(jsonResponse);
				break;
			}
		}
		logger.debug("invUpdateItem : {}", invUpdateItem);

		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		out.print(new Gson().toJson(invUpdateItem));
		out.flush();

		//List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		//logger.debug("Fetched vendorList :: {}", vendorList);

		session.removeAttribute("invStockInItemList");
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		//mav.addObject("vendorList", vendorList);
		session.setAttribute("podate", date);
		session.setAttribute("stockInId", NumberUtils.toInt(stockId));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);
		return null;
	}

	@RequestMapping(value = "/deleteEachStockInItem",
					method = RequestMethod.GET)
	public ModelAndView deleteEachStockInItem(	@RequestParam String stockInItemId,
												@RequestParam String stockInId,
												Model model,
												HttpSession session,
												HttpServletRequest request) throws ParseException {
		logger.debug("In deleteEachStockInItem......{}{}", stockInItemId, stockInId);

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
		String date = (String) session.getAttribute("podate");
		String sessionDate = (String) session.getAttribute("sessionDate");
		logger.debug("sessionDate : " + sessionDate);

		stockInService.deleteEachStockInItem(stockInId, stockInItemId, customer.getStoreId());

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);
		if (inventoryStockInList.size() != 0) {

			List<InventoryStockIn> invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockInId);
			for (InventoryStockIn invStockIn : invStockInList) {
				closeStatus = invStockIn.getClosed();
				misCharge = invStockIn.getMiscCharge();
//				grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(invStockIn.getBillNo());
				stockInDetails.setBillDate(invStockIn.getBillDate());
				stockInDetails.setClosed(invStockIn.getClosed());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();

				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
				grandTotalPrice=grandTotalPrice +invStockInItem.getItemGrossAmount();
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

		}
		grandTotalPrice=grandTotalPrice+misCharge;
		System.out.println("grandTotalPrice="+grandTotalPrice);
		session.removeAttribute("invStockInItemList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", sessionDate);
		session.setAttribute("stockInId", NumberUtils.toInt(stockInId));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);
		return mav;
	}

	@RequestMapping(value = "/removeNewlyAddedItem",
					method = RequestMethod.GET)
	public ModelAndView removeNewlyAddedItem(	@RequestParam String itemCode,
												@RequestParam String totalPrice,
												@RequestParam String miscChargeVal,
												@RequestParam String userId,
												@RequestParam String stockId,
												@RequestParam String billNo,
												@RequestParam String billDate,
												@RequestParam String vendorId,
												Model model,
												HttpSession session,
												HttpServletRequest request) throws ParseException {
		logger.debug("In removeNewlyAddedItem......{}{}");

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();

		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		List<InventoryStockInItem> stockInItemList = new ArrayList<InventoryStockInItem>();
		List<InvStockInFB> stockInFbList = new ArrayList<InvStockInFB>();
		InvStockInForm invStockInForm = new InvStockInForm();
		String closeStatus = "N";
		double misCharge = 0.00;
		double grandTotalPrice = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
		String date = (String) session.getAttribute("podate");

		String sessionDate = (String) session.getAttribute("sessionDate");
		logger.debug("sessionDate : " + sessionDate);

		String newStockStatus = (String) session.getAttribute("newStockIn");
		logger.debug("NewStockStatus ::" + newStockStatus);

		List<InvStockInFB> stockInFBList = (List<InvStockInFB>) session.getAttribute("invStockInFBList");
		logger.debug("Session stockInFBList...: {}", stockInFBList);

		List<InventoryStockInItem> invStockInItemList = (List<InventoryStockInItem>) session.getAttribute("invStockInItemList");

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);
		if (NumberUtils.toInt(stockId) != 0) {
			List<InventoryStockIn> invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockId);
			for (InventoryStockIn invStockIn : invStockInList) {
				closeStatus = invStockIn.getClosed();
				misCharge = invStockIn.getMiscCharge();
				//grandTotalPrice = invStockIn.getTotalPrice();

				stockInDetails.setId(invStockIn.getId());
				stockInDetails.setUserId(invStockIn.getUserId());
				stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
				stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
				stockInDetails.setVendorName(invStockIn.getVendorName());
				stockInDetails.setBillNo(billNo);
				stockInDetails.setBillDate(billDate);
				stockInDetails.setClosed(invStockIn.getClosed());
				inventoryStockInDetailList.add(stockInDetails);

				inventoryStockInItemList = invStockIn.getInventoryStockInItems();

				inventoryStockIn = invStockIn;
				break;
			}

			for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
				String itmCode = stockInItem.getInventoryItems().getCode();
				int itemId = stockInItem.getId();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					stockInService.deleteEachStockInItem(stockId, String.valueOf(itemId), customer.getStoreId());
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (inventoryStockIn.getVendorId() != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}
//			for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
//				grandTotalPrice=grandTotalPrice +invStockInItem.getItemGrossAmount();
//			}
//			grandTotalPrice=Double.valueOf(totalPrice);
		} else {
			stockInDetails.setId(0);
			stockInDetails.setUserId(customer.getContactNo());
			stockInDetails.setCreatedBy(customer.getContactNo());
			stockInDetails.setCreatedDate(date);
			stockInDetails.setBillNo(billNo);
			stockInDetails.setBillDate(billDate);
			inventoryStockInDetailList.add(stockInDetails);

			for (InventoryVendors inVendor : vendorList) {
				if (NumberUtils.toInt(vendorId) == inVendor.getId()) {
					selectedVendorList.add(inVendor);
					break;
				}
			}

			for (InventoryVendors inVendor : vendorList) {
				if (NumberUtils.toInt(vendorId) != inVendor.getId()) {
					selectedVendorList.add(inVendor);
				}
			}

			vendorList = new ArrayList<InventoryVendors>();
			vendorList = selectedVendorList;
		}

		for (InvStockInFB invStockInFB : stockInFBList) {
			String itmCode = invStockInFB.getItemCode();
			if (!itmCode.equalsIgnoreCase(itemCode)) {
				System.out.println("itmCode="+itmCode);
				System.out.println("invStockInFB.getItemQuantity()="+invStockInFB.getItemQuantity());
				System.out.println("invStockInFB.getTotalPrice()="+invStockInFB.getTotalPrice());
				grandTotalPrice=grandTotalPrice+invStockInFB.getTotalPrice();
				stockInFbList.add(invStockInFB);
			}
		}
		for (InventoryStockInItem inItem : invStockInItemList) {//stockInItemList
			String itmCode = inItem.getInventoryItems().getCode();
			if (!itmCode.equalsIgnoreCase(itemCode)) {
				System.out.println("itmCode="+itmCode);
				System.out.println("inItem.getItemQuantity()="+inItem.getItemQuantity());
				System.out.println("inItem.getItemGrossAmount()="+inItem.getItemTotalPrice());
				stockInItemList.add(inItem);
			}
		}
		grandTotalPrice=grandTotalPrice+NumberUtils.toDouble(miscChargeVal);
		logger.debug("Final stockInFBList...: {}", stockInFbList);
		logger.debug("Final inventoryStockInItemList...: {}", inventoryStockInItemList);
		invStockInForm.setInvStockInFBList(stockInFbList);
		session.setAttribute("invStockInItemList", stockInItemList);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		//session.removeAttribute("invStockInItemList");
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("invStockInForm", invStockInForm);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("invStockInFBList", stockInFbList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", sessionDate);
		session.setAttribute("stockInId", NumberUtils.toInt(stockId));
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", newStockStatus);
		session.setAttribute("addItemFlag", "Y");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", NumberUtils.toDouble(miscChargeVal));
		return mav;
	}

	@RequestMapping(value = "/newStockIn",
					method = RequestMethod.GET)
	public ModelAndView newStockIn(	Model model,
									HttpSession session,
									HttpServletRequest request) throws ParseException {
		logger.debug("In newStockIn......");

		Customer customer = new Customer();
		Date currDate = new Date();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);

//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String newDate = dateFormat.format(currDate);

		inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));

		stockInDetails.setId(0);
		stockInDetails.setUserId(customer.getContactNo());
		stockInDetails.setCreatedBy(customer.getContactNo());
		stockInDetails.setCreatedDate(newDate);
		inventoryStockInDetailList.add(stockInDetails);

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		session.removeAttribute("invStockInItemList");
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		session.setAttribute("podate", newDate);
		session.setAttribute("sessionDate", Utility.getFormatedDateShort(currDate));
		session.setAttribute("stockInId", 0);
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", "N");
		session.setAttribute("newStockIn", "Y");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);
		return mav;
	}

	@RequestMapping(value = "/getItemInfoFromPage/{itemCode}/{qty}/{unit}/{total}/{sumTotal}",
					method = RequestMethod.GET)
	public ModelAndView getItemInfoFromPage(@PathVariable String itemCode,
											@PathVariable String qty,
											@PathVariable String unit,
											@PathVariable String total,
											@PathVariable String sumTotal,
											HttpSession session) throws ParseException {
		logger.debug("In getItemInfoFromPage......");
		Customer customer = new Customer();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		List<InventoryStockInItem> stockInItemList = (List<InventoryStockInItem>) session.getAttribute("invStockInItemList");
		logger.debug("Session stockInItemList.. {}", stockInItemList);
		List<InvStockInFB> stockInFBList = (List<InvStockInFB>) session.getAttribute("invStockInFBList");
		logger.debug("Session stockInFBList...: {}", stockInFBList);
		boolean flag = stockInItemList == null ? true : false;
		boolean flagstockInFBList = stockInFBList == null ? true : false;

		if (flag == false) {
			for (InventoryStockInItem invStockInItem : stockInItemList) {
				String itmCode = invStockInItem.getInventoryItems().getCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					System.out.println("getItemInfoFromPage unit="+unit);
					invStockInItem.setItemQuantity(NumberUtils.toDouble(qty));
					invStockInItem.setUnitId(NumberUtils.toInt(unit));
					invStockInItem.setItemTotalPrice(NumberUtils.toDouble(total));
					System.out.println("getItemInfoFromPage invStockInItem.getUnitId()="+invStockInItem.getUnitId());
					
					break;
				}
			}
		}
		if (flagstockInFBList == false) {
			for (InvStockInFB invStockInFB : stockInFBList) {
				String itmCode = invStockInFB.getItemCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					System.out.println("getItemInfoFromPage unit="+unit);
					invStockInFB.setItemQuantity(NumberUtils.toDouble(qty));
					invStockInFB.setTotalPrice(NumberUtils.toDouble(total));
					System.out.println("getItemInfoFromPage invStockInFB.setTotalPrice()="+invStockInFB.getTotalPrice());
					
					break;
				}
			}
		}
		session.setAttribute("invStockInFBList", stockInFBList);
		session.setAttribute("invStockInItemList", stockInItemList);
		session.setAttribute("grandTotalPrice", NumberUtils.toDouble(sumTotal));

		return null;
	}

	@RequestMapping(value = "/getItemRateFromPage/{itemCode}/{rate}/{qty}/{total}/{sumTotal}",
					method = RequestMethod.GET)
	public ModelAndView getItemRateFromPage(@PathVariable String itemCode,
											@PathVariable String rate,
											@PathVariable String qty,
											@PathVariable String total,
											@PathVariable String sumTotal,
											HttpSession session) throws ParseException {
		logger.debug("In getItemRateFromPage......");
		Customer customer = new Customer();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		List<InventoryStockInItem> stockInItemList = (List<InventoryStockInItem>) session.getAttribute("invStockInItemList");
		logger.debug("Session stockInItemList.. {}", stockInItemList);
		List<InvStockInFB> stockInFBList = (List<InvStockInFB>) session.getAttribute("invStockInFBList");
		logger.debug("Session stockInFBList...: {}", stockInFBList);
		boolean flag = stockInItemList == null ? true : false;
		boolean flagstockInFBList = stockInFBList == null ? true : false;

		if (flag == false) {
			for (InventoryStockInItem invStockInItem : stockInItemList) {
				String itmCode = invStockInItem.getInventoryItems().getCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					invStockInItem.setItemQuantity(NumberUtils.toDouble(qty));
					invStockInItem.setItemRate(NumberUtils.toDouble(rate));
					invStockInItem.setItemTotalPrice(NumberUtils.toDouble(total));
					break;
				}
			}
		}
		if (flagstockInFBList == false) {
			for (InvStockInFB invStockInFB : stockInFBList) {
				String itmCode = invStockInFB.getItemCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					invStockInFB.setItemQuantity(NumberUtils.toDouble(qty));
					invStockInFB.setItemRate(NumberUtils.toDouble(rate));
					invStockInFB.setTotalPrice(NumberUtils.toDouble(total));
					System.out.println("getItemInfoFromPage invStockInFB.setTotalPrice()="+invStockInFB.getTotalPrice());
					
					break;
				}
			}
		}
		session.setAttribute("invStockInFBList", stockInFBList);
		session.setAttribute("invStockInItemList", stockInItemList);
		session.setAttribute("grandTotalPrice", NumberUtils.toDouble(sumTotal));

		return null;
	}

	@RequestMapping(value = "/addNewStockInItem",
					method = RequestMethod.GET)
	public ModelAndView addNewStockInItem(	@RequestParam String itemCode,
											@RequestParam String stockInId,
											@RequestParam String vendorId,
											@RequestParam String billNo,
											@RequestParam String billDate,
											@RequestParam String miscCharge,
											Model model,
											HttpSession session,
											HttpServletRequest request) throws ParseException {
		logger.debug("In addNewStockInItem......");

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockIn> invStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockInItem inventoryStockInItem = new InventoryStockInItem();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		InvStockInForm invStockInForm = new InvStockInForm();
		List<InvStockInFB> invStockInFBList = new ArrayList<InvStockInFB>();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		List<InventoryVendors> newVendorList = new ArrayList<InventoryVendors>();
		double grandTotalPrice = 0.00;
		String closeStatus = "N";
		String newStockIn = "N";
		String addItemFlag = "N";
		double misCharge = 0.00;
		boolean itemCodeFlag = false;
		//String stockNumber = null;
		int fbId = 0;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		

		try {
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
			String sessionDate = (String) session.getAttribute("sessionDate");
			String date = (String) session.getAttribute("podate");
			int stockId = NumberUtils.toInt(stockInId);

			List<InventoryStockInItem> stockInItemList = (List<InventoryStockInItem>) session.getAttribute("invStockInItemList");
			logger.debug("Session stockInItemList.. {}", stockInItemList);
			boolean flag = stockInItemList == null ? true : false;

			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
			inventoryItemList = inventoryService.getInventoryItemList(customer.getStoreId(),itemCode.trim());
//			inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());
			inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);
			if (stockId != 0) {
				invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), stockInId);

				for (InventoryStockIn invStockIn : invStockInList) {

					stockInDetails.setId(invStockIn.getId());
					stockInDetails.setUserId(invStockIn.getUserId());
					stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
					stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
					stockInDetails.setVendorName(invStockIn.getVendorName());
					stockInDetails.setBillNo(invStockIn.getBillNo());
					stockInDetails.setBillDate(invStockIn.getBillDate());
					stockInDetails.setClosed(invStockIn.getClosed());
					inventoryStockInDetailList.add(stockInDetails);
					inventoryStockInItemList = invStockIn.getInventoryStockInItems();
					inventoryStockIn = invStockIn;
					break;
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() == inVendor.getId()) {
						selectedVendorList.add(inVendor);
						break;
					}
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() != inVendor.getId()) {
						selectedVendorList.add(inVendor);
					}
				}

				if (inventoryStockInItemList.size() == 0) {
					inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
				}

				if (flag == false) {
					inventoryStockInItemList = stockInItemList;
				}
				
				if (inventoryStockInItemList.size() != 0) {
					for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
						String stockItemcode =  stockInItem.getInventoryItems().getCode();
						if (stockItemcode.equalsIgnoreCase(itemCode)) {
							itemCodeFlag = true;
						}
					}
				}
				if(!itemCodeFlag){
				for (InventoryItems inventoryItem : inventoryItemList) {
					String itmCode = inventoryItem.getCode();
					if (itmCode.equalsIgnoreCase(itemCode)) {
						InventoryStockInItem stockInItem = new InventoryStockInItem();
						stockInItem.setId(0);
						stockInItem.setItemQuantity(1);
						stockInItem.setItemRate(inventoryItem.getRate());
						stockInItem.setItemTotalPrice(inventoryItem.getRate());
						stockInItem.setPoId("");
						stockInItem.setApproveFlag("N");
						stockInItem.setInventoryItems(inventoryItem);
						inventoryStockInItemList.add(stockInItem);
						break;
					}
				}
				}
				logger.debug("final invPurchaseOrderItemList :: {}", inventoryStockInItemList);
				session.setAttribute("invStockInItemList", inventoryStockInItemList);

				for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
					fbId += 1;
					//int itemId = stockInItem.getInventoryItems().getId();
					//stockNumber = inventoryService.getCurrentStockByItem(customer.getStoreId(), itemId);
					String itmCode = stockInItem.getInventoryItems().getCode();
					String itemName = stockInItem.getInventoryItems().getName();
					double quantity = stockInItem.getItemQuantity();
					String unit = stockInItem.getInventoryItems().getUnit();
//					int metricUnitId = stockInItem.getUnitId();
					int metricUnitId=stockInItem.getInventoryItems().getMetricUnitId();
					double rate = stockInItem.getItemRate();
					double totalPrice = stockInItem.getItemTotalPrice();
					String poNo = stockInItem.getPoId();
					String approveFlag = stockInItem.getApproveFlag();
					Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
					System.out.println("metricUnitId="+metricUnitId);
					Double grossamt=0.0;
					Double taxamt=0.0;
					Double amtwithouttax=0.0;
					grossamt=quantity*rate;
					totalPrice=grossamt;
					grandTotalPrice += totalPrice;
					taxamt=grossamt*store.getVatAmt()/100;
					amtwithouttax=grossamt-taxamt;
					System.out.println("grossamt"+grossamt);
					System.out.println("taxamt="+taxamt);
					System.out.println("amtwithouttax="+amtwithouttax);
					invStockInFBList.add(new InvStockInFB(fbId, itmCode, itemName, 0, quantity, unit, rate, totalPrice, poNo, approveFlag,store.getVatAmt(),taxamt,amtwithouttax,metricUnitId));
				}
				invStockInForm.setInvStockInFBList(invStockInFBList);
				logger.debug("InvStockInForm {}", invStockInForm);
				addItemFlag = "Y";
				misCharge = NumberUtils.toDouble(miscCharge);
				grandTotalPrice += misCharge;

			} else {
				stockInDetails.setId(0);
				stockInDetails.setUserId(customer.getContactNo());
				stockInDetails.setCreatedBy(customer.getContactNo());
				stockInDetails.setCreatedDate(date);
				stockInDetails.setBillNo(billNo);
				stockInDetails.setBillDate(billDate);
				inventoryStockInDetailList.add(stockInDetails);

				for (InventoryVendors inVendor : vendorList) {
					if (NumberUtils.toInt(vendorId) == inVendor.getId()) {
						newVendorList.add(inVendor);
					}
				}

				for (InventoryVendors inVendor : vendorList) {
					if (NumberUtils.toInt(vendorId) != inVendor.getId()) {
						newVendorList.add(inVendor);
					}
				}

				vendorList = new ArrayList<InventoryVendors>();/*Re-Initialisation */
				vendorList = newVendorList;

				if (flag == false) {
					inventoryStockInItemList = stockInItemList;
				}
				
				if (inventoryStockInItemList.size() != 0) {
					for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
						String stockItemcode =  stockInItem.getInventoryItems().getCode();
						if (stockItemcode.equalsIgnoreCase(itemCode)) {
							itemCodeFlag = true;
						}
					}
				}
if(!itemCodeFlag){
				for (InventoryItems inventoryItem : inventoryItemList) {
					String itmCode = inventoryItem.getCode();
					if (itmCode.equalsIgnoreCase(itemCode)) {
						InventoryStockInItem stockInItem = new InventoryStockInItem();
						stockInItem.setId(0);
						stockInItem.setItemQuantity(1);
						stockInItem.setItemRate(inventoryItem.getRate());
						stockInItem.setItemTotalPrice(inventoryItem.getRate());
						stockInItem.setPoId("");
						stockInItem.setApproveFlag("N");
						stockInItem.setInventoryItems(inventoryItem);
						inventoryStockInItemList.add(stockInItem);
						break;
					}
				}
}
				logger.debug("final invPurchaseOrderItemList :: {}", inventoryStockInItemList);
				session.setAttribute("invStockInItemList", inventoryStockInItemList);
				misCharge = NumberUtils.toDouble(miscCharge);

				for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
					fbId += 1;
					//int itemId = stockInItem.getInventoryItems().getId();
					//stockNumber = inventoryService.getCurrentStockByItem(customer.getStoreId(), itemId);
					String itmCode = stockInItem.getInventoryItems().getCode();
					String itemName = stockInItem.getInventoryItems().getName();
					double quantity = stockInItem.getItemQuantity();
					String unit = stockInItem.getInventoryItems().getUnit();
					int metricUnitId = stockInItem.getInventoryItems().getMetricUnitId();
//					int metricUnitId = stockInItem.getUnitId();
					System.out.println("stockInItem.getUnitId();="+stockInItem.getUnitId());
					double rate = stockInItem.getItemRate();
					double totalPrice = stockInItem.getItemTotalPrice();
					grandTotalPrice += totalPrice;
					String poNo = stockInItem.getPoId();
					String approveFlag = stockInItem.getApproveFlag();
					Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
					System.out.println("stockInItem.getInventoryItems().getMetricUnitId();="+stockInItem.getInventoryItems().getMetricUnitId());
					Double grossamt=0.0;
					Double taxamt=0.0;
					Double amtwithouttax=0.0;
					grossamt=quantity*rate;
					taxamt=grossamt*store.getVatAmt()/100;
					amtwithouttax=grossamt-taxamt;
					System.out.println("grossamt"+grossamt);
					System.out.println("taxamt="+taxamt);
					System.out.println("amtwithouttax="+amtwithouttax);
					invStockInFBList.add(new InvStockInFB(fbId, itmCode, itemName, 0, quantity, unit, rate, totalPrice, poNo, approveFlag,store.getVatAmt(),taxamt,amtwithouttax,metricUnitId));
				}
				invStockInForm.setInvStockInFBList(invStockInFBList);
				logger.debug("InvStockInForm {}", invStockInForm);
				addItemFlag = "Y";
				selectedVendorList = vendorList;
				grandTotalPrice += misCharge;
			}
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			logger.debug("Close Status :: " + closeStatus);
			Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
			System.out.println("store.getVatAmt()="+store.getVatAmt());
			mav.addObject("vat",store.getVatAmt());
			mav.addObject("inventoryStockInList", inventoryStockInList);
			mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
			mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
			mav.addObject("invStockInForm", invStockInForm);
			mav.addObject("vendorList", vendorList);
			mav.addObject("selectedVendorList", selectedVendorList);
			session.setAttribute("invStockInFBList", invStockInFBList);
			session.setAttribute("podate", date);
			session.setAttribute("sessionDate", sessionDate);
			session.setAttribute("stockInId", stockId);
			session.setAttribute("loginId", customer.getContactNo());
			session.setAttribute("grandTotalPrice", grandTotalPrice);
			session.setAttribute("closeStatus", closeStatus);
			session.setAttribute("newStockIn", newStockIn);
			session.setAttribute("addItemFlag", addItemFlag);
			session.setAttribute("searchBoxDisplay", "Y");
			session.setAttribute("misCharge", NumberUtils.toDouble(miscCharge));

			return mav;
		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/saveStockInObject",
					method = RequestMethod.POST)
	public ModelAndView saveNewStockInObject(	@ModelAttribute("invStockInForm") InvStockInForm invStockInForm,
												Model model,
												HttpSession session,
												HttpServletRequest request) throws ParseException {
		logger.debug("In saveNewStockInObject......");

		Customer customer = new Customer();
		List<InventoryStockIn> inventoryStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockIn> invStockInList = new ArrayList<InventoryStockIn>();
		List<InventoryStockInItem> inventoryStockInItemList = new ArrayList<InventoryStockInItem>();
		List<InventoryStockInDetails> inventoryStockInDetailList = new ArrayList<InventoryStockInDetails>();
		InventoryStockInDetails stockInDetails = new InventoryStockInDetails();
		InventoryStockIn inventoryStockIn = new InventoryStockIn();
		InventoryStockInItem inventoryStockInItem = new InventoryStockInItem();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		List<InvStockInFB> invStockInFormBeanList = new ArrayList<InvStockInFB>();
		List<InventoryVendors> selectedVendorList = new ArrayList<InventoryVendors>();
		InventoryItems inventoryItems = new InventoryItems();
		List<String> stockInFBList = new ArrayList<String>();
		List<String> stockPoItemList = new ArrayList<String>();
		List<String> itemCodeFinalList = new ArrayList<String>();
		double grandTotalPrice = 0.00;
		double misCharge = 0.00;
		String closeStatus = "N";
		int totalQty = 0;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_IN_PAGE);
		/*SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String date = dateFormat.format(currDate);*/

		session.removeAttribute("invStockInItemList");
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		int stockId = (int) session.getAttribute("stockInId");
		System.out.println("stockId="+stockId);	
		logger.debug("StockIn Id : " + stockId);
		String sessionDate = (String) session.getAttribute("sessionDate");
		Date sessionutilDate = dateFormat.parse(sessionDate);
		sessionDate=Utility.getFormatedDateShort(sessionutilDate);
		logger.debug("sessionDate : " + sessionDate);
		String date = (String) session.getAttribute("podate");
		
		Date utilDate = dateFormat.parse(date);
		date=Utility.getFormatedDateShort(utilDate);
		logger.debug("date : " + date);
		String billNumber = request.getParameter("billNo");
		logger.debug("billNumber : " + billNumber);
		String billDate = request.getParameter("billDate");
		logger.debug("billDate : " + billDate);
		//vendorId
		String vendorId = request.getParameter("vendorId");
		logger.debug("vendorId : " + vendorId);

		String misChargeValue = request.getParameter("misChargeId");
		logger.debug("misChargeValue :{} ", misChargeValue);

		String totalItemValue = request.getParameter("totalId");
		logger.debug("totalItemValue :{} ", totalItemValue);

		logger.debug("InvStockInForm..{}", invStockInForm);
		List<InvStockInFB> invStockInFBList = invStockInForm.getInvStockInFBList();

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);

//		inventoryItemList = inventoryService.getInventoryItemList(customer.getStoreId(),itemCode.trim());
		inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());

		if (stockId != 0) {
			invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), String.valueOf(stockId));
			for (InventoryStockIn stockIn : invStockInList) {
				inventoryStockInItemList = stockIn.getInventoryStockInItems();
			}

			for (InventoryStockInItem stockInItem : inventoryStockInItemList) {
				String itmCode = stockInItem.getInventoryItems().getCode();
				stockPoItemList.add(itmCode);
			}
			logger.debug("stockPoItemList {} :", stockPoItemList);

			for (InvStockInFB stockInFB : invStockInFBList) {
				double itemQty = stockInFB.getItemQuantity();
				totalQty += itemQty;

				String code = stockInFB.getItemCode();
				stockInFBList.add(code);
			}
			logger.debug("stockInFBList {} :", stockInFBList);

			Iterator<String> itr = stockInFBList.iterator();
			while (itr.hasNext()) {
				String code = (String) itr.next();
				if (!stockPoItemList.contains(code)) {
					itemCodeFinalList.add(code);
				}
			}
			logger.debug("itemCodeFinalList {} :", itemCodeFinalList);

			for (String itmcode : itemCodeFinalList) {
				for (InvStockInFB invStockInFB : invStockInFBList) {
					String code = invStockInFB.getItemCode();
					if (code.equalsIgnoreCase(itmcode)) {
						invStockInFormBeanList.add(invStockInFB);
						break;
					}
				}
			}
			logger.debug("invStockInFormBeanList {} :", invStockInFormBeanList);

			inventoryStockInItemList = new ArrayList<InventoryStockInItem>();/*Re-Initialisation*/
			for (InvStockInFB invStockInFB : invStockInFormBeanList) {
				for (InventoryItems item : inventoryItemList) {
					String code = item.getCode();
					if (code.equalsIgnoreCase(invStockInFB.getItemCode())) {
						inventoryItems = item;
						inventoryItems.setMetricUnitId(invStockInFB.getMetricUnitId());
						System.out.println("invStockInFB.getMetricUnitId()="+invStockInFB.getMetricUnitId());
						break;
					}
				}
				
				//create new InventoryStockInItem obj.
				InventoryStockInItem stockInItem = new InventoryStockInItem();
				stockInItem.setInventoryItems(inventoryItems);
				stockInItem.setItemQuantity(invStockInFB.getItemQuantity());
				stockInItem.setItemRate(invStockInFB.getItemRate());
				Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
				System.out.println("store.getVatAmt()="+store.getVatAmt());
				Double grossamt=0.0;
				Double taxamt=0.0;
				Double amtwithouttax=0.0;
				grossamt=invStockInFB.getItemQuantity()*invStockInFB.getItemRate();
				taxamt=grossamt*store.getVatAmt()/100;
				amtwithouttax=grossamt-taxamt;
				stockInItem.setItemTotalPrice(amtwithouttax);
				stockInItem.setTaxRate(store.getVatAmt());
				stockInItem.setTaxAmount(taxamt);
				stockInItem.setItemGrossAmount(grossamt);
				stockInItem.setStoreId(customer.getStoreId());
				stockInItem.setPoId(invStockInFB.getPoNo());
				stockInItem.setCreatedBy(customer.getContactNo());
				stockInItem.setCreatedDate(date);
				stockInItem.setUnitId(inventoryItems.getMetricUnitId());
				inventoryStockInItemList.add(stockInItem);
				totalItemValue=totalItemValue+grossamt;
			}
            System.out.println("totalItemValue="+totalItemValue);
			inventoryStockIn.setId(stockId);
			inventoryStockIn.setTotalQuantity(totalQty);
			inventoryStockIn.setMiscCharge(NumberUtils.toDouble(misChargeValue));
			inventoryStockIn.setTotalPrice(NumberUtils.toDouble(totalItemValue));
			inventoryStockIn.setInventoryStockInItems(inventoryStockInItemList);
			logger.debug("inventoryStockIn ready for update {} :", inventoryStockIn);

			stockInService.updateExistingStockIn(inventoryStockIn);

			inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);

			if (inventoryStockInList.size() != 0) {

				invStockInList = stockInService.getStockInByPoId(customer.getStoreId(), String.valueOf(stockId));
				for (InventoryStockIn invStockIn : invStockInList) {
					closeStatus = invStockIn.getClosed();
					misCharge = invStockIn.getMiscCharge();
//					grandTotalPrice = invStockIn.getTotalPrice();

					stockInDetails.setId(invStockIn.getId());
					stockInDetails.setUserId(invStockIn.getUserId());
					stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
					stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
					stockInDetails.setVendorName(invStockIn.getVendorName());
					stockInDetails.setBillNo(invStockIn.getBillNo());
					stockInDetails.setBillDate(invStockIn.getBillDate());
					stockInDetails.setClosed(invStockIn.getClosed());
					inventoryStockInDetailList.add(stockInDetails);

					inventoryStockInItemList = invStockIn.getInventoryStockInItems();

					inventoryStockIn = invStockIn;
					break;
				}

				for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
					grandTotalPrice =grandTotalPrice+ invStockInItem.getItemGrossAmount();
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() == inVendor.getId()) {
						selectedVendorList.add(inVendor);
						break;
					}
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() != inVendor.getId()) {
						selectedVendorList.add(inVendor);
					}
				}
			}
		} else {

			for (InvStockInFB invStockInFB : invStockInFBList) {
				double itemQty = invStockInFB.getItemQuantity();
				totalQty += itemQty;
				for (InventoryItems item : inventoryItemList) {
					String code = item.getCode();
					if (code.equalsIgnoreCase(invStockInFB.getItemCode())) {
						inventoryItems = item;
						System.out.println("invStockInFB.getMetricUnitId()="+invStockInFB.getMetricUnitId());
						inventoryItems.setMetricUnitId(invStockInFB.getMetricUnitId());
						break;
					}
				}
				//create new InventoryStockInItem obj.
				InventoryStockInItem stockInItem = new InventoryStockInItem();
				stockInItem.setInventoryItems(inventoryItems);
				stockInItem.setItemQuantity(invStockInFB.getItemQuantity());
				stockInItem.setItemRate(invStockInFB.getItemRate());
				Store store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
				System.out.println("store.getVatAmt()="+store.getVatAmt());
				Double grossamt=0.0;
				Double taxamt=0.0;
				Double amtwithouttax=0.0;
				grossamt=invStockInFB.getItemQuantity()*invStockInFB.getItemRate();
				taxamt=grossamt*store.getVatAmt()/100;
				amtwithouttax=grossamt-taxamt;
				stockInItem.setItemTotalPrice(amtwithouttax);
				stockInItem.setTaxRate(store.getVatAmt());
				stockInItem.setTaxAmount(taxamt);
				stockInItem.setItemGrossAmount(grossamt);
				stockInItem.setStoreId(customer.getStoreId());
				stockInItem.setPoId(invStockInFB.getPoNo());
				stockInItem.setCreatedBy(customer.getContactNo());
				stockInItem.setCreatedDate(date);
				System.out.println("invStockInFB.getMetricUnitId() after="+invStockInFB.getMetricUnitId());
				System.out.println("inventoryItems.getMetricUnitId() after="+inventoryItems.getMetricUnitId());
				stockInItem.setUnitId(inventoryItems.getMetricUnitId());
				
				
				inventoryStockInItemList.add(stockInItem);
			}
			logger.debug("Final inventoryStockInItemList : {}", inventoryStockInItemList);
			inventoryStockIn.setDate(sessionDate);
			inventoryStockIn.setUserId(customer.getContactNo());
			inventoryStockIn.setStoreId(customer.getStoreId());
			inventoryStockIn.setVendorId(NumberUtils.toInt(vendorId));
			inventoryStockIn.setBillNo(billNumber);
			inventoryStockIn.setBillDate(billDate);
			inventoryStockIn.setTotalQuantity(totalQty);
			inventoryStockIn.setMiscCharge(NumberUtils.toDouble(misChargeValue));
			inventoryStockIn.setTotalPrice(NumberUtils.toDouble(totalItemValue));
			inventoryStockIn.setCreatedBy(customer.getContactNo());
			inventoryStockIn.setCreatedDate(date);
			inventoryStockIn.setInventoryStockInItems(inventoryStockInItemList);
			logger.debug("Final inventoryStockIn Obj for save ...{} :", inventoryStockIn);

			stockInService.saveNewStockIn(inventoryStockIn);

			inventoryStockInList = stockInService.getInventoryStockInByDate(customer.getStoreId(), sessionDate);
			logger.debug("inventoryStockInList for checking : {}", inventoryStockInList.size());
			if (inventoryStockInList.size() != 0) {
				for (InventoryStockIn invStockIn : inventoryStockInList) {
					closeStatus = invStockIn.getClosed();
					misCharge = invStockIn.getMiscCharge();
//					grandTotalPrice = invStockIn.getTotalPrice();

					stockInDetails.setId(invStockIn.getId());
					stockInDetails.setUserId(invStockIn.getUserId());
					stockInDetails.setCreatedBy(invStockIn.getCreatedBy());
					stockInDetails.setCreatedDate(invStockIn.getCreatedDate());
					stockInDetails.setVendorName(invStockIn.getVendorName());
					stockInDetails.setBillNo(invStockIn.getBillNo());
					stockInDetails.setBillDate(invStockIn.getBillDate());
					stockInDetails.setClosed(invStockIn.getClosed());
					inventoryStockInDetailList.add(stockInDetails);

					inventoryStockInItemList = invStockIn.getInventoryStockInItems();

					inventoryStockIn = invStockIn;
					break;
				}

				for (InventoryStockInItem invStockInItem : inventoryStockInItemList) {
					double totalItemPrice = invStockInItem.getItemGrossAmount();
					grandTotalPrice += totalItemPrice;
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() == inVendor.getId()) {
						selectedVendorList.add(inVendor);
						break;
					}
				}

				for (InventoryVendors inVendor : vendorList) {
					if (inventoryStockIn.getVendorId() != inVendor.getId()) {
						selectedVendorList.add(inVendor);
					}
				}
			}
		}
		
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		grandTotalPrice=grandTotalPrice+misCharge;
		session.removeAttribute("invStockInItemList");
		logger.debug("Close Status :: " + closeStatus);
		mav.addObject("inventoryStockInList", inventoryStockInList);
		mav.addObject("inventoryStockInDetailList", inventoryStockInDetailList);
		mav.addObject("inventoryStockInItemList", inventoryStockInItemList);
		mav.addObject("vendorList", vendorList);
		mav.addObject("selectedVendorList", selectedVendorList);
		session.setAttribute("podate", date);
		session.setAttribute("sessionDate", sessionDate);
		session.setAttribute("stockInId", stockId);
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("grandTotalPrice", grandTotalPrice);
		session.setAttribute("closeStatus", closeStatus);
		session.setAttribute("newStockIn", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("searchBoxDisplay", "Y");
		session.setAttribute("misCharge", misCharge);

		return mav;
	}
}
