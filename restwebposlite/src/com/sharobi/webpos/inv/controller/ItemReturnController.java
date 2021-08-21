package com.sharobi.webpos.inv.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.ReturnTypes;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.service.FGStockinService;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.ItemReturnService;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.FgReturn;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/itemreturn")
public class ItemReturnController {
	  private final static Logger logger = LogManager.getLogger(ItemReturnController.class);
	  private final static FGStockinService fgStockinService = new FGStockinService();
	  private final static MenuMgntService menumgntService =new MenuMgntService();
	  private final static MenuService menuService =new MenuService();
	  private final static InventoryService inventoryService = new InventoryService();
	  private final static OrderService orderService = new OrderService();
	  private final static ItemReturnService itemReturnService = new ItemReturnService();
	  
	  @RequestMapping(value = "/loaditemreturn",method = RequestMethod.GET)
	  public ModelAndView loadItemReturn( 
			  				Model model,
	                        HttpSession session) {

	    ModelAndView mav = new ModelAndView();
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
		      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		      return mav;
	    } else {
		      Date currDate = new Date();
		      mav.addObject("today", currDate);
		      List<FgReturn> returnItemList = itemReturnService.getSimpleFgStockReturnByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		      mav.addObject("itemLists", returnItemList);
		      List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
		      MenuCategory menucategory = null;
		      menucategory=menucategoryList.get(0);
		      List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
		      List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		      List < ReturnTypes > returntypelist = orderService.getAllReturntypes(customer.getStoreId());
			  List < ReturnTypes > filteredreturntypelist = new ArrayList < ReturnTypes > ();
			
			  for (ReturnTypes ob: returntypelist) {
			       if (ob.getType().equals("PUR")) {
			           filteredreturntypelist.add(ob);
			           }
			     }
			  mav.addObject("reasons", filteredreturntypelist);
			  mav.addObject("reasonslist", new Gson().toJson(filteredreturntypelist).toString());
			  mav.addObject("menucategoryList", menucategoryList);
		      mav.addObject("menusubcategoryList", menusubcategoryList);
		      mav.addObject("vendorList", vendorList);
		      mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		      mav.setViewName(ForwardConstants.VIEW_ITEMRETURN_PAGE);
		      return mav;
	    }
	  }
	  
	  @RequestMapping(value = "/createorupdatefgstockout",
	          method = RequestMethod.POST)
	  public void createOrUpdateNewFgStockReturn( @RequestBody String fgStockReturn,
	                  HttpSession session,
	                  HttpServletResponse response) throws IOException {
	    logger.debug("in createOrUpdateNewFgStockReturn...{}", fgStockReturn);
	    Customer customer;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	      Date currDate = new Date();
	      PrintWriter out = response.getWriter();
	      response.setContentType("text/plain");
	      Gson gson = new Gson();
	      FgReturn fgReturn = gson.fromJson(fgStockReturn, new TypeToken<FgReturn>() {}.getType());
	      logger.info("ID IS:::"+fgReturn.getId());
	      String s="";
	      if(fgReturn.getId()==0){
	    	  s=itemReturnService.createSimpleFGStockin(fgReturn);
	      }
	      else{
	         s=itemReturnService.updateSimpleFGStockin(fgReturn);
	      }
	      out.print(s);
	      out.flush();
	    }
	  }
  
	  
	  @RequestMapping(value = "/getfgstockreturnbyid",method = RequestMethod.GET)
	  public ModelAndView getSimpleFgStockReturnById(@RequestParam("stockReturnId") String stockReturnId, Model model,HttpSession session,HttpServletResponse response) throws IOException {
	    
	    ModelAndView mav = new ModelAndView();
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    } else {
	    	FgReturn fgSimpleStockReturn=itemReturnService.getSimpleFgStockReturnDataByStoreIdAndId(customer.getStoreId(), stockReturnId);
	      PrintWriter out = response.getWriter();
	      response.setContentType("application/json");
	      out.print(new Gson().toJson(fgSimpleStockReturn));
	      return null;
	    }
	  }
	  
	  @RequestMapping(value = "/getfgstockreturnbydate",method = RequestMethod.POST)
	  public ModelAndView getSimpleFgStockReturnByDate( @ModelAttribute("estimateDailyProd") EstimateDailyProd estimateDailyProd,
	                               Model model,
	                               HttpSession session) {
	       System.out.println("estimateDailyProd.getDate()=" + estimateDailyProd.getDate());
	       ModelAndView mav = new ModelAndView();
	       Customer customer = null;
	       String pattern = "yyyy-MM-dd";
	       Date date = null;
	       SimpleDateFormat format = new SimpleDateFormat(pattern);
	       try {
	         date = format.parse(estimateDailyProd.getDate());
	         System.out.println(date);
	       } catch (ParseException e) {
	         e.printStackTrace();
	       }
	       if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	         mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
	         return mav;
	       } else {
	         List<FgReturn> returnItemList = itemReturnService.getSimpleFgStockReturnByDate(customer.getStoreId(), estimateDailyProd.getDate());
	         mav.addObject("itemLists", returnItemList);
	         mav.addObject("today", date);
	        /* List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
	         MenuCategory menucategory = null;
	         menucategory=menucategoryList.get(0);
	         List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
	         mav.addObject("menucategoryList", menucategoryList);
	         mav.addObject("menusubcategoryList", menusubcategoryList);*/
	         List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
	 		 logger.debug("Fetched vendorList :: {}", vendorList);
	 		 mav.addObject("vendorList", vendorList);
	 		  List < ReturnTypes > returntypelist = orderService.getAllReturntypes(customer.getStoreId());
			  List < ReturnTypes > filteredreturntypelist = new ArrayList < ReturnTypes > ();
			
			  for (ReturnTypes ob: returntypelist) {
			       if (ob.getType().equals("PUR")) {
			           filteredreturntypelist.add(ob);
			           }
			     }
			  mav.addObject("reasons", filteredreturntypelist);
			  mav.addObject("reasonslist", new Gson().toJson(filteredreturntypelist).toString());
	         mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
	         mav.setViewName(ForwardConstants.VIEW_ITEMRETURN_PAGE);
	         return mav;
	       }
	       }
	  
	  @RequestMapping(value = "/approvedFGStockReturn",
	          method = RequestMethod.GET)
	  public ModelAndView approveSimpleFgReturn( @RequestParam String storeId,
	                  @RequestParam String fgstockreturnid,
	                  @RequestParam String approveBy,
	                  @RequestParam String vendorId,
	                  Model model,
	                  HttpSession session,
	                  HttpServletRequest request,
	                  HttpServletResponse response) throws IOException {
	    logger.debug("In approveSimpleFgReturn......{},{},{},{}", storeId, fgstockreturnid, approveBy ,vendorId);
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    }
	    PrintWriter out = response.getWriter();
	    response.setContentType("application/json");
	    FgReturn obj = new FgReturn();
	    obj.setId(Integer.parseInt(fgstockreturnid));
	    obj.setStoreId(customer.getStoreId());
	    obj.setVendorId(Integer.parseInt(vendorId));
	    String responsedata = itemReturnService.approveFgStockReturn(obj);
	    out.print("success");
	    out.flush();
	    return null;
	  }
	  	  
	  @RequestMapping(value = "/deletestockreturnbyid/{selectedstockreturnid}", method = RequestMethod.GET)
	  public ModelAndView deleteStockReturnById(@PathVariable("selectedstockreturnid") String selectedstockreturnid, Model model, HttpSession session,
	      HttpServletRequest request, HttpServletResponse response) {
	    logger.debug("In deleteStockReturnById......{}", selectedstockreturnid);
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
	    }
	    try {
	      String wsResponse = itemReturnService.deleteSimpleStockReturnById(selectedstockreturnid, customer.getStoreId());
	      logger.debug("Response : " + wsResponse);
	      PrintWriter out;
	      out = response.getWriter();
	      response.setContentType("text/plain");
	      out.print(wsResponse);
	      out.flush();
	      return null;
	    } catch (IOException e) {
	      return null;
	    }

	  }  

}
