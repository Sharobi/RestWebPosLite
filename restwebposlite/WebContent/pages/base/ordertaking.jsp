<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.sharobi.webpos.base.model.Order"%>
<%@ page import="com.sharobi.webpos.base.model.OrderItem" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" /> 
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Order Taking :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />
<!-- for saravana numeric keypad -->
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/numerickey.js"></script>
<!--  For event calendar-->
   <link href="${pageContext.request.contextPath}/assets/css/calendar/fullcalendar.min.css" rel="stylesheet"/>
   <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet"/>
   
<script type="text/javascript">
var BASE_URL="${pageContext.request.contextPath}";
var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
var vfdPort="${sessionScope.loggedinStore.customerDisplay}";
var storeID="${sessionScope.loggedinStore.id}";
/* var storeAddr = "${sessionScope.loggedinStore.address}"; */
var itcatId="${itcatno}";
var orderType="${orderType}";
var softKey="${sessionScope.loggedinStore.softKey}";
var printpaidBill="${sessionScope.loggedinStore.printPaidBill}";
var cdrawerCode="${sessionScope.loggedinStore.cashDrawerCode}";

</script>
<!-- end for saravana numeric keypad -->
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">

<style>
.ui-autocomplete {
	max-height: 300px;
	overflow-y: auto;
	/*
	prevent
	horizontal
	scrollbar
	*/
	overflow-x
	:
	hidden;
	/*
	add
	padding
	to
	account
	for
	vertical
	scrollbar
	*/
	/*
	padding-right
	:
	20px;
	*/
}

li {
	padding: 0px;
	important;
}

.nav-tabs {
	display: flex;
}

.nav-tabs li {
	display: flex;
	flex: 1;
}

.nav-tabs li  a {
	flex: 1;
	text-align: center;
}

li.active {
	padding: 0px;
	important;
}

li.disabled {
	background-color: #000;
}

li>a {
	color: #fff; important;
	height: 100%;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	important;
}

li.active>a {
	color: #000; important;
	height: 100%;
	text-align: center;
	text-decoration: none;
	vertical-align: middle;
	important;
}

.nav>li.disabled>a:focus {
	pointer-events: none;
}

span.disable-link
{
 pointer-events: none;
}

span.enable-link
{
 pointer-events: auto;
}

#n_keypad_man {
	display: block !important;
}

#enterQtyAlert {
	color: #f60;
	font-size: 12px;
	font-weight: bold;
	text-align: center;
}

#tblorderdata td, th{
padding: 4px;
}
/* #ordereditems thead{
display: block;
}

#ordereditems tbody {
    display: block;
    height: 100px;       
    overflow-y: auto;   
    overflow-x: hidden; 
} */


</style>
<script>
	function rowClicked(){
		//alert("Table row clicked");
	}
	</script>




<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body
	onload="showtablebookingData(),directOrderCheck(document.getElementById('directordertakingContId').value),instantPaymentOpenModal(),menucatload($('#menucatitemsublength').val(),$('#menucatitemsubid').val(),$('#menucatitemsubindex').val()),isOrderSave(),getAllOrderType()"
	style="background-color: #e9e9e9;">
 	<jsp:include page="/pages/common/header.jsp"></jsp:include> 
	<c:set var="today" value="<%=new java.util.Date()%>" />
	
	<input type="hidden" id="hiddenOrderType"/>
	
	 <%-- <input type="text" name="text" value="${sessionScope.matchedOrderType}" /> --%> 

	<div class="content-wrapper">
		<div class="container-fluid">

			<div class="row">
				<div class="col-md-4 col-sm-4">
					<div style="background: #fff;">
						<div>
							<input type="hidden" id="directordertakingContId"
								value="${directorderTaking}" /> <input type="hidden"
								id="hidinstantPaymentFlag" value="${flag}" /> <input
								type="hidden" id="hidinstantPaymentType" value="${ptype}" /> <input
								type="hidden" id="firsttimecall" value="${firsttimecall}" />
								
							 	<div>
								<input type="text" id="itemNameSearch"
									value="${orders.customerName}"
									onkeypress='return lettersOnly(event)'	
									style="color: #222222; margin-left: 1% "  size="15"placeholder="Customer Name">

								<input type="text" id="itemContactSearch"
								value="${orders.customerContact}" 
								onkeypress='return isNumberKey(event)'
								style="color: #222222;" maxlength="10" size="15" placeholder="Contact No" >
									
										<span id="custDetail" class= "disable-link"><a href="javascript:custDetails()"
										class="btn-order-taking" style="width: 15% ;height: 10%; text-align:center;">DETAILS </a></span>
										
										<span id="custAdd" class= "enable-link"><a href="javascript:newCustAdd()" id="btnAddId"
										class="btn-order-taking" style="width: 15%;height: 10%;text-align:center;">ADD</a></span>
										
										<input type="text" id="orderRmks" value="${orders.remarks}" style="display:none;">
										<input type="text" id="orderPkgNotes" value="${orders.specialNote}" style="display:none;">
								</div> 
						
							
							<table style="width: 99%">
								<tr>
									<td><a href="javascript:selectAllRow()"
										class="btn-order-taking" style="width: 97%"><span
											class="fa fa-check"></span> &nbsp;ALL </a></td>
									<td><a href="javascript:deleteRows()"
										class="btn-order-taking" style="width: 97%"><span
											class="fa fa-trash"></span> &nbsp;DELETE </a></td>
									<c:if test="${sessionScope.loggedinStore.id == 120}">
									<td><a href="javascript:openPackagingNoteModal()"
										class="btn-order-taking" style="width: 97%;margin:2px;"><span
											class="fa fa-info"></span> <spring:message
												code="order.jsp.RMK" text="PKG RMK" /></a></td>
									</c:if>
									<td><a href="javascript:openRemarksModal()"
										class="btn-order-taking" style="width: 97%;margin:2px;"><span
											class="fa fa-info"></span> <spring:message
												code="order.jsp.RMK" text="RMK" /></a></td>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.billSplit, 'Y') }">
										<td class="hide"><a
											href="javascript:openSplitBill(${sessionScope.loggedinStore.id})"
											class="btn-order-taking" style="width: 97%;"><span
												class="fa fa-copy"></span>&nbsp;SPLIT </a></td>
									</c:if>
									<td><a href="javascript:openpecialNoteModal()"
										class="btn-order-taking" style="width: 97%"><span
											class="fa fa-pencil"></span> &nbsp;NOTE </a></td>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.isPax, 'Y') }">
										<td class="hide"><a href="javascript:openPaxModal()"
											class="btn-order-taking" style="width: 98%;"><span
												class="fa fa-users"></span>&nbsp;PAX <span id="noofPaxId">
													<c:if test="${orders.table_no!='0' }">
                				${orders.noOfPersons}
                				</c:if>
											</span> </a></td>
									</c:if>
								</tr>
							</table>
							<!--<c:choose>
             	<c:when test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
             	<a href="javascript:selectAllRow()"  class="btn-order-taking" style="width: 17%;"><span class="fa fa-check"></span>&nbsp;ALL </a>
                <a href="javascript:deleteRows()" class="btn-order-taking" style="width: 17%;"><span class="fa fa-trash"></span>&nbsp;DEL </a>
                <a href="javascript:openSplitBill(${sessionScope.loggedinStore.id})" class="btn-order-taking" style="width: 18%;"><span class="fa fa-copy"></span>&nbsp;SPLIT </a>
                <a href="javascript:openpecialNoteModal()" class="btn-order-taking" style="width: 18%;"><span class="fa fa-pencil"></span>&nbsp;NOTE </a>
                <a href="javascript:openPaxModal()" class="btn-order-taking" style="width: 20%;"><span class="fa fa-users"></span>&nbsp;PAX 
                <span id="noofPaxId">
                <c:if test="${orders.table_no!='0' }">
                ${orders.noOfPersons}
                </c:if>
                </span>
                </a>
             	</c:when>
             	<c:otherwise>
             	<a href="javascript:selectAllRow()"  class="btn-order-taking" style="width: 31%;"><span class="fa fa-check"></span> &nbsp;ALL </a>
                <a href="javascript:deleteRows()" class="btn-order-taking" style="width: 31%;"><span class="fa fa-trash"></span> &nbsp;DELETE </a>
                
                <a href="javascript:openpecialNoteModal()" class="btn-order-taking" style="width: 31%;"><span class="fa fa-pencil"></span> &nbsp;NOTE </a>
             	</c:otherwise>
             	</c:choose>!-->
							<c:if test="${! empty orders}">
								<input type="hidden" id="hidnoofPax"
									value="${orders.noOfPersons}" />
							<input type="hidden" id="hidnOrderTypeData"
									value="${orders.ordertype.orderTypeName}" />
						    <c:set var="varordertypename" value="${orders.ordertype.orderTypeName}"></c:set>								
							</c:if>
							<c:if test="${empty orders}">
								<c:set var="savedOrderItemCount" value="0"></c:set>
								<input type="hidden" id="hidnoofPax" value="1" />								
							</c:if>

						</div>
						<div style="background: #fff; overflow-y: auto; padding: 2px;">
							<div class="panel panel-default">
								<div class="panel-body" style="height: 275px; background: #fff;">
									<div class="table-responsive" id="orderitemContId">

										<table class="table table-striped table-bordered">
											<c:if test="${! empty orders}">
												<thead>
													<th>SL</th>
													<th>NAME</th>
													<th style="text-align: center;">QUANTITY</th>
													<th>RATE</th>
													<th>TOTAL</th>
													<!-- for saravana -->
													<!-- <th>
                            							DISCNT
                           							 </th> -->
													
													<!-- for saravana -->
													<%-- <c:if test="${! empty sessionScope.loggedinStore.vatTaxText}">
                            	<th>
                            	${sessionScope.loggedinStore.vatTaxText}(%)
                            	</th>
                            </c:if>
                            <c:if test="${! empty sessionScope.loggedinStore.serviceTaxText}">
                            	<th>
                            	${sessionScope.loggedinStore.serviceTaxText}(%)
                            	</th>
                            </c:if> --%>
												</thead>

												<tbody>

													<c:forEach items="${orders.orderitem }" var="orderitems"
														varStatus="stat">
														<c:set var="bgCol" value="#2E2E2E"></c:set>
														<c:if
															test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
															<c:set var="bgCol" value="#1c91bc"></c:set>

														</c:if>
														<c:set var="savedOrderItemCount" value="${stat.index+1}"></c:set>

														<tr style="padding: 2px;">
															<td style="padding: 1px; text-align: center;">${stat.index+1}</td>
															<td
																style="padding: 1px; max-width: 250px !important; word-wrap: break-word;"><c:choose>
																	<c:when test="${orderitems.ordertype==2}">
                                		${orderitems.item.name}
                                	</c:when>
																	<c:otherwise>
                                	${orderitems.item.name}
                                	</c:otherwise>
																</c:choose></td>
															<td valign="middle" align="center" style="padding: 3px;">${orderitems.quantityOfItem}</td>
															<td style="padding: 1px; text-align: center;"><fmt:formatNumber
																	type="number" maxFractionDigits="2"
																	minFractionDigits="2" value="${orderitems.rate}"></fmt:formatNumber></td>
																		
													
															
															<td style="padding: 1px; text-align: center;"><c:if
																	test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
																	<fmt:formatNumber type="number" maxFractionDigits="2"
																		minFractionDigits="2"
																		value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
																</c:if> <c:if
																	test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
																	<fmt:formatNumber type="number" maxFractionDigits="2"
																		minFractionDigits="2"
																		value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
																</c:if></td>
															<!-- for saravana -->
															<%--  <td  style="padding:1px;text-align: center;">
                                	<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
                                	<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${(orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
                                	</c:if>
                                	<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
                                	0.00
                                	</c:if>
                                </td> --%>
															
														
															
															
															<!-- for saravana -->
															<%-- <c:if test="${! empty sessionScope.loggedinStore.vatTaxText}">
                                	<td  style="padding:1px;text-align: center;">
                                		<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.vat}"></fmt:formatNumber>
                                	</td>
                                </c:if>
                                <c:if test="${! empty sessionScope.loggedinStore.serviceTaxText}">
                                 	<td  style="padding:1px;text-align: center;">
                                		<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.serviceTax}"></fmt:formatNumber>
                                	</td> 
                                </c:if> --%>
														</tr>

													</c:forEach>

												</tbody>
											</c:if>
											<c:if test="${empty orders}">
												<thead>
													<th></th>
													<th>NAME</th>
													<th style="text-align: center;">QUANTITY</th>
													<th>RATE</th>
													<th>TOTAL</th>
													<!-- for saravana -->
													<!-- <th>
                            	DISCNT
                            </th> -->
													
													<!-- for saravana -->
													<%-- <c:if test="${! empty sessionScope.loggedinStore.vatTaxText}">
                            	<th>
                            	${sessionScope.loggedinStore.vatTaxText}(%)
                            	</th>
                            </c:if>
                            <c:if test="${! empty sessionScope.loggedinStore.serviceTaxText}">
                            	<th>
                            	${sessionScope.loggedinStore.serviceTaxText}(%)
                            	</th>
                            </c:if> --%>
												</thead>
												<tbody style="color: #fff; padding: 1px;">
												</tbody>
											</c:if>
										</table>

									</div>
								</div>
							</div>
						</div>
						<!-- Bill Calculation Show Start -->
						
						
						<c:set var="staticVat" value="14.5"></c:set>
						<c:set var="staticST" value="5.6"></c:set>
						<c:set var="netPrice" value="0.00"></c:set>
						<c:set var="paidAmount" value="0.00"></c:set>
						<c:set var="custDisc" value="0.00"></c:set>
						<c:set var="custDiscPerc" value="0.00"></c:set>
						<c:set var="totDisc" value="0.00"></c:set>
						<c:set var="totVat" value="0.00"></c:set>
						<c:set var="totST" value="0.00"></c:set>
						<c:set var="totRate" value="0.00"></c:set>

						<c:set var="subtotalWithOutTax" value="0.00"></c:set>
						<c:set var="subtotalWithTax" value="0.00"></c:set>
						<c:set var="orderVat" value="${sessionScope.loggedinStore.vatAmt}"></c:set>
						<c:set var="orderSTax" value="${sessionScope.loggedinStore.serviceTaxAmt}"></c:set>

						<c:set var="totPrice" value="0.00"></c:set>
						<c:set var="netTotal" value="0.00"></c:set>
						<c:set var="totnonspotDiscAmt" value="0.00"></c:set>
						<c:set var="schrg" value="0.00"></c:set>

						<c:set var="custDiscPerc1" value="0.00"></c:set>
						<c:set var="schargerate" value="0.00"></c:set>
						<c:set var="custDisc1" value="0.00"></c:set>
						<c:set var="schrg1" value="0.00"></c:set>

						<c:if test="${! empty orders}">


							<c:if test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
								<c:set var="custDiscPerc1"
									value="${orders.orderBill.discountPercentage}"></c:set>
							</c:if>


						<!-- /* Item Wise Calculation start */ -->
							<c:forEach items="${orders.orderitem}" var="orditems">
								<c:set var="totDisc1" value="0.00"></c:set>
								<c:set var="totVat1" value="0.00"></c:set>
								<c:set var="totST1" value="0.00"></c:set>
								<c:set var="totnonspotDiscAmt1" value="0.00"></c:set>
								<c:set var="totcustdisc1" value="0.00"></c:set>
								<c:set var="totscharge1" value="0.00"></c:set>
								<c:set var="totRate1" value="0.00"></c:set>
								<c:set var="totalItemRate" value="0.00"></c:set> 
								<c:if test="${fn:containsIgnoreCase(orditems.item.promotionFlag, 'Y') }">
									<c:set var="totDisc1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${orditems.quantityOfItem*(orditems.rate*orditems.item.promotionValue/100)}" />
									</c:set>
								</c:if>
								<c:set var="totRate">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${totRate+orditems.quantityOfItem*orditems.rate-totDisc1}" />
								</c:set>
								<c:set var="totRate1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${orditems.quantityOfItem*orditems.rate-totDisc1}" />
								</c:set>
								<c:set var="totcustdisc1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate1*custDiscPerc1/100}" />
									</c:set>

								<%-- <c:set var="totscharge1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${(totRate1-totcustdisc1) * orders.orderBill.serviceChargeRate/100}" />
									</c:set>
                                   --%>
								<c:if
									test="${fn:containsIgnoreCase(orditems.item.spotDiscount, 'N') }">
									<c:set var="totnonspotDiscAmt1"> ${totnonspotDiscAmt1+(orditems.quantityOfItem*orditems.rate)}</c:set>
								</c:if>

								<c:set var="totVat1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${(totRate1-totcustdisc1+totscharge1)*orditems.item.vat/100}" />
								</c:set>
								<c:set var="totST1">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${(totRate1-totcustdisc1+totscharge1)*orditems.item.serviceTax/100}" />
								</c:set>
								<c:if
									test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orditems.item.vat==0.00}">
									<c:set var="totVat1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totVat1+(orditems.quantityOfItem*orditems.rate-totDisc1)*staticVat/100}" />
									</c:set>
								</c:if>
								<c:if
									test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orditems.item.serviceTax==0.00}">
									<c:set var="totST1">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totST1+(orditems.quantityOfItem*orditems.rate-totDisc1)*staticST/100}" />
									</c:set>
								</c:if>

								<c:set var="totDisc">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${totDisc+totDisc1}" />
								</c:set>

								<c:if
									test="${orditems.item.vat==0.00 && orditems.item.serviceTax==0.00}">
									<c:set var="subtotalWithOutTax">${subtotalWithOutTax+((orditems.quantityOfItem*orditems.rate)-totDisc1)}</c:set>
								</c:if>
	 							<c:if
									test="${orditems.item.vat!=0.00 || orditems.item.serviceTax!=0.00}">
									<c:set var="orderVat">${orditems.item.vat}</c:set>
									<c:set var="orderSTax">${orditems.item.serviceTax}</c:set>
									<c:set var="subtotalWithTax">${subtotalWithTax+((orditems.quantityOfItem*orditems.rate)-totDisc1)}</c:set>
								</c:if>

								<c:set var="totVat">${totVat+totVat1}</c:set>
								<c:set var="totST">${totST+totST1}</c:set>
								<c:set var="totnonspotDiscAmt">${totnonspotDiscAmt+totnonspotDiscAmt1}</c:set>
							</c:forEach>
							<!-- /* Item Wise Calculation end */ -->


							<c:if
								test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
								<c:set var="custDisc"
									value="${custDisc+orders.orderBill.customerDiscount}"></c:set>
							</c:if>
							<c:if test="${subtotalWithOutTax>custDisc}">

							<c:set var="subtotalWithTax">${totRate-subtotalWithOutTax}</c:set>
							</c:if>
						<c:if test="${subtotalWithOutTax<=custDisc}">

						<c:set var="subtotalWithTax">${totRate-custDisc}</c:set>
						</c:if>
                               
                               <!--new added for total item price to show in bill 28.9.2018 start  -->
                              <c:set var="totalItemRate1">
								<fmt:formatNumber type="number" groupingUsed="false"
									maxFractionDigits="2" value="${totRate}" />
							</c:set>
							 <!--new added for total item price to show in bill 28.9.2018 end  -->
                                 
							<c:set var="totRate">
								<fmt:formatNumber type="number" groupingUsed="false"
									maxFractionDigits="2" value="${totRate-custDisc}" />
							</c:set>


							<%-- <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
								<c:if test="${ordertypeList.serviceChargeValue!=0.0 }">
									<c:set var="schrg">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate * orders.orderBill.serviceChargeRate/100}" />
									</c:set>
									
								</c:if>
							</c:if> --%>


							<c:set var="totnonspotDiscAmt">
								<fmt:formatNumber type="number" groupingUsed="false"
									minFractionDigits="2" maxFractionDigits="2"
									value="${totnonspotDiscAmt}" />
							</c:set>

							<c:if
								test="${currentTable=='0' && sessionScope.loggedinStore.parcelServiceTax=='N'}">
								<c:set var="totST" value="0.00"></c:set>
							</c:if>

							<c:if
								test="${totRate==0.00}">
								<c:set var="totVat" value="0.00"></c:set>
								<c:set var="totST" value="0.00"></c:set>
								<c:set var="schrg" value="0.00"></c:set>

							</c:if>


							<c:if
								test="${currentTable=='0' && sessionScope.loggedinStore.parcelVat=='N'}">
								<c:set var="totVat" value="0.00"></c:set>
							</c:if>

							<c:set var="paidAmount" value="${paidAmount+orders.paidAmt}"></c:set>

							<c:set var="totPrice" value="${totRate+schrg+totVat+totST}"></c:set>

							<c:set var="netPrice" value="${totPrice-(paidAmount)}"></c:set>
							<c:set var="netTotal" value="${totPrice}"></c:set>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal +0.5 - ((netTotal+0.5) % 1) }" />
								</c:set>
							</c:if>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.doubleRoundOff, 'Y') }">

								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal}" />
								</c:set>
								<c:set var="netTotal">
									<dd:ddformatter place="1" number="${netTotal}"></dd:ddformatter>
								</c:set>
								<c:set var="netTotal">
									<fmt:formatNumber type="number" groupingUsed="false"
										minFractionDigits="2" maxFractionDigits="2"
										value="${netTotal}" />
								</c:set>
							</c:if>
						</c:if>
						<input type="hidden" id="hidstoreroundoffFlag"
							value="${sessionScope.loggedinStore.roundOffTotalAmtStatus}">
						<input type="hidden" id="hidstoredoubleroundoffFlag"
							value="${sessionScope.loggedinStore.doubleRoundOff}"> <input
							type="hidden" id="hidserviceTaxTextVal"
							value="${sessionScope.loggedinStore.serviceTaxText}"> <input
							type="hidden" id="hidvatTaxTextVal"
							value="${sessionScope.loggedinStore.vatTaxText}"> <input
							type="hidden" id="hidserviceTaxVal"
							value="${sessionScope.loggedinStore.serviceTaxAmt}"> <input
							type="hidden" id="hidvatTaxVal"
							value="${sessionScope.loggedinStore.vatAmt}"> <input
							type="hidden" id="hidpaidAmtVal" value="${paidAmount}"> <input
							type="hidden" id="hidcustDiscVal" value="${custDisc}"> <input
							type="hidden" id="hidnetTotal" value="${netTotal}"> <input
							type="hidden" id="hidparcelST"
							value="${sessionScope.loggedinStore.parcelServiceTax}"> <input
							type="hidden" id="hidparcelVat"
							value="${sessionScope.loggedinStore.parcelVat}"> <input
							type="hidden" id="mobPrintVal"
							value="${sessionScope.loggedinStore.mobBillPrint}"> <input
							type="hidden" id="kotPrintVal"
							value="${sessionScope.loggedinStore.kitchenPrintBt}"> <input
							type="hidden" id="printbillpapersize"
							value="${sessionScope.loggedinStore.printBillPaperSize}">
							<input
							type="hidden" id="totalDiscountAmount"
							value="0.0">
						
						
						<%-- <c:if test="${empty orders}">
						<c:if test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
							<input type="hidden" id="serviceChargeRate" value="0">
						  </c:if>
						   <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
							<input type="hidden" id="serviceChargeRate"
								value="${orderTypeList.serviceChargeValue}">
						  </c:if>
						</c:if>
						<c:if test="${!empty orders}">
						<c:if test="${sessionScope.loggedinStore.serviceChargeFlag!='Y'}">
							<input type="hidden" id="serviceChargeRate" value="0">
						  </c:if>
						   <c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
							<input type="hidden" id="serviceChargeRate"
								value="${orders.orderBill.serviceChargeRate}">
						  </c:if>
						</c:if> --%>




						<%-- <input type="hidden" id="hidserviceChargeTextNew"
							value="${sessionScope.loggedinStore.serviceChargeFlag}">
						<input type="hidden" id="hidserviceChargeText" value="S.Charge"> --%>
						<%-- <input type="hidden" id="storeName" value="${sessionScope.loggedinStore.storeName}"> --%>
						<input type="hidden" id="hidtotnonspotDiscAmt"
							value="${totnonspotDiscAmt}">
							<!-- <input type="hidden" id="hidendiscountpercentage"
							value=""> -->
						
					    <!-- Bill Calculation Show End -->
					    
						<div class="col-md-12 col-sm-12"
							style="background-color: #ccc; color: #000;">
							<div class="col-md-6 col-sm-6" style="margin-top: 5px;">
								<a href="javascript:openCashModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 7px;" id="openCashModalBtn"><span
									class="fa fa-usd"></span>&nbsp;CASH </a> <a
									href="javascript:openCardModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 3px;" id="openCardModalBtn"><span
									class="fa fa-credit-card"></span>&nbsp;CARD </a> <a
									href="javascript:openOnlineModal()" class="btn-order-taking"
									style="text-align: center; width: 29%; padding: 8px 7px;" id="openOnlineModalBtn">ONLINE
								</a><a href="javascript:printBillWithReason()"
									class="btn-order-taking" id="printunpaidbillbtn"
									style="text-align: center; width: 46%; margin-top: 2px;"><span
									class="fa fa-print"></span>&nbsp;PRINT </a> <a
									href="javascript:showDelOptModal()" class="btn-order-taking" id="ordersavebtn"
									style="background: #F60; text-align: center; width: 46%; margin-top: 2px;"><i
									class="fa fa-save"></i>&nbsp;SAVE</a>
									
										<%-- <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable!='0'}">
										<c:set var="widthVal" value="96%"></c:set>
										<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									    <a href="javascript:openCreditSaleModal()"
										class="btn-order-taking"
										style="text-align: center; width:auto; margin-top: 2px;">CREDIT
										SALE </a>
								        </c:if>
										</c:if>  --%>
										<%--  <c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable=='0'}"> --%> 
										<%-- <c:set var="widthVal" value="46%"></c:set> --%>
										<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
									      <a href="javascript:openCreditSaleModal()"
										class="btn-order-taking" 
										style="text-align: center; width:46%; margin-top: 2px;">CREDIT
										SALE </a>
								        </c:if>
								             
								        
										<%-- </c:if> --%>
										 
										<%-- <c:if test="${sessionScope.loggedinStore.creditSale!='Y'}">
										<c:set var="widthVal" value="96%"></c:set>
										<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y' && currentTable=='0'}">
									<a href="javascript:openAssignDelBoyModal()"
										class="btn-order-taking"
										style="text-align: center;width:96%; margin-top: 2px;">DELIVERY BOY							
											<spring:message code="order.jsp.DELIVERYBOY"
												text="DELIVERY BOY" />
									</a>
								</c:if>
										</c:if> --%>
										
										<%-- <c:if test="${sessionScope.loggedinStore.creditSale=='Y'}"> --%>
										<%-- <c:set var="widthVal" value="46%"></c:set> --%>
										<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
											
									    <a href="javascript:openAssignDelBoyModal()"
										class="btn-order-taking"
										style="text-align: center;width:46%; margin-top: 2px; padding:10px 5px 10px 5px;">
										    <c:choose>
											    <c:when test="${sessionScope.loggedinStore.id==168}">
											      DOCTOR
											     </c:when>    
											    <c:otherwise>
											       DELIVERY BOY
											    </c:otherwise>
											</c:choose>
										   	<%-- <spring:message code="order.jsp.DELIVERYBOY"
												text="DELIVERY BOY" /> --%>
									    </a>
										</c:if>
										<%-- </c:if> --%>
								
								
								<c:if
									test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
									<a class="hide" href="javascript:printKotCheckList()"
										class="btn-order-taking"
										style="text-align: center; width: 46%; margin-top: 2px; padding: 6px 0px;">&nbsp;KOT
										LIST </a>
									<a class="hide" href="javascript:openSplitPaymentCashModal()"
										class="btn-order-taking"
										style="text-align: center; width: 46%; margin-top: 2px; padding: 6px;">SPLITPAY
									</a>
								</c:if>
							</div>

							<div class="col-md-6 col-sm-6">
								<div class="order-summery">
									<c:if test="${!empty orders}">
										<c:if
											test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'Y') }">
											<c:if test="${orders.orderBill.discountPercentage==0.00}">
												<div id="discPerContId" class="col-md-6 col-sm-3">Discount
													in ${sessionScope.loggedinStore.currency}:</div>
											</c:if>
											<%-- 											<c:set var="totRate"> --%>
											<%-- 												<fmt:formatNumber type="number" groupingUsed="false" --%>
											<%-- maxFractionDigits="2" value="${totRate-custDisc}" /> --%>
											<%-- </c:set> --%>
											<c:if test="${orders.orderBill.discountPercentage!=0.00}">
												<div id="discPerContId" class="col-md-6 col-sm-3">
													Discount ${orders.orderBill.discountPercentage}%:

													<c:set var="custDiscPerc"
														value="${orders.orderBill.discountPercentage}"></c:set>
												</div>
											</c:if>
											<div id="discBtnContId" style="float: right; height: 20px;">
												<fmt:formatNumber type="number" groupingUsed="false"
													minFractionDigits="2" maxFractionDigits="2"
													value="${orders.orderBill.customerDiscount}" />
											</div>
										</c:if>
										<c:if
											test="${fn:containsIgnoreCase(orders.isDiscountAdded, 'N') }">
											<div id="discPerContId" class="col-md-6 col-sm-3">Discount:</div>
											<div id="discBtnContId"
												style="float: right; height: 20px; width: 30%">
												<input type="button" onclick="javascript:openAddDiscount()"
													class="btn btn-success btn btn-xs" style="width: 100%"
													value="ADD" id="openDiscountBtn">
												<%-- <input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;"> --%>
											</div>
										</c:if>
									</c:if>
									<c:if test="${empty orders}">
										<div id="discPerContId" class="col-md-6 col-sm-3">Discount:</div>
										<div id="discBtnContId"
											style="float: right; height: 20px; width: 30%">
											<input type="button" onclick="javascript:openAddDiscount()"
												class="btn btn-success btn btn-xs" style="width: 100%"
												value="ADD" id="openDiscountBtn">
											<%-- <input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;"> --%>
										</div>
									</c:if>
									<%-- <div id="discPerContId" class="col-md-6 col-sm-3">-Discount:</div>
                			<div id="discBtnContId" style="float:right;height: 20px;width: 30%">
                			<input type="button" onclick="javascript:openAddDiscount()" class="btn btn-success btn btn-xs" style="width: 100%" value="ADD">
                				<input type="text" id="discAmtCont" size="4" value="${totDisc}" style="text-align:right;line-height:1px;">
                			</div> --%>
									<br />

									<div class="col-md-4 col-sm-6">SubTotal:</div>
				                    <div id="subtotalcontId"
										style="float: right; font-weight: bold;">
										<fmt:formatNumber type="number" groupingUsed="false"
											minFractionDigits="2" maxFractionDigits="2"
											value="${totRate}" />
									 </div>
										
										<div id="totalratecontId"
										style="float: right; font-weight: bold;display:none;">${totalItemRate1}</div>
										
									<br />

<%-- 									<c:forEach items="${orderTypeList}" var="typeList"> --%>
										<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y' }">
										<c:if test="${sessionScope.matchedOrderType.serviceChargeValue!=0.0 && sessionScope.matchedOrderType.serviceChargeValue!=0}">
										<span id="serviceChargeSpan">
										    <div class="col-md-3 col-sm-6">S.Charge
											</div>
											<div id="serviceCharge" class="col-md-6 col-sm-6">
											<c:if test="${sessionScope.matchedOrderType.serviceChargeValue!=0.0 && sessionScope.matchedOrderType.serviceChargeValue!=0}">
                       						 (${sessionScope.matchedOrderType.serviceChargeValue}%)
                       						</c:if>
                       						:
                       						</div> 
										<div id="schrgId" style="float: right; font-weight: bold;">${schrg}</div>
										<br />
										</span>
									</c:if>
									</c:if>
									<%-- </c:forEach> --%>
									<c:if
										test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
										<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.vatTaxText}
											<c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=164 && sessionScope.loggedinStore.id!=120 && sessionScope.loggedinStore.id!=149 && sessionScope.loggedinStore.id!=47 }">
												<c:if test="${sessionScope.loggedinStore.vatAmt!=0.0}">
                			    					(${sessionScope.loggedinStore.vatAmt}%)
                			    	</c:if>:
                			 		</c:if>
										</div>
										
										<div id="vatcontId" style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totVat}" />
										</div>
										<br />
									</c:if>
									<c:if
										test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
										<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.serviceTaxText}
											<c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=164 && sessionScope.loggedinStore.id!=120 && sessionScope.loggedinStore.id!=149 && sessionScope.loggedinStore.id!=47}">
												<c:if
													test="${sessionScope.loggedinStore.serviceTaxAmt!=0.0}">
                			     					(${sessionScope.loggedinStore.serviceTaxAmt}%)
                			    </c:if>:
                			  </c:if>
										</div>
									
											<div id="servicetaxcontId"
											style="float: right; font-weight: bold;"><fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totST}" /></div>
										<br />
									</c:if>
									<div class="col-md-6 col-sm-3">
										<strong>Total(${sessionScope.loggedinStore.currency}):</strong>
									</div>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
										<div id="grandtotalcontId"
											style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totPrice +0.5 - ((totPrice+0.5) % 1) }" />
										</div>
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
										<div id="grandtotalcontId"
											style="float: right; font-weight: bold;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${totPrice}" />
										</div>
									</c:if>
									<br />
									<div class="col-md-6 col-sm-6">
										<strong>Amt.ToPay:</strong>
									</div>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
										<div id="amttopaycontId"
											style="float: right; font-weight: bold; background: #fff;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${netPrice +0.5 - ((netPrice+0.5) % 1) }" />
										</div>
									</c:if>
									<%-- 	<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
										<div id="amttopaycontId"
											style="float: right; font-weight: bold; background: #fff;">
											<fmt:formatNumber type="number" groupingUsed="false"
												minFractionDigits="2" maxFractionDigits="2"
												value="${netPrice}" />
										</div>
									</c:if> --%>


									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
										<c:choose>
											<c:when
												test="${fn:containsIgnoreCase(sessionScope.loggedinStore.doubleRoundOff, 'Y') }">
												<%-- <div id="amttopaycontId" style="float:right; font-weight:bold;background: #fff;"><fmt:formatNumber type="number" groupingUsed="false"  minFractionDigits="2"   maxFractionDigits="2" value="${netPrice +0.05 - ((netPrice+0.05) % .1) }"/></div> --%>
												<c:set var="netPrice">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</c:set>
												<c:set var="netPrice">
													<%-- <dd:ddformatter place="1" number="${netPrice}"></dd:ddformatter> --%>
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</c:set>
												<c:set var="netPrice">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</c:set>
												<div id="amttopaycontId"
													style="float: right; font-weight: bold; background: #fff;">${netPrice}</div>
											</c:when>
											<c:otherwise>
												<div id="amttopaycontId"
													style="float: right; font-weight: bold; background: #fff;">
													<fmt:formatNumber type="number" groupingUsed="false"
														minFractionDigits="2" maxFractionDigits="2"
														value="${netPrice}" />
												</div>
											</c:otherwise>
										</c:choose>
									</c:if>


									<br />

								</div>
							</div>
						</div>
					</div>

				</div>
				<c:choose>
					<c:when
						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.menuCollapsable, 'Y') }">
						<div class="col-md-5 col-sm-5">
						        <div class="col-md-12 col-sm-12" style="background: #939393; font-size: 16px; font-weight: bold;">
						          <div class="col-md-6 col-sm-6">
						             
								            &nbsp;NAME&nbsp;<input type="text" id="itemCodeSearch"
									        style="color: #222222;" size="15" placeholder="Item Name...">
							         
							      </div>
							      <%-- <c:if test="${sessionScope.loggedinStore.isBarcode =='Y'}">
									<div class="col-md-6 col-sm-6"
										style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
										&nbsp;CODE&nbsp;&nbsp;<input type="text" id="itemBarCodeSearch"
											style="color: #222222;width: 50%"
											placeholder="Code..."/>
										<button type="button" style="padding: 2px 5px 2px 5px;"
											onclick="javascript:addBarcodeItem(document.getElementById('itemBarCodeSearch').value)"
											class="btn btn-default">
											<span class="fa fa-plus"></span>
										</button>

									</div>
								</c:if> --%>
								              <c:set var = "advorderno" scope = "session" value = "${noofpreorder}"/>
						                      <c:if test = "${advorderno > 0}">
 						                          <div class="col-md-6 col-sm-6">
								                       <a href="javascript:openadvtblbooklistsearchmodal()"><font size="3" color="black" style="font-weight: bold;background-color:#FF3C33;">${noofpreorder}&nbsp;<spring:message code="admin.admleftpanel.jsp.prebookingnotice" text="Advance Bookings" /></font></a>
						                          </div>
						                     </c:if> 
							    </div>   
							      
							<div style="height: 500px; width: 100%; overflow-y: auto;">
								<div id="menu_items_container"></div>
							</div>
						</div>
					   </c:when>
					 <c:otherwise>
						<c:if test="${!empty allmenu }">
							<c:forEach items="${allmenu.menucategory}" var="item"
								varStatus="itemStat">
								<c:if
									test="${fn:length(item.menucategory)==1 && fn:length(allmenu.menucategory)==1}">
									<c:set var="menucatlength" value="1"></c:set>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${menucatlength==1}">
																		<c:set var="menucatlength" value="1"></c:set>
									<div class="col-md-8 col-sm-8">

										<div style="height: 500px; width: 100%; overflow-y: auto;">
											<div id="waitimage" align="center">
												<img alt=""
													src="${pageContext.request.contextPath}/assets/images/wait/wait1.gif"
													height="150" width="150">
											</div>
											<div id="menu_items_container"></div>
										</div>
									</div>
									<c:forEach items="${allmenu.menucategory}" var="item"
										varStatus="itemStat">
										<a href="#${item.id}" class="list-group-item menucathead${itemStat.index}" data-toggle="collapse" data-parent="#accord">${item.menuCategoryName}</a>
            							<div class="collapse" id="${item.id}">
										<c:forEach items="${item.menucategory }" var="itemSub">
											<input type="hidden" value="${itemSub.id}"
												id="menucatitemsubid">
											<input type="hidden" value="${itemStat.index}"
												id="menucatitemsubindex">
											<input type="hidden" value="1" id="menucatitemsublength">
										</c:forEach>
										<!-- </div> -->
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="col-md-6 col-sm-6">
										<!-- <div
											style="background: #939393; font-size: 16px; font-weight: bold;">
											&nbsp;NAME&nbsp;<input type="text" id="itemCodeSearch"
												style="color: #222222;" size="15" placeholder="Item Name...">
										</div> -->
										<div class="col-md-12 col-sm-12" style="background: #939393; font-size: 16px; font-weight: bold;">
											<div class="col-md-6 col-sm-6">

												&nbsp;NAME&nbsp;<input type="text" id="itemCodeSearch"
													style="color: #222222;" size="15"
													placeholder="Item Name...">

											</div>
											<%-- <c:if test="${sessionScope.loggedinStore.isBarcode =='Y'}">
												<div class="col-md-6 col-sm-6"
													style="color: #FFF; background: #404040; font-size: 14px; font-weight: bold;">
													&nbsp;CODE&nbsp;&nbsp;<input type="text"
														id="itemBarCodeSearch" style="color: #222222; width: 50%"
														placeholder="Code..." />
													<button type="button" style="padding: 2px 5px 2px 5px;"
														onclick="javascript:addBarcodeItem(document.getElementById('itemBarCodeSearch').value)"
														class="btn btn-default">
														<span class="fa fa-plus"></span>
													</button>

												</div>
											</c:if> --%>
											<c:set var = "advorderno" scope = "session" value = "${noofpreorder}"/>
						                      <c:if test = "${advorderno > 0}">
 						                          <div class="col-md-6 col-sm-6">
								                       <a href="javascript:openadvtblbooklistsearchmodal()"><font size="3" color="black" style="font-weight: bold;background-color:#FF3C33;">${noofpreorder}&nbsp;<spring:message code="admin.admleftpanel.jsp.prebookingnotice" text="Advance Bookings" /></font></a>
						                          </div>
						                     </c:if> 
										</div>
										<div style="height: 500px; width: 100%; overflow-y: auto;">
											<div id="menu_items_container"></div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:otherwise> 
				</c:choose>

				<c:choose>
					<c:when
						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.menuCollapsable, 'Y') }">
						<div class="col-md-3 col-sm-3">
							<div class="menu-category"
								style="height: 100%; font-size: 12px; font-weight: bold;">
								<div style="overflow-y: auto; height: 500px; background: white;">
									<div id="accord" style="padding: 5px;">
										<div class="list-group panel"
											style="background: #404040; text-align: center; text-transform: uppercase;">
											<c:if test="${empty allmenu }">
            					No Menu found!!!!
            				</c:if>
											<c:if test="${!empty allmenu }">
												<c:forEach items="${allmenu.menucategory}" var="item"
													varStatus="itemStat">
													<%-- <a href="#${item.id}" class="list-group-item menucathead${itemStat.index}" data-toggle="collapse" data-parent="#accord">${item.menuCategoryName}</a>
            							<div class="collapse" id="${item.id}"> --%>
													<c:forEach items="${item.menucategory }" var="itemSub">
														<a
															href="javascript:clickonSubmenu(${itemSub.id}, ${itemStat.index})"
															style="display: inline; margin-bottom: 5px; margin-top: -1px; padding: 5px; position: relative; color: #fff; width: 47%; float: left; margin-right: 5px; height: 45px;"
															class="menucathead${itemStat.index}">${itemSub.menuCategoryName}</a>
													</c:forEach>
													<!-- </div> -->
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:if test="${menucatlength==1}">
							<div id="litewebpos" class="col-md-2 col-sm-2"
								style="background: #fff;">
						</c:if>
						<c:if test="${menucatlength!=1}">
							<div class="col-md-2 col-sm-2" style="background: #fff;">
						</c:if>
						<div class="menu-category" style="height: 100%;">
							<div style="overflow-y: auto; height: 500px; background: #fff;">
								<div id="accord" style="padding: 5px;">
									<div class="list-group panel"
										style="background: #fff; text-align: center; text-transform: uppercase;">
										<c:if test="${empty allmenu }">
            					No Menu found!!!!
            				</c:if>
										<c:if test="${!empty allmenu }">
											<c:forEach items="${allmenu.menucategory}" var="item"
												varStatus="itemStat">
												<a href="#${item.id}"
													class="list-group-item menucathead${itemStat.index}"
													data-toggle="collapse" data-parent="#accord">${item.menuCategoryName}</a>
												<div class="collapse" id="${item.id}">
													<c:forEach items="${item.menucategory }" var="itemSub">
														<a
															href="javascript:clickonSubmenu(${itemSub.id}, ${itemStat.index})"
															class="list-group-item item_sub_child">${itemSub.menuCategoryName}</a>
													</c:forEach>
												</div>
											</c:forEach>
										</c:if>
									</div>
								</div>
							</div>
						</div>
			</div>
			</c:otherwise>
			</c:choose>


		</div>

		<!-- modal start -->
		<div class="modal fade" data-backdrop="static" id="delOptModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Delivery
							Option</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="radio" id="deliveryOptionDine" name="deliveryOption"
								value="dineIn">&nbsp;&nbsp;Dine In&nbsp;&nbsp; <input
								type="radio" id="deliveryOptionParcel" name="deliveryOption"
								value="parcel">&nbsp;&nbsp;Parcel
							<!-- for saravanaa -->
							<div style="display: none;">
								<input type="radio" id="deliveryOptionHomedel"
									name="deliveryOption" value="homeDel">&nbsp;&nbsp;Home
								Delivery
							</div>
							<!-- end for saravanaa -->
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" style="background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javascript:createOrder()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">DONE</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" data-backdrop="static" id="ParceldelOptModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Delivery
							Option</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="radio" id="PdeliveryOptionDine"
								name="deliveryOptionParcel" value="dineIn">&nbsp;&nbsp;Dine
							In&nbsp;&nbsp; <input type="radio" id="PdeliveryOptionParcel"
								name="deliveryOptionParcel" value="parcel">&nbsp;&nbsp;Parcel

						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" style="background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javascript:showCustDetailsModal()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">DONE</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="orderModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">SUCCESS</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div align="center" style="text-align: left; font-size: 20px;">
							<!-- 								TABLE NO:   -->
							<span class="hide" id="modTabCont">00</span> ORDER NO: <span
								id="modOrderCont" class="hide">00</span>  <span
								id="modOrderSuccessStoreBasedOrderCont">00</span><br></br>
							<table>
								<tr>
									<td>AMOUNT&nbsp;&nbsp;</td>
									<td>:</td>
									<td align="right">&nbsp;&nbsp;<span id="modAmtCont">0.00</span></td>
									<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
								</tr>
								<tr>
									<td>ITEM DISCOUNT&nbsp;&nbsp;</td>
									<td>:</td>
									<td align="right">&nbsp;&nbsp;<span id="modDiscCont">0.00</span></td>
									<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
								</tr>
								<tr>
									<td>TOTAL AMT&nbsp;&nbsp;</td>
									<td>:</td>
									<td>&nbsp;&nbsp;<span id="modtotAmtCont">0.00</span></td>
									<td>&nbsp;&nbsp;${sessionScope.loggedinStore.currency}</td>
								</tr>

							</table>
							<br> (Taxes charge Extra)
						</div>
						<br>
						<div id="instantPaycontId" align="center"
							style="text-align: left; font-size: 20px;"></div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<div id="parcelInstantPrintBillContId" style="float: left;"></div>
						<button type="button" onclick="javascript:orderSuccessOK()"
							style="background: #72BB4F; font-weight: bold; width: 25%"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="cashModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							ORDER NO: <span id="cashmodOrderCont" style="display:none">00</span>
							          <span id="cashmodStoreBasedOrderNumberCont">00</span> <span
								class="hide" style="float: right;">TABLE NO: <span
								id="cashmodTabCont">00</span></span>

						</h4>

					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div align="center" style="font-size: 20px;">
							<div style="padding: 5px;">
								TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cashtotamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								PAID AMOUNT :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
									id="cashpaidamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="cashamttopaycontId">0.00</span>
							</div>
							<div style="padding: 3px;">
								TENDER AMOUNT :&nbsp;<input type="text"
									onkeyup="javascript:getChangeAmt(this.value)" value=""
									id="cashtenderAmt" style="text-align: center; color: #222222"
									size="4" />
							</div>
							<div style="padding: 5px;">
								CHANGE AMOUNT :&nbsp;<span id="cashchangeamtcontId">0.00</span>
							</div>
							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="paycashalertMsg"></div>
						</div>

						<div align="center" style="font-size: 20px;">
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
								<div style="padding: 5px;">
									<input type="checkbox" id="chkprintBillCash"
										style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;PRINT
									PAID BILL
								</div>
								<br />
							</c:if>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
								<table class="ui-bar-a" id="n_keypad"
									style="display: none; -khtml-user-select: none;">
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040; padding: 0 0;"
											class="btn btn-primary btn-lg" id="numero100"><img
												src="${pageContext.request.contextPath}/assets/images/base/payment/rm100.png" /></a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero7">7</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero8">8</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero9">9</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-danger btn-lg" id="del">x</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040; padding: 0 0;"
											class="btn btn-primary btn-lg" id="numero50"><img
												src="${pageContext.request.contextPath}/assets/images/base/payment/rm50.png" /></a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero4">4</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero5">5</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero6">6</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-warning btn-lg" id="clear">c</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040; padding: 0 0;"
											class="btn btn-primary btn-lg" id="numero20"><img
												src="${pageContext.request.contextPath}/assets/images/base/payment/rm20.png" /></a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero1">1</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero2">2</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero3">3</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numerodot">&nbsp;.</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040; padding: 0 0;"
											class="btn btn-primary btn-lg" id="numero10"><img
												src="${pageContext.request.contextPath}/assets/images/base/payment/rm10.png" /></a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040; padding: 0 0;"
											class="btn btn-primary btn-lg" id="numerorm5"><img
												src="${pageContext.request.contextPath}/assets/images/base/payment/rm5.png" /></a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="zero">0</a></td>
										<td colspan="4"><a data-role="button"
											style="border: 2px solid #404040; width: 184px;"
											data-theme="done" class="btn btn-success btn-lg" id="done">DONE</a></td>
									</tr>
								</table>
							</c:if>
						</div>

					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" id="paybycashbtn"
							onclick="javascript:payByCash(document.getElementById('cashtenderAmt').value)"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">PAY</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static"
			id="cashSplitPaymentModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							ORDER NO: <span id="cashmodSplitPaymentOrderCont">00</span> <span
								class="hide" style="float: right;">TABLE NO: <span
								id="cashmodSplitPaymentTabCont">00</span></span>

						</h4>

					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div align="center" style="font-size: 20px;">
							<div id="cashmodSplitPaymentBody"></div>

							<div id="cashmodSplitPaymentBodyAmountDetails"></div>
							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="splitpaycashalertMsg"></div>
						</div>

					</div>
					<div class="alert alert-danger">
						<strong>*</strong> Please close the window after paying all bill
						amount otherwise your data may be lost.
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" id="splitPaymentBtn"
							onclick="javascript:paySplitAmtByCash(document.getElementById('splitpaymentamttopaycontId').value)"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success disabled">PAY</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="cardModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							ORDER NO: <span id="cardmodOrderCont" class="hide">00</span>
							           <span id="cardmodStoseBasedOrderCont">00</span> <span
								class="hide" style="float: right;">TABLE NO: <span
								id="cardmodTabCont">00</span></span>

						</h4>

					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div align="center" style="font-size: 20px;">
							<div style="padding: 5px;">
								TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cardtotamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								PAID AMOUNT :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
									id="cardpaidamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="cardamttopaycontId">0.00</span>
							</div>
							<div style="padding: 3px;">
								TENDER AMOUNT&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text"
									id="cardtenderAmt" style="text-align: center; color: #222222"
									size="4" />
							</div>
							<c:if
								test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
								<div>
									CARD TYPE: <input type="radio" id="cardTypeVisa"
										name="cardType" value="Visa"
										onclick="javascript:checkCardType(this.value)"> <img
										src="${pageContext.request.contextPath}/assets/images/base/payment/visa_card.png" />&nbsp;&nbsp;
									<input type="radio" id="cardTypeMaster" name="cardType"
										value="Master" onclick="javascript:checkCardType(this.value)">
									<img
										src="${pageContext.request.contextPath}/assets/images/base/payment/master_card.png" />&nbsp;&nbsp;
									<input type="radio" id="cardTypeOther" name="cardType"
										value="Other" onclick="javascript:checkCardType(this.value)">
									<img
										src="${pageContext.request.contextPath}/assets/images/base/payment/other_card.png" />
								</div>
							</c:if>
							<div style="padding: 5px; display: none;" id="cardTypeNameDiv">
								CARD TYPE NAME:&nbsp;&nbsp;&nbsp; <input type="text"
									id="cardTypeName" value="card"
									style="text-align: center; color: #222222" size="12" />
							</div>
					<!-- 		<div style="padding: 5px;">
								CARD LAST 4 DIGIT :&nbsp;<input type="text"
									id="cardlastfourDigit"
									style="text-align: center; color: #222222" size="4" />
							</div>
 -->

							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="paycardalertMsg"></div>
							</div>

						<div align="center" style="font-size: 20px;">
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
								<div style="padding: 5px;">
									<input type="checkbox" id="chkprintBillCard"
										style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;PRINT
									PAID BILL
								</div>
								<br />
							</c:if>
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
								<table class="ui-bar-a" id="n_keypad_cr"
									style="display: none; -khtml-user-select: none;">
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero7_cr">7</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero8_cr">8</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero9_cr">9</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-danger btn-lg" id="del_cr">x</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero4_cr">4</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero5_cr">5</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero6_cr">6</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-warning btn-lg" id="clear_cr">c</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero1_cr">1</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero2_cr">2</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero3_cr">3</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numerodot_cr">&nbsp;.</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="zero_cr">0</a></td>
										<td colspan="4"><a data-role="button"
											style="border: 2px solid #404040; width: 184px;"
											data-theme="done" class="btn btn-success btn-lg" id="done_cr">DONE</a></td>
									</tr>
								</table>
							</c:if>
						</div>
						<div align="center" style="font-size: 20px;">
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
								<table class="ui-bar-a" id="n_keypad_cr1"
									style="display: none; -khtml-user-select: none;">
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero7_cr1">7</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero8_cr1">8</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero9_cr1">9</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-danger btn-lg" id="del_cr1">x</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero4_cr1">4</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero5_cr1">5</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero6_cr1">6</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-warning btn-lg" id="clear_cr1">c</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero1_cr1">1</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero2_cr1">2</a></td>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numero3_cr1">3</a></td>
										<td><a data-role="button" data-theme="e"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="numerodot_cr1">&nbsp;.</a></td>
									</tr>
									<tr>
										<td><a data-role="button" data-theme="b"
											style="border: 2px solid #404040;"
											class="btn btn-primary btn-lg" id="zero_cr1">0</a></td>
										<td colspan="4"><a data-role="button"
											style="border: 2px solid #404040; width: 184px;"
											data-theme="done" class="btn btn-success btn-lg"
											id="done_cr1">DONE</a></td>
									</tr>
								</table>
							</c:if>
						</div>

					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" id="paybycardbtn"
							onclick="javascript:payByCard(document.getElementById('cardtenderAmt').value)"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">PAY</button>
					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" data-backdrop="static" id="onlineModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							ORDER NO: <span id="onlinemodOrderCont" class="hide">00</span> 
							<span id="onlineStoreBasedmodOrderCont">00</span><span
								class="hide" style="float: right;">TABLE NO: <span
								id="onlinemodTabCont">00</span></span>

						</h4>

					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div align="center" style="font-size: 20px;">
							<div style="padding: 5px;">
								PAYMENT MODE :&nbsp;&nbsp;&nbsp;<span id="onlineselpaymenttype">paytm</span>
							</div>
							<div style="padding: 5px;">
								TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="onlinetotamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								PAID AMOUNT :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
									id="onlinepaidamtcontId">0.00</span>
							</div>
							<div style="padding: 5px;">
								AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="onlineamttopaycontId">0.00</span>
							</div>
							<div style="padding: 3px;">
								TENDER AMOUNT&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text"
									id="onlinetenderAmt" style="text-align: center; color: #222222"
									size="4" />
							</div>

							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="payonlinealertMsg"></div>
							<input type="hidden" id="selpaymentmode" value="">
						</div>

						<div align="center" style="font-size: 20px;">
							<c:if
								test="${fn:containsIgnoreCase(sessionScope.loggedinStore.printPaidBill, 'N') }">
								<div style="padding: 5px;">
									<input type="checkbox" id="chkprintBillonline"
										style="transform: scale(2.5); -webkit-transform: scale(2.5);" />&nbsp;&nbsp;&nbsp;PRINT
									PAID BILL
								</div>
								<br />
							</c:if>

						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" id="paybyonlinebtn"
							onclick="javascript:payByOnline(document.getElementById('onlinetenderAmt').value)"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">PAY</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static"
			id="paymodeselectionModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Payment
							Mode</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;"
							id="paymodeselectiondiv"></div>
						<div style="text-align: center; font-size: 20px;"
							id="paymodeselectiontext"></div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button"
							style="background: #72BB4F; font-weight: bold;"
							class="btn btn-success" onclick="getpaymod()">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static"
			id="notavailableonlinepaymentModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">No online
							payment mode available.</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">

						<button type="button"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="directOrderModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">Please
							select table first and take order!</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							onclick="location.href='${pageContext.request.contextPath}/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0'"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="specialnoteModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!--   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Special
							Note</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="max-height: 300px; overflow-y: auto;">
							<div style="font-size: 20px;" id="spnoteitemlistContId"></div>
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" style="background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javascript:savespecialNote()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">SUBMIT</button>
					</div>
				</div>
			</div>
		</div>




		<div class="modal fade" data-backdrop="static" id="noOrderTypeModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">There is
							no order type in present store. Please add order types first !!</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							onclick="location.href='${pageContext.request.contextPath}/home/welcome.htm'"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" data-backdrop="static"
			id="alertselectItemModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">Please add
							any items!</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" data-backdrop="static"
			id="alertModalForShortKey" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;" id="alertText"></div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" data-backdrop="static"
			id="alertsaveOrderModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">Please
							save the order first!</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static"
			id="confirmdeleteorderitemModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Confirmation!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">Are you
							sure?</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="background: #F60; font-weight: bold; width: 25%;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javacsript:deleteorderItemRow()"
							style="background: #72BB4F; font-weight: bold; width: 25%;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static" id="parcelpayOptModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Do
							you want to pay?</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="radio" id="parcelpayOptionCash" checked="checked"
								name="parcelpayOption" value="cash">&nbsp;&nbsp;Cash&nbsp;&nbsp;
							<input type="radio" id="parcelpayOptionCard"
								name="parcelpayOption" value="card">&nbsp;&nbsp;Card

						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" style="background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javascript:parcelPayment()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">PAY</button>
					</div>
				</div>
			</div>
		</div>



		<div class="modal fade" data-backdrop="static" id="discountModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							<spring:message code="order.jsp.AddDiscount" text="Add Discount" />
							<span style="margin-left: 50%;"><input type="checkbox"
								id="ncbill"
								style="transform: scale(1.7); -webkit-transform: scale(1.7);">
								Nonchargeable</span>
						</h4>

					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div>
							<spring:message code="order.jsp.ORDERNO" text="ORDER NO" />
							<span id="discmodOrderCont" class="hide">00</span><span id="discmodStoreBasedOrderCont">00</span> <span id="discmodTabCont"></span>
						</div>
						<div align="center" style="font-size: 20px;">
							<input type="hidden" id="discmodstorediscFlagcontId"
								value="${sessionScope.loggedinStore.discountPercentage}">
							<input type="hidden" id="discmodstorecurrencycontId"
								value="${sessionScope.loggedinStore.currency}">
							<table>
								<tr>
									<td><spring:message code="order.jsp.TOTALAMOUNT"
											text="TOTAL AMOUNT" /></td>
									<td>:</td>
									<td id="discmodtotamtcontId"></td>
								</tr>
								<tr class="hide" id="totdiscountableAmtrowId">
									<td><spring:message code="order.jsp.DISCOUNTABLEAMOUNT"
											text="DISCOUNTABLE AMOUNT" /></td>
									<td>:</td>
									<td id="discmoddiscountableamtcontId"></td>
								</tr>
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'Y') }">
									<tr id="trdiscperc">
										<td><spring:message code="order.jsp.DISCPERCENTAGE"
												text="DISCOUNT(%)" /></td>
										<td>:</td>
										<td><input type="text" id="discModdiscPer" value="" onkeydown="javascript:numcheck(event)"
											onkeyup="javascript:calculateDiscAmt(this.value)" size="4"
											style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
									</tr>
									<tr id="trdiscamt">
										<td><spring:message code="order.jsp.DISCAMOUNT"
												text="DISC  AMOUNT" /></td>
										<td>:</td>
										<td><input type="text" id="discModdiscAmt"
											disabled="disabled" size="4"
											style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
								</c:if>
								<c:if
									test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'N') }">
									<tr id="trdiscperc">
										<td><spring:message code="order.jsp.DISCPERCENTAGE"
												text="DISCOUNT(%)" /></td>
										<td>:</td>
										<td><input type="text" id="discModdiscPer"
											disabled="disabled" value="0.00" size="4"
											style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
									</tr>
									<tr id="trdiscamt">
										<td><spring:message code="order.jsp.DISCAMOUNT"
												text="DISC  AMOUNT" /></td>
										<td>:</td>
										<td><input type="text" id="discModdiscAmt" size="4" onkeydown="javascript:numcheck(event)" onkeyup="javascript:calculateDiscPercentage(this.value)"
											style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
								</c:if>
								<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'M') }">
										<tr id="trdiscperc">
											<td><spring:message code="order.jsp.DISCPERCENTAGE"
													text="DISCOUNT(%)" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer" value="" onkeydown="javascript:numcheck(event)"
												onkeyup="javascript:calculateDiscAmt(this.value)" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr id="trdiscamt">
											<td><spring:message code="order.jsp.DISCAMOUNT"
													text="DISC  AMOUNT" /></td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt" size="4" onkeydown="javascript:numcheck(event)" onkeyup="javascript:calculateDiscPercentage(this.value)"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
								
								
								
								<tr>
									<td><spring:message code="order.jsp.reason" text="REASON" /></td>
									<td>:</td>
									<td><input type="text" id="discreason"
										style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
								</tr>
							</table>
							<!-- <div style="padding: 5px;">TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="discmodtotamtcontId">0.00</span></div>
                                           		<div style="padding: 3px;">DISC PERCENTAGE :&nbsp;<input type="text"   value="" id="discModdiscPer" style="text-align:center; color: #222222" size="4"/> % </div>
                                           		<div style="padding: 5px;">DISC AMOUNT :&nbsp;<input type="text"   value="" id="discModdiscAmt" style="text-align:center; color: #222222" size="4"/></div> -->
							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="discAddalertMsg"></div>
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">
							<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						</button>
						<button type="button" onclick="javascript:AddDiscount()"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">
							<spring:message code="order.jsp.ADD" text="ADD" />
						</button>
					</div>
				</div>
			</div>
		</div>


		<%-- <div class="modal fade" data-backdrop="static" id="discountModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Add
								Discount</h4>

						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div>
								ORDER NO: <span id="discmodOrderCont">00</span> <span
									class="hide" style="float: right;">TABLE NO: <span
									id="discmodTabCont">00</span></span>
							</div>
							<div align="center" style="font-size: 20px;">
								<input type="hidden" id="discmodstorediscFlagcontId"
									value="${sessionScope.loggedinStore.discountPercentage}">
								<input type="hidden" id="discmodstorecurrencycontId"
									value="${sessionScope.loggedinStore.currency}">
								<table>
									<tr>
										<td>TOTAL AMOUNT</td>
										<td>:</td>
										<td id="discmodtotamtcontId"></td>
									</tr>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'Y') }">
										<tr>
											<td>DISC PERCENTAGE(%)</td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer" value=""
												onkeyup="javascript:calculateDiscAmt(this.value)" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr>
											<td>DISC AMOUNT</td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt"
												disabled="disabled" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
									<c:if
										test="${fn:containsIgnoreCase(sessionScope.loggedinStore.discountPercentage, 'N') }">
										<tr>
											<td>DISC PERCENTAGE(%)</td>
											<td>:</td>
											<td><input type="text" id="discModdiscPer"
												disabled="disabled" value="0.00" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px; margin-top: 5px;" /></td>
										</tr>
										<tr>
											<td>DISC AMOUNT</td>
											<td>:</td>
											<td><input type="text" id="discModdiscAmt" size="4"
												style="text-align: center; width: 95%; color: #222222; margin-bottom: 5px;" /></td>
										</tr>
									</c:if>
								</table>
								<!-- <div style="padding: 5px;">TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="discmodtotamtcontId">0.00</span></div>
                                           		<div style="padding: 3px;">DISC PERCENTAGE :&nbsp;<input type="text"   value="" id="discModdiscPer" style="text-align:center; color: #222222" size="4"/> % </div>
                                           		<div style="padding: 5px;">DISC AMOUNT :&nbsp;<input type="text"   value="" id="discModdiscAmt" style="text-align:center; color: #222222" size="4"/></div> -->
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="discAddalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button" onclick="javascript:AddDiscount()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">ADD</button>
						</div>
					</div>
				</div>
			</div> --%>

		<div class="modal fade" data-backdrop="static"
			id="alerteditOrderquantityModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="hidden" id="hiddmanualeditItemId" value="">
							Please enter a valid number!
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="javascript:setOrderItemManualQty()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>

		<%-- 	<div class="modal fade" data-backdrop="static"
			id="parcelCustDetailsModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto; width: 50%;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							<spring:message code="order.jsp.CustomerDetails"
								text="Customer Details" />
							<span style="float: right;"> Order Type : <span
								id="modOrderType">N/A</span>
							</span>
						</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff; width: 100%; padding: 5px;">
						<ul id="customerdetails"
							class="nav nav-tabs nav-justified st-nav-tabs"
							style="background: #404040; color: #fff;">
							<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#transactionsummarydiv"
								onclick="javascript:gotransactionsummary()">Transaction
									Summary</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#transactionhistorydiv"
								onclick="javascript:gotransactionhistory()">Transaction
									History</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#paymentsummarydiv"
								onclick="javascript:gopaymentsummary()">Payment Summary</a></li>
						</ul>
						<div class="tab-content"
							style="background: #404040; border-top: 10px solid #404040;">
							<div id="home" class="tab-pane fade in active"
								style="background: #404040;">
								<!--       											<div class="modal-category" style="background: #404040;color: #fff;">-->
								<div style="text-align: left; font-size: 18px;">
									<table align="center">
										<c:if test="${!empty orders}">
											<tr>
												<td><spring:message code="order.jsp.PHONENO"
														text="PHONE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustPhone" 
													value="${orders.customerContact}" autocomplete="off"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													readonly /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.CUSTOMERNAME"
														text="CUSTOMER NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustName"
													value="${orders.customerName}"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													readonly /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.location"
														text="LOCATION" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustlocation"
													value="${orders.location}"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													readonly /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.ADDRESS"
														text="ADDRESS" /></td>
												<td>:</td>
												<td><textarea id="modparcelcustAddress" rows="2"
														style="margin-bottom: 2px; color: #222222; width: 95%;">${orders.deliveryAddress}</textarea>
												</td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.DELIVERYPERSONNAME"
														text="DELIVERY PERSON NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparceldeliveryPersonName"
													value="${orders.deliveryPersonName}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.houseno"
														text="HOUSE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcusthouseno"
													value="${orders.houseNo}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.streetno"
														text="STREET NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcuststreet"
													value="${orders.street}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td>Cust VAT/CST:</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustvatorcst"
													value="${orders.custVatRegNo}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<td><spring:message code="order.jsp.custDOB"
													text="DATE OF BIRTH" /></td>
											</td>
											<td>:</td>

											<td><input type="text" id="modparcelcustdob" size="10"
												style="margin-bottom: 2px; color: #222222; width: 95%;"
												value=""></td>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${orders.dob}"/>
											</tr>

											<tr>
												<td><spring:message code="order.jsp.custAnniversary"
														text="ANNIVERSARY DATE" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustanniversary"
													size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value=""></td>
											</tr>
										</c:if>
										<c:if test="${empty orders}">
											<tr>
												<td><spring:message code="order.jsp.PHONENO"
														text="PHONE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustPhone" maxlength="10" value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													autofocus="autofocus" onkeypress='return isNumberKey(event)'/></td>
												<td><button type="button"
														onclick="javascript:searchCustomer()"
														class="btn btn-success"
														style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
														<spring:message code="order.jsp.SEARCH" text="SEARCH" />
													</button></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.CUSTOMERNAME"
														text="CUSTOMER NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustName" value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.location"
														text="LOCATION" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustlocation"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.ADDRESS"
														text="ADDRESS" /></td>
												<td>:</td>
												<td><textarea id="modparcelcustAddress" rows="2"
														style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea>
												</td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.DELIVERYPERSONNAME"
														text="DELIVERY PERSON NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparceldeliveryPersonName"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.houseno"
														text="HOUSE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcusthouseno"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.streetno"
														text="STREET NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcuststreet"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td>Cust. VAT/CST:</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustvatorcst"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.custDOB"
														text="DATE OF BIRTH" /></td>
												</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustdob" size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">
												</td>
											</tr>

											<tr>
												<td><spring:message code="order.jsp.custAnniversary"
														text="ANNIVERSARY DATE" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustanniversary"
													size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>
											</tr>

										</c:if>
									</table>

									<div
										style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
										id="parcelCustModalalertMsg"></div>
								</div>
							</div>
							<!--     										</div>    -->
							<div id="transactionsummarydiv" class="tab-pane fade" style="background: #404040;border-top: 1px solid #404040;color: #fff; important!">
												<div style="text-align: left;font-size: 18px;">
                           							<table align="center">
                                            		<tr >
                                            			<td><spring:message code="order.jsp.TOTALTRANSACTION" text="TOTAL AMOUNT"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="modtotaltransaction"></td>
                                            		</tr>
                                            		<tr >
                                            			<td><spring:message code="order.jsp.LASTVISITDATE" text="LAST VISIT DATE"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="modlastvisitdate"></td>
                                            		</tr>
                                            		<tr >
                                            			<td><spring:message code="order.jsp.TOTALPAIDAMT" text="TOTAL PAID AMOUNT"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="modtotalpaidamt"></td>
                                            		</tr>
                                            
                                           		</table>
                                           		
                                           		<table style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;">
                                           		<thead>
                                           		<tr style="border-bottom: 1px dashed;">
        										<th width="5%;"><spring:message code="reprintcash.jsp.invno" text="SNo" /></th>
         										<th width="30%;"><spring:message code="item.jsp.name" text="Item Name" /></th>
												<th width="6%;"><spring:message code="purinvdet.jsp.expdt" text="Qty" /></th>
                                           		</thead>
                                           		<tbody style="color: #000000; padding: 1px;" id="modmostpurchaseitems">
                                           		</tbody>
                                           		</table>
										</div>
    									</div>
							<div id="transactionsummarydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px;">
									<table align="center">
										<tr>
											<td><spring:message code="order.jsp.TOTALTRANSACTION"
													text="TOTAL AMOUNT" /></td>
											<td width="5%">:</td>
											<td id="modtotaltransaction"></td>
										</tr>
										<tr>
											<td><spring:message code="order.jsp.LASTVISITDATE"
													text="LAST VISIT DATE" /></td>
											<td width="5%">:</td>
											<td id="modlastvisitdate"></td>
										</tr>
										 <tr >
                                               <td><spring:message code="order.jsp.TOTALPAIDAMT" text="TOTAL PAID AMOUNT"/></td>
                                               <td width="5%">:</td>
                                               <td id="modtotalpaidamt"></td>
                                              </tr>

									</table>
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Most Purchased Items By Customer --</div>
									<br> <br>
									<table align="center"
										style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
										<thead>
											<tr style="border-bottom: 1px dashed;">
												<th width="5%;" style="padding-left: 5%; font-size: 20px;"><spring:message
														code="reprintcash.jsp.invno" text="SNo" /></th>
												<th width="20%;" style="padding-left: 25%; font-size: 20px;"><spring:message
														code="item.jsp.name" text="Item Name" /></th>
												<th width="6%;" style="padding-left: 7%; font-size: 20px;"><spring:message
														code="purinvdet.jsp.expdt" text="Qty" /></th>
										</thead>
										<tbody style="color: #000000; padding: 1px;"
											id="modmostpurchaseitems">
										</tbody>
									</table>
								</div>
							</div>

							<div id="transactionhistorydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px;">
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Transaction History Of Customer --</div>
									<br> <br>
									<table align="center"
										style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
										<thead>
											<tr style="border-bottom: 1px dashed;">
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="reprintcash.jsp.invno" text="Order No" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.orderdate" text="Order Date" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="item.jsp.name" text="Amount" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.paidamt" text="Paid Amt" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.amttopay" text="Amt to Pay" /></th>
										</thead>
										<tbody style="color: #000000; padding: 1px;"
											id="modcusttransactionsummary">
										</tbody>
									</table>
								</div>
							</div>
							<!-- 			</div> -->


							<div id="paymentsummarydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px; display: none;"
									id="previouspaymenthistorydiv">
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Payment Summary Of Customer --</div>
									<br> <br>
									<table align="center">
										<tr>
											<td><spring:message code="order.jsp.TOTALPAIDAMT"
													text="TOTAL PAID AMOUNT" /></td>
											<td width="5%">:</td>
											<td id="modtotalpaidamt"></td>
										</tr>

										<tr>
											<td><spring:message code="order.jsp.LASTORDERDATE"
													text="LAST ORDER DATE" /></td>
											<td width="5%">:</td>
											<td id="modlastorderdate"></td>
										</tr>
										<tr>
											<td><spring:message code="order.jsp.TOTALTRANSACTION"
													text="LAST ORDER PAID AMOUNT" /></td>
											<td width="5%">:</td>
											<td id="modlastorderpaidamt"></td>
										</tr>
									</table>
								</div>
								<div style="text-align: left; font-size: 18px; display: none;"
									id="nopreviouspaymenthistorydiv">
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Payment Summary Not Available --</div>
									<br> <br>
								</div>
							</div>


							<div class="modal-footer"
								style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
								<button type="button" onclick="javascript:cancelCustomer()"
									style="background: #F60; font-weight: bold; width: 25%"
									class="btn btn-warning" data-dismiss="modal">
									<spring:message code="order.jsp.CANCEL" text="CANCEL" />
								</button>
								<button type="button" onclick="javascript:createOrder()"
									style="background: #72BB4F; font-weight: bold; width: 25%"
									data-dismiss="modal" class="btn btn-success">
									<spring:message code="order.jsp.DONE" text="DONE" />
								</button>
							</div>
						</div>
					</div>
				</div> --%>




		<div class="modal fade" data-backdrop="static"
			id="parcelCustDetailsModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto; width: 50%;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							<spring:message code="order.jsp.CustomerDetails"
								text="Customer Details" />
							<span style="float: right;"> Order Type : <span
								id="modOrderType">N/A</span>
							</span>
						</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff; width: 100%; padding: 5px;">
						<ul class="nav st-nav-tabs nav-tabs nav-justified"
							id="customerdetails" style="background: #404040; color: #fff;">
							<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#transactionsummarydiv"
								onclick="javascript:gotransactionsummary()">Transaction
									Summary</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#transactionhistorydiv"
								onclick="javascript:gotransactionhistory()"">Transaction
									History</a></li>
							<li class="disabled"><a data-toggle="tab"
								href="#paymentsummarydiv"
								onclick="javascript:gopaymentsummary()">Payment Summary</a></li>
						</ul>
						<div class="tab-content"
							style="background: #404040; border-top: 10px solid #404040;">
							<div id="home" class="tab-pane fade in active"
								style="background: #404040;">
								<!-- <div class="modal-category" style="background: #404040;color: #fff;"> -->
								<div style="text-align: left; font-size: 18px;">
									<table align="center"> <input type="hidden" id="modparcelcustIdhidden" value="">
										<c:if test="${!empty orders}">
										<%-- 	<tr>
												<td><spring:message code="order.jsp.PHONENO"
														text="PHONE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustPhone"
													value="${orders.customerContact}" autocomplete="off"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													autofocus="autofocus" readonly /></td>
											</tr> --%>
											
											
												<tr>
												<td><spring:message code="order.jsp.PHONENO"
														text="PHONE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustPhone"
												    value="${orders.customerContact}"
													maxlength="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													autofocus="autofocus"
													onkeypress='return isNumberKey(event)' /></td>
												<%-- <td><button type="button" id="searchCustId"
														onclick="javascript:searchCustomer()"
														class="btn btn-success"
														style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
														<spring:message code="order.jsp.SEARCH" text="SEARCH" />
													</button></td> --%>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.CUSTOMERNAME"
														text="CUSTOMER NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustName"
													value="${orders.customerName}"
													onkeypress='return lettersOnly(event)'
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													/></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.location"
														text="LOCATION" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustlocation"
													value="${orders.location}"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													 /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.ADDRESS"
														text="ADDRESS" /></td>
												<td>:</td>
												<td><textarea id="modparcelcustAddress" rows="2"
														style="margin-bottom: 2px; color: #222222; width: 95%;">${orders.deliveryAddress}</textarea>
												</td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.DELIVERYPERSONNAME"
														text="DELIVERY PERSON NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparceldeliveryPersonName"
													value="${orders.deliveryPersonName}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.houseno"
														text="HOUSE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcusthouseno"
													value="${orders.houseNo}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.streetno"
														text="STREET NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcuststreet"
													value="${orders.street}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>

											<tr>
												<td>STATE</td>
												<td>:</td>
												<td><%-- <input type="text" id="modparcelcuststate"
													value="${orders.state}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /> --%>

													<select id="modparcelcuststate" name="stateslist"
													style="margin-bottom: 2px; color: #222222; width: 95%;">
														<option value="${orders.state}" selected>${orders.state}</option>
														<option value="Andhra Pradesh">Andhra Pradesh</option>
														<option value="Arunachal Pradesh">Arunachal Pradesh</option>
														<option value="Assam">Assam</option>
														<option value="Bihar">Bihar</option>
														<option value="Chandigarh">Chandigarh</option>
														<option value="Chhattisgarh">Chhattisgarh</option>
														<option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option>
														<option value="Daman and Diu">Daman and Diu</option>
														<option value="Delhi">Delhi</option>
														<option value="Goa">Goa</option>
														<option value="Gujarat">Gujarat</option>
														<option value="Haryana">Haryana</option>
														<option value="Himachal Pradesh">Himachal Pradesh</option>
														<option value="Jammu and Kashmir">Jammu and Kashmir</option>
														<option value="Jharkhand">Jharkhand</option>
														<option value="Karnataka">Karnataka</option>
														<option value="Kenmore">Kenmore</option>
														<option value="Kerala">Kerala</option>
														<option value="Lakshadweep">Lakshadweep</option>
														<option value="Madhya Pradesh">Madhya Pradesh</option>
														<option value="Maharashtra">Maharashtra</option>
														<option value="Manipur">Manipur</option>
														<option value="Meghalaya">Meghalaya</option>
														<option value="Mizoram">Mizoram</option>
														<option value="Nagaland">Nagaland</option>
														<option value="Odisha">Odisha</option>
														<option value="Pondicherry">Pondicherry</option>
														<option value="Punjab">Punjab</option>
														<option value="Rajasthan">Rajasthan</option>
														<option value="Sikkim">Sikkim</option>
														<option value="Tamil Nadu">Tamil Nadu</option>
														<option value="Telangana">Telangana</option>
														<option value="Tripura">Tripura</option>
														<option value="Uttar Pradesh">Uttar Pradesh</option>
														<option value="Uttarakhand">Uttarakhand</option>
														<option value="Vaishali">Vaishali</option>
														<option value="West Bengal">West Bengal</option>
												</select>
                                               </td>
											</tr>

											<tr>
												<td>GSTIN/CST:</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustvatorcst"
													value="${orders.custVatRegNo}"
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.custDOB"
														text="DATE OF BIRTH" />
												</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustdob" size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value=""></td>
												<%-- <fmt:formatDate pattern="yyyy-MM-dd" value="${orders.dob}"/> --%>
											</tr>

											<tr>
												<td><spring:message code="order.jsp.custAnniversary"
														text="ANNIVERSARY DATE" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustanniversary"
													size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value=""></td>
											</tr>
											<tr>
											
									      </tr>
										</c:if>
										<c:if test="${empty orders}">
											<tr>
												<td><spring:message code="order.jsp.PHONENO"
														text="PHONE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustPhone"
													maxlength="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													autofocus="autofocus"
													onkeypress='return isNumberKey(event)' /></td>
												<td><button type="button" id="searchCustId"
														onclick="javascript:searchCustomer()"
														class="btn btn-success"
														style="margin-bottom: 2px; background: #72BB4F; font-weight: bold;">
														<spring:message code="order.jsp.SEARCH" text="SEARCH" />
													</button></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.CUSTOMERNAME"
														text="CUSTOMER NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustName" value="" onkeypress='return lettersOnly(event)'
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.location"
														text="LOCATION" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustlocation"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.ADDRESS"
														text="ADDRESS" /></td>
												<td>:</td>
												<td><textarea id="modparcelcustAddress" rows="2"
														style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea>
												</td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.DELIVERYPERSONNAME"
														text="DELIVERY PERSON NAME" /></td>
												<td>:</td>
												<td><input type="text" id="modparceldeliveryPersonName"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.houseno"
														text="HOUSE NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcusthouseno"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.streetno"
														text="STREET NO" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcuststreet"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td>STATE</td>
												<td>:</td>
												<td><!-- <input type="text" id="modparcelcuststate" value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /> -->
													<select id="modparcelcuststate" name="stateslist"
													style="margin-bottom: 2px; color: #222222; width: 95%;">
														<option value="" selected>Select State</option>
														<option value="Andhra Pradesh">Andhra Pradesh</option>
														<option value="Arunachal Pradesh">Arunachal Pradesh</option>
														<option value="Assam">Assam</option>
														<option value="Bihar">Bihar</option>
														<option value="Chandigarh">Chandigarh</option>
														<option value="Chhattisgarh">Chhattisgarh</option>
														<option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option>
														<option value="Daman and Diu">Daman and Diu</option>
														<option value="Delhi">Delhi</option>
														<option value="Goa">Goa</option>
														<option value="Gujarat">Gujarat</option>
														<option value="Haryana">Haryana</option>
														<option value="Himachal Pradesh">Himachal Pradesh</option>
														<option value="Jammu and Kashmir">Jammu and Kashmir</option>
														<option value="Jharkhand">Jharkhand</option>
														<option value="Karnataka">Karnataka</option>
														<option value="Kenmore">Kenmore</option>
														<option value="Kerala">Kerala</option>
														<option value="Lakshadweep">Lakshadweep</option>
														<option value="Madhya Pradesh">Madhya Pradesh</option>
														<option value="Maharashtra">Maharashtra</option>
														<option value="Manipur">Manipur</option>
														<option value="Meghalaya">Meghalaya</option>
														<option value="Mizoram">Mizoram</option>
														<option value="Nagaland">Nagaland</option>
														<option value="Odisha">Odisha</option>
														<option value="Pondicherry">Pondicherry</option>
														<option value="Punjab">Punjab</option>
														<option value="Rajasthan">Rajasthan</option>
														<option value="Sikkim">Sikkim</option>
														<option value="Tamil Nadu">Tamil Nadu</option>
														<option value="Telangana">Telangana</option>
														<option value="Tripura">Tripura</option>
														<option value="Uttar Pradesh">Uttar Pradesh</option>
														<option value="Uttarakhand">Uttarakhand</option>
														<option value="Vaishali">Vaishali</option>
														<option value="West Bengal">West Bengal</option>
												</select>
                                                </td>
											</tr>

											<tr>
												<td>GSTIN/CST:</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustvatorcst"
													value=""
													style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.custDOB"
														text="DATE OF BIRTH" />
												</td>
												<td>:</td>
												<td><input type="text" id="modparcelcustdob" size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">
												</td>
											</tr>
											<tr>
												<td><spring:message code="order.jsp.custAnniversary"
														text="ANNIVERSARY DATE" /></td>
												<td>:</td>
												<td><input type="text" id="modparcelcustanniversary"
													size="10"
													style="margin-bottom: 2px; color: #222222; width: 95%;"
													value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">
												</td>
											</tr>
											
										</c:if>
									</table>

									<div
										style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
										id="parcelCustModalalertMsg"></div>
								</div>
							</div>
							<!-- </div> -->
							<div id="transactionsummarydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px;">
									<table align="center">
										<tr>
											<td><spring:message code="order.jsp.TOTALTRANSACTION"
													text="TOTAL AMOUNT SPENT" /></td>
											<td width="5%">:</td>
											<td id="modtotaltransaction"></td>
										</tr>
										<tr>
											<td><spring:message code="order.jsp.LASTVISITDATE"
													text="LAST VISIT DATE" /></td>
											<td width="5%">:</td>
											<td id="modlastvisitdate"></td>
										</tr>

									</table>
									<br> <br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Most Purchased Items By Customer --</div>
									<br> <br>
									<table align="center"
										style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
										<thead>
											<tr style="border-bottom: 1px dashed;">
												<th width="5%;" style="padding-left: 6%; font-size: 20px;"><spring:message
														code="reprintcash.jsp.invno" text="SNo" /></th>
												<th width="20%;" style="padding-left: 25%; font-size: 20px;"><spring:message
														code="item.jsp.name" text="Item Name" /></th>
												<th width="6%;" style="padding-left: 7%; font-size: 20px;"><spring:message
														code="purinvdet.jsp.expdt" text="Qty" /></th>
										</thead>
										<tbody style="color: #000000; padding: 1px;"
											id="modmostpurchaseitems">
										</tbody>
									</table>
								</div>
							</div>
							<div id="transactionhistorydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px;">
									<br> <br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Transaction History Of Customer --</div>
									<br> <br>
									<table align="center"
										style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed; max-height: 100px; overflow-y: auto;">
										<thead>
											<tr style="border-bottom: 1px dashed;">
												<%-- <th width="5%;"><spring:message code="reprintcash.jsp.invno" text="SNo" /></th> --%>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="reprintcash.jsp.invno" text="Order No" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.orderdate" text="Order Date" /></th>
												<th
													style="padding-left: 20px; padding-right: 20px; font-size: 20px;"><spring:message
														code="item.jsp.name" text="Amount" /></th>
												<!-- width="6%;" width="15%;" width="6%;" width="6%;"-->
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.paidamt" text="Paid Amt" /></th>
												<th
													style="font-size: 20px; padding-left: 20px; padding-right: 20px;"><spring:message
														code="purinvdet.jsp.amttopay" text="Amt to Pay" /></th>
										</thead>
										<tbody style="color: #000000; padding: 1px;"
											id="modcusttransactionsummary">
										</tbody>
									</table>


								</div>
							</div>
							<div id="paymentsummarydiv" class="tab-pane fade"
								style="background: #404040; border-top: 1px solid #404040; color: #fff;">
								<div style="text-align: left; font-size: 18px; display: none;"
									id="previouspaymenthistorydiv">
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Payment Summary Of Customer --</div>
									<br> <br>
									<table align="center">
										<tr>
											<td><spring:message code="order.jsp.TOTALPAIDAMT"
													text="TOTAL PAID AMOUNT" /></td>
											<td width="5%">:</td>
											<td id="modtotalpaidamt"></td>
										</tr>

										<tr>
											<td><spring:message code="order.jsp.LASTORDERDATE"
													text="LAST ORDER DATE" /></td>
											<td width="5%">:</td>
											<td id="modlastorderdate"></td>
										</tr>
										<tr>
											<td><spring:message code="order.jsp.LASTORDERPAIDAMT"
													text="LAST ORDER PAID AMOUNT" /></td>
											<td width="5%">:</td>
											<td id="modlastorderpaidamt"></td>
										</tr>
									</table>
								</div>
								<div style="text-align: left; font-size: 18px; display: none;"
									id="nopreviouspaymenthistorydiv">
									<br>
									<div
										style="width: 100%; text-align: center; font-size: 22px; color: #fff;">--
										Previous Payment Summary Not Available --</div>
									<br> <br>
								</div>
							</div>

							<!-- <div id="menu3" class="tab-pane fade" style="background: #404040;border-top: 1px solid #404040;color: #fff; important!">
            								<p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
    									</div> -->
						</div>
					</div>
				
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<%-- <button type="button" onclick="javascript:cancelCustomer()"
							style="background: #F60; font-weight: bold; width: 25%"
							class="btn btn-warning" data-dismiss="modal">
							<spring:message code="order.jsp.CANCEL" text="CANCEL" />
						</button> --%>
						<button type="button" onclick="javascript:showCustomer()"
							style="background: #72BB4F; font-weight: bold; width: 25%"
							data-dismiss="modal" class="btn btn-success">
							<spring:message code="m.jsp.DONE" text="DONE" />
						</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" data-backdrop="static"
			id="billPrintSuccessModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">
							<spring:message code="order.jsp.Success" text="Success" />
						</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="hidden" id="hiddmanualeditItemId" value="">
							<spring:message code="order.jsp.Billhasbeensuccessfullyprinted"
								text="Bill has been successfully printed" />
							!
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							onclick="javascript:showDirectPaymentforPacel()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">
							<spring:message code="order.jsp.OK" text="OK" />
						</button>
					</div>
				</div>
			</div>
		</div>






		<div class="modal fade" data-backdrop="static"
			id="billPrintSuccessModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Success</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="hidden" id="hiddmanualeditItemId" value="">
							Bill has been successfully printed!
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							onclick="javascript:showDirectPaymentforPacel()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" data-backdrop="static" id="helloPrintModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="width: 200px; height: auto;">


				<div class="modal-body" id="localPrint"
					style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
					<div
						style="text-align: left; height: auto; position: inherit; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


						<b><font
							style="font-size: 12px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
						<b><font
							style="font-size: 10px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

						<div
							style="text-align: left; font-size: 11px; font-family: sans-serif;">
							<b>Email :</b> ${sessionScope.loggedinStore.emailId}
						</div>
						<div
							style="text-align: left; font-size: 11px; font-family: sans-serif;">
							<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
						</div>
						<div
							style="text-align: left; font-size: 11px; font-family: sans-serif;">
							<b>Order No / Invoice :</b> <span id="ordervalue">00</span>
						</div>
						<div
							style="text-align: left; font-size: 11px; font-family: sans-serif;"
							id="showtableno">
							<b>Table No :</b> <span id="tableNoValue">00</span>
						</div>
						<div class="table-responsive" id="orderitemContId">

							<table
								style="color: #000000; border: none; height: 50px; width: 130px;">
								<c:if test="${! empty orders}">
									<thead>

										<th style="font-size: 10px; width: 30px;"><span
											style="float: left; font-family: sans-serif;">Items</span></th>
										<th
											style="text-align: center; font-size: 10px; font-family: sans-serif;">Qty</th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;">Rate</th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;">Total</th>


									</thead>

									<tbody style="color: #000000; padding: 1px;">
										<c:forEach items="${orders.orderitem }" var="orderitems"
											varStatus="stat">
											<c:set var="bgCol" value="#ffffff"></c:set>
																						
											<c:if
												test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
												<c:set var="bgCol" value="#1c91bc"></c:set>

											</c:if>
											<tr style="padding: 1px;">
												<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
												<td
													style="padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px; font-family: sans-serif;">
													<c:choose>
														<c:when test="${orderitems.ordertype==2}">

															<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
															        ${orderitems.item.name}(P)
                                							</c:when>
														<c:otherwise>
															<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                                										  ${orderitems.item.name}
                                							</c:otherwise>
													</c:choose>
												</td>
												<td valign="middle" align="center"
													style="padding: 1px; font-size: 10px; font-family: sans-serif;">
													${orderitems.quantityOfItem}</td>
												<td
													style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 10px"><fmt:formatNumber
														type="number" maxFractionDigits="2" minFractionDigits="2"
														value="${orderitems.rate}"></fmt:formatNumber></td>
												<td
													style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 10px"><c:if
														test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
														<fmt:formatNumber type="number" maxFractionDigits="2"
															minFractionDigits="2"
															value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
													</c:if> <c:if
														test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
														<fmt:formatNumber type="number" maxFractionDigits="2"
															minFractionDigits="2"
															value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
													</c:if></td>



											</tr>

										</c:forEach>

									</tbody>
								</c:if>
								<c:if test="${empty orders}">
									<thead>

										<th>NAME</th>
										<th style="text-align: center;">QUANTITY</th>
										<th>RATE</th>
										<th>TOTAL</th>

									</thead>
									<tbody style="color: #fff; padding: 1px;">
									</tbody>
								</c:if>
							</table>

						</div>

						<div style="text-align: right; width: 150px;">--------------------</div>

						<table style="height: 50px; width: 150px;">

							<tr>
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
									Amount :</td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
									id="totalamt">00</span></td>
							</tr>

							<tr id="totalServiceTax">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
									Service Tax :</td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
									id="servTax">00</span></td>
							</tr>

							<tr id="totalVatTax">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
									Vat :</td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
									id="vatTax">00</span></td>
							</tr>
							<tr>
								<td><b><span
										style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Gross
											Amount :</span></b></td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
										id="grossAmount">00</span></b></td>
							</tr>
							<tr id="showDiscount">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="discountTxt">00</span></td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
									id="discountValue">00</span></td>
							</tr>
							<tr>
								<td><b><span
										style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Amount
											To Pay :</span></b></td>
								<td
									style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
										id="amoutToPay">00</span></b></td>
							</tr>
							<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->
						</table>

						<table style="height: 50px; width: 150px;">
							<c:if test="${! empty orders.customerName}">
								<tr id="showcustomerNameDiv">
									<td
										style="font-size: 10px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerNameTxt">Cust Name : </span></td>
									<td style="font-size: 10px; font-family: sans-serif;"><span
										id="showcustomerNameValue">${orders.customerName}</span></td>
								</tr>
							</c:if>
							<c:if test="${! empty orders.customerContact}">
								<tr id="showcustomerContactDiv">
									<td
										style="font-size: 10px; font-weight: bold; font-family: sans-serif;"><span
										id="showcustomerContactTxt">Cust Ph : </span></td>
									<td style="font-size: 10px; font-family: sans-serif;"><span
										id="showcustomerContactValue">${orders.customerContact}</span></td>
								</tr>
							</c:if>
							<c:if test="${! empty orders.deliveryAddress}">
								<tr id="showdeliveryAddressDiv">
									<td
										style="font-size: 10px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryAddressTxt">Address : </span></td>
									<td style="font-size: 10px; font-family: sans-serif;"><span
										id="showdeliveryAddressValue">${orders.deliveryAddress}</span></td>
								</tr>
							</c:if>
							<c:if test="${! empty orders.deliveryPersonName}">
								<tr id="showdeliveryPersonNameDiv">
									<td
										style="font-size: 10px; font-weight: bold; font-family: sans-serif;"><span
										id="showdeliveryPersonNameTxt">Del Person Name : </span></td>
									<td style="font-size: 10px; font-family: sans-serif;"><span
										id="showdeliveryPersonNameValue">${orders.deliveryPersonName}</span></td>
								</tr>
							</c:if>
							<tr>
								<td style="visibility: hidden;">---------------------------</td>
								<td></td>
							</tr>

						</table>

						<div style="text-align: left; width: 150px;">
							<font style="font-size: 12px; font-family: sans-serif;">**Thank
								You. Visit Again**</font>
						</div>
					</div>
				</div>
				<div class="modal-footer" id="removePrint"
					style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
					<button type="button" onclick="javascript:localPrint()"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
					<button type="button" onclick="return false"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">CANCEL</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="helloPrintModal80px"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="width: 276px; height: auto;">


			<div class="modal-body" id="localPrint80px"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
				<!-- <div
					style="text-align: left; height: 550px; width: 100%; position: inherit; overflow-y: scroll; width: 100%; font-size: 20px; color: #000000" >
                   -->
    <div style="text-align: center; width: 230px; font-size: 20px; color: #000000">
					<b><font
						style="font-size: 12px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
					<b><font
						style="font-size: 10px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Email :</b> ${sessionScope.loggedinStore.emailId}
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Order No / Invoice :</b> <span id="ordervalue80px">00</span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showtableno80px">
						<b>Order Type :</b> <span id="tableNoValue80px">00</span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showOrderDate80px">
						<b>Order Date :</b> <span id="orderDateValue80px">
						<fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
									pattern="MMM dd, yyyy" />
						<fmt:formatDate pattern="yyyy-MM-dd"
										value="${parsedInvDate}" />
						</span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showgstno80px">
						<b>${sessionScope.loggedinStore.gstText}:</b> <span id="gstnValue80px">${sessionScope.loggedinStore.gstRegNo}</span>
					</div>
					<div class="table-responsive" id="orderitemContId">
						<table
							style="color: #000000; border: none; height: 50px; width: 100%;">
							<c:if test="${! empty orders}">
								<thead>
									<th style="font-size: 11px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">Items</span></th>
									<th
										style="text-align: center; font-size: 11px; font-family: sans-serif;">QTY</th>
									<th
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<c:choose>
                                         <c:when test="${sessionScope.loggedinStore.id==47}">
                                         RATE
                                         </c:when>
										 <c:otherwise>
										 RATE
										  </c:otherwise>
										</c:choose>
										
										</th>
									<th
										style="text-align: right; font-size: 11px; font-family: sans-serif;">TOTAL</th>
								</thead>
								<tbody style="color: #000000; padding: 1px;">
									<c:forEach items="${orders.orderitem }" var="orderitems"
										varStatus="stat">
										<c:set var="bgCol" value="#ffffff"></c:set>
										<c:if
											test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
											<c:set var="bgCol" value="#1c91bc"></c:set>

										</c:if>
										<tr style="padding: 2px;">
											<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
											<td
												style="padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px; font-family: sans-serif;">
												<c:choose>
													<c:when test="${orderitems.ordertype==2}">

														<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
														<%-- ${orderitems.item.name}(P) --%>
							  							           <c:choose>
	                                                                  <c:when test="${sessionScope.loggedinStore.id==164}">
	                                                                     ${orderitems.item.name}(P)(${orderitems.item.code})
                                                                      </c:when>
                                                                      <c:otherwise>
                                                                          ${orderitems.item.name}(P)<!--  -->
                                                                      </c:otherwise>
                                                                     </c:choose>
															        
                                					</c:when>
													<c:otherwise>
														<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
														 <%-- ${orderitems.item.name} --%>
														           <c:choose>
	                                                                  <c:when test="${sessionScope.loggedinStore.id==164}">
	                                                                   ${orderitems.item.name}(${orderitems.item.code})
                                                                      </c:when>
                                                                      <c:otherwise>
                                                                           ${orderitems.item.name}<!--  -->
                                                                      </c:otherwise>
                                                                     </c:choose>
                                										  
                                					</c:otherwise>
												</c:choose>
											</td>
											<td valign="middle" align="center"
												style="padding: 3px; font-size: 11px; font-family: sans-serif;">
												${orderitems.quantityOfItem}</td>
											<td
												style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 11px">
												<fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${orderitems.rate}"></fmt:formatNumber>
											  </td>
											<td
												style="padding: 1px; font-family: sans-serif; text-align: right; font-size: 11px"><c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
													<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2"
														value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
												</c:if> <c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
													<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2"
														value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
												</c:if></td>
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
							<c:if test="${empty orders}">
								<thead>

									<th>NAME</th>
									<th style="text-align: center;">QUANTITY</th>
									<th>RATE</th>
									<th>TOTAL</th>

								</thead>
								<tbody style="color: #fff; padding: 1px;">
								</tbody>
							</c:if>
						</table>
					</div>
					<div style="text-align: center;">--------------------------------</div>

					<table style="height: 50px; width: 100%;">
						
						<tr>
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
								Amount :</td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="totalamt80px">00</span></td>
						</tr>
						<tr id="showDiscount80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
								id="discountTxt80px">00</span></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="discountValue80px">00</span></td>
						</tr>

						<tr id="totalServiceTax80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
								<!-- Service Tax -->
								<%-- ${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%): --%>
								<c:choose>
		                              <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                  ${sessionScope.loggedinStore.serviceTaxText}:
		                               </c:when>
		      						   <c:otherwise>
		   								${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):
		  							  </c:otherwise>
								 </c:choose>
								
							</td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="servTax80px">00</span></td>
						</tr>

						<tr id="totalVatTax80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
								<!-- Vat -->
								<%-- ${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%) : --%>
								<c:choose>
		                               <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                  ${sessionScope.loggedinStore.vatTaxText}:
		                               </c:when> 
		                                <c:otherwise>
		   								${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):
		  							  </c:otherwise>
								 </c:choose>
							</td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="vatTax80px">00</span></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Gross
										Amount :</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="grossAmount80px">00</span></b></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Amount
										To Pay :</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="amoutToPay80px">00</span></b></td>
						</tr>
						<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->

					</table>
					<table style="height: 50px; width: 100%;">
						<c:if test="${! empty orders.customerName}">
							<tr id="showcustomerNameDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerNameTxt80px">Cust Name : </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showcustomerNameValue80px">${orders.customerName}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.customerContact}">
							<tr id="showcustomerContactDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerContactTxt80px">Cust Ph : </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showcustomerContactValue80px">${orders.customerContact}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryAddress}">
							<tr id="showdeliveryAddressDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryAddressTxt80px">Address : </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryAddressValue80px">${orders.deliveryAddress}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.location}">
							<tr id="showdeliveryAddressDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryLocationTxt80px">Location: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryLocationValue80px">${orders.location}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.street}">
							<tr id="showdeliveryStreetDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryStreetTxt80px">Street: </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryStreetValue80px">${orders.street}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.houseNo}">
							<tr id="showdeliveryHouseNoDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryHouseNoTxt80px">House No: </span></td>
								<td style="font-size: 11px; font-weight: bold;font-family: sans-serif;"><span
									id="showdeliveryHouseNoalue80px">${orders.houseNo}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryPersonName}">
							<tr id="showdeliveryPersonNameDiv80px">
								<td
									style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryPersonNameTxt80px">Del Person Name : </span></td>
								<td style="font-size: 11px;font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryPersonNameValue80px">${orders.deliveryPersonName}</span></td>
							</tr>
						</c:if>
						<tr>
							<td style="visibility: hidden;">---------------------------</td>
							<td></td>
						</tr>

					</table>
					<div style="text-align: center;">
						<font style="font-size: 12px; font-family: sans-serif;">*****Thank
							You. Visit Again*****</font>
					</div>
				</div>
				<div class="modal-footer" id="removePrint80px"
					style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
					<button type="button" onclick="javascript:localPrint80px()"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
					<button type="button" onclick="return false"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">CANCEL</button>
				</div>
			</div>
		</div>
	</div>


	<!-- PRINT IN PRINT BUTTON 2100 -->

	<div class="modal fade" data-backdrop="static"
		id="helloPrintModal_2100px" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="width: 276px; height: 450px;">


			<div class="modal-body" id="localPrint_2100px"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
				<div
					style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


					<b><font
						style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
					<b><font
						style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

					<div style="font-size: 15px; font-family: sans-serif;">
						<b>Email :</b> ${sessionScope.loggedinStore.emailId}
					</div>
					<div style="font-size: 15px; font-family: sans-serif;">
						<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
					</div>
					<div
						style="text-align: left; font-size: 15px; font-family: sans-serif;">
						<b>Order No / Invoice :</b> <span id="ordervalue_2100px">00</span>
					</div>
					<div
						style="text-align: left; font-size: 15px; font-family: sans-serif;"
						id="showtableno_2100px">
						<b>Order Type :</b> <span id="tableNoValue_2100px">00</span>
					</div>

					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<div class="table-responsive" id="orderitemContId">
						<table
							style="color: #000000; border: none; height: 50px; width: 100%;">
							<c:if test="${! empty orders}">
								<thead>
									<th style="font-size: 15px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">Items</span></th>
									<th
										style="width: 110px; float: right; padding-right: 120px; text-align: center; font-size: 15px; font-family: sans-serif;">QTY</th>
									<th
										style="width: 110px; padding-right: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">RATE</th>
									<th
										style="width: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">TOTAL</th>

								</thead>

								<tbody style="color: #000000; padding: 1px;">
									<!-- <tr>
					<td style="width: 100% !important">1--------------------------------------------------------------------------------------------------------------</td>
					<td></td>
					</tr> -->
									<c:forEach items="${orders.orderitem }" var="orderitems"
										varStatus="stat">
										<c:set var="bgCol" value="#ffffff"></c:set>
										<c:if
											test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
											<c:set var="bgCol" value="#1c91bc"></c:set>

										</c:if>
										<tr style="padding: 2px;">
											<%-- <td style="padding: 1px; text-align: center;">
																${stat.index+1}</td> --%>
											<td
												style="padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px; font-family: sans-serif;">
												<c:choose>
													<c:when test="${orderitems.ordertype==2}">

														<%--   ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
															        ${orderitems.item.name}(P)
                                							</c:when>
													<c:otherwise>
														<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                                										  ${orderitems.item.name}
                                							</c:otherwise>
												</c:choose>
											</td>
											<td valign="middle"
												style="float: right; font-size: 14px; font-family: sans-serif; padding-right: 170px; text-align: center">
												${orderitems.quantityOfItem}</td>
											<td
												style="font-size: 14px; font-family: sans-serif; padding-right: 110px; text-align: center"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${orderitems.rate}"></fmt:formatNumber></td>
											<td
												style="padding: 1px; font-family: sans-serif; text-align: center; font-size: 14px"><c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
													<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2"
														value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
												</c:if> <c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
													<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2"
														value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
												</c:if></td>
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
							<c:if test="${empty orders}">
								<thead>

									<th>NAME</th>
									<th style="text-align: center;">QUANTITY</th>
									<th>RATE</th>
									<th>TOTAL</th>

								</thead>
								<tbody style="color: #fff; padding: 1px;">
								</tbody>
							</c:if>
						</table>
					</div>
					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<table style="height: 50px; width: 100%;">
						<tr id="showDiscount_2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
								id="discountTxt_2100px">00</span></td>
							<td
								style="text-align: right; font-size: 14px; font-family: sans-serif;"><span
								id="discountValue_2100px">00</span></td>
						</tr>
						<tr>
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
								Amount :</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="totalamt_2100px">00</span></td>
						</tr>

						<tr id="totalServiceTax_2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
								Service Tax :</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="servTax_2100px">00</span></td>
						</tr>

						<tr id="totalVatTax_2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
								Vat :</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="vatTax_2100px">00</span></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
										Amount :</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="grossAmount_2100px">00</span></b></td>
						</tr>
						 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_2100px">00</span></b></td>
					  </tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 14px; font-family: sans-serif;">Amount
										To Pay :</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="amoutToPay_2100px">00</span></b></td>
						</tr>
						<!-- <tr>
									<td style="visibility: hidden;">---------------------------</td>
									<td></td>
								</tr> -->

					</table>
					<c:if test="${! empty orders.customerName}">
						<div style="">-------------------------------------------------------------------------------------------------------</div>
					</c:if>
					<table style="height: 50px; width: 100%;">
						<c:if test="${! empty orders.customerName}">
							<tr id="showcustomerNameDiv_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerNameTxt_2100px">Cust Name : </span></td>
								<td style="font-size: 14px; font-family: sans-serif;"><span
									id="showcustomerNameValue_2100px">${orders.customerName}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.customerContact}">
							<tr id="showcustomerContactDiv_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
									id="showcustomerContactTxt_2100px">Cust Ph : </span></td>
								<td style="font-size: 14px; font-family: sans-serif;"><span
									id="showcustomerContactValue_2100px">${orders.customerContact}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryAddress}">
							<tr id="showdeliveryAddressDiv_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryAddressTxt_2100px">Address : </span></td>
								<td style="font-size: 14px; font-family: sans-serif;"><span
									id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryAddress}">
							<tr id="showdeliveryStateDiv_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryStateDiv_2100px">State : </span></td>
								<td style="font-size: 14px; font-family: sans-serif;"><span
									id="showdeliveryStateDiv_2100px">${orders.state}</span></td>
							</tr>
						</c:if>
						<c:if test="${! empty orders.deliveryPersonName}">
							<tr id="showdeliveryPersonNameDiv_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;"><span
									id="showdeliveryPersonNameTxt_2100px">Del Person Name :
								</span></td>
								<td style="font-size: 14px; font-family: sans-serif;"><span
									id="showdeliveryPersonNameValue_2100px">${orders.deliveryPersonName}</span></td>
							</tr>
						</c:if>


					</table>
					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<div style="text-align: center;">
						<font style="font-size: 16px; font-family: sans-serif;">*****Thank
							You. Visit us Again*****</font>
					</div>
				</div>
				<div class="modal-footer" id="removePrint_2100px"
					style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
					<button type="button" onclick="javascript:localPrint_2100px()"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
					<button type="button" onclick="return false"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">CANCEL</button>
				</div>
			</div>
		</div>
	</div>


	<!-- ************    END    ************    -->


	<!-- PRINT IN PRINT BUTTON 2100 ( for GST) -->

	<div class="modal fade" data-backdrop="static"
		id="helloPrintModal_2100px_GST" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="width: 276px; height: 450px;">


			<div class="modal-body" id="localPrint_2100px_GST"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
				<div
					style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


					<b><font
						style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
					<b><font
						style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}</font></b>

					<div style="font-size: 15px; font-family: sans-serif;">
						<b>Email :</b> ${sessionScope.loggedinStore.emailId}
					</div>
					<div style="font-size: 15px; font-family: sans-serif;">
						<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
					</div>
					<div style="font-size: 15px; font-family: sans-serif;">
						<b>Tax Invoice </b>
					</div>
					<div>
						<div style="float: left;">
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>${sessionScope.loggedinStore.gstText} :</b> <span
									id="ordervalue_2100px">${sessionScope.loggedinStore.gstRegNo}</span>
							</div>
							<%-- <c:if test="${sessionScope.loggedinStore.id == 120}">
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>FSSAI:</b>${sessionScope.loggedinStore.dataSource} 
							</div>
							</c:if> --%>
							<br> <br>
							<div style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<c:choose>
								    <c:when test="${sessionScope.loggedinStore.id==168}">
								      <b>Details of Patient</b>
								     </c:when>    
								    <c:otherwise>
								       <b>Details of Receiver</b>
								    </c:otherwise>
								</c:choose>
								
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Name :</b><span id="showcustomerNameValue_2100px">${orders.customerName}</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Address :</b><span id="showdeliveryAddressValue_2100px">${orders.deliveryAddress}</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>State :</b><span id="showdeliveryStateValue_2100px">${orders.state}</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Contact No:</b><span id="showcustomerContactNoValue_2100px">${orders.customerContact}</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>GSTIN/Unique Id :</b><span>${orders.custVatRegNo}</span>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No / Invoice :</b> <span id="ordervalue_2100px_gst">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
									pattern="MMM dd, yyyy" />
								<b>Date :</b> <span><fmt:formatDate pattern="yyyy-MM-dd"
										value="${parsedInvDate}" /></span>
								<%-- <c:if test="${sessionScope.loggedinStore.id==47}">
							      <b>Doctor :</b>
							    </c:if>  --%>
							</div>
							<c:if test="${sessionScope.loggedinStore.id==168}">
								<div style="text-align: left; font-size: 15px; font-family: sans-serif;">
									 <b>Doctor :</b>${orders.deliveryPersonName}
								 </div>
							 </c:if>
						</div>
					</div>
					<!-- <div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b>Order No / Invoice :</b> <span id="ordervalue_2100px">00</span>
							</div>
							<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;" id="showtableno_2100px">
								<b>Table No :</b> <span id="tableNoValue_2100px">00</span>
							</div> -->

					<!-- <div style="">-------------------------------------------------------------------------------------------------------</div> -->

					<div style="float: left; margin-bottom: 5%;" id="orderitemContId">
						<table
							style="text-align: center; border-collapse: collapse; "
							id="orderItemTbl">
							<thead>
								<tr style="border-bottom: 1px dashed;">
									<th width="5%;"><spring:message
											code="reprintcash.jsp.invno" text="SNo" /></th>
								   <c:if test="${sessionScope.loggedinStore.id!=168}">		
									<th width="30%;"><spring:message code="item.jsp.name"
											text="Item Name" /></th>
								    </c:if>
								    <c:if test="${sessionScope.loggedinStore.id==168}">		
									<th width="40%;">Description</th>
								    </c:if>
								   <c:if test="${sessionScope.loggedinStore.id!=168}">
									<th><spring:message code="purinvdet.jsp.mfg" text="HSN" />/</th>&nbsp;
									<th><spring:message code="purinvdet.jsp.batch" text="SAC" /></th>
								   </c:if>
								   <th width="6%;"><spring:message code="purinvdet.jsp.expdt"
											text="Qty" /></th>
									<c:if test="${sessionScope.loggedinStore.id!=168}">		
									<th width="6%;"><spring:message code="purinvdet.jsp.expdt"
											text="Unit" /></th>
									</c:if>	
									<c:if test="${sessionScope.loggedinStore.id!=168}">	
									<th width="5%;"><spring:message code="purinvdet.jsp.pqty"
											text="Rate" /></th>
									</c:if>		
									<c:if test="${sessionScope.loggedinStore.id==168}">
									<th width="30%;"><spring:message code="purinvdet.jsp.pqty"
											text="Rate" /></th>
									</c:if>	
									<c:if test="${sessionScope.loggedinStore.id!=168}">			
									<th width="5%;"><spring:message code="purinvdet.jsp.lqty"
											text="Total" /></th>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id == 168}">			
									<th width="30%;"><spring:message code="purinvdet.jsp.lqty"
											text="Total" /></th>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id!=168}">			
									<th width="5%;"><spring:message
											code="reprintcash.jsp.totqty" text="Disc" />(${orders.orderBill.discountPercentage}%)</th>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id==168}">			
									<th width="20%;"><spring:message
											code="reprintcash.jsp.totqty" text="Disc" />(${orders.orderBill.discountPercentage}%)</th>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id!=168}">				
										<th width="10%;"><spring:message code="pos.jsp.mrpLs"
											text="Taxable Value" /></th>
									</c:if>	
									<c:if test="${sessionScope.loggedinStore.id!=168}">		
									<th width="18%;" colspan="2">&nbsp;<spring:message
											code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
									</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message
											code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
									</th>
									<th width="18%;" colspan="2">&nbsp;<spring:message
											code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
									</th>
									</c:if>
								</tr>
								<c:if test="${sessionScope.loggedinStore.id!=168}">
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<th width="5%;"><spring:message
											code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs"
											text="Amt." /></th>
									<th width="5%;"><spring:message
											code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs"
											text="Amt." /></th>
									<th width="5%;"><spring:message
											code="reprintcash.jsp.totqty" text="Rate" /></th>
									<th width="10%;"><spring:message code="pos.jsp.mrpLs"
											text="Amt." /></th>
								</tr>
								</c:if>
							</thead>
							<%
											Order orders = (Order)request.getAttribute("orders");
											if(orders!=null){
											List<OrderItem> orderItemList = orders.getOrderitem();
											//request.setAttribute("orderItemList",orderItemList);
											List<OrderItem> itemlist = new ArrayList<OrderItem>();
											List<OrderItem> packingitemlist = new ArrayList<OrderItem>();
											for (OrderItem orderitems : orderItemList) {
												//if(StringUtils.containsIgnoreCase(orderitems.getItem().getName(), "bowl"))
													if(StringUtils.equalsIgnoreCase(orderitems.getItem().getPackaged(), "Y"))
													{
													packingitemlist.add(orderitems);
													
													}
												else{
													itemlist.add(orderitems);
												}
							
												}
											orders.setOrderitem(itemlist);
											orders.setPackingitem(packingitemlist);
											}
											request.setAttribute("orders",orders);
										%>
							<tbody>
								<c:if test="${!empty orders.orderitem }">
									<c:forEach items="${orders.orderitem }" var="orderitems"
										varStatus="stat">
										<tr>
											<td width="5%;">${stat.index+1}</td>
											<td width="30%;"><c:choose>
													<c:when test="${orderitems.ordertype==2}">
														<%-- ${fn:substring(orderitems.item.name,0,18)}(P)... --%>
												        ${orderitems.item.name}(P)
                             					</c:when>
													<c:otherwise>
														<%-- ${fn:substring(orderitems.item.name,0,18)}... --%>
                             										  ${orderitems.item.name}
                             					</c:otherwise>
												</c:choose></td>
											<c:if test="${sessionScope.loggedinStore.id!=168}">	
												<td></td>
												
												<td>
												<c:if test="${fn:containsIgnoreCase(varordertypename, 'Catering') }">
												${orderitems.item.code}
												</c:if>
												</td>
											</c:if>
											<td width="6%;">${orderitems.quantityOfItem}</td>
											<c:if test="${sessionScope.loggedinStore.id!=168}">	
												<td width="6%;">${orderitems.item.unit}</td>
											</c:if>
											<td width="5%;"><fmt:formatNumber type="number"
													maxFractionDigits="2" minFractionDigits="2"
													value="${orderitems.rate}"></fmt:formatNumber></td>
											<td width="5%;" id="tbl_orderItemTot"><c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
													<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
														minFractionDigits="2"
														value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
												</c:if> <c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
													<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
														minFractionDigits="2"
														value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
												</c:if></td>
												
											<td width="5%;" id="tbl_orderItemDisc">
											    <c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'Y') }">
												       <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" groupingUsed = "false"
															value="${(((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
													 </c:if> 
													 <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" groupingUsed = "false"
															value="${((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
													</c:if>
											    <%--  ${orders.orderBill.discountPercentage} --%>
											    </c:if>
											    <c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'N') }">
											     0.00
											   </c:if>
											</td>
											<c:if test="${sessionScope.loggedinStore.id!=168}">	
											<td width="10%;" id="tbl_orderItemTaxAmt"><c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
													
												 <fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
														
												 </c:if> <c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
													
												<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
														
												</c:if>
											</td>
											</c:if>
											 <c:if test="${sessionScope.loggedinStore.id!=168}">	 
											 <c:choose>
			                                        <c:when test="${sessionScope.loggedinStore.id!=120}">
			                                        
											<td width="5%;">${orderitems.vat}</td>
											
												<td width="10%;" id="tbl_orderItemVatTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if></td>
											
											<td width="5%;">${orderitems.serviceTax}</td>
											
											<td width="10%;" id="tbl_orderItemServiceTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if></td>
												
											<%-- <td width="5%;">${orderitems.vat + orderitems.serviceTax}</td> --%>
											<td width="5%;"></td>
											<td width="10%;">
												
											</td>
										  </c:when>
			                               <c:otherwise>
                                	               <c:if test="${fn:containsIgnoreCase(orders.state, 'WB') || fn:containsIgnoreCase(orders.state, 'West Bengal') || fn:containsIgnoreCase(orders.state, 'WestBengal')}">
                                                              
														 <td width="5%;">${orderitems.vat}</td>
														
														<td width="10%;" id="tbl_orderItemVatTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100}"></fmt:formatNumber>
														</c:if></td>

														<td width="5%;">${orderitems.serviceTax}</td>
														
														<td width="10%;" id="tbl_orderItemServiceTaxAmt"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100}"></fmt:formatNumber>
														</c:if></td>

														<td width="5%;"><%-- ${orderitems.vat + orderitems.serviceTax} --%></td>
														<td width="5%;"></td>
														<td width="10%;">
															
														</td>

 


													</c:if>
			                                       <c:if test="${!(fn:containsIgnoreCase(orders.state, 'WB')||(fn:containsIgnoreCase(orders.state, 'West Bengal')) || (fn:containsIgnoreCase(orders.state, 'WestBengal')) )  }">
			                                       
			                                              <td width="5%;">0.00</td>
														<td width="10%;">0.00</td>

														<td width="5%;">0.00</td>
														<td width="10%;">0.00</td>

														<td width="5%;"> ${orderitems.vat + orderitems.serviceTax} </td>
														<!-- <td width="5%;"></td> -->
														<td width="10%;">
														<%-- <c:if
												test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${(((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.vat)/100) + (((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											</c:if> <c:if
												test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${((((orderitems.quantityOfItem*orderitems.rate) - orderitems.discount) * orderitems.vat)/100) + ((((orderitems.quantityOfItem*orderitems.rate) - orderitems.discount) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											   </c:if>  --%>
											   <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${(((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100) + (((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											   </c:if> 
											   <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
												<fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2"
													value="${((((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.vat)/100) + ((((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * orderitems.serviceTax)/100)}"></fmt:formatNumber>
											   </c:if> 
														</td>
			                                             
			                                        </c:if>
                                            </c:otherwise>
			                                </c:choose>
										 </c:if>
										
										
										
										
										</tr>

									</c:forEach>
								</c:if>
								
							</tbody>
							<tfoot style="display: table-row-group">
							   <tr  style="border-top: 1px dashed;">
									<td></td>
									<td></td>
								    <c:if test="${sessionScope.loggedinStore.id!=168}">
									<td></td>
									<td></td>
									<td></td>
									</c:if> 
									<td></td> 
									<td><b>Total:</b></td>
									<td><span id="totalamt_2100px_gst">00</span></td>
									<td><span id="discountValue_2100px_gst">00</span></td>
									<c:if test="${sessionScope.loggedinStore.id!=168}">		
										<td><span id="taxableAmount_2100px_gst">00</span></td>
										<td></td>
										<td><span id="vatTax_2100px_gst">00</span></td>
										<td></td>
										<td><span id="servTax_2100px_gst">00</span></td>
										<td></td>
										<td><span id="igst_2100px_gst"></span></td>
									</c:if>
									<c:if test="${sessionScope.loggedinStore.id==168}">		
										<td style="display:none;"><span id="taxableAmount_2100px_gst">00</span></td>
										<td style="display:none;"></td>
										<td style="display:none;"><span id="vatTax_2100px_gst">00</span></td>
										<td style="display:none;"></td>
										<td style="display:none;"><span id="servTax_2100px_gst">00</span></td>
										<td style="display:none;"></td>
										<td style="display:none;"><span id="igst_2100px_gst"></span></td>
									</c:if>
								</tr>
							</tfoot>
						</table>
					</div>

					


				</div>

				<div>
					<table style="height: 50px; width: 100%;">
						<tr>
							<td width="50%"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
										Invoice Value (In figure) :</span></b></td>
							<td width="50%"
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="totgrossAmount_2100px_gst">00</span></b></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
										Invoice Value (In Words):</span></b></td>
							<td width="100%"
								style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
								id="grossAmount_2100px_word_gst"></span></td>
						</tr>
						<c:if test="${sessionScope.loggedinStore.id!=168}">		
							<tr id="totalServiceTax_2100px">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
									of Tax subject to Reverse Charges :</td>
								<td style="font-size: 14px; font-family: sans-serif;">
								<span style="padding-left: 52%" id="totvatTax_2100px_gst">00</span> 
								<span style="padding-left: 16%" id="totservTax_2100px_gst">00</span>
								<span style="padding-left: 60%" id="totigst_2100px_gst"></span>
								</td>
									 
	
							</tr>
						</c:if>
						<c:if test="${sessionScope.loggedinStore.id==168}">
							<tr id="totalServiceTax_2100px" style="display:none;">
								<td
									style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
									of Tax subject to Reverse Charges :</td>
								<td style="font-size: 14px; font-family: sans-serif;">
								<span style="padding-left: 52%" id="totvatTax_2100px_gst">00</span> 
								<span style="padding-left: 16%" id="totservTax_2100px_gst">00</span>
								<span style="padding-left: 60%" id="totigst_2100px_gst"></span>
								</td>
									 
	
							</tr>
						</c:if>	
						<!-- new added 10.5.2018 start -->
						<tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount1_2100px">00</span></b></td>
						 </tr>														
						 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay1_2100px">00</span></b></td>
						 </tr>
	
						<!-- new added 10.5.2018 end -->
					</table>
					
				</div>
				<c:if test="${sessionScope.loggedinStore.id == 120}">
				<div style="font-size: 15px; font-family: sans-serif; color: black; margin-top: 40px;">
				Narration:${orders.remarks}
				</div>
				<div style="font-size: 15px; font-family: sans-serif; color: black; margin-top: 10px;">
				Bank Details:
				</div>
				<div style="font-size: 14px; font-family: sans-serif; color: black;">
				BANK NAME: THE FEDERAL BANK LIMITED
				</div>
				<div style="font-size: 14px; font-family: sans-serif; color: black;">
				BRANCH NAME: SHAKESPERE SARANI,KOLKATA-700017
				</div>
				<div style="font-size: 14px; font-family: sans-serif; color: black;">
				A/C No.: 14000200014938
				</div>
				<div style="font-size: 14px; font-family: sans-serif; color: black;">
				IFSC: FDRL0001400
				</div>
				</c:if>
				<div style="text-align: center; margin-top: 30px;">
					<font
						style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
						You. Visit us Again*****</font>
				</div>
				
								<c:set var="totPacking" value="0.00"></c:set>
								<c:set var="totPackDisc" value="0.00"></c:set>
								<c:set var="totPackTaxable" value="0.00"></c:set>
								<c:set var="totPackTax" value="0.00"></c:set>
								<c:if test="${! empty orders.packingitem}">
								<div style="color: #000000; height: 50px;margin-top:50px;">
								........................................................................................................................................................................................................................................................................................................................................
								</div>
								<div style="color: #000000; height: 20px;">Packaging Details(Refundable)</div>
								<div style="font-size: 15px; color: black; margin-top: 5px;height: 20px;">
									Packaging Narration:${orders.specialNote}
								</div>
								<table style="color: #000000; height: 50px; width: 100%;border-collapse: collapse;">
										<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="10%;"><spring:message
											code="reprintcash.jsp.invno" text="SNo" /></th>
											<th style="font-size: 15px;"><span
												style="float: left;font-family: sans-serif;">ITEM NAME</span></th>
												<th style="text-align: center; font-size: 15px;font-family: sans-serif;">UNIT</th>
											<th style="float:right;text-align: center; font-size: 15px;font-family: sans-serif;">QTY</th>
											<th style="text-align: center; font-size: 15px;font-family: sans-serif;">RATE</th>
											<th style="text-align: center; font-size: 15px;font-family: sans-serif;">TOTAL</th>
											<th style="text-align: center; font-size: 15px;font-family: sans-serif;">DISC</th>
											<th style="text-align: center; font-size: 15px;font-family: sans-serif;">TAXABLE</th>
											<th style="text-align: center; font-size: 15px;font-family: sans-serif;">TAX</th>
											
										</tr>
										</thead>
										
										<tbody style="color: #000000; padding: 1px;">
										
					
					
																
											<c:forEach items="${orders.packingitem }" var="orderitems"
												varStatus="stat">
												<c:set var="bgCol" value="#ffffff"></c:set>
												<c:if
													test="${fn:startsWith(orderitems.item.name, 'CONTAINER')}">
													<c:set var="bgCol" value="#1c91bc"></c:set>

												</c:if>
												<tr style="padding: 2px;">
													<td style="padding: 1px; text-align: center;">
																${stat.index+1}</td>
													<td
														style="padding: 1px;  font-size: 14px;font-family: sans-serif;">
														
															        ${orderitems.item.name}
                                							
													</td>
													<td>${orderitems.item.unit}</td>
													<td valign="middle" style="float:right;font-size: 14px;font-family: sans-serif;text-align:center">
														${orderitems.quantityOfItem}</td>
													<td
														style="font-size: 14px;font-family: sans-serif;text-align:center"><fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${orderitems.rate}"></fmt:formatNumber></td>
													<td
														style="padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
																<c:set var="totPacking">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPacking+(orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}" ></fmt:formatNumber>
																</c:set>
														</c:if> 
														<c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${orderitems.quantityOfItem*orderitems.rate}"></fmt:formatNumber>
																<c:set var="totPacking">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPacking+orderitems.quantityOfItem*orderitems.rate}" ></fmt:formatNumber>
																</c:set>
														</c:if></td>
														<td style="text-align: center;">
											    		<c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'Y') }">
												       <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" groupingUsed = "false"
															value="${(((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
													 	<c:set var="totPackDisc">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackDisc+((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)}" ></fmt:formatNumber>
																</c:set>
													 </c:if> 
													 <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
														<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" groupingUsed = "false"
															value="${((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100}"></fmt:formatNumber>
														<c:set var="totPackDisc">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackDisc+(((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)}" ></fmt:formatNumber>
																</c:set>
													</c:if>
											    </c:if>
											    <c:if test="${fn:containsIgnoreCase(orderitems.item.spotDiscount, 'N') }">
											     0.00
											     <c:set var="totPackDisc">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackDisc+0.0}" ></fmt:formatNumber>
																</c:set>
											   </c:if>
											</td>
											<td style="text-align: center;"><c:if
													test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
													
												 <fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
													 <c:set var="totPackTaxable">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackTaxable+(((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100))}" ></fmt:formatNumber>
																</c:set>	
												 </c:if>
												 <c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
													
												<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)}"></fmt:formatNumber>
														<c:set var="totPackTaxable">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackTaxable+((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100))}" ></fmt:formatNumber>
																</c:set>
												</c:if>
											</td>
											<td style="text-align: center;"><c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * (orderitems.vat+orderitems.serviceTax))/100}"></fmt:formatNumber>
														 <c:set var="totPackTax">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackTax+(((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)-((((orderitems.rate-orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem)*orders.orderBill.discountPercentage)/100)) * (orderitems.vat+orderitems.serviceTax))/100)}" ></fmt:formatNumber>
																</c:set>
														</c:if> <c:if
															test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">
															<fmt:formatNumber type="number" maxFractionDigits="2" groupingUsed = "false"
																minFractionDigits="2"
																value="${(((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * (orderitems.vat+orderitems.serviceTax))/100}"></fmt:formatNumber>
														<c:set var="totPackTax">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		minFractionDigits="2" maxFractionDigits="2"
																		value="${totPackTax+((((orderitems.quantityOfItem*orderitems.rate) - (((orderitems.quantityOfItem*orderitems.rate)*orders.orderBill.discountPercentage)/100)) * (orderitems.vat+orderitems.serviceTax))/100)}" ></fmt:formatNumber>
																</c:set>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
										<tfoot>
							   			<tr  style="border-top: 1px dashed;">
							   			<td></td>
							   			<td></td>
							   			<td></td>
							   			<td></td>
							   			<td style="text-align:center;font-weight: bold;">Total</td>
							   			<td style="text-align:center;font-weight: bold;">${totPacking}</td>
							   			<td style="text-align:center;font-weight: bold;">${totPackDisc}</td>
							   			<td style="text-align:center;font-weight: bold;">${totPackTaxable}</td>
							   			<td style="text-align:center;font-weight: bold;">${totPackTax}</td>
							   			</tr>
							   			</tfoot>
									
								</table>
								</c:if>
				<!-- <div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div> -->
			</div>
		</div>
	</div>


	<!-- ************    END    ************    -->

	<div class="modal fade" data-backdrop="static"
		id="specialnoteforOrderModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						Add Special Note for <span id="headerforitemnamespnote"></span>
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="overflow-y: auto;">
						<div class="panel panel-default" style="background: #404040;">
							<div class="panel-body" style="max-height: 300px;">
								<input type="hidden" id="itemidforsetsplnote" value="">
								<div class="table-responsive"
									id="specialnoteforOrderContainerId"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #F60; font-weight: bold; width: 25%"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						onclick="javascript:setspecialNoteforOrder();"
						style="background: #72BB4F; font-weight: bold; width: 25%"
						data-dismiss="modal" class="btn btn-success">ADD</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="creditsaleModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						ORDER NO: <span id="creditsalemodOrderCont" class="hide">00</span> 
						<span id="creditsalemodStoreBasedOrderCont">00</span><span
							class="hide" style="float: right;">TABLE NO: <span
							id="creditsalemodTabCont">00</span></span>

					</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div>
						<div align="center" style="font-size: 20px; margin-bottom: 5px;">CREDIT
							SALE</div>
						<div style="font-size: 14px; font-weight: bold;">
							Customer Name : <input type="text" value=""
								id="creditsalecustname" size="14"
								style="margin-bottom: 2px; color: #222222;" /> OR Contact No: <input
								type="text" value="" id="creditsalecustcontact" size="14"
								style="margin-bottom: 2px; color: #222222;" />
						</div>
						<input type="hidden" id="hidcredisalecustid" value="" />
						<div id="creditsalecustdetailcontId"
							style="font-size: 14px; font-weight: bold; margin-top: 5px;"></div>
						<div id="creditsalepaymentdetailcontId"
							style="font-size: 14px; font-weight: bold; margin-top: 5px;"></div>
						<div
							style="display: none; font-size: 14px; font-weight: bold; margin-top: 5px;"
							id="hidcreditsalelastfourdigitcontid">
							Card Last 4 Digit :&nbsp;<input type="text"
								id="creditsalecardlastfourDigit" value="0000"
								style="text-align: center; color: #222222;" size="4" />
						</div>
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="paycreditsalealertMsg"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button" onclick="javascript:showcreditcustaddModal();"
						id="creditsaleaddcustomerButton" 
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">New Customer</button>
					<button type="button" onclick="javascript:payCreditSale();"
						id="creditsalepayButton" disabled="disabled"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">PAY</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="paxModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Enter No Of Pax</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						No Of Pax: <input type="text" id="noofPax" size="4"
							style="text-align: center; color: #222222;" />
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="paxalertMsg"></div>
					</div>
					<div align="center" style="font-size: 20px;">
						<c:if
							test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
							<table class="ui-bar-a" id="n_keypad_px"
								style="display: none; -khtml-user-select: none;">
								<tr>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero7_px">7</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero8_px">8</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero9_px">9</a></td>
									<td><a data-role="button" data-theme="e"
										style="border: 2px solid #404040;"
										class="btn btn-danger btn-lg" id="del_px">x</a></td>
								</tr>
								<tr>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero4_px">4</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero5_px">5</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero6_px">6</a></td>
									<td><a data-role="button" data-theme="e"
										style="border: 2px solid #404040;"
										class="btn btn-warning btn-lg" id="clear_px">c</a></td>
								</tr>
								<tr>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero1_px">1</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero2_px">2</a></td>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numero3_px">3</a></td>
									<td><a data-role="button" data-theme="e"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="numerodot_px">&nbsp;.</a></td>
								</tr>
								<tr>
									<td><a data-role="button" data-theme="b"
										style="border: 2px solid #404040;"
										class="btn btn-primary btn-lg" id="zero_px">0</a></td>
									<td colspan="4"><a data-role="button"
										style="border: 2px solid #404040; width: 184px;"
										data-theme="done" class="btn btn-success btn-lg" id="done_px">DONE</a></td>
								</tr>
							</table>
						</c:if>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						onclick="javascript:addnoofPax(document.getElementById('noofPax').value)"
						style="background: #72BB4F; font-weight: bold;"
						class="btn btn-success">DONE</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="changeTableModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Change Table</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div>
							TABLE NO : <select id="changetableId"
								style="padding: 5px 0 5px 0; color: #222222;">
								<c:forEach items="${sessionScope.TableList}" var="tablelist">
									<option value="${tablelist.tableNo}~${tablelist.isBooked}">${tablelist.tableNo}</option>
								</c:forEach>
							</select>
						</div>
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="changetablealertMsg"></div>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button"
						onclick="javascript:updateTableNo(document.getElementById('changetableId').value)"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static" id="splitBillModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						SPLIT BILL <input type="hidden" id="splitbillId"
							value="${orders.orderBill.id}"> <span
							style="float: right;">ORDER NO: <span
							id="splitbillmodOrderCont">00</span></span> <span class="hide"
							style="float: right;">TABLE NO: <span
							id="splitbillmodTabCont">00</span>&nbsp;&nbsp;&nbsp;
						</span>

					</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">

						<div style="padding: 3px;">
							NO OF BILL :&nbsp; <input type="text" value="" id="noofsplitBill"
								style="text-align: center; color: #222222" size="4" />
							<button type="button" id="noofBillCreatedWithoutPax"
								onclick="javascript:showSplitBillContent(document.getElementById('noofsplitBill').value,${sessionScope.loggedinStore.id})"
								style="width: 15%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">SPLIT</button>
						</div>
						<c:if
							test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
							<div class="row" style="display: none;">
								<label class="radio-inline"> <input name="radioGroup"
									id="splitbillitemwise" checked="checked" value="1" type="radio">Item
									Wise
								</label> <label class="radio-inline"> <input name="radioGroup"
									id="splitbillcategorywise" value="2" type="radio">Category
									Wise
								</label>
							</div>
						</c:if>

						<c:if
							test="${sessionScope.loggedinStore.id!=37 || sessionScope.loggedinStore.id!=38}">
							<div class="row" style="display: none;">
								<label class="radio-inline"> <input name="radioGroup"
									id="splitbillitemwise" value="1" type="radio">Item Wise
								</label> <label class="radio-inline"> <input type="hidden"
									name="radioGroup" id="splitbillcategorywise" checked="checked"
									value="2" type="radio">Category Wise
								</label>
							</div>
						</c:if>

						<div id="splitBillContainerId"
							style="font-size: 14px; max-height: 350px; overflow-y: auto;"></div>
						<div
							style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
							id="paycashalertMsg"></div>
					</div>

					<!-- <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="splitbillalertMsg"></div> -->
					<div id="splitbillalertMsg"></div>
				</div>

				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<button type="button" id="submitSplitBillBut" onclick="javascript:submitSpliBill(document.getElementById('noofsplitBill').value,${sessionScope.loggedinStore.id})"
						style="width: 25%; background: #72BB4F; font-weight: bold;"
						class="btn btn-success">SUBMIT</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static"
		id="printBillReasonModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.alert" text="Alert" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						Reason : <input type="text" id="printbillreasonId"
							style="color: black;" value=""> <input type="hidden"
							id="printbillcount" value="0">
					</div>
					<div id="printbillresonreq" class="hide" style="color: red;"
						align="center">reason required.</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="width: 25%; background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">
						<spring:message code="order.jsp.CANCEL" text="CANCEL" />
					</button>
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						onclick="printBillCountt(document.getElementById('printbillcount').value);"
						class="btn btn-success">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static"
		id="splitBillItemListModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Order Items</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 14px;">
						<div class="table-responsive" id="splitBillItemListContId"></div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button" onclick="javascript:addItemToSplitBill()"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" data-backdrop="static"
		id="splitBillItemListModalcatwise" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Order Items</h4>

				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 14px;">
						<div class="table-responsive" id="splitBillItemListContIdcatwise"></div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button"
							style="width: 25%; background: #F60; font-weight: bold;"
							class="btn btn-warning" data-dismiss="modal">CANCEL</button>
						<button type="button"
							onclick="javascript:addItemToSplitBillcatwise()"
							style="width: 25%; background: #72BB4F; font-weight: bold;"
							class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
		<div class="modal fade" data-backdrop="static" id="alertdeliveryboydataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="deliveryboydataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:selectOderNo()"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
	
	<div class="modal fade" data-backdrop="static" id="AssignDelBoyModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<%-- <spring:message code="header.jsp.AssignDelBoyModule"
									text="Assign Delivery Boy" /> --%>
									<c:choose>
								    	<c:when test="${sessionScope.loggedinStore.id==168}">
								     		 Assign Doctor
								    	 </c:when>    
								    	<c:otherwise>
								       		Assign Delivery Boy
								    	</c:otherwise>
									</c:choose>
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<%-- <spring:message code="header.jsp.delboyName"
									text="Delivery Boy Name" /> --%>
									<c:choose>
									    <c:when test="${sessionScope.loggedinStore.id==168}">
									      Doctor Name
									     </c:when>    
									    <c:otherwise>
									       Delivery Boy Name
									    </c:otherwise>
									</c:choose>: 
									<select id="deliveryboyName"  onchange="javascript:selectDelBoy()" style="margin-bottom: 2px; color: #222222;"></select>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold; margin-top: 20px;"
									id="assigndelboyalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
							onclick="javascript:closeAssignDeliveryBoyModal()"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="header.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								onclick="javascript:assignDeliveryBoy()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">
								<spring:message code="header.jsp.ASSIGN" text="ASSIGN" />
							</button>
						</div>
					</div>
				</div>
			</div>

	<div class="modal fade" data-backdrop="static" id="changeAmtModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<div style="padding: 5px;">
							AMOUNT TO PAY :&nbsp;<span id="cashamttopaymodcontId">0.00</span>
						</div>
						<div style="padding: 3px;">
							TENDER AMOUNT :&nbsp;<span id="cashtenderAmtmodcontId">0.00</span>
						</div>
						<div style="padding: 5px;">
							CHANGE AMOUNT :&nbsp;<span id="cashchangeamtmodcontId">0.00</span>
						</div>

					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0'"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>



	<%-- <div class="modal fade" data-backdrop="static"
				id="printBillReasonModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								Reason : <input type="text" id="printbillreasonId"
									style="color: black;" value=""> <input type="hidden"
									id="printbillcount" value="0">
							</div>
							<div id="printbillresonreq" class="hide" style="color: red;"
								align="center">reason required.</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								onclick="printBillCountt(document.getElementById('printbillcount').value);"
								class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
 --%>




	<div class="modal fade" data-backdrop="static"
		id="noOrderRecordsFoundModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="order.jsp.alert" text="Alert" />
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						No records found.
						<%-- 								<spring:message code="order.jsp.KOTChecklisthasbeensuccessfullyprinted" text="KOT Checklist has been successfully printed" />! --%>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">
						<spring:message code="order.jsp.OK" text="OK" />
					</button>
				</div>
			</div>
		</div>
	</div>










	<div class="modal fade" data-backdrop="static"
		id="kotchecklistPrintSuccessModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">
						<input type="hidden" id="hiddmanualeditItemId" value="">
						KOT Checklist has been successfully printed!
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">OK</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" data-backdrop="static" id="manualqtyModal"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">Enter No Of Qty</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">

					<div align="center" style="font-size: 20px;">
						<input type="text" id="kepadmanQty" value="" size="4"
							style="text-align: center; color: #222222;"> <br />
						<table class="ui-bar-a" id="n_keypad_man"
							style="display: none; -khtml-user-select: none;">
							<tr>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero7_man">7</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero8_man">8</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero9_man">9</a></td>
								<td><a data-role="button" data-theme="e"
									style="border: 2px solid #404040;"
									class="btn btn-danger btn-lg del_man">x</a></td>
							</tr>
							<tr>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero4_man">4</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero5_man">5</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero6_man">6</a></td>
								<td><a data-role="button" data-theme="e"
									style="border: 2px solid #404040;"
									class="btn btn-warning btn-lg clear_man">c</a></td>
							</tr>
							<tr>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero1_man">1</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero2_man">2</a></td>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numero3_man">3</a></td>
								<td><a data-role="button" data-theme="e"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg numerodot_man">&nbsp;.</a></td>
							</tr>
							<tr>
								<td><a data-role="button" data-theme="b"
									style="border: 2px solid #404040;"
									class="btn btn-primary btn-lg zero_man">0</a></td>
								<td colspan="4"><a data-role="button"
									style="border: 2px solid #404040; width: 184px;"
									data-theme="done" class="btn btn-success btn-lg done_man">DONE</a></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="background: #F60; font-weight: bold;"
						class="btn btn-warning" data-dismiss="modal">CANCEL</button>
					<!-- <button type="button" onclick="javascript:addnoofPax(document.getElementById('noofPax').value)" style="background: #72BB4F;font-weight: bold;" class="btn btn-success">DONE</button> -->
				</div>
			</div>
		</div>
	</div>

	<!-- *******  PRINT IN 80  ********* -->

	<div class="modal fade" data-backdrop="static"
		id="cashhelloPrintModal80" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="width: 276px; height: auto;">

			<div class="modal-body" id="printDiv80"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

				<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>

				<div
					style="text-align: center; width: 230px; font-size: 20px; color: #000000">

					<b><font
						style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div
								id="storeName80"></div></font></b> <b><font
						style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div
								id="storeAddr80"></div></font></b> <font
						style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div
							id="storeEmail80">Email:${sessionScope.loggedinStore.emailId}</div></font> <font
						style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div
							id="storePhNo80">Ph:${sessionScope.loggedinStore.mobileNo}</div></font><br>

					<%-- <div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="storePhNo80"></div>
							</div> --%>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Order No:</b> <span id="cashOrdervalue80">00</span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showtableno80px">
						<b>Order Type:</b> <span id="cashtableNoValue80">00</span>
					</div>
					<div style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Order Date:</b> <span id="cashOrderDate80"></span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showcashgstno80px">
						<b>${sessionScope.loggedinStore.gstText}:</b> <span id="cashgstValue80">${sessionScope.loggedinStore.gstRegNo}</span>
					</div>

					<div class="table-responsive" id="orderitemContId_80">
						<table
							style="color: #000000; border: none; height: 50px; width: 100%;">

							<thead>
								<tr>
									<th style="font-size: 11px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">Item</span></th>
									<th
										style="text-align: center; font-size: 11px; font-family: sans-serif;">Qty</th>
									<th
										style="text-align: right; font-size: 11px; font-family: sans-serif;">Rate</th>
									<th
										style="text-align: right; font-size: 11px; font-family: sans-serif;">Amt</th>
								</tr>
							</thead>

							<tbody style="color: #000000; padding: 1px;"
								id="itemDetailsPrint80"></tbody>

						</table>
					</div>

					<div style="text-align: center;">--------------------------------</div>

					<table style="height: 50px; width: 100%;">

						<tr>
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">TOTAL
								AMOUNT:</td>
								<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashtotalamt80">00</span></td>
						</tr>
						
						<tr id="cashshowDiscount80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								TOTAL DISCOUNT (<span id="paidbilldiscpers"></span>%):</td>
								<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashdiscountValue80">00</span></td>
						</tr>
						
						
						
						<tr id="cashtotalServiceCharge80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								 Service Charge: </td>
								 <td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;">
								<span id="cashservChrg80">00</span>
							</td>
						</tr>

						<tr id="cashtotalServiceTax80px">
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								<!-- Total Service Tax -->
								<%-- ${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%): --%>
							    <c:choose>
		                              <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                 ${sessionScope.loggedinStore.serviceTaxText}:
		                               </c:when>
		      						   <c:otherwise>
		   								${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):
		  							  </c:otherwise>
								 </c:choose>
							</td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashservTax80">00</span></td>
						</tr>

						<tr id="cashtotalVatTax80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								<!-- Total Vat -->
								<%-- ${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%): --%>
								  <c:choose>
		                              <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                  ${sessionScope.loggedinStore.vatTaxText}:
		                               </c:when>
		      						   <c:otherwise>
		   								${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):
		  							  </c:otherwise>
								 </c:choose>
								
							</td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashvatTax80px">00</span></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Gross
										Amount:</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="cashgrossAmount80">00</span></b></td>
						</tr>

						

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">AMOUNT
										TO PAY:</span></b></td>
							 <td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="cashamoutToPay80">00</span></b></td>
						</tr>

						<tr>
							<td style="text-align: center;">---------------------------</td>
							<td></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Paid
										Amount:</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							 </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="paidAmount80">00</span></b></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Tender
										Amount:</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
						   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="tenderAmount80">00</span></b></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Refund
										Amount:</span></b></td>
							 <td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="refundAmount80">00</span></b></td>
						</tr>



						<tr>
							<td style="text-align: center;">---------------------------</td>
							<td></td>
						</tr>
                            
                          <tr id="cusnametr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Name:</td>
									<td id="cusname80" style="text-align: right;"></td>
								</tr> 
								 <tr id="cusphnotr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Ph No:</td>
									<td id="cusphno80" style="text-align: right;"></td>
								</tr> 
                                  <tr id="cusaddresstr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Address:</td>
									<td id="cusaddress80" style="text-align: right;"></td>
								</tr> 
                                   <tr id="cuslocationtr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Location:</td>
									<td id="cuslocation80" style="text-align: right;"></td>
								</tr> 
                                  <tr id="cusstreettr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Street:</td>
									<td id="cusstreet80" style="text-align: right;"></td>
								</tr>  
                                   <tr id="cushousenotr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >House No:</td>
									<td id="cushouseno80" style="text-align: right;"></td>
								</tr> 
                                    
                                   <tr id="deliveryboytr80" style="display:none;font-weight:bold;">
									<td style="text-align: left;" >Dlv By:</td>
									<td id="deliveryboy80" style="text-align: right;"></td>
								</tr>   
                            
                            
                            
                            
					</table>
					<div style="text-align: center;">
						<b><font style="font-size: 12px; font-family: sans-serif;"><span
								id="payType80"></span></font></b>
					</div>
					<div style="text-align: center;">
						<font style="font-size: 12px; font-family: sans-serif;">Thank
							You. Visit us Again.</font>
					</div>
				</div>
				<div class="modal-footer" id="cashRemovePrint80"
					style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
					<button type="button" onclick="javascript:printCashOrCardLocal80()"
						style="background: #72BB4F; font-weight: bold;"
						class="btn btn-success" id="printBtn_80">PRINT</button>
					<button type="button" onclick="return false"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">CANCEL</button>
				</div>
			</div>


		</div>
	</div>

	<!-- *******  PRINT IN 58  ********* -->

	<div class="modal fade" data-backdrop="static" id="helloPrintModal58"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="width: 200px; height: auto;">


			<div class="modal-body" id="printDiv58"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

				<div
					style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


					<%-- <div style="text-align: center; width: 230px;">
								<input type="image"	src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%>


					<b><font
						style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div
								id="storeName58"></div></font></b> <b><font
						style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div
								id="storeAddr58"></div></font></b> <font
						style="font-size: 12px; font-style: inherit; font-family: sans-serif;"><div
							id="storeName58"></div></font> <font
						style="font-size: 10px; font-style: normal; font-family: sans-serif;"><div
							id="storeAddr58"></div></font><br>

					<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b> <div id="storePhNo58"></div>
							</div> --%>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;">
						<b>Order No:</b> <span id="orderValue58">00</span>
					</div>
					<div
						style="text-align: left; font-size: 11px; font-family: sans-serif;"
						id="showtableno">
						<b>Order Type:</b> <span id="tableNoValue58">00</span>
					</div>

					<div class="table-responsive" id="orderitemContId_58">

						<table
							style="color: #000000; border: none; height: 50px; width: 130px;">

							<thead>

								<th style="font-size: 10px; width: 30px;"><span
									style="float: left; font-family: sans-serif;">Items</span></th>
								<th
									style="text-align: center; font-size: 10px; font-family: sans-serif;">Qty</th>
								<th
									style="text-align: right; font-size: 10px; font-family: sans-serif;">Rate</th>
								<th
									style="text-align: right; font-size: 10px; font-family: sans-serif;">Amt</th>

							</thead>

							<tbody style="color: #000000; padding: 1px";
								   id="itemDetailsPrint58"></tbody>

						</table>

					</div>

					<div style="text-align: right; width: 150px;">--------------------</div>

					<table style="height: 50px; width: 150px;">

						<tr>
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">TOTAL
								AMOUNT:</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id=totalAmt58>00</span></td>
						</tr>
						<tr id="totalServiceChrg_58">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								Service Charge:</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="servChrg58">00</span></td>
						</tr>

						<tr id="totalServiceTax_58">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
								Service Tax:</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="servTax58">00</span></td>
						</tr>

						<tr id="totalVatTax_58">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
								Vat:</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="vatTax58">00</span></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Gross
										Amount:</span></b></td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="grossAmount58">00</span></b></td>
						</tr>
						<tr id="showDiscount_58">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								TOTAL DISCOUNT :</td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="discountValue58">00</span></td>
						</tr>
						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">AMOUNT
										TO PAY:</span></b></td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="amoutToPay58">00</span></b></td>
						</tr>
						<tr>
							<td style="text-align: right;">---------------------------</td>
							<td></td>
						</tr>



						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 11px; font-family: sans-serif;">Paid
										Amount:</span></b></td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="paidAmount58">00</span></b></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 11px; font-family: sans-serif;">Tender
										Amount:</span></b></td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="tenderAmount58">00</span></b></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 11px; font-family: sans-serif;">Refund
										Amount:</span></b></td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="refundAmount58">00</span></b></td>
						</tr>



						<tr>
							<td style="text-align: right;">---------------------------</td>
							<td></td>
						</tr>
					</table>
					<div style="text-align: left; width: 150px;">
						<b><font style="font-size: 12px; font-family: sans-serif;"><div
									id="payType58"></div></font></b>
					</div>
					<div style="text-align: left; width: 150px;">
						<font style="font-size: 12px; font-family: sans-serif;">Thank
							You. Visit us Again</font>
					</div>
				</div>
			</div>
			<div class="modal-footer" id="removePrint58"
				style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
				<button type="button" onclick="javascript:printCashOrCardLocal58()"
					style="background: #72BB4F; font-weight: bold;"
					data-dismiss="modal" class="btn btn-success" id="printBtn_58">PRINT</button>
				<button type="button" onclick="return false"
					style="background: #72BB4F; font-weight: bold;"
					data-dismiss="modal" class="btn btn-success">CANCEL</button>
			</div>
		</div>
	</div>

	<!--  *********  PRINT IN 2100 ******** -->

	<div class="modal fade" data-backdrop="static"
		id="cashhelloPrintModal2100" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="width: 276px; height: auto;">

			<div class="modal-body" id="printDiv2100"
				style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

				<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>

				<div
					style="text-align: center; width: auto; font-size: 20px; color: #000000">

					<b><font
						style="font-size: 19px; font-style: inherit; font-family: sans-serif;"><div
								id="storeName2100"></div></font></b> <b><font
						style="font-size: 17px; font-style: normal; font-family: sans-serif;"><div
								id="storeAddr2100"></div></font></b> <font
						style="font-size: 15px; width: auto; font-style: inherit; font-family: sans-serif;"><div
							id="storeEmail2100"></div></font> <font
						style="font-size: 15px; width: auto; font-style: normal; font-family: sans-serif;"><div
							id="storePhNo2100"></div></font><br>


					<div
						style="text-align: left; font-size: 15px; font-family: sans-serif;">
						<b>Order No:</b> <span id="cashOrdervalue2100">00</span>
					</div>
					<div
						style="text-align: left; font-size: 15px; font-family: sans-serif;"
						id="showtableno2100px">
						<b>Order Type:</b> <span id="cashtableNoValue2100">00</span>
					</div>
					<div style="text-align: left;">-------------------------------------------------------------------------------------------------------</div>

					<div class="table-responsive" id="orderitemContId_2100">
						<table
							style="color: #000000; border: none; height: 50px; width: 100%;">

							<thead>
								<tr>
									<th style="font-size: 15px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">Item</th>
									<th
										style="width: 110px; float: right; padding-right: 120px; text-align: center; font-size: 15px; font-family: sans-serif;">Qty</th>
									<th
										style="width: 110px; padding-right: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">Rate</th>
									<th
										style="width: 110px; text-align: center; font-size: 15px; font-family: sans-serif;">Amt</th>
								</tr>
							</thead>


							<tbody style="color: #000000; padding: 1px;"
								id="itemDetailsPrint2100"></tbody>

						</table>
					</div>


					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<table style="height: 50px; width: 100%;">

						<tr>
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">TOTAL
								AMOUNT:</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="cashtotalamt2100">00</span></td>
						</tr>
						<tr id="cashtotalServiceCharge2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
								Service Charge:</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
								<span id="cashservChrg2100">00</span>
							</td>
						</tr>

						<tr id="cashtotalServiceTax2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
								Service Tax(${sessionScope.loggedinStore.serviceTaxAmt}%):</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="cashservTax2100">00</span></td>
						</tr>

						<tr id="cashtotalVatTax2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Total
								Vat(${sessionScope.loggedinStore.vatAmt}%):</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="cashvatTax2100px">00</span></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Gross
										Amount:</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="cashgrossAmount2100">00</span></b></td>
						</tr>

						<tr id="cashshowDiscount2100px">
							<td
								style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
								TOTAL DISCOUNT:</td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><span
								id="cashdiscountValue2100">00</span></td>
						</tr>

						<tr>
							<td><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">AMOUNT
										TO PAY:</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="cashamoutToPay2100">00</span></b></td>
						</tr>
					</table>

					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<table style="height: 50px; width: 100%;">

						<tr>
							<td id="paid_amt"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
										Amount:</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="paidAmount2100">00</span></b></td>
						</tr>

						<tr>
							<td id="tender_amt"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Tender
										Amount:</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
									id="tenderAmount2100">00</span></b></td>
						</tr>

						<tr>
							<td id="refund_amt"><b><span
									style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund
										Amount:</span></b></td>
							<td
								style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b>
									<span id="refundAmount2100"><fmt:formatNumber
											type="number" value="${invPurchaseOrderItem.oldStock}"
											maxFractionDigits="2" />00</span>
							</b></td>
						</tr>



					</table>

					<div style="">-------------------------------------------------------------------------------------------------------</div>

					<div style="text-align: center;">
						<b><font style="font-size: 15px; font-family: sans-serif;"><span
								id="payType2100"></span></font></b>
					</div>
					<div style="text-align: center;">
						<font style="font-size: 16px; font-family: sans-serif;">Thank
							You. Visit us Again</font>
					</div>
				</div>
				<div class="modal-footer" id="cashRemovePrint2100"
					style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
					<button type="button"
						onclick="javascript:printCashOrCardLocal2100()"
						style="background: #72BB4F; font-weight: bold;"
						class="btn btn-success" id="printBtn_80">PRINT</button>
					<button type="button" onclick="return false"
						style="background: #72BB4F; font-weight: bold;"
						data-dismiss="modal" class="btn btn-success">CANCEL</button>
				</div>
			</div>

			<!-- =========================================== printDiv2100(For GST) ===================================================== -->

			<div class="modal fade" data-backdrop="static"
				id="cashhelloPrintModal2100_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="printDiv2100GST"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
						<div
							style="text-align: center; height: 550px; width: 100%; position: inherit; width: 100%; font-size: 20px; color: #000000">


							<b><font
								style="font-size: 19px; font-style: inherit; font-family: sans-serif;">${sessionScope.loggedinStore.storeName}</font></b><br>
							<b><font
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address}
							</font></b>

							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Email :</b> ${sessionScope.loggedinStore.emailId}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Ph :</b> ${sessionScope.loggedinStore.mobileNo}
							</div>
							<div style="font-size: 15px; font-family: sans-serif;">
								<b>Tax Invoice </b>
							</div>
							<div>
								<div style="float: left;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>${sessionScope.loggedinStore.gstText} :</b>
										   ${sessionScope.loggedinStore.gstRegNo}
									</div>
									<%-- <c:if test="${sessionScope.loggedinStore.id == 120}">
							           <div style="text-align: left; font-size: 15px; font-family: sans-serif;">
								        <b>FSSAI:</b>${sessionScope.loggedinStore.dataSource} 
							           </div>
							        </c:if> --%>
									<br> <br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<c:choose>
										    <c:when test="${sessionScope.loggedinStore.id==168}">
										      <b>Details of Patient</b>
										     </c:when>    
										    <c:otherwise>
										       <b>Details of Receiver</b>
										    </c:otherwise>
										</c:choose>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="cashCustName_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b> <span id="cashCustAddr_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="cashCustState_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b><span id="cashCustPhone2100_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span id="cashCustGSTIN_GST"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="cashOrdervalue2100_GST">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Date :</b> <span id="cashOrderDate_GST"></span>
									</div>
									<c:if test="${sessionScope.loggedinStore.id==168}">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Doctor:</b> <span id="cashOrderDeliveryBoy_GST"></span>
									</div>
									</c:if>
								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse;"
									id="orderItemTblPaid">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
										  <c:if test="${sessionScope.loggedinStore.id!=168}">		
												<th width="30%;"><spring:message code="item.jsp.name"
														text="Item Name" /></th>
											 </c:if>
											 <c:if test="${sessionScope.loggedinStore.id==168}">		
												<th width="40%;">Description</th>
											 </c:if>
											 <c:if test="${sessionScope.loggedinStore.id!=168}">
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" />/</th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											</c:if>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<c:if test="${sessionScope.loggedinStore.id!=168}">
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											</c:if>
											<c:if test="${sessionScope.loggedinStore.id!=168}">	
												<th width="5%;"><spring:message code="purinvdet.jsp.pqty"
														text="Rate" /></th>
											</c:if>		
											<c:if test="${sessionScope.loggedinStore.id==168}">
												<th width="30%;"><spring:message code="purinvdet.jsp.pqty"
													text="Rate" /></th>
											</c:if>	
											<c:if test="${sessionScope.loggedinStore.id!=168}">			
												<th width="5%;"><spring:message code="purinvdet.jsp.lqty"
														text="Total" /></th>
											</c:if>
											<c:if test="${sessionScope.loggedinStore.id == 168}">			
												<th width="30%;"><spring:message code="purinvdet.jsp.lqty"
													text="Total" /></th>
											</c:if>
											<c:if test="${sessionScope.loggedinStore.id!=168}">			
												<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" />(${orders.orderBill.discountPercentage}%)</th>
												</c:if>
												<c:if test="${sessionScope.loggedinStore.id==168}">			
														<th width="20%;"><spring:message
															code="reprintcash.jsp.totqty" text="Disc" />(${orders.orderBill.discountPercentage}%)</th>
												</c:if>
											<c:if test="${sessionScope.loggedinStore.id!=168}">	
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Taxable Value" /></th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.mrp" text="CGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="purinvdet.jsp.vatprcnt" text="SGST" />&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;<spring:message
													code="reprintcash.jsp.dpcnt" text="IGST" />&nbsp;
											</th>
											</c:if>
										</tr>
										<c:if test="${sessionScope.loggedinStore.id!=168}">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Rate" /></th>
											<th width="10%;"><spring:message code="pos.jsp.mrpLs"
													text="Amt." /></th>
										</tr>
										</c:if>
									</thead>
									<tbody id="itemDetailsPrint2100_GST">

									</tbody>
								</table>
							</div>



						</div>

						<div>
							<table style="height: 50px; width: 100%;">
								<tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In figure):</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="cashgrossAmount2100_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="cashgrossAmount2100_word_gst"></span></td>
								</tr>
							<c:if test="${sessionScope.loggedinStore.id!=168}">		
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 60%" id="cashIGST2100_gst"></span></td>

								</tr>
							</c:if>	
							<c:if test="${sessionScope.loggedinStore.id==168}">		
								<tr id="totalServiceTax_2100px" style="display:none;">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 60%" id="cashIGST2100_gst"></span></td>

								</tr>
							</c:if>								
								<!-- new added 10.5.2018 start -->
								 <tr>
	                             <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_paidbill_2100px">00</span></b></td>
								 </tr>
								
								
								 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_paidbill_2100px">00</span></b></td>
								 </tr>
								
								
									<!-- new added 10.5.2018 end -->
									 <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									   <b><span id="paymentmode_paidbill_2100px"></span></b></td>
								 </tr>
								
								
							</table>
						</div>
						<c:if test="${sessionScope.loggedinStore.id == 120}">
							<div style="font-size: 15px; font-family: sans-serif; color: black; margin-top: 40px;">
							Narration:<span id="remarks_2100px_gst"></span>
							</div>
							<div style="font-size: 15px; font-family: sans-serif; color: black; margin-top: 10px;">
							Bank Details:
							</div>
							<div style="font-size: 14px; font-family: sans-serif; color: black;">
							BANK NAME: THE FEDERAL BANK LIMITED
							</div>
							<div style="font-size: 14px; font-family: sans-serif; color: black;">
							BRANCH NAME: SHAKESPERE SARANI,KOLKATA-700017
							</div>
							<div style="font-size: 14px; font-family: sans-serif; color: black;">
							A/C No.: 14000200014938
							</div>
							<div style="font-size: 14px; font-family: sans-serif; color: black;">
							IFSC: FDRL0001400
							</div>
						</c:if>
						<div style="text-align: center; margin-top: 30px;">
							<font
								style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
								You. Visit us Again*****</font>
						</div>
						<!-- <div class="modal-footer" id="removePrint_2100px"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:localPrint_2100px()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">PRINT</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">CANCEL</button>
						</div> -->
						<div id="packageContId"></div>
					</div>
				</div>
			</div>


			<!-- ************    END    ************    -->

		</div>
	</div>
	
	
	
	
	
	<div class="modal fade" data-backdrop="static" id="alertselectTaxModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.addVndr" text="Tax Setup" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table style="color: #fff;font-size: 16px;">
                  		<c:if test="${! empty sessionScope.loggedinStore.vatTaxText && sessionScope.loggedinStore.vatTaxText!='null'}">
                            	<tr>
                            		<td>
                            			<input type="checkbox" id="vatchk" name="taxChk" onclick="enablevatTxt(this)" value="vatval" style="margin-bottom: 5px;">&nbsp;&nbsp;&nbsp;
                            		</td>
                            		<td>
                            			${sessionScope.loggedinStore.vatTaxText}&nbsp;&nbsp;&nbsp;
                            			<input type="hidden" id="hidvattxt" value="${sessionScope.loggedinStore.vatTaxText}">
                            		</td>
                            		<td>
                            			<input type="text" id="vatAmtTxt" size="4" disabled="disabled" value="${sessionScope.loggedinStore.vatAmt}" style="margin-bottom: 5px;color: #222222;">&nbsp;%
                            		</td>
                            	</tr>
                         </c:if>
                         <c:if test="${! empty sessionScope.loggedinStore.serviceTaxText && sessionScope.loggedinStore.serviceTaxText!='null'}">
                            	<tr>
                            		<td>
                            			<input type="checkbox" id="stchk" name="taxChk" onclick="enablestTxt(this)" value="stval" style="margin-bottom: 5px;">&nbsp;&nbsp;&nbsp;
                            		</td>
                            		<td>
                            			${sessionScope.loggedinStore.serviceTaxText}&nbsp;&nbsp;&nbsp;
                            			<input type="hidden" id="hidsttxt" value="${sessionScope.loggedinStore.serviceTaxText}">
                            		</td>
                            		<td>
                            			<input type="text" id="stAmtTxt" size="4" disabled="disabled" value="${sessionScope.loggedinStore.serviceTaxAmt}" style="margin-bottom: 5px;color: #222222;">&nbsp;%
                            		</td>
                            	</tr>
                         </c:if>
                         <tr>
                         	<td></td>
                         	<td></td>
                         	<td><a href="javascript:updatetaxAllItem()" class="btn btn-success" style="background:#41A1E3;margin-top: 5px;">SUBMIT</a> 
                          <button type="button" style="background:#F60;margin-top: 5px;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                         	
                         	</td>
                         </tr>
                         
                  	</table>
                                           
	 </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
	
	
	
	
		<div class="modal fade" data-backdrop="static" id="taxupdationsuccessmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">Success</h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;">Taxes has been updated successfully</div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" onclick="javascript:jLogout();" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" data-backdrop="static" id="alertalreadypaidModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invtypemgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="alreadypaidmsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.invtypemgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
	
	
	<!-- Print kot modal start -->
	
	<div class="modal fade" data-backdrop="static" id="printingkot"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" style="width: 205px; height: 'auto';">
					<div class="modal-body" id="kotPrint"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 2px !important;">
						<div
							style="text-align: center; width: 205px; font-size: 20px; color: #000000">
							<div
								style="text-align: center; font-family: sans-serif; font-size: 20px">
								<spring:message code="order.jsp.KOT" text="KOT" />
							</div>
							<font
								style="font-size: 18px; font-family: sans-serif; text-align: center;">${sessionScope.loggedinStore.storeName}</font><br>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<span id="dateTimeValue">00</span>&nbsp;(${sessionScope.loggedinUser.contactNo})
							</div>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="ordValue" style="font-weight:bold">00</span>
							</div>
							<div id="kottable"
								style="text-align: left; font-size: 11px; font-family: sans-serif;display:none;">
								<b><spring:message code="order.jsp.TableNo" text="Table No" />
									:</b> <span id="tblValue">00</span>
							</div>
							<div id="kothdorpercel" class="hide"
								style="text-align: left; font-size: 12px; font-family: sans-serif;">
								<b> <span id="hdorpercelValue"></span></b>
							</div>
							<div style="visibility: hidden;">----------</div>

							<table
								style="color: #000000; border: none; height: auto; width: 186px;">
								<thead>
									<th style="font-size: 11px; width: 102px;"><span
										style="float: left; font-family: sans-serif;">ITEM NAME</span></th>
									<th
										style="text-align: center; font-family: sans-serif; font-size: 11px">QTY</th>
								</thead>
								<tbody
									style="color: #000000; padding: 1px; font-family: sans-serif; font-size: 11px;"
									id="kotitems"></tbody>
							</table>
						</div>
						<div class="modal-footer" id="removeKotPrint"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button" onclick="javascript:kotPrint()"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" id="printBtn">
								<spring:message code="order.jsp.PRINT" text="PRINT" />
							</button>
							<button type="button" onclick="return false"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
						</div>
					</div>
				</div>
			</div>
	
	
	
	
	<div class="modal fade" data-backdrop="static" id="itemnotfoundModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">

								<spring:message code="order.jsp.itemnotfound"
									text="Item not found against this code, please add the item first." />
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
	
	
	          <!-- Show Order Detail Modal Start -->
	<div class="modal fade in" data-backdrop="static" id="orderDetailDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           Order Details
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;" id="printDivshow">
                        <div style="text-align: left;font-size: 20px;">
                          
                           <table id="tblorderdata">
                              <tbody>
							   <tr>
                                 <td><spring:message code="order.jsp.OrderNoInvoice" text="Order No / Invoice" />:
                                 </td>
                                 <td style=" border-spacing:0 15px;">
								    <span id="cashOrdervalueshow" style="font-weight:bold">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td>Order Date:
                                 </td>
                                 <td>
								  <span  id="cashOrderdateshow">00</span>
                                 </td>
								 </tr>
                              	 <tr>
                                 <td>Order Time:
                                 </td>
                                 <td>
								 <span  id="cashOrdertimeshow">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td>Booking Date:
                                 </td>
                                 <td>
								  <span  id="cashBookingdateshow">00</span>
                                 </td>
								 </tr>
                                 <tr>
                                 <td> Order Type:
                                 </td>
                                 <td>
								  <span id="cashtableNoValueshow"></span>
                                 </td>
								 </tr>
                              </tbody>
							  </table>
							  <br>
							  <table id="custrshow" style="display:none;">
							  <tbody>
							  <tr>
							  <td colspan="2">
							    <span style= "text-decoration: underline;">Customer Details</span> 
							  </td>
							  </tr>
							   <tr id="cusnametrshow" style="display:none;padding-bottom: 2px;padding-top: 3px;">
                                 <td> Name:&nbsp;&nbsp;</td>
                                 <td id="cusnameshow"></td>
                              </tr>
							  <tr id="cusphnotrshow" style="display:none;">
                                 <td> Contact No: &nbsp;&nbsp;</td>
                                 <td id="cusphnoshow"></td>
                               </tr>
                              	</tbody>
							  </table>									
                             
                            <br>
                            <div style="height:100px;border:solid 1px white;overflow:scroll;overflow-x:hidden;overflow-y:scroll;" id="ordrDetailDiv">
							<table class="table table-striped table-bordered" style="color:#FFF; border:1px solid #222222;font-size:70%;" id="ordereditems">
							<thead>
							<tr>
							<th style="text-align:center;"><spring:message code="order.jsp.Items" text="Items" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.Qty" text="Qty" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.RATE" text="RATE" /></th>
							<th style="text-align:center;"><spring:message code="order.jsp.TOTAL" text="TOTAL" /></th>
							</tr>
							</thead>
							<tbody style="color:#fff; padding:1px; max-height: 10px;overflow-y: scroll;" id="itemDetailsPrintshow">
							</tbody>
							</table>
						    </div> 
							<table  align="right" id="paymentDetailDiv">
							<tr>
							<td><span style="color:#FFF;font-size:70%"><spring:message code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></td>
							<td><span id="cashgrossAmountshow" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							<tr>
							<td><span style="color:#FFF; font-size:70%"><spring:message code="order.jsp.PAIDAMT" text="PAID AMT" />:</span></td>
							<td><span id="cashamoutPaidshow" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							<tr>
							<td><span style="color:#FFF; font-size:70%"><spring:message code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></td>
							<td> <span id="cashamoutToPayshow" style="color:#FFF;font-size:100%;text-align: right;">00</span></td>
							</tr>
							</table>
							</div>
                               
                          <br>
                        </div>
                  
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;text-align: center;">
                         <button type="button" onclick="closeOrderDetailsModal();"
								style="background: #72BB4F; font-weight: bold;margin-left: 100px;"
								 class="btn btn-success">
								<spring:message code="order.jsp.CANCEL" text="CANCEL" />
							</button>
                       
                     </div>
                        </div>
                  </div>
               </div>
            
			
			<!-- Show Order Detail Modal End -->
	
		<!-- Advance booking table details data model start -->
	<div class="modal fade" data-backdrop="static" id="advtblbooklistsearchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog modal-lg" >
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.admleftpanel.jsp.prebookingheader" text="ADVANCE BOOKING SCHEDULE" />
							</h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<%-- <div class="row" style="text-align: center; font-size: 20px;">
							    <div class="col-lg-5 col-md-5">
								<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_inv_po_period.jsp.frmDate" text="From Date:" /></span>
								<input type="text" id="fromdateforpretblbook" style="color:black;" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />" >
								
								</div>
                                <div class="col-lg-5 col-md-5">								
								 <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_inv_po_period.jsp.toDate" text="To Date:" /></span>
								 <input type="text" id="todateforpretblbook" style="color:black;" size="10" > 
								 </div>
								 <div class="col-lg-2 col-md-2">
								     <a href="javascript:showdetailsofadvtablebooking(document.getElementById('fromdateforpretblbook').value,document.getElementById('todateforpretblbook').value)" class="btn btn-success" style="background:#0CF;margin-bottom: 3px;"><spring:message code="admin.rpt_inv_po_period.jsp.submit" text="SUBMIT" /></a>             									
								 </div>
								 
						      </div> --%>
						      <div id="tableprebookingdetaildata"></div>
						      <div id='calendar'></div>
						
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.tablenew.jsp.ok" text="OK" />
							</button>
						</div>
					
				</div>
			</div>
		</div>
			<!-- Advance booking table details data model end -->	
	
	<!--Item Current Qty Modal Start  -->
	<div class="modal fade" data-backdrop="static" id="itemCurrentStockModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="order.jsp.alert" text="Alert" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
                                <input type="text" id="itIdData" style="display:none;" value=""/>
								<input type="text" id="itNameData" style="display:none;" value=""/>
								<input type="text" id="itPriceData" style="display:none;" value=""/>
								<input type="text" id="discData" style="display:none;" value=""/>
								<input type="text" id="vatData" style="display:none;" value=""/>
								<input type="text" id="serviceTaxData" style="display:none;" value=""/>
								<input type="text" id="promoFlagData" style="display:none;" value=""/>
								<input type="text" id="promoValueData" style="display:none;" value=""/>
								<spring:message code="order.jsp.currentstockofitem"
									text="Available Stock Of Item" />&nbsp;
								   <span id="itmName"></span>&nbsp;
								   <spring:message code="order.jsp.is"
									text=" Is:" />&nbsp;&nbsp;
								    <span id="itmcurstck"></span>
								    
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="addOrUpdateOrderItems(document.getElementById('itIdData').value,document.getElementById('itNameData').value,document.getElementById('itPriceData').value,document.getElementById('discData').value,document.getElementById('vatData').value,document.getElementById('serviceTaxData').value,document.getElementById('promoFlagData').value,document.getElementById('promoValueData').value);" id="itmSaleBtn"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.Sale" text="SALE" />
							</button>
							<button type="button" onclick="clearItemCodeSearch()"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="order.jsp.close" text="CLOSE" />
							</button>
						</div>
					</div>
				</div>
			</div>
	<!-- Item Current Qty Modal End -->
	<div class="modal fade" data-backdrop="static" id="msgmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div style="text-align: center; font-size: 20px;" id="msgspace"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="stockinnew.jsp.OK" text="OK" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itmOutOfStockmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					               <input type="text" id="itIdOfOutStckItm" style="display:none;" value=""/>
								   <input type="text" id="itNameOfOutStckItm" style="display:none;" value=""/>
								   <input type="text" id="itPriceOfOutStckItm" style="display:none;" value=""/>
								   <div style="text-align: center; font-size: 20px;" id="msgspace1"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="orderItemQtyIncrease(document.getElementById('itIdOfOutStckItm').value,document.getElementById('itNameOfOutStckItm').value,document.getElementById('itPriceOfOutStckItm').value);" id="itmQtyIncrBtn"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.increase" text="INCREASE" />
							</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static" id="itmOutOfStockmodalForManualEntry" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="stockinnew.jsp.Alert" text="Alert" /></h4>
				</div>
				<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					               <input type="text" id="itIdOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <input type="text" id="itNameOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <input type="text" id="itQtyOfOutStckItmForManualEntry" style="display:none;" value=""/>
								   <div style="text-align: center; font-size: 20px;" id="msgspace2"></div>
				</div>
				<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="enterItemManualQuantity(document.getElementById('itQtyOfOutStckItmForManualEntry').value,document.getElementById('itIdOfOutStckItmForManualEntry').value);" id="itmQtyIncrBtnManually"
								style="background: #72BB4F; font-weight: bold; width:30%;"
								class="btn btn-success">
								<spring:message code="order.jsp.increase" text="INCREASE" />
							</button>
					<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" data-backdrop="static"
			id="alerteditOrderquantityModal1" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog" style="margin: 100px auto;">
				<div class="modal-content"
					style="border: 3px solid #ffffff; border-radius: 0px;">
					<div class="modal-header"
						style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

						<h4 class="modal-title"
							style="font-size: 18px; font-weight: bold;" id="myModalLabel">Alert!</h4>
					</div>
					<div class="modal-body"
						style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						<div style="text-align: center; font-size: 20px;">
							<input type="hidden" id="hiddmanualeditItmId" value="">
							Please enter a valid number!
						</div>
					</div>
					<div class="modal-footer"
						style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
						<button type="button" onclick="javascript:setOrderItemQtyManually()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success">OK</button>
					</div>
				</div>
			</div>
		</div>
	      <div class="modal fade" data-backdrop="static" id="creditcustAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <c:if test="${sessionScope.loggedinStore.id !=87}">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.storecustmgnt.jsp.addCustomer" text="Add Customer" /></h4>
                                            </c:if>
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.storecustmgnt.jsp.addStaff" text="Add Staff" /></h4>
                                            </c:if>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
								<table>
									<tr>
										<td><spring:message code="admin.storecustmgnt.jsp.name"
												text="NAME" /> <span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<!-- <td style="margin-bottom: 3px;"><input type="text"
											id="addstorecustnameContId" onkeypress='return lettersOnlyCreditCust(event)'
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td> -->
											<td style="margin-bottom: 3px;"><input type="text"
											id="addstorecustnameContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.contactNo" text="CONTACT NO" />
											<span style="color: #ff0000;">*</span></td>
										<td>:</td>
										<td><input type="text" id="addstorecustcontactContId" maxlength="10"
											style="width: 95%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKeyCreditCust(event)'/></td>
									</tr>

									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.emailId" text="EMAIL ID" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustemailContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.location"
												text="LOCATION" /></td>
										<td>:</td>
										<td><input type="text" id="addstorelcustlocation"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>

									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.address" text="ADDRESS" /></td>
										<td>:</td>
										<td><textarea id="addstorecustaddressContId" rows="2"
												style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.houseno"
												text="HOUSE NO" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecusthouseno"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.streetno"
												text="STREET NO" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecuststreet"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>
									<tr>
										<td><spring:message code="order.jsp.custDOB"
												text="DATE OF BIRTH" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustdob"
											style="width: 95%; color: #222222; margin-bottom: 5px;" value=" <fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td> <%-- --%>
									</tr>

									<tr>
										<td><spring:message code="order.jsp.custAnniversary"
												text="ANNIVERSARY DATE" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustanniversarydate"
											style="width: 95%; color: #222222; margin-bottom: 5px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>  <%-- --%>
									</tr>
									<tr>
										<td><spring:message
												code="admin.storecustmgnt.jsp.creditLimmit"
												text="CREDIT LIMIT" /></td>
										<td>:</td>
										<td><input type="text" id="addstorecustcrlimitContId"
											style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
									</tr>


								</table>
								<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addstorecustalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelCreditCustomer()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.storecustmgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addCreditCustomer()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.storecustmgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="catdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.storecustmgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Rate change modal start -->
                            <div class="modal fade" data-backdrop="static" id="itemRateChangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="base.ordertaking.changerate" text="CHANGE RATE" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                        	 
                                        	  <input type="text" id="rateChangeItemId" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemName" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemDisc" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemVat" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemSTax" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemPromoFalg" style="display:none;" value=""/>
								              <input type="text" id="rateChangeItemPromoVal" style="display:none;" value=""/>
								   
                                        	  <spring:message code="base.ordertaking.newrate" text="New Rate" />:
                                              <input type="text" id="itemNewRateData" value="" style="color: black;"/>
                                              <br><span id="changeratealert" style="color:red"></span>
                                            </div>
                                            
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <!-- <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:clearRemark()"  class="btn btn-success"><span class="fa fa-eraser"></span></button> -->
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:setChangedRate(document.getElementById('rateChangeItemId').value,document.getElementById('rateChangeItemName').value,document.getElementById('rateChangeItemDisc').value,document.getElementById('rateChangeItemVat').value,document.getElementById('rateChangeItemSTax').value,document.getElementById('rateChangeItemPromoFalg').value,document.getElementById('rateChangeItemPromoVal').value)"  class="btn btn-success"><spring:message code="base.ordertaking.change" text="CHANGE" /></button>
                                            <button type="button" style="font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Rate change modal end -->
                            <!--remarks modal start  -->
           <div class="modal fade" data-backdrop="static" id="remarksModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="REMARKS" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                        	  <spring:message code="unpaidorder.jsp.Remarks" text="Remarks" />:
                                              <input type="text" id="orderRemarksData" value="" style="color: black;"/>
                                              <br><span id="rmkalert" style="color:red"></span>
                                            </div>
                                            
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <!-- <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:clearRemark()"  class="btn btn-success"><span class="fa fa-eraser"></span></button> -->
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:setRemarks()"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                            <button type="button" style="font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				
                                        </div>
                                    </div>
                                </div>
                            </div>


       <!--remarks modal  end -->
                            
                             <!--packaging note modal start  -->
           <div class="modal fade" data-backdrop="static" id="packagingNoteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="PACKAGING REMARKS" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                        	  <spring:message code="unpaidorder.jsp.Remarks" text="Remarks" />:
                                              <input type="text" id="pkgNoteData" value="" style="color: black;"/>
                                              <br><span id="pkgnotealert" style="color:red"></span>
                                            </div>
                                            
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <!-- <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:clearRemark()"  class="btn btn-success"><span class="fa fa-eraser"></span></button> -->
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:setPackagingNote()"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                            <button type="button" style="font-weight: bold; width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="order.jsp.close" text="CLOSE" /></button>
				
                                        </div>
                                    </div>
                                </div>
                            </div>


       <!--packaging note modal  end -->
	
	<!-- modal end -->


	</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script src="${pageContext.request.contextPath}/assets/js/baseScript.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/showOrderInCalender.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/json/json-min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/json/yahoo-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- for numeric keypad it goes to header section -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
	
	<!-- For event calendar -->
     <script src="${pageContext.request.contextPath}/assets/js/calendar/moment.min.js"></script>
     <script src="${pageContext.request.contextPath}/assets/js/calendar/fullcalendar.min.js"></script>
     
	 <style>
       .current {
	     background: #939393;
        }
    </style>
	<script type="text/javascript">
	var BASE_URL="${pageContext.request.contextPath}";
	var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
	var vfdPort="${sessionScope.loggedinStore.customerDisplay}";
	var storeID="${sessionScope.loggedinStore.id}";
	var storeAddr ="${sessionScope.loggedinStore.address}";
	var itcatId="${itcatno}";
	var orderType="${orderType}";
	var softKey="${sessionScope.loggedinStore.softKey}";
	var printpaidBill="${sessionScope.loggedinStore.printPaidBill}";
	var cdrawerCode="${sessionScope.loggedinStore.cashDrawerCode}";
	var custId=null;
	var orderVal="${orders.ordertype}";
	var orderDeliveryPerson="${orders.deliveryPersonName}";
	var savedOrderItemCount="${savedOrderItemCount}";
	var calledFromSavedOrder='no';
	var SelectedOption="${currentOrderType}";
	var scflag="${sessionScope.loggedinStore.serviceChargeFlag}";
	var ordSucc = "${sessionScope.loggedinStore.ordSucc}";
	var storeBasedOrderNumber = "${orders.orderNo}";
	var displayCurrentStockMenu="${sessionScope.loggedinStore.displayCurrentStockMenu}";
	var negativeStockBilling="${sessionScope.loggedinStore.negativeStockBilling}";
	/*var  orderdata = "${orders}";
	console.log("orderdata::"+JSON.stringify(orderdata));*/
	</script>
	<script type="text/javascript">
	//var tableno="${tableNo}";
	$('.list-group-item.item_sub_child').on('click',function(){
	  $(this).parent().find('.list-group-item.item_sub_child').removeClass('current');
		$(this).addClass('current');
  });
	//for hatim tai
	if(itcatId!=""){
	<c:forEach items="${allmenu.menucategory}" var="menu" varStatus="loop">
	if(itcatId=="${menu.id}")
		{
		$("#"+itcatId).addClass("collapse in");
		$('.list-group-item.item_sub_child').removeClass('current');
		$('.list-group-item.item_sub_child').addClass('current');
		<c:forEach items="${menu.menucategory}" var="submenu" varStatus="loop1">
			clickonSubmenu("${submenu.id}", "${loop.index}");
		</c:forEach>
		}
	</c:forEach>
	}
	instantPaymentOpenModal();
/* 	
	
	$(document).ready(function() {
	$('#orderType option').click(function(){
	    $('#textboxid').val($(this).val());
	        });
	}); */
	
  function custDetails()
	{
		// $("#itemNameSearch").val()
		 
		var customerID=document.getElementById('modparcelcustIdhidden').innerHTML;//modparcelcustIdhidden
		if(customerID==null || customerID=='')
        {
			
			var orderText=$('#orderType').find("option:selected").text();
			document.getElementById('modOrderType').innerHTML=orderText;
         showCustDetailsModal();
         searchCustomer();
        }
      
	}
	
	 function newCustAdd()
		{
		 
		
			$('#searchCustId').css('visibility','hidden');
				var orderText=$('#orderType').find("option:selected").text();
				document.getElementById('modOrderType').innerHTML=orderText;
			var newCustName=document.getElementById('itemNameSearch').value;//modparcelcustName
			var newCustPh=document.getElementById('itemContactSearch').value;
			document.getElementById('modparcelcustName').value=newCustName;
			document.getElementById('modparcelcustPhone').value=newCustPh;
			if(newCustName==null||newCustPh==null){
				showselectcustalertModal();
			}
			else{
				showCustDetailsModal();
			}
	         
	         //searchCustomer();
	      //  }
	      
		}
		
	function showDelOptModal()
	{
		//alert('${sessionScope.loggedinStore.parcelAddress}');
		
		//validateCreateOrder();
		if(validateCreateOrder())
			{
			var orderText=$('#orderType').find("option:selected").text(); //orderNo
			//var orderNo=$('#orderNo').find("option:selected").value();
			var tabNO=document.getElementById('tablenoCont').innerHTML;
			if(tabNO=='0')
				{
				if(parcelAdd=='Y' && itcatId=="")
			{
					document.getElementById('PdeliveryOptionParcel').checked=true;
					//$('#ParceldelOptModal').modal('show')
					 document.getElementById('modOrderType').innerHTML=orderText;
					

					  /* if(orderVal==null || orderVal=='')
				       {
				       showCustDetailsModal();
				       }
				      else {
				    //   alert('previous order clubbing');
				       showCustDetailsModal();
				        calledFromSavedOrder='yes';
				       searchCustomer();

				      }  */
				      
				      
					 createOrder();
				      
					}
				else if(orderType!="")
					{
					document.getElementById('deliveryOptionHomedel').checked=true;
					//$('#delOptModal').modal('show');
					createOrder();
					}
				else
					{
					document.getElementById('deliveryOptionParcel').checked=true;
					//$('#delOptModal').modal('show');
					createOrder();
					}
				}
			else
				{
				document.getElementById('deliveryOptionDine').checked=true;
				//for saravanaa
				//$('#delOptModal').modal('show');
				createOrder();
				// end for saravanaa
				}
			//$('#delOptModal').modal('show');
			}
		else
			{
			//alert('Please add any items!');
			$('#alertselectItemModal').modal('show');
			}
	}
	function showOrderModal()
	{
		
		if(itcatId!="")
			{
			var begindivline="<div>PAYMENT OPTION : ";
			var htm="<input type='radio' id='instantpayOptionCash' name='instantpayOption' value='cash' checked='checked'>&nbsp;&nbsp;<span style='font-size: 24px;font-weight:bold;'>CASH</span>&nbsp;&nbsp;"+
   			"<input type='radio' id='instantpayOptionCard' name='instantpayOption' value='card' >&nbsp;&nbsp;<span style='font-size: 24px;font-weight:bold;'>CARD</span>";
   			var enddivline="</div>";
   			document.getElementById("instantPaycontId").innerHTML=begindivline+htm+enddivline;
			}

		$('#orderModal').modal('show');
	}
	function showCashModal()
	{
		//alert('order');
		$('#cashModal').modal('show');
	}
	function showCardModal()
	{
		//alert('order');
		$('#cardModal').modal('show');
	}
	function hideCashModal()
	{
		//alert('order');
		$('#cashModal').modal('hide');
	}
	function hideCardModal()
	{
		//alert('order');
		$('#cardModal').modal('hide');
	}
	
	function showdirectOrderModal()
	{
		$('#directOrderModal').modal('show');
	}
	function showspecialnoteModal()
	{
		$('#specialnoteModal').modal('show');
	}
	function showalertsaveorderModal()
	{
		$('#alertsaveOrderModal').modal('show');
	}
	function showselectitemalertModal()
	{
		$('#alertselectItemModal').modal('show');
	}
	
	function showconfirmdeleteOrderItemModal()
	{
		$('#confirmdeleteorderitemModal').modal('show');
	}
	function showparcelPaymentModal()
	{
		$('#parcelpayOptModal').modal('show');
	}
	function showaddDiscountModal()
	{
		$('#discountModal').modal('show');
	}
	function closeaddDiscountModal()
	{
		$('#discountModal').modal('hide');
	}
	function showalerteditOrderQuantityModal(id)
	{
		document.getElementById('hiddmanualeditItemId').value=id;
	  	$('#alerteditOrderquantityModal').modal('show');
	}
	function showCustDetailsModal()
	{
		$('#parcelCustDetailsModal').modal('show');
	}
	function showBillPrintSuccessModal()
	{
		$('#billPrintSuccessModal').modal('show');
	}
	function helloBillPrint()
	{
		$('#helloPrintModal').modal('show');
	}
	function showspecialNoteforOrderModal()
	   {
		   $('#specialnoteforOrderModal').modal('show'); 
	   }
	function closespecialNoteforOrderModal()
	   {
		   $('#specialnoteforOrderModal').modal('hide'); 
	   }
	function showCreditSaleModal()
	{
		//alert('order');
		$('#creditsaleModal').modal('show');
	}
	function hideCreditSaleModal()
	{
		//alert('order');
		$('#creditsaleModal').modal('show');
	}
	function openPaxModal()
	{
		//alert('order');
		var tabNO=document.getElementById('tablenoCont').innerHTML;
		if(tabNO!='0')
			{
			document.getElementById('noofPax').value="";
			document.getElementById('paxalertMsg').innerHTML="";
			$('#paxModal').modal('show');
			}
		
	}
	function closePaxModal()
	{
		//alert('order');
		$('#paxModal').modal('hide');
	}
	
	function openChangeTableModal()
	{
		document.getElementById('changetablealertMsg').innerHTML='';
		$('#changeTableModal').modal('show');	
	}
	function closeChangeTableModal()
	{
		$('#changeTableModal').modal('hide');	
	}
	function showsplitBillModal()
	{
		//alert('order');
		$('#splitBillModal').modal('show');
	}
	function hidesplitBillModal()
	{
		//alert('order');
		$('#splitBillModal').modal('hide');
	}
	function showsplitBillItemListModal()
	{
		//alert('order');
		$('#splitBillItemListModal').modal('show');
	}
	function hidesplitBillItemListModal()
	{
		//alert('order');
		$('#splitBillItemListModal').modal('hide');
	}
	
	function showsplitBillItemListModalcatwise()
	{
		//alert('order');
		$('#splitBillItemListModalcatwise').modal('show');
	}
	function hidesplitBillItemListModalcatwise()
	{
		//alert('order');
		$('#splitBillItemListModalcatwise').modal('hide');
	}
	function showCashChangeAmtModal()
	{
		//alert('order');
		$('#changeAmtModal').modal('show');
	}
	function showKotCheckListPrintSuccessModal()
	{
		$('#kotchecklistPrintSuccessModal').modal('show');
	}
	function showSplitPaymentCashModal()
	{
		//alert('order');
		$('#cashSplitPaymentModal').modal('show');
	}
	function hideSplitPaymentCashModal()
	{
		//alert('order');
		$('#cashSplitPaymentModal').modal('hide');
	}
    </script>
	<script type="text/javascript">  
	function menucatload (length,subMenuId,cssIndex ){
// 		alert('hicall');
// 		alert('length='+length);
// 		alert('subMenuId='+subMenuId);
// 		alert('cssIndex='+cssIndex);
cssIndex='nosidemenu';
$("#litewebpos").addClass('hide');
var firsttimecall=$("#firsttimecall").val();
// alert('firsttimecall='+firsttimecall);
//alert('BASE_URL'+BASE_URL);
if(firsttimecall=='Y'){
	setTimeout(
			  function() 
			  {
			    //do something special
				  loadMenuItems(BASE_URL + "/menu/menuitems.htm?menuid=" + subMenuId + "&index=" + cssIndex + "",document.getElementById('menu_items_container'));
				  $('#waitimage').addClass('hide');
			  }, 5000);
               }else{
	            loadMenuItems(BASE_URL + "/menu/menuitems.htm?menuid=" + subMenuId + "&index=" + cssIndex + "",document.getElementById('menu_items_container'));
	             $('#waitimage').addClass('hide');
           }
		
	}
	
	 
	$(document).ready(function() {
		


		   $('#modparcelcustanniversary').datepicker({
		    format : "yyyy-mm-dd",
		    autoclose : true,
		    endDate: '0'
		    
		   }); 
		   $('#modparcelcustdob').datepicker({
		    format : "yyyy-mm-dd",
		    autoclose : true,
		    endDate: '0'
		   }); 
		   

			var customerName= document.getElementById("itemNameSearch").value;
		      var customerContact= document.getElementById("itemContactSearch").value;
		      if(customerContact != '' ||  customerName != '')
		       {   
		    	  
			  //    console.log("customerContact" + customerContact + "customerName" + customerName);

		    	  enableDetailDsblAdd();
		    	  calledFromSavedOrder='yes';
		          searchCustomer();

		       }
		   
		   
		 });
	
	//enableDetailDsblAdd
	
	
	
	
	
	
	function deactivateTabs(){
	//	disbleDetailEnblAdd(); 
     //   console.log('now here');
 $tabs = $('.nav-justified li');
 var myArray = $(".nav-justified li a").map(function() {
            return $(this).text();
         }).get();
 for(var i = 0; i<myArray.length; i++)
 {
  if(myArray[i]!='Home')
  {
   $tabs.addClass('disabled');
  }
 }
}
	$(function() {
	       $("#itemCodeSearch")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompleteitemcode.htm",
	                                           type : "GET",
	                                           data : {
	                                               tagName : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                               response($
	                                                       .map(
	                                                               data,
	                                                               function(v) {

	                                                                   return {
	                                                                       label : v.name,

	                                                                       itemCode : v.id,
	                                                                       //tagCode : v.tagCode
	                                                                       items:v,
	                                                                   };

	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           select : function(e, ui) {

	                              // $("#itemCode").val(ui.item.itemCode);
	                               //$("#autocompleteItemId").val(ui.item.itemCode);
	                               var disc=0.0;
	                               if(ui.item.items.promotionFlag=='Y')
	                            	   disc=ui.item.items.promotionValue;
	                        	   additemtoOrder(ui.item.items.id,ui.item.items.name,ui.item.items.price,disc,ui.item.items.vat,ui.item.items.serviceTax,ui.item.items.promotionFlag,ui.item.items.promotionValue);
	                           }
	                       });
	   });
	
	$(function() {
	       $("#creditsalecustname")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompletecreditcustname.htm",
	                                           type : "GET",
	                                           data : {
	                                               tagName : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                               response($
	                                                       .map(
	                                                               data,
	                                                               function(v) {

	                                                                   return {
	                                                                       label : v.name,

	                                                                       itemCode : v.id,
	                                                                       //tagCode : v.tagCode
	                                                                       items:v,
	                                                                   };

	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#creditsaleModal",
	                           select : function(e, ui) {

	                        	$("#creditsalecustcontact").val(ui.item.items.contactNo);
	                        	   $("#hidcredisalecustid").val(ui.item.itemCode);
	                        	   var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Cash&nbsp;&nbsp;"+
                                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Card&nbsp;&nbsp;"+
                                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Nopay";
	                        	   $("#creditsalecustdetailcontId").html("Payment Type : "+htm);
	                           }
	                       });
	   });
	
	
	$(function() {
	       $("#creditsalecustcontact")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/autocompletecreditcustcontact.htm",
	                                           type : "GET",
	                                           data : {
	                                               tagName : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                               response($
	                                                       .map(
	                                                               data,
	                                                               function(v) {

	                                                                   return {
	                                                                       label : v.contactNo,

	                                                                       itemCode : v.id,
	                                                                       //tagCode : v.tagCode
	                                                                       items:v,
	                                                                   };

	                                                               }));
	                                           },
	                                           error : function(error) {
	                                               alert('error: ' + error);
	                                           }
	                                       });
	                           },
	                           appendTo: "#creditsaleModal",
	                           select : function(e, ui) {

	                        	$("#creditsalecustname").val(ui.item.items.name);
	                        	$("#hidcredisalecustid").val(ui.item.itemCode);
	                        	   var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Cash&nbsp;&nbsp;"+
                                			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Card&nbsp;&nbsp;"+
                                			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;Nopay";
	                        	   $("#creditsalecustdetailcontId").html("Payment Type : "+htm);
	                           }
	                       });
	   });
	
	
	   
	   
	   
	   /* $(function() {
		   if($("#custDetail").hasClass('enable-link')){

	       $("#modparcelcustPhone")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                        	   var custname=JSON.parse(data);
	                                        	   console.log(custname);
	                                        	   deactivateTabs();
	                                        	    if(data.length==0){
	                                        	 $("#parcelCustModalalertMsg").html("<strong>customer contact not found</strong>");
 												}else{
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
		                                                                   return {
		                                                                       label : v.contactNo,
		                                                                       name:v.name,
		                                                                       addr:v.address,
		                                                                   };

		                                                               }));
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	   }
	                                        	    if(custname.length==0){
	   	                                        	 $("#parcelCustModalalertMsg").html("<strong>customer contact not found</strong>");
	    												}
	                                        	    $("#modparcelcustName")
	               									.val("");
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");
	               							$("#modparcelcustlocation").val(
           									"");
	               							$("#modparcelcustAddress").val(
           									"");
	               							$("#modparcelcusthouseno").val(
           									"");
	               							$("#modparcelcuststreet").val(
           									"");
	               							$("#modparcelcustvatorcst").val(
           									"");
	                                           },
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       }); 
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	//$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);
		                        	 
		                           }
	                           
	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.name + ")</br><font size='2'>"+item.addr + "</font></a>" )
      				.appendTo( ul );
      		};
      		deactivateTabs();
	   }
	   }); */
	   
	   
	   $(function() {
		   

	       $("#modparcelcustlocation")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchlocation.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                    		   if($("#custDetail").hasClass('disable-link')){

	                                        	   var locname=JSON.parse(data);
	                                        	   console.log(locname);
	                                        	   deactivateTabs();
	                                        	   if(data.length==0){
	                                        		   $("#parcelCustModalalertMsg").html("<strong>customer location not found</strong>");	
	                                        		   }else{
	                                        		   response($.map(
	                                        				   locname,
                                                               function(v) {
                                                                   return {
                                                                       label : v.location,
                                                                      
                                                                   };

                                                               }));
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	   }
	                                        	   if(locname.length==0){
	                                        		   $("#parcelCustModalalertMsg").html("<strong>customer location not found</strong>");	
	                                        		   }
	                                        	 /*   $("#modparcelcustName")
	               									.val("");
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");
	               							
	               							$("#modparcelcustAddress").val(
           									"");
	               							$("#modparcelcusthouseno").val(
           									"");
	               							$("#modparcelcuststreet").val(
           									"");
	               							$("#modparcelcustvatorcst").val(
           									""); */
	                                    		   }
	                                    		   },
	                                           
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                               
	                                           }
	                                       });
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	//$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustlocation").val(ui.item.label);
		                        	 
		                           }
	                       });
	       deactivateTabs();
	   }); 
	   
	   
	   
	   
 
	   /* $(function() {
		   if($("#custDetail").hasClass('enable-link')){
			   
		   
	       $("#modparcelcustName")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                        	   var custname=JSON.parse(data);
	                                        	   console.log(custname);
	                                        	   deactivateTabs();
	                                        	   
	                                        	    if(data.length==0){
	                                        	    	
	               							$("#parcelCustModalalertMsg").html("<strong>customer name not found</strong>");
	                                        	   }else{
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
		                                                                   return {
		                                                                       label : v.name,
		                                                                       phno:v.contactNo,
		                                                                       addr:v.address,
		                                                                       custId:v.id,
		                                                                   };

		                                                               }));
	                                        		   $("#parcelCustModalalertMsg").html("");
	                                        	   }
	                                        	    if(custname.length==0){
	        	               							$("#parcelCustModalalertMsg").html("<strong>customer name not found</strong>");
	        	                                        	   }  
	               							$("#modparcelcustAddress").val(
	               									"");
	               							$("#modparceldeliveryPersonName").val(
	               									"");
	               							$("#modparcelcustlocation").val(
           									"");
	               							$("#modparcelcustAddress").val(
           									"");
	               							$("#modparcelcusthouseno").val(
           									"");
	               							$("#modparcelcuststreet").val(
           									"");
	               							$("#modparcelcustvatorcst").val(
           									"");
	                                               
	                                           },
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       }); 
	                           },
	                           appendTo: "#parcelCustDetailsModal",
	                           select : function(e, ui) {

		                        	$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);
		                        	$("#modparcelcustIdhidden").val(ui.item.custId);
		                        	 
		                           }
	                           
	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.phno + ")</br><font size='2'>"+item.addr + "</font></a>" )
      				.appendTo( ul );
      		};
      		
      		deactivateTabs();
	   }
	   }); */
	   function shownoOrderTypeModal()
		{
			$('#noOrderTypeModal').modal('show');
		}
	   function showprintBillReasonModal()
	   {
		 
	  //  $("#printBillReasonModal").modal("show");
	    document.getElementById('printBillReasonModal').style.display='block';
	   }
	   
	   var custname=null;
	   $(function() {
	       $("#itemNameSearch")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyname.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                        	    custname=JSON.parse(data);
	                                        	   console.log(custname);
	                                        	   //deactivateTabs();
	                                        	   
	               							
	                                        	    	$("#modparcelcustIdhidden").val('');
	                                        	    	
	                                        	    	$("#modparcelcustName").val();
	                		                        	$("#modparcelcustPhone").val();
	                		                        	$("#modparcelcustAddress").val("");
	                		                        	$("#modparcelcustlocation").val();
	                		                        	$("#modparceldeliveryPersonName").val("");
	                		                        	$("#modparcelcusthouseno").val();
	                		                        	$("#modparcelcuststreet").val();
	                		                        	$("#modparcelcuststate").val();
	                		                        	$("#modparcelcustvatorcst").val();
	                		                        	$("#modparcelcustdob").val(); 
	                		                        	$("#modparcelcustanniversary").val();
	                		                        	
	                		                         if(data==null){
	                                        	    	disbleDetailEnblAdd();
	                                        	    	}else{
	                                        		   console.log("in else");
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
		                                                                   return {
		                                                                       label : v.name,
		                                                                       phno:v.contactNo,
		                                                                       //addr:v.address,
		                                                                       custId:v.id,
		                                                                   };

		                                                               }));
	                                        	   }
	                    
	                                               
	                                           },
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       }); 
	                           },
	                         //  appendTo: "#itemNameSearch",
	                           select : function(e, ui) {

		                        	//$("#itemNameSearch").val(ui.item.custname);
		                        	$("#itemNameSearch").val(ui.item.label);
		                       		$("#itemContactSearch").val(ui.item.phno);
		                        	$("#modparcelcustIdhidden").val(ui.item.custId);
		                        	$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);
		                  			
		                        	enableDetailDsblAdd();
		                        	searchCustomer();
		                           }
	                        	

	                           
	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.phno + ")</a>" )
      				.appendTo( ul );
      		};
      		//deactivateTabs();
      		//disbleDetailEnblAdd();
      		
	   }); 
	   
	   
	   $(function() {
	       $("#itemContactSearch")
	               .autocomplete(
	                       {
	                           source : function(request, response) {
	                               $.ajax({
	                                           url : "${pageContext.request.contextPath}/order/searchcustbyphno.htm",
	                                           type : "GET",
	                                           data : {
	                                        	   term : request.term
	                                           },

	                                           dataType : "json",

	                                           success : function(data) {
	                                        	   var custname=JSON.parse(data);
	                                        	   console.log(custname);
	                                        	//   deactivateTabs();
	                                        	    if(data.length==0){
	                                        	    	
	                                        	    	//alert("new customer");
	                                        	    	$("#modparcelcustName").val();
	                		                        	$("#modparcelcustPhone").val();
	                		                        	$("#modparcelcustlocation").val();
	                		                        	$("#modparcelcusthouseno").val();
	                		                        	$("#modparcelcuststreet").val();
	                		                        	$("#modparcelcuststate").val();
	                		                        	$("#modparcelcustvatorcst").val();
	                		                        	$("#modparcelcustdob").val(); 
	                		                        	$("#modparcelcustanniversary").val();
	                                        	    	
	                                        	    	
	                                        	    	disbleDetailEnblAdd();

 												}else{
	                                        		   response($.map(
	                                        				   custname,
		                                                               function(v) {
		                                                                   return {
		                                                                       label : v.contactNo,
		                                                                       name:v.name,
		                                                                       //addr:v.address,
		                                                                       custId:v.id,
		                                                                   };

		                                                               }));
	                                        	   }
	                                   
	                                           },
	                                           error : function(error) {
	                                               console.log('error: ' + error);
	                                           }
	                                       }); 
	                           },
	                           select : function(e, ui) {

		                        	//$("#modparcelcustName").val(ui.item.custname);
		                        	//$("#itemContactSearch").val(ui.item.phno);
		                        	 
		                        	
	                        		$("#itemNameSearch").val(ui.item.name);
		                       		$("#itemContactSearch").val(ui.item.label);
		                        	$("#modparcelcustIdhidden").val(ui.item.custId);
		                        	$("#modparcelcustName").val(ui.item.custname);
		                        	$("#modparcelcustPhone").val(ui.item.phno);
		                        	
		                        	enableDetailDsblAdd();
		                        	searchCustomer();

		                           }
	                           
	                       })
	       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      			return $( "<li></li>" )
      				.data( "ui-autocomplete-item", item )
      				.append( "<a>" + item.label + "(" + item.name + ")</a>" )
      				.appendTo( ul );
      		};
      		//deactivateTabs();
      		//disbleDetailEnblAdd();
      		//searchCustomer();
	   });
	   
	   
	   function isNumberKey(evt){
	         var charCode = (evt.which) ? evt.which : evt.keyCode;
	         var customerName= document.getElementById("itemNameSearch").value;
	         var customerContact= document.getElementById("itemContactSearch").value;
	         
	         if(customerContact == '' ||  customerName == '')
	          {               
	        	 disbleDetailEnblAdd();
	          }
	         if (charCode > 31 && (charCode < 48 || charCode > 57))
	             return false;
	         return true;
	     }
	   
	   
	   function lettersOnly(evt) {
           evt = (evt) ? evt : event;
           var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
              ((evt.which) ? evt.which : 0));
         //  alert(charCode);
           var customerName= document.getElementById("itemNameSearch").value;
      var customerContact= document.getElementById("itemContactSearch").value;
      
      if(customerContact == '' ||  customerName == '')
       {               
    	  disbleDetailEnblAdd();
       }
           
           
           if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
              (charCode < 97 || charCode > 122)) {
             // alert("Enter letters only.");
              return false;
           }
           return true;
         }
	   
	   
	   
	   
	   
	   
	   function existingClassRemove()
	     {
	      
	        $("#custDetail").removeClass('enable-link');
	       $("#custDetail").removeClass('disable-link');
	       
	      $("#custAdd").removeClass('enable-link');
	       $("#custAdd").removeClass('disable-link');
	       
	     }
	   
	  function disbleDetailEnblAdd(){
		 
		  existingClassRemove();
		  $("#custDetail").addClass('disable-link');;
		  $("#custAdd").addClass('enable-link');
	  }
	   
 	function enableDetailDsblAdd(){
 		
 		  existingClassRemove();
		  $("#custDetail").addClass('enable-link');
		  $("#custAdd").addClass('disable-link');
		  
	  }
 	
 	function showCustomer()
 	{
 		var newCustName=document.getElementById('modparcelcustName').value;//modparcelcustName
		var newCustPh=document.getElementById('modparcelcustPhone').value;
		document.getElementById('itemNameSearch').value=newCustName;
		document.getElementById('itemContactSearch').value=newCustPh;
 		
 	}
 	
 	function showtaxupdatesuccessModal()
	{
		$('#taxupdationsuccessmodal').modal('show');
	}

 	  function showselcttaxModal()
 		{
 			$('#alertselectTax').modal('show');
 		}
 	  
 	   function closeselcttaxModal()
 	  {
 		 $('#alertselectTaxModal').modal('hide');//alertselectTaxModal
 	  } 
 	
	</script>
	
	<!-- Script for handling short key of ordertaking -->
	<script type="text/javascript">
	document.onkeydown = function(e) {
		//alert(e.keyCode);
		if((e.shiftKey && e.altKey && e.keyCode==83)){ // for save order (if you press shift+alt+s)
		      saveOrderByShortKey();
		 }
		if((e.shiftKey && e.altKey && e.keyCode==80)){ // for print unpaid order (if you press shift+alt+p)
		    printUnpaidOrderByShortKey();
		}
		if((e.shiftKey && e.altKey && e.keyCode==68)){ // for open discount modal (if you press shift+alt+d)
		    openDiscountByShortKey();
		}
		if((e.shiftKey && e.altKey && e.keyCode==88)){ // for open cash modal (if you press shift+alt+x)
		    openPaymentModalByShortKey("cash");
		}
		if((e.shiftKey && e.altKey && e.keyCode==89)){ // for open card modal (if you press shift+alt+y)
			 openPaymentModalByShortKey("card");
		}
		if((e.shiftKey && e.altKey && e.keyCode==90)){ // for open online modal (if you press shift+alt+z)
			 openPaymentModalByShortKey("online");
		}
		
	};
		
	function saveOrderByShortKey(){
		document.getElementById("ordersavebtn").click();
	    }
	
	function  printUnpaidOrderByShortKey(){
		var ordrno = document.getElementById("orderNo").value;
		if(ordrno != 0){
			 document.getElementById("printunpaidbillbtn").click();
			}
		else{
			 document.getElementById("alertText").innerHTML = "";
			 document.getElementById("alertText").innerHTML = "Save the order first!";
			 $('#alertModalForShortKey').modal('show');
			}
		}
	
	function openDiscountByShortKey(){
		var discount = document.getElementById("discBtnContId").innerHTML;
		 if(isNaN(discount)){
		 document.getElementById("openDiscountBtn").click();
		    }
		 else{
			 document.getElementById("alertText").innerHTML = "";
			 document.getElementById("alertText").innerHTML = "Discount already exist!";
			 $('#alertModalForShortKey').modal('show');
			 
			 }
		 }
		function openPaymentModalByShortKey(type){
			if(type == "cash"){
				document.getElementById("openCashModalBtn").click();
			}
            if(type == "card"){
            	document.getElementById("openCardModalBtn").click();
			}
            if(type == "online"){
            	document.getElementById("openOnlineModalBtn").click();
             }						
		}
		
		

		 function showcreditcustaddModal()
			{
			   	document.getElementById('addstorecustnameContId').value='';
				document.getElementById('addstorecustcontactContId').value='';
				document.getElementById('addstorecustaddressContId').value='';
				document.getElementById('addstorecustemailContId').value='';
				document.getElementById('addstorecustcrlimitContId').value='';
				document.getElementById('addstorecustalertMsg').innerHTML='';
				$('#creditcustAddModal').modal('show');
			}
		 function closecreditcustaddModal()
			{
				$('#creditcustAddModal').modal('hide');
			}
		 function showalertcatdataopModal()
			{
				$('#alertcatdataopModal').modal('show');
			}
		 
		/*  function openRemarksModal(){
				//document.getElementById('orderRemarksData').value="";
				document.getElementById('orderRemarksData').value = document.getElementById('orderRmks').value;
				document.getElementById('rmkalert').innerHTML ="";
				$('#remarksModal').modal('show');
			}
			function clearRemark(){
				document.getElementById('orderRemarksData').value  = "";
			} */
	</script>
	
	 <script type="text/javascript">
	 $('#advtblbooklistsearchModal').on('show.bs.modal', function() {
		setTimeout(function(){
		$('#calendar').fullCalendar('render');
		},300);
		}) 
		
	</script> 
</body>
</html>

