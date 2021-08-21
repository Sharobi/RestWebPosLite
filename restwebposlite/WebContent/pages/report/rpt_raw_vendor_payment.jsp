<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.sharobi.webpos.util.CommonResource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>:. POS :: Periodic Vendor Payment Report :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    <link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
   
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
           <jsp:include page="/pages/report/rptleftpanel.jsp"></jsp:include>  
           
           <div class="col-md-10 col-sm-10">
				<div class="col-md-12 col-sm-12">
				<div class="col-md-3 col-sm-3">
				<span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_period_wise_vendor_payment.jsp.header" text="Vendor Payment Report" /></span>
				</div>
				<div class="col-md-9 col-sm-9">
                    <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_item_wise_order_period.jsp.frmDate" text="From Date:" /></span>
                    <input type="text" id="fromdaterptvendorpayment" size="7" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                    <span style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="admin.rpt_item_wise_order_period.jsp.toDate" text="To Date:" /></span>
                    <input type="text" id="todaterptvendorpayment" size="7" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                     <input type="hidden" id="hiddaterptvendorpayment" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                     <span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="stockinnew.jsp.Vendor" text="Vendor" /></span>&nbsp;&nbsp;
						<select id="selectedvendorId" name="vendorId">
						    <option value="0">All</option>
								<c:forEach items="${vendorList}" var="vendor">
									<option value="${vendor.id}">${vendor.name}</option>
								</c:forEach>
							</select>
                     
                      <span style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="admit_rpt_rpttype" text="Report Type" /></span>&nbsp;&nbsp;
						<select id="rptType">
                           <option value="1">PDF</option>
                           <option value="2">Excel</option>
                        </select>
                     <a href="javascript:showpdfrptperiodicVendorPayment(document.getElementById('fromdaterptvendorpayment').value,document.getElementById('todaterptvendorpayment').value,${sessionScope.loggedinUser.storeId},document.getElementById('rptType').value,document.getElementById('selectedvendorId').value)" class="btn btn-success" style="background:#41A1E3;margin-bottom: 3px;"><spring:message code="admin.rpt_item_wise_order_period.jsp.submit" text="SUBMIT" /></a> 
                    
                     
                </div> 
                </div>
                <div class="col-md-12 col-sm-12">
                  <div id="periodic_vendor_payment_report_ContainerId" >
                   
                  </div> 
               </div>
           </div>
       </div>
       <!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="alertrptperiodicvendorpaymentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.rpt_item_wise_order_period.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <spring:message code="admin.rpt_item_wise_order_period.jsp.cont_two" text="Given date is greater than today's date!" />
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_item_wise_order_period.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="alertrptperiodicvendorpaymentgreaterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.rpt_item_wise_order_period.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <spring:message code="admin.rpt_item_wise_order_period.jsp.cont_one" text="From Date is greater than To Date!" />
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.rpt_item_wise_order_period.jsp.ok" text="OK" /></button>
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
    <script src="${pageContext.request.contextPath}/assets/js/reportScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   var pdf_url_periodic_vendor_payment='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_RAW_VENDOR_PAYMENT_REPORT)%>';
  
   //var pdf_url_period_sale="http://54.187.126.219:8080/Restaurant/rest/order/reportsales";
   $(document).ready(function() {

		$('#fromdaterptvendorpayment').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true
		});

	});
   $(document).ready(function() {

		$('#todaterptvendorpayment').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true
		});

	});
   function showalertrptperiodicvendorpaymentModal()
	{
	  	$('#alertrptperiodicvendorpaymentModal').modal('show');
	}
   function showalertrptperiodicvendorpaymentgreaterModal()
	{
	  	$('#alertrptperiodicvendorpaymentgreaterModal').modal('show');
	}
   </script>
   </body>
</html>