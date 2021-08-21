/**
 * 
 */
package com.sharobi.webpos.report.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.DeliveryBoy;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.User;
import com.sharobi.webpos.adm.service.DeliveryBoyService;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.report.service.ReportService;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/report")
public class ReportController {
	private final static Logger logger = LogManager.getLogger(ReportController.class);
	private final static StoreService storeService = new StoreService();
	private final static ReportService reportService = new ReportService();
	private final static MenuMgntService menumgntService = new MenuMgntService();
	private final static InventoryService inventoryService = new InventoryService();
	private final static MenuService menuService = new MenuService();
	private final static DeliveryBoyService deliveryBoyService = new DeliveryBoyService();
	private final static Gson gson = new Gson();

	@RequestMapping(value = "/viewdaywisesales", method = RequestMethod.GET)
	public ModelAndView loadDaywiseSales(HttpSession session) {
		logger.debug("In viewdaywisesales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_SALES);

		return mav;
	}

	@RequestMapping(value = "/getdaywisesales/", method = RequestMethod.GET)
	public void getdaywiseSalesReport(@RequestParam String date, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.debug("In getdaywisesales......{}", date);
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			// PrintWriter out = response.getWriter();
			response.setContentType("application/pdf");
			OutputStream os = response.getOutputStream();
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_SALES_DAILY_REPORT)
							.replace("{1}", date).replace("{2}", String.valueOf(customer.getStoreId()));
			URL pdfUrl = new URL(url);
			InputStream ios = pdfUrl.openStream();
			byte[] bytes = new byte[1024];
			int bytesRead;
			while ((bytesRead = ios.read()) > 0) {
				os.write(bytes, 0, bytesRead);
			}
			os.flush();
			os.close();
			ios.close();

		}

	}

	@RequestMapping(value = "/getReportByStore", method = RequestMethod.GET)
	public ModelAndView getReportByStore(HttpSession session) {

		logger.debug("In Report......");

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		User user = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		/* Use Hardcode UserId */
		// String userId = "88";
		PosModules posModules = new PosModules();
		List<PosModules> posModuleObj = reportService.getReportByStore(String.valueOf(customer.getId()),
				String.valueOf(customer.getStoreId()));
		System.out.println(">>>>>" + posModuleObj);
		mav.addObject("posModuleObj", posModuleObj);
		session.setAttribute("posModuleObj", posModuleObj);
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_SALES);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;

	}

	@RequestMapping(value = "/viewdaytimewisesales", method = RequestMethod.GET)
	public ModelAndView loadDayTimewiseSales(HttpSession session) {
		logger.debug("In viewdaytimewisesales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_TIME_WISE_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewdaywiseorders", method = RequestMethod.GET)
	public ModelAndView loadDaywiseOrders(HttpSession session) {
		logger.debug("In viewdaywiseorders......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_ORDERS);

		return mav;
	}

	@RequestMapping(value = "/viewperiodwisesales", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseSales(HttpSession session) {
		logger.debug("In viewperiodwisesales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewUserWiseDailySales", method = RequestMethod.GET)
	public ModelAndView viewUserwiseDailySalesReport(HttpSession session) {
		logger.debug("In viewuserwisedailysales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Customer> customers = storeService.getAllWaitersByStoreid(customer.getStoreId());
		mav.addObject("customers", customers);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_USER_WISE_DAILY_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisehourlysales", method = RequestMethod.GET)
	public ModelAndView viewDaywiseHourlySales(HttpSession session) {
		logger.debug("In viewdaywisehourlysales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_HOURLY_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisesummarysales", method = RequestMethod.GET)
	public ModelAndView viewDaywiseSummarySales(HttpSession session) {
		logger.debug("In viewdaywisesummarysales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_SUMMARY_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisesummarysales", method = RequestMethod.GET)
	public ModelAndView viewPeriodwiseSummarySales(HttpSession session) {
		logger.debug("In viewperiodwisesummarysales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_SUMMARY_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewitemwisedailyorders", method = RequestMethod.GET)
	public ModelAndView loadItemwiseDailyOrders(HttpSession session) {
		logger.debug("In viewitemwisedailyorders......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_ITEM_WISE_DAILY_ORDERS);
		return mav;
	}

	@RequestMapping(value = "/viewitemwiseperiodorders", method = RequestMethod.GET)
	public ModelAndView loadItemwisePeriodOrders(HttpSession session) {
		logger.debug("In viewitemwiseperiodorders......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_ITEM_WISE_PERIOD_ORDERS);
		return mav;
	}

	@RequestMapping(value = "/viewgstinoutrptperiodwise", method = RequestMethod.GET)
	public ModelAndView loadgstinoutrptperiodwise(HttpSession session) {
		logger.debug("In viewgstinoutrptperiodwise......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_GST_IN_OUT_PERIOD_WISE);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisesalescategory", method = RequestMethod.GET)
	public ModelAndView loadDaywiseSalesCategory(HttpSession session) {
		logger.debug("In viewdaywisesalescategory......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
		mav.addObject("menucategorylist", menucategoryList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_CAT_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisecreditsales", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseCreditSales(HttpSession session) {
		logger.debug("In viewperiodwisecreditsales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_CREDIT_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisepo", method = RequestMethod.GET)
	public ModelAndView loadDaywisePo(HttpSession session) {
		logger.debug("In viewdaywisepo......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_PO);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisepo", method = RequestMethod.GET)
	public ModelAndView loadPeriodwisePo(HttpSession session) {
		logger.debug("In viewperiodwisepo......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_PO);
		return mav;
	}

	@RequestMapping(value = "/viewrawstockinsummary", method = RequestMethod.GET)
	public ModelAndView loadRawStockInSummary(HttpSession session) {
		logger.debug("In viewrawstockinsummary......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKIN_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewrawstockinregister", method = RequestMethod.GET)
	public ModelAndView loadRawStockInRegister(HttpSession session) {
		logger.debug("In loadRawStockInRegister......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKIN_REGISTER);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisestockin", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseStockIn(HttpSession session) {
		logger.debug("In viewperiodwisestockin......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_STOCKIN);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisestockoutallcat", method = RequestMethod.GET)
	public ModelAndView loadDaywiseStockOutAllCat(HttpSession session) {
		logger.debug("In viewdaywisestockoutallcat......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_STOCKOUT_ALLCAT);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisestockoutallcat", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseStockOutAllCat(HttpSession session) {
		logger.debug("In viewperiodwisestockoutallcat......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_STOCKOUT_ALLCAT);
		return mav;
	}

	@RequestMapping(value = "/viewdaywisestockoutkitchen", method = RequestMethod.GET)
	public ModelAndView loadDaywiseStockOutKitchen(HttpSession session) {
		logger.debug("In viewdaywisestockoutkitchen......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
		mav.addObject("menucategorylist", menucategoryList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_DAY_WISE_STOCKOUT_KITCHEN);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisestockoutkitchen", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseStockOutKitchen(HttpSession session) {
		logger.debug("In viewperiodwisestockoutkitchen......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
		mav.addObject("menucategorylist", menucategoryList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_STOCKOUT_KITCHEN);
		return mav;
	}

	@RequestMapping(value = "/viewcurrentstock", method = RequestMethod.GET)
	public ModelAndView loadCurrentStock(HttpSession session) {
		logger.debug("In viewcurrentstock......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_CURRENT_STOCK);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisecancelorder", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseCancelOrder(HttpSession session) {
		logger.debug("In viewperiodwisecancelorder......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_CANCEL_ORDER);
		return mav;
	}

	@RequestMapping(value = "/viewperiodwisenockotorder", method = RequestMethod.GET)
	public ModelAndView loadPeriodwiseNOCKOTOrder(HttpSession session) {
		logger.debug("In viewperiodwisenockotorder......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_NOCKOT_ORDER);
		return mav;
	}
	
	@RequestMapping(value = "/viewperiodwisepackagingdetails", method = RequestMethod.GET)
	public ModelAndView loadPeriodwisePackagingDetails(HttpSession session) {
		logger.debug("In viewperiodwisepackagingdetails......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_PERIOD_WISE_PACKAGING_DETAILS);
		return mav;
	}

	@RequestMapping(value = "/getcustomerlist", method = RequestMethod.GET)
	public ModelAndView getAllCustomerDetails(HttpSession session) {

		logger.debug("In Report......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		User user = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		// List<Customer> customerObj =
		// reportService.getCustomerList(String.valueOf(customer.getStoreId()));

		// mav.addObject("customerObj",customerObj);
		mav.addObject(Constants.REPORTS, "Y");

		mav.setViewName(ForwardConstants.VIEW_RPT_CUSTOMER_LIST);

		return mav;
	}

	@RequestMapping(value = "/viewcancelorderreasonrpt", method = RequestMethod.GET)
	public ModelAndView viewCancelOrderReasonrpt(HttpSession session) {
		logger.debug("In viewCancelOrderReasonrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_CANCEL_ORDER_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewdailysalescelavirpt", method = RequestMethod.GET)
	public ModelAndView viewDailySalesCelavirpt(HttpSession session) {
		logger.debug("In viewDailySalesCelavirpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_DAILYSALES_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewpaymentmodewisesales", method = RequestMethod.GET)
	public ModelAndView loadPaymentmodeSales(HttpSession session) {
		logger.debug("In viewpaymentmodewisesales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");

		mav.setViewName(ForwardConstants.VIEW_RPT_PAYMENTMODE_WISE_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewcatwisesales", method = RequestMethod.GET)
	public ModelAndView loadCatwisewiseSales(HttpSession session) {
		logger.debug("In viewcatwisesales......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		List<MenuCategory> menucategoryList = menumgntService
				.getMenuCategoryExcludeSpclNoteByStoreId(customer.getStoreId());
		mav.addObject("menucategorylist", menucategoryList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_CAT_WISE_PERIOD_SALES);
		return mav;
	}

	@RequestMapping(value = "/viewtopcustomer", method = RequestMethod.GET)
	public ModelAndView loadTopCustomer(HttpSession session) {
		logger.debug("In viewtopcustomer......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_TOP_CUSTOMER);
		return mav;
	}

	@RequestMapping(value = "/viewnewvsrepeat", method = RequestMethod.GET)
	public ModelAndView NewVsRepeat(HttpSession session) {
		logger.debug("In viewnewvsrepeat......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_NEW_VS_RPT_CUSTOMER);
		return mav;
	}

	@RequestMapping(value = "/viewoutstandingcustomer", method = RequestMethod.GET)
	public ModelAndView loadOutStandingCustomer(HttpSession session) {
		logger.debug("In viewnewvsrepeat......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_OUTSTANDING_CUSTOMER);
		return mav;
	}

	@RequestMapping(value = "/vieworderwisedeliveryboy", method = RequestMethod.GET)
	public ModelAndView loadviewOrderWiseDeliveryBoy(HttpSession session) {
		logger.debug("In vieworderwisedeliveryboy......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_ORDER_AND_DELIVERYBOY_REPORT);
		return mav;
	}

	// new added
	@RequestMapping(value = "/viewdailymanagerwithtaxrpt", method = RequestMethod.GET)
	public ModelAndView viewDailyManagerwithTaxrpt(HttpSession session) {
		logger.debug("In viewDailyManagerwithTaxrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_DAILYMANAGER_WITHTAX_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewdailysalesinclusiverpt", method = RequestMethod.GET)
	public ModelAndView viewDailySalesInclusiverpt(HttpSession session) {
		logger.debug("In viewDailySalesInclusiverpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_DAILYSALES_INCLUSIVETAX_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewdiscountreasonrpt", method = RequestMethod.GET)
	public ModelAndView viewDiscountReasonrpt(HttpSession session) {
		logger.debug("In viewdiscountreasonrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_DISCOUNT_REASON_ORDER_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewnonchargeableorderrpt", method = RequestMethod.GET)
	public ModelAndView viewNCOrderrpt(HttpSession session) {
		logger.debug("In viewCancelOrderReasonrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_NONCHARGEABLE_ORDER_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewpaymentwiserpt", method = RequestMethod.GET)
	public ModelAndView viewPaymentWiserpt(HttpSession session) {
		logger.debug("In viewpaymentwiserpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_ORDER_PAYMENTDETAILS_CELAVI);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	@RequestMapping(value = "/viewdailysalessummaryrpt", method = RequestMethod.GET)
	public ModelAndView viewDailySalesSummaryrpt(HttpSession session) {
		logger.debug("In viewpaymentwiserpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.setViewName(ForwardConstants.VIEW_RPT_ORDER_DAILYSALES_SUMMARY);
		mav.addObject(Constants.REPORTS, "Y");
		return mav;
	}

	// Accounts report part

	@RequestMapping(value = "/viewplstatement", method = RequestMethod.GET)
	public ModelAndView loadPLStatement(HttpSession session) {
		logger.debug("In viewplstatement......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_ACCOUNT_PLSTATEMENT);
		return mav;
	}

	@RequestMapping(value = "/viewtaxstatement", method = RequestMethod.GET)
	public ModelAndView loadTaxStatement(HttpSession session) {
		logger.debug("In viewtaxstatement......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_ACCOUNT_TAXSTATEMENT);
		return mav;
	}

	@RequestMapping(value = "/viewrefundsummary", method = RequestMethod.GET)
	public ModelAndView loadRefundSummary(HttpSession session) {
		logger.debug("In viewrefundsummary......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_REFUNDS_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewrefunddetails", method = RequestMethod.GET)
	public ModelAndView loadRefundDetails(HttpSession session) {
		logger.debug("In viewrefunddetails......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_REFUNDS_DETAILS);
		return mav;
	}

	@RequestMapping(value = "/viewtaxsummary", method = RequestMethod.GET)
	public ModelAndView loadTaxSummary(HttpSession session) {
		logger.debug("In viewrefunddetails......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_TAX_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewrawstockinitemwise", method = RequestMethod.GET)
	public ModelAndView loadRawStockInItemWise(HttpSession session) {
		logger.debug("In loadRawStockInRegister......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		/*
		 * List<InventoryVendors> vendorList =
		 * inventoryService.getVendors(customer.getStoreId());
		 */
		/*
		 * Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
		 * List<MenuItem> menuItem=menuService.getItems(menu); mav.addObject("itemList",
		 * menuItem);
		 */
		/* mav.addObject("vendorList", vendorList); */
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKIN_ITEMWISE);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockinsummary", method = RequestMethod.GET)
	public ModelAndView loadFgStockInSummary(HttpSession session) {
		logger.debug("In viewfgstockinsummary......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKIN_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockinregister", method = RequestMethod.GET)
	public ModelAndView loadFgStockInRegister(HttpSession session) {
		logger.debug("In viewfgstockinregister......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKIN_REGISTER);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockinitemwise", method = RequestMethod.GET)
	public ModelAndView loadFgStockInItemWise(HttpSession session) {
		logger.debug("In viewfgstockinitemwise......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		/*
		 * List<InventoryVendors> vendorList =
		 * inventoryService.getVendors(customer.getStoreId());
		 */
		/*
		 * Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
		 * List<MenuItem> menuItem=menuService.getItems(menu); mav.addObject("itemList",
		 * menuItem);
		 */
		/* mav.addObject("vendorList", vendorList); */
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKIN_ITEMWISE);
		return mav;
	}

	@RequestMapping(value = "/viewrawstockreturnsummary", method = RequestMethod.GET)
	public ModelAndView loadRawStockOutSummary(HttpSession session) {
		logger.debug("In viewrawstockoutsummary......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKOUT_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewrawstockreturnregister", method = RequestMethod.GET)
	public ModelAndView loadRawStockOutRegister(HttpSession session) {
		logger.debug("In viewrawstockoutregister......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKOUT_REGISTER);
		return mav;
	}
	
	
	@RequestMapping(value = "/viewrawstockoutregister", method = RequestMethod.GET)
	  public ModelAndView loadviewrawstockoutregister(HttpSession session) {
	    logger.debug("In viewrawstockoutregister......");
	    ModelAndView mav = new ModelAndView();
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    }
	    List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
	    mav.addObject("vendorList", vendorList);
	    mav.addObject(Constants.REPORTS, "Y");
	    mav.setViewName(ForwardConstants.VIEW_RPT_INV_RAW_STOCKOUT_REGISTER);
	    return mav;
	  }
	@RequestMapping(value = "/viewrawstockoutsummary", method = RequestMethod.GET)
	  public ModelAndView loadRrawStockoutSummary(HttpSession session) {
	    logger.debug("In viewrawstockoutsummary......");
	    ModelAndView mav = new ModelAndView();
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    }
	    List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
	    mav.addObject("vendorList", vendorList);
	    mav.addObject(Constants.REPORTS, "Y");
	    mav.setViewName(ForwardConstants.VIEW_RPT_INV_RAW_STOCKOUT_SUMMARY);
	    return mav;
	  }
	
	 @RequestMapping(value = "/viewrawstockoutitemwise", method = RequestMethod.GET)
	  public ModelAndView viewrawstockoutitemwise(HttpSession session) {
	    logger.debug("In viewrawstockoutitemwise......");
	    ModelAndView mav = new ModelAndView();
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    }
	    /*
	     * List<InventoryVendors> vendorList =
	     * inventoryService.getVendors(customer.getStoreId());
	     */
	    /*
	     * Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
	     * List<MenuItem> menuItem=menuService.getItems(menu); mav.addObject("itemList",
	     * menuItem);
	     */
	    /* mav.addObject("vendorList", vendorList); */
	    mav.addObject(Constants.REPORTS, "Y");
	    mav.setViewName(ForwardConstants.VIEW_RPT_INV_RAW_STOCKOUT_ITEMWISE);
	    return mav;
	  }


	@RequestMapping(value = "/viewrawstockreturnitemwise", method = RequestMethod.GET)
	public ModelAndView loadRawStockOutItemWise(HttpSession session) {
		logger.debug("In viewrawstockoutitemwise......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		/*
		 * List<InventoryVendors> vendorList =
		 * inventoryService.getVendors(customer.getStoreId());
		 */
		/*
		 * Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
		 * List<MenuItem> menuItem=menuService.getItems(menu); mav.addObject("itemList",
		 * menuItem);
		 */
		/* mav.addObject("vendorList", vendorList); */
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_STOCKOUT_ITEMWISE);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockreturnsummary", method = RequestMethod.GET)
	public ModelAndView loadFgStockReturnSummary(HttpSession session) {
		logger.debug("In viewfgstockreturnsummary......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKRETURN_SUMMARY);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockreturnregister", method = RequestMethod.GET)
	public ModelAndView loadFgStockReturnRegister(HttpSession session) {
		logger.debug("In viewfgstockreturnregister......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorList);
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKRETURN_REGISTER);
		return mav;
	}

	@RequestMapping(value = "/viewfgstockreturnitemwise", method = RequestMethod.GET)
	public ModelAndView loadFgStockReturnItemWise(HttpSession session) {
		logger.debug("In viewfgstockreturnitemwise......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		/*
		 * List<InventoryVendors> vendorList =
		 * inventoryService.getVendors(customer.getStoreId());
		 */
		/*
		 * Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
		 * List<MenuItem> menuItem=menuService.getItems(menu); mav.addObject("itemList",
		 * menuItem);
		 */
		/* mav.addObject("vendorList", vendorList); */
		mav.addObject(Constants.REPORTS, "Y");
		mav.setViewName(ForwardConstants.VIEW_RPT_FG_STOCKRETURN_ITEMWISE);
		return mav;
	}

	// Vendor payment report
	@RequestMapping(value = "/viewvendorpaymentrpt", method = RequestMethod.GET)
	public ModelAndView loadRefund(HttpSession session) {
		logger.debug("In viewvendorpaymentrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorlist = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorlist);
		mav.addObject(Constants.REPORTS, "Y");

		mav.setViewName(ForwardConstants.VIEW_RPT_RAW_VENDOR_PAYMENT);
		return mav;
	}

	@RequestMapping(value = "/viewfgvendorpaymentrpt", method = RequestMethod.GET)
	public ModelAndView loadFgVendorPayment(HttpSession session) {
		logger.debug("In viewvendorpaymentrpt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryVendors> vendorlist = inventoryService.getVendors(customer.getStoreId());
		mav.addObject("vendorList", vendorlist);
		mav.addObject(Constants.REPORTS, "Y");

		mav.setViewName(ForwardConstants.VIEW_RPT_FG_VENDOR_PAYMENT);
		return mav;
	}

}
