package com.sharobi.webpos.inv.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.inv.model.FgItemCurrentStock;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.FgStockIn;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class FGStockinService {
	private final static Logger logger = LogManager.getLogger(FGStockinService.class);
	private final static Gson gson = new Gson();
	

	public List<EstimateDailyProd> getFgStockinByDate(int storeId,
														String date) {
		try {
			List<EstimateDailyProd> edpList = new ArrayList<EstimateDailyProd>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGSTOCKIN_GETFGSTOCKINBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getFgStockinByDate: {}", responseString);
			edpList = gson.fromJson(responseString, new TypeToken<List<EstimateDailyProd>>() {}.getType());
			return edpList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public String createFGStockin(FgStockIn fgStockIn)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGSTOCKIN_CREATEFGSTOCKIN);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, CommonResource.GSON.toJson(fgStockIn));
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
	
	public String approveFgStockin(String storeId,String fgstockinid,String approveBy) {
		try {
			logger.debug("Input [store id]: {},{},{}", storeId,fgstockinid,approveBy);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGSTOCKIN_APPROVEFGSTOCKIN).replace("{1}", storeId).replace("{2}", fgstockinid).replace("{3}", approveBy));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in approveFgStockin: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

  public List<FgStockIn> getSimpleFgStockinByDate(int storeId, String date) {
    try {
      List<FgStockIn> itemList = new ArrayList<FgStockIn>();
      logger.debug("Input [store id]: {}", storeId);
      ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGSTOCKINBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
      String responseString = response.getEntity(String.class);
      logger.debug("Response string in getsimpleFgStockinByDate: {}", responseString);
      itemList = gson.fromJson(responseString, new TypeToken<List<FgStockIn>>() {}.getType());
      return itemList;
    } catch (Exception e) {
      logger.debug("Exception:", e);
      return null;
    }
  }

  public String createSimpleFGStockin(FgStockIn fgStockIn) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_CREATEFGSTOCKIN);
      //String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+"/inventory/createFgStockIn";
      logger.debug("url....{}",url);
      logger.info(CommonResource.GSON.toJson(fgStockIn));
      ClientResponse response=WebServiceClient.callPost(url, CommonResource.GSON.toJson(fgStockIn));
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

  public FgStockIn getSimpleFgStockInDataByStoreIdAndId(int storeId, String stockinId) {
    try {
     FgStockIn fgStockitemList=new FgStockIn();
      logger.debug("Input [store id]: {}", storeId);
      ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETSIMPLESTOCKINLISTBYID).replace("{1}", String.valueOf(storeId)).replace("{2}", stockinId));
      String responseString = response.getEntity(String.class);
      logger.debug("Response string in getSimpleFgStockInDataByStoreIdAndId: {}", responseString);
      fgStockitemList = gson.fromJson(responseString,FgStockIn.class);
      return fgStockitemList;
    } catch (Exception e) {
      logger.debug("Exception:", e);
      return null;
    }
  }

 public List<FgItemCurrentStock>  getFgItemCurrentStock(int storeid,int itemId) {
   try {
     List<FgItemCurrentStock> fgitemCurrentStockList=new ArrayList<FgItemCurrentStock>();
     logger.debug("Input [store id]: {}", storeid);
     //ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGITEMCURRENTSTOCK).replace("{1}", String.valueOf(storeid)).replace("{2}", String.valueOf(itemId)));
     ClientResponse response =  WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+"/inventory/getFgCurrentStockByItem?storeid="+storeid+"&itemId="+itemId);
     logger.debug("uri: {}", response);
     String responseString = response.getEntity(String.class);
     logger.debug("Response string in getFgItemCurrentStock: {}", responseString);
     fgitemCurrentStockList = gson.fromJson(responseString, new TypeToken<List<FgItemCurrentStock>>() {}.getType());
     return fgitemCurrentStockList;
   } catch (Exception e) {
     logger.debug("Exception:", e);
     return null;
   }
  }

public String updateSimpleFGStockin(FgStockIn fgStockIn) {
  try{
    String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_UPDATEFGSTOCKIN);
    logger.debug("url....{}",url);
    ClientResponse response=WebServiceClient.callPost(url, CommonResource.GSON.toJson(fgStockIn));
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

public String deleteSimpleStockinById(String selectedstockinid, int storeId) {
  try {
    String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_DELETEFGSTOCKIN).replace("{1}", selectedstockinid).replace("{2}", String.valueOf(storeId)));
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