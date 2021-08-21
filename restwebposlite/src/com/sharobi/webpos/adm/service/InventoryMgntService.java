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
import com.sharobi.webpos.adm.model.InvType;
import com.sharobi.webpos.adm.model.InventoryItem;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class InventoryMgntService {

	private final static Logger logger=LogManager.getLogger(InventoryMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<InvType> getInvTypeList(int storeId)
	{
		List<InvType> invtypeList=new ArrayList<InvType>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVTYPE_GETINVTYPE).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get inventory type list: {}", responseString);
			invtypeList=gson.fromJson(responseString, new TypeToken<List<InvType>>() {}.getType());
			logger.debug("inv type List fetched: {}", invtypeList);
			return invtypeList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String addInvType(InvType invType)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVTYPE_ADDINVTYPE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(invType));
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
	
	public String editInvType(InvType invType)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVTYPE_EDITINVTYPE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(invType));
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
	
	public String deleteInvType(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVTYPE_DELETEINVTYPE).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}

	public List<InventoryItem> getInvItemList(int storeId)
	{
		List<InventoryItem> invitemList=new ArrayList<InventoryItem>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_GETINVITEM).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get inventory item list: {}", responseString);
			invitemList=gson.fromJson(responseString, new TypeToken<List<InventoryItem>>() {}.getType());
			logger.debug("inv item List fetched: {}", invitemList);
			return invitemList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<MetricUnit> getInvItemUnitList()
	{
		List<MetricUnit> unitList=new ArrayList<MetricUnit>();
		try{
			logger.debug("getInvItemUnitList: {}");
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_GETUNITLIST);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get inventory unit list: {}", responseString);
			unitList=gson.fromJson(responseString, new TypeToken<List<MetricUnit>>() {}.getType());
			logger.debug("Unit List fetched: {}", unitList);
			return unitList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public MetricUnit getInvItemUnitDetails(int unitid)
	{
		MetricUnit unitList=new MetricUnit();
		try{
			logger.debug("getInvItemUnitList: {}");
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_GETUNITDETAILS).replace("{1}", String.valueOf(unitid));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get inventory item list: {}", responseString);
			unitList=gson.fromJson(responseString, new TypeToken<MetricUnit>() {}.getType());
			logger.debug("Unit List fetched: {}", unitList);
			return unitList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String addInvItem(InventoryItem inventoryItem)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_ADDINVITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(inventoryItem));
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
	
	public String editInvItem(InventoryItem inventoryItem)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_EDITINVITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(inventoryItem));
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
	
	public String deleteInvItem(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_DELETEINVITEM).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}
	
	
	public String getFgStockInItemsByItemId(int storeId,int itemId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_INVMGNT_INVITEM_GETFGSTOCKINITEMSBYITEMID).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("URL IN getFgStockInItemsByItemId() and InventoryMgntService.java CLASS IS...{}",url);
			logger.debug("response string in method getFgStockInItemsByItemId() and InventoryMgntService.java Class Is...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}
	
	
}
