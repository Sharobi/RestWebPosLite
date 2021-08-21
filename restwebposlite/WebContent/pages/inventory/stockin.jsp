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
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<input type="hidden" value="${sessionScope.addItemFlag}" id="hdnAddItemFlag">
	<input type="hidden" value="" id="hdnPageAlertFlag">
	<input type="hidden" id="newStockInId" value="${sessionScope.newStockIn}">
	<input type="hidden" id="hdntotalItemPrice" value="">
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
								<a href="#">SIMPLE STOCK IN</a>
							</div>
							<div class="item item-sub-child" style="background-color: #72bb4f;">
								<a href="javascript:viewStockOut()">SIMPLE STOCK OUT</a>
							</div>
						</div>
					</div>

				</div>
				<form:form modelAttribute="invStockInForm" onsubmit="return checkValidate();" action="${pageContext.request.contextPath }/stockin/saveStockInObject.htm" method="post" role="form">
					<div class="col-md-10 col-sm-10" style="background-color: #999;">

						<div class="col-md-12 col-sm-12">
							<div class="col-md-5 col-sm-5">
								<div class="inv-requisition-0">
									STOCK IN <a href="javascript:newStockIn()" class="btn btn-success" style="background: #78B626">NEW</a>
								</div>
							</div>
							<c:forEach items="${inventoryStockInDetailList}" var="invStockInDetail" varStatus="invStatus" begin="0" end="0">
								<div class="col-md-7 col-sm-7">
									<div class="inv-requisition">
										Date&nbsp;&nbsp;<input type="text" size="8" readonly value="${invStockInDetail.createdDate}" style="text-align: center;"> Created By&nbsp;&nbsp;<input type="text" size="2" id="poCreatedId" readonly value="${invStockInDetail.createdBy}" style="text-align: center;"> StockIn Id&nbsp;&nbsp;<input type="text" size="2" readonly id="stockInId" value="${invStockInDetail.id}" style="text-align: center;">
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty inventoryStockInDetailList}">
								<div class="col-md-7 col-sm-7">
									<div class="inv-requisition">
										Date&nbsp;&nbsp;<input type="text" size="8" readonly value="${sessionScope.podate}" style="text-align: center;"> Created By&nbsp;&nbsp;<input type="text" size="2" readonly value="${sessionScope.loginId}" style="text-align: center;"> StockIn Id&nbsp;&nbsp;<input type="text" size="2" readonly value="0" style="text-align: center;">
									</div>
								</div>
							</c:if>
						</div>
						<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
							<div class="col-md-3 ">
								<div class="inv-requisition">
									Date&nbsp;&nbsp;<input type="text" name="selecteddate" id="poDate" size="8" readonly value="${sessionScope.podate}">&nbsp;&nbsp; <a href="javascript:getStockInByDate()" class="btn btn-success" style="background: #78B626">GO</a>
								</div>
							</div>


							<c:if test="${!empty inventoryStockInDetailList}">
								<c:forEach items="${inventoryStockInDetailList}" var="inventoryStockIn" varStatus="odrStatus" begin="0" end="0">
									<c:choose>
										<c:when test="${sessionScope.closeStatus != 'Y' }">
											<c:choose>
												<c:when test="${inventoryStockIn.id != 0}">
													<div class="col-md-6 col-sm-6">
														<div class="inv-requisition">
															Bill Date&nbsp;&nbsp;<input type="text" id="billDate" name="billDate" value="${inventoryStockIn.billDate}" size="8" readonly>Bill No&nbsp;&nbsp;<input type="text" id="billNo" name="billNo" value="${inventoryStockIn.billNo}" size="6" readonly> Vendor&nbsp;&nbsp; <select id="vendorId" name="vendorId" disabled="disabled">
																<c:forEach items="${selectedVendorList}" var="vendor">
																	<option value="${vendor.id}">${vendor.name}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-md-6 col-sm-6">
														<div class="inv-requisition">
															Bill Date&nbsp;&nbsp;<input type="text" id="billDate" name="billDate" value="${inventoryStockIn.billDate}" size="8">Bill No&nbsp;&nbsp;<input type="text" id="billNo" name="billNo" value="${inventoryStockIn.billNo}" size="6"> Vendor&nbsp;&nbsp; <select id="vendorId" name="vendorId">
																<c:forEach items="${vendorList}" var="vendor">
																	<option value="${vendor.id}">${vendor.name}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<div class="col-md-6 col-sm-6">
												<div class="inv-requisition">
													Bill Date&nbsp;&nbsp;<input type="text" id="billDate" name="billDate" value="${inventoryStockIn.billDate}" size="8" readonly>Bill No&nbsp;&nbsp;<input type="text" id="billNo" name="billNo" value="${inventoryStockIn.billNo}" size="6" readonly> Vendor&nbsp;&nbsp; <select id="vendorId" name="vendorId" disabled="disabled">
														<c:forEach items="${selectedVendorList}" var="vendor">
															<option value="${vendor.id}">${vendor.name}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:if>

							<div class="col-md-3 col-sm-6">
								<c:if test="${!empty  inventoryStockInDetailList}">
									<c:forEach items="${inventoryStockInDetailList}" var="invStockInItem" varStatus="invStatus" begin="0" end="0">
										<c:choose>
											<c:when test="${sessionScope.closeStatus != 'Y' }">
												<div class="inv-requisition">
													Close&nbsp;&nbsp;<select id="selectPO" name="selectPO" onchange="getSelectedStatus(this.value)"><option value="N">N</option>
														<option value="Y">Y</option></select> By&nbsp;&nbsp;<input type="text" size="4" id="poUserId" value=""> <a href="javascript:closeStatusUpdated()" class="btn btn-success" style="background: #78B626">DONE</a>
												</div>
											</c:when>
											<c:otherwise>
												<div class="inv-requisition">
													Close&nbsp;&nbsp;<select id="selectPO" name="selectPO" disabled="disabled"><option>Y</option>
														<option>N</option></select> By&nbsp;&nbsp;<input type="text" size="4" value="${invStockInItem.createdBy}" readonly>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
							</div>
							<div class="col-md-5">
								<c:choose>
									<c:when test="${sessionScope.closeStatus != 'Y' && sessionScope.searchBoxDisplay == 'Y'}">
										<div class="inv-requisition">
											<input type="text" size="16" placeholder="SEARCH" id="search" name="search" value=""> <input type="text" readonly size="4" id="searchCode" value="">&nbsp;&nbsp; <a href="javascript:addNewItem()" class="btn btn-success" style="background: #78B626">ADD</a>
										</div>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="col-md-12 col-sm-12" style="background: #CCCCCC;">
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
															<tr style="background-color: #C8E6F0; cursor: pointer;" onclick="rowClicked(${inventoryStockIn.id})">
																<td>${inventoryStockIn.id}</td>
																<td>${inventoryStockIn.vendorName}</td>
																<td>${inventoryStockIn.closed}</td>
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
								<div style="background: #FFF; overflow-y: auto; padding: 2px;">
									<div class="panel panel-default">
										<div class="panel-body" style="height: 260px;">
											<div class="table-responsive">
												<table class="table table-striped table-bordered table-hover">
													<thead style="background: #999999;">
														<tr>
															<th>ID</th>
															<th>ITEM</th>
															<th>QUANTITY</th>
															<th>UNIT</th>
															<th>RATE</th>
															<th>TAX(%)</th>
															<th>TAX AMOUNT</th>
															<th>ITEM AMOUNT</th>
															<th>TOTAL</th>
															<th>PO NO</th>
														</tr>
													</thead>
													<%-- <form:form modelAttribute="invStockInForm" action="${pageContext.request.contextPath }/stockin/saveStockInObject.htm" method="post"> --%>
													<c:choose>
														<c:when test="${sessionScope.addItemFlag != 'Y' }">
															<c:if test="${! empty inventoryStockInItemList}">
																<c:forEach items="${inventoryStockInItemList}" var="invStockInItem" varStatus="invStatus">
																	<input type="hidden" value="${invStockInItem.id}" id="stockInItemId">
																	<input type="hidden" value="${invStockInItem.itemQuantity}" id="hdnQty${invStockInItem.id}">
																	<input type="hidden" value="${invStockInItem.poId}" id="hdnPO${invStockInItem.id}">
																	<input type="hidden" value="${invStockInItem.itemRate}" id="hdnItemRate${invStockInItem.id}">
																	<c:choose>
																		<c:when test="${sessionScope.closeStatus != 'Y' }">
																			<tr>
																				<td id="tdCode${invStatus.index}">${invStockInItem.inventoryItems.code}</td>
																				<td id="tdName">${invStockInItem.inventoryItems.name}</td>
																				<td id="tdItemQty"><input type="text" id="itemQty${invStockInItem.id}" value="${invStockInItem.itemQuantity}" onkeyup="getStockInTotalPrice(${invStockInItem.id},${invStockInItem.taxRate})" onclick="javascript:clearItemQuantity(${invStockInItem.id})" size="4" style="border: 0px solid #000000; background: #FFF; text-align: center;" maxlength="4"></td>
																				<td id="tdUnit${invStockInItem.id}">
<%-- 																				${invStockInItem.inventoryItems.unit} --%>
																				<select id="tdUnit${invStockInItem.id}" name="${invStockInItem.unitId}" disabled="disabled" style="margin-bottom: 5px; color: #222222;border-color: white; appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																							
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								<c:if test="${invStockInItem.unitId==metricunit.id}">
																								<option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							</c:if>
																							<c:if test="${invStockInItem.unitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option></c:if>
																								</c:forEach></c:if>
																					</select>
																				</td>
																				<td id="tdRate${invStockInItem.id}"><input type="text"  id="itmRate${invStockInItem.id}" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemRate}" />' onkeyup="getStockInItemPrice(${invStockInItem.id},${invStockInItem.taxRate})" onclick="javascript:clearStockInItemRate(${invStockInItem.id})" size="8" style="border: 0px solid #000000; background: #FFF; text-align: right;" maxlength="8"></td>
																				<td id="tdtaxRate">${invStockInItem.taxRate}</td>
																				<td id="tdtaxAmount${invStockInItem.id}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.taxAmount}" /></td>
																				<td id="tdamountWithoutTax${invStockInItem.id}"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemTotalPrice}" /></td>
																				<td id="tdTotalPrice${invStockInItem.id}" align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemGrossAmount}" /></td>
																				<td id="tdPoNo${invStockInItem.id}"><input type="text" id="pNo${invStockInItem.id}" value="${invStockInItem.poId}" onkeyup="getColorChange(${invStockInItem.id})" size="10" style="border: 0px solid #000000; background: #FFF;"></td>
																				<td><a href="javascript:updateEachStockInItem(${invStockInItem.id},${invStockInItem.taxRate})" class="btn btn-success" style="background: #78B626" id="update${invStockInItem.id}">Update</a></td>
																				<td><a href="javascript:deleteEachStockInItem(${invStockInItem.id})"><img alt="" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"> </a></td>
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<tr>
																				<td>${invStockInItem.inventoryItems.code}</td>
																				<td>${invStockInItem.inventoryItems.name}</td>
																				<td align="center">${invStockInItem.itemQuantity}</td>
																				<td>
<%-- 																				${invStockInItem.inventoryItems.unit} --%>
																				<select id="tdUnit" name="${invStockInItem.unitId}" disabled="disabled" style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																								<c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${invStockInItem.unitId==metricunit.id}">
																								     <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							       </c:if>
																							       <c:if test="${invStockInItem.unitId!=metricunit.id}">
																									 <option value="${metricunit.id}" >${metricunit.unit}</option>
																									</c:if>
																								</c:forEach>
																							</c:if>
																					</select>
																				</td>
																				<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemRate}" /></td>
																				<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.taxRate}" /></td>
																				<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.taxAmount}" /></td>
																				<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemTotalPrice}" /></td>
																				<td align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${invStockInItem.itemGrossAmount}" /></td>
																				<td>${invStockInItem.poId}</td>
																			</tr>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${!empty invStockInForm }">
																<c:forEach items="${ invStockInForm.invStockInFBList}" var="stockInFB" varStatus="status">
																	<tr>
																		<td><input name="invStockInFBList[${status.index}].itemCode" id="iCode${status.index}" value="${stockInFB.itemCode}" style="border: 0px solid #000000; background: #FFF;" size="3" readonly></td>
																		<td><input name="invStockInFBList[${status.index}].itemName" id="iName${status.index}" value="${stockInFB.itemName}" style="border: 0px solid #000000; background: #FFF;" readonly multiple></td>
																		<c:choose>
																			<c:when test="${stockInFB.approveFlag == 'Y'}">
																				<td><input name="invStockInFBList[${status.index}].itemQuantity" value="${stockInFB.itemQuantity}" id="itemQty${status.index}" readonly style="border: 0px solid #000000; background: #FFF; text-align: center;" size="6"></td>
																			</c:when>
																			<c:otherwise>
																				<td><input name="invStockInFBList[${status.index}].itemQuantity" value="${stockInFB.itemQuantity}" id="itemQty${status.index}" onkeyup="getStockInPrice(${status.index},'${stockInFB.itemCode}',${stockInFB.tax})" onclick="javascript:clearItemQty(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: center" size="6" maxlength="6"></td>
																			</c:otherwise>
																		</c:choose>
																		<td>
<%-- 																		<input name="invStockInFBList[${status.index}].itemUnit" value="${stockInFB.itemUnit}" style="border: 0px solid #000000; background: #FFF;" size="6" readonly> --%>
																		<c:if test="${stockInFB.metricUnitId!='0'}">
																		<select  name="${stockInFB.metricUnitId}" id="iUnit${status.index}" disabled="disabled" onchange="getMetricunitVal(this.value,${status.index},'${stockInFB.itemCode}',${stockInFB.tax});" style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																							   <c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${stockInFB.metricUnitId==metricunit.id}">
																								    <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							     </c:if>
																							     <c:if test="${stockInFB.metricUnitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option>
																								 </c:if>
																								</c:forEach>
																							</c:if>
																					</select>
																		</c:if>
																		<c:if test="${stockInFB.metricUnitId=='0'}">
																		           <select  name="invStockInFBList[${status.index}].metricUnitId" id="iUnit${status.index}" disabled="disabled" onchange="getMetricunitVal(this.value,${status.index},'${stockInFB.itemCode}',${stockInFB.tax});" style="margin-bottom: 5px; color: #222222;border-color: white;appearance:none;-moz-appearance:none; /* Firefox */ -webkit-appearance:none;">
																							<c:if test="${! empty metricUnitList}">
																							   <c:forEach items="${metricUnitList}" var="metricunit">
																								  <c:if test="${stockInFB.metricUnitId==metricunit.id}">
																								    <option value="${metricunit.id}" selected>${metricunit.unit}</option>
																							     </c:if>
																							     <c:if test="${stockInFB.metricUnitId!=metricunit.id}">
																									<option value="${metricunit.id}" >${metricunit.unit}</option>
																								 </c:if>
																								</c:forEach>
																							</c:if>
																					</select>
																		</c:if>
																		
																		</td>
																		<td><input  name="invStockInFBList[${status.index}].itemRate" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${stockInFB.itemRate}" />' id="iRate${status.index}" onkeyup="getItemRate(${status.index},'${stockInFB.itemCode}',${stockInFB.tax})" onclick="javascript:clearItemRate(${status.index})" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="6"></td>
																		<td><input name="invStockInFBList[${status.index}].tax" id="tax${status.index}" value="${stockInFB.tax}" style="border: 0px solid #000000; background: #FFF;" size="6" readonly></td>
																		<td><input name="invStockInFBList[${status.index}].taxAmount" id="taxAmount${status.index}" value="${stockInFB.taxAmount}" style="border: 0px solid #000000; background: #FFF;" size="6" readonly></td>
																		<td><input name="invStockInFBList[${status.index}].amountWithoutTax" id="amountWithoutTax${status.index}" value="${stockInFB.amountWithoutTax}" style="border: 0px solid #000000; background: #FFF;" size="6" readonly></td>
																		<td><input name="invStockInFBList[${status.index}].totalPrice" class="itemtopr" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false"  value="${stockInFB.totalPrice}" />' id="tPrice${status.index}" style="border: 0px solid #000000; background: #FFF; text-align: right;" size="8" readonly></td>
																		<c:choose>
																			<c:when test="${stockInFB.approveFlag == 'Y'}">
																				<td><input name="invStockInFBList[${status.index}].poNo" value="${stockInFB.poNo}" id="pNo${status.index}" readonly style="border: 0px solid #000000; background: #FFF;" size="10"></td>
																			</c:when>
																			<c:otherwise>
																				<td><input name="invStockInFBList[${status.index}].poNo" value="${stockInFB.poNo}" id="pNo${status.index}" style="border: 0px solid #000000; background: #FFF;" size="10"></td>
																			</c:otherwise>
																		</c:choose>
																		<td><a href="javascript:removeNewlyItem('${stockInFB.itemCode}',${stockInFB.totalPrice})"><img alt="" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"> </a></td>
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
									<c:when test="${sessionScope.closeStatus != 'Y' }">
										<c:choose>
											<c:when test="${sessionScope.addItemFlag != 'Y' }">
												<div class="col-md-8 col-sm-8">
													Misc Charges:<input type="text" size="10" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' id="misChargeId" readonly="readonly" style="text-align: right;">
												</div>
												<div class="col-md-4 col-sm-4"></div>
												<div class="col-md-6">
													<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" size="8" id="totalId" style="text-align: right;" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${sessionScope.grandTotalPrice}"/>' readonly><input type="submit" disabled="disabled" value="Save" class="btn btn-success" style="background: #78B626; margin-top: 3px;">
												</div>
											</c:when>
											<c:otherwise>
												<div class="col-md-8 col-sm-8">
													Misc Charges:<input type="text" size="10"  value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' id="misChargeId" onclick="javascript:clearMiscValue(this.id)" onkeyup="getTotalPriceByMiscValue()" name="misChargeId" style="text-align: right;">
												</div>
												<div class="col-md-4 col-sm-4"></div>
												<div class="col-md-6">
													<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" size="8" id="totalId" name="totalId" style="text-align: right;" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${sessionScope.grandTotalPrice}"/>' readonly> <input type="submit" value="Save" class="btn btn-success" style="background: #78B626; margin-top: 3px;">
												</div>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<div class="col-md-8 col-sm-8">
											Misc Charges:<input type="text" size="10" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${misCharge}"/>' readonly="readonly" style="text-align: right;">
										</div>
										<div class="col-md-4 col-sm-4"></div>
										<div class="col-md-6">
											<font style="font-weight: bold;">GRAND TOTAL:</font><input type="text" size="8" id="totalId" style="text-align: right;" value='<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${sessionScope.grandTotalPrice}"/>' readonly>
										</div>
									</c:otherwise>
								</c:choose>

							</div>

						</div>
					</div>
				</form:form>
			</div>

		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
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
function selectYtocloseModal()
{
	$('#selectYtoclose').modal('show');
}
function saveStockInItemsModal()
{
	$('#saveStockInItems').modal('show');
}
function deleteItemModal()
{
	$('#deleteItemId').modal('show');
} 
function confirmCancelItemModal()
{
	$('#confirmcancelOrderModal').modal('show');
}
function updateAlertInAddItemModal()
{
	$('#updateAlertInAddItem').modal('show');
}
function confirmNewlyAddedItemModal()
{
	$('#confirmNewlyAddedItem').modal('show');
}
function billNumberModal()
{
	$('#billNumber').modal('show');
}
function billDateValidateModal()
{
	$('#billDateModal').modal('show');
}
function billAlphaNumericValidateModal()
{
	$('#billAlphaNumericValidate').modal('show');
}
function quantityFloatValidateModal()
{
	$('#quantityFloatValidate').modal('show');
}
function validPONoModal()
{
	$('#validPONo').modal('show');
}
function ItemRateBlankValidateModal()
{
	$('#ItemRateBlankValidate').modal('show');
}
function ItemRateZeroValidateModal()
{
	$('#ItemRateZeroValidate').modal('show');
}
function ItemRateNegativeValidateModal()
{
	$('#ItemRateNegativeValidate').modal('show');
}
function ItemRateCharValidateModal()
{
	$('#ItemRateCharValidate').modal('show');
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

function displayNewStockInModal()
{
	$('#selectNewStockIn').modal('show');
}

function updateAlertNewStockInModal()
{
	$('#updateAlertNewStockIn').modal('show');
}

function displayStockInByDateModal()
{
	$('#selectStockInbyDate').modal('show');
}

function updateAlertStockInbyDateModal()
{
	$('#updateAlertStockInbyDate').modal('show');
}

function displayStockInByIdModal()
{
	$('#selectStockInbyId').modal('show');
}

function updateAlertStockInbyIdModal()
{
	$('#updateAlertStockInbyId').modal('show');
}

function updateAlertModal()
{
	$('#updateAlertId').modal('show');
}

function postDateAlertModal()
{
	$('#postDateAlert').modal('show');
}
</script>
	<script type="text/javascript">
function viewPurchaseOrder() {
	var hdnPageAlertFlag = document.getElementById('hdnPageAlertFlag').value;
	
	if(hdnPageAlertFlag == 'Y'){
		updateAlertPOPageModal();
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

	<!--modal-->
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
	<div class="modal fade" data-backdrop="static" id="selectYtoclose" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please select Y to close.</div>
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
					<div style="text-align: center; font-size: 20px;">Please add an item first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="saveStockInItems" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please save the StockIn Items and then close.</div>
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
					<button type="button" onclick="javascript:deleteStockInItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="deleteItemId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First Update the changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:confirmCancelItemModal()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
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
					<button type="button" onclick="javascript:addNewStockInItem()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
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
	<div class="modal fade" data-backdrop="static" id="billNumber" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter Bill Number.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billDateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter Bill Date.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="billAlphaNumericValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Bill Number must be AlphaNumeric.</div>
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
	<div class="modal fade" data-backdrop="static" id="validPONo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter valid PO Number.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="ItemRateBlankValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Rate cannot be blank</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="ItemRateZeroValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Rate cannot be zero</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="ItemRateNegativeValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Item Rate cannot be negative</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
					<!-- <button type="button" onclick="javacsript:cancelUnpaidOrder(document.getElementById('unpaidordernocontId').innerHTML)" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button> -->
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="ItemRateCharValidate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Please enter valid Item Rate</div>
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
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
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
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
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
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:viewStockOutPage()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectNewStockIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:getNewStockIn()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertNewStockIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:getNewStockIn()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectStockInbyDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:stockInByDateWise()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertStockInbyDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:stockInByDateWise()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="selectStockInbyId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Save the unsaved items first.</div>
					<input type="hidden" id="hiddenStockId" value="">
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:getStockInById()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="updateAlertStockInbyId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Warning</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">First update changes in the items.</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

					<button type="button" onclick="javascript:getStockInById()" style="font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-warning">CANCEL</button>
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
	<script src="${pageContext.request.contextPath}/assets/js/stockinScript.js"></script>
	<script type="text/javascript">
		// When the document is ready
		$(document).ready(function() {

			$('#poDate').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true
			});
			
			$('#billDate').datepicker({
// 				format : "dd-mm-yyyy",
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
var tableArray ="${ invStockInForm.invStockInFBList}";
var jsArray = 
    [
        <c:forEach items="${ invStockInForm.invStockInFBList}" var="arr" 
         varStatus="status">
          "${arr}"<c:if test="${not status.last}">,</c:if>
        </c:forEach>
    ];
 var poItemList =" ${inventoryStockInItemList}";
 var jspoItemArray = 
	 [
      <c:forEach items="${ inventoryStockInItemList}" var="array" 
       varStatus="status">
        "${array}"<c:if test="${not status.last}">,</c:if>
      </c:forEach>
  ];
</script>
</body>
</html>
