/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
	private final static Logger logger=LogManager.getLogger(MenuController.class);
	private final static MenuService menuService=new MenuService();
	
	
	@RequestMapping(value = "/menuitems",method = RequestMethod.GET)
	public ModelAndView getMenuItems(@RequestParam String menuid,@RequestParam String index,HttpSession session) throws IOException
	{
		logger.debug("in get menu items...! {},{}", menuid,index);
		ModelAndView mav=new ModelAndView();
		Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
		mav.addObject("menuItems",menuService.getMenuItems(menu,NumberUtils.toInt(menuid)));
		mav.addObject("css",index);
		mav.setViewName(ForwardConstants.VIEW_MENUITEM_PAGE);
		return mav;
		
	}
	
	
	
	@RequestMapping(value = "/getmenuitembybarcode/{code}", method = RequestMethod.GET)
	public void getMenuitemByBarcode(@PathVariable("code") String code, HttpSession session, HttpServletResponse response) throws IOException {
		logger.debug("in getmenuitembybarcode...{}", code);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
			out.print(menuService.getMenuitemByBarcode(code, customer.getStoreId(),selLang));
			out.flush();
		}
	}
	
	
	
	
	
	

}
