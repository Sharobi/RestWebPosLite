/**
 * 
 */
package com.sharobi.webpos.adm.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.TaxesForAllItems;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class TaxMgntService {
	private final static Logger logger=LogManager.getLogger(TaxMgntService.class);
	private final static Gson gson=new Gson();
	public String updateTaxforAllItems(TaxesForAllItems taxesForAllItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_TAXMGNT_MENUITEM_UPDATEALLITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(taxesForAllItems));
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
