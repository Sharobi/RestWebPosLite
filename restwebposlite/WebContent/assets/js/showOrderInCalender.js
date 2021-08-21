/**
 * 
 */
//////////////////////for event calender////////////////////
var eventsdata = [];
var event = {};
function openadvtblbooklistsearchmodal() {
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/fetchprebookdata.htm", function(response) {
        try {
            //console.log(">>>>>> " + response);
            var responseObj = JSON.parse(response);

            //prepareAllPreBookTableDataHtml(responseObj);
            prepareAllPreBookEventsDataHtml(responseObj)
        } catch (e) {
            alert(e);
        }

    }, null);



}

function prepareAllPreBookEventsDataHtml(data) {
  
    if (data.length == 0) {

    } else {
        for (var i = 0; i < data.length; i++) {
             var s=data[i].orderNo+" "+data[i].customerName;
             var date=new Date(data[i].orderDate);
             var odate = date.getDate();
             var oyear = date.getFullYear();
             var omonth = date.getMonth()+1;
              if(omonth<10){
             	 omonth='0'+omonth;
              }
              if(odate<10){
            	  odate='0'+odate;
               }
             var ordaerdate=oyear+'-'+omonth+'-'+odate;
             
             
             
            var event = {};
            event.title = s;
            /*event.start = data[i].orderDate;*/
            event.start = ordaerdate;
            event.data = data[i];
            eventsdata.push(event);

        }

        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'            
            },
            aspectRatio: 2,
            defaultDate: formatDate(),
            navLinks: false, // can click day/week names to navigate views
            editable: false, // can edit by drag and drop the events from one date to another date
            eventLimit: true, // allow "more" link when too many events
            displayEventTime : false,
            events: eventsdata,
            eventClick: function(calEvent, jsEvent, view) {
               //console.log(JSON.stringify(calEvent.data));
               prepareOrderDetailHTMLModal(calEvent.data);
            }

        });

    }

    $('#advtblbooklistsearchModal').modal('show');
   

}



function prepareOrderDetailHTMLModal(data){
	var jsonObj=data;
	var orderNo = jsonObj.id;
    var storeBasedOrderNo = jsonObj.orderNo;
	var tabNo = jsonObj.table_no;
	var customerName = jsonObj.customers.name;
	var orderCustomerName = jsonObj.customerName;
	var customerAddr = "";
	var orderCustomerAddr = jsonObj.deliveryAddress;
	var customerPhNo = "";
	var customerEmail = "";
	var state="";
	//var orderDateWithTime = jsonObj.orderDate;
	var orderTime = jsonObj.time;
    var cuslocation = "";
    var cusstreet = "";
    var cushouseno = "";
    var delivaryboy = "";
	var ordercustomerphone= jsonObj.customerContact;
	
	/* ***** Bill Amount Details ***** */
	var storeId = jsonObj.storeId;
	var billAmt = jsonObj.orderBill.billAmount;
	var serviceTaxAmt = "";
	var vatAmt = "";
	var grossAmt = jsonObj.orderBill.grossAmt;
	var totalDiscount = "";
	var customerDiscount = "";
	var roundOffAmt = jsonObj.orderBill.roundOffAmt;
	var discPercentage = "";
	var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
	var subToatlAmt = "";
	var serviceChargeDisc = "";
	var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
	var bookingDate=jsonObj.orderTime;
	var afterdiscount = ""; 
    
	var date=new Date(jsonObj.orderDate);
    var odate = date.getDate();
    var oyear = date.getFullYear();
    var omonth = date.getMonth()+1;
     if(omonth<10){
    	 omonth='0'+omonth;
     }
     if(odate<10){
   	  odate='0'+odate;
      }
     var orderDateWithTime=oyear+'-'+omonth+'-'+odate;
	
	
	
	    $("#itemDetailsPrintshow").text("");
		$('#cashOrdervalueshow').text(storeBasedOrderNo);
		$('#cashOrderdateshow').text(orderDateWithTime);
		$('#cashBookingdateshow').text(bookingDate);
		
		if(tabNo!='0'){
			$('#cashtableNoValueshow').text('Table No:'+tabNo);
		}
		else{
			$('#cashtableNoValueshow').text(orderTypeOfOrder);
		}
		$('#cashOrdertimeshow').text(orderTime);
		
		if(jsonObj.orderitem.length>0){
		for ( var k = 0; k < jsonObj.orderitem.length; k++) {
			var item1 = jsonObj.orderitem[k];
            var itemName = item1.item.name;
			var itemQty = item1.quantityOfItem;
			var itemRate = item1.rate;
			var itemTotalPrice = item1.totalPriceByItem;
            var createdrowline = "";
			/*var startTrline = "<tr style='padding: 2px;'>";
			var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
			var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
			var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
			var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
			var endTrline = "</tr>";*/
            var startTrline = "<tr style='background:#2E2E2E; padding:2px;'>";
			var firstTdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" + itemName + "</td>";
			var secondTdline = "<td style='padding:1px;text-align:center;'>" + itemQty + "</td>";
			var thirdTdline = "<td valign='middle' align='center' style='padding:3px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
			var fourthTdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
			var endTrline = "</tr>";
            createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

			$("#itemDetailsPrintshow").append(createdrowline);
			$("#ordrDetailDiv").show();

		}
      }
		else{
			 $("#ordrDetailDiv").hide();
		}	
        //$('#cashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));
        $("#cashgrossAmountshow").text(parseFloat(grossAmt).toFixed(2));
		var paidamt = jsonObj.payments[0].paidAmount;	
		
		var amttopay=parseFloat(grossAmt).toFixed(2);
		if(paidamt>0 && paidamt!=""){
		    amttopay=grossAmt-paidamt;
		}
		else{
			paidamt=0.0;	
		}
		$("#cashamoutPaidshow").text(parseFloat(paidamt).toFixed(2));
		$("#cashamoutToPayshow").text(parseFloat(amttopay).toFixed(2));
	
	       if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
	    	    document.getElementById("custrshow").style.display = "block";
				document.getElementById('cusnameshow').innerHTML =orderCustomerName;				
				document.getElementById("cusnametrshow").style.display = "block";
				
			}
			
			
			if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
				document.getElementById("custrshow").style.display = "block";
				document.getElementById('cusphnoshow').innerHTML =ordercustomerphone;
				document.getElementById("cusphnotrshow").style.display = "block";
				
			}
		
     

	  $('#advtblbooklistsearchModal').modal('hide');
	  $('#orderDetailDataModal').modal('show');
}




function closeOrderDetailsModal(){
	 $('#orderDetailDataModal').modal('hide');
	 $('#advtblbooklistsearchModal').modal('show');
	}


function formatDate() {
    var d = new Date(),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

