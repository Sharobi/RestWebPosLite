/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.adm.service.StoreCustomerMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/storecustomermgnt")
public class StoreCustomerMgntController {
	private final static Logger logger=LogManager.getLogger(StoreCustomerMgntController.class);
	private final static StoreCustomerMgntService storecustomermgntService=new StoreCustomerMgntService();
	
	@RequestMapping(value="/loadstorecustomermgnt",method=RequestMethod.GET)
	public ModelAndView loadStoreCustomer(HttpSession session)
	{
		logger.debug("in loadstorecustomermgnt...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<StoreCustomer> storeCustList=storecustomermgntService.getStoreCustomerList(customer.getStoreId());
		mav.addObject("storecustList",storeCustList);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_STORECUST_MGNT_PAGE);
		return mav;
	}
	/*@RequestMapping(value="/addstorecustomer/{custName}/{custContact}/{custAddress}/{custEmail}/{custcrLimit}",method=RequestMethod.GET)
	public void addStoreCustomer(@PathVariable("custName") String custName,@PathVariable("custContact") String custContact,@PathVariable("custAddress") String custAddress,@PathVariable("custEmail") String custEmail,@PathVariable("custcrLimit") int custcrLimit,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addstorecustomer......{},{},{},{},{}",custName,custContact,custAddress,custEmail,custcrLimit);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			StoreCustomer storeCustomer=new StoreCustomer();
			storeCustomer.setName(custName);
			storeCustomer.setContactNo(custContact);
			storeCustomer.setAddress(custAddress);
			storeCustomer.setEmailId(custEmail);
			storeCustomer.setCreditLimit(custcrLimit);
			storeCustomer.setStoreId(customer.getStoreId());
			storeCustomer.setCreditCustomer("N");
			String res=storecustomermgntService.addStoreCustomer(storeCustomer);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	
	
	
	/*@RequestMapping(value="/editstorecustomer/{custId}/{custName}/{custContact}/{custAddress}/{custEmail}/{custcrLimit}/{crFlag}",method=RequestMethod.GET)
	public void editStoreCustomer(@PathVariable("custId") int custId,@PathVariable("custName") String custName,@PathVariable("custContact") String custContact,@PathVariable("custAddress") String custAddress,@PathVariable("custEmail") String custEmail,@PathVariable("custcrLimit") int custcrLimit,@PathVariable("crFlag") String crFlag,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editstorecustomer......{},{},{},{},{},{},{}",custId,custName,custContact,custAddress,custEmail,custcrLimit,crFlag);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			StoreCustomer storeCustomer=new StoreCustomer();
			storeCustomer.setId(custId);
			storeCustomer.setName(custName);
			storeCustomer.setContactNo(custContact);
			storeCustomer.setAddress(custAddress);
			storeCustomer.setEmailId(custEmail);
			storeCustomer.setCreditLimit(custcrLimit);
			storeCustomer.setCreditCustomer(crFlag);
			storeCustomer.setStoreId(customer.getStoreId());
			storeCustomer.setDeleteFlag("N");
			String res=storecustomermgntService.editStoreCustomer(storeCustomer);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	@RequestMapping(value="/addstorecustomer",method=RequestMethod.POST)
	 public void addstorecustomer(@RequestBody String customerString,HttpSession session,HttpServletResponse response) throws IOException
	 {
	  logger.debug("In addstorecustomer......{}",customerString);
	  Customer customer=null;
	  if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	  {
	   PrintWriter out = response.getWriter();
	   response.setContentType("text/plain");

	   
	   Gson gson = new GsonBuilder().create();
	   StoreCustomer storeCust =gson.fromJson(customerString, new TypeToken<StoreCustomer>() {
	   }.getType());
	   
	   storeCust.setStoreId(customer.getStoreId());
	   storeCust.setCreditCustomer("N");
	   String res=storecustomermgntService.addStoreCustomer(storeCust);
	   System.out.println("res add customer:"+res);
	   out.print(res);
	   out.flush();
	  }
	 }
	@RequestMapping(value="/editstorecustomer",method=RequestMethod.POST)
	 public void editStoreCustomer(@RequestBody String editCustomerString,HttpSession session,HttpServletResponse response) throws IOException
	 {
	  logger.debug("In editstorecustomer......{},{},{},{},{},{},{}",editCustomerString);
	  Customer customer=null;
	  if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	  {
	   PrintWriter out = response.getWriter();
	   response.setContentType("text/plain");
	   //StoreCustomer storeCustomer=new StoreCustomer();
	   /*storeCustomer.setId(custId);
	   storeCustomer.setName(custName);
	   storeCustomer.setContactNo(custContact);
	   storeCustomer.setAddress(custAddress);
	   storeCustomer.setEmailId(custEmail);
	   storeCustomer.setCreditLimit(custcrLimit);
	   storeCustomer.setCreditCustomer(crFlag);*/
	   Gson gson = new GsonBuilder().create();
	   StoreCustomer storeCust =gson.fromJson(editCustomerString, new TypeToken<StoreCustomer>() {
	   }.getType());
	   
	   storeCust.setStoreId(customer.getStoreId());
	   storeCust.setDeleteFlag("N");
	   String res=storecustomermgntService.editStoreCustomer(storeCust);
	   System.out.println("res:"+res);
	   out.print(res);
	   out.flush();
	  }
	 }
	
	@RequestMapping(value="/deletestorecustomer/{id}",method=RequestMethod.GET)
	public void deleteVendor(@PathVariable("id") String id,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletestorecustomer......{}",id);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=storecustomermgntService.deleteStoreCustomer(NumberUtils.toInt(id), customer.getStoreId());
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/addcreditcustomer",method=RequestMethod.POST)
	public void addCreditCustomer(@RequestBody String customerString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addcreditcustomer......{}",customerString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			StoreCustomer storeCust =gson.fromJson(customerString, new TypeToken<StoreCustomer>() {
			}.getType());

			storeCust.setStoreId(customer.getStoreId());
			storeCust.setCreditCustomer("Y");
			//JSONObject json = (JSONObject) JSONSerializer.toJSON(data);
			System.out.println("customer contact:"+storeCust.getContactNo());
			//storeCust.setCreatedByid(customer.getId());
			String res=storecustomermgntService.addStoreCustomer(storeCust);
			StoreCustomer customerobj=storecustomermgntService.getAddedCustomerData(customer.getStoreId(),storeCust.getContactNo());
			out.print(gson.toJson(customerobj));
			out.flush();
		}
	}
}
