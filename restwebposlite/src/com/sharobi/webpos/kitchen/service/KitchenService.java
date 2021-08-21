/**
 * 
 */
package com.sharobi.webpos.kitchen.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;


/**
 * @author habib
 *
 */
public class KitchenService {
	private final static Logger logger=LogManager.getLogger(KitchenService.class);
	private final static Gson gson=new Gson();
	
	public List<OrderItem> getKitchenItem(int storeId,String date)
	{
		List<OrderItem> kitchenitemList=new ArrayList<OrderItem>();
		try{
			logger.debug("Input [store id],date: {},{}", storeId,date);
			ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_KITCHEN_GETKITCHENITEM).replace("{1}", String.valueOf(storeId)).replace("{2}",date));
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get all kitchen item list: {}", responseString);
			kitchenitemList=gson.fromJson(responseString, new TypeToken<List<OrderItem>>() {}.getType());
			return kitchenitemList;
			}catch (Exception e) {
				logger.debug("Exception:",e);
				return null;
			}
	}
	public String addCookingStartTime(int orderid,int orderitemid,String startTime)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_KITCHEN_COOKING_START).replace("{1}", String.valueOf(orderid)).replace("{2}",String.valueOf(orderitemid)).replace("{3}",startTime);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in addCookingStartTime: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception:",ex);
			return null;
		}
	}
	public String addCookingEndTime(int orderid,int orderitemid,String endTime)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_KITCHEN_COOKING_END).replace("{1}", String.valueOf(orderid)).replace("{2}",String.valueOf(orderitemid)).replace("{3}",endTime);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in addCookingEndTime: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception:",ex);
			return null;
		}
	}
	public String updateKitchenOut(int orderid,int orderitemid)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_KITCHEN_OUT).replace("{1}", String.valueOf(orderid)).replace("{2}", String.valueOf(orderitemid));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in updateKitchenOut: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception:",ex);
			return null;
		}
	}

}
