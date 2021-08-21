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
import com.sharobi.webpos.adm.model.InventoryInvoicePayment;
import com.sharobi.webpos.adm.model.Vendor;
import com.sharobi.webpos.rm.model.FgInvoicePayment;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
public class VendorMgntService {
	private final static Logger logger=LogManager.getLogger(VendorMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<Vendor> getVendorList(int storeId)
	{
		List<Vendor> vendorList=new ArrayList<Vendor>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_GETVENDOR).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get vendor list: {}", responseString);
			vendorList=gson.fromJson(responseString, new TypeToken<List<Vendor>>() {}.getType());
			logger.debug("Vendor List fetched: {}", vendorList);
			return vendorList;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String addVendor(Vendor vendor)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_ADDVENDOR);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(vendor));
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
	
	public String editVendor(Vendor vendor)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_EDITVENDOR);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(vendor));
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
	
	public String deleteVendor(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_DELETEVENDOR).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}
	
	// vendor payment management part start
		public List<InventoryInvoicePayment> getPaymentInfoByvendorId(int vendorId,int storeId)
		{
			List<InventoryInvoicePayment> invInvoiceList=new ArrayList<InventoryInvoicePayment>();
			try{
				logger.debug("Input [vendorid],[store id]: {},{}",vendorId,storeId);
				String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_GETPAYMENTINFOBYID).replace("{1}", String.valueOf(vendorId)).replace("{2}", String.valueOf(storeId));
				ClientResponse response=WebServiceClient.callGet(url);
				String responseString=response.getEntity(String.class);
				logger.debug("Response string in get credit invoice list by vendor id: {}", responseString);
				invInvoiceList=gson.fromJson(responseString, new TypeToken<List<InventoryInvoicePayment>>() {}.getType());
				return invInvoiceList;
			}catch(Exception ex)
			{
				logger.debug("Exception",ex);
				return null;
			}
		}
		
		public String vendorPayment(InventoryInvoicePayment invoicePayment)
		{
			try{
			ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_VENDOR_VENDOPAYMENT), gson.toJson(invoicePayment));
			String responseString=response.getEntity(String.class);
			logger.debug("Response string: {}", responseString);
			return responseString;
			}catch(Exception ex)
			{
				logger.debug("Exception",ex);
				return null;
			}
		}

		public List<FgInvoicePayment> getPaymentInfoByFgvendorId(int vendorId, int storeId) {

			List<FgInvoicePayment> invInvoiceList=new ArrayList<FgInvoicePayment>();
			try{
				logger.debug("Input [vendorid],[store id]: {},{}",vendorId,storeId);
				String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_FGVENDOR_GETPAYMENTINFOBYID).replace("{1}", String.valueOf(vendorId)).replace("{2}", String.valueOf(storeId));
				ClientResponse response=WebServiceClient.callGet(url);
				String responseString=response.getEntity(String.class);
				logger.debug("Response string in get credit invoice list by fg vendor id: {}", responseString);
				invInvoiceList=gson.fromJson(responseString, new TypeToken<List<FgInvoicePayment>>() {}.getType());
				return invInvoiceList;
			 }catch(Exception ex)
			{
				logger.debug("Exception",ex);
				return null;
			}
		}

		public String fgVendorPayment(FgInvoicePayment payment) {
			try{
				ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_VENDORMGNT_FGVENDOR_VENDOPAYMENT), gson.toJson(payment));
				String responseString=response.getEntity(String.class);
				logger.debug("Response string: {}", responseString);
				return responseString;
				}catch(Exception ex)
				{
					logger.debug("Exception",ex);
					return null;
				}
		}
		
		
		
		// vendor payment management part end
		
	
	

}
