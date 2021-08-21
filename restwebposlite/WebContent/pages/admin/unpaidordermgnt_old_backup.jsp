<%@page import="com.sharobi.webpos.util.CommonResource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![end if]-->
        
    <title>:. POS :: Unpaid Orders :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    <link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
    
    <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/numerickey.js"></script> --%>
    
   <style type="text/css">
   
   	 .selected{
    	background-color: #373737 !important;
     }
    /*   */
 
    </style>
    
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>
<body>
	<c:set var="today" value="<%=new java.util.Date()%>" /> 
	
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
    	<div class="container-fluid">
        	<div class="row">
           		<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include> 
           			<div class="col-md-10 col-sm-10">
						<div class="col-md-12 col-sm-12" align="center">
                    		<span style="color:#FFF; font-size:16px; font-weight:bold;">Select Date For Unpaid Orders</span>&nbsp;&nbsp;
                    	<c:if test="${!empty fromdate}">
                        <span style="color:#FFF; font-size:16px; font-weight:bold;">From Date :</span>
                       <input type="text" id="fromdateunpaidorderList" size="10" value="${fromdate}" />" 
                       <c:set var="fromSpecificDate" value="${fromdate}" />
                      </c:if>
                  
                      <c:if test="${!empty todate}">
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">To Date :</span>
                       <input type="text" id="todateunpaidorderList" size="10" value="${todate}" />" 
                       <c:set var="toSpecificDate" value="${todate}" />
                      </c:if>
                      <c:if test="${empty fromdate}"> 
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">From Date :</span> 
                       <input type="text" id="fromdateunpaidorderList" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">  
                       <c:set var="fromSpecificDate" value="${today}" />
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">To Date :</span>
                       <input type="text" id="todateunpaidorderList" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">  
                       <c:set var="toSpecificDate" value="${today}" />
                      </c:if>
                    			<input type="hidden" id="hiddenunpaidorderList" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                    		
                    		
                    		
                   			<a href="javascript:showunpaidOrdersListPeriodWise(document.getElementById('fromdateunpaidorderList').value,document.getElementById('todateunpaidorderList').value,${sessionScope.loggedinUser.storeId})" class="btn btn-success" style="background:#FE2E64;margin-bottom: 3px;">SUBMIT</a> 
                		</div>
                		<div class="col-md-12 col-sm-12">
                  			<div id="daytimewiseunpaidorderContainerId">
                   				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="overflow-y:auto;height:750px;"> 
            						<c:if test="${! empty allunpaidOrderList}">
            							<div class="panel-group" id="accordion">		
                        					<c:forEach items="${allunpaidOrderList}" var="unpaidOrders" varStatus="stat">
                        						<div class="panel panel-default" id="${unpaidOrders.id}" style="background-color:#ccd1ce;">
                    								<div class="panel-heading" style="margin-bottom: 8px;color:#000;background-color: #ccd1ce;">
                         								<h4 class="panel-title" style="width: inherit;">
                         								<c:if test = "${unpaidOrders.customerName == ''}">
                              								<a style="display:block;width: inherit;" data-toggle="collapse" data-parent="#accordion" href="#collapse--${unpaidOrders.id}">Order No : ${unpaidOrders.orderNo}</a>
                            							</c:if>
                            							<c:if test = "${unpaidOrders.customerName != '' && unpaidOrders.customerName!='null'}" >
                              								<a style="display:block;width: inherit;" data-toggle="collapse" data-parent="#accordion" href="#collapse--${unpaidOrders.id}">Order No : ${unpaidOrders.orderNo} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Customer Name : ${unpaidOrders.customerName}</center></a>
                            							</c:if>
                            							</h4>
                    								</div>
                    								<div id="collapse--${unpaidOrders.id}" class="panel-collapse collapse">
                        								<div class="panel-body">
                        									<div style="overflow-y:auto;">
																<div class="panel panel-default">
																	<div class="panel-body" style="max-height:500px;">
																		<div class="table-responsive" id="unpaidordertableContId">
																			<table class="table table-striped table-bordered">
																				<thead>
    																				<th>SL</th>
        																			<th>NAME</th>
        																			<th style="text-align:center;">QUANTITY</th>
        																			<th style="text-align:center;">TOTAL</th>
        																			<th style="text-align:center;">DISCNT</th>
        																			<th style="text-align:center;">RATE</th>
    																			</thead>
    																			<tbody>
    																				<c:if test="${! empty allunpaidOrderList}">
    																				 <c:set var="presentOrderID" value="${unpaidOrders.id}" />
    																					<c:forEach items="${allunpaidOrderList}" var="unpaidOrder">
    																				 		<c:set var="iteratingOrderID" value="${unpaidOrder.id}" />
    				 																		<c:if test = "${presentOrderID == iteratingOrderID}">
    																							<c:forEach items="${unpaidOrder.orderitem}" var="orderitems" varStatus="stat">
    																								<tr>
        																								<td>${stat.index+1}</td>
            																							<td>${orderitems.item.name}</td>
            																							<td valign="middle" align="center" style="padding: 1px;">${orderitems.quantityOfItem}</td>
            																							<td style="text-align:center;" id="tdtotal${orderitems.id}">
            																								<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.price*orderitems.quantityOfItem}"></fmt:formatNumber>
            																							</td>
            																							<td style="text-align:center;" id="tddisc${orderitems.id}">
            																								<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
            																									<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${(orderitems.item.price*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
            																								</c:if>
            																								<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">0.00</c:if>
            																							</td>
            																							<td style="text-align:center;">
            																								<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.item.price}"></fmt:formatNumber>
            																							</td>
            																						</tr>
       					 																		</c:forEach>
       					 																	</c:if>
       					 																</c:forEach>
       					 															</c:if>     					
        																		</tbody>
																			</table>
																			
																			<!--///////////////////////////////////  -->
																			
																			
																		<c:set var="staticVat" value="14.5"></c:set>
																		<c:set var="staticST" value="5.6"></c:set>
																		<c:set var="netPrice" value="0.00"></c:set>
																		<c:set var="paidAmount" value="0.00"></c:set>
																		<c:set var="custDisc" value="0.00"></c:set>
																		<c:set var="custDiscPerc" value="0.00"></c:set>
																		<c:set var="totDisc" value="0.00"></c:set>
																		<c:set var="totVat" value="0.00"></c:set>
																		<c:set var="totST" value="0.00"></c:set>
																		<c:set var="serviceCharge" value="0.00"></c:set>
																		<c:set var="totRate" value="0.00"></c:set>

																		<c:set var="subtotalWithOutTax" value="0.00"></c:set>
																		<c:set var="subtotalWithTax" value="0.00"></c:set>
																		<c:set var="orderVat"
																			value="${sessionScope.loggedinStore.vatAmt}"></c:set>
																		<c:set var="orderSTax"
																			value="${sessionScope.loggedinStore.serviceTaxAmt}"></c:set>

																		<c:set var="totPrice" value="0.00"></c:set>
																		<c:set var="netTotal" value="0.00"></c:set>
																		<c:set var="totnonspotDiscAmt" value="0.00"></c:set>
																		<c:set var="schrg" value="0.00"></c:set>
																		<c:set var="menucatlength" value="0"></c:set>
																		<c:if test="${! empty allunpaidOrderList}">
																			<c:forEach items="${allunpaidOrderList}"
																				var="unpaidOrder">

																				<c:set var="iteratingOrderID"
																					value="${unpaidOrder.id}" />
																				<c:if test="${presentOrderID == iteratingOrderID}">

																					<c:set var="iteratingOrderTypeServcharge"
																						value="${unpaidOrder.ordertype.serviceChargeValue}"></c:set>

																					<c:forEach items="${unpaidOrder.orderitem}"
																						var="orditems" varStatus="stat">
																						<c:set var="totDisc1" value="0.00"></c:set>

																						<c:set var="totVat1" value="0.00"></c:set>
																						<c:set var="totST1" value="0.00"></c:set>
																						<c:set var="totnonspotDiscAmt1" value="0.00"></c:set>

																						<%-- <c:set var="totVat1" value="0.00"></c:set>
																							<c:set var="totST1" value="0.00"></c:set> --%>
																						<c:if
																							test="${fn:containsIgnoreCase(orditems.item.promotionFlag, 'Y') }">
																							<c:set var="totDisc1">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${orditems.quantityOfItem*(orditems.item.price*orditems.item.promotionValue/100)}" />
																							</c:set>
																						</c:if>
																						<c:if
																							test="${fn:containsIgnoreCase(orditems.item.spotDiscount, 'N') }">
																							<c:set var="totnonspotDiscAmt1"> ${totnonspotDiscAmt1+(orditems.quantityOfItem*orditems.item.price)}</c:set>
																						</c:if>
																						<%-- <c:set var="totVat1">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totVat1+(orditems.quantityOfItem*orditems.item.price+serviceCharge-totDisc1)*orditems.item.vat/100}" />
																							</c:set>
																							<c:set var="totST1">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totST1+(orditems.quantityOfItem*orditems.item.price+serviceCharge-totDisc1)*orditems.item.serviceTax/100}" />
																							</c:set> --%>
																						<c:set var="table_no"
																							value="${unpaidOrder.table_no}"></c:set>

																						<c:set var="totVat1">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2"
																								value="${totVat1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*orditems.item.vat/100}" />
																						</c:set>
																						<%-- <c:set var="totST1"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totST1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*orditems.item.serviceTax/100}"/></c:set> --%>
																						<c:set var="totST1">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2"
																								value="${totST1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*orditems.item.serviceTax/100}" />
																						</c:set>
																						<c:if
																							test="${sessionScope.loggedinStore.id==35 && table_no!='0' && orditems.item.vat==0.00}">
																							<c:set var="totVat1">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${totVat1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticVat/100}" />
																							</c:set>
																						</c:if>
																						<c:if
																							test="${sessionScope.loggedinStore.id==35 && table_no!='0' && orditems.item.serviceTax==0.00}">
																							<c:set var="totST1">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${totST1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticST/100}" />
																							</c:set>
																						</c:if>
																						<%-- <c:if test="${sessionScope.loggedinStore.id==35 && table_no!='0' && orditems.item.vat==0.00}">
																							<c:set var="totVat1">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totVat1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticVat/100}" />
																							</c:set>
																							</c:if>
																							<c:if test="${sessionScope.loggedinStore.id==35 && table_no!='0' && orditems.item.serviceTax==0.00}">
																								<c:set var="totST1">
																									<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totST1+(orditems.quantityOfItem*orditems.item.price-totDisc1)*staticST/100}" />
																								</c:set>
																							</c:if> --%>
																						<c:set var="totRate">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2"
																								value="${totRate+orditems.quantityOfItem*orditems.item.price-totDisc1}" />
																						</c:set>
																						<c:set var="totDisc">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2"
																								value="${totDisc+totDisc1}" />
																						</c:set>

																						<c:if
																							test="${orditems.item.vat==0.00 && orditems.item.serviceTax==0.00}">
																							<c:set var="subtotalWithOutTax">${subtotalWithOutTax+((orditems.quantityOfItem*orditems.item.price)-totDisc1)}</c:set>
																						</c:if>
																						<c:if
																							test="${orditems.item.vat!=0.00 || orditems.item.serviceTax!=0.00}">
																							<c:set var="orderVat">${orditems.item.vat}</c:set>
																							<c:set var="orderSTax">${orditems.item.serviceTax}</c:set>
																							<c:set var="subtotalWithTax">${subtotalWithTax+((orditems.quantityOfItem*orditems.item.price)-totDisc1)}</c:set>
																						</c:if>

																						<c:set var="totVat">${totVat+totVat1}</c:set>
																						<c:set var="totST">${totST+totST1}</c:set>
																						<c:set var="totnonspotDiscAmt">${totnonspotDiscAmt+totnonspotDiscAmt1}</c:set>
																						<%-- <c:set var="totVat">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totVat+totVat1}" />
																							</c:set>
																							<c:set var="totST">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totST+totST1}" />
																							</c:set> --%>
																					</c:forEach>

																					<%--
																				 <c:set var="custDisc" value="${custDisc+unpaidOrders.orderBill.customerDiscount}"></c:set>
																				 <c:if test="${custDisc!=0.0}">
                			    																	<c:set var="totRate">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totRate-custDisc}" />
																							</c:set>
                			    																</c:if>
                			    															 --%>


																					<%-- <c:if
																							test="${sessionScope.loggedinStore.serviceChargeRate!=0.0}">
                			    															<c:set var="serviceCharge"> <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${(serviceCharge+totRate)*sessionScope.loggedinStore.serviceChargeRate/100}"/></c:set>
                			    														</c:if>
                			    												 --%>
                			    												 <c:if test="${unpaidOrder.orderBill.customerDiscount!=0.0}">
																		<c:set var="custDisc"
																						value="${custDisc+unpaidOrder.orderBill.customerDiscount}"></c:set>
																				</c:if>

																				<c:if test="${subtotalWithOutTax>custDisc}">
																					<c:set var="subtotalWithTax">${totRate-subtotalWithOutTax}</c:set>
																				</c:if>
																				<c:if test="${subtotalWithOutTax<=custDisc}">
																					<c:set var="subtotalWithTax">${totRate-custDisc}</c:set>
																				</c:if>

																				<c:if
																					test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orderVat==0.00}">
																					<c:set var="totVat">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" minFractionDigits="2"
																							maxFractionDigits="2"
																							value="${subtotalWithTax*staticVat/100}" />
																					</c:set>
																				</c:if>
																				<c:if
																					test="${sessionScope.loggedinStore.id!=35 && orderVat!=0.00}">
																					<c:set var="totVat">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" minFractionDigits="2"
																							maxFractionDigits="2"
																							value="${subtotalWithTax*orderVat/100}" />
																					</c:set>
																				</c:if>
																				<c:if
																					test="${sessionScope.loggedinStore.id==35 && currentTable!='0' && orderSTax==0.00}">
																					<c:set var="totST">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" minFractionDigits="2"
																							maxFractionDigits="2"
																							value="${subtotalWithTax*staticST/100}" />
																					</c:set>
																				</c:if>
																				<c:if
																					test="${sessionScope.loggedinStore.id!=35 && orderVat!=0.00}">
																					<c:set var="totST">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" minFractionDigits="2"
																							maxFractionDigits="2"
																							value="${subtotalWithTax*orderSTax/100}" />
																					</c:set>
																				</c:if>

																				<c:if
																						test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
																						<c:if test="${iteratingOrderTypeServcharge!=0.0}">
																							<c:set var="serviceCharge">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${totRate*iteratingOrderTypeServcharge/100}" />
																							</c:set>
																							<c:set var="totVat">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${totVat+totVat * iteratingOrderTypeServcharge/100}" />
																							</c:set>
																							<c:set var="totST">
																								<fmt:formatNumber type="number"
																									groupingUsed="false" minFractionDigits="2"
																									maxFractionDigits="2"
																									value="${totST+totST * iteratingOrderTypeServcharge/100}" />
																							</c:set>
																						</c:if>
																					</c:if>

																					<c:set var="totnonspotDiscAmt">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" minFractionDigits="2"
																							maxFractionDigits="2"
																							value="${totnonspotDiscAmt}" />
																					</c:set>
																					<%-- <c:if
																				test="${fn:containsIgnoreCase(unpaidOrder.isDiscountAdded, 'Y') }"> --%>
																				<%-- 	<c:set var="custDisc"
																						value="${custDisc+unpaidOrder.orderBill.customerDiscount}"></c:set> --%>
																					<%-- </c:if> --%>
																					<c:set var="totRate">
																						<fmt:formatNumber type="number"
																							groupingUsed="false" maxFractionDigits="2"
																							value="${totRate-custDisc}" />
																					</c:set>
																					<c:if
																						test="${table_no=='0' && sessionScope.loggedinStore.parcelServiceTax=='N'}">
																						<c:set var="totST" value="0.00"></c:set>
																					</c:if>

																					<c:if
																						test="${table_no=='0' && sessionScope.loggedinStore.parcelVat=='N'}">
																						<c:set var="totVat" value="0.00"></c:set>
																					</c:if>

																					<c:set var="paidAmount"
																						value="${paidAmount+orders.paidAmt}"></c:set>
																					<c:set var="totPrice"
																						value="${totRate+serviceCharge+totVat+totST}"></c:set>
																					<c:set var="netPrice"
																						value="${totPrice-(paidAmount)}"></c:set>
																					<c:set var="netTotal" value="${totPrice}"></c:set>

																					<%-- <c:forEach items="${unpaidOrder.orderitem}" var="orditems" varStatus="stat">
																				  <c:set var="totVat">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totVat + (orditems.rate + ((orditems.rate*10)/100))*orditems.vat/100}" />
																							</c:set>
																							</c:forEach>
																							 <c:set var="totST">
																								<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${(totRate+serviceCharge)*unpaidOrders.orderitem[0].serviceTax/100}" />
																							</c:set>

																						 <c:if test="${table_no=='0' && fn:containsIgnoreCase(sessionScope.loggedinStore.parcelServiceTax,'N')}">
																								<c:set var="totST" value="0.00"></c:set>
																							</c:if>
																							<c:if test="${table_no=='0' && fn:containsIgnoreCase(sessionScope.loggedinStore.parcelVat,'N')}">
																								<c:set var="totVat" value="0.00"></c:set>
																							</c:if>



																						<c:set var="paidAmount" value="${paidAmount+unpaidOrders.paidAmt}"></c:set>
																						<c:set var="totPrice" value="${totRate+totVat+totST+serviceCharge}"></c:set>
																						<c:set var="clearedPrice" value="${paidAmount}"></c:set>
																							<c:set var="netPrice" value="${totPrice-clearedPrice}"></c:set>
																							<c:set var="netTotal" value="${totPrice-custDisc}"></c:set> --%>
																					<c:if
																						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
																						<c:set var="netTotal">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2"
																								value="${netTotal +0.5 - ((netTotal+0.5) % 1) }" />
																						</c:set>
																					</c:if>
																					<c:if
																						test="${fn:containsIgnoreCase(sessionScope.loggedinStore.doubleRoundOff, 'Y') }">
																						<%-- <c:set var="netTotal"><fmt:formatNumber type="number" groupingUsed="false"  minFractionDigits="2"   maxFractionDigits="2" value="${netTotal +0.05 - ((netTotal+0.05) % .1) }"/></c:set> --%>
																						<c:set var="netTotal">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2" value="${netTotal}" />
																						</c:set>
																						<c:set var="netTotal">
																							<dd:ddformatter place="1" number="${netTotal}"></dd:ddformatter>
																						</c:set>
																						<c:set var="netTotal">
																							<fmt:formatNumber type="number"
																								groupingUsed="false" minFractionDigits="2"
																								maxFractionDigits="2" value="${netTotal}" />
																						</c:set>
																					</c:if>

																		  <%--  <input type="hidden" id="unpaidorderid_${unpaidOrders.id}" value="${unpaidOrders.id}">
                                                                           <input type="hidden" id="unpaidorderdiscpercntg_${unpaidOrders.id}" value="${unpaidOrders.orderBill.discountPercentage}">
                                                                           <input type="hidden" id="unpaidorderdiscamt_${unpaidOrders.id}"   value="${unpaidOrders.orderBill.customerDiscount}">
                                                                           <input type="hidden" id="unpaidordersubtotal_${unpaidOrders.id}"  value="${totRate}">
                                                                           <input type="hidden" id="unpaidorderscharge_${unpaidOrders.id}"   value="${serviceCharge}">
                                                                           <input type="hidden" id="unpaidordervattax_${unpaidOrders.id}"    value="${totVat}">
                                                                           <input type="hidden" id="unpaidorderstax_${unpaidOrders.id}"      value="${totST}">
                                                                            <input type="hidden" id="unpaidorderstrbaseorderno_${unpaidOrders.id}"      value="${unpaidOrders.orderNo}">
 --%>
																				</c:if>
																			</c:forEach>
																		</c:if>
																			
																			
																			<!--//////////////////////////////////  -->
																			
																			
																			
																			
																			
																			
																										
							
							
							
							
							
																				
																				
				<!-- 02-08-2017 -->																
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
							type="hidden" id="printbillpapersize"
							value="${sessionScope.loggedinStore.printBillPaperSize}">	
																				
																			
																				
																				
																				
																			
																			<div class="col-md-6 col-sm-6"> <!-- style="padding-left: 80px !important;" -->
																				<a href="javascript:openCashModal(${totPrice},${netPrice},${netTotal})" class="btn-order-taking" style="text-align: center; width: 30%; ">
																					<span class="fa fa-usd"></span>&nbsp;CASH </a> 
																				<a href="javascript:openCardModal(${totPrice},${netPrice},${netTotal})" class="btn-order-taking" style="text-align: center; width: 30%;">
																					<span class="fa fa-credit-card"></span>&nbsp;CARD </a> 
																				<a href="javascript:openOnlineModal(${totPrice},${netPrice},${netTotal})" class="btn-order-taking" style="text-align: center; width: 30%;">ONLINE </a>
																				<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
																					<a href="javascript:openCreditSaleModal()" class="btn-order-taking" style="text-align: center; width: 0%; display: none;">&nbsp;CREDIT SALE </a>
																				</c:if>
																			</div>
																			
																			<div class="col-md-6 col-sm-6">
																				<div class="order-summery" style="color:#000000;background-color: #FFFFFF;">
																					<c:if test="${unpaidOrders.orderBill.discountPercentage!=0.00}">
																						<div id="discPerContId" class="col-md-6 col-sm-3">Discount ${unpaidOrders.orderBill.discountPercentage}%:</div>
																						<div id="discBtnContId" style="float: right; height: 20px;">
																							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${unpaidOrders.orderBill.customerDiscount}" />
																						</div>
																						<br />
																					</c:if>
																					<div class="col-md-6 col-sm-6">SubTotal:</div>
																					<div id="subtotalcontId" style="float: right; font-weight: bold;">${totRate}</div>
																					<br />
																					
																					
                    														<%-- 	<c:if test="${sessionScope.loggedinStore.serviceChargeText!=null}">
                    															<c:if test="${sessionScope.matchedOrderType.serviceChargeValue!=0.0}">
                    															
                    															 <div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.serviceChargeText}							
                     															 <c:if
                       																test="${sessionScope.loggedinStore.serviceChargeRate!=0.0}">
                                     													 (${sessionScope.loggedinStore.serviceChargeRate}%)
                                     											</c:if>
                      																	:
                     															</div>
                     															<div id="schrgId" style="float: right; font-weight: bold;">${serviceCharge}</div>
                     															
                     															<br/>
                   																 </c:if> --%>
                   																 
                   																 <c:if
                     test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                     <c:if
                     test="${iteratingOrderTypeServcharge!=0.0}">
                     <div class="col-md-6 col-sm-6">S.Charge
                     
                                       (${iteratingOrderTypeServcharge}%)
                                       
                       :
                      </div>
                      <div id="schrgId" style="float: right; font-weight: bold;">${serviceCharge}</div>
                      <br />
                      </c:if>
                     
                    </c:if>
                   																 
                   																 
                   																 
                   																 
                   																 
                   																 
                   																 
                   																 
                   																 
																					<%-- <c:if test="${sessionScope.loggedinStore.vatTaxText.length()!=0} "> --%>
																						<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.vatTaxText}
																							<c:if test="${sessionScope.loggedinStore.id!=53 }">
																								<c:if test="${sessionScope.loggedinStore.vatAmt!=0.0}">
                			    																	(${sessionScope.loggedinStore.vatAmt}%)
                			    																</c:if>:
                			 																</c:if>
																						</div>
																						<div id="vatcontId" style="float: right; font-weight: bold;">${totVat}</div>
																						<br />
																					<%-- </c:if> --%>
																					<c:if test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
																						<div class="col-md-6 col-sm-6">${sessionScope.loggedinStore.serviceTaxText}
																							<c:if test="${sessionScope.loggedinStore.id!=53}">
																								<c:if test="${sessionScope.loggedinStore.serviceTaxAmt!=0.0}">
                			     																	(${sessionScope.loggedinStore.serviceTaxAmt}%)
                			    																</c:if>:
                			  																</c:if>
																						</div>
																						<div id="servicetaxcontId" style="float: right; font-weight: bold;">${totST}</div>
																						<br />
																					</c:if>
																					<div class="col-md-6 col-sm-3">
																						<strong>Total(${sessionScope.loggedinStore.currency}):</strong>
																					</div>
																					<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
																						<div id="grandtotalcontId" style="float: right; font-weight: bold;">
																						<%-- <c:set var="totPrice" value="${document.getElementById('subtotalcontId').innerHTML}"></c:set> --%>
																						
																							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPrice +0.5 - ((totPrice+0.5) % 1) }" />
																						</div>
																					</c:if>
																					<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
																						<div id="grandtotalcontId" style="float: right; font-weight: bold;">
																						<%-- <c:set var="totPrice" value="${document.getElementById('subtotalcontId').innerHTML}"></c:set> --%>
																							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPrice}" />
																						</div>
																					</c:if>
																					<br />
																					<div class="col-md-6 col-sm-6">
																						<strong>Amt.ToPay:</strong>
																					</div>
																					<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'Y') }">
																						<div id="amttopaycontId" style="float: right; font-weight: bold; background: #fff;">
																							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${netPrice +0.5 - ((netPrice+0.5) % 1) }" />
																						</div>
																					</c:if>
																					<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.roundOffTotalAmtStatus, 'N') }">
																						<div id="amttopaycontId" style="float: right; font-weight: bold; background: #fff;">
																							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${netPrice}" />
																						</div>
																						<br />
																					</c:if>																					
																				</div>
																			</div>
																		</div>
																	</div>
																</div>	
															</div> 
                										</div>
                									</div>
                								</div> 
                							</c:forEach>
                						</div>	
                					</c:if> 
        						</div> 
                  			</div> 
               			</div>
           		</div>
           		
           		<input type="hidden" id="hidstoreroundoffFlag"
							value="${sessionScope.loggedinStore.roundOffTotalAmtStatus}">
				<input type="hidden" id="hidstoredoubleroundoffFlag"
							value="${sessionScope.loggedinStore.doubleRoundOff}">
				<input type="hidden" id="hidnetTotal" value="${netTotal}"> 
				<input type="hidden" id="mobPrintVal1" value="${sessionScope.loggedinStore.mobBillPrint}">
				<input type="hidden" id="printbillpapersize1" value="${sessionScope.loggedinStore.printBillPaperSize}">
           <!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="alertunpaidorderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Given from date is greater than to date!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:showCurrntDateUnpaidOrders()" style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
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
								ORDER NO: <span id="cashmodOrderCont" class="hide">00</span>
								 <span id="cashmodStoreBasedOrderCont">00</span>
								 <span class="hide" style="float: right;">TABLE NO: <span
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
									TENDER AMOUNT :&nbsp;<span id="cashtenderAmt">0.00</span>
									<!-- <input type="text"
										 value=""
										id="cashtenderAmt" style="text-align: center; color: #222222"
										size="4" readonly/> -->
										<!-- onkeyup="javascript:getChangeAmt(this.value)" -->
								</div>
								<!-- <div style="padding: 5px; display: none;">
									CHANGE AMOUNT :&nbsp;<span id="cashchangeamtcontId">0.00</span>
								</div>
 -->								<div
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
							<%-- 	<c:if test="${fn:containsIgnoreCase(sessionScope.loggedinStore.softKey, 'Y') }">
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
 --%>							</div>

						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button"
								onclick="javascript:payByCash(document.getElementById('cashtenderAmt').innerHTML)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">PAY</button>
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
								<span id="cardmodStoreBasedOrderCont">00</span>
								 <span class="hide" style="float: right;">TABLE NO: <span
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
									TENDER AMOUNT&nbsp;&nbsp;&nbsp; :&nbsp;<span id="cardtenderAmt">0.00</span>
									<!-- <input type="text"
										id="cardtenderAmt" style="text-align: center; color: #222222"
										size="4" /> -->
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
								<div style="padding: 5px;">
									CARD LAST 4 DIGIT :&nbsp;<input type="text"
										id="cardlastfourDigit"
										style="text-align: center; color: #222222" size="4" />
								</div>


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
							<%-- 	<c:if
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
												data-theme="done" class="btn btn-success btn-lg"
												id="done_cr">DONE</a></td>
										</tr>
									</table>
								</c:if> --%>
							</div>
					<%-- 		<div align="center" style="font-size: 20px;">
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

						</div> --%>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button"
								onclick="javascript:payByCard(document.getElementById('cardtenderAmt').innerHTML)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">PAY</button>
						</div>
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
								<span id="onlinemodStoreBasedOrderCont">00</span>
								<span class="hide" style="float: right;">TABLE NO: <span
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
									TENDER AMOUNT&nbsp;&nbsp;&nbsp; :&nbsp;<span id="onlinetenderAmt">0.00</span>
									<!-- <input type="text"
										id="onlinetenderAmt" style="text-align: center; color: #222222"
										size="4" /> -->
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
						
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="width: 25%; background: #F60; font-weight: bold;"
								class="btn btn-warning" data-dismiss="modal">CANCEL</button>
							<button type="button"
								onclick="javascript:payByOnline(document.getElementById('onlinetenderAmt').innerHTML)"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">PAY</button>
						</div>
						</div>
					</div>
				</div>
			</div>
			
		<!-- 	<div class="modal fade" data-backdrop="static" id="paymodeselectionModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Payment Mode</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;" id="paymodeselectiondiv"></div>
							<div style="text-align: center; font-size: 20px;" id="paymodeselectiontext"></div>
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
			
			<div class="modal fade" data-backdrop="static" id="notavailableonlinepaymentModal"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
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
							<div style="text-align: center; font-size: 20px;" >No online payment mode available.</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							
							<button type="button"
								style="background: #72BB4F; font-weight: bold;"
								data-dismiss="modal" class="btn btn-success" >OK</button>
						</div>
					</div>
				</div>
			</div> -->
			
			<div class="modal fade" data-backdrop="static" id="paymodeselectionModal"
    tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true" style="display: none;">
    <div class="modal-dialog" style="margin: 100px auto;">
     <div class="modal-content"
      style="border: 3px solid #ffffff; border-radius: 0px;">
      <div class="modal-header"
       style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

       <h4 class="modal-title"
        style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="order.jsp.paymentmode" text="PAYMENT MODE" /></h4>
      </div>
      <div class="modal-body"
       style="background: #404040; border-top: 1px solid #404040; color: #fff;">
       <div style="text-align: center; font-size: 20px;" id="paymodeselectiondiv"></div>
       <div style="text-align: center; font-size: 20px;" id="paymodeselectiontext"></div>
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
   
   <div class="modal fade" data-backdrop="static" id="notavailableonlinepaymentModal"
    tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true" style="display: none;">
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
       <div style="text-align: center; font-size: 20px;" ><spring:message code="order.jsp.noonlinepaymentmode" text="No online payment mode available." /></div>
      </div>
      <div class="modal-footer"
       style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
       
       <button type="button"
        style="background: #72BB4F; font-weight: bold;"
        data-dismiss="modal" class="btn btn-success" >OK</button>
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

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								ORDER NO: <span id="creditsalemodOrderCont">00</span> <span
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
										style="margin-bottom: 2px; color: #222222;" /> OR Contact No:
									<input type="text" value="" id="creditsalecustcontact"
										size="14" style="margin-bottom: 2px; color: #222222;" />
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
							<button type="button" onclick="javascript:payCreditSale();"
								id="creditsalepayButton" disabled="disabled"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">PAY</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static"
				id="alertOrderPaidModal" tabindex="-1" role="dialog"
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
							<div style="text-align: center; font-size: 20px;">Payment Successfully Done!</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="javascript:paymentDone()"
								style="width: 25%; background: #72BB4F; font-weight: bold;"
								class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" data-backdrop="static"
			id="alertpaidModal" tabindex="-1" role="dialog"
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
						<div style="text-align: center; font-size: 20px;">Payment Already Done for This Item!</div>
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
			
			
			
<!-- =========================================== printDiv2100(For GST) ===================================================== -->

	 		<%--  <div class="modal fade" data-backdrop="static"
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
								style="font-size: 17px; font-style: normal; font-family: sans-serif;">${sessionScope.loggedinStore.address} </font></b>

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
										<b>${sessionScope.loggedinStore.gstText} :</b> ${sessionScope.loggedinStore.gstRegNo}
									</div>
									<br> <br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
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
								</div>
							</div>							

							<div style="float: left; margin-bottom: 5%;" id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;">SNo</th>
											<th width="30%;">Item Name</th>
											<th>HSN</th>&nbsp;
											<th>SAC</th>
											<th width="6%;">Qty</th>
											<th width="6%;">Unit</th>
											<th width="5%;">Rate</th>
											<th width="5%;">Total</th>
											<th width="5%;">Disc</th>
											<th width="10%;">Taxable Value</th>
											<th width="18%;" colspan="2">&nbsp;CGST&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;SGST&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;IGST&nbsp;
											</th>
										</tr>
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
												Invoice Value (In figure) :</span></b></td>
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
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 5%"></span>
									</td>

								</tr>
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
								
								
								
							</table>
						</div>

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
					</div>
				</div>
			</div> --%>
			
			
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
									<br> <br>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Details of Receiver</b>
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
								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;">SNo</th>
											<th width="30%;">Item Name</th>
											<th>HSN/&nbsp;</th> 
                                            <th>SAC</th>
											<th width="6%;">Qty</th>
											<th width="6%;">Unit</th>
											<th width="5%;">Rate</th>
											<th width="5%;">Total</th>
											<th width="5%;">Disc</th>
											<th width="10%;">Taxable Value</th>
											<th width="18%;" colspan="2">&nbsp;CGST&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;SGST&nbsp;
											</th>
											<th width="18%;" colspan="2">&nbsp;IGST&nbsp;
											</th>
										</tr>
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
											<th width="5%;">Rate</th>
											<th width="10%;">Amt.</th>
											<th width="5%;">Rate</th>
											<th width="10%;">Amt.></th>
											<th width="5%;">Rate</th>
											<th width="10%;">Amt.</th>
										</tr>
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
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 60%" id="cashIGST2100_gst"></span></td>

								</tr>							
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
								
								
							</table>
						</div>

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
								<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashtotalamt80">00</span></td>
						</tr>
						<tr id="cashshowDiscount80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								TOTAL DISCOUNT (<span id="paidbilldiscpers80"></span>%):</td>
								<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
								id="cashdiscountValue80">00</span></td>
						</tr>
						<tr id="cashtotalServiceCharge80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								Service Charge:</td>
								<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;">
								<span id="cashservChrg80">00</span>
							</td>
						</tr>

						<tr id="cashtotalServiceTax80px">
							<td
								style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
								<!-- Total Service Tax -->
								<%-- ${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%): --%>
								<c:choose>
		                              <c:when test="${sessionScope.loggedinStore.id==164}">
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
		                              <c:when test="${sessionScope.loggedinStore.id==164}">
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
	
			
			<!-- *******  PRINT IN 2100 ********* -->
			
			
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
											type="number" value=""
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
			
			
			
			
			<!-- ************    END    ************    -->	
           <!-- modal ends -->
       </div>
     </div>
     </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <script
		src="${pageContext.request.contextPath}/assets/js/json/json-min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/json/yahoo-min.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script type="text/javascript">
  // alert('hello');
   var BASE_URL="${pageContext.request.contextPath}";
   var currentId=null;
   var printpaidBill="${sessionScope.loggedinStore.printPaidBill}";
   var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
   var loggedinStore="${sessionScope.loggedinStore.id}";
   var roundOffTotalAmtStatus="${sessionScope.loggedinStore.roundOffTotalAmtStatus}";
   var parcelServiceTax="${sessionScope.loggedinStore.parcelServiceTax}";
   var parcelVat="${sessionScope.loggedinStore.parcelVat}";
   var vfdPort="${sessionScope.loggedinStore.customerDisplay}";
   var cdrawerCode="${sessionScope.loggedinStore.cashDrawerCode}";
   var softKey="${sessionScope.loggedinStore.softKey}";
   var storeId="${sessionScope.loggedinUser.storeId}";
   var specificDate="${specificDate}";
   var storeID="${sessionScope.loggedinStore.id}";
   var storeAddr = "${sessionScope.loggedinStore.address}";
  
	
   $(document).ready(function() {

		$('#fromdateunpaidorderList').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate : '0'
		});	
		$('#todateunpaidorderList').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate : '0'
		});	
	});
   function showalertunpaidorderModal()
	{
	  	$('#alertunpaidorderModal').modal('show');
	}
   function showalertOrderPaidModal()
	{
		$('#alertOrderPaidModal').modal('show');
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
	function showPaidModal()
	{
		//alertpaidModal
		$('#alertpaidModal').modal('show');

	}
	function hidePaidModal(){
		$('#alertpaidModal').modal('hide');

	}
	$('.panel').on('show.bs.collapse', function (e) {
	    console.log('Collapse Alert' + e.currentTarget.id);
	    currentId=e.currentTarget.id;
	})
	
	function showCurrntDateUnpaidOrders()
	{
		
		var todaydate=document.getElementById('hiddenunpaidorderList').value;

		//document.getElementById('fromdateunpaidorderList').value=todaydate;
		 // document.getElementById('todateunpaidorderList').value=todaydate;
		  location.href=BASE_URL+'/unpaidorderlist/unpaidorderspecificdate.htm?storeId='+storeId+'&fromdate='+todaydate+'&todate='+todaydate;
	}
		
   </script>
   </body>
</html>