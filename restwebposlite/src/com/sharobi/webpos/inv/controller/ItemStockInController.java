package com.sharobi.webpos.inv.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.inv.model.FgItemCurrentStock;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.service.FGStockinService;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.FgStockIn;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/itemstockin")
public class ItemStockInController {
  private final static Logger logger = LogManager.getLogger(ItemStockInController.class);
  private final static FGStockinService fgStockinService = new FGStockinService();
  private final static MenuMgntService menumgntService =new MenuMgntService();
  private final static MenuService menuService =new MenuService();
  private final static InventoryService inventoryService = new InventoryService();

  @RequestMapping(value = "/loaditemstockin",
          method = RequestMethod.GET)
  public ModelAndView loadRecipeIngredients( 
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
	      List<FgStockIn> itemList = fgStockinService.getSimpleFgStockinByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
	      mav.addObject("itemLists", itemList);
	      List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
	      MenuCategory menucategory = null;
	      menucategory=menucategoryList.get(0);
	      List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
	      mav.addObject("menucategoryList", menucategoryList);
	      mav.addObject("menusubcategoryList", menusubcategoryList);
	      List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		  logger.debug("Fetched vendorList :: {}", vendorList);
		  mav.addObject("vendorList", vendorList);
	      mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
	      mav.setViewName(ForwardConstants.VIEW_ITEMSTOCK_PAGE);
	      return mav;
    }
  }

  
 
  @RequestMapping(value="/menuitemdata/{menuid}",method=RequestMethod.GET)
  public void getMenuItems(@PathVariable("menuid") int menuid,HttpSession session,HttpServletResponse response) throws IOException
  {
    logger.debug("In get items......{}",menuid);
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Menu menu=(Menu) session.getAttribute(Constants.MENU_ALL_TREE);
      List<MenuItem> menuItem=menuService.getMenuItems(menu,menuid);
      Gson gson = new GsonBuilder().create();
      out.print(gson.toJson(menuItem));
      out.flush();
    }
  }
  
  @RequestMapping(value="/getfgcurrentstock/{itemid}",method=RequestMethod.GET)
  public void getCurrentStockItems(@PathVariable("itemid") int itemid,HttpSession session,HttpServletResponse response) throws IOException
  {
    logger.debug("In get items......{}",itemid);
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Gson gson = new GsonBuilder().create();
      out.print(gson.toJson(fgStockinService.getFgItemCurrentStock(customer.getStoreId(),itemid)));
      out.flush();
    }
  }
  
  
  
  @RequestMapping(value = "/getsimplefgstockinbystoreidandid",method = RequestMethod.GET)
  public ModelAndView getEstimateDailyProdByStoreIdAndId(@RequestParam("stockinId") String stockinId, Model model,HttpSession session,HttpServletResponse response) throws IOException {
    
    ModelAndView mav = new ModelAndView();
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    } else {
      FgStockIn fgSimpleStockListitem=fgStockinService.getSimpleFgStockInDataByStoreIdAndId(customer.getStoreId(), stockinId);
      PrintWriter out = response.getWriter();
      response.setContentType("application/json");
      out.print(new Gson().toJson(fgSimpleStockListitem));
      return null;
    }
  }
  
  
  @RequestMapping(value = "/getsimplefgstockinbydateandstoreid",method = RequestMethod.POST)
 public ModelAndView getrequisitionbydateandstoreid( @ModelAttribute("estimateDailyProd") EstimateDailyProd estimateDailyProd,
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
        List<FgStockIn> itemList = fgStockinService.getSimpleFgStockinByDate(customer.getStoreId(), estimateDailyProd.getDate());
        mav.addObject("itemLists", itemList);
        mav.addObject("today", date);
        List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
        MenuCategory menucategory = null;
        menucategory=menucategoryList.get(0);
        List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
        mav.addObject("menucategoryList", menucategoryList);
        mav.addObject("menusubcategoryList", menusubcategoryList);
        List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
		logger.debug("Fetched vendorList :: {}", vendorList);
		mav.addObject("vendorList", vendorList);
        mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
        mav.setViewName(ForwardConstants.VIEW_ITEMSTOCK_PAGE);
        return mav;
      }
      }

  @RequestMapping(value = "/createnewfgstockin",
          method = RequestMethod.POST)
  public void createNewFgStockin( @RequestBody String fgstockin,
                  HttpSession session,
                  HttpServletResponse response) throws IOException {
    logger.debug("in createnewfgstockin...{}", fgstockin);
    Customer customer;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      Date currDate = new Date();
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Gson gson = new Gson();
      FgStockIn fgStockIn2 = gson.fromJson(fgstockin, new TypeToken<FgStockIn>() {}.getType());
      fgStockIn2.setDate(currDate);
      logger.info("ID IS:::"+fgStockIn2.getId());
      String s="";
      if(fgStockIn2.getId()==0){
       s=fgStockinService.createSimpleFGStockin(fgStockIn2);
      }
      else{
         s=fgStockinService.updateSimpleFGStockin(fgStockIn2);
      }
      out.print(s);
      out.flush();
    }
  }

  
  
  
  @RequestMapping(value = "/approvedFGStockin",
          method = RequestMethod.GET)
  public ModelAndView approvedPO( @RequestParam String storeId,
                  @RequestParam String fgstockinid,
                  @RequestParam String approveBy,
                  Model model,
                  HttpSession session,
                  HttpServletRequest request,
                  HttpServletResponse response) throws IOException {
    logger.debug("In approvedFGStockin......{},{},{}", storeId, fgstockinid, approveBy);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    PrintWriter out = response.getWriter();
    response.setContentType("application/json");
    fgStockinService.approveFgStockin(storeId, fgstockinid, approveBy);
    out.print("success");
    out.flush();
    return null;
  }
  
  @RequestMapping(value = "/deletesimplestockinbyid/{selectedstockinid}", method = RequestMethod.GET)
  public ModelAndView deleteStockinById(@PathVariable("selectedstockinid") String selectedstockinid, Model model, HttpSession session,
      HttpServletRequest request, HttpServletResponse response) {
    logger.debug("In deleteSimpleStockin by stockinid......{}", selectedstockinid);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    try {
      String wsResponse = fgStockinService.deleteSimpleStockinById(selectedstockinid, customer.getStoreId());
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
  
  
  
 @RequestMapping(value = "/stockinfo",method = RequestMethod.GET)
public ModelAndView loadSimpleStockDisplay(  Model model,
                    HttpSession session) {

    ModelAndView mav = new ModelAndView();
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    } else {
      List<FgItemCurrentStock> itemList= fgStockinService.getFgItemCurrentStock(customer.getStoreId(),0);
      mav.addObject("itemLists", itemList);
      mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
      mav.setViewName(ForwardConstants.VIEW_ITEMSTOCKDISPLAY_PAGE);
      return mav;
    }
}
	 
 
}

