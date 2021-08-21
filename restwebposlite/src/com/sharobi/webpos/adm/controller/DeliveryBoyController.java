package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.DeliveryBoy;
import com.sharobi.webpos.adm.model.OrderDeliveryBoy;
import com.sharobi.webpos.adm.model.Vendor;
import com.sharobi.webpos.adm.service.DeliveryBoyService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;



@Controller
@RequestMapping("/deliveryboy")
public class DeliveryBoyController {

	private final static Logger logger=LogManager.getLogger(TaxMgntController.class);
	private final static DeliveryBoyService deliveryBoyService=new DeliveryBoyService();
	
	@RequestMapping(value="/viewdeliveryboy",method=RequestMethod.GET)
	public ModelAndView loadDeliveryBoyMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewdeliveryboy......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<DeliveryBoy> deliveryBoyList = deliveryBoyService.getAllDeliveryBoy(customer.getStoreId());
		
		mav.addObject("deliveryBoyList", deliveryBoyList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_DELIVERY_BOY_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/getdeliveryboy",method=RequestMethod.GET)
	public void getDeliveryboy(Model model,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getdeliveryboy......");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		String res=deliveryBoyService.getAllDeliveryBoyByList(customer.getStoreId());
		System.out.println("res:"+res);
		out.print(res);
		out.flush();
		}
	}
	
	@RequestMapping(value="/adddelboymgnt",method=RequestMethod.POST)
	public void addDelBoyMgnt(@RequestBody String deliveryboypost,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In adddeliveryboy......{}",deliveryboypost);
		System.out.println("deliveryBoyPost:"+deliveryboypost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			response.setContentType("text/plain");
			PrintWriter out = response.getWriter();
			Gson gson = new GsonBuilder().create();
			DeliveryBoy deliveryBoy =gson.fromJson(deliveryboypost, new TypeToken<DeliveryBoy>() {
			}.getType());
		
			String res=deliveryBoyService.addDeliveryBoy(deliveryBoy);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/editdelboymgnt",method=RequestMethod.POST)
	public void editDelBoyMgnt(@RequestBody String deliveryboyeditpost,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editdeliveryboy......{}",deliveryboyeditpost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			DeliveryBoy deliveryBoy =gson.fromJson(deliveryboyeditpost, new TypeToken<DeliveryBoy>() {
			}.getType());

			String res=deliveryBoyService.editDeliveryBoy(deliveryBoy);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/deletedelboy/{id}",method=RequestMethod.GET)
	public void deleteDelboy(@PathVariable("id") String id,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletevendor......{}",id);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=deliveryBoyService.deleteDeliveryBoy(NumberUtils.toInt(id), customer.getStoreId());
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	

	@RequestMapping(value="/assigndelboy",method=RequestMethod.POST)
	public void assignDelboy(@RequestBody String orderdeliveryboy,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			OrderDeliveryBoy deliveryBoy =gson.fromJson(orderdeliveryboy, new TypeToken<OrderDeliveryBoy>() {
			}.getType());

			String res=deliveryBoyService.assignDeliveryBoy(deliveryBoy);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
}
