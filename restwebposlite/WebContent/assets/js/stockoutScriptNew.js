function newStockOut() {
	$("#itemdetails").html("");
	$("#searchDiv").show();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	$("#createDate").val(creationDate);
	$("#stockoutDate").val(creationDate);
	$("#createTime").val("00:00:00");
	$("#stockoutId").val(0);
}

function addNewStockOut() {
	var itemcode = $("#searchCode").val();
	console.log("itemcode=" + itemcode);
	$("#stockInSave").removeClass('disabled');
	var itempresent = 0;
	$('#stockoutItemTable > tbody  > tr').each(function() {
		var itcode = $(this).find("td:eq(0)").html().split(">")[1];
		if (itcode == itemcode) {
			itempresent = 1;
		}
		//	    $(this).find("td:gt(0)").each(function(){
		//	       console.log("hi="+$(this).html());
		//	       });
	});
	if (itempresent == 1) {
		$('#alreadyexistitem').modal('show');
	} else {
		var list = $("#menucatlst").html();
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getinventoryitemdetails/" + itemcode + ".htm", function(response) {
			console.log("response=" + response);
			var itemdetail = JSON.parse(response);
			var createdrowline = "";
			var starttrline = "<tr id=" + itemdetail.id + ">";
			var firsttdline = "<td><input type='hidden'  id='stockinitmcode_" + itemdetail.id + "' value='" + itemdetail.code + "' />" + itemdetail.code + "</td>";
			var secondtdline = "<td><input type='hidden'  id='stockinid_" + itemdetail.id + "' value='0' />" + itemdetail.name + "</td>";
			var thirdtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + ") id='itmqty_" + itemdetail.id + "' value='" + itemdetail.quantity + "' /></td>";
			var fourthtdline = "<td><input type='hidden'  id='itmunitid_" + itemdetail.id + "' value='" + itemdetail.metricUnitId + "' />" + itemdetail.unit + "</td>";
			var fifthtdline = "<td>" + parseFloat(itemdetail.stockAvailable).toFixed(2) + "</td>";
			var sixthtdline = "<td>" + list + "</td>";
			var seventdline = "<td><a href='javascript:deleteRowId(" + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
			var endtrline = "</tr>";
			createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventdline + endtrline;
			$("#itemdetails").append(createdrowline);
			$("#searchCode").val("");
			$("#search").val("");
			$("#stockOutSave").removeClass('disabled');
			//			calculateGrandTotal();
		}, null);
	}
}

function deleteRowId(deleterowid) {
	$("#hdnItemStockoutId").val(deleterowid);
	$('#stockoutitemdeletemodal').modal('show');
}
function deleteStockoutItem() {
	var delitemid = $("#hdnItemStockoutId").val();
	$("tr#" + delitemid + "").remove();
}

function changeQty(	qty,
					itemid,
					shcharge) {
	var isno = isNaN(qty);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} 
	}
}

function stockOutSave() {
	var invStockOut1 = {};
	var invStockOut = [];
	var totQty = 0;
	var qtycheck = 0;
	var currstockcheck = 0;
	var nocheck=0;
	var creationDate = $("#stockoutDate").val();
	var d = new Date();
	var creationDateTime = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
	console.log("creationDate="+creationDate);
	console.log("creationDateTime="+creationDateTime);
	$('#stockoutItemTable > tbody  > tr').each(function() {
		console.log("tr id=" + this.id);
		var that = this;
		var trid = this.id;
		var qty = $("#itmqty_" + trid).val();
		var isno = isNaN(qty);
		if(isno){
			nocheck=1;
		}
		if (qty <= 0) {
			qtycheck = 1;
		}
		var currentstock = $(that).find("td:eq(4)").html();
		if (qty > Number(currentstock)) {
			currstockcheck = 1;
		}
		totQty = totQty + parseFloat(qty);
		var rate = $("#itmrate_" + trid).val();
		var unitid = $("#itmunitid_" + trid).val();
		var poid = $("#itmpoid_" + trid).val();
		var itmcode = $("#stockinitmcode_" + trid).val();
		var towhom = $("#itemdetails tr#" + trid).find(".selectedmenucat").val();
		if ($("#stockinid_" + trid).val() != 0) {
			stockinid = $("#stockinid_" + trid).val();
		}
		//	    $(this).find("td:gt(0)").each(function(){
		//	       });
		if ($("#stockinid_" + trid).val() == 0) {
			var invStockOutItems = {};
			var inventoryItemsarr = {};
			invStockOutItems.itemQuantity = qty;
			invStockOutItems.itemRate = rate;
			invStockOutItems.toWhom = towhom;
			invStockOutItems.unitId = unitid;
			invStockOutItems.createdDate=creationDate;
			invStockOutItems.time=creationDateTime;
			inventoryItemsarr.id = trid;
			inventoryItemsarr.code = itmcode;
			invStockOutItems.inventoryItems = inventoryItemsarr;
			invStockOut.push(invStockOutItems);
		}
	});
	invStockOut1.inventoryStockOutItems = invStockOut;
	invStockOut1.totalQuantity = totQty;
	invStockOut1.date=creationDate;
	invStockOut1.time=creationDateTime;
	invStockOut1.createdDate=creationDate;
	//				console.log("invStockin1="+JSON.stringify(invStockOut1));
	if (qtycheck == 1) {
		$('#positiveitemquantityorrate').modal('show');
	} else if (currstockcheck == 1) {
		$('#inSufficientStockInAlert').modal('show');
	}else if(nocheck==1){
		$('#validitemquantityorrate').modal('show');
	} else {
		$.ajax({
			url : BASE_URL + "/stockoutnew/createstockout.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invStockOut1),
			success : function(response) {
				//called when successful
				if (response == 'success') {
					location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
				}
			},
			error : function(e) {
			}
		});
	}
}

function rowClicked(id) {
	$("#itemdetails").html("");
	var selectDate = $("#stockoutDate").val();
	console.log("selectDate=" + selectDate);
	console.log("id=" + id);
	$("#selectedstockinid").val(id);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/stockoutnew/getstockOutdetailsbyid/" + id + "/" + selectDate + ".htm", function(response) {
		console.log("response=" + response);
		var stockoutdetail = JSON.parse(response);
		for ( var i = 0; i < stockoutdetail.length; i++) {
			var invstockOutItems = stockoutdetail[i];
			console.log("response=" + invstockOutItems.inventoryStockOutItems.length);
			for ( var j = 0; j < invstockOutItems.inventoryStockOutItems.length; j++) {
				var itemdetail = invstockOutItems.inventoryStockOutItems[j];
				console.log("response.code=" + itemdetail.inventoryItems.code);
				//				var itemdetail = JSON.parse(response);
				var createdrowline = "";
				var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
				var firsttdline = "<td><input type='hidden'  id='stockinitmcode_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
				var secondtdline = "<td><input type='hidden'  id='stockinid_" + itemdetail.inventoryItems.id + "' value='0' />" + itemdetail.inventoryItems.name + "</td>";
				var thirdtdline = "<td><input type='text' readonly size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + ") id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' /></td>";
				var fourthtdline = "<td><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.metricUnitId + "' />" + itemdetail.unitName + "</td>";
				var fifthtdline = "<td>" + parseFloat(itemdetail.inventoryItems.stockAvailable).toFixed(2) + "</td>";
				var sixtdline = "<td>" + itemdetail.toWhom + "</td>";
				var seventdline="<td></td>";
				var endtrline = "</tr>";
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixtdline+ seventdline + endtrline;
				$("#itemdetails").append(createdrowline);
				if (itemdetail.approveFlag == 'Y') {
					$("#searchDiv").hide();
					$("#stockOutSave").addClass('disabled');
				} else {
					$("#searchDiv").show();
					$("#stockOutSave").removeClass('disabled');
				}
			}
			$("#stockoutDate").val(invstockOutItems.createdDate);
			$("#createDate").val(invstockOutItems.createdDate);
			$("#createTime").val(invstockOutItems.time);
			$("#createdBy").val(invstockOutItems.createdBy);
			$("#stockoutId").val(invstockOutItems.id);
		}
	}, null);
}

function getStockOutByDate() {
	var selectDate = $("#stockoutDate").val();
	console.log("selectDate=" + selectDate);
	location.href = BASE_URL + "/stockoutnew/getstockOutdetailsbydate/" + selectDate + ".htm";
}

function viewPurchaseOrder() {
//	var selectedpoid = $("#selectedstockinid").val();
//	console.log("selectedstockinid=" + selectedstockinid);
//	console.log("$('#stockinItemTable > tbody  > tr').="+$('#stockinItemTable > tbody  > tr').length);
//	var tableDatalen=$('#stockinItemTable > tbody  > tr').length;
//	if (selectedpoid == 0 && tableDatalen>0) {
//		$("#displayPOPage").modal('show');
//	} else {
			location.href = BASE_URL+'/inventorynew/loadinventory.htm';
//	}
}

function viewPurchaseOrderPage(){
	location.href = BASE_URL+'/inventorynew/loadinventory.htm';
}

function viewStockIn() {
	location.href = BASE_URL + '/stockinnew/loadstockin.htm';
}