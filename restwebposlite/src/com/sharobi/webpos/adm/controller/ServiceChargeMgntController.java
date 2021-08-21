package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ServiceChargesFortAllItems;
import com.sharobi.webpos.adm.model.TaxesForAllItems;
import com.sharobi.webpos.adm.service.ServiceChargeMgntService;
import com.sharobi.webpos.adm.service.TaxMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.base.service.OrderService;

@Controller
@RequestMapping("/servicecharge")
public class ServiceChargeMgntController {
 
 private final static OrderService orderService = new OrderService();
 private final static Logger logger=LogManager.getLogger(TaxMgntController.class);
 private final static ServiceChargeMgntService serviceChargeService=new ServiceChargeMgntService();
 
 @RequestMapping(value="/viewservicecharge",method=RequestMethod.GET)
 public ModelAndView loadTaxMgnt(Model model,HttpSession session)
 {
  logger.debug("In viewservicecharge......");
  ModelAndView mav = new ModelAndView();
  Customer customer=null;
  if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
  {
   mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
   return mav;
  }
  
  List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
  if (orderTypeList.size() > 0) {

   mav.addObject("orderTypeList", orderTypeList);
  }
  
  mav.addObject(Constants.ADMIN,"Y");
  mav.setViewName(ForwardConstants.VIEW_SERVICE_CHARGE_PAGE);
  return mav;
 }
 
 
 @RequestMapping(value = "/getOrderType",
   method = RequestMethod.GET)
 public void getOrderType( 
        HttpSession session,
        HttpServletResponse response) throws IOException {

  Customer customer;
  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
   PrintWriter out = response.getWriter();
   response.setContentType("text/plain");
   Gson gson = new Gson();
 
   List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
   out.print(gson.toJson(orderTypeList));
   out.flush();
  }
 }
 
 
 
 @RequestMapping(value="/updateservicecharge",method=RequestMethod.POST)
 public void updateServiceCharge(@RequestBody List<ServiceChargesFortAllItems> serviceChargeString ,HttpSession session,HttpServletResponse response) throws IOException
 {
  logger.debug("In updatetaxforallitem......{},{},{},{}",serviceChargeString);
  
  System.out.println("serviceChargeString>>" + serviceChargeString);
  Customer customer=null;
  if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
  {
   PrintWriter out = response.getWriter();
   response.setContentType("text/plain");

//   Gson gson = new GsonBuilder().create();
//   List<ServiceChargesFortAllItems> orderTypeObj =gson.fromJson(serviceChargeString, new TypeToken<ServiceChargesFortAllItems>() {
//   }.getType());

   String res=serviceChargeService.updateServiceChargeOrderType(serviceChargeString);
   System.out.println("res:"+res);
   out.print(res);
   out.flush();
  }
 }
 
 
}