<%@page import="com.sharobi.webpos.util.CommonResource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <title>:. POS ::Inventory Current Stock Report :.</title>
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
				<div class="col-md-12 col-sm-12" align="center">
                      <div class="col-md-3 col-sm-3">
	           				<span style="color:#FFF; font-size:16px; font-weight:bold;">Inventory Current Stock Report</span>
           			  </div>
                      
                    <div class="col-md-9 col-sm-9">
                    <span style="color:#FFF; font-size:16px; font-weight:bold;">Date:</span>
                     <input type="text" id="rptdate" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                    <span style="color: #FFF; font-size: 16px; font-weight: bold;">Item:</span>&nbsp;&nbsp; 
                    <input type="text" id="itmName" size="30" />
                    <input type="text" id="itemid" class="hide" value="0" />
                    
                    <span style="color: #FFF; font-size: 16px; font-weight: bold;">Report Type</span>&nbsp;&nbsp;				
			        <select id="rptType">
                           <option value="1">PDF</option>
                           <option value="2">Excel</option>
                     </select>
                                      
                    <a href="javascript:showpdfrptcurrentStock(${sessionScope.loggedinUser.storeId},document.getElementById('rptType').value,document.getElementById('rptdate').value,document.getElementById('itemid').value,document.getElementById('itmName').value)" class="btn btn-success" style="background:#E0B12F;margin-bottom: 3px;">
                     GET
                   </a>  
                   </div>
                </div>
                <div class="col-md-12 col-sm-12">
                  <div id="currentstockreportContainerId">
                  
                  </div> 
               </div>
           </div>
           <!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="alertrptinvcurrstockModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Given date is greater than today's date!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
           <!-- modal ends -->
       </div>
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
   var pdf_url_current_stock='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_INVENTORY_CURRENT_STOCK_REPORT)%>';
   //var pdf_url_day_sale="http://54.187.126.219:8080/Restaurant/rest/order/reportsales/day";
   $(document).ready(function() {

		$('#daterptinvcurrStock').datepicker({
			format : "dd-mm-yyyy",
			autoclose : true
		});
		$('#rptdate').datepicker({
			format : "yyyy-mm-dd",
			maxDate: new Date(),
			autoclose : true
			
		});
	});
   function showalertrptinvcurrstockModal()
	{
	  	$('#alertrptinvcurrstockModal').modal('show');
	}
   $(function() {
		$("#itmName") .autocomplete({
		    source : function(request, response) {
		          $.ajax({
		                      url : BASE_URL+"/inventorynew/inventoryitems.htm",
		                      type : "GET",
		                      data : {
		                          tagName : request.term
		                      },

		                      dataType : "json",

		                      success : function(data) {
		                          response($
		                                  .map( data,function(v) {
		                                       	     return {
		                                               	      label : v.name,
		                                                      itemCode : v.id,
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
		    	  console.log(ui);
		    	   $('#itemid').val(ui.item.items.id);
		       },
		      close: function(el) {
		          /*el.target.value = '';*/
		      }
		   });
		});
   </script>
   </body>
</html>