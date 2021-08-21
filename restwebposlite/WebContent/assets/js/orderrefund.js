/**
 *
 */
var slno=0;
function numcheck(e) {

    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}
function showPaidorderDataForRefund(){

	var orderid= document.getElementById('paidOrderId').value;
	if(orderid == '' || orderid == 'undefined' || orderid == null){
		document.getElementById('msgspace').innerHTML = "Please Enter Valid Order Id.";
		$("#msgmodal").modal('show');
	}else{
		$("#paidorderforrefundtbodyd").html("");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyOrderNumber/" + orderid + ".htm", function(response) {
			console.log("response=" + response);
			var orderdetails = JSON.parse(response);
		     //alert(orderdetails.length);
			if(orderdetails.length > 0){
				for ( var i = 0; i < orderdetails.length; i++) {
					var order=orderdetails[i];
					//alert(order.id);

					var trlinestart= "<tr style='background: #222222; cursor: pointer;'>";
					var firsttd = "<td style='text-align: center;'>"+1+"</td>";
					var secondtd= "<td style='text-align: center;'>"+ order.orderNo +"</td>";
					var thirdtd= "<td style='text-align: center;'>"+ parseFloat(order.orderBill.grossAmt).toFixed(2)+"</td>";
					var fourthtd="";
					if(order.table_no == 0 ){
						fourthtd="<td style='text-align: center;'>"+order.ordertype.orderTypeName+"</td>";
					}
					else{
						fourthtd="<td style='text-align: center;'>"+order.table_no+"</td>";

					}
					 var fifthtd = "<td style='text-align: center;'>"+order.orderTime+"</td>";
					 var sixthtd="";
					 if(order.refundStatus=='N'){
						 sixthtd = "<td align='center'><a href='javascript:openRefundModal("+order.id+")' class='btn btn-success' style='text-align: center; width: 46%; margin-top: 2px;'>REFUND</a></td>";
					   }
					 if(order.refundStatus=='C'){
						 sixthtd= "<td align='center'><a href='javascript:openRefundApproveModal("+order.id+",&quot;"+order.ordertype.orderTypeName+"&quot;,&quot;"+order.table_no+"&quot;)' class='btn btn-success' style='text-align: center; width: 46%; margin-top: 2px;'>APPROVE</a></td>";
						 }
					  if(order.refundStatus=='F'){
						  sixthtd = "<td align='center'><a href='javascript:openRefundDetailsModal("+order.id+",&quot;"+order.ordertype.orderTypeName+"&quot;,&quot;"+order.table_no+"&quot;)' class='btn btn-success' style='text-align: center; width: 46%; margin-top: 2px;'>DETAILS</a>&nbsp;&nbsp;<a href='javascript:printRefundBill("+order.id+")' class='btn btn-success' style='text-align: center; width: 46%; margin-top: 2px;'>PRINT</a></td>";
					  }

					  var trlineend="</tr>"	;

					  var createdline = trlinestart + firsttd + secondtd + thirdtd + fourthtd + fifthtd + sixthtd + trlineend;
					}
				$("#paidorderforrefundtbodyd").append(createdline);

			}
			else{
				var trlinestart= "<tr style='background: #222222; cursor: pointer;'><td colspan='6'>";
				var msg="No Data Found!"
				var trlineend="</td></tr>";
				var createdline=trlinestart+msg+trlineend;
					$("#paidorderforrefundtbodyd").append(createdline);
			}


		}, null);

	}


}


/////////////////////////////////////////////////////////////



function openRefundModal(orderid){
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getpaidorderdatabyid/" + orderid + ".htm", function(response) {
		console.log("response=" + response);
		var orders = JSON.parse(response);
	    if(orders.length > 0){
			for ( var i = 0; i < orders.length; i++) {
				var order=orders[i];
				var actualitemsubtotal=0.0;
				var actualitemvat=0.0;
				var actualitemst=0.0;
				   $("#refundableitemsdetailsofordertbody").html("");
				   for(var j=0;j<order.orderitem.length;j++){
					   var itemdetail = order.orderitem[j];
					   slno=slno+1;
					   var starttrline = "<tr id=" + itemdetail.id + ">";
					   var selecttd = "<td style='text-align:center;'>"+ "<input type='checkbox' name='select' id='select_"+itemdetail.id+"' value='"+itemdetail.id+"' onchange='setChange(this,"+itemdetail.id+");'>" + "</td>";
					   var sltd = "<td  id='ordereditem_" + itemdetail.id + "'>"+ slno + "</td>";
					   var item_code_td="<td  id='ordereditemcode_" + itemdetail.id + "'>"+ itemdetail.item.id + "</td>";
					   var item_name_td="<td  id='ordereditemname_" + itemdetail.id + "'>"+ itemdetail.item.name + "</td>";
					   var item_rate_td="<td  id='ordereditemrate_" + itemdetail.id + "'>"+ itemdetail.rate + "</td>";
					   var item_sold_qty_td="<td  id='ordereditemsoldqty_" + itemdetail.id + "'>"+ itemdetail.quantityOfItem + "</td>";
					   var item_return_qty_td = "<td  id='ordereditemreturnqty_" + itemdetail.id + "'><input type='text'   id='inpordereditemreturnqty_" + itemdetail.id + "' value='" + itemdetail.quantityOfItem + "' size='5' style='color: black;' onKeyUp='calculateBill("+ itemdetail.id +");' disabled />"  + "</td>";
					   var item_unit_td="<td  id='ordereditemunit_" + itemdetail.id + "' style='display:none;'>"+ itemdetail.item.unit + "</td>";
					   var item_total_td="<td  id='ordereditemtotal_" + itemdetail.id + "'>"+  parseFloat(Number(itemdetail.totalPriceByItem)-Number(itemdetail.promotionDiscountAmt)).toFixed(2); + "</td>";

					   var itemactualprice=parseFloat(Number(itemdetail.totalPriceByItem)-Number(itemdetail.promotionDiscountAmt)).toFixed(2);
					       actualitemsubtotal= parseFloat(Number(actualitemsubtotal) + Number(itemactualprice)).toFixed(2);

					   var item_price_td="<td  id='ordereditemprice_" + itemdetail.id + "' style='display:none;'>"+  parseFloat(itemdetail.netPrice).toFixed(2) + "</td>";
					   var item_promotionvalue_td="<td  id='ordereditempromotionvalue_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.promotionValue + "</td>";
					   var item_vat_td="<td  id='ordereditemvat_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.vat + "</td>";
					   var item_servicetax_td="<td  id='ordereditemservicetax_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.serviceTax + "</td>";
					   var vatAmt = ((Number(itemdetail.totalPriceByItem) - Number(itemdetail.customerDiscount)) * Number(itemdetail.vat))/100;
					   var serviceTaxAmt = ((Number(itemdetail.totalPriceByItem) - Number(itemdetail.customerDiscount)) * Number(itemdetail.serviceTax))/100;
					   var item_vatamt_td="<td  id='ordereditemvatamt_" + itemdetail.id + "'style='display:none;'>"+ parseFloat(vatAmt).toFixed(2)+ "</td>";
					   var item_servicetaxamt_td="<td  id='ordereditemservicetaxamt_" + itemdetail.id + "'style='display:none;'>" +parseFloat(serviceTaxAmt).toFixed(2) +"</td>";
					   var item_discperc_td="<td  id='ordereditemdiscountperc_" + itemdetail.id + "'style='display:none;'>" +parseFloat(itemdetail.discountPercentage).toFixed(2) +"</td>";
					   var item_discamt_td="<td  id='ordereditemdiscountamt_" + itemdetail.id + "'style='display:none;'>" +parseFloat(itemdetail.customerDiscount).toFixed(2) +"</td>";
					   var item_spotdiscount_td="<td  id='ordereditemspotdiscount_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.spotDiscount + "</td>";
					   var item_return_reason_td="";
					   actualitemvat= parseFloat(Number(actualitemvat) + Number(vatAmt));
					   actualitemst= parseFloat(Number(actualitemst) + Number(serviceTaxAmt));
					   var item_return_reason_td = "<td  id='ordereditemreturnreason_" + itemdetail.id + "' style='display:none;'><input type='text'   id='inpordereditemreturnreason_" + itemdetail.id + "' value='' size='10' style='color: black;' />"  + "</td>";
					   var item_promotionflag_td="<td  id='ordereditempromotionflag_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.promotionFlag + "</td>";
					   var item_promotionvalue_td="<td  id='ordereditempromotionvalue_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.item.promotionValue + "</td>";
					   var endtrline = "</tr>";
					   var cratedline =starttrline+selecttd+sltd+item_code_td+item_name_td+item_rate_td+item_sold_qty_td+item_return_qty_td+item_unit_td+item_total_td+item_price_td+item_promotionvalue_td+item_vat_td+item_servicetax_td+item_spotdiscount_td+item_return_reason_td+item_promotionflag_td+item_promotionvalue_td+item_vatamt_td+item_servicetaxamt_td+item_discperc_td+item_discamt_td+endtrline;
                       $("#refundableitemsdetailsofordertbody").append(cratedline);

				   }

				   document.getElementById('paidorderno').innerHTML = order.id;
				   document.getElementById('storebasepaidorderno').innerHTML = order.orderNo;
				   document.getElementById('paidorderdate').innerHTML = order.orderDate; 
				   
				
				   if(order.table_no == 0 ){
					   document.getElementById('paidordertbl').innerHTML =order.ordertype.orderTypeName;
					}
					else{
						document.getElementById('paidordertbl').innerHTML =order.table_no;
					}
				   document.getElementById('paidordercustomerid').innerHTML =order.storeCustomerId;
				   document.getElementById('paidordercustomername').innerHTML =order.customerName;
				   document.getElementById('paidordercustomercontactno').innerHTML = order.customerContact;
				   document.getElementById('paidordercustomeraddress').innerHTML = order.deliveryAddress;
				   document.getElementById('paidorderdeliveryboy').innerHTML =order.deliveryPersonName;
				   document.getElementById('paidorderwaiter').innerHTML =order.waiterName;

				   //document.getElementById('paidordertotalitemprice').innerHTML =parseFloat(order.orderBill.subTotalAmt).toFixed(2);
				   document.getElementById('paidordertotalitemprice').innerHTML =parseFloat(actualitemsubtotal).toFixed(2);
				   //alert("servicechargeflag:"+servicechargeflag);
				   if(servicechargeflag=='Y'){
				   document.getElementById('paidorderschargepers').innerHTML =parseFloat(order.orderBill.serviceChargeRate).toFixed(2);
			       document.getElementById('paidorderschargeamt').innerHTML =parseFloat(order.orderBill.serviceChargeAmt).toFixed(2);
				  }
			       document.getElementById('paidorderdiscpers').innerHTML =parseFloat(order.orderBill.discountPercentage).toFixed(2);
				   document.getElementById('paidorderdiscamt').innerHTML =parseFloat(order.orderBill.customerDiscount).toFixed(2);
				   //alert("vatTaxText:"+vatTaxText);
				   if(vatTaxText!=0){
				   //document.getElementById('paidordervatamt').innerHTML =parseFloat(order.orderBill.vatAmt).toFixed(2);
					   document.getElementById('paidordervatamt').innerHTML =parseFloat(actualitemvat).toFixed(2);
				   }
				  // alert("serviceTaxText:"+serviceTaxText);
				   if(serviceTaxText!=0){
				   //document.getElementById('paidorderstaxamt').innerHTML =parseFloat(order.orderBill.serviceTaxAmt).toFixed(2);
					   document.getElementById('paidorderstaxamt').innerHTML =parseFloat(actualitemst).toFixed(2);
			         }
				   //document.getElementById('paidordernetamt').innerHTML =parseFloat(order.orderBill.grossAmt).toFixed(2);
				   document.getElementById('paidordernetamt').innerHTML =parseFloat(Number(actualitemsubtotal)+Number(actualitemvat)+Number(actualitemst)).toFixed(2);
				   slno=0;
				}
			document.getElementById('addsalesreturnalertMsg').innerHTML = '';
			$('#orderrefundmodal').modal('show');

		}

	}, null);

}


function setReturnReason(reasonid){
	//alert("reasonid"+reasonid);
	$('#refundableitemtable > tbody  > tr').each(function() {
		console.log("tr id=" + this.id);
		var that = this;
		var trid = this.id;
		$("#inpordereditemreturnreason_" + trid).val(reasonid);

	});

}


function addorderrefunddata(){
	  var orderid= document.getElementById('paidorderno').innerHTML;
	  var orderDate=document.getElementById('paidorderdate').innerHTML;
	  var tableno = document.getElementById('paidordertbl').innerHTML;
	  var customerId= document.getElementById('paidordercustomerid').innerHTML;
	  var customerName= document.getElementById('paidordercustomername').innerHTML;
	  var customerContact=document.getElementById('paidordercustomercontactno').innerHTML;
	  var deliveryAddress= document.getElementById('paidordercustomeraddress').innerHTML;
	  var deliveryPersonName =document.getElementById('paidorderdeliveryboy').innerHTML;
	  var waiterName=document.getElementById('paidorderwaiter').innerHTML;
	  var subTotalAmt=document.getElementById('paidordertotalitemprice').innerHTML;
	  var serviceChargeRate=0;
	  var serviceChargeAmt=0;
		  if(servicechargeflag=='Y'){
		  serviceChargeRate=document.getElementById('paidorderschargepers').innerHTML;
		  serviceChargeAmt= document.getElementById('paidorderschargeamt').innerHTML;
		  }

	  var discountPercentage= document.getElementById('paidorderdiscpers').innerHTML;
	  var customerDiscount=document.getElementById('paidorderdiscamt').innerHTML;
	  var vatAmt=0;
	  var vatrate=0;
		  if(vatTaxText!=0){
			 vatrate=document.getElementById('paidordervatpers').innerHTML;
	         vatAmt= document.getElementById('paidordervatamt').innerHTML;
		  }
	  var serviceTaxAmt=0;
	  var staxrate=0;
		   if(serviceTaxText!=0){
	          staxrate=document.getElementById('paidorderstaxpers').innerHTML;
	          serviceTaxAmt=document.getElementById('paidorderstaxamt').innerHTML;
		     }

	  var netAmt =document.getElementById('paidordernetamt').innerHTML;
      var reason = document.getElementById('returnreason').value;
	  var remarks = document.getElementById('refundremark').value;

	  var storeId= storeID;
	  var todate=todaydate;
	  var SalesReturnItems=[];
	  var salesreturn = {};//main
	  var returntypes={};
	  
	  var totItemTotal = 0.0;
	  var totDiscountAmount = 0.0;
	  var totServicechargeAmount = 0.0;
	  var totVatAmount = 0.0;
	  var totServiceTaxAmount = 0.0;
	  var totDiscountAmount = 0.0;
	  var totNetAmount = 0.0;
	  var totCount = 0;
	  var selectedCount = 0;
	  var refundpartialItems = 'N';
	  $('#refundableitemtable > tbody  > tr').each(function() {
			console.log("tr id=" + this.id);
			var that = this;
			var trid = this.id;
			totCount++;
			if ($('#select_' + trid).is(':checked')){
				selectedCount++;
				var itemcode=$("#ordereditemcode_" + trid).text();
				var itemname=$("#ordereditemname_" + trid).text();
				var itemrate=$("#ordereditemrate_" + trid).text();
				var itemtotal=$("#ordereditemtotal_" + trid).text();
				var itemPrice=$("#ordereditemprice_" + trid).text();
				var itemSoldQuantity=$("#ordereditemsoldqty_" + trid).text();
				var itemReturnQuantity=$("#inpordereditemreturnqty_" + trid).val();
				
				if(Number(itemSoldQuantity)!=Number(itemReturnQuantity)){
					refundpartialItems = 'Y';
				}
				
				var metricUnit=$("#ordereditemunit_" + trid).text();
				var returnreasonid=$("#inpordereditemreturnreason_" + trid).val();
				var vat=$("#ordereditemvat_" + trid).text();
				var serviceTax=$("#ordereditemservicetax_" + trid).text();
				/*var vatAmt = $("#ordereditemvatamt_" + trid).text();
				var setviceTaxAmt = $("#ordereditemservicetaxamt_" + trid).text();*/
				var promotionflag=$("#ordereditempromotionflag_" + trid).text();
				var promotionvalue=$("#ordereditempromotionvalue_" + trid).text();
				var discountonitem= parseFloat(Number(itemtotal) * Number(discountPercentage) / 100).toFixed(2);
				var servicechargeonitem= parseFloat(((Number(itemtotal) - Number(discountonitem))*Number(serviceChargeRate))/100).toFixed(2);
				var itmtaxableamt= parseFloat(Number(itemtotal) - Number(discountonitem) + Number(servicechargeonitem)).toFixed(2);
				var vatAmt= parseFloat(Number(itmtaxableamt) * Number(vat) / 100).toFixed(2);
				var serviceTaxAmt = parseFloat(Number(itmtaxableamt) * Number(serviceTax) / 100).toFixed(2);
				var disPer=$("#ordereditemdiscountperc_" + trid).text();
				var disAmt=$("#ordereditemdiscountamt_" + trid).text();
	
				totItemTotal +=Number(itemtotal);
				totDiscountAmount += Number(disAmt);
				totServicechargeAmount += Number(servicechargeonitem);
				totVatAmount += Number(vatAmt);
				totServiceTaxAmount += Number(serviceTaxAmt);
				totNetAmount +=Number(itemPrice);
				
				var SalesReturnItem  = {};
				var SalesReturnItemarr = {};
				var marticunit={};
				var returntypes={};
				    SalesReturnItem.storeId = storeId;
				    SalesReturnItem.itemSoldQuantity =itemSoldQuantity;
				    SalesReturnItem.itemReturnQuantity = itemReturnQuantity;
				    SalesReturnItem.itemRate = itemrate;
				    SalesReturnItem.itemReturnRate = itemrate;
				    SalesReturnItem.itemPrice = itemtotal;
				    SalesReturnItem.disPer = disPer;
				    SalesReturnItem.disAmt = disAmt;
				    SalesReturnItem.vat= vat;
				    SalesReturnItem.vatAmt = vatAmt;
				    SalesReturnItem.serviceTax= serviceTax;
				    SalesReturnItem.serviceTaxAmt = serviceTaxAmt;
				    SalesReturnItem.itemReturnPrice = itemPrice;
				    SalesReturnItem.unitName=metricUnit
				    SalesReturnItem.unitId=0;
				    SalesReturnItem.orderId=orderid;
	
	
				    returntypes.id=returnreasonid;
				    SalesReturnItem.returnTypes = returntypes;
	
				    SalesReturnItem.remarks = remarks;
				    /*SalesReturnItem.createdDate = todate;
				    SalesReturnItem.createdBy = storeId;*/
				    SalesReturnItem.deleteFlag ="N";
				    SalesReturnItemarr.id = itemcode;
				    SalesReturnItem.menuItem = SalesReturnItemarr;
	
	
				     SalesReturnItems.push(SalesReturnItem);
	        }
		});

	  salesreturn.salesReturnItems=SalesReturnItems;
	  //salesreturn.date=todate;
	  salesreturn.storeId=storeId;
	  salesreturn.orderId=orderid;
	  salesreturn.customerName=customerName;
	  salesreturn.customerContact=customerContact;
	  salesreturn.deliveryAddress=deliveryAddress;
	  salesreturn.deliveryPersonName=deliveryPersonName;
	  salesreturn.waiterName=waiterName;
	  salesreturn.storeCustId=customerId;//customer id if exist else 0
	  returntypes.id=reason;
	  salesreturn.returnTypes=returntypes;
	  /*salesreturn.itemTotal=subTotalAmt;
	  salesreturn.disPer=discountPercentage;
	  salesreturn.disAmt=customerDiscount;
	  salesreturn.serviceCharge=serviceChargeAmt;
	  salesreturn.serviceChargeRate=serviceChargeRate;
	  salesreturn.vatAmt=vatAmt;
	  salesreturn.serviceTaxAmt=serviceTaxAmt;
	  salesreturn.netAmt=netAmt;*/
	  salesreturn.itemTotal=parseFloat(totItemTotal).toFixed(2);
	  salesreturn.disPer=parseFloat(discountPercentage).toFixed(2);
	  salesreturn.disAmt=parseFloat(totDiscountAmount).toFixed(2);
	  salesreturn.serviceCharge=parseFloat(totServicechargeAmount).toFixed(2);
	  salesreturn.serviceChargeRate=parseFloat(serviceChargeRate).toFixed(2);
	  salesreturn.vatAmt=parseFloat(totVatAmount).toFixed(2);
	  salesreturn.serviceTaxAmt=parseFloat(totServiceTaxAmount).toFixed(2);
	  salesreturn.netAmt=parseFloat(totNetAmount).toFixed(2);
	  salesreturn.remark=remarks;
	  var returnStatus = '';
	  if(Number(totCount) == Number(selectedCount)){
		  if(refundpartialItems == 'Y'){
			  returnStatus = 'P';
		  }else{
			  returnStatus = 'F';
		  }
		  
	  }else{
		  returnStatus = 'P';
	  }
	  
	  
	  console.log("salesreturn data:"+JSON.stringify(salesreturn));
	 if(reason != 0){
	  $.ajax({
			url : BASE_URL + "/refund/refundorder.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(salesreturn),
			success : function(response) {
				if (response == 'success') {
					location.reload();

				} else{
					document.getElementById('addsalesreturnalertMsg').innerHTML = ''
						+ "Error Occurred" + '';
				}


			},
			error : function(e) {
			}
		});
      }
	 else{
		 document.getElementById('addsalesreturnalertMsg').innerHTML = "Please Select Valid Reason." ;
	 }

}


function openRefundApproveModal(orderid,ordertype,tblno){
	//alert("orderid"+orderid+"ordertype:"+ordertype+"tblno:"+tblno);

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/refund/getrefundorderdatabyidforapprove/" + orderid + ".htm", function(response) {
		console.log("response=" + response);
		var refundorders = JSON.parse(response);
				var order=refundorders;

				//alert(order.id);

				   //alert(order.salesReturnItems.length);
				   $("#refundableitemsdetailsofordertbodyforapprove").html("");
				   for(var j=0;j<order.salesReturnItems.length;j++){
					   var itemdetail = order.salesReturnItems[j];
					   slno=slno+1;
					   var starttrline = "<tr id=" + itemdetail.id + ">";
					   var sltd = "<td  id='ordereditemforapprove_" + itemdetail.id + "'>"+ slno + "</td>";
					   var item_code_td="<td  id='ordereditemcodeforapprove_" + itemdetail.id + "'>"+ itemdetail.menuItem.id + "</td>";
					   var item_name_td="<td  id='ordereditemnameforapprove_" + itemdetail.id + "'>"+ itemdetail.menuItem.name + "</td>";
					   var item_rate_td="<td  id='ordereditemrateforapprove_" + itemdetail.id + "'>"+ itemdetail.itemRate + "</td>";
					   var item_sold_qty_td="<td  id='ordereditemsoldqtyforapprove_" + itemdetail.id + "'>"+ itemdetail.itemSoldQuantity + "</td>";
					   var item_return_qty_td = "<td  id='ordereditemreturnqtyforapprove_" + itemdetail.id + "'><input type='text' style='display:none;'  id='inpordereditemreturnqtyforapprove_" + itemdetail.id + "' value='" + itemdetail.itemReturnQuantity + "' size='5' style='color: black;'/>"+itemdetail.itemReturnQuantity  + "</td>";

					   var item_unit_td="<td  id='ordereditemunitforapprove_" + itemdetail.id + "' style='display:none;'>"+ itemdetail.unitName + "</td>";

					   var item_total_td="<td  id='ordereditemtotalforapprove_" + itemdetail.id + "'>"+  parseFloat(itemdetail.itemPrice).toFixed(2) + "</td>";
					   var item_price_td="<td  id='ordereditempriceforapprove_" + itemdetail.id + "' style='display:none;'>"+  parseFloat(itemdetail.itemReturnPrice).toFixed(2) + "</td>";
					   var item_promotionvalue_td="<td  id='ordereditempromotionvalueforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.promotionValue + "</td>";
					   var item_promotionvalue_flag_td="<td  id='ordereditempromotionvalueflagforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.promotionFlag + "</td>";

					   var item_vat_td="<td  id='ordereditemvatforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.vat + "</td>";
					   var item_vat_amt_td="<td  id='ordereditemvatamtforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.vatAmt + "</td>";

					   var item_servicetax_td="<td  id='ordereditemservicetaxforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.serviceTax + "</td>";
					   var item_servicetaxamt_td="<td  id='ordereditemservicetaxamtforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.serviceTaxAmt + "</td>";

					   var item_spotdiscount_td="<td  id='ordereditemspotdiscountforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.spotDiscount + "</td>";
					   var item_orderid_td="<td  id='ordereditemorderforapprove_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.orderId + "</td>";

					   var item_return_reason_td="";
					   //if(printReason == 'Y'){
					       item_return_reason_td = "<td  id='ordereditemreturnreasonforapprove_" + itemdetail.id + "' style='display:none;'><input type='text'   id='inpordereditemreturnreasonforapprove_" + itemdetail.id + "' value='"+itemdetail.returnTypes.id+"' size='10' style='color: black;'/>"  + "</td>";
					  // }
					   var endtrline = "</tr>";
					   var cratedline =starttrline+sltd+item_code_td+item_name_td+item_rate_td+item_sold_qty_td+item_return_qty_td+item_unit_td+item_total_td+item_price_td+item_promotionvalue_td+item_promotionvalue_flag_td+item_vat_td+item_vat_amt_td+item_servicetax_td+item_servicetaxamt_td+item_spotdiscount_td+item_return_reason_td+item_orderid_td+endtrline;



					   $("#refundableitemsdetailsofordertbodyforapprove").append(cratedline);

				   }
				   
				   document.getElementById('paidordernoforapprove').innerHTML = order.orderId;
				   document.getElementById('salesreturnidforapprove').innerHTML = order.id; 
				   document.getElementById('storebasepaidordernoforapprove').innerHTML = order.orderNo;		

				   if(tblno == 0 ){

					   document.getElementById('paidordertblforapprove').innerHTML =ordertype;
					}
					else{
						document.getElementById('paidordertblforapprove').innerHTML =tblno;
					}
				   document.getElementById('paidorderdateforapprove').innerHTML = order.date;

				   document.getElementById('returnreasonforapprove').value=order.returnTypes.id;
				   document.getElementById('refundremarkforapprove').value=order.remark;
				   document.getElementById('paidordercustomernameforapprove').innerHTML =order.customerName;
				   document.getElementById('paidordercustomercontactnoforapprove').innerHTML = order.customerContact;
				   document.getElementById('paidordercustomeraddressforapprove').innerHTML = order.deliveryAddress;
				   document.getElementById('paidorderdeliveryboyforapprove').innerHTML =order.deliveryPersonName;
				   document.getElementById('paidorderwaiterforapprove').innerHTML =order.waiterName;

				   document.getElementById('paidordertotalitempriceforapprove').innerHTML =parseFloat(order.itemTotal).toFixed(2);

				   if(servicechargeflag=='Y'){
				   document.getElementById('paidorderschargepersforapprove').innerHTML =parseFloat(order.serviceChargeRate).toFixed(2);
				   document.getElementById('paidorderschargeamtforapprove').innerHTML =parseFloat(order.serviceCharge).toFixed(2);
	                  }
				   document.getElementById('paidorderdiscpersforapprove').innerHTML =parseFloat(order.disPer).toFixed(2);
				   document.getElementById('paidorderdiscamtforapprove').innerHTML =parseFloat(order.disAmt).toFixed(2);
				   if(vatTaxText!=0){
				   document.getElementById('paidordervatamtforapprove').innerHTML =parseFloat(order.vatAmt).toFixed(2);
	                 }
				   if(serviceTaxText!=0){
				   document.getElementById('paidorderstaxamtforapprove').innerHTML =parseFloat(order.serviceTaxAmt).toFixed(2);
	                 }
				   document.getElementById('paidordernetamtforapprove').innerHTML =parseFloat(order.netAmt).toFixed(2);
				   slno=0;
				   document.getElementById('approvesalesreturnalertMsg').innerHTML = '';
				   $('#orderrefundapprovemodal').modal('show');
	   }, null);

}

/**
 *  account effect
 * @returns
 */

function approverefund(){

	  var salesreturnid= document.getElementById('salesreturnidforapprove').innerHTML;
	 // alert("approverefund"+salesreturnid);
	  var orderno = document.getElementById('paidordernoforapprove').innerHTML;		  
	  var grossamount = document.getElementById('paidordertotalitempriceforapprove').innerHTML;
	  var discountamount = document.getElementById('paidorderdiscamtforapprove').innerHTML;
	  var servicecharge = 0.0;
	  var vattaxamount = 0.0;
	  var servicetaxamount = 0.0;
	  if(servicechargeflag=='Y'){
		  servicecharge = document.getElementById('paidorderschargeamtforapprove').innerHTML;
	  }
	  if(vatTaxText!=0){
		  vattaxamount= document.getElementById('paidordervatamtforapprove').innerHTML;
	  }
	   if(serviceTaxText!=0){
		   servicetaxamount = document.getElementById('paidorderstaxamtforapprove').innerHTML;
	   }

	  var totaltax = Number(vattaxamount)+Number(servicetaxamount);
	  var netamount = document.getElementById('paidordernetamtforapprove').innerHTML;


	    var salesreturn1={};
	    salesreturn1.id=salesreturnid;
	    salesreturn1.orderId=orderno;
		salesreturn1.netAmt=netamount;
		salesreturn1.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		salesreturn1.discAmt=discountamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		salesreturn1.taxVatAmt=totaltax.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		salesreturn1.serviceChargeAmt=servicecharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];

		if(is_Acc=="Y")
		{

		    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
			var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
			var round_ledger_id = parseInt($('#round_ledger_idf').val());
			var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
			var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
		    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
		    var card_ledger_id=parseInt($('#card_ledger_idf').val());

		  if(sale_ledger_id<=0 && duties_ledger_id<= 0 && round_ledger_id<=0 && discount_ledger_id<=0 && debitor_cash_ledger_id<=0 && service_charge_ledger_id<=0 && card_ledger_id<=0) {
		   document.getElementById('approvesalesreturnalertMsg').innerHTML = "ledger missing";
				return;
			 }else {
				  document.getElementById('approvesalesreturnalertMsg').innerHTML = "";

				  salesreturn1.duties_ledger_id=duties_ledger_id;
				  salesreturn1.round_ledger_id=round_ledger_id;
				  salesreturn1.sale_ledger_id=sale_ledger_id;
				  salesreturn1.discount_ledger_id=discount_ledger_id;
				  salesreturn1.debitor_cash_ledger_id=debitor_cash_ledger_id;
				  salesreturn1.service_charge_ledger_id=service_charge_ledger_id;
				  salesreturn1.card_ledger_id=card_ledger_id;

			}
		}

	 /* var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/refund/approveorder/" + salesreturnid + ".htm",
						function(response) {*/
							//alert(response);
		$.ajax({
			url : BASE_URL + "/refund/approveorder.htm?salesreturnid=" + salesreturnid,
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(salesreturn1),
			success : function(response) {

		         	try {
								console.log('Response>>>'+response);
								if (response == 'success') {

									location.reload();

								} else{
									document.getElementById('approvesalesreturnalertMsg').innerHTML = ''
										+ "Error Occurred" + '';
								}
							} catch (e) {
								alert(e);
							}
						//}, null);
			},
	        error : function(e) {
	      }
	  });



}


function confirmdeleterefund(){
	var salesreturnid= document.getElementById('salesreturnidforapprove').innerHTML;
	document.getElementById('moddeleteconfirmsalereturnid').value=salesreturnid;
	$("#confirmdeletesalesreturnModal").modal('show');
}




function deleterefund(){

	var salesreturnid= document.getElementById('moddeleteconfirmsalereturnid').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/refund/deleterefundbyid/' + salesreturnid+'.htm' , function(response) {
		if (response == 'success') {
			location.reload();
		}
		else{
			document.getElementById('msgspace').innerHTML="";
			document.getElementById('msgspace').innerHTML = "Problem Occured.Data Is Not Deleted.";
			$("#msgmodal").modal('show');
		}
	}, null);


}



function openRefundDetailsModal(orderid,ordertype,tblno){

	//alert("orderid"+orderid+"ordertype:"+ordertype+"tblno:"+tblno);

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/refund/getrefundorderdatabyidforapprove/" + orderid + ".htm", function(response) {
				console.log("response=" + response);
				var refundorders = JSON.parse(response);
		        var order=refundorders;
		        $("#refundableitemsdetailsofordertbodyfordetails").html("");
				for(var j=0;j<order.salesReturnItems.length;j++){
					   var itemdetail = order.salesReturnItems[j];
					   slno=slno+1;
					   var starttrline = "<tr id=" + itemdetail.id + ">";
					   var sltd = "<td  id='ordereditemfordetails_" + itemdetail.id + "'>"+ slno + "</td>";
					   var item_code_td="<td  id='ordereditemcodefordetails_" + itemdetail.id + "'>"+ itemdetail.menuItem.id + "</td>";
					   var item_name_td="<td  id='ordereditemnamefordetails_" + itemdetail.id + "'>"+ itemdetail.menuItem.name + "</td>";
					   var item_rate_td="<td  id='ordereditemratefordetails_" + itemdetail.id + "'>"+ itemdetail.itemRate + "</td>";
					   var item_sold_qty_td="<td  id='ordereditemsoldqtyfordetails_" + itemdetail.id + "'>"+ itemdetail.itemSoldQuantity + "</td>";
					   var item_return_qty_td = "<td  id='ordereditemreturnqtyfordetails_" + itemdetail.id + "'><input type='text' style='display:none;'  id='inpordereditemreturnqtyfordetails_" + itemdetail.id + "' value='" + itemdetail.itemReturnQuantity + "' size='5' style='color: black;'/>"+ itemdetail.itemReturnQuantity  + "</td>";

					   var item_unit_td="<td  id='ordereditemunitfordetails_" + itemdetail.id + "' style='display:none;'>"+ itemdetail.unitName + "</td>";

					   var item_total_td="<td  id='ordereditemtotalfordetails_" + itemdetail.id + "'>"+  parseFloat(itemdetail.itemPrice).toFixed(2) + "</td>";
					   var item_price_td="<td  id='ordereditempricefordetails_" + itemdetail.id + "' style='display:none;'>"+  parseFloat(itemdetail.itemReturnPrice).toFixed(2) + "</td>";
					   var item_promotionvalue_td="<td  id='ordereditempromotionvaluefordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.promotionValue + "</td>";
					   var item_promotionvalue_flag_td="<td  id='ordereditempromotionvalueflagfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.promotionFlag + "</td>";

					   var item_vat_td="<td  id='ordereditemvatfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.vat + "</td>";
					   var item_vat_amt_td="<td  id='ordereditemvatamtfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.vatAmt + "</td>";

					   var item_servicetax_td="<td  id='ordereditemservicetaxfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.serviceTax + "</td>";
					   var item_servicetaxamt_td="<td  id='ordereditemservicetaxamtfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.serviceTaxAmt + "</td>";

					   var item_spotdiscount_td="<td  id='ordereditemspotdiscountfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.menuItem.spotDiscount + "</td>";
					   var item_orderid_td="<td  id='ordereditemorderfordetails_" + itemdetail.id + "'style='display:none;'>"+ itemdetail.orderId + "</td>";

					   var item_return_reason_td="";
					   //if(printReason == 'Y'){
					       item_return_reason_td = "<td  id='ordereditemreturnreasonfordetails_" + itemdetail.id + "' style='display:none;'><input type='text'   id='inpordereditemreturnreasonfordetails_" + itemdetail.id + "' value='"+itemdetail.returnTypes.id+"' size='10' style='color: black;'/>"  + "</td>";
					  // }
					   var endtrline = "</tr>";
					   var cratedline =starttrline+sltd+item_code_td+item_name_td+item_rate_td+item_sold_qty_td+item_return_qty_td+item_unit_td+item_total_td+item_price_td+item_promotionvalue_td+item_promotionvalue_flag_td+item_vat_td+item_vat_amt_td+item_servicetax_td+item_servicetaxamt_td+item_spotdiscount_td+item_return_reason_td+item_orderid_td+endtrline;



					   $("#refundableitemsdetailsofordertbodyfordetails").append(cratedline);

				   }
				   
				   document.getElementById('paidordernofordetails').innerHTML = order.orderId;	
				   document.getElementById('storebasepaidordernofordetails').innerHTML = order.orderNo;	
				   document.getElementById('salesreturnidfordetails').innerHTML = order.id; 
				   
				   if(tblno == 0 ){
					   document.getElementById('paidordertblfordetails').innerHTML =ordertype;
					}
					else{
						document.getElementById('paidordertblfordetails').innerHTML =tblno;
					}
				   document.getElementById('paidorderdatefordetails').innerHTML = order.date;

				   document.getElementById('returnreasonfordetails').value=order.returnTypes.id;
				   document.getElementById('refundremarkfordetails').value=order.remark;
				   document.getElementById('paidordercustomernamefordetails').innerHTML =order.customerName;
				   document.getElementById('paidordercustomercontactnofordetails').innerHTML = order.customerContact;
				   document.getElementById('paidordercustomeraddressfordetails').innerHTML = order.deliveryAddress;
				   document.getElementById('paidorderdeliveryboyfordetails').innerHTML =order.deliveryPersonName;
				   document.getElementById('paidorderwaiterfordetails').innerHTML =order.waiterName;

				   document.getElementById('paidordertotalitempricefordetails').innerHTML =parseFloat(order.itemTotal).toFixed(2);
				   if(servicechargeflag=='Y'){
				   document.getElementById('paidorderschargepersfordetails').innerHTML =parseFloat(order.serviceChargeRate).toFixed(2);
				   document.getElementById('paidorderschargeamtfordetails').innerHTML =parseFloat(order.serviceCharge).toFixed(2);
				   }
				   document.getElementById('paidorderdiscpersfordetails').innerHTML =parseFloat(order.disPer).toFixed(2);
				   document.getElementById('orderDiscPersForRefund').value =parseFloat(order.disPer).toFixed(2); //new
				   document.getElementById('paidorderdiscamtfordetails').innerHTML =parseFloat(order.disAmt).toFixed(2);
				   if(vatTaxText!=0){
				   document.getElementById('paidordervatamtfordetails').innerHTML =parseFloat(order.vatAmt).toFixed(2);
				   }
				   if(serviceTaxText!=0){
				   document.getElementById('paidorderstaxamtfordetails').innerHTML =parseFloat(order.serviceTaxAmt).toFixed(2);
	                 }
				   document.getElementById('paidordernetamtfordetails').innerHTML =parseFloat(order.netAmt).toFixed(2);
				   slno=0;
				   $('#orderrefunddetailsmodal').modal('show');
		}, null);



}



function getvendorledger_sale(group_code,acc_id,ref_id,para)
{
	 //var keyword=ref_id.toString();
	//  var trackname=keyword.split("_");
	/*
	 * 	commonobj.id=1; is call another procedure
	 */


	var commonobj={};
	if (para==0) { // for duties and tax

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;


	}


	if (para==1) { // for round off

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

	if (para==2) { // for sale

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

if (para==3) { // for debitor

		if (ref_id==0) { // when customer is not present
			commonobj.groupCode=$('#cash_codef').val();
			commonobj.accountID=0;
			commonobj.referenceID=0;
			commonobj.id=1;
			cash_sale=1;

		}else {
			cash_sale=0;// when customer present
			commonobj.groupCode=group_code;
			commonobj.accountID=0;
			commonobj.referenceID=ref_id;
			commonobj.id=1;
		}


	}

if (para==4) { // for discount

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}
if (para==5) { // for cash

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

if (para==6) { // for card

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

if (para==7) { // for service charge

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

//$('#pleasewaitModal').modal('show');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/searchledgerusinggroup.htm", commonobj, function(response) {
		$('#pleasewaitModal').modal('hide');

		var status = JSON.parse(response);

		if (para==0) {// for duties and tax
			console.log("duties and tax ");

			$.each(status, function(i) {

				// $('#duties_html1').html("Cr-"+status[i].name);
				 $('#duties_ledger_idf').val(status[i].id);

			});
		}

		if (para==1) {// for round off
			console.log("for round off ");
			$.each(status, function(i) {

				 //$('#round_html1').html(status[i].name);
				 $('#round_ledger_idf').val(status[i].id);

			});
		}
	if (para==2) { // for sale

		console.log("for sale ");
				$.each(status, function(i) {

					// $('#sales_html1').html("Cr-"+status[i].name);
					 $('#sales_ledger_idf').val(status[i].id);

				});
			}

	if (para==3) {// for debitor

		console.log(" for debitor ");

				$.each(status, function(i) {

					// $('#debitor_html1').html("Dr-"+status[i].name );
					 $('#debitor_ledger_idf').val(status[i].id);

				});
		 }

	if (para==4) {// for discount
		console.log("for discount ");
		$.each(status, function(i) {

			// $('#discount_html1').html("Dr-"+status[i].name );
			 $('#discount_ledger_idf').val(status[i].id);

		});
		 }
	if (para==5) {// for cash
		console.log("for cash ");
		$.each(status, function(i) {
			// $('#cash_ledger_html1').html("Dr-"+status[i].name );
			 $('#debitor_cahs_ledger_idf').val(status[i].id);

		});
		 }
	if (para==6) {// for card
		console.log(" for card ");
		$.each(status, function(i) {



		//	 $('#card_html1').html("Dr-"+status[i].name );
			 $('#card_ledger_idf').val(status[i].id);

		});
		 }


	if (para==7) {// for  service charge
		console.log(" for  service charge ");
		$.each(status, function(i) {

			//	 $('#card_html1').html("Dr-"+status[i].name );
			 $('#service_charge_ledger_idf').val(status[i].id);

		});
		 }

		//chngeResultStat(status);
	});

}

////////////////////////////////////////////////////////////////////////////////////////////////////


function printRefundBill(orderid) 
{
	/*var order = {};
	order.id = orderid;
	order.storeId = storeID;*/
	if (mobPrintVal == "Y") {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/refund/getrefundorderdatabyidforapprove/" + orderid + ".htm", function(response) {
				console.log(response);
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				var returnId = jsonObj.id;
				var orderNo = jsonObj.orderId; 
				var storeBaseOrderNumber = jsonObj.orderNo;
				var tabNo = '';
				var customerName = jsonObj.customerName;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.deliveryAddress;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customerContact;
				var customerEmail = '';
				var state='';
				var orderDateWithTime = jsonObj.date;
				var orderTime = '';
				
				var cuslocation = '';
                var cusstreet = '';
                var cushouseno = '';
                var delivaryboy = jsonObj.deliveryPersonName;
				var ordercustomerphone= jsonObj.customerContact;

				/* ***** Bill Amount Details ***** */
				var storeId = jsonObj.storeid;
				var billAmt = jsonObj.netAmt;
				var serviceTaxAmt = jsonObj.serviceTaxAmt;
				var vatAmt = jsonObj.vatAmt;
				var grossAmt = jsonObj.netAmt;
				var totalDiscount = jsonObj.disAmt;
				var customerDiscount = jsonObj.disAmt;
				/*var roundOffAmt = jsonObj.orderBill.roundOffAmt;*/
				var discPercentage = jsonObj.disPer;
				var serviceChargeAmt = jsonObj.serviceCharge;
				var subToatlAmt = jsonObj.itemTotal;
				var orderTypeOfOrder = '';
				var returnType = jsonObj.returnTypes.remark;
				var returndate = jsonObj.createdDate;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; 
				if (printbillpapersize == '58.00') {

					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeName58').text(customerName);
					$('#storeAddr58').text(storeAddr);
					$('#storeEmail58').text(customerEmail);
					$('#storePhNo58').text(customerPhNo);
					$('#orderValue58').text(storeBaseOrderNumber);
					$('#tableNoValue58').text(orderTypeOfOrder);

					for ( var k = 0; k < jsonObj.salesReturnItems.length; k++) {
						var item1 = jsonObj.salesReturnItems[k];

						var itemName = item1.menuItem.name;
						var itemQty = item1.itemReturnQuantity;
						var itemRate = item1.itemRate;
						var itemTotalPrice = item1.itemReturnPrice;

						var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrint58").append(createdrowline);

					}

					$('#totalAmt58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#totalServiceChrg_58").show();
						$('#servChrg58').text(serviceChargeAmt);
					} else {
						$("#totalServiceChrg_58").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#totalServiceTax_58").show();
						$('#servTax58').text(serviceTaxAmt);
					} else {
						$("#totalServiceTax_58").hide();
					}

					if (vatAmt > 0) {
						$("#totalVatTax_58").show();
						$("#vatTax58").text(vatAmt);
					} else {
						$("#totalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#showDiscount_58").show();
						$("#discountValue58").text(customerDiscount);
					} else {
						$("#showDiscount_58").hide();
					}

					$("#grossAmount58").text(billAmt);
					$("#amoutToPay58").text(grossAmt);

				

				} else if(printbillpapersize == '80.00') {
					/* ****** Print in 80 paper size ***** */
					$("#itemDetailsPrint80").text("");
					/* ********** START STORE INFO PRINT ********** */
					$('#storeName80').text(customerName);
					$('#storeAddr80').text(storeAddr);
					//$('#storeEmail80').text(customerEmail);
					//$('#storePhNo80').text(customerPhNo);
					//$('#cashOrdervalue80').text(orderNo);
					$('#cashOrdervalue80').text(storeBaseOrderNumber);
					//$('#cashtableNoValue80').text(tabNo);
					$('#cashtableNoValue80').text(orderTypeOfOrder);
					$("#cashOrderdate80").text(returndate);
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.salesReturnItems.length; k++) {
						var item1 = jsonObj.salesReturnItems[k];

						var itemName = item1.menuItem.name;
						var itemQty = item1.itemReturnQuantity;
						var itemRate = item1.itemRate;
						var itemTotalPrice = item1.itemReturnPrice;
						var itemhsn='';
						if(itemhsn==undefined){itemhsn="";}
						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline="";
						if(storeID == 164){
						 firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName +"("+itemhsn+")" + "</td>";
						}
						else{
							firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
								
						}
						
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;
						
						$("#itemDetailsPrint80").append(createdrowline);

					}

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					//alert(" << subToatlAmt >> "+subToatlAmt+ " << serviceChargeAmt >>"+serviceChargeAmt+"<< serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt >>"+vatAmt+"<< customerDiscount >>"+customerDiscount+"<< billAmt >> "+billAmt+"<< grossAmt >> "+grossAmt);						
					$('#cashtotalamt80').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge80px").show();
						$('#cashservChrg80').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge80px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax80px").show();
						$('#cashservTax80').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax80px").show();
						$("#cashvatTax80px").text(vatAmt);
					} else {
						$("#cashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount80px").show();
						$("#cashdiscountValue80").text(customerDiscount);
						$("#paidbilldiscpers").text(parseFloat(discPercentage).toFixed(2));
					} else {
						$("#cashshowDiscount80px").hide();
					}

					$("#cashgrossAmount80").text(billAmt);
					$("#cashamoutToPay80").text(grossAmt);
					$("#orderrefundAmount80").text(parseFloat(billAmt).toFixed(2));

					/* ********** END AMOUNT INFO PRINT ********** 	*/
					  if(parcelAdd == 'Y'){
	            	      //alert("jj");
	            	     // alert(tabNo+""+parcelAdd);
							if(orderCustomerName != '' && orderCustomerName != null && orderCustomerName.length >0){
								//alert(orderCustomerName);
								document.getElementById('cusname80').innerHTML =orderCustomerName;				
								document.getElementById("cusnametr80").style.display = "block";
								
							}
							if(orderCustomerAddr != '' && orderCustomerAddr != null && orderCustomerAddr.length >0){
								document.getElementById('cusaddress80').innerHTML =orderCustomerAddr;											
								 document.getElementById("cusaddresstr80").style.display = "block";
							}
							
							if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
								document.getElementById('cusphno80').innerHTML =ordercustomerphone;
								document.getElementById("cusphnotr80").style.display = "block";
								
							}
							
							if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
								document.getElementById('cuslocation80').innerHTML =cuslocation;
								document.getElementById("cuslocationtr80").style.display = "block";
								
							}
							
							if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
								document.getElementById('cusstreet80').innerHTML =cusstreet;
								document.getElementById("cusstreettr80").style.display = "block";
								 
							}
							

							if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
								document.getElementById('cushouseno80').innerHTML =cushouseno;
								document.getElementById("cushousenotr80").style.display = "block";
								 
							}
							
							
							if(delivaryboy != '' && delivaryboy != null && delivaryboy.length >0){
								document.getElementById('deliveryboy80').innerHTML =delivaryboy;	
								document.getElementById("deliveryboytr80").style.display = "block";
								
							}
							
						} 					
			    printCashOrCardLocal80();
				

				}else if(printbillpapersize == '2100.00'){
					if(storeID == "120"){
						storeBaseOrderNumber = storeBaseOrderNumber + "/2019-20";
					}
					
					var tottaxamt=0.0;
					$('#storeName2100').text(customerName);
					$('#storeAddr2100').text(storeAddr);
					$('#storeEmail2100').text("Email :"+customerEmail);
					$('#storePhNo2100').text("Ph :"+customerPhNo);
					//$('#cashOrdervalue2100').text(orderNo);
					$('#cashOrdervalue2100').text(storeBaseOrderNumber);
					//$('#cashtableNoValue2100').text(tabNo);
					$('#cashtableNoValue2100').text(orderTypeOfOrder);

					/* ********** For GST *********** */
					
					$('#storeName2100_GST').text(customerName);
					$('#storeAddr2100_GST').text(storeAddr);
					$('#storeEmail2100_GST').text(customerEmail);
					$('#storePhNo2100_GST').text(customerPhNo);
					//$('#cashOrdervalue2100_GST').text(orderNo);
					$('#cashOrdervalue2100_GST').text(storeBaseOrderNumber);
					$('#cashOrderDate_GST').text(orderDateWithTime);
					
					$('#cashCustName_GST').text(orderCustomerName);
					$('#cashCustAddr_GST').text(orderCustomerAddr);
					$('#cashCustState_GST').text(state);
					$('#cashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					$('#cashCustPhone2100_GST').text(ordercustomerphone);
					
					$('#customerDiscpercentage').text(parseFloat(discPercentage).toFixed(2)); // for display discount percentage
					
					$("#cashOrderDate_GST").text(returndate);
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					for ( var k = 0; k < jsonObj.salesReturnItems.length; k++) {
						var item1 = jsonObj.salesReturnItems[k];
						var itemName = item1.menuItem.name;
						var itemQty = item1.itemReturnQuantity;
						var itemRate = item1.itemReturnRate;
						var itemTotalPrice = item1.itemReturnPrice;
						var itemUnit = item1.unitName;
						/*var itemDisc = item1.promotionDiscountAmt;*/
						var itemDisc = item1.disAmt;
						var itemTotalAmt = item1.itemPrice;
						var itemTaxableAmt = 0.0;
						var cgstPrcnt = item1.vat;
						var cgstAmt = 0.0;
						var sgstPrcnt = item1.serviceTax;
						var sgstAmt = 0.0;
						var igstPrcnt = Number(item1.vat) + Number(item1.serviceTax);  // for 120
						var igstAmt = 0.0; // for 120
						var itemHsn = '';						
						if(itemHsn == undefined){itemHsn="";}						
						
						var createdrowline = "";
						var startTrline1 = "<tr>";
						var firstTdline = "<td width='30%;'>" + itemName + "</td>";
						var secondTdline = "<td width='6%;'>" + itemQty + "</td>";
						var thirdTdline = "<td width='5%;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td width='5%;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
						var unit_clm = "<td width='6%;'>" + itemUnit + "</td>";
						var disc_clm = "<td width='5%;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
						var taxable_clm = "<td width='10%;'>" + parseFloat(Number(item1.itemPrice) - Number(item1.disAmt)).toFixed(2) + "</td>";
						totTaxable = Number(totTaxable)+ parseFloat((Number(itemRate) * Number(itemQty)) - Number(itemDisc)).toFixed(2)
						
						if(storeID == '120'){
						    if(state=='WB' || state=='wb' || state=='West Bengal' || state=='west bengal' || state=='westbengal' || state=='WestBengal' || state=='WEST BENGAL' || state=='WESTBENGAL' ){
						    	var cgstPrcnt_clm = "<td width='5%;'>" + parseFloat(cgstPrcnt).toFixed(2) + "</td>";
								var cgstAmt_clm = "<td width='10%;'>" + parseFloat(cgstAmt).toFixed(2) + "</td>";
								var sgstPrcnt_clm = "<td width='5%;'>" + parseFloat(sgstPrcnt).toFixed(2) + "</td>";
								var sgstAmt_clm = "<td width='10%;'>" + parseFloat(sgstAmt).toFixed(2) + "</td>";
								var igstPrcnt_clm = "<td width='5%;'></td>";
								var igstAmt_clm = "<td width='10%;'></td>";
								
						    }
						    else{
						    	igstAmt=Number(cgstAmt)+Number(sgstAmt);
						    	var cgstPrcnt_clm = "<td width='5%;'>" + 0.00 + "</td>";
								var cgstAmt_clm = "<td width='10%;'>" + 0.00 + "</td>";
								var sgstPrcnt_clm = "<td width='5%;'>" + 0.00 + "</td>";
								var sgstAmt_clm = "<td width='10%;'>" + 0.00 + "</td>";
								var igstPrcnt_clm = "<td width='5%;'>"+parseFloat(igstPrcnt).toFixed(2)+"</td>";
								var igstAmt_clm = "<td width='10%;'>"+parseFloat(igstAmt).toFixed(2)+"</td>";
								
						    	
						    	
							
						     }
						 }
						 else{
							    var cgstPrcnt_clm = "<td width='5%;'>" + parseFloat(cgstPrcnt).toFixed(2) + "</td>";
								var cgstAmt_clm = "<td width='10%;'>" + parseFloat(cgstAmt).toFixed(2) + "</td>";
								var sgstPrcnt_clm = "<td width='5%;'>" + parseFloat(sgstPrcnt).toFixed(2) + "</td>";
								var sgstAmt_clm = "<td width='10%;'>" + parseFloat(sgstAmt).toFixed(2) + "</td>";
								var igstPrcnt_clm = "<td width='5%;'></td>";
								var igstAmt_clm = "<td width='10%;'></td>";
								
							
						 }
						
						
						
						
						
						var sl_no = "<td width='5%;'>"+(k+1)+"</td>";
						var hsn_clm = "<td></td>";
						
						if((orderTypeOfOrder == 'catering' || orderTypeOfOrder == 'Catering' || orderTypeOfOrder == 'CATERING')){
						    var sac_clm = "<td>"+itemHsn+"</td>";
						    }
						else{
							var sac_clm = "<td></td>";
						    }
						var endTrline1 = "</tr>";

						createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;

						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr style='border-top: 1px dashed;'>";
					var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";
					var total_txt = "<td><b>Total:</b></td>";
					var total_amt_clm = "<td>"+parseFloat(subToatlAmt).toFixed(2)+"</td>";
					
					//var total_disc_clm = "<td>" + parseFloat(totalDiscount).toFixed(2) + "</td>";
					var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					//var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";
					var total_taxable_clm = "<td>" + parseFloat(afterdiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					
					if(storeID == '120'){ 
					    if(state=='WB' || state=='wb' || state=='West Bengal' || state=='west bengal' || state=='westbengal' || state=='WestBengal' || state=='WEST BENGAL' || state=='WESTBENGAL'){
					    	var blank_clm2 = "<td></td>";
							var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
							var blank_clm3 = "<td></td>";
							var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
							var blank_clm4 = "<td></td>";
							var total_igstAmt_clm = "<td></td>";
						  }
					    else{
					        tottaxamt = Number(vatAmt) + Number(serviceTaxAmt);
					    	var blank_clm2 = "<td></td>";
							var total_cgstAmt_clm = "<td>0.00</td>";
							var blank_clm3 = "<td></td>";
							var total_sgstAmt_clm = "<td>0.00</td>";
							var blank_clm4 = "<td></td>";
							var total_igstAmt_clm = "<td>"+parseFloat(tottaxamt).toFixed(2)+"</td>";
						  }
					    }
					else{
						var blank_clm2 = "<td></td>";
						var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
						var blank_clm3 = "<td></td>";
						var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
						var blank_clm4 = "<td></td>";
						var total_igstAmt_clm = "<td></td>";
					   }
					
					
					var endTrline2 = "</tr>";

					createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm + total_taxable_clm + blank_clm2 + total_cgstAmt_clm + blank_clm3 + total_sgstAmt_clm + blank_clm4 + total_igstAmt_clm + endTrline2;

					$("#itemDetailsPrint2100_GST").append(createdrowline2);

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					
					$('#cashtotalamt2100').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge2100px").show();
						$('#cashservChrg2100').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge2100px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax2100px").show();
						$('#cashservTax2100').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax2100px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax2100px").show();
						$("#cashvatTax2100px").text(vatAmt);
					} else {
						$("#cashtotalVatTax2100px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount2100px").show();
						$("#cashdiscountValue2100").text(customerDiscount);
					} else {
						$("#cashshowDiscount2100px").hide();
					}

					$("#cashgrossAmount2100").text(billAmt);
					$("#cashamoutToPay2100").text(grossAmt);

					$("#cashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					
					
					
					$("#cashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$('#cashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					$('#cashIGST2100_gst').text(parseFloat(tottaxamt).toFixed(2)); //new
					
					
					if(storeID == '120'){ 
					    if(state=='WB' || state=='wb' || state=='West Bengal' || state=='west bengal'|| state=='westbengal' || state=='WestBengal' || state=='WEST BENGAL' || state=='WESTBENGAL'){
					    	$("#cashvatTax2100px_gst").show();
					    	$("#cashservTax2100_gst").show();
					    	$("#cashIGST2100_gst").hide();
					    
					    }
					    else{
					    	$("#cashvatTax2100px_gst").hide();
					    	$("#cashservTax2100_gst").hide();
					    	$("#cashIGST2100_gst").show();
					    	
					       }
					   }else{
						  
						    $("#cashvatTax2100px_gst").show();
					    	$("#cashservTax2100_gst").show();
					    	$("#cashIGST2100_gst").hide();
					    }
					
					
					
					var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
					
					$("#cashgrossAmount2100_word_gst").text(cash_gross_word);
		
					$("#paidAmount_paidbill_2100px").text(parseFloat(grossAmt).toFixed(2)); // new added 10.5.2018
					$("#amoutToPay_paidbill_2100px").text('00.00'); // new added 10.5.2018
					$("#refundorderamount2100px").text(parseFloat(grossAmt).toFixed(2));
					
					
					/*var paymentsObj = jsonObj.payments.length;*/
					
					var paymentmode = "";
					var coma = ',';
					/*if (paymentsObj == 1) {
						paymentmode=jsonObj.payments[0].paymentMode;
					}else{
						for(var i=0;i<paymentsObj;i++){
							if(paymentmode == ""){
								paymentmode=jsonObj.payments[i].paymentMode;
							}else{
								paymentmode = paymentmode + coma + jsonObj.payments[i].paymentMode;
							}
						}
					}*/
					$("#paymentmode_paidbill_2100px").text(paymentmode);
					printCashOrCardLocal2100();
				}

		 /* }*/
		}, null);


	} else {
	        var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/refund/printrefundbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();
					
				}catch(e)
				{alert(e);}
				}, null);
			
		
	}
}

function showPaidBillPrintSuccessModal() {
	$('#paidbillPrintSuccessModal').modal('show');
}
function showDirectPaymentforPacel(){}
function printCashOrCardLocal58() {

	var divToPrint = document.getElementById('printDiv58');
	document.getElementById('removePrint58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint58').style.display = 'block';

	newWin.close();
	// location.href = BASE_URL + '/table/viewtable.htm';
}
function printCashOrCardLocal80() {
	   //alert("printCashOrCardLocal80");
		//console.log("print bill");
		var divToPrint = document.getElementById('printDiv80');
		document.getElementById('cashRemovePrint80').style.display = 'none';
		newWin = window.open("");
		//alert('hello1');
		newWin.document.write(divToPrint.outerHTML);
		newWin.document.close();
		newWin.focus();
		newWin.print();
		
		document.getElementById('cashRemovePrint80').style.display = 'block';
	    
		newWin.close();
		//console.log("print bill end");
		// location.href = BASE_URL + '/table/viewtable.htm';
	}

function printCashOrCardLocal2100() {
	 // $('#printDiv2100GST').modal('show');
	 //var divToPrint = document.getElementById('printDiv2100');
	 var divToPrint = document.getElementById('printDiv2100GST');
	 //document.getElementById('cashRemovePrint2100').style.display = 'none';
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 //newWin.document.close();
	 newWin.focus();
	 newWin.print();
	 //document.getElementById('cashRemovePrint2100').style.display = 'block';
	 
	 newWin.close();
	// location.href = BASE_URL + '/table/viewtable.htm';
	 //location.href = '#';
	}

/* ============== Convert number to Word in currency ========================*/

function number2text(value) {
	var fraction = Math.round(frac(value) * 100);
	var f_text = "";

	if (fraction > 0) {
		f_text = "AND " + convert_number(fraction) + " PAISE";
	}

	return convert_number(value) + " RUPEE " + f_text + " ONLY";
}

function frac(f) {
	return f % 1;
}

function convert_number(number) {
	if ((number < 0) || (number > 999999999)) {
		return "NUMBER OUT OF RANGE!";
	}
	var Gn = Math.floor(number / 10000000); /* Crore */
	number -= Gn * 10000000;
	var kn = Math.floor(number / 100000); /* lakhs */
	number -= kn * 100000;
	var Hn = Math.floor(number / 1000); /* thousand */
	number -= Hn * 1000;
	var Dn = Math.floor(number / 100); /* Tens (deca) */
	number = number % 100; /* Ones */
	var tn = Math.floor(number / 10);
	var one = Math.floor(number % 10);
	var res = "";

	if (Gn > 0) {
		res += (convert_number(Gn) + " CRORE");
	}
	if (kn > 0) {
		res += (((res == "") ? "" : " ") + convert_number(kn) + " LAKH");
	}
	if (Hn > 0) {
		res += (((res == "") ? "" : " ") + convert_number(Hn) + " THOUSAND");
	}

	if (Dn) {
		res += (((res == "") ? "" : " ") + convert_number(Dn) + " HUNDRED");
	}

	var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN",
			"EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN",
			"FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN");
	var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY",
			"SEVENTY", "EIGHTY", "NINETY");

	if (tn > 0 || one > 0) {
		if (!(res == "")) {
			res += " AND ";
		}
		if (tn < 2) {
			res += ones[tn * 10 + one];
		} else {

			res += tens[tn];
			if (one > 0) {
				res += (ones[one]);
			}
		}
	}

	if (res == "") {
		res = "zero";
	}
	return res;
}



function calculateBill(itemId){
	
	var discountPers = $("#paidorderdiscpers").html()
	var totVatTaxAmt = 0.0;
	var totSTaxAmt = 0.0;
	var totDiscAmt = 0.0;
	var totSubTot = 0.0;
	var totAmt = 0.0;
	if(discountPers==""){discountPers=0.0;}
	$('#refundableitemsdetailsofordertbody tr').each(function() {
		var itemid = this.id;
		var rate = $('#ordereditemrate_'+itemid).html();
		var soldQty = $('#ordereditemsoldqty_'+itemid).html();
		var returnQty=$('#inpordereditemreturnqty_'+itemid).val();
		var vattax = $('#ordereditemvat_'+itemid).html();
		var stax = $('#ordereditemservicetax_'+itemid).html();
		var promotionFlag = $('#ordereditempromotionflag_'+itemid).html();
		var promotionValue =$('#ordereditempromotionvalue_'+itemid).html();	
		var discountFlag = $('#ordereditemspotdiscount_'+itemid).html();	
		  
		if(Number(returnQty) > Number(soldQty)){
			$('#inpordereditemreturnqty_'+itemid).val(soldQty);
			returnQty = soldQty;
		}else if(returnQty == ""){
			$('#inpordereditemreturnqty_'+itemid).val(soldQty);
			returnQty = soldQty;
		}
		
		
		var newSubTot = Number(returnQty) * Number(rate);
		var newDiscAmt = 0.0;
		if(discountFlag == 'Y'){
			newDiscAmt = (Number(newSubTot) * Number(discountPers)) / 100; 
		}
		var newTaxableAmt = Number(newSubTot) - Number(newDiscAmt);
		var newVatAmt = (Number(newTaxableAmt) * Number(vattax))/100;
		var newSTaxAmt = (Number(newTaxableAmt) * Number(stax))/100;
		var newTotAmt = Number(newTaxableAmt) + Number(newVatAmt) + Number(newSTaxAmt);
		totVatTaxAmt+=Number(newVatAmt);
		totSTaxAmt+=Number(newSTaxAmt);
		totDiscAmt+=Number(newDiscAmt);
		totSubTot+=Number(newSubTot);
		totAmt+=Number(newTotAmt);
		
		$('#ordereditemtotal_'+itemid).html(parseFloat(newSubTot).toFixed(2));
		$('#ordereditemvatamt_'+itemid).html(parseFloat(newVatAmt).toFixed(2));
		$('#ordereditemservicetaxamt_'+itemid).html(parseFloat(newSTaxAmt).toFixed(2));
		$('#ordereditemdiscountamt_'+itemid).html(parseFloat(newDiscAmt).toFixed(2));
		$('#ordereditemprice_'+itemid).html(parseFloat(newTotAmt).toFixed(2));
	
		
	});
	
	$('#paidordertotalitemprice').html(parseFloat(totSubTot).toFixed(2));
	$('#paidorderdiscamt').html(parseFloat(totDiscAmt).toFixed(2));
	if(vatTaxText!=0){
	 $('#paidordervatamt').html(parseFloat(totVatTaxAmt).toFixed(2));
	}
	if(serviceTaxText!=0){
	 $('#paidorderstaxamt').html(parseFloat(totSTaxAmt).toFixed(2));
	}
	$('#paidordernetamt').html(parseFloat(totAmt).toFixed(2));
}


function setChange(d,id){
	if (!d.checked) {
		 $('#inpordereditemreturnqty_'+id).attr("disabled",true);
  }else{
	  $('#inpordereditemreturnqty_'+id).attr("disabled",false); 
  }
}





/* ===================== End */










