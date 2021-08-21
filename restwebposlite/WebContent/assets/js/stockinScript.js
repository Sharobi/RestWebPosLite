function rowClicked(stockId) {
	//alert("Id ::" + stockId);
	var date = document.getElementById('poDate').value;
	//alert("Selected Date : " + date);
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag);

	if (hdnPageAlertFlag == 'Y') {
		var hdnStockId = document.getElementById('hiddenStockId');
		hdnStockId.value = stockId;

		updateAlertStockInbyIdModal();
	} else {
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			var hdnStockId = document.getElementById('hiddenStockId');
			hdnStockId.value = stockId;

			displayStockInByIdModal();
		} else {
			location.href = 'stockInByPoId.htm?stockId=' + stockId + '&date=' + date;
		}
	}
}

function getStockInById() {
	var hdnStockId = document.getElementById('hiddenStockId').value;
	var date = document.getElementById('poDate').value;

	location.href = 'stockInByPoId.htm?stockId=' + hdnStockId + '&date=' + date;
}

function dateformat(str) {
	var dt = parseInt(str.substring(0, 2), 10);
	var mon = parseInt(str.substring(3, 5), 10);
	var yr = parseInt(str.substring(6, 10), 10);
	str = new Date(yr, mon - 1, dt);
	return str;
}

function getStockInByDate() {
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
		//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag);
		if (hdnPageAlertFlag == 'Y') {

			updateAlertStockInbyDateModal();
		} else {
			var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
			if (itemAddFlag == "Y") {

				displayStockInByDateModal();
			} else {
				location.href = 'stockInByDate.htm?date=' + date;
			}
		}
	}
}

function stockInByDateWise() {
	var date = document.getElementById('poDate').value;
	//alert("Selected Date : " + date);
	location.href = 'stockInByDate.htm?date=' + date;
}

function newStockIn() {
	//alert("New StockIn");
	jsArray.length = 0;
	jspoItemArray.length = 0;

	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag);

	if (hdnPageAlertFlag == 'Y') {

		updateAlertNewStockInModal();
	} else {
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayNewStockInModal();
		} else {
			location.href = 'newStockIn.htm';
		}
	}
}

function getNewStockIn() {
	location.href = 'newStockIn.htm';
}

function getSelectedStatus(value) {
	//alert("Selected Value ::" + value);
	var createdId = document.getElementById('poCreatedId').value;
	//alert("createdId ::" + createdId);
	var userId = document.getElementById('poUserId');
	if (value == 'Y') {
		userId.value = createdId;
	} else {
		userId.value = '';
	}
}

function closeStatusUpdated() {
	var poSelect = document.getElementById('selectPO').value;
	//alert("PO Selected Value ::" + poSelect);
	var stockId = document.getElementById('stockInId').value;
	//alert("StockIn Id ::" + stockId);
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	//alert("itemAddFlag : " + itemAddFlag);

	var todayDate = new Date();
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;

	var date = document.getElementById('poDate').value;

	if (date != todayDateText && stockId == 0) {

		//alert("Please go for new requisition");
		newrequisitionModal();
	} else if (itemAddFlag == 'N') {
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
		//alert("hdnPageAlertFlag :: " + hdnPageAlertFlag );
		if (hdnPageAlertFlag == 'Y') {

			updateAlertModal();
		} else {
			if (jspoItemArray.length != 0) {
				if (poSelect == 'Y') {
					location.href = 'stockInClosed.htm?stockInId=' + stockId;
				} else {

					//alert("Please select Y to close.");
					selectYtocloseModal();
				}
			} else {
				//alert("Please add an item first.");
				additemModal();
			}
		}
	} else if (itemAddFlag == 'Y') {

		//alert("Please save the StockIn Items and then close.");
		saveStockInItemsModal();
	}

}

function getStockInTotalPrice(itemId,tax) {
	//alert("ItemId  ::" + itemId);
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
	hdnPageAlertFlag.value = 'Y';

	var rate = document.getElementById('itmRate' + itemId).value;

	var totalPrice = document.getElementById('tdTotalPrice' + itemId);
	var totalPriceValue = totalPrice.innerHTML;
	//alert("totalPriceValue : " + totalPriceValue);

	var tdtotalPrice = totalPriceValue.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;

	var totalItemAmt = gdTotalValue.replace(/\,/g, "");

	var poNumber = document.getElementById('pNo' + itemId).value;
	//alert("poNumber :" + poNumber);
	var dbPoNo = document.getElementById('hdnPO' + itemId).value;
	//alert("databse dbPoNo : " + dbPoNo);

	var selectQty = document.getElementById('itemQty' + itemId);
	var qty = selectQty.value;
	//alert("Actual Quantity ::" + qty);

	var dbQuantity = document.getElementById('hdnQty' + itemId);
	var dbQty = dbQuantity.value;
	//alert("Databse Quantity ::" + dbQty);

	var result = isNaN(qty);

	var total = '';
	if (result) {
		total = rate * 0;
	} else if (qty.value < 0) {
		total = rate * 0;
	} else if (qty.value == '0') {
		total = rate * 0;
	} else if (qty.value == '') {
		total = rate * 0;
	} else {
		total = rate * qty;
	}
	//alert("FinaL AMT :" + total);

	var residualQty = parseFloat(total) - parseFloat(tdtotalPrice);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + parseFloat(sumTotal).toFixed(1));

	totalPrice.innerHTML = parseFloat(total).toFixed(2);
	//var residualQty = parseFloat(total)-parseFloat(totalqty);

	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	//totalqty.value = total;
	//alert("last final amt" + totalqty); id="totalId"
	var taxAmount=total*tax/100;
	var amountWithoutTax=parseFloat(total)-taxAmount;
	console.log("ItemId  ::" + itemId);
	console.log("total="+total);
	console.log("tax="+tax);
	console.log("taxAmount="+parseFloat(taxAmount).toFixed(2));
	console.log("amountWithoutTax="+parseFloat(amountWithoutTax).toFixed(2));
	$("#tdtaxAmount"+ itemId).text(parseFloat(taxAmount).toFixed(2));
	$("#tdamountWithoutTax"+ itemId).text(parseFloat(amountWithoutTax).toFixed(2));
	if (dbQty == qty && dbPoNo == poNumber) {
		document.getElementById('update' + itemId).style.background = "#78b626";
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
		hdnPageAlertFlag.value = 'N';
	} else {
		document.getElementById('update' + itemId).style.background = "orange";
	}
}

function getStockInItemPrice(itemId,tax) {//hdnItemRate
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
	hdnPageAlertFlag.value = 'Y';

	var dbItemRate = document.getElementById('hdnItemRate' + itemId).value;
	//alert("dbItemRate : " + dbItemRate);

	var rate = document.getElementById('itmRate' + itemId).value;
	//alert("rate :" + rate);

	var totalPrice = document.getElementById('tdTotalPrice' + itemId);
	var totalPriceValue = totalPrice.innerHTML;
	//alert("totalPriceValue : " + totalPriceValue);

	var tdtotalPrice = totalPriceValue.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;

	var totalItemAmt = gdTotalValue.replace(/\,/g, "");

	//var poNumber = document.getElementById('pNo' + itemId).value;
	//alert("poNumber :" + poNumber);
	//var dbPoNo = document.getElementById('hdnPO' + itemId).value;
	//alert("databse dbPoNo : " + dbPoNo);

	var selectQty = document.getElementById('itemQty' + itemId);
	var qty = selectQty.value;
	//alert("Actual Quantity ::" + qty);

	//var dbQuantity = document.getElementById('hdnQty' + itemId);
	//var dbQty = dbQuantity.value;
	//alert("Databse Quantity ::" + dbQty);

	var result = isNaN(rate);

	var total = '';
	if (result) {
		total = qty * 0;
	} else if (qty.value == '') {
		total = qty * 0;
	} else if (rate < 0) {
		total = qty * 0;
	} else if (rate == 0) {
		total = qty * 0;
	} else {
		total = rate * qty;
	}
	//alert("FinaL AMT :" + total);

	var residualQty = parseFloat(total) - parseFloat(tdtotalPrice);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + parseFloat(sumTotal).toFixed(1));

	totalPrice.innerHTML = parseFloat(total).toFixed(2);
	//var residualQty = parseFloat(total)-parseFloat(totalqty);

	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	//totalqty.value = total;
	//alert("last final amt" + totalqty); id="totalId"
	var taxAmount=total*tax/100;
	var amountWithoutTax=parseFloat(total)-taxAmount;
	console.log("ItemId  ::" + itemId);
	console.log("total="+total);
	console.log("tax="+tax);
	console.log("taxAmount="+taxAmount);
	console.log("amountWithoutTax="+amountWithoutTax);
	$("#tdtaxAmount"+ itemId).text(parseFloat(taxAmount).toFixed(2));
	$("#tdamountWithoutTax"+ itemId).text(parseFloat(amountWithoutTax).toFixed(2));
	if (parseFloat(dbItemRate) == parseFloat(rate)) {
		document.getElementById('update' + itemId).style.background = "#78b626";
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
		hdnPageAlertFlag.value = 'N';
	} else {
		document.getElementById('update' + itemId).style.background = "orange";
	}
}

function clearItemQuantity(itemId) {
	document.getElementById('itemQty' + itemId).value = '';

	var totalPrice = document.getElementById('tdTotalPrice' + itemId);
	var totalPriceVal = totalPrice.innerHTML;
	var totalPriceValue = totalPriceVal.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalPriceValue);
	totalPrice.innerHTML = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
	document.getElementById('update' + itemId).style.background = "orange";
}

function clearItemQty(index) {
	document.getElementById('itemQty' + index).value = '';

	var totalqty = document.getElementById('tPrice' + index);
	var totalQtyVal = totalqty.value;
	var totalQtyValue = totalQtyVal.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyValue);
	totalqty.value = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);

}

function clearStockInItemRate(itemId) {
	document.getElementById('itmRate' + itemId).value = '';

	var totalqty = document.getElementById('tdTotalPrice' + itemId);
	var totalQtyVal = totalqty.innerHTML;
	var totalQtyValue = totalQtyVal.replace(/\,/g, "");

	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyValue);
	totalqty.innerHTML = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
	document.getElementById('update' + itemId).style.background = "orange";
}

function clearItemRate(index) {
	document.getElementById('iRate' + index).value = '';

	var totalqty = document.getElementById('tPrice' + index);
	var totalQtyVal = totalqty.value;
	var totalQtyValue = totalQtyVal.replace(/\,/g, "");

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
	var grandTotal = document.getElementById('totalId');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");

	var hdnGrdTotal = document.getElementById('hdntotalItemPrice');
	var hdngrdTotalVal = hdnGrdTotal.value;

	var result = isNaN(miscCharge);
	//alert("result :" + result);
	var rest = '';
	if (result) {
		if (hdngrdTotalVal == '') {
			rest = parseFloat(gdTotalValue);
		} else {
			rest = parseFloat(hdngrdTotalVal);
		}
		//alert("in If...total :" + rest);
	} else if (miscCharge == '') {
		if (hdngrdTotalVal == '') {
			rest = parseFloat(gdTotalValue);
		} else {
			rest = parseFloat(hdngrdTotalVal);
		}
	} else if (!result) {
		rest = parseFloat(gdTotalValue) - parseFloat(miscCharge);
	}
	var gdTotal = document.getElementById('totalId');
	gdTotal.value = parseFloat(rest).toFixed(2);
	document.getElementById('hdntotalItemPrice').value = parseFloat(rest);
	document.getElementById('' + id).value = '';
}

var grandTotalglobal = document.getElementById('totalId');
var gdTotalValglobal = grandTotalglobal.value;
var gdTotalValueglobal = gdTotalValglobal.replace(/\,/g, "");

function getTotalPriceByMiscValue() {
	var miscValue = document.getElementById('misChargeId');
	var miscVal = miscValue.value;
	var miscCharge = miscVal.replace(/\,/g, "");

	var grdTotal = document.getElementById('hdntotalItemPrice');
	var grdTotalVal = grdTotal.value;
	//alert("grdTotalVal : " + grdTotalVal );

	var result = isNaN(miscCharge);
	var total = '';
	if (result) {
		//miscValue.value = '0.00';
		//alert("Please enter valid value");
		if (grdTotalVal == '') {
			total = parseFloat(gdTotalValueglobal);
		} else {
			total = parseFloat(grdTotalVal);
		}
		validMiscValueModal();
	} else if (miscCharge == '') {
		total = parseFloat(gdTotalValueglobal);
	} else if (miscCharge == 0) {
		//miscValue.value = '0.00';
		total = parseFloat(gdTotalValueglobal);
	} else if (miscCharge < 0) {
		total = parseFloat(gdTotalValueglobal);
	} else {
		if (grdTotalVal == '') {
			total = parseFloat(gdTotalValueglobal) + parseFloat(miscCharge);
		} else {
			total = parseFloat(grdTotalVal) + parseFloat(miscCharge);
		}
	}
	grandTotalglobal.value = parseFloat(total).toFixed(2);
}

function getColorChange(itemId) {
	var poNumber = document.getElementById('pNo' + itemId).value;
	//alert("poNumber :" + poNumber);

	var dbPoNo = document.getElementById('hdnPO' + itemId).value;
	//alert("databse dbPoNo : " + dbPoNo);

	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
	hdnPageAlertFlag.value = 'Y';

	if (dbPoNo == poNumber) {
		document.getElementById('update' + itemId).style.background = "#78b626";
		var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
		hdnPageAlertFlag.value = 'N';
	} else {
		document.getElementById('update' + itemId).style.background = "orange";
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

function getStockInPrice(	index,
							itemCode,tax) {
	//alert("autoInId :" + index + "::" + rate);

	var totalqty = document.getElementById('tPrice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);

	var qty = document.getElementById('itemQty' + index).value;
//	alert("actual ItemQnty ::" + qty);
	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);

	var hdnTotalPrice = document.getElementById('hdntotalItemPrice');
	var unit = document.getElementById('iUnit' + index).value;
//	alert("unit ::" + unit);
	
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");

	var result = isNaN(qty);
	var total = '';

	if (result) {
		total = rate * 0;
	} else if (qty.value < 0) {
		total = rate * 0;
	} else if (qty.value == '0') {
		total = rate * 0;
	} else if (qty.value == '') {
		total = rate * 0;
	} else {
		total = rate * qty;
	}
	//alert("FinaL AMT :" + total);

	var residualQty = parseFloat(total) - parseFloat(totalQtyValue);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + parseFloat(sumTotal).toFixed(1));

	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	hdnTotalPrice.value = parseFloat(sumTotal);
	var taxAmount=total*tax/100;
	var amountWithoutTax=parseFloat(total)-taxAmount;
	console.log("tax="+tax);
	console.log("taxAmount="+taxAmount);
	console.log("amountWithoutTax="+amountWithoutTax);
	$("#taxAmount"+ index).val(parseFloat(taxAmount).toFixed(2));
	$("#amountWithoutTax"+ index).val(parseFloat(amountWithoutTax).toFixed(2));

	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockin/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit + "/"+ total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getMetricunitVal(unitId,index,itemCode,tax){
	var totalqty = document.getElementById('tPrice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);

	var qty = document.getElementById('itemQty' + index).value;
//	alert("actual ItemQnty ::" + qty);
	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);

	var hdnTotalPrice = document.getElementById('hdntotalItemPrice');
	var unit = unitId;
//	alert("unit ::" + unit);
	var totalItemAmt = gdTotalValue.replace(/\,/g, "");

	var result = isNaN(qty);
	var total = '';

	if (result) {
		total = rate * 0;
	} else if (qty.value < 0) {
		total = rate * 0;
	} else if (qty.value == '0') {
		total = rate * 0;
	} else if (qty.value == '') {
		total = rate * 0;
	} else {
		total = rate * qty;
	}
	//alert("FinaL AMT :" + total);

	var residualQty = parseFloat(total) - parseFloat(totalQtyValue);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + parseFloat(sumTotal).toFixed(1));

	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	hdnTotalPrice.value = parseFloat(sumTotal);
	var taxAmount=total*tax/100;
	var amountWithoutTax=parseFloat(total)-taxAmount;
	console.log("tax="+tax);
	console.log("taxAmount="+taxAmount);
	console.log("amountWithoutTax="+amountWithoutTax);
	$("#taxAmount"+ index).val(parseFloat(taxAmount).toFixed(2));
	$("#amountWithoutTax"+ index).val(parseFloat(amountWithoutTax).toFixed(2));

	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockin/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit + "/"+ total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getItemRate(	index,
						itemCode,tax) {
	var totalqty = document.getElementById('tPrice' + index);
	var totalQtyValue = totalqty.value;
	//alert(" totalqty value ::" + totalQtyValue);
	var itemRate = document.getElementById('iRate' + index);
	var rate = itemRate.value;

	var qty = document.getElementById('itemQty' + index).value;
//	alert("actual ItemQnty ::" + qty);

	var grandTotal = document.getElementById('totalId');
	var gdTotalValue = grandTotal.value;
	//alert("grandTotal Price ::" + gdTotalValue);
	var hdnTotalPrice = document.getElementById('hdntotalItemPrice');

	var totalItemAmt = gdTotalValue.replace(/\,/g, "");

	var result = isNaN(rate);
	var total = '';

	if (result) {
		total = qty * 0;
	} else if (rate < 0) {
		total = qty * 0;
	} else if (rate == 0) {
		total = qty * 0;
	} else if (rate == '') {
		total = qty * 0;
	} else {
		total = rate * qty;
	}
	//alert("FinaL AMT :" + total);

	var residualQty = parseFloat(total) - parseFloat(totalQtyValue);
	//alert("ResidualQty ::" + residualQty);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal :" + parseFloat(sumTotal).toFixed(1));

	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);
	hdnTotalPrice.value = parseFloat(sumTotal);

	var taxAmount=total*tax/100;
	var amountWithoutTax=parseFloat(total)-taxAmount;
	console.log("tax="+tax);
	console.log("taxAmount="+taxAmount);
	console.log("amountWithoutTax="+amountWithoutTax);
	$("#taxAmount"+ index).val(parseFloat(taxAmount).toFixed(2));
	$("#amountWithoutTax"+ index).val(parseFloat(amountWithoutTax).toFixed(2));
	
	if (!result && rate > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockin/getItemRateFromPage/" + itemCode + "/" + rate + "/" + qty + "/" + total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function updateEachStockInItem(itemId,tax) {
	//alert("itemId ::" + itemId);
	var date = document.getElementById('poDate').value;
	//alert(" Date ::" + date);
	var stockId = document.getElementById('stockInId').value;
	//alert("Pos Id ::" + stockId);
	var dbQuantity = document.getElementById('hdnQty' + itemId);
	var dbQty = dbQuantity.value;
	//alert("Dtabase Qty :: " + dbQty);
	var poNo = document.getElementById("pNo" + itemId);
	var poNoValue = poNo.value;
	//alert("poNoValue :: " + poNoValue);
	var dbPoNo = document.getElementById('hdnPO' + itemId);
	var dbPoNoValue = dbPoNo.value;
	//alert("dbPoNoValue :" + dbPoNoValue);
	var dbItemRateVal = document.getElementById('hdnItemRate' + itemId);
	var dbItemRate = dbItemRateVal.value;
	//alert("dbItemRate : " + dbItemRate);

	var itemRate = document.getElementById('itmRate' + itemId);
	var rate = itemRate.value;
	//alert("rate :" + rate);

	var totalItemPrice = document.getElementById('tdTotalPrice' + itemId);
	var totalPriceValue = totalItemPrice.innerHTML;
	//alert("totalPriceValue :: " + totalPriceValue);
	var itemQuantity = document.getElementById('itemQty' + itemId);
	var itemQty = itemQuantity.value;
	//alert("actual ItemQuantity ::" + itemQty);
//	var unitId = document.getElementById('tdUnit' + itemId);
//	alert("unitId="+unitId.value);
	var result = isNaN(itemQty);
	var itemRateResult = isNaN(rate);
	var floatRes = checkDecimals(itemQty);
	
	if (dbQty == itemQty && dbPoNoValue == poNoValue && parseFloat(dbItemRate) == parseFloat(rate)) {
		//alert("Please do some changes.");
		dosomechangesModal();
	} else if (result) {
		validitemquantityModal();
		//alert("Please enter valid Item Quantity");
	} else if (itemQty == '') {
		enteritemQuantityModal();
		//alert("Please enter Item Quantity.");
	} else if (itemQty == 0) {
		zeroitemquantityModal();
		//alert("Item Quantity can not be zero.");
	} else if (itemQty < 0) {
		positiveitemquantityModal();
		//alert("Please enter a positive Item Quantity");
	} 
//	else if (floatRes) {
//		//alert("can not be fraction");
//
//		quantityFloatValidateModal();
//	} 
	else if (itemRateResult) {
		ItemRateCharValidateModal();

	} else if (rate == '') {
		ItemRateBlankValidateModal();

	} else if (rate == 0) {
		ItemRateZeroValidateModal();

	} else if (rate < 0) {
		ItemRateNegativeValidateModal();

	} else {

		//alert('update order item');
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockin/updateEachStockInItem/" + itemId + "/" + itemQty + "/" + rate + "/" + totalPriceValue + "/" + poNoValue + "/" + date + "/" + stockId + ".htm", function(response) {
			try {
				//alert("response ::" + response);
				reponseObj = JSON.parse(response);
console.log(reponseObj);
				//alert("updated Item Id :" + reponseObj.itemId);
//				alert("updated Item Qty :" + reponseObj.itemQuantity);
//				alert("updated Item totalPirce :" + reponseObj.itemPrice);
				//alert("updated Item GRAND TOTAL :" + reponseObj.totalItemPrice);
				//alert("updated RESPONE :" + reponseObj.response);
//				alert("updated Item GRAND TOTAL :" + reponseObj.itemGrossAmount);
//				alert("updated Item totalItemPrice :" + reponseObj.totalItemPrice);
				if (reponseObj.response == 'success') {
					document.getElementById('update' + itemId).style.background = "#78b626";
					itemQuantity.value = reponseObj.itemQuantity;
					dbQuantity.value = reponseObj.itemQuantity;
					dbItemRateVal.value = reponseObj.itemPrice;
					itemRate.value = parseFloat(reponseObj.itemPrice).toFixed(2);
					$("#tdamountWithoutTax"+itemId).text(parseFloat(reponseObj.totalItemPrice).toFixed(2));
					totalItemPrice.innerHTML = parseFloat(reponseObj.itemQuantity*reponseObj.itemPrice).toFixed(2);
					poNo.value = reponseObj.poNo;
					dbPoNo.value = reponseObj.poNo;
					var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag');
					hdnPageAlertFlag.value = 'N';
					
				} else {
					//alert("Something wrong while updating the item.");
					document.getElementById('update' + itemId).style.background = "orange";
				}
			} catch (e) {
				//alert(e);
			}

		}, null);

	}

}

function deleteEachStockInItem(itemId) {
	//alert("Item Id ::" + itemId);
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	//alert("hdnPageAlertFlag : " + hdnPageAlertFlag);
	if (hdnPageAlertFlag == 'Y') {
		var hdnItemId = document.getElementById('hdnItemPoId');
		hdnItemId.value = itemId;

		deleteItemModal();
	} else {
		var hdnItemId = document.getElementById('hdnItemPoId');
		hdnItemId.value = itemId;

		confirmCancelItemModal();
	}
}

function deleteStockInItem() {
	var stockId = document.getElementById('stockInId').value;
	//alert("StockIn Id ::" + stockId);
	var itemId = document.getElementById('hdnItemPoId').value;

	location.href = 'deleteEachStockInItem.htm?stockInItemId=' + itemId + '&stockInId=' + stockId;
}

function removeNewlyItem(	itemCode,
							totalPrice) {
	//alert("removeNewlyItem ::" + itemCode + ":::" + totalPrice);
	var grandTotal = document.getElementById('totalId').value;

	var totalItemPrice = parseFloat(grandTotal) - parseFloat(totalPrice);
	//alert("totalItemPrice :" + totalItemPrice);

	var hdnItemCode = document.getElementById('hdnItemCode');
	hdnItemCode.value = itemCode;

	var hdnTotalPrice = document.getElementById('hdnTotalPrice');
	hdnTotalPrice.value = totalItemPrice;

	confirmNewlyAddedItemModal();
}

function removeNewlyAddedItem() {

	var billNo = document.getElementById('billNo').value;
	//alert("Bill No :" + billNo);
	
	var billDate = document.getElementById('billDate').value;

	var vendorId = document.getElementById('vendorId').value;
	//alert("vendorId : " + vendorId);

	var userId = document.getElementById('poCreatedId').value;
	var stockId = document.getElementById('stockInId').value;

	var hdnItemCode = document.getElementById('hdnItemCode').value;

	var hdnTotalPrice = document.getElementById('hdnTotalPrice').value;

	var miscChargeVal = document.getElementById('misChargeId').value;
	
	location.href = 'removeNewlyAddedItem.htm?itemCode=' + hdnItemCode + '&totalPrice=' + hdnTotalPrice + '&miscChargeVal=' + miscChargeVal + '&userId=' + userId + '&stockId=' + stockId + '&billNo=' + billNo + '&billDate=' + billDate +'&vendorId=' + vendorId;
}

function addNewItem() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
//	alert("hdnPageAlertFlag :: " + hdnPageAlertFlag);
	if (hdnPageAlertFlag == 'Y') {

		updateAlertInAddItemModal();
	} else {
		var searchedCode = document.getElementById('searchCode').value;
		
		var stockInId = document.getElementById('stockInId').value;
		//alert("stockInId ::" + stockInId);

		var date = document.getElementById('poDate').value;
		//alert("date : " + date);

		var vendorId = document.getElementById('vendorId').value;
		//alert("vendorId : " + vendorId);

		var miscCharge = document.getElementById('misChargeId').value;
		//alert("miscCharge : " + miscCharge);

		var billNo = document.getElementById('billNo').value;
		
		var billDate = document.getElementById('billDate').value;

		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		//alert("itemAddFlag : " + itemAddFlag);

		var todayDate = new Date();
		//need to add one to get current month as it is start with 0
		var todayDay = ("0" + (todayDate.getDate())).slice(-2);
		var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
		var todayYear = todayDate.getFullYear();
//		var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
		var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;
		//alert("todayDateText ::" + todayDateText);
		

		if (date != todayDateText && stockInId == 0) {
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
					//alert("jspoItemArray.length : " + jspoItemArray.length);
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
						location.href = 'addNewStockInItem.htm?itemCode=' + searchedCode + '&stockInId=' + stockInId + '&vendorId=' + vendorId + '&billNo=' + billNo + '&billDate=' + billDate + '&miscCharge=' + miscCharge;
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
						location.href = 'addNewStockInItem.htm?itemCode=' + searchedCode + '&stockInId=' + stockInId + '&vendorId=' + vendorId + '&billNo=' + billNo + '&billDate=' + billDate + '&miscCharge=' + miscCharge;
					}
				}
			}
		}
	}

}

function addNewStockInItem() {
	var searchedCode = document.getElementById('searchCode').value;
	
	var stockInId = document.getElementById('stockInId').value;
	//alert("stockInId ::" + stockInId);

	var date = document.getElementById('poDate').value;
	//alert("date : " + date);

	var vendorId = document.getElementById('vendorId').value;
	//alert("vendorId : " + vendorId);

	var miscCharge = document.getElementById('misChargeId').value;
	//alert("miscCharge : " + miscCharge); 

	var billNo = document.getElementById('billNo').value;
	var billDate = document.getElementById('billDate').value;

	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	//alert("itemAddFlag : " + itemAddFlag);

	var todayDate = new Date();
	//need to add one to get current month as it is start with 0
	var todayDay = ("0" + (todayDate.getDate())).slice(-2);
	var todayMonth = ("0" + (todayDate.getMonth() + 1)).slice(-2);
	var todayYear = todayDate.getFullYear();
//	var todayDateText = todayDay + "-" + todayMonth + "-" + todayYear;
	var todayDateText = todayYear + "-" + todayMonth + "-" + todayDay;
	//alert("todayDateText ::" + todayDateText);

	if (date != todayDateText && stockInId == 0) {
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
				//alert("jspoItemArray.length : " + jspoItemArray.length);
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
					location.href = 'addNewStockInItem.htm?itemCode=' + searchedCode + '&stockInId=' + stockInId + '&vendorId=' + vendorId + '&billNo=' + billNo + '&billDate=' + billDate + '&miscCharge=' + miscCharge;
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
					location.href = 'addNewStockInItem.htm?itemCode=' + searchedCode + '&stockInId=' + stockInId + '&vendorId=' + vendorId + '&billNo=' + billNo + '&billDate=' + billDate + '&miscCharge=' + miscCharge;
				}
			}
		}
	}
}

function checkValidate() {
	//alert("hello submit");
	var length = jsArray.length;
	//alert("Tbale Length ::" + length);
	var billNo = document.getElementById('billNo').value;
	var billDate = $("#billDate").val();
	if (billDate == '') {
		billDateValidateModal();
		return false;
	}
	//alert("Bill No : " + billNo);
	//var billResult = isNaN(billNo);
	//alert("billResult : " + billResult);
	var letterNumber = /((^[0-9]+[a-z]+)|(^[a-z]+[0-9]+))+[0-9a-z]+$/i;
	var numeric = /^[0-9]*$/;
	for ( var i = 0; i < length; i++) {
		var itemQty = document.getElementById("itemQty" + i).value;
		var poNo = document.getElementById("pNo" + i).value;
		var itemRate = document.getElementById('iRate' + i).value;
		//alert("Item itemRate:::" + itemRate);
		//var miscChrage = document.getElementById('misChargeId').value;
		//alert("miscChrage : " + miscChrage);
		//var mischargeResult = isNaN(miscChrage);
		//alert("mischargeResult : " + mischargeResult);
		var poResult = isNaN(poNo);
		//alert("poResult : " + poResult);
		var result = isNaN(itemQty);
		var itemRateResult = isNaN(itemRate);
		//alert("itemRateResult : " + itemRateResult);
		//alert("result : " + result);
		var floatRes = checkDecimals(itemQty);
		if (!itemRateResult) {
			if (itemRate == '') {
				//alert(" Item rate can not be blank");
				ItemRateBlankValidateModal();

				return false;
			} else if (itemRate == 0) {
				//alert(" Item rate can not be zero");
				ItemRateZeroValidateModal();

				return false;
			} else if (itemRate < 0) {
				//alert(" Item rate can not be negative");
				ItemRateNegativeValidateModal();

				return false;
			} else if (!result) {
				//alert("hello");
				//alert("Item Qty:::" + itemQty);
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
				} 
//				else if (floatRes) {
//					//alert("can not be fraction");
//					quantityFloatValidateModal();
//
//					return false;
//				} 
				else if (billNo == '') {
					//alert("Please enter Bill Number.");
					billNumberModal();

					return false;
				} else if (billNo != '') {
					//alert("Please enter Bill Number.");
					if (billNo.match(numeric) || billNo.match(letterNumber)) {

						return true;
					} else {
						billAlphaNumericValidateModal();

						return false;
					}
				}  else if (poResult) {
					//alert("Please enter valid PO Number.");
					validPONoModal();

					return false;
				}
			} else if (result) {
				//alert("Please enter valid Item Quantity");
				validitemquantityModal();

				return false;
			}
		} else if (itemRateResult) {
			//alert("plz valid item rate");
			ItemRateCharValidateModal();

			return false;
		}
	}
	
}
