/**
 * 
 */
package com.sharobi.webpos.base.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.WebServiceClient;
import com.sharobi.webpos.vfd.Display;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 * 
 */
public class MenuService {
	private final static Logger logger = LogManager.getLogger(MenuService.class);
	private final static Gson gson = new Gson();
	private final static MenuMgntService menumgntService = new MenuMgntService();

	public Menu getAllMenuList(int storeId,HttpSession session) {
		try {
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETLIST).replace("{1}", String.valueOf(storeId)));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			Menu menu = gson.fromJson(responseString, Menu.class);
			Store store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			System.out.println("Store image" + store.getItemWithImage());
			if(store.getItemWithImage().equalsIgnoreCase("Y")){
				loadItemImage(menu);
			}
			return menu;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
	
	public Menu getAllMenuListLogin(int storeId,HttpSession session) {
		try {
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETLIST).replace("{1}", String.valueOf(storeId)));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			Menu menu = gson.fromJson(responseString, Menu.class);
//			loadItemImage(menu);
			Store store = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			/*String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETIMAGE);
			String url1=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETIMAGE).replace("{1}",String.valueOf(1769));
			System.out.println("urlrrrrrrr="+url);
			System.out.println("url111111111="+url1);*/
			if(store.getItemWithImage().equalsIgnoreCase("Y")){
				List<Menu> allMenuCat = menu.getMenucategory();
				Iterator<Menu> allMenuCatItr = allMenuCat.iterator();
				while (allMenuCatItr.hasNext()) {
					Menu submenuCat = allMenuCatItr.next();
					List<Menu> allsubMenuCat = submenuCat.getMenucategory();
					Iterator<Menu> allsubMenuCatItr = allsubMenuCat.iterator();
					while (allsubMenuCatItr.hasNext()) {
						Menu menuItems = allsubMenuCatItr.next();
						List<MenuItem> allItems = menuItems.getItems();
						Iterator<MenuItem> allitemCatItr = allItems.iterator();
						while (allitemCatItr.hasNext()) {
							MenuItem items = allitemCatItr.next();
							String imagepath = menumgntService.getMenuItemImage(items.getId());
							items.setImagepath(imagepath);
						}
					}
				}
			}
			
			return menu;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}

	public void loadItemImage(final Menu menu) throws IOException {
		logger.debug("in loadItemImage...{},{}");
		Thread t1 = new Thread(new Runnable() {
			public void run() {
				// code goes here.
				List<Menu> allMenuCat = menu.getMenucategory();
				Iterator<Menu> allMenuCatItr = allMenuCat.iterator();
				while (allMenuCatItr.hasNext()) {
					Menu submenuCat = allMenuCatItr.next();
					List<Menu> allsubMenuCat = submenuCat.getMenucategory();
					Iterator<Menu> allsubMenuCatItr = allsubMenuCat.iterator();
					while (allsubMenuCatItr.hasNext()) {
						Menu menuItems = allsubMenuCatItr.next();
						List<MenuItem> allItems = menuItems.getItems();
						Iterator<MenuItem> allitemCatItr = allItems.iterator();
						while (allitemCatItr.hasNext()) {
							MenuItem items = allitemCatItr.next();
							String imagepath = menumgntService.getMenuItemImage(items.getId());
							items.setImagepath(imagepath);
						}
					}
				}
			}
		});
		t1.start();
	}

	public List<MenuItem> getMenuItems(	Menu menuTree,
										int subcatId) {
		if (menuTree != null && CollectionUtils.isNotEmpty(menuTree.getMenucategory())) {
			List<Menu> allMenuCat = menuTree.getMenucategory();
			Iterator<Menu> allMenuCatItr = allMenuCat.iterator();
		if(subcatId==0){
			  List<MenuItem> items = new ArrayList<MenuItem>();
			  while(allMenuCatItr.hasNext())
            {  
			       Menu menu=allMenuCatItr.next();
			         for(Menu ob:menu.getMenucategory()){
			              for(MenuItem itm:ob.getItems()){
			                items.add(itm);
			              }
			            }
			       }
			  //System.out.println("Items::::"+items.toString());
			  return items;
			
			}else{
			while (allMenuCatItr.hasNext()) {
				Menu menu = allMenuCatItr.next();
				//System.out.println("sub cat:"+menu);
				if (menu.getId() == subcatId) {
					logger.debug("menu Id: {}", menu.getId());
					logger.debug("menu items:{}", menu.getItems());
					return menu.getItems();
				} else {
					List<MenuItem> menuItem = this.getMenuItems(menu, subcatId);
					//logger.debug("in else menu items:{}",menuItem);
					if (CollectionUtils.isNotEmpty(menuItem)) {
						return menuItem;
					}
				}
			}
		}
		}
		return null;
	}

	public String getMenuitemByBarcode(String code, int storeId, String lang) {
		try{
			logger.debug("Input [store id]: {},{},{}",code, storeId,lang);
			ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETITEM_BYCODE).replace("{1}",String.valueOf(code.trim())).replace("{2}",String.valueOf(storeId)).replace("{3}",String.valueOf(lang)));
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get  menu by barcode: {}", responseString);
//			MenuItem menuitem=gson.fromJson(responseString, MenuItem.class);
//			return menuitem;
			return responseString;
			}catch (Exception e) {
				logger.debug("Exception:",e);
				return null;
			}
	}

	public List<MenuItem> getItems(Menu menuTree) {
		if (menuTree != null && CollectionUtils.isNotEmpty(menuTree.getMenucategory())) {
			List<Menu> allMenuCat = menuTree.getMenucategory();
			Iterator<Menu> allMenuCatItr = allMenuCat.iterator();
		/*if(subcatId==0){*/
			  List<MenuItem> items = new ArrayList<MenuItem>();
			  while(allMenuCatItr.hasNext())
            {  
			       Menu menu=allMenuCatItr.next();
			         for(Menu ob:menu.getMenucategory()){
			              for(MenuItem itm:ob.getItems()){
			                items.add(itm);
			              }
			            }
			       }
			  //System.out.println("Items::::"+items.toString());
			  return items;
			
			/*}else{
			while (allMenuCatItr.hasNext()) {
				Menu menu = allMenuCatItr.next();
				//System.out.println("sub cat:"+menu);
				if (menu.getId() == subcatId) {
					logger.debug("menu Id: {}", menu.getId());
					logger.debug("menu items:{}", menu.getItems());
					return menu.getItems();
				} else {
					List<MenuItem> menuItem = this.getMenuItems(menu, subcatId);
					//logger.debug("in else menu items:{}",menuItem);
					if (CollectionUtils.isNotEmpty(menuItem)) {
						return menuItem;
					}
				}
			}
		}*/
		}
		return null;
	}

}
