package com.sharobi.webpos.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.service.UnpaidOrderService;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class AdminUnpaidOrderService {

	private final static Logger logger=LogManager.getLogger(UnpaidOrderService.class);
	private final static Gson gson=new Gson();
	
	public List<Order> getAllUnpaidOrderList(int storeId,String toDay)
	 {
	  List<Order> allUnpaidOrderList=new ArrayList<Order>();
	  try{
	   logger.debug("Input [store id] [to day date]: {},{}",storeId,toDay);
	   String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(toDay));
	   logger.debug("url....{}",url);
	   ClientResponse response=WebServiceClient.callGet(url);
	   String responseString=response.getEntity(String.class);
	   logger.debug("Response string in get unpaid orderlist list: {}", responseString);
	   allUnpaidOrderList=gson.fromJson(responseString, new TypeToken<List<Order>>() {}.getType());
	   logger.debug("all unpaid order List fetched: {}", allUnpaidOrderList);
	   return allUnpaidOrderList;
	  }catch(Exception ex)
	  {
	   logger.debug("Exception",ex);
	   return null;
	  }
	 }	
	public List<Order> getAllUnpaidOrderListPeriodWise(int storeId,String fromDay,String toDay)
	 {
	  List<Order> allUnpaidOrderList=new ArrayList<Order>();
	  try{
	   logger.debug("Input [store id] [to day date]: {},{}",storeId,toDay);
	   String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYPERIOD).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(fromDay)).replace("{3}", String.valueOf(toDay));
	   logger.debug("url....{}",url);
	   ClientResponse response=WebServiceClient.callGet(url);
	   String responseString=response.getEntity(String.class);
	   logger.debug("Response string in get unpaid orderlist list: {}", responseString);
	   allUnpaidOrderList=gson.fromJson(responseString, new TypeToken<List<Order>>() {}.getType());
	   logger.debug("all unpaid order List fetched: {}", allUnpaidOrderList);
	   return allUnpaidOrderList;
	  }catch(Exception ex)
	  {
	   logger.debug("Exception",ex);
	   return null;
	  }
	 }
}