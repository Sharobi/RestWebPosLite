<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
    <title>:. POS :: Credit Sale :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   
   <style type="text/css">
    .selected{
    background-color: #373737 !important;
    }
    </style>
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>  
           
           <div class="col-md-10 col-sm-10">
                <div class="col-md-5 col-sm-5">
                <c:if test="${sessionScope.loggedinStore.id ==87}">
                <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.staffExpenditure" text="STAFF EXPENDITURE" /></div> 
                </c:if>
                <c:if test="${sessionScope.loggedinStore.id !=87}">
                      <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.creditSale" text="CREDIT SALES" /></div> 
                </c:if>
                </div>
                <div class="col-md-7 col-sm-7">
                 <c:if test="${sessionScope.loggedinStore.id !=87}">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.custName" text="CUSTOMER NAME" /> <span id="creditcustnameContId" style="color:#00CC33; ">${storeCustDetail.name}</span> <spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" /><span id="creditcustcontactContId" style="color:#00CC33;">${storeCustDetail.contactNo}</span></div>
                   </c:if> 
                   <c:if test="${sessionScope.loggedinStore.id ==87}">
                <div style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.creditsale.jsp.staffName" text="STAFF NAME" /><span id="creditcustnameContId" style="color:#00CC33; ">${storeCustDetail.name}</span> <spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" /> <span id="creditcustcontactContId" style="color:#00CC33;">${storeCustDetail.contactNo}</span></div>
                </c:if>
                    <input type="hidden" id="creditcustidContId" value="${storeCustDetail.id}"> 
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div class="col-md-5 col-sm-5">
                  <div style="max-height: 500px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover" id="creditcustomertableContId">
                                    <thead style="background:#404040; color:#FFF;">
                                    <c:if test="${sessionScope.loggedinStore.id !=87}">
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custName" text="CUST. NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custPh" text="CUST. CONTACT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.custAddr" text="CUST. ADDRESS" /></th>
                                            </c:if>
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                             <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffName" text="STAFF NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffPh" text="STAFF CONTACT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.creditsale.jsp.staffAddr" text="STAFF ADDRESS" /></th>
                                            </c:if>
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty creditcustList }">
                                    		<c:forEach items="${creditcustList}" var="creditcust">
                                    			<tr style="background:#404040; color:#FFF;cursor:pointer;" onclick="javascript:getcreditOrderBycustId(${creditcust.id},&quot;${creditcust.name}&quot;,&quot;${creditcust.contactNo}&quot;)">
                                    				<td>${creditcust.name}</td>
                                    				<td align="center">${creditcust.contactNo}</td>
                                    				<td>${creditcust.address}</td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty creditcustList}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="3"><spring:message code="admin.creditsale.jsp.noDataFound" text="No Data found!" /></td>
                                        	</tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </div>
                    </div>
                    <div class="col-md-7 col-sm-7">
                    	<div style="max-height: 500px;overflow-y:auto; ">
                    		<div class="panel panel-default">
                        		<div class="panel-body">
                            		<div class="table-responsive" style="background:#404040;" id="creditordertableContId">
                                		<table class="table table-striped table-bordered table-hover">
                                    		<thead style="background:#404040; color:#FFF;">
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.date" text="DATE" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.billAmt" text="BILL AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.dueAmt" text="DUE AMT" /></th>
                                            	<th style="text-align:center;"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></th>
                                    		</thead>
                                    		<tbody>
                                    		<c:if test="${! empty creditOrderList }">
                                    			<c:set var="totBillAmt" value="0.0"></c:set>
                                    			<c:set var="totDiscAmt" value="0.0"></c:set>
                                    			<c:set var="totPaidAmt" value="0.0"></c:set>
                                    			<c:forEach items="${creditOrderList}" var="creditorder">
                                    				<tr style="background:#404040; color:#FFF;">
                                    					<%-- <td align="center">${creditorder.id}</td> --%>
                                    					<td align="center">${creditorder.orderNo}</td>
                                    					<td align="center">${fn:substring(creditorder.orderTime, 0, 10)}</td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.orderBill.grossAmt}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.paidAmt}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditorder.orderBill.grossAmt-creditorder.paidAmt}"/></td>
                                    					<td align="center"><a href="javascript:opencr_saleCashModal(${creditorder.id},'${creditorder.table_no}',${creditorder.orderBill.grossAmt},${creditorder.paidAmt},${creditorder.orderNo})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.cash" text="CASH" /></a>&nbsp;<a href="javascript:opencr_saleCardModal(${creditorder.id},'${creditorder.table_no}',${creditorder.orderBill.grossAmt},${creditorder.paidAmt},${creditorder.orderNo})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.card" text="CARD" /></a></td>
                                    				</tr>
                                    				<c:set var="totBillAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt+creditorder.orderBill.grossAmt}"/></c:set>
                                    				<c:set var="totDiscAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totDiscAmt+creditorder.orderBill.customerDiscount}"/></c:set>
                                    				<c:set var="totPaidAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt+creditorder.paidAmt}"/></c:set>
                                    			</c:forEach>
                                    			<c:if test="${creditOrderList.size()>1}">
                                    			<tr style="background:#e2e2e2; color:#222222;">
                                    				<td colspan="2" align="center"><spring:message code="admin.creditsale.jsp.total" text="TOTAL" /></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt-totPaidAmt}"/></td>
                                    				<td align="center"><a href="javascript:opentotcr_saleCashModal(${totBillAmt},${totPaidAmt})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.cash" text="CASH" /></a>&nbsp;<a href="javascript:opentotcr_saleCardModal(${totBillAmt},${totPaidAmt})" class="btn btn-success"><spring:message code="admin.creditsale.jsp.card" text="CARD" /></a></td>
                                    			</tr>
                                    			</c:if>
                                    		</c:if>
                                        	<c:if test="${empty creditOrderList}">
                                        		<tr style="background:#404040; color:#FFF;">
                                        			<td colspan="6"><spring:message code="admin.creditsale.jsp.noDataFound" text="No Data found!" /></td>
                                        		</tr>
                                        	</c:if>
                                    		</tbody>
                                		</table>
                            		</div>
                            		<div style="background-color: black;" class="hide" id="waitimage" align="center">
											<img alt="" src="${pageContext.request.contextPath}/assets/images/wait/wait.gif" height="150" width="150">
									</div>
                        		</div>
                    		</div>
                    	</div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>
                	
            </div>
           <!-- modal starts -->
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
								style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="inventorynew.jsp.Success" text="Success" /></h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;"><spring:message code="admin.unpaidOrders.jsp.PaymentSuccessful" text="Payment Successfully Done!" /></div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								onclick="javascript:creditPaymentDone()"
								style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
						</div>
					</div>
				</div>
			</div>
           					<div class="modal fade" data-backdrop="static" id="cr_salecashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" /> <span id="cr_salecashmodOrderCont" style="display:none;">00</span>  <span id="cr_salecashmodStoreBasedOrderCont">00</span>
                                            <span style="float: right;"><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />: <span id="cr_salecashmodTabCont">00</span></span>
                                           
                                            </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecashtotamtcontId">0.00</span></div>
                                           		<!-- <div style="padding: 5px;">DISC. AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_salecashdiscamtcontId">0.00</span></div> -->
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cr_salecashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" /> :&nbsp;<input type="text" onkeyup="javascript:getcr_saleChangeAmt(this.value)"  value="" id="cr_salecashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.changeAmt" text="CHANGE AMOUNT" /> :&nbsp;<span id="cr_salecashchangeamtcontId">0.00</span> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="cr_salepaycashalertMsg"></div>
                                            </div>
                                           
										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:cr_salepayByCash(document.getElementById('cr_salecashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="cr_salecardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <spring:message code="admin.creditsale.jsp.orderNo" text="ORDER NO" />: <span id="cr_salecardmodOrderCont" style="display:none;">00</span>  <span id="cr_salecardmodStoreBasedOrderCont">00</span>
                                            <span style="float: right;"><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />: <span id="cr_salecardmodTabCont">00</span></span>
                                           
                                            </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="cr_salecardtotamtcontId">0.00</span></div>
                                           		<!-- <div style="padding: 5px;">DISC. AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_salecarddiscamtcontId">0.00</span></div> -->
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cr_salecardpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY " />: &nbsp;&nbsp;&nbsp;<span id="cr_salecardamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" />&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" id="cr_salecardtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.cardLast4Digit" text="CARD LAST 4 DIGIT" /> :&nbsp;<input type="text" id="cr_salecardlastfourDigit" style="text-align:center; color: #222222" size="4"/> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="cr_salepaycardalertMsg"></div>
                                            </div>
                                           
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:cr_salepayByCard(document.getElementById('cr_salecardtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          
                          <div class="modal fade" data-backdrop="static" id="totcr_salecashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                           <c:if test="${sessionScope.loggedinStore.id ==87}">
                                           <spring:message code="admin.creditsale.jsp.cont_one" text="Staff expense Bulk Payment By Cash" />
                                           </c:if>
                                           <c:if test="${sessionScope.loggedinStore.id !=87}">
                                           <spring:message code="admin.creditsale.jsp.cont_two" text="Credit Sale Bulk Payment By Cash" />
                                           </c:if>
                                            
                                          </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecashtotamtcontId">0.00</span></div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="totcr_salecashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" /> :&nbsp;<input type="text" onkeyup="javascript:gettotcr_saleChangeAmt(this.value)"  value="" id="totcr_salecashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.changeAmt" text="CHANGE AMOUNT" /> :&nbsp;<span id="totcr_salecashchangeamtcontId">0.00</span> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="totcr_salepaycashalertMsg"></div>
                                            </div>
                                           
										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" /></button>
                                           <button type="button" onclick="javascript:totcr_salepayByCash(document.getElementById('totcr_salecashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><span id="totcashpaySpinner" style="display: none;"><i class="fa fa-spinner fa-spin"></i></span>&nbsp;<spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="totcr_salecardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <c:if test="${sessionScope.loggedinStore.id ==87}">
                                           <spring:message code="admin.creditsale.jsp.cont_three" text="Staff expense Bulk Payment By Card" />
                                           </c:if>
                                           <c:if test="${sessionScope.loggedinStore.id !=87}">
                                           <spring:message code="admin.creditsale.jsp.cont_four" text="Credit Sale Bulk Payment By Card" />
                                           </c:if>
                                            </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.totalAmt" text="TOTAL AMOUNT" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecardtotamtcontId">0.00</span></div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.paidAmt" text="PAID AMOUNT" /> :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="totcr_salecardpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.amtToPay" text="AMOUNT TO PAY" /> :&nbsp;&nbsp;&nbsp;<span id="totcr_salecardamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;"><spring:message code="admin.creditsale.jsp.tndAmt" text="TENDER AMOUNT" />&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" id="totcr_salecardtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;"><spring:message code="admin.creditsale.jsp.cardLast4Digit" text="CARD LAST 4 DIGIT" /> :&nbsp;<input type="text" id="totcr_salecardlastfourDigit" style="text-align:center; color: #222222" size="4"/> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="totcr_salepaycardalertMsg"></div>
                                            </div>
                                           
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.creditsale.jsp.cancel" text="CANCELD" /></button>
                                           <button type="button" onclick="javascript:totcr_salepayByCard(document.getElementById('totcr_salecardtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><span id="totcardpaySpinner" style="display: none;"><i class="fa fa-spinner fa-spin"></i></span>&nbsp;<spring:message code="admin.creditsale.jsp.pay" text="PAY" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
           <!-- modal ends -->
           
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
  	<script src="${pageContext.request.contextPath}/assets/js/datatable/jquery.dataTables.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datatable/dataTables.bootstrap.js"></script>

   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   var language = '<%= session.getAttribute("language") %>';
   
    $('#creditcustomertableContId tbody tr').on('click',function(e){
	  $(this).closest('table').find('td').removeClass('selected');
		$(this).find('td').addClass('selected');
		//e.stopPropagation();
	});
    function showcr_saleCashModal()
	{
		//alert('order');
		$('#cr_salecashModal').modal('show');
	}
	function showcr_saleCardModal()
	{
		//alert('order');
		$('#cr_salecardModal').modal('show');
	}
	 function showalertOrderPaidModal()
		{
			$('#alertOrderPaidModal').modal('show');
		}
	function hidecr_saleCashModal()
	{
		//alert('order');
		$('#cr_salecashModal').modal('hide');
	}
	function hidecr_saleCardModal()
	{
		//alert('order');
		$('#cr_salecardModal').modal('hide');
	}
	//for total
	function showtotcr_saleCashModal()
	{
		//alert('order');
		$('#totcr_salecashModal').modal('show');
	}
	function showtotcr_saleCardModal()
	{
		//alert('order');
		$('#totcr_salecardModal').modal('show');
	}
	function hidetotcr_saleCashModal()
	{
		//alert('order');
		$('#totcr_salecashModal').modal('hide');
	}
	function hidetotcr_saleCardModal()
	{
		//alert('order');
		$('#totcr_salecardModal').modal('hide');
	}
	
	$(document).ready(function() {
		$('#creditcustomertableContId').DataTable( {
		        paging:true,
		        "info": false,
		    });
		});

   </script>
  
</body>
</html>
