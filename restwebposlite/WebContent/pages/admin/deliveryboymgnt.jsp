<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>
     <c:choose>
	    	<c:when test="${sessionScope.loggedinStore.id==168}">
	    	   :. POS :: Doctor Management :.     			
	       </c:when>    
	       <c:otherwise>
	       :. POS :: Delivery Boy Management :.  
	      </c:otherwise>
     </c:choose>
     </title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   
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
                <div class="col-md-10 col-sm-10">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">
                    <%-- <spring:message code="admin.deliveryboymgnt.jsp.deliveryboy" text="DELIVERY BOYS" /> --%>
                    <c:choose>
					    <c:when test="${sessionScope.loggedinStore.id==168}">
					      DOCTORS
					     </c:when>    
					    <c:otherwise>
					       DELIVERY BOYS
					    </c:otherwise>
					</c:choose>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showdeliveryboyaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.vendormgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.deliveryboymgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.deliveryboymgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.deliveryboymgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.deliveryboymgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.deliveryboymgnt.jsp.details" text="DETAILS" /></th>
                                        
                                    </thead>
                                    <tbody>
                                    	<c:if test="${! empty deliveryBoyList }">
                                    		<c:forEach items="${deliveryBoyList}" var="deliveryboy">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${deliveryboy.id}</td>
                                    				<td>${deliveryboy.name}</td>
                                    				<td align="center"><a href="javascript:showdeliveryboyeditModal(${deliveryboy.id},&quot;${deliveryboy.name}&quot;,&quot;${deliveryboy.phone_no}&quot;,&quot;${deliveryboy.email}&quot;,&quot;${deliveryboy.address}&quot;,&quot;${deliveryboy.uniqueId}&quot;,&quot;${deliveryboy.DOB}&quot;,&quot;${deliveryboy.DOJ}&quot;,)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteDeliveryBoyModal(${deliveryboy.id})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailDeliveryBoyModal(${deliveryboy.id},&quot;${deliveryboy.name}&quot;,&quot;${deliveryboy.phone_no}&quot;,&quot;${deliveryboy.email}&quot;,&quot;${deliveryboy.address}&quot;,&quot;${deliveryboy.uniqueId}&quot;,&quot;${deliveryboy.DOB}&quot;,&quot;${deliveryboy.DOJ}&quot;,)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty deliveryBoyList}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="6"><spring:message code="admin.vendormgnt.jsp.noDataFound" text="No Data found!" /></td>
                                        	</tr>
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
           <!-- modal starts -->
           					<div class="modal fade" data-backdrop="static" id="deliveryBoyAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <%-- <spring:message code="admin.deliveryboymgnt.jsp.addDeliveryBoy" text="Add Delivery Boy" /> --%>
                                            <c:choose>
											    <c:when test="${sessionScope.loggedinStore.id==168}">
											      Add Doctor 
											     </c:when>    
											    <c:otherwise>
											       Add Delivery Boy
											    </c:otherwise>
											</c:choose>
                                            </h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.deliveryboyName" text="NAME" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="adddelboyname" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" onkeypress='return lettersOnly(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyPhone" text="PHONE NUMBER" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="adddelboyphone" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" maxlength="10"
														onkeypress='return isNumberKey(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyEmail" text="EMAIL" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="adddelboyemail" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyAddress" text="ADDRESS" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="adddelboyaddress" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyUniqueID" text="VERIFIED IDENTITY ID" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="adddelboyuniqueid" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            			<tr>
													<td><spring:message code="admin.deliveryboymgnt..jsp.delboyDOB"
															text="DATE OF BIRTH" /></td>
													</td>
													<td>:</td>

													<td><input type="text" id="adddelboydob" size="10"
														style="text-align:left; margin-bottom: 5px; color: #222222; width: 95%;"></td>							
												</tr>

												<tr>
													<td><spring:message code="admin.deliveryboymgnt.jsp.delboyDOJ"
															text="DATE OF JOINING" /></td>
													<td>:</td>
													<td><input type="text" id="adddelboydoj"
														size="10"
														style="text-align:left; margin-bottom: 2px; color: #222222; width: 95%;"></td>
												</tr>                                            		
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="adddelboyalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelDeliveryBoy()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:addDeliveryBoy()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.create" text="CREATE" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="deliveryBoyEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                            <%-- <spring:message code="admin.deliveryboymgnt.jsp.editDeliveryBoy" text="Edit Delivery Boy" /> --%>
                                            <c:choose>
											    <c:when test="${sessionScope.loggedinStore.id==168}">
											      Edit Doctor 
											     </c:when>    
											    <c:otherwise>
											       Edit Delivery Boy
											    </c:otherwise>
											</c:choose>
                                            </h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                        	<input type="hidden" id="editdelboyidContId" value="">
                                            	<table>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.deliveryboyName" text="NAME" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td style="margin-bottom: 3px;"><input type="text" id="editdelboyname" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" onkeypress='return lettersOnly(event)' /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyPhone" text="PHONE NUMBER" /><span style="color: #ff0000;">*</span></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdelboyphone" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" maxlength="10"
														onkeypress='return isNumberKey(event)'/></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyEmail" text="EMAIL" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdelboyemail" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyAddress" text="ADDRESS" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdelboyaddress" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr>
                                            		<tr>
                                            			<td><spring:message code="admin.deliveryboymgnt.jsp.delboyUniqueID" text="VERIFIED IDENTITY ID" /></td>
                                            			<td>:</td>
                                            			<td><input type="text" id="editdelboyuniqueid" style="text-align:left; width:95%; color: #222222;margin-bottom: 5px;" /></td>
                                            		</tr> 	
                                            		</tr>
                                            			<tr>
													<td><spring:message code="admin.deliveryboymgnt..jsp.delboyDOB"
															text="DATE OF BIRTH" /></td>
													</td>
													<td>:</td>

													<td><input type="text" id="editdelboydob" size="10"
														style="text-align:left; margin-bottom: 5px; color: #222222; width: 95%;"></td>							
												</tr>

												<tr>
													<td><spring:message code="admin.deliveryboymgnt.jsp.delboyDOJ"
															text="DATE OF JOINING" /></td>
													<td>:</td>
													<td><input type="text" id="editdelboydoj"
														size="10"
														style="text-align:left; margin-bottom: 2px; color: #222222; width: 95%;"></td>
												</tr>              	
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="editdelboyalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javascript:cancelDeliveryBoy()" style="background:#F60;font-weight: bold;width: 25%" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javascript:editDeliveryBoy()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.edit" text="EDIT" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="confirmdeleteDeliveryBoyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.confirmation" text="Confirmation!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            	<spring:message code="admin.vendormgnt.jsp.areYouSure" text="Are you sure?" />
                                            	<input type="hidden" id="moddeleteconfirmdelboyidContId" value="">
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background:#F60;font-weight: bold;width: 25%;" class="btn btn-warning" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button" onclick="javacsript:deleteDeliveryBoy()" style="background: #72BB4F;font-weight: bold;width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="modal fade" data-backdrop="static" id="deliveryBoyDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel">
                                           <%--  <spring:message code="admin.deliveryboymgnt.jsp.deliveryBoyDetails" text="Delivery Boy Details" /> --%>
                                           <c:choose>
											    <c:when test="${sessionScope.loggedinStore.id==168}">
											       Doctor Details 
											     </c:when>    
											    <c:otherwise>
											        Delivery Boy Details
											    </c:otherwise>
											</c:choose>
                                            </h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div align="center" style="font-size: 20px;">
                                            	<table>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.vendormgnt.jsp.id" text="ID" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboyidTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.deliveryboyName" text="NAME"/></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboynameTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.delboyPhone" text="PHONE NUMBER" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboyphoneTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.delboyEmail" text="EMAIL" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboyemailTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.delboyAddress" text="ADDRESS" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboyaddressTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.delboyUniqueID" text="VERIFIED IDENTITY ID"  /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboyuniqueidTd"></td>
                                            		</tr> 
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt..jsp.delboyDOB"
															text="DATE OF BIRTH" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboydobTd"></td>
                                            		</tr>
                                            		<tr>
                                            			<td style="padding: 5px 0px;"><spring:message code="admin.deliveryboymgnt.jsp.delboyDOJ"
															text="DATE OF JOINING" /></td>
                                            			<td width="5%">:</td>
                                            			<td id="moddetaildelboydojTd"></td>
                                            		</tr>                                   
                                    			</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" onclick="javacsript:closedeliveryboydetailModal()" style="background: #72BB4F;font-weight: bold;width: 25%"  class="btn btn-success" data-dismiss="modal"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                             <div class="modal fade" data-backdrop="static" id="alertdeliveryboydataopModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.vendormgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="deliveryboydataopmassagecont"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/deliveryboy/viewdeliveryboy.htm'"  class="btn btn-success"><spring:message code="admin.vendormgnt.jsp.ok" text="OK" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   var language = '<%= session.getAttribute("language") %>';
   var storeID="${sessionScope.loggedinStore.id}";
   var user="${sessionScope.loggedinUser.name}";

   function showdeliveryboyaddModal()
	{
		$('#deliveryBoyAddModal').modal('show');
		$('#deliveryBoyAddModal').on('shown.bs.modal', function () {
		$('#adddelboyname').focus();});
	}
    function closedeliveryboyaddModal()
	{
		$('#deliveryBoyAddModal').modal('hide');
	} 
   function showdeliveryboyeditModal(id,name,phone_no,email,address,uniqueId,dob,doj)
	{
	   	document.getElementById('editdelboyidContId').value=id;
	   	document.getElementById('editdelboyname').value=name;
	   	document.getElementById('editdelboyphone').value=phone_no;
	   	document.getElementById('editdelboyemail').value=email;
	   	document.getElementById('editdelboyaddress').value=address;
	   	document.getElementById('editdelboyuniqueid').value=uniqueId;

	   	if(dob!='' && typeof dob !== "undefined")
	     {        
	        document.getElementById('editdelboydob').value=formatDate(dob);
	     }
	     if(doj!='' && typeof doj !== "undefined")
	     { 
	      document.getElementById('editdelboydoj').value=formatDate(doj);
	     }
	   	 
		$('#deliveryBoyEditModal').modal('show');
	}
   function closedeliveryboyeditModal()
	{
		$('#deliveryBoyEditModal').modal('hide');
	}
   function closedeliveryboydeleteModal()
	{
		$('#confirmdeleteDeliveryBoyModal').modal('hide');
	}
   function showConfirmdeleteDeliveryBoyModal(id)
   {
	   document.getElementById('moddeleteconfirmdelboyidContId').value=id;
	   $('#confirmdeleteDeliveryBoyModal').modal('show');
   }
   function showDetailDeliveryBoyModal(id,name,phone_no,email,address,uniqueId,dob,doj)
   {
	   document.getElementById('moddetaildelboyidTd').innerHTML=id;
	   document.getElementById('moddetaildelboynameTd').innerHTML=name;
	   document.getElementById('moddetaildelboyphoneTd').innerHTML=phone_no;
	   document.getElementById('moddetaildelboyemailTd').innerHTML=email;
	   document.getElementById('moddetaildelboyaddressTd').innerHTML=address;
	   document.getElementById('moddetaildelboyuniqueidTd').innerHTML=uniqueId;
	
	   if(dob!='' && typeof dob !== "undefined")
	    {        
	     document.getElementById('moddetaildelboydobTd').innerHTML=formatDate(dob);
	    }
	    if(doj!='' && typeof doj !== "undefined")
	    { 
	     document.getElementById('moddetaildelboydojTd').innerHTML=formatDate(doj); 
	    }
	   $('#deliveryBoyDetailModal').modal('show');
   }
   
   function showalertdeliveryboydataopModal()
	{
		$('#alertdeliveryboydataopModal').modal('show');
	}
   
   
   function closedeliveryboydetailModal()
   {
      document.getElementById('moddetaildelboyidTd').innerHTML="";
      document.getElementById('moddetaildelboynameTd').innerHTML="";
      document.getElementById('moddetaildelboyphoneTd').innerHTML="";
      document.getElementById('moddetaildelboyemailTd').innerHTML="";
      document.getElementById('moddetaildelboyaddressTd').innerHTML="";
      document.getElementById('moddetaildelboyuniqueidTd').innerHTML="";
      document.getElementById('moddetaildelboydobTd').innerHTML="";
      document.getElementById('moddetaildelboydojTd').innerHTML=""; 
   }
   
   $(document).ready(function() {

		$('#editdelboydob').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate: '0'
			
		});	
		$('#editdelboydoj').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate: '0'
		});	
		
		$('#adddelboydob').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate: '0'
			
		});	
		$('#adddelboydoj').datepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			endDate: '0'
		});	
		
   });
   
   function isNumberKey(evt){
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    
	    if (charCode > 31 && (charCode < 48 || charCode > 57))
	        return false;
	    return true;
	}
	
	function lettersOnly(evt) {
	       evt = (evt) ? evt : event;
	       var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
	          ((evt.which) ? evt.which : 0));
	      
	       if (charCode > 31 && charCode != 32 && (charCode < 65 || charCode > 90) &&
	          (charCode < 97 || charCode > 122)) {
	
	          return false;
	       }
	       return true;
	     }
   </script>  
</body>
</html>