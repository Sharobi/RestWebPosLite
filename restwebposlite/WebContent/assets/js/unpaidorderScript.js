function noUnpaidOrders(size)
{
	//alert(size);
	if(size==0)
	{
		shownounpaidOrderModal();
	}
}
function getunpaidOrderById(orderId)
{
	//alert(orderId);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/unpaidorder/getunpaidorder/" + orderId +".htm", function(response) {
		try{
			var responseObj=JSON.parse(response);
			prepareUnpaidHtml(responseObj);
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	
}

function prepareUnpaidHtml(data)
{
	var ordertype='';
	var unpaidorderitemcontainerId=document.getElementById('unpaidordertableContId');
	var unpaidordernocontId=document.getElementById('unpaidordernocontId');
	var unpaidordertablenocontId=document.getElementById('unpaidordertablenocontId');
	var unpaidStoreBaseordernocontId = document.getElementById('unpaidStoreBaseordernocontId');
	var starttable="<table class='table table-striped table-bordered' >"+
                    "<thead><th>SL</th><th>NAME</th><th class='hide'>ORDER TYPE</th><th style='text-align:center;'>QUANTITY</th><th style='text-align:center;'>TOTAL</th><th style='text-align:center;'>DISCNT</th><th style='text-align:center;'>RATE</th><th></th>"+
                    "</thead>";
                    "<tbody>";
    var endtable="</tbody></table>";
   
    var createdrowline="";
    var generatedHtml = "";
    var orderitem=[];
    orderitems=data.orderitem;
    for(var i=0;i<orderitems.length;i++)
    	{
    	 	orderitem=orderitems[i];
    	 	if(orderitem.ordertype==2)
    	 		ordertype='PARCEL';
    	 	if(orderitem.ordertype==3)
    	 		ordertype='DINE IN';
    	var begintr="<tr>";
    	var firsttd="<td>"+(i+1)+"</td>";
    	var secondtd="<td>"+orderitem.item.name+"</td>";
    	var second1td="<td class='hide'>"+ordertype+"</td>";
    	var thirdtd="<td valign=\"middle\" align=\"center\" style=\"padding:1px;\"><a href=\"javascript:decreaseItemQuantity("+orderitem.id+","+orderitem.rate+",'"+orderitem.item.promotionFlag+"',"+orderitem.item.promotionValue+")\" >"+
                    "<img border='0' height='24' width='24' alt='' src='"+BASE_URL+"/assets/images/base/d/d_delete.png'></a>"+
                    "<input type=\"text\" size=\"1\" id=\"inputqty"+orderitem.id+"\" onkeyup=\"javascript:enterManualQuantity(this.value,"+orderitem.id+","+orderitem.rate+",'"+orderitem.item.promotionFlag+"',"+orderitem.item.promotionValue+")\" value=\""+orderitem.quantityOfItem+"\" style=\"text-align:center;margin:0 3px;width:28px;\"><a href=\"javascript:increaseItemQuantity("+orderitem.id+","+orderitem.rate+",'"+orderitem.item.promotionFlag+"',"+orderitem.item.promotionValue+")\">"+
                    "<img border='0' height='24' width='24'  alt='' src='"+BASE_URL+"/assets/images/base/d/d_add.png'></a></td>";
    	var fourthtd="<td style='text-align:center;' id='tdtotal"+orderitem.id+"'>"+parseFloat(orderitem.rate*orderitem.quantityOfItem).toFixed(2)+"</td>";
    	var fifthtd="";
    	if(orderitem.item.promotionFlag=='Y')
    		{
    		fifthtd="<td style='text-align:center;' id='tddisc"+orderitem.id+"'>"+parseFloat((orderitem.rate*orderitem.item.promotionValue/100)*orderitem.quantityOfItem).toFixed(2)+"</td>";
    		}
    	else
    		{
    		fifthtd="<td style='text-align:center;' id='tddisc"+orderitem.id+"'>0.00</td>";
    		}
    	var sixthtd="<td style='text-align:center;'>"+parseFloat(orderitem.rate).toFixed(2)+"</td>";
		var reasontd = "<td style='text-align:center;'><input type='text' style='color:black;' id='itemcancelreason" + orderitem.id + "'/><input type='hidden' id='itemorderedqty" + orderitem.id + "' value='" + orderitem.quantityOfItem + "'/></td>";
//       var seventhtd = "<td style='text-align:center;'><a href='#' onclick='javascript:updateUnpaidOrder(" + orderitem.id + "," + orderitem.item.id + "," + data.id + ",document.getElementById(&quot;itemcancelreason" + orderitem.id + "&quot;).value,document.getElementById(&quot;itemorderedqty" + orderitem.id + "&quot;).value)' id='updatebut" + orderitem.id + "' class='btn-unpaid-order'>" + getLangUnpaidOrder.update + "</a></td>";

    	var seventhtd="<td style='text-align:center;'><a href='#' onclick='javascript:updateUnpaidOrder("+orderitem.rate+","+orderitem.id+","+orderitem.item.id+","+data.id+",document.getElementById(&quot;itemcancelreason" + orderitem.id + "&quot;).value)' id='updatebut"+orderitem.id+"' class='btn-unpaid-order'>UPDATE</a></td>";
    	var endtr="</tr>";
//    	createdrowline+=begintr+firsttd+secondtd+second1td+thirdtd+fourthtd+fifthtd+sixthtd+seventhtd+endtr;
    	createdrowline+=begintr+firsttd+secondtd+thirdtd+fourthtd+fifthtd+sixthtd+reasontd+seventhtd+endtr;
    	}
	generatedHtml=starttable+createdrowline+endtable;
	unpaidordernocontId.innerHTML=data.id;
	unpaidordertablenocontId.innerHTML=data.table_no;
	unpaidStoreBaseordernocontId.innerHTML=data.orderNo;
	unpaidorderitemcontainerId.innerHTML=generatedHtml;
}
/*
function cancelUnpaidOrder(orderNo)
{
	location.href=BASE_URL+'/unpaidorder/cancelunpaidorder.htm?orderId='+orderNo;
}
*/
function cancelUnpaidOrder() {
	var changeNote = $('#changenoteContId').val();
	//var cancelreason=document.getElementById('unpaidordernocontId'+id).value;
	var orderNo=document.getElementById('unpaidordernocontId').innerHTML;
	//alert(changeNote + " " + orderNo );

	if ($.trim(changeNote) == "") {
		$("#itemQtyChangeModal").modal('show');
	}
	else {
		//location.href=BASE_URL+'/unpaidorder/cancelunpaidorder.htm?orderId='+orderNo;
		var cancelOrdered = {};
		cancelOrdered.id = orderNo;
		cancelOrdered.cancelRemark = changeNote;
		$.ajax({
			url : BASE_URL + "/unpaidorder/cancelunpaidorderPost.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cancelOrdered),
			success : function(	response,
								JSON_UNESCAPED_UNICODE) {
				console.log(">>>>>> " + response);
				// closenmenucateditModal();
				if (response == 'success') {
					$("#successCancelModal").modal('show');
				} else {
					$("#failureModal").modal('show');
				}
			}

		});
	}
}


function increaseItemQuantity(itemId,rate,promoFlag,promoValue)
{
	//alert(itemId);
	var itemtotalpriceContId=document.getElementById('tdtotal'+itemId);
	var itemdiscContId=document.getElementById('tddisc'+itemId);
	var updatebutContId=document.getElementById('updatebut'+itemId);
	var itemQty=document.getElementById('inputqty'+itemId).value;
	var qty=0;
	var disc=0.0;
	qty=parseInt(itemQty)+1;
	if(promoFlag=='Y')
		{
		disc=(rate*promoValue/100)*qty;
		}
	document.getElementById('inputqty'+itemId).value=qty;
	itemtotalpriceContId.innerHTML=parseFloat(rate*qty).toFixed(2);
	itemdiscContId.innerHTML=parseFloat(disc).toFixed(2);
	updatebutContId.style.background='#F60';
}
function decreaseItemQuantity(itemId,rate,promoFlag,promoValue)
{
	//alert(itemId);
	var itemtotalpriceContId=document.getElementById('tdtotal'+itemId);
	var itemdiscContId=document.getElementById('tddisc'+itemId);
	var updatebutContId=document.getElementById('updatebut'+itemId);
	var itemQty=document.getElementById('inputqty'+itemId).value;
	var qty=0;
	var disc=0.0;
	qty=parseInt(itemQty)-1;
	if(qty>0)
		{
		if(promoFlag=='Y')
		{
		disc=(rate*promoValue/100)*qty;
		}
		document.getElementById('inputqty'+itemId).value=qty;
		itemtotalpriceContId.innerHTML=parseFloat(rate*qty).toFixed(2);
		itemdiscContId.innerHTML=parseFloat(disc).toFixed(2);
		}
	else
		{
		qty=0;
		document.getElementById('inputqty'+itemId).value=qty;
		itemtotalpriceContId.innerHTML=parseFloat(rate*qty).toFixed(2);
		itemdiscContId.innerHTML=parseFloat(disc).toFixed(2);
		}
	updatebutContId.style.background='#F60';
}
function enterManualQuantity(qty,itemId,rate,promoFlag,promoValue)
{
	//
	var itemtotalpriceContId=document.getElementById('tdtotal'+itemId);
	var itemdiscContId=document.getElementById('tddisc'+itemId);
	var updatebutContId=document.getElementById('updatebut'+itemId);
	var total=0.0;
	var disc=0.0;
	if(parseInt(qty)>=0)
		{
		if(promoFlag=='Y')
			{
				disc=(rate*promoValue/100)*qty;
			}
		itemtotalpriceContId.innerHTML=parseFloat(rate*qty).toFixed(2);
		itemdiscContId.innerHTML=parseFloat(disc).toFixed(2);
		updatebutContId.style.background='#F60';
		}
	else if(qty=='')
		{
		updatebutContId.style.background='#F60';
		}
	else
		{
		updatebutContId.style.background='#F60';
		//alert('Enter a valid quantity!');
		showalerteditUnpaidOrderModal();
		}
}
function updateUnpaidOrder(rate,id,itemId,orderId,cancelreason)
{
	var quantity=document.getElementById('inputqty'+id).value;
	var changeNote=document.getElementById('changenoteContId').value;
	var cancelreason=document.getElementById('itemcancelreason'+id).value;
	//alert(id+":"+itemId+":"+orderId+":"+quantity+":"+changeNote);
	if(quantity=='')
		{
		//alert('Please enter valid quantity!');
		showalerteditUnpaidOrderModal();
		}
	else {
		if ($.trim(cancelreason) == '') {
			//alert('Please enter valid quantity!');
			$("#itemQtyChangeModal").modal('show');
		}
	
	else
		{
	/*		var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/unpaidorder/updateunpaidorderitem/" +id+"/" +itemId +"/" +orderId +"/" +quantity +"/" +changeNote +".htm", function(response) {
				try{
					document.getElementById('updatebut'+id).style.background='';
				}catch(e)
				{
					alert(e);
				}
			}, null);*/
		
		
		
		var cancelOrderedItemQty = {};
		cancelOrderedItemQty.id = id;
		cancelOrderedItemQty.itemId = itemId;
		cancelOrderedItemQty.ordrId = orderId;
		cancelOrderedItemQty.quantityOfItem = quantity;
		cancelOrderedItemQty.changeNote = cancelreason;
		cancelOrderedItemQty.rate = rate;
		//alert(id + " " + itemId + " " + orderId + " " + quantity + " " + cancelreason);
		$.ajax({
			url : BASE_URL + "/unpaidorder/updateunpaidorderitempost.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(cancelOrderedItemQty),
			success : function(	response,
								JSON_UNESCAPED_UNICODE) {
				document.getElementById('updatebut' + id).style.background = '';
				console.log(">>>>>> " + response);
				// closenmenucateditModal();
				$('#itemcancelreason' + id).val("");
				if (response == 'success') {

					$("#successModal").modal('show');
				} else {
					$("#failureModal").modal('show');
				}
			}

		});
		
		
		}	
		}
}