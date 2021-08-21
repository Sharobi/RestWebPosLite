/**
 * 
 */
package com.sharobi.webpos.util;

import java.io.File;

import javax.ws.rs.core.MediaType;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;


import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.MenuFile;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.MultiPart;
import com.sun.jersey.multipart.file.FileDataBodyPart;

/**
 * @author habib
 *
 */
public class WebServiceClient {
	
	public static ClientResponse callGet(String url)
	{
		Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=webResource.type(MediaType.APPLICATION_JSON).get(ClientResponse.class);
		return response;
	}
	public static ClientResponse callPost(String url,String param)
	{
		Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=null;
		if(StringUtils.isNotEmpty(param))
			{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class, param);
			}
		else{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class);
			}
		return response;
	}
	public static ClientResponse callPostData(String url,MenuFile file,MultiPart param)
	{
		/*Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=null;
		if(param!=null)
			{
			response = webResource.type(MediaType.MULTIPART_FORM_DATA).post(ClientResponse.class, param);
			}
		else{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class);
			}
		return response;*/
		Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=null;
		if(param!=null)
			{
			
			 
	        
	            response=webResource.type(
	                    MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class,
	                    		param);
			}
		else{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class);
			}
		return response;
	}
	
	public static ClientResponse callPostDataForImageUpload(String url,String itemId,String filename,MultiPart param)
	{
		/*Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=null;
		if(param!=null)
			{
			response = webResource.type(MediaType.MULTIPART_FORM_DATA).post(ClientResponse.class, param);
			}
		else{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class);
			}
		return response;*/
		Client client=Client.create();
		WebResource webResource=client.resource(url);
		ClientResponse response=null;
		if(param!=null)
			{
	            response=webResource.type(
	                    MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class,
	                    		param);
			}
		else{
			response = webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class);
			}
		return response;
	}

}
