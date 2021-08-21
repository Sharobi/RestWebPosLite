/**
 * 
 */
package com.sharobi.webpos.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class CreditSaleService {

	private final static Logger logger=LogManager.getLogger(CreditSaleService.class);
	private final static Gson gson=new Gson();
	
	public List<StoreCustomer> getCreditCustomerList(int storeId)
	{
		List<StoreCustomer> storeCustomerList=new ArrayList<StoreCustomer>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_CREDITSALE_GETCREDITCUSTTOMERLIST).replace("{1}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get credit customer list: {}", responseString);
			storeCustomerList=gson.fromJson(responseString, new TypeToken<List<StoreCustomer>>() {}.getType());
			logger.debug("StoreCustomer List fetched: {}", storeCustomerList);
			return storeCustomerList;
		}catch(Exception ex){
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public List<Order> getCreditOrdersBycustId(int storeId,int custId)
	{
		List<Order> creditOrderList=new ArrayList<Order>();
		try{
			logger.debug("Input [store id],[custid]: {},{}",storeId,custId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_CREDITSALE_ORDER_GETCREDITORDERBYCUSTOMERID).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(custId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get credit order list: {}", responseString);
			creditOrderList=gson.fromJson(responseString, new TypeToken<List<Order>>() {}.getType());
			return creditOrderList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
}
