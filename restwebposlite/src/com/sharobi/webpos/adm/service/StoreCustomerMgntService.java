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
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class StoreCustomerMgntService {

	private final static Logger logger=LogManager.getLogger(StoreCustomerMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<StoreCustomer> getStoreCustomerList(int storeId)
	{
		List<StoreCustomer> storeCustomerList=new ArrayList<StoreCustomer>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_GETSTORECUSTOMER).replace("{1}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer list: {}", responseString);
			storeCustomerList=gson.fromJson(responseString, new TypeToken<List<StoreCustomer>>() {}.getType());
			logger.debug("StoreCustomer List fetched: {}", storeCustomerList);
			return storeCustomerList;
		}catch(Exception ex){
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addStoreCustomer(StoreCustomer storeCustomer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_ADDSTORECUSTOMER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(storeCustomer));
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
	
	public String editStoreCustomer(StoreCustomer storeCustomer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_EDITSTORECUSTOMER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(storeCustomer));
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
	
	public String deleteStoreCustomer(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_DELETESTORECUSTOMER).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}

	public StoreCustomer getAddedCustomerData(int storeId, String contactNo) {
		StoreCustomer storeCustomerData=new StoreCustomer();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_CREDITSALE_ORDER_GETCREDITCUSTOMERBYCONTACTNO).replace("{1}", String.valueOf(storeId)).replace("{2}",contactNo);
			
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_HOTELCOUNTRYLINKUP).replace("{1}", String.valueOf(storeId)).replace("{2}",String.valueOf(countryLinkId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer: {}", responseString);
			storeCustomerData=gson.fromJson(responseString, new TypeToken<StoreCustomer>() {}.getType());
			logger.debug("StoreCustomer fetched: {}", storeCustomerData);
			return storeCustomerData;
		}catch(Exception ex){
			logger.debug("Exception",ex);
			return null;
		}
	}
}
