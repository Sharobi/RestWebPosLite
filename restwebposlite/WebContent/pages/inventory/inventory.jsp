<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<input type="hidden" value="${sessionScope.approveStatus}" id="hdnApprove">
	<input type="hidden" value="${sessionScope.addItemFlag}" id="hdnAddItemFlag">
	<input type="hidden" value="${sessionScope.itemListSize}" id="hdnItemListSize">
	<input type="hidden" value="" id="hdnPageAlertFlag">
	<input type="hidden" value="" id="hdntotalItemPrice">
	<%-- <c:set var="poStatus" value="<%=request.getAttribute("poStatus") %>"/> --%>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2 col-sm-2">
					<div class="menu-category">
						<div style="padding: 8px;">
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
						</div>
					</div>

				</div>

				<div class="col-md-10 col-sm-10" style="background-color: #999;">

					<div class="col-md-12 col-sm-12">
						<div class="col-md-5 col-sm-5">
							<div class="inv-requisition-0">

								PURCHASE ORDER <a href="javascript:newPurchaseOrder()" class="btn btn-success" style="background: #78B626">New Requisition</a>

							</div>
						</div>
						<c:forEach items="${invPurchaseOrderList}" var="invPurchaseOrder" varStatus="invStatus" begin="0" end="0">
							<div class="col-md-7 col-sm-7">
								<div class="inv-requisition">
									Date&nbsp;&nbsp;<input type="text" id="invCrtDate" size="8" readonly value="${invPurchaseOrder.createdDate}"> Created By&nbsp;&nbsp;<input type="text" id="invCrtBy" size="2" readonly value="${invPurchaseOrder.createdBy}"> PO Id&nbsp;&nbsp;<input type="text" id="invPoId" size="2" readonly value="${invPurchaseOrder.id}">
								</div>
								<input type="hidden" value="${invPurchaseOrder.id}" id="hdnInvAutoId"> <input type="hidden" value="${invPurchaseOrder.approved}" id="hdnAppvId">
							</div>
						</c:forEach>
						<c:if test="${ empty invPurchaseOrderList}">
							<div class="col-md-7 col-sm-7">
								<div class="inv-requisition">
									Date&nbsp;&nbsp;<input type="text" size="8" readonly value="${podate}"> Created By&nbsp;&nbsp;<input type="text" size="2" readonly value="${sessionScope.loginId}"> PO Id&nbsp;&nbsp;<input type="text" size="2" readonly value="0">
								</div>
							</div>
						</c:if>
					</div>

					<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">

						<div class="col-md-4 ">
							<div class="inv-requisition">
								<c:if test="${empty podate}">
									Date&nbsp;&nbsp;<input type="text" name="selecteddate" id="poDate" size="8" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>'>&nbsp;&nbsp; <a href="javascript:getPOByDate()" class="btn btn-success" style="background: #78B626">GO</a>
								</c:if>
								<c:if test="${! empty podate}">
									Date&nbsp;&nbsp;<input type="text" name="selecteddate" id="poDate" size="8" readonly value="${podate}">&nbsp;&nbsp; <a href="javascript:getPOByDate()" class="btn btn-success" style="background: #78B626">GO</a>
								</c:if>
							</div>
						</div>

						<c:choose>
							<c:when test="${sessionScope.poStatus != 'Y' }">
								<c:choose>
									<c:when test="${sessionScope.approveStatus != 'Y' }">
										<div class="col-md-4 col-sm-6">
											<div class="inv-requisition">
												Approved&nbsp;&nbsp;<select name="select1" id="select1" onchange="getApprovedBy(this.value)">
													<option value="N">N</option>
													<option value="Y">Y</option>
												</select> By&nbsp;&nbsp;<input type="text" id="appvId" size="4" readonly> <a href="javascript:approveCall()" class="btn btn-success" style="background: #78B626">APPROVE</a>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-md-4 col-sm-6">
											<c:forEach items="${invPurchaseOrderList}" var="invPurchaseOrder" varStatus="invStatus" begin="0" end="0">
												<div class="inv-requisition">
													Approved&nbsp;&nbsp;<select name="select1" id="select1" onchange="getApprovedBy(this.value)">
														<option value="Y">Y</option>
														<option value="N">N</option>
													</select> By&nbsp;&nbsp;<input type="text" id="appvId" size="4" value="${invPurchaseOrder.createdBy}" readonly> <a href="javascript:approveCall()" class="btn btn-success" style="background: orange none repeat scroll 0% 0%;">APPROVE</a>
												</div>
											</c:forEach>
										</div>
									</c:otherwise>
								</c:choose>
								<div class="col-md-4 col-sm-6">
									<div class="inv-requisition">
										PO&nbsp;&nbsp;<select name="select2" id="select2" onchange="getPoBy(this.value)">
											<option value="N">N</option>
											<option value="Y">Y</option>
										</select> By&nbsp;&nbsp;<input type="text" id="poId" size="4" readonly> <a href="javascript:poByCall()" class="btn btn-success" style="background: #78B626">CREATE</a>
										<%-- <c:out value="${sessionScope.poStatus}"></c:out>
								<c:out value="${sessionScope.newRequisition}"></c:out> --%>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${invPurchaseOrderList}" var="invPurchaseOrder" varStatus="invStatus" begin="0" end="0">
									<div class="col-md-4 col-sm-6">
										<div class="inv-requisition">
											Approved&nbsp;&nbsp;<select name="select1" id="select1" disabled="disabled">
												<option value="Y">Y</option>
												<option value="N">N</option>
											</select> By&nbsp;&nbsp;<input type="text" id="appvId" size="4" value="${invPurchaseOrder.createdBy}" readonly>
										</div>
									</div>
									<div class="col-md-4 col-sm-6">
										<div class="inv-requisition">
											PO&nbsp;&nbsp;<select name="select2" id="select2" disabled="disabled">
												<option value="Y">Y</option>
												<option value="N">N</option>
											</select> By&nbsp;&nbsp;<input type="text" id="poId" size="4" value="${invPurchaseOrder.createdBy}" readonly>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${sessionScope.poStatus != 'Y' && sessionScope.searchBoxDisplay == 'Y'}">
								<div class="col-md-5" id="serachDiv">
									<div class="inv-requisition">
										<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewPoItem()" class="btn btn-success" style="background: #78B626">ADD</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>

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

														<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${purchaseOrder.id})">
															<td>${purchaseOrder.id}</td>
															<td>${purchaseOrder.userId}</td>
															<td>${purchaseOrder.poStatus}</td>
														</tr>
														<input type="hidden" value="${purchaseOrder.userId}" id="hdnuserId">
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
													<tr >
														<th>ID</th>
														<th>ITEM</th>
														<th nowrap="nowrap">OLD STOCK</th>
														<!-- 														<th nowrap="nowrap">REQ STOCK</th> -->
														<th>QUANTITY</th>
														<th>UNIT</th>
														<th>RATE</th>
														<th>SHIPPING</th>
														<th>TOTAL</th>
														<th>VENDOR</th>
													</tr>
												</thead>
												<form:form modelAttribute="purchaseOrderForm" onsubmit="return checkValidate();" action="${pageContext.request.contextPath }/inventory/createNewPurchaseOrder.htm" method="post" role="form">
													<c:choose>
														<c:when test="${sessionScope.addItemFlag != 'Y' }">
															<c:if test="${! empty invPurchaseOrderItemList}">
																<c:forEach items="${invPurchaseOrderItemList}" var="invPurchaseOrderItem" varStatus="invStatus">
																	<tr>
																		<input type="hidden" value="${invPurchaseOrderItem.id}" id="hdnPurchaseId" />
																		<input type="hidden" value="${invPurchaseOrderItem.inventoryItems.name}" id="hdnItemName" />
																		<input type="hidden" value="${invPurchaseOrderItem.itemTotalPrice}" id="hdnInvTP" />
																		<input type="hidden" value="${invPurchaseOrderItem.itemQuantity}" id="hdnQty${invPurchaseOrderItem.id}" />
																		<input type="hidden" value="${invPurchaseOrderItem.rate}" id="hdnItemRate${invPurchaseOrderItem.id}" />
																		<input type="hidden" id="hdndropdownId" name="" />
																		<input type="hidden" value="${invPurchaseOrderItem.unitId}" id="hdnMetricUnitId" />
																		<c:choose>
																			<c:when test="${sessionScope.poStatus != 'Y' }">
																				<tr>
																					<td id="tdCode${invStatus.index}">${invPurchaseOrderItem.inventoryItems.code}</td>
																					<td>${invPurchaseOrderItem.inventoryItems.name}</td>
																					<c:choose>
																						<c:when test="${invPurchaseOrderItem.oldStock == '0.0' || invPurchaseOrderItem.oldStock == 'Not Available'}">
																							<td id="tdStock">Not Available</td>
																						</c:when>
																						<c:otherwise>
																							<td id="tdStock" align="right"><fmt:formatNumber  type="number" value="${invPurchaseOrderItem.oldStock}" maxFractionDigits="2" /></td>
																						</c:otherwise>
																					</c:choose>
																					<%-- 																					<td id="tdReqQty" align="right">${invPurchaseOrderItem.requiredQuantity}</td> --%>
																					<td id="tdItemQty"><input type="text" id="itmQty${invPurchaseOrderItem.id}" value="${invPurchaseOrderItem.itemQuantity}" size="5" onkeyup="getTotalPrice(${invPurchaseOrderItem.id},${invPurchaseOrderItem.rate})" onclick="javascript:clearValue(${invPurchaseOrderItem.id})" style="border: 0px solid #000000; background: #FFF; text-align: center;" maxlength="6"></td>
																					<td id="tdUnit">
																						<%-- 																					${invPurchaseOrderItem.inventoryItems.unit} --%> 
																						<select id="tdUnit" name="${invPurchaseOrderItem.unitId}" disabled="disabled" style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																							
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								<c:if test="${invPurchaseOrderItem.unitId==metricunit.id}">
																								<option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							</c:if>
																							<c:if test="${invPurchaseOrderItem.unitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option></c:if>
																								</c:forEach></c:if>
																					</select>
																					</td>
																					<td id="tdRate" align="right"><input type="text" id="tdItmRate${invPurchaseOrderItem.id}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invPurchaseOrderItem.rate}" />' size="5" onkeyup="getTotalPriceForChangeRate(${invPurchaseOrderItem.id},${invPurchaseOrderItem.itemQuantity})" onclick="javascript:clearItemValue(${invPurchaseOrderItem.id})" style="border: 0px solid #000000; background: #FFF; text-align: center;" maxlength="6" ></td>
																					<td id="tdShipCrge${invPurchaseOrderItem.id}" align="right"><fmt:formatNumber type="number" minFractionDigits="2" groupingUsed="false" maxFractionDigits="2" value="${invPurchaseOrderItem.shippingCharge}" /></td>
																					<td id="tdItemtp${invPurchaseOrderItem.id}" align="right"><fmt:formatNumber type="number" minFractionDigits="2" groupingUsed="false" maxFractionDigits="2" value="${invPurchaseOrderItem.itemTotalPrice}" /></td>
																					<td>${invPurchaseOrderItem.vendorName}</td>
																					<td id="${invStatus.index}"><a href="javascript:updatePoItem(${invPurchaseOrderItem.id})" class="btn btn-success" style="background: #78B626" id="update${invPurchaseOrderItem.id}">Update</a></td>
																					<td><a href="javascript:deleteEachPoItem(${invPurchaseOrderItem.id})"><img alt="" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"> </a></td>
																				</tr>
																			</c:when>
																			<c:otherwise>
																				<tr>
																					<td>${invPurchaseOrderItem.inventoryItems.code}</td>
																					<td>${invPurchaseOrderItem.inventoryItems.name}</td>
																					<c:choose>
																						<c:when test="${invPurchaseOrderItem.oldStock == '0.0' || invPurchaseOrderItem.oldStock == 'Not Available'}">
																							<td id="tdStock">Not Available</td>
																						</c:when>
																						<c:otherwise>
																							<td id="tdStock" align="right"><fmt:formatNumber  type="number" value="${invPurchaseOrderItem.oldStock}" maxFractionDigits="2" /></td>
																						</c:otherwise>
																					</c:choose>
																					<%-- 																					<td align="right">${invPurchaseOrderItem.requiredQuantity}</td> --%>
																					<td align="right">${invPurchaseOrderItem.itemQuantity}</td>
																					<td>
<%-- 																					${invPurchaseOrderItem.inventoryItems.unit} --%>
																	<select id="${invPurchaseOrderItem.unitId}" name="${invPurchaseOrderItem.unitId}" disabled="disabled"  style="margin-bottom: 5px; color: #222222; border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																							
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								<c:if test="${invPurchaseOrderItem.unitId==metricunit.id}">
																								<option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							</c:if>
																							<c:if test="${invPurchaseOrderItem.unitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option></c:if>
																								</c:forEach></c:if>
																					</select>
																					</td>
																					<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invPurchaseOrderItem.rate}" /></td>
																					<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invPurchaseOrderItem.shippingCharge}" /></td>
																					<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false"  value="${invPurchaseOrderItem.itemTotalPrice}" /></td>
																					<td>${invPurchaseOrderItem.vendorName}</td>
																				</tr>
																			</c:otherwise>
																		</c:choose>
																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${!empty purchaseOrderForm }">
																<c:forEach items="${ purchaseOrderForm.purchaseOrderFbList}" var="pOrderFB" varStatus="status">
																	<tr>
																		<td><input name="purchaseOrderFbList[${status.index}].itemCode" id="iCode${status.index}" value="${pOrderFB.itemCode}" style="border: 0px solid #000000; background: #FFF;" size="3" readonly></td>
																		<c:choose>
																			<c:when test="${pOrderFB.stockFlag == 'Y' && pOrderFB.approveFlag == 'N'}">
																				<td style="color: red; font-weight: bold;" id="tdName"><input name="purchaseOrderFbList[${status.index}].itemName" value="${pOrderFB.itemName}" style="color: red; font: bold; border: 0px solid #000000; background: #FFF;" readonly multiple></td>
																			</c:when>
																			<c:otherwise>
																				<td><input name="purchaseOrderFbList[${status.index}].itemName" value="${pOrderFB.itemName}" style="border: 0px solid #000000; background: #FFF;" readonly multiple></td>
																			</c:otherwise>
																		</c:choose>
																		<td><input name="purchaseOrderFbList[${status.index}].oldStock" value='<fmt:formatNumber  type="number" value="${pOrderFB.oldStock}" maxFractionDigits="2" minFractionDigits="2" />' style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly></td>
																		<%-- 																		<td><input name="purchaseOrderFbList[${status.index}].requiredQuantity" value="${pOrderFB.requiredQuantity}" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly></td> --%>
																		<input type="hidden" name="purchaseOrderFbList[${status.index}].requiredQuantity" value="${pOrderFB.requiredQuantity}" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly>
																		<c:choose>
																			<c:when test="${pOrderFB.approveFlag == 'Y'}">
																				<td><input name="purchaseOrderFbList[${status.index}].itemQuantity" value="${pOrderFB.itemQuantity}" id="itemQty${status.index}" readonly style="border: 0px solid #000000; background: #FFF; text-align: center;" size="6"></td>
																			</c:when>
																			<c:otherwise>
																				<td><input name="purchaseOrderFbList[${status.index}].itemQuantity" value="${pOrderFB.itemQuantity}" id="itemQty${status.index}" onkeyup="getItemTotalPrice(${status.index},${pOrderFB.itemQuantity},'${pOrderFB.itemCode}')" onclick="javascript:clearItemQuantity(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: center;" size="6" maxlength="6"></td>
																			</c:otherwise>
																		</c:choose>

																		<td>
																			<%-- 																		<input name="purchaseOrderFbList[${status.index}].itemUnit" value="${pOrderFB.itemUnit}" style="border: 0px solid #000000; background: #FFF;" size="5" readonly> --%> 
																			<select  name="purchaseOrderFbList[${status.index}].metricUnitId" id="iUnit${status.index}" disabled="disabled" onchange="getMetricunitVal(this.value,${status.index},${pOrderFB.itemQuantity},'${pOrderFB.itemCode}');" style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																				<c:if test="${! empty metricUnitList}">
																					<c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${pOrderFB.metricUnitId==metricunit.id}">
																								    <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							     </c:if>
																							     <c:if test="${pOrderFB.metricUnitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option>
																								 </c:if>
																								</c:forEach>
																					</c:if>
																		</select>
																		
																		</td>
<%-- 															</c:if> --%>
															<c:choose>
                                                                 <c:when test="${pOrderFB.approveFlag == 'Y'}">
												                 <td><input name="purchaseOrderFbList[${status.index}].itemRate" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${pOrderFB.itemRate}" />' id="iRate${status.index}" onkeyup="getItemRate(${status.index},'${pOrderFB.itemCode}')" onclick="javascript:clearItemRate(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" disabled="disabled"></td>
												                 </c:when>
													             <c:otherwise>
													             <td><input name="purchaseOrderFbList[${status.index}].itemRate" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${pOrderFB.itemRate}" />' id="iRate${status.index}" onkeyup="getItemRate(${status.index},'${pOrderFB.itemCode}')" onclick="javascript:clearItemRate(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" ></td>
													             </c:otherwise>
													        </c:choose>
															
															<td><input name="purchaseOrderFbList[${status.index}].shippingCharge" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${pOrderFB.shippingCharge}" />' id="sCharge${status.index}" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6" readonly></td>
															<td><input class="itemtotalprice" name="purchaseOrderFbList[${status.index}].totalPrice" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${pOrderFB.totalPrice}" />' id="tprice${status.index}" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="10" readonly></td>
															<c:choose>
																<c:when test="${pOrderFB.approveFlag == 'Y'}">
																	<td>
																	<select id="vendorId" name="purchaseOrderFbList[${status.index}].vendorId" disabled="disabled" style="border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																	<c:forEach items="${vendorList}" var="vendor">
																				<c:if test="${pOrderFB.vendorId==vendor.id}">
																								    <option value="${vendor.id}" selected>${vendor.name}</option>
																							     </c:if>
																							     <c:if test="${pOrderFB.vendorId!=vendor.id}">
																									<option value="${vendor.id}" >${vendor.name}</option>
																								 </c:if>
																	</c:forEach>
																	</select>
																	</td>
																</c:when>
																<c:otherwise>
																	<td>
																	<select id="vendorId" name="purchaseOrderFbList[${status.index}].vendorId" disabled="disabled" style="border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																			<c:forEach items="${vendorList}" var="vendor">
																				<c:if test="${pOrderFB.vendorId==vendor.id}">
																								    <option value="${vendor.id}" selected>${vendor.name}</option>
																							     </c:if>
																							     <c:if test="${pOrderFB.vendorId!=vendor.id}">
																									<option value="${vendor.id}" >${vendor.name}</option>
																								 </c:if>
																			</c:forEach>
																	</select>
																	</td>
																</c:otherwise>
															</c:choose>
															<td><a href="javascript:removeItem('${pOrderFB.itemCode}',${pOrderFB.totalPrice})"><img alt="" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"> </a></td>
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

							<c:choose>
								<c:when test="${sessionScope.poStatus != 'Y' }">
									<c:choose>
										<c:when test="${sessionScope.addItemFlag != 'Y' }">
											<div class="col-md-8 col-sm-8">
												Misc Charges:<input type="text" id="misChargeId" size="10" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' style="text-align: right;" readonly="readonly"> <a href="javascript:poOrderPrint()" class="btn btn-success" style="background: #78B626; margin-top: 3px;">PRINT</a>
											</div>

											<div class="col-md-4 col-sm-4"></div>
											<div class="col-md-6">
												<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="totalId" size="10" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${grandTotalItemPrice }"/>' style="text-align: right;" readonly="readonly"><input type="submit" disabled="disabled" value="Save" class="btn btn-success" style="background: #78B626; margin-top: 3px;">
											</div>
										</c:when>
										<c:otherwise>
											<div class="col-md-8 col-sm-8">
												Misc Charges:<input type="text" size="10" id="misChargeId" name="misChargeId" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' onclick="javascript:clearMiscValue(this.id)" onkeyup="getTotalByMiscValue()" style="text-align: right;"> <a href="javascript:poOrderPrint()" class="btn btn-success" style="background: #78B626; margin-top: 3px;">PRINT</a>
											</div>

											<div class="col-md-4 col-sm-4"></div>
											<div class="col-md-6">
												<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="totalId" name="totalId" size="10" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${grandTotalItemPrice }"/>' style="text-align: right;" readonly="readonly"> <input type="submit" value="Save" class="btn btn-success" style="background: #78B626; margin-top: 3px;">
											</div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div class="col-md-8 col-sm-8">
										Misc Charges:<input type="text" size="10" id="misChargeId" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' style="text-align: right;" readonly="readonly"> <a href="javascript:poOrderPrint()" class="btn btn-success" style="background: #78B626; margin-top: 3px;">PRINT</a>
									</div>

									<div class="col-md-4 col-sm-4"></div>
									<div class="col-md-6">
										<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" id="totalId" name="totalId" size="10" value='<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${grandTotalItemPrice }"/>' style="text-align: right;" readonly="readonly">
									</div>
								</c:otherwise>
							</c:choose>
							</form:form>
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
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/invScript.js"></script>
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
var tableArray ="${ purchaseOrderForm.purchaseOrderFbList}";
var jsArray = 
    [
        <c:forEach items="${ purchaseOrderForm.purchaseOrderFbList}" var="arr" 
         varStatus="status">
          "${arr}"<c:if test="${not status.last}">,</c:if>
        </c:forEach>
    ];
 var poItemList =" ${invPurchaseOrderItemList}";
 var jspoItemArray = 
	 [
      <c:forEach items="${ invPurchaseOrderItemList}" var="array" 
       varStatus="status">
        "${array}"<c:if test="${not status.last}">,</c:if>
      </c:forEach>
  ];
</script>
	<script type="text/javascript">//
function confirmcancelItemModal()
{
	$('#confirmcancelOrderModal').modal('show');
}
	
function deletePoItemModal()
{
	$('#deletePoItemId').modal('show');
}
	
function confirmNewlyAddedItemModal(item)
{
	$('#confirmNewlyAddedItem').modal('show');
}

function updateAlertInAddItemModal()
{
	$('#updateAlertInAddItem').modal('show');
}

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
function quantityFloatValidateModal()
{
	$('#quantityFloatValidate').modal('show');
}
function newrequisitionModal()
{
	$('#newrequisition').modal('show');
}
function searchitemcorrectlyModal()
{
	$('#searchitemcorrectly').modal('show');
}
function alreadyexistitemModal()
{
	$('#alreadyexistitem').modal('show');
}
function somethingwrongitemupdateModal()
{
	$('#somethingwrongitemupdate').modal('show');
}
function dosomechangesModal()
{
	$('#dosomechanges').modal('show');
}
function validMiscValueModal()
{
	$('#validMiscValue').modal('show');
}
function additemModal()
{
	$('#additem').modal('show');
}
function selectYcreatePOModal()
{
	$('#selectYcreatePO').modal('show');
}
function approveYModal()
{
	$('#approveY').modal('show');
}
function approvePOModal()
{
	$('#approvePO').modal('show');
}
function poCreatedModal()
{
	$('#poCreated').modal('show');
}
function savepurchaseorderapproveModal()
{
	$('#savepurchaseorderapprove').modal('show');
}
function savepurchaseordercreatePOModal()
{
	$('#savepurchaseordercreatePO').modal('show');
}
function purchaseorderapproveModal()
{
	$('#purchaseorderapprove').modal('show');
}//displayPOPage

function purchaseorderapprovePOModal()
{
	$('#purchaseorderapprovePO').modal('show');
}

function displayPOPageModal()
{
	$('#displayPOPage').modal('show');
}

function updateAlertPOPageModal()
{
	$('#updateAlertPOPage').modal('show');
}

function displayStockInPageModal()
{
	$('#displayStockInPage').modal('show');
}

function updateAlertStockInPageModal()
{
	$('#updateAlertStockInPage').modal('show');
}

function displayStockOutPageModal()
{
	$('#displayStockOutPage').modal('show');
}

function updateAlertStockOutPageModal()
{
	$('#updateAlertStockOutPage').modal('show');
}

function displayNewRequisitionModal()
{
	$('#selectNewRequisition').modal('show');
}

function updateAlertNewRequisitionModal()
{
	$('#updateAlertNewRequisition').modal('show');
}

function displayPObyDateModal()
{
	$('#selectPObyDate').modal('show');
}

function updateAlertPObyDateModal()
{
	$('#updateAlertPObyDate').modal('show');
}

function displayPObyIdModal()
{
	$('#selectPObyId').modal('show');
}

function updateAlertPObyIdModal()
{
	$('#updateAlertPObyId').modal('show');
}

function updateAlertModal()
{
	$('#updateAlertId').modal('show');
}

function postDateAlertModal()
{
	$('#postDateAlert').modal('show');
}
function printAlertModal()
{
	$('#printAlert').modal('show');
}
function printSaveAlertModal()
{
	$('#printSaveAlert').modal('show');
}
function printSuccessModal()
{
	$('#printSuccess').modal('show');
}
</script>
	<script type="text/javascript">
function viewPurchaseOrder() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	if(hdnPageAlertFlag == 'Y'){
		updateAlertStockInPageModal();
	}else{
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayPOPageModal();
		} else {
			location.href = '${pageContext.request.contextPath }/inventory/viewinventory.htm';
		}
	}
}

function viewPurchaseOrderPage() {
	location.href = '${pageContext.request.contextPath }/inventory/viewinventory.htm';
}

function viewStockIn() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	if(hdnPageAlertFlag == 'Y'){
		updateAlertStockInPageModal();
	}else{
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayStockInPageModal();
		} else {
			location.href = '${pageContext.request.contextPath }/stockin/viewstockin.htm';
		}
	}
}

function viewStockInPage() {
	location.href = '${pageContext.request.contextPath }/stockin/viewstockin.htm';
}

function viewStockOut() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	if(hdnPageAlertFlag == 'Y'){
		updateAlertStockOutPageModal();
	}else{
		var itemAddFlag = document.getElementById('hdnAddItemFlag').value;
		if (itemAddFlag == "Y") {
			displayStockOutPageModal();
		} else {
			location.href = '${pageContext.request.contextPath }/stockout/viewstockout.htm';
		}
	}
}

function viewStockOutPage() {
	location.href = '${pageContext.request.contextPath }/stockout/viewstockout.htm';
}
</script>
	<!-----modal---->
	<div class="modal fade" data-backdrop="static" id="confirmcancelOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-danger" data-dismiss="modal">Cancel</button>
					<button type="button" onclick="javascript:removeNewlyAddedItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="zeroitemquantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Quantity Or Item Rate can not be zero.</div>
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
					<div style="text-align: center; font-size: 20px;">Please enter Item Quantity Or Item Rate.</div>
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
					<div style="text-align: center; font-size: 20px;">Please enter a positive Item Quantity Or Item Rate.</div>
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
					<!--  <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
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
	<div class="modal fade" data-backdrop="static" id="newrequisition" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please go for new requisition</div>
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
	<div class="modal fade" data-backdrop="static" id="somethingwrongitemupdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Something wrong while updating the item.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="validMiscValue" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter valid miscellaneous Rate</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="dosomechanges" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please do some changes.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="additem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please add an item first</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectYcreatePO" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please select Y to create PO</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="approveY" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please select Y to approve</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="approvePO" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please approve the PO first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
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
					<div style="text-align: center; font-size: 20px;">PO Created.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="javascript:poCreatedModalClose()">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="savepurchaseorderapprove" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please save the Purchase Order and then approve.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="savepurchaseordercreatePO" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please save the Purchase Order and then create PO.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="purchaseorderapprove" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Purchase Order already approved.</div>
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
	<div class="modal fade" data-backdrop="static" id="updateAlertPOPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
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
	<div class="modal fade" data-backdrop="static" id="updateAlertStockInPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
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
	<div class="modal fade" data-backdrop="static" id="updateAlertStockOutPage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:viewStockOutPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectNewRequisition" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:newPORequisition()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertNewRequisition" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:newPORequisition()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectPObyDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:purchaseOrderByDate()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertPObyDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:purchaseOrderByDate()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectPObyId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
					<input type="hidden" id="hiddenPO" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:getPoByPoId()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertPObyId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:getPoByPoId()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="deletePoItemId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the Changes in the Items</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:confirmcancelItemModal()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertInAddItem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the Changes in the Items</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:addNewOrderItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<!-- <button type="button" onclick="javascript:approveCallByPoId()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button> -->
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
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
	<div class="modal fade" data-backdrop="static" id="printAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please add an Item First.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="printSaveAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please save items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
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
	<!---modal--->

</body>
</html>