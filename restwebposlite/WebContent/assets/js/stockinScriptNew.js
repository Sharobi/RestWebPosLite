var vatAmt = $('#hidvatTaxVal').val();
var storeid = $("#hidstoreid").val();
var currCode = $("#hidcurrCode").val();
function newStockIn() {
	$('#billNo').prop('disabled', false); //new
	$('#discountId').prop('disabled', false); //new
	$('#billDate').prop('disabled', false);//new
	$('#selectedvendorId').prop('disabled', false); //new
	$("#pocallbtn").removeClass('disabled');//new
	$('#pono').prop('disabled', false); // new
	$("#pono").val('');//new
	$("#itemdetails").html("");
	$("#closeStockin").val('N');
	$("#stockinUserId").val('');
	$('#closeStockin').removeAttr('disabled');
	$("#closestockinButton").removeClass('disabled');
	$("#stockInSave").removeClass('disabled');
	$("#stockInDelete").addClass('disabled'); // new
	$("#misChargeId").prop('disabled', false);
	$("#misChargeId").val(0.00);
	$("#grandtotalId").val(0.00);
	$("#discountAmtId").val(0.00); //new
	$("#totalTaxId").val(0.00); //new
	$("#discountId").val(0.00); //new
	$("#roundOffAmtId").val(0.00); //new
	$("#selectedstockinid").val(0);
	$("#createdstockinid").val(0);
	$("#billNo").val(0);
	$("#selectedvendorId").val(1);
	$("#serachDiv").show();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	$("#billDate").val(creationDate);
	$("#stockinDate").val(creationDate);
	$("#stockincreatedate").val(creationDate);
	//$("#selectedvendorId").removeAttr('disabled');
	setButton();// add new
}
function addNewStockInItem() { // modified
	var discountprcs = $("#discountId").val();
	if( discountprcs == '' || discountprcs == 'undefined') {
		discountprcs = 0.0;
	}
	
	var itemcode = $("#searchCode").val();
	var vendorid= $("#selectedvendorId").val();
	console.log("itemcode=" + itemcode);
	//$("#stockInSave").removeClass('disabled');
	var itempresent = 0;
	$('#stockinItemTable > tbody  > tr').each(function() {
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
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getinventoryitemdetails/" + itemcode + ".htm", function(response) {
			console.log("response=" + response);
			var itemdetail = JSON.parse(response);
			console.log("response.code=" + itemdetail.code);
			var createdrowline = "";
			var discamt = 0;
			//
			var itemamt = Number(itemdetail.quantity)*Number(itemdetail.rate);
			var itemdiscountamt = 0;
			var itemtaxamt = 0;
			var itemtotalamt = 0;
			
			if(itemdetail.isTaxExclusive == 'Y'){
	    	     itemdiscountamt = Number(itemamt) *  Number(discountprcs) / 100;
	    	     itemtaxamt = ((Number(itemamt) - Number(itemdiscountamt)) * Number(itemdetail.taxRate)) / 100;
		         itemtotalamt = Number(itemamt) - Number(itemdiscountamt) + Number(itemtaxamt);					        
	          }
	      else{
	    	  var basePrice =  Number(itemamt) / (1 + (Number(itemdetail.taxRate)/100) );  //this basePrice is without tax amt
	    	  itemdiscountamt = Number(basePrice) *  Number(discountprcs) / 100;  // discount amt on basePrice
	    	  itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt))*Number(itemdetail.taxRate))/100; // tax amt on basePrice
	    	  itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
	    	 }
			//
			
			var starttrline = "<tr id=" + itemdetail.id + ">";
			var firsttdline_id = "<td  id='stockinitmcodetd_" + itemdetail.id + "'><input type='hidden'  id='stockinitmcode_" + itemdetail.id + "' value='" + itemdetail.code + "' />" + itemdetail.code + "</td>";
			var secondtdline_name = "<td id='stockinitmnametd_" + itemdetail.id + "'><input type='hidden'  id='stockinid_" + itemdetail.id + "' value='0' />" + itemdetail.name + "</td>";
			var thirdtdline_qty = "<td id='stockinitmqtytd_" + itemdetail.id + "'><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmqty_" + itemdetail.id + "' value='" + itemdetail.quantity + "' onkeydown='numcheck(event);' /></td>";
			var fourthtdline_unit = "<td id='stockinitmunittd_" + itemdetail.id + "'><input type='hidden'  id='itmunitid_" + itemdetail.id + "' value='" + itemdetail.metricUnitId + "' />" + itemdetail.unit + "</td>";
			var fifthtdline_rate = "<td id='stockinitmratetd_" + itemdetail.id + "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmrate_" + itemdetail.id + "' value='" + itemdetail.rate + "' onkeydown='numcheck(event);'/> </td>";
			var sixthtdline_tax = "<td id='stockinitmtaxtd_" + itemdetail.id + "'><input type='hidden'  id='itmtaxid_" + itemdetail.id + "' value='" + itemdetail.taxRate + "' />" + parseFloat(itemdetail.taxRate).toFixed(2) + "</td>";
			//var taxamt= parseFloat(Number(itemdetail.quantity)*(Number(itemdetail.rate) *Number(itemdetail.taxRate) /100)).toFixed(2);
			var seventhtdline_taxamt = "<td id='itmtaxamttd_" + itemdetail.id + "' style='display:none;'>" + parseFloat(itemtaxamt).toFixed(2) + "</td>";
		    var eighttdline_disc="<td id='stockinitmdisctd_" + itemdetail.id + "'><input type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmdisc_" + itemdetail.id + "' value='"+discountprcs+"' onkeydown='numcheck(event);'/></td>";
			var ninetdline_discamt="<td id='itmdiscamttd_" + itemdetail.id + "'>" + parseFloat(itemdiscountamt).toFixed(2) + "</td>";
			var tentdline_itmamt="<td id='itmitmamttd_" + itemdetail.id + "' style='display:none;'>" + parseFloat(itemamt).toFixed(2) + "</td>";
			if(itemdetail.isTaxExclusive == 'Y'){				
				var eleventdline_total = "<td id='itmtottd_" + itemdetail.id + "'>" + parseFloat(itemtotalamt).toFixed(2) + "</td>"; //modified
			}
			else{				
				var eleventdline_total = "<td id='itmtottd_" + itemdetail.id + "'>" + parseFloat(itemamt).toFixed(2) + "</td>"; //modified
			}
			
			var poid=0;
			var twelvetdline_poid = "<td id='itmpoidtd_" + itemdetail.id + "' style='display:none;'>"+poid+"</td>";
			var thirteentdline_shipping = "<td id='itmshipingtd_" + itemdetail.id + "'style='display:none;'><input type='text' size='4'  id='itmspchrg_" + itemdetail.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
			var fourteentdline_istaxexclusive = "<td id='itmistaxexclusivetd_" + itemdetail.id + "' style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
			var fifteentdline_itemid = "<td id='itmidtd_" + itemdetail.id + "' style='display:none;'>"+itemdetail.id+"</td>";
			var sixteentdline_itemvendorid = "<td id='itmvendoridtd_" + itemdetail.id + "' style='display:none;'><input type='hidden'  id='itmvendorid_" + itemdetail.id + "' value='" + vendorid + "' />" + vendorid + "</td>";
			
			var actionline = "<td><a href='javascript:deleteRowId(" + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
			var endtrline = "</tr>";
			
			createdrowline = starttrline + firsttdline_id + secondtdline_name + thirdtdline_qty + fourthtdline_unit + fifthtdline_rate + sixthtdline_tax + seventhtdline_taxamt + eighttdline_disc + ninetdline_discamt + tentdline_itmamt + eleventdline_total + twelvetdline_poid + thirteentdline_shipping + fourteentdline_istaxexclusive + fifteentdline_itemid + sixteentdline_itemvendorid + actionline  + endtrline;
			$("#itemdetails").append(createdrowline);
			$("#searchCode").val("");
			$("#search").val("");
			$("#stockInSave").removeClass('disabled');
			
			calculateGrandTotal();
		}, null);
	}
}

function deleteRowId(deleterowid) {
	$("#hdnItemStockinId").val(deleterowid);
	$('#stockinitemdeletemodal').modal('show');
}
function deleteStockinItem() {
	var delitemid = $("#hdnItemStockinId").val();
	$("tr#" + delitemid + "").remove();
	calculateGrandTotal();
}

function calculateGrandTotal() { // modified
	console.log("call calculateGrandTotal");
	var grandtotal = 0.00;
	var totaltaxamt = 0.00; 
	var totaldiscamt = 0.00; 
	var mischarge = $("#misChargeId").val();
	$('#itemdetails tr').each(function() {
		var trid = $(this).find("td:eq(14)").html();
		var taxamt =$("#itmtaxamttd_"+trid).html();
		var discamt =$("#itmdiscamttd_"+trid).html();
		var itmtotal = $(this).find("td:eq(10)").html();
		grandtotal = grandtotal + Number(itmtotal);
		totaltaxamt = totaltaxamt + Number(taxamt);
		totaldiscamt = totaldiscamt +Number(discamt);
		
	});
	grandtotal = grandtotal + Number(mischarge);
	
	if(roundoffflag == 'Y'){
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

function changeQty(	qty,
					itemid,
					shcharge,
					taxrate) { //modified
	$("#itmupdate_" + itemid).css('background-color','orange');
	var isno = isNaN(qty);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			var rate = $("#itmrate_" + itemid).val();
			var discountperc = $("#itmdisc_" + itemid).val();
			var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();
			//alert("rate:"+rate+" " +"discountperc:"+" "+ discountperc +"istaxexclusive:"+ istaxexclusive);
			
			var itemamount = Number(qty) * Number(rate);
			//alert("itemamount:"+itemamount);
			var itemdiscountamt = 0.00;
			var itemtotalamt= 0.00;	
			var itemtaxamt = 0.00;
						
			if(discountperc != '' && discountperc != '0'){
				//alert("in discount");
				     if(istaxexclusive == 'Y'){
				    	    // alert("in tax exclusive with disc");
				    	     itemdiscountamt = Number(itemamount) *  Number(discountperc) / 100;
				    	     itemtaxamt = ((Number(itemamount) - Number(itemdiscountamt)) * Number(taxrate)) / 100;
					         itemtotalamt = Number(itemamount) - Number(itemdiscountamt) + Number(itemtaxamt);					        
				          }
				      else{
				    	  //alert("in tax inclusive with disc");
				    	  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
				    	 // alert("basePrice:"+basePrice);
				    	  itemdiscountamt = Number(basePrice) *  Number(discountperc) / 100;  // discount amt on basePrice
				    	  itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt))*Number(taxrate))/100; // tax amt on basePrice
				    	  itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
				    	 }
				         //alert("itemtotalamt:"+itemtotalamt);
			}
			else{
				//alert("no disc");
				if(istaxexclusive == 'Y'){
					 //alert("in tax exclusive without disc");
					 itemtaxamt = (Number(itemamount) * Number(taxrate)) / 100;
				     itemtotalamt = Number(itemamount) + Number(itemtaxamt) ;
				}
				else{
					  //alert("in tax inclusive without disc");
					  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
			    	  //alert("basePrice:"+basePrice);
					  itemtaxamt = (Number(basePrice) *Number(taxrate))/100; // tax amt on basePrice
					  //alert("itemtaxamt:"+itemtaxamt);
					  itemtotalamt = Number(basePrice) + Number(itemtaxamt);
					  //alert("itemtotalamt:"+itemtotalamt);
			    	 
				}
				//alert("itemtotalamt1:"+itemtotalamt);
				
			}
			
			$("#itmtaxamttd_" + itemid).text(parseFloat(itemtaxamt).toFixed(2));
			$("#itmitmamttd_" + itemid).text(parseFloat(itemamount).toFixed(2));
			$("#itmdiscamttd_" + itemid).text(parseFloat(itemdiscountamt).toFixed(2));
			$("#itmtottd_" + itemid).text(parseFloat(itemtotalamt).toFixed(2));
			
			calculateGrandTotal();
			
		}
	}
}

function changeRate(rate,
					itemid,
					shcharge,
					taxrate) { //modified
	$("#itmupdate_" + itemid).css('background-color','orange');
	var isno = isNaN(rate);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (rate < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			var qty = $("#itmqty_" + itemid).val();
			var discountperc = $("#itmdisc_" + itemid).val();
			var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();
			//alert("qty:"+qty+" " +"discountperc:"+" "+ discountperc +"istaxexclusive:"+ istaxexclusive);
			
			//
			var itemamount = Number(qty) * Number(rate);
			//alert("itemamount:"+itemamount);
			var itemdiscountamt = 0.00;
			var itemtotalamt= 0.00;	
			var itemtaxamt = 0.00;
						
			if(discountperc != '' && discountperc != '0'){
				//alert("in discount");
				     if(istaxexclusive == 'Y'){
				    	    // alert("in tax exclusive with disc");
				    	     itemdiscountamt = Number(itemamount) *  Number(discountperc) / 100;
				    	     itemtaxamt = ((Number(itemamount) - Number(itemdiscountamt)) * Number(taxrate)) / 100;
					         itemtotalamt = Number(itemamount) - Number(itemdiscountamt) + Number(itemtaxamt);					        
				          }
				      else{
				    	 // alert("in tax inclusive with disc");
				    	  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
				    	  //alert("basePrice:"+basePrice);
				    	  itemdiscountamt = Number(basePrice) *  Number(discountperc) / 100;  // discount amt on basePrice
				    	  itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt))*Number(taxrate))/100; // tax amt on basePrice
				    	  itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
				    	 }
				         //alert("itemtotalamt:"+itemtotalamt);
			}
			else{
				//alert("no disc");
				if(istaxexclusive == 'Y'){
					 //alert("in tax exclusive without disc");
					 itemtaxamt = (Number(itemamount) * Number(taxrate)) / 100;
				     itemtotalamt = Number(itemamount) + Number(itemtaxamt) ;
				}
				else{
					 // alert("in tax inclusive without disc");
					  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
			    	  //alert("basePrice:"+basePrice);
					  itemtaxamt = (Number(basePrice) *Number(taxrate))/100; // tax amt on basePrice
					  //alert("itemtaxamt:"+itemtaxamt);
					  itemtotalamt = Number(basePrice) + Number(itemtaxamt);
					  //alert("itemtotalamt:"+itemtotalamt);
			    	 
				}
				//alert("itemtotalamt1:"+itemtotalamt);
				
			}
			
			$("#itmtaxamttd_" + itemid).text(parseFloat(itemtaxamt).toFixed(2));
			$("#itmitmamttd_" + itemid).text(parseFloat(itemamount).toFixed(2));
			$("#itmdiscamttd_" + itemid).text(parseFloat(itemdiscountamt).toFixed(2));
			$("#itmtottd_" + itemid).text(parseFloat(itemtotalamt).toFixed(2));
			
			
			
			calculateGrandTotal();
		}
	}
}

function changeDisc(discountperc,
		            itemid,
		            shcharge,
		            taxrate){ //new added
	var isno = isNaN(discountperc);
	if (isno) {
		document.getElementById('msgspace').innerHTML = "Plese Enter Valid Discount Percentage.";
		$("#msgmodal").modal('show');
	} else {
		if (discountperc < 0) {
			document.getElementById('msgspace').innerHTML = "Plese Enter Valid Discount Percentage.";
			$("#msgmodal").modal('show');
		} else {
	
	var qty = $("#itmqty_" + itemid).val();
	var rate = $("#itmrate_" + itemid).val();
	var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();
	//alert("discountperc"+discountperc+" "+"qty:"+qty+" " +"rate:"+" "+ rate +"istaxexclusive:"+ istaxexclusive);
	
	//
	var itemamount = Number(qty) * Number(rate);
	//alert("itemamount:"+itemamount);
	var itemdiscountamt = 0.00;
	var itemtotalamt= 0.00;	
	var itemtaxamt = 0.00;
				
	if(discountperc != '' && discountperc != '0'){
		//alert("in discount");
		     if(istaxexclusive == 'Y'){
		    	     //alert("in tax exclusive with disc");
		    	     itemdiscountamt = Number(itemamount) *  Number(discountperc) / 100;
		    	     itemtaxamt = ((Number(itemamount) - Number(itemdiscountamt)) * Number(taxrate)) / 100;
			         itemtotalamt = Number(itemamount) - Number(itemdiscountamt) + Number(itemtaxamt);					        
		          }
		      else{
		    	  //alert("in tax inclusive with disc");
		    	  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
		    	  //alert("basePrice:"+basePrice);
		    	  itemdiscountamt = Number(basePrice) *  Number(discountperc) / 100;  // discount amt on basePrice
		    	  itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt))*Number(taxrate))/100; // tax amt on basePrice
		    	  itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
		    	 }
		         //alert("itemtotalamt:"+itemtotalamt);
	}
	else{
		//alert("no disc");
		if(istaxexclusive == 'Y'){
			// alert("in tax exclusive without disc");
			 itemtaxamt = (Number(itemamount) * Number(taxrate)) / 100;
		     itemtotalamt = Number(itemamount) + Number(itemtaxamt) ;
		}
		else{
			 // alert("in tax inclusive without disc");
			  var basePrice =  Number(itemamount) / (1 + (Number(taxrate)/100) );  //this basePrice is without tax amt
	    	  //alert("basePrice:"+basePrice);
			  itemtaxamt = (Number(basePrice) *Number(taxrate))/100; // tax amt on basePrice
			 // alert("itemtaxamt:"+itemtaxamt);
			  itemtotalamt = Number(basePrice) + Number(itemtaxamt);
			 // alert("itemtotalamt:"+itemtotalamt);
	    	 
		}
		//alert("itemtotalamt1:"+itemtotalamt);
		
	}
	
	$("#itmtaxamttd_" + itemid).text(parseFloat(itemtaxamt).toFixed(2));
	$("#itmitmamttd_" + itemid).text(parseFloat(itemamount).toFixed(2));
	$("#itmdiscamttd_" + itemid).text(parseFloat(itemdiscountamt).toFixed(2));
	$("#itmtottd_" + itemid).text(parseFloat(itemtotalamt).toFixed(2));
	calculateGrandTotal();
		}
		
}
}

function calculateDiscount(){ //new added
	var discountperc = $("#discountId").val();
	var isno = isNaN(discountperc);
	if (isno) {
		
	} else {
		if (discountperc < 0) {
			
		} else {
			
			$('#itemdetails tr').each(function() {
				var trid = $(this).find("td:eq(14)").html();
				var taxrate =$("#itmtaxid_"+trid).val();
				var shippingcharge = $("#itmspchrg_"+trid).val();
				$("#itmdisc_"+trid).val(discountperc);
				//alert("discountperc:"+discountperc+" "+"itemid:"+trid+" "+"shippingcharge:"+shippingcharge+""+"taxrate:"+taxrate);
				changeDisc(discountperc,trid,shippingcharge,taxrate);
				
			});
		   }	
		}
	
}



function stockInSave() { //modified
	//$("#stockInSave").addClass('disabled');
	var stockinid = 0;
	var vendorId = $("#selectedvendorId").val();
	var billNo = $("#billNo").val();
	var billDate = $("#billDate").val();
	var stockincreatedate = $("#stockinDate").val();
	var closeStockin = $("#closeStockin").val();
	console.log("vendorId=" + vendorId);
	console.log("billNo=" + billNo);
	console.log("billDate=" + billDate);
	console.log("stockincreatedate=" + stockincreatedate);

	var invStockin1 = {};
	var invStockin = [];
	var d = new Date();
	var totQty = 0.00;
	var totitemtot = 0.00;
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var poid = 0;
	var shouldpositive = 0;
	var tableDatalen = $('#stockinItemTable > tbody  > tr').length;
	$('#stockinItemTable > tbody  > tr').each(function() {
		var trid = this.id;
		var qty = $("#itmqty_" + trid).val();
		var rate = $("#itmrate_" + trid).val();
		if (qty < 0 || rate < 0 || qty == '' || rate == '' || qty == 0 || rate == 0) {
			shouldpositive = 1;
		}
	});
	if (shouldpositive == 1) {
		$("#positiveitemquantityorrate").modal('show');
		//$("#stockInSave").removeClass('disabled');
	} else if (stockincreatedate < billDate) {
		$("#billdateGreaterdmodal").modal('show');
		//$("#stockInSave").removeClass('disabled');
	} else if (tableDatalen == 0) {
		$("#tabledatadmodal").modal('show');
		//$("#stockInSave").removeClass('disabled');
	} else if (billNo == 0) {
		$("#billnodmodal").modal('show');
		//$("#stockInSave").removeClass('disabled');
	} else if (closeStockin == 'Y') {
		document.getElementById('msgspace').innerHTML = "Data Is Not Updatable.";
		$("#msgmodal").modal('show');
	}else {
		$("#stockInSave").addClass('disabled');
		$('#stockinItemTable > tbody  > tr').each(function() {
			console.log("tr id=" + this.id);
			var that = this;
			var trid = this.id;
			var qty = $("#itmqty_" + trid).val();
			totQty = totQty + parseFloat(qty);			
			var rate = $("#itmrate_" + trid).val();
			var unitid = $("#itmunitid_" + trid).val();
			
		    poid = $("#itmpoidtd_" + trid).html();
			var itmcode = $("#stockinitmcode_" + trid).val();
			var taxperc = $("#itmtaxid_" + trid).val();
			var taxamt = $("#itmtaxamttd_" + trid).html();
			var discperc = $("#itmdisc_" + trid).val();
			if(discperc == ''){discperc =0.0;}
			var discamt = $("#itmdiscamttd_" + trid).html();
			var itemamt = $("#itmitmamttd_" + trid).html();
			totitemtot=totitemtot + parseFloat(itemamt);
			var itemtotal = $("#itmtottd_" + trid).html();	
			var shippingcharge = $("#itmspchrg_" + trid).val();
			var istaxexclusive = $("#itmistaxexclusive_" + trid).val();
			
				
			if ($("#stockinid_" + trid).val() != 0) {
				stockinid = $("#stockinid_" + trid).val();
			}
			//	    $(this).find("td:gt(0)").each(function(){
			//	       });
			if ($("#stockinid_" + trid).val() == 0) {
				var invStockinItems = {};
				var inventoryItemsarr = {};
				invStockinItems.itemQuantity = qty;
				invStockinItems.itemRate = rate;
				invStockinItems.itemTotalPrice = itemamt;
				invStockinItems.taxRate = taxperc;
				invStockinItems.taxAmount = taxamt;
				invStockinItems.itemGrossAmount = itemtotal;
				invStockinItems.poId = poid;
				invStockinItems.unitId = unitid;
				invStockinItems.storeId = storeid;
				invStockinItems.createdDate = stockincreatedate;
				invStockinItems.createdBy = storeid;
				invStockinItems.isTaxExclusive = istaxexclusive;
				invStockinItems.discPer =discperc;
				invStockinItems.discAmt =discamt;
				
				inventoryItemsarr.id = trid;
				inventoryItemsarr.code = itmcode;
				
				invStockinItems.inventoryItems = inventoryItemsarr;
				invStockin.push(invStockinItems);
			}
			else{
				var invStockinItems = {};
				var inventoryItemsarr = {};
				invStockinItems.itemQuantity = qty;
				invStockinItems.itemRate = rate;
				invStockinItems.itemTotalPrice = itemamt;
				invStockinItems.taxRate = taxperc;
				invStockinItems.taxAmount = taxamt;
				invStockinItems.itemGrossAmount = itemtotal;
				invStockinItems.poId = poid;
				invStockinItems.unitId = unitid;
				invStockinItems.storeId = storeid;
				invStockinItems.createdDate = stockincreatedate;
				invStockinItems.createdBy = storeid;
				invStockinItems.isTaxExclusive = istaxexclusive;
				invStockinItems.discPer =discperc;
				invStockinItems.discAmt =discamt;
				
				inventoryItemsarr.id = trid;
				inventoryItemsarr.code = itmcode;
				
				invStockinItems.inventoryItems = inventoryItemsarr;
				invStockin.push(invStockinItems);
				
			}
		});
		invStockin1.inventoryStockInItems = invStockin;
		invStockin1.id = stockinid;
		invStockin1.date = stockincreatedate;
		invStockin1.userId = storeid;
		invStockin1.storeId = storeid;
		invStockin1.vendorId = vendorId;
		invStockin1.billNo = billNo;
		invStockin1.billDate = billDate;
		invStockin1.itemTotal = totitemtot;
		
		var discountpercentage = $("#discountId").val();
		if(discountpercentage == ''){discountpercentage = 0;}
		invStockin1.discPer = parseFloat(discountpercentage);
		
		invStockin1.discAmt= $("#discountAmtId").val();
		invStockin1.taxAmt= $("#totalTaxId").val();
		
		var mislechargeamt = $("#misChargeId").val();		
		if(mislechargeamt == ''){mislechargeamt = 0};
		invStockin1.miscCharge = parseFloat(mislechargeamt);
		
		invStockin1.totalPrice = $("#grandtotalId").val();
		invStockin1.totalQuantity = totQty;
		invStockin1.createdDate = stockincreatedate;
		invStockin1.poId = poid;
		invStockin1.roundOffAmt = $("#roundOffAmtId").val();
		//		console.log("invStockin1="+JSON.stringify(invStockin1));
		$.ajax({
			url : BASE_URL + "/stockinnew/createorupdatestockin.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invStockin1),
			success : function(response) {
				//called when successful
				if (response == 'success') {
					console.log("stockinid="+stockinid);
					if (stockinid == 0) {
						location.href = BASE_URL+'/stockinnew/loadstockin.htm';
					} else {
						rowClicked(stockinid);
					}
				}
			},
			error : function(e) {
			}
		});
	}
}

function rowClicked(id) {
	//alert("clicked");
	//$("#itemdetails").html("");
	$('#billNo').prop('disabled', true);
	$('#billDate').prop('disabled', true);
	$("#pocallbtn").addClass('disabled');
	var selectDate = $("#stockinDate").val();
	console.log("selectDate=" + selectDate);
	console.log("id=" + id);
	$("#selectedstockinid").val(id);
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/stockinnew/getstockIndetailsbyidanddate/" + id + "/" + selectDate + ".htm", function(response) {
		console.log("response=" + response);
		var stockindetail = JSON.parse(response);
		$("#itemdetails").html("");
		for ( var i = 0; i < stockindetail.length; i++) {
			var invstockInItems = stockindetail[i];
			$("#pono").val(invstockInItems.poId);
			$('#pono').prop('disabled', true);
			console.log("response=" + invstockInItems.inventoryStockInItems.length);
			for ( var j = 0; j < invstockInItems.inventoryStockInItems.length; j++) {
				var itemdetail = invstockInItems.inventoryStockInItems[j];
				console.log("response.code=" + itemdetail.code);
				var createdrowline = "";
				
				var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
				var firsttdline_id = "<td  id='stockinitmcodetd_" + itemdetail.inventoryItems.id+ "'><input type='hidden'  id='stockinitmcode_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
				var secondtdline_name = "<td id='stockinitmnametd_" + itemdetail.inventoryItems.id+ "'><input type='hidden'  id='stockinid_" + itemdetail.inventoryItems.id+ "' value='"+invstockInItems.id +"' />" + itemdetail.inventoryItems.name + "</td>";
				
				if(invstockInItems.closed == 'N'){
					var thirdtdline_qty = "<td id='stockinitmqtytd_" + itemdetail.inventoryItems.id+ "'><input  type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmqty_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.itemQuantity+ "' onkeydown='numcheck(event);' /></td>";
				}
				else{
					var thirdtdline_qty = "<td id='stockinitmqtytd_" + itemdetail.inventoryItems.id+ "'><input readonly type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmqty_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.itemQuantity+ "' /></td>";
				}
				
				var fourthtdline_unit = "<td id='stockinitmunittd_" + itemdetail.inventoryItems.id+ "'><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.unitId + "' />" + /*itemdetail.unitName*/itemdetail.metricUnit.unit + "</td>";
				
				
				if(invstockInItems.closed == 'N'){
				var fifthtdline_rate = "<td id='stockinitmratetd_" + itemdetail.inventoryItems.id+ "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmrate_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.itemRate + "' onkeydown='numcheck(event);'/> </td>";
				}
				else{
					var fifthtdline_rate = "<td id='stockinitmratetd_" + itemdetail.inventoryItems.id+ "'><input readonly type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmrate_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.itemRate + "' /> </td>";
				}
				var sixthtdline_tax = "<td id='stockinitmtaxtd_" + itemdetail.inventoryItems.id+ "'><input type='hidden'  id='itmtaxid_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.taxRate + "' />" + parseFloat(itemdetail.taxRate).toFixed(2) + "</td>";
				var seventhtdline_taxamt = "<td id='itmtaxamttd_" + itemdetail.inventoryItems.id+ "' style='display:none;'>" + parseFloat(itemdetail.taxAmount).toFixed(2) + "</td>";
				
				if(invstockInItems.closed == 'N'){
				var eighttdline_disc="<td id='stockinitmdisctd_" + itemdetail.inventoryItems.id+ "'><input type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmdisc_" + itemdetail.inventoryItems.id+ "' value='"+parseFloat(itemdetail.discPer).toFixed(2)+"' onkeydown='numcheck(event);' /></td>";
				}
				else{
					var eighttdline_disc="<td id='stockinitmdisctd_" + itemdetail.inventoryItems.id+ "'><input readonly type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.inventoryItems.id+ "," + itemdetail.inventoryItems.shippingCharge + "," + itemdetail.taxRate+ ") id='itmdisc_" + itemdetail.inventoryItems.id+ "' value='"+parseFloat(itemdetail.discPer).toFixed(2)+"' /></td>";
						
				}
				var ninetdline_discamt="<td id='itmdiscamttd_" + itemdetail.inventoryItems.id+ "'>" +parseFloat(itemdetail.discAmt).toFixed(2) + "</td>";
				var tentdline_itmamt="<td id='itmitmamttd_" + itemdetail.inventoryItems.id+ "' style='display:none;'>" + parseFloat(itemdetail.itemTotalPrice).toFixed(2) + "</td>";
				var eleventdline_total = "<td id='itmtottd_" + itemdetail.inventoryItems.id+ "'>" + parseFloat(itemdetail.itemGrossAmount).toFixed(2) + "</td>"; 
				var twelvetdline_poid = "<td id='itmpoidtd_" + itemdetail.inventoryItems.id+ "' style='display:none;'>"+itemdetail.poId+"</td>";
				var thirteentdline_shipping = "<td id='itmshipingtd_" + itemdetail.inventoryItems.id+ "'style='display:none;'><input type='text' size='4'  id='itmspchrg_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.inventoryItems.shippingCharge + "' /></td>";
				var fourteentdline_istaxexclusive = "<td id='itmistaxexclusivetd_" + itemdetail.inventoryItems.id+ "' style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.inventoryItems.id+ "' value='" + itemdetail.isTaxExclusive+ "' /></td>";
				var fifteentdline_itemid = "<td id='itmidtd_" + itemdetail.inventoryItems.id+ "' style='display:none;'>"+itemdetail.inventoryItems.id+"</td>";
				var sixteentdline_itemvendorid = "<td id='itmvendoridtd_" + itemdetail.inventoryItems.id+ "' style='display:none;'><input type='hidden'  id='itmvendorid_" + itemdetail.inventoryItems.id+ "' value='" + invstockInItems.vendorId + "' />" + invstockInItems.vendorId + "</td>";
				
				if(invstockInItems.closed == 'N'){
					var actionline = "<td><a href='javascript:deleteRowId(" + itemdetail.inventoryItems.id+ ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
						
				}
				else{
					var actionline = "<td></td>";
				}
					var endtrline = "</tr>";
				
				createdrowline = starttrline + firsttdline_id + secondtdline_name + thirdtdline_qty + fourthtdline_unit + fifthtdline_rate + sixthtdline_tax + seventhtdline_taxamt + eighttdline_disc + ninetdline_discamt + tentdline_itmamt + eleventdline_total + twelvetdline_poid + thirteentdline_shipping + fourteentdline_istaxexclusive + fifteentdline_itemid + sixteentdline_itemvendorid + actionline  + endtrline;
				
				$("#itemdetails").append(createdrowline);
				$("#searchCode").val("");
				$("#search").val("");
				$("#billNo").val(invstockInItems.billNo);
				$("#billDate").val(invstockInItems.billDate);
				$("#selectedvendorId").val(invstockInItems.vendorId);
				$("#misChargeId").val(invstockInItems.miscCharge);
				$("#misChargeId").prop('disabled', true);
				$("#discountId").val(invstockInItems.discPer);
				$("#createdstockinid").val(invstockInItems.id);
				calculateGrandTotal();
				
			}
			setButton();
			if (invstockInItems.closed == 'Y') {
				$("#stockInSave").addClass('disabled');	
				//alert('rowcli');
				$("#closeStockin").val('Y');
				$("#stockinUserId").val(invstockInItems.createdBy);
				$('#closeStockin').prop('disabled', true);
				$("#closestockinButton").addClass('disabled');
				$("#selectedvendorId").prop('disabled', true);
				$("#stockInDelete").addClass('disabled');
				$('#discountId').prop('disabled', true);
			} else {
				$("#closeStockin").val('N');
				$("#stockinUserId").val('');
				$('#closeStockin').removeAttr('disabled');
				$("#closestockinButton").removeClass('disabled');
				//$("#selectedvendorId").removeAttr('disabled');
				$("#selectedvendorId").prop('disabled', true);
				$("#stockInSave").removeClass('disabled');
				$("#stockInDelete").removeClass('disabled');
				$('#discountId').prop('disabled', false);
			}
		}
		
	}, null);
}

function deleteRowForExistingStockIn(	deleterowid,
										stockinid,
										stockininvitemid) {
	$("#hdnitemstockinid").val(deleterowid);
	$("#hdnstockinid").val(stockinid);
	$("#hdnstockininvitemid").val(stockininvitemid);
	$("#existingstockinitemdeletemodal").modal('show');
}

function deleteExistingStockInItem() {
	var deleterowid = $("#hdnitemstockinid").val();
	var stockinid = $("#hdnstockinid").val();
	var stockininvitemid = $("#hdnstockininvitemid").val();
	console.log("stockinid=" + stockinid);
	console.log("stockininvitemid=" + stockininvitemid);
	$("tr#" + deleterowid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/stockinnew/deleteEachStockInItem/" + stockininvitemid + "/" + stockinid + ".htm", function(response) {
	}, null);
	calculateGrandTotal();
}

/*function editExistingPOItem(itemid,
							stockinid,
							stockininvid) {
	console.log("itemid=" + itemid);
	console.log("stockinid=" + stockinid);
	console.log("stockininvid=" + stockininvid);
	//	var vendorid = $("#itmvendorid_" + itemid).val();
	var qty = $("#itmqty_" + itemid).val();
	var rate = $("#itmrate_" + itemid).val();
	var unitid = $("#itmunitid_" + itemid).val();
	var poid = $("#itmpoid_" + itemid).val();
	var itmcode = $("#stockinitmcode_" + itemid).val();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var isnoqty = isNaN(qty);
	var isnorate = isNaN(rate);
	if (isnoqty || isnorate || qty == '' || rate == '') {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0 || rate < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			$('#stockinItemTable > tbody  > tr').each(function() {
				var that = this;
				if (this.id == itemid) {
					var invStockinItems = {};
					var inventoryItemsarr = {};
					var invStockin = {};
					invStockinItems.id = stockininvid;
					invStockinItems.itemQuantity = qty;
					invStockinItems.itemRate = rate;
					invStockinItems.itemTotalPrice = $(that).find("td:eq(7)").html();
					invStockinItems.taxRate = vatAmt;
					invStockinItems.taxAmount = $(that).find("td:eq(6)").html();
					invStockinItems.itemGrossAmount = $(that).find("td:eq(8)").html();
					invStockinItems.poId = poid;
					invStockinItems.unitId = unitid;
					invStockinItems.storeId = storeid;
					invStockinItems.createdDate = creationDate;
					invStockinItems.createdBy = storeid;
					inventoryItemsarr.id = itemid;
					inventoryItemsarr.code = itmcode;
					invStockin.id = stockinid;
					invStockinItems.inventoryItems = inventoryItemsarr;
					invStockinItems.inventoryStockIn = invStockin;
					//			console.log("invPOOrderItems=" + JSON.stringify(invPOOrderItems));
					$.ajax({
						url : BASE_URL + "/stockinnew/updatestockinitem.htm",
						type : 'POST',
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(invStockinItems),
						success : function(response) {
							if (response == 'success') {
								$("#itemupdatedmodal").modal('show');
								$("#itmupdate_" + itemid).css('background-color','#78B626');
							}
						},
						error : function(e) {
						}
					});
				}
			});
		}
	}
}
*/
function getStockInByDate() {
	var selectDate = $("#stockinDate").val();
	console.log("selectDate=" + selectDate);
	location.href = BASE_URL + "/stockinnew/getstockIndetailsbydate/" + selectDate + ".htm";
}

function getSelectedStatus(value) {
	var usrId = $("#hiduserid").val();
	var userId = document.getElementById('stockinUserId');
	if (value == 'Y') {
		userId.value = usrId;
	} else {
		userId.value = '';
	}
}
function closeStatusUpdated() {
	var selectedstockinid = $("#selectedstockinid").val();
	console.log("selectedstockinid=" + selectedstockinid);
	if (selectedstockinid != 0 && selectedstockinid != undefined) {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + '/stockinnew/stockInClosed.htm?stockInId=' + selectedstockinid, function(response) {
			if (response == 'success') {
				$("#stockinstatus_" + selectedstockinid).html('Y');
				rowClicked(selectedstockinid);
			}
		}, null);
	}
}

function viewPurchaseOrder() {
	var selectedpoid = $("#selectedstockinid").val();
	console.log("selectedstockinid=" + selectedstockinid);
	console.log("$('#stockinItemTable > tbody  > tr').=" + $('#stockinItemTable > tbody  > tr').length);
	var tableDatalen = $('#stockinItemTable > tbody  > tr').length;
	if (selectedpoid == 0 && tableDatalen > 0) {
		$("#displayPOPage").modal('show');
	} else {
		location.href = BASE_URL + '/inventorynew/loadinventory.htm';
	}
}

function viewPurchaseOrderPage() {
	location.href = BASE_URL + '/inventorynew/loadinventory.htm';
}

function viewStockOut() {
	location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
}


// new added function 26th april 2018

function bringPoDetails(){ //add new
	//alert("hi");
	
	$("#itemdetails").html("");
	var poid = document.getElementById('pono').value;
	//alert("hi"+poid);
	if(poid == '' || poid == 'undefined' || poid == null){
		document.getElementById('msgspace').innerHTML = "Please Enter Valid PO Number.";
		$("#msgmodal").modal('show');
	}else{
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getpodetailsbypoid/" + poid + ".htm", function(response) {
		console.log("response=" + response);
		//		console.log("response="+response.inventoryPurchaseOrderItems);
		var podetail = JSON.parse(response);
		var invPOItems = [];
		var discountprcs = $("#discountId").val();
		if( discountprcs == '' || discountprcs == 'undefined') {
			discountprcs = 0.0;
		}
		if(podetail.length > 0){
		for ( var i = 0; i < podetail.length; i++) {
			var invPOItems = podetail[i];			
			$("#selectedPovendorId").val(invPOItems.vendorId);//new
			$("#selectedPovendorId").prop("disabled", true);//new
			console.log("response=" + invPOItems.inventoryPurchaseOrderItems.length);
			for ( var j = 0; j < invPOItems.inventoryPurchaseOrderItems.length; j++) {
				var itemdetail = invPOItems.inventoryPurchaseOrderItems[j];
				
			
				
				var itemamt = Number(itemdetail.itemQuantity)*Number(itemdetail.rate);
				var itemdiscountamt = 0;
				var itemtaxamt = 0;
				var itemtotalamt = 0;
				
				if(itemdetail.isTaxExclusive == 'Y'){
		    	     itemdiscountamt = Number(itemamt) *  Number(discountprcs) / 100;
		    	     itemtaxamt = ((Number(itemamt) - Number(itemdiscountamt)) * Number(itemdetail.taxRate)) / 100;
			         itemtotalamt = Number(itemamt) - Number(itemdiscountamt) + Number(itemtaxamt);					        
		          }
		      else{
		    	  var basePrice =  Number(itemamt) / (1 + (Number(itemdetail.taxRate)/100) );  //this basePrice is without tax amt
		    	  itemdiscountamt = Number(basePrice) *  Number(discountprcs) / 100;  // discount amt on basePrice
		    	  itemtaxamt = ((Number(basePrice) - Number(itemdiscountamt))*Number(itemdetail.taxRate))/100; // tax amt on basePrice
		    	  itemtotalamt = Number(basePrice) + Number(itemtaxamt) - Number(itemdiscountamt);
		    	 }
				//
				//alert("Code:"+itemdetail.inventoryItems.code);
				var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
				var firsttdline_id = "<td  id='stockinitmcodetd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='stockinitmcode_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
				
				var secondtdline_name = "<td id='stockinitmnametd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='stockinid_" + itemdetail.inventoryItems.id + "' value='0' />" + itemdetail.inventoryItems.name + "</td>";
				
				var thirdtdline_qty = "<td id='stockinitmqtytd_" + itemdetail.inventoryItems.id + "'><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemQuantity
	             + "' onkeydown='numcheck(event);'/></td>";
				 
				 
				var fourthtdline_unit = "<td id='stockinitmunittd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unitId + "' />" + itemdetail.metricUnit.unit + "</td>";
				   
				   
				var fifthtdline_rate = "<td id='stockinitmratetd_" + itemdetail.inventoryItems.id + "'><input type='text' size='4' onkeyup=javascript:changeRate(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmrate_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.rate + "' onkeydown='numcheck(event);' /> </td>";
				
				var sixthtdline_tax = "<td id='stockinitmtaxtd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='itmtaxid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.taxRate + "' />" + parseFloat(itemdetail.taxRate).toFixed(2) + "</td>";
				
				
				
				var seventhtdline_taxamt = "<td id='itmtaxamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemtaxamt).toFixed(2) + "</td>";
				
			    var eighttdline_disc="<td id='stockinitmdisctd_" + itemdetail.inventoryItems.id + "'><input type='text' size='4' onkeyup=javascript:changeDisc(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge + "," + itemdetail.taxRate+ ") id='itmdisc_" + itemdetail.inventoryItems.id + "' value='"+discountprcs+"' onkeydown='numcheck(event);'/></td>";
				
				var ninetdline_discamt="<td id='itmdiscamttd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdiscountamt).toFixed(2) + "</td>";
				
				var tentdline_itmamt="<td id='itmitmamttd_" + itemdetail.inventoryItems.id + "' style='display:none;'>" + parseFloat(itemamt).toFixed(2) + "</td>";
				
				if(itemdetail.isTaxExclusive == 'Y'){				
					var eleventdline_total = "<td id='itmtottd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemtotalamt).toFixed(2) + "</td>"; //modified
				}
				else{				
					var eleventdline_total = "<td id='itmtottd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemamt).toFixed(2) + "</td>"; //modified
				}
				
				
				var twelvetdline_poid = "<td id='itmpoidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>"+invPOItems.id+"</td>";
				
				var thirteentdline_shipping = "<td id='itmshipingtd_" + itemdetail.inventoryItems.id + "'style='display:none;'><input type='text' size='4'  id='itmspchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
				
				var fourteentdline_istaxexclusive = "<td id='itmistaxexclusivetd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>";
				
				var fifteentdline_itemid = "<td id='itmidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>"+itemdetail.inventoryItems.id+"</td>";
				
				var sixteentdline_itemvendorid = "<td id='itmvendoridtd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='hidden'  id='itmvendorid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.vendorId + "' />" + itemdetail.vendorId  + "</td>";
				
				var actionline = "<td><a href='javascript:deleteRowId(" + itemdetail.inventoryItems.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
				var endtrline = "</tr>";
				
				createdrowline = starttrline + firsttdline_id + secondtdline_name + thirdtdline_qty + fourthtdline_unit + fifthtdline_rate + sixthtdline_tax + seventhtdline_taxamt + eighttdline_disc + ninetdline_discamt + tentdline_itmamt + eleventdline_total + twelvetdline_poid + thirteentdline_shipping + fourteentdline_istaxexclusive + fifteentdline_itemid + sixteentdline_itemvendorid + actionline  + endtrline;
				$("#itemdetails").append(createdrowline);
				$("#selectedvendorId").val(invPOItems.vendorId);
				
				calculateGrandTotal(); 
				}
		}
	}
	else{
		$("#pono").val('');
		$("#misChargeId").val('');
		$("#discountId").val('');
		$("#discountAmtId").val('');
		$("#totalTaxId").val('');
		$("#grandtotalId").val('');
		$("#roundOffAmtId").val('');
		document.getElementById('msgspace').innerHTML = "PO Does Not Exist.";
		$("#msgmodal").modal('show');
		$("#pono").val('');
	}	
		
   }, null);	
  }
}


function setButton(){ //add new
	//alert('setbut');
	var stockinid = $("#createdstockinid").val();
	var activebutton="";
	if(stockinid == '0'){
		activebutton ="<a href='javascript:stockInSave()' id='stockInSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";
		
	}
	else{
		activebutton ="<a href='javascript:stockInSave()' id='stockInSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";
		
	}	
	document.getElementById("operationbtnspan").innerHTML = activebutton;	
	}

function stockInDeleteConfirmation(){ // added new
	$("#stockindeletemodal").modal('show');
}

function stockInDelete(){ // added new
	var selectedstockinid = $("#createdstockinid").val();
	var tableDatalen = $('#stockinItemTable > tbody  > tr').length;
	if (selectedstockinid == 0) {
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	} else if(tableDatalen == 0){
		document.getElementById('msgspace').innerHTML = "Please Select Data For Delete.";
		$("#msgmodal").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/stockinnew/deletestockinbyid/' + selectedstockinid+'.htm' , function(response) {
		if (response == 'success') {
			location.href=BASE_URL+'/stockinnew/loadstockin.htm';
		}
		else{
			document.getElementById('msgspace').innerHTML = "Problem Occured.Data Is Not Deleted.";
			$("#msgmodal").modal('show');
		}
	}, null);
	}
	
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





