/**
 * 
 */
package com.sharobi.webpos.report.service;

import java.io.InputStream;
import java.util.List;

import javax.ws.rs.core.MediaType;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;


/**
 * @author habib
 *
 */
public class ReportService {
	private final static Logger logger=LogManager.getLogger(ReportService.class);
	private final static Gson gson = new Gson();
	public InputStream  getDailySalesReport(String date,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_SALES_DAILY_REPORT).replace("{1}", date).replace("{2}", String.valueOf(storeId));
			Client client=Client.create();
			WebResource webResource=client.resource(url);
			ClientResponse response=webResource.type(MediaType.APPLICATION_OCTET_STREAM).get(ClientResponse.class);
			return response.getEntityInputStream();
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	
public List<PosModules> getReportByStore(String userId, String storeId){
		
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_BY_STORE).replace("{1}",String.valueOf(userId)).replace("{2}",String.valueOf(storeId));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		
		List<PosModules> posModuleList = (List<PosModules>) gson.fromJson(responseString, new TypeToken<List<PosModules>>() {}.getType());
		
		return posModuleList;
		
	}

}
