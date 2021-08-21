package com.sharobi.webpos.inv.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.StockOutMenuCategory;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class StockOutService {
	private final static Logger logger = LogManager.getLogger(StockOutService.class);
	private final static Gson gson = new Gson();

	public List<InventoryStockOut> getInventoryStockOutByDate(	int storeId,
																String date) {

		List<InventoryStockOut> invStockOutListRev = new ArrayList<InventoryStockOut>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKOUT_BYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString.length());
			if (!responseString.equals("null") && responseString.length() != 2) {
				List<InventoryStockOut> invStockOutList = (List<InventoryStockOut>) gson.fromJson(responseString, new TypeToken<List<InventoryStockOut>>() {}.getType());
				int listSize = invStockOutList.size();
				logger.debug("Size ::" + listSize);
				for (int i = listSize - 1; i >= 0; i--) {
					invStockOutListRev.add(invStockOutList.get(i));
				}
				logger.debug("invStockOutListRev Size ::" + invStockOutListRev.size());
				logger.debug("invStockOutListRev Obj:: {}", invStockOutListRev);

				return invStockOutList;
			} else {
				return invStockOutListRev;
			}

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	public List<InventoryStockOut> getInventoryStockOutByDateNew(	int storeId,
																	String date) {

		List<InventoryStockOut> invStockOutList = new ArrayList<InventoryStockOut>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKOUT_BYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString.length());
			if (!responseString.equals("null") && responseString.length() != 2) {
				invStockOutList = (List<InventoryStockOut>) gson.fromJson(responseString, new TypeToken<List<InventoryStockOut>>() {}.getType());
				Collections.reverse(invStockOutList);
				return invStockOutList;
			} else {
				return invStockOutList;
			}

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	public List<InventoryStockOut> getStockOutByPoId(	int storeId,
														String poId) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKOUT_BYID).replace("{1}", String.valueOf(storeId)).replace("{2}", poId));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		List<InventoryStockOut> InventoryStockOutList = (List<InventoryStockOut>) gson.fromJson(responseString, new TypeToken<List<InventoryStockOut>>() {}.getType());
		logger.debug("InventoryStockOutList Obj. List :: {}", InventoryStockOutList);

		return InventoryStockOutList;
	}

	public String createNewStockOut(InventoryStockOut inventoryStockOut) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKOUT_CREATE_NEW));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockOut));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.error("Exception", e);

			return null;
		}
	}

	public List<StockOutMenuCategory> getMenuCategoryByStoreId(int storeId) {
		List<StockOutMenuCategory> menucategoryList = new ArrayList<StockOutMenuCategory>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}", String.valueOf(storeId));
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			menucategoryList = gson.fromJson(responseString, new TypeToken<List<StockOutMenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public List<MenuCategory> getMenuCategoryListByStoreId(int storeId) {
		List<MenuCategory> menucategoryList = new ArrayList<MenuCategory>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}", String.valueOf(storeId));
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			menucategoryList = gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
}
