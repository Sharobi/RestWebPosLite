/**
 * 
 */
var currentfgstockreturnid="";
function rowClicked(fgstockreturnid) {
	$("#itemdetails").html("");
	$("#waitimage").removeClass('hide');
	var data="";
	var returnsTypes = returnTypes;
	var options = "";
    var option = "<option value='" + 0 + "'>Select Return Type</option>";
    for (var i = 0; i < returnsTypes.length; i++) {
        options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
    }
    var alloptions = option + options;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/itemreturn/getfgstockreturnbyid.htm?stockReturnId=" + fgstockreturnid, function(response) {
		try {
			console.log(response);
			$("#itemdetails").html("");
			$("#waitimage").addClass('hide');
			 data = JSON.parse(response);
			$("#clickedfgreturnid").val(data.id);
			$("#clickedfgreturninvno").val(data.billNo);
			$("#clickedfgreturninvdate").val(data.billDate);
			$("#clickedfgreturnvendorid").val(data.vendorId);
			$("#selectedreturnreasonId").val(data.returnTypeId);
			$("#returnRemarks").val(data.fgReturnItems[0].remarks);
			
			$("#discountId").val(data.disPer);
			$("#discountAmtId").val(data.disAmt);
			$("#totalVatTaxId").val(data.vatAmt);
			$("#totalServiceTaxId").val(data.serviceTaxAmt);
			$("#totalItemAmt").val(data.itemTotal);
			$("#grandtotalId").val(data.totalPrice);
			$("#roundOffAmtId").val(data.roundOffAmt);
			$("#roundOffAmtId").val(data.roundOffAmt);
			$("#fgStockInNo").val(data.fgReturnItems[0].fgStockInId);
			$("#stockincallbtn").addClass('disabled');
			$("#fgStockInNo").prop('disabled', true);
			
			
			for ( var i = 0; i < data.fgReturnItems.length; i++) {
				var itemdetail = data.fgReturnItems[i];
				var createdrowline = "";
				var generatedHtml = "";
				var starttrline = "<tr id=" + itemdetail.menuItem.id + ">";
				var idtdline = "<td id=itmid_"+itemdetail.menuItem.id+" style='text-align: center;'>" + itemdetail.menuItem.id + "</td>";
				var nametdline = "<td style='text-align: center;'>" + itemdetail.menuItem.name  + "</td>";
				var unittdline = "<td style='text-align: center;' id=itmunit_"+itemdetail.menuItem.id+">" + itemdetail.menuItem.unit + "</td>";
				var saleratetdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+itemdetail.menuItem.id+">" + parseFloat(itemdetail.menuItem.price).toFixed(2) + "</td>";
				 var purchaseratetdline ="";
				if (data.approved == 'Y') {
				   purchaseratetdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.itemRate).toFixed(2)+"' disabled />" + "</td>";
				}
				else{
					purchaseratetdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.itemRate).toFixed(2)+"' />" + "</td>";
					
				}
				var stockinqtyline = "<td style='text-align: center;'  id='itmnewstock_" + itemdetail.menuItem.id + "'>"+itemdetail.itemInvoiceQuantity+"</td>";	
				var returnstkqtyline="";
				if (data.approved == 'Y') {
				    returnstkqtyline = "<td style='text-align: center;'><input type='text' size='4'  id='itmreturnstock_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPriceByReturnQty("+itemdetail.menuItem.id+")'  onkeydown='numcheck(event);' value='"+itemdetail.itemQuantity+"' disabled/></td>";
				}else{
				    returnstkqtyline = "<td style='text-align: center;'><input type='text' size='4'  id='itmreturnstock_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPriceByReturnQty("+itemdetail.menuItem.id+")'  onkeydown='numcheck(event);' value='"+itemdetail.itemQuantity+"' /></td>";
					
				}
				
				var actionline = "";
				if (data.approved == 'Y') {
					actionline = "<td style='text-align: center;'></td>";
				     
				}else{
					 actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.menuItem.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
				       
				}
				
			    var returnresonline = "<td style='text-align: center;' id='currentstocktd_"+itemdetail.menuItem.id+"'> <select id='itmreturnreason_" + itemdetail.menuItem.id+ "' name='selectedreturnreason'>" + alloptions + "</select></td></td>";
	            var discountLine= "<td style='text-align: center; display:none;'><input type='text' size='4'  id='itmdiscount_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.disPer+"' /></td>";
	            var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + itemdetail.menuItem.id + "'>"+itemdetail.totalPrice+"</span></td>";
	            var vatLine= "<td style='text-align: center;display:none;' id=itmVat_"+itemdetail.menuItem.id+">"+itemdetail.vatRate+"</td>";
	            var serviceTaxLine= "<td style='text-align: center;display:none;' id=itmServiceTax_"+itemdetail.menuItem.id+">"+itemdetail.serviceTaxRate+"</td>";
	            var discAmttdline= "<td style='text-align: center;display:none;' id=itmDiscAmt_"+itemdetail.menuItem.id+">"+itemdetail.disAmt+"</td>";
	            var vatAmttdline= "<td style='text-align: center;display:none;' id=itmVatAmt_"+itemdetail.menuItem.id+">"+itemdetail.vatAmt+"</td>";
	            var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id=itmServiceTaxAmt_"+itemdetail.menuItem.id+">"+itemdetail.serviceTaxAmt+"</td>";
	            var itemTotaltdline= "<td style='text-align: center;display:none;' id=itmTot_"+itemdetail.menuItem.id+">"+itemdetail.itemTotalPrice+"</td>";
				var itemOldPurchaseRateLine = "<td style='text-align: center;display:none;' id=itmOldPurchaseRate_"+itemdetail.menuItem.id+">"+itemdetail.itemInvoiceRate+"</td>";
				/*var remarks = "<td style='text-align: center;'><input type='text' size='4'  id='itmReturnRemarks_" + itemdetail.menuItem.id + "'  value='"+itemdetail.remarks+"'/>"+ "</td>";*/	
				var currentstockline = "<td style='text-align:center;' id='itmcurrentwstock_" + itemdetail.menuItem.id + "'>" +itemdetail.curStock +"</td>";	
				var previousReturnQty = "<td style='text-align: center;display:none;' id=itmPrevRetQty_"+itemdetail.menuItem.id+">"+itemdetail.itemQuantity+"</td>";
				
				var endtrline = "</tr>";
	            
				createdrowline = starttrline + idtdline + nametdline + unittdline + saleratetdline + purchaseratetdline + stockinqtyline  + currentstockline+returnstkqtyline+discountLine+ totalLine +  returnresonline  + itemOldPurchaseRateLine +vatLine + serviceTaxLine + discAmttdline + vatAmttdline + serviceTaxAmttdline + itemTotaltdline+actionline +previousReturnQty+ endtrline;
				$("#itemdetails").append(createdrowline);
			    $("#itmreturnreason_"+itemdetail.menuItem.id).val(itemdetail.returnTypes.id);
				
			}
			if (data.approved == 'Y') {
				$("#select1").val('Y');
				$("#appvId").val(data.createdBy);
				$('#select1').prop('disabled', true);
				$("#fgstockreturnapprovedbuttion").addClass('disabled');
				setButton();
			} else {
				$("#select1").val('N');
				$("#appvId").val('');
				$('#select1').removeAttr('disabled');
				$("#fgstockreturnapprovedbuttion").removeClass('disabled');
				setButton();
			}

		} catch (e) {
			//alert(e);
		}

	}, null);
	
	
}



function newStockIn(){
	$("#clickedfgreturnid").val(0);
	$("#itemdetails").html("");
	$("#select1").val('N');
	$("#appvId").val('');
	$('#select1').removeAttr('disabled');
	$("#fgstockreturnapprovedbuttion").removeClass('disabled');
	
	$("#grandtotalId").val('');
	$("#discountAmtId").val('');
	$("#totalVatTaxId").val('');
	$("#totalServiceTaxId").val('');
	$("#totalItemAmt").val('');
	$("#discountId").val('');
	$("#roundOffAmtId").val('');
	$("#clickedfgreturninvno").val('');
	$("#clickedfgreturninvdate").val('');
	$("#clickedfgreturnvendorid").val('');
	$("#selectedreturnreasonId").val('0');
	$("#fgStockInNo").val('');
	$("#stockincallbtn").removeClass('disabled');
	$("#fgStockInNo").prop('disabled', false);
	$("#returnRemarks").val('');
	setButton();
	
}

function approveCall() {
	var clickedfgreturnid = $("#clickedfgreturnid").val();
	var vendorId =  $("#clickedfgreturnvendorid").val();
	if (clickedfgreturnid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var creationdate = $("#selecteddate").val();
		var createdBy = $("#appvId").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/itemreturn/approvedFGStockReturn.htm?storeId=' + storeID + '&fgstockreturnid=' + clickedfgreturnid + '&approveBy=' + createdBy + '&vendorId=' + vendorId, function(response) {
				if (response == 'success') {
					location.href = BASE_URL+'/itemreturn/loaditemreturn.htm';
				}
			}, null);
		}else{
			document.getElementById('msgspace').innerHTML = "Please Select Y To Approve.";
			$("#msgmodal").modal('show');
		}
	}
}



/*function viewStockIn() {
	var selectedpoid = $("#selectedpoid").val();
	console.log("selectedpoid=" + selectedpoid);
	console.log("$('#poItemTable > tbody  > tr').=" + $('#poItemTable > tbody  > tr').length);
	var tableDatalen = $('#poItemTable > tbody  > tr').length;
	if (selectedpoid == 0 && tableDatalen > 0) {
		$("#displayStockInPage").modal('show');
	} else {
		location.href = BASE_URL + '/stockinnew/loadstockin.htm';
	}
}*/

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


/*function getSubCategory(catid){
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/getsubcategorylistbycategory/" + catid + ".htm",
					function(response) {
						var responseObj = [];
						responseObj = JSON.parse(response);
						var optionline = "<option value='' disabled selected>"+"Select Sub Category" + "</option><option value='" + 0 + "'>" + "Select All" + "</option>";
						for ( var i = 0; i < responseObj.length; i++) {
							var id = responseObj[i].id;
							var name = responseObj[i].menuCategoryName;
							optionline += "<option value='" + id + "'>" + name
									+ "</option>";
						}
						document.getElementById('selectedmenusubcategoryName').innerHTML = optionline;
					}, null);
	
}*/


function getItems(subcatid){
  var approveValue = $("#select1").val();
  var itemReturnTbllength= $('#itemReturnTbl > tbody  > tr').length;
     if(itemReturnTbllength==0){
    	 $("#waitimage").removeClass('hide'); 
     }
	
	var itemdetail="";
	var  itemdetails = "";
	var flag=false;
	
	    var returnsTypes = returnTypes;
	    var options = "";
	    var option = "<option value='" + 0 + "'>Select Return Type</option>";
	    for (var i = 0; i < returnsTypes.length; i++) {
	        options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
	    }
	    var alloptions = option + options;
	
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/itemstockin/menuitemdata/" + subcatid + ".htm",
			function(response) {
				console.log(response);
				$("#waitimage").addClass('hide');
				setButton();
			    itemdetails = JSON.parse(response);
				if(itemdetails!=null){
					   if(itemReturnTbllength>0 && approveValue!='Y'){
						   for ( var i = 0; i < itemdetails.length; i++) {
									      itemdetail = itemdetails[i];
									      flag=false;
								          $("#itemReturnTbl tbody tr").each(function(index) { 
												  var trid = this.id;
												  if(trid ==itemdetail.id  ){
													  flag=true;
													 }
												  
											      });
												  if(flag!=true){
												            var createdrowline = "";
															var generatedHtml = "";
															var seventhtdline = "";
															var sixthtdline = "";
															var starttrline = "";
															var starttrline = "<tr id=" + itemdetail.id + ">";
															var firsttdline = "<td id=itmid_"+itemdetail.id+" style='text-align: center;'>" + itemdetail.id + "</td>";
															var secondtdline = "<td style='text-align: center;'>" + itemdetail.name  + "</td>";
															var thirdtdline = "<td style='text-align: center;'>" + itemdetail.unit + "</td>";
															var fourthtdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewreturnprice_" + itemdetail.id + "' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.price).toFixed(2)+"' /></td>";
															var fifthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.id + "' onkeydown='numcheck(event);' /></td>";
															var sixthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.id+"'> <select id='itmreturnreason_" + itemdetail.id+ "' name='selectedreturnreason'>" + alloptions + "</select></td>";
															var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
										                    var endtrline = "</tr>";
															createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthline+sixthline+actionline+ endtrline;
															$("#itemdetails").append(createdrowline);
												
											              }else{
											            	  $("#itemAlreadyExistModal").modal('show');
											              };
								               
								            }
				                        }else if(itemReturnTbllength==0 && approveValue!='Y'){
				                        	$("#itemdetails").html("");
				                        	for ( var i = 0; i < itemdetails.length; i++) {
												       itemdetail = itemdetails[i];
							                            var createdrowline = "";
														var generatedHtml = "";
														var seventhtdline = "";
														var sixthtdline = "";
														var starttrline = "";
														var starttrline = "<tr id=" + itemdetail.id + ">";
														var firsttdline = "<td id=itmid_"+itemdetail.id+" style='text-align: center;'>" + itemdetail.id + "</td>";
														var secondtdline = "<td style='text-align: center;'>" + itemdetail.name  + "</td>";
														var thirdtdline = "<td style='text-align: center;'>" + itemdetail.unit + "</td>";
														var fourthtdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewreturnprice_" + itemdetail.id + "' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.price).toFixed(2)+"' /></td>";
														var fifthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.id + "' onkeydown='numcheck(event);' /></td>";
														var sixthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.id+"'><select id='itmreturnreason_" + itemdetail.id+ "' name='selectedreturnreason'>" + alloptions + "</select> </td>";
														var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
									                    var endtrline = "</tr>";
														createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthline+sixthline+actionline+ endtrline;
														$("#itemdetails").append(createdrowline);
															
													  }
				                        }else{
				                        	$("#itemCanNotAddModal").modal('show');
				                        }
				  
				    }
				else{
					$("#itemNotFoundModal").modal('show');
					setButton();
					
				}
				

			}, null);
	
}

function deleteRowId(deleterowid) {
	$("#hdnItemId").val(deleterowid);
	$('#itemStockInDeleteModal').modal('show');
}

function deleteStockinItem() {
	var delitemid = $("#hdnItemId").val();
	$("tr#" + delitemid + "").remove();
	
}


function setButton(){ 
	var stockinid = $("#clickedfgreturnid").val();
	var status = $("#select1").val();
	var activebutton="";
	if(stockinid == '0' && status != 'Y'){
		activebutton ="<a href='javascript:itemStockReturnSave()' id='stockReturnSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";
        }
	else{
		if(status != 'Y'){
		    activebutton ="<a href='javascript:itemStockReturnSave()' id='stockReturnSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";
		    activebutton +="&nbsp;&nbsp;<a href='javascript:itemStockReturnDeleteConfirmation()' id='stockreturnDelete' class='btn btn-danger' style='background: #78B626; margin-top: 3px;'>Delete</a>";
		}
      }
	document.getElementById("operationbtnspan").innerHTML = activebutton;
	}


function itemStockReturnSave(){
	var edpid = 0;
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var tableDatalen = $('#itemReturnTbl > tbody  > tr').length;
	var fgStockReturn = {};
	var fgStockReturnItemsChild = [];
	var fgstockreturnid = $("#clickedfgreturnid").val();
	var fgstockreturninvno = $("#clickedfgreturninvno").val();
	var fgstockreturninvdate = $("#clickedfgreturninvdate").val();
	var fgstockreturnvendorid = $("#clickedfgreturnvendorid").val();
	var fgstockinno = $("#fgStockInNo").val();
	
	var grandTotal =$("#grandtotalId").val();
	var roundOffAmt = $("#roundOffAmtId").val();
	var totVatAmt = $("#totalVatTaxId").val();
	var totServiceTaxAmt = $("#totalServiceTaxId").val();
	var totDiscAmt = $("#discountAmtId").val();
	var discPrercentage= $("#discountId").val();
	var itemTotPrice = $("#totalItemAmt").val();
	var returnType = $("#selectedreturnreasonId").val();
	var remarks = $("#returnRemarks").val();
	if(discPrercentage == ""){discPrercentage = 0;}
	if(totDiscAmt== ""){totDiscAmt = 0;}
	
	var itemReturnQty="";
	var returnReasonType=""; 
	var emptyStockReturnQty = [];
	var emptyStockReturnReason = [];
	
	if (tableDatalen == 0) {
		document.getElementById('msgspace').innerHTML = "Please Select Data For Add Or Update.";
		$("#msgmodal").modal('show');
	} else{	
		$("#itemReturnTbl tbody tr").each(function(index) {
			var trID = this.id;
			itemReturnQty = $("#itmreturnstock_" + trID).val();
			if(itemReturnQty == ""){
				emptyStockReturnQty.push(trID);
			}
			if(itemReturnQty != ""){
				returnReasonType= $("#itmreturnreason_" + trID).val();
				if(returnReasonType == 0){
				 emptyStockReturnReason.push(trID);
				}
			}
			
			
		});
		if(emptyStockReturnReason.length==0){
			
			fgStockReturn.edpId = edpid;
			fgStockReturn.createdBy = invCrtBy;
			fgStockReturn.createdDate = selecteddate;
			fgStockReturn.currentItems = 1;
			fgStockReturn.deleteFlag = "N";
			fgStockReturn.estimatedItems = 1;
			fgStockReturn.storeId = storeID;
			fgStockReturn.billNo=fgstockreturninvno;
			fgStockReturn.billDate=fgstockreturninvdate;
			fgStockReturn.vendorId=fgstockreturnvendorid;
			fgStockReturn.itemTotal = itemTotPrice;
			fgStockReturn.disPer = discPrercentage;	
			fgStockReturn.disAmt = totDiscAmt;
			fgStockReturn.vatAmt = totVatAmt;
			fgStockReturn.serviceTaxAmt=totServiceTaxAmt;
			fgStockReturn.roundOffAmt=roundOffAmt;
			fgStockReturn.totalPrice=grandTotal;
			fgStockReturn.returnTypeId=returnType;
			
			
			
		$("#itemReturnTbl tbody tr").each(function(index) {
			var trid = this.id;
			var itemReturnQty = $("#itmreturnstock_" + trid).val();
			if(itemReturnQty!=""){
		
				    $row = $(this);
				    var itmoldstock = 0;
				    var fgStockReturnItemChild = {};
					var menuitem = {};
					var fgStockIn = {};
					var returnTypes = {};
					fgStockReturnItemChild.storeId = storeID;
					fgStockReturnItemChild.edProdAmount = 0;
					fgStockReturnItemChild.itemInvoiceQuantity = $("#itmnewstock_" + trid).html();
					fgStockReturnItemChild.itemQuantity = $("#itmreturnstock_" + trid).val();
					fgStockReturnItemChild.createdDate = selecteddate;
					fgStockReturnItemChild.createdBy = invCrtBy;
					fgStockReturnItemChild.fgStatus = 'Y';
					fgStockReturnItemChild.unit = $("#itmUnit_" + trid).html();
					fgStockReturnItemChild.itemRate = $("#itmPurchaseRate_" + trid).val();
					fgStockReturnItemChild.itemInvoiceRate = $("#itmOldPurchaseRate_" + trid).html();
					fgStockReturnItemChild.itemTotalPrice = $("#itmTot_" + trid).html();
					
					var itmdisc = $("#itmdiscount_" + trid).val();
					var itmdiscamt =$("#itmDiscAmt_" + trid).html();	
					  if(itmdisc == ""){itmdisc=0;}
					  if(itmdiscamt == ""){itmdiscamt=0;}
					fgStockReturnItemChild.disPer = itmdisc;	
					fgStockReturnItemChild.disAmt = itmdiscamt;	
					fgStockReturnItemChild.vatRate = $("#itmVat_" + trid).html();	
					fgStockReturnItemChild.vatAmt = $("#itmVatAmt_" + trid).html();	
					fgStockReturnItemChild.serviceTaxRate = $("#itmServiceTax_" + trid).html(); 	
					fgStockReturnItemChild.serviceTaxAmt = $("#itmServiceTaxAmt_" + trid).html();	
					fgStockReturnItemChild.totalPrice = $("#itmTotalAmt_" + trid).html();	
					fgStockReturnItemChild.remarks = remarks;	
					menuitem.id = trid;
					fgStockReturnItemChild.menuItem = menuitem;
					fgStockIn.id = fgstockinno
					fgStockReturnItemChild.fgStockIn = fgStockIn;
					returnTypes.id =  $("#itmreturnreason_" + trid).val();
					fgStockReturnItemChild.returnTypes =returnTypes;
					fgStockReturnItemsChild.push(fgStockReturnItemChild);
		
		}
			
		
	});
	fgStockReturn.fgReturnItems = fgStockReturnItemsChild;
	if (fgstockreturnid != 0) {
		fgStockReturn.id=fgstockreturnid;
	} 
	console.log(JSON.stringify(fgStockReturn));
	if(fgStockReturnItemsChild.length>0){
	
		$.ajax({
			url : BASE_URL + "/itemreturn/createorupdatefgstockout.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(fgStockReturn),
			success : function(response) {
			       if(response!=0){
					   currentfgstockreturnid =fgstockreturnid;
					   $("#fgsuccessdmodal").modal('show');
					 }else{
						 $("#fgerrormodal").modal('show'); 
					 }
			},
			error : function(e) {
			}
		});
	}else{
		document.getElementById('msgspace').innerHTML = "Please Insert Return Quantity";
		$("#msgmodal").modal('show');
	}
	}else{
		document.getElementById('msgspace').innerHTML = "Please Insert Return Reasons.";
		$("#msgmodal").modal('show');
	}	
  }	
}
		
function dataInsertPositiveStatus(){
	 /*if (currentfgstockreturnid == 0) {*/
		    /*currentfgstockreturnid="";*/
			location.href = BASE_URL+'/itemreturn/loaditemreturn.htm';
		/*} else {
			rowClicked(currentfgstockreturnid);
		}
	 	*/
}


function dataInsertNegetiveStatus(){
	currentfgstockreturnid="";
	location.href = BASE_URL+'/itemreturn/loaditemreturn.htm';
	
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




/*function additemtoStocinTable(ui){
  var approveValue = $("#select1").val();
  var returnsTypes = returnTypes;
  var options = "";
  var option = "<option value='" + 0 + "'>Select Return Type</option>";
  for (var i = 0; i < returnsTypes.length; i++) {
      options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
  }
  var alloptions = option + options;
  if(approveValue!='Y'){
	var flag=false;
	var itemReturnTbllength= $('#itemReturnTbl > tbody  > tr').length;
    if(itemReturnTbllength==0){
    	 $("#waitimage").removeClass('hide'); 
    	 $("#itemdetails").html("");
    }else{
   	   $("#itemReturnTbl tbody tr").each(function(index) {
		var trid = this.id;
		if(trid==ui.item.items.id){
			flag=true;
		}
	  });
	}
	if(flag==true){
		$("#itmName").val(" ");
		$("#itemAlreadyExistModal").modal('show');
	}
	else{
	var createdrowline = "";
	var generatedHtml = "";
	var seventhtdline = "";
	var sixthtdline = "";
	var starttrline = "";
	console.log(JSON.stringify(ui));
    var starttrline = "<tr id=" + ui.item.items.id + ">";
	var firsttdline = "<td id=itmid_"+ui.item.items.id+" style='text-align: center;'>" + ui.item.items.id + "</td>";
	var secondtdline = "<td style='text-align: center;'>" + ui.item.items.name  + "</td>";
	var thirdtdline = "<td style='text-align: center;'>" + ui.item.items.unit + "</td>";
	var fourthtdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewreturnprice_" + ui.item.items.id + "' onkeydown='numcheck(event);' value='"+parseFloat( ui.item.items.price).toFixed(2)+"' /></td>";
	var fifthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + ui.item.items.id + "' onkeydown='numcheck(event);' /></td>";
	var sixthline= "<td style='text-align: center;' id='currentstocktd_"+ui.item.items.id+"'><select id='itmreturnreason_" + ui.item.items.id+ "' name='selectedreturnreason'>" + alloptions + "</select> </td>";
	var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + ui.item.items.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
    var endtrline = "</tr>";
	createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthline+sixthline+actionline+ endtrline;
	$("#waitimage").addClass('hide');
	$("#itemdetails").append(createdrowline);
	//$("#itmName").val(" ");
	}
	//setButton();
  }else{
	 // $("#itmName").val(" ");
	  $("#itemCanNotAddModal").modal('show');
	  
  }

}*/


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

/*function getCurrentQty(itemid){
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/itemstockin/getfgcurrentstock/" + itemid + ".htm",
					function(response) {
						//alert(response);
						var responseObj = [];
						responseObj = JSON.parse(response);
						 $("#itmCurrentstock_"+itemid).text(responseObj[0].curStock);
						 $("#getCurrentQtyBtn_"+itemid).hide();
						 $("#itmCurrentstock_"+itemid).show();
						
					}, null);
	
	
}*/

function itemStockReturnDeleteConfirmation(){ 
	$("#simplestockindeletemodal").modal('show');
}

function itemStockReturnDelete(){ 
	var selectedstockreturnid = $("#clickedfgreturnid").val();
	var tableDatalen = $('#itemReturnTbl > tbody  > tr').length;
	if (selectedstockreturnid == 0) {
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	} else if(tableDatalen == 0){
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/itemreturn/deletestockreturnbyid/' + selectedstockreturnid+'.htm' , function(response) {
		if (response == 'success') {
			location.href=BASE_URL+'/itemreturn/loaditemreturn.htm';
		}
		else{
			document.getElementById('msgspace').innerHTML = "Problem Occured.Data Is Not Deleted.";
			$("#msgmodal").modal('show');
		}
	}, null);
	}

}

	

function selectReason(reason) {
	
  $('#itemReturnTbl tr').each(function() {
        var trid = $(this).find("td:eq(0)").html();
        $("#itmreturnreason_" + trid).val(reason);
    });
}



function bringStockinDetails(){
	var fgStockinId =  $("#fgStockInNo").val();
	if(fgStockinId == ""){
		document.getElementById('msgspace').innerHTML = "Please Insert Stockin Id.";
		$("#msgmodal").modal('show');
	}else{
		/*$("#fgStockInNo").val('');*/
		$("#itemdetails").html("");
		$("#waitimage").removeClass('hide');
		
		var returnsTypes = returnTypes;
		var options = "";
	    var option = "<option value='" + 0 + "'>Select Return Type</option>";
	    for (var i = 0; i < returnsTypes.length; i++) {
	        options += "<option value='" + returnsTypes[i].id + "'>" + returnsTypes[i].remark + "</option>";
	    }
	    var alloptions = option + options;
	    
		var data="";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/itemstockin/getsimplefgstockinbystoreidandid.htm?stockinId=" + fgStockinId, function(response) {
			try {
				console.log(response);
				
				if(response!=""){
					$("#itemdetails").html("");
					$("#waitimage").addClass('hide');
					 data = JSON.parse(response);
					if(data.approved == 'N'){
						document.getElementById('msgspace').innerHTML = "Please approve the stockin before return.";
						$("#msgmodal").modal('show');
					}else{
						
						$("#clickedfgreturninvno").val(data.billNo);
						$("#clickedfgreturninvdate").val(data.billDate);
						$("#clickedfgreturnvendorid").val(data.vendorId);
						$("#selectedreturnreasonId").val(data.returnTypeId);
						$("#discountId").val(data.discPer);
						$("#discountAmtId").val(data.discAmt);
					for ( var i = 0; i < data.fgStockInItemsChilds.length; i++) {
						var itemdetail = data.fgStockInItemsChilds[i];
						if(itemdetail.prevretQty<itemdetail.stockInQuantity){
							var createdrowline = "";
							var generatedHtml = "";
							var starttrline = "<tr id=" + itemdetail.menuItem.id + ">";
							var idtdline = "<td id=itmid_"+itemdetail.menuItem.id+" style='text-align: center;'>" + itemdetail.menuItem.id + "</td>";
							var nametdline = "<td style='text-align: center;'>" + itemdetail.menuItem.name  + "</td>";
							var unittdline = "<td style='text-align: center;' id=itmunit_"+itemdetail.menuItem.id+">" + itemdetail.menuItem.unit + "</td>";
							var saleratetdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+itemdetail.menuItem.id+">" + parseFloat(itemdetail.menuItem.price).toFixed(2) + "</td>";
							var purchaseratetdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.itemRate).toFixed(2)+"' />" + "</td>";
							var stockinqtyline = "<td style='text-align: center;'  id='itmnewstock_" + itemdetail.menuItem.id + "'>"+itemdetail.stockInQuantity+"</td>";	
							var returnstkqtyline = "<td style='text-align: center;'><input type='text' size='4'  id='itmreturnstock_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPriceByReturnQty("+itemdetail.menuItem.id+")'  onkeydown='numcheck(event);' /></td>";
							var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.menuItem.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
					        var returnresonline = "<td style='text-align: center;' id='currentstocktd_"+itemdetail.menuItem.id+"'> <select id='itmreturnreason_" + itemdetail.menuItem.id+ "' name='selectedreturnreason'>" + alloptions + "</select></td></td>";
				            var discountLine= "<td style='text-align: center; display:none;'><input type='text' size='4'  id='itmdiscount_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.discPer+"' /></td>";
				            var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + itemdetail.menuItem.id + "'>"+"</span></td>";
				            var vatLine= "<td style='text-align: center;display:none;' id=itmVat_"+itemdetail.menuItem.id+">"+itemdetail.vatRate+"</td>";
				            var serviceTaxLine= "<td style='text-align: center;display:none;' id=itmServiceTax_"+itemdetail.menuItem.id+">"+itemdetail.serviceTaxRate+"</td>";
				            var discAmttdline= "<td style='text-align: center;display:none;' id=itmDiscAmt_"+itemdetail.menuItem.id+">"+"</td>";
				            var vatAmttdline= "<td style='text-align: center;display:none;' id=itmVatAmt_"+itemdetail.menuItem.id+">"+"</td>";
				            var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id=itmServiceTaxAmt_"+itemdetail.menuItem.id+">"+"</td>";
				            var itemTotaltdline= "<td style='text-align: center;display:none;' id=itmTot_"+itemdetail.menuItem.id+">"+itemdetail.itemTotal+"</td>";
							var itemOldPurchaseRateLine = "<td style='text-align: center;display:none;' id=itmOldPurchaseRate_"+itemdetail.menuItem.id+">"+itemdetail.itemRate+"</td>";
							/*var remarks = "<td style='text-align: center;'><input type='text' size='4'  id='itmReturnRemarks_" + itemdetail.menuItem.id + "' />" + "</td>";*/	
							var currentstockline = "<td style='text-align:center;' id='itmcurrentwstock_" + itemdetail.menuItem.id + "'>" +itemdetail.curStock +"</td>";	
							var previousReturnQty = "<td style='text-align: center;display:none;' id=itmPrevRetQty_"+itemdetail.menuItem.id+">"+itemdetail.prevretQty+"</td>";
							
							var endtrline = "</tr>";
							
							createdrowline = starttrline + idtdline + nametdline + unittdline + saleratetdline + purchaseratetdline + stockinqtyline + currentstockline +returnstkqtyline+discountLine+ totalLine +  returnresonline  + itemOldPurchaseRateLine +vatLine + serviceTaxLine + discAmttdline + vatAmttdline + serviceTaxAmttdline + itemTotaltdline +actionline+ previousReturnQty + endtrline;
							$("#itemdetails").append(createdrowline);
						}
							
					}
				}
			 }/*else if(JSON.parse(response).fgStockInItemsChilds.length==0){
				    document.getElementById('msgspace').innerHTML = "All Items are Already Returned";
					$("#msgmodal").modal('show');
			 }*/else{
				 $("#waitimage").addClass('hide');
				 $("#itemNotFoundModal").modal('show'); 
			 }	

			} catch (e) {
				//alert(e);
			}

		}, null);
		
		
	}
	
}

function setItemTotalPrice(itemid){
	var purchaseRate = $("#itmPurchaseRate_"+itemid).val();
	var stockReturnQty = $("#itmreturnstock_"+itemid).val();
	var discPercentage = $("#itmdiscount_"+itemid).val();
	var vat = $("#itmVat_"+itemid).html();
	var servicetax = $("#itmServiceTax_"+itemid).html();
	
	
	if(purchaseRate == ""){purchaseRate = 0.0;}
	if(stockReturnQty == ""){stockInQty = 0.0;}
	if(discPercentage == ""){discPercentage = 0.0;}
	if(vat == ""){vat = 0.0;}
	if(servicetax == ""){servicetax = 0.0;}
	
	
	var totalItemPrice = Number(purchaseRate) * Number(stockReturnQty);
	var discAmt = parseFloat((Number(totalItemPrice)*Number(discPercentage))/100).toFixed(2);
	var taxableAmt = parseFloat(Number(totalItemPrice) - Number(discAmt)).toFixed(2);
	var vatAmt = parseFloat((Number(taxableAmt) * Number(vat)) / 100).toFixed(2);
	var serviceTaxAmt =parseFloat((Number(taxableAmt) * Number(servicetax)) / 100).toFixed(2);
	var totalTaxAmt = parseFloat(Number(vatAmt) + Number(serviceTaxAmt)).toFixed(2);
	var itemNetPrice = parseFloat(Number(taxableAmt) + Number(vatAmt) + Number(serviceTaxAmt)).toFixed(2);
	
	
	 $("#itmTotalAmt_"+itemid).html(itemNetPrice);
	 $("#itmDiscAmt_"+itemid).html(discAmt);
	 $("#itmVatAmt_"+itemid).html(vatAmt);
	 $("#itmServiceTaxAmt_"+itemid).html(serviceTaxAmt);
	 $("#itmTot_"+itemid).html( parseFloat(totalItemPrice).toFixed(2));
	
	calculateGrandTotal();
	
	
}	



function setItemTotalPriceByReturnQty(itemid){
	var returnNo = $("#clickedfgreturnid").val();	
	var purchaseRate = $("#itmPurchaseRate_"+itemid).val();
	var stockInQty = $("#itmnewstock_"+itemid).html();
	var currentStockInQty = $("#itmcurrentwstock_"+itemid).html();
	var stockReturnQty = $("#itmreturnstock_"+itemid).val();
	var discPercentage = $("#itmdiscount_"+itemid).val();
	var vat = $("#itmVat_"+itemid).html();
	var servicetax = $("#itmServiceTax_"+itemid).html();
	var prevRetQty= $("#itmPrevRetQty_"+itemid).html();
	
	if(purchaseRate == ""){purchaseRate = 0.0;}
	if(stockReturnQty == ""){stockReturnQty = 0.0;}
	if(discPercentage == ""){discPercentage = 0.0;}
	if(vat == ""){vat = 0.0;}
	if(servicetax == ""){servicetax = 0.0;}
	
	
	if(Number(stockReturnQty)>Number(stockInQty)){
		$("#itmreturnstock_"+itemid).val('');
		stockReturnQty = 0;
		document.getElementById('msgspace').innerHTML = "Please Insert Return Qty Smaller Than StockIn Qty.";
		$("#msgmodal").modal('show');
	}
	
	if(Number(stockReturnQty)>Number(currentStockInQty)){
		$("#itmreturnstock_"+itemid).val('');
		stockReturnQty = 0;
		document.getElementById('msgspace').innerHTML = "Please Insert Return Qty Smaller Than Current Stock.";
		$("#msgmodal").modal('show');
	}
	if(returnNo==0){
		if((Number(stockReturnQty) + Number(prevRetQty)) > Number(stockInQty)){
			$("#itmreturnstock_"+itemid).val('');
			stockReturnQty = 0;
			document.getElementById('msgspace').innerHTML = "Please Insert Return Qty Smaller Than StockIn Qty.Your Previous Retturn Quantity is:"+prevRetQty;
			$("#msgmodal").modal('show');
		}
	}
	
	
		var totalItemPrice = Number(purchaseRate) * Number(stockReturnQty);
		var discAmt = parseFloat((Number(totalItemPrice)*Number(discPercentage))/100).toFixed(2);
		var taxableAmt = parseFloat(Number(totalItemPrice) - Number(discAmt)).toFixed(2);
		var vatAmt = parseFloat((Number(taxableAmt) * Number(vat)) / 100).toFixed(2);
		var serviceTaxAmt =parseFloat((Number(taxableAmt) * Number(servicetax)) / 100).toFixed(2);
		var totalTaxAmt = parseFloat(Number(vatAmt) + Number(serviceTaxAmt)).toFixed(2);
		var itemNetPrice = parseFloat(Number(taxableAmt) + Number(vatAmt) + Number(serviceTaxAmt)).toFixed(2);
		
		
		 $("#itmTotalAmt_"+itemid).html(itemNetPrice);
		 $("#itmDiscAmt_"+itemid).html(discAmt);
		 $("#itmVatAmt_"+itemid).html(vatAmt);
		 $("#itmServiceTaxAmt_"+itemid).html(serviceTaxAmt);
		 $("#itmTot_"+itemid).html( parseFloat(totalItemPrice).toFixed(2));
		
		calculateGrandTotal();
    
	
}	


function calculateGrandTotal(){
	var grandTotal = 0.00;
	var totalVatTaxAmt = 0.00; 
	var totalServiceTaxAmt = 0.00; 
	var totalDiscAmt = 0.00; 
	var totalItemPrice = 0.00;
	$('#itemdetails tr').each(function() {
		var trid = this.id;
		var vtaxamt =$("#itmVatAmt_"+trid).html();
		var staxamt =$("#itmServiceTaxAmt_"+trid).html();
		var discamt =$("#itmDiscAmt_"+trid).html();
		var itmtotal = $("#itmTotalAmt_"+trid).html();
		var itemPrice = $("#itmTot_"+trid).html();
		grandTotal = grandTotal + Number(itmtotal);
		totalVatTaxAmt = totalVatTaxAmt + Number(vtaxamt);
		totalServiceTaxAmt = totalServiceTaxAmt + Number(staxamt);
		totalDiscAmt = totalDiscAmt +Number(discamt);
		totalItemPrice = totalItemPrice + Number(itemPrice);
		
	});
	
	if(roundoffflag == 'Y'){
		var totalbeforeround = grandTotal;
		grandTotal = Math.round(grandTotal);
		var roundoffamt = 0.00;
		    roundoffamt = Number(totalbeforeround) - Number(grandTotal);
		    $("#roundOffAmtId").val(parseFloat(roundoffamt).toFixed(2));
		
	}
	
	
	$("#grandtotalId").val(parseFloat(grandTotal).toFixed(2));
	$("#discountAmtId").val(parseFloat(totalDiscAmt).toFixed(2));
	$("#totalVatTaxId").val(parseFloat(totalVatTaxAmt).toFixed(2));
	$("#totalServiceTaxId").val(parseFloat(totalServiceTaxAmt).toFixed(2));
	$("#totalItemAmt").val(parseFloat(totalItemPrice).toFixed(2));
	
	
}

function calculateDiscount(){ //new added
	var discountperc = $("#discountId").val();
	var isno = isNaN(discountperc);
	if (isno) {
		
	} else {
		if (discountperc < 0) {
			
		} else {
			
			$('#itemdetails tr').each(function() {
				var trid = this.id;
				$("#itmdiscount_"+trid).val(discountperc);
				setItemTotalPrice(trid);
				calculateGrandTotal();
				
			});
		   }	
		}
	
}


function getFgStockInItemsByItemIdDesign(ui){
	//console.log("UI IS");
	//console.log(ui);
	//storeID
	$("#fgstockinmodalbodytablebody>tr").remove();
	var itemId=ui.itemCode;
	var myvar ="";
	var res=getFgStockInItemsByItemId(ui);
	//console.log("RES IN getFgStockInItemsByItemIdDesign(ui)FUNCTION IS: ");
	//console.log(res);
	if(res!=null && res!=""){
		for(var i=0;i<res.length;i++){
			var itemobj=res[i];
			var stockId=itemobj.stockId;
			var invNo=itemobj.invNo;
			var vendorname=itemobj.vndrName;
			var stockDate=itemobj.stockDate;
			stockDate=moment(stockDate).format("YYYY-MM-DD");
			var itemname=itemobj.menuItem.name;
			var unit=itemobj.menuItem.unit;
			var itemRate=itemobj.itemRate;
			var stockInQuantity=itemobj.stockInQuantity;
			var currentStock=itemobj.curStock;
			var prevretQty=itemobj.prevretQty;
			currentStock=currentStock>0?currentStock:"<p>Not Available!</p>";
			$("#fgstockinitemsmodalheading").html("<b>Food Item: "+itemname+"</b>");
		   myvar = myvar+ '<tr>'+
			'									     <td>'+stockId+'</td>'+
			'									     <td>'+invNo+'</td>'+
			'									    <td>'+vendorname+'</td>'+
			'									    <td>'+stockDate+'</td>'+	
			'									    <td>'+unit+'</td>'+
			'									    <td>'+itemRate+'</td>'+
			'									    <td>'+stockInQuantity+'</td>'+
			'									    <td>'+prevretQty+'</td>'+
			'									    <td>'+currentStock+'</td>'+
			'</tr>'		
		}
		
	}else{	
		var itemname="No Data Found!";
		$("#fgstockinitemsmodalheading").html("<b>"+itemname+"</b>");
		myvar="<tr>"
		myvar=myvar+"<td colspan='9'>No Data Found!</td>"
		myvar=myvar+"</tr>"
	}
	
	$("#fgstockinmodalbodytablebody").append(myvar);
	$("#displayfgstockinitemsbyitemidmodal").modal("show");	
	
}

function getFgStockInItemsByItemId(ui){
	var res=null;
	var itemId=ui.item.itemCode;
	//console.log("UI IN getFgStockInItemsByItemId FUNCTION IS");
	//console.log(ui);
	//alert(storeID);
	//alert(itemId);
	url=BASE_URL + "/inventorymgnt/getFgStockInItemsByItemId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeid": storeID,"itemId":itemId},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			//console.log("RES getFgStockInItemsByItemId(ui) FUNCTION  IS:");
			//console.log(res);
		},
		error:function(error){
			console.log("ERROR IN itemReturnScript.js IN getFgStockInItemsByItemId(ui) FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
	
}
