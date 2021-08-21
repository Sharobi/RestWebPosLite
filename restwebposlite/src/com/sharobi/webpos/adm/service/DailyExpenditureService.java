package com.sharobi.webpos.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.DailyExpenditure;
import com.sharobi.webpos.adm.model.DailyExpenditureType;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class DailyExpenditureService {
	private final static Logger logger=LogManager.getLogger(DailyExpenditureService.class);
	private final static Gson gson=new Gson();
	public String addDailyExpenditure(DailyExpenditure dailyExpenditure)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_ADD_DAILYEXPENDITURE);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(dailyExpenditure));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String getDailyExpenditure(String date, int storeId)
	{
		//List<DailyExpenditure> dailyexpList=new ArrayList<DailyExpenditure>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_VIEW_DAILYEXPENDITURE).replace("{1}",date).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			//dailyexpList=gson.fromJson(responseString, new TypeToken<List<DailyExpenditure>>() {}.getType());
			logger.debug("daily exp string fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String getPeriodExpenditure(String fromdate, String todate, int storeId)
	 {
	  //List<DailyExpenditure> dailyexpList=new ArrayList<DailyExpenditure>();
	  try{
	   String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_VIEW_PERIODEXPENDITURE).replace("{1}",fromdate).replace("{2}",todate).replace("{3}", String.valueOf(storeId));
	   ClientResponse response=WebServiceClient.callGet(url);
	   String responseString=response.getEntity(String.class);
	   //dailyexpList=gson.fromJson(responseString, new TypeToken<List<DailyExpenditure>>() {}.getType());
	   logger.debug("daily exp string fetched: {}", responseString);
	   return responseString;
	  }catch(Exception ex)
	  {
	   logger.debug("Exception",ex);
	   return null;
	  }
	 }

	public String editDailyExp(DailyExpenditure dailyexpenditureob) {
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_VIEW_EDITXPENDITURE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(dailyexpenditureob));
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

	public String deleteexpenditure(DailyExpenditure dailyexpob) {
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_VIEW_EDITXPENDITURE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(dailyexpob));
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

	public List<DailyExpenditureType> getExpenditureTypes() {
		List<DailyExpenditureType> exptypeobjList = new ArrayList<DailyExpenditureType>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_VIEW_XPENDITURETYPE);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			exptypeobjList = gson.fromJson(responseString, new TypeToken<List<DailyExpenditureType>>() {}.getType());
			logger.debug("all expenditure type  List fetched: {}", exptypeobjList);
			return exptypeobjList;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
}
