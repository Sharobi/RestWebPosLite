package com.sharobi.webpos.inv.service;


import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.inv.model.InventoryReturn;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

@Service
public class PurchaseReturnService {
	private final static Logger logger = LogManager.getLogger(StockInService.class);
	private final static Gson gson = new Gson();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();
	
	
	public void saveNewPurchaseReturn(InventoryReturn invreturn) {
		
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_SAVE));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(invreturn));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public void updatePurchaseReturn(InventoryReturn invreturn) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_UPDATE));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(invreturn));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
		
	}

	public List<InventoryReturn> getPurchaseReturnByDate(int storeId, String date) {
		List<InventoryReturn> returnListRev = new ArrayList<InventoryReturn>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("responseString: {}", responseString);
			logger.debug("Response string: {}", responseString.length());
				if (!responseString.equals("null") && responseString.length() != 2 ) {
					  List<InventoryReturn> returnlist = (List<InventoryReturn>) gson.fromJson(responseString, new TypeToken<List<InventoryReturn>>() {}.getType());
					
					int listSize = returnlist.size();								
					logger.debug("Size ::" + listSize);
					for (int i = listSize - 1; i >= 0; i--) {
						returnListRev.add(returnlist.get(i));
					}
					logger.debug("invStockInListRev Size ::" + returnListRev.size());
					logger.debug("invStockInListRev Obj:: {}", returnListRev);

					return returnListRev;
			} else {
				return returnListRev;
			}
			

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	public InventoryReturn getPurchaseReturnByReturnId(int storeId, String returnid) {
		
		InventoryReturn returndata = new InventoryReturn();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYID).replace("{1}", returnid).replace("{2}",String.valueOf(storeId) ));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response Purchase return by id : {}", response);
			String responseString = response.getEntity(String.class);
			returndata = (InventoryReturn) gson.fromJson(responseString, new TypeToken<InventoryReturn>() {}.getType());
			return returndata;
		 } catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
		
		
	}

	public void purchaseReturnClosed(InventoryReturn inventoryReturn) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_CLOSED).replace("{1}", String.valueOf(inventoryReturn.getId())));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryReturn));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	
     }   
 public String deletePurchaseReturnById(String purchaseReturnId, int storeId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASE_RETURN_DELETEBYID).replace("{1}", purchaseReturnId).replace("{2}", String.valueOf(storeId)));
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
