//for yyyy-mm-dd
function  dateformat(str){
		var dt  = parseInt(str.substring(8,10),10); 
	    var mon = parseInt(str.substring(5,7),10);
		var yr  = parseInt(str.substring(0,4),10);
		str =  new Date(yr,mon-1,dt);
		return  str;
	}
//for dd-mm-yyyy
function  dateformat1(str){
	var dt  = parseInt(str.substring(0,2),10); 
    var mon = parseInt(str.substring(3,5),10);
	var yr  = parseInt(str.substring(6,10),10);
	str =  new Date(yr,mon-1,dt);
	return  str;
}
function showpdfrptpaymentmodeSales(fromdate,todate,storeId,rpttype)
{

	var todaydate=document.getElementById('hidpaymentmodewiseSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptpaymentmodewiseModal1();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptpaymentmodewiseModal1();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptpaymentmodewiseModal2();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
		
	document.getElementById('paymentmodesalereportContainerId').innerHTML=pdfline;
	}


}

function showpdfrptdaywiseSales(fromdate,todate,storeId,rptType)
{
	    var todaydate=document.getElementById('hiddaterptdaywiseSales').value;
		if(dateformat(fromdate)>dateformat(todaydate))
		{
			showalertrptsalesdayModal1();
			return;
		}
		if(dateformat(todate)>dateformat(todaydate))
		{
			showalertrptsalesdayModal1();
			return;
		}
		if(dateformat(fromdate)>dateformat(todate))
		{
			showalertrptsalesdayModal2();
			return;
		}
		else{
			
			//var pdfline="<iframe src='"+pdf_url_day_sale+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
			//var pdfline="<iframe src='"+pdf_url_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
			var pdfline="<iframe src='"+pdf_url_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rptType+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
			
			document.getElementById('daywisesalereportContainerId').innerHTML=pdfline;
			
	        }
}
	
	
function showpdfrptdaytimewiseSales(fromdate,todate,storeId,workingHour,rpttype)
{
	var todaydate=document.getElementById('hiddenrptdaywiseSales').value;
	//alert("form date:"+fromdate+"   "+"todate:"+todate +" "+"curdate:"+todaydate);
	if(dateformat(fromdate) > dateformat(todaydate)){
		showalertrptsalesdayModal1();
	    return;
	    }
	if(dateformat(todate) > dateformat(todaydate))
	{		
		showalertrptsalesdayModal1();
		return;
	}
	if(dateformat(fromdate) > dateformat(todate))
		{		
		showalertrptsalesdayModal2();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_time_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&workingHours="+workingHour+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	 var pdfline="<iframe src='"+pdf_url_day_time_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&workingHours="+workingHour+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	 document.getElementById('daytimewisesalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdaywiseOrder(date,storeId)
{
	var todaydate=document.getElementById('hiddaterptdaywiseOrders').value;
	if(dateformat(date)>dateformat(todaydate))
	{
		showalertrptorderdayModal();
	}
else{
	var pdfline="<iframe src='"+pdf_url_day_order+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywiseorderreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwiseSales(fromdate,todate,type,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwiseSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptsalesperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptsalesperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptsalesperiodGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_sale+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	  var pdfline="<iframe src='"+pdf_url_period_sale+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisesalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwiseSalesSB(fromdate,todate,storeId)
{
	var todaydate=document.getElementById('hiddaterptperiodwiseSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptsalesperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptsalesperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptsalesperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_period_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisesalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptuserwiseSales(fromdate,todate,storeId,userId,rpttype)
{	
	var seluser=$("#seluser").val();
	var todaydate=document.getElementById('hiddenrptuserwiseSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptsalesdayModal1();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptsalesdayModal1();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptsalesdayModal2();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_user_day_sale+"?date="+date+"&storeId="+storeId+"&user="+userId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	//var pdfline="<iframe src='"+pdf_url_user_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&user="+seluser+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	  var pdfline="<iframe src='"+pdf_url_user_day_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&user="+seluser+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
		 
		document.getElementById('userwisedailysalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdaywisehourlySales(fromdate,todate,storeId,rpttype)
{	
     var todaydate=document.getElementById('hiddaterptdaywisehourlySales').value;
	  if (dateformat(fromdate) > dateformat(todaydate)) {
		showalertrptdaywisehourlysalesModal1();
		return;
	}
	if (dateformat(todate) > dateformat(todaydate)) {
		showalertrptdaywisehourlysalesModal1();
		return;
	}
	if (dateformat(fromdate) > dateformat(todate)) {
		showalertrptdaywisehourlysalesModal2();
		return;
	}
    else{
	//var pdfline="<iframe src='"+pdf_url_day_wise_hourly_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_wise_hourly_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>"; 
		
	document.getElementById('daywisehourlysalesreportContainerId').innerHTML=pdfline;
	}

}
function showpdfrptdaywisesummarySales(date,storeId)
{	

	var todaydate=document.getElementById('hiddaterptdaywisesummarySales').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptdaywisesummarysalesModal();
		}
	else{
	var pdfline="<iframe src='"+pdf_url_day_wise_summary_sale+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywisesummarysalesreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisesummarySales(fromdate,todate,storeId)
{
	var todaydate=document.getElementById('hiddaterptperiodwisesummarySales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptsalessummaryperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptsalessummaryperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptsalesperiodsummaryGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_period_wise_summary_sale+"?startDate="+fromdate+"&endDate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisesalesummaryreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptitemwisedailyOrder(date,storeId,rpttype)
{
	//alert(date+storeId);
	var todaydate=document.getElementById('hiddaterptitemwisedailyOrders').value;
	if(dateformat(date)>dateformat(todaydate))
	{
		showalertrptitemwiseorderdayModal();
	}
else{
	//var pdfline="<iframe src='"+pdf_url_item_wise_day_order+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	  var pdfline="<iframe src='"+pdf_url_item_wise_day_order+"?date="+date+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('itemwisedailyorderreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptitemwiseperiodOrder(fromdate,todate,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptitemwiseperiodOrders').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptitemwiseorderperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptitemwiseorderperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptitemwiseorderperiodGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_item_wise_period_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_item_wise_period_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	
	document.getElementById('itemwiseperiodorderreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptorderswithdeliveryboys(fromdate,todate,storeId,rpttype,deliveryboyid)
{
	var todaydate=document.getElementById('hiddaterptperiodwisePo').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptpoperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptpoperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptpoperiodGreaterModal();
		return;
		}
	else{
	/*var pdfline="<iframe src='"+pdf_url_orders_with_deliveryboys_list+"?storeId="+storeId+"&orderFrom="+fromdate+"&orderTo="+todate+"&deliveryBoyId="+deliveryboyid+"&catId="+catid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";*/
	var pdfline="<iframe src='"+pdf_url_orders_with_deliveryboys_list+"?storeId="+storeId+"&orderFrom="+fromdate+"&orderTo="+todate+"&deliveryBoyId="+deliveryboyid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
		
	document.getElementById('deliveryboysreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptgstinoutperiod(fromdate,todate,storeId)
{
	var todaydate=document.getElementById('hiddaterptgstinoutperiodOrders').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptgstinoutperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptgstinoutperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptgstinoutperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_gst_inout_period+"?storeId="+storeId+"&frmdate="+fromdate+"&todate="+todate+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('gstinoutreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptcatdaywiseSales(date,ktype,storeId,rpttype)
{

	var todaydate=document.getElementById('hiddaterptcatdaywiseSales').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptcatsalesdayModal();
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_sale_cat+"?date="+date+"&storeId="+storeId+"&category="+ktype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_sale_cat+"?date="+date+"&storeId="+storeId+"&category="+ktype+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	
	document.getElementById('catdaywisesalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisecreditSales(fromdate,todate,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwisecreditSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptcreditsalesperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptcreditsalesperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptcreditsalesperiodGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_credit_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_period_credit_sale+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisecreditsalereportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisecancelOrder(fromdate,todate,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwisecancelOrders').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodwisecancelorderModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodwisecancelorderModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodwisecancelorderGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_wise_cancel_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_period_wise_cancel_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	
	document.getElementById('periodwisecancelorderreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisenockotOrder(fromdate,todate,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwisenockotOrders').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodwisenockotorderModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodwisenockotorderModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodwisenockotorderGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_wise_nockot_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_period_wise_nockot_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisenockotorderreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisepackagingDetail(fromdate,todate,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwisepackagingDetails').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodwisepackagingModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodwisepackagingModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodwisepackagingGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_wise_nockot_order+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_period_wise_packaging_detail+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisepackagingdetailreportContainerId').innerHTML=pdfline;
	}
}
/* start inventory report*/
function showpdfrptdaywisePo(date,storeId,rpttype)
{

	var todaydate=document.getElementById('hiddaterptdaywisePo').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptpodayModal();
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_po+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_po+"?date="+date+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywiseporeportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwisePo(fromdate,todate,type,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwisePo').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptpoperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptpoperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptpoperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_period_po+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwiseporeportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwiseStockIn(fromdate,todate,type,storeId,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwiseStockIn').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptstockinperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptstockinperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptstockinperiodGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_period_stockin+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_period_stockin+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisestockinreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdaywiseStockIn(date,storeId,rpttype)
{

	var todaydate=document.getElementById('hiddaterptdaywiseStockIn').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptstockindayModal();
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_stockin+"?date="+date+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_stockin+"?date="+date+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywisestockinreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdaywiseStockOutallCat(date,storeId,rpttype)
{
	
	var todaydate=document.getElementById('hiddaterptdaywiseStockOutallCat').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptstockoutallcatdayModal();
		}
	else{
	var pdfline="<iframe src='"+pdf_url_day_stockout_allcat+"?date="+date+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywisestockoutallcatreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwiseStockOutallCat(fromdate,todate,type,storeId,rpttype)
{
	
	var todaydate=document.getElementById('hiddaterptperiodwiseStockOutallCat').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptstockoutallcatperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptstockoutallcatperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptstockoutallcatGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_period_stockout_allcat+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisestockoutallcatreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdaywiseStockOutKitchen(date,ktype,storeId,rpttype)
{

	var todaydate=document.getElementById('hiddaterptdaywiseStockOutKitchen').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptstockoutkitchendayModal();
		}
	else{
	var pdfline="<iframe src='"+pdf_url_day_stockout_kitchen+"?date="+date+"&storeId="+storeId+"&category="+ktype+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywisestockoutkitchenreportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptperiodwiseStockOutKitchen(fromdate,todate,type,storeId,ktype,rpttype)
{
	var todaydate=document.getElementById('hiddaterptperiodwiseStockOutKitchen').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptstockoutkitchenperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptstockoutkitchenGreaterModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptstockoutkitchenGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_period_stockout_kitchen+"?type="+type+"&frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&category="+ktype+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('periodwisestockoutkitchenreportContainerId').innerHTML=pdfline;
	}
}
/*function showpdfrptcurrentStock(storeId,rpttype)
{
	//var pdfline="<iframe src='"+pdf_url_current_stock+"?storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_current_stock+"?storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('currentstockreportContainerId').innerHTML=pdfline;
}*/

function showpdfrptcurrentStock(storeId, rpttype , date , itemid , itemName) {
	// var pdfline="<iframe src='"+pdf_url_current_stock+"?storeId="+storeId+"'
	// style='width:100%; height:450px;' frameborder='0'></iframe>";
	if(itemName ==""){itemid=0;}
	var pdfline = "<iframe src='" + pdf_url_current_stock + "?storeId="
			+ storeId + "&rptType=" + rpttype + "&curDate=" + date + "&itemId=" + itemid
			+ "' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('currentstockreportContainerId').innerHTML = pdfline;
}

function showpdfrptcustomerlist(rpttype,storeid)
{
	
	var pdfline="<iframe src='"+pdf_url_customer_list+"?storeId="+storeid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('customerListReportContainer').innerHTML=pdfline;
	
}
function showpdfoutstandingcust(storeid,rpttype)
{
	var pdfline="<iframe src='"+pdf_url_outstanding_customer_list+"?storeId="+storeid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('outstandingCustomerListReportContainer').innerHTML=pdfline;
	
}
function showpdfrpttopcustomerlist(storeid,rpttype)
{
 
 var pdfline="<iframe src='"+pdf_url_top_customer_list+"?storeId="+storeid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
 document.getElementById('topcustomerListReportContainer').innerHTML=pdfline;
 
}
function showpdfrptnewrepeatcustomer(fromdate,todate,storeId,rpttype)
{
 var todaydate=document.getElementById('hiddaterptperiodwisePo').value;
 if(dateformat(fromdate)>dateformat(todaydate))
 {
  showalertrptpoperiodModal();
  return;
 }
 if(dateformat(todate)>dateformat(todaydate))
 {
  showalertrptpoperiodModal();
  return;
 }
 if(dateformat(fromdate)>dateformat(todate))
  {
  showalertrptpoperiodGreaterModal();
  return;
  }
 else{
 var pdfline="<iframe src='"+pdf_url_new_repeat_customer_list+"?storeId="+storeId+"&orderFrom="+fromdate+"&orderTo="+todate+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
 document.getElementById('newrepeatcustomerreportContainerId').innerHTML=pdfline;
 }
}
/* end inventory report*/

// new added

function showpdfrptcancelorderscelavi(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptcancelorderscelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptcancelorderscelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptcancelorderscelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptcancelorderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_cancelorderreason+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('cancelorderscelavireportContainerId').innerHTML=pdfline;
	}
}


function showpdfrptdailymanagertaxcelavi(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterptdailymanagertaxcelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptdailymanagertaxcelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptdailymanagertaxcelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptdailymanagertaxcelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_dailymanagerwithtax+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('dailymanagertaxcelavireportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdisreasonOrderscelavi(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterptdisreasonOrderscelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptdisreasonOrderscelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptdisreasonOrderscelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptdisreasonOrderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_discountreason+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('disreasonOrderscelavireportContainerId').innerHTML=pdfline;
	}
}

function showpdfrptncOrderscelavi(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterptncOrderscelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptncOrderscelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptncOrderscelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptncOrderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_nonchargeable+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('ncOrderscelavireportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptpaymenydetOrderscelavi(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterptpaymenydetOrderscelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptpaymenydetOrderscelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptpaymenydetOrderscelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptpaymenydetOrderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_paymentwise+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('paymenydetOrderscelavireportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdailysalesinclusivecelavi(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptdailysalesinclusivecelavi').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptdailysalesinclusivecelaviModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptdailysalesinclusivecelaviModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptdailysalesinclusivecelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_dailysalesinclusive+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('dailysalesinclusivecelavireportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptdailysalessummary(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptdailysalessummary').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptdailysalessummaryModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptdailysalessummaryModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptcancelorderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_dailysalessummary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('dailysalessummaryreportContainerId').innerHTML=pdfline;
	}
}

function showpdfrptdaywiseOrdercelavi(date,storeId,rpttype)
{

	var todaydate=document.getElementById('hiddaterptdaywiseOrderscelavi').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertrptorderdaycelaviModal();
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_dailysales+"?date="+date+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('daywiseordercelavireportContainerId').innerHTML=pdfline;
	}
}
function showpdfrptoutstandingcustomerlist(storeid)
{
	
	var pdfline="<iframe src='"+pdf_url_outstanding_customer_list+"?storeId="+storeid+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('outstandingcustomerListReportContainer').innerHTML=pdfline;
	
}
function showpdfrptcatwiseperiodicSales(fromdate,todate,ktype,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptcatdaywiseSales').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptcatsalesdayModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptcatsalesdayModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptstockinperiodGreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_day_sale_cat+"?date="+fromdate+"&date1="+todate+"&storeId="+storeId+"&category="+ktype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_day_sale_cat+"?date="+fromdate+"&date1="+todate+"&storeId="+storeId+"&category="+ktype+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	
	document.getElementById('catwiseperiodicsalereportContainerId').innerHTML=pdfline;
	}
}


//For accounts report added 21th may 2018


function showpdfrptplstatement(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterptplstatement').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptplstatementperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptplstatementperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptplstatementperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_accounts_periodic_pl_statement+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('plstatementreportContainerId').innerHTML=pdfline;
	}
}



function showpdfrpttaxstatement(fromdate,todate,storeId){
	var todaydate=document.getElementById('hiddaterpttaxstatement').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrpttaxstatementperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrpttaxstatementperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrpttaxstatementperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_accounts_periodic_tax_statement+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('taxstatementreportContainerId').innerHTML=pdfline;
	}
}



function showpdfrptrefunddetails(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptrefunddetails').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptrefunddetailsperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptrefunddetailsperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptrefunddetailsperiodgreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_refunds_periodic_refund_details+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_refunds_periodic_refund_details+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";	
	document.getElementById('refunddetailsreportContainerId').innerHTML=pdfline;
	}
}


function showpdfrptrefundsummary(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptrefundsummary').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptrefundsummaryperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptrefundsummaryperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptrefundsummaryperiodgreaterModal();
		return;
		}
	else{
	//var pdfline="<iframe src='"+pdf_url_refunds_periodic_refund_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	var pdfline="<iframe src='"+pdf_url_refunds_periodic_refund_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('refundsummaryreportContainerId').innerHTML=pdfline;
	}
}



function showpdfrpttaxsummary(fromdate,todate,storeId,rpttype){
	var todaydate=document.getElementById('hiddaterptdailysalessummary').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptdailysalessummaryModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptdailysalessummaryModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptcancelorderscelaviGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_report_taxsummary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('dailysalessummaryreportContainerId').innerHTML=pdfline;
	}
}

function showPdfRptRawStockinSummary(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockin_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockInSummaryRptContainerId').innerHTML=pdfline;
	}
}

function showPdfRptRawStockinRegister(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockin_register+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockInRegisterRptContainerId').innerHTML=pdfline;
	}
}


function showPdfRptRawStockinItemWise(fromdate,todate,item,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockin_itemwise+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&itemId="+item+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockInItemWiseRptContainerId').innerHTML=pdfline;
	$('#itemid').val('0');
	$('#itmName').val('');
	}
}

function showPdfRptFgStockinSummary(fromdate,todate,vendor,storeId,rpttype){
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockin_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockInSummaryRptContainerId').innerHTML=pdfline;
	}	
}
function showPdfRptFgStockinRegister(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockin_register+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockInRegisterRptContainerId').innerHTML=pdfline;
	}
}
function showPdfRptFgStockinItemWise(fromdate,todate,item,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockin_itemwise+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&itemId="+item+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockInItemWiseRptContainerId').innerHTML=pdfline;
	$('#itemid').val('0');
	$('#itmName').val('');
	}
}




function showPdfRptRawStockoutSummary(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockout_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockOutSummaryRptContainerId').innerHTML=pdfline;
	}
}

function showPdfRptRawStockoutRegister(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockout_register+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockOutRegisterRptContainerId').innerHTML=pdfline;
	}
}


function showPdfRptRawStockoutItemWise(fromdate,todate,item,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_raw_stockout_itemwise+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&itemId="+item+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('rawStockOutItemWiseRptContainerId').innerHTML=pdfline;
	$('#itemid').val('0');
	$('#itmName').val('');
	}
}


function showPdfRptFgStockoutSummary(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockout_summary+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockOutSummaryRptContainerId').innerHTML=pdfline;
	}
}

function showPdfRptFgStockoutRegister(fromdate,todate,vendor,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockout_register+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&vendorId="+vendor+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockOutRegisterRptContainerId').innerHTML=pdfline;
	}
}


function showPdfRptFgStockoutItemWise(fromdate,todate,item,storeId,rpttype)
{
	var todaydate=document.getElementById('rpthiddate').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodGreaterModal();
		return;
		}
	else{
	var pdfline="<iframe src='"+pdf_url_fg_stockout_itemwise+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&itemId="+item+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
	document.getElementById('fgStockOutItemWiseRptContainerId').innerHTML=pdfline;
	$('#itemid').val('0');
	$('#itmName').val('');
	}
}

function showpdfrptperiodicVendorPayment(fromdate,todate,storeId,rpttype,vendorid){
	
	var todaydate=document.getElementById('hiddaterptvendorpayment').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodicvendorpaymentModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodicvendorpaymentModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodicvendorpaymentgreaterModal();
		return;
		}
	else{
	
		//var pdfline="<iframe src='"+pdf_url_periodic_vendor_payment+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"&vendorId="+vendorid+"' style='width:100%; height:450px;' frameborder='0'></iframe>";	
		var pdfline="<iframe src='"+pdf_url_periodic_vendor_payment+"?storeId="+storeId+"&frmdate="+fromdate+"&todate="+todate+"&vendorId="+vendorid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
		
		document.getElementById('periodic_vendor_payment_report_ContainerId').innerHTML=pdfline;
	}
	
}

function showpdfrptperiodicFgVendorPayment(fromdate,todate,storeId,rpttype,vendorid){
	
	var todaydate=document.getElementById('hiddaterptvendorpayment').value;
	if(dateformat(fromdate)>dateformat(todaydate))
	{
		showalertrptperiodicvendorpaymentModal();
		return;
	}
	if(dateformat(todate)>dateformat(todaydate))
	{
		showalertrptperiodicvendorpaymentModal();
		return;
	}
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertrptperiodicvendorpaymentgreaterModal();
		return;
		}
	else{
	
		//var pdfline="<iframe src='"+pdf_url_periodic_vendor_payment+"?frmdate="+fromdate+"&todate="+todate+"&storeId="+storeId+"&rptType="+rpttype+"&vendorId="+vendorid+"' style='width:100%; height:450px;' frameborder='0'></iframe>";	
		var pdfline="<iframe src='"+pdf_url_periodic_fgvendor_payment+"?storeId="+storeId+"&frmdate="+fromdate+"&todate="+todate+"&vendorId="+vendorid+"&rptType="+rpttype+"' style='width:100%; height:450px;' frameborder='0'></iframe>";
		
		document.getElementById('periodic_fgvendor_payment_report_ContainerId').innerHTML=pdfline;
	}	
}
function showPdfRptInvRawStockOutSummary(fromdate, todate, vendor, storeId, rpttype) {
	var todaydate = document.getElementById('rpthiddate').value;
	if (dateformat(fromdate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(todate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(fromdate) > dateformat(todate)) {
		showalertrptperiodGreaterModal();
		return;
	} else {
		var pdfline = "<iframe src='"
				+ pdf_url_inv_raw_stockout_summary
				+ "?frmdate=" + fromdate + "&todate=" + todate + "&storeId=" + storeId + "&rptType=" + rpttype + "' style='width:100%; height:450px;' frameborder='0'></iframe>";
		document.getElementById('rawInvStockOutSummaryRptContainerId').innerHTML = pdfline;
	}
}

function showPdfRptInvRawStockoutRegister(fromdate, todate, vendor, storeId,
		rpttype) {
	var todaydate = document.getElementById('rpthiddate').value;
	if (dateformat(fromdate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(todate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(fromdate) > dateformat(todate)) {
		showalertrptperiodGreaterModal();
		return;
	} else {
		var pdfline = "<iframe src='"
				+ pdf_url_inv_raw_stockout_register
				+ "?frmdate="
				+ fromdate
				+ "&todate="
				+ todate
				+ "&storeId="
				+ storeId
				+ "&rptType="
				+ rpttype
				+ "' style='width:100%; height:450px;' frameborder='0'></iframe>";
		document.getElementById('rawInvStockOutRegisterRptContainerId').innerHTML = pdfline;
	}
}

function showPdfRptInvRawStockoutItemWise(fromdate, todate, item, storeId, rpttype) {
	var todaydate = document.getElementById('rpthiddate').value;
	if (dateformat(fromdate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(todate) > dateformat(todaydate)) {
		showalertrptperiodModal();
		return;
	}
	if (dateformat(fromdate) > dateformat(todate)) {
		showalertrptperiodGreaterModal();
		return;
	} else {
		var pdfline = "<iframe src='"
				+ pdf_url_inv_raw_stockout_itemwise
				+ "?frmdate="
				+ fromdate
				+ "&todate="
				+ todate
				+ "&storeId="
				+ storeId
				+ "&itemId="
				+ item
				+ "&rptType="
				+ rpttype
				+ "' style='width:100%; height:450px;' frameborder='0'></iframe>";
		document.getElementById('rawInvStockOutItemWiseRptContainerId').innerHTML = pdfline;
		$('#itemid').val('0');
		$('#itmName').val('');
	}
}


