function rowClicked(id) {//hiddenPO
	var date = document.getElementById('poDate').value;

	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );

	if (hdnPageAlertFlag == 'Y') {
		var hiddenPoId = document.getElementById('hiddenPO');
		hiddenPoId.value = id;

		updateAlertPObyIdModal();
	} else {
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			var hiddenPoId = document.getElementById('hiddenPO');
			hiddenPoId.value = id;

			displayPObyIdModal();
		} else {
			location.href = 'purchaseItemsByPoId.htm?poId=' + id + '&date=' + date;
		}
	}
}

function getPoByPoId() {
	var date = document.getElementById('poDate').value;
	var hiddenPoId = document.getElementById('hiddenPO').value;
	location.href = 'purchaseItemsByPoId.htm?poId=' + hiddenPoId + '&date=' + date;
}

function newPurchaseOrder() {
	var jsArray = [];
	var jspoItemArray = [];
	jsArray.length = 0;
	jspoItemArray.length = 0;

	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );

	if (hdnPageAlertFlag == 'Y') {
		//alert("update task success.");
		updateAlertNewRequisitionModal();
	} else {
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayNewRequisitionModal();
		} else {
			location.href = 'newRequisition.htm';
		}
	}
}

function newPORequisition() {
	location.href = 'newRequisition.htm';
}

function dateformat(str) {
	var dt = parseInt(str.substring(0, 2), 10);
	var mon = parseInt(str.substring(3, 5), 10);
	var yr = parseInt(str.substring(6, 10), 10);
	str = new Date(yr, mon - 1, dt);
	return str;
}

function getPOByDate() {
	//alert("getPOByDate");
	var date = document.getElementById('poDate').value;
	//alert("Selected Date : " + date);
	var todayDate = new Date();
	//alert("todayDate : " + todayDate);
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;
	//alert ("todayDateText : " + todayDateText);

	if (dateformat(todayDateText) < dateformat(date)) {
		postDateAlertModal();
	} else {
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
		//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );
		if (hdnPageAlertFlag == 'Y') {

			updateAlertPObyDateModal();
		} else {
			var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
			if (itemAddFlag == "Y") {

				displayPObyDateModal();
			} else {
				location.href = 'viewPOByDate.htm?selectedDate=' + date;
			}
		}
	}
}

function purchaseOrderByDate() {
	var date = document.getElementById('poDate').value;
	location.href = 'viewPOByDate.htm?selectedDate=' + date;
}

function getApprovedBy(aaa) {

	var usrId = document.getElementById('invCrtBy').value;
	//alert("usrId :" + usrId);
	var selectAppvId = document.getElementById('appvId');

	if (aaa == 'Y') {
		selectAppvId.value = usrId;
	} else {
		selectAppvId.value = '';
	}
}

function approveCall() {
	//alert("approve call");
	var appvSelect = document.getElementById('select1').value;
	//alert("selected value ::" + appvSelect);
	var approve = document.getElementById('hdnApprove').value;
	//alert("approve flag :" + approve);
	//var poId = document.getElementById('invPoId').value;

	var todayDate = new Date();
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;

	var date = document.getElementById('poDate').value;
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	var poId = document.getElementById('invPoId').value;

	if (date != todayDateText && poId == 0) {

		//alert("Please go for new requisition");
		newrequisitionModal();
	} else if (itemAddFlag == 'N') {
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
		//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );
		if (hdnPageAlertFlag == 'Y') {
			updateAlertModal();
		} else {
			if (jspoItemArray.length != 0) {
				if (appvSelect == 'Y') {

					if (approve == 'Y') {
						//alert("Purchase Order already approved by " + invCreatedBy);
						purchaseorderapproveModal();
					} else {

						var invDate = document.getElementById('invCrtDate').value;
						var invCreatedBy = document.getElementById('invCrtBy').value;
						//alert("Pamameters::" + poId + " ::: " + invDate + " :::: " + invCreatedBy);
						location.href = 'approvedPO.htm?poId=' + poId + '&updatedBy=' + invCreatedBy + '&updatedDate=' + invDate;
					}
				} else {

					//alert("Please select Y to approve.");
					approveYModal();
				}
			} else {
				//alert("Please add an item first.");
				additemModal();
			}
		}
	} else if (itemAddFlag == 'Y') {

		//alert("Please save the Purchase Order and then approve.");
		savepurchaseorderapproveModal();
	}

}

function getPoBy(bbb) {
	//alert(" hello getPoBy ::" + bbb);
	var usrrId = document.getElementById('invCrtBy').value;
	//alert("usrId :" + usrrId);
	var selectPoId = document.getElementById('poId');

	if (bbb == 'Y') {
		selectPoId.value = usrrId;
	} else {
		selectPoId.value = '';
	}
}

function poByCall() {
	//alert("poByCall");
	var poSelect = document.getElementById('select2').value;
	var appValue = document.getElementById('select1').value;
	//var poId = document.getElementById('invPoId').value;
	var approve = document.getElementById('hdnApprove').value;
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	//alert("itemAddFlag :: " + itemAddFlag);
	//alert("approve flag :" + approve);
	//alert("selected value for PO ::" + poSelect);
	//alert("Approved value ::" + appValue);
	var todayDate = new Date();
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;

	var date = document.getElementById('poDate').value;

	var poId = document.getElementById('invPoId').value;

	if (date != todayDateText && poId == 0) {

		//alert("Please go for new requisition");
		newrequisitionModal();
	} else if (itemAddFlag == 'N') {
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
		//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );
		if (hdnPageAlertFlag == 'Y') {
			updateAlertModal();
		} else {
			if (jspoItemArray.length != 0) {
				if (approve == 'Y') {

					if (appValue == 'Y') {
						if (poSelect == 'Y') {
							var invDate = document.getElementById('invCrtDate').value;
							var invCreatedBy = document.getElementById('invCrtBy').value;
							poCreatedModal();
//							function poCreatedModalClose(){
//								location.href = 'updatedPO.htm?poId=' + poId + '&poBy=' + invCreatedBy + '&updatedDate=' + invDate;
//							}
							setTimeout(function() {
							location.href = 'updatedPO.htm?poId=' + poId + '&poBy=' + invCreatedBy + '&updatedDate=' + invDate;
							}, 2000); 
						} else {
							//alert("Please select Y to create PO");
							selectYcreatePOModal();
						}
					} else {
						//alert("Please select Y to approve");
						approveYModal();
					}
				} else {

					//alert("Please approve the PO first.");
					approvePOModal();
				}
			} else {
				//alert("Please add an item first.");
				additemModal();
			}
		}

	} else if (itemAddFlag == 'Y') {
		//alert("Please save the Purchase Order and then create PO");
		savepurchaseordercreatePOModal();
	}
}

function checkDecimals(input) {
	var decimal = /^[-+]?[0-9]+\.[0-9]+$/;
	if (input.match(decimal)) {
		return true;
	} else {
		return false;
	}
}

function updatePoItem(itemId) {
	//alert("Item Id ::" + itemId);
	var date = document.getElementById('poDate').value;
	//alert(" Date ::" + date);
	var poId = document.getElementById('invPoId').value;
	//alert("Pos Id ::" + poId);
	var dbQuantity = document.getElementById('hdnQty' + itemId);
	var dbQty = dbQuantity.value;
	//alert("Dtabase Qty :: " + dbQty);
	var dbItemRate = document.getElementById('hdnItemRate'+itemId).value;
	var totalItemPrice = document.getElementById('tdItemtp' + itemId);

	var itemQuantity = document.getElementById('itmQty' + itemId);
	var itemQty = itemQuantity.value;
	//alert("actual ItemQuantity ::" + itemQty);
	var result = isNaN(itemQty);
var rate=document.getElementById('tdItmRate' + itemId).value;
console.log("rate="+rate);
console.log("dbItemRate="+dbItemRate);
	var floatRes = checkDecimals(itemQty);
	//alert("floatRes : " + floatRes );

	if (dbQty == itemQty && parseFloat(dbItemRate) == parseFloat(rate)) {
		//alert("Please do some changes.");
		dosomechangesModal();
	} else if (result) {

		//alert("Please enter valid Item Quantity");
		validitemquantityModal();
	} else if (itemQty == '') {

		//alert("Please enter Item Quantity.");
		enteritemQuantityModal();
	} else if (itemQty == 0) {

		//alert("Item Quantity can not be zero.");
		zeroitemquantityModal();
	} else if (itemQty < 0) {

		//alert("Please enter a positive Item Quantity");
		positiveitemquantityModal();
	} else if (rate == '') {

		//alert("Please enter Item Quantity.");
		enteritemQuantityModal();
	} else if(rate < 0 ){
		positiveitemquantityModal();
	}
//	else if (floatRes) {
//		//alert("Item Quantity cannnot be fractioned.");
//		quantityFloatValidateModal();
//	} 
	else {
		//alert('update order item');
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventory/updatePoEachItem/" + itemId + "/" + itemQty + "/" + rate + "/" + date + "/" + poId + ".htm", function(response) {
			try {
				//alert("response ::" + response);
				reponseObj = JSON.parse(response);

				//alert("updated Item Id :" + reponseObj.itemId);
				//alert("updated Item Qty :" + reponseObj.itemQuantity);
				//alert("updated Item totalPirce :" + reponseObj.itemPrice);
				//alert("updated Item GRAND TOTAL :" + reponseObj.totalItemPrice);
				//alert("updated RESPONE :" + reponseObj.response);

				if (reponseObj.response == 'success') {
					itemQuantity.value = reponseObj.itemQuantity;
					dbQuantity.value = reponseObj.itemQuantity;
					totalItemPrice.innerHTML = parseFloat(reponseObj.itemPrice).toFixed(2);
					document.getElementById('update' + itemId).style.background = "#78b626";
					var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
					hdnPageAlertFlag.value = 'N';
					//alert("hdnPageAlertFlag ::: " + hdnPageAlertFlag.value );
				} else {
					//alert("Something wrong while updating the item.");
					somethingwrongitemupdateModal();
					document.getElementById('update' + itemId).style.background = "orange";
				}
			} catch (e) {
				alert(e);
			}

		}, null);

	}
}

function clearValue(id) {
	document.getElementById('itmQty' + id).value = '';
	var totalqtycontid = document.getElementById('tdItemtp' + id);
	var totalqty = totalqtycontid.innerHTML;
	var totalQtyVal = totalqty.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyVal);
	totalqtycontid.innerHTML = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
}

function clearItemValue(id) {
//	tdItmRate${invPurchaseOrderItem.id}
	document.getElementById('tdItmRate' + id).value = '';
	var totalqtycontid = document.getElementById('tdItemtp' + id);
	var totalqty = totalqtycontid.innerHTML;
	var totalQtyVal = totalqty.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyVal);
	totalqtycontid.innerHTML = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
}

function clearItemQuantity(index) {
	document.getElementById('itemQty' + index).value = '';

	var totalqty = document.getElementById('tprice' + index);
	var totalQtyValue = totalqty.value;

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyValue);
	totalqty.value = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
}

function clearItemRate(index) {
	document.getElementById('iRate' + index).value = '';

	var totalqty = document.getElementById('tprice' + index);
	var totalQtyValue = totalqty.value;

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyValue);
	totalqty.value = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
}

function clearMiscValue(id) {

	var miscValue = document.getElementById('misChargeId');
	var miscVal = miscValue.value;
	var miscCharge = miscVal.replace(/\,/g, "");
	//alert("miscCharge " + miscCharge);
	var grandTotalMisc = document.getElementById('totalId');
	var gdTotalValMisc = grandTotalMisc.value;
	var gdTotalValueMisc = gdTotalValMisc.replace(/\,/g, "");

	var hdnGrdTotal = document.getElementById('hdntotalItemPrice');
	var hdngrdTotalVal = hdnGrdTotal.value;
	//alert("hdngrdTotalVal :" + hdngrdTotalVal );
	//var hdnTotalPrice = document.getElementById('hdntotalItemPrice').value;
	//alert("gdTotalValueMisc :" + gdTotalValueMisc);
	var result = isNaN(miscCharge);
	var rest = '';
	if (result) {
		if (hdngrdTotalVal == '') {
			rest = parseFloat(gdTotalValueMisc);
		} else {
			rest = parseFloat(hdngrdTotalVal);
		}

	} else if (miscCharge == '') {
		if (hdngrdTotalVal == '') {
			rest = parseFloat(gdTotalValueMisc);
		} else {
			rest = parseFloat(hdngrdTotalVal);
		}
	} else if (!result) {
		rest = parseFloat(gdTotalValueMisc) - parseFloat(miscCharge);

	}
	var grdTotal = document.getElementById('totalId');
	grdTotal.value = parseFloat(rest).toFixed(2);
	document.getElementById('hdntotalItemPrice').value = parseFloat(rest);
	document.getElementById('' + id).value = '';
}

var grandTotalglobal = document.getElementById('totalId');
var gdTotalValglobal = grandTotalglobal.value;
var gdTotalValueglobal = gdTotalValglobal.replace(/\,/g, "");
function getTotalByMiscValue() {
	var miscValue = document.getElementById('misChargeId');
	var miscVal = miscValue.value;
	var miscCharge = miscVal.replace(/\,/g, "");
	//alert("miscCharge : " + miscCharge );

	//alert("gdTotalValueglobal :" + gdTotalValueglobal );
	var grdTotal = document.getElementById('hdntotalItemPrice');
	var grdTotalVal = grdTotal.value;
	//alert("grdTotalVal : " + grdTotalVal );

	var result = isNaN(miscCharge);
	var total = '';
	if (result) {
		//alert("Please enter valid value");
		if (grdTotalVal == '') {
			total = parseFloat(gdTotalValueglobal);
		} else {
			total = parseFloat(grdTotalVal);
		}
		validMiscValueModal();
	} else if (miscCharge == '') {
		//alert("1");
		total = parseFloat(gdTotalValueglobal);
	} else if (miscCharge == 0) {
		//alert("2");
		//miscValue.value = '0.00';
		total = parseFloat(gdTotalValueglobal);
	} else if (miscCharge < 0) {
		//alert("3");
		//miscValue.value = '0.00';
		total = parseFloat(gdTotalValueglobal);
	} else if (!result) {
		//alert("4");
		//gdTotalValueglobal = parseFloat(gdTotalValueglobal) - parseFloat(miscValueglobal.value);
		if (grdTotalVal == '') {
			total = parseFloat(gdTotalValueglobal) + parseFloat(miscCharge);
		} else {
			total = parseFloat(grdTotalVal) + parseFloat(miscCharge);
		}
		//alert("total :" + total);
	}
	grandTotalglobal.value = parseFloat(total).toFixed(2);
	//alert("grandTotalglobal.value : " + grandTotalglobal.value);
	//var grdTotal = document.getElementById('totalId');
	//grdTotal.value = parseFloat(total).toFixed(2);
}

function getTotalPrice(	id,
						rate) {
	//alert("Total Price :" + id + "---" + rate);
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
	hdnPageAlertFlag.value = 'Y';
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag.value );

	var shippingCharge = document.getElementById('tdShipCrge' + id).innerHTML;
	//alert("shippingCharge :" + shippingCharge);

	var totalqtycontid = document.getElementById('tdItemtp' + id);
	var totalqty = totalqtycontid.innerHTML;
	//alert("totalqty value ::" + totalqty);

	var tdtotalItemAmt = totalqty.replace(/\,/g, "");
	//alert("totalqty after edit ::" + tdtotalItemAmt);

	var qty = document.getElementById('itmQty' + id).value;
	//alert("actual ItemQrty ::" + qty);

	var dbQuantity = document.getElementById('hdnQty' + id);
	var dbQty = dbQuantity.value;
	//alert("Database Qty :: " + dbQty);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");
	//alert("grandTotal Price after edit ::" + totalItemAmt);
	rate = document.getElementById('tdItmRate' + id).value;
	var result = isNaN(qty);
	var total = '';
	var totalAmt = '';
	if (result) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value < 0) {
		total = rate * 0;
	} else if (qty.value == '0') {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '') {
		total = rate * 0;
		totalAmt = 0;
	} else {
		total = rate * qty;
		totalAmt = total + parseFloat(shippingCharge);
	}
	//alert("FinaL AMT :" + totalAmt);

	var residualQty = parseFloat(totalAmt) - parseFloat(tdtotalItemAmt);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + sumTotal);

	totalqtycontid.innerHTML = parseFloat(totalAmt).toFixed(2);
	//var residualQty = parseFloat(total)-parseFloat(totalqty);

	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	//totalqty.value = total;
	//alert("last final amt" + totalqty); id="totalId"
	if (dbQty == qty) {
		document.getElementById('update' + id).style.background = "#78b626";
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
		hdnPageAlertFlag.value = 'N';
	} else {
		document.getElementById('update' + id).style.background = "orange";
	}
}

function getTotalPriceForChangeRate(	id,
						rate) {
	//alert("Total Price :" + id + "---" + rate);
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
	hdnPageAlertFlag.value = 'Y';
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag.value );

	var shippingCharge = document.getElementById('tdShipCrge' + id).innerHTML;
	//alert("shippingCharge :" + shippingCharge);

	var totalqtycontid = document.getElementById('tdItemtp' + id);
	var totalqty = totalqtycontid.innerHTML;
	//alert("totalqty value ::" + totalqty);

	var tdtotalItemAmt = totalqty.replace(/\,/g, "");
	//alert("totalqty after edit ::" + tdtotalItemAmt);

	var qty = document.getElementById('itmQty' + id).value;
	//alert("actual ItemQrty ::" + qty);

	var dbQuantity = document.getElementById('hdnQty' + id);
	var dbQty = dbQuantity.value;
	//alert("Database Qty :: " + dbQty);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");
	//alert("grandTotal Price after edit ::" + totalItemAmt);
	var dbRate = document.getElementById('hdnItemRate' + id).value;
	console.log("dbRate="+dbRate);
	rate = document.getElementById('tdItmRate' + id).value;
	console.log("rate="+rate);
	var result = isNaN(qty);
	var total = '';
	var totalAmt = '';
	if (result) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value < 0) {
		total = rate * 0;
	} else if (qty.value == '0') {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '') {
		total = rate * 0;
		totalAmt = 0;
	} else {
		total = rate * qty;
		totalAmt = total + parseFloat(shippingCharge);
	}
	//alert("FinaL AMT :" + totalAmt);

	var residualQty = parseFloat(totalAmt) - parseFloat(tdtotalItemAmt);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + sumTotal);

	totalqtycontid.innerHTML = parseFloat(totalAmt).toFixed(2);
	//var residualQty = parseFloat(total)-parseFloat(totalqty);

	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	//totalqty.value = total;
	//alert("last final amt" + totalqty); id="totalId"
	if ( parseFloat(dbRate) ==  parseFloat(rate)) {
		document.getElementById('update' + id).style.background = "#78b626";
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
		hdnPageAlertFlag.value = 'N';
	} else {
		document.getElementById('update' + id).style.background = "orange";
	}
}

function getItemTotalPrice(	index,
							itemQty,
							itemCode) {
	//alert("Index :--" + index + "--:Quantity:--" + itemQty + "--:Rate:--" + rate);
	//alert("itemCode :" + itemCode);
	var totalqty = document.getElementById('tprice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);
	var hdnTotalPrice = document.getElementById('hdntotalItemPrice');
	var shipCharge = document.getElementById('sCharge' + index).value;

	var qty = document.getElementById('itemQty' + index).value;
	//alert("actual ItemQnty ::" + qty);
	var unit = document.getElementById('iUnit' + index).value;
	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;
	//alert("Rate : " + rate);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	//var totalItemAmt = '';
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");
	//alert("grandTotal Price after edit ::" + totalItemAmt);
	var result = isNaN(qty);
	var total = '';
	var totalAmt = 0;

	if (result) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value < 0) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '0') {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '') {
		total = rate * 0;
		totalAmt = 0;
	} else {
		total = rate * qty;
		totalAmt = total + parseFloat(shipCharge);
	}
	//alert("FinaL AMT :" + total);

	var residualQty = totalAmt - totalQtyValue;
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + sumTotal);

	totalqty.value = parseFloat(totalAmt).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	hdnTotalPrice.value = parseFloat(sumTotal);
	//grandTotalglobal.value = grandTotal.value;
	//alert("grandTotalglobal : " + grandTotalglobal.value);
	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventory/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit + "/"+ rate + "/" + totalAmt + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getMetricunitVal(unitid,index,itemQty,itemCode){
//	alert("unitid="+unitid);
	var totalqty = document.getElementById('tprice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);
	var hdnTotalPrice = document.getElementById('hdntotalItemPrice');
	var shipCharge = document.getElementById('sCharge' + index).value;

	var qty = document.getElementById('itemQty' + index).value;
	//alert("actual ItemQnty ::" + qty);
	var unit = unitid;
	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;
	//alert("Rate : " + rate);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	//var totalItemAmt = '';
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");
	//alert("grandTotal Price after edit ::" + totalItemAmt);
	var result = isNaN(qty);
	var total = '';
	var totalAmt = 0;

	if (result) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value < 0) {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '0') {
		total = rate * 0;
		totalAmt = 0;
	} else if (qty.value == '') {
		total = rate * 0;
		totalAmt = 0;
	} else {
		total = rate * qty;
		totalAmt = total + parseFloat(shipCharge);
	}
	//alert("FinaL AMT :" + total);

	var residualQty = totalAmt - totalQtyValue;
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + sumTotal);

	totalqty.value = parseFloat(totalAmt).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	hdnTotalPrice.value = parseFloat(sumTotal);
	//grandTotalglobal.value = grandTotal.value;
	//alert("grandTotalglobal : " + grandTotalglobal.value);
	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventory/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit + "/"+ rate + "/" + totalAmt + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getItemRate(	index,
						itemCode) {
	//alert("getItemRate");
	//alert("Index :--" + index);
	//alert("itemCode :" + itemCode);
	var totalqty = document.getElementById('tprice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);
	var shipCharge = document.getElementById('sCharge' + index).value;

	var qty = document.getElementById('itemQty' + index).value;
	//alert("actual ItemQnty ::" + qty);

	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;
	//alert("Rate : " + rate);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	//var totalItemAmt = '';
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");
	//alert("grandTotal Price after edit ::" + totalItemAmt);
	var result = isNaN(rate);
	var total = '';
	var totalAmt = 0;

	if (result) {
		total = qty * 0;
		totalAmt = 0;
	} else if (rate < 0) {
		total = qty * 0;
		totalAmt = 0;
	} else if (rate == 0) {
		total = qty * 0;
		totalAmt = 0;
	} else if (rate == '') {
		total = qty * 0;
		totalAmt = 0;
	} else {
		total = rate * qty;
		totalAmt = total + parseFloat(shipCharge);
	}
	//alert("FinaL AMT :" + total);

	var residualQty = totalAmt - totalQtyValue;
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + sumTotal);
	totalqty.value = parseFloat(totalAmt).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);

	if (!result && rate > 0) {
		//alert("getItemRateFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventory/getItemRateFromPage/" + itemCode + "/" + qty + "/" + rate + "/" + totalAmt + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function checkValidate() {
	//alert("hello submit");
	var length = jsArray.length;
	//alert("Tbale Length ::" + length);
	for ( var i = 0; i < length; i++) {
		var itemQty = document.getElementById("itemQty" + i).value;
		var rate = document.getElementById('iRate' + i).value;
		//var itemRate = document.getElementById('iRate'+i).value;
		//alert("Item Qty:::" + itemQty);
		var floatRes = checkDecimals(itemQty);
		var result = isNaN(itemQty);
		//var resultRate = isNaN(itemRate);
		if (!result) {
			if (itemQty == '') {
				//alert("Please enter Item Quantity.");
				enteritemQuantityModal();
				return false;
			} else if (itemQty == 0) {
				//alert("Item Quantity can not be zero.");
				zeroitemquantityModal();
				return false;
			} else if (itemQty < 0) {
				//alert("Please enter a positive Item Quantity");
				positiveitemquantityModal();
				return false;
			} else if (rate == '') {
				//alert("Please enter Item Quantity.");
				enteritemQuantityModal();
				return false;
			} else if (rate < 0) {
				//alert("Please enter a positive Item Quantity");
				positiveitemquantityModal();
				return false;
			} 
//			else if (floatRes) {
//				//alert("Item Quantity cannnot be fractioned.");
//				quantityFloatValidateModal();
//				return false;
//			}
		} else {
			//alert("Please enter valid Item Quantity");
			validitemquantityModal();
			return false;
		}
	}
}

function addNewPoItem() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	if (hdnPageAlertFlag == 'Y') {

		updateAlertInAddItemModal();
	} else {
		var searchedCode = document.getElementById('searchCode').value;
		var searchedName = document.getElementById('search').value;
		var poId = document.getElementById('invPoId').value;
		var miscCharge = document.getElementById('misChargeId').value;
		//alert("PoId ::" + poId);

		var invCreatedBy = document.getElementById('invCrtBy').value;
		//alert("Ceated By ::" + invCreatedBy);

		var date = document.getElementById('poDate').value;
		//alert("date : " + date);

		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;

		var todayDate = new Date();
		//need to add one to get current month as it is start with 0
		var todayDay = ("0" + (todayDate.getDate())).slice(-2);
		var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
		var todayYear = todayDate.getFullYear();
//		var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
		var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;
		//alert("todayDateText ::" + todayDateText);

		if (date != todayDateText && poId == 0) {
			//alert("Please go for new requisition");
			newrequisitionModal();
		} else {
			//alert("elseeeeeeee");
			if (searchedCode == '') {
				//alert("Please search an Item correctly");
				searchitemcorrectlyModal();
			} else {
				//alert("hellooooo11111");
				if (itemAddFlag == 'N') {
					//alert("hellooooo22222");
					var status = 'N';
					if (jspoItemArray.length != 0) {
						for ( var i = 0; i < jspoItemArray.length; i++) {
							var itemCode = document.getElementById('tdCode' + i).innerHTML;
							if (itemCode == searchedCode) {
								status = 'Y';
							}
						}
					}
					//alert("status :" + status);
					if (status == 'Y') {
						//alert("Item already exists, please select another.");
						alreadyexistitemModal();
					} else if (status == 'N') {
						location.href = 'createNewPurchaseOrderItemRow.htm?itemName=' + searchedName + '&poId=' + poId + '&userId=' + invCreatedBy + '&date=' + date + '&miscValue=' + miscCharge;
					}
				} else if (itemAddFlag == "Y") {
					var status = 'N';
					if (jsArray.length != 0) {
						for ( var i = 0; i < jsArray.length; i++) {
							var itemCode = document.getElementById('iCode' + i).value;
							//alert("Item code ::: " + itemCode);
							if (itemCode == searchedCode) {
								status = 'Y';
							}
						}
					}
					//alert(" Item status :" + status);
					if (status == 'Y') {
						//alert("Item already exists, please select another.");
						alreadyexistitemModal();
					} else if (status == 'N') {
						location.href = 'createNewPurchaseOrderItemRow.htm?itemName=' + searchedName + '&poId=' + poId + '&userId=' + invCreatedBy + '&date=' + date + '&miscValue=' + miscCharge;
					}
				}
			}
		}
	}
}

function addNewOrderItem() {
	var searchedCode = document.getElementById('searchCode').value;
	var searchedName = document.getElementById('search').value;
	var poId = document.getElementById('invPoId').value;
	var miscCharge = document.getElementById('misChargeId').value;
	//alert("PoId ::" + poId);

	var invCreatedBy = document.getElementById('invCrtBy').value;
	//alert("Ceated By ::" + invCreatedBy);

	var date = document.getElementById('poDate').value;
	//alert("date : " + date);

	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;

	var todayDate = new Date();
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;
	//alert("todayDateText ::" + todayDateText);

	if (date != todayDateText && poId == 0) {
		//alert("Please go for new requisition");
		newrequisitionModal();
	} else {
		//alert("elseeeeeeee");
		if (searchedCode == '') {
			//alert("Please search an Item correctly");
			searchitemcorrectlyModal();
		} else {
			//alert("hellooooo11111");
			if (itemAddFlag == 'N') {
				//alert("hellooooo22222");
				var status = 'N';
				if (jspoItemArray.length != 0) {
					for ( var i = 0; i < jspoItemArray.length; i++) {
						var itemCode = document.getElementById('tdCode' + i).innerHTML;
						if (itemCode == searchedCode) {
							status = 'Y';
						}
					}
				}
				//alert("status :" + status);
				if (status == 'Y') {
					//alert("Item already exists, please select another.");
					alreadyexistitemModal();
				} else if (status == 'N') {
					location.href = 'createNewPurchaseOrderItemRow.htm?itemName=' + searchedName + '&poId=' + poId + '&userId=' + invCreatedBy + '&date=' + date + '&miscValue=' + miscCharge;
				}
			} else if (itemAddFlag == "Y") {
				var status = 'N';
				if (jsArray.length != 0) {
					for ( var i = 0; i < jsArray.length; i++) {
						var itemCode = document.getElementById('iCode' + i).value;
						//alert("Item code ::: " + itemCode);
						if (itemCode == searchedCode) {
							status = 'Y';
						}
					}
				}
				//alert(" Item status :" + status);
				if (status == 'Y') {
					//alert("Item already exists, please select another.");
					alreadyexistitemModal();
				} else if (status == 'N') {
					location.href = 'createNewPurchaseOrderItemRow.htm?itemName=' + searchedName + '&poId=' + poId + '&userId=' + invCreatedBy + '&date=' + date + '&miscValue=' + miscCharge;
				}
			}
		}
	}
}

function deleteEachPoItem(poItemId) {

	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	if (hdnPageAlertFlag == 'Y') {
		var hdnPoItem = document.getElementById('hdnItemPoId');
		hdnPoItem.value = poItemId;

		deletePoItemModal();
	} else {
		var hdnPoItem = document.getElementById('hdnItemPoId');
		hdnPoItem.value = poItemId;

		confirmcancelItemModal();
	}
}

function deletePoItem() {
	//alert("PoItem Id ::" + poItemId);
	var poId = document.getElementById('invPoId').value;
	//alert("Po Id ::" + poId);
	var poItemId = document.getElementById('hdnItemPoId').value;

	location.href = 'deletePoItem.htm?poId=' + poId + '&poItemId=' + poItemId;
}

function removeItem(itemCode,
					totalPrice) {
	//alert("Item Code ::" + itemCode);
	//alert("Item Total Price" + totalPrice);
	var gdTotal = document.getElementById('totalId').value;
//	alert("Item grand Total Price" + gdTotal);
	var itemTotalPrice = parseFloat(gdTotal) - parseFloat(totalPrice);
//	alert("Remaining TotalQty :" + itemTotalPrice);

	var hdnItemCode = document.getElementById('hdnItemCode');
	hdnItemCode.value = itemCode;

	var hdnTotalPrice = document.getElementById('hdnTotalPrice');
	hdnTotalPrice.value = itemTotalPrice;

	confirmNewlyAddedItemModal();
}

function removeNewlyAddedItem() {
	var poId = document.getElementById('invPoId').value;
	var invCreatedBy = document.getElementById('invCrtBy').value;
	var date = document.getElementById('poDate').value;
	var hdnItemCode = document.getElementById('hdnItemCode').value;
	var hdnTotalPrice = document.getElementById('hdnTotalPrice').value;
	/*$("#poItemTable tr").each(function() {
		  $this = $(this)
		  var quantity = $this.find("input.itemtotalprice").val();
		  console.log("quantity="+quantity);
		})*/;
//	alert("hdnTotalprice :" + hdnTotalPrice);
	var miscValue = document.getElementById('misChargeId').value;
//	alert("miscValue :" + miscValue);
	location.href = 'removeOrderItemRow.htm?itemcode=' + hdnItemCode + '&totalPrice=' + hdnTotalPrice + '&miscValue=' + miscValue + '&poId=' + poId + '&userId=' + invCreatedBy + '&date=' + date;
}

function selectVendorDropDown(select) {
	//alert("Selected Value :" + select);
	var hdnVendorDropId = document.getElementById('hdndropdownId');
	hdnVendorDropId.value = select;
}

function poOrderPrint() {
	var poId = document.getElementById('invPoId').value;
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag != 'Y' && poId != 0) {
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
		if (hdnPageAlertFlag == 'Y') {
			updateAlertModal();
		} else {
			if (jspoItemArray.length != 0) {
				//alert('print po item');
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/inventory/poOrderPrint/" + poId + ".htm", function(response) {
					try {
						printSuccessModal();
					} catch (e) {
						//alert(e);
					}
				}, null);
			} else {
				//alert("pLZ add an item first");
				printAlertModal();
			}
		}
	} else {
		//alert("Plz save items first");
		printSaveAlertModal();
	}
}
