/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.adm.service.CreditSaleService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/creditsale")
public class CreditSaleController {

	private final static Logger logger=LogManager.getLogger(CreditSaleController.class);
	private final static CreditSaleService creditsaleService=new CreditSaleService();
	private final static OrderService orderService=new OrderService();
	
	@RequestMapping(value="/loadcreditcustomer",method=RequestMethod.GET)
	public ModelAndView loadCreditCustomer(HttpSession session)
	{
		logger.debug("in loadcreditcustomer...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<StoreCustomer> creditCustList=creditsaleService.getCreditCustomerList(customer.getStoreId());
		StoreCustomer storeCust=new StoreCustomer();
		List<Order> creditOrderList=new ArrayList<Order>();
		if(creditCustList.size()>0)
		{
			storeCust=creditCustList.get(0);
			creditOrderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), storeCust.getId());
			for(Order orders:creditOrderList)
			{
				setPaidAmt(orders);
			}
			mav.addObject("storeCustDetail",storeCust);
			mav.addObject("creditOrderList",creditOrderList);
		}
		mav.addObject("creditcustList",creditCustList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_CREDIT_SALE_PAGE);
		return mav;
	}
	@RequestMapping(value="/getcreditorderbycustid/{custId}",method=RequestMethod.GET)
	public void getcreditOrderByustId(@PathVariable("custId") int custId,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in getcreditorderbycustid...{}",custId);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}
	@RequestMapping(value="/paybulkcashbycustid/{custId}/{tenderAmt}",method=RequestMethod.GET)
	public void payBulkCashByustId(@PathVariable("custId") int custId,@PathVariable("tenderAmt") double tenderAmt,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in paybulkcashbycustid...{},{}",custId,tenderAmt);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			double finaltenderAmt=0.0;
			finaltenderAmt=tenderAmt;
			for(Order orders:creditorderList)
			{
				if(finaltenderAmt>0)
				{
				int orderno=orders.getId();
				double billAmt=orders.getOrderBill().getGrossAmt();
				double paidAmt=orders.getPaidAmt();
				double amttoPay=billAmt-paidAmt;
				if(finaltenderAmt>=amttoPay)
					{
					paidAmt=amttoPay;
					amttoPay=0.0;
					}
				else
					{
					paidAmt=finaltenderAmt;
					amttoPay=amttoPay-finaltenderAmt;
					}
				Order order=new Order();
				order.setId(orderno);
				Payment payment=new Payment();
				payment.setOrderPayment(order);
				payment.setAmount(billAmt);
				payment.setPaidAmount(paidAmt);
				payment.setAmountToPay(amttoPay);
				payment.setTenderAmount(tenderAmt);
				payment.setPaymentMode("cash");
				payment.setCardLastFourDigits("0000");
				payment.setStoreId(customer.getStoreId());
				payment.setSource("web");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreationDate(getOrderTime());
				String res=orderService.orderPayment(payment);
				System.out.println("paid amt:"+paidAmt);
				if("success".equals(res))
				{
					finaltenderAmt=finaltenderAmt-paidAmt;
				}
				}
				else
				{
					break;
				}
				
			}
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}
	@RequestMapping(value="/paybulkcardbycustid/{custId}/{tenderAmt}/{lastfourdigit}",method=RequestMethod.GET)
	public void payBulkCardByustId(@PathVariable("custId") int custId,@PathVariable("tenderAmt") double tenderAmt,@PathVariable("lastfourdigit") int lastfourdigit,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in paybulkcardbycustid...{},{},{}",custId,tenderAmt,lastfourdigit);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			double finaltenderAmt=0.0;
			finaltenderAmt=tenderAmt;
			for(Order orders:creditorderList)
			{
				if(finaltenderAmt>0)
				{
				int orderno=orders.getId();
				double billAmt=orders.getOrderBill().getGrossAmt();
				double paidAmt=orders.getPaidAmt();
				double amttoPay=billAmt-paidAmt;
				if(finaltenderAmt>=amttoPay)
					{
					paidAmt=amttoPay;
					amttoPay=0.0;
					}
				else
					{
					paidAmt=finaltenderAmt;
					amttoPay=amttoPay-finaltenderAmt;
					}
				Order order=new Order();
				order.setId(orderno);
				Payment payment=new Payment();
				payment.setOrderPayment(order);
				payment.setAmount(billAmt);
				payment.setPaidAmount(paidAmt);
				payment.setAmountToPay(amttoPay);
				payment.setTenderAmount(tenderAmt);
				payment.setPaymentMode("card");
				payment.setCardLastFourDigits(""+lastfourdigit);
				payment.setStoreId(customer.getStoreId());
				payment.setSource("web");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreationDate(getOrderTime());
				String res=orderService.orderPayment(payment);
				System.out.println("paid amt:"+paidAmt);
				if("success".equals(res))
				{
					finaltenderAmt=finaltenderAmt-paidAmt;
				}
				}
				else
				{
					break;
				}
				
			}
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}
	
	public Order setPaidAmt(Order order)
	{
		double paidAmount=0.00;
		List<Payment> paymentLst = orderService.getPaymentListById(order.getId());
		Iterator<Payment> iterator = paymentLst.iterator();
		while (iterator.hasNext()) {
			Payment payment = (Payment) iterator.next();
			paidAmount = paidAmount + payment.getPaidAmount();
		}
		order.setPaidAmt(paidAmount);
		return order;
	}
	
	public String getOrderTime()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    //System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
