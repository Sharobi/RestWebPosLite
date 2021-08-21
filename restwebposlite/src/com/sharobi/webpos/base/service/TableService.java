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
import com.sharobi.webpos.base.model.Table;
import com.sharobi.webpos.base.model.TableCombo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;



/**
 * @author habib
 *
 */
public class TableService {
	private final static Logger logger=LogManager.getLogger(TableService.class);
	private final static Gson gson=new Gson();
	
	public List<Table> getTableList(int storeId)
	{
		List<Table> tableList=new ArrayList<Table>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TABLE_GETLIST).replace("{1}", String.valueOf(storeId));
			logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get table list: {}", responseString);
			tableList=gson.fromJson(responseString, new TypeToken<List<Table>>() {}.getType());
			logger.debug("Table List fetched: {}", tableList);
			return tableList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public void updateTableSatus(TableCombo table)
	{
		try{
			ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_UPDATE_TABLE_STATUS), gson.toJson(table));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString);
		}catch (Exception e) {
			logger.error("Exception:",e);
		}
	}

}
