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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Unpaid Order :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    <style type="text/css">
    .selected{
    background-color: #ffe4c1 !important;
    }
    </style>
    <script>
	function rowClicked(){
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
<body onload="javascript:noUnpaidOrders(${allunpaidOrderList.size()})" style="background-color: #e9e9e9;">
 <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
    <div class="container-fluid">
			
    <div class="row">
		<div class="col-md-4 col-sm-4">
		     <div style="overflow-y:auto; padding:2px;max-height:400px;" >
             <div class="panel panel-default" >
				<div class="panel-body" >
                <div style="padding:3px;">
                	<div class="table-responsive">
             		<table class="table table-striped table-bordered table-condensed" id="ordertableId" >
                    	<thead>
                        	<th style="text-align:center;">
                            	SL NO
                            </th>
                            <th>
                            	ORDER NO
                            </th>
                            <th class="hide">
                            	TABLE NO
                            </th>
                            <th>
                            	ORDER TIME
                            </th>
                            <c:if test="${sessionScope.loggedinStore.parcelAddress=='Y'}">
                            <th>
                            	DEL. DETAILS
                            </th>
                            </c:if>
                        </thead>
                        <tbody>
                        	<c:if test="${! empty allunpaidOrderList}">
                        		<c:forEach items="${allunpaidOrderList}" var="unpaidOrders" varStatus="stat">
                        			<tr style="cursor: pointer;" id="tr_${unpaidOrders.id}" class="unpaid-order-row" class="unpaid-order-row">
                            			<td id="td_id" style="text-align:center;" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${stat.index+1}</td>
                                		<td id="td_id" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${unpaidOrders.orderNo}</td>
                               		<td class="hide" valign="middle" align="center" onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">
                                		<c:choose> 
                               			<c:when test="${unpaidOrders.ordertype.id==2}"> 
                                				PARCEL 
                                			</c:when> 
                                			<c:when test="${unpaidOrders.ordertype.id==1}"> 
                                 			HOME DELIVERY 
                               			</c:when> 
                                			<c:otherwise> 
                                				${unpaidOrders.table_no}
                                			</c:otherwise> 
                                		</c:choose> 
                                 		</td> 
                                		<c:set var="ordtime" value="${fn:substring(unpaidOrders.orderTime, 11, 19)}" />
                                		<td onclick="javascript:getunpaidOrderById(${unpaidOrders.id})">${ordtime}</td>
                                		<c:if test="${sessionScope.loggedinStore.parcelAddress=='Y'}">
                                		<td align="center">
<%--                                  		<c:out value="${unpaidOrders}"></c:out>
 --%>                                 		<c:choose>
<%--  										<c:if test="${table_no=='0' && fn:containsIgnoreCase(sessionScope.loggedinStore.parcelVat,'N')}">
 --%>                                			<c:when test="${unpaidOrders.ordertype.id!=3 && (unpaidOrders.customerName!='' || unpaidOrders.customerContact!='' || unpaidOrders.location!='' || unpaidOrders.deliveryAddress!='' || unpaidOrders.deliveryPersonName!='' || unpaidOrders.houseNo!='' || unpaidOrders.street!='')}" >
                                			<a href="javascript:showdeliveryDetailModal('${unpaidOrders.customerName}','${unpaidOrders.customerContact}','${unpaidOrders.location}','${unpaidOrders.deliveryAddress}','${unpaidOrders.deliveryPersonName}','${unpaidOrders.houseNo}','${unpaidOrders.street}')"><img src="/restwebposlite/assets/images/header/info_btn.png" style="height: 22px;"></a>
                                				<%-- <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png" data-toggle="tooltip" data-html="true" data-placement="top" title="Customer Name:${unpaidOrders.customerName}</br>Phone No:${unpaidOrders.customerContact}</br>Del. Adress:${unpaidOrders.deliveryAddress}</br>Delivery Person:${unpaidOrders.deliveryPersonName}"> --%>
                                			</c:when>
                                			<c:otherwise>
                                				N/A
                                			</c:otherwise>
                                		</c:choose>
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
             </div>
             
		</div>
		
        <div class="col-md-8 col-sm-8">
		     <div>
             	<div class="col-md-12 col-sm-12">
             	<c:if test="${! empty allunpaidOrderList}">
             		<c:forEach items="${allunpaidOrderList}" var="unpaidorder" end="0">
                		<div class="col-md-6 col-sm-6" style="font-weight:bold;">
                			ORDER NO&nbsp;<font color="#00CC33;"><span id="unpaidordernocontId" style="display:none;">${unpaidorder.id}</span><span id="unpaidStoreBaseordernocontId">${unpaidorder.orderNo}</span></font>
<!--                 			&nbsp;TABLE NO&nbsp; -->
                			<font color="#00CC33;"><span class="hide" id="unpaidordertablenocontId">${unpaidorder.table_no}</span></font>
                		</div>
                		<div class="col-md-6 col-sm-6" style="font-weight:bold;">
                			<a href="javascript:showCancelOrderModal()" class="btn-unpaid-order" style="background: #D9534F;width: auto;margin-bottom: 3px;padding: 6px;">Cancel Order</a>
                				<!-- Remarks
                				<select id="changenoteContId" style="color:#000; width: 75px;">
                					<option value="Misc">Misc</option>
                					<option value="BadFood">BadFood</option>
                				</select> -->
                	<spring:message code="unpaidorder.jsp.Reason" text="Reason" /><input type="text" style="color:black;" id="changenoteContId" value=""/>
                				
                				
                				
                		</div>
                	</c:forEach>
                </c:if>
               
                </div>
                <div class="col-md-12 col-sm-12">
					<div style="overflow-y:auto; padding:2px;">
                		<div class="panel panel-default">
							<div class="panel-body" style="max-height:400px;">
                				<div class="table-responsive" id="unpaidordertableContId">
             						<table class="table table-striped table-bordered" >
                    					<thead>
                        					<th>SL</th>
                            				<th>NAME</th>
                            				<th class="hide">ORDER TYPE</th>
                            				<th style="text-align:center;">QUANTITY</th>
                            				<th style="text-align:center;">TOTAL</th>
                            				<th style="text-align:center;">DISCNT</th>
                            				<th style="text-align:center;">RATE</th>
                            				<th style="text-align: center;">REASON</th>
                            				
                            				<th></th>
                        				</thead>
                        				<tbody >
                        				<c:if test="${! empty allunpaidOrderList}">
                        				<c:forEach items="${allunpaidOrderList}" var="unpaidOrder" end="0">
                        					<c:forEach items="${unpaidOrder.orderitem}" var="orderitems" varStatus="stat">
                        					<tr>
                            					<td>${stat.index+1}</td>
                                				<td style="word-wrap:break-word;">${orderitems.item.name}</td>
                                				<td class="hide">
                                				<c:choose>
                                					<c:when test="${orderitems.ordertype==2}">
                                					PARCEL
                                					</c:when>
                                					<c:otherwise>
                                					DINE IN
                                					</c:otherwise>
                                				</c:choose>
                                				</td> 
                                				<td valign="middle" align="center" style="padding: 1px;width:110px;!important">
                                					<a href="javascript:decreaseItemQuantity(${orderitems.id},${orderitems.rate},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})" >
                                    					<img border="0" height="24" width="24" alt="" src="${pageContext.request.contextPath}/assets/images/base/d/d_delete.png">
                                        			</a>
                                    				<input type="text" size="1" id="inputqty${orderitems.id}" onkeyup="javascript:enterManualQuantity(this.value,${orderitems.id},${orderitems.rate},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})" value="${orderitems.quantityOfItem}" style="text-align:center;width:28px;">
                                    				<a href="javascript:increaseItemQuantity(${orderitems.id},${orderitems.rate},'${orderitems.item.promotionFlag}',${orderitems.item.promotionValue})" >
                                    					<img border="0" height="24" width="24"  alt="" src="${pageContext.request.contextPath}/assets/images/base/d/d_add.png">
                                        			</a>
                                				</td>
                                				<td style="text-align:center;" id="tdtotal${orderitems.id}">
                                				<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.rate*orderitems.quantityOfItem}"></fmt:formatNumber>
                                				</td>
                                				<td style="text-align:center;" id="tddisc${orderitems.id}">
                                					<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'Y') }">
                                					<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${(orderitems.rate*orderitems.item.promotionValue/100)*orderitems.quantityOfItem}"></fmt:formatNumber>
                                					</c:if>
                                					<c:if test="${fn:containsIgnoreCase(orderitems.item.promotionFlag, 'N') }">0.00</c:if>
                                				</td>
                                				<td style="text-align:center;">
                                				<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${orderitems.rate}"></fmt:formatNumber>
                                				</td>
                                				<td style="text-align: center;"><input type="text" style="color:black;" id="itemcancelreason${orderitems.id}" value=""/> <input type='hidden' id='itemorderedqty${orderitems.id}' value="${orderitems.quantityOfItem}"/></td>
                                				
                                				<td style="text-align:center;">
                                					<a href="#" onclick="javascript:updateUnpaidOrder(${orderitems.rate},${orderitems.id},${orderitems.item.id},${unpaidOrder.id})" id="updatebut${orderitems.id}" class="btn-unpaid-order">UPDATE</a>
                                				</td>
                           					 </tr>
                           					 	</c:forEach>
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
       </div>
       <!-- modal starts -->
       
       <div class="modal fade" data-backdrop="static" id="nounpaidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            There is no unpaid orders!!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="location.href='${pageContext.request.contextPath}/order/vieworder.htm?ono=0&tno=0&sno=0'" style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
        <div class="modal fade" data-backdrop="static" id="confirmcancelOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Confirmation!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	Are you sure?
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
                                            <button type="button" onclick="javacsript:cancelUnpaidOrder()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alerteditunpaidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Please enter a valid number!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                           <!--  <div class="modal fade" data-backdrop="static" id="alerteditunpaidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Please enter a valid reason!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                            
                            
                            <div class="modal fade" data-backdrop="static" id="itemQtyChangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
								Please enter a valid reason!!
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
                            
                            
                <div class="modal fade" data-backdrop="static" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
								Item successfully updated.
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
								Order successfully cancelled.
							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" style="background: #72BB4F; font-weight: bold;" data-dismiss="modal" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/unpaidorder/viewunpaidorder.htm'">
								<spring:message code="unpaidorder.jsp.OK" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>            
                            
                            
                            
                            <div class="modal fade" data-backdrop="static" id="deliveryDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Delivery Details</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr id="moddeliverydetailcustnameTr">
                                            			<td style="padding: 5px 0px;">CUSTOMER NAME</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetailcustnameTd"></td>
                                            		</tr>
                                            		<tr id="moddeliverydetailphonenoTr">
                                            			<td style="padding: 5px 0px;">PHONE NO</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetailphonenoTd"></td>
                                            		</tr>
                                            		<tr  id="moddeliverydetailcustLocationTr">
                                            			<td style="padding: 5px 0px;">LOCATION</td>
                                            			<td width="5%">:</td>
                                            			<td  id="moddeliverydetailcustlocationTd"></td>
                                            		</tr>
                                            		<tr id="moddeliverydetailcustaddressTr">
                                            			<td style="padding: 5px 0px;">CUSTOMER ADDRESS</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetailcustaddressTd"></td>
                                            		</tr>
                                            		<tr id="moddeliverydetaildeliverymanTr">
                                            			<td style="padding: 5px 0px;">DELIVERY PERSON</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetaildeliverymanTd"></td>
                                            		</tr >
                                            			<tr id="moddeliverydetailhousenoTr">
                                            			<td style="padding: 5px 0px;">HOUSE NO</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetailhousenoTd"></td>
                                            		</tr>
                                            			<tr id="moddeliverydetailstreetTr">
                                            			<td style="padding: 5px 0px;">STREET NO</td>
                                            			<td width="5%">:</td>
                                            			<td id="moddeliverydetailstreetTd"></td>
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal">OK</button>
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
    <script src="${pageContext.request.contextPath}/assets/js/unpaidorderScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	
  <script type="text/javascript">
  var BASE_URL="${pageContext.request.contextPath}";
  $('.unpaid-order-row').on('click',function(){
	  $(this).parent().find('.unpaid-order-row').removeClass('selected');
		$(this).addClass('selected');
  });
  /* $('#ordertableId tbody tr').on('click',function(e){
	  $(this).closest('table').find('td').removeClass('selected');
		$(this).find('td').addClass('selected');
		//e.stopPropagation();
  }); */
  </script>
  <script type="text/javascript">
  function shownounpaidOrderModal()
	{
		$('#nounpaidOrderModal').modal('show');
	}
  function showCancelOrderModal()
  	{
	  	$('#confirmcancelOrderModal').modal('show');
  	}
  function showalerteditUnpaidOrderModal()
	{
	  	$('#alerteditunpaidOrderModal').modal('show');
	}
  function showdeliveryDetailModal(custname,phoneno,location,custaddress,deliveryman,houseno,streetno)//,houseno,streetno,location
  {
	//  document.getElementById('moddeliverydetailcustnameTd').innerHTML=custname;
	//  document.getElementById('moddeliverydetailphonenoTd').innerHTML=phoneno;
	//  document.getElementById('moddeliverydetailcustaddressTd').innerHTML=custaddress;
	//  document.getElementById('moddeliverydetaildeliverymanTd').innerHTML=deliveryman;
	 // document.getElementById('moddeliverydetailhousenoTd').innerHTML=houseno;
	//  document.getElementById('moddeliverydetailstreetTd').innerHTML=streetno;
	 
	  if(location.length=="0")
	  {
		
			//document.getElementById('moddeliverydetailcustLocationTr').style.display = 'none';

		  $("#moddeliverydetailcustLocationTr").hide();
	  }
	  else{
		  $("#moddeliverydetailcustLocationTr").show();
		//	document.getElementById('moddeliverydetailcustLocationTr').style.display = 'block';
		  document.getElementById('moddeliverydetailcustlocationTd').innerHTML=location; 

	  }
	  
	  if(streetno.length=="0")
	  {
		

		  $("#moddeliverydetailstreetTr").hide();
	  }
	  else{
		  $("#moddeliverydetailstreetTr").show();
		  document.getElementById('moddeliverydetailstreetTd').innerHTML=streetno; 

	  }
	  
	  if(houseno.length=="0")
	  {
		

		  $("#moddeliverydetailhousenoTr").hide();
	  }
	  else{
		  $("#moddeliverydetailhousenoTr").show();
		  document.getElementById('moddeliverydetailhousenoTd').innerHTML=houseno; 

	  }
	  if(custaddress.length=="0")
	  {
		

		  $("#moddeliverydetailcustaddressTr").hide();
	  }
	  else{
		  $("#moddeliverydetailcustaddressTr").show();
		  document.getElementById('moddeliverydetailcustaddressTd').innerHTML=custaddress; 

	  }
	  if(deliveryman.length=="0")
	  {
		

		  $("#moddeliverydetaildeliverymanTr").hide();
	  }
	  else{
		  $("#moddeliverydetaildeliverymanTr").show();
		  document.getElementById('moddeliverydetaildeliverymanTd').innerHTML=deliveryman; 

	  } //moddeliverydetailcustnameTd
	  
	  if(custname.length=="0")
	  {
		

		  $("#moddeliverydetailcustnameTr").hide();
	  }
	  else{
		  $("#moddeliverydetailcustnameTr").show();
		  document.getElementById('moddeliverydetailcustnameTd').innerHTML=custname; 

	  }
	  if(phoneno.length=="0")
	  {
		

		  $("#moddeliverydetailphonenoTr").hide();
	  }
	  else{
		  $("#moddeliverydetailphonenoTr").show();
		  document.getElementById('moddeliverydetailphonenoTd').innerHTML=phoneno; 

	  }

	  $('#deliveryDetailModal').modal('show');
  }
  </script>
  
</body>
</html>
