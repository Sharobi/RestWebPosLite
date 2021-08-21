<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> --%>
    <%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
        <![endif]-->
    <title>:. POS :: Vendor Payment :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   
   <style type="text/css">
    /* .selected{
    background-color: #E4E5E8 !important;
    } */
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
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">VENDOR PAYMENT</div> 
                </div>
                <div class="col-md-7 col-sm-7">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">VENDOR NAME : <span id="creditvendornameContId" style="color:#00CC33; ">${vendorDetail.name}</span> CONTACT NO : <span id="creditvendorcontactContId" style="color:#00CC33;">${vendorDetail.contactNo}</span></div>
                    <input type="hidden" id="creditvendoridContId" value="${vendorDetail.id}"> 
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div class="col-md-5 col-sm-5">
                  <div style="max-height: 500px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover" id="creditvendortableContId">
                                    <thead style="background:#404040; color:#FFF;">
                                            <th style="text-align:center;">VENDOR NAME</th>
                                            <th style="text-align:center;">VENDOR CONTACT</th>
                                            <th style="text-align:center;">VENDOR ADDRESS</th>
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty vendorList }">
                                    		<c:forEach items="${vendorList}" var="creditvendor">
                                    			<tr style="cursor:pointer;background:#404040; color:#FFF;" onclick="javascript:getcreditInvinvoiceByvendorId(${creditvendor.id},&quot;${creditvendor.name}&quot;,${creditvendor.contactNo})">
                                    				<td>${creditvendor.name}</td>
                                    				<td align="center">${creditvendor.contactNo}</td>
                                    				<td>${creditvendor.address}</td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty vendorList}">
                                        	<tr>
                                        		<td colspan="3">No Data found!</td>
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
                            		<div class="table-responsive" style="background:#404040;" id="creditinvinvoicetableContId">
                                		<table class="table table-striped table-bordered table-hover">
                                    		<thead style="background:#404040; color:#FFF;">
                                            	<th style="text-align:center;">INVOICE NO</th>
                                            	<th style="text-align:center;">DATE</th>
                                            	<th style="text-align:center;">BILL AMT</th>
                                            	<th style="text-align:center;">PAID AMT</th>
                                            	<th style="text-align:center;display:none;">RET AMT</th>
                                            	<th style="text-align:center;">DUE AMT</th>
                                            	<th style="text-align:center;">PAY</th>
                                    		</thead>
                                    		<tbody>
                                    		<c:if test="${! empty invInvoiceList }">
                                    			<c:set var="totBillAmt" value="0.0"></c:set>
                                    			<c:set var="totAmttoPay" value="0.0"></c:set>
                                    			<c:set var="totPaidAmt" value="0.0"></c:set>
                                    			<c:set var="totRetAmt" value="0.0"></c:set>
                                    			<c:forEach items="${invInvoiceList}" var="creditinvinvoice">
                                    				<tr style="background:#404040; color:#FFF;">
                                    					<td align="center">${creditinvinvoice.stockInId}</td>
                                    					<td align="center">${creditinvinvoice.stockInDate}</td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditinvinvoice.billAmount}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditinvinvoice.paidAmount}"/></td>
                                    					<td align="center" style="display:none;"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditinvinvoice.returnAmount}"/></td>
                                    					<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${creditinvinvoice.amountToPay}"/></td>
                                    					<td align="center"><a href="javascript:opencr_vendorCashModal(${creditinvinvoice.stockInId},${creditinvinvoice.poId},&quot;${creditinvinvoice.stockInDate}&quot;,${creditinvinvoice.billAmount},${creditinvinvoice.paidAmount},${creditinvinvoice.amountToPay})" class="btn btn-success">PAY</a></td>
                                    				</tr>
                                    				<c:set var="totBillAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt+creditinvinvoice.billAmount}"/></c:set>
                                    				<c:set var="totAmttoPay"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totAmttoPay+creditinvinvoice.amountToPay}"/></c:set>
                                    				<c:set var="totPaidAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt+creditinvinvoice.paidAmount}"/></c:set>
                                    				<c:set var="totRetAmt"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totRetAmt+creditinvinvoice.returnAmount}"/></c:set>
                                    			</c:forEach>
                                    			<c:if test="${invInvoiceList.size()>1}">
                                    			<tr style="background:#e2e2e2; color:#222222;">
                                    				<td colspan="2" align="center">TOTAL</td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totBillAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totPaidAmt}"/></td>
                                    				<td align="center" style="display:none;"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totRetAmt}"/></td>
                                    				<td align="center"><fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${totAmttoPay}"/></td>
                                    				<td align="center"><a href="javascript:opentotcr_vendorCashModal(${totBillAmt},${totPaidAmt},${totAmttoPay})" class="btn btn-success">PAY</a></td>
                                    			</tr>
                                    			</c:if>
                                    		</c:if>
                                        	<c:if test="${empty invInvoiceList}">
                                        		<tr style="background:#404040; color:#FFF;">
                                        			<td colspan="7">No Data found!</td>
                                        		</tr>
                                        	</c:if>
                                    		</tbody>
                                		</table>
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
           					<div class="modal fade" data-backdrop="static" id="cr_vendorcashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            VENDOR NAME: <span id="cr_vendorcashmodNameCont">00</span>  
                                            <span style="float: right;">INVOICE NO: <span id="cr_vendorcashmodInvoiceNoCont">00</span></span>
                                           	<input type="hidden" id="cr_vendorcashmodPoNoCont" value="0">
                                           	<input type="hidden" id="cr_vendorcashmodInvoiceDateCont" value=""> 
                                            </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;">TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_vendorcashtotamtcontId">0.00</span></div>
                                           		<!-- <div style="padding: 5px;">DISC. AMOUNT :&nbsp;&nbsp;&nbsp;<span id="cr_salecashdiscamtcontId">0.00</span></div> -->
                                           		<div style="padding: 5px;">PAID AMOUNT :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cr_vendorcashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;">AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="cr_vendorcashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;">TENDER AMOUNT :&nbsp;<input type="text" onkeyup="javascript:getcr_vendorChangeAmt(this.value)"  value="" id="cr_vendorcashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;">CHANGE AMOUNT :&nbsp;<span id="cr_vendorcashchangeamtcontId">0.00</span> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="cr_vendorpaycashalertMsg"></div>
                                            </div>
                                           
										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
                                           <button type="button" onclick="javascript:cr_vendorpayByCash(document.getElementById('cr_vendorcashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success">PAY</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="totcr_vendorcashModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            Vendor Bulk Payment By Cash
                                          </h4>
                                            
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style=";font-size: 20px;">
                                           		<div style="padding: 5px;">TOTAL AMOUNT :&nbsp;&nbsp;&nbsp;<span id="totcr_vendorcashtotamtcontId">0.00</span></div>
                                           		<div style="padding: 5px;">PAID AMOUNT :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="totcr_vendorcashpaidamtcontId">0.00</span> </div>
                                           		<div style="padding: 5px;">AMOUNT TO PAY :&nbsp;&nbsp;&nbsp;<span id="totcr_vendorcashamttopaycontId">0.00</span> </div>
                                           		<div style="padding: 3px;">TENDER AMOUNT :&nbsp;<input type="text" onkeyup="javascript:gettotcr_vendorChangeAmt(this.value)"  value="" id="totcr_vendorcashtenderAmt" style="text-align:center; color: #222222" size="4"/> </div>
                                           		<div style="padding: 5px;">CHANGE AMOUNT :&nbsp;<span id="totcr_vendorcashchangeamtcontId">0.00</span> </div>
                                            	<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="totcr_vendorpaycashalertMsg"></div>
                                            </div>
                                           
										</div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                           <button type="button" style="width:25%; background:#F60;font-weight: bold;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
                                           <button type="button" onclick="javascript:totcr_vendorpayByCash(document.getElementById('totcr_vendorcashtenderAmt').value)" style="width:25%; background: #72BB4F;font-weight: bold;" class="btn btn-success"><span id="totvendorcashpaySpinner" style="display: none;"><i class="fa fa-spinner fa-spin"></i></span>&nbsp;PAY</button>
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

   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   
    $('#creditvendortableContId tbody tr').on('click',function(e){
	  $(this).closest('table').find('td').removeClass('selected');
		$(this).find('td').addClass('selected');
		//e.stopPropagation();
	});
    function showcr_vendorCashModal()
	{
		//alert('order');
		$('#cr_vendorcashModal').modal('show');
	}
	function hidecr_vendorCashModal()
	{
		//alert('order');
		$('#cr_vendorcashModal').modal('hide');
	}
	
	//for total
	function showtotcr_vendorCashModal()
	{
		//alert('order');
		$('#totcr_vendorcashModal').modal('show');
	}
	function hidetotcr_vendorCashModal()
	{
		//alert('order');
		$('#totcr_vendorcashModal').modal('hide');
	}
	
   </script>
  
</body>
</html>
