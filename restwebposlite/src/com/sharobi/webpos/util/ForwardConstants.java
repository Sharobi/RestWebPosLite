/**
 * 
 */
package com.sharobi.webpos.util;

/**
 * @author habib
 * 
 */
public class ForwardConstants {
	/* Login Module*/

	/**
	 * This key used to Forward page to Login Page
	 */
	public static final String VIEW_LOGIN_PAGE = "login/login";
	/**
	 * This key used to Forward page to Login Page for saravaana
	 */
	public static final String VIEW_LOGIN_PAGE_SB = "login/login_sb";
	/**
	 * This key used to redirect Home
	 */
	public static final String REDIRECT_HOME = "redirect:/home/welcome.htm";
	/**
	 * This key used to redirect Login page
	 */
	public static final String REDIRECT_LOGIN_PAGE = "redirect:/authentication/login.htm";

	/* End Login Module*/

	/* Base Module*/
	/**
	 * This key used to Forward page to Home Page
	 */
	public static final String VIEW_HOME_PAGE = "base/home";
	/**
	 * This key used to Forward page to Table selection Page
	 */
	public static final String VIEW_TABLE_PAGE = "base/table";

	/**
	 * This key used to Forward page to Order taking Page
	 */
	public static final String VIEW_ORDER_PAGE = "base/ordertaking";
	
	/**
	 * This key used to Forward page to Menu Item Page
	 */
	public static final String VIEW_MENUITEM_PAGE = "base/menuitem";
	
	/**
	 * This key used to Forward page to unpaid order Page
	 */
	public static final String VIEW_UNPAID_ORDER_PAGE = "base/unpaidorder";
	
	/**
	 * This key used to redirect unpaid order Page
	 */
	public static final String REDIRECT_UNPAID_ORDER_PAGE = "redirect:/unpaidorder/viewunpaidorder.htm";
	/**
	 * This key used to Forward page to paid order Page
	 */
	public static final String VIEW_PAID_ORDER_PAGE = "base/paidorder";
	
	/* End Base Module*/
	
	/* Admin Module*/
	/**
	 * This key used to Forward page to menu management page
	 */
	public static final String VIEW_MENU_MGNT_PAGE = "admin/menumgnt";
	/**
	 * This key used to Forward page to sub category page
	 */
	public static final String VIEW_MENU_SUB_CAT_PAGE = "admin/subcategory";
	/**
	 * This key used to Forward page to menu items page
	 */
	public static final String VIEW_MENU_ITEMS_PAGE = "admin/menuitems";
	/**
	 * This key used to Forward page to unpaid order management page
	 */
	public static final String VIEW_UNPAID_ORDER_MGNT_PAGE = "admin/unpaidordermgnt";
	/**
	 * This key used to Forward page to special note page
	 */
	public static final String VIEW_SPECIAL_NOTE_PAGE = "admin/specialnote";
	/**
	 * This key used to Forward page to table management page
	 */
	public static final String VIEW_TABLE_MGNT_PAGE = "admin/tablemgnt";
	/**
	 * This key used to Forward page to vendor management page
	 */
	public static final String VIEW_VENDOR_MGNT_PAGE = "admin/vendormgnt";
	/**
	 * This key used to Forward page to inventory type management page
	 */
	public static final String VIEW_INVTYPE_MGNT_PAGE = "admin/invtypemgnt";
	/**
	 * This key used to Forward page to inventory item management page
	 */
	public static final String VIEW_INVITEM_MGNT_PAGE = "admin/invitemmgnt";
	/**
	 * This key used to Forward page to simple inventory item management page
	 */
	public static final String VIEW_SIMPLE_INVITEM_MGNT_PAGE = "admin/simpleinvitemmgnt";
	/**
	 * This key used to Forward page to storecustomer management page
	 */
	public static final String VIEW_STORECUST_MGNT_PAGE = "admin/storecustmgnt";
	
	/**
	 * This key used to Forward page to vendor payment management page
	 */
	public static final String VIEW_VENDOR_PAYMENT_PAGE = "admin/vendorpayment";
	
	/**
	 * This key used to Forward page to fg vendor payment management page
	 */
	public static final String VIEW_FGVENDOR_PAYMENT_PAGE = "admin/fgvendorpayment";
	
	/**
	 * This key used to Forward page to tax management page
	 */
	public static final String VIEW_TAX_MGNT_PAGE = "admin/taxmgnt";
	/* for credit customer*/
	
	public static final String VIEW_SERVICE_CHARGE_PAGE="admin/servicechargemgnt";
	/**
	 * This key used to Forward page to credit customer page
	 */
	public static final String VIEW_CREDIT_SALE_PAGE = "admin/creditsale";
	/**
	 * This key used to Forward page to delivery boy page
	 */
	
	public static final String VIEW_DELIVERY_BOY_PAGE = "admin/deliveryboymgnt";

	
	/* end for credit customer*/
	/* for expenditure mgnt*/
	/**
	 * This key used to Forward page to expense mgmt page
	 */
	public static final String VIEW_EXP_MGMT_PAGE = "admin/expenditure";
	public static final String VIEW_DAILY_EXP_PAGE = "admin/viewdailyexp";
	/* end for expenditure mgnt*/
	
	/**
	 * This key used to Forward page to upload menu items page
	 */
	public static final String VIEW_UPLOAD_MENU_ITEM_PAGE = "admin/uploadmenuitem";
	/* End Admin Module*/
	
	/* Hr Module*/

	/* End Hr Module*/

	/* Inventory Module*/
	/**
	 * This key used to Forward page to view Inventory Page
	 */
	public static final String VIEW_INVENTORY_PAGE = "inventory/inventory";
	
	public static final String VIEW_INVENTORYNEW_PAGE = "inventory/inventorynew";

	/**
	 * This key used to Forward page to view StockIn Page
	 */
	public static final String VIEW_STOCK_IN_PAGE = "inventory/stockin";
	
	public static final String VIEW_STOCK_IN_NEW_PAGE = "inventory/stockinnew";

	/**
	 * This key used to Forward page to view StockIn Page
	 */
	public static final String VIEW_STOCK_OUT_PAGE = "inventory/stockout";
	
	public static final String VIEW_STOCK_OUT_NEW_PAGE = "inventory/stockoutnew";
	
	public static final String VIEW_RPT_INV_RAW_STOCKOUT_SUMMARY = "report/rpt_inv_rawstockout_summary";

	public static final String VIEW_RPT_INV_RAW_STOCKOUT_REGISTER = "report/rpt_inv_rawstockout_register";
	  
	public static final String VIEW_RPT_INV_RAW_STOCKOUT_ITEMWISE = "report/rpt_inv_rawstockout_itemwise";
	  
	/**
	   * This key used to Forward page to item stock entry page
	   */
	  public static final String VIEW_ITEMSTOCK_PAGE = "inventory/stockentry";
		
	  /**
	   * This key used to Forward page to item stock sisplay page
	   */
	  public static final String VIEW_ITEMSTOCKDISPLAY_PAGE = "inventory/fgstockdisplay";
	  
	  /**
	   * This key used to Forward page to item  return page
	   */
	  public static final String VIEW_ITEMRETURN_PAGE = "inventory/fgreturn";
	
	
	/* End Inventory Module*/
	
	/* Report Module*/
	/**
	 * This key used to Forward page to daily category wise sales report periodic page
	 */
	public static final String VIEW_RPT_CAT_WISE_PERIOD_SALES = "report/rpt_catwise_sales_period";
	/**
	 * This key used to Forward page to payment mode wise sales report page
	 */
	public static final String VIEW_RPT_PAYMENTMODE_WISE_SALES = "report/rpt_sales_paymentmode_wise";
	/**
	 * This key used to Forward page to rpt_dailysales_celavi
	 */
	public static final String VIEW_RPT_DAILYSALES_CELAVI = "report/rpt_dailysales_celavi";
	/**
	 * This key used to Forward page to rpt_cancel_order_celavi
	 */
	public static final String VIEW_RPT_CANCEL_ORDER_CELAVI = "report/rpt_cancel_order_celavi";
	/**
	 * This key used to Forward page to day wise sales report page
	 */
	public static final String VIEW_RPT_DAY_WISE_SALES = "report/rpt_sales_day";
	/**
	 * This key used to Forward page to day time wise sales report page
	 */
	public static final String VIEW_RPT_DAY_TIME_WISE_SALES = "report/rpt_sales_day_time_wise";
	/**
	 * This key used to Forward page to day wise orders report page
	 */
	public static final String VIEW_RPT_DAY_WISE_ORDERS = "report/rpt_order_day";
	/**
	 * This key used to Forward page to period wise sales report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_SALES = "report/rpt_sales_period";
	/**
	 * This key used to Forward page to user wise daily sales report page
	 */
	public static final String VIEW_RPT_USER_WISE_DAILY_SALES = "report/rpt_sales_day_user";
	/**
	 * This key used to Forward page to day wise hourly sales report page
	 */
	public static final String VIEW_RPT_DAY_WISE_HOURLY_SALES = "report/rpt_sales_hour_day";
	/**
	 * This key used to Forward page to day wise summary sales report page
	 */
	public static final String VIEW_RPT_DAY_WISE_SUMMARY_SALES = "report/rpt_sales_summary_day";
	/**
	 * This key used to Forward page to period wise summary sales report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_SUMMARY_SALES = "report/rpt_sales_summary_period";
	/**
	 * This key used to Forward page to item wise daily orders report page
	 */
	public static final String VIEW_RPT_ITEM_WISE_DAILY_ORDERS = "report/rpt_item_wise_order_day";
	/**
	 * This key used to Forward page to item wise period orders report page
	 */
	public static final String VIEW_RPT_ITEM_WISE_PERIOD_ORDERS = "report/rpt_item_wise_order_period";
	/**
	 * This key used to Forward page to gst in out period wise report page
	 */
	public static final String VIEW_RPT_GST_IN_OUT_PERIOD_WISE = "report/rpt_gst_in_out_period";
	/**
	 * This key used to Forward page to daily category wise sales report page
	 */
	public static final String VIEW_RPT_DAY_WISE_CAT_SALES = "report/rpt_sales_cat_day";
	/**
	 * This key used to Forward page to period wise credit sales report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_CREDIT_SALES = "report/rpt_sales_credit_period";
	
	/**
	 * This key used to Forward page to day wise po report page
	 */
	public static final String VIEW_RPT_DAY_WISE_PO = "report/rpt_inv_po_day";
	/**
	 * This key used to Forward page to period wise po report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_PO = "report/rpt_inv_po_period";
	/**
	 * This key used to Forward page to day wise stock in report page
	 */
	public static final String VIEW_RPT_DAY_WISE_STOCKIN = "report/rpt_inv_stockin_day";
	
	/**
	 * This key used to Forward page to raw stockin summary report page
	 */
	public static final String VIEW_RPT_RAW_STOCKIN_SUMMARY = "report/rpt_inv_rawstockin_summary";
	
	/**
	 * This key used to Forward page to raw stockin register report page
	 */
	public static final String VIEW_RPT_RAW_STOCKIN_REGISTER = "report/rpt_inv_rawstockin_register";
	/**
	 * This key used to Forward page to raw stockin itemwise report page
	 */
	public static final String VIEW_RPT_RAW_STOCKIN_ITEMWISE = "report/rpt_inv_rawstockin_itemwise";
	/**
	 * This key used to Forward page to fg stockin itemwise report page
	 */
	public static final String VIEW_RPT_FG_STOCKIN_ITEMWISE = "report/rpt_inv_fgstockin_itemwise";
	
	/**
	 * This key used to Forward page to fg stockin summary report page
	 */
	public static final String VIEW_RPT_FG_STOCKIN_SUMMARY = "report/rpt_inv_fgstockin_summary";
	
	/**
	 * This key used to Forward page to fg stockin register report page
	 */
	public static final String VIEW_RPT_FG_STOCKIN_REGISTER = "report/rpt_inv_fgstockin_register";
	
	/**
	 * This key used to Forward page to fg stockreturn summary report page
	 */
	public static final String VIEW_RPT_FG_STOCKRETURN_SUMMARY = "report/rpt_inv_fgstockreturn_summary";
	
	
	/**
	 * This key used to Forward page to fg stockreturn register report page
	 */
	public static final String VIEW_RPT_FG_STOCKRETURN_REGISTER = "report/rpt_inv_fgstockreturn_register";
	/**
	 * This key used to Forward page to fg stockreturn  itemwise report page
	 */
	public static final String VIEW_RPT_FG_STOCKRETURN_ITEMWISE = "report/rpt_inv_fgstockreturn_itemwise";
	
	
	
	/**
	 * This key used to Forward page to raw stockout summary report page
	 */
	public static final String VIEW_RPT_RAW_STOCKOUT_SUMMARY = "report/rpt_inv_rawstockreturn_summary";
	/**
	 * This key used to Forward page to raw stockout register report page
	 */
	public static final String VIEW_RPT_RAW_STOCKOUT_REGISTER = "report/rpt_inv_rawstockreturn_register";
	/**
	 * This key used to Forward page to raw stockout itemwise report page
	 */
	public static final String VIEW_RPT_RAW_STOCKOUT_ITEMWISE = "report/rpt_inv_rawstockreturn_itemwise";
	
	
	/**
	 * This key used to Forward page to period wise stock in report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_STOCKIN = "report/rpt_inv_stockin_period";
	/**
	 * This key used to Forward page to day wise stock out allcat report page
	 */
	public static final String VIEW_RPT_DAY_WISE_STOCKOUT_ALLCAT = "report/rpt_inv_stockout_allcat_day";
	/**
	 * This key used to Forward page to period wise stock out allcat report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_STOCKOUT_ALLCAT = "report/rpt_inv_stockout_allcat_period";
	/**
	 * This key used to Forward page to day wise stock out kitchen wise report page
	 */
	public static final String VIEW_RPT_DAY_WISE_STOCKOUT_KITCHEN = "report/rpt_inv_stockout_kitchen_day";
	/**
	 * This key used to Forward page to period wise stock out kitchen wise report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_STOCKOUT_KITCHEN = "report/rpt_inv_stockout_kitchen_period";
	/**
	 * This key used to Forward page to current stock report page
	 */
	public static final String VIEW_RPT_CURRENT_STOCK = "report/rpt_inv_current_stock";
	/**
	 * This key used to Forward page to period wise cancel order report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_CANCEL_ORDER = "report/rpt_order_cancel_period";
	/**
	 * This key used to Forward page to period wise nockot order report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_NOCKOT_ORDER = "report/rpt_order_nockot_period";
	/**
	 * This key used to Forward page to period  wise packaging details report page
	 */
	public static final String VIEW_RPT_PERIOD_WISE_PACKAGING_DETAILS = "report/rpt_order_packaging_period";
	
	public static final String VIEW_RPT_CUSTOMER_LIST = "report/rpt_customer_list";
	
	public static final String VIEW_RPT_TOP_CUSTOMER = "report/rpt_top_customer";
	
	public static final String VIEW_NEW_VS_RPT_CUSTOMER = "report/rpt_new_repeat_customer"; // VIEW_OUTSTANDING_CUSTOMER
	public static final String VIEW_OUTSTANDING_CUSTOMER = "report/rpt_outstanding_customer";

	public static final String VIEW_RPT_ORDER_AND_DELIVERYBOY_REPORT = "report/rpt_delivery_boy_periodwise";
	public static final String VIEW_RPT_ACCOUNT_PLSTATEMENT = "report/rpt_accounts_plstatement";
	public static final String VIEW_RPT_ACCOUNT_TAXSTATEMENT = "report/rpt_accounts_taxtatement";
	
	/*Sale Refund Report*/
	public static final String VIEW_RPT_REFUNDS_SUMMARY = "report/rpt_refunds_summary";
	public static final String VIEW_RPT_REFUNDS_DETAILS = "report/rpt_refunds_details";
	public static final String VIEW_RPT_TAX_SUMMARY = "report/rpt_tax_summary";
	
	/* End Report Module*/
	
	/* Kitchen Module*/
	/**
	 * This key used to Forward page to kitchen item page
	 */
	public static final String VIEW_KITCHEN_ITEM_PAGE = "kitchen/kitchenitem";
	/* End Kitchen Module*/
	
	/* RM Module*/
	/**
	 * This key used to Forward page to RM recipe ingredient page
	 */
	public static final String VIEW_RECIPE_INGREDIENTS_PAGE = "rm/recipeingredients";
	
	
	// new added
	
	/**
	 * This key used to Forward page to rpt_dailymanager_withtax_celavi
	 */
	public static final String VIEW_RPT_DAILYMANAGER_WITHTAX_CELAVI = "report/rpt_dailymanager_withtax_celavi";
	/**
	 * This key used to Forward page to rpt_dailysales_inclusivetax_celavi
	 */
	public static final String VIEW_RPT_DAILYSALES_INCLUSIVETAX_CELAVI = "report/rpt_dailysales_inclusivetax_celavi";
	/**
	 * This key used to Forward page to rpt_discount_reason_order_celavi
	 */
	public static final String VIEW_RPT_DISCOUNT_REASON_ORDER_CELAVI = "report/rpt_discount_reason_order_celavi";
	/**
	 * This key used to Forward page to rpt_nonchargeable_order_celavi
	 */
	public static final String VIEW_RPT_NONCHARGEABLE_ORDER_CELAVI = "report/rpt_nonchargeable_order_celavi";
	/**
	 * This key used to Forward page to rpt_order_paymentdetails_celavi
	 */
	public static final String VIEW_RPT_ORDER_PAYMENTDETAILS_CELAVI = "report/rpt_order_paymentdetails_celavi";
	/**
	 * This key used to Forward page to rpt_dailysales_summary_celavi
	 */
	public static final String VIEW_RPT_ORDER_DAILYSALES_SUMMARY = "report/rpt_dailysales_summary_celavi";
	
	
	/**
	 *for Advance order by admin
	 */
	public static final String VIEW_ADV_TBL_BOOK_PAGE = "admin/advancebooking";
	
	/* End RM Module*/
	/**
	 *for Order refund page by admin
	 */
	public static final String VIEW_REFUND_ORDER_PAGE = "admin/orderrefund";
	/**
	 * This key used to Forward page to Dashboard Page
	 */
	public static final String VIEW_HOME_DASHBOARD = "admin/dashboard";
	
	/**
	 * This key used to Forward page to view Purchase return Page
	 */
	public static final String VIEW_PURCHASE_RETURN_PAGE = "inventory/purchasereturn";
	
	/**
	 * This key used to Forward page to raw item vendor payment report page
	 */
	public static final String VIEW_RPT_RAW_VENDOR_PAYMENT = "report/rpt_raw_vendor_payment";
	/**
	 * This key used to Forward page to fg item vendor payment report page
	 */
	public static final String VIEW_RPT_FG_VENDOR_PAYMENT = "report/rpt_fg_vendor_payment";
	
}
