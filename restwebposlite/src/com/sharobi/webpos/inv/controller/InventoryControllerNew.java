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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.BillSplitManual;
import com.sharobi.webpos.base.model.BillSplitManual_duplicate;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InvItem;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.model.PurchaseOrder;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/inventorynew")
public class InventoryControllerNew {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = LogManager.getLogger(InventoryControllerNew.class);
	private final static InventoryService inventoryService = new InventoryService();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	@RequestMapping(value = "/loadinventory",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) throws ParseException {
		logger.debug("In Inventory......");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Date currdate = new Date();
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORYNEW_PAGE);
		List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), Utility.getFormatedDateShort(currdate));
		logger.debug("purchaseOrderList : {}", purchaseOrderList);
		String date = dateFormat.format(currdate);
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject("purchaseOrderList", purchaseOrderList);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		mav.addObject("vendorList", vendorList);
		return mav;
	}

	@RequestMapping(value = "/inventoryitems",
					method = RequestMethod.GET)
	public ModelAndView getInventoryItems(	@RequestParam("tagName") String tagName,
											Model model,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) throws IOException {
		logger.debug("In getInventoryItems new Details......{}", tagName);
		Customer customer = null;
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
			if (StringUtils.startsWithIgnoreCase(inventoryItems.getName(), tagName)) {
				resultList.add(new InvItem(inventoryItems.getId(), inventoryItems.getCode(), inventoryItems.getName()));
			}
		}
		logger.debug("Item Result list:: {}", resultList);
		if (resultList.size() > 0) {
			itemExistStatus = "Y";
		}
		out.print(new Gson().toJson(resultList).toString());
		return null;
	}

	@RequestMapping(value = "/getinventoryitemdetails/{itemCode}",
					method = RequestMethod.GET)
	public ModelAndView getInventoryItemDetails(@PathVariable("itemCode") String itemCode,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws IOException {
		logger.debug("In getInventoryItemDetails new Details......{}", itemCode);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		InventoryItems inventoryItems = inventoryService.getInventoryItemDetails(customer.getStoreId(), itemCode.trim());
		logger.debug("inventoryItems : {}", inventoryItems);
		String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryItems.getId());
		inventoryItems.setStockAvailable(stockAvailable);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(inventoryItems).toString());
		return null;
	}

	@RequestMapping(value = "/createnewpurchaseorder",
					method = RequestMethod.POST)
	public void createNewPurchaseOrder(	@RequestBody String invPOOrder,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("in createnewpurchaseorder...{}", invPOOrder);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryPurchaseOrder purchaseOrder = gson.fromJson(invPOOrder, new TypeToken<InventoryPurchaseOrder>() {}.getType());
			/*for (InventoryPurchaseOrderItems invPurchaseOrderItems : purchaseOrder.getInventoryPurchaseOrderItems()) {
				invPurchaseOrderItems.setStoreId(customer.getStoreId());
				invPurchaseOrderItems.setCreatedBy(customer.getContactNo());
			}*/
			purchaseOrder.setDate(Utility.getFormatedDateShort(currDate));
			purchaseOrder.setUserId(customer.getContactNo());
			purchaseOrder.setTime(Utility.getFormatedDateShort(currDate));
			purchaseOrder.setStoreId(customer.getStoreId());
			
			if (purchaseOrder.getId() == 0) {
				for (InventoryPurchaseOrderItems invPurchaseOrderItems : purchaseOrder.getInventoryPurchaseOrderItems()) {
					invPurchaseOrderItems.setStoreId(customer.getStoreId());
					invPurchaseOrderItems.setCreatedBy(customer.getContactNo());
				}
				purchaseOrder.setCreatedBy(customer.getContactNo());
				inventoryService.createInventoryPurchaseOrder(purchaseOrder);
			} else {
				List<InventoryPurchaseOrder> invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), purchaseOrder.getId());
				  
				   for(InventoryPurchaseOrder ob:invPurchaseOrderList){
					   purchaseOrder.setCreatedBy(ob.getCreatedBy());
					   purchaseOrder.setCreatedDate(ob.getCreatedDate());
				   }
				       purchaseOrder.setUpdatedBy(customer.getContactNo());
				
				List<InventoryPurchaseOrderItems> updatablepurchaseorderitem =purchaseOrder.getInventoryPurchaseOrderItems();
				      
				for(InventoryPurchaseOrder ob1:invPurchaseOrderList){
				    	  for(InventoryPurchaseOrderItems poitemob:updatablepurchaseorderitem){
				    		   poitemob.setCreatedBy(ob1.getCreatedBy());
				    		   poitemob.setCreatedDate(ob1.getCreatedDate());
				    		   poitemob.setUpdatedBy(customer.getContactNo());
				    	   }
				    	 }
				    inventoryService.updateInventoryPurchaseOrder(purchaseOrder);
			}
			out.print("success");
			out.flush();
		}

	}

	@RequestMapping(value = "/getpodetailsbyidanddate/{poId}/{date}",
					method = RequestMethod.GET)
	public ModelAndView getInventoryItemDetails(@PathVariable("poId") String poId,
												@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws IOException {
		logger.debug("In getpodetailsbyidanddate  Details......{},{}", poId, date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryPurchaseOrder> invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(), NumberUtils.toInt(poId));
		for (InventoryPurchaseOrder inventoryPurchaseOrder : invPurchaseOrderList) {
			for (InventoryPurchaseOrderItems inventoryPurchaseOrderItems : inventoryPurchaseOrder.getInventoryPurchaseOrderItems()) {
				MetricUnit metricUnit = inventorymgntService.getInvItemUnitDetails(inventoryPurchaseOrderItems.getUnitId());
				inventoryPurchaseOrderItems.setUnitName(metricUnit.getUnit());
			}
		}
		logger.debug("invPurchaseOrderItemList in controller :: {}", invPurchaseOrderList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(invPurchaseOrderList).toString());
		return null;
	}

	@RequestMapping(value = "/poitemdelete/{poId}/{poorderitemid}",
					method = RequestMethod.GET)
	public ModelAndView poItemDelete(	@PathVariable("poId") String poId,
										@PathVariable("poorderitemid") String poorderitemid,
										Model model,
										HttpSession session,
										HttpServletRequest request,
										HttpServletResponse response) throws IOException {
		logger.debug("In poItemDelete  Details......{},{}", poId, poorderitemid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		inventoryService.deletePoItem(poId, String.valueOf(poorderitemid), customer.getStoreId());
		return null;
	}

	@RequestMapping(value = "/updatepoitem",
					method = RequestMethod.POST)
	public void updatePOItem(	@RequestBody String invPOOrderItems,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in updatepoitem...{}", invPOOrderItems);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryPurchaseOrderItems inventoryPurchaseOrderItems = gson.fromJson(invPOOrderItems, new TypeToken<InventoryPurchaseOrderItems>() {}.getType());
			inventoryPurchaseOrderItems.setStoreId(customer.getStoreId());
			inventoryPurchaseOrderItems.setCreatedBy(customer.getName());
			inventoryPurchaseOrderItems.setDeleteFlag("N");
			inventoryService.updatePoEachItem(inventoryPurchaseOrderItems);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/viewPOByDate",
					method = RequestMethod.GET)
	public ModelAndView viewInventoryByDate(@RequestParam String selectedDate,
											Model model,
											HttpSession session,
											HttpServletRequest request) throws ParseException {
		logger.debug("In viewPOByDate......{}", selectedDate);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_INVENTORYNEW_PAGE);
		List<PurchaseOrder> purchaseOrderList = inventoryService.getPurchaseOrderByDate(customer.getStoreId(), selectedDate);
		logger.debug("purchaseOrderList : {}", purchaseOrderList);
		mav.addObject("purchaseOrderList", purchaseOrderList);
		Date today = dateFormat.parse(selectedDate);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		mav.addObject("today", today);
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		mav.addObject("vendorList", vendorList);

		return mav;
	}

	@RequestMapping(value = "/approvedPO",
					method = RequestMethod.GET)
	public ModelAndView approvedPO(	@RequestParam String poId,
									@RequestParam String updatedBy,
									@RequestParam String updatedDate,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws IOException {
		logger.debug("In viewPOByDate......{},{},{}", poId, updatedBy, updatedDate);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		inventoryService.approvedPO(poId, updatedBy, updatedBy, updatedDate);
		out.print("success");
		out.flush();
		return null;
	}

	@RequestMapping(value = "/updatedPO",
					method = RequestMethod.GET)
	public ModelAndView updatedPO(	@RequestParam String poId,
									@RequestParam String poBy,
									@RequestParam String updatedDate,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws IOException {
		logger.debug("In updatedPO......{},{},{}", poId, poBy, updatedDate);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		inventoryService.updatedPO(poId, poBy, poBy, updatedDate);
		out.print("success");
		out.flush();
		return null;
	}

	@RequestMapping(value = "/poOrderPrint/{poId}",
					method = RequestMethod.GET)
	public ModelAndView poOrderPrint(	@PathVariable("poId") String poId,
										Model model,
										HttpSession session,
										HttpServletRequest request,
										HttpServletResponse response) {
		logger.debug("In poOrderPrint......{}",poId);
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
			return null;
		}

	}
	
	@RequestMapping(value = "/deleterequisition/{poId}",
			method = RequestMethod.GET)
public ModelAndView deleteRequisition(	@PathVariable("poId") String poId,
								Model model,
								HttpSession session,
								HttpServletRequest request,
								HttpServletResponse response) {
logger.debug("In deleteRequisition......{}",poId);
Customer customer = null;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	return mav;
}
try {
	String wsResponse = inventoryService.deleteRequisition(poId,customer.getStoreId());
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

	@RequestMapping(value = "/getpodetailsbypoid/{poid}",
			method = RequestMethod.GET)
public ModelAndView getPoDetailsByPoId(	@PathVariable("poid") String poid,
								Model model,
								HttpSession session,
								HttpServletRequest request,
								HttpServletResponse response) {
logger.debug("In getPoDetailsByPoId......{}",poid);
Customer customer = null;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	return mav;
}
try {
	List<InventoryPurchaseOrder> invPurchaseOrderList = inventoryService.getPurchaseOrderById(customer.getStoreId(),Integer.parseInt(poid));
	logger.debug("Response : " + invPurchaseOrderList);
	PrintWriter out;
	out = response.getWriter();
	response.setContentType("text/plain");
	out.print(new Gson().toJson(invPurchaseOrderList).toString());
	out.flush();
	return null;
} catch (IOException e) {
	return null;
}

}		
	
	
}
