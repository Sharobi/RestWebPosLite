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
import com.sharobi.webpos.adm.model.CommonResultSetMapper;
import com.sharobi.webpos.adm.model.DashPaymentSummary;
import com.sharobi.webpos.adm.model.DashSalesSummary;
import com.sharobi.webpos.adm.model.DashSalesSummaryOrderType;
import com.sharobi.webpos.adm.model.DashSalesSummaryPaymentType;
import com.sharobi.webpos.adm.model.DashTopCustomer;
import com.sharobi.webpos.adm.model.DashTopItem;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class StoreService {
	
	private final static Logger logger=LogManager.getLogger(StoreService.class);
	private final static Gson gson=new Gson();
	
	public Store getStoreById(int id)
	{
		try{
			logger.debug("Input [store id]: {}", id);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_BYID).replace("{1}", String.valueOf(id));
			logger.debug("get store by id URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get store by id: {}", responseString);
			Store store=gson.fromJson(responseString, Store.class);
			return store;
		}catch (Exception e) {
			logger.error("Exception: ", e);
			return null;
		}
	}
	
	public String getLicenseInfoByStoreId(int storeid)
	{
		try{
			logger.debug("Input [store id]: {}", storeid);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_MODULE_GETLICENSE_INFO).replace("{1}", String.valueOf(storeid));
			logger.debug("get store by id URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get store by id: {}", responseString);
//			KeyBean keybean=gson.fromJson(responseString, KeyBean.class);
			return responseString;
		}catch (Exception e) {
			logger.error("Exception: ", e);
			return null;
		}
	}
	
	
	public List<PosModules> getPosModulesByUserId(String userid,int storeid)
	{
		try{
			List<PosModules> posModules=new ArrayList<PosModules>();
			logger.debug("getPosModulesByUserId {},{}", userid,storeid);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LOGIN_POSHEADER).replace("{1}", String.valueOf(userid)).replace("{2}", String.valueOf(storeid));
			logger.debug("get getPosModulesByUserId by id URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get getPosModulesByUserId by id: {}", responseString);
			posModules=gson.fromJson(responseString, new TypeToken<List<PosModules>>() {}.getType());
			return posModules;
		}catch (Exception e) {
			logger.error("Exception: ", e);
			return null;
		}
	}

	public List<Customer> getAllWaitersByStoreid(int storeId) {
		try{
			List<Customer> customers=new ArrayList<Customer>();
			logger.debug("getAllWaitersByStoreid {}", storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LOGIN_GETALLWAITERS).replace("{1}", String.valueOf(storeId));
			logger.debug("get getAllWaitersByStoreid by id URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get getAllWaitersByStoreid by id: {}", responseString);
			customers=gson.fromJson(responseString, new TypeToken<List<Customer>>() {}.getType());
			return customers;
		}catch (Exception e) {
			logger.error("Exception: ", e);
			return null;
		}
	}

	// for dashboard data 
	
	public DashSalesSummary getBoxData(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_SALESSUMMARY).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get boxdata URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get getBoxData: {}", responseString);
	      DashSalesSummary  dashSalesSummary=gson.fromJson(responseString, DashSalesSummary.class);
	      return dashSalesSummary;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }

	  public DashPaymentSummary getPaymentSummary(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_PAYMENTSUMMARY).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get getPaymentSummary URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get store getPaymentSummary: {}", responseString);
	      DashPaymentSummary  dashpaymentsummary=gson.fromJson(responseString, DashPaymentSummary.class);
	      return dashpaymentsummary;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }

	  public List<DashSalesSummaryOrderType> getDashSaleSummaryOrderType(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      List<DashSalesSummaryOrderType> dashsalessummaryordertype=new ArrayList<DashSalesSummaryOrderType>();
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYORDERTYPE).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get getDashSaleSummaryOrderType URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get store getDashSaleSummaryOrderType: {}", responseString);
	      dashsalessummaryordertype=gson.fromJson(responseString,new TypeToken<List<DashSalesSummaryOrderType>>() {}.getType());
	      return dashsalessummaryordertype;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }

	  public List<DashSalesSummaryPaymentType> getDashSaleSummaryPaymentType(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      List<DashSalesSummaryPaymentType> dashsalessummarypaymenttype=new ArrayList<DashSalesSummaryPaymentType>();
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYPAYMENTTYPE).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get DashSalesSummaryPaymentType URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get store getDashSaleSummaryPaymentType: {}", responseString);
	      dashsalessummarypaymenttype=gson.fromJson(responseString,new TypeToken<List<DashSalesSummaryPaymentType>>() {}.getType());
	      return dashsalessummarypaymenttype;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }

	  public List<DashTopCustomer> getDashTopCustomer(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      List<DashTopCustomer> dashtopcustomer=new ArrayList<DashTopCustomer>();
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_TOPCUSTOMERS).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get getDashTopCustomer URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get store getDashTopCustomer: {}", responseString);
	      dashtopcustomer=gson.fromJson(responseString,new TypeToken<List<DashTopCustomer>>() {}.getType());
	      return dashtopcustomer;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }

	  public List<DashTopItem> getDashTopItem(CommonResultSetMapper commonResultSetMapper) {
	    try{
	      logger.debug("Input [store id]: {}", commonResultSetMapper.getStoreId());
	      List<DashTopItem> dashtopttem=new ArrayList<DashTopItem>();
	      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORE_DASHBOARD_TOPITEMS).replace("{1}", String.valueOf(commonResultSetMapper.getStoreId())).replace("{2}", commonResultSetMapper.getStartDate()).replace("{3}", commonResultSetMapper.getEndDate());
	      logger.info("get getDashTopItem URL: {}", url);
	      ClientResponse response=WebServiceClient.callGet(url);
	      String responseString=response.getEntity(String.class);
	      logger.info("Response string in get store getDashTopItem: {}", responseString);
	      dashtopttem=gson.fromJson(responseString,new TypeToken<List<DashTopItem>>() {}.getType());
	      return dashtopttem;
	    }catch (Exception e) {
	      logger.error("Exception: ", e);
	      return null;
	    }
	  }
	

}
