package com.sharobi.webpos.adm.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.ServiceChargesFortAllItems;
import com.sharobi.webpos.adm.model.TaxesForAllItems;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;



public class ServiceChargeMgntService {
 private final static Logger logger=LogManager.getLogger(ServiceChargeMgntService.class);
 private final static Gson gson=new Gson();
 public String updateServiceChargeOrderType(List<ServiceChargesFortAllItems> serviceCharge)
 {
  try{
   String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_SERVICECHARGE_ORDERTYPE_UPDATE);
   logger.debug("url....{}",url);
   //System.out.println("serviceCharge<><>" + gson.toJson(serviceCharge));
   ClientResponse response=WebServiceClient.callPost(url,gson.toJson(serviceCharge));
   String responseString=response.getEntity(String.class);
   logger.debug("response string...{}",responseString);
   return responseString;
  }
  catch(Exception ex)
  {
   logger.debug("Exception",ex);
   return null; 
  }
 }

}