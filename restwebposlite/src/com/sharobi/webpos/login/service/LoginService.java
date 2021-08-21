/**
 * 
 */
package com.sharobi.webpos.login.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.login.model.KeyBean;
import com.sharobi.webpos.login.model.Licensekey;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;



/**
 * @author habib
 *
 */
public class LoginService {
	
	private final static Logger logger=LogManager.getLogger(LoginService.class);
	private final static Gson gson = new Gson();
	
	public Customer login(Customer customer)
	{
		//ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LOGIN), gson.toJson(customer));
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LOGIN);
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callPost(url, gson.toJson(customer));
		String responseString=response.getEntity(String.class);
		
		logger.debug("Response string: {}", responseString);
		Customer custFromServer = gson.fromJson(responseString, Customer.class);
		
		return custFromServer;
	}
	
	public KeyBean addStoreLicenseInformation(String licensekey)
	{
		Licensekey license=new Licensekey();
		license.setLicenseKey(licensekey);
		ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LICENSE), gson.toJson(license));
		String responseString=response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
		KeyBean keyBean = gson.fromJson(responseString, KeyBean.class);
		
		return keyBean;
	}

}
