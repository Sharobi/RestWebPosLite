/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.User;
import com.sharobi.webpos.adm.service.AdminService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;



/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	private final static Logger logger=LogManager.getLogger(AdminController.class);
	private final static AdminService adminService=new AdminService();
	
	@RequestMapping(value="/loginadminmodule/{pass}",method=RequestMethod.GET)
	public void deleteSubMenuCategory(@PathVariable("pass") String pass,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In loginadminmodule......{}",pass);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			User user=new User();
			user.setUserId(customer.getContactNo());
			user.setPassword(pass);
			user.setStoreId(customer.getStoreId());
			String res=adminService.dologinAdminModule(user);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	//	mav.addObject(Constants.ADMIN,"Y");

	}

}
