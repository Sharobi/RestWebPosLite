/**
 * 
 */
package com.sharobi.webpos.adm.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.FmcgUnit;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuFile;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.model.PrintKotMaster;
import com.sharobi.webpos.adm.model.SpecialNoteListContainer;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.multipart.MultiPart;


/**
 * @author habib
 *
 */
public class MenuMgntService {
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<MenuCategory> getMenuCategoryByStoreId(int storeId)
	{
		List<MenuCategory> menucategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menucategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	/*public String addMenuCategory(String name,int storeId,String color)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY).replace("{1}", name).replace("{2}",String.valueOf(storeId)).replace("{3}",color);
			url=url.replaceAll(" ", "%20");
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}*/
	public String addMenuCategory(MenuCategory category)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY_POST);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(category));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editMenuCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_EDITCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public String deleteMenuCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_DELETECATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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

	
	public List<MenuCategory> getMenuSubCategoryByStoreId(int storeId,int catId)
	{
		List<MenuCategory> menusubcategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(catId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menusubcategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", menusubcategoryList);
			return menusubcategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
/*	public String addMenuSubCategory(String name,int storeId,String color,int catId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY).replace("{1}", name).replace("{2}",String.valueOf(storeId)).replace("{3}",color).replace("{4}", String.valueOf(catId));
			url=url.replaceAll(" ", "%20");
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}*/
	
	public String addMenuSubCategory(MenuCategory menuSubCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY_POST);
			logger.debug("url....{}",url);
			//url=url.replaceAll(" ", "%20");
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuSubCategory));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editMenuSubCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_EDITSUBCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public String deleteMenuSubCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_DELETESUBCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public MenuCategory getAllMenuTree(int storeId)
	{
		try{
		logger.debug("Input [store id]: {}", storeId);
		ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETLISTALL).replace("{1}",String.valueOf(storeId)));
		String responseString=response.getEntity(String.class);
		//logger.debug("Response string in get all menu list: {}", responseString);
		MenuCategory menuCategory=gson.fromJson(responseString, MenuCategory.class);
		return menuCategory;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_ADDMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	public String editMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_EDITMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	public String deleteMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_DELETEMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	
	public String getMenuSubCategoryListByStoreId(int storeId,int catId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(catId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all menu sub category List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public List<FmcgUnit> getFmcgUnitByStoreId(int storeId)
	{
		List<FmcgUnit> fmcgList=new ArrayList<FmcgUnit>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETFMCGUNIT).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			fmcgList=gson.fromJson(responseString, new TypeToken<List<FmcgUnit>>() {}.getType());
			logger.debug("all fmcg List fetched: {}", fmcgList);
			return fmcgList;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public MenuCategory getAllSplNoteTree(int storeId,int itemId)
	{
		try{
		logger.debug("Input [store id],[item id]: {},{}", storeId,itemId);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE).replace("{1}",String.valueOf(storeId)).replace("{2}", String.valueOf(itemId));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get all special note list: {}", responseString);
		MenuCategory menuCategory=gson.fromJson(responseString, MenuCategory.class);
		return menuCategory;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addSpecialNote(SpecialNoteListContainer specialNoteListContainer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_ADDSPECIALNOTE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(specialNoteListContainer));
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
	public String getInstalledPrinters()
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_GETALLINSTALLEDPRINTERS);
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all installed printer List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String assignPrinter(PrintKotMaster kotMaster)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_ASSIGNPRINTER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(kotMaster));
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
	public String getAllServerPrinters(int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_GETALLSERVERPRINTERS).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all server printer List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String assignPrinterToItem(int itemid,String printerList)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_ASSIGNPRINTERTOITEM).replace("{1}",String.valueOf(itemid)).replace("{2}", String.valueOf(printerList));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
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
	public String uploadMenuItems(MenuFile file,MultiPart multipart)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_UPLOADFILE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPostData(url,file,multipart);
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
	
	public String uploadMenuItemImage(MenuFile file,MultiPart multipart)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_UPLOADIMAGE);
			logger.debug("url....{}",url);
			
			System.out.println("multipart="+multipart);
			//ClientResponse response=WebServiceClient.callPostDataForImageUpload(url, itemId, filename, multipart);
			ClientResponse response=WebServiceClient.callPostData(url,file, multipart);
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
	
	public String getMenuItemImage(int itemid)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETIMAGE).replace("{1}",String.valueOf(itemid));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			logger.debug("getMenuItemImage: {}", response.getStatus());
            if(response.getStatus()==200){
            	return url;
            }else{
            	return "failure";
            }
			
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public List<MenuCategory> getMenuCategoryExcludeSpclNoteByStoreId(int storeId)
	{
		List<MenuCategory> menucategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORYEXCLUDESPCLNOTE).replace("{1}",String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menucategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
}
