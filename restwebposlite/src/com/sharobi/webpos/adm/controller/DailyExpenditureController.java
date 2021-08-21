package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.sharobi.webpos.adm.model.DailyExpenditure;
import com.sharobi.webpos.adm.model.DailyExpenditureType;
import com.sharobi.webpos.adm.service.DailyExpenditureService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/expendituremgmt")
public class DailyExpenditureController {
	private final static Logger logger=LogManager.getLogger(DailyExpenditureController.class);
	private final static DailyExpenditureService dailyexpmgmt=new DailyExpenditureService();
	@RequestMapping("/loadexpendituremgmt")
	public ModelAndView viewExpenditureMgmt(Model model,HttpSession session){
		logger.debug("In expmgmt......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<DailyExpenditureType> expenditureTypes = dailyexpmgmt.getExpenditureTypes(); // new
		mav.addObject("expenditureTypes",expenditureTypes); // new
		session.setAttribute(Constants.ADMINEXPENDITURE_TYPELIST, new Gson().toJson(expenditureTypes).toString()); //new
		logger.debug("response String {}", new Gson().toJson(expenditureTypes).toString()); //new
		
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_EXP_MGMT_PAGE);
		return mav;
	}
	
	@RequestMapping("/viewdailyexpenditure")
	public ModelAndView viewDailyExpenditure(Model model,HttpSession session){
		logger.debug("In viewdailyexpenditure......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<DailyExpenditureType> expenditureTypes = dailyexpmgmt.getExpenditureTypes(); // new
		mav.addObject("expenditureTypes",expenditureTypes); // new
		
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_DAILY_EXP_PAGE);
		return mav;
	}
	
	
	/*@RequestMapping("/addexpenditure/{vocDate}/{vocNo}/{vocPart}/{expAmt}")
	public void addDailyExpenditure(@PathVariable("vocDate") String vocDate,@PathVariable("vocNo") String vocNo,@PathVariable("vocPart") String vocPart,@PathVariable("expAmt") String expAmt,HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("In addexpenditure......{},{},{},{}",vocDate,vocNo,vocPart,expAmt);
		Customer customer=null;
		DailyExpenditure dailyExpenditure = new DailyExpenditure();
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			dailyExpenditure.setVoucherDate(vocDate);
			dailyExpenditure.setVoucherId(Integer.parseInt(vocNo));
			dailyExpenditure.setParticulars(vocPart);
			dailyExpenditure.setAmount(Double.parseDouble(expAmt));
			dailyExpenditure.setStoreId(customer.getStoreId());
			dailyExpenditure.setCreatedBy(customer.getContactNo());
			dailyExpenditure.setCreatedDate(sdf.format(new Date()));
			System.out.println(dailyExpenditure.toString());
			String res=dailyexpmgmt.addDailyExpenditure(dailyExpenditure);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}

	}*/
	
	
	@RequestMapping(value = "/addexpenditure", method=RequestMethod.POST)
	public void addDailyExpenditure(@RequestBody String expanditureString,HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("In addexpenditure......{},{},{},{}",expanditureString);
		Customer customer=null;
		DailyExpenditure dailyExpenditure = new DailyExpenditure();
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			/*dailyExpenditure.setVoucherDate(vocDate);
			dailyExpenditure.setVoucherId(Integer.parseInt(vocNo));
			dailyExpenditure.setParticulars(vocPart);
			dailyExpenditure.setAmount(Double.parseDouble(expAmt));*/
			
			Gson gson = new GsonBuilder().create();
			DailyExpenditure dailyExpObj =gson.fromJson(expanditureString, new TypeToken<DailyExpenditure>() {
			}.getType());
			
			dailyExpObj.setStoreId(customer.getStoreId());
			dailyExpObj.setCreatedBy(customer.getContactNo());
			dailyExpObj.setCreatedDate(sdf.format(new Date()));
			System.out.println(dailyExpObj.toString());
			String res=dailyexpmgmt.addDailyExpenditure(dailyExpObj);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}

	}
	
	
	
	
	
	@RequestMapping("/loaddailyexpenditure/{date}/{storeId}")
	public void loadDailyExpenditure(@PathVariable("date") String date,@PathVariable("storeId") int storeId,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
		logger.debug("In loaddailyexpenditure......{},{}",date,storeId);
		DailyExpenditureService dailyExpenditureService = new DailyExpenditureService();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=dailyExpenditureService.getDailyExpenditure(date, storeId);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
		
	}
	
	
	@RequestMapping("/loadperiodexpenditure/{fromdate}/{todate}/{storeId}")
	 public void loadPeriodExpenditure(@PathVariable("fromdate") String fromdate,@PathVariable("todate") String todate,@PathVariable("storeId") int storeId,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
	  logger.debug("In loaddailyexpenditure......{},{},{}",fromdate,todate,storeId);
	  DailyExpenditureService dailyExpenditureService = new DailyExpenditureService();
	  Customer customer=null;
	  if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	  {
	   PrintWriter out = response.getWriter();
	   response.setContentType("text/plain");
	   String res=dailyExpenditureService.getPeriodExpenditure(fromdate, todate, storeId);
	   System.out.println("res:"+res);
	   out.print(res);
	   out.flush();
	  }
	  
	 }
	
	
	@RequestMapping(value = "/editdailyexp",method = RequestMethod.POST)
	public void editDailyExp(@RequestBody String dailyexpenditure,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("In editdailyexpenditure......{}", dailyexpenditure);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		DailyExpenditureService dailyExpenditureService = new DailyExpenditureService();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			DailyExpenditure dailyexpenditureob =gson.fromJson(dailyexpenditure, new TypeToken<DailyExpenditure>() {
			}.getType());
			dailyexpenditureob.setStoreId(customer.getStoreId());
			dailyexpenditureob.setUpdatedBy(customer.getContactNo());
			dailyexpenditureob.setUpdatedDate(sdf.format(new Date()));
		    String res = dailyExpenditureService.editDailyExp(dailyexpenditureob);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}	
	
	
@RequestMapping(value = "/deleteexpenditure/{id}",method = RequestMethod.GET)
public void deleteVendor(@PathVariable("id") String id,
						HttpSession session,
						HttpServletResponse response) throws IOException {
logger.debug("In deleteexpenditure......{}", id);
DailyExpenditureService dailyExpenditureService = new DailyExpenditureService();
DailyExpenditure dailyexpob = new DailyExpenditure();
dailyexpob.setId(Integer.parseInt(id));
Customer customer = null;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	dailyexpob.setStoreId(customer.getStoreId());
	String res = dailyExpenditureService.deleteexpenditure(dailyexpob);
	System.out.println("res:" + res);
	out.print(res);
	out.flush();
}
}
	
	
	
	
}


