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
<title>:. POS :: StockOut :.</title>
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
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



</head>
<body>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<input type="hidden" value="${sessionScope.itemAddFlag}" id="hdnAddItemFlag">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<!-- <script type="text/javascript">
		// When the document is ready
		$(document).ready(function() {
			alert("Response : "+ '${response}');
			
			if('${response}' != 'success'){
				//alert("Stock out is not possible due to insufficient Stock In and Current Stock is " + '${response}');
				inSufficientStockAlertModal();
			}

		});
	</script> -->
	<div class="content-wrapper">
		<div class="container-fluid">

			<!-- <div class="row">
                <div class="col-md-12">
                    <h4 class="page-head-line">Dashboard</h4>

                </div>

            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-success">
                        This is a simple admin template that can be used for your small project or may be large projects. This is free for personal and commercial use.
                    </div>
                </div>

            </div>-->
			<div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px;">
							<div class="item" style="margin-bottom: 10px;"></div>
							<div class="item item-sub-child" style="background: #72bb4f;">
								<a href="javascript:viewPurchaseOrder()">SIMPLE PURCHASE ORDER</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockIn()">SIMPLE STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="#">SIMPLE STOCK OUT</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-10 col-sm-10" style="background-color: #999;">
					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">
								STOCK OUT <a href="javascript:newStockOut()" class="btn btn-success" style="background: #78B626">NEW</a>
							</div>
						</div>
						<c:forEach items="${invStockOutDetailList}" var="invStockOut" varStatus="invStatus" begin="0" end="0">
							<div class="col-md-7 col-sm-7">
								<div class="inv-requisition">
									Date&nbsp;&nbsp; <input type="text" size="8" readonly value="${invStockOut.createdDate}" style="text-align: center;"> Time&nbsp;&nbsp; <input type="text" size="7" readonly value="${invStockOut.time}" style="text-align: center;"> Created By&nbsp;&nbsp; <input type="text" size="3" readonly value="${invStockOut.userId}" style="text-align: center;"> StockOut Id&nbsp;&nbsp; <input type="text" size="2" readonly value="${invStockOut.id}" style="text-align: center;">
								</div>
								<input type="hidden" value="${invStockOut.id}" id="hdnpoId">
							</div>
						</c:forEach>
						<c:if test="${empty invStockOutDetailList}">
							<div class="col-md-7 col-sm-7">
								<div class="inv-requisition">
									Date&nbsp;&nbsp; <input type="text" size="8" readonly value="${sessionScope.podate}" style="text-align: center;"> Time&nbsp;&nbsp; <input type="text" size="7" readonly value="00:00:00" style="text-align: center;"> Created By&nbsp;&nbsp; <input type="text" size="3" readonly value="${sessionScope.loginId}" style="text-align: center;"> StockOut Id&nbsp;&nbsp; <input type="text" size="2" readonly value="0" style="text-align: center;">
								</div>
							</div>
						</c:if>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-4 ">
							<div class="inv-requisition">
								Date&nbsp;&nbsp; <input type="text" name="selecteddate" id="poDate" size="8" readonly value="${sessionScope.podate}"> &nbsp;&nbsp; <a href="javascript:getStockOutByDate()" class="btn btn-success" style="background: #78B626">GO</a>
							</div>
						</div>
						<div class="col-md-4 col-sm-6">
							<div class="inv-requisition"></div>
						</div>
						<div class="col-md-4 col-sm-6">
							<div class="inv-requisition"></div>
						</div>
						<c:choose>
							<c:when test="${sessionScope.newStockOut == 'Y' }">
								<div class="col-md-5">
									<div class="inv-requisition">
										<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value=""> &nbsp;&nbsp; <a href="javascript:addNewStockOut()" class="btn btn-success" style="background: #78B626">ADD</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
						<div class="col-md-3 col-sm-4">
							<div style="background: #CCCCCC; overflow-y: auto; padding: 2px;">
								<div class="panel panel-default">
									<div class="panel-body" style="height: 260px;">
										<div class="table-responsive">
											<table class="table table-striped table-bordered">
												<thead>
													<tr style="background: #77C5EB;">
														<th>ID</th>
														<th>USER</th>
														<th>TIME</th>
													</tr>
												</thead>
												<c:if test="${! empty inventoryStockOutList}">
													<c:forEach items="${inventoryStockOutList}" var="inventoryStockOut" varStatus="odrStatus">
														<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${inventoryStockOut.id})">
															<td>${inventoryStockOut.id}</td>
															<td>${inventoryStockOut.userId}</td>
															<td>${inventoryStockOut.time}</td>
														</tr>
													</c:forEach>
												</c:if>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9 col-sm-8">
							<form:form modelAttribute="invStockOutForm" onsubmit="return checkValidate();" action="${pageContext.request.contextPath }/stockout/createNewStockOut.htm" method="post" role="form">
								<div style="background: #FFF; overflow-y: auto; padding: 2px;">
									<div class="panel panel-default">
										<div class="panel-body" style="height: 300px;">
											<div class="table-responsive">
												<table class="table table-striped table-bordered table-hover">
													<c:choose>
														<c:when test="${sessionScope.itemAddFlag == 'Y' }">
															<thead style="background: #999999">
																<tr>
																	<th>CODE</th>
																	<th>ITEM</th>
																	<th>QUANTITY</th>
																	<th>UNIT</th>
<!-- 																	<th>RATE</th> -->
<!-- 																	<th>TOTAL</th> -->
																	<th nowrap="nowrap">CURRENT STOCK</th>
																	<th>TO WHOM</th>
																</tr>
															</thead>
															<c:if test="${! empty invStockOutForm}">
																<c:forEach items="${invStockOutForm.invStockOutFBList}" var="stockOutFB" varStatus="status">
																	<tr>
																		<td><input name="invStockOutFBList[${status.index}].itemCode" id="iCode${status.index}" value="${stockOutFB.itemCode}" style="border: 0px solid #000000; background: #FFF;" size="3" readonly></td>
																		<td><input name="invStockOutFBList[${status.index}].itemName" id="iName${status.index}" value="${stockOutFB.itemName}" style="border: 0px solid #000000; background: #FFF;" readonly></td>
																		<td><input name="invStockOutFBList[${status.index}].itemQuantity" id="itemQty${status.index}" value="${stockOutFB.itemQuantity}" onkeyup="getPrice(${status.index},${stockOutFB.itemRate},'${stockOutFB.itemCode}')" onclick="javascript:clearItemValue(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: center;" size="6" maxlength="6"></td>
																		<td>
<%-- 																		<input name="invStockOutFBList[${status.index}].itemUnit" id="iUnit${status.index}" value="${stockOutFB.itemUnit}" style="border: 0px solid #000000; background: #FFF;" size="6" readonly> --%>
																		<select name="invStockOutFBList[${status.index}].metricUnitId" id="iUnit${status.index}" value="${stockOutFB.metricUnitId}" disabled="disabled" onchange="getMetricunitVal(this.value,${status.index},${stockOutFB.itemRate},'${stockOutFB.itemCode}');"  style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																																																
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${stockOutFB.metricUnitId==metricunit.id}">
																								    <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							     </c:if>
																							     <c:if test="${stockOutFB.metricUnitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option>
																								 </c:if>
																								</c:forEach>
																								
																							</c:if>
																					</select>
																		</td>
																		<input type="hidden" name="invStockOutFBList[${status.index}].itemRate" id="iRate${status.index}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockOutFB.itemRate}" />' style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly>
																		<input type="hidden" name="invStockOutFBList[${status.index}].totalPrice" id="iTotalRate${status.index}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockOutFB.totalPrice}" />' style="border: 0px solid #000000; background: #FFF; text-align: right;" size="8" readonly>
<%-- 																		<td><input type="hidden" name="invStockOutFBList[${status.index}].itemRate" id="iRate${status.index}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockOutFB.itemRate}" />' style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly></td> --%>
<%-- 																		<td><input type="hidden" name="invStockOutFBList[${status.index}].totalPrice" id="iTotalRate${status.index}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockOutFB.totalPrice}" />' style="border: 0px solid #000000; background: #FFF; text-align: right;" size="8" readonly></td> --%>
																		<td><input name="invStockOutFBList[${status.index}].currentStock" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockOutFB.currentStock}" />' style="border: 0px solid #000000; background: #FFF; text-align: center;" size="8" readonly></td>
																		<td><select id="imenuCategoryName${status.index}" name="invStockOutFBList[${status.index}].menuCategoryName" onchange="getToWhom(this.value,${status.index},${stockOutFB.itemRate},'${stockOutFB.itemCode}');">
																				<c:forEach items="${menuCategoryList}" var="menuCategory">
<%-- 																					<option value="${menuCategory.menuCategoryName}">${menuCategory.menuCategoryName}</option> --%>
																					<c:if test="${stockOutFB.menuCategoryName==menuCategory.menuCategoryName}">
																								    <option value="${menuCategory.menuCategoryName}" selected>${menuCategory.menuCategoryName}</option>
																							     </c:if>
																							     <c:if test="${stockOutFB.menuCategoryName!=menuCategory.menuCategoryName}">
																									<option value="${menuCategory.menuCategoryName}" >${menuCategory.menuCategoryName}</option>
																								 </c:if>
																				</c:forEach>
																		</select></td>
																		<td><a href="javascript:deleteStockOutItem('${stockOutFB.itemCode}',${stockOutFB.totalPrice})"><img alt="" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"> </a></td>
																	</tr>
																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<thead style="background: #999999">
																<tr>
																	<th>CODE</th>
																	<th>ITEM</th>
																	<th>QUANTITY</th>
																	<th>UNIT</th>
<!-- 																	<th>RATE</th> -->
<!-- 																	<th>TOTAL</th> -->
																	<th>TO WHOM</th>
																</tr>
															</thead>
															<c:if test="${! empty inventoryStockOutItemList}">
																<c:forEach items="${inventoryStockOutItemList}" var="inventoryStockOutItem" varStatus="odrStatus">
																	<tr>
																		<td>${inventoryStockOutItem.inventoryItems.code}</td>
																		<td>${inventoryStockOutItem.inventoryItems.name}</td>
																		<td align="right">${inventoryStockOutItem.itemQuantity}</td>
																		<td>
<%-- 																		${inventoryStockOutItem.inventoryItems.unit} --%>
																		<select id="${inventoryStockOutItem.unit.id}" value="${inventoryStockOutItem.unit.id}" disabled="disabled"  style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${inventoryStockOutItem.unit.id==metricunit.id}">
																								     <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							       </c:if>
																							       <c:if test="${inventoryStockOutItem.unit.id!=metricunit.id}">
																									 <option value="${metricunit.id}" >${metricunit.unit}</option>
																									</c:if>
																								</c:forEach>
																							</c:if>
																					</select>
																		</td>
<%-- 																		<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${inventoryStockOutItem.inventoryItems.rate}" /></td> --%>
<%-- 																		<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${inventoryStockOutItem.totalPrice}" /></td> --%>
																		<td>${inventoryStockOutItem.toWhom}</td>
																	</tr>
																</c:forEach>
															</c:if>
														</c:otherwise>
													</c:choose>
												</table>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-8 col-sm-8"></div>
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-6">
									<c:choose>
										<c:when test="${sessionScope.newStockOut == 'Y' && sessionScope.itemAddFlag == 'Y' }">
											<font style="font-weight: bold;visibility: hidden;">GRAND TOTAL:</font>
											<input type="hidden" size="8" id="gdTotal" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${sessionScope.grandTotalItemPrice }"/>' style="text-align: right;" readonly="readonly">
											<input type="submit" value="Save" class="btn btn-success" style="background: #78B626; margin-top: 3px;">
										</c:when>
										<c:otherwise>
											<font style="font-weight: bold;visibility: hidden;">GRAND TOTAL:</font>
											<input type="hidden" size="8" id="gdTotal" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${sessionScope.grandTotalItemPrice }"/>' readonly="readonly" style="text-align: right;">
										</c:otherwise>
									</c:choose>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>

	function enteritemQuantityModal()
{
	$('#enteritemquantity').modal('show');
}
function zeroitemquantityModal()
{
	$('#zeroitemquantity').modal('show');
}
function positiveitemquantityModal()
{
	$('#positiveitemquantity').modal('show');
}
function validitemquantityModal()
{
	$('#validitemquantity').modal('show');
}
function searchitemcorrectlyModal()
{
	$('#searchitemcorrectly').modal('show');
}
function alreadyexistitemModal()
{
	$('#alreadyexistitem').modal('show');
}
function toWhomModal()
{
	$('#toWhom').modal('show');
}
function quantityFloatValidateModal()
{
	$('#quantityFloatValidate').modal('show');
}
function inSufficientStockAlertModal()
{
	$('#inSufficientStockInAlert').modal('show');
}
function displayPOPageModal()
{
	$('#displayPOPage').modal('show');
}

function displayStockInPageModal()
{
	$('#displayStockInPage').modal('show');
}

function displayStockOutPageModal()
{
	$('#displayStockOutPage').modal('show');
}

function displayNewStockOutModal()
{
	$('#selectNewStockOut').modal('show');
}

function displayStockOutByDateModal()
{
	$('#selectStockOutbyDate').modal('show');
}//confirmNewlyAddedItem

function displayStockOutByIdModal()
{
	$('#selectStockOutbyId').modal('show');
}

function confirmNewlyAddedItemModal()
{
	$('#confirmNewlyAddedItem').modal('show');
}

function postDateAlertModal()
{
	$('#postDateAlert').modal('show');
}
	</script>

	<script type="text/javascript">
function viewPurchaseOrder() {
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag == "Y") {
		displayPOPageModal();
	} else {
		location.href = '${pageContext.request.contextPath }/inventory/viewinventory.htm';
	}
}

function viewPurchaseOrderPage() {
	location.href = '${pageContext.request.contextPath }/inventory/viewinventory.htm';
}

function viewStockIn() {
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag == "Y") {
		displayStockInPageModal();
	} else {
		location.href = '${pageContext.request.contextPath }/stockin/viewstockin.htm';
	}
}

function viewStockInPage() {
	location.href = '${pageContext.request.contextPath }/stockin/viewstockin.htm';
}

function viewStockOut() {
	var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
	if (itemAddFlag == "Y") {
		displayStockOutPageModal();
	} else {
		location.href = '${pageContext.request.contextPath }/stockout/viewstockout.htm';
	}
}

function viewStockOutPage() {
	location.href = '${pageContext.request.contextPath }/stockout/viewstockout.htm';
}
</script>
	<!-----modal---->
	<div class="modal fade" data-backdrop="static" id="zeroitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Quantity can not be zero</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="enteritemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter Item Quantity.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="positiveitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter a positive Item Quantity.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter a valid Item Quantity.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="toWhom" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please fill up the toWhom Box.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="searchitemcorrectly" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please search an Item correctly</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="quantityFloatValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Quantity cannot be fractioned.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="inSufficientStockInAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Stock out is not possible due to insufficient Stock In and Current Stock is : ${response }</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
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
	<div class="modal fade" data-backdrop="static" id="displayStockOutPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:viewStockOutPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectNewStockOut" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:getNewStockOut()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectStockOutbyDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:stockOutByDate()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectStockOutbyId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
					<input type="hidden" id="hdnStockOutId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:getStockOutById()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="confirmNewlyAddedItem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Are you sure?</div>
					<input type="hidden" id="hdnItemCode" value=""> <input type="hidden" id="hdnTotalPrice" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:removeNewlyAddedItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="postDateAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Sorry, you can not procced to post date.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
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
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
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
	<script src="${pageContext.request.contextPath}/assets/js/stockoutScript.js"></script>
	<script type="text/javascript">
		// When the document is ready
		$(document).ready(function() {
			//alert("Response : "+ '${response}');
			
			if('${response}' != 'success'){
				//alert("Stock out is not possible due to insufficient Stock In and Current Stock is " + '${response}');
				inSufficientStockAlertModal();
			}

		});
	</script>
	<script type="text/javascript">
		// When the document is ready
		$(document).ready(function() {
			$('#poDate').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true
			});

		});
	</script>
	<script type="text/javascript">
 
     $(function() {
         $("#search").autocomplete({
             source: function(request, response) {
                 $.ajax({
                     url: "${pageContext.request.contextPath}/inventory/inventoryitems.htm",
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
	<script type="text/javascript">
var BASE_URL="${pageContext.request.contextPath}";
//var jsArray = [];
var jsArray = 
    [
        <c:forEach items="${invStockOutForm.invStockOutFBList}" var="arr" 
         varStatus="status">
          "${arr}"<c:if test="${not status.last}">,</c:if>
        </c:forEach>
    ];
</script>
</body>
</html>
