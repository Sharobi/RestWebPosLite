<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>:. POS :: Inventory :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<style type="text/css">
    .selected{
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
						<div style="padding: 8px; background-color: #fff; ">
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="#">SIMPLE PURCHASE ORDER</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()">SIMPLE STOCK IN</a>
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
					<input type="hidden" id="selectedpoid" value="0">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								PURCHASE ORDER <a href="javascript:newPurchaseOrder()" class="btn btn-success" style="background: #78B626">New Requisition</a>
							</div>
						</div>
						<div class="col-md-7 col-sm-7">
							<div class="inv-requisition">
								Date&nbsp;&nbsp;<input type="text" size="8" id="invCrtDate" readonly value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"> Created By&nbsp;&nbsp;<input type="text" id="invCrtBy" size="2" readonly value="${sessionScope.loggedinUser.contactNo}"> PO Id&nbsp;&nbsp;<input type="text" size="2" id="invPOId" readonly value="0">
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-2 ">
							<div class="inv-requisition">
								Date&nbsp;&nbsp;<input type="text" name="selecteddate" id="poDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'>&nbsp;&nbsp;<a href="javascript:getPOByDate()" class="btn btn-success" style="background: #78B626">GO</a>
							</div>
						</div>
						<div class="col-md-3" id="vendorDiv">
							<div class="inv-requisition">
								<spring:message code="stockinnew.jsp.Vendor" text="Vendor" />:
								  <select id="selectedPovendorId" name="vendorId">
									 <c:forEach items="${vendorList}" var="vendor">
										<option value="${vendor.id}">${vendor.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-3 col-sm-6">
							<div class="inv-requisition">
								Approved&nbsp;&nbsp; <select name="select1" id="select1" onchange="getApprovedBy(this.value)">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select> By&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" id="poapprovedbuttion" style="background: #78B626">OK</a>
							</div>
						</div>
						<div class="col-md-4 col-sm-6">
							<div class="inv-requisition">
								PO&nbsp;&nbsp; <select name="select2" id="select2" onchange="getPoBy(this.value)">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select> By&nbsp;&nbsp;<input type="text" id="poId" size="4" readonly> <a href="javascript:poByCall()" class="btn btn-success" id="pocreatedbutton" style="background: #78B626">CREATE</a>
							</div>
						</div>
						<div class="col-md-5" id="serachDiv">
							<div class="inv-requisition">
								<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewPoItem()" id="addnewpoitem" class="btn btn-success" style="background: #78B626">ADD</a>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-4">
							<div style="overflow-y: auto;">
								<div class="panel panel-default">
									<div class="panel-body" style="max-height: 200px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered">
											<thead>
												<tr style="background: #77C5EB;">
														<th>ID</th>
														<th>NAME</th>
														<th>PO STATUS</th>
													</tr>
												</thead>
												<c:if test="${! empty purchaseOrderList}">
													<c:forEach items="${purchaseOrderList}" var="purchaseOrder" varStatus="odrStatus">
														<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${purchaseOrder.id})" class="selected-po-row">
															<td>${purchaseOrder.id}</td>
															<td>${purchaseOrder.userId}</td>
															<td id="postatus_${purchaseOrder.id}">${purchaseOrder.poStatus}</td>
														</tr>
														<input type="hidden" value="${purchaseOrder.userId}" id="hdnuserId">
														<input type="hidden" value="${purchaseOrderList[0].id}" id="hdpoId">
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
											<table class="table table-striped table-bordered table-hover" style="" id="poItemTable">
												<thead style="background: #999999;">
													<tr>
														<th>ID</th>
														<th>ITEM</th>
														<th nowrap="nowrap">OLD STOCK</th>
														<!-- 														<th nowrap="nowrap">REQ STOCK</th> -->
														<th>QUANTITY</th>
														<th>UNIT</th>
														<th>RATE</th>
														<th style="display:none;">SHIPPING</th>
														<th>TAX</th>
														<th>TOTAL</th>
														<th style="display:none;">VENDOR</th>
														<th>ACTION</th>
													</tr>
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
							Misc Charges:<input type="text" size="10" id="misChargeId" onkeyup="javascript:calculateGrandTotal()" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;" onkeydown="numcheck(event);"> &nbsp; <a href="javascript:poOrderPrint()" class="btn btn-success hide" style="background: #78B626; margin-top: 3px;">PRINT</a>
							<spring:message code="inventorynew.jsp.totaltax" text="Total Tax" />:<input readonly type="text" size="5" id="totTaxAmt"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="0.00"/>' style="text-align: right;"> &nbsp;
						</div>
						<div class="col-md-4 col-sm-4"></div>
						<div class="col-md-6">
							<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="grandtotalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="0.00"/>' style="text-align: right;" readonly="readonly"> &nbsp;
							<!--  <a href="javascript:poOrderSave()" id="poOrderSave" class="btn btn-success" style="background: #78B626; margin-top: 3px;">Save</a> -->
						     <span id="btnspan"></span>
						     <a href="javascript:poOrderDeleteModalOpen()" id="poOrderDelete" class="btn btn-success" style="background: #78B626; margin-top: 3px;"><spring:message code="inventorynew.jsp.Delete" text="Delete" /></a>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"> </script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/invNewScript.js"></script>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
		// When the document is ready
 		$(document).ready(function() {
 			var poid=$("#hdpoId").val();
 			console.log("poid="+poid);
 			if(undefined!=poid){
 				rowClicked(poid);
 			}
 			else{
 				setActiveButton();//new
 			}
 			$('#poDate').datepicker({
 				format : "yyyy-mm-dd",
//  				startDate: '-0d',
 				endDate: '+0d',
 				autoclose : true
 			});
 			setActiveButton();//new
 		});
 		$('.selected-po-row').on('click',function(){
  		   $(this).parent().find('.selected-po-row').removeClass('selected');
  		  $(this).addClass('selected');
  		  });
</script>
	<script type="text/javascript">
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
                         console.log('error: ' + error);
                      }
                });              
             },
               select: function(e,ui) {
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

	<div class="modal fade" data-backdrop="static" id="poitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnItemPoId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:deletePoItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingpoitemdeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnitempoid" value=""> <input type="hidden" id="hdnpoid" value=""> <input type="hidden" id="hdnpoinvitemid" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:deleteExistingPoItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="poapprovedmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				    <input type="hidden" id="approvedpoid" value="0">
					<div style="text-align: center; font-size: 20px;">PO successfully approved.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="javascript:poApprovedModalClose();">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="poCreated" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">PO Created</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<input type="hidden" id="createdpoid" value="0">
					<div style="text-align: center; font-size: 20px;">PO Created.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="javascript:poCreatedModalClose()">OK</button>
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
	<div class="modal fade" data-backdrop="static" id="savepurchaseorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please save the Purchase Order first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="printSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Confirmation</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Success</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="displayStockInPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:viewStockInPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<!-- new modal -->
	<div class="modal fade" data-backdrop="static" id="itemquantityzero" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Itemquantitycantbezeroorblank" text="Item Quantity can not be zero or blank" />.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="existingrequisitiondeletemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;"><spring:message code="inventorynew.jsp.Areyousure" text="Are you sure" />?</div>					
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:poOrderDelete();" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="inventorynew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>