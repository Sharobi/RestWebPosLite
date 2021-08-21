/**
 * 
 */



function printRefundBill(orderid) 
{
	var caseValue =  $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	var order = {};
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();

	if (caseValue == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				console.log(response);
				var orderNo = jsonObj.id;
				var storeBasedOrderNo = jsonObj.orderNo;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.customers.address;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var state=jsonObj.state;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;
                var cuslocation = jsonObj.location;
                var cusstreet = jsonObj.street;
                var cushouseno = jsonObj.houseNo;
                var delivaryboy = jsonObj.deliveryPersonName;
				var ordercustomerphone= jsonObj.customerContact;
				
				/* ***** Bill Amount Details ***** */
				var storeId = jsonObj.orderBill.storeid;
				var billAmt = jsonObj.orderBill.billAmount;
				var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
				var vatAmt = jsonObj.orderBill.vatAmt;
				var grossAmt = jsonObj.orderBill.grossAmt;
				var totalDiscount = jsonObj.orderBill.totalDiscount;
				var customerDiscount = jsonObj.orderBill.customerDiscount;
				var roundOffAmt = jsonObj.orderBill.roundOffAmt;
				var discPercentage = jsonObj.orderBill.discountPercentage;
				var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
				var subToatlAmt = jsonObj.orderBill.subTotalAmt;
				//var serviceChargeDisc = jsonObj.ordertype.serviceChargeValue;
				var serviceChargeDisc = jsonObj.orderBill.serviceChargeRate;
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				
				var orderDate=jsonObj.orderTime;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
                
				//console.log(jsonObj);
				
				if (printbillpapersize == '58.00') {
					$("#refunditemDetailsPrint58").text("");
					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					/*$('#refundstoreName58').text(customerName);
					$('#refundstoreAddr58').text(storeAddr);
					$('#refundstoreEmail58').text(customerEmail);
					$('#refundstorePhNo58').text(customerPhNo);*/
					//$('#refundorderValue58').text(orderNo);
					$('#refundorderValue58').text(storeBasedOrderNo);
					
					//$('#refundtableNoValue58').text(tabNo);
					$('#refundcashOrderdate58').text(orderDate);
					if(tabNo!='0'){
						$('#refundtableNoValue58').text('Table No:'+tabNo);
					}
					else{
						$('#refundtableNoValue58').text(orderTypeOfOrder);
					}
					
					
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";
						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;
						$("#refunditemDetailsPrint58").append(createdrowline);  // it was commented by previous developer

					}

					$('#refundtotalAmt58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {						
						$("#refundtotalServiceChrg_58").show();
						$('#refundservChrg58').text(serviceChargeAmt);
					} else {
						$("#refundtotalServiceChrg_58").hide();
					}

					if (serviceTaxAmt >0) {						
						$("#refundtotalServiceTax_58").show();
						$('#refundservTax58').text(serviceTaxAmt);
					} else {
						$("#refundtotalServiceTax_58").hide();
					}

					if (vatAmt > 0) {						
						$("#refundtotalVatTax_58").show();
						$("#refundvatTax58").text(vatAmt);
					} else {
						$("#refundtotalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#refundshowDiscount_58").show();
						$("#refunddiscountValue58").text(customerDiscount);
					} else {
						$("#refundshowDiscount_58").hide();
					}

					$("#refundgrossAmount58").text(billAmt);
					$("#refundamoutToPay58").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#refundpaidAmount58').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount58').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefund_amount_58px').text(returnAmt);
						$('#refundpayType_58').text(type);

					}
					
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#refundpaidAmount58').text(paidAmt);

						$('#refundtenderAmount58').text(tenderAmt);
						$('#refundrefund_amount_58px').text(Math.floor(returnAmt * 100) / 100);
						$('#refundpayType_58').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#refundpaidAmount58').text(paidAmt);
						$('#refundtenderAmount58').text(tenderAmt);
						$('#refundrefundAmount58').text("0.00");
						$('#refundpayType58').text(type1 + type2);
					}
					$('#refundorderrefundAmount58').text(paidAmt);
					//	$('#refundhelloPrintModal58').modal('show');	
					
					 if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
						var amt1 = jsonObj.orderBill.billAmount;
						var paidAmt1 = jsonObj.orderBill.billAmount;
						if (amt1 == paidAmt1) {												
							refundprintCashOrCardLocal58();					
						}
					}
					

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							refundprintCashOrCardLocal58();
						}
					}

					if (paymentsObj == 2) {
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							refundprintCashOrCardLocal58();
						}
					}
					
				} else if(printbillpapersize == '80.00') {					
					if( gsttext != '' && gsttext.length>0){
						if(gstno != '' && gstno.length>0){
							   var gstText = gsttext+":"+gstno;
							   document.getElementById('refundpaidgstdata').innerHTML = gstText;
							   $("refundpaidgstdata").show();
							   
						   }
					}
					else{
						 $("refundpaidgstdata").hide();
					}
					$("#refunditemDetailsPrint80").text("");
					/* ****** Print in 80 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					/*$('#refundstoreName80').text(customerName);
					$('#refundstoreAddr80').text(storeAddr);
					$('#refundstoreEmail80').text(customerEmail);
					$('#refundstorePhNo80').text(customerPhNo);*/
					//$('#refundcashOrdervalue80').text(orderNo);
					
					$('#refundcashOrdervalue80').text(storeBasedOrderNo);
					
					console.log('orderDate'+orderDate);
					$('#refundcashOrderdate80').text(orderDate);
					if(tabNo!='0'){
						$('#refundcashtableNoValue80').text('Table No:'+tabNo);
					}
					else{
						$('#refundcashtableNoValue80').text(orderTypeOfOrder);
					}
					//$('#refundorderType_80px').text(orderTypeOfOrder);

					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						//alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#refunditemDetailsPrint80").append(createdrowline);

					}

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					//alert(" << subToatlAmt >> "+subToatlAmt+ " << serviceChargeAmt >>"+serviceChargeAmt+"<< serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt >>"+vatAmt+"<< customerDiscount >>"+customerDiscount+"<< billAmt >> "+billAmt+"<< grossAmt >> "+grossAmt);						
					$('#refundcashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));

					if (serviceChargeAmt > 0) {
                         // alert("serviceChargeAmt"+serviceChargeAmt);
						$("#refundorderAmtDetails .serviceCharge80px").show();
						$('#refundcashservChrg80').text(parseFloat(serviceChargeAmt).toFixed(2));
						$('#refundcashservChrgDisc80').text("(" + serviceChargeDisc +")%");
					} else {
					
						$("#refundorderAmtDetails .serviceCharge80px").hide();
					}

					if (serviceTaxAmt > 0) {
						 //alert("serviceTaxAmt"+serviceTaxAmt);
						$("#refundcashtotalServiceTax80px").show();
						$('#refundcashservTax80').text(parseFloat(serviceTaxAmt).toFixed(2));
					} else {
						//alert(" else serviceTaxAmt"+serviceTaxAmt);
						$("#refundcashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						// alert("vatAmt"+vatAmt);
						$("#refundcashtotalVatTax80px").show();
						$("#refundcashvatTax80px").text(parseFloat(vatAmt).toFixed(2));
					} else {
						$("#refundcashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#refundcashshowDiscount80px").show();
						$("#refundcashdiscountValue80").text(parseFloat(customerDiscount).toFixed(2));
						$("#refundpaidbilldiscpers").text(parseFloat(discPercentage).toFixed(2));
					} else {
						$("#refundcashshowDiscount80px").hide();
					}

					$("#refundcashgrossAmount80").text(parseFloat(billAmt).toFixed(2));
					$("#refundcashamoutToPay80").text(parseFloat(grossAmt).toFixed(2));

					var paymentsObj = jsonObj.payments.length;	
					
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(returnAmt);
						$('#refundpayType80').text(type);

					}
					
					
					
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#refundpayType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#refundpayType80').text(type1 + " & " + type2);
					}

					
					$("#refundorderrefundAmount80").text(parseFloat(paidAmt).toFixed(2));
					/* ********** END AMOUNT INFO PRINT ********** 	*/

				
					 
                   /*if(tabNo == '0' && parcelAdd == 'Y'){*/
		            if(parcelAdd == 'Y'){
            	      
            	      if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
							//alert(orderCustomerName); refundcusnametr80
							document.getElementById('refundcusname80').innerHTML =orderCustomerName;				
							document.getElementById("refundcusnametr80").style.display = "block";
							
						}
						if(orderCustomerAddr != '' && orderCustomerAddr != null && orderCustomerAddr.length >0){
							document.getElementById('refundcusaddress80').innerHTML =orderCustomerAddr;											
							 document.getElementById("refundcusaddresstr80").style.display = "block";
						}
						
						if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
							document.getElementById('refundcusphno80').innerHTML =ordercustomerphone;
							document.getElementById("refundcusphnotr80").style.display = "block";
							
						}
						
						if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
							document.getElementById('refundcuslocation80').innerHTML =cuslocation;
							document.getElementById("refundcuslocationtr80").style.display = "block";
							
						}
						
						if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
							document.getElementById('refundcusstreet80').innerHTML =cusstreet;
							document.getElementById("refundcusstreettr80").style.display = "block";
							 
						}
						

						if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
							document.getElementById('refundcushouseno80').innerHTML =cushouseno;
							document.getElementById("refundcushousenotr80").style.display = "block";
							 
						}
						
						
						if(delivaryboy != '' && delivaryboy != null && delivaryboy.length >0){
							document.getElementById('refunddeliveryboy80').innerHTML =delivaryboy;	
							document.getElementById("refunddeliveryboytr80").style.display = "block";
							
						}
						
					}
            else{
            	//alert("none");
            	 document.getElementById("refundcusnametr80").style.display = "none";
            	 document.getElementById("refundcusaddresstr80").style.display = "none";
            	 document.getElementById("refundcusphnotr80").style.display = "none";
            	 document.getElementById("refundcuslocationtr80").style.display = "none";
            	 document.getElementById("refundcusstreettr80").style.display = "none";
            	 document.getElementById("refundcushousenotr80").style.display = "none";
            	 document.getElementById("refunddeliveryboytr80").style.display = "none";
            }
          
            if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
				
				var amt1 = jsonObj.orderBill.billAmount;
				var paidAmt1 = jsonObj.orderBill.billAmount;
				if (amt1 == paidAmt1) {
									
					refundprintCashOrCardLocal80();					
				}
			}
                                                         
        	if (paymentsObj == 1) {
				 
				var amt1 = jsonObj.payments[0].amount;
				var paidAmt1 = jsonObj.payments[0].paidAmount;
				if (amt1 == paidAmt1) {
										
					refundprintCashOrCardLocal80();					
				}
			}

			if (paymentsObj == 2) {

				var amt2 = jsonObj.payments[0].amount;
				var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
				
				if (amt2 == paidAmt2) {
									
					refundprintCashOrCardLocal80();					
				}
			}
		}else if(printbillpapersize == '2100.00'){
					/*$('#refundstoreName2100').text(customerName);
					$('#refundstoreAddr2100').text(storeAddr);
					$('#refundstoreEmail2100').text("Email :"+customerEmail);
					$('#refundstorePhNo2100').text("Ph :"+customerPhNo);*/
					//$('#refundcashOrdervalue2100').text(orderNo);
			         $('#refundcashOrdervalue2100').text(storeBasedOrderNo);
					$('#refundcashOrderdate2100').text(orderDate);
					if(storeID == "120"){
						//orderNo = orderNo + "/2018-19";
						storeBasedOrderNo = storeBasedOrderNo + "/2019-20";
					}
					if(tabNo!='0'){
						$('#refundcashtableNoValue2100').text('Table No:'+tabNo);
					}
					else{
						$('#refundcashtableNoValue2100').text(orderTypeOfOrder);
					}
					
					
					//$('#refundcashtableNoValue2100').text(tabNo);

					/* ********** For GST *********** */
					
					$('#refundstoreName2100_GST').text(customerName);
					$('#refundstoreAddr2100_GST').text(storeAddr);
					$('#refundstoreEmail2100_GST').text(customerEmail);
					$('#refundstorePhNo2100_GST').text(customerPhNo);
					//$('#refundcashOrdervalue2100_GST').text(orderNo);
					$('#refundcashOrdervalue2100_GST').text(storeBasedOrderNo);
					$('#refundcashOrderDate_GST').text(orderDateWithTime);
					
					$('#refundcashCustName_GST').text(orderCustomerName);
					$('#refundcashCustAddr_GST').text(orderCustomerAddr);
					$('#refundcashCustState_GST').text(state);
					$('#refundcashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					$('#refundcashCustPhone2100_GST').text(ordercustomerphone);
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#refundcashOrderDate_GST").text(y + "-" + m + "-" + d);
					$('#refundpaidbilldiscpers2100').text(parseFloat(discPercentage).toFixed(2)); // for display discount percentage
					
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#refunditemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					 var tottaxamt=0.0;
						for ( var k = 0; k < jsonObj.orderitem.length; k++) {
							var item1 = jsonObj.orderitem[k];

							var itemName = item1.item.name;
							var itemQty = item1.quantityOfItem;
							var itemRate = item1.rate;
							var itemTotalPrice = item1.totalPriceByItem;
							var itemUnit = item1.item.unit;
							var itemDisc = item1.promotionDiscountAmt;
							var itemTotalAmt = 0.0;
							var itemTaxableAmt = 0.0;
							var cgstPrcnt = item1.vat;
							var cgstAmt = 0.0;
							var sgstPrcnt = item1.serviceTax;
							var sgstAmt = 0.0;
							
							var igstPrcnt = Number(item1.vat) + Number(item1.serviceTax);  // for 120
							var igstAmt = 0.0; // for 120
							//var itemHsn = "";
							var itemHsn = item1.item.code;						
							if(itemHsn == undefined){itemHsn="";}						
							if(item1.item.promotionFlag == "Y")
							{							
								itemTotalAmt = (item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem;
								if(item1.item.spotDiscount == "Y"){
									itemDisc = (itemTotalAmt * discPercentage)/100; 
								}
								else{
									itemDisc = 0.00;
								}
								
								itemTaxableAmt = (((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)- itemDisc;
								cgstAmt = ((((((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)) - itemDisc)* item1.vat)/100;
								sgstAmt = ((((((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt))- itemDisc) * item1.serviceTax)/100;
							}
							else
							{
								itemTotalAmt = item1.quantityOfItem*item1.rate;
								if(item1.item.spotDiscount == "Y"){
									itemDisc = (itemTotalAmt * discPercentage)/100; 
								}
								else{
									itemDisc = 0.00;
								}
								
								itemTaxableAmt = ((item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt) - itemDisc;
								cgstAmt = (((((item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt))- itemDisc) * item1.vat)/100;
								sgstAmt = (((((item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt))- itemDisc) * item1.serviceTax)/100;
							}
							
							/*if(item1.item.spotDiscount == "Y"){
								itemDisc = (itemTotalAmt * discPercentage)/100; 
							}
							else{
								itemDisc = 0.00;
							}*/
							
							
							
							
					//		alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);
							totTaxable = totTaxable + itemTaxableAmt;
							var createdrowline = "";
							var startTrline1 = "<tr>";
							var firstTdline = "<td width='30%;'>" + itemName + "</td>";
							var secondTdline = "<td width='6%;'>" + itemQty + "</td>";
							var thirdTdline = "<td width='5%;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
							var fourthTdline = "<td width='5%;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
							var unit_clm = "<td width='6%;'>" + itemUnit + "</td>";
							var disc_clm = "<td width='5%;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
							var taxable_clm = "<td width='10%;'>" + parseFloat(itemTaxableAmt).toFixed(2) + "</td>";
							
							
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

							$("#refunditemDetailsPrint2100_GST").append(createdrowline1);

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

					$("#refunditemDetailsPrint2100_GST").append(createdrowline2);

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					
					$('#refundcashtotalamt2100').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#refundcashtotalServiceCharge2100px").show();
						$('#refundcashservChrgPercentage2100').text(serviceChargeDisc);
						$('#refundcashservChrg2100').text(serviceChargeAmt);
					} else {
						$("#refundcashtotalServiceCharge2100px").hide();
					}

					/*if (serviceTaxAmt > 0.00) {
						$("#refundcashtotalServiceTax2100px").show();
						$('#refundcashservTax2100').text(serviceTaxAmt);
					} else {
						$("#refundcashtotalServiceTax2100px").hide();
					}*/

					/*if (vatAmt > 0) {
						$("#refundcashtotalVatTax2100px").show();
						$("#refundcashvatTax2100px").text(vatAmt);
					} else {
						$("#refundcashtotalVatTax2100px").hide();
					}*/

					/*if (customerDiscount > 0) {
						$("#refundcashshowDiscount2100px").show();
						$("#refundcashdiscountValue2100").text(customerDiscount);
					} else {
						$("#refundcashshowDiscount2100px").hide();
					}*/

					$("#refundcashgrossAmount2100").text(billAmt);
					$("#refundcashamoutToPay2100").text(grossAmt);
                    $("#refundcashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					$("#refundcashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$('#refundcashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					$('#refundcashIGST2100_gst').text(parseFloat(tottaxamt).toFixed(2));
					$('#refundcashTotalTaxAmount2100_gst').text(Number(Number(serviceTaxAmt) + Number(vatAmt)).toFixed(2));
					
					
					
					if(storeID == '120'){ 
					    if(state=='WB' || state=='wb' || state=='West Bengal' || state=='west bengal'|| state=='westbengal' || state=='WestBengal' || state=='WEST BENGAL' || state=='WESTBENGAL'){
					    	$("#refundcashvatTax2100px_gst").show();
					    	$("#refundcashservTax2100_gst").show();
					    	$("#refundcashIGST2100_gst").hide();
					    
					    }
					    else{
					    	$("#refundcashvatTax2100px_gst").hide();
					    	$("#refundcashservTax2100_gst").hide();
					    	$("#refundcashIGST2100_gst").show();
					    	
					       }
					   }else{
						  
						    $("#refundcashvatTax2100px_gst").show();
					    	$("#refundcashservTax2100_gst").show();
					    	$("#refundcashIGST2100_gst").hide();
					    }
					
					
					
					
					
					
					
					
					
					
					var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
					
					$("#refundcashgrossAmount2100_word_gst").text(cash_gross_word);
					
					$("#refundpaidAmount_paidbill_2100px").text(parseFloat(grossAmt).toFixed(2)); // new added 10.5.2018
					$("#refundamoutToPay_paidbill_2100px").text('00.00'); // new added 10.5.2018
					
					var paymentsObj = jsonObj.payments.length;
					
					var paymentmode = "";
					var coma = ',';
					if (paymentsObj == 1) {
						paymentmode=jsonObj.payments[0].paymentMode;
					}else{
						for(var i=0;i<paymentsObj;i++){
							if(paymentmode == ""){
								paymentmode=jsonObj.payments[i].paymentMode;
							}else{
								paymentmode = paymentmode + coma + jsonObj.payments[i].paymentMode;
							}
						}
					}
					$("#refundpaymentmode_paidbill_2100px").text(paymentmode);
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#refundpaidAmount2100').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount2100').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount2100').text(returnAmt);
						$('#refundpayType2100').text(type);

					}
										
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#refundpaidAmount2100').text(paidAmt);
						$('#refundtenderAmount2100').text(tenderAmt);
						$('#refundrefundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#refundpayType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#refundpaidAmount2100').text(paidAmt);
						$('#refundtenderAmount2100').text(tenderAmt);
						$('#refundrefundAmount2100').text("0.00");
						$('#refundpayType2100').text(type1 + type2);
					}
					$("#refundrefundorderamount2100px").text(parseFloat(grossAmt).toFixed(2));
					/* ********** END AMOUNT INFO PRINT ********** */	

					 if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt						
						var amt1 = jsonObj.orderBill.billAmount;
						var paidAmt1 = jsonObj.orderBill.billAmount;
						if (amt1 == paidAmt1) {											
							refundprintCashOrCardLocal2100();					
						}
					}
					
					
					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							refundprintCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							refundprintCashOrCardLocal2100();
						}
					}
				}

			}
		});

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
function refundprintCashOrCardLocal58() {

	var divToPrint = document.getElementById('refundprintDiv58');
	document.getElementById('refundremovePrint58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('refundremovePrint58').style.display = 'block';

	newWin.close();
	// location.href = BASE_URL + '/table/viewtable.htm';
}
function refundprintCashOrCardLocal80() {
	   //alert("refundprintCashOrCardLocal80");
		//console.log("print bill");
		var divToPrint = document.getElementById('refundprintDiv80');
		document.getElementById('refundcashRemovePrint80').style.display = 'none';
		newWin = window.open("");
		//alert('hello1');
		newWin.document.write(divToPrint.outerHTML);
		newWin.document.close();
		newWin.focus();
		newWin.print();
		
		document.getElementById('refundcashRemovePrint80').style.display = 'block';
	    
		newWin.close();
		//console.log("print bill end");
		// location.href = BASE_URL + '/table/viewtable.htm';
	}

function refundprintCashOrCardLocal2100() {
	 // $('#printDiv2100GST').modal('show');
	 //var divToPrint = document.getElementById('refundprintDiv2100');
	 var divToPrint = document.getElementById('refundprintDiv2100GST');
	 //document.getElementById('refundcashRemovePrint2100').style.display = 'none';
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 //newWin.document.close();
	 newWin.focus();
	 newWin.print();
	 //document.getElementById('refundcashRemovePrint2100').style.display = 'block';
	 
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
/* ===================== End */





function showRefundBill(orderid) 
{
	
	var order = {};
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				console.log(response);
				var orderNo = jsonObj.id;
				var storeBasedOrderNo = jsonObj.orderNo;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.customers.address;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var state=jsonObj.state;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;
                var cuslocation = jsonObj.location;
                var cusstreet = jsonObj.street;
                var cushouseno = jsonObj.houseNo;
                var delivaryboy = jsonObj.deliveryPersonName;
				var ordercustomerphone= jsonObj.customerContact;
				
				/* ***** Bill Amount Details ***** */
				var storeId = jsonObj.orderBill.storeid;
				var billAmt = jsonObj.orderBill.billAmount;
				var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
				var vatAmt = jsonObj.orderBill.vatAmt;
				var grossAmt = jsonObj.orderBill.grossAmt;
				var totalDiscount = jsonObj.orderBill.totalDiscount;
				var customerDiscount = jsonObj.orderBill.customerDiscount;
				var roundOffAmt = jsonObj.orderBill.roundOffAmt;
				var discPercentage = jsonObj.orderBill.discountPercentage;
				var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
				var subToatlAmt = jsonObj.orderBill.subTotalAmt;
				//var serviceChargeDisc = jsonObj.ordertype.serviceChargeValue;
				var serviceChargeDisc = jsonObj.orderBill.serviceChargeRate;
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				
				var orderDate=jsonObj.orderTime;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
                if( gsttext != '' && gsttext.length>0){
						if(gstno != '' && gstno.length>0){
							   var gstText = gsttext+":"+gstno;
							   document.getElementById('refundpaidgstdata').innerHTML = gstText;
							   $("refundpaidgstdata").show();
							   
						   }
					}
					else{
						 $("refundpaidgstdata").hide();
					}
					$("#refunditemDetailsPrint80").text("");
					$('#refundcashOrdervalue80').text(storeBasedOrderNo);
					
					console.log('orderDate'+orderDate);
					$('#refundcashOrderdate80').text(orderDate);
					if(tabNo!='0'){
						$('#refundcashtableNoValue80').text('Table No:'+tabNo);
					}
					else{
						$('#refundcashtableNoValue80').text(orderTypeOfOrder);
					}
					
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#refunditemDetailsPrint80").append(createdrowline);

					}

					$('#refundcashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));

					if (serviceChargeAmt > 0) {
						$("#refundorderAmtDetails .serviceCharge80px").show();
						$('#refundcashservChrg80').text(parseFloat(serviceChargeAmt).toFixed(2));
						$('#refundcashservChrgDisc80').text("(" + serviceChargeDisc +")%");
					} else {
					
						$("#refundorderAmtDetails .serviceCharge80px").hide();
					}

					if (serviceTaxAmt > 0) {			
						$("#refundcashtotalServiceTax80px").show();
						$('#refundcashservTax80').text(parseFloat(serviceTaxAmt).toFixed(2));
					} else {
						$("#refundcashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						$("#refundcashtotalVatTax80px").show();
						$("#refundcashvatTax80px").text(parseFloat(vatAmt).toFixed(2));
					} else {
						$("#refundcashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#refundcashshowDiscount80px").show();
						$("#refundcashdiscountValue80").text(parseFloat(customerDiscount).toFixed(2));
						$("#refundpaidbilldiscpers").text(parseFloat(discPercentage).toFixed(2));
					} else {
						$("#refundcashshowDiscount80px").hide();
					}

					$("#refundcashgrossAmount80").text(parseFloat(billAmt).toFixed(2));
					$("#refundcashamoutToPay80").text(parseFloat(grossAmt).toFixed(2));

					var paymentsObj = jsonObj.payments.length;	
					
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(returnAmt);
						$('#refundpayType80').text(type);

					}
					
					
					
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#refundpayType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#refundpaidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#refundtenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundrefundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#refundpayType80').text(type1 + " & " + type2);
					}

					
					$("#refundorderrefundAmount80").text(parseFloat(paidAmt).toFixed(2));
					/* ********** END AMOUNT INFO PRINT ********** 	*/

				
					 
           /* if(tabNo == '0' && parcelAdd == 'Y'){*/ 
			 if(parcelAdd == 'Y'){
            	      //alert("jj");
            	     // alert(tabNo+""+parcelAdd);
            	    
            	      if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
							//alert(orderCustomerName);
							document.getElementById('refundcusname80').innerHTML =orderCustomerName;				
							document.getElementById("refundcusnametr80").style.display = "block";
							
						}
						if(orderCustomerAddr != '' && orderCustomerAddr != null && orderCustomerAddr.length >0){
							document.getElementById('refundcusaddress80').innerHTML =orderCustomerAddr;											
							 document.getElementById("refundcusaddresstr80").style.display = "block";
						}
						
						if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
							document.getElementById('refundcusphno80').innerHTML =ordercustomerphone;
							document.getElementById("refundcusphnotr80").style.display = "block";
							
						}
						
						if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
							document.getElementById('refundcuslocation80').innerHTML =cuslocation;
							document.getElementById("refundcuslocationtr80").style.display = "block";
							
						}
						
						if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
							document.getElementById('refundcusstreet80').innerHTML =cusstreet;
							document.getElementById("refundcusstreettr80").style.display = "block";
							 
						}
						

						if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
							document.getElementById('refundcushouseno80').innerHTML =cushouseno;
							document.getElementById("refundcushousenotr80").style.display = "block";
							 
						}
						
						
						if(delivaryboy != '' && delivaryboy != null && delivaryboy.length >0){
							document.getElementById('refunddeliveryboy80').innerHTML =delivaryboy;	
							document.getElementById("refunddeliveryboytr80").style.display = "block";
							
						}
						
					}
            else{
            	//alert("none");
            	 document.getElementById("refundcusnametr80").style.display = "none";
            	 document.getElementById("refundcusaddresstr80").style.display = "none";
            	 document.getElementById("refundcusphnotr80").style.display = "none";
            	 document.getElementById("refundcuslocationtr80").style.display = "none";
            	 document.getElementById("refundcusstreettr80").style.display = "none";
            	 document.getElementById("refundcushousenotr80").style.display = "none";
            	 document.getElementById("refunddeliveryboytr80").style.display = "none";
            }
             $("#refundprintBtn_80").addClass('hidden');
             $('#refundcashhelloPrintModal80').modal("show");
           
		

			}
		});

	
}