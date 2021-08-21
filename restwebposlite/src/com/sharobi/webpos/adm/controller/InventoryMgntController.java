/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.InvType;
import com.sharobi.webpos.adm.model.InventoryItem;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.model.Vendor;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.adm.service.VendorMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.rm.model.FgStockInItemsChild;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/inventorymgnt")
public class InventoryMgntController {

	private final static Logger logger = LogManager.getLogger(InventoryMgntController.class);
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();
	private final static VendorMgntService vendormgntService = new VendorMgntService();

	@RequestMapping(value = "/loadinvtypemgnt", method = RequestMethod.GET)
	public ModelAndView loadInvTypeMgnt(HttpSession session) {
		logger.debug("in loadinvtypemgnt...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InvType> invtypeList = inventorymgntService.getInvTypeList(customer.getStoreId());
		mav.addObject("invtypeList", invtypeList);
		mav.addObject(Constants.ADMIN, "Y");
		mav.setViewName(ForwardConstants.VIEW_INVTYPE_MGNT_PAGE);
		return mav;
	}

	/*
	 * @RequestMapping(value = "/addinvtype/{invtypeName}/{invtypeDesc}", method
	 * = RequestMethod.GET) public void
	 * addMenuCategory(@PathVariable("invtypeName") String invtypeName,
	 * 
	 * @PathVariable("invtypeDesc") String invtypeDesc, HttpSession session,
	 * HttpServletResponse response) throws IOException {
	 * logger.debug("In addinvtype......{},{}", invtypeName, invtypeDesc);
	 * //ModelAndView mav = new ModelAndView(); Customer customer = null; if
	 * ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER))
	 * != null) { PrintWriter out = response.getWriter();
	 * response.setContentType("text/plain"); InvType invType = new InvType();
	 * invType.setName(invtypeName); invType.setDescription(invtypeDesc);
	 * invType.setStoreId(customer.getStoreId());
	 * invType.setCreatedBy(customer.getName());
	 * invType.setCreatedDate(getTodayDate()); String res =
	 * inventorymgntService.addInvType(invType); System.out.println("res:" +
	 * res); out.print(res); out.flush(); } }
	 */
	@RequestMapping(value = "/addinvtype", method = RequestMethod.POST)
	public void addMenuCategory(@RequestBody String invTypeadd, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In addinvtype......{}", invTypeadd);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			InvType invType = gson.fromJson(invTypeadd, new TypeToken<InvType>() {
			}.getType());
			invType.setCreatedDate(getTodayDate());
			String res = inventorymgntService.addInvType(invType);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}
	/*
	 * @RequestMapping(value = "/editinvtype/{id}/{invtypeName}/{invtypeDesc}",
	 * method = RequestMethod.GET) public void
	 * addMenuCategory(@PathVariable("id") String id,
	 * 
	 * @PathVariable("invtypeName") String invtypeName,
	 * 
	 * @PathVariable("invtypeDesc") String invtypeDesc, HttpSession session,
	 * HttpServletResponse response) throws IOException {
	 * logger.debug("In addinvtype......{},{},{}", id, invtypeName,
	 * invtypeDesc); //ModelAndView mav = new ModelAndView(); Customer customer
	 * = null; if ((customer = (Customer)
	 * session.getAttribute(Constants.LOGGED_IN_USER)) != null) { PrintWriter
	 * out = response.getWriter(); response.setContentType("text/plain");
	 * InvType invType = new InvType(); invType.setId(NumberUtils.toInt(id));
	 * invType.setName(invtypeName); invType.setDescription(invtypeDesc);
	 * invType.setStoreId(customer.getStoreId());
	 * invType.setCreatedBy(customer.getName());
	 * invType.setCreatedDate(getTodayDate());
	 * invType.setUpdatedBy(customer.getName());
	 * invType.setUpdatedDate(getTodayDate()); invType.setDeleteFlag("N");
	 * String res = inventorymgntService.editInvType(invType);
	 * System.out.println("res:" + res); out.print(res); out.flush(); } }
	 */

	@RequestMapping(value = "/editinvtype", method = RequestMethod.POST)
	public void editInvType(@RequestBody String invtypeedit, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In editinvtype......{}", invtypeedit);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			InvType invType = gson.fromJson(invtypeedit, new TypeToken<InvType>() {
			}.getType());
			/*
			 * InvType invType = new InvType();
			 * invType.setId(NumberUtils.toInt(id));
			 * invType.setName(invtypeName);
			 * invType.setDescription(invtypeDesc);
			 */
			// invType.setStoreId(customer.getStoreId());
			// invType.setCreatedBy(customer.getName());
			invType.setCreatedDate(getTodayDate());
			invType.setUpdatedBy(customer.getName());
			invType.setUpdatedDate(getTodayDate());
			invType.setDeleteFlag("N");
			String res = inventorymgntService.editInvType(invType);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/deleteinvtype/{id}", method = RequestMethod.GET)
	public void deleteVendor(@PathVariable("id") String id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In deleteinvtype......{}", id);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = inventorymgntService.deleteInvType(NumberUtils.toInt(id), customer.getStoreId());
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/loadinvitemmgnt", method = RequestMethod.GET)
	public ModelAndView loadInvItemMgnt(HttpSession session) {
		logger.debug("in loadinvitemmgnt...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryItem> invitemList = inventorymgntService.getInvItemList(customer.getStoreId());
		List<InvType> invtypeList = inventorymgntService.getInvTypeList(customer.getStoreId());
		List<Vendor> vendorList = vendormgntService.getVendorList(customer.getStoreId());
		List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
		session.setAttribute("sesinvitemList", invitemList);
		session.setAttribute("sesinvtypeList", invtypeList);
		session.setAttribute("sesvendorList", vendorList);
		session.setAttribute("sesmetricUnitList", metricUnitList);
		mav.addObject("invitemList", invitemList);
		mav.addObject("invTYPEList", invtypeList);
		mav.addObject("invVENDORList", vendorList);
		mav.addObject("metricUnitList", metricUnitList);
		mav.addObject(Constants.ADMIN, "Y");

		mav.setViewName(ForwardConstants.VIEW_INVITEM_MGNT_PAGE);
		return mav;
	}

	@RequestMapping(value = "/loadsimpleinvitemmgnt", method = RequestMethod.GET)
	public ModelAndView loadSimpleInvItemMgnt(HttpSession session) {
		logger.debug("in loadinvitemmgnt...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryItem> invitemList = inventorymgntService.getInvItemList(customer.getStoreId());
		List<InvType> invtypeList = inventorymgntService.getInvTypeList(customer.getStoreId());
		List<Vendor> vendorList = vendormgntService.getVendorList(customer.getStoreId());
		List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
		session.setAttribute("sesinvitemList", invitemList);
		session.setAttribute("sesinvtypeList", invtypeList);
		session.setAttribute("sesvendorList", vendorList);
		session.setAttribute("sesmetricUnitList", metricUnitList);
		mav.addObject("invitemList", invitemList);
		mav.addObject("invTYPEList", invtypeList);
		mav.addObject("invVENDORList", vendorList);
		mav.addObject("metricUnitList", metricUnitList);
		mav.addObject(Constants.ADMIN, "Y");

		mav.setViewName(ForwardConstants.VIEW_SIMPLE_INVITEM_MGNT_PAGE);
		return mav;
	}

	/*
	 * @RequestMapping(value =
	 * "/addinvitem/{name}/{code}/{itemtype}/{qty}/{rate}/{unit}/{vendorid}/{shipping}/{dailyreq}/{tax}",
	 * method = RequestMethod.GET) public void addInvItem( @PathVariable("name")
	 * String name,
	 * 
	 * @PathVariable("code") String code,
	 * 
	 * @PathVariable("itemtype") String itemtype,
	 * 
	 * @PathVariable("qty") String qty,
	 * 
	 * @PathVariable("rate") String rate,
	 * 
	 * @PathVariable("unit") String unit,
	 * 
	 * @PathVariable("vendorid") String vendorid,
	 * 
	 * @PathVariable("shipping") String shipping,
	 * 
	 * @PathVariable("dailyreq") String dailyreq,
	 * 
	 * @PathVariable("tax") String tax, HttpSession session, HttpServletResponse
	 * response) throws IOException {
	 * logger.debug("In addinvitem......{},{},{},{},{},{},{},{},{}", name, code,
	 * itemtype, qty, rate, unit, vendorid, shipping, dailyreq); //ModelAndView
	 * mav = new ModelAndView(); Customer customer = null; if ((customer =
	 * (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	 * PrintWriter out = response.getWriter();
	 * response.setContentType("text/plain"); InvType invType = new InvType();
	 * invType.setId(NumberUtils.toInt(itemtype)); InventoryItem inventoryItem =
	 * new InventoryItem(); inventoryItem.setName(name);
	 * inventoryItem.setCode(code); inventoryItem.setInventoryType(invType);
	 * inventoryItem.setQuantity(NumberUtils.toDouble(qty));
	 * inventoryItem.setRate(NumberUtils.toDouble(rate)); String unitname = "";
	 * MetricUnit metricUnit =
	 * inventorymgntService.getInvItemUnitDetails(Integer.valueOf(unit));
	 * unitname = metricUnit.getUnit(); System.out.println("unitname=" +
	 * unitname); inventoryItem.setUnit(unitname);
	 * inventoryItem.setMetricUnitId(Integer.valueOf(unit));
	 * inventoryItem.setVendorId(NumberUtils.toInt(vendorid));
	 * inventoryItem.setShippingCharge(NumberUtils.toDouble(shipping));
	 * inventoryItem.setDailyRequirement(NumberUtils.toDouble(dailyreq));
	 * inventoryItem.setTax(tax);
	 * inventoryItem.setStoreId(customer.getStoreId());
	 * inventoryItem.setCreatedBy(customer.getName());
	 * inventoryItem.setCreatedDate(getTodayDate()); String res =
	 * inventorymgntService.addInvItem(inventoryItem); System.out.println("res:"
	 * + res); out.print(res); out.flush(); } }
	 */
	@RequestMapping(value = "/addinvitem", method = RequestMethod.POST)
	public void addInvItem(@RequestBody String invItemAddPost, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In addinvitem......{}", invItemAddPost);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			InventoryItem inventoryItem = gson.fromJson(invItemAddPost, new TypeToken<InventoryItem>() {
			}.getType());

			inventoryItem.setStoreId(customer.getStoreId());
			inventoryItem.setCreatedBy(customer.getName());
			inventoryItem.setCreatedDate(getTodayDate());
			String res = inventorymgntService.addInvItem(inventoryItem);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	/*
	 * @RequestMapping(value =
	 * "/editinvitem/{id}/{name}/{code}/{itemtype}/{qty}/{rate}/{unit}/{vendorid}/{shipping}/{dailyreq}/{tax}",
	 * method = RequestMethod.GET) public void editInvItem(@PathVariable("id")
	 * String id,
	 * 
	 * @PathVariable("name") String name,
	 * 
	 * @PathVariable("code") String code,
	 * 
	 * @PathVariable("itemtype") String itemtype,
	 * 
	 * @PathVariable("qty") String qty,
	 * 
	 * @PathVariable("rate") String rate,
	 * 
	 * @PathVariable("unit") String unit,
	 * 
	 * @PathVariable("vendorid") String vendorid,
	 * 
	 * @PathVariable("shipping") String shipping,
	 * 
	 * @PathVariable("dailyreq") String dailyreq,
	 * 
	 * @PathVariable("tax") String tax, HttpSession session, HttpServletResponse
	 * response) throws IOException {
	 * logger.debug("In editinvitem......{},{},{},{},{},{},{},{},{},{}", id,
	 * name, code, itemtype, qty, rate, unit, vendorid, shipping, dailyreq);
	 * //ModelAndView mav = new ModelAndView(); Customer customer = null; if
	 * ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER))
	 * != null) { PrintWriter out = response.getWriter();
	 * response.setContentType("text/plain"); InvType invType = new InvType();
	 * invType.setId(NumberUtils.toInt(itemtype)); InventoryItem inventoryItem =
	 * new InventoryItem(); inventoryItem.setId(NumberUtils.toInt(id));
	 * inventoryItem.setName(name); inventoryItem.setCode(code);
	 * inventoryItem.setInventoryType(invType);
	 * inventoryItem.setQuantity(NumberUtils.toDouble(qty));
	 * inventoryItem.setRate(NumberUtils.toDouble(rate)); String unitname = "";
	 * MetricUnit metricUnit =
	 * inventorymgntService.getInvItemUnitDetails(Integer.valueOf(unit));
	 * unitname = metricUnit.getUnit(); System.out.println("unitname=" +
	 * unitname); inventoryItem.setUnit(unitname);
	 * inventoryItem.setMetricUnitId(Integer.valueOf(unit));
	 * inventoryItem.setVendorId(NumberUtils.toInt(vendorid));
	 * inventoryItem.setShippingCharge(NumberUtils.toDouble(shipping));
	 * inventoryItem.setDailyRequirement(NumberUtils.toDouble(dailyreq));
	 * inventoryItem.setStoreId(customer.getStoreId());
	 * inventoryItem.setTax(tax);
	 * inventoryItem.setCreatedBy(customer.getName());
	 * inventoryItem.setCreatedDate(getTodayDate());
	 * inventoryItem.setUpdatedBy(customer.getName());
	 * inventoryItem.setUpdatedDate(getTodayDate());
	 * inventoryItem.setDeleteFlag("N"); String res =
	 * inventorymgntService.editInvItem(inventoryItem);
	 * System.out.println("res:" + res); out.print(res); out.flush(); } }
	 */

	@RequestMapping(value = "/editinvitem", method = RequestMethod.POST)
	public void editInvItem(@RequestBody String invItemEditPost, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In editinvitem......{}", invItemEditPost);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			InventoryItem inventoryItem = gson.fromJson(invItemEditPost, new TypeToken<InventoryItem>() {
			}.getType());
			/*
			 * InvType invType = new InvType();
			 * invType.setId(NumberUtils.toInt(itemtype)); InventoryItem
			 * inventoryItem = new InventoryItem();
			 * inventoryItem.setId(NumberUtils.toInt(id));
			 * inventoryItem.setName(name); inventoryItem.setCode(code);
			 * inventoryItem.setInventoryType(invType);
			 * inventoryItem.setQuantity(NumberUtils.toDouble(qty));
			 * inventoryItem.setRate(NumberUtils.toDouble(rate)); String
			 * unitname = ""; MetricUnit metricUnit =
			 * inventorymgntService.getInvItemUnitDetails(Integer.valueOf(unit))
			 * ; unitname = metricUnit.getUnit(); System.out.println("unitname="
			 * + unitname); inventoryItem.setUnit(unitname);
			 * inventoryItem.setMetricUnitId(Integer.valueOf(unit));
			 * inventoryItem.setVendorId(NumberUtils.toInt(vendorid));
			 * inventoryItem.setShippingCharge(NumberUtils.toDouble(shipping));
			 * inventoryItem.setDailyRequirement(NumberUtils.toDouble(dailyreq))
			 * ;
			 */
			inventoryItem.setStoreId(customer.getStoreId());
			// inventoryItem.setTax(tax);
			inventoryItem.setCreatedBy(customer.getName());
			inventoryItem.setCreatedDate(getTodayDate());
			inventoryItem.setUpdatedBy(customer.getName());
			inventoryItem.setUpdatedDate(getTodayDate());
			inventoryItem.setDeleteFlag("N");
			String res = inventorymgntService.editInvItem(inventoryItem);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/deleteinvitem/{id}", method = RequestMethod.GET)
	public void deleteInvItem(@PathVariable("id") String id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In deleteinvitem......{}", id);
		// ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = inventorymgntService.deleteInvItem(NumberUtils.toInt(id), customer.getStoreId());
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/autocomplete", method = RequestMethod.GET)
	public List<InventoryItem> getAutocompleteList(@RequestParam String tagName, HttpSession session,
			HttpServletResponse response) throws IOException {
		List<InventoryItem> inventoryItemList = (List<InventoryItem>) session.getAttribute("sesinvitemList");
		List<InventoryItem> newinventoryItemList = new ArrayList<InventoryItem>();
		for (InventoryItem invitems : inventoryItemList) {
			if (StringUtils.startsWithIgnoreCase(invitems.getName(), tagName)) {
				newinventoryItemList.add(invitems);
			}
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newinventoryItemList));
		return null;
	}

	@RequestMapping(value = "/loadinvitemsbyid", method = RequestMethod.GET)
	public ModelAndView loadInvItemsById(@RequestParam int invitemid, HttpSession session) {
		logger.debug("in loadinvitemsbyid...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryItem> inventoryItemList = (List<InventoryItem>) session.getAttribute("sesinvitemList");
		List<InventoryItem> newinventoryItemList = new ArrayList<InventoryItem>();
		for (InventoryItem invitems : inventoryItemList) {
			if (invitems.getId() == invitemid) {
				newinventoryItemList.add(invitems);
			}
		}
		mav.addObject("invitemList", newinventoryItemList);
		mav.addObject("invTYPEList", (List<InvType>) session.getAttribute("sesinvtypeList"));
		mav.addObject("invVENDORList", (List<Vendor>) session.getAttribute("sesvendorList"));
		mav.addObject("metricUnitList", (List<MetricUnit>) session.getAttribute("sesmetricUnitList"));
		mav.addObject(Constants.ADMIN, "Y");

		mav.setViewName(ForwardConstants.VIEW_INVITEM_MGNT_PAGE);
		return mav;
	}

	@RequestMapping(value = "/loadsimpleinvitemsbyid", method = RequestMethod.GET)
	public ModelAndView loadSimpleInvItemsById(@RequestParam int invitemid, HttpSession session) {
		logger.debug("in loadinvitemsbyid...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryItem> inventoryItemList = (List<InventoryItem>) session.getAttribute("sesinvitemList");
		List<InventoryItem> newinventoryItemList = new ArrayList<InventoryItem>();
		for (InventoryItem invitems : inventoryItemList) {
			if (invitems.getId() == invitemid) {
				newinventoryItemList.add(invitems);
			}
		}
		mav.addObject("invitemList", newinventoryItemList);
		mav.addObject("invTYPEList", (List<InvType>) session.getAttribute("sesinvtypeList"));
		mav.addObject("invVENDORList", (List<Vendor>) session.getAttribute("sesvendorList"));
		mav.addObject("metricUnitList", (List<MetricUnit>) session.getAttribute("sesmetricUnitList"));
		mav.addObject(Constants.ADMIN, "Y");
		mav.setViewName(ForwardConstants.VIEW_SIMPLE_INVITEM_MGNT_PAGE);
		return mav;
	}

	public String getTodayDate() {
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		// java.util.Calendar cal=java.util.Calendar.getInstance();
		System.out.println("date:" + df.format(date));
		return df.format(date);
	}

	@RequestMapping(value = "/getFgStockInItemsByItemId", method = RequestMethod.GET)
	@ResponseBody
	public String getFgStockInItemsByItemId(@RequestHeader("storeid") String storeid,@RequestHeader("itemId") String itemId,HttpSession session) {
		logger.debug("in getFgStockInItemsByItemId In InventoryMgntController.java Class IS...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String response=null;
		//List<FgStockInItemsChild>list=null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		   
			response=inventorymgntService.getFgStockInItemsByItemId(Integer.parseInt(storeid), Integer.parseInt(itemId));
			
		}
		
		return response;
	}
}
