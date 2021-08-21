/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.MediaType;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.FmcgUnit;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuFile;
import com.sharobi.webpos.adm.model.MenuItemNotes;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.model.PrintKotMaster;
import com.sharobi.webpos.adm.model.SpecialNoteListContainer;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.login.model.User;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.KOTPrint;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.MultiPart;
import com.sun.jersey.multipart.file.FileDataBodyPart;
/*import com.sun.xml.internal.messaging.saaj.packaging.mime.util.BASE64DecoderStream;*/

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/menumgnt")
public class MenuMgntController {
	private final static Logger logger = LogManager.getLogger(MenuMgntController.class);
	private final static MenuMgntService menumgntService = new MenuMgntService();
	private final static MenuService menuService = new MenuService();

	@RequestMapping(value = "/viewmenumgnt",
					method = RequestMethod.GET)
	public ModelAndView loadMenuMgnt(	Model model,
										HttpSession session) {
		logger.debug("In loadMenuMgnt......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
		session.setAttribute("sescategoryList", menucategoryList);
		mav.addObject("menucategorylist", menucategoryList);
		//mav.addObject("menucatid",menucategoryList.get(0).getId());
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_MENU_MGNT_PAGE);
		return mav;
	}

	/*@RequestMapping(value = "/addmenucategory/{catName}/{bgColor}",
					method = RequestMethod.GET)
	public void addMenuCategory(@PathVariable("catName") String catName,
								@PathVariable("bgColor") String bgColor,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In addmenucategory......{},{}", catName, bgColor);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = menumgntService.addMenuCategory(catName, customer.getStoreId(), bgColor);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}*/
	
	@RequestMapping(value="/addmenucategory",method=RequestMethod.POST)
	public void addMenuCategory(@RequestBody String menuItemString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmenucategory......{}",menuItemString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//response.setCharacterEncoding("UTF-8");
			//request.setCharacterEncoding("UTF-8");
			//MenuCategory category=new MenuCategory();
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuItemString, new TypeToken<MenuCategory>() {
			}.getType());
			//category.setMenuCategoryName(catName);
			//category.setBgColor(bgColor);
			category.setStoreId(customer.getStoreId());
			String res=menumgntService.addMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}

	/*@RequestMapping(value = "/editmenucategory/{id}/{name}/{color}",
					method = RequestMethod.GET)
	public void editMenuCategory(	@PathVariable("id") int id,
									@PathVariable("name") String name,
									@PathVariable("color") String color,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In editmenucategory......{},{},{}", id, name, color);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			String res = menumgntService.editMenuCategory(menuCategory);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}
*/

	@RequestMapping(value="/editmenucategory",method=RequestMethod.POST)
	public void editMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editmenucategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			String res=menumgntService.editMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
/*	@RequestMapping(value = "/deletemenucategory/{id}/{name}/{color}",
					method = RequestMethod.GET)
	public void deleteMenuCategory(	@PathVariable("id") int id,
									@PathVariable("name") String name,
									@PathVariable("color") String color,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In deleteMenuCategory......{},{},{}", id, name, color);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			String res = menumgntService.deleteMenuCategory(menuCategory);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}*/

	@RequestMapping(value="/deletemenucategory",method=RequestMethod.POST)
	public void deleteMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteMenuCategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			String res=menumgntService.deleteMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	
	@RequestMapping(value = "/loadsubcategory",
					method = RequestMethod.GET)
	public ModelAndView loadsubCategoryPage(Model model,
											HttpSession session) {
		logger.debug("in loadsubcategory...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menuCatList = (List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		/*for(MenuCategory menucat:menuCatList){
			if(menucat.getId()==NumberUtils.toInt(menucatid))
			{
				menucategory=menucat;
			}
			}*/
		List<MenuCategory> menusubcategoryList=null;
		
		if(menuCatList.size()!=0){
		  menucategory = menuCatList.get(0);
		  menusubcategoryList = menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(), menucategory.getId());
	     }
		mav.addObject("catList", menuCatList);
		//mav.addObject("menucategory",menucategory);
		//model.addAttribute("printKotMaster", new PrintKotMaster());
		mav.addObject("menusubcategorylist", menusubcategoryList);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_MENU_SUB_CAT_PAGE);
		return mav;
	}

	@RequestMapping(value = "/loadsubcategorybyid",
					method = RequestMethod.GET)
	public ModelAndView loadsubCategoryPageById(@RequestParam String menucatid,
												HttpSession session) {
		logger.debug("in loadsubcategory...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menuCatList = (List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		for (MenuCategory menucat : menuCatList) {
			if (menucat.getId() == NumberUtils.toInt(menucatid)) {
				menucategory = menucat;
			}
		}
		//menucategory=menuCatList.get(0);
		List<MenuCategory> menusubcategoryList = menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(), NumberUtils.toInt(menucatid));
		mav.addObject("catList", menuCatList);
		mav.addObject("menucategory", menucategory);
		mav.addObject("menusubcategorylist", menusubcategoryList);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_MENU_SUB_CAT_PAGE);
		return mav;
	}

	/*@RequestMapping(value = "/addmenusubcategory/{subcatName}/{subcatbgColor}/{catId}",
					method = RequestMethod.GET)
	public void addMenuSubCategory(	@PathVariable("subcatName") String subcatName,
									@PathVariable("subcatbgColor") String subcatbgColor,
									@PathVariable("catId") int catId,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In addmenusubcategory......{},{},{}", subcatName, subcatbgColor, catId);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = menumgntService.addMenuSubCategory(subcatName, customer.getStoreId(), subcatbgColor, catId);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}*/

	@RequestMapping(value="/addmenusubcategorypost",method=RequestMethod.POST)
	public void addMenuSubCategoryPost(@RequestBody String menuSubcategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmenusubcategory......{}",menuSubcategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");	
			Gson gson = new GsonBuilder().create();
			MenuCategory subcategory =gson.fromJson(menuSubcategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			//MenuCategory menuSubCategory=new MenuCategory();
			//menuSubCategory.setMenuCategoryName(subcatName);
			//menuSubCategory.setBgColor(subcatbgColor);
			System.out.println("TEST Pk"+subcategory.getMenucategory());  
			subcategory.setStoreId(customer.getStoreId());
			//menuSubCategory.setParentCatId(""+catId);
			//System.out.println("catId:"+catId);
			String res=menumgntService.addMenuSubCategory(subcategory);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
/*	@RequestMapping(value = "/editmenusubcategory/{id}/{name}/{color}/{catId}",
					method = RequestMethod.GET)
	public void editSubMenuCategory(@PathVariable("id") int id,
									@PathVariable("name") String name,
									@PathVariable("color") String color,
									@PathVariable("catId") int catId,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In editmenusubcategory......{},{},{},{}", id, name, color, catId);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId("" + catId);
			String res = menumgntService.editMenuSubCategory(menuCategory);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}*/
	
	@RequestMapping(value="/editmenusubcategory",method=RequestMethod.POST)
	public void editSubMenuCategory(@RequestBody String menuSubCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editmenusubcategory......{}",menuSubCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			MenuCategory Subcategory =gson.fromJson(menuSubCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			/*MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId(""+catId);*/
			String res=menumgntService.editMenuSubCategory(Subcategory);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}

	/*@RequestMapping(value = "/deletemenusubcategory/{id}/{name}/{color}/{catId}",
					method = RequestMethod.GET)
	public void deleteSubMenuCategory(	@PathVariable("id") int id,
										@PathVariable("name") String name,
										@PathVariable("color") String color,
										@PathVariable("catId") int catId,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("In deletemenusubcategory......{},{},{},{}", id, name, color, catId);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId("" + catId);
			String res = menumgntService.deleteMenuSubCategory(menuCategory);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}*/

	@RequestMapping(value="/deletemenusubcategorypost",method=RequestMethod.POST)
	public void deleteSubMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deletemenusubcategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");			
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			/*MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId(""+catId);*/
			String res=menumgntService.deleteMenuSubCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value = "/loadmenuitems",
					method = RequestMethod.GET)
	public ModelAndView loadMenuItems(HttpSession session) {
		logger.debug("in loadmenuitems...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		MenuCategory menuCategory = menumgntService.getAllMenuTree(customer.getStoreId());
		session.setAttribute("categoryTree", menuCategory);
		List<MenuCategory> menuCatList = (List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		List<MenuCategory> menusubcategoryList=null;
		if(menuCatList.size()!=0){
		 menucategory = menuCatList.get(0);
		 menusubcategoryList = menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(), menucategory.getId());
		}
		List<FmcgUnit> fmcgList = menumgntService.getFmcgUnitByStoreId(customer.getStoreId());
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		mav.addObject("menucatList", menuCatList);
		mav.addObject("menusubcatList", menusubcategoryList);
		mav.addObject("allmenuTree", menuCategory);
		mav.addObject("fmcgList", fmcgList);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_PAGE);

		return mav;
	}

	/*@RequestMapping(value = "/addmenuitems/{catId}/{name}/{desc}/{price}/{vat}/{stax}/{type}/{spicy}/{promo}/{promodesc}/{promovalue}/{cookingtime}/{unit}/{itemcode}/{itemPurchaseRate}",
					method = RequestMethod.GET)
	public void addMenuItems(	@PathVariable("catId") int catId,
								@PathVariable("name") String name,
								@PathVariable("desc") String desc,
								@PathVariable("price") double price,
								@PathVariable("vat") double vat,
								@PathVariable("stax") double stax,
								@PathVariable("type") String type,
								@PathVariable("spicy") String spicy,
								@PathVariable("promo") String promo,
								@PathVariable("promodesc") String promodesc,
								@PathVariable("promovalue") int promovalue,
								@PathVariable("cookingtime") int cookingtime,
								@PathVariable("unit") String unit,
								@PathVariable("itemcode") String itemcode,
								@PathVariable("itemPurchaseRate") double itemPurchaseRate,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In addmenuitems......{},{},{},{},{},{},{},{},{},{},{},{},{},{}", catId, name, desc, price, vat, stax, type, spicy, promo, promodesc, promovalue, cookingtime, unit,itemcode);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(catId);
			MenuItems menuItems = new MenuItems();
			menuItems.setMenucategory(menuCategory);
			menuItems.setName(name);
			menuItems.setDescription(desc);
			menuItems.setPrice(price);
			menuItems.setVat(vat);
			menuItems.setServiceTax(stax);
			menuItems.setVeg(type);
			menuItems.setSpicy(spicy);
			menuItems.setPromotionFlag(promo);
			menuItems.setPromotionDesc(promodesc);
			menuItems.setPromotionValue(promovalue);
			menuItems.setStoreId(customer.getStoreId());
			menuItems.setCookingTimeInMins(cookingtime);
			menuItems.setUnit(unit);
			menuItems.setCode(itemcode);
			menuItems.setPurchasePrice(itemPurchaseRate);
			
			String res = menumgntService.addMenuItems(menuItems);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
//			Menu menu=(Menu)session.getAttribute(Constants.MENU_ALL_TREE);
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService
					.getAllMenuList(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
	}*/

	/*@RequestMapping(value = "/editmenuitems/{catId}/{id}/{name}/{desc}/{price}/{vat}/{stax}/{type}/{spicy}/{promo}/{promodesc}/{promovalue}/{cookingtime}/{production}/{unit}/{spotDisc}/{itemcode}/{purchaseRate}",
					method = RequestMethod.GET)
	public void addMenuItems(	@PathVariable("catId") int catId,
								@PathVariable("id") int id,
								@PathVariable("name") String name,
								@PathVariable("desc") String desc,
								@PathVariable("price") double price,
								@PathVariable("vat") double vat,
								@PathVariable("stax") double stax,
								@PathVariable("type") String type,
								@PathVariable("spicy") String spicy,
								@PathVariable("promo") String promo,
								@PathVariable("promodesc") String promodesc,
								@PathVariable("promovalue") int promovalue,
								@PathVariable("cookingtime") int cookingtime,
								@PathVariable("production") String production,
								@PathVariable("unit") String unit,
								@PathVariable("spotDisc") String spotDisc,
								@PathVariable("itemcode") String itemcode,
								@PathVariable("purchaseRate") double purchaseRate,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In editmenuitems......{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}", catId, id, name, desc, price, vat, stax, type, spicy, promo, promodesc, promovalue, cookingtime, production, unit,spotDisc,itemcode);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(catId);
			MenuItems menuItems = new MenuItems();
			menuItems.setId(id);
			menuItems.setMenucategory(menuCategory);
			menuItems.setName(name);
			menuItems.setDescription(desc);
			menuItems.setPrice(price);
			menuItems.setVat(vat);
			menuItems.setServiceTax(stax);
			menuItems.setVeg(type);
			menuItems.setSpicy(spicy);
			menuItems.setPromotionFlag(promo);
			menuItems.setPromotionDesc(promodesc);
			menuItems.setPromotionValue(promovalue);
			menuItems.setStoreId(customer.getStoreId());
			menuItems.setCookingTimeInMins(cookingtime);
			menuItems.setProduction(production);
			menuItems.setUnit(unit);
			menuItems.setSpotDiscount(spotDisc);
			menuItems.setCode(itemcode);
			menuItems.setPurchasePrice(purchaseRate);
			String res = menumgntService.editMenuItems(menuItems);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService
					.getAllMenuList(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
	}*/
	
	@RequestMapping(value="/addmenuitems",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String menuItemString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addMenuItems......{}",menuItemString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");	
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(menuItemString, new TypeToken<MenuItems>() {
			}.getType());
			menuItem.setStoreId(customer.getStoreId());
			String res=menumgntService.addMenuItems(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
			/*Locale locale = LocaleContextHolder.getLocale();
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService.getAllMenuList(customer.getStoreId(),locale.getDisplayLanguage());
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);*/
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService
					.getAllMenuList(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
	}
	@RequestMapping(value="/editmenuitems",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String menuItemEditString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editmenuitems......{}",menuItemEditString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(menuItemEditString, new TypeToken<MenuItems>() {
			}.getType());
			
			//MenuItems menuItems=new MenuItems();
			//menuItems.setStoreId(customer.getStoreId());
			String res=menumgntService.editMenuItems(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
			/*Locale locale = LocaleContextHolder.getLocale();
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService.getAllMenuList(customer.getStoreId(),locale.getDisplayLanguage());
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);*/
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService
					.getAllMenuList(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
	}
	
	@RequestMapping(value = "/deletemenuitems/{subcatId}/{id}",
					method = RequestMethod.GET)
	public void deleteMenuItems(@PathVariable("subcatId") int subcatId,
								@PathVariable("id") int id,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In deletemenuitems......{},{}", subcatId, id);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			MenuCategory menuCategory = new MenuCategory();
			menuCategory.setId(subcatId);
			MenuItems menuItems = new MenuItems();
			menuItems.setId(id);
			menuItems.setMenucategory(menuCategory);

			menuItems.setStoreId(customer.getStoreId());
			String res = menumgntService.deleteMenuItems(menuItems);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
			session.removeAttribute(Constants.MENU_ALL_TREE);
			Menu allMenuList = menuService
					.getAllMenuList(customer.getStoreId(),session);
			session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
	}

	@RequestMapping(value = "/getsubcategorylistbycategory/{catid}",
					method = RequestMethod.GET)
	public void deleteMenuItems(@PathVariable("catid") int catid,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In getsubcategorylistbycategory......{}", catid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menumgntService.getMenuSubCategoryListByStoreId(customer.getStoreId(), catid));
			out.flush();
		}
	}

	@RequestMapping(value = "/autocomplete",
					method = RequestMethod.GET)
	public List<MenuItems> getAutocompleteList(	@RequestParam String tagName,
												HttpSession session,
												HttpServletResponse response) throws IOException

	{
		System.out.println("in autocomplete.." + tagName);
		MenuCategory menuCategory = (MenuCategory) session.getAttribute("categoryTree");
		List<MenuItems> itemList = new ArrayList<MenuItems>();
		List<MenuCategory> allMenuCat = menuCategory.getMenucategory();
		Iterator<MenuCategory> allMenuCatItr = allMenuCat.iterator();
		while (allMenuCatItr.hasNext()) {
			MenuCategory submenuCat = allMenuCatItr.next();
			List<MenuCategory> allsubMenuCat = submenuCat.getMenucategory();
			Iterator<MenuCategory> allsubMenuCatItr = allsubMenuCat.iterator();
			while (allsubMenuCatItr.hasNext()) {
				MenuCategory menuItems = allsubMenuCatItr.next();
				List<MenuItems> allItems = menuItems.getItems();
				Iterator<MenuItems> allitemCatItr = allItems.iterator();
				while (allitemCatItr.hasNext()) {
					MenuItems items = allitemCatItr.next();
					items.setMenucatId(submenuCat.getId());
					items.setMenucatName(submenuCat.getMenuCategoryName());
					items.setSubmenucatId(menuItems.getId());
					items.setSubmenucatName(menuItems.getMenuCategoryName());
					itemList.add(items);
					//System.out.println("menu Items :"+items);
				}
			}
		}
		System.out.println("menu Items List size:" + itemList);
		session.setAttribute("totalitemList", itemList);
		List<MenuItems> newItemList = new ArrayList<MenuItems>();
		for (MenuItems items : itemList) {
			if (StringUtils.startsWithIgnoreCase(items.getName(), tagName)) {
				newItemList.add(items);
			}
		}
		System.out.println("menu Items List :" + newItemList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		out.print(gson.toJson(newItemList));
		return null;
	}

	@RequestMapping(value = "/loadmenuitemsbyid",
					method = RequestMethod.GET)
	public ModelAndView loadMenuItemsById(	@RequestParam int itemid,
											HttpSession session) {
		logger.debug("in loadmenuitemsbyid...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuItems> itemList = (List<MenuItems>) session.getAttribute("totalitemList");
		for (MenuItems items : itemList) {
			if (items.getId() == itemid) {
				mav.addObject("singleMenuItem", items);
			}
		}
		List<MenuCategory> menuCatList = (List<MenuCategory>) session.getAttribute("sescategoryList");
		//MenuCategory menuCategory=(MenuCategory) session.getAttribute("categoryTree");
		//mav.addObject("allmenuTreeforSingle",menuCategory);
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		MenuCategory menucategory = null;
		menucategory = menuCatList.get(0);
		List<MenuCategory> menusubcategoryList = menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(), menucategory.getId());
		List<FmcgUnit> fmcgList = menumgntService.getFmcgUnitByStoreId(customer.getStoreId());
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		mav.addObject("menucatList", menuCatList);
		mav.addObject("menusubcatList", menusubcategoryList);
		mav.addObject("fmcgList", fmcgList);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_PAGE);

		return mav;
	}

	@RequestMapping(value = "/loadspecialnotes",
					method = RequestMethod.GET)
	public ModelAndView loadSpecialNotes(	@RequestParam String itemid,
											@RequestParam String itemname,
											HttpSession session) {
		logger.debug("in loadspecialnotes...{},{} ", itemid, itemname);
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		MenuCategory menuCategory = menumgntService.getAllSplNoteTree(customer.getStoreId(), NumberUtils.toInt(itemid));
		mav.addObject("allsplnoteTree", menuCategory);
		mav.addObject("itemidforspnote", itemid);
		mav.addObject("itemnameforspnote", itemname);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_SPECIAL_NOTE_PAGE);
		return mav;
	}

	@RequestMapping(value = "/addspecialnote/{itemid}/{spnotearr}",
					method = RequestMethod.GET)
	public void addSpecialNote(	@PathVariable("itemid") String itemid,
								@PathVariable("spnotearr") String[] spnotearr,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In addspecialnote......{},{}", itemid, spnotearr.toString());
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<MenuItemNotes> menuitemnoteList = new ArrayList<MenuItemNotes>();
			for (int i = 0; i < spnotearr.length; i++) {
				MenuItemNotes itemNotes = new MenuItemNotes();
				MenuItems menuItem = new MenuItems();
				menuItem.setId(NumberUtils.toInt(spnotearr[i]));
				itemNotes.setStoreId(customer.getStoreId());
				itemNotes.setFoodItemIds(NumberUtils.toInt(itemid));
				itemNotes.setMenuItem(menuItem);
				menuitemnoteList.add(itemNotes);
			}
			SpecialNoteListContainer splnotelistContainer = new SpecialNoteListContainer();
			splnotelistContainer.setMenuItemNotes(menuitemnoteList);
			splnotelistContainer.setItemId(NumberUtils.toInt(itemid));
			splnotelistContainer.setStoreId(customer.getStoreId());

			String res = menumgntService.addSpecialNote(splnotelistContainer);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/getallinstalledprinters",
					method = RequestMethod.GET)
	public void getallInstalledPrinters(HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("In getallinstalledprinters......{}");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menumgntService.getInstalledPrinters());
			out.flush();
		}
	}

	@RequestMapping(value = "/assignkotprinter/{cuisineid}/{printerloc}/{printername}/{kitchenname}",
					method = RequestMethod.GET)
	public void assignKotPrinters(	@PathVariable("cuisineid") int cuisineid,
									@PathVariable("printerloc") String printerloc,
									@PathVariable("printername") String printername,
									@PathVariable("kitchenname") String kitchenname,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In assignkotprinter......{},{},{},{}", cuisineid, printerloc, printername, kitchenname);
		printerloc = StringUtils.replace(printerloc, "|", "\\");
		System.out.println("printerloc:" + printerloc);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			PrintKotMaster kotMaster = new PrintKotMaster();
			kotMaster.setPrinterIp(printerloc);
			kotMaster.setCuisineTypeId(cuisineid);
			kotMaster.setName(printername);
			kotMaster.setKitchenLocation(kitchenname);
			kotMaster.setStoreId(customer.getStoreId());
			String res = menumgntService.assignPrinter(kotMaster);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	@RequestMapping(value = "/getallserverprinters",
					method = RequestMethod.GET)
	public void getallSeverPrinters(HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("In getallserverprinters......{}");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menumgntService.getAllServerPrinters(customer.getStoreId()));
			out.flush();
		}
	}

	@RequestMapping(value = "/assignkotprintertoitem/{itemid}/{printerloc1}/{printerloc2}/{printerloc3}",
					method = RequestMethod.GET)
	public void assignKotPrintersToItem(@PathVariable("itemid") int itemid,
										@PathVariable("printerloc1") String printerloc1,
										@PathVariable("printerloc2") String printerloc2,
										@PathVariable("printerloc3") String printerloc3,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("In assignkotprintertoitem......{},{},{},{}", itemid, printerloc1, printerloc2, printerloc3);

		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String printerList = "";
			printerList = printerloc1 + "~" + printerloc2 + "~" + printerloc3;
			System.out.println("printerList:" + printerList);
			//String res="success";
			String res = menumgntService.assignPrinterToItem(itemid, printerList);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	/*@RequestMapping(value="/assignkotprinter",method=RequestMethod.POST)
	public void assignKotPrinters(@ModelAttribute("printKotMaster") PrintKotMaster prinMaster,HttpSession session,HttpServletResponse response) throws IOException
	{
		//logger.debug("In assignkotprinter......{},{},{},{}",cuisineid,printerloc,printername,kitchenname);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			PrintKotMaster kotMaster=new PrintKotMaster();
			kotMaster.setPrinterIp(prinMaster.getPrinterIp());
			kotMaster.setCuisineTypeId(prinMaster.getCuisineTypeId());
			kotMaster.setName(prinMaster.getName());
			kotMaster.setKitchenLocation(prinMaster.getKitchenLocation());
			kotMaster.setStoreId(customer.getStoreId());
			String res=menumgntService.assignPrinter(kotMaster);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	@RequestMapping(value = "/viewmenuitemupload",
					method = RequestMethod.GET)
	public ModelAndView loadMenuItemUpload(	Model model,
											HttpSession session) {
		logger.debug("In viewmenuitemupload......");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_UPLOAD_MENU_ITEM_PAGE);
		return mav;
	}

	@RequestMapping(value = "/uploadmenuitem",
					method = RequestMethod.POST)
	public ModelAndView uploadMenuItem(	@RequestParam MultipartFile fileUpload,
										HttpSession session,
										HttpServletResponse response,
										HttpServletRequest request) {
		logger.debug("in uploadmenuitem...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		InputStream inputFile = null;
		byte[] byteArr = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		if (fileUpload != null && fileUpload.getSize() > 0) {
			try {
				System.out.println("file name:" + fileUpload.getName());
				System.out.println("original file name:" + fileUpload.getOriginalFilename());
				System.out.println("file size:" + fileUpload.getSize());
				inputFile = fileUpload.getInputStream();
				byteArr = fileUpload.getBytes();
				System.out.println("inputsterm:" + inputFile);
				System.out.println("byte arr:" + byteArr);
				String uploadsDir = "/uploads/";
				String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
				if (!new File(realPathtoUploads).exists()) {
					new File(realPathtoUploads).mkdir();
				}

				System.out.println("path:" + realPathtoUploads);
				String orgName = fileUpload.getOriginalFilename();
				String filePath = realPathtoUploads + "/" + orgName;
				File dest = new File(filePath);
				fileUpload.transferTo(dest);

				MenuFile menuFile = new MenuFile();
				menuFile.setStoreId(customer.getStoreId());
				menuFile.setFileName(fileUpload.getOriginalFilename());

				FileDataBodyPart filePart = new FileDataBodyPart("file", new File(filePath));
				filePart.setContentDisposition(FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
				MultiPart multipartEntity = new FormDataMultiPart().field("menuFile", new Gson().toJson(menuFile), MediaType.APPLICATION_JSON_TYPE).bodyPart(filePart);

				String res = menumgntService.uploadMenuItems(menuFile, multipartEntity);
				System.out.println("result:" + res);
				//inputFile.close();
			} catch (Exception e) {
				logger.error("File uploading problem: ", e);
			}
		} else {

		}
		mav.setViewName(ForwardConstants.VIEW_UPLOAD_MENU_ITEM_PAGE);
		return mav;
	}

	@RequestMapping(value = "/uploadmenuitemimage",
					method = RequestMethod.POST)
	public String uploadMenuItemImage(	@RequestParam MultipartFile fileUpload,
										@RequestParam String imageName,
										@RequestParam String imageitemid,
										HttpSession session,
										HttpServletResponse response,
										HttpServletRequest request) {
		logger.debug("in uploadmenuitemimage...! ");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		InputStream inputFile = null;
		byte[] byteArr = null;
		BufferedImage bufferedImage;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			//			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			//			return mav;
		}
		if (fileUpload != null && fileUpload.getSize() > 0) {
			try {
				System.out.println("file name:" + fileUpload.getName());
				System.out.println("original file name:" + fileUpload.getOriginalFilename());
				System.out.println("original file getContentType:"+fileUpload.getContentType());
				System.out.println("file size:" + fileUpload.getSize());
				System.out.println("imageName:" + imageName);
				System.out.println("imageitemid:" + imageitemid);
				inputFile = fileUpload.getInputStream();
				byteArr = fileUpload.getBytes();
				
				System.out.println("inputsterm:" + inputFile);
				System.out.println("byte arr:" + byteArr);
				
				String orgName = fileUpload.getOriginalFilename();
				
//				if(!fileUpload.getContentType().equals("png")){
//					orgName=orgName.replace(".", ",");
//					String[] forgName=orgName.split(",");
//					String orgNameNew=forgName[0]+".png";
//					System.out.println("orgNameNew:" + orgNameNew);
//					orgName=orgNameNew;
//				}
				System.out.println("orgName="+orgName);
				String uploadsDir = "/uploads/";
				String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
				if (!new File(realPathtoUploads).exists()) {
					new File(realPathtoUploads).mkdir();
				}

				System.out.println("path:" + realPathtoUploads);
				String filePath = realPathtoUploads + "/" + orgName;
				
//				//read image file
//				bufferedImage = ImageIO.read(new File(filePath));
//				// create a blank, RGB, same width and height, and a white background
//				BufferedImage newBufferedImage = new BufferedImage(bufferedImage.getWidth(), bufferedImage.getHeight(), BufferedImage.TYPE_INT_RGB);
//				newBufferedImage.createGraphics().drawImage(bufferedImage, 0, 0, Color.WHITE, null);
//
//				// write to jpeg file
//				ImageIO.write(newBufferedImage, "PNG", new File(filePath));
				File dest = new File(filePath);
				fileUpload.transferTo(dest);

				/*FileDataBodyPart filePart = new FileDataBodyPart("inputStream", new File(filePath));
				filePart.setContentDisposition(FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
				MultiPart multipartEntity = new FormDataMultiPart().field("itemId", imageitemid).field("fileName", fileUpload.getOriginalFilename()).bodyPart(filePart);
				String res = menumgntService.uploadMenuItemImage(imageitemid, imageName, multipartEntity);*/
				MenuFile menuFile = new MenuFile();
				menuFile.setStoreId(customer.getStoreId());
				menuFile.setFileName(fileUpload.getOriginalFilename());
				menuFile.setId(Integer.parseInt(imageitemid));
				FileDataBodyPart filePart = new FileDataBodyPart("file", new File(filePath));
				filePart.setContentDisposition(FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
				MultiPart multipartEntity = new FormDataMultiPart().field("menuFile", new Gson().toJson(menuFile), MediaType.APPLICATION_JSON_TYPE).bodyPart(filePart);
				String res = menumgntService.uploadMenuItemImage(menuFile, multipartEntity);
				System.out.println("result:" + res);

			} catch (Exception e) {
				logger.error("File uploading problem: ", e);
			}
		}
		//		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_PAGE);
		return "redirect:/menumgnt/loadmenuitems.htm";
	}

	@RequestMapping(value = "/getimagebyitemid",
					method = RequestMethod.GET)
	public void getImageByItemid(	HttpSession session,
									HttpServletResponse response,
									@RequestParam String itemId,
									HttpServletRequest request) throws IOException {
		logger.debug("In getimagebyitemid......{}");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res = menumgntService.getMenuItemImage(Integer.valueOf(itemId));
			System.out.println("res=" + res);
			out.print(res);
			out.flush();
		}
	}
}
