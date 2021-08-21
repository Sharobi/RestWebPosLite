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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;



import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.TaxesForAllItems;
import com.sharobi.webpos.adm.service.TaxMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/taxmgnt")
public class TaxMgntController {
	
	private final static Logger logger=LogManager.getLogger(TaxMgntController.class);
	private final static TaxMgntService taxmgntService=new TaxMgntService();
	
	@RequestMapping(value="/viewtaxmgnt",method=RequestMethod.GET)
	public ModelAndView loadTaxMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewtaxmgnt......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_TAX_MGNT_PAGE);

		return mav;
	}
	/*@RequestMapping(value="/updatetaxforallitem/{vattxt}/{vatamt}/{sttxt}/{stamt}",method=RequestMethod.GET)
	public void addSpecialNote(@PathVariable("vattxt") String vattxt,@PathVariable("vatamt") double vatamt,@PathVariable("sttxt") String sttxt,@PathVariable("stamt") double stamt,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In updatetaxforallitem......{},{},{},{}",vattxt,vatamt,sttxt,stamt);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			TaxesForAllItems taxesForAllItems=new TaxesForAllItems();
			taxesForAllItems.setStoreId(customer.getStoreId());
			if(!"null".equals(vattxt))
			{
				taxesForAllItems.setVatTaxText(vattxt);
				taxesForAllItems.setVatAmt(vatamt);
			}
			if(!"null".equals(sttxt))
			{
				taxesForAllItems.setServiceTaxText(sttxt);
				taxesForAllItems.setServiceTaxAmt(stamt);
			}
			//System.out.println("hh:"+taxesForAllItems.toString());
			String res=taxmgntService.updateTaxforAllItems(taxesForAllItems);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	
	@RequestMapping(value="/updatetaxforallitem",method=RequestMethod.POST)
	public void addSpecialNote(@RequestBody String taxString ,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In updatetaxforallitem......{},{},{},{}",taxString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			TaxesForAllItems taxesForAllItems=new TaxesForAllItems();
			
			/*taxesForAllItems.setStoreId(customer.getStoreId());
			if(!"null".equals(vattxt))
			{
				taxesForAllItems.setVatTaxText(vattxt);
				taxesForAllItems.setVatAmt(vatamt);
			}
			if(!"null".equals(sttxt))
			{
				taxesForAllItems.setServiceTaxText(sttxt);
				taxesForAllItems.setServiceTaxAmt(stamt);
			}*/
			
			Gson gson = new GsonBuilder().create();
			TaxesForAllItems taxObj =gson.fromJson(taxString, new TypeToken<TaxesForAllItems>() {
			}.getType());
			
			taxObj.setStoreId(customer.getStoreId());
			
			//System.out.println("hh:"+taxesForAllItems.toString());
			String res=taxmgntService.updateTaxforAllItems(taxObj);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
}
