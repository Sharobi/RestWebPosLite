package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.StoreCustomers;
import com.sharobi.webpos.rm.model.RecipeIngredient;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class RecipeService {
	private final static Logger logger = LogManager.getLogger(RecipeService.class);
	private final static Gson gson = new Gson();

	public Menu getAllMenuListForRM(int storeId) {
		try {
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETLIST).replace("{1}", String.valueOf(storeId)));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			Menu menu = gson.fromJson(responseString, Menu.class);
			return menu;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}

	public String getAllIndredientOfMenuItem(	int storeId,
											int itemId) {
		try {
			logger.debug("Input [store id,itemId,]: {}", storeId, itemId);
//			List<RecipeIngredient> recipeIngredientList=new ArrayList<RecipeIngredient>();
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETINGREDIENTLIST).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all ingredient list of menu: {}", responseString);
//			recipeIngredientList=gson.fromJson(responseString, new TypeToken<List<RecipeIngredient>>() {}.getType());
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
}
