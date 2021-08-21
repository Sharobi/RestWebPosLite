package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.sharobi.webpos.adm.model.SalesReturn;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/refund")
public class RefundController {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = LogManager.getLogger(AdvanceBookingController.class);
	private final static OrderService orderService = new OrderService();
	private final static StoreService storeService = new StoreService();

	@RequestMapping(value = "/refundorder", method = RequestMethod.POST)
	public void saveRefundOrderData(@RequestBody String salesreturn, HttpSession session, HttpServletResponse response)
			throws IOException, ParseException {
		logger.debug("in save salesreturn...{}", salesreturn);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			SalesReturn salesReturn = null;
			Gson gson = new Gson();
			try {
				salesReturn = gson.fromJson(salesreturn, new TypeToken<SalesReturn>() {
				}.getType());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			/*
			 * String date = dateFormat.format(currDate); Date today =
			 * dateFormat.parse(date); salesReturn.setDate(today);
			 */
			
			salesReturn.setCreatedDate(Utility.getFormatedDateShort(currDate));
			salesReturn.setUserId(customer.getContactNo());
			salesReturn.setCreatedBy(customer.getContactNo());
			orderService.saveSalesRefundData(salesReturn);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/getrefundorderdatabyidforapprove/{orderid}", method = RequestMethod.GET)
	public ModelAndView getRefundOrderDetailsForApproveById(@PathVariable("orderid") String orderid, Model model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("In getRefundOrderDetailsForApproveById......{}", orderid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
			String refundorder = orderService.getRefundOrderDetailsDataById(orderid, customer.getStoreId());
			logger.debug("Response : " + refundorder);
			PrintWriter out;
			out = response.getWriter();
			response.setContentType("text/plain");
			out.print(refundorder);
			out.flush();
			return null;
		} catch (IOException e) {
			return null;
		}

	}

	/*
	 * @RequestMapping(value = "/approveorder/{salesreturnid}",method =
	 * RequestMethod.GET) public void
	 * approveRefundOrderData(@PathVariable("salesreturnid") String
	 * salesreturnid, HttpSession session, HttpServletResponse response) throws
	 * IOException { logger.debug("in approveRefundOrderData{}", salesreturnid);
	 * Customer customer; if ((customer = (Customer)
	 * session.getAttribute(Constants.LOGGED_IN_USER)) != null) { PrintWriter
	 * out = response.getWriter(); response.setContentType("text/plain");
	 * out.print(orderService.approveSalesRefundData(salesreturnid ,
	 * customer.getStoreId())); out.flush(); } }
	 */

	@RequestMapping(value = "/approveorder", method = RequestMethod.POST)
	public void approveRefundOrderData(@RequestParam String salesreturnid, HttpSession session,
			@RequestBody String salesreturn1, HttpServletResponse response) throws IOException {
		logger.debug("in approveRefundOrderData{}", salesreturnid);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			Gson gson = new Gson();
			SalesReturn salesreturn = gson.fromJson(salesreturn1, new TypeToken<SalesReturn>() {
			}.getType());
			salesreturn.setStoreId(customer.getStoreId());
			salesreturn.setId(Integer.parseInt(salesreturnid));
			Store store = storeService.getStoreById(customer.getStoreId());
			System.out.println("___is_acc_in order___" + store.getIs_account());
            salesreturn.setIs_account(store.getIs_account());
			//salesreturn.setQs(Constants.SALE_RETURN_PAYMENT_QS);
			salesreturn.setStoreId(customer.getStoreId());
			System.out.println("_____sale_return _____" + salesreturn.toString());
			logger.debug("in payment...{}", gson.toJson(salesreturn));
			out.print(orderService.approveSalesRefundData(salesreturn));
			out.flush();

		}
	}

	@RequestMapping(value = "/deleterefundbyid/{salesreturnid}", method = RequestMethod.GET)
	public ModelAndView deleteSalesRefundById(@PathVariable("salesreturnid") String salesreturnid, Model model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("In deleteSalesRefundById by returnid......{}", salesreturnid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		try {
			String deleteResponse = orderService.deleteSalesReturnDataById(salesreturnid, customer.getStoreId());
			logger.debug("Response : " + deleteResponse);
			PrintWriter out;
			out = response.getWriter();
			response.setContentType("text/plain");
			out.print(deleteResponse);
			out.flush();
			return null;
		} catch (IOException e) {
			return null;
		}

	}
	
	
	
	@RequestMapping(value = "/printrefundbill/{orderid}", method = RequestMethod.GET)
	public void printOrderRefundBill(@PathVariable("orderid") String orderid, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("in print-order-refund-bill...{}", orderid);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Store store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			// if (store.getBillPrintBt().equalsIgnoreCase("Y")) {
			// new PosBillPrinter().printBill(getBillPrintObject(store,
			// orderService.getOrderById(NumberUtils.toInt(orderid))),
			// customer.getStoreId());
			// }
			out.print(orderService.printOrderRefundBill(NumberUtils.toInt(orderid), customer.getStoreId()));
			out.flush();
		}
	}
	
	
	
	
	
	
	
	
	
	

}
