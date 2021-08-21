/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.OrderItem;

import org.springframework.web.bind.annotation.RequestBody;

import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.service.UnpaidOrderService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/unpaidorder")
public class UnpaidOrderController {
	private final static Logger logger=LogManager.getLogger(UnpaidOrderController.class);
	private final static UnpaidOrderService unpaidorderService=new UnpaidOrderService();
	@RequestMapping(value="/viewunpaidorder",method=RequestMethod.GET)
	public ModelAndView loadUnapidOrder(Model model,HttpSession session)
	{
		logger.debug("In loadUnapidOrder......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Order> allunpaidOrderList=unpaidorderService.getAllUnpaidOrderList(customer.getStoreId(), getTodayDate());
		mav.addObject("allunpaidOrderList",allunpaidOrderList);
		mav.addObject(Constants.UNPAID_ORDER,"Y");
		mav.setViewName(ForwardConstants.VIEW_UNPAID_ORDER_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/getunpaidorder/{orderId}",method=RequestMethod.GET)
	public void getunpaidOrderById(@PathVariable("orderId") int orderId,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in getunpaidorder...{}",orderId);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(unpaidorderService.getUnpaidOrderById(orderId));
			out.flush();
		}
	}
/*	@RequestMapping(value="/updateunpaidorderitem/{id}/{itemId}/{orderId}/{quantity}/{changeNote}",method=RequestMethod.GET)
	public void updateUnpaidOrderItem(@PathVariable("id") String id,@PathVariable("itemId") String itemId,@PathVariable("orderId") String orderId,@PathVariable("quantity") String quantity,@PathVariable("changeNote") String changeNote,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in updateunpaidorderitem...{},{},{},{},{}",id,itemId,orderId,quantity,changeNote);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(unpaidorderService.updateUnpaidOrderItem(id, itemId, orderId, quantity, changeNote));
			out.flush();
		}
	}

	*/

	
	@RequestMapping(value = "/updateunpaidorderitempost", method = RequestMethod.POST)
	public void updateunpaidorderitempost(@RequestBody String orderitemstring, HttpSession session, HttpServletResponse response) throws IOException {
		logger.debug("in updateunpaidorderitempost...{}", orderitemstring);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			OrderItem cancelOrderItem = gson.fromJson(orderitemstring, new TypeToken<OrderItem>() {
			}.getType());
			String res = unpaidorderService.updateUnpaidOrderItemPost(cancelOrderItem);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value = "/cancelunpaidorderPost", method = RequestMethod.POST)
	public void cancelunpaidorderPost(@RequestBody String orderstring, HttpSession session, HttpServletResponse response) throws IOException {
		logger.debug("in cancelunpaidorderPost...{}", orderstring);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			Order cancelOrder = gson.fromJson(orderstring, new TypeToken<Order>() {
			}.getType());
			cancelOrder.setStoreId(customer.getStoreId());
			String res = unpaidorderService.cancelUnpaidOrderPost(cancelOrder);
			out.print(res);
			out.flush();
		}
	}
	/*
	@RequestMapping(value="/cancelunpaidorder",method=RequestMethod.GET)
	public ModelAndView cancelUnpaidOrder(@RequestParam String orderId,HttpSession session)throws IOException
	{
		logger.debug("in cancelUnpaidOrder...{}",orderId);
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		String res=unpaidorderService.cancelUnpaidOrder(NumberUtils.toInt(orderId), customer.getStoreId());
		System.out.println("res:"+res);
		mav.setViewName(ForwardConstants.REDIRECT_UNPAID_ORDER_PAGE);
		return mav;
		
	}*/
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}

}
