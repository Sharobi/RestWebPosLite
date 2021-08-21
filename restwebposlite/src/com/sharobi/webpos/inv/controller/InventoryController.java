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

import org.apache.commons.lang3.StringUtils;
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
import com.sharobi.webpos.inv.model.InvItem;
import com.sharobi.webpos.inv.model.InvUpdateItem;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.model.PurchaseOrder;
import com.sharobi.webpos.inv.model.PurchaseOrderFB;
import com.sharobi.webpos.inv.model.PurchaseOrderForm;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.login.model.User;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

/**
 * @author habib
 * 
 */
@SessionAttributes({ "purchaseOrderForm" })
@Controller
@RequestMapping("/inventory")
public class InventoryController {
	private final static Logger logger = LogManager.getLogger(InventoryController.class);
	private final static InventoryService inventoryService = new InventoryService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/viewinventory",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) {
		logger.debug("In Inventory......");
		Customer customer;
		Date currdate = new Date();
		List<PurchaseOrder> purchaseOrderList = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		InventoryPurchaseOrder inventoryPurchaseOrder = new InventoryPurchaseOrder();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		boolean flag = false;
		String poStatus = null;
		String approveStatus = null;
		int purchaseId = 0;
		double grandTotalItemPrice = 0.00;
		String searchBoxDisplay = "Y";
		double misCharge = 0.00;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date = dateFormat.format(currdate);
//		String date = Utility.getFormatedDateShort(currdate);
		logger.debug("Date  ::" + date);
		purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), Utility.getFormatedDateShort(currdate));
		logger.debug("purchaseOrderList : {}", purchaseOrderList);
		if (purchaseOrderList.size() != 0) {
			Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
			while (iterator.hasNext()) {
				PurchaseOrder purchaseOrder = (PurchaseOrder) iterator.next();
				if (flag == false) {
					purchaseId = purchaseOrder.getId();
					invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
					for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
						invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
						poStatus = inventoryPurchaseOrder1.getPoStatus();
						approveStatus = inventoryPurchaseOrder1.getApproved();
						misCharge = inventoryPurchaseOrder1.getShippingCharge();
//						grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
					}
					logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);
					for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
						grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
						String deleteFlag = invpoItem.getDeleteFlag();
						if ("N".equalsIgnoreCase(deleteFlag)) {
							finalPoItemList.add(invpoItem);
						}
					}

					/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
						double totalItemPrice = finalPoItem.getItemTotalPrice();
						grandTotalItemPrice += totalItemPrice;
					}*/
				}
				flag = true;
				//grandTotalItemPrice += misCharge;
				logger.debug("finalPoItemList...{}", finalPoItemList);
			}
		} else {
			logger.debug("Else Part");
			inventoryPurchaseOrder.setCreatedBy(customer.getContactNo());
			inventoryPurchaseOrder.setCreatedDate(date);
			inventoryPurchaseOrder.setId(0);
			invPurchaseOrderList.add(inventoryPurchaseOrder);
			poStatus = "N";
			searchBoxDisplay = "N";
		}
		grandTotalItemPrice=grandTotalItemPrice+misCharge;
		session.removeAttribute("invPOrderItemList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		logger.debug("invPurchaseOrderList :: {}", invPurchaseOrderList);
		logger.debug("poStatus :: " + poStatus);
		mav.addObject("purchaseOrderList", purchaseOrderList);
		mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
		//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
		mav.addObject("invPurchaseOrderItemList", finalPoItemList);
		mav.addObject("metricUnitList", metricUnitList);
		model.addAttribute("inventoryVendor", new InventoryVendors());
		model.addAttribute("user", new User());
		session.setAttribute("loginId", customer.getContactNo());
		session.setAttribute("podate", date);
		session.setAttribute("poStatus", poStatus);
		session.setAttribute("approveStatus", approveStatus);
		session.setAttribute("newRequisition", "N");
		session.setAttribute("stockStatus", "N");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("pucrhaseId", purchaseId);
		session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
		session.setAttribute("misCharge", misCharge);
		session.setAttribute("selectedDate", Utility.getFormatedDateShort(currdate));
		session.setAttribute("searchBoxDisplay", searchBoxDisplay);
		//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);
		
		return mav;
	}

	@RequestMapping(value = "/viewPOByDate",
					method = RequestMethod.GET)
	public ModelAndView viewInventoryByDate(@RequestParam String selectedDate,
											Model model,
											HttpSession session,
											HttpServletRequest request) {
		logger.debug("In viewPOByDate......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		InventoryPurchaseOrder inventoryPurchaseOrder = new InventoryPurchaseOrder();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		String poStatus = null;
		String approveStatus = null;
		int purchaseId = 0;
		double grandTotalItemPrice = 0.00;
		double misCharge = 0.00;
		String searchBoxDisplay = "Y";

		boolean flag = false;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
			Date currDate = new Date();

			logger.debug("Selected DATE :: {}", selectedDate);
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(selectedDate);
			String newDate = Utility.getFormatedDateShort(utilDate);
			String toDay = dateFormat.format(currDate);
			//newdatem
			toDay= Utility.getFormatedDateShort(currDate);
			logger.debug("New DATE :: {}", newDate);

			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);
			if (purchaseOrderList.size() != 0) {
				Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
				while (iterator.hasNext()) {
					PurchaseOrder purchaseOrder = (PurchaseOrder) iterator.next();

					if (flag == false) {
						purchaseId = purchaseOrder.getId();
						invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseOrder.getId());
						logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
						for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
							invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
							poStatus = inventoryPurchaseOrder1.getPoStatus();
							approveStatus = inventoryPurchaseOrder1.getApproved();
							misCharge = inventoryPurchaseOrder1.getShippingCharge();
//							grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
						}
						logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

						for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
							grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
							String deleteFlag = invpoItem.getDeleteFlag();
							if ("N".equalsIgnoreCase(deleteFlag)) {
								finalPoItemList.add(invpoItem);
							}
						}

						/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
							double totalItemPrice = finalPoItem.getItemTotalPrice();
							grandTotalItemPrice += totalItemPrice;
						}*/
					}
					flag = true;
					//grandTotalItemPrice += misCharge;
				}
			} else {
				logger.debug("Else Part");
				inventoryPurchaseOrder.setCreatedBy(customer.getContactNo());
				inventoryPurchaseOrder.setCreatedDate(selectedDate);
				inventoryPurchaseOrder.setId(0);
				invPurchaseOrderList.add(inventoryPurchaseOrder);
				poStatus = "N";
			}

			if (!toDay.equalsIgnoreCase(selectedDate)) {
				logger.debug("date is not matched.");
				searchBoxDisplay = "N";
			}
			grandTotalItemPrice=grandTotalItemPrice+misCharge;
			session.removeAttribute("invPOrderItemList");
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			logger.debug("poStatus :: " + poStatus);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			session.setAttribute("loginId", customer.getContactNo());
			mav.addObject("podate", selectedDate);
			model.addAttribute("inventoryVendor", new InventoryVendors());
			model.addAttribute("user", new User());
			session.setAttribute("poDate", selectedDate);
			session.setAttribute("poStatus", poStatus);
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", searchBoxDisplay);
			//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);

			return mav;
		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/purchaseItemsByPoId",
					method = RequestMethod.GET)
	public ModelAndView getPurchaseItemsByPoId(	@RequestParam String poId,
												String date,
												Model model,
												HttpSession session,
												HttpServletRequest request) {
		logger.debug("In getPurchaseItemsByPoId......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		String poStatus = null;
		String approveStatus = null;
		double grandTotalItemPrice = 0.00;
		double misCharge = 0.00;
		logger.debug("Current DATE :: {}", date);

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(date);
			String newDate = Utility.getFormatedDateShort(utilDate);
			logger.debug("New DATE :: {}", newDate);
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			int purchaseId = NumberUtils.toInt(poId);

			List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);

			invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), NumberUtils.toInt(poId));
			logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
			for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
				invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
				poStatus = inventoryPurchaseOrder1.getPoStatus();
				approveStatus = inventoryPurchaseOrder1.getApproved();
				misCharge = inventoryPurchaseOrder1.getShippingCharge();
//				grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
//				grandTotalItemPrice = grandTotalItemPrice+inventoryPurchaseOrder1.getTotalPrice();
				for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
					grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
					String deleteFlag = invpoItem.getDeleteFlag();
					if ("N".equalsIgnoreCase(deleteFlag)) {
						finalPoItemList.add(invpoItem);
					}
				}

				/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
					double totalItemPrice = finalPoItem.getItemTotalPrice();
					grandTotalItemPrice += totalItemPrice;
				}*/
			}
			grandTotalItemPrice=grandTotalItemPrice + misCharge;
			System.out.println("misCharge="+misCharge);
			System.out.println("grandTotalItemPrice="+grandTotalItemPrice);
			logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);
			logger.debug("poStatus :: " + poStatus);

			session.removeAttribute("invPOrderItemList");
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			session.setAttribute("loginId", customer.getContactNo());
			mav.addObject("podate", date);
			model.addAttribute("inventoryVendor", new InventoryVendors());
			model.addAttribute("user", new User());
			session.setAttribute("poDate", date);
			session.setAttribute("poStatus", poStatus);
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("pucrhaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", "Y");
			//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);

			return mav;
		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/inventoryitems",
					method = RequestMethod.GET)
	public ModelAndView getInventoryItems(	@RequestParam("tagName") String tagName,
											Model model,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) throws IOException {
		logger.debug("In getInventoryItems......");
		Customer customer = null;
		List<InvItem> invItemList = new ArrayList<InvItem>();
		List<InvItem> resultList = new ArrayList<InvItem>();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		String itemExistStatus = "N";
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		PrintWriter out = response.getWriter();
		response.setContentType("application/json");

		inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());
		logger.debug("inventoryItemList : {}", inventoryItemList);
		Iterator<InventoryItems> itr = inventoryItemList.iterator();
		while (itr.hasNext()) {
			InventoryItems inventoryItems = (InventoryItems) itr.next();
			invItemList.add(new InvItem(inventoryItems.getId(), inventoryItems.getCode(), inventoryItems.getName()));
		}
		logger.debug("inventory item name List: {}", invItemList);

		for (InvItem invItem : invItemList) {
			if (StringUtils.startsWithIgnoreCase(invItem.getName(), tagName)) {
				resultList.add(invItem);
			}
		}
		logger.debug("Item Result list:: {}", resultList);
		if (resultList.size() > 0) {
			itemExistStatus = "Y";
		}
		logger.debug("itemExistStatus :: " + itemExistStatus);
		logger.debug(new Gson().toJson(resultList));
		out.print(new Gson().toJson(resultList).toString());

		return null;

	}

	@RequestMapping(value = "/approvedPO",
					method = RequestMethod.GET)
	public ModelAndView approvedPO(	@RequestParam String poId,
									@RequestParam String updatedBy,
									@RequestParam String updatedDate,
									Model model,
									HttpSession session,
									HttpServletRequest request) {
		logger.debug("In approvedPO......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();

		boolean flag = false;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(updatedDate);
			String newDate = Utility.getFormatedDateShort(utilDate);
			//newdatem
			updatedDate=Utility.getFormatedDateShort(utilDate);
			logger.debug("New DATE :: {}", newDate);
			String approveStatus = null;
			double grandTotalItemPrice = 0.00;
			double misCharge = 0.00;
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			session.removeAttribute("invPOrderItemList");
			int purchaseId = NumberUtils.toInt(poId);
			inventoryService.approvedPO(poId, updatedBy, updatedBy, updatedDate);

			List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);
			Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
			while (iterator.hasNext()) {
				PurchaseOrder purchaseOrder = (PurchaseOrder) iterator.next();
				if (flag == false) {
					invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
					logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
					for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
						invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
						approveStatus = inventoryPurchaseOrder1.getApproved();
						misCharge = inventoryPurchaseOrder1.getShippingCharge();
//						grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
					}
					logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);
					for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
						grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
						String deleteFlag = invpoItem.getDeleteFlag();
						if ("N".equalsIgnoreCase(deleteFlag)) {
							finalPoItemList.add(invpoItem);
						}
					}

					/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
						double totalItemPrice = finalPoItem.getItemTotalPrice();
						grandTotalItemPrice += totalItemPrice;
					}*/
				}
				flag = true;
				//grandTotalItemPrice += misCharge;
			}
			grandTotalItemPrice = grandTotalItemPrice+misCharge;
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			session.removeAttribute("invPOrderItemList");
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			session.setAttribute("loginId", customer.getContactNo());
			mav.addObject("podate", updatedDate);
			model.addAttribute("inventoryVendor", new InventoryVendors());
			model.addAttribute("user", new User());
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("poStatus", "N");
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", "Y");
			return mav;
		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/updatedPO",
					method = RequestMethod.GET)
	public ModelAndView updatedPO(	@RequestParam String poId,
									@RequestParam String poBy,
									@RequestParam String updatedDate,
									Model model,
									HttpSession session,
									HttpServletRequest request) {
		logger.debug("In updatedPO......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		String approveStatus = null;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		try {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(updatedDate);
			String newDate = Utility.getFormatedDateShort(utilDate);
			//newdatem
			updatedDate=Utility.getFormatedDateShort(utilDate);
			logger.debug("New DATE :: {}", newDate);
			String poStatus = null;
			boolean flag = false;
			double grandTotalItemPrice = 0.00;
			double misCharge = 0.00;
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			session.removeAttribute("invPOrderItemList");
			int purchaseId = NumberUtils.toInt(poId);
			inventoryService.updatedPO(poId, poBy, poBy, updatedDate);

			List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);
			Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
			while (iterator.hasNext()) {
				PurchaseOrder purchaseOrder = (PurchaseOrder) iterator.next();

				if (flag == false) {
					invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
					logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
					for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
						invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
						poStatus = inventoryPurchaseOrder1.getPoStatus();
						approveStatus = inventoryPurchaseOrder1.getApproved();
						misCharge = inventoryPurchaseOrder1.getShippingCharge();
//						grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
					}
					logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

					for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
						grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
						String deleteFlag = invpoItem.getDeleteFlag();
						if ("N".equalsIgnoreCase(deleteFlag)) {
							finalPoItemList.add(invpoItem);
						}
					}

					/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
						double totalItemPrice = finalPoItem.getItemTotalPrice();
						grandTotalItemPrice += totalItemPrice;
					}*/
				}
				flag = true;
				//grandTotalItemPrice += misCharge;
			}
			grandTotalItemPrice = grandTotalItemPrice+misCharge;
			session.removeAttribute("invPOrderItemList");
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			session.setAttribute("loginId", customer.getContactNo());
			mav.addObject("podate", updatedDate);
			model.addAttribute("inventoryVendor", new InventoryVendors());
			model.addAttribute("user", new User());
			session.setAttribute("loginId", customer.getContactNo());
			session.setAttribute("poStatus", poStatus);
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", "Y");
			return mav;

		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/updatePoEachItem/{itemId}/{itemQty}/{rate}/{date}/{poId}",
					method = RequestMethod.GET)
	public ModelAndView updatePoEachItem(	@PathVariable("itemId") String itemId,
											@PathVariable("itemQty") String itemQty,
											@PathVariable("rate") String rate,
											@PathVariable("date") String date,
											@PathVariable("poId") String poId,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) throws IOException {
		logger.debug("In updatePoEachItem......::{},{},{},{}", itemId, itemQty,rate, date, poId);
		Customer customer = null;
		List<PurchaseOrder> purchaseOrderList = new ArrayList<PurchaseOrder>();
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		InventoryPurchaseOrderItems inventoryPurchaseOrderItems = new InventoryPurchaseOrderItems();
		PurchaseOrder purchaseOrder = new PurchaseOrder();
		InventoryPurchaseOrder inventoryPurchaseOrder = new InventoryPurchaseOrder();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		InvUpdateItem updateItem = new InvUpdateItem();
		String poStatus = null;
		String approveStatus = null;
		double grandTotalItemPrice = 0.00;
		double misCharge = 0.00;

		boolean flag = false;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;

		}
		try {
			logger.debug("Current DATE :: {}", date);
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(date);
			String newDate = Utility.getFormatedDateShort(utilDate);
			logger.debug("New DATE :: {}", newDate);

			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			session.removeAttribute("invPOrderItemList");
			int purchaseId = NumberUtils.toInt(poId);
			invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), NumberUtils.toInt(poId));
			logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
			for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
				invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
				inventoryPurchaseOrder = inventoryPurchaseOrder1;
				misCharge = inventoryPurchaseOrder1.getShippingCharge();
			}
			logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

			poStatus = inventoryPurchaseOrder.getPoStatus();

			for (InventoryPurchaseOrderItems invPItems : invPurchaseOrderItemList) {
				if (invPItems.getId() == NumberUtils.toInt(itemId)) {
					invPItems.setItemQuantity(NumberUtils.toDouble(itemQty));
					
					double rate1 = Double.valueOf(rate);
					invPItems.setRate(rate1);
					double totalPrice = rate1 * NumberUtils.toDouble(itemQty);
					double shipCharge = invPItems.getShippingCharge();
					double totalgrossAmt = totalPrice + shipCharge;
					logger.debug("Total price :{}" + totalgrossAmt);
					invPItems.setItemTotalPrice(totalgrossAmt);

					inventoryPurchaseOrderItems = invPItems;
					break;
				}
			}

			inventoryPurchaseOrder.setInventoryPurchaseOrderItems(null);
			inventoryPurchaseOrderItems.setInventoryPurchaseOrder(inventoryPurchaseOrder);
			logger.debug("Final inventoryPurchaseOrderItem for row update :: {}", inventoryPurchaseOrderItems);

			String jResponse = inventoryService.updatePoEachItem(inventoryPurchaseOrderItems);
			logger.debug("Respone in Controller : " + jResponse);

			invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
			logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
			for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
				invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
				poStatus = inventoryPurchaseOrder1.getPoStatus();
				approveStatus = inventoryPurchaseOrder1.getApproved();
			}
			logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

			for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
//				grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
				String deleteFlag = invpoItem.getDeleteFlag();
				if ("N".equalsIgnoreCase(deleteFlag)) {
					finalPoItemList.add(invpoItem);
				}
			}

			for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
				double totalItemPrice = finalPoItem.getItemTotalPrice();
				grandTotalItemPrice += totalItemPrice;
			}

			for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
				if (NumberUtils.toInt(itemId) == finalPoItem.getId()) {
					updateItem.setItemId(finalPoItem.getId());
					updateItem.setItemQuantity(finalPoItem.getItemQuantity());
					updateItem.setItemPrice(finalPoItem.getItemTotalPrice());
					updateItem.setTotalItemPrice(grandTotalItemPrice);
					updateItem.setResponse(jResponse);
					break;
				}
			}
//			grandTotalItemPrice = grandTotalItemPrice+misCharge;
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(new Gson().toJson(updateItem));
			out.flush();
			return null;

		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		} catch (IOException ioe) {
			logger.error("IOException", ioe);
			return null;
		}

	}

	@RequestMapping(value = "/deletePoItem",
					method = RequestMethod.GET)
	public ModelAndView deletePoItem(	@RequestParam String poId,
										@RequestParam String poItemId,
										Model model,
										HttpSession session,
										HttpServletRequest request) {
		logger.debug("In deletePoItem......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		String poStatus = null;
		String approveStatus = null;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		try {
			String todayDate = (String) session.getAttribute("podate");
			logger.debug("Today date :: " + todayDate);//selectedDate
			String sessionDate = (String) session.getAttribute("selectedDate");
			logger.debug("sessionDate :: " + sessionDate);

			logger.debug("Po Id :: " + poId);
			logger.debug("Po ItemId :: " + poItemId);
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(todayDate);
			String newDate = Utility.getFormatedDateShort(utilDate);
			logger.debug("New DATE :: {}", newDate);
			//newdatem
			todayDate=Utility.getFormatedDateShort(utilDate);
			double grandTotalItemPrice = 0.00;
			double misCharge = 0.00;
			boolean flag = false;
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			int purchaseId = NumberUtils.toInt(poId);
			session.removeAttribute("invPOrderItemList");

			inventoryService.deletePoItem(poId, poItemId, customer.getStoreId());

			List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), sessionDate);
			Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
			while (iterator.hasNext()) {
				PurchaseOrder purchaseOrder = (PurchaseOrder) iterator.next();

				if (flag == false) {
					invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
					logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
					for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
						invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
						approveStatus = inventoryPurchaseOrder1.getApproved();
						poStatus = inventoryPurchaseOrder1.getPoStatus();
						misCharge = inventoryPurchaseOrder1.getShippingCharge();
//						grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
					}
					logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

					for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
						grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
//						misCharge = inventoryPurchaseOrder1.getShippingCharge();
						String deleteFlag = invpoItem.getDeleteFlag();
						if ("N".equalsIgnoreCase(deleteFlag)) {
							finalPoItemList.add(invpoItem);
						}
					}

					/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
						double totalItemPrice = finalPoItem.getItemTotalPrice();
						grandTotalItemPrice += totalItemPrice;
					}*/

				}
				flag = true;
				//grandTotalItemPrice += misCharge;
			}
			grandTotalItemPrice = grandTotalItemPrice+misCharge;
			logger.debug("PO STATUS ::" + poStatus);
			session.removeAttribute("invPOrderItemList");
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			mav.addObject("podate", todayDate);
			model.addAttribute("inventoryVendor", new InventoryVendors());
			session.setAttribute("loginId", customer.getContactNo());
			model.addAttribute("user", new User());
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("poStatus", poStatus);
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", "Y");
			return mav;
		} catch (ParseException e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/newRequisition",
					method = RequestMethod.GET)
	public ModelAndView newRequisition(	Model model,
										HttpSession session,
										HttpServletRequest request) {
		logger.debug("In newRequisition......");
		Customer customer = null;
		Date currdate = new Date();
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<PurchaseOrder> purchaseOrderList = new ArrayList<PurchaseOrder>();
		InventoryPurchaseOrder inventoryPurchaseOrder = new InventoryPurchaseOrder();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
//		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date = dateFormat.format(currdate);
		logger.debug("Date in String Format ::" + date);
		//newdatem
		date=Utility.getFormatedDateShort(currdate);
		session.removeAttribute("invPOrderItemList");
		purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), Utility.getFormatedDateShort(currdate));

		inventoryPurchaseOrder.setId(0);
		inventoryPurchaseOrder.setCreatedBy(customer.getContactNo());
		inventoryPurchaseOrder.setCreatedDate(date);
		invPurchaseOrderList.add(inventoryPurchaseOrder);

		session.removeAttribute("invPOrderItemList");
		List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
		mav.addObject("metricUnitList", metricUnitList);
		mav.addObject("purchaseOrderList", purchaseOrderList);
		mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
		mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
		model.addAttribute("inventoryVendor", new InventoryVendors());
		session.setAttribute("loginId", customer.getContactNo());
		model.addAttribute("user", new User());
		session.setAttribute("podate", date);
		session.setAttribute("poStatus", "N");
		session.setAttribute("approveStatus", "N");
		session.setAttribute("stockStatus", "N");
		session.setAttribute("newRequisition", "Y");
		session.setAttribute("addItemFlag", "N");
		session.setAttribute("purchaseId", 0);
		session.setAttribute("selectedDate", Utility.getFormatedDateShort(currdate));
		session.setAttribute("grandTotalItemPrice", 0.00);
		session.setAttribute("misCharge", 0.00);
		session.setAttribute("itemListSize", 0);
		session.setAttribute("searchBoxDisplay", "Y");

		return mav;
	}

	@RequestMapping(value = "/getItemInfoFromPage/{itemCode}/{qty}/{unit}/{rate}/{totalAmt}/{sumTotal}",
					method = RequestMethod.GET)
	public void getItemInfoFromPage(@PathVariable String itemCode,
									@PathVariable String qty,
									@PathVariable String unit,
									@PathVariable String rate,
									@PathVariable String totalAmt,
									@PathVariable String sumTotal,
									HttpSession session) {

		logger.debug("getItemInfoFromPage...{},{},{},{},{} :", itemCode, qty,unit, rate, totalAmt, sumTotal);
		List<InventoryPurchaseOrderItems> poOrderItemList = (List<InventoryPurchaseOrderItems>) session.getAttribute("invPOrderItemList");
		logger.debug("Session InventoryPurchaseOrderItemList {}", poOrderItemList);
		List<PurchaseOrderFB> poOrderFbList = (List<PurchaseOrderFB>) session.getAttribute("purchaseOrderFbList");
		logger.debug("Session PurchaseOrderFB List {}", poOrderFbList);
		boolean flag = poOrderItemList == null ? true : false;
		boolean flagpoOrderFbList = poOrderFbList == null ? true : false;

		if (flag == false) {
			for (InventoryPurchaseOrderItems invPoItem : poOrderItemList) {
				String itmCode = invPoItem.getInventoryItems().getCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					invPoItem.setItemQuantity(NumberUtils.toDouble(qty));
					invPoItem.setUnitId(NumberUtils.toInt(unit));
					invPoItem.setRate(NumberUtils.toDouble(rate));
					invPoItem.setItemTotalPrice(NumberUtils.toDouble(totalAmt));
					break;
				}
			}
		}
		if (flagpoOrderFbList == false) {
			for (PurchaseOrderFB purchaseOrderFB : poOrderFbList) {
				String itmCode = purchaseOrderFB.getItemCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					purchaseOrderFB.setItemQuantity(NumberUtils.toDouble(qty));
					purchaseOrderFB.setMetricUnitId(NumberUtils.toInt(unit));
					purchaseOrderFB.setItemRate(NumberUtils.toDouble(rate));
					purchaseOrderFB.setTotalPrice(NumberUtils.toDouble(totalAmt));
					break;
				}
			}
		}
		logger.debug("poOrderFbList after edit...{} : ", poOrderFbList);
		logger.debug("poOrderItemList after edit...{} : ", poOrderItemList);
		session.setAttribute("purchaseOrderFbList", poOrderFbList);
		session.setAttribute("invPOrderItemList", poOrderItemList);
		session.setAttribute("grandTotalItemPrice", NumberUtils.toDouble(sumTotal));
	}

	@RequestMapping(value = "/getItemRateFromPage/{itemCode}/{qty}/{rate}/{totalAmt}/{sumTotal}",
					method = RequestMethod.GET)
	public void getItemRateFromPage(@PathVariable String itemCode,
									@PathVariable String qty,
									@PathVariable String rate,
									@PathVariable String totalAmt,
									@PathVariable String sumTotal,
									HttpSession session) {

		logger.debug("getItemRateFromPage...{},{},{},{},{} :", itemCode, qty, rate, totalAmt, sumTotal);
		List<InventoryPurchaseOrderItems> poOrderItemList = (List<InventoryPurchaseOrderItems>) session.getAttribute("invPOrderItemList");
		logger.debug("Session InventoryPurchaseOrderItemList {}", poOrderItemList);
		List<PurchaseOrderFB> poOrderFbList = (List<PurchaseOrderFB>) session.getAttribute("purchaseOrderFbList");
		logger.debug("Session PurchaseOrderFB List {}", poOrderFbList);
		boolean flag = poOrderItemList == null ? true : false;
		boolean flagpoOrderFbList = poOrderFbList == null ? true : false;

		if (flag == false) {
			for (InventoryPurchaseOrderItems invPoItem : poOrderItemList) {
				String itmCode = invPoItem.getInventoryItems().getCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					invPoItem.setItemQuantity(NumberUtils.toDouble(qty));
					invPoItem.setRate(NumberUtils.toDouble(rate));
					invPoItem.setItemTotalPrice(NumberUtils.toDouble(totalAmt));
					break;
				}
			}
		}
		if (flagpoOrderFbList == false) {
			for (PurchaseOrderFB purchaseOrderFB : poOrderFbList) {
				String itmCode = purchaseOrderFB.getItemCode();
				if (itmCode.equalsIgnoreCase(itemCode)) {
					purchaseOrderFB.setItemQuantity(NumberUtils.toDouble(qty));
//					purchaseOrderFB.setMetricUnitId(NumberUtils.toInt(unit));
					purchaseOrderFB.setItemRate(NumberUtils.toDouble(rate));
					purchaseOrderFB.setTotalPrice(NumberUtils.toDouble(totalAmt));
					break;
				}
			}
		}
		logger.debug("poOrderFbList after edit...{} : ", poOrderFbList);
		session.setAttribute("purchaseOrderFbList", poOrderFbList);
		logger.debug("poOrderItemList after edit...{} : ", poOrderItemList);
		session.setAttribute("invPOrderItemList", poOrderItemList);
		session.setAttribute("grandTotalItemPrice", NumberUtils.toDouble(sumTotal));
	}

	@RequestMapping(value = "/createNewPurchaseOrderItemRow",
					method = RequestMethod.GET)
	public ModelAndView createNewPurchaseOrderItemRow(	@RequestParam String itemName,
														@RequestParam String poId,
														@RequestParam String userId,
														@RequestParam String date,
														@RequestParam String miscValue,
														@ModelAttribute("inventoryVendor") InventoryVendors inventoryVendor,
														Model model,
														HttpSession session,
														HttpServletRequest request) {
		logger.debug("In createNewPurchaseOrderItemRow......");
		Customer customer = null;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<PurchaseOrder> purchaseOrderList = new ArrayList<PurchaseOrder>();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		//InventoryPurchaseOrderItems invPurchaseOrderItems = new InventoryPurchaseOrderItems();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		InventoryPurchaseOrder invPurchaseOrder = new InventoryPurchaseOrder();
		List<PurchaseOrderFB> purchaseOrderFbList = null;
		PurchaseOrderForm purchaseOrderForm = new PurchaseOrderForm();
		String stockStatus = "N";
		String stockNumber = null;
		String approveStatus = null;
		int poFbId = 0;
		boolean itemFlag = false;
		boolean itemListStatus = false;
		String addItemFlag = "N";
		String newRequisition = "Y";
		String formStart = "N";
		double grandTotalPrice = 0.00;
		double misCharge = 0.00;
		int itemListSize = 0;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(date);
			String newDate = Utility.getFormatedDateShort(utilDate);
			logger.debug("Date ::" + date);
			//newdatem
			date=Utility.getFormatedDateShort(utilDate);
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);

			int purchaseId = NumberUtils.toInt(poId);

			InventoryPurchaseOrderItems invPOrderItems = (InventoryPurchaseOrderItems) session.getAttribute("invPOrderItems");
			logger.debug("Session InventoryPurchaseOrderItems {}", invPOrderItems);

			purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);

			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
			logger.debug("Fetched vendorList :: {}", vendorList);

			inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());

			List<InventoryPurchaseOrderItems> poOrderItemList = (List<InventoryPurchaseOrderItems>) session.getAttribute("invPOrderItemList");
			logger.debug("Session InventoryPurchaseOrderItemList {}", poOrderItemList);
			boolean flag = poOrderItemList == null ? true : false;

			if (NumberUtils.toInt(poId) != 0) {
				//addItemFlag = "Y";
				//newRequisition = "N";
				String sessionFormStatus = (String) session.getAttribute("formStart");
				boolean formStatusFlag = sessionFormStatus == null ? false : true;
				logger.debug("sessionFormStatus ::" + formStatusFlag);
				invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), NumberUtils.toInt(poId));
				if (itemListStatus == false && flag == true) {
					for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
						invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
						approveStatus = inventoryPurchaseOrder1.getApproved();
						misCharge = inventoryPurchaseOrder1.getShippingCharge();
						//grandTotalPrice = inventoryPurchaseOrder1.getTotalPrice();
						itemListStatus = true;
					}
					for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
						String deleteFlag = invpoItem.getDeleteFlag();
						if ("N".equalsIgnoreCase(deleteFlag)) {
							finalPoItemList.add(invpoItem);
						}
					}
				}

				if (flag == false) {
					finalPoItemList = poOrderItemList;
				}

				if (finalPoItemList.size() != 0) {
					for (InventoryPurchaseOrderItems poItems : finalPoItemList) {
						String poItemName = poItems.getInventoryItems().getName();
						if (poItemName.equalsIgnoreCase(itemName)) {
							itemFlag = true;
							if (formStatusFlag == true) {
								newRequisition = "Y";
								addItemFlag = "Y";
							} else {
								newRequisition = "N";
							}
							itemListStatus = false;
							//addItemFlag = "Y";
						}
					}
				}

				if (itemFlag == false) {
					itemListSize = finalPoItemList.size();// POItemList Size

					for (InventoryItems inventoryItem : inventoryItemList) {
						String itmName = inventoryItem.getName();

						if (itmName.equalsIgnoreCase(itemName)) {

							logger.debug("Inventory Item Name ::" + itmName);
							inventoryItems = inventoryItem;
							stockNumber = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryItems.getId());
							if (inventoryItems.getDailyRequirement() > NumberUtils.toDouble(stockNumber)) {
								stockStatus = "Y";
							}
							InventoryPurchaseOrderItems invPurchaseOrderItems = new InventoryPurchaseOrderItems();
							invPurchaseOrderItems.setId(0);
							invPurchaseOrderItems.setOldStock(stockNumber);
							invPurchaseOrderItems.setRequiredQuantity(inventoryItem.getDailyRequirement());
							invPurchaseOrderItems.setItemQuantity(1);
							invPurchaseOrderItems.setRate(inventoryItem.getRate());
							invPurchaseOrderItems.setShippingCharge(inventoryItem.getShippingCharge());
							invPurchaseOrderItems.setItemTotalPrice(inventoryItem.getRate() + inventoryItem.getShippingCharge());
							invPurchaseOrderItems.setVendorName(inventoryItem.getVendorName());
							invPurchaseOrderItems.setVendorId(inventoryItem.getVendorId());
							invPurchaseOrderItems.setApproveFlag("N");
							invPurchaseOrderItems.setInventoryItems(inventoryItem);
							session.setAttribute("invPOrderItems", invPurchaseOrderItems);
							finalPoItemList.add(invPurchaseOrderItems);
							addItemFlag = "Y";
							break;
						} else {}
					}
				}

				logger.debug("Fetched inventoryItems :: {}", inventoryItems);
				logger.debug("final invPurchaseOrderItemList :: {}", finalPoItemList);
				session.setAttribute("invPOrderItemList", finalPoItemList);

				if ("Y".equalsIgnoreCase(newRequisition)) {//grandTotalPrice
					purchaseOrderFbList = new ArrayList<PurchaseOrderFB>();
					for (InventoryPurchaseOrderItems invPurchaseItem : finalPoItemList) {
						String stockFlag = "N";
						String itmCode = invPurchaseItem.getInventoryItems().getCode();
						String itmName = invPurchaseItem.getInventoryItems().getName();
						poFbId += 1;
						String stockNo = invPurchaseItem.getOldStock();
						double reqQty = invPurchaseItem.getRequiredQuantity();
						double itemQty = invPurchaseItem.getItemQuantity();
						String itemUnit = invPurchaseItem.getInventoryItems().getUnit();
//						int unitid=invPurchaseItem.getUnitId();
						int unitid=invPurchaseItem.getInventoryItems().getMetricUnitId();
						double itmRate = invPurchaseItem.getRate();
						double totalPrice = invPurchaseItem.getItemTotalPrice();
						double shippingCharge = invPurchaseItem.getShippingCharge();
						int vendorId = invPurchaseItem.getVendorId();
						String vendorName = invPurchaseItem.getVendorName();
						String approveFlag = invPurchaseItem.getApproveFlag();
						grandTotalPrice += totalPrice;
						if (reqQty > NumberUtils.toDouble(stockNo)) {
							stockFlag = "Y";
						}

						purchaseOrderFbList.add(new PurchaseOrderFB(poFbId, itmCode, itmName, stockNo, reqQty, itemQty, itemUnit, itmRate, shippingCharge, totalPrice, vendorId, vendorName, stockFlag, approveFlag,unitid));
					}
					logger.debug("PurchaseOrderFBList.. {}", purchaseOrderFbList);
					purchaseOrderForm.setPurchaseOrderFbList(purchaseOrderFbList);
					logger.debug("purchaseOrderForm.. {}", purchaseOrderForm);
					formStart = "Y";
					session.setAttribute("formStart", formStart);
				}
				misCharge = NumberUtils.toDouble(miscValue);
				grandTotalPrice += misCharge;

			} else {
				invPurchaseOrder.setId(0);
				invPurchaseOrder.setCreatedBy(userId);
				invPurchaseOrder.setCreatedDate(date);
				invPurchaseOrderList.add(invPurchaseOrder);

				if (flag == false) {
					finalPoItemList = poOrderItemList;
				}

				if (finalPoItemList.size() != 0) {
					for (InventoryPurchaseOrderItems poItems : finalPoItemList) {
						String poItemName = poItems.getInventoryItems().getName();
						if (poItemName.equalsIgnoreCase(itemName)) {
							itemFlag = true;
						}
					}
				}

				if (itemFlag == false) {
					itemListSize = finalPoItemList.size();// POItemList Size

					for (InventoryItems inventoryItem : inventoryItemList) {
						String itmName = inventoryItem.getName();

						if (itmName.equalsIgnoreCase(itemName)) {

							logger.debug("Inventory Item Name ::" + itmName);
							inventoryItems = inventoryItem;
							stockNumber = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryItems.getId());
							if (inventoryItems.getDailyRequirement() > NumberUtils.toDouble(stockNumber)) {
								stockStatus = "Y";
							}
							InventoryPurchaseOrderItems invPurchaseOrderItems = new InventoryPurchaseOrderItems();
							invPurchaseOrderItems.setId(0);
							invPurchaseOrderItems.setOldStock(stockNumber);
							System.out.println("invPurchaseOrderItems.getOldStock(stockNumber)="+invPurchaseOrderItems.getOldStock());
							invPurchaseOrderItems.setRequiredQuantity(inventoryItem.getDailyRequirement());
							invPurchaseOrderItems.setItemQuantity(1);
							invPurchaseOrderItems.setRate(inventoryItem.getRate());
							invPurchaseOrderItems.setShippingCharge(inventoryItem.getShippingCharge());
							invPurchaseOrderItems.setItemTotalPrice(inventoryItem.getRate() + inventoryItem.getShippingCharge());
							invPurchaseOrderItems.setVendorName(inventoryItem.getVendorName());
							invPurchaseOrderItems.setVendorId(inventoryItem.getVendorId());
							invPurchaseOrderItems.setApproveFlag("N");
							invPurchaseOrderItems.setInventoryItems(inventoryItem);
							session.setAttribute("invPOrderItems", invPurchaseOrderItems);
							finalPoItemList.add(invPurchaseOrderItems);
							break;
						} else {}
					}
				}

				logger.debug("Fetched inventoryItems :: {}", inventoryItems);
				logger.debug("final invPurchaseOrderItemList :: {}", finalPoItemList);
				session.setAttribute("invPOrderItemList", finalPoItemList);
				misCharge = NumberUtils.toDouble(miscValue);

				if ("Y".equalsIgnoreCase(newRequisition)) {
					purchaseOrderFbList = new ArrayList<PurchaseOrderFB>();
					for (InventoryPurchaseOrderItems invPurchaseItem : finalPoItemList) {
						String stockFlag = "N";
						String itmCode = invPurchaseItem.getInventoryItems().getCode();
						String itmName = invPurchaseItem.getInventoryItems().getName();
						poFbId += 1;
						String stockNo = invPurchaseItem.getOldStock();
						System.out.println("invPurchaseItem.getOldStock()="+invPurchaseItem.getOldStock());
						double reqQty = invPurchaseItem.getRequiredQuantity();
						double itemQty = invPurchaseItem.getItemQuantity();
						String itemUnit = invPurchaseItem.getInventoryItems().getUnit();
						double itmRate = invPurchaseItem.getRate();
						double totalPrice = invPurchaseItem.getItemTotalPrice();
						double shippingCharge = invPurchaseItem.getShippingCharge();
						int vendorId = invPurchaseItem.getVendorId();
//						int unitid=invPurchaseItem.getUnitId();
						int unitid=invPurchaseItem.getInventoryItems().getMetricUnitId();
						String vendorName = invPurchaseItem.getVendorName();
						String approveFlag = invPurchaseItem.getApproveFlag();//miscValue
						grandTotalPrice += totalPrice;
						if (reqQty > NumberUtils.toDouble(stockNo)) {
							stockFlag = "Y";
						}
						purchaseOrderFbList.add(new PurchaseOrderFB(poFbId, itmCode, itmName, stockNo, reqQty, itemQty, itemUnit, itmRate, shippingCharge, totalPrice, vendorId, vendorName, stockFlag, approveFlag,unitid));
					}
					logger.debug("PurchaseOrderFBList.. {}", purchaseOrderFbList);
					purchaseOrderForm.setPurchaseOrderFbList(purchaseOrderFbList);
					logger.debug("purchaseOrderForm.. {}", purchaseOrderForm);
					addItemFlag = "Y";
				}
				grandTotalPrice += misCharge;
			}
			List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
			logger.debug("Inv PurcHASE OrderItem List :: {}", finalPoItemList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("vendorList", vendorList);
			mav.addObject("purchaseOrderForm", purchaseOrderForm);
			mav.addObject("podate", date);
			session.setAttribute("purchaseOrderFbList", purchaseOrderFbList);
			session.setAttribute("inventoryItems", inventoryItems);
			model.addAttribute("user", new User());
			session.setAttribute("podate", date);
			session.setAttribute("poStatus", "N");
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("stockStatus", stockStatus);
			session.setAttribute("newRequisition", newRequisition);
			model.addAttribute("inventoryVendor", inventoryVendor);
			session.setAttribute("addItemFlag", addItemFlag);
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("itemListSize", itemListSize);
			session.setAttribute("searchBoxDisplay", "Y");
			//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);
			return mav;

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/removeOrderItemRow",
					method = RequestMethod.GET)
	public ModelAndView removeOrderItemRow(	@RequestParam String itemcode,
											@RequestParam String totalPrice,
											@RequestParam String miscValue,
											@RequestParam String poId,
											@RequestParam String userId,
											@RequestParam String date,
											@ModelAttribute("inventoryVendor") InventoryVendors inventoryVendor,
											Model model,
											HttpSession session,
											HttpServletRequest request) {
		logger.debug("In removeOrderItemRow......");
		Customer customer = null;
		;
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> invpoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<PurchaseOrder> purchaseOrderList = new ArrayList<PurchaseOrder>();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		//InventoryPurchaseOrderItems invPurchaseOrderItems = new InventoryPurchaseOrderItems();
		InventoryPurchaseOrder invPurchaseOrder = new InventoryPurchaseOrder();
		List<PurchaseOrderFB> purchaseOrderFbList = new ArrayList<PurchaseOrderFB>();
		PurchaseOrderForm purchaseOrderForm = new PurchaseOrderForm();
		String stockStatus = "N";
		String stockNumber = null;
		String approveStatus = "N";
		int poFbId = 0;
		boolean itemFlag = false;
		String addItemFlag = "Y";
		String newRequisition = "Y";
		double grandTotalPrice = 0.00;
		double misCharge = 0.00;

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date utilDate = dateFormat.parse(date);
			String newDate = Utility.getFormatedDateShort(utilDate);
			//newdatem
			date=Utility.getFormatedDateShort(utilDate);
			logger.debug("Date ::" + date);
			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			List<PurchaseOrderFB> poOrderFbList = (List<PurchaseOrderFB>) session.getAttribute("purchaseOrderFbList");
			logger.debug("Session PurchaseOrderFB List {}", poOrderFbList);
			int purchaseId = NumberUtils.toInt(poId);
			InventoryPurchaseOrderItems invPOrderItems = (InventoryPurchaseOrderItems) session.getAttribute("invPOrderItems");
			logger.debug("Session InventoryPurchaseOrderItems {}", invPOrderItems);
			List<InventoryPurchaseOrderItems> poOrderItemList = (List<InventoryPurchaseOrderItems>) session.getAttribute("invPOrderItemList");
			logger.debug("Session InventoryPurchaseOrderItemList {}", poOrderItemList);
			purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);

			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
			logger.debug("Fetched vendorList :: {}", vendorList);

			if (NumberUtils.toInt(poId) != 0) {
				invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), NumberUtils.toInt(poId));
				for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
					invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
					approveStatus = inventoryPurchaseOrder1.getApproved();
					misCharge = inventoryPurchaseOrder1.getShippingCharge();
				}
				for (InventoryPurchaseOrderItems purchaseOrderItem : invPurchaseOrderItemList) {
					String itmcode = purchaseOrderItem.getInventoryItems().getCode();
					int itemId = purchaseOrderItem.getId();
					if (itmcode.equalsIgnoreCase(itemcode)) {
						inventoryService.deletePoItem(poId, String.valueOf(itemId), customer.getStoreId());
						break;
					}
				}

			} else {
				invPurchaseOrder.setId(0);
				invPurchaseOrder.setCreatedBy(userId);
				invPurchaseOrder.setCreatedDate(date);
				invPurchaseOrderList.add(invPurchaseOrder);
			}

			logger.debug("invPurchaseOrderList :: {}", invPurchaseOrderList);

			//code for remove item....
			for (PurchaseOrderFB orderFB : poOrderFbList) {
				String itmCode = orderFB.getItemCode();
				if (!itmCode.equalsIgnoreCase(itemcode)) {
					grandTotalPrice = grandTotalPrice+orderFB.getTotalPrice();
					purchaseOrderFbList.add(orderFB);
				}
			}

			for (InventoryPurchaseOrderItems orderItems : poOrderItemList) {
				String itmcode = orderItems.getInventoryItems().getCode();
				if (!itmcode.equalsIgnoreCase(itemcode)) {
					invpoItemList.add(orderItems);
				}

			}
//			System.out.println("grandTotalPrice="+grandTotalPrice);
//			System.out.println("grandTotalPrice + miscValue="+(grandTotalPrice+NumberUtils.toDouble(miscValue)));
			grandTotalPrice=grandTotalPrice+NumberUtils.toDouble(miscValue);
			logger.debug("PurchaseOrderFBList.. {}", purchaseOrderFbList);
			purchaseOrderForm.setPurchaseOrderFbList(purchaseOrderFbList);
			logger.debug("purchaseOrderForm.. {}", purchaseOrderForm);

			session.setAttribute("invPOrderItemList", invpoItemList);
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			logger.debug("Inv PurcHASE OrderItem List :: {}", invPurchaseOrderItemList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("vendorList", vendorList);
			mav.addObject("purchaseOrderForm", purchaseOrderForm);
			mav.addObject("podate", date);
			session.setAttribute("purchaseOrderFbList", purchaseOrderFbList);
			session.setAttribute("inventoryItems", inventoryItems);
			model.addAttribute("user", new User());
			session.setAttribute("podate", date);
			session.setAttribute("poStatus", "N");
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("stockStatus", stockStatus);
			session.setAttribute("newRequisition", newRequisition);
			model.addAttribute("inventoryVendor", inventoryVendor);
			session.setAttribute("addItemFlag", addItemFlag);
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalPrice);
			session.setAttribute("misCharge", NumberUtils.toDouble(miscValue));
			session.setAttribute("itemListSize", 0);
			session.setAttribute("searchBoxDisplay", "Y");
			//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);
			return mav;

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/createNewPurchaseOrder",
					method = RequestMethod.POST)
	public ModelAndView createNewPurchaseOrderObj(	@ModelAttribute("purchaseOrderForm") PurchaseOrderForm purchaseOrderForm,
													Model model,
													HttpSession session,
													HttpServletRequest request) {
		logger.debug("In createNewPurchaseOrderObj......");
		Customer customer = null;
		List<PurchaseOrder> purchaseOrderList = new ArrayList<PurchaseOrder>();
		List<InventoryPurchaseOrder> invPurchaseOrderList = new ArrayList<InventoryPurchaseOrder>();
		List<InventoryPurchaseOrderItems> invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryItems> inventoryItemList = new ArrayList<InventoryItems>();
		InventoryItems inventoryItems = new InventoryItems();
		InventoryVendors inventoryVendors = new InventoryVendors();
		InventoryPurchaseOrderItems invPurchaseOrderItems = new InventoryPurchaseOrderItems();
		InventoryPurchaseOrder purchaseOrder = new InventoryPurchaseOrder();
		List<PurchaseOrderFB> inPurchaseOrderFBList = new ArrayList<PurchaseOrderFB>();
		List<InventoryPurchaseOrderItems> finalPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		List<InventoryPurchaseOrderItems> testPoItemList = new ArrayList<InventoryPurchaseOrderItems>();
		boolean flag = false;
		String stockStatus = "N";
		String approveStatus = null;
		String vendorName = null;
		int totalQty = 0;
		String stockNumber = null;
		double grandTotalItemPrice = 0.00;
		double misCharge = 0.00;
		List<String> poFBList = new ArrayList<String>();
		List<String> poItemList = new ArrayList<String>();
		List<String> itemCodeFinalList = new ArrayList<String>();

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
			Date currDate = new Date();
//			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
//			String date = dateFormat.format(currDate);
			String date =Utility.getFormatedDateShort(currDate);
			String dateTime = dateTimeFmt.format(currDate);
			logger.debug("Date ::" + date);
			logger.debug("Time ::" + dateTime);

			String misChargeValue = request.getParameter("misChargeId");
			logger.debug("misChargeValue :{} ", misChargeValue);
			String totalItemValue = request.getParameter("totalId");
			logger.debug("totalItemValue :{} ", totalItemValue);

			ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORY_PAGE);
			session.removeAttribute("invPOrderItemList");

			logger.debug("PurchaseOrderForm obj...{}", purchaseOrderForm);

			int purchaseId = (int) session.getAttribute("purchaseId");
			logger.debug("Purchase Id :" + purchaseId);

			String newDate = (String) session.getAttribute("selectedDate");
			logger.debug("Purchase Date :" + newDate);

			List<PurchaseOrderFB> purchaseOrderFbList = purchaseOrderForm.getPurchaseOrderFbList();
			logger.debug("purchaseOrderFBList obj...{}", purchaseOrderFbList);

			inventoryItemList = inventoryService.getInventoryItems(customer.getStoreId());

			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());

			if (purchaseId != 0) {
				/** update the existing InventoryPurchaseOrder Obj. **/

				invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
				for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
					invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
					misCharge = inventoryPurchaseOrder1.getShippingCharge();
				}

				logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);
				for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {

					String deleteFlag = invpoItem.getDeleteFlag();
					if ("N".equalsIgnoreCase(deleteFlag)) {
						testPoItemList.add(invpoItem);
					}
				}

				for (PurchaseOrderFB purchaseOrderFB : purchaseOrderFbList) {
					double itemQty = purchaseOrderFB.getItemQuantity();
					totalQty += itemQty;
					String code = purchaseOrderFB.getItemCode();
					poFBList.add(code);
				}
				logger.debug("poFBList :: {}", poFBList);
				for (InventoryPurchaseOrderItems inPOItem : testPoItemList) {
					String itmCode = inPOItem.getInventoryItems().getCode();
					poItemList.add(itmCode);
				}
				logger.debug("poItemList :: {}", poItemList);

				Iterator<String> itr = poFBList.iterator();
				while (itr.hasNext()) {
					String code = (String) itr.next();
					if (!poItemList.contains(code)) {
						itemCodeFinalList.add(code);
					}
				}
				logger.debug("itemCodeFinalList :: {}", itemCodeFinalList);

				for (String itmcode : itemCodeFinalList) {
					for (PurchaseOrderFB purchaseOrderFB : purchaseOrderFbList) {
						String code = purchaseOrderFB.getItemCode();
						if (code.equalsIgnoreCase(itmcode)) {
							inPurchaseOrderFBList.add(purchaseOrderFB);
							break;
						}
					}
				}
				logger.debug("inPurchaseOrderFBList fetched list.. {}", inPurchaseOrderFBList);
				invPurchaseOrderItemList = new ArrayList<InventoryPurchaseOrderItems>(); /*Re-Initialisation*/

				for (PurchaseOrderFB porderFB : inPurchaseOrderFBList) {
					double itemQty = porderFB.getItemQuantity();

					for (InventoryItems inventoryItem : inventoryItemList) {
						String itmCode = inventoryItem.getCode();
						if (itmCode.equalsIgnoreCase(porderFB.getItemCode())) {
							logger.debug("Inventory Item Code ::" + itmCode);
							inventoryItems = inventoryItem;
							break;
						}
					}
					logger.debug("Fetched inventoryItems :: {}", inventoryItems);
					InventoryPurchaseOrderItems invPOrderItems = new InventoryPurchaseOrderItems();
					invPOrderItems.setOldStock(porderFB.getOldStock());
					invPOrderItems.setRequiredQuantity(porderFB.getRequiredQuantity());
					invPOrderItems.setItemQuantity(itemQty);
					invPOrderItems.setRate(porderFB.getItemRate());
					invPOrderItems.setShippingCharge(porderFB.getShippingCharge());
					invPOrderItems.setItemTotalPrice(porderFB.getTotalPrice());
					invPOrderItems.setStoreId(customer.getStoreId());
					invPOrderItems.setVendorId(porderFB.getVendorId());
					invPOrderItems.setCreatedBy(customer.getContactNo());
					System.out.println("porderFB.getMetricUnitId()="+porderFB.getMetricUnitId());
					invPOrderItems.setUnitId(porderFB.getMetricUnitId());
					invPOrderItems.setCreatedDate(date);
					invPOrderItems.setInventoryItems(inventoryItems);
					invPurchaseOrderItemList.add(invPOrderItems);
				}
				logger.debug("TotalQty after update po : " + totalQty);
				purchaseOrder.setId(purchaseId);
				purchaseOrder.setTotalQuantity(totalQty);
				purchaseOrder.setShippingCharge(NumberUtils.toDouble(misChargeValue));
				purchaseOrder.setTotalPrice(NumberUtils.toDouble(totalItemValue));
				logger.debug("Inv PurcHASE OrderItem List :: {}", invPurchaseOrderItemList);
				purchaseOrder.setInventoryPurchaseOrderItems(invPurchaseOrderItemList);

				logger.debug("Final Purchase Order :: {}", purchaseOrder);
				inventoryService.updateInventoryPurchaseOrder(purchaseOrder);

				purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), newDate);
				Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
				while (iterator.hasNext()) {
					PurchaseOrder purchaseOrder1 = (PurchaseOrder) iterator.next();
					if (flag == false) {
						invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseId);
						for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
							invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
							approveStatus = inventoryPurchaseOrder1.getApproved();
							misCharge = inventoryPurchaseOrder1.getShippingCharge();
//							grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
						}
						System.out.println("misCharge="+misCharge);
						System.out.println("grandTotalItemPrice+misCharge="+(grandTotalItemPrice+misCharge));
						logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

						for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
							grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
							String deleteFlag = invpoItem.getDeleteFlag();
							if ("N".equalsIgnoreCase(deleteFlag)) {
								finalPoItemList.add(invpoItem);
							}
						}

						/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
							double totalItemPrice = finalPoItem.getItemTotalPrice();
							grandTotalItemPrice += totalItemPrice;
						}*/
					}
					flag = true;
					//grandTotalItemPrice += misCharge;
				}

			} else {
				/** create a new InventoryPurchaseOrder Obj. **/

				for (PurchaseOrderFB porderFB : purchaseOrderFbList) {
					double itemQty = porderFB.getItemQuantity();
					totalQty += itemQty;

					for (InventoryItems inventoryItem : inventoryItemList) {
						String itmCode = inventoryItem.getCode();
						if (itmCode.equalsIgnoreCase(porderFB.getItemCode())) {
							logger.debug("Inventory Item Code ::" + itmCode);
							inventoryItems = inventoryItem;
							break;
						}
					}
					logger.debug("Fetched inventoryItems :: {}", inventoryItems);
					InventoryPurchaseOrderItems invPOrderItems = new InventoryPurchaseOrderItems();
					invPOrderItems.setOldStock(porderFB.getOldStock());
					invPOrderItems.setRequiredQuantity(porderFB.getRequiredQuantity());
					invPOrderItems.setItemQuantity(itemQty);
					invPOrderItems.setRate(porderFB.getItemRate());
					invPOrderItems.setShippingCharge(porderFB.getShippingCharge());
					invPOrderItems.setItemTotalPrice(porderFB.getTotalPrice());
					invPOrderItems.setStoreId(customer.getStoreId());
					invPOrderItems.setVendorId(porderFB.getVendorId());
					invPOrderItems.setCreatedBy(customer.getContactNo());
					invPOrderItems.setCreatedDate(date);
					System.out.println("porderFB.getMetricUnitId()="+porderFB.getMetricUnitId());
					invPOrderItems.setUnitId(porderFB.getMetricUnitId());
					invPOrderItems.setInventoryItems(inventoryItems);
					invPurchaseOrderItemList.add(invPOrderItems);
				}

				purchaseOrder.setDate(Utility.getFormatedDateShort(currDate));
				purchaseOrder.setTime(dateTime);
				purchaseOrder.setUserId(customer.getContactNo());
				purchaseOrder.setShippingCharge(NumberUtils.toDouble(misChargeValue));
				purchaseOrder.setTotalPrice(NumberUtils.toDouble(totalItemValue));
				purchaseOrder.setTotalQuantity(totalQty);
				purchaseOrder.setStoreId(customer.getStoreId());
				purchaseOrder.setCreatedBy(customer.getContactNo());
				purchaseOrder.setCreatedDate(date);

				logger.debug("Inv PurcHASE OrderItem List :: {}", invPurchaseOrderItemList);
				purchaseOrder.setInventoryPurchaseOrderItems(invPurchaseOrderItemList);

				logger.debug("Final Purchase Order :: {}", purchaseOrder);
				inventoryService.createInventoryPurchaseOrder(purchaseOrder);

				purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
				Iterator<PurchaseOrder> iterator = purchaseOrderList.iterator();
				while (iterator.hasNext()) {
					PurchaseOrder purchaseOrder1 = (PurchaseOrder) iterator.next();
					if (flag == false) {
						invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseOrder1.getId());
						for (InventoryPurchaseOrder inventoryPurchaseOrder1 : invPurchaseOrderList) {
							invPurchaseOrderItemList = inventoryPurchaseOrder1.getInventoryPurchaseOrderItems();
							approveStatus = inventoryPurchaseOrder1.getApproved();
							misCharge = inventoryPurchaseOrder1.getShippingCharge();
//							grandTotalItemPrice = inventoryPurchaseOrder1.getTotalPrice();
//							grandTotalItemPrice =grandTotalItemPrice+ inventoryPurchaseOrder1.getTotalPrice();
						}
						System.out.println("grandTotalItemPrice+misCharge="+(grandTotalItemPrice+misCharge));
						logger.debug("invPurchaseOrderItemList :: {}", invPurchaseOrderItemList);

						for (InventoryPurchaseOrderItems invpoItem : invPurchaseOrderItemList) {
							grandTotalItemPrice = grandTotalItemPrice+invpoItem.getItemTotalPrice();
							String deleteFlag = invpoItem.getDeleteFlag();
							if ("N".equalsIgnoreCase(deleteFlag)) {
								finalPoItemList.add(invpoItem);
							}
						}

						/*for (InventoryPurchaseOrderItems finalPoItem : finalPoItemList) {
							double totalItemPrice = finalPoItem.getItemTotalPrice();
							grandTotalItemPrice += totalItemPrice;
						}*/
					}
					flag = true;
					//grandTotalItemPrice += misCharge;
				}
			}
			grandTotalItemPrice = grandTotalItemPrice+misCharge;
			List<MetricUnit> metricUnitList=inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject("purchaseOrderList", purchaseOrderList);
			mav.addObject("invPurchaseOrderList", invPurchaseOrderList);
			//mav.addObject("invPurchaseOrderItemList", invPurchaseOrderItemList);
			mav.addObject("invPurchaseOrderItemList", finalPoItemList);
			mav.addObject("vendorList", vendorList);
			model.addAttribute("user", new User());
			session.setAttribute("loginId", customer.getContactNo());
			session.setAttribute("poStatus", "N");
			session.setAttribute("newRequisition", "N");
			session.setAttribute("stockStatus", "N");
			session.setAttribute("approveStatus", approveStatus);
			session.setAttribute("addItemFlag", "N");
			session.setAttribute("purchaseId", purchaseId);
			session.setAttribute("selectedDate", newDate);
			session.setAttribute("grandTotalItemPrice", grandTotalItemPrice);
			session.setAttribute("misCharge", misCharge);
			session.setAttribute("searchBoxDisplay", "Y");
			//mav.setViewName(ForwardConstants.VIEW_INVENTORY_PAGE);
			return mav;

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	@RequestMapping(value = "/poOrderPrint/{poId}",
					method = RequestMethod.GET)
	public ModelAndView poOrderPrint(	@PathVariable("poId") String poId,
										Model model,
										HttpSession session,
										HttpServletRequest request,
										HttpServletResponse response) {
		logger.debug("In poOrderPrint......");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		try {
			String wsResponse = inventoryService.poOrderPrint(customer.getStoreId(), poId);
			logger.debug("Response : " + wsResponse);

			PrintWriter out;
			out = response.getWriter();
			response.setContentType("text/plain");
			out.print(new Gson().toJson(wsResponse));
			out.flush();
			return null;
		} catch (IOException e) {
			logger.error("IOException", e);
			return null;
		}

	}
}
