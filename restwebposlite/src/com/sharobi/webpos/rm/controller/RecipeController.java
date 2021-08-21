package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.rm.model.RecipeIngredient;
import com.sharobi.webpos.rm.service.RecipeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	private final static Logger logger = LogManager.getLogger(RecipeController.class);
	private final static RecipeService recipeService = new RecipeService();

	@RequestMapping(value = "/loadrecipeingredient",
					method = RequestMethod.GET)
	public ModelAndView loadRecipeIngredients(	Model model,
												HttpSession session) {
		ModelAndView mav = new ModelAndView();

		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Menu allMenuList = recipeService.getAllMenuListForRM(customer.getStoreId());
			System.out.println("allMenuList=" + allMenuList.toString());
			mav.addObject("allmenuforrm", allMenuList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_RECIPE_INGREDIENTS_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getIngredientDetailsOfMenuItem",
					method = RequestMethod.GET)
	public void getIngredientDetailsOfMenuItem(	@RequestParam String itemid,
															HttpSession session,HttpServletResponse response) {
		logger.debug("in getIngredientDetailsOfMenuItem...! {}", itemid);
		PrintWriter out;
		try {
			out = response.getWriter();
		
		response.setContentType("text/plain");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			out.print(recipeService.getAllIndredientOfMenuItem(customer.getStoreId(), Integer.valueOf(itemid)));
			out.flush();
		}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
