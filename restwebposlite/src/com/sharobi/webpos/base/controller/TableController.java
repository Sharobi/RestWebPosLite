/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.nio.channels.SeekableByteChannel;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.base.model.ChildTable;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderItem;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.model.Table;
import com.sharobi.webpos.base.model.TableCombo;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.TableService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.vfd.Display;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/table")
public class TableController {
	private final static Logger logger=LogManager.getLogger(TableController.class);
	private final static TableService tableService=new TableService();
	private final static MenuService menuService=new MenuService();
	private final static OrderService orderService=new OrderService();
	
	@RequestMapping(value="/viewtable",method=RequestMethod.GET)
	public ModelAndView getTableList(Model model,HttpSession session)
	{
		logger.debug("In Table......");
		ModelAndView mav = new ModelAndView();
		List<ChildTable> childtableList=new ArrayList<ChildTable>();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Table> tableList=tableService.getTableList(customer.getStoreId());
		List<Order> unpaidOrderList=orderService.getUnpaidOrderList(customer.getStoreId(), getTodayDate());
		session.setAttribute(Constants.ALL_UNPAIDORDER_LIST, unpaidOrderList);
		DecimalFormat df=new DecimalFormat("00.00");
		Store store=null;
		store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
		if(tableList.size()>0)
		{
			for(Table tables:tableList)
			{
				List<Order> orderList=new ArrayList<Order>();
				if(unpaidOrderList.size()>0)
				{
					for(Order orders:unpaidOrderList)
					{
						if(tables.getTableNo().equals(orders.getTable_no()))
						{
							double staticVat=14.5;
							double staticST=5.6;
							double totVat = 0;
							double totST = 0;
							double totRate = 0;
							double totDisc = 0;
							double totAmt;
							for(OrderItem items:orders.getOrderitem())
							{
								double disc=0;
								double rate=0;
								double vat=0;
								double ST=0;
								rate=items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem());
								if(items.getItem().getPromotionFlag().equalsIgnoreCase("Y"))
								{
									disc=(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem());
								}
								if(store.getId()==35 && !orders.getTable_no().equals("0") && items.getItem().getVat()==0.0)
								{
									vat=Double.parseDouble(df.format((rate-disc)*(staticVat/100)));
								}
								else{
									vat=Double.parseDouble(df.format((rate-disc)*(items.getItem().getVat()/100)));
								}
								if(store.getId()==35 && !orders.getTable_no().equals("0") && items.getItem().getServiceTax()==0.0)
								{
									ST=Double.parseDouble(df.format((rate-disc)*(staticST/100)));
								}
								else{
									ST=Double.parseDouble(df.format((rate-disc)*(items.getItem().getServiceTax()/100)));
								}
								//vat=Double.parseDouble(df.format((rate-disc)*(items.getItem().getVat()/100)));
								//ST=Double.parseDouble(df.format((rate-disc)*(items.getItem().getServiceTax()/100)));
								totRate+=rate;
								totDisc+=disc;
								totVat+=vat;
								totST+=ST;
							}
							totAmt=(totRate+totVat+totST)-totDisc;
							if(store.getRoundOffTotalAmtStatus().equalsIgnoreCase("Y"))
							{
								totAmt=Math.round(totAmt);
							}
							StringTokenizer st2 = new StringTokenizer(orders.getChildTables(), "/");
							while(st2.hasMoreElements())
							{
								ChildTable cdT=new ChildTable();
								cdT.setChildTableNo(st2.nextElement().toString());
								cdT.setParentTableNo(orders.getTable_no());
								childtableList.add(cdT);
							}
							if(store.getMultiOrderTable().equalsIgnoreCase("Y") && tables.getMultiOrder().equalsIgnoreCase("Y"))
							{
								orderList.add(orders);
								tables.setIsBooked("Y");
							}
							else
							{
								tables.setOrder(orders);
								tables.setIsBooked("Y");
								tables.setNoofItem(orders.getOrderitem().size());
								tables.setOrderAmt(Double.parseDouble(df.format(totAmt)));
							}
						}
						
					}
					tables.setMultiOrders(orderList);
					tables.setNoofOrder(orderList.size());
				}
				if(childtableList.size()>0)
				{
					for(ChildTable cdt:childtableList)
					{
						if(tables.getTableNo().equals(cdt.getChildTableNo()))
						{
							tables.setIsBooked("Y");
							tables.setIschildTable("Y");
							tables.setParentTable(cdt.getParentTableNo());
						}
					}
				}
			}
		}
		/*if(store.getMultiOrderTable().equalsIgnoreCase("N"))
		{
			if(unpaidOrderList.size()>0)
			{
				for(Order orders:unpaidOrderList){
					double totVat = 0;
					double totST = 0;
					double totRate = 0;
					double totDisc = 0;
					double totAmt;
					for(OrderItem items:orders.getOrderitem())
					{
						double disc=0;
						double rate=0;
						double vat=0;
						double ST=0;
						//totVat+=Double.parseDouble(df.format(((items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem()))-(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem()))*items.getItem().getVat()/100));
						 //totST+=Double.parseDouble(df.format(((items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem()))-(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem()))*items.getItem().getServiceTax()/100));
						rate=items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem());
						if(items.getItem().getPromotionFlag().equalsIgnoreCase("Y"))
						{
							disc=(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem());
						}
						
						vat=Double.parseDouble(df.format((rate-disc)*(items.getItem().getVat()/100)));
						ST=Double.parseDouble(df.format((rate-disc)*(items.getItem().getServiceTax()/100)));
						totRate+=rate;
						totDisc+=disc;
						totVat+=vat;
						totST+=ST;
						//System.out.println("vat:"+vat+":ST:"+ST+":disc:"+disc+":rate:"+rate);
						//System.out.println("totvat:"+totVat+":totST:"+totST+":totdisc:"+totDisc+":totrate:"+totRate);
					}
					totAmt=(totRate+totVat+totST)-totDisc;
					//Store store;
					if(store!=null)
					{
						if(store.getRoundOffTotalAmtStatus().equalsIgnoreCase("Y"))
						{
							totAmt=Math.round(totAmt);
						}
					}
					StringTokenizer st2 = new StringTokenizer(orders.getChildTables(), "/");
					while(st2.hasMoreElements())
					{
						ChildTable cdT=new ChildTable();
						cdT.setChildTableNo(st2.nextElement().toString());
						cdT.setParentTableNo(orders.getTable_no());
						childtableList.add(cdT);
						//System.out.println("child tables:"+st2.nextElement());
						
					}
					//System.out.println("amt:"+Double.parseDouble(df.format(totAmt)));
					for(Table tables:tableList)
					{
						if(tables.getTableNo().equals(orders.getTable_no()))
						{
							
							tables.setOrder(orders);
							tables.setIsBooked("Y");
							tables.setNoofItem(orders.getOrderitem().size());
							tables.setOrderAmt(Double.parseDouble(df.format(totAmt)));
							
						}
						
					}
					
					
				}
				
			}
			if(childtableList.size()>0)
			{
				for(ChildTable cdt:childtableList)
				{
					for(Table tables:tableList)
					{
						if(tables.getTableNo().equals(cdt.getChildTableNo()))
						{
							tables.setIsBooked("Y");
							tables.setIschildTable("Y");
							tables.setParentTable(cdt.getParentTableNo());
						}
					}
				}
			}
		}
		else
		{
			if(unpaidOrderList.size()>0)
			{
				for(Order orders:unpaidOrderList){
					double totVat = 0;
					double totST = 0;
					double totRate = 0;
					double totDisc = 0;
					double totAmt;
					for(OrderItem items:orders.getOrderitem())
					{
						double disc=0;
						double rate=0;
						double vat=0;
						double ST=0;
						//totVat+=Double.parseDouble(df.format(((items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem()))-(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem()))*items.getItem().getVat()/100));
						 //totST+=Double.parseDouble(df.format(((items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem()))-(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem()))*items.getItem().getServiceTax()/100));
						rate=items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem());
						if(items.getItem().getPromotionFlag().equalsIgnoreCase("Y"))
						{
							disc=(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem());
						}
						
						vat=Double.parseDouble(df.format((rate-disc)*(items.getItem().getVat()/100)));
						ST=Double.parseDouble(df.format((rate-disc)*(items.getItem().getServiceTax()/100)));
						totRate+=rate;
						totDisc+=disc;
						totVat+=vat;
						totST+=ST;
						//System.out.println("vat:"+vat+":ST:"+ST+":disc:"+disc+":rate:"+rate);
						//System.out.println("totvat:"+totVat+":totST:"+totST+":totdisc:"+totDisc+":totrate:"+totRate);
					}
					totAmt=(totRate+totVat+totST)-totDisc;
					//Store store;
					if(store!=null)
					{
						if(store.getRoundOffTotalAmtStatus().equalsIgnoreCase("Y"))
						{
							totAmt=Math.round(totAmt);
						}
					}
					StringTokenizer st2 = new StringTokenizer(orders.getChildTables(), "/");
					while(st2.hasMoreElements())
					{
						ChildTable cdT=new ChildTable();
						cdT.setChildTableNo(st2.nextElement().toString());
						cdT.setParentTableNo(orders.getTable_no());
						childtableList.add(cdT);
						//System.out.println("child tables:"+st2.nextElement());
						
					}
					//System.out.println("amt:"+Double.parseDouble(df.format(totAmt)));
					List<Order> orderList=new ArrayList<Order>();
					for(Table tables:tableList)
					{
						
						if(tables.getTableNo().equals(orders.getTable_no()))
						{
							
							if(tables.getMultiOrder().equalsIgnoreCase("N"))
							{
								tables.setOrder(orders);
								tables.setIsBooked("Y");
								tables.setNoofItem(orders.getOrderitem().size());
								tables.setOrderAmt(Double.parseDouble(df.format(totAmt)));
							}
							else
							{	
								
								orderList.add(orders);
								tables.setMultiOrders(orderList);
								tables.setIsBooked("Y");
								tables.setNoofOrder(orderList.size());
							}
							
						}
						
					}
					
					
				}
				
			}
			if(childtableList.size()>0)
			{
				for(ChildTable cdt:childtableList)
				{
					for(Table tables:tableList)
					{
						if(tables.getTableNo().equals(cdt.getChildTableNo()))
						{
							tables.setIsBooked("Y");
							tables.setIschildTable("Y");
							tables.setParentTable(cdt.getParentTableNo());
						}
					}
				}
			}
			for(Table tables:tableList)
			{
				List<Order> orderList=new ArrayList<Order>();
				for(Order orders:unpaidOrderList){
					//orderList=
					if(tables.getTableNo().equals(orders.getTable_no()))
					{
						
						if(tables.getMultiOrder().equalsIgnoreCase("Y"))
						{
							orderList.add(orders);
							tables.setIsBooked("Y");
						}
					}
					
					
				}
				tables.setMultiOrders(orderList);
				tables.setNoofOrder(orderList.size());
				
			}	
		}*/
		/*try{Display display=new Display();
		display.StartDisplay();
		display.ShowGreeting();
		}
		catch(Exception ex){ex.printStackTrace();}*/
		System.out.println("Tables:"+tableList.toString());
		//model.addAttribute("table",new Table());
		mav.addObject("tableList", tableList);
		session.setAttribute("TableList", tableList);
		mav.setViewName(ForwardConstants.VIEW_TABLE_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/updatetableStatus/{tid}/{op}",method=RequestMethod.GET)
	public void upadateTableStatus(@PathVariable("tid") int tid,@PathVariable("op") int op,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in update table status...! {}, {}", tid, op);
		TableCombo table=new TableCombo();
		Customer customer;
		try{
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				table.setId(tid);
				table.setStatus(this.getStatusString(op));
				tableService.updateTableSatus(table);
			}
			
		}catch (Exception e) {
			logger.error("Exception:",e);
		}
	}
	
	private String getStatusString(int operationId) {
		return operationId == 1 ? "Y" : "N";
	}
	
	/*@RequestMapping(value="/bookingTable/{tableId}/{tableNo}",method=RequestMethod.GET)
	public ModelAndView bookingTable(@PathVariable("tableId") int tableId,@PathVariable("tableNo") int tableNo,Model model,HttpSession session)throws IOException
	{
		logger.debug("in booking table...! {}, {}", tableId, tableNo);
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Menu allMenuList=menuService.getAllMenuList(customer.getStoreId());
		session.setAttribute(Constants.MENU_ALL_TREE,allMenuList);
		mav.addObject("allmenu",allMenuList);
		mav.addObject("tableId",tableId);
		mav.addObject("tableNo",tableNo);
		mav.setViewName("redirect:/order/vieworder");
		return mav;
	}*/
	
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
