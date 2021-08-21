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
import com.sharobi.webpos.adm.model.TableMaster;
import com.sharobi.webpos.adm.model.Tables;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;


/**
 * @author habib
 *
 */
public class TableMgntService {
	
	private final static Logger logger=LogManager.getLogger(TableMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<Tables> getTableListforMgnt(int storeId)
	{
		List<Tables> tableList=new ArrayList<Tables>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TABLE_GETLIST).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get table list: {}", responseString);
			tableList=gson.fromJson(responseString, new TypeToken<List<Tables>>() {}.getType());
			logger.debug("Table List fetched: {}", tableList);
			return tableList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	public String addTable(Tables tables)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TABLEMGNT_TABLE_ADDTABLE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(tables));
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
	public String editTable(TableMaster tables)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TABLEMGNT_TABLE_EDITTABLE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(tables));
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
	public String deleteTable(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TABLEMGNT_TABLE_DELETETABLE).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}

}
