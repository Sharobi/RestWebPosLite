package com.sharobi.webpos.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.DeliveryBoy;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.OrderDeliveryBoy;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class DeliveryBoyService {
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<DeliveryBoy> getAllDeliveryBoy(int storeId)
	{
		List<DeliveryBoy> deliveryboyList = new ArrayList<DeliveryBoy>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY).replace("{1}",String.valueOf(storeId));
			//logger.debug("url{}", CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY).replace("{1}",String.valueOf(storeId)));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all delivery boy List fetched: {}", responseString);
			deliveryboyList = gson.fromJson(responseString, new TypeToken<List<DeliveryBoy>>() {}.getType());
			return deliveryboyList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String getAllDeliveryBoyByList(int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY).replace("{1}",String.valueOf(storeId));
			logger.debug("url{}", CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY).replace("{1}",String.valueOf(storeId)));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all delivery boy List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addDeliveryBoy(DeliveryBoy deliveryBoyObj)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_ADDDELIVERYBOY);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(deliveryBoyObj));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editDeliveryBoy(DeliveryBoy deliveryBoyObj)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_EDITDELIVERYBOY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(deliveryBoyObj));
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
	
	public String deleteDeliveryBoy(int id,int storeId)
	{
	try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_DELVRYBOYMGNT_DELETEDELIVERYBOY).replace("{1}",String.valueOf(id)).replace("{2}",String.valueOf(storeId));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);;
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
	
	public String assignDeliveryBoy(OrderDeliveryBoy deliveryBoyObj)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ORDER_ASSIGNDELIVERYBOY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(deliveryBoyObj));
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
       
