 function newPurchaseOrder() {
	$("#itemdetails").html("");
	//$("#poOrderSave").removeClass('disabled');
	$("#poOrderDelete").addClass('disabled');//new
	$("#selectedPovendorId").prop("disabled", false);//new
	$("#invPOId").val(0);
	$("#serachDiv").show();
	$("#select2").val('');
	$('#select2').removeAttr('disabled');
	$("#poId").val('');
	$("#select1").val('');
	$('#select1').removeAttr('disabled');
	$("#appvId").val('');
	$("#poapprovedbuttion").removeClass('disabled');
	$("#pocreatedbutton").removeClass('disabled');
	$("#misChargeId").prop('disabled', false);
	$("#misChargeId").val(0.00);
	$("#grandtotalId").val(0.00);
	$("#totTaxAmt").val(0.00); // new add
	$("#selectedpoid").val(0);
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	$("#invCrtDate").val(creationDate);
	$("#poDate").val(creationDate);
	//	getPOByDate();
	setActiveButton();//new
}

function addNewPoItem() { //modified
	var itemcode = $("#searchCode").val();
	var vendorid= $("#selectedPovendorId").val(); // new added
	//$("#poOrderSave").removeClass('disabled');
	var itempresent = 0;
	$('#poItemTable > tbody  > tr').each(function() {
		var itcode = $(this).find("td:eq(0)").html();
		if (itcode == itemcode) {
			itempresent = 1;
		}
	});
	if (itempresent == 1) {
		$('#alreadyexistitem').modal('show');
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getinventoryitemdetails/" + itemcode + ".htm", function(response) {
			console.log("response=" + response);
			var itemdetail = JSON.parse(response);
			console.log("response.code=" + itemdetail.code);
			var createdrowline = "";
			var generatedHtml = "";
			var starttrline = "<tr id=" + itemdetail.id + ">";
			var firsttdline = "<td>" + itemdetail.code + "</td>";
			var secondtdline = "<td><input type='hidden'  id='poid_" + itemdetail.id + "' value='0' />" + itemdetail.name + "</td>";
			var thirdtdline = "<td>" + (new Number(itemdetail.stockAvailable)).toFixed(2) + "</td>";
			var fourthtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + "," +itemdetail.taxRate+ ") onkeydown=numcheck(event) id='itmqty_" + itemdetail.id + "' value='" + itemdetail.quantity + "' /></td>";
			var fifthtdline = "<td><input type='hidden'  id='itmunitid_" + itemdetail.id + "' value='" + itemdetail.metricUnitId + "' />" + itemdetail.unit + "</td>";
			var sixthtdline = "<td id='itmratetd_" + itemdetail.id + "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.id + "," + itemdetail.shippingCharge +"," +itemdetail.taxRate+ ") onkeydown=numcheck(event) id='itmrate_" + itemdetail.id + "' value='" + itemdetail.rate + "' /> </td>";
			var seventhtdline = "<td style='display:none;'><input type='text' size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.id + "," + itemdetail.rate + ") id='itmspchrg_" + itemdetail.id + "' value='" + itemdetail.shippingCharge + "' /></td>"; //modified
			var taxtdline = "<td id='itmtaxtd_" + itemdetail.id + "'><input type='hidden' size='4'  id='itmtaxchrg_" + itemdetail.id + "' value='" + itemdetail.taxRate + "' />" +parseFloat(itemdetail.taxRate).toFixed(2) +"</td>"; //new added
			
			if(itemdetail.isTaxExclusive == 'Y'){				
				var eighttdline = "<td id='itmtot_" + itemdetail.id + "'>" + parseFloat(itemdetail.quantity * (itemdetail.rate + (itemdetail.rate * itemdetail.taxRate/100))).toFixed(2) + "</td>"; //modified
			}
			else{				
				var eighttdline = "<td id='itmtot_" + itemdetail.id + "'>" + parseFloat(itemdetail.quantity * itemdetail.rate).toFixed(2) + "</td>"; //modified
			}
						
			var ninetdline = "<td style='display:none;'><input type='hidden'  id='itmvendorid_" + itemdetail.id + "' value='" + vendorid + "' />" + vendorid + "</td>";
			var tentdline = "<td><a href='javascript:deleteRowId(" + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
			
			var taxforcalculate = "<td style='display:none;'>"+parseFloat(itemdetail.taxRate).toFixed(2)+"</td>";
			var rateforcalculate = "<td style='display:none;'>"+parseFloat(itemdetail.rate).toFixed(2)+"</td>";
			
			var taxamt= parseFloat(Number(itemdetail.quantity)*(Number(itemdetail.rate) *Number(itemdetail.taxRate) /100)).toFixed(2);
			
			var taxamttd = "<td style='display:none;' id='itmtaxamts_" + itemdetail.id + "'>"+taxamt+"</td>";
			var taxexclusive = "<td style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
			var tdid = "<td style='display:none;'>"+itemdetail.id+"</td>";
			
			var endtrline = "</tr>";
			createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + taxtdline + eighttdline + ninetdline + tentdline + taxforcalculate + rateforcalculate + taxamttd+ taxexclusive+ tdid +endtrline; //modified
			$("#itemdetails").append(createdrowline);
			$("#searchCode").val("");
			$("#search").val("");
			calculateGrandTotal();
		}, null);
	}
}

function deleteRowId(deleterowid) {
	$("#hdnItemPoId").val(deleterowid);
	$('#poitemdeletemodal').modal('show');
}
function deletePoItem() {
	var delitemid = $("#hdnItemPoId").val();
	$("tr#" + delitemid + "").remove();
	calculateGrandTotal() 
}

function calculateGrandTotal() { //changed
	console.log("call calculateGrandTotal");
	var grandtotal = 0.00;
	var totaltaxamt = 0.00; //add new
	var mischarge = $("#misChargeId").val();
	$('#itemdetails tr').each(function() {
		var trid = $(this).find("td:eq(15)").html();
		var itmtotal = $(this).find("td:eq(8)").html();
		var taxamt =$("#itmtaxamts_"+trid).html();
		grandtotal = grandtotal + Number(itmtotal);
		totaltaxamt = Number(totaltaxamt) + Number(taxamt); //add new
		});
	grandtotal = grandtotal + Number(mischarge);
	$("#grandtotalId").val(parseFloat(grandtotal).toFixed(2));
	$("#totTaxAmt").val(parseFloat(totaltaxamt).toFixed(2));//add new
	
}


function changeQty(	qty,
					itemid,
					shcharge,
					taxrate) {
		
	$("#itmupdate_" + itemid).css('background-color', 'orange');
	var isno = isNaN(qty);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else if (qty == 0) {
			$("#itemquantityzero").modal('show');
		} else {
			var rate = $("#itmrate_" + itemid).val();
			var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();
			var ratewithtax = Number(rate) + ((Number(rate) * Number(taxrate))/100); //new added
			var taxamt = Number(qty)*((Number(rate) * Number(taxrate))/100);//new added
			document.getElementById("itmtaxamts_"+itemid).innerHTML = parseFloat(taxamt).toFixed(2);//new added
			
		
			if(istaxexclusive == 'Y'){// new added
			var trate = (Number(qty) * Number(ratewithtax)); // new added
			}
			else{// new added
			var trate = (Number(qty) * Number(rate)); // new added
			}
			
			var tot = 0;
		    tot=parseFloat(trate).toFixed(2);
			$("#itmtot_" + itemid).text(tot);
			calculateGrandTotal(); //changed
		}
	}
}

function changeRate(rate,
					itemid,
					shcharge,
					taxrate) {
	$("#itmupdate_" + itemid).css('background-color', 'orange');
	var isno = isNaN(rate);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (rate < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			var qty = $("#itmqty_" + itemid).val();
			var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();						
			var newratewithtax = Number(rate) + ((Number(rate) * Number(taxrate)) / 100); // new added
		
			if(istaxexclusive == 'Y'){//new added
			var trate = (Number(qty) * Number(newratewithtax)); //new added
			}
			else{//new added
				var trate = (Number(qty) * Number(rate)); //new added
			}
			
			var taxamt = Number(qty)*((Number(rate) * Number(taxrate))/100);//new added
			document.getElementById("itmtaxamts_"+itemid).innerHTML = parseFloat(taxamt).toFixed(2);//new added
			
			var tot = 0;
			tot =  parseFloat(trate).toFixed(2);//new add
			$("#itmtot_" + itemid).text(tot);
			calculateGrandTotal();
		}
	}
}

/*function changeShippingCharge(	shcharge,
								itemid,
								qty) {
	$("#itmupdate_" + itemid).css('background-color', 'orange');
	var isno = isNaN(shcharge);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (shcharge < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			var qty = $("#itmqty_" + itemid).val();
			var rate = $("#itmrate_" + itemid).val();
			var trate = (qty * rate);
			var tot = 0;
			if (parseFloat(trate) > 0) {
				tot = parseFloat((trate) + parseFloat(shcharge)).toFixed(2);
			} else {

			}
			tot = parseFloat((trate) + parseFloat(shcharge)).toFixed(2);
			$("#itmtot_" + itemid).text(tot);
			calculateGrandTotal();
		}
	}
}*/

function poOrderSave() {
	//$("#poOrderSave").addClass('disabled');
	var grandtotal = $("#grandtotalId").val(); // add new
	var totaltax = $("#totTaxAmt").val(); // add new
	var vendorid = $("#selectedPovendorId").val(); // add new
	
	var itemtotal = 0.00; // add new
	var invPOOrder1 = {};
	var invPOOrder = [];
	var d = new Date();
	var totQty = 0.00;
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var poid = 0;
	var shouldpositive = 0;
	var itmQty = 0;
	var tableDatalen = $('#poItemTable > tbody  > tr').length;
	$('#poItemTable > tbody  > tr').each(function() {
		var trid = this.id;
		var qty = $("#itmqty_" + trid).val();
		var rate = $("#itmrate_" + trid).val();
		var shchrg = $("#itmspchrg_" + trid).val();
		if (qty < 0 || rate < 0 || qty == '' || rate == '') {
			shouldpositive = 1;
		}
		if (qty == 0) {
			itmQty = 1;
		}
	});
	if (shouldpositive == 1) {
		$("#positiveitemquantityorrate").modal('show');
		//$("#poOrderSave").removeClass('disabled');
	} else if (itmQty == 1) {
		$("#itemquantityzero").modal('show');
		//$("#poOrderSave").removeClass('disabled');
	}else if(tableDatalen == 0){
		$("#itemquantityzero").modal('show');
	} 
	else {
		$("#poOrderOperate").addClass('disabled');
		$('#poItemTable > tbody  > tr').each(function() {
			console.log("tr id=" + this.id);
			var that = this;
			var trid = this.id;
			var qty = $("#itmqty_" + trid).val();
			totQty = totQty + parseFloat(qty);
			var rate = $("#itmrate_" + trid).val();
			var unitid = $("#itmunitid_" + trid).val();
			var vendorid = $("#itmvendorid_" + trid).val();
			var shippingCharge = $("#itmspchrg_" + trid).val();
			
			var taxRate = $("#itmtaxchrg_" + trid).val();// new added 
			var taxAmt = Number(qty) * (Number(rate)*Number(taxRate)/100);// new added 
			var totalItemPrice = Number(rate) * Number(qty);// new added 
			itemtotal = itemtotal + parseFloat(totalItemPrice);// new added 
			var totalAmt = $("#itmtot_" + trid).html();// new added 
			
			
			if ($("#poid_" + trid).val() != 0) {
				poid = $("#poid_" + trid).val();
			}
			//	    $(this).find("td:gt(0)").each(function(){
			//	       });
			if ($("#poid_" + trid).val() == 0) {
				var invPOOrderItems = {};
				var inventoryItemsarr = {};
				invPOOrderItems.oldStock = $(that).find("td:eq(2)").html();
				invPOOrderItems.requiredQuantity = qty;
				invPOOrderItems.itemQuantity = qty;
				invPOOrderItems.rate = rate;
				invPOOrderItems.shippingCharge = parseFloat(shippingCharge);
				invPOOrderItems.itemTotalPrice = $(that).find("td:eq(8)").html(); // modified
				invPOOrderItems.vendorId = vendorid;
				invPOOrderItems.unitId = unitid;
				invPOOrderItems.createdDate = creationDate;
				inventoryItemsarr.id = trid;
				invPOOrderItems.inventoryItems = inventoryItemsarr;
				invPOOrderItems.itemTotalPrice =parseFloat(totalItemPrice); // new added 
				invPOOrderItems.taxRate = parseFloat(taxRate); // new added 
				invPOOrderItems.taxAmt = parseFloat(taxAmt); // new added 
				invPOOrderItems.totalAmt = parseFloat(totalAmt); // new added 				
				invPOOrderItems.isTaxExclusive =$("#itmistaxexclusive_"+trid).val(); // new added 
				var ii = $("#itmistaxexclusive_"+trid).val();
				invPOOrder.push(invPOOrderItems);
			}
		});
		invPOOrder1.inventoryPurchaseOrderItems = invPOOrder;
		invPOOrder1.id = poid;
		var othercharges1 = $("#misChargeId").val();
		if(othercharges1 == ''){othercharges1 = 0.0;}
		invPOOrder1.shippingCharge = parseFloat(othercharges1);
		invPOOrder1.totalPrice = $("#grandtotalId").val();
		invPOOrder1.totalQuantity = totQty;
		invPOOrder1.createdDate = creationDate;
		invPOOrder1.itemTotal = parseFloat(itemtotal);// new added 
		invPOOrder1.taxAmt = parseFloat(totaltax);// new added 
		invPOOrder1.vendorId = vendorid;// new added 
		$.ajax({
			url : BASE_URL + "/inventorynew/createnewpurchaseorder.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invPOOrder1),
			success : function(response) {
				//called when successful
				if (response == 'success') {
					if (poid == 0) {
						location.reload();
					} else {
						rowClicked(poid);
					}
				}
			},
			error : function(e) {
				//called when there is an error
				//console.log(e.message);
			}
		});
	}

}
function rowClicked(id) {
	//alert("hi"+id);
	//$("#itemdetails").html("");
	//$("#poOrderSave").addClass('disabled');
	$("#invPOId").val(id);
	$("#selectedpoid").val(id);
	setActiveButton();//new
	var date = document.getElementById('poDate').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getpodetailsbyidanddate/" + id + "/" + date + ".htm", function(response) {
		console.log("response=" + response);
		//		console.log("response="+response.inventoryPurchaseOrderItems);
		var podetail = JSON.parse(response);
		var invPOItems = [];
		$("#itemdetails").html("");
		for ( var i = 0; i < podetail.length; i++) {
			var invPOItems = podetail[i];
			$("#selectedPovendorId").val(invPOItems.vendorId);//new
			$("#selectedPovendorId").prop("disabled", true);//new
			console.log("response=" + invPOItems.inventoryPurchaseOrderItems.length);
			for ( var j = 0; j < invPOItems.inventoryPurchaseOrderItems.length; j++) {
				var itemdetail = invPOItems.inventoryPurchaseOrderItems[j];
				var createdrowline = "";
				var generatedHtml = "";
				
				var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
				var firsttdline = "<td>" + itemdetail.inventoryItems.code + "</td>";
				var secondtdline = "<td><input type='hidden'  id='poid_" + itemdetail.inventoryItems.id + "' value='" + invPOItems.id + "' />" + itemdetail.inventoryItems.name + "</td>";
				var thirdtdline = "<td>" + (new Number(itemdetail.oldStock)).toFixed(2) + "</td>";
				var fourthtdline = "<td><input  type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge +  "," +itemdetail.inventoryItems.taxRate+") onkeydown=numcheck(event) id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' /></td>";
				//var fourthtdline = "<td><input readonly type='text' size='4'  id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' /></td>";
				
				var fifthtdline = "<td><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unitId + "' />" + itemdetail.unitName + "</td>";
				
				var sixthtdline = "<td><input  type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge +"," +itemdetail.inventoryItems.taxRate+ ") onkeydown=numcheck(event) id='itmrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.rate + "' /> </td>";
				//var sixthtdline = "<td><input readonly type='text' size='4'  id='itmrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.rate + "' /> </td>";
				
				var seventhtdline = "<td style='display:none;'><input type='text' size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.rate + ") id='itmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
				var taxtdline = "<td id='itmtaxtd_" + itemdetail.inventoryItems.id + "'><input type='hidden' size='4'  id='itmtaxchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.taxRate + "' />" +parseFloat(itemdetail.inventoryItems.taxRate).toFixed(2) +"</td>"; 
			   //var eighttdline = "<td id='itmtot_" + itemdetail.inventoryItems.id + "'>" + parseFloat(((itemdetail.itemQuantity * itemdetail.rate) + itemdetail.shippingCharge)).toFixed(2) + "</td>";
				
				var eighttdline = "<td id='itmtot_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.totalAmt).toFixed(2) + "</td>";
			    var ninetdline = "<td style='display:none;'><input type='hidden'  id='itmvendorid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.vendorId + "' />" + itemdetail.vendorName + "</td>";
				var blanktd1 ="<td style='display:none;'></td>";
				var blanktd2 ="<td style='display:none;'></td>";
				var taxamt= parseFloat(Number(itemdetail.itemQuantity)*(Number(itemdetail.rate) *Number(itemdetail.taxRate) /100)).toFixed(2);
				var taxamttd = "<td style='display:none;' id='itmtaxamts_" + itemdetail.inventoryItems.id + "'>"+parseFloat(itemdetail.taxAmt).toFixed(2)+"</td>";
				var taxexclusive = "<td style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
				var tdid = "<td style='display:none;'>"+itemdetail.inventoryItems.id+"</td>";
				
				if (invPOItems.poStatus == 'Y' || invPOItems.approved == 'Y' ) {
					//alert("yy");
					$("#serachDiv").hide();
					var tentdline = "<td></td>";
					//fourthtdline = "<td><input type='text' readonly size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + ") id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' /></td>";
					 fourthtdline = "<td><input readonly type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge +  "," +itemdetail.inventoryItems.taxRate+") id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' /></td>";
					//sixthtdline = "<td><input type='text' readonly size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + ") id='itmrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.rate + "' /> </td>";
					//seventhtdline = "<td><input type='text' size='4' readonly onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.rate + ") id='itmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
					 sixthtdline = "<td><input readonly type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge +"," +itemdetail.inventoryItems.taxRate+ ") id='itmrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.rate + "' /> </td>";
					 seventhtdline = "<td style='display:none;'><input type='text' size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.rate + ") id='itmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
				
				
				} else {
					$("#serachDiv").show();
					//var tentdline = "<td><a href='javascript:editExistingPOItem(" + itemdetail.inventoryItems.id + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/admin/g/g_edit.png' height='22' width='18' alt='edit item'>&nbsp;&nbsp;&nbsp; <a href='javascript:deleteRowForExistingPO(" + itemdetail.inventoryItems.id + "," + invPOItems.id + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item'></td></a>";
					var tentdline = "<td ><a class='btn btn-success' style='background: #78B626;display:none;' id='itmupdate_" + itemdetail.inventoryItems.id + "' href='javascript:editExistingPOItem(" + itemdetail.inventoryItems.id + "," + itemdetail.id + ")'>"+"Update"+"</a>&nbsp;&nbsp;&nbsp; <a href='javascript:deleteRowId(" + itemdetail.inventoryItems.id + "," + invPOItems.id + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item'></td></a>";
				}
				var endtrline = "</tr>";
				
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + taxtdline + eighttdline + ninetdline + tentdline + blanktd1 + blanktd2 + taxamttd+ taxexclusive+ tdid +endtrline; //modified
				$("#itemdetails").append(createdrowline);
				
			}
			$("#searchCode").val("");
			$("#search").val("");
			$("#misChargeId").val(invPOItems.shippingCharge);
			$("#misChargeId").prop('disabled', true);
			calculateGrandTotal();
			//addMiscWithTotal();			
			$("#totTaxAmt").val(parseFloat(invPOItems.taxAmt).toFixed(2));
			$("#invCrtBy").val(invPOItems.createdBy);
			
			if (invPOItems.approved == 'Y') {
				$("#select1").val(invPOItems.approved);
				$("#appvId").val(invPOItems.approvedBy);
				$('#select1').prop('disabled', true);
				$("#poapprovedbuttion").addClass('disabled');
				$("#poOrderOperate").addClass('disabled'); //new
				$("#poOrderDelete").removeClass('disabled'); // new
				
			} else {
				$("#select1").val('');
				$("#appvId").val('');
				$('#select1').removeAttr('disabled');
				$("#poapprovedbuttion").removeClass('disabled');
				$("#poOrderOperate").removeClass('disabled'); //new
				$("#poOrderDelete").removeClass('disabled'); // new
			}
			if (invPOItems.poStatus == 'Y') {
				$('#select2').prop('disabled', true);
				$("#select2").val(invPOItems.poStatus);
				$("#poId").val(invPOItems.poBy);
				$("#pocreatedbutton").addClass('disabled');
				$("#poOrderOperate").addClass('disabled'); // new
				$("#poOrderDelete").addClass('disabled'); // new
			} else {
				$("#select2").val('');
				$("#poId").val('');
				$('#select2').removeAttr('disabled');
				$("#pocreatedbutton").removeClass('disabled');
				
			}
			
			
		}
	}, null);
}

function deleteRowForExistingPO(deleterowid,
								poid,
								poinvitemid) {
	$("#hdnitempoid").val(deleterowid);
	$("#hdnpoid").val(poid);
	$("#hdnpoinvitemid").val(poinvitemid);
	$("#existingpoitemdeletemodal").modal('show');
}

function deleteExistingPoItem() {
	//alert("deleteExistingPoItem");
	var deleterowid = $("#hdnitempoid").val();
	var poid = $("#hdnpoid").val();
	var poinvitemid = $("#hdnpoinvitemid").val();
	$("tr#" + deleterowid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/inventorynew/poitemdelete/" + poid + "/" + poinvitemid + ".htm", function(response) {
	}, null);
	//$("#poOrderSave").removeClass('disabled');//new
	calculateGrandTotal();
	
}

function editExistingPOItem(itemid,
							poinvid) {
	var qty = $("#itmqty_" + itemid).val();
	var rate = $("#itmrate_" + itemid).val();
	var unitid = $("#itmunitid_" + itemid).val();
	var vendorid = $("#itmvendorid_" + itemid).val();
	var poid = $("#poid_" + itemid).val();
	var shippingCharge = $("#itmspchrg_" + itemid).val();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var isnoqty = isNaN(qty);
	var isnorate = isNaN(rate);
	var isnoshippingCharge = isNaN(shippingCharge);
	if (isnoqty || isnorate  || qty == '' || rate == '') {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0 || rate < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else if (qty == 0) {
			$("#itemquantityzero").modal('show');
		} else {
			$('#poItemTable > tbody  > tr').each(function() {
				var that = this;
				if (this.id == itemid) {
					var invPOOrderItems = {};
					var inventoryItemsarr = {};
					var inventorypoorder = {};
					invPOOrderItems.id = poinvid;
					invPOOrderItems.oldStock = $(that).find("td:eq(2)").html();
					invPOOrderItems.requiredQuantity = qty;
					invPOOrderItems.itemQuantity = qty;
					invPOOrderItems.rate = rate;
					invPOOrderItems.shippingCharge = parseFloat(shippingCharge);
					invPOOrderItems.itemTotalPrice = $(that).find("td:eq(7)").html();
					invPOOrderItems.vendorId = vendorid;
					invPOOrderItems.unitId = unitid;
					invPOOrderItems.createdDate = creationDate;
					inventoryItemsarr.id = itemid;
					inventorypoorder.id = poid;
					invPOOrderItems.inventoryItems = inventoryItemsarr;
					invPOOrderItems.inventoryPurchaseOrder = inventorypoorder;
					//			console.log("invPOOrderItems=" + JSON.stringify(invPOOrderItems));
					$.ajax({
						url : BASE_URL + "/inventorynew/updatepoitem.htm",
						type : 'POST',
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(invPOOrderItems),
						success : function(response) {
							if (response == 'success') {
								$("#itemupdatedmodal").modal('show');
								$("#itmupdate_" + itemid).css('background-color', '#78B626');
							}
						},
						error : function(e) {
							//called when there is an error
							//console.log(e.message);
						}
					});
				}
			});
		}
	}
}

function getPOByDate() {
	var date = document.getElementById('poDate').value;
	location.href = 'viewPOByDate.htm?selectedDate=' + date;
}

function getApprovedBy(user) {
	var usrId = document.getElementById('invCrtBy').value;
	var selectAppvId = document.getElementById('appvId');
	if (user == 'Y') {
		selectAppvId.value = usrId;
	} else {
		selectAppvId.value = '';
	}
}

function approveCall() {
	var selectedpoid = $("#selectedpoid").val();
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var invDate = $("#invCrtDate").val();
		var invCreatedBy = $("#invCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/inventorynew/approvedPO.htm?poId=' + selectedpoid + '&updatedBy=' + invCreatedBy + '&updatedDate=' + invDate, function(response) {
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$('#approvedpoid').val(selectedpoid);//new
					$("#poapprovedmodal").modal('show');
					$("#poapprovedbuttion").addClass('disabled');
					$("#poOrderOperate").addClass('disabled'); //new
					
				}
			}, null);
		}
	}
}

function getPoBy(selval) {
	var usrrId = document.getElementById('invCrtBy').value;
	var selectPoId = document.getElementById('poId');
	if (selval == 'Y') {
		selectPoId.value = usrrId;
	} else {
		selectPoId.value = '';
	}
}

function poByCall() {
	var selectedpoid = $("#selectedpoid").val();
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var poSelect = document.getElementById('select2').value;
		var appSelect = document.getElementById('select1').value;
		if (appSelect == 'Y') {
			if (poSelect == 'Y') {
				var invDate = document.getElementById('invCrtDate').value;
				var invCreatedBy = document.getElementById('invCrtBy').value;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + '/inventorynew/updatedPO.htm?poId=' + selectedpoid + '&poBy=' + invCreatedBy + '&updatedDate=' + invDate, function(response) {
					if (response == 'success') {
						$('#select2').prop('disabled', true);
						$("#poOrderDelete").addClass('disabled'); // new						
						$('#createdpoid').val(selectedpoid);
						$("#postatus_" + selectedpoid).html('Y');
						$("#poCreated").modal('show');
					}
				}, null);
			}
		}
	}
}

function poCreatedModalClose() {
	var createdpoid = $('#createdpoid').val();
	rowClicked(createdpoid);
	$("#pocreatedbutton").addClass('disabled');
	//	location.reload();
}
function poApprovedModalClose() {
	var approvedpoid = $('#approvedpoid').val();
	rowClicked(approvedpoid);
	
	
}



function poOrderPrint() {
	var selectedpoid = $("#selectedpoid").val();
	console.log("selectedpoid=" + selectedpoid);
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventorynew/poOrderPrint/" + selectedpoid + ".htm", function(response) {
			try {
				$("#printSuccess").modal('show');
			} catch (e) {
				//alert(e);
			}
		}, null);
	}
}

function viewStockIn() {
	var selectedpoid = $("#selectedpoid").val();
	console.log("selectedpoid=" + selectedpoid);
	console.log("$('#poItemTable > tbody  > tr').=" + $('#poItemTable > tbody  > tr').length);
	var tableDatalen = $('#poItemTable > tbody  > tr').length;
	if (selectedpoid == 0 && tableDatalen > 0) {
		$("#displayStockInPage").modal('show');
	} else {
		location.href = BASE_URL + '/stockinnew/loadstockin.htm';
	}
}

function viewStockInPage() {
	location.href = BASE_URL + '/stockinnew/loadstockin.htm';
}
function viewStockOut() {
	location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
}


function poOrderDeleteModalOpen(){//new added
	$("#existingrequisitiondeletemodal").modal('show');
}


function poOrderDelete(){ // new added
	var selectedpoid = $("#selectedpoid").val();
	var tableDatalen = $('#poItemTable > tbody  > tr').length;
	//alert("selectedpoid"+selectedpoid);
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
		$("#poOrderDelete").addClass('disabled');
	} else if(tableDatalen == 0){
		$("#itemquantityzero").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/inventorynew/deleterequisition/' + selectedpoid+'.htm' , function(response) {
		if (response == 'success') {
			
			location.href=BASE_URL+'/inventorynew/loadinventory.htm';
			
			
		}
	}, null);
	}
} 



function poOrderUpdate(){ // new added
	//alert("update");
	//$("#poOrderSave").addClass('disabled');
	var grandtotal = $("#grandtotalId").val(); // add new
	var totaltax = $("#totTaxAmt").val(); // add new
	var vendorid = $("#selectedPovendorId").val(); // add new
	
	var itemtotal = 0.00; // add new
	var invPOOrder1 = {};
	var invPOOrder = [];
	var d = new Date();
	var totQty = 0.00;
	var updatedDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var poid = 0;
	var shouldpositive = 0;
	var itmQty = 0;
	var tableDatalen = $('#poItemTable > tbody  > tr').length;
	$('#poItemTable > tbody  > tr').each(function() {
		var trid = this.id;
		var qty = $("#itmqty_" + trid).val();
		var rate = $("#itmrate_" + trid).val();
		var shchrg = $("#itmspchrg_" + trid).val();
		if (qty < 0 || rate < 0 || qty == '' || rate == '') {
			shouldpositive = 1;
		}
		if (qty == 0) {
			itmQty = 1;
		}
	});
	if (shouldpositive == 1) {
		$("#positiveitemquantityorrate").modal('show');
		//$("#poOrderSave").removeClass('disabled');
	} else if (itmQty == 1) {
		$("#itemquantityzero").modal('show');
		//$("#poOrderSave").removeClass('disabled');
	}else if(tableDatalen == 0){
		$("#itemquantityzero").modal('show');
	} 
	else {
		$("#poOrderOperate").addClass('disabled');
		$('#poItemTable > tbody  > tr').each(function() {
			console.log("tr id=" + this.id);
			var that = this;
			var trid = this.id;
			var qty = $("#itmqty_" + trid).val();
			totQty = totQty + parseFloat(qty);
			var rate = $("#itmrate_" + trid).val();
			var unitid = $("#itmunitid_" + trid).val();
			var vendorid = $("#itmvendorid_" + trid).val();
			var shippingCharge = $("#itmspchrg_" + trid).val();
			
			var taxRate = $("#itmtaxchrg_" + trid).val();// new added 
			var taxAmt = Number(qty) * (Number(rate)*Number(taxRate)/100);// new added 
			var totalItemPrice = Number(rate) * Number(qty);// new added 
			itemtotal = itemtotal + parseFloat(totalItemPrice);// new added 
			var totalAmt = $("#itmtot_" + trid).html();// new added 
			
			
			if ($("#poid_" + trid).val() != 0) {
				poid = $("#poid_" + trid).val();
			}
			//	    $(this).find("td:gt(0)").each(function(){
			//	       });
			//if ($("#poid_" + trid).val() != 0) {
				//alert("poid::"+$("#poid_" + trid).val());
				var invPOOrderItems = {};
				var inventoryItemsarr = {};
				invPOOrderItems.oldStock = $(that).find("td:eq(2)").html();
				invPOOrderItems.requiredQuantity = qty;
				invPOOrderItems.itemQuantity = qty;
				invPOOrderItems.rate = rate;
				invPOOrderItems.shippingCharge = parseFloat(shippingCharge);
				invPOOrderItems.itemTotalPrice = $(that).find("td:eq(8)").html(); // modified
				invPOOrderItems.vendorId = vendorid;
				invPOOrderItems.unitId = unitid;
				invPOOrderItems.updatedDate = updatedDate;
				inventoryItemsarr.id = trid;
				invPOOrderItems.inventoryItems = inventoryItemsarr;
				invPOOrderItems.itemTotalPrice =parseFloat(totalItemPrice); // new added 
				invPOOrderItems.taxRate = parseFloat(taxRate); // new added 
				invPOOrderItems.taxAmt = parseFloat(taxAmt); // new added 
				invPOOrderItems.totalAmt = parseFloat(totalAmt); // new added 
				invPOOrderItems.isTaxExclusive =$("#itmistaxexclusive_"+trid).val(); // new added 
				var ii = $("#itmistaxexclusive_"+trid).val();
				console.log(invPOOrderItems);
				invPOOrder.push(invPOOrderItems);
			//}
		});
		invPOOrder1.inventoryPurchaseOrderItems = invPOOrder;
		invPOOrder1.id = poid;
		var othercharges2 = $("#misChargeId").val();
		if(othercharges2 == ''){othercharges2 = 0;}
		invPOOrder1.shippingCharge = parseFloat(othercharges2);
		invPOOrder1.totalPrice = $("#grandtotalId").val();
		invPOOrder1.totalQuantity = totQty;
		invPOOrder1.updatedDate = updatedDate;
		invPOOrder1.itemTotal = parseFloat(itemtotal);// new added 
		invPOOrder1.taxAmt = parseFloat(totaltax);// new added 
		invPOOrder1.vendorId = vendorid;// new added 
		$.ajax({
			url : BASE_URL + "/inventorynew/createnewpurchaseorder.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invPOOrder1),
			success : function(response) {
				//called when successful
				if (response == 'success') {
					if (poid == 0) {
						location.reload();
					} else {
						rowClicked(poid);
					}
				}
			},
			error : function(e) {
				//called when there is an error
				//console.log(e.message);
			}
		});
	}
	
}

function setActiveButton(){ //add new
var poid = $("#selectedpoid").val();
var activebutton="";
if(poid == '0'){
	activebutton ="<a href='javascript:poOrderSave()' id='poOrderOperate' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";
	
}
else{
	activebutton ="<a href='javascript:poOrderUpdate()' id='poOrderOperate' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";
	
}	
document.getElementById("btnspan").innerHTML = activebutton;	
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




