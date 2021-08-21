/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.sharobi.webpos.adm.model.TableMaster;
import com.sharobi.webpos.adm.model.Tables;
import com.sharobi.webpos.adm.service.TableMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;




/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/tablemgnt")
public class TableMgntController {
	private final static Logger logger=LogManager.getLogger(TableMgntController.class);
	private final static TableMgntService tablemgntService=new TableMgntService();
	private final static OrderService orderService=new OrderService();
	@RequestMapping(value="/loadtablemgnt",method=RequestMethod.GET)
	public ModelAndView loadTableMgnt(HttpSession session)
	{
		logger.debug("in loadtablemgnt...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Tables> tableListforMgnt=tablemgntService.getTableListforMgnt(customer.getStoreId());
		session.setAttribute("existingTableList", tableListforMgnt);
		List<Order> orderList=orderService.getUnpaidOrderList(customer.getStoreId(), getTodayDate());
		if(orderList.size()>0)
		{
			for(Order orders:orderList)
			{
				for(Tables tables:tableListforMgnt)
				{
					if(tables.getTableNo().equals(orders.getTable_no()))
					{
						tables.setIsBooked("Y");
					}
				}
			}
		}
		mav.addObject("tableListforMgnt", tableListforMgnt);
		mav.addObject(Constants.ADMIN,"Y");

		mav.setViewName(ForwardConstants.VIEW_TABLE_MGNT_PAGE);
		return mav;
	}
	/*@RequestMapping(value="/addtable/{tableno}/{seatingcapacity}/{desc}",method=RequestMethod.GET)
	public void addTable(@PathVariable("tableno") String tableno,@PathVariable("seatingcapacity") int seatingcapacity,@PathVariable("desc") String desc,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addtable......{},{},{}",tableno,seatingcapacity,desc);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableno.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				Tables tables =new Tables();
				tables.setTableNo(tableno);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());
				String res=tablemgntService.addTable(tables);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}
		}
	}*/
	
	@RequestMapping(value="/addtable",method=RequestMethod.POST)
	public void addTable(@RequestBody String tablepost,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addtable......{}",tablepost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Tables table=gson.fromJson(tablepost, new TypeToken<Tables>() {
			}.getType());
			String tableno=table.getTableNo();
			/*String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}*/
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableno.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				/*Tables tables =new Tables();
				tables.setTableNo(tableno);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());*/
				String res=tablemgntService.addTable(table);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}
		}
	}
	/*@RequestMapping(value="/edittable/{tableid}/{tableno}/{seatingcapacity}/{desc}/{multiorder}",method=RequestMethod.GET)
	public void editTable(@PathVariable("tableid") int tableid,@PathVariable("tableno") String tableno,@PathVariable("seatingcapacity") int seatingcapacity,@PathVariable("desc") String desc,@PathVariable("multiorder") String multiorder,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In edittable......{},{},{},{},{}",tableid,tableno,seatingcapacity,desc,multiorder);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			TableMaster tables=new TableMaster();
			tables.setId(tableid);
			tables.setTableNo(tableno);
			tables.setSeatingCapacity(seatingcapacity);
			tables.setTableDescription(desc);
			tables.setAvailableForOnlineBbooking((short) 1);
			tables.setDeleteFlag("N");
			tables.setStoreId(customer.getStoreId());
			tables.setStatus("Y");
			tables.setStyleId(""+1);
			tables.setMultiOrder(multiorder);
			String res=tablemgntService.editTable(tables);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
			
			String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableNo.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				Tables tables =new Tables();
				tables.setTableId(tableid);
				tables.setTableNo(tableNo);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());
				String res=tablemgntService.editTable(tables);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}
			
		}
	}*/
	
	@RequestMapping(value="/edittable",method=RequestMethod.POST)
	public void editTable(@RequestBody String TableeditPost,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In edittable......{}",TableeditPost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			TableMaster table=gson.fromJson(TableeditPost, new TypeToken<TableMaster>() {
			}.getType());
			/*TableMaster tables=new TableMaster();
			tables.setId(tableid);
			tables.setTableNo(tableno);
			tables.setSeatingCapacity(seatingcapacity);
			tables.setTableDescription(desc);*/
			table.setAvailableForOnlineBbooking((short) 1);
			table.setDeleteFlag("N");
			//tables.setStoreId(customer.getStoreId());
			table.setStatus("Y");
			table.setStyleId(""+1);
			//table.setMultiOrder(multiorder);
			String res=tablemgntService.editTable(table);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
			
			/*String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableNo.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				Tables tables =new Tables();
				tables.setTableId(tableid);
				tables.setTableNo(tableNo);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());
				String res=tablemgntService.editTable(tables);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}*/
			
		}
	}
	public synchronized List<Tables> getUpdatedTableList(String tabno,List<Tables> tabList)
	{
		for(Tables tab:tabList)
		{
			if(tabno.equals(tab.getTableNo()))
					{
				tabList.remove(tab);
					}
		}
		return tabList;
	}
	@RequestMapping(value="/deletetable/{tableid}",method=RequestMethod.GET)
	public void editTable(@PathVariable("tableid") int tableid,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletetable......{}",tableid);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=tablemgntService.deleteTable(tableid, customer.getStoreId());
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
