function rowClicked(stockOutId) {
	//alert("Id ::" + stockOutId);
	var date = document.getElementById('poDate').value;
	//alert("Selected Date : " + date);
	var hdnStockOutId = document.getElementById('hdnStockOutId');
	hdnStockOutId.value = stockOutId;

	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag == "Y") {
		displayStockOutByIdModal();
	} else {
		location.href = 'stockoutByPoId.htm?stockOutId=' + stockOutId + '&date=' + date;
	}
}

function getStockOutById() {
	var date = document.getElementById('poDate').value;
	//alert("Selected Date : " + date);
	var hdnStockOutId = document.getElementById('hdnStockOutId').value;
	location.href = 'stockoutByPoId.htm?stockOutId=' + hdnStockOutId + '&date=' + date;
}

function dateformat(str) {
	var dt = parseInt(str.substring(0, 2), 10);
	var mon = parseInt(str.substring(3, 5), 10);
	var yr = parseInt(str.substring(6, 10), 10);
	str = new Date(yr, mon - 1, dt);
	return str;
}

function getStockOutByDate() {
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
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayStockOutByDateModal();
		} else {
			location.href = 'viewstockoutByDate.htm?date=' + date;
		}
	}
}

function stockOutByDate() {
	var date = document.getElementById('poDate').value;

	location.href = 'viewstockoutByDate.htm?date=' + date;
}

function newStockOut() {
	var jsArray = [];
	jsArray.length = 0;

	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag == "Y") {
		displayNewStockOutModal();
	} else {
		location.href = 'newstockout.htm';
	}
}

function getNewStockOut() {
	location.href = 'newstockout.htm';
}

function addNewStockOut() {
	//alert("hello add");
	var searchedCode = document.getElementById('searchCode').value;
	//alert("Item Code ::" + searchedCode);
	if (searchedCode == '') {
		//alert("Please search an item correctly.");
		searchitemcorrectlyModal();
	} else {
		var status = 'N';
		//alert("hello 1223343");
		//alert("array length : " + jsArray.length);
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
			//alert("add item");
			location.href = 'addnewStockOutRow.htm?itemCode=' + searchedCode;
		}
	}
}

function deleteStockOutItem(itemCode,
							totalPrice) {
	//alert("Item Code : " + itemCode);
	//alert("Item total price : " + totalPrice);
	var grandTotal = document.getElementById('gdTotal').value;
	//alert("grandTotal : " + grandTotal);

	var residualTotalPrice = grandTotal - totalPrice;
	//alert("residualTotalPrice : " + residualTotalPrice);

	var hdnItemCode = document.getElementById('hdnItemCode');
	hdnItemCode.value = itemCode;

	var hdnTotalPrice = document.getElementById('hdnTotalPrice');
	hdnTotalPrice.value = residualTotalPrice;

	confirmNewlyAddedItemModal();
}

function removeNewlyAddedItem() {

	var hdnItemCode = document.getElementById('hdnItemCode').value;

	var hdnTotalPrice = document.getElementById('hdnTotalPrice').value;

	location.href = 'deleteNewlyAddedStockOutItem.htm?itemCode=' + hdnItemCode + '&residualTotalPrice=' + hdnTotalPrice;
}

function getPrice(	index,
					rate,
					itemCode) {
	//alert("Id and rate:" + index + "---" + rate);
	var grandTotal = document.getElementById('gdTotal');
	var gdTotalVal = grandTotal.value;
	var totalItemAmt = gdTotalVal.replace(/\,/g, "");

	var totalqty = document.getElementById('iTotalRate' + index);
	var totalQtyVal = totalqty.value;
	//alert(" input value ::" + totalqty);
	var qty = document.getElementById('itemQty' + index).value;
//	alert("hi ::");
//	alert("actual ItemQrty ::" + qty);
	var unit = document.getElementById('iUnit' + index).value;
	
	var menuCategoryName = document.getElementById('imenuCategoryName' + index).value;
	
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
	var residualQty = parseFloat(total) - parseFloat(totalQtyVal);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal AMT :" + total);totalqty.value = parseFloat(total).toFixed(1);
	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);

	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockout/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit +"/" +menuCategoryName+"/"+ total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getMetricunitVal(unitId,index,rate,itemCode){
	var grandTotal = document.getElementById('gdTotal');
	var gdTotalVal = grandTotal.value;
	var totalItemAmt = gdTotalVal.replace(/\,/g, "");

	var totalqty = document.getElementById('iTotalRate' + index);
	var totalQtyVal = totalqty.value;
	//alert(" input value ::" + totalqty);
	var qty = document.getElementById('itemQty' + index).value;
//	alert("hi ::");
//	alert("actual ItemQrty ::" + qty);
	var unit = unitId;
	var menuCategoryName = document.getElementById('imenuCategoryName' + index).value;
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
	var residualQty = parseFloat(total) - parseFloat(totalQtyVal);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal AMT :" + total);totalqty.value = parseFloat(total).toFixed(1);
	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);

	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockout/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit +"/"+menuCategoryName+"/" + total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function getToWhom(towhom,index,rate,itemCode){
//	alert("towhom="+towhom);
//	alert("Id and rate:" + index + "---" + rate+"---"+itemCode);
//	getNewStockOut();
	var grandTotal = document.getElementById('gdTotal');
	var gdTotalVal = grandTotal.value;
	var totalItemAmt = gdTotalVal.replace(/\,/g, "");

	var totalqty = document.getElementById('iTotalRate' + index);
	var totalQtyVal = totalqty.value;
	//alert(" input value ::" + totalqty);
	var qty = document.getElementById('itemQty' + index).value;
//	alert("hi ::");
//	alert("actual ItemQrty ::" + qty);
	var unit = document.getElementById('iUnit' + index).value;
	
	var menuCategoryName = towhom;
	
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
	var residualQty = parseFloat(total) - parseFloat(totalQtyVal);

	var sumTotal = parseFloat(totalItemAmt) + parseFloat(residualQty);
	//alert("sumTotal AMT :" + total);totalqty.value = parseFloat(total).toFixed(1);
	totalqty.value = parseFloat(total).toFixed(2);
	grandTotal.value = parseFloat(sumTotal).toFixed(2);

	if (!result && qty > 0) {
		//alert("getItemInfoFromPage");
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/stockout/getItemInfoFromPage/" + itemCode + "/" + qty + "/" + unit +"/" +menuCategoryName+"/"+ total + "/" + sumTotal + ".htm", function(response) {
		}, null);
	}
}

function clearItemValue(index) {
	//alert("index : " + index);
	document.getElementById('itemQty' + index).value = '';

	var totalqty = document.getElementById('iTotalRate' + index);
	var totalQtyVal = totalqty.value;
	var totalQtyValue = totalQtyVal.replace(/\,/g, "");
	//alert("totalQtyValue : " + totalQtyValue );

	var grandTotal = document.getElementById('gdTotal');
	var gdTotalVal = grandTotal.value;
	var gdTotalValue = gdTotalVal.replace(/\,/g, "");
	//alert("gdTotalValue : " + gdTotalValue );

	var residualVal = parseFloat(gdTotalValue) - parseFloat(totalQtyValue);
	//alert("residualVal : " + residualVal);
	totalqty.value = '0.00';
	grandTotal.value = parseFloat(residualVal).toFixed(2);
}

function checkDecimals(input) {
	var decimal = /^[-+]?[0-9]+\.[0-9]+$/;
	if (input.match(decimal)) {
		return true;
	} else {
		return false;
	}
}

function checkValidate() {
//	alert("hello submit");
	var length = jsArray.length;
//	alert("Tbale Length ::" + length);
	for ( var i = 0; i < length; i++) {
		
		var itemQty = document.getElementById("itemQty" + i).value;
//		var toWhom = document.getElementById('iToWhom' + i).value;
//		alert("Item Qty:::" + itemQty);
		var result = isNaN(itemQty);
//		var floatRes = checkDecimals(itemQty);

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
			} 
//			else if (floatRes) {
//				//alert("Item Quantity can not be fractioned.");
//				quantityFloatValidateModal();
//
//				return false;
//			}
//			else if (toWhom == '') {
//				//alert("Please fill up the toWhom Box.");
//				toWhomModal();
//				return false;
//			}
		} else {
			//alert("Please enter valid Item Quantity");
			validitemquantityModal();
			return false;
		}
	}
}
