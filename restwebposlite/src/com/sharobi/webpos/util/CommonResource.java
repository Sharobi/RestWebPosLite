/**
 * 
 */
package com.sharobi.webpos.util;

import java.lang.reflect.Type;
import java.util.Properties;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;


/**
 * @author habib
 * 
 */
public class CommonResource {

	private final static Logger logger = LogManager.getLogger(CommonResource.class);
	private final static Properties resourceProperties = getProperties();

	public static final String DATE_FORMAT_GSON = "date.format.gson";
	public static final String DATE_FORMAT_GSON_TABLE = "date.format.gson.table";
	public static final String DATE_FORMAT_SHORT = "date.format.short";

	public static final String TARGET_WEBSERVICE_ENDPOINT = "target.webservice.endpoint";
	/*Start Login module*/
	public final static String WEBSERVICE_LOGIN = "webservice.login";
	public final static String WEBSERVICE_LICENSE = "webservice.admin.module.license";
	public final static String WEBSERVICE_LOGIN_POSHEADER = "webservice.login.posheader";
	public final static String WEBSERVICE_LOGIN_GETALLWAITERS = "webservice.login.getallwaiters";
	/*End Login module*/

	/*Start Base module*/
	public final static String WEBSERVICE_STORE_BYID = "webservice.store.byid";
	public final static String WEBSERVICE_TABLE_GETLIST = "webservice.table.getlist";
	public final static String WEBSERVICE_UPDATE_TABLE_STATUS = "webservice.update.table.status";
	public final static String WEBSERVICE_MENU_GETLIST = "webservice.menu.getlist";
	public final static String WEBSERVICE_ORDER_GETUNPAIDORDERLIST = "webservice.order.getUnpaidOrderlist";
	public final static String WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYDATE="webservice.order.getAllUnpaidorderlistbyDate";
	public final static String WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYPERIOD="webservice.order.getAllUnpaidorderlistbyPeriod";
	public final static String WEBSERVICE_ORDER_SAVE = "webservice.order.save";
	public final static String WEBSERVICE_ORDER_BILL_PRINT = "werservice.order.bill.print";
	public final static String WEBSERVICE_BILL_PAYMENTINFO = "webservice.bill.paymentinfo";
	public final static String WEBSERVICE_BILL_PAYMENT = "webservice.bill.payment";
	public final static String WEBSERVICE_ORDER_TYPE = "webservice.order.type";//by SAYANI
	public final static String WEBSERVICE_BILL_GETBILLBYID = "webservice.bill.getbillbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETORDERBYID = "webservice.unpaid.order.getorderbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYID = "webservice.unpaid.order.getunpaidorderdetailsbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETORDERBYID_FOR_SPLITBILL = "webservice.unpaid.order.getorderbyid.for.splitbill";
	public final static String WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM = "webservice.unpaid.order.update.orderitem";
	public final static String WEBSERVICE_UNPAID_ORDER_CANCEL = "webservice.unpaid.order.cancel";
	public final static String WEBSERVICE_UNPAID_ORDER_CANCEL_POST = "webservice.unpaid.order.cancel.post";
	public final static String WEBSERVICE_UNPAID_ORDER_SETREMARKS = "webservice.unpaid.order.setremarks";
	public final static String WEBSERVICE_UNPAID_ORDER_SETPACKAGINGNOTE = "webservice.unpaid.order.setpackagingnote";
	public final static String WEBSERVICE_ORDER_GET_BILLPRINT_COUNT = "webservice.order.get.billprint.count";
	public final static String WEBSERVICE_ORDER_UPDATE_BILLPRINT_COUNT = "webservice.order.update.billprint.count";
	public final static String WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM_POST = "webservice.unpaid.order.update.orderitem.post";//Sayani
	public final static String WEBSERVICE_BILL_ADDDISCOUNT = "webservice.bill.adddiscount";
	public final static String WEBSERVICE_ORDER_GETSPLNOTEBYITEMID = "webservice.order.getspecialnotebyitemid";
	public final static String WEBSERVICE_ORDER_UPDATE_CREDITSALE = "webservice.order.update.creditsale";
	public final static String WEBSERVICE_ORDER_UPDATE_PAX = "webservice.order.update.pax";
	public final static String WEBSERVICE_ORDER_GETALLPAIDORDER = "webservice.order.getallpaidorder";
	public final static String WEBSERVICE_ORDER_UPDATE_TABLE = "webservice.order.update.table";
	public final static String WEBSERVICE_ORDER_GETPAYMENTTYPEBYSTORE = "webservice.order.getPaymentTypeByStore";
	public final static String WEBSERVICE_BILL_SPLIT_M = "webservice.order.split.bill.m";
	public final static String WEBSERVICE_BILL_SPLIT_PRINT = "webservice.order.split.bill.print";
	public final static String WEBSERVICE_ORDER_KOT_CHECKLIST_PRINT="webservice.order.kot.checklist.print";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYPHNO = "webservice.order.getcustomerdetails.byphno";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_BYCONTACT = "webservice.order.getcustomerdetails.bycontact";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_BYID = "webservice.order.getcustomerdetails.byid";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERCONTACT = "webservice.order.getcustomercontact";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYNAME = "webservice.order.getcustomerdetails.byname";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_LOCATION = "webservice.order.getcustomer.location";
	public final static String WEBSERVICE_ORDER_GETTOTALTRANSACTION_CUSTID="webservice.order.gettotaltransactionpercustomer.bycustid";
	public final static String WEBSERVICE_ORDER_GETLASTVISITDATE_CUSTID="webservice.order.getlastvisitdate.bycustid";
	public final static String WEBSERVICE_ORDER_GETTOTALPAIDAMOUNT_CUSTID="webservice.order.gettotalpaidamount.bycustid";
	public final static String WEBSERVICE_ORDER_GETCUSTMOSTPURCHASEITEM_CUSTID="webservice.order.getcustmostpurchaseitem.bycustid";
	public final static String WEBSERVICE_ORDER_GETCUSTTRANSACTIONSUMMARY_CUSTID="webservice.order.getcusttransactionsummary.bycustid";
	public final static String WEBSERVICE_UNPAID_ORDER_SERVICECHARGE="webservice.unpaid.order.servicecharge";
	/*End Base module*/
	
	/*Start Billing module*/
	public final static String WEBSERVICE_SPLIT_BILL_MANUAL_BYORDERID="webservice.split.bill.manual.byorderid";
	public final static String WEBSERVICE_PRINT_BILL_CASH="webservice.print.bill.cash";
	/*End Billing module*/
	
	/*Start Admin module*/
	public final static String WEBSERVICE_ADMIN_MODULE_LOGIN = "webservice.admin.module.login";
	public final static String WEBSERVICE_ADMIN_MODULE_GETLICENSE_INFO = "webservice.admin.module.getlicenseinfo";
	public final static String WEBSERVICE_MENU_GETLISTALL = "webservice.menu.getlistall";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY = "webservice.menumgnt.category.getcategory";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY_POST = "webservice.menumgnt.category.addcategorypost";
/*	public final static String WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY = "webservice.menumgnt.category.addcategory";*/
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_EDITCATEGORY = "webservice.menumgnt.category.editcategory";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_DELETECATEGORY = "webservice.menumgnt.category.deletecategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY = "webservice.menumgnt.subcategory.getsubcategory";
/*	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY = "webservice.menumgnt.subcategory.addsubcategory";*/
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY_POST = "webservice.menumgnt.subcategory.addsubcategorypost";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_EDITSUBCATEGORY = "webservice.menumgnt.subcategory.editsubcategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_DELETESUBCATEGORY = "webservice.menumgnt.subcategory.deletesubcategory";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_ADDMENUITEM = "webservice.menumgnt.menuitem.addmenuitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_EDITMENUITEM = "webservice.menumgnt.menuitem.editmenuitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_DELETEMENUITEM = "webservice.menumgnt.menuitem.deletemenuitem";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE = "webservice.menumgnt.splecialnote.getspeciallnote";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_ADDSPECIALNOTE = "webservice.menumgnt.splecialnote.addspecialnote";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_ADDTABLE = "webservice.tablemgnt.table.addtable";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_EDITTABLE = "webservice.tablemgnt.table.edittable";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_DELETETABLE = "webservice.tablemgnt.table.deletetable";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_GETVENDOR = "webservice.vendormgnt.vendor.getvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_ADDVENDOR = "webservice.vendormgnt.vendor.addvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_EDITVENDOR = "webservice.vendormgnt.vendor.editvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_DELETEVENDOR = "webservice.vendormgnt.vendor.deletevendor";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_GETINVTYPE = "webservice.invmgnt.invtype.getinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_ADDINVTYPE = "webservice.invmgnt.invtype.addinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_EDITINVTYPE = "webservice.invmgnt.invtype.editinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_DELETEINVTYPE = "webservice.invmgnt.invtype.deleteinvtype";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETINVITEM = "webservice.invmgnt.invitem.getinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_ADDINVITEM = "webservice.invmgnt.invitem.addinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_EDITINVITEM = "webservice.invmgnt.invitem.editinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETFGSTOCKINITEMSBYITEMID = "webservice.invmgnt.invitem.getfgstockinitemsbyitemid";
	public final static String WEBSERVICE_INVMGNT_INVITEM_DELETEINVITEM = "webservice.invmgnt.invitem.deleteinvitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_GETFMCGUNIT = "webservice.menumgnt.menuitem.getfmcgunit";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_GETSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.getstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_ADDSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.addstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_EDITSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.editstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_DELETESTORECUSTOMER = "webservice.storecustmgnt.storecustomer.deletestorecustomer";
	public final static String WEBSERVICE_TAXMGNT_MENUITEM_UPDATEALLITEM = "webservice.taxmgnt.menuitem.updateallitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETUNITLIST = "webservice.invmgnt.invitem.getunitlist";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETUNITDETAILS = "webservice.invmgnt.invitem.getunitdetails";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_UPLOADFILE="webservice.menumgnt.menuitem.uploadfile";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_UPLOADIMAGE="webservice.menumgnt.menuitem.uploadimage";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_GETIMAGE="webservice.menumgnt.menuitem.getimage";
	public final static String WEBSERVICE_SERVICECHARGE_ORDERTYPE_UPDATE = "webservice.servicecharge.ordertype.update";
	public final static String WEBSERVICE_ACCOUNT_VIEW_PERIODEXPENDITURE = "webservice.expenditure.view.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_EDITXPENDITURE = "webservice.expenditure.edit.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_DELETEEXPENDITURE = "webservice.expenditure.delete.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_XPENDITURETYPE = "webservice.expenditure.periodexpenditure.expendituretype";

	
	//public final static String WEBSERVICE_DELIVER_BOY_GETDELIVERYBOY="webservice.deliver.boy.getdeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_ADDDELIVERYBOY = "webservice.delvryboymgnt.adddeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_EDITDELIVERYBOY = "webservice.delvryboymgnt.editdeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_DELETEDELIVERYBOY = "webservice.delvryboymgnt.deletedeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY = "webservice.delvryboymgnt.getalldeliveryboy";
	public final static String WEBSERVICE_ORDER_ASSIGNDELIVERYBOY="webservice.order.assigndeliveryboy";
	
	//for vendor payment management
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_GETPAYMENTINFOBYID = "webservice.vendormgnt.vendor.getpaymentinfobyid";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_VENDOPAYMENT = "webservice.vendormgnt.vendor.vendorpayment";
	//for Fg vendor payment management
	public final static String WEBSERVICE_VENDORMGNT_FGVENDOR_GETPAYMENTINFOBYID = "webservice.vendormgnt.fgvendor.getpaymentinfobyid";	
	public final static String WEBSERVICE_VENDORMGNT_FGVENDOR_VENDOPAYMENT = "webservice.vendormgnt.fgvendor.vendorpayment";	
	//for credit sales
	public final static String WEBSERVICE_CREDITSALE_GETCREDITCUSTTOMERLIST = "webservice.creditsale.getcreditcustomerlist";
	public final static String WEBSERVICE_CREDITSALE_ORDER_GETCREDITORDERBYCUSTOMERID = "webservice.creditsale.order.getcreditorderbycustotmerid";
	public final static String WEBSERVICE_CREDITSALE_ORDER_GETCREDITCUSTOMERBYCONTACTNO = "webservice.creditsale.order.getcreditcustomerbycontact";

	//for kot printer setup
	public final static String WEBSERVICE_PRINT_GETALLINSTALLEDPRINTERS = "webservice.print.getallinstalledprinters";
	public final static String WEBSERVICE_PRINT_ASSIGNPRINTER = "webservice.print.assignprinter";
	public final static String WEBSERVICE_PRINT_GETALLSERVERPRINTERS = "webservice.print.getallserverprinters";
	public final static String WEBSERVICE_PRINT_ASSIGNPRINTERTOITEM = "webservice.print.assignprintertoitem";
	//for daily expenditure
	public final static String WEBSERVICE_ACCOUNT_ADD_DAILYEXPENDITURE = "webservice.expenditure.add.dailyexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_DAILYEXPENDITURE = "webservice.expenditure.view.dailyexpenditure";
	/*End Admin module*/

	/*Start Report module*/
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORYEXCLUDESPCLNOTE = "webservice.menumgnt.category.getcategoryexcludespclnote";
	public final static String WEBSERVICE_REPORT_SALES_CATWISE_PERIOD_REPORT="webservice.report.sales.categorywise.period.report";
	public final static String WEBSERVICE_REPORT_SALES_PAYMENTMODE_WISE_REPORT = "webservice.report.sales.paymentmodewise.report";
	public final static String WEBSERVICE_REPORT_DAILYSALES="webservice.report.dailysales";
	public final static String WEBSERVICE_REPORT_CANCELORDERREASON="webservice.report.cancelorderreason";
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT = "webservice.report.sales.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_DAILY_TIMEWISE_REPORT = "webservice.report.sales.datetime.report";
	public final static String WEBSERVICE_REPORT_ORDERS_DAILY_REPORT = "webservice.report.orders.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_REPORT = "webservice.report.sales.period.report";
	public final static String WEBSERVICE_REPORT_SALES_CATWISE_DAILY_REPORT = "webservice.report.sales.catwise.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_CREDIT_PERIOD_REPORT = "webservice.report.sales.credit.period.report";
	public final static String WEBSERVICE_REPORT_SALES_USER_WISE_DAILY_REPORT = "webservice.report.sales.user.wise.daily.report";
	public final static String WEBSERVICE_REPORT_ORDERS_ITEM_WISE_DAILY_REPORT = "webservice.report.orders.item.wise.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_PO_DAILY_REPORT = "webservice.report.inventory.po.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_PO_PERIOD_REPORT = "webservice.report.inventory.po.period.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKIN_DAILY_REPORT = "webservice.report.inventory.stockin.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKIN_PERIOD_REPORT = "webservice.report.inventory.stockin.period.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_DAILY_KITCHENWISE_REPORT = "webservice.report.inventory.stockout.daily.kitchenwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_DAILY_ALLCATWISE_REPORT = "webservice.report.inventory.stockout.daily.allcatwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_PERIOD_KITCHENWISE_REPORT = "webservice.report.inventory.stockout.period.kitchenwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_PERIOD_ALLCATWISE_REPORT = "webservice.report.inventory.stockout.period.allcatwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_CURRENT_STOCK_REPORT = "webservice.report.inventory.current.stock.report";
	
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_SUMMARY = "webservice.report.inventory.raw.stockin.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_REGISTER = "webservice.report.inventory.raw.stockin.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_ITEMWISE = "webservice.report.inventory.raw.stockin.itemwise";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_SUMMARY = "webservice.report.inventory.fg.stockin.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_REGISTER = "webservice.report.inventory.fg.stockin.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_ITEMWISE = "webservice.report.inventory.fg.stockin.itemwise";
	
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_SUMMARY = "webservice.report.inventory.raw.stockreturn.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_REGISTER = "webservice.report.inventory.raw.stockreturn.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_ITEMWISE = "webservice.report.inventory.raw.stockreturn.itemwise";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_SUMMARY = "webservice.report.inventory.fg.stockreturn.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_REGISTER = "webservice.report.inventory.fg.stockreturn.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_ITEMWISE = "webservice.report.inventory.fg.stockreturn.itemwise";
	
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT_WITHTAX="webservice.report.sales.daily.report.withtax";
	public final static String WEBSERVICE_REPORT_ORDERS_ITEM_WISE_PERIOD_REPORT="webservice.report.orders.item.wise.period.report";
	public final static String WEBSERVICE_REPORT_GST_IN_OUT_PERIOD_REPORT="webservice.report.orders.gst.in.out.period.report";
	public final static String WEBSERVICE_REPORT_ORDERS_NOCKOT_PERIOD_REPORT="webservice.report.orders.nockot.period.report";
	public final static String WEBSERVICE_REPORT_PACKAGING_DETAILS_PERIOD_REPORT="webservice.report.orders.packaging.period.report";
	public final static String WEBSERVICE_REPORT_ORDERS_CANCEL_PERIOD_REPORT="webservice.report.orders.cancel.period.report";
	public final static String WEBSERVICE_REPORT_CUSTOMER="webservice.report.getCustomerReport";
	public final static String WEBSERVICE_REPORT_OUTSTANDING_CUSTOMER="webservice.report.getOutstandingCustomerReport";
	public final static String WEBSERVICE_REPORT_TOP_CUSTOMER="webservice.report.getTopCustomerReport";
	public final static String WEBSERVICE_NEW_REPEAT_CUSTOMER="webservice.report.getNewVsRepeatReport";

	public final static String WEBSERVICE_REPORT_BY_STORE="webservice.report.getReportByStore";
	public final static String WEBSERVICE_REPORT_ORDERS_WITH_DELIVERYBOY="webservice.report.getOrdersWithDeliveryBoyReport";
	
	public final static String WEBSERVICE_REPORT_DAILYMANAGERWITHTAX="webservice.report.dailymanagerwithtax";
	public final static String WEBSERVICE_REPORT_DISCOUNTREASON="webservice.report.discountreason";
	public final static String WEBSERVICE_REPORT_NONCHARGEABLE="webservice.report.nonchargeable";
	public final static String WEBSERVICE_REPORT_PAYMENTWISE="webservice.report.paymentwise";
	
	public final static String WEBSERVICE_REPORT_DAILYSALESINCLUSIVE="webservice.report.dailysalesinclusive";
	public final static String WEBSERVICE_REPORT_DAILYSALESSUMMARY="webservice.report.dailysalessummary";
	public final static String WEBSERVICE_REPORT_RAW_VENDOR_PAYMENT_REPORT = "webservice.report.raw.vendor.payment";
	public final static String WEBSERVICE_REPORT_FG_VENDOR_PAYMENT_REPORT = "webservice.report.fg.vendor.payment";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_ITEMWISE = "webservice.report.inventory.raw.stockout.itemwise";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_REGISTER = "webservice.report.inventory.raw.stockout.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_SUMMARY = "webservice.report.inventory.raw.stockout.summary";

	
	//for thermal printer
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT_TP = "webservice.report.sales.daily.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_REPORT_TP = "webservice.report.sales.period.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_DAY_WISE_HOURLY_REPORT_TP = "webservice.report.sales.day.wise.hourly.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_DAY_WISE_SUMMARY_REPORT_TP = "webservice.report.sales.day.wise.summary.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_WISE_SUMMARY_REPORT_TP = "webservice.report.sales.period.wise.summary.report.tp";
	/*End Report module*/

	/*Start Inventory module*/
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_BYDATE = "webservice.inventory.purchaseorder.bydate";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_BYPOID = "webservice.inventory.purchaseorder.bypoid";
	public final static String WEBSERVICE_INVENTORY_INVENTORYITEMS = "webservice.inventory.inventoryitems";
	public final static String WEBSERVICE_INVENTORY_GETINVENTORYITEMS_BYCODE = "webservice.inventory.getinventoryitems.bycode";
	public final static String WEBSERVICE_INVENTORY_APPROVEDPO = "webservice.inventory.approvedpo";
	public final static String WEBSERVICE_INVENTORY_UPDATEDPO = "webservice.inventory.updatepo";
	public final static String WEBSERVICE_INVENTORY_UPDATE_EACHPOITEM = "webservice.inventory.updateEachpoitem";
	public final static String WEBSERVICE_INVENTORY_DELETE_POITEM = "webservice.inventory.deletepoitem";
	public final static String WEBSERVICE_INVENTORY_CURRENTSTOCK_ITEM = "webservice.inventory.currentstock.item";
	public final static String WEBSERVICE_INVENTORY_VENDORS = "webservice.inventory.vendors";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_CREATE = "webservice.inventory.purchaseOrder.create";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_UPDATE = "webservice.inventory.purchaseOrder.update";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_BYDATE = "webservice.inventory.stockout.bydate";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_BYID = "webservice.inventory.stockout.byid";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_CREATE_NEW = "webservice.inventory.stockout.create.newstockout";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_BYDATE = "webservice.inventory.stockin.bydate";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_BYID = "webservice.inventory.stockin.byid";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_CLOSED = "webservice.inventory.stockin.close";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EACHSTOCKINITEM = "webservice.inventory.stockin.update.eachstockinitem";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_DELETE_EACHSTOCKINITEM = "webservice.inventory.stockin.delete.eachstockinitem";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_SAVE_NEW = "webservice.inventory.stockin.save.newstockin";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EXISTING = "webservice.inventory.stockin.update.existing";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_PRINT = "webservice.inventory.purchaseorder.print";
	public final static String WEBSERVICE_INVENTORY_REQUISITION_DELETE = "webservice.inventory.requisition.delete";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_DELETEBYID = "webservice.inventory.stockin.deletebyid";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_SAVE = "webservice.inventory.purchase.return.save";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_UPDATE = "webservice.inventory.purchase.return.update";

	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYDATE = "webservice.inventory.purchase.return.getreturnlistbydate";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYID = "webservice.inventory.purchase.return.getreturnlistbyid";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_CLOSED = "webservice.inventory.purchase.return.closed";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_DELETEBYID = "webservice.inventory.purchase.return.deletebyid";
	
	
	/*End Inventory module*/

	/*Start Kitchen module*/
	public final static String WEBSERVICE_KITCHEN_GETKITCHENITEM = "webservice.kitchen.getkitchenitem";
	public final static String WEBSERVICE_KITCHEN_COOKING_START = "webservice.kitchen.cooking.start";
	public final static String WEBSERVICE_KITCHEN_COOKING_END = "webservice.kitchen.cooking.end";
	public final static String WEBSERVICE_KITCHEN_OUT = "webservice.kitchen.out";
	/*End Kitchen module*/

	/*Start RM module*/
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETLIST = "webservice.rm.recipe.menu.getlist";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETINGREDIENTLIST = "webservice.rm.recipe.menu.getingredients";

	/*End RM module*/
	public final static String WEBSERVICE_REPORT_ACCOUNTS_PERIODWISE_PL_STATEMENT = "webservice.report.accounts.periodwise.pl.statement";
	public final static String WEBSERVICE_REPORT_ACCOUNTS_PERIODWISE_TAX_STATEMENT= "webservice.report.accounts.periodwise.tax.statement";
	
	// new added 
	public final static String WEBSERVICE_MENU_GETITEM_BYCODE = "webservice.menu.getitem.bycode";
	
	
	// advance booking
	public final static String WEBSERVICE_ADMIN_TABLE_PREBOOKLIST ="webservice.admin.table.prebook.getlist";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADDBOOKINGDETAILS="webservice.admin.pretablebooking.addprebookingdetails";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_EDITBOOKINGDETAILS="webservice.admin.pretablebooking.editprebookingdetails";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADVANCEPAY="webservice.admin.pretablebooking.advancepay";
	public final static String WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYNUMBER="webservice.unpaid.order.getunpaidorderdetailsbynumber";
	public final static String WEBSERVICE_ADVANCE_ORDER_COUNT="webservice.aqadvanc.order.count";
	
	//Simple Item Stock In
	
	public final static String WEBSERVICE_RM_FGSTOCKIN_GETFGSTOCKINBYDATE = "webservice.rm.fgstockin.getfgstockinbydate";
	public final static String WEBSERVICE_RM_FGSTOCKIN_APPROVEFGSTOCKIN = "webservice.rm.fgstockin.approvefgstockin";
	public final static String WEBSERVICE_RM_FGSTOCKIN_CREATEFGSTOCKIN = "webservice.rm.fgstockin.createfgstockin";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGSTOCKINBYDATE = "webservice.inventory.simplefgstockin.getfgstockinbydate";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_CREATEFGSTOCKIN = "webservice.inventory.simplefgstockin.createfgstockin";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETSIMPLESTOCKINLISTBYID = "webservice.inventory.simplefgstockin.getsimplefgstckindatabystockinid";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGITEMCURRENTSTOCK = "webservice.inventory.simplefgstockin.getfgitemcurrentstock";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_UPDATEFGSTOCKIN = "webservice.inventory.simplefgstockin.updatefgstockin";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_DELETEFGSTOCKIN = "webservice.inventory.simplefgstockin.deletefgstockin";
	
	
	//Simple Fg Item Return
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_CREATEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.createfgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_UPDATEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.updatefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_DELETEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.deletefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_APPROVEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.approvefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYID = "webservice.inventory.simplefgstockreturn.getfgstockreturnbyid";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYDATE ="webservice.inventory.simplefgstockreturn.getfgstockreturnbydate";
	
	
	//Refund Order
	public final static String WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERID = "webservice.paidorder.details.byid";
	public final static String WEBSERVICE_ORDER_REFUND_REASONS = "webservice.paidorder.refund.reasonlist";
	public final static String WEBSERVICE_ADMIN_ORDER_SAVEREFUND = "webservice.paidorder.refundorder";
	public final static String WEBSERVICE_ORDER_REFUNDORDERDETAILS_BYORDERID = "webservice.paidorder.refund.orderdetailsbyid";
	public final static String WEBSERVICE_ADMIN_ORDERREFUND_APPROVE = "webservice.paidorder.refund.approve";
	public final static String WEBSERVICE_ADMIN_ORDERREFUND_DELETE = "webservice.paidorder.refund.delete";
	public final static String WEBSERVICE_ORDER_REFUND_BILL_PRINT = "werservice.order.refund.bill.print";
	public final static String WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERNUMBER = "webservice.paidorder.details.bynumber";
	
	
	/* Dash board data fetch */
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARY = "webservice.store.dash.salessummary";
	public final static String WEBSERVICE_STORE_DASHBOARD_PAYMENTSUMMARY = "webservice.store.dash.paymentsummary";
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYORDERTYPE = "webservice.store.dash.salesummaryordertype";
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYPAYMENTTYPE = "webservice.store.dash.salesummarypaymenttype";
	public final static String WEBSERVICE_STORE_DASHBOARD_TOPCUSTOMERS = "webservice.store.dash.topcustomer";
	public final static String WEBSERVICE_STORE_DASHBOARD_TOPITEMS = "webservice.store.dash.topitem";
	
	// refund report 
	public final static String WEBSERVICE_REPORT_REFUNDS_PERIODWISE_REFUND_SUMMARY = "webservice.report.accounts.periodwise.refund.summary";
	public final static String WEBSERVICE_REPORT_REFUNDS_PERIODWISE_REFUND_DETAILS = "webservice.report.accounts.periodwise.refund.details";
   
	
	public static final String WEBSERVICE_REPORT_TAXSUMMARY = "webservice.report.taxsummary.details.report";
	
	private static Properties getProperties() {
		logger.info("CommonResource initialized [+] ...");
		try {
			Properties properties = new Properties();
			properties.load(CommonResource.class.getClassLoader().getResourceAsStream("com/sharobi/webpos/resources/commonResource.properties"));
			logger.debug("CommonResource properties loaded");
			return properties;
		} catch (Exception ex) {
			logger.error("Failed to initialize CommonResource [-] ", ex);
			return null;
		}
	}

	public static String getProperty(String key) {
		return resourceProperties.getProperty(key);
	}
	
	
	
	
	// gson serialize and JsonDeserializer
	private static DateFormat dateFormatser = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
	private static DateFormat dateFormatdeser = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a", Locale.US);
	static JsonSerializer<Date> serializer = new JsonSerializer<Date>() {
		@Override
		public JsonElement serialize(Date date, Type type, JsonSerializationContext jsonSerializationContext) {
			return new JsonPrimitive(dateFormatser.format(date));
		}
	};

	static JsonDeserializer<Date> deserializer = new JsonDeserializer<Date>() {
		@Override
		public Date deserialize(JsonElement jsonElement, Type type,
				JsonDeserializationContext jsonDeserializationContext) {
			try {
				return dateFormatdeser.parse(jsonElement.getAsString());
			} catch (Exception e) {
				throw new JsonParseException(e);
			}
		}
	};

	public final static Gson GSON = new GsonBuilder().registerTypeAdapter(Date.class, serializer)
			.registerTypeAdapter(Date.class, deserializer).create();
			
			
	
	
		
}
