/**
 * 
 */

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
function viewPurchaseReturnPage(){
	location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
	
}
function viewPurchaseOrder() {
	location.href = BASE_URL + '/inventorynew/loadinventory.htm';
	}



 
$(function () {  
    $("#fgstockinExport").click(function () {  
        $("#itemNewStockDisplay").table2excel({  
            filename: "FG_Current_Stock.xls"  
        });  
    });  
});  
