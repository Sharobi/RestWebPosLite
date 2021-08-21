/**
 * 
 */
package com.sharobi.webpos.kitchen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.kitchen.service.KitchenService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/kitchen")
public class KitchenController {
	private final static Logger logger=LogManager.getLogger(KitchenController.class);
	private final static KitchenService kitchenService=new KitchenService();

	@RequestMapping(value="/loadkitchenitem",method=RequestMethod.GET)
	public ModelAndView welcome(Model model,HttpSession session)
	{
		logger.debug("In loadkitchenitem......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<OrderItem> allkitchenItem=kitchenService.getKitchenItem(customer.getStoreId(), getTodayDate());
		mav.addObject("allkitchenItem",allkitchenItem);
		mav.addObject(Constants.KITCHEN,"Y");

		mav.setViewName(ForwardConstants.VIEW_KITCHEN_ITEM_PAGE);
		return mav;
	}
	@RequestMapping(value="/startcooking/{orderid}/{orderitemid}/{startTime}",method=RequestMethod.GET)
	public void startCooking(@PathVariable("orderid") int orderid,@PathVariable("orderitemid") int orderitemid,@PathVariable("startTime") String startTime,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in startcooking...{},{},{}",orderid,orderitemid,startTime);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(kitchenService.addCookingStartTime(orderid, orderitemid, startTime));
			out.flush();
		}
	}
	@RequestMapping(value="/stopcooking/{orderid}/{orderitemid}/{endTime}",method=RequestMethod.GET)
	public void stopCooking(@PathVariable("orderid") int orderid,@PathVariable("orderitemid") int orderitemid,@PathVariable("endTime") String endTime,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in stopcooking...{},{},{}",orderid,orderitemid,endTime);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(kitchenService.addCookingEndTime(orderid, orderitemid, endTime));
			out.flush();
		}
	}
	@RequestMapping(value="/kitchenout/{orderid}/{orderitemid}",method=RequestMethod.GET)
	public void updateKitchenOut(@PathVariable("orderid") int orderid,@PathVariable("orderitemid") int orderitemid,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in kitchenout...{},{},",orderid,orderitemid);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(kitchenService.updateKitchenOut(orderid,orderitemid));
			out.flush();
		}
	}
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
