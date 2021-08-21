/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.InvType;
import com.sharobi.webpos.adm.model.InventoryInvoicePayment;
import com.sharobi.webpos.adm.model.Vendor;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.adm.service.VendorMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.rm.model.FgInvoicePayment;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/vendormgnt")
public class VendorMgntController {
	private final static Logger logger=LogManager.getLogger(VendorMgntController.class);
	private final static VendorMgntService vendormgntService=new VendorMgntService();
	private final static InventoryMgntService inventorymgntService=new InventoryMgntService();
	
	@RequestMapping(value="/loadvendormgnt",method=RequestMethod.GET)
	public ModelAndView loadVendorMgnt(HttpSession session)
	{
		logger.debug("in loadvendormgnt...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Vendor> vendorList=vendormgntService.getVendorList(customer.getStoreId());
		List<InvType> invtypeList=inventorymgntService.getInvTypeList(customer.getStoreId());
		mav.addObject("vendorList",vendorList);
		mav.addObject("invTypeList",invtypeList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_VENDOR_MGNT_PAGE);
		return mav;
	}
	
/*	@RequestMapping(value="/addvendor/{name}/{code}/{desc}/{rating}/{contact}/{address}/{type}",method=RequestMethod.GET)
	public void addVendor(@PathVariable("name") String name,@PathVariable("code") String code,@PathVariable("desc") String desc,@PathVariable("rating") String rating,@PathVariable("contact") String contact,@PathVariable("address") String address,@PathVariable("type") String type,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addvendor......{},{},{},{},{},{},{}",name,code,desc,rating,contact,address,type);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Vendor vendor=new Vendor();
			vendor.setName(name);
			vendor.setCode(code);
			vendor.setDescription(desc);
			vendor.setRating(NumberUtils.toInt(rating));
			vendor.setContactNo(contact);
			vendor.setAddress(address);
			vendor.setType(type);
			vendor.setStoreId(customer.getStoreId());
			vendor.setCreatedBy(customer.getName());
			vendor.setCreatedDate(getTodayDate());
			String res=vendormgntService.addVendor(vendor);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	
	@RequestMapping(value="/addvendor",method=RequestMethod.POST)
	public void addVendor(@RequestBody String vendorpost,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addvendor......{}",vendorpost);
		System.out.println("vendorpost:"+vendorpost);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			//request.setCharacterEncoding("UTF-8");
			response.setContentType("text/plain");
			//response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			//response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Vendor vendor =gson.fromJson(vendorpost, new TypeToken<Vendor>() {
			}.getType());
			//vendor.setStoreId(customer.getStoreId());
			//vendor.setCreatedBy(customer.getName());
			vendor.setCreatedDate(getTodayDate());
			System.out.println("date:"+getTodayDate());
			String res=vendormgntService.addVendor(vendor);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	/*@RequestMapping(value="/editvendor/{id}/{name}/{code}/{desc}/{rating}/{contact}/{address}/{type}/{crby}",method=RequestMethod.GET)
	public void editVendor(@PathVariable("id") String id,@PathVariable("name") String name,@PathVariable("code") String code,@PathVariable("desc") String desc,@PathVariable("rating") String rating,@PathVariable("contact") String contact,@PathVariable("address") String address,@PathVariable("type") String type,@PathVariable("crby") String crby,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editvendor......{},{},{},{},{},{},{},{},{}",id,name,code,desc,rating,contact,address,type,crby);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Vendor vendor=new Vendor();
			vendor.setId(NumberUtils.toInt(id));
			vendor.setName(name);
			vendor.setCode(code);
			vendor.setDescription(desc);
			vendor.setRating(NumberUtils.toInt(rating));
			vendor.setContactNo(contact);
			vendor.setAddress(address);
			vendor.setType(type);
			vendor.setStoreId(customer.getStoreId());
			vendor.setUpdatedBy(customer.getName());
			vendor.setDeleteFlag("N");
			vendor.setCreatedBy(crby);
			vendor.setCreatedDate(getTodayDate());
			vendor.setUpdatedDate(getTodayDate());
			String res=vendormgntService.editVendor(vendor);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	
	@RequestMapping(value="/editvendor",method=RequestMethod.POST)
	public void editVendor(@RequestBody String vendoreditPost,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editvendor......{}",vendoreditPost);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			Vendor vendor =gson.fromJson(vendoreditPost, new TypeToken<Vendor>() {
			}.getType());
			/*Vendor vendor=new Vendor();
			vendor.setId(NumberUtils.toInt(id));
			vendor.setName(name);
			vendor.setCode(code);
			vendor.setDescription(desc);
			vendor.setRating(NumberUtils.toInt(rating));
			vendor.setContactNo(contact);
			vendor.setAddress(address);
			vendor.setType(type);
			vendor.setStoreId(customer.getStoreId());
			vendor.setUpdatedBy(customer.getName());
			vendor.setDeleteFlag("N");
			vendor.setCreatedBy(crby);*/
			vendor.setCreatedDate(getTodayDate());
			vendor.setUpdatedDate(getTodayDate());
			String res=vendormgntService.editVendor(vendor);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/deletevendor/{id}",method=RequestMethod.GET)
	public void deleteVendor(@PathVariable("id") String id,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletevendor......{}",id);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=vendormgntService.deleteVendor(NumberUtils.toInt(id), customer.getStoreId());
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
	
	
	// vendor payment management part start
	
		@RequestMapping(value="/loadvendorpayment",method=RequestMethod.GET)
		public ModelAndView loadVendorPayment(HttpSession session)
		{
			logger.debug("in loadvendorpayment...! ");
			ModelAndView mav=new ModelAndView();
			Customer customer=null;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
			{
				mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
				return mav;
			}
			List<Vendor> vendorList=vendormgntService.getVendorList(customer.getStoreId());
			Vendor vendor=new Vendor();
			List<InventoryInvoicePayment> invInvoiceList=new ArrayList<InventoryInvoicePayment>();
			if(vendorList.size()>0)
			{
				vendor=vendorList.get(0);
				invInvoiceList=vendormgntService.getPaymentInfoByvendorId(vendor.getId(), customer.getStoreId());
				mav.addObject("vendorDetail",vendor);
				mav.addObject("invInvoiceList",invInvoiceList);
			}
			mav.addObject("vendorList",vendorList);
			mav.addObject(Constants.ADMIN,"Y");
			mav.setViewName(ForwardConstants.VIEW_VENDOR_PAYMENT_PAGE);
			return mav;
		}
		@RequestMapping(value="/getvendorpaymentinfobyid/{vendorId}",method=RequestMethod.GET)
		public void getcreditOrderByustId(@PathVariable("vendorId") int vendorId,HttpSession session,HttpServletResponse response)throws IOException
		{
			logger.debug("in getvendorpaymentinfobyid...{}",vendorId);
			Customer customer;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				List<InventoryInvoicePayment> invInvoiceList=new ArrayList<InventoryInvoicePayment>();
				invInvoiceList=vendormgntService.getPaymentInfoByvendorId(vendorId, customer.getStoreId());
				out.print(new Gson().toJson(invInvoiceList, new TypeToken<List<InventoryInvoicePayment>>() {}.getType()));
				out.flush();
			}
		}
		@RequestMapping(value = "/vendorpayment/{invoiceno}/{pono}/{invoicedate}/{vendorid}/{billamount}/{paidAmount}/{amountToPay}",
				method = RequestMethod.GET)
		public void vendorPayment(	@PathVariable("invoiceno") String invoiceno,
							@PathVariable("pono") String pono,
							@PathVariable("invoicedate") String invoicedate,
							@PathVariable("vendorid") String vendorid,
							@PathVariable("billamount") String billamount,
							@PathVariable("paidAmount") String paidAmount,
							@PathVariable("amountToPay") String amountToPay,
							HttpSession session,
							HttpServletResponse response) throws IOException {
			logger.debug("in vendorpayment...{},{},{},{},{},{},{}", invoiceno,pono,invoicedate,vendorid, billamount, paidAmount, amountToPay);
			Customer customer;
			if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
				Date currDate = new Date(); 
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				InventoryInvoicePayment payment=new InventoryInvoicePayment();
				payment.setPoId(NumberUtils.toInt(pono));
				payment.setStockInId(NumberUtils.toInt(invoiceno));
				payment.setStockInDate(invoicedate);
				payment.setVendorId(NumberUtils.toInt(vendorid));
				payment.setStoreId(customer.getStoreId());
				payment.setBillAmount(NumberUtils.toDouble(billamount));
				payment.setPaidAmount(NumberUtils.toDouble(paidAmount));
				payment.setAmountToPay(NumberUtils.toDouble(amountToPay));
				payment.setDeleteFlag("N");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreatedDate(Utility.getFormatedDateShort(currDate));
				out.print(vendormgntService.vendorPayment(payment));
				out.flush();
				}

	}
		@RequestMapping(value="/payvendorbulkcashbycustid/{vendorId}/{tenderAmt}",method=RequestMethod.GET)
		public void payBulkCashByustId(@PathVariable("vendorId") int vendorId,@PathVariable("tenderAmt") double tenderAmt,HttpSession session,HttpServletResponse response)throws IOException
		{
			logger.debug("in payvendorbulkcashbycustid...{},{}",vendorId,tenderAmt);
			Customer customer;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				Date currDate = new Date(); 
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				List<InventoryInvoicePayment> invInvoiceList=new ArrayList<InventoryInvoicePayment>();
				invInvoiceList=vendormgntService.getPaymentInfoByvendorId(vendorId,customer.getStoreId());
				double finaltenderAmt=0.0;
				finaltenderAmt=tenderAmt;
				for(InventoryInvoicePayment invoices:invInvoiceList)
				{
					if(finaltenderAmt>0)
					{
					int invoiceno=invoices.getStockInId();
					int pono=invoices.getPoId();
					String invoicedate=invoices.getStockInDate();
					double billAmt=invoices.getBillAmount();
					double paidAmt=invoices.getPaidAmount();
					double amttoPay=invoices.getAmountToPay();
					if(finaltenderAmt>=amttoPay)
						{
						paidAmt=amttoPay;
						amttoPay=0.0;
						}
					else
						{
						paidAmt=finaltenderAmt;
						amttoPay=amttoPay-finaltenderAmt;
						}
					InventoryInvoicePayment payment1=new InventoryInvoicePayment();
					payment1.setPoId(pono);
					payment1.setStockInId(invoiceno);
					payment1.setStockInDate(invoicedate);
					payment1.setVendorId(vendorId);
					payment1.setStoreId(customer.getStoreId());
					payment1.setBillAmount(billAmt);
					payment1.setPaidAmount(paidAmt);
					payment1.setAmountToPay(amttoPay);
					payment1.setDeleteFlag("N");
					payment1.setCreatedBy(customer.getContactNo());
					payment1.setCreatedDate(Utility.getFormatedDateShort(currDate));
					String res=vendormgntService.vendorPayment(payment1);
					
					if("success".equals(res))
					{
						finaltenderAmt=finaltenderAmt-paidAmt;
					}
					System.out.println("finaltenderAmt:"+finaltenderAmt+"billAmt:"+billAmt+"paid amt:"+paidAmt+"amttoPay:"+amttoPay);
					}
					else
					{
						break;
					}
					
				}
				invInvoiceList=vendormgntService.getPaymentInfoByvendorId(vendorId, customer.getStoreId());
				out.print(new Gson().toJson(invInvoiceList, new TypeToken<List<InventoryInvoicePayment>>() {}.getType()));
				out.flush();
			}
		}
		
		

	//vendor payment management part end
	
	
	// FG Vendor Payment start
		
		@RequestMapping(value="/loadfgvendorpayment",method=RequestMethod.GET)
		public ModelAndView loadFgVendorPayment(HttpSession session)
		{
			logger.debug("in loadfgvendorpayment...! ");
			ModelAndView mav=new ModelAndView();
			Customer customer=null;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
			{
				mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
				return mav;
			}
			List<Vendor> vendorList=vendormgntService.getVendorList(customer.getStoreId());
			Vendor vendor=new Vendor();
			List<FgInvoicePayment> invInvoiceList=new ArrayList<FgInvoicePayment>();
			if(vendorList.size()>0)
			{
				vendor=vendorList.get(0);
				invInvoiceList=vendormgntService.getPaymentInfoByFgvendorId(vendor.getId(), customer.getStoreId());
				mav.addObject("vendorDetail",vendor);
				mav.addObject("invInvoiceList",invInvoiceList);
			}
			mav.addObject("vendorList",vendorList);
			mav.addObject(Constants.ADMIN,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGVENDOR_PAYMENT_PAGE);
			return mav;
		}
		
		@RequestMapping(value="/getfgvendorpaymentinfobyid/{vendorId}",method=RequestMethod.GET)
		public void getFGVendorPaymentInfoId(@PathVariable("vendorId") int vendorId,HttpSession session,HttpServletResponse response)throws IOException
		{
			logger.debug("in getfgvendorpaymentinfobyid...{}",vendorId);
			Customer customer;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				List<FgInvoicePayment> invInvoiceList=new ArrayList<FgInvoicePayment>();
				invInvoiceList=vendormgntService.getPaymentInfoByFgvendorId(vendorId, customer.getStoreId());
				out.print(new Gson().toJson(invInvoiceList, new TypeToken<List<FgInvoicePayment>>() {}.getType()));
				out.flush();
			}
		}
	
		@RequestMapping(value = "/fgvendorpayment/{invoiceno}/{invoicedate}/{vendorid}/{billamount}/{paidAmount}/{amountToPay}",
				method = RequestMethod.GET)
		public void fgVendorPayment(@PathVariable("invoiceno") String invoiceno,
							@PathVariable("invoicedate") String invoicedate,
							@PathVariable("vendorid") String vendorid,
							@PathVariable("billamount") String billamount,
							@PathVariable("paidAmount") String paidAmount,
							@PathVariable("amountToPay") String amountToPay,
							HttpSession session,
							HttpServletResponse response) throws IOException {
			logger.debug("in Fgvendorpayment...{},{},{},{},{},{},{}", invoiceno,invoicedate,vendorid, billamount, paidAmount, amountToPay);
			Customer customer;
			if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
				Date currDate = new Date(); 
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				FgInvoicePayment payment=new FgInvoicePayment();
				payment.setFgStockInId(NumberUtils.toInt(invoiceno));
				payment.setFgStockInDate(invoicedate);
				payment.setVendorId(NumberUtils.toInt(vendorid));
				payment.setStoreId(customer.getStoreId());
				payment.setBillAmount(NumberUtils.toDouble(billamount));
				payment.setPaidAmount(NumberUtils.toDouble(paidAmount));
				payment.setAmountToPay(NumberUtils.toDouble(amountToPay));
				payment.setDeleteFlag("N");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreatedDate(Utility.getFormatedDateShort(currDate));
				out.print(vendormgntService.fgVendorPayment(payment));
				out.flush();
				}

	}
		@RequestMapping(value="/payfgvendorbulkcashbycustid/{vendorId}/{tenderAmt}",method=RequestMethod.GET)
		public void payBulkCashByFgVendorId(@PathVariable("vendorId") int vendorId,@PathVariable("tenderAmt") double tenderAmt,HttpSession session,HttpServletResponse response)throws IOException
		{
			logger.debug("in payfgvendorbulkcashbycustid...{},{}",vendorId,tenderAmt);
			Customer customer;
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				Date currDate = new Date(); 
				PrintWriter out = response.getWriter();
				response.setContentType("text/plain");
				List<FgInvoicePayment> invInvoiceList=new ArrayList<FgInvoicePayment>();
				invInvoiceList=vendormgntService.getPaymentInfoByFgvendorId(vendorId,customer.getStoreId());
				double finaltenderAmt=0.0;
				finaltenderAmt=tenderAmt;
				for(FgInvoicePayment invoices:invInvoiceList)
				{
					if(finaltenderAmt>0)
					{
					int invoiceno=invoices.getFgStockInId();
					String invoicedate=invoices.getFgStockInDate();
					double billAmt=invoices.getBillAmount();
					double paidAmt=invoices.getPaidAmount();
					double amttoPay=invoices.getAmountToPay();
					if(finaltenderAmt>=amttoPay)
						{
						paidAmt=amttoPay;
						amttoPay=0.0;
						}
					else
						{
						paidAmt=finaltenderAmt;
						amttoPay=amttoPay-finaltenderAmt;
						}
					FgInvoicePayment payment1=new FgInvoicePayment();
					payment1.setFgStockInId(invoiceno);
					payment1.setFgStockInDate(invoicedate);
					payment1.setVendorId(vendorId);
					payment1.setStoreId(customer.getStoreId());
					payment1.setBillAmount(billAmt);
					payment1.setPaidAmount(paidAmt);
					payment1.setAmountToPay(amttoPay);
					payment1.setDeleteFlag("N");
					payment1.setCreatedBy(customer.getContactNo());
					payment1.setCreatedDate(Utility.getFormatedDateShort(currDate));
					String res=vendormgntService.fgVendorPayment(payment1);
					
					if("success".equals(res))
					{
						finaltenderAmt=finaltenderAmt-paidAmt;
					}
					System.out.println("finaltenderAmt:"+finaltenderAmt+"billAmt:"+billAmt+"paid amt:"+paidAmt+"amttoPay:"+amttoPay);
					}
					else
					{
						break;
					}
					
				}
				invInvoiceList=vendormgntService.getPaymentInfoByFgvendorId(vendorId, customer.getStoreId());
				out.print(new Gson().toJson(invInvoiceList, new TypeToken<List<FgInvoicePayment>>() {}.getType()));
				out.flush();
			}
		}
}
