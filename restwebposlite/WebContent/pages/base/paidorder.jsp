<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>:. POS :: Paid Order :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
<style type="text/css">
.selected {
	background-color: #373737 !important;
}

</style>

<script>
	function rowClicked() {
		alert("Table row clicked");
	}
</script>
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="background-color: #e9e9e9;">
	<%-- 	<c:set var="today" value="<%=new java.util.Date()%>" /> --%>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">

			<div class="row">
				<div class="col-md-12 col-sm-12">
					<form modelAttribute="order"
						action="${pageContext.request.contextPath }/order/viewallpaidorderbydate.htm"
						method="post">
						<span style="font-size: 16px; font-weight: bold;">Select
							Date For view Order Details</span>&nbsp;&nbsp; <input type="text"
							id="daywiseorderdetails" name="orderDate" size="10"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						<input type="hidden" id="hiddaywiseorderdetails"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						<input type="submit" value="Submit" class="btn btn-primary">
					</form>
				</div>
				<br />
				<br />
				<div class="col-md-12 col-sm-12">
					<div overflow-y:auto; padding: 2px;">
						<div class="panel panel-default">
							<div class="panel-body" style="max-height: 500px;">
								<div style="padding: 3px;">
									<div class="table-responsive" id="paidordertableContId">
										<table class="table table-striped table-bordered"
											id="ordertableId">
											<thead>
												<th style="text-align: center;">SL NO</th>
												<th style="text-align: center;">ORDER NO</th>
												<th style="text-align: center;">ORDER AMT</th>
												<th class="hide" style="text-align: center;">TABLE NO</th>
												<th style="text-align: center;">CUSTOMER INFO</th>
												<th style="text-align: center;">ORDER DATE</th>
												<th style="text-align: center;">ACTION</th>

											</thead>
											<tbody>
												<c:if test="${ empty allpaidOrderList}">
													<tr style="cursor: pointer;">
														<td style="text-align: center;" colspan="6">No Orders
															found.</td>
													</tr>

												</c:if>
												<c:if test="${! empty allpaidOrderList}">
													<c:forEach items="${allpaidOrderList}" var="paidOrders"
														varStatus="stat">
														<tr style="cursor: pointer;">
															<td style="text-align: center;">${stat.index+1}</td>
															<td style="text-align: center;">${paidOrders.orderNo}</td>
															<c:if test="${sessionScope.loggedinStore.id!=120}">
															<td style="text-align: center;"><fmt:formatNumber
																	type="number" maxFractionDigits="2"
																	minFractionDigits="2"
																	value="${paidOrders.orderBill.grossAmt}"></fmt:formatNumber></td>
															</c:if>
															<c:if test="${sessionScope.loggedinStore.id==120}">
																<c:set var="itemTOT" value="0.00" />
																<c:set var="packTOT" value="0.00" />
																<c:forEach items="${paidOrders.orderitem}" var="orderitems" varStatus="stat">
																	<c:choose>
																		<c:when test="${fn:containsIgnoreCase(orderitems.item.packaged, 'Y')}">
																			<c:set var="packTOT" value="${packTOT+orderitems.netPrice}"></c:set>
																		</c:when>
																		<c:otherwise>
																			<c:set var="itemTOT" value="${itemTOT+orderitems.netPrice}"></c:set>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
																<td style="text-align: center;">
																<fmt:formatNumber
																	type="number" maxFractionDigits="2"
																	minFractionDigits="2"
																	value="${itemTOT +0.5 - ((itemTOT+0.5) % 1) }"></fmt:formatNumber>
																</td>
															</c:if>
															<td class="hide" style="text-align: center;"><c:choose>
																	<c:when test="${paidOrders.ordertype.id==2}">
                                				PARCEL
                                			</c:when>
																	<c:when test="${paidOrders.ordertype.id==1}">
                                			HOME DELIVERY
                                			</c:when>
																	<c:otherwise>
                                				${paidOrders.table_no}
                                			</c:otherwise>
																</c:choose></td>
															<td style="text-align:center">
															 <a href="javascript:showCustomerDetails(&quot;${paidOrders.customerName}&quot;,&quot;${paidOrders.customerContact}&quot;,&quot;${paidOrders.deliveryAddress}&quot;)">${paidOrders.customerName}</a>
															 </td>
															<td style="text-align: center;">${paidOrders.orderTime}</td>
															<td align="center">
															<c:if test="${sessionScope.loggedinStore.id==47}">
								                                     <a href="javascript:printPaidBillForCorporateCustomer(${paidOrders.id})"
																       class="btn btn-success" style="text-align: center;  margin-top: 2px;">
																       <span class="fa fa-print"></span>&nbsp;CORPORATE CUSTOMER</a>
															</c:if> 
															<c:choose>
																	<c:when test="${paidOrders.refundStatus=='F'}">
																	<a href="javascript:printRefundBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-print"></span>&nbsp;<spring:message code="paidorder.jsp.REFUNDPRINT" text="REFUND PRINT" /> </a>
                                									</c:when>
																	<c:otherwise>
                                									<a href="javascript:printPaidBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 50%; margin-top: 2px;"><span class="fa fa-print"></span>&nbsp;<spring:message code="paidorder.jsp.PRINT" text="PRINT" /> </a>
                                									</c:otherwise>
															</c:choose>
								                        </td>
														</tr>
													</c:forEach>
												</c:if>

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
					</div>

				</div>


			</div>

			<div class="modal fade" data-backdrop="static" id="customermodel"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">Customer
								Details</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div align="center" style="font-size: 20px;">
								<table>
									<tbody>
										<tr id="cust_name" style="display: none">
											<td style="padding: 5px 0px;">Customer Name </td>
											<td width="5%">:</td>
											<td id="custName"></td>
										</tr>
										<tr id="cust_ph" style="display: none">
											<td style="padding: 5px 0px;">Customer Phone </td>
											<td width="5%">:</td>
											<td id="custPh"></td>
										</tr>
										<tr id="del_addr" style="display: none">
											<td style="padding: 5px 0px;">Delivery Address </td>
											<td width="5%">:</td>
											<td id="delAddr"></td>
										</tr>
										
										<tr id="notFoundCustomer" style="display: none">
											<td style="padding: 5px 0px;">No Customer Found</td>
											
										</tr>

									</tbody>
								</table>
								<div
									style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
									id="addalertMsg"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								class="btn btn-success" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>

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

			<!-- modal starts -->
			<div class="modal fade" data-backdrop="static"
				id="paidbillPrintSuccessModal" tabindex="-1" role="dialog"
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
							<div style="text-align: left; font-size: 11px; font-family: sans-serif;"
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
										<!-- Service Charge -->
										${sessionScope.loggedinStore.serviceChargeText}:</td>
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
							<button type="button"
								onclick="javascript:printCashOrCardLocal80()"
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

									<tbody style="color: #000000; padding: 1px"
										; id="itemDetailsPrint58"></tbody>

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
						<button type="button"
							onclick="javascript:printCashOrCardLocal58()"
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
								style="font-size: 15px; text-align: center; width: auto; font-style: inherit; font-family: sans-serif;"><div
									id="storeEmail2100"></div></font> <font
								style="font-size: 15px; text-align: center; width: auto; font-style: normal; font-family: sans-serif;"><div
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
									<%-- <c:if test="${sessionScope.loggedinStore.id == 120}">
							           <div style="text-align: left; font-size: 15px; font-family: sans-serif;">
								        <b>FSSAI:</b> ${sessionScope.loggedinStore.dataSource} 
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

							<div style="float: left; margin-bottom: 5%;" id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse;">
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
								<c:if test="${sessionScope.loggedinStore.id!=168}">		
								<tr id="totalServiceTax_2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;"><span
										style="padding-left: 52%" id="cashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%" id="cashservTax2100_gst">00</span>
										<span style="padding-left: 60%" id="cashIGST2100_gst"></span><!--new  -->
									</td>

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
										<span style="padding-left: 60%" id="cashIGST2100_gst"></span><!--new  -->
									</td>

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
          
           <!-- ///////////////////////////////////////////////////////////////////////////////// ///////// -->
            <!--Modal for refunded order bill print start  -->


                 <!--Bill print modals start  -->
			<div class="modal fade" data-backdrop="static" id="refundhelloPrintModal58"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="width: 200px; height: auto;">


					<div class="modal-body" id="refundprintDiv58"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<div
							style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">


							<%-- <div style="text-align: center; width: 230px;">
								<input type="image"	src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
							</div> --%>


							<b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							    <div id="refundstoreName58">${sessionScope.loggedinStore.storeName}</div></font></b> <b>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							   <div id="refundstoreAddr58">${sessionScope.loggedinStore.address}</div></font></b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							   <div id="refundstoreEmail58"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							    <div id="refundstorePhNo58"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>
								<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							    <spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						       </div> <br>

							<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="refundstoreEmail58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b> <div id="refundstorePhNo58"></div>
							</div> --%>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="refundorderValue58" style="font-weight:bold">00</span>
							</div>
                              <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Date :</b><span id="refundcashOrderdate58">00</span>
							</div>
                           <%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="refundorderType_58px">${orders.ordertype.orderTypeName}</span>
							</div> --%>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="refundshowtableno">
										 <b><span id="refundtableNoValue58">00</span></b>
							</div>

							<div class="table-responsive" id="refundorderitemContId_58">

								<table
									style="color: #000000; border: none; height: 50px; width: 130px;">

									<thead>

										<th style="font-size: 10px; width: 30px;"><span
											style="float: left; font-family: sans-serif;"><spring:message
													code="order.jsp.Items" text="Items" /></span></th>
										<th
											style="text-align: center; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Qty" text="Qty" /></th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Rate" text="Rate" /></th>
										<th
											style="text-align: right; font-size: 10px; font-family: sans-serif;"><spring:message
												code="order.jsp.Total" text="Total" /></th>

									</thead>

									<tbody style="color: #000000; padding: 1px;"
										id="refunditemDetailsPrint58"></tbody>

								</table>

							</div>

							<div style="text-align: right; width: 150px;">--------------------</div>

							<table style="height: 50px; width: 150px;">

								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" />:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id=refundtotalAmt58>00</span></td>
								</tr>
								<tr id="refundtotalServiceChrg_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate}%):
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundservChrg58">00</span></td>
								</tr>

								<tr id="refundtotalServiceTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundservTax58">00</span></td>
								</tr>

								<tr id="refundtotalVatTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundvatTax58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundgrossAmount58">00</span></b></td>
								</tr>
								<tr id="refundshowDiscount_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refunddiscountValue58">00</span></td>
								</tr>
								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundamoutToPay58">00</span></b></td>
								</tr>
								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>



								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundpaidAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundtenderAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundrefundAmount58">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundorderrefundAmount58">00</span></b></td>
								</tr>


								<tr>
									<td style="text-align: right;">---------------------------</td>
									<td></td>
								</tr>
							</table>
							<div style="text-align: left; width: 150px;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><div
											id="refundpayType58"></div></font></b>
							</div>
							<div style="text-align: left; width: 150px;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.ThankYouVisitAgain"
										text="**Thank You. Visit Again" /></font>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="refundremovePrint58"
						style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
						<button type="button"
							onclick="javascript:refundprintCashOrCardLocal58()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success" id="refundprintBtn_58">
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
			<!-- modal end -->
			
			
			<div class="modal fade" data-backdrop="static"
				id="refundcashhelloPrintModal80" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: auto;">

					<div class="modal-body" id="refundprintDiv80"
						style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">

						<%-- <div style="text-align: center; width: 230px;">
								<input type="image"
									src="${pageContext.request.contextPath}/assets/images/billlogo/storelogo.png">
						</div> --%>

						<div
							style="text-align: center; width: 230px; font-size: 20px; color: #000000">

							<b><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							<div id="refundstoreName80">${sessionScope.loggedinStore.storeName}</div></font></b>
							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="refundstoreAddr80">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
								<div id="refundstoreEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
								<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="refundstorePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>

							<%-- <div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="refundstoreEmail80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="refundstorePhNo80"></div>
							</div> --%>

							<div id="refundpaidgstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							<spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						    </div> 
						<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="refundcashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" /> --%>
										<b>Date :</b> <span  id="refundcashOrderdate80">00<%-- <fmt:formatDate
												pattern="yyyy-MM-dd" value="${parsedInvDate}" /> --%></span>
									</div>

							<%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="refundorderType_80px">${orders.ordertype.orderTypeName}</span>
							</div> --%>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="refundshowtableno80px">
								<%-- <spring:message code="order.jsp.TableNo" text="Table No:" /> --%>
								<b><span id="refundcashtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="refundorderitemContId_80">
								<table
									style="color: #000000; border: none; height: 50px; width: 100%;">

									<thead>
										<tr>
											<th style="font-size: 11px; width: 102px;"><span
												style="float: left; font-family: sans-serif;"><spring:message
														code="order.jsp.Items" text="Items" /></span></th>
											<th
												style="text-align: center; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.Qty" text="Qty" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.RATE" text="RATE" /></th>
											<th
												style="text-align: right; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.TOTAL" text="TOTAL" /></th>
										</tr>
									</thead>

									<tbody style="color: #000000; padding: 1px;"
										id="refunditemDetailsPrint80"></tbody>

								</table>
							</div>

							<div style="text-align: center;">--------------------------------</div>

							<table style="height: 50px; width: 100%;" id="orderAmtDetails">

								<tr>
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;"><spring:message
											code="order.jsp.TOTALAMOUNT" text="TOTAL AMOUNT" /> :</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundcashtotalamt80">00</span></td>
								</tr>
								<tr id="refundcashshowDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> (<span id="refundpaidbilldiscpers"></span>%) :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="refundcashdiscountValue80">00</span></td>
								</tr>
								<tr id="refundcashtotalServiceCharge80px" class="refundserviceCharge80px" style="display:none;">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}<span id="refundcashservChrgDisc80">00</span>:
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<span id="refundcashservChrg80">00</span>
									</td>
								</tr>

								<tr id="refundcashtotalServiceTax80px">
								   <td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
									  <c:choose>
		                                <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                  ${sessionScope.loggedinStore.serviceTaxText}:
		                               </c:when>
		      						   <c:otherwise>
		   								${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%):
		  							  </c:otherwise>
								     </c:choose>
									</td>
									<td style="text-align: right; font-size: 11px; font-family: sans-serif;">
									  <span id="refundcashservTax80">00</span>
									</td>
								</tr>

								<tr id="refundcashtotalVatTax80px">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<c:choose>
		                                  <c:when test="${sessionScope.loggedinStore.id==164 || sessionScope.loggedinStore.id==120 || sessionScope.loggedinStore.id==149 || sessionScope.loggedinStore.id==47}">
		                                     ${sessionScope.loggedinStore.vatTaxText}:
		                                  </c:when>
		      						      <c:otherwise>
		   								    ${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):
		  							      </c:otherwise>
								       </c:choose>
									</td>
									<td style="text-align: right; font-size: 11px; font-family: sans-serif;">
									<span id="refundcashvatTax80px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundcashgrossAmount80">00</span></b></td>
								</tr>

								

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundcashamoutToPay80">00</span></b></td>
								</tr>

								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.paid_amount" text="Paid Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundpaidAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundtenderAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundrefundAmount80">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundorderrefundAmount80">00</span></b></td>
								</tr>


								<tr>
									<td style="text-align: center;">---------------------------</td>
									<td></td>
								</tr>
                                 <tr id="refundcusnametr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Name:</td>
									<td id="refundcusname80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
								 <tr id="refundcusphnotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Ph No:</td>
									<td id="refundcusphno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                  <tr id="refundcusaddresstr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Address:</td>
									<td id="refundcusaddress80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                   <tr id="refundcuslocationtr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Location:</td>
									<td id="refundcuslocation80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                  <tr id="refundcusstreettr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Street:</td>
									<td id="refundcusstreet80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>
                                   <tr id="refundcushousenotr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >House No:</td>
									<td id="refundcushouseno80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>

                                   <tr id="refunddeliveryboytr80" style="display:none;">
									<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;" >Dlv By:</td>
									<td id="refunddeliveryboy80" style="font-size: 11px; font-weight: bold; font-family: sans-serif;"></td>
								</tr>

							</table>
							<div style="text-align: center;">
								<b><font style="font-size: 12px; font-family: sans-serif;"><span
										id="refundpayType80"></span></font></b>
							</div>
							<div style="text-align: center;">
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.**Thank You. Visit Again"
										text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="refundcashRemovePrint80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:refundprintCashOrCardLocal80()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="refundprintBtn_80">
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
  
  <div class="modal fade" data-backdrop="static"
				id="refundcashhelloPrintModal2100_GST" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="width: 276px; height: 450px;">


					<div class="modal-body" id="refundprintDiv2100GST"
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
								<b>Refund Invoice </b>
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
										<b>Details of Receiver</b>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Name :</b><span id="refundcashCustName_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b> <span id="refundcashCustAddr_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b> <span id="refundcashCustPhone2100_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>State :</b><span id="refundcashCustState_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>GSTIN/Unique Id :</b><span id="refundcashCustGSTIN_GST"></span>
									</div>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6" style="float: right;">
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Order No / Invoice :</b> <span id="refundcashOrdervalue2100_GST">00</span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Date :</b> <span id="refundcashOrderDate_GST"></span>
									</div>
								<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b><span id="refundcashtableNoValue2100">00</span></b>
							   </div>

								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="refundorderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse; border-bottom: 1px dashed;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" /></th>&nbsp;
											<th><spring:message code="purinvdet.jsp.batch"
													text="SAC" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Qty" /></th>
											<th width="6%;"><spring:message
													code="purinvdet.jsp.expdt" text="Unit" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.pqty" text="Rate" /></th>
											<th width="5%;"><spring:message
													code="purinvdet.jsp.lqty" text="Total" /></th>
											<th width="5%;"><spring:message
													code="reprintcash.jsp.totqty" text="Disc" />(<span id="refundpaidbilldiscpers2100"></span>%)</th>
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}"> 
											<th width="5%;">${sessionScope.loggedinStore.serviceChargeText}</th> 
											</c:if>
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
											<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}"> 
											<td></td> 
											</c:if>
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
									<tbody id="refunditemDetailsPrint2100_GST">

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
											id="refundcashgrossAmount2100_gst">00</span></b></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Total
												Invoice Value (In Words):</span></b></td>
									<td width="100%"
										style="float: right; text-align: left; white-space: nowrap; font-size: 14px; font-family: sans-serif;"><span
										id="refundcashgrossAmount2100_word_gst"></span></td>
								</tr>
								<tr id="refundcashtotalServiceCharge2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">
										Total ${sessionScope.loggedinStore.serviceChargeText}:(<span id="refundcashservChrgPercentage2100">00</span>%)</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
										<b><span id="refundcashservChrg2100">00</span></b>
									</td>
								</tr>
								
								
								<tr id="refundcashtotalServiceTax2100px">
									<td
										style="font-size: 15px; font-weight: bold; font-family: sans-serif;">Amount
										of Tax subject to Reverse Charges :</td>
									<td style="font-size: 14px; font-family: sans-serif;">
									    <span style="padding-left: 52%;" id="refundcashvatTax2100px_gst">00</span>
										<span style="padding-left: 16%;" id="refundcashservTax2100_gst">00</span>
										<span style="padding-left: 60%" id="refundcashIGST2100_gst"></span>
									</td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;display:none;">
										<b><span id="refundcashTotalTaxAmount2100_gst">00</span></b>
									</td>

								</tr>
								<!-- new added 10.5.2018 start -->
								 <tr style="display:none;">
	                             <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundpaidAmount_paidbill_2100px">00</span></b></td>
								 </tr>


								 <tr style="display:none;">
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundamoutToPay_paidbill_2100px">00</span></b></td>
								 </tr>

                                 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund Amount:</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundrefundorderamount2100px">00</span></b></td>
								 </tr>
                                  <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									   <b><span id="refundpaymentmode_paidbill_2100px"></span></b></td>
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

   <!--Modal for refunded order bill print end  -->
          
         <!--++++++++++++++++++++++++++++++++++++Corporate Bill Start (2100) +++++++++++++++++++++++++++++++++++++++++++++++++++ -->
			          
	     <div class="modal fade" data-backdrop="static"
			   id="corporateBillModal2100_GST" tabindex="-1" role="dialog"
			   aria-labelledby="myModalLabel" aria-hidden="true"
			   style="display: none;"> 
			   <div class="modal-dialog">
			      <div class="modal-body" id="printDivCorporate" style="margin-right: 65px; margin-left: 65px;">
						<style type="text/css">
						 .txtallign{
						  vertical-align: top;
						  text-align: left;
						}
						.tableclass{
						  border-collapse: collapse;
						}
						
						.tableclass, .tableclass th, .tableclass td{
						  border: 1px solid black;
						}
						
						.tableclass tr.noBorder td{
						  border-bottom: 0;
						  border-top: 0;
						}
						
						.tableclass tr.topBorder td{
						  border-top: 0 ;
						} 
						
						.taxbrktbl{
						   width:100%;
						   border-collapse: collapse;
						   border : none;
						   
						}
					    .taxbrktbl td{
							border: 1px solid black;
						}
				
						.taxbrktbl tr:first-child td{
							border-top: none;
						}
				
						.taxbrktbl tr:last-child td{
							border-bottom: 1px solid black;
						}
				
						.taxbrktbl tr td:first-child{
							border-left: none;
						}
				
						.taxbrktbl tr td:last-child{
							border-right: none;
						}
						
						
					 </style>
					   <div style="text-align: center; margin-top: 30px;">
			            <font style="font-size: 16px; font-family: sans-serif; color: black;">
			             Tax Invoice
			            </font>
			         </div>
			         <table style="width:100%" class="tableclass">
			            <tr>
			               <td rowspan = "3" width="250" class="txtallign" id="corporatebill_sellerInfo" style="font-size: 16px; font-family: sans-serif; color: black;">
			                
			               ${sessionScope.loggedinStore.storeName}<br>
			               ${sessionScope.loggedinStore.address}<br>
			               Email:${sessionScope.loggedinStore.emailId}<br>
			               Phone:${sessionScope.loggedinStore.mobileNo}<br>
			               ${sessionScope.loggedinStore.gstText} : ${sessionScope.loggedinStore.gstRegNo}
			               
			               </td>
			               <td height="30"><b>Invoice No</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="corporatebill_invNo"></span></td>
			               <td height="30"><b>Dated</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="corporatebill_invDate"></span></td>
			            </tr>
			            <tr>
			               <td height="30"><b>Delivery Note</b><span id="corporatebill_deliveryDate"></span></td>
			               <td height="30"><b>Payment Mode&nbsp;&nbsp;</b><span id="corporatebill_paymentMode"></span></td>
			            </tr>
			            <tr>
			               <td height="30"><b>Supplier's Ref.</b><span id="corporatebill_supplierRef"></span></td>
			               <td height="30"><b>Others Ref.</b><span id="corporatebill_otherRef"></span></td>
			            </tr>
			            <tr>
			               <td rowspan = "4" width="250" class="txtallign"><b> Buyer</b><br>
			               <span id="corporatebill_buyerInfo"></span>
			               <span id="corporatebill_buyerInfoName"></span><br>
			               <span id="corporatebill_buyerInfoContact"></span><br>
			               <span id="corporatebill_buyerInfoAddress"></span><br>
			               <span id="corporatebill_buyerInfoState"></span><br>
			               GSTIN:<span id="corporatebill_buyerInfoGSTIN"></span>
			               
			               
			               </td>
			               <td height="30"><b> Buyer Order No</b><span id="corporatebill_buyerOrderNo"></span></td>
			               <td height="30"><b>Dated</b><span id="corporatebill_orderDate"></span></td>
			            </tr>
			            <tr>
			               <td height="30"><b>Despatch Document No.</b><span id="corporatebill_dispatchDocNo"></span></td>
			               <td height="30"><b>Delivery Note Date</b><span id="corporatebill_deliveryNoteDate"></span></td>
			            </tr>
			            <tr>
			               <td height="30"><b>Despatched Through</b><span id="corporatebill_deliveryNoteDate"></span></td>
			               <td height="30"><b>Destination</b><span id="corporatebill_destination"></span></td>
			            </tr>
			            <tr>
			               <td height="50" colspan="2" class="txtallign"><b>Terms Of delivery</b><span id="corporatebill_termsOfDelivery"></span></td>
			            </tr>
			         </table>
			         <table style="width:100%"  class="tableclass">
			            <thead>
			               <tr>
			                  <th height="30" width="50" rowspan="2">SL No.</th>
			                  <th height="30" width="500" rowspan="2">Description Of Goods</th>
			                  <th height="30" rowspan="2">HSN/SAC</th>
			                  <th height="30" rowspan="2">Qty</th>
			                  <th height="30" width="100" rowspan="2">Rate</th>
			                  <th height="30" colspan="2">Tax %</th>
			                  <th height="30" rowspan="2">Disc %</th>
			                  <th height="30" rowspan="2">Amount</th>
			               </tr>
			                <tr>
			                  <td align="center">${sessionScope.loggedinStore.vatTaxText}</td>
			                  <td align="center">${sessionScope.loggedinStore.serviceTaxText}</td>
			               </tr>
			            </thead>
			            <tbody id="corporatebill_itemsData" style="height:0%">
			              
			            </tbody>
			            <tfoot>
			               <tr>
			                  <td height="30" width="50"></td>
			                  <td height="30" width="200" style="text-align:right;"><b>Total</b></td>
			                  <td height="30" style="text-align:right;"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_totItemQty"></td>
			                  <td height="30" style="text-align:right;"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_totTaxPercentageAmt" colspan="2"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_totDiscountPercentageAmt"></td>
			                  <td height="30" style="text-align:right;"id="corporatebill_totAmount"></td>
			               </tr>
			               <tr>
			                  <td height="30" colspan="9" class="txtallign"><b> Amount Chargeable(In Words) 
			                     </b><span id="corporatebill_totAmountInWords"></span>
			                  </td>
			               </tr>
			               <tr>
			               <td colspan="9">
			                  <table class="taxbrktbl" >
			                  <thead>
			                  <tr>
			                  <td colspan="3" align="center" rowspan="2">
			                     <b>HSN/SAC</b> 
			                  </td>
			                  <td  align="center" rowspan="2">
			                     <b>Taxable Value</b>
			                  </td>
			                  <td  colspan="2" align="center">
			                     <b>${sessionScope.loggedinStore.vatTaxText}</b><!--central  -->
			                  </td>
			                  <td colspan="2" align="center">
			                     <b>${sessionScope.loggedinStore.serviceTaxText}</b><!--state  -->
			                  </td>
			                  <td  align="center" rowspan="2"><b>Total</b></td>
			               </tr>
			               <tr>
			                  <td align="center">
			                     <b>Rate</b> 
			                  </td>
			                  <td align="center"><b>Amount</b></td>
			                  <td align="center">
			                     <b>Rate</b>
			                  </td>
			                  <td align="center">
			                     <b>Amount</b>
			                  </td>
			               </tr>
			               </thead>
			               <tbody id="corporatebill_itemWiseTaxBreaks">
			               
			               </tbody>
			               <tfoot>
			                 <tr>
			                  <td height="30" colspan="3" style="text-align:right;"><b>Total</b></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_taxableAmount"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_centralTaxRate"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_centralTaxAmount"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_StateTaxRate"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_StateTaxAmount"></td>
			                  <td height="30" style="text-align:right;" id="corporatebill_totTaxAmount"></td>
			               </tr>
			               </tfoot>
			               </table>
			               </td>
			               </tr>
			               <tr>
			                  <td colspan="9" height="80" class="txtallign"><b>Tax Amount(In Words)</b>
			                     <span id="corporatebill_totTaxAmountInWords"></span>
			                  </td>
			               </tr>
			               <tr>
			                  <td colspan="3" height="40" class="txtallign"><b>Company's PAN&nbsp;&nbsp;<span id="corporatebill_companyPAN"></span>
			                     <br>
			                     <u>Declaration</u></b><br>
			                     We declare that this invoice shows the actual price of the goods  
			                     described and that all particulars are true and correct.
			                  </td>
			                  <td colspan="6" height="40" 
			                     style="vertical-align:bottom;text-align:right;">
			                     <b>SIGNATORY<b/>
			                  </td>
			               </tr>
			            </tfoot>
			         </table>
			         <div style="text-align: center; margin-top: 30px;">
			            <font style="font-size: 16px; font-family: sans-serif; color: black;">
			            This is a Computer Generated Invoice
			            </font>
			         </div>
			      </div>
			   </div>
			 </div>
			          
            <!--Corporate Bill End -->

             
			<!-- ************    END    ************    -->	


				</div>
			</div>

			<!-- modal ends -->

		</div>
	</div>

	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/baseScript.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/paidrefundbillprint.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>

	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
		
		<%-- <script src="${pageContext.request.contextPath}/assets/js/table2excel.js"></script>  --%>
	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var storeID = "${sessionScope.loggedinStore.id}";
		var storeAddr = "${sessionScope.loggedinStore.address}";
		var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
		var sgst = "${sessionScope.loggedinStore.serviceTaxAmt}";
		var cgst = "${sessionScope.loggedinStore.vatAmt}";
		var gsttext = "${sessionScope.loggedinStore.gstText}";
		var gstno = "${sessionScope.loggedinStore.gstRegNo}";
	</script>
	<script type="text/javascript">
		$(document).ready(function() {

			$('#daywiseorderdetails').datepicker({
				format : "yyyy-mm-dd",
				autoclose : true
			});

		});
		function showPaidBillPrintSuccessModal() {
			$('#paidbillPrintSuccessModal').modal('show');
		}
	</script>

</body>
</html>
