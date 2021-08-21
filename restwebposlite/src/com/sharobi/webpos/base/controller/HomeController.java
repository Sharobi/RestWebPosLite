/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
//import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Store;
//import com.sharobi.webpos.base.model.StoreDayBookRegister;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.login.model.KeyBean;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/home")
public class HomeController {
	private final static Logger logger = LogManager.getLogger(HomeController.class);
	private final static StoreService storeService = new StoreService();
	private final static MenuService menuService = new MenuService();
	private final static Gson gson=new Gson();
	
	@RequestMapping(value = "/welcome",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session) {
		logger.debug("In welcome......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
	/*	Store store = storeService.getStoreById(customer.getStoreId());
		session.setAttribute(Constants.LOGGED_IN_STORE, store);
		mav.addObject("store", store);
		Menu menu=(Menu)session.getAttribute(Constants.MENU_ALL_TREE);
		if(menu==null){
		Menu allMenuList = menuService
				.getAllMenuListLogin(customer.getStoreId(),session);
		session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
//		Menu allMenuList = menuService.getAllMenuListLogin(customer.getStoreId());
//		session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		mav.setViewName(ForwardConstants.VIEW_HOME_PAGE);
		return mav;*/
		
		
		Store store=storeService.getStoreById(customer.getStoreId());
	//	System.out.println(""+store.getIsBarcode());
		session.setAttribute(Constants.LOGGED_IN_STORE, store);
		List<PosModules> posModuless=storeService.getPosModulesByUserId(customer.getContactNo(), customer.getStoreId());
	//	List<Language> langObj = langService.getLanguageListByStoreId(customer.getStoreId());
	//	String res=storeService.checkOpentimestatus(customer.getStoreId());
		session.setAttribute("posModuless", posModuless);
	//	session.setAttribute(Constants.LANG_LIST, langObj);
		mav.addObject("posModuless",posModuless);
		mav.addObject("store",store);
	//	mav.addObject("langlist1", langObj);
		mav.addObject(Constants.HOME,"Y");
	//	StoreDayBookRegister storeDayBookRegistersession=gson.fromJson(res, StoreDayBookRegister.class);
	//	System.out.println("res:"+res);
	//	session.setAttribute(Constants.REST_OPEN_DET,storeDayBookRegistersession);
		Menu menu=(Menu)session.getAttribute(Constants.MENU_ALL_TREE);
		if(menu==null){
	//	Menu allMenuList = menuService.getAllMenuList(customer.getStoreId(),locale.getDisplayLanguage());
			Menu allMenuList = menuService
					.getAllMenuListLogin(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
		
		
		// License  expiration date calculation for alert in home page   
				Date date = new Date();
				String currentdate= new SimpleDateFormat("yyyy-MM-dd").format(date);
				String storeLicenseInfo=storeService.getLicenseInfoByStoreId(Integer.valueOf(customer.getStoreId()));
				KeyBean keybean=gson.fromJson(storeLicenseInfo, KeyBean.class);
				String expireDate=keybean.getTo_date();
				
				Date todayDate;
				Date liscExpireDate;
				try {
					todayDate = new SimpleDateFormat("yyyy-MM-dd").parse(currentdate);  
					liscExpireDate = new SimpleDateFormat("yyyy-MM-dd").parse(expireDate);
					long timeDiff = liscExpireDate.getTime() - todayDate.getTime();
					long daysDiff = timeDiff/(1000*60*60*24);
					//System.out.println("________Time difference is__________::"+daysDiff+"::__Today__::"+todayDate+"::__expday__::"+liscExpireDate);
					if(daysDiff<=15){
						mav.addObject("expdate",expireDate);
					}
					else{
						mav.addObject("expdate","null");
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}  
				
		mav.setViewName(ForwardConstants.VIEW_HOME_PAGE);
		return mav;
	}
	
	@RequestMapping(value = "/getlicenseinfo/{storeid}",
					method = RequestMethod.GET)
	public void getlicenseinfo(	@PathVariable("storeid") String storeid,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In getlicenseinfo......{}", storeid);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			String res = storeService.getLicenseInfoByStoreId(Integer.valueOf(storeid));
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

}
