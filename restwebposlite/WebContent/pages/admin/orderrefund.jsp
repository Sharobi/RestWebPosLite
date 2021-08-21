<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <title>:. POS :: Order Refund :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   <link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />



   <style type="text/css">
     .ui-autocomplete {
          overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
        }
     .modal:nth-of-type(even) {
           z-index: 1042 !important;
         }
     .modal-backdrop.in:nth-of-type(even) {
           z-index: 1041 !important;
         }
</style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
   <%--  <c:set var="today" value="<%=new java.util.Date()%>" /> --%>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

           <div class="col-md-10 col-sm-10">
				<div class="col-md-7 col-sm-7">
                          <form modelAttribute="order" action="${pageContext.request.contextPath }/order/viewallpaidorderbydateforrefund.htm" method="post">
						    <span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="paidorder.jsp.SelectDateForviewOrderDetails" text="Select Date For view Order Details" /></span>&nbsp;&nbsp; <input type="text" id="daywisepaidorderdetails" name="orderDate" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
						    <input type="submit" value="<spring:message code="paidorder.jsp.submit" text="Submit" />" class="btn btn-primary">
					     </form>

                </div>
                <div class="col-md-1 col-sm-1"><span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="order.jsp.OR" text="OR" /></span></div>
                <div class="col-md-4 col-sm-4">
                    	  <input type="text"  name="orderNumber" id="paidOrderId" size="10" placeholder="Order No" onkeydown='numcheck(event);'/>
                          <a href="javascript:showPaidorderDataForRefund()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="order.jsp.OK" text="OK" /></a>


                </div>


                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">

                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered" id="paidordertable" style="color: #FFF; border: 1px solid #222222;">
											<thead>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERNO" text="ORDER NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERAMT" text="ORDER AMT" /></th>
												<th style="text-align: center;"><spring:message code="unpaidorder.jsp.TABLENO" text="TABLE NO" /></th>
												<th style="text-align: center;"><spring:message code="paidorder.jsp.ORDERDATE" text="ORDER DATE" /></th>
												<th style="text-align: center;"><spring:message code="admin.jsp.REFUNDACTION" text="REFUND ACTION" /></th>

											</thead>
											<tbody style="color: #fff;" id="paidorderforrefundtbodyd">
												<c:if test="${ empty allpaidOrderList}">
												<tr style="background: #222222; cursor: pointer;">
												<td style="text-align: center;" colspan="6"><spring:message code="paidorder.jsp.NoOrdersfound" text="No Orders found" />.</td>
												</tr>

											</c:if>
												<c:if test="${! empty allpaidOrderList}">
													<c:forEach items="${allpaidOrderList}" var="paidOrders" varStatus="stat">
														<tr style="background: #222222; cursor: pointer;">
															<td style="text-align: center;">${stat.index+1}</td>
															<td style="text-align: center;">${paidOrders.orderNo}</td>
															<td style="text-align: center;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${paidOrders.orderBill.grossAmt}"></fmt:formatNumber></td>
															<td style="text-align: center;">
																<c:choose>
																	<c:when test="${paidOrders.table_no=='0'}">
																	${paidOrders.ordertype.orderTypeName}
                                									</c:when>
																	<c:otherwise>
                                									${paidOrders.table_no}
                                									</c:otherwise>
																</c:choose></td>
															<td style="text-align: center;">${paidOrders.orderTime}</td>



															<c:if test="${paidOrders.refundStatus=='N'}">
															<td align="center"><a href="javascript:openRefundModal(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 46%; margin-top: 2px;"><spring:message code="paidorder.jsp.REFUND" text="REFUND" /> </a></td>
														     </c:if>
														     <c:if test="${paidOrders.refundStatus=='C'}">
															<td align="center"><a href="javascript:openRefundApproveModal(${paidOrders.id},&quot;${paidOrders.ordertype.orderTypeName}&quot;,&quot;${paidOrders.table_no}&quot;)" class="btn btn-success" style="text-align: center; width: 46%; margin-top: 2px;"><spring:message code="paidorder.jsp.APPROVE" text="APPROVE" /> </a></td>
														     </c:if>
														    <c:if test="${paidOrders.refundStatus=='F' || paidOrders.refundStatus=='P'}">
															<td align="center">
															<a href="javascript:openRefundDetailsModal(${paidOrders.id},&quot;${paidOrders.ordertype.orderTypeName}&quot;,&quot;${paidOrders.table_no}&quot;)" class="btn btn-success" style="text-align: center; width: 46%; margin-top: 2px;"><spring:message code="paidorder.jsp.DETAILS" text="DETAILS" /> </a>
															<a href="javascript:printRefundBill(${paidOrders.id})" class="btn btn-success" style="text-align: center; width: 46%; margin-top: 2px;"><spring:message code="order.jsp.PRINT" text="PRINT" /> </a>
															</td>
														     </c:if>
															</tr>
													</c:forEach>
												</c:if>

											</tbody>
										</table>
                            </div>
                        </div>
                    </div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>

            </div>
            <!-- modals part starts -->
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


             <!-- refund modal starts -->
           					<div class="modal fade" data-backdrop="static" id="orderrefundmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto; width:60%;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.advtblbookingmgnt.jsp.refundorder" text="REFUND" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div>

								<div style="text-align:center;font-size: 15px;padding: 10px;" class="col-md-12 col-sm-12">
								<div class="col-md-12 col-sm-12">
								<table style="width:100%;">
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ORDERNO" text="ORDER NO" /></strong> </span>
								<span id="paidorderno" style="display:none;"></span><span id="storebasepaidorderno"></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.advtblbookingmgnt.jsp.date" text="DATE" />&nbsp;:</strong></span>
								<span id="paidorderdate"></span>
								</td>

								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />&nbsp;:</strong> </span>
								<span  id="paidordertbl"></span>
								</td>
								<td style="text-align:left;">
								<span id="paidordercustomerid" style="display:none;"></span>
								<span><strong><spring:message code="order.jsp.CUSTOMERNAME" text="CUSTOMER NAME" />&nbsp;:</strong></span>
								<span id="paidordercustomername"></span>
								</td>
								</tr>

								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" />&nbsp;: </strong></span>
								<span  id="paidordercustomercontactno" ></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ADDRESS" text="ADDRESS" />&nbsp;:</strong></span>
								<span  id="paidordercustomeraddress"></span>

								</td>
								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" />&nbsp;:</strong> </span>
								<span>
								<select id="returnreason"  style="margin-bottom: 2px;color: #222222;" onChange="setReturnReason(this.value);">
                                           <c:if test="${! empty reasons}">
                                                               <option value="0">Select Reason</option>
                                            					<c:forEach items="${reasons}" var="returnreason">
                                            						<option value="${returnreason.id}">${returnreason.remark}</option>
                                            					</c:forEach>
                                            					</c:if>

                                 </select>
								</span>
								</td>

								<td style="text-align:left;" colspan="2">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="REMARKS" /> &nbsp;:</strong></span>
								<span><input type="text" id="refundremark" value="" style="color:black;"></span>
								</td>


								</tr>
								<tr style="display:none;">
								<td>
								<span style="display:inline;" ><spring:message code="order.jsp.bill.DELIVERYBOY" text="order.jsp.bill.DELIVERYBOY" />&nbsp;: </span>
								<span style="display:inline;" id="paidorderdeliveryboy"></span>

								</td>

								<td>
								<span style="display:inline;" ><spring:message code="admin.tablenew.jsp.Waiter" text="WAITER" /> &nbsp;:</span>
								<span style="display:inline;" id="paidorderwaiter"></span>

								</td>
								</tr>
								</table>

								</div>
                             </div>
                              <!-- <div style="overflow-y: auto; padding: 2px;">
								<div class="panel panel-default"> -->
									<div  style="overflow-y: auto;height: 150px;padding: 1px;">
										<div  style="text-align: left;font-size: 15px;">
											<table class="table table-bordered" style="border: 1px solid white;" id="refundableitemtable">
											  <thead>
											    <th style="text-align: center;"><spring:message code="unpaidorder.jsp.Select" text="SELECT" /></th>
                                                <th style="text-align: center;"><spring:message code="unpaidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemsoldQty" text="SOLD QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemrefundQty" text="REFUND QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemPrice" text="ITEM PRICE" /></th>
												<th style="text-align: center;display:none;"><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" /></th>

                                            </thead>
                                            <tbody id="refundableitemsdetailsofordertbody"></tbody>
                                            </table>
                                             </div>  </div><!-- </div></div>  -->

                                               <div class="col-md-12 col-sm-12" >
                                                <div class="col-md-6 col-sm-6"></div>
                                               <div class="col-md-5 col-sm-5">
                                                <table style="width:100%;">
                                                    <tr>
								                  <td style="text-align: right;" colspan="2"><spring:message code="admin.order.subtotal" text="SUB TOTAL" />: </td>
								                  <td id="paidordertotalitemprice"  style="text-align: right;"  colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2">${sessionScope.loggedinStore.serviceChargeText}:
								                  <span id="paidorderschargepers"></span><span>(%)</span>
								                  </td>
								                  <td id="paidorderschargeamt"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2"><spring:message code="base.roombooking.checkout.adddiscount" text="DISCOUNT" />
								                  <span id="paidorderdiscpers"></span><span>(%)</span>
								                  <input style="display:none;" id="orderDiscPersForRefund">
								                  </td>
								                  <td id="paidorderdiscamt"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
								                  <tr>
								                  <td  style="text-align: right;" colspan="2">${sessionScope.loggedinStore.vatTaxText}
								                  <span id="paidordervatpers">${sessionScope.loggedinStore.vatAmt}</span><span>(%)</span>

								                  </td>
								                  <td id="paidordervatamt"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                  <c:if
										          test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
								                  <tr>
								                  <td style="text-align: right;" colspan="2">${sessionScope.loggedinStore.serviceTaxText}
								                  <span id="paidorderstaxpers">${sessionScope.loggedinStore.serviceTaxAmt}</span><span>(%)</span>
								                  </td>
								                  <td id="paidorderstaxamt"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                   <tr>
								                  <td  style="text-align: right;" colspan="2"><spring:message code="admin.showdailyexpenditure.jsp.edit.netamt" text="NET AMOUNT" /> </td>
								                  <td id="paidordernetamt"  style="text-align: right;" colspan="2"></td>
								                  </tr>
                                                </table>

                                               </div>
                                               <div class="col-md-1 col-sm-1"></div>
                                                </div>





							        	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addsalesreturnalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addorderrefunddata()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.advtblbookingmgnt.jsp.refundorder" text="REFUND" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
               <!-- refund modal end -->


               <!-- approve and delete modal starts -->
           					<div class="modal fade" data-backdrop="static" id="orderrefundapprovemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto; width:60%;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="paidorder.jsp.APPROVE" text="APPROVE" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div>

								<div style="text-align:center;font-size: 15px;padding: 10px;" class="col-md-12 col-sm-12">
								<div class="col-md-12 col-sm-12">
								<table style="width:100%;">
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ORDERNO" text="ORDER NO" /></strong> </span>
								<span id="paidordernoforapprove" style="display:none;"></span><span id="storebasepaidordernoforapprove"></span>
								<span id="salesreturnidforapprove" style="display:none;"></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.advtblbookingmgnt.jsp.date" text="DATE" />&nbsp;:</strong></span>
								<span id="paidorderdateforapprove"></span>
								</td>

								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />&nbsp;:</strong> </span>
								<span  id="paidordertblforapprove"></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.CUSTOMERNAME" text="CUSTOMER NAME" />&nbsp;:</strong></span>
								<span id="paidordercustomernameforapprove"></span>
								</td>
								</tr>

								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" />&nbsp;: </strong></span>
								<span  id="paidordercustomercontactnoforapprove" ></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ADDRESS" text="ADDRESS" />&nbsp;:</strong></span>
								<span  id="paidordercustomeraddressforapprove"></span>

								</td>
								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" />&nbsp;:</strong> </span>
								<span>
								<select id="returnreasonforapprove"  style="margin-bottom: 2px;color: #222222;" onChange="setReturnReason(this.value);" disabled>
                                           <c:if test="${! empty reasons}">
                                                               <option value="0">Select Reason</option>
                                            					<c:forEach items="${reasons}" var="returnreason">
                                            						<option value="${returnreason.id}">${returnreason.remark}</option>
                                            					</c:forEach>
                                            					</c:if>

                                 </select>
								</span>
								</td>

								<td style="text-align:left;" colspan="2">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="REMARKS" /> &nbsp;:</strong></span>
								<span><input type="text" id="refundremarkforapprove" value="" style="color:black;" disabled></span>
								</td>


								</tr>
								<tr style="display:none;">
								<td>
								<span style="display:inline;" ><spring:message code="order.jsp.bill.DELIVERYBOY" text="order.jsp.bill.DELIVERYBOY" />&nbsp;: </span>
								<span style="display:inline;" id="paidorderdeliveryboyforapprove"></span>

								</td>

								<td>
								<span style="display:inline;" ><spring:message code="admin.tablenew.jsp.Waiter" text="WAITER" /> &nbsp;:</span>
								<span style="display:inline;" id="paidorderwaiterforapprove"></span>

								</td>
								</tr>
								</table>

								</div>
                             </div>
                              <!-- <div style="overflow-y: auto; padding: 2px;">
								<div class="panel panel-default"> -->
									<div  style="overflow-y: auto;height: 150px;padding: 1px;">
										<div  style="text-align: left;font-size: 15px;">
											<table class="table table-bordered" style="border: 1px solid white;" id="approverefunditemtable">
											  <thead>
                                                <th style="text-align: center;"><spring:message code="unpaidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemsoldQty" text="SOLD QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemrefundQty" text="REFUND QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemPrice" text="ITEM PRICE" /></th>
												<th style="text-align: center;display:none;"><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" /></th>

                                            </thead>
                                            <tbody id="refundableitemsdetailsofordertbodyforapprove"></tbody>
                                            </table>
                                             </div>  </div><!-- </div></div>  -->

                                               <div class="col-md-12 col-sm-12" >
                                                <div class="col-md-6 col-sm-6"></div>
                                               <div class="col-md-5 col-sm-5">
                                                <table style="width:100%;">
                                                    <tr>
								                  <td style="text-align: right;" colspan="2"><spring:message code="admin.order.subtotal" text="SUB TOTAL" />: </td>
								                  <td id="paidordertotalitempriceforapprove"  style="text-align: right;"  colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2">${sessionScope.loggedinStore.serviceChargeText}:
								                  <span id="paidorderschargepersforapprove"></span><span>(%)</span>
								                  </td>
								                  <td id="paidorderschargeamtforapprove"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2"><spring:message code="base.roombooking.checkout.adddiscount" text="DISCOUNT" />
								                  <span id="paidorderdiscpersforapprove"></span><span>(%)</span>
								                  </td>
								                  <td id="paidorderdiscamtforapprove"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
								                  <tr>
								                  <td  style="text-align: right;" colspan="2">${sessionScope.loggedinStore.vatTaxText}
								                  <span id="paidordervatpersforapprove">${sessionScope.loggedinStore.vatAmt}</span><span>(%)</span>

								                  </td>
								                  <td id="paidordervatamtforapprove"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                  <c:if
										          test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
								                  <tr>
								                  <td style="text-align: right;" colspan="2">${sessionScope.loggedinStore.serviceTaxText}
								                  <span id="paidorderstaxpersforapprove">${sessionScope.loggedinStore.serviceTaxAmt}</span><span>(%)</span>
								                  </td>
								                  <td id="paidorderstaxamtforapprove"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                   <tr>
								                  <td  style="text-align: right;" colspan="2"><spring:message code="admin.showdailyexpenditure.jsp.edit.netamt" text="NET AMOUNT" /> </td>
								                  <td id="paidordernetamtforapprove"  style="text-align: right;" colspan="2"></td>
								                  </tr>
                                                </table>

                                               </div>
                                               <div class="col-md-1 col-sm-1"></div>
                                                </div>





							        	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="approvesalesreturnalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:approverefund()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="paidorder.jsp.APPROVE" text="APPROVE" /></button>
                                            <button type="button" onclick="javascript:confirmdeleterefund()" style="background: #cc2020;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="order.jsp.DELETE" text="DELETE" /></button>

                                        </div>
                                    </div>
                                </div>
                            </div>
               <!-- approve and delete modal end -->

               <!-- details modal starts -->
           					<div class="modal fade" data-backdrop="static" id="orderrefunddetailsmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto; width:60%;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="paidorder.jsp.DETAILS" text="DETAILS" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div>

								<div style="text-align:center;font-size: 15px;padding: 10px;" class="col-md-12 col-sm-12">
								<div class="col-md-12 col-sm-12">
								<table style="width:100%;">
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ORDERNO" text="ORDER NO" /></strong> </span>
								<span id="paidordernofordetails" style="display:none;"></span><span id="storebasepaidordernofordetails"></span>
								<span id="salesreturnidfordetails" style="display:none;"></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.advtblbookingmgnt.jsp.date" text="DATE" />&nbsp;:</strong></span>
								<span id="paidorderdatefordetails"></span>
								</td>

								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.tableNo" text="TABLE NO" />&nbsp;:</strong> </span>
								<span  id="paidordertblfordetails"></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.CUSTOMERNAME" text="CUSTOMER NAME" />&nbsp;:</strong></span>
								<span id="paidordercustomernamefordetails"></span>
								</td>
								</tr>

								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.creditsale.jsp.phNo" text="CONTACT NO" />&nbsp;: </strong></span>
								<span  id="paidordercustomercontactnofordetails" ></span>
								</td>
								<td style="text-align:left;">
								<span><strong><spring:message code="order.jsp.ADDRESS" text="ADDRESS" />&nbsp;:</strong></span>
								<span  id="paidordercustomeraddressfordetails"></span>

								</td>
								</tr>
								<tr>
								<td style="text-align:left;">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" />&nbsp;:</strong> </span>
								<span>
								<select id="returnreasonfordetails"  style="margin-bottom: 2px;color: #222222;" onChange="setReturnReason(this.value);" disabled>
                                           <c:if test="${! empty reasons}">
                                                               <option value="0">Select Reason</option>
                                            					<c:forEach items="${reasons}" var="returnreason">
                                            						<option value="${returnreason.id}">${returnreason.remark}</option>
                                            					</c:forEach>
                                            					</c:if>

                                 </select>
								</span>
								</td>

								<td style="text-align:left;" colspan="2">
								<span><strong><spring:message code="admin.invitemmgnt.jsp.refundRemarks" text="REMARKS" /> &nbsp;:</strong></span>
								<span><input type="text" id="refundremarkfordetails" value="" style="color:black;" disabled></span>
								</td>


								</tr>
								<tr style="display:none;">
								<td>
								<span style="display:inline;" ><spring:message code="order.jsp.bill.DELIVERYBOY" text="order.jsp.bill.DELIVERYBOY" />&nbsp;: </span>
								<span style="display:inline;" id="paidorderdeliveryboyfordetails"></span>

								</td>

								<td>
								<span style="display:inline;" ><spring:message code="admin.tablenew.jsp.Waiter" text="WAITER" /> &nbsp;:</span>
								<span style="display:inline;" id="paidorderwaiterfordetails"></span>

								</td>
								</tr>
								</table>

								</div>
                             </div>
                              <!-- <div style="overflow-y: auto; padding: 2px;">
								<div class="panel panel-default"> -->
									<div  style="overflow-y: auto;height: 150px;padding: 1px;">
										<div  style="text-align: left;font-size: 15px;">
											<table class="table table-bordered" style="border: 1px solid white;" id="detailsrefunditemtable">
											  <thead>
                                                <th style="text-align: center;"><spring:message code="unpaidorder.jsp.SLNO" text="SL NO" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemCode" text="ITEM CODE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemName" text="ITEM NAME" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.rate" text="RATE" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemsoldQty" text="SOLD QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemrefundQty" text="REFUND QTY" /></th>
												<th style="text-align: center;"><spring:message code="admin.invitemmgnt.jsp.itemPrice" text="ITEM PRICE" /></th>
												<th style="text-align: center;display:none;"><spring:message code="admin.invitemmgnt.jsp.refundReason" text="REFUND REASON" /></th>

                                            </thead>
                                            <tbody id="refundableitemsdetailsofordertbodyfordetails"></tbody>
                                            </table>
                                             </div>  </div><!-- </div></div>  -->

                                               <div class="col-md-12 col-sm-12" >
                                                <div class="col-md-6 col-sm-6"></div>
                                               <div class="col-md-5 col-sm-5">
                                                <table style="width:100%;">
                                                    <tr>
								                  <td style="text-align: right;" colspan="2"><spring:message code="admin.order.subtotal" text="SUB TOTAL" />: </td>
								                  <td id="paidordertotalitempricefordetails"  style="text-align: right;"  colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2">${sessionScope.loggedinStore.serviceChargeText}:
								                  <span id="paidorderschargepersfordetails"></span><span>(%)</span>
								                  </td>
								                  <td id="paidorderschargeamtfordetails"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
                                                  <tr>
								                  <td  style="text-align: right;"  colspan="2"><spring:message code="base.roombooking.checkout.adddiscount" text="DISCOUNT" />
								                  <span id="paidorderdiscpersfordetails"></span><span>(%)</span>
								                  </td>
								                  <td id="paidorderdiscamtfordetails"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  <c:if
										           test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
								                  <tr>
								                  <td  style="text-align: right;" colspan="2">${sessionScope.loggedinStore.vatTaxText}
								                  <span id="paidordervatpersfordetails">${sessionScope.loggedinStore.vatAmt}</span><span>(%)</span>

								                  </td>
								                  <td id="paidordervatamtfordetails"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                  <c:if
										          test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
								                  <tr>
								                  <td style="text-align: right;" colspan="2">${sessionScope.loggedinStore.serviceTaxText}
								                  <span id="paidorderstaxpersfordetails">${sessionScope.loggedinStore.serviceTaxAmt}</span><span>(%)</span>
								                  </td>
								                  <td id="paidorderstaxamtfordetails"  style="text-align: right;" colspan="2"></td>
								                  </tr>
								                  </c:if>
								                   <tr>
								                  <td  style="text-align: right;" colspan="2"><spring:message code="admin.showdailyexpenditure.jsp.edit.netamt" text="NET AMOUNT" /> </td>
								                  <td id="paidordernetamtfordetails"  style="text-align: right;" colspan="2"></td>
								                  </tr>
                                                </table>

                                               </div>
                                               <div class="col-md-1 col-sm-1"></div>
                                                </div>





							        	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addadvtblbookingalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.msg.close" text="CLOSE" /></button>

                                        </div>
                                    </div>
                                </div>
                            </div>
               <!-- details modal end -->


               <!-- delete confirmation  modal start -->
                            <div class="modal fade" data-backdrop="static" id="confirmdeletesalesreturnModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">

                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.advtblbookingmgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.advtblbookingmgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmsalereturnid" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleterefund()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.advtblbookingmgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                  <!-- delete confirmation  modal start -->

<!--Bill print modals start  -->
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


							<b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							    <div id="storeName58">${sessionScope.loggedinStore.storeName}</div></font></b> <b>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							   <div id="storeAddr58">${sessionScope.loggedinStore.address}</div></font></b>
							<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							   <div id="storeEmail58"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
							<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
							    <div id="storePhNo58"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>
								<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							    <spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						       </div> <br>

							<%-- <div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail58"></div>
							</div>
							<div
								style="font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b> <div id="storePhNo58"></div>
							</div> --%>
							<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="orderValue58" style="font-weight:bold">00</span>
							</div>
                              <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Date :</b><span id="cashOrderdate58">00</span>
							</div>
                           <%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_58px">${orders.ordertype.orderTypeName}</span>
							</div> --%>

							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno">
								<%-- <spring:message code="order.jsp.TableNo"
										text="Table No :" /> --%>
										 <b><span id="tableNoValue58">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId_58">

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
										id="itemDetailsPrint58"></tbody>

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
										id=totalAmt58>00</span></td>
								</tr>
								<tr id="totalServiceChrg_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}(${orders.orderBill.serviceChargeRate}%):
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servChrg58">00</span></td>
								</tr>

								<tr id="totalServiceTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.serviceTaxText}(${sessionScope.loggedinStore.serviceTaxAmt}%)
										:</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="servTax58">00</span></td>
								</tr>

								<tr id="totalVatTax_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.vatTaxText}(${sessionScope.loggedinStore.vatAmt}%):</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="vatTax58">00</span></td>
								</tr>
								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="grossAmount58">00</span></b></td>
								</tr>
								<tr id="showDiscount_58">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="discountValue58">00</span></td>
								</tr>
								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="amoutToPay58">00</span></b></td>
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
											id="paidAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount58">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmount58">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 11px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="orderrefundAmount58">00</span></b></td>
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
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.ThankYouVisitAgain"
										text="**Thank You. Visit Again" /></font>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="removePrint58"
						style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
						<button type="button"
							onclick="javascript:printCashOrCardLocal58()"
							style="background: #72BB4F; font-weight: bold;"
							data-dismiss="modal" class="btn btn-success" id="printBtn_58">
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

							<b><font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
							<div id="storeName80">${sessionScope.loggedinStore.storeName}</div></font></b>
							<c:if test="${sessionScope.loggedinStore.id==126}">
								<b><font
									style="font-size: 10px; font-style: normal; font-family: sans-serif;">A
										UNIT OF SAPPHIRE CAFE LLP</font></b>
							</c:if>
							<b><font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storeAddr80">${sessionScope.loggedinStore.address}</div></font></b>
								<font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
								<div id="storeEmail80"><spring:message code="order.jsp.Email" text="Email" /> :${sessionScope.loggedinStore.emailId}</div></font>
								<font style="font-size: 10px; font-style: normal; font-family: sans-serif;">
								<div id="storePhNo80"><spring:message code="order.jsp.Ph" text="Ph" /> :</b>
								${sessionScope.loggedinStore.mobileNo}</div></font>

							<%-- <div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Email" text="Email"/> :</b><div id="storeEmail80"></div>
							</div>
							<div
								style="text-align: center; font-size: 11px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.Ph" text="Ph"/> :</b><div id="storePhNo80"></div>
							</div> --%>

							<div id="paidgstdata" style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">

							</div>
							<div style="text-align: center; font-size: 11px; font-family: sans-serif;font-weight:bold;">
							<spring:message code="admin.jsp.refundbill" text="REFUND BILL" />
						    </div> 
						<div
								style="text-align: left; font-size: ${sessionScope.loggedinStore.kotTableFont}px; font-family: sans-serif;">
								<b><spring:message code="order.jsp.OrderNoInvoice"
										text="Order No / Invoice " />:</b> <span id="cashOrdervalue80" style="font-weight:bold">00</span>
							</div>


							<div
										style="text-align: left; font-size: 11px; font-family: sans-serif;">
										<%-- <fmt:parseDate value="${orders.orderDate}" var="parsedInvDate"
											pattern="yyyy-MM-dd" /> --%>
										<b>Date :</b><span  id="cashOrderdate80"></span>
									</div>

							<%-- <div
								style="text-align: left; font-size: 11px; font-family: sans-serif;">
								<b>Order Type :</b> <span id="orderType_80px">${orders.ordertype.orderTypeName}</span>
							</div> --%>
							<div
								style="text-align: left; font-size: 11px; font-family: sans-serif;"
								id="showtableno80px">
								<%-- <spring:message code="order.jsp.TableNo" text="Table No:" /> --%>
								<b><span id="cashtableNoValue80">00</span></b>
							</div>

							<div class="table-responsive" id="orderitemContId_80">
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
										id="itemDetailsPrint80"></tbody>

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
										id="cashtotalamt80">00</span></td>
								</tr>
								<tr id="cashshowDiscount80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<spring:message code="order.jsp.TOTALDISCOUNT"
											text="TOTAL DISCOUNT" /> (<span id="paidbilldiscpers"></span>%) :
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashdiscountValue80">00</span></td>
								</tr>
								<tr id="cashtotalServiceCharge80px" class="serviceCharge80px">
									<td
										style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
										<%-- <spring:message code="order.jsp.ServiceCharge"
											text="Service Charge" /> --%>${sessionScope.loggedinStore.serviceChargeText}<span id="cashservChrgDisc80">00</span>:
									</td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;">
										<span id="cashservChrg80">00</span>
									</td>
								</tr>

								<tr id="cashtotalServiceTax80px">
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
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashservTax80">00</span></td>
								</tr>

								<tr id="cashtotalVatTax80px">
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
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
										id="cashvatTax80px">00</span></td>
								</tr>

								<tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.TotalAmount" text="NET TOTAL" /> :</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashgrossAmount80">00</span></b></td>
								</tr>

								

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.AMOUNTTOPAY" text="AMOUNT TO PAY" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="cashamoutToPay80">00</span></b></td>
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
											id="paidAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.tender_amount" text="Tender Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="tenderAmount80">00</span></b></td>
								</tr>

								<tr style="display:none;">
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="refundAmount80">00</span></b></td>
								</tr>
                                 <tr>
									<td><b><span
											style="font-weight: bold; font-size: 12px; font-family: sans-serif;"><spring:message
													code="order.jsp.refund_amount" text="Refund Amount" />:</span></b></td>
									<td
										style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
											id="orderrefundAmount80">00</span></b></td>
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
								<font style="font-size: 12px; font-family: sans-serif;"><spring:message
										code="order.jsp.**Thank You. Visit Again"
										text="**Thank You. Visit Again" />**</font>
							</div>
						</div>
						<div class="modal-footer" id="cashRemovePrint80"
							style="background: #ffffff; border-top: 1px solid #ffffff; padding: 10px;">
							<button type="button"
								onclick="javascript:printCashOrCardLocal80()"
								style="background: #72BB4F; font-weight: bold;"
								class="btn btn-success" id="printBtn_80">
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
										<b>Name :</b><span id="cashCustName_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Address :</b> <span id="cashCustAddr_GST"></span>
									</div>
									<div
										style="text-align: left; font-size: 15px; font-family: sans-serif;">
										<b>Contact No:</b><span id="cashCustPhone2100_GST"></span>
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
								<div
								style="text-align: left; font-size: 15px; font-family: sans-serif;">
								<b><span id="cashtableNoValue2100">00</span></b>
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
													code="reprintcash.jsp.totqty" text="Disc" />(<span id="customerDiscpercentage"></span>%)</th>
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
										<span style="padding-left: 60%" id="cashIGST2100_gst">00</span></td>

								</tr>
								<!-- new added 10.5.2018 start -->
								 <tr style="display:none;">
	                             <td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Paid
												Amount :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="paidAmount_paidbill_2100px">00</span></b></td>
								 </tr>


								 <tr style="display:none;">
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Amount
												To Pay :</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="amoutToPay_paidbill_2100px">00</span></b></td>
								 </tr>

                                 <tr>
									<td width="50%"><b><span
											style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Refund Amount:</span></b></td>
									<td width="50%"
										style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;"><b><span
											id="refundorderamount2100px">00</span></b></td>
								 </tr>
                                 <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									 <b><span id="paymentmode_paidbill_2100px"></span></b></td>
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

     <!-- Bill Print modals part end -->
<div class="modal fade" data-backdrop="static" id="paidbillPrintSuccessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="paidorder.jsp.Success" text="Success" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<input type="hidden" id="hiddmanualeditItemId" value=""> <spring:message code="paidorder.jsp.Billhasbeensuccessfullyprinted" text="Bill has been successfully printed" />!
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:showDirectPaymentforPacel()" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="paidorder.jsp.OK" text="OK" /></button>
						</div>
					</div>
				</div>
			</div>
			
			
          <!-- modals part end -->


        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->

    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/orderrefund.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

   <script type="text/javascript">
   var printReason="${sessionScope.loggedinStore.isProvideReason}";
   var BASE_URL="${pageContext.request.contextPath}";
   var storeID="${sessionScope.loggedinStore.id}";
   var todaydate="${today}";
   var servicechargeflag="${sessionScope.loggedinStore.serviceChargeFlag}";
   var vatTaxText="${sessionScope.loggedinStore.vatTaxText.length()}";
   var serviceTaxText="${sessionScope.loggedinStore.serviceTaxText.length()}";
   var is_Acc='${is_acc}';
   var mobPrintVal="${sessionScope.loggedinStore.mobBillPrint}";
   var printbillpapersize="${sessionScope.loggedinStore.printBillPaperSize}";
   var gsttext = "${sessionScope.loggedinStore.gstText}";
   var gstno = "${sessionScope.loggedinStore.gstRegNo}";
   var printReason="${sessionScope.loggedinStore.isProvideReason}";
   var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
   var storeAddr = "${sessionScope.loggedinStore.address}";
   $(document).ready(function() {

		$('#daywisepaidorderdetails').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true

		});
     });


   </script>

   

</body>
</html>
