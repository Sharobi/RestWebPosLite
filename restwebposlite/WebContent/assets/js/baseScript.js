var itemObjValue = new Array(); //18.7.2018 for kot
var itemUnique; //18.7.2018 for kot
var ordItemVal; //18.7.2018 for kot
var storeOrderNo ="";//18.7.2018 for kot
function updatetableStatus(operation)
{
	var tableData = document.getElementById('TableId').value;//changetableheaderdataordersearch
	if(tableData==0)
		{
		//alert('Please select a table');
		showselectTablealertModal();
		}
	else
		{
		var status=document.getElementById('tabstatus'+tableData).value;
		if(status=='Y')
			{
			
			showbookedTablealertModal();
			}
		else
			{
			/*if (confirm("Are you sure?")) {
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/table/updatetableStatus/" + tableData + "/" + operation + ".htm", function() {
					location.href=BASE_URL+'/table/viewtable.htm';
				}, null);
			}*/
			showconfirmTablealertModal(tableData,operation);
			}
		}
}
function updateTableOperation()
{
	var tableData=document.getElementById('targettableId').value;
	var operation=document.getElementById('targettableOpt').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/table/updatetableStatus/" + tableData + "/" + operation + ".htm", function() {
		location.href=BASE_URL+'/table/viewtable.htm';
	}, null);
}
function showtablebookingData()
{
	
	//alert('tablebookingdata');
	document.getElementById('tablebookingheaderdata').style.display='block';
	document.getElementById('changetableheaderdata').style.display='block';
	//document.getElementById('changetaxsetup').style.display='block';

	// order type select tag display to show in screen whenever orderTaking.jsp will be load. by SIBAPRASAD and SAYANI 
	document.getElementById('order_type').style.display='block';

	 var x = document.getElementById("orderType");
	// alert("length:"+x.length);
	 if(x.length==0)
		{
		// alert("open");
	    	shownoOrderTypeModal();
		}
}
function directOrderCheck(val)
{
	if(val=='xx')
		{
		showdirectOrderModal();
		}
}

function searchbyorderno(orderno){
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/" + orderno + ".htm", function(res) {
		console.log(res);
		var resoderdet=JSON.parse(res);
		var orderNo = resoderdet.id;
		if(orderNo==0){
			$("#noOrderRecordsFoundModal").modal("show");
		}else{
//			var orderNo=orderNo_withordertype.split("_")[0];
			var orderType = resoderdet.ordertype.id;
			var tabno = resoderdet.table_no;
			var seatno =( resoderdet.seatNo==null)?0:resoderdet.seatNo;
			//	alert(orderType);
			// alert('select:'+orderNo+':'+tabno+':'+seatno);
		/*	if (orderType == 1) {
				location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=h';
			} else if (orderType == 5) {
				location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=s';
			} else if (orderType == 6) {
				location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=z';
			} else {*/
				location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + seatno;
			//}
		}
		
	}, null);
}


function clickonSubmenu(subMenuId,cssIndex)
{
	setTimeout(
			  function() 
			  {
			    //do something special
				  loadMenuItems(BASE_URL + "/menu/menuitems.htm?menuid=" + subMenuId + "&index=" + cssIndex + "",document.getElementById('menu_items_container'));
			  }, 1000);
		
}

function loadMenuItems(url,containerId)
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(url, function(response) {
		containerId.innerHTML = response;
	}, null);
}

function clickOnTable(tableId,tableNo,orderNo,seatNo)
{
	//alert(tableId+":"+tableNo+":"+orderNo);
	location.href=BASE_URL+'/order/vieworder.htm?ono='+orderNo+'&tno='+tableNo+'&sno='+seatNo;
	
}
var orderitemdata=null;
/*function additemtoOrder(itId,itName,itPrice,disc,vat,serviceTax,promoFlag,promoValue)//backup
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/addorderitem/" + itId + "/" + decodeURIComponent(itName) + "/" + itPrice + "/" + disc + "/" + vat + "/" + serviceTax + "/" + promoFlag + "/" + promoValue+".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			prepareOrderHtml(responseObj);
			var qty=null;
			for(var i=0;i<responseObj.length;i++)
				{
				var orderitem=responseObj[i];
				if(itId==orderitem.itemId)
					{
					qty=orderitem.quantityOfItem;
					}
				}
			if(vfdPort.length>3)
			{
				if(itName.length>12)
				itName=itName.substring(0,12);
				var tot=document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +qty+"x"+itName+":"+parseFloat(itPrice).toFixed(2)  + "/" +"TOT IN RM : "+parseFloat(tot).toFixed(2)+".htm", function() {
				}, null);
			}
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
}
*/
var itemRecord=[];
function additemtoOrder(itId,itName,itPrice,disc,vat,serviceTax,promoFlag,promoValue)
{
	//alert(JSON.stringify(itemRecord));
	if(displayCurrentStockMenu == 'Y'){
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/itemstockin/getfgcurrentstock/" + itId + ".htm",function(response) {
			            var responseObj = JSON.parse(response);
			            var flag= false;
			            for(var k=0;k<itemRecord.length;k++){
			            	if(itemRecord[k].itemId == itId){
			            		flag=true;
			            		
			            	}
			            }
			            if(flag == false){
			            	itemRecord.push(responseObj[0]);
			            }
			           
			           $("#itmName").text(responseObj[0].name);
			           $("#itmcurstck").text(responseObj[0].curStock);
			           
			             $("#itIdData").val(itId);
		        		 $("#itNameData").val(itName);
		        		 $("#itPriceData").val(itPrice);
		        		 $("#discData").val(disc);
		        		 $("#vatData").val(vat);
		        		 $("#serviceTaxData").val(serviceTax);
		        		 $("#promoFlagData").val(promoFlag);
		        		 $("#promoValueData").val(promoValue);
			             if(responseObj[0].curStock<1){
			            	 if(negativeStockBilling == 'Y'){
			            		 $("#itmSaleBtn").removeClass('disabled');
			            	 }else{
			            		 $("#itmSaleBtn").addClass('disabled');
			            	 }
			        	  }else{
			        		  
			        		  if(negativeStockBilling == 'N'){
				        		   if(flag == true){
				        			   var currentQtyInBill = $("#qty"+itId).val();
				        			   if((Number(currentQtyInBill)+1) > responseObj[0].curStock){
				        				   $("#itmSaleBtn").addClass('disabled');
				        			   }else{
				        				   $("#itmSaleBtn").removeClass('disabled');
				        			   }
				        			   
				        		   }else{
				        			   $("#itmSaleBtn").removeClass('disabled');
				        		   }
				        		 
				        		  }else{
				        			  $("#itmSaleBtn").removeClass('disabled');
				        		  }
			        		  
			        		  
			        	  
			        	  }
			           $("#itemCurrentStockModal").modal('show');
						
		              }, null);
	}else{
		addOrUpdateOrderItems(itId,itName,itPrice,disc,vat,serviceTax,promoFlag,promoValue);
	}	

}

function clearItemCodeSearch(){
	  $("#itemCodeSearch").val("");
}


function addOrUpdateOrderItems(itId,itName,itPrice,disc,vat,serviceTax,promoFlag,promoValue){
	$("#itemCurrentStockModal").modal('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/addorderitem/" + itId + "/" + decodeURIComponent(itName) + "/" + itPrice + "/" + disc + "/" + vat + "/" + serviceTax + "/" + promoFlag + "/" + promoValue+".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			prepareOrderHtml(responseObj);
			var qty=null;
			for(var i=0;i<responseObj.length;i++)
				{
				var orderitem=responseObj[i];
				if(itId==orderitem.itemId)
					{
					qty=orderitem.quantityOfItem;
					}
				}
			if(vfdPort.length>3)
			{
				if(itName.length>12)
				itName=itName.substring(0,12);
				var tot=document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +qty+"x"+itName+":"+parseFloat(itPrice).toFixed(2)  + "/" +"TOT IN RM : "+parseFloat(tot).toFixed(2)+".htm", function() {
				}, null);
			}
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	
	
}












var total=0.0;
var totDisc=0.0;
var forspNoteData=[];
var servTax=0.0;
var VATamt=0.0;
var grandTot=0.0;
var PaidAmtVal=0.0;
var CustdiscAmtVal=0.0;
function prepareOrderHtml(responseData)
{
	console.log(JSON.stringify(responseData));
	forspNoteData=[];
	orderitemdata=responseData;
	var staticVat=14.5;
	var staticST=5.6;
	
	var orderVat=0.0;
	 var orderSTax=0.0
	 
	var subtotal=0.0;
	var disc=0.0;
	var staxAmt=0.0;
	var vatAmt=0.0;
	var grandTotal=0.0;
	var netPrice=0.0;
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var servicetaxText=document.getElementById('hidserviceTaxTextVal').value;
	var vattaxText=document.getElementById('hidvatTaxTextVal').value;
	var paidAmtVal=document.getElementById('hidpaidAmtVal').value;
	var custdiscAmtVal=document.getElementById('hidcustDiscVal').value;
	var orderitemcontainerId=document.getElementById('orderitemContId');
	var subtotalcontainerId=document.getElementById('subtotalcontId');
	//var servicetaxcontainerId=document.getElementById('servicetaxcontId');
	//var vatcontainerId=document.getElementById('vatcontId');
	var amttopaycontainerId=document.getElementById('amttopaycontId');
	var grandtotalcontainerId=document.getElementById('grandtotalcontId');
	//var discAmtcontainerId=document.getElementById('discAmtCont');
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var parcelST=document.getElementById('hidparcelST').value;
	var parcelVat=document.getElementById('hidparcelVat').value;
	var scharge = $('#serviceChargeRate').val();
	var schargetext = $('#hidserviceChargeTextNew').val();
//	alert("schargetext  scharge" + schargetext + scharge);
	var createdrowline="";
	var generatedHtml = "";
	//for saravana
	var tableline="<table class='table table-striped table-bordered' ><thead><th></th><th>NAME</th><th style='text-align:center;'>QUANTITY</th><th>RATE</th><th>TOTAL</th>";
	//for other
	//var tableline="<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>NAME</th><th style='text-align:center;'>QUANTITY</th><th>TOTAL</th><th>DISCNT</th><th>RATE</th>";
	//for saravana commented the following code
	/*if(vattaxText.length!=0)
		{
		tableline+="<th>"+vattaxText+"(%)</th>";
		}
	if(servicetaxText.length!=0)
		{
		tableline+="<th>"+servicetaxText+"(%)</th>";
		}*/
	var headerline="<tbody>";
	var footerline="</tbody></table>";
	//var table = document.getElementById("orderItemtable");
	for(var i=0;i<responseData.length;i++)
		{
		//alert( responseData[i].itemName);
		var orderitem=responseData[i];
		ordItemVal = responseData[i]; //18.7.2018 for kot
		var disc1=0.0;
		var begintrline="";
		var firsttdline="";
		var secondtdline="";
		var thirdtdline="";
		if(orderitem.isinOrder=='Y')
		{
			var trbgColor="#2E2E2E";
			if(orderitem.itemName.indexOf("CONTAINER") == 0)
				{
				trbgColor="#1c91bc";
				}
			begintrline="<tr style='padding:2px;'>";
			firsttdline="<td style='padding:1px;text-align:center;'>"+(i+1)+"</td>";
			if(orderitem.ordertype==2)
				{
				secondtdline="<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.itemName+"(P)</td>";
				
				}
			else
				{
				secondtdline="<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.itemName+"</td>";
				}
			thirdtdline="<td valign='middle' align='center' style='padding:3px;'> " +orderitem.quantityOfItem+
			//"<input type='text' size='1' disabled='disabled' value='"+orderitem.quantityOfItem+"' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;'>" +
			"</td>";
			
			var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate).toFixed(2)+"</td>";
		
		}
		else
		{
			//forspNoteData=[];
			forspNoteData.push(orderitem);
			var trbgColor="#222222";
			if(orderitem.itemName.indexOf("CONTAINER") == 0)
				{
				trbgColor="#1c91bc";
				}
			begintrline="<tr id='row_"+orderitem.itemId+"' style='padding:2px;'>";
			firsttdline="<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow("+orderitem.itemId+",this)' id='chk_"+orderitem.itemId+"'></td>";
			/*secondtdline="<td width='50%'  onclick='javascript:selectRow("+orderitem.itemId+")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.itemName+"</td>";*/
			secondtdline="<td width='50%' onclick='javascript:selectRow("+orderitem.itemId+")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'><a onclick='changeItemRate("+orderitem.itemId+",&quot;"+orderitem.itemName+"&quot;,"+orderitem.discount+","+orderitem.vat+","+orderitem.serviceTax+",&quot;"+orderitem.item.promotionFlag+"&quot;,"+orderitem.item.promotionValue+");'>"+orderitem.itemName+"</a></td>";
			
			thirdtdline="<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity("+orderitem.itemId+",&quot;"+orderitem.itemName+"&quot;,"+orderitem.rate+")'><img border='0' alt='' src='"+BASE_URL+"/assets/images/base/d/d_delete.png' height='22' width='18'></a> " +
			"<input type='text' id='qty"+orderitem.itemId+"' size='1' onkeyup='javascript:enterManualQuantity(this.value,"+orderitem.itemId+")' value='"+orderitem.quantityOfItem+"' style='text-align:center;height:22px;width:30px;' class='ordermanualQty'>" +
			" <a href='javascript:increaseItemQuantity("+orderitem.itemId+",&quot;"+orderitem.itemName+"&quot;,"+orderitem.rate+")'><img border='0'  alt='' src='"+BASE_URL+"/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";
			var sixthtdline="<td style='padding:1px;text-align: center;'>"+"<input type='text' id='rate"+orderitem.itemId+"' size='10' onkeyup='javascript:enterManualRate(this.value,"+orderitem.itemId+")' value='"+parseFloat(orderitem.rate).toFixed(2)+"' style='text-align:center;height:22px;width:80px;'>"+"</td>";
		
		}
		if(orderitem.item.promotionFlag=='Y')
		{
		disc1=(orderitem.rate*orderitem.quantityOfItem)*orderitem.discount/100;
		}
		//staxAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.serviceTax/100;
		//vatAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.vat/100;
		
		
		
		
		/*if(storeID=='35' && tableno!='0' && orderitem.serviceTax=='0')
			{
			staxAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*staticST/100;
			}
		else
			{
			staxAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.serviceTax/100;
			}
		if(storeID=='35' && tableno!='0' && orderitem.vat=='0')
			{
			vatAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*staticVat/100;
			}
		else
			{
			vatAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.vat/100;
			}*/
		
		/* orderVat=orderitem.vat;
		 orderSTax=orderitem.serviceTax; */
		
		
		
		
		disc+=disc1;
		subtotal+=(orderitem.rate*orderitem.quantityOfItem)-disc1;
		var fourthtdline="<td  style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+"</td>";
		var fifthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(disc1).toFixed(2)+"</td>";
		//var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate).toFixed(2)+"</td>";	
		/*var sixthtdline="<td style='padding:1px;text-align: center;'>"+"<input type='text' id='rate"+orderitem.itemId+"' size='10' onkeyup='javascript:enterManualRate(this.value,"+orderitem.itemId+")' value='"+parseFloat(orderitem.rate).toFixed(2)+"' style='text-align:center;height:22px;width:80px;'>"+"</td>";*/		
		var seventhhtdline="";
		var eighthtdline="";
		if(vattaxText.length!=0)
			{
			seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>";
			}
		if(servicetaxText.length!=0)
			{
			eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>";
			}
		
		var endtrline="</tr>";
		
		//disc+=(orderitem.rate*orderitem.discount/100)*orderitem.quantityOfItem;
		
		//createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem).toFixed(2)+endtrline;
		//for saravana
		createdrowline+=begintrline+firsttdline+secondtdline+thirdtdline+sixthtdline+fourthtdline+endtrline;
		//for other
		//createdrowline+=begintrline+firsttdline+secondtdline+thirdtdline+fourthtdline+fifthtdline+sixthtdline+seventhhtdline+eighthtdline+endtrline;
		
		
		//createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+orderitem.vat+eighthtdline+orderitem.serviceTax+endtrline;
		//createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+parseFloat(orderitem.vat).toFixed(2)+eighthtdline+endtrline;
		}
	
	var subtotalWithOutTax=0;
	var subtotalWithTax=0;
	//alert(responseData.length);
	for (var j = 0; j < responseData.length; j++) {

		var orderitemDesc = responseData[j];

			var discRate = 0;
			if (orderitemDesc.item.promotionFlag == 'Y') {
				disc1 = (orderitemDesc.rate * orderitemDesc.quantityOfItem)
						* orderitemDesc.discount / 100;
			}
			if(orderitemDesc.serviceTax == '0' && orderitemDesc.vat == '0')
				subtotalWithOutTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate; 
			else
				{
				orderVat=orderitemDesc.vat;
				orderSTax=orderitemDesc.serviceTax;
				subtotalWithTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
				
				 // new added strt 28.3.2019 for item wise tax calculation
			    staxAmt += (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderSTax) / 100;
			    vatAmt +=  (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderVat) / 100;
			    //new added end
				}

	}
	
	if(subtotalWithOutTax>custdiscAmtVal)
	{
		subtotalWithTax=subtotal - subtotalWithOutTax;	
	}
	else
	{	
		 subtotalWithTax=subtotal - custdiscAmtVal;
	}
	if (storeID == '35' && tableno != '0' && orderSTax == '0') {
		  staxAmt = subtotalWithTax * staticST / 100;
		 } else {
		  //staxAmt = subtotalWithTax * orderSTax / 100; // off new 28.3.2019
		 }
		 if (storeID == '35' && tableno != '0' && orderVat == '0') {
		  vatAmt = (subtotalWithTax * staticVat / 100);
		 } else {
		 // vatAmt =(subtotalWithTax * orderVat / 100);// off new 28.3.2019
		 }
	
		 console.log(staxAmt + " " + vatAmt);
		   
		    var flag = false;
		    for(var t=0;t<itemObjValue.length;t++){
		    	if(itemObjValue[t]==ordItemVal.itemId){
		    		flag = true;
		    	}
		    }
		    if(flag == false){
		    	//alert("add:"+ordItemVal.itemName);
		    	itemObjValue.push(ordItemVal.itemId);//18.7.2018
		    	}
		    
			//itemObjValue.push(ordItemVal.itemId);//18.7.2018
			itemUnique = $.unique(itemObjValue);//18.7.2018
	
	
	generatedHtml=tableline+headerline+createdrowline+footerline;
	if(tableno=='0' && parcelST=='N')
		{
		staxAmt=0.0;
		}
	if(tableno=='0' && parcelVat=='N')
	{
		vatAmt=0.0;
	}
	
	
	 if (schargetext == 'Y' && scharge != 0.00) 
	 {
	/*	  if (currentTable == 0 && orderType == '') {
		   scharge = 0;
		  } 
		  else {*/
		   staxAmt = staxAmt + staxAmt * scharge / 100;
		   vatAmt = vatAmt + vatAmt * scharge / 100;
		   scharge = subtotal * scharge / 100;
		// }
		 // console.log("scharge" + scharge);

	}
	//alert(generatedHtml);
	//grandTotal=(subtotal+staxAmt+vatAmt)-disc;
	//alert('subtotal:'+subtotal+'stax:'+staxAmt+':vat:'+vatAmt);
	grandTotal=(subtotal+staxAmt+vatAmt);
	//alert('paid:'+paidAmtVal+'disc:'+custAmtVal+':flag:'+storeroundoffflag);
	//alert('s text:'+servicetaxText.length);
	netPrice=grandTotal-paidAmtVal-custdiscAmtVal;
	orderitemcontainerId.innerHTML=generatedHtml;
	if(storeroundoffflag=='Y')
		{
		grandTotal=Math.round(grandTotal);
		netPrice=Math.round(netPrice);
		}
	subtotalcontainerId.innerHTML=parseFloat(subtotal).toFixed(2);
	if (schargetext == 'Y'  && scharge != 0.00) {
	//  if (currentTable == 0 && orderType == '') {
	//   $("#schrgId").html(parseFloat(0).toFixed(2));
	//  } else {
	   $("#schrgId").html(parseFloat(scharge).toFixed(2));
	 // }

	 }
	if(servicetaxText.length!=0)
		{
		document.getElementById('servicetaxcontId').innerHTML=parseFloat(staxAmt).toFixed(2);
		}
	if(vattaxText.length!=0)
	{
		document.getElementById('vatcontId').innerHTML=parseFloat(vatAmt).toFixed(2);
	}
	
	amttopaycontainerId.innerHTML=parseFloat(netPrice).toFixed(2);
	grandtotalcontainerId.innerHTML=parseFloat(grandTotal).toFixed(2);
	//discAmtcontainerId.value=parseFloat(disc).toFixed(2);
	total=grandTotal;
	totDisc=disc;
	$("#itemCodeSearch").val("");
	
	 servTax=staxAmt;
	 VATamt=vatAmt;
	 PaidAmtVal=paidAmtVal;
	 CustdiscAmtVal=custdiscAmtVal;
}

function increaseItemQuantity(itemId,itemName,itemRate){
	var salepageqty = $("#qty"+itemId).val();
	if(salepageqty == ""){
		 $("#hiddmanualeditItmId").val(itemId);
		 $("#alerteditOrderquantityModal1").modal('show');
	}else{
    if(displayCurrentStockMenu == 'Y'){
    	    for(var i=0;i<itemRecord.length;i++){
    	    	if(itemRecord[i].itemId==itemId){// Item Found Start
    	    		if(negativeStockBilling=='N'){ //negativeStockBilling is N
    	    			   if(itemRecord[i].curStock<=(Number(salepageqty))){ // out of stock
    	    		    	   document.getElementById('msgspace').innerHTML = "Item Can't Add.Out Of Stock";
    	    				   $("#msgmodal").modal('show');
    	    			    }else{ // In stock
    	    			    	orderItemQtyIncrease(itemId,itemName,itemRate);
    	    			    }
    	    	         }else{//negativeStockBilling is Y
    	    	        	 if(itemRecord[i].curStock<=(Number(salepageqty))){ // out of stock
    	    	        		/*$("#itIdOfOutStckItm").val(itemId);
 	    	    	    	    $("#itNameOfOutStckItm").val(itemName);
 	    	    	    	    $("#itPriceOfOutStckItm").val(itemRate);
 	    	    	    	    document.getElementById('msgspace1').innerHTML = "Item Is Out Of Stock";
 	    	    	    	    $("#itmOutOfStockmodal").modal('show');*/
    	    	        		 orderItemQtyIncrease(itemId,itemName,itemRate);
    	    	        		 
    	    	        	 }else{ // In stock
    	    	        		 orderItemQtyIncrease(itemId,itemName,itemRate);
    	    	        	 }
    	    	       }
    	    	  }// Item Found end
    	    }//loop end
    }else{
		orderItemQtyIncrease(itemId,itemName,itemRate);
	}
	}
 }

function orderItemQtyIncrease(itemId,itemName,itemRate){
	//alert(itemId);
	$("#itmOutOfStockmodal").modal('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/increaseitemquantity/" + itemId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			prepareOrderHtml(responseObj);
			var qty=null;
			for(var i=0;i<responseObj.length;i++)
				{
				var orderitem=responseObj[i];
				if(itemId==orderitem.itemId)
					{
					qty=orderitem.quantityOfItem;
					}
				}
			// for vfd
			if(vfdPort.length>3)
			{
				if(itemName.length>12)
				itemName=itemName.substring(0,12);
				var tot=document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +qty+"x"+itemName+":"+parseFloat(itemRate).toFixed(2)  + "/"+"TOT IN RM : " + parseFloat(tot).toFixed(2)+".htm", function() {
					}, null);
			}
		}catch(e)
		{
			alert(e);
		}
		}, null);


}




function decreaseItemQuantity(itemId,itemName,itemRate)
{
	//alert(itemId);
	var salepageqty = $("#qty"+itemId).val();
	if(salepageqty == ""){
		 $("#hiddmanualeditItmId").val(itemId);
		 $("#alerteditOrderquantityModal1").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/decreaseitemquantity/" + itemId  + ".htm", function(response) {
		try{
			 //alert(JSON.stringify(itemRecord));
			  var responseObj=JSON.parse(response);
			  var itemUpdateRecord = [];
			  for(var i=0;i<itemRecord.length;i++){
				  for(var k=0;k<responseObj.length;k++){
					 if(responseObj[k].itemId == itemRecord[i].itemId){
						 itemUpdateRecord.push(itemRecord[i]);
					 } 
				  }
			    }
			  itemRecord = itemUpdateRecord;
			  //alert(JSON.stringify(itemRecord));
			
			
			prepareOrderHtml(responseObj);
			
			// for vfd
			if(vfdPort.length>3)
			{
				if(itemName.length>13)
				itemName=itemName.substring(0,13);
				var tot=document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +itemName+":-"+parseFloat(itemRate).toFixed(2)  + "/" +"TOT IN RM : "+ parseFloat(tot).toFixed(2)+".htm", function() {
					}, null);
			}
		}catch(e)
		{
			alert(e);
		}
		}, null);
	}
}

function enterManualQuantity(qty,itemId){
	var salepageqty = qty;
	  if(displayCurrentStockMenu == 'Y'){
    	    for(var i=0;i<itemRecord.length;i++){
    	    	if(itemRecord[i].itemId==itemId){// Item Found Start
    	    		if(negativeStockBilling=='N'){ //negativeStockBilling is N
    	    			   if(itemRecord[i].curStock<(Number(salepageqty))){ // out of stock
    	    		    	   document.getElementById('msgspace').innerHTML = "Item Can't Add.Out Of Stock";
    	    		    	   document.getElementById('qty'+itemId).value="";
    	    		    	   document.getElementById('qty'+itemId).focus();
    	    				   $("#msgmodal").modal('show');
    	    			    }else{ // In stock
    	    			    	enterItemManualQuantity(qty,itemId);
    	    			    }
    	    	         }else{//negativeStockBilling is Y
    	    	        	 if(itemRecord[i].curStock<(Number(salepageqty))){ // out of stock
    	    	        		/*$("#itIdOfOutStckItmForManualEntry").val(itemId);
 	    	    	    	    $("#itNameOfOutStckItmForManualEntry").val(itemRecord[i].name);
 	    	    	    	    $("#itQtyOfOutStckItmForManualEntry").val(qty);
 	    	    	    	    document.getElementById('msgspace2').innerHTML = "Current Qty Of "+itemRecord[i].name+" is "+itemRecord[i].curStock;
 	    	    	    	    $("#itmOutOfStockmodalForManualEntry").modal('show');*/
    	    	        		 enterItemManualQuantity(qty,itemId);
    	    	        		 
    	    	        	 }else{ // In stock
    	    	        		 enterItemManualQuantity(qty,itemId);
    	    	        	 }
    	    	       }
    	    	  }// Item Found end
    	    }//loop end
    }else{
    	enterItemManualQuantity(qty,itemId);
	}
	
}




function enterItemManualQuantity(qty,itemId)
{
	//alert(qty+":"+itemId);
	//var newqty=qty.trim();
	  $("#itmOutOfStockmodalForManualEntry").modal('hide');
	/*if(parseInt(qty)>0)*/
	if(parseFloat(qty)>=0)
		{
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/manualitemquantity/"+qty +"/"+ itemId  + ".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareOrderHtml(responseObj);
				
				var number = qty.split('.');
				 if(Number(number[1])/10 >= 1){
					 $("#qty"+itemId).val(parseFloat(qty).toFixed(2)).blur();
				 }
				 else if(qty.indexOf(".") == qty.length-1 || qty.indexOf(".0") == qty.length-2) {
					$("#qty"+itemId).val(qty).focus();
				}
				else if(qty % 1 != 0){
					$("#qty"+itemId).val(qty).focus();
				}
				else{
					$("#qty"+itemId).val(parseInt(qty)).focus();
				}
				
				
				
				
			}catch(e)
			{
				alert(e);
			}
			}, null);
		//document.getElementById('qty'+itemId).focus();
		}
	else if(qty=='')
		{
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty'+itemId).focus();
		}
	else if(parseInt(qty)<0)
		{
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty'+itemId).value=1;
		}
	else 
		{
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty'+itemId).value=1;
		}
}
function setOrderItemManualQty()
{
	var itId=document.getElementById('hiddmanualeditItemId').value;
	document.getElementById('qty'+itId).value=1;
}
//function createOrder has been modified.  deliveryOption element id replaced by select order type drop down. by SIBAPRASAD and SAYANI 
//isOrderSave has been added by SIBAPRASAD and SAYANI 

function isOrderSave()
{
	var orderText=$('#orderNo').find("option:selected").text();
	if(orderText!=0){
		
		var idSelected =$('#orderNo option:selected').attr("id");
	    var orderType=null;
	  
	    var x = document.getElementById("orderType");
	    var i;

	    for (i = 0; i < x.length; i++) {
	    
		if(idSelected ==  x.options[i].value){
	
			x.options[i].selected = true;
		}
	    }
		
	    document.getElementById("orderType").disabled=true;
	}
}

function createOrder() {

	 // var option =document.getElementsByName("deliveryOption");
        //alert("hii");
	 var remark = document.getElementById("orderRmks").value;
	 var option;
	 var selOption = null;
	
	 var customerContact = document.getElementById("modparcelcustPhone").value;
	 var customerID = document.getElementById("modparcelcustIdhidden").value;
	 var customerName = document.getElementById("modparcelcustName").value;
	  if (customerContact == '' &&  customerName == '')
	   {
	  //custId='0';
	   customerContact= document.getElementById('itemContactSearch').value;
	   customerName=document.getElementById('itemNameSearch').value;
	   }
	 
	 if( custId=='' || custId==null)
	  {
	  custId='0';
	  }

	 var custName = null;
	 var custPhone = null;
	 
	 
	 var custAddress = null;
	 var deliveryPerson = null;
	 var custvatregno = null;
	 var location = null;
	 var houseno = null;
	 var streetno = null;
	 var dob = null;
	 var anniversary = null;
	// var waiterNameForTable=null;
	 var orderno = document.getElementById('orderNo').value;
	 //alert("orderno:"+orderno);
	 var tableno = document.getElementById('tablenoCont').innerHTML;
	 var seatno = document.getElementById('hidcurrentSeat').value;
	 var pax = document.getElementById('hidnoofPax').value;
	//  SelectedOption=$("#orderTypeid" + orderNo).val();

	 if (tableno == '0') {
	  if (parcelAdd == 'Y' && itcatId == '') {

		   option =$("#orderType").val();

	   custName =document.getElementById('itemNameSearch').value;
		

	   custPhone = document.getElementById('itemContactSearch').value;
		   //document.getElementById('modparcelcustPhone').value;
	   custAddress = decodeURIComponent(document.getElementById('modparcelcustAddress').value);
	   deliveryPerson = decodeURIComponent(document.getElementById('modparceldeliveryPersonName').value);
	   custvatregno = decodeURIComponent(document.getElementById('modparcelcustvatorcst').value);


	    houseno = decodeURIComponent(document
	 .getElementById('modparcelcusthouseno').value);
	    streetno = decodeURIComponent(document
	      .getElementById('modparcelcuststreet').value);
	    location = decodeURIComponent(document
	      .getElementById('modparcelcustlocation').value);
		   state=decodeURIComponent(document.getElementById('modparcelcuststate').value);		  		  
		  dob = decodeURIComponent(document
	     .getElementById('modparcelcustdob').value);
	   anniversary = decodeURIComponent(document
	     .getElementById('modparcelcustanniversary').value);
	  } else {
		  option =$("#orderType").val();
	  }
	  option =$("#orderType").val();
	 } else {
	  custName = '';
	  option =$("#orderType").val();
	 }
	 if(custPhone==null)
		{
		custPhone='';
		}
	if(custName==null)
	{
		custName='';
	}
	if (custPhone == '' &&  custName == '')
	  {
	
	   custId='0';
	   custName = '';
	   custPhone = '';
	   custAddress = '';
	   deliveryPerson = '';
	   custvatregno = '';
	   location = '';
	   houseno = '';
	   streetno = '';
	   dob = '';
	   anniversary = '';
	   state = '';
	  }
	 var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	 var storedoubleroundoffflag = document
	   .getElementById('hidstoredoubleroundoffFlag').value;
	 var netamt = 0.0;
	 if(state=='' && storeID=="120"){state="West Bengal";}

	 
	/*	alert("custAddress" + custAddress+ "deliveryPerson" + deliveryPerson + "houseno" + houseno + "streetno" +streetno + "location" + location
				+ "state" + state + "dob" + dob + "anniversary" + anniversary + "custvatregno" + custvatregno);*/
	
	 var ajaxCallObject = new CustomBrowserXMLObject();
	 ajaxCallObject
	   .callAjax(
	     BASE_URL + "/order/createorder.htm?delOption=" + option
	       + "&orderno=" + orderno + "&tableno=" + tableno
	       + "&custId=" + custId + "&custname=" + custName + "&custphone="
	       + custPhone + "&custaddress=" + custAddress
	       + "&deliveryperson=" + deliveryPerson + "&seatno="
	       + seatno + "&pax=" + pax + "&custvatregno="
	       + custvatregno + "&location=" + location
	       + "&houseno=" + houseno + "&streetno=" + streetno
	       +"&state=" + state + "&dob=" + dob + "&anniversary=" + anniversary+"&remark=" + remark,
	     function(response) {
	      try {

	       var responseObj = JSON.parse(response);
	        //alert(responseObj);
	       if (responseObj.length > 0 || responseObj != null) {
	    	   
	    	 netamt = total - totDisc;
	        if (storeroundoffflag == 'Y') {
	         netamt = Math.round(netamt);
	         total = Math.round(total);
	        }
	        if (storedoubleroundoffflag == 'Y') {
	         netamt = round(netamt, 1);
	        }
	        document.getElementById('modTabCont').innerHTML = tableno;
	        tableNoValue = tableno;
	        ordVal = responseObj.id;
	        document.getElementById('modOrderCont').innerHTML = responseObj.id;
	        document.getElementById('modOrderSuccessStoreBasedOrderCont').innerHTML = responseObj.orderNo;
	        document.getElementById('modAmtCont').innerHTML = parseFloat(
	          total).toFixed(2);
	        document.getElementById('modDiscCont').innerHTML = parseFloat(
	          totDisc).toFixed(2);
	        document.getElementById('modtotAmtCont').innerHTML = parseFloat(
	          netamt).toFixed(2);
	        /*
	         * if(tableno=='0') { var instantPrintBill="<button
	         * type='button'
	         * onclick='javascript:printinstantBill("+responseObj+");()'
	         * style='background: #72BB4F;font-weight:
	         * bold;' data-dismiss='modal' class='btn
	         * btn-success'>PRINT BILL</button>";
	         * document.getElementById('parcelInstantPrintBillContId').innerHTML=instantPrintBill; }
	         */
	        
	        if(ordSucc == 'Y'){
				showOrderModal();
				}
				else{
					orderSuccessOK();
				}

	       }

	      } catch (e) {
	       alert(e);
	      }
	     }, null);
	}



/*function createOrder()
{

 var option; 
 var custName=null;
 var custPhone=null;
 var custAddress=null;
 var deliveryPerson=null;
 var houseno=null;
 var streetno=null;
 var dob=null;
 var anniversary=null;
 var location=null;
 var state=null;
 var custvatregno=null;
 var orderno=document.getElementById('orderNo').value;
 if(isNaN(custId) || custId=='')
 {
 custId='0';
 }
 var tableno=document.getElementById('tablenoCont').innerHTML;
 var seatno=document.getElementById('hidcurrentSeat').value;
 var pax=document.getElementById('hidnoofPax').value;
 
 if(tableno=='0')
  {
  if(parcelAdd=='Y' && itcatId=='')
   {
	 
   option =$("#orderType").val();
   custName=decodeURIComponent(document.getElementById('modparcelcustName').value);
  
   custPhone=document.getElementById('modparcelcustPhone').value;
   custAddress=decodeURIComponent(document.getElementById('modparcelcustAddress').value);
   deliveryPerson=decodeURIComponent(document.getElementById('modparceldeliveryPersonName').value);
   custvatregno= decodeURIComponent(document.getElementById('modparcelcustvatorcst').value);
   alert("in create order" + custvatregno );
   if(orderno!=0)
	   {
	   houseno='';
	   streetno='';
	   location='';
	   state='';
	   }
   else{
	   houseno=decodeURIComponent(document.getElementById('modparcelcusthouseno').value);  
	   streetno=decodeURIComponent(document.getElementById('modparcelcuststreet').value);
	   location=decodeURIComponent(document.getElementById('modparcelcustlocation').value);
	   state=decodeURIComponent(document.getElementById('modparcelcuststate').value);
   }
   dob= decodeURIComponent(document.getElementById('modparcelcustdob').value);
   anniversary= decodeURIComponent(document.getElementById('modparcelcustanniversary').value);
   }
  else
   {
   option =$("#orderType").val();
   }
  
  }
 else
  {

  option =$("#orderType").val();
  }

 var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
 var netamt=0.0;
 
 var order={};
 var ordertype={};
  
 ordertype.id=parseInt(option);
 
 
 alert("custVatRegNo" + custvatregno);
 order.id=parseInt(orderno);
 order.customerName=custName;
 order.customerContact=custPhone;
 order.deliveryAddress=custAddress;
 order.deliveryPersonName=deliveryPerson;
 order.location=location;
 order.houseNo=houseno;
 order.street=streetno;
 order.state=state;
 order.custVatRegNo=custvatregno;
 order.table_no=tableno;
 order.seatNo='0';
 order.dob=dob;
 order.anniversary=anniversary;
 order.customerId=custId;
 
 
 
 
 order.noOfPersons=parseInt(pax);
 order.ordertype=ordertype;
 //alert(order);
 $
 .ajax({
  url : BASE_URL + "/order/createorder.htm",
  type : 'POST',
  contentType : 'application/json;charset=utf-8',
  data : JSON.stringify(order),
  success : function(response, JSON_UNESCAPED_UNICODE) {
   console.log(response);
   try{
    
    var responseObj=JSON.parse(response);
  
    if(responseObj.length>0 || responseObj!=null)
     {
     
     netamt=total-totDisc;
     if(storeroundoffflag=='Y')
      {
      netamt=Math.round(netamt);
      total=Math.round(total);
      }
     document.getElementById('modTabCont').innerHTML=tableno;
     document.getElementById('modOrderCont').innerHTML=responseObj;
     document.getElementById('modAmtCont').innerHTML=parseFloat(total).toFixed(2);
     document.getElementById('modDiscCont').innerHTML=parseFloat(totDisc).toFixed(2);
     document.getElementById('modtotAmtCont').innerHTML=parseFloat(netamt).toFixed(2);
    
     showOrderModal();
     }
    
   }catch(e)
   {
    console.log(e);
   }
  }
 });
}*/
/*
function createOrder()
{
	
	//var option =document.getElementsByName("deliveryOption");
	var option;
	var selOption=null;
	for(var i = 0; i < option.length; i++) {
		   if(option[i].checked == true) {
			   selOption = option[i].value;
		   }
		 }
	
	var custName=null;
	var custPhone=null;
	var custAddress=null;
	var deliveryPerson=null;
	var custvatregno=null;
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var seatno=document.getElementById('hidcurrentSeat').value;
	var pax=document.getElementById('hidnoofPax').value;
	if(tableno=='0')
		{
		if(parcelAdd=='Y' && itcatId=='')
			{
			option =document.getElementsByName("deliveryOptionParcel");
			custName=decodeURIComponent(document.getElementById('modparcelcustName').value);
			custPhone=document.getElementById('modparcelcustPhone').value;
			custAddress=decodeURIComponent(document.getElementById('modparcelcustAddress').value);
			deliveryPerson=decodeURIComponent(document.getElementById('modparceldeliveryPersonName').value);
			custvatregno= decodeURIComponent(document.getElementById('modparcelcustvatorcst').value);
			}
		else
			{
			option =document.getElementsByName("deliveryOption");
			}
		
		}
	else
		{
		option =document.getElementsByName("deliveryOption");
		}
	for(var i = 0; i < option.length; i++) {
		   if(option[i].checked == true) {
			   selOption = option[i].value;
		   }
		 }
	//alert(selOption);
	//alert('custname:'+custName+':custphone:'+custPhone+':custaddress:'+custAddress+':deliveryperson:'+deliveryPerson);
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var netamt=0.0;
	//alert(orderno+":"+tableno);
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/createorder.htm?delOption="+selOption+"&orderno="+orderno+"&tableno="+tableno+"&custname="+custName+"&custphone="+custPhone+"&custaddress="+custAddress+"&deliveryperson="+deliveryPerson+"&seatno="+seatno+"&pax="+pax+"&custvatregno="+custvatregno, function(response) {
		try{
			
			var responseObj=JSON.parse(response);
			//alert(responseObj);
			if(responseObj.length>0 || responseObj!=null)
				{
				
				netamt=total-totDisc;
				if(storeroundoffflag=='Y')
					{
					netamt=Math.round(netamt);
					total=Math.round(total);
					}
				document.getElementById('modTabCont').innerHTML=tableno;
				document.getElementById('modOrderCont').innerHTML=responseObj;
				document.getElementById('modAmtCont').innerHTML=parseFloat(total).toFixed(2);
				document.getElementById('modDiscCont').innerHTML=parseFloat(totDisc).toFixed(2);
				document.getElementById('modtotAmtCont').innerHTML=parseFloat(netamt).toFixed(2);
				if(tableno=='0')
				{
					var instantPrintBill="<button type='button' onclick='javascript:printinstantBill("+responseObj+");()' style='background: #72BB4F;font-weight: bold;' data-dismiss='modal' class='btn btn-success'>PRINT BILL</button>";
					document.getElementById('parcelInstantPrintBillContId').innerHTML=instantPrintBill;
				}
				showOrderModal();
				}
			
		}catch(e)
		{
			console.log(e);
		}
		}, null);
}
*/
/*function orderSuccessOK()
{
	//alert("success");
	var table_no=document.getElementById('modTabCont').innerHTML;
	order_no=document.getElementById('modOrderCont').innerHTML;
	//var seatno=document.getElementById('sno'+orderNo).value;
	//alert(table_no+':'+order_no+':'+itcatId);
	//enblPayByCashButton();
	//enblPayByCardButton();
	//enblPayByOnlineButton();
	if(table_no=='0' && itcatId!='')
		{
		var option =document.getElementsByName("instantpayOption");
		var setOption=null;
		for(var i = 0; i < option.length; i++) {
			   if(option[i].checked == true) {
				   selOption = option[i].value;
			   }
			 }
		//document.getElementById('hidinstantPaymentType').value=selOption;
		//document.getElementById('hidinstantPaymentFlag').value="Y";
		location.href=BASE_URL+'/order/vieworders.htm?ono='+order_no+'&tno='+table_no+'&sno=0'+'&itcno='+itcatId+'&flg=Y&ptype='+selOption;
		}
	else if(table_no=='0')
		{
		location.href=BASE_URL+'/order/vieworder.htm?ono='+order_no+'&tno='+table_no+'&sno=0';
		}
	else{
	//	location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
	location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0' ;
	
		//}
}*/
function orderSuccessOK()
{
	//alert("success");
	var table_no=document.getElementById('modTabCont').innerHTML;
	order_no=document.getElementById('modOrderCont').innerHTML;
	var kotPrintValue = $("#kotPrintVal").val();
	var ordernumber1 = document.getElementById('modOrderSuccessStoreBasedOrderCont').innerHTML;
if (kotPrintValue == "Y") {
	 
	/* var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/" + order_no + ".htm", function(res) {
			console.log(res);
			var resoderdet = JSON.parse(res);*/
			
			
			
		     for (var j = 0; j < itemUnique.length; j++) {
					//alert(itemUnique[j]);
					var name = $("#row_" + itemUnique[j]).find('td:eq(1)').text();
					var quantity = $("#qty" + itemUnique[j]).val();
					var itembasedkotflag=$("#row_" + itemUnique[j]).find('td:eq(5)').text();
					//alert("name::"+name +" " + "qty::"+quantity +"itembasedkotflag::"+itembasedkotflag);
					//if (quantity != undefined && (itembasedkotflag== 'Y'|| itembasedkotflag== 'y')) {
					if (quantity != undefined) {
						var rowline = "";
						var starttrline = "<tr>";
						var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>"
								+ name + "</td>";
						var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>"
								+ quantity + "</td>";					
						var endtrline = "</tr>";
						rowline = starttrline + firsttdline + secondtdline + endtrline;
						// alert(rowline);
						var splnoterowline = "";
						// alert(forspNoteData.length);
						for (var i = 0; i < forspNoteData.length; i++) {
							var item = forspNoteData[i];
							var id = item.itemId;
							if (id == itemUnique[j]) {
								var note = decodeURIComponent($(
										'#spnoteinput_' + id).val());
								if (undefined != note && note != "undefined"
										&& note != "") {
									splnoterowline = "";
									var splnotestarttrline = "<tr>";
									var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#"
											+ note + "</td>";
									var splnoteendtrline = "</tr>";
									splnoterowline = splnotestarttrline
											+ firsttdline + splnoteendtrline;
								}
							}
						}
						$("#kotitems").append(rowline + splnoterowline);
					}

				}

				var todayDate = new Date();
				var dateDate = todayDate.getDate();
				var monthMonth = todayDate.getMonth() + 1;
				var yyyy = todayDate.getFullYear();
				var hours = todayDate.getHours();
				var minutes = todayDate.getMinutes();
				var ampm = hours >= 12 ? 'PM' : 'AM';
				hours = hours % 12;
				hours = hours ? hours : 12; // the hour '0' should be '12'
				minutes = minutes < 10 ? '0' + minutes : minutes;
				var strTime = hours + ':' + minutes + ' ' + ampm;
				if (dateDate < 10) {
					dateDate = '0' + dateDate;
				}

				if (monthMonth < 10) {
					monthMonth = '0' + monthMonth;
				}

				todayDate = yyyy + '-' + monthMonth + '-' + dateDate;

				// alert(todayDate);
				document.getElementById('dateTimeValue').innerHTML = todayDate
						+ " " + strTime;
				//document.getElementById('ordValue').innerHTML = ordVal;
				document.getElementById('ordValue').innerHTML = ordernumber1;
				
				var selectedordervalue = document.getElementById('orderType');// new
				var selectedordertype = selectedordervalue.options[selectedordervalue.selectedIndex].innerHTML;// new
				document.getElementById('hdorpercelValue').innerHTML = selectedordertype; // new				
				
				
				
				/*if (currentTable == 0) {
					$("#kottable").hide();
					$("#kothdorpercel").show();
					if (orderType == 'h') {
						$("#hdorpercelValue").text("Home Delivery");
					} else if (orderType == 's') {
						$("#hdorpercelValue").text("Swiggy");
					} else if (orderType == 'z') {
						$("#hdorpercelValue").text("Zomato");
					} else {

					}
				} else {
					$("#kothdorpercel").hide();
					document.getElementById('tblValue').innerHTML = tableNoValue;
				}*/

				itemUnique = "";
				kotPrint();	
		
		
			/*}, null);*/
	
	
		}else{
		if (table_no == '0' && itcatId != '') {
			var option = document.getElementsByName("instantpayOption");
			var setOption = null;
			for (var i = 0; i < option.length; i++) {
				if (option[i].checked == true) {
					selOption = option[i].value;
				}
			}
			
			location.href=BASE_URL+'/order/vieworders.htm?ono='+order_no+'&tno='+table_no+'&sno=0'+'&itcno='+itcatId+'&flg=Y&ptype='+selOption;
			
		} else if (table_no == '0') {
			
			location.href=BASE_URL+'/order/vieworder.htm?ono='+order_no+'&tno='+table_no+'&sno=0';
			} 
		
		else{
			location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0' ;
		}
		
	}

		//}, null);

	
}

function kotPrint() {

	var divToPrint = document.getElementById('kotPrint');
	document.getElementById('removeKotPrint').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.print();
	document.getElementById('removeKotPrint').style.display = 'block';

	newWin.close();

	var table_no = document.getElementById('modTabCont').innerHTML;
	order_no = document.getElementById('modOrderCont').innerHTML;
	// alert(table_no+':'+order_no+':'+itcatId);
	if (table_no == '0' && itcatId != '') {
		var option = document.getElementsByName("instantpayOption");
		var setOption = null;
		for (var i = 0; i < option.length; i++) {
			if (option[i].checked == true) {
				selOption = option[i].value;
			}
		}
		
		location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no
				+ '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId
				+ '&flg=Y&ptype=' + SelectedOption;
	} else if (table_no == '0') {
		
		location.href=BASE_URL+'/order/vieworder.htm?ono='+order_no+'&tno='+table_no+'&sno=0';
		

	} else {
		location.href=BASE_URL+'/order/vieworder.htm?ono='+order_no+'&tno='+table_no+'&sno=0';
	}

}




































function selectOderNo()
{
	var orderNo=document.getElementById('orderNo').value;
	var tabno=document.getElementById('tno'+orderNo).value;

	var seatno=document.getElementById('sno'+orderNo).value;
	
	//alert('select:'+orderNo+':'+tabno+':'+seatno);
	//location.href=BASE_URL+'/order/vieworder.htm?ono='+orderNo+'&tno=0'+'&sno=0';
	
	location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + seatno;


}

function validateCreateOrder()
{
	if(savedOrderItemCount == ""){savedOrderItemCount=0;}// for advance booked order without items
	if(parseInt(savedOrderItemCount)!=0)
	  {
	  if (orderitemdata != null && orderitemdata.length>parseInt(savedOrderItemCount)) {
	   return true;
	  }
	  }
	 else{
	  if (orderitemdata != null && orderitemdata.length>savedOrderItemCount) {
	   return true;
	  }
	 }
	return false;
}


function printBill()
{
	var commBean = {};
	commBean.orderId = document.getElementById('orderNo').value;
	commBean.billPrintReason = $("#printbillreasonId").val();
	$.ajax({
		url : BASE_URL + "/order/updateprintcount.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(commBean),
		success : function(	response,
							JSON_UNESCAPED_UNICODE) {

			console.log(">>>>>> " + response);
		}
	});	
	
	
	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	for (var i = 0; i < forspNoteData.length; i++) {
	   // alert(forspNoteData[i]);
	    //Do something
	}
	 //alert(forspNoteData.toString());
	if (caseValue == "Y") {
		var orderid = document.getElementById('orderNo').value;
		var tableno = document.getElementById('tablenoCont').innerHTML;
		var totalAmt = document.getElementById('subtotalcontId').innerHTML;
		var orderTypeName=document.getElementById('hidnOrderTypeData').value;
		//var serviceTax =document.getElementById('servicetaxcontId').innerHTML;		
		//var vatTax = document.getElementById('vatcontId').innerHTML;
		var serviceTax =  0.0;
		var vatTax = 0.0;
		if(document.getElementById('hidvatTaxVal').value!=0.0)
			{
			vatTax = document.getElementById('vatcontId').innerHTML;
			}
		if(document.getElementById('hidserviceTaxVal').value!=0.0)
			{
			serviceTax =  document.getElementById('servicetaxcontId').innerHTML;
			}
		var grossAmt = document.getElementById('grandtotalcontId').innerHTML;
		var amountPay = document.getElementById('amttopaycontId').innerHTML;
		var discountValue = document.getElementById('discBtnContId').innerHTML;
		var discountTxt = document.getElementById('discPerContId').innerHTML;
		var totItemRate = document.getElementById('totalratecontId').innerHTML;
		if(isNaN(discountValue)){discountValue = "0.00";}
		
//		helloBillPrint();
		if(printbillpapersize=='58.00'){
			//document.getElementById('ordervalue').innerHTML = orderid;
			document.getElementById('ordervalue').innerHTML = storeBasedOrderNumber;
			//document.getElementById('tableNoValue').innerHTML = tableno;
			document.getElementById('tableNoValue').innerHTML = orderTypeName;
			document.getElementById('totalamt').innerHTML = totalAmt;
			document.getElementById('servTax').innerHTML= serviceTax;
			document.getElementById('vatTax').innerHTML = vatTax;
			document.getElementById('grossAmount').innerHTML = grossAmt;
			document.getElementById('amoutToPay').innerHTML = amountPay;
			document.getElementById('discountValue').innerHTML = discountValue;
			document.getElementById('discountTxt').innerHTML =  discountTxt;
			
			
			if(serviceTax > 0.00){
				    $("#totalServiceTax").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax").show();
			}else{
				$("#totalVatTax").hide();
			}
			
			if(discountValue > 0){
				$("#showDiscount").show();
			}else{
				$("#showDiscount").hide();
			}
			//$("#showtableno").hide();
			localPrint();
		}else if(printbillpapersize=='80.00'){
			
			//document.getElementById('ordervalue80px').innerHTML = orderid;
			document.getElementById('ordervalue80px').innerHTML = storeBasedOrderNumber;
			//document.getElementById('tableNoValue80px').innerHTML = tableno;
			document.getElementById('tableNoValue80px').innerHTML = orderTypeName;
			//document.getElementById('totalamt80px').innerHTML = totalAmt;
			document.getElementById('totalamt80px').innerHTML = parseFloat(totItemRate).toFixed(2);
			document.getElementById('servTax80px').innerHTML= serviceTax;
			document.getElementById('vatTax80px').innerHTML = vatTax;
			document.getElementById('grossAmount80px').innerHTML = grossAmt;
			document.getElementById('amoutToPay80px').innerHTML = amountPay;
			document.getElementById('discountValue80px').innerHTML = discountValue;
			document.getElementById('discountTxt80px').innerHTML =  discountTxt;
			
			
			
			
			if(serviceTax > 0.00){
				    $("#totalServiceTax80px").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax80px").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax80px").show();
			}else{
				$("#totalVatTax80px").hide();
			}
			
			if(discountValue > 0){
				$("#showDiscount80px").show();
			}else{
				$("#showDiscount80px").hide();
			}
			//$("#showtableno80px").hide();		
			localPrint80px();
			
		} else if(printbillpapersize=='2100.00'){
			var customerstate='';
			var orderno1='';
			if(storeID == "120"){
				orderno1 = storeBasedOrderNumber + "/2019-20";					
			    customerstate=document.getElementById('showdeliveryStateValue_2100px').innerHTML;
			}
			else{
				orderno1 = storeBasedOrderNumber;
			}
			
			var totalItemGross=0.00;
			var totalDisc = 0.00;
			var totalTaxableAmt = 0.00;
			var totalItmVat=0.0;
			var totalItmServ=0.0;
			$('#orderItemTbl tbody tr').each(function() {
				var itmtot=$(this).find("#tbl_orderItemTot").html();
				var itmdisc = $(this).find("#tbl_orderItemDisc").html();
				var itmtaxamt = $(this).find("#tbl_orderItemTaxAmt").html();
				var itmvatamt = $(this).find("#tbl_orderItemVatTaxAmt").html();
				var itmservamt = $(this).find("#tbl_orderItemServiceTaxAmt").html();
				totalItemGross=totalItemGross+ Number(itmtot);
				totalDisc = totalDisc + Number(itmdisc);
				totalTaxableAmt = totalTaxableAmt + Number(itmtaxamt);
				totalItmVat = totalItmVat + Number(itmvatamt);
				totalItmServ = totalItmServ + Number(itmservamt);
				
			});
			grossAmt=Math.round(totalTaxableAmt+Number(totalItmVat)+Number(totalItmServ));//for red onion packaging
			//document.getElementById('ordervalue_2100px_gst').innerHTML = orderid;
			document.getElementById('ordervalue_2100px_gst').innerHTML = orderno1;
			//document.getElementById('tableNoValue_2100px').innerHTML = tableno;
			document.getElementById('tableNoValue_2100px').innerHTML = orderTypeName;
			//document.getElementById('totalamt_2100px_gst').innerHTML = parseFloat(Number(totalAmt)+Number(discountValue)).toFixed(2);
			document.getElementById('totalamt_2100px_gst').innerHTML = parseFloat(totalItemGross).toFixed(2);//red onion packaging
			//document.getElementById('taxableAmount_2100px_gst').innerHTML = totalAmt;
			document.getElementById('taxableAmount_2100px_gst').innerHTML = parseFloat(totalTaxableAmt).toFixed(2);//red onion packaging
			
		
			if(storeID == "120"){
			
			
				if(customerstate == "WB" || customerstate == "wb" || customerstate =="West Bengal" || customerstate == "west bengal" || customerstate =="WestBengal" || customerstate == "westbengal" ||  customerstate == "WESTBENGAL" || customerstate == "WEST BENGAL"){
					document.getElementById('servTax_2100px_gst').innerHTML= parseFloat(totalItmServ).toFixed(2);//serviceTax;
					document.getElementById('totservTax_2100px_gst').innerHTML= parseFloat(totalItmServ).toFixed(2);//serviceTax;
					document.getElementById('totvatTax_2100px_gst').innerHTML =parseFloat(totalItmVat).toFixed(2); //vatTax;
					document.getElementById('vatTax_2100px_gst').innerHTML =parseFloat(totalItmVat).toFixed(2); //vatTax;
				}else{
					
					document.getElementById('servTax_2100px_gst').innerHTML= 0.00;
					document.getElementById('vatTax_2100px_gst').innerHTML = 0.00;
					document.getElementById('igst_2100px_gst').innerHTML = Number(totalItmServ)+Number(totalItmVat);//Number(serviceTax)+Number(vatTax);
					document.getElementById('totservTax_2100px_gst').innerHTML= parseFloat(totalItmServ).toFixed(2);//serviceTax;
					document.getElementById('totvatTax_2100px_gst').innerHTML = parseFloat(totalItmVat).toFixed(2);//vatTax;					
					document.getElementById('totigst_2100px_gst').innerHTML =  Number(totalItmServ)+Number(totalItmVat);//Number(serviceTax)+Number(vatTax);
					
				}
				
			}
			else{ 
				document.getElementById('servTax_2100px_gst').innerHTML= parseFloat(totalItmServ).toFixed(2);//serviceTax;
			    document.getElementById('vatTax_2100px_gst').innerHTML=parseFloat(totalItmVat).toFixed(2); //vatTax;
				document.getElementById('totservTax_2100px_gst').innerHTML=parseFloat(totalItmServ).toFixed(2); //serviceTax;				
				document.getElementById('totservTax_2100px_gst').innerHTML=parseFloat(totalItmServ).toFixed(2); //serviceTax;
				document.getElementById('totvatTax_2100px_gst').innerHTML =parseFloat(totalItmVat).toFixed(2); //vatTax;
				
			}
			
			//newly added
			var paidAmt=document.getElementById('hidpaidAmtVal').value;
			//document.getElementById('totservTax_2100px_gst').innerHTML= serviceTax;
			//document.getElementById('totvatTax_2100px_gst').innerHTML = vatTax;
			document.getElementById('grossAmount_2100px').innerHTML = parseFloat(grossAmt).toFixed(2);
			document.getElementById('totgrossAmount_2100px_gst').innerHTML =  parseFloat(grossAmt).toFixed(2);
			//document.getElementById('amoutToPay1_2100px').innerHTML = parseFloat(amountPay).toFixed(2);
			document.getElementById('amoutToPay1_2100px').innerHTML = parseFloat(Number(grossAmt-paidAmt)).toFixed(2);//for red onion packaging
			//document.getElementById('discountValue_2100px').innerHTML = discountValue;
			document.getElementById('discountValue_2100px').innerHTML = parseFloat(totalDisc).toFixed(2);//for red onion packaging
			document.getElementById('discountTxt_2100px').innerHTML =  discountTxt;
			
			
			
			
		
		/*	if(amountPay == '0.0'){
				document.getElementById('amoutToPay_2100px').innerHTML = grossAmt;
			}
			else{
				document.getElementById('amoutToPay_2100px').innerHTML = amountPay;
			}
			*/
			document.getElementById('paidAmount1_2100px').innerHTML =  parseFloat(paidAmt).toFixed(2);//parseFloat(Number(grossAmt) - Number(grossAmt)).toFixed(2); //new added 10.5.2018
			
			//document.getElementById('igst_2100px_gst').innerHTML= Number(serviceTax) + Number(vatTax);
			//document.getElementById('totigst_2100px_gst').innerHTML= Number(serviceTax) + Number(vatTax);
			
			//$("#discountValue_2100px_gst").text(parseFloat(discountValue).toFixed(2));
			$("#discountValue_2100px_gst").text(parseFloat(totalDisc).toFixed(2));//for red onion packaging
			
			var word = number2text(grossAmt);
			
			$("#grossAmount_2100px_word_gst").text(word);
			
			
			/*if(serviceTax > 0.00){
				    $("#totalServiceTax_2100px").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax_2100px").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax_2100px").show(); 
			}else{
				$("#totalVatTax_2100px").hide();
			}*/
			
			if(discountValue > 0){
				$("#showDiscount_2100px").show();
			}else{
				$("#showDiscount_2100px").hide();
			}
			
			
			
			
			if(storeID == "120"){
				if(customerstate == "WB" || customerstate == "wb" || customerstate == "West Bengal" || customerstate == "west bengal" || customerstate == "WestBengal" || customerstate == "westbengal" ||  customerstate == "WESTBENGAL" || customerstate == "WEST BENGAL"){					
					 if(serviceTax > 0.00){
						    $("#totservTax_2100px_gst").show();
					       }else{
						    //$("#totalServiceTax").addClass('hide');
						    $("#totservTax_2100px_gst").hide();
					        }
				        	if(vatTax > 0){
						    $("#totvatTax_2100px_gst").show();
					       }else{
						      $("#totvatTax_2100px_gst").hide();
					       }
				}
				else{
					$("#totvatTax_2100px_gst").hide();
					$("#totservTax_2100px_gst").hide();
					$("#totigst_2100px_gst").show();
					
			     	}
			}
			else{
				
				if(serviceTax > 0.00){
				    $("#totalServiceTax_2100px").show();
			       }else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax_2100px").hide();
			        }
		        	if(vatTax > 0){
				    $("#totalVatTax_2100px").show();
			       }else{
				      $("#totalVatTax_2100px").hide();
			       }
				
			}
			
			
			//$("#showtableno_2100px").hide();
			localPrint_2100px();
		}
		
	} else{
	var orderid=document.getElementById('orderNo').value;
	//var tableno=document.getElementById('tablenoCont').innerHTML;
	if(orderid==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid  + ".htm", function(response) {
			try{
				if(response=='Success')
					showBillPrintSuccessModal();
				
			}catch(e)
			{alert(e);}
			}, null);
		}
	}
}




function localPrint() {

	var divToPrint = document.getElementById('localPrint');
	document.getElementById('removePrint').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint').style.display = 'block';
	
	newWin.close();

}

function localPrint80px() {

	var divToPrint = document.getElementById('localPrint80px');
	document.getElementById('removePrint80px').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint80px').style.display = 'block';
	
	newWin.close();

}

function localPrint_2100px() {	
	

	var divToPrint = document.getElementById('localPrint_2100px_GST');
	document.getElementById('removePrint_2100px').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint_2100px').style.display = 'block';
	
	newWin.close();

}





function printPaidBill(orderid)
{
	var caseValue =  $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	
	//alert("in ptintpaidbill:"+caseValue + printbillpapersize);
//	alert("<< storeID >> "+storeID+"<< caseValue >> "+caseValue+"<< printbillpapersize >> "+printbillpapersize+"<< orderid >> "+orderid);
	var order = {};
//	var orderId = document.getElementById('orderNo').value;
	order.id = orderid;
	order.storeId = storeID;
//	alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
	var ajaxCallObject = new CustomBrowserXMLObject();

	if (caseValue == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			async: false,
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				//console.log("jsonObj" + response);
				//alert("response"+response);
				console.log(response);
				var orderNo = jsonObj.id;
				var storeBaseOrderNumber = jsonObj.orderNo;
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
				var remark= jsonObj.remarks;
				var packnotes= jsonObj.specialNote;
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
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				//alert(orderTypeOfOrder);
				 //alert("subToatlAmt::"+subToatlAmt);
                 //alert("customerDiscount::"+customerDiscount);
                 //alert("discPercentage::"+discPercentage);
                 //alert("grossAmt::"+grossAmt);
                 //alert("roundOffAmt::"+roundOffAmt);
                 var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
                 //alert("afterdiscount::"+afterdiscount);
                 
                 
                 
				if (printbillpapersize == '58.00') {

					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeName58').text(customerName);
					$('#storeAddr58').text(storeAddr);
					$('#storeEmail58').text(customerEmail);
					$('#storePhNo58').text(customerPhNo);
					//$('#orderValue58').text(orderNo);
					$('#orderValue58').text(storeBaseOrderNumber);
					//$('#tableNoValue58').text(tabNo);
					$('#tableNoValue58').text(orderTypeOfOrder);

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						// alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

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

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount58').text(paidAmt);

						$('#tenderAmount58').text(tenderAmt);
						$('#refund_amount_58px').text(Math.floor(returnAmt * 100) / 100);
						$('#payType_58').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount58').text(paidAmt);
						$('#tenderAmount58').text(tenderAmt);
						$('#refundAmount58').text("0.00");
						$('#payType58').text(type1 + type2);
					}

					//	$('#helloPrintModal58').modal('show');	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal58();
						}
					}

					if (paymentsObj == 2) {
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							printCashOrCardLocal58();
						}
					}

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
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate80").text(y + "-" + m + "-" + d);
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var itemhsn=item1.item.code;
						if(itemhsn==undefined){itemhsn="";}

						//alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

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

					var paymentsObj = jsonObj.payments.length;
					//alert("paymentsObj:::"+paymentsObj);
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text(Math.floor(returnAmt * 100) / 100);
						$('#payType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text("0.00");
						$('#payType80').text(type1 + type2);
					}

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
					
					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal80();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal80();
						}
					}

				}else if(printbillpapersize == '2100.00'){
					
					//alert("printbillpapersize 2 >> "+printbillpapersize);
					/*var ordertypeid = 	document.getElementById('orderType');
					var ordertypename = ordertypeid.options[ordertypeid.selectedIndex].innerHTML;*/
					
					if(storeID == "120"){
						//orderNo = orderNo + "/2018-19";
						storeBaseOrderNumber = storeBaseOrderNumber + "/2019-20";
					}
					
					var tottaxamt=0.0;
					$('#storeName2100').text(customerName);
					$('#storeAddr2100').text(storeAddr);
					$('#storeEmail2100').text("Email :"+customerEmail);
					$('#storePhNo2100').text("Ph :"+customerPhNo);
					//alert(customerPhNo);
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
					if(storeID == "168"){
					 $('#cashOrderDeliveryBoy_GST').text(delivaryboy);
					}
					$('#customerDiscpercentage').text(parseFloat(discPercentage).toFixed(2)); // for display discount percentage
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate_GST").text(y + "-" + m + "-" + d);
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					 var itmTOT=0.0;
					 var itmTOTDisc=0.0;
					 var itmTOTCGST=0.0;
					 var itmTOTSGST=0.0;
					 var itmTOTIGST=0.0;
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
						
						totTaxable = totTaxable + Number(itemTaxableAmt);
						itmTOT=itmTOT+ Number(itemTotalAmt);
						itmTOTDisc=itmTOTDisc+ Number(itemDisc);
						itmTOTCGST=itmTOTCGST+ Number(cgstAmt);
						itmTOTSGST=itmTOTSGST+ Number(sgstAmt);
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
								
								itmTOTIGST=itmTOTIGST+ Number(igstAmt);
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

						if(storeID == '168'){
						    createdrowline1 = startTrline1 + sl_no + firstTdline   + secondTdline  + thirdTdline + fourthTdline + disc_clm  + endTrline1;
						}else{
							createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;
								
						}
						
						
						
						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr style='border-top: 1px dashed;'>";
					if(storeID == '168'){
						var blank_clm1 = "<td></td><td></td><td></td>";
					}else{
						var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";					
					}
					
					var total_txt = "<td><b>Total:</b></td>";
					//var total_amt_clm = "<td>"+parseFloat(subToatlAmt).toFixed(2)+"</td>";
					var total_amt_clm = "<td>"+parseFloat(itmTOT).toFixed(2)+"</td>";//for red onion packaging
					//var total_disc_clm = "<td>" + parseFloat(totalDiscount).toFixed(2) + "</td>";
					//var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					var total_disc_clm = "<td>" + parseFloat(itmTOTDisc).toFixed(2) + "</td>";//for red onion packaging
					//var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";
					//var total_taxable_clm = "<td>" + parseFloat(afterdiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";//for red onion packaging
					
					if(storeID == '120'){ 
					    if(state=='WB' || state=='wb' || state=='West Bengal' || state=='west bengal' || state=='westbengal' || state=='WestBengal' || state=='WEST BENGAL' || state=='WESTBENGAL'){
					    	var blank_clm2 = "<td></td>";
							//var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
							var total_cgstAmt_clm = "<td>" + parseFloat(itmTOTCGST).toFixed(2) + "</td>";//for red onion packaging
							var blank_clm3 = "<td></td>";
							//var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
							var total_sgstAmt_clm = "<td>" + parseFloat(itmTOTSGST).toFixed(2) + "</td>";//for red onion packaging
							var blank_clm4 = "<td></td>";
							var total_igstAmt_clm = "<td></td>";
						  }
					    else{
					        //tottaxamt = Number(vatAmt) + Number(serviceTaxAmt);
					    	tottaxamt = Number(itmTOTCGST) + Number(itmTOTSGST);//for red onion packaging
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
						//var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
						var total_cgstAmt_clm = "<td>" + parseFloat(itmTOTCGST).toFixed(2) + "</td>";//for red onion packaging
						var blank_clm3 = "<td></td>";
						//var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
						var total_sgstAmt_clm = "<td>" + parseFloat(itmTOTSGST).toFixed(2) + "</td>";//for red onion packaging
						var blank_clm4 = "<td></td>";
						var total_igstAmt_clm = "<td></td>";
					   }
					
					
					var endTrline2 = "</tr>";

					if(storeID == '168'){
						createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm + endTrline2;
						
					}else{
						createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm + total_taxable_clm + blank_clm2 + total_cgstAmt_clm + blank_clm3 + total_sgstAmt_clm + blank_clm4 + total_igstAmt_clm + endTrline2;
					  }
					
					
					
					
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

					grossAmt=Math.round(totTaxable+Number(itmTOTCGST)+Number(itmTOTSGST));//for red onion packaging
					$("#cashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					
					
					
					//$("#cashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$("#cashvatTax2100px_gst").text(parseFloat(itmTOTCGST).toFixed(2));//for red onion packaging
					//$('#cashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					$('#cashservTax2100_gst').text(parseFloat(itmTOTSGST).toFixed(2));//for red onion packaging
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
					if(remark==undefined){remark="";}
					$("#remarks_2100px_gst").text(''+remark+'');
					
					
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
					$("#paymentmode_paidbill_2100px").text(paymentmode);
					
					
					
					
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text("0.00");
						$('#payType2100').text(type1 + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** */
					
					/* ********** START PACKAGE ITEM DETAILS PRINT ********** */
					$("#packageContId").html('');
						if(jsonObj.packingitem.length>0)
							{
							if(packnotes==undefined){packnotes="";}
							$("#packageContId").html('');
							var firstDiv="<div style='color: #000000; height: 50px;margin-top:50px;'>........................................................................................................................................................................................................................................................................................................................................</div>";
							var labelDiv="<div style='color: #000000; height: 20px;'>Packaging Details(Refundable)</div>"
							var packNoteDiv="<div style='font-size: 15px; color: black; margin-top: 5px;height: 20px;'>Packaging Narration:"+packnotes+"</div>"
							var starttablehtml="<table style='color: #000000; height: 50px; width: 100%;border-collapse: collapse;'><thead>"
							var thead="<thead>"+
									"<tr style='border-bottom: 1px dashed;'>"+
									"<th width='10%;'>SNo</th>"+
									"<th style='font-size: 15px;'><span style='font-family: sans-serif;'>ITEM NAME</span></th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>UNIT</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>QTY</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>RATE</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>TOTAL</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>DISC</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>TAXABLE</th>"+
									"<th style='text-align: center; font-size: 15px;font-family: sans-serif;'>TAX</th></tr></thead><tbody>"
							var endtablehtml="</table>"
							//$("#packageContId").append(labelDiv+starttablehtml+thead);
							 var totTaxable = 0.0;
							 var itmTOT=0.0;
							 var itmTOTDisc=0.0;
							 var itmTOTCGST=0.0;
							 var itmTOTSGST=0.0;
							 var createdrowline1="";
							for ( var k = 0; k < jsonObj.packingitem.length; k++) {
								
								var item1 = jsonObj.packingitem[k];

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
								
								totTaxable = totTaxable + Number(itemTaxableAmt);
								itmTOT=itmTOT+ Number(itemTotalAmt);
								itmTOTDisc=itmTOTDisc+ Number(itemDisc);
								itmTOTCGST=itmTOTCGST+ Number(cgstAmt);
								itmTOTSGST=itmTOTSGST+ Number(sgstAmt);
								var createdrowline = "";
								var startTrline1 = "<tr>";
								var firstTdline = "<td style='padding: 1px; text-align: center;'>" + itemName + "</td>";
								var secondTdline = "<td style='padding: 1px; text-align: center;'>" + itemQty + "</td>";
								var thirdTdline = "<td style='padding: 1px; text-align: center;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
								var fourthTdline = "<td style='padding: 1px; text-align: center;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
								var unit_clm = "<td style='padding: 1px; text-align: center;'>" + itemUnit + "</td>";
								var disc_clm = "<td style='padding: 1px; text-align: center;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
								var taxable_clm = "<td style='padding: 1px; text-align: center;'>" + parseFloat(itemTaxableAmt).toFixed(2) + "</td>";
								var tax_clm="<td style='padding: 1px; text-align: center;'>" + parseFloat(cgstAmt+sgstAmt).toFixed(2) + "</td>";
								
								var sl_no = "<td style='padding: 1px; text-align: center;'>"+(k+1)+"</td>";
								
								var endTrline1 = "</tr>";
								createdrowline = startTrline1 + sl_no + firstTdline + unit_clm + secondTdline + thirdTdline + fourthTdline + disc_clm + taxable_clm + tax_clm + endTrline1;
							
								
								createdrowline1=createdrowline1+createdrowline;
								}
								var createdrowline2="";
								var startTrline2 = "</tbody><tfoot style='display: table-row-group'><tr style='border-top: 1px dashed;'>";
								var blank_clm1 = "<td></td><td></td><td></td><td></td>";					
								var total_txt = "<td style='text-align:center;font-weight: bold;'><b>Total:</b></td>";
								var total_amt_clm = "<td style='text-align:center;font-weight: bold;'>"+parseFloat(itmTOT).toFixed(2)+"</td>";
								var total_disc_clm = "<td style='text-align:center;font-weight: bold;'>" + parseFloat(itmTOTDisc).toFixed(2) + "</td>";
								var total_taxable_clm = "<td style='text-align:center;font-weight: bold;'>" + parseFloat(totTaxable).toFixed(2) + "</td>";
								var total_tax_clm="<td style='text-align:center;font-weight: bold;'>" + parseFloat(itmTOTCGST+itmTOTSGST).toFixed(2) + "</td>";
								var endTrline2 = "</tr></tfoot>";
								createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm + total_taxable_clm + total_tax_clm + endTrline2;
								
								
								$("#packageContId").append(firstDiv+labelDiv+packNoteDiv+starttablehtml+thead+createdrowline1+createdrowline2+endtablehtml);
							}
					/* ********** END PACKAGE ITEM DETAILS PRINT ********** */

					if (paymentsObj == 1) {
						
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {
						
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal2100();
						}
					}
				}

			}
		});

	} else {
	//	var orderid = document.getElementById('orderNo').value;

			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();
					
				}catch(e)
				{alert(e);}
				}, null);
			
		
	}
}

function printKotCheckList()
{
	var orderid=document.getElementById('orderNo').value;
	//var tableno=document.getElementById('tablenoCont').innerHTML;
	if(orderid==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else
	{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/printkotchecklist/"+orderid  + ".htm", function(response) {
		try{
			if(response=='Success')
				showKotCheckListPrintSuccessModal();
			}catch(e)
		{alert(e);}
		}, null);
	}
}
function showDirectPaymentforPacel()
{
	var tableno=document.getElementById('tablenoCont').innerHTML;
	if(tableno=='0')
	{
		//for saravanaa
	//showparcelPaymentModal();
	}
}
function parcelPayment()
{
	var option =document.getElementsByName("parcelpayOption");
	var payOption=null;
	for(var i = 0; i < option.length; i++) {
		   if(option[i].checked == true) {
			   payOption = option[i].value;
		   }
		 }
	if(payOption=='cash')
		{openCashModal();}
	else{openCardModal();}
}
var pmntTotAmt=document.getElementById('grandtotalcontId').innerHTML;
var netPrice=document.getElementById('amttopaycontId').innerHTML;
var netTotal=0.0;
var hidstoreroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
var storedoubleroundoffflag=document.getElementById('hidstoredoubleroundoffFlag').value;
var paidAmnt=0.0;
var amntToPay=0.0;
function openCashModal()
{
	netTotal=document.getElementById('hidnetTotal').value;
	document.getElementById('cashtenderAmt').value='';
	document.getElementById('paycashalertMsg').innerHTML='';
	document.getElementById('cashchangeamtcontId').innerHTML='0.00';
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
	if(orderno==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else
	{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				paidAmnt=temppaidAmt;
				if(hidstoreroundoffflag=='Y')
				{
				netTotal=Math.round(netTotal);
				}
				if(storedoubleroundoffflag=='Y')
				{
				netTotal=round(netTotal,1);
				}
				amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
				document.getElementById('cashmodOrderCont').innerHTML=orderno;
				document.getElementById('cashmodStoreBasedOrderNumberCont').innerHTML=storeBasedOrderNumber;
				document.getElementById('cashmodTabCont').innerHTML=tableno;
				document.getElementById('cashtotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cashpaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('cashamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				if(printpaidBill=='N')
					{document.getElementById('chkprintBillCash').checked=false;}
				showCashModal();

			}catch(e)
			{
				alert(e);
			}
			}, null);
		
	}		
}



function getChangeAmt(tenderAmt)
{
	if(tenderAmt=='')
		{
		document.getElementById('cashchangeamtcontId').innerHTML='0.00';
		}
	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
		{
			document.getElementById('cashchangeamtcontId').innerHTML='0.00';
		}
	else
		{
			document.getElementById('cashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
			// for vfd
			if(vfdPort.length>3)
			{
				var changeAmt=tenderAmt-netTotal;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/" +"TOT IN RM : " + parseFloat(amntToPay).toFixed(2) + "/"+"BAL IN RM : " + parseFloat(changeAmt).toFixed(2)+".htm", function() {
					}, null);
			}
			
		}
}
function openCardModal()
{
	netTotal=document.getElementById('hidnetTotal').value;
	document.getElementById('paycardalertMsg').innerHTML='';
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
	if(orderno==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else
	{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				paidAmnt=temppaidAmt;
				if(hidstoreroundoffflag=='Y')
					{
					netTotal=Math.round(netTotal);
					}
				if(storedoubleroundoffflag=='Y')
				{
				netTotal=round(netTotal,1);
				}
				amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
				document.getElementById('cardmodOrderCont').innerHTML=orderno;	
				document.getElementById('cardmodStoseBasedOrderCont').innerHTML=storeBasedOrderNumber;	
				document.getElementById('cardmodTabCont').innerHTML=tableno;
				document.getElementById('cardtotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cardpaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('cardamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('cardtenderAmt').value=parseFloat(amntToPay).toFixed(2);
				if(printpaidBill=='N')
				{document.getElementById('chkprintBillCard').checked=false;}
				showCardModal();
			}catch(e)
			{
				alert(e);
			}
			}, null);
	
	}		
}

function checkCardType(cardType)
{
	if(cardType=='Visa')
		{
		document.getElementById('cardTypeName').value=cardType;
		document.getElementById('cardTypeNameDiv').style.display='none';
		}
	if(cardType=='Master')
		{
		document.getElementById('cardTypeName').value=cardType;
		document.getElementById('cardTypeNameDiv').style.display='none';
		}
	if(cardType=='Other')
		{
		document.getElementById('cardTypeName').value="";
		document.getElementById('cardTypeNameDiv').style.display='block';
		}
	
}
function openOnlineModal()
{
	netTotal=document.getElementById('hidnetTotal').value;
	document.getElementById('paycardalertMsg').innerHTML='';
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
	if(orderno==0 || forspNoteData.length>0)
	{
		showalertsaveorderModal();
	}
	else
	{
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymenttypebystore.htm", function(response) {
			var parseresponse = JSON.parse(response);
			try{
				//console.log("getpaymenttypebystore="+response);
				if('null'==response){
					$("#notavailableonlinepaymentModal").modal("show");
				}else if(0 == parseresponse.size){
					$("#notavailableonlinepaymentModal").modal(
					"show");
				}else{
				var responseObjpaymenttype=JSON.parse(response);
				if(responseObjpaymenttype.size==1){
					ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
						try{
							var responseObj=[];
							responseObj=JSON.parse(response);
							for(var i=0;i<responseObj.length;i++)
							{
								temppaidAmt+=responseObj[i].paidAmount;
							}
							paidAmnt=temppaidAmt;
							if(hidstoreroundoffflag=='Y')
								{
								netTotal=Math.round(netTotal);
								}
							if(storedoubleroundoffflag=='Y')
							{
							netTotal=round(netTotal,1);
							}
							amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
							document.getElementById('onlinemodOrderCont').innerHTML=orderno;
							document.getElementById('onlineStoreBasedmodOrderCont').innerHTML=storeBasedOrderNumber;
							document.getElementById('onlinemodTabCont').innerHTML=tableno;
							document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
							document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
							document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
							document.getElementById('onlinetenderAmt').value=parseFloat(amntToPay).toFixed(2);
							$("#selpaymentmode").val(responseObjpaymenttype.paymentTypes[0].paymentTypeName+"_"+responseObjpaymenttype.paymentTypes[0].id);
							if(printpaidBill=='N')
							{document.getElementById('chkprintBillonline').checked=false;}
							$("#onlineModal").modal("show");
						}catch(e)
						{
							alert(e);
						}
						}, null);
				}else{
//					alert("size="+responseObj.size);
					var createdrowline="";
					var begintable="<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
					var endtable="</table>";
					
					for(var j=0;j<responseObjpaymenttype.paymentTypes.length;j++)
					{
						var begintr="<tr style='background:#404040; color:#FFF;'>";
//						var firsttd="<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"+responseObjpaymenttype.paymentTypes[j].id+"'/></td>";
						var firsttd="<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"+responseObjpaymenttype.paymentTypes[j].paymentTypeName+"_"+responseObjpaymenttype.paymentTypes[j].id+"'/></td>";
						var secondtd="<td>"+responseObjpaymenttype.paymentTypes[j].paymentTypeName+"</td>";
						var endtr="</tr>";
						createdrowline+=begintr+firsttd+secondtd+endtr;
					}
					
					$("#paymodeselectiondiv").html(begintable+createdrowline+endtable);
					$("#paymodeselectionModal").modal("show");
				}
			}
			}catch(e)
			{
				alert(e);
			}
			}, null);
	}		
}
function getSelectedPaymentTypeval(){
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	//console.log("selectedPaymentType="+selectedPaymentType);
}
function getpaymod(){
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	if(selectedPaymentType==undefined){
		$("#paymodeselectiontext").text("Please select one option.");
	}else{
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		netTotal=document.getElementById('hidnetTotal').value;
		document.getElementById('paycardalertMsg').innerHTML='';
		var orderno=document.getElementById('orderNo').value;
		var tableno=document.getElementById('tablenoCont').innerHTML;
		var temppaidAmt=0.0;
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				paidAmnt=temppaidAmt;
				if(hidstoreroundoffflag=='Y')
					{
					netTotal=Math.round(netTotal);
					}
				if(storedoubleroundoffflag=='Y')
				{
				netTotal=round(netTotal,1);
				}
				amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
				document.getElementById('onlinemodOrderCont').innerHTML=orderno;
				document.getElementById('onlineStoreBasedmodOrderCont').innerHTML=storeBasedOrderNumber;
				document.getElementById('onlinemodTabCont').innerHTML=tableno;
				document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('onlinetenderAmt').value=parseFloat(amntToPay).toFixed(2);
				document.getElementById('onlineselpaymenttype').innerHTML=selectedPaymentType.split("_")[0];
				$("#selpaymentmode").val(selectedPaymentType);
				
				if(printpaidBill=='N')
				{document.getElementById('chkprintBillonline').checked=false;}
				$("#onlineModal").modal("show");
			}catch(e)
			{
				alert(e);
			}
			}, null);
	}
}
function payByCash(tenderAmt)
{
	var caseValue = $("#mobPrintVal").val();
    netTotal=document.getElementById('hidnetTotal').value;
	var orderno=document.getElementById('orderNo').value;
	//alert(printpaidBill + "" + caseValue);
	if (isNaN(tenderAmt) || tenderAmt=='')
	{
	//alert('Please eneter a valid number!');
	document.getElementById('paycashalertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('cashtenderAmt').focus();
	}
	else
	{
		dsblPayByCashButton();
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
		if(storedoubleroundoffflag=='Y')
		{
		netTotal=round(netTotal,1);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+"cash"+"/"+"000" + ".htm", function(response) {
			try{
				if(response=='success')
					{
				//	alert(" printpaidBill >> "+ printpaidBill);
					//alert(" caseValue >> "+ caseValue);
					var alrdypaid=0.0;
					alrdypaid=document.getElementById('hidpaidAmtVal').value;
					document.getElementById('hidpaidAmtVal').value=parseFloat(alrdypaid)+parseFloat(paidAmnt);
					enblPayByCashButton();
					if(printpaidBill=='N')
					{
						if(document.getElementById('chkprintBillCash').checked==true)
							{
							//alert('print cash');
							//printPaidBill(orderno);
							if (caseValue == 'Y') {
							//	cashOrcardPrintBill();
								//alert("print call");
								printPaidBill(orderno);
								
							} else { 
								
								var ajaxCallObject = new CustomBrowserXMLObject();
								ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
								}, null);	
							}
						
							//alert(orderno);
							}
						
					}
					else
						{
					
						if (caseValue == 'Y') {
							//	cashOrcardPrintBill();
								
								//location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
								printPaidBill(orderno);
							}
						}
					//alert("amntToPay" + amntToPay);
					//alert("itcatId" + itcatId);
					
					if(amntToPay>0)
					{
						document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
						hideCashModal();	
					}
					else
						{
						if(document.getElementById('cashmodTabCont').innerHTML=='0' && itcatId!='')
							{
							location.href=BASE_URL+'/order/vieworders.htm?ono=0&tno=0&sno=0'+'&itcno='+itcatId+'&flg=N&ptype=';
							}
						else{
							hideCashModal();

							if(cdrawerCode.length>0)
								{
								//hideCashModal();
								var toPay=document.getElementById('cashamttopaycontId').innerHTML;
								var changeAmt=parseFloat(parseFloat(tenderAmt)-parseFloat(toPay)).toFixed(2);
								//document.getElementById('cashchangeamtmodcontId').innerHTML=document.getElementById('cashchangeamtcontId').innerHTML;
								document.getElementById('cashamttopaymodcontId').innerHTML=parseFloat(toPay).toFixed(2);
								document.getElementById('cashtenderAmtmodcontId').innerHTML=parseFloat(tenderAmt).toFixed(2);
								document.getElementById('cashchangeamtmodcontId').innerHTML=parseFloat(changeAmt).toFixed(2);
								showCashChangeAmtModal();
								}
							else{
								//alert('hi hi');
								location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
								}

							}
						}
					}
				    if(response == 'alreadypaid'){
				    	enblPayByCashButton();
						$('#cashModal').modal('hide');
						document.getElementById('alreadypaidmsg').innerHTML = "Already Paid!!";
						$('#alertalreadypaidModal').modal('show');
						
					}
				}catch(e){alert(e);}
			}, null);
	}
}
function payByCard(tenderAmt)
{
	var caseValue = $("#mobPrintVal").val();
	netTotal=document.getElementById('hidnetTotal').value;
	var orderno=document.getElementById('orderNo').value;
//	var lastfourdigit=document.getElementById('cardlastfourDigit').value;
	var lastfourdigit='1234';
	var cardType=document.getElementById('cardTypeName').value;
	
	if(isNaN(tenderAmt)|| tenderAmt=='')
	{
		document.getElementById('paycardalertMsg').innerHTML='Please eneter a valid number!';
		document.getElementById('cardtenderAmt').focus();
	}
	else if(cardType=='')
	{
		document.getElementById('paycardalertMsg').innerHTML='Please eneter card type!';
	}
	/*else if(!parseFloat(lastfourdigit))
	{
		document.getElementById('paycardalertMsg').innerHTML='Please enter a valid card number!';
		document.getElementById('cardlastfourDigit').focus();
	}
	else if(lastfourdigit.length!=4)
	{
		//alert('Please enter 4 digit valid card number!');
		document.getElementById('paycardalertMsg').innerHTML='Please enter 4 digit valid card number!';
		document.getElementById('cardlastfourDigit').focus();
	}*/
	
	else
	{
		dsblPayByCardButton();
		if(lastfourdigit=='')
			{
			lastfourdigit='xxxx';
			}
		if(parseFloat(tenderAmt).toFixed(2)>=parseFloat(amntToPay).toFixed(2))
		{
			paidAmnt=parseFloat(amntToPay).toFixed(2);
			amntToPay=0.0;
		}
		else
		{
			paidAmnt=parseFloat(tenderAmt).toFixed(2);
			amntToPay=parseFloat(amntToPay).toFixed(2)-parseFloat(tenderAmt).toFixed(2);
		}
		if(storedoubleroundoffflag=='Y')
		{
		netTotal=round(netTotal,1);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+cardType+"/"+lastfourdigit + ".htm", function(response) {
		try{
			if(response=='success')
				{
				
				enblPayByCardButton();
				var alrdypaid=0.0;
				alrdypaid=document.getElementById('hidpaidAmtVal').value;
				document.getElementById('hidpaidAmtVal').value=parseFloat(alrdypaid)+parseFloat(paidAmnt);
				if(printpaidBill=='N')
				{
					if(document.getElementById('chkprintBillCard').checked==true)
						{
						//alert('print card');
						//printPaidBill(orderno);
						if (caseValue == 'Y') {
						//	cashOrcardPrintBill();
							printPaidBill(orderno);
							
						} else {
							var ajaxCallObject = new CustomBrowserXMLObject();
							ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
								}, null);
							//alert(orderno);
							}
						}
						
					
				}
				else
				{
				
				if (caseValue == 'Y') {
					//	cashOrcardPrintBill();
						
						//location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
						printPaidBill(orderno);
					}
				}
				//alert("amntToPay" + amntToPay);
				//alert("itcatId" + itcatId);
				if(amntToPay>0)
				{
					document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
					hideCardModal();	
				}
				else
					{
					hideCardModal();
						if(document.getElementById('cardmodTabCont').innerHTML=='0' && itcatId!='')
						{
							location.href=BASE_URL+'/order/vieworders.htm?ono=0&tno=0&sno=0'+'&itcno='+itcatId+'&flg=N&ptype=';
						}
						else{
							//alert('hi hi');
							location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
							}
					}
				}
			if(response == 'alreadypaid'){
				enblPayByCardButton();
				$('#cardModal').modal('hide');
				document.getElementById('alreadypaidmsg').innerHTML = "Already Paid!!";
				$('#alertalreadypaidModal').modal('show');
				
			}
			}catch(e){alert(e);}
		}, null);
	}
}
function payByOnline(tenderAmt){
	var caseValue = $("#mobPrintVal").val();
	
	//alert('hi');
	
	netTotal=document.getElementById('hidnetTotal').value;
	var orderno=document.getElementById('orderNo').value;
	var paymentType=$('#selpaymentmode').val();
	if(isNaN(tenderAmt)|| tenderAmt=='')
	{
		document.getElementById('payonlinealertMsg').innerHTML='Please eneter a valid number!';
		document.getElementById('onlinetenderAmt').focus();
	}
	dsblPayByOnlineButton();
	if(parseFloat(tenderAmt).toFixed(2)>=parseFloat(amntToPay).toFixed(2))
	{
		paidAmnt=parseFloat(amntToPay).toFixed(2);
		amntToPay=0.0;
	}
	else
	{
		paidAmnt=parseFloat(tenderAmt).toFixed(2);
		amntToPay=parseFloat(amntToPay).toFixed(2)-parseFloat(tenderAmt).toFixed(2);
	}
	if(storedoubleroundoffflag=='Y')
	{
	netTotal=round(netTotal,1);
	}
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+paymentType.split("_")[0]+"/"+paymentType.split("_")[1] + ".htm", function(response) {
	try{
		if(response=='success')
			{
			
		//	alert(" printpaidBill >> "+ printpaidBill);
			enblPayByOnlineButton();
			var alrdypaid=0.0;
			alrdypaid=document.getElementById('hidpaidAmtVal').value;
			document.getElementById('hidpaidAmtVal').value=parseFloat(alrdypaid)+parseFloat(paidAmnt);
			if(printpaidBill=='N')
			{
				//alert("chkprintBillonline" +printpaidBill);

				if(document.getElementById('chkprintBillonline').checked==true)
					{
					//alert('print card');
					//printPaidBill(orderno);
					if (caseValue == 'Y') {
						printPaidBill(orderno);
						
					}
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
						}, null);
					//alert(orderno);
					}
				
			}
			else
			{
			
			if (caseValue == 'Y') {
				//	cashOrcardPrintBill();
					
					//location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
					printPaidBill(orderno);
				}
			}
			//alert("amntToPay" + amntToPay);
			//alert("itcatId" +itcatId);
			if(amntToPay>0)
			{
				document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				$("#onlineModal").modal("hide");
			}
			else
				{
				$("#onlineModal").modal("hide");

					if(document.getElementById('cardmodTabCont').innerHTML=='0' && itcatId!='')
					{
						location.href=BASE_URL+'/order/vieworders.htm?ono=0&tno=0&sno=0'+'&itcno='+itcatId+'&flg=N&ptype=';
					}
					else{
						location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
						}
				}
			}
		if(response == 'alreadypaid'){
			enblPayByOnlineButton();
			$('#onlineModal').modal('hide');
			document.getElementById('alreadypaidmsg').innerHTML = "Already Paid!!";
			$('#alertalreadypaidModal').modal('show');
			
		}
		}catch(e){alert(e);}
	}, null);
	
}
function openAddDiscount()
{
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	// var totAmt = document.getElementById('grandtotalcontId').innerHTML;

	 var totAmt = document.getElementById('subtotalcontId').innerHTML;
	 var totnonspotDiscAmt = document.getElementById('hidtotnonspotDiscAmt').value; //new
	//alert("totnonspotDiscAmt:"+totnonspotDiscAmt);
	var isnoncharge = 'N';

	if ($('#ncbill').is(':checked')) {
		isnoncharge = 'Y';

	}
	
	
	
	if(orderno==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else{
		document.getElementById('discmodOrderCont').innerHTML=orderno;
		document.getElementById('discmodStoreBasedOrderCont').innerHTML=storeBasedOrderNumber;
	//	document.getElementById('discmodTabCont').innerHTML=tableno;
		document.getElementById('discmodtotamtcontId').innerHTML=totAmt;
		document.getElementById('discmoddiscountableamtcontId').innerHTML = parseFloat(
				totAmt - totnonspotDiscAmt).toFixed(2); //new
		showaddDiscountModal();
	}
	
}
function calculateDiscAmt(per)
{
	var totAmount=document.getElementById('discmodtotamtcontId').innerHTML;
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var discAmt=0.0;
	if(per=='')
	{
	document.getElementById('discModdiscAmt').value='0.00';
	}
	else if(!isNaN(per))
		{
		discAmt=parseFloat(parseFloat(totAmount).toFixed(2)*parseFloat(per).toFixed(2)/100).toFixed(2);
		/*if(storeroundoffflag=='Y'){
			discAmt=Math.round(discAmt);
		}*/
		document.getElementById('discModdiscAmt').value=parseFloat(discAmt).toFixed(2);
		}
}

function AddDiscount() {
	var orderid = document.getElementById('discmodOrderCont').innerHTML;
	var discper = document.getElementById('discModdiscPer').value;
	var discamt = document.getElementById('discModdiscAmt').value;
	var storediscflag = document.getElementById('discmodstorediscFlagcontId').value;
	var storecurrency = document.getElementById('discmodstorecurrencycontId').value;
	var netAmt = document.getElementById('amttopaycontId').innerHTML;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var discreason = $("#discreason").val();
	var isnoncharge = 'N';
	if ($('#ncbill').is(':checked')) {
		discper = 100;
		discamt = document.getElementById('subtotalcontId').innerHTML;// parseFloat(netAmt).toFixed(2);
		isnoncharge = 'Y';
	}
	var nettot = 0.0;

    if(discreason=='')
    	{
    	document.getElementById('discAddalertMsg').innerHTML='Please enter a valid reason!';
    	}
	else if((storediscflag != 'M') && (isNaN(discper) || isNaN(discamt) || discper == '' || discper == '' ))
		{
		document.getElementById('discAddalertMsg').innerHTML='Please enter a valid number!';
		} else if (discper > 100) {
			document.getElementById('discAddalertMsg').innerHTML = 'Please insert discount less than 100%!';
		} else if(discper == 100 && isnoncharge == 'N'){
			document.getElementById('discAddalertMsg').innerHTML ='Please insert discount less than 100%!';
		}else {			
			if(storediscflag == 'M' && discper == '' && discamt != ''){
				//alert("valid");
				discper="0.0";
				
			}				
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/adddiscount/" + orderid + "/" + discper + "/" + discamt + "/" + discreason + "/" + isnoncharge + ".htm", function(response) {
			try {
				if (response == 'success') {
					nettot = netAmt - discamt;
					if (storediscflag == 'Y') {
						document.getElementById('discBtnContId').style.width = '';
					//	document.getElementById('discPerContId').innerHTML = getBaseLang.discount + discper + '%:';
						document.getElementById('discBtnContId').innerHTML = discamt;
						if (storeroundoffflag == 'Y') {
							nettot = Math.round(nettot);
						}
						document.getElementById('amttopaycontId').innerHTML = parseFloat(nettot).toFixed(2);
					} else {
					//	document.getElementById('discPerContId').innerHTML = getBaseLang.discIn + storecurrency + ':';
						document.getElementById('discBtnContId').innerHTML = discamt;
						if (storeroundoffflag == 'Y') {
							nettot = Math.round(nettot);
						}
						document.getElementById('amttopaycontId').innerHTML = parseFloat(nettot).toFixed(2);
					}
					document.getElementById('hidnetTotal').value = nettot;
					
					location.reload();
					closeaddDiscountModal();
				} else {
					document.getElementById('discAddalertMsg').innerHTML = '' + response + '';
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}
}
/*
function AddDiscount()
{
	var orderid=document.getElementById('discmodOrderCont').innerHTML;
	var discper=document.getElementById('discModdiscPer').value;
	var discamt=document.getElementById('discModdiscAmt').value;
	var storediscflag=document.getElementById('discmodstorediscFlagcontId').value;
	var storecurrency=document.getElementById('discmodstorecurrencycontId').value;
	var netAmt=document.getElementById('amttopaycontId').innerHTML;
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var discreason = $("#discreason").val();
	var isnoncharge = 'N';
	if ($('#ncbill').is(':checked')) {
		discper = 100;
		discamt = parseFloat(netAmt).toFixed(2);
		isnoncharge = 'Y';
	}
	var nettot=0.0;
	if(isNaN(discper) || isNaN(discamt))
		{
		document.getElementById('discAddalertMsg').innerHTML='Please enter a valid number!';
		}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/adddiscount/"+orderid+"/"+discper+"/"+discamt  + ".htm", function(response) {
			try{
				if(response=='success')
					{
					nettot=netAmt-discamt;
						if(storediscflag=='Y')
							{
							document.getElementById('discBtnContId').style.width='';
							document.getElementById('discPerContId').innerHTML='Discount '+discper+'%:';
							document.getElementById('discBtnContId').innerHTML=discamt;
							if(storeroundoffflag=='Y')
								{
								nettot=Math.round(nettot);
								}
							document.getElementById('amttopaycontId').innerHTML=parseFloat(nettot).toFixed(2);
							}
						else
							{
							document.getElementById('discPerContId').innerHTML='-Discount in '+storecurrency+':';
							document.getElementById('discBtnContId').innerHTML=discamt;
							if(storeroundoffflag=='Y')
							{
								nettot=Math.round(nettot);
							}
							document.getElementById('amttopaycontId').innerHTML=parseFloat(nettot).toFixed(2);
							}
						document.getElementById('hidnetTotal').value=nettot;
						closeaddDiscountModal();
					}
				else
					{
					document.getElementById('discAddalertMsg').innerHTML=''+response+'';
					}
			}catch(e)
			{alert(e);}
			}, null);
		}
}*/
function totPaidAmount(orderno)
{
	var totPaidAmt=0.0;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
		try{
			var responseObj=[];
			responseObj=JSON.parse(response);
			for(var i=0;i<responseObj.length;i++)
			{
				totPaidAmt+=responseObj[i].paidAmount;
			}
		}catch(e)
		{
			alert(e);
		}
		}, null);
	return totPaidAmt;
}
var selectedRows = [];
function selectAllRow()
{
	var checkboxes = document.getElementsByTagName('input');
	for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].type == 'checkbox') {
            if(checkboxes[i].checked)
            	{
            	}
            else
            	{
            	 checkboxes[i].checked = true;
            	 chkid=checkboxes[i].id;
                 document.getElementById('row_'+chkid.substr(4)).style.background='#ffe4c1';
                 selectedRows.push(chkid.substr(4));
            	}  
        }
    }
}
function selectRow(trId)
{
	if(document.getElementById('chk_'+trId).checked==false)
		{
		document.getElementById('row_'+trId).style.background='#ffe4c1';
		document.getElementById('chk_'+trId).checked=true;
		selectedRows.push(trId);
		}
	else
		{
		document.getElementById('row_'+trId).style.background='#fff';
		document.getElementById('chk_'+trId).checked=false;
		selectedRows.splice(selectedRows.indexOf(trId), 1);
		}
}
function checkRow(trId,chk)
{
	if(chk.checked)
	{
	document.getElementById('row_'+trId).style.background='#ffe4c1';
	selectedRows.push(trId);
	}
else
	{
	document.getElementById('row_'+trId).style.background='#fff';
	selectedRows.splice(selectedRows.indexOf(trId), 1);
	}
}
function deleteRows()
{
	if(selectedRows.length>0)
		{
		showconfirmdeleteOrderItemModal();
		/*var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/deleteitems/"+selectedRows  + ".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareOrderHtml(responseObj);
			}catch(e)
			{
				alert(e);
			}
			}, null);
		selectedRows = [];*/
		}
	else{showselectitemalertModal();}
}
function deleteorderItemRow()
{
	
	for(var i=0;i<selectedRows.length;i++){
		for(var k=0;k<itemRecord.length;k++){
			if(itemRecord[k].itemId == selectedRows[i]){
				itemRecord.splice( itemRecord.indexOf(itemRecord[k]), 1 );
			}
		}
	}
	
	var noofremoveItem=selectedRows.length;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitems/"+selectedRows  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			selectedRows = [];
			prepareOrderHtml(responseObj);
			if(vfdPort.length>3)
			{
				var tot=document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +noofremoveItem+" ITEM(S) REMOVED"  + "/"+"TOT IN RM : " + parseFloat(tot).toFixed(2)+".htm", function() {
					}, null);
			}
		}catch(e)
		{
			alert(e);
		}
		}, null);
	/*selectedRows = [];*/
}
function openpecialNoteModal()
{
	//alert(forspNoteData.length);
	var spnoteitemlistContId=document.getElementById('spnoteitemlistContId');
	var createdtd="";
	if(forspNoteData.length>0)
		{
		for(var i=0;i<forspNoteData.length;i++)
			{
				var item=forspNoteData[i];
				var spnote=item.specialNote==undefined?"":item.specialNote;
				var namediv="<div style='text-align: left;'>"+item.itemName+"</div>";
				var inputdiv="<div style='color: #000'><input type='text' style='width:60%;' value='"+spnote+"' id='spnoteinput_"+item.itemId+"'>&nbsp;&nbsp;<button type='button' onclick='javascript:getspecialNotebyitemId("+item.itemId+",&quot;"+item.itemName+"&quot;);' style='background: #72BB4F;font-weight: bold;height:30px;'  class='btn btn-success'>GET NOTE</button></div>";
				createdtd+=namediv+inputdiv;
			}
		spnoteitemlistContId.innerHTML=createdtd;
		showspecialnoteModal();
		}
	else{
		//alert('Please select any item!');
		showselectitemalertModal();
		}
}
function getspecialNotebyitemId(itemid,itemname)
{
	//alert(itemid);
	var spnotecontId=document.getElementById("specialnoteforOrderContainerId");
	var headeritemname=document.getElementById("headerforitemnamespnote");
	document.getElementById("itemidforsetsplnote").value=itemid;
	var spnoteHtml="";
	var createdrowline="";
	var begintable="<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
	var endtable="</table>";
	headeritemname.innerHTML=itemname;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getspecialnotesbyitemid/"+itemid + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			if(responseObj.length>0)
				{
					for(var i=0;i<responseObj.length;i++)
						{
						var spnote=responseObj[i];
						var begintr="<tr style='background:#404040; color:#FFF;'>";
						var firsttd="<td>"+spnote.menuItem.name+"</td>";
						var secondtd="<td><input type='checkbox' name='specialnote' value='"+spnote.menuItem.name+"'/></td>";
						var endtr="</tr>";
						createdrowline+=begintr+firsttd+secondtd+endtr;
						}
					spnotecontId.innerHTML=begintable+createdrowline+endtable;
				}
			else{spnotecontId.innerHTML="No special note found!";}
			//prepareOrderHtml(responseObj);
		}catch(e)
		{
			alert(e);
		}
		}, null);
	showspecialNoteforOrderModal();
	
}
function setspecialNoteforOrder()
{
	var itemid=document.getElementById("itemidforsetsplnote").value;
	var spclvalue="";
	var selectedspnotefororderRows = [];
	var checkboxes = document.getElementsByName('specialnote');
	for (var i=0; i<checkboxes.length; i++) 
		{
	    	if (checkboxes[i].checked) {
	    		selectedspnotefororderRows.push(checkboxes[i].value);
	    		}
		}
	if(selectedspnotefororderRows.length>0)
		{
		 for(var i=0;i<selectedspnotefororderRows.length;i++)
			 {
			 spclvalue+=selectedspnotefororderRows[i]+",";
			 }
		 
		}
	//closespecialNoteforOrderModal();
	var prevnote=document.getElementById("spnoteinput_"+itemid).value;
	document.getElementById("spnoteinput_"+itemid).value=prevnote+spclvalue;
}
function savespecialNote()
{
	//var spNotes=[];
	//var spnote={};
	for(var i=0;i<forspNoteData.length;i++)
	{
		var item=forspNoteData[i];
		var id=item.itemId;
		var note=decodeURIComponent(document.getElementById('spnoteinput_'+item.itemId).value);
		//alert(id+':'+note);
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/addspecialnote/"+id+"/"+note + ".htm", function() {
			}, null);
	}
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/showspecialnote.htm", function(response) {
		try{
			//alert(response);
			forspNoteData=[];
			var responseObj=JSON.parse(response);
			if(responseObj.length>0){
				for(var i=0;i<responseObj.length;i++)
					{
					var item=responseObj[i];
					forspNoteData.push(item);
					}
				}
		}catch(e){alert(e);}
		}, null);
}

function instantPaymentOpenModal()
{
	//alert('instant');
	var flag=document.getElementById('hidinstantPaymentFlag').value;
	var ptype=document.getElementById('hidinstantPaymentType').value;
	if(flag=='Y')
		{
			if(ptype=='cash')
				{
				openCashModal();
				}
			else{openCardModal();}
		}
}

/*start credit sale*/
function openCreditSaleModal()
{
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	document.getElementById("creditsalemodOrderCont").innerHTML=orderno;
	document.getElementById("creditsalemodStoreBasedOrderCont").innerHTML=storeBasedOrderNumber;
	document.getElementById("creditsalemodTabCont").innerHTML=tableno;
	document.getElementById("creditsalecustname").value="";
	document.getElementById("creditsalecustcontact").value="";
	document.getElementById("hidcredisalecustid").value="";
	document.getElementById('creditsalecustdetailcontId').innerHTML="";
	document.getElementById("creditsalepaymentdetailcontId").innerHTML="";
	document.getElementById("creditsalepayButton").disabled=true;
	document.getElementById('paycreditsalealertMsg').innerHTML='';
	if(orderno==0 || forspNoteData.length>0)
	{
		showalertsaveorderModal();
	}
	else
		{
		showCreditSaleModal();
		}
}
function showcreditsalePaydetail(val)
{
	var createdline="";
	var netPrice=document.getElementById('amttopaycontId').innerHTML;
	var line1="<div style='padding: 5px;'>Total Amount :&nbsp;&nbsp;&nbsp;"+parseFloat(pmntTotAmt).toFixed(2)+"</div>";
	var line2="<div style='padding: 5px;'>Amount to Pay :&nbsp;&nbsp;&nbsp;"+parseFloat(netPrice).toFixed(2)+"</div>";
	var line3="<div style='padding: 3px;'>Tender Amount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type='text' id='creditsaletenderAmount' style='text-align:center; color: #222222' size='4'/> </div>";
	//var line4="<div style='padding: 5px;'>Card Last 4 Digit :&nbsp;<input type='text' id='creditsalecardlastfourDigit' style='text-align:center; color: #222222' size='4'/> </div>";
	if(val=='cash')
		{
		createdline=line1+line2+line3;
		document.getElementById('creditsalecardlastfourDigit').value="0000";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display="none";
		document.getElementById('paycreditsalealertMsg').innerHTML="";
		}
	else if(val=='card')
		{
		createdline=line1+line2+line3;
		document.getElementById('paycreditsalealertMsg').innerHTML="";
		}else{
			document.getElementById('creditsalecardlastfourDigit').value="0000";
			document.getElementById("hidcreditsalelastfourdigitcontid").style.display="none";
		}
	document.getElementById("creditsalepaymentdetailcontId").innerHTML=createdline;
	if(val=='card'){
		document.getElementById('creditsalecardlastfourDigit').value="";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display="block";
	}
	document.getElementById("creditsalepayButton").disabled=false;
}
function payCreditSale()
{
	
	var netAmt=document.getElementById('hidnetTotal').value;
	var orderno=document.getElementById('orderNo').value;
	var custid=document.getElementById('hidcredisalecustid').value;
	var option=document.getElementsByName("creditsalepayOption");
	var lastdigit=document.getElementById('creditsalecardlastfourDigit').value;
	var selOption=null;
	for(var i = 0; i < option.length; i++) {
		   if(option[i].checked == true) {
			   selOption = option[i].value;
		   }
		 }
	var tenderAmt=0;
	if(selOption=='nopay'){
		tenderAmt=0;
	}else{
		tenderAmt=document.getElementById('creditsaletenderAmount').value;
	}
	
	//alert('net:'+netAmt+':ord:'+orderno+':cust:'+custid+':payoption:'+selOption+':tender:'+tenderAmt+':lastdigit:'+lastdigit);
	if (isNaN(tenderAmt) || tenderAmt==='')
	{
	//alert('Please eneter a valid number!');
	document.getElementById('paycreditsalealertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('creditsaletenderAmount').focus();
	}
	
	else if(isNaN(lastdigit))
		 	{
			//alert('Please enter a valid card number!');
			document.getElementById('paycreditsalealertMsg').innerHTML='Please enter a valid card number!';
			document.getElementById('creditsalecardlastfourDigit').focus();
		 	}
	else if(lastdigit.length!=4)
			{
			//alert('Please enter 4 digit valid card number!');
			document.getElementById('paycreditsalealertMsg').innerHTML='Please enter 4 digit valid card number!';
			document.getElementById('creditsalecardlastfourDigit').focus();
			}
		else
		{
		var amttoPay=parseFloat(netAmt).toFixed(2)-tenderAmt;
		//alert('success:'+amttoPay);
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/updatecreditsalestatus/"+orderno +"/"+ custid + ".htm", function(response) {
		try{
			//alert(response);
			if(response=='success')
				{
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netAmt+"/"+ parseFloat(tenderAmt).toFixed(2)+"/"+ amttoPay+"/"+tenderAmt+"/"+selOption+"/"+lastdigit + ".htm", function(response) {
				try{
					//alert(response);
					if(response=='success')
						{
						hideCreditSaleModal();
						location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
						
						}
					}catch(e){alert(e);}
				}, null);
				
				}
			}catch(e){alert(e);}
		}, null);
		}
}
/*end credit sale*/
/*add no of pax*/
function addnoofPax(noofPax)
{
	//alert(noofPax);
	var orderno=document.getElementById('orderNo').value;
	//alert(orderno);
	if(!parseInt(noofPax))
		{
		document.getElementById('paxalertMsg').innerHTML='Please enter correct value!';
		}
	else
		{
		if(orderno=='0')
			{
			document.getElementById('noofPaxId').innerHTML=noofPax;
			document.getElementById('hidnoofPax').value=noofPax;
			closePaxModal();
			}
		else{
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/updatepax/"+orderno+"/"+noofPax  + ".htm", function(response) {
				try{
					//alert(response);
					if(response=='success')
						{
						document.getElementById('noofPaxId').innerHTML=noofPax;
						document.getElementById('hidnoofPax').value=noofPax;
						closePaxModal();
						}
					else
						{
						document.getElementById('paxalertMsg').innerHTML=''+response+'';
						}
				}catch(e)
				{alert(e);}
				}, null);
			}
		
		}
}
/*end add no of pax*/
/*start change table*/
function showchangeTable()
{
	var tableno=document.getElementById('tablenoCont').innerHTML;
	if(tableno!='0')
		{
		openChangeTableModal();
		}
}
function updateTableNo(tabVal)
{
	var orderno=document.getElementById('orderNo').value;
	var res=tabVal.split('~');
	var tabno=res[0];
	var tabstat=res[1];
	if(tabstat=='Y')
		{
		document.getElementById('changetablealertMsg').innerHTML='Table No '+tabno+' is already Booked!';
		}
	else
		{
		if(orderno=='0')
			{
			document.getElementById('tablenoCont').innerHTML=tabno;
			closeChangeTableModal();
			}
		else{
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/updatetable/"+orderno+"/"+tabno  + ".htm", function(response) {
				try{
					//alert(response);
					if(response=='success')
						{
						document.getElementById('tablenoCont').innerHTML=tabno;
						closeChangeTableModal();
						}
					else
						{
						document.getElementById('changetablealertMsg').innerHTML=''+response+'';
						}
				}catch(e)
				{alert(e);}
				}, null);
			}
		}
}
/*end change table*/
/* start split bill*/
function openSplitBill(storeid)
{
	$("#submitSplitBillBut").hide();
	document.getElementById('splitBillContainerId').innerHTML="";
	document.getElementById('splitbillalertMsg').innerHTML="";
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	if(orderno!=0 && tableno!='0')
	{
		//alert('Please save the order first!');
		if(storeid==37 || storeid==38){
			var noofPax=document.getElementById('noofPaxId').innerHTML;
			var NOPAX=parseInt(noofPax);
			document.getElementById('noofsplitBill').value=NOPAX;
		}else{
			document.getElementById('noofsplitBill').value=2;
		}
		
		document.getElementById('splitbillmodOrderCont').innerHTML=orderno;
		document.getElementById('splitbillmodTabCont').innerHTML=tableno;
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistbyoderid/"+orderno+".htm", function(response) {
			if(response=='success')
				{
				showsplitBillModal();
				}
		}, null);
		
	}
		
}

var splitservicetaxText=document.getElementById('hidserviceTaxTextVal').value;
var splitvattaxText=document.getElementById('hidvatTaxTextVal').value;
var splitvatAmt=document.getElementById('hidvatTaxVal').value;
var splitstaxAmt=document.getElementById('hidserviceTaxVal').value;
function showSplitBillContent(pax,storeid)
{
	$("#submitSplitBillBut").show();
	if(storeid==37 || storeid==38){
		var noofPax=document.getElementById('noofPaxId').innerHTML;
		/*var servicetaxText=document.getElementById('hidserviceTaxTextVal').value;
		var vattaxText=document.getElementById('hidvatTaxTextVal').value;
		var vatAmt=document.getElementById('hidvatTaxVal').value;
		var staxAmt=document.getElementById('hidserviceTaxVal').value;*/
		var billsplittype = $('input:radio[name=radioGroup]:checked').val();
		if(billsplittype==1){
			// item wise split
			if(parseInt(pax)>1 && parseInt(pax)<=parseInt(noofPax))
			{
				generateHTMLForItemWiseSplitting(pax);
			}
		}else{
			// category wise split
			if(parseInt(pax)>1 && parseInt(pax)<=parseInt(noofPax))
			{
				var orderno=document.getElementById('orderNo').value;
				var tableno=document.getElementById('tablenoCont').innerHTML;
				if(orderno!=0 && tableno!='0')
				{
					//alert('Please save the order first!');
					
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywisebyoderid/"+orderno+".htm", function(response) {
						if(response=='success')
							{
//							showsplitBillModal();
							}
					}, null);
					generateHTMLForCategoryWiseSplitting(pax);
				}
			
			}
		}
		
	}else{
		/*var servicetaxText=document.getElementById('hidserviceTaxTextVal').value;
		var vattaxText=document.getElementById('hidvatTaxTextVal').value;
		var vatAmt=document.getElementById('hidvatTaxVal').value;
		var staxAmt=document.getElementById('hidserviceTaxVal').value;*/
		var billsplittype = $('input:radio[name=radioGroup]:checked').val();
		if(billsplittype==1){
			// item wise split
				generateHTMLForItemWiseSplitting(pax);
		}else{
			// category wise split
				var orderno=document.getElementById('orderNo').value;
				var tableno=document.getElementById('tablenoCont').innerHTML;
				if(orderno!=0 && tableno!='0')
				{
					//alert('Please save the order first!');
					
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywisebyoderid/"+orderno+".htm", function(response) {
						if(response=='success')
							{
//							showsplitBillModal();
							}
					}, null);
					generateHTMLForCategoryWiseSplitting(pax);
				}
			
		}
	}
	
	
}

function generateHTMLForItemWiseSplitting(pax){
	var generatedHtml="";
	for(var i=1;i<=pax;i++)
		{
		var createddiv="";
		var headerDiv="<div align='left'>Bill No "+i+" <button type='button' onclick='javascript:opensplitBillItemListModal("+i+")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>Select Items</button></div>";
		var tableline="<div id='sbillcontid_"+i+"'><table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>NAME</th><th style='text-align:center;'>QTY</th><th style='text-align:center;'>RATE</th><th style='text-align:center;'>TOTAL</th>";
		var headerline="<tbody style='color:#fff; padding:1px;' id='tbodycontid_"+i+"'>";
		var endtbody="</tbody></table>";
		var subtotdiv="<div align='left' style='width:77%'>SubTotal<span style='float:right' id='subtotdiv_"+i+"'>0.00</span></div>";
		var taxdiv="";
		var staxdiv="";
		if(splitvattaxText.length!=0)
		{
			taxdiv="<div align='left' style='width:77%'>"+splitvattaxText+"("+splitvatAmt+"%)<span style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		}
		if(splitservicetaxText.length!=0)
		{
			staxdiv="<div align='left' style='width:77%'>"+splitservicetaxText+"("+splitstaxAmt+"%)<span style='float:right' id='staxdiv_"+i+"'>0.00</span></div>";
		}
		//var taxdiv="<div align='left' style='width:77%'>GST(6%)<span style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var grandtotdiv="<div align='left' style='width:77%'>GrandTotal<span style='float:right' id='grandtotdiv_"+i+"'>0.00</span></div>";
		var footerline="</div>";
		createddiv=headerDiv+tableline+headerline+endtbody+subtotdiv+taxdiv+staxdiv+grandtotdiv+footerline;
		generatedHtml+=createddiv;
		}
	//alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML=generatedHtml;
}

function generateHTMLForCategoryWiseSplitting(pax){
	var generatedHtml="";
	for(var i=1;i<=pax;i++)
		{
		var createddiv="";
		var headerDiv="<div align='left'>Bill No "+i+" <button type='button' onclick='javascript:opensplitBillItemListModalCategoryWise("+i+")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>Select Category</button></div>";
		var tableline="<div id='sbillcontid_"+i+"'><table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>NAME</th><th style='text-align:center;'>QTY</th><th style='text-align:center;'>RATE</th><th style='text-align:center;'>TOTAL</th>";
		var headerline="<tbody style='color:#fff; padding:1px;' id='tbodycontid_"+i+"'>";
		var endtbody="</tbody></table>";
		var subtotdiv="<div id='subtotdivcont_"+i+"' align='left' style='width:77%'>SubTotal<span style='float:right' id='subtotdiv_"+i+"'>0.00</span></div>";
		var taxdiv="";
		var staxdiv="";
		if(splitvattaxText.length!=0)
		{
//			taxdiv="<div id='taxdivcont_"+i+"' align='left' style='width:77%'>"+splitvattaxText+"("+splitvatAmt+"%)<span style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
			taxdiv="<div id='taxdivcont_"+i+"' align='left' style='width:77%'>"+splitvattaxText+"<span style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		}
		if(splitservicetaxText.length!=0)
		{
//			staxdiv="<div id='staxdivcont_"+i+"' align='left' style='width:77%'>"+splitservicetaxText+"("+splitstaxAmt+"%)<span style='float:right' id='staxdiv_"+i+"'>0.00</span></div>";
			staxdiv="<div id='staxdivcont_"+i+"' align='left' style='width:77%'>"+splitservicetaxText+"<span style='float:right' id='staxdiv_"+i+"'>0.00</span></div>";
		}
		//var taxdiv="<div align='left' style='width:77%'>GST(6%)<span style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var grandtotdiv="<div id='grandtotdivcont_"+i+"' align='left' style='width:77%'>GrandTotal<span style='float:right' id='grandtotdiv_"+i+"'>0.00</span></div>";
		var footerline="</div>";
		createddiv=headerDiv+tableline+headerline+endtbody+subtotdiv+taxdiv+staxdiv+grandtotdiv+footerline;
		generatedHtml+=createddiv;
		}
	//alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML=generatedHtml;
}

var splitbillid=0;
function opensplitBillItemListModal(id)
{
	splitbillid=id;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlist.htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			preparesplitbillitemListHtml(responseObj);
			
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	showsplitBillItemListModal();
}
function opensplitBillItemListModalCategoryWise(id)
{
	splitbillid=id;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywise.htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			preparesplitbillitemListCategoryWiseHtml(responseObj);
//			console.log(response);
//			alert(response);
			
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	showsplitBillItemListModalcatwise();
}
function preparesplitbillitemListCategoryWiseHtml(responseData)
{
	selectedsplitRowscatwise=[];
	var createdrowline="";
	var generatedHtml = "";
	var tableline="<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th style='width:5%'></th><th style='text-align:center'>CATEGORY NAME</th>";
	var headerline="<tbody style='color:#fff; padding:1px;' >";
	var footerline="</tbody></table>";
	for(var i=0;i<responseData.length;i++)
	{
		var itemcatgory=responseData[i];
		var disc1=0.0;
		var begintrline="";
		var firsttdline="";
		var secondtdline="";
		var trbgColor="#222222";
		//alert(orderitem.id);
		begintrline="<tr id='rowsplitcatwise_"+itemcatgory.id+"' style='background:"+trbgColor+"; padding:2px;'>";
		firsttdline="<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplitcatwise("+itemcatgory.id+",this)' id='chksplitcatwise_"+itemcatgory.id+"'></td>";
		secondtdline="<td width='50%'  onclick='javascript:selectRowSplitcatwise("+itemcatgory.id+")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+itemcatgory.menuCategoryName+"</td>";
		var endtrline="</tr>";
		createdrowline+=begintrline+firsttdline+secondtdline+endtrline;
		
	}
	generatedHtml=tableline+headerline+createdrowline+footerline;
	document.getElementById('splitBillItemListContIdcatwise').innerHTML=generatedHtml;
}

var selectedsplitRowscatwise = [];
function selectRowSplitcatwise(trId)
{
	if(document.getElementById('chksplitcatwise_'+trId).checked==false)
		{
		document.getElementById('rowsplitcatwise_'+trId).style.background='#373737';
		document.getElementById('chksplitcatwise_'+trId).checked=true;
		selectedsplitRowscatwise.push(trId);
		}
	else
		{
		document.getElementById('rowsplitcatwise_'+trId).style.background='#222222';
		document.getElementById('chksplitcatwise_'+trId).checked=false;
		selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId), 1);
		}
}
function checkRowSplitcatwise(trId,chk)
{
	if(chk.checked)
	{
	document.getElementById('rowsplitcatwise_'+trId).style.background='#373737';
	selectedsplitRowscatwise.push(trId);
	}
else
	{
	document.getElementById('rowsplitcatwise_'+trId).style.background='#222222';
	selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId), 1);
	}
}
function addItemToSplitBillcatwise()
{
	//alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbillcatwise/"+selectedsplitRowscatwise+".htm", function(response) {
		try{
			console.log(response);
			var responseObj=JSON.parse(response);
			preparesplitbillitemListHtmlCatWise(responseObj);
			
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	hidesplitBillItemListModalcatwise();
}



function preparesplitbillitemListHtmlCatWise(responseData)
{
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var subtot=0.0;
	subtot=document.getElementById('subtotdiv_'+splitbillid).innerHTML;
	subtot=parseFloat(subtot);
	var catidbeverage=0.0;
	var taxamt=0.0;
	var staxamt=0.0;
	var grandtot=0.0;
	var generatedHtml="";
	var createddiv="";
	var createdrowline="";
	var tableline="<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>SL</th><th>NAME</th><th style='text-align:center;'>QTY</th><th>RATE</th><th>TOTAL</th><th>ACTION</th>";
	var headerline="<tbody style='color:#fff; padding:1px;' >";
	var endtbody="</tbody>";
	var footerline="</tbody><tfoot><tr><td>SubTotal</td><td></td><td></td><td></td><td>200.00</td></tr><tr><td>GST(6%)</td><td></td><td></td><td></td><td>50.00</td></tr><tr><td>Total Amount</td><td></td><td></td><td></td><td>250.00</td></tr></tfoot></table>";
	
	for(var i=0;i<responseData.length;i++)
	{
		var Menu=responseData[i];
		for(var j=0;j<Menu.items.length;j++){
			var item=Menu.items[j];
			var disc1=0.0;
			var begintrline="";
			var firsttdline="";
			var secondtdline="";
			var thirdtdline="";
			var trbgColor="#222222";
			
			begintrline="<tr id='"+item.id+"' style='padding:2px;background:#404040'>";
			var hidcatid="<input type='hidden'  value='"+item.categoryId+"'>";
			secondtdline="<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+item.name+" ## "+item.categoryName+"</td>";
			thirdtdline="<td valign='middle' align='center' style='padding:3px;'>"+item.quantityOfItem+"</td>";
			var fourthtdline="<td  style='padding:1px;text-align: center;'>"+parseFloat(item.price).toFixed(2)+"</td>";
			var fifthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(disc1).toFixed(2)+"</td>";
			var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(item.price*item.quantityOfItem-disc1).toFixed(2)+"</td>";
			subtot+=item.price*item.quantityOfItem-disc1;
			taxamt+=(item.price*item.quantityOfItem-disc1)*item.vat/100;
			staxamt+=(item.price*item.quantityOfItem-disc1)*item.serviceTax/100;
			var endtrline="</tr>";
			createdrowline+=begintrline+hidcatid+secondtdline+thirdtdline+fourthtdline+sixthtdline+endtrline;
			if(item.categoryId==1025){
				catidbeverage=item.categoryId;
				
			   }
			}
		
	}
	if(splitvattaxText.length!=0)
		{
		taxamt=taxamt;
		}
	if(storeID==53 && catidbeverage==1025){
		staxamt=staxamt;
	}else{
		if(splitservicetaxText.length!=0)
		{
		staxamt=staxamt;
		}
	}
	
	//taxamt=subtot*6/100;
	grandtot=subtot+taxamt+staxamt;
	generatedHtml=createdrowline;
	//alert(generatedHtml);
	$("#tbodycontid_"+splitbillid).append(generatedHtml);
	document.getElementById('subtotdivcont_'+splitbillid).style.width="86%";
	document.getElementById('subtotdiv_'+splitbillid).innerHTML=parseFloat(subtot).toFixed(2);
	if(storeID==53 && catidbeverage==1025){
		document.getElementById('taxdivcont_'+splitbillid).innerHTML="Sales Tax <span style='float:right' id='taxdiv_"+splitbillid+"'>0.00</span>";
		document.getElementById('taxdivcont_'+splitbillid).style.width="86%";
		document.getElementById('taxdiv_'+splitbillid).innerHTML=parseFloat(taxamt).toFixed(2);
		
	}else{
		
		if(splitvattaxText.length!=0)
		{
			document.getElementById('taxdivcont_'+splitbillid).style.width="86%";
			document.getElementById('taxdiv_'+splitbillid).innerHTML=parseFloat(taxamt).toFixed(2);
		}
	}
	
	
		if(splitservicetaxText.length!=0)
		{
			document.getElementById('staxdivcont_'+splitbillid).style.width="86%";
			document.getElementById('staxdiv_'+splitbillid).innerHTML=parseFloat(staxamt).toFixed(2);
		}
	
	document.getElementById('grandtotdivcont_'+splitbillid).style.width="86%";
	if(storeroundoffflag=='Y'){
		grandtot=Math.round(grandtot);
	}
	document.getElementById('grandtotdiv_'+splitbillid).innerHTML=parseFloat(grandtot).toFixed(2);
	//document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}

function preparesplitbillitemListHtml(responseData)
{
	selectedsplitRows=[];
	var createdrowline="";
	var generatedHtml = "";
	//for saravana
	var tableline="<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>NAME</th><th style='text-align:center;'>QUANTITY</th><th>RATE</th><th>TOTAL</th>";
	var headerline="<tbody style='color:#fff; padding:1px;' >";
	var footerline="</tbody></table>";
	for(var i=0;i<responseData.length;i++)
	{
		var orderitem=responseData[i];
		var disc1=0.0;
		var begintrline="";
		var firsttdline="";
		var secondtdline="";
		var thirdtdline="";
		var trbgColor="#222222";
		//alert(orderitem.id);
		begintrline="<tr id='rowsplit_"+orderitem.id+"' style='background:"+trbgColor+"; padding:2px;'>";
		var hiditemid="<input type='hidden' id='"+splitbillid+"_"+orderitem.item.id+"' value='"+orderitem.item.id+"'>";
		firsttdline="<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplit("+orderitem.id+",this)' id='chksplit_"+orderitem.id+"'></td>";
		secondtdline="<td width='50%'  onclick='javascript:selectRowSplit("+orderitem.id+")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.item.name+"</td>";
		thirdtdline="<td valign='middle' align='center' style='padding:3px;'>"+orderitem.quantityOfItem+"</td>";
		var fourthtdline="<td  style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate).toFixed(2)+"</td>";
		var fifthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(disc1).toFixed(2)+"</td>";
		var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+"</td>";
		var seventhhtdline="";
		var eighthtdline="";
		/*if(vattaxText.length!=0)
			{
			seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>";
			}
		if(servicetaxText.length!=0)
			{
			eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>";
			}*/
		
		var endtrline="</tr>";
		createdrowline+=begintrline+firsttdline+secondtdline+thirdtdline+fourthtdline+sixthtdline+endtrline;
		
	}
	generatedHtml=tableline+headerline+createdrowline+footerline;
	document.getElementById('splitBillItemListContId').innerHTML=generatedHtml;
}
var selectedsplitRows = [];
function selectRowSplit(trId)
{
	if(document.getElementById('chksplit_'+trId).checked==false)
		{
		document.getElementById('rowsplit_'+trId).style.background='#373737';
		document.getElementById('chksplit_'+trId).checked=true;
		selectedsplitRows.push(trId);
		}
	else
		{
		document.getElementById('rowsplit_'+trId).style.background='#222222';
		document.getElementById('chksplit_'+trId).checked=false;
		selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
		}
}
function checkRowSplit(trId,chk)
{
	if(chk.checked)
	{
	document.getElementById('rowsplit_'+trId).style.background='#373737';
	selectedsplitRows.push(trId);
	}
else
	{
	document.getElementById('rowsplit_'+trId).style.background='#222222';
	selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
	}
}
function addItemToSplitBill()
{
	//alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbill/"+selectedsplitRows+".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			preparesplitbillitemListHtmltoBill(responseObj);
			
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	hidesplitBillItemListModal();
}
function deleteItemFromSplitBill(billid,deleteitemid)
{
	//alert(deleteitemid);
	var orderid=document.getElementById('splitbillmodOrderCont').innerHTML;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitemlisttosplitbill/"+deleteitemid+"/"+orderid+".htm", function(response) {
		preparesplitbillitemListHtmltoBillDelete(billid,deleteitemid);
		}, null);
	
	hidesplitBillItemListModal();
}
function preparesplitbillitemListHtmltoBill(responseData)
{
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var splitbillids = [];
	var subtot=0.0;
	subtot=document.getElementById('subtotdiv_'+splitbillid).innerHTML;
	subtot=parseFloat(subtot);
	var taxamt=0.0;
	var staxamt=0.0;
	var grandtot=0.0;
	var generatedHtml="";
	var createddiv="";
	var createdrowline="";
	var tableline="<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>SL</th><th>NAME</th><th style='text-align:center;'>QTY</th><th>RATE</th><th>TOTAL</th><th>ACTION</th>";
	var headerline="<tbody style='color:#fff; padding:1px;' >";
	var endtbody="</tbody>";
	var footerline="</tbody><tfoot><tr><td>SubTotal</td><td></td><td></td><td></td><td>200.00</td></tr><tr><td>GST(6%)</td><td></td><td></td><td></td><td>50.00</td></tr><tr><td>Total Amount</td><td></td><td></td><td></td><td>250.00</td></tr></tfoot></table>";
	$("#tbodycontid_"+splitbillid +" > tr").each(function() {
		//alert(this.id);
		splitbillids.push(this.id);
	});
	
	for(var i=0;i<responseData.length;i++)
	{
		/*$.each( splitbillids, function( index,value ) {
			  alert("value: " + value );
			});*/
		
		
		var orderitem=responseData[i];
		var disc1=0.0;
		var begintrline="";
		var firsttdline="";
		var secondtdline="";
		var thirdtdline="";
		var trbgColor="#222222";
		if(splitbillids.length>0)
		{
			for(var j=0; j<splitbillids.length;j++)
				{
				if(splitbillids[j]==orderitem.id)
					{
					orderitem.quantityOfItem=parseInt(orderitem.quantityOfItem)+1;
					subtot=subtot-orderitem.rate*1;
					$("#tbodycontid_"+splitbillid +" tr#"+orderitem.id).remove();
					}
				}
		}
		//alert(orderitem.id);
		begintrline="<tr id='"+orderitem.id+"' style='padding:2px;background:#404040'>";
		var hiditemid="<input type='hidden' id='"+splitbillid+"_"+orderitem.item.id+"' value='"+orderitem.item.id+"'>";
		//firsttdline="<td style='padding:1px;'>"+(i+1)+"</td>";
		secondtdline="<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"+orderitem.item.name+"</td>";
		thirdtdline="<td valign='middle' align='center' style='padding:3px;'>"+orderitem.quantityOfItem+"</td>";
		var fourthtdline="<td  style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate).toFixed(2)+"</td>";
		var fifthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(disc1).toFixed(2)+"</td>";
		var sixthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+"</td>";
		var seventhhtdline="<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:deleteItemFromSplitBill("+splitbillid+","+orderitem.id+")'><img border='0' alt='' src='"+BASE_URL+"/assets/images/base/d/d_delete.png' height='22' width='18'></a></td>";
		var eighthtdline="";
		/*if(vattaxText.length!=0)
			{
			seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>";
			}
		if(servicetaxText.length!=0)
			{
			eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>";
			}*/
		//alert(parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2));
		subtot+=orderitem.rate*orderitem.quantityOfItem-disc1;
		//alert(subtot);
		var endtrline="</tr>";
		createdrowline+=begintrline+hiditemid+secondtdline+thirdtdline+fourthtdline+sixthtdline+seventhhtdline+endtrline;
		
	}
	//alert(subtot);
	if(splitvattaxText.length!=0)
		{
		taxamt=subtot*splitvatAmt/100;
		}
	if(splitservicetaxText.length!=0)
		{
		staxamt=subtot*splitstaxAmt/100;
		}
	//taxamt=subtot*6/100;
	grandtot=subtot+taxamt+staxamt;
	generatedHtml=createdrowline;
	//alert(generatedHtml);
	$("#tbodycontid_"+splitbillid).append(generatedHtml);
	document.getElementById('subtotdiv_'+splitbillid).innerHTML=parseFloat(subtot).toFixed(2);
	if(splitvattaxText.length!=0)
	{
		document.getElementById('taxdiv_'+splitbillid).innerHTML=parseFloat(taxamt).toFixed(2);
	}
	if(splitservicetaxText.length!=0)
	{
		document.getElementById('staxdiv_'+splitbillid).innerHTML=parseFloat(staxamt).toFixed(2);
	}
	if(storeroundoffflag=='Y'){
		grandtot=Math.round(grandtot);
	}
	document.getElementById('grandtotdiv_'+splitbillid).innerHTML=parseFloat(grandtot).toFixed(2);
	//document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}
function preparesplitbillitemListHtmltoBillDelete(billid,deleteitemid)
{
	//alert('in delete:'+billid+':'+deleteitemid);
	//alert($("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(3)').html());
	var deleteditemcost=0.0;
	var deleteditemqty=$("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(1)').html();
	var deleteditemrate=$("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(2)').html();
	//deleteditemcost=$("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(3)').html();
	
	if(deleteditemqty>1)
		{
		deleteditemqty=deleteditemqty-1;
		$("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(1)').html(deleteditemqty);
		$("#tbodycontid_"+billid +" tr#"+deleteitemid).find('td:eq(3)').html(parseFloat(deleteditemqty*deleteditemrate).toFixed(2));
		}
	else
		{
		$("#tbodycontid_"+billid +" tr#"+deleteitemid).remove();
		}
	
	//alert('gg:'+deleteditemcost);
	var subtot=0.0;
	var taxamt=0.0;
	var staxamt=0.0;
	var grandtot=0.0;
	subtot=document.getElementById('subtotdiv_'+billid).innerHTML;
	subtot=parseFloat(subtot);
	subtot=subtot-parseInt(deleteditemrate);
	if(splitvattaxText.length!=0)
	{
		taxamt=subtot*splitvatAmt/100;
	}
	if(splitservicetaxText.length!=0)
	{
		staxamt=subtot*splitstaxAmt/100;
	}
	//taxamt=subtot*6/100;
	grandtot=subtot+taxamt+staxamt;
	document.getElementById('subtotdiv_'+billid).innerHTML=parseFloat(subtot).toFixed(2);
	if(splitvattaxText.length!=0)
	{
		document.getElementById('taxdiv_'+billid).innerHTML=parseFloat(taxamt).toFixed(2);
	}
	if(splitservicetaxText.length!=0)
	{
		document.getElementById('staxdiv_'+billid).innerHTML=parseFloat(staxamt).toFixed(2);
	}
	//document.getElementById('taxdiv_'+billid).innerHTML=parseFloat(taxamt).toFixed(2);
	document.getElementById('grandtotdiv_'+billid).innerHTML=parseFloat(grandtot).toFixed(2);
}

function submitSpliBill(noofbill,storeid)
{
	var SpliBill=[];
//	var noofPax=document.getElementById('noofPaxId').innerHTML;
	var billsplittype = $('input:radio[name=radioGroup]:checked').val();
	if(billsplittype==1){
		// itemwise
		
		var rowlen=0;
		var orderid=document.getElementById('splitbillmodOrderCont').innerHTML;
		for(var i=1;i<=noofbill;i++)
			{
			//rowlen=$("#tbodycontid_"+i+" tr").length;
			if($("#tbodycontid_"+i+" tr").length==0)
				{
				rowlen=i;
				}
			$("#tbodycontid_"+i+" > tr").each(function() {
				
				var biilamt=0.0;
				var SpliBillObj={};	
				SpliBillObj.billId=document.getElementById('splitbillId').value;
				SpliBillObj.orderId=document.getElementById('splitbillmodOrderCont').innerHTML;
				SpliBillObj.billNo=i;
				SpliBillObj.itemId=$(this).find('input[type="hidden"]').val();
				SpliBillObj.itemName=$(this).find('td:eq(0)').html();
				SpliBillObj.totalBillNo=noofbill;
				SpliBillObj.itemQuantity=$(this).find('td:eq(1)').html();
				SpliBillObj.itemRate=$(this).find('td:eq(2)').html();
				SpliBillObj.billAmount=$(this).find('td:eq(3)').html();
				var d=new Date();
				SpliBillObj.creationDate=("0" + d.getDate()).slice(-2) + "-" + ("0"+(d.getMonth()+1)).slice(-2) + "-" + d.getFullYear();
				//biilamt=Number($(this).find('td:eq(3)').html());
				//biilamt=Number(biilamt)+Number(biilamt*6/100);
				
				//SpliBillObj.billAmount=Number(parseFloat(biilamt).toFixed(2));
				
				SpliBillObj.mode="M";
				//alert($(this).find('input[type="hidden"]').val());
				//alert($(this).find('td:eq(0)').html());
				SpliBill.push(SpliBillObj);
				
			});
			}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/validatesplitbill.htm", function(response) {
			try{
				if(response>0)
					{
					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'+response+' item(s) is remaining to add!</strong> </div>');
					}
//				else if(parseInt(noofbill)>parseInt(noofPax))
//					{
//					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong> No of bill is greater than no of pax!</strong> </div>');
//					}
				else
					{
					
					if(rowlen==0)
						{
						$.ajax({
							  url: BASE_URL + "/order/submitsplitbillfors01.htm",
							  type: 'POST',
							  contentType:'application/json;charset=utf-8',
							  data: JSON.stringify(SpliBill),
							  success: function(response) {
								//called when successful
								  if(response=='success')
									{
									
									SpliBillcatwise=[];
									hidesplitBillModal();
									var ajaxCallObject = new CustomBrowserXMLObject();
									ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/"+orderid  + ".htm", function(response) {
										try{
											if(response=='Success')
												showBillPrintSuccessModal();
											}catch(e)
										{alert(e);}
										}, null);
									}
							  },
							  error: function(e) {
								//called when there is an error
								//console.log(e.message);
							  }
							});
					/*var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/submitsplitbill/"+JSON.stringify(SpliBill)+".htm", function(response) {
						alert(response);
						if(response=='success')
							{
							SpliBill=[];
							hidesplitBillModal();
							var ajaxCallObject = new CustomBrowserXMLObject();
							ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/"+orderid  + ".htm", function(response) {
								try{
									if(response=='Success')
										showBillPrintSuccessModal();
									}catch(e)
								{alert(e);}
								}, null);
							}
						}, null);*/
					}else
						{
						$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>Please add item(s) in Bill No '+rowlen+'!</strong> </div>');
						}
					}
			}catch(e)
			{alert(e);}
			}, null);
		
	}else{
		// categorywise
		var rowlen=0;
		var orderid=document.getElementById('splitbillmodOrderCont').innerHTML;
		for(var i=1;i<=noofbill;i++)
			{
			//rowlen=$("#tbodycontid_"+i+" tr").length;
			if($("#tbodycontid_"+i+" tr").length==0)
				{
				rowlen=i;
				}
			$("#tbodycontid_"+i+" > tr").each(function() {
				var biilamt=0.0;
				var SpliBillObj={};	
				SpliBillObj.billId=document.getElementById('splitbillId').value;
				SpliBillObj.orderId=document.getElementById('splitbillmodOrderCont').innerHTML;
				SpliBillObj.billNo=i;
				SpliBillObj.categoryId=$(this).find('input[type="hidden"]').val();
				console.log("SpliBillObj.categoryId="+SpliBillObj.categoryId);
				SpliBillObj.itemId=this.id;
				SpliBillObj.itemName=$(this).find('td:eq(0)').html().split("##")[0];
				SpliBillObj.totalBillNo=noofbill;
				SpliBillObj.itemQuantity=$(this).find('td:eq(1)').html();
				SpliBillObj.itemRate=$(this).find('td:eq(2)').html();
				SpliBillObj.billAmount=$(this).find('td:eq(3)').html();
				var d=new Date();
				SpliBillObj.creationDate=("0" + d.getDate()).slice(-2) + "-" + ("0"+(d.getMonth()+1)).slice(-2) + "-" + d.getFullYear();
				//biilamt=Number($(this).find('td:eq(3)').html());
				//biilamt=Number(biilamt)+Number(biilamt*6/100);
				
				//SpliBillObj.billAmount=Number(parseFloat(biilamt).toFixed(2));
				
				SpliBillObj.mode="M";
				//alert($(this).find('input[type="hidden"]').val());
				//alert($(this).find('td:eq(0)').html());
				SpliBill.push(SpliBillObj);
				
			});
			}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/validatesplitbillcatwise.htm", function(response) {
			try{
				if(response>0)
					{
					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'+response+' category(s) is remaining to add!</strong> </div>');
					}
//				else if(parseInt(noofbill)>parseInt(noofPax))
//					{
//					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong> No of bill is greater than no of pax!</strong> </div>');
//					}
				else
					{
					if(rowlen==0)
						{
							$.ajax({
								  url: BASE_URL + "/order/submitsplitbillfors01.htm",
								  type: 'POST',
								  contentType:'application/json;charset=utf-8',
								  data: JSON.stringify(SpliBill),
								  success: function(response) {
									//called when successful
									  if(response=='success')
										{
										
										SpliBillcatwise=[];
										hidesplitBillModal();
										var ajaxCallObject = new CustomBrowserXMLObject();
										ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/"+orderid  + ".htm", function(response) {
											try{
												if(response=='Success')
													showBillPrintSuccessModal();
												}catch(e)
											{alert(e);}
											}, null);
										}
								  },
								  error: function(e) {
									//called when there is an error
									//console.log(e.message);
								  }
								});
					
					/*var ajaxCallObject1 = new CustomBrowserXMLObject();
					ajaxCallObject1.callAjax(BASE_URL + "/order/submitsplitbill/"+JSON.stringify(SpliBill)+".htm", function(response) {
						if(response=='success')
							{
							
							SpliBillcatwise=[];
							hidesplitBillModal();
							var ajaxCallObject = new CustomBrowserXMLObject();
							ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/"+orderid  + ".htm", function(response) {
								try{
									if(response=='Success')
										showBillPrintSuccessModal();
									}catch(e)
								{alert(e);}
								}, null);
							}
						}, null);*/
					}else
						{
						$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>Please add item(s) in Bill No '+rowlen+'!</strong> </div>');
						}
					}
			}catch(e)
			{alert(e);}
			}, null);
	}
//	alert('bill:'+noofbill+':pax:'+noofPax);
	
	
	
}
/*end split bill*/
/*start split payment */
function openSplitPaymentCashModal(){
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	document.getElementById('cashmodSplitPaymentOrderCont').innerHTML=orderno;
	document.getElementById('cashmodSplitPaymentTabCont').innerHTML=tableno;
	var totalbillamt=round($("#amttopaycontId").text(),1);
	$('#cashmodSplitPaymentBody').html('');
	$('#cashmodSplitPaymentBodyAmountDetails').html('');
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getbillwiseitemlist/"+orderno  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			console.log(responseObj);
			if(responseObj.length>0){
				var lastbillamttopay=0.00;
				for (var i = 0; i < responseObj.length; i++) {
					console.log(responseObj[i].billNo);
					console.log(responseObj[i].billSplitManuals.length);
				   
				    var amttopay=0.00;
				    
				    for (var j = 0; j < responseObj[i].billSplitManuals.length; j++) {
				    	var billSplitManual=responseObj[i].billSplitManuals[j];
				    	var itemamt=billSplitManual.itemQuantity*billSplitManual.itemRate;
				    	var taxamt=itemamt*6/100;
				    	amttopay=amttopay+itemamt+taxamt;
				    	
				    }
				    lastbillamttopay=lastbillamttopay+amttopay;
				    if(i==responseObj.length-1)
				    	{
				    	lastbillamttopay=totalbillamt-lastbillamttopay;
				    	amttopay=round(amttopay,2)+lastbillamttopay;
				    	}
				    var radioBtn = $('<label class="radio-inline"><input type="radio" name="cashmodSplitPayment" value="'+responseObj[i].billNo+"&"+round(amttopay,1)+'" style="transform: scale(2.0);-webkit-transform: scale(2.0);">Bill No. '+responseObj[i].billNo+'</label>');
				    radioBtn.appendTo('#cashmodSplitPaymentBody');
				   
				}
				 $("input:radio[name=cashmodSplitPayment]").click(function() {
						$( "#splitPaymentBtn" ).removeClass( "active" ).addClass( "disabled" );
						$('#cashmodSplitPaymentBodyAmountDetails').html('');
						$('#splitpaycashalertMsg').text('');
					    var value = $(this).val();
					    var newval=value.split("&");
					    var dynamictext=   '<br/>PAY FOR BILL NO. '+newval[0]
					    	      + '<div style="padding: 5px;">AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="splitpaymentamttopaycontId">'+newval[1]+'</span> </div>'
				   		          + '<div style="padding: 3px;">TENDER AMOUNT&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" onkeyup="javascript:getChangeAmtForSplit(this.value)" id="splitpaymenttenderAmt" style="text-align:center; color: #222222" size="4"/> </div>'
					              + '<div style="padding: 5px;">CHANGE AMOUNT :&nbsp;<span id="cashchangeamtsplitpaymentcontId">0.00</span> </div>'+
					    ' <div align="center" style=";font-size: 20px;">'
                                            
											+'<table class="ui-bar-a" id="n_keypad_sppay" style="display: none; -khtml-user-select: none;">'
												+'<tr>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero100_sppay"><img src="'+BASE_URL+'/assets/images/base/payment/rm100.png" /></a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero7_sppay">7</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero8_sppay">8</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero9_sppay">9</a></td>'
													+'<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-danger btn-lg" id="del_sppay">x</a></td>'
												+'</tr>'
												+'<tr>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero50_sppay"><img src="'+BASE_URL+'/assets/images/base/payment/rm50.png" /></a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero4_sppay">4</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero5_sppay">5</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero6_sppay">6</a></td>'
													+'<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-warning btn-lg" id="clear_sppay">c</a></td>'
												+'</tr>'
												+'<tr>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero20_sppay"><img src="'+BASE_URL+'/assets/images/base/payment/rm20.png" /></a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero1_sppay">1</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero2_sppay">2</a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero3_sppay">3</a></td>'
													+'<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numerodot_sppay">&nbsp;.</a></td>'
												+'</tr>'
												+'<tr>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero10_sppay"><img src="'+BASE_URL+'/assets/images/base/payment/rm10.png" /></a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numerorm5_sppay"><img src="'+BASE_URL+'/assets/images/base/payment/rm5.png" /></a></td>'
													+'<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="zero_sppay">0</a></td>'
													+'<td colspan="4"><a data-role="button" style="border: 2px solid #404040;width: 184px;" data-theme="done" class="btn btn-success btn-lg" id="done_sppay">DONE</a></td>'
												+'</tr>'
											+'</table>'
											+'</div>';
											
					    $('#cashmodSplitPaymentBodyAmountDetails').html(dynamictext);
					});
				
			}else
				{
				$('#cashmodSplitPaymentBodyAmountDetails').html('This Order is not splitted yet!');
				}
			
			}catch(e)
		{alert(e);}
		}, null);
	showSplitPaymentCashModal();
}
var originalamount=0.00;
function paySplitAmtByCash()
{
	
	var orderno=document.getElementById('orderNo').value;
	var amttopay=$('#splitpaymentamttopaycontId').text();
	var tenderAmt=$('#splitpaymenttenderAmt').val();
	var changeamt=Number(tenderAmt)-Number(amttopay);
	var billno=$('input:radio[name=cashmodSplitPayment]:checked').val();
	var totalbillamt=round($("#amttopaycontId").text(),1);
	var remainingamt=0.00;
	if(originalamount==0.00){
		remainingamt=Number(totalbillamt)-Number(amttopay);
	}else{
		//remainingamt=Number(originalamount)-Number(amttopay);	
		remainingamt=Number(totalbillamt)-(Number(originalamount)+Number(amttopay));
	}
	 
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ totalbillamt+"/"+ Number(amttopay)+"/"+ remainingamt+"/"+tenderAmt+"/"+"cash"+"/"+"000" + ".htm", function(response) {
		try{
			if(response=='success'){
				$('#splitpaycashalertMsg').text('Payment successfully done for bill no. '+billno.split("&")[0]);
				originalamount=originalamount+Number(amttopay);
				if(originalamount>=Number(totalbillamt)){
					if(storeID=='37' || storeID=='38')
					{
					hideSplitPaymentCashModal();
					document.getElementById('cashamttopaymodcontId').innerHTML=parseFloat(amttopay).toFixed(2);
					document.getElementById('cashtenderAmtmodcontId').innerHTML=parseFloat(tenderAmt).toFixed(2);
					document.getElementById('cashchangeamtmodcontId').innerHTML=parseFloat(changeamt).toFixed(2);
					showCashChangeAmtModal();
					}
					//location.href=BASE_URL+'/table/viewtable.htm';
				}
			}
			}catch(e)
		{alert(e);}
		}, null);
//	$("input:radio[name=cashmodSplitPayment][value=" + billno + "]").attr("disabled",true);
	$("input:radio[name=cashmodSplitPayment]:checked").attr("disabled",true);
	$( "#splitPaymentBtn" ).removeClass( "active" ).addClass( "disabled" );
}
function getChangeAmtForSplit(billno){
	
	var amttopay=$('#splitpaymentamttopaycontId').text();
	var tenderAmt=$('#splitpaymenttenderAmt').val();
	if(Number(tenderAmt)>=Number(amttopay)){
		var changeamt=Number(tenderAmt)-Number(amttopay);
		$('#cashchangeamtsplitpaymentcontId').text(round(changeamt,1));
		$( "#splitPaymentBtn" ).removeClass( "disabled" ).addClass( "active" );
		// for vfd
		if(vfdPort.length>3)
		{
			//var changeAmt=tenderAmt-netTotal;
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/" +"TOT IN RM : " + parseFloat(amttopay).toFixed(2) + "/"+"BAL IN RM : " + parseFloat(changeamt).toFixed(2)+".htm", function() {
				}, null);
		}
	}else{
		$('#cashchangeamtsplitpaymentcontId').text('0.00');
		$( "#splitPaymentBtn" ).removeClass( "active" ).addClass( "disabled" );
		
		
	}
	
}

/*function searchCustomer() {
	
	
	var orderNo=$('#orderNo').find("option:selected").val();
	console.log("orderDetails" + orderNo);
	
	var customerContact = document.getElementById("modparcelcustPhone").value;
	
	if ((isNaN(customerContact) || customerContact == '')&& calledFromSavedOrder=='no') {
		// alert('Please eneter a valid number!');
		
		
		$("#modparceldeliveryPersonName").val("");
		$("#modparcelcustAddress").val("");
		$("#modparcelcustName").val("");
		$("#modparcelcustvatorcst").val("");
		$("#modparcelcustlocation").val("");
		 $("#modparcelcusthouseno").val("");
		 $("#modparcelcuststreet").val("");
		 $("#modparcelcuststate").val("");

		var date = new Date();
		 $("#modparcelcustdob").val(formatDate(date));
		 $("#modparcelcustanniversary").val(formatDate(date));
		
	
		
		document.getElementById('parcelCustModalalertMsg').innerHTML = 'Please eneter a valid number!';
		document.getElementById('modparcelcustPhone').focus();
		$tabs = $('.nav-justified li');
	     var myArray = $(".nav-justified li a").map(function() {
	                   return $(this).text();
	                }).get();
	     for(var i = 0; i<myArray.length; i++)
	     {
	      if(myArray[i]!='Home')
	      {
	       $tabs.addClass('disabled');
	      }
	     }
	} else {
		
		
		var ajaxCallObject = new CustomBrowserXMLObject();

		if(customerContact == '')
			{
			
			// ajaxCallObject.callAjax(BASE_URL+'/order/getspecificorder.htm?orderNo='+orderNo,	
					 ajaxCallObject.callAjax(BASE_URL + "/order/getspecificorder/"+orderNo + ".htm",
					 function(response) {
						try {
							
							 var responseObj=JSON.parse(response);
			    											
						     //console.log("responseObj" + responseObj);
						     custId= responseObj.storeCustomerId;
						     console.log("custId" + custId);
						     
						     
							 ajaxCallObject
								.callAjax(
										BASE_URL + "/order/getcustomerdetailsbyid/"
												+ custId + ".htm",
										function(response) {
											try {
												console.log("responsebycustID=" + response);
												var custDetail = JSON.parse(response);
												if ($.isEmptyObject(custDetail)) {
													$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
													$("#modparcelcustName")
													.val("");
											$("#modparcelcustAddress").val(
													"");
											$("#modparceldeliveryPersonName").val(
													"");
											$("#modparcelcustvatorcst").val("");
											$("#modparcelcustlocation").val("");
										     $("#modparcelcusthouseno").val("");
										     $("#modparcelcuststreet").val("");
										     $("#modparcelcuststate").val("");

										     var date = new Date();
										     $("#modparcelcustdob").val(formatDate(date));
										     $("#modparcelcustanniversary").val(formatDate(date));
											$tabs = $('.nav-justified li');
										     var myArray = $(".nav-justified li a").map(function() {
										                   return $(this).text();
										                }).get();
										     for(var i = 0; i<myArray.length; i++)
										     {
										      if(myArray[i]!='Home')
										      {
										       $tabs.addClass('disabled');
										      }
										     }
												}else{
													console.log("id   " + custDetail.creditCust.id);
													custId=custDetail.creditCust.id;
													$tabs = $('.nav-justified li');
													$tabs.removeClass('disabled');
													$("#home").addClass('active');
													$("#transactionsummary").removeClass('disabled');
													$("#transactionhistory").removeClass('disabled');
					//console.log(custDetail);

													$("#modparcelcustName")
															.val(custDetail.custName);
													$("#modparcelcustAddress").val(
															custDetail.delivAddr);
													$("#modparceldeliveryPersonName").val(
															custDetail.delivPersonName);
													$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
													
													$("#modparcelcustlocation").val(custDetail.location);
													$("#modparcelcusthouseno").val(custDetail.houseNo);
													$("#modparcelcuststreet").val(custDetail.street);
													$("#modparcelcuststate").val(custDetail.creditCust.state);

													if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
												     {
												      
												      $("#modparcelcustdob").val(formatDate(custDetail.dob));
												     }
												     else {
												      $("#modparcelcustdob").val("");
												     }
												   //  console.log('><><><'+custDetail.anniversary);
												     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
												     {
												      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
												     }
												     else {
												      $("#modparcelcustanniversary").val("");
												     }
													
												}
												

											} catch (e) {
												console.log(e);
											}
										}, null);
						     
						     
						     
					}catch (e) {
						console.log(e);
					}
				}, null);
					 
					
	
				
			}
		else
			{
			
			ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getcustomerdetails/"
							+ customerContact + ".htm",
					function(response) {
						try {
							console.log("response=" + response);
							var custDetail = JSON.parse(response);
							if ($.isEmptyObject(custDetail)) {
								$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
								$("#modparcelcustName")
								.val("");
						$("#modparcelcustAddress").val(
								"");
						$("#modparceldeliveryPersonName").val(
								"");
						$("#modparcelcustvatorcst").val("");
						$("#modparcelcustlocation").val("");
					     $("#modparcelcusthouseno").val("");
					     $("#modparcelcuststreet").val("");
					     $("#modparcelcuststate").val("");

					     var date = new Date();
					     $("#modparcelcustdob").val(formatDate(date));
					     $("#modparcelcustanniversary").val(formatDate(date));
						$tabs = $('.nav-justified li');
					     var myArray = $(".nav-justified li a").map(function() {
					                   return $(this).text();
					                }).get();
					     for(var i = 0; i<myArray.length; i++)
					     {
					      if(myArray[i]!='Home')
					      {
					       $tabs.addClass('disabled');
					      }
					     }
							}else{
								console.log("id   " + custDetail.creditCust.id);
								custId=custDetail.creditCust.id;
								$tabs = $('.nav-justified li');
								$tabs.removeClass('disabled');
								$("#home").addClass('active');
								$("#transactionsummary").removeClass('disabled');
								$("#transactionhistory").removeClass('disabled');
//console.log(custDetail);

								$("#modparcelcustName")
										.val(custDetail.custName);
								$("#modparcelcustAddress").val(
										custDetail.delivAddr);
								$("#modparceldeliveryPersonName").val(
										custDetail.delivPersonName);
								$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
								
								$("#modparcelcustlocation").val(custDetail.location);
								$("#modparcelcusthouseno").val(custDetail.houseNo);
								$("#modparcelcuststreet").val(custDetail.street);
								$("#modparcelcuststate").val(custDetail.creditCust.state);

								if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
							     {
							      
							      $("#modparcelcustdob").val(formatDate(custDetail.dob));
							     }
							     else {
							      $("#modparcelcustdob").val("");
							     }
							   //  console.log('><><><'+custDetail.anniversary);
							     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
							     {
							      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
							     }
							     else {
							      $("#modparcelcustanniversary").val("");
							     }
								
							}
							

						} catch (e) {
							console.log(e);
						}
					}, null);

			}
		
		
	}
}*/




function searchCustomer() {
	
	
	var orderNo=$('#orderNo').find("option:selected").val();
	//console.log("orderDetails" + orderNo);
	
	var customerContact = document.getElementById("modparcelcustPhone").value;
	var customerID = document.getElementById("modparcelcustIdhidden").value;
	var customerName = document.getElementById("modparcelcustName").value;
	
	//alert(customerID + " + " customerContact + " + " + customerName);
	if (customerContact == '' &&  customerName == '')
	{
			//custId='0';
			//alert(custId);
			 customerContact = document.getElementById("itemContactSearch").value;
			 customerName = document.getElementById("itemNameSearch").value;
	}
	if ( customerContact == '' &&  customerName == '')
			{
		       customerID='0';
			}
	else{
		if(customerID!=null || customerID!='')
			{
			custId=customerID;
			}
	}
	//alert(customerID);
      if ( customerContact == '' &&  customerID == '' && calledFromSavedOrder=='no') {
	//	 alert('Please enter a valid number!');
		
		$("#modparceldeliveryPersonName").val("");
		$("#modparcelcustAddress").val("");
		$("#modparcelcustName").val("");
		$("#modparcelcustvatorcst").val("");
		$("#modparcelcustlocation").val("");
		$("#modparcelcusthouseno").val("");
		$("#modparcelcuststreet").val("");
		$("#modparcelcuststate").val("");

	//	var date = new Date();
		 $("#modparcelcustdob").val();
		 $("#modparcelcustanniversary").val();
		 
		document.getElementById('parcelCustModalalertMsg').innerHTML = 'Please enter a valid number!';
		document.getElementById('modparcelcustPhone').focus();
		$tabs = $('.nav-justified li');
	     var myArray = $(".nav-justified li a").map(function() {
	                   return $(this).text();
	                }).get();
	     for(var i = 0; i<myArray.length; i++)
	     {
	      if(myArray[i]!='Home')
	      {
	       $tabs.addClass('disabled');
	      }
	     }
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		 var deliveryPersonName=null;
		
		var deliveryPersonName=null;
		if(customerID == '' && orderNo!='0'){
		ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/"+orderNo + ".htm",
		function(response) {
			try{
						var responseObj=JSON.parse(response);
						custId= responseObj.storeCustomerId;
						deliveryPersonName=responseObj.deliveryPersonName;
						//alert("custId" + custId);
						customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) ;
			
			}catch (e) {
							console.log(e);
						}
					}, null);
		}
		
		else
			{
			 custId=customerID;
			 customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) ;
			
			}
		/*if(customerContact == '' && customerID =='')
			{
		//	console.log("orderDetails else" + orderNo);
			// ajaxCallObject.callAjax(BASE_URL+'/order/getspecificorder.htm?orderNo='+orderNo,	
//					 ajaxCallObject.callAjax(BASE_URL + "/order/getspecificorder/"+orderNo + ".htm",
//					 function(response) {
//						try {
//							
//							 var responseObj=JSON.parse(response);
//			    											
//						     //console.log("responseObj" + responseObj);
//						     custId= responseObj.storeCustomerId;
//						     console.log("custId" + custId);
			
								
					//alert("1st condition");
							 ajaxCallObject
								.callAjax(
										BASE_URL + "/order/getcustomerdetailsbyid/"
												+ custId + ".htm",
										function(response) {
											try {
												console.log("responsebycustID=" + response);
												var custDetail = JSON.parse(response);
												if ($.isEmptyObject(custDetail)) {
													$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
													$("#modparcelcustName")
													.val("");
											$("#modparcelcustAddress").val(
													"");
											$("#modparceldeliveryPersonName").val(
													"");
											$("#modparcelcustvatorcst").val("");
											$("#modparcelcustlocation").val("");
										     $("#modparcelcusthouseno").val("");
										     $("#modparcelcuststreet").val("");
										     $("#modparcelcuststate").val("");

										     var date = new Date();
										     $("#modparcelcustdob").val(formatDate(date));
										     $("#modparcelcustanniversary").val(formatDate(date));
											$tabs = $('.nav-justified li');
										     var myArray = $(".nav-justified li a").map(function() {
										                   return $(this).text();
										                }).get();
										     for(var i = 0; i<myArray.length; i++)
										     {
										      if(myArray[i]!='Home')
										      {
										       $tabs.addClass('disabled');
										      }
										     }
												}else{
													console.log("id   " + custDetail.creditCust.id);
													custId=custDetail.creditCust.id;
													$tabs = $('.nav-justified li');
													$tabs.removeClass('disabled');
													$("#home").addClass('active');
													$("#transactionsummary").removeClass('disabled');
													$("#transactionhistory").removeClass('disabled');
					//console.log(custDetail);

													$("#modparcelcustName")
															.val(custDetail.custName);
													$("#modparcelcustAddress").val(
															custDetail.delivAddr);
													$("#modparceldeliveryPersonName").val(
															deliveryPersonName);
													$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
													
													$("#modparcelcustlocation").val(custDetail.location);
													$("#modparcelcusthouseno").val(custDetail.houseNo);
													$("#modparcelcuststreet").val(custDetail.street);
													$("#modparcelcuststate").val(custDetail.creditCust.state);

													if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
												     {
												      
												      $("#modparcelcustdob").val(formatDate(custDetail.dob));
												     }
												     else {
												      $("#modparcelcustdob").val("");
												     }
												   //  console.log('><><><'+custDetail.anniversary);
												     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
												     {
												      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
												     }
												     else {
												      $("#modparcelcustanniversary").val("");
												     }
													
												}
												

											} catch (e) {
												console.log(e);
											}
										}, null);
						     
						     
						     
			
					
		
			}
		else if(customerContact != '')
			{
			
		//	alert("2nd condition");
			
			ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getcustomerdetails/"
							+ customerContact + ".htm",
					function(response) {
						try {
							console.log("response=" + response);
							var custDetail = JSON.parse(response);
							if ($.isEmptyObject(custDetail)) {
								$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
								$("#modparcelcustName")
								.val("");
						$("#modparcelcustAddress").val(
								"");
						$("#modparceldeliveryPersonName").val(
								"");
						$("#modparcelcustvatorcst").val("");
						$("#modparcelcustlocation").val("");
					     $("#modparcelcusthouseno").val("");
					     $("#modparcelcuststreet").val("");
					     $("#modparcelcuststate").val("");

					     var date = new Date();
					     $("#modparcelcustdob").val(formatDate(date));
					     $("#modparcelcustanniversary").val(formatDate(date));
						$tabs = $('.nav-justified li');
					     var myArray = $(".nav-justified li a").map(function() {
					                   return $(this).text();
					                }).get();
					     for(var i = 0; i<myArray.length; i++)
					     {
					      if(myArray[i]!='Home')
					      {
					       $tabs.addClass('disabled');
					      }
					     }
							}
							else{
								console.log("id   " + custDetail.creditCust.id);
								custId=custDetail.creditCust.id;
								$tabs = $('.nav-justified li');
								$tabs.removeClass('disabled');
								$("#home").addClass('active');
								$("#transactionsummary").removeClass('disabled');
								$("#transactionhistory").removeClass('disabled');
								//console.log(custDetail);

								$("#modparcelcustName")
										.val(custDetail.custName);
								$("#modparcelcustAddress").val(
										custDetail.delivAddr);
								$("#modparceldeliveryPersonName").val(
										deliveryPersonName);
								$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
								
								$("#modparcelcustlocation").val(custDetail.location);
								$("#modparcelcusthouseno").val(custDetail.houseNo);
								$("#modparcelcuststreet").val(custDetail.street);
								$("#modparcelcuststate").val(custDetail.creditCust.state);

								if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
							     {
							      
							      $("#modparcelcustdob").val(formatDate(custDetail.dob));
							     }
							     else {
							      $("#modparcelcustdob").val("");
							     }
							   //  console.log('><><><'+custDetail.anniversary);
							     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
							     {
							      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
							     }
							     else {
							      $("#modparcelcustanniversary").val("");
							     }
								
							}
							

						} catch (e) {
							console.log(e);
						}
					}, null);

			}
		else if(customerID !='')
			{
			
		     
			 ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getcustomerdetailsbyid/"
								+ customerID + ".htm",
						function(response) {
							try {
								console.log("responsebycustID=" + response);
								var custDetail = JSON.parse(response);
								if ($.isEmptyObject(custDetail)) {
									$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
									$("#modparcelcustName")
									.val("");
							$("#modparcelcustAddress").val(
									"");
							$("#modparceldeliveryPersonName").val(
									"");
							$("#modparcelcustvatorcst").val("");
							$("#modparcelcustlocation").val("");
						     $("#modparcelcusthouseno").val("");
						     $("#modparcelcuststreet").val("");
						     $("#modparcelcuststate").val("");

						     var date = new Date();
						     $("#modparcelcustdob").val(formatDate(date));
						     $("#modparcelcustanniversary").val(formatDate(date));
							$tabs = $('.nav-justified li');
						     var myArray = $(".nav-justified li a").map(function() {
						                   return $(this).text();
						                }).get();
						     for(var i = 0; i<myArray.length; i++)
						     {
						      if(myArray[i]!='Home')
						      {
						       $tabs.addClass('disabled');
						      }
						     }
								}else{
									console.log("id   " + custDetail.creditCust.id);
									custId=custDetail.creditCust.id;
									$tabs = $('.nav-justified li');
									$tabs.removeClass('disabled');
									$("#home").addClass('active');
									$("#transactionsummary").removeClass('disabled');
									$("#transactionhistory").removeClass('disabled');
	//console.log(custDetail);

									$("#modparcelcustName")
											.val(custDetail.custName);
									$("#modparcelcustAddress").val(
											custDetail.delivAddr);
									$("#modparceldeliveryPersonName").val(
											deliveryPersonName);
									$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
									
									$("#modparcelcustlocation").val(custDetail.location);
									$("#modparcelcusthouseno").val(custDetail.houseNo);
									$("#modparcelcuststreet").val(custDetail.street);
									$("#modparcelcuststate").val(custDetail.creditCust.state);

									if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
								     {
								      
								      $("#modparcelcustdob").val(formatDate(custDetail.dob));
								     }
								     else {
								      $("#modparcelcustdob").val("");
								     }
								   //  console.log('><><><'+custDetail.anniversary);
								     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
								     {
								      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
								     }
								     else {
								      $("#modparcelcustanniversary").val("");
								     }
									
								}
								

							} catch (e) {
								console.log(e);
							}
						}, null);
			}*/
		
		}
		 
	}


function customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) {
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	if(customerContact == '' && customerID =='')
	{
				     
					 ajaxCallObject
						.callAjax(
								BASE_URL + "/order/getcustomerdetailsbyid/"
										+ custId + ".htm",
								function(response) {
									try {
										console.log("responsebycustID=" + response);
										var custDetail = JSON.parse(response);
										alert(custDetail);
										if ($.isEmptyObject(custDetail)) {
											$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
											$("#modparcelcustName")
											.val("");
									$("#modparcelcustAddress").val(
											"");
									$("#modparceldeliveryPersonName").val(
											"");
									$("#modparcelcustvatorcst").val("");
									$("#modparcelcustlocation").val("");
								     $("#modparcelcusthouseno").val("");
								     $("#modparcelcuststreet").val("");
								     $("#modparcelcuststate").val("");

								
								     $("#modparcelcustdob").val("");
								     $("#modparcelcustanniversary").val("");
									$tabs = $('.nav-justified li');
								     var myArray = $(".nav-justified li a").map(function() {
								                   return $(this).text();
								                }).get();
								     for(var i = 0; i<myArray.length; i++)
								     {
								      if(myArray[i]!='Home')
								      {
								       $tabs.addClass('disabled');
								      }
								     }
										}else{
											document.getElementById('parcelCustModalalertMsg').innerHTML = "";
											console.log("id   " + custDetail.creditCust.id);
											custId=custDetail.creditCust.id;
											$tabs = $('.nav-justified li');
											$tabs.removeClass('disabled');

											$("#modparcelcustName")
													.val(custDetail.custName);
											$("#modparcelcustAddress").val(
													custDetail.delivAddr);
											$("#modparceldeliveryPersonName").val(
													deliveryPersonName);
											$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
											
											$("#modparcelcustlocation").val(custDetail.location);
											$("#modparcelcusthouseno").val(custDetail.houseNo);
											$("#modparcelcuststreet").val(custDetail.street);
											$("#modparcelcuststate").val(custDetail.creditCust.state);
											

											if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
										     {
										      
										      $("#modparcelcustdob").val(formatDate(custDetail.dob));
										     }
										     else {
										      $("#modparcelcustdob").val("");
										     }
										   //  console.log('><><><'+custDetail.anniversary);
										     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
										     {
										      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
										     }
										     else {
										      $("#modparcelcustanniversary").val("");
										     }
											
										}
										

									} catch (e) {
										console.log(e);
									}
								}, null);
				     
	}
else  if(customerContact != '')
	{
	
	ajaxCallObject
	.callAjax(
			BASE_URL + "/order/getcustomerdetails/"
					+ customerContact + ".htm",
			function(response) {
				try {
					console.log("responseByCustContact=" + response);
					var custDetail = JSON.parse(response);
					//alert(JSON.stringify(custDetail));
					if ($.isEmptyObject(custDetail)) {
						$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
						$("#modparcelcustName")
						.val("");
				$("#modparcelcustAddress").val(
						"");
				$("#modparceldeliveryPersonName").val(
						"");
				$("#modparcelcustvatorcst").val("");
				$("#modparcelcustlocation").val("");
			     $("#modparcelcusthouseno").val("");
			     $("#modparcelcuststreet").val("");
			     $("#modparcelcuststate").val("");

			     $("#modparcelcustdob").val("");
			     $("#modparcelcustanniversary").val("");
				$tabs = $('.nav-justified li');
			     var myArray = $(".nav-justified li a").map(function() {
			                   return $(this).text();
			                }).get();
			     for(var i = 0; i<myArray.length; i++)
			     {
			      if(myArray[i]!='Home')
			      {
			       $tabs.addClass('disabled');
			      }
			     }
					}else{
						document.getElementById('parcelCustModalalertMsg').innerHTML = "";
						console.log("id   " + custDetail.creditCust.id);
						custId=custDetail.creditCust.id;
						$tabs = $('.nav-justified li');
						$tabs.removeClass('disabled');

						$("#modparcelcustName")
								.val(custDetail.custName);
						$("#modparcelcustAddress").val(
								custDetail.delivAddr);
						$("#modparceldeliveryPersonName").val(
								deliveryPersonName);
						$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
						
						$("#modparcelcustlocation").val(custDetail.location);
						$("#modparcelcusthouseno").val(custDetail.houseNo);
						$("#modparcelcuststreet").val(custDetail.street);
						$("#modparcelcuststate").val(custDetail.creditCust.state);
						
						if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
					     {
					      
					      $("#modparcelcustdob").val(formatDate(custDetail.dob));
					     }
					     else {
					      $("#modparcelcustdob").val("");
					     }
					   //  console.log('><><><'+custDetail.anniversary);
					     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
					     {
					      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
					     }
					     else {
					      $("#modparcelcustanniversary").val("");
					     }
						
					}
					

				} catch (e) {
					console.log(e);
				}
			}, null);

	}
else if(customerID !='')
	{
     
	 ajaxCallObject
		.callAjax(
				BASE_URL + "/order/getcustomerdetailsbyid/"
						+ customerID + ".htm",
				function(response) {
					try {
						console.log("responsebycustID=" + response);
						var custDetail = JSON.parse(response);
						if ($.isEmptyObject(custDetail)) {
							$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
							$("#modparcelcustName")
							.val("");
					$("#modparcelcustAddress").val(
							"");
					$("#modparceldeliveryPersonName").val(
							"");
					$("#modparcelcustvatorcst").val("");
					$("#modparcelcustlocation").val("");
				     $("#modparcelcusthouseno").val("");
				     $("#modparcelcuststreet").val("");
				     $("#modparcelcuststate").val("");

				     $("#modparcelcustdob").val("");
				     $("#modparcelcustanniversary").val("");
					$tabs = $('.nav-justified li');
				     var myArray = $(".nav-justified li a").map(function() {
				                   return $(this).text();
				                }).get();
				     for(var i = 0; i<myArray.length; i++)
				     {
				      if(myArray[i]!='Home')
				      {
				       $tabs.addClass('disabled');
				      }
				     }
						}else{
							document.getElementById('parcelCustModalalertMsg').innerHTML = "";
							console.log("id   " + custDetail.creditCust.id);
							custId=custDetail.creditCust.id;
							$tabs = $('.nav-justified li');
							$tabs.removeClass('disabled');

							$("#modparcelcustName")
									.val(custDetail.custName);
							$("#modparcelcustAddress").val(
									custDetail.delivAddr);
							$("#modparceldeliveryPersonName").val(
									deliveryPersonName);
							$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
							
							$("#modparcelcustlocation").val(custDetail.location);
							$("#modparcelcusthouseno").val(custDetail.houseNo);
							$("#modparcelcuststreet").val(custDetail.street);
							$("#modparcelcuststate").val(custDetail.creditCust.state);
							

							if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
						     {
						      
						      $("#modparcelcustdob").val(formatDate(custDetail.dob));
						     }
						     else {
						      $("#modparcelcustdob").val("");
						     }
						   //  console.log('><><><'+custDetail.anniversary);
						     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
						     {
						      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
						     }
						     else {
						      $("#modparcelcustanniversary").val("");
						     }
							
						}
						

					} catch (e) {
						console.log(e);
					}
				}, null);
	}
}


function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}





function gotransactionsummary()
{
//	var searchedCustId=custId;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getTotaltransactionPerCustomer/" + custId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			
		//	console.log("responseObj " + responseObj);
			 document.getElementById('modtotaltransaction').innerHTML=parseFloat(responseObj).toFixed(2);
		
		}catch(e)
		{
			alert(e);
		}
		}, null);
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getLastVisitDate/" + custId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			
			console.log("responseObj " + response);
			var lastvisit = responseObj[1];
			var fields = lastvisit.split(':');

			//var name = fields[0];
			var lastdate = fields[1];
		//	qty = lastvisit.last_Visit_Date;
		//	console.log("lastvisit " + lastdate);
			var dayDiff = responseObj[2];
			var fields1 = dayDiff.split(':');
			var dayDiffTotal = fields1[1];
			if(parseInt(dayDiffTotal)==0){
			    
			    document.getElementById('modlastvisitdate').innerHTML=lastdate + " ( Today )";
			   }
			   else if(parseInt(dayDiffTotal)==1){
			    
			    document.getElementById('modlastvisitdate').innerHTML=lastdate + " ( " + dayDiffTotal+ " day ago )";
			   }
			   else {
			   
			    document.getElementById('modlastvisitdate').innerHTML=lastdate + " ( " + dayDiffTotal+ " days ago )";
			   }			 

		}catch(e)
		{
			//alert("tt:"+e);
		}
		}, null);
	

	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getcustmostpurchaseItem/" + custId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			
			console.log("responseObj " + responseObj);
			 var createdrowline = "";
			for(var i=0;i<responseObj.length;i++)
			{
			var  item = responseObj[i];
			 var itemname=item[3];
			 var itemqty=item[4];
			 var fieldsforname = itemname.split(':');
			 var fieldsforqty=itemqty.split(':');
			 

			 
			 var startTrline = "<tr style=''>";
			    var firstTdline = "<td style=' max-width: 50px !important; color:#fff; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>" + (i+1) + "</td>";
			    var secondTdline = "<td style=' max-width: 50px !important; color:#fff; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>" + fieldsforname[1] + "</td>";
			    var thirdTdline = "<td style=' color:#fff; font-size: 18px;font-family: sans-serif;'>" + fieldsforqty[1] + "</td>";
			    var endTrline = "</tr>";
			    createdrowline += startTrline + firstTdline  + secondTdline + thirdTdline + endTrline;	 
			
			 //("#modmostpurchaseitems").append(createdrowline);
			}
			document.getElementById('modmostpurchaseitems').innerHTML=createdrowline;
		}catch(e)
		{
			alert("tt1:"+e);
		}
		}, null);

}

function gotransactionhistory()
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getcustomertransactionsummery/" + custId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			
			console.log("responseObj " + responseObj);
			 var createdrowline = "";
			for(var i=0;i<responseObj.length;i++)
			{
			var  item = responseObj[i];
			var orderid=item[0];
			var orderno=item[1];
			 var amount=item[2];
			 var paidamt=item[3];
			 var amounttopay=item[4];
			 var orderdate=item[5];
			 var fieldsfororderid=orderid.split(':');
			 var fieldsfororderno=orderno.split(':');
			 var fieldsforamount = amount.split(':');
			 var fieldsforpaidamt=paidamt.split(':');
			 var fieldsforamounttopay=amounttopay.split(':');
			 var fieldsfororderdate=orderdate.split(':');
			 console.log("fieldsforamount " + fieldsforamount[1] + "fieldsforpaidamt " + fieldsforpaidamt[1] + "fieldsforamounttopay " + fieldsforamounttopay[1] +"fieldsfororderdate" + fieldsfororderdate );
			 

			 var startTrline = "<tr style='padding: 1px;'>";
			 var fourTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>" + fieldsforpaidamt[1] + "</td>";
			 var firstTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; max-width: 50px !important; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>" + fieldsfororderno[1] + "</td>";
			 var secondTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>" + fieldsfororderdate[1] + "</td>";
			 var thirdTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>" + fieldsforamount[1] + "</td>";
			 var fifthTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>" + fieldsforamounttopay[1] + "</td>";

			
			 var endTrline = "</tr>";

			 createdrowline += startTrline + firstTdline  + secondTdline + thirdTdline + fourTdline + fifthTdline + endTrline;
			
			 //("#modmostpurchaseitems").append(createdrowline);
			}
			document.getElementById('modcusttransactionsummary').innerHTML=createdrowline;
		}catch(e)
		{
			alert(e);
		}
		}, null);
}
function cancelCustomer(){
	  if(orderVal==null || orderVal=='')
{
		  document.getElementById("modparcelcustPhone").value="";
			 document.getElementById("modparcelcustName").value="";
			 document.getElementById("modparcelcustAddress").value="";
			 document.getElementById("modparceldeliveryPersonName").value="";
			 document.getElementById("modparcelcustlocation").value="";
			 document.getElementById("modparcelcustvatorcst").value="";
			 document.getElementById("modparcelcusthouseno").value="";
			 document.getElementById("modparcelcuststreet").value="";
			 document.getElementById("modparcelcuststate").value="";
			 document.getElementById("itemNameSearch").value="";
			 document.getElementById("itemContactSearch").value="";

			 document.getElementById('parcelCustModalalertMsg').innerHTML=""; 
			 var date = new Date();
			 $("#modparcelcustdob").val(formatDate(date));
			 $("#modparcelcustanniversary").val(formatDate(date));
			 
			 
			   $("st-nav-tabs li:first").addClass("active");
			    $('#customerdetails a[href="#home"]').tab('show');
			 var myArray = $(".nav-justified li a").map(function() {
			         return $(this).text();
			      }).get();
			 for(var i = 0; i<myArray.length; i++)
			 {
			  if(myArray[i]!='Home')
			  {
			   $tabs.addClass('disabled');
			  }
			 }
			 disbleDetailEnblAdd();
	
}
		 
		 else
		  {
		   $("st-nav-tabs li:first").addClass("active");
		      $('#customerdetails a[href="#home"]').tab('show');
		  }
	
	 
	 
	 
	 
//	 $(".tab-content").hide().first().show();
}
function gopaymentsummary()
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getTotalPaidAmt/" + custId  + ".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			/*if (responseObj=='')
			 {
			    
			    document.getElementById('previouspaymenthistorydiv').style.display='none';
			    document.getElementById('nopreviouspaymenthistorydiv').style.display='block';

			 }
			   else {*/
			var  qty = responseObj[0];
		
			var totalpaidamt=qty[3];
			var orderdate=qty[1];
			var paidamt=qty[2];
			var dayDiff = qty[4];
			   
			   var fields1 = dayDiff.split(':');
			   var dayDiffTotal = fields1[1];
			console.log("qty " + qty + "totalpaidamt " +totalpaidamt);
			var fieldsforpaidamt = totalpaidamt.split(':');
			var fieldsforlastorderdate=orderdate.split(':');
			var fieldsforlastorderpaidamt=paidamt.split(':');
			//var name = fields[0];
			var paidamount = fieldsforpaidamt[1];
			var lastorderdate=fieldsforlastorderdate[1];
			var lastorderpaidamt=fieldsforlastorderpaidamt[1];
			 document.getElementById('modtotalpaidamt').innerHTML=paidamount;
			 if(parseInt(dayDiffTotal)==0){
			     
			     document.getElementById('modlastorderdate').innerHTML=lastorderdate + " ( Today )";
			    }
			    else if(parseInt(dayDiffTotal)==1){
			     
			     document.getElementById('modlastorderdate').innerHTML=lastorderdate + " ( " + dayDiffTotal+ " day ago )";
			    }
			    else {
			    
			     document.getElementById('modlastorderdate').innerHTML=lastorderdate + " ( " + dayDiffTotal+ " days ago )";
			    }
			 
			 document.getElementById('modlastorderpaidamt').innerHTML=lastorderpaidamt;
			
			 if (parseFloat(paidamount).toFixed(2) == "0.00") {

		         document
		           .getElementById('previouspaymenthistorydiv').style.display = 'none';
		         document
		           .getElementById('nopreviouspaymenthistorydiv').style.display = 'block';

		        }
		        else
		         {
		         document
		         .getElementById('nopreviouspaymenthistorydiv').style.display = 'none';
		         document
		         .getElementById('previouspaymenthistorydiv').style.display = 'block';
		         }
			   //}
		}catch(e)
		{
			//alert(e);
		}
		}, null);
}

/*end split payment */
function  round(value,places) {
    var factor = Math.pow(10, places);
    value = value * factor;
    var tmp = Math.round(value);
    return tmp / factor;
}


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
//	location.href = BASE_URL + '/table/viewtable.htm';
}

function printCashOrCardLocal80() {

	var divToPrint = document.getElementById('printDiv80');
	document.getElementById('cashRemovePrint80').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('cashRemovePrint80').style.display = 'block';

	newWin.close();
//	location.href = BASE_URL + '/table/viewtable.htm';
}



function printCashOrCardLocal2100() {
	// $('#printDiv2100GST').modal('show');
	//var divToPrint = document.getElementById('printDiv2100');
	//alert("div2100gst");
	var divToPrint = document.getElementById('printDiv2100GST');
	//document.getElementById('cashRemovePrint2100').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	//newWin.document.close();
	newWin.focus();
	newWin.print();
	//document.getElementById('cashRemovePrint2100').style.display = 'block';
	
	newWin.close();

}
function printCorporateBillData() {
	var divToPrint = document.getElementById('printDivCorporate');
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.focus();
	newWin.print();
	newWin.close();
 }
function cashOrcardPrintBill() {
	
 	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
//	alert("caseValue >> "+caseValue);
	var order = {};
	var orderId = document.getElementById('orderNo').value;
	order.id = orderId;
	order.storeId = storeID;
//	  alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
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
				var orderNo = jsonObj.id;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var customerAddr = jsonObj.customers.address;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;

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

				if (printbillpapersize == '58.00') {

					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeName58').text(customerName);
					$('#storeAddr58').text(customerAddr);
					$('#storeEmail58').text(customerEmail);
					$('#storePhNo58').text(customerPhNo);
					$('#orderValue58').text(orderNo);
					$('#tableNoValue58').text(tabNo);
					
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						// alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

						var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

					//	$("#itemDetailsPrint58").append(createdrowline);

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

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount58').text(paidAmt);

						$('#tenderAmount58').text(tenderAmt);
						$('#refund_amount_58px').text(Math.floor(returnAmt * 100) / 100);
						$('#payType_58').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount58').text(paidAmt);
						$('#tenderAmount58').text(tenderAmt);
						$('#refundAmount58').text("0.00");
						$('#payType58').text(type1 + type2);
					}

					//	$('#helloPrintModal58').modal('show');	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal58();
						}
					}

					if (paymentsObj == 2) {
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							printCashOrCardLocal58();
						}
					}

				} else if(printbillpapersize == '80.00') {
					/* ****** Print in 80 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeName80').text(customerName);
					$('#storeAddr80').text(customerAddr);
					$('#storeEmail80').text(customerEmail);
					$('#storePhNo80').text(customerPhNo);
					$('#cashOrdervalue80').text(orderNo);
					$('#cashtableNoValue80').text(tabNo);

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
					} else {
						$("#cashshowDiscount80px").hide();
					}

					$("#cashgrossAmount80").text(billAmt);
					$("#cashamoutToPay80").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text(Math.floor(returnAmt * 100) / 100);
						$('#payType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text("0.00");
						$('#payType80').text(type1 + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** 	*/

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal80();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal80();
						}
					}

				}else if(printbillpapersize == '2100.00'){
					
			//		alert("printbillpapersize 2 >> "+printbillpapersize);
					
					$('#storeName2100').text(customerName);
					$('#storeAddr2100').text(storeAddr);
					$('#storeEmail2100').text("Email :"+customerEmail);
					$('#storePhNo2100').text("Ph :"+customerPhNo);
					$('#cashOrdervalue2100').text(orderNo);
					$('#cashtableNoValue2100').text(tabNo);

					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

				//		alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center'>" + itemQty + "</td>";
						var thirdTdline = "<td style='font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrint2100").append(createdrowline);

					}

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

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text("0.00");
						$('#payType2100').text(type1 + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** */	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal2100();
						}
					}
				}

			}
		});

	} else {
		var orderid = document.getElementById('orderNo').value;

		//alert(orderid);
		// var tableno=document.getElementById('tablenoCont').innerHTML;
		if (orderid == 0 || forspNoteData.length > 0) {
			// alert('Please save the order first!');
			showalertsaveorderModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid + ".htm", function(response) {
				try {
					if (response == 'Success')
						showBillPrintSuccessModal();

				} catch (e) {
					alert(e);
				}
			}, null);
		}
	}

}

function showCustomerDetails(name, contact, delAddr) {
   
	 var custName = name;
	 var custPh = contact;
	 var delAddress = delAddr;
	 
	if(custName.length > 0 || custPh.length > 0){
	  
		 $('#cust_name').show();
    	 $('#cust_ph').show();
    	 $('#del_addr').show();
    	 $('#notFoundCustomer').hide();
    	 
	   document.getElementById('custName').innerHTML=name;
	   document.getElementById('custPh').innerHTML=contact;
	   document.getElementById('delAddr').innerHTML=delAddr;
	   $('#customermodel').modal('show');
      
     } else {
    	
    	 $('#cust_name').hide();
    	 $('#cust_ph').hide();
    	 $('#del_addr').hide();
    	 $('#notFoundCustomer').show();
    	 $('#customermodel').modal('show');
     
     }
}



function printBillWithReason() {
	//var printbillcount=$("#printbillcount").val();
	$("#printbillresonreq").addClass("hide");
	var orderid = document.getElementById('orderNo').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getprintcount/" + orderid + ".htm", function(response) {
	//	alert(response);
		if (response == 0) {
			$("#printbillcount").val(0);
			//alert($("#printbillcount").val());
			printBill();
		} else {
			$("#printbillcount").val(response);
			$("#printBillReasonModal").modal("show");
		}
	}, null);

}

function printBillCountt(printbillcount) {
	//var printbillcount = $("#printbillcount").val();
	var printreason = $("#printbillreasonId").val();
	
	if (printbillcount == 0) {
		printBill();
	} else {
		if (printreason == '') {
			$("#printbillresonreq").removeClass("hide");
		} else {
			$("#printbillresonreq").addClass("hide");
			$("#printBillReasonModal").modal("hide");
			printBill();
		}
	}
}


$('#ncbill').click(function() {
	if ($(this).prop("checked") == true) {
		$("#trdiscperc").hide();
		$("#trdiscamt").hide();
	} else if ($(this).prop("checked") == false) {
		$("#trdiscperc").show();
		$("#trdiscamt").show();
	}
});


/* ============== Convert number to Word in currency ========================*/

function number2text(value) {
    var fraction = Math.round(frac(value)*100);
    var f_text  = "";

    if(fraction > 0) {
        f_text = "AND "+convert_number(fraction)+" PAISE";
    }

    return convert_number(value)+" RUPEE "+f_text+" ONLY";
}

function frac(f) {
    return f % 1;
}

function convert_number(number)
{
    if ((number < 0) || (number > 999999999)) 
    { 
        return "NUMBER OUT OF RANGE!";
    }
    var Gn = Math.floor(number / 10000000);  /* Crore */ 
    number -= Gn * 10000000; 
    var kn = Math.floor(number / 100000);     /* lakhs */ 
    number -= kn * 100000; 
    var Hn = Math.floor(number / 1000);      /* thousand */ 
    number -= Hn * 1000; 
    var Dn = Math.floor(number / 100);       /* Tens (deca) */ 
    number = number % 100;               /* Ones */ 
    var tn= Math.floor(number / 10); 
    var one=Math.floor(number % 10); 
    var res = ""; 

    if (Gn>0) 
    { 
        res += (convert_number(Gn) + " CRORE"); 
    } 
    if (kn>0) 
    { 
            res += (((res=="") ? "" : " ") + 
            convert_number(kn) + " LAKH"); 
    } 
    if (Hn>0) 
    { 
        res += (((res=="") ? "" : " ") +
            convert_number(Hn) + " THOUSAND"); 
    } 

    if (Dn) 
    { 
        res += (((res=="") ? "" : " ") + 
            convert_number(Dn) + " HUNDRED"); 
    } 


    var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX","SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN","FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN","NINETEEN"); 
var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY","SEVENTY", "EIGHTY", "NINETY"); 

    if (tn>0 || one>0) 
    { 
        if (!(res=="")) 
        { 
            res += " AND "; 
        } 
        if (tn < 2) 
        { 
            res += ones[tn * 10 + one]; 
        } 
        else 
        { 

            res += tens[tn];
            if (one>0) 
            { 
                res += (ones[one]); 
            } 
        } 
    }

    if (res=="")
    { 
        res = "zero"; 
    } 
    return res;
}




var matchedOrderType=[];

function selectedOrderType()
{
	
	var orderText=$('#orderType').find("option:selected").text();
	var storeroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
	var netPrice=0.0;
	
	
	 for(var i=0; i<responseObjOrderType.length; i++)
		 {
		 
		  if(orderText==responseObjOrderType[i].orderTypeName)
	    	{
	    	matchedOrderType=responseObjOrderType[i].serviceChargeValue;
         
	   if(matchedOrderType==0.0 || scflag!='Y')
		   {
		 //  document.getElementById('serviceChargeSpan').style.display=none;
		   $("#serviceChargeSpan").hide();
		   }
	   else if(matchedOrderType!=0.0 && scflag=='Y'){
		 //  document.getElementById('serviceChargeSpan').style.display=block;
		   $("#serviceChargeSpan").show();
	   
		document.getElementById('serviceCharge').innerHTML="(" + matchedOrderType + "%)";
		document.getElementById('schrgId').innerHTML=serviceCharge;
	   }
	   
		var serviceCharge=($("#subtotalcontId").text())*matchedOrderType/100;
		//document.getElementById('schrgId').innerHTML=serviceCharge;
		var subtotalcontainerId=$("#subtotalcontId").text();

		var totalAmount=(Number(VATamt) + Number(serviceCharge) + Number(subtotalcontainerId) + Number(servTax));
	//	alert("totalAmount" + totalAmount);
		var netPrice=0.0;
		netPrice=totalAmount-PaidAmtVal-CustdiscAmtVal;
	//	alert("netPrice" + netPrice);
		
		if(storeroundoffflag=='Y')
		{
			totalAmount=Math.round(totalAmount);
			netPrice=Math.round(netPrice);
		}
		document.getElementById('grandtotalcontId').innerHTML=parseFloat(totalAmount).toFixed(2);
		document.getElementById('amttopaycontId').innerHTML=parseFloat(netPrice).toFixed(2);

		
		$("#serviceChargeRate").val(matchedOrderType);
		
		/*var ajaxCallObject = new CustomBrowserXMLObject();
		   ajaxCallObject.callAjax(BASE_URL+'/order/setordertypeservicecharge.htm?matchedOrderType='+JSON.stringify(responseObjOrderType[i]),
		    		 function(response) {
			   
			   		alert("in ajx:"+response);	
		    		 try {
		    			
		    			 var responseObj=JSON.parse(response);
		    				prepareOrderHtml(responseObj);

		    	
		    		 } catch (e) {
		    		        alert(e);
		    	     }
		    	    }, null);*/

		$.ajax({
			url : BASE_URL + "/order/setordertypeservicecharge.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(responseObjOrderType[i]),
			success : function(	response,
								JSON_UNESCAPED_UNICODE) {
				 var responseObj=JSON.parse(response);
 				prepareOrderHtml(responseObj);
				//console.log(">>>>>> " + response);
			}
		});	
		 }
		 }
}
  		

var responseObjOrderType = [];
function getAllOrderType()
{
   
	 //alert("storeID>>> " + storeID);
	 var ajaxCallObject = new CustomBrowserXMLObject();

	 ajaxCallObject.callAjax(BASE_URL + "/order/getordertype/"+storeID + ".htm",
	 function(response) {
	 try {
	
	
		 responseObjOrderType = JSON.parse(response);
		
		 var orderText=$('#orderType').find("option:selected").text();
		 	if(scflag=='Y' || scflag=="y")
		 		{
		 		for(var i=0; i<responseObjOrderType.length; i++)
				 {
			
				   if(orderText==responseObjOrderType[i].orderTypeName)
			    	{
					  
			    	matchedOrderType=responseObjOrderType[i].serviceChargeValue;
			   	document.getElementById('serviceChargeRate').value=matchedOrderType;
			   	
			   	if(matchedOrderType==0.0)
			     {
			   //  document.getElementById('serviceChargeSpan').style.display=none;
			     $("#serviceChargeSpan").hide();
			     }
			    else{
			   //  document.getElementById('serviceChargeSpan').style.display=block;
			     $("#serviceChargeSpan").show();
					document.getElementById('serviceCharge').innerHTML="(" + matchedOrderType + "%)";

			    }
			   	
			    ajaxCallObject.callAjax(BASE_URL+'/order/setordertypeservicecharge.htm?matchedOrderType='+JSON.stringify(responseObjOrderType[i]),
			    		 function(response) {
			    		 try {
			    	
			    		 } catch (e) {
			    		        alert(e);
			    	     }
			    	    }, null);
			    	
			    	
			    	
			    	}
				 
				 }
		 		}
		 	else
		 		{
		 		 $("#serviceChargeSpan").hide();
		 		}
				 
		 
		 
	 } catch (e) {
	        alert(e);
     }
    }, null);
	  

}



function openAssignDelBoyModal() {
	var orderno = document.getElementById('orderNo').value;
	document.getElementById('assigndelboyalertMsg').innerHTML = "";	
	if (orderno == 0) {
		showalertsaveorderModal();
	} else {
		showAssignDeliveryBoyModal();
	}
}


var delBoyDetail = [];
function showAssignDeliveryBoyModal()
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/deliveryboy/getdeliveryboy.htm",
					function(response) {
						var responseObj = [];
						responseObj = JSON.parse(response);
						delBoyDetail=responseObj;
						var optionline = "";
						if(storeID == 168){
							optionline += "<option value='0'> Select Doctor </option>";
						}
						else{
							optionline += "<option value='0'> Select Del. Boy </option>";
						}
						
						for ( var i = 0; i < responseObj.length; i++) {
							var id = responseObj[i].id;
							var name = responseObj[i].name;
							/*optionline += "<option value='" + id + "'style='text-indent:10px;'>" + name
									+ "</option>";*/
							if(orderDeliveryPerson!="")
					        {
					         if(orderDeliveryPerson==responseObj[i].name)
					          {
					          optionline += "<option value='" + id + "'style='text-indent:10px;' selected='selected'>" + name
					          + "</option>";
					          }
					         else {
					          optionline += "<option value='" + id + "'style='text-indent:10px;'>" + name
					          + "</option>";
					          }
					        }
					       else {
					        optionline += "<option value='" + id + "'style='text-indent:10px;'>" + name
					        + "</option>";
					       }
							
							
							
							
							
							
							
						}
						document.getElementById('deliveryboyName').innerHTML = optionline;
						
						   $('#AssignDelBoyModal').modal('show');
					}, null);
}

var orderdeliveryBoy = {};
function selectDelBoy() {

	var id = document
	   .getElementById('deliveryboyName').value;
	if(id!=0)
	{
		for( var i = 0; i < delBoyDetail.length; i++)
		{
			orderdeliveryBoy = {};
			if(delBoyDetail[i].id == id) {

				var orderno = document.getElementById('orderNo').value;
				orderdeliveryBoy.orderId=orderno;
				orderdeliveryBoy.deliveryPersonName=delBoyDetail[i].name;
				/*orderdeliveryBoy.deliveryPersonAddress=delBoyDetail[i].address;
				orderdeliveryBoy.deliveryPersonphone_no=delBoyDetail[i].phone_no;
				orderdeliveryBoy.deliveryPersonemail=delBoyDetail[i].email;
				orderdeliveryBoy.DOB=delBoyDetail[i].DOB;
				orderdeliveryBoy.DOJ=delBoyDetail[i].DOJ;
				orderdeliveryBoy.uniqueId=delBoyDetail[i].uniqueId;*/
				orderdeliveryBoy.store_id=delBoyDetail[i].store_id;
				break;
			}
		}
	}
	
}

function assignDeliveryBoy() {
	
	var id = document
	   .getElementById('deliveryboyName').value;
	
	if(id!=0)
	{
		console.log(JSON.stringify(orderdeliveryBoy));
		$.ajax({
			url : BASE_URL + "/deliveryboy/assigndelboy.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(orderdeliveryBoy),
			success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						if (response === 'success') {
							closedeliveryboyassignModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = "Data is sucessfully added!";
							showalertdeliveryboydataopModal();
						} else {
							closedeliveryboyassignModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = "Data is not added.Please try again!";
							showalertdeliveryboydataopModal();
						}
					}
				});
	}
	else{
		document.getElementById('assigndelboyalertMsg').innerHTML = "Please Select a Delivery Boy First!";	
	}
}

function closedeliveryboyassignModal()
{
	$('#AssignDelBoyModal').modal('hide');
}


function showalertdeliveryboydataopModal()
	{
		$('#alertdeliveryboydataopModal').modal('show');
	}


function updatetaxAllItem() {
	var taxRows = [];
	var vattxt = null;
	var vatamt = 0.0;
	var sttxt = null;
	var stamt = 0.0;
	var checkboxes = document.getElementsByName('taxChk');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			taxRows.push(checkboxes[i].value);
		}
	}
	if (taxRows.length > 0) {
		for ( var j = 0; j < taxRows.length; j++) {
			if (taxRows[j] == 'vatval') {
				vattxt = document.getElementById('hidvattxt').value;
				vatamt = document.getElementById('vatAmtTxt').value;
				if (isNaN(vatamt)) {
					showcorrectnumberModal();
					return;
				}
			}
			if (taxRows[j] == 'stval') {
				sttxt = document.getElementById('hidsttxt').value;
				stamt = document.getElementById('stAmtTxt').value;
				if (isNaN(vatamt)) {
					showcorrectnumberModal();
					return;
				}
			}
		}
		

		var taxString = {};
		taxString.vatTaxText = vattxt;
		taxString.vatAmt = vatamt;
		taxString.serviceTaxText = sttxt;
		taxString.serviceTaxAmt = stamt;

		$.ajax({
			url : BASE_URL + '/taxmgnt/updatetaxforallitem.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(taxString),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				closeselcttaxModal();
				if (response == 'success') {
					showtaxupdatesuccessModal();
				} else {

				}
			}

		})

	} else {
		showselcttaxModal();
	}
}

function enablevatTxt(chk)
{
	if(chk.checked==true)
	document.getElementById('vatAmtTxt').disabled=false;
	else
	document.getElementById('vatAmtTxt').disabled=true;	
}
function enablestTxt(chk)
{
	if(chk.checked==true)
	document.getElementById('stAmtTxt').disabled=false;
	else
	document.getElementById('stAmtTxt').disabled=true;	
}
function jLogout()
{
	

	
var ajaxCallObject = new CustomBrowserXMLObject();

ajaxCallObject.callAjax(BASE_URL + "/order/reload.htm",
function(response) {
	
		location.href=BASE_URL+'/order/vieworder.htm?ono=0&tno=0&sno=0';

		

}, null);


}

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

function dsblPayByCashButton(){
	 document.getElementById('paybycashbtn').style.backgroundColor="#F00";
	 document.getElementById('paybycashbtn').disabled = true; 
	}

function enblPayByCashButton(){
	 document.getElementById('paybycashbtn').style.backgroundColor="#72BB4F";
	 document.getElementById('paybycashbtn').disabled = false; 
	}

function dsblPayByCardButton(){
	 document.getElementById('paybycardbtn').style.backgroundColor="#F00";
	 document.getElementById('paybycardbtn').disabled = true; 
	}

function enblPayByCardButton(){
	 document.getElementById('paybycardbtn').style.backgroundColor="#72BB4F";
	 document.getElementById('paybycardbtn').disabled = false; 
	}
function dsblPayByOnlineButton(){
	 document.getElementById('paybyonlinebtn').style.backgroundColor="#F00";
	 document.getElementById('paybyonlinebtn').disabled = true; 
	}

function enblPayByOnlineButton(){
	 document.getElementById('paybyonlinebtn').style.backgroundColor="#72BB4F";
	 document.getElementById('paybyonlinebtn').disabled = false; 
	}




//new 

function calculateDiscPercentage(amt) {
	var totAmount = document.getElementById('discmodtotamtcontId').innerHTML;
	var totdiscountableAmount = document.getElementById('discmoddiscountableamtcontId').innerHTML;
	var discPercentage = 0.0;
	if (amt == '') {
		document.getElementById('discModdiscPer').value = '0.00';
	} else if (!isNaN(amt)) {
		   discPercentage = (parseFloat(amt).toFixed(2)*100)/ parseFloat(totdiscountableAmount).toFixed(2);
		  document.getElementById('discModdiscPer').value = parseFloat(discPercentage).toFixed(2);
          }
	
    }



// new added 29th oct 2018 

function addBarcodeItem(code) {
	document.getElementById('itemBarCodeSearch').value="";
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/menu/getmenuitembybarcode/" + code
			+ ".htm", function(response) {
		var item = JSON.parse(response);
		if (jQuery.isEmptyObject(item)) {
			$("#itemnotfoundModal").modal("show");
		} else {
			var disc = 0.0;
			if (item.promotionFlag == 'Y')
				disc = item.promotionValue;
			additemtoOrder(item.id, item.name, item.price, disc, item.vat,
					item.serviceTax, item.promotionFlag, item.promotionValue);
		}

	}, null);
}




//For Corporate customer paid bill print
function printPaidBillForCorporateCustomer(orderid){
	 var caseValue =  $("#mobPrintVal").val();
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
				async: false,
				success : function(response) {
					console.log(response);
					var jsonObj = JSON.parse(response);
					/* ***** Store Details ***** */
					//console.log(response);
					var orderNo = jsonObj.id;
					var storeBaseOrderNumber = jsonObj.orderNo;
					var tabNo = jsonObj.table_no;
					var customerName = jsonObj.customers.name;
					var orderCustomerName = jsonObj.customerName;
					var customerAddr = jsonObj.customers.address;
					var orderCustomerAddr = jsonObj.deliveryAddress;
					var customerPhNo = jsonObj.customerContact;
					var customerEmail = jsonObj.customers.emailId;
					var state=jsonObj.state;
					var orderDateWithTime = jsonObj.customers.orderTime;
					var orderTime = jsonObj.customers.time;
					var cuslocation = jsonObj.location;
	                var cusstreet = jsonObj.street;
	                var cushouseno = jsonObj.houseNo;
	                var delivaryboy = jsonObj.deliveryPersonName;
					var ordercustomerphone= jsonObj.customerContact;
					var customergst = jsonObj.custVatRegNo;

					/* ***** Bill Amount Details ***** */
					var storeId = jsonObj.orderBill.storeid;
					var billAmt = jsonObj.orderBill.billAmount;
					var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
					var vatAmt = jsonObj.orderBill.vatAmt;
					var grossAmt = jsonObj.orderBill.grossAmt;
					var totalDiscount = jsonObj.orderBill.totalDiscount;
					var customerDiscount = jsonObj.orderBill.customerDiscount;
					var customerDiscountPercentage = jsonObj.orderBill.discountPercentage;
	                var roundOffAmt = jsonObj.orderBill.roundOffAmt;
					var discPercentage = jsonObj.orderBill.discountPercentage;
					var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
					var subToatlAmt = jsonObj.orderBill.subTotalAmt;
					var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
					var afterdiscount =Number(subToatlAmt) - Number(customerDiscount) + Number(serviceChargeAmt); //(Taxable value)
	                var tottaxamt=0.0;
					
						$('#corporatebill_invNo').text(storeBaseOrderNumber);
						//$('#corporatebill_buyerInfo').text(orderCustomerName+"\n"+orderCustomerAddr+"\n"+customerPhNo+"\n"+state+"\n"+jsonObj.custVatRegNo);
						$('#corporatebill_buyerInfoName').text(orderCustomerName);
						$('#corporatebill_buyerInfoContact').text(customerPhNo);
						$('#corporatebill_buyerInfoAddress').text(orderCustomerAddr);
						/*if(orderCustomerAddr!=""){
						$("#corporatebill_buyerInfoAddress").css('display', 'none');
						}*/
						$('#corporatebill_buyerInfoState').text(state);
						$('#corporatebill_buyerInfoGSTIN').text(customergst);
						
						
						var formattedDate = new Date(jsonObj.orderDate);
						var d = formattedDate.getDate();
						var m =  formattedDate.getMonth();
						m += 1;  // JavaScript months are 0-11
						var y = formattedDate.getFullYear();
						$("#corporatebill_invDate").text(y + "-" + m + "-" + d);
						
						/* *********** End ************* */
						
						/* ********** END STORE INFO PRINT ********** */

						/* ********** START ITEM DETAILS PRINT ********** */
						var paymentMode = "";
						if(jsonObj.payments.length>1){
							for(var k=0;k<jsonObj.payments.length;k++){
								if(paymentMode=="")
									paymentMode = jsonObj.payments[k].paymentMode;
								else
								    paymentMode = paymentMode + "," + jsonObj.payments[k].paymentMode;
							}
							
						}
						else{
							paymentMode = jsonObj.payments[0].paymentMode;
						}
						
						
						$("#corporatebill_paymentMode").text(paymentMode);
						$("#corporatebill_itemsData").html('');
						$("#corporatebill_itemWiseTaxBreaks").html('');
						
						 var totTaxable = 0.0;
						 var totQty = 0;
						 var totalItemNetAmt= 0.0;
						 var totcgst = 0.0;
						 var totsgst=0.0;
						 var totcgstAmt=0.0;
						 var totsgstAmt=0.0;
						for ( var k = 0; k < jsonObj.orderitem.length; k++) {
							var item1 = jsonObj.orderitem[k];

							var itemName = item1.item.name;
							var itemQty = item1.quantityOfItem;
							var itemRate = item1.rate;
							var itemTotalPrice = item1.totalPriceByItem;
							var itemUnit = item1.item.unit;
							var itemDisc =0.0;
	                        if(item1.item.spotDiscount == 'Y'){
								itemDisc = customerDiscountPercentage;
							}						
							var itemTotalAmt = 0.0;
							var itemTaxableAmt = 0.0;
							var cgstPrcnt = item1.vat;
							var cgstAmt = 0.0;
							var sgstPrcnt = item1.serviceTax;
							var sgstAmt = 0.0;
							var itemNetAmt = 0.0;
							var itemDiscountValue=0.0;
							
							var igstPrcnt = Number(item1.vat) + Number(item1.serviceTax);  // for 120
							var igstAmt = 0.0; // for 120
							var itemHsn = item1.item.code;
							if(itemHsn == undefined){itemHsn="";}	
							
							if(item1.item.promotionFlag == "Y")
							{							
								itemTotalAmt = (item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem;
								itemDiscountValue=Number(itemTotalAmt) - (Number(itemTotalAmt) * Number(itemDisc) /100);
								itemTaxableAmt = (Number(itemTotalAmt) - (Number(itemTotalAmt) * Number(itemDisc) /100)) - item1.promotionDiscountAmt;
								cgstAmt = ( itemTaxableAmt * item1.vat)/100;
								sgstAmt = (itemTaxableAmt * item1.serviceTax)/100;
								itemNetAmt = Number(itemTaxableAmt)+Number(cgstAmt)+Number(sgstAmt);
							}
							else
							{
								itemTotalAmt = item1.quantityOfItem*item1.rate;
								itemDiscountValue=Number(itemTotalAmt) - (Number(itemTotalAmt) * Number(itemDisc) /100);
								itemTaxableAmt = (Number(itemTotalAmt) - (Number(itemTotalAmt) * Number(itemDisc) /100)) - item1.promotionDiscountAmt;
								cgstAmt = (itemTaxableAmt * item1.vat)/100;
								sgstAmt = (itemTaxableAmt * item1.serviceTax)/100;
								itemNetAmt = Number(itemTaxableAmt)+Number(cgstAmt)+Number(sgstAmt);
							}
							
					        totTaxable = Number(totTaxable) + Number(itemTaxableAmt);
							totQty = Number(totQty) + Number(itemQty);
							totalItemNetAmt = Number(totalItemNetAmt) + Number(itemNetAmt) ;
							totcgst = Number(totcgst) + Number(item1.vat) ;
							totsgst= Number(totsgst) + Number(item1.serviceTax) ;
						    totcgstAmt= Number(totcgstAmt) + Number(cgstAmt) ;
						    totsgstAmt= Number(totsgstAmt) + Number(sgstAmt) ;
							
							
							var createdrowline = "";
							var startTrline = "<tr class='noBorder'>";
							var sl_no_clm = "<td  width='50' style='text-align:center;'>"+(k+1)+"</td>";
							var itmname_clm = "<td width='80' style='text-align:left;'>" + itemName + "</td>";
							var hsn_clm = "<td style='text-align:right;'>"+itemHsn+"</td>";
							var itmrate_clm = "<td style='text-align:right;'>" + Number(itemRate).toFixed(2) + "</td>";
							var itmqty_clm = "<td style='text-align:right;'>" + itemQty + "</td>";
							//var taxperc_clm = "<td style='text-align:right;'>" + Number(Number(cgstPrcnt)+Number(sgstPrcnt)).toFixed(2) + "</td>";
							var cgsttaxperc_clm = "<td style='text-align:right;'>" + Number(cgstPrcnt).toFixed(2) + "</td>";
							var sgsttaxperc_clm = "<td style='text-align:right;'>" + Number(sgstPrcnt).toFixed(2) + "</td>";
							var disc_clm = "<td style='text-align:right;'>" + Number(itemDisc).toFixed(2) + "</td>";
							var itmtotalamt_clm = "<td style='text-align:right;'>" + Number(itemNetAmt).toFixed(2) + "</td>";
							var endTrline = "</tr>";

							createdrowline = startTrline + sl_no_clm + itmname_clm + hsn_clm + itmqty_clm + itmrate_clm + cgsttaxperc_clm + sgsttaxperc_clm + disc_clm + itmtotalamt_clm + endTrline;

							$("#corporatebill_itemsData").append(createdrowline);

						
						    var taxbreaklines = "";
						    var linetrstart = "<tr class='noBorder'>";
						    var firsttdline = "<td colspan='3' style='text-align:right;'>"+itemHsn + "(" + itemName + ")" +"</td>"
						    var secondtdline ="<td  style='text-align:right;'>"+Number(itemTaxableAmt).toFixed(2)+"</td>";
						    var thirdtdline ="<td style='text-align:right;'>"+Number(item1.vat).toFixed(2)+"</td>";
						    var fourthtdline ="<td style='text-align:right;'>"+Number(cgstAmt).toFixed(2);+"</td>";
						    var fifthtdline ="<td style='text-align:right;'>"+Number(item1.serviceTax).toFixed(2);+"</td>";
						    var sixthtdline ="<td style='text-align:right;'>"+Number(sgstAmt).toFixed(2)+"</td>";
						    var seventhtdline ="<td style='text-align:right;'>"+Number(Number(cgstAmt)+Number(sgstAmt)).toFixed(2)+"</td>";
						    var linetrend ="</tr>";
						    
						    taxbreaklines = linetrstart+firsttdline+secondtdline+thirdtdline+fourthtdline+fifthtdline+sixthtdline+seventhtdline+linetrend;
						    $("#corporatebill_itemWiseTaxBreaks").append(taxbreaklines);
						    
						    
						    }
						
						// for space 
						if(jsonObj.orderitem.length<15){
						for ( var k = 0; k < 15-jsonObj.orderitem.length; k++) {
							var createdrowline = "";
							var startTrline = "<tr class='noBorder' style='height:10px;'>";
							var sl_no_clm = "<td  width='50' style='text-align:center;'></td>";
							var itmname_clm = "<td width='80' style='text-align:left;'></td>";
							var hsn_clm = "<td style='text-align:right;'></td>";
							var itmrate_clm = "<td style='text-align:right;'></td>";
							var itmqty_clm = "<td style='text-align:right;'></td>";
							var cgsttaxperc_clm = "<td style='text-align:right;'></td>";
							var sgsttaxperc_clm = "<td style='text-align:right;'></td>";
							var disc_clm = "<td style='text-align:right;'></td>";
							var itmtotalamt_clm = "<td style='text-align:right;'></td>";
							var endTrline = "</tr>";
							createdrowline = startTrline + sl_no_clm + itmname_clm + hsn_clm + itmqty_clm + itmrate_clm + cgsttaxperc_clm + sgsttaxperc_clm + disc_clm + itmtotalamt_clm + endTrline;
							$("#corporatebill_itemsData").append(createdrowline);
							
						   }
						}
						
						
					    $('#corporatebill_totItemQty').text(totQty);
						$('#corporatebill_totTaxPercentageAmt').text(Number(Number(vatAmt)+Number(serviceTaxAmt)).toFixed(2));
						$('#corporatebill_totDiscountPercentageAmt').text(Number(customerDiscount).toFixed(2));
						$('#corporatebill_totAmount').text(parseFloat(grossAmt).toFixed(2));
						var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
						$('#corporatebill_totAmountInWords').text(cash_gross_word);
						
						$('#corporatebill_taxableAmount').text(Number(afterdiscount).toFixed(2));
						//$('#corporatebill_centralTaxRate').text(parseFloat(cgst).toFixed(2));
						//$('#corporatebill_centralTaxRate').text(parseFloat(totcgst).toFixed(2));
						$('#corporatebill_centralTaxAmount').text(Number(totcgstAmt).toFixed(2));
						//$('#corporatebill_StateTaxRate').text(parseFloat(sgst).toFixed(2));
						//$('#corporatebill_StateTaxRate').text(parseFloat(totsgst).toFixed(2));
						$('#corporatebill_StateTaxAmount').text(Number(totsgstAmt).toFixed(2));
						
						
						
						var totaltaxamount=Number(parseFloat(totcgstAmt).toFixed(2))+Number(parseFloat(totsgstAmt).toFixed(2));
						$('#corporatebill_totTaxAmount').text(parseFloat(totaltaxamount).toFixed(2));
						var tot_tax_word =  number2text(Number(totaltaxamount).toFixed(2));
						$('#corporatebill_totTaxAmountInWords').text(tot_tax_word);
						
						printCorporateBillData();
						
				}
			});

		} else {
		
            	var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
					try{
						if(response=='Success')
							showPaidBillPrintSuccessModal();
						
					}catch(e)
					{alert(e);}
					}, null);
				
			
		}
	
	
}





function printPaidBillForCorporateCustomer2100px(orderid)  // not used
{
	var caseValue =  $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	
	var order = {};
//	var orderId = document.getElementById('orderNo').value;
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();

	if (caseValue == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			async: false,
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				console.log("jsonObj" + response);
				//alert("response"+response);
				var orderNo = jsonObj.id;
				var storeBaseOrderNumber = jsonObj.orderNo;
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
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
                
				if(storeID == "120"){
						//orderNo = orderNo + "/2018-19";
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
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate_GST").text(y + "-" + m + "-" + d);
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
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
						/*alert(itemHsn);*/
						if(itemHsn == undefined){itemHsn="";}	
						
						if(item1.item.promotionFlag == "Y")
						{							
							itemTotalAmt = (item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem;
							itemTaxableAmt = ((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt;
							cgstAmt = ((((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = ((((item1.rate-(item1.rate*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.serviceTax)/100;
						}
						else
						{
							itemTotalAmt = item1.quantityOfItem*item1.rate;
							itemTaxableAmt = (item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt;
							cgstAmt = (((item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = (((item1.quantityOfItem*item1.rate) - item1.promotionDiscountAmt) * item1.serviceTax)/100;
						}
						
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
						var hsn_clm = "<td>"+itemHsn+"</td>";
						
						/*if((orderTypeOfOrder == 'catering' || orderTypeOfOrder == 'Catering' || orderTypeOfOrder == 'CATERING')){
						    var sac_clm = "<td>"+itemHsn+"</td>";
						    }
						else{
							var sac_clm = "<td></td>";
						    }*/
						var sac_clm = "<td></td>";
						var endTrline1 = "</tr>";

						createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;

						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr>";
					var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";
					var total_txt = "<td>Total:</td>";
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
					
					
					
					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text("0.00");
						$('#payType2100').text(type1 + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** */	

					if (paymentsObj == 1) {
						
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {
						
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal2100();
						}
					}
				

			}
		});

	} else {
	//	var orderid = document.getElementById('orderNo').value;

			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();
					
				}catch(e)
				{alert(e);}
				}, null);
			
		
	}
}





function setOrderItemQtyManually(){
	var itId=document.getElementById('hiddmanualeditItmId').value;
	//document.getElementById('qty'+itId).value=1;
}




function addCreditCustomer() {

	var storecustname = decodeURIComponent(document.getElementById('addstorecustnameContId').value);
	var storecustcontact = decodeURIComponent(document.getElementById('addstorecustcontactContId').value);
	var storecustaddress = decodeURIComponent(document.getElementById('addstorecustaddressContId').value);
	var storecustemail = decodeURIComponent(document.getElementById('addstorecustemailContId').value);
	var storecustcrlimit = document.getElementById('addstorecustcrlimitContId').value;
	var storecustlocation = document.getElementById('addstorelcustlocation').value;
	var storecusthouseno = document.getElementById('addstorecusthouseno').value;
	var storecuststreet = document.getElementById('addstorecuststreet').value;
	var storecustdob = document.getElementById('addstorecustdob').value;
	var storecustanniversary = document.getElementById('addstorecustanniversarydate').value;

	
	if (storecustname == '' || storecustcontact == '') {
		document.getElementById('addstorecustalertMsg').innerHTML = "Both fields are required!";
	} else if ((/[#%?\/\\]/gi).test(storecustname)
			|| (/[#%?\/\\]/gi).test(storecustaddress)) {
		document.getElementById('addstorecustalertMsg').innerHTML = "#,%,?,/,\  characters are not allowed!";
	} else if (isNaN(storecustcontact)) {
		document.getElementById('addstorecustalertMsg').innerHTML = "Enter a valid contact no!";
	}
	
	else {
		storecustaddress = storecustaddress == "" ? null : storecustaddress;
		storecustcrlimit = storecustcrlimit == "" ? 0 : storecustcrlimit;
		storecustemail = storecustemail == "" ? null : storecustemail;
		

		var addStoreCustomer = {};
		addStoreCustomer.name = storecustname;
		addStoreCustomer.contactNo = storecustcontact;
		addStoreCustomer.emailId = storecustemail;
		addStoreCustomer.address = storecustaddress;
		addStoreCustomer.creditLimit = storecustcrlimit;
		addStoreCustomer.location=storecustlocation;
		addStoreCustomer.house_no=storecusthouseno;
		addStoreCustomer.street=storecuststreet;
		addStoreCustomer.dob=storecustdob;
		addStoreCustomer.anniversary=storecustanniversary;

		$.ajax({   
			        url : BASE_URL + "/storecustomermgnt/addcreditcustomer.htm",
		            type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(addStoreCustomer),
					success : function(response) {
						console.log(">>>>>> "+response);
						 var customer=JSON.parse(response);
						// closenmenucateditModal();
						if ($.trim(response)) {
							document.getElementById('catdataopmassagecont').innerHTML = "Data is sucessfully added!";

							document.getElementById('hidcredisalecustid').value=customer.id;
							document.getElementById('creditsalecustname').value=customer.name;
							document.getElementById('creditsalecustcontact').value=customer.contactNo;

							showalertcatdataopModal();
							closecreditcustaddModal();
							document.getElementById('addstorecustnameContId').value='';
							document.getElementById('addstorecustcontactContId').value='';
							document.getElementById('addstorecustaddressContId').value='';
							document.getElementById('addstorecustemailContId').value='';
							document.getElementById('addstorecuststreet').value='';
							document.getElementById('addstorecusthouseno').value='';
							document.getElementById('addstorelcustlocation').value='';
							document.getElementById('addstorecustcrlimitContId').value='';

							
							var date= new Date();
							document.getElementById('addstorecustdob').value=formatDate(date);
							document.getElementById('addstorecustanniversarydate').value=formatDate(date);
						//	$("#modparcelcustdob").val(formatDate(custDetail.dob));

							var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Cash&nbsp;&nbsp;"+
                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Card&nbsp;&nbsp;"+
                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Nopay";
            	             $("#creditsalecustdetailcontId").html("Payment Type : "+htm);



						} else {
							document.getElementById('catdataopmassagecont').innerHTML = "Data is not added.Please try again!";
							showalertcatdataopModal();
						}
					}

				});

	}
}


// new added for rate and qty change in order taking


function changeItemRate(itId,itName,disc,vat,serviceTax,promoFlag,promoValue){
	
	document.getElementById('itemNewRateData').value = "";
	document.getElementById('rateChangeItemId').value = itId;
	document.getElementById('rateChangeItemName').value = itName;
	document.getElementById('rateChangeItemDisc').value = disc;
	document.getElementById('rateChangeItemVat').value = vat;
	document.getElementById('rateChangeItemSTax').value = serviceTax;
	document.getElementById('rateChangeItemPromoFalg').value = promoFlag;
	document.getElementById('rateChangeItemPromoVal').value = promoValue;
	$('#itemRateChangeModal').modal('show');
	
}

function setChangedRate(itemId,itName,disc,vat,serviceTax,promoFlag,promoValue){
	var itemRate = document.getElementById('itemNewRateData').value;
	if(itemRate == ""){
		document.getElementById('changeratealert').value  = "Please insert new rate.";
		
	}else{
		document.getElementById('changeratealert').value  = "";
		$("#itemRateChangeModal").modal('hide');
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/changeItemRate/" + itemId +"/"+ itemRate  + ".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareOrderHtml(responseObj);
				var qty=null;
				for(var i=0;i<responseObj.length;i++)
					{
					var orderitem=responseObj[i];
					if(itemId==orderitem.itemId)
						{
						qty=orderitem.quantityOfItem;
						}
					}
				// for vfd
				if(vfdPort.length>3)
				{
					if(itemName.length>12)
					itemName=itemName.substring(0,12);
					var tot=document.getElementById('amttopaycontId').innerHTML;
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +qty+"x"+itemName+":"+parseFloat(itemRate).toFixed(2)  + "/"+"TOT IN RM : " + parseFloat(tot).toFixed(2)+".htm", function() {
						}, null);
				}
			}catch(e)
			{
				alert(e);
			}
			}, null);
	}
}


function enterManualRate(itemRate,itemId){
	if(itemRate == ""){
		//changeratealert = "Please insert new rate.";
	}else{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/changeItemRate/" + itemId +"/"+ itemRate  + ".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareOrderHtml(responseObj);
				 var number = itemRate.split('.');
				 if(Number(number[1])/10 >= 1){
					 $("#rate"+itemId).val(parseFloat(itemRate).toFixed(2)).blur();
				 }
				 else if(itemRate.indexOf(".") == itemRate.length-1 || itemRate.indexOf(".0") == itemRate.length-2) {
					$("#rate"+itemId).val(itemRate).focus();
				}
				else if(itemRate % 1 != 0){
					$("#rate"+itemId).val(itemRate).focus();
				}
				else{
					$("#rate"+itemId).val(parseInt(itemRate)).focus();
				}
				
				
				//$("#rate"+itemId).focus();
				var qty=null;
				for(var i=0;i<responseObj.length;i++)
					{
					var orderitem=responseObj[i];
					if(itemId==orderitem.itemId)
						{
						qty=orderitem.quantityOfItem;
						}
					}
				// for vfd
				if(vfdPort.length>3)
				{
					if(itemName.length>12)
					itemName=itemName.substring(0,12);
					var tot=document.getElementById('amttopaycontId').innerHTML;
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +qty+"x"+itemName+":"+parseFloat(itemRate).toFixed(2)  + "/"+"TOT IN RM : " + parseFloat(tot).toFixed(2)+".htm", function() {
						}, null);
				}
			}catch(e)
			{
				alert(e);
			}
			}, null);
	}
	
}

function openRemarksModal(){
	var orderno=document.getElementById('orderNo').value;
	if(orderno==0 || forspNoteData.length>0)
		{
		showalertsaveorderModal();
		}
	else
		{
		document.getElementById('orderRemarksData').value = document.getElementById('orderRmks').value;
		document.getElementById('rmkalert').innerHTML ="";
		$('#remarksModal').modal('show');
		}
	
}

function setRemarks(){
	var orderno=document.getElementById('orderNo').value;
	var remarks= document.getElementById('orderRemarksData').value;
	if(remarks == ""){
		document.getElementById('rmkalert').innerHTML ="Please enter remarks.";
		
	}else{
		var cancelOrdered = {};
		cancelOrdered.id = orderno;
		cancelOrdered.remarks = remarks;
		$.ajax({
			url : BASE_URL + "/order/setorderremarks.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cancelOrdered),
			success : function(	response,JSON_UNESCAPED_UNICODE) {
				if(response=='success')
				{
					location.reload();
				}
			else
				{
				document.getElementById('rmkalert').innerHTML=''+response+'';
				}
			}

		});
		
	}
}

function openPackagingNoteModal(){
	var orderno=document.getElementById('orderNo').value;
	if(orderno==0 || forspNoteData.length>0)
		{
		showalertsaveorderModal();
		}
	else
		{
		document.getElementById('pkgNoteData').value = document.getElementById('orderPkgNotes').value;
		document.getElementById('pkgnotealert').innerHTML ="";
		$('#packagingNoteModal').modal('show');
		}
	
}

function setPackagingNote(){
	var orderno=document.getElementById('orderNo').value;
	var note= document.getElementById('pkgNoteData').value;
	if(note == ""){
		document.getElementById('pkgnotealert').innerHTML ="Please enter remarks.";
		
	}else{
		var cancelOrdered = {};
		cancelOrdered.id = orderno;
		cancelOrdered.specialNote = note;
		$.ajax({
			url : BASE_URL + "/order/setpackagingnotes.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cancelOrdered),
			success : function(	response,JSON_UNESCAPED_UNICODE) {
				if(response=='success')
				{
					location.reload();
				}
			else
				{
				document.getElementById('pkgnotealert').innerHTML=''+response+'';
				}
			}

		});
		
	}
}

 /* ===================== End */


