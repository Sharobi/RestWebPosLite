package com.sharobi.webpos.inv.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryStockIn;
import com.sharobi.webpos.inv.model.InventoryStockInItem;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class StockInService {
	private final static Logger logger = LogManager.getLogger(StockInService.class);
	private final static Gson gson = new Gson();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	public List<InventoryStockIn> getInventoryStockInByDate(int storeId,
															String date) {

		List<InventoryStockIn> invStockInListRev = new ArrayList<InventoryStockIn>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_BYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("responseString: {}", responseString);
			logger.debug("Response string: {}", responseString.length());
				if (!responseString.equals("null") && responseString.length() != 2 ) {
					List<InventoryStockIn> invStockInList = (List<InventoryStockIn>) gson.fromJson(responseString, new TypeToken<List<InventoryStockIn>>() {}.getType());
					int listSize = invStockInList.size();
								
					logger.debug("Size ::" + listSize);
					for (int i = listSize - 1; i >= 0; i--) {
						invStockInListRev.add(invStockInList.get(i));
					}
					logger.debug("invStockInListRev Size ::" + invStockInListRev.size());
					logger.debug("invStockInListRev Obj:: {}", invStockInListRev);

					return invStockInListRev;
			} else {
				return invStockInListRev;
			}
			

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	public List<InventoryStockIn> getStockInByPoId(	int storeId,
													String poId) {

		List<InventoryStockIn> invStockInListRev = new ArrayList<InventoryStockIn>();

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_BYID).replace("{1}", String.valueOf(storeId)).replace("{2}", poId));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("responseString: {}", responseString);
		logger.debug("Response string: {}", responseString.length());
		if (!responseString.equals("null") && responseString.length() != 2) {
			List<InventoryStockIn> InventoryStockInList = (List<InventoryStockIn>) gson.fromJson(responseString, new TypeToken<List<InventoryStockIn>>() {}.getType());
			int listSize = InventoryStockInList.size();
			logger.debug("Size ::" + listSize);
			for (int i = listSize - 1; i >= 0; i--) {
				invStockInListRev.add(InventoryStockInList.get(i));
			}
			logger.debug("invStockInListRev Size ::" + invStockInListRev.size());
			logger.debug("invStockInListRev Obj:: {}", invStockInListRev);

			return invStockInListRev;
		} else {

			return invStockInListRev;
		}
	}

	public void stockInClosed(InventoryStockIn inventoryStockIn) {

		/*String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_CLOSED).replace("{1}", String.valueOf(poId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);*/
		 try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_CLOSED).replace("{1}", String.valueOf(inventoryStockIn.getId())));
				logger.debug("URL :: {}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockIn));
				String responseString = response.getEntity(String.class);
				logger.debug("Response :: {}", responseString);
			} catch (Exception e) {
				logger.error("Exception", e);
			}
	
	
	
	}

	public String updateEachStockInItem(InventoryStockInItem inventoryStockInItem) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EACHSTOCKINITEM));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockInItem));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.error("Exception", e);
			return "failure";
		}
	}

	public void deleteEachStockInItem(	String stockInId,
										String stockInItemId,
										int storeId) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_DELETE_EACHSTOCKINITEM).replace("{1}", stockInId).replace("{2}", stockInItemId).replace("{3}", String.valueOf(storeId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
	}

	public void saveNewStockIn(InventoryStockIn inventoryStockIn) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_SAVE_NEW));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockIn));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}
	
	public void updateExistingStockIn(InventoryStockIn inventoryStockIn) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EXISTING));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockIn));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public String deleteStockinById(String stockinid, int storeId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_DELETEBYID).replace("{1}", stockinid).replace("{2}", String.valueOf(storeId)));
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
