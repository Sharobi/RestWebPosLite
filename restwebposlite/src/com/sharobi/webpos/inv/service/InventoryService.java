package com.sharobi.webpos.inv.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.model.PurchaseOrder;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class InventoryService {
	private final static Logger logger = LogManager.getLogger(InventoryService.class);
	private final static Gson gson = new Gson();
	private final static InventoryMgntService inventorymgntService = new InventoryMgntService();

	public List<PurchaseOrder> getPurchaseOrderByDate(	int storeId,
														String date) {

		List<PurchaseOrder> purchaseOrderListRev = new ArrayList<PurchaseOrder>();
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASEORDER_BYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString.length());
			if (!responseString.equals("null") && responseString.length() != 2) {
				List<PurchaseOrder> purchaseOrderList = (List<PurchaseOrder>) gson.fromJson(responseString, new TypeToken<List<PurchaseOrder>>() {}.getType());
				int listSize = purchaseOrderList.size();
				logger.debug("Size ::" + listSize);
				for (int i = listSize - 1; i >= 0; i--) {
					purchaseOrderListRev.add(purchaseOrderList.get(i));
				}
				logger.debug("purchaseOrderListRev Size ::" + purchaseOrderListRev.size());
				logger.debug("purchaseOrderListRev Obj:: {}", purchaseOrderListRev);

				return purchaseOrderListRev;
			} else {
				return purchaseOrderListRev;
			}

		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}

	}

	public List<InventoryPurchaseOrder> getPurchaseOrderById(	int storeId,
																int poId) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASEORDER_BYPOID).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(poId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		List<InventoryPurchaseOrder> InventoryPurchaseOrderList = (List<InventoryPurchaseOrder>) gson.fromJson(responseString, new TypeToken<List<InventoryPurchaseOrder>>() {}.getType());
		logger.debug("InventoryPucrchaseOrder Obj. List :: {}", InventoryPurchaseOrderList);

		return InventoryPurchaseOrderList;
	}

	public List<InventoryItems> getInventoryItems(int storeId) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_INVENTORYITEMS).replace("{1}", String.valueOf(storeId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		List<InventoryItems> InventoryItemList = (List<InventoryItems>) gson.fromJson(responseString, new TypeToken<List<InventoryItems>>() {}.getType());

		logger.debug("InventoryItem Obj. List :: {}", InventoryItemList);

		return InventoryItemList;
	}

	public List<InventoryItems> getInventoryItemList(	int storeId,
														String itemcode) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_GETINVENTORYITEMS_BYCODE).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemcode)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		InventoryItems InventoryItem = (InventoryItems) gson.fromJson(responseString, new TypeToken<InventoryItems>() {}.getType());
		MetricUnit metricUnit = inventorymgntService.getInvItemUnitDetails(InventoryItem.getMetricUnitId());
		InventoryItem.setUnit(metricUnit.getUnit());
		List<InventoryItems> InventoryItemList = new ArrayList<InventoryItems>();
		InventoryItemList.add(InventoryItem);
		logger.debug("InventoryItem Obj. List :: {}", InventoryItemList);

		return InventoryItemList;
	}
	
	public InventoryItems getInventoryItemDetails(	int storeId,
			String itemcode) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_GETINVENTORYITEMS_BYCODE).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemcode)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		InventoryItems InventoryItem = (InventoryItems) gson.fromJson(responseString, new TypeToken<InventoryItems>() {}.getType());
		MetricUnit metricUnit = inventorymgntService.getInvItemUnitDetails(InventoryItem.getMetricUnitId());
		InventoryItem.setUnit(metricUnit.getUnit());
		logger.debug("InventoryItem Obj. List :: {}", InventoryItem);

		return InventoryItem;
}

	public void approvedPO(	String poId,
							String approvedBy,
							String updatedBy,
							String updatedDate) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_APPROVEDPO).replace("{1}", poId).replace("{2}", approvedBy).replace("{3}", updatedBy).replace("{4}", updatedDate));
		logger.debug("URL :: {}", url);
		ClientResponse response = WebServiceClient.callGet(url);
		//String responseString = response.getEntity(String.class);
	}

	public void updatedPO(	String poId,
							String poBy,
							String updatedBy,
							String updatedDate) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_UPDATEDPO).replace("{1}", poId).replace("{2}", poBy).replace("{3}", updatedBy).replace("{4}", updatedDate));
		logger.debug("URL :: {}", url);
		ClientResponse response = WebServiceClient.callGet(url);
		//String responseString = response.getEntity(String.class);
	}

	/*public void updatePoEachItem(InventoryPurchaseOrderItems purchaseOrderItems) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_UPDATE_EACHPOITEM));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(purchaseOrderItems));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}*/

	public String updatePoEachItem(InventoryPurchaseOrderItems purchaseOrderItems) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_UPDATE_EACHPOITEM));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(purchaseOrderItems));
			logger.debug("JSON Response :: {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("Response String :: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.error("Exception", e);
			return null;
		}
	}

	public void deletePoItem(	String poId,
								String poItemId,
								int storeId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_DELETE_POITEM).replace("{1}", poId).replace("{2}", poItemId).replace("{3}", String.valueOf(storeId)));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public String getCurrentStockByItem(int storeId,
										int itemId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_CURRENTSTOCK_ITEM).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemId)));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
			String itemStockNo = gson.fromJson(responseString, String.class);
			logger.debug("itemStockNo :: " + itemStockNo);
			return itemStockNo;
		} catch (Exception e) {
			logger.error("Exception", e);
			return "Not Available";
		}
	}

	public List<InventoryVendors> getVendors(int storeId) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_VENDORS).replace("{1}", String.valueOf(storeId)));
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		List<InventoryVendors> vendorList = (List<InventoryVendors>) gson.fromJson(responseString, new TypeToken<List<InventoryVendors>>() {}.getType());
		logger.debug("Vendor Obj. List :: {}", vendorList);

		return vendorList;
	}

	public void createInventoryPurchaseOrder(InventoryPurchaseOrder purchaseOrder) {
		try {
			logger.debug("In Inventory Service :createInventoryPurchaseOrder :: {}", purchaseOrder);
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASEORDER_CREATE));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(purchaseOrder));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public void updateInventoryPurchaseOrder(InventoryPurchaseOrder purchaseOrder) {
		try {
			logger.debug("In Inventory Service :updateInventoryPurchaseOrder :: {}", purchaseOrder);
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASEORDER_UPDATE));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(purchaseOrder));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public String poOrderPrint(	int storeId,
								String poId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_PURCHASEORDER_PRINT).replace("{1}", String.valueOf(storeId)).replace("{2}", poId));
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

	public String deleteRequisition(String poId, int storeId) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_REQUISITION_DELETE).replace("{1}", poId).replace("{2}", String.valueOf(storeId)));
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
