/**
 * 
 */


function getcreditInvinvoiceByvendorId(id,name,contact)
{
	//alert(id+':'+name+':'+contact);
	console.log("id="+id);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/getfgvendorpaymentinfobyid/" + id +".htm", function(response) {
		try{
			console.log("response="+response);
			var responseObj=JSON.parse(response);
			prepareCreditVendorPaymentHtml(responseObj);
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	document.getElementById('creditvendornameContId').innerHTML=name;
	document.getElementById('creditvendorcontactContId').innerHTML=contact;
	document.getElementById('creditvendoridContId').value=id;  
}
function prepareCreditVendorPaymentHtml(responseData)
{
	var creditvendorcontainerId=document.getElementById('creditinvinvoicetableContId');
	var starttable="<table class='table table-striped table-bordered table-hover'>"+
    				"<thead style='background:#404040; color:#FFF;'><th style='text-align:center;'>INVOICE NO</th><th style='text-align:center;'>DATE</th><th style='text-align:center;'>BILL AMT</th><th style='text-align:center;'>PAID AMT</th><th style='text-align:center;display:none;'>RET AMT</th><th style='text-align:center;'>DUE AMT</th><th style='text-align:center;'>PAY</th>"+
    				"</thead>";
    				"<tbody >";
    var endtable="</tbody></table>";
    var createdrowline="";
    var generatedHtml = "";
    var totBillAmt=0.0;
    var totAmttoPay=0.0;
    var totPaidAmt=0.0;
    var totRetAmt=0.0;
    if(responseData.length>0)
    	{
    	for(var i=0;i<responseData.length;i++)
    		{
    		
    		var creditinvinvoice=responseData[i];
    		var begintr="<tr style='background:#404040; color:#FFF;'>";
    		var firsttd="<td align='center'>"+creditinvinvoice.fgStockInId+"</td>";
    		var secondtd="<td align='center'>"+creditinvinvoice.fgStockInDate +"</td>";
    		var thirdtd="<td align='center'>"+parseFloat(creditinvinvoice.billAmount).toFixed(2)+"</td>";
    		var fourthtd="<td align='center'>"+parseFloat(creditinvinvoice.paidAmount).toFixed(2)+"</td>";
    		var fourthtd1="<td align='center' style='display:none;'>"+parseFloat(creditinvinvoice.returnAmount).toFixed(2)+"</td>";
    		var fifthtd="<td align='center'>"+parseFloat(creditinvinvoice.amountToPay).toFixed(2)+"</td>";
    		var sixthtd="<td align='center'><a href='javascript:opencr_vendorCashModal("+creditinvinvoice.fgStockInId+","+"&quot;"+creditinvinvoice.fgStockInDate+"&quot;,"+creditinvinvoice.billAmount+","+creditinvinvoice.paidAmount+","+creditinvinvoice.amountToPay+")' class='btn btn-success'>PAY</a></td>";
    		var endtr="</tr>";
    		createdrowline+=begintr+firsttd+secondtd+thirdtd+fourthtd+fourthtd1+fifthtd+sixthtd+endtr;
    		totBillAmt+=creditinvinvoice.billAmount;
    		totAmttoPay+=creditinvinvoice.amountToPay;
    		totPaidAmt+=creditinvinvoice.paidAmount;
    		totRetAmt+=creditinvinvoice.returnAmount;
    		}
    	if(responseData.length>1)
    	{
    		var begintottr="<tr style='background:#e2e2e2; color:#222222;'>";
    		var totaltd="<td colspan='2' align='center'>TOTAL</td>";
    		var totalbilltd="<td align='center'>"+parseFloat(totBillAmt).toFixed(2)+"</td>";
    		var totalpaidtd="<td align='center'>"+parseFloat(totPaidAmt).toFixed(2)+"</td>";
    		var totalrettd="<td align='center' style='display:none;'>"+parseFloat(totRetAmt).toFixed(2)+"</td>";
    		var totalduetd="<td align='center'>"+parseFloat(totAmttoPay).toFixed(2)+"</td>";
    		var totalpaytd="<td align='center'><a href='javascript:opentotcr_vendorCashModal("+totBillAmt+","+totPaidAmt+","+totAmttoPay+")' class='btn btn-success'>PAY</a></td>";
    		var endtottr="</tr>";
    		createdrowline+=begintottr+totaltd+totalbilltd+totalpaidtd+totalrettd+totalduetd+totalpaytd+endtottr;
    	}
    	}
    else
    	{
    	var begintr="<tr style='background:#404040; color:#FFF;'>";
    	var firsttd="<td colspan='7'>No Data found!</td>";
    	var endtr="</tr>";
    	createdrowline+=begintr+firsttd+endtr;
    	}
    generatedHtml=starttable+createdrowline+endtable;
    creditvendorcontainerId.innerHTML=generatedHtml;
}
function opencr_vendorCashModal(invoiceno,invoiceDate,billAmt,paidAmt,amttoPay)
{
	document.getElementById('cr_vendorcashtenderAmt').value='';
	document.getElementById('cr_vendorpaycashalertMsg').innerHTML='';
	document.getElementById('cr_vendorcashmodNameCont').innerHTML=document.getElementById('creditvendornameContId').innerHTML;
	document.getElementById('cr_vendorcashmodInvoiceNoCont').innerHTML=invoiceno;
	document.getElementById('cr_vendorcashmodInvoiceDateCont').value=invoiceDate;
	document.getElementById('cr_vendorcashtotamtcontId').innerHTML=parseFloat(billAmt).toFixed(2);
	document.getElementById('cr_vendorcashpaidamtcontId').innerHTML=parseFloat(paidAmt).toFixed(2);
	document.getElementById('cr_vendorcashamttopaycontId').innerHTML=parseFloat(amttoPay).toFixed(2);
	showcr_vendorCashModal();
}
function getcr_vendorChangeAmt(tenderAmt)
{
	var amntToPay=document.getElementById('cr_vendorcashamttopaycontId').innerHTML;
	if(tenderAmt=='')
		{
		document.getElementById('cr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
		{
			document.getElementById('cr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else
		{
			document.getElementById('cr_vendorcashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
		}
}
function cr_vendorpayByCash(tenderAmt)
{
	var vendorid=document.getElementById('creditvendoridContId').value;
	var invoiceno=document.getElementById('cr_vendorcashmodInvoiceNoCont').innerHTML;
	var invoiceDate=document.getElementById('cr_vendorcashmodInvoiceDateCont').value;
	var billAmt=document.getElementById('cr_vendorcashtotamtcontId').innerHTML;
	var paidAmnt=document.getElementById('cr_vendorcashpaidamtcontId').innerHTML;
	var amntToPay=document.getElementById('cr_vendorcashamttopaycontId').innerHTML;
	if (!parseFloat(tenderAmt))
	{
	document.getElementById('cr_vendorpaycashalertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('cr_vendorcashtenderAmt').focus();
	}
	else
	{
		if(parseFloat(tenderAmt)>=parseFloat(amntToPay))
		{
			paidAmnt=parseFloat(amntToPay);
			amntToPay=0.0;
		}
		else
		{
			paidAmnt=parseFloat(tenderAmt);
			amntToPay=(parseFloat(amntToPay)-parseFloat(tenderAmt)).toFixed(2);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/fgvendorpayment/"+invoiceno +"/"+ invoiceDate+"/"+ vendorid+"/"+ billAmt+"/"+ paidAmnt+"/"+ amntToPay + ".htm", function(response) {
			try{
				if(response=='success')
					{
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/getfgvendorpaymentinfobyid/" + vendorid +".htm", function(response) {
						try{
							var responseObj=JSON.parse(response);
							prepareCreditVendorPaymentHtml(responseObj);
						}catch(e)
						{
							alert(e);
						}
						
					}, null);
					hidecr_vendorCashModal();
					}
				}catch(e){alert(e);}
			}, null);
	}
}
function opentotcr_vendorCashModal(billAmt,paidAmt,amttoPay)
{
	document.getElementById('totcr_vendorcashtenderAmt').value='';
	document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='';
	document.getElementById('totvendorcashpaySpinner').style.display="none";
	document.getElementById('totcr_vendorcashtotamtcontId').innerHTML=parseFloat(billAmt).toFixed(2);
	document.getElementById('totcr_vendorcashpaidamtcontId').innerHTML=parseFloat(paidAmt).toFixed(2);
	document.getElementById('totcr_vendorcashamttopaycontId').innerHTML=parseFloat(amttoPay).toFixed(2);
	showtotcr_vendorCashModal();
}
function gettotcr_vendorChangeAmt(tenderAmt)
{
	var amntToPay=document.getElementById('totcr_vendorcashamttopaycontId').innerHTML;
	if(tenderAmt=='')
		{
		document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
		{
			document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else
		{
			document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
		}
}
function totcr_vendorpayByCash(tenderAmt)
{
	var vendorid=document.getElementById('creditvendoridContId').value;
	
	//var billAmt=document.getElementById('totcr_salecashtotamtcontId').innerHTML;
	//var paidAmnt=document.getElementById('totcr_salecashpaidamtcontId').innerHTML;
	//var amntToPay=document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	//alert(custid+':'+tenderAmt);
	if (!parseFloat(tenderAmt))
	{
	//alert('Please eneter a valid number!');
	document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('totcr_vendorcashtenderAmt').focus();
	}
	else
	{
		document.getElementById('totvendorcashpaySpinner').style.display="inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/payfgvendorbulkcashbycustid/" + vendorid +"/"+tenderAmt+".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareCreditVendorPaymentHtml(responseObj);
				hidetotcr_vendorCashModal();
			}catch(e)
			{
				alert(e);
			}
			
		}, null);
	
	}
}
/*end vendor payment*/