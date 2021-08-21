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
      <title>:. POS :: Customer Management :.</title>
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
      <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
      <style type="text/css">
         .ui-autocomplete {
         overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
         } 
         /* .modal:nth-of-type(even) {
         z-index: 1042 !important;
         }
         .modal-backdrop.in:nth-of-type(even) {
         z-index: 1041 !important;
         } */
      </style>
   </head>
   <body>
      <jsp:include page="/pages/common/header.jsp"></jsp:include>
      <c:set var="today" value="<%=new java.util.Date()%>" />
      <div class="content-wrapper">
         <div class="container-fluid">
            <div class="row">
               <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>
               <div class="col-md-10 col-sm-10">
                  <div class="col-md-10 col-sm-10">
                     <div style="color:#FFF; font-size:16px; font-weight:bold;">
                        <spring:message code="admin.admleftpanel.jsp.prebookingheader" text="ADVANCE TABLE BOOKING" />
                     </div>
                  </div>
                  <div class="col-md-2 col-sm-2">
                     <a href="javascript:showadvanceTableBookingModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;">
                        <spring:message code="admin.advtblbookingmgnt.jsp.add" text="ADD" />
                     </a>
                  </div>
                  <div class="col-md-12 col-sm-12">
                     <!--   Kitchen Sink -->
                     <div style="max-height: 400px;overflow-y:auto; ">
                        <div class="panel panel-default">
                           <div class="panel-body">
                              <div class="table-responsive" style="background:#404040;">
                                 <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.id" text="ID" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.ordertype" text="ORDER TYPE" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingcustomer" text="CUSTOMER" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingcustomercontact" text="CONTACT" />
                                       </th>
                                       <%-- <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingcustomerpax" text="PAX" />
                                       </th>--%>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingdate" text="ORDER DATE" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingtime" text="BOOKING DATE" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.prebookingpaidammt" text="PAID AMMT" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.bookingadvpayment" text="ADV PAY" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.edit" text="EDIT" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.creditsale.jsp.cancel" text="CANCEL" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advtblbookingmgnt.jsp.details" text="DETAILS" />
                                       </th>
                                       <th style="text-align:center;">
                                          <spring:message code="admin.advorder.jsp.printbill" text="INVOICE" />
                                       </th>
                                    </thead>
                                    <tbody>
                                       <c:if test="${! empty advanceTableBookingList }">
                                          <c:forEach items="${advanceTableBookingList}" var="advtblbooking">
                                             <tr style="background:#404040; color:#FFF;">
                                                <td align="center">${advtblbooking.orderNo}</td>
                                                <td align="center">${advtblbooking.ordertype.orderTypeName}</td>
                                                <td align="center">${advtblbooking.customerName}</td>
                                                <td align="center">${advtblbooking.customerContact}</td>
                                                 <%-- <td align="center">${advtblbooking.noOfPersons}</td>--%>
                                                <%-- <fmt:parseDate value = "${advtblbooking.orderDate}" var = "dt" pattern = "yyyy-MM-dd" /> --%>
                                                <td align="center">${advtblbooking.orderDate} ${advtblbooking.time}</td>
                                                <td align="center">${advtblbooking.orderTime}</td>
                                                <td align="center">${advtblbooking.payments[0].paidAmount}</td>
                                                <td align="center">
                                                   <a href="javascript:tableprebooking_advpayment(${advtblbooking.id})" class="btn btn-success">
                                                      <spring:message code="admin.advtblbookingmgnt.jsp.bookingadvpayment" text="ADV PAY" />
                                                   </a>
                                                </td>
                                                <%-- <td align="center"><a href="javascript:showadvtblbookingeditModal(${advtblbooking.id},&quot;${advtblbooking.ordertype.orderTypeName}&quot;,&quot;${advtblbooking.orderDate}&quot;,&quot;${advtblbooking.time}&quot;,&quot;${advtblbooking.customerName}&quot;,&quot;${advtblbooking.customerContact}&quot;,&quot;${advtblbooking.deliveryAddress}&quot;,${advtblbooking.noOfPersons},&quot;${advtblbooking.location}&quot;,${advtblbooking.storeCustomerId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td> --%>
                                                <td align="center"><a href="javascript:showadvtblbookingeditModal(${advtblbooking.orderNo})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                                <td align="center"><a href="javascript:showadvtblbookingcancellationModal(${advtblbooking.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/inv/delete_normal.png"></a></td>
                                                <td align="center"><a href="javascript:showDetailadvtblbookingModal(${advtblbooking.id},&quot;${advtblbooking.ordertype.orderTypeName}&quot;,&quot;${advtblbooking.orderDate}&quot;,&quot;${advtblbooking.time}&quot;,&quot;${advtblbooking.customerName}&quot;,&quot;${advtblbooking.customerContact}&quot;,&quot;${advtblbooking.deliveryAddress}&quot;,${advtblbooking.noOfPersons},&quot;${advtblbooking.location}&quot;,&quot;${advtblbooking.orderNo}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                                <td align="center"><a href="javascript:printAdvOrderInv(${advtblbooking.id},${advtblbooking.payments[0].paidAmount})" class="btn btn-success"> <spring:message code="order.jsp.PRINT" text="PRINT" /></a></td>
                                            
                                             </tr>
                                          </c:forEach>
                                       </c:if>
                                       <c:if test="${empty advanceTableBookingList}">
                                          <tr style="background:#404040; color:#FFF;">
                                             <td colspan="12">
                                                <spring:message code="admin.advtblbookingmgnt.jsp.noDataFound" text="No Data found!" />
                                             </td>
                                          </tr>
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
            <div>
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
                  value="${sessionScope.loggedinStore.parcelVat}"> 
               <input type="hidden" id="servicechargerate"
                  value="${sessionScope.loggedinStore.serviceChargeRate}">
               <input type="hidden" id="servicechargeflag"
                  value="${sessionScope.loggedinStore.serviceChargeFlag}">
               <input type="hidden" id="hidserviceChargeTextNew"
                  value="${sessionScope.loggedinStore.serviceChargeFlag}">
            </div>
            <!-- table pre booking edit modal starts --> 
            <div class="modal fade" data-backdrop="static" id="advtblbookingEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.editadvbooking" text="Edit Table Booking " />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: left;font-size: 20px;">
                           <input type="hidden" id="editadvbookingid" value="">
                           <table>
                              <tr>
                                 <td>
                                    <spring:message code="admin.tablenew.jsp.OrderType"
                                       text="Order Type" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <select id="editOrderType" style="width: 95%; color: #222222; margin-bottom: 5px;" onchange="checkOrderType(this.value,2)" disabled>
                                    
                                    </select>
                              </tr>
                              <tr id="editselecttabletr" style="display:none;">
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.table"
                                       text="Select Table" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><select id="editTableId" style="width: 95%; color: #222222; margin-bottom: 5px;">
                                    </select>
                                 </td>
                              </tr> 
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.orderdate"
                                       text="Date Of Order" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="editadvbookingdate" readonly="readonly"
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>"></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.orderitem"
                                       text="Select Item" />
                                    <span style="color: #ff0000;"></span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="edititemCodeSearch" 
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" ></td>
                              </tr>
                              <tr >
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.ordertime"
                                       text="Time Of Order" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td style="margin-bottom: 3px;"><input type="text"
                                    id="editadvbookingtime"
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.contactNo" text="Contact No." />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="editadvbookingcustcontact" maxlength="10"  
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.customername" text="Customer Name" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <input type="text" id="editadvbookingcustid"
                                       style="display:none;width: 95%; color: #222222; margin-bottom: 5px;"/>
                                    <input type="text" id="editadvbookingcustname"
                                       style="width: 95%; color: #222222; margin-bottom: 5px;"/>
                                 </td>
                              </tr>
                              <%-- <tr>
                                 <td><spring:message
                                 		code="admin.advtblbookingmgnt.jsp.emailId" text="Email ID" /></td>
                                 <td>:</td>
                                 <td><input type="text" id="editadvbookingcustemail"
                                 	style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
                                 </tr> --%>										
                              <tr style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.address" text="Address" />
                                 </td>
                                 <td>:</td>
                                 <td><textarea id="editadvbookingcustaddress" rows="2"
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
                              </tr>
                              <tr style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.location" text="Location" />
                                 </td>
                                 <td>:</td>
                                 <td><input id="editadvbookingcustlocation" 
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"/></td>
                              </tr>
                               <tr style="display:none;">
                                 <td>
                                    <spring:message code="accsetup.jsp.state" text="State" />
                                 </td>
                                 <td>:</td>
                                 <td><input id="editadvbookingcuststate" 
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"/></td>
                              </tr>
                              <tr id="editadvbookingcustnoofpersontr" style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.noofperson" text="No.Of Persons" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="editadvbookingcustnoofperson" rows="2"
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
                              </tr>
                           </table>
                           <div style="text-align: center;overflow:auto;" id="editadvtblbookingitems"></div>
                           <div style="text-align: center;" id="editcalculationdiv" >
                              <!--Bill Part -->
                              <table style='color:#FFF;font-size:55%;display:none;width:100%;' id="editbilltbl">
                                 <tbody style='color:#fff; padding:1px; width:100%;'>
                                    <tr>
                                       <td>SubTotal :</td>
                                       <td>
                                          <div id="subtotalcontId1" style="float: right; font-weight: bold;">
                                          </div>
                                       </td>
                                        <c:if test="${sessionScope.loggedinStore.serviceChargeFlag == 'Y'}">
                                       <td>
                                         <div>
                                                ${sessionScope.loggedinStore.serviceChargeText}(
                                                <span id="schargevalue1"></span>)%:
                                             </div>
                                       </td>
                                        </c:if>
                                          <c:if test="${sessionScope.loggedinStore.serviceChargeFlag == 'Y'}">
                                         <td>
                                         <div id="schrgId1" style="float: right; font-weight: bold;">
                                                <a href="#" id="servicechrgId1">
                                                </a>
                                             </div>
                                        </td>
                                         </c:if>
                                         <c:if test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
                                       <td>
                                          
                                             ${sessionScope.loggedinStore.vatTaxText}
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <c:if test="${sessionScope.loggedinStore.vatAmt!=0.0}">
                                                   (${sessionScope.loggedinStore.vatAmt}%)
                                                </c:if>
                                                :
                                             </c:if>
                                        </td>
                                          </c:if>
                                          <c:if test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
                                       <td>
                                           <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <div id="vatcontId1" style="float: right; font-weight: bold;">
                                                   <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                      minFractionDigits="2" maxFractionDigits="2"
                                                      value="" /> --%>
                                                </div>
                                             </c:if>
                                          
                                       </td>
                                       </c:if>
                                       <!-- <td>
                                       </td> -->
                                        <c:if test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
                                       <td>
                                         
                                             ${sessionScope.loggedinStore.serviceTaxText}
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <c:if test="${sessionScope.loggedinStore.serviceTaxAmt!=0.0}">
                                                   (${sessionScope.loggedinStore.serviceTaxAmt}%)
                                                </c:if>
                                                :
                                             </c:if>
                                          
                                       </td>
                                       </c:if>
                                       <c:if test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
                                       <td>
                                          
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <div id="servicetaxcontId1"
                                                   style="float: right; font-weight: bold;"><%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                   minFractionDigits="2" maxFractionDigits="2"/> --%></div>
                                             </c:if>
                                          
                                       </td>
                                      </c:if>
                                    </tr>
                                    <tr>
                                       <td></td>
                                       <td></td>
                                        <td style="text-align: right;">
                                          <strong>
                                             <spring:message code="order.jsp.TOTAL" text="TOTAL" />
                                             (${sessionScope.loggedinStore.currency}):
                                          </strong>
                                       </td>
                                       <td style="text-align:left;">
                                          <div id="grandtotalcontId1" style="float: right; font-weight: bold;">
                                             <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                minFractionDigits="2" maxFractionDigits="2"
                                                value="" /> --%>
                                          </div>
                                       </td>
                                       <td style="display:none;">
                                          <strong>
                                             <spring:message code="order.jsp.AMOUNTTOPAY"
                                                text="AMOUNT TO PAY" />
                                             :
                                          </strong>
                                       </td>
                                       <td style="display:none;">
                                          <div id="amttopaycontId1" style="float: right; font-weight: bold;">
                                             <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                minFractionDigits="2" maxFractionDigits="2"
                                                value="" /> --%>
                                          </div>
                                       </td>
                                    </tr>
                                 </tbody>
                              </table>
                           </div>
                           <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editadvtblbookingalertMsg"></div>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning"  onclick="javascript:clearOrderListSession(2)">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" onclick="javascript:editadvtblbookindata()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success">
                           <spring:message code="admin.advtblbookingmgnt.jsp.edit" text="EDIT" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- table pre booking edit modal end --> 
            <!-- modals part starts -->
            <!-- table pre booking add modal starts -->
            <div class="modal fade" data-backdrop="static" id="advtblbookingAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.addbooking" text="Book Table" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: left;font-size: 20px;">
                           <table>
                              <tr>
                                 <td>
                                    <spring:message code="admin.tablenew.jsp.OrderType"
                                       text="Order Type" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <select id="addOrderType" style="width: 95%; color: #222222; margin-bottom: 5px;" onchange="checkOrderType(this.value,1)">
                                       <c:if test="${! empty orderTypeList}">
                                          <option value="0" disabled selected>Select Order Type</option> 
                                          <c:forEach items="${orderTypeList}" var="ordertype">
                                             <option value="${ordertype.id}_${ordertype.serviceChargeValue}">${ordertype.orderTypeName}</option>
                                          </c:forEach>
                                       </c:if>
                                    </select>
                              </tr>
                         <%-- <tr id="selecttabletr">
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.table"
                                       text="Select Table" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <select id="TableId" style="width: 95%; color: #222222; margin-bottom: 5px;" onchange="checkTableStatus(this.value)">
                                       <option value="0">
                                          <spring:message code="admin.tablenew.jsp.slctTab" text="Select Table" />
                                       </option>
                                       <c:forEach items="${tableList}" var="tablelist">
                                          <option value="${tablelist.tableNo}">${tablelist.tableNo}</option>
                                       </c:forEach>
                                    </select>
                                 </td>
                              </tr>  --%>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.orderdate"
                                       text="Date Of Order" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="advbookingdate" readonly="readonly"
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" value=""></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.orderitem"
                                       text="Select Item" />
                                    <span style="color: #ff0000;"></span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="itemCodeSearch" 
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" disabled></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.ordertime"
                                       text="Time Of Order" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td style="margin-bottom: 3px;"><input type="text"
                                    id="advbookingtime"
                                    style="width: 95%; color: #222222; margin-bottom: 5px;" placeholder="HH:MM"/></td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.contactNo" text="Contact No." />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <input type="text" id="advbookingcustcontact" maxlength="10"  
                                       style="width: 70%; color: #222222; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/>
                                    <button type="button" onclick="javascript:openaddnewprebookcustomerdata();" style="background: #72BB4F;font-weight: bold;width: 20%;height: 30%;margin-bottom: 5px;"  class="btn btn-success">
                                       <spring:message code="stockinnew.jsp.NEW" text="NEW" />
                                    </button>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.customername" text="Customer Name" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td>
                                    <input type="text" id="advbookingcustid"
                                       style="display:none;width: 95%; color: #222222; margin-bottom: 5px;"/>
                                    <input type="text" id="advbookingcustname"
                                       style="width: 95%; color: #222222; margin-bottom: 5px;"/>
                                 </td>
                              </tr>
                              <%-- <tr>
                                 <td><spring:message
                                 		code="admin.advtblbookingmgnt.jsp.emailId" text="Email ID" /></td>
                                 <td>:</td>
                                 <td><input type="text" id="advbookingcustemail"
                                 	style="width: 95%; color: #222222; margin-bottom: 5px;" /></td>
                                 </tr>		 --%>							
                              <tr style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.address" text="Address" />
                                 </td>
                                 <td>:</td>
                                 <td><textarea id="advbookingcustaddress" rows="2"
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"></textarea></td>
                              </tr>
                              <tr style="display:none;">
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.location" text="Location" />
                                 </td>
                                 <td>:</td>
                                 <td><input id="advbookingcustlocation" 
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"/></td>
                              </tr>
                               <tr style="display:none;">
                                 <td>
                                    <spring:message code="admin.jsp.state" text="State" />
                                 </td>
                                 <td>:</td>
                                 <td><input id="advbookingcuststate" 
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;"/></td>
                              </tr>
                              <tr id="advbookingcustnoofpersontr" style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.noofperson" text="No.Of Persons" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="advbookingcustnoofperson" 
                                    style="margin-bottom: 2px; color: #222222; width: 95%; margin-bottom: 5px;" onkeypress='return isNumberKey(event)'/></td>
                              </tr>
                           </table>
                           <div style="text-align: center;overflow:auto;" id="addadvtblbookingitems"></div>
                           <div style="text-align: center;" id="addcalculationdiv" >
                              <!--Bill Part -->
                              <table style='color:#FFF;font-size:55%;display:none;width:100%;' id="billtbl">
                                 <tbody style='color:#fff; padding:1px; width:100%;'>
                                    <tr>
                                       <td>SubTotal :</td>
                                       <td>
                                          <div id="subtotalcontId" style="float: right; font-weight: bold;">
                                          </div>
                                       </td>
                                       <c:if test="${sessionScope.loggedinStore.serviceChargeFlag == 'Y'}">
                                       <td>
                                          
                                             <div>
                                                ${sessionScope.loggedinStore.serviceChargeText}(
                                                <span id="schargevalue"></span>)%:
                                             </div>
                                          
                                       </td>
                                       </c:if>
                                       <c:if test="${sessionScope.loggedinStore.serviceChargeFlag == 'Y'}">
                                       <td>
                                          
                                             <div id="schrgId" style="float: right; font-weight: bold;">
                                                <a href="#" id="servicechrgId">
                                                </a>
                                             </div>
                                          
                                       </td>
                                       </c:if>
                                       <c:if test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
                                       <td>
                                          
                                             ${sessionScope.loggedinStore.vatTaxText}
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <c:if test="${sessionScope.loggedinStore.vatAmt!=0.0}">
                                                   (${sessionScope.loggedinStore.vatAmt}%)
                                                </c:if>
                                                :
                                             </c:if>
                                          
                                       </td>
                                       </c:if>
                                        <c:if test="${sessionScope.loggedinStore.vatTaxText.length()!=0}">
                                       <td>
                                         
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <div id="vatcontId" style="float: right; font-weight: bold;">
                                                   <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                      minFractionDigits="2" maxFractionDigits="2"
                                                      value="" /> --%>
                                                </div>
                                             </c:if>
                                          
                                       </td>
                                       </c:if>
                                       <!-- <td>
                                       </td> -->
                                         <c:if test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
                                       <td> ${sessionScope.loggedinStore.serviceTaxText}
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <c:if test="${sessionScope.loggedinStore.serviceTaxAmt!=0.0}">
                                                   (${sessionScope.loggedinStore.serviceTaxAmt}%)
                                                </c:if>
                                                :
                                             </c:if>
                                         
                                       </td>
                                        </c:if>
                                        <c:if test="${sessionScope.loggedinStore.serviceTaxText.length()!=0}">
                                       <td>
                                          
                                             <c:if test="${sessionScope.loggedinStore.id!=53 && sessionScope.loggedinStore.id!=78}">
                                                <div id="servicetaxcontId"
                                                   style="float: right; font-weight: bold;"><%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                   minFractionDigits="2" maxFractionDigits="2"/> --%></div>
                                             </c:if>
                                         
                                       </td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                       <td></td>
                                       <td></td>
                                       <td style="text-align: right;">
                                          <strong>
                                             <spring:message code="order.jsp.TOTAL" text="TOTAL" />
                                             (${sessionScope.loggedinStore.currency}):
                                          </strong>
                                       </td>
                                       <td style="text-align: left;">
                                          <div id="grandtotalcontId" style="float: right; font-weight: bold;">
                                             <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                minFractionDigits="2" maxFractionDigits="2"
                                                value="" /> --%>
                                          </div>
                                       </td>
                                       <td style="display:none;">
                                          <strong>
                                             <spring:message code="order.jsp.AMOUNTTOPAY"
                                                text="AMOUNT TO PAY" />
                                             :
                                          </strong>
                                       </td>
                                       <td style="display:none;">
                                          <div id="amttopaycontId" style="float: right; font-weight: bold;">
                                             <%-- <fmt:formatNumber type="number" groupingUsed="false"
                                                minFractionDigits="2" maxFractionDigits="2"
                                                value="" /> --%>
                                          </div>
                                       </td>
                                    </tr>
                                 </tbody>
                              </table>
                           </div>
                           <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addadvtblbookingalertMsg"></div>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning"  onclick="javascript:clearOrderListSession(1)">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" onclick="javascript:addadvtblbookindata()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success">
                           <spring:message code="admin.advtblbookingmgnt.jsp.book" text="BOOK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- table pre booking add modal end --> 
            <!-- delete confirmation  modal start --> 
            <div class="modal fade" data-backdrop="static" id="confirmdeleteadvtblbookingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.confirmation" text="Confirmation!" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: center;font-size: 20px;">
                           <spring:message code="admin.advtblbookingmgnt.jsp.areYouSure" text="Are you sure?" />
                           <input type="hidden" id="moddeleteconfirmadvtblbookingidContId" value="">
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" onclick="javacsript:deleteadvtblbooking()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">
                           <spring:message code="admin.advtblbookingmgnt.jsp.ok" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- delete confirmation  modal start --> 
            <!-- table pre booking details modal starts --> 
            <div class="modal fade" data-backdrop="static" id="advtblbookingDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.bookingdetails" text="Booking Details" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div align="center" style="font-size: 20px;">
                           <table>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message code="admin.advtblbookingmgnt.jsp.id" text="ID" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingid"></td>
                              </tr>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message code="admin.advtblbookingmgnt.jsp.ordertypesmall"
                                       text="Order Type" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailTableId"></td>
                              </tr>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message code="admin.advtblbookingmgnt.jsp.orderdate"
                                       text="Date Of Order" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingdate"></td>
                              </tr>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message code="admin.advtblbookingmgnt.ordertime"
                                       text="Time Of Order" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingtime"></td>
                              </tr>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.contactNo" text="Contact No." />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingcustcontact"></td>
                              </tr>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.customername" text="Customer Name" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingcustname"></td>
                              </tr>
                              <%-- <tr>
                                 <td style="padding: 5px 0px;"><spring:message
                                 		code="admin.advtblbookingmgnt.jsp.emailId" text="Email ID" /></td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingcustemail"></td>
                                 </tr>--%>
                              <tr>
                                 <td style="padding: 5px 0px;">
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.address" text="Address" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingcustaddress"></td>
                              </tr>
                              <tr style="display:none;">
                                 <td>
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.location" text="Location" />
                                 </td>
                                 <td>:</td>
                                 <td id="moddetailadvbookingcustlocation"></td>
                              </tr>
                              <tr style="display:none;">
                                 <td style="padding: 5px 0px;">
                                    <spring:message
                                       code="admin.advtblbookingmgnt.jsp.noofperson" text="No.Of Persons" />
                                 </td>
                                 <td width="5%">:</td>
                                 <td id="moddetailadvbookingnoofperson" ></td>
                              </tr>
                           </table>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal">
                           <spring:message code="admin.advtblbookingmgnt.jsp.ok" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- table pre booking details modal end --> 
            <!-- alert message modal start --> 
            <div class="modal fade" data-backdrop="static" id="alertcatdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: center;font-size: 20px;">
                           <div id="catdataopmassagecont"></div>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/advancebooking/loadadvancebooking.htm'" data-dismiss="modal" class="btn btn-success">
                           <spring:message code="admin.advtblbookingmgnt.jsp.ok" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- alert message modal start -->
            <!-- advance payment modal start --> 
            <div class="modal fade" data-backdrop="static" id="prebookadvancepaymentmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.prebookadvpay" text="Advance Payment" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: center;font-size: 20px;">
                           <input type="hidden" id="orderidforpayadv" value="">
                           <table>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.prebookpayammount"
                                       text="PAYMENT AMMT" />
                                    <span style="color: #ff0000;">*</span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="prebookingadvpayammt" value="" style="color:black" onkeypress='return isNumberKey(event)'></td>
                              </tr>
                           </table>
                           <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="advtblbookingadvpayalertMsg"></div>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:prebookadvancepay()"  class="btn btn-success">
                           <spring:message code="admin.advtblbookingmgnt.jsp.prebookpay" text="PAY" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- advance payment modal start -->
            <!--  Add new customer modal start -->
            <div class="modal fade" data-backdrop="static"
               id="PreBookCustDetailsModal" tabindex="-1" role="dialog"
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
                           <spring:message code="order.jsp.CustomerDetails"
                              text="Customer Details" />
                        </h4>
                     </div>
                     <div class="modal-body"
                        style="background: #404040; border-top: 1px solid #404040; color: #fff; width: 100%; padding: 5px;">
                        <div class="tab-content"
                           style="background: #404040; border-top: 10px solid #404040;">
                           <div id="home" class="tab-pane fade in active"
                              style="background: #404040;">
                              <!-- <div class="modal-category" style="background: #404040;color: #fff;"> -->
                              <div style="text-align: left; font-size: 18px;">
                                 <table align="center">
                                    <input type="hidden" id="PreBookCustDetailsId" value="">
                                    <tr>
                                       <td>
                                          <spring:message code="order.jsp.PHONENO"
                                             text="PHONE NO" />
                                          <span style="color: #ff0000;">*</span>
                                       </td>
                                       <td>:</td>
                                       <td><input type="text" id="PreBookCustDetailsPhone"
                                          maxlength="10" value=""
                                          style="margin-bottom: 2px; color: #222222; width: 95%;"
                                          autofocus="autofocus"
                                          onkeypress='return isNumberKey(event)' /></td>
                                    </tr>
                                    <tr>
                                       <td>
                                          <spring:message code="order.jsp.CUSTOMERNAME"
                                             text="CUSTOMER NAME" />
                                          <span style="color: #ff0000;">*</span>
                                       </td>
                                       <td>:</td>
                                       <td><input type="text" id="PreBookCustDetailsName"
                                          value=""
                                          style="margin-bottom: 2px; color: #222222; width: 95%;" /></td>
                                    </tr>
                                    <tr>
                                       <td>
                                          <spring:message code="order.jsp.ADDRESS"
                                             text="ADDRESS" />
                                       </td>
                                       <td>:</td>
                                       <td><textarea id="PreBookCustDetailsAddress" rows="2"
                                          style="margin-bottom: 2px; color: #222222; width: 95%;"></textarea>
                                       </td>
                                    </tr>
                                    <tr>
									   <td>STATE</td>
									   <td>:</td>
									   <td>
									     <select id="PreBookCustDetailsState" name="stateslist" style="margin-bottom: 2px; color: #222222; width: 95%;">
										<option value="" selected="">Select State</option>
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
                                 </table>
                                 <div
                                    style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
                                    id="PreBookCustDetailsModalalertMsg"></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="modal-footer"
                        style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
                        <%-- <button type="button" onclick="javascript:cancelCustomer()"
                           style="background: #F60; font-weight: bold; width: 25%"
                           class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="order.jsp.CANCEL" text="CANCEL" />
                           </button> --%>
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" onclick="javascript:addNewPreBookCustomer()" style="background: #72BB4F; font-weight: bold; width: 25%" class="btn btn-success">
                           <spring:message code="m.jsp.DONE" text="DONE" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!--  Add new customer modal end -->
            <!-- ADV BOOKING Cancellation modal start --> 
            <div class="modal fade" data-backdrop="static" id="prebookcancellationmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                     <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancelation" text="Booking Cancellation" />
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                        <div style="text-align: center;font-size: 20px;">
                           <input type="hidden" id="bookingOrderId" value="" >
                           <table>
                              <tr>
                                 <td>
                                    <spring:message code="admin.advtblbookingmgnt.jsp.cancelationreason"
                                       text="Reason" />
                                    <span style="color: #ff0000;"></span>
                                 </td>
                                 <td>:</td>
                                 <td><input type="text" id="changenoteContId" value="" style="color:black" ></td>
                              </tr>
                           </table>
                           <div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="advtblbookingcancellationalertMsg"></div>
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                        <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="admin.advtblbookingmgnt.jsp.cancel" text="CANCEL" />
                        </button>
                        <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="javascript:preOrderCancellation()"  class="btn btn-success">
                           <spring:message code="admin.cleanlog.jsp.ok" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- ADV BOOKING Cancellation modal end -->
            <!-- ADV BOOKING Cancellation success modal start -->
            <div class="modal fade" data-backdrop="static" id="successCancelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
                     <div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
                           <spring:message code="unpaidorder.jsp.Alert" text="Alert" />
                           !
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
                        <div style="text-align: center; font-size: 20px;">
                           Booking successfully cancelled.
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
                        <button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/advancebooking/loadadvancebooking.htm'">
                           <spring:message code="unpaidorder.jsp.OK" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- ADV BOOKING Cancellation success modal end -->
            <!-- ADV BOOKING Cancellation failure modal start -->
            <div class="modal fade" data-backdrop="static" id="failureModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
               <div class="modal-dialog" style="margin: 100px auto;">
                  <div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
                     <div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
                        <h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
                           <spring:message code="unpaidorder.jsp.Alert" text="Alert" />
                           !
                        </h4>
                     </div>
                     <div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
                        <div style="text-align: center; font-size: 20px;">
                           Booking is not cancelled. please try again.
                        </div>
                     </div>
                     <div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
                        <button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success">
                           <spring:message code="unpaidorder.jsp.OK" text="OK" />
                        </button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- ADV BOOKING Cancellation failure modal end -->
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
                           style="font-size: 18px; font-weight: bold;" id="myModalLabel">
                           <spring:message code="order.jsp.Alert" text="Alert" />
                        </h4>
                     </div>
                     <div class="modal-body"
                        style="background: #404040; border-top: 1px solid #404040; color: #fff;">
                        <div style="text-align: center; font-size: 20px;">
                           <input type="hidden" id="hiddmanualeditItemId" value="">
                           <spring:message code="order.jsp.Pleaseenteravalidnumber"
                              text="Please enter a valid number" />
                           !
                        </div>
                     </div>
                     <div class="modal-footer"
                        style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
                        <button type="button"
                           onclick="javascript:setOrderItemManualQty()"
                           style="background: #72BB4F; font-weight: bold;"
                           data-dismiss="modal" class="btn btn-success">
                           <spring:message code="order.jsp.OK" text="OK" />
                        </button>
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
                           style="font-size: 18px; font-weight: bold;" id="myModalLabel">
                           <spring:message code="order.jsp.Confirmation"
                              text="Confirmation" />
                           !
                        </h4>
                     </div>
                     <div class="modal-body"
                        style="background: #404040; border-top: 1px solid #404040; color: #fff;">
                        <input type="hidden" id="hidddeleteoperationid" value="">
                        <div style="text-align: center; font-size: 20px;">
                           <spring:message code="order.jsp.Areyousure" text="Are you sure" />
                           ?
                        </div>
                     </div>
                     <div class="modal-footer"
                        style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
                        <button type="button"
                           style="background: #F60; font-weight: bold; width: 25%;"
                           class="btn btn-warning" data-dismiss="modal">
                           <spring:message code="order.jsp.CANCEL" text="CANCEL" />
                        </button>
                        <button type="button" onclick="javacsript:deleteorderItemRow()"
                           style="background: #72BB4F; font-weight: bold; width: 25%;"
                           data-dismiss="modal" class="btn btn-success">
                           <spring:message code="order.jsp.OK" text="OK" />
                        </button>
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
                           style="font-size: 18px; font-weight: bold;" id="myModalLabel">
                           <spring:message code="order.jsp.Alert" text="Alert" />
                        </h4>
                     </div>
                     <div class="modal-body"
                        style="background: #404040; border-top: 1px solid #404040; color: #fff;">
                        <div style="text-align: center; font-size: 20px;">
                           <spring:message code="order.jsp.Pleaseaddanyitems"
                              text="Please add any items!" />
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
            <!-- modals part end -->
            
            <!--Bill Part start  -->
            <!--Bill Sixe 58 Start  -->
<div class="modal fade" data-backdrop="static" id="helloPrintModal58"
   tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
   aria-hidden="true" style="display: none;">
   <div class="modal-dialog" style="width: 200px; height: auto;">
      <div class="modal-body" id="printDiv58"
         style="background: #ffffff; border-top: 1px solid #ffffff; color: #fff; padding: 4px !important;">
         <div
            style="text-align: center; height: auto; font-size: 20px; color: #000000; word-wrap: break-word; width: 170px;">
             <b>
               <font style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
                  <div id="storeName58"></div>
               </font>
            </b>
            <b>
               <font
                  style="font-size: 10px; font-style: normal; font-family: sans-serif;">
                  <div id="storeAddr58"></div>
               </font>
            </b>
            <font
               style="font-size: 12px; font-style: inherit; font-family: sans-serif;">
               <div id="storeName58"></div>
            </font>
            <font
               style="font-size: 10px; font-style: normal; font-family: sans-serif;">
               <div id="storeAddr58"></div>
            </font>
            <br>
            
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
                     AMOUNT:
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
                     id=totalAmt58>00</span></td>
               </tr>
               <tr id="totalServiceChrg_58">
                  <td
                     style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
                     Service Charge:
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
                     id="servChrg58">00</span></td>
               </tr>
               <tr id="totalServiceTax_58">
                  <td
                     style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
                     Service Tax:
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
                     id="servTax58">00</span></td>
               </tr>
               <tr id="totalVatTax_58">
                  <td
                     style="font-size: 11px; font-weight: bold; font-family: sans-serif;">Total
                     Vat:
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
                     id="vatTax58">00</span></td>
               </tr>
               <tr>
                  <td><b><span
                     style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Gross
                     Amount:</span></b>
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
                     id="grossAmount58">00</span></b></td>
               </tr>
               <tr id="showDiscount_58">
                  <td
                     style="font-size: 11px; font-weight: bold; font-family: sans-serif;">
                     TOTAL DISCOUNT :
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><span
                     id="discountValue58">00</span></td>
               </tr>
               <tr>
                  <td><b><span
                     style="font-weight: bold; font-size: 12px; font-family: sans-serif;">AMOUNT
                     TO PAY:</span></b>
                  </td>
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
                     Amount:</span></b>
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
                     id="paidAmount58">00</span></b></td>
               </tr>
               <tr>
                  <td><b><span
                     style="font-weight: bold; font-size: 11px; font-family: sans-serif;">Tender
                     Amount:</span></b>
                  </td>
                  <td
                     style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
                     id="tenderAmount58">00</span></b></td>
               </tr>
               <tr>
                  <td><b><span
                     style="font-weight: bold; font-size: 11px; font-family: sans-serif;">Refund
                     Amount:</span></b>
                  </td>
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
               <b>
                  <font style="font-size: 12px; font-family: sans-serif;">
                     <div
                        id="payType58"></div>
                  </font>
               </b>
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
       <!--Bill Size 58 end  -->
       <!--Bill Size 80 start -->
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
									style="font-weight: bold; font-size: 12px; font-family: sans-serif;">Bill
										Amount:</span></b></td>
							<td style="font-size: 11px; font-weight: bold; font-family: sans-serif;">${sessionScope.loggedinStore.currency}
							   </td>
							<td
								style="text-align: right; font-size: 11px; font-family: sans-serif;"><b><span
									id="cashgrossAmount80">00</span></b></td>
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

						

						<tr style="display:none;">
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
       <!--Bill Size 80 end  -->
       <!--Bill Size 2100 start  -->
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
								</div>
							</div>

							<div style="float: left; margin-bottom: 5%;"
								id="orderitemContId_2100_GST">
								<table
									style="text-align: center; border-collapse: collapse;"
									id="orderItemTbl">
									<thead>
										<tr style="border-bottom: 1px dashed;">
											<th width="5%;"><spring:message
													code="reprintcash.jsp.invno" text="SNo" /></th>
											<th width="30%;"><spring:message code="item.jsp.name"
													text="Item Name" /></th>
											<th><spring:message code="purinvdet.jsp.mfg" text="HSN" />/</th>&nbsp;
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
									 <tr>
									<td width="50%"><b><span style="font-weight: bold; font-size: 15px; font-family: sans-serif;">Payment Mode:</span></b></td>
									<td width="50%" style="float: right; padding-right: 40px; text-align: center; font-size: 14px; font-family: sans-serif;">
									   <b><span id="paymentmode_paidbill_2100px"></span></b></td>
								 </tr>
								
								
							</table>
						</div>

						<div style="text-align: center; margin-top: 30px;">
							<font
								style="font-size: 16px; font-family: sans-serif; color: black;">*****Thank
								You. Visit us Again*****</font>
						</div>
						
					</div>
				</div>
			</div>
        <!-- </div>
	</div> -->
       <!--Bill Size 2100 end  -->
       
       <!--Bill Part End  -->
            
            <div class="modal fade" data-backdrop="static"
			id="alertModal" tabindex="-1" role="dialog"
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
							  Please Select Items In Order For Print Bill
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
		
		
   </div>
</div>
      <!-- CONTENT-WRAPPER SECTION END-->
      <!-- FOOTER SECTION END-->
      <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
      <script src="${pageContext.request.contextPath}/assets/js/advancebookingScript.js"></script>
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
         var displayCurrentStockMenu="${sessionScope.loggedinStore.displayCurrentStockMenu}";
         var storeID="${sessionScope.loggedinStore.id}";
         var serviceChargeFlag="${sessionScope.loggedinStore.serviceChargeFlag}";
         var ordertypebasedscharge=0;
         var mobPrintVal="${sessionScope.loggedinStore.mobBillPrint}";
         var printbillpapersize="${sessionScope.loggedinStore.printBillPaperSize}";
         var gsttext = "${sessionScope.loggedinStore.gstText}";
         var gstno = "${sessionScope.loggedinStore.gstRegNo}";
         var parcelAdd="${sessionScope.loggedinStore.parcelAddress}";
         var storeAddr = "${sessionScope.loggedinStore.address}";
         
         
         
         
        /*  var tables='${tables}'; */
         var orderTypes='${orderTypes}';
         $(document).ready(function() {
         
          var date = new Date();
          date.setDate(date.getDate()+1);
         $('#advbookingdate').datepicker({
         format : "yyyy-mm-dd",
         autoclose : true,
         endDate: '+1m', // for diactive future dates			
         startDate: date  // for diactive past dates
         
         });	
         $('#editadvbookingdate').datepicker({
         format : "yyyy-mm-dd",
         autoclose : true,
         endDate: '+1m',
         startDate: date
         });	
         
         });
         function checkOrderType(ordertypevalue,id){
         // alert(ordertypevalue+"----"+id);
               if(ordertypevalue!=0){
            	   if(id == 1){
            	          $("#itemCodeSearch").removeAttr('disabled');
            	         }
            	          /* else{
            	           $("#edititemCodeSearch").removeAttr('disabled');
            	          } */
                }
         
         
               var ordertypevalues = ordertypevalue.split("_");
               if(ordertypevalues[1]!=0){
         	   ordertypebasedscharge=ordertypevalues[1];
         	      if(serviceChargeFlag == 'Y'){
         	       document.getElementById("schargevalue").innerHTML=ordertypevalues[1];
         	       }
         	   }
               else{
         	   ordertypebasedscharge=0.0;
         	      if(serviceChargeFlag == 'Y'){
         	        document.getElementById("schargevalue").innerHTML=0.0;
         	      }
               }
         }
         
         
         function showalerteditOrderQuantityModal(id)
         {
         document.getElementById('hiddmanualeditItemId').value=id;
         	$('#alerteditOrderquantityModal').modal('show');
         }
         
         
         function isNumberKey(evt){
           var charCode = (evt.which) ? evt.which : evt.keyCode;
           if (charCode > 31 && (charCode < 48 || charCode > 57))
               return false;
           return true;
         }
         function closeadvanceTableBookingModal()
         {
         $('#advtblbookingAddModal').modal('hide');
         }
         
         function showadvanceTableBookingModal()
         {
           document.getElementById('addOrderType').value='0';
          	//document.getElementById('TableId').value=0;
         document.getElementById('advbookingtime').value='';
         document.getElementById('advbookingcustname').value='';
         document.getElementById('advbookingcustcontact').value='';
         document.getElementById('advbookingcustlocation').value='';
         document.getElementById('advbookingcustaddress').value='';
         document.getElementById('advbookingcustnoofperson').value='';
         document.getElementById('addadvtblbookingalertMsg').innerHTML='';
         $("#billtbl").hide();
         document.getElementById('addadvtblbookingitems').innerHTML='';
         document.getElementById('advbookingdate').value='';
         
         document.getElementById('subtotalcontId').innerHTML='';
         //document.getElementById('schrgId').innerHTML='';
         //document.getElementById('vatcontId').innerHTML='';
         //document.getElementById('servicetaxcontId').innerHTML='';
         document.getElementById('grandtotalcontId').innerHTML='';
         document.getElementById('amttopaycontId').innerHTML='';
        // $("#itemCodeSearch").attr('disabled','disabled');
         $('#addadvtblbookingitems').css("height", '');
         
         $('#advtblbookingAddModal').modal('show');
         }
         
         
         /* function showadvtblbookingeditModal(id, tableno, bookingdate, bookingtime, custname,custcontact,custaddress,noofperson,location,customerid) {
           document.getElementById('editadvtblbookingalertMsg').innerHTML = '';
           document.getElementById('editadvbookingid').value = id;		  
           document.getElementById('editadvbookingdate').value = bookingdate;
           document.getElementById('editadvbookingtime').value = bookingtime;
           document.getElementById('editadvbookingcustid').value = customerid; 
           document.getElementById('editadvbookingcustname').value = custname;
           document.getElementById('editadvbookingcustcontact').value = custcontact;
          // document.getElementById('editadvbookingcustemail').value = custemail;
           document.getElementById('editadvbookingcustaddress').value = custaddress;
           document.getElementById('editadvbookingcustnoofperson').value = noofperson;
           document.getElementById('editadvbookingcustlocation').value = location; 
           
                               var tableNameArray=[];
         				   var tableIdArray=[];
         				   var tableData="";
         				   var tblData="";
         				     <c:forEach items="${tableList}" var="tableData" varStatus="loop">
         				     tableNameArray.push('${tableData.tableNo}');
         				     tableIdArray.push('${tableData.tableNo}');
         				   </c:forEach>  
         				  
         				   tblData="<option value='"+0+"'> Select Table</option>";		   
         				   for(var i=0;i<tableNameArray.length;i++)
         					   {
         					   console.log(tableNameArray[i]);
         					   if(tableNameArray[i]!=tableno){
         						   tableData+="<option value='"+tableIdArray[i]+"'>"+tableNameArray[i]+"</option>";
         
         					   }
         					   if(tableNameArray[i]==tableno){
         						   tableData+="<option value='"+tableIdArray[i]+"' selected='selected'>"+tableNameArray[i]+"</option>";
         
         					   }
         					   }
         				   var tableDatafinal=tblData+tableData;
         				   document.getElementById('editTableId').innerHTML=tableDatafinal;
          $('#advtblbookingEditModal').modal('show');
          }
         */
         
         
         
         function formatDate(date) {
         var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
         	+ d.getDate(), year = d.getFullYear();
         
         if (month.length < 2)
         month = '0' + month;
         if (day.length < 2)
         day = '0' + day;
         
         return [ year, month, day ].join('-');
         }
         
         function showalertcatdataopModal()
         {
         $('#alertcatdataopModal').modal('show');
         }
         
         function closeadvtblbookingeditModal()
         {
         $('#advtblbookingEditModal').modal('hide');
         }
         function showconfirmdeleteOrderItemModal()
         {
         $('#confirmdeleteorderitemModal').modal('show');
         }
         function showConfirmdeleteadvtblbookingModal(id)
         {
          document.getElementById('moddeleteconfirmadvtblbookingidContId').value=id;
          $('#confirmdeleteadvtblbookingModal').modal('show');
         }
         function showselectitemalertModal()
         {
         $('#alertselectItemModal').modal('show');
         }
         function showDetailadvtblbookingModal(id, tableno, bookingdate, bookingtime, custname,custcontact,custaddress,noofperson,location,storebaseorderno)
         {
         
          document.getElementById('moddetailadvbookingid').innerHTML = storebaseorderno;
          document.getElementById('moddetailTableId').innerHTML = tableno;
          document.getElementById('moddetailadvbookingdate').innerHTML = bookingdate;
          document.getElementById('moddetailadvbookingtime').innerHTML = bookingtime;
          document.getElementById('moddetailadvbookingcustname').innerHTML = custname;
          document.getElementById('moddetailadvbookingcustcontact').innerHTML = custcontact;
          //document.getElementById('moddetailadvbookingcustemail').innerHTML = custemail;
          document.getElementById('moddetailadvbookingcustaddress').innerHTML = custaddress;
          document.getElementById('moddetailadvbookingnoofperson').innerHTML = noofperson;
          document.getElementById('moddetailadvbookingcustlocation').innerHTML = location; 
            
             $('#advtblbookingDetailModal').modal('show');
         }
         
         
         
         
         $(function() {
             $("#advbookingcustname")
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
                                                    $("#advbookingcustid").val('');
                                                    $("#advbookingcustcontact").val('');
                                                    $("#advbookingcustaddress").val('');
                                                    $("#advbookingcustlocation").val('');
                                                    $("#advbookingcuststate").val('');
                                                    if(data==null){
                                                                  }
                                                    else{
                                                        console.log("in else");
                                                        response($.map(
                                                        custname,
                                                                      function(v) {
                                                                          return {
                                                                              label : v.name,
                                                                              phno:v.contactNo,
                                                                              addr:v.address,
                                                                              location:v.location,
                                                                              custId:v.id,
                                                                              state:v.state,
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
                                         $("#advbookingcustname").val(ui.item.label);
                                         $("#advbookingcustid").val(ui.item.custId);
                                         $("#advbookingcustcontact").val(ui.item.phno);
                                         $("#advbookingcustaddress").val(ui.item.addr);
                                         $("#advbookingcustlocation").val(ui.item.location);
                                         $("#advbookingcuststate").val(ui.item.state);
                                
                                  }
                               	                            
                             })
           }); 
         
         
         $(function() {
         
             $("#advbookingcustcontact")
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
                                              	 
                                                         custname=JSON.parse(data);
                                                         console.log(custname);
                                                         $("#advbookingcustid").val('');
                                                         $("#advbookingcustname").val('');
                                                         $("#advbookingcustaddress").val('');
                                                         $("#advbookingcustlocation").val('');
                                                         $("#advbookingcuststate").val('');
                                                         if(data==null){
                                                                       }
                                                         else{
                                                             console.log("in else");
                                                             response($.map(
                                                             custname,
                                                                           function(v) {
                                                                               return {
                                                                                   label:v.contactNo,
                                                                                   name:v.name,
                                                                                   addr:v.address,
                                                                                   custId:v.id,
                                                                                   location:v.location,
                                                                                   state:v.state,
                                                                                  
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
                              	   $("#advbookingcustname").val(ui.item.name);
                                     $("#advbookingcustid").val(ui.item.custId);
                                     $("#advbookingcustcontact").val(ui.item.label);
                                     $("#advbookingcustaddress").val(ui.item.addr);
                                     $("#advbookingcustlocation").val(ui.item.location);
                                     $("#advbookingcuststate").val(ui.item.state);
                                  }
                                 
                             })
         
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
                                                                  	   if(displayCurrentStockMenu=='Y'){
                                                                  		   return {
                                                                       	   label : v.name,
                                                                              itemCode : v.id,
                                                                              //tagCode : v.tagCode
                                                                              items:v,
                                                                          };
                                                                  	   }else{
                                                                  		   return {
                                                                       	   label : v.name,
                                                                              itemCode : v.id,
                                                                              //tagCode : v.tagCode
                                                                              items:v,
                                                                          };
                                                                  	   }
         
         
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
                              	   additemtoOrder(ui.item.items.id,ui.item.items.name,ui.item.items.price,disc,ui.item.items.vat,ui.item.items.serviceTax,ui.item.items.promotionFlag,ui.item.items.promotionValue,ui.item.items.isKotPrint,1);
         
                                 }
                             });
         
             $("#edititemCodeSearch")
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
                                                                  	   if(displayCurrentStockMenu=='Y'){
                                                                  		   return {
                                                                       	   label : v.name,
                                                                              itemCode : v.id,
                                                                              //tagCode : v.tagCode
                                                                              items:v,
                                                                          };
                                                                  	   }else{
                                                                  		   return {
                                                                       	   label : v.name,
                                                                              itemCode : v.id,
                                                                              //tagCode : v.tagCode
                                                                              items:v,
                                                                          };
                                                                  	   }
         
         
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
                              	   additemtoOrder(ui.item.items.id,ui.item.items.name,ui.item.items.price,disc,ui.item.items.vat,ui.item.items.serviceTax,ui.item.items.promotionFlag,ui.item.items.promotionValue,ui.item.items.isKotPrint,2);
         
                                 }
                             });
         });
         
         
         
         
      </script>
      <script type="text/javascript"></script>
      
   </body>
</html>