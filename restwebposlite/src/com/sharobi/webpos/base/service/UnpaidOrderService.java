/**
 * 
 */
package com.sharobi.webpos.base.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
import com.sharobi.webpos.base.model.OrderItem;


/**
 * @author habib
 *
 */
public class UnpaidOrderService {
	private final static Logger logger=LogManager.getLogger(UnpaidOrderService.class);
	private final static Gson gson=new Gson();
	
	public List<Order> getAllUnpaidOrderList(int storeId,String toDay)
	{
		List<Order> allUnpaidOrderList=new ArrayList<Order>();
		try{
			logger.debug("Input [store id] [to day date]: {},{}",storeId,toDay);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_GETUNPAIDORDERLIST).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(toDay));
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
	
	public String getUnpaidOrderById(int orderId)
	{
		
		try{
			logger.debug("Input [order id] : {}",orderId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_GETORDERBYID).replace("{1}", String.valueOf(orderId));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			//order=gson.fromJson(responseString, new TypeToken<Order>() {}.getType());
			logger.debug("order fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	/*
	public String updateUnpaidOrderItem(String id,String itemId,String orderId,String quantity,String changeNote)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM).replace("{1}",id).replace("{2}",itemId).replace("{3}",orderId).replace("{4}",quantity).replace("{5}",changeNote);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	*/
	public String updateUnpaidOrderItemPost(OrderItem orderItem)
	{
		try{
		//	String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM_POST);
			ClientResponse response = WebServiceClient
					.callPost(
							CommonResource
									.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
									+ CommonResource
											.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM_POST),
							gson.toJson(orderItem));
			//logger.debug("url....{}",url);
			//ClientResponse response=WebServiceClient.callPost(url, gson.toJson(orderItem));
			String responseString=response.getEntity(String.class);
			logger.debug("billsplitted...{}",responseString);
			return responseString;
			
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	

public String cancelUnpaidOrderPost(Order order)
{
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UNPAID_ORDER_CANCEL_POST);
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(order));
		String responseString=response.getEntity(String.class);
		logger.debug("response string:...{}",responseString);
		return responseString;
		
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
	
}

}
