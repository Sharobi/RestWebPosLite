<%@page import="com.sharobi.webpos.util.CommonResource"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <title>:. POS :: View Daily Expenditure :.</title>
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
            <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include> 
           
           <div class="col-md-10 col-sm-10">
				<div class="col-md-12 col-sm-12" align="center">
                    <span style="color:#FFF; font-size:16px; font-weight:bold;">Select Voucher Date For Periodwise Expenditure</span>&nbsp;&nbsp;
                    
                    <c:if test="${!empty fromdate}">
                        <span style="color:#FFF; font-size:16px; font-weight:bold;">From Date :</span>
                       <input type="text" id="fromdateExpList" size="10" value="${fromdate}" />" 
                       <c:set var="fromSpecificDate" value="${fromdate}" />
                      </c:if>
                  
                      <c:if test="${!empty todate}">
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">To Date :</span>
                       <input type="text" id="todateExpList" size="10" value="${todate}" />" 
                       <c:set var="toSpecificDate" value="${todate}" />
                      </c:if>
                      <c:if test="${empty fromdate}"> 
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">From Date :</span> 
                       <input type="text" id="fromdateExpList" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">  
                       <c:set var="fromSpecificDate" value="${today}" />
                       <span style="color:#FFF; font-size:16px; font-weight:bold;">To Date :</span>
                       <input type="text" id="todateExpList" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}"/>">  
                       <c:set var="toSpecificDate" value="${today}" />
                      </c:if>
                    			<input type="hidden" id="hiddenExpList" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">
                    
                    
                    
                    
            
                   <a href="javascript:showdailyExp(document.getElementById('fromdateExpList').value,document.getElementById('todateExpList').value,${sessionScope.loggedinUser.storeId})" class="btn btn-success" style="background:#FF8576;;margin-bottom: 3px; padding: 2px 12px;">VIEW</a> 
                </div>
                <div class="col-md-12 col-sm-12" style="max-height: 450px;overflow-y:auto;">
                  <div id="dailyexpContainerId">
                  
                  </div> 
               </div>
           </div>
           <!-- modal starts -->
            				<div class="modal fade" data-backdrop="static" id="alertexpdayModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
                        <div class="modal fade" data-backdrop="static" id="alertexpModalBiggerFromDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            Given From Date is Greater than To Date!
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button"   onclick="javascript:showCurrentDateExp(${sessionScope.loggedinUser.storeId})"  style="background: #72BB4F;font-weight: bold;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            
                             <div class="modal fade" data-backdrop="static" id="confirmdeleteDailyExpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Confirmation!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	Are you sure?
                                            	<input type="hidden" id="moddeleteconfirmdailyexpId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal">CANCEL</button>
                                            <button type="button" onclick="javacsript:deleteDailyExpenditure()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>   
                            <div class="modal fade" data-backdrop="static" id="alertdailyexpdataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">Alert!</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="dailyexpdataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/expendituremgmt/viewdailyexpenditure.htm'" data-dismiss="modal" class="btn btn-success">OK</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" data-backdrop="static" id="dailyExpenditureEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.showdailyexpenditure.jsp.edid.header" text="Edit Daily Expenditure" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="editdailyexpid" value="">
                                            	<table>
                                            	    <tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.exptype" text="EXPENDITURE TYPE" /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;" id="exptypetd">
                                            			 <select id="editexpensetype"  style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onchange="setVendorNameAccess();">
	                                                             <option value="0">Select One</option>
	                                                         <c:forEach items="${expenditureTypes}" var="exptype">
	                                                                <option value="${exptype.id}">${exptype.typeName}</option>
	                                                         </c:forEach>
                                                       </select>
                                            			</td>
                                            		</tr>
                                            	     <tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.vno" text="VOUCHER NO." /></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdailyexpvoucherno" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.date" text="DATE" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexpdate" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.vendor" text="VENDOR" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexpvendor" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.perticular" text="PARTICULARS" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexpparticulars" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.amt" text="BILL AMOUNT" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexpamount" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onkeyup="changeCalculationOnAmount(this.value)"/></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.tax" text="TAX(%)" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexptaxrate" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" onkeyup="changeCalculationOnTaxRate(this.value)"/></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.taxamt" text="TAX AMOUNT" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexptaxamt" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" readonly/></td>
                                            		</tr>
													<tr>
                                            			<td><spring:message code="admin.showdailyexpenditure.jsp.edit.netamt" text="NET AMOUNT" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdailyexpnetamt" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" readonly/></td>
                                            		</tr>
                                            		
                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editdailyexpalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelInventoryType()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.invtypemgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editDailyExpenditure()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.invtypemgnt.jsp.edit" text="EDIT" /></button>
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
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/adminScript.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
  
  /*  $(document).ready(function() {

		$('#datedailyExp').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true
		});

	});
    */
    
    
    $(document).ready(function() {

		$('#fromdateExpList').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate : '0'
		});	
		$('#todateExpList').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate : '0'
		});	
		$('#editdailyexpdate').datepicker({ // new added 19th April 2018
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate: '0'
		});
	});
    
    
    
    
    
   function showExpGreaterAlertModal() {
		$('#alertexpdayModal').modal('show');
	}
   function showalertexpModalBiggerFromDate()
	{
	  	$('#alertexpModalBiggerFromDate').modal('show');
	}
  function showalertdailyexpdataopModal(){
	   $('#alertdailyexpdataopModal').modal('show');
  }
  
  function setVendorNameAccess(){
	   var selectedexptypeid = document.getElementById('editexpensetype').value;
	   if(selectedexptypeid == 1){
		   document.getElementById('editdailyexpvendor').readOnly = false;
		}
	   else{
		   document.getElementById('editdailyexpvendor').value='';
		   document.getElementById('editdailyexpvendor').readOnly = true;
	   }
		   
  }
  
  
   </script>
   </body>
</html>