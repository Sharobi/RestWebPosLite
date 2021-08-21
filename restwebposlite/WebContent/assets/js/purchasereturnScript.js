/**
 *
 */
function viewStockIn() {
    location.href = BASE_URL + '/stockinnew/loadstockin.htm';
}

function viewPurchaseOrder() {
    location.href = BASE_URL + '/inventorynew/loadinventory.htm';
}

function viewStockOut() {
    location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
}

function viewItemStockInsertPage() {
    location.href = BASE_URL + '/itemstockin/loaditemstockin.htm';

}
function openNewPurchaseReturn() {
    $("#returnitemdetails").html("");
    $("#stkinNo").val("");
    $('#stkinNo').prop('disabled', false);
    $("#billNo").val("");
    $("#billDate").val("");
    $("#selectedvendorId").val("");
    $("#misChargeId").val("");
    $("#discountId").val("");
    $("#discountAmtId").val("");
    $("#totalTaxId").val("");
    $("#grandtotalId").val("");
    $("#roundOffAmtId").val("");
    $("#billcallbtn").removeClass('disabled');
    $('#selectedvendorId').prop('disabled', false);
    $("#selectedreturnreasonId").val("");
    $("#returnRemarks").val("");
    $("#createdpurchasereturnid").val(0);

    $("#closepurchasereturn").val('N');
    $('#closepurchasereturn').removeAttr('disabled');
    $("#purchaseReturnUserId").val('');
    $("#closepurchasereturnButton").removeClass('disabled');


    $("#misChargeId").val(0.00);
    $("#grandtotalId").val(0.00);
    $("#discountAmtId").val(0.00);
    $("#totalTaxId").val(0.00);
    $("#discountId").val(0.00);
    $("#roundOffAmtId").val(0.00);
    setButton();




}

function numcheck(e) { // new added

    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}


function setButton() { //add new
    //alert('setbut');
    var purchasereturnid = $("#createdpurchasereturnid").val();
    //alert('setbut'+purchasereturnid);
    var activebutton = "";
    if (purchasereturnid == '0') {
        activebutton = "<a href='javascript:purchaseReturnSaveOrUpdate()' id='purchaseReturnSaveOrUpdate' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";

    } else {
        activebutton = "<a href='javascript:purchaseReturnSaveOrUpdate()' id='purchaseReturnSaveOrUpdate' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";

    }
    document.getElementById("operationbtnspan").innerHTML = activebutton;
}



function getPurchaseReturnByDate() {
    var purchaseReturnDate = $("#purchaseReturnDate").val();
    //alert("purchaseReturnDate:"+purchaseReturnDate);
    console.log("selectDate=" + purchaseReturnDate);
    location.href = BASE_URL + "/purchasereturn/getPurchaseReturndetailsbydate/" + purchaseReturnDate + ".htm";
}



function rowClicked(id) {
    //alert("clicked"+id);

    $("#inventoryPurchaseReturnListTbl").css("pointer-events", "none");
    $("#purchaseReturnItemTableDiv").addClass('hide');
    $("#waitimage").removeClass('hide');

    $('#billNo').prop('disabled', true);
    $('#billDate').prop('disabled', true);
    $("#billcallbtn").addClass('disabled');
    var selectDate = $("#purchaseReturnDate").val();
    var stkinno = 0;
    var remark = "";
    console.log("selectDate=" + selectDate);
    console.log("id=" + id);
    $("#selectedpurchasereturnid").val(id);

    var returnsTypes = JSON.parse(returnTypes);
    var options = "";
    var option = "<option value='" + 0 + "'>Select Return Type</option>";
    for (var i = 0; i < returnsTypes.length; i++) {
        options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
    }
    var alloptions = option + options;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/purchasereturn/getpurchaseReturndetailsbyidanddate/" + id + "/" + selectDate + ".htm", function(response) {
        console.log("response=" + response);
        var purchasereturndetail = JSON.parse(response);
        $("#returnitemdetails").html("");
        //for ( var i = 0; i < purchasereturndetail.length; i++) {
        var purchasereturnItems = purchasereturndetail;

        $("#createdpurchasereturnid").val(purchasereturnItems.id);

        console.log("response=" + purchasereturnItems.inventoryReturnItems.length);
        for (var j = 0; j < purchasereturnItems.inventoryReturnItems.length; j++) {
            var itemdetail = purchasereturnItems.inventoryReturnItems[j];
            stkinno = itemdetail.inventoryStckIn.id;
            //alert("stkinno:"+stkinno);
            var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
            var firsttdline_id = "<td  id='purchaseditmcodetd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmcode_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
            var secondtdline_name = "<td id='purchaseditmnametd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='stockinid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryStckIn.id + "' /><input type='hidden'  id='purchasereturnid_" + itemdetail.inventoryItems.id + "' value='" + purchasereturnItems.id + "' /><input type='hidden'  id='purchasereturnitemid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.id + "' />" + itemdetail.inventoryItems.name + "</td>";
            var thirdtdline_invqty = "<td id='purchaseditminvqtytd_" + itemdetail.inventoryItems.id + "'>" + itemdetail.itemInvoiceQuantity + "</td>";

            var fourthtdline_returnqty = "";
            if (purchasereturnItems.approved == 'N') {
                fourthtdline_returnqty = "<td id='purchaseditmreturnqtytd_" + itemdetail.inventoryItems.id + "'><input  type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.inventoryItems.taxRate + "," + itemdetail.itemInvoiceQuantity + ") id='purchaseditmreturnqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' onkeydown='numcheck(event);' /></td>";
            } else {
                fourthtdline_returnqty = "<td id='purchaseditmreturnqtytd_" + itemdetail.inventoryItems.id + "'><input readonly type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.inventoryItems.taxRate + "," + itemdetail.itemInvoiceQuantity + ") id='purchaseditmreturnqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' onkeydown='numcheck(event);' /></td>";
            }

            var fifthtdline_unit = "<td id='purchaseditmunittd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unitId + "' />" + itemdetail.metricUnit.unit + "</td>";
            var sixthtdline_invrate = "<td id='purchaseditminvratetd_" + itemdetail.inventoryItems.id + "'>" + itemdetail.itemInvoiceRate + "</td>";

            var seventhtdline_returnrate = "";
            if (purchasereturnItems.approved == 'N') {
                seventhtdline_returnrate = "<td id='purchaseditmreturnratetd_" + itemdetail.inventoryItems.id + "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.inventoryItems.taxRate + "," + itemdetail.itemInvoiceRate + ") id='purchaseditmreturnrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemRate + "' onkeydown='numcheck(event);'/> </td>";
            } else {
                seventhtdline_returnrate = "<td id='purchaseditmreturnratetd_" + itemdetail.inventoryItems.id + "'><input readonly type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.inventoryItems.taxRate + "," + itemdetail.itemInvoiceRate + ") id='purchaseditmreturnrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemRate + "' onkeydown='numcheck(event);'/> </td>";

            }

            var eightthtdline_tax = "<td id='purchaseditmtaxtd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmtaxid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.taxRate + "' />" + parseFloat(itemdetail.inventoryItems.taxRate).toFixed(2) + "</td>";
            var ninethtdline_taxamt = "<td id='purchaseditmtaxamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemdetail.taxAmount).toFixed(2) + "</td>";
            var tenthtdline_disc = "<td id='purchaseditmdisctd_" + itemdetail.inventoryItems.id + "'><input style='display:none;' type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.inventoryItems.taxRate + ") id='purchaseditmdisc_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(itemdetail.disPer).toFixed(2) + "' />" + parseFloat(itemdetail.disPer).toFixed(2) + "</td>";
            var eleventhtdline_discamt = "<td id='purchaseditmdiscamttd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.disAmt).toFixed(2) + "</td>";
            var twelevethtdline_itmamt = "<td id='purchaseditmitmamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemdetail.itemTotalPrice).toFixed(2) + "</td>";
            var thirteenthtdline_total = "<td id='purchaseditmtottd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.itemGrossAmount).toFixed(2) + "</td>";
            remark = itemdetail.remarks;
            var fourtenthtdline_returnreason = "<td id='purchaseditmreturnreasontd_" + itemdetail.inventoryItems.id + "'> <select id='purchaseditmreturnreason_" + itemdetail.inventoryItems.id + "' name='selectedpurreturnreason'>" + alloptions + "</select></td>";
            var fifteenthtdline_poid = "<td id='purchaseditmpoidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + itemdetail.poId + "</td>";
            var sixteenthtdline_shipping = "<td id='purchaseditmshipingtd_" + itemdetail.inventoryItems.id + "'style='display:none;'><input type='text' size='4'  id='purchaseditmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.shippingCharge + "' /></td>";
            var seventeenthtdline_istaxexclusive = "<td id='purchaseditmistaxexclusivetd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='text' size='4'  id='purchaseditmistaxexclusive_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
            var eighteenthtdline_itemid = "<td id='purchaseditmidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + itemdetail.inventoryItems.id + "</td>";
            var nineteenthtdline_itemvendorid = "<td id='purchaseditmvendoridtd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='hidden'  id='purchaseditmvendorid_" + itemdetail.inventoryItems.id + "' value='" + purchasereturnItems.vendorId + "' />" + purchasereturnItems.vendorId + "</td>";
            var tweneenthtdline_edpno = "<td id='purchaseditmedptd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + purchasereturnItems.edpId + "</td>";
            var actionline = "";
            if (purchasereturnItems.approved == 'N') {
                actionline = "<td><a href='javascript:deleteRowId(" + itemdetail.inventoryItems.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
            } else {
                actionline = "<td></td>";

            }
            var endtrline = "</tr>";


            createdrowline = starttrline + firsttdline_id + secondtdline_name + thirdtdline_invqty + fourthtdline_returnqty + fifthtdline_unit + sixthtdline_invrate + seventhtdline_returnrate + eightthtdline_tax + ninethtdline_taxamt + tenthtdline_disc + eleventhtdline_discamt + twelevethtdline_itmamt + thirteenthtdline_total + fourtenthtdline_returnreason + fifteenthtdline_poid + sixteenthtdline_shipping + seventeenthtdline_istaxexclusive + eighteenthtdline_itemid + nineteenthtdline_itemvendorid + tweneenthtdline_edpno + actionline + endtrline;

            $("#purchaseReturnItemTableDiv").removeClass('hide');
            $("#waitimage").addClass('hide');
            $("#inventoryPurchaseReturnListTbl").css("pointer-events", "");

            $("#returnitemdetails").append(createdrowline);
            $('#purchaseditmreturnreason_' + itemdetail.inventoryItems.id).val(itemdetail.returnTypes.id);

        }

        $("#stkinNo").val(stkinno);
        $('#stkinNo').prop('disabled', true);
        $("#billNo").val(purchasereturnItems.billNo);
        $("#billDate").val(purchasereturnItems.billDate);
        $("#selectedvendorId").val(purchasereturnItems.vendorId);

       /* getvendorledger_pur($('#creditor_code1').val(), 0, purchasereturnItems.vendorId, 3); // for  creditor account
      */      
        $("#misChargeId").val(purchasereturnItems.miscCharge);
        $("#discountId").val(purchasereturnItems.disPer);
        $("#discountAmtId").val(purchasereturnItems.disAmt);
        $("#totalTaxId").val(purchasereturnItems.taxAmt);
        $("#grandtotalId").val(purchasereturnItems.netAmt);
        $("#roundOffAmtId").val(purchasereturnItems.roundOffAmt);
        $("#itemtotal").val(purchasereturnItems.itemTotal);
        $("#selectedreturnreasonId").val(purchasereturnItems.returnTypeId);

        $("#returnRemarks").val(remark);


        setButton();
        if (purchasereturnItems.approved == 'Y') {
            $("#purchaseReturnSaveOrUpdate").addClass('disabled');
            $("#selectedvendorId").prop('disabled', true);
            $("#closepurchasereturn").val('Y');
            $("#closepurchasereturnButton").addClass('disabled');
            $('#closepurchasereturn').prop('disabled', true);
            $("#purchaseReturnUserId").val(purchasereturnItems.createdBy);
            $("#PurchaseReturnDelete").addClass('disabled');

            //$('#discountId').prop('disabled', true);
            ////$("#stockInPrint").removeClass('disabled');
        } else {
            $("#closepurchasereturn").val('N');
            $("#purchaseReturnUserId").val('');
            $("#closepurchasereturnButton").removeClass('disabled');
            $('#closepurchasereturn').removeAttr('disabled');
            $("#selectedvendorId").prop('disabled', true);
            $("#purchaseReturnSaveOrUpdate").removeClass('disabled');
            $("#PurchaseReturnDelete").removeClass('disabled');


            //$("#stockInPrint").addClass('disabled');
        }
        //}

    }, null);
}




function bringBillDetails() {
    $("#returnitemdetails").html("");
    var stockinid = document.getElementById('stkinNo').value;
    var selectDate = $("#purchaseReturnDate").val();
    console.log("selectDate=" + selectDate);
    console.log("id=" + stockinid);
    if (stockinid == '' || stockinid == 'undefined' || stockinid == null) {
        document.getElementById('msgspace').innerHTML = "Please Enter Valid Stockin Number.";
        $("#msgmodal").modal('show');
    } else {

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjax(BASE_URL + "/stockinnew/getstockIndetailsbyidanddate/" + stockinid + "/" + selectDate + ".htm", function(response) {
            console.log("response=" + response);
            var stockindetail = JSON.parse(response);
            $("#returnitemdetails").html("");

            if (stockindetail.length > 0) {
                $("#billcallbtn").addClass('disabled');
                $('#selectedvendorId').prop('disabled', true);

                var returnsTypes = JSON.parse(returnTypes);
                var options = "";
                var option = "<option value='" + 0 + "'>Select Return Type</option>";
                for (var i = 0; i < returnsTypes.length; i++) {
                    options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
                }
                var alloptions = option + options;

                for (var i = 0; i < stockindetail.length; i++) {
                    var invstockInItems = stockindetail[i];
                    $("#stkinNo").val(invstockInItems.id);
                    $('#stkinNo').prop('disabled', true);
                    console.log("response=" + invstockInItems.inventoryStockInItems.length);
                    for (var j = 0; j < invstockInItems.inventoryStockInItems.length; j++) {
                        var itemdetail = invstockInItems.inventoryStockInItems[j];
                        //console.log("response.code=" + itemdetail.code);
                        var createdrowline = "";

                        var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
                        var firsttdline_id = "<td  id='purchaseditmcodetd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmcode_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
                        var secondtdline_name = "<td id='purchaseditmnametd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='stockinid_" + itemdetail.inventoryItems.id + "' value='" + invstockInItems.id + "' /><input type='hidden'  id='purchasereturnid_" + itemdetail.inventoryItems.id + "' value='0' />" + itemdetail.inventoryItems.name + "</td>";
                        var thirdtdline_invqty = "<td id='purchaseditminvqtytd_" + itemdetail.inventoryItems.id + "'>" + itemdetail.itemQuantity + "</td>";
                        var fourthtdline_returnqty = "<td id='purchaseditmreturnqtytd_" + itemdetail.inventoryItems.id + "'><input  type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate + "," + itemdetail.itemQuantity + ") id='purchaseditmreturnqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity + "' onkeydown='numcheck(event);' /></td>";
                        var fifthtdline_unit = "<td id='purchaseditmunittd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unitId + "' />" + itemdetail.metricUnit.unit + "</td>";
                        var sixthtdline_invrate = "<td id='purchaseditminvratetd_" + itemdetail.inventoryItems.id + "'>" + itemdetail.itemRate + "</td>";
                        var seventhtdline_returnrate = "<td id='purchaseditmreturnratetd_" + itemdetail.inventoryItems.id + "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate + "," + itemdetail.itemRate + ") id='purchaseditmreturnrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemRate + "' onkeydown='numcheck(event);'/> </td>";
                        var eightthtdline_tax = "<td id='purchaseditmtaxtd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='purchaseditmtaxid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.taxRate + "' />" + parseFloat(itemdetail.taxRate).toFixed(2) + "</td>";
                        var ninethtdline_taxamt = "<td id='purchaseditmtaxamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemdetail.taxAmount).toFixed(2) + "</td>";
                        var tenthtdline_disc = "<td id='purchaseditmdisctd_" + itemdetail.inventoryItems.id + "'><input style='display:none;' type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate + ") id='purchaseditmdisc_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(itemdetail.discPer).toFixed(2) + "' />" + parseFloat(itemdetail.discPer).toFixed(2) + "</td>";
                        var eleventhtdline_discamt = "<td id='purchaseditmdiscamttd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.discAmt).toFixed(2) + "</td>";
                        var twelevethtdline_itmamt = "<td id='purchaseditmitmamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemdetail.itemTotalPrice).toFixed(2) + "</td>";
                        var thirteenthtdline_total = "<td id='purchaseditmtottd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.itemGrossAmount).toFixed(2) + "</td>";
                        var fourtenthtdline_returnreason = "<td id='purchaseditmreturnreasontd_" + itemdetail.inventoryItems.id + "'> <select id='purchaseditmreturnreason_" + itemdetail.inventoryItems.id + "' name='selectedpurreturnreason'>" + alloptions + "</select></td>";
                        var fifteenthtdline_poid = "<td id='purchaseditmpoidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + itemdetail.poId + "</td>";
                        var sixteenthtdline_shipping = "<td id='purchaseditmshipingtd_" + itemdetail.inventoryItems.id + "'style='display:none;'><input type='text' size='4'  id='purchaseditmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.shippingCharge + "' /></td>";
                        var seventeenthtdline_istaxexclusive = "<td id='purchaseditmistaxexclusivetd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='text' size='4'  id='purchaseditmistaxexclusive_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
                        var eighteenthtdline_itemid = "<td id='purchaseditmidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + itemdetail.inventoryItems.id + "</td>";
                        var nineteenthtdline_itemvendorid = "<td id='purchaseditmvendoridtd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='hidden'  id='purchaseditmvendorid_" + itemdetail.inventoryItems.id + "' value='" + invstockInItems.vendorId + "' />" + invstockInItems.vendorId + "</td>";
                        var tweneenthtdline_edpno = "<td id='purchaseditmedptd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + invstockInItems.edpId + "</td>";
                        var actionline = "<td><a href='javascript:deleteRowId(" + itemdetail.inventoryItems.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
                        var endtrline = "</tr>";

                        createdrowline = starttrline + firsttdline_id + secondtdline_name + thirdtdline_invqty + fourthtdline_returnqty + fifthtdline_unit + sixthtdline_invrate + seventhtdline_returnrate + eightthtdline_tax + ninethtdline_taxamt + tenthtdline_disc + eleventhtdline_discamt + twelevethtdline_itmamt + thirteenthtdline_total + fourtenthtdline_returnreason + fifteenthtdline_poid + sixteenthtdline_shipping + seventeenthtdline_istaxexclusive + eighteenthtdline_itemid + nineteenthtdline_itemvendorid + tweneenthtdline_edpno + actionline + endtrline;

                        $("#returnitemdetails").append(createdrowline);
                        $("#billNo").val(invstockInItems.billNo);
                        $("#billDate").val(invstockInItems.billDate);
                        $("#selectedvendorId").val(invstockInItems.vendorId);

                        /*getvendorledger_pur($('#creditor_code1').val(), 0, invstockInItems.vendorId, 3); // creditor account*/
                        $("#misChargeId").val(invstockInItems.miscCharge);
                        $("#discountId").val(invstockInItems.discPer);
                        $("#discountAmtId").val(invstockInItems.discAmt);
                        $("#totalTaxId").val(invstockInItems.taxAmt);
                        $("#grandtotalId").val(invstockInItems.totalPrice);
                        $("#roundOffAmtId").val(invstockInItems.roundOffAmt);
                        $("#itemtotal").val(invstockInItems.itemTotal);


                    }


                }
            } else {
                document.getElementById('msgspace').innerHTML = "Stockin No Does Not Exist!!";
                $("#msgmodal").modal('show');
                $("#stkinNo").val('');
            }
        }, null);

    }



}




function selectReason(reason) {
    //alert("reason id"+reason);
    $('#returnitemdetails tr').each(function() {
        var trid = $(this).find("td:eq(17)").html();
        $("#purchaseditmreturnreason_" + trid).val(reason);
    });
}



function changeQty(qty, itemid, shcharge, taxrate, pastqty) {

    var isno = isNaN(qty);
    if (isno) {
        $("#validitemquantityorrate").modal('show');
    } else {
        if (qty < 0) {
            $("#positiveitemquantityorrate").modal('show');
        }
        if (Number(qty) > Number(pastqty)) {
            document.getElementById('msgspace').innerHTML = "Invalid Return Quantity.";
            $("#msgmodal").modal('show');
            $("#purchaseditmreturnqty_" + itemid).val(pastqty);
        } else {
            var rate = $("#purchaseditmreturnrate_" + itemid).val();
            var discountperc = $("#purchaseditmdisc_" + itemid).val();
            var istaxexclusive = $("#purchaseditmistaxexclusive_" + itemid).val();
            //alert("rate:"+rate+" " +"discountperc:"+" "+ discountperc +"istaxexclusive:"+ istaxexclusive);

            var itemamount = Number(qty) * Number(rate);
            //alert("itemamount:"+itemamount);
            var itemdiscountamt = 0.00;
            var itemtotalamt = 0.00;
            var itemtaxamt = 0.00;

            if (discountperc != '' && discountperc != '0') {
                //alert("in discount");
                if (istaxexclusive == 'Y') {
                    // alert("in tax exclusive with disc");
                    itemdiscountamt = Number(itemamount) * Number(discountperc) / 100;
                    itemtaxamt = ((Number(itemamount) - Number(itemdiscountamt)) * Number(taxrate)) / 100;
                    itemtotalamt = Number(itemamount) - Number(itemdiscountamt) + Number(itemtaxamt);
                } else {
                    //alert("in tax inclusive with disc");
                    var basePrice = Number(itemamount) / (1 + (Number(taxrate) / 100)); //this basePrice is without tax amt
                    // alert("basePrice:"+basePrice);
                    itemdiscountamt = Number(basePrice) * Number(discountperc) / 100; // discount amt on basePrice
                    itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt)) * Number(taxrate)) / 100; // tax amt on basePrice
                    itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
                }
                //alert("itemtotalamt:"+itemtotalamt);
            } else {
                //alert("no disc");
                if (istaxexclusive == 'Y') {
                    //alert("in tax exclusive without disc");
                    itemtaxamt = (Number(itemamount) * Number(taxrate)) / 100;
                    itemtotalamt = Number(itemamount) + Number(itemtaxamt);
                } else {
                    //alert("in tax inclusive without disc");
                    var basePrice = Number(itemamount) / (1 + (Number(taxrate) / 100)); //this basePrice is without tax amt
                    //alert("basePrice:"+basePrice);
                    itemtaxamt = (Number(basePrice) * Number(taxrate)) / 100; // tax amt on basePrice
                    //alert("itemtaxamt:"+itemtaxamt);
                    itemtotalamt = Number(basePrice) + Number(itemtaxamt);
                    //alert("itemtotalamt:"+itemtotalamt);

                }
                //alert("itemtotalamt1:"+itemtotalamt);

            }

            $("#purchaseditmtaxamttd_" + itemid).text(parseFloat(itemtaxamt).toFixed(2));
            $("#purchaseditmitmamttd_" + itemid).text(parseFloat(itemamount).toFixed(2));
            $("#purchaseditmdiscamttd_" + itemid).text(parseFloat(itemdiscountamt).toFixed(2));
            $("#purchaseditmtottd_" + itemid).text(parseFloat(itemtotalamt).toFixed(2));

            calculateGrandTotal();

        }
    }
}

function changeRate(rate,
    itemid,
    shcharge,
    taxrate,
    pastrate) {

    var isno = isNaN(rate);
    if (isno) {
        $("#validitemquantityorrate").modal('show');
    } else {
        if (rate < 0) {
            $("#positiveitemquantityorrate").modal('show');
        }
        if (Number(rate) > Number(pastrate)) {
            document.getElementById('msgspace').innerHTML = "Invalid Return Rate.";
            $("#msgmodal").modal('show');
            $("#purchaseditmreturnrate_" + itemid).val(pastrate);

        } else {
            var qty = $("#purchaseditmreturnqty_" + itemid).val();
            var discountperc = $("#purchaseditmdisc_" + itemid).val();
            var istaxexclusive = $("#purchaseditmistaxexclusive_" + itemid).val();

            var itemamount = Number(qty) * Number(rate);
            //alert("itemamount:"+itemamount);
            var itemdiscountamt = 0.00;
            var itemtotalamt = 0.00;
            var itemtaxamt = 0.00;

            if (discountperc != '' && discountperc != '0') {
                //alert("in discount");
                if (istaxexclusive == 'Y') {
                    // alert("in tax exclusive with disc");
                    itemdiscountamt = Number(itemamount) * Number(discountperc) / 100;
                    itemtaxamt = ((Number(itemamount) - Number(itemdiscountamt)) * Number(taxrate)) / 100;
                    itemtotalamt = Number(itemamount) - Number(itemdiscountamt) + Number(itemtaxamt);
                } else {
                    // alert("in tax inclusive with disc");
                    var basePrice = Number(itemamount) / (1 + (Number(taxrate) / 100)); //this basePrice is without tax amt
                    //alert("basePrice:"+basePrice);
                    itemdiscountamt = Number(basePrice) * Number(discountperc) / 100; // discount amt on basePrice
                    itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt)) * Number(taxrate)) / 100; // tax amt on basePrice
                    itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
                }
                //alert("itemtotalamt:"+itemtotalamt);
            } else {
                //alert("no disc");
                if (istaxexclusive == 'Y') {
                    //alert("in tax exclusive without disc");
                    itemtaxamt = (Number(itemamount) * Number(taxrate)) / 100;
                    itemtotalamt = Number(itemamount) + Number(itemtaxamt);
                } else {
                    // alert("in tax inclusive without disc");
                    var basePrice = Number(itemamount) / (1 + (Number(taxrate) / 100)); //this basePrice is without tax amt
                    //alert("basePrice:"+basePrice);
                    itemtaxamt = (Number(basePrice) * Number(taxrate)) / 100; // tax amt on basePrice
                    //alert("itemtaxamt:"+itemtaxamt);
                    itemtotalamt = Number(basePrice) + Number(itemtaxamt);
                    //alert("itemtotalamt:"+itemtotalamt);

                }


            }

            $("#purchaseditmtaxamttd_" + itemid).text(parseFloat(itemtaxamt).toFixed(2));
            $("#purchaseditmitmamttd_" + itemid).text(parseFloat(itemamount).toFixed(2));
            $("#purchaseditmdiscamttd_" + itemid).text(parseFloat(itemdiscountamt).toFixed(2));
            $("#purchaseditmtottd_" + itemid).text(parseFloat(itemtotalamt).toFixed(2));



            calculateGrandTotal();
        }
    }
}


function calculateGrandTotal() {
    console.log("call calculateGrandTotal");
    var grandtotal = 0.00;
    var totaltaxamt = 0.00;
    var totaldiscamt = 0.00;
    var mischarge = $("#misChargeId").val();
    $('#returnitemdetails tr').each(function() {
        var trid = $(this).find("td:eq(17)").html();
        var taxamt = $("#purchaseditmtaxamttd_" + trid).html();
        var discamt = $("#purchaseditmdiscamttd_" + trid).html();
        var itmtotal = $(this).find("td:eq(12)").html();

        grandtotal = grandtotal + Number(itmtotal);
        totaltaxamt = totaltaxamt + Number(taxamt);
        totaldiscamt = totaldiscamt + Number(discamt);

    });
    grandtotal = grandtotal + Number(mischarge);

    if (roundoffflag == 'Y') {
        var totalbeforeround = grandtotal;
        grandtotal = Math.round(grandtotal);
        var roundoffamt = 0.00;
        roundoffamt = Number(totalbeforeround) - Number(grandtotal);
        $("#roundOffAmtId").val(parseFloat(roundoffamt).toFixed(2));

    }
    $("#grandtotalId").val(parseFloat(grandtotal).toFixed(2));
    $("#discountAmtId").val(parseFloat(totaldiscamt).toFixed(2));
    $("#totalTaxId").val(parseFloat(totaltaxamt).toFixed(2));

}


function deleteRowId(deleterowid) {
    $("#hdnPurchaseReturnItemId").val(deleterowid);
    $('#purchasereturnitemdeletemodal').modal('show');
}

function deletePurchaseReturnItem() {
    var delitemid = $("#hdnPurchaseReturnItemId").val();
    $("tr#" + delitemid + "").remove();
    calculateGrandTotal();

}




function purchaseReturnSaveOrUpdate() {
    var purchasereturnid = 0;
    var uid = $("#hiduserid").val();
    var vendorId = $("#selectedvendorId").val();
    var returntypeidheader = $("#selectedreturnreasonId").val();
    //alert("returntypeidheader"+returntypeidheader);
    var billNo = $("#billNo").val();
    var billDate = $("#billDate").val();
    var returncreatedate = $("#purchaseReturnDate").val();
    var closePurchaseReturn = $("#closepurchasereturn").val();
    var storeid = $("#hidstoreid").val();
    var remark = $("#returnRemarks").val();
    var edp = 0;
    console.log("vendorId=" + vendorId);
    console.log("billNo=" + billNo);
    console.log("billDate=" + billDate);
    console.log("returncreatedate=" + returncreatedate);

    var purchaseReturn1 = {};
    var purchaseReturn = [];
    var d = new Date();

    var totQty = 0.00;
    var totitemtot = 0.00;
    var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
    var poid = 0;
    var shouldpositive = 0;
    var tableDatalen = $('#purchaseReturnItemTable > tbody  > tr').length;
    $('#purchaseReturnItemTable > tbody  > tr').each(function() {
        var trid = this.id;
        var qty = $("#purchaseditmreturnqty_" + trid).val();
        var rate = $("#purchaseditmreturnrate_" + trid).val();
        var returnid = $("#purchaseditmreturnreason_" + trid).val();
        //alert("returnid"+returnid);
        if (qty < 0 || rate < 0 || qty == '' || rate == '' || returnid == 0 || returnid == '' || qty == 0 || rate == 0) {
            shouldpositive = 1;
        }
    });
    if (shouldpositive == 1) {
        //alert("1");
        $("#positiveitemquantityorrate").modal('show');
    } else if (returncreatedate < billDate) {
        //alert("2");
        $("#billdateGreaterdmodal").modal('show');
    } else if (tableDatalen == 0) {
        //alert("3");
        $("#tabledatadmodal").modal('show');
    } else if (billNo == 0) {
        //alert("4");
        $("#billnodmodal").modal('show');
    } else if (closePurchaseReturn == 'Y') {
        //alert("5");
        document.getElementById('msgspace').innerHTML = "Data Is Not Updatable.";
        $("#msgmodal").modal('show');
    } else if (returntypeidheader == 0 || returntypeidheader == '') {
        document.getElementById('msgspace').innerHTML = "Please Select Return Type.";
        $("#msgmodal").modal('show');
    } else {
        $("#purchaseReturnSaveOrUpdate").addClass('disabled');
        $('#purchaseReturnItemTable > tbody  > tr').each(function() {
            console.log("tr id=" + this.id);
            var that = this;
            var trid = this.id;
            var invqty = $("#purchaseditminvqtytd_" + trid).html();
            var qty = $("#purchaseditmreturnqty_" + trid).val();
            totQty = totQty + parseFloat(qty);
            var invrate = $("#purchaseditminvratetd_" + trid).html();
            var rate = $("#purchaseditmreturnrate_" + trid).val();
            var unitid = $("#purchaseditmunitid_" + trid).val();

            var itmid = $("#purchasereturnitemid_" + trid).val();


            poid = $("#purchaseditmpoidtd_" + trid).html();
            var itmcode = $("#purchaseditmcode_" + trid).val();
            var taxperc = $("#purchaseditmtaxid_" + trid).val();
            var taxamt = $("#purchaseditmtaxamttd_" + trid).html();
            var discperc = $("#purchaseditmdisc_" + trid).val();
            //alert("discperc"+discperc);
            if (discperc == '') {
                discperc = 0.0;
            }
            var discamt = $("#purchaseditmdiscamttd_" + trid).html();
            //alert("discamt"+discamt);
            var itemamt = $("#purchaseditmitmamttd_" + trid).html();
            totitemtot = totitemtot + parseFloat(itemamt);
            var itemtotal = $("#purchaseditmtottd_" + trid).html();
            var shippingcharge = $("#purchaseditmspchrg_" + trid).val();
            var istaxexclusive = $("#purchaseditmistaxexclusive_" + trid).val();
            var returntypeid = $("#purchaseditmreturnreason_" + trid).val();
            var stockinid = $("#stockinid_" + trid).val();
            /*edp = $("#purchaseditmedptd_" + trid).html();
             if(edp == undefined){
            	 edp = 0;
             }*/

            if ($("#purchasereturnid_" + trid).val() != 0) {
                purchasereturnid = $("#purchasereturnid_" + trid).val();
            }

            if ($("#purchasereturnid_" + trid).val() == 0) {


                //alert("add");
                var returnitem = {};
                var inventoryStockIn = {};
                var inventoryItems = {};
                var returnTypes = {};


                returnitem.itemQuantity = qty;
                returnitem.itemInvoiceQuantity = invqty;
                returnitem.itemInvoiceRate = invrate;
                returnitem.itemRate = rate;
                returnitem.itemTotalPrice = itemamt;
                returnitem.taxRate = taxperc;
                returnitem.taxAmount = taxamt;
                returnitem.itemGrossAmount = itemtotal;
                returnitem.poId = poid;
                returnitem.unitId = unitid;
                returnitem.storeId = storeid;
                returnitem.createdDate = returncreatedate;
                returnitem.createdBy = uid;
                returnitem.isTaxExclusive = istaxexclusive;
                returnitem.disPer = discperc;
                returnitem.disAmt = discamt;
                returnitem.billNo = billNo;
                returnitem.remarks = remark;
                returnTypes.id = returntypeid;
                returnitem.returnTypes = returnTypes;

                inventoryStockIn.id = stockinid;
                returnitem.inventoryStockIn = inventoryStockIn;

                inventoryItems.id = trid;
                inventoryItems.code = itmcode;
                returnitem.inventoryItems = inventoryItems;
                purchaseReturn.push(returnitem);
            } else {
                //alert("update");
                var returnitem = {};
                var inventoryStockIn = {};
                var inventoryItems = {};
                var returnTypes = {};
                var metricUnit = {};


                returnitem.itemQuantity = qty;
                returnitem.itemInvoiceQuantity = invqty;
                returnitem.itemInvoiceRate = invrate;
                returnitem.itemRate = rate;
                returnitem.itemTotalPrice = itemamt;
                returnitem.taxRate = taxperc;
                returnitem.taxAmount = taxamt;
                returnitem.itemGrossAmount = itemtotal;
                returnitem.poId = poid;
                returnitem.unitId = unitid;
                returnitem.storeId = storeid;
                returnitem.updatedBy = uid;
                returnitem.updatedDate = returncreatedate;
                returnitem.isTaxExclusive = istaxexclusive;
                returnitem.disPer = discperc;
                returnitem.disAmt = discamt;
                returnitem.billNo = billNo;
                returnitem.remarks = remark;

                returnTypes.id = returntypeid;
                returnitem.returnTypes = returnTypes;

                inventoryStockIn.id = stockinid;
                returnitem.inventoryStockIn = inventoryStockIn;

                inventoryItems.id = trid;
                inventoryItems.code = itmcode;
                returnitem.inventoryItems = inventoryItems;

                metricUnit.id = unitid;
                returnitem.metricUnit = metricUnit;

                purchaseReturn.push(returnitem);

            }
        });
        purchaseReturn1.inventoryReturnItems = purchaseReturn;
        purchaseReturn1.id = purchasereturnid;
        purchaseReturn1.userId = uid;
        purchaseReturn1.storeId = storeid;
        purchaseReturn1.vendorId = vendorId;
        purchaseReturn1.billNo = billNo;
        purchaseReturn1.billDate = billDate;
        purchaseReturn1.itemTotal = totitemtot;
        purchaseReturn1.edpId = edp;
        purchaseReturn1.approved = closePurchaseReturn;
        purchaseReturn1.deleteFlag = "N";
        //purchaseReturn1.createdBy=uid;
        purchaseReturn1.returnTypeId = returntypeidheader;

        var discountpercentage = $("#discountId").val();
        if (discountpercentage == '') {
            discountpercentage = 0;
        }
        purchaseReturn1.disPer = parseFloat(discountpercentage);
        purchaseReturn1.disAmt = $("#discountAmtId").val();
        purchaseReturn1.taxAmt = $("#totalTaxId").val();
        var mislechargeamt = $("#misChargeId").val();
        if (mislechargeamt == '') {
            mislechargeamt = 0
        };
        purchaseReturn1.miscCharge = parseFloat(mislechargeamt);
        purchaseReturn1.netAmt = $("#grandtotalId").val();
        purchaseReturn1.roundOffAmt = $("#roundOffAmtId").val();
        //	console.log("invStockin1="+JSON.stringify(purchaseReturn1));
        $.ajax({
            url: BASE_URL + "/purchasereturn/createorupdatepurchasereturn.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(purchaseReturn1),
            success: function(response) {
                //called when successful
                if (response == 'success') {
                    console.log("returnid=" + purchasereturnid);
                    if (purchasereturnid == 0) {
                        location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
                    } else {
                        rowClicked(purchasereturnid);
                    }
                }
            },
            error: function(e) {}
        });
    }
}




/*function closeStatusUpdated() {//off
	var purchasereturnid = $("#createdpurchasereturnid").val();
	console.log("purchasereturnid=" + purchasereturnid);
	if (purchasereturnid != 0 && purchasereturnid != undefined) {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + '/purchasereturn/purchasereturnclosed.htm?purchaseReturnId=' + purchasereturnid, function(response) {
			if (response == 'success') {
				$("#purchasereturnstatus_" + purchasereturnid).html('Y');
				rowClicked(purchasereturnid);
			}
		}, null);
	}
}*/



function closeStatusUpdated() {
    var purchasereturnid = $("#createdpurchasereturnid").val();
    console.log("purchasereturnid=" + purchasereturnid);

    var misccharge = $("#misChargeId").val();
    var discountamt = $("#discountAmtId").val();
    var taxamt = $("#totalTaxId").val();
    var netamt = $("#grandtotalId").val();
    var roundamt = $("#roundOffAmtId").val();
    var totgrossamt = 0.00;
    var billdata = $("#billDate").val();

    if (purchasereturnid != 0 && purchasereturnid != undefined) {

        $('#purchaseReturnItemTable > tbody  > tr').each(function() {
            console.log("tr id=" + this.id);
            var that = this;
            var trid = this.id;
            var qty = $("#purchaseditmreturnqty_" + trid).val();
            var rate = $("#purchaseditmreturnrate_" + trid).val();
            var taxperc = $("#purchaseditmtaxid_" + trid).val();
            var istaxexclusive = $("#purchaseditmistaxexclusive_" + trid).val();
            var itemamt = Number(qty) * Number(rate);

            if (istaxexclusive == 'Y') {
                totgrossamt = Number(totgrossamt) + Number(itemamt);
            } else {
                var basePrice = Number(itemamt) / (1 + (Number(taxperc) / 100)); //this basePrice is without tax amt
                totgrossamt = Number(totgrossamt) + Number(basePrice);
            }

        });

        var actualgrossamt = totgrossamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
        var inventoryReturn = {};
        inventoryReturn.totGrossAmt = actualgrossamt;
        inventoryReturn.miscCharge = misccharge;
        inventoryReturn.disAmt = discountamt;
        inventoryReturn.roundOffAmt = roundamt;
        inventoryReturn.netAmt = netamt;
        inventoryReturn.taxAmt = taxamt;
        inventoryReturn.billDate = billdata;

        /*
         * for account
         */
        /*if (is_Acc == 'Y') {

            if (parseInt($('#duties_ledger_id1').val()) > 0 && parseInt($('#round_ledger_id1').val()) > 0 && parseInt($('#purchase_ledger_id1').val()) > 0 && parseInt($('#discount_ledger_id1').val()) > 0 && parseInt($('#creditor_ledger_id1').val()) > 0 && parseInt($('#misslenious_ledger_id1').val()) > 0) {
                inventoryReturn.duties_ledger_id = parseInt($('#duties_ledger_id1').val());
                inventoryReturn.round_ledger_id = parseInt($('#round_ledger_id1').val());
                inventoryReturn.purchase_ledger_id = parseInt($('#purchase_ledger_id1').val());
                inventoryReturn.discount_ledger_id = parseInt($('#discount_ledger_id1').val());
                inventoryReturn.credior_ledger_id = parseInt($('#creditor_ledger_id1').val());
                inventoryReturn.missllenous_ledger_id = parseInt($('#misslenious_ledger_id1').val());

            } else {
                $("#stockInSave").removeClass('disabled');
                document.getElementById('msgspace').innerHTML = "Ledger Missing ";
                $("#msgmodal").modal('show');
                return;
            }

        }*/

        $.ajax({
            url: BASE_URL + "/purchasereturn/purchasereturnclosed.htm?purchaseReturnId=" + purchasereturnid,
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(inventoryReturn),
            success: function(response) {
                //called when successful
                if (response == 'success') {
                    $("#purchasereturnstatus_" + purchasereturnid).html('Y');
                    rowClicked(purchasereturnid);
                }
            },
            error: function(e) {}
        });


    }
}




function getSelectedStatus(value) {
    var usrId = $("#hiduserid").val();
    var userId = document.getElementById('purchaseReturnUserId');
    if (value == 'Y') {
        userId.value = usrId;
    } else {
        userId.value = '';
    }
}



function PurchaseReturnDeleteConfirmation() { // added new
    $("#stockindeletemodal").modal('show');
}

function stockInDelete() { // added new
    var purchaseReturnId = $("#createdpurchasereturnid").val();
    var tableDatalen = $('#purchaseReturnItemTable > tbody  > tr').length;
    if (purchaseReturnId == 0) {
        document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
        $("#msgmodal").modal('show');
    } else if (tableDatalen == 0) {
        document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
        $("#msgmodal").modal('show');
    } else {
        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjax(BASE_URL + '/purchasereturn/deletepurchasereturnbyid/' + purchaseReturnId + '.htm', function(response) {
            if (response == 'success') {
                location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
            } else {
                document.getElementById('msgspace').innerHTML = "Problem Occured.Data Is Not Deleted.";
                $("#msgmodal").modal('show');
            }
        }, null);
    }

}


function calculateDiscount(){}
