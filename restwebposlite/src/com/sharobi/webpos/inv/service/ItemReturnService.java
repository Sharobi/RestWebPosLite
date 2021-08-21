package com.sharobi.webpos.inv.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.rm.model.FgReturn;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class ItemReturnService {
	private final static Logger logger = LogManager.getLogger(ItemReturnService.class);
	private final static Gson gson = new Gson();
	
	
	public String createSimpleFGStockin(FgReturn fgStockReturn) {
		try{
		      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_CREATEFGSTOCKRETURN);
		      logger.debug("url....{}",url);
		      logger.info(gson.toJson(fgStockReturn));
		      ClientResponse response=WebServiceClient.callPost(url, gson.toJson(fgStockReturn));
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


	public String updateSimpleFGStockin(FgReturn fgStockReturn) {
		try{
		    String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_UPDATEFGSTOCKRETURN);
		    logger.debug("url....{}",url);
		    ClientResponse response=WebServiceClient.callPost(url, CommonResource.GSON.toJson(fgStockReturn));
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


	public FgReturn getSimpleFgStockReturnDataByStoreIdAndId(int storeId, String stockReturnId) {
		try {
			FgReturn fgStockReturn=new FgReturn();
		      logger.debug("Input [store id]: {}", storeId);
		      ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYID).replace("{1}", stockReturnId).replace("{2}", String.valueOf(storeId)));
		      String responseString = response.getEntity(String.class);
		      logger.debug("Response string in getSimpleFgStockInDataByStoreIdAndId: {}", responseString);
		      fgStockReturn = gson.fromJson(responseString,FgReturn.class);
		      return fgStockReturn;
		    } catch (Exception e) {
		      logger.debug("Exception:", e);
		      return null;
		    }
	}


	public List<FgReturn> getSimpleFgStockReturnByDate(int storeId, String date) {
		try {
		      List<FgReturn> itemList = new ArrayList<FgReturn>();
		      logger.debug("Input [store id]: {}", storeId);
		      ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
		      String responseString = response.getEntity(String.class);
		      logger.debug("Response string in getsimpleFgStockinByDate: {}", responseString);
		      itemList = gson.fromJson(responseString, new TypeToken<List<FgReturn>>() {}.getType());
		      return itemList;
		    } catch (Exception e) {
		      logger.debug("Exception:", e);
		      return null;
		    }
	}


	public String approveFgStockReturn(FgReturn obj) {
		try{
		    String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_APPROVEFGSTOCKRETURN);
		    logger.debug("url....{}",url);
		    ClientResponse response=WebServiceClient.callPost(url, CommonResource.GSON.toJson(obj));
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


	public String deleteSimpleStockReturnById(String selectedstockreturnid, int storeId) {
		try {
		    String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_DELETEFGSTOCKRETURN).replace("{1}", selectedstockreturnid).replace("{2}", String.valueOf(storeId)));
		    ClientResponse response = WebServiceClient.callGet(url);
		    logger.debug("Response : {}", response);
		    String responseString = response.getEntity(String.class);
		    logger.debug("Response string: {}", responseString);
		    return responseString;
		  } catch (Exception e) {
		    logger.error("Exception", e);
		    return "Failure";
		  }
	}
	
	
	
}
