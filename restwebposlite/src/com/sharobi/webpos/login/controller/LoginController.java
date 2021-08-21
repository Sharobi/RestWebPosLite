/**
 * 
 */
package com.sharobi.webpos.login.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.login.model.KeyBean;
import com.sharobi.webpos.login.model.User;
import com.sharobi.webpos.login.service.LoginService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/authentication")
public class LoginController {
	private final static Logger logger = LogManager.getLogger(LoginController.class);
	private final static LoginService loginService = new LoginService();

	@RequestMapping(value = "/login",
					method = RequestMethod.GET)
	public ModelAndView login(Model model) {
		logger.debug("In Login...");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_LOGIN_PAGE);
		model.addAttribute("user", new User());
		return mav;
	}

	@RequestMapping(value = "/dologin",
					method = RequestMethod.POST)
	public ModelAndView doLogin(@Valid @ModelAttribute("user") User user,
								BindingResult result,
								HttpSession session) {
		logger.debug("In doLogin...");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_LOGIN_PAGE);
		if (!result.hasErrors()) {
			Customer customer = new Customer();
			customer.setContactNo(user.getUserName());
			customer.setPassword(user.getPassword());
			Customer custFromServer = loginService.login(customer);
			if (custFromServer.getId() != 0) {
				System.out.println("session.getId()="+session.getId());
				System.out.println("custFromServer.getStatus()=" + custFromServer.getStatus());
				custFromServer.setPassword(null);
				session.setAttribute(Constants.LOGGED_IN_USER, custFromServer);
				session.setAttribute("count", 0); // for showing license expiry alert
				mav.setViewName(ForwardConstants.REDIRECT_HOME);
			} else {
				if (custFromServer.getMessage().equalsIgnoreCase("License Expired")) {
					result.reject("Failed.user.invalid.explicense");
					mav.addObject("msg", "explicense");
				} else if (custFromServer.getMessage().contains("You have no license!")) {
					result.reject("Failed.user.invalid.nolicense");
					mav.addObject("msg", "nolicense");
				} else
					result.reject("Failed.user.invalid");
			}
		}

		return mav;
	}

	@RequestMapping(value = "/logout",
					method = RequestMethod.GET)
	public ModelAndView logout(	Model model,
								HttpSession session) {
		logger.debug("in logout...");
		ModelAndView mav = new ModelAndView();
		if (session.getAttribute(Constants.LOGGED_IN_USER) != null) {
			session.removeAttribute(Constants.LOGGED_IN_USER);
			session.removeAttribute(Constants.LOGGED_IN_STORE);
			session.removeAttribute(Constants.ALL_UNPAIDORDER_LIST);
			session.removeAttribute(Constants.MENU_ALL_TREE);
			session.removeAttribute("count");
			session.removeAttribute(Constants.RETURN_TYPELIST);
		}
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		model.addAttribute("user", new User());
		return mav;
	}

	@RequestMapping(value = "/addlicensekey/{lickey}",
					method = RequestMethod.GET)
	public ModelAndView addStoreLicenseInformation(	@PathVariable("lickey") String lickey,
													Model model,
													HttpSession session,
													HttpServletRequest request,
													HttpServletResponse response) throws IOException {
		logger.debug("In addlicensekey  Details......{},{}", lickey);
		KeyBean keyBean = loginService.addStoreLicenseInformation(lickey.trim());
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/plain");
		out.print(new Gson().toJson(keyBean));
		out.flush();
		return null;
	}
}
