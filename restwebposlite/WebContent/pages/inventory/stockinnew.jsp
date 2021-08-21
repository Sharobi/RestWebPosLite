<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: StockIn :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/datepicker.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<style type="text/css">
.selected {
	background-color: #77C5EB !important;
}
</style>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="background-color: #e9e9e9;">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px; background-color: #fff;">
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:viewPurchaseOrder()">SIMPLE PURCHASE ORDER</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="#">SIMPLE STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()">SIMPLE STOCK OUT</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/purchasereturn/loadpurchasereturn.htm'">SIMPLE PURCHASE RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/loaditemstockin.htm'">FG STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
							<a href="javascript:location.href='${pageContext.request.contextPath}/itemreturn/loaditemreturn.htm'">FG RETURN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:location.href='${pageContext.request.contextPath}/itemstockin/stockinfo.htm'">FG STOCK DISPLAY</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								STOCK IN <a href="javascript:newStockIn()" class="btn btn-success" style="background: #78B626">NEW</a>
							</div>
						</div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition">
								Date&nbsp;&nbsp;<input type="text" id="stockincreatedate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>' style="text-align: center;"> Created By&nbsp;&nbsp;<input type="text" size="2" readonly value="${sessionScope.loggedinUser.contactNo}" style="text-align: center;"> StockIn Id&nbsp;&nbsp;<input type="text" size="2" id="createdstockinid" readonly value="0" style="text-align: center;">
							<input type="hidden" id="hiduserid" value="${sessionScope.loggedinUser.contactNo}">
							</div>
						</div>
					</div>

					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 ">
							<div class="inv-requisition">
								Date&nbsp;&nbsp;<input type="text" name="selecteddate" id="stockinDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'>&nbsp;&nbsp; <a href="javascript:getStockInByDate()" class="btn btn-success" style="background: #78B626">GO</a>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="inv-requisition">
								Bill Date&nbsp;&nbsp;<input type="text" id="billDate" name="billDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>' size="8" readonly>Bill No&nbsp;&nbsp;<input type="text" id="billNo" name="billNo" value="0" size="6"> Vendor&nbsp;&nbsp; <select id="selectedvendorId" name="vendorId">
									<c:forEach items="${vendorList}" var="vendor">
										<option value="${vendor.id}">${vendor.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-3 col-sm-6">
							<div class="inv-requisition">
								Close&nbsp;&nbsp;<select id="closeStockin" name="selectPO" onchange="getSelectedStatus(this.value)"><option value="N">N</option>
									<option value="Y">Y</option></select> By&nbsp;&nbsp;<input type="text" size="4" id="stockinUserId" value=""> <a href="javascript:closeStatusUpdated()" id="closestockinButton" class="btn btn-success" style="background: #78B626">DONE</a>
							</div>
						</div>
						<!-- <div class="col-md-3" id="serachDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewStockInItem()" class="btn btn-success" style="background: #78B626">ADD</a>
							</div>
						</div> -->
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
					<div class="col-md-4" id="serachDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewStockInItem()" class="btn btn-success" style="background: #78B626">ADD</a>
							</div>
						</div>
						<div class="col-md-8" id="poDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="PO NUMBER" id="pono" name="Pono" value="" onkeydown="numcheck(event);"> &nbsp;&nbsp; <a href="javascript:bringPoDetails()" id="pocallbtn" class="btn btn-success" style="background: #78B626">ADD</a>
							</div>
						</div>
					</div>
					
					
					
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<input type="hidden" id="hidvatTaxVal" value="${sessionScope.loggedinStore.vatAmt}"> <input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
						<input type="hidden" id="selectedstockinid" value="0">
						<div class="col-md-3 col-sm-4">
							<div style="background: #CCCCCC; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 200px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered">
												<thead>
													<tr style="background: #77C5EB;">
														<th>ID</th>
														<th>VENDOR</th>
														<th>CLOSED</th>
													</tr>
												</thead>
												<c:if test="${! empty inventoryStockInList}">
													<c:forEach items="${inventoryStockInList}" var="inventoryStockIn" varStatus="odrStatus">
														<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${inventoryStockIn.id})" class="selected-stockin-row">
															<td>${inventoryStockIn.id}</td>
															<td>${inventoryStockIn.vendorName}</td>
															<td id="stockinstatus_${inventoryStockIn.id}">${inventoryStockIn.closed}</td>
														</tr>
														<input type="hidden" value="${inventoryStockIn.id}" id="hidstockinId">
													</c:forEach>
												</c:if>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-8">
							<div style="background: #FFF; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 260px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" style="" id="stockinItemTable">
												<thead style="background: #999999;">
													<th>ID</th>
													<th>ITEM</th>
													<th>QUANTITY</th>
													<th>UNIT</th>
													<th>RATE</th>
													<th>TAX(%)</th>
													<th style="display:none;">TAX AMOUNT</th>
													<th>DISCOUNT(%)</th>
													<th>DISCOUNT AMOUNT</th>
													<th style="display:none;">ITEM AMOUNT</th>
													<th>TOTAL</th>
													<th style="display:none;">PO NO</th>
													<th>ACTION</th>
												</thead>
												<tbody id="itemdetails"></tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-8 col-sm-8">
							Misc Charges:<input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown="numcheck(event);">
						    Discount(%):<input type="text" size="5" id="discountId" onkeyup="javascript:calculateDiscount()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown="numcheck(event);">
							Discount Amt:<input type="text" readonly size="8" id="discountAmtId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
							Tax Amt:<input type="text" readonly size="8" id="totalTaxId"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;">
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-6">
							<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp; 
							<font style="font-weight: bold;">Round Off:</font><input type="text" id="roundOffAmtId" name="RoundOffAmtId" size="5" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp; 
							<span id="operationbtnspan"></span>
							<%-- <a href="javascript:stockInSave()" id="stockInSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="stockinnew.jsp.Save" text="Save" /></a> --%>
						    <a href="javascript:stockInDeleteConfirmation()" id="stockInDelete" class="btn btn-success" style="background: #78B626; margin-top: 3px;">Delete</a>
						
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--modal-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js">
		
	</script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/stockinScriptNew.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
		// When the document is ready
		$(document).ready(function() {
			var hidstockinId=$("#hidstockinId").val();
 			console.log("hidstockinId="+hidstockinId);
 			var selectedstockinid = $("#selectedstockinid").val();
 			console.log("selectedstockinid=" + selectedstockinid);
 			if(undefined!=hidstockinId){
 				rowClicked(hidstockinId);
 			}else {
 				if(undefined!=selectedstockinid && selectedstockinid!=0){
 					rowClicked(selectedstockinid);
 				}
 				else{
 					$("#stockInDelete").addClass('disabled'); // new
 					setButton();//new
 				}
 			}
			$('#stockinDate').datepicker({
				format : "yyyy-mm-dd",
				endDate: '+0d',
				autoclose : true
			});
			
			$('#billDate').datepicker({
				format : "yyyy-mm-dd",
				endDate: '+0d',
				autoclose : true
			});
			
		});
		$('.selected-stockin-row').on('click',function(){
	 		   $(this).parent().find('.selected-stockin-row').removeClass('selected');
	 		  $(this).addClass('selected');
	 		  });
	</script>
	<script type="text/javascript">
	var roundoffflag = "${sessionScope.loggedinStore.roundOffTotalAmtStatus}";
     $(function() {
         $("#search").autocomplete({
             source: function(request, response) {
                 $.ajax({
                     url: "${pageContext.request.contextPath}/inventorynew/inventoryitems.htm",
                     type: "GET",
                     data: { tagName: request.term },
                     dataType: "json",
                     success: function(data) {
                      response($.map(data, function(v){
                           return  {
                                      label: v.name,
                                      value: v.name,
                                      itemCode:v.code,
                                     };  
                      }));
                     },
                     error: function (error) {
                         alert('error: ' + error);
                      }
                });              
             },
   select: function(e,ui) {
             //alert('select');
                //var sname = ev.value;
                //alert('val'+ui.item.value);
                //alert('itemCode:'+ui.item.itemCode);
                //('#itemCode').val(ui.item.id)  
                //event.preventDefault();
    // manually update the textbox and hidden field
    //$(this).val(ui.item.label);
    $("#searchCode").val(ui.item.itemCode);
            }
         });
     });
 
 </script>
	<div class="modal fade" data-backdrop="static" id="alreadyexistitem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item already exists, please select another.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter a valid Item Quantity Or Item Rate.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantityorrate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter a positive Item Quantity Or Item Rate.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="stockinitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnItemStockinId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:deleteStockinItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingstockinitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnitemstockinid" value=""> <input type="hidden" id="hdnstockinid" value=""> <input type="hidden" id="hdnstockininvitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:deleteExistingStockInItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itemupdatedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item successfully updated.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billnodmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter the bill number.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="tabledatadmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter atleast 1 item before create stockin.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="displayPOPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:viewPurchaseOrderPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billdateGreaterdmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Bill Date should not be greater than Stock In date.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<!-- new added -->
	
	<div class="modal fade" data-backdrop="static" id="stockindeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnStockinId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:stockInDelete()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="msgmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="msgspace"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>