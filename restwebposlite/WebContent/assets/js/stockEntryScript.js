/**
 * 
 */

var currentfgstockid="";
function rowClicked(fgstockinid) {
	$("#itemdetails").html("");
	$("#waitimage").removeClass('hide');
	var data="";
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/itemstockin/getsimplefgstockinbystoreidandid.htm?stockinId=" + fgstockinid, function(response) {
		try {
			console.log(response);
			$("#itemdetails").html("");
			$("#waitimage").addClass('hide');
			 data = JSON.parse(response);
			$("#clickedfgid").val(data.id);
			for ( var i = 0; i < data.fgStockInItemsChilds.length; i++) {
				var itemdetail = data.fgStockInItemsChilds[i];
				var createdrowline = "";
				var generatedHtml = "";
				var seventhtdline = "";
				var sixthtdline = "";
				var starttrline = "";
				var starttrline = "<tr id=" + itemdetail.menuItem.id + ">";
				var firsttdline = "<td id=itmid_"+itemdetail.menuItem.id+" style='text-align: center;'>" + itemdetail.menuItem.id + "</td>";
				var secondtdline = "<td style='text-align: center;'>" + itemdetail.menuItem.name  + "</td>";
				var thirdtdline = "<td style='text-align: center;' id=itmunit_"+itemdetail.menuItem.id+">" + itemdetail.menuItem.unit + "</td>";
				var fourthtdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+itemdetail.menuItem.id+">" + parseFloat(itemdetail.menuItem.price).toFixed(2) + "</td>";
				
				var seventhline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.itemRate).toFixed(2)+"' />" + "</td>";
				
				
				var sixthline="";
				if(data.approved == 'Y'){
					 sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.stockInQuantity+"' readonly='true'/></td>";
					
				}
				else{
				    sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")'  onkeydown='numcheck(event);' value='"+itemdetail.stockInQuantity+"'/></td>";
					
				}
				
			    var fifthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.menuItem.id+"'><span id='itmCurrentstock_" + itemdetail.menuItem.id + "' style='display:none'></span><button type='button' style='font-weight: bold; width: 100%;' class='btn btn-success' id='getCurrentQtyBtn_"+itemdetail.menuItem.id+"' onclick='getCurrentQty("+itemdetail.menuItem.id+")'>GET CURRENT QTY</button></td>";
				var actionline = "";
	            if(data.approved == 'Y'){
	            	actionline = "<td></td>";
				}
				else{
					 actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.menuItem.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
		               
				}
	            var discountLine ="";
	            if(data.approved == 'Y'){
	                discountLine= "<td style='text-align: center;'><input type='text' size='4' readonly='true' id='itmdiscount_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.discPer+"'/></td>";
	            }else{
	            	discountLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmdiscount_" + itemdetail.menuItem.id + "' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.discPer+"'/></td>";
	   	         }
	            
	            
	            var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + itemdetail.menuItem.id + "'>"+itemdetail.totalPrice+"</span></td>";
	            
	            var vatLine="";
	            if(data.approved == 'Y'){
	            	vatLine= "<td style='text-align: center;'><input type='text' size='4' readonly='true'  id='itmVat_"+itemdetail.menuItem.id+"' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.vatRate+"'/></td>";
	            }else{
	            	vatLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmVat_"+itemdetail.menuItem.id+"' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.vatRate+"'/></td>";
	            }
	            
	            var serviceTaxLine="";
	            if(data.approved == 'Y'){
	            	serviceTaxLine= "<td style='text-align: center;'><input type='text' size='4' readonly='true'  id='itmServiceTax_"+itemdetail.menuItem.id+"' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.serviceTaxRate+"'/></td>";
	            }else{
	            	serviceTaxLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmServiceTax_"+itemdetail.menuItem.id+"' onkeyup='setItemTotalPrice("+itemdetail.menuItem.id+")' onkeydown='numcheck(event);' value='"+itemdetail.serviceTaxRate+"'/></td>";
	            }
	            
	            var discAmttdline= "<td style='text-align: center;display:none;' id=itmDiscAmt_"+itemdetail.menuItem.id+">"+itemdetail.discAmt+"</td>";
	            var vatAmttdline= "<td style='text-align: center;display:none;' id=itmVatAmt_"+itemdetail.menuItem.id+">"+itemdetail.vatAmt+"</td>";
	            var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id=itmServiceTaxAmt_"+itemdetail.menuItem.id+">"+itemdetail.serviceTaxAmt+"</td>";
	            var itemTotaltdline= "<td style='text-align: center;display:none;' id=itmTot_"+itemdetail.menuItem.id+">"+itemdetail.itemTotal+"</td>";
				var endtrline = "</tr>";
				
				createdrowline = starttrline + firsttdline + secondtdline + fifthline + thirdtdline + fourthtdline + seventhline +sixthline+discountLine + vatLine + serviceTaxLine + totalLine + discAmttdline + vatAmttdline + serviceTaxAmttdline + itemTotaltdline+actionline+ endtrline;
				$("#itemdetails").append(createdrowline);
				
				$("#grandtotalId").val(data.totalPrice);
				$("#discountAmtId").val(data.discAmt);
				$("#totalVatTaxId").val(data.vatAmt);
				$("#totalServiceTaxId").val(data.serviceTaxAmt);
				$("#totalItemAmt").val(data.itemTotal);
				$("#discountId").val(data.discPer);
				$("#roundOffAmtId").val(data.roundOffAmt);
				$("#clickedFgInvNo").val(data.billNo);
				$("#clickedFgInvDate").val(data.billDate);
				$("#clickedFgSelectedVendorId").val(data.vendorId);
				
				
				
			}
			if (data.approved == 'Y') {
				$("#select1").val('Y');
				$("#appvId").val(data.createdBy);
				$('#select1').prop('disabled', true);
				$("#fgstockinapprovedbuttion").addClass('disabled');
				setButton();
			} else {
				$("#select1").val('N');
				$("#appvId").val('');
				$('#select1').removeAttr('disabled');
				$("#fgstockinapprovedbuttion").removeClass('disabled');
				setButton();
			}

		} catch (e) {
			//alert(e);
		}

	}, null);
	
	
}

function formatDate() {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

function newStockIn(){
	var selecteddate = $("#selecteddate").val();
	$("#clickedfgid").val(0);
	$("#itemdetails").html("");
	$("#select1").val('N');
	$("#appvId").val('');
	$('#select1').removeAttr('disabled');
	$("#fgstockinapprovedbuttion").removeClass('disabled');
	$("#grandtotalId").val('');
	$("#discountAmtId").val('');
	$("#totalVatTaxId").val('');
	$("#totalServiceTaxId").val('');
	$("#totalItemAmt").val('');
	$("#discountId").val('');
	$("#roundOffAmtId").val('');
	$("#clickedFgInvNo").val('');
	/*alert(todaydate);*/
	/*var todaydate = formatDate() ;*/
	$("#clickedFgInvDate").val(selecteddate);
	$("#clickedFgSelectedVendorId").val('');
	$("#clickedFgInvNo").val('');
	setButton();
	
}

function approveCall() {
	var clickedfgid = $("#clickedfgid").val();
	if (clickedfgid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var creationdate = $("#selecteddate").val();
		var createdBy = $("#appvId").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/itemstockin/approvedFGStockin.htm?storeId=' + storeID + '&fgstockinid=' + clickedfgid + '&approveBy=' + createdBy, function(response) {
				if (response == 'success') {
					/*rowClicked(clickedfgid);*/
					location.href = BASE_URL+'/itemstockin/loaditemstockin.htm';
				}
			}, null);
		}else{
			document.getElementById('msgspace').innerHTML = "Please Select Y To Approve.";
			$("#msgmodal").modal('show');
		}
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
function viewPurchaseReturnPage(){
	location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
	
}
function viewPurchaseOrder() {
	location.href = BASE_URL + '/inventorynew/loadinventory.htm';
	}


function getSubCategory(catid){
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
	
}


function getItems(subcatid){
  var approveValue = $("#select1").val();
  var itemNewStocklength= $('#itemNewStock > tbody  > tr').length;
     if(itemNewStocklength==0){
    	 $("#waitimage").removeClass('hide'); 
     }
	
	var itemdetail="";
	var  itemdetails = "";
	var flag=false;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/itemstockin/menuitemdata/" + subcatid + ".htm",
			function(response) {
				console.log(response);
				$("#waitimage").addClass('hide');
				setButton();
			    itemdetails = JSON.parse(response);
				if(itemdetails!=null){
					   if(itemNewStocklength>0 && approveValue!='Y'){
						   for ( var i = 0; i < itemdetails.length; i++) {
									      itemdetail = itemdetails[i];
									      flag=false;
								          $("#itemNewStock tbody tr").each(function(index) { 
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
															var thirdtdline = "<td style='text-align: center;' id=itmunit_"+itemdetail.id+">" + itemdetail.unit + "</td>";
															var fourthtdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+itemdetail.id+">" + parseFloat(itemdetail.price).toFixed(2) + "</td>";
															
															var seventhline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.purchasePrice).toFixed(2)+"' />" + "</td>";
															
															var sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' /></td>";
															var fifthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.id+"'><span id='itmCurrentstock_" + itemdetail.id + "' style='display:none'></span><button type='button' style='font-weight: bold; width: 100%;' class='btn btn-success' id='getCurrentQtyBtn_"+itemdetail.id+"' onclick='getCurrentQty("+itemdetail.id+")'>GET CURRENT QTY</button></td>";
															
															var discountLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmdiscount_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' /></td>";
															var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + itemdetail.id + "'></span></td>";
															var vatLine="<td style='text-align: center;'><input type='text' size='4'  id='itmVat_"+itemdetail.id+"' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+itemdetail.vat+"'/></td>";
															var serviceTaxLine= "<td style='text-align: center;'><input type='text' size='4'   id='itmServiceTax_"+itemdetail.id+"' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+itemdetail.serviceTax+"'/></td>";
															var discAmttdline= "<td style='text-align: center;display:none;' id=itmDiscAmt_"+itemdetail.id+">"+"</td>";
															var vatAmttdline= "<td style='text-align: center;display:none;' id=itmVatAmt_"+itemdetail.id+">"+"</td>";
															var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id=itmServiceTaxAmt_"+itemdetail.id+">"+"</td>";
															var itemTotaltdline= "<td style='text-align: center;display:none;' id=itmTot_"+itemdetail.id+">"+"</td>";
															
															
															var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
										                    var endtrline = "</tr>";
															createdrowline = starttrline + firsttdline + secondtdline + fifthline+ thirdtdline + fourthtdline + seventhline  + sixthline + discountLine + vatLine + serviceTaxLine + totalLine + discAmttdline + vatAmttdline + serviceTaxAmttdline + itemTotaltdline+ actionline + endtrline;
															$("#itemdetails").append(createdrowline);
												
											              }else{
											            	  $("#itemAlreadyExistModal").modal('show');
											              };
								               
								            }
				                        }else if(itemNewStocklength==0 && approveValue!='Y'){
				                        	$("#itemdetails").html("");
				                        	for ( var i = 0; i < itemdetails.length; i++) {
												       itemdetail = itemdetails[i];
							                            var createdrowline = "";
														var generatedHtml = "";
														var seventhtdline = "";
														var sixthtdline = "";
														var starttrline = "";
														/*var starttrline = "<tr id=" + itemdetail.id + ">";
														var firsttdline = "<td id=itmid_"+itemdetail.id+" style='text-align: center;'>" + itemdetail.id + "</td>";
														var secondtdline = "<td style='text-align: center;'>" + itemdetail.name  + "</td>";
														var thirdtdline = "<td style='text-align: center;'>" + itemdetail.unit + "</td>";
														var fourthtdline = "<td style='text-align: center;'>" + parseFloat(itemdetail.price).toFixed(2) + "</td>";
														var sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.id + "' onkeydown='numcheck(event);' /></td>";
														var fifthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.id+"'><span id='itmCurrentstock_" + itemdetail.id + "' style='display:none'></span><button type='button' style='font-weight: bold; width: 100%;' class='btn btn-success' id='getCurrentQtyBtn_"+itemdetail.id+"' onclick='getCurrentQty("+itemdetail.id+")'>GET CURRENT QTY</button></td>";
														var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
									                    var endtrline = "</tr>";
														createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthline+sixthline+actionline+ endtrline;*/
														var starttrline = "<tr id=" + itemdetail.id + ">";
														var firsttdline = "<td id=itmid_"+itemdetail.id+" style='text-align: center;'>" + itemdetail.id + "</td>";
														var secondtdline = "<td style='text-align: center;'>" + itemdetail.name  + "</td>";
														var thirdtdline = "<td style='text-align: center;' id=itmunit_"+itemdetail.id+">" + itemdetail.unit + "</td>";
														var fourthtdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+itemdetail.id+">" + parseFloat(itemdetail.price).toFixed(2) + "</td>";
														var seventhline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+parseFloat(itemdetail.purchasePrice).toFixed(2)+"' />" + "</td>";
														var sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")'  onkeydown='numcheck(event);' /></td>";
														var fifthline= "<td style='text-align: center;' id='currentstocktd_"+itemdetail.id+"'><span id='itmCurrentstock_" + itemdetail.id + "' style='display:none'></span><button type='button' style='font-weight: bold; width: 100%;' class='btn btn-success' id='getCurrentQtyBtn_"+itemdetail.id+"' onclick='getCurrentQty("+itemdetail.id+")'>GET CURRENT QTY</button></td>";
														
														var discountLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmdiscount_" + itemdetail.id + "' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' /></td>";
														var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + itemdetail.id + "'></span></td>";
														var vatLine="<td style='text-align: center;'><input type='text' size='4'  id='itmVat_"+itemdetail.id+"' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+itemdetail.vat+"'/></td>";
														var serviceTaxLine= "<td style='text-align: center;'><input type='text' size='4'   id='itmServiceTax_"+itemdetail.id+"' onkeyup='setItemTotalPrice("+itemdetail.id+")' onkeydown='numcheck(event);' value='"+itemdetail.serviceTax+"'/></td>";
														var discAmttdline= "<td style='text-align: center;display:none;' id=itmDiscAmt_"+itemdetail.id+">"+"</td>";
														var vatAmttdline= "<td style='text-align: center;display:none;' id=itmVatAmt_"+itemdetail.id+">"+"</td>";
														var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id=itmServiceTaxAmt_"+itemdetail.id+">"+"</td>";
														var itemTotaltdline= "<td style='text-align: center;display:none;' id=itmTot_"+itemdetail.id+">"+"</td>";
														
														
														var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + itemdetail.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
									                    var endtrline = "</tr>";
														createdrowline = starttrline + firsttdline + secondtdline + fifthline + thirdtdline + fourthtdline + seventhline  + sixthline + discountLine + vatLine + serviceTaxLine + totalLine + discAmttdline + vatAmttdline + serviceTaxAmttdline + itemTotaltdline +  actionline + endtrline;
														
														
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
	calculateGrandTotal();
	
}


function setButton(){ 
	var stockinid = $("#clickedfgid").val();
	var status = $("#select1").val();
	var activebutton="";
	if(stockinid == '0' && status != 'Y'){
		activebutton ="<a href='javascript:itemStockInSave()' id='stockInSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";
        }
	else{
		if(status != 'Y'){
		    activebutton ="<a href='javascript:itemStockInSave()' id='stockInSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";
		    activebutton +="&nbsp;&nbsp;<a href='javascript:itemStockInDeleteConfirmation()' id='stockInDelete' class='btn btn-danger' style='background: #78B626; margin-top: 3px;'>Delete</a>";
		}
      }
	document.getElementById("operationbtnspan").innerHTML = activebutton;
	}


function itemStockInSave(){
	var edpid = 0;
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var tableDatalen = $('#itemNewStock > tbody  > tr').length;
	var fgStockIn = {};
	var fgStockInItemsChild = [];
	var fgstockinid = $("#clickedfgid").val();
	var itemNewStock="";
	var emptyStockQty = [];
	var invoiceNo = $("#clickedFgInvNo").val();
	var invoiceDate =$("#clickedFgInvDate").val();
	var invoiceVendorId = $("#clickedFgSelectedVendorId").val();
	
	var grandTotal =$("#grandtotalId").val();
	var roundOffAmt = $("#roundOffAmtId").val();
	var totVatAmt = $("#totalVatTaxId").val();
	var totServiceTaxAmt = $("#totalServiceTaxId").val();
	var totDiscAmt = $("#discountAmtId").val();
	var discPrercentage= $("#discountId").val();
	var itemTotPrice = $("#totalItemAmt").val();
	if(discPrercentage == ""){discPrercentage = 0;}
	if(totDiscAmt== ""){totDiscAmt = 0;}
	
	
	if (tableDatalen == 0) {
		document.getElementById('msgspace').innerHTML = "Please Select Data For Add Or Update.";
		$("#msgmodal").modal('show');
	} else{	
		$("#itemNewStock tbody tr").each(function(index) {
			var trID = this.id;
			itemNewStock = $("#itmnewstock_" + trID).val();
			if(itemNewStock == ""){
				emptyStockQty.push(trID);
			}
			
		});
		if(emptyStockQty.length==0){
		$("#itemNewStock tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
		    var itmoldstock = 0;
		    var fgStockInItemChild = {};
			var menuitem = {};
			fgStockInItemChild.storeId = storeID;
			fgStockInItemChild.edProdAmount = 0;
			fgStockInItemChild.stockInQuantity = $("#itmnewstock_" + trid).val();
			fgStockInItemChild.oldStockInQuantity = itmoldstock;
			fgStockInItemChild.createdDate = selecteddate;
			fgStockInItemChild.createdBy = invCrtBy;
			fgStockInItemChild.fgStatus = 'Y';
			fgStockInItemChild.unit = $("#itmUnit_" + trid).html();
			fgStockInItemChild.itemRate = $("#itmPurchaseRate_" + trid).val();
			fgStockInItemChild.itemTotal = $("#itmTot_" + trid).html();
			
			var itmdisc = $("#itmdiscount_" + trid).val();
			var itmdiscamt =$("#itmDiscAmt_" + trid).html();	
			  if(itmdisc == ""){itmdisc=0;}
			  if(itmdiscamt == ""){itmdiscamt=0;}
			fgStockInItemChild.discPer = itmdisc;
			fgStockInItemChild.discAmt = itmdiscamt;
			fgStockInItemChild.vatRate = $("#itmVat_" + trid).val();	
			fgStockInItemChild.vatAmt = $("#itmVatAmt_" + trid).html();	
			fgStockInItemChild.serviceTaxRate = $("#itmServiceTax_" + trid).val(); 	
			fgStockInItemChild.serviceTaxAmt = $("#itmServiceTaxAmt_" + trid).html();	
			fgStockInItemChild.totalPrice = $("#itmTotalAmt_" + trid).html();	
			
			menuitem.id = trid;
			fgStockInItemChild.menuItem = menuitem;
			fgStockInItemsChild.push(fgStockInItemChild);
		
			
			
		
	});
	fgStockIn.fgStockInItemsChilds = fgStockInItemsChild;
	if (fgstockinid != 0) {
		fgStockIn.id=fgstockinid;
	} 
	fgStockIn.edpId = edpid;
	fgStockIn.createdBy = invCrtBy;
	fgStockIn.createdDate = selecteddate;
	fgStockIn.currentItems = 1;
	fgStockIn.deleteFlag = "N";
	fgStockIn.estimatedItems = 1;
	fgStockIn.storeId = storeID;
	fgStockIn.billNo=invoiceNo;
	fgStockIn.billDate=invoiceDate;
	fgStockIn.vendorId=invoiceVendorId;
	fgStockIn.itemTotal = itemTotPrice;
	fgStockIn.discPer = discPrercentage;	
	fgStockIn.discAmt = totDiscAmt;
	fgStockIn.vatAmt = totVatAmt;
	fgStockIn.serviceTaxAmt=totServiceTaxAmt;
	fgStockIn.roundOffAmt=roundOffAmt;
	fgStockIn.totalPrice=grandTotal;
	console.log(JSON.stringify(fgStockIn));
	$.ajax({
		url : BASE_URL + "/itemstockin/createnewfgstockin.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(fgStockIn),
		success : function(response) {
		       if(response!=0){
				   currentfgstockid =fgstockinid;
				   $("#fgsuccessdmodal").modal('show');
				 }else{
					 $("#fgerrormodal").modal('show'); 
				 }
		},
		error : function(e) {
		}
	});
	}else{
		document.getElementById('msgspace').innerHTML = "Please Insert New Stock For All Items.";
		$("#msgmodal").modal('show');
	}	
  }	
}
		
function dataInsertPositiveStatus(){
	 if (currentfgstockid == 0) {
		    currentfgstockid="";
			location.href = BASE_URL+'/itemstockin/loaditemstockin.htm';
		} else {
			rowClicked(currentfgstockid);
		}
	 	
}


function dataInsertNegetiveStatus(){
	currentfgstockid="";
	location.href = BASE_URL+'/itemstockin/loaditemstockin.htm';
	
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




function additemtoStocinTable(ui){
  var approveValue = $("#select1").val();
  if(approveValue!='Y'){
	var flag=false;
	var itemNewStocklength= $('#itemNewStock > tbody  > tr').length;
    if(itemNewStocklength==0){
    	 $("#waitimage").removeClass('hide'); 
    	 $("#itemdetails").html("");
    }else{
   	   $("#itemNewStock tbody tr").each(function(index) {
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
	var fourthtdline = "<td style='text-align: center;display:none;' id=itmSalePrice_"+ui.item.items.id+">" + parseFloat(ui.item.items.price).toFixed(2) + "</td>";
	var purchaseratetdline = "<td style='text-align: center;'><input type='text' size='4'  id='itmPurchaseRate_" + ui.item.items.id + "' onkeyup='setItemTotalPrice("+ui.item.items.id+")' onkeydown='numcheck(event);' value='"+parseFloat(ui.item.items.purchasePrice).toFixed(2)+"' />" + "</td>";
	var sixthline = "<td style='text-align: center;'><input type='text' size='4'  id='itmnewstock_" + ui.item.items.id + "'  onkeyup='setItemTotalPrice("+ui.item.items.id+")'  onkeydown='numcheck(event);' /></td>";
	var fifthline= "<td style='text-align: center;' id='currentstocktd_"+ui.item.items.id+"'><span id='itmCurrentstock_" + ui.item.items.id + "' style='display:none'></span><button type='button' style='font-weight: bold; width: 100%;' class='btn btn-success' id='getCurrentQtyBtn_"+ui.item.items.id+"' onclick='getCurrentQty("+ui.item.items.id+")'>GET CURRENT QTY</button></td>";
	
	var discountLine= "<td style='text-align: center;'><input type='text' size='4'  id='itmdiscount_" + ui.item.items.id + "' onkeyup='setItemTotalPrice("+ui.item.items.id+")'  onkeydown='numcheck(event);' /></td>";
	var totalLine= "<td style='text-align: center;'><span id='itmTotalAmt_" + ui.item.items.id + "'></span></td>";
	var vatLine="<td style='text-align: center;'><input type='text' size='4'  id='itmVat_"+ui.item.items.id+"' onkeyup='setItemTotalPrice("+ui.item.items.id+")' onkeydown='numcheck(event);' value='"+ui.item.items.vat+"'/></td>";
	var serviceTaxLine="<td style='text-align: center;'><input type='text' size='4'   id='itmServiceTax_"+ui.item.items.id+"' onkeyup='setItemTotalPrice("+ui.item.items.id+")' onkeydown='numcheck(event);' value='"+ui.item.items.serviceTax+"'/></td>";
	var discAmttdline= "<td style='text-align: center;display:none;' id='itmDiscAmt_"+ui.item.items.id+"'>"+"</td>";
	var vatAmttdline= "<td style='text-align: center;display:none;' id='itmVatAmt_"+ui.item.items.id+"'>"+"</td>";
	var serviceTaxAmttdline= "<td style='text-align: center;display:none;' id='itmServiceTaxAmt_"+ui.item.items.id+"'>"+"</td>";
	var itemTotaltdline= "<td style='text-align: center;display:none;' id='itmTot_"+ui.item.items.id+"'>"+"</td>";
	
	var actionline = "<td style='text-align: center;'><a href='javascript:deleteRowId(" + ui.item.items.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
    var endtrline = "</tr>";
	createdrowline = starttrline + firsttdline + secondtdline + fifthline+ thirdtdline + fourthtdline + purchaseratetdline +sixthline+discountLine + vatLine + serviceTaxLine + totalLine +discAmttdline+vatAmttdline+serviceTaxAmttdline+itemTotaltdline+actionline+ endtrline;
	$("#waitimage").addClass('hide');
	$("#itemdetails").append(createdrowline);
	//$("#itmName").val(" ");
	}
	//setButton();
  }else{
	 // $("#itmName").val(" ");
	  $("#itemCanNotAddModal").modal('show');
	  
  }

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

function getCurrentQty(itemid){
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
	
	
}

function itemStockInDeleteConfirmation(){ 
	$("#simplestockindeletemodal").modal('show');
}

function itemStockInDelete(){ 
	var selectedstockinid = $("#clickedfgid").val();
	var tableDatalen = $('#itemNewStock > tbody  > tr').length;
	if (selectedstockinid == 0) {
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	} else if(tableDatalen == 0){
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/itemstockin/deletesimplestockinbyid/' + selectedstockinid+'.htm' , function(response) {
		if (response == 'success') {
			location.href=BASE_URL+'/itemstockin/loaditemstockin.htm';
		}
		else{
			document.getElementById('msgspace').innerHTML = "Problem Occured.Data Is Not Deleted.";
			$("#msgmodal").modal('show');
		}
	}, null);
	}

}

	
function setItemTotalPrice(itemid){
	var purchaseRate = $("#itmPurchaseRate_"+itemid).val();
	var stockInQty = $("#itmnewstock_"+itemid).val();
	var discPercentage = $("#itmdiscount_"+itemid).val();
	var vat = $("#itmVat_"+itemid).val();
	var servicetax = $("#itmServiceTax_"+itemid).val();
	
	
	if(purchaseRate == ""){purchaseRate = 0.0;}
	if(stockInQty == ""){stockInQty = 0.0;}
	if(discPercentage == ""){discPercentage = 0.0;}
	if(vat == ""){vat = 0.0;}
	if(servicetax == ""){servicetax = 0.0;}
	

	var totalItemPrice = Number(purchaseRate) * Number(stockInQty);
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
