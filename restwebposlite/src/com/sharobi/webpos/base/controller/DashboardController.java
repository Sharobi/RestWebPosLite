package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.CommonResultSetMapper;
import com.sharobi.webpos.adm.model.DashPaymentSummary;
import com.sharobi.webpos.adm.model.DashSalesSummary;
import com.sharobi.webpos.adm.model.DashSalesSummaryOrderType;
import com.sharobi.webpos.adm.model.DashSalesSummaryPaymentType;
import com.sharobi.webpos.adm.model.DashTopCustomer;
import com.sharobi.webpos.adm.model.DashTopItem;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
@Controller
@RequestMapping("/dash")
public class DashboardController {
	    private final static Logger logger = LogManager.getLogger(HomeController.class);
		private final static StoreService storeService = new StoreService();
		private final static MenuMgntService menumgntService = new MenuMgntService();
		private final static Gson gson=new Gson();
		
		@RequestMapping(value = "/viewmdashboard",method = RequestMethod.GET)
		public ModelAndView welcome(Model model,HttpSession session) {
			logger.debug("In welcome......");
			ModelAndView mav = new ModelAndView();
			Customer customer = null;
			if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
				mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
				return mav;
			}
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			session.setAttribute("sescategoryList", menucategoryList);
		    mav.addObject(Constants.ADMIN,"Y");
			mav.setViewName(ForwardConstants.VIEW_HOME_DASHBOARD);
			return mav;
		}
		
		
		
	@RequestMapping(value = "/getBoxData", method = RequestMethod.POST)
	  public void getAllBoxData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getboxdata......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      DashSalesSummary res =storeService.getBoxData(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
		
		@RequestMapping(value = "/getPaymentSummary", method = RequestMethod.POST)
	  public void getPaymentSummaryData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getPaymentSummary......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      DashPaymentSummary res =storeService.getPaymentSummary(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
	  
		
		
		
		@RequestMapping(value = "/getDashSaleSummaryOrderType", method = RequestMethod.POST)
	  public void getDashSaleSummaryOrderTypeData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getDashSaleSummaryOrderType......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      List<DashSalesSummaryOrderType> res =storeService.getDashSaleSummaryOrderType(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
	  
		
		@RequestMapping(value = "/getDashSaleSummaryPaymentType", method = RequestMethod.POST)
	  public void getDashSaleSummaryPaymentTypeData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getDashSaleSummaryPaymentType......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      List<DashSalesSummaryPaymentType> res =storeService.getDashSaleSummaryPaymentType(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
		
		
		@RequestMapping(value = "/getDashTopCustomer", method = RequestMethod.POST)
	  public void getDashTopCustomerData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getDashTopCustomer......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      List<DashTopCustomer> res =storeService.getDashTopCustomer(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
		@RequestMapping(value = "/getDashTopItem", method = RequestMethod.POST)
	  public void getDashTopItemData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
	      throws IOException {
	    logger.info("In getDashTopItem......{}" );
	    Customer customer=null;
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      List<DashTopItem> res =storeService.getDashTopItem(commonResultSetMapper);
	      System.out.println("res:" + res);
	      out.print(gson.toJson(res));
	      out.flush();
	    }
	  }
	

}
